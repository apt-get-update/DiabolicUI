-- Run from the addon root: lua5.1 tests/test_minimap_api.lua
--
-- Loads a handful of the *real* modules/minimap/Core/API/*.lua files (the
-- embedded minimap module's own small utility library) and exercises their
-- pure logic:
--  - Positions.lua's GetParsedPosition: which of the 9 anchor regions a
--    coordinate within a frame falls into, and the offset returned for it.
--  - Addons.lua's IsAddOnAvailable / IsAddOnEnabled: case-insensitive
--    lookups against the addon listing.
--
-- Unlike the rest of the addon, these files read a *global*
-- DiabolicUIMinimapNS (not the usual `local Addon, Engine = ...`), and each
-- one does `local API = ns.API or {}; ns.API = API`, accumulating onto the
-- same table across loads - so loading both against one shared
-- DiabolicUIMinimapNS table works exactly like the real addon's own load
-- order (Core/API/*.lua files loaded in sequence via Core.xml).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

local API

local function loadMinimapApi()
	_G.DiabolicUIMinimapNS = {}

	-- Addons.lua's functions loop a small fake addon list through these
	-- two globals.

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

os.exit(lu.LuaUnit.run())
