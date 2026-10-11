local _, Engine = ...
local Module = Engine:NewModule("ChatFilters")
local L = Engine:GetLocale()

Module:SetIncompatible("gUI4_Chat")

-- Lua API
local _G = _G
local ipairs = ipairs
local select = select
local table_concat = table.concat

-- WoW API
local FCF_GetCurrentChatFrame = _G.FCF_GetCurrentChatFrame
local StaticPopup_Show = _G.StaticPopup_Show
local hooksecurefunc = _G.hooksecurefunc

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

local handled = {}

-- Copy Web Links: web addresses in chat messages become light blue links,
-- |Hurl:<address>|h<address>|h, that open a popup with the address
-- selected, ready to copy, when left-clicked. Counted as web addresses:
-- anything with a scheme (https://, ftp://, ...), www.<domain>, mailto: and
-- e-mail addresses, IPv4 addresses, a domain with a port or a path, and a
-- bare domain with a common top level domain (so "etc." or "wait.no" stay
-- text). Brackets and quotes around an address, and the punctuation ending
-- a sentence after it, stay out of the link. Other links, textures and
-- colors in the message are left alone.
local URL_COLOR = "|cff40a6ff"

local COMMON_TLDS = {
	app = true, biz = true, co = true, com = true, dev = true, edu = true, gg = true, gl = true, gov = true,
	info = true, io = true, me = true, net = true, online = true, org = true, tv = true, wiki = true, xyz = true,
}

local IsWebAddress = function(word)
	if word:find("^%a[%w%+%.%-]*://.") -- scheme://...
	or word:find("^[Ww][Ww][Ww]%.[%w%.%-]+%.%a%a") -- www.domain.tld
	or word:find("^mailto:.")
	or word:find("^[%w%.%-_%+]+@[%w%.%-]+%.%a%a+$") -- e-mail
	or word:find("^%d+%.%d+%.%d+%.%d+") -- IPv4, with a port or a path
	or word:find("^[%w%.%-]+%.[%w%-]+[:/]") then -- domain.tld:port or domain.tld/path
		return true
	end
	local tld = word:match("^[%w%.%-]+%.(%a%a+)$") -- domain.tld
	return (tld ~= nil) and COMMON_TLDS[tld:lower()] or false
end

-- A word of plain text, linked when it's a web address.
local LinkWord = function(word)
	local lead, address, trail = word:match("^([%(%[<\"']*)(.-)([%)%]>\"'%.,;:!%?]*)$")
	if (address ~= "") and IsWebAddress(address) then
		return lead .. URL_COLOR .. "|Hurl:" .. address .. "|h" .. address .. "|h|r" .. trail
	end
end

-- The escape sequences copied over as they are: links, textures, colors
-- and an escaped "|".
local ESCAPES = { "^|H.-|h.-|h", "^|T.-|t", "^|c%x%x%x%x%x%x%x%x", "^|r", "^||" }

local WrapWebLinks = function(msg)
	if (not msg:find(".", 1, true)) then -- every web address has a dot
		return msg
	end
	local out, plain, pos = {}, 1, 1
	while true do
		local bar = msg:find("|", pos, true)
		if (not bar) then
			break
		end
		local last
		for _, pattern in ipairs(ESCAPES) do
			last = select(2, msg:find(pattern, bar))
			if last then
				break
			end
		end
		if last then
			out[#out + 1] = msg:sub(plain, bar - 1):gsub("[^%s|]+", LinkWord)
			out[#out + 1] = msg:sub(bar, last)
			plain = last + 1
		end
		pos = (last or bar) + 1
	end
	out[#out + 1] = msg:sub(plain):gsub("[^%s|]+", LinkWord)
	return table_concat(out)
end

local ShowCopyTextPopup = function(text)
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
	-- read only: any change puts the text back, selected
	EditBoxOnTextChanged = function(self, data)
		if (self:GetText() ~= (data or "")) then
			self:SetText(data or "")
			self:HighlightText()
		end
	end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

-- A real override, not hooksecurefunc: Blizzard's own SetItemRef falls
-- through to ItemRefTooltip:SetHyperlink() for any link type it doesn't
-- recognize, which *errors* ("Unknown link type") rather than no-op'ing -
-- hooksecurefunc can't run instead of that, only alongside it, so our
-- custom link type needs to be caught and returned on before the original
-- ever sees it.
local Original_SetItemRef = _G.SetItemRef
_G.SetItemRef = function(link, text, button, ...)
	local address = link:match("^url:(.+)$")
	if address then
		-- Left-click only, same as opening any other chat link. Still
		-- swallowed (not forwarded) on any other button, since the
		-- original errors on this unrecognized link type regardless of
		-- which button was used.
		if button == "LeftButton" then
			ShowCopyTextPopup(address)
		end
		return
	end
	return Original_SetItemRef(link, text, button, ...)
end

-- Hovering a web link says what a click does.
local OnHyperlinkEnter = function(frame, link)
	if link:find("^url:") then
		GameTooltip:SetOwner(frame, "ANCHOR_CURSOR")
		GameTooltip:SetText(L["Click to copy the link."])
		GameTooltip:Show()
	end
end

local OnHyperlinkLeave = function(frame)
	if (GameTooltip:GetOwner() == frame) then
		GameTooltip:Hide()
	end
end

local AddMessage = function(frame, msg, ...)
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

	msg = WrapWebLinks(msg)

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

	frame:HookScript("OnHyperlinkEnter", OnHyperlinkEnter)
	frame:HookScript("OnHyperlinkLeave", OnHyperlinkLeave)
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
