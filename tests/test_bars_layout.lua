-- Run from the addon root: lua5.1 tests/test_bars_layout.lua
--
-- Loads the *real* handlers/statusbar.lua and handlers/orb.lua (every
-- health, power and cast bar, and the big globes) on fake frames that count
-- the calls made on them. The bar itself must only be laid out again when
-- something it shows changed
-- (the value, the range, the size, the texture or the crop), since laying
-- out textures every frame on dozens of bars costs framerate.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- Fake frames and textures: sizes, alpha, shown state and scripts behave;
-- any other method (capitalized, like the real API) just counts its calls.
local Methods = {}
local Fake = {
	__index = function(object, key)
		if Methods[key] then
			return Methods[key]
		elseif type(key) == "string" and key:match("^%u") then
			return function(self)
				self.calls[key] = (self.calls[key] or 0) + 1
			end
		end
	end,
}

local function newFake()
	return setmetatable({ calls = {}, width = 0, height = 0, alpha = 1, shown = true, scripts = {} }, Fake)
end

function Methods:SetSize(width, height) self.width, self.height = width, height end
function Methods:SetWidth(width) self.width = width end
function Methods:SetHeight(height) self.height = height end
function Methods:GetSize() return self.width, self.height end
function Methods:GetWidth() return self.width end
function Methods:GetHeight() return self.height end
function Methods:SetAlpha(alpha) self.alpha = alpha end
function Methods:GetAlpha() return self.alpha end
function Methods:Show() self.shown = true end
function Methods:Hide() self.shown = false end
function Methods:IsShown() return self.shown end
function Methods:SetScript(script, func) self.scripts[script] = func end
function Methods:GetScript(script) return self.scripts[script] end
function Methods:GetFrameLevel() return 1 end
function Methods:CreateTexture() return newFake() end
function Methods:CreateAnimationGroup() return newFake() end
function Methods:CreateAnimation() return newFake() end
function Methods:SetTexCoord(...)
	self.calls.SetTexCoord = (self.calls.SetTexCoord or 0) + 1
end

-- Without a parent: a widget prototype (the handlers' method tables). Its
-- frame methods answer nothing (an unplaced frame has no GetTop), and it
-- must not answer for fields it doesn't have.
local Prototype = {
	__index = function(_, key)
		if type(key) == "string" and key:match("^%u") then
			return function() end
		end
	end,
}
_G.CreateFrame = function(frameType, name, parent)
	if (not parent) then
		return setmetatable({}, Prototype)
	end
	return newFake()
end

local function loadHandler(path, name)
	local Engine = EngineMock.new()
	Engine.CreateFrame = function(self, ...) return _G.CreateFrame(...) end
	assert(loadfile(path))("DiabolicUI", Engine)
	return Engine:GetHandler(name)
end

local function count(object, method)
	return object.calls[method] or 0
end

-- handlers/statusbar.lua ---------------------------------------------------

TestStatusBarLayout = {}

function TestStatusBarLayout:setUp()
	local Handler = loadHandler("handlers/statusbar.lua", "StatusBar")
	local bar = Handler:New(newFake())
	bar:DisableSmoothing(true)
	bar:SetSize(100, 10)
	bar:SetMinMaxValues(0, 100)
	bar:SetValue(50)
	self.bar = bar
	self.laidOut = count(bar.bar, "SetTexCoord")
end

function TestStatusBarLayout:test_updating_again_is_not_laid_out()
	local bar = self.bar
	for _ = 1, 10 do
		bar:Update()
	end
	lu.assertEquals(count(bar.bar, "SetTexCoord"), self.laidOut)
end

function TestStatusBarLayout:test_same_value_again_is_not_laid_out()
	self.bar:SetValue(50)
	lu.assertEquals(count(self.bar.bar, "SetTexCoord"), self.laidOut)
end

function TestStatusBarLayout:test_changes_are_laid_out()
	local bar = self.bar
	bar:SetValue(60)
	lu.assertEquals(count(bar.bar, "SetTexCoord"), self.laidOut + 1)
	bar:SetSize(200, 10)
	lu.assertEquals(count(bar.bar, "SetTexCoord"), self.laidOut + 2)
	bar:SetMinMaxValues(0, 200)
	lu.assertEquals(count(bar.bar, "SetTexCoord"), self.laidOut + 3)
	bar:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
	lu.assertEquals(count(bar.bar, "SetTexCoord"), self.laidOut + 4)
end

function TestStatusBarLayout:test_laid_out_again_after_being_empty()
	local bar = self.bar
	bar:SetValue(0)
	lu.assertFalse(bar.bar.shown)
	bar:SetValue(50) -- same value as before it emptied
	lu.assertTrue(bar.bar.shown)
	lu.assertEquals(count(bar.bar, "SetTexCoord"), self.laidOut + 1)
end

-- handlers/orb.lua ---------------------------------------------------------

TestOrbLayout = {}

function TestOrbLayout:setUp()
	local Handler = loadHandler("handlers/orb.lua", "Orb")
	local orb = Handler:New(newFake())
	orb:DisableSmoothing(true)
	orb:SetSize(100, 100)
	orb:SetMinMaxValues(0, 100)
	orb:SetValue(50)
	self.orb = orb
	self.laidOut = count(orb.scrollframe, "SetVerticalScroll")
	self.sparkPlaced = count(orb.overlay.spark, "SetTexCoord")
end

function TestOrbLayout:test_updating_again_is_not_placed()
	local orb = self.orb
	for _ = 1, 10 do
		orb:Update()
	end
	lu.assertEquals(count(orb.scrollframe, "SetVerticalScroll"), self.laidOut)
	lu.assertEquals(count(orb.overlay.spark, "SetTexCoord"), self.sparkPlaced)
end

function TestOrbLayout:test_changes_are_placed()
	local orb = self.orb
	orb:SetValue(60)
	lu.assertEquals(count(orb.scrollframe, "SetVerticalScroll"), self.laidOut + 1)
	lu.assertEquals(count(orb.overlay.spark, "SetTexCoord"), self.sparkPlaced + 1)
	orb:SetCrop(10, 10)
	lu.assertEquals(count(orb.scrollframe, "SetVerticalScroll"), self.laidOut + 2)
end

function TestOrbLayout:test_placed_again_after_being_empty()
	local orb = self.orb
	orb:SetValue(0)
	lu.assertFalse(orb.scrollframe.shown)
	orb:SetValue(50)
	lu.assertTrue(orb.scrollframe.shown)
	lu.assertEquals(count(orb.scrollframe, "SetVerticalScroll"), self.laidOut + 1)
end

os.exit(lu.LuaUnit.run())
