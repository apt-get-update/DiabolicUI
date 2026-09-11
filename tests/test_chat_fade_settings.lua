-- Run from the addon root: lua5.1 tests/test_chat_fade_settings.lua
--
-- Loads the *real* modules/chat/windows.lua under a minimal Engine/WoW mock
-- and exercises:
--  - Module.ApplyFadeSettings, which the chat submenu's "Fade Chat" /
--    "Time Fading" / "Time Visible" controls call to push their values onto
--    the actual chat frames and Blizzard's own fade-out timing.
--  - Module.SaveChatFrameLayout, which remembers the main chat window's
--    manually dragged/resized position and size so it survives a reload.
--  - Module.ApplyBackgroundOpacity, which the "Background Opacity" slider
--    calls to push its value onto the chat window's background texture
--    (only while its editbox is shown - otherwise it stays transparent).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- A fake FloatingChatFrame: just enough of the API ApplyFadeSettings,
-- SaveChatFrameLayout and ApplyBackgroundOpacity call.
local function newFakeChatFrame(name)
	local frame = {
		fadingCalls = {}, timeVisibleCalls = {},
		left = 100, bottom = 50, width = 400, height = 200,
	}
	function frame:GetName() return name end
	function frame:SetFading(enabled) table.insert(self.fadingCalls, enabled) end
	function frame:SetTimeVisible(seconds) table.insert(self.timeVisibleCalls, seconds) end
	function frame:GetLeft() return self.left end
	function frame:GetBottom() return self.bottom end
	function frame:GetWidth() return self.width end
	function frame:GetHeight() return self.height end
	function frame:SetSize(width, height) self.width, self.height = width, height end
	function frame:ClearAllPoints() self.points = {} end
	function frame:SetPoint(point, relativeTo, relativePoint, x, y)
		self.points = self.points or {}
		table.insert(self.points, { point = point, relativeTo = relativeTo, relativePoint = relativePoint, x = x, y = y })
	end
	return frame
end

-- A fake editbox: just enough for updateWindowAlpha's "is the player
-- currently typing" check (getEditbox looks this up by name).
local function newFakeEditBox(shown)
	local box = { shown = shown or false }
	function box:IsShown() return self.shown end
	return box
end

-- A fake chat frame background texture: what updateWindowAlpha actually
-- sets the alpha on.
local function newFakeBackgroundTexture()
	local texture = { shown = true, alphaCalls = {} }
	function texture:IsShown() return self.shown end
	function texture:SetAlpha(alpha) table.insert(self.alphaCalls, alpha) end
	return texture
end

local function loadChatWindowsModule()
	-- CHAT_FRAMES lists the (global) frame names ApplyFadeSettings loops
	-- over; ChatFrame1/ChatFrame2 are looked up by those names via _G.
	_G.CHAT_FRAMES = { "ChatFrame1", "ChatFrame2" }
	_G.ChatFrame1 = newFakeChatFrame("ChatFrame1")
	_G.ChatFrame2 = newFakeChatFrame("ChatFrame2")
	_G.CHAT_FRAME_FADE_OUT_TIME = nil

	-- Only needed for ApplyBackgroundOpacity's underlying updateWindowAlpha,
	-- which getEditbox/the texture loop both touch at call time.
	_G.GetCVar = function() return "" end -- anything but "classic"
	_G.UIFrameFadeRemoveFrame = function() end
	_G.CHAT_FRAME_TEXTURES = { "Background" }
	_G.ChatFrame1EditBox = newFakeEditBox()
	_G.ChatFrame2EditBox = newFakeEditBox()
	_G.ChatFrame1Background = newFakeBackgroundTexture()
	_G.ChatFrame2Background = newFakeBackgroundTexture()

	local Engine = EngineMock.new()
	local chunk = assert(loadfile("modules/chat/windows.lua"))
	chunk("DiabolicUI", Engine)
	local Module = Engine:GetModule("ChatWindows")
	Module.db = { fadeChat = true, timeFading = 3, timeVisible = 20, backgroundOpacity = 25 }
	return Module
end

TestApplyFadeSettings = {}

function TestApplyFadeSettings:setUp()
	self.Module = loadChatWindowsModule()
end

function TestApplyFadeSettings:test_sets_the_global_fade_out_duration_from_timeFading()
	self.Module.db.timeFading = 4
	self.Module:ApplyFadeSettings()
	lu.assertEquals(_G.CHAT_FRAME_FADE_OUT_TIME, 4)
end

function TestApplyFadeSettings:test_applies_fadeChat_and_timeVisible_to_every_chat_frame()
	self.Module.db.fadeChat = false
	self.Module.db.timeVisible = 45
	self.Module:ApplyFadeSettings()

	for _, name in ipairs(_G.CHAT_FRAMES) do
		local frame = _G[name]
		lu.assertEquals(frame.fadingCalls[#frame.fadingCalls], false)
		lu.assertEquals(frame.timeVisibleCalls[#frame.timeVisibleCalls], 45)
	end
end

function TestApplyFadeSettings:test_skips_a_listed_frame_that_does_not_currently_exist()
	table.insert(_G.CHAT_FRAMES, "ChatFrame3") -- no _G.ChatFrame3 defined
	-- must not error just because one listed frame is missing
	self.Module:ApplyFadeSettings()
	lu.assertEquals(#_G.ChatFrame1.fadingCalls, 1)
end

TestSaveChatFrameLayout = {}

function TestSaveChatFrameLayout:setUp()
	self.Module = loadChatWindowsModule()
	self.Module.db.autoposition = false
end

function TestSaveChatFrameLayout:test_records_the_chat_frames_current_position_and_size()
	_G.ChatFrame1.left, _G.ChatFrame1.bottom = 123, 45
	_G.ChatFrame1.width, _G.ChatFrame1.height = 500, 250

	self.Module:SaveChatFrameLayout()

	lu.assertEquals(self.Module.db.positionX, 123)
	lu.assertEquals(self.Module.db.positionY, 45)
	lu.assertEquals(self.Module.db.width, 500)
	lu.assertEquals(self.Module.db.height, 250)
end

TestApplyBackgroundOpacity = {}

function TestApplyBackgroundOpacity:setUp()
	self.Module = loadChatWindowsModule()
	_G.ChatFrame1EditBox.shown = true
	_G.ChatFrame2EditBox.shown = true
end

function TestApplyBackgroundOpacity:test_defaults_to_25_percent()
	self.Module:ApplyBackgroundOpacity()
	lu.assertEquals(_G.ChatFrame1Background.alphaCalls[#_G.ChatFrame1Background.alphaCalls], 0.25)
end

function TestApplyBackgroundOpacity:test_converts_the_percentage_to_a_0_to_1_alpha_on_every_chat_frame()
	self.Module.db.backgroundOpacity = 40
	self.Module:ApplyBackgroundOpacity()

	for _, name in ipairs(_G.CHAT_FRAMES) do
		local background = _G[name .. "Background"]
		lu.assertEquals(background.alphaCalls[#background.alphaCalls], 0.4)
	end
end

function TestApplyBackgroundOpacity:test_stays_transparent_while_the_editbox_is_hidden_regardless_of_the_setting()
	_G.ChatFrame1EditBox.shown = false
	self.Module.db.backgroundOpacity = 100
	self.Module:ApplyBackgroundOpacity()

	lu.assertEquals(_G.ChatFrame1Background.alphaCalls[#_G.ChatFrame1Background.alphaCalls], 0)
end

os.exit(lu.LuaUnit.run())
