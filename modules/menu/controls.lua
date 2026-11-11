-- The options pages' controls (/dui config): a shared layout grid, so
-- columns line up on every page, and the checkboxes, buttons, sliders,
-- dropdowns and pickers they're made of.
local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Layout grid
-------------------------------------------------------
-- Every control is positioned from its page's top left corner on a shared
-- grid, never relative to its neighbour, so columns line up across all the
-- pages no matter how wide a (localized) label is.
local EDGE = 16 -- page padding, and the left column
local CHECK_X = EDGE - 2 -- checkbox art has a 2px transparent margin
local SLIDER_WIDTH = 160
local SLIDER_COLUMN = 200 -- distance between two sliders on one row
local RADIO_OVERHANG = 8 -- picker radios stick out past the box

local TITLE_HEIGHT = 16
local HEADER_HEIGHT = 16
local LABEL_HEIGHT = 14
local CHECK_HEIGHT = 26
local BUTTON_HEIGHT = 24
local SLIDER_LABEL_HEIGHT = 16 -- the template's label sits above the bar
local SLIDER_INPUT_GAP = 4 -- between the bar and its entry box
local SLIDER_BLOCK_HEIGHT = SLIDER_LABEL_HEIGHT + 15 + SLIDER_INPUT_GAP + 14 -- label, bar, entry box
local PICKER_WIDTH, PICKER_HEIGHT = 120, 80 -- the box, its radios hanging RADIO_OVERHANG past it
local INTRO_WIDTH = 380 -- the main page's texts
local LOGO_HEIGHT = 80 -- the main page's logo, top right
local SPEC_COLUMN = 199 -- distance between the two specialization columns
local CARD_PAD = 8 -- inside a card, around what it holds; its border this far outside the column
local CARD_WIDTH = SPEC_COLUMN * 2 - 5 -- a card across the page
local CARD_TITLE_GAP = 6 -- between a card's title and what it holds
local DROPDOWN_HEIGHT = 32
local CHOICE_HEIGHT = 22
local DROPDOWN_OVERHANG = 16 -- the template's art starts this far right of its frame

local SECTION_GAP = 24 -- above a section header
local HEADER_GAP = 8 -- between a header and its first row
local ROW_GAP = 4 -- between rows of the same section

local GROUP_BACKDROP = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 12,
	insets = { left = 3, right = 3, top = 3, bottom = 3 },
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

-- Widgets
-------------------------------------------------------
local CreateTitle = function(page, layout, text)
	local title = page:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetText(text)
	layout:Place(title, EDGE, layout:Row(TITLE_HEIGHT))
	return title
end

-- The small lettermark crest on the submenu pages, in line with the title,
-- its right edge on the cards' (not in the window's corner).
local CREST_SIZE = 24
local CREST_RIGHT = EDGE + CARD_PAD / 2
local CreateSubmenuLogo = function(page)
	local logo = page:CreateTexture(nil, "ARTWORK")
	logo:SetSize(CREST_SIZE, CREST_SIZE)
	logo:SetPoint("RIGHT", page, "TOPRIGHT", -CREST_RIGHT, -EDGE - TITLE_HEIGHT / 2)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\diabolic-lettermark.tga]]):format(Addon))
	logo:SetTexCoord(90 / 512, 422 / 512, 90 / 512, 422 / 512)
	return logo
end

local CreateHeader = function(page, layout, text)
	local header = page:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	header:SetText(text)
	layout:Place(header, EDGE, layout:Row(HEADER_HEIGHT, SECTION_GAP))
	return header
end

-- A card: a bordered box `width` wide (its height set by the caller), its
-- gold `title` at the top left showing `tooltipText` on hover. Named
-- DiabolicUIOptionsPanel<name>Card; placed by the caller.
local CreateCard = function(parent, name, width, title, tooltipText)
	local card = CreateFrame("Frame", name and ("DiabolicUIOptionsPanel" .. name .. "Card"), parent)
	card:SetBackdrop(GROUP_BACKDROP)
	card:SetBackdropColor(0, 0, 0, 0.35)
	card:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	card:SetWidth(width)
	if title then
		card.title = card:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		card.title:SetPoint("TOPLEFT", CARD_PAD, -CARD_PAD)
		card.title:SetText(title)
	end
	if tooltipText then
		-- (a FontString takes no mouse: a frame over it shows the text)
		card.hitbox = CreateFrame("Frame", nil, card)
		card.hitbox:SetAllPoints(card.title)
		card.hitbox:EnableMouse(true)
		card.hitbox:SetScript("OnEnter", function(self)
			GameTooltip_SetDefaultAnchor(GameTooltip, self)
			GameTooltip:AddLine(title)
			GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
			GameTooltip:Show()
		end)
		card.hitbox:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	end
	return card
end

-- Placed by the caller; checkboxes on a row of their own use CHECK_X.
local CreateCheckbox = function(parent, name, label, tooltipText, onClick)
	local checkbox =
		CreateFrame("CheckButton", "DiabolicUIOptionsPanel" .. name, parent, "InterfaceOptionsCheckButtonTemplate")
	_G[checkbox:GetName() .. "Text"]:SetText(label)
	-- the windows' checkbox, not Blizzard's yellow tick
	Engine:GetModule("Blizzard: Windows"):SkinCheckBox(checkbox, Engine:GetDB("Blizzard").window.check_box.size)
	checkbox.tooltipText = label
	checkbox.tooltipRequirement = tooltipText
	checkbox:SetScript("OnClick", onClick)
	return checkbox
end

local CreateButton = function(parent, name, label, tooltipText, onClick)
	local button = CreateFrame("Button", "DiabolicUIOptionsPanel" .. name, parent, "UIPanelButtonTemplate")
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
	tile = true,
	tileSize = 8,
	edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 },
}
local SLIDER_THUMB_TEXTURE = [[Interface\Buttons\UI-SliderBar-Button-Horizontal]]

local INPUT_BACKDROP = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
	tile = true,
	tileSize = 5,
	edgeSize = 1,
}
local INPUT_BORDER_COLOR = { 0.3, 0.3, 0.3, 0.8 }
local INPUT_BORDER_COLOR_HOVER = { 0.5, 0.5, 0.5, 1 }
local LABEL_COLOR = { 1, 0.82, 0 }

-- A slider plus a manual numeric entry box centered below it, kept in sync
-- both ways. Placed by the caller by the top of its label. snapRange, if
-- given, makes values dragged near 0 snap to it.
local CreateValueSlider = function(parent, name, label, tooltipText, minValue, maxValue, getValue, setValue, snapRange)
	local slider = CreateFrame("Slider", "DiabolicUIOptionsPanel" .. name, parent, "OptionsSliderTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetWidth(SLIDER_WIDTH)
	slider:SetHeight(15)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetMinMaxValues(minValue, maxValue)
	slider:SetValueStep(1)
	slider:SetBackdrop(SLIDER_BACKDROP)
	slider:SetThumbTexture(SLIDER_THUMB_TEXTURE)

	local lowText, highText, labelText =
		_G[slider:GetName() .. "Low"], _G[slider:GetName() .. "High"], _G[slider:GetName() .. "Text"]
	-- (no low and high under the ends: the entry box says the value)
	lowText:Hide()
	highText:Hide()
	labelText:SetText(label)
	labelText:SetTextColor(unpack(LABEL_COLOR))

	slider.tooltipText = label
	slider.tooltipRequirement = tooltipText

	-- manual numeric entry, for typing an exact value directly instead of
	-- having to land on it with the slider
	local input = CreateFrame("EditBox", "DiabolicUIOptionsPanel" .. name .. "Input", parent)
	input:SetSize(70, 14)
	input:SetPoint("TOP", slider, "BOTTOM", 0, -SLIDER_INPUT_GAP)
	input:SetAutoFocus(false)
	input:SetJustifyH("CENTER")
	input:SetFontObject(GameFontHighlightSmall)
	input:SetBackdrop(INPUT_BACKDROP)
	input:SetBackdropColor(0, 0, 0, 0.5)
	input:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR))
	input:SetScript("OnEnter", function(self)
		self:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR_HOVER))
	end)
	input:SetScript("OnLeave", function(self)
		self:SetBackdropBorderColor(unpack(INPUT_BORDER_COLOR))
	end)
	input:SetMaxLetters(5) -- "-200" / "120"

	local silent = false -- true while we're driving the slider/input from code, not the user

	-- updates both widgets to match, without re-triggering the slider's
	-- own OnValueChanged (which would otherwise snap it again and re-save)
	local setSilently = function(value)
		value = math.floor(value + 0.5)
		silent = true
		slider:SetValue(value)
		silent = false
		input:SetText(tostring(value))
	end

	local commitValue = function(value)
		if value < minValue then
			value = minValue
		elseif value > maxValue then
			value = maxValue
		end
		setSilently(value)
		setValue(value)
	end

	slider:SetScript("OnValueChanged", function(button, value)
		if silent then
			return
		end
		value = math.floor(value + 0.5)
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
			self:SetText(tostring(math.floor(slider:GetValue() + 0.5)))
		end
		self:ClearFocus()
	end)

	input:SetScript("OnEscapePressed", function(self)
		self:SetText(tostring(math.floor(slider:GetValue() + 0.5)))
		self:ClearFocus()
	end)

	-- leaving the box keeps a new number typed in it
	input:SetScript("OnEditFocusLost", function(self)
		local value = tonumber(self:GetText())
		if value and (value ~= math.floor(slider:GetValue() + 0.5)) then
			commitValue(value)
		else
			self:SetText(tostring(math.floor(slider:GetValue() + 0.5)))
		end
	end)

	setSilently(getValue())

	-- exposed so the panel's cancel/refresh can reset the display without
	-- re-triggering a snap or a write-back
	slider.SetValueSilently = function(self, value)
		setSilently(value)
	end
	slider.Input = input

	return slider
end

local CreateOffsetSlider = function(parent, name, label, tooltipText, getValue, setValue)
	return CreateValueSlider(
		parent,
		name,
		label,
		tooltipText,
		SLIDER_MIN,
		SLIDER_MAX,
		getValue,
		setValue,
		SLIDER_SNAP_RANGE
	)
end

-- Order they're visited in when building/refreshing the anchor point picker.
-- The names match both a WoW anchor point and a key in Tooltips.anchorPoint.
local ANCHOR_POINT_ORDER =
	{ "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }

local ANCHOR_POINT_LABELS = {
	TOPLEFT = L["Top Left"],
	TOP = L["Top"],
	TOPRIGHT = L["Top Right"],
	LEFT = L["Left"],
	CENTER = L["Center"],
	RIGHT = L["Right"],
	BOTTOMLEFT = L["Bottom Left"],
	BOTTOM = L["Bottom"],
	BOTTOMRIGHT = L["Bottom Right"],
}

-- A box with a radio button on each of `points` (corners, edges' middles,
-- its center) to pick one; `getValue()` and `setValue(point)` read and save
-- it. Its radios are DiabolicUIOptionsPanel<name><point>, and hang
-- RADIO_OVERHANG past it. Placed by the caller; box:Refresh() checks the
-- saved one and calls box:OnRefresh(point) when set (to draw a preview).
local CreateAnchorPointPicker = function(parent, name, points, getValue, setValue)
	local box = CreateFrame("Frame", nil, parent)
	box:SetSize(PICKER_WIDTH, PICKER_HEIGHT)
	box:SetBackdrop(GROUP_BACKDROP)
	box:SetBackdropColor(0, 0, 0, 0.75)
	box:SetBackdropBorderColor(1, 1, 1, 1)
	box.radios = {}

	box.Refresh = function(self)
		local value = getValue()
		for point, radio in pairs(self.radios) do
			radio:SetChecked(point == value)
		end
		if self.OnRefresh then
			self:OnRefresh(value)
		end
	end

	for _, point in ipairs(points) do
		local radio =
			CreateFrame("CheckButton", "DiabolicUIOptionsPanel" .. name .. point, box, "UIRadioButtonTemplate")
		radio:SetPoint("CENTER", box, point, 0, 0)
		radio:SetFrameLevel(box:GetFrameLevel() + 2) -- (over a preview)
		radio.tooltipText = ANCHOR_POINT_LABELS[point]
		radio:SetScript("OnClick", function()
			setValue(point)
			box:Refresh()
		end)
		box.radios[point] = radio
	end
	return box
end

-- A Blizzard dropdown. `getItems()` lists the choices, each { text, value,
-- icon }, fresh every time it opens; `getValue()` and `setValue(value)` read
-- and save the chosen one. Placed by the caller, its art DROPDOWN_OVERHANG
-- to the right of where it's anchored.
local CreateDropDown = function(parent, name, width, getItems, getValue, setValue)
	local dropDown = CreateFrame("Frame", "DiabolicUIOptionsPanel" .. name, parent, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(dropDown, width)
	UIDropDownMenu_JustifyText(dropDown, "LEFT")

	local label = function(item)
		return item.icon and ("|T" .. item.icon .. ":16:16:0:0|t " .. item.text) or item.text
	end

	-- the closed dropdown shows the saved choice, or the saved name greyed
	-- out when it's gone (a deleted equipment set). Its icon loaded first
	-- and its text set anew: an inline icon not loaded yet draws blank, and
	-- the same text set again doesn't redraw it.
	local preload = dropDown:CreateTexture(nil, "BACKGROUND")
	preload:Hide()
	dropDown.Refresh = function(self)
		local current = getValue()
		for _, item in ipairs(getItems()) do
			if item.value == current then
				if item.icon then
					preload:SetTexture(item.icon)
				end
				UIDropDownMenu_SetText(self, "")
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
	SLIDER_COLUMN = SLIDER_COLUMN,
	TITLE_HEIGHT = TITLE_HEIGHT,
	CREST_RIGHT = CREST_RIGHT,
	LABEL_HEIGHT = LABEL_HEIGHT,
	CHECK_HEIGHT = CHECK_HEIGHT,
	BUTTON_HEIGHT = BUTTON_HEIGHT,
	SLIDER_BLOCK_HEIGHT = SLIDER_BLOCK_HEIGHT,
	SLIDER_LABEL_HEIGHT = SLIDER_LABEL_HEIGHT,
	PICKER_WIDTH = PICKER_WIDTH,
	PICKER_HEIGHT = PICKER_HEIGHT,
	RADIO_OVERHANG = RADIO_OVERHANG,
	CARD_PAD = CARD_PAD,
	CARD_WIDTH = CARD_WIDTH,
	CARD_TITLE_GAP = CARD_TITLE_GAP,
	INTRO_WIDTH = INTRO_WIDTH,
	LOGO_HEIGHT = LOGO_HEIGHT,
	SPEC_COLUMN = SPEC_COLUMN,
	DROPDOWN_HEIGHT = DROPDOWN_HEIGHT,
	CHOICE_HEIGHT = CHOICE_HEIGHT,
	GROUP_BACKDROP = GROUP_BACKDROP,
	DROPDOWN_OVERHANG = DROPDOWN_OVERHANG,
	SECTION_GAP = SECTION_GAP,
	HEADER_GAP = HEADER_GAP,
	ROW_GAP = ROW_GAP,
	NewLayout = NewLayout,
	CreateTitle = CreateTitle,
	CreateHeader = CreateHeader,
	CreateCard = CreateCard,
	CreateCheckbox = CreateCheckbox,
	CreateButton = CreateButton,
	CreateValueSlider = CreateValueSlider,
	CreateOffsetSlider = CreateOffsetSlider,
	CreateAnchorPointPicker = CreateAnchorPointPicker,
	ANCHOR_POINTS = ANCHOR_POINT_ORDER,
	CreateDropDown = CreateDropDown,
	NewPage = NewPage,
}
