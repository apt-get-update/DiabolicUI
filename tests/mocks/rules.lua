-- The windows' rules (tools/rules.js, the editor's) on what /dui layout saved
-- in the fake client: the scan written out, tools/positions.lua run on it, the
-- rules run with node (tests/rules_run.js). No node: Rules.available is false.
local Rules = {}

local pipe = io.popen("command -v node 2>/dev/null")
Rules.available = (pipe:read("*l") ~= nil)
pipe:close()

local Dump
Dump = function(value, out)
	local kind = type(value)
	if (kind == "table") then
		out[#out + 1] = "{"
		for key, item in pairs(value) do
			out[#out + 1] = "["
			Dump(key, out)
			out[#out + 1] = "]="
			Dump(item, out)
			out[#out + 1] = ","
		end
		out[#out + 1] = "}"
	elseif (kind == "string") then
		out[#out + 1] = string.format("%q", value)
	else
		out[#out + 1] = tostring(value)
	end
end

-- `window`'s problems, as a set.
Rules.Problems = function(window)
	local dir = (os.getenv("TMPDIR") or "/tmp") .. "/diabolicui_rules_" .. os.time() .. "_" .. math.random(1e9)
	os.execute("mkdir -p '" .. dir .. "/windows'")
	local out = { "DiabolicUI_Layout=" }
	Dump(_G.DiabolicUI_Layout, out)
	local file = assert(io.open(dir .. "/saved.lua", "w"))
	file:write(table.concat(out))
	file:close()
	os.execute(string.format("%s tools/positions.lua '%s/saved.lua' '%s/positions.lua' '%s/layout.json' '%s/windows' >/dev/null",
		os.getenv("LUA") or "lua5.1", dir, dir, dir, dir))
	local run = io.popen(string.format("node tests/rules_run.js '%s/layout.json' '%s' 2>&1", dir, window))
	local set = {}
	for line in run:lines() do
		set[line] = true
	end
	run:close()
	os.execute("rm -rf '" .. dir .. "'")
	return set
end

return Rules
