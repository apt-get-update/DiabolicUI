-- The screen's edges pulse red while the player's health is low, like
-- Diablo III's. It uses Blizzard's own low health texture on a frame of our
-- own: Blizzard's LowHealthFrame is its combat flash (screenEdgeFlash),
-- which would stop ours when combat ends.
local _, Engine = ...
local Module = Engine:NewModule("LowHealthWarning")

-- Lua API
local _G = _G
local math_cos = math.cos
local math_pi = math.pi

-- WoW API
local CreateFrame = _G.CreateFrame
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost

local THRESHOLD = .35 -- the share of health under which the edges show
local PULSE = 1.4 -- seconds for one pulse, in and out
local MIN_ALPHA, MAX_ALPHA = .3, .8

Module.IsHealthLow = function(self)
	if UnitIsDeadOrGhost("player") then
		return false
	end
	local max = UnitHealthMax("player")
	return (max > 0) and (UnitHealth("player") / max < THRESHOLD)
end

-- Fades between MIN_ALPHA and MAX_ALPHA, only while shown.
local OnUpdate = function(frame, elapsed)
	frame.elapsed = (frame.elapsed + elapsed) % PULSE
	local wave = .5 - .5 * math_cos(2 * math_pi * frame.elapsed / PULSE)
	frame:SetAlpha(MIN_ALPHA + (MAX_ALPHA - MIN_ALPHA) * wave)
end

Module.Update = function(self, event, unit)
	if unit and (unit ~= "player") then
		return
	end
	local frame = self.frame
	if self:IsHealthLow() then
		if (not frame:IsShown()) then
			frame.elapsed = 0
			frame:SetAlpha(MIN_ALPHA)
			frame:Show()
		end
	else
		frame:Hide()
	end
end

-- Over the game world, under the rest of the UI.
Module.CreateFrame = function(self)
	local frame = CreateFrame("Frame", "DiabolicLowHealthFrame", _G.UIParent)
	frame:Hide()
	frame:SetAllPoints(_G.UIParent)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetFrameLevel(0)
	frame:SetScript("OnUpdate", OnUpdate)

	local texture = frame:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture([[Interface\FullScreenTextures\LowHealth]])
	texture:SetBlendMode("ADD")
	texture:SetAllPoints()

	self.frame = frame
end

Module.OnEnable = function(self)
	if (not self:GetConfig("UnitFrames").lowHealthWarning) then
		return
	end
	self:CreateFrame()
	for _, event in _G.ipairs({ "UNIT_HEALTH", "UNIT_MAXHEALTH", "PLAYER_ENTERING_WORLD", "PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST" }) do
		self:RegisterEvent(event, "Update")
	end
	self:Update()
end
