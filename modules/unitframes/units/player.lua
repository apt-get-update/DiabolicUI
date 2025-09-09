local ADDON, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Player")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local unpack = unpack
local pairs = pairs
local tostring = tostring

-- WoW API
local CreateFrame = _G.CreateFrame
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitClass = _G.UnitClass
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType

-- WoW constants
local SPELL_POWER_MANA = _G.SPELL_POWER_MANA or Enum.PowerType.Mana

-- player class
local _,CLASS = UnitClass("player")

-- bar visibility constants
local HAS_VEHICLE_UI = false -- entering a value just to reserve the memory. semantics. 
local NUM_VISIBLE_BARS = 1 -- need a fallback here or the spawn will bug out


local postUpdateHealth = function(health, unit)

	if (health.useClassColor and UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		if (class and C.Orb[class]) then
			for i,v in pairs(C.Orb[class]) do
				health:SetStatusBarColor(v[1], v[2], v[3], v[4], v[5])
			end
		else
			r, g, b = unpack(C.Class[class] or C.Class.UNKNOWN)
			health:SetStatusBarColor(r, g, b, "ALL")
		end
	else
		for i,v in pairs(C.Orb.HEALTH) do
			health:SetStatusBarColor(v[1], v[2], v[3], v[4], v[5])
		end
	end

	local forced = health._owner.mouseIsOver
	local Value = health.Value
	local Label = health.Label

	local orbAlpha = (UnitAffectingCombat("player") or forced) and .9 or 0
	local labelAlpha = forced and .9 or 0

	if (orbAlpha == Value.alpha) and (labelAlpha == Label.alpha) then
		return
	end

	Value:SetAlpha(orbAlpha)
	Label:SetAlpha(labelAlpha)

	Value.alpha = orbAlpha
	Label.alpha = labelAlpha
end

local postUpdatePower = function(power)
	local owner = power._owner
	local unit = owner.unit

	-- Check if mana is the current resource or not, 
	-- and crop the primary power bar as needed to 
	-- give room for the secondary mana orb. 
	local powerID, powerType = UnitPowerType(unit)

	-- Only do any of this if the type has changed, 
	-- or if it's the first time calling this. 
	if (power.currentPowerType ~= powerType) then
		if (powerType == "MANA") then
			power:SetCrop(0, 0)
		else
			local manamax = UnitPowerMax(unit, SPELL_POWER_MANA)
			if manamax > 0 then
				power:SetCrop(0, power.crop)
			else
				power:SetCrop(0, 0)
			end
		end

		-- Update the label
		local label = power.Label
		--label:SetText(_G[powerType] or "")

		-- Store the powertype to avoid extra updates.
		-- Note that this isn't stored before this point
		-- to ensure that this is called at least once.
		power.currentPowerType = powerType
	end

	local forced = power._owner.mouseIsOver
	local Value = power.Value
	local Label = power.Label

	local orbAlpha = (UnitAffectingCombat("player") or forced) and .9 or 0
	local labelAlpha = forced and .9 or 0

	if (orbAlpha == Value.alpha) and (labelAlpha == Label.alpha) then
		return
	end

	Value:SetAlpha(orbAlpha)
	Label:SetAlpha(labelAlpha)

	Value.alpha = orbAlpha
	Label.alpha = labelAlpha
		
end

local maxPower = CLASS == "DEATHKNIGHT" and 6 or 5
local postUpdateClassPower = function(element, min, max, powerType, newMax)
	if (not newMax) or (not min) or (not max) or (max == 0) then
		return 
	end  
	if (max > maxPower) then 
		max = maxPower
	end 
	local config = Module:GetDB("UnitFrames").visuals.units.player
	element:SetSize(config.classpower.point.size[1]*max + config.classpower.point.padding*(max-1), config.classpower.point.size[2])
end 

local onEnterLeft = function(self)
	self.mouseIsOver = true

	local Value = self.Health.Value
	local Label = self.Health.Label

	local orbAlpha = .9
	local labelAlpha = .9

	if (orbAlpha == Value.alpha) and (labelAlpha == Label.alpha) then
		return
	end

	Value:SetAlpha(orbAlpha)
	Label:SetAlpha(labelAlpha)

	Value.alpha = orbAlpha
	Label.alpha = labelAlpha
		
end

local onEnterRight = function(self)
	self.mouseIsOver = true

	local Value = self.Power.Value
	local Label = self.Power.Label

	local orbAlpha = .9
	local labelAlpha = .9

	if (orbAlpha == Value.alpha) and (labelAlpha == Label.alpha) then
		return
	end

	Value:SetAlpha(orbAlpha)
	Label:SetAlpha(labelAlpha)

	Value.alpha = orbAlpha
	Label.alpha = labelAlpha
		
end

local onLeaveLeft = function(self)
	self.mouseIsOver = false

	local Value = self.Health.Value
	local Label = self.Health.Label

	local orbAlpha = UnitAffectingCombat("player") and .9 or 0
	local labelAlpha = 0

	if (orbAlpha == Value.alpha) and (labelAlpha == Label.alpha) then
		return
	end

	Value:SetAlpha(orbAlpha)
	Label:SetAlpha(labelAlpha)

	Value.alpha = orbAlpha
	Label.alpha = labelAlpha
	
end

local onLeaveRight = function(self)
	self.mouseIsOver = false

	local Value = self.Power.Value
	local Label = self.Power.Label

	local orbAlpha = UnitAffectingCombat("player") and .9 or 0
	local labelAlpha = 0

	if (orbAlpha == Value.alpha) and (labelAlpha == Label.alpha) then
		return
	end

	Value:SetAlpha(orbAlpha)
	Label:SetAlpha(labelAlpha)

	Value.alpha = orbAlpha
	Label.alpha = labelAlpha
	
end

local postCreateAuraButton = function(self, button)
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

local postUpdateAuraButton = function(self, button, ...)
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

local MINUTE = 60
local HOUR = 3600
local DAY = 86400

-- Time limit where we separate between short and long buffs
local TIME_LIMIT = Engine:GetConstant("AURA_TIME_LIMIT")
local TIME_LIMIT_LOW = Engine:GetConstant("AURA_TIME_LIMIT_LOW")

-- Move to the general aura lists later
local whiteList = {
	-- Player debuffs of importance 
	[57723] 	= true, 	-- Exhaustion "Cannot benefit from Heroism or other similar effects." (Alliance version)
	[57724] 	= true, 	-- Sated "Cannot benefit from Bloodlust or other similar effects." (Horde version)
	[160455]	= true, 	-- Fatigued "Cannot benefit from Netherwinds or other similar effects." (Pet version)
	[95809] 	= true, 	-- Insanity "Cannot benefit from Ancient Hysteria or other similar effects." (Pet version)

	[15007] 	= true, 	-- Resurrection Sickness
	[19752]		= true 		-- Divine Intervention

}


-- Combat relevant buffs
local shortBuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	if duration and (duration > 0) then
		-- Don't list buffs with a long duration here
		if duration > TIME_LIMIT then
			return false
		end
		return true
	end
end

-- Combat relevant debuffs
local shortDebuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	if whiteList[spellId] then
		return true
	end
	if duration and (duration > 0) then
		--if UnitAffectingCombat("player") and (duration > TIME_LIMIT) then
			--return false
		--end
		return true
	elseif (count and count > 0) then -- Decomposing Aura
		return true
	end
end

-- Buffs with a remaining duration of 5 minutes or more, and static auras with no duration
local longBuffFilter = function(self, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
	if duration and (duration > 0) then
		if duration > TIME_LIMIT then
			return true
		end
		return false
	elseif (not duration) or (duration == 0) then
		--if isCastByPlayer then
		--	return false
		--end
		return true
	end
end

-- Custom Combo Point Template
------------------------------------------------------------------
-- Doing it this way since neither the blizz bars, our bars, 
-- or any textures as they are will do for our purpose.

local Point = Engine:CreateFrame("Frame")
local Point_MT = { __index = Point }

local CreatePoint = function(parent)
	local point = setmetatable(parent:CreateFrame("Frame"), Point_MT)

	point.__bg = point:CreateTexture()
	point.__bg:SetDrawLayer("BACKGROUND")
	point.__bg:SetAllPoints()

	point.__bar = point:CreateTexture()
	point.__bar:SetDrawLayer("BORDER")
	point.__bar:SetPoint("TOP", 0, 0)
	point.__bar:SetPoint("BOTTOM", 0, 0)
	point.__bar:SetPoint("LEFT", 0, 0)
	point.__bar:SetPoint("RIGHT", 0, 0)

	point.__glow = point:CreateTexture()
	point.__glow:SetDrawLayer("ARTWORK")
	point.__glow:SetAllPoints(point.__bar)

	point.__currentValue = 0
	point.__minValue = 0
	point.__maxValue = 1
	point.__statusbarTexture = nil
	point.__backgroundTexture = nil
	point.__glowTexture = nil
	point.__statusbarTexCoord = { 0, 1, 0, 1 }
	point.__backgroundTexCoord = { 0, 1, 0, 1 }
	point.__glowTexCoord = { 0, 1, 0, 1 }

	hooksecurefunc(point, "Hide", function() point.__glow:Hide() end)
	hooksecurefunc(point, "Show", function() point.__glow:Show() end)

	return point
end 

Point.Update = function(self)
	local bg = self.__bg
	local bar = self.__bar
	local glow = self.__glow
	local min = self.__minValue or 0
	local max = self.__maxValue or 1
	local cur = self.__currentValue or 0
	local left, right, top, bottom = unpack(self.__statusbarTexCoord)
	local leftGlow, rightGlow, topGlow, bottomGlow = unpack(self.__glowTexCoord)
	local percent = (cur-min)/(max-min)
	if percent > 1 then percent = 1 end 
	if percent < 0 then percent = 0 end 
	bar:SetPoint("TOP", 0, -(self:GetHeight() * (1-percent)))
	bar:SetTexCoord(left, right, top + (bottom-top)*(1-percent), bottom)
	glow:SetTexCoord(leftGlow, rightGlow, topGlow + (bottomGlow-topGlow)*(1-percent), bottomGlow)
end 

Point.SetValue = function(self, value)
	self.__currentValue = value
	self:Update()
end 

Point.GetValue = function(self)
	return self.__currentValue
end 

Point.SetMinMaxValues = function(self, min, max)
	self.__minValue = min
	self.__maxValue = max
	self:Update()
end 

Point.GetMinMaxValues = function(self)
	return self.__minValue, self.__maxValue
end 

Point.IsObjectType = function(_, objectType)
	return objectType == "StatusBar"
end 

Point.GetObjectType = function()
	return "StatusBar"
end 

Point.SetStatusBarTexture = function(self, path)
	self.__bar:SetTexture(path)
end 

Point.SetBackgroundTexture = function(self, path)
	self.__bg:SetTexture(path)
end 

Point.SetGlowTexture = function(self, path)
	self.__glow:SetTexture(path)
end 

Point.SetStatusBarTexCoord = function(self, left, right, top, bottom)
	self.__statusbarTexCoord = { left, right, top, bottom }
end 

Point.SetBackgroundTexCoord = function(self, left, right, top, bottom)
	self.__bg:SetTexCoord(left, right, top, bottom)
end 

Point.SetGlowTexCoord = function(self, left, right, top, bottom)
	self.__glowTexCoord = { left, right, top, bottom }
end 

Point.SetGlowBlendMode = function(self, blendMode)
	self.__glow:SetBlendMode(blendMode)
end 

Point.SetStatusBarColor = function(self, r, g, b, a)
	self.__bar:SetVertexColor(r, g, b, a)
	self.__bg:SetVertexColor(r*1/4, g*1/4, b*1/4, .85 * a)
	self.__glow:SetVertexColor(r, g, b, .75 * a)
end 


-- Left orb (health, castbar, actionbar auras)	
local StyleLeftOrb = function(self, unit, index, numBars, inVehicle)
	local config = Module:GetDB("UnitFrames").visuals.units.player
	local db = Module:GetConfig("UnitFrames") 

	local configHealth = config.left.health
	local configHealthSpark = config.left.health.spark
	local configHealthLayers = config.left.health.layers
	local configHealthTexts = config.texts.health

	self:Size(unpack(config.left.size))
	self:Place(unpack(config.left.position))

	local Pet = Engine:GetModule("ActionBars"):GetWidget("Bar: Pet"):GetFrame()
	local hasPet = Pet:IsShown()


	-- Health
	-------------------------------------------------------------------
	local Health = self:CreateOrb()
	Health:SetSize(unpack(configHealth.size))
	Health:SetPoint(unpack(configHealth.position))
	Health:SetStatusBarTexture(configHealthLayers.gradient.texture, "bar")
	Health:SetStatusBarTexture(configHealthLayers.moon.texture, "moon")
	Health:SetStatusBarTexture(configHealthLayers.smoke.texture, "smoke")
	Health:SetStatusBarTexture(configHealthLayers.shade.texture, "shade")
	Health:SetSparkTexture(configHealthSpark.texture)
	Health:SetSparkSize(unpack(configHealthSpark.size))
	Health:SetSparkOverflow(configHealthSpark.overflow)
	--Health:SetSparkFlash(unpack(configHealthSpark.flash))
	Health:SetSparkFlashSize(unpack(configHealthSpark.flash_size))
	Health:SetSparkFlashTexture(configHealthSpark.flash_texture)

	Health.useClassColor = false -- make this a user option later on
	Health.frequent = 1/120

	Health.Value = Health:GetOverlay():CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(configHealthTexts.font_object)
	Health.Value:SetPoint(unpack(configHealthTexts.position))

	Health.Label = Health:GetOverlay():CreateFontString(nil, "OVERLAY")
	Health.Label:SetFontObject(configHealthTexts.font_object)
	Health.Label:SetPoint("BOTTOM", Health.Value, "TOP", 0, 2)
	Health.Label:SetText("")

	Health.Value.showPercent = false
	Health.Value.showDeficit = false
	Health.Value.showMaximum = true
	Health.Value.showAtZero = true

	Health.PostUpdate = postUpdateHealth
	

	
	-- CastBar
	-------------------------------------------------------------------
	if (not Engine:IsAddOnEnabled("Quartz")) and (not Engine:IsAddOnEnabled("Castbars")) then
		local CastBar = self:CreateStatusBar()
		CastBar:Hide()
		CastBar:SetSize(unpack(config.castbar.size))
		CastBar:SetStatusBarTexture(config.castbar.texture)
		CastBar:SetStatusBarColor(unpack(config.castbar.color))
		CastBar:SetSparkTexture(config.castbar.spark.texture)
		CastBar:SetSparkSize(unpack(config.castbar.spark.size))
		CastBar:SetSparkFlash(unpack(config.castbar.spark.flash))
		CastBar:DisableSmoothing(true)
		CastBar:Place(unpack(hasPet and config.castbar.positionPet or config.castbar.position))
		
		CastBar.Backdrop = CastBar:CreateTexture(nil, "BACKGROUND")
		CastBar.Backdrop:SetSize(unpack(config.castbar.backdrop.size))
		CastBar.Backdrop:SetPoint(unpack(config.castbar.backdrop.position))
		CastBar.Backdrop:SetTexture(config.castbar.backdrop.texture)

		CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
		CastBar.SafeZone:SetPoint("RIGHT")
		CastBar.SafeZone:SetPoint("TOP")
		CastBar.SafeZone:SetPoint("BOTTOM")
		CastBar.SafeZone:SetTexture(.7, 0, 0, .25)
		CastBar.SafeZone:SetWidth(0.0001)
		CastBar.SafeZone:Hide()

		CastBar.Name = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Name:SetFontObject(config.castbar.name.font_object)
		CastBar.Name:SetPoint(unpack(config.castbar.name.position))
		CastBar.Name.Shade = CastBar:CreateTexture(nil, "BACKGROUND")
		CastBar.Name.Shade:SetPoint("CENTER", CastBar.Name, "CENTER", 0, 4)
		CastBar.Name.Shade:SetTexture(config.castbar.shade.texture)
		CastBar.Name.Shade:SetVertexColor(0, 0, 0)
		CastBar.Name.Shade:SetAlpha(1/3)

		CastBar.Overlay = CastBar:CreateFrame()
		CastBar.Overlay:SetAllPoints()

		CastBar.Border = CastBar.Overlay:CreateTexture(nil, "BORDER")
		CastBar.Border:SetSize(unpack(config.castbar.border.size))
		CastBar.Border:SetPoint(unpack(config.castbar.border.position))
		CastBar.Border:SetTexture(config.castbar.border.texture)

		CastBar.Value = CastBar.Overlay:CreateFontString(nil, "OVERLAY")
		CastBar.Value:SetFontObject(config.castbar.value.font_object)
		CastBar.Value:SetPoint(unpack(config.castbar.value.position))
		CastBar.Value.Shade = CastBar:CreateTexture(nil, "BACKGROUND")
		CastBar.Value.Shade:SetPoint("CENTER", CastBar.Value, "CENTER", 0, 4)
		CastBar.Value.Shade:SetTexture(config.castbar.shade.texture)
		CastBar.Value.Shade:SetVertexColor(0, 0, 0)
		CastBar.Value.Shade:SetAlpha(1/3)

		hooksecurefunc(CastBar.Name, "SetText", function(self) self.Shade:SetSize(self:GetStringWidth() + 128, self:GetStringHeight() + 48) end)

		self.CastBar = CastBar
	end


	-- Class Resource
	-------------------------------------------------------------------
	if Engine:IsBuild("Legion") and false then -- just disable until I get the element build 
		local ClassPower = self:CreateFrame()
		ClassPower:SetSize(config.classpower.point.size[1]*maxPower + config.classpower.point.padding*(maxPower-1), config.classpower.point.size[2])
		ClassPower:Place(unpack(config.classpower.position))
		ClassPower.PostUpdate = postUpdateClassPower
		for i = 1,maxPower do
			local point = CreatePoint(ClassPower)
			if i == 1 then 
				point:SetPoint("LEFT", 0, 0)
			else 
				point:SetPoint("LEFT", ClassPower[i-1], "RIGHT", config.classpower.point.padding, 0)
			end 
			point:SetSize(unpack(config.classpower.point.size))
			point:SetStatusBarTexture(config.classpower.point.texture)
			point:SetBackgroundTexture(config.classpower.point.texture)
			point:SetGlowTexture(config.classpower.point.texture)
			point:SetStatusBarTexCoord((i-1)*128/1024, i*128/1024, 128/512, 256/512)
			point:SetBackgroundTexCoord((i-1)*128/1024, i*128/1024, 0/512, 128/512)
			point:SetGlowTexCoord((i-1)*128/1024, i*128/1024,256/512, 384/512)
			point:SetGlowBlendMode("ADD")

			ClassPower[i] = point
		end 
		self.ClassPower = ClassPower
	end 


	-- Buffs (combat)
	-------------------------------------------------------------------
	local Buffs = self:CreateFrame()
	Buffs:SetSize(unpack(config.buffs.size[HAS_VEHICLE_UI and "vehicle" or tostring(NUM_VISIBLE_BARS)])) 
	Buffs:Place(unpack(hasPet and config.buffs.positionPet or config.buffs.position))

	Buffs.config = config.buffs
	Buffs.buttonConfig = config.buffs.button
	Buffs.auraSize = config.buffs.button.size
	Buffs.spacingH = config.buffs.spacingH
	Buffs.spacingV = config.buffs.spacingV
	Buffs.growthX = "RIGHT"
	Buffs.growthY = "UP"
	Buffs.filter = "HELPFUL"
	Buffs.sortByTime = true
	Buffs.sortByDuration = true
	Buffs.sortByName = true
	Buffs.hideTimerBar = true
	Buffs.hideCooldownSpiral = true

	Buffs.BuffFilter = shortBuffFilter
	Buffs.PostCreateButton = postCreateAuraButton
	Buffs.PostUpdateButton = postUpdateAuraButton


	-- Debuffs
	-------------------------------------------------------------------
	local Debuffs = self:CreateFrame()
	Debuffs:SetSize(unpack(config.debuffs.size[HAS_VEHICLE_UI and "vehicle" or tostring(NUM_VISIBLE_BARS)]))  
	Debuffs:Place(unpack(hasPet and config.debuffs.positionPet or config.debuffs.position))

	Debuffs.config = config.debuffs
	Debuffs.buttonConfig = config.debuffs.button
	Debuffs.auraSize = config.debuffs.button.size
	Debuffs.spacingH = config.debuffs.spacingH
	Debuffs.spacingV = config.debuffs.spacingV
	Debuffs.growthX = "LEFT"
	Debuffs.growthY = "UP"
	Debuffs.filter = "HARMFUL"
	Debuffs.sortByTime = true
	Debuffs.sortByDuration = true
	Debuffs.sortByName = true
	Debuffs.hideTimerBar = true
	Debuffs.hideCooldownSpiral = true

	Debuffs.DebuffFilter = shortDebuffFilter
	Debuffs.PostCreateButton = postCreateAuraButton
	Debuffs.PostUpdateButton = postUpdateAuraButton

	self:HookScript("OnEnter", onEnterLeft)
	self:HookScript("OnLeave", onLeaveLeft)

	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.Health = Health
	
end

-- Right orb (power, minimap auras)
local StyleRightOrb = function(self, unit, index, numBars, inVehicle)
	local config = Module:GetDB("UnitFrames").visuals.units.player
	local db = Module:GetConfig("UnitFrames") 

	local configPower = config.right.power
	local configPowerSpark = config.right.power.spark
	local configPowerLayers = config.right.power.layers
	local configPowerTexts = config.texts.power
	
	self:Size(unpack(config.right.size))
	self:Place(unpack(config.right.position))


	-- Power
	-------------------------------------------------------------------

	local Power = self:CreateOrb(true) -- reverse the rotation
	Power:SetSize(unpack(configPower.size))
	Power:SetPoint(unpack(configPower.position))
	Power:SetCrop(0, 0)
	Power.crop = configPower.size[1]/2

	Power:SetStatusBarTexture(configPowerLayers.gradient.texture, "bar")
	Power:SetStatusBarTexture(configPowerLayers.moon.texture, "moon")
	Power:SetStatusBarTexture(configPowerLayers.smoke.texture, "smoke")
	Power:SetStatusBarTexture(configPowerLayers.shade.texture, "shade")

	Power:SetSparkTexture(configPowerSpark.texture)
	Power:SetSparkSize(unpack(configPowerSpark.size))
	Power:SetSparkOverflow(configPowerSpark.overflow)
	--Power:SetSparkFlash(unpack(configPowerSpark.flash))
	Power:SetSparkFlashSize(unpack(configPowerSpark.flash_size))
	Power:SetSparkFlashTexture(configPowerSpark.flash_texture)

	Power.Value = Power:GetOverlay():CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(configPowerTexts.font_object)
	Power.Value:SetPoint(unpack(configPowerTexts.position))
	Power.Value.showPercent = false
	Power.Value.showDeficit = false
	Power.Value.showMaximum = true
	Power.Value.showAtZero = true

	Power.Label = Power:GetOverlay():CreateFontString(nil, "OVERLAY")
	Power.Label:SetFontObject(configPowerTexts.font_object)
	Power.Label:SetPoint("BOTTOM", Power.Value, "TOP", 0, 2)
	Power.Label:SetText("")
	
	Power.frequent = 1/120
	Power.PostUpdate = postUpdatePower

	-- Adding a mana only power resource for classes or specs with mana as the secondary resource.
	-- This is compatible with all current and future classes and specs that function this way, 
	-- since the only thing this element does is to show mana if the player has mana but 
	-- mana isn't the currently displayed resource. 
	local Mana = self:CreateOrb()
	Mana:Hide()
	Mana:SetCrop(configPower.size[1]/2, 0)
	Mana:SetSize(unpack(configPower.size))
	Mana:SetPoint(unpack(configPower.position))

	Mana:SetStatusBarTexture(configPowerLayers.gradient.texture, "bar")
	Mana:SetStatusBarTexture(configPowerLayers.moon.texture, "moon")
	Mana:SetStatusBarTexture(configPowerLayers.smoke.texture, "smoke")
	Mana:SetStatusBarTexture(configPowerLayers.shade.texture, "shade")

	Mana:SetSparkTexture(configPowerSpark.texture)
	Mana:SetSparkSize(unpack(configPowerSpark.size))
	Mana:SetSparkOverflow(configPowerSpark.overflow)
	--Mana:SetSparkFlash(unpack(configPowerSpark.flash))
	Mana:SetSparkFlashSize(unpack(configPowerSpark.flash_size))
	Mana:SetSparkFlashTexture(configPowerSpark.flash_texture)

	Mana.frequent = 1/120

	-- We need a holder frame to get the orb split above the globe artwork
	local SeparatorHolder = Mana:CreateFrame()
	SeparatorHolder:SetAllPoints()
	SeparatorHolder:SetFrameStrata("MEDIUM")
	SeparatorHolder:SetFrameLevel(10)

	local Separator = SeparatorHolder:CreateTexture(nil, "ARTWORK")
	Separator:SetSize(unpack(configPower.separator.size))
	Separator:SetPoint(unpack(configPower.separator.position))
	Separator:SetTexture(configPower.separator.texture)

	-- Player Alternate Power Bar
	-------------------------------------------------------------------
	if Engine:IsBuild("BfA") then 
		local AltPower = self:CreateStatusBar()
		AltPower:Hide()
		AltPower:SetSize(unpack(config.altpower.size))
		AltPower:SetStatusBarTexture(config.altpower.texture)
		AltPower:SetStatusBarColor(unpack(config.altpower.color))
		AltPower:SetSparkTexture(config.altpower.spark.texture)
		AltPower:SetSparkSize(unpack(config.altpower.spark.size))
		AltPower:SetSparkFlash(unpack(config.altpower.spark.flash))
		AltPower:DisableSmoothing(true)
		AltPower:Place(unpack(hasPet and config.altpower.positionPet or config.altpower.position))
		
		AltPower.Backdrop = AltPower:CreateTexture(nil, "BACKGROUND")
		AltPower.Backdrop:SetSize(unpack(config.altpower.backdrop.size))
		AltPower.Backdrop:SetPoint(unpack(config.altpower.backdrop.position))
		AltPower.Backdrop:SetTexture(config.altpower.backdrop.texture)

		AltPower.Overlay = AltPower:CreateFrame()
		AltPower.Overlay:SetAllPoints()

		AltPower.Border = AltPower.Overlay:CreateTexture(nil, "BORDER")
		AltPower.Border:SetSize(unpack(config.altpower.border.size))
		AltPower.Border:SetPoint(unpack(config.altpower.border.position))
		AltPower.Border:SetTexture(config.altpower.border.texture)

		AltPower.Value = AltPower.Overlay:CreateFontString(nil, "OVERLAY")
		AltPower.Value:SetFontObject(config.altpower.value.font_object)
		AltPower.Value:SetPoint(unpack(config.altpower.value.position))
		AltPower.Value.Shade = AltPower:CreateTexture(nil, "BACKGROUND")
		AltPower.Value.Shade:SetPoint("CENTER", AltPower.Value, "CENTER", 0, 4)
		AltPower.Value.Shade:SetTexture(config.altpower.shade.texture)
		AltPower.Value.Shade:SetVertexColor(0, 0, 0)
		AltPower.Value.Shade:SetAlpha(1/3)

		self.AltPower = AltPower
	end

	-- Buffs (no duration)
	-------------------------------------------------------------------
	local Buffs = self:CreateFrame()
	Buffs:SetSize(config.auras.size[1], config.auras.size[2]) 
	Buffs:Place(unpack(config.auras.position)) -- Minimap is always visible on /reload

	Buffs.position = config.auras.position
	Buffs.positionWithoutMinimap = config.auras.positionWithoutMinimap
	Buffs.config = config.auras
	Buffs.buttonConfig = config.auras.button
	Buffs.auraSize = config.auras.button.size
	Buffs.spacingH = config.auras.spacingH
	Buffs.spacingV = config.auras.spacingV
	Buffs.growthX = "LEFT"
	Buffs.growthY = "DOWN"
	Buffs.filter = "HELPFUL"
	Buffs.sortByTime = true
	Buffs.sortByDuration = true
	Buffs.sortByName = true
	Buffs.hideTimerBar = true
	Buffs.hideCooldownSpiral = true -- looks slightly weird on long term buffs

	Buffs.BuffFilter = longBuffFilter
	Buffs.PostCreateButton = postCreateAuraButton
	Buffs.PostUpdateButton = postUpdateAuraButton

	self:HookScript("OnEnter", onEnterRight)
	self:HookScript("OnLeave", onLeaveRight)

	self.Buffs = Buffs
	self.Power = Power
	self.Mana = Mana
	
end

UnitFrameWidget.OnEvent = function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		-- set our constants for number of visible bars and vehicleUI
		local hasVehicleUI = self.ActionBarController:InVehicle() or false
		local numVisibleBars = self.ActionBarController:GetNumBars() or 1 -- fallback value

		if hasVehicleUI then
			self.Left.Buffs:SetSize(unpack(self.config.buffs.size["vehicle"]))
			self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size["vehicle"]))
		else
			self.Left.Buffs:SetSize(unpack(self.config.buffs.size[tostring(numVisibleBars)]))
			self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size[tostring(numVisibleBars)]))
		end	

		NUM_VISIBLE_BARS = numVisibleBars
		HAS_VEHICLE_UI = hasVehicleUI

		self.Left.Buffs:ForceUpdate("Buffs")

	elseif event == "ENGINE_ACTIONBAR_VEHICLE_CHANGED" then
		local hasVehicleUI = ...
		if hasVehicleUI ~= HAS_VEHICLE_UI then
			if hasVehicleUI then
				self.Left.Buffs:SetSize(unpack(self.config.buffs.size["vehicle"]))
				self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size["vehicle"]))
			else
				self.Left.Buffs:SetSize(unpack(self.config.buffs.size[tostring(NUM_VISIBLE_BARS)]))
				self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size[tostring(NUM_VISIBLE_BARS)]))
			end
			self.Left.Buffs:ForceUpdate("Buffs")
			HAS_VEHICLE_UI = hasVehicleUI
		end 

	elseif event == "ENGINE_ACTIONBAR_VISIBLE_CHANGED" then
		local numVisibleBars = ...
		if numVisibleBars ~= NUM_VISIBLE_BARS then
			if hasVehicleUI then
				self.Left.Buffs:SetSize(unpack(self.config.buffs.size["vehicle"]))
				self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size["vehicle"]))
			else
				self.Left.Buffs:SetSize(unpack(self.config.buffs.size[tostring(numVisibleBars)]))
				self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size[tostring(numVisibleBars)]))
			end
			self.Left.Buffs:ForceUpdate("Buffs")
			NUM_VISIBLE_BARS = numVisibleBars
		end

	elseif event == "ENGINE_ACTIONBAR_PET_CHANGED" then
		local isPetBarVisible = ...
		if isPetBarVisible then 
			--self.Right.AltPower:Place(unpack(self.config.altpower.positionPet))
			self.Left.CastBar:Place(unpack(self.config.castbar.positionPet))
			self.Left.Buffs:Place(unpack(self.config.buffs.positionPet))
			self.Left.Debuffs:Place(unpack(self.config.debuffs.positionPet))
		else
			--self.Right.AltPower:Place(unpack(self.config.altpower.position))
			self.Left.CastBar:Place(unpack(self.config.castbar.position))
			self.Left.Buffs:Place(unpack(self.config.buffs.position))
			self.Left.Debuffs:Place(unpack(self.config.debuffs.position))
		end
	
	elseif event == "ENGINE_MINIMAP_VISIBLE_CHANGED" then
		local isMinimapVisible = ...
		if isMinimapVisible then
			self.Right.Buffs:Place(unpack(self.config.auras.position))
		else
			self.Right.Buffs:Place(unpack(self.config.auras.positionWithoutMinimap))
		end
	end
end

UnitFrameWidget.OnEnable = function(self)
	self.config = self:GetDB("UnitFrames").visuals.units.player
	self.db = self:GetConfig("UnitFrames") 

	-- get the main actionbar controller, as we need some info from it
	self.ActionBarController = Engine:GetModule("ActionBars"):GetWidget("Controller: Main"):GetFrame()
	self.IsMinimapVisible = Engine:GetModule("Minimap").IsMinimapVisible

	-- set our constants for number of visible bars and vehicleUI
	NUM_VISIBLE_BARS = self.ActionBarController:GetNumBars() or 1 -- fallback value
	HAS_VEHICLE_UI = self.ActionBarController:InVehicle() or false

	-- spawn the orbs
	local UnitFrame = Engine:GetHandler("UnitFrame")
	self.Left = UnitFrame:New("player", "UICenter", StyleLeftOrb) -- health / main
	self.Right = UnitFrame:New("player", "UICenter", StyleRightOrb) -- power / mana in forms

	-- check for correct numbers in all clients!
	local BlizzardUI = self:GetHandler("BlizzardUI")
	if Engine:IsBuild("WotLK") then
		BlizzardUI:GetElement("Menu_Panel"):Remove(11, "InterfaceOptionsBuffsPanel")
	end

	-- Disable Blizzard's castbars for player 
	BlizzardUI:GetElement("Auras"):Disable()
	BlizzardUI:GetElement("CastBars"):Remove("player")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterMessage("ENGINE_ACTIONBAR_VEHICLE_CHANGED", "OnEvent")
	self:RegisterMessage("ENGINE_ACTIONBAR_VISIBLE_CHANGED", "OnEvent")
	self:RegisterMessage("ENGINE_MINIMAP_VISIBLE_CHANGED", "OnEvent")
	self:RegisterMessage("ENGINE_ACTIONBAR_PET_CHANGED", "OnEvent")
	

	--[[
	local box = UIParent:CreateTexture(nil, "OVERLAY")
	box:SetSize(400, 300)
	box:SetPoint("BOTTOMRIGHT", -20, 100)
	box:SetColorTexture(1, 1, 1, .5)
	box:Hide()

	local frame = CreateFrame("Frame")
	frame.elapsed = 0
	frame.HZ = 1/120
	frame:SetScript("OnUpdate", function(self, elapsed) 
		self.elapsed = self.elapsed + elapsed
		if self.elapsed > self.HZ then
			local mouseover = UnitExists("mouseover")
			if mouseover and UnitIsPlayer("mouseover") then
				local _, class = UnitClass("mouseover")
				if class then
					local r, g, b = unpack(C.Class[class])
					box:SetVertexColor(r, g, b)
				else
					box:SetVertexColor(0, 0, 0)
				end
				if not box:IsShown() then
					box:Show()
				end
			else
				if box:IsShown() then
					box:Hide()
				end
			end
			self.elapsed = 0
		end
	end)]]
end

UnitFrameWidget.GetFrame = function(self)
	return self.Left, self.Right
end

