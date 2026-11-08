-- luacheck's settings (`luacheck .`): WoW 3.3.5a's Lua 5.1 and its globals, the
-- lists in tests/data/.
std = "lua51+wow"

local names = {}
for _, path in ipairs({ "tests/data/wotlk-globals.txt", "tests/data/wow-names.txt" }) do
	for line in io.lines(path) do
		local name = line:match("^([%a_][%w_]*)")
		if name then
			names[#names + 1] = name
		end
	end
end
stds.wow = {
	globals = names, -- (the addon sets some on purpose: test_no_global_leaks.lua polices those)
	read_globals = { string = { fields = { "join", "split", "trim" } }, table = { fields = { "wipe" } } },
}

exclude_files = {
	"modules/minimap/Libs/**", -- (Ace3)
	"tests/luaunit.lua",
	"settings/positions.lua", -- (written by tools/positions.lua)
	"settings/components.lua", -- (and this one)
	"docs/**",
	"graft/**",
	".kiss/**",
}

ignore = {
	"212", -- unused arguments (a callback's `self`, `event`...)
	"4", -- shadowing (a closure's own `self`...)
	"61", -- whitespace (StyLua's)
	"631", -- long lines
}

files["tests/**"] = { ignore = { "1" } } -- (the fake client and LuaUnit's test tables are globals)
