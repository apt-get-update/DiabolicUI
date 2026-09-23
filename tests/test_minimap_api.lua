-- Run from the addon root: lua5.1 tests/test_minimap_api.lua
--
-- Loads a handful of the *real* modules/minimap/Core/API/*.lua files (the
-- embedded minimap module's own small utility library) and exercises their
-- pure logic:
--  - Positions.lua's GetParsedPosition: which of the 9 anchor regions a
--    coordinate within a frame falls into, and the offset returned for it.
--  - Abbreviations.lua's AbbreviateNumber / AbbreviateNumberBalanced /
--    AbbreviateTime: number/time -> short display-string formatting.
--  - Addons.lua's IsAddOnAvailable / IsAddOnEnabled / IsAddOnLoadable:
--    case-insensitive lookups against the addon listing.
--
-- Unlike the rest of the addon, these files read a *global*
-- DiabolicUIMinimapNS (not the usual `local Addon, Engine = ...`), and each
-- one does `local API = ns.API or {}; ns.API = API`, accumulating onto the
-- same table across loads - so loading all three against one shared
-- DiabolicUIMinimapNS table works exactly like the real addon's own load
-- order (Core/API/*.lua files loaded in sequence via Core.xml).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

local API

local function loadMinimapApi()
	_G.DiabolicUIMinimapNS = {}

	-- Abbreviations.lua reads GetLocale() at file scope to pick the zhCN
	-- exception branch or not - default to a plain English locale.
	_G.GetLocale = function() return "enUS" end

	-- Addons.lua reads UnitName("player") at file scope, and its functions
	-- loop a small fake addon list through these two globals.
	_G.UnitName = function() return "Tester" end

	local addonList = {
		{ name = "Questie", enabled = true, loadable = true },
		{ name = "MBB", enabled = false, loadable = true },
		{ name = "SomeLoDAddon", enabled = false, loadable = false },
	}
	_G.GetNumAddOns = function() return #addonList end
	_G.GetAddOnInfo = function(index)
		local a = addonList[index]
		return a.name, a.name, "", a.enabled, a.loadable, nil, nil
	end

	for _, file in ipairs({
		"modules/minimap/Core/API/Positions.lua",
		"modules/minimap/Core/API/Abbreviations.lua",
		"modules/minimap/Core/API/Addons.lua",
	}) do
		local chunk = assert(loadfile(file))
		chunk("DiabolicUI")
	end

	return _G.DiabolicUIMinimapNS.API
end

TestMinimapApi = {}

function TestMinimapApi:setUp()
	API = loadMinimapApi()
end

-- GetParsedPosition
---------------------------------------------------------

function TestMinimapApi:test_bottom_left_region()
	local point, x, y = API.GetParsedPosition(300, 300, 50, 50, -1, -2, -3, -4)
	lu.assertEquals(point, "BOTTOMLEFT")
	lu.assertEquals(x, -2) -- leftOffset
	lu.assertEquals(y, -1) -- bottomOffset
end

function TestMinimapApi:test_bottom_right_region()
	local point, x, y = API.GetParsedPosition(300, 300, 250, 50, -1, -2, -3, -4)
	lu.assertEquals(point, "BOTTOMRIGHT")
	lu.assertEquals(x, -4) -- rightOffset
	lu.assertEquals(y, -1) -- bottomOffset
end

function TestMinimapApi:test_bottom_center_region_uses_x_relative_to_center()
	local point, x, y = API.GetParsedPosition(300, 300, 150, 50, -1, -2, -3, -4)
	lu.assertEquals(point, "BOTTOM")
	lu.assertEquals(x, 150 - 300/2)
	lu.assertEquals(y, -1)
end

function TestMinimapApi:test_top_left_region()
	local point, x, y = API.GetParsedPosition(300, 300, 50, 250, -1, -2, -3, -4)
	lu.assertEquals(point, "TOPLEFT")
	lu.assertEquals(x, -2) -- leftOffset
	lu.assertEquals(y, -3) -- topOffset
end

function TestMinimapApi:test_center_left_region()
	local point, x, y = API.GetParsedPosition(300, 300, 50, 150, -1, -2, -3, -4)
	lu.assertEquals(point, "LEFT")
	lu.assertEquals(x, -2) -- leftOffset
	lu.assertEquals(y, 150 - 300/2)
end

function TestMinimapApi:test_dead_center_region()
	local point, x, y = API.GetParsedPosition(300, 300, 150, 150, -1, -2, -3, -4)
	lu.assertEquals(point, "CENTER")
	lu.assertEquals(x, 150 - 300/2)
	lu.assertEquals(y, 150 - 300/2)
end

-- AbbreviateNumber
---------------------------------------------------------

function TestMinimapApi:test_abbreviate_number_billions_millions_thousands()
	lu.assertEquals(API.AbbreviateNumber(2500000000), "2.5b")
	lu.assertEquals(API.AbbreviateNumber(3200000), "3.2m")
	lu.assertEquals(API.AbbreviateNumber(1500), "1.5k")
end

function TestMinimapApi:test_abbreviate_number_strips_trailing_zero()
	-- 1.0m should collapse to "1m", not "1.0m"
	lu.assertEquals(API.AbbreviateNumber(1000000), "1m")
end

function TestMinimapApi:test_abbreviate_number_small_values_and_invalid_input()
	lu.assertEquals(API.AbbreviateNumber(42), "42")
	lu.assertEquals(API.AbbreviateNumber(0), "")
	lu.assertEquals(API.AbbreviateNumber("not a number"), "")
end

-- AbbreviateNumberBalanced
---------------------------------------------------------

function TestMinimapApi:test_abbreviate_number_balanced_ranges()
	lu.assertEquals(API.AbbreviateNumberBalanced(150000000), "150m")
	lu.assertEquals(API.AbbreviateNumberBalanced(12300000), "12.3m")
	lu.assertEquals(API.AbbreviateNumberBalanced(150000), "150k")
	lu.assertEquals(API.AbbreviateNumberBalanced(1500), "1.5k")
	lu.assertEquals(API.AbbreviateNumberBalanced(42), "42")
end

-- AbbreviateTime
---------------------------------------------------------

function TestMinimapApi:test_abbreviate_time_days_hours_minutes()
	lu.assertEquals({ API.AbbreviateTime(90000) }, { "%.0f%s", 2, "d" }) -- >1 day, rounds up
	lu.assertEquals({ API.AbbreviateTime(7200) }, { "%.0f%s", 2, "h" }) -- exactly 2 hours
	lu.assertEquals({ API.AbbreviateTime(90) }, { "%.0f%s", 2, "m" }) -- 90s -> 2m (rounds up)
end

function TestMinimapApi:test_abbreviate_time_seconds_thresholds()
	lu.assertEquals({ API.AbbreviateTime(10) }, { "%.0f", 10 })
	lu.assertEquals({ API.AbbreviateTime(1) }, { "|cffff8800%.0f|r", 1 })
	lu.assertEquals({ API.AbbreviateTime(0.02) }, { "" })
end

-- Addon lookups
---------------------------------------------------------

function TestMinimapApi:test_is_addon_available_is_case_insensitive()
	lu.assertTrue(API.IsAddOnAvailable("questie"))
	lu.assertTrue(API.IsAddOnAvailable("QUESTIE"))
	lu.assertNil(API.IsAddOnAvailable("NotInstalled"))
end

function TestMinimapApi:test_is_addon_enabled_requires_enabled_and_loadable()
	lu.assertTrue(API.IsAddOnEnabled("Questie"))
	lu.assertNil(API.IsAddOnEnabled("MBB")) -- present, but disabled
end

function TestMinimapApi:test_is_addon_loadable_respects_ignore_lod()
	lu.assertNil(API.IsAddOnLoadable("SomeLoDAddon"))
	lu.assertTrue(API.IsAddOnLoadable("SomeLoDAddon", true))
end

os.exit(lu.LuaUnit.run())
