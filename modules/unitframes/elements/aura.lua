-- "Auras" element: buff and debuff icon grids on unit frames, with time
-- left, cooldown spirals, stack counts and per-frame filters
-- (frame.Auras / Buffs / Debuffs).
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local AuraFunctions = Engine:GetDB("Library: AuraFunctions")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local math_ceil = math.ceil
local math_floor = math.floor
local math_min = math.min
local ipairs = ipairs
local setmetatable = setmetatable
local tostring = tostring

-- WoW API
local CancelUnitBuff = _G.CancelUnitBuff
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetTime = _G.GetTime
local GetWeaponEnchantInfo = _G.GetWeaponEnchantInfo
local UnitExists = _G.UnitExists
local UnitHasVehicleUI = _G.UnitHasVehicleUI

-- Inventory slot ids for the main hand and off hand weapons
local MAINHAND_SLOT, OFFHAND_SLOT = 16, 17

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Engine API
local UnitAura = AuraFunctions.UnitAura
local UnitBuff = AuraFunctions.UnitBuff
local UnitDebuff = AuraFunctions.UnitDebuff

-- Blank texture used for the borders
local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]] 


-- Speeeeed!
local day = L["d"]
local hour = L["h"]
local minute = L["m"]

-- Time constants
local DAY, HOUR, MINUTE = 86400, 3600, 60

local formatTime = function(time)
	if time > DAY then -- more than a day
		return "%1d%s", math_ceil(time / DAY), day
	elseif time > HOUR then -- more than an hour
		return "%1d%s", math_ceil(time / HOUR), hour
	elseif time > MINUTE then -- more than a minute
		return "%1d%s", math_ceil(time / MINUTE), minute
	elseif time > 5 then -- more than 5 seconds
		return "%d", math_ceil(time)
	else -- (only ever asked with some time left)
		return "|cffff0000%.1f|r", time
	end
end

-- Cache of all aura buttons from all frames
local auraCache = {}

-- Caches of aura button elements
local Elements = setmetatable({}, { __index = function(self, element) 
	local tbl = {}

	rawset(self, element, tbl)

	return tbl
end })



-- Aura Button Template
-----------------------------------------------------

local Aura = Engine:CreateFrame("Button")
local Aura_MT = { __index = Aura }

Aura.SetElement = function(self, name, element)
	Elements[self][name] = element
end

Aura.GetElement = function(self, name)
	return Elements[self][name]
end

Aura.OnEnter = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, self)

	if self.isWeaponEnchant then
		GameTooltip:SetInventoryItem("player", self.weaponSlot)
	elseif self.isBuff then
		GameTooltip:SetUnitBuff(unit, self:GetID(), self.filter)
	else
		GameTooltip:SetUnitDebuff(unit, self:GetID(), self.filter)
	end
end

Aura.OnLeave = function(self)
	GameTooltip:Hide()
end

Aura.OnClick = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
		return
	end
	if self.isWeaponEnchant then
		return
	end
	if self.isBuff then
		CancelUnitBuff(unit, self:GetID(), self.filter)
	end
end

Aura.SetCooldownTimer = function(self, start, duration)
	local cooldown = self:GetElement("Cooldown")

	-- Try to prevent the strange WotLK bug where the end shine effect
	-- constantly pops up for a random period of time. 
	if duration > .5 then
		cooldown:SetCooldown(start, duration)
		if self._owner.hideCooldownSpiral then
			cooldown:Hide()
		else
			cooldown:Show()
		end
	else
		cooldown:Hide()
	end
end

local HZ = 1/10 -- the text shows tenths of a second at most
Aura.UpdateTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= HZ then
			self.timeLeft = self.expirationTime - GetTime()
			if self.timeLeft > 0 then
				self:GetElement("Time"):SetFormattedText(formatTime(self.timeLeft))
			else
				self:SetScript("OnUpdate", nil)
				self:SetCooldownTimer(0, 0)
				self:GetElement("Time"):SetText("")
			end	
			self.elapsed = 0
		end
	end
end

-- Starts the time left and the cooldown spiral of an aura (or clears them,
-- for one without a duration)
Aura.SetTimer = function(self, fullDuration, expirationTime)
	if fullDuration and (fullDuration > 0) then
		self.fullDuration = fullDuration
		self.timeStarted = expirationTime - fullDuration
		self.timeLeft = expirationTime - GetTime()

		self:SetScript("OnUpdate", self.UpdateTimer)
		self:SetCooldownTimer(self.timeStarted, self.fullDuration)
	else
		self:SetScript("OnUpdate", nil)
		self:SetCooldownTimer(0,0)

		self:GetElement("Time"):SetText("")

		self.fullDuration = 0
		self.timeStarted = 0
		self.timeLeft = 0
	end
end

local CreateAuraButton = function(self)
	local button = setmetatable(self:CreateFrame("Button"), Aura_MT)
	button:EnableMouse(true)
	button:RegisterForClicks("RightButtonUp")
	button._owner = self

	local currentBackdrop = {
		bgFile = BLANK_TEXTURE,
		edgeFile = BLANK_TEXTURE,
		edgeSize = 1,
		insets = {
			left = -1,
			right = -1,
			top = -1,
			bottom = -1
		}
	}

	local Scaffold = button:CreateFrame()
	Scaffold:SetPoint("TOPLEFT", 0, 0)
	Scaffold:SetPoint("BOTTOMRIGHT", 0, 0)
	Scaffold:SetBackdrop(currentBackdrop)
	Scaffold:SetFrameLevel(button:GetFrameLevel() + 1)

	local Icon = Scaffold:CreateTexture()
	Icon:SetPoint("TOPLEFT", 2, -2)
	Icon:SetPoint("BOTTOMRIGHT", -2, 2)
	Icon:SetTexCoord(5/64, 59/64, 5/64, 59/64) 
	Icon:SetDrawLayer("ARTWORK")

	local Cooldown = button:CreateFrame("Cooldown")
	Cooldown:Hide()
	Cooldown:SetReverse(true)
	Cooldown:SetFrameLevel(button:GetFrameLevel() + 2)
	Cooldown:SetPoint("TOPLEFT", Icon, "TOPLEFT", 0, 0)
	Cooldown:SetPoint("BOTTOMRIGHT", Icon, "BOTTOMRIGHT", 0, 0)
	Cooldown:SetAlpha(1)

	local Overlay = button:CreateFrame()
	Overlay:SetFrameLevel(button:GetFrameLevel() + 3)
	Overlay:SetPoint("TOPLEFT", Scaffold, "TOPLEFT", -3, 3)
	Overlay:SetPoint("BOTTOMRIGHT", Scaffold, "BOTTOMRIGHT", 3, -3)

	local Count = Overlay:CreateFontString()
	Count:SetDrawLayer("OVERLAY")
	Count:SetFontObject(DiabolicFont_SansBold12)
	Count:SetPoint("BOTTOMRIGHT", Icon, "BOTTOMRIGHT", -1, 1)

	local Time = Overlay:CreateFontString()
	Time:SetDrawLayer("OVERLAY")
	Time:SetFontObject(DiabolicFont_SansBold10)
	Time:SetPoint("TOPLEFT", Icon, "TOPLEFT", -1, 1)
	
	button:SetElement("Icon", Icon)
	button:SetElement("Count", Count)
	button:SetElement("Cooldown", Cooldown)
	button:SetElement("Time", Time)
	button:SetElement("Scaffold", Scaffold)
	button:SetElement("Overlay", Overlay)

	button:SetScript("OnEnter", Aura.OnEnter)
	button:SetScript("OnLeave", Aura.OnLeave)
	button:SetScript("OnClick", Aura.OnClick)
	
	button.UpdateTooltip = Aura.OnEnter

	auraCache[button] = true
	
	return button
end


local SetPosition = function(self, visible)
	-- arranges auras based on available space and visible auras
	local width, height = self:GetSize()
	local auraWidth, auraHeight = unpack(self.auraSize)
	local spacingH = self.spacingH
	local spacingV = self.spacingV
	local cols, rows = math_floor((width + spacingH) / (auraWidth + spacingH)), math_floor((height + spacingV) / (auraHeight + spacingV))
	local visibleButtons = math_min(cols * rows, visible)
	local growthX = self.growthX
	local growthY = self.growthY

	for i = 1, visibleButtons do
		if (i == 1) then
			local point = ((growthY == "UP") and "BOTTOM" or (growthY == "DOWN") and "TOP") .. ((growthX == "RIGHT") and "LEFT" or (growthX == "LEFT") and "RIGHT")
			self[tostring(i)]:Place(point, self, point, 0, 0)
		elseif ((i - 1)%cols == 0) then
			local point = ((growthY == "UP") and "BOTTOM" or (growthY == "DOWN") and "TOP") .. ((growthX == "RIGHT") and "LEFT" or (growthX == "LEFT") and "RIGHT")
			self[tostring(i)]:Place(point, self, point, 0, (math_floor((i-1) / cols) * (auraHeight + spacingV))*(growthY == "DOWN" and -1 or 1))
		else
			self[tostring(i)]:Place(((growthX == "RIGHT") and "LEFT" or (growthX == "LEFT") and "RIGHT"), self[tostring(i-1)], growthX, (growthX == "RIGHT") and spacingH or -spacingH, 0)
		end
	end

	return visibleButtons
end

local UpdateTooltip = function(self, event, ...)
	local arg1 = ...
	if (event == "MODIFIER_STATE_CHANGED") and ((arg1 == "LSHIFT") or (arg1 == "RSHIFT")) then
		if GameTooltip:IsShown() and auraCache[GameTooltip:GetOwner()] then 
			GameTooltip:GetOwner():UpdateTooltip()
		end
	end
end


-- The owner's (Auras, Buffs or Debuffs) visible-th button, made on first
-- use and styled by the owner's PostCreateButton (its look, and the
-- SetBorderColor it brings).
local GetButton = function(owner, visible)
	local key = tostring(visible)
	local button = owner[key]
	if (not button) then
		button = CreateAuraButton(owner)
		owner[key] = button
		owner:PostCreateButton(button)
	end
	if button:IsShown() then
		button:Hide()
	end
	return button
end

-- Shows a button: its icon, stack count and time left.
local ShowButton = function(owner, button, icon, count, duration, expirationTime)
	button:GetElement("Icon"):SetTexture(icon)
	button:GetElement("Count"):SetText((count and count > 1) and count or "")
	button:SetTimer(duration, expirationTime)
	if (not button:IsShown()) then
		button:Show()
	end
end

-- Adds the unit's auras from `query` (UnitBuff, UnitDebuff or UnitAura,
-- with `filter`) that `accept` lets through, after the `visible` buttons
-- already shown. Returns the new number of shown buttons.
local AddAuras = function(owner, unit, visible, query, filter, maxAuras, isBuff, accept)
	for i = 1, maxAuras do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer = query(unit, i, filter)
		if (not name) then
			break
		end
		if (not accept) or accept(owner, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer) then
			visible = visible + 1
			local button = GetButton(owner, visible)
			button:SetID(i)
			button.isBuff = isBuff
			button.isWeaponEnchant = nil
			button.unit = unit
			button.filter = filter
			button.name = name
			button.rank = rank
			button.count = count
			button.debuffType = debuffType
			button.duration = duration
			button.expirationTime = expirationTime
			button.unitCaster = unitCaster
			button.isStealable = isStealable
			button.isBossDebuff = isBossDebuff
			button.isCastByPlayer = isCastByPlayer
			ShowButton(owner, button, icon, count, duration, expirationTime)
		end
	end
	return visible
end

-- The player's weapon enchants (temporary main/off hand buffs) never come
-- through UnitAura, so they're added here, ahead of the real auras, so they
-- always get a slot instead of being the first thing dropped when the bar
-- is full.
-- One weapon's enchant, in the next button
local AddWeaponEnchant = function(owner, unit, filter, visible, has, expiration, charges, slotID)
	if (not has) then
		return visible
	end
	visible = visible + 1
	local button = GetButton(owner, visible)
	local duration = expiration / 1000
	local expirationTime = GetTime() + duration
	button:SetID(0)
	button.isBuff = true
	button.isWeaponEnchant = true
	button.weaponSlot = slotID
	button.unit = unit
	button.filter = filter
	button.name = nil
	button.count = charges
	button.duration = duration
	button.expirationTime = expirationTime
	ShowButton(owner, button, GetInventoryItemTexture("player", slotID), charges, duration, expirationTime)
	return visible
end

local AddWeaponEnchants = function(owner, unit, filter)
	local hasMainHand, mainExpiration, mainCharges, hasOffHand, offExpiration, offCharges = GetWeaponEnchantInfo()
	local visible = AddWeaponEnchant(owner, unit, filter, 0, hasMainHand, mainExpiration, mainCharges, MAINHAND_SLOT)
	return AddWeaponEnchant(owner, unit, filter, visible, hasOffHand, offExpiration, offCharges, OFFHAND_SLOT)
end

-- Hides the buttons after the visible ones, lays the rest out, and shows
-- or hides the whole owner.
local Finish = function(owner, visible)
	if (visible == 0) then
		if owner:IsShown() then
			owner:Hide()
		end
	else
		local nextButton = SetPosition(owner, visible) + 1
		local key = tostring(nextButton)
		while (owner[key]) do
			owner[key]:Hide()
			owner[key]:SetScript("OnUpdate", nil)
			owner[key]:SetTimer(0,0)
			nextButton = nextButton + 1
			key = tostring(nextButton)
		end
		if (not owner:IsShown()) then
			owner:Show()
		end
	end
end

local Update = function(self, event, ...)
	local unit = self.unit
	local arg1 = ...

	-- The secure state driver that changes the unit when entering a vehicle 
	-- can sometimes be fairly slow, so when relying on that alone auras won't
	-- be properly updated before the auras on your vehicle change again. 
	-- So we hook into vehicle events to figure out what unit actually to query.
	local realUnit = self:GetRealUnit()
	if (realUnit == "player") and ((event == "UNIT_ENTERED_VEHICLE") or (event == "UNIT_ENTERING_VEHICLE") or (event == "UNIT_EXITED_VEHICLE") or (event == "UNIT_EXITING_VEHICLE")) then
		if UnitHasVehicleUI(realUnit) then
			unit = "vehicle"
		else
			unit = realUnit
		end
	elseif not((event == "PLAYER_ENTERING_WORLD") or (event == "FORCED") or (event == "PLAYER_TARGET_CHANGED")) and (unit ~= arg1) then
		return
	end
	local exists = UnitExists(unit)

	-- Buffs and debuffs together
	local Auras = self.Auras
	if Auras then
		if (not exists) then
			Auras:Hide()
		else
			local visible = AddAuras(Auras, unit, 0, UnitBuff, Auras.filter, BUFF_MAX_DISPLAY, true, Auras.BuffFilter)
			visible = AddAuras(Auras, unit, visible, UnitDebuff, Auras.filter, DEBUFF_MAX_DISPLAY, false, Auras.DebuffFilter)
			Finish(Auras, visible)
		end
	end

	-- Buffs, the player's weapon enchants first
	local Buffs = self.Buffs
	if Buffs then
		if (not exists) then
			Buffs:Hide()
		else
			local visible = (unit == "player") and AddWeaponEnchants(Buffs, unit, Buffs.filter) or 0
			visible = AddAuras(Buffs, unit, visible, UnitAura, Buffs.filter, BUFF_MAX_DISPLAY, true, Buffs.BuffFilter)
			Finish(Buffs, visible)
		end
	end

	-- Debuffs
	local Debuffs = self.Debuffs
	if Debuffs then
		if (not exists) then
			Debuffs:Hide()
		else
			local visible = AddAuras(Debuffs, unit, 0, UnitAura, Debuffs.filter, DEBUFF_MAX_DISPLAY, false, Debuffs.DebuffFilter)
			Finish(Debuffs, visible)
		end
	end
end

local ForceUpdate = function(element)
	return Update(element._owner, "FORCED", element.unit)
end

local Enable = function(self, unit)
	local Auras = self.Auras
	local Buffs = self.Buffs
	local Debuffs = self.Debuffs
	if Auras or Buffs or Debuffs then
		if Auras then
			Auras._owner = self
			Auras.unit = unit
			Auras.ForceUpdate = ForceUpdate
		end
		if Buffs then
			Buffs._owner = self
			Buffs.unit = unit
			Buffs.ForceUpdate = ForceUpdate
		end
		if Debuffs then
			Debuffs._owner = self
			Debuffs.unit = unit
			Debuffs.ForceUpdate = ForceUpdate
		end
		self:RegisterEvent("UNIT_AURA", Update)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:RegisterEvent("VEHICLE_UPDATE", Update)
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:RegisterEvent("UNIT_ENTERING_VEHICLE", Update)
		self:RegisterEvent("UNIT_EXITING_VEHICLE", Update)
		self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
		self:RegisterEvent("MODIFIER_STATE_CHANGED", UpdateTooltip)

		if (unit == "target") or (unit == "targettarget") then
			self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)
		end

		if (unit == "player") then
			self:RegisterEvent("UNIT_INVENTORY_CHANGED", Update)
		end

		return true
	end
end

Handler:RegisterElement("Auras", Enable, Update)
