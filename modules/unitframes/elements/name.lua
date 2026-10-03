-- "Name" element: the unit name, colored for elites and bosses when the frame
-- opts in (frame.Name).
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- Lua API
local unpack = unpack

-- WoW API
local UnitClassification = UnitClassification
local UnitExists = UnitExists
local UnitName = UnitName

local colors = {
	elite = { 0/255, 112/255, 221/255 },
	boss = { 163/255, 53/255, 255/238 },
	normal = { 255/255, 255/255, 255/255 }
}

local Update = function(self, event, ...)
	local unit = self.unit
	
	if (not UnitExists(self.unit)) or (event == "UNIT_TARGET" and not(UnitIsUnit(self.unit, unit.."target"))) then
		return
	end

	local Name = self.Name
	local name = UnitName(unit)
	local classification = UnitClassification(unit)
	
	local r, g, b
	if Name.colorBoss and classification == "worldboss" then
		r, g, b = unpack(colors.boss)
	elseif Name.colorElite and (classification == "elite" or classification == "rareelite") then
		r, g, b = unpack(colors.elite)
	else
		r, g, b = unpack(colors.normal)
	end
	
	Name:SetText(name)
	Name:SetTextColor(r, g, b)
end

local Enable = function(self, unit)
	local Name = self.Name
	if Name then
		Name._owner = self
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

		if unit:find("party") then
			self:RegisterEvent("PARTY_MEMBER_ENABLE", Update)
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", Update)
			self:RegisterEvent("RAID_ROSTER_UPDATE", Update)
		end
		return true
	end
end

Handler:RegisterElement("Name", Enable, Update)
