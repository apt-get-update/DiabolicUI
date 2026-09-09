-- Run from the addon root: lua5.1 tests/test_all_modules_load.lua
--
-- A load-only "smoke test" for every module/handler file in the addon: each
-- one is loaded standalone (fresh Engine mock + a permissive auto-stub for
-- any WoW global it touches) and we assert it doesn't error while doing so.
--
-- This can't verify any file *behaves* correctly - see test_tooltip_positioning.lua
-- and friends for that, on the handful of files with real assertions - but it
-- does catch load-time regressions across the whole addon: typos, a removed
-- function a file still calls at file scope, a bad require/reference, etc.
-- See tests/README.md for what this approach can and can't catch.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")
local WowApiMock = require("mocks.wow_api_mock")
local AutoStub = require("mocks.auto_stub")

-- Real, meaningful mocks first (so e.g. ITEM_LEVEL is an actual string),
-- then the permissive catch-all for everything else.
WowApiMock.install()
AutoStub.install()

-- Every module/handler file the addon ships, in the same load order as the
-- .toc/.xml files (handlers before modules, matching how the real client
-- loads them - not that it matters much here, since each file gets its own
-- isolated Engine mock).
local FILES = {
	"handlers/actionbar.lua",
	"handlers/actionbutton.lua",
	"handlers/blizzard.lua",
	"handlers/commands.lua",
	"handlers/fade.lua",
	"handlers/flash.lua",
	"handlers/orb.lua",
	"handlers/popups.lua",
	"handlers/slider.lua",
	"handlers/statusbar.lua",
	"handlers/tooltip.lua",
	"handlers/unitframe.lua",

	"modules/actionbars/actionbars.lua",
	"modules/actionbars/controllers/controller_chat.lua",
	"modules/actionbars/controllers/controller_main.lua",
	"modules/actionbars/controllers/controller_menu.lua",
	"modules/actionbars/controllers/controller_pet.lua",
	"modules/actionbars/elements/artwork.lua",
	"modules/actionbars/elements/bar1.lua",
	"modules/actionbars/elements/bar2.lua",
	"modules/actionbars/elements/bar3.lua",
	"modules/actionbars/elements/bar4.lua",
	"modules/actionbars/elements/bar5.lua",
	"modules/actionbars/elements/floaters.lua",
	"modules/actionbars/elements/keybinds.lua",
	"modules/actionbars/elements/menu.lua",
	"modules/actionbars/elements/pet.lua",
	"modules/actionbars/elements/reputation.lua",
	"modules/actionbars/elements/social.lua",
	"modules/actionbars/elements/stance.lua",
	"modules/actionbars/elements/vehicle.lua",
	"modules/actionbars/elements/xp.lua",
	"modules/actionbars/templates/floatbutton_template.lua",
	"modules/actionbars/templates/flyoutbar_template.lua",
	"modules/actionbars/templates/menubutton_template.lua",

	"modules/blizzard/altpower.lua",
	"modules/blizzard/character.lua",
	"modules/blizzard/containers.lua",
	"modules/blizzard/durability.lua",
	"modules/blizzard/fonts.lua",
	"modules/blizzard/gamemenu.lua",
	"modules/blizzard/ghostframe.lua",
	"modules/blizzard/levelup.lua",
	"modules/blizzard/merchant.lua",
	"modules/blizzard/mirrortimers.lua",
	"modules/blizzard/popups.lua",
	"modules/blizzard/styling.lua",
	"modules/blizzard/talkinghead.lua",
	"modules/blizzard/tooltips.lua",
	"modules/blizzard/totembar.lua",
	"modules/blizzard/tradeskill.lua",
	"modules/blizzard/vehicleseat.lua",

	"modules/chat/bubbles.lua",
	"modules/chat/filters.lua",
	"modules/chat/sounds.lua",
	"modules/chat/windows.lua",

	"modules/nameplates/nameplates.lua",

	"modules/objectives/alerts.lua",
	"modules/objectives/capturebars.lua",
	"modules/objectives/orderhall.lua",
	"modules/objectives/pvpemotes.lua",
	"modules/objectives/questtimers.lua",
	"modules/objectives/warnings.lua",
	"modules/objectives/worldstate.lua",
	"modules/objectives/zone.lua",

	"modules/tooltips/tooltips.lua",

	"modules/unitframes/controllers/controller_party.lua",
	"modules/unitframes/controllers/controller_raid.lua",
	"modules/unitframes/elements/altpower.lua",
	"modules/unitframes/elements/aura.lua",
	"modules/unitframes/elements/cast.lua",
	"modules/unitframes/elements/classification.lua",
	"modules/unitframes/elements/classpower.lua",
	"modules/unitframes/elements/combatfeedback.lua",
	"modules/unitframes/elements/happiness.lua",
	"modules/unitframes/elements/health.lua",
	"modules/unitframes/elements/name.lua",
	"modules/unitframes/elements/portraits.lua",
	"modules/unitframes/elements/power.lua",
	"modules/unitframes/elements/role.lua",
	"modules/unitframes/elements/runes.lua",
	"modules/unitframes/elements/threat.lua",
	"modules/unitframes/elements/weaponenchants.lua",
	"modules/unitframes/unitframes.lua",
	"modules/unitframes/units/arena.lua",
	"modules/unitframes/units/boss.lua",
	"modules/unitframes/units/focus.lua",
	"modules/unitframes/units/party.lua",
	"modules/unitframes/units/pet.lua",
	"modules/unitframes/units/player.lua",
	"modules/unitframes/units/raid.lua",
	"modules/unitframes/units/target.lua",
	"modules/unitframes/units/tot.lua",
}

TestAllModulesLoad = {}

-- One assertion per file (instead of one big loop inside a single
-- assertion) so a failure names the exact file and error, and one bad file
-- doesn't stop the rest from being checked.
for _, path in ipairs(FILES) do
	TestAllModulesLoad["test_loads__" .. path:gsub("[^%w]", "_")] = function()
		local chunk, loadErr = loadfile(path)
		lu.assertNotNil(chunk, path .. " failed to parse: " .. tostring(loadErr))

		local Engine = EngineMock.new()
		local ok, runErr = pcall(chunk, "DiabolicUI", Engine)
		lu.assertTrue(ok, path .. " errored while loading: " .. tostring(runErr))
	end
end

os.exit(lu.LuaUnit.run())
