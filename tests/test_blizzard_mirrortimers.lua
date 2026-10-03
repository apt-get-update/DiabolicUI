-- Run from the addon root: lua5.1 tests/test_blizzard_mirrortimers.lua
--
-- Loads the *real* modules/blizzard/mirrortimers.lua under a minimal
-- Engine/WoW mock and exercises:
--  - Module.UpdateTimer: crops (not shrinks) a mirror timer's
--    statusbar texture to the current value, clamping to the bar's own
--    min/max first.
--  - Module.UpdateAnchors: only visible timers get anchored, sorted by
--    id, stacked one below the previous with
--    a configured padding, and the first one anchored either at the normal
--    position or the "one slot down" position depending on whether a
--    capture bar is currently occupying that spot.
--
-- Module.Skin (real CreateFrame/hooksecurefunc wiring) is bypassed - timers
-- are pre-seeded directly into Module.timers with small hand-written fakes
-- recording calls, the same idiom the other tests use.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local Module

-- A frame/texture stand-in that just records every method call made on it
-- as {methodName, arg1, arg2, ...} (dropping the leading `self` a colon
-- call passes, so recorded calls don't embed the spy itself).
local function newSpy()
	local spy = { calls = {} }
	setmetatable(spy, { __index = function(t, key)
		return function(_, ...) table.insert(t.calls, { key, ... }) end
	end })
	return spy
end

local function newFakeBar(min, max, value)
	local statusBarTexture = newSpy()
	return {
		GetMinMaxValues = function() return min, max end,
		GetValue = function() return value end,
		GetStatusBarTexture = function() return statusBarTexture end,
		statusBarTexture = statusBarTexture,
	}
end

local function newFakeTimerFrame(shown)
	local spy = newSpy()
	spy.shown = shown
	spy.IsShown = function(self) return self.shown end
	return spy
end

local function loadMirrorTimersModule()
	-- table.wipe is a WoW-custom extension, not standard Lua 5.1, captured
	-- as a local upvalue at file scope (`local table_wipe = table.wipe`).
	_G.table.wipe = _G.table.wipe or function(t)
		for k in pairs(t) do t[k] = nil end
	end

	local Engine = EngineMock.new()
	local chunk = assert(loadfile("modules/blizzard/mirrortimers.lua"))
	chunk("DiabolicUI", Engine)
	local Module = Engine:GetModule("Blizzard: MirrorTimers")
	Module:OnInit()
	Module.config.position = { "TOP", "UIParent", "TOP", 0, -10 }
	Module.config.positionOffsetByOne = { "TOP", "UIParent", "TOP", 0, -40 }
	Module.config.padding = 5
	return Module
end

TestMirrorTimers = {}

function TestMirrorTimers:setUp()
	Module = loadMirrorTimersModule()
end

-- UpdateTimer
---------------------------------------------------------

function TestMirrorTimers:test_crops_the_texture_to_the_current_fraction()
	local frame = newFakeTimerFrame(true)
	local bar = newFakeBar(0, 100, 25)
	Module.timers[frame] = { bar = bar }

	Module:UpdateTimer(frame)

	lu.assertEquals(bar.statusBarTexture.calls[1], { "SetTexCoord", 0, 0.25, 0, 1 })
end

function TestMirrorTimers:test_clamps_value_above_max()
	local frame = newFakeTimerFrame(true)
	local bar = newFakeBar(0, 100, 150) -- value over max, e.g. a stale read
	Module.timers[frame] = { bar = bar }

	Module:UpdateTimer(frame)

	lu.assertEquals(bar.statusBarTexture.calls[1], { "SetTexCoord", 0, 1, 0, 1 })
end

function TestMirrorTimers:test_clamps_value_below_min()
	local frame = newFakeTimerFrame(true)
	local bar = newFakeBar(10, 100, 0)
	Module.timers[frame] = { bar = bar }

	Module:UpdateTimer(frame)

	lu.assertEquals(bar.statusBarTexture.calls[1], { "SetTexCoord", 0, 0, 0, 1 })
end

function TestMirrorTimers:test_does_nothing_when_min_max_or_value_is_unavailable()
	local frame = newFakeTimerFrame(true)
	local bar = {
		GetMinMaxValues = function() return nil, nil end,
		GetValue = function() return nil end,
		GetStatusBarTexture = function() error("should not be reached") end,
	}
	Module.timers[frame] = { bar = bar }

	Module:UpdateTimer(frame) -- must not error
end

-- UpdateAnchors
---------------------------------------------------------

function TestMirrorTimers:test_hidden_timers_are_skipped_but_still_cleared()
	local shownFrame = newFakeTimerFrame(true)
	local hiddenFrame = newFakeTimerFrame(false)
	Module.timers[shownFrame] = { frame = shownFrame, id = 1 }
	Module.timers[hiddenFrame] = { frame = hiddenFrame, id = 2 }

	Module:UpdateAnchors()

	lu.assertEquals(shownFrame.calls[1][1], "ClearAllPoints")
	lu.assertEquals(hiddenFrame.calls[1][1], "ClearAllPoints")
	-- Only the shown one gets anchored (SetPoint called on its own frame).
	lu.assertEquals(#shownFrame.calls, 2)
	lu.assertEquals(#hiddenFrame.calls, 1)
end

function TestMirrorTimers:test_timers_are_ordered_by_id()
	local first = newFakeTimerFrame(true)
	local second = newFakeTimerFrame(true)
	Module.timers[second] = { frame = second, id = 2 }
	Module.timers[first] = { frame = first, id = 1 }

	Module:UpdateAnchors()

	lu.assertEquals(first.calls[2], { "SetPoint", "TOP", "UIParent", "TOP", 0, -10 })
	lu.assertEquals(second.calls[2], { "SetPoint", "CENTER", first, "CENTER", 0, -5 })
end

function TestMirrorTimers:test_moves_one_slot_down_while_a_capture_bar_is_visible()
	local frame = newFakeTimerFrame(true)
	Module.timers[frame] = { frame = frame, id = 1 }

	Module:CaptureBarVisible() -- re-anchors right away

	lu.assertEquals(frame.calls[2], { "SetPoint", "TOP", "UIParent", "TOP", 0, -40 })
end

function TestMirrorTimers:test_moves_back_up_once_the_capture_bar_hides()
	local frame = newFakeTimerFrame(true)
	Module.timers[frame] = { frame = frame, id = 1 }

	Module:CaptureBarVisible()
	Module:CaptureBarHidden()

	lu.assertEquals(frame.calls[4], { "SetPoint", "TOP", "UIParent", "TOP", 0, -10 })
end

function TestMirrorTimers:test_does_nothing_when_no_timer_is_visible()
	local frame = newFakeTimerFrame(false)
	Module.timers[frame] = { frame = frame, id = 1 }

	Module:UpdateAnchors() -- must not error with an empty visible-order list
end

os.exit(lu.LuaUnit.run())
