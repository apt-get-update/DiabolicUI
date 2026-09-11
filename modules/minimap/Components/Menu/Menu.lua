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

-- Refreshes the live anchor/size readout.
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
	anchorLabel:SetText("Anchor Point")

	-- A rectangle with a radio button on each of the 8 anchor
	-- points around it - click one to snap the minimap there.
	-- Styled to match DiabolicUI's own Tooltips "Anchor Point" picker
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
	sizeSlider:SetHeight(16)
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

	local sizeInput = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
	sizeInput:SetSize(40, 20)
	sizeInput:SetAutoFocus(false)
	sizeInput:SetMaxLetters(5)
	sizeInput:SetJustifyH("CENTER")
	sizeInput:SetPoint("LEFT", sizeSlider, "RIGHT", 20, 0)
	sizeInput:SetScript("OnEnterPressed", SizeInput_OnEnterPressed)
	sizeInput:SetScript("OnEscapePressed", SizeInput_OnEscapePressed)
	sizeInput:SetScript("OnEditFocusLost", SizeInput_OnEditFocusLost)
	panel.sizeInput = sizeInput

	InterfaceOptions_AddCategory(panel)

	self.panel = panel

	return panel
end

MenuMod.OnEnable = function(self)
	self:CreatePanel()
end
