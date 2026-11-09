-- The action bars and the orbs dim while nothing's going on, so the
-- world shows: back in combat, with a target, while casting, on a vehicle or
-- a taxi, short of health or mana, with something on the cursor or the mouse
-- over them. Only their alpha changes: the bars' buttons are secure, and
-- still take clicks. The orbs' auras stay.
local _, Engine = ...
local Module = Engine:NewModule("IdleFade", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs
local math_max = math.max
local math_min = math.min

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCursorInfo = _G.GetCursorInfo
local MouseIsOver = _G.MouseIsOver
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitExists = _G.UnitExists
local UnitHasVehicleUI = _G.UnitHasVehicleUI
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitOnTaxi = _G.UnitOnTaxi
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType

local SPELL_POWER_MANA = _G.SPELL_POWER_MANA

local DELAY = 4 -- seconds of nothing going on before they fade
local IDLE_ALPHA = 0.35 -- how much of them still shows
local FADE_OUT, FADE_IN = 1, 0.15 -- seconds
local INTERVAL = 0.1 -- seconds between looks at what's going on

Module.IsMouseOverParts = function(self)
	for _, part in ipairs(self.hovered) do
		if part:IsVisible() and MouseIsOver(part) then
			return true
		end
	end
	return false
end

Module.IsBusy = function(self)
	local shortOfMana = (UnitPowerType("player") == SPELL_POWER_MANA) and (UnitPower("player") < UnitPowerMax("player"))
	return not self.db.fadeWhenIdle
		or UnitAffectingCombat("player")
		or UnitExists("target")
		or UnitCastingInfo("player")
		or UnitChannelInfo("player")
		or UnitHasVehicleUI("player")
		or UnitOnTaxi("player")
		or (UnitHealth("player") < UnitHealthMax("player"))
		or shortOfMana
		or GetCursorInfo()
		or self:IsMouseOverParts()
end

Module.Tick = function(self, elapsed)
	self.sinceLook = self.sinceLook + elapsed
	if self.sinceLook >= INTERVAL then
		self.idle = self:IsBusy() and 0 or (self.idle + self.sinceLook)
		self.sinceLook = 0
	end
	local target = (self.idle >= DELAY) and IDLE_ALPHA or 1
	if self.alpha ~= target then
		local alpha
		if target == IDLE_ALPHA then
			alpha = math_max(IDLE_ALPHA, self.alpha - elapsed / FADE_OUT)
		else
			alpha = math_min(1, self.alpha + elapsed / FADE_IN)
		end
		self.alpha = alpha
		for _, part in ipairs(self.parts) do
			part:SetAlpha(alpha)
		end
	end
end

Module.OnInit = function(self)
	self.db = self:GetConfig("ActionBars", "character")
end

Module.OnEnable = function(self)
	local bars = Engine:GetModule("ActionBars")
	local main, pet = bars:GetWidget("Controller: Main"):GetFrame(), bars:GetWidget("Controller: Pet"):GetFrame()
	local orbs = Engine:GetModule("UnitFrames"):GetWidget("Unit: Player")
	local left, right = orbs.Left, orbs.Right
	-- (the orbs' own parts: the auras are in the same frames; only death knights have runes)
	self.parts = { main, pet, left.Health, right.Power, right.Mana, left.ComboPoints, left.Runes }
	-- the side bars are in `main`, out of its box
	self.hovered = {
		main,
		pet,
		bars:GetWidget("Bar: 4"):GetFrame(),
		bars:GetWidget("Bar: 5"):GetFrame(),
		left,
		right,
	}
	self.sinceLook, self.idle, self.alpha = 0, 0, 1

	self.Ticker = CreateFrame("Frame") -- (named in /dui cpu)
	self.Ticker:SetScript("OnUpdate", function(_, elapsed)
		self:Tick(elapsed)
	end)
end
