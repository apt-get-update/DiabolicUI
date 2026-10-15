-- Run from the addon root: lua5.1 tests/test_session_nameplates.lua
--
-- modules/nameplates/nameplates.lua in the fake client, against 3.3.5's
-- own nameplates (WorldFrame children, see Client:AddNamePlate): finding
-- them, reading the unit from their regions (name, level, elite/boss/raid
-- icons, the health bar's reaction or class color, the threat glow), the
-- target's plate standing out, fading in and out, the target's or focus'
-- castbar on its plate, and your auras on the plates (auras.lua).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")

local function assertClean(client)
	local problems = client:Problems()
	if problems ~= "" then
		lu.fail(problems)
	end
end

local HOSTILE = { 1, 0, 0 }
local FRIENDLY_NPC = { 0, 1, 0 }
local NEUTRAL = { 1, 1, 0 }
local FRIENDLY_PLAYER = { 0, 0, 1 }
local TAPPED = { 0.53, 0.53, 0.53 }

-- Our plate for a Blizzard one (the addon keeps them in allPlates).
local function ours(client, blizzardPlate)
	return client:GetModule("NamePlates").allPlates[blizzardPlate.frame]
end

local function stripColors(text)
	return (text or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
end

TestNamePlates = {}

function TestNamePlates:setUp()
	self.client = Client.boot({ class = "MAGE" })
	self.client:Tick(0.1)
end

-- LuaUnit pretty-prints the test object between tests: don't let it walk
-- the whole client.
function TestNamePlates:tearDown()
	self.client = nil
end

function TestNamePlates:test_a_hostile_npc_gets_a_plate_that_fades_in()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Hogger", level = 11, health = 400, healthMax = 800, color = HOSTILE })
	client:Tick(0.1)
	local plate = ours(client, blizzard)
	lu.assertNotNil(plate, "the plate was found")
	lu.assertEquals(plate.Health.Value:GetText(), "Hogger")
	lu.assertEquals(stripColors(plate.Level:GetText()), "11")
	lu.assertEquals(plate.Health:GetValue(), 400)
	lu.assertEquals(select(2, plate.Health:GetMinMaxValues()), 800)
	lu.assertFalse(blizzard.health:IsShown() == 1, "Blizzard's own bar is hidden")
	client:Tick(2)
	lu.assertAlmostEquals(plate:GetAlpha(), 0.7, 0.01) -- ALPHA_FULL: no target
	assertClean(client)
end

function TestNamePlates:test_elite_rare_and_boss_levels()
	local client = self.client
	local elite = client:AddNamePlate({ name = "Elite", level = 80, elite = true, color = HOSTILE })
	local rare = client:AddNamePlate({ name = "Rare", level = 80, rare = true, color = NEUTRAL })
	local friendlyElite = client:AddNamePlate({ name = "Guard", level = 80, elite = true, color = FRIENDLY_NPC })
	local boss = client:AddNamePlate({ name = "Boss", boss = true, color = HOSTILE })
	client:Tick(0.1)
	lu.assertEquals(stripColors(ours(client, elite).Level:GetText()), "80+")
	lu.assertEquals(stripColors(ours(client, rare).Level:GetText()), "80+") -- a rare elite (the dragon texture)
	lu.assertEquals(stripColors(ours(client, friendlyElite).Level:GetText()), "80+")
	lu.assertEquals(ours(client, boss).Level:GetText(), "")
	lu.assertEquals(ours(client, boss).BossIcon:IsShown(), 1)
	assertClean(client)
end

function TestNamePlates:test_level_colors_follow_the_difficulty()
	local client = self.client
	for _, level in ipairs({ 90, 83, 80, 72, 10 }) do
		client:AddNamePlate({ name = "L" .. level, level = level, color = HOSTILE })
	end
	client:Tick(0.1)
	local colors = {}
	for _, blizzard in ipairs(client.namePlates) do
		local text = ours(client, blizzard).Level:GetText()
		colors[text:match("^|c(%x+)")] = true
	end
	local count = 0
	for _ in pairs(colors) do count = count + 1 end
	lu.assertEquals(count, 5, "five difficulty colors")
	assertClean(client)
end

function TestNamePlates:test_every_kind_of_unit_reads_right()
	local client = self.client
	local kinds = {
		hostile = HOSTILE, friendlyNpc = FRIENDLY_NPC, neutral = NEUTRAL, friendlyPlayer = FRIENDLY_PLAYER,
		tapped = TAPPED, enemyPlayer = { 0.5, 0.2, 0.9 },
	}
	local plates = {}
	for name, color in pairs(kinds) do
		plates[name] = client:AddNamePlate({ name = name, level = 80, color = color })
	end
	local c = _G.RAID_CLASS_COLORS.PALADIN
	plates.paladin = client:AddNamePlate({ name = "paladin", level = 80, color = { c.r, c.g, c.b } })
	client:Tick(0.2)
	assertClean(client)
	local info = function(name) return ours(client, plates[name]).info end
	lu.assertTrue(info("hostile").isFriendly == false and info("hostile").isPlayer == false)
	lu.assertTrue(info("friendlyNpc").isFriendly)
	lu.assertTrue(info("neutral").isNeutral)
	lu.assertTrue(info("friendlyPlayer").isPlayer and info("friendlyPlayer").isFriendly)
	lu.assertTrue(info("tapped").isTapped)
	lu.assertEquals(info("paladin").isClass, "PALADIN")
	lu.assertFalse(info("enemyPlayer").isFriendly)
end

function TestNamePlates:test_the_target_stands_out_and_others_dim()
	local client = self.client
	local target = client:AddNamePlate({ name = "Target", level = 80, color = HOSTILE })
	local other = client:AddNamePlate({ name = "Other", level = 80, color = HOSTILE })
	local player = client:AddNamePlate({ name = "Player", level = 80, color = FRIENDLY_PLAYER })
	local friend = client:AddNamePlate({ name = "Friend", level = 80, color = FRIENDLY_NPC })
	client:Tick(1)
	target:Update({ target = true })
	client:SetUnit("target", Client.newUnit({ name = "Target", isPlayer = false }))
	client:Tick(3)
	lu.assertEquals(ours(client, target):GetAlpha(), 1)
	lu.assertEquals(ours(client, target):GetFrameLevel(), 126)
	-- its border highlighted, the others' not
	lu.assertEquals(ours(client, target).Health.BorderHighlight:IsShown(), 1)
	lu.assertNil(ours(client, target).Health.BorderNormal:IsShown())
	lu.assertNil(ours(client, other).Health.BorderHighlight:IsShown())
	lu.assertEquals(ours(client, other).Health.BorderNormal:IsShown(), 1)
	lu.assertAlmostEquals(ours(client, other):GetAlpha(), 0.7, 0.01)
	lu.assertAlmostEquals(ours(client, player):GetAlpha(), 0.35, 0.01)
	lu.assertAlmostEquals(ours(client, friend):GetAlpha(), 0.01, 0.01)

	-- the target leaves: everyone back to normal
	target:Update({ target = false })
	client:SetUnit("target", nil)
	client:Tick(3)
	lu.assertAlmostEquals(ours(client, target):GetAlpha(), 0.7, 0.01)
	lu.assertAlmostEquals(ours(client, player):GetAlpha(), 0.7, 0.01)
	assertClean(client)
end

function TestNamePlates:test_threat_glow_and_raid_icons()
	local client = self.client
	local plates = {}
	for status = 0, 3 do
		plates[status] = client:AddNamePlate({ name = "Threat" .. status, level = 80, color = HOSTILE, threat = status })
	end
	client:Tick(0.2)
	client:FireEvent("UNIT_THREAT_SITUATION_UPDATE", "player")
	local C = client.Engine:GetDB("Data: Colors")
	for status = 1, 3 do
		local r, g, b = ours(client, plates[status]).Health.Glow:GetVertexColor()
		lu.assertAlmostEquals(r, C.Threat[status][1], 0.01)
		lu.assertAlmostEquals(g, C.Threat[status][2], 0.01)
		lu.assertEquals(ours(client, plates[status]).Health.Glow:IsShown(), 1)
	end
	lu.assertNil(ours(client, plates[0]).Health.Glow:IsShown()) -- no threat, no glow

	plates[1]:Update({ raidIcon = { 0, 0.25, 0, 0.25 } })
	client:FireEvent("RAID_TARGET_UPDATE")
	lu.assertEquals(ours(client, plates[1]).RaidIcon:IsShown(), 1)
	plates[1]:Update({ raidIcon = false })
	client:FireEvent("RAID_TARGET_UPDATE")
	lu.assertNil(ours(client, plates[1]).RaidIcon:IsShown())
	assertClean(client)
end

function TestNamePlates:test_plates_fade_out_when_hidden_or_dead_and_come_back()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Wolf", level = 70, color = HOSTILE })
	client:Tick(2)
	local plate = ours(client, blizzard)
	lu.assertEquals(plate:IsShown(), 1)

	blizzard:Update({ hidden = true })
	client:Tick(1)
	lu.assertNil(plate:IsShown(), "hidden with its unit")

	blizzard:Update({ hidden = false, health = 0 })
	client:Tick(1)
	lu.assertEquals(plate.targetAlpha, 0, "dead units fade out")
	lu.assertNil(plate:IsShown())

	-- the client reuses the plate for another unit
	blizzard:Update({ hidden = true })
	blizzard:Update({ hidden = false, name = "Bear", health = 50 })
	client:Tick(2)
	lu.assertTrue(plate:GetAlpha() > 0)
	lu.assertEquals(plate.Health.Value:GetText(), "Bear")
	assertClean(client)
end

function TestNamePlates:test_plates_fade_out_gradually()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Slow", level = 80, color = HOSTILE })
	client:Tick(2)
	local plate = ours(client, blizzard)
	blizzard:Update({ health = 0 })
	client:Tick(0.034, 0.034) -- one update: 0.034s of a 0.05s fade
	local alpha = plate:GetAlpha()
	lu.assertAlmostEquals(alpha, 0.7 - 0.034 / 0.05, 0.001)
	client:Tick(0.034, 0.034)
	lu.assertEquals(plate:GetAlpha(), 0)
	lu.assertNil(plate:IsShown())

	-- fading in takes 3/4 of a second, whatever the framerate
	blizzard:Update({ hidden = true })
	blizzard:Update({ hidden = false, health = 50 })
	client:Tick(0.375, 0.005)
	lu.assertAlmostEquals(plate:GetAlpha(), 0.5, 0.05)
	assertClean(client)
end

function TestNamePlates:test_a_zone_change_updates_hidden_plates_too()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Gone", level = 80, color = HOSTILE })
	client:Tick(1)
	blizzard:Update({ hidden = true })
	client:Tick(1)
	client:FireEvent("ZONE_CHANGED_NEW_AREA")
	lu.assertEquals(ours(client, blizzard).targetAlpha, 0)
	assertClean(client)
end

function TestNamePlates:test_frame_levels_wrap_around_after_many_plates()
	local client = self.client
	for i = 1, 60 do
		client:AddNamePlate({ name = "Crowd" .. i, level = 80, color = HOSTILE })
	end
	client:Tick(0.2)
	-- levels 21, 23 ... 125: the 54th plate starts over
	lu.assertEquals(ours(client, client.namePlates[53]).frameLevel, 125)
	lu.assertEquals(ours(client, client.namePlates[54]).frameLevel, 21)
	assertClean(client)
end

function TestNamePlates:test_a_target_from_another_realm()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Stranger", level = 80, color = FRIENDLY_PLAYER, target = true })
	client:Tick(0.5)
	client:SetUnit("target", Client.newUnit({ name = "Stranger", realm = "Icecrown" }))
	client:Tick(1)
	lu.assertEquals(ours(client, blizzard):GetAlpha(), 1)
	assertClean(client)
end

function TestNamePlates:test_unit_and_world_changes_update_every_plate()
	local client = self.client
	client:AddNamePlate({ name = "A", level = 79, color = HOSTILE })
	client:AddNamePlate({ name = "B", level = 81, color = FRIENDLY_NPC })
	client:Tick(0.2)
	client:FireEvent("UNIT_LEVEL", "target")
	client:FireEvent("UNIT_FACTION", "target")
	client:FireEvent("ZONE_CHANGED_NEW_AREA")
	client:FireEvent("PLAYER_LEVEL_UP", 81)
	client.world.units.player.level = 82
	client:FireEvent("PLAYER_LEVEL_UP")
	client:Tick(0.2)
	assertClean(client)
end

function TestNamePlates:test_scale_changes_rescale_every_plate()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Scaled", level = 80, color = HOSTILE })
	client:Tick(0.2)
	local plate = ours(client, blizzard)
	local UICenter = client.Engine:GetFrame()
	UICenter:SetScale(0.5)
	client:FireEvent("UI_SCALE_CHANGED")
	lu.assertAlmostEquals(plate:GetScale(), UICenter:GetEffectiveScale(), 0.001)
	UICenter:SetScale(0.8)
	client:FireEvent("DISPLAY_SIZE_CHANGED")
	lu.assertAlmostEquals(plate:GetScale(), UICenter:GetEffectiveScale(), 0.001)
	assertClean(client)
end

function TestNamePlates:test_the_plate_follows_its_blizzard_plate()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Mover", level = 80, color = HOSTILE })
	client:Tick(0.2)
	local plate = ours(client, blizzard)
	-- the sizer spans WorldFrame's corner to the Blizzard plate's top: its
	-- size changes when the plate moves
	for _, widget in ipairs(client:WidgetsWithScript("OnSizeChanged")) do
		if widget.plate == plate then
			client:RunScript(widget, "OnSizeChanged", 640, 360)
		end
	end
	local point, relativeTo, _, x, y = plate:GetPoint()
	lu.assertEquals({ point, relativeTo, x, y }, { "TOP", _G.WorldFrame, 640, 360 })
	assertClean(client)
end

-- Castbars ---------------------------------------------------------------

local function casting(client, name, spell, seconds, fields)
	local now = client.world.time * 1000
	local cast = { name = spell, startTime = now, endTime = now + seconds * 1000, texture = "Interface\\Icons\\Spell" }
	for key, value in pairs(fields or {}) do
		cast[key] = value
	end
	return cast
end

function TestNamePlates:test_the_targets_cast_shows_on_its_plate()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Caster", level = 80, color = HOSTILE, target = true })
	local unit = Client.newUnit({ name = "Caster", isPlayer = false })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local cast = ours(client, blizzard).Cast

	unit.casting = casting(client, "Caster", "Frostbolt", 3)
	client:FireEvent("UNIT_SPELLCAST_START", "target")
	lu.assertEquals(cast:IsShown(), 1)
	lu.assertEquals(cast.Name:GetText(), "Frostbolt")
	client:Tick(1)
	lu.assertAlmostEquals(cast:GetValue(), 1, 0.15)

	unit.casting.endTime = unit.casting.endTime + 1000
	client:FireEvent("UNIT_SPELLCAST_DELAYED", "target")
	client:Tick(0.5)
	lu.assertStrContains(cast.Value:GetText(), "|cffff0000")

	unit.casting = nil
	client:FireEvent("UNIT_SPELLCAST_STOP", "target")
	lu.assertNil(cast:IsShown())

	-- a cast that runs out on its own
	unit.casting = casting(client, "Caster", "Short", 0.5)
	client:FireEvent("UNIT_SPELLCAST_START", "target")
	client:Tick(1)
	lu.assertNil(cast:IsShown())

	for _, event in ipairs({ "UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_INTERRUPTED" }) do
		unit.casting = casting(client, "Caster", "Fireball", 3)
		client:FireEvent("UNIT_SPELLCAST_START", "target")
		unit.casting = nil
		client:FireEvent(event, "target")
		lu.assertNil(cast:IsShown(), event)
	end

	-- the start event without a cast behind it
	client:FireEvent("UNIT_SPELLCAST_START", "target")
	lu.assertNil(cast:IsShown())
	assertClean(client)
end

function TestNamePlates:test_channels_count_down()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Channeler", level = 80, color = HOSTILE, target = true })
	local unit = Client.newUnit({ name = "Channeler", isPlayer = false })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local cast = ours(client, blizzard).Cast

	unit.channeling = casting(client, "Channeler", "Arcane Missiles", 5)
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "target")
	lu.assertEquals(cast:IsShown(), 1)
	client:Tick(1)
	lu.assertAlmostEquals(cast:GetValue(), 4, 0.15)
	unit.channeling.endTime = unit.channeling.endTime - 1000
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "target")
	client:Tick(0.5)
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_STOP", "target")
	lu.assertNil(cast:IsShown())

	-- runs out on its own
	unit.channeling = casting(client, "Channeler", "Drain Life", 0.5)
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "target")
	client:Tick(1)
	lu.assertNil(cast:IsShown())

	-- without a channel behind the event
	unit.channeling = nil
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "target")
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "target")
	lu.assertNil(cast:IsShown())
	assertClean(client)
end

function TestNamePlates:test_long_and_trade_skill_casts_and_names()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Crafter", level = 80, color = HOSTILE, target = true })
	local unit = Client.newUnit({ name = "Crafter", isPlayer = false })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local cast = ours(client, blizzard).Cast
	local long = string.rep("Ä", 40) -- longer than the 32 characters shown
	for _, seconds in ipairs({ 2 * 86400, 2 * 3600, 150, 30 }) do
		unit.casting = casting(client, "Crafter", long, seconds, { tradeSkill = 1 })
		client:FireEvent("UNIT_SPELLCAST_START", "target")
		client:Tick(0.1)
		lu.assertNotEquals(cast.Value:GetText(), "")
	end
	lu.assertEquals(cast.Name:GetText(), string.rep("Ä", 32) .. "...")

	-- names are cut at 32 characters, whatever their byte length
	for _, name in ipairs({ string.rep("a", 40), string.rep("€", 40), string.rep("\240\157\132\158", 40), string.rep("Ä", 20) }) do
		unit.casting = casting(client, "Crafter", name, 2)
		client:FireEvent("UNIT_SPELLCAST_START", "target")
		local shown = cast.Name:GetText():gsub("%.%.%.$", "")
		lu.assertTrue(#shown <= 32 * 4 and #shown > 0)
	end
	lu.assertEquals(cast.Name:GetText(), string.rep("Ä", 20), "32 characters or less: whole")

	-- the unit goes away mid-cast
	client:SetUnit("target", nil)
	client:Tick(0.1)
	lu.assertNil(cast:IsShown())
	assertClean(client)
end

function TestNamePlates:test_a_new_target_already_casting_shows_its_cast()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Busy", level = 80, color = HOSTILE, target = true })
	client:Tick(0.5)
	local unit = Client.newUnit({ name = "Busy", isPlayer = false })
	unit.casting = casting(client, "Busy", "Shadow Bolt", 3)
	client:SetUnit("target", unit)
	lu.assertEquals(ours(client, blizzard).Cast:IsShown(), 1)

	local channeler = Client.newUnit({ name = "Busy", isPlayer = false })
	channeler.channeling = casting(client, "Busy", "Mind Flay", 3)
	client:SetUnit("target", channeler)
	lu.assertEquals(ours(client, blizzard).Cast:IsShown(), 1)
	assertClean(client)
end

function TestNamePlates:test_casts_of_units_without_a_plate_are_ignored()
	local client = self.client
	client:SetUnit("focus", Client.newUnit({ name = "Nowhere" }))
	client:FireEvent("UNIT_SPELLCAST_START", "focus")
	client:FireEvent("UNIT_SPELLCAST_START", "party1") -- not a unit plates show casts for
	client:FireEvent("UNIT_SPELLCAST_START", "mouseover") -- nobody there
	assertClean(client)
end

-- Your auras ----------------------------------------------------------------------

local function hostile(name, auras)
	return Client.newUnit({ name = name, isPlayer = false, isFriend = false, isEnemy = true, canAttack = true, auras = auras or {} })
end

-- one of yours (or someone else's: caster) for `seconds`
local function debuff(client, spellId, seconds, caster)
	return { name = "Spell" .. spellId, spellId = spellId, icon = "Interface\\Icons\\Spell" .. spellId, harmful = true,
		caster = caster or "player", duration = seconds, expires = seconds and (client.world.time + seconds) or 0 }
end

-- the icons shown on a plate, in order
local function shownAuras(plate)
	local icons = {}
	for _, button in ipairs(plate.Auras) do
		if button:IsShown() then
			icons[#icons + 1] = button.Icon:GetTexture()
		end
	end
	return icons
end

function TestNamePlates:test_your_debuffs_on_the_targets_plate()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE, target = true })
	local other = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE })
	local unit = hostile("Wolf", { debuff(client, 2, 30), debuff(client, 1, 12), debuff(client, 3, 30, "party1") })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local plate = ours(client, blizzard)
	-- yours only, the shortest first, with the time left
	lu.assertEquals(shownAuras(plate), { "Interface\\Icons\\Spell1", "Interface\\Icons\\Spell2" })
	lu.assertEquals(plate.Auras[1].Time:GetText(), "11")
	lu.assertEquals(shownAuras(ours(client, other)), {})
	-- one more
	table.insert(unit.auras, debuff(client, 4, 5))
	client:FireEvent("UNIT_AURA", "target")
	lu.assertEquals(shownAuras(plate)[1], "Interface\\Icons\\Spell4")
	-- run out: gone
	client:Tick(5)
	lu.assertEquals(#shownAuras(plate), 2)
	assertClean(client)
end

function TestNamePlates:test_the_plate_keeps_them_once_the_unit_isnt_the_target()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE, target = true })
	client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE })
	local unit = hostile("Wolf", { debuff(client, 1, 30) })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local plate = ours(client, blizzard)
	blizzard:Update({ target = false })
	client:SetUnit("target", nil)
	client:Tick(0.5)
	lu.assertEquals(#shownAuras(plate), 1)
	-- the combat log: yours added and removed on it
	local log = function(event, spellId)
		client:FireEvent("COMBAT_LOG_EVENT_UNFILTERED", 0, event, client.world.units.player.guid, "Me", 0, unit.guid, "Wolf", 0, spellId, "Spell" .. spellId, 1)
	end
	log("SPELL_AURA_APPLIED", 7)
	lu.assertEquals(shownAuras(plate), { "Interface\\Icons\\Spell1", "Interface\\Icons\\Spell7" })
	log("SPELL_AURA_REMOVED", 1)
	lu.assertEquals(shownAuras(plate), { "Interface\\Icons\\Spell7" })
	-- someone else's: nothing
	client:FireEvent("COMBAT_LOG_EVENT_UNFILTERED", 0, "SPELL_AURA_APPLIED", "0xOTHER", "Other", 0, unit.guid, "Wolf", 0, 8, "Spell8", 1)
	lu.assertEquals(#shownAuras(plate), 1)
	-- it dies
	client:FireEvent("COMBAT_LOG_EVENT_UNFILTERED", 0, "UNIT_DIED", nil, nil, 0, unit.guid, "Wolf", 0)
	lu.assertEquals(shownAuras(plate), {})
	assertClean(client)
end

function TestNamePlates:test_the_mouseovers_plate_and_a_unique_name()
	local client = self.client
	local wolf = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE })
	local other = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE })
	local bear = client:AddNamePlate({ name = "Bear", level = 80, color = HOSTILE })
	client:Tick(0.5)
	-- the mouseover: Blizzard's highlight tells its plate
	wolf:Update({ mouseover = true })
	client:SetUnit("mouseover", hostile("Wolf", { debuff(client, 1, 30) }))
	client:FireEvent("UPDATE_MOUSEOVER_UNIT")
	lu.assertEquals(#shownAuras(ours(client, wolf)), 1)
	lu.assertEquals(#shownAuras(ours(client, other)), 0)
	-- the focus: the only plate with its name
	client:SetUnit("focus", hostile("Bear", { debuff(client, 2, 30) }))
	lu.assertEquals(#shownAuras(ours(client, bear)), 1)
	-- a plate hidden, then shown for another unit: none of the old ones
	bear:Update({ hidden = true })
	bear:Update({ hidden = false })
	client:Tick(0.5)
	lu.assertEquals(#shownAuras(ours(client, bear)), 0)
	assertClean(client)
end

function TestNamePlates:test_long_auras_read_in_days_hours_minutes_and_a_refresh_restarts_one()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE, target = true })
	local unit = hostile("Wolf", { debuff(client, 1, 2 * 86400), debuff(client, 2, 3 * 3600), debuff(client, 3, 5 * 60), debuff(client, 4, 30) })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local plate = ours(client, blizzard)
	local times = {}
	for i = 1, 4 do
		times[i] = plate.Auras[i].Time:GetText()
	end
	lu.assertEquals(times, { "29", "4m", "2h", "1d" })
	-- cast again (the combat log only): its time starts over
	client:Tick(20)
	lu.assertStrMatches(plate.Auras[1].Time:GetText(), "9%.%d") -- tenths under 10 seconds
	client:FireEvent("COMBAT_LOG_EVENT_UNFILTERED", 0, "SPELL_AURA_REFRESH", client.world.units.player.guid, "Me", 0, unit.guid, "Wolf", 0, 4, "Spell4", 1)
	client:Tick(0.5)
	lu.assertEquals(plate.Auras[1].Time:GetText(), "29")
	assertClean(client)
end

function TestNamePlates:test_what_ran_out_while_the_plate_was_hidden_is_gone_when_it_shows()
	local client = self.client
	local blizzard = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE, target = true })
	local unit = hostile("Wolf", { debuff(client, 1, 5), debuff(client, 2, 60) })
	client:SetUnit("target", unit)
	client:Tick(0.5)
	local plate = ours(client, blizzard)
	lu.assertEquals(#shownAuras(plate), 2)
	blizzard:Update({ hidden = true })
	client:Tick(10)
	table.remove(unit.auras, 1) -- run out on the unit too
	blizzard:Update({ hidden = false })
	client:Tick(0.5)
	lu.assertEquals(shownAuras(plate), { "Interface\\Icons\\Spell2" })
	assertClean(client)
end

function TestNamePlates:test_a_name_shared_by_two_plates_tells_neither_and_a_wrong_guess_is_undone()
	local client = self.client
	local first = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE })
	local second = client:AddNamePlate({ name = "Wolf", level = 80, color = HOSTILE })
	client:Tick(0.5)
	-- two Wolves: the focus' auras go on neither
	local wolf = hostile("Wolf", { debuff(client, 1, 30) })
	client:SetUnit("focus", wolf)
	lu.assertEquals(#shownAuras(ours(client, first)), 0)
	lu.assertEquals(#shownAuras(ours(client, second)), 0)
	-- one Wolf left: taken for the focus by its name
	second:Update({ hidden = true })
	client:Tick(0.5)
	client:FireEvent("PLAYER_FOCUS_CHANGED")
	lu.assertEquals(#shownAuras(ours(client, first)), 1)
	-- the focus was the other Wolf: targeted, its plate takes the auras back
	second:Update({ hidden = false, target = true })
	client:SetUnit("target", wolf)
	client:Tick(0.5)
	lu.assertEquals(#shownAuras(ours(client, first)), 0)
	lu.assertEquals(#shownAuras(ours(client, second)), 1)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
