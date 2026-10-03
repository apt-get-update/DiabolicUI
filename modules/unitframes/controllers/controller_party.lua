-- "Controller: Party" widget: placeholder, the party frames anchor themselves.
local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local ControllerWidget = Module:SetWidget("Controller: Party")

-- WoW API


ControllerWidget.OnEnable = function(self)
end

ControllerWidget.GetFrame = function(self)
end
