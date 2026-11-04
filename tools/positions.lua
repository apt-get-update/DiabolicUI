-- Writes settings/positions.lua: every named part /dui layout saw (each
-- window's, in DiabolicUI_Layout), where it was, each line commented out;
-- the lines already without "--" kept (with the notes over them and at
-- their ends, in their window), and what /dui adjust moved in game added
-- without "--". Run from the addon's folder, the game's saved
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

-- what's written by hand around the lines in use: the notes over each (its
-- own comment lines), the one at its end, the window it's under
local notes, tails, sections = {}, {}, {}
local file = io.open(OUT)
if file then
	local section, pending = nil, {}
	for line in file:lines() do
		local key, tail = line:match("^%s*([^%s%-][^=]-) = %b{},?%s*(.*)$")
		local window = line:match("^%s*%-%- (.-) %-%-%-%-+%s*$")
		if key then
			local name = key:match('^%["(.*)"%]$') or key
			notes[name] = (#pending > 0) and pending or nil
			tails[name] = (tail ~= "") and tail or nil
			sections[name] = section
			pending = {}
		elseif window then
			section, pending = window, {}
		elseif line:match("^%s*%-%-") and (not line:match("^%s*%-%-%s*%S+ = {")) then
			pending[#pending + 1] = line:match("^%s*(.-)%s*$")
		else
			pending = {}
		end
	end
	file:close()
end

local Number = function(value)
	value = math.floor(value * 10 + .5) / 10
	return (value == math.floor(value)) and string.format("%d", value) or string.format("%.1f", value)
end

local Line = function(name, entry, info)
	local key = name:match("^[%a_][%w_]*$") and name or string.format("[%q]", name)
	local values
	if (type(entry[1]) == "number") then
		values = { Number(entry[1]), Number(entry[2]) } -- (a size only)
	else
		values = { string.format("%q", entry[1]), string.format("%q", entry[2]), string.format("%q", entry[3]),
			Number(entry[4]), Number(entry[5]) }
		if entry[6] then
			values[6], values[7] = Number(entry[6]), Number(entry[7])
		end
	end
	local line = string.format("%s = { %s },", key, table.concat(values, ", "))
	if tails[name] and active[name] then
		line = line .. " " .. tails[name]
	elseif info and info.kind then
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
-- a width and height it keeps its size; { width, height } alone sizes it
-- where it is. A line without "--" keeps its part there for good, whatever
-- else moves it (modules/blizzard/adjust.lua).
-- Written by tools/positions.lua (docs: Common Tasks): it keeps the lines
-- without "--", the notes over them and at their ends, and adds what
-- /dui adjust moved in game.
local _, Engine = ...

Engine:NewStaticConfig("Positions", {]] }
local NOT_SEEN = "Not seen by /dui layout"
local listed, count = {}, 0
local windows = {}
for window, seen in pairs(layout.windows or {}) do
	windows[window] = seen.parts or {}
end
-- (a line in use stays in its window, even one /dui layout didn't see)
local unseen = {}
for name in pairs(active) do
	local window = sections[name] or NOT_SEEN
	if (window ~= NOT_SEEN) then
		windows[window] = windows[window] or {}
	end
	unseen[window] = unseen[window] or {}
	unseen[window][name] = true
end
local Section = function(window, parts)
	local names = {}
	for _, name in ipairs(Sorted(parts)) do
		if (not listed[name]) and ((type(parts[name]) == "table") or active[name]) then
			names[#names + 1] = name
		end
	end
	if (#names > 0) then
		out[#out + 1] = "\n\t-- " .. window .. " " .. string.rep("-", math.max(4, 70 - #window))
		for _, name in ipairs(names) do
			listed[name] = true
			local entry, seen = active[name], parts[name]
			seen = (type(seen) == "table") and seen or nil
			count = count + (seen and 1 or 0)
			for _, note in ipairs(entry and notes[name] or {}) do
				out[#out + 1] = "\t" .. note
			end
			out[#out + 1] = "\t" .. (entry and "" or "-- ") .. Line(name, entry or seen, seen)
		end
	end
end
for _, window in ipairs(Sorted(windows)) do
	local parts = {}
	for name, seen in pairs(windows[window]) do
		parts[name] = seen
	end
	for name in pairs(unseen[window] or {}) do
		parts[name] = parts[name] or true
	end
	Section(window, parts)
end
local others = {}
for name in pairs(active) do
	others[name] = true
end
Section(NOT_SEEN, others)
out[#out + 1] = "})\n"

file = assert(io.open(OUT, "w"))
file:write(table.concat(out, "\n"))
file:close()
print(string.format("%s: %d parts, %d in use.", OUT, count, #Sorted(active)))
