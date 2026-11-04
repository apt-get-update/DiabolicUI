-- Writes settings/positions.lua: every named part /dui layout saw (each
-- window's, in DiabolicUI_Layout), where it was, each line commented out;
-- the lines already without "--" kept, and what /dui adjust moved in game
-- added without "--". Run from the addon's folder, the game's saved
-- variables written (a /reload or a logout):
--   lua5.1 tools/positions.lua [path/to/WTF/Account/<you>/SavedVariables/DiabolicUI.lua [out]]
local OUT = arg[2] or "settings/positions.lua"

local Newest = function()
	local pipe = io.popen("ls -t ../../../WTF/Account/*/SavedVariables/DiabolicUI.lua 2>/dev/null")
	local path = pipe:read("*l")
	pipe:close()
	return path
end

local saved = arg[1] or Newest()
assert(saved, "No DiabolicUI.lua in ../../../WTF/Account/*/SavedVariables: give its path.")
local env = {}
setfenv(assert(loadfile(saved)), env)()
local layout = env.DiabolicUI_Layout or {}

-- the lines in use: the file's, then what was moved in game
local active = {}
local chunk = loadfile(OUT)
if chunk then
	chunk("DiabolicUI", { NewStaticConfig = function(_, _, positions) active = positions end })
end
for name, entry in pairs(layout.moved or {}) do
	active[name] = entry
end

local Number = function(value)
	value = math.floor(value * 10 + .5) / 10
	return (value == math.floor(value)) and string.format("%d", value) or string.format("%.1f", value)
end

local Line = function(name, entry, info)
	local key = name:match("^[%a_][%w_]*$") and name or string.format("[%q]", name)
	local values = { string.format("%q", entry[1]), string.format("%q", entry[2]), string.format("%q", entry[3]),
		Number(entry[4]), Number(entry[5]) }
	if entry[6] then
		values[6], values[7] = Number(entry[6]), Number(entry[7])
	end
	local line = string.format("%s = { %s },", key, table.concat(values, ", "))
	if info and info.kind then
		line = line .. " -- " .. info.kind .. (info.text and (" " .. string.format("%q", info.text)) or "")
	end
	return line
end

local Sorted = function(list)
	local names = {}
	for name in pairs(list) do
		names[#names + 1] = name
	end
	table.sort(names)
	return names
end

local out = { [[
-- Every named part of the windows /dui layout saw (Blizzard's, and the
-- addons' styled), where it was: { point, the frame it's placed on, that
-- frame's point, x, y, width, height } (x right, y up; a text keeps its own
-- size). To move one: remove its "--", change its numbers, /reload. Without
-- a width and height it keeps its size. A line without "--" keeps its part
-- there for good, whatever else moves it (modules/blizzard/adjust.lua).
-- Written by tools/positions.lua (docs: Common Tasks): it keeps the lines
-- without "--" and adds what /dui adjust moved in game.
local _, Engine = ...

Engine:NewStaticConfig("Positions", {]] }
local listed = {}
local windows = layout.windows or {}
for _, window in ipairs(Sorted(windows)) do
	local parts = windows[window].parts or {}
	local names = {}
	for _, name in ipairs(Sorted(parts)) do
		if (not listed[name]) and (type(parts[name]) == "table") then
			names[#names + 1] = name
		end
	end
	if (#names > 0) then
		out[#out + 1] = "\n\t-- " .. window .. " " .. string.rep("-", math.max(4, 70 - #window))
		for _, name in ipairs(names) do
			listed[name] = true
			local entry = active[name]
			out[#out + 1] = "\t" .. (entry and "" or "-- ") .. Line(name, entry or parts[name], parts[name])
		end
	end
end
local others = {}
for _, name in ipairs(Sorted(active)) do
	if not listed[name] then
		others[#others + 1] = "\t" .. Line(name, active[name])
	end
end
if (#others > 0) then
	out[#out + 1] = "\n\t-- Not seen by /dui layout " .. string.rep("-", 46)
	for _, line in ipairs(others) do
		out[#out + 1] = line
	end
end
out[#out + 1] = "})\n"

local file = assert(io.open(OUT, "w"))
file:write(table.concat(out, "\n"))
file:close()
local count = 0
for _ in pairs(listed) do count = count + 1 end
print(string.format("%s: %d parts, %d in use.", OUT, count, #Sorted(active)))
