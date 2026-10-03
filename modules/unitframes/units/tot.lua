-- "Unit: ToT" widget: the target of target frame.
local _, Engine = ...

local Module = Engine:GetModule("UnitFrames")
local UnitFrame = Engine:GetHandler("UnitFrame")
local StatusBar = Engine:GetHandler("StatusBar")
local Library = Engine:GetDB("Library: UnitFrames")

local UnitFrameWidget = Module:SetWidget("Unit: ToT")

-- Lua API
local unpack = unpack

local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.tot
	local db = Module:GetConfig("UnitFrames") 

	
	self:SetSize(unpack(config.size))
	self:Place(unpack(config.position))


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


	self.CastBar = CastBar
	self.Health = Health
	self.Name = Name
	self.Threat = Threat

	self.BorderNormal = BorderNormal
	self.BorderNormalHighlight = BorderNormalHighlight

	self:HookScript("OnEnter", Library.UpdateLayers)
	self:HookScript("OnLeave", Library.UpdateLayers)
	
end

UnitFrameWidget.OnEnable = function(self)
	self.UnitFrame = UnitFrame:New("targettarget", Engine:GetFrame(), Style) 
end

UnitFrameWidget.GetFrame = function(self)
	return self.UnitFrame
end

