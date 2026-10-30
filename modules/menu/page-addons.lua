-- The Frames & AddOns page of /dui config: Blizzard's windows in Diablo
-- III's look, its loot window replaced and the roll window.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local CHECK_X, CHECK_HEIGHT, HEADER_GAP, ROW_GAP = C.CHECK_X, C.CHECK_HEIGHT, C.HEADER_GAP, C.ROW_GAP
local CreateHeader, CreateCheckbox = C.CreateHeader, C.CreateCheckbox

-- The Frames & AddOns page
Module.CreateAddOnsPage = function(self)
	local lootDB = Engine:GetConfig("LootFrame")
	local windowsDB = Engine:GetConfig("Windows")

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
	local addonsPanel, layout = NewPage("DiabolicUIOptionsPanelAddOns", L["Frames & AddOns"])

	CreateHeader(addonsPanel, layout, L["Blizzard Frames"])

	local reskinWindows = CreateCheckbox(addonsPanel, "ReskinWindows", L["Reskin Windows"], L["Shows Blizzard's windows in the Diablo III style: the character, spellbook, talents, quest log, social, mail, merchant, achievements and the other windows, and AdiBags' bags. When disabled, Blizzard's own windows are used.|n|nRequires a UI reload to apply."], reloadOption(windowsDB, "enableSkin"))
	layout:Place(reskinWindows, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	local reskinLoot = CreateCheckbox(addonsPanel, "ReskinLoot", L["Reskin Loot Window"], L["Re-styles the loot window to match the rest of the UI. When disabled, Blizzard's own loot window is used instead.|n|nRequires a UI reload to apply."], function(button)
		local checked = button:GetChecked() and true or false
		if (checked ~= lootDB.enableSkin) then
			lootDB.enableSkin = checked
			Engine:ReloadUI()
		end
	end)
	layout:Place(reskinLoot, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	local rollWindow = CreateCheckbox(addonsPanel, "RollWindow", L["Roll Window"], L["Shows a window when the master looter, the leader or a raid warning puts an item up for a roll, with its time left and buttons to roll for it: Main Spec (/roll 100) or Off Spec (/roll 99). The boss's loot they post in the chat shows in a list on the right.|n|nRequires a UI reload to apply."], reloadOption(lootDB, "rollWindow"))
	layout:Place(rollWindow, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	addonsPanel.okay = function() end
	addonsPanel.cancel = function()
		reskinWindows:SetChecked(windowsDB.enableSkin)
		reskinLoot:SetChecked(lootDB.enableSkin)
		rollWindow:SetChecked(lootDB.rollWindow)
	end
	addonsPanel.refresh = addonsPanel.cancel
	addonsPanel.cancel()
	return addonsPanel
end
