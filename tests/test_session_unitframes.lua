-- Run from the addon root: lua5.1 tests/test_session_unitframes.lua
--
-- The unit frames in the fake client, driven by the game: the player's
-- orbs (health, every power type, the druid's mana in forms, auras and
-- weapon enchants, the vehicle), the target frame by classification, cast
-- bars, the target of target, focus, party (roles, status, portraits,
-- mind control), raid, boss and arena frames, the pet, and the test mode
-- previews.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean, stripColors = Session.assertClean, Session.stripColors

local client, module

local function boot(options)
	client = Client.boot(options)
	module = client:GetModule("UnitFrames")
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

local function frameOf(widgetName, ...)
	return module:GetWidget(widgetName):GetFrame(...)
end

local function npc(fields)
	fields = fields or {}
	local unit = Client.newUnit(fields)
	unit.isPlayer = fields.isPlayer or false
	unit.playerControlled = fields.playerControlled or false
	if fields.reaction == nil then unit.reaction = 2 end
	if fields.canAttack == nil then unit.canAttack = true end
	if fields.isFriend == nil then unit.isFriend = false end
	if fields.isEnemy == nil then unit.isEnemy = true end
	return unit
end

local function casting(seconds, fields)
	local now = client.world.time * 1000
	local cast = { name = "Frostbolt", startTime = now, endTime = now + seconds * 1000 }
	for key, value in pairs(fields or {}) do cast[key] = value end
	return cast
end

local function shownButtons(owner)
	local count = 0
	for i = 1, 40 do
		local button = owner[tostring(i)]
		if button and button:IsShown() then count = count + 1 end
	end
	return count
end

-- The player -----------------------------------------------------------------

TestPlayerOrbs = {}

function TestPlayerOrbs:tearDown()
	client, module = nil, nil
end

function TestPlayerOrbs:test_health_and_mana_follow_the_player()
	boot({ class = "MAGE" })
	local left, right = frameOf("Unit: Player")
	local player = client.world.units.player
	player.health, player.healthMax = 2500, 10000
	player.power, player.powerMax = 1000, 8000
	client:Tick(0.5)
	lu.assertEquals(left.Health:GetValue(), 2500)
	lu.assertEquals(right.Power:GetValue(), 1000)
	client:Hover(left)
	client:Leave()
	client:Hover(right)
	client:Leave()
	player.dead = true
	client:Tick(0.5)
	player.dead, player.ghost = false, true
	client:Tick(0.5)
	assertClean(client)
end

function TestPlayerOrbs:test_every_power_type()
	for _, case in ipairs({ { "WARRIOR", 1, 50, 100 }, { "ROGUE", 3, 70, 100 }, { "DEATHKNIGHT", 6, 40, 100 }, { "HUNTER", 0, 3000, 6000 } }) do
		boot({ class = case[1] })
		local player = client.world.units.player
		player.powerType, player.power, player.powerMax = case[2], case[3], case[4]
		client:FireEvent("UNIT_DISPLAYPOWER", "player")
		client:Tick(0.5)
		local _, right = frameOf("Unit: Player")
		lu.assertEquals(right.Power:GetValue(), case[3], case[1])
		assertClean(client, case[1])
	end
end

function TestPlayerOrbs:test_a_druid_in_cat_form_keeps_an_eye_on_mana()
	boot({ class = "DRUID" })
	local player = client.world.units.player
	player.powerType, player.power, player.powerMax = 3, 60, 100
	player.powers, player.powersMax = { [0] = 4000 }, { [0] = 9000 }
	client:FireEvent("UNIT_DISPLAYPOWER", "player")
	client:Tick(0.5)
	local _, right = frameOf("Unit: Player")
	lu.assertEquals(right.Power:GetValue(), 60)
	if right.Mana then
		lu.assertEquals(right.Mana:GetValue(), 4000)
	end
	assertClean(client)
end

function TestPlayerOrbs:test_buffs_debuffs_and_weapon_enchants()
	boot({ class = "SHAMAN", world = function(world)
		local now = world.time
		world.units.player.auras = {
			{ name = "Bloodlust", duration = 40, expires = now + 40, caster = "player", spellId = 2825 },
			{ name = "Blessing of Kings", duration = 3600, expires = now + 3000, caster = "party1", spellId = 20217 },
			{ name = "Ghost Wolf", duration = 0, expires = 0, caster = "player", spellId = 2645 },
			{ name = "Weakened Soul", harmful = true, debuffType = "Magic", duration = 15, expires = now + 15, spellId = 6788 },
			{ name = "Decomposing Aura", harmful = true, count = 3, duration = 0, expires = 0, spellId = 12 },
		}
		world.weaponEnchants = { true, 1800000, 0, true, 60000, 3 }
	end })
	local left, right = frameOf("Unit: Player")
	client:FireEvent("UNIT_AURA", "player")
	client:Tick(0.2)
	lu.assertTrue(shownButtons(left.Buffs) >= 3, "short buffs and both weapon enchants")
	lu.assertTrue(shownButtons(left.Debuffs) >= 2)
	lu.assertTrue(shownButtons(right.Buffs) >= 2, "long buffs by the minimap")

	-- hovering and right-clicking a buff cancels it; enchants just show their item
	for i = 1, 3 do
		local button = left.Buffs[tostring(i)]
		client:Hover(button)
		client:Leave()
		client:Click(button, "RightButton")
	end
	client:FireEvent("MODIFIER_STATE_CHANGED", "LSHIFT", 1)
	client:Hover(left.Debuffs["1"])
	client.world.modifiers.shift = true
	client:FireEvent("MODIFIER_STATE_CHANGED", "LSHIFT", 1)
	client:Leave()
	lu.assertEquals(client.world.units.player.cancelled, 1)

	-- timers run out
	client:Tick(20, 0.05)
	client:Tick(30, 0.5)
	client:FireEvent("UNIT_AURA", "player")
	assertClean(client)
end

function TestPlayerOrbs:test_the_player_in_a_vehicle()
	boot({ class = "PALADIN" })
	local player = client.world.units.player
	player.vehicle = Client.newUnit({ name = "Siege Engine", isPlayer = false, health = 50000, healthMax = 100000 })
	player.vehicle.auras = { { name = "Ram", duration = 10, expires = client.world.time + 10, caster = "vehicle" } }
	player.hasVehicleUI, player.inVehicle = true, true
	client.world.bonusBarOffset = 5
	client:FireEvent("UNIT_ENTERING_VEHICLE", "player")
	client:FireEvent("UNIT_ENTERED_VEHICLE", "player")
	client:FireEvent("UPDATE_BONUS_ACTIONBAR")
	client:Tick(0.5)
	local left = frameOf("Unit: Player")
	lu.assertEquals(left.unit, "pet", "the vehicle is the pet unit to the secure code")
	player.hasVehicleUI, player.inVehicle, player.vehicle = false, false, nil
	client.world.bonusBarOffset = 0
	client:FireEvent("UNIT_EXITING_VEHICLE", "player")
	client:FireEvent("UNIT_EXITED_VEHICLE", "player")
	client:FireEvent("UPDATE_BONUS_ACTIONBAR")
	client:Tick(0.5)
	lu.assertEquals(left.unit, "player")
	assertClean(client)
end

function TestPlayerOrbs:test_auras_move_with_the_bars_the_pet_bar_and_the_minimap()
	boot({ class = "HUNTER" })
	local widget = module:GetWidget("Unit: Player")
	for _, bars in ipairs({ 1, 2, 3 }) do
		widget:OnEvent("ENGINE_ACTIONBAR_VISIBLE_CHANGED", bars)
	end
	widget:OnEvent("ENGINE_ACTIONBAR_VEHICLE_CHANGED", true)
	widget:OnEvent("ENGINE_ACTIONBAR_VISIBLE_CHANGED", 2)
	widget:OnEvent("ENGINE_ACTIONBAR_VEHICLE_CHANGED", false)
	widget:OnEvent("ENGINE_ACTIONBAR_PET_CHANGED", true)
	widget:OnEvent("ENGINE_ACTIONBAR_PET_CHANGED", false)
	-- the minimap moves to the left half: the long buffs grow the other way
	_G.Minimap:ClearAllPoints()
	_G.Minimap:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 30, -30)
	client:Tick(1.1)
	local _, right = frameOf("Unit: Player")
	lu.assertEquals(right.Buffs.growthX, "RIGHT")
	assertClean(client)
end

function TestPlayerOrbs:test_death_knight_runes()
	boot({ class = "DEATHKNIGHT", world = function(world)
		world.runes = { { start = 999, duration = 10, ready = false, type = 1 }, { ready = true, type = 1 },
			{ start = 995, duration = 10, ready = false, type = 2 }, { ready = true, type = 2 },
			{ ready = true, type = 4 }, { ready = true, type = 3 } }
	end })
	client:FireEvent("RUNE_POWER_UPDATE", 1, false)
	client:FireEvent("RUNE_TYPE_UPDATE", 5)
	client:Tick(1)
	assertClean(client)
end

function TestPlayerOrbs:test_debuffs_worth_seeing_even_without_a_duration()
	boot({ class = "PRIEST" })
	local me = client.world.units.player
	me.auras = {
		{ name = "Resurrection Sickness", harmful = true, spellId = 15007 },
		{ name = "Something Lasting", harmful = true, spellId = 1 },
	}
	client:FireEvent("UNIT_AURA", "player")
	client:Tick(0.1)
	local debuffs = frameOf("Unit: Player").Debuffs
	lu.assertTrue(shown(debuffs["1"]))
	lu.assertTrue(not debuffs["2"] or not shown(debuffs["2"]))
	assertClean(client)
end

function TestPlayerOrbs:test_the_runes_move_up_for_the_ghouls_bar()
	boot({ class = "DEATHKNIGHT", world = function(world)
		world.units.pet = Client.newUnit({ name = "Ghoul", isPlayer = false })
	end })
	local left = frameOf("Unit: Player")
	local config = module:GetWidget("Unit: Player").config
	lu.assertNotNil(left.Runes)
	local _, _, _, _, petY = unpack(config.runes.positionPet)
	lu.assertEquals(select(5, left.Runes:GetPoint()), petY)
	client:SetUnit("pet", nil)
	client:Tick(0.5)
	local _, _, _, _, y = unpack(config.runes.position)
	lu.assertEquals(select(5, left.Runes:GetPoint()), y)
	assertClean(client)
end

function TestPlayerOrbs:test_a_reload_inside_a_vehicle()
	boot({ class = "PALADIN", login = false, world = function(world)
		world.units.player.hasVehicleUI, world.units.player.inVehicle = true, true
		world.units.player.vehicle = Client.newUnit({ name = "Siege Engine", isPlayer = false })
		world.bonusBarOffset = 5
	end })
	client:Login()
	client:Tick(0.5)
	local left = frameOf("Unit: Player")
	local config = module:GetWidget("Unit: Player").config
	lu.assertEquals({ left.Buffs:GetSize() }, config.buffs.size.vehicle)
	assertClean(client)
end

function TestPlayerOrbs:test_no_cast_bar_with_quartz()
	boot({ class = "MAGE", world = function(world)
		table.insert(world.addons, { name = "Quartz", title = "Quartz", enabled = true, loadable = true, loaded = true })
	end })
	local left = frameOf("Unit: Player")
	lu.assertNil(left.CastBar)
	-- moving out of the pet bar's way still works
	module:GetWidget("Unit: Player"):OnEvent("ENGINE_ACTIONBAR_PET_CHANGED", true)
	assertClean(client)
end

-- The target ------------------------------------------------------------------

TestTargetFrame = {}

function TestTargetFrame:setUp()
	boot({ class = "WARRIOR" })
	self.frame = frameOf("Unit: Target")
end

function TestTargetFrame:tearDown()
	client, module, self.frame = nil, nil, nil
end

function TestTargetFrame:test_every_classification()
	for _, fields in ipairs({
		{ classification = "normal" }, { classification = "elite" }, { classification = "rare" },
		{ classification = "rareelite" }, { classification = "worldboss", level = -1 }, { level = -1 },
		{ classification = "trivial", powerMax = 0, power = 0 },
	}) do
		client:SetUnit("target", npc(fields))
		client:Tick(0.2)
		lu.assertEquals(self.frame:IsShown(), 1)
		client:Hover(self.frame)
		client:Leave()
	end
	assertClean(client)
end

function TestTargetFrame:test_players_pets_and_their_states()
	local rogue = Client.newUnit({ class = "ROGUE", name = "Stabby" })
	for _, target in ipairs({
		rogue,
		Client.newUnit({ class = "PRIEST", connected = false }),
		Client.newUnit({ class = "MAGE", dead = true }),
		Client.newUnit({ class = "MAGE", ghost = true }),
		npc({ name = "Wolf", playerControlled = true }),
		npc({ name = "Taken", tapped = true, isFriend = false }),
		npc({ name = "Nobody", reaction = false }),
	}) do
		client:SetUnit("target", target)
		client:Tick(0.2)
	end
	client:SetUnit("target", nil)
	client:Tick(0.2)
	lu.assertNil(self.frame:IsShown())
	assertClean(client)
end

function TestTargetFrame:test_the_targets_auras()
	local now = client.world.time
	local target = npc({ name = "Target Dummy" })
	target.auras = {
		{ name = "Shield", duration = 10, expires = now + 10, caster = "target", stealable = true },
		{ name = "Enrage", duration = 5, expires = now + 5, caster = "target" },
		{ name = "Sunder", harmful = true, duration = 30, expires = now + 30, caster = "player", count = 5 },
		{ name = "Boss Curse", harmful = true, duration = 30, expires = now + 30, caster = "boss1" },
		{ name = "Other's Dot", harmful = true, duration = 30, expires = now + 30, caster = "raid5" },
	}
	client:SetUnit("target", target)
	client:FireEvent("UNIT_AURA", "target")
	client:Tick(0.2)
	lu.assertTrue(shownButtons(self.frame.Auras) >= 3)
	assertClean(client)
end

function TestTargetFrame:test_cast_bars()
	local target = npc({ name = "Caster" })
	client:SetUnit("target", target)
	local castBar = self.frame.CastBar
	target.casting = casting(3)
	client:FireEvent("UNIT_SPELLCAST_START", "target")
	client:Tick(0.5)
	lu.assertEquals(castBar:IsShown(), 1)
	target.casting.endTime = target.casting.endTime + 500
	client:FireEvent("UNIT_SPELLCAST_DELAYED", "target")
	client:Tick(0.5)
	target.casting = nil
	client:FireEvent("UNIT_SPELLCAST_INTERRUPTED", "target")
	client:Tick(1)

	target.casting = casting(1)
	client:FireEvent("UNIT_SPELLCAST_START", "target")
	target.casting = nil
	client:FireEvent("UNIT_SPELLCAST_FAILED", "target")
	target.casting = casting(1)
	client:FireEvent("UNIT_SPELLCAST_START", "target")
	client:Tick(1.5)
	target.casting = nil
	client:FireEvent("UNIT_SPELLCAST_STOP", "target")

	target.channeling = casting(3, { name = "Arcane Missiles" })
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "target")
	client:Tick(0.5)
	target.channeling.endTime = target.channeling.endTime - 500
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "target")
	client:Tick(0.5)
	target.channeling = nil
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_STOP", "target")
	client:Tick(1)

	-- a target that's already casting when targeted
	local busy = npc({ name = "Busy" })
	busy.casting = casting(2)
	client:SetUnit("target", busy)
	client:Tick(0.5)
	local channeler = npc({ name = "Channeler" })
	channeler.channeling = casting(2)
	client:SetUnit("target", channeler)
	client:Tick(3)
	assertClean(client)
end

-- Calls one of the target's aura filters with an aura described by `aura`:
-- caster, duration, stealable, boss (isBossDebuff) and mine (isCastByPlayer).
local function targetFilter(frame, name, aura)
	local auras = frame.Auras
	return auras[name](auras, "Aura", "", "", 1, nil, aura.duration, nil,
		aura.caster, aura.stealable, nil, aura.boss, aura.mine)
end

function TestTargetFrame:test_which_auras_the_target_shows()
	local frame = self.frame
	client:SetUnit("target", npc({ name = "Ogre" })) -- a hostile NPC
	lu.assertTrue(targetFilter(frame, "BuffFilter", { boss = true }))
	lu.assertTrue(targetFilter(frame, "BuffFilter", { stealable = true, caster = "target" }))
	lu.assertTrue(targetFilter(frame, "BuffFilter", { mine = true, caster = "player" }))
	lu.assertTrue(targetFilter(frame, "BuffFilter", { caster = "target", duration = 10 })) -- its own short ones
	lu.assertNil(targetFilter(frame, "BuffFilter", {})) -- nobody's, out in the world
	client.world.instance = { inInstance = 1, type = "party", name = "Utgarde Keep", difficulty = 1, maxPlayers = 5 }
	lu.assertTrue(targetFilter(frame, "BuffFilter", {}))
	lu.assertTrue(targetFilter(frame, "BuffFilter", { caster = "target", duration = 0 })) -- its own long ones
	lu.assertFalse(targetFilter(frame, "BuffFilter", { caster = "focus", duration = 0 }))

	lu.assertTrue(targetFilter(frame, "DebuffFilter", { boss = true }))
	lu.assertTrue(targetFilter(frame, "DebuffFilter", { caster = "vehicle" }))
	lu.assertTrue(targetFilter(frame, "DebuffFilter", { mine = true, caster = "player" }))
	lu.assertTrue(targetFilter(frame, "DebuffFilter", { caster = "target" }))
	lu.assertFalse(targetFilter(frame, "DebuffFilter", { caster = "focus" }))

	-- a friendly player: auras of unknown origin, not others'
	client:SetUnit("target", Client.newUnit({ name = "Friend" }))
	lu.assertTrue(targetFilter(frame, "BuffFilter", {}))
	lu.assertFalse(targetFilter(frame, "BuffFilter", { caster = "party1", duration = 0 }))
	lu.assertFalse(targetFilter(frame, "DebuffFilter", { caster = "party1" }))
	client.world.instance = { inInstance = nil, type = "none", name = "", difficulty = 1, maxPlayers = 0 }
	lu.assertNil(targetFilter(frame, "DebuffFilter", {}))
	assertClean(client)
end

function TestTargetFrame:test_aura_times_and_a_target_gone_from_under_the_mouse()
	local target = npc({ name = "Ogre" })
	local now = client.world.time
	target.auras = {
		{ name = "Thick Hide", duration = 7200, expires = now + 7000, caster = "target" },
		{ name = "Old Curse", duration = 86400 * 4, expires = now + 86400 * 3, caster = "target" },
	}
	client:SetUnit("target", target)
	client:Tick(0.1)
	local L = client.Engine:GetLocale()
	local auras = self.frame.Auras
	local texts = {}
	for i = 1, 2 do
		texts[auras[tostring(i)]:GetElement("Time"):GetText()] = true
	end
	lu.assertTrue(texts["2" .. L["h"]])
	lu.assertTrue(texts["3" .. L["d"]])

	-- the target went away: hovering or right-clicking its last auras does nothing
	local button = auras["1"]
	client:SetUnit("target", nil)
	client:RunScript(button, "OnEnter")
	lu.assertFalse(shown(_G.GameTooltip))
	client:RunScript(button, "OnClick", "RightButton")
	assertClean(client)
end

function TestTargetFrame:test_the_border_follows_the_power_bar()
	local target = npc({ name = "Caster" })
	target.powerType, target.power, target.powerMax = 0, 3000, 5000
	client:SetUnit("target", target)
	client:Tick(0.2)
	local frame = self.frame
	lu.assertEquals(frame.layers.border.BorderNormalPower:IsShown(), 1)
	-- out of power for good: the bar goes, and so does its border
	target.power, target.powerMax = 0, 0
	client:Tick(0.2)
	lu.assertEquals(frame.layers.border.BorderNormal:IsShown(), 1)
	lu.assertNil(frame.layers.border.BorderNormalPower:IsShown())
	assertClean(client)
end

function TestTargetFrame:test_targeting_sounds()
	client:SetUnit("target", npc({ reaction = 4, isEnemy = false, isFriend = false }))
	lu.assertEquals(client.sounds[#client.sounds], "igCreatureNeutralSelect")
	client:SetUnit("target", Client.newUnit({ name = "Friend" }))
	lu.assertEquals(client.sounds[#client.sounds], "igCharacterNPCSelect")
	client:SetUnit("target", npc())
	lu.assertEquals(client.sounds[#client.sounds], "igCreatureAggroSelect")
	client:SetUnit("target", nil)
	lu.assertEquals(client.sounds[#client.sounds], "INTERFACESOUND_LOSTTARGETUNIT")
	assertClean(client)
end

function TestTargetFrame:test_the_classification_line()
	local frame = self.frame
	local function line(fields)
		client:SetUnit("target", npc(fields))
		return frame.Classification:GetText()
	end
	lu.assertEquals(line({ level = 70, creatureType = "Beast" }), "Level 70 Beast")
	lu.assertEquals(line({ level = 70, creatureType = "Not specified" }), "Level 70")
	lu.assertEquals(line({ level = 72, classification = "elite", creatureType = "Giant" }), "Level 72 Elite Giant")
	lu.assertEquals(line({ level = 72, classification = "elite", creatureType = "Not specified" }), "Level 72 Elite")
	lu.assertEquals(line({ level = -1, classification = "worldboss", creatureType = "Dragonkin" }), "Elite Dragonkin")
	lu.assertEquals(line({ level = -1, creatureType = "Undead" }), "Undead")
	lu.assertEquals(line({ level = 70, dead = true }), "Level 70 (Dead)")
	lu.assertEquals(line({ level = -1, dead = true }), _G.DEAD)
	assertClean(client)
end

function TestTargetFrame:test_threat_and_the_target_of_target()
	local target = npc({ name = "Boss", threat = 3 })
	target.target = "player"
	client:SetUnit("target", target)
	client:FireEvent("UNIT_THREAT_SITUATION_UPDATE", "target")
	client:FireEvent("UNIT_THREAT_SITUATION_UPDATE", "player")
	client:Tick(1)
	local tot = frameOf("Unit: ToT")
	lu.assertEquals(tot:IsShown(), 1)
	client:Hover(tot)
	client:Leave()
	target.threat = nil
	target.target = Client.newUnit({ name = "Tank", class = "WARRIOR" })
	client:FireEvent("UNIT_THREAT_SITUATION_UPDATE", "player")
	client:Tick(1)
	assertClean(client)
end

function TestTargetFrame:test_the_right_click_menus()
	client:SetUnit("target", npc())
	client:RunScript(self.frame, "OnClick", "RightButton")
	self.frame:menu()
	client:SetUnit("focus", Client.newUnit())
	local focus = frameOf("Unit: Focus")
	focus:menu()
	client.world.units.party1 = Client.newUnit()
	client:FireEvent("PARTY_MEMBERS_CHANGED")
	frameOf("Unit: Party", 1):menu()
	frameOf("Unit: ToT"):menu()
	assertClean(client)
end

-- Cast bars ---------------------------------------------------------------------

TestCastBars = {}

function TestCastBars:setUp()
	boot({ class = "MAGE" })
	local left, right = frameOf("Unit: Player")
	self.bar = (left.CastBar or right.CastBar)
	self.me = client.world.units.player
end

function TestCastBars:tearDown()
	client, module, self.bar, self.me = nil, nil, nil, nil
end

function TestCastBars:test_the_players_cast_and_its_latency()
	local bar, me = self.bar, self.me
	client.world.latency = 100
	me.casting = casting(2, { castID = 7, text = "Frostbolt" })
	client:FireEvent("UNIT_SPELLCAST_START", "player")
	lu.assertTrue(shown(bar))
	lu.assertEquals(bar.Name:GetText(), "Frostbolt")
	-- 0.1s of a 2s cast: the last twentieth of the bar
	lu.assertTrue(shown(bar.SafeZone))
	lu.assertAlmostEquals(bar.SafeZone:GetWidth(), bar:GetWidth() / 20, 1e-6)
	client:Tick(0.5)
	lu.assertEquals(bar.Value:GetText(), "1.5")

	-- pushed back
	me.casting.startTime = me.casting.startTime + 300
	me.casting.endTime = me.casting.endTime + 300
	client:FireEvent("UNIT_SPELLCAST_DELAYED", "player")
	client:Tick(0.1)
	lu.assertStrContains(bar.Value:GetText(), "|cffff0000 -")

	-- a lag longer than the cast: all of it
	client.world.latency = 5000
	client:Tick(0.1)
	lu.assertAlmostEquals(bar.SafeZone:GetWidth(), bar:GetWidth(), 1e-6)

	-- no latency known: no safe zone
	client.world.latency = 0
	client:Tick(0.1)
	lu.assertFalse(shown(bar.SafeZone))

	-- the stop of an older cast doesn't end this one
	client:FireEvent("UNIT_SPELLCAST_STOP", "player", "Frostbolt", "", 6)
	lu.assertTrue(shown(bar))
	client:FireEvent("UNIT_SPELLCAST_INTERRUPTED", "player", "Frostbolt", "", 7)
	lu.assertFalse(shown(bar))
	assertClean(client)
end

function TestCastBars:test_trade_skills_long_casts_and_long_names()
	local bar, me = self.bar, self.me
	local L = client.Engine:GetLocale()
	me.casting = casting(75, { tradeSkill = 1, text = "Transmute: Titanium" })
	client:FireEvent("UNIT_SPELLCAST_START", "player")
	client:Tick(0.1)
	lu.assertEquals(bar.Value:GetText(), "1" .. L["m"] .. " 14" .. L["s"])
	client:FireEvent("UNIT_SPELLCAST_FAILED", "player", "Transmute: Titanium", "", 1)
	lu.assertFalse(shown(bar))

	-- 32 letters at most, however many bytes each takes
	local name = ("\195\156\230\188\162\240\157\132\158a"):rep(10) -- Ü, 漢, 𝄞 and a: 40 letters
	me.casting = casting(20, { text = name })
	client:FireEvent("UNIT_SPELLCAST_START", "player")
	lu.assertEquals(bar.Name:GetText(), ("\195\156\230\188\162\240\157\132\158a"):rep(8) .. "...")
	client:Tick(0.1)
	lu.assertEquals(bar.Value:GetText(), "19" .. L["s"])
	-- done by itself
	client:Tick(20)
	lu.assertFalse(shown(bar))

	-- nothing being cast after all
	me.casting = nil
	client:FireEvent("UNIT_SPELLCAST_START", "player")
	lu.assertFalse(shown(bar))
	assertClean(client)
end

function TestCastBars:test_channels()
	local bar, me = self.bar, self.me
	client.world.latency = 100
	me.channeling = casting(3, { name = "Arcane Missiles" })
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
	lu.assertTrue(shown(bar))
	lu.assertEquals(bar.Name:GetText(), "Arcane Missiles")
	lu.assertFalse(shown(bar.SafeZone)) -- the bar's right end is a channel's start
	client:Tick(0.5)
	lu.assertEquals(bar.Value:GetText(), "2.5")

	-- cut short
	me.channeling.endTime = me.channeling.endTime - 1000
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
	client:Tick(0.1)
	lu.assertStrContains(bar.Value:GetText(), "|cffff0000-1.0")
	me.channeling = nil
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
	lu.assertFalse(shown(bar))
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player") -- late: nothing to update
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
	lu.assertFalse(shown(bar))

	-- done by itself
	me.channeling = casting(1, { name = "Drain Soul" })
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
	client:Tick(1.2)
	lu.assertFalse(shown(bar))
	assertClean(client)
end

function TestCastBars:test_a_target_that_goes_away_mid_cast()
	local target = npc({ name = "Caster" })
	target.casting = casting(3)
	client:SetUnit("target", target)
	local bar = frameOf("Unit: Target").CastBar
	lu.assertTrue(shown(bar))
	client:SetUnit("target", nil)
	client:Tick(0.1)
	lu.assertFalse(shown(bar))

	-- a new target that isn't casting
	client:SetUnit("target", npc({ name = "Idle" }))
	lu.assertFalse(shown(bar))
	assertClean(client)
end

-- Focus, party, raid ------------------------------------------------------------

TestGroupFrames = {}

function TestGroupFrames:tearDown()
	client, module = nil, nil
end

function TestGroupFrames:test_focus()
	boot({ class = "PRIEST" })
	local focus = frameOf("Unit: Focus")
	client:SetUnit("focus", Client.newUnit({ class = "DRUID", health = 3000, healthMax = 9000 }))
	client:Tick(0.5)
	lu.assertEquals(focus:IsShown(), 1)
	client:Hover(focus)
	client:Leave()
	-- it's after you
	client.world.units.focus.threat = 3
	client:FireEvent("UNIT_THREAT_SITUATION_UPDATE", "focus")
	lu.assertEquals(focus.Threat.Border:IsShown(), 1)
	client.world.units.focus.threat = nil
	client:FireEvent("UNIT_THREAT_SITUATION_UPDATE", "focus")
	lu.assertNil(focus.Threat.Border:IsShown())
	client:SetUnit("focus", nil)
	client:Tick(0.2)
	lu.assertNil(focus:IsShown())
	assertClean(client)
end

local function party(world)
	world.units.party1 = Client.newUnit({ class = "WARRIOR", role = "TANK", leader = true })
	world.units.party2 = Client.newUnit({ class = "PRIEST", role = "HEALER" })
	world.units.party3 = Client.newUnit({ class = "MAGE", role = "DAMAGER", connected = false })
	world.units.party4 = Client.newUnit({ class = "ROGUE", role = "DAMAGER", dead = true })
end

function TestGroupFrames:test_a_party_of_four()
	boot({ class = "PALADIN", world = party })
	client:FireEvent("PARTY_MEMBERS_CHANGED")
	client:Tick(0.5)
	for i = 1, 4 do
		local frame = frameOf("Unit: Party", i)
		lu.assertEquals(frame:IsShown(), 1, "party" .. i)
		client:Hover(frame)
		client:Leave()
	end
	local now = client.world.time
	local healer = client.world.units.party2
	healer.auras = {
		{ name = "Renew", duration = 15, expires = now + 15, caster = "player" },
		{ name = "Someone's Buff", duration = 15, expires = now + 15, caster = "party1" },
		{ name = "Poison", harmful = true, debuffType = "Poison", duration = 10, expires = now + 10 },
		{ name = "Weakened Soul", harmful = true, duration = 15, expires = now + 15, caster = "player" },
		{ name = "Boss Hit", harmful = true, duration = 5, expires = now + 5, caster = "boss1" },
		{ name = "Nothing", harmful = true, duration = 5, expires = now + 5, caster = "party1" },
	}
	client:FireEvent("UNIT_AURA", "party2")
	client:Tick(0.5)

	-- a member goes into a vehicle, another is mind controlled
	client.world.units.party1.hasVehicleUI = true
	client.world.units.party2.isFriend, client.world.units.party2.canAttack = false, true
	client:FireEvent("UNIT_AURA", "party2")
	client:FireEvent("PARTY_MEMBERS_CHANGED")
	client:FireEvent("UNIT_ENTERED_VEHICLE", "party1")
	client:Tick(0.5)

	-- joining a raid hides the party frames
	client.world.units.raid1 = Client.newUnit()
	client:FireEvent("RAID_ROSTER_UPDATE")
	client:Tick(0.2)
	lu.assertNil(frameOf("Unit: Party", 1):IsVisible())
	assertClean(client)
end

function TestGroupFrames:test_party_portraits_and_no_class_colors()
	boot({ class = "PALADIN", world = party, savedVariables = {
		DiabolicUI_DB = { UnitFrames = { profiles = { global = { showPortrait = true, showClassColors = false } } } },
	} })
	client:FireEvent("PARTY_MEMBERS_CHANGED")
	client:Tick(0.5)
	local frame = frameOf("Unit: Party", 1)
	lu.assertNotNil(frame.Portrait)
	client:Hover(frame)
	lu.assertEquals(frame.PortraitGlow:IsShown(), 1)
	client:Leave()
	lu.assertNil(frame.PortraitGlow:IsShown())
	-- out of range: the 2D portrait
	client.world.units.party1.visible = false
	client:FireEvent("UNIT_PORTRAIT_UPDATE", "party1")
	client:FireEvent("PARTY_MEMBER_ENABLE", "party1")
	client:Tick(1)
	-- the focus frame has one too
	client:SetUnit("focus", Client.newUnit({ class = "SHAMAN" }))
	client:Tick(0.5)
	assertClean(client)
end

-- The role a party frame shows, read from its icon's crop.
local function roleOf(i)
	local icon = frameOf("Unit: Party", i).Role
	if icon:IsShown() ~= 1 then
		return nil
	end
	local left, top = icon:GetTexCoord()
	return (top > .5 and "DAMAGER") or (left > .5 and "HEALER") or "TANK"
end

function TestGroupFrames:test_roles_assigned_or_guessed_from_talents()
	boot({ class = "PALADIN", world = function(world)
		world.units.party1 = Client.newUnit({ class = "WARRIOR", role = "TANK" }) -- through the Dungeon Finder
		world.units.party2 = Client.newUnit({ class = "PRIEST" })
		world.units.party3 = Client.newUnit({ class = "MAGE" })
		world.inspectTalents = { { "Discipline", "", 51 }, { "Holy", "", 20 }, { "Shadow", "", 0 } }
	end })
	client:FireEvent("PARTY_MEMBERS_CHANGED")
	client:Tick(0.3)
	lu.assertEquals(roleOf(1), "TANK")

	-- the others are inspected one at a time, and their role guessed from
	-- their talents
	lu.assertEquals(client.world.inspecting, "party2")
	client.world.units.party3.isPlayer = false -- out of reach by its turn
	client:FireEvent("INSPECT_TALENT_READY")
	lu.assertEquals(roleOf(2), "HEALER") -- most points in Discipline
	client.world.inspecting = nil
	client:Tick(1.5)
	lu.assertNil(client.world.inspecting) -- skipped
	lu.assertNil(roleOf(3))

	-- back in reach: asked again, and again once an answer never came
	client.world.units.party3.isPlayer = true
	client:Tick(3.5)
	lu.assertEquals(client.world.inspecting, "party3")
	client.world.inspecting = nil
	client:Tick(6)
	lu.assertEquals(client.world.inspecting, "party3")
	client:FireEvent("INSPECT_TALENT_READY")
	lu.assertEquals(roleOf(3), "DAMAGER")

	-- out of a group: no roles
	client:SetUnit("party1", nil)
	client:SetUnit("party2", nil)
	client:SetUnit("party3", nil)
	client:FireEvent("PARTY_MEMBERS_CHANGED")
	assertClean(client)
end

function TestGroupFrames:test_a_raid_of_forty_and_what_each_class_can_dispel()
	for _, class in ipairs({ "PRIEST", "PALADIN", "DRUID", "SHAMAN", "MAGE", "WARRIOR" }) do
		boot({ class = class, world = function(world)
			for i = 1, 40 do
				local member = Client.newUnit({ class = ({ "WARRIOR", "PRIEST", "MAGE", "DRUID" })[i % 4 + 1] })
				member.subgroup = math.floor((i - 1) / 5) + 1
				local now = world.time
				member.auras = {
					{ name = "Fortitude", duration = 600, expires = now + 600, caster = "raid2" }, -- no buffs on raid frames
					{ name = "Magic", harmful = true, debuffType = "Magic", duration = 10, expires = now + 10 },
					{ name = "Curse", harmful = true, debuffType = "Curse", duration = 10, expires = now + 10 },
					{ name = "Poison", harmful = true, debuffType = "Poison", duration = 10, expires = now + 10 },
					{ name = "Disease", harmful = true, debuffType = "Disease", duration = 10, expires = now + 10 },
					{ name = "Boss", harmful = true, duration = 10, expires = now + 10, caster = "boss1" },
				}
				world.units["raid" .. i] = member
			end
			world.spells[51886] = { name = "Cleanse Spirit" }
		end })
		client:FireEvent("RAID_ROSTER_UPDATE")
		for i = 1, 40 do
			client:FireEvent("UNIT_AURA", "raid" .. i)
		end
		client:Tick(0.5)
		local frame = frameOf("Unit: Raid", 1)
		lu.assertEquals(frame:IsShown(), 1, class)
		client:Hover(frame)
		client:Leave()
		assertClean(client, class)
	end
end

-- Enemies, the pet, test mode ------------------------------------------------------

TestOtherFrames = {}

function TestOtherFrames:tearDown()
	client, module = nil, nil
end

function TestOtherFrames:test_boss_frames()
	boot({ class = "WARRIOR" })
	local now = client.world.time
	for i = 1, 4 do
		local boss = npc({ name = "Boss" .. i, classification = "worldboss", level = -1 })
		boss.auras = {
			{ name = "Enrage", duration = 10, expires = now + 10, caster = "boss" .. i },
			{ name = "Frenzy", duration = 600, expires = now + 600, caster = "boss" .. i },
			{ name = "Magic Shield", duration = 10, expires = now + 10, stealable = true },
			{ name = "My Dot", harmful = true, duration = 10, expires = now + 10, caster = "player" },
			{ name = "Vehicle Dot", harmful = true, duration = 10, expires = now + 10, caster = "vehicle" },
			{ name = "Its Own", harmful = true, duration = 10, expires = now + 10, caster = "boss" .. i },
			{ name = "Unknown", harmful = true, duration = 10, expires = now + 10 },
		}
		client.world.units["boss" .. i] = boss
	end
	client.world.instance = { inInstance = 1, type = "raid", name = "ICC", difficulty = 1, maxPlayers = 25 }
	client:FireEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	for i = 1, 4 do
		client:FireEvent("UNIT_AURA", "boss" .. i)
	end
	client:Tick(0.5)
	for i = 1, 4 do
		local frame = frameOf("Unit: Boss", i)
		lu.assertEquals(frame:IsShown(), 1, "boss" .. i)
		client:Hover(frame)
		client:Leave()
	end
	assertClean(client)
end

function TestOtherFrames:test_arena_opponents()
	boot({ class = "ROGUE" })
	local now = client.world.time
	for i = 1, 5 do
		local enemy = Client.newUnit({ class = "MAGE", canAttack = true, isEnemy = true, isFriend = false, reaction = 2, pvp = true })
		enemy.auras = {
			{ name = "Ice Barrier", duration = 60, expires = now + 60, caster = "arena" .. i, spellId = 43039 },
			{ name = "Fort", duration = 3600, expires = now + 3600, caster = "arena2" },
			{ name = "Poison", harmful = true, duration = 12, expires = now + 12, caster = "player" },
			{ name = "Other", harmful = true, duration = 12, expires = now + 12, caster = "arena3" },
		}
		client:SetUnit("arena" .. i, enemy)
		client:FireEvent("UNIT_AURA", "arena" .. i)
	end
	client:Tick(0.5)
	lu.assertEquals(frameOf("Unit: Arena", 5):IsShown(), 1)
	assertClean(client)
end

function TestOtherFrames:test_the_pet()
	boot({ class = "HUNTER" })
	local pet = Client.newUnit({ name = "Wolf", isPlayer = false, powerType = 2, power = 50, powerMax = 100 })
	client:SetUnit("pet", pet)
	client:Tick(0.5)
	local frame = frameOf("Unit: Pet")
	lu.assertEquals(frame:IsShown(), 1)
	client:Hover(frame)
	client:Leave()
	client:SetUnit("pet", nil)
	client:Tick(0.2)
	lu.assertNil(frame:IsShown())
	assertClean(client)
end

function TestOtherFrames:test_test_mode_previews()
	boot({ class = "MAGE" })
	module:SetPartyMockShown(true)
	module:SetRaidMockShown(true)
	client:Tick(0.2)
	lu.assertEquals(module.partyContainer:IsShown(), 1)
	lu.assertEquals(#module.raidFrames, 40)
	module:SetPartyMockShown(false)
	module:SetRaidMockShown(false)
	module:SetPartyMockShown(true) -- made once, shown again
	lu.assertNil(module.raidContainer:IsShown())
	-- the previews follow the class color option
	client.Engine:GetConfig("UnitFrames").showClassColors = false
	boot({ class = "MAGE", savedVariables = {
		DiabolicUI_DB = { UnitFrames = { profiles = { global = { showClassColors = false, showPortrait = true } } } },
	} })
	module:SetPartyMockShown(true)
	module:SetPartyMockShown(false)
	client.world.mounted = true -- the portraits keep their whole-model camera
	module:SetPartyMockShown(true)
	module:SetRaidMockShown(true)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
