local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("Menu")

-- Lua API
local math_floor = math.floor
local unpack = unpack

-- WoW API
local CreateFrame = CreateFrame
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory

-- The small lettermark crest shown top-right on the submenu pages.
local CreateSubmenuLogo = function(panel)
	local logo = panel:CreateTexture(nil, "ARTWORK")
	logo:SetSize(32, 32)
	logo:SetPoint("TOPRIGHT", -16, -16)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\diabolic-lettermark.tga]]):format(Addon))
	logo:SetTexCoord(90/512, 422/512, 90/512, 422/512)
	return logo
end

local CreateSubHeader = function(panel, anchorTo, text)
	local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	header:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 2, -30)
	header:SetText(text)
	return header
end

-- Values dragged this close to 0 snap to it, since landing on exactly the
-- centered position by hand is otherwise fiddly. Only meaningful for
-- sliders whose range spans 0, like the tooltip offsets below.
local SLIDER_SNAP_RANGE = 5
local SLIDER_MIN, SLIDER_MAX = -200, 200

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

-- A slider plus a manual numeric entry box centered below it, kept in sync
-- both ways. anchorSpec optionally overrides the default "stack below
-- anchorTo" layout with an explicit { point, relativePoint, x, y } anchor
-- of its own. snapRange, if given, makes values dragged near 0 snap to it.
local CreateValueSlider = function(panel, name, anchorTo, label, tooltipText, minValue, maxValue, getValue, setValue, anchorSpec, snapRange)
	local slider = CreateFrame("Slider", "DiabolicUIOptionsPanel"..name, panel, "OptionsSliderTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetWidth(160)
	slider:SetHeight(15)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetMinMaxValues(minValue, maxValue)
	slider:SetValueStep(1)
	slider:SetBackdrop(SLIDER_BACKDROP)
	slider:SetThumbTexture(SLIDER_THUMB_TEXTURE)

	if anchorSpec then
		slider:SetPoint(anchorSpec[1], anchorTo, anchorSpec[2], anchorSpec[3], anchorSpec[4])
	else
		-- Always anchored to anchorTo itself (never its .Input), so this
		-- slider's own left edge lines up with anchorTo's - anchoring to
		-- .Input instead would misalign it, since that box is centered
		-- under the slider above it, not flush with its left edge. If
		-- anchorTo is itself a slider, though, its input box now sits
		-- below it, so the gap needs to be bigger to actually clear it.
		local gap = anchorTo.Input and -50 or -20
		slider:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", 4, gap)
	end

	local lowText, highText, labelText = _G[slider:GetName().."Low"], _G[slider:GetName().."High"], _G[slider:GetName().."Text"]
	lowText:SetText(minValue)
	highText:SetText(maxValue)
	labelText:SetText(label)
	lowText:SetTextColor(1, 1, 1)
	highText:SetTextColor(1, 1, 1)
	labelText:SetTextColor(unpack(LABEL_COLOR))

	slider.tooltipText = label
	slider.tooltipRequirement = tooltipText

	-- manual numeric entry, for typing an exact value directly instead of
	-- having to land on it with the slider
	local input = CreateFrame("EditBox", "DiabolicUIOptionsPanel"..name.."Input", panel)
	input:SetSize(70, 14)
	input:SetPoint("TOP", slider, "BOTTOM", 0, -6)
	input:SetAutoFocus(false)
	input:SetJustifyH("CENTER")
	input:SetFontObject(GameFontHighlightSmall)
	input:SetBackdrop(INPUT_BACKDROP)
	input:SetBackdropColor(0, 0, 0, .5)
	input:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR))
	input:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR_HOVER)) end)
	input:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR)) end)
	input:SetMaxLetters(5) -- "-200" / "120"

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
		if (value < minValue) then
			value = minValue
		elseif (value > maxValue) then
			value = maxValue
		end
		setSilently(value)
		setValue(value)
	end

	slider:SetScript("OnValueChanged", function(button, value)
		if silent then
			return
		end
		value = math_floor(value + .5)
		if snapRange and (value ~= 0) and (value > -snapRange) and (value < snapRange) then
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

	-- exposed so a dependent control (e.g. a checkbox toggling whether
	-- this slider's setting even applies) can grey it out and block
	-- interaction, along with its numeric entry box.
	-- *EditBox has no Enable()/Disable() of its own in this client (only
	--  Button/CheckButton/Slider do), so it's faked here instead: block
	--  mouse and keyboard input, drop any current focus, and dim the text.
	slider.Input = input
	slider.SetEnabled = function(self, enabled)
		if enabled then
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

-- anchorSpec optionally overrides the default "stack below anchorTo" layout
-- with an explicit { point, relativePoint, x, y } anchor of its own.
local CreateOffsetSlider = function(panel, name, anchorTo, label, tooltipText, getValue, setValue, anchorSpec)
	return CreateValueSlider(panel, name, anchorTo, label, tooltipText, SLIDER_MIN, SLIDER_MAX, getValue, setValue, anchorSpec, SLIDER_SNAP_RANGE)
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
local CreateAnchorPointPicker = function(panel, anchorTo, label, tooltipText, getValue, setValue)
	local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	header:SetPoint("TOPLEFT", anchorTo, "BOTTOMLEFT", -2, -30)
	header:SetText(label)

	-- FontStrings can't take mouse input themselves, so a same-sized
	-- frame on top of it is what actually shows the description on hover.
	local headerHitbox = CreateFrame("Frame", nil, panel)
	headerHitbox:SetAllPoints(header)
	headerHitbox:EnableMouse(true)
	headerHitbox:SetScript("OnEnter", function(self)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(label)
		GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
		GameTooltip:Show()
	end)
	headerHitbox:SetScript("OnLeave", function(self)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip:Hide()
	end)

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
	local db = self:GetConfig("UnitFrames")
	local tooltipsDB = Engine:GetConfig("Tooltips")
	local actionbarsDB = Engine:GetConfig("ActionBars", "character")
	local objectivesDB = Engine:GetConfig("ObjectiveTracker")
	local lootDB = Engine:GetConfig("LootFrame")
	local UnitFrames = Engine:GetModule("UnitFrames")

	local panel = CreateFrame("Frame", "DiabolicUIOptionsPanel", InterfaceOptionsFramePanelContainer)
	panel.name = "DiabolicUI"
	panel:Hide()

	local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("DiabolicUI")

	local logo = panel:CreateTexture(nil, "ARTWORK")
	logo:SetSize(160, 80)
	logo:SetPoint("TOPRIGHT", -16, -16)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\DiabolicUI_Logo.tga]]):format(Addon))

	-- Menu
	-------------------------------------------------------
	local menuHeader = CreateSubHeader(panel, title, L["Menu"])

	local showGold = CreateFrame("CheckButton", "DiabolicUIOptionsPanelShowGold", panel, "InterfaceOptionsCheckButtonTemplate")
	showGold:SetPoint("TOPLEFT", menuHeader, "BOTTOMLEFT", -2, -8)
	showGold:SetChecked(actionbarsDB.showGold)
	_G[showGold:GetName().."Text"]:SetText(L["Show Gold"])
	showGold.tooltipText = L["Show Gold"]
	showGold.tooltipRequirement = L["Shows how much money you're carrying, next to the menu button in the bottom right corner."]
	showGold:SetScript("OnClick", function(button)
		actionbarsDB.showGold = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdateGoldVisibility()
	end)

	local showPerformance = CreateFrame("CheckButton", "DiabolicUIOptionsPanelShowPerformance", panel, "InterfaceOptionsCheckButtonTemplate")
	showPerformance:SetPoint("TOPLEFT", showGold, "BOTTOMLEFT", 0, -4)
	showPerformance:SetChecked(actionbarsDB.showPerformance)
	_G[showPerformance:GetName().."Text"]:SetText(L["Show FPS & Latency"])
	showPerformance.tooltipText = L["Show FPS & Latency"]
	showPerformance.tooltipRequirement = L["Shows your framerate and latency, next to the menu button in the bottom right corner."]
	showPerformance:SetScript("OnClick", function(button)
		actionbarsDB.showPerformance = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdatePerformanceVisibility()
	end)

	-- Objectives
	-------------------------------------------------------
	local objectivesHeader = CreateSubHeader(panel, showPerformance, L["Objectives"])

	local fadeTracker = CreateFrame("CheckButton", "DiabolicUIOptionsPanelFadeTracker", panel, "InterfaceOptionsCheckButtonTemplate")
	fadeTracker:SetPoint("TOPLEFT", objectivesHeader, "BOTTOMLEFT", -2, -8)
	fadeTracker:SetChecked(objectivesDB.fadeTracker)
	_G[fadeTracker:GetName().."Text"]:SetText(L["Fade Quest Tracker"])
	fadeTracker.tooltipText = L["Fade Quest Tracker"]
	fadeTracker.tooltipRequirement = L["Fades Questie's quest tracker out after it hasn't been moused over for a while, and shows it again as soon as you mouse over it.|n|nRequires Questie."]

	-- Anchored to the checkbox's own label text (not the checkbox frame,
	-- which is much narrower than the label), so the gap to the sliders
	-- is measured from where "Fade Quest Tracker" actually ends on screen.
	local trackerTimeFading = CreateValueSlider(panel, "ObjectivesTimeFading", _G[fadeTracker:GetName().."Text"], L["Time Fading"], L["How many seconds the tracker stays fully visible before it starts fading, once you stop hovering it."],
		1, 30,
		function() return objectivesDB.fadeDelay end,
		function(value) objectivesDB.fadeDelay = value end,
		{ "TOPLEFT", "TOPRIGHT", 30, -4 })

	local trackerOpacity = CreateValueSlider(panel, "ObjectivesOpacity", trackerTimeFading, L["Opacity"], L["How visible the tracker stays once it has fully faded, as a percentage."],
		0, 100,
		function() return objectivesDB.fadeOpacity end,
		function(value) objectivesDB.fadeOpacity = value end)

	-- Time Fading / Opacity only matter while the tracker fade is
	-- actually enabled, so grey them out and block input otherwise.
	local updateTrackerSlidersEnabled = function()
		trackerTimeFading:SetEnabled(objectivesDB.fadeTracker)
		trackerOpacity:SetEnabled(objectivesDB.fadeTracker)
	end
	updateTrackerSlidersEnabled()

	fadeTracker:SetScript("OnClick", function(button)
		objectivesDB.fadeTracker = button:GetChecked() and true or false
		Engine:GetModule("ObjectiveTracker"):ApplyFadeSetting()
		updateTrackerSlidersEnabled()
	end)

	-- Loot
	-------------------------------------------------------
	local lootHeader = CreateSubHeader(panel, trackerOpacity, L["Loot"])

	local reskinLoot = CreateFrame("CheckButton", "DiabolicUIOptionsPanelReskinLoot", panel, "InterfaceOptionsCheckButtonTemplate")
	reskinLoot:SetPoint("TOPLEFT", lootHeader, "BOTTOMLEFT", -2, -8)
	reskinLoot:SetChecked(lootDB.enableSkin)
	_G[reskinLoot:GetName().."Text"]:SetText(L["Reskin Loot Window"])
	reskinLoot.tooltipText = L["Reskin Loot Window"]
	reskinLoot.tooltipRequirement = L["Re-styles the loot window to match the rest of the UI. When disabled, Blizzard's own loot window is used instead.|n|nRequires a UI reload to apply."]
	reskinLoot:SetScript("OnClick", function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= lootDB.enableSkin) then
			lootDB.enableSkin = checked
			Engine:ReloadUI()
		end
	end)

	panel.okay = function() end
	panel.cancel = function()
		showGold:SetChecked(actionbarsDB.showGold)
		showPerformance:SetChecked(actionbarsDB.showPerformance)
		fadeTracker:SetChecked(objectivesDB.fadeTracker)
		trackerTimeFading:SetValueSilently(objectivesDB.fadeDelay)
		trackerOpacity:SetValueSilently(objectivesDB.fadeOpacity)
		updateTrackerSlidersEnabled()
		reskinLoot:SetChecked(lootDB.enableSkin)
	end
	panel.refresh = panel.cancel

	InterfaceOptions_AddCategory(panel)

	-- Tooltips (submenu)
	-------------------------------------------------------
	local tooltipsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelTooltips", InterfaceOptionsFramePanelContainer)
	tooltipsPanel.name = L["Tooltips"]
	tooltipsPanel.parent = panel.name
	tooltipsPanel:Hide()

	local tooltipsTitle = tooltipsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	tooltipsTitle:SetPoint("TOPLEFT", 16, -16)
	tooltipsTitle:SetText(L["Tooltips"])

	CreateSubmenuLogo(tooltipsPanel)

	local anchorPreview, refreshAnchorPoint = CreateAnchorPointPicker(tooltipsPanel, tooltipsTitle, L["Tooltip mouse anchor"], L["Which point of the tooltip gets anchored to your cursor, so you can pick the corner or edge that overlaps your mouse the least."],
		function() return tooltipsDB.anchorPoint end,
		function(value) tooltipsDB.anchorPoint = value end)

	local offsetX = CreateOffsetSlider(tooltipsPanel, "TooltipOffsetX", anchorPreview, L["Horizontal Offset"], L["At 0, the tooltip is centered horizontally on the cursor."],
		function() return tooltipsDB.offsetX end,
		function(value) tooltipsDB.offsetX = value end,
		{ "TOPLEFT", "TOPRIGHT", 40, 0 })

	local offsetY = CreateOffsetSlider(tooltipsPanel, "TooltipOffsetY", offsetX, L["Vertical Offset"], L["At 0, the cursor is at the bottom edge of the tooltip."],
		function() return tooltipsDB.offsetY end,
		function(value) tooltipsDB.offsetY = value end)

	tooltipsPanel.okay = function() end
	tooltipsPanel.cancel = function()
		offsetX:SetValueSilently(tooltipsDB.offsetX)
		offsetY:SetValueSilently(tooltipsDB.offsetY)
		refreshAnchorPoint()
	end
	tooltipsPanel.refresh = tooltipsPanel.cancel

	InterfaceOptions_AddCategory(tooltipsPanel)

	-- Units (submenu)
	-------------------------------------------------------
	local unitsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelUnits", InterfaceOptionsFramePanelContainer)
	unitsPanel.name = L["Units"]
	unitsPanel.parent = panel.name
	unitsPanel:Hide()

	local unitsTitle = unitsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	unitsTitle:SetPoint("TOPLEFT", 16, -16)
	unitsTitle:SetText(L["Units"])

	CreateSubmenuLogo(unitsPanel)

	local classColors = CreateFrame("CheckButton", "DiabolicUIOptionsPanelClassColors", unitsPanel, "InterfaceOptionsCheckButtonTemplate")
	classColors:SetPoint("TOPLEFT", unitsTitle, "BOTTOMLEFT", -2, -20)
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

	local showPortrait = CreateFrame("CheckButton", "DiabolicUIOptionsPanelShowPortrait", unitsPanel, "InterfaceOptionsCheckButtonTemplate")
	showPortrait:SetPoint("TOPLEFT", classColors, "BOTTOMLEFT", 0, -4)
	showPortrait:SetChecked(db.showPortrait)
	_G[showPortrait:GetName().."Text"]:SetText(L["Show Portrait"])
	showPortrait.tooltipText = L["Show Portrait"]
	showPortrait.tooltipRequirement = L["Shows an animated 3D model portrait on party and focus frames.|n|nRequires a UI reload to apply."]
	showPortrait:SetScript("OnClick", function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= db.showPortrait) then
			db.showPortrait = checked
			Engine:ReloadUI()
		end
	end)

	-- Advanced
	-------------------------------------------------------
	local advancedHeader = CreateSubHeader(unitsPanel, showPortrait, L["Advanced"])

	local toggleFakeParty = CreateFrame("Button", "DiabolicUIOptionsPanelToggleFakeParty", unitsPanel, "UIPanelButtonTemplate")
	toggleFakeParty:SetSize(150, 24)
	toggleFakeParty:SetPoint("TOPLEFT", advancedHeader, "BOTTOMLEFT", -2, -8)
	toggleFakeParty:SetText(L["Toggle Fake Party"])
	toggleFakeParty:SetScript("OnClick", function(button)
		db.testPartyMode = not db.testPartyMode
		UnitFrames:SetPartyMockShown(db.testPartyMode)
	end)
	toggleFakeParty:SetScript("OnEnter", function(button)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip_SetDefaultAnchor(GameTooltip, button)
		GameTooltip:AddLine(L["Toggle Fake Party"])
		GameTooltip:AddLine(L["Shows or hides a mock party of fake members, to preview the party frames' look without needing a real group."], 1, 1, 1, true)
		GameTooltip:Show()
	end)
	toggleFakeParty:SetScript("OnLeave", function(button)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip:Hide()
	end)

	local toggleFakeRaid = CreateFrame("Button", "DiabolicUIOptionsPanelToggleFakeRaid", unitsPanel, "UIPanelButtonTemplate")
	toggleFakeRaid:SetSize(150, 24)
	toggleFakeRaid:SetPoint("LEFT", toggleFakeParty, "RIGHT", 8, 0)
	toggleFakeRaid:SetText(L["Toggle Fake Raid"])
	toggleFakeRaid:SetScript("OnClick", function(button)
		db.testRaidMode = not db.testRaidMode
		UnitFrames:SetRaidMockShown(db.testRaidMode)
	end)
	toggleFakeRaid:SetScript("OnEnter", function(button)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip_SetDefaultAnchor(GameTooltip, button)
		GameTooltip:AddLine(L["Toggle Fake Raid"])
		GameTooltip:AddLine(L["Shows or hides a mock raid of fake members, to preview the raid frames' look without needing a real group."], 1, 1, 1, true)
		GameTooltip:Show()
	end)
	toggleFakeRaid:SetScript("OnLeave", function(button)
		if (GameTooltip:IsForbidden()) then return end
		GameTooltip:Hide()
	end)

	unitsPanel.okay = function() end
	unitsPanel.cancel = function()
		classColors:SetChecked(db.showClassColors)
		showPortrait:SetChecked(db.showPortrait)
	end
	unitsPanel.refresh = unitsPanel.cancel

	InterfaceOptions_AddCategory(unitsPanel)

	-- Chat (submenu)
	-------------------------------------------------------
	local chatDB = Engine:GetConfig("ChatWindows")
	local chatFiltersDB = Engine:GetConfig("ChatFilters")
	local applyChatFadeSettings = function()
		Engine:GetModule("ChatWindows"):ApplyFadeSettings()
	end

	local chatPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelChat", InterfaceOptionsFramePanelContainer)
	chatPanel.name = L["Chat"]
	chatPanel.parent = panel.name
	chatPanel:Hide()

	local chatTitle = chatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	chatTitle:SetPoint("TOPLEFT", 16, -16)
	chatTitle:SetText(L["Chat"])

	CreateSubmenuLogo(chatPanel)

	-- Forward-declared: assigned once Time Fading/Time Visible exist below,
	-- but referenced by fadeChat's OnClick here already.
	local updateFadeSlidersEnabled

	local appearanceHeader = CreateSubHeader(chatPanel, chatTitle, L["Appearance"])

	local applyChatBackgroundOpacity = function()
		Engine:GetModule("ChatWindows"):ApplyBackgroundOpacity()
	end

	local backgroundOpacity = CreateValueSlider(chatPanel, "ChatBackgroundOpacity", appearanceHeader, L["Background Opacity"], L["How opaque the chat window's background is while you're typing."],
		0, 100,
		function() return chatDB.backgroundOpacity end,
		function(value)
			chatDB.backgroundOpacity = value
			applyChatBackgroundOpacity()
		end,
		{ "TOPLEFT", "BOTTOMLEFT", 14, -38 })

	-- A bordered group around Fade Chat + Time Fading + Time Visible,
	-- styled like the anchor point picker's backdrop elsewhere in this
	-- menu. Background Opacity stays outside/above it, on its own.
	-- *Anchored to backgroundOpacity itself (not its .Input), with the
	--  x-offset cancelling out backgroundOpacity's own +14 offset from
	--  appearanceHeader - so the frame's left edge lines up exactly with
	--  "Appearance" above it. The y-offset accounts for the extra height
	--  of backgroundOpacity's input box, which sits below its slider.
	local fadeGroup = CreateFrame("Frame", nil, chatPanel)
	fadeGroup:SetPoint("TOPLEFT", backgroundOpacity, "BOTTOMLEFT", -14, -36)
	fadeGroup:SetSize(380, 145)
	fadeGroup:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	fadeGroup:SetBackdropColor(0, 0, 0, .25)
	fadeGroup:SetBackdropBorderColor(1, 1, 1, 1)

	local fadeChat = CreateFrame("CheckButton", "DiabolicUIOptionsPanelFadeChat", fadeGroup, "InterfaceOptionsCheckButtonTemplate")
	fadeChat:SetPoint("TOPLEFT", fadeGroup, "TOPLEFT", 18, -16)
	fadeChat:SetChecked(chatDB.fadeChat)
	_G[fadeChat:GetName().."Text"]:SetText(L["Fade Chat"])
	fadeChat.tooltipText = L["Fade Chat"]
	fadeChat.tooltipRequirement = L["Fades chat text out after it has been visible for a while, instead of leaving it on screen permanently."]
	fadeChat:SetScript("OnClick", function(button)
		chatDB.fadeChat = button:GetChecked() and true or false
		applyChatFadeSettings()
		updateFadeSlidersEnabled()
	end)

	-- Anchored to the checkbox's own label text (not the checkbox frame,
	-- which is much narrower than the label), so the gap to the sliders
	-- is measured from where "Fade Chat" actually ends on screen.
	local timeFading = CreateValueSlider(fadeGroup, "ChatTimeFading", _G[fadeChat:GetName().."Text"], L["Time Fading"], L["How many seconds it takes for chat text to fade out."],
		1, 5,
		function() return chatDB.timeFading end,
		function(value)
			chatDB.timeFading = value
			applyChatFadeSettings()
		end,
		{ "TOPLEFT", "TOPRIGHT", 30, -4 })

	local timeVisible = CreateValueSlider(fadeGroup, "ChatTimeVisible", timeFading, L["Time Visible"], L["How many seconds chat text stays fully visible before it starts fading."],
		5, 120,
		function() return chatDB.timeVisible end,
		function(value)
			chatDB.timeVisible = value
			applyChatFadeSettings()
		end)

	-- Time Fading / Time Visible only matter while chat is actually
	-- set to fade, so grey them out and block input otherwise.
	updateFadeSlidersEnabled = function()
		timeFading:SetEnabled(chatDB.fadeChat)
		timeVisible:SetEnabled(chatDB.fadeChat)
	end
	updateFadeSlidersEnabled()

	-- Anchored below timeVisible's input box (the lowest point of the
	-- Appearance section now that each slider's input sits underneath it),
	-- then pulled back from that (right-hand) column to the left-hand one
	-- "Appearance" itself sits in, by a fixed estimate of the gap between
	-- them (fadeChat's checkbox + label + the gap to timeFading/timeVisible).
	-- Anchored to fadeGroup itself (not anything inside it), so it just
	-- inherits the group's own left edge - already aligned with
	-- "Appearance" - and its bottom edge, both by a single simple anchor.
	local miscHeader = CreateSubHeader(chatPanel, fadeGroup, L["Miscellaneous"])
	miscHeader:SetPoint("TOPLEFT", fadeGroup, "BOTTOMLEFT", 2, -20)

	local copyWebLinks = CreateFrame("CheckButton", "DiabolicUIOptionsPanelChatCopyWebLinks", chatPanel, "InterfaceOptionsCheckButtonTemplate")
	copyWebLinks:SetPoint("TOPLEFT", miscHeader, "BOTTOMLEFT", -2, -8)
	copyWebLinks:SetChecked(chatFiltersDB.copyWebLinks)
	_G[copyWebLinks:GetName().."Text"]:SetText(L["Copy Web Links"])
	copyWebLinks.tooltipText = L["Copy Web Links"]
	copyWebLinks.tooltipRequirement = L["Left-click a web link (http:// or https://) in the chat to open a popup with it, selected and ready to copy."]
	copyWebLinks:SetScript("OnClick", function(button)
		chatFiltersDB.copyWebLinks = button:GetChecked() and true or false
	end)

	chatPanel.okay = function() end
	chatPanel.cancel = function()
		fadeChat:SetChecked(chatDB.fadeChat)
		timeFading:SetValueSilently(chatDB.timeFading)
		timeVisible:SetValueSilently(chatDB.timeVisible)
		updateFadeSlidersEnabled()
		backgroundOpacity:SetValueSilently(chatDB.backgroundOpacity)
		copyWebLinks:SetChecked(chatFiltersDB.copyWebLinks)
	end
	chatPanel.refresh = chatPanel.cancel

	InterfaceOptions_AddCategory(chatPanel)

	self.OptionsPanel = panel

	self:GetHandler("ChatCommand"):Register("config", function()
		InterfaceOptionsFrame_OpenToCategory(panel)
		InterfaceOptionsFrame_OpenToCategory(panel) -- needs to be called twice to work around a blizzard bug
	end)
end

Module.OnEnable = function(self)
	self:CreateOptionsPanel()
end
