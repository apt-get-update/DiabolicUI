--[[

	The MIT License (MIT)

	Copyright (c) 2024 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
local Addon, ns = ..., DiabolicUIMinimapNS
local MenuMod = ns:NewModule("Menu")

-- Lua API
local ipairs = ipairs
local string_format = string.format
local tonumber = tonumber

-- The 8 anchor points shown on the picker, in the same
-- layout as they sit around the rectangle (no center point).
local ANCHOR_POINTS = {
	"TOPLEFT", "TOP", "TOPRIGHT",
	"LEFT", "RIGHT",
	"BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT"
}

-- Default screen inset used when snapping to a given anchor point.
local ANCHOR_OFFSETS = {
	TOPLEFT = { 30, -30 },
	TOP = { 0, -30 },
	TOPRIGHT = { -30, -30 },
	LEFT = { 30, 0 },
	RIGHT = { -30, 0 },
	BOTTOMLEFT = { 30, 30 },
	BOTTOM = { 0, 30 },
	BOTTOMRIGHT = { -30, 30 }
}

-- Strings
local L_PARENT_CATEGORY = "DiabolicUI"
local L_MINIMAP_CATEGORY = "Minimap"
local L_TOGGLE_EDIT_MODE = "Toggle Edit Mode"
local L_SIZE_SLIDER_TOOLTIP = "Resizes the minimap."
local L_EDIT_MODE_TOOLTIP = "Left-click and drag the minimap to move it. Right-click and drag to resize it instead. An |cffffffffExit Edit Mode|r button will appear once you're done."
local L_ZONE_FADE_CHECKBOX = "Animate Zone Text"
local L_ZONE_FADE_TOOLTIP = "Fades the zone label out and back in whenever you change zones, instead of swapping it instantly."
local L_ZONE_FADE_DURATION_SLIDER = "Fade Duration"
local L_ZONE_LABEL_HEADER = "Zone Label"
local L_ANCHOR_HEADER = "Minimap Screen Anchor"
local L_ANCHOR_TOOLTIP = "Which corner or edge of the screen the minimap snaps to when moved, and which side it stays clear of when resized."

-- Styled to match how Immersion (and other AceGUI-3.0 based addons) render
-- their own options sliders: a flat backdrop-textured bar instead of
-- Blizzard's thin grooved track, a gold label, and the numeric entry box
-- centered directly underneath the slider instead of sitting beside it.
local SLIDER_BACKDROP = {
	bgFile = [[Interface\Buttons\UI-SliderBar-Background]],
	edgeFile = [[Interface\Buttons\UI-SliderBar-Border]],
	tile = true, tileSize = 8, edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}
local SLIDER_THUMB_TEXTURE = [[Interface\Buttons\UI-SliderBar-Button-Horizontal]]

local INPUT_BACKDROP = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
	tile = true, tileSize = 5, edgeSize = 1
}
local INPUT_BORDER_COLOR = { .3, .3, .3, .8 }
local INPUT_BORDER_COLOR_HOVER = { .5, .5, .5, 1 }
local LABEL_COLOR = { 1, .82, 0 }
local LABEL_COLOR_DISABLED = { .5, .5, .5 }

-- Applies the shared bar/thumb backdrop to a slider, and builds the
-- centered numeric entry box below it. Returns the input box.
local SkinDurationSlider = function(slider)
	slider:SetBackdrop(SLIDER_BACKDROP)
	slider:SetThumbTexture(SLIDER_THUMB_TEXTURE)

	local lowText, highText, labelText = _G[slider:GetName() .. "Low"], _G[slider:GetName() .. "High"], _G[slider:GetName() .. "Text"]
	lowText:SetTextColor(1, 1, 1)
	highText:SetTextColor(1, 1, 1)
	labelText:SetTextColor(unpack(LABEL_COLOR))

	local input = CreateFrame("EditBox", nil, slider:GetParent())
	input:SetSize(70, 14)
	input:SetPoint("TOP", slider, "BOTTOM", 0, -6)
	input:SetAutoFocus(false)
	input:SetJustifyH("CENTER")
	input:SetFontObject(GameFontHighlightSmall)
	input:SetMaxLetters(5)
	input:SetBackdrop(INPUT_BACKDROP)
	input:SetBackdropColor(0, 0, 0, .5)
	input:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR))
	input:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR_HOVER)) end)
	input:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR)) end)

	return input, lowText, highText, labelText
end

-- Minimap Options Panel
--------------------------------------------
-- Forward-declared so AnchorRadio_OnClick can trigger an
-- immediate refresh instead of waiting on the next OnUpdate tick.
local UpdateInfo

local EditButton_OnClick = function(self)
	local MinimapMod = ns:GetModule("Minimap")
	if (MinimapMod:IsEditModeActive()) then
		MinimapMod:ExitEditMode()
	else
		MinimapMod:EnterEditMode()
	end
end

-- Snaps the minimap to the clicked anchor point, using a
-- default screen inset for that point.
local AnchorRadio_OnClick = function(self)
	local offset = ANCHOR_OFFSETS[self.point]
	ns.db.global.minimap.storedPosition = { point = self.point, x = offset[1], y = offset[2] }
	ns:GetModule("Minimap"):UpdatePosition()
	UpdateInfo(self:GetParent():GetParent())
end

-- Applies a typed size percentage, clamped to the allowed range.
local SizeInput_Commit = function(self)
	local panel = self:GetParent()
	local value = tonumber(self:GetText())
	if (value) then
		local db = ns.Config.Minimap
		local newScale = value / 100
		if (newScale < db.MinUserScale) then
			newScale = db.MinUserScale
		elseif (newScale > db.MaxUserScale) then
			newScale = db.MaxUserScale
		end
		ns.db.global.minimap.userScale = newScale
		ns:GetModule("Minimap"):UpdateSize()

		if (panel.sizeSlider) then
			panel.sizeSlider.updatingFromCode = true
			panel.sizeSlider:SetValue(newScale * 100)
			panel.sizeSlider.updatingFromCode = false
		end
	end
	self:ClearFocus()
end

local SizeInput_OnEnterPressed = function(self)
	SizeInput_Commit(self)
end

local SizeInput_OnEscapePressed = function(self)
	self:ClearFocus()
end

local SizeInput_OnEditFocusLost = function(self)
	SizeInput_Commit(self)
end

-- Applies a dragged size percentage.
local SizeSlider_OnValueChanged = function(self, value)
	if (self.updatingFromCode) then return end

	ns.db.global.minimap.userScale = value / 100
	ns:GetModule("Minimap"):UpdateSize()

	local panel = self:GetParent()
	if (panel.sizeInput) and (not panel.sizeInput:HasFocus()) then
		panel.sizeInput:SetText(string_format("%.0f", value))
	end
end

local ZoneFadeCheckbox_OnClick = function(self)
	local checked = self:GetChecked() and true or false
	ns.db.global.minimap.zoneFadeEnabled = checked

	local panel = self:GetParent()
	panel.zoneFadeDurationSlider:SetEnabled(checked)
end

-- Builds a labeled slider + numeric input pair for a millisecond duration
-- setting, styled like Immersion's own options sliders (title above the
-- slider, low/high under its ends, the input box centered underneath).
-- Returns the slider; call slider.Refresh() to sync both widgets to the
-- current saved value (e.g. from UpdateInfo, or right after creating it),
-- and slider.SetEnabled(enabled) to grey it and its input out together.
-- anchorSpec optionally overrides the default "stack below anchorTo"
-- layout with an explicit { point, relativePoint, x, y } anchor of its own.
local CreateDurationSlider = function(panel, name, anchorTo, label, tooltipText, minMs, maxMs, getValue, setValue, anchorSpec)
	local slider = CreateFrame("Slider", name, panel, "OptionsSliderTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetWidth(160)
	slider:SetHeight(15)
	if (anchorSpec) then
		slider:SetPoint(anchorSpec[1], anchorTo, anchorSpec[2], anchorSpec[3], anchorSpec[4])
	else
		-- Always anchored to anchorTo itself (never its .input), so this
		-- slider's own left edge lines up with anchorTo's - anchoring to
		-- .input instead would misalign it, since that box is centered
		-- under the slider above it, not flush with its left edge. If
		-- anchorTo is itself a slider, though, its input box now sits
		-- below it, so the gap needs to be bigger to actually clear it.
		local gap = anchorTo.input and -50 or -30
		slider:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 0, gap)
	end
	slider:SetMinMaxValues(minMs, maxMs)
	slider:SetValueStep(10)
	_G[slider:GetName() .. "Text"]:SetText(label)
	_G[slider:GetName() .. "Low"]:SetText(minMs .. "ms")
	_G[slider:GetName() .. "High"]:SetText(maxMs .. "ms")
	slider.tooltipText = label
	slider.tooltipRequirement = tooltipText

	local input = SkinDurationSlider(slider)
	slider.input = input

	local commit = function(self)
		local value = tonumber(input:GetText())
		if (value) then
			if (value < minMs) then
				value = minMs
			elseif (value > maxMs) then
				value = maxMs
			end
			setValue(value / 1000)
			slider.updatingFromCode = true
			slider:SetValue(value)
			slider.updatingFromCode = false
		end
		input:ClearFocus()
	end
	input:SetScript("OnEnterPressed", commit)
	input:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	input:SetScript("OnEditFocusLost", commit)

	slider:SetScript("OnValueChanged", function(self, value)
		if (self.updatingFromCode) then return end
		setValue(value / 1000)
		if (not input:HasFocus()) then
			input:SetText(string_format("%.0f", value))
		end
	end)

	slider.Refresh = function()
		local ms = getValue() * 1000
		if (not input:HasFocus()) then
			input:SetText(string_format("%.0f", ms))
		end
		slider.updatingFromCode = true
		slider:SetValue(ms)
		slider.updatingFromCode = false
	end

	-- *EditBox has no Enable()/Disable() of its own in this client (only
	--  Button/CheckButton/Slider do), so it's faked here instead: block
	--  mouse and keyboard input, drop any current focus, and dim the text.
	local lowText, highText, labelText = _G[slider:GetName() .. "Low"], _G[slider:GetName() .. "High"], _G[slider:GetName() .. "Text"]
	slider.SetEnabled = function(self, enabled)
		if (enabled) then
			slider:Enable()
			input:EnableMouse(true)
			input:EnableKeyboard(true)
			input:SetTextColor(1, 1, 1)
			labelText:SetTextColor(unpack(LABEL_COLOR))
			lowText:SetTextColor(1, 1, 1)
			highText:SetTextColor(1, 1, 1)
			slider:SetAlpha(1)
			input:SetAlpha(1)
		else
			slider:Disable()
			input:ClearFocus()
			input:EnableMouse(false)
			input:EnableKeyboard(false)
			input:SetTextColor(.5, .5, .5)
			labelText:SetTextColor(unpack(LABEL_COLOR_DISABLED))
			lowText:SetTextColor(.5, .5, .5)
			highText:SetTextColor(.5, .5, .5)
			slider:SetAlpha(.5)
			input:SetAlpha(.5)
		end
	end

	return slider
end

-- Refreshes the live anchor/size/zone-fade readout.
UpdateInfo = function(panel)
	local point = ns.API.GetPosition(Minimap)
	local sizePct = ((ns.db and ns.db.global.minimap.userScale) or 1) * 100

	for anchorPoint, radio in pairs(panel.anchorRadios) do
		radio:SetChecked(anchorPoint == point)
	end

	-- Don't stomp on the user while they're actively typing in it.
	if (not panel.sizeInput:HasFocus()) then
		panel.sizeInput:SetText(string_format("%.0f", sizePct))
	end

	panel.sizeSlider.updatingFromCode = true
	panel.sizeSlider:SetValue(sizePct)
	panel.sizeSlider.updatingFromCode = false

	local zoneFadeEnabled = ns.db.global.minimap.zoneFadeEnabled
	panel.zoneFadeCheckbox:SetChecked(zoneFadeEnabled)
	panel.zoneFadeDurationSlider.Refresh()
	panel.zoneFadeDurationSlider:SetEnabled(zoneFadeEnabled)
end

local Panel_OnShow = function(panel)
	UpdateInfo(panel)
end

-- Keeps the readout live while the panel is open, in case
-- the user is resizing/moving the minimap at the same time.
local Panel_OnUpdate = function(panel, elapsed)
	panel.elapsed = (panel.elapsed or 0) + elapsed
	if (panel.elapsed < .2) then return end
	panel.elapsed = 0
	UpdateInfo(panel)
end

-- Creates the "Minimap" sub-category, nested under the existing
-- "DiabolicUI" parent category. *We don't create our own parent
-- category frame here, since DiabolicUI itself already registers
-- one - doing so ourselves would just result in a second, empty,
-- duplicate "DiabolicUI" entry in the list.
MenuMod.CreatePanel = function(self)
	if (self.panel) then return self.panel end

	local panel = CreateFrame("Frame", "DiabolicMinimapOptionsPanel", UIParent)
	panel.name = L_MINIMAP_CATEGORY
	panel.parent = L_PARENT_CATEGORY
	panel:SetScript("OnShow", Panel_OnShow)
	panel:SetScript("OnUpdate", Panel_OnUpdate)
	panel:Hide()

	local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(L_MINIMAP_CATEGORY)
	panel.title = title

	-- The small lettermark crest shown top-right on the submenu pages,
	-- matching the one on DiabolicUI's own Tooltips submenu exactly
	-- (same size, position, source texture and crop).
	local icon = panel:CreateTexture(nil, "ARTWORK")
	icon:SetSize(32, 32)
	icon:SetPoint("TOPRIGHT", -16, -16)
	icon:SetTexture(([[Interface\AddOns\%s\media\textures\diabolic-lettermark.tga]]):format(Addon))
	icon:SetTexCoord(90 / 512, 422 / 512, 90 / 512, 422 / 512)
	panel.icon = icon

	local editButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
	editButton:SetSize(190, 24)
	editButton:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -20)
	editButton:SetText(L_TOGGLE_EDIT_MODE)
	editButton:SetScript("OnClick", EditButton_OnClick)
	editButton:SetScript("OnEnter", function(self)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(L_TOGGLE_EDIT_MODE)
		GameTooltip:AddLine(L_EDIT_MODE_TOOLTIP, 1, 1, 1, true)
		GameTooltip:Show()
	end)
	editButton:SetScript("OnLeave", function(self)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip:Hide()
	end)
	panel.editButton = editButton

	local anchorLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	anchorLabel:SetPoint("TOPLEFT", editButton, "BOTTOMLEFT", 2, -20)
	anchorLabel:SetJustifyH("LEFT")
	anchorLabel:SetText(L_ANCHOR_HEADER)

	-- FontStrings can't take mouse input themselves, so a same-sized
	-- frame on top of it is what actually shows the description on hover.
	local anchorLabelHitbox = CreateFrame("Frame", nil, panel)
	anchorLabelHitbox:SetAllPoints(anchorLabel)
	anchorLabelHitbox:EnableMouse(true)
	anchorLabelHitbox:SetScript("OnEnter", function(self)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(L_ANCHOR_HEADER)
		GameTooltip:AddLine(L_ANCHOR_TOOLTIP, 1, 1, 1, true)
		GameTooltip:Show()
	end)
	anchorLabelHitbox:SetScript("OnLeave", function(self)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip:Hide()
	end)

	-- A rectangle with a radio button on each of the 8 anchor
	-- points around it - click one to snap the minimap there.
	-- Styled to match DiabolicUI's own Tooltips anchor picker
	-- (same size and tooltip-border skin).
	local anchorBox = CreateFrame("Frame", nil, panel)
	anchorBox:SetSize(120, 80)
	anchorBox:SetPoint("TOPLEFT", anchorLabel, "BOTTOMLEFT", 10, -20)
	anchorBox:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	anchorBox:SetBackdropColor(0, 0, 0, .75)
	anchorBox:SetBackdropBorderColor(1, 1, 1, 1)

	-- *TOPRIGHT is the addon's default anchor point, so the
	--  readout (below) will show it selected before any move.
	panel.anchorRadios = {}
	for _, point in ipairs(ANCHOR_POINTS) do
		local radio = CreateFrame("CheckButton", nil, anchorBox, "UIRadioButtonTemplate")
		radio:SetPoint("CENTER", anchorBox, point, 0, 0)
		radio.point = point
		radio:SetScript("OnClick", AnchorRadio_OnClick)
		panel.anchorRadios[point] = radio
	end

	local minPct = ns.Config.Minimap.MinUserScale * 100
	local maxPct = ns.Config.Minimap.MaxUserScale * 100

	-- Slider + input styled like Blizzard's own options
	-- (e.g. "Time Visible"): title above, low/high under the
	-- ends, and the numeric box sitting to the right of it.
	local sizeSlider = CreateFrame("Slider", "DiabolicMinimapSizeSlider", panel, "OptionsSliderTemplate")
	sizeSlider:SetOrientation("HORIZONTAL")
	sizeSlider:SetWidth(160)
	sizeSlider:SetHeight(15)
	sizeSlider:SetPoint("TOPLEFT", anchorBox, "TOPRIGHT", 40, -14)
	sizeSlider:SetMinMaxValues(minPct, maxPct)
	sizeSlider:SetValueStep(1)
	sizeSlider:SetScript("OnValueChanged", SizeSlider_OnValueChanged)
	_G[sizeSlider:GetName() .. "Text"]:SetText("Size (% of default)")
	_G[sizeSlider:GetName() .. "Low"]:SetText(string_format("%d%%", minPct))
	_G[sizeSlider:GetName() .. "High"]:SetText(string_format("%d%%", maxPct))
	sizeSlider.tooltipText = "Size (% of default)"
	sizeSlider.tooltipRequirement = L_SIZE_SLIDER_TOOLTIP
	panel.sizeSlider = sizeSlider

	local sizeInput = SkinDurationSlider(sizeSlider)
	sizeInput:SetScript("OnEnterPressed", SizeInput_OnEnterPressed)
	sizeInput:SetScript("OnEscapePressed", SizeInput_OnEscapePressed)
	sizeInput:SetScript("OnEditFocusLost", SizeInput_OnEditFocusLost)
	panel.sizeInput = sizeInput

	local zoneLabelHeader = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	zoneLabelHeader:SetPoint("TOPLEFT", anchorBox, "BOTTOMLEFT", 2, -20)
	zoneLabelHeader:SetJustifyH("LEFT")
	zoneLabelHeader:SetText(L_ZONE_LABEL_HEADER)

	-- A bordered group around Animate Zone Text + Fade Duration, styled
	-- like the anchor point picker's backdrop elsewhere in this menu.
	local zoneFadeGroup = CreateFrame("Frame", nil, panel)
	zoneFadeGroup:SetPoint("TOPLEFT", zoneLabelHeader, "BOTTOMLEFT", -16, -8)
	zoneFadeGroup:SetSize(380, 100)
	zoneFadeGroup:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	zoneFadeGroup:SetBackdropColor(0, 0, 0, .25)
	zoneFadeGroup:SetBackdropBorderColor(1, 1, 1, 1)

	local zoneFadeCheckbox = CreateFrame("CheckButton", "DiabolicMinimapZoneFadeCheckbox", zoneFadeGroup, "InterfaceOptionsCheckButtonTemplate")
	zoneFadeCheckbox:SetPoint("TOPLEFT", zoneFadeGroup, "TOPLEFT", 18, -16)
	_G[zoneFadeCheckbox:GetName() .. "Text"]:SetText(L_ZONE_FADE_CHECKBOX)
	zoneFadeCheckbox.tooltipText = L_ZONE_FADE_CHECKBOX
	zoneFadeCheckbox.tooltipRequirement = L_ZONE_FADE_TOOLTIP
	zoneFadeCheckbox:SetScript("OnClick", ZoneFadeCheckbox_OnClick)
	panel.zoneFadeCheckbox = zoneFadeCheckbox

	-- Anchored to the checkbox's own label text (not the checkbox frame,
	-- which is much narrower than the label), so the gap to the slider
	-- is measured from where "Animate Zone Text" actually ends on screen -
	-- same layout as DiabolicUI's own "Fade Chat" + Time Fading/Visible.
	-- One duration covers both halves of the crossfade (out, then in).
	local zoneFadeDurationSlider = CreateDurationSlider(zoneFadeGroup, "DiabolicMinimapZoneFadeDurationSlider", _G[zoneFadeCheckbox:GetName() .. "Text"], L_ZONE_FADE_DURATION_SLIDER, L_ZONE_FADE_TOOLTIP,
		50, 1000,
		function() return ns.db.global.minimap.zoneFadeDuration end,
		function(value) ns.db.global.minimap.zoneFadeDuration = value end,
		{ "TOPLEFT", "TOPRIGHT", 30, -4 })
	panel.zoneFadeDurationSlider = zoneFadeDurationSlider
	-- ZoneFadeCheckbox_OnClick reaches this via self:GetParent() on the
	-- checkbox, which is zoneFadeGroup now that it's grouped in its own
	-- bordered frame - not the options panel itself.
	zoneFadeGroup.zoneFadeDurationSlider = zoneFadeDurationSlider

	-- Fade Duration only matters while zone fade is actually enabled,
	-- so grey it out and block input otherwise.
	zoneFadeDurationSlider:SetEnabled(ns.db.global.minimap.zoneFadeEnabled)

	InterfaceOptions_AddCategory(panel)

	self.panel = panel

	return panel
end

MenuMod.OnEnable = function(self)
	self:CreatePanel()
end
