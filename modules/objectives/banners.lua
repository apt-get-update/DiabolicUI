-- Two cards that fade in over the world, stay a moment and fade out: a
-- boss's name on a banner as it's engaged or targeted, and the zone's name
-- as you enter it, its PvP state over it in that state's color. (The zone
-- names Blizzard shows are off: zone.lua.)
local _, Engine = ...
local Module = Engine:NewModule("Banners", "LOW")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local GetTime = _G.GetTime
local GetZonePVPInfo = _G.GetZonePVPInfo
local GetZoneText = _G.GetZoneText
local UnitCanAttack = _G.UnitCanAttack
local UnitClassification = _G.UnitClassification
local UnitExists = _G.UnitExists
local UnitIsDead = _G.UnitIsDead
local UnitName = _G.UnitName

local MAX_BOSSES = 4

-- A zone's PvP state: Blizzard's line for it, in Blizzard's color.
local PVP = {
	sanctuary = { "SANCTUARY_TERRITORY", 0.41, 0.8, 0.94 },
	arena = { "FREE_FOR_ALL_TERRITORY", 1, 0.1, 0.1 },
	friendly = { "FACTION_CONTROLLED_TERRITORY", 0.1, 1, 0.1 },
	hostile = { "FACTION_CONTROLLED_TERRITORY", 1, 0.1, 0.1 },
	contested = { "CONTESTED_TERRITORY", 1, 0.7, 0 },
	combat = { "COMBAT_ZONE", 1, 0.1, 0.1 },
}

local OnUpdate = function(card, elapsed)
	card.age = card.age + elapsed
	local spec, age = card.spec, card.age
	local full = spec.fade_in + spec.hold
	if age >= full + spec.fade_out then
		card:Hide()
	elseif age >= full then
		card:SetAlpha(1 - (age - full) / spec.fade_out)
	elseif age >= spec.fade_in then
		card:SetAlpha(1)
	else
		card:SetAlpha(age / spec.fade_in)
	end
end

-- Its small line over its big one, from `side` ("LEFT" or "RIGHT").
Module.CreateCard = function(self, spec, side)
	local path = _G[self.config.font]:GetFont()
	local card = Engine:CreateFrame("Frame", nil, Engine:GetFrame())
	card:Hide()
	card:SetFrameStrata("HIGH")
	card:SetSize(unpack(spec.size))
	card:Place(unpack(spec.position))
	card:SetScript("OnUpdate", OnUpdate)
	card.spec = spec

	local small = card:CreateFontString(nil, "OVERLAY")
	small:SetFont(path, spec.small_size, "OUTLINE")
	small:SetPoint("TOP" .. side, card, "TOP" .. side, spec.text_x, spec.text_y)
	local big = card:CreateFontString(nil, "OVERLAY")
	big:SetFont(path, spec.name_size, "OUTLINE")
	big:SetTextColor(unpack(spec.name_color))
	big:SetPoint("TOP" .. side, small, "BOTTOM" .. side, 0, -spec.line_gap)
	card.Small, card.Big = small, big
	return card
end

Module.ShowCard = function(self, card, small, big)
	card.Small:SetText(small)
	card.Big:SetText(big)
	card.age = 0
	card:SetAlpha(0)
	card:Show()
end

-- The banner behind a boss's card, a glyph on it.
Module.AddBanner = function(self, card, spec)
	local banner = card:CreateTexture(nil, "ARTWORK")
	banner:SetTexture(spec.banner.texture)
	banner:SetSize(unpack(spec.banner.size))
	banner:SetPoint("LEFT")
	banner:SetVertexColor(unpack(spec.banner.color))
	local glyph = card:CreateTexture(nil, "OVERLAY")
	glyph:SetTexture(spec.glyph.texture)
	glyph:SetSize(spec.glyph.size, spec.glyph.size)
	glyph:SetPoint("CENTER", banner, "CENTER", 0, spec.glyph.y)
	glyph:SetTexCoord(unpack(spec.glyph.coords))
	glyph:SetAlpha(spec.glyph.alpha)
end

-- `unit`'s card, unless its was shown a moment ago (a wipe, a retarget).
Module.AnnounceBoss = function(self, unit)
	local name, now = UnitName(unit), GetTime()
	local wait = self.config.boss.again_after
	if name and (now - (self.announced[name] or -wait) >= wait) then
		self.announced[name] = now
		self:ShowCard(self.Boss, _G.BOSS, name)
	end
end

Module.INSTANCE_ENCOUNTER_ENGAGE_UNIT = function(self)
	for i = 1, MAX_BOSSES do
		local unit = "boss" .. i
		if UnitExists(unit) then
			self:AnnounceBoss(unit)
		end
	end
end

Module.PLAYER_TARGET_CHANGED = function(self)
	if
		UnitExists("target")
		and (UnitClassification("target") == "worldboss")
		and UnitCanAttack("player", "target")
		and not UnitIsDead("target")
	then
		self:AnnounceBoss("target")
	end
end

Module.ZONE_CHANGED_NEW_AREA = function(self)
	local zone = GetZoneText()
	if (zone == "") or (zone == self.zone) then
		return
	end
	self.zone = zone
	local kind, _, faction = GetZonePVPInfo()
	local pvp = PVP[kind]
	local small = pvp and _G[pvp[1]]:format(faction or "") or ""
	if pvp then
		self.Zone.Small:SetTextColor(pvp[2], pvp[3], pvp[4])
	end
	self:ShowCard(self.Zone, small, zone)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Objectives").banners
end

Module.OnEnable = function(self)
	local config = self.config
	self.announced = {}
	self.Boss = self:CreateCard(config.boss, "LEFT")
	self:AddBanner(self.Boss, config.boss)
	self.Boss.Small:SetTextColor(unpack(config.boss.small_color))
	self.Zone = self:CreateCard(config.zone, "RIGHT")
	self.zone = GetZoneText() -- (where you log in: no card)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end
