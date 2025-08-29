local Addon, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Raid")

local UnitFrame = Engine:GetHandler("UnitFrame")
local StatusBar = Engine:GetHandler("StatusBar")
local C = Engine:GetDB("Data: Colors")
local AuraData = Engine:GetDB("Data: Auras")

-- Lua API
local _G = _G
local pairs = pairs
local string_match = string.match
local table_concat = table.concat
local table_insert = table.insert
local tostring = tostring
local unpack = unpack

-- WoW API
local UnitClass = _G.UnitClass

-- Time limit in seconds where we separate between short and long buffs
local TIME_LIMIT = Engine:GetConstant("AURA_TIME_LIMIT")
local TIME_LIMIT_LOW = Engine:GetConstant("AURA_TIME_LIMIT_LOW")


local postUpdateHealth = function(health, unit, curHealth, maxHealth, isUnavailable)
	local r, g, b
	if (not isUnavailable) then
		if UnitIsPlayer(unit) then
			local missingImportantBuff = false
            local importantBuffs = {
                "Power Word: Fortitude",
                "Divine Spirit",
                "Shadow Protection"
            }	

            for _, buffName in ipairs(importantBuffs) do
                if not UnitBuff(unit, buffName) then
                    missingImportantBuff = false
                    break
                end
            end

            if missingImportantBuff then
                r, g, b = 0.6, 0, 1 -- purple for missing buffs
			elseif health.useClassColor then
				local _, class = UnitClass(unit)
				r, g, b = unpack(class and C.Class[class] or C.Class.UNKNOWN)
			else
				r, g, b = unpack(C.Orb.HEALTH[1])
			end
		elseif UnitPlayerControlled(unit) then
			if UnitIsFriend("player", unit) then
				r, g, b = unpack(C.Reaction[5])
			elseif UnitIsEnemy(unit, "player") then
				r, g, b = unpack(C.Reaction[1])
			else
				r, g, b = unpack(C.Reaction[4])
			end
		elseif (not UnitIsFriend("player", unit)) and UnitIsTapDenied(unit) then
			r, g, b = unpack(C.Status.Tapped)
		elseif UnitReaction(unit, "player") then
			r, g, b = unpack(C.Reaction[UnitReaction(unit, "player")])
		else
			r, g, b = unpack(C.Orb.HEALTH[1])
		end
	elseif (isUnavailable == "dead") or (isUnavailable == "ghost") then
		r, g, b = unpack(C.Status.Dead)
	elseif (isUnavailable == "offline") then
		r, g, b = unpack(C.Status.Disconnected)
	end

	if r then
		if not((r == health.r) and (g == health.g) and (b == health.b)) then
			health:SetStatusBarColor(r, g, b)
			health.r, health.g, health.b = r, g, b
		end
	end

	if UnitAffectingCombat("player") then
		health.Value:SetAlpha(1)
	else
		health.Value:SetAlpha(.7)
	end

end

local updateLayers = function(self)
	if self:IsMouseOver() then
		self.BorderNormalHighlight:Show()
		self.BorderNormal:Hide()
	else
		self.BorderNormal:Show()
		self.BorderNormalHighlight:Hide()
	end
end

local PostCreateAuraButton = function(self, button)
	local config = self.buttonConfig
	local width, height = unpack(config.size)
	local r, g, b = unpack(config.color)

	local icon = button:GetElement("Icon")
	local overlay = button:GetElement("Overlay")
	local scaffold = button:GetElement("Scaffold")
	local timer = button:GetElement("Timer")

	local timerBar = timer.Bar
	local timerBarBackground = timer.Background
	local timerScaffold = timer.Scaffold

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
	iconDarken:SetColorTexture(0, 0, 0, .15)

	local iconOverlay = overlay:CreateTexture()
	iconOverlay:Hide()
	iconOverlay:SetDrawLayer("OVERLAY")
	iconOverlay:SetAllPoints(icon)
	iconOverlay:SetColorTexture(0, 0, 0, 1)
	icon.Overlay = iconOverlay

	local timerOverlay = timer:CreateFrame()
	timerOverlay:SetFrameLevel(timer:GetFrameLevel() + 3)
	timerOverlay:SetPoint("TOPLEFT", -3, 3)
	timerOverlay:SetPoint("BOTTOMRIGHT", 3, -3)
	timerOverlay:SetBackdrop(config.glow.backdrop)

	button.SetBorderColor = function(self, r, g, b)
		timerBarBackground:SetVertexColor(r * 1/3, g * 1/3, b * 1/3)
		timerBar:SetStatusBarColor(r * 2/3, g * 2/3, b * 2/3)

		overlay:SetBackdropBorderColor(r, g, b, .5)
		glow:SetBackdropBorderColor(r/3, g/3, b/3, .75)
		timerOverlay:SetBackdropBorderColor(r, g, b, .5)

		scaffold:SetBackdropColor(r * 1/3, g * 1/3, b * 1/3)
		scaffold:SetBackdropBorderColor(r, g, b)

		timerScaffold:SetBackdropColor(r * 1/3, g * 1/3, b * 1/3)
		timerScaffold:SetBackdropBorderColor(r, g, b)
	end

	button:SetElement("Glow", glow)
	button:SetSize(width, height)
	button:SetBorderColor(r * 4/5, g * 4/5, b * 4/5)
end


-- TODO: Add PvP relevant buffs to a whitelist in these filters 
-- TODO: Optimize the code once we're happy with the functionality

local Filter = Engine:GetDB("Library: AuraFilters")
local Filter_UnitIsHostileNPC = Filter.UnitIsHostileNPC

-- No buffs at all on raid frames
local buffFilter = function(self, ...)
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

-- Helper to check what the player can dispel
function IsDispellableByPlayer(debuffType)
	local _, class = UnitClass("player")
	if class == "PRIEST" then
		return (debuffType == "Magic" or debuffType == "Disease")
	elseif class == "PALADIN" then
		return (debuffType == "Magic" or debuffType == "Poison" or debuffType == "Disease")
	elseif class == "DRUID" then
		return (debuffType == "Magic" or debuffType == "Curse" or debuffType == "Poison")
	elseif class == "SHAMAN" then
		return (debuffType == "Magic" or debuffType == "Curse")
	elseif class == "MAGE" then
		return (debuffType == "Curse")
	elseif class == "MONK" then
		return (debuffType == "Magic" or debuffType == "Disease" or debuffType == "Poison")
	end
	return false
end

local PostUpdateAuraButton = function(self, button, ...)
	local updateType = ...
	local config = self.buttonConfig

	local icon = button:GetElement("Icon")
	local glow = button:GetElement("Glow")
	local timer = button:GetElement("Timer")
	local scaffold = button:GetElement("Scaffold")

	if timer:IsShown() then
		glow:SetPoint("BOTTOMRIGHT", timer, "BOTTOMRIGHT", 3, -3)
	else
		glow:SetPoint("BOTTOMRIGHT", scaffold, "BOTTOMRIGHT", 3, -3)
	end
	
	if self.hideTimerBar then
		local color = config.color
		button:SetBorderColor(color[1], color[2], color[3]) 
		icon:SetDesaturated(false)
		icon:SetVertexColor(.85, .85, .85)
	else
		if button.isBuff then
			if button.isStealable then
				local color = C.General.Title
				button:SetBorderColor(color[1], color[2], color[3]) 
				icon:SetDesaturated(false)
				icon:SetVertexColor(1, 1, 1)
				icon.Overlay:Hide()

			elseif button.isCastByPlayer then
				local color = C.General.XP
				button:SetBorderColor(color[1], color[2], color[3]) 
				icon:SetDesaturated(false)
				icon:SetVertexColor(1, 1, 1)
				icon.Overlay:Hide()
			else
				local color = config.color
				button:SetBorderColor(color[1], color[2], color[3]) 

				if icon:SetDesaturated(true) then
					icon:SetVertexColor(1, 1, 1)
					icon.Overlay:SetVertexColor(C.General.UIOverlay[1], C.General.UIOverlay[2], C.General.UIOverlay[3], .5)
					icon.Overlay:Show()
				else
					icon:SetDesaturated(false)
					icon:SetVertexColor(.7, .7, .7)
					icon.Overlay:SetVertexColor(C.General.UIOverlay[1], C.General.UIOverlay[2], C.General.UIOverlay[3], .25)
					icon.Overlay:Show()
				end		
			end

		elseif button.isCastByPlayer then
			button:SetBorderColor(.7, .1, .1)
			icon:SetDesaturated(false)
			icon:SetVertexColor(1, 1, 1)
			icon.Overlay:Hide()

		else
			local color = config.color
			button:SetBorderColor(color[1], color[2], color[3])

			if icon:SetDesaturated(true) then
				icon:SetVertexColor(1, 1, 1)
				icon.Overlay:SetVertexColor(C.General.UIOverlay[1], C.General.UIOverlay[2], C.General.UIOverlay[3], .5)
				icon.Overlay:Show()
			else
				icon:SetDesaturated(false)
				icon:SetVertexColor(.7, .7, .7)
				icon.Overlay:SetVertexColor(C.General.UIOverlay[1], C.General.UIOverlay[2], C.General.UIOverlay[3], .25)
				icon.Overlay:Show()
			end		
		end
	end
end


local fakeUnitNum = 0
local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.raid
	local db = Module:GetConfig("UnitFrames") 

	--self:Size(unpack(config.size))
	--self:Place(unpack(config.position))

	local unitNum = string_match(unit, "%d")
	if (not unitNum) then 
		fakeUnitNum = fakeUnitNum + 1
		unitNum = fakeUnitNum
	end 

	self:Size(unpack(config.size))
	self:Place("TOP", 0, -((unitNum-1) * 90))

	-- Artwork
	-------------------------------------------------------------------

	local Shade = self:CreateTexture(nil, "BACKGROUND")
	Shade:SetSize(unpack(config.shade.size))
	Shade:SetPoint(unpack(config.shade.position))
	Shade:SetTexture(config.shade.texture)
	Shade:SetVertexColor(config.shade.color)

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

	Health.PostUpdate = postUpdateHealth
	Health.useClassColor = true


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
	auras.hideTimerBar = true

	auras.BuffFilter = buffFilter
	auras.DebuffFilter = debuffFilter
	auras.PostCreateButton = PostCreateAuraButton
	auras.PostUpdateButton = PostUpdateAuraButton


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


	self.Auras = auras
	self.CastBar = CastBar
	self.Health = Health
	self.Name = Name
	self.Threat = Threat

	self.BorderNormal = BorderNormal
	self.BorderNormalHighlight = BorderNormalHighlight

	self:HookScript("OnEnter", updateLayers)
	self:HookScript("OnLeave", updateLayers)
	

end 

UnitFrameWidget.OnEnable = function(self)
    local config = self:GetDB("UnitFrames").visuals.units.raid
    local db = self:GetConfig("UnitFrames") 
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

    local function LayoutRaidFrames()
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

        for i = 1, GetNumGroupMembers() do
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
    self.UnitFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
    self.UnitFrame:RegisterEvent("RAID_ROSTER_UPDATE")
    self.UnitFrame:SetScript("OnEvent", LayoutRaidFrames)

    -- Initial layout
    LayoutRaidFrames()
end

UnitFrameWidget.GetFrame = function(self, raidIndex)
	return self.UnitFrame[raidIndex] or self.UnitFrame
end