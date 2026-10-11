-- Run from the addon root: lua5.1 tests/test_session_actionbars.lua
--
-- The action bar module in the fake client, beyond the buttons themselves:
-- the menus in the bottom right corner (the main menu, Blizzard's micro
-- buttons, the action bar layout menu, the bag bar, with Bagnon or
-- LiteBag), the gold and fps & latency texts, the XP and reputation bars,
-- the pet bar, the stance bar and its toggle, the vehicle and taxi
-- buttons, the bar count commands and the cast-on-key-down option.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean, tooltipLines, stripColors = Session.assertClean, Session.tooltipLines, Session.stripColors

local client, module

local function boot(options)
	client = Client.boot(options)
	module = client:GetModule("ActionBars")
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

local function visible(widget)
	return widget:IsVisible() == 1
end

local function widget(name)
	return module:GetWidget(name)
end

-- The main menu's two buttons: the micro menu's and the bar layout menu's.
local function mainMenuButtons()
	local menu = widget("Menu: Main")
	local micro = menu.MicroMenuWindow:GetParent()
	for _, button in menu.MasterMenuWindow:GetAll() do
		if button ~= micro then
			return micro, button
		end
	end
end

-- The bag button: the bag bar's window hangs from it.
local function bagButtonOf()
	return _G.MainMenuBarBackpackButton:GetParent():GetParent()
end

local function tooltip()
	local lines = {}
	for i, line in ipairs(tooltipLines(_G.GameTooltip)) do
		lines[i] = stripColors(line)
	end
	return lines
end

-- The menus ---------------------------------------------------------------------

TestMenus = {}

function TestMenus:tearDown()
	client, module = nil, nil
end

function TestMenus:test_the_main_menu_opens_its_windows()
	boot()
	local menu = widget("Menu: Main")
	local master, micro = menu.MasterMenuButton, menu.MicroMenuWindow
	client:Hover(master)
	lu.assertEquals(tooltip()[1], client.Engine:GetLocale()["Main Menu"])
	client:Click(master)
	lu.assertTrue(shown(menu.MasterMenuWindow))
	lu.assertEquals(master:GetButtonState(), "PUSHED")
	lu.assertFalse(shown(_G.GameTooltip)) -- out of the way of the open menu
	client:Leave()

	-- the micro menu: Blizzard's buttons, restyled
	local microButton = micro:GetParent()
	client:Hover(microButton)
	lu.assertEquals(tooltip()[1], client.Engine:GetLocale()["Blizzard Micro Menu"])
	client:Click(microButton)
	lu.assertTrue(shown(micro))
	lu.assertEquals(_G.CharacterMicroButton:GetParent(), micro)
	lu.assertEquals(_G.MicroButtonPortrait:IsVisible(), nil)
	client:Leave()

	-- the action bar menu closes the micro menu
	local _, barMenuButton = mainMenuButtons()
	client:Hover(barMenuButton)
	lu.assertFalse(shown(_G.GameTooltip)) -- not over an open menu
	client:Click(barMenuButton)
	lu.assertFalse(shown(micro))
	client:Leave()
	client:Click(barMenuButton)
	client:Hover(barMenuButton)
	lu.assertEquals(tooltip()[1], client.Engine:GetLocale()["Action Bars"])
	client:Leave()
	assertClean(client)
end

function TestMenus:test_the_micro_buttons()
	boot()
	local menu = widget("Menu: Main")
	local button = _G.CharacterMicroButton
	-- Blizzard's art goes, ours shows the state
	lu.assertEquals(button:GetNormalTexture():GetAlpha(), 0)
	button:SetButtonState("PUSHED")
	lu.assertTrue(shown(button.Pushed))
	lu.assertFalse(shown(button.Normal))
	button:SetButtonState("NORMAL")
	lu.assertTrue(shown(button.Normal))
	-- greyed out while disabled
	button:Disable()
	lu.assertAlmostEquals(select(1, button.Icon:GetVertexColor()), 0.4, 1e-6)
	button:Enable()
	lu.assertEquals(select(1, button.Icon:GetVertexColor()), 1)
	-- the tooltip goes above the menu
	button:SetScript("OnEnter", button:GetScript("OnEnter")) -- (unchanged)
	client:Hover(button)
	if shown(_G.GameTooltip) then
		lu.assertEquals(select(2, _G.GameTooltip:GetPoint()), menu.MicroMenuWindow)
	end
	client:Leave()
	-- the latency bar's tooltip too
	_G.GameTooltip:SetOwner(_G.MainMenuMicroButton, "ANCHOR_RIGHT")
	_G.GameTooltip:AddLine("Latency")
	_G.GameTooltip:Show()
	_G.MainMenuBarPerformanceBarFrame_OnEnter(_G.MainMenuMicroButton)
	lu.assertEquals(select(2, _G.GameTooltip:GetPoint()), menu.MicroMenuWindow)
	_G.GameTooltip:Hide()
	assertClean(client)
end

function TestMenus:test_a_disabled_micro_button_starts_grey()
	-- below level 10 the talent button is disabled before we skin it
	boot({ world = function(world)
		world.units.player.level = 5
		_G.TalentMicroButton:Disable()
	end })
	lu.assertAlmostEquals(select(1, _G.TalentMicroButton.Icon:GetVertexColor()), 0.4, 1e-6)
	assertClean(client)
end

function TestMenus:test_micro_buttons_rearranged_after_combat()
	boot()
	local window = widget("Menu: Main").MicroMenuWindow
	local arranged = 0
	local arrange = window.Arrange
	window.Arrange = function(...) arranged = arranged + 1 return arrange(...) end
	_G.UpdateMicroButtons()
	lu.assertEquals(arranged, 1)
	client:EnterCombat()
	_G.UpdateMicroButtons()
	client:FireEvent("PLAYER_LEVEL_UP", 20)
	lu.assertEquals(arranged, 1)
	-- both catch up: Blizzard's update, and the level up's
	client:LeaveCombat()
	lu.assertEquals(arranged, 3)
	client:FireEvent("PLAYER_LEVEL_UP", 21)
	lu.assertEquals(arranged, 4)
	assertClean(client)
end

function TestMenus:test_the_bag_bar()
	boot()
	local menu = widget("Menu: Main")
	local bagButton = bagButtonOf()
	client:Hover(bagButton)
	lu.assertEquals(tooltip()[1], client.Engine:GetLocale()["Bags"])
	client:Click(bagButton, "LeftButton")
	lu.assertTrue(client.bagsOpen)
	-- right click: the bag bar, with the backpack, bags and keyring
	client:Click(bagButton, "RightButton")
	local window = _G.MainMenuBarBackpackButton:GetParent()
	lu.assertTrue(shown(window))
	lu.assertEquals(bagButton:GetButtonState(), "PUSHED")
	lu.assertEquals(_G.KeyRingButton:GetParent(), window)
	client:Click(bagButton, "RightButton")
	lu.assertFalse(shown(window))
	lu.assertEquals(bagButton:GetButtonState(), "NORMAL")
	-- the backpack open keeps it pushed
	_G.ContainerFrame1:Show()
	lu.assertEquals(bagButton:GetButtonState(), "PUSHED")
	_G.ContainerFrame1:Hide()
	lu.assertEquals(bagButton:GetButtonState(), "NORMAL")
	-- opening another menu closes the bags
	client.bagsOpen = true
	menu.MasterMenuWindow:Show()
	lu.assertFalse(client.bagsOpen)
	client:Leave()
	assertClean(client)
end

local function bagAddons(world)
	table.insert(world.addons, { name = "Bagnon", enabled = true, onLoad = function()
		_G.Bagnon = { OnEnable = function()
			CreateFrame("Frame", "BagnonFrameinventory", _G.UIParent):Hide()
		end }
	end })
	table.insert(world.addons, { name = "LiteBag", enabled = true, onLoad = function()
		CreateFrame("Frame", "LiteBagInventory", _G.UIParent):Hide()
	end })
end

function TestMenus:test_bagnon_and_litebag_bags_push_the_bag_button()
	boot({ world = bagAddons })
	local bagButton = bagButtonOf()
	client.api.LoadAddOn("Bagnon")
	_G.Bagnon:OnEnable()
	_G.BagnonFrameinventory:Show()
	lu.assertEquals(bagButton:GetButtonState(), "PUSHED")
	_G.BagnonFrameinventory:Hide()
	lu.assertEquals(bagButton:GetButtonState(), "NORMAL")

	client.api.LoadAddOn("LiteBag")
	_G.LiteBagInventory:Show()
	lu.assertEquals(bagButton:GetButtonState(), "PUSHED")
	_G.LiteBagInventory:Hide()
	lu.assertEquals(bagButton:GetButtonState(), "NORMAL")
	assertClean(client)
end

function TestMenus:test_bag_addons_loaded_before_us()
	boot({ world = function(world)
		bagAddons(world)
		for _, addon in ipairs(world.addons) do
			if addon.onLoad and (addon.name == "Bagnon" or addon.name == "LiteBag") then
				addon.loaded = true
				addon.onLoad()
			end
		end
		_G.Bagnon.OnEnable()
	end })
	local bagButton = bagButtonOf()
	_G.BagnonFrameinventory:Show()
	lu.assertEquals(bagButton:GetButtonState(), "PUSHED")
	_G.BagnonFrameinventory:Hide()
	_G.LiteBagInventory:Show()
	lu.assertEquals(bagButton:GetButtonState(), "PUSHED")
	assertClean(client)
end

function TestMenus:test_the_social_button_counts_friends_and_guild_members_online()
	boot({ world = function(world)
		world.guild = { name = "Testers", members = {
			{ name = "Tester", class = "WARRIOR", online = true },
			{ name = "Ally", class = "MAGE", online = true },
			{ name = "Away", class = "PRIEST" },
		} }
		world.friends = { { name = "Pal", connected = true }, { name = "Gone" } }
	end })
	local L = client.Engine:GetLocale()
	local social = _G.SocialsMicroButton
	client:Hover(social)
	local lines = tooltip()
	lu.assertEquals(lines[1], "SocialsMicroButton") -- Blizzard's title
	lu.assertStrContains(table.concat(lines, "\n"), L["Guild Members Online:"] .. "|1") -- not you
	lu.assertStrContains(table.concat(lines, "\n"), L["Friends Online:"] .. "|1")
	client:Leave()

	-- only friends
	client.world.guild = nil
	client:Hover(social)
	lines = tooltip()
	lu.assertNotStrContains(table.concat(lines, "\n"), L["Guild Members Online:"])
	lu.assertStrContains(table.concat(lines, "\n"), L["Friends Online:"] .. "|1")
	client:Leave()

	-- nobody: just the title
	client.world.friends = {}
	client:Hover(social)
	lu.assertEquals(#tooltip(), 1)
	client:Leave()
	assertClean(client)
end

function TestMenus:test_the_spec_switch_on_the_skull()
	boot({ world = function(world)
		world.talents = { { "Holy", "", 51 }, { "Protection", "", 20 }, { "Retribution", "", 0 } }
		world.secondaryTalents = { { "Holy", "", 0 }, { "Protection", "", 5 }, { "Retribution", "", 66 } }
	end })
	local L = client.Engine:GetLocale()
	local config = client:GetModule("ActionBars"):GetDB("ActionBars").visuals.specswitch
	local switch = widget("Button: Spec Switch")
	local button = switch:GetFrame()
	lu.assertEquals(button:IsShown(), 1)
	-- talent events before the artwork exists: nothing to update yet
	switch.Button = nil
	switch:Update()
	switch.Button = button
	-- on the skull: anchored where the skull is (a secure button can't
	-- anchor to a texture), its offset above it
	local position = config.position
	lu.assertEquals(button:GetBottom(), _G.DiabolicUISkullTexture:GetBottom() + position[3])
	lu.assertEquals(button:GetCenter(), (_G.DiabolicUISkullTexture:GetCenter()))
	lu.assertEquals(button.Art:GetTexture(), config.textures.normal)

	-- hovering: both specializations, the active one first in white
	client:Hover(button)
	lu.assertEquals(button.Art:GetTexture(), config.textures.highlight)
	local text = table.concat(tooltip(), "\n")
	lu.assertStrContains(text, _G.PRIMARY .. "|Holy (51/20/0)")
	lu.assertStrContains(text, _G.SECONDARY .. "|Retribution (0/5/66)")
	client:RunScript(button, "OnMouseDown", "LeftButton")
	lu.assertEquals(button.Art:GetTexture(), config.textures.pushed)
	client:RunScript(button, "OnMouseUp", "LeftButton")

	-- a click switches to the other one, the tooltip follows
	client:Click(button)
	lu.assertEquals(client.world.talentGroup, 2)
	client:Click(button)
	lu.assertEquals(client.world.talentGroup, 1)
	client:Leave()
	lu.assertEquals(button.Art:GetTexture(), config.textures.normal)

	-- without Dual Talent Specialization: hidden until it's learned
	client.world.numTalentGroups = 1
	client:FireEvent("PLAYER_TALENT_UPDATE")
	lu.assertNil(button:IsShown())
	client.world.numTalentGroups = 2
	client:FireEvent("PLAYER_TALENT_UPDATE")
	lu.assertEquals(button:IsShown(), 1)
	assertClean(client)
end

function TestMenus:test_what_a_specialization_sets_up_once_switched_to_it()
	boot({ world = function(world)
		world.equipmentSets = { { "Holy", "Interface\\Icons\\Holy" }, { "Shadow", "Interface\\Icons\\Shadow" } }
	end })
	local L = client.Engine:GetLocale()
	local bars = client.Engine:GetConfig("ActionBars", "character")
	local switch = widget("Button: Spec Switch")
	local calls = {}
	_G.SLASH_ABS1, _G.SLASH_ABS2 = "/abs", "/actionbarsaver"
	_G.SlashCmdList.ABS = function(arguments) calls[#calls + 1] = "abs " .. arguments end
	local messages = client.widgetState[_G.ChatFrame1].messages
	local lastMessage = function() return messages[#messages].text end

	bars.specEquipSet2, bars.specProfile2, bars.specBars2, bars.specSideBars2 = "Shadow", "shadow", 3, 2
	bars.num_bars, bars.num_side_bars = 1, 0

	-- the switch completes: a moment later, the set, the profile, the bars
	_G.SetActiveTalentGroup(2)
	client:Tick(.5)
	lu.assertEquals(calls, {})
	client:Tick(.6)
	lu.assertEquals(client.world.equippedSet, "Shadow")
	lu.assertEquals(calls, { "abs restore shadow" })
	lu.assertEquals({ bars.num_bars, bars.num_side_bars }, { 3, 2 })
	client:Tick(2)
	lu.assertEquals(#calls, 1) -- once

	-- and back: left as it is, but a gone set and a missing addon say so
	bars.specEquipSet1, bars.specProfile1 = "Deleted", "holy"
	_G.SlashCmdList.ABS = nil
	_G.SetActiveTalentGroup(1)
	client:Tick(1.1)
	lu.assertEquals(client.world.equippedSet, "Shadow")
	lu.assertEquals({ bars.num_bars, bars.num_side_bars }, { 3, 2 })
	lu.assertEquals(messages[#messages - 1].text, L["Equipment set '%s' not found."]:format("Deleted"))
	lu.assertEquals(lastMessage(), L["Action Bar Saver isn't loaded, can't restore '%s'."]:format("holy"))

	-- only one of the bar counts set
	bars.specBars2, bars.specSideBars2 = false, 1
	_G.SetActiveTalentGroup(2)
	client:Tick(1.1)
	lu.assertEquals({ bars.num_bars, bars.num_side_bars }, { 3, 1 })

	-- no switch: the event repeating the current group, or before the first
	-- loading screen (the group at login)
	local count = #calls
	client.world.equippedSet = nil
	client:FireEvent("ACTIVE_TALENT_GROUP_CHANGED", 2, 2)
	switch.talentGroup = nil
	client.world.talentGroup = 1
	client:FireEvent("ACTIVE_TALENT_GROUP_CHANGED", 1, 2)
	client:FireEvent("PLAYER_ENTERING_WORLD")
	client:Tick(1.1)
	lu.assertEquals(#calls, count)
	lu.assertNil(client.world.equippedSet)
	lu.assertEquals(switch.talentGroup, 1)

	_G.SLASH_ABS1, _G.SLASH_ABS2 = nil, nil
	assertClean(client)
end

function TestMenus:test_a_specialization_macro_runs_on_the_next_click()
	boot({ world = function(world)
		world.macros = { [1] = { "Holy Toy", "Interface\\Icons\\Toy", "/use item:44430" } }
	end })
	local L = client.Engine:GetLocale()
	local bars = client.Engine:GetConfig("ActionBars", "character")
	local button = widget("Button: Spec Switch"):GetFrame()
	local messages = client.widgetState[_G.ChatFrame1].messages
	bars.specMacroName2 = "Holy Toy"

	-- the default: no macro, the button only switches
	lu.assertNil(button:GetAttribute("type"))
	client:Click(button)
	lu.assertEquals(client.world.talentGroup, 2)
	lu.assertNil(button:GetAttribute("type"))

	-- the switch completes: the button glows, and says what its click does
	client:Tick(1.1)
	lu.assertEquals(button:GetAttribute("type"), "macro")
	lu.assertEquals(button:GetAttribute("macro"), "Holy Toy")
	lu.assertEquals(button.Glow:IsShown(), 1)
	client:Hover(button)
	lu.assertStrContains(table.concat(tooltip(), "\n"), L["<Left-click> to run your '%s' macro"]:format("Holy Toy"))

	-- its click runs the macro (the template's OnClick), not a switch
	client:Click(button)
	lu.assertEquals(client.world.talentGroup, 2)
	lu.assertNil(button:GetAttribute("type"))
	lu.assertNil(button.Glow:IsShown())
	lu.assertStrContains(table.concat(tooltip(), "\n"), L["<Left-click> to switch"])
	client:Leave()

	-- clicked in combat: the attributes wait for its end
	client:Click(button)
	client:Tick(1.1)
	client:Click(button)
	client:Tick(1.1)
	lu.assertEquals(button:GetAttribute("type"), "macro")
	client.world.inCombat = true
	client:FireEvent("PLAYER_REGEN_DISABLED")
	client:Click(button)
	lu.assertNil(button.Glow:IsShown())
	lu.assertEquals(button:GetAttribute("type"), "macro")
	client.world.inCombat = false
	client:FireEvent("PLAYER_REGEN_ENABLED")
	lu.assertNil(button:GetAttribute("type"))

	-- switching away without clicking: the macro's no longer waiting
	client:Click(button)
	client:Tick(1.1)
	lu.assertEquals(client.world.talentGroup, 1)
	client:Click(button)
	client:Tick(1.1)
	lu.assertEquals(button:GetAttribute("type"), "macro")
	_G.SetActiveTalentGroup(1)
	client:Tick(1.1)
	lu.assertNil(button:GetAttribute("type"))
	lu.assertNil(button.Glow:IsShown())

	-- a deleted macro, or the button turned off: said in the chat
	bars.specMacroName2 = "Gone"
	_G.SetActiveTalentGroup(2)
	client:Tick(1.1)
	lu.assertNil(button:GetAttribute("type"))
	lu.assertEquals(messages[#messages].text, L["Macro '%s' not found."]:format("Gone"))
	bars.specMacroName1, bars.showSpecSwitch = "Holy Toy", false
	_G.SetActiveTalentGroup(1)
	client:Tick(1.1)
	lu.assertNil(button:GetAttribute("type"))
	lu.assertEquals(messages[#messages].text, L["Turn on the specialization switch button to run your '%s' macro."]:format("Holy Toy"))

	-- turned off while one waits: cleared
	bars.showSpecSwitch = true
	widget("Button: Spec Switch"):Update()
	_G.SetActiveTalentGroup(2)
	_G.SetActiveTalentGroup(1)
	client:Tick(1.1)
	lu.assertEquals(button:GetAttribute("type"), "macro")
	bars.showSpecSwitch = false
	widget("Button: Spec Switch"):Update()
	lu.assertNil(button:GetAttribute("type"))
	lu.assertNil(button:IsShown())

	-- updates in combat wait for its end (a secure button)
	bars.showSpecSwitch = true
	client.world.inCombat = true
	widget("Button: Spec Switch"):Update()
	lu.assertNil(button:IsShown())
	client.world.inCombat = false
	client:FireEvent("PLAYER_REGEN_ENABLED")
	lu.assertEquals(button:IsShown(), 1)
	assertClean(client)
end

function TestMenus:test_a_specialization_macro_before_the_switch()
	boot({ world = function(world)
		world.macros = { [1] = { "Corruption", "Interface\\Icons\\Toy", "/say Hoo the corruption" } }
	end })
	local L = client.Engine:GetLocale()
	local bars = client.Engine:GetConfig("ActionBars", "character")
	local switch = widget("Button: Spec Switch")
	local button = switch:GetFrame()
	local messages = client.widgetState[_G.ChatFrame1].messages
	bars.specMacroBefore2 = "Corruption"

	-- the tooltip says it runs first
	client:Hover(button)
	lu.assertStrContains(table.concat(tooltip(), "\n"), L["Runs your '%s' macro first"]:format("Corruption"))
	client:Leave()

	-- the click that switches runs it: the macro set up for the template's
	-- OnClick, then taken off again, and the switch
	local typeOnClick
	button:HookScript("OnClick", function(self) typeOnClick = self:GetAttribute("macro") end)
	client:Click(button)
	lu.assertEquals(typeOnClick, "Corruption")
	lu.assertNil(button:GetAttribute("type"))
	lu.assertEquals(client.world.talentGroup, 2)

	-- a deleted one: said, and it still switches
	bars.specMacroBefore1 = "Gone"
	client:Click(button)
	lu.assertEquals(messages[#messages].text, L["Macro '%s' not found."]:format("Gone"))
	lu.assertEquals(client.world.talentGroup, 1)

	-- a waiting "after" macro shown on the tooltip of a hovered button
	client.world.macros[2] = { "Power", "Interface\\Icons\\Toy", "/say So much power" }
	client:Tick(1.1)
	client:Hover(button)
	switch:SetMacro("Power")
	lu.assertStrContains(table.concat(tooltip(), "\n"), L["<Left-click> to run your '%s' macro"]:format("Power"))
	client:Leave()

	-- what a specialization sets up, run directly
	bars.specBars1 = 2
	switch:RunSpec(1)
	lu.assertEquals(bars.num_bars, 2)

	-- no button yet (the artwork not loaded): nothing to set up on it
	switch.Button = nil
	switch:SetMacro(nil)
	switch:PlaceButton()
	switch.Button = button
	assertClean(client)
end

function TestMenus:test_artwork_loaded_in_combat_places_the_button_after_it()
	boot()
	local switch = widget("Button: Spec Switch")
	switch.Button = nil
	client.world.inCombat = true
	switch:CreateButton()
	lu.assertNil(switch:GetFrame())
	client.world.inCombat = false
	client:FireEvent("PLAYER_REGEN_ENABLED")
	lu.assertEquals(switch:GetFrame():IsShown(), 1)
	assertClean(client)
end

function TestMenus:test_the_old_commands_become_a_macro()
	boot({ world = function(world)
		world.talents = { { "Discipline", "", 13 }, { "Holy", "", 58 }, { "Shadow", "", 0 } }
		world.secondaryTalents = { { "Discipline", "", 14 }, { "Holy", "", 0 }, { "Shadow", "", 57 } }
		world.macros = { [37] = { "DUI Shadow", "", "/say hi" } }
	end })
	local L = client.Engine:GetLocale()
	local bars = client.Engine:GetConfig("ActionBars", "character")
	local switch = widget("Button: Spec Switch")
	local messages = client.widgetState[_G.ChatFrame1].messages

	bars.specMacro1, bars.specMacro2 = "/use item:44430\n/gear holy", "/use item:1"
	switch:MoveCommandsToMacros()
	lu.assertEquals({ _G.GetMacroInfo("DUI Holy") }, { "DUI Holy", "Interface\\Icons\\INV_Misc_QuestionMark", "/use item:44430\n/gear holy", 1 })
	lu.assertEquals({ bars.specMacroName1, bars.specMacro1 }, { "DUI Holy", nil })
	lu.assertEquals(messages[#messages].text, L["Your other commands are now the character macro '%s', run by a click on the skull after switching."]:format("DUI Holy"))
	-- one by that name already: picked as it is
	lu.assertEquals({ bars.specMacroName2, bars.specMacro2 }, { "DUI Shadow", nil })
	lu.assertEquals(select(3, _G.GetMacroInfo("DUI Shadow")), "/say hi")

	-- blank: dropped; a macro already picked: left alone
	bars.specMacroName1, bars.specMacro1, bars.specMacro2 = false, "  \n ", "/x"
	switch:MoveCommandsToMacros()
	lu.assertEquals({ bars.specMacroName1, bars.specMacro1 }, { false, nil })
	lu.assertEquals({ bars.specMacroName2, bars.specMacro2 }, { "DUI Shadow", "/x" })

	-- no free slot: kept, and said
	for index = 37, 54 do
		client.world.macros[index] = client.world.macros[index] or { "M" .. index, "", "" }
	end
	bars.specMacroName2, bars.specMacro2 = false, "/use item:1"
	client.world.macros[37] = { "Other", "", "" }
	switch:MoveCommandsToMacros()
	lu.assertEquals({ bars.specMacroName2, bars.specMacro2 }, { false, "/use item:1" })
	lu.assertEquals(messages[#messages].text, L["No free character macro slot for your %s commands, they're kept until there's one."]:format("DUI Shadow"))

	-- too long for a macro: printed for you to make it
	bars.specMacro2 = string.rep("x", 256)
	switch:MoveCommandsToMacros()
	lu.assertNil(bars.specMacro2)
	lu.assertStrContains(messages[#messages].text, string.rep("x", 256))

	-- done at the loading screen, out of combat
	bars.specMacro1 = "/use item:2"
	client.world.inCombat = true
	client:FireEvent("PLAYER_ENTERING_WORLD")
	lu.assertEquals(bars.specMacro1, "/use item:2")
	assertClean(client)
end

function TestMenus:test_the_dropdown_choices()
	boot({ world = function(world)
		world.equipmentSets = { { "Holy", "Interface\\Icons\\Holy" } }
	end })
	local switch = widget("Button: Spec Switch")
	lu.assertEquals(switch:GetEquipmentSets(), { { text = "Holy", value = "Holy", icon = "Interface\\Icons\\Holy" } })
	lu.assertNil(switch:GetActionBarProfiles()) -- not loaded
	_G.SlashCmdList.ABS = function() end
	_G.ActionBarSaverDB = { sets = { WARRIOR = { tank = {}, arms = {} }, PRIEST = { holy = {} } } }
	lu.assertEquals(switch:GetActionBarProfiles(), { { text = "arms", value = "arms" }, { text = "tank", value = "tank" } })
	_G.ActionBarSaverDB.sets.WARRIOR = nil
	lu.assertEquals(switch:GetActionBarProfiles(), {})
	_G.SlashCmdList.ABS, _G.ActionBarSaverDB = nil, nil

	-- the macros: the account ones, then the character ones
	client.world.macros = { [2] = { "Mount", "Interface\\Icons\\Mount", "" }, [1] = { "Toy", "Interface\\Icons\\Toy", "" }, [37] = { "DUI Holy", "Interface\\Icons\\Q", "" } }
	lu.assertEquals(switch:GetMacros(), {
		{ text = "Toy", value = "Toy", icon = "Interface\\Icons\\Toy" },
		{ text = "Mount", value = "Mount", icon = "Interface\\Icons\\Mount" },
		{ text = "DUI Holy", value = "DUI Holy", icon = "Interface\\Icons\\Q" },
	})
	assertClean(client)
end

function TestMenus:test_the_bar_layout_menu()
	boot()
	local Main = widget("Controller: Main"):GetFrame()
	local _, barMenuButton = mainMenuButtons()
	local layout
	for _, child in ipairs({ barMenuButton:GetChildren() }) do
		if child.button1 then
			layout = child
		end
	end
	lu.assertNotNil(layout)
	layout:Show()
	client:Click(layout.button2)
	lu.assertEquals(Main:GetAttribute("numbars"), 2)
	client:Click(layout.button4)
	lu.assertEquals(Main:GetAttribute("numsidebars"), 0)
	client:Click(layout.button6)
	lu.assertEquals(Main:GetAttribute("numsidebars"), 2)
	client:Click(layout.button3)
	lu.assertEquals(Main:GetAttribute("numbars"), 3)
	client:Click(layout.button1)
	client:Click(layout.button5)
	lu.assertEquals(Main:GetAttribute("numbars"), 1)
	lu.assertEquals(Main:GetAttribute("numsidebars"), 1)

	-- the buttons light up and press
	local button = layout.button2
	client:Hover(button)
	lu.assertTrue(shown(button.highlight))
	client:RunScript(button, "OnMouseDown", "LeftButton")
	lu.assertTrue(shown(button.pushed))
	client:Leave()
	lu.assertTrue(shown(button.highlight))
	client:RunScript(button, "OnMouseUp", "LeftButton")
	lu.assertTrue(shown(button.normal))
	assertClean(client)
end

function TestMenus:test_gold_and_performance()
	boot()
	local bars = client.Engine:GetConfig("ActionBars", "character")
	local menu = widget("Menu: Main")
	local button = menu.MasterMenuButton
	client.world.money = 123456
	client:FireEvent("PLAYER_MONEY")
	lu.assertNotEquals(button.Gold:GetText(), nil)

	bars.showPerformance = true
	menu:UpdatePerformanceVisibility()
	client.world.framerate, client.world.latency = 59.6, 45
	client:Tick(1.2)
	lu.assertEquals(stripColors(button.Performance:GetText()), "45" .. _G.MILLISECONDS_ABBR .. " - 59" .. _G.FPS_ABBR)
	-- next to the gold, or in its place
	bars.showGold = true
	menu:UpdateGoldVisibility()
	lu.assertEquals(select(2, button.Performance:GetPoint()), button.Gold)
	bars.showGold = false
	menu:UpdateGoldVisibility()
	lu.assertNotEquals(select(2, button.Performance:GetPoint()), button.Gold)

	-- Ctrl+R toggles ours, Blizzard's stays hidden
	_G.ToggleFramerate()
	lu.assertFalse(bars.showPerformance)
	lu.assertFalse(shown(button.Performance))
	lu.assertFalse(shown(_G.FramerateText))
	_G.ToggleFramerate()
	lu.assertTrue(bars.showPerformance)
	assertClean(client)
end

-- XP and reputation --------------------------------------------------------------

TestXPBars = {}

function TestXPBars:tearDown()
	client, module = nil, nil
end

function TestXPBars:test_the_xp_bar_and_its_tooltip()
	boot({ world = function(world)
		world.units.player.level = 40
		world.xp, world.xpMax, world.exhaustion, world.restState, world.resting = 1000, 5000, 2000, 1, true
		world.timeToWellRested = 3 * 3600
	end })
	local xp = widget("Bar: XP")
	local L = client.Engine:GetLocale()
	lu.assertTrue(shown(xp:GetFrame()))
	lu.assertEquals(xp.Bar.XP:GetValue(), 1000)
	lu.assertEquals(xp.Bar.Rested:GetValue(), 3000)
	client:Hover(xp:GetFrame())
	local lines = table.concat(tooltip(), "\n")
	lu.assertStrContains(lines, L["Rested"])
	lu.assertStrContains(lines, L["Rested Bonus: "])
	lu.assertStrContains(lines, L["Resting"])
	lu.assertStrContains(lines, L["You must rest for %s additional\nhours to become fully rested."]:format("3"))
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))

	client.world.timeToWellRested = 30 * 60
	client:Hover(xp:GetFrame())
	lu.assertStrContains(table.concat(tooltip(), "\n"), L["You must rest for %s additional\nminutes to become fully rested."]:format("30"))
	client:Leave()

	-- not rested
	client.world.exhaustion, client.world.restState, client.world.resting = nil, 2, false
	client.world.timeToWellRested = nil
	client:FireEvent("PLAYER_UPDATE_RESTING")
	client:Hover(xp:GetFrame())
	lu.assertStrContains(table.concat(tooltip(), "\n"), L["You should rest at an Inn."])
	client:Leave()

	-- nothing to show without a maximum
	client.world.xpMax = 0
	client:FireEvent("PLAYER_XP_UPDATE", "player")
	client:Hover(xp:GetFrame())
	lu.assertFalse(shown(_G.GameTooltip))
	client:Leave()
	client.world.xpMax = 5000

	-- another unit's vehicle changes nothing
	client:FireEvent("UNIT_ENTERED_VEHICLE", "party1")
	-- the bar layout changes size
	widget("Controller: Main"):GetFrame():SetAttribute("numbars", 2)
	assertClean(client)
end

function TestXPBars:test_at_the_level_cap_or_watching_a_faction()
	boot({ world = function(world) world.units.player.level = 80 end })
	local xp, rep = widget("Bar: XP"), widget("Bar: Reputation")
	lu.assertFalse(shown(xp:GetFrame()))
	lu.assertFalse(shown(rep:GetFrame()))

	client.world.watchedFaction = { name = "The Kalu'ak", standing = 5, min = 3000, max = 9000, value = 4500, id = 1073 }
	client:FireEvent("UPDATE_FACTION")
	lu.assertTrue(shown(rep:GetFrame()))
	lu.assertEquals(rep.Bar.XP:GetValue(), 1500)
	client:Hover(rep:GetFrame())
	lu.assertEquals(tooltip()[1], "The Kalu'ak")
	client:Leave()
	client:RunScript(rep:GetFrame(), "OnMouseUp", "LeftButton")
	lu.assertEquals(client.toggled, "CharacterFrame:ReputationFrame")
	widget("Controller: Main"):GetFrame():SetAttribute("numbars", 3)

	-- the XP bar gives way to the reputation bar below the cap too
	client.world.units.player.level = 70
	client:FireEvent("PLAYER_LEVEL_UP", 70)
	lu.assertFalse(shown(xp:GetFrame()))
	client.world.watchedFaction = nil
	client:FireEvent("UPDATE_FACTION")
	client:FireEvent("PLAYER_XP_UPDATE", "player")
	lu.assertTrue(shown(xp:GetFrame()))
	lu.assertFalse(shown(rep:GetFrame()))
	-- nothing to show for an empty faction
	rep.Bar:Update()
	rep.Bar:OnEnter()
	assertClean(client)
end

-- Pet and stance bars ----------------------------------------------------------------

TestPetAndStance = {}

function TestPetAndStance:tearDown()
	client, module = nil, nil
end

function TestPetAndStance:test_a_low_level_warlocks_imp_gets_its_bar()
	boot({ class = "WARLOCK", world = function(world)
		world.units.player.level = 5
		world.units.pet = Client.newUnit({ name = "Imp" })
	end })
	local bar = widget("Bar: Pet"):GetFrame()
	lu.assertTrue(visible(bar))
	client:SetUnit("pet", nil)
	lu.assertFalse(visible(bar))
	assertClean(client)
end

function TestPetAndStance:test_the_pet_bar_moves_out_of_the_xp_bars_way()
	boot({ class = "HUNTER", world = function(world)
		world.units.player.level = 80
		world.units.pet = Client.newUnit({ name = "Wolf" })
	end })
	local config = module.config.structure.bars.pet
	local bar = widget("Bar: Pet"):GetFrame()
	lu.assertEquals(select(5, bar:GetPoint()), config.position[#config.position])
	-- in combat it waits
	client:EnterCombat()
	client.world.watchedFaction = { name = "Argent Crusade", standing = 4, min = 0, max = 3000, value = 10, id = 1106 }
	client:FireEvent("UPDATE_FACTION")
	lu.assertEquals(select(5, bar:GetPoint()), config.position[#config.position])
	client:LeaveCombat()
	lu.assertEquals(select(5, bar:GetPoint()), config.positionXP[#config.positionXP])
	assertClean(client)
end

local function forms(count, active)
	local list = {}
	for i = 1, count do
		list[i] = { name = "Form " .. i, texture = "Interface\\Icons\\Form" .. i, active = (i == active) }
	end
	return list
end

function TestPetAndStance:test_the_stance_bar_and_its_toggle()
	boot({ class = "WARRIOR", world = function(world) world.forms = forms(3, 1) end })
	local toggle = _G.EngineStanceBarButton
	local bar = widget("Bar: Stance"):GetFrame()
	lu.assertTrue(shown(toggle))
	lu.assertFalse(visible(bar))
	client:Hover(toggle)
	lu.assertEquals(tooltip()[1], client.Engine:GetLocale()["Stances"])
	client:Leave()
	-- left click opens it
	client:Click(toggle, "LeftButton")
	lu.assertTrue(visible(bar))
	lu.assertEquals(bar.buttons[1]:GetChecked(), 1)
	lu.assertFalse(shown(bar.buttons[4]))
	client:Click(toggle, "LeftButton")
	lu.assertFalse(visible(bar))

	-- a form changes: checked state follows
	client.world.forms[1].active, client.world.forms[2].active = false, true
	client:FireEvent("UPDATE_SHAPESHIFT_FORM")
	lu.assertEquals(bar.buttons[2]:GetChecked(), 1)
	lu.assertNil(bar.buttons[1]:GetChecked())

	-- a new form learned in combat: after it
	client:EnterCombat()
	client.world.forms = forms(4, 2)
	client:FireEvent("UPDATE_SHAPESHIFT_FORMS")
	client:LeaveCombat()
	lu.assertTrue(shown(bar.buttons[4]))

	-- no forms left (a respec): toggle and bar go
	client.world.forms = {}
	client:FireEvent("UPDATE_SHAPESHIFT_FORMS")
	lu.assertFalse(shown(toggle))
	lu.assertFalse(visible(bar))
	assertClean(client)
end

-- The forms' spells, with their icons: the toggle shows a form's spell icon
-- (some forms report another texture while active).
local function formSpells(world, count)
	for i = 1, count do
		world.spells["Form " .. i] = { name = "Form " .. i, icon = "Interface\\Icons\\SpellForm" .. i }
	end
end

function TestPetAndStance:test_the_toggle_shows_the_active_form()
	boot({ class = "WARRIOR", world = function(world)
		world.forms = forms(3, 1)
		formSpells(world, 3)
	end })
	local icon = _G.EngineStanceBarButton.Icon
	local default = module.config.visuals.floaters.stance.icon.texture
	lu.assertEquals(icon:GetTexture(), "Interface\\Icons\\SpellForm1")
	client.world.forms[1].active, client.world.forms[3].active = false, true
	client:FireEvent("UPDATE_SHAPESHIFT_FORM")
	lu.assertEquals(icon:GetTexture(), "Interface\\Icons\\SpellForm3")
	-- no form on: its own icon
	client.world.forms[3].active = false
	client:FireEvent("UPDATE_SHAPESHIFT_FORM")
	lu.assertEquals(icon:GetTexture(), default)
	lu.assertEquals({ icon:GetVertexColor() }, { 1, 1, 1, 1 })
	assertClean(client)
end

function TestPetAndStance:test_a_single_form_is_its_own_button()
	boot({ class = "PRIEST", world = function(world)
		world.forms = forms(1)
		formSpells(world, 1)
	end })
	local L = client.Engine:GetLocale()
	local floaters = widget("Bar: Floaters")
	local toggle, proxy = _G.EngineStanceBarButton, floaters.StanceProxyButton
	local bar = widget("Bar: Stance"):GetFrame()
	-- a click is the form's own button's
	lu.assertEquals(proxy:GetAttribute("clickbutton1"), bar.buttons[1])
	lu.assertFalse(visible(bar))
	-- its icon, dimmed while the form is off
	lu.assertEquals(toggle.Icon:GetTexture(), "Interface\\Icons\\SpellForm1")
	lu.assertEquals({ toggle.Icon:GetVertexColor() }, { .5, .5, .5, 1 })
	client.world.forms[1].active = true
	client:FireEvent("UPDATE_SHAPESHIFT_FORM")
	lu.assertEquals({ toggle.Icon:GetVertexColor() }, { 1, 1, 1, 1 })
	client:Hover(proxy)
	lu.assertEquals(tooltip()[1], "Form 1")
	lu.assertEquals(tooltip()[2], L["<Left-click> to use %s."]:format("Form 1"))
	client:Leave()

	-- more forms learned: it opens the bar again
	client.world.forms = forms(2, 1)
	client:FireEvent("UPDATE_SHAPESHIFT_FORMS")
	lu.assertEquals(proxy:GetAttribute("clickbutton1"), toggle)
	client:Hover(proxy)
	lu.assertEquals(tooltip()[1], L["Stances"])
	client:Leave()
	assertClean(client)
end

function TestPetAndStance:test_no_forms_no_toggle()
	boot({ class = "MAGE" })
	lu.assertFalse(shown(_G.EngineStanceBarButton))
	assertClean(client)
end

-- Vehicle and taxi buttons ----------------------------------------------------------------

TestFloaters = {}

function TestFloaters:tearDown()
	client, module = nil, nil
end

function TestFloaters:test_the_taxi_button_requests_a_stop()
	boot()
	local button = _G.EngineTaxiExitButton
	client.world.units.player.onTaxi = true
	client:FireEvent("PLAYER_CONTROL_LOST")
	lu.assertTrue(visible(button))
	lu.assertEquals(button:IsEnabled(), 1)
	client:Hover(button)
	lu.assertEquals(tooltip()[1], client.Engine:GetLocale()["Request Stop"])
	client:Click(button, "LeftButton")
	lu.assertTrue(client.world.units.player.landingRequested)
	client:Leave()
	-- landed
	client.world.units.player.onTaxi = false
	client:FireEvent("PLAYER_CONTROL_GAINED")
	lu.assertFalse(visible(button))
	-- not in combat: once it's over
	client:EnterCombat()
	client.world.units.player.onTaxi = true
	client:FireEvent("PLAYER_CONTROL_LOST")
	lu.assertFalse(visible(button))
	client:LeaveCombat()
	lu.assertTrue(visible(button))
	assertClean(client)
end

function TestFloaters:test_the_vehicle_exit_button()
	boot()
	local button = _G.EngineVehicleExitButton
	lu.assertFalse(shown(button))
	local player = client.world.units.player
	player.inVehicle, player.vehicle = true, Client.newUnit({ name = "Siege Engine" })
	client:FireEvent("UNIT_ENTERED_VEHICLE", "player")
	lu.assertTrue(shown(button))
	client:Hover(button)
	lu.assertEquals(tooltip()[1], _G.LEAVE_VEHICLE)
	client:RunScript(button, "OnMouseDown", "LeftButton")
	lu.assertTrue(shown(button.Pushed))
	client:RunScript(button, "OnMouseUp", "LeftButton")
	lu.assertTrue(shown(button.Highlight))
	client:Leave()
	lu.assertTrue(shown(button.Normal))

	-- held down as it went away: back to normal when it comes back
	client:Hover(button)
	client:RunScript(button, "OnMouseDown", "LeftButton")
	button:Hide()
	client.mouseFocus = nil
	button:Show()
	lu.assertTrue(shown(button.Normal))
	lu.assertFalse(shown(button.Pushed))
	assertClean(client)
end

-- Commands and options ----------------------------------------------------------------------

TestBarSettings = {}

function TestBarSettings:tearDown()
	client, module = nil, nil
end

function TestBarSettings:test_the_bar_count_commands()
	boot()
	local printed = {}
	_G.print = function(text) printed[#printed + 1] = text end
	local Main = widget("Controller: Main"):GetFrame()
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("num_bars 2")
	lu.assertEquals(module.db.num_bars, 2)
	lu.assertEquals(Main:GetAttribute("numbars"), 2)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("num_bars 7")
	lu.assertEquals(module.db.num_bars, 2)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("num_side_bars 0")
	lu.assertEquals(Main:GetAttribute("numsidebars"), 0)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("num_side_bars x")
	lu.assertEquals(#printed, 4)
	assertClean(client)
end

function TestBarSettings:test_cast_on_key_down()
	boot()
	local checkbox = _G.InterfaceOptionsCombatPanelActionButtonUseKeyDown
	lu.assertNotNil(checkbox)
	checkbox:SetChecked(true)
	client:RunScript(checkbox, "OnClick", "LeftButton")
	lu.assertEquals(_G.GetCVar("ActionButtonUseKeyDown"), "1")
	lu.assertEquals(module.db.cast_on_down, 1)
	checkbox:SetChecked(false)
	client:RunScript(checkbox, "OnClick", "LeftButton")
	lu.assertEquals(module.db.cast_on_down, 0)
	assertClean(client)
end

function TestBarSettings:test_cast_on_key_down_after_a_reload()
	-- the CVar stays registered through a /reload: the option comes back anyway
	boot({ world = function(world) world.cvars.ActionButtonUseKeyDown = "1" end })
	local checkbox = _G.InterfaceOptionsCombatPanelActionButtonUseKeyDown
	lu.assertNotNil(checkbox)
	lu.assertEquals(_G.GetCVar("ActionButtonUseKeyDown"), "0") -- the saved setting
	checkbox:SetChecked(true)
	client:RunScript(checkbox, "OnClick", "LeftButton")
	lu.assertEquals(module.db.cast_on_down, 1)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
