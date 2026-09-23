local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- WoW API
local UnitClassification = UnitClassification
local UnitCreatureFamily = UnitCreatureFamily
local UnitCreatureType = UnitCreatureType
local UnitLevel = UnitLevel
local UnitIsDead = UnitIsDead
local UnitIsGhost = UnitIsGhost
local UnitIsPlayer = UnitIsPlayer
local UnitLevel = UnitLevel

local add = function(msg, addition)
	if msg then
		return msg .. " " .. addition
	else
		return addition
	end
end

local not_specified = {
	["Not specified"] = true,
	["Nicht spezifiziert"] = true,
	["No especificado"] = true,
	["Sin especificar"] = true,
	["Non spécifié"] = true,
	["Non Specificato"] = true,
	["Não especificado"] = true,
	["Не указано"] = true,
	["기타"] = true,
	["未指定"] = true,
	["不明"] = true
}

local Update = function(self, event, ...)
	local Classification = self.Classification
	local unit = self.unit

	local classification = UnitClassification(unit)
	local creaturetype = UnitCreatureType(unit)
	local creaturefamily = UnitCreatureFamily(unit)
	local level = UnitLevel(unit)
	local name = UnitName(unit)
	local class = UnitClass(unit)
	local race = UnitRace(unit)
	
	if not_specified[creaturetype] then
		creaturetype = nil
	end
	local type = creaturetype or creaturefamily
	
	if level < 0 then
		level = nil
	end

	local msg

	if UnitIsPlayer(unit) then
		if race then
			if level then
				msg = add(msg, FRIENDS_LEVEL_TEMPLATE:format(level, race))
			end
		end
		if class then
			msg = add(msg, class)
		end
		
	elseif UnitIsDead(unit) or UnitIsGhost(unit) then
		if level then
			msg = add(msg, UNIT_LEVEL_DEAD_TEMPLATE:format(level))
		else
			msg = add(msg, DEAD)
		end
		
	else
		if classification == "worldboss" or classification == "elite" or classification == "rareelite" then
			if level then
				if type then
					msg = add(msg, UNIT_TYPE_PLUS_LEVEL_TEMPLATE:format(level, type))
				else
					msg = add(msg, UNIT_PLUS_LEVEL_TEMPLATE:format(level))
				end
			else
				msg = add(msg, ELITE)
				if type then
					msg = add(msg, type)
				end
			end
			if classification == "worldboss" then
			end
			
		else
			if level then
				if type then
					msg = add(msg, UNIT_TYPE_LEVEL_TEMPLATE:format(level, type))
				else
					msg = add(msg, UNIT_LEVEL_TEMPLATE:format(level))
				end
			else
				if type then
					msg = add(msg, type)
				end
			end
		end
	end

	Classification:SetText(msg)
	Classification:SetTextColor(1, 1, 1, 1)
	
	if Classification.PostUpdate then
		return Classification:PostUpdate(unit)
	end
	
end

local Enable = function(self, unit)
	local Classification = self.Classification
	if Classification then
		if Classification.frequent then
			self:EnableFrequentUpdates("Classification", Classification.frequent)
		else
			self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
			self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
			self:RegisterEvent("UNIT_NAME_UPDATE", Update)
			self:RegisterEvent("UNIT_TARGET", Update)
			self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
			
			if unit:find("^target") then
				self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)
			end

			if unit:find("^focus") then
				self:RegisterEvent("PLAYER_FOCUS_CHANGED", Update)
			end

			if unit:find("^mouseover") then
				self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", Update)
			end
			
			if unit:find("party") then
				self:RegisterEvent("PARTY_MEMBER_ENABLE", Update)
				self:RegisterEvent("GROUP_ROSTER_UPDATE", Update)
			end
		end
		return true
	end
end

local Disable = function(self, unit)
	local Classification = self.Classification
	if Classification then
		if not Classification.frequent then
			self:UnregisterEvent("UNIT_ENTERED_VEHICLE", Update)
			self:UnregisterEvent("UNIT_EXITED_VEHICLE", Update)
			self:UnregisterEvent("UNIT_NAME_UPDATE", Update)
			self:UnregisterEvent("UNIT_TARGET", Update)
			self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
			
			if unit:find("^target") then
				self:UnregisterEvent("PLAYER_TARGET_CHANGED", Update)
			end

			if unit:find("^focus") then
				self:UnregisterEvent("PLAYER_FOCUS_CHANGED", Update)
			end

			if unit:find("^mouseover") then
				self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT", Update)
			end
			
			if unit:find("party") then
				self:UnregisterEvent("PARTY_MEMBER_ENABLE", Update)
				self:UnregisterEvent("GROUP_ROSTER_UPDATE", Update)
			end
		end
	end
end

Handler:RegisterElement("Classification", Enable, Disable, Update)
