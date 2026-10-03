-- Moves the durability figure and the vehicle seat indicator to their
-- places on the screen, and keeps them there when Blizzard moves them back
-- (UIParent_ManageFramePositions).
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Anchors")

-- Lua API
local _G = _G
local getmetatable = getmetatable
local pairs = pairs
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc

-- Blizzard frame -> its settings in the "Blizzard" static config
local frames = {
	DurabilityFrame = "durability",
	VehicleSeatIndicator = "vehicleseat"
}

-- Anchors the frame to a holder at `position`, for good.
Module.Lock = function(self, content, position)
	local holder = Engine:CreateFrame("Frame", nil, "UICenter")
	holder:Place(unpack(position))
	holder:SetWidth(content:GetWidth())
	holder:SetHeight(content:GetHeight())

	local frameMeta = getmetatable(holder).__index
	local SetPoint = frameMeta.SetPoint
	local ClearAllPoints = frameMeta.ClearAllPoints

	-- If Mappy is enabled, we need to reset objects it's already taken control of.
	if Engine:IsAddOnEnabled("Mappy") then
		content.Mappy_DidHook = true -- set the flag indicating its already been set up for Mappy
		content.Mappy_SetPoint = function() end -- kill the IsVisible reference Mappy makes
		content.Mappy_HookedSetPoint = function() end -- kill this too
		content.SetPoint = nil -- return the SetPoint method to its original metamethod
		content.ClearAllPoints = nil -- return the SetPoint method to its original metamethod
	end

	ClearAllPoints(content)
	SetPoint(content, "BOTTOM", holder, "BOTTOM", 0, 0)

	hooksecurefunc(content, "SetPoint", function(self, _, anchor)
		if (anchor ~= holder) then
			ClearAllPoints(self)
			SetPoint(self, "BOTTOM", holder, "BOTTOM", 0, 0)
		end
	end)
end

Module.OnInit = function(self)
	local config = self:GetDB("Blizzard")
	for name, key in pairs(frames) do
		self:Lock(_G[name], config[key].position)
	end
end
