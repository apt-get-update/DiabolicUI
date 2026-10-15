-- Run from the addon root: lua5.1 tests/test_actionbars_buttons.lua
--
-- Loads the *real* handlers/actionbutton.lua and
-- modules/actionbars/elements/artwork.lua and exercises two button updates:
--  - UpdateUsable: the icon's state (usable, out of range, out of mana,
--    unusable), which is only redrawn when it changes - except for the
--    "forced" refresh the handler sends once after login, when the client
--    may have failed to desaturate icons
--  - the artwork's PostUpdate: which border layers show for an empty,
--    normal or checked (active) button, hovered or not
--  - UpdateCooldown: the time left on the button, in minutes then seconds,
--    none for the global cooldown or with OmniCC on

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")
local WowApiMock = require("mocks.wow_api_mock")
local AutoStub = require("mocks.auto_stub")

local state = { dead = false }
_G.UnitIsDeadOrGhost = function() return state.dead end
WowApiMock.install()
AutoStub.install()

-- handlers/actionbutton.lua ------------------------------------------------

local function loadButtonPrototype()
	local Engine = EngineMock.new()
	assert(loadfile("handlers/actionbutton.lua"))("DiabolicUI", Engine)
	local Handler = Engine:GetHandler("ActionButton")
	-- the prototype every button's metatable points at, reached through
	-- Handler.New (it builds real secure frames, so it isn't called here)
	for i = 1, math.huge do
		local name, value = debug.getupvalue(Handler.New, i)
		if (not name) then
			break
		elseif (name == "Button_MT") then
			return value.__index
		end
	end
	error("Handler.New no longer uses Button_MT")
end

local function newButton(Button, usable, notEnoughMana, inRange)
	-- (the prototype is a stubbed frame here, which answers any field:
	-- the ones UpdateUsable checks are set explicitly)
	local button = setmetatable({ redraws = 0, OverrideUsable = false, outOfRange = false }, { __index = Button })
	button.icon = {
		SetDesaturated = function(self, flag) self.desaturated = flag; return true end,
		SetVertexColor = function(self, r, g, b) self.color = { r, g, b } end,
	}
	button.IsUsable = function() return usable, notEnoughMana end
	button.IsInRange = function() return inRange end
	button.PostUpdateUsable = function(self, usableState) self.redraws = self.redraws + 1; self.drawn = usableState end
	return button
end

TestButtonUsable = {}

function TestButtonUsable:setUp()
	state.dead = false
	self.Button = loadButtonPrototype()
end

function TestButtonUsable:test_states()
	local cases = {
		{ { true, nil, true }, "usable" },
		{ { true, nil, false }, "range" },
		{ { nil, 1, true }, "mana" }, -- the client reports "not enough mana" as not usable too
		{ { nil, nil, true }, "unusable" },
	}
	for _, case in ipairs(cases) do
		local button = newButton(self.Button, unpack(case[1]))
		button:UpdateUsable()
		lu.assertEquals(button.drawn, case[2])
	end

	state.dead = true
	local button = newButton(self.Button, true, nil, true)
	button:UpdateUsable()
	lu.assertEquals(button.drawn, "taxi")
end

function TestButtonUsable:test_unchanged_state_is_not_redrawn_unless_forced()
	local button = newButton(self.Button, true, nil, true)
	button:UpdateUsable()
	button:UpdateUsable()
	lu.assertEquals(button.redraws, 1)
	button:UpdateUsable("forced")
	lu.assertEquals(button.redraws, 2)
end

-- modules/actionbars/elements/artwork.lua ----------------------------------

local LAYERS = { "empty", "empty_highlight", "normal", "normal_highlight", "checked", "checked_highlight" }

local function newArtworkButton(Button, hasAction, checked, highlighted)
	local button = setmetatable({ _checked = checked, _highlighted = highlighted, border = {} }, { __index = Button })
	button.HasAction = function() return hasAction end
	for _, layer in ipairs(LAYERS) do
		button.border[layer] = { SetAlpha = function(self, alpha) self.alpha = alpha end }
	end
	return button
end

-- the border layers left visible
local function shown(button)
	local list = {}
	for _, layer in ipairs(LAYERS) do
		if (button.border[layer].alpha or 0) > 0 then
			list[#list + 1] = layer
		end
	end
	return table.concat(list, ",")
end

TestButtonArtwork = {}

function TestButtonArtwork:setUp()
	local Engine = EngineMock.new()
	local Module = Engine:NewModule("ActionBars")
	assert(loadfile("modules/actionbars/elements/artwork.lua"))("DiabolicUI", Engine)
	self.Button = Module:GetWidget("Artwork"):GetButtonTemplate()
end

function TestButtonArtwork:test_border_layers()
	local cases = {
		{ { false, nil, nil }, "empty" },
		{ { false, nil, true }, "empty_highlight" },
		{ { true, nil, nil }, "normal" },
		{ { true, nil, true }, "normal_highlight" },
		{ { true, true, nil }, "checked" },
		{ { true, true, true }, "checked_highlight" },
	}
	for _, case in ipairs(cases) do
		local button = newArtworkButton(self.Button, unpack(case[1]))
		button:PostUpdate()
		lu.assertEquals(shown(button), case[2])
	end
end

-- The cooldown's time left -------------------------------------------------

TestButtonCooldown = {}

function TestButtonCooldown:setUp()
	self.now, self.omniCC = 100, false
	_G.GetTime = function() return self.now end
	_G.IsAddOnLoaded = function(name) return (name == "OmniCC") and self.omniCC end
	local Button = loadButtonPrototype()
	local button = setmetatable({}, { __index = Button })
	local text = { SetText = function(t, value) t.text = value end }
	local cooldown = {
		count = text,
		SetCooldown = function() end,
		Show = function(c) c.shown = true end,
		Hide = function(c) c.shown = false; c.count:SetText(""); c.OnUpdate = nil end, -- (its OnHide)
		SetScript = function(c, _, func) c.OnUpdate = func end,
	}
	button.cooldown, self.text, self.cooldown = cooldown, text, cooldown
	self.button = button
	self.cooldownTimes = { 0, 0, 1 }
	button.GetCooldown = function() return unpack(self.cooldownTimes) end
end

function TestButtonCooldown:tick(seconds)
	self.now = self.now + seconds
	if self.cooldown.OnUpdate then
		self.cooldown:OnUpdate(seconds)
	end
end

function TestButtonCooldown:test_minutes_then_seconds()
	self.cooldownTimes = { 100, 150, 1 }
	self.button:UpdateCooldown()
	self:tick(0)
	lu.assertEquals(self.text.text, "3m")
	self:tick(30) -- 120 left
	lu.assertEquals(self.text.text, "2m")
	self:tick(61) -- 59 left
	lu.assertEquals(self.text.text, 59)
	self:tick(58.5)
	lu.assertEquals(self.text.text, 1)
	self:tick(1) -- done
	lu.assertEquals(self.text.text, "")
	lu.assertNil(self.cooldown.OnUpdate)
end

function TestButtonCooldown:test_hours()
	self.cooldownTimes = { 100, 2 * 3600, 1 }
	self.button:UpdateCooldown()
	self:tick(0)
	lu.assertEquals(self.text.text, "2h")
end

function TestButtonCooldown:test_written_ten_times_a_second()
	self.cooldownTimes = { 100, 150, 1 }
	self.button:UpdateCooldown()
	self:tick(0)
	self.text.text = nil
	self:tick(0.05)
	lu.assertNil(self.text.text)
	self:tick(0.05)
	lu.assertEquals(self.text.text, "3m")
end

function TestButtonCooldown:test_none_for_the_global_cooldown_or_with_omnicc()
	self.cooldownTimes = { 100, 1.5, 1 }
	self.button:UpdateCooldown()
	lu.assertTrue(self.cooldown.shown)
	lu.assertNil(self.cooldown.OnUpdate)
	self.omniCC = true
	self.cooldownTimes = { 100, 30, 1 }
	self.button:UpdateCooldown()
	lu.assertNil(self.cooldown.OnUpdate)
	-- and none once it's over
	self.omniCC = false
	self.button:UpdateCooldown()
	self.cooldownTimes = { 0, 0, 1 }
	self.button:UpdateCooldown()
	lu.assertFalse(self.cooldown.shown)
	lu.assertEquals(self.text.text, "")
end

os.exit(lu.LuaUnit.run())
