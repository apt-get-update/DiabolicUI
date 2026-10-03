-- Run from the addon root: lua5.1 tests/test_session_objectives.lua
--
-- The objectives modules in the fake client: the world state indicators
-- (scores with their faction icons, timers counting down, tooltips), the
-- capture bars of battleground and world PvP objectives, the error and
-- quest messages, and the emotes at the players you kill.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean, tooltipLines = Session.assertClean, Session.tooltipLines

local client

local function boot(options)
	client = Client.boot(options)
	client:Tick(0.2)
end

local function setWorldStates(states)
	client.world.worldStates = states
	client:FireEvent("UPDATE_WORLD_STATES")
end

local function shown(widget)
	return widget:IsShown() == 1
end

local function visible(widget)
	return widget:IsVisible() == 1
end

-- The texcoords of a texture as left, right, top, bottom.
local function texCoords(texture)
	local left, top, _, bottom, right = texture:GetTexCoord()
	return { left, right, top, bottom }
end

-- World states -----------------------------------------------------------------

TestWorldState = {}

function TestWorldState:setUp()
	boot()
	self.module = client:GetModule("WorldState")
	self.config = client.Engine:GetDB("Objectives").zoneinfo.worldstate
end

function TestWorldState:tearDown()
	client = nil
	self.module, self.config = nil, nil
end

function TestWorldState:test_scores_show_with_our_faction_icons()
	setWorldStates({
		{ text = "Bases: 3  Resources: 1200/1600", icon = [[Interface\TargetingFrame\UI-PVP-Alliance]],
			tooltip = "Alliance score", dynamicIcon = [[Interface\WorldStateFrame\AllianceFlag]], state = 2 },
		{ text = "Bases: 2  Resources: 900/1600", icon = [[Interface\Icons\Something]],
			dynamicIcon = [[Interface\Icons\Else]], state = 3 },
		{ text = "Not shown", state = 0 },
		{ text = "Captured", icon = [[Interface\WorldStateFrame\NeutralTower]] },
	})
	local module, config = self.module, self.config
	lu.assertTrue(shown(module.frame))
	lu.assertEquals(module.numInfoUIs, 3)
	lu.assertEquals(module.numTimerUIs, 0)

	local alliance, other, tower = module:GetUI(1), module:GetUI(2), module:GetUI(3)
	lu.assertEquals(alliance.text:GetText(), "Bases: 3  Resources: 1200/1600")
	lu.assertEquals(alliance.icon:GetTexture(), config.texPath)
	lu.assertEquals(texCoords(alliance.icon), config.texCoords.alliance)
	lu.assertEquals({ alliance:GetHitRectInsets() }, config.texHitRects)
	lu.assertEquals(alliance.tooltip, "Alliance score")
	-- the flag carrier: our flag, shown while the state flashes
	lu.assertEquals(texCoords(alliance.dynamicIcon), config.texCoords.allianceflag)
	lu.assertTrue(shown(alliance.dynamicIcon))

	-- an icon we have no art for: none, but Blizzard's dynamic icon is kept
	lu.assertEquals(other.icon:GetTexture(), "")
	lu.assertEquals({ other:GetHitRectInsets() }, { 0, 0, 0, 0 })
	lu.assertEquals(other.dynamicIcon:GetTexture(), [[Interface\Icons\Else]])
	lu.assertTrue(shown(other.dynamicIcon))
	lu.assertNil(other.tooltip)

	-- no dynamic icon
	lu.assertEquals(texCoords(tower.icon), config.texCoords.neutraltower)
	lu.assertFalse(shown(tower.dynamicIcon))

	-- stacked top down
	lu.assertEquals({ alliance:GetPoint() }, { "TOPLEFT", module.frame, "TOPLEFT", 0, 0 })
	lu.assertEquals({ other:GetPoint() }, { "TOPLEFT", alliance, "BOTTOMLEFT", 0, -4 })
	lu.assertEquals({ tower:GetPoint() }, { "TOPLEFT", other, "BOTTOMLEFT", 0, -4 })
	assertClean(client)
end

function TestWorldState:test_a_dynamic_icon_hides_when_the_state_stops_flashing()
	local flag = { text = "Flag", icon = [[Interface\WorldStateFrame\HordeFlag]],
		dynamicIcon = [[Interface\WorldStateFrame\HordeFlag]], state = 2 }
	setWorldStates({ flag })
	lu.assertTrue(shown(self.module:GetUI(1).dynamicIcon))
	flag.state = 1
	setWorldStates({ flag })
	lu.assertFalse(shown(self.module:GetUI(1).dynamicIcon))
	assertClean(client)
end

function TestWorldState:test_timers_count_down_and_go_away()
	setWorldStates({
		{ text = "Horde: 3", icon = [[Interface\TargetingFrame\UI-PVP-Horde]] },
		{ text = "Next battle in 1:30", tooltip = "Wintergrasp" },
		{ text = "Reinforcements: 0:05" },
	})
	local module = self.module
	lu.assertEquals(module.numInfoUIs, 1)
	lu.assertEquals(module.numTimerUIs, 2)
	local score, battle, reinforcements = module:GetUI(1), module:GetUI(2), module:GetUI(3)
	lu.assertEquals(battle.uiType, "timer")
	lu.assertEquals(battle.tooltip, "Wintergrasp")
	-- timers come after the scores
	lu.assertEquals({ battle:GetPoint() }, { "TOPLEFT", score, "BOTTOMLEFT", 0, -4 })
	lu.assertEquals({ reinforcements:GetPoint() }, { "TOPLEFT", battle, "BOTTOMLEFT", 0, -4 })

	client:Tick(0.6)
	lu.assertEquals(battle.text:GetText(), "01:29")
	lu.assertEquals(reinforcements.text:GetText(), "00:04")

	-- the short one runs out: cleared, and the rest move up
	client:Tick(5)
	lu.assertFalse(shown(reinforcements))
	lu.assertNil(reinforcements.uiType)
	lu.assertTrue(shown(battle))
	lu.assertEquals(battle.text:GetText(), "01:24")

	-- all of them gone
	client:Tick(90)
	lu.assertFalse(shown(battle))
	assertClean(client)
end

function TestWorldState:test_a_lone_timer_goes_on_top()
	setWorldStates({ { text = "Time left: 10:00" } })
	local timer = self.module:GetUI(1)
	lu.assertEquals({ timer:GetPoint() }, { "TOPLEFT", self.module.frame, "TOPLEFT", 0, 0 })
	client:Tick(0.6)
	lu.assertEquals(timer.text:GetText(), "09:59")
	assertClean(client)
end

function TestWorldState:test_hovering_shows_the_tooltip()
	setWorldStates({
		{ text = "Alliance: 2", icon = [[Interface\WorldStateScore\AllianceIcon]], tooltip = "Bases held" },
		{ text = "Plain" },
	})
	local scored, plain = self.module:GetUI(1), self.module:GetUI(2)
	client:Hover(scored)
	lu.assertTrue(shown(_G.GameTooltip))
	lu.assertEquals(tooltipLines(_G.GameTooltip), { "Bases held" })
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	-- no tooltip, nothing shown
	client:Hover(plain)
	lu.assertFalse(shown(_G.GameTooltip))
	client:Leave()
	assertClean(client)
end

function TestWorldState:test_capture_points_and_hidden_states_are_left_to_others()
	setWorldStates({
		{ text = "Tower", state = 0 },
		{ text = "", extendedUI = "CAPTUREPOINT", extended1 = 50, extended2 = 20, extended3 = 1 },
		{ text = nil },
	})
	lu.assertEquals(self.module.numInfoUIs + self.module.numTimerUIs, 0)
	lu.assertFalse(shown(self.module.frame))
	assertClean(client)
end

function TestWorldState:test_leaving_the_battleground_clears_everything()
	setWorldStates({ { text = "Horde: 3", icon = [[Interface\WorldStateScore\HordeIcon]] }, { text = "0:30" } })
	lu.assertTrue(shown(self.module.frame))
	client.world.worldStates = {}
	client:FireEvent("PLAYER_ENTERING_WORLD")
	lu.assertFalse(shown(self.module.frame))
	lu.assertFalse(shown(self.module:GetUI(1)))
	lu.assertFalse(shown(self.module:GetUI(2)))
	-- the old timer doesn't come back to life
	client:Tick(1)
	lu.assertFalse(shown(self.module:GetUI(2)))
	assertClean(client)
end

function TestWorldState:test_a_target_hides_it_to_make_room_for_the_target_frame()
	setWorldStates({ { text = "Horde: 3" } })
	lu.assertTrue(visible(self.module.frame))
	client:SetUnit("target", Client.newUnit({ name = "Hogger" }))
	lu.assertFalse(visible(self.module.frame))
	client:SetUnit("target", nil)
	lu.assertTrue(visible(self.module.frame))
	assertClean(client)
end

-- Capture bars ------------------------------------------------------------------

TestCaptureBars = {}

function TestCaptureBars:setUp()
	boot()
	self.module = client:GetModule("CaptureBars")
	self.timers = client:GetModule("Blizzard: MirrorTimers")
end

function TestCaptureBars:tearDown()
	client = nil
	self.module, self.timers = nil, nil
end

local function capturePoint(value, neutral, id)
	return { text = "", extendedUI = "CAPTUREPOINT", extended1 = value, extended2 = neutral, extended3 = id }
end

function TestCaptureBars:test_a_capture_point_shows_its_bar()
	local config = self.module.config
	setWorldStates({ capturePoint(70, 20, 1), { text = "Score" } })
	local bar = self.module.captureBarsByID.BlizzardCaptureBar1
	lu.assertNotNil(bar)
	lu.assertTrue(shown(bar))
	lu.assertEquals(select(1, bar:GetPoint()), config.position[1])
	-- 70% to the Alliance: the spark sits left of the middle
	lu.assertAlmostEquals(select(4, bar.spark:GetPoint()), config.size[1] * (0.3 - 0.5), 1e-9)
	lu.assertAlmostEquals(bar.middle:GetWidth(), config.size[1] * 0.2, 1e-9)
	-- a new bar hasn't moved yet
	lu.assertFalse(shown(bar.leftIndicator))
	lu.assertFalse(shown(bar.rightIndicator))
	-- the mirror timers make room
	lu.assertTrue(self.timers.captureBarVisible)
	assertClean(client)
end

function TestCaptureBars:test_the_indicator_shows_which_way_it_moves()
	setWorldStates({ capturePoint(70, 20, 1) })
	local bar = self.module.captureBarsByID.BlizzardCaptureBar1
	setWorldStates({ capturePoint(60, 20, 1) }) -- toward the Horde
	lu.assertTrue(shown(bar.rightIndicator))
	lu.assertFalse(shown(bar.leftIndicator))
	setWorldStates({ capturePoint(65, 20, 1) }) -- back toward the Alliance
	lu.assertTrue(shown(bar.leftIndicator))
	lu.assertFalse(shown(bar.rightIndicator))
	setWorldStates({ capturePoint(100, 20, 1) }) -- all the way
	lu.assertFalse(shown(bar.leftIndicator))
	lu.assertFalse(shown(bar.rightIndicator))
	assertClean(client)
end

function TestCaptureBars:test_several_bars_stack_and_go_away()
	local config = self.module.config
	setWorldStates({ capturePoint(50, 10, 1), capturePoint(50, 10, "Tower") })
	local first, second = self.module.captureBarsByID.BlizzardCaptureBar1, self.module.captureBarsByID.Tower
	lu.assertTrue(shown(second))
	lu.assertEquals({ second:GetPoint() }, { "CENTER", first, "CENTER", 0, -config.padding })

	-- the first point is done: the second moves up
	setWorldStates({ capturePoint(50, 10, "Tower") })
	lu.assertFalse(shown(first))
	lu.assertEquals(select(1, second:GetPoint()), config.position[1])

	-- none left
	setWorldStates({})
	lu.assertFalse(shown(second))
	lu.assertFalse(self.timers.captureBarVisible)
	assertClean(client)
end

function TestCaptureBars:test_entering_the_world_hides_the_old_bars()
	setWorldStates({ capturePoint(50, 10, 1) })
	client.world.worldStates = {}
	client:FireEvent("PLAYER_ENTERING_WORLD")
	lu.assertFalse(shown(self.module.captureBarsByID.BlizzardCaptureBar1))
	assertClean(client)
end

-- Warnings -------------------------------------------------------------------------

TestWarnings = {}

function TestWarnings:setUp()
	boot({ world = function()
		_G.ERR_QUEST_ADD_KILL_SII = "%s slain: %d/%d"
		_G.ERR_LOOT_GONE = "Already looted (%d/%d)"
		_G.ERR_OUT_OF_POWER_DISPLAY = "Not enough %s"
	end })
	self.module = client:GetModule("Warnings")
	self.chat = {}
	local chat = self.chat
	_G.DEFAULT_CHAT_FRAME.AddMessage = function(_, text, r, g, b)
		chat[#chat + 1] = { text, r, g, b }
	end
end

function TestWarnings:tearDown()
	client = nil
	self.module, self.chat = nil, nil
end

function TestWarnings:test_whitelisted_errors_show_then_fade()
	local module, config = self.module, self.module.config
	client:FireEvent("UI_ERROR_MESSAGE", _G.ERR_OUT_OF_RANGE)
	client:Tick(0.1)
	lu.assertEquals(module.message:GetText(), _G.ERR_OUT_OF_RANGE)
	lu.assertEquals(module.message:GetAlpha(), 1)
	lu.assertAlmostEquals(module.message.shade:GetAlpha(), 2 / 3, 1e-9)
	lu.assertEquals(#self.chat, 0)

	-- shown, then fading
	client:Tick(config.time_to_show + config.time_to_fade / 2)
	local alpha = module.message:GetAlpha()
	lu.assertTrue(alpha > 0 and alpha < 1, "fading: " .. alpha)
	client:Tick(config.time_to_fade)
	lu.assertEquals(module.message:GetAlpha(), 0)
	lu.assertEquals(module.message:GetText(), "")

	-- whitelisted by pattern
	client:FireEvent("UI_ERROR_MESSAGE", "Not enough mana")
	client:Tick(0.1)
	lu.assertEquals(module.message:GetText(), "Not enough mana")
	lu.assertEquals(#self.chat, 0)
	assertClean(client)
end

function TestWarnings:test_the_same_message_right_away_is_ignored()
	local module = self.module
	client:FireEvent("UI_ERROR_MESSAGE", _G.ERR_OUT_OF_RANGE)
	client:Tick(2)
	client:FireEvent("UI_ERROR_MESSAGE", _G.ERR_OUT_OF_RANGE)
	client:Tick(0.1)
	-- not restarted: still counting from the first one
	lu.assertTrue(module.player.time_shown > 1.9)
	client:Tick(module.config.HZ)
	client:FireEvent("UI_ERROR_MESSAGE", _G.ERR_OUT_OF_RANGE)
	client:Tick(0.1)
	lu.assertEquals(module.message:GetAlpha(), 1)
	lu.assertTrue(module.player.time_shown < 0.2)
	assertClean(client)
end

function TestWarnings:test_quest_progress_shows_in_the_quest_line()
	local module, config = self.module, self.module.config
	client:FireEvent("UI_INFO_MESSAGE", "Kobold Vermin slain: 3/8")
	client:Tick(0.1)
	lu.assertEquals(module.message_quest:GetText(), "Kobold Vermin slain: 3/8")
	lu.assertEquals(module.message:GetText(), nil)
	client:FireEvent("UI_INFO_MESSAGE", _G.ERR_QUEST_LOG_FULL)
	client:Tick(0.1)
	lu.assertEquals(module.message_quest:GetText(), _G.ERR_QUEST_LOG_FULL)
	client:Tick(config.time_to_show + config.time_to_fade / 2)
	local alpha = module.message_quest:GetAlpha()
	lu.assertTrue(alpha > 0 and alpha < 1, "fading: " .. alpha)
	client:Tick(config.time_to_fade)
	lu.assertEquals(module.message_quest:GetText(), "")
	lu.assertEquals(#self.chat, 0)
	assertClean(client)
end

function TestWarnings:test_whitelisted_info_shows_in_the_quest_line()
	local module = self.module
	local whitelisted = next(module.config.whitelist.plain)
	client:FireEvent("UI_INFO_MESSAGE", whitelisted)
	client:Tick(0.1)
	lu.assertEquals(module.message_quest:GetText(), whitelisted)
	assertClean(client)
end

function TestWarnings:test_blacklisted_messages_are_dropped_and_the_rest_go_to_chat()
	local config = self.module.config
	client:FireEvent("UI_ERROR_MESSAGE", "Already looted (1/3)")
	lu.assertEquals(#self.chat, 0)
	client:FireEvent("UI_ERROR_MESSAGE", "Something odd happened")
	client:FireEvent("UI_INFO_MESSAGE", "Discovered: Goldshire")
	lu.assertEquals(self.chat, {
		{ "Something odd happened", unpack(config.color.error) },
		{ "Discovered: Goldshire", unpack(config.color.info) },
	})
	assertClean(client)
end

function TestWarnings:test_system_messages_keep_their_color()
	local module, config = self.module, self.module.config
	client:FireEvent("SYSMSG", "Your group has been disbanded.", 1, 1, 0)
	client:FireEvent("SYSMSG", "No color here")
	lu.assertEquals(self.chat, {
		{ "Your group has been disbanded.", 1, 1, 0 },
		{ "No color here", unpack(config.color.system) },
	})
	-- a whitelisted one goes to the warning line
	client:FireEvent("SYSMSG", _G.ERR_OUT_OF_RANGE, 1, 0.1, 0.1)
	client:Tick(0.1)
	lu.assertEquals(module.message:GetText(), _G.ERR_OUT_OF_RANGE)
	lu.assertEquals(#self.chat, 2)
	assertClean(client)
end

-- PvP emotes ----------------------------------------------------------------------

TestPvPEmotes = {}

local PLAYER_FLAGS = 0x548 -- hostile outsider, a player controlled player
local NPC_FLAGS = 0xa48 -- hostile outsider, an NPC

function TestPvPEmotes:setUp()
	boot()
	self.me = client.world.units.player.guid
end

function TestPvPEmotes:tearDown()
	client = nil
	self.me = nil
end

local function combatLog(subEvent, sourceGUID, destGUID, destName, destFlags, ...)
	client:FireEvent("COMBAT_LOG_EVENT_UNFILTERED", 1000, subEvent, sourceGUID, "Source", 0x511,
		destGUID, destName, destFlags, ...)
end

function TestPvPEmotes:test_hugs_the_first_victim_then_picks_random_emotes()
	combatLog("PARTY_KILL", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS)
	lu.assertEquals(client.emotes, { { "HUG", "Grumpy" } })
	combatLog("PARTY_KILL", self.me, "0x0100000000000003", "Sneaky", PLAYER_FLAGS)
	lu.assertEquals(#client.emotes, 2)
	lu.assertNotEquals(client.emotes[2][1], "HUG")
	lu.assertEquals(client.emotes[2][2], "Sneaky")
	assertClean(client)
end

function TestPvPEmotes:test_with_the_achievement_it_never_hugs()
	client.world.achievements[247] = { name = "Make Love, Not Warcraft", completed = true }
	combatLog("PARTY_KILL", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS)
	lu.assertEquals(#client.emotes, 1)
	lu.assertNotEquals(client.emotes[1][1], "HUG")
	assertClean(client)
end

function TestPvPEmotes:test_one_emote_per_kill()
	-- the killing blow reports its overkill, then the kill itself
	combatLog("SPELL_DAMAGE", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS, 133, "Fireball", 4, 900, 120)
	combatLog("PARTY_KILL", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS)
	lu.assertEquals(client.emotes, { { "HUG", "Grumpy" } })
	-- the same player killed again later
	client:Tick(3)
	combatLog("PARTY_KILL", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS)
	lu.assertEquals(#client.emotes, 2)
	assertClean(client)
end

function TestPvPEmotes:test_overkill_from_the_player_or_pet_counts()
	local pet = Client.newUnit({ name = "Wolf" })
	client:SetUnit("pet", pet)
	combatLog("SWING_DAMAGE", pet.guid, "0x0100000000000002", "Grumpy", PLAYER_FLAGS, 800, 50)
	lu.assertEquals(client.emotes, { { "HUG", "Grumpy" } })
	combatLog("SPELL_PERIODIC_DAMAGE", self.me, "0x0100000000000003", "Sneaky", PLAYER_FLAGS, 172, "Corruption", 32, 300, 1)
	lu.assertEquals(#client.emotes, 2)
	assertClean(client)
end

function TestPvPEmotes:test_no_emote_without_a_killing_blow_on_a_player()
	-- an NPC
	combatLog("PARTY_KILL", self.me, "0xF130000000000001", "Hogger", NPC_FLAGS)
	-- someone else's kill
	combatLog("PARTY_KILL", "0x0100000000000009", "0x0100000000000002", "Grumpy", PLAYER_FLAGS)
	-- a hit that didn't kill (no overkill is -1 in 3.3.5)
	combatLog("SPELL_DAMAGE", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS, 133, "Fireball", 4, 900, -1)
	combatLog("SWING_DAMAGE", "0x0100000000000009", "0x0100000000000002", "Grumpy", PLAYER_FLAGS, 800, 50)
	-- events without a destination
	combatLog("SPELL_AURA_APPLIED", self.me, "", nil, nil, 1, "Aura", 1, "BUFF")
	combatLog("SPELL_CAST_SUCCESS", self.me, "0x0100000000000002", "Grumpy", PLAYER_FLAGS, 133, "Fireball", 4)
	lu.assertEquals(client.emotes, {})
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
