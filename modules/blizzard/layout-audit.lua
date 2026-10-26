-- /dui layout: checks the windows shown against the layout's rules
-- (windows.lua, settings/blizzard.lua window.layout) and says in the chat
-- what breaks them: buttons on a row too close, a button's text wider
-- than it, the band's controls over each other (or over its medallion,
-- the title, the X), parts out of the window, the content too close to
-- the band (or the tabs under it) or the foot, or its room over and under
-- it uneven, or left and right of it; its zones too close; a dropdown
-- not Diablo III's; light text on parchment. While it's on, each window is checked as it shows and each
-- second (for its pages), each problem said once; typed again, it stops.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Layout Audit", "LOW")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local math_abs = math.abs
local math_floor = math.floor
local math_huge = math.huge
local pcall = pcall
local math_max = math.max
local math_min = math.min
local select = select
local string_find = string.find
local string_format = string.format
local tonumber = tonumber
local table_sort = table.sort

-- WoW API
local CreateFrame = _G.CreateFrame
local GetChatWindowInfo = _G.GetChatWindowInfo

local kit, layout
local Said, Fine -- problems already said (by text), windows found right (by frame)

-- In a chat window named Layout if there's one (its own tab), else the main one.
local Print = function(text)
	local frame = _G.DEFAULT_CHAT_FRAME
	for i = 1, _G.NUM_CHAT_WINDOWS do
		if (GetChatWindowInfo(i) == L["Layout"]) then
			frame = _G["ChatFrame" .. i]
			break
		end
	end
	frame:AddMessage("|cffff8000DiabolicUI|r " .. text)
end

-- What a part is called in the chat: its text, else its name.
local Named = function(part)
	local text = part.GetText and part:GetText()
	if text and (text ~= "") and (not string_find(text, "|")) then
		return "\"" .. text .. "\""
	end
	return part:GetName() or L["a part"]
end

-- `part` in `ancestor`'s (a text in its frame, a button in its dropdown).
local IsIn = function(part, ancestor)
	local parent = part:GetParent()
	while parent do
		if (parent == ancestor) then
			return true
		end
		parent = parent:GetParent()
	end
end

-- A control drawn by us or Blizzard: a button with art or text, an edit
-- box, a dropdown (not the empty frames laid over them to click).
-- A dropdown (UIDropDownMenuTemplate's: a frame with its art and its
-- button), not a status bar named the same way.
local IsDropDown = function(frame)
	local name = frame:GetName()
	return name and (frame:GetObjectType() == "Frame") and _G[name .. "Button"] and _G[name .. "Middle"] and true
end

local IsControl = function(frame)
	local name = frame:GetName()
	if IsDropDown(frame) then
		return true
	end
	if frame:IsObjectType("EditBox") then
		return true
	end
	if frame:IsObjectType("Button") then
		return frame.DiabolicStyled or frame:GetNormalTexture() or (((frame:GetText()) or "") ~= "")
	end
end

-- The controls and texts shown in `frame` and all it holds, not in `skip`
-- (the window: its own parts are the rules').
local Collect
Collect = function(frame, skip, controls, texts)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("FontString") and region:IsVisible() and (region:GetAlpha() > 0) and ((region:GetText() or "") ~= "") then
			texts[#texts + 1] = region
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if (child ~= skip) and child:IsVisible() and (child:GetAlpha() > 0) then
			if IsControl(child) and child:GetLeft() then
				controls[#controls + 1] = child
			end
			Collect(child, skip, controls, texts)
		end
	end
end

-- Where a part's art is (a text's letters, a dropdown's plate): left,
-- bottom, right, top on screen.
local Box = function(part)
	local left, bottom, right, top = kit.Edges(part)
	if not left then
		return
	end
	local scale = kit.ScaleOf(part)
	if part:IsObjectType("FontString") then
		-- (a wrapped one's string width is its one line's: its box's at most)
		local width, justify = math_min(part:GetStringWidth() * scale, right - left), part:GetJustifyH()
		if (justify == "LEFT") then
			right = left + width
		elseif (justify == "RIGHT") then
			left = right - width
		else
			local middle = (left + right) / 2
			left, right = middle - width / 2, middle + width / 2
		end
	elseif part.IsObjectType and part:IsObjectType("Frame") then
		local inLeft, inRight = kit.ArtInsets(part)
		left, right = left + inLeft * scale, right - inRight * scale
	end
	return left, bottom, right, top
end

-- How much two boxes overlap, the lesser way (0 if they don't).
local Overlap = function(a, b)
	local across = math_min(a[3], b[3]) - math_max(a[1], b[1])
	local up = math_min(a[4], b[4]) - math_max(a[2], b[2])
	return math_max(0, math_min(across, up))
end

local Checks = {}

-- Buttons on a row closer than the rule, a button's text wider than it.
Checks.Rows = function(window, say, scale)
	local buttons = kit.CollectShown(window.Frame, {})
	table_sort(buttons, function(a, b) return (kit.Edges(a)) < (kit.Edges(b)) end)
	for i, button in ipairs(buttons) do
		if (button:GetTextWidth() > button:GetWidth() - 2) then
			say(L["%s's text is wider than it."], Named(button))
		end
		local _, bottom, right, top = kit.Edges(button)
		for j = i + 1, #buttons do
			local other = buttons[j]
			local left, otherBottom, _, otherTop = kit.Edges(other)
			if (math_abs((otherBottom + otherTop - bottom - top) / 2) <= 2) then
				local apart = (left - right) / scale
				if (apart < layout.button_gap - .5) then
					say(L["%s and %s are %d apart on their row (the rule: %d)."], Named(button), Named(other), math_floor(apart + .5), layout.button_gap)
				end
				break
			end
		end
	end
end

-- The band's controls and texts over each other, its medallion, the
-- title, the X.
Checks.Band = function(window, say, scale, controls, texts)
	local header = window.DiabolicHeaders[1]
	local _, bandBottom, _, bandTop = kit.Edges(header)
	local parts = {}
	local Add = function(part, name)
		local left, bottom, right, top = Box(part)
		if left and ((bottom + top) / 2 > bandBottom) and ((bottom + top) / 2 < bandTop) then
			parts[#parts + 1] = { left, bottom, right, top, part = part, name = name or Named(part) }
		end
	end
	for _, list in ipairs({ controls, texts }) do
		for _, part in ipairs(list) do
			Add(part)
		end
	end
	for i = 1, select("#", header:GetRegions()) do
		local region = select(i, header:GetRegions())
		if region:IsObjectType("FontString") and region:IsVisible() and ((region:GetText() or "") ~= "") then
			Add(region)
		end
	end
	if header.DiabolicMedallion then
		Add(header.DiabolicMedallion, L["the medallion"])
	end
	if window.DiabolicClose and window.DiabolicClose:IsVisible() then
		Add(window.DiabolicClose)
	end
	for i, a in ipairs(parts) do
		for j = i + 1, #parts do
			local b = parts[j]
			if (a.part ~= b.part) and (not IsIn(a.part, b.part)) and (not IsIn(b.part, a.part)) and (Overlap(a, b) > 1) then
				say(L["%s and %s overlap in the band."], a.name, b.name)
			end
		end
	end
end

-- `part` on a tab hanging from the foot (a banner), in a scroll frame
-- (clipped: what's past it isn't seen), a tooltip or a frame mostly
-- beside the window (a popup by it: the guild's info, a member's card).
local IsHung = function(part, holder, left, bottom, right, top)
	local frame = part
	while frame and (frame ~= holder) do
		if frame.DiabolicBanner or frame:IsObjectType("ScrollFrame") or (frame:GetFrameStrata() == "TOOLTIP") then
			return true
		end
		if (frame ~= part) and frame:IsObjectType("Frame") then
			local frameLeft, frameBottom, frameRight, frameTop = kit.Edges(frame)
			local x, y = frameLeft and (frameLeft + frameRight) / 2, frameLeft and (frameBottom + frameTop) / 2
			if x and ((x > right) or (x < left) or (y < bottom) or (y > top)) then
				return true
			end
		end
		frame = frame:GetParent()
	end
end

-- Parts past the window's sides (not its tabs, nor a scroll frame's,
-- nor its X in the iron's corner).
Checks.Inside = function(window, say, scale, controls, texts)
	local left, bottom, right, top = kit.Edges(window)
	for _, list in ipairs({ controls, texts }) do
		for _, part in ipairs(list) do
			if (not IsHung(part, window.Frame, left, bottom, right, top)) and (part ~= window.DiabolicClose) then
				local box = { Box(part) }
				if box[1] and ((box[1] < left - 1) or (box[3] > right + 1) or (box[2] < bottom - 1) or (box[4] > top + 1)) then
					say(L["%s is out of the window."], Named(part))
				end
			end
		end
	end
end

-- The content's zones and parchments shown in `frame` and all it holds.
local CollectContent
CollectContent = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsVisible() then
			if child.DiabolicContent then
				found[#found + 1] = child
			end
			CollectContent(child, found)
		end
	end
	return found
end

-- A zone named after the frame it's around (or what that's on).
local ZoneName = function(zone)
	local frame = zone
	for _ = 1, 3 do
		local _, relative = frame:GetPoint()
		if (not relative) then
			break
		end
		if relative:GetName() then
			return relative:GetName()
		end
		frame = relative
	end
	return L["a part"]
end

-- The room over the content (under the band, or the tabs under it) and
-- under it (over the foot): at least the rule's, and even.
Checks.Room = function(window, say, scale, controls, texts)
	local content = CollectContent(window.Frame, {})
	if (#content == 0) then
		return
	end
	local top, bottom, topZone, bottomZone = -math_huge, math_huge
	for _, zone in ipairs(content) do
		local _, zoneBottom, _, zoneTop = kit.Edges(zone)
		if (zoneTop > top) then
			top, topZone = zoneTop, zone
		end
		if (zoneBottom < bottom) then
			bottom, bottomZone = zoneBottom, zone
		end
	end
	local _, above = kit.Edges(window.DiabolicHeaders[1])
	local aboveName = L["the band"]
	for _, list in ipairs({ controls, texts }) do
		for _, part in ipairs(list) do
			local _, partBottom, _, partTop = Box(part)
			if partBottom and (partBottom >= top - 1) and (partTop <= above + 1) and (partBottom < above) then
				above, aboveName = partBottom, Named(part)
			end
		end
	end
	local over = math_floor((above - top) / scale + .5)
	local foot = window.DiabolicFoot
	local under
	if foot and foot.DiabolicShown then
		-- (or the highest part between: the letter's attachments, money)
		local _, _, _, below = kit.Edges(foot)
		for _, list in ipairs({ controls, texts }) do
			for _, part in ipairs(list) do
				local _, partBottom, _, partTop = Box(part)
				if partTop and (partTop <= bottom + 1) and (partBottom >= below - 1) and (partTop > below) then
					below = partTop
				end
			end
		end
		under = math_floor((bottom - below) / scale + .5)
	end
	if (over < layout.content_gap) then
		say(L["%s is %d under %s (the rule: at least %d)."], ZoneName(topZone), over, aboveName, layout.content_gap)
	end
	if under and (under < layout.content_gap) then
		say(L["%s is %d over the foot (the rule: at least %d)."], ZoneName(bottomZone), under, layout.content_gap)
	end
	if under and (math_abs(over - under) > layout.uneven) then
		say(L["%d of room over the content, %d under it: uneven."], over, under)
	end
end

-- The content's zones not around another (what's seen: a parchment, not
-- the panel under it).
local Innermost = function(content)
	local found = {}
	for _, zone in ipairs(content) do
		local left, bottom, right, top = kit.Edges(zone)
		local outer = not left -- (one not placed: none)
		for _, other in ipairs(left and content or {}) do
			if (other ~= zone) then
				local otherLeft, otherBottom, otherRight, otherTop = kit.Edges(other)
				if otherLeft and (otherLeft >= left - 1) and (otherRight <= right + 1) and (otherBottom >= bottom - 1) and (otherTop <= top + 1) then
					outer = true
					break
				end
			end
		end
		if (not outer) then
			found[#found + 1] = zone
		end
	end
	return found
end

-- The visible scroll bars in `frame` and all it holds.
local CollectBars
CollectBars = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsVisible() then
			if child:IsObjectType("Slider") then
				found[#found + 1] = child
			end
			CollectBars(child, found)
		end
	end
	return found
end

-- As much room left of the content (its zones, scroll bars, and the
-- controls and texts beside them) as right of it.
Checks.Sides = function(window, say, scale, controls, texts)
	local content = CollectContent(window.Frame, {})
	if (#content == 0) then
		return
	end
	local left, right, top, bottom = math_huge, -math_huge, -math_huge, math_huge
	local Reach = function(part)
		local partLeft, _, partRight = kit.Edges(part)
		if partLeft then
			left, right = math_min(left, partLeft), math_max(right, partRight)
		end
	end
	for _, zone in ipairs(content) do
		Reach(zone)
		local _, zoneBottom, _, zoneTop = kit.Edges(zone)
		if zoneBottom then
			top, bottom = math_max(top, zoneTop), math_min(bottom, zoneBottom)
		end
	end
	local windowLeft, windowBottom, windowRight, windowTop = kit.Edges(window)
	-- (those level with the zones: not the band's, nor the foot's)
	for _, list in ipairs({ controls, texts }) do
		for _, part in ipairs(list) do
			local partLeft, partBottom, partRight, partTop = Box(part)
			if partLeft and ((partBottom + partTop) / 2 < top) and ((partBottom + partTop) / 2 > bottom)
				and (not IsHung(part, window.Frame, windowLeft, windowBottom, windowRight, windowTop)) then
				left, right = math_min(left, partLeft), math_max(right, partRight)
			end
		end
	end
	for _, bar in ipairs(CollectBars(window.Frame, {})) do
		if (not IsHung(bar, window.Frame, windowLeft, windowBottom, windowRight, windowTop)) then
			Reach(bar)
			for i = 1, select("#", bar:GetChildren()) do
				Reach((select(i, bar:GetChildren())))
			end
		end
	end
	local before = math_floor((left - windowLeft) / scale + .5)
	local after = math_floor((windowRight - right) / scale + .5)
	if (math_abs(before - after) > layout.uneven) then
		say(L["%d of room left of the content, %d right of it: uneven."], before, after)
	end
end

-- The content's zones apart by the rule's at least (not over each other).
Checks.Gaps = function(window, say, scale)
	local zones = Innermost(CollectContent(window.Frame, {}))
	for i, a in ipairs(zones) do
		local aLeft, aBottom, aRight, aTop = kit.Edges(a)
		for j = i + 1, #zones do
			local b = zones[j]
			-- (not a zone's own part: a list's bar of column names on it, nor two
			-- around the same frame: its panel, its page)
			if (not IsIn(a, b)) and (not IsIn(b, a)) and (ZoneName(a) ~= ZoneName(b)) then
				local bLeft, bBottom, bRight, bTop = kit.Edges(b)
				local across = math_max(aLeft - bRight, bLeft - aRight) / scale
				local up = math_max(aBottom - bTop, bBottom - aTop) / scale
				if (across < -1) and (up < -1) then
					say(L["%s and %s overlap by %d."], ZoneName(a), ZoneName(b), math_floor(-math_max(across, up) + .5))
				else
					local apart = math_max(across, up)
					if (apart < layout.content_gap - .5) then
						say(L["%s and %s are %d apart (the rule: at least %d)."], ZoneName(a), ZoneName(b), math_floor(apart + .5), layout.content_gap)
					end
				end
			end
		end
	end
end

-- Dropdowns still Blizzard's (or an addon's), not on Diablo III's plate.
Checks.DropDowns = function(window, say, scale, controls)
	for _, control in ipairs(controls) do
		local name = control:GetName()
		if IsDropDown(control) and (not control.DiabolicDropDown) then
			say(L["%s isn't Diablo III's."], name)
		end
	end
end

local LIGHT = { parchment = true, lined = true, page = true } -- the materials read in ink

-- `text` (its middle at `x`, `y`) on its own frame's art: a button's face
-- (ours), an icon (its count), not the page under it.
local OnArt = function(text, x, y)
	local frame = text:GetParent()
	if frame.DiabolicStyled then
		return true
	end
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") and region:IsVisible() and (region:GetAlpha() > 0) and region:GetTexture()
			and (region:GetDrawLayer() ~= "HIGHLIGHT") then
			local left, bottom, right, top = kit.Edges(region)
			if left and (x >= left) and (x <= right) and (y >= bottom) and (y <= top) then
				return true
			end
		end
	end
end

-- How light a color is, 0 to 1.
local Lightness = function(r, g, b)
	return .299 * r + .587 * g + .114 * b
end

-- Light text (its color or a color in it) on parchment, not on a chosen
-- row's copper bar.
Checks.Ink = function(window, say, scale, controls, texts)
	local pages = {}
	for _, zone in ipairs(CollectContent(window.Frame, {})) do
		if LIGHT[zone.DiabolicMaterial] then
			pages[#pages + 1] = { kit.Edges(zone) }
		end
	end
	if (#pages == 0) then
		return
	end
	local bars = {}
	for _, bar in ipairs(kit.LitRows) do
		if bar:IsVisible() then
			bars[#bars + 1] = { kit.Edges(bar) }
		end
	end
	local On = function(boxes, x, y)
		for _, box in ipairs(boxes) do
			if box[1] and (x >= box[1]) and (x <= box[3]) and (y >= box[2]) and (y <= box[4]) then
				return true
			end
		end
	end
	local first, more = nil, 0
	for _, text in ipairs(texts) do
		local left, bottom, right, top = Box(text)
		if left then
			local x, y = (left + right) / 2, (bottom + top) / 2
			if On(pages, x, y) and (not On(bars, x, y)) and (not OnArt(text, x, y)) then
				local light = Lightness(text:GetTextColor()) > .5
				for hex in (text:GetText() or ""):gmatch("|c%x%x(%x%x%x%x%x%x)") do
					light = light or (Lightness(tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255) > .5)
				end
				if light then
					if first then
						more = more + 1
					else
						first = Named(text)
					end
				end
			end
		end
	end
	if (more > 0) then
		say(L["%s and %d more are light on parchment: hard to read."], first, more)
	elseif first then
		say(L["%s is light on parchment: hard to read."], first)
	end
end

-- `window` checked: what breaks the rules said once each, or that
-- nothing does (once).
local Check = function(window)
	local frame = window.Frame
	local scale = window:GetEffectiveScale()
	local controls, texts = {}, {}
	Collect(frame, window, controls, texts)
	local found
	local say = function(text, ...)
		found = true
		local line = (frame:GetName() or L["a window"]) .. ": " .. string_format(text, ...)
		if not Said[line] then
			Said[line] = true
			Print(line)
		end
	end
	for _, name in ipairs({ "Rows", "Band", "Inside", "Room", "Sides", "Gaps", "DropDowns", "Ink" }) do
		if (name ~= "Band") or window.DiabolicHeaders[1] then
			Checks[name](window, say, scale, controls, texts)
		end
	end
	if (not found) and (not Fine[frame]) then
		Fine[frame] = true
		Print((frame:GetName() or L["a window"]) .. ": " .. L["nothing breaks the rules."])
	end
end

local CheckShown = function()
	for _, window in ipairs(kit.Windows) do
		if window.Frame:IsVisible() and window:GetLeft() then
			-- (a check that breaks said once, the others still made)
			local ok, err = pcall(Check, window)
			if (not ok) and (not Said[err]) then
				Said[err] = true
				Print(string_format(L["%s couldn't be checked: %s"], window.Frame:GetName() or L["a window"], err))
			end
		end
	end
end

Module.Toggle = function(self)
	if self.Ticker:IsShown() then
		self.Ticker:Hide()
		Print(L["Layout check off."])
		return
	end
	Said, Fine = {}, {}
	Print(L["Layout check on: each window is checked as it shows. /dui layout again to stop."])
	CheckShown()
	self.Ticker:Show()
end

Module.OnEnable = function(self)
	kit = Engine:GetModule("Blizzard: Windows")
	layout = kit.config.layout
	local ticker, elapsed = CreateFrame("Frame"), 0
	ticker:Hide()
	ticker:SetScript("OnUpdate", function(_, delta)
		elapsed = elapsed + delta
		if (elapsed >= 1) then
			elapsed = 0
			CheckShown()
		end
	end)
	self.Ticker = ticker
	self:GetHandler("ChatCommand"):Register("layout", function() self:Toggle() end)
end
