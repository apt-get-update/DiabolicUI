-- Run from the addon root: lua5.1 tests/test_unitframes_health_power.lua
--
-- Loads the *real* modules/unitframes/elements/health.lua and power.lua,
-- the two elements every unit frame has, and exercises them against
-- scripted unit state:
--  - health: bar values, the value text, and the dead, ghost and offline
--    states
--  - power: bar values and colors (by power type, dead, disconnected), the
--    druid's extra mana bar, and Enable reporting success (without it the
--    frame never refreshes the element when its unit changes, like when
--    entering a vehicle), including on a frame with only a mana bar
--  - both: an every-frame poll ("FREQUENT") that finds nothing changed skips
--    the work, but still refreshes fully twice a second
-- Same RegisterElement capture as test_unitframes_elements.lua.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local COLORS = {
	Power = { MANA = { 0, 0, 1 }, RAGE = { 1, 0, 0 }, ENERGY = { 1, 1, 0 }, UNUSED = { .5, .5, .5 } },
	Orb = { MANA = { { 0, 0, .1, 1, "bar" }, { 0, 0, .2, .9, "moon" }, { 0, 0, .3, .5, "smoke" }, { 0, 0, 0, 1, "shade" } } },
	Status = { Dead = { .3, .3, .3 }, Disconnected = { .2, .2, .2 }, Tapped = { .4, .4, .4 } },
}

local unit -- scripted state of the frame's unit

local function resetUnit()
	unit = {
		health = 800, healthMax = 1000,
		isPlayer = true, connected = true, dead = false, ghost = false,
		powerType = "MANA", powerID = 0,
		power = { [0] = 300, [1] = 50 }, powerMax = { [0] = 600, [1] = 100 },
		tapped = false,
	}
end
resetUnit()

_G.UnitHealth = function() return unit.health end
_G.UnitHealthMax = function() return unit.healthMax end
_G.UnitIsPlayer = function() return unit.isPlayer end
_G.UnitIsConnected = function() return unit.connected end
_G.UnitIsDeadOrGhost = function() return unit.dead or unit.ghost end
_G.UnitIsGhost = function() return unit.ghost end
_G.UnitIsDead = function() return unit.dead end
_G.UnitPowerType = function() return unit.powerID, unit.powerType end
_G.UnitPower = function(_, id) return unit.power[id] end
_G.UnitPowerMax = function(_, id) return unit.powerMax[id] end
_G.UnitClass = function() return "Druid", "DRUID" end
_G.SPELL_POWER_MANA = 0
_G.DEAD = "Dead"
_G.PLAYER_OFFLINE = "Offline"

local function loadElement(path)
	local Engine = EngineMock.new()
	Engine:NewStaticConfig("Data: Colors", COLORS)
	Engine.UnitIsTapDenied = function() return unit.tapped end
	local Handler = Engine:NewHandler("UnitFrame")
	local captured
	Handler.RegisterElement = function(self, name, Enable, Update)
		captured = { Enable = Enable, Update = Update }
	end
	assert(loadfile(path))("DiabolicUI", Engine)
	return captured
end

local function newText(flags)
	local text = {
		SetText = function(self, value) self.text = value end,
		SetFormattedText = function(self, format, ...) self.text = string.format(format, ...) end,
	}
	for key, value in pairs(flags or {}) do
		text[key] = value
	end
	return text
end

local function newBar(valueFlags)
	return {
		shown = true,
		GetObjectType = function() return "StatusBar" end,
		SetMinMaxValues = function(self, min, max) self.min, self.max = min, max end,
		SetValue = function(self, value) self.value = value; self.sets = (self.sets or 0) + 1 end,
		SetStatusBarColor = function(self, r, g, b) self.color = { r, g, b } end,
		IsShown = function(self) return self.shown end,
		Show = function(self) self.shown = true end,
		Hide = function(self) self.shown = false end,
		Value = valueFlags and newText(valueFlags),
	}
end

-- health.lua ----------------------------------------------------------------

TestHealthElement = {}

function TestHealthElement:setUp()
	resetUnit()
	self.element = loadElement("modules/unitframes/elements/health.lua")
end

function TestHealthElement:update(flags)
	local frame = { unit = "target", Health = newBar(flags) }
	self.element.Update(frame, "UNIT_HEALTH", "target")
	return frame.Health
end

function TestHealthElement:test_bar_values()
	local Health = self:update()
	lu.assertEquals({ Health.min, Health.max, Health.value }, { 0, 1000, 800 })
end

function TestHealthElement:test_value_text()
	lu.assertEquals(self:update({}).Value.text, 800)
	unit.health = 0
	lu.assertEquals(self:update({}).Value.text, "") -- nothing at 0
end

function TestHealthElement:test_dead_ghost_and_offline_players()
	unit.dead = true
	local Health = self:update({})
	lu.assertEquals({ Health.value, Health.Value.text }, { 0, "Dead" })

	unit.dead, unit.ghost = false, true
	lu.assertEquals(self:update({}).Value.text, "Dead")

	unit.ghost, unit.connected = false, false
	Health = self:update({})
	lu.assertEquals({ Health.value, Health.max, Health.Value.text }, { 1, 1, "Offline" })
end

function TestHealthElement:test_dead_npc()
	unit.isPlayer, unit.dead = false, true
	lu.assertEquals(self:update({}).Value.text, "Dead")
end

function TestHealthElement:test_post_update_gets_the_state()
	unit.dead = true
	local frame = { unit = "target", Health = newBar() }
	frame.Health.PostUpdate = function(self, unit, cur, max, state) self.post = { unit, cur, max, state } end
	self.element.Update(frame, "UNIT_HEALTH", "target")
	lu.assertEquals(frame.Health.post, { "target", 0, 0, "dead" })
end

function TestHealthElement:test_unchanged_polls_skip_the_work()
	local frame = { unit = "target", Health = newBar({}) }
	self.element.Update(frame, "FREQUENT", 1/60)
	lu.assertEquals(frame.Health.sets, 1)

	self.element.Update(frame, "FREQUENT", 1/60) -- nothing changed
	lu.assertEquals(frame.Health.sets, 1)

	unit.health = 700
	self.element.Update(frame, "FREQUENT", 1/60)
	lu.assertEquals(frame.Health.sets, 2)
	lu.assertEquals(frame.Health.Value.text, 700)

	self.element.Update(frame, "UNIT_HEALTH", "target") -- events always update
	lu.assertEquals(frame.Health.sets, 3)
end

function TestHealthElement:test_unchanged_polls_still_refresh_twice_a_second()
	local frame = { unit = "target", Health = newBar() }
	self.element.Update(frame, "FREQUENT", 1/60)
	for _ = 1, 20 do
		self.element.Update(frame, "FREQUENT", 1/60) -- a third of a second
	end
	lu.assertEquals(frame.Health.sets, 1)
	for _ = 1, 20 do
		self.element.Update(frame, "FREQUENT", 1/60)
	end
	lu.assertEquals(frame.Health.sets, 2)
end

function TestHealthElement:test_unit_change_updates()
	local frame = { unit = "party1", Health = newBar() }
	self.element.Update(frame, "FREQUENT", 1/60)
	frame.unit = "party2" -- same health, another unit
	self.element.Update(frame, "FREQUENT", 1/60)
	lu.assertEquals(frame.Health.sets, 2)
end

-- power.lua -----------------------------------------------------------------

TestPowerElement = {}

function TestPowerElement:setUp()
	resetUnit()
	self.element = loadElement("modules/unitframes/elements/power.lua")
end

function TestPowerElement:test_bar_values_and_color()
	local frame = { unit = "player", Power = newBar({}) }
	self.element.Update(frame, "UNIT_MANA", "player")
	lu.assertEquals({ frame.Power.max, frame.Power.value }, { 600, 300 })
	lu.assertEquals(frame.Power.color, { 0, 0, 1 })
	lu.assertEquals(frame.Power.Value.text, 300)
end

function TestPowerElement:test_dead_and_disconnected_colors()
	unit.dead = true
	local frame = { unit = "party1", Power = newBar() }
	self.element.Update(frame)
	lu.assertEquals(frame.Power.value, 0)
	lu.assertEquals(frame.Power.color, COLORS.Status.Dead)

	unit.dead, unit.connected = false, false
	self.element.Update(frame)
	lu.assertEquals(frame.Power.color, COLORS.Status.Disconnected)
end

function TestPowerElement:test_druid_mana_bar_in_forms()
	local frame = { unit = "player", Power = newBar(), Mana = newBar() }
	self.element.Update(frame) -- caster form: mana is the main bar
	lu.assertFalse(frame.Mana.shown)

	unit.powerType, unit.powerID = "RAGE", 1 -- bear form
	self.element.Update(frame)
	lu.assertTrue(frame.Mana.shown)
	lu.assertEquals({ frame.Mana.max, frame.Mana.value }, { 600, 300 })
	lu.assertEquals(frame.Mana.color, { 0, 0, 0 }) -- the orb's mana layers, the shade last
	lu.assertEquals(frame.Power.color, { 1, 0, 0 })

	unit.dead = true
	self.element.Update(frame)
	lu.assertEquals({ frame.Mana.max, frame.Mana.value }, { 0, 0 })
end

function TestPowerElement:test_orb_colors_by_power_type()
	local frame = { unit = "player", Power = newBar() }
	frame.Power.GetObjectType = function() return "Orb" end
	frame.Power.Clear = function(self) self.cleared = (self.cleared or 0) + 1 end
	self.element.Update(frame) -- mana: the orb's mana layers, the shade last
	lu.assertEquals(frame.Power.color, { 0, 0, 0 })
	unit.powerType, unit.powerID = "POWER_TYPE_STEAM", 1 -- a vehicle's, with no orb colors
	self.element.Update(frame)
	lu.assertEquals(frame.Power.color, COLORS.Power.UNUSED)
	lu.assertEquals(frame.Power.cleared, 2) -- emptied on each change, for a livelier refill
end

function TestPowerElement:test_enable_reports_success()
	local registered = {}
	local frame = { unit = "player", Power = newBar(), Mana = newBar() }
	frame.RegisterEvent = function(_, event) registered[event] = true end
	lu.assertTrue(self.element.Enable(frame))
	lu.assertTrue(registered.UNIT_MANA)
	lu.assertTrue(registered.UNIT_DISPLAYPOWER)
end

function TestPowerElement:test_frame_with_only_a_mana_bar()
	local frame = { unit = "player", Mana = newBar() }
	frame.RegisterEvent = function() end
	frame.UnregisterEvent = function() end
	lu.assertTrue(self.element.Enable(frame))
end

function TestPowerElement:test_unchanged_polls_skip_the_work()
	local frame = { unit = "player", Power = newBar(), Mana = newBar() }
	unit.powerType, unit.powerID = "RAGE", 1
	self.element.Update(frame, "FREQUENT", 1/60)
	self.element.Update(frame, "FREQUENT", 1/60)
	lu.assertEquals({ frame.Power.sets, frame.Mana.sets }, { 1, 1 })

	unit.power[0] = 400 -- only the druid's mana changed
	self.element.Update(frame, "FREQUENT", 1/60)
	lu.assertEquals({ frame.Power.sets, frame.Mana.sets }, { 2, 2 })
	lu.assertEquals(frame.Mana.value, 400)
end

function TestPowerElement:test_frequent_updates()
	local frame = { unit = "target", Power = newBar() }
	frame.Power.frequent = 1/120
	frame.EnableFrequentUpdates = function(self, element, hz) self.frequent = { element, hz } end
	lu.assertTrue(self.element.Enable(frame))
	lu.assertEquals(frame.frequent, { "Power", 1/120 })
end

os.exit(lu.LuaUnit.run())
