-- Run from the addon root: lua5.1 tests/test_actionbars_visibility.lua
--
-- Loads the *real* modules/actionbars/actionbars.lua under a minimal
-- Engine/WoW mock and exercises Module.IsXPVisible / IsReputationVisible -
-- the checks that decide whether the xp bar and the reputation bar (see
-- modules/actionbars/elements/xp.lua and reputation.lua) should be shown.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- Mutable "world state" the mocked WoW API functions below read from, so
-- tests can flip a flag instead of having to reassign _G.* functions after
-- the module is loaded - several of these are captured once as upvalues at
-- file-load time (`local UnitHasVehicleUI = _G.UnitHasVehicleUI`), so a
-- later `_G.UnitHasVehicleUI = ...` reassignment would silently do nothing.
local state

local function resetState()
	state = {
		inVehicle = false,
		possessedPet = false,
		expansionLevel = 3,
		playerLevel = 80,
		maxLevelForExpansion = { [3] = 80 },
		watchedFaction = nil,
	}
end

_G.UnitHasVehicleUI = function() return state.inVehicle end
_G.UnitIsPossessed = function() return state.possessedPet and 1 or nil end
_G.GetAccountExpansionLevel = function() return state.expansionLevel end
_G.UnitLevel = function() return state.playerLevel end
_G.MAX_PLAYER_LEVEL_TABLE = setmetatable({}, { __index = function(_, k)
	return state.maxLevelForExpansion[k]
end })
_G.GetWatchedFactionInfo = function() return state.watchedFaction end

local function loadActionBarsModule()
	local Engine = EngineMock.new()
	local chunk = assert(loadfile("modules/actionbars/actionbars.lua"))
	chunk("DiabolicUI", Engine)
	return Engine:GetModule("ActionBars")
end

TestIsXPVisible = {}

function TestIsXPVisible:setUp()
	resetState()
	self.Module = loadActionBarsModule()
end

function TestIsXPVisible:test_true_while_leveling()
	state.playerLevel = 79
	lu.assertTrue(self.Module:IsXPVisible())
end

function TestIsXPVisible:test_false_at_the_expansion_level_cap()
	state.playerLevel = 80
	state.maxLevelForExpansion[3] = 80
	lu.assertFalse(self.Module:IsXPVisible())
end

function TestIsXPVisible:test_false_in_a_vehicle()
	state.inVehicle = true
	state.playerLevel = 10 -- would otherwise be xp-visible
	lu.assertFalse(self.Module:IsXPVisible())
end

function TestIsXPVisible:test_false_when_possessing_a_pet()
	state.possessedPet = true
	state.playerLevel = 10
	lu.assertFalse(self.Module:IsXPVisible())
end

TestIsReputationVisible = {}

function TestIsReputationVisible:setUp()
	resetState()
	self.Module = loadActionBarsModule()
end

function TestIsReputationVisible:test_false_with_no_watched_faction()
	state.watchedFaction = nil
	lu.assertFalse(self.Module:IsReputationVisible())
end

function TestIsReputationVisible:test_true_with_a_watched_faction()
	state.watchedFaction = "Some Faction"
	lu.assertTrue(self.Module:IsReputationVisible())
end

function TestIsReputationVisible:test_false_in_a_vehicle_even_with_a_watched_faction()
	state.watchedFaction = "Some Faction"
	state.inVehicle = true
	lu.assertFalse(self.Module:IsReputationVisible())
end

os.exit(lu.LuaUnit.run())
