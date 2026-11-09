-- Run from the addon root: lua5.1 tests/test_session_addon_conflicts.lua
--
-- In the fake client: an addon that makes DiabolicUI turn a part of itself
-- off gets asked about once, and the answer is kept or acted on.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client
local POPUP = "DIABOLICUI_ADDON_CONFLICT_TipTac"

local function boot(kept)
	client = Client.boot({
		world = function(world)
			table.insert(world.addons, { name = "TipTac", enabled = true, loadable = true })
		end,
		savedVariables = kept and {
			DiabolicUI_DB = { AddOnConflicts = { profiles = { global = { kept = kept } } } },
		} or nil,
	})
	client:Tick(0.2)
end

-- The shown popup frame of the popup handler for `id`.
local function popupFrame(id)
	for _, child in ipairs({ client.Engine:GetFrame():GetChildren() }) do
		if child.id == id and child:IsShown() then
			return child
		end
	end
end

local function tipTac()
	for _, addon in ipairs(client.world.addons) do
		if addon.name == "TipTac" then
			return addon
		end
	end
end

TestAddOnConflicts = {}

function TestAddOnConflicts:tearDown()
	client = nil
end

function TestAddOnConflicts:test_keeping_the_addon_is_remembered()
	boot()
	lu.assertTrue(client.Engine:GetAddOnConflicts().TipTac)
	client:Click(popupFrame(POPUP).button1)
	lu.assertNil(popupFrame(POPUP))
	lu.assertTrue(client:GetModule("AddOnConflicts").db.kept.TipTac)
	lu.assertNotEquals(tipTac().enabled, false)
	assertClean(client)
end

function TestAddOnConflicts:test_kept_addons_are_not_asked_about_again()
	boot({ TipTac = true })
	lu.assertTrue(client.Engine:GetAddOnConflicts().TipTac)
	lu.assertNil(popupFrame(POPUP))
	assertClean(client)
end

function TestAddOnConflicts:test_turning_it_off_disables_it_and_reloads()
	boot()
	client:Click(popupFrame(POPUP).button2)
	lu.assertEquals(tipTac().enabled, false)
	lu.assertEquals(client.reloaded, 1)
	lu.assertNil(client:GetModule("AddOnConflicts").db.kept.TipTac)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
