-- "RaidMark" element: the skull, cross, ... on the unit (frame.RaidMark, a
-- texture holding Blizzard's sheet of them).
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

local Update = function(self)
	local RaidMark = self.RaidMark
	local index = GetRaidTargetIndex(self.unit)
	if index then
		SetRaidTargetIconTexture(RaidMark, index)
		RaidMark:Show()
	else
		RaidMark:Hide()
	end
end

local Enable = function(self)
	if self.RaidMark then
		self:RegisterEvent("RAID_TARGET_UPDATE", Update)
		self:RegisterEvent("RAID_ROSTER_UPDATE", Update)
		return true
	end
end

Handler:RegisterElement("RaidMark", Enable, Update)
