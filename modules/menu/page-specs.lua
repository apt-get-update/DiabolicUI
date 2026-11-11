-- The Specializations page of /dui config: what each talent specialization
-- sets up once you switch to it (modules/actionbars/elements/specswitch.lua).
-- A card per specialization side by side, the active one lit, its settings
-- one under the other (the same ones level across the two), and only a hint
-- before Dual Talent Specialization.
local ADDON, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local EDGE, LABEL_HEIGHT, HEADER_GAP = C.EDGE, C.LABEL_HEIGHT, C.HEADER_GAP
local DROPDOWN_HEIGHT, DROPDOWN_OVERHANG, CHOICE_HEIGHT = C.DROPDOWN_HEIGHT, C.DROPDOWN_OVERHANG, C.CHOICE_HEIGHT
local BUTTON_HEIGHT = C.BUTTON_HEIGHT
local CARD_PAD, CARD_WIDTH = C.CARD_PAD, C.CARD_WIDTH
local CreateDropDown, CreateCard = C.CreateDropDown, C.CreateCard
local CreateButton = C.CreateButton

local ICON_SIZE = 24 -- the specialization's icon, by its name
local CARD_GAP = 8 -- between the two cards
local INTRO_HEIGHT = 24 -- the line over the cards, and its gap to them
local ROW_GAP = 8 -- above each label
local LABEL_GAP = 4 -- between a label and its control
local ROW_HEIGHT = ROW_GAP + LABEL_HEIGHT + LABEL_GAP + CHOICE_HEIGHT
local SPEC_CARD_WIDTH = math.floor((CARD_WIDTH - CARD_GAP) / 2) -- the two as wide as one across the page
-- a dropdown's box: the frame's art (or the Diablo III plate) is 18 wider
-- than its set width, and as high as a choice, centered in its frame
local DROPDOWN_WIDTH = SPEC_CARD_WIDTH - CARD_PAD * 2 - 18
local DROPDOWN_INSET = (DROPDOWN_HEIGHT - CHOICE_HEIGHT) / 2
local BARS_BUTTON_GAP = 6 -- between Save and Restore, squares BUTTON_HEIGHT wide
local CARD_HEIGHT = CARD_PAD + ICON_SIZE + ROW_HEIGHT * 4 + CARD_PAD
local LABEL_ICON = 16 -- the menu's icon by each label
-- the menu's icons (DiabolicUI_40x40_MenuIconGrid, 40 apart): shield, bars, cog
local ICONS = [[Interface\AddOns\]] .. ADDON .. [[\media\textures\DiabolicUI_40x40_MenuIconGrid.tga]]
local ICON_COORDS = {
	equipSet = { 120 / 256, 159 / 256, 0, 39 / 256 },
	actions = { 0, 39 / 256, 160 / 256, 199 / 256 },
	macro = { 160 / 256, 199 / 256, 120 / 256, 159 / 256 },
}
-- Save and Restore as the equipment sets' icons (the window icons' sheet, 8 of 32)
local SET_ICONS = [[Interface\AddOns\]] .. ADDON .. [[\media\textures\DiabolicUI_Window_Icons.tga]]
local SAVE_ICON, RESTORE_ICON = 3, 4
local BARS_BUTTON_ICON = 16
local ACTIVE_COLOR = { 1, 0.82, 0 }
local IDLE_COLOR = { 0.5, 0.5, 0.5 }

-- 3.3.5 has no SetShown
local ShowIf = function(region, shown)
	if shown then
		region:Show()
	else
		region:Hide()
	end
end

-- The Specializations page
Module.CreateSpecsPage = function(self)
	local actionbarsDB = Engine:GetConfig("ActionBars", "character")
	local specSwitch = Engine:GetModule("ActionBars"):GetWidget("Button: Spec Switch")

	local specsPanel, layout = NewPage("DiabolicUIOptionsPanelSpecs", L["Specializations"])
	local top = layout:Row(0, HEADER_GAP)

	-- before Dual Talent Specialization: only this
	local hint = specsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	hint:SetJustifyH("LEFT")
	hint:SetWidth(CARD_WIDTH - CARD_PAD * 2)
	hint:SetText(L["Learn Dual Talent Specialization to set this up."])
	layout:Place(hint, EDGE, top)

	-- with it: what the cards are for, over them
	local intro = specsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	intro:SetJustifyH("LEFT")
	intro:SetWidth(CARD_WIDTH - CARD_PAD * 2)
	intro:SetText(L["Switching spec puts on its gear, action bars and macros."])
	layout:Place(intro, EDGE, top)

	-- a label over its control, after its icon, with a description on hover
	local specLabel = function(card, text, tooltipText, icon)
		local label = card:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		label:SetJustifyH("LEFT")
		label:SetText(text)
		label.icon = card:CreateTexture(nil, "ARTWORK")
		label.icon:SetTexture(ICONS)
		label.icon:SetTexCoord(unpack(ICON_COORDS[icon]))
		label.icon:SetSize(LABEL_ICON, LABEL_ICON)
		label.icon:SetPoint("RIGHT", label, "LEFT", -3, 0)
		if tooltipText then
			local hitbox = CreateFrame("Frame", nil, card)
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

	-- `button` as a square with the sheet's icon `index` only (its text in
	-- its tooltip), the icon faded while it's disabled
	local iconOnly = function(button, index)
		button:SetText("")
		button:SetSize(BUTTON_HEIGHT, BUTTON_HEIGHT)
		local icon = button:CreateTexture(nil, "OVERLAY")
		icon:SetTexture(SET_ICONS)
		icon:SetTexCoord(index / 8, (index + 1) / 8, 0, 1)
		icon:SetSize(BARS_BUTTON_ICON, BARS_BUTTON_ICON)
		icon:SetPoint("CENTER")
		local update = function()
			icon:SetDesaturated(button:IsEnabled() == 0)
			icon:SetAlpha((button:IsEnabled() == 0) and 0.4 or 1)
		end
		hooksecurefunc(button, "Enable", update)
		hooksecurefunc(button, "Disable", update)
		update()
	end

	-- a saved choice, false when it's left as it is
	local specSetting = function(key)
		return function()
			return actionbarsDB[key] or false
		end, function(value)
			actionbarsDB[key] = value
		end
	end

	-- "None", then the list
	local withNone = function(list)
		local items = { { text = L["None"], value = false } }
		for _, item in ipairs(list) do
			items[#items + 1] = item
		end
		return items
	end

	local specCards = {}
	for group = 1, 2 do
		local card = CreateCard(specsPanel, nil, SPEC_CARD_WIDTH)
		card:SetHeight(CARD_HEIGHT)
		layout:Place(card, EDGE - CARD_PAD + (group - 1) * (SPEC_CARD_WIDTH + CARD_GAP), top - INTRO_HEIGHT)

		card.icon = card:CreateTexture(nil, "ARTWORK")
		card.icon:SetSize(ICON_SIZE, ICON_SIZE)
		card.icon:SetPoint("TOPLEFT", CARD_PAD, -CARD_PAD)

		card.name = card:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		card.name:SetJustifyH("LEFT")
		card.name:SetPoint("LEFT", card.icon, "RIGHT", 8, 0)

		card.active = card:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		card.active:SetPoint("TOPRIGHT", -CARD_PAD, -CARD_PAD)
		card.active:SetText(L["Active"])

		-- its settings, a label over a control, on `row`
		card.rows = {}
		local place = function(key, row, label, control, isDropDown)
			local x = CARD_PAD
			local y = -CARD_PAD - ICON_SIZE - (row - 1) * ROW_HEIGHT - ROW_GAP
			label:SetPoint("TOPLEFT", x + LABEL_ICON + 3, y)
			y = y - LABEL_HEIGHT - LABEL_GAP
			if isDropDown then
				control:SetPoint("TOPLEFT", x - DROPDOWN_OVERHANG, y + DROPDOWN_INSET)
			else
				control:SetPoint("TOPLEFT", x, y)
			end
			card.rows[#card.rows + 1] = { key = key, label = label, control = control }
		end

		local getSet, setSet = specSetting("specEquipSet" .. group)
		place(
			"equipSet",
			1,
			specLabel(card, L["Equipment Set"], L["The equipment set to put on."], "equipSet"),
			CreateDropDown(card, "Spec" .. group .. "EquipSet", DROPDOWN_WIDTH, function()
				return withNone(specSwitch:GetEquipmentSets())
			end, getSet, setSet),
			true
		)

		-- its action bars: saved here, put back once switched to it
		local profiles = Engine:GetModule("ActionBars: Profiles")
		local actions = CreateFrame("Frame", nil, card)
		actions:SetSize(DROPDOWN_WIDTH, CHOICE_HEIGHT)
		local save = CreateButton(
			card,
			"Spec" .. group .. "SaveBars",
			L["Save"],
			L["Your action bars as they are now become this specialization's."],
			function()
				profiles:Save(group)
				actions:Refresh()
			end
		)
		local restore = CreateButton(
			card,
			"Spec" .. group .. "RestoreBars",
			L["Restore"],
			L["Puts this specialization's saved action bars back now."],
			function()
				profiles:Restore(group)
			end
		)
		iconOnly(save, SAVE_ICON)
		iconOnly(restore, RESTORE_ICON)
		save:SetParent(actions)
		save:SetPoint("LEFT")
		restore:SetParent(actions)
		restore:SetPoint("LEFT", save, "RIGHT", BARS_BUTTON_GAP, 0)
		-- only on the active one's card: the bars on screen are its own
		actions.Refresh = function()
			local active = group == GetActiveTalentGroup()
			if active then
				save:Enable()
			else
				save:Disable()
			end
			if active and profiles:HasSaved(group) then
				restore:Enable()
			else
				restore:Disable()
			end
		end
		place(
			"actions",
			2,
			specLabel(card, L["Action Bars"], L["Saved with Save, put back once you switch to it."], "actions"),
			actions
		)

		-- macros, run by clicks on the skull's button
		local macroChoices = function()
			return withNone(specSwitch:GetMacros())
		end
		local getBefore, setBefore = specSetting("specMacroBefore" .. group)
		place(
			"macroBefore",
			3,
			specLabel(
				card,
				L["Macro Before"],
				L["A macro to run just before switching to this specialization."],
				"macro"
			),
			CreateDropDown(card, "Spec" .. group .. "MacroBefore", DROPDOWN_WIDTH, macroChoices, getBefore, setBefore),
			true
		)
		local getMacro, setMacro = specSetting("specMacroName" .. group)
		place(
			"macro",
			4,
			specLabel(
				card,
				L["Macro After"],
				L["A macro to run after switching: the skull's button glows, click it again to run it."],
				"macro"
			),
			CreateDropDown(card, "Spec" .. group .. "Macro", DROPDOWN_WIDTH, macroChoices, getMacro, setMacro),
			true
		)

		specCards[group] = card
	end

	specsPanel.okay = function() end
	specsPanel.cancel = function()
		local dual = GetNumTalentGroups() > 1
		local active = GetActiveTalentGroup()
		ShowIf(hint, not dual)
		ShowIf(intro, dual)
		for group, card in ipairs(specCards) do
			ShowIf(card, dual)
			local name, _, icon = specSwitch:GetSpec(group)
			card.icon:SetTexture(icon or [[Interface\Icons\INV_Misc_QuestionMark]])
			card.name:SetText(name or (group == 1 and _G.PRIMARY or _G.SECONDARY))
			ShowIf(card.active, group == active)
			local color = (group == active) and ACTIVE_COLOR or IDLE_COLOR
			card:SetBackdropBorderColor(color[1], color[2], color[3], 1)
			for _, row in ipairs(card.rows) do
				row.control:Refresh()
			end
		end
	end
	specsPanel.refresh = specsPanel.cancel
	specsPanel.cancel()
	return specsPanel
end
