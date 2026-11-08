-- The windows' controls (windows.lua's kit): the close button in its socket,
-- dropdowns, edit boxes, check boxes, the band's texts and flat red buttons.
local _, Engine = ...
local Module = Engine:GetModule("Blizzard: Windows")

-- Lua and WoW API
local _G = _G
local ipairs = ipairs
local math_min = math.min
local pairs = pairs
local select = select
local type = type
local unpack = unpack
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local Private = Module.Private
local NameFor = Private.NameFor
local Gradient = Private.Gradient
local Drop = Private.Drop
local UpdateLit = Private.UpdateLit

-- A close button (UIPanelCloseButton's) as Diablo III's, in a socket of
-- `window`'s iron frame at its top right corner: lit under the mouse,
-- darker pressed. (`header` is the band's, kept for its callers.)
Module.StyleClose = function(self, button, window, header)
	button.DiabolicStyle = "CloseButton"
	local spec = Module.config.close
	self:SkinClose(button)
	if not window.DiabolicSocket then
		window.DiabolicSocket = self:CreateSocket(window)
	end
	window.DiabolicClose = button
	button:ClearAllPoints()
	button:SetPoint("CENTER", window, "TOPRIGHT", -spec.socket_size / 2, -spec.socket_size / 2 - Drop(window))
	-- over its socket, again as the window shows: a toplevel one (the
	-- achievements') is raised then, its X put back under the socket
	local Raise = function()
		button:SetFrameLevel(window.Border:GetFrameLevel() + 2)
	end
	Raise()
	window:HookScript("OnShow", Raise)
end

-- The close button's socket, over the window's iron: the window's left
-- edge (its file's first eighth) on its left, and again on its side along
-- its bottom, outside down, so both bars are lit as the window's sides,
-- the two mitred in its corner; black inside the window's iron, its top and right ends cut at the middle
-- of that iron.
Module.CreateSocket = function(self, window)
	local spec, edge = Module.config.close, Module.config.backdrop.edgeSize
	local file = Module.config.backdrop.edgeFile
	local size = spec.socket_size - spec.socket_inset
	local socket = CreateFrame("Frame", NameFor(window, "Socket"), window)
	socket:SetFrameLevel(window.Border:GetFrameLevel() + 1)
	socket:SetSize(size, size)
	socket:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.socket_inset, -spec.socket_inset - Drop(window))
	local fill = socket:CreateTexture(nil, "BACKGROUND")
	fill:SetTexture(unpack(spec.socket_color))
	-- the black from the window's iron's inner edge: its iron over it shows
	local inner = Module.config.backdrop.insets.top - spec.socket_inset
	fill:SetPoint("TOPLEFT", socket, "TOPLEFT", spec.socket_inset, -inner)
	fill:SetPoint("BOTTOMRIGHT", socket, "BOTTOMRIGHT", -inner, spec.socket_inset)
	local left = socket:CreateTexture(nil, "BORDER")
	left:SetTexture(file)
	left:SetTexCoord(0, 1/8, 0, 1)
	left:SetPoint("TOPLEFT", socket, "TOPLEFT")
	left:SetSize(edge, size - edge)
	-- up to the window's iron, not over it
	local bottom = socket:CreateTexture(nil, "BORDER")
	bottom:SetTexture(file)
	bottom:SetTexCoord(1/8, 0, 0, 0, 1/8, 1, 0, 1)
	bottom:SetPoint("BOTTOMRIGHT", socket, "BOTTOMRIGHT", -inner, 0)
	bottom:SetSize(size - edge - inner, edge)
	local corner = socket:CreateTexture(nil, "BORDER")
	corner:SetTexture(spec.socket_corner)
	corner:SetPoint("BOTTOMLEFT", socket, "BOTTOMLEFT")
	corner:SetSize(edge, edge)
	for _, texture in ipairs({ left, bottom, corner }) do
		texture:SetVertexColor(unpack(Module.config.backdrop_border_color))
	end
	return socket
end

-- The close button's look alone, for windows of our own (loot, rolls).
Module.SkinClose = function(self, button)
	local spec = Module.config.close
	button:SetSize(spec.size, spec.size)
	button:SetNormalTexture(spec.texture.normal)
	button:SetPushedTexture(spec.texture.pushed)
	button:SetDisabledTexture(spec.texture.normal)
	button:SetHighlightTexture(spec.texture.lit)
	button:GetHighlightTexture():SetBlendMode("BLEND")
	button:GetDisabledTexture():SetDesaturated(true)
	for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
		texture:SetTexCoord(unpack(spec.texcoords))
		texture:ClearAllPoints()
		texture:SetAllPoints()
	end
end

-- The dropdowns' and edit boxes' field (dropdown.field): dark stone in a
-- bronze border two lines thick, bevelled (lit from the top left) and
-- brightest in each side's middle, `inset` in from `plate`'s ends; drawn by
-- `owner` (under its text: a child frame would cover it).
local FIELD_SEGMENTS = {
	-- each side in two halves (fading to its ends): its light, how it
	-- fades, its two points (on the stone's), inwards, the end on its
	-- gradient's low side
	{ "light", "HORIZONTAL", "TOPLEFT", "TOPLEFT", "TOPRIGHT", "TOP", 0, -1, true },
	{ "light", "HORIZONTAL", "TOPLEFT", "TOP", "TOPRIGHT", "TOPRIGHT", 0, -1, false },
	{ "dark", "HORIZONTAL", "BOTTOMLEFT", "BOTTOMLEFT", "BOTTOMRIGHT", "BOTTOM", 0, 1, true },
	{ "dark", "HORIZONTAL", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT", "BOTTOMRIGHT", 0, 1, false },
	{ "light", "VERTICAL", "TOPLEFT", "TOPLEFT", "BOTTOMLEFT", "LEFT", 1, 0, false },
	{ "light", "VERTICAL", "TOPLEFT", "LEFT", "BOTTOMLEFT", "BOTTOMLEFT", 1, 0, true },
	{ "dark", "VERTICAL", "TOPRIGHT", "TOPRIGHT", "BOTTOMRIGHT", "RIGHT", -1, 0, false },
	{ "dark", "VERTICAL", "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "BOTTOMRIGHT", -1, 0, true }
}
local Field = function(plate, inset, owner)
	local spec = Module.config.dropdown.field
	local fill = owner:CreateTexture(nil, "BACKGROUND")
	fill:SetTexture(spec.stone)
	fill:SetTexCoord(unpack(spec.stone_coords))
	fill:SetPoint("TOPLEFT", plate, "TOPLEFT", inset, 0)
	fill:SetPoint("BOTTOMRIGHT", plate, "BOTTOMRIGHT", -inset, 0)
	local lines = { fill }
	-- (the outer line over the inner at the corners)
	for depth, look in ipairs({ { spec.line_color, "ARTWORK" }, { spec.line_dark, "BORDER" } }) do
		for _, segment in ipairs(FIELD_SEGMENTS) do
			local light = spec.bevel[segment[1]]
			local r, g, b = math_min(1, look[1][1] * light), math_min(1, look[1][2] * light), math_min(1, look[1][3] * light)
			local ends = spec.sheen_ends
			local line = owner:CreateTexture(nil, look[2])
			line:SetTexture(spec.texture)
			local x, y = segment[7] * (depth - 1), segment[8] * (depth - 1)
			line:SetPoint(segment[3], fill, segment[4], x, y)
			line:SetPoint(segment[5], fill, segment[6], x, y)
			if (segment[2] == "HORIZONTAL") then
				line:SetHeight(1)
			else
				line:SetWidth(1)
			end
			if segment[9] then
				Gradient(line, segment[2], r * ends, g * ends, b * ends, 1, r, g, b, 1)
			else
				Gradient(line, segment[2], r, g, b, 1, r * ends, g * ends, b * ends, 1)
			end
			lines[#lines + 1] = line
		end
	end
	return lines
end

-- A dropdown's menu (its first level) as wide as its field at least, its
-- lines too (Blizzard's as wide as the widest of them).
local FitMenu = function(level, _, dropdown)
	local list, plate = _G.DropDownList1, dropdown and dropdown.DiabolicPlate
	if ((level or 1) ~= 1) or (type(plate) ~= "table") or (not list:IsShown()) then
		return
	end
	local inset = dropdown.DiabolicInset or Module.config.dropdown.inset
	local width = (plate:GetWidth() - inset * 2) * plate:GetEffectiveScale() / list:GetEffectiveScale()
	if (list:GetWidth() < width) then
		list:SetWidth(width)
		for i = 1, list.numButtons or 0 do
			_G["DropDownList1Button" .. i]:SetWidth(width - 25) -- (Blizzard's: the list 25 wider)
		end
	end
end
local MenusFitted

-- A dropdown (UIDropDownMenuTemplate's, or one drawn like it) in Diablo III's
-- field, its own art out of sight; `offset` moves the plate up where its
-- text sits above its frame's middle, `inset` is how far in from its sides
-- the field is drawn (the template's own by default).
Module.StyleDropDown = function(self, frame, offset, inset)
	frame.DiabolicStyle = "DropDown"
	local name = frame:GetName()
	-- as wide as its art first: one never sized (Auctionator's,
	-- Overachiever's) is narrower, its art reaching past it
	local middle = name and _G[name .. "Middle"]
	if middle and (frame:GetWidth() < middle:GetWidth()) then
		_G.UIDropDownMenu_SetWidth(frame, middle:GetWidth())
	end
	for _, part in ipairs({ "Left", "Middle", "Right" }) do
		local region = name and _G[name .. part]
		if region then
			region:SetAlpha(0)
		end
	end
	local spec = Module.config.dropdown
	frame.DiabolicInset = inset
	frame.DiabolicDropDown = true
	local plate = CreateFrame("Frame", NameFor(frame, "DiabolicField"), frame)
	plate:SetPoint("LEFT", 0, offset or 0)
	plate:SetPoint("RIGHT", 0, offset or 0)
	plate:SetHeight(spec.height)
	Field(plate, inset or spec.inset, frame)
	frame.DiabolicPlate = plate -- (raised with it: LineBand)
	if not MenusFitted then
		MenusFitted = true
		hooksecurefunc("ToggleDropDownMenu", FitMenu)
	end
	-- its button Diablo III's, inside the field's right end, top and bottom
	local button = name and _G[name .. "Button"]
	if button then
		local arrow = spec.arrow
		button:SetSize(spec.arrow_size, spec.arrow_size)
		button:ClearAllPoints()
		button:SetPoint("RIGHT", plate, "RIGHT", -(inset or spec.inset) - spec.arrow_inset, 0)
		button:SetNormalTexture(arrow.normal)
		button:SetPushedTexture(arrow.pushed)
		button:SetDisabledTexture(arrow.normal)
		button:SetHighlightTexture(arrow.lit)
		button:GetHighlightTexture():SetBlendMode("BLEND")
		button:GetDisabledTexture():SetDesaturated(true)
		for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
			texture:SetTexCoord(unpack(spec.arrow_texcoords))
			texture:ClearAllPoints()
			texture:SetAllPoints()
		end
		-- its text from the plate's left, up to the arrow (Blizzard's
		-- reaches under it, right-aligned)
		local text = _G[name .. "Text"]
		if text then
			text:ClearAllPoints()
			text:SetPoint("LEFT", plate, "LEFT", (inset or spec.inset) + spec.text_padding, 0)
			text:SetPoint("RIGHT", button, "LEFT", -spec.arrow_gap, 0)
			text:SetJustifyH("LEFT")
		end
	end
end

-- An edit box (InputBoxTemplate's, or drawn like it: a search) in the
-- dropdowns' field, its own art out of sight; the field `edit_padding`
-- past its sides, around its text.
Module.StyleEditBox = function(self, box)
	box.DiabolicStyle = "EditBox"
	local name = box:GetName()
	for _, part in ipairs({ "Left", "Middle", "Right" }) do
		local region = name and _G[name .. part]
		if region then
			region:SetAlpha(0)
		end
	end
	local spec = Module.config.dropdown
	box.DiabolicOutset = Module.config.edit_padding
	local plate = CreateFrame("Frame", NameFor(box, "DiabolicField"), box)
	plate:SetPoint("LEFT", -Module.config.edit_padding, 0)
	plate:SetPoint("RIGHT", Module.config.edit_padding, 0)
	plate:SetHeight(spec.height)
	return Field(plate, 0, box)
end

-- A checkbox (OptionsCheckButtonTemplate's) as Diablo III's: its dark box
-- in a bronze frame, the frame lit under the mouse, its orange X checked;
-- its label (Blizzard's "Text") right of it in the title's gold; its size
-- and its label's font `look`'s (check_box.stacked) if not check_box's.
Module.StyleCheckBox = function(self, button, look)
	button.DiabolicStyle = "CheckBox"
	local spec = Module.config.check_box
	look = look or spec
	button:SetSize(look.size, look.size)
	button:SetNormalTexture(spec.texture)
	button:SetPushedTexture(spec.texture)
	button:SetHighlightTexture(spec.texture)
	button:SetCheckedTexture(spec.texture)
	button:SetDisabledCheckedTexture(spec.texture)
	button:GetNormalTexture():SetTexCoord(unpack(spec.box))
	local pushed = button:GetPushedTexture()
	pushed:SetTexCoord(unpack(spec.box))
	pushed:SetVertexColor(unpack(spec.pushed_color))
	local lit = button:GetHighlightTexture()
	lit:SetTexCoord(unpack(spec.lit))
	lit:SetBlendMode("ADD")
	button:GetCheckedTexture():SetTexCoord(unpack(spec.checked))
	local disabled = button:GetDisabledCheckedTexture()
	disabled:SetTexCoord(unpack(spec.checked))
	disabled:SetDesaturated(true)
	local label = _G[button:GetName() .. "Text"]
	button.DiabolicLabel = label
	if label then
		self:StyleBandText(label)
		label:SetFontObject(look.font)
		label:ClearAllPoints()
		label:SetPoint("LEFT", button, "RIGHT", spec.label_gap, 0)
	end
end

-- How far in from a band control's sides its art is drawn (a dropdown's
-- plate), negative out past them (an edit box's plate, a checkbox's
-- label): left, right.
local ArtInsets = function(part)
	local name = part:GetName()
	if name and _G[name .. "Button"] and _G[name .. "Middle"] then
		local inset = part.DiabolicInset or Module.config.dropdown.inset
		return inset, inset
	elseif part.DiabolicOutset then
		return -part.DiabolicOutset, -part.DiabolicOutset
	elseif part.DiabolicLabel then
		return 0, -(Module.config.check_box.label_gap + part.DiabolicLabel:GetStringWidth())
	end
	return 0, 0
end
Module.ArtInsets = ArtInsets

-- `text` (a font string, an edit box's) in the band's look: a label in
-- the title's gold, `value` (what's typed or chosen) in white.
Module.StyleBandText = function(self, text, value)
	local spec = Module.config.band_text
	text:SetFontObject(value and spec.value_font or spec.label_font)
	text:SetTextColor(unpack(value and spec.value or spec.label))
	text:SetShadowColor(0, 0, 0, 1)
	text:SetShadowOffset(1, -1)
end

-- A button's text (a list's All) as a band's label: the bands' font, in
-- the title's gold, hovered or not.
Module.StyleLabelButton = function(self, button)
	if button then
		button:SetNormalFontObject(Module.config.band_text.label_button_font)
		button:SetHighlightFontObject(Module.config.band_text.label_button_font)
	end
end

-- `parts` (controls, texts) in a row along `header`'s band from its left:
-- the first from its end, their art
-- window.layout.band_gap apart, each placed on the one before it (moved
-- as it's resized); `fromRight`: from its right end instead (short of the
-- X's socket), the last part rightmost. Dropdowns over the window's frame;
-- their texts, the boxes' and the labels in the band's (StyleBandText).
Module.LineBand = function(self, header, parts, fromRight)
	local layout = Module.config.layout
	local level = header:GetParent():GetFrameLevel() + 4
	local previous, previousInset
	for i = fromRight and #parts or 1, fromRight and 1 or #parts, fromRight and -1 or 1 do
		local part = parts[i]
		if part:IsObjectType("FontString") then
			part:SetWidth(0) -- (as wide as its text)
			self:StyleBandText(part)
		elseif part:IsObjectType("EditBox") then
			self:StyleBandText(part, true)
		end
		local left, right = ArtInsets(part)
		part:ClearAllPoints()
		if fromRight and previous then
			part:SetPoint("RIGHT", previous, "LEFT", previousInset - layout.band_gap + right, 0)
		elseif fromRight then
			part:SetPoint("RIGHT", header, "RIGHT", right - layout.band_right_edge, 0)
		elseif previous then
			part:SetPoint("LEFT", previous, "RIGHT", layout.band_gap - previousInset - left, 0)
		else
			part:SetPoint("LEFT", header, "LEFT", layout.band_edge - left, 0)
		end
		previous, previousInset = part, fromRight and left or right
		local name = part:GetName()
		-- (a dropdown: ours, or Blizzard's with its art, some without)
		if name and _G[name .. "Button"] and (part.DiabolicDropDown or _G[name .. "Middle"]) then
			if _G[name .. "Text"] then
				self:StyleBandText(_G[name .. "Text"], true)
			end
			-- (its plate first, under it: a child keeps its own level)
			for _, piece in ipairs({ part.DiabolicPlate or false, part, _G[name .. "Button"], _G[name .. "MouseOver"] or false }) do
				if piece then
					piece:SetFrameLevel(level)
					level = level + 1
				end
			end
		end
	end
end

-- A push button (UIPanelButtonTemplate's) as a flat red one, `height`
-- high: lit under the mouse, dark while disabled.
Module.StyleButton = function(self, button, height)
	button.DiabolicStyle = "Button"
	for _, texture in ipairs({ button:GetNormalTexture() or false, button:GetPushedTexture() or false,
		button:GetDisabledTexture() or false, button:GetHighlightTexture() or false }) do
		if texture then
			texture:SetAlpha(0)
		end
	end
	local spec = Module.config.rect_button
	local normal = self:CreateSlices(button, "BACKGROUND", spec, spec.texture.normal, height)
	local dark = self:CreateSlices(button, "BACKGROUND", spec, spec.texture.dark, height)
	button.DiabolicNotLit = function() return button:IsEnabled() == 0 end
	self:AddLit(button, self:CreateSlices(button, "BORDER", spec, spec.texture.lit, height))
	local update = function()
		if (button:IsEnabled() == 0) then
			normal:Hide()
			dark:Show()
		else
			normal:Show()
			dark:Hide()
		end
		UpdateLit(button)
		-- its text grey while disabled, back to its own color once enabled
		-- (a color set on the text stays until another is)
		local text = button:GetFontString()
		if text then
			text:SetTextColor(unpack((button:IsEnabled() == 0) and Module.config.button_disabled_color or Module.config.button_text_color))
		end
	end
	hooksecurefunc(button, "Enable", update)
	hooksecurefunc(button, "Disable", update)
	self:SetButtonFont(button, Module.config.button_font)
	update()
end

-- `frame`'s own close button, an unnamed child (Blizzard's panel close).
Module.FindClose = function(self, frame)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		local texture = child:IsObjectType("Button") and child:GetNormalTexture()
		local file = texture and texture:GetTexture()
		if file and file:lower():find("ui%-panel%-minimizebutton") then
			return child
		end
	end
end

-- Page buttons (back, on) as the scroll bars' arrows, turned to point
-- left and right.
Module.StylePager = function(self, prev, nextPage)
	local spec = Module.config.scrollbar
	local left, right, top, bottom = unpack(spec.arrow_texcoords)
	for button, art in pairs({ [prev] = spec.up, [nextPage] = spec.down }) do
		button:SetSize(Module.config.pager_size, Module.config.pager_size)
		button:SetNormalTexture(art.normal)
		button:SetPushedTexture(art.lit)
		button:SetDisabledTexture(art.disabled)
		button:SetHighlightTexture(art.lit)
		button:GetHighlightTexture():SetBlendMode("BLEND")
		for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
			-- (a quarter turn: the art's top on the left)
			texture:SetTexCoord(right, top, left, top, right, bottom, left, bottom)
			texture:ClearAllPoints()
			texture:SetAllPoints()
		end
	end
end

-- `font` in all of a button's states.
Module.SetButtonFont = function(self, button, font)
	button:SetNormalFontObject(font)
	button:SetHighlightFontObject(font)
	button:SetDisabledFontObject(font)
	if (button:IsEnabled() == 0) and button:GetFontString() then
		button:GetFontString():SetTextColor(unpack(Module.config.button_disabled_color))
	end
end

-- The action buttons' border (made for 44px ones) around a `size` button.
Module.AddBorder = function(self, button, size)
	local spec = Module.config.button_border
	local scale = size / 44
	local border = button:CreateTexture(nil, "OVERLAY")
	border:SetTexture(spec.texture)
	border:SetSize(spec.size[1] * scale, spec.size[2] * scale)
	border:SetPoint("TOPLEFT", spec.offset[1] * scale, spec.offset[2] * scale)
	return border
end
