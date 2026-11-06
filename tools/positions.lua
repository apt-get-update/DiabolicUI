-- The windows' parts, three ways: windows/*.qml (each part where it goes,
-- written from what /dui layout saw: yours to change, by hand or with
-- tools/editor.py), settings/positions.lua written from them for the game
-- (the parts with a `pin`), and tools/layout.json for the editor. A part
-- without a pin follows the scan.
-- Run from the addon's folder, the game's saved variables written (a
-- /reload or a logout), any number of times:
--   lua5.1 tools/positions.lua [saved variables, "" newest, "-" none [out [json [windows [edits]]]]]
-- (edits: a Lua file returning { [name] = { place, size, pin, second } } and
-- ["@rows"] = { [window] = { [row] = { fit, spacing, left, right, y } } }, the editor's.)
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

-- A window's art, as the scan packs it (Packed, modules/blizzard/layout-scan.lua).
for _, seen in pairs(layout.windows or {}) do
	for _, view in pairs(type(seen) == "table" and seen.views or {}) do
		for i, item in ipairs(view.art or {}) do
			if (type(item) == "string") then
				view.art[i] = assert(loadstring("return " .. item))()
			end
		end
	end
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

-- The kinds of part with a type of their own (windows/<kind>.qml): `FontString { }`.
-- Any other kind the scan finds is written `Part { kind: "..." }`.
local KINDS = { Button = true, CheckButton = true, DressUpModel = true, EditBox = true, FontString = true, Frame = true,
	PlayerModel = true, ScrollFrame = true, ScrollingMessageFrame = true, Slider = true, StatusBar = true, Texture = true }

-- A window's file: its name, its size, its parts (each with its notes, the
-- note at its end, its place, its size, its pin).
local ReadWindow = function(path)
	local file = assert(io.open(path))
	local text = file:read("*a")
	file:close()
	local Problem = function(name, what)
		error(path .. ": " .. name .. ": " .. what, 0)
	end
	local window, block, kindOf, notes = { parts = {}, ghosts = {}, rows = {} }, nil, nil, {}
	local names, raw = {}, {}
	local depth = 0
	for _, statement in ipairs(Statements(text)) do
		local kind, value = statement[1], statement[2]
		if (kind == "open") then
			depth = depth + 1
			if ((depth == 1) and (value ~= "WowWindow")) or ((depth == 2) and (value ~= "Part") and (value ~= "Ghost") and (value ~= "WowRow") and (not KINDS[value])) or (depth > 2) then
				Problem(value, "only a WowWindow of parts, WowRows and Ghosts can be read")
			end
			if (depth == 1) then
				notes = {}
			elseif (depth == 2) then
				block, kindOf = { notes = (#notes > 0) and notes or nil, anchors = {}, margins = {} }, KINDS[value] and "Part" or value
				block.kind = KINDS[value] and value or nil
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
				elseif (kindOf == "WowRow") then
					window.rows[#window.rows + 1] = block
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
			elseif (key == "name") or (key == "kind") or (key == "text") or (key == "wowParent") or (key == "pin") or (key == "style") or (key == "fit") then
				target[key] = Unquote(content) or Problem(key, "needs a text, not " .. content)
			elseif (key == "width") or (key == "height") or (key == "x") or (key == "y") or (key == "spacing") then
				target[key] = tonumber(content) or Problem(key, "needs a number, not " .. content)
			elseif (key == "parts") and (depth == 2) then
				block.members = {}
				for name in content:gmatch('"([^"]+)"') do
					block.members[#block.members + 1] = name
				end
			elseif line and (depth == 2) and MARGINS[line] then
				block.margins[MARGINS[line][1]] = tonumber(content) or Problem(key, "needs a number, not " .. content)
			elseif line and (depth == 2) and (ACROSS[line] or DOWN[line]) then
				local id, other = content:match("^([%w_]+)%.(%w+)$")
				if (not id) then
					Problem(key, "needs a part and its line, not " .. content)
				end
				local axis = ACROSS[line] and "across" or "down"
				-- (a second one on the same axis: stretched between them)
				if block.anchors[axis] then
					axis = axis .. "2"
				end
				if block.anchors[axis] then
					Problem(block.name or key, "two anchors across and two down at most")
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
	-- (a stretch's two lines in order: left then right, top then bottom)
	local InOrder = function(name, first, second, a, b)
		if not second then
			return first
		end
		if (first.line == b) and (second.line == a) then
			first, second = second, first
		end
		if (first.line ~= a) or (second.line ~= b) then
			Problem(name, "stretches between " .. a .. " and " .. b .. " only")
		end
		return first, second
	end
	local Offset = function(margins, line)
		return (margins[line] or 0) * MARGINS[MARGIN_OF[line]][2]
	end
	for name, part in pairs(raw) do
		local across, across2 = InOrder(name, part.anchors.across, part.anchors.across2, "left", "right")
		local down, down2 = InOrder(name, part.anchors.down, part.anchors.down2, "top", "bottom")
		if across or down then
			if (not across) or (not down) or (across.id ~= down.id) or (not names[across.id]) then
				Problem(name, "needs one anchor across and one down, on one part of this file")
			end
			part.place = { PointOf(across.line, down.line), names[across.id], PointOf(across.to, down.to),
				Offset(part.margins, across.line), Offset(part.margins, down.line) }
			if across2 or down2 then
				local x, y = across2 or across, down2 or down
				if (x.id ~= across.id) or (y.id ~= across.id) then
					Problem(name, "stretches between the lines of one part only")
				elseif (part.pin ~= "place") and (part.pin ~= "all") then
					Problem(name, 'stretched, it needs a pin of "place" or "all"')
				end
				part.second = { PointOf(x.line, y.line), PointOf(x.to, y.to), Offset(part.margins, x.line), Offset(part.margins, y.line) }
			end
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
	-- the rows: across one part, by its sides, one anchor down on it
	for _, row in ipairs(window.rows) do
		local anchors = row.anchors
		local left, right = InOrder(row.name, anchors.across, anchors.across2, "left", "right")
		local down = anchors.down
		if (not right) or (left.to ~= "left") or (right.to ~= "right") or (not down) or anchors.down2
			or (left.id ~= right.id) or (down.id ~= left.id) or (not names[left.id]) then
			Problem(row.name, "a row goes from a part's left to its right, with one anchor down on it")
		elseif (not row.members) or (not row.members[1]) then
			Problem(row.name, "a row needs its parts")
		elseif row.fit and (row.fit ~= "fill") and (row.fit ~= "equal") and (row.fit ~= "center") and (row.fit ~= "ends") then
			Problem(row.name, 'its fit is "fill", "equal", "center" or "ends"')
		end
		row.on, row.line, row.to = names[left.id], down.line, down.to
		row.left, row.right, row.y = row.margins.left or 0, row.margins.right or 0, Offset(row.margins, down.line)
	end
	return window
end

-- what's in windows/ and what's in settings/positions.lua ---------------------

local windows, owner, inFile = {}, {}, {}
os.execute("mkdir -p '" .. DIR .. "'")
for _, path in ipairs(Lines("ls '" .. DIR .. "'/*.qml 2>/dev/null")) do
	local base = path:match("([^/]+)%.qml$")
	if (base ~= "Part") and (base ~= "Ghost") and (base ~= "GameText") and (base ~= "WowWindow") and (base ~= "WowRow") and (not KINDS[base]) then
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
		part.second = entry.second
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
		part.second = edit.second
		if part.second and (part.pin ~= "place") and (part.pin ~= "all") then
			error(name .. ': stretched, it needs a pin of "place" or "all"', 0)
		end
		Follow(part)
	end
end
for title, rows in pairs(edits["@rows"] or {}) do
	for _, row in ipairs(windows[title] and windows[title].rows or {}) do
		local edit = rows[row.name]
		if edit then
			row.fit = (edit.fit ~= "fill") and edit.fit or nil
			row.spacing, row.left, row.right, row.y = edit.spacing, edit.left, edit.right, edit.y
		end
	end
end

-- What only shows in the editor, to be seen and not changed: what's in a bag (AdiBags
-- places it), and the rows of a long list, all like the first. In its file only
-- if it's pinned; the rules and the preview have it from the scan.
local PREVIEW_FROM = 8 -- (how many of a name, but for their numbers, make a list)
local NumbersOf = function(name)
	local numbers = {}
	for number in name:gmatch("%d+") do
		numbers[#numbers + 1] = tonumber(number)
	end
	return numbers
end
local ByNumbers = function(a, b)
	local x, y = NumbersOf(a), NumbersOf(b)
	for i = 1, math.min(#x, #y) do
		if (x[i] ~= y[i]) then
			return x[i] < y[i]
		end
	end
	return a < b
end
for _, window in pairs(windows) do
	local families = {}
	for name, part in pairs(window.parts) do
		local family, numbers = name:gsub("%d+", "#")
		if (numbers > 0) and part.seen then
			families[family] = families[family] or {}
			table.insert(families[family], name)
		end
	end
	for family, names in pairs(families) do
		local items = family:find("^AdiBagsItemButton#") or family:find("^AdiBagsBankItemButton#")
		if items or ((#names >= PREVIEW_FROM) and (not family:find("Tab#$"))) then
			table.sort(names, ByNumbers)
			for i, name in ipairs(names) do
				local part = window.parts[name]
				part.preview = (not part.pin) and (items or (i > 1)) and true or nil
			end
		end
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
	-- (a part only for the preview: where it was seen)
	local seenPart = window.parts[name]
	local seenRect = seenPart and seenPart.preview and seenPart.seen.rect
	if root and seenRect then
		return seenRect[1] - root[1], (root[2] + root[4]) - (seenRect[2] + seenRect[4]), seenRect[3], seenRect[4]
	end
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

-- How wide and tall `name` is in `window`: the window's, a part's.
local BoxOf = function(window, name)
	if (name == window.name) then
		return WindowSize(window)
	end
	local part = window.parts[name]
	local rect = part and part.seen and part.seen.rect
	if rect then
		return rect[3], rect[4]
	end
	local size = part and (part.size or (part.w and { part.w, part.h }))
	if size then
		return size[1], size[2]
	end
end

-- A stretched part's size, from what it's stretched on.
for _, window in pairs(windows) do
	for _, part in pairs(window.parts) do
		local second = part.second
		local width, height = BoxOf(window, part.place and part.place[2] or "")
		if second and width then
			local place = part.place
			local box = part.size or { 0, 0 }
			local w = width * (X_OF[AcrossOf(second[2])] - X_OF[AcrossOf(place[3])]) + second[3] - place[4]
			local h = height * (Y_OF[DownOf(place[3])] - Y_OF[DownOf(second[2])]) + place[5] - second[4]
			part.size = { (AcrossOf(second[1]) ~= AcrossOf(place[1])) and Round(w) or box[1],
				(DownOf(second[1]) ~= DownOf(place[1])) and Round(h) or box[2] }
		end
	end
end

-- The rows: their parts placed and sized so that they fit the room they're told.
-- (Written as any other part's place: the game has nothing new to do. The room
-- too small, they're still in it: "its text is wider than it" says so.)
local RowGap = function()
	for _, component in ipairs(components) do
		local rules = (component.name == "Window") and component.values.layout
		if rules and rules.button_gap then
			return rules.button_gap
		end
	end
	return (layout.rules and layout.rules.button_gap) or 6
end

local PartSize = function(part)
	local rect = part.seen and part.seen.rect
	return part.size or (rect and { rect[3], rect[4] }) or (part.w and { part.w, part.h }) or { 0, 0 }
end

local ResolveRow = function(window, row)
	local width = BoxOf(window, row.on)
	if not width then
		error(window.name .. ": " .. row.name .. ": how wide " .. row.on .. " is isn't known", 0)
	end
	local room, gap, count = width - row.left - row.right, row.spacing or RowGap(), #row.members
	local parts, widths, sum = {}, {}, 0
	for i, name in ipairs(row.members) do
		local part = window.parts[name]
		if (not part) then
			error(window.name .. ": " .. row.name .. ": " .. name .. " isn't a part of this file", 0)
		elseif part.heldBy then
			error(window.name .. ": " .. row.name .. ": " .. name .. " is held by " .. part.heldBy, 0)
		end
		part.heldBy = "row " .. row.name
		parts[i], widths[i] = part, PartSize(part)[1]
		sum = sum + widths[i]
	end
	local fit, first = row.fit or "fill", row.left
	if (fit == "fill") then
		-- those with a text as wide as it, the room left shared between them; those
		-- without as they are (no text known: all of them as they are, what's left shared)
		local sharing, last = 0, nil
		sum = 0
		for i, part in ipairs(parts) do
			local text = part.seen and part.seen.textWidth
			widths[i] = text or widths[i]
			sum = sum + widths[i]
			if text then
				sharing, last = sharing + 1, i
				parts[i].sharing = true
			end
		end
		if (sharing == 0) then
			sharing, last = count, count
			for _, part in ipairs(parts) do
				part.sharing = true
			end
		end
		local extra = (room - gap * (count - 1) - sum) / sharing
		sum = 0
		for i, part in ipairs(parts) do
			widths[i] = Round(widths[i] + (part.sharing and extra or 0))
			part.sharing = nil
			sum = sum + widths[i]
		end
		widths[last] = Round(widths[last] + room - gap * (count - 1) - sum)
	elseif (fit == "equal") then
		-- all as wide, whatever their texts (the last takes what rounding left)
		local shared = room - gap * (count - 1)
		sum = 0
		for i = 1, count do
			widths[i] = Round(shared / count)
			sum = sum + widths[i]
		end
		widths[count] = Round(widths[count] + shared - sum)
	elseif (fit == "center") then
		first = row.left + (room - sum - gap * (count - 1)) / 2
	elseif (count > 1) then
		gap = (room - sum) / (count - 1)
	else
		first = row.left + (room - sum) / 2
	end
	if (fit ~= "fill") and (fit ~= "equal") and (sum + ((fit == "center") and (gap * (count - 1)) or 0) > room) then
		print(string.format("%s: %s is wider than its room (%s).", window.name, row.name, Number(room)))
	end
	for i, part in ipairs(parts) do
		if (i == 1) then
			part.place = { PointOf("left", row.line), row.on, PointOf("left", row.to), Round(first), row.y }
		else
			part.place = { "LEFT", parts[i - 1].name, "RIGHT", Round(gap), 0 }
		end
		part.second = nil
		if (fit == "fill") or (fit == "equal") then
			part.size, part.pin = { widths[i], PartSize(part)[2] }, "all"
		else
			-- (as they are: pinned at their size, it stays what the editor shows)
			part.pin = (part.pin == "all") and "all" or "place"
		end
	end
end

for _, title in ipairs(Sorted(windows)) do
	for _, row in ipairs(windows[title].rows or {}) do
		ResolveRow(windows[title], row)
	end
end

local WritePart = function(out, part, ids)
	for _, note in ipairs(part.notes or {}) do
		out[#out + 1] = "    " .. note
	end
	local typed = part.kind and KINDS[part.kind]
	out[#out + 1] = "    " .. (typed and part.kind or "Part") .. " {"
	local Set = function(key, value)
		out[#out + 1] = "        " .. key .. ": " .. value
	end
	Set("id", ids[part.name])
	Set("name", Quote(part.name))
	if part.kind and (not typed) then
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
		-- (stretched: the other side's line, or lines)
		local second = part.second
		if second then
			for _, axis in ipairs({ { AcrossOf(place[1]), AcrossOf(second[1]), AcrossOf(second[2]), second[3] },
				{ DownOf(place[1]), DownOf(second[1]), DownOf(second[2]), second[4] } }) do
				if (axis[1] ~= axis[2]) then
					Set("anchors." .. axis[2], ids[place[2]] .. "." .. axis[3])
					if (axis[4] ~= 0) then
						Set("anchors." .. MARGIN_OF[axis[2]], Number(axis[4] * MARGINS[MARGIN_OF[axis[2]]][2]))
					end
				end
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

-- A row as it's written: what it is, not where its parts ended up (theirs).
local WriteRow = function(out, row, ids)
	for _, note in ipairs(row.notes or {}) do
		out[#out + 1] = "    " .. note
	end
	out[#out + 1] = "    WowRow {"
	local Set = function(key, value)
		out[#out + 1] = "        " .. key .. ": " .. value
	end
	local members = {}
	for i, name in ipairs(row.members) do
		members[i] = Quote(name)
	end
	Set("name", Quote(row.name))
	Set("parts", "[" .. table.concat(members, ", ") .. "]")
	if row.fit then
		Set("fit", Quote(row.fit))
	end
	if row.spacing then
		Set("spacing", Number(row.spacing))
	end
	local on = ids[row.on]
	Set("anchors.left", on .. ".left")
	if (row.left ~= 0) then
		Set("anchors.leftMargin", Number(row.left))
	end
	Set("anchors.right", on .. ".right")
	if (row.right ~= 0) then
		Set("anchors.rightMargin", Number(row.right))
	end
	Set("anchors." .. row.line, on .. "." .. row.to)
	if (row.y ~= 0) then
		local margin = MARGIN_OF[row.line]
		Set("anchors." .. margin, Number(row.y * MARGINS[margin][2]))
	end
	out[#out + 1] = "    }"
	out[#out + 1] = ""
end

local WriteWindow = function(window)
	local names, ghosts = { [window.name] = true }, {}
	for name, part in pairs(window.parts) do
		names[name] = (not part.preview) or nil
	end
	for _, row in ipairs(window.rows or {}) do
		if (not names[row.on]) then
			ghosts[row.on] = true
		end
	end
	for _, part in pairs(window.parts) do
		local rel = (not part.preview) and part.place and part.place[2]
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
		if (not window.parts[name].preview) then
			WritePart(out, window.parts[name], ids)
		end
	end
	for _, row in ipairs(window.rows or {}) do
		WriteRow(out, row, ids)
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
	if part.second then
		local second = part.second
		values[#values + 1] = string.format("second = { %q, %q, %s, %s }", second[1], second[2], Number(second[3]), Number(second[4]))
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
-- moves it; second = { point, that frame's point, x, y } stretches it to there
-- too (modules/blizzard/adjust.lua).
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
			"material", "onArt", "onLit", "own", "row", "textWidth", "written", "zone",
			"color", "font", "fontSize", "justifyV", "outline", "shadow", "words" }) do -- (the last line: how the editor draws its text)
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
		-- (not to be dragged: it follows from its row, or its two sides)
		copy.heldBy = part.heldBy or (part.second and "its two sides") or nil
		copy.inRow = part.heldBy and part.heldBy:match("^row (.+)$") -- (its WowRow; `row` is the scan's: a button on a row)
		copy.second = part.second
		copy.preview = part.preview
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
			frame = view.frame, band = view.band, foot = view.foot, railOver = view.railOver, close = view.close, iron = view.iron, worded = view.worded }
	end
	-- its rows, as the editor works them out too (its rowLayout, ResolveRow's)
	local rows = {}
	for i, row in ipairs(window.rows or {}) do
		rows[i] = { name = row.name, parts = row.members, fit = row.fit or "fill", spacing = row.spacing, gap = RowGap(), on = row.on,
			left = row.left, right = row.right, y = row.y, point = PointOf("left", row.line), relPoint = PointOf("left", row.to) }
	end
	export.windows[title] = { checked = seen.checked, rect = seen.rect, window = seen.window, parts = parts,
		art = Pictures(first), file = window.file, views = views[1] and views or nil, rows = rows[1] and rows or nil }
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
