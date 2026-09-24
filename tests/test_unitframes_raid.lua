-- Run from the addon root: lua5.1 tests/test_unitframes_raid.lua
--
-- Loads the *real* modules/unitframes/units/raid.lua and exercises its
-- debuff filter, which decides which debuffs raid frames show: boss
-- debuffs always, anything else only when the player's class can remove
-- it, following the WotLK 3.3.5 dispel list:
--   PRIEST  Magic, Disease         PALADIN Magic, Poison, Disease
--   DRUID   Curse, Poison          MAGE    Curse
--   SHAMAN  Poison, Disease, plus Curse with the Cleanse Spirit talent
-- (druids and shamans only gained Magic removal in Cataclysm).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local CLEANSE_SPIRIT_ID = 51886

local state

local function loadRaidDebuffFilter()
	state = { class = "PRIEST", knowsCleanseSpirit = false }

	_G.UnitClass = function() return state.class, state.class end
	_G.GetNumRaidMembers = function() return 0 end
	-- By spell ID it always answers; by name only when the spell is in the
	-- player's spellbook - same as the real client.
	_G.GetSpellInfo = function(spell)
		if spell == CLEANSE_SPIRIT_ID then
			return "Cleanse Spirit"
		elseif spell == "Cleanse Spirit" and state.knowsCleanseSpirit then
			return "Cleanse Spirit"
		end
	end

	local Engine = EngineMock.new()
	local Module = Engine:NewModule("UnitFrames")
	assert(loadfile("modules/unitframes/units/raid.lua"))("DiabolicUI", Engine)
	return Module:GetWidget("Unit: Raid").DebuffFilter
end

-- debuffFilter(self, name, rank, icon, count, debuffType, duration,
--              expirationTime, unitCaster, isStealable, spellId, isBossDebuff)
local function shows(filter, debuffType, isBossDebuff)
	return filter(nil, "Debuff", nil, nil, 1, debuffType, 0, 0, "boss1", nil, 1, isBossDebuff)
end

local DEBUFF_TYPES = { "Magic", "Curse", "Poison", "Disease" }

-- Which debuff types each class sees, as a set.
local EXPECTED = {
	PRIEST = { Magic = true, Disease = true },
	PALADIN = { Magic = true, Poison = true, Disease = true },
	DRUID = { Curse = true, Poison = true },
	MAGE = { Curse = true },
	SHAMAN = { Poison = true, Disease = true },
	WARRIOR = {},
	ROGUE = {},
	HUNTER = {},
	WARLOCK = {},
	DEATHKNIGHT = {},
}

TestRaidDebuffFilter = {}

function TestRaidDebuffFilter:setUp()
	self.filter = loadRaidDebuffFilter()
end

function TestRaidDebuffFilter:test_each_class_sees_what_it_can_dispel()
	for class, expected in pairs(EXPECTED) do
		state.class = class
		for _, debuffType in ipairs(DEBUFF_TYPES) do
			lu.assertEquals(shows(self.filter, debuffType), expected[debuffType] or false,
				class .. " / " .. debuffType)
		end
	end
end

function TestRaidDebuffFilter:test_shaman_curses_need_cleanse_spirit()
	state.class = "SHAMAN"
	lu.assertFalse(shows(self.filter, "Curse"))
	state.knowsCleanseSpirit = true
	lu.assertTrue(shows(self.filter, "Curse"))
	-- a respec away from the talent is picked up again
	state.knowsCleanseSpirit = false
	lu.assertFalse(shows(self.filter, "Curse"))
end

function TestRaidDebuffFilter:test_boss_debuffs_always_show()
	state.class = "WARRIOR"
	lu.assertTrue(shows(self.filter, nil, true))
	lu.assertTrue(shows(self.filter, "Magic", true))
end

function TestRaidDebuffFilter:test_typeless_debuffs_are_hidden()
	state.class = "PALADIN"
	lu.assertFalse(shows(self.filter, nil))
end

os.exit(lu.LuaUnit.run())
