-- Run from the addon root: lua5.1 tests/test_session_chat.lua
--
-- Chat in the fake client: our chat bubbles following Blizzard's, the chat
-- windows (input box, buttons, the IM style, whisper windows, the stuck key
-- guard, the first-run layout question, saving a hand-placed window, the
-- autoposition command) and the copy web link popup.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client

local function boot(options)
	client = Client.boot(options)
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

-- Chat windows settings with the layout question already answered.
local function chatWindows(settings)
	settings.hasbeenqueried = true
	return { DiabolicUI_DB = { ChatWindows = { profiles = { global = settings } } } }
end

-- Chat bubbles --------------------------------------------------------------------

TestChatBubbles = {}

function TestChatBubbles:tearDown()
	client = nil
end

-- A chat bubble like the client makes them: a nameless child of the
-- WorldFrame, its background first, then the text.
local function say(text, x, y)
	local bubble = CreateFrame("Frame", nil, _G.WorldFrame)
	local background = bubble:CreateTexture(nil, "BACKGROUND")
	background:SetTexture([[Interface\Tooltips\ChatBubble-Background]])
	local tail = bubble:CreateTexture(nil, "BACKGROUND")
	tail:SetTexture([[Interface\Tooltips\ChatBubble-Tail]])
	local message = bubble:CreateFontString(nil, "ARTWORK")
	message:SetFontObject(_G.ChatFontNormal)
	message:SetPoint("BOTTOM", _G.WorldFrame, "BOTTOMLEFT", x or 500, y or 300)
	message:SetTextColor(1, 1, 0.6)
	message:SetText(text)
	bubble.background, bubble.message = background, message
	return bubble
end

-- Our bubble for Blizzard's.
local function oursFor(bubble)
	for _, frame in ipairs({ _G.UIParent:GetChildren() }) do
		for _, child in ipairs({ frame:GetChildren() }) do
			if child.text and child.text:GetText() == bubble.message:GetText() then
				return child
			end
		end
	end
end

function TestChatBubbles:test_our_bubble_follows_blizzards()
	boot({ world = function(world) world.cvars.chatBubbles = "0" end })
	lu.assertEquals(_G.GetCVar("chatBubbles"), "1")
	-- other children of the WorldFrame are left alone
	CreateFrame("Frame", "SomeNamedFrame", _G.WorldFrame)
	CreateFrame("Frame", nil, _G.WorldFrame)
	local bubble = say("For the Horde!")
	client:Tick(0.1)

	-- Blizzard's is emptied
	lu.assertNil(bubble.background:GetTexture())
	lu.assertEquals(select(4, bubble.message:GetTextColor()), 0)

	local ours = oursFor(bubble)
	lu.assertNotNil(ours)
	lu.assertTrue(shown(ours))
	lu.assertEquals({ ours.text:GetTextColor() }, { 1, 1, 0.6, 1 })
	local x, y = select(4, ours:GetPoint())
	lu.assertNotNil(x)

	-- it moves along
	bubble.message:SetPoint("BOTTOM", _G.WorldFrame, "BOTTOMLEFT", 700, 300)
	client:Tick(0.1)
	lu.assertTrue(select(4, ours:GetPoint()) > x)
	lu.assertEquals(select(5, ours:GetPoint()), y)

	-- gone, then the same words again
	bubble:Hide()
	client:Tick(0.1)
	lu.assertFalse(shown(ours))
	client:Tick(0.1)
	lu.assertNil(ours.last)
	bubble:Show()
	client:Tick(0.1)
	lu.assertTrue(shown(ours))
	assertClean(client)
end

function TestChatBubbles:test_long_lines_wrap()
	boot()
	local bubble = say(string.rep("Lok'tar ogar! ", 60))
	client:Tick(0.1)
	lu.assertEquals(oursFor(bubble).text:GetWidth(), 400)
	assertClean(client)
end

function TestChatBubbles:test_left_to_nicebubbles()
	boot({ world = function(world)
		table.insert(world.addons, { name = "NiceBubbles", enabled = true })
	end })
	local bubble = say("Hello")
	client:Tick(0.1)
	lu.assertNotNil(bubble.background:GetTexture())
	assertClean(client)
end

-- Chat windows ----------------------------------------------------------------------

TestChatWindows = {}

function TestChatWindows:tearDown()
	client = nil
end

function TestChatWindows:test_the_im_style_input_box_of_the_dock()
	boot({ world = function(world) world.cvars.chatStyle = "im" end,
		savedVariables = chatWindows({ backgroundOpacity = 50 }) })
	_G.ChatFrame2EditBox:Show()
	_G.FCF_SetWindowAlpha(_G.ChatFrame1, 0)
	lu.assertEquals(_G.ChatFrame1Background:GetAlpha(), 0.5)
	_G.ChatFrame2EditBox:Hide()
	_G.FCF_SetWindowAlpha(_G.ChatFrame1, 0)
	lu.assertEquals(_G.ChatFrame1Background:GetAlpha(), 0)
	assertClean(client)
end

function TestChatWindows:test_whisper_windows_get_the_same_look()
	boot()
	local frame = _G.FCF_OpenTemporaryWindow("WHISPER", "Bob")
	lu.assertNotNil(_G[frame:GetName() .. "EditBoxIcon"])
	lu.assertEquals(_G[frame:GetName() .. "TabLeft"]:GetTexture(), "")
	-- and the same filters
	frame:AddMessage("see https://example.com")
	assertClean(client)
end

function TestChatWindows:test_shift_scroll_jumps_to_the_ends()
	boot()
	local frame = _G.ChatFrame1
	for i = 1, 20 do
		frame:AddMessage("line " .. i)
	end
	client.world.modifiers.shift = true
	_G.FloatingChatFrame_OnMouseScroll(frame, 1)
	lu.assertEquals(frame:GetCurrentScroll(), 20)
	_G.FloatingChatFrame_OnMouseScroll(frame, -1)
	lu.assertEquals(frame:GetCurrentScroll(), 0)
	-- without shift, Blizzard's own scrolling
	client.world.modifiers.shift = false
	_G.FloatingChatFrame_OnMouseScroll(frame, 1)
	_G.FloatingChatFrame_OnMouseScroll(frame, -1)
	lu.assertEquals(frame:GetCurrentScroll(), 0)
	assertClean(client)
end

function TestChatWindows:test_the_input_icon_follows_the_button_side()
	boot()
	local config = client.Engine:GetDB("ChatWindows")
	_G.ChatFrame1.buttonSide = "right"
	_G.FCF_SetButtonSide(_G.ChatFrame1, "right")
	local point, _, rpoint, x, y = _G.ChatFrame1EditBoxIcon:GetPoint()
	lu.assertEquals({ point, rpoint, x, y }, { "TOPRIGHT", unpack(config.editbox.icon.position.right) })
	assertClean(client)
end

function TestChatWindows:test_frames_stay_on_our_ui_parent()
	boot()
	local center = client.Engine:GetFrame()
	for _, frame in ipairs({ _G.ChatFrameMenuButton, _G.ChatFrame1, _G.ChatFrame1EditBox }) do
		frame:SetParent(_G.UIParent)
		lu.assertEquals(frame:GetParent(), center, frame:GetName())
	end
	assertClean(client)
end

function TestChatWindows:test_the_menu_button_only_with_the_input_box()
	boot()
	_G.SELECTED_CHAT_FRAME = _G.ChatFrame1
	_G.ChatFrameMenuButton:Show()
	lu.assertFalse(shown(_G.ChatFrameMenuButton))
	_G.ChatFrame1EditBox:Show()
	lu.assertTrue(shown(_G.ChatFrameMenuButton))
	lu.assertTrue(shown(_G.ChatFrame1ButtonFrame))
	_G.ChatFrame1EditBox:Hide()
	lu.assertFalse(shown(_G.ChatFrameMenuButton))
	lu.assertFalse(shown(_G.ChatFrame1ButtonFrame))
	assertClean(client)
end

function TestChatWindows:test_the_button_frame_fades_with_the_input_box()
	boot()
	_G.SELECTED_CHAT_FRAME = _G.ChatFrame1
	local fading = true
	_G.UIFrameIsFading = function() return fading end
	_G.ChatFrame1ButtonFrame:SetAlpha(0.5)
	lu.assertEquals(_G.ChatFrame1ButtonFrame:GetAlpha(), 0)
	fading = false
	_G.ChatFrame1EditBox:Show()
	_G.ChatFrame1ButtonFrame:SetAlpha(0.5)
	lu.assertEquals(_G.ChatFrame1ButtonFrame:GetAlpha(), 1)
	assertClean(client)
end

function TestChatWindows:test_a_stuck_key_closes_the_input_box()
	boot()
	local editBox = _G.ChatFrame1EditBox
	editBox:Show()
	editBox:SetText("hello there, all good")
	lu.assertEquals(editBox:GetText(), "hello there, all good")
	editBox:SetText("wwwwwwwwwwww")
	lu.assertEquals(editBox:GetText(), "")
	lu.assertFalse(shown(editBox))
	-- fewer repeats are enough in combat
	client:EnterCombat()
	editBox:Show()
	editBox:SetText("aaaaaaa")
	lu.assertEquals(editBox:GetText(), "")
	client:LeaveCombat()
	assertClean(client)
end

-- The shown popup frame of the popup handler for `id`.
local function popupFrame(id)
	for _, child in ipairs({ client.Engine:GetFrame():GetChildren() }) do
		if child.id == id and child:IsShown() then
			return child
		end
	end
end

function TestChatWindows:test_the_first_run_question()
	local printed = {}
	boot({ login = false })
	_G.print = function(text) printed[#printed + 1] = text end
	client:Login()
	local db = client.Engine:GetConfig("ChatWindows")
	local popup = popupFrame("ENGINE_AUTO_SETUP_CHAT")
	lu.assertNotNil(popup)
	client:Click(popup.button2) -- manual
	lu.assertFalse(db.autoposition)
	lu.assertTrue(db.hasbeenqueried)
	lu.assertEquals(#printed, 1)
	assertClean(client)
end

function TestChatWindows:test_answering_auto()
	boot({ login = false })
	_G.ChatFrame1:SetMovable(true)
	client:Login()
	local db = client.Engine:GetConfig("ChatWindows")
	client:Click(popupFrame("ENGINE_AUTO_SETUP_CHAT").button1)
	lu.assertTrue(db.autoposition)
	lu.assertTrue(db.hasbeenqueried)
	client:FireEvent("UPDATE_CHAT_WINDOWS")
	lu.assertEquals(_G.ChatFrame1:IsUserPlaced(), 1)
	lu.assertNil(popupFrame("ENGINE_AUTO_SETUP_CHAT"))
	assertClean(client)
end

function TestChatWindows:test_clicking_a_tab_or_the_window_closes_the_input_box()
	boot()
	_G.SELECTED_CHAT_FRAME = _G.ChatFrame1
	_G.ChatFrame1EditBox:Show()
	client:Click(_G.ChatFrame1Tab)
	lu.assertFalse(shown(_G.ChatFrame1EditBox))
	lu.assertFalse(shown(_G.ChatFrame1ButtonFrame))
	-- hovering the window shows the tab's name
	client:Hover(_G.ChatFrame2ClickAnywhereButton)
	lu.assertTrue(shown(_G.ChatFrame2TabText))
	client:Leave()
	lu.assertFalse(shown(_G.ChatFrame2TabText))
	-- (the classic style has the one input box)
	_G.ChatFrame1EditBox:Show()
	client:Click(_G.ChatFrame2ClickAnywhereButton)
	lu.assertFalse(shown(_G.ChatFrame1EditBox))
	assertClean(client)
end

function TestChatWindows:test_a_hand_placed_window_comes_back()
	boot({ savedVariables = chatWindows({ autoposition = false, width = 500, height = 200,
		positionX = 40, positionY = 120 }) })
	local frame = _G.ChatFrame1
	lu.assertEquals({ frame:GetSize() }, { 500, 200 })
	lu.assertEquals({ frame:GetPoint() }, { "BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 40, 120 })

	-- dragged somewhere else: remembered
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 60, 140)
	frame:StopMovingOrSizing()
	local db = client.Engine:GetConfig("ChatWindows")
	lu.assertEquals({ db.positionX, db.positionY }, { 60, 140 })
	assertClean(client)
end

function TestChatWindows:test_the_autoposition_command()
	boot({ savedVariables = chatWindows({ autoposition = false }) })
	local printed = {}
	_G.print = function(text) printed[#printed + 1] = text end
	local db = client.Engine:GetConfig("ChatWindows")
	local config = client.Engine:GetDB("ChatWindows")
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("autoposition")
	lu.assertTrue(db.autoposition)
	lu.assertEquals({ _G.ChatFrame1:GetSize() }, config.size)
	-- auto placed windows aren't saved when Blizzard stops moving them
	db.positionX = nil
	_G.ChatFrame1:StopMovingOrSizing()
	lu.assertNil(db.positionX)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("autoposition")
	lu.assertFalse(db.autoposition)
	lu.assertEquals(#printed, 2)
	assertClean(client)
end

-- Shorter messages --------------------------------------------------------------------------

TestChatCleaner = {}

function TestChatCleaner:tearDown()
	client = nil
end

-- (the rules themselves: tests/test_chat_cleaner.lua)
function TestChatCleaner:test_the_filters_are_in_place_after_login()
	boot()
	-- (this client's global strings read as their own names)
	local filter = client.chatFilters.CHAT_MSG_SYSTEM[1]
	local _, cleaned = filter(_G.ChatFrame1, "CHAT_MSG_SYSTEM", _G.ERR_AUCTION_STARTED)
	lu.assertEquals(cleaned, "|cff33cc33+|r " .. _G.ERR_AUCTION_STARTED)
	lu.assertNotNil(client.chatFilters.CHAT_MSG_CHANNEL_NOTICE)
	lu.assertNotNil(client.chatFilters.CHAT_MSG_SAY)
	assertClean(client)
end

-- Copying web links -----------------------------------------------------------------------

TestCopyLinks = {}

function TestCopyLinks:tearDown()
	client = nil
end

function TestCopyLinks:test_clicking_a_link_opens_the_copy_box()
	boot()
	local frame = _G.ChatFrame1
	frame:AddMessage("guide at https://example.com/guide please")
	local last = client.widgetState[frame].messages[#client.widgetState[frame].messages].text
	local link = last:match("|H(url:.-)|h")
	lu.assertEquals(link, "url:https://example.com/guide")
	_G.SetItemRef(link, "https://example.com/guide", "LeftButton", frame)
	-- the hover tooltip
	client:RunScript(frame, "OnHyperlinkEnter", link, "https://example.com/guide")
	lu.assertEquals(Session.tooltipLines(_G.GameTooltip)[1], client.Engine:GetLocale()["Click to copy the link."])
	client:RunScript(frame, "OnHyperlinkLeave", link)
	lu.assertTrue(shown(_G.StaticPopup1))
	local editBox = _G.StaticPopup1.editBox
	lu.assertEquals(editBox:GetText(), "https://example.com/guide")
	-- read only: typing puts the link back (Blizzard's popup passes on its
	-- OnTextChanged with the popup's data)
	local info = _G.StaticPopupDialogs.DIABOLICUI_COPY_CHAT_TEXT
	editBox:SetText("oops")
	info.EditBoxOnTextChanged(editBox, _G.StaticPopup1.data)
	lu.assertEquals(editBox:GetText(), "https://example.com/guide")
	info.EditBoxOnTextChanged(editBox, _G.StaticPopup1.data) -- unchanged: left alone
	lu.assertEquals(editBox:GetText(), "https://example.com/guide")

	_G.StaticPopup1:Hide()
	assertClean(client)
end

-- Copy chat --------------------------------------------------------------------------

TestChatCopy = {}

function TestChatCopy:tearDown()
	client = nil
end

function TestChatCopy:test_double_clicking_a_tab_shows_its_lines_as_plain_text()
	boot({ savedVariables = chatWindows({}) })
	_G.ChatFrame1:AddMessage("|cffffd000Hello|r there")
	_G.ChatFrame1:AddMessage("Look: |cffa335ee|Hitem:100:0:0:0:0:0:0:0:80|h[Big Sword]|h|r |TInterface\\Icons\\Coin:0|t")
	_G.ChatFrame3:AddMessage("elsewhere")
	client:RunScript(_G.ChatFrame1Tab, "OnDoubleClick", "LeftButton")
	local frame = _G.DiabolicChatCopyFrame
	lu.assertTrue(shown(frame))
	lu.assertEquals(client:GetModule("ChatCopy").editBox:GetText(), "Hello there\nLook: [Big Sword] ")

	-- Escape closes it
	lu.assertEquals(_G.UISpecialFrames[#_G.UISpecialFrames], "DiabolicChatCopyFrame")
	frame:Hide()
	-- a right double-click is the tab's menu, not ours
	client:RunScript(_G.ChatFrame1Tab, "OnDoubleClick", "RightButton")
	lu.assertFalse(shown(frame))
	assertClean(client)
end

function TestChatCopy:test_keeps_the_last_200_lines()
	boot({ savedVariables = chatWindows({}) })
	for i = 1, 205 do
		_G.ChatFrame1:AddMessage("line " .. i)
	end
	local text = client:GetModule("ChatCopy"):GetText(_G.ChatFrame1)
	lu.assertEquals(text:match("^[^\n]+"), "line 6")
	lu.assertEquals(text:match("[^\n]+$"), "line 205")
	-- a frame never watched has nothing
	lu.assertEquals(client:GetModule("ChatCopy"):GetText(_G.CreateFrame("ScrollingMessageFrame")), "")
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
