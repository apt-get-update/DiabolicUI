local _, Engine = ...
local Module = Engine:NewModule("Warnings")

-- Lua API
local _G = _G
local ipairs = ipairs
local unpack = unpack
local strmatch = string.match

-- WoW API
local GetTime = _G.GetTime

local INTERRUPTED = _G.INTERRUPTED

local OnUpdate = function(self, elapsed)
	if self.new_message then
		self.showing_message = self.new_message
		self.message:SetText(self.new_message)
		self.message:SetAlpha(1)
		self.time_fading = 0
		self.time_shown = 0
		self.is_fading = false
		self.new_message = nil
	end
	if self.new_quest_message then
		self.showing_quest_message = self.new_quest_message
		self.message_quest:SetText(self.new_quest_message)
		self.message_quest:SetAlpha(1)
		self.time_fading_quest = 0
		self.time_shown_quest = 0
		self.is_fading_quest = false
		self.new_quest_message = nil
	end
	if self.is_fading then
		self.time_fading = self.time_fading + elapsed
		if self.time_fading < self.time_to_fade then
			local alpha = 1 - (self.time_fading / self.time_to_fade)
			self.message:SetAlpha(alpha)
		else
			self.message:SetAlpha(0)
			self.message:SetText("")
			self.is_fading = false
			self.time_fading = 0
		end
	else
		if self.showing_message then
			self.time_shown = self.time_shown + elapsed
			if self.time_shown >= self.time_to_show then
				self.time_shown = 0
				self.time_fading = 0
				self.is_fading = true
				self.showing_message = false
			end
		end
	end
	if self.is_fading_quest then
		self.time_fading_quest = self.time_fading_quest + elapsed
		if self.time_fading_quest < self.time_to_fade then
			local alpha = 1 - (self.time_fading_quest / self.time_to_fade)
			self.message_quest:SetAlpha(alpha)
		else
			self.message_quest:SetAlpha(0)
			self.message_quest:SetText("")
			self.is_fading_quest = false
			self.time_fading_quest = 0
		end
	else
		if self.showing_quest_message then
			self.time_shown_quest = self.time_shown_quest + elapsed
			if self.time_shown_quest >= self.time_to_show then
				self.time_shown_quest = 0
				self.time_fading_quest = 0
				self.is_fading_quest = true
				self.showing_quest_message = false
			end
		end
	end
end

Module.AddMessage = function(self, msg, type, r, g, b)
	local now = GetTime()
	if msg == self.lastMsg and ((self.lastTime or 0) + self.config.HZ) > now then
		return
	end
	self.lastMsg = msg
	self.lastTime = now
	local config = self.config
	local hasPriority = config.whitelist.plain[msg]
	local isQuestProgress
	local isBlackListed

	if (not hasPriority) then
		-- first check if it's blacklisted
		for i,pattern in ipairs(config.blacklist.pattern) do
			if strmatch(msg, pattern) then
				isBlackListed = true
				break
			end
		end
		-- then do a sweep to see if it's whitelisted
		if (not isBlackListed) then
			for i,pattern in ipairs(config.whitelist.pattern) do
				if strmatch(msg, pattern) then
					hasPriority = true
					break
				end
			end
			-- quest update?
			isQuestProgress = config.tracker.plain[msg]
			if not isQuestProgress then
				for i,pattern in ipairs(config.tracker.pattern) do
					if strmatch(msg, pattern) then
						isQuestProgress = true
						break
					end
				end
			end
		end
	end

	if (type == "error") then
		r, g, b = unpack(config.color.error)
	elseif (type == "info") then
		r, g, b = unpack(config.color.info)
	elseif (type == "system") and not(r and g and b) then
		r, g, b = unpack(config.color.system)
	end

	if hasPriority then
		if (type == "error") then
			self.player.new_message_type = type
			self.player.new_message = msg
		elseif (type == "info") then
			self.player.new_quest_message_type = type
			self.player.new_quest_message = msg
		elseif (type == "system") and not(r and g and b) then
			self.player.new_message_type = type
			self.player.new_message = msg
		end
		return
	elseif isQuestProgress then
		self.player.new_quest_message_type = type
		self.player.new_quest_message = msg
		return
	end

	if (not isBlackListed) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
	end
end

Module.OnEvent = function(self, event, ...)
	if event == "UI_ERROR_MESSAGE" then
		local messageType, msg
		msg = ...
		self:AddMessage(msg, "error")
	elseif event == "UI_INFO_MESSAGE" then
		local messageType, msg
		msg = ...
		self:AddMessage(msg, "info")
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Warnings")

	self.frames = {}
	self.frames.player = Engine:CreateFrame("Frame")

	-- error frame
	self.frames.player.message = self.frames.player:CreateFontString(nil, "OVERLAY")
	self.frames.player.message.shade = self.frames.player:CreateTexture(nil, "BACKGROUND")

	-- quest frame (system messages too?)
	self.frames.player.message_quest = self.frames.player:CreateFontString(nil, "OVERLAY")
	self.frames.player.message_quest.shade = self.frames.player:CreateTexture(nil, "BACKGROUND")

	-- speeeeeed!!
	self.player = self.frames.player
	self.message = self.frames.player.message
	self.message_quest = self.frames.player.message_quest

end

Module.OnEnable = function(self)
	self:GetHandler("BlizzardUI"):GetElement("Warnings"):Disable()

	local config = self.config

	self.player:SetPoint(unpack(config.point))
	self.player:SetSize(unpack(config.size))
	self.player.time_to_show = config.time_to_show
	self.player.time_to_fade = config.time_to_fade
	self.player.time_shown = 0 -- how long the message currently has been displayed
	self.player.time_fading = 0 -- how long the message currently has been displayed
	self.player.is_fading = false -- if the frame has started fading
	self.player.time_shown_quest = 0 -- how long the message currently has been displayed
	self.player.time_fading_quest = 0 -- how long the message currently has been displayed
	self.player.is_fading_quest = false -- if the frame has started fading
	self.player:Show()

	self.message:SetFontObject(config.font.font_object)
	self.message:SetPoint(unpack(config.font.point))
	self.message:SetSize(unpack(config.font.size))
	self.message.shade:SetPoint("CENTER", self.message, "CENTER", 0, 0)
	self.message.shade:SetTexture(config.shade.texture)
	self.message.shade:SetVertexColor(0, 0, 0)
	self.message.shade:SetAlpha(0)

	self.message_quest:SetFontObject(config.font.font_object_quest)
	self.message_quest:SetPoint(unpack(config.font.point_quest))
	self.message_quest:SetSize(unpack(config.font.size_quest))
	self.message_quest.shade:SetPoint("CENTER", self.message_quest, "CENTER", 0, 0)
	self.message_quest.shade:SetTexture(config.shade.texture)
	self.message_quest.shade:SetVertexColor(0, 0, 0)
	self.message_quest.shade:SetAlpha(0)

	hooksecurefunc(self.frames.player.message, "SetAlpha", function(self, alpha) self.shade:SetAlpha(alpha * 2/3) end)
	hooksecurefunc(self.frames.player.message, "SetText", function(self, alpha) self.shade:SetSize(self:GetStringWidth() + 128, self:GetStringHeight() + 48) end)
	hooksecurefunc(self.frames.player.message_quest, "SetAlpha", function(self, alpha) self.shade:SetAlpha(alpha * 2/3) end)
	hooksecurefunc(self.frames.player.message_quest, "SetText", function(self, alpha) self.shade:SetSize(self:GetStringWidth() + 128, self:GetStringHeight() + 48) end)

	self:RegisterEvent("UI_ERROR_MESSAGE", "OnEvent")
	self:RegisterEvent("UI_INFO_MESSAGE", "OnEvent")
	self:RegisterEvent("SYSMSG", "OnEvent")
	self.player:SetScript("OnUpdate", OnUpdate)

end
