-- Run from the addon root: lua5.1 tests/test_unitframes_portraits.lua
--
-- Loads the *real* modules/unitframes/elements/portraits.lua and exercises
-- its Update function, which picks between the 3D model portrait and the
-- flat 2D fallback texture (party frames only have the latter):
--  - offline or missing unit: both hidden
--  - unit out of visible range (UnitIsVisible false): the 3D model can't
--    render, so it's hidden and the 2D portrait is shown instead - like
--    Blizzard's own party frames do for far-away group members
--  - unit in range: 2D hidden, 3D model shown and pointed at the unit,
--    with the close-up camera unless the unit is mounted, and camera 1 for
--    female humans (their close-up is framed wrong otherwise)
--  - events for a different unit are ignored
--
-- Same RegisterElement capture as test_unitframes_elements.lua.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- Fake game state, keyed by unit token.
local units

-- Records calls in order, dropping the leading self (see tests/README.md).
local function newRecorder(methods)
	local object = { calls = {}, shown = false }
	for _, name in ipairs(methods) do
		object[name] = function(self, ...)
			table.insert(self.calls, { name, ... })
		end
	end
	object.Show = function(self) self.shown = true; table.insert(self.calls, { "Show" }) end
	object.Hide = function(self) self.shown = false; table.insert(self.calls, { "Hide" }) end
	object.IsShown = function(self) return self.shown end
	return object
end

local function newModel()
	return newRecorder({ "ClearModel", "SetUnit", "SetCamera" })
end

local function newTexture()
	return newRecorder({})
end

-- Names of the calls a recorder received, e.g. { "Hide", "SetUnit" }.
local function callNames(recorder)
	local names = {}
	for _, call in ipairs(recorder.calls) do
		names[#names + 1] = call[1]
	end
	return names
end

local portraitTextures

local function loadPortraitElement()
	units = {}
	portraitTextures = {}

	_G.UnitExists = function(unit) return units[unit] ~= nil end
	_G.UnitIsConnected = function(unit) return units[unit] and not units[unit].offline end
	_G.UnitIsVisible = function(unit) return units[unit] and not units[unit].far end
	_G.IsMounted = function(unit) return units[unit] and units[unit].mounted end
	_G.UnitSex = function(unit) return units[unit] and units[unit].sex or 2 end
	_G.UnitIsPlayer = function() return true end
	_G.UnitRace = function(unit) return units[unit].race, units[unit].race end
	_G.UnitIsUnit = function(a, b) return a == b end
	_G.GetShapeshiftForm = function() return 0 end
	_G.UnitAura = function() return nil end
	_G.SetPortraitTexture = function(texture, unit)
		table.insert(portraitTextures, { texture, unit })
	end

	local Engine = EngineMock.new()
	local Handler = Engine:NewHandler("UnitFrame")
	local captured = {}
	Handler.RegisterElement = function(self, name, Enable, Disable, Update)
		captured[name] = { Enable = Enable, Disable = Disable, Update = Update }
	end
	assert(loadfile("modules/unitframes/elements/portraits.lua"))("DiabolicUI", Engine)
	return captured.Portrait
end

TestUnitFramePortrait = {}

function TestUnitFramePortrait:setUp()
	self.Update = loadPortraitElement().Update
	self.frame = { unit = "party1", Portrait = newModel(), Portrait2D = newTexture() }
end

function TestUnitFramePortrait:test_in_range_shows_the_3d_model()
	units.party1 = { race = "Orc" }
	self.Update(self.frame, "UNIT_PORTRAIT_UPDATE", "party1")

	local Portrait, Portrait2D = self.frame.Portrait, self.frame.Portrait2D
	lu.assertTrue(Portrait.shown)
	lu.assertFalse(Portrait2D.shown)
	lu.assertEquals(callNames(Portrait), { "Show", "ClearModel", "SetUnit", "SetCamera" })
	lu.assertEquals(Portrait.calls[3], { "SetUnit", "party1" })
	lu.assertEquals(Portrait.calls[4], { "SetCamera", 0 })
	lu.assertEquals(portraitTextures, {})
end

function TestUnitFramePortrait:test_out_of_range_falls_back_to_2d()
	units.party1 = { far = true }
	self.frame.Portrait.shown = true
	self.Update(self.frame, "PARTY_MEMBER_ENABLE")

	lu.assertFalse(self.frame.Portrait.shown)
	lu.assertTrue(self.frame.Portrait2D.shown)
	lu.assertEquals(portraitTextures, { { self.frame.Portrait2D, "party1" } })
end

function TestUnitFramePortrait:test_coming_back_in_range_swaps_back_to_3d()
	units.party1 = { far = true }
	self.Update(self.frame)
	units.party1.far = false
	self.Update(self.frame)
	lu.assertTrue(self.frame.Portrait.shown)
	lu.assertFalse(self.frame.Portrait2D.shown)
end

function TestUnitFramePortrait:test_out_of_range_without_a_2d_portrait_just_hides()
	-- player/target/focus frames have no Portrait2D
	units.party1 = { far = true }
	self.frame.Portrait2D = nil
	self.Update(self.frame)
	lu.assertFalse(self.frame.Portrait.shown)
	lu.assertEquals(portraitTextures, {})
end

function TestUnitFramePortrait:test_offline_hides_both()
	units.party1 = { offline = true }
	self.frame.Portrait.shown = true
	self.frame.Portrait2D.shown = true
	self.Update(self.frame)
	lu.assertFalse(self.frame.Portrait.shown)
	lu.assertFalse(self.frame.Portrait2D.shown)
end

function TestUnitFramePortrait:test_missing_unit_hides_both()
	self.frame.Portrait.shown = true
	self.Update(self.frame)
	lu.assertFalse(self.frame.Portrait.shown)
	lu.assertFalse(self.frame.Portrait2D.shown)
end

function TestUnitFramePortrait:test_mounted_units_keep_the_default_camera()
	units.party1 = { mounted = true }
	self.Update(self.frame)
	lu.assertEquals(callNames(self.frame.Portrait), { "Show", "ClearModel", "SetUnit" })
end

function TestUnitFramePortrait:test_female_humans_get_camera_one()
	units.party1 = { sex = 3, race = "Human" }
	self.Update(self.frame)
	local calls = self.frame.Portrait.calls
	lu.assertEquals(calls[#calls], { "SetCamera", 1 })
end

function TestUnitFramePortrait:test_ignores_events_for_other_units()
	units.party1 = {}
	self.Update(self.frame, "UNIT_MODEL_CHANGED", "party2")
	lu.assertEquals(self.frame.Portrait.calls, {})
end

function TestUnitFramePortrait:test_disable_hides_both()
	local element = loadPortraitElement()
	local registered = {}
	self.frame.RegisterEvent = function(_, event) registered[event] = true end
	self.frame.UnregisterEvent = function(_, event) registered[event] = nil end
	units.party1 = { far = true }

	lu.assertTrue(element.Enable(self.frame, "party1"))
	lu.assertTrue(registered.PARTY_MEMBER_ENABLE)
	lu.assertTrue(self.frame.Portrait2D.shown)

	element.Disable(self.frame, "party1")
	lu.assertEquals(registered, {})
	lu.assertFalse(self.frame.Portrait.shown)
	lu.assertFalse(self.frame.Portrait2D.shown)
end

os.exit(lu.LuaUnit.run())
