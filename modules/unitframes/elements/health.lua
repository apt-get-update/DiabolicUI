local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")

-- Lua API
local _G = _G
local math_floor = math.floor
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local UnitClassification = _G.UnitClassification
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsUnit = _G.UnitIsUnit
local UnitIsTapDenied = _G.UnitIsTapDenied 
local UnitLevel = _G.UnitLevel
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitReaction = _G.UnitReaction


local Update = function(self, event, ...)
	local Health = self.Health
	local unit = self.unit

	local curHealth = UnitHealth(unit)
	local maxHealth = UnitHealthMax(unit)
	local isUnavailable

	if UnitIsPlayer(unit) then
		if (not UnitIsConnected(unit)) then
			curHealth = 1
			maxHealth = 1
			isUnavailable = "offline"
		elseif UnitIsDeadOrGhost(unit) then
			curHealth = 0
			maxHealth = 0
			isUnavailable = UnitIsGhost(unit) and "ghost" or "dead"
		end 
	elseif UnitIsDead(unit) then
		curHealth = 0
		maxHealth = 0
		isUnavailable = "dead"
	end

	Health:SetMinMaxValues(0, maxHealth)
	Health:SetValue(curHealth)

	if Health.Value then
		if (not isUnavailable) then
			if (curHealth == 0 or maxHealth == 0) and (not Health.Value.showAtZero) then
				Health.Value:SetText("")
			else
				if Health.Value.showDeficit then
					if Health.Value.showPercent then
						if Health.Value.showMaximum then
							Health.Value:SetFormattedText("%s / %s - %d%%", (maxHealth - curHealth), maxHealth, math_floor(curHealth/maxHealth * 100))
						else
							Health.Value:SetFormattedText("%s / %d%%", (maxHealth - curHealth), math_floor(curHealth/maxHealth * 100))
						end
					else
						if Health.Value.showMaximum then
							Health.Value:SetFormattedText("%s / %s", (maxHealth - curHealth), maxHealth)
						else
							Health.Value:SetFormattedText("%s / %s", (maxHealth - curHealth))
						end
					end
				else
					if Health.Value.showPercent then
						if Health.Value.showMaximum then
							Health.Value:SetFormattedText("%s / %s - %d%%", curHealth, maxHealth, math_floor(curHealth/maxHealth * 100))
						elseif Health.Value.hideMinimum then
							Health.Value:SetFormattedText("%d%%", math_floor(curHealth/maxHealth * 100))
						else
							Health.Value:SetFormattedText("%s / %d%%", curHealth, math_floor(curHealth/maxHealth * 100))
						end
					else
						if Health.Value.showMaximum then
							Health.Value:SetFormattedText("%s / %s", curHealth, maxHealth)
						else
							Health.Value:SetFormattedText("%s / %s", curHealth)
						end
					end
				end
			end		elseif (isUnavailable == "dead") then 
			Health.Value:SetText(DEAD)
		elseif (isUnavailable == "ghost") then
			Health.Value:SetText(DEAD)
		elseif (isUnavailable == "offline") then
			Health.Value:SetText(PLAYER_OFFLINE)
		end
	end

	if Health.PostUpdate then
		return Health:PostUpdate(unit, curHealth, maxHealth, isUnavailable)
	end
end
	
local Enable = function(self)
	local Health = self.Health
	if Health then
		Health._owner = self
		if Health.frequent then
			self:EnableFrequentUpdates("Health", Health.frequent)
		else
			self:RegisterEvent("UNIT_HEALTH", Update)
			self:RegisterEvent("UNIT_MAXHEALTH", Update)
			self:RegisterEvent("UNIT_HAPPINESS", Update)
			self:RegisterEvent("UNIT_FACTION", Update)
			self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		end
		return true
	end
end

local Disable = function(self)
	local Health = self.Health
	if Health then 
		if (not Health.frequent) then
			self:UnregisterEvent("UNIT_HEALTH", Update)
			self:UnregisterEvent("UNIT_MAXHEALTH", Update)
			self:UnregisterEvent("UNIT_HAPPINESS", Update)
			self:UnregisterEvent("UNIT_FACTION", Update)
			self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		end
	end
end

Handler:RegisterElement("Health", Enable, Disable, Update)
