local Addon, Engine = ...
local Module = Engine:NewModule("ChatSounds")

-- Bail if Prat is enabled
Module:SetIncompatible("Prat-3.0")

Module.OnInit = function(self, event, ...)
	self.config = self:GetDB("ChatSounds") -- setup
	self.db = self:GetConfig("ChatSounds") -- user settings
end

Module.OnEnable = function(self, event, ...)
end

Module.OnDisable = function(self)
end
