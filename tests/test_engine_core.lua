-- Run from the addon root: lua5.1 tests/test_engine_core.lua
--
-- Loads the *real* engine (locale/locale_handler.lua, locale/locale-enUS.lua
-- and engine/engine-core.lua) on a fake WoW frame API, then drives it the
-- way the client does, by firing events through the engine's own event
-- frame. Covers:
--  - module and handler registration (duplicates, reserved names, bad
--    load priorities, silent lookups) and widgets
--  - the startup sequence: every OnInit runs before any OnEnable, NORMAL
--    and HIGH modules enable on ADDON_LOADED + VARIABLES_LOADED, LOW ones
--    only on PLAYER_LOGIN
--  - SetIncompatible / SetDependency gating OnInit and OnEnable
--  - event and message dispatch (only to enabled objects, no duplicate
--    registrations, unregistering the frame event once nobody listens)
--  - Engine:Wrap deferring calls made in combat until PLAYER_REGEN_ENABLED
--  - saved config profiles: NewConfig, GetConfig and ParseSavedVariables
--  - static configs, private configs, IsAddOnEnabled and the write guard
--
-- The engine keeps all its state in file-local registries, so every test
-- loads a fresh copy of it (see setUp).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local FrameMock = require("mocks.frame_mock")

-- WoW's own string.join, which plain Lua 5.1 doesn't have. The engine
-- captures it at load time for its argument check error messages.
string.join = string.join or function(sep, ...)
	return table.concat({ ... }, sep)
end

-- Fake game state, read by the mocked WoW API below. Tests edit it in place.
local state

local Engine, frames

-- The engine's event frame is the first frame it creates.
local function fire(event, ...)
	frames.created[1]:Fire("OnEvent", event, ...)
end

local function loadEngine()
	state = {
		inCombat = false,
		lockdown = false,
		loggedIn = false,
		addons = {},
	}
	frames = FrameMock.new()

	_G.CreateFrame = frames.CreateFrame
	_G.UIParent = FrameMock.newFrame("Frame", "UIParent")
	_G.UIParent:SetSize(1920, 1080)
	_G.WorldFrame = FrameMock.newFrame("Frame", "WorldFrame")
	_G.WorldFrame:SetSize(1920, 1080)

	_G.GetLocale = function() return "enUS" end
	_G.GetRealmName = function() return "Realm" end
	_G.UnitName = function() return "Me" end
	_G.UnitFactionGroup = function() return "Horde" end
	_G.UnitAffectingCombat = function() return state.inCombat end
	_G.InCombatLockdown = function() return state.lockdown end
	_G.IsLoggedIn = function() return state.loggedIn end
	_G.GetCVarBool = function() return false end
	_G.debugstack = function() return ": in function `Test'" end
	_G.GetNumAddOns = function() return #state.addons end
	_G.GetAddOnInfo = function(index)
		local addon = state.addons[index]
		return addon.name, addon.name, "", addon.enabled, addon.loadable, addon.reason
	end

	Engine = {}
	for _, path in ipairs({ "locale/locale_handler.lua", "locale/locale-enUS.lua", "engine/engine-core.lua" }) do
		local chunk = assert(loadfile(path))
		chunk("DiabolicUI", Engine)
	end
end

-- The handlers Engine.Init looks up by name while starting up.
local function addStartupHandlers()
	Engine:NewHandler("Orb")
	Engine:NewHandler("StatusBar")
	local ChatCommand = Engine:NewHandler("ChatCommand")
	ChatCommand.commands = {}
	ChatCommand.Register = function(self, name, func) self.commands[name] = func end
end

-- ADDON_LOADED and VARIABLES_LOADED, in either order, start the engine.
local function startUp()
	fire("ADDON_LOADED", "DiabolicUI")
	fire("VARIABLES_LOADED")
end

local function addAddOn(name, enabled, reason)
	table.insert(state.addons, { name = name, enabled = enabled, loadable = enabled, reason = reason })
end

------------------------------------------------------------------------
-- Modules, handlers and widgets
------------------------------------------------------------------------

TestEngineRegistry = {}

function TestEngineRegistry:setUp()
	loadEngine()
end

function TestEngineRegistry:test_new_module_is_returned_by_get_module()
	local module = Engine:NewModule("Foo")
	lu.assertIs(Engine:GetModule("Foo"), module)
	lu.assertEquals(tostring(module), "Foo")
end

function TestEngineRegistry:test_get_module_errors_unless_silent()
	lu.assertErrorMsgContains("No module named 'Missing' exist", Engine.GetModule, Engine, "Missing")
	lu.assertNil(Engine:GetModule("Missing", true))
end

function TestEngineRegistry:test_duplicate_module_name_errors()
	Engine:NewModule("Foo")
	lu.assertErrorMsgContains("A module named 'Foo' already exists", Engine.NewModule, Engine, "Foo")
end

function TestEngineRegistry:test_module_cant_take_a_handler_name()
	Engine:NewHandler("Shared")
	lu.assertErrorMsgContains("reserved for a handler", Engine.NewModule, Engine, "Shared")
end

function TestEngineRegistry:test_invalid_load_priority_errors()
	lu.assertErrorMsgContains("The load priority 'URGENT' is invalid", Engine.NewModule, Engine, "Foo", "URGENT")
end

function TestEngineRegistry:test_argument_check_names_the_expected_type()
	lu.assertErrorMsgContains("string expected, got number", Engine.NewModule, Engine, 42)
end

function TestEngineRegistry:test_duplicate_handler_name_errors()
	Engine:NewHandler("Bar")
	lu.assertErrorMsgContains("A handler named 'Bar' is already registered", Engine.NewHandler, Engine, "Bar")
	lu.assertIs(Engine:GetHandler("Bar"), Engine:GetHandler("Bar", true))
	lu.assertNil(Engine:GetHandler("Missing", true))
end

function TestEngineRegistry:test_widgets_belong_to_their_module()
	local module = Engine:NewModule("Foo")
	local widget = module:SetWidget("Bar: One")
	lu.assertIs(module:GetWidget("Bar: One"), widget)
	lu.assertNil(Engine:NewModule("Other"):GetWidget("Bar: One"))
	lu.assertErrorMsgContains("The widget 'Bar: One' is already registered", module.SetWidget, module, "Bar: One")
end

function TestEngineRegistry:test_handler_elements()
	local handler = Engine:NewHandler("Bar")
	local element = handler:SetElement("Health")
	lu.assertIs(handler:GetElement("Health"), element)
	lu.assertErrorMsgContains("The element 'Health' is already registered", handler.SetElement, handler, "Health")
end

function TestEngineRegistry:test_engine_is_write_protected()
	lu.assertErrorMsgContains("The Engine can't be tampered with", function() Engine.Injected = true end)
end

------------------------------------------------------------------------
-- Startup sequence
------------------------------------------------------------------------

TestEngineStartup = {}

function TestEngineStartup:setUp()
	loadEngine()
	addStartupHandlers()
end

-- Records OnInit/OnEnable calls of several modules into one shared log.
local function trackedModule(log, name, priority)
	local module = Engine:NewModule(name, priority)
	module.OnInit = function() table.insert(log, name .. ":init") end
	module.OnEnable = function() table.insert(log, name .. ":enable") end
	return module
end

function TestEngineStartup:test_every_module_initializes_before_any_enables()
	local log = {}
	trackedModule(log, "A")
	trackedModule(log, "B", "HIGH")
	trackedModule(log, "C")
	startUp()

	lu.assertEquals(#log, 6)
	for i = 1, 3 do
		lu.assertStrContains(log[i], ":init")
	end
	for i = 4, 6 do
		lu.assertStrContains(log[i], ":enable")
	end
	-- HIGH priority modules go first within each phase.
	lu.assertEquals(log[1], "B:init")
	lu.assertEquals(log[4], "B:enable")
end

function TestEngineStartup:test_either_loading_event_order_works()
	local log = {}
	trackedModule(log, "A")
	fire("VARIABLES_LOADED")
	lu.assertEquals(log, {})
	fire("ADDON_LOADED", "SomeOtherAddon")
	lu.assertEquals(log, {})
	fire("ADDON_LOADED", "DiabolicUI")
	lu.assertEquals(log, { "A:init", "A:enable" })
end

function TestEngineStartup:test_low_priority_modules_wait_for_player_login()
	local log = {}
	trackedModule(log, "Late", "LOW")
	startUp()
	lu.assertEquals(log, { "Late:init" })
	lu.assertFalse(Engine:GetModule("Late"):IsEnabled() or false)

	fire("PLAYER_LOGIN")
	lu.assertEquals(log, { "Late:init", "Late:enable" })
	lu.assertTrue(Engine:GetModule("Late"):IsEnabled())
	lu.assertTrue(Engine:IsEnabled())
end

function TestEngineStartup:test_already_logged_in_enables_everything_at_once()
	-- A /reload: the player is already in the world when the variables load.
	state.loggedIn = true
	local log = {}
	trackedModule(log, "Late", "LOW")
	startUp()
	lu.assertEquals(log, { "Late:init", "Late:enable" })
end

function TestEngineStartup:test_handlers_are_enabled_before_modules()
	local handler = Engine:NewHandler("Early")
	local seen
	handler.OnEnable = function() seen = "handler" end
	Engine:NewModule("A").OnInit = function() seen = seen and (seen .. "+module") end
	startUp()
	lu.assertEquals(seen, "handler+module")
end

function TestEngineStartup:test_enable_and_disable_run_only_once()
	local count = 0
	local module = Engine:NewModule("A")
	module.OnEnable = function() count = count + 1 end
	module.OnDisable = function() count = count - 10 end
	startUp()
	module:Enable()
	lu.assertEquals(count, 1)
	module:Disable()
	module:Disable()
	lu.assertEquals(count, -9)
	lu.assertFalse(module:IsEnabled())
end

function TestEngineStartup:test_incompatible_module_never_runs()
	addAddOn("Prat-3.0", true)
	local log = {}
	trackedModule(log, "ChatWindows"):SetIncompatible("Prat-3.0")
	trackedModule(log, "Other")
	startUp()
	lu.assertEquals(log, { "Other:init", "Other:enable" })
end

function TestEngineStartup:test_incompatibility_needs_the_addon_enabled()
	addAddOn("Prat-3.0", false)
	addAddOn("NiceBubbles", true, "DISABLED")
	local log = {}
	trackedModule(log, "A"):SetIncompatible("Prat-3.0", "NiceBubbles")
	startUp()
	lu.assertEquals(log, { "A:init", "A:enable" })
end

function TestEngineStartup:test_incompatibility_condition_function_decides()
	addAddOn("Questie", true)
	local log = {}
	local module = trackedModule(log, "A")
	module:SetIncompatible("Questie", function() return false end)
	startUp()
	lu.assertEquals(log, { "A:init", "A:enable" })
end

function TestEngineStartup:test_missing_dependency_blocks_the_module()
	local log = {}
	trackedModule(log, "A"):SetDependency("Masque")
	startUp()
	lu.assertEquals(log, {})

	loadEngine()
	addStartupHandlers()
	addAddOn("masque", true) -- lookups are case-insensitive
	log = {}
	trackedModule(log, "A"):SetDependency("Masque")
	startUp()
	lu.assertEquals(log, { "A:init", "A:enable" })
end

------------------------------------------------------------------------
-- Events and messages
------------------------------------------------------------------------

TestEngineEvents = {}

function TestEngineEvents:setUp()
	loadEngine()
	addStartupHandlers()
end

function TestEngineEvents:test_events_reach_enabled_modules_only()
	local received = {}
	local module = Engine:NewModule("A")
	module.OnBagUpdate = function(self, event, bag) table.insert(received, { event, bag }) end
	module:RegisterEvent("BAG_UPDATE", "OnBagUpdate")

	fire("BAG_UPDATE", 1)
	lu.assertEquals(received, {})

	startUp()
	fire("BAG_UPDATE", 2)
	lu.assertEquals(received, { { "BAG_UPDATE", 2 } })
end

function TestEngineEvents:test_default_handler_calls_method_named_after_event()
	local received = {}
	local module = Engine:NewModule("A")
	module.PLAYER_TARGET_CHANGED = function(self, event) table.insert(received, event) end
	module.OnEvent = function(self, event) table.insert(received, "OnEvent:" .. event) end
	module:RegisterEvent("PLAYER_TARGET_CHANGED")
	module:RegisterEvent("PLAYER_FOCUS_CHANGED")
	startUp()

	fire("PLAYER_TARGET_CHANGED")
	fire("PLAYER_FOCUS_CHANGED")
	lu.assertEquals(received, { "PLAYER_TARGET_CHANGED", "OnEvent:PLAYER_FOCUS_CHANGED" })
end

function TestEngineEvents:test_function_callbacks_and_no_duplicates()
	local count = 0
	local callback = function() count = count + 1 end
	local module = Engine:NewModule("A")
	module:RegisterEvent("UNIT_HEALTH", callback)
	module:RegisterEvent("UNIT_HEALTH", callback)
	lu.assertTrue(module:IsEventRegistered("UNIT_HEALTH", callback))
	startUp()
	fire("UNIT_HEALTH", "player")
	lu.assertEquals(count, 1)
end

function TestEngineEvents:test_widgets_receive_events_with_their_module()
	local received = 0
	local module = Engine:NewModule("A")
	local widget = module:SetWidget("Bar: One")
	widget:RegisterEvent("UPDATE_BINDINGS", function() received = received + 1 end)
	startUp()
	fire("UPDATE_BINDINGS")
	lu.assertEquals(received, 1)
end

function TestEngineEvents:test_frame_event_is_dropped_when_last_listener_leaves()
	local eventFrame = frames.created[1]
	local a, b = Engine:NewModule("A"), Engine:NewModule("B")
	a:RegisterEvent("UNIT_AURA", "OnAura")
	b:RegisterEvent("UNIT_AURA", "OnAura")
	lu.assertTrue(eventFrame:IsEventRegistered("UNIT_AURA"))

	a:UnregisterEvent("UNIT_AURA", "OnAura")
	lu.assertTrue(eventFrame:IsEventRegistered("UNIT_AURA"))
	b:UnregisterEvent("UNIT_AURA", "OnAura")
	lu.assertFalse(eventFrame:IsEventRegistered("UNIT_AURA"))
	lu.assertFalse(a:IsEventRegistered("UNIT_AURA", "OnAura"))
end

function TestEngineEvents:test_unregistering_unknown_event_errors()
	local module = Engine:NewModule("A")
	lu.assertErrorMsgContains("isn't currently registered to any object", module.UnregisterEvent, module, "NEVER_REGISTERED")
	module:RegisterEvent("UNIT_AURA", "OnAura")
	lu.assertErrorMsgContains("The method named 'Other' isn't registered", module.UnregisterEvent, module, "UNIT_AURA", "Other")
end

function TestEngineEvents:test_missing_method_is_reported()
	local module = Engine:NewModule("A")
	module:RegisterEvent("UNIT_AURA", "DoesNotExist")
	startUp()
	lu.assertErrorMsgContains("has no method named 'DoesNotExist'", fire, "UNIT_AURA")
end

function TestEngineEvents:test_messages()
	local received = {}
	local module = Engine:NewModule("A")
	module.OnConfig = function(self, message, value) table.insert(received, value) end
	module:RegisterMessage("DIABOLICUI_CONFIG_CHANGED", "OnConfig")
	lu.assertTrue(module:IsMessageRegistered("DIABOLICUI_CONFIG_CHANGED", "OnConfig"))
	startUp()

	Engine:Fire("DIABOLICUI_CONFIG_CHANGED", 1)
	module:SendMessage("DIABOLICUI_CONFIG_CHANGED", 2)
	module:UnregisterMessage("DIABOLICUI_CONFIG_CHANGED", "OnConfig")
	Engine:Fire("DIABOLICUI_CONFIG_CHANGED", 3)
	lu.assertEquals(received, { 1, 2 })
	lu.assertFalse(module:IsMessageRegistered("DIABOLICUI_CONFIG_CHANGED", "OnConfig"))
end

function TestEngineEvents:test_loading_screen_tracking()
	lu.assertFalse(Engine:IsInWorld())
	lu.assertFalse(Engine:IsOffWorld())
	fire("PLAYER_ENTERING_WORLD")
	lu.assertTrue(Engine:IsInWorld())
	fire("PLAYER_LEAVING_WORLD")
	lu.assertTrue(Engine:IsOffWorld())
end

------------------------------------------------------------------------
-- Combat-safe calls (Engine:Wrap)
------------------------------------------------------------------------

TestEngineWrap = {}

function TestEngineWrap:setUp()
	loadEngine()
end

function TestEngineWrap:test_runs_immediately_out_of_combat()
	local calls = {}
	local wrapped = Engine:Wrap(function(...) table.insert(calls, { ... }) end)
	wrapped(1, 2)
	lu.assertEquals(calls, { { 1, 2 } })
end

function TestEngineWrap:test_combat_calls_are_deferred_and_merged()
	local calls = {}
	local wrapped = Engine:Wrap(function(...) table.insert(calls, { ... }) end)

	fire("PLAYER_REGEN_DISABLED")
	state.lockdown = true
	wrapped("first")
	wrapped("second")
	lu.assertEquals(calls, {})

	state.lockdown = false
	fire("PLAYER_REGEN_ENABLED")
	-- Only the latest arguments survive, and the call runs once.
	lu.assertEquals(calls, { { "second" } })

	wrapped("after")
	lu.assertEquals(calls, { { "second" }, { "after" } })
end

function TestEngineWrap:test_runs_when_lockdown_already_lifted()
	-- PLAYER_REGEN_DISABLED fired, but the lockdown ended before
	-- PLAYER_REGEN_ENABLED did: no reason to wait.
	local calls = 0
	local wrapped = Engine:Wrap(function() calls = calls + 1 end)
	fire("PLAYER_REGEN_DISABLED")
	wrapped()
	lu.assertEquals(calls, 1)
end

function TestEngineWrap:test_module_enable_waits_for_combat_end()
	addStartupHandlers()
	local enabled = false
	local module = Engine:NewModule("A")
	module.OnEnable = function() enabled = true end
	fire("PLAYER_REGEN_DISABLED")
	state.lockdown = true
	module:Enable()
	lu.assertFalse(enabled)
	state.lockdown = false
	fire("PLAYER_REGEN_ENABLED")
	lu.assertTrue(enabled)
end

------------------------------------------------------------------------
-- Configs
------------------------------------------------------------------------

TestEngineConfig = {}

function TestEngineConfig:setUp()
	loadEngine()
	addStartupHandlers()
end

function TestEngineConfig:test_new_config_creates_every_profile_from_defaults()
	Engine:NewConfig("Foo", { size = 10, colors = { r = 1 } })
	for _, profile in ipairs({ "realm", "character", "faction" }) do
		lu.assertEquals(Engine:GetConfig("Foo", profile), { size = 10, colors = { r = 1 } })
	end
	local global = Engine:GetConfig("Foo")
	lu.assertEquals(global, { size = 10, colors = { r = 1 } })

	-- Every profile is its own deep copy.
	global.colors.r = 0
	lu.assertEquals(Engine:GetConfig("Foo", "realm").colors.r, 1)
end

function TestEngineConfig:test_config_errors()
	Engine:NewConfig("Foo", {})
	lu.assertErrorMsgContains("The config 'Foo' already exists", Engine.NewConfig, Engine, "Foo", {})
	lu.assertErrorMsgContains("The config 'Missing' doesn't exist", Engine.GetConfig, Engine, "Missing")
	lu.assertNil(Engine:GetConfig("Missing", nil, nil, true))
	lu.assertErrorMsgContains("doesn't have a profile named 'account'", Engine.GetConfig, Engine, "Foo", "account")
end

function TestEngineConfig:test_saved_values_are_merged_over_defaults()
	Engine:NewConfig("Foo", { size = 10, shown = true, nested = { a = 1, b = 2 } })
	_G.DiabolicUI_DB = {
		Foo = { profiles = {
			global = { size = 20, nested = { b = 3 } },
			character = { ["Me-Realm"] = { shown = false } },
			realm = { Realm = { size = 30 } },
			faction = { Horde = { size = 40 } },
		} },
		-- a config no module registers any more is left alone
		Gone = { profiles = { global = { x = 1 } } },
	}
	startUp()

	lu.assertEquals(Engine:GetConfig("Foo"), { size = 20, shown = true, nested = { a = 1, b = 3 } })
	lu.assertEquals(Engine:GetConfig("Foo", "character").shown, false)
	lu.assertEquals(Engine:GetConfig("Foo", "realm").size, 30)
	lu.assertEquals(Engine:GetConfig("Foo", "faction").size, 40)

	lu.assertEquals(_G.DiabolicUI_DB.Gone, { profiles = { global = { x = 1 } } })
	-- The saved variable now points at the live profiles, so changes
	-- made while playing are what gets written on logout.
	Engine:GetConfig("Foo").size = 99
	lu.assertEquals(_G.DiabolicUI_DB.Foo.profiles.global.size, 99)
end

function TestEngineConfig:test_first_run_saves_every_config()
	Engine:NewConfig("Foo", { size = 10 })
	startUp()
	lu.assertEquals(_G.DiabolicUI_DB.Foo.profiles.global, { size = 10 })
	lu.assertNotNil(_G.DiabolicUI_DB.ScreenScaling)
end

function TestEngineConfig:test_static_configs_are_copied()
	local source = { width = 100 }
	Engine:NewStaticConfig("Layout", source)
	source.width = 5
	lu.assertEquals(Engine:GetDB("Layout"), { width = 100 })
	lu.assertErrorMsgContains("The static config 'Layout' already exists", Engine.NewStaticConfig, Engine, "Layout", {})
	lu.assertErrorMsgContains("The static config 'Missing' doesn't exist", Engine.GetDB, Engine, "Missing")
end

function TestEngineConfig:test_private_configs_are_engine_only()
	Engine:NewStaticConfig("Data: Constants", { A = 1 }, true)
	lu.assertEquals(Engine:GetConstant("A"), 1)
	Engine:SetConstant("A", 2) -- existing constants can't be replaced
	Engine:SetConstant("B", 3)
	lu.assertEquals(Engine:GetConstant("A"), 1)
	lu.assertEquals(Engine:GetConstant("B"), 3)

	local module = Engine:NewModule("A")
	lu.assertErrorMsgContains("Only the Engine can access private configs", module.GetDB, module, "Data: Constants", true)
	-- and a private config isn't visible as a public one
	lu.assertErrorMsgContains("doesn't exist", module.GetDB, module, "Data: Constants")
end

------------------------------------------------------------------------
-- Addon listing
------------------------------------------------------------------------

TestEngineAddOns = {}

function TestEngineAddOns:setUp()
	loadEngine()
end

function TestEngineAddOns:test_is_addon_enabled()
	addAddOn("Questie", true)
	addAddOn("Bagnon", true, "DEP_DISABLED")
	addAddOn("Recount", false)
	lu.assertTrue(Engine:IsAddOnEnabled("questie"))
	lu.assertNil(Engine:IsAddOnEnabled("Bagnon"))
	lu.assertNil(Engine:IsAddOnEnabled("Recount"))
	lu.assertNil(Engine:IsAddOnEnabled("NotInstalled"))
end

function TestEngineAddOns:test_is_addon_loadable()
	addAddOn("Blizzard_TalentUI", false)
	state.addons[1].loadable = true
	addAddOn("Broken", false, "DISABLED")
	state.addons[2].loadable = true
	lu.assertTrue(Engine:IsAddOnLoadable("Blizzard_TalentUI"))
	lu.assertNil(Engine:IsAddOnLoadable("Broken"))
end

os.exit(lu.LuaUnit.run())
