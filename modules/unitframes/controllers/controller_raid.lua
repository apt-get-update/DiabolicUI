-- "Controller: Raid" widget: placeholder, the raid frames anchor themselves.
local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local ControllerWidget = Module:SetWidget("Controller: Raid")

ControllerWidget.OnEnable = function(self) end

ControllerWidget.GetFrame = function(self) end
