local Addon, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Focus")

local UnitFrame = Engine:GetHandler("UnitFrame")
local StatusBar = Engine:GetHandler("StatusBar")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local pairs = pairs
local table_concat = table.concat
local table_insert = table.insert
local tostring = tostring
local unpack = unpack

-- WoW API
local UnitClass = _G.UnitClass
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitReaction = _G.UnitReaction

local postUpdateHealth = function(health, unit, curHealth, maxHealth, isUnavailable)

	local r, g, b
	if (not isUnavailable) then
		if UnitIsPlayer(unit) then
			local _, class = UnitClass(unit)
			r, g, b = unpack(class and C.Class[class] or C.Class.UNKNOWN)
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

end

local UpdateLayers = function(self)
	if self:IsMouseOver() then
		self.BorderNormalHighlight:Show()
		self.BorderNormal:Hide()
		if self.PortraitBorderNormal then
			self.PortraitBorderNormal:Hide()
			self.PortraitBorderHighlight:Show()
			self.PortraitGlow:Show()
		end
	else
		self.BorderNormal:Show()
		self.BorderNormalHighlight:Hide()
		if self.PortraitBorderNormal then
			self.PortraitBorderNormal:Show()
			self.PortraitBorderHighlight:Hide()
			self.PortraitGlow:Hide()
		end
	end
end

local Style = function(self, unit)
	local config = Module:GetDB("UnitFrames").visuals.units.focus
	local db = Module:GetConfig("UnitFrames") 

	self:Size(unpack(config.size))
	self:Place(unpack(config.position))

	
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
	Border:SetFrameLevel(self:GetFrameLevel() + 5)
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


	-- Health
	-------------------------------------------------------------------
	local Health = StatusBar:New(self)
	Health:SetSize(unpack(config.health.size))
	Health:SetPoint(unpack(config.health.position))
	Health:SetStatusBarTexture(config.health.texture)
	Health.frequent = 1/120
	Health.PostUpdate = postUpdateHealth

	
	-- Power
	-------------------------------------------------------------------
	local Power = StatusBar:New(self)
	Power:SetSize(unpack(config.power.size))
	Power:SetPoint(unpack(config.power.position))
	Power:SetStatusBarTexture(config.power.texture)
	Power.frequent = 1/120
	

	-- CastBar
	-------------------------------------------------------------------
	local CastBar = StatusBar:New(Health)
	CastBar:Hide()
	CastBar:SetAllPoints()
	CastBar:SetStatusBarTexture(1, 1, 1, .15)
	CastBar:SetSize(Health:GetSize())
	--CastBar:SetSparkTexture(config.castbar.spark.texture)
	--CastBar:SetSparkSize(unpack(config.castbar.spark.size))
	--CastBar:SetSparkFlash(unpack(config.castbar.spark.flash))
	CastBar:DisableSmoothing(true)


	-- Portrait
	-------------------------------------------------------------------
	-- Optional animated 3D model portrait, sitting on top of the health
	-- bar. Off by default, and only created here at frame-creation time
	-- (like Show Class Colors) since adding or removing it after the
	-- fact needs a UI reload anyway.
	local Portrait, PortraitBorderNormal, PortraitBorderHighlight, PortraitGlow
	if db.showPortrait then
		local portraitPos = config.portrait.position
		local PortraitHolder = self:CreateFrame("Frame")
		PortraitHolder:SetSize(unpack(config.portrait.size))
		PortraitHolder:SetPoint(portraitPos[1], Health, portraitPos[2], portraitPos[3], portraitPos[4])

		local PortraitBackdrop = PortraitHolder:CreateTexture(nil, "BACKGROUND")
		PortraitBackdrop:SetSize(unpack(config.portrait.texture_size))
		PortraitBackdrop:SetPoint(unpack(config.portrait.texture_position))
		PortraitBackdrop:SetTexture(config.portrait.textures.backdrop)

		-- Above Border's own frame level (self:GetFrameLevel() + 5), so the
		-- portrait and its chrome always draw on top of the frame's skin.
		Portrait = PortraitHolder:CreateFrame("PlayerModel")
		Portrait:SetFrameLevel(self:GetFrameLevel() + 6)
		Portrait:SetAllPoints()

		local PortraitBorder = PortraitHolder:CreateFrame("Frame")
		PortraitBorder:SetFrameLevel(self:GetFrameLevel() + 7)
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
	end


	-- Threat
	-------------------------------------------------------------------
	local Threat = {}
	
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
	end


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


	self.CastBar = CastBar
	self.Health = Health
	self.Name = Name
	self.Portrait = Portrait
	self.Power = Power
	self.Threat = Threat

	self.BorderNormal = BorderNormal
	self.BorderNormalHighlight = BorderNormalHighlight
	self.PortraitBorderNormal = PortraitBorderNormal
	self.PortraitBorderHighlight = PortraitBorderHighlight
	self.PortraitGlow = PortraitGlow

	self:HookScript("OnEnter", UpdateLayers)
	self:HookScript("OnLeave", UpdateLayers)
	
	--self:SetAttribute("toggleForVehicle", true)

end

UnitFrameWidget.OnEnable = function(self)
	local config = Module:GetDB("UnitFrames").visuals.units.focus
	local db = Module:GetConfig("UnitFrames") 

	self.UnitFrame = UnitFrame:New("focus", Engine:GetFrame(), Style) 

end

UnitFrameWidget.GetFrame = function(self)
	return self.UnitFrame
end

