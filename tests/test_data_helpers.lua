-- Run from the addon root: lua5.1 tests/test_data_helpers.lua
--
-- The small shared helper libraries in data/ and engine/wotlk-helpers.lua,
-- loaded for real under the Engine mock:
--  - data/functions.lua ("Library: Format"): F.Short number abbreviation
--    (1500 -> "1.5k", trailing ".0" dropped) and F.Colorize
--  - data/aura-filters.lua ("Library: AuraFilters"): unit and caster checks
--  - data/aura-functions.lua ("Library: AuraFunctions"): UnitAura/UnitBuff/
--    UnitDebuff wrappers that add isBossDebuff and isCastByPlayer
--  - engine/wotlk-helpers.lua: Engine.UnitIsTapDenied and /rl

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- Fake game state, keyed by unit token.
local units

local function install(globals)
	for name, value in pairs(globals) do
		_G[name] = value
	end
end

local function unitField(field)
	return function(unit) return units[unit] and units[unit][field] end
end

-- Loads the given files against one Engine mock, like the real load order.
local function loadFiles(files, setup)
	units = {}
	local Engine = EngineMock.new()
	if setup then
		setup(Engine)
	end
	for _, file in ipairs(files) do
		assert(loadfile(file))("DiabolicUI", Engine)
	end
	return Engine
end

------------------------------------------------------------------------
-- data/functions.lua
------------------------------------------------------------------------

TestFormatShort = {}

function TestFormatShort:setUp()
	_G.GetLocale = function() return "enUS" end
	self.Short = loadFiles({ "data/functions.lua" }):GetDB("Library: Format").Short
end

function TestFormatShort:test_small_numbers_are_floored()
	lu.assertEquals((self.Short(0)), "0")
	lu.assertEquals((self.Short(999)), "999")
	lu.assertEquals((self.Short(42.9)), "42")
end

function TestFormatShort:test_thousands_millions_billions()
	lu.assertEquals((self.Short(1500)), "1.5k")
	lu.assertEquals((self.Short(2500000)), "2.5m")
	lu.assertEquals((self.Short(3200000000)), "3.2b")
end

function TestFormatShort:test_trailing_zero_decimal_is_dropped()
	lu.assertEquals((self.Short(1000)), "1k")
	lu.assertEquals((self.Short(10000)), "10k")
	lu.assertEquals((self.Short(100000)), "100k")
	lu.assertEquals((self.Short(1000000)), "1m")
end

function TestFormatShort:test_negative_thousands_are_abbreviated()
	lu.assertEquals((self.Short(-1500)), "-1.5k")
end

function TestFormatShort:test_accepts_numeric_strings_and_rejects_garbage()
	lu.assertEquals((self.Short("2000")), "2k")
	lu.assertEquals((self.Short("lots")), "")
	lu.assertEquals((self.Short(nil)), "")
end

TestFormatColorize = {}

function TestFormatColorize:setUp()
	_G.GetLocale = function() return "enUS" end
	local Engine = loadFiles({ "data/functions.lua" }, function(Engine)
		Engine:NewStaticConfig("Data: Colors", { General = { Normal = { 1, 0.5, 0 } } })
	end)
	self.Colorize = Engine:GetDB("Library: Format").Colorize
end

function TestFormatColorize:test_rgb_arguments()
	lu.assertEquals(self.Colorize("Hi", 1, 0, 0), "|cffFF0000Hi|r")
end

function TestFormatColorize:test_color_table()
	lu.assertEquals(self.Colorize("Hi", { 0, 1, 0 }), "|cff00FF00Hi|r")
end

function TestFormatColorize:test_named_general_color()
	lu.assertEquals(self.Colorize("Hi", "Normal"), "|cffFF7F00Hi|r")
end

function TestFormatColorize:test_nil_text_becomes_empty()
	lu.assertEquals(self.Colorize(nil, 1, 1, 1), "|cffFFFFFF|r")
end

------------------------------------------------------------------------
-- data/aura-filters.lua
------------------------------------------------------------------------

TestAuraFilters = {}

function TestAuraFilters:setUp()
	install({
		UnitPlayerControlled = unitField("player"),
		UnitIsFriend = function(_, unit) return units[unit] and units[unit].friend end,
		UnitIsEnemy = function(_, unit) return units[unit] and not units[unit].friend end,
		UnitCanAttack = function(_, unit) return units[unit] and not units[unit].friend end,
		UnitLevel = unitField("level"),
		UnitClassification = unitField("classification"),
		UnitIsUnit = function(a, b) return a == b or (units[a] and units[a].is == b) end,
	})
	self.Filter = loadFiles({ "data/aura-filters.lua" }):GetDB("Library: AuraFilters")
end

function TestAuraFilters:test_unit_reactions()
	units.target = { player = true, friend = true }
	units.focus = { player = true, friend = false }
	units.boss1 = { player = false, friend = false }
	lu.assertTrue(self.Filter.UnitIsFriendlyPlayer("target"))
	lu.assertFalse(self.Filter.UnitIsHostilePlayer("target"))
	lu.assertTrue(self.Filter.UnitIsHostilePlayer("focus"))
	lu.assertFalse(self.Filter.UnitIsHostileNPC("focus"))
	lu.assertTrue(self.Filter.UnitIsHostileNPC("boss1"))
end

function TestAuraFilters:test_unit_is_important()
	units.boss1 = { level = -1, classification = "worldboss" }
	units.target = { level = 80, classification = "rare" }
	units.focus = { level = 80, classification = "rareelite" }
	units.mouseover = { level = 80, classification = "elite" }
	units.pet = { level = 80, classification = "normal" }
	lu.assertTrue(self.Filter.UnitIsImportant("boss1"))
	lu.assertTrue(self.Filter.UnitIsImportant("target"))
	lu.assertTrue(self.Filter.UnitIsImportant("focus"))
	lu.assertFalse(self.Filter.UnitIsImportant("mouseover") or false)
	lu.assertFalse(self.Filter.UnitIsImportant("pet") or false)

	-- skull-level units count even without a classification
	units.target = { level = -1 }
	lu.assertTrue(self.Filter.UnitIsImportant("target"))
end

function TestAuraFilters:test_caster_checks()
	units.target = { is = "party1" }
	lu.assertTrue(self.Filter.CasterIsPlayer("target", "player"))
	lu.assertTrue(self.Filter.CasterIsPlayer("target", "pet"))
	lu.assertNil(self.Filter.CasterIsPlayer("target", "party1"))
	lu.assertTrue(self.Filter.CasterIsUnit("target", "target"))
	lu.assertTrue(self.Filter.CasterIsUnit("target", "party1"))
	lu.assertNil(self.Filter.CasterIsUnit("target", nil))
	lu.assertTrue(self.Filter.CasterIsVehicle("target", "vehicle"))
end

------------------------------------------------------------------------
-- data/aura-functions.lua
------------------------------------------------------------------------

TestAuraFunctions = {}

function TestAuraFunctions:setUp()
	self.inVehicle = false
	local aura = function(unit, index)
		local a = units[unit] and units[unit].auras[index]
		if a then
			return a.name, nil, "icon", 1, a.debuffType, 10, 20, a.caster, false, nil, a.spellId
		end
	end
	install({
		UnitAura = aura,
		UnitBuff = aura,
		UnitDebuff = aura,
		UnitHasVehicleUI = function() return self.inVehicle end,
	})
	self.Aura = loadFiles({ "data/aura-functions.lua" }):GetDB("Library: AuraFunctions")
end

-- Returns spellId, isBossDebuff, isCastByPlayer for one aura.
local function extras(func, unit, index)
	local results = { func(unit, index) }
	return results[10], results[11], results[12]
end

function TestAuraFunctions:test_adds_boss_and_player_flags()
	units.target = { auras = {
		{ name = "Mine", caster = "player", spellId = 1 },
		{ name = "Boss", caster = "boss1", spellId = 2, debuffType = "Magic" },
		{ name = "Pet", caster = "pet", spellId = 3 },
		{ name = "Other", caster = "party2", spellId = 4 },
		{ name = "Unknown", spellId = 5 },
	} }
	for _, name in ipairs({ "UnitAura", "UnitBuff", "UnitDebuff" }) do
		local func = self.Aura[name]
		local spellId, isBoss, isMine = extras(func, "target", 1)
		lu.assertEquals(spellId, 1)
		lu.assertNil(isBoss)
		lu.assertTrue(isMine)

		spellId, isBoss, isMine = extras(func, "target", 2)
		lu.assertEquals(spellId, 2)
		lu.assertEquals(isBoss, 1) -- string.find's start index
		lu.assertFalse(isMine)

		lu.assertTrue(select(3, extras(func, "target", 3)))
		lu.assertFalse(select(3, extras(func, "target", 4)))
		lu.assertNil(select(3, extras(func, "target", 5)))
	end
end

function TestAuraFunctions:test_vehicle_auras_count_as_the_players_while_driving()
	units.player = { auras = { { name = "Ram", caster = "vehicle", spellId = 9 } } }
	lu.assertFalse(select(3, extras(self.Aura.UnitAura, "player", 1)))
	self.inVehicle = true
	lu.assertTrue(select(3, extras(self.Aura.UnitAura, "player", 1)))
end

function TestAuraFunctions:test_missing_aura_returns_nil_name()
	units.target = { auras = {} }
	lu.assertNil((self.Aura.UnitAura("target", 1)))
end

------------------------------------------------------------------------
-- engine/wotlk-helpers.lua
------------------------------------------------------------------------

TestWotlkHelpers = {}

function TestWotlkHelpers:setUp()
	install({
		UnitIsTapped = unitField("tapped"),
		UnitPlayerControlled = unitField("player"),
		UnitIsTappedByPlayer = unitField("mine"),
		UnitIsTappedByAllThreatList = unitField("everyone"),
		UnitIsFriend = function(_, unit) return units[unit] and units[unit].friend end,
		SlashCmdList = {},
		ReloadUI = function() end,
	})
	self.Engine = {}
	units = {}
	assert(loadfile("engine/wotlk-helpers.lua"))("DiabolicUI", self.Engine)
end

function TestWotlkHelpers:test_tapped_by_someone_else_is_denied()
	units.target = { tapped = true }
	lu.assertTrue(self.Engine.UnitIsTapDenied("target"))
end

function TestWotlkHelpers:test_untapped_or_shared_credit_is_not_denied()
	units.target = {}
	lu.assertFalse(self.Engine.UnitIsTapDenied("target") or false)
	for _, reason in ipairs({ "mine", "everyone", "player", "friend" }) do
		units.target = { tapped = true, [reason] = true }
		lu.assertFalse(self.Engine.UnitIsTapDenied("target"), reason)
	end
end

function TestWotlkHelpers:test_reload_slash_commands()
	lu.assertEquals(_G.SLASH_RELOADUI1, "/rl")
	lu.assertEquals(_G.SLASH_RELOADUI2, "/reload")
	lu.assertEquals(_G.SLASH_RELOADUI3, "/reloadui")
	lu.assertIs(_G.SlashCmdList.RELOADUI, _G.ReloadUI)
end

os.exit(lu.LuaUnit.run())
