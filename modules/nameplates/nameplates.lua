local ADDON, Engine = ...
local Module = Engine:NewModule("NamePlates")
local StatusBar = Engine:GetHandler("StatusBar")
local AuraData = Engine:GetDB("Data: Auras")
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")
local L = Engine:GetLocale()
local AuraFunctions = Engine:GetDB("Library: AuraFunctions")
local UICenter = Engine:GetFrame()

-- Register incompatibilities
Module:SetIncompatible("gUI4_NamePlates")
Module:SetIncompatible("NeatPlates")
Module:SetIncompatible("Kui_Nameplates")
Module:SetIncompatible("SimplePlates")
Module:SetIncompatible("TidyPlates")
Module:SetIncompatible("TidyPlates_ThreatPlates")
Module:SetIncompatible("TidyPlatesContinued")

-- Hack'ish manual disable switch.
-- Will be implemented as a user choice later.
--Module:SetIncompatible("DiabolicUI")

-- Lua API
local _G = _G
local ipairs = ipairs
local math_ceil = math.ceil
local math_floor = math.floor
local pairs = pairs
local select = select
local setmetatable = setmetatable
local string_find = string.find
local table_insert = table.insert
local table_sort = table.sort
local table_wipe = table.wipe
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetLocale = _G.GetLocale
local GetRaidTargetIndex = _G.GetRaidTargetIndex
local GetTime = _G.GetTime
local GetQuestGreenRange = _G.GetQuestGreenRange
local InCombatLockdown = _G.InCombatLockdown
local SetCVar = _G.SetCVar
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitClass = _G.UnitClass
local UnitClassification = _G.UnitClassification
local UnitExists = _G.UnitExists
local UnitHasVehicleUI = _G.UnitHasVehicleUI
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitIsTrivial = _G.UnitIsTrivial
local UnitIsUnit = _G.UnitIsUnit
local UnitLevel = _G.UnitLevel
local UnitName = _G.UnitName
local UnitReaction = _G.UnitReaction
local UnitThreatSituation = _G.UnitThreatSituation

-- Engine API
local short = F.Short
local UnitAura = AuraFunctions.UnitAura
local UnitBuff = AuraFunctions.UnitBuff
local UnitDebuff = AuraFunctions.UnitDebuff

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip
local UIParent = UIParent
local WorldFrame = WorldFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

-- Plate Registries
local AllPlates, VisiblePlates = {}, {}
local CastData, CastBarPool = {}, {}

-- WorldFrame child registry to rule out elements already checked faster
local AllChildren = {}

-- Plate FrameLevel ordering
local FRAMELEVELS = {}

-- Counters to keep track of WorldFrame frames and NamePlates
local WORLDFRAME_CHILDREN, WORLDFRAME_PLATES = -1, 0

-- This will be updated later on by the addon,
-- we just need a value of some sort here as a fallback.
local SCALE = 768/1080

-- This will be true if forced updates are needed on all plates
-- All plates will be updated in the next frame cycle
local FORCEUPDATE = false

-- Frame level constants and counters
local FRAMELEVEL_TARGET = 126
local FRAMELEVEL_IMPORTANT = 124 -- rares, bosses, etc
local FRAMELEVEL_CURRENT, FRAMELEVEL_MIN, FRAMELEVEL_MAX, FRAMELEVEL_STEP = 21, 21, 125, 2
local FRAMELEVEL_TRIVAL_CURRENT, FRAMELEVEL_TRIVIAL_MIN, FRAMELEVEL_TRIVIAL_MAX, FRAMELEVEL_TRIVIAL_STEP = 1, 1, 20, 2

-- Opacity Settings
local ALPHA_TARGET = 1 -- For the current target, if any
local ALPHA_FULL = .7 -- For players when not having a target, also for World Bosses when not targeted
local ALPHA_LOW = .35 -- For non-targeted players when having a target
local ALPHA_TRIVIAL = .25 -- For non-targeted trivial mobs
local ALPHA_MINIMAL = .01 -- For non-targeted NPCs

-- Update and fading frequencies
local HZ = 1/30
local FADE_IN = 3/4 -- time in seconds to fade in
local FADE_OUT = 1/20 -- time in seconds to fade out

-- Constants for castbar and aura time displays
local DAY = Engine:GetConstant("DAY")
local HOUR = Engine:GetConstant("HOUR")
local MINUTE = Engine:GetConstant("MINUTE")

-- Maximum displayed buffs.
local BUFF_MAX_DISPLAY = Engine:GetConstant("BUFF_MAX_DISPLAY")

-- Time limit in seconds where we separate between short and long buffs
local TIME_LIMIT = Engine:GetConstant("AURA_TIME_LIMIT")
local TIME_LIMIT_LOW = Engine:GetConstant("AURA_TIME_LIMIT_LOW")

-- Player and Target data
local LEVEL = UnitLevel("player") -- our current level
local TARGET -- our current target, if any
local COMBAT -- whether or not the player is affected by combat

-- Blizzard textures we use to identify plates and more
local CATA_PLATE 		= [[Interface\Tooltips\Nameplate-Border]]
local WOTLK_PLATE 		= [[Interface\TargetingFrame\UI-TargetingFrame-Flash]]
local ELITE_TEXTURE 	= [[Interface\Tooltips\EliteNameplateIcon]] -- elite/rare dragon texture
local BOSS_TEXTURE 		= [[Interface\TargetingFrame\UI-TargetingFrame-Skull]] -- skull textures
local EMPTY_TEXTURE 	= Engine:GetConstant("EMPTY_TEXTURE") -- used to make textures invisible

-- Adding support for WeakAuras' personal resource attachments
local WEAKAURAS = false

-- We use the visibility of some items to determine info about a plate's owner,
-- but still wish these itemse to be hidden from view.
-- So we simply parent them to this hidden frame.
local UIHider = CreateFrame("Frame")
UIHider:Hide()



-- Utility Functions
----------------------------------------------------------

-- Returns the correct difficulty color compared to the player
local getDifficultyColorByLevel = function(level)
	level = level - LEVEL
	if level > 4 then
		return C.General.DimRed.colorCode
	elseif level > 2 then
		return C.General.Orange.colorCode
	elseif level >= -2 then
		return C.General.Normal.colorCode
	elseif level >= -GetQuestGreenRange() then
		return C.General.OffGreen.colorCode
	else
		return C.General.Gray.colorCode
	end
end

-- In Diablo they don't abbreviate numbers at all
-- Since that would be messy with the insanely high health numbers in WoW,
-- we compromise and abbreviate numbers larger than 100k.
local abbreviateNumber = function(number)
	local abbreviated
	if number >= 1e6  then
		abbreviated = short(number)
	else
		abbreviated = tostring(number)
	end
	return abbreviated
end

-- Return a more readable time format for auras and castbars
local formatTime = function(time)
	if time > DAY then -- more than a day
		return ("%1d%s"):format(math_floor(time / DAY), L["d"])
	elseif time > HOUR then -- more than an hour
		return ("%1d%s"):format(math_floor(time / HOUR), L["h"])
	elseif time > MINUTE then -- more than a minute
		return ("%1d%s %d%s"):format(math_floor(time / MINUTE), L["m"], floor(time%MINUTE), L["s"])
	elseif time > 10 then -- more than 10 seconds
		return ("%d%s"):format(math_floor(time), L["s"])
	elseif time > 0 then
		return ("%.1f"):format(time)
	else
		return ""
	end
end

local utf8sub = function(str, i, dots)
	if not str then return end
	local bytes = str:len()
	if bytes <= i then
		return str
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = str:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return str:sub(1, pos - 1)..(dots and "..." or "")
		else
			return str
		end
	end
end



-- NamePlate Template
----------------------------------------------------------

local NamePlate = Engine:CreateFrame("Frame")
local NamePlate_MT = { __index = NamePlate }

local NamePlate_WotLK = setmetatable({}, { __index = NamePlate })
local NamePlate_WotLK_MT = { __index = NamePlate_WotLK }

------------------------------------------------------------------------------
-- 	NamePlate Aura Button Template
------------------------------------------------------------------------------

local Aura = CreateFrame("Frame")
local Aura_MT = { __index = Aura }

local auraFilter = function(name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)


end

Aura.OnEnter = function(self)
	local unit = self:GetParent().unit
	if (not UnitExists(unit)) then
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetUnitAura(unit, self:GetID(), self:GetParent().filter)
end

Aura.OnLeave = function(self)
	if (not GameTooltip:IsForbidden()) then
		GameTooltip:Hide()
	end
end

Aura.CreateTimer = function(self, elapsed)
	if (self.timeLeft) then
		self.elapsed = (self.elapsed or 0) + elapsed
		if (self.elapsed >= 0.1) then
			if (not self.first) then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if (self.timeLeft > 0) then
				if self.currentSpellID then
					self.Time:SetFormattedText("%1d", math_ceil(self.timeLeft))
				else
					-- more than a day
					if (self.timeLeft > DAY) then
						self.Time:SetFormattedText("%1dd", math_floor(self.timeLeft / DAY))

					-- more than an hour
					elseif (self.timeLeft > HOUR) then
						self.Time:SetFormattedText("%1dh", math_floor(self.timeLeft / HOUR))

					-- more than a minute
					elseif (self.timeLeft > MINUTE) then
						self.Time:SetFormattedText("%1dm", math_floor(self.timeLeft / MINUTE))

					-- more than 10 seconds
					elseif (self.timeLeft > 10) then
						self.Time:SetFormattedText("%1d", math_floor(self.timeLeft))

					-- between 6 and 10 seconds
					elseif (self.timeLeft >= 6) then
						self.Time:SetFormattedText("|cffff8800%1d|r", math_floor(self.timeLeft))

					-- between 3 and 5 seconds
					elseif (self.timeLeft >= 3) then
						self.Time:SetFormattedText("|cffff0000%1d|r", math_floor(self.timeLeft))

					-- less than 3 seconds
					elseif (self.timeLeft > 0) then
						self.Time:SetFormattedText("|cffff0000%.1f|r", self.timeLeft)
					else
						self.Time:SetText("")
					end
				end
			else
				self.Time:SetText("")
				self.Time:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end



-- WotLK Plates
----------------------------------------------------------

NamePlate_WotLK.UpdateUnitData = function(self)
	local info = self.info
	local oldRegions = self.old.regions
	local r, g, b

	info.name = oldRegions.name:GetText()
	info.isBoss = oldRegions.bossicon:IsShown()

	-- If the dragon texture is shown, this is an elite or a rare or both
	local dragon = oldRegions.eliteicon:IsShown()
	if dragon then
		-- Speeeeed!
		local math_floor = math_floor

		-- The texture is golden, so a white vertexcolor means it's not a rare, but an elite
		r, g, b = oldRegions.eliteicon:GetVertexColor()
		r, g, b = math_floor(r*100 + .5)/100, math_floor(g*100 + .5)/100, math_floor(b*100 + .5)/100
		if r + g + b == 3 then
			info.isElite = true
			info.isRare = false
		else
			-- The problem with the following is that only elites have the dragontexture,
			-- while it is possible for mobs to be rares without having elite status.
			info.isElite = oldRegions.eliteicon:GetTexture() == ELITE_TEXTURE
			info.isRare = true
		end
	else
		info.isElite = false
		info.isRare = false
	end

	info.level = self.info.isBoss and -1 or tonumber(oldRegions.level:GetText()) or -1
end

NamePlate_WotLK.UpdateTargetData = function(self)
	self.info.isTarget = TARGET and (self.baseFrame:GetAlpha() == 1)
	self.info.isMouseOver = self.old.regions.highlight:IsShown() == 1
end

NamePlate_WotLK.UpdateCombatData = function(self)
	-- Shortcuts to our own objects
	local config = self.config
	local info = self.info
	local oldBars = self.old.bars
	local oldRegions = self.old.regions

	-- Our color table
	local C = C

	-- Blizzard tables
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS

	-- More Lua speed
	local math_floor = math_floor
	local pairs = pairs
	local select = select
	local unpack = unpack

	local r, g, b, _
	local class, hasClass


	-- check if unit is in combat
	r, g, b = oldRegions.name:GetTextColor()
	r, g, b = math_floor(r*100 + .5)/100, math_floor(g*100 + .5)/100, math_floor(b*100 + .5)/100
	info.isInCombat = r > .5 and g < .5 -- seems to be working

	-- check for threat situation
	if oldRegions.threat:IsShown() then
		r, g, b = oldRegions.threat:GetVertexColor()
		r, g, b = math_floor(r*100 + .5)/100, math_floor(g*100 + .5)/100, math_floor(b*100 + .5)/100
		if r > 0 then
			if g > 0 then
				if b > 0 then
					info.unitThreatSituation = 1
				else
					info.unitThreatSituation = 2
				end
			else
				info.unitThreatSituation = 3
			end
		else
			info.unitThreatSituation = 0
		end
	else
		info.unitThreatSituation = nil
	end

	info.health = oldBars.health:GetValue() or 0
	info.healthMax = select(2, oldBars.health:GetMinMaxValues()) or 1

	-- check for raid marks
	info.isMarked = oldRegions.raidicon:IsShown()

	-- figure out class
	r, g, b = oldBars.health:GetStatusBarColor()
	r, g, b = math_floor(r*100 + .5)/100, math_floor(g*100 + .5)/100, math_floor(b*100 + .5)/100

	for class in pairs(RAID_CLASS_COLORS) do
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
			info.isNeutral = false
			info.isCivilian = false
			info.isClass = class
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = true
			hasClass = true
			break
		end
	end

	-- figure out reaction and type if no class is found
	if not hasClass then
		info.isClass = false
		if (r + g + b) >= 1.5 and (r == g and r == b) then -- tapped npc (.53, .53, .53)
			info.isNeutral = false
			info.isCivilian = false
			info.isFriendly = false
			info.isTapped = true
			info.isPlayer = false
		elseif g + b == 0 then -- hated/hostile/unfriendly npc
			info.isNeutral = false
			info.isCivilian = false
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = false
		elseif r + b == 0 then -- friendly npc
			info.isNeutral = false
			info.isCivilian = false
			info.isFriendly = true
			info.isTapped = false
			info.isPlayer = false
		elseif r + g > 1.95 then -- neutral npc
			info.isNeutral = true
			info.isCivilian = false
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = false
		elseif r + g == 0 then -- friendly player
			info.isNeutral = false
			info.isCivilian = true
			info.isFriendly = true
			info.isTapped = false
			info.isPlayer = true
		else -- enemy player (no class colors enabled)
			info.isNeutral = false
			info.isCivilian = false
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = false
		end
	end

	-- apply health and threat coloring
	if not info.healthColor then
		info.healthColor = {}
	end
	if info.unitThreatSituation and info.unitThreatSituation > 0 then
		local color = C.Threat[info.unitThreatSituation]
		r, g, b = color[1], color[2], color[3]
		if not info.threatColor then
			info.threatColor = {}
		end

		info.threatColor[1] = r
		info.threatColor[2] = g
		info.threatColor[3] = b

		info.healthColor[1] = r
		info.healthColor[2] = g
		info.healthColor[3] = b
	else
		if info.isClass then
			if config.showEnemyClassColor then
				local color = C.Class[info.isClass]
				r, g, b = color[1], color[2], color[3]
			else
				local color = C.Reaction[1]
				r, g, b = color[1], color[2], color[3]
			end
		elseif info.isFriendly then
			if info.isPlayer then
				local color = C.Reaction.civilian
				r, g, b = color[1], color[2], color[3]
			else
				local color = C.Reaction[5]
				r, g, b = color[1], color[2], color[3]
			end
		elseif info.isTapped then
			local color = C.tapped
			r, g, b = color[1], color[2], color[3]
		else
			if info.isPlayer then
				local color = C.Reaction[1]
				r, g, b = color[1], color[2], color[3]
			elseif info.isNeutral then
				local color = C.Reaction[4]
				r, g, b = color[1], color[2], color[3]
			else
				local color = C.Reaction[2]
				r, g, b = color[1], color[2], color[3]
			end
		end

		info.healthColor[1] = r
		info.healthColor[2] = g
		info.healthColor[3] = b
	end

end

NamePlate_WotLK.ApplyUnitData = function(self)
	local info = self.info

	local level
	if info.isBoss or (info.level and info.level < 1) then
		self.BossIcon:Show()
		self.Level:SetText("")
	else
		if info.level and info.level > 0 then
			if info.isFriendly then
				level = C.General.OffWhite.colorCode .. info.level .. "|r"
			else
				level = (getDifficultyColorByLevel(info.level)) .. info.level .. "|r"
			end
			if info.isElite then
				if info.isFriendly then
					level = level .. C.Reaction[5].colorCode .. "+|r"
				elseif info.isNeutral then
					level = level .. C.Reaction[4].colorCode .. "+|r"
				else
					level = level .. C.Reaction[2].colorCode .. "+|r"
				end
			end
		end
		self.Level:SetText(level)
		self.BossIcon:Hide()
	end

	self.Health.Value:SetText(self.info and self.info.name or "")

	if info.isMarked then
		self.RaidIcon:SetTexCoord(self.old.regions.raidicon:GetTexCoord()) -- ?
		self.RaidIcon:SetTexture(self.old.regions.raidicon:GetTexture())
		self.RaidIcon:Show()
	else
		self.RaidIcon:Hide()
	end
end

NamePlate_WotLK.ApplyHealthData = function(self)
	local info = self.info
	local health = self.Health

	if info.healthColor then
		--health:SetStatusBarColor(unpack(info.healthColor))
		health:SetStatusBarColor(unpack(C.Orb.HEALTH[1]))
	end

	if info.unitThreatSituation and info.unitThreatSituation > 0 then
		if info.threatColor then
			local r, g, b = info.threatColor[1], info.threatColor[2], info.threatColor[3]
			health.Glow:SetVertexColor(r, g, b, 1)
			health.Shadow:SetVertexColor(r, g, b)
		else
			health.Glow:SetVertexColor(0, 0, 0, .25)
			health.Shadow:SetVertexColor(0, 0, 0, 1)
		end
	else
		health.Glow:SetVertexColor(0, 0, 0, .25)
		health.Shadow:SetVertexColor(0, 0, 0, 1)
	end

	health:SetMinMaxValues(0, info.healthMax)
	health:SetValue(info.health)

	health.Value:SetFont(select(1, health.Value:GetFont()), select(2, health.Value:GetFont()), "OUTLINE")

	health.Value:SetTextColor(unpack(info.healthColor))
	--health.Value:SetFormattedText("( %s / %s )", abbreviateNumber(info.health), abbreviateNumber(info.healthMax))
end

NamePlate_WotLK.UpdateAlpha = function(self)
	local info = self.info
	if self.visiblePlates[self] then
		local oldHealth = self.old.bars.health
		local current, min, max = oldHealth:GetValue(), oldHealth:GetMinMaxValues()
		if ((current == 0) or (max == 0)) then
			self.targetAlpha = 0 -- just fade out the dead units fast, they tend to get stuck. weird.
		elseif TARGET then
			if info.isTarget then
				self.targetAlpha = ALPHA_TARGET
			elseif info.isPlayer then
				self.targetAlpha = ALPHA_LOW
			elseif info.isFriendly then
				self.targetAlpha = ALPHA_MINIMAL
			else
				self.targetAlpha = ALPHA_FULL
			end
		elseif info.isPlayer then
			self.targetAlpha = ALPHA_FULL
		elseif info.isFriendly then
			self.targetAlpha = ALPHA_MINIMAL
		else
			self.targetAlpha = ALPHA_FULL
		end
	else
		self.targetAlpha = 0 -- fade out hidden frames
	end
end

NamePlate_WotLK.UpdateFrameLevel = function(self)
	local info = self.info
	local healthValue = self.Health.Value
	if TARGET and info.isTarget then
		if self:GetFrameLevel() ~= FRAMELEVEL_TARGET then
			self:SetFrameLevel(FRAMELEVEL_TARGET)
		end
		if not healthValue:IsShown() then
			healthValue:Show()
		end
	else
		if self:GetFrameLevel() ~= self.frameLevel then
			self:SetFrameLevel(self.frameLevel)
		end
		if not healthValue:IsShown() then
			healthValue:Show()
		end
	end
end

NamePlate_WotLK.UpdateRaidTarget = function(self)
	local info = self.info
	local oldRegions = self.old.regions

	info.isMarked = oldRegions.raidicon:IsShown()

	if info.isMarked then
		self.RaidIcon:SetTexCoord(oldRegions.raidicon:GetTexCoord()) -- ?
		self.RaidIcon:SetTexture(oldRegions.raidicon:GetTexture())
		self.RaidIcon:Show()
	else
		self.RaidIcon:Hide()
	end
end

NamePlate_WotLK.UpdateLevel = function(self)
	self:UpdateUnitData() -- update 'cosmetic' info like name, level, and elite/boss textures
	self:ApplyUnitData() -- set name, level, textures and icons
end

NamePlate_WotLK.UpdateHealth = function(self)
	self:UpdateCombatData()  -- updates colors, threat, classes, etc
	self:ApplyUnitData() -- set name, level, textures and icons
	self:ApplyHealthData() -- applies health values and coloring
end

NamePlate_WotLK.UpdateThreat = function(self)
	self:UpdateCombatData() -- updates colors, threat, classes, etc
	self:ApplyHealthData() -- applies health values and coloring
end

NamePlate_WotLK.UpdateFaction = function(self)
	self:UpdateUnitData() -- update 'cosmetic' info like name, level, and elite/boss textures
	self:UpdateCombatData() -- updates colors, threat, classes, etc
	self:ApplyUnitData() -- set name, level, textures and icons
	self:ApplyHealthData() -- applies health values and coloring
end

NamePlate_WotLK.UpdateAll = function(self)
	self:UpdateUnitData() -- update 'cosmetic' info like name, level, and elite/boss textures
	self:UpdateTargetData() -- updates info about target and mouseover
	self:UpdateAlpha() -- updates alpha and frame level based on current target
	self:UpdateFrameLevel() -- update frame level to keep target in front and frames separated
	self:UpdateCombatData() -- updates colors, threat, classes, raid markers, combat status, reaction, etc
	self:ApplyUnitData() -- set name, level, textures and icons
	self:ApplyHealthData() -- update health values
end

NamePlate_WotLK.OnShow = function(self)
	local info = self.info
	local baseFrame = self.baseFrame

	info.level = nil
	info.name = nil
	--info.rawname = nil
	info.isInCombat = nil
	info.isCasting = nil
	info.isClass = nil
	info.isBoss = nil
	info.isElite = nil
	info.isFriendly = nil
	info.isMouseOver = nil
	info.isNeutral = nil
	info.isPlayer = nil
	info.isRare = nil
	info.isShieldedCast = nil
	info.isTapped = nil
	info.isTarget = nil
	info.isTrivial = nil
	info.unitThreatSituation = nil
	info.healthMax = 0
	info.health = 0

	self.Highlight:Hide() -- hide custom highlight
	-- self.old.regions.highlight:Hide() -- hide old highlight

	--self.old.regions.highlight:ClearAllPoints()
	--self.old.regions.highlight:SetAllPoints(self.Health)

	self.Health:Show()
	self.Cast:Hide()
	self.Cast.Shadow:Hide()
	self.Auras:Hide()

	self.visiblePlates[self] = self.baseFrame -- this will trigger the fadein

	self.currentAlpha = 0
	self:SetAlpha(0)

	self:UpdateUnitData()
	self:UpdateTargetData()
	self:UpdateAlpha()
	self:UpdateFrameLevel()

	if self.targetAlpha > 0 then
		if self.baseFrame:IsShown() then
			self:Show()
		end
	end

	-- Force an update to catch alpha changes when our target moves back into sight
	FORCEUPDATE = true

	-- setup player classbars
	-- setup auras
	-- setup raid targets
end

NamePlate_WotLK.OnHide = function(self)
	local info = self.info

	info.level = nil
	info.name = nil
	--info.rawname = nil
	info.isInCombat = nil
	info.isCasting = nil
	info.isClass = nil
	info.isBoss = nil
	info.isElite = nil
	info.isFriendly = nil
	info.isMouseOver = nil
	info.isNeutral = nil
	info.isPlayer = nil
	info.isRare = nil
	info.isShieldedCast = nil
	info.isTapped = nil
	info.isTarget = nil
	info.isTrivial = nil
	info.unitThreatSituation = nil
	info.healthMax = 0
	info.health = 0

	self.Cast:Hide()
	self.Cast.Shadow:Hide()
	self.Auras:Hide()

	self.visiblePlates[self] = false -- this will trigger the fadeout and hiding

	-- Force an update to catch alpha changes when our target moves out of sight
	FORCEUPDATE = true
end

NamePlate_WotLK.HandleBaseFrame = function(self, baseFrame)
	local old = {
		baseFrame = baseFrame,
		bars = {},
		regions = {}
	}

	old.bars.health,
	old.bars.cast = baseFrame:GetChildren()

	old.regions.threat,
	old.regions.healthborder,
	old.regions.castshield,
	old.regions.castborder,
	old.regions.casticon,
	old.regions.highlight,
	old.regions.name,
	old.regions.level,
	old.regions.bossicon,
	old.regions.raidicon,
	old.regions.eliteicon = baseFrame:GetRegions()

	old.bars.health:SetStatusBarTexture(EMPTY_TEXTURE)
	old.bars.health:Hide()
	old.bars.cast:SetStatusBarTexture(EMPTY_TEXTURE)
	old.bars.cast:Hide()
	old.regions.name:Hide()
	old.regions.threat:SetTexture(nil)
	old.regions.healthborder:Hide()
	old.regions.highlight:SetTexture(nil)

	old.regions.level:SetWidth(.0001)
	old.regions.level:Hide()
	old.regions.bossicon:SetTexture(nil)
	old.regions.raidicon:SetAlpha(0)
	-- old.regions.eliteicon:SetTexture(nil)
	UIHider[old.regions.eliteicon] = old.regions.eliteicon:GetParent()
	old.regions.eliteicon:SetParent(UIHider)
	old.regions.castborder:SetTexture(nil)
	old.regions.castshield:SetTexture(nil)
	old.regions.casticon:SetTexCoord(0, 0, 0, 0)
	old.regions.casticon:SetWidth(.0001)

	self.baseFrame = baseFrame
	self.old = old

	return old
end

NamePlate_WotLK.HookScripts = function(self, baseFrame)
	baseFrame:HookScript("OnShow", function(baseFrame) self:OnShow() end)
	baseFrame:HookScript("OnHide", function(baseFrame) self:OnHide() end)

	self.old.bars.health:HookScript("OnValueChanged", function() self:UpdateHealth() end)
	self.old.bars.health:HookScript("OnMinMaxChanged", function() self:UpdateHealth() end)

	--self.old.bars.cast:HookScript("OnShow", OldcastBar.OnShowCast)
	--self.old.bars.cast:HookScript("OnHide", OldcastBar.OnHideCast)
	--self.old.bars.cast:HookScript("OnValueChanged", OldcastBar.OnUpdateCast)
end

-- General Plates
----------------------------------------------------------
-- Create our custom regions and objects
NamePlate.CreateRegions = function(self)
	local config = self.config
	local widgetConfig = config.widgets
	local textureConfig = config.textures

	-- Health bar
	local Health = self:CreateStatusBar()
	Health:SetSize(unpack(widgetConfig.health.size))
	Health:SetPoint(unpack(widgetConfig.health.place))
	Health:SetStatusBarTexture(textureConfig.bar_texture.path)
	Health:Hide()

	local HealthShadow = Health:CreateTexture()
	HealthShadow:SetDrawLayer("BACKGROUND")
	HealthShadow:SetSize(unpack(textureConfig.bar_glow.size))
	HealthShadow:SetPoint(unpack(textureConfig.bar_glow.position))
	HealthShadow:SetTexture(textureConfig.bar_glow.path)
	HealthShadow:SetVertexColor(0, 0, 0, 1)
	Health.Shadow = HealthShadow

	local HealthBackdrop = Health:CreateTexture()
	HealthBackdrop:SetDrawLayer("BACKGROUND")
	HealthBackdrop:SetSize(unpack(textureConfig.bar_backdrop.size))
	HealthBackdrop:SetPoint(unpack(textureConfig.bar_backdrop.position))
	HealthBackdrop:SetTexture(textureConfig.bar_backdrop.path)
	HealthBackdrop:SetVertexColor(.15, .15, .15, .85)
	Health.Backdrop = HealthBackdrop

	local HealthGlow = Health:CreateTexture()
	HealthGlow:SetDrawLayer("OVERLAY")
	HealthGlow:SetSize(unpack(textureConfig.bar_glow.size))
	HealthGlow:SetPoint(unpack(textureConfig.bar_glow.position))
	HealthGlow:SetTexture(textureConfig.bar_glow.path)
	HealthGlow:SetVertexColor(0, 0, 0, .75)
	Health.Glow = HealthGlow

	local HealthOverlay = Health:CreateTexture()
	HealthOverlay:SetDrawLayer("ARTWORK")
	HealthOverlay:SetSize(unpack(textureConfig.bar_overlay.size))
	HealthOverlay:SetPoint(unpack(textureConfig.bar_overlay.position))
	HealthOverlay:SetTexture(textureConfig.bar_overlay.path)
	HealthOverlay:SetAlpha(.5)
	Health.Overlay = HealthOverlay

	local HealthValue = Health:CreateFontString()
	HealthValue:SetDrawLayer("OVERLAY")
	HealthValue:SetPoint(unpack(widgetConfig.health.value.place))
	HealthValue:SetFontObject(widgetConfig.health.value.fontObject)
	HealthValue:SetTextColor(unpack(widgetConfig.health.value.color))
	Health.Value = HealthValue


	-- Cast bar
	local CastHolder = self:CreateFrame("Frame")
	CastHolder:SetSize(unpack(widgetConfig.cast.size))
	CastHolder:SetPoint(unpack(widgetConfig.cast.place))

	local Cast = CastHolder:CreateStatusBar()
	Cast:Hide()
	Cast:SetAllPoints()
	Cast:SetStatusBarTexture(textureConfig.bar_texture.path)
	Cast:SetStatusBarColor(unpack(widgetConfig.cast.color))

	local CastShadow = Cast:CreateTexture()
	CastShadow:Hide()
	CastShadow:SetDrawLayer("BACKGROUND")
	CastShadow:SetSize(unpack(textureConfig.bar_glow.size))
	CastShadow:SetPoint(unpack(textureConfig.bar_glow.position))
	CastShadow:SetTexture(textureConfig.bar_glow.path)
	CastShadow:SetVertexColor(0, 0, 0, 1)
	--CastShadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
	Cast.Shadow = CastShadow

	local CastBackdrop = Cast:CreateTexture()
	CastBackdrop:SetDrawLayer("BACKGROUND")
	CastBackdrop:SetSize(unpack(textureConfig.bar_backdrop.size))
	CastBackdrop:SetPoint(unpack(textureConfig.bar_backdrop.position))
	CastBackdrop:SetTexture(textureConfig.bar_backdrop.path)
	CastBackdrop:SetVertexColor(0, 0, 0, 1)
	Cast.Backdrop = CastBackdrop

	local CastGlow = Cast:CreateTexture()
	CastGlow:SetDrawLayer("OVERLAY")
	CastGlow:SetSize(unpack(textureConfig.bar_glow.size))
	CastGlow:SetPoint(unpack(textureConfig.bar_glow.position))
	CastGlow:SetTexture(textureConfig.bar_glow.path)
	CastGlow:SetVertexColor(0, 0, 0, .75)
	--CastGlow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
	Cast.Glow = CastGlow

	local CastOverlay = Cast:CreateTexture()
	CastOverlay:SetDrawLayer("ARTWORK")
	CastOverlay:SetSize(unpack(textureConfig.bar_overlay.size))
	CastOverlay:SetPoint(unpack(textureConfig.bar_overlay.position))
	CastOverlay:SetTexture(textureConfig.bar_overlay.path)
	CastOverlay:SetAlpha(.5)
	Cast.Overlay = CastOverlay

	local CastValue = Cast:CreateFontString()
	CastValue:SetDrawLayer("OVERLAY")
	CastValue:SetJustifyV("TOP")
	CastValue:SetHeight(10)
	--CastValue:SetPoint("BOTTOM", Cast, "TOP", 0, 6)
	CastValue:SetPoint("TOPLEFT", Cast, "TOPRIGHT", 4, -(Cast:GetHeight() - Cast:GetHeight())/2)
	CastValue:SetFontObject(DiabolicFont_SansBold10)
	CastValue:SetTextColor(C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3])
	CastValue:Hide()
	Cast.Value = CastValue

	-- Cast icon (Wrath)
	local CastIcon = CastHolder:CreateTexture(nil, "ARTWORK")
	CastIcon:SetSize(18, 18)                         -- small, tidy icon
	CastIcon:SetPoint("RIGHT", Cast, "LEFT", -6, 0)  -- to the left of the bar
	CastIcon:SetTexCoord(5/64, 59/64, 5/64, 59/64)   -- trim the default icon edges
	Cast.Icon = CastIcon


	-- Cast Name
	local CastName = Cast:CreateFontString()
	CastName:SetDrawLayer("OVERLAY")
	CastName:SetPoint(unpack(widgetConfig.cast.name.place))
	CastName:SetFontObject(widgetConfig.cast.name.fontObject)
	CastName:SetTextColor(unpack(widgetConfig.cast.name.color))
	Cast.Name = CastName

	-- This is a total copout, but it does what we want,
	-- which is to replace the health value text with spell name.
	Cast:HookScript("OnShow", function()
		CastShadow:Show()
		CastGlow:Show()
		if Cast.Icon then Cast.Icon:Show() end
	end)
	Cast:HookScript("OnHide", function()
		CastShadow:Hide()
		CastGlow:Hide()
		if Cast.Icon then Cast.Icon:SetTexture(nil); Cast.Icon:Hide() end
	end)


	-- Cast Name
	--local Spell = Cast:CreateFrame()
	--SpellName = Spell:CreateFontString()
	--SpellName:SetDrawLayer("OVERLAY")
	--SpellName:SetPoint("BOTTOM", Health, "TOP", 0, 6)
	--SpellName:SetFontObject(DiabolicFont_SansBold10)
	--SpellName:SetTextColor(C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3])
	--Spell.Name = SpellName

	-- Cast Icon
	--SpellIcon = Spell:CreateTexture()
	--Spell.Icon = SpellIcon

	--SpellIconBorder = Spell:CreateTexture()
	--Spell.Icon.Border = SpellIconBorder

	--SpellIconShield = Spell:CreateTexture()
	--Spell.Icon.Shield = SpellIconShield

	--SpellIconShade = Spell:CreateTexture()
	--Spell.Icon.Shade = SpellIconShade

	-- Mouse hover highlight
	local Highlight = Health:CreateTexture()
	Highlight:Hide()
	Highlight:SetAllPoints()
	Highlight:SetBlendMode("ADD")
	Highlight:SetColorTexture(1, 1, 1, 1/4)
	Highlight:SetDrawLayer("BACKGROUND", 1)

	-- Unit Level
	local Level = Health:CreateFontString()
	Level:SetDrawLayer("OVERLAY")
	Level:SetFontObject(DiabolicFont_SansBold10)
	Level:SetTextColor(C.General.OffWhite[1], C.General.OffWhite[2], C.General.OffWhite[3])
	Level:SetJustifyV("TOP")
	Level:SetHeight(10)
	Level:SetPoint("TOPLEFT", Health, "TOPRIGHT", 4, -(Health:GetHeight() - Level:GetHeight())/2)


	-- Icons
	local EliteIcon = Health:CreateTexture()
	EliteIcon:Hide()

	local RaidIcon = Health:CreateTexture()
	RaidIcon:Hide()

	local BossIcon = Health:CreateTexture()
	BossIcon:SetSize(18, 18)
	BossIcon:SetTexture(BOSS_TEXTURE)
	BossIcon:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", 2, 2)
	BossIcon:Hide()

	-- Auras
	local Auras = self:CreateFrame()
	Auras:Hide()
	Auras:SetPoint(unpack(widgetConfig.auras.place))
	Auras:SetWidth(widgetConfig.auras.rowsize * widgetConfig.auras.button.size[1] + ((widgetConfig.auras.rowsize - 1) * widgetConfig.auras.padding))
	Auras:SetHeight(widgetConfig.auras.button.size[2])

	-- GitHub issue #62: Experimental CC highlight suggested by dualcoding.
	-- https://github.com/cogwerkz/DiabolicUI/issues/62
	self.Health = Health
	self.Cast = Cast
	self.Auras = Auras
	self.Highlight = Highlight
	self.Level = Level
	self.EliteIcon = EliteIcon
	self.RaidIcon = RaidIcon
	self.BossIcon = BossIcon
	self.Auras = Auras
end

-- Create the sizer frame that handles nameplate positioning
NamePlate.CreateSizer = function(self, baseFrame, worldFrame)
	local sizer = self:CreateFrame()
	sizer.plate = self
	sizer.worldFrame = worldFrame
	sizer:SetPoint("BOTTOMLEFT", worldFrame, "BOTTOMLEFT", 0, 0)
	sizer:SetPoint("TOPRIGHT", baseFrame, "TOP", 0, 0)
	sizer:SetScript("OnSizeChanged", function(self, width, height)
		local plate = self.plate
		plate:Hide()
		plate:SetPoint("TOP", self.worldFrame, "BOTTOMLEFT", width, height)
		plate:Show()
	end)
end


-- This is where a name plate is first created,
-- but it hasn't been assigned a unit (Legion) or shown yet.
Module.CreateNamePlate = function(self, baseFrame, name)
	local config = self.config
	local worldFrame = self.worldFrame

	local plate = setmetatable(Engine:CreateFrame("Frame", "Engine" .. (name or baseFrame:GetName()), worldFrame), NamePlate_WotLK_MT)
	plate.info = {}
	plate.config = config
	plate.allPlates = self.allPlates
	plate.visiblePlates = self.visiblePlates
	plate.frameLevel = FRAMELEVEL_CURRENT -- storing the framelevel
	plate.targetAlpha = 0
	plate.currentAlpha = 0

	-- Since constantly updating frame levels can cause quite the performance drop,
	-- we're just giving each frame a set frame level when they spawn.
	-- We can still get frames overlapping, but in most cases we avoid it now.
	-- Targets, bosses and rares have an elevated frame level,
	-- but when a nameplate returns to "normal" status, its previous stored level is used instead.
	FRAMELEVEL_CURRENT = FRAMELEVEL_CURRENT + FRAMELEVEL_STEP
	if FRAMELEVEL_CURRENT > FRAMELEVEL_MAX then
		FRAMELEVEL_CURRENT = FRAMELEVEL_MIN
	end

	plate:Hide()
	plate:SetAlpha(0)
	plate:SetFrameLevel(plate.frameLevel)
	plate:SetScale(SCALE)
	plate:SetSize(unpack(config.size))
	plate:HandleBaseFrame(baseFrame) -- hide and reference the baseFrame and original blizzard objects
	plate:CreateRegions() -- create our custom regions and objects

	plate:CreateSizer(baseFrame, worldFrame) -- create the sizer that positions the nameplate
	plate:HookScripts(baseFrame, worldFrame)

	-- Support for WeakAuras personal resource display attachment! :)
	-- (We're pretty much faking it, pretending to be KUINamePlates)
	if WEAKAURAS then
		local background = plate:CreateFrame("Frame")
		background:SetFrameLevel(1)

		local anchor = plate:CreateFrame("Frame")
		anchor:SetPoint("TOPLEFT", plate.Health, 0, 0)
		anchor:SetPoint("BOTTOMRIGHT", plate.Cast, 0, 0)

		baseFrame.kui = background
		baseFrame.kui.bg = anchor
	end

	plate.allPlates[baseFrame] = plate

	return plate
end


-- NamePlate Handling
----------------------------------------------------------
-- Not actually something we're going to do
Module.UpdateNamePlateOptions = function(self)
end

-- Adjust the maximum distance from which a Legion nameplate is visible.
Module.UpdateNamePlateMaxDistance = function(self)
end

Module.UpdateAllScales = function(self)
	local oldScale = SCALE
	local scale = UICenter:GetEffectiveScale()
	if scale then
		SCALE = scale
	end
	if (oldScale ~= SCALE) then
		for baseFrame, plate in pairs(self.allPlates) do
			if plate then
				plate:SetScale(SCALE)
			end
		end
	end
end


-- NamePlate Event Handling
----------------------------------------------------------
local hasSetBlizzardSettings
Module.OnEvent = function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then

		if (not hasSetBlizzardSettings) then
			self:UpdateBlizzardSettings()
			hasSetBlizzardSettings = true
		end
		self:UpdateAllScales()
		self.Updater:SetScript("OnUpdate", function(_, ...) self:OnUpdate(...) end)
	--elseif (event == "PLAYER_CONTROL_GAINED") then
		--for baseFrame, plate in pairs(self.allPlates) do
		--	plate:UpdateAll()
		--end

	--elseif (event == "PLAYER_CONTROL_LOST") then
		--for baseFrame, plate in pairs(self.allPlates) do
		--	plate:UpdateAll()
		--end

	elseif (event == "PLAYER_TARGET_CHANGED") then
		local oldTarget = TARGET
		local name, realm = UnitName("target")
		if (name and realm) then
			TARGET = name..realm
		elseif name then
			TARGET = name
		else
			TARGET = false
		end
		if (oldTarget ~= TARGET) then
			FORCEUPDATE = "TARGET" -- initiate alpha changes
		end

		-- If the new target was already casting, force-show its castbar.
		if UnitCastingInfo("target") then
			self:OnSpellCast("UNIT_SPELLCAST_START", "target")
		elseif UnitChannelInfo("target") then
			self:OnSpellCast("UNIT_SPELLCAST_CHANNEL_START", "target")
		end

	elseif ((event == "PLAYER_REGEN_ENABLED") or (event == "PLAYER_REGEN_DISABLED")) then
		COMBAT = InCombatLockdown()

	elseif event == "RAID_TARGET_UPDATE" then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateRaidTarget()
		end

	elseif (event == "UNIT_FACTION") then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateFaction()
		end

	elseif (event == "UNIT_THREAT_SITUATION_UPDATE") then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateThreat()
		end

	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateAll()
		end

	elseif (event == "UNIT_LEVEL") then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateLevel()
		end

	elseif (event == "PLAYER_LEVEL_UP") then
		local level = ...
		if (level and (level > LEVEL)) then
			LEVEL = level
		else
			local level = UnitLevel("player")
			if (level > LEVEL) then
				LEVEL = level
			end
		end

	elseif (event == "DISPLAY_SIZE_CHANGED") then
		self:UpdateAllScales()

	elseif (event == "UI_SCALE_CHANGED") then
		self:UpdateAllScales()
	end
end

Module.OnSpellCast = function(self, event, unit)
	-- Only care about units Wrath exposes cast info for.
	if not unit or (unit ~= "target" and unit ~= "focus" and unit ~= "mouseover") then
		return
	end

	-- Find the visible plate that matches this unit's name.
	local name = UnitName(unit)
	if not name then return end

	local plate
	for baseFrame, p in pairs(self.allPlates) do
		-- Only consider visible/active plates and match by the cached plate name.
		if self.visiblePlates[p] and p.info and p.info.name == name then
			plate = p
			break
		end
	end
	if not plate then return end

	local castBar = plate.Cast
	if not CastData[castBar] then
		CastData[castBar] = {}
	end
	local castData = CastData[castBar]
	if not CastBarPool[plate] then
		CastBarPool[plate] = castBar
	end

	if event == "UNIT_SPELLCAST_START" then
		local spellName, _, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
		if not spellName then
			castBar:Hide()
			return
		end

		-- Wrath returns ms; convert to seconds.
		local now = GetTime()
		startTime = startTime / 1000
		endTime = endTime / 1000

		castData.casting   = true
		castData.channeling = nil
		castData.duration  = now - startTime
		castData.max       = endTime - startTime
		castData.delay     = 0
		castData.tradeskill = isTradeSkill
		castData.interrupt = nil -- Wrath doesn't give interruptible flag here.
		castData.unit = unit

		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(castData.duration)

		if castBar.Name then castBar.Name:SetText(utf8sub(text or spellName, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end

		-- Use default Diabolic glow/shadow (already skinned)
		if castBar.Shield then
			castBar.Shield:Hide()
			castBar.Glow:SetVertexColor(0, 0, 0, .75)
			castBar.Shadow:SetVertexColor(0, 0, 0, 1)
		end

		castBar:Show()

	elseif event == "UNIT_SPELLCAST_DELAYED" then
		-- Re-query to adjust timing.
		local spellName, _, _, _, startTime, endTime = UnitCastingInfo(unit)
		if not (spellName and castData.casting) then return end
		startTime = startTime / 1000
		endTime   = endTime / 1000
		local now = GetTime()
		local newDur = now - startTime
		castData.delay   = (castData.delay or 0) + (newDur - (castData.duration or 0))
		castData.duration = newDur
		castData.max      = endTime - startTime
		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(castData.duration)

	elseif event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" then
		castData.casting   = nil
		castData.channeling = nil
		castData.tradeskill = nil
		castData.interrupt  = nil
		castBar:SetValue(0)
		castBar:Hide()
		if castBar.Icon then castBar.Icon:SetTexture(nil); castBar.Icon:Hide() end

	elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
		local name2, _, text, texture, startTime, endTime = UnitChannelInfo(unit)
		if not name2 then
			castBar:Hide()
			return
		end
		startTime = startTime / 1000
		endTime   = endTime / 1000

		castData.casting    = nil
		castData.channeling = true
		castData.delay      = 0
		castData.duration   = endTime - GetTime()         -- channels count down
		castData.max        = endTime - startTime

		if castBar.Name then castBar.Name:SetText(utf8sub(text or name2, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end

		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(castData.duration)
		castBar:Show()

	elseif event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
		local name2, _, _, _, startTime, endTime = UnitChannelInfo(unit)
		if not (name2 and castData.duration) then return end
		local duration = (endTime / 1000) - GetTime()
		castData.delay    = (castData.delay or 0) + castData.duration - duration
		castData.duration = duration
		castData.max      = (endTime - startTime) / 1000
		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(duration)

	elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
		if castBar:IsShown() then
			castData.channeling = nil
			castData.interrupt  = nil
			castBar:SetValue(castData.max or 0)
			castBar:Hide()
			if castBar.Icon then castBar.Icon:SetTexture(nil); castBar.Icon:Hide() end
		end

	else
		-- Fallback: if we get here via manual checks, try to show a cast.
		if UnitCastingInfo(unit) then
			return self:OnSpellCast("UNIT_SPELLCAST_START", unit)
		end
		if UnitChannelInfo(unit) then
			return self:OnSpellCast("UNIT_SPELLCAST_CHANNEL_START", unit)
		end
		-- Otherwise clear.
		castData.casting, castData.channeling = nil, nil
		castBar:SetValue(0)
		castBar:Hide()
	end
end or Module.OnSpellCast

-- NamePlate Update Cycle
----------------------------------------------------------

-- Proxy function to allow us to exit the update by returning,
-- but still continue looping through the remaining castbars, if any!
Module.UpdateCastBar = function(self, castBar, unit, castData, elapsed)

	unit = unit or (castData and castData.unit)
	if (not UnitExists(unit)) then
		castData.casting = nil
		castData.castID = nil
		castData.channeling = nil
		castBar:SetValue(0)
		castBar:Hide()
		return
	end
	local r, g, b
	if (castData.casting or castData.tradeskill) then
		local duration = castData.duration + elapsed
		if (duration >= castData.max) then
			castData.casting = nil
			castData.tradeskill = nil
			castData.total = nil
			castBar:Hide()
		end
		if castBar.Value then
			if castData.tradeskill then
				castBar.Value:SetText(formatTime(castData.max - duration))
			elseif (castData.delay and (castData.delay ~= 0)) then
				castBar.Value:SetFormattedText("%s|cffff0000 -%s|r", formatTime(floor(castData.max - duration)), formatTime(castData.delay))
			else
				castBar.Value:SetText(formatTime(castData.max - duration))
			end
		end
		castData.duration = duration
		castBar:SetValue(duration)

	elseif castData.channeling then
		local duration = castData.duration - elapsed
		if (duration <= 0) then
			castData.channeling = nil
			castBar:Hide()
		end
		if castBar.Value then
			if castData.tradeskill then
				castBar.Value:SetText(formatTime(duration))
			elseif (castData.delay and (castData.delay ~= 0)) then
				castBar.Value:SetFormattedText("%s|cffff0000 -%s|r", formatTime(duration), formatTime(castData.delay))
			else
				castBar.Value:SetText(formatTime(duration))
			end
		end
		castData.duration = duration
		castBar:SetValue(duration)
	else
		castData.casting = nil
		castData.castID = nil
		castData.channeling = nil
		castBar:SetValue(0)
		castBar:Hide()
	end
end

Module.OnUpdate = function(self, elapsed)

	-- If the number of children in the WorldFrame
	--  is different from the number we have stored,
	-- we parse the children to check for new NamePlates.
	for owner, castBar in pairs(CastBarPool) do
		self:UpdateCastBar(castBar, owner.unit, CastData[castBar], elapsed)
	end

	local numChildren = select("#", self.worldFrame:GetChildren())
	if (WORLDFRAME_CHILDREN ~= numChildren) then
		-- Localizing even more to reduce the load when entering large scale raids
		local select = select
		local allPlates = self.allPlates
		local allChildren = self.allChildren
		local worldFrame = self.worldFrame
		local isNamePlate = self.IsNamePlate
		local createNamePlate = self.CreateNamePlate

		for i = 1, numChildren do
			local object = select(i, worldFrame:GetChildren())
			if not(allChildren[object]) then
				local isPlate = isNamePlate(_, object)
				if (isPlate and not(allPlates[object])) then
					-- Update our NamePlate counter
					WORLDFRAME_PLATES = WORLDFRAME_PLATES + 1

					-- Create and show the nameplate
					-- The constructor function returns the plate,
					-- so we can chain the OnShow method in the same call.
					createNamePlate(self, object, "NamePlate"..WORLDFRAME_PLATES):OnShow()
				elseif (not isPlate) then
					allChildren[object] = true
				end
			end
		end

		-- Update our WorldFrame subframe counter to the current number of frames
		WORLDFRAME_CHILDREN = numChildren

		-- Debugging the performance drops in AV and Wintergrasp
		-- by printing out number of new plates and comparing it to when the spikes occur.
		-- *verified that nameplate creation is NOT a reason for the spikes.
		--if WORLDFRAME_PLATES ~= oldNumPlates then
		--	print(("Total plates: %d - New this cycle: %d"):format(WORLDFRAME_PLATES, WORLDFRAME_PLATES - oldNumPlates))
		--end
	end

	self.elapsed = (self.elapsed or 0) + elapsed
	if (self.elapsed < HZ) then
		return
	end

	-- Update visibility, health values and target alpha
	for plate, baseFrame in pairs(self.visiblePlates) do
		if baseFrame then
			local force = FORCEUPDATE or plate.FORCEUPDATE
			if force then
				if (force == "TARGET") then
					plate:UpdateTargetData()
					plate:UpdateAlpha()
					plate:UpdateFrameLevel()
				else
					plate:UpdateAll()
				end
				plate.FORCEUPDATE = false
			else
				plate:UpdateTargetData()
				plate:UpdateAlpha()
				plate:UpdateHealth()
			end
		else
			plate.targetAlpha = 0
		end

		for plate, baseFrame in pairs(self.visiblePlates) do
			if (not baseFrame) then
				plate.targetAlpha = 0
			end

			if (plate.currentAlpha ~= plate.targetAlpha) then
				local difference
				if (plate.targetAlpha > plate.currentAlpha) then
					difference = plate.targetAlpha - plate.currentAlpha
				else
					difference = plate.currentAlpha - plate.targetAlpha
				end

				local step_in = elapsed/(FADE_IN * difference)
				local step_out = elapsed/(FADE_OUT * difference)

				if (plate.targetAlpha > plate.currentAlpha) then
					if (plate.targetAlpha > plate.currentAlpha + step_in) then
						plate.currentAlpha = plate.currentAlpha + step_in -- fade in
					else
						plate.currentAlpha = plate.targetAlpha -- fading done
					end
				elseif (plate.targetAlpha < plate.currentAlpha) then
					if (plate.targetAlpha < plate.currentAlpha - step_out) then
						plate.currentAlpha = plate.currentAlpha - step_out -- fade out
					else
						plate.currentAlpha = plate.targetAlpha -- fading done
					end
				else
					plate.currentAlpha = plate.targetAlpha -- fading done
				end
				plate:SetAlpha(plate.currentAlpha)
			end

			if ((plate.currentAlpha == 0) and (plate.targetAlpha == 0)) then
				plate.visiblePlates[plate] = nil
				plate:Hide()
			end
		end
	end
	FORCEUPDATE = false

	self.elapsed = 0
end


-- NamePlate Parsing (pre Legion)
----------------------------------------------------------
-- Figure out if the given frame is a NamePlate
Module.IsNamePlate = function(self, baseFrame)
	local region = baseFrame:GetRegions()
	return (region and (region:GetObjectType() == "Texture") and (region:GetTexture() == WOTLK_PLATE))
end


-- Blizzard Settings
----------------------------------------------------------
-- Note that setting CVars in Legion is protected,
-- and can only be done outside of combat.

-- Force some blizzard console variables to our liking
Module.UpdateBlizzardSettings = Engine:Wrap(function(self)
	local config = self.config
	local SetCVar = SetCVar

	-- These are from which expansion...? /slap myself for not commenting properly!!

	--SetCVar("bloatthreat", 0) -- scale plates based on the gained threat on a mob with multiple threat targets. weird.
	--SetCVar("bloattest", 0) -- weird setting that shrinks plates for values > 0
	--SetCVar("bloatnameplates", 0) -- don't change frame size based on threat. it's silly.
	--SetCVar("repositionfrequency", 1) -- don't skip frames between updates
	--SetCVar("ShowClassColorInNameplate", 1) -- display class colors -- let the user decide later
	SetCVar("ShowVKeyCastbar", 1) -- display castbars
	--SetCVar("showVKeyCastbarSpellName", 1) -- display spell names on castbars
	--SetCVar("showVKeyCastbarOnlyOnTarget", 0) -- display castbars only on your current target
end)


Module.OnInit = function(self)
	self.config = self:GetDB("NamePlates")
	self.worldFrame = WorldFrame
	self.allPlates = AllPlates
	self.allChildren = AllChildren
	self.visiblePlates = VisiblePlates
end


Module.OnEnable = function(self)

	if (not self.Updater) then
		-- We parent our update frame to the WorldFrame,
		-- as we need it to run even if the user has hidden the UI.
		self.Updater = CreateFrame("Frame", nil, self.worldFrame)

		-- When parented to the WorldFrame, setting the strata to TOOLTIP
		-- will cause its updates to run close to last in the update cycle.
		self.Updater:SetFrameStrata("TOOLTIP")
	end

	self:UpdateBlizzardSettings()

	-- Update
	self:RegisterEvent("PLAYER_CONTROL_GAINED", "OnEvent")
	self:RegisterEvent("PLAYER_CONTROL_LOST", "OnEvent")
	self:RegisterEvent("PLAYER_LEVEL_UP", "OnEvent")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnEvent")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEvent")
	self:RegisterEvent("RAID_TARGET_UPDATE", "OnEvent")
	--self:RegisterEvent("UNIT_FACTION", "OnEvent")
	self:RegisterEvent("UNIT_LEVEL", "OnEvent")
	--self:RegisterEvent("UNIT_TARGET", "OnEvent")
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnEvent")

	-- NamePlate Update Cycles
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")

	-- Scale Changes
	self:RegisterEvent("DISPLAY_SIZE_CHANGED", "OnEvent")
	self:RegisterEvent("UI_SCALE_CHANGED", "OnEvent")

	-- Castbars (Wrath)
	self:RegisterEvent("UNIT_SPELLCAST_START", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_STOP", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "OnSpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "OnSpellCast")
end
