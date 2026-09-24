-- Run from the addon root: lua5.1 tests/test_objectives_tracker.lua
--
-- Loads the *real* modules/objectives/tracker.lua ("Fade Quest Tracker")
-- and drives its OnUpdate ticker frame with a fake clock and cursor:
--  - it fades Questie's tracker when Questie's is shown, Blizzard's
--    WatchFrame otherwise, switching (and restoring full alpha on the old
--    one) when Questie's tracker is toggled
--  - hover is detected from the cursor position, since Questie's locked
--    tracker ignores mouse input
--  - after the cursor leaves: full alpha for Time Fading seconds, then a
--    0.3s fade down to the Opacity setting; hovering again restores it
--  - unticking the option restores full alpha straight away

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")
local FrameMock = require("mocks.frame_mock")

local clock, cursor
local Module, ticker

-- A tracker frame covering (0,0)-(100,200) at scale 1.
local function newTracker()
	return {
		alpha = 1, shown = true,
		GetLeft = function() return 0 end,
		GetRight = function() return 100 end,
		GetBottom = function() return 0 end,
		GetTop = function() return 200 end,
		GetEffectiveScale = function() return 1 end,
		IsShown = function(self) return self.shown end,
		SetAlpha = function(self, alpha) self.alpha = alpha end,
	}
end

local function tick(seconds)
	clock.now = clock.now + (seconds or 0)
	ticker:Fire("OnUpdate", seconds or 0)
end

local function hover(over)
	cursor.x, cursor.y = over and 50 or 500, over and 50 or 500
end

local function loadTracker()
	clock = { now = 100 }
	cursor = { x = 500, y = 500 }
	local frames = FrameMock.new()
	_G.CreateFrame = frames.CreateFrame
	_G.GetTime = function() return clock.now end
	_G.GetCursorPosition = function() return cursor.x, cursor.y end
	_G.Questie_BaseFrame = nil
	_G.WatchFrame = newTracker()

	local Engine = EngineMock.new()
	assert(loadfile("modules/objectives/tracker.lua"))("DiabolicUI", Engine)
	Module = Engine:GetModule("ObjectiveTracker")
	Module.db = { fadeTracker = true, fadeDelay = 5, fadeOpacity = 20 }
	ticker = frames.created[1]
end

TestTrackerFade = {}

function TestTrackerFade:setUp()
	loadTracker()
end

-- Hover, then leave: the fade timer only starts on leaving.
local function leaveAfterHover()
	hover(true)
	tick()
	hover(false)
	tick()
end

function TestTrackerFade:test_stays_visible_until_the_delay_passes()
	leaveAfterHover()
	tick(4.9)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_fades_to_the_opacity_setting()
	leaveAfterHover()
	tick(5)   -- delay over, fade starts
	tick(0.15) -- halfway through the 0.3s fade
	lu.assertAlmostEquals(_G.WatchFrame.alpha, 0.6, 1e-9)
	tick(0.15)
	lu.assertAlmostEquals(_G.WatchFrame.alpha, 0.2, 1e-9)
end

function TestTrackerFade:test_hovering_restores_full_alpha()
	leaveAfterHover()
	tick(5)
	tick(0.3)
	hover(true)
	tick()
	lu.assertEquals(_G.WatchFrame.alpha, 1)
	-- and hovering stops the timer: nothing happens while it stays there
	tick(60)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_never_hovered_never_fades()
	tick()
	tick(60)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_does_nothing_when_disabled()
	Module.db.fadeTracker = false
	leaveAfterHover()
	tick(5)
	tick(0.3)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_unticking_the_option_restores_full_alpha()
	leaveAfterHover()
	tick(5)
	tick(0.3)
	Module.db.fadeTracker = false
	Module:ApplyFadeSetting()
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_uses_questies_tracker_when_shown()
	local questie = newTracker()
	_G.Questie_BaseFrame = questie
	leaveAfterHover()
	tick(5)
	tick(0.3)
	lu.assertAlmostEquals(questie.alpha, 0.2, 1e-9)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_switching_tracker_restores_the_old_one()
	local questie = newTracker()
	_G.Questie_BaseFrame = questie
	leaveAfterHover()
	tick(5)
	tick(0.3)

	questie.shown = false -- Questie's tracker toggled off
	tick()
	lu.assertEquals(questie.alpha, 1)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

function TestTrackerFade:test_hidden_tracker_is_left_alone()
	_G.WatchFrame.shown = false
	leaveAfterHover()
	tick(5)
	tick(0.3)
	lu.assertEquals(_G.WatchFrame.alpha, 1)
end

os.exit(lu.LuaUnit.run())
