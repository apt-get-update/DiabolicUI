-- Run from the addon root: lua5.1 tests/test_wotlk_globals.lua
--
-- Fails if addon code reads an ALL-CAPS Blizzard global (a UI string such as
-- TAXI_CANCEL, or a constant) that the WotLK 3.3.5a client doesn't have.
-- Those come from code written for later expansions: on 3.3.5 the value is
-- nil, which either errors (GameTooltip:SetText(nil)) or silently turns a
-- feature off. Use a DiabolicUI locale string instead (see conventions).
--
-- tests/data/wotlk-globals.txt lists every ALL-CAPS global the 3.3.5 client's
-- own UI defines. Reads are found in the bytecode listing (GETGLOBAL) plus
-- explicit `_G.NAME` reads in the source. Names the addon defines itself
-- are fine, and so is anything on the ALLOWED list below.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

local LUAC = os.getenv("LUAC") or "luac5.1"
local KNOWN_FILE = "tests/data/wotlk-globals.txt"

-- Reads that are fine even though 3.3.5 doesn't define them, and why.
local ALLOWED = {
	DEVELOPER_RESET = "developer-only flag in engine-core.lua, nil on purpose",
	MBB_M = "defined by the optional MBB addon; the minimap checks for it",
	MBB_TOOLTIP1 = "defined by the optional MBB addon; the minimap checks for it",
}

local readFile = function(path)
	local file = assert(io.open(path, "rb"))
	local text = file:read("*a")
	file:close()
	return text
end

local loadKnownGlobals = function()
	local known = {}
	for line in io.lines(KNOWN_FILE) do
		if line:match("^[A-Z]") then
			known[line] = true
		end
	end
	return known
end

local listSourceFiles = function()
	local files = {}
	local pipe = io.popen("find engine handlers modules settings defaults data locale -name '*.lua' -not -path '*/Libs/*' | sort")
	for path in pipe:lines() do
		files[#files + 1] = path
	end
	pipe:close()
	return files
end

-- Returns the ALL-CAPS globals a file reads ({ name = "file:line" }) and
-- the ones it writes ({ name = true }).
local scanFile = function(path)
	local source = readFile(path):gsub("^\239\187\191", "") -- UTF-8 BOM
	local reads, writes = {}, {}

	local tmp = os.tmpname()
	local file = assert(io.open(tmp, "wb"))
	file:write(source)
	file:close()
	local pipe = io.popen(LUAC .. " -p -l '" .. tmp .. "' 2>&1")
	for line in pipe:lines() do
		local lineNumber, op, name = line:match("%[(%d+)%]%s+([GS]ETGLOBAL)%s.-;%s*([A-Z][A-Z0-9_]+)%s*$")
		if name then
			if op == "GETGLOBAL" then
				reads[name] = reads[name] or (path .. ":" .. lineNumber)
			else
				writes[name] = true
			end
		end
	end
	pipe:close()
	os.remove(tmp)

	local lineNumber = 1
	for line in (source .. "\n"):gmatch("(.-)\r?\n") do
		for name, rest in line:gmatch("_G%.([A-Z][A-Z0-9_]*)(.?.?)") do
			if not rest:match("^[%w_]") then
				if rest:match("^%s*=") and not rest:match("^%s*==") then
					writes[name] = true
				else
					reads[name] = reads[name] or (path .. ":" .. lineNumber)
				end
			end
		end
		lineNumber = lineNumber + 1
	end
	return reads, writes
end

TestWotlkGlobals = {}

function TestWotlkGlobals:test_known_list_is_loaded()
	local known = loadKnownGlobals()
	lu.assertTrue(known.LEAVE_VEHICLE)
	lu.assertNil(known.TAXI_CANCEL) -- Cataclysm
end

function TestWotlkGlobals:test_only_reads_globals_that_exist_in_wotlk()
	local known = loadKnownGlobals()
	local reads, defined = {}, {}
	for _, path in ipairs(listSourceFiles()) do
		local fileReads, fileWrites = scanFile(path)
		for name, where in pairs(fileReads) do
			reads[name] = reads[name] or where
		end
		for name in pairs(fileWrites) do
			defined[name] = true
		end
	end
	local missing = {}
	for name, where in pairs(reads) do
		if not (known[name] or defined[name] or ALLOWED[name]) then
			missing[#missing + 1] = where .. "  " .. name
		end
	end
	table.sort(missing)
	if #missing > 0 then
		lu.fail("Globals that don't exist in WotLK 3.3.5 (use a locale string, or add to ALLOWED with a reason):\n  " .. table.concat(missing, "\n  "))
	end
end

function TestWotlkGlobals:test_detector_catches_a_missing_global()
	local tmp = os.tmpname()
	local file = io.open(tmp, "w")
	file:write('local x = TAXI_CANCEL\nlocal y = _G.PANDAREN_THING\n_G.OWN_VALUE = 1\nlocal z = _G.UIParent\n')
	file:close()
	local reads, writes = scanFile(tmp)
	os.remove(tmp)
	lu.assertEquals(reads.TAXI_CANCEL, tmp .. ":1")
	lu.assertEquals(reads.PANDAREN_THING, tmp .. ":2")
	lu.assertTrue(writes.OWN_VALUE)
	lu.assertNil(reads.UIP) -- a CamelCase name isn't an ALL-CAPS global
end

os.exit(lu.LuaUnit.run())
