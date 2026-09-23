-- Run from the addon root: lua5.1 tests/test_chat_copy_weblinks.lua
--
-- Loads the *real* modules/chat/filters.lua under a minimal Engine/WoW mock
-- and exercises the "Copy Web Links" feature:
--  - AddMessage wraps any http:// or https:// URL found in a message in a
--    custom |HDiabolicCopyText:<index>|h<url>|h link (the URL itself stays
--    the link's visible text), storing that URL by index. Everything else
--    in the message - including any other real hyperlink - is left alone.
--  - filters.lua *replaces* (not hooksecurefunc's) the real SetItemRef, so
--    it can catch that custom link type and return before Blizzard's own
--    version ever sees it (which would otherwise error - "Unknown link
--    type" - on anything it doesn't recognize) while still forwarding
--    every other link type on to the original unchanged. It only opens the
--    copy popup on a left-click; a right-click on the same link is
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
	-- make Module.db.copyWebLinks truthy regardless, masking a broken gate).
	Module.db = { copyWebLinks = true }
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
-- own SetItemRef override, now the live global. Defaults to a left-click,
-- since that's what the copy feature actually responds to.
local function clickLink(link, button)
	_G.SetItemRef(link, "", button or "LeftButton", nil)
end

TestCopyWebLinks = {}

function TestCopyWebLinks:setUp()
	self.Module = loadFiltersModule()
	self.frame = newFakeChatFrame()
	self.Module:SetUpFrame(self.frame)
end

function TestCopyWebLinks:test_wraps_a_url_found_in_the_message()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: check https://wowhead.com/item=123 for stats")

	lu.assertStrContains(self.frame.captured, "|HDiabolicCopyText:")
	lu.assertStrContains(self.frame.captured, "|hhttps://wowhead.com/item=123|h")
end

function TestCopyWebLinks:test_leaves_surrounding_text_untouched()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: check https://wowhead.com/item=123 for stats")

	lu.assertStrContains(self.frame.captured, "check ")
	lu.assertStrContains(self.frame.captured, " for stats")
end

function TestCopyWebLinks:test_clicking_the_wrapped_link_shows_the_url()
	self.frame:AddMessage("visit https://example.com/path?query=1 now")

	local index = self.frame.captured:match("|HDiabolicCopyText:(%d+)|h")
	lu.assertNotNil(index)

	clickLink("DiabolicCopyText:" .. index)

	lu.assertEquals(#popupCalls, 1)
	lu.assertEquals(popupCalls[1].which, "DIABOLICUI_COPY_CHAT_TEXT")
	lu.assertEquals(popupCalls[1].data, "https://example.com/path?query=1")

	-- Must NOT reach the real SetItemRef - that's what used to error
	-- ("Unknown link type") on our custom link type.
	lu.assertEquals(#passedThroughLinks, 0)
end

function TestCopyWebLinks:test_right_clicking_the_wrapped_link_does_nothing()
	self.frame:AddMessage("visit https://example.com now")

	local index = self.frame.captured:match("|HDiabolicCopyText:(%d+)|h")
	clickLink("DiabolicCopyText:" .. index, "RightButton")

	lu.assertEquals(#popupCalls, 0)
	-- Still swallowed, not forwarded - the original errors on this custom
	-- link type regardless of which button was used.
	lu.assertEquals(#passedThroughLinks, 0)
end

function TestCopyWebLinks:test_wraps_multiple_urls_with_separate_indices()
	self.frame:AddMessage("http://one.com and https://two.com")

	local first, second = self.frame.captured:match("|HDiabolicCopyText:(%d+)|hhttp://one%.com|h.-|HDiabolicCopyText:(%d+)|hhttps://two%.com|h")
	lu.assertNotNil(first)
	lu.assertNotNil(second)
	lu.assertNotEquals(first, second)
end

function TestCopyWebLinks:test_leaves_other_hyperlinks_in_the_message_untouched()
	local original = "|Hplayer:Gandalf|h[Gandalf]|h: check out |Hitem:12345|h[Sword]|h and https://example.com"
	self.frame:AddMessage(original)

	-- The item link is byte-for-byte unchanged...
	lu.assertStrContains(self.frame.captured, "|Hitem:12345|h[Sword]|h")
	-- ...while the URL still gets wrapped.
	lu.assertStrContains(self.frame.captured, "|hhttps://example.com|h")
end

function TestCopyWebLinks:test_does_nothing_when_the_option_is_disabled()
	self.Module.db.copyWebLinks = false

	local original = "check https://example.com out"
	self.frame:AddMessage(original)

	lu.assertEquals(self.frame.captured, original)
end

function TestCopyWebLinks:test_forwards_an_unrelated_hyperlink_click_to_the_real_SetItemRef()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: hi")

	clickLink("item:12345", "LeftButton") -- real links normally open on left-click

	lu.assertEquals(#popupCalls, 0)
	lu.assertEquals(passedThroughLinks, { "item:12345" })
end

function TestCopyWebLinks:test_leaves_a_message_with_no_url_unchanged()
	local original = "Raid instance will reset in 5 minutes."
	self.frame:AddMessage(original)

	lu.assertEquals(self.frame.captured, original)
end

os.exit(lu.LuaUnit.run())
