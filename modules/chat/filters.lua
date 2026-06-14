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
local hooksecurefunc = _G.hooksecurefunc

local handled = {}

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
