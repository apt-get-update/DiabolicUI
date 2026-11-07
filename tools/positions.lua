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
-- note at its end, its place, its size, its pin), nested in what they're placed
-- on: `parent` in an anchor is the block it's in, or an id of the file.
local ReadWindow = function(path)
	local file = assert(io.open(path))
	local text = file:read("*a")
	file:close()
	local Problem = function(name, what)
		error(path .. ": " .. name .. ": " .. what, 0)
	end
	local window, notes = { parts = {}, ghosts = {}, rows = {} }, {}
	local open = {} -- the blocks open, the window's first
	local names, raw = {}, {}
	for _, statement in ipairs(Statements(text)) do
		local kind, value = statement[1], statement[2]
		local block = open[#open]
		if (kind == "open") then
			if (not block) then
				if (value ~= "WowWindow") then
					Problem(value, "only a WowWindow of parts, WowRows and Ghosts can be read")
				end
				open[1] = window
			else
				local what = KINDS[value] and "Part" or value
				if ((what ~= "Part") and (what ~= "Ghost") and (what ~= "WowRow"))
					or (block.what == "WowRow" and (what ~= "Part")) or ((what == "Ghost") and (block ~= window)) then
					Problem(value, "only a WowWindow of parts, WowRows and Ghosts can be read")
				end
				open[#open + 1] = { notes = (#notes > 0) and notes or nil, anchors = {}, margins = {}, what = what, over = block,
					kind = KINDS[value] and value or nil }
			end
			notes = {}
		elseif (kind == "close") then
			open[#open] = nil
			if block and (block ~= window) then
				if (not block.name) then
					Problem(block.id or block.what, "a part needs a name")
				end
				names[block.id or block.name] = block.name
				if (block.what == "Part") then
					block.tail = statement.tail
					window.parts[block.name] = block
					raw[block.name] = block
					if (block.over.what == "WowRow") then
						if next(block.anchors) then
							Problem(block.name, "its row places it: no anchors")
						end
						block.over.members = block.over.members or {}
						table.insert(block.over.members, block.name)
					end
				elseif (block.what == "WowRow") then
					window.rows[#window.rows + 1] = block
				else
					window.ghosts[block.name] = { block.x, block.y, block.width, block.height }
				end
			end
		elseif (kind == "note") then
			notes[#notes + 1] = value
		elseif block then
			local key, content = value:match("^([%w%.]+)%s*:%s*(.+)$")
			if (not key) then
				Problem(value, "not a property")
			end
			local line = key:match("^anchors%.(.+)$")
			if (key == "id") then
				block.id = content
			elseif (key == "name") or (key == "kind") or (key == "text") or (key == "wowParent") or (key == "pin") or (key == "style") or (key == "fit") then
				block[key] = Unquote(content) or Problem(key, "needs a text, not " .. content)
			elseif (key == "width") or (key == "height") or (key == "x") or (key == "y") or (key == "spacing") then
				block[key] = tonumber(content) or Problem(key, "needs a number, not " .. content)
			elseif line and (block ~= window) and MARGINS[line] then
				block.margins[MARGINS[line][1]] = tonumber(content) or Problem(key, "needs a number, not " .. content)
			elseif line and (block ~= window) and (ACROSS[line] or DOWN[line]) then
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
	-- what an anchor's on: the block it's in, or an id
	local On = function(block, anchor)
		if (anchor.id == "parent") then
			return block.over.name
		end
		return names[anchor.id]
	end
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
			if (not across) or (not down) or (across.id ~= down.id) or (not On(part, across)) then
				Problem(name, "needs one anchor across and one down, on one part of this file")
			end
			part.place = { PointOf(across.line, down.line), On(part, across), PointOf(across.to, down.to),
				Offset(part.margins, across.line), Offset(part.margins, down.line) }
			part.besideOn = (across.id ~= "parent") and part.place[2] or nil
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
		local inRow = part.over.what == "WowRow" -- (its row places it)
		part.anchors, part.margins, part.id, part.width, part.height, part.over, part.what = nil, nil, nil, nil, nil, nil, nil
		if part.pin and (part.pin ~= "all") and (part.pin ~= "place") and (part.pin ~= "size") then
			Problem(name, 'its pin is "all", "place" or "size"')
		elseif ((part.pin == "all") or (part.pin == "place")) and (not part.place) and (not inRow) then
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
			or (left.id ~= right.id) or (down.id ~= left.id) or (not On(row, left)) then
			Problem(row.name, "a row goes from a part's left to its right, with one anchor down on it")
		end
		if (not row.members) or (not row.members[1]) then
			Problem(row.name, "a row needs its parts")
		elseif row.fit and (row.fit ~= "fill") and (row.fit ~= "equal") and (row.fit ~= "center") and (row.fit ~= "ends") then
			Problem(row.name, 'its fit is "fill", "equal", "center" or "ends"')
		end
		row.on, row.line, row.to = On(row, left), down.line, down.to
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
			view.rect, view.window, view.scale = Own(view.rect), Own(view.window), scale
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
-- if it's pinned; the preview has it from the scan.
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
-- (Written as any other part's place: the game has nothing new to do.)
local RowGap = function()
	for _, component in ipairs(components) do
		local rules = (component.name == "Window") and component.values.layout
		if rules and rules.button_gap then
			return rules.button_gap
		end
	end
	return 6
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
		if part.heldBy then
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

-- A part's block, what's placed on it inside it (`kids`, by what they're on).
local BUTTONS = { Button = true, CheckButton = true }
local WriteKids
local WritePart = function(out, part, kids, indent, inRow)
	for _, note in ipairs(part.notes or {}) do
		out[#out + 1] = indent .. note
	end
	local typed = part.kind and KINDS[part.kind]
	out[#out + 1] = indent .. (typed and part.kind or "Part") .. " {"
	local Set = function(key, value)
		out[#out + 1] = indent .. "    " .. key .. ": " .. value
	end
	if part.fileId then
		Set("id", part.fileId)
	end
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
	if part.place and (not inRow) and (not part.loose) then
		local place = part.place
		local on = part.besideId or "parent"
		for _, axis in ipairs({ { AcrossOf(place[1]), AcrossOf(place[3]), place[4] }, { DownOf(place[1]), DownOf(place[3]), place[5] } }) do
			Set("anchors." .. axis[1], on .. "." .. axis[2])
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
					Set("anchors." .. axis[2], on .. "." .. axis[3])
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
	WriteKids(out, kids[part.name], kids, indent .. "    ")
	out[#out + 1] = indent .. "}" .. (part.tail and (" " .. part.tail) or "")
end

-- A row as it's written: what it is, not where its parts ended up (they're in it).
local WriteRow = function(out, row, window, kids, indent)
	for _, note in ipairs(row.notes or {}) do
		out[#out + 1] = indent .. note
	end
	out[#out + 1] = indent .. "WowRow {"
	local Set = function(key, value)
		out[#out + 1] = indent .. "    " .. key .. ": " .. value
	end
	Set("name", Quote(row.name))
	if row.fit then
		Set("fit", Quote(row.fit))
	end
	if row.spacing then
		Set("spacing", Number(row.spacing))
	end
	Set("anchors.left", "parent.left")
	if (row.left ~= 0) then
		Set("anchors.leftMargin", Number(row.left))
	end
	Set("anchors.right", "parent.right")
	if (row.right ~= 0) then
		Set("anchors.rightMargin", Number(row.right))
	end
	Set("anchors." .. row.line, "parent." .. row.to)
	if (row.y ~= 0) then
		local margin = MARGIN_OF[row.line]
		Set("anchors." .. margin, Number(row.y * MARGINS[margin][2]))
	end
	for _, name in ipairs(row.members) do
		out[#out + 1] = ""
		WritePart(out, window.parts[name], kids, indent .. "    ", true)
	end
	out[#out + 1] = indent .. "}"
end

-- What's placed on something, in its block: its parts by name, then its rows.
WriteKids = function(out, these, kids, indent)
	for _, part in ipairs(these and these.parts or {}) do
		out[#out + 1] = ""
		WritePart(out, part, kids, indent)
	end
	for _, row in ipairs(these and these.rows or {}) do
		out[#out + 1] = ""
		WriteRow(out, row, these.window, kids, indent)
	end
end

local WriteWindow = function(window)
	local inFile, inRow, ghosts = { [window.name] = true }, {}, {}
	for name, part in pairs(window.parts) do
		inFile[name] = (not part.preview) or nil
	end
	for _, row in ipairs(window.rows or {}) do
		for _, name in ipairs(row.members) do
			inRow[name], inFile[name] = row, true
		end
	end
	local Note = function(on)
		if on and (not inFile[on]) then
			ghosts[on] = true
		end
	end
	for _, row in ipairs(window.rows or {}) do
		Note(row.on)
	end
	for name, part in pairs(window.parts) do
		if inFile[name] and (not inRow[name]) then
			Note(part.place and part.place[2])
		end
	end
	-- what each part is written in. (Parts placed on each other can't nest: the
	-- first of them stands in the window, not anchored, the scan placing it.)
	local Over = function(name)
		if inRow[name] then
			return inRow[name].on
		end
		local place = window.parts[name] and window.parts[name].place
		return place and place[2]
	end
	local loose = {}
	for _, name in ipairs(Sorted(window.parts)) do
		local walked, up = {}, name
		while up and (not walked[up]) and (not loose[up]) do
			walked[up] = true
			up = Over(up)
		end
		if up and walked[up] and (not loose[up]) then
			local part = window.parts[up]
			if part.pin or inRow[up] then
				error(window.name .. ": " .. up .. " is placed on what's placed on it", 0)
			end
			loose[up], part.loose = true, true
		end
	end
	-- A button next to another (coins, tabs, a list's): not in it, side by side in
	-- what that one's in. (Blizzard's anchors kept: a row would pin them.)
	local Beside = function(name)
		local part = window.parts[name]
		local on = part.place and part.place[2]
		local other = on and window.parts[on]
		if (not other) or (not BUTTONS[part.kind]) or (not BUTTONS[other.kind]) or loose[name] or inRow[on] or (not inFile[on]) then
			return false
		end
		local x, y, toX, toY = AcrossOf(part.place[1]), DownOf(part.place[1]), AcrossOf(part.place[3]), DownOf(part.place[3])
		if ((x == "left") and (toX == "right")) or ((x == "right") and (toX == "left"))
			or ((y == "top") and (toY == "bottom")) or ((y == "bottom") and (toY == "top")) then
			return true
		end
		-- (or by where the scan saw it: its middle out of that one)
		local rect, box = part.seen and part.seen.rect, other.seen and other.seen.rect
		if (not rect) or (not box) then
			return part.besideOn == on -- (no scan: as its file has it)
		end
		local midX, midY = rect[1] + rect[3] / 2, rect[2] + rect[4] / 2
		return (midX < box[1]) or (midX > box[1] + box[3]) or (midY < box[2]) or (midY > box[2] + box[4])
	end
	local kids = {}
	local Into = function(on, kind, item)
		kids[on] = kids[on] or { parts = {}, rows = {}, window = window }
		table.insert(kids[on][kind], item)
	end
	for _, name in ipairs(Sorted(window.parts)) do
		if inFile[name] and (not inRow[name]) then
			local part, up = window.parts[name], name
			if Beside(name) then
				local other = window.parts[part.place[2]]
				other.fileId = other.name:gsub("[^%w_]", "_"):gsub("^%u", string.lower)
				part.besideId = other.fileId
			end
			while Beside(up) do
				up = window.parts[up].place[2]
			end
			local top = window.parts[up]
			Into((not loose[up]) and top.place and top.place[2] or window.name, "parts", part)
		end
	end
	for _, row in ipairs(window.rows or {}) do
		Into(row.on, "rows", row)
	end
	local width, height = WindowSize(window)
	local out = { "// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part",
		"// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua (\"all\",",
		"// or only its \"place\" or its \"size\"), the others follow /dui layout's scan.",
		"import QtQuick", "", "WowWindow {",
		"    name: " .. Quote(window.name),
		"    width: " .. Number(width), "    height: " .. Number(height) }
	WriteKids(out, kids[window.name], kids, "    ")
	for _, name in ipairs(Sorted(ghosts)) do
		local x, y, w, h = GhostRect(window, name)
		out[#out + 1] = ""
		out[#out + 1] = "    Ghost {"
		for _, line in ipairs({ "name: " .. Quote(name), "x: " .. Number(x), "y: " .. Number(y), "width: " .. Number(w), "height: " .. Number(h) }) do
			out[#out + 1] = "        " .. line
		end
		WriteKids(out, kids[name], kids, "        ")
		out[#out + 1] = "    }"
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

local export = { left = layout.left, windows = {} }
for title, window in pairs(windows) do
	local parts = {}
	for name, part in pairs(window.parts) do
		local seen = part.seen or {}
		local copy = { kind = part.kind, text = part.text, parent = part.wowParent, style = part.style, place = part.place, size = part.size,
			pin = part.pin, rect = seen.rect, strata = seen.strata, level = seen.level, layer = seen.layer }
		-- (how the editor draws its text)
		for _, key in ipairs({ "color", "faded", "font", "fontSize", "justify", "justifyV", "outline", "shadow", "textWidth", "words" }) do
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
		views[#views + 1] = { key = key, label = view.label, rect = view.rect, window = view.window, scale = view.scale, art = Pictures(view.art), worded = view.worded }
	end
	-- its rows (windows/WowRow.qml works them out too, as ResolveRow does)
	local rows = {}
	for i, row in ipairs(window.rows or {}) do
		rows[i] = { name = row.name, parts = row.members, fit = row.fit or "fill", spacing = row.spacing, gap = RowGap(), on = row.on,
			left = row.left, right = row.right, y = row.y, point = PointOf("left", row.line) }
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
		end
		export.components[#export.components + 1] = { name = component.name, comment = component.comment, fields = fields }
	end
end
file = assert(io.open(JSON, "w"))
file:write(Shared.Encode(export), "\n")
file:close()
