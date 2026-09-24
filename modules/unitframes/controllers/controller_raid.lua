-- "Controller: Raid" widget: placeholder, the raid frames anchor themselves.
local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local ControllerWidget = Module:SetWidget("Controller: Raid")

-- WoW API
local CreateFrame = CreateFrame

local Controller = CreateFrame("Frame")
local Controller_MT = { __index = Controller }

ControllerWidget.OnEnable = function(self)
end

ControllerWidget.GetFrame = function(self)
end
