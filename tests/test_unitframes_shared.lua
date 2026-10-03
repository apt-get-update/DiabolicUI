-- Run from the addon root: lua5.1 tests/test_unitframes_shared.lua
--
-- Loads the *real* modules/unitframes/units/shared.lua (what the smaller
-- unit frames share) and checks its logic against scripted units:
--  - HealthColor: the status colors, class or plain colors for players,
--    the reaction of pets and mind controlled units, tapped and reaction
--    colors for NPCs
--  - PostUpdateHealth: colors set only when they change, the value dimmed
--    out of combat
--  - UpdateLayers: the border (and portrait border) lit on mouseover
--  - the enemy and group aura filters, branch by branch

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- Colors are stand-in names, so a test reads which one was picked.
local COLORS = {
	Status = { Dead = { "dead" }, Disconnected = { "offline" }, Tapped = { "tapped" } },
	Class = { MAGE = { "mage" }, UNKNOWN = { "unknown" } },
	Orb = { HEALTH = { { "health" } } },
	Reaction = { [1] = { "hated" }, [2] = { "hostile" }, [4] = { "neutral" }, [5] = { "friendly" } },
}

local TIME_LIMIT_LOW = 60

local units, state, Library

local function load()
	units, state = {}, { instance = false, combat = false }
	local function u(unit) return units[unit] or {} end
	_G.IsInInstance = function() return state.instance end
	_G.UnitAffectingCombat = function() return state.combat end
	_G.UnitCanAttack = function(_, unit) return u(unit).canAttack end
	_G.UnitClass = function(unit) return u(unit).class, u(unit).class end
	_G.UnitIsEnemy = function(unit) return u(unit).enemy end
	_G.UnitIsFriend = function(_, unit) return u(unit).friend end
	_G.UnitIsPlayer = function(unit) return u(unit).player end
	_G.UnitIsUnit = function(a, b) return a == b end
	_G.UnitPlayerControlled = function(unit) return u(unit).controlled end
	_G.UnitReaction = function(unit) return u(unit).reaction end

	local Engine = EngineMock.new()
	Engine.GetConstant = function(_, name) return ({ AURA_TIME_LIMIT_LOW = TIME_LIMIT_LOW })[name] end
	Engine.UnitIsTapDenied = function(unit) return u(unit).tapDenied end
	Engine:NewStaticConfig("Data: Colors", COLORS)
	assert(loadfile("modules/unitframes/units/shared.lua"))("DiabolicUI", Engine)
	Library = Engine:GetDB("Library: UnitFrames")
end

-- Health -------------------------------------------------------------------

TestHealthColor = {}

function TestHealthColor:setUp()
	load()
end

local function color(unit, isUnavailable, useClassColor, plainControlled)
	return (Library.HealthColor(unit, isUnavailable, useClassColor, plainControlled))
end

function TestHealthColor:test_dead_ghosts_and_offline_players()
	lu.assertEquals(color("party1", "dead"), "dead")
	lu.assertEquals(color("party1", "ghost"), "dead")
	lu.assertEquals(color("party1", "offline"), "offline")
end

function TestHealthColor:test_players()
	units.party1 = { player = true, class = "MAGE" }
	lu.assertEquals(color("party1", nil, true), "mage")
	lu.assertEquals(color("party1", nil, false), "health")
	units.party1.class = nil
	lu.assertEquals(color("party1", nil, true), "unknown")
end

function TestHealthColor:test_pets_vehicles_and_mind_controlled_units()
	units.pet = { controlled = true, friend = true }
	lu.assertEquals(color("pet"), "friendly")
	lu.assertEquals(color("pet", nil, false, true), "health")
	units.pet = { controlled = true, enemy = true }
	lu.assertEquals(color("pet"), "hated")
	units.pet = { controlled = true }
	lu.assertEquals(color("pet"), "neutral")
end

function TestHealthColor:test_npcs()
	units.target = { tapDenied = true, reaction = 2 }
	lu.assertEquals(color("target"), "tapped")
	units.target = { tapDenied = true, friend = true, reaction = 5 }
	lu.assertEquals(color("target"), "friendly") -- only enemies show as tapped
	units.target = { reaction = 2 }
	lu.assertEquals(color("target"), "hostile")
	units.target = {}
	lu.assertEquals(color("target"), "health")
end

function TestHealthColor:test_post_update_colors_on_change_and_dims_out_of_combat()
	units.target = { reaction = 2 }
	local sets = 0
	local health = {
		SetStatusBarColor = function(self, r) sets = sets + 1; self.color = r end,
		Value = { SetAlpha = function(self, alpha) self.alpha = alpha end },
		dimOutOfCombat = true,
	}
	Library.PostUpdateHealth(health, "target", 100, 100)
	Library.PostUpdateHealth(health, "target", 90, 100)
	lu.assertEquals({ health.color, sets }, { "hostile", 1 })
	lu.assertEquals(health.Value.alpha, .7)
	state.combat = true
	units.target.reaction = 4
	Library.PostUpdateHealth(health, "target", 90, 100)
	lu.assertEquals({ health.color, sets }, { "neutral", 2 })
	lu.assertEquals(health.Value.alpha, 1)
end

-- Mouseover ------------------------------------------------------------------

TestUpdateLayers = {}

local function texture()
	return { Show = function(self) self.shown = true end, Hide = function(self) self.shown = false end }
end

function TestUpdateLayers:test_the_borders_light_up_under_the_mouse()
	load()
	local frame = {
		BorderNormal = texture(), BorderNormalHighlight = texture(),
		PortraitBorderNormal = texture(), PortraitBorderHighlight = texture(), PortraitGlow = texture(),
		IsMouseOver = function(self) return self.over end,
	}
	frame.over = true
	Library.UpdateLayers(frame)
	lu.assertEquals({ frame.BorderNormal.shown, frame.BorderNormalHighlight.shown }, { false, true })
	lu.assertEquals({ frame.PortraitBorderNormal.shown, frame.PortraitBorderHighlight.shown, frame.PortraitGlow.shown }, { false, true, true })
	frame.over = false
	Library.UpdateLayers(frame)
	lu.assertEquals({ frame.BorderNormal.shown, frame.BorderNormalHighlight.shown }, { true, false })
	lu.assertEquals({ frame.PortraitBorderNormal.shown, frame.PortraitBorderHighlight.shown, frame.PortraitGlow.shown }, { true, false, false })

	-- without a portrait
	local plain = { BorderNormal = texture(), BorderNormalHighlight = texture(), IsMouseOver = function() return true end }
	Library.UpdateLayers(plain)
	lu.assertTrue(plain.BorderNormalHighlight.shown)
end

-- Aura filters -----------------------------------------------------------------

TestAuraFilters = {}

function TestAuraFilters:setUp()
	load()
	-- a hostile NPC (a boss), a hostile player (an arena enemy), a friendly
	-- and a mind controlled party member
	units.boss1 = { canAttack = true }
	units.arena1 = { canAttack = true, controlled = true, player = true }
	units.party1 = { friend = true, player = true, controlled = true }
	units.party2 = { canAttack = true, controlled = true, player = true }
end

-- Calls a filter for `unit` with an aura described by `aura`: caster,
-- duration, debuffType, stealable, spellId, boss (isBossDebuff) and mine
-- (isCastByPlayer).
local function filter(name, unit, aura)
	return Library[name]({ unit = unit }, "Aura", "", "", 1, aura.debuffType, aura.duration, nil,
		aura.caster, aura.stealable, aura.spellId, aura.boss, aura.mine)
end

function TestAuraFilters:test_enemy_buffs()
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", { boss = true }))
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", { stealable = true, caster = "boss1", duration = 600 }))
	-- yours and your vehicle's, while short
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", { mine = true, caster = "player", duration = 30 }))
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", { caster = "vehicle", duration = 30 }))
	-- the unit's own, while short
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", { caster = "boss1", duration = 30 }))
	-- no caster: world bosses outside instances spam these
	lu.assertNil(filter("EnemyBuffFilter", "boss1", {}))
	state.instance = true
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", {}))
	-- a hostile NPC's long ones from itself, not from others
	lu.assertTrue(filter("EnemyBuffFilter", "boss1", { caster = "boss1", duration = 0 }))
	lu.assertFalse(filter("EnemyBuffFilter", "boss1", { caster = "boss2", duration = 0 }))
	-- a hostile player: unknown origin yes, others' no
	lu.assertTrue(filter("EnemyBuffFilter", "arena1", {}))
	lu.assertFalse(filter("EnemyBuffFilter", "arena1", { caster = "arena2", spellId = 1, duration = 0 }))
	-- your own longer buffs
	lu.assertFalse(filter("EnemyBuffFilter", "arena1", { mine = true, caster = "player", duration = 600 }))
end

function TestAuraFilters:test_enemy_debuffs()
	lu.assertTrue(filter("EnemyDebuffFilter", "boss1", { boss = true }))
	lu.assertTrue(filter("EnemyDebuffFilter", "boss1", { mine = true, caster = "player" }))
	lu.assertTrue(filter("EnemyDebuffFilter", "boss1", { caster = "vehicle" }))
	lu.assertNil(filter("EnemyDebuffFilter", "boss1", {}))
	state.instance = true
	lu.assertTrue(filter("EnemyDebuffFilter", "boss1", {}))
	lu.assertTrue(filter("EnemyDebuffFilter", "boss1", { caster = "boss1" }))
	lu.assertFalse(filter("EnemyDebuffFilter", "boss1", { caster = "raid3" }))
	lu.assertFalse(filter("EnemyDebuffFilter", "arena1", { caster = "raid3", spellId = 1 }))
end

function TestAuraFilters:test_group_members()
	lu.assertTrue(filter("GroupBuffFilter", "party1", { mine = true, caster = "player" }))
	lu.assertTrue(filter("GroupBuffFilter", "party1", { caster = "vehicle" }))
	lu.assertFalse(filter("GroupBuffFilter", "party1", { caster = "party3" }))
	lu.assertTrue(filter("GroupDebuffFilter", "party1", { boss = true }))
	lu.assertTrue(filter("GroupDebuffFilter", "party1", { debuffType = "Magic", caster = "boss1" }))
	lu.assertTrue(filter("GroupDebuffFilter", "party1", { mine = true, caster = "player" }))
	lu.assertFalse(filter("GroupDebuffFilter", "party1", { caster = "boss1" }))

	-- mind controlled: an enemy for the time being
	lu.assertTrue(filter("GroupBuffFilter", "party2", { stealable = true }))
	lu.assertTrue(filter("GroupDebuffFilter", "party2", { boss = true }))
end

os.exit(lu.LuaUnit.run())
