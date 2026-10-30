-- The Specializations page of /dui config: what each talent specialization
-- sets up once you switch to it (modules/actionbars/elements/specswitch.lua).
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Lua API
local ipairs = ipairs

-- WoW API
local CreateFrame = CreateFrame
local UIDropDownMenu_DisableDropDown = UIDropDownMenu_DisableDropDown
local UIDropDownMenu_EnableDropDown = UIDropDownMenu_EnableDropDown
local UIDropDownMenu_SetText = UIDropDownMenu_SetText

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local EDGE, LABEL_HEIGHT, SPEC_COLUMN, SPEC_ICON_SIZE = C.EDGE, C.LABEL_HEIGHT, C.SPEC_COLUMN, C.SPEC_ICON_SIZE
local SPEC_LABEL_WIDTH, DROPDOWN_HEIGHT, DROPDOWN_OVERHANG, DROPDOWN_WIDTH = C.SPEC_LABEL_WIDTH, C.DROPDOWN_HEIGHT, C.DROPDOWN_OVERHANG, C.DROPDOWN_WIDTH
local SMALL_DROPDOWN_WIDTH, HEADER_GAP, CreateDropDown = C.SMALL_DROPDOWN_WIDTH, C.HEADER_GAP, C.CreateDropDown

-- The Specializations page
Module.CreateSpecsPage = function(self)
	local actionbarsDB = Engine:GetConfig("ActionBars", "character")
	local specSwitch = Engine:GetModule("ActionBars"):GetWidget("Button: Spec Switch")

	local specsPanel, layout = NewPage("DiabolicUIOptionsPanelSpecs", L["Specializations"])

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
			column.macroBefore:Refresh()
			column.macro:Refresh()
		end
	end
	specsPanel.refresh = specsPanel.cancel
	specsPanel.cancel()
	return specsPanel
end
