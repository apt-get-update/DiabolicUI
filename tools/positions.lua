-- Writes settings/positions.lua: every named part /dui layout saw (each
-- window's, in DiabolicUI_Layout), where it was, each line commented out;
-- the lines already without "--" kept (with the notes over them and at
-- their ends, in their window), and what /dui adjust moved in game added
-- without "--". With them, tools/layout.json: every window and its parts
-- as the scan saw them (all their points, parents, places on screen,
-- layers), the lines in use beside them, for an editor out of the game.
-- Run from the addon's folder, the game's saved variables written (a
-- /reload or a logout):
--   lua5.1 tools/positions.lua [path/to/WTF/Account/<you>/SavedVariables/DiabolicUI.lua [out [json]]]
local OUT = arg[2] or "settings/positions.lua"
local JSON = arg[3] or "tools/layout.json"

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

-- tools/layout.json ----------------------------------------------------------

-- `value` (a string, a number or a table) in JSON: a table with 1..n only
-- an array, else an object (its keys sorted).
local Encode
Encode = function(value, out)
	local kind = type(value)
	if (kind == "string") then
		local escaped = value:gsub('[%c"\\]', function(c)
			return (c == '"' and '\\"') or (c == "\\" and "\\\\") or string.format("\\u%04x", c:byte())
		end)
		out[#out + 1] = '"' .. escaped .. '"'
	elseif (kind == "number") then
		out[#out + 1] = (string.format("%.4f", value):gsub("%.?0+$", ""))
	elseif (kind == "boolean") then
		out[#out + 1] = tostring(value)
	elseif (kind == "table") and (next(value) ~= nil) and (#Sorted(value) == #value) then
		out[#out + 1] = "["
		for i, item in ipairs(value) do
			out[#out + 1] = (i > 1) and "," or ""
			Encode(item, out)
		end
		out[#out + 1] = "]"
	else
		out[#out + 1] = "{"
		for i, key in ipairs(Sorted(value)) do
			out[#out + 1] = (i > 1) and "," or ""
			Encode(tostring(key), out)
			out[#out + 1] = ":"
			Encode(value[key], out)
		end
		out[#out + 1] = "}"
	end
end

-- A place as settings/positions.lua takes it: { point, relative,
-- relativePoint, x, y } and its size ({ width, height }), apart.
local Place = function(entry)
	if (type(entry[1]) == "number") then
		return { size = { entry[1], entry[2] } }
	end
	return { place = { entry[1], entry[2], entry[3], entry[4], entry[5] }, size = entry[6] and { entry[6], entry[7] } }
end

-- Our art's pictures (tools/art/, not in git): each file of media/ the
-- windows show, as a .bmp (a browser reads it, not a .tga), named after
-- it; a white file (a line, a fill: colored in game) just said white.
local ART = (JSON:match("^(.*)/[^/]*$") or ".") .. "/art"

local LittleEndian = function(value, bytes)
	value = (value < 0) and (value + 256 ^ bytes) or value
	local out = {}
	for i = 1, bytes do
		out[i] = string.char(value % 256)
		value = math.floor(value / 256)
	end
	return table.concat(out)
end

-- a .tga (raw or packed, 24 or 32 bits) as a 32-bit .bmp with its alpha
local Bitmap = function(data)
	local idLength, mapType, kind = data:byte(1, 3)
	local width, height = data:byte(13) + 256 * data:byte(14), data:byte(15) + 256 * data:byte(16)
	local bits, flags = data:byte(17, 18)
	if (mapType ~= 0) or ((kind ~= 2) and (kind ~= 10)) or ((bits ~= 24) and (bits ~= 32)) then
		return
	end
	local size, at, count = bits / 8, 19 + idLength, width * height
	local Pixel = function()
		local pixel = data:sub(at, at + size - 1) .. ((size == 3) and "\255" or "")
		at = at + size
		return pixel
	end
	local pixels = {}
	if (kind == 2) and (size == 4) then
		pixels[1] = data:sub(at, at + count * 4 - 1)
	else
		local done = 0
		while (done < count) do
			local run, same = 1, false
			if (kind == 10) then
				local head = data:byte(at)
				at, run, same = at + 1, head % 128 + 1, head >= 128
			end
			if same then
				pixels[#pixels + 1] = Pixel():rep(run)
			else
				for _ = 1, run do
					pixels[#pixels + 1] = Pixel()
				end
			end
			done = done + run
		end
	end
	local body = table.concat(pixels)
	local top = (math.floor(flags / 32) % 2 == 1) -- (its first row the top one: a .bmp's height negative)
	return table.concat({ "BM", LittleEndian(122 + #body, 4), LittleEndian(0, 4), LittleEndian(122, 4),
		LittleEndian(108, 4), LittleEndian(width, 4), LittleEndian(top and -height or height, 4), LittleEndian(1, 2),
		LittleEndian(32, 2), LittleEndian(3, 4), LittleEndian(#body, 4), LittleEndian(2835, 4), LittleEndian(2835, 4),
		LittleEndian(0, 4), LittleEndian(0, 4), LittleEndian(0x00FF0000, 4), LittleEndian(0x0000FF00, 4),
		LittleEndian(0x000000FF, 4), LittleEndian(0xFF000000, 4), "BGRs", string.rep("\0", 48), body })
end

-- the media files by their names in lower case (the game's aren't fussy)
local media = {}
local pipe = io.popen("find media -type f -iname '*.tga' 2>/dev/null")
for path in pipe:lines() do
	media[path:lower()] = path
end
pipe:close()

-- a texture's file: its picture's path (made once), true if white, or nil
local made = {}
local Picture = function(file)
	if (not file) then
		return
	end
	local rest = file:gsub("\\", "/"):match("[Dd]iabolic[Uu][Ii]/(.*)$")
	if (not rest) then
		return true
	end
	local path = media[rest:lower()] or media[rest:lower() .. ".tga"]
	if path and (made[path] == nil) then
		local tga = io.open(path, "rb")
		local data = Bitmap(tga:read("*a"))
		tga:close()
		made[path] = data and ("art/" .. path:gsub("^media/", ""):gsub("/", "-"):gsub("%.[Tt][Gg][Aa]$", ".bmp")) or false
		if data then
			os.execute("mkdir -p '" .. ART .. "'")
			local bmp = assert(io.open(ART .. "/" .. made[path]:sub(5), "wb"))
			bmp:write(data)
			bmp:close()
		end
	end
	return path and made[path] or nil
end

-- a window's art as the editor draws it: its files as their pictures
-- (the ones not found or read left out; none: nil)
local Pictures = function(art)
	local out = {}
	for _, item in ipairs(art or {}) do
		local copy = {}
		for key, value in pairs(item) do
			copy[key] = value
		end
		copy.file, copy.image = nil, Picture(item.file)
		if item.backdrop then
			local backdrop = {}
			for key, value in pairs(item.backdrop) do
				backdrop[key] = value
			end
			backdrop.bgFile, backdrop.edgeFile = nil, nil
			backdrop.bg, backdrop.edge = Picture(item.backdrop.bgFile), Picture(item.backdrop.edgeFile)
			copy.backdrop = backdrop
		end
		if copy.image or (copy.backdrop and (copy.backdrop.bg or copy.backdrop.edge)) then
			out[#out + 1] = copy
		end
	end
	return out[1] and out or nil
end

local export = { resolution = layout.resolution, unit = layout.unit, windows = {}, unseen = {} }
local exported = {}
for window, seen in pairs(layout.windows or {}) do
	local parts = {}
	for name, entry in pairs(seen.parts or {}) do
		if (type(entry) == "table") then
			local part = Place(entry)
			for _, key in ipairs({ "kind", "text", "parent", "rect", "strata", "level", "layer" }) do
				part[key] = entry[key]
			end
			-- (a point placed on nothing: on its parent, as the game has it)
			for i, point in ipairs(entry.points or {}) do
				part.points = part.points or {}
				part.points[i] = { point[1], point[2] or entry.parent or "UIParent", point[3], point[4], point[5] }
			end
			part.use = active[name] and Place(active[name])
			parts[name], exported[name] = part, true
		end
	end
	export.windows[window] = { checked = seen.checked, rect = seen.rect, window = seen.window, parts = parts, art = Pictures(seen.art) }
end
for name, entry in pairs(active) do
	if not exported[name] then
		export.unseen[name] = Place(entry)
	end
end
local json = {}
Encode(export, json)
file = assert(io.open(JSON, "w"))
file:write(table.concat(json), "\n")
file:close()
