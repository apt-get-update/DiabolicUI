-- Run from the addon root: lua5.1 tests/test_tooltip_positioning.lua
--
-- Loads the *real* modules/blizzard/tooltips.lua under a minimal Engine/WoW
-- mock, then exercises its cursor-anchoring math directly - the same
-- functions the actual addon uses to position tooltips relative to the
-- user's chosen anchor point and offset.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")
local WowApiMock = require("mocks.wow_api_mock")

WowApiMock.install()

-- The real module keeps `local GetCursorPosition = _G.GetCursorPosition` as
-- an upvalue captured once at file-load time, so re-pointing the global
-- later (e.g. reassigning _G.GetCursorPosition inside a test) would have no
-- effect on an already-loaded module. Instead we install one fixed closure
-- up front and let tests mutate the table it reads from.
local cursor = { x = 0, y = 0 }
_G.GetCursorPosition = function() return cursor.x, cursor.y end
_G.UIParent = { name = "UIParent" }

local function setCursorPosition(x, y)
	cursor.x, cursor.y = x, y
end

-- Loads a fresh copy of the module under test, so each test starts from a
-- clean Module.db instead of leaking state between tests.
local function loadTooltipsModule()
	local Engine = EngineMock.new()
	local chunk = assert(loadfile("modules/blizzard/tooltips.lua"))
	chunk("DiabolicUI", Engine)
	local Module = Engine:GetModule("Blizzard: Tooltips")
	Module.db = { offsetX = 0, offsetY = 0, anchorPoint = "BOTTOM" }
	return Module
end

-- A fake GameTooltip: just enough of the Frame API for Tooltip_PositionAtCursor
-- to run, recording every SetPoint call so tests can assert on it.
local function newFakeTooltip(overrides)
	local tooltip = { width = 200, height = 100, scale = 1, points = {} }
	for k, v in pairs(overrides or {}) do
		tooltip[k] = v
	end
	function tooltip:GetEffectiveScale() return self.scale end
	function tooltip:GetWidth() return self.width end
	function tooltip:GetHeight() return self.height end
	function tooltip:ClearAllPoints() self.points = {} end
	function tooltip:SetPoint(point, relativeTo, relativePoint, x, y)
		table.insert(self.points, { point = point, relativeTo = relativeTo, relativePoint = relativePoint, x = x, y = y })
	end
	return tooltip
end

-- point name -> { horizontal fraction, vertical fraction }, mirroring the
-- ANCHOR_POINTS table in modules/blizzard/tooltips.lua.
local ALL_POINTS = {
	TOPLEFT     = { 0,  1  },
	TOP         = { .5, 1  },
	TOPRIGHT    = { 1,  1  },
	LEFT        = { 0,  .5 },
	CENTER      = { .5, .5 },
	RIGHT       = { 1,  .5 },
	BOTTOMLEFT  = { 0,  0  },
	BOTTOM      = { .5, 0  },
	BOTTOMRIGHT = { 1,  0  },
}

TestTooltipGetAnchorFractions = {}

function TestTooltipGetAnchorFractions:setUp()
	self.Module = loadTooltipsModule()
end

function TestTooltipGetAnchorFractions:test_defaults_to_bottom_when_unset()
	self.Module.db.anchorPoint = nil
	local h, v = self.Module:Tooltip_GetAnchorFractions()
	lu.assertEquals(h, 0.5)
	lu.assertEquals(v, 0)
end

function TestTooltipGetAnchorFractions:test_falls_back_to_bottom_for_an_unknown_point()
	self.Module.db.anchorPoint = "NOT_A_REAL_POINT"
	local h, v = self.Module:Tooltip_GetAnchorFractions()
	lu.assertEquals(h, 0.5)
	lu.assertEquals(v, 0)
end

function TestTooltipGetAnchorFractions:test_every_named_point_returns_its_fraction()
	for point, expected in pairs(ALL_POINTS) do
		self.Module.db.anchorPoint = point
		local h, v = self.Module:Tooltip_GetAnchorFractions()
		lu.assertEquals({ h, v }, expected, "point " .. point)
	end
end

TestTooltipPositionAtCursor = {}

function TestTooltipPositionAtCursor:setUp()
	self.Module = loadTooltipsModule()
end

function TestTooltipPositionAtCursor:test_bottom_anchor_centers_horizontally_and_sits_on_the_cursor()
	setCursorPosition(400, 300)
	local tooltip = newFakeTooltip({ width = 200, height = 100 })
	self.Module:Tooltip_PositionAtCursor(tooltip)

	lu.assertEquals(#tooltip.points, 1)
	local p = tooltip.points[1]
	lu.assertEquals(p.point, "BOTTOMLEFT")
	lu.assertEquals(p.relativeTo, _G.UIParent)
	lu.assertEquals(p.relativePoint, "BOTTOMLEFT")
	lu.assertEquals(p.x, 400 - 100) -- cursorX - width/2, i.e. horizontally centered
	lu.assertEquals(p.y, 300) -- cursorY, bottom edge sits right on the cursor
end

function TestTooltipPositionAtCursor:test_offset_is_added_on_top_of_the_anchor_point()
	setCursorPosition(400, 300)
	self.Module.db.offsetX = 15
	self.Module.db.offsetY = -20
	local tooltip = newFakeTooltip({ width = 200, height = 100 })
	self.Module:Tooltip_PositionAtCursor(tooltip)

	local p = tooltip.points[1]
	lu.assertEquals(p.x, 400 - 100 + 15)
	lu.assertEquals(p.y, 300 - 20)
end

function TestTooltipPositionAtCursor:test_center_anchor_also_folds_in_half_the_height()
	setCursorPosition(400, 300)
	self.Module.db.anchorPoint = "CENTER"
	local tooltip = newFakeTooltip({ width = 200, height = 100 })
	self.Module:Tooltip_PositionAtCursor(tooltip)

	local p = tooltip.points[1]
	lu.assertEquals(p.x, 400 - 100)
	lu.assertEquals(p.y, 300 - 50)
end

function TestTooltipPositionAtCursor:test_topright_anchor_puts_the_cursor_at_the_top_right_corner()
	setCursorPosition(400, 300)
	self.Module.db.anchorPoint = "TOPRIGHT"
	local tooltip = newFakeTooltip({ width = 200, height = 100 })
	self.Module:Tooltip_PositionAtCursor(tooltip)

	local p = tooltip.points[1]
	lu.assertEquals(p.x, 400 - 200) -- full width subtracted: cursor sits at the right edge
	lu.assertEquals(p.y, 300 - 100) -- full height subtracted: cursor sits at the top edge
end

function TestTooltipPositionAtCursor:test_raw_cursor_position_is_divided_by_effective_scale()
	setCursorPosition(800, 600)
	local tooltip = newFakeTooltip({ width = 200, height = 100, scale = 2 })
	self.Module:Tooltip_PositionAtCursor(tooltip)

	local p = tooltip.points[1]
	lu.assertEquals(p.x, 400 - 100) -- 800/2 - width/2
	lu.assertEquals(p.y, 300) -- 600/2
end

os.exit(lu.LuaUnit.run())
