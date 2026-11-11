-- The main page of /dui config: the on/off options (world messages, names
-- in combat, the menu's gold, the unit frames, Blizzard's windows,
-- the chat). The scale and the positions are on the Positions page.
local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Lua API
local ipairs = ipairs

-- WoW API
local CreateFrame = CreateFrame
local GetAddOnMetadata = GetAddOnMetadata

-- the controls (controls.lua)
local C = Module.Controls
local EDGE, SLIDER_COLUMN, TITLE_HEIGHT, LOGO_HEIGHT = C.EDGE, C.SLIDER_COLUMN, C.TITLE_HEIGHT, C.LOGO_HEIGHT
local HEADER_GAP, ROW_GAP, CHECK_X, CHECK_HEIGHT = C.HEADER_GAP, C.ROW_GAP, C.CHECK_X, C.CHECK_HEIGHT
local CREST_RIGHT = C.CREST_RIGHT
local NewLayout, CreateHeader, CreateCheckbox = C.NewLayout, C.CreateHeader, C.CreateCheckbox

local LOGO_TOP = 8 -- the logo's top, from the page's (its art has room above it)

-- The DiabolicUI page itself; Positions and Specializations go under it
Module.CreateMainPage = function(self)
	local panel = CreateFrame("Frame", "DiabolicUIOptionsPanel", InterfaceOptionsFramePanelContainer)
	panel.name = "DiabolicUI"
	panel:Hide()
	local page = panel

	-- the logo as its title (the name once), the version where the other
	-- pages have their crest, then the options
	local layout = NewLayout(page)
	local logo = page:CreateTexture(nil, "ARTWORK")
	logo:SetSize(160, LOGO_HEIGHT)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\DiabolicUI_Logo.tga]]):format(Addon))
	layout:Place(logo, EDGE, layout:Row(LOGO_HEIGHT, LOGO_TOP - EDGE))

	local version = page:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
	version:SetPoint("RIGHT", page, "TOPRIGHT", -CREST_RIGHT, -EDGE - TITLE_HEIGHT / 2)
	version:SetText(L["Version %s"]:format(GetAddOnMetadata(Addon, "Version") or "?"))

	-- On and off, two to a row --------------------------------------------
	local objectivesDB = Engine:GetConfig("ObjectiveTracker")
	local unitsDB = Engine:GetConfig("UnitFrames")
	local actionbarsDB = Engine:GetConfig("ActionBars", "character")
	local lootDB = Engine:GetConfig("LootFrame")
	local windowsDB = Engine:GetConfig("Windows")

	-- on/off with a reload
	local reloadOption = function(config, setting)
		return function(button)
			local checked = button:GetChecked() and true or false
			if checked ~= config[setting] then
				config[setting] = checked
				Engine:ReloadUI()
			end
		end
	end

	-- { name, label, description, onClick, config, setting }
	local options = {
		{
			"WorldMessages",
			L["Zone & Loot Messages"],
			L["Boss and zone names over the world, and your gold, XP and loot at the right."],
			function(button)
				objectivesDB.worldMessages = button:GetChecked() and true or false
			end,
			objectivesDB,
			"worldMessages",
		},
		{
			"CombatNames",
			L["Hide Names Out of Combat"],
			L["Names and nameplates hidden out of combat. Enemy players' names stay, except in Dalaran and Shattrath."],
			function(button)
				unitsDB.combatNames = button:GetChecked() and true or false
				Engine:GetModule("CombatNames"):Apply()
			end,
			unitsDB,
			"combatNames",
		},
		{
			"ShowGold",
			L["Show Gold"],
			L["Your gold next to the menu button."],
			function(button)
				actionbarsDB.showGold = button:GetChecked() and true or false
				Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdateGoldVisibility()
			end,
			actionbarsDB,
			"showGold",
		},
		{
			"ClassColors",
			L["Class-Colored Health"],
			L["Health bars in class colors.|n|nNeeds a reload. Preview: /dui party, /dui raid"],
			reloadOption(unitsDB, "showClassColors"),
			unitsDB,
			"showClassColors",
		},
		{
			"ShowPortrait",
			L["3D Portraits"],
			L["3D portraits on the party and focus frames.|n|nNeeds a reload."],
			reloadOption(unitsDB, "showPortrait"),
			unitsDB,
			"showPortrait",
		},
		{
			"LowHealthWarning",
			L["Low Health Warning"],
			L["The screen edges pulse red under 35% health.|n|nNeeds a reload."],
			reloadOption(unitsDB, "lowHealthWarning"),
			unitsDB,
			"lowHealthWarning",
		},
		{
			"ReskinWindows",
			L["Diablo III Windows"],
			L["Blizzard's windows (character, bags, loot...) in the Diablo III style.|n|nNeeds a reload."],
			reloadOption(windowsDB, "enableSkin"),
			windowsDB,
			"enableSkin",
		},
		{
			"RollWindow",
			L["Master Loot Rolls"],
			L["A window to roll Main Spec or Off Spec when the master looter puts an item up.|n|nNeeds a reload. Preview: /dui loot"],
			reloadOption(lootDB, "rollWindow"),
			lootDB,
			"rollWindow",
		},
	}
	local chatDB = Engine:GetConfig("ChatFilters")
	local chatOption = function(name, label, description, setting)
		return {
			name,
			label,
			description,
			function(button)
				chatDB[setting] = button:GetChecked() and true or false
			end,
			chatDB,
			setting,
		}
	end
	local chatOptions = {
		chatOption(
			"ShortMessages",
			L["Shorter Messages"],
			L["Loot, XP, reputation and other system lines made short: '+ [Item] (3)'."],
			"shortMessages"
		),
		chatOption(
			"HideChannelNotices",
			L["Hide Channel Notices"],
			L["Hides channel join and leave notices, and empty lines."],
			"hideChatNoise"
		),
		chatOption(
			"ShortChannels",
			L["Short Channel Names"],
			L["'Guild' becomes 'G', '2. Trade - City' becomes '2.'."],
			"shortChannels"
		),
		chatOption(
			"ChatHistory",
			L["Chat History"],
			L["The last 100 chat lines come back after a reload or relog."],
			"chatHistory"
		),
	}

	-- each section's checkboxes two to a row; `all` keeps them for cancel
	local all = {}
	for _, section in ipairs({ { L["General"], options }, { L["Chat"], chatOptions } }) do
		CreateHeader(page, layout, section[1])
		local row
		for i, option in ipairs(section[2]) do
			local checkbox = CreateCheckbox(page, option[1], option[2], option[3], option[4])
			if i % 2 == 1 then
				row = layout:Row(CHECK_HEIGHT, i == 1 and HEADER_GAP or ROW_GAP)
				layout:Place(checkbox, CHECK_X, row)
			else
				layout:Place(checkbox, CHECK_X + SLIDER_COLUMN, row)
			end
			all[#all + 1] = { checkbox, option[5], option[6] }
		end
	end

	panel.okay = function() end
	panel.cancel = function()
		for _, check in ipairs(all) do
			check[1]:SetChecked(check[2][check[3]])
		end
	end
	panel.refresh = panel.cancel
	panel.cancel()
	return panel
end
