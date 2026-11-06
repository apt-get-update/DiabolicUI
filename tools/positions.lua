-- The windows' parts, three ways: windows/*.qml (each part where it goes,
-- written from what /dui layout saw: yours to change, by hand or with
-- tools/editor.py), settings/positions.lua written from them for the game
-- (the parts with a `pin`), and tools/layout.json for the editor. A part
-- without a pin follows the scan.
-- Run from the addon's folder, the game's saved variables written (a
-- /reload or a logout), any number of times:
--   lua5.1 tools/positions.lua [saved variables, "" newest, "-" none [out [json [windows [edits]]]]]
-- (edits: a Lua file returning { [name] = { place, size, pin } }, the editor's.)
-- It also writes settings/components.lua from windows/components/*.qml.
local SAVED = arg[1] or ""
local OUT = arg[2] or "settings/positions.lua"
local JSON = arg[3] or "tools/layout.json"
local DIR = arg[4] or "windows"
local EDITS = arg[5]

local Shared = dofile((arg[0]:match("^(.*)/[^/]*$") or ".") .. "/shared.lua")
local Sorted, Unquote, IsList, Pictures = Shared.Sorted, Shared.Unquote, Shared.IsList, Shared.Pictures

local Lines = function(command)
	local pipe = io.popen(command)
	local lines = {}
	for line in pipe:lines() do
		lines[#lines + 1] = line
	end
	pipe:close()
	return lines
end

local Number = function(value)
	value = math.floor(value * 10 + .5) / 10
	return (value == math.floor(value)) and string.format("%d", value) or string.format("%.1f", value)
end

local Round = function(value)
	return tonumber(Number(value))
end

local layout = {}
local saved = (SAVED == "") and Lines("ls -t ../../../WTF/Account/*/SavedVariables/DiabolicUI.lua 2>/dev/null")[1] or SAVED
if saved and (saved ~= "-") then
	local env = {}
	setfenv(assert(loadfile(saved)), env)()
	layout = env.DiabolicUI_Layout or {}
end

-- reading windows/*.qml ------------------------------------------------------

-- The statements of a .qml file: blocks opened and closed, properties set,
-- comments alone on their lines (a comment after a "}" kept on it).
local Statements = function(text)
	local out, buffer, at, closed = {}, {}, 1, false
	local Flush = function()
		local statement = table.concat(buffer):match("^%s*(.-)%s*$")
		buffer = {}
		if (statement ~= "") then
			out[#out + 1] = { "set", statement }
		end
	end
	while (at <= #text) do
		local c = text:sub(at, at)
		if (c == '"') then
			local stop = at + 1
			while (stop <= #text) and (text:sub(stop, stop) ~= '"') do
				stop = stop + ((text:sub(stop, stop) == "\\") and 2 or 1)
			end
			buffer[#buffer + 1] = text:sub(at, stop)
			at = stop
		elseif (text:sub(at, at + 1) == "//") then
			local stop = text:find("\n", at, true) or (#text + 1)
			local comment = text:sub(at, stop - 1):match("^(.-)%s*$")
			if closed then
				out[#out].tail = comment
			elseif (not table.concat(buffer):find("%S")) then
				out[#out + 1] = { "note", comment }
			end
			at = stop - 1
		elseif (c == "{") then
			out[#out + 1] = { "open", table.concat(buffer):match("^%s*(.-)%s*$") }
			buffer = {}
		elseif (c == "}") then
			Flush()
			out[#out + 1] = { "close" }
			closed = true
		elseif (c == "\n") or (c == ";") then
			Flush()
			closed = closed and (c == ";")
		else
			buffer[#buffer + 1] = c
		end
		at = at + 1
	end
	Flush()
	return out
end

-- WoW's points as QML's anchors: their line across, their line up and down.
local ACROSS = { left = "LEFT", right = "RIGHT", horizontalCenter = "" }
local DOWN = { top = "TOP", bottom = "BOTTOM", verticalCenter = "" }
local MARGINS = { -- what each moves: x or y, its sign
	leftMargin = { "left", 1 }, rightMargin = { "right", -1 }, horizontalCenterOffset = { "horizontalCenter", 1 },
	topMargin = { "top", -1 }, bottomMargin = { "bottom", 1 }, verticalCenterOffset = { "verticalCenter", -1 },
}
local MARGIN_OF = {}
for margin, info in pairs(MARGINS) do
	MARGIN_OF[info[1]] = margin
end

local AcrossOf = function(point)
	return (point:find("LEFT") and "left") or (point:find("RIGHT") and "right") or "horizontalCenter"
end

local DownOf = function(point)
	return (point:find("TOP") and "top") or (point:find("BOTTOM") and "bottom") or "verticalCenter"
end

local PointOf = function(across, down)
	local point = DOWN[down] .. ACROSS[across]
	return (point == "") and "CENTER" or point
end

local Quote = function(value)
	return '"' .. value:gsub('[\\"]', "\\%0") .. '"'
end

-- A window's file: its name, its size, its parts (each with its notes, the
-- note at its end, its place, its size, its pin).
local ReadWindow = function(path)
	local file = assert(io.open(path))
	local text = file:read("*a")
	file:close()
	local Problem = function(name, what)
		error(path .. ": " .. name .. ": " .. what, 0)
	end
	local window, block, kindOf, notes = { parts = {}, ghosts = {} }, nil, nil, {}
	local names, raw = {}, {}
	local depth = 0
	for _, statement in ipairs(Statements(text)) do
		local kind, value = statement[1], statement[2]
		if (kind == "open") then
			depth = depth + 1
			if ((depth == 1) and (value ~= "WowWindow")) or ((depth == 2) and (value ~= "Part") and (value ~= "Ghost")) or (depth > 2) then
				Problem(value, "only a WowWindow of Parts and Ghosts can be read")
			end
			if (depth == 1) then
				notes = {}
			elseif (depth == 2) then
				block, kindOf = { notes = (#notes > 0) and notes or nil, anchors = {}, margins = {} }, value
				notes = {}
			end
		elseif (kind == "close") then
			if (depth == 2) then
				if (not block.name) then
					Problem(block.id or kindOf, "a part needs a name")
				end
				names[block.id or block.name] = block.name
				if (kindOf == "Part") then
					block.tail = statement.tail
					window.parts[block.name] = block
					raw[block.name] = block
				else
					window.ghosts[block.name] = { block.x, block.y, block.width, block.height }
				end
			end
			depth = depth - 1
		elseif (kind == "note") then
			notes[#notes + 1] = value
		elseif (depth > 0) then
			local key, content = value:match("^([%w%.]+)%s*:%s*(.+)$")
			if (not key) then
				Problem(value, "not a property")
			end
			local target = (depth == 1) and window or block
			local line = key:match("^anchors%.(.+)$")
			if (key == "id") then
				target.id = content
			elseif (key == "name") or (key == "kind") or (key == "text") or (key == "wowParent") or (key == "pin") or (key == "style") then
				target[key] = Unquote(content) or Problem(key, "needs a text, not " .. content)
			elseif (key == "width") or (key == "height") or (key == "x") or (key == "y") then
				target[key] = tonumber(content) or Problem(key, "needs a number, not " .. content)
			elseif line and (depth == 2) and MARGINS[line] then
				block.margins[MARGINS[line][1]] = tonumber(content) or Problem(key, "needs a number, not " .. content)
			elseif line and (depth == 2) and (ACROSS[line] or DOWN[line]) then
				local id, other = content:match("^([%w_]+)%.(%w+)$")
				if (not id) then
					Problem(key, "needs a part and its line, not " .. content)
				end
				local axis = ACROSS[line] and "across" or "down"
				if block.anchors[axis] then
					Problem(block.name or key, "one anchor across and one down only (a WoW point)")
				end
				block.anchors[axis] = { line = line, id = id, to = other }
			else
				Problem(key, "can't be read")
			end
		end
	end
	if (not window.name) then
		Problem(path, "a window needs a name")
	end
	names[window.id or window.name] = window.name
	-- their anchors as WoW places
	for name, part in pairs(raw) do
		local across, down = part.anchors.across, part.anchors.down
		if across or down then
			if (not across) or (not down) or (across.id ~= down.id) or (not names[across.id]) then
				Problem(name, "needs one anchor across and one down, on one part of this file")
			end
			part.place = { PointOf(across.line, down.line), names[across.id], PointOf(across.to, down.to),
				(part.margins[across.line] or 0) * MARGINS[MARGIN_OF[across.line]][2],
				(part.margins[down.line] or 0) * MARGINS[MARGIN_OF[down.line]][2] }
		end
		part.w, part.h = part.width, part.height
		if part.width and part.height and ((part.kind ~= "FontString") or (part.pin == "all") or (part.pin == "size")) then
			part.size = { part.width, part.height }
		end
		part.anchors, part.margins, part.id, part.width, part.height = nil, nil, nil, nil, nil
		if part.pin and (part.pin ~= "all") and (part.pin ~= "place") and (part.pin ~= "size") then
			Problem(name, 'its pin is "all", "place" or "size"')
		elseif ((part.pin == "all") or (part.pin == "place")) and (not part.place) then
			Problem(name, "its pin needs anchors")
		elseif ((part.pin == "all") or (part.pin == "size")) and (not part.size) then
			Problem(name, "its pin needs a width and a height")
		end
	end
	return window
end

-- what's in windows/ and what's in settings/positions.lua ---------------------

local windows, owner, inFile = {}, {}, {}
os.execute("mkdir -p '" .. DIR .. "'")
for _, path in ipairs(Lines("ls '" .. DIR .. "'/*.qml 2>/dev/null")) do
	local base = path:match("([^/]+)%.qml$")
	if (base ~= "Part") and (base ~= "Ghost") and (base ~= "WowWindow") then
		local window = ReadWindow(path)
		windows[window.name] = window
		for name in pairs(window.parts) do
			owner[name], inFile[name] = window.name, true
		end
	end
end

-- settings/positions.lua's lines (for the parts in no file yet: the first
-- run), with the notes over them, at their ends, the window they're under
local active, notes, tails, sections = {}, {}, {}, {}
local chunk = loadfile(OUT)
if chunk then
	chunk("DiabolicUI", { NewStaticConfig = function(_, _, positions) active = positions end })
end
local file = io.open(OUT)
if file then
	local section, pending = nil, {}
	for line in file:lines() do
		local key, tail = line:match("^%s*([^%s%-][^=]-) = %b{},?%s*(.*)$")
		local title = line:match("^%s*%-%- (.-) %-%-%-%-+%s*$")
		if key then
			local name = key:match('^%["(.*)"%]$') or key
			notes[name] = (#pending > 0) and pending or nil
			tails[name] = (tail ~= "") and tail or nil
			sections[name] = section
			pending = {}
		elseif title then
			section, pending = title, {}
		elseif line:match("^%s*%-%-") and (not line:match("^%s*%-%-%s*%S+ = {")) then
			pending[#pending + 1] = line:match("^%s*(.-)%s*$")
		else
			pending = {}
		end
	end
	file:close()
end

-- all of it together ---------------------------------------------------------

local NOT_SEEN = "NotSeen"
local NOT_SEEN_TITLE = "Not seen by /dui layout"

local WindowNamed = function(name)
	windows[name] = windows[name] or { name = name, parts = {} }
	return windows[name]
end

-- `name`'s part in its window, or a new one in `window`
local PartNamed = function(name, window)
	owner[name] = owner[name] or window
	local parts = WindowNamed(owner[name]).parts
	parts[name] = parts[name] or { name = name }
	return parts[name]
end

-- what a part is placed and sized by for good: a line of settings/positions.lua
local Pin = function(part, entry)
	if (type(entry[1]) == "number") then
		part.size, part.pin = { Round(entry[1]), Round(entry[2]) }, "size"
	else
		part.place = { entry[1], entry[2], entry[3], Round(entry[4]), Round(entry[5]) }
		part.pin = "place"
		if entry[6] then
			part.size, part.pin = { Round(entry[6]), Round(entry[7]) }, "all"
		end
	end
end

-- what the scan saw, for what isn't pinned
local Follow = function(part)
	local seen = part.seen
	if seen then
		if (part.pin ~= "all") and (part.pin ~= "place") then
			part.place = { seen[1], seen[2], seen[3], seen[4], seen[5] }
		end
		if (part.pin ~= "all") and (part.pin ~= "size") then
			part.size = seen[6] and { seen[6], seen[7] } or nil
		end
	end
end

for _, title in ipairs(Sorted(layout.windows or {})) do
	local seen = layout.windows[title]
	WindowNamed(title).seen = seen
	for _, name in ipairs(Sorted(seen.parts or {})) do
		local entry = seen.parts[name]
		if (type(entry) == "table") and (not (owner[name] and windows[owner[name]].parts[name] and windows[owner[name]].parts[name].seen)) then
			local part = PartNamed(name, title)
			part.seen, part.kind, part.text, part.wowParent = entry, entry.kind, entry.text, entry.parent
			part.style = entry.style or part.style
			Follow(part)
		end
	end
end
-- A window the game scales (the auction house): the scan's rects are on screen,
-- its parts' places and sizes in its own units, as its file and
-- settings/positions.lua have them. Its rects in its own units too, from its top
-- left, for all of it to line up.
local ScaleOf = function(window)
	local scales = {}
	for _, part in pairs(window.parts) do
		local seen = part.seen
		if seen and seen.rect and seen[6] and (seen[6] > 0) and (seen.rect[3] > 0) then
			scales[#scales + 1] = math.floor(seen.rect[3] / seen[6] * 100 + .5) / 100
		end
	end
	table.sort(scales)
	return scales[math.ceil(#scales / 2)] or 1
end

for _, window in pairs(windows) do
	local seen = window.seen
	local scale = ScaleOf(window)
	if seen and seen.rect and (scale ~= 1) then
		local left, top = seen.rect[1], seen.rect[2] + seen.rect[4]
		local Own = function(rect)
			return rect and { left + (rect[1] - left) / scale, top - (top - rect[2]) / scale, rect[3] / scale, rect[4] / scale }
		end
		local OwnArt = function(art)
			for _, item in ipairs(art or {}) do
				item.rect = Own(item.rect)
				item.scale = item.scale and (item.scale / scale)
			end
		end
		for _, part in pairs(window.parts) do
			if part.seen then
				part.seen.rect = Own(part.seen.rect)
			end
		end
		for _, view in pairs(seen.views or {}) do
			view.rect, view.window, view.footRect, view.scale = Own(view.rect), Own(view.window), Own(view.footRect), scale
			OwnArt(view.art)
		end
		seen.rect, seen.window = Own(seen.rect), Own(seen.window)
		OwnArt(seen.art)
	end
end

-- A part placed by several points: the one place and size that keep it
-- where it is (its first point's wouldn't: the others stretch it).
local X_OF = { left = 0, horizontalCenter = .5, right = 1 }
local Y_OF = { bottom = 0, verticalCenter = .5, top = 1 }
for title, window in pairs(windows) do
	for _, part in pairs(window.parts) do
		local seen = part.seen
		if seen and seen.rect and seen.points and (#seen.points > 1) then
			local rel = window.parts[seen[2]]
			local on = (seen[2] == title) and (window.seen and window.seen.rect) or (rel and rel.seen and rel.seen.rect)
			if on then
				local rect = seen.rect
				seen[4] = Round(rect[1] + rect[3] * X_OF[AcrossOf(seen[1])] - on[1] - on[3] * X_OF[AcrossOf(seen[3])])
				seen[5] = Round(rect[2] + rect[4] * Y_OF[DownOf(seen[1])] - on[2] - on[4] * Y_OF[DownOf(seen[3])])
				if seen[6] then
					seen[6], seen[7] = rect[3], rect[4]
				end
				Follow(part)
			end
		end
	end
end
for name, entry in pairs(active) do
	if (not inFile[name]) then
		local section = sections[name]
		local part = PartNamed(name, (section and (section ~= NOT_SEEN_TITLE)) and section or NOT_SEEN)
		Pin(part, entry)
		for i, note in ipairs(notes[name] or {}) do
			part.notes = part.notes or {}
			part.notes[i] = note:gsub("^%-%-", "//")
		end
		-- (the note at its end, unless it's what's written there anyway)
		local tail = tails[name]
		if tail and (not (part.kind and tail:find("-- " .. part.kind, 1, true) == 1)) then
			part.tail = tail:gsub("^%-%-", "//")
		end
	end
end
local edits = EDITS and assert(loadfile(EDITS))() or {}
for name, edit in pairs(edits) do
	local part = owner[name] and windows[owner[name]].parts[name]
	if part then
		part.pin = (edit.pin ~= "") and edit.pin or nil
		part.place, part.size = edit.place or part.place, edit.size or part.size
		Follow(part)
	end
end

-- windows/components/*.qml ---------------------------------------------------

-- What every window shares (the generic window, its controls): a file's
-- properties, one a line, plain values. settings/components.lua is written from
-- them for the game; the editor changes them (edits["@components"]).

local components = {}
for _, path in ipairs(Lines("ls '" .. DIR .. "'/components/*.qml 2>/dev/null")) do
	components[#components + 1] = Shared.ReadComponent(path)
end

-- the editor's changes, each by its property's path: "up.normal"
local changedComponents = edits["@components"] or {}
for _, component in ipairs(components) do
	if changedComponents[component.name] then
		Shared.ChangeComponent(component, changedComponents[component.name])
		local file = assert(io.open(component.path, "w"))
		file:write(table.concat(component.lines, "\n"), "\n")
		file:close()
	end
end

-- writing windows/*.qml ------------------------------------------------------

local RESERVED = { id = true, parent = true, default = true, ["function"] = true, ["in"] = true, ["for"] = true, ["if"] = true,
	["new"] = true, this = true, name = true, kind = true, text = true, pin = true, property = true, signal = true, import = true }

-- an id for each name in a file: its name from a small letter, unique
local IdsOf = function(names)
	local ids, taken = {}, {}
	for _, name in ipairs(Sorted(names)) do
		local id = name:gsub("[^%w_]", "_"):gsub("^%u", string.lower):gsub("^%d", "_%0")
		while RESERVED[id] or taken[id] do
			id = id .. "_"
		end
		ids[name], taken[id] = id, true
	end
	return ids
end

-- How big a window is: as the scan saw it, as its file says, or as far as
-- what's placed from its top left goes.
local WindowSize = function(window)
	local rect = window.seen and window.seen.rect
	if rect then
		return rect[3], rect[4]
	elseif window.width and window.height then
		return window.width, window.height
	end
	local width, height = 400, 400
	for _, part in pairs(window.parts) do
		local place, size = part.place, part.size or {}
		if place and (place[2] == window.name) and (place[1] == "TOPLEFT") and (place[3] == "TOPLEFT") then
			width, height = math.max(width, place[4] + (size[1] or 0)), math.max(height, -place[5] + (size[2] or 0))
		end
	end
	return width, height
end

-- Where a frame that's in no part of this window is, in its coordinates
-- (from its top left, y down), going by what's placed on it: it stands in
-- for it in the file (a "Ghost").
local GhostRect = function(window, name)
	local root = window.seen and window.seen.rect
	local spots = { left = {}, horizontalCenter = {}, right = {}, top = {}, verticalCenter = {}, bottom = {} }
	for _, partName in ipairs(Sorted(window.parts)) do
		local part = window.parts[partName]
		local place = part.place
		local rect = part.seen and part.seen.rect
		if root and rect and place and (place[2] == name) then
			local x = rect[1] + rect[3] * X_OF[AcrossOf(place[1])] - place[4]
			local y = rect[2] + rect[4] * Y_OF[DownOf(place[1])] - place[5]
			spots[AcrossOf(place[3])][1] = x - root[1]
			spots[DownOf(place[3])][1] = (root[2] + root[4]) - y
		end
	end
	local Span = function(first, middle, last)
		local a, c, b = spots[first][1], spots[middle][1], spots[last][1]
		a = a or (c and b and (2 * c - b)) or c or b or 0
		b = b or (c and (2 * c - a)) or a
		return a, b - a
	end
	local x, width = Span("left", "horizontalCenter", "right")
	local y, height = Span("top", "verticalCenter", "bottom")
	-- (nothing to go by: where its file has it)
	if (not next(spots.left)) and (not next(spots.horizontalCenter)) and (not next(spots.right)) and window.ghosts and window.ghosts[name] then
		return unpack(window.ghosts[name])
	end
	return x, y, width, height
end

-- A part only placed and never scanned (a named texture): its size from what's
-- placed on its points, as a Ghost's, for those to be where the game has them.
for _, window in pairs(windows) do
	for name, part in pairs(window.parts) do
		if (part.pin == "place") and (not part.seen) then
			local _, _, width, height = GhostRect(window, name)
			if (width > 0) and (height > 0) then
				part.size = { width, height }
			end
		end
	end
end

local WritePart = function(out, part, ids)
	for _, note in ipairs(part.notes or {}) do
		out[#out + 1] = "    " .. note
	end
	out[#out + 1] = "    Part {"
	local Set = function(key, value)
		out[#out + 1] = "        " .. key .. ": " .. value
	end
	Set("id", ids[part.name])
	Set("name", Quote(part.name))
	if part.kind then
		Set("kind", Quote(part.kind))
	end
	if part.text then
		Set("text", Quote(part.text))
	end
	if part.wowParent then
		Set("wowParent", Quote(part.wowParent))
	end
	if part.style then
		Set("style", Quote(part.style))
	end
	if part.pin then
		Set("pin", Quote(part.pin))
	end
	if part.place then
		local place = part.place
		for _, axis in ipairs({ { AcrossOf(place[1]), AcrossOf(place[3]), place[4] }, { DownOf(place[1]), DownOf(place[3]), place[5] } }) do
			Set("anchors." .. axis[1], ids[place[2]] .. "." .. axis[2])
			local margin = MARGIN_OF[axis[1]]
			if (axis[3] ~= 0) then
				Set("anchors." .. margin, Number(axis[3] * MARGINS[margin][2]))
			end
		end
	end
	local rect = part.seen and part.seen.rect
	local size = part.size or (rect and { rect[3], rect[4] }) or (part.w and { part.w, part.h })
		or { 6 * #(part.text or part.name), 12 }
	Set("width", Number(size[1]))
	Set("height", Number(size[2]))
	out[#out + 1] = "    }" .. (part.tail and (" " .. part.tail) or "")
	out[#out + 1] = ""
end

local WriteWindow = function(window)
	local names, ghosts = { [window.name] = true }, {}
	for name, part in pairs(window.parts) do
		names[name] = true
	end
	for _, part in pairs(window.parts) do
		local rel = part.place and part.place[2]
		if rel and (not names[rel]) then
			ghosts[rel] = true
		end
	end
	for name in pairs(ghosts) do
		names[name] = true
	end
	local ids = IdsOf(names)
	local width, height = WindowSize(window)
	local out = { "// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part",
		'// with a pin is put in settings/positions.lua ("all", or only its "place" or',
		"// its \"size\"), the others follow /dui layout's scan.",
		"import QtQuick", "", "WowWindow {",
		"    id: " .. ids[window.name], "    name: " .. Quote(window.name),
		"    width: " .. Number(width), "    height: " .. Number(height), "" }
	for _, name in ipairs(Sorted(window.parts)) do
		WritePart(out, window.parts[name], ids)
	end
	for _, name in ipairs(Sorted(ghosts)) do
		local x, y, w, h = GhostRect(window, name)
		out[#out + 1] = string.format("    Ghost { id: %s; name: %s; x: %s; y: %s; width: %s; height: %s }",
			ids[name], Quote(name), Number(x), Number(y), Number(w), Number(h))
	end
	out[#out + 1] = "}\n"
	local path = DIR .. "/" .. window.name:gsub("[^%w_]", "_") .. ".qml"
	local written = assert(io.open(path, "w"))
	written:write(table.concat(out, "\n"))
	written:close()
	return path
end

for _, title in ipairs(Sorted(windows)) do
	windows[title].file = WriteWindow(windows[title])
end

-- writing settings/positions.lua ---------------------------------------------

local Line = function(part)
	local name = part.name
	local key = name:match("^[%a_][%w_]*$") and name or string.format("[%q]", name)
	local values = {}
	if (part.pin ~= "size") then
		local place = part.place
		values = { string.format("%q", place[1]), string.format("%q", place[2]), string.format("%q", place[3]), Number(place[4]), Number(place[5]) }
	end
	if (part.pin ~= "place") then
		values[#values + 1] = Number(part.size[1])
		values[#values + 1] = Number(part.size[2])
	end
	local line = string.format("%s = { %s },", key, table.concat(values, ", "))
	if part.tail then
		return line .. " " .. part.tail:gsub("^//", "--")
	end
	return line .. (part.kind and (" -- " .. part.kind .. (part.text and (" " .. string.format("%q", part.text)) or "")) or "")
end

local out = { [[
-- The parts placed for good: { point, the frame it's placed on, that frame's
-- point, x, y, width, height } (x right, y up), without a width and height it
-- keeps its size, { width, height } alone sizes it where it is, whatever else
-- moves it (modules/blizzard/adjust.lua).
-- Written from windows/*.qml by tools/positions.lua: change those (docs:
-- Common Tasks), this file is overwritten.
local _, Engine = ...

Engine:NewStaticConfig("Positions", {]] }
local total, pinned = 0, 0
for _, title in ipairs(Sorted(windows)) do
	local window, first = windows[title], true
	for _, name in ipairs(Sorted(window.parts)) do
		local part = window.parts[name]
		total = total + 1
		if part.pin then
			pinned = pinned + 1
			if first then
				local shown = (title == NOT_SEEN) and NOT_SEEN_TITLE or title
				out[#out + 1] = "\n\t-- " .. shown .. " " .. string.rep("-", math.max(4, 70 - #shown))
				first = false
			end
			for _, note in ipairs(part.notes or {}) do
				out[#out + 1] = "\t" .. note:gsub("^//", "--")
			end
			out[#out + 1] = "\t" .. Line(part)
		end
	end
end
out[#out + 1] = "})\n"
file = assert(io.open(OUT, "w"))
file:write(table.concat(out, "\n"))
file:close()
print(string.format("%s: %d parts, %d in use.", OUT, total, pinned))

-- settings/components.lua ----------------------------------------------------

if components[1] then
	local file = assert(io.open((OUT:match("^(.*)/[^/]*$") or ".") .. "/components.lua", "w"))
	file:write(Shared.ComponentsLua(components))
	file:close()
end

-- tools/layout.json ----------------------------------------------------------

local export = { resolution = layout.resolution, unit = layout.unit, rules = layout.rules, left = layout.left, windows = {} }
for title, window in pairs(windows) do
	local parts = {}
	for name, part in pairs(window.parts) do
		local seen = part.seen or {}
		local copy = { kind = part.kind, text = part.text, parent = part.wowParent, style = part.style, place = part.place, size = part.size,
			pin = part.pin, rect = seen.rect, strata = seen.strata, level = seen.level, layer = seen.layer }
		-- (what the rules go by: tools/rules.js)
		for _, key in ipairs({ "aside", "chain", "control", "diablo", "dropdown", "edge", "faded", "hung", "inset", "justify", "light",
			"material", "onArt", "onLit", "own", "row", "textWidth", "written", "zone" }) do
			copy[key] = seen[key]
		end
		copy.tabs = (next(seen.tabs or {}) ~= nil) and Sorted(seen.tabs) or nil
		-- (seen only with no tab chosen, as the spellbook's companions: only then)
		local views = window.seen and window.seen.views
		if (not copy.tabs) and part.seen and views and views[""] and (next(views, next(views)) ~= nil) then
			copy.tabs = { "" }
		end
		-- the views whose last look at the window saw it (a view not looked at
		-- since looks were told apart: all it had)
		if views then
			copy.current = {}
			for view, was in pairs(views) do
				if (not was.stamp) or ((seen.last or {})[view] == was.stamp) then
					copy.current[view] = true
				end
			end
		end
		copy.use = part.pin and { place = (part.pin ~= "size") and part.place or nil, size = (part.pin ~= "place") and part.size or nil } or nil
		-- (a point placed on nothing: on its parent, as the game has it)
		for i, point in ipairs(seen.points or {}) do
			copy.points = copy.points or {}
			copy.points[i] = { point[1], point[2] or seen.parent or "UIParent", point[3], point[4], point[5] }
		end
		parts[name] = copy
	end
	local seen = window.seen or {}
	-- what it shows by the tabs chosen (a scan from before: its art alone)
	local views, first = {}, seen.art
	for _, key in ipairs(Sorted(seen.views or {})) do
		local view = seen.views[key]
		first = first or view.art
		views[#views + 1] = { key = key, label = view.label, rect = view.rect, window = view.window, footRect = view.footRect, scale = view.scale, art = Pictures(view.art),
			frame = view.frame, band = view.band, foot = view.foot, railOver = view.railOver, close = view.close, iron = view.iron }
	end
	export.windows[title] = { checked = seen.checked, rect = seen.rect, window = seen.window, parts = parts,
		art = Pictures(first), file = window.file, views = views[1] and views or nil }
end

-- the components for the editor, each property on its own: a table of names by
-- its path, a color by its name
local COLORS = { fill = true, line = true, label = true, value = true, line_dark = true }
local IsColor = function(key, value)
	local last = key:match("([^.]+)$")
	return (#value >= 3) and (#value <= 4) and (type(value[1]) == "number") and (COLORS[last] or last:find("color"))
end
local Fields
Fields = function(fields, key, value, note)
	if (type(value) == "table") and (not IsList(value)) then
		for _, inner in ipairs(Sorted(value)) do
			Fields(fields, key .. "." .. inner, value[inner], note)
			note = nil
		end
		return
	end
	local kind = type(value)
	if (kind == "table") then
		kind = IsColor(key, value) and "color" or "list"
	elseif (kind == "string") and value:find("^textures/") then
		kind = "texture"
	end
	fields[#fields + 1] = { key = key, value = value, kind = kind, note = (note ~= "") and note or nil }
end
if components[1] then
	export.components = {}
	for _, component in ipairs(components) do
		local fields = {}
		for _, key in ipairs(component.order) do
			Fields(fields, key, component.values[key], component.notes[key])
			if (component.name == "Window") and (key == "layout") then
				export.rules = export.rules or {}
				for rule, value in pairs(component.values[key]) do
					export.rules[rule] = value
				end
			end
		end
		export.components[#export.components + 1] = { name = component.name, comment = component.comment, fields = fields }
	end
end
file = assert(io.open(JSON, "w"))
file:write(Shared.Encode(export), "\n")
file:close()
