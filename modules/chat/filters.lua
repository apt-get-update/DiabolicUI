local Addon, Engine = ...
local Module = Engine:NewModule("ChatFilters")

Module:SetIncompatible("gUI4_Chat")

-- Lua API
local _G = _G
local string_gsub = string.gsub
local string_match = string.match

-- WoW API
local ChatFrame_AddMessageEventFilter = _G.ChatFrame_AddMessageEventFilter
local ChatFrame_RemoveMessageEventFilter = _G.ChatFrame_RemoveMessageEventFilter
local FCF_GetCurrentChatFrame = _G.FCF_GetCurrentChatFrame
local StaticPopup_Show = _G.StaticPopup_Show
local hooksecurefunc = _G.hooksecurefunc

local handled = {}

-- Click-to-copy: the message body (everything after the sender's name)
-- gets wrapped in our own custom hyperlink, so clicking it (instead of
-- the name itself, which keeps its own normal whisper/insert-name click
-- behaviour) opens a popup with the plain text, selected and ready to copy.
-- Bounded so it can't grow forever over a long play session.
local COPY_TEXT_HISTORY_LIMIT = 200
local copyTextByIndex = {}
local nextCopyIndex = 0

local WrapCopyableText = function(msg)
	local senderLink, rest = msg:match("(|H%a-player:.-|h.-|h)(.*)$")
	if (not senderLink) or (rest == "") then
		return msg
	end

	-- |H...|h...|h isn't a truly nestable format - wrapping our own link
	-- around an existing one (an item, spell, quest, etc. mentioned in the
	-- message) would corrupt that link's own click region. Leave the whole
	-- message untouched rather than risk breaking those.
	if rest:find("|H") then
		return msg
	end

	-- Plain-text version to actually show in the copy popup - strips color
	-- codes and textures (no other hyperlinks can be present at this point,
	-- guaranteed by the check above), so what's shown is plain, readable,
	-- copyable text.
	local clean = rest:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "")
	clean = clean:gsub("^:%s*", "") -- drop the leading ": " separator
	if (clean == "") then
		return msg
	end

	nextCopyIndex = nextCopyIndex + 1
	copyTextByIndex[nextCopyIndex] = clean
	copyTextByIndex[nextCopyIndex - COPY_TEXT_HISTORY_LIMIT] = nil

	return senderLink .. "|HDiabolicCopyText:" .. nextCopyIndex .. "|h" .. rest .. "|h"
end

local ShowCopyTextPopup = function(text)
	if (not text) or (text == "") then
		return
	end
	StaticPopup_Show("DIABOLICUI_COPY_CHAT_TEXT", nil, nil, text)
end

_G.StaticPopupDialogs["DIABOLICUI_COPY_CHAT_TEXT"] = {
	text = "Select and copy the text below:",
	button1 = CLOSE,
	hasEditBox = true,
	editBoxWidth = 350,
	maxLetters = 0,
	OnShow = function(self)
		self.editBox:SetText(self.data or "")
		self.editBox:HighlightText()
		self.editBox:SetFocus()
	end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

-- A real override, not hooksecurefunc: Blizzard's own SetItemRef falls
-- through to ItemRefTooltip:SetHyperlink() for any link type it doesn't
-- recognize, which *errors* ("Unknown link type") rather than no-op'ing -
-- hooksecurefunc can't run instead of that, only alongside it, so our
-- custom link type needs to be caught and returned on before the original
-- ever sees it.
local Original_SetItemRef = _G.SetItemRef
_G.SetItemRef = function(link, text, button, ...)
	local index = link:match("^DiabolicCopyText:(%d+)$")
	if index then
		-- Right-click only. Still swallowed (not forwarded) on any other
		-- button, since the original errors on this unrecognized link
		-- type regardless of which button was used.
		if button == "RightButton" then
			ShowCopyTextPopup(copyTextByIndex[tonumber(index)])
		end
		return
	end
	return Original_SetItemRef(link, text, button, ...)
end

local AddMessage = function(frame, msg, ...)
	-- uncomment to break the chat
	-- for development purposes only. weird stuff happens when used.
	-- msg = gsub(msg, "|", "||")

	-- player names
	msg = msg:gsub("|Hplayer:(.-)-(.-):(.-)|h%[%|c(%w%w%w%w%w%w%w%w)(.-)-(.-)|r%]|h", "|Hplayer:%1-%2:%3|h|c%4%5|r|h") -- player name removing realm
	msg = msg:gsub("|Hplayer:(.-)|h%[(.-)%]|h", "|Hplayer:%1|h%2|h") -- player names with realm
	msg = msg:gsub("|HBNplayer:(.-)|h%[(.-)%]|h", "|HBNplayer:%1|h%2|h")

	-- channel names
	msg = msg:gsub("|Hchannel:(%w+):(%d)|h%[(%d)%. (%w+)%]|h", "|Hchannel:%1:%2|h%3.|h") -- numbered channels
	msg = msg:gsub("|Hchannel:(%w+)|h%[(%w+)%]|h", "|Hchannel:%1|h%2|h") -- non-numbered channels

	-- descriptions
	msg = msg:gsub("^To (.-|h)", "|cffad2424@|r%1")
	msg = msg:gsub("^(.-|h) whispers", "%1")
	msg = msg:gsub("^(.-|h) says", "%1")
	msg = msg:gsub("^(.-|h) yells", "%1")

	-- player status messages
	msg = msg:gsub("<"..AFK..">", "|cffFF0000<"..AFK..">|r ")
	msg = msg:gsub("<"..DND..">", "|cffE7E716<"..DND..">|r ")

	-- raid warnings
	msg = msg:gsub("^%["..RAID_WARNING.."%]", "|cffff0000!|r")

	if Module.db and Module.db.copyText then
		msg = WrapCopyableText(msg)
	end

	return frame.old.message(frame, msg, ...)
end

Module.SetUpFrame = function(self, frame)
	if handled[frame] then return end
	handled[frame] = true

	frame.old = {}
	frame.old.message = frame.AddMessage

	frame.custom = {}
	frame.custom.message = AddMessage

	if frame.AddMessage and frame ~= _G["ChatFrame2"] then
		frame.AddMessage = frame.custom.message
	end
end

Module.SetUpFilters = function(self)
end

Module.OnInit = function(self, event, ...)
	self.config = self:GetDB("ChatFilters")
	self.db = self:GetConfig("ChatFilters")
end

Module.OnEnable = function(self, event, ...)

	for _,name in ipairs(CHAT_FRAMES) do
		self:SetUpFrame(_G[name])
	end

	hooksecurefunc("FCF_OpenTemporaryWindow", function(chatType, chatTarget, sourceChatFrame, selectWindow)
		local frame = FCF_GetCurrentChatFrame()
		self:SetUpFrame(frame)
	end)

	self:SetUpFilters()
end
