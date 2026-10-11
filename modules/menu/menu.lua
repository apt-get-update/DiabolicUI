local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("Menu")

-- Lua API
local ipairs = ipairs
local math_floor = math.floor
local pairs = pairs
local setmetatable = setmetatable
local unpack = unpack

-- WoW API
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_DisableDropDown = UIDropDownMenu_DisableDropDown
local UIDropDownMenu_EnableDropDown = UIDropDownMenu_EnableDropDown
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local UIDropDownMenu_JustifyText = UIDropDownMenu_JustifyText
local UIDropDownMenu_SetText = UIDropDownMenu_SetText
local UIDropDownMenu_SetWidth = UIDropDownMenu_SetWidth
local GetAddOnMetadata = GetAddOnMetadata
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
local CHECK_COLUMN = 230         -- distance between two checkboxes on one row
local RADIO_OVERHANG = 8         -- picker radios stick out past the box

local TITLE_HEIGHT = 16
local HEADER_HEIGHT = 16
local LABEL_HEIGHT = 14
local CHECK_HEIGHT = 26
local BUTTON_HEIGHT = 24
local SLIDER_LABEL_HEIGHT = 16   -- the template's label sits above the bar
local SLIDER_BLOCK_HEIGHT = SLIDER_LABEL_HEIGHT + 15 + 22 -- label, bar, low/high + input
local PICKER_HEIGHT = 80 + RADIO_OVERHANG * 2
local INTRO_WIDTH = 380          -- the main page's texts
local LOGO_HEIGHT = 80           -- the main page's logo, top right
local SPEC_COLUMN = 199          -- distance between the two specialization columns
local SPEC_WIDTH = 182           -- a specialization's column: two fit the 413 wide page
local SPEC_ICON_SIZE = 32
local SPEC_LABEL_WIDTH = 84      -- "Action Bars" left of its small dropdown
local DROPDOWN_HEIGHT = 32
local DROPDOWN_OVERHANG = 16     -- the template's art starts this far right of its frame
local DROPDOWN_WIDTH = SPEC_WIDTH - 44
local SMALL_DROPDOWN_WIDTH = 70

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

-- A Blizzard dropdown. `getItems()` lists the choices, each { text, value,
-- icon }, fresh every time it opens; `getValue()` and `setValue(value)` read
-- and save the chosen one. Placed by the caller, its art DROPDOWN_OVERHANG
-- to the right of where it's anchored.
local CreateDropDown = function(parent, name, width, getItems, getValue, setValue)
	local dropDown = CreateFrame("Frame", "DiabolicUIOptionsPanel"..name, parent, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(dropDown, width)
	UIDropDownMenu_JustifyText(dropDown, "LEFT")

	local label = function(item)
		return item.icon and ("|T" .. item.icon .. ":16:16:0:0|t " .. item.text) or item.text
	end

	-- the closed dropdown shows the saved choice, or the saved name greyed
	-- out when it's gone (a deleted equipment set)
	dropDown.Refresh = function(self)
		local current = getValue()
		for _, item in ipairs(getItems()) do
			if (item.value == current) then
				UIDropDownMenu_SetText(self, label(item))
				return
			end
		end
		UIDropDownMenu_SetText(self, "|cff808080" .. tostring(current) .. "|r")
	end

	local choose = function(button, value)
		setValue(value)
		dropDown:Refresh()
	end

	UIDropDownMenu_Initialize(dropDown, function(self, level)
		local current = getValue()
		for _, item in ipairs(getItems()) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = label(item)
			info.arg1 = item.value
			info.checked = (item.value == current)
			info.func = choose
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	return dropDown
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
	logo:SetSize(160, LOGO_HEIGHT)
	logo:SetPoint("TOPRIGHT", -EDGE, -EDGE)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\DiabolicUI_Logo.tga]]):format(Addon))

	-- what's where, and the chat commands
	local intro = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	intro:SetJustifyH("LEFT")
	intro:SetWidth(INTRO_WIDTH)
	intro:SetText(L["A Diablo III style interface. Its settings are on the pages below this one."])
	layout:Place(intro, EDGE, layout:Row(LABEL_HEIGHT * 2, LOGO_HEIGHT - TITLE_HEIGHT + SECTION_GAP))

	CreateHeader(panel, layout, L["Chat Commands"])
	local commands = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	commands:SetJustifyH("LEFT")
	commands:SetWidth(INTRO_WIDTH)
	commands:SetText(L["/dui config - these options|n/dui move - unlocks the minimap, the chat, the menu buttons and the quest tracker to move them|n/dui num_bars 1-3 - the number of action bars|n/dui num_side_bars 0-2 - the number of side bars|n/dui tracker reset - puts the quest tracker back"])
	layout:Place(commands, EDGE, layout:Row(LABEL_HEIGHT * 5, HEADER_GAP))

	local unlockFrames = CreateButton(panel, "UnlockFrames", L["Unlock Frames"], L["Highlights the frames you can move - the minimap, the chat, the menu buttons, the quest tracker (Blizzard's or Questie's) and TrinketMenu - to drag them around. Right-drag the minimap to resize it. A Lock Frames button locks them in their new places.|n|nAlso: /dui move"], function(button)
		self:SetFramesUnlocked(not self:AreFramesUnlocked())
	end)
	layout:Place(unlockFrames, EDGE, layout:Row(BUTTON_HEIGHT, SECTION_GAP))
	self.UnlockFramesButton = unlockFrames

	-- the size of DiabolicUI's own frame ("ScreenScaling", also /dui setscale);
	-- applied out of combat (the frame is secure)
	local scaling = Engine:GetConfig("ScreenScaling")
	local uiScale = CreateValueSlider(panel, "UIScale", L["UI Scale"], L["The size of DiabolicUI's bars, orbs, frames and everything on them, as a percentage of the size made for your screen. WoW's own UI scale and other addons aren't changed.|n|nAlso: /dui setscale 0.9"],
		50, 150,
		function() return math_floor(scaling.scale * 100 + .5) end,
		function(value)
			scaling.scale = value / 100
			Engine:OnDisplaySizeEvent()
			self:ApplyUIScale()
		end)
	layout:PlaceSlider(uiScale, EDGE, layout:Row(SLIDER_BLOCK_HEIGHT, SECTION_GAP))

	local version = panel:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
	version:SetPoint("BOTTOMRIGHT", -EDGE, EDGE)
	version:SetText(L["Version %s"]:format(GetAddOnMetadata(Addon, "Version") or "?"))

	panel.okay = function() end
	panel.cancel = function()
		unlockFrames:SetText(self:AreFramesUnlocked() and L["Lock Frames"] or L["Unlock Frames"])
		uiScale:SetValueSilently(math_floor(scaling.scale * 100 + .5))
	end
	panel.refresh = panel.cancel

	InterfaceOptions_AddCategory(panel)

	-- Action Bars page
	-------------------------------------------------------
	local actionBarsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelActionBars", InterfaceOptionsFramePanelContainer)
	actionBarsPanel.name = L["Action Bars"]
	actionBarsPanel.parent = panel.name
	actionBarsPanel:Hide()

	layout = NewLayout(actionBarsPanel)
	CreateTitle(actionBarsPanel, layout, L["Action Bars"])
	CreateSubmenuLogo(actionBarsPanel)

	CreateHeader(actionBarsPanel, layout, L["Menu"])

	local showGold = CreateCheckbox(actionBarsPanel, "ShowGold", L["Show Gold"], L["Shows how much money you're carrying, next to the menu button in the bottom right corner."], function(button)
		actionbarsDB.showGold = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdateGoldVisibility()
	end)
	layout:Place(showGold, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	local showPerformance = CreateCheckbox(actionBarsPanel, "ShowPerformance", L["Show FPS & Latency"], L["Shows your framerate and latency, next to the menu button in the bottom right corner."], function(button)
		actionbarsDB.showPerformance = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdatePerformanceVisibility()
	end)
	layout:Place(showPerformance, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	local showSpecSwitch = CreateCheckbox(actionBarsPanel, "ShowSpecSwitch", L["Show Specialization Switch"], L["Shows a button on top of the skull in the middle of the action bars that switches to your other talent specialization, once you learn Dual Talent Specialization."], function(button)
		actionbarsDB.showSpecSwitch = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Button: Spec Switch"):Update()
		if _G.DiabolicUIOptionsPanelSpecs then
			_G.DiabolicUIOptionsPanelSpecs.refresh()
		end
	end)
	layout:Place(showSpecSwitch, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	-- the menu buttons move with Unlock Frames on the main page; this puts them back
	local resetMenu = CreateButton(actionBarsPanel, "ResetMenu", L["Reset Position"], L["Puts the menu buttons, with the gold and the fps texts, back in the bottom right corner."], function(button)
		Engine:GetModule("ActionBars"):GetWidget("Controller: Menu"):ResetPosition()
	end)
	layout:Place(resetMenu, EDGE, layout:Row(BUTTON_HEIGHT, SECTION_GAP))

	actionBarsPanel.okay = function() end
	actionBarsPanel.cancel = function()
		showGold:SetChecked(actionbarsDB.showGold)
		showPerformance:SetChecked(actionbarsDB.showPerformance)
		showSpecSwitch:SetChecked(actionbarsDB.showSpecSwitch)
	end
	actionBarsPanel.refresh = actionBarsPanel.cancel
	actionBarsPanel.cancel()

	InterfaceOptions_AddCategory(actionBarsPanel)

	-- Specializations page: what each talent specialization sets up once
	-- you switch to it (modules/actionbars/elements/specswitch.lua)
	-------------------------------------------------------
	local specSwitch = Engine:GetModule("ActionBars"):GetWidget("Button: Spec Switch")

	local specsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelSpecs", InterfaceOptionsFramePanelContainer)
	specsPanel.name = L["Specializations"]
	specsPanel.parent = panel.name
	specsPanel:Hide()

	layout = NewLayout(specsPanel)
	CreateTitle(specsPanel, layout, L["Specializations"])
	CreateSubmenuLogo(specsPanel)

	-- the same rows in both columns
	local rows = {
		header = layout:Row(SPEC_ICON_SIZE, HEADER_GAP),
		equipSetLabel = layout:Row(LABEL_HEIGHT, 12),
		equipSet = layout:Row(DROPDOWN_HEIGHT, 2),
		profileLabel = layout:Row(LABEL_HEIGHT, 6),
		profile = layout:Row(DROPDOWN_HEIGHT, 2),
		bars = layout:Row(DROPDOWN_HEIGHT, 6),
		sideBars = layout:Row(DROPDOWN_HEIGHT, 2),
		macroBeforeLabel = layout:Row(LABEL_HEIGHT, 6),
		macroBefore = layout:Row(DROPDOWN_HEIGHT, 2),
		macroLabel = layout:Row(LABEL_HEIGHT, 6),
		macro = layout:Row(DROPDOWN_HEIGHT, 2),
	}

	local specLabel = function(text, tooltipText)
		local label = specsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		label:SetJustifyH("LEFT")
		label:SetText(text)
		if tooltipText then
			local hitbox = CreateFrame("Frame", nil, specsPanel)
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
		end
		return label
	end

	-- a saved choice, false when it's left as it is
	local specSetting = function(key)
		return function() return actionbarsDB[key] or false end,
			function(value) actionbarsDB[key] = value end
	end

	local barChoices = function(counts)
		return function()
			local items = { { text = L["Unchanged"], value = false } }
			for _, count in ipairs(counts) do
				items[#items + 1] = { text = tostring(count), value = count }
			end
			return items
		end
	end

	local specColumns = {}
	for group = 1, 2 do
		local x = EDGE + (group - 1) * SPEC_COLUMN
		local column = {}

		column.icon = specsPanel:CreateTexture(nil, "ARTWORK")
		column.icon:SetSize(SPEC_ICON_SIZE, SPEC_ICON_SIZE)
		layout:Place(column.icon, x, rows.header)

		column.name = specsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		column.name:SetJustifyH("LEFT")
		column.name:SetPoint("LEFT", column.icon, "RIGHT", 8, 0)

		-- equipment set
		layout:Place(specLabel(L["Equipment Set"], L["The equipment set to put on once you switch to this specialization, from the equipment manager of your character window."]), x, rows.equipSetLabel)
		local getSet, setSet = specSetting("specEquipSet" .. group)
		column.equipSet = CreateDropDown(specsPanel, "Spec" .. group .. "EquipSet", DROPDOWN_WIDTH, function()
			local items = { { text = L["None"], value = false } }
			for _, item in ipairs(specSwitch:GetEquipmentSets()) do
				items[#items + 1] = item
			end
			return items
		end, getSet, setSet)
		layout:Place(column.equipSet, x - DROPDOWN_OVERHANG, rows.equipSet)

		-- Action Bar Saver profile
		layout:Place(specLabel(L["Action Bar Saver Profile"], L["The Action Bar Saver profile to restore once you switch to this specialization. Save one with '/abs save <name>'."]), x, rows.profileLabel)
		local getProfile, setProfile = specSetting("specProfile" .. group)
		column.profile = CreateDropDown(specsPanel, "Spec" .. group .. "Profile", DROPDOWN_WIDTH, function()
			local items = { { text = L["None"], value = false } }
			for _, item in ipairs(specSwitch:GetActionBarProfiles() or {}) do
				items[#items + 1] = item
			end
			return items
		end, getProfile, setProfile)
		layout:Place(column.profile, x - DROPDOWN_OVERHANG, rows.profile)

		-- number of action bars and side bars
		local getBars, setBars = specSetting("specBars" .. group)
		column.bars = CreateDropDown(specsPanel, "Spec" .. group .. "Bars", SMALL_DROPDOWN_WIDTH, barChoices({ 1, 2, 3 }), getBars, setBars)
		layout:Place(column.bars, x + SPEC_LABEL_WIDTH - DROPDOWN_OVERHANG, rows.bars)
		specLabel(L["Action Bars"]):SetPoint("LEFT", specsPanel, "TOPLEFT", x, rows.bars - DROPDOWN_HEIGHT / 2)

		local getSideBars, setSideBars = specSetting("specSideBars" .. group)
		column.sideBars = CreateDropDown(specsPanel, "Spec" .. group .. "SideBars", SMALL_DROPDOWN_WIDTH, barChoices({ 0, 1, 2 }), getSideBars, setSideBars)
		layout:Place(column.sideBars, x + SPEC_LABEL_WIDTH - DROPDOWN_OVERHANG, rows.sideBars)
		specLabel(L["Side Bars"]):SetPoint("LEFT", specsPanel, "TOPLEFT", x, rows.sideBars - DROPDOWN_HEIGHT / 2)

		-- anything else: macros, run by clicks on the skull's button
		local macroChoices = function()
			local items = { { text = L["None"], value = false } }
			for _, item in ipairs(specSwitch:GetMacros()) do
				items[#items + 1] = item
			end
			return items
		end

		layout:Place(specLabel(L["Macro Before"], L["A macro of yours to run as you switch to this specialization: the click on the skull's specialization button that switches runs it first."]), x, rows.macroBeforeLabel)
		local getBefore, setBefore = specSetting("specMacroBefore" .. group)
		column.macroBefore = CreateDropDown(specsPanel, "Spec" .. group .. "MacroBefore", DROPDOWN_WIDTH, macroChoices, getBefore, setBefore)
		layout:Place(column.macroBefore, x - DROPDOWN_OVERHANG, rows.macroBefore)

		layout:Place(specLabel(L["Macro After"], L["A macro of yours to run once you switch to this specialization. The game only runs macros on a click, so the specialization button on the skull glows, and its next click runs the macro."]), x, rows.macroLabel)
		local getMacro, setMacro = specSetting("specMacroName" .. group)
		column.macro = CreateDropDown(specsPanel, "Spec" .. group .. "Macro", DROPDOWN_WIDTH, macroChoices, getMacro, setMacro)
		layout:Place(column.macro, x - DROPDOWN_OVERHANG, rows.macro)

		specColumns[group] = column
	end

	specsPanel.okay = function() end
	specsPanel.cancel = function()
		local profilesLoaded = specSwitch:GetActionBarProfiles() and true
		for group, column in ipairs(specColumns) do
			local name, _, icon = specSwitch:GetSpec(group)
			column.icon:SetTexture(icon or [[Interface\Icons\INV_Misc_QuestionMark]])
			column.name:SetText(name or (group == 1 and _G.PRIMARY or _G.SECONDARY))
			column.equipSet:Refresh()
			column.bars:Refresh()
			column.sideBars:Refresh()
			if profilesLoaded then
				UIDropDownMenu_EnableDropDown(column.profile)
				column.profile:Refresh()
			else
				UIDropDownMenu_DisableDropDown(column.profile)
				UIDropDownMenu_SetText(column.profile, "|cff808080" .. L["Action Bar Saver isn't loaded"] .. "|r")
			end
			-- the macros run on clicks of the skull's button
			for _, dropDown in ipairs({ column.macroBefore, column.macro }) do
				if actionbarsDB.showSpecSwitch then
					UIDropDownMenu_EnableDropDown(dropDown)
					dropDown:Refresh()
				else
					UIDropDownMenu_DisableDropDown(dropDown)
					UIDropDownMenu_SetText(dropDown, "|cff808080" .. L["Needs Show Specialization Switch"] .. "|r")
				end
			end
		end
	end
	specsPanel.refresh = specsPanel.cancel
	specsPanel.cancel()

	InterfaceOptions_AddCategory(specsPanel)

	-- Tooltips page
	-------------------------------------------------------
	local tooltipsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelTooltips", InterfaceOptionsFramePanelContainer)
	tooltipsPanel.name = L["Tooltips"]
	tooltipsPanel.parent = panel.name
	tooltipsPanel:Hide()

	layout = NewLayout(tooltipsPanel)
	CreateTitle(tooltipsPanel, layout, L["Tooltips"])
	CreateSubmenuLogo(tooltipsPanel)

	local reskinTooltip = CreateCheckbox(tooltipsPanel, "ReskinTooltip", L["Reskin Tooltip"], L["Shows item tooltips in the Diablo III style: the item's name on a title banner in its quality color, its icon on the left, damage per second or armor as a big number, and the sell price and durability at the bottom.|n|nWhen disabled, Blizzard's own item tooltips are used."], function(button)
		tooltipsDB.reskinTooltip = button:GetChecked() and true or false
	end)
	layout:Place(reskinTooltip, CHECK_X, layout:Row(CHECK_HEIGHT, SECTION_GAP))

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
		reskinTooltip:SetChecked(tooltipsDB.reskinTooltip)
		offsetX:SetValueSilently(tooltipsDB.offsetX)
		offsetY:SetValueSilently(tooltipsDB.offsetY)
		refreshAnchorPoint()
	end
	tooltipsPanel.refresh = tooltipsPanel.cancel
	tooltipsPanel.cancel()

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

	local slideMessages = CreateCheckbox(chatPanel, "ChatSlideMessages", L["Slide New Messages"], L["New chat lines slide up into place instead of jumping. Not while you're typing in the chat, hovering it or scrolled up in it."], function(button)
		chatDB.slideMessages = button:GetChecked() and true or false
	end)
	layout:Place(slideMessages, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	-- the chat moves with Unlock Frames on the main page; this puts it back
	local resetChat = CreateButton(chatPanel, "ResetChat", L["Reset Position"], L["Puts the chat window back in the bottom left corner, sized like Diablo III's."], function(button)
		local chat = Engine:GetModule("ChatWindows")
		chat.db.autoposition = true
		chat:PositionChatFrames()
	end)
	layout:Place(resetChat, EDGE, layout:Row(BUTTON_HEIGHT, SECTION_GAP))

	chatPanel.okay = function() end
	chatPanel.cancel = function()
		fadeChat:SetChecked(chatDB.fadeChat)
		timeFading:SetValueSilently(chatDB.timeFading)
		timeVisible:SetValueSilently(chatDB.timeVisible)
		updateFadeSlidersEnabled()
		backgroundOpacity:SetValueSilently(chatDB.backgroundOpacity)
		slideMessages:SetChecked(chatDB.slideMessages)
	end
	chatPanel.refresh = chatPanel.cancel
	chatPanel.cancel()

	InterfaceOptions_AddCategory(chatPanel)

	-- Messages page: shorter system lines in the chat (modules/chat/cleaner.lua)
	-------------------------------------------------------
	local messagesPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelMessages", InterfaceOptionsFramePanelContainer)
	messagesPanel.name = L["Messages"]
	messagesPanel.parent = panel.name
	messagesPanel:Hide()

	layout = NewLayout(messagesPanel)
	CreateTitle(messagesPanel, layout, L["Messages"])
	CreateSubmenuLogo(messagesPanel)

	CreateHeader(messagesPanel, layout, L["Shorter Messages"])

	local cleanerChecks, cleanerRow = {}
	-- two per row, the longer labels on the left
	for i, option in ipairs({
		{ "cleanProgress", L["Experience, Reputation & Honor"], L["Shorter experience, reputation, honor, skill and level up lines, like '+ 75 Reputation: Argent Crusade'."] },
		{ "cleanQuests", L["Quests"], L["Shorter lines for quests accepted and completed."] },
		{ "cleanStatus", L["Away, Busy & Rested"], L["'You are now Away.' becomes '+ Away', and the same for busy and rested."] },
		{ "cleanOnline", L["Online & Offline"], L["Marks friends and guild members coming online with a green +, and dims them going offline."] },
		{ "cleanLoot", L["Loot & Money"], L["'You receive loot: [Item]x3.' becomes '+ [Item] (3)', and looted money shows as coins."] },
		{ "cleanAuctions", L["Auctions"], L["Marks auctions created, sold and won with a green +, and cancelled, outbid and expired ones with a red -."] },
		{ "cleanAchievements", L["Achievements"], L["'Name has earned the achievement [Name]!' becomes 'Name: [Name]'."] },
		{ "hideChatNoise", L["Hide Channel Notices"], L["Hides the notices of joining, leaving and changing chat channels, and empty chat lines."] },
	}) do
		local setting = option[1]
		local check = CreateCheckbox(messagesPanel, "MessagesCleaner" .. i, option[2], option[3], function(button)
			chatFiltersDB[setting] = button:GetChecked() and true or false
		end)
		if (i % 2 == 1) then
			cleanerRow = layout:Row(CHECK_HEIGHT, (i == 1) and HEADER_GAP or ROW_GAP)
		end
		layout:Place(check, (i % 2 == 1) and CHECK_X or (CHECK_X + CHECK_COLUMN), cleanerRow)
		cleanerChecks[setting] = check
	end

	messagesPanel.okay = function() end
	messagesPanel.cancel = function()
		for setting, check in pairs(cleanerChecks) do
			check:SetChecked(chatFiltersDB[setting])
		end
	end
	messagesPanel.refresh = messagesPanel.cancel
	messagesPanel.cancel()

	InterfaceOptions_AddCategory(messagesPanel)

	-- Quests page
	-------------------------------------------------------
	local skinsDB = Engine:GetConfig("AddOnSkins")

	-- on/off with a reload
	local reloadOption = function(config, setting)
		return function(button)
			local checked = button:GetChecked() and true or false
			if (checked ~= config[setting]) then
				config[setting] = checked
				Engine:ReloadUI()
			end
		end
	end

	local questsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelQuests", InterfaceOptionsFramePanelContainer)
	questsPanel.name = L["Quests"]
	questsPanel.parent = panel.name
	questsPanel:Hide()

	layout = NewLayout(questsPanel)
	CreateTitle(questsPanel, layout, L["Quests"])
	CreateSubmenuLogo(questsPanel)

	CreateHeader(questsPanel, layout, L["Objectives"])

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

	-- Blizzard's tracker moves with Unlock Frames on the main page; this
	-- puts it back (Questie's moves from its own options)
	local tracker = Engine:GetModule("ObjectiveTracker")
	local resetTracker = CreateButton(questsPanel, "ResetTracker", L["Reset Position"], L["Puts Blizzard's objectives tracker back under the minimap.|n|nAlso: /dui tracker reset"], function(button)
		tracker:ResetTrackerPosition()
	end)
	layout:Place(resetTracker, EDGE, layout:Row(BUTTON_HEIGHT, ROW_GAP * 2))

	-- Time Fading / Opacity only matter while the tracker fade is
	-- actually enabled, so grey them out and block input otherwise.
	updateTrackerSlidersEnabled = function()
		trackerTimeFading:SetEnabled(objectivesDB.fadeTracker)
		trackerOpacity:SetEnabled(objectivesDB.fadeTracker)
	end

	questsPanel.okay = function() end
	questsPanel.cancel = function()
		fadeTracker:SetChecked(objectivesDB.fadeTracker)
		trackerTimeFading:SetValueSilently(objectivesDB.fadeDelay)
		trackerOpacity:SetValueSilently(objectivesDB.fadeOpacity)
		updateTrackerSlidersEnabled()
	end
	questsPanel.refresh = questsPanel.cancel
	questsPanel.cancel()

	InterfaceOptions_AddCategory(questsPanel)

	-- Frames & AddOns page: Blizzard's loot window replaced, other addons
	-- styled like the UI (modules/blizzard/lootframe.lua, trinketmenu.lua)
	-------------------------------------------------------
	local addonsPanel = CreateFrame("Frame", "DiabolicUIOptionsPanelAddOns", InterfaceOptionsFramePanelContainer)
	addonsPanel.name = L["Frames & AddOns"]
	addonsPanel.parent = panel.name
	addonsPanel:Hide()

	layout = NewLayout(addonsPanel)
	CreateTitle(addonsPanel, layout, L["Frames & AddOns"])
	CreateSubmenuLogo(addonsPanel)

	CreateHeader(addonsPanel, layout, L["Blizzard Frames"])

	local reskinLoot = CreateCheckbox(addonsPanel, "ReskinLoot", L["Reskin Loot Window"], L["Re-styles the loot window to match the rest of the UI. When disabled, Blizzard's own loot window is used instead.|n|nRequires a UI reload to apply."], function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= lootDB.enableSkin) then
			lootDB.enableSkin = checked
			Engine:ReloadUI()
		end
	end)
	layout:Place(reskinLoot, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	CreateHeader(addonsPanel, layout, L["AddOns"])

	local styleTrinketMenu = CreateCheckbox(addonsPanel, "StyleTrinketMenu", L["Style TrinketMenu"], L["Shows TrinketMenu's trinket buttons like the action bars' buttons, without its backgrounds.|n|nRequires a UI reload to apply."], reloadOption(skinsDB, "styleTrinketMenu"))
	layout:Place(styleTrinketMenu, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	addonsPanel.okay = function() end
	addonsPanel.cancel = function()
		reskinLoot:SetChecked(lootDB.enableSkin)
		styleTrinketMenu:SetChecked(skinsDB.styleTrinketMenu)
	end
	addonsPanel.refresh = addonsPanel.cancel
	addonsPanel.cancel()

	InterfaceOptions_AddCategory(addonsPanel)

	self.OptionsPanel = panel

	self:GetHandler("ChatCommand"):Register("config", function()
		InterfaceOptionsFrame_OpenToCategory(panel)
		InterfaceOptionsFrame_OpenToCategory(panel) -- needs to be called twice to work around a blizzard bug
	end)
end

-- Unlock Frames: every frame that can be moved at once - the minimap
-- (modules/minimap, its edit mode), Blizzard's quest tracker
-- (modules/objectives/tracker.lua), Questie's tracker (its own lock), the
-- main chat window and the menu buttons with the gold and fps texts - with
-- one Lock Frames button to put them back. Not in combat: the minimap and
-- the menu buttons are secure, and entering combat locks them.
-------------------------------------------------------
local GetMinimap = function()
	local minimap = _G.DiabolicUIMinimapNS
	return minimap and minimap:GetModule("Minimap", true)
end

-- Questie's tracker, while it's in use: it moves once Questie's own
-- "trackerLocked" is off.
local GetQuestieTracker = function()
	local questie, loader = _G.Questie, _G.QuestieLoader
	if questie and questie.db and questie.db.profile and questie.db.profile.trackerEnabled and loader then
		return questie.db.profile, loader:ImportModule("TrackerBaseFrame")
	end
end

-- The box covers `target` and the `extra` frames attached to it (the
-- chat's buttons and edit box), or only those (the menu buttons and their
-- texts, inside a wider holder): their outer edges, measured each time
-- it's shown, kept as offsets from `target` so it follows the drag. An
-- extra given as { frame, "lr" } only counts for those edges (left, right,
-- top, bottom): the chat's button column reaches below its last button.
local FitMover = function(mover, target, extra, extraOnly, padding)
	local left, right, top, bottom = target:GetLeft(), target:GetRight(), target:GetTop(), target:GetBottom()
	mover:ClearAllPoints()
	if not (left and right and top and bottom) then
		mover:SetAllPoints(target)
		return
	end
	local l, r, t, b = left, right, top, bottom
	if extraOnly then
		l, r, t, b = math.huge, -math.huge, -math.huge, math.huge
	end
	for _, entry in ipairs(extra) do
		local frame, edges = entry, "lrtb"
		if (type(entry) == "table") and (not entry.GetLeft) then
			frame, edges = entry[1], entry[2]
		end
		local fl, fr, ft, fb = frame:GetLeft(), frame:GetRight(), frame:GetTop(), frame:GetBottom()
		if fl and fr and ft and fb then
			-- in the target's own scale
			local scale = frame:GetEffectiveScale() / target:GetEffectiveScale()
			fl, fr, ft, fb = fl * scale, fr * scale, ft * scale, fb * scale
			if edges:find("l") then l = math.min(l, fl) end
			if edges:find("r") then r = math.max(r, fr) end
			if edges:find("t") then t = math.max(t, ft) end
			if edges:find("b") then b = math.min(b, fb) end
		end
	end
	if (l > r) then -- none of them placed
		mover:SetAllPoints(target)
		return
	end
	padding = padding or 0
	l, r, t, b = l - padding, r + padding, t + padding, b - padding
	mover:SetPoint("TOPLEFT", target, "TOPLEFT", l - left, t - top)
	mover:SetPoint("BOTTOMRIGHT", target, "BOTTOMRIGHT", r - right, b - bottom)
end

-- A box over a frame that drags it: `onDragStart` and `onDragStop` run
-- around the move.
-- On top of what it covers, so its buttons can't be clicked meanwhile
-- (the menu buttons are DIALOG themselves). `padding` makes it that much
-- bigger than what it fits around.
local CreateMover = function(name, target, text, onDragStart, onDragStop, extra, extraOnly, padding)
	local mover = CreateFrame("Frame", name, UIParent)
	mover:SetFrameStrata("FULLSCREEN_DIALOG")
	mover:SetAllPoints(target)
	if extra then
		mover:SetScript("OnShow", function(self) FitMover(self, target, extra, extraOnly, padding) end)
	end
	mover:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	mover:SetBackdropColor(.6, .1, .1, .5)
	mover:SetBackdropBorderColor(1, .82, 0, 1)
	mover:EnableMouse(true)
	mover:RegisterForDrag("LeftButton")
	mover.Text = mover:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mover.Text:SetPoint("CENTER")
	mover.Text:SetText(text)
	mover:SetScript("OnDragStart", function()
		if onDragStart then
			onDragStart()
		end
		target:SetMovable(true)
		target:StartMoving()
	end)
	mover:SetScript("OnDragStop", function()
		target:StopMovingOrSizing()
		if onDragStop then
			onDragStop()
		end
	end)
	mover.target = target
	mover:Hide()
	return mover
end

Module.GetMovers = function(self)
	if self.Movers then
		return self.Movers
	end
	local chat = Engine:GetModule("ChatWindows")
	local menu = Engine:GetModule("ActionBars"):GetWidget("Controller: Menu")
	local menuButtons = Engine:GetModule("ActionBars"):GetWidget("Menu: Main")
	local master = menuButtons.MasterMenuButton
	self.Movers = {
		-- dropped by hand: no longer placed automatically, and kept there
		-- (modules/chat/windows.lua saves it)
		CreateMover("DiabolicUIChatMover", _G.ChatFrame1, L["Chat"], function()
			chat.db.autoposition = false
		end, function()
			chat:SaveChatFrameLayout()
		end, { { _G.ChatFrame1ButtonFrame, "lr" }, { _G.ChatFrameMenuButton, "lrt" }, _G.ChatFrame1EditBox }),
		CreateMover("DiabolicUIMenuMover", menu:GetFrame(), L["Menu"], nil, function()
			menu:SavePosition()
		end, { master, menuButtons.BagBarMenuButton, master.Gold, master.Performance }, true, 6)
	}
	-- TrinketMenu's worn trinkets, saved where TrinketMenu keeps them
	local trinkets = _G.TrinketMenu_MainFrame
	if trinkets and _G.TrinketMenuPerOptions then
		table.insert(self.Movers, CreateMover("DiabolicUITrinketMenuMover", trinkets, "TrinketMenu", nil, function()
			_G.TrinketMenuPerOptions.XPos = trinkets:GetLeft()
			_G.TrinketMenuPerOptions.YPos = trinkets:GetTop()
			self:PinTrinketMenu()
		end))
	end
	return self.Movers
end

Module.AreFramesUnlocked = function(self)
	return self.framesUnlocked and true or false
end

Module.GetLockButton = function(self)
	if self.LockButton then
		return self.LockButton
	end
	local button = CreateFrame("Button", "DiabolicUILockFramesButton", UIParent, "UIPanelButtonTemplate")
	button:SetFrameStrata("TOOLTIP") -- above the boxes
	button:SetSize(160, BUTTON_HEIGHT)
	button:SetPoint("TOP", UIParent, "TOP", 0, -120)
	button:SetText(L["Lock Frames"])
	button:SetScript("OnClick", function() self:SetFramesUnlocked(false) end)
	button.Hint = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	button.Hint:SetPoint("TOP", button, "BOTTOM", 0, -6)
	button.Hint:SetText(L["Drag the highlighted frames to move them. Right-drag the minimap to resize it."])
	button:Hide()
	self.LockButton = button
	return button
end

Module.SetFramesUnlocked = function(self, unlocked)
	if unlocked and InCombatLockdown() then
		print(L["You can't move frames in combat."])
		return
	end
	self.framesUnlocked = unlocked
	-- the quest tracker in use: Questie's when it's on, Blizzard's otherwise
	local questie, questieTracker = GetQuestieTracker()
	Engine:GetModule("ObjectiveTracker"):SetTrackerUnlocked(unlocked and not questie)
	for _, mover in ipairs(self:GetMovers()) do
		if unlocked and mover.target:IsShown() then
			mover:Show()
		else
			mover:Hide()
		end
	end
	-- Questie's tracker: unlocked, then back to the way it was. It drags
	-- and saves itself, so its box only shows it: clicks go through.
	if questie then
		if unlocked then
			self.questieWasLocked = questie.trackerLocked
			questie.trackerLocked = false
		elseif (self.questieWasLocked ~= nil) then
			questie.trackerLocked = self.questieWasLocked
			self.questieWasLocked = nil
		end
		questieTracker:Update()
	end
	local questieFrame = _G.Questie_BaseFrame
	if unlocked and questie and questieFrame then
		if (not self.QuestieBox) then
			self.QuestieBox = CreateMover("DiabolicUIQuestieMover", questieFrame, "Questie", nil, nil)
			self.QuestieBox:EnableMouse(false)
		end
		self.QuestieBox:Show()
	elseif self.QuestieBox then
		self.QuestieBox:Hide()
	end
	local minimap = GetMinimap()
	if minimap then
		if unlocked then
			minimap:EnterEditMode()
		else
			minimap:ExitEditMode()
		end
	end
	local lockButton = self:GetLockButton()
	if unlocked then
		lockButton:Show()
	else
		lockButton:Hide()
	end
	if self.UnlockFramesButton then
		self.UnlockFramesButton:SetText(unlocked and L["Lock Frames"] or L["Unlock Frames"])
	end
end

-- The UI Scale, beyond DiabolicUI's own frame: the minimap (its size
-- multiplies it, modules/minimap), Questie's tracker (Questie leaves its
-- scale alone) and TrinketMenu's windows (on top of TrinketMenu's own
-- scales, which it keeps setting and saving: its frames' SetScale and
-- GetScale go through these). Out of combat: they hold secure buttons.
-------------------------------------------------------
local GetUIScale = function()
	return Engine:GetConfig("ScreenScaling").scale or 1
end

local ScaleWithUI = function(frame)
	if frame.DiabolicOwnScale then
		return
	end
	local SetScale, GetScale = frame.SetScale, frame.GetScale
	frame.DiabolicOwnScale = GetScale(frame)
	frame.SetScale = function(self, scale)
		self.DiabolicOwnScale = scale
		SetScale(self, scale * GetUIScale())
	end
	frame.GetScale = function(self)
		return self.DiabolicOwnScale
	end
end

-- TrinketMenu places its window from its saved spot (TOPLEFT, in its own
-- scale), and the game's layout cache can add another anchor for it once
-- it's been dragged: with two, the window stretches between them. One
-- anchor only, the saved one, and no layout cache.
Module.PinTrinketMenu = function(self)
	local frame, saved = _G.TrinketMenu_MainFrame, _G.TrinketMenuPerOptions
	if not (frame and saved and saved.XPos and saved.YPos) or InCombatLockdown() then
		return
	end
	frame:SetUserPlaced(false)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", saved.XPos, saved.YPos)
end

Module.ApplyUIScale = function(self)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnScaleCombatEnded")
		return
	end
	local minimap = GetMinimap()
	if minimap then
		minimap:UpdateSize()
	end
	local questie = _G.Questie_BaseFrame
	if questie then
		questie:SetScale(GetUIScale())
	end
	for _, name in ipairs({ "TrinketMenu_MainFrame", "TrinketMenu_MenuFrame" }) do
		local frame = _G[name]
		if frame then
			ScaleWithUI(frame)
			frame:SetScale(frame.DiabolicOwnScale)
		end
	end
	self:PinTrinketMenu()
end

Module.OnScaleCombatEnded = function(self)
	self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnScaleCombatEnded")
	self:ApplyUIScale()
end

-- Questie builds its tracker some time after login: scaled once it's updated.
Module.OnEnteringWorld = function(self)
	local loader = _G.QuestieLoader
	if loader and (not self.questieHooked) then
		self.questieHooked = true
		hooksecurefunc(loader:ImportModule("TrackerBaseFrame"), "Update", function()
			local frame = _G.Questie_BaseFrame
			if frame and (frame:GetScale() ~= GetUIScale()) and not InCombatLockdown() then
				frame:SetScale(GetUIScale())
			end
		end)
	end
	self:ApplyUIScale()
end

-- combat starting while unlocked: everything goes back
Module.OnCombatStart = function(self)
	if self.framesUnlocked then
		self:SetFramesUnlocked(false)
	end
end

Module.OnEnable = function(self)
	self:CreateOptionsPanel()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStart")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEnteringWorld")
	self:GetHandler("ChatCommand"):Register("move", function()
		self:SetFramesUnlocked(not self:AreFramesUnlocked())
	end)
end
