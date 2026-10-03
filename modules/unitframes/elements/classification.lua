-- "Classification" element: level, class and creature type text for a unit,
-- with elite, rare and boss markers (frame.Classification).
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
end

local Enable = function(self, unit)
	local Classification = self.Classification
	if Classification then
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
		self:RegisterEvent("UNIT_NAME_UPDATE", Update)
		self:RegisterEvent("UNIT_TARGET", Update)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)

		-- (only the target frame has one)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)
		return true
	end
end

Handler:RegisterElement("Classification", Enable, Update)
