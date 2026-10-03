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

function TestMenus:test_the_social_button_counts_friends_and_guild_members()
	boot({ world = function(world)
		world.guild = { name = "Testers", members = {
			{ name = "Tester", class = "WARRIOR", online = true },
			{ name = "Ally", class = "MAGE", online = true },
			{ name = "Away", class = "PRIEST" },
		} }
		world.friends = { { name = "Pal", connected = true }, { name = "Gone" } }
	end })
	local social = widget("Menu: Chat").SocialButton
	local L = client.Engine:GetLocale()
	lu.assertEquals(social.People:GetText(), "2") -- one other guild member, one friend
	client:Hover(social)
	local lines = tooltip()
	lu.assertEquals(lines[1], L["Friends & Guild"])
	lu.assertStrContains(table.concat(lines, "\n"), L["Guild Members Online:"] .. "|1")
	lu.assertStrContains(table.concat(lines, "\n"), L["Friends Online:"] .. "|1")
	client:Leave()

	-- the guild window asked for the roster again: so do we
	client:FireEvent("GUILD_ROSTER_UPDATE", 1)
	client.world.guild.members[2].online = nil
	client:Tick(16) -- and every 15 seconds
	client:FireEvent("GUILD_ROSTER_UPDATE")
	lu.assertEquals(social.People:GetText(), "1")

	-- out of the guild, without friends online
	client.world.guild, client.world.friends = nil, {}
	client:FireEvent("PLAYER_GUILD_UPDATE")
	lu.assertEquals(social.People:GetText(), "")
	client:Hover(social)
	lu.assertEquals(tooltip()[1], _G.FRIENDS)
	client:Leave()
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
