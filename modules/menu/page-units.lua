-- The Units page of /dui config: class colors, portraits, the low health
-- warning, and the fake party, raid and loot roll to preview them.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local EDGE, CHECK_X, SLIDER_COLUMN, CHECK_HEIGHT = C.EDGE, C.CHECK_X, C.SLIDER_COLUMN, C.CHECK_HEIGHT
local BUTTON_HEIGHT, HEADER_GAP, ROW_GAP, CreateHeader = C.BUTTON_HEIGHT, C.HEADER_GAP, C.ROW_GAP, C.CreateHeader
local CreateCheckbox, CreateButton = C.CreateCheckbox, C.CreateButton

-- The Units page
Module.CreateUnitsPage = function(self)
	local db = self:GetConfig("UnitFrames")
	local UnitFrames = Engine:GetModule("UnitFrames")
	local unitsPanel, layout = NewPage("DiabolicUIOptionsPanelUnits", L["Units"])

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

	local lowHealthWarning = CreateCheckbox(unitsPanel, "LowHealthWarning", L["Low Health Warning"], L["The edges of the screen pulse red while your health is under 35%, like in Diablo III.|n|nRequires a UI reload to apply."], function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= db.lowHealthWarning) then
			db.lowHealthWarning = checked
			Engine:ReloadUI()
		end
	end)
	layout:Place(lowHealthWarning, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	-- fake members and loot, to see the frames without a group
	CreateHeader(unitsPanel, layout, L["Preview"])
	local toggleFakeParty = CreateButton(unitsPanel, "ToggleFakeParty", L["Toggle Fake Party"], L["Shows or hides a mock party of fake members, to preview the party frames' look without needing a real group."], function(button)
		db.testPartyMode = not db.testPartyMode
		UnitFrames:SetPartyMockShown(db.testPartyMode)
	end)
	local toggleFakeRaid = CreateButton(unitsPanel, "ToggleFakeRaid", L["Toggle Fake Raid"], L["Shows or hides a mock raid of fake members, to preview the raid frames' look without needing a real group."], function(button)
		db.testRaidMode = not db.testRaidMode
		UnitFrames:SetRaidMockShown(db.testRaidMode)
	end)
	local fakeLootRoll = CreateButton(unitsPanel, "FakeLootRoll", L["Fake Loot Roll"], L["Shows the roll window and the loot list with fake loot, to try them without a raid. Needs the roll window on."], function()
		Engine:GetModule("Blizzard: LootPreview"):ShowFakeRoll()
	end)
	local previewRow = layout:Row(BUTTON_HEIGHT, HEADER_GAP)
	layout:Place(toggleFakeParty, EDGE, previewRow)
	layout:Place(toggleFakeRaid, EDGE + SLIDER_COLUMN, previewRow)
	layout:Place(fakeLootRoll, EDGE, layout:Row(BUTTON_HEIGHT, ROW_GAP))

	unitsPanel.okay = function() end
	unitsPanel.cancel = function()
		classColors:SetChecked(db.showClassColors)
		showPortrait:SetChecked(db.showPortrait)
		lowHealthWarning:SetChecked(db.lowHealthWarning)
	end
	unitsPanel.refresh = unitsPanel.cancel
	unitsPanel.cancel()
	return unitsPanel
end
