local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local ControllerWidget = Module:SetWidget("Controller: Pet")

-- Lua API
local setmetatable = setmetatable

local Controller = Engine:CreateFrame("Frame")
local Controller_MT = { __index = Controller }

Controller.UpdateBarArtwork = function(self)
	local Bar = Module:GetWidget("Bar: Pet"):GetFrame()
	if Bar and Bar.PostUpdate then
		Bar:PostUpdate()
	end
end

ControllerWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db
	local controlConfig = config.structure.controllers.pet
	local controlPosition = config.structure.controllers.pet.position

	self.Controller = setmetatable(Engine:CreateFrame("Frame", nil, Engine:GetFrame(), "SecureHandlerAttributeTemplate"), Controller_MT)
	self.Controller.db = db
	self.Controller:SetFrameStrata("BACKGROUND")
	self.Controller:SetAllPoints()
	self.Controller:SetAttribute("padding", controlConfig.padding)
	self.Controller:SetAttribute("controller_width", controlConfig.size[1])
	self.Controller:SetAttribute("controller_height", controlConfig.size[2])
	self.Controller:SetAttribute("controller_width_vehicle", controlConfig.size_vehicle[1])
	self.Controller:SetAttribute("controller_height_vehicle", controlConfig.size_vehicle[2])
	self.Controller:SetSize(controlConfig.size[1], controlConfig.size[2])
	self.Controller:Place(controlPosition.point, controlPosition.anchor, controlPosition.anchor_point, controlPosition.xoffset, controlPosition.yoffset)
		
	-- because the bars aren't created when the first call comes
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateBarArtwork")

end

ControllerWidget.UpdateBarArtwork = function(self)
	self:GetFrame():UpdateBarArtwork()
end

ControllerWidget.GetFrame = function(self)
	return self.Controller
end
