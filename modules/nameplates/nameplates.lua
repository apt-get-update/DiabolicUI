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
local C_NamePlate = _G.C_NamePlate 
local C_NamePlate_GetNamePlateForUnit = C_NamePlate and C_NamePlate.GetNamePlateForUnit
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

-- Client version constants, to avoid extra function calls and database lookups 
-- during the rather performance intensive OnUpdate handling.
-- Hopefully we'll gain a FPS or two by doing this. 
local ENGINE_BFA_820	= Engine:IsBuild("8.2.0")
local ENGINE_BFA 		= Engine:IsBuild("BfA")
local ENGINE_LEGION_730 = Engine:IsBuild("7.3.0")
local ENGINE_LEGION 	= Engine:IsBuild("Legion")
local ENGINE_WOD 		= Engine:IsBuild("WoD")
local ENGINE_MOP 		= Engine:IsBuild("MoP")
local ENGINE_CATA 		= Engine:IsBuild("Cata")
local ENGINE_WOTLK 		= Engine:IsBuild("WotLK")

-- Adding support for WeakAuras' personal resource attachments
local WEAKAURAS = ENGINE_LEGION and Engine:IsAddOnEnabled("WeakAuras")

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

local NamePlate_Cata = setmetatable({}, { __index = NamePlate_WotLK })
local NamePlate_Cata_MT = { __index = NamePlate_Cata }

local NamePlate_MoP = setmetatable({}, { __index = NamePlate_Cata })
local NamePlate_MoP_MT = { __index = NamePlate_MoP }

local NamePlate_WoD = setmetatable({}, { __index = NamePlate_MoP })
local NamePlate_WoD_MT = { __index = NamePlate_WoD }

-- Legion NamePlates do NOT inherit from the other expansions, 
-- as the system for NamePlates was completely changed here. 
local NamePlate_Legion = setmetatable({}, { __index = NamePlate })
local NamePlate_Legion_MT = { __index = NamePlate_Legion }

-- Set the nameplate metatable to whatever the current expansion is.
local NamePlate_Current_MT = ENGINE_LEGION and 	NamePlate_Legion_MT 
						  or ENGINE_WOD and 	NamePlate_WoD_MT 
						  or ENGINE_MOP and 	NamePlate_MoP_MT 
						  or ENGINE_CATA and 	NamePlate_Cata_MT
						  or ENGINE_WOTLK and 	NamePlate_WotLK_MT 



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

	-- Trivial mobs wasn't introduced until WoD
	if ENGINE_WOD then
		info.isTrivial = not(self.old.bars.group:GetScale() > .9)
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
		else 
			if r == 0 and (g > b) and (g + b > 1.5) and (g + b < 1.65) then -- monk?
				info.isNeutral = false
				info.isCivilian = false
				info.isClass = "MONK"
				info.isFriendly = false
				info.isTapped = false
				info.isPlayer = true
				hasClass = true
			else -- enemy player (no class colors enabled)
				info.isNeutral = false
				info.isCivilian = false
				info.isFriendly = false
				info.isTapped = false
				info.isPlayer = false
			end
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



-- Legion Plates
----------------------------------------------------------

NamePlate_Legion.UpdateAlpha = function(self)
	local unit = self.unit
	if (not UnitExists(unit)) then
		return
	end
	if self.visiblePlates[self] then
		if UnitExists("target") then
			if UnitIsUnit(unit, "target") then
				self.targetAlpha = ALPHA_TARGET 
			elseif UnitIsTrivial(unit) then 
				self.targetAlpha = ALPHA_MINIMAL
			elseif UnitIsPlayer(unit) then
				self.targetAlpha = .35 
			elseif UnitIsFriend("player", unit) then
				self.targetAlpha = ALPHA_MINIMAL
			else
				local level = UnitLevel(unit)
				local classificiation = UnitClassification(unit)
				if (classificiation == "worldboss") or (classificiation == "rare") or (classificiation == "rareelite") or (level and level < 1) then
					self.targetAlpha = ALPHA_FULL
				else
					self.targetAlpha = ALPHA_LOW
				end	
			end
		elseif UnitIsTrivial(unit) then 
			self.targetAlpha = ALPHA_TRIVIAL
		elseif UnitIsPlayer(unit) then
			self.targetAlpha = ALPHA_FULL
		elseif UnitIsFriend("player", unit) then
			self.targetAlpha = ALPHA_MINIMAL
		else
			local level = UnitLevel(unit)
			local classificiation = UnitClassification(unit)
			if (classificiation == "worldboss") or (classificiation == "rare") or (classificiation == "rareelite") or (level and level < 1) then
				self.targetAlpha = ALPHA_TARGET
			else
				self.targetAlpha = ALPHA_FULL
			end	
		end
	else
		self.targetAlpha = 0 -- fade out hidden frames
	end
end

NamePlate_Legion.UpdateFrameLevel = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end
	if self.visiblePlates[self] then
		local healthValue = self.Health.Value
		-- We're placing targets at an elevated frame level, 
		-- as we want that frame visible above everything else. 
		if UnitIsUnit(unit, "target") then
			if self:GetFrameLevel() ~= FRAMELEVEL_TARGET then
				self:SetFrameLevel(FRAMELEVEL_TARGET)
			end
			if (not healthValue:IsShown()) then
				healthValue:Show()
			end
		else
			-- We're also elevating rares and bosses to almost the same level as our target, 
			-- as we want these frames to stand out above all the others to make Legion rares easier to see.
			-- Note that this doesn't actually make it easier to click, as we can't raise the secure uniframe itself, 
			-- so it only affects the visible part created by us. 
			local level = UnitLevel(unit)
			local classificiation = UnitClassification(unit)
			if (classificiation == "worldboss") or (classificiation == "rare") or (classificiation == "rareelite") or (level and level < 1) then
				if self:GetFrameLevel() ~= FRAMELEVEL_IMPORTANT then
					self:SetFrameLevel(FRAMELEVEL_IMPORTANT)
				end
				if (not healthValue:IsShown()) then
					healthValue:Show()
				end
			else
				-- If the current nameplate isn't a rare, boss or our target, 
				-- we return it to its original framelevel, if the framelevel has been changed.
				if self:GetFrameLevel() ~= self.frameLevel then
					self:SetFrameLevel(self.frameLevel)
				end
				if healthValue:IsShown() then
					healthValue:Hide()
				end
			end
		end
	end
end

NamePlate_Legion.UpdateHealth = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end
	
	local oldHealth = self.Health:GetValue()
	local _, oldHealthMax = self.Health:GetMinMaxValues()

	local health = UnitHealth(unit)
	local healthMax = UnitHealthMax(unit)

	if (health ~= oldHealth) or (healthMax ~= oldHealthMax) then
		self.Health:SetMinMaxValues(0, healthMax)
		self.Health:SetValue(health)
		self.Health.Value:SetFormattedText("( %s / %s )", abbreviateNumber(health), abbreviateNumber(healthMax))
	end 
end

NamePlate_Legion.UpdateName = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end
end

NamePlate_Legion.UpdateLevel = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end

	local levelstring
	local level = UnitLevel(unit)
	local classificiation = UnitClassification(unit)

	if classificiation == "worldboss" or (level and level < 1) then
		self.BossIcon:Show()
	else
		if level and level > 0 then
			if UnitIsFriend("player", unit) then
				levelstring = C.General.OffWhite.colorCode .. level .. "|r"
			else
				levelstring = (getDifficultyColorByLevel(level)) .. level .. "|r"
			end
			if classificiation == "elite" or classificiation == "rareelite" then
				levelstring = levelstring .. C.Reaction[UnitReaction(unit, "player")].colorCode .. "+|r"
			end
			if classificiation == "rareelite" or classificiation == "rare" then
				levelstring = levelstring .. C.General.DimRed.colorCode .. " (rare)|r"
			end
		end
		self.Level:SetText(levelstring)
		self.BossIcon:Hide()
	end
end

NamePlate_Legion.UpdateColor = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end
	if UnitIsPlayer(unit) then
		if UnitIsFriend("player", unit) then
			self.Health:SetStatusBarColor(unpack(C.Reaction.civilian))
		else
			local _, class = UnitClass(unit)
			if (class and C.Class[class]) then
				self.Health:SetStatusBarColor(unpack(C.Class[class]))
			else
				self.Health:SetStatusBarColor(unpack(C.Reaction[1]))
			end
		end
	elseif UnitIsFriend("player", unit) then
		--self.Health:SetStatusBarColor(unpack(C.Reaction[5])) -- all are Friendly colored
		self.Health:SetStatusBarColor(unpack(C.Reaction[UnitReaction(unit, "player") or 5])) -- All levels of reaction coloring
	elseif UnitIsTapDenied(unit) then
		self.Health:SetStatusBarColor(unpack(C.Status.Tapped))
	else
		local threat = UnitThreatSituation("player", unit)
		if (threat and (threat > 0)) then
			local r, g, b = unpack(C.Threat[threat])
			self.Health:SetStatusBarColor(r, g, b)
		elseif (UnitReaction(unit, "player") == 4) then
			self.Health:SetStatusBarColor(unpack(C.Reaction[4]))
		else
			self.Health:SetStatusBarColor(unpack(C.Reaction[2]))
		end
	end
		
end

NamePlate_Legion.UpdateThreat = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end
	local threat = UnitIsEnemy(unit, "player") and UnitThreatSituation(unit, "player") -- UnitThreatSituation("player", unit)
	if (threat and (threat > 0)) then
		local r, g, b = unpack(C.Threat[threat])
		self.Health.Glow:SetVertexColor(r, g, b, 1)
		self.Health.Shadow:SetVertexColor(r, g, b)
	else
		self.Health.Glow:SetVertexColor(0, 0, 0, .25)
		self.Health.Shadow:SetVertexColor(0, 0, 0, 1)
	end
end

NamePlate_Legion.AddAuraButton = function(self, id)

	local config = self.config.widgets.auras
	local auraConfig = config.button
	local rowsize = config.rowsize
	local gap = config.padding
	local width, height = unpack(auraConfig.size)

	local auras = self.Auras
	local aura = setmetatable(auras:CreateFrame("Frame"), Aura_MT)
	aura:SetID(id)
	aura:SetSize(width, height)
	aura:ClearAllPoints()
	aura:SetPoint(auraConfig.anchor, ((id-1)%rowsize*(width + gap))*auraConfig.growthX, (math_floor((id-1)/rowsize)*(height + gap)*auraConfig.growthY))
	
	aura.Scaffold = aura:CreateFrame("Frame")
	aura.Scaffold:SetPoint("TOPLEFT", aura, 1, -1)
	aura.Scaffold:SetPoint("BOTTOMRIGHT", aura, -1, 1)
	aura.Scaffold:SetBackdrop(auraConfig.backdrop)
	aura.Scaffold:SetBackdropColor(0, 0, 0, 1) 
	aura.Scaffold:SetBackdropBorderColor(.15, .15, .15) 

	aura.Overlay = aura.Scaffold:CreateFrame("Frame") 
	aura.Overlay:SetAllPoints(aura) 
	aura.Overlay:SetFrameLevel(aura.Scaffold:GetFrameLevel() + 2) 

	aura.Icon = aura.Scaffold:CreateTexture() 
	aura.Icon:SetDrawLayer("ARTWORK", 0) 
	aura.Icon:SetSize(unpack(auraConfig.icon.size))
	aura.Icon:SetPoint(unpack(auraConfig.icon.place))
	aura.Icon:SetTexCoord(unpack(auraConfig.icon.texCoord))
	
	aura.Shade = aura.Scaffold:CreateTexture() 
	aura.Shade:SetDrawLayer("ARTWORK", 2) 
	aura.Shade:SetTexture(auraConfig.icon.shade) 
	aura.Shade:SetAllPoints(aura.Icon) 
	aura.Shade:SetVertexColor(0, 0, 0, 1) 

	aura.Time = aura.Overlay:CreateFontString() 
	aura.Time:SetDrawLayer("OVERLAY", 1) 
	aura.Time:SetTextColor(unpack(C.General.OffWhite)) 
	aura.Time:SetFontObject(auraConfig.time.fontObject)
	aura.Time:SetShadowOffset(unpack(auraConfig.time.shadowOffset))
	aura.Time:SetShadowColor(unpack(auraConfig.time.shadowColor))
	aura.Time:SetPoint(unpack(auraConfig.time.place))

	aura.Count = aura.Overlay:CreateFontString() 
	aura.Count:SetDrawLayer("OVERLAY", 1) 
	aura.Count:SetTextColor(unpack(C.General.Normal)) 
	aura.Count:SetFontObject(auraConfig.count.fontObject)
	aura.Count:SetShadowOffset(unpack(auraConfig.count.shadowOffset))
	aura.Count:SetShadowColor(unpack(auraConfig.count.shadowColor))
	aura.Count:SetPoint(unpack(auraConfig.count.place))

	--aura:SetScript("OnEnter", Aura.OnEnter)
	--aura:SetScript("OnLeave", Aura.OnLeave)

	return aura
end

NamePlate_Legion.UpdateAuras = function(self)
	local unit = self.unit
	local auras = self.Auras
	local cc = self.CC

	-- Hide auras from hidden plates, or from the player's personal resource display.
	if (not UnitExists(unit)) or (UnitIsUnit(unit ,"player")) then
		auras:Hide()
		cc:Hide()
		return
	end

	--local classificiation = UnitClassification(unit)
	--if UnitIsTrivial(unit) or (classificiation == "trivial") or (classificiation == "minus") then
	--	auras:Hide()
	--	return
	--end

	local hostilePlayer = UnitIsPlayer(unit) and UnitIsEnemy("player", unit)
	local hostileNPC = UnitCanAttack("player", unit) and (not UnitPlayerControlled(unit))
	local hostile = hostilePlayer or hostileNPC

	local filter
	if hostile then
		--filter = "HARMFUL|PLAYER" -- blizz use INCLUDE_NAME_PLATE_ONLY, but that sucks. So we don't.
		filter = "HARMFUL" -- blizz use INCLUDE_NAME_PLATE_ONLY, but that sucks. So we don't.
	else
		filter = "HELPFUL|PLAYER" -- blizz don't show beneficial auras, but we do. 
	end

	--local reaction = UnitReaction(unit, "player")
	--if reaction then 
	--	if (reaction <= 4) then
	--		-- Reaction 4 is neutral and less than 4 becomes increasingly more hostile
	--		filter = "HARMFUL|PLAYER" -- blizz use INCLUDE_NAME_PLATE_ONLY, but that sucks. So we don't.
	--	else
	--		filter = "HELPFUL|PLAYER" -- blizz don't show beneficial auras, but we do. 
	--	end
	--end

	--local showLoC = (UnitIsPlayer(unit) and UnitIsEnemy("player", unit)) or (reaction and (reaction <= 4))

	local locSpellPrio = -1
	local locSpellID, locSpellIcon, locSpellCount, locDuration, locExpirationTime
	local visible = 0
	if filter then
		for i = 1, BUFF_MAX_DISPLAY do
			
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer = UnitAura(unit, i, filter)
			
			if (not name) then
				break
			end

			-- Leave out auras with a long duration
			if duration and (duration > TIME_LIMIT) then
				name = nil
			end

			if hostile then

				-- Hide Loss of Control from the plates, 
				-- but show it on the big CC display.
				local lossOfControlPrio = AuraData.loc[spellId]
				if lossOfControlPrio then

					-- Display the LoC with higher prio if one already exists 
					if (lossOfControlPrio > locSpellPrio) then
						locSpellID = spellId
						locSpellPrio = lossOfControlPrio
						locSpellIcon = icon
						locSpellCount = count
						locDuration = duration
						locExpirationTime = expirationTime
					end

					-- Leaving all LoC effects out 
					name = nil
				end
			end

			if name and isCastByPlayer then
				visible = visible + 1
				local visibleKey = tostring(visible)

				if (not auras[visibleKey]) then
					auras[visibleKey] = self:AddAuraButton(visible)
				end

				local button = auras[visibleKey]
			
				if (duration and (duration > 0)) then
					button.Time:Show()
				else
					button.Time:Hide()
				end
				
				button.first = true
				button.duration = duration
				button.timeLeft = expirationTime
				button:SetScript("OnUpdate", Aura.CreateTimer)

				if (count > 1) then
					button.Count:SetText(count)
				else
					button.Count:SetText("")
				end

				if filter:find("HARMFUL") then
					local color = C.Debuff[debuffType] 
					if not(color and color.r and color.g and color.b) then
						color = { r = 0.7, g = 0, b = 0 }
					end
					button.Scaffold:SetBackdropBorderColor(color.r, color.g, color.b)
				else
					button.Scaffold:SetBackdropBorderColor(.15, .15, .15)
				end

				button.Icon:SetTexture(icon)
				
				if (not button:IsShown()) then
					button:Show()
				end
			end
		end
	end 

	if (visible == 0) then
		if auras:IsShown() then
			auras:Hide()
		end
	else
		local nextAura = visible + 1
		local visibleKey = tostring(nextAura)
		while (auras[visibleKey]) do
			auras[visibleKey]:Hide()
			auras[visibleKey].Time:Hide()
			auras[visibleKey]:SetScript("OnUpdate", nil)
			nextAura = nextAura + 1
			visibleKey = tostring(nextAura)
		end
		if (not auras:IsShown()) then
			auras:Show()
		end
	end

	-- Display the big LoC icon
	if locSpellID then
		cc.first = true
		cc.duration = locDuration
		cc.timeLeft = locExpirationTime
		cc.currentPrio = locSpellPrio
		cc.currentSpellID = locSpellID

		if (locDuration and (locDuration > 0)) then
			cc.Time:Show()
		else
			cc.Time:Hide()
		end
		cc:SetScript("OnUpdate", Aura.CreateTimer)

		cc.Icon:SetTexture(locSpellIcon)

		if (not cc:IsShown()) then
			cc:Show()
		end
	else
		if cc:IsShown() then
			cc:Hide()
			cc.Time:Hide()
			cc:SetScript("OnUpdate", nil)
		end
		cc.Icon:SetTexture(nil)
		cc.currentPrio = nil
		cc.currentSpellID = nil
	end
			
end

NamePlate_Legion.UpdateRaidTarget = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		self.RaidIcon:Hide()
		return
	end
	local classificiation = UnitClassification(unit)
	local istrivial = UnitIsTrivial(unit) or classificiation == "trivial" or classificiation == "minus"
	if istrivial then
		self.RaidIcon:Hide()
		return
	end
	local index = GetRaidTargetIndex(unit)
	if index then
		SetRaidTargetIconTexture(self.RaidIcon, index)
		self.RaidIcon:Show()
	else
		self.RaidIcon:Hide()
	end
end

NamePlate_Legion.UpdateFaction = function(self)
	self:UpdateName()
	self:UpdateLevel()
	self:UpdateColor()
	self:UpdateThreat()
end

NamePlate_Legion.UpdateAll = function(self)
	self:UpdateAlpha()
	self:UpdateFrameLevel()
	self:UpdateHealth()
	self:UpdateName()
	self:UpdateLevel()
	self:UpdateColor()
	self:UpdateThreat()
	self:UpdateRaidTarget()
	self:UpdateAuras()
end

NamePlate_Legion.OnShow = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end

	-- setup player classbars
	-- setup auras
	-- setup raid targets

	self.Health:Show()
	self.Auras:Hide()
	self.Cast:Hide()

	self:SetAlpha(0) -- set the actual alpha to 0
	self.currentAlpha = 0 -- update stored alpha value
	self:UpdateAll() -- update all elements while it's still transparent
	self:Show() -- make the fully transparent frame visible

	self.visiblePlates[self] = self.baseFrame -- this will trigger the fadein 

	self:UpdateFrameLevel() -- must be called after the plate has been added to VisiblePlates
end

NamePlate_Legion.OnHide = function(self)
	self.visiblePlates[self] = false -- this will trigger the fadeout and hiding
end

NamePlate_Legion.HandleBaseFrame = function(self, baseFrame)
	local unitframe = baseFrame.UnitFrame
	if unitframe then
		unitframe:Hide()
		unitframe:HookScript("OnShow", function(unitframe) unitframe:Hide() end) 
	end
	self.baseFrame = baseFrame
end

NamePlate_Legion.HookScripts = function(self, baseFrame)
	baseFrame:HookScript("OnHide", function(baseFrame) self:OnHide() end)
end

-- WoD Plates
----------------------------------------------------------
NamePlate_WoD.HookScripts = function(self, baseFrame)
	baseFrame:HookScript("OnShow", function(baseFrame) self:OnShow() end)
	baseFrame:HookScript("OnHide", function(baseFrame) self:OnHide() end)

	self.old.bars.health:HookScript("OnValueChanged", function() self:UpdateHealth() end)
	self.old.bars.health:HookScript("OnMinMaxChanged", function() self:UpdateHealth() end)

	--self.old.bars.cast:HookScript("OnShow", OldcastBar.OnShowCast)
	--self.old.bars.cast:HookScript("OnHide", OldcastBar.OnHideCast)
	--self.old.bars.cast:HookScript("OnValueChanged", OldcastBar.OnUpdateCast)

	-- 6.2.2 absorb bar
	--	self.old.bars.absorb:HookScript("OnShow", OldAbsorbBar.OnShowAbsorb)
	--	self.old.bars.absorb:HookScript("OnHide", OldAbsorbBar.OnHideAbsorb)
	--	self.old.bars.absorb:HookScript("OnValueChanged", OldAbsorbBar.OnUpdateAbsorb)
end

NamePlate_WoD.HandleBaseFrame = function(self, baseFrame)
	local old = {
		baseFrame = baseFrame,
		bars = {}, groups = {}, regions = {} 
	}

	local oldBars = old.bars
	local oldGroups = old.groups
	local oldRegions = old.regions

	oldGroups.bars, 
	oldGroups.name = baseFrame:GetChildren()
	
	local artContainer = baseFrame.ArtContainer

	oldBars.group = oldGroups.bars
	
	-- 6.2.2 healthbar
	oldBars.health = artContainer.HealthBar
	oldBars.health.texture = oldBars.health:GetRegions() 
	
	-- 6.2.2 absorbbar
	oldBars.absorb = artContainer.AbsorbBar
	oldBars.absorb.texture = oldBars.absorb:GetRegions() 
	oldBars.absorb.overlay = oldBars.absorb.Overlay

	-- 6.2.2 castbar
	oldBars.cast = artContainer.castBar
	oldBars.cast.texture = oldBars.cast:GetRegions() 
	
	oldRegions.castborder = artContainer.castBarBorder
	oldRegions.castshield = artContainer.castBarFrameShield
	oldRegions.spellicon = artContainer.castBarSpellIcon
	oldRegions.spelltext = artContainer.castBarText
	oldRegions.spellshadow = artContainer.castBarTextBG
	
	-- 6.2.2 frame
	oldRegions.threat = artContainer.AggroWarningTexture
	oldRegions.healthborder = artContainer.Border
	oldRegions.highlight = artContainer.Highlight
	oldRegions.level = artContainer.LevelText
	oldRegions.bossicon = artContainer.HighLevelIcon
	oldRegions.raidicon = artContainer.RaidTargetIcon
	oldRegions.eliteicon = artContainer.EliteIcon

	-- 6.2.2 name
	oldRegions.name = baseFrame.NameContainer.NameText
		
	-- kill off everything blizzard
	oldBars.health:SetStatusBarTexture(EMPTY_TEXTURE)
	oldBars.health:Hide()
	oldBars.cast:SetStatusBarTexture(EMPTY_TEXTURE)
	oldGroups.name:Hide()
	oldRegions.name:Hide()
	oldRegions.threat:SetTexture(nil)
	oldRegions.healthborder:Hide()
	--oldRegions.highlight:SetTexture(nil)

	oldBars.absorb:SetStatusBarTexture(EMPTY_TEXTURE)

	oldRegions.level:SetWidth(.0001)
	oldRegions.level:Hide()
	oldRegions.bossicon:SetTexture(nil)
	oldRegions.raidicon:SetAlpha(0)
	-- oldRegions.eliteicon:SetTexture(nil)
	UIHider[oldRegions.eliteicon] = oldRegions.eliteicon:GetParent()
	oldRegions.eliteicon:SetParent(UIHider)
	oldRegions.castborder:SetTexture(nil)
	oldRegions.castshield:SetTexture(nil)
	oldRegions.spellicon:SetTexCoord(0, 0, 0, 0)
	oldRegions.spellicon:SetWidth(.0001)
	oldRegions.spellshadow:SetTexture(nil)
	oldRegions.spellshadow:Hide()
	oldRegions.spelltext:Hide()

	-- 6.2.2 absorb bar
	oldBars.absorb.texture:SetTexture(nil)
	oldBars.absorb.texture:Hide()
	oldBars.absorb.overlay:SetTexture(nil)
	oldBars.absorb.overlay:Hide()

	self.baseFrame = baseFrame
	self.old = old

	return old
end

-- MoP Plates
----------------------------------------------------------
NamePlate_MoP.HandleBaseFrame = function(self, baseFrame)
	local old = {
		baseFrame = baseFrame,
		bars = {}, frames = {}, regions = {} 
	}
	
	local oldBars = old.bars
	local oldFrames = old.frames
	local oldRegions = old.regions

	oldFrames.bars, 
	oldFrames.name = baseFrame:GetChildren()

	oldBars.health, 
	oldBars.cast = oldFrames.bars:GetChildren()

	oldRegions.castbar, 
	oldRegions.castborder, 
	oldRegions.castshield, 
	oldRegions.casticon,
	oldRegions.casttext,
	oldRegions.castshadow = oldBars.cast:GetRegions()

	oldRegions.threat, 
	oldRegions.healthborder, 
	oldRegions.highlight, 
	oldRegions.level,  
	oldRegions.bossicon, 
	oldRegions.raidicon, 
	oldRegions.eliteicon = oldFrames.bars:GetRegions()

	oldRegions.name = oldFrames.name:GetRegions()

	oldBars.health:SetStatusBarTexture(EMPTY_TEXTURE)
	oldBars.health:Hide()
	oldBars.cast:SetStatusBarTexture(EMPTY_TEXTURE)
	oldRegions.name:Hide()
	oldRegions.threat:SetTexture(nil)
	oldRegions.healthborder:Hide()
	oldRegions.highlight:SetTexture(nil)

	oldRegions.level:SetWidth(.0001)
	oldRegions.level:Hide()
	oldRegions.bossicon:SetTexture(nil)
	oldRegions.raidicon:SetAlpha(0)
	-- oldRegions.eliteicon:SetTexture(nil)
	UIHider[oldRegions.eliteicon] = oldRegions.eliteicon:GetParent() -- not here?
	oldRegions.eliteicon:SetParent(UIHider)
	oldRegions.castborder:SetTexture(nil)
	oldRegions.castshield:SetTexture(nil)
	oldRegions.casticon:SetTexCoord(0, 0, 0, 0)
	oldRegions.casticon:SetWidth(.0001)
	
	oldRegions.casttext:SetWidth(.0001)
	oldRegions.casttext:Hide()
	oldRegions.castshadow:SetTexture(nil)

	self.baseFrame = baseFrame
	self.old = old

	return old
end

-- Cata Plates
----------------------------------------------------------
NamePlate_Cata.HandleBaseFrame = function(self, baseFrame)
	local old = { 
		baseFrame = baseFrame, 
		bars = {}, regions = {} 
	}

	local oldBars = old.bars
	local oldRegions = old.regions

	oldBars.health, 
	oldBars.cast = baseFrame:GetChildren()

	oldRegions.castbar, -- what is this?
	oldRegions.castborder, 
	oldRegions.castshield, 
	oldRegions.casticon = oldBars.cast:GetRegions()

	oldRegions.threat, 
	oldRegions.healthborder, 
	oldRegions.highlight, 
	oldRegions.name, 
	oldRegions.level, 
	oldRegions.bossicon, 
	oldRegions.raidicon, 
	oldRegions.eliteicon = baseFrame:GetRegions()

	oldBars.health:SetStatusBarTexture(EMPTY_TEXTURE)
	oldBars.health:Hide()
	oldBars.cast:SetStatusBarTexture(EMPTY_TEXTURE)
	oldRegions.name:Hide()
	oldRegions.threat:SetTexture(nil)
	oldRegions.healthborder:Hide()
	oldRegions.highlight:SetTexture(nil)

	oldRegions.level:SetWidth(.0001)
	oldRegions.level:Hide()
	oldRegions.bossicon:SetTexture(nil)
	oldRegions.raidicon:SetAlpha(0)
	-- oldRegions.eliteicon:SetTexture(nil)
	UIHider[oldRegions.eliteicon] = oldRegions.eliteicon:GetParent()
	oldRegions.eliteicon:SetParent(UIHider)
	oldRegions.castborder:SetTexture(nil)
	oldRegions.castshield:SetTexture(nil)
	oldRegions.casticon:SetTexCoord(0, 0, 0, 0)
	oldRegions.casticon:SetWidth(.0001)

	self.baseFrame = baseFrame
	self.old = old

	return old
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
	if ENGINE_LEGION then
		local cc = widgetConfig.cc -- adding a tiny amount of speed
		local CC = self:CreateFrame()
		CC:Hide() 
		CC:SetPoint(unpack(cc.place))
		CC:SetSize(unpack(cc.size))

		CC.Glow = CC:CreateFrame()
		CC.Glow:SetFrameLevel(CC:GetFrameLevel())
		CC.Glow:SetSize(unpack(cc.glow.size))
		CC.Glow:SetPoint(unpack(cc.glow.place))
		CC.Glow:SetBackdrop(cc.glow.backdrop)
		CC.Glow:SetBackdropColor(0, 0, 0, 0)
		CC.Glow:SetBackdropBorderColor(unpack(cc.glow.borderColor)) 

		CC.Scaffold = CC:CreateFrame()
		CC.Scaffold:SetFrameLevel(CC:GetFrameLevel() + 1)
		CC.Scaffold:SetAllPoints()

		CC.Border = CC:CreateFrame("Frame")
		CC.Border:SetFrameLevel(CC:GetFrameLevel() + 2)
		CC.Border:SetSize(unpack(cc.border.size))
		CC.Border:SetPoint(unpack(cc.border.place))
		CC.Border:SetBackdrop(cc.border.backdrop) 
		CC.Border:SetBackdropColor(0, 0, 0, 0)
		CC.Border:SetBackdropBorderColor(unpack(cc.border.borderColor))

		CC.Icon = CC.Scaffold:CreateTexture() 
		CC.Icon:SetDrawLayer("BACKGROUND") 
		CC.Icon:SetSize(unpack(cc.icon.size))
		CC.Icon:SetPoint(unpack(cc.icon.place))
		CC.Icon:SetTexCoord(unpack(cc.icon.texCoord))
		
		CC.Icon.Shade = CC.Scaffold:CreateTexture() 
		CC.Icon.Shade:SetDrawLayer("BORDER") 
		CC.Icon.Shade:SetSize(unpack(cc.icon.shade.size)) 
		CC.Icon.Shade:SetPoint(unpack(cc.icon.shade.place)) 
		CC.Icon.Shade:SetTexture(cc.icon.shade.path) 
		CC.Icon.Shade:SetVertexColor(unpack(cc.icon.shade.color)) 

		CC.Overlay = CC:CreateFrame("Frame") 
		CC.Overlay:SetFrameLevel(CC:GetFrameLevel() + 3)
		CC.Overlay:SetAllPoints() 

		CC.Time = CC.Overlay:CreateFontString() 
		CC.Time:SetDrawLayer("OVERLAY") 
		CC.Time:SetTextColor(unpack(C.General.OffWhite)) 
		CC.Time:SetFontObject(cc.time.fontObject)
		CC.Time:SetShadowOffset(unpack(cc.time.shadowOffset))
		CC.Time:SetShadowColor(unpack(cc.time.shadowColor))
		CC.Time:SetPoint(unpack(cc.time.place))
	
		CC.Count = CC.Overlay:CreateFontString() 
		CC.Count:SetDrawLayer("OVERLAY") 
		CC.Count:SetTextColor(unpack(C.General.Normal)) 
		CC.Count:SetFontObject(cc.count.fontObject)
		CC.Count:SetShadowOffset(unpack(cc.count.shadowOffset))
		CC.Count:SetShadowColor(unpack(cc.count.shadowColor))
		CC.Count:SetPoint(unpack(cc.count.place))

		self.CC = CC
	end

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
-- *Blizzard changed nameplate format and also anchoring points in Legion,
--  so naturally we're using a different function for this too. Speed!
NamePlate_Legion.CreateSizer = function(self, baseFrame, worldFrame)
	local sizer = self:CreateFrame()
	sizer.plate = self
	sizer.worldFrame = worldFrame
	sizer:SetPoint("BOTTOMLEFT", worldFrame, "BOTTOMLEFT", 0, 0)
	sizer:SetPoint("TOPRIGHT", baseFrame, "CENTER", 0, 0)
	sizer:SetScript("OnSizeChanged", function(self, width, height)
		local plate = self.plate
		plate:Hide()
		plate:SetPoint("TOP", self.worldFrame, "BOTTOMLEFT", width, height)
		plate:Show()
	end)
end

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
	
	local plate = setmetatable(Engine:CreateFrame("Frame", "Engine" .. (name or baseFrame:GetName()), worldFrame), NamePlate_Current_MT)
	plate.info = not(ENGINE_LEGION) and {} or nil
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

	if (ENGINE_BFA_820) then 
		plate:SetPoint("TOP", baseFrame, "TOP", 0, 0)
		plate:Show()
	else
		plate:CreateSizer(baseFrame, worldFrame) -- create the sizer that positions the nameplate
	end 
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
Module.UpdateNamePlateMaxDistance = ENGINE_LEGION and Engine:Wrap(function(self)
	if IsInInstance() then
		SetCVar("nameplateMaxDistance", 45)
	else
		SetCVar("nameplateMaxDistance", 30)
	end
end)

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
Module.OnEvent = ENGINE_LEGION and function(self, event, ...)

	-- This is called when new Legion plates are spawned
	if (event == "NAME_PLATE_CREATED") then
		self:CreateNamePlate((...)) -- local namePlateFrameBase = ...

	-- This is called when Legion plates are shown
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		local unit = ...
		local baseFrame = C_NamePlate_GetNamePlateForUnit(unit)
		local plate = baseFrame and self.allPlates[baseFrame] 
		if plate then
			plate.unit = unit
			plate:OnShow(unit)
		end

	-- This is called when Legion plates are hidden
	elseif (event == "NAME_PLATE_UNIT_REMOVED") then
		local unit = ...
		local baseFrame = C_NamePlate_GetNamePlateForUnit(unit)
		local plate = baseFrame and self.allPlates[baseFrame] 
		if plate then
			plate.unit = nil
			plate:OnHide()
		end

	elseif (event == "PLAYER_TARGET_CHANGED") then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateAlpha()
			plate:UpdateFrameLevel()
		end	
		
	elseif (event == "UNIT_AURA") then
		local unit = ...
		local baseFrame = C_NamePlate_GetNamePlateForUnit(unit)
		local plate = baseFrame and self.allPlates[baseFrame]
		if plate then
			plate:UpdateAuras()
		end
		
	--elseif (event == "VARIABLES_LOADED") then
	--	self:UpdateNamePlateOptions()
	
	--elseif event == "CVAR_UPDATE" then
	--	local name = ...
	--	if name == "SHOW_CLASS_COLOR_IN_V_KEY" or name == "SHOW_NAMEPLATE_LOSE_AGGRO_FLASH" then
	--		self:UpdateNamePlateOptions()
	--	end

	elseif (event == "UNIT_FACTION") then
		local unit = ...
		local baseFrame = C_NamePlate_GetNamePlateForUnit(unit)
		local plate = baseFrame and self.allPlates[baseFrame] 
		if plate then
			plate:UpdateFaction()
		end

	elseif (event == "UNIT_THREAT_SITUATION_UPDATE") then
		for baseFrame, plate in pairs(self.allPlates) do
			plate:UpdateColor()
			plate:UpdateThreat()
		end	


	elseif (event == "RAID_TARGET_UPDATE") then
		for baseFrame, plate in pairs(self.allPlates) do
		end

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (not hasSetBlizzardSettings) then
			if _G.C_NamePlate then
				self:UpdateBlizzardSettings()
			else
				self:RegisterEvent("ADDON_LOADED", "OnEvent")
			end
			hasSetBlizzardSettings = true
		end
		self:UpdateAllScales()
		self:UpdateNamePlateMaxDistance() -- Only available in Legion
		self.Updater:SetScript("OnUpdate", function(_, ...) self:OnUpdate(...) end)

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
		self:UpdateNamePlateOptions()
		self:UpdateAllScales()

	elseif (event == "UI_SCALE_CHANGED") then
		self:UpdateAllScales()

	elseif (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == "Blizzard_NamePlates") then
			self:UpdateBlizzardSettings()
			self:UnregisterEvent("ADDON_LOADED")
		end

	end
end
or ENGINE_WOTLK and function(self, event, ...)
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

Module.OnSpellCast = ENGINE_BFA and function(self, event, unit, ...)
	if ((not unit) or (not UnitExists(unit))) then
		return
	end

	local baseFrame = C_NamePlate_GetNamePlateForUnit(unit)
	local plate = baseFrame and self.allPlates[baseFrame] 
	if (not plate) then
		return
	end

	local castBar = plate.Cast
	if (not CastData[castBar]) then
		CastData[castBar] = {}
	end

	local castData = CastData[castBar]
	if (not CastBarPool[plate]) then
		CastBarPool[plate] = castBar
	end

	if (event == "UNIT_SPELLCAST_START") then
		local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
		if (not name) then
			castBar:Hide()
			return
		end

		endTime = endTime / 1e3
		startTime = startTime / 1e3

		local now = GetTime()
		local max = endTime - startTime

		castData.castID = castID
		castData.duration = now - startTime
		castData.max = max
		castData.delay = 0
		castData.casting = true
		castData.interrupt = notInterruptible
		castData.tradeskill = isTradeSkill
		castData.total = nil
		castData.starttime = nil

		castBar:SetMinMaxValues(0, castData.total or castData.max)
		castBar:SetValue(castData.duration) 

		if castBar.Name then castBar.Name:SetText(utf8sub(text, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end
		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end

		castBar:Show()
		
		
	elseif (event == "UNIT_SPELLCAST_FAILED") then
		local castID, spellID = ...
		if (castData.castID ~= castID) then
			return
		end

		castData.tradeskill = nil
		castData.total = nil
		castData.casting = nil
		castData.interrupt = nil

		castBar:SetValue(0)
		castBar:Hide()
		
	elseif (event == "UNIT_SPELLCAST_STOP") then
		local castID, spellID = ...
		if (castData.castID ~= castID) then
			return
		end

		castData.casting = nil
		castData.interrupt = nil
		castData.tradeskill = nil
		castData.total = nil

		castBar:SetValue(0)
		castBar:Hide()
		
	elseif (event == "UNIT_SPELLCAST_INTERRUPTED") then
		local castID, spellID = ...
		if (castData.castID ~= castID) then
			return
		end

		castData.tradeskill = nil
		castData.total = nil
		castData.casting = nil
		castData.interrupt = nil

		castBar:SetValue(0)
		castBar:Hide()
		
	elseif (event == "UNIT_SPELLCAST_INTERRUPTIBLE") then	
		if castData.casting then
			local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end
		elseif castData.channeling then
			local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end
		end
		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end
	
	elseif (event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE") then	
		if castData.casting then
			local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end
		elseif castData.channeling then
			local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end
		end
		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end
	
	elseif (event == "UNIT_SPELLCAST_DELAYED") then
		local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
		if (not startTime) or (not castData.duration) then 
			return 
		end
		
		local duration = GetTime() - (startTime / 1000)
		if (duration < 0) then 
			duration = 0 
		end

		castData.delay = (castData.delay or 0) + castData.duration - duration
		castData.duration = duration

		castBar:SetValue(duration)
		
	elseif (event == "UNIT_SPELLCAST_CHANNEL_START") then	
		local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit)
		if (not name) then
			castBar:Hide()
			return
		end
		
		endTime = endTime / 1e3
		startTime = startTime / 1e3

		local max = endTime - startTime
		local duration = endTime - GetTime()

		castData.duration = duration
		castData.max = max
		castData.delay = 0
		castData.channeling = true
		castData.interrupt = notInterruptible

		castData.casting = nil
		castData.castID = nil

		castBar:SetMinMaxValues(0, max)
		castBar:SetValue(duration)
		
		if castBar.Name then castBar.Name:SetText(utf8sub(name, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end
		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end

		castBar:Show()
		
		
	elseif (event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
		local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit)
		if (not name) or (not castData.duration) then 
			return 
		end

		local duration = (endTime / 1000) - GetTime()
		castData.delay = (castData.delay or 0) + castData.duration - duration
		castData.duration = duration
		castData.max = (endTime - startTime) / 1000
		
		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(duration)
	
	elseif (event == "UNIT_SPELLCAST_CHANNEL_STOP") then
		if castBar:IsShown() then
			castData.channeling = nil
			castData.interrupt = nil

			castBar:SetValue(castData.max)
			castBar:Hide()
		end
		
	else
		if UnitCastingInfo(unit) then
			return self:OnSpellCast("UNIT_SPELLCAST_START", unit)
		end
		if UnitChannelInfo(unit) then
			return self:OnSpellCast("UNIT_SPELLCAST_CHANNEL_START", unit)
		end
		
		castData.casting = nil
		castData.interrupt = nil
		castData.tradeskill = nil
		castData.total = nil

		castBar:SetValue(0)
		castBar:Hide()
	end

end

or ENGINE_LEGION and function(self, event, ...)
	local unit = ...
	if ((not unit) or (not UnitExists(unit))) then
		return
	end

	local baseFrame = C_NamePlate_GetNamePlateForUnit(unit)
	local plate = baseFrame and self.allPlates[baseFrame] 
	if (not plate) then
		return
	end

	local castBar = plate.Cast
	if (not CastData[castBar]) then
		CastData[castBar] = {}
	end

	local castData = CastData[castBar]
	if (not CastBarPool[plate]) then
		CastBarPool[plate] = castBar
	end

	if (event == "UNIT_SPELLCAST_START") then
		local unit, spell = ...

		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
		if (not name) then
			castBar:Hide()
			return
		end

		endTime = endTime / 1e3
		startTime = startTime / 1e3

		local now = GetTime()
		local max = endTime - startTime

		castData.castID = castID
		castData.duration = now - startTime
		castData.max = max
		castData.delay = 0
		castData.casting = true
		castData.interrupt = notInterruptible
		castData.tradeskill = isTradeSkill
		castData.total = nil
		castData.starttime = nil

		castBar:SetMinMaxValues(0, castData.total or castData.max)
		castBar:SetValue(castData.duration) 

		if castBar.Name then castBar.Name:SetText(utf8sub(text, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end
		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end

		castBar:Show()
		
		
	elseif (event == "UNIT_SPELLCAST_FAILED") then
		local unit, spellname, _, castID = ...
		if (castData.castID ~= castID) then
			return
		end

		castData.tradeskill = nil
		castData.total = nil
		castData.casting = nil
		castData.interrupt = nil

		castBar:SetValue(0)
		castBar:Hide()
		
	elseif (event == "UNIT_SPELLCAST_STOP") then
		local unit, spellname, _, castID = ...
		if (castData.castID ~= castID) then
			return
		end

		castData.casting = nil
		castData.interrupt = nil
		castData.tradeskill = nil
		castData.total = nil

		castBar:SetValue(0)
		castBar:Hide()
		
	elseif (event == "UNIT_SPELLCAST_INTERRUPTED") then
		local unit, spellname, _, castID = ...
		if (castData.castID ~= castID) then
			return
		end

		castData.tradeskill = nil
		castData.total = nil
		castData.casting = nil
		castData.interrupt = nil

		castBar:SetValue(0)
		castBar:Hide()
		
	elseif (event == "UNIT_SPELLCAST_INTERRUPTIBLE") then	
		local unit, spellname = ...

		if castData.casting then
			local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end

		elseif castData.channeling then
			local name, _, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitChannelInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end
		end

		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end
	
	elseif (event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE") then	
		local unit, spellname = ...

		if castData.casting then
			local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end

		elseif castData.channeling then
			local name, _, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitChannelInfo(unit)
			if name then
				castData.interrupt = notInterruptible
			end
		end

		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end
	
	elseif (event == "UNIT_SPELLCAST_DELAYED") then
		local unit, spellname, _, castID = ...

		local name, _, text, texture, startTime, endTime = UnitCastingInfo(unit)
		if (not startTime) or (not castData.duration) then 
			return 
		end
		
		local duration = GetTime() - (startTime / 1000)
		if (duration < 0) then 
			duration = 0 
		end

		castData.delay = (castData.delay or 0) + castData.duration - duration
		castData.duration = duration

		castBar:SetValue(duration)
		
	elseif (event == "UNIT_SPELLCAST_CHANNEL_START") then	
		local unit, spellname = ...

		local name, _, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitChannelInfo(unit)
		if (not name) then
			castBar:Hide()
			return
		end
		
		endTime = endTime / 1e3
		startTime = startTime / 1e3

		local max = endTime - startTime
		local duration = endTime - GetTime()

		castData.duration = duration
		castData.max = max
		castData.delay = 0
		castData.channeling = true
		castData.interrupt = notInterruptible

		castData.casting = nil
		castData.castID = nil

		castBar:SetMinMaxValues(0, max)
		castBar:SetValue(duration)
		
		if castBar.Name then castBar.Name:SetText(utf8sub(name, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end
		if castBar.Shield then 
			if castData.interrupt and not UnitIsUnit(unit ,"player") then
				castBar.Shield:Show()
				castBar.Glow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
				castBar.Shadow:SetVertexColor(widgetConfig.cast.color[1], widgetConfig.cast.color[2], widgetConfig.cast.color[3], 1)
			else
				castBar.Shield:Hide()
				castBar.Glow:SetVertexColor(0, 0, 0, .75)
				castBar.Shadow:SetVertexColor(0, 0, 0, 1)
			end
		end

		castBar:Show()
		
		
	elseif (event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
		local unit, spellname = ...

		local name, _, text, texture, startTime, endTime, oldStart = UnitChannelInfo(unit)
		if (not name) or (not castData.duration) then 
			return 
		end

		local duration = (endTime / 1000) - GetTime()
		castData.delay = (castData.delay or 0) + castData.duration - duration
		castData.duration = duration
		castData.max = (endTime - startTime) / 1000
		
		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(duration)
	
	elseif (event == "UNIT_SPELLCAST_CHANNEL_STOP") then
		local unit, spellname = ...

		if castBar:IsShown() then
			castData.channeling = nil
			castData.interrupt = nil

			castBar:SetValue(castData.max)
			castBar:Hide()
		end
		
	elseif (event == "UNIT_TARGET")	or (event == "PLAYER_TARGET_CHANGED") or (event == "PLAYER_FOCUS_CHANGED") then 
		local unit = self.unit
		if (not UnitExists(unit)) then
			return
		end
		if UnitCastingInfo(unit) then
			return self:OnSpellCast("UNIT_SPELLCAST_START", unit)
		end
		if UnitChannelInfo(self.unit) then
			return self:OnSpellCast("UNIT_SPELLCAST_CHANNEL_START", unit)
		end
		
		castData.casting = nil
		castData.interrupt = nil
		castData.tradeskill = nil
		castData.total = nil

		castBar:SetValue(0)
		castBar:Hide()
	end

end

or ENGINE_WOTLK and function(self, event, unit)
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

Module.OnUpdate = ENGINE_LEGION and function(self, elapsed)
	-- Update any running castbars, before we throttle.
	-- We need to do this on every update to make sure the values are correct.
	for owner, castBar in pairs(CastBarPool) do
		self:UpdateCastBar(castBar, owner.unit, CastData[castBar], elapsed)
	end

	-- Throttle the updates, to increase the performance. 
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < HZ then
		return
	end

	for plate, baseFrame in pairs(self.visiblePlates) do
		if baseFrame then
			plate:UpdateAlpha()
			plate:UpdateHealth()
		else
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
	self.elapsed = 0

end 
or ENGINE_WOTLK and function(self, elapsed)

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
Module.IsNamePlate = ENGINE_MOP and function(self, baseFrame)
	local name = baseFrame:GetName()
	if name and string_find(name, "^NamePlate%d") then
		local _, name_frame = baseFrame:GetChildren()
		if name_frame then
			local name_region = name_frame:GetRegions()
			return (name_region and (name_region:GetObjectType() == "FontString"))
		end
	end
end
or ENGINE_CATA and function(self, baseFrame)
	local threat_region, border_region = baseFrame:GetRegions()
	return (border_region and (border_region:GetObjectType() == "Texture") and (border_region:GetTexture() == CATA_PLATE))
end
or ENGINE_WOTLK and function(self, baseFrame)
	local region = baseFrame:GetRegions()
	return (region and (region:GetObjectType() == "Texture") and (region:GetTexture() == WOTLK_PLATE))
end


-- Blizzard Settings 
----------------------------------------------------------
-- Note that setting CVars in Legion is protected, 
-- and can only be done outside of combat. 

-- Force some blizzard console variables to our liking
Module.UpdateBlizzardSettings = ENGINE_LEGION and Engine:Wrap(function(self)
	local config = self.config
	local SetCVar = SetCVar

	-- Because we want friendly NPC nameplates
	-- We're toning them down a lot as it is, 
	-- but we still prefer to have them visible, 
	-- and not the fugly super sized names we get otherwise.
	SetCVar("nameplateShowFriendlyNPCs", 1)

	-- If these are enabled the GameTooltip will become protected, 
	-- and all sort of taints and bugs will occur.
	-- This happens on specs that can dispel when hovering over nameplate auras.
	-- We create our own auras anyway, so we don't need these. 
	if ENGINE_LEGION_730 then
		SetCVar("nameplateShowDebuffsOnFriendly", 0) 
	end
		
	-- Insets at the top and bottom of the screen 
	-- which the target nameplate will be kept away from. 
	-- Used to avoid the target plate being overlapped 
	-- by the target frame or actionbars and keep it in view.
	SetCVar("nameplateLargeTopInset", .22) -- default .1
	SetCVar("nameplateOtherTopInset", .22) -- default .08
	SetCVar("nameplateLargeBottomInset", .22) -- default .15
	SetCVar("nameplateOtherBottomInset", .22) -- default .1
	
	SetCVar("nameplateClassResourceTopInset", 0)
	SetCVar("nameplateGlobalScale", 1)
	SetCVar("NamePlateHorizontalScale", 1)
	SetCVar("NamePlateVerticalScale", 1)

	-- Scale modifier for large plates, used for important monsters
	SetCVar("nameplateLargerScale", 1) -- default 1.2

	-- The minimum scale and alpha of nameplates
	SetCVar("nameplateMinScale", 1) -- .5 default .8
	SetCVar("nameplateMinAlpha", .3) -- default .5

	-- The minimum distance from the camera plates will reach their minimum scale and alpa
	SetCVar("nameplateMinScaleDistance", 30) -- default 10
	SetCVar("nameplateMinAlphaDistance", 30) -- default 10

	-- The maximum scale and alpha of nameplates
	SetCVar("nameplateMaxScale", 1) -- default 1
	SetCVar("nameplateMaxAlpha", 0.85) -- default 0.9
	
	-- The maximum distance from the camera where plates will still have max scale and alpa
	SetCVar("nameplateMaxScaleDistance", 10) -- default 10
	SetCVar("nameplateMaxAlphaDistance", 10) -- default 10

	-- Show nameplates above heads or at the base (0 or 2)
	SetCVar("nameplateOtherAtBase", 0)

	-- Scale and Alpha of the selected nameplate (current target)
	SetCVar("nameplateSelectedAlpha", 1) -- default 1
	SetCVar("nameplateSelectedScale", 1) -- default 1
	

	-- Setting the base size involves changing the size of secure unit buttons, 
	-- but since we're using our out of combat wrapper, we should be safe.
	local width, height = config.size[1], config.size[2]

	C_NamePlate.SetNamePlateFriendlySize(width, height)
	C_NamePlate.SetNamePlateEnemySize(width, height)

	NamePlateDriverFrame.UpdateNamePlateOptions = function() end

	--NamePlateDriverMixin:SetBaseNamePlateSize(unpack(config.size))

	--[[
		7.1 new methods in C_NamePlate:

		Added:
		SetNamePlateFriendlySize,
		GetNamePlateFriendlySize,
		SetNamePlateEnemySize,
		GetNamePlateEnemySize,
		SetNamePlateSelfClickThrough,
		GetNamePlateSelfClickThrough,
		SetNameplateFriendlyClickThrough,
		GetNameplateFriendlyClickThrough,
		SetNamePlateEnemyClickThrough,
		GetNamePlateEnemyClickThrough

		These functions allow a specific area on the nameplate to be marked as a preferred click area such that if the nameplate position query results in two overlapping nameplates, the nameplate with the position inside its preferred area will be returned:

		SetNamePlateSelfPreferredClickInsets,
		GetNamePlateSelfPreferredClickInsets,
		SetNamePlateFriendlyPreferredClickInsets,
		GetNamePlateFriendlyPreferredClickInsets,
		SetNamePlateEnemyPreferredClickInsets,
		GetNamePlateEnemyPreferredClickInsets,
	]]
end)
or Engine:Wrap(function(self)
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

	if ENGINE_LEGION then
		-- Detection, showing and hidding
		self:RegisterEvent("NAME_PLATE_CREATED", "OnEvent")
		self:RegisterEvent("NAME_PLATE_UNIT_ADDED", "OnEvent")
		self:RegisterEvent("NAME_PLATE_UNIT_REMOVED", "OnEvent")

		-- Updates
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnEvent")
		self:RegisterEvent("PLAYER_LEVEL_UP", "OnEvent")
		self:RegisterEvent("RAID_TARGET_UPDATE", "OnEvent")
		self:RegisterEvent("UNIT_AURA", "OnEvent")
		self:RegisterEvent("UNIT_FACTION", "OnEvent")
		self:RegisterEvent("UNIT_LEVEL", "OnEvent")
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", "OnEvent")

		-- NamePlate Update Cycles
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")

		-- Scale Changes
		self:RegisterEvent("DISPLAY_SIZE_CHANGED", "OnEvent")
		self:RegisterEvent("UI_SCALE_CHANGED", "OnEvent")

		--self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnEvent")
		--self:RegisterEvent("PLAYER_CONTROL_GAINED", "OnEvent")
		--self:RegisterEvent("PLAYER_CONTROL_LOST", "OnEvent")
		--self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
		--self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEvent")
		--self:RegisterEvent("CVAR_UPDATE", "OnEvent")
		--self:RegisterEvent("VARIABLES_LOADED", "OnEvent")

		-- Castbars
		self:RegisterEvent("UNIT_SPELLCAST_START", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_FAILED", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_STOP", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_DELAYED", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "OnSpellCast")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "OnSpellCast")
		
	elseif ENGINE_WOTLK then
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

end
