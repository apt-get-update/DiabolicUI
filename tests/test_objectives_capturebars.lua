-- Run from the addon root: lua5.1 tests/test_objectives_capturebars.lua
--
-- Loads the *real* modules/objectives/capturebars.lua under a minimal
-- Engine/WoW mock and exercises Module.UpdateCaptureBar - the math behind
-- the world-state "capture bar" (the tug-of-war progress bar shown for
-- battleground/outdoor objectives): resizing the neutral-zone middle
-- section, repositioning the spark to the current value, and showing the
-- left/right "moving" indicator based on which way the value just changed.
--
-- NewCaptureBar (which builds the real textures via CreateFrame) is
-- deliberately bypassed - a capture bar is pre-seeded directly into
-- Module.captureBarsByID with small hand-written fakes recording calls,
-- the same idiom test_tooltip_positioning.lua uses for its fake tooltip.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local Module
local calls

-- A texture/frame stand-in that just records every method call made on it
-- (dropping the leading `self` a colon call passes, so a recorded call is
-- just {methodName, arg1, arg2, ...} - not embedding the spy itself, which
-- would make its own growing `.calls` list self-referential).
local function newSpy()
	local spy = { calls = {} }
	setmetatable(spy, { __index = function(t, key)
		return function(_, ...) table.insert(t.calls, { key, ... }) end
	end })
	return spy
end

local function newFakeCaptureBar()
	return {
		width = 200,
		neutralZone = 0.0001,
		value = 1/2,
		min = 0,
		max = 1,
		middle = newSpy(),
		left = newSpy(),
		right = newSpy(),
		spark = newSpy(),
		leftIndicator = newSpy(),
		rightIndicator = newSpy(),
		shown = true,
		IsShown = function(self) return self.shown end,
		Show = function(self) self.shown = true end,
	}
end

local function loadCaptureBarsModule()
	local Engine = EngineMock.new()
	local chunk = assert(loadfile("modules/objectives/capturebars.lua"))
	chunk("DiabolicUI", Engine)
	local Module = Engine:GetModule("CaptureBars")
	Module:OnInit()
	return Module
end

TestCaptureBars = {}

function TestCaptureBars:setUp()
	Module = loadCaptureBarsModule()
	self.bar = newFakeCaptureBar()
	Module.captureBarsByID["world_state_1"] = self.bar
end

function TestCaptureBars:test_shows_the_bar_if_it_was_hidden()
	self.bar.shown = false
	Module:UpdateCaptureBar("world_state_1", 0.5, 0.0001, 0, 1)
	lu.assertTrue(self.bar:IsShown())
end

function TestCaptureBars:test_resizes_the_neutral_zone_when_it_changes()
	Module:UpdateCaptureBar("world_state_1", 0.5, 10, 0, 1) -- 10% neutral zone

	lu.assertEquals(self.bar.neutralZone, 10)
	lu.assertEquals(self.bar.middle.calls[1], { "SetWidth", 200 * 0.1 })
end

function TestCaptureBars:test_neutral_zone_is_clamped_between_a_tiny_minimum_and_100()
	Module:UpdateCaptureBar("world_state_1", 0.5, -5, 0, 1)
	lu.assertEquals(self.bar.neutralZone, 0.0001)

	Module.captureBarsByID["world_state_2"] = newFakeCaptureBar()
	Module:UpdateCaptureBar("world_state_2", 0.5, 250, 0, 1)
	lu.assertEquals(Module.captureBarsByID["world_state_2"].neutralZone, 100)
end

function TestCaptureBars:test_unchanged_neutral_zone_does_not_touch_the_textures()
	-- Bar was created with neutralZone = 0.0001 already.
	Module:UpdateCaptureBar("world_state_1", 0.5, 0.0001, 0, 1)
	lu.assertEquals(#self.bar.middle.calls, 0)
end

function TestCaptureBars:test_repositions_the_spark_to_the_new_value()
	-- fraction = (0.75 - 0)/(1 - 0) = 0.75, x = width * (0.75 - 0.5) = 50
	Module:UpdateCaptureBar("world_state_1", 0.75, 0.0001, 0, 1)

	lu.assertEquals(self.bar.spark.calls[1][1], "ClearAllPoints")
	lu.assertEquals(self.bar.spark.calls[2], { "SetPoint", "CENTER", 50, 0 })
end

function TestCaptureBars:test_shows_the_right_indicator_when_the_value_increases()
	Module:UpdateCaptureBar("world_state_1", 0.75, 0.0001, 0, 1) -- up from the default 0.5

	local hidLeft, shownRight
	for _, call in ipairs(self.bar.leftIndicator.calls) do
		if call[1] == "Hide" then hidLeft = true end
	end
	for _, call in ipairs(self.bar.rightIndicator.calls) do
		if call[1] == "Show" then shownRight = true end
	end
	lu.assertTrue(hidLeft)
	lu.assertTrue(shownRight)
end

function TestCaptureBars:test_shows_the_left_indicator_when_the_value_decreases()
	Module:UpdateCaptureBar("world_state_1", 0.25, 0.0001, 0, 1) -- down from the default 0.5

	local shownLeft, hidRight
	for _, call in ipairs(self.bar.leftIndicator.calls) do
		if call[1] == "Show" then shownLeft = true end
	end
	for _, call in ipairs(self.bar.rightIndicator.calls) do
		if call[1] == "Hide" then hidRight = true end
	end
	lu.assertTrue(shownLeft)
	lu.assertTrue(hidRight)
end

function TestCaptureBars:test_hides_both_indicators_near_the_edges()
	Module:UpdateCaptureBar("world_state_1", 0.999, 0.0001, 0, 1)

	local hidLeft, hidRight
	for _, call in ipairs(self.bar.leftIndicator.calls) do
		if call[1] == "Hide" then hidLeft = true end
	end
	for _, call in ipairs(self.bar.rightIndicator.calls) do
		if call[1] == "Hide" then hidRight = true end
	end
	lu.assertTrue(hidLeft)
	lu.assertTrue(hidRight)
end

function TestCaptureBars:test_unchanged_value_does_not_move_the_spark()
	Module:UpdateCaptureBar("world_state_1", 0.5, 0.0001, 0, 1) -- same as the default
	lu.assertEquals(#self.bar.spark.calls, 0)
end

os.exit(lu.LuaUnit.run())
