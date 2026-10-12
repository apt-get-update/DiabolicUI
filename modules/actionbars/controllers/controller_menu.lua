-- "Controller: Menu" widget: the secure anchor frame the main menu button
-- (bottom right) is placed in, with the bag button and the gold and fps
-- texts. Moved with Unlock Frames (modules/menu/menu.lua): its bottom right
-- corner is saved as "menuPosition", from the UI's bottom right.
local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local ControllerWidget = Module:SetWidget("Controller: Menu")

-- Lua API
local unpack = unpack
local setmetatable = setmetatable

-- WoW API
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown


local Controller = CreateFrame("Frame")
local Controller_MT = { __index = Controller }


ControllerWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db

	self.Controller = setmetatable(CreateFrame("Frame", nil, Engine:GetFrame(), "SecureHandlerAttributeTemplate"), Controller_MT)
	self.Controller:SetFrameStrata("BACKGROUND")
	self.Controller:SetAllPoints()
	self.Controller.db = db

	local control_config = config.structure.controllers.mainmenu
	
	local point = control_config.position.point
	local anchor = control_config.position.anchor
	local anchor_point = control_config.position.anchor_point
	local xoffset = control_config.position.xoffset
	local yoffset = control_config.position.yoffset

	if anchor == "UICenter" then
		anchor = Engine:GetFrame()
	end
	self.defaultPosition = { point, anchor, anchor_point, xoffset, yoffset }

	self.Controller:SetSize(unpack(control_config.size))
	self:PlaceController()
end

-- Where it was moved to, or its default place. A secure frame: out of
-- combat only (Unlock Frames isn't available in combat anyway).
ControllerWidget.PlaceController = function(self)
	local controller = self.Controller
	local position = Module.db.menuPosition
	controller:ClearAllPoints()
	if position then
		controller:SetPoint("BOTTOMRIGHT", Engine:GetFrame(), "BOTTOMRIGHT", position[1], position[2])
	else
		controller:SetPoint(unpack(self.defaultPosition))
	end
	-- its buttons mirror on the left half of the screen
	Module:GetWidget("Menu: Main"):ApplySide()
end

-- After a drag: its new place, from the UI's bottom right.
ControllerWidget.SavePosition = function(self)
	local controller, ui = self.Controller, Engine:GetFrame()
	Module.db.menuPosition = { controller:GetRight() - ui:GetRight(), controller:GetBottom() - ui:GetBottom() }
	self:PlaceController()
end

ControllerWidget.ResetPosition = function(self)
	Module.db.menuPosition = nil
	if (not InCombatLockdown()) then
		self:PlaceController()
	end
end

ControllerWidget.GetFrame = function(self)
	return self.Controller
end
