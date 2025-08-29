local Addon, Engine = ...

local UnitFrame = Engine:GetHandler("UnitFrame")
local StatusBar = Engine:GetHandler("StatusBar")
local AuraData = Engine:GetDB("Data: Auras")
local C = Engine:GetDB("Data: Colors")

local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Target")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local GetCVarBool = _G.GetCVarBool
local IsInInstance = _G.IsInInstance
local PlaySoundKitID = Engine:IsBuild("7.3.0") and _G.PlaySound or _G.PlaySoundKitID
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassification = _G.UnitClassification
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitExists = _G.UnitExists
local UnitLevel = _G.UnitLevel
local UnitPowerType = _G.UnitPowerType
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitIsUnit = _G.UnitIsUnit

-- Time limit in seconds where we separate between short and long buffs
local TIME_LIMIT = Engine:GetConstant("AURA_TIME_LIMIT")
local TIME_LIMIT_LOW = Engine:GetConstant("AURA_TIME_LIMIT_LOW")

-- Client Constants
local ENGINE_LEGION = Engine:IsBuild("Legion")

-- Constant tracking Legion nameplate visibility
local ENEMY_PLATES = ENGINE_LEGION and GetCVarBool("nameplateShowEnemies") 


-- Utility Functions
--------------------------------------------------------------------------

-- reposition the unit classification when needed
local PostUpdateClassification = function(self, unit)
	if not unit then
		return
	end

	local isPlayer = UnitIsPlayer(unit)

	local powerID, powerType = UnitPowerType(unit)
	local power = UnitPower(unit, powerID)
	local powermax = UnitPowerMax(unit, powerID)

	local haspower = isPlayer or not(power == 0 or powermax == 0)

	local level = UnitLevel(unit)
	local classification = UnitClassification(unit)

	local isboss = (classification == "worldboss") or (level and level < 1)
	local isElite = (classification == "elite") or (classification == "rare") or (classification == "rareelite")

	local hadpower = self.haspower
	local wasboss = self.isboss
	local waselite = self.iselite
	
	-- todo: clean this mess up
	if isboss then
		if haspower then
			if hadpower and wasboss then
				return
			end
			self:Place(unpack(self.position.boss_double))
			self.haspower = true
		else
			if wasboss and (not hadpower) then
				return
			end
			self:Place(unpack(self.position.boss_single))
			self.haspower = false
		end
		self.isboss = true
		self.iselite = false
	elseif isElite then
		if haspower then
			if hadpower and waselite then
				return
			end
			self:Place(unpack(self.position.elite_double))
			self.haspower = true
		else
			if waselite and (not hadpower) then
				return
			end
			self:Place(unpack(self.position.elite_single))
			self.haspower = false
		end
		self.iselite = true
		self.isboss = false
	else
		if haspower then
			if hadpower and (not wasboss) then
				return
			end
			self:Place(unpack(self.position.normal_double))
			self.haspower = true
		else
			if (not hadpower) and (not wasboss) then
				return
			end
			self:Place(unpack(self.position.normal_single))
			self.haspower = false
		end
		self.isboss = false
		self.iselite = false
	end
end

local PostUpdateArtwork = function(self)
	local unit = self.unit
	if not unit then
		return
	end

	local isPlayer = UnitIsPlayer(unit)

	local powerID, powerType = UnitPowerType(unit)
	local power = UnitPower(unit, powerID)
	local powermax = UnitPowerMax(unit, powerID)

	local haspower = isPlayer or not(power == 0 or powermax == 0)

	local level = UnitLevel(unit)
	local classification = UnitClassification(unit)

	local isElite = (classification == "elite") or (classification == "rare") or (classification == "rareelite")
	local isboss = (classification == "worldboss") or (level and level < 1)
	
	local ishighlight = self:IsMouseOver()
	
	if (isboss == self.isboss) and (isElite == self.iselite) and (haspower == self.haspower) and (ishighlight == self.ishighlight) then
		return -- avoid unneeded graphic updates
	else
		if (not haspower) and (self.haspower == true) then
			-- Forcefully empty the bar fast to avoid 
			-- it being visible after the border has been hidden.
			self.Power:Clear() 
		end

		self.iselite = isElite
		self.isboss = isboss
		self.haspower = haspower
		self.ishighlight = ishighlight

		local cache = self.layers
		local border_name = "Border" .. (isElite and "Elite" or isboss and "Boss" or "Normal") .. (haspower and "Power" or "") .. (ishighlight and "Highlight" or "")
		local backdrop_name = "Backdrop" .. (haspower and "Power" or "")
		local threat_name = "Threat" .. ((isElite or isboss) and "Boss" or "Normal") .. (haspower and "Power" or "")
		
		-- display the correct border texture
		cache.border[border_name]:Show()
		for id,layer in pairs(cache.border) do
			if id ~= border_name then
				layer:Hide()
			end
		end
		
		-- display the correct backdrop texture
		cache.backdrop[backdrop_name]:Show()
		for id,layer in pairs(cache.backdrop) do
			if id ~= backdrop_name then
				layer:Hide()
			end
		end
		
		-- display the correct threat texture
		--  *This does not affect the visibility of the main threat object, 
		--   it only handles the visibility of the separate sub-textures.
		cache.threat[threat_name]:Show()
		for id,layer in pairs(cache.threat) do
			if id ~= threat_name then
				layer:Hide()
			end
		end
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
	if (isBossDebuff) 
	or (isStealable) 
	or (isCastByPlayer or (unitCaster == "vehicle"))
	or ((unitCaster and UnitIsUnit(unit, unitCaster)) and duration and (duration > 0) and (duration < TIME_LIMIT)) then
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
		if (duration > TIME_LIMIT) then
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
		if duration > TIME_LIMIT then
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

local PostUpdateHealth = function(health, unit, curHealth, maxHealth, isUnavailable)

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
			r, g, b = unpack(C.Orb.HEALTH[1])
		elseif (not UnitIsFriend("player", unit)) and UnitIsTapDenied(unit) then
			r, g, b = unpack(C.Status.Tapped)
		--elseif UnitReaction(unit, "player") then
			--r, g, b = unpack(C.Reaction[UnitReaction(unit, "player")])
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

local PostUpdateFrame = function(self, event, ...)
	PostUpdateArtwork(self)
	PostUpdateClassification(self.Classification, self.unit)
end

local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.target
	local db = Module:GetConfig("UnitFrames") 
	
	self:Size(unpack(config.size))
	self:Place(unpack(config.position))


	-- Artwork
	-------------------------------------------------------------------

	local shade = self:CreateTexture(nil, "BACKGROUND")
	shade:SetSize(unpack(config.textures.layers.shade.size))
	shade:SetPoint(unpack(config.textures.layers.shade.position))
	shade:SetTexture(config.textures.layers.shade.texture)
	shade:SetVertexColor(config.textures.layers.shade.color)

	local backdrop = self:CreateTexture(nil, "BACKGROUND")
	backdrop:SetSize(unpack(config.textures.size))
	backdrop:SetPoint(unpack(config.textures.position))
	backdrop:SetTexture(config.textures.layers.backdrop.single)

	local backdropPower = self:CreateTexture(nil, "BACKGROUND")
	backdropPower:SetSize(unpack(config.textures.size))
	backdropPower:SetPoint(unpack(config.textures.position))
	backdropPower:SetTexture(config.textures.layers.backdrop.double)
	
	local border = self:CreateFrame()
	border:SetFrameLevel(self:GetFrameLevel() + 4)
	border:SetAllPoints()
	
	local borderNormal = border:CreateTexture(nil, "BORDER")
	borderNormal:SetSize(unpack(config.textures.size))
	borderNormal:SetPoint(unpack(config.textures.position))
	borderNormal:SetTexture(config.textures.layers.border.standard_single.normal)
	
	local borderNormalHighlight = border:CreateTexture(nil, "BORDER")
	borderNormalHighlight:SetSize(unpack(config.textures.size))
	borderNormalHighlight:SetPoint(unpack(config.textures.position))
	borderNormalHighlight:SetTexture(config.textures.layers.border.standard_single.highlight)

	local borderNormalPower = border:CreateTexture(nil, "BORDER")
	borderNormalPower:SetSize(unpack(config.textures.size))
	borderNormalPower:SetPoint(unpack(config.textures.position))
	borderNormalPower:SetTexture(config.textures.layers.border.standard_double.normal)

	local borderNormalPowerHighlight = border:CreateTexture(nil, "BORDER")
	borderNormalPowerHighlight:SetSize(unpack(config.textures.size))
	borderNormalPowerHighlight:SetPoint(unpack(config.textures.position))
	borderNormalPowerHighlight:SetTexture(config.textures.layers.border.standard_double.highlight)

	local borderBoss = border:CreateTexture(nil, "BORDER")
	borderBoss:SetSize(unpack(config.textures.size))
	borderBoss:SetPoint(unpack(config.textures.position))
	borderBoss:SetTexture(config.textures.layers.border.boss_single.normal)

	local borderBossHighlight = border:CreateTexture(nil, "BORDER")
	borderBossHighlight:SetSize(unpack(config.textures.size))
	borderBossHighlight:SetPoint(unpack(config.textures.position))
	borderBossHighlight:SetTexture(config.textures.layers.border.boss_single.highlight)

	local borderBossPower = border:CreateTexture(nil, "BORDER")
	borderBossPower:SetSize(unpack(config.textures.size))
	borderBossPower:SetPoint(unpack(config.textures.position))
	borderBossPower:SetTexture(config.textures.layers.border.boss_double.normal)

	local borderBossPowerHighlight = border:CreateTexture(nil, "BORDER")
	borderBossPowerHighlight:SetSize(unpack(config.textures.size))
	borderBossPowerHighlight:SetPoint(unpack(config.textures.position))
	borderBossPowerHighlight:SetTexture(config.textures.layers.border.boss_double.highlight)

	local borderElite = border:CreateTexture(nil, "BORDER")
	borderElite:SetSize(unpack(config.textures.size))
	borderElite:SetPoint(unpack(config.textures.position))
	borderElite:SetTexture(config.textures.layers.border.elite_single.normal)

	local borderEliteHighlight = border:CreateTexture(nil, "BORDER")
	borderEliteHighlight:SetSize(unpack(config.textures.size))
	borderEliteHighlight:SetPoint(unpack(config.textures.position))
	borderEliteHighlight:SetTexture(config.textures.layers.border.elite_single.highlight)

	local borderElitePower = border:CreateTexture(nil, "BORDER")
	borderElitePower:SetSize(unpack(config.textures.size))
	borderElitePower:SetPoint(unpack(config.textures.position))
	borderElitePower:SetTexture(config.textures.layers.border.elite_double.normal)

	local borderElitePowerHighlight = border:CreateTexture(nil, "BORDER")
	borderElitePowerHighlight:SetSize(unpack(config.textures.size))
	borderElitePowerHighlight:SetPoint(unpack(config.textures.position))
	borderElitePowerHighlight:SetTexture(config.textures.layers.border.elite_double.highlight)


	-- Health
	-------------------------------------------------------------------
	local health = self:CreateStatusBar()
	health:SetSize(unpack(config.health.size))
	health:SetPoint(unpack(config.health.position))
	health:SetStatusBarTexture(config.health.texture)
	health.frequent = 1/120
	
	local healthValueHolder = health:CreateFrame()
	healthValueHolder:SetAllPoints()
	healthValueHolder:SetFrameLevel(border:GetFrameLevel() + 1)
	
	health.Value = healthValueHolder:CreateFontString(nil, "OVERLAY")
	health.Value:SetFontObject(config.texts.health.font_object)
	health.Value:SetPoint(unpack(config.texts.health.position))
	health.Value.showPercent = false
	health.Value.showDeficit = false
	health.Value.showMaximum = true
	health.PostUpdate = PostUpdateHealth
	health.useClassColor = true

	
	-- Power
	-------------------------------------------------------------------
	local power = self:CreateStatusBar()
	power:SetSize(unpack(config.power.size))
	power:SetPoint(unpack(config.power.position))
	power:SetStatusBarTexture(config.power.texture)
	power.frequent = 1/120

	-- Add a postupdate to dynamically toggle powerbar artwork when needed
	power.PostUpdate = function(power, min, max)
		local unit = self.unit
		if (not unit) then
			return
		end
		local showPower = (UnitIsPlayer(unit) or not(min == 0 or max == 0))
		if (showPower == self.haspower) then 
			return 
		end 
		PostUpdateArtwork(self)
	end 


	-- CastBar
	-------------------------------------------------------------------
	local castBar = health:CreateStatusBar()
	castBar:Hide()
	castBar:SetAllPoints()
	castBar:SetStatusBarTexture(1, 1, 1, .15)
	castBar:SetSize(health:GetSize())
	castBar:DisableSmoothing(true)


	
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

	

	-- Threat
	-------------------------------------------------------------------
	local threat = self:CreateFrame()
	threat:SetFrameLevel(0)
	threat:SetAllPoints()
	threat:Hide()
	
	local threatNormal = threat:CreateTexture(nil, "BACKGROUND")
	threatNormal:Hide()
	threatNormal:SetSize(unpack(config.textures.size))
	threatNormal:SetPoint(unpack(config.textures.position))
	threatNormal:SetTexture(config.textures.layers.border.standard_single.threat)
	
	local threatNormalPower = threat:CreateTexture(nil, "BACKGROUND")
	threatNormalPower:Hide()
	threatNormalPower:SetSize(unpack(config.textures.size))
	threatNormalPower:SetPoint(unpack(config.textures.position))
	threatNormalPower:SetTexture(config.textures.layers.border.standard_double.threat)

	local threatBoss = threat:CreateTexture(nil, "BACKGROUND")
	threatBoss:Hide()
	threatBoss:SetSize(unpack(config.textures.size))
	threatBoss:SetPoint(unpack(config.textures.position))
	threatBoss:SetTexture(config.textures.layers.border.boss_single.threat)

	local threatBossPower = threat:CreateTexture(nil, "BACKGROUND")
	threatBossPower:Hide()
	threatBossPower:SetSize(unpack(config.textures.size))
	threatBossPower:SetPoint(unpack(config.textures.position))
	threatBossPower:SetTexture(config.textures.layers.border.boss_double.threat)


	-- Texts
	-------------------------------------------------------------------
	local name = border:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(config.name.font_object)
	name:SetPoint(unpack(config.name.position))
	name:SetSize(unpack(config.name.size))
	name:SetJustifyV("BOTTOM")
	name:SetJustifyH("CENTER")
	name:SetIndentedWordWrap(false)
	name:SetWordWrap(true)
	name:SetNonSpaceWrap(false)
	name.colorBoss = true
	
	local classification = border:CreateFontString(nil, "OVERLAY")
	classification:SetFontObject(config.classification.font_object)
	classification:SetPoint(unpack(config.classification.position.normal_single))
	classification.position = config.classification.position -- should contain all 4 positions

	local spellName = castBar:CreateFontString(nil, "OVERLAY")
	spellName:SetFontObject(config.classification.font_object)
	spellName:SetPoint("CENTER", classification, "CENTER", 0, 0) -- just piggyback on the classification positions

	local castTime = castBar:CreateFontString(nil, "OVERLAY")
	castTime:SetFontObject(config.texts.castTime.font_object)
	castTime:SetPoint(unpack(config.texts.castTime.position))

	castBar:HookScript("OnShow", function() 
		classification:Hide()
		spellName:Show() 
	end)

	castBar:HookScript("OnHide", function() 
		classification:Show()
		spellName:Hide() 
	end)

	
	-- Put everything into our layer cache
	-------------------------------------------------------------------
	self.layers = { 
		backdrop = {
			Backdrop = backdrop,
			BackdropPower = backdropPower
		}, 
		border = {
			BorderNormal = borderNormal,
			BorderNormalHighlight = borderNormalHighlight,
			BorderNormalPower = borderNormalPower,
			BorderNormalPowerHighlight = borderNormalPowerHighlight,
			BorderBoss = borderBoss,
			BorderBossHighlight = borderBossHighlight,
			BorderBossPower = borderBossPower,
			BorderBossPowerHighlight = borderBossPowerHighlight,
			BorderElite = borderElite,
			BorderEliteHighlight = borderEliteHighlight,
			BorderElitePower = borderElitePower,
			BorderElitePowerHighlight = borderElitePowerHighlight
		}, 
		threat = {
			ThreatNormal = threatNormal,
			ThreatNormalPower = threatNormalPower,
			ThreatBoss = threatBoss,
			ThreatBossPower = threatBossPower
		} 
	} 

	self.Auras = auras
	self.CastBar = castBar
	self.CastBar.Name = spellName
	self.CastBar.Value = castTime
	self.Classification = classification
	self.Classification.PostUpdate = PostUpdateClassification
	self.Health = health
	self.Name = name
	self.Power = power
	--self.Power.PostUpdate = function() Update(self) end
	self.Threat = threat
	self.Threat.SetVertexColor = function(_, ...) 
		for i,v in pairs(self.layers.threat) do
			v:SetVertexColor(...)
		end
	end

	self:HookScript("OnEnter", PostUpdateArtwork)
	self:HookScript("OnLeave", PostUpdateArtwork)

	self:HookScript("OnShow", PostUpdateFrame)

	self:RegisterEvent("PLAYER_ENTERING_WORLD", PostUpdateFrame)
	self:RegisterEvent("PLAYER_TARGET_CHANGED", PostUpdateFrame)
	self:RegisterEvent("UNIT_NAME_UPDATE", PostUpdateFrame)

end

UnitFrameWidget.OnEvent = function(self, event, ...)
	if (event == "PLAYER_TARGET_CHANGED") then
		if UnitExists("target") then
			if UnitIsEnemy("target", "player") then
				PlaySoundKitID(SOUNDKIT.IG_CREATURE_AGGRO_SELECT, "SFX")
			elseif UnitIsFriend("player", "target") then
				PlaySoundKitID(SOUNDKIT.IG_CHARACTER_NPC_SELECT, "SFX")
			else
				PlaySoundKitID(SOUNDKIT.IG_CREATURE_NEUTRAL_SELECT, "SFX")
			end
		else
			PlaySoundKitID(SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT, "SFX")
		end
	elseif (event == "PLAYER_ENTERING_WORLD") or (event == "VARIABLES_LOADED") or (event == "CVAR_UPDATE") then
		ENEMY_PLATES = GetCVarBool("nameplateShowEnemies")
	end
end

UnitFrameWidget.OnEnable = function(self)
	self.UnitFrame = UnitFrame:New("target", Engine:GetFrame(), Style)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnEvent")

	if ENGINE_LEGION then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
		self:RegisterEvent("CVAR_UPDATE", "OnEvent")
		self:RegisterEvent("VARIABLES_LOADED", "OnEvent")
	end
end

UnitFrameWidget.GetFrame = function(self)
	return self.UnitFrame
end
