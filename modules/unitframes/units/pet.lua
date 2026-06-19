local Addon, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Pet")

local UnitFrame = Engine:GetHandler("UnitFrame")
local StatusBar = Engine:GetHandler("StatusBar")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local tostring = tostring
local unpack, pairs = unpack, pairs
local tinsert, tconcat = table.insert, table.concat

-- WoW API
local CreateFrame = _G.CreateFrame
local UnitClass = _G.UnitClass
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitReaction = _G.UnitReaction

local _, playerClass = UnitClass("player")
local postUpdateHealth = function(health, unit)
	if (health.useClassColor and UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		if (class and C.Orb[class]) then
			for i,v in pairs(C.Orb[class]) do
				health:SetStatusBarColor(v[1] * .75, v[2] * .75, v[3] * .75, v[4], v[5])
			end
		else
			r, g, b = unpack(C.Class[class] or C.Class.UNKNOWN)
			health:SetStatusBarColor(r, g, b, "ALL")
		end
	elseif (health.useClassColorPet and UnitIsUnit("pet", unit)) then 
		if (C.Orb[playerClass]) then
			for i,v in pairs(C.Orb[playerClass]) do
				health:SetStatusBarColor(v[1] * .5, v[2] * .5, v[3] * .5, v[4], v[5])
			end
		else
			r, g, b = unpack(C.Class[playerClass] or C.Class.UNKNOWN)
			health:SetStatusBarColor(r, g, b, "ALL")
		end
	else 
		for i,v in pairs(C.Orb.HEALTH) do
			health:SetStatusBarColor(v[1], v[2], v[3], v[4], v[5])
		end
	end 
end


--local UpdateLayers = function(self)
--	if self:IsMouseOver() then
--		self.BorderNormalHighlight:Show()
--		self.BorderNormal:Hide()
--	else
--		self.BorderNormal:Show()
--		self.BorderNormalHighlight:Hide()
--	end
--end

local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.pet
	local db = Module:GetConfig("UnitFrames") 

	local configHealth = config.health
	local configHealthSpark = config.health.spark
	local configHealthLayers = config.health.layers

	self:Size(unpack(config.size))
	self:Place(unpack(config.position))


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
	Health:SetSparkFlashSize(unpack(configHealthSpark.flash_size))
	Health:SetSparkFlashTexture(configHealthSpark.flash_texture)

	Health.useClassColor = true 
	Health.useClassColorPet = true 
	Health.frequent = 1/120

	Health.PostUpdate = postUpdateHealth


	-- Artwork
	-------------------------------------------------------------------
	local Shade = Health:CreateTexture()
	Shade:SetDrawLayer("BACKGROUND")
	Shade:SetSize(unpack(configHealth.shade.size))
	Shade:SetPoint(unpack(configHealth.shade.position))
	Shade:SetTexture(configHealth.shade.texture)
	Shade:SetVertexColor(unpack(configHealth.shade.color))

	local Overlay = self:CreateFrame("Frame")
	Overlay:SetAllPoints()
	Overlay:SetFrameLevel(self:GetFrameLevel() + 5)

	local OverlayTexture = Overlay:CreateTexture()
	OverlayTexture:SetDrawLayer("OVERLAY")
	OverlayTexture:SetSize(unpack(configHealth.overlay.size))
	OverlayTexture:SetPoint(unpack(configHealth.overlay.position))
	OverlayTexture:SetTexture(configHealth.overlay.texture)
	OverlayTexture:SetVertexColor(unpack(configHealth.overlay.color))


	-- Threat
	-------------------------------------------------------------------
	--local Threat = {}
	
	--[[
	Threat.Border = self:CreateTexture(nil, "BACKGROUND")
	Threat.Border:Hide()
	Threat.Border:SetSize(unpack(config.border.texture_size))
	Threat.Border:SetPoint(unpack(config.border.texture_position))
	Threat.Border:SetTexture(config.border.textures.threat)

	Threat.Hide = function(self)
		self.Border:Hide()
	end

	Threat.Show = function(self)
		self.Border:Show()
	end
	
	Threat.SetVertexColor = function(self, ...)
		self.Border:SetVertexColor(...)
	end]]

	self.Health = Health
	--self.Threat = Threat

	--self.BorderNormal = BorderNormal
	--self.BorderNormalHighlight = BorderNormalHighlight

	--self:HookScript("OnEnter", UpdateLayers)
	--self:HookScript("OnLeave", UpdateLayers)
	
	-- self:SetAttribute("toggleForVehicle", true)

end

UnitFrameWidget.OnEnable = function(self)
	local config = self:GetDB("UnitFrames").visuals.units.pet
	local db = self:GetConfig("UnitFrames") 

	self.UnitFrame = UnitFrame:New("pet", Engine:GetFrame(), Style) 
	self.UnitFrame:SetFrameStrata("MEDIUM") -- get it above player orbs
	self.UnitFrame:SetFrameLevel(25) -- get it above player orbs

	-- Disable Blizzard's castbars for pet 
	self:GetHandler("BlizzardUI"):GetElement("CastBars"):Remove("pet")
end

UnitFrameWidget.GetFrame = function(self)
	return self.UnitFrame
end
