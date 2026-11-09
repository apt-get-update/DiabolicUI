-- "Range" element: a group member out of range fades out (frame.Range, a
-- table with .outsideAlpha). Offline members stay as they are: they have
-- their own text, and no range to speak of.
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- Lua API
local _G = _G

-- WoW API
local UnitInRange = _G.UnitInRange
local UnitIsConnected = _G.UnitIsConnected
local UnitIsUnit = _G.UnitIsUnit

local INTERVAL = 0.2 -- seconds between looks

local Update = function(self)
	local Range = self.Range
	local unit = self.unit
	local inRange = UnitIsUnit(unit, "player") or not UnitIsConnected(unit) or UnitInRange(unit)
	local alpha = inRange and 1 or Range.outsideAlpha
	if alpha ~= Range.alpha then
		Range.alpha = alpha
		self:SetAlpha(alpha)
	end
end

local Enable = function(self)
	if self.Range then
		self:EnableFrequentUpdates("Range", INTERVAL)
		return true
	end
end

Handler:RegisterElement("Range", Enable, Update)
