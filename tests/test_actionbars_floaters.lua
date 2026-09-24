-- Run from the addon root: lua5.1 tests/test_actionbars_floaters.lua
--
-- Loads the *real* modules/actionbars/elements/floaters.lua and exercises
-- UpdateTaxiExitButtonVisibility, the "request early landing" button:
--  - on a flight path: taxi bar shown, button enabled, stance button
--    hidden underneath it
--  - landed: the reverse
--  - in combat lockdown the (secure) frames can't be shown or hidden, so
--    the update waits for PLAYER_REGEN_ENABLED, then stops listening
--
-- The engine's Engine:Wrap (defer until out of combat) is replaced with a
-- pass-through here; tests/test_engine_core.lua covers Wrap itself.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local state

local function newToggle()
	return {
		shown = false, enabled = false, alpha = 1,
		Show = function(self) self.shown = true end,
		Hide = function(self) self.shown = false end,
		Enable = function(self) self.enabled = true end,
		Disable = function(self) self.enabled = false end,
		SetAlpha = function(self, alpha) self.alpha = alpha end,
	}
end

local function loadFloaters()
	state = { onTaxi = false, lockdown = false }
	_G.UnitOnTaxi = function() return state.onTaxi end
	_G.InCombatLockdown = function() return state.lockdown end

	local Engine = EngineMock.new()
	local Module = Engine:NewModule("ActionBars")
	Engine.Wrap = function(_, func) return func end
	assert(loadfile("modules/actionbars/elements/floaters.lua"))("DiabolicUI", Engine)

	local widget = Module:GetWidget("Bar: Floaters")
	widget.TaxiBar = newToggle()
	widget.TaxiExitButton = newToggle()
	widget.StanceBarButton = newToggle()
	widget.registered = {}
	widget.RegisterEvent = function(self, event, method) self.registered[event] = method end
	widget.UnregisterEvent = function(self, event) self.registered[event] = nil end
	return widget
end

TestTaxiExitButton = {}

function TestTaxiExitButton:setUp()
	self.widget = loadFloaters()
end

function TestTaxiExitButton:test_shown_while_on_a_flight()
	state.onTaxi = true
	self.widget:UpdateTaxiExitButtonVisibility("PLAYER_CONTROL_LOST")
	lu.assertTrue(self.widget.TaxiBar.shown)
	lu.assertTrue(self.widget.TaxiExitButton.enabled)
	lu.assertEquals(self.widget.StanceBarButton.alpha, 0)
end

function TestTaxiExitButton:test_hidden_after_landing()
	state.onTaxi = true
	self.widget:UpdateTaxiExitButtonVisibility("PLAYER_CONTROL_LOST")
	state.onTaxi = false
	self.widget:UpdateTaxiExitButtonVisibility("PLAYER_CONTROL_GAINED")
	lu.assertFalse(self.widget.TaxiBar.shown)
	lu.assertFalse(self.widget.TaxiExitButton.enabled)
	lu.assertEquals(self.widget.StanceBarButton.alpha, 1)
end

function TestTaxiExitButton:test_waits_for_combat_to_end()
	state.onTaxi = true
	state.lockdown = true
	self.widget:UpdateTaxiExitButtonVisibility("PLAYER_CONTROL_LOST")
	lu.assertFalse(self.widget.TaxiBar.shown)
	lu.assertEquals(self.widget.registered.PLAYER_REGEN_ENABLED, "UpdateTaxiExitButtonVisibility")

	state.lockdown = false
	self.widget:UpdateTaxiExitButtonVisibility("PLAYER_REGEN_ENABLED")
	lu.assertTrue(self.widget.TaxiBar.shown)
	lu.assertNil(self.widget.registered.PLAYER_REGEN_ENABLED)
end

os.exit(lu.LuaUnit.run())
