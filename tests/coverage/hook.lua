-- Line-coverage recorder, loaded in front of a test file by
-- tests/coverage/run.sh:
--
--   lua5.1 -e "dofile('tests/coverage/hook.lua')" tests/test_foo.lua
--
-- Installs a debug line hook that remembers every (file, line) pair the
-- addon executes, and appends them to tests/coverage/stats.out when the test
-- file exits. Test files end with os.exit(lu.LuaUnit.run()), which skips any
-- normal "end of script" code, so os.exit itself is wrapped to flush first.
--
-- Only addon source files are recorded: tests, the vendored test framework
-- and third party libraries are left out. Plain Lua 5.1, no luacov needed.

local STATS_FILE = os.getenv("DIABOLICUI_COVERAGE_STATS") or "tests/coverage/stats.out"

local hits = {}

-- chunk source ("@modules/chat/windows.lua") -> repo-relative path, or false
-- when the file isn't addon code. Cached, since the hook runs on every line.
local tracked = {}

local function trackedPath(source)
	local path = tracked[source]
	if path == nil then
		path = false
		if source:sub(1, 1) == "@" then
			local p = source:sub(2):gsub("\\", "/"):gsub("^%./", "")
			if p:match("%.lua$")
				and not p:match("^tests/")
				and not p:match("^docs/")
				and not p:match("/Libs/") then
				path = p
			end
		end
		tracked[source] = path
	end
	return path
end

local getinfo = debug.getinfo

-- function -> its tracked path (or false)
local pathOf = setmetatable({}, { __mode = "k" })

-- The tracked path of every function on the call stack, kept up to date by
-- the call and return events, so a line event only has to look at the top
-- (asking debug.getinfo on every line made the session tests ~30x slower).
local stack, depth = {}, 0

debug.sethook(function(event, line)
	if event == "line" then
		local path = stack[depth]
		if path then
			local lines = hits[path]
			if not lines then
				lines = {}
				hits[path] = lines
			end
			lines[line] = true
		end
	elseif event == "call" then
		local fn = getinfo(2, "f").func
		local path = pathOf[fn]
		if path == nil then
			path = trackedPath(getinfo(2, "S").source)
			pathOf[fn] = path
		end
		depth = depth + 1
		stack[depth] = path
	elseif depth > 0 then -- "return", or "tail return" for a frame a tail call replaced
		depth = depth - 1
	end
end, "crl")

-- An error unwinds the stack without return events: pcall and xpcall put
-- the depth back to where it was when they were called.
local pack = function(...)
	return { n = select("#", ...), ... }
end
for _, name in ipairs({ "pcall", "xpcall" }) do
	local protected = _G[name]
	_G[name] = function(...)
		local saved = depth
		local results = pack(protected(...))
		depth = saved
		return unpack(results, 1, results.n)
	end
end

local function flush()
	debug.sethook()
	local out = assert(io.open(STATS_FILE, "a"))
	for path, lines in pairs(hits) do
		local list = {}
		for line in pairs(lines) do
			list[#list + 1] = line
		end
		table.sort(list)
		out:write(path, "\t", table.concat(list, ","), "\n")
	end
	out:close()
	hits = {}
end

local exit = os.exit
os.exit = function(...)
	flush()
	return exit(...)
end
