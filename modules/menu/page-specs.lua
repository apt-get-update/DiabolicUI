-- The Specializations page of /dui config: what each talent specialization
-- sets up once you switch to it (modules/actionbars/elements/specswitch.lua).
-- A card across the page per specialization, the active one lit, its
-- settings two to a row, and only a hint before Dual Talent Specialization.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local EDGE, LABEL_HEIGHT, SLIDER_COLUMN, HEADER_GAP = C.EDGE, C.LABEL_HEIGHT, C.SLIDER_COLUMN, C.HEADER_GAP
local DROPDOWN_HEIGHT, DROPDOWN_OVERHANG, CHOICE_HEIGHT = C.DROPDOWN_HEIGHT, C.DROPDOWN_OVERHANG, C.CHOICE_HEIGHT
local CARD_PAD, CARD_WIDTH = C.CARD_PAD, C.CARD_WIDTH
local CreateDropDown, CreateChoiceButtons, CreateCard = C.CreateDropDown, C.CreateChoiceButtons, C.CreateCard

local ICON_SIZE = 24 -- the specialization's icon, by its name
local CARD_GAP = 8 -- between the two cards
local KEEP_WIDTH = 44 -- the "Keep" and "None" choices, wider than "1"
local ROW_GAP = 8 -- above each label
local LABEL_GAP = 4 -- between a label and its control
local ROW_HEIGHT = ROW_GAP + LABEL_HEIGHT + LABEL_GAP + CHOICE_HEIGHT
local COLUMN = SLIDER_COLUMN -- the second column, as on the Positions page
-- a dropdown's box: the frame's art (or the Diablo III plate) is 18 wider
-- than its set width, and as high as a choice, centered in its frame
local DROPDOWN_WIDTH = CARD_WIDTH - CARD_PAD * 2 - COLUMN - 18
local DROPDOWN_INSET = (DROPDOWN_HEIGHT - CHOICE_HEIGHT) / 2
local CARD_HEIGHT = CARD_PAD + ICON_SIZE + ROW_HEIGHT * 3 + CARD_PAD
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

	-- a label over its control, with a description on hover
	local specLabel = function(card, text, tooltipText)
		local label = card:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		label:SetJustifyH("LEFT")
		label:SetText(text)
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

	-- a saved choice, false when it's left as it is
	local specSetting = function(key)
		return function()
			return actionbarsDB[key] or false
		end, function(value)
			actionbarsDB[key] = value
		end
	end

	-- "Keep", then the counts, 0 as "None" (the buttons' font crosses its 0)
	local barChoices = function(counts)
		local choices = { { text = L["Keep"], value = false, width = KEEP_WIDTH } }
		for _, count in ipairs(counts) do
			choices[#choices + 1] = count == 0 and { text = L["None"], value = 0, width = KEEP_WIDTH }
				or { text = tostring(count), value = count }
		end
		return choices
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
		local card = CreateCard(specsPanel, nil, CARD_WIDTH)
		card:SetHeight(CARD_HEIGHT)
		layout:Place(card, EDGE - CARD_PAD, top - (group - 1) * (CARD_HEIGHT + CARD_GAP))

		card.icon = card:CreateTexture(nil, "ARTWORK")
		card.icon:SetSize(ICON_SIZE, ICON_SIZE)
		card.icon:SetPoint("TOPLEFT", CARD_PAD, -CARD_PAD)

		card.name = card:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		card.name:SetJustifyH("LEFT")
		card.name:SetPoint("LEFT", card.icon, "RIGHT", 8, 0)

		card.active = card:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		card.active:SetPoint("TOPRIGHT", -CARD_PAD, -CARD_PAD)
		card.active:SetText(L["Active"])

		-- its settings, a label over a control, in `column` (0 or 1) of `row`
		card.rows = {}
		local place = function(key, row, column, label, control, isDropDown)
			local x = CARD_PAD + column * COLUMN
			local y = -CARD_PAD - ICON_SIZE - (row - 1) * ROW_HEIGHT - ROW_GAP
			label:SetPoint("TOPLEFT", x, y)
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
			0,
			specLabel(card, L["Equipment Set"], L["The equipment set to put on."]),
			CreateDropDown(card, "Spec" .. group .. "EquipSet", DROPDOWN_WIDTH, function()
				return withNone(specSwitch:GetEquipmentSets())
			end, getSet, setSet),
			true
		)

		local getProfile, setProfile = specSetting("specProfile" .. group)
		place(
			"profile",
			1,
			1,
			specLabel(
				card,
				L["Action Bar Profile"],
				L["The action bars to put back. Save them with '/dui bars save <name>'."]
			),
			CreateDropDown(card, "Spec" .. group .. "Profile", DROPDOWN_WIDTH, function()
				return withNone(specSwitch:GetActionBarProfiles())
			end, getProfile, setProfile),
			true
		)

		local getBars, setBars = specSetting("specBars" .. group)
		place(
			"bars",
			2,
			0,
			specLabel(card, L["Action Bar Count"], L["Keep: the bars stay as they are."]),
			CreateChoiceButtons(card, "Spec" .. group .. "Bars", barChoices({ 1, 2, 3 }), getBars, setBars)
		)

		local getSideBars, setSideBars = specSetting("specSideBars" .. group)
		place(
			"sideBars",
			2,
			1,
			specLabel(card, L["Side Bar Count"], L["Keep: the bars stay as they are."]),
			CreateChoiceButtons(card, "Spec" .. group .. "SideBars", barChoices({ 0, 1, 2 }), getSideBars, setSideBars)
		)

		-- macros, run by clicks on the skull's button
		local macroChoices = function()
			return withNone(specSwitch:GetMacros())
		end
		local getBefore, setBefore = specSetting("specMacroBefore" .. group)
		place(
			"macroBefore",
			3,
			0,
			specLabel(card, L["Macro Before"], L["A macro to run just before switching to this specialization."]),
			CreateDropDown(card, "Spec" .. group .. "MacroBefore", DROPDOWN_WIDTH, macroChoices, getBefore, setBefore),
			true
		)
		local getMacro, setMacro = specSetting("specMacroName" .. group)
		place(
			"macro",
			3,
			1,
			specLabel(
				card,
				L["Macro After"],
				L["A macro to run after switching: the skull's button glows, click it again to run it."]
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
