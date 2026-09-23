local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("Menu")

-- Lua API
local math_floor = math.floor
local setmetatable = setmetatable
local unpack = unpack

-- WoW API
local CreateFrame = CreateFrame
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory

-- Layout grid
-------------------------------------------------------
-- Every control is positioned from its page's top left corner on a shared
-- grid, never relative to its neighbour, so columns line up across all the
-- pages no matter how wide a (localized) label is.
-- modules/minimap/Components/Menu/Menu.lua uses the same numbers.
local EDGE = 16                  -- page padding, and the left column
local CHECK_X = EDGE - 2         -- checkbox art has a 2px transparent margin
local INDENT = EDGE + 24         -- settings that belong to the checkbox above
local SLIDER_WIDTH = 160
local SLIDER_COLUMN = 200        -- distance between two sliders on one row
local RADIO_OVERHANG = 8         -- picker radios stick out past the box

local TITLE_HEIGHT = 16
local HEADER_HEIGHT = 16
local LABEL_HEIGHT = 14
local CHECK_HEIGHT = 26
local BUTTON_HEIGHT = 24
local SLIDER_LABEL_HEIGHT = 16   -- the template's label sits above the bar
local SLIDER_BLOCK_HEIGHT = SLIDER_LABEL_HEIGHT + 15 + 22 -- label, bar, low/high + input
local PICKER_HEIGHT = 80 + RADIO_OVERHANG * 2

local SECTION_GAP = 24           -- above a section header
local HEADER_GAP = 8             -- between a header and its first row
local ROW_GAP = 4                -- between rows of the same section

local GROUP_PAD = 10             -- a group's border sits this far outside its columns
local GROUP_WIDTH = (INDENT + SLIDER_COLUMN + SLIDER_WIDTH + GROUP_PAD) - (EDGE - GROUP_PAD)
local GROUP_BACKDROP = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 12,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

local Layout = {}
Layout.__index = Layout

local NewLayout = function(page)
	return setmetatable({ page = page, y = -EDGE }, Layout)
end

-- Reserves the next row and returns the y offset its top edge sits at.
Layout.Row = function(self, height, gap)
	local top = self.y - (gap or 0)
	self.y = top - height
	return top
end

Layout.Place = function(self, region, x, top)
	region:SetPoint("TOPLEFT", self.page, "TOPLEFT", x, top)
end

-- Sliders are placed by the top of their label, not of the bar itself.
Layout.PlaceSlider = function(self, slider, x, top)
	slider:SetPoint("TOPLEFT", self.page, "TOPLEFT", x, top - SLIDER_LABEL_HEIGHT)
end

-- A bordered box around a checkbox and the settings it controls. Controls
-- inside it keep using the page's columns; only the border sits outside.
-- Parent those controls to the returned frame so they draw above it.
Layout.BeginGroup = function(self, gap)
	local group = CreateFrame("Frame", nil, self.page)
	group:SetBackdrop(GROUP_BACKDROP)
	group:SetBackdropColor(0, 0, 0, .25)
	group:SetBackdropBorderColor(1, 1, 1, 1)
	group.top = self.y - (gap or 0)
	self.y = group.top - GROUP_PAD
	return group
end

Layout.EndGroup = function(self, group)
	self.y = self.y - GROUP_PAD
	group:SetPoint("TOPLEFT", self.page, "TOPLEFT", EDGE - GROUP_PAD, group.top)
	group:SetSize(GROUP_WIDTH, group.top - self.y)
end

-- Widgets
-------------------------------------------------------
local CreateTitle = function(page, layout, text)
	local title = page:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetText(text)
	layout:Place(title, EDGE, layout:Row(TITLE_HEIGHT))
	return title
end

-- The small lettermark crest shown top-right on the submenu pages.
local CreateSubmenuLogo = function(page)
	local logo = page:CreateTexture(nil, "ARTWORK")
	logo:SetSize(32, 32)
	logo:SetPoint("TOPRIGHT", -EDGE, -EDGE)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\diabolic-lettermark.tga]]):format(Addon))
	logo:SetTexCoord(90/512, 422/512, 90/512, 422/512)
	return logo
end

local CreateHeader = function(page, layout, text)
	local header = page:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	header:SetText(text)
	layout:Place(header, EDGE, layout:Row(HEADER_HEIGHT, SECTION_GAP))
	return header
end

-- A smaller gold label naming the control below it, with its description
-- shown on hover.
local CreateFieldLabel = function(page, layout, text, tooltipText, gap)
	local label = page:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	layout:Place(label, EDGE, layout:Row(LABEL_HEIGHT, gap))

	-- FontStrings can't take mouse input themselves, so a same-sized
	-- frame on top of it is what actually shows the description on hover.
	local hitbox = CreateFrame("Frame", nil, page)
	hitbox:SetAllPoints(label)
	hitbox:EnableMouse(true)
	hitbox:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(text)
		GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
		GameTooltip:Show()
	end)
	hitbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	return label
end

-- Placed by the caller; checkboxes on a row of their own use CHECK_X.
local CreateCheckbox = function(parent, name, label, tooltipText, onClick)
	local checkbox = CreateFrame("CheckButton", "DiabolicUIOptionsPanel"..name, parent, "InterfaceOptionsCheckButtonTemplate")
	_G[checkbox:GetName().."Text"]:SetText(label)
	checkbox.tooltipText = label
	checkbox.tooltipRequirement = tooltipText
	checkbox:SetScript("OnClick", onClick)
	return checkbox
end

local CreateButton = function(parent, name, label, tooltipText, onClick)
	local button = CreateFrame("Button", "DiabolicUIOptionsPanel"..name, parent, "UIPanelButtonTemplate")
	button:SetSize(150, BUTTON_HEIGHT)
	button:SetText(label)
	button:SetScript("OnClick", onClick)
	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(label)
		GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	return button
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
-- both ways. Placed by the caller with Layout:PlaceSlider. snapRange, if
-- given, makes values dragged near 0 snap to it.
local CreateValueSlider = function(parent, name, label, tooltipText, minValue, maxValue, getValue, setValue, snapRange)
	local slider = CreateFrame("Slider", "DiabolicUIOptionsPanel"..name, parent, "OptionsSliderTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetWidth(SLIDER_WIDTH)
	slider:SetHeight(15)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetMinMaxValues(minValue, maxValue)
	slider:SetValueStep(1)
	slider:SetBackdrop(SLIDER_BACKDROP)
	slider:SetThumbTexture(SLIDER_THUMB_TEXTURE)

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
	local input = CreateFrame("EditBox", "DiabolicUIOptionsPanel"..name.."Input", parent)
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
	slider.SetValueSilently = function(self, value)
		setSilently(value)
	end

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

local CreateOffsetSlider = function(parent, name, label, tooltipText, getValue, setValue)
	return CreateValueSlider(parent, name, label, tooltipText, SLIDER_MIN, SLIDER_MAX, getValue, setValue, SLIDER_SNAP_RANGE)
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
-- anchored to the cursor. Placed at the given row; the radios hang past the
-- box by RADIO_OVERHANG, so the box is inset by that much to keep the
-- outermost radios on the page's column.
local CreateAnchorPointPicker = function(page, layout, top, getValue, setValue)
	local preview = CreateFrame("Frame", nil, page)
	preview:SetSize(120, 80)
	layout:Place(preview, EDGE + RADIO_OVERHANG, top - RADIO_OVERHANG)
	preview:SetBackdrop(GROUP_BACKDROP)
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

-- Pages
-------------------------------------------------------
Module.CreateOptionsPanel = function(self)
	local db = self:GetConfig("UnitFrames")
	local tooltipsDB = Engine:GetConfig("Tooltips")
	local actionbarsDB = Engine:GetConfig("ActionBars", "character")
	local objectivesDB = Engine:GetConfig("ObjectiveTracker")
	local lootDB = Engine:GetConfig("LootFrame")
	local UnitFrames = Engine:GetModule("UnitFrames")

	-- Main page
	-------------------------------------------------------
	local panel = CreateFrame("Frame", "DiabolicUIOptionsPanel", InterfaceOptionsFramePanelContainer)
	panel.name = "DiabolicUI"
	panel:Hide()

	local layout = NewLayout(panel)
	CreateTitle(panel, layout, "DiabolicUI")

	local logo = panel:CreateTexture(nil, "ARTWORK")
	logo:SetSize(160, 80)
	logo:SetPoint("TOPRIGHT", -EDGE, -EDGE)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\DiabolicUI_Logo.tga]]):format(Addon))

	-- Menu
	CreateHeader(panel, layout, L["Menu"])

	local showGold = CreateCheckbox(panel, "ShowGold", L["Show Gold"], L["Shows how much money you're carrying, next to the menu button in the bottom right corner."], function(button)
		actionbarsDB.showGold = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdateGoldVisibility()
	end)
	layout:Place(showGold, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	local showPerformance = CreateCheckbox(panel, "ShowPerformance", L["Show FPS & Latency"], L["Shows your framerate and latency, next to the menu button in the bottom right corner."], function(button)
		actionbarsDB.showPerformance = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdatePerformanceVisibility()
	end)
	layout:Place(showPerformance, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	-- Objectives
	CreateHeader(panel, layout, L["Objectives"])

	local updateTrackerSlidersEnabled -- assigned once the sliders exist

	local trackerGroup = layout:BeginGroup(HEADER_GAP)

	local fadeTracker = CreateCheckbox(trackerGroup, "FadeTracker", L["Fade Quest Tracker"], L["Fades the quest tracker out after it hasn't been moused over for a while, and shows it again as soon as you mouse over it.|n|nUses Questie's tracker when it's enabled, Blizzard's otherwise."], function(button)
		objectivesDB.fadeTracker = button:GetChecked() and true or false
		Engine:GetModule("ObjectiveTracker"):ApplyFadeSetting()
		updateTrackerSlidersEnabled()
	end)
	layout:Place(fadeTracker, CHECK_X, layout:Row(CHECK_HEIGHT))

	local trackerTimeFading = CreateValueSlider(trackerGroup, "ObjectivesTimeFading", L["Time Fading"], L["How many seconds the tracker stays fully visible before it starts fading, once you stop hovering it."],
		1, 30,
		function() return objectivesDB.fadeDelay end,
		function(value) objectivesDB.fadeDelay = value end)

	local trackerOpacity = CreateValueSlider(trackerGroup, "ObjectivesOpacity", L["Opacity"], L["How visible the tracker stays once it has fully faded, as a percentage."],
		0, 100,
		function() return objectivesDB.fadeOpacity end,
		function(value) objectivesDB.fadeOpacity = value end)

	local trackerSliders = layout:Row(SLIDER_BLOCK_HEIGHT, ROW_GAP)
	layout:PlaceSlider(trackerTimeFading, INDENT, trackerSliders)
	layout:PlaceSlider(trackerOpacity, INDENT + SLIDER_COLUMN, trackerSliders)

	layout:EndGroup(trackerGroup)

	-- Time Fading / Opacity only matter while the tracker fade is
	-- actually enabled, so grey them out and block input otherwise.
	updateTrackerSlidersEnabled = function()
		trackerTimeFading:SetEnabled(objectivesDB.fadeTracker)
		trackerOpacity:SetEnabled(objectivesDB.fadeTracker)
	end

	-- Loot
	CreateHeader(panel, layout, L["Loot"])

	local reskinLoot = CreateCheckbox(panel, "ReskinLoot", L["Reskin Loot Window"], L["Re-styles the loot window to match the rest of the UI. When disabled, Blizzard's own loot window is used instead.|n|nRequires a UI reload to apply."], function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= lootDB.enableSkin) then
			lootDB.enableSkin = checked
			Engine:ReloadUI()
		end
	end)
	layout:Place(reskinLoot, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

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
	panel.cancel()

	InterfaceOptions_AddCategory(panel)

	-- Tooltips page
	-------------------------------------------------------
	local tooltipsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelTooltips", InterfaceOptionsFramePanelContainer)
	tooltipsPanel.name = L["Tooltips"]
	tooltipsPanel.parent = panel.name
	tooltipsPanel:Hide()

	layout = NewLayout(tooltipsPanel)
	CreateTitle(tooltipsPanel, layout, L["Tooltips"])
	CreateSubmenuLogo(tooltipsPanel)

	CreateFieldLabel(tooltipsPanel, layout, L["Tooltip mouse anchor"], L["Which point of the tooltip gets anchored to your cursor, so you can pick the corner or edge that overlaps your mouse the least."], SECTION_GAP)

	-- The picker on the left, its offset sliders stacked in the second column.
	local offsetX = CreateOffsetSlider(tooltipsPanel, "TooltipOffsetX", L["Horizontal Offset"], L["At 0, the tooltip is centered horizontally on the cursor."],
		function() return tooltipsDB.offsetX end,
		function(value) tooltipsDB.offsetX = value end)

	local offsetY = CreateOffsetSlider(tooltipsPanel, "TooltipOffsetY", L["Vertical Offset"], L["At 0, the cursor is at the bottom edge of the tooltip."],
		function() return tooltipsDB.offsetY end,
		function(value) tooltipsDB.offsetY = value end)

	local pickerRow = layout:Row(math.max(PICKER_HEIGHT, SLIDER_BLOCK_HEIGHT * 2 + ROW_GAP), HEADER_GAP)
	local _, refreshAnchorPoint = CreateAnchorPointPicker(tooltipsPanel, layout, pickerRow,
		function() return tooltipsDB.anchorPoint end,
		function(value) tooltipsDB.anchorPoint = value end)
	layout:PlaceSlider(offsetX, EDGE + SLIDER_COLUMN, pickerRow)
	layout:PlaceSlider(offsetY, EDGE + SLIDER_COLUMN, pickerRow - SLIDER_BLOCK_HEIGHT - ROW_GAP)

	tooltipsPanel.okay = function() end
	tooltipsPanel.cancel = function()
		offsetX:SetValueSilently(tooltipsDB.offsetX)
		offsetY:SetValueSilently(tooltipsDB.offsetY)
		refreshAnchorPoint()
	end
	tooltipsPanel.refresh = tooltipsPanel.cancel

	InterfaceOptions_AddCategory(tooltipsPanel)

	-- Units page
	-------------------------------------------------------
	local unitsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelUnits", InterfaceOptionsFramePanelContainer)
	unitsPanel.name = L["Units"]
	unitsPanel.parent = panel.name
	unitsPanel:Hide()

	layout = NewLayout(unitsPanel)
	CreateTitle(unitsPanel, layout, L["Units"])
	CreateSubmenuLogo(unitsPanel)

	CreateHeader(unitsPanel, layout, L["Appearance"])

	local classColors = CreateCheckbox(unitsPanel, "ClassColors", L["Show class colors"], L["Colors the player, target, party, raid and tab-target of target health bars by the unit's class.|n|nRequires a UI reload to apply."], function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= db.showClassColors) then
			db.showClassColors = checked
			Engine:ReloadUI()
		end
	end)
	layout:Place(classColors, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	local showPortrait = CreateCheckbox(unitsPanel, "ShowPortrait", L["Show Portrait"], L["Shows an animated 3D model portrait on party and focus frames.|n|nRequires a UI reload to apply."], function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= db.showPortrait) then
			db.showPortrait = checked
			Engine:ReloadUI()
		end
	end)
	layout:Place(showPortrait, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	-- Advanced
	CreateHeader(unitsPanel, layout, L["Advanced"])

	local toggleFakeParty = CreateButton(unitsPanel, "ToggleFakeParty", L["Toggle Fake Party"], L["Shows or hides a mock party of fake members, to preview the party frames' look without needing a real group."], function(button)
		db.testPartyMode = not db.testPartyMode
		UnitFrames:SetPartyMockShown(db.testPartyMode)
	end)

	local toggleFakeRaid = CreateButton(unitsPanel, "ToggleFakeRaid", L["Toggle Fake Raid"], L["Shows or hides a mock raid of fake members, to preview the raid frames' look without needing a real group."], function(button)
		db.testRaidMode = not db.testRaidMode
		UnitFrames:SetRaidMockShown(db.testRaidMode)
	end)

	local buttonRow = layout:Row(BUTTON_HEIGHT, HEADER_GAP)
	layout:Place(toggleFakeParty, EDGE, buttonRow)
	layout:Place(toggleFakeRaid, EDGE + SLIDER_COLUMN, buttonRow)

	unitsPanel.okay = function() end
	unitsPanel.cancel = function()
		classColors:SetChecked(db.showClassColors)
		showPortrait:SetChecked(db.showPortrait)
	end
	unitsPanel.refresh = unitsPanel.cancel
	unitsPanel.cancel()

	InterfaceOptions_AddCategory(unitsPanel)

	-- Chat page
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

	layout = NewLayout(chatPanel)
	CreateTitle(chatPanel, layout, L["Chat"])
	CreateSubmenuLogo(chatPanel)

	-- Appearance
	CreateHeader(chatPanel, layout, L["Appearance"])

	local backgroundOpacity = CreateValueSlider(chatPanel, "ChatBackgroundOpacity", L["Background Opacity"], L["How opaque the chat window's background is while you're typing."],
		0, 100,
		function() return chatDB.backgroundOpacity end,
		function(value)
			chatDB.backgroundOpacity = value
			Engine:GetModule("ChatWindows"):ApplyBackgroundOpacity()
		end)
	layout:PlaceSlider(backgroundOpacity, EDGE, layout:Row(SLIDER_BLOCK_HEIGHT, HEADER_GAP))

	local updateFadeSlidersEnabled -- assigned once the sliders exist

	local fadeGroup = layout:BeginGroup(SECTION_GAP)

	local fadeChat = CreateCheckbox(fadeGroup, "FadeChat", L["Fade Chat"], L["Fades chat text out after it has been visible for a while, instead of leaving it on screen permanently."], function(button)
		chatDB.fadeChat = button:GetChecked() and true or false
		applyChatFadeSettings()
		updateFadeSlidersEnabled()
	end)
	layout:Place(fadeChat, CHECK_X, layout:Row(CHECK_HEIGHT))

	local timeFading = CreateValueSlider(fadeGroup, "ChatTimeFading", L["Time Fading"], L["How many seconds it takes for chat text to fade out."],
		1, 5,
		function() return chatDB.timeFading end,
		function(value)
			chatDB.timeFading = value
			applyChatFadeSettings()
		end)

	local timeVisible = CreateValueSlider(fadeGroup, "ChatTimeVisible", L["Time Visible"], L["How many seconds chat text stays fully visible before it starts fading."],
		5, 120,
		function() return chatDB.timeVisible end,
		function(value)
			chatDB.timeVisible = value
			applyChatFadeSettings()
		end)

	local fadeSliders = layout:Row(SLIDER_BLOCK_HEIGHT, ROW_GAP)
	layout:PlaceSlider(timeFading, INDENT, fadeSliders)
	layout:PlaceSlider(timeVisible, INDENT + SLIDER_COLUMN, fadeSliders)

	layout:EndGroup(fadeGroup)

	-- Time Fading / Time Visible only matter while chat is actually
	-- set to fade, so grey them out and block input otherwise.
	updateFadeSlidersEnabled = function()
		timeFading:SetEnabled(chatDB.fadeChat)
		timeVisible:SetEnabled(chatDB.fadeChat)
	end

	-- Miscellaneous
	CreateHeader(chatPanel, layout, L["Miscellaneous"])

	local copyWebLinks = CreateCheckbox(chatPanel, "ChatCopyWebLinks", L["Copy Web Links"], L["Left-click a web link (http:// or https://) in the chat to open a popup with it, selected and ready to copy."], function(button)
		chatFiltersDB.copyWebLinks = button:GetChecked() and true or false
	end)
	layout:Place(copyWebLinks, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

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
	chatPanel.cancel()

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
