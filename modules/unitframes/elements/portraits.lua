local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- WoW API
local GetShapeshiftForm = GetShapeshiftForm
local UnitAura = UnitAura
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitIsConnected = UnitIsConnected
local UnitIsPlayer = UnitIsPlayer
local UnitIsUnit = UnitIsUnit
local UnitIsVisible = UnitIsVisible
local UnitSex = UnitSex

local unit_events = {
	UNIT_PORTRAIT_UPDATE = true,
	UNIT_MODEL_CHANGED = true,
	UNIT_ENTERED_VEHICLE = true,
	UNIT_EXITED_VEHICLE = true,
	UNIT_NAME_UPDATE = true,
	UNIT_AURA = true
}


local female_human = {
	-- Human Illusion in Caverns of Time (Escape from Durnholde Keep + Culling of Stratholme)
	[35481] = true, -- Horde (?)
	[35483] = true -- Alliance (?)
}

-- We're actually doing this... /sigh
-- The problem is that female humans get their camera wrong,
-- so we have to use a different setting for them,
-- and this as it turns out also applies to the illusion
-- applied to certain races in the Caverns of Time.
local HasFemaleHumanPortrait = function(unit)
	-- only applies to females, I think
	-- *check for male worgens!
	if UnitSex(unit) ~= 3 then
		return false
	end

	if UnitIsPlayer(unit) then
		-- We got a human female!
		local _, race = UnitRace(unit) -- avoid select, because it's a function call
		if race == "Human" then
			return true
		end
	else
		-- This is a bit dodgy, need more testing.
		-- Main problem here is that we can't always check the race of NPC characters,
		-- but in many cases the display bug applies to more than just female human NPCs,
		-- it applies to most female NPCs.
		-- Needs more testing, though.
		local creature = UnitCreatureType(unit)
		if creature == "Humanoid" then
			return true
		end
	end

	-- druids in a form doesn't get the human illusion
	if UnitIsUnit("player", unit) and GetShapeshiftForm() == 0 then -- returns zero for no form
		return false
	end

	-- Do we have an illusion?
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, shouldConsolidate, spellId, canApplyAura, isBossDebuff, isCastByPlayer, value1, value2, value3
	for i = 1,40 do

		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff = UnitAura(unit, i)
		-- return true if we find a match
		if spellId and female_human[spellId] then
			return true
		end

		-- break and return if we hit the last/empty aura
		if not name then
			return false
		end
	end
end

local Update = function(self, event, ...)
	local unit = self.unit
	if not unit then
		return
	end

	-- don't waste updates on other units events
	local arg = ...
	if event and unit_events[event] and arg ~= unit then
		return
	end

	local Portrait = self.Portrait
	if not UnitExists(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit) then
		Portrait:Hide()
	else
		if not Portrait:IsShown() then
			-- If the model isn't visible,
			-- it won't properly react to camera changes.
			Portrait:Show()
		end
		Portrait:ClearModel()
		Portrait:SetUnit(unit)
		Portrait:SetCamera(0)
		if HasFemaleHumanPortrait(unit) then
			Portrait:SetCamera(1)
		end
	end
end

local Enable = function(self, unit)
	local Portrait = self.Portrait
	if Portrait then
		if Portrait.frequent then
			self:EnableFrequentUpdates("Portrait", Portrait.frequent)
		else
			self:RegisterEvent("UNIT_PORTRAIT_UPDATE", Update)
			self:RegisterEvent("UNIT_MODEL_CHANGED", Update)
			self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
			self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
			self:RegisterEvent("UNIT_NAME_UPDATE", Update)
			self:RegisterEvent("UNIT_AURA", Update)
			self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
			self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)
			self:RegisterEvent("PLAYER_FOCUS_CHANGED", Update)

			-- The quest log uses PARTY_MEMBER_{ENABLE,DISABLE} to handle updating of
			-- party members overlapping quests. This will probably be enough to handle
			-- model updating.
			--
			-- DISABLE isn't used as it fires when we most likely don't have the
			-- information we want.
			if unit:find("party") then
				self:RegisterEvent("PARTY_MEMBER_ENABLE", Update)
			end
		end
		Update(self)
		return true
	end
end

local Disable = function(self, unit)
	local Portrait = self.Portrait
	if Portrait then
		if not Portrait.frequent then
			self:UnregisterEvent("UNIT_PORTRAIT_UPDATE", Update)
			self:UnregisterEvent("UNIT_MODEL_CHANGED", Update)
			self:UnregisterEvent("UNIT_ENTERED_VEHICLE", Update)
			self:UnregisterEvent("UNIT_EXITED_VEHICLE", Update)
			self:UnregisterEvent("UNIT_NAME_UPDATE", Update)
			self:UnregisterEvent("UNIT_AURA", Update)
			self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
			self:UnregisterEvent("PLAYER_TARGET_CHANGED", Update)
			self:UnregisterEvent("PLAYER_FOCUS_CHANGED", Update)

			if unit:find("party") then
				self:UnregisterEvent("PARTY_MEMBER_ENABLE", Update)
			end
		end
		Portrait:Hide()
	end
end

Handler:RegisterElement("Portrait", Enable, Disable, Update)
