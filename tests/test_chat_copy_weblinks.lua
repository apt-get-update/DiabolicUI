-- Run from the addon root: lua5.1 tests/test_chat_copy_weblinks.lua
--
-- Loads the *real* modules/chat/filters.lua under a minimal Engine/WoW mock
-- and exercises the "Copy Web Links" feature:
--  - AddMessage turns the web addresses found in a message into light blue
--    |Hurl:<address>|h<address>|h links: schemes, www., mailto: and
--    e-mails, IPv4, domains with a port or a path, and bare domains with a
--    common top level domain. Brackets and sentence punctuation around one
--    stay out of the link; other links, textures and colors are left alone.
--  - hovering such a link shows "Click to copy the link." 
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

	_G.GameTooltip = {
		SetOwner = function(self, owner) self.owner = owner end,
		GetOwner = function(self) return self.owner end,
		SetText = function(self, text) self.text = text end,
		Show = function(self) self.shown = true end,
		Hide = function(self) self.shown = false end,
	}

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
	local frame = { scripts = {} }
	function frame:AddMessage(msg, ...)
		frame.captured = msg
	end
	function frame:HookScript(script, func)
		frame.scripts[script] = func
	end
	return frame
end

-- The address linked in `msg`, as the link has it (nil when there's none).
local function linked(msg)
	return msg:match("|Hurl:(.-)|h")
end

-- `text` as a link
local function asLink(text)
	return "|cff40a6ff|Hurl:" .. text .. "|h" .. text .. "|h|r"
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

function TestCopyWebLinks:test_links_a_url_found_in_the_message()
	self.frame:AddMessage("|Hplayer:Gandalf|h[Gandalf]|h: check https://wowhead.com/item=123 for stats")

	lu.assertEquals(self.frame.captured, -- (player names lose their brackets)
		"|Hplayer:Gandalf|hGandalf|h: check " .. asLink("https://wowhead.com/item=123") .. " for stats")
end

function TestCopyWebLinks:test_what_counts_as_a_web_address()
	local addresses = {
		"http://one.com", "ftp://files.example.org/a", "www.wowhead.com", "WWW.Example.net/x",
		"mailto:me@example.com", "someone@mail.example.fr", "192.168.1.10:8080", "10.0.0.1/admin",
		"example.fr/page", "localhost.lan:3000", "discord.gg", "wowhead.com", "Example.COM",
	}
	for _, address in ipairs(addresses) do
		self.frame:AddMessage("see " .. address .. " now")
		lu.assertEquals(linked(self.frame.captured), address, address)
	end
	-- dots in plain words aren't addresses
	for _, text in ipairs({ "etc.", "wait.no", "1.5", "v3.3.5a", "end. Next", "file.lua", "..." }) do
		self.frame:AddMessage("this " .. text .. " here")
		lu.assertNil(linked(self.frame.captured), text)
	end
end

function TestCopyWebLinks:test_brackets_and_punctuation_stay_outside()
	self.frame:AddMessage("(see https://example.com/a), or \"www.example.com\". Also <discord.gg>!")
	lu.assertEquals(self.frame.captured, "(see " .. asLink("https://example.com/a") .. "), or \""
		.. asLink("www.example.com") .. "\". Also <" .. asLink("discord.gg") .. ">!")
end

function TestCopyWebLinks:test_links_textures_and_colors_are_left_alone()
	local item = "|cff1eff00|Hitem:12345:0:0:0:0:0:0:0|h[www.sword.com]|h|r"
	local texture = "|TInterface\\Icons\\a.b.com:14|t"
	self.frame:AddMessage(item .. " " .. texture .. " |cffff0000red.com|r a||b.com")
	lu.assertEquals(self.frame.captured,
		item .. " " .. texture .. " |cffff0000" .. asLink("red.com") .. "|r a||" .. asLink("b.com"))
	-- an unknown escape is left as it is, and the text around it still checked
	self.frame:AddMessage("|x www.a.com")
	lu.assertEquals(self.frame.captured, "|x " .. asLink("www.a.com"))
end

function TestCopyWebLinks:test_clicking_a_link_shows_the_address()
	self.frame:AddMessage("visit https://example.com/path?query=1 now")

	clickLink("url:" .. linked(self.frame.captured))

	lu.assertEquals(#popupCalls, 1)
	lu.assertEquals(popupCalls[1].which, "DIABOLICUI_COPY_CHAT_TEXT")
	lu.assertEquals(popupCalls[1].data, "https://example.com/path?query=1")

	-- Must NOT reach the real SetItemRef - that's what used to error
	-- ("Unknown link type") on our custom link type.
	lu.assertEquals(#passedThroughLinks, 0)
end

function TestCopyWebLinks:test_right_clicking_a_link_does_nothing()
	clickLink("url:https://example.com", "RightButton")

	lu.assertEquals(#popupCalls, 0)
	-- Still swallowed, not forwarded - the original errors on this custom
	-- link type regardless of which button was used.
	lu.assertEquals(#passedThroughLinks, 0)
end

function TestCopyWebLinks:test_hovering_a_link_says_a_click_copies_it()
	local enter, leave = self.frame.scripts.OnHyperlinkEnter, self.frame.scripts.OnHyperlinkLeave
	enter(self.frame, "url:https://example.com")
	lu.assertEquals({ GameTooltip.owner, GameTooltip.text, GameTooltip.shown }, { self.frame, "Click to copy the link.", true })
	leave(self.frame)
	lu.assertFalse(GameTooltip.shown)

	-- other links are left to others
	GameTooltip.shown, GameTooltip.owner = true, "someone else"
	enter(self.frame, "item:12345")
	leave(self.frame)
	lu.assertEquals({ GameTooltip.owner, GameTooltip.shown }, { "someone else", true })
end

function TestCopyWebLinks:test_does_nothing_when_the_option_is_disabled()
	self.Module.db.copyWebLinks = false

	local original = "check https://example.com out"
	self.frame:AddMessage(original)

	lu.assertEquals(self.frame.captured, original)
end

function TestCopyWebLinks:test_forwards_an_unrelated_hyperlink_click_to_the_real_SetItemRef()
	clickLink("item:12345", "LeftButton") -- real links normally open on left-click

	lu.assertEquals(#popupCalls, 0)
	lu.assertEquals(passedThroughLinks, { "item:12345" })
end

function TestCopyWebLinks:test_leaves_a_message_with_no_url_unchanged()
	for _, original in ipairs({ "Raid instance will reset in 5 minutes.", "no dots at all" }) do
		self.frame:AddMessage(original)
		lu.assertEquals(self.frame.captured, original)
	end
end

os.exit(lu.LuaUnit.run())
