-- Run from the addon root: lua5.1 tests/test_session_login.lua
--
-- The whole addon in the fake client (tests/mocks/client.lua), from login:
--  - every class logs in without a Lua error or a blocked action
--  - a /reload with the saved variables of the last session keeps the
--    settings, and the first login of a new character (the client already
--    logged in when VARIABLES_LOADED fires) works too
--  - every event the addon listens to, fired with a plausible payload, in
--    and out of combat
--  - every frame with a mouse script hovered and clicked
-- Nothing here checks a feature in detail (the other test_session_* files
-- do); it catches the errors that only show once everything is loaded
-- together and the game starts talking to it.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")

local CLASSES = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }

local function assertClean(client, context)
	local problems = client:Problems()
	if problems ~= "" then
		lu.fail((context and (context .. ":\n") or "") .. problems)
	end
end

-- Payloads for the events the addon registers: the unit events get a unit,
-- the rest what the client passes.
local EVENT_ARGS = {
	ADDON_LOADED = { "Blizzard_TimeManager" },
	ARENA_OPPONENT_UPDATE = { "arena1", "seen" },
	COMBAT_LOG_EVENT_UNFILTERED = { 1000, "SPELL_DAMAGE", "0x01", "Tester", 0x511, "0x02", "Hogger", 0xa48, 133, "Fireball", 4, 500 },
	CVAR_UPDATE = { "USE_UISCALE", "1" },
	MODIFIER_STATE_CHANGED = { "LSHIFT", 1 },
	PLAYER_ENTERING_WORLD = {},
	PLAYER_LEVEL_UP = { 80 },
	SYSMSG = { "System message", 1, 1, 0 },
	UI_ERROR_MESSAGE = { "Not enough mana" },
	UI_INFO_MESSAGE = { "Quest accepted: Test" },
	UNIT_AURA = { "player" },
	UNIT_ENTERED_VEHICLE = { "player" },
	UNIT_ENTERING_VEHICLE = { "player" },
	UNIT_EXITED_VEHICLE = { "player" },
	UNIT_EXITING_VEHICLE = { "player" },
	UNIT_INVENTORY_CHANGED = { "player" },
	UNIT_LEVEL = { "target" },
	UNIT_NAME_UPDATE = { "target" },
	UNIT_PET = { "player" },
	UNIT_TARGET = { "target" },
	UNIT_THREAT_SITUATION_UPDATE = { "player" },
	VARIABLES_LOADED = {},
}

-- Events that mean the game changed state: fired by EnterCombat,
-- LeaveCombat or logging out, never on their own.
local STATE_EVENTS = {
	PLAYER_REGEN_DISABLED = true, PLAYER_REGEN_ENABLED = true, PLAYER_LOGOUT = true,
}

local function argsFor(event)
	if EVENT_ARGS[event] then
		return unpack(EVENT_ARGS[event])
	end
	if event:match("^UNIT_") then
		return "player"
	end
end

-- A world with something in every unit slot, so unit events have work.
local function crowdedWorld(world)
	local newUnit = Client.newUnit
	world.units.target = newUnit({ name = "Hogger", isPlayer = false, class = "WARRIOR", classification = "elite",
		canAttack = true, isEnemy = true, isFriend = false, reaction = 2, playerControlled = false, level = 82,
		health = 3000, healthMax = 10000,
		auras = { { name = "Sunder Armor", harmful = true, count = 3, duration = 30, expires = 1020, caster = "player" } } })
	world.units.target.target = "player"
	world.units.focus = newUnit({ name = "Focus", class = "MAGE", powerType = 0 })
	world.units.pet = newUnit({ name = "Wolf", isPlayer = false, creatureFamily = "Wolf", powerType = 2, power = 50, powerMax = 100 })
	for i = 1, 4 do
		world.units["party" .. i] = newUnit({ class = CLASSES[i + 1], role = (i == 1) and "TANK" or (i == 2 and "HEALER" or "DAMAGER") })
	end
	world.units.boss1 = newUnit({ name = "Lich King", isPlayer = false, classification = "worldboss", level = -1, canAttack = true })
	world.units.player.auras = {
		{ name = "Power Word: Fortitude", duration = 3600, expires = 4600, caster = "party2" },
		{ name = "Weakened Soul", harmful = true, duration = 15, expires = 1015, debuffType = "Magic" },
	}
	world.units.player.casting = { name = "Fireball", startTime = 1000000, endTime = 1003000 }
	world.watchedFaction = { name = "The Kalu'ak", standing = 5, min = 3000, max = 9000, value = 5000 }
	world.mail, world.mailSenders = true, { "Postman" }
	world.friends = { { name = "Buddy", level = 80, class = "Priest", area = "Dalaran", connected = true } }
	world.guild = { name = "Testers", members = { { name = "Tester", class = "WARRIOR", online = true }, { name = "Away", class = "MAGE" } } }
end

TestSessionLogin = {}

function TestSessionLogin:test_every_class_logs_in_cleanly()
	for _, class in ipairs(CLASSES) do
		local client = Client.boot({ class = class })
		assertClean(client, class)
		lu.assertTrue(client.firedEvents.PLAYER_LOGIN == 1)
		lu.assertNotNil(client:GetModule("ActionBars"), class)
	end
end

function TestSessionLogin:test_reload_keeps_the_saved_settings()
	local client = Client.boot({ class = "MAGE" })
	local db = client.Engine:GetConfig("ChatWindows")
	db.fadeChat = not db.fadeChat
	local fade = db.fadeChat
	client:FireEvent("PLAYER_LOGOUT")
	local saved = { DiabolicUI_DB = _G.DiabolicUI_DB, DiabolicUI_Minimap_DB = _G.DiabolicUI_Minimap_DB }
	lu.assertNotNil(saved.DiabolicUI_DB)
	lu.assertNotNil(saved.DiabolicUI_Minimap_DB)

	local reloaded = Client.boot({ class = "MAGE", savedVariables = saved })
	assertClean(reloaded, "after the reload")
	lu.assertEquals(reloaded.Engine:GetConfig("ChatWindows").fadeChat, fade)
end

function TestSessionLogin:test_first_login_of_a_new_character()
	-- VARIABLES_LOADED after the client is already logged in: the engine
	-- initializes then and fakes the missed PLAYER_ENTERING_WORLD
	local client = Client.boot({ class = "PRIEST", login = false })
	client:FireEvent("ADDON_LOADED", "DiabolicUI")
	client.world.loggedIn = true
	client:FireEvent("PLAYER_LOGIN")
	client:FireEvent("VARIABLES_LOADED")
	client:FireEvent("PLAYER_ENTERING_WORLD")
	client:Tick(1)
	assertClean(client)
	lu.assertTrue(client.Engine:IsEnabled())
end

function TestSessionLogin:test_every_event_in_and_out_of_combat()
	local client = Client.boot({ class = "DRUID", world = crowdedWorld })
	for _, combat in ipairs({ false, true }) do
		if combat then
			client:EnterCombat()
		end
		local events = {}
		for event in pairs(client:RegisteredEvents()) do
			events[#events + 1] = event
		end
		table.sort(events)
		for _, event in ipairs(events) do
			if not STATE_EVENTS[event] then
				client:FireEvent(event, argsFor(event))
			end
		end
		client:Tick(2)
		assertClean(client, combat and "in combat" or "out of combat")
	end
	client:LeaveCombat()
	client:Tick(1)
	assertClean(client, "after combat")
end

function TestSessionLogin:test_every_frame_can_be_hovered_and_clicked()
	local client = Client.boot({ class = "WARLOCK", world = crowdedWorld })
	for _, widget in ipairs(client:WidgetsWithScript("OnEnter")) do
		if Client.Widgets.isVisible(widget) then
			client:Hover(widget)
			client:Leave()
		end
	end
	for _, script in ipairs({ "OnClick", "OnMouseDown", "OnMouseUp" }) do
		for _, widget in ipairs(client:WidgetsWithScript(script)) do
			if Client.Widgets.isVisible(widget) then
				for _, button in ipairs({ "LeftButton", "RightButton" }) do
					client:RunScript(widget, script, button)
				end
			end
		end
	end
	client:Tick(1)
	assertClean(client)
end

function TestSessionLogin:test_dropdowns_drop_values_addons_left_behind()
	-- engine/blizzard-taint.lua: a hidden menu button keeping a value an
	-- addon gave it would taint the next Blizzard menu using that button
	local client = Client.boot({ class = "MAGE" })
	local left, used = _G.DropDownList1Button7, _G.DropDownList1Button1
	left.value = "an addon's"
	left:Hide()
	used.value = "showing"
	used:Show()
	local dropDown = CreateFrame("Frame", "TestDropDown", _G.UIParent)
	dropDown.initialize = function() end
	_G.ToggleDropDownMenu(1, nil, dropDown)
	lu.assertNil(rawget(left, "value"))
	lu.assertEquals(used.value, "showing")
	assertClean(client)
end

function TestSessionLogin:test_a_newer_copy_of_the_dropdown_fix_takes_over()
	-- another addon carrying a newer version of the same fix: ours steps aside
	local client = Client.boot({ class = "MAGE" })
	_G.UIDROPDOWNMENU_VALUE_PATCH_VERSION = 3
	local left = _G.DropDownList1Button7
	left.value = "an addon's"
	left:Hide()
	local dropDown = CreateFrame("Frame", "TestDropDown", _G.UIParent)
	dropDown.initialize = function() end
	_G.ToggleDropDownMenu(1, nil, dropDown)
	lu.assertEquals(rawget(left, "value"), "an addon's")
	assertClean(client)
end

function TestSessionLogin:test_blizzard_ui_pieces_already_there_or_missing()
	-- the talent window loaded before us (by another addon) stops switching
	-- talent groups' action bars itself, like when it loads later
	local client = Client.boot({ class = "PRIEST", world = function()
		_G.LoadAddOn("Blizzard_TalentUI")
	end })
	lu.assertNil(_G.PlayerTalentFrame:IsEventRegistered("ACTIVE_TALENT_GROUP_CHANGED"))
	-- an options entry this client doesn't have is skipped
	client.Engine:GetHandler("BlizzardUI"):GetElement("Menu_Option"):Remove(true, "InterfaceOptionsNoSuchCheckButton")
	assertClean(client)
end

function TestSessionLogin:test_warnings_with_the_same_text_are_matched_once()
	-- in 3.3.5 several of the blacklisted messages read the same
	local client = Client.boot({ class = "SHAMAN", world = function()
		_G.SPELL_FAILED_TOTEMS = "Requires %s"
		_G.SPELL_FAILED_TOTEM_CATEGORY = "Requires %s"
	end })
	local count = 0
	for _, pattern in ipairs(client.Engine:GetDB("Warnings").whitelist.pattern) do
		if pattern == "^Requires .+" then
			count = count + 1
		end
	end
	lu.assertEquals(count, 1)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
