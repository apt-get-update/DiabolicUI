-- Run from the addon root: lua5.1 tests/test_actionbars_combat.lua
--
-- Combat lockdown: secure frames (action buttons, bars with state drivers)
-- can't be changed in combat, so these changes wait for the end of combat
-- (PLAYER_REGEN_ENABLED) and then run once. Loads the *real* files:
--  - handlers/actionbutton.lua: the "cast on key down" setting changing
--    (CVAR_UPDATE) re-registers every button's clicks, after combat
--  - modules/actionbars/elements/pet.lua: the pet bar's visibility driver
--    and position
--  - modules/actionbars/elements/stance.lua: the stance bar's visibility
--    driver when the number of forms changes
-- For each: nothing secure is touched in combat, the work happens when
-- combat ends, and the end-of-combat event is let go again afterwards.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")
local WowApiMock = require("mocks.wow_api_mock")
local AutoStub = require("mocks.auto_stub")

local state -- scripted game state
local drivers -- every (Un)RegisterStateDriver call, in order

local function resetState()
	state = { lockdown = false, castOnDown = false, forms = 0 }
	drivers = {}
end
resetState()

-- Real functions first: files keep some of them as upvalues at load time.
_G.InCombatLockdown = function() return state.lockdown end
_G.GetCVarBool = function(name)
	if (name == "ActionButtonUseKeyDown") then
		return state.castOnDown
	end
end
_G.RegisterStateDriver = function(frame, attribute, value)
	drivers[#drivers + 1] = { "register", attribute, value }
end
_G.UnregisterStateDriver = function(frame, attribute)
	drivers[#drivers + 1] = { "unregister", attribute }
end
_G.GetNumShapeshiftForms = function() return state.forms end
_G.UnitLevel = function() return 80 end
WowApiMock.install()
AutoStub.install()

-- The event (un)registrations a handler or widget makes, as
-- "EVENT -> method" strings.
local function trackEvents(object)
	object.events = {}
	object.RegisterEvent = function(self, event, method)
		self.events[event] = method
	end
	object.UnregisterEvent = function(self, event, method)
		if (self.events[event] == method) then
			self.events[event] = nil
		end
	end
	return object
end

local function endCombat(object)
	state.lockdown = false
	local method = object.events.PLAYER_REGEN_ENABLED
	lu.assertNotNil(method, "nothing waits for the end of combat")
	object[method](object, "PLAYER_REGEN_ENABLED")
end

-- handlers/actionbutton.lua ------------------------------------------------

TestActionButtonClicksInCombat = {}

function TestActionButtonClicksInCombat:setUp()
	resetState()
	local Engine = EngineMock.new()
	assert(loadfile("handlers/actionbutton.lua"))("DiabolicUI", Engine)
	self.Handler = trackEvents(Engine:GetHandler("ActionButton"))

	-- The buttons live in a private registry that Handler.New fills (it
	-- builds real secure frames); reach it through Handler.OnEvent instead.
	local registry
	for i = 1, math.huge do
		local name, value = debug.getupvalue(self.Handler.OnEvent, i)
		if (not name) then
			break
		elseif (name == "ButtonRegistry") then
			registry = value
		end
	end
	assert(registry, "Handler.OnEvent no longer reads ButtonRegistry")
	self.buttons = {}
	for i = 1, 2 do
		local button = {
			RegisterForClicks = function(self, clicks) self.clicks = clicks end,
		}
		registry[button] = true
		self.buttons[i] = button
	end
end

function TestActionButtonClicksInCombat:test_applies_at_once_out_of_combat()
	state.castOnDown = true
	self.Handler:OnEvent("CVAR_UPDATE", "ACTION_BUTTON_USE_KEY_DOWN")
	for _, button in ipairs(self.buttons) do
		lu.assertEquals(button.clicks, "AnyDown")
	end
	lu.assertNil(self.Handler.events.PLAYER_REGEN_ENABLED)
end

function TestActionButtonClicksInCombat:test_waits_for_the_end_of_combat()
	state.lockdown = true
	state.castOnDown = true
	self.Handler:OnEvent("CVAR_UPDATE", "ACTION_BUTTON_USE_KEY_DOWN")
	for _, button in ipairs(self.buttons) do
		lu.assertNil(button.clicks) -- secure buttons untouched in combat
	end

	endCombat(self.Handler)
	for _, button in ipairs(self.buttons) do
		lu.assertEquals(button.clicks, "AnyDown")
	end
	lu.assertNil(self.Handler.events.PLAYER_REGEN_ENABLED)
end

function TestActionButtonClicksInCombat:test_other_settings_are_ignored()
	self.Handler:OnEvent("CVAR_UPDATE", "SOME_OTHER_SETTING")
	lu.assertNil(self.buttons[1].clicks)
end

-- modules/actionbars/elements/pet.lua ------------------------------------

TestPetBarInCombat = {}

function TestPetBarInCombat:setUp()
	resetState()
	local Engine = EngineMock.new()
	local Module = Engine:NewModule("ActionBars")
	Module.config = { structure = { bars = { pet = {
		position = { "BOTTOM", 0, 100 },
		positionXP = { "BOTTOM", 0, 120 },
	} } } }
	Module.IsXPVisible = function() return false end
	Module.IsReputationVisible = function() return false end
	assert(loadfile("modules/actionbars/elements/pet.lua"))("DiabolicUI", Engine)
	self.Widget = trackEvents(Module:GetWidget("Bar: Pet"))
	self.Widget.Bar = {
		Place = function(self, ...) self.place = { ... } end,
	}
end

function TestPetBarInCombat:test_visibility_waits_for_the_end_of_combat()
	state.lockdown = true
	self.Widget:UpdateVisibility()
	lu.assertEquals(drivers, {})

	endCombat(self.Widget)
	lu.assertEquals(drivers[#drivers][1], "register")
	lu.assertEquals(drivers[#drivers][2], "vis")
	lu.assertNil(self.Widget.events.PLAYER_REGEN_ENABLED)
end

function TestPetBarInCombat:test_position_waits_for_the_end_of_combat()
	state.lockdown = true
	self.Widget:UpdatePosition()
	lu.assertNil(self.Widget.Bar.place)

	endCombat(self.Widget)
	lu.assertEquals(self.Widget.Bar.place, { "BOTTOM", 0, 100 })
	lu.assertNil(self.Widget.events.PLAYER_REGEN_ENABLED)
end

-- modules/actionbars/elements/stance.lua ---------------------------------

TestStanceBarInCombat = {}

function TestStanceBarInCombat:setUp()
	resetState()
	local Engine = EngineMock.new()
	local Module = Engine:NewModule("ActionBars")
	assert(loadfile("modules/actionbars/elements/stance.lua"))("DiabolicUI", Engine)
	self.Widget = trackEvents(Module:GetWidget("Bar: Stance"))
	self.Widget.Bar = { numForms = 0 }
end

function TestStanceBarInCombat:test_new_forms_wait_for_the_end_of_combat()
	state.lockdown = true
	state.forms = 3 -- learned a form in combat
	self.Widget:UpdateStanceButton()
	lu.assertEquals(drivers, {})
	lu.assertEquals(self.Widget.Bar.numForms, 0)

	endCombat(self.Widget)
	lu.assertEquals(drivers[#drivers], { "register", "visibility", "[bonusbar:5][vehicleui]hide;show" })
	lu.assertEquals(self.Widget.Bar.numForms, 3)
	lu.assertNil(self.Widget.events.PLAYER_REGEN_ENABLED)
end

function TestStanceBarInCombat:test_no_forms_hides_the_bar()
	self.Widget.Bar.numForms = 2
	state.forms = 0
	self.Widget:UpdateStanceButton()
	lu.assertEquals(drivers[#drivers], { "register", "visibility", "hide" })
end

os.exit(lu.LuaUnit.run())
