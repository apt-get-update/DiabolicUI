local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Raid")

local StatusBar = Engine:GetHandler("StatusBar")
local Library = Engine:GetDB("Library: UnitFrames")

-- Lua API
local _G = _G
local string_match = string.match
local unpack = unpack

-- WoW API
local GetNumRaidMembers = _G.GetNumRaidMembers
local GetSpellInfo = _G.GetSpellInfo
local UnitClass = _G.UnitClass


-- No buffs at all on raid frames
local buffFilter = function(self, ...)
	return false
end


-- Cleanse Spirit is a talent. GetSpellInfo by ID always returns the
-- localized name; GetSpellInfo by *name* only returns something when the
-- spell is in the player's spellbook, which also tracks respecs.
local CLEANSE_SPIRIT = GetSpellInfo(51886)

-- What the player can remove from a friendly target, as of WotLK.
-- Druids and shamans only gained Magic removal in Cataclysm.
local IsDispellableByPlayer = function(debuffType)
	local _, class = UnitClass("player")
	if class == "PRIEST" then
		return (debuffType == "Magic" or debuffType == "Disease")
	elseif class == "PALADIN" then
		return (debuffType == "Magic" or debuffType == "Poison" or debuffType == "Disease")
	elseif class == "DRUID" then
		return (debuffType == "Curse" or debuffType == "Poison")
	elseif class == "SHAMAN" then
		if (debuffType == "Poison" or debuffType == "Disease") then
			return true
		end
		return (debuffType == "Curse") and (CLEANSE_SPIRIT ~= nil) and (GetSpellInfo(CLEANSE_SPIRIT) ~= nil)
	elseif class == "MAGE" then
		return (debuffType == "Curse")
	end
	return false
end

-- Only show the most important dispellable debuff
local debuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff)
	-- If it's a boss debuff, always show it
	if isBossDebuff then
		return true
	end

	-- Only show if it's dispellable by *you*
	if debuffType and IsDispellableByPlayer(debuffType) then
		return true
	end

	return false
end


local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.raid
	local db = Module:GetConfig("UnitFrames") 

	local unitNum = string_match(unit, "%d") -- (raid1 to raid40)

	self:SetSize(unpack(config.size))
	self:Place("TOP", 0, -((unitNum-1) * 90))

	-- Artwork
	-------------------------------------------------------------------

	local Shade = self:CreateTexture(nil, "BACKGROUND")
	Shade:SetSize(unpack(config.shade.size))
	Shade:SetPoint(unpack(config.shade.position))
	Shade:SetTexture(config.shade.texture)
	Shade:SetVertexColor(unpack(config.shade.color))

	local Backdrop = self:CreateTexture(nil, "BORDER")
	Backdrop:SetSize(unpack(config.backdrop.texture_size))
	Backdrop:SetPoint(unpack(config.backdrop.texture_position))
	Backdrop:SetTexture(config.backdrop.texture)

	-- border overlay frame
	local Border = self:CreateFrame("Frame")
	Border:SetFrameLevel(self:GetFrameLevel() + 4)
	Border:SetAllPoints()
	
	local BorderNormal = Border:CreateTexture(nil, "BORDER")
	BorderNormal:SetSize(unpack(config.border.texture_size))
	BorderNormal:SetPoint(unpack(config.border.texture_position))
	BorderNormal:SetTexture(config.border.textures.normal)
	
	local BorderNormalHighlight = Border:CreateTexture(nil, "BORDER")
	BorderNormalHighlight:SetSize(unpack(config.border.texture_size))
	BorderNormalHighlight:SetPoint(unpack(config.border.texture_position))
	BorderNormalHighlight:SetTexture(config.border.textures.highlight)
	BorderNormalHighlight:Hide()


	-- Threat
	-------------------------------------------------------------------
	local Threat = self:CreateTexture(nil, "BACKGROUND")
	Threat:Hide()
	Threat:SetSize(unpack(config.border.texture_size))
	Threat:SetPoint(unpack(config.border.texture_position))
	Threat:SetTexture(config.border.textures.threat)
	

	-- Health
	-------------------------------------------------------------------
	local Health = StatusBar:New(self)
	Health:SetSize(unpack(config.health.size))
	Health:SetPoint(unpack(config.health.position))
	Health:SetStatusBarTexture(config.health.texture)
	Health.frequent = 1/120

	local HealthValueHolder = Health:CreateFrame("Frame")
	HealthValueHolder:SetAllPoints()
	HealthValueHolder:SetFrameLevel(Border:GetFrameLevel() + 1)
	
	Health.Value = HealthValueHolder:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(config.texts.health.font_object)
	Health.Value:SetPoint(unpack(config.texts.health.position))
	Health.Value.showPercent = true
	Health.Value.showDeficit = false
	Health.Value.showMaximum = false
	Health.Value.hideMinimum = true

	Health.PostUpdate = Library.PostUpdateHealth
	Health.useClassColor = db.showClassColors
	Health.dimOutOfCombat = true


	-- CastBar
	-------------------------------------------------------------------
	local CastBar = StatusBar:New(Health)
	CastBar:Hide()
	CastBar:SetAllPoints()
	CastBar:SetStatusBarTexture(1, 1, 1, .15)
	CastBar:SetSize(Health:GetSize())
	CastBar:DisableSmoothing(true)


	-- Auras
	-------------------------------------------------------------------
	local auras = self:CreateFrame()
	auras:SetSize(unpack(config.auras.size))
	auras:Place(unpack(config.auras.position))
	
	auras.config = config.auras
	auras.buttonConfig = config.auras.button
	auras.auraSize = config.auras.button.size
	auras.spacingH = config.auras.spacingH
	auras.spacingV = config.auras.spacingV
	auras.growthX = "RIGHT"
	auras.growthY = "DOWN"
	auras.filter = nil

	auras.BuffFilter = buffFilter
	auras.DebuffFilter = debuffFilter
	auras.PostCreateButton = Library.PostCreateAuraButton


	-- Texts
	-------------------------------------------------------------------
	local Name = Border:CreateFontString(nil, "OVERLAY")
	Name:SetFontObject(config.name.font_object)
	Name:SetPoint(unpack(config.name.position))
	Name:SetSize(unpack(config.name.size))
	Name:SetJustifyV("BOTTOM")
	Name:SetJustifyH("CENTER")
	Name:SetIndentedWordWrap(false)
	Name:SetWordWrap(true)
	Name:SetNonSpaceWrap(false)


	-- Role Icon
	-------------------------------------------------------------------
	-- Parented to Border (elevated frame level) so it isn't drawn behind
	-- the border/backdrop skin, positioned to the left of the health bar.
	local Role = Border:CreateTexture(nil, "OVERLAY")
	Role:SetSize(unpack(config.role.size))
	Role:SetPoint(config.role.position[1], Health, config.role.position[2], config.role.position[3])
	Role:SetTexture(config.role.texture)
	Role:Hide()


	self.Auras = auras
	self.CastBar = CastBar
	self.Health = Health
	self.Name = Name
	self.Role = Role
	self.Threat = Threat

	self.BorderNormal = BorderNormal
	self.BorderNormalHighlight = BorderNormalHighlight

	self:HookScript("OnEnter", Library.UpdateLayers)
	self:HookScript("OnLeave", Library.UpdateLayers)


end

-- Exposed so units/testmode.lua's Toggle Fake Raid can reuse this purely-visual
-- builder to construct mock preview frames, without needing to go through
-- the real (unit-token-driven) UnitFrame:New/Handler.New pipeline.
UnitFrameWidget.Style = Style

-- Exposed for tests/test_unitframes_raid.lua.
UnitFrameWidget.DebuffFilter = debuffFilter

UnitFrameWidget.OnEnable = function(self)
    local config = self:GetDB("UnitFrames").visuals.units.raid
    local UnitFrame = Engine:GetHandler("UnitFrame")

    -- Spawn a holder for all raid frames
    self.UnitFrame = Engine:CreateFrame("Frame", nil, "UICenter", "SecureHandlerAttributeTemplate")
    self.UnitFrame:Place(unpack(config.position))
    RegisterStateDriver(self.UnitFrame, "visibility", "[@raid1,exists]show;hide")

    -- Create 40 frames
    self.UnitFrames = {}
    for i = 1, 40 do
        local unitFrame = UnitFrame:New("raid"..i, self.UnitFrame, Style)
        self.UnitFrames[i] = unitFrame
    end

    -- The frames are secure, so they can't be moved in combat: a roster
    -- change in combat is laid out as soon as it ends.
    local function LayoutRaidFrames(_, event)
        if InCombatLockdown() then
            self.UnitFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
            return
        end
        if (event == "PLAYER_REGEN_ENABLED") then
            self.UnitFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        end

        local membersPerGroup = 5
        local groupsPerColumn = 2
        local xOffset = config.size[1] + (config.offset or 5) + (config.auras.button.size[1] or 0) + 3 --aura size and a little extra padding
        local yOffset = -(config.size[2] + (config.offset or 5))

        -- Clear all points
        for i = 1, 40 do
            self.UnitFrames[i]:ClearAllPoints()
            self.UnitFrames[i]:Hide()
        end

        -- Track rows within each group
        local groupRows = {}
        for g = 1, 8 do groupRows[g] = 0 end

        for i = 1, GetNumRaidMembers() do
            local name, _, subgroup = GetRaidRosterInfo(i)
            if name and subgroup >= 1 and subgroup <= 8 then
                local frame = self.UnitFrames[i]

                -- Which column this group belongs to
                local col = math.floor((subgroup - 1) / groupsPerColumn)
                -- Vertical offset within the column
                local groupInColumn = (subgroup - 1) % groupsPerColumn
                local row = groupRows[subgroup]

                local anchorX = col * xOffset
                local anchorY = (groupInColumn * membersPerGroup + row) * yOffset

                frame:SetPoint("TOPLEFT", self.UnitFrame, "TOPLEFT", anchorX, anchorY)
                frame:Show()

                groupRows[subgroup] = groupRows[subgroup] + 1
            end
        end
    end

    -- Update when raid changes
    self.UnitFrame:RegisterEvent("RAID_ROSTER_UPDATE")
    self.UnitFrame:SetScript("OnEvent", LayoutRaidFrames)

    -- Initial layout
    LayoutRaidFrames()
end

-- The frame of raid member `raidIndex`, or the holder of them all.
UnitFrameWidget.GetFrame = function(self, raidIndex)
	return raidIndex and self.UnitFrames[raidIndex] or self.UnitFrame
end