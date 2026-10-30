local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Party")

local StatusBar = Engine:GetHandler("StatusBar")
local Library = Engine:GetDB("Library: UnitFrames")

-- Lua API
local string_match = string.match
local unpack = unpack

local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.party
	local db = Module:GetConfig("UnitFrames")

	local unitNum = string_match(unit, "%d") -- (party1 to party4)

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
	Health.frequent = 1/30

	local HealthValueHolder = Health:CreateFrame("Frame")
	HealthValueHolder:SetAllPoints()
	HealthValueHolder:SetFrameLevel(Border:GetFrameLevel() + 1)

	Health.Value = HealthValueHolder:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(config.texts.health.font_object)
	Health.Value:SetPoint(unpack(config.texts.health.position))
	Health.Value.showMaximum = true
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

	auras.BuffFilter = Library.GroupBuffFilter
	auras.DebuffFilter = Library.GroupDebuffFilter
	auras.PostCreateButton = Library.PostCreateAuraButton


	-- Texts
	-------------------------------------------------------------------
	local Name = Border:CreateFontString(nil, "OVERLAY")
	Name:SetFontObject(config.name.font_object)
	if db.showPortrait then
		-- The portrait takes the space above the frame the name normally
		-- floats in, so the name moves below the health bar instead.
		-- Justified TOP (instead of BOTTOM) so the text hugs the anchor
		-- right under the health bar, instead of sinking to the bottom
		-- of its own (much taller) text box.
		local namePos = config.portrait.name_position
		Name:SetPoint(namePos[1], Health, namePos[2], namePos[3], namePos[4])
		Name:SetJustifyV("TOP")
	else
		Name:SetPoint(unpack(config.name.position))
		Name:SetJustifyV("BOTTOM")
	end
	Name:SetSize(unpack(config.name.size))
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


	-- Portrait
	-------------------------------------------------------------------
	-- Optional animated 3D model portrait, sitting on top of the health
	-- bar. Off by default, and only created here at frame-creation time
	-- (like Show Class Colors) since adding or removing it after the
	-- fact needs a UI reload anyway.
	local Portrait, Portrait2D, PortraitBorderNormal, PortraitBorderHighlight, PortraitGlow
	if db.showPortrait then
		local portraitPos = config.portrait.position
		local PortraitHolder = self:CreateFrame("Frame")
		PortraitHolder:SetSize(unpack(config.portrait.size))
		PortraitHolder:SetPoint(portraitPos[1], Health, portraitPos[2], portraitPos[3], portraitPos[4])

		local PortraitBackdrop = PortraitHolder:CreateTexture(nil, "BACKGROUND")
		PortraitBackdrop:SetSize(unpack(config.portrait.texture_size))
		PortraitBackdrop:SetPoint(unpack(config.portrait.texture_position))
		PortraitBackdrop:SetTexture(config.portrait.textures.backdrop)

		-- Above Border's own frame level (self:GetFrameLevel() + 4), so the
		-- portrait and its chrome always draw on top of the frame's skin.
		Portrait = PortraitHolder:CreateFrame("PlayerModel")
		Portrait:SetFrameLevel(self:GetFrameLevel() + 5)
		Portrait:SetAllPoints()

		-- Sits directly behind the 3D model above (lower frame level) and
		-- stays kept in sync (see elements/portraits.lua): whenever the
		-- model itself fails to render - e.g. too far away for it to
		-- have streamed in - it's fully transparent, so this shows
		-- through by itself with no extra detection logic needed.
		Portrait2D = PortraitHolder:CreateTexture(nil, "ARTWORK")
		Portrait2D:SetAllPoints(Portrait)
		Portrait2D:Hide()

		local PortraitBorder = PortraitHolder:CreateFrame("Frame")
		PortraitBorder:SetFrameLevel(self:GetFrameLevel() + 6)
		PortraitBorder:SetAllPoints()

		PortraitBorderNormal = PortraitBorder:CreateTexture(nil, "ARTWORK")
		PortraitBorderNormal:SetSize(unpack(config.portrait.texture_size))
		PortraitBorderNormal:SetPoint(unpack(config.portrait.texture_position))
		PortraitBorderNormal:SetTexture(config.portrait.textures.border)

		PortraitBorderHighlight = PortraitBorder:CreateTexture(nil, "ARTWORK")
		PortraitBorderHighlight:SetSize(unpack(config.portrait.texture_size))
		PortraitBorderHighlight:SetPoint(unpack(config.portrait.texture_position))
		PortraitBorderHighlight:SetTexture(config.portrait.textures.highlight)
		PortraitBorderHighlight:Hide()

		PortraitGlow = PortraitBorder:CreateTexture(nil, "OVERLAY")
		PortraitGlow:SetSize(unpack(config.portrait.texture_size))
		PortraitGlow:SetPoint(unpack(config.portrait.texture_position))
		PortraitGlow:SetTexture(config.portrait.textures.glow)
		PortraitGlow:Hide()

		-- The portrait sits above the health bar, outside the secure
		-- button's own rect, so clicking it wouldn't select the unit
		-- without extending the button's hit-test area to cover it.
		local chromeOverflow = (config.portrait.texture_size[2] - config.portrait.size[2]) / 2
		local topOverflow = config.health.position[3] + config.health.size[2] + portraitPos[4] + config.portrait.size[2] + chromeOverflow - config.size[2]
		self:SetHitRectInsets(0, 0, -topOverflow, 0)
	end


	self.Auras = auras
	self.CastBar = CastBar
	self.Health = Health
	self.Name = Name
	self.Portrait = Portrait
	self.Portrait2D = Portrait2D
	self.Role = Role
	self.Threat = Threat

	self.BorderNormal = BorderNormal
	self.BorderNormalHighlight = BorderNormalHighlight
	self.PortraitBorderNormal = PortraitBorderNormal
	self.PortraitBorderHighlight = PortraitBorderHighlight
	self.PortraitGlow = PortraitGlow

	self:HookScript("OnEnter", Library.UpdateLayers)
	self:HookScript("OnLeave", Library.UpdateLayers)


end

-- Exposed so units/testmode.lua's Toggle Fake Party can reuse this purely-visual
-- builder to construct mock preview frames, without needing to go through
-- the real (unit-token-driven) UnitFrame:New/Handler.New pipeline.
UnitFrameWidget.Style = Style

UnitFrameWidget.OnEnable = function(self)
	local config = self:GetDB("UnitFrames").visuals.units.party

	-- Retrieve the unitframe handler
	local UnitFrame = Engine:GetHandler("UnitFrame")

	-- Spawn a holder for all party frames
	self.UnitFrame = Engine:CreateFrame("Frame", nil, "UICenter", "SecureHandlerAttributeTemplate")
	self.UnitFrame:Place(unpack(config.position))
	self.UnitFrame:SetSize(config.size[1], config.size[2]*4 + config.offset*3)
	RegisterStateDriver(self.UnitFrame, "visibility", "[@raid1,exists]hide;show")

	-- The four frames show and hide themselves with their units.
	for i = 1,4 do
		self.UnitFrame[i] = UnitFrame:New("party"..i, self.UnitFrame, Style)
	end

end

UnitFrameWidget.GetFrame = function(self, numPartyMember)
	return self.UnitFrame[numPartyMember] or self.UnitFrame
end
