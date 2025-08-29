local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")

-- Lua API
local math_floor = math.floor
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local GetSpecialization = _G.GetSpecialization
local UnitHealthMax = _G.UnitHealthMax
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsTapDenied = _G.UnitIsTapDenied 
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType
local UnitStagger = _G.UnitStagger

local _, playerClass = UnitClass("player")

local ENGINE_BFA = Engine:IsBuild("BfA")
local ENGINE_LEGION = Engine:IsBuild("Legion")
local ENGINE_MOP = Engine:IsBuild("MoP")
local ENGINE_CATA = Engine:IsBuild("Cata")

local _SECONDARY_RESOURCE_NAME = "MANA"
local _SECONDARY_RESOURCE_TOKEN = SPELL_POWER_MANA or Enum.PowerType.Mana

local playerSpec
local UpdateSpec = function(Self, event, ...)
	local spec = GetSpecialization()

end

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
			if (power == 0 or powermax == 0) and (not Power.Value.showAtZero) then
				Power.Value:SetText("")
			else
				if Power.Value.showDeficit then
					if Power.Value.showPercent then
						if Power.Value.showMaximum then
							Power.Value:SetFormattedText("%s / %s - %d%%", (powermax - power), powermax, math_floor(power/powermax * 100))
						else
							Power.Value:SetFormattedText("%s / %d%%", (powermax - power), math_floor(power/powermax * 100))
						end
					else
						if Power.Value.showMaximum then
							Power.Value:SetFormattedText("%s / %s", (powermax - power), powermax)
						else
							Power.Value:SetFormattedText("%s", (powermax - power))
						end
					end
				else
					if Power.Value.showPercent then
						if Power.Value.showMaximum then
							Power.Value:SetFormattedText("%s / %s - %d%%", power, powermax, math_floor(power/powermax * 100))
						else
							Power.Value:SetFormattedText("%s / %d%%", power, math_floor(power/powermax * 100))
						end
					else
						if Power.Value.showMaximum then
							Power.Value:SetFormattedText("%s / %s", power, powermax)
						else
							Power.Value:SetFormattedText("%s", power)
						end
					end
				end
			end
		end
				
		if Power.PostUpdate then
			Power:PostUpdate(power, powermax)
		end		
	end

	if Mana then
		local mana = UnitPower(unit, _SECONDARY_RESOURCE_TOKEN)
		local manamax = UnitPowerMax(unit, _SECONDARY_RESOURCE_TOKEN)

		if powerType == "MANA" or manamax == 0 then
			Mana:Hide()
		else
			if dead then
				mana = 0
				manamax = 0
			end

			local objectType = Mana:GetObjectType()

			if (objectType == "Orb") then
				local colorMulti = C.Orb.MANA 
				local colorSingle = C.Power.MANA or C.Power.UNUSED

				Mana:SetMinMaxValues(0, manamax)
				Mana:SetValue(mana)
				
				if colorMulti then
					for i = 1,4 do
						Mana:SetStatusBarColor(unpack(colorMulti[i]))
					end
				else
					for i = 1,4 do
						Mana:SetStatusBarColor(unpack(colorSingle))
					end
				end

			elseif (objectType == "StatusBar") then
				local color = C.Power.MANA or C.Power.UNUSED

				Mana:SetMinMaxValues(0, manamax)
				Mana:SetValue(mana)
				
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
				Mana:SetStatusBarColor(r, g, b)
			end
			
			if not Mana:IsShown() then
				Mana:Show()
			end

			if Mana.PostUpdate then
				Mana:PostUpdate(mana, manamax)
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
		if Power.frequent or Mana.frequent then
			self:EnableFrequentUpdates("Power", Power.frequent or Mana.frequent)
		else
			if ENGINE_BFA then 
				self:RegisterEvent("UNIT_POWER_UPDATE", Update)
				self:RegisterEvent("UNIT_MAXPOWER", Update)
			elseif ENGINE_CATA then
				self:RegisterEvent("UNIT_POWER", Update)
				self:RegisterEvent("UNIT_MAXPOWER", Update)
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
			end
			self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		end

		-- We want to track these events regardless of wheter or not we're using frequent updates
		if (playerClass == "MONK") then
			self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", UpdateSpec)
			self:RegisterEvent("CHARACTER_POINTS_CHANGED", UpdateSpec)
			self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", UpdateSpec)
			self:RegisterEvent("PLAYER_TALENT_UPDATE", UpdateSpec)

			UpdateSpec(self)
		end
	end
end

local Disable = function(self)
	local Power = self.Power
	local Mana = self.Mana
	if Power or Mana then
		if not (Power.frequent or Mana.frequent) then
			if ENGINE_BFA then
				self:UnregisterEvent("UNIT_POWER_UPDATE", Update)
				self:UnregisterEvent("UNIT_MAXPOWER", Update)
			elseif ENGINE_CATA then 
				self:UnregisterEvent("UNIT_POWER", Update)
				self:UnregisterEvent("UNIT_MAXPOWER", Update)
			else
				self:UnregisterEvent("UNIT_MANA", Update)
				self:UnregisterEvent("UNIT_RAGE", Update)
				self:UnregisterEvent("UNIT_FOCUS", Update)
				self:UnregisterEvent("UNIT_ENERGY", Update)
				self:UnregisterEvent("UNIT_RUNIC_POWER", Update)
				self:UnregisterEvent("UNIT_MAXMANA", Update)
				self:UnregisterEvent("UNIT_MAXRAGE", Update)
				self:UnregisterEvent("UNIT_MAXFOCUS", Update)
				self:UnregisterEvent("UNIT_MAXENERGY", Update)
				self:UnregisterEvent("UNIT_DISPLAYPOWER", Update)
				self:UnregisterEvent("UNIT_MAXRUNIC_POWER", Update)
			end
			self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		end
		return true
	end
end

Handler:RegisterElement("Power", Enable, Disable, Update)
