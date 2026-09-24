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

-- Every module/handler file the addon ships, found on disk so a new file
-- is covered without editing this test. Each file gets its own isolated
-- Engine mock, so the order doesn't matter here (test_addon_loads.lua
-- checks the real load order). The embedded minimap module doesn't use the
-- Engine at all and is covered by test_addon_loads.lua instead.
local FILES = {}
local pipe = assert(io.popen("find handlers modules -name '*.lua' -not -path 'modules/minimap/*' | sort"))
for path in pipe:lines() do
	FILES[#FILES + 1] = path
end
pipe:close()
assert(#FILES > 0, "run this from the addon root")

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
