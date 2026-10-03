-- "Unit: Player" widget: the player's health and power orbs at the bottom
-- corners, plus the player cast bar, buffs and debuffs.
local _, Engine = ...
local Module = Engine:GetModule("UnitFrames")
local UnitFrameWidget = Module:SetWidget("Unit: Player")
local C = Engine:GetDB("Data: Colors")
local Library = Engine:GetDB("Library: UnitFrames")

-- Lua API
local _G = _G
local ipairs = ipairs
local unpack = unpack
local pairs = pairs
local tostring = tostring

-- WoW API
local CreateFrame = _G.CreateFrame
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitClass = _G.UnitClass
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType

-- WoW constants
local SPELL_POWER_MANA = _G.SPELL_POWER_MANA

-- player class
local _,CLASS = UnitClass("player")

-- bar visibility constants
local HAS_VEHICLE_UI = false -- entering a value just to reserve the memory. semantics.
local NUM_VISIBLE_BARS = 1 -- need a fallback here or the spawn will bug out


-- An orb's value and label: the value shows in combat or with the mouse
-- over the orb, the label with the mouse over it only. (The polled updates
-- get here about 120 times a second: the texts are only touched when that
-- changes.)
local UpdateTexts = function(bar)
	local over = bar._owner.mouseIsOver
	local valueAlpha = (over or UnitAffectingCombat("player")) and .9 or 0
	local labelAlpha = over and .9 or 0
	local Value, Label = bar.Value, bar.Label
	if (valueAlpha ~= Value.alpha) or (labelAlpha ~= Label.alpha) then
		Value:SetAlpha(valueAlpha)
		Label:SetAlpha(labelAlpha)
		Value.alpha, Label.alpha = valueAlpha, labelAlpha
	end
end

-- Health: the player's class colors (or blood red), and the texts.
local postUpdateHealth = function(health, unit)
	local _, class = UnitClass(unit)
	local colors = (health.useClassColor and UnitIsPlayer(unit) and C.Orb[class]) or C.Orb.HEALTH
	for _, layer in ipairs(colors) do
		health:SetStatusBarColor(layer[1], layer[2], layer[3], layer[4], layer[5])
	end
	UpdateTexts(health)
end

-- Power: the primary power orb is cropped to make room for the mana orb
-- while mana isn't the main resource (a druid in a form), then the texts.
local postUpdatePower = function(power)
	local unit = power._owner.unit
	local _, powerType = UnitPowerType(unit)
	if (power.currentPowerType ~= powerType) then
		if (powerType ~= "MANA") and (UnitPowerMax(unit, SPELL_POWER_MANA) > 0) then
			power:SetCrop(0, power.crop)
		else
			power:SetCrop(0, 0)
		end
		power.currentPowerType = powerType
	end
	UpdateTexts(power)
end

local onEnterLeft = function(self)
	self.mouseIsOver = true
	UpdateTexts(self.Health)
end

local onLeaveLeft = function(self)
	self.mouseIsOver = false
	UpdateTexts(self.Health)
end

local onEnterRight = function(self)
	self.mouseIsOver = true
	UpdateTexts(self.Power)
end

local onLeaveRight = function(self)
	self.mouseIsOver = false
	UpdateTexts(self.Power)
end

-- Time limit where we separate between short and long buffs
local TIME_LIMIT = Engine:GetConstant("AURA_TIME_LIMIT")

-- Move to the general aura lists later
local whiteList = {
	-- Player debuffs of importance
	[57723] 	= true, 	-- Exhaustion "Cannot benefit from Heroism or other similar effects." (Alliance version)
	[57724] 	= true, 	-- Sated "Cannot benefit from Bloodlust or other similar effects." (Horde version)

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
		return true
	end
end

-- Left orb (health, castbar, actionbar auras)
local StyleLeftOrb = function(self, unit, index, numBars, inVehicle)
	local config = Module:GetDB("UnitFrames").visuals.units.player
	local db = Module:GetConfig("UnitFrames")

	local configHealth = config.left.health
	local configHealthSpark = config.left.health.spark
	local configHealthLayers = config.left.health.layers
	local configHealthTexts = config.texts.health

	self:SetSize(unpack(config.left.size))
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
	Health:SetSparkFlashSize(unpack(configHealthSpark.flash_size))
	Health:SetSparkFlashTexture(configHealthSpark.flash_texture)

	Health.useClassColor = db.showClassColors
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
	Buffs.hideCooldownSpiral = true

	Buffs.BuffFilter = shortBuffFilter
	Buffs.PostCreateButton = Library.PostCreateAuraButton


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
	Debuffs.hideCooldownSpiral = true

	Debuffs.DebuffFilter = shortDebuffFilter
	Debuffs.PostCreateButton = Library.PostCreateAuraButton


	-- Runes (death knights)
	-------------------------------------------------------------------
	-- Six glyphs from one texture: row 0 is the empty slot, row 1 the fill
	-- and row 2 its glow. The Runes element fills and colors them.
	local Runes
	if (CLASS == "DEATHKNIGHT") then
		local configRunes = config.runes
		local glyphWidth, glyphHeight = unpack(configRunes.glyph_size)
		local size = configRunes.rune_size

		Runes = self:CreateFrame("Frame")
		Runes:SetSize(unpack(configRunes.size))
		Runes:Place(unpack(hasPet and configRunes.positionPet or configRunes.position))
		Runes.config = configRunes

		for i = 1, 6 do
			local rune = CreateFrame("Frame", nil, Runes)
			rune:SetSize(size, size)
			rune:SetPoint("BOTTOMLEFT", (i - 1) * size, 0)
			rune.size = size

			local glyph = function(row, drawLayer)
				local texture = rune:CreateTexture(nil, drawLayer)
				local top = row * glyphHeight
				texture.texCoords = { (i - 1) * glyphWidth, i * glyphWidth, top, top + glyphHeight }
				texture:SetTexture(configRunes.texture)
				texture:SetTexCoord(unpack(texture.texCoords))
				return texture
			end

			rune.Slot = glyph(configRunes.glyph_rows.slot, "BACKGROUND")
			rune.Slot:SetAllPoints()

			rune.Fill = glyph(configRunes.glyph_rows.fill, "ARTWORK")
			rune.Glow = glyph(configRunes.glyph_rows.glow, "OVERLAY")
			rune.Glow:SetBlendMode("ADD")
			rune.layers = { rune.Fill, rune.Glow }
			for _, texture in ipairs(rune.layers) do
				texture:SetPoint("BOTTOMLEFT")
				texture:SetPoint("BOTTOMRIGHT")
				texture:SetHeight(size)
			end

			Runes[i] = rune
		end
	end

	self:HookScript("OnEnter", onEnterLeft)
	self:HookScript("OnLeave", onLeaveLeft)

	self.Runes = Runes
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.Health = Health
	self.WeaponEnchants = true -- drives a periodic refresh so weapon enchants (shown inline in Buffs) don't go stale

end

-- Which half of the screen the (real, Blizzard) minimap is currently on,
-- so the long-duration buffs anchored beside it can be told to grow out
-- into open screen space instead of running off whichever edge it's near.
local GetMinimapSide = function()
	local minimap = _G.Minimap
	local minimapX = minimap and minimap:GetCenter()
	local screenX = _G.UIParent:GetCenter()
	if (minimapX and screenX and minimapX < screenX) then
		return "LEFT"
	end
	return "RIGHT"
end

-- Flips the minimap buffs to the opposite side of the minimap when it's
-- moved to the left half of the screen, and back when it isn't.
local UpdateAuraSide = function(self)
	local Buffs = self.Right.Buffs

	local side = GetMinimapSide()
	if (side == self.auraSide) then
		return
	end
	self.auraSide = side

	if (side == "LEFT") then
		Buffs:Place(unpack(Buffs.positionMinimapLeft))
		Buffs.growthX = "RIGHT"
	else
		Buffs:Place(unpack(Buffs.position))
		Buffs.growthX = "LEFT"
	end
	Buffs:ForceUpdate("Buffs")
end

-- Right orb (power, minimap auras)
local StyleRightOrb = function(self, unit, index, numBars, inVehicle)
	local config = Module:GetDB("UnitFrames").visuals.units.player
	local db = Module:GetConfig("UnitFrames")

	local configPower = config.right.power
	local configPowerSpark = config.right.power.spark
	local configPowerLayers = config.right.power.layers
	local configPowerTexts = config.texts.power

	self:SetSize(unpack(config.right.size))
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


	-- Buffs (no duration)
	-------------------------------------------------------------------
	local Buffs = self:CreateFrame()
	Buffs:SetSize(config.auras.size[1], config.auras.size[2])
	Buffs:Place(unpack(config.auras.position)) -- Minimap is always visible on /reload

	Buffs.position = config.auras.position
	Buffs.positionMinimapLeft = config.auras.positionMinimapLeft
	Buffs.config = config.auras
	Buffs.buttonConfig = config.auras.button
	Buffs.auraSize = config.auras.button.size
	Buffs.spacingH = config.auras.spacingH
	Buffs.spacingV = config.auras.spacingV
	Buffs.growthX = "LEFT"
	Buffs.growthY = "DOWN"
	Buffs.filter = "HELPFUL"
	Buffs.hideCooldownSpiral = true -- looks slightly weird on long term buffs

	Buffs.BuffFilter = longBuffFilter
	Buffs.PostCreateButton = Library.PostCreateAuraButton

	self:HookScript("OnEnter", onEnterRight)
	self:HookScript("OnLeave", onLeaveRight)

	self.Buffs = Buffs
	self.Power = Power
	self.Mana = Mana

end

-- The player's aura areas shrink with more action bars, and the vehicle's.
local UpdateAuraSizes = function(self)
	local size = HAS_VEHICLE_UI and "vehicle" or tostring(NUM_VISIBLE_BARS)
	self.Left.Buffs:SetSize(unpack(self.config.buffs.size[size]))
	self.Left.Debuffs:SetSize(unpack(self.config.debuffs.size[size]))
	self.Left.Buffs:ForceUpdate("Buffs")
end

UnitFrameWidget.OnEvent = function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		NUM_VISIBLE_BARS = self.ActionBarController:GetNumBars() or 1 -- fallback value
		HAS_VEHICLE_UI = self.ActionBarController:InVehicle() or false
		UpdateAuraSizes(self)
		UpdateAuraSide(self)

	elseif event == "ENGINE_ACTIONBAR_VEHICLE_CHANGED" then
		local hasVehicleUI = ...
		if hasVehicleUI ~= HAS_VEHICLE_UI then
			HAS_VEHICLE_UI = hasVehicleUI
			UpdateAuraSizes(self)
		end

	elseif event == "ENGINE_ACTIONBAR_VISIBLE_CHANGED" then
		local numVisibleBars = ...
		if numVisibleBars ~= NUM_VISIBLE_BARS then
			NUM_VISIBLE_BARS = numVisibleBars
			UpdateAuraSizes(self)
		end

	elseif event == "ENGINE_ACTIONBAR_PET_CHANGED" then
		-- moved up out of the pet bar's way
		local position = (...) and "positionPet" or "position"
		local Left = self.Left
		if Left.CastBar then -- (none when Quartz or Castbars does the cast bars)
			Left.CastBar:Place(unpack(self.config.castbar[position]))
		end
		Left.Buffs:Place(unpack(self.config.buffs[position]))
		Left.Debuffs:Place(unpack(self.config.debuffs[position]))
		if Left.Runes then
			Left.Runes:Place(unpack(self.config.runes[position]))
		end
	end
end

UnitFrameWidget.OnEnable = function(self)
	self.config = self:GetDB("UnitFrames").visuals.units.player
	self.db = self:GetConfig("UnitFrames")

	-- get the main actionbar controller, as we need some info from it
	self.ActionBarController = Engine:GetModule("ActionBars"):GetWidget("Controller: Main"):GetFrame()

	-- set our constants for number of visible bars and vehicleUI
	NUM_VISIBLE_BARS = self.ActionBarController:GetNumBars() or 1 -- fallback value
	HAS_VEHICLE_UI = self.ActionBarController:InVehicle() or false

	-- spawn the orbs
	local UnitFrame = Engine:GetHandler("UnitFrame")
	self.Left = UnitFrame:New("player", "UICenter", StyleLeftOrb) -- health / main
	self.Right = UnitFrame:New("player", "UICenter", StyleRightOrb) -- power / mana in forms

	local BlizzardUI = self:GetHandler("BlizzardUI")
	BlizzardUI:GetElement("Menu_Panel"):Remove(11, "InterfaceOptionsBuffsPanel")

	-- Disable Blizzard's castbars for player
	BlizzardUI:GetElement("Auras"):Disable()
	BlizzardUI:GetElement("CastBars"):Remove("player")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterMessage("ENGINE_ACTIONBAR_VEHICLE_CHANGED", "OnEvent")
	self:RegisterMessage("ENGINE_ACTIONBAR_VISIBLE_CHANGED", "OnEvent")
	self:RegisterMessage("ENGINE_ACTIONBAR_PET_CHANGED", "OnEvent")

	-- No event fires when the minimap itself is moved (e.g. dragged in
	-- the minimap module's own edit mode), so this polls for it instead.
	local auraSideTicker = CreateFrame("Frame")
	auraSideTicker:SetScript("OnUpdate", function(ticker, elapsed)
		ticker.elapsed = (ticker.elapsed or 0) + elapsed
		if (ticker.elapsed < 1) then
			return
		end
		ticker.elapsed = 0
		UpdateAuraSide(self)
	end)

	UpdateAuraSide(self)
end

UnitFrameWidget.GetFrame = function(self)
	return self.Left, self.Right
end

