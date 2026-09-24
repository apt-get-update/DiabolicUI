-- "Runes" element: the death knight's six runes (frame.Runes). Each rune
-- glyph fills from the bottom while that rune recharges, colored by its
-- current type (blood, unholy, frost, or death once converted). Behaves like
-- DiabolicUI2's runes: shown in combat with recharging runes dimmed, hidden
-- out of combat once all six are ready, and hidden while in a vehicle.
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local ipairs = ipairs

-- WoW API
local GetRuneCooldown = GetRuneCooldown
local GetRuneType = GetRuneType
local GetTime = GetTime
local UnitAffectingCombat = UnitAffectingCombat
local UnitHasVehicleUI = UnitHasVehicleUI

-- Blizzard's display order: blood, blood, frost, frost, unholy, unholy.
-- (Rune IDs 1-2 are blood, 3-4 unholy and 5-6 frost.)
local RUNE_ORDER = { 1, 2, 5, 6, 3, 4 }

-- Indexed by GetRuneType()
local RUNE_COLORS = {
	[1] = C.Power.RUNES_BLOOD,
	[2] = C.Power.RUNES_UNHOLY,
	[3] = C.Power.RUNES_FROST,
	[4] = C.Power.RUNES_DEATH
}

-- Fills a rune from the bottom: the fill and its glow grow with progress
-- (0-1) and show only the matching bottom part of their glyph, so the art
-- is cropped rather than squashed.
local SetProgress = function(rune, progress)
	if (progress < 0) then
		progress = 0
	elseif (progress > 1) then
		progress = 1
	end
	rune.progress = progress
	for _, texture in ipairs(rune.layers) do
		if (progress == 0) then
			texture:Hide()
		else
			local left, right, top, bottom = texture.texCoords[1], texture.texCoords[2], texture.texCoords[3], texture.texCoords[4]
			texture:SetHeight(rune.size * progress)
			texture:SetTexCoord(left, right, bottom - (bottom - top) * progress, bottom)
			texture:Show()
		end
	end
end

local SetRuneType = function(Runes, rune, runeType)
	if (runeType == rune.runeType) then
		return
	end
	rune.runeType = runeType
	local config = Runes.config
	local color = RUNE_COLORS[runeType] or C.Power.RUNES
	local r, g, b = color[1], color[2], color[3]
	local fill, slot = config.fill_multiplier, config.slot_multiplier
	rune.Slot:SetVertexColor(r * slot, g * slot, b * slot)
	rune.Fill:SetVertexColor(r * fill, g * fill, b * fill)
	rune.Glow:SetVertexColor(r * fill, g * fill, b * fill, config.glow_alpha)
end

local UpdateAlpha = function(Runes, allReady)
	local recharging = Runes.config.alpha_recharging
	for index = 1, #RUNE_ORDER do
		local rune = Runes[index]
		if (allReady) then
			rune:SetAlpha(Runes.inCombat and 1 or 0)
		else
			rune:SetAlpha(rune.ready and 1 or recharging)
		end
	end
end

-- Moves the recharging runes along between rune events.
local OnUpdate = function(Runes, elapsed)
	local now = GetTime()
	for index = 1, #RUNE_ORDER do
		local rune = Runes[index]
		if (not rune.ready) and (rune.duration) and (rune.duration > 0) then
			SetProgress(rune, (now - rune.start) / rune.duration)
		end
	end
end

local Update = function(self, event, ...)
	local Runes = self.Runes
	if (event == "PLAYER_REGEN_DISABLED") then
		Runes.inCombat = true
	elseif (event == "PLAYER_REGEN_ENABLED") then
		Runes.inCombat = false
	elseif (event == "UNIT_ENTERED_VEHICLE") or (event == "UNIT_EXITED_VEHICLE") then
		if ((...) ~= "player") then
			return
		end
	elseif (event ~= "RUNE_POWER_UPDATE") and (event ~= "RUNE_TYPE_UPDATE") then
		Runes.inCombat = UnitAffectingCombat("player") and true or false
	end

	if UnitHasVehicleUI("player") then
		Runes:SetScript("OnUpdate", nil)
		Runes:Hide()
		return
	end

	local now = GetTime()
	local allReady = true
	for index, runeID in ipairs(RUNE_ORDER) do
		local rune = Runes[index]
		local start, duration, ready = GetRuneCooldown(runeID)
		SetRuneType(Runes, rune, GetRuneType(runeID))
		rune.start, rune.duration, rune.ready = start, duration, ready
		if (ready) or (not start) or (not duration) or (duration <= 0) then
			rune.ready = true
			SetProgress(rune, 1)
		else
			allReady = false
			SetProgress(rune, (now - start) / duration)
		end
	end

	UpdateAlpha(Runes, allReady)
	Runes:SetScript("OnUpdate", (not allReady) and OnUpdate or nil)
	Runes:Show()
end

local Enable = function(self, unit)
	local Runes = self.Runes
	if Runes and (unit == "player") then
		self:RegisterEvent("RUNE_POWER_UPDATE", Update)
		self:RegisterEvent("RUNE_TYPE_UPDATE", Update)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:RegisterEvent("PLAYER_REGEN_DISABLED", Update)
		self:RegisterEvent("PLAYER_REGEN_ENABLED", Update)
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
		Update(self)
		return true
	end
end

local Disable = function(self, unit)
	local Runes = self.Runes
	if Runes then
		self:UnregisterEvent("RUNE_POWER_UPDATE", Update)
		self:UnregisterEvent("RUNE_TYPE_UPDATE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:UnregisterEvent("PLAYER_REGEN_DISABLED", Update)
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", Update)
		self:UnregisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:UnregisterEvent("UNIT_EXITED_VEHICLE", Update)
		Runes:SetScript("OnUpdate", nil)
		Runes:Hide()
	end
end

Handler:RegisterElement("Runes", Enable, Disable, Update)
