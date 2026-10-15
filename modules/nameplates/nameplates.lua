-- 3.3.5's nameplates in the Diabolic look: health, level, name, raid and boss
-- icons, the target's and focus' casts, and your auras (auras.lua).
local _, Engine = ...
local Module = Engine:NewModule("NamePlates")
local C = Engine:GetDB("Data: Colors")
local L = Engine:GetLocale()
local UICenter = Engine:GetFrame()

-- Register incompatibilities
Module:SetIncompatible("gUI4_NamePlates")
Module:SetIncompatible("NeatPlates")
Module:SetIncompatible("Kui_Nameplates")
Module:SetIncompatible("SimplePlates")
Module:SetIncompatible("TidyPlates")
Module:SetIncompatible("TidyPlates_ThreatPlates")
Module:SetIncompatible("TidyPlatesContinued")

-- Lua API
local _G = _G
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local select = select
local setmetatable = setmetatable
local tonumber = tonumber
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetTime = _G.GetTime
local GetQuestGreenRange = _G.GetQuestGreenRange
local SetCVar = _G.SetCVar
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitExists = _G.UnitExists
local UnitLevel = _G.UnitLevel
local UnitName = _G.UnitName

-- Engine API

-- WoW Frames & Objects
local WorldFrame = WorldFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

-- Plate Registries
local AllPlates, VisiblePlates = {}, {}
local CastData, CastBarPool = {}, {}

-- WorldFrame child registry to rule out elements already checked faster
local AllChildren = {}

-- Plate FrameLevel ordering

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
local FRAMELEVEL_CURRENT, FRAMELEVEL_MIN, FRAMELEVEL_MAX, FRAMELEVEL_STEP = 21, 21, 125, 2

-- Opacity Settings
local ALPHA_TARGET = 1 -- For the current target, if any
local ALPHA_FULL = .7 -- For players when not having a target, also for World Bosses when not targeted
local ALPHA_LOW = .35 -- For non-targeted players when having a target
local ALPHA_MINIMAL = .01 -- For non-targeted NPCs

-- How far toward white the name is drawn, from its bar's color
local NAME_LIGHTEN = .35

-- Update and fading frequencies
local HZ = 1/30
local FADE_IN = 3/4 -- time in seconds to fade in
local FADE_OUT = 1/20 -- time in seconds to fade out

-- Constants for castbar and aura time displays
local DAY = Engine:GetConstant("DAY")
local HOUR = Engine:GetConstant("HOUR")
local MINUTE = Engine:GetConstant("MINUTE")

-- Maximum displayed buffs.

-- Time limit in seconds where we separate between short and long buffs

-- Player and Target data
local LEVEL = UnitLevel("player") -- our current level
local TARGET -- our current target, if any

-- Blizzard textures we use to identify plates and more
local WOTLK_PLATE 		= [[Interface\TargetingFrame\UI-TargetingFrame-Flash]]
local ELITE_TEXTURE 	= [[Interface\Tooltips\EliteNameplateIcon]] -- elite/rare dragon texture
local BOSS_TEXTURE 		= [[Interface\TargetingFrame\UI-TargetingFrame-Skull]] -- skull textures
local EMPTY_TEXTURE 	= Engine:GetConstant("EMPTY_TEXTURE") -- used to make textures invisible

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

local NamePlate_WotLK = setmetatable({}, { __index = NamePlate })
local NamePlate_WotLK_MT = { __index = NamePlate_WotLK }

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
		else
			-- A rare: only elites have the dragon texture, while a rare
			-- doesn't have to be elite.
			info.isElite = oldRegions.eliteicon:GetTexture() == ELITE_TEXTURE
		end
	else
		info.isElite = false
	end

	info.level = self.info.isBoss and -1 or tonumber(oldRegions.level:GetText()) or -1
end

NamePlate_WotLK.UpdateTargetData = function(self)
	local isTarget = TARGET and (self.baseFrame:GetAlpha() == 1)
	self.info.isTarget = isTarget

	-- the border highlighted for the target and the mouseover (Blizzard's
	-- highlight shows on it)
	local health = self.Health
	if isTarget or self.old.regions.highlight:IsShown() then
		health.BorderHighlight:Show()
		health.BorderNormal:Hide()
	else
		health.BorderHighlight:Hide()
		health.BorderNormal:Show()
	end
end

NamePlate_WotLK.UpdateCombatData = function(self)
	-- Shortcuts to our own objects
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

	local r, g, b
	local hasClass


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
			info.isFriendly = false
			info.isTapped = true
			info.isPlayer = false
		elseif g + b == 0 then -- hated/hostile/unfriendly npc
			info.isNeutral = false
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = false
		elseif r + b == 0 then -- friendly npc
			info.isNeutral = false
			info.isFriendly = true
			info.isTapped = false
			info.isPlayer = false
		elseif r + g > 1.95 then -- neutral npc
			info.isNeutral = true
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = false
		elseif r + g == 0 then -- friendly player
			info.isNeutral = false
			info.isFriendly = true
			info.isTapped = false
			info.isPlayer = true
		else -- enemy player (no class colors enabled)
			info.isNeutral = false
			info.isFriendly = false
			info.isTapped = false
			info.isPlayer = false
		end
	end

	-- apply health and threat coloring: the bar in the unit's reaction color,
	-- like the unit frames', the name in its threat color when it has threat
	if not info.healthColor then
		info.healthColor = {}
	end
	if not info.reactionColor then
		info.reactionColor = {}
	end
	do
		if info.isClass then
			-- an enemy player (only players have class colored health bars)
			local color = C.Reaction[1]
			r, g, b = color[1], color[2], color[3]
		elseif info.isFriendly then
			if info.isPlayer then
				local color = C.Reaction.civilian
				r, g, b = color[1], color[2], color[3]
			else
				local color = C.Reaction[5]
				r, g, b = color[1], color[2], color[3]
			end
		elseif info.isTapped then
			local color = C.Status.Tapped
			r, g, b = color[1], color[2], color[3]
		elseif info.isNeutral then
			local color = C.Reaction[4]
			r, g, b = color[1], color[2], color[3]
		else
			local color = C.Reaction[2]
			r, g, b = color[1], color[2], color[3]
		end

		info.reactionColor[1] = r
		info.reactionColor[2] = g
		info.reactionColor[3] = b
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
	end
	info.healthColor[1] = r
	info.healthColor[2] = g
	info.healthColor[3] = b

end

NamePlate_WotLK.ApplyUnitData = function(self)
	local info = self.info

	-- This runs 30 times a second for every plate on screen: the level and
	-- name texts are only built again when what they show changed.
	local shown = self.shownUnitData
	if (not shown) then
		shown = {}
		self.shownUnitData = shown
	end
	local playerLevel = UnitLevel("player") -- the level's color depends on it
	if (info.level ~= shown.level) or (info.isBoss ~= shown.isBoss) or (info.isElite ~= shown.isElite) or (info.isFriendly ~= shown.isFriendly)
	or (info.isNeutral ~= shown.isNeutral) or (info.name ~= shown.name) or (playerLevel ~= shown.playerLevel) then
		shown.level, shown.isBoss, shown.isElite, shown.isFriendly = info.level, info.isBoss, info.isElite, info.isFriendly
		shown.isNeutral, shown.name, shown.playerLevel = info.isNeutral, info.name, playerLevel
		self:ApplyLevelAndName()
	end

	if info.isMarked then
		self.RaidIcon:SetTexCoord(self.old.regions.raidicon:GetTexCoord()) -- ?
		self.RaidIcon:SetTexture(self.old.regions.raidicon:GetTexture())
		self.RaidIcon:Show()
	else
		self.RaidIcon:Hide()
	end
end

NamePlate_WotLK.ApplyLevelAndName = function(self)
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
end

NamePlate_WotLK.ApplyHealthData = function(self)
	local info = self.info
	local health = self.Health

	if info.reactionColor then
		health:SetStatusBarColor(unpack(info.reactionColor))
	end

	if info.unitThreatSituation and info.unitThreatSituation > 0 then
		local r, g, b = info.threatColor[1], info.threatColor[2], info.threatColor[3]
		health.Glow:SetVertexColor(r, g, b, 1)
		health.Glow:Show()
	else
		health.Glow:Hide()
	end

	health:SetMinMaxValues(0, info.healthMax)
	health:SetValue(info.health)

	local font, size, flags = health.Value:GetFont()
	if (flags ~= "OUTLINE") then
		health.Value:SetFont(font, size, "OUTLINE")
	end

	-- the name lighter than the bar, to read on dark ground
	local r, g, b = unpack(info.healthColor)
	health.Value:SetTextColor(r + (1 - r) * NAME_LIGHTEN, g + (1 - g) * NAME_LIGHTEN, b + (1 - b) * NAME_LIGHTEN)
end

NamePlate_WotLK.UpdateAlpha = function(self)
	local info = self.info
	if self.visiblePlates[self] then
		local oldHealth = self.old.bars.health
		local current, max = oldHealth:GetValue(), select(2, oldHealth:GetMinMaxValues())
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
	if TARGET and info.isTarget then
		if self:GetFrameLevel() ~= FRAMELEVEL_TARGET then
			self:SetFrameLevel(FRAMELEVEL_TARGET)
		end
	elseif self:GetFrameLevel() ~= self.frameLevel then
		self:SetFrameLevel(self.frameLevel)
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
	info.isClass = nil
	info.isBoss = nil
	info.isElite = nil
	info.isFriendly = nil
	info.isNeutral = nil
	info.isPlayer = nil
	info.isTapped = nil
	info.isTarget = nil
	info.unitThreatSituation = nil
	info.healthMax = 0
	info.health = 0

	self.Health:Show()
	self.Cast:Hide()

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

	-- a plate shown for another unit, maybe: its auras wait until it's known
	Module:ClearPlateAuras(self)
end

NamePlate_WotLK.OnHide = function(self)
	local info = self.info

	info.level = nil
	info.name = nil
	info.isClass = nil
	info.isBoss = nil
	info.isElite = nil
	info.isFriendly = nil
	info.isNeutral = nil
	info.isPlayer = nil
	info.isTapped = nil
	info.isTarget = nil
	info.unitThreatSituation = nil
	info.healthMax = 0
	info.health = 0

	self.Cast:Hide()

	Module:ClearPlateAuras(self)

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

	-- the focus frame's border around it (units/focus.lua): its backdrop
	-- behind the bar, its glow behind that for the threat (both on the
	-- plate, under the bar, as the focus frame has them), its border over
	-- the bar, highlighted for the target and the mouseover
	local border = textureConfig.border
	local point, x, y = unpack(border.position)

	local HealthGlow = self:CreateTexture()
	HealthGlow:SetDrawLayer("BACKGROUND")
	HealthGlow:SetSize(unpack(border.size))
	HealthGlow:SetPoint(point, self, point, x, y)
	HealthGlow:SetTexture(border.glow)
	HealthGlow:Hide()
	Health.Glow = HealthGlow

	local HealthBackdrop = self:CreateTexture()
	HealthBackdrop:SetDrawLayer("BORDER")
	HealthBackdrop:SetSize(unpack(border.size))
	HealthBackdrop:SetPoint(point, self, point, x, y)
	HealthBackdrop:SetTexture(border.backdrop)
	Health.Backdrop = HealthBackdrop

	local HealthOverlay = Health:CreateTexture()
	HealthOverlay:SetDrawLayer("ARTWORK")
	HealthOverlay:SetAllPoints()
	HealthOverlay:SetTexture(textureConfig.bar_overlay.path)
	HealthOverlay:SetAlpha(.5)
	Health.Overlay = HealthOverlay

	local Border = Health:CreateFrame("Frame") -- over the bar
	Border:SetAllPoints()

	local BorderNormal = Border:CreateTexture(nil, "BORDER")
	BorderNormal:SetSize(unpack(border.size))
	BorderNormal:SetPoint(point, self, point, x, y)
	BorderNormal:SetTexture(border.normal)
	Health.BorderNormal = BorderNormal

	local BorderHighlight = Border:CreateTexture(nil, "BORDER")
	BorderHighlight:SetSize(unpack(border.size))
	BorderHighlight:SetPoint(point, self, point, x, y)
	BorderHighlight:SetTexture(border.highlight)
	BorderHighlight:Hide()
	Health.BorderHighlight = BorderHighlight

	local HealthValue = Health:CreateFontString()
	HealthValue:SetDrawLayer("OVERLAY")
	HealthValue:SetPoint(unpack(widgetConfig.health.value.place))
	HealthValue:SetFontObject(widgetConfig.health.value.fontObject)
	HealthValue:SetTextColor(unpack(widgetConfig.health.value.color))
	Health.Value = HealthValue


	-- Cast bar, in the same border as the health bar, under it
	local castConfig = widgetConfig.cast
	local CastHolder = self:CreateFrame("Frame")
	CastHolder:SetSize(unpack(castConfig.size))
	CastHolder:SetPoint(unpack(castConfig.place))

	local Cast = CastHolder:CreateStatusBar()
	Cast:Hide()
	Cast:SetSize(unpack(castConfig.bar.size))
	Cast:SetPoint(unpack(castConfig.bar.place))
	Cast:SetStatusBarTexture(textureConfig.bar_texture.path)
	Cast:SetStatusBarColor(unpack(castConfig.color))

	-- the border's backdrop, under the bar, shown with it
	local CastBackdrop = CastHolder:CreateTexture()
	CastBackdrop:SetDrawLayer("BORDER")
	CastBackdrop:SetSize(unpack(border.size))
	CastBackdrop:SetPoint(point, CastHolder, point, x, y)
	CastBackdrop:SetTexture(border.backdrop)
	CastBackdrop:Hide()
	Cast.Backdrop = CastBackdrop

	local CastOverlay = Cast:CreateTexture()
	CastOverlay:SetDrawLayer("ARTWORK")
	CastOverlay:SetAllPoints()
	CastOverlay:SetTexture(textureConfig.bar_overlay.path)
	CastOverlay:SetAlpha(.5)
	Cast.Overlay = CastOverlay

	local CastBorderFrame = Cast:CreateFrame("Frame") -- over the bar
	CastBorderFrame:SetAllPoints()
	local CastBorder = CastBorderFrame:CreateTexture(nil, "BORDER")
	CastBorder:SetSize(unpack(border.size))
	CastBorder:SetPoint(point, CastHolder, point, x, y)
	CastBorder:SetTexture(border.normal)
	Cast.Border = CastBorder

	-- the time left, after the border's art on the right
	local CastValue = CastBorderFrame:CreateFontString()
	CastValue:SetDrawLayer("OVERLAY")
	local valuePoint, valueRelative, valueX, valueY = unpack(castConfig.value.place)
	CastValue:SetPoint(valuePoint, CastHolder, valueRelative, valueX, valueY)
	CastValue:SetFontObject(castConfig.value.fontObject)
	CastValue:SetTextColor(C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3])
	Cast.Value = CastValue

	-- the spell's icon, before the border's art on the left
	local CastIcon = CastBorderFrame:CreateTexture(nil, "ARTWORK")
	CastIcon:SetSize(unpack(castConfig.icon.size))
	local iconPoint, iconRelative, iconX, iconY = unpack(castConfig.icon.place)
	CastIcon:SetPoint(iconPoint, CastHolder, iconRelative, iconX, iconY)
	CastIcon:SetTexCoord(5/64, 59/64, 5/64, 59/64)   -- trim the default icon edges
	Cast.Icon = CastIcon

	-- the spell's name, under the border's art
	local CastName = CastBorderFrame:CreateFontString()
	CastName:SetDrawLayer("OVERLAY")
	CastName:SetPoint(unpack(castConfig.name.place))
	CastName:SetFontObject(castConfig.name.fontObject)
	CastName:SetTextColor(unpack(castConfig.name.color))
	Cast.Name = CastName

	Cast:HookScript("OnShow", function()
		CastBackdrop:Show()
		Cast.Icon:Show()
	end)
	Cast:HookScript("OnHide", function()
		CastBackdrop:Hide()
		Cast.Icon:SetTexture(nil)
		Cast.Icon:Hide()
	end)



	-- Unit Level
	local Level = Health:CreateFontString()
	Level:SetDrawLayer("OVERLAY")
	Level:SetFontObject(DiabolicFont_SansBold10)
	Level:SetTextColor(C.General.OffWhite[1], C.General.OffWhite[2], C.General.OffWhite[3])
	Level:SetPoint("LEFT", Health.Value, "RIGHT", 4, 0) -- by the name, clear of the border's art


	-- Icons
	local RaidIcon = Health:CreateTexture()
	RaidIcon:Hide()

	local BossIcon = Health:CreateTexture()
	BossIcon:SetSize(18, 18)
	BossIcon:SetTexture(BOSS_TEXTURE)
	BossIcon:SetPoint("LEFT", Health.Value, "RIGHT", 2, 0)
	BossIcon:Hide()

	self.Health = Health
	self.Cast = Cast
	self.Level = Level
	self.RaidIcon = RaidIcon
	self.BossIcon = BossIcon
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
	self:CreateAuras(plate)

	plate:CreateSizer(baseFrame, worldFrame) -- create the sizer that positions the nameplate
	plate:HookScripts(baseFrame, worldFrame)

	plate.allPlates[baseFrame] = plate

	return plate
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
	-- the unit the bar follows (and gets hidden with, see UpdateCastBar)
	CastData[castBar].unit = unit
	local castData = CastData[castBar]
	if not CastBarPool[plate] then
		CastBarPool[plate] = castBar
	end

	if event == "UNIT_SPELLCAST_START" then
		local spellName, _, text, texture, startTime, endTime = UnitCastingInfo(unit)
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

		castBar:SetMinMaxValues(0, castData.max)
		castBar:SetValue(castData.duration)

		if castBar.Name then castBar.Name:SetText(utf8sub(text or spellName, 32, true)) end
		if castBar.Icon then castBar.Icon:SetTexture(texture) end
		if castBar.Value then castBar.Value:SetText("") end

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
			castBar:SetValue(castData.max or 0)
			castBar:Hide()
			if castBar.Icon then castBar.Icon:SetTexture(nil); castBar.Icon:Hide() end
		end
	end
end

-- NamePlate Update Cycle
----------------------------------------------------------

-- Proxy function to allow us to exit the update by returning,
-- but still continue looping through the remaining castbars, if any!
Module.UpdateCastBar = function(self, castBar, castData, elapsed)
	if (not UnitExists(castData.unit)) then
		castData.casting = nil
		castData.channeling = nil
		castBar:SetValue(0)
		castBar:Hide()
		return
	end
	local duration, remaining
	if castData.casting then
		duration = castData.duration + elapsed
		remaining = castData.max - duration
		if (remaining <= 0) then
			castData.casting = nil
			castBar:Hide()
		end
	else -- a channel counts down
		duration = castData.duration - elapsed
		remaining = duration
		if (duration <= 0) then
			castData.channeling = nil
			castBar:Hide()
		end
	end
	if (castData.delay ~= 0) then
		castBar.Value:SetFormattedText("%s|cffff0000 -%s|r", formatTime(remaining), formatTime(castData.delay))
	else
		castBar.Value:SetText(formatTime(remaining))
	end
	castData.duration = duration
	castBar:SetValue(duration)
end

Module.OnUpdate = function(self, elapsed)

	-- If the number of children in the WorldFrame
	--  is different from the number we have stored,
	-- we parse the children to check for new NamePlates.
	for _, castBar in pairs(CastBarPool) do
		local castData = CastData[castBar]
		if castData.casting or castData.channeling then
			self:UpdateCastBar(castBar, castData, elapsed)
		end
	end

	local numChildren = self.worldFrame:GetNumChildren()
	if (WORLDFRAME_CHILDREN ~= numChildren) then
		-- Localizing even more to reduce the load when entering large scale raids
		local allPlates = self.allPlates
		local allChildren = self.allChildren
		local worldFrame = self.worldFrame
		local isNamePlate = self.IsNamePlate
		local createNamePlate = self.CreateNamePlate

		-- one list, rather than asking the WorldFrame for all its children
		-- again for each one of them
		local children = { worldFrame:GetChildren() }
		for i = 1, numChildren do
			local object = children[i]
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
	end

	self.elapsed = (self.elapsed or 0) + elapsed
	if (self.elapsed < HZ) then
		return
	end
	elapsed = self.elapsed -- the time since the last update, not the last frame

	-- Update visibility, health values and target alpha
	for plate, baseFrame in pairs(self.visiblePlates) do
		if baseFrame then
			if FORCEUPDATE == "TARGET" then
				plate:UpdateTargetData()
				plate:UpdateAlpha()
				plate:UpdateFrameLevel()
			elseif FORCEUPDATE then
				plate:UpdateAll()
			else
				plate:UpdateTargetData()
				plate:UpdateAlpha()
				plate:UpdateHealth()
			end
			self:UpdatePlateUnit(plate) -- the target's or mouseover's: whose auras
		else
			plate.targetAlpha = 0
		end
	end

	-- Fade each plate toward its target alpha (a full fade takes FADE_IN or
	-- FADE_OUT seconds), and let go of the faded out ones.
	local step_in, step_out = elapsed/FADE_IN, elapsed/FADE_OUT
	for plate in pairs(self.visiblePlates) do
		local current, target = plate.currentAlpha, plate.targetAlpha
		if (current ~= target) then
			if (target > current) then
				current = math_min(target, current + step_in)
			else
				current = math_max(target, current - step_out)
			end
			plate.currentAlpha = current
			plate:SetAlpha(current)
		end
		if ((current == 0) and (target == 0)) then
			plate.visiblePlates[plate] = nil
			plate:Hide()
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
	SetCVar("ShowVKeyCastbar", 1) -- 3.3's castbars on nameplates
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
	self:RegisterEvent("PLAYER_LEVEL_UP", "OnEvent")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnEvent")
	self:RegisterEvent("RAID_TARGET_UPDATE", "OnEvent")
	self:RegisterEvent("UNIT_FACTION", "OnEvent")
	self:RegisterEvent("UNIT_LEVEL", "OnEvent")
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

	self:EnableAuras()
end
