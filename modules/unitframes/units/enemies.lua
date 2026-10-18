-- The boss and arena enemy frames: the same small frames, stacked down
-- from the top right, for boss1-4 (Unit: Boss) and arena1-5 (Unit: Arena).
local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")

local StatusBar = Engine:GetHandler("StatusBar")
local Library = Engine:GetDB("Library: UnitFrames")

-- Lua API
local string_match = string.match
local tonumber = tonumber
local unpack = unpack

-- Builds one frame; `kind` is "boss" or "arena".
local Style = function(self, unit, kind)
	local config = Module:GetDB("UnitFrames").visuals.units[kind]

	local unitNum = tonumber(string_match(unit, "%d"))

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
	Health:SetOrientation("LEFT")
	Health.frequent = 1/30

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
	Health.useClassColor = true
	Health.dimOutOfCombat = true


	-- CastBar
	-------------------------------------------------------------------
	local CastBar = StatusBar:New(Health)
	CastBar:Hide()
	CastBar:SetAllPoints()
	CastBar:SetStatusBarTexture(1, 1, 1, .15)
	CastBar:SetSize(Health:GetSize())
	CastBar:SetOrientation("LEFT")
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
	auras.growthX = "LEFT"
	auras.growthY = "DOWN"
	auras.filter = nil

	auras.BuffFilter = Library.EnemyBuffFilter
	auras.DebuffFilter = Library.EnemyDebuffFilter
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


	self.Auras = auras
	self.CastBar = CastBar
	self.Health = Health
	self.Name = Name
	self.Threat = Threat

	self.BorderNormal = BorderNormal
	self.BorderNormalHighlight = BorderNormalHighlight

	self:HookScript("OnEnter", Library.UpdateLayers)
	self:HookScript("OnLeave", Library.UpdateLayers)
end

-- A widget spawning the frames for unit tokens prefix1..prefixN.
local NewEnemyFrames = function(widgetName, kind, count)
	local UnitFrameWidget = Module:SetWidget(widgetName)

	UnitFrameWidget.OnEnable = function(self)
		local config = self:GetDB("UnitFrames").visuals.units[kind]
		local UnitFrame = Engine:GetHandler("UnitFrame")
		local style = function(frame, unit) return Style(frame, unit, kind) end

		-- A holder for the frames
		self.UnitFrame = Engine:CreateFrame("Frame")
		self.UnitFrame:Place(unpack(config.position))
		self.UnitFrame:SetSize(config.size[1], config.size[2]*4 + config.offset*3)

		for i = 1, count do
			self.UnitFrame[i] = UnitFrame:New(kind..i, self.UnitFrame, style)
		end
	end

	UnitFrameWidget.GetFrame = function(self, index)
		return self.UnitFrame[index] or self.UnitFrame
	end

	return UnitFrameWidget
end

NewEnemyFrames("Unit: Boss", "boss", 4)

-- Gladius does arena frames of its own
local Arena = NewEnemyFrames("Unit: Arena", "arena", 5)
Arena:SetIncompatible("Gladius")
Arena:SetIncompatible("GladiusEx")
