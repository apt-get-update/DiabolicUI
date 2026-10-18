-- "Unit: Pet" widget: the pet frame. Also registered as the "PetFrame" anchor
-- keyword for other modules.
local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Pet")

local UnitFrame = Engine:GetHandler("UnitFrame")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local ipairs, unpack = ipairs, unpack

-- WoW API
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer

local _, playerClass = UnitClass("player")
-- Health: in a vehicle the player is the pet unit, in its class colors a
-- shade darker; the pet itself can take the player's class colors, darker
-- still; otherwise it's blood red.
local postUpdateHealth = function(health, unit)
	local colors, shade
	if (health.useClassColor and UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		colors, shade = C.Orb[class], .75
	elseif (health.useClassColorPet and UnitIsUnit("pet", unit)) then
		colors, shade = C.Orb[playerClass], .5
	end
	if (not colors) then
		colors, shade = C.Orb.HEALTH, 1
	end
	for _, layer in ipairs(colors) do
		health:SetStatusBarColor(layer[1] * shade, layer[2] * shade, layer[3] * shade, layer[4], layer[5])
	end
end


local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.pet
	local db = Module:GetConfig("UnitFrames") 

	local configHealth = config.health
	local configHealthSpark = config.health.spark
	local configHealthLayers = config.health.layers

	self:SetSize(unpack(config.size))
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
	Health:SetSparkFlashSize(unpack(configHealthSpark.flash_size))
	Health:SetSparkFlashTexture(configHealthSpark.flash_texture)

	Health.useClassColor = db.showClassColors
	Health.useClassColorPet = db.showClassColors
	Health.frequent = 1/30

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
	
	self.Health = Health

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
