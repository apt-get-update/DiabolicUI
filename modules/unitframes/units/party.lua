local Addon, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Party")

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
			if health.useClassColor then
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

local buffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)

	local unit = self.unit

	-- If it's a party member, only show buffs from me (or vehicle)
	if UnitIsFriend("player", unit) then
	    return isCastByPlayer or (unitCaster == "vehicle")
	end

	if (isBossDebuff) or (isStealable) then 
		return true 

	elseif UnitIsFriend("player", unit) and (isCastByPlayer or unitCaster == "vehicle") then
    	return true

	elseif (isCastByPlayer or (unitCaster == "vehicle")) and (duration and ((duration > 0) and (duration < TIME_LIMIT_LOW))) then 
		return true 

	elseif ((unitCaster and UnitIsUnit(unit, unitCaster)) and duration and ((duration > 0) and (duration < TIME_LIMIT_LOW))) then
		return true

	elseif (not unitCaster) and (not IsInInstance()) then -- cache this
		-- EXPERIMENTAL: ignore debuffs from players outside the group, eg. world bosses
		return

	elseif (UnitCanAttack("player", unit) and (not UnitPlayerControlled(unit))) then
		-- Hostile NPC.
		-- Show auras cast by the unit, and auras of unknown origin.
		return (not unitCaster) or (unitCaster == unit)

	elseif (not unitCaster) then
		-- Friendly target or hostile player
		-- Show auras of unknown origin
		return true

	elseif (not isCastByPlayer) then
		-- Need to make a whitelist of certain pvp related player shields, cooldowns and stuff here
		return spellId and AuraData[spellId] or false

	elseif (duration and (duration > 0)) then
		if (duration > TIME_LIMIT_LOW) then
			return false
		end
		return true
	end
end

local debuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)

	-- The unitframe's unitID
	local unit = self.unit

	-- Info about the unitframe's unit (the unit the auras are applied to)
	local unitLevel = UnitLevel(unit)
	local unitClassificiation = UnitClassification(unit)
	local unitIsHostilePlayer = UnitIsPlayer(unit) and UnitIsEnemy("player", unit)
	local unitIsHostileNPC = UnitCanAttack("player", unit) and (not UnitPlayerControlled(unit))
	local unitIsImportant = (unitClassificiation == "worldboss") or (unitClassificiation == "rare") or (unitClassificiation == "rareelite") or (level and level < 1) 

	-- Info about the caster of the auras 
	local casterIsUnit = unitCaster and ((unitCaster == unit) or UnitIsUnit(unit, unitCaster))
	local casterIsVehicle = unitCaster and ((unitCaster == "vehicle") or UnitIsUnit("vehicle", unitCaster))

	-- Info about the auras themselves
	local isShortDuration = duration and (duration > 0) and (duration < TIME_LIMIT)
	local isLongDuration = duration and (duration > TIME_LIMIT)
	local isStatic = (not duration) or (duration == 0)
	local isCC = ENGINE_LEGION and spellId and AuraData.cc[spellId] -- Any CC 
	local isLoC = ENGINE_LEGION and spellId and AuraData.loc[spellId] -- Loss of Control CC

	-- If this is a friendly unitframe, prioritize useful/dispellable info
	if UnitIsFriend("player", unit) then
	    -- Always show boss debuffs on party
	    if isBossDebuff then 
	    	return true
	    end
	    -- Show dispellables (Magic/Curse/Disease/Poison)
	    if debuffType then 
	    	return true 
	    end
	    -- Show my own debuffs (e.g., Weakened Soul) and vehicle
	    if isCastByPlayer or (unitCaster == "vehicle") then 
	    	return true 
	    end
	    -- Otherwise hide
	    return false
	end

	-- Always show boss debuffs on your target
	if isBossDebuff then
		return true

	-- Always show debuffs cast by your vehicle 
	elseif casterIsVehicle then
		return true

	-- Hide Loss of Control CC from the target when enemy plates are visible
	--elseif ENEMY_PLATES and isLoC then
	--elseif ENEMY_PLATES and unitIsHostilePlayer and isShortDuration then 
	--	return false

	-- Show debuffs cast by the player, unless it's currently visible on a nameplate
	elseif isCastByPlayer then

		-- Enemy plates are visible (implies Legion)and the target is hostile.
		-- Filter out debuffs shown on the nameplates. This must match the nameplate filter.
		--if ENEMY_PLATES and (unitIsHostilePlayer or unitIsHostileNPC) and isShortDuration then 
		--if ENEMY_PLATES and unitIsHostilePlayer and isShortDuration then 
		--	return false
		--end
		return true

	elseif (not unitCaster) and (not IsInInstance()) then
		-- EXPERIMENTAL: ignore debuffs from players outside the group, eg. world bosses
		return

	elseif unitIsHostileNPC then
		return (not unitCaster) or (unitCaster == unit)

	elseif (not isCastByPlayer) then
		-- Need to make a whitelist of certain pvp related player shields, cooldowns and stuff here
		return spellId and AuraData[spellId] or false

	elseif duration and (duration > 0) then
		if duration > TIME_LIMIT_LOW then
			return false
		end
		return true
	end
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
	local config = Module:GetDB("UnitFrames").visuals.units.party
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
	local config = self:GetDB("UnitFrames").visuals.units.party
	local db = self:GetConfig("UnitFrames") 

	-- Retrieve the unitframe handler
	local UnitFrame = Engine:GetHandler("UnitFrame")

	-- Spawn a holder for all party frames
	self.UnitFrame = Engine:CreateFrame("Frame", nil, "UICenter", "SecureHandlerAttributeTemplate")
	self.UnitFrame:Place(unpack(config.position))
	self.UnitFrame:SetSize(config.size[1], config.size[2]*4 + config.offset*3)
	RegisterStateDriver(self.UnitFrame, "visibility", "[@raid1,exists]hide;show")

	local function LayoutPartyFrames()
		for i = 1,4 do 
			local unitFrame = UnitFrame:New("party"..i, self.UnitFrame, Style) 
			--local unitFrame = UnitFrame:New("player", self.UnitFrame, Style) 

			self.UnitFrame[i] = unitFrame
		end
	end 

	-- Update when party changes
    self.UnitFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
    self.UnitFrame:SetScript("OnEvent", LayoutPartyFrames)

    -- Initial layout
    LayoutPartyFrames()

end 

UnitFrameWidget.GetFrame = function(self, numPartyMember)
	return self.UnitFrame[numPartyMember] or self.UnitFrame
end
