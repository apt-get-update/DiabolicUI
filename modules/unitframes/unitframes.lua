local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("UnitFrames")

-- Lua API
local math_floor = math.floor
local unpack = unpack

-- WoW API
local CreateFrame = CreateFrame
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory

Module.LoadArtWork = function(self)
	local config = self.config.visuals.artwork
	local db = self.db

	local Main = Engine:GetModule("ActionBars"):GetWidget("Controller: Main"):GetFrame()

	self.artwork = {}

	local backdrop = CreateFrame("Frame", nil, Main)
	backdrop:SetFrameStrata("BACKGROUND")
	backdrop:SetAllPoints()

	local overlay = CreateFrame("Frame", nil, Main)
	overlay:SetFrameStrata("MEDIUM")
	overlay:SetAllPoints()

	local new = function(parent, config, flip)
		local artwork = parent:CreateTexture(nil, drawLayer or "ARTWORK")
		artwork:SetSize(unpack(config.size))
		artwork:SetTexture(config.texture)
		artwork:SetVertexColor(unpack(config.color))
		artwork:SetPoint(unpack(config.position))
		artwork:SetBlendMode(alhpaMode or "BLEND")
		return artwork
	end

	self.artwork["healthshade"] = new(backdrop, config.health.shade)
	self.artwork["healthborder"] = new(overlay, config.health.overlay)

	self.artwork["powershade"] = new(backdrop, config.power.shade)
	self.artwork["powerborder"] = new(overlay, config.power.overlay)

end

local CreateSubHeader = function(panel, anchorTo, text)
	local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	header:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 2, -30)
	header:SetText(text)
	return header
end

-- Values dragged this close to 0 snap to it, since landing on exactly the
-- centered position by hand is otherwise fiddly.
local SLIDER_SNAP_RANGE = 5
local SLIDER_MIN, SLIDER_MAX = -200, 200

-- anchorSpec optionally overrides the default "stack below anchorTo" layout
-- with an explicit { point, relativePoint, x, y } anchor of its own.
local CreateOffsetSlider = function(panel, name, anchorTo, label, tooltipText, getValue, setValue, anchorSpec)
	local slider = CreateFrame("Slider", "DiabolicUIOptionsPanel"..name, panel, "OptionsSliderTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetWidth(160)
	slider:SetHeight(16)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetMinMaxValues(SLIDER_MIN, SLIDER_MAX)
	slider:SetValueStep(1)

	if anchorSpec then
		slider:SetPoint(anchorSpec[1], anchorTo, anchorSpec[2], anchorSpec[3], anchorSpec[4])
	else
		slider:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 4, -40)
	end

	_G[slider:GetName().."Low"]:SetText(SLIDER_MIN)
	_G[slider:GetName().."High"]:SetText(SLIDER_MAX)
	_G[slider:GetName().."Text"]:SetText(label)

	slider.tooltipText = label
	slider.tooltipRequirement = tooltipText

	-- manual numeric entry, for typing an exact value (like 0) directly
	-- instead of having to land on it with the slider
	local input = CreateFrame("EditBox", "DiabolicUIOptionsPanel"..name.."Input", panel, "InputBoxTemplate")
	input:SetSize(40, 20)
	input:SetPoint("LEFT", slider, "RIGHT", 16, 0)
	input:SetAutoFocus(false)
	input:SetJustifyH("CENTER")
	input:SetMaxLetters(4) -- "-200"

	local silent = false -- true while we're driving the slider/input from code, not the user

	-- updates both widgets to match, without re-triggering the slider's
	-- own OnValueChanged (which would otherwise snap it again and re-save)
	local setSilently = function(value)
		value = math_floor(value + .5)
		silent = true
		slider:SetValue(value)
		silent = false
		input:SetText(tostring(value))
	end

	local commitValue = function(value)
		if (value < SLIDER_MIN) then
			value = SLIDER_MIN
		elseif (value > SLIDER_MAX) then
			value = SLIDER_MAX
		end
		setSilently(value)
		setValue(value)
	end

	slider:SetScript("OnValueChanged", function(button, value)
		if silent then
			return
		end
		value = math_floor(value + .5)
		if (value ~= 0) and (value > -SLIDER_SNAP_RANGE) and (value < SLIDER_SNAP_RANGE) then
			value = 0
		end
		commitValue(value)
	end)

	input:SetScript("OnEnterPressed", function(self)
		local value = tonumber(self:GetText())
		if value then
			commitValue(value)
		else
			self:SetText(tostring(math_floor(slider:GetValue() + .5)))
		end
		self:ClearFocus()
	end)

	input:SetScript("OnEscapePressed", function(self)
		self:SetText(tostring(math_floor(slider:GetValue() + .5)))
		self:ClearFocus()
	end)

	setSilently(getValue())

	-- exposed so the panel's cancel/refresh can reset the display without
	-- re-triggering a snap or a write-back
	slider.SetValueSilently = setSilently

	return slider
end

-- Order they're visited in when building/refreshing the anchor point picker.
-- The names match both a WoW anchor point and a key in Tooltips.anchorPoint.
local ANCHOR_POINT_ORDER = { "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }

local ANCHOR_POINT_LABELS = {
	TOPLEFT = L["Top Left"], TOP = L["Top"], TOPRIGHT = L["Top Right"],
	LEFT = L["Left"], CENTER = L["Center"], RIGHT = L["Right"],
	BOTTOMLEFT = L["Bottom Left"], BOTTOM = L["Bottom"], BOTTOMRIGHT = L["Bottom Right"]
}

-- A small rectangle representing the tooltip, with a radio button on each
-- corner, edge midpoint and its center, to pick which of those points gets
-- anchored to the cursor (plus the offset sliders above).
local CreateAnchorPointPicker = function(panel, anchorTo, label, getValue, setValue)
	local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	header:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", -2, -30)
	header:SetText(label)

	local preview = CreateFrame("Frame", nil, panel)
	preview:SetSize(120, 80)
	preview:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 4, -28)
	preview:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	preview:SetBackdropColor(0, 0, 0, .75)
	preview:SetBackdropBorderColor(1, 1, 1, 1)

	local buttons = {}

	local refresh = function()
		local value = getValue()
		for _, point in ipairs(ANCHOR_POINT_ORDER) do
			buttons[point]:SetChecked(point == value)
		end
	end

	for _, point in ipairs(ANCHOR_POINT_ORDER) do
		local button = CreateFrame("CheckButton", "DiabolicUIOptionsPanelAnchor"..point, preview, "UIRadioButtonTemplate")
		button:SetPoint("CENTER", preview, point, 0, 0)
		button.tooltipText = ANCHOR_POINT_LABELS[point]
		button:SetScript("OnClick", function()
			setValue(point)
			refresh()
		end)
		buttons[point] = button
	end

	refresh()

	return preview, refresh
end

Module.CreateOptionsPanel = function(self)
	local db = self.db
	local tooltipsDB = Engine:GetConfig("Tooltips")

	local panel = CreateFrame("Frame", "DiabolicUIOptionsPanel", InterfaceOptionsFramePanelContainer)
	panel.name = "DiabolicUI"
	panel:Hide()

	local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("DiabolicUI")

	local logo = panel:CreateTexture(nil, "ARTWORK")
	logo:SetSize(32, 32)
	logo:SetPoint("TOPRIGHT", -16, -16)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\diabolic-lettermark.tga]]):format(Addon))
	logo:SetTexCoord(90/512, 422/512, 90/512, 422/512)

	-- Unit Frames
	-------------------------------------------------------
	local unitframesHeader = CreateSubHeader(panel, title, L["Unit Frames"])

	local classColors = CreateFrame("CheckButton", "DiabolicUIOptionsPanelClassColors", panel, "InterfaceOptionsCheckButtonTemplate")
	classColors:SetPoint("TOPLEFT", unitframesHeader, "BOTTOMLEFT", -2, -8)
	classColors:SetChecked(db.showClassColors)
	_G[classColors:GetName().."Text"]:SetText(L["Show class colors"])
	classColors.tooltipText = L["Show class colors"]
	classColors.tooltipRequirement = L["Colors the player, target, party, raid and tab-target of target health bars by the unit's class.|n|nRequires a UI reload to apply."]
	classColors:SetScript("OnClick", function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= db.showClassColors) then
			db.showClassColors = checked
			Engine:ReloadUI()
		end
	end)

	-- Tooltips
	-------------------------------------------------------
	local tooltipsHeader = CreateSubHeader(panel, classColors, L["Tooltips"])

	local anchorPreview, refreshAnchorPoint = CreateAnchorPointPicker(panel, tooltipsHeader, L["Anchor Point"],
		function() return tooltipsDB.anchorPoint end,
		function(value) tooltipsDB.anchorPoint = value end)

	local offsetX = CreateOffsetSlider(panel, "TooltipOffsetX", anchorPreview, L["Horizontal Offset"], L["At 0, the tooltip is centered horizontally on the cursor."],
		function() return tooltipsDB.offsetX end,
		function(value) tooltipsDB.offsetX = value end,
		{ "TOPLEFT", "TOPRIGHT", 40, 0 })

	local offsetY = CreateOffsetSlider(panel, "TooltipOffsetY", offsetX, L["Vertical Offset"], L["At 0, the cursor is at the bottom edge of the tooltip."],
		function() return tooltipsDB.offsetY end,
		function(value) tooltipsDB.offsetY = value end)

	panel.okay = function() end
	panel.cancel = function()
		classColors:SetChecked(db.showClassColors)
		offsetX:SetValueSilently(tooltipsDB.offsetX)
		offsetY:SetValueSilently(tooltipsDB.offsetY)
		refreshAnchorPoint()
	end
	panel.refresh = panel.cancel

	InterfaceOptions_AddCategory(panel)

	self.OptionsPanel = panel

	self:GetHandler("ChatCommand"):Register("config", function()
		InterfaceOptionsFrame_OpenToCategory(panel)
		InterfaceOptionsFrame_OpenToCategory(panel) -- needs to be called twice to work around a blizzard bug
	end)
end

Module.OnInit = function(self)
	self.config = self:GetDB("UnitFrames") -- setup
	self.db = self:GetConfig("UnitFrames") -- user settings

	self:GetWidget("Controller: Party"):Enable()
	self:GetWidget("Controller: Raid"):Enable()

	self:LoadArtWork()
	self:GetWidget("Unit: Player"):Enable()
	self:GetWidget("Unit: Pet"):Enable()
	self:GetWidget("Unit: Focus"):Enable()
	self:GetWidget("Unit: Target"):Enable()
	self:GetWidget("Unit: ToT"):Enable()

	self:GetWidget("Unit: Party"):Enable()
	self:GetWidget("Unit: Raid"):Enable()
	self:GetWidget("Unit: Arena"):Enable()
	self:GetWidget("Unit: Boss"):Enable()

	-- Set a keyword for our petframe,
	-- for modules like the actionbars to hook into.
	local PetFrame = self:GetWidget("Unit: Pet"):GetFrame()
	Engine:RegisterKeyword("PetFrame", function() return PetFrame end)

end

Module.OnEnable = function(self)
	self:CreateOptionsPanel()

	local BlizzardUI = self:GetHandler("BlizzardUI")
	BlizzardUI:GetElement("UnitFrames"):Disable()

	BlizzardUI:GetElement("Menu_Panel"):Remove(9, "InterfaceOptionsStatusTextPanel")
	BlizzardUI:GetElement("Menu_Panel"):Remove(10, "InterfaceOptionsUnitFramePanel")

	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelPartyBackground")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelPartyInRaid")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelPartyPets")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelRaidRange")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelFullSizeFocusFrame")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelArenaEnemyFrames")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelArenaEnemyCastBar")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelArenaEnemyPets")

	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelTargetOfTarget")
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelTOTDropDown")
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelEnemyCastBars")
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait")
--	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates")
end
