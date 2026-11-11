-- "ComboPoints" element: a row of glyphs (frame.ComboPoints, built like the
-- death knight's runes), lit up to the points on the current target and hidden
-- while there are none. Vehicles have their own points, as in Blizzard's frame.
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local C = Engine:GetDB("Data: Colors")

local Update = function(self)
	local ComboPoints = self.ComboPoints
	local points = GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target")
	if points == 0 then
		ComboPoints:Hide()
		return
	end
	for index = 1, #ComboPoints do
		for _, texture in ipairs(ComboPoints[index].layers) do
			if index <= points then
				texture:Show()
			else
				texture:Hide()
			end
		end
	end
	ComboPoints:Show()
end

local Enable = function(self, unit)
	local ComboPoints = self.ComboPoints
	if ComboPoints and (unit == "player") then
		local config, color = ComboPoints.config, C.Power.ENERGY
		local r, g, b = color[1], color[2], color[3]
		local fill, slot = config.fill_multiplier, config.slot_multiplier
		for index = 1, #ComboPoints do
			local point = ComboPoints[index]
			point.Slot:SetVertexColor(r * slot, g * slot, b * slot)
			point.Fill:SetVertexColor(r * fill, g * fill, b * fill)
			point.Glow:SetVertexColor(r * fill, g * fill, b * fill, config.glow_alpha)
		end
		self:RegisterEvent("UNIT_COMBO_POINTS", Update)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
		return true
	end
end

Handler:RegisterElement("ComboPoints", Enable, Update)
