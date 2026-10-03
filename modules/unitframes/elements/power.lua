-- "Power" element: mana, rage, energy, focus and runic power bars and value
-- text (frame.Power, frame.Mana).
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local ipairs = ipairs
local unpack = unpack

-- WoW API
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsTapDenied = Engine.UnitIsTapDenied
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType


local _SECONDARY_RESOURCE_TOKEN = SPELL_POWER_MANA

-- Like health: a "FREQUENT" poll that finds nothing changed skips the work,
-- with a full refresh this often regardless.
local IDLE_REFRESH = .5

local Update = function(self, event, ...)
	local Power = self.Power
	local Mana = self.Mana

	local unit = self.unit

	local dead = UnitIsDeadOrGhost(unit)
	local connected = UnitIsConnected(unit)
	local tapped = UnitIsTapDenied(unit)

	local powerID, powerType = UnitPowerType(unit)
	local power = UnitPower(unit, powerID)
	local powermax = UnitPowerMax(unit, powerID)
	local mana = Mana and UnitPower(unit, _SECONDARY_RESOURCE_TOKEN)
	local manamax = Mana and UnitPowerMax(unit, _SECONDARY_RESOURCE_TOKEN)

	local last = self._lastPower
	if (not last) then
		last = {}
		self._lastPower = last
	end
	if (event == "FREQUENT") and (unit == last.unit) and (powerType == last.powerType) and (power == last.power) and (powermax == last.powermax)
	and (mana == last.mana) and (manamax == last.manamax) and (dead == last.dead) and (connected == last.connected) and (tapped == last.tapped) then
		last.idle = last.idle + ((...) or 0)
		if (last.idle < IDLE_REFRESH) then
			return
		end
	end
	last.unit, last.powerType, last.power, last.powermax, last.mana, last.manamax = unit, powerType, power, powermax, mana, manamax
	last.dead, last.connected, last.tapped, last.idle = dead, connected, tapped, 0

	if Power then 
		if dead then
			power = 0
			powermax = 0
		end

		local objectType = Power:GetObjectType()

		if objectType == "Orb" then
			local colorMulti = powerType and C.Orb[powerType] 
			local colorSingle = powerType and C.Power[powerType] or C.Power.UNUSED

			if Power.powerType ~= powerType then
				Power:Clear() -- forces the orb to empty, for a more lively animation on power/form changes
				Power.powerType = powerType
			end

			Power:SetMinMaxValues(0, powermax)
			Power:SetValue(power)
			
			if colorMulti then
				for i = 1,4 do
					Power:SetStatusBarColor(unpack(colorMulti[i]))
				end
			else
				--for i = 1,4 do
					Power:SetStatusBarColor(unpack(colorSingle))
				--end
			end

		elseif objectType == "StatusBar" then
			local color = powerType and C.Power[powerType] or C.Power.UNUSED
			if Power.powerType ~= powerType then
				Power.powerType = powerType
			end

			Power:SetMinMaxValues(0, powermax)
			Power:SetValue(power)
			
			local r, g, b
			if not connected then
				r, g, b = unpack(C.Status.Disconnected)
			elseif dead then
				r, g, b = unpack(C.Status.Dead)
			elseif tapped then
				r, g, b = unpack(C.Status.Tapped)
			else
				r, g, b = unpack(color)
			end
			Power:SetStatusBarColor(r, g, b)
		end
		
		if Power.Value then
			Power.Value:SetText(((power == 0) or (powermax == 0)) and "" or power)
		end
				
		if Power.PostUpdate then
			Power:PostUpdate(power, powermax)
		end		
	end

	if Mana then
		if powerType == "MANA" or manamax == 0 then
			Mana:Hide()
		else
			if dead then
				mana = 0
				manamax = 0
			end

			-- (the only mana bar is the player's orb, beside a druid's form power)
			Mana:SetMinMaxValues(0, manamax)
			Mana:SetValue(mana)
			for _, layer in ipairs(C.Orb.MANA) do
				Mana:SetStatusBarColor(unpack(layer))
			end

			if not Mana:IsShown() then
				Mana:Show()
			end
		end
	end
end

local Enable = function(self)
	local Power = self.Power
	local Mana = self.Mana
	if Power or Mana then
		if Power then
			Power._owner = self
		end
		if Mana then
			Mana._owner = self
		end
		local frequent = (Power and Power.frequent) or (Mana and Mana.frequent)
		if frequent then
			self:EnableFrequentUpdates("Power", frequent)
		else
			self:RegisterEvent("UNIT_MANA", Update)
			self:RegisterEvent("UNIT_RAGE", Update)
			self:RegisterEvent("UNIT_FOCUS", Update)
			self:RegisterEvent("UNIT_ENERGY", Update)
			self:RegisterEvent("UNIT_RUNIC_POWER", Update)
			self:RegisterEvent("UNIT_MAXMANA", Update)
			self:RegisterEvent("UNIT_MAXRAGE", Update)
			self:RegisterEvent("UNIT_MAXFOCUS", Update)
			self:RegisterEvent("UNIT_MAXENERGY", Update)
			self:RegisterEvent("UNIT_DISPLAYPOWER", Update)
			self:RegisterEvent("UNIT_MAXRUNIC_POWER", Update)
			self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		end
		return true
	end
end

Handler:RegisterElement("Power", Enable, Update)
