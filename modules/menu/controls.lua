-- The options pages' controls (/dui config): a shared layout grid, so
-- columns line up on every page, and the checkboxes, buttons, sliders,
-- dropdowns and pickers they're made of.
local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Lua API
local ipairs = ipairs
local math_floor = math.floor
local setmetatable = setmetatable
local unpack = unpack

-- WoW API
local CreateFrame = CreateFrame
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local UIDropDownMenu_JustifyText = UIDropDownMenu_JustifyText
local UIDropDownMenu_SetText = UIDropDownMenu_SetText
local UIDropDownMenu_SetWidth = UIDropDownMenu_SetWidth

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


-- A page under the DiabolicUI one, with its title and crest; its layout
-- starts below them.
local NewPage = function(name, title)
	local page = CreateFrame("Frame", name, InterfaceOptionsFramePanelContainer)
	page.name = title
	page.parent = "DiabolicUI"
	page:Hide()
	local layout = NewLayout(page)
	CreateTitle(page, layout, title)
	CreateSubmenuLogo(page)
	return page, layout
end

-- for the pages (page-*.lua)
Module.Controls = {
	EDGE = EDGE,
	CHECK_X = CHECK_X,
	INDENT = INDENT,
	SLIDER_COLUMN = SLIDER_COLUMN,
	CHECK_COLUMN = CHECK_COLUMN,
	TITLE_HEIGHT = TITLE_HEIGHT,
	LABEL_HEIGHT = LABEL_HEIGHT,
	CHECK_HEIGHT = CHECK_HEIGHT,
	BUTTON_HEIGHT = BUTTON_HEIGHT,
	SLIDER_BLOCK_HEIGHT = SLIDER_BLOCK_HEIGHT,
	PICKER_HEIGHT = PICKER_HEIGHT,
	INTRO_WIDTH = INTRO_WIDTH,
	LOGO_HEIGHT = LOGO_HEIGHT,
	SPEC_COLUMN = SPEC_COLUMN,
	SPEC_ICON_SIZE = SPEC_ICON_SIZE,
	SPEC_LABEL_WIDTH = SPEC_LABEL_WIDTH,
	DROPDOWN_HEIGHT = DROPDOWN_HEIGHT,
	DROPDOWN_OVERHANG = DROPDOWN_OVERHANG,
	DROPDOWN_WIDTH = DROPDOWN_WIDTH,
	SMALL_DROPDOWN_WIDTH = SMALL_DROPDOWN_WIDTH,
	SECTION_GAP = SECTION_GAP,
	HEADER_GAP = HEADER_GAP,
	ROW_GAP = ROW_GAP,
	NewLayout = NewLayout,
	CreateTitle = CreateTitle,
	CreateHeader = CreateHeader,
	CreateFieldLabel = CreateFieldLabel,
	CreateCheckbox = CreateCheckbox,
	CreateButton = CreateButton,
	CreateValueSlider = CreateValueSlider,
	CreateOffsetSlider = CreateOffsetSlider,
	CreateAnchorPointPicker = CreateAnchorPointPicker,
	CreateDropDown = CreateDropDown,
	NewPage = NewPage,
}
