-- Run from the addon root: lua5.1 tests/test_chat_copy_text.lua
--
-- Loads the *real* modules/chat/filters.lua under a minimal Engine/WoW mock
-- and exercises the "right-click chat text to copy it" feature:
--  - AddMessage wraps everything after the sender's name in a custom
--    |HDiabolicCopyText:<index>|h...|h link, storing a plain-text (no
--    color codes/hyperlinks) copy of it, keyed by that index.
--  - filters.lua *replaces* (not hooksecurefunc's) the real SetItemRef, so
--    it can catch that custom link type and return before Blizzard's own
--    version ever sees it (which would otherwise error - "Unknown link
--    type" - on anything it doesn't recognize) while still forwarding
--    every other link type on to the original unchanged. It only opens the
--    copy popup on a right-click; a left-click on the same link is
--    swallowed silently (no popup, no fall-through to the original).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local popupCalls
local passedThroughLinks

local function loadFiltersModule()
	_G.CHAT_FRAMES = {}
	_G.AFK = "AFK"
	_G.DND = "DND"
	_G.RAID_WARNING = "Raid Warning"
	_G.CLOSE = "Close"
	_G.StaticPopupDialogs = {}

	-- filters.lua captures its *own* SetItemRef override's reference to the
	-- pre-existing global as a local upvalue at file-load time, so this
	-- stand-in for "Blizzard's real SetItemRef" needs to be installed
	-- before loading (same gotcha as test_tooltip_positioning.lua's
	-- `cursor` table) - it just records what reached it, standing in for
	-- what would otherwise be Blizzard's own link handling.
	passedThroughLinks = {}
	_G.SetItemRef = function(link) table.insert(passedThroughLinks, link) end

	popupCalls = {}
	_G.StaticPopup_Show = function(which, a1, a2, data)
		table.insert(popupCalls, { which = which, data = data })
	end

	local Engine = EngineMock.new()
	local chunk = assert(loadfile("modules/chat/filters.lua"))
	chunk("DiabolicUI", Engine)
	local Module = Engine:GetModule("ChatFilters")
	-- Explicit, not left to the mock's permissive fallback (which would
	-- make Module.db.copyText truthy regardless, masking a broken gate).
	Module.db = { copyText = true }
	return Module
end

-- A fake chat frame: just enough for SetUpFrame to attach AddMessage to,
-- and to capture what the real (overridden) AddMessage forwards on.
local function newFakeChatFrame()
	local frame = {}
	function frame:AddMessage(msg, ...)
		frame.captured = msg
	end
	return frame
end

-- Simulates clicking the given hyperlink, the way Blizzard's real
-- ChatFrame_OnHyperlinkShow -> SetItemRef chain would - via the module's
-- own SetItemRef override, now the live global. Defaults to a right-click,
-- since that's what the copy feature actually responds to.
local function clickLink(link, button)
	_G.SetItemRef(link, "", button or "RightButton", nil)
end

TestCopyText = {}

function TestCopyText:setUp()
	self.Module = loadFiltersModule()
	self.frame = newFakeChatFrame()
	self.Module:SetUpFrame(self.frame)
end

function TestCopyText:test_wraps_the_message_body_after_the_sender_name()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: You shall not pass")

	-- The existing player-name gsub (unrelated to this feature) already
	-- strips the brackets around the name - the wrap just needs to land
	-- right after that link's closing |h.
	lu.assertStrContains(self.frame.captured, "|Hplayer:Gandalf|hGandalf|h|HDiabolicCopyText:")
	lu.assertStrContains(self.frame.captured, ": You shall not pass|h")
end

function TestCopyText:test_clicking_the_wrapped_link_shows_the_plain_message_text()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: You shall not pass")

	local index = self.frame.captured:match("|HDiabolicCopyText:(%d+)|h")
	lu.assertNotNil(index)

	clickLink("DiabolicCopyText:" .. index)

	lu.assertEquals(#popupCalls, 1)
	lu.assertEquals(popupCalls[1].which, "DIABOLICUI_COPY_CHAT_TEXT")
	lu.assertEquals(popupCalls[1].data, "You shall not pass")

	-- Must NOT reach the real SetItemRef - that's what used to error
	-- ("Unknown link type") on our custom link type.
	lu.assertEquals(#passedThroughLinks, 0)
end

function TestCopyText:test_left_clicking_the_wrapped_link_does_nothing()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: You shall not pass")

	local index = self.frame.captured:match("|HDiabolicCopyText:(%d+)|h")
	clickLink("DiabolicCopyText:" .. index, "LeftButton")

	lu.assertEquals(#popupCalls, 0)
	-- Still swallowed, not forwarded - the original errors on this custom
	-- link type regardless of which button was used.
	lu.assertEquals(#passedThroughLinks, 0)
end

function TestCopyText:test_strips_color_codes_from_the_stored_copy()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: check out |cff0070ddmy sword|r!")

	local index = self.frame.captured:match("|HDiabolicCopyText:(%d+)|h")
	clickLink("DiabolicCopyText:" .. index)

	lu.assertEquals(popupCalls[1].data, "check out my sword!")
end

function TestCopyText:test_leaves_a_message_containing_another_hyperlink_completely_untouched()
	-- |H...|h...|h isn't truly nestable - wrapping our own link around an
	-- existing item/spell/quest/etc. link would corrupt its click region,
	-- so a message like this is left alone entirely rather than risk that.
	local original = "|Hplayer:Gandalf|h[Gandalf]|h: check out |Hitem:12345|h[Sword]|h!"
	self.frame:AddMessage(original)

	lu.assertEquals(self.frame.captured, "|Hplayer:Gandalf|hGandalf|h: check out |Hitem:12345|h[Sword]|h!")
	lu.assertNil(self.frame.captured:match("DiabolicCopyText"))
end

function TestCopyText:test_does_nothing_when_the_option_is_disabled()
	self.Module.db.copyText = false

	local original = "|Hplayer:Gandalf|h[Gandalf]|h: You shall not pass"
	self.frame:AddMessage(original)

	lu.assertEquals(self.frame.captured, "|Hplayer:Gandalf|hGandalf|h: You shall not pass")
	lu.assertNil(self.frame.captured:match("DiabolicCopyText"))
end

function TestCopyText:test_forwards_an_unrelated_hyperlink_click_to_the_real_SetItemRef()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: hi")

	clickLink("item:12345", "LeftButton") -- real links normally open on left-click

	lu.assertEquals(#popupCalls, 0)
	lu.assertEquals(passedThroughLinks, { "item:12345" })
end

function TestCopyText:test_leaves_a_message_with_no_sender_link_unchanged()
	local original = "Raid instance will reset in 5 minutes."
	self.frame:AddMessage(original)

	lu.assertEquals(self.frame.captured, original)
end

os.exit(lu.LuaUnit.run())
