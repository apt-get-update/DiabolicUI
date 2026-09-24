-- Run from the addon root: lua5.1 tests/test_unitframes_runes.lua
--
-- Loads the *real* modules/unitframes/elements/runes.lua (the death knight
-- runes, ported from DiabolicUI2) and exercises its Update function against
-- scripted rune cooldowns:
--  - display order blood, blood, frost, frost, unholy, unholy (rune IDs
--    1, 2, 5, 6, 3, 4), colored by GetRuneType, including death runes
--  - a recharging rune's fill is cropped to its progress, not squashed
--  - visibility: in combat everything shows with recharging runes dimmed;
--    out of combat the row hides once all six are ready; vehicles hide it
--  - the OnUpdate ticker only runs while a rune is recharging
--
-- Same RegisterElement capture as test_unitframes_elements.lua.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local COLORS = {
	RUNES = { .4, .6, .9 },
	RUNES_BLOOD = { .8, .1, .2 },
	RUNES_UNHOLY = { .3, .7, .1 },
	RUNES_FROST = { .2, .4, .6 },
	RUNES_DEATH = { .7, .2, .6 },
}

local CONFIG = {
	fill_multiplier = .5,
	slot_multiplier = .25,
	glow_alpha = .75,
	alpha_recharging = .5,
}

local state -- scripted game state

local function newTexture(coords)
	return {
		texCoords = coords, shown = true,
		SetVertexColor = function(self, r, g, b, a) self.color = { r, g, b, a } end,
		SetHeight = function(self, h) self.height = h end,
		SetTexCoord = function(self, ...) self.coords = { ... } end,
		Show = function(self) self.shown = true end,
		Hide = function(self) self.shown = false end,
	}
end

local function newRunes()
	local Runes = {
		config = CONFIG, shown = true,
		SetScript = function(self, script, func) self.onUpdate = func end,
		Show = function(self) self.shown = true end,
		Hide = function(self) self.shown = false end,
	}
	for i = 1, 6 do
		local rune = {
			size = 70,
			SetAlpha = function(self, alpha) self.alpha = alpha end,
			Slot = newTexture({ 0, .125, 0, .25 }),
			Fill = newTexture({ 0, .125, .25, .5 }),
			Glow = newTexture({ 0, .125, .5, .75 }),
		}
		rune.layers = { rune.Fill, rune.Glow }
		Runes[i] = rune
	end
	return Runes
end

local function loadRunesElement()
	state = {
		now = 100,
		inCombat = false,
		inVehicle = false,
		-- rune ID -> { start, duration, ready, type }
		runes = {
			{ 0, 10, true, 1 }, { 0, 10, true, 1 },
			{ 0, 10, true, 2 }, { 0, 10, true, 2 },
			{ 0, 10, true, 3 }, { 0, 10, true, 3 },
		},
	}
	_G.GetTime = function() return state.now end
	_G.GetRuneCooldown = function(id) local r = state.runes[id]; return r[1], r[2], r[3] end
	_G.GetRuneType = function(id) return state.runes[id][4] end
	_G.UnitAffectingCombat = function() return state.inCombat end
	_G.UnitHasVehicleUI = function() return state.inVehicle end

	local Engine = EngineMock.new()
	Engine:NewStaticConfig("Data: Colors", { Power = COLORS })
	local Handler = Engine:NewHandler("UnitFrame")
	local captured
	Handler.RegisterElement = function(self, name, Enable, Disable, Update)
		captured = { Enable = Enable, Disable = Disable, Update = Update }
	end
	assert(loadfile("modules/unitframes/elements/runes.lua"))("DiabolicUI", Engine)
	return captured
end

local function recharge(runeID, start)
	state.runes[runeID][1] = start
	state.runes[runeID][3] = false
end

TestRunes = {}

function TestRunes:setUp()
	self.element = loadRunesElement()
	self.Runes = newRunes()
	self.frame = { Runes = self.Runes }
end

function TestRunes:update(event, ...)
	self.element.Update(self.frame, event, ...)
end

function TestRunes:test_display_order_and_colors()
	self:update("PLAYER_ENTERING_WORLD")
	-- slots 1-2 blood, 3-4 frost (rune IDs 5-6), 5-6 unholy (rune IDs 3-4)
	local expected = { COLORS.RUNES_BLOOD, COLORS.RUNES_BLOOD, COLORS.RUNES_FROST, COLORS.RUNES_FROST, COLORS.RUNES_UNHOLY, COLORS.RUNES_UNHOLY }
	for i, color in ipairs(expected) do
		local fill = self.Runes[i].Fill.color
		lu.assertAlmostEquals(fill[1], color[1] * .5, 1e-9)
		lu.assertAlmostEquals(fill[2], color[2] * .5, 1e-9)
		lu.assertAlmostEquals(self.Runes[i].Slot.color[1], color[1] * .25, 1e-9)
		lu.assertEquals(self.Runes[i].Glow.color[4], .75)
	end
end

function TestRunes:test_death_rune_recolors()
	self:update("PLAYER_ENTERING_WORLD")
	state.runes[5][4] = 4 -- a frost rune converted to death
	self:update("RUNE_TYPE_UPDATE", 5)
	lu.assertAlmostEquals(self.Runes[3].Fill.color[1], COLORS.RUNES_DEATH[1] * .5, 1e-9)
end

function TestRunes:test_recharging_fill_is_cropped()
	recharge(1, 97.5) -- 25% through a 10 second recharge
	self:update("RUNE_POWER_UPDATE", 1)
	local fill = self.Runes[1].Fill
	lu.assertAlmostEquals(fill.height, 70 * .25, 1e-9)
	-- the bottom quarter of the glyph's fill row (.25 to .5)
	lu.assertAlmostEquals(fill.coords[3], .5 - .25 * .25, 1e-9)
	lu.assertEquals(fill.coords[4], .5)

	state.now = 101.5 -- 40% through
	self.Runes.onUpdate(self.Runes, .1)
	lu.assertAlmostEquals(fill.height, 70 * .4, 1e-9)
end

function TestRunes:test_hidden_out_of_combat_when_all_ready()
	self:update("PLAYER_ENTERING_WORLD")
	for i = 1, 6 do
		lu.assertEquals(self.Runes[i].alpha, 0)
	end
	lu.assertNil(self.Runes.onUpdate)
end

function TestRunes:test_shown_in_combat_when_all_ready()
	self:update("PLAYER_REGEN_DISABLED")
	for i = 1, 6 do
		lu.assertEquals(self.Runes[i].alpha, 1)
	end
end

function TestRunes:test_recharging_runes_are_dimmed()
	recharge(3, 99)
	self:update("RUNE_POWER_UPDATE", 3)
	lu.assertEquals(self.Runes[5].alpha, .5) -- rune ID 3 sits in slot 5
	lu.assertEquals(self.Runes[1].alpha, 1)
	lu.assertNotNil(self.Runes.onUpdate)
end

function TestRunes:test_leaving_combat_hides_ready_runes_again()
	self:update("PLAYER_REGEN_DISABLED")
	self:update("PLAYER_REGEN_ENABLED")
	lu.assertEquals(self.Runes[1].alpha, 0)
end

function TestRunes:test_hidden_in_vehicles()
	state.inVehicle = true
	self:update("UNIT_ENTERED_VEHICLE", "player")
	lu.assertFalse(self.Runes.shown)
	state.inVehicle = false
	self:update("UNIT_EXITED_VEHICLE", "player")
	lu.assertTrue(self.Runes.shown)
end

function TestRunes:test_ignores_other_units_vehicles()
	self:update("PLAYER_ENTERING_WORLD")
	state.inVehicle = true
	self:update("UNIT_ENTERED_VEHICLE", "party1")
	lu.assertTrue(self.Runes.shown)
end

function TestRunes:test_enable_only_for_the_player()
	local registered = {}
	self.frame.RegisterEvent = function(_, event) registered[event] = true end
	lu.assertNil(self.element.Enable(self.frame, "target"))
	lu.assertTrue(self.element.Enable(self.frame, "player"))
	lu.assertTrue(registered.RUNE_POWER_UPDATE)
	lu.assertTrue(registered.RUNE_TYPE_UPDATE)
	lu.assertTrue(registered.PLAYER_REGEN_DISABLED)
end

os.exit(lu.LuaUnit.run())
