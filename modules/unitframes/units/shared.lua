-- What the smaller unit frames (target, target of target, focus, party,
-- raid, boss, arena) share: their health bar colors, the border that lights
-- up on mouseover, how their aura buttons look, and which auras enemies and
-- group members show. Loaded before the units/*.lua files, which get it as
-- Engine:GetDB("Library: UnitFrames").
local _, Engine = ...
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local IsInInstance = _G.IsInInstance
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsUnit = _G.UnitIsUnit
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitReaction = _G.UnitReaction
local UnitIsTapDenied = Engine.UnitIsTapDenied

-- Time limit in seconds where we separate between short and long buffs
local TIME_LIMIT_LOW = Engine:GetConstant("AURA_TIME_LIMIT_LOW")

local Library = {}

-- Health
------------------------------------------------------------------------

-- A unit's health color:
--  - players: their class color (useClassColor), or the plain health color
--  - pets, vehicles and mind controlled units: their reaction (friendly,
--    hostile, neutral), or the plain health color with plainControlled
--  - NPCs: gray when tapped by someone else, else their reaction
--  - dead, ghosts and offline players: their status color
local HealthColor = function(unit, isUnavailable, useClassColor, plainControlled)
	local color
	if (isUnavailable == "dead") or (isUnavailable == "ghost") then
		color = C.Status.Dead
	elseif (isUnavailable == "offline") then
		color = C.Status.Disconnected
	elseif UnitIsPlayer(unit) then
		if useClassColor then
			local _, class = UnitClass(unit)
			color = class and C.Class[class] or C.Class.UNKNOWN
		else
			color = C.Orb.HEALTH[1]
		end
	elseif UnitPlayerControlled(unit) then
		if plainControlled then
			color = C.Orb.HEALTH[1]
		elseif UnitIsFriend("player", unit) then
			color = C.Reaction[5]
		elseif UnitIsEnemy(unit, "player") then
			color = C.Reaction[1]
		else
			color = C.Reaction[4]
		end
	elseif (not UnitIsFriend("player", unit)) and UnitIsTapDenied(unit) then
		color = C.Status.Tapped
	else
		color = C.Reaction[UnitReaction(unit, "player")] or C.Orb.HEALTH[1]
	end
	return unpack(color)
end
Library.HealthColor = HealthColor

-- Health.PostUpdate: colors the bar (see HealthColor, and the bar's
-- useClassColor and plainControlled fields), and dims its value outside
-- of combat when dimOutOfCombat is set.
Library.PostUpdateHealth = function(health, unit, curHealth, maxHealth, isUnavailable)
	local r, g, b = HealthColor(unit, isUnavailable, health.useClassColor, health.plainControlled)
	if not((r == health.r) and (g == health.g) and (b == health.b)) then
		health:SetStatusBarColor(r, g, b)
		health.r, health.g, health.b = r, g, b
	end
	if health.dimOutOfCombat then
		health.Value:SetAlpha(UnitAffectingCombat("player") and 1 or .7)
	end
end

-- Mouseover
------------------------------------------------------------------------

-- OnEnter/OnLeave: the frame's border, and its portrait's, light up while
-- the mouse is over it.
Library.UpdateLayers = function(self)
	local over = self:IsMouseOver()
	if over then
		self.BorderNormalHighlight:Show()
		self.BorderNormal:Hide()
	else
		self.BorderNormal:Show()
		self.BorderNormalHighlight:Hide()
	end
	if self.PortraitBorderNormal then
		if over then
			self.PortraitBorderNormal:Hide()
			self.PortraitBorderHighlight:Show()
			self.PortraitGlow:Show()
		else
			self.PortraitBorderNormal:Show()
			self.PortraitBorderHighlight:Hide()
			self.PortraitGlow:Hide()
		end
	end
end

-- Aura buttons
------------------------------------------------------------------------

-- Auras.PostCreateButton: the glow and shade, and a SetBorderColor that
-- tints the border, glow and icon frame. Every aura gets the owner's color,
-- its icon a little dimmed.
Library.PostCreateAuraButton = function(self, button)
	local config = self.buttonConfig

	local icon = button:GetElement("Icon")
	local overlay = button:GetElement("Overlay")
	local scaffold = button:GetElement("Scaffold")

	overlay:SetBackdrop(config.glow.backdrop)

	local glow = button:CreateFrame()
	glow:SetFrameLevel(button:GetFrameLevel())
	glow:SetPoint("TOPLEFT", scaffold, "TOPLEFT", -4, 4)
	glow:SetPoint("BOTTOMRIGHT", scaffold, "BOTTOMRIGHT", 3, -3)
	glow:SetBackdrop(config.glow.backdrop)

	local iconShade = scaffold:CreateTexture()
	iconShade:SetDrawLayer("OVERLAY")
	iconShade:SetAllPoints(icon)
	iconShade:SetTexture(config.shade.texture)
	iconShade:SetVertexColor(0, 0, 0, 1)

	local iconDarken = scaffold:CreateTexture()
	iconDarken:SetDrawLayer("OVERLAY")
	iconDarken:SetAllPoints(icon)
	iconDarken:SetTexture(0, 0, 0, .15)

	button.SetBorderColor = function(self, r, g, b)
		overlay:SetBackdropBorderColor(r, g, b, .5)
		glow:SetBackdropBorderColor(r/3, g/3, b/3, .75)
		scaffold:SetBackdropColor(r * 1/3, g * 1/3, b * 1/3)
		scaffold:SetBackdropBorderColor(r, g, b)
	end

	button:SetElement("Glow", glow)
	button:SetSize(unpack(config.size))
	button:SetBorderColor(unpack(config.color))
	icon:SetVertexColor(.85, .85, .85)
end

-- Aura filters
------------------------------------------------------------------------
-- All of them get the Auras element's frame and UnitAura's returns plus
-- isBossDebuff and isCastByPlayer (see data/aura-functions.lua).

-- Buffs on an enemy (boss and arena frames): boss auras, stealable ones,
-- and short ones from you or the unit itself.
Library.EnemyBuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	local unit = self.unit
	if (isBossDebuff) or (isStealable) then
		return true

	elseif (isCastByPlayer or (unitCaster == "vehicle")) and (duration and ((duration > 0) and (duration <= TIME_LIMIT_LOW))) then
		return true

	elseif ((unitCaster and UnitIsUnit(unit, unitCaster)) and duration and ((duration > 0) and (duration < TIME_LIMIT_LOW))) then
		return true

	elseif (not unitCaster) and (not IsInInstance()) then
		-- EXPERIMENTAL: ignore auras from players outside the group, eg. world bosses
		return

	elseif (UnitCanAttack("player", unit) and (not UnitPlayerControlled(unit))) then
		-- Hostile NPC.
		-- Show auras cast by the unit, and auras of unknown origin.
		return (not unitCaster) or (unitCaster == unit)

	elseif (not unitCaster) then
		-- Friendly target or hostile player
		-- Show auras of unknown origin
		return true

	else
		-- others' (TODO: a whitelist of the PvP shields and cooldowns worth
		-- knowing about), and your own longer buffs
		return false
	end
end

-- Debuffs on an enemy: boss debuffs, yours and your vehicle's, and the
-- ones a hostile NPC put on itself.
Library.EnemyDebuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	local unit = self.unit
	if isBossDebuff or isCastByPlayer then
		return true

	elseif unitCaster and ((unitCaster == "vehicle") or UnitIsUnit("vehicle", unitCaster)) then
		return true

	elseif (not unitCaster) and (not IsInInstance()) then
		-- EXPERIMENTAL: ignore debuffs from players outside the group, eg. world bosses
		return

	elseif UnitCanAttack("player", unit) and (not UnitPlayerControlled(unit)) then
		return (not unitCaster) or (unitCaster == unit)

	else
		-- (TODO: a whitelist of the PvP debuffs worth knowing about)
		return false
	end
end

-- Buffs on a group member: only yours (or your vehicle's). A mind
-- controlled member is an enemy for the time being.
Library.GroupBuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	if UnitIsFriend("player", self.unit) then
		return isCastByPlayer or (unitCaster == "vehicle")
	end
	return Library.EnemyBuffFilter(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
end

-- Debuffs on a group member: boss debuffs, dispellable ones, and yours.
Library.GroupDebuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	if UnitIsFriend("player", self.unit) then
		return (isBossDebuff or debuffType or isCastByPlayer or (unitCaster == "vehicle")) and true or false
	end
	return Library.EnemyDebuffFilter(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
end

Engine:NewStaticConfig("Library: UnitFrames", Library)
