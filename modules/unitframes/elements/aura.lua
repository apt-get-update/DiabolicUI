local ADDON, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")
local StatusBar = Engine:GetHandler("StatusBar")
local C = Engine:GetDB("Data: Colors")
local AuraFunctions = Engine:GetDB("Library: AuraFunctions")
local L = Engine:GetLocale()
local UICenter = Engine:GetFrame()

-- Lua API
local _G = _G
local math_ceil = math.ceil
local math_floor = math.floor
local math_min = math.min
local select = select
local setmetatable = setmetatable

-- WoW API
local CancelUnitBuff = _G.CancelUnitBuff
local CreateFrame = _G.CreateFrame
local GetTime = _G.GetTime
local InCombatLockdown = _G.InCombatLockdown
local UnitExists = _G.UnitExists
local UnitHasVehicleUI = _G.UnitHasVehicleUI
local UnitReaction = _G.UnitReaction

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Engine API
local UnitAura = AuraFunctions.UnitAura
local UnitBuff = AuraFunctions.UnitBuff
local UnitDebuff = AuraFunctions.UnitDebuff

-- Blank texture used as a fallback for borders and bars
local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]] 

-- these exist (or are used) in WoD and beyond
local BLING_TEXTURE = [[Interface\Cooldown\star4]]
local EDGE_LOC_TEXTURE = [[Interface\Cooldown\edge-LoC]]
local EDGE_NORMAL_TEXTURE = [[Interface\Cooldown\edge]]

-- Retrive the current game client version
local BUILD = tonumber((select(2, GetBuildInfo()))) 

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
	elseif time > 0 then
		return "|cffff0000%.1f|r", time
	else
		return ""
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
	if GameTooltip:IsForbidden() then
		return
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, self)

	if self.isBuff then
		GameTooltip:SetUnitBuff(unit, self:GetID(), self.filter)
	else
		GameTooltip:SetUnitDebuff(unit, self:GetID(), self.filter)
	end
end

Aura.OnLeave = function(self)
	if (not GameTooltip:IsForbidden()) then
		GameTooltip:Hide()
	end
end

Aura.OnClick = function(self)
	local unit = self.unit
	if not UnitExists(unit) then
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

local HZ = 1/30
Aura.UpdateTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= HZ then
			self.timeLeft = self.expirationTime - GetTime()
			if self.timeLeft > 0 then
				self:GetElement("Time"):SetFormattedText(formatTime(self.timeLeft))
				self:GetElement("Timer").Bar:SetValue(self.timeLeft)

				if self._owner.PostUpdateButton then
					self._owner:PostUpdateButton(self, "Timer")
				end
			else
				self:SetScript("OnUpdate", nil)
				self:SetCooldownTimer(0, 0)

				local timer = self:GetElement("Timer")
				timer:Hide()
				timer.Bar:SetValue(0)
				timer.Bar:SetMinMaxValues(0,0)

				self:GetElement("Time"):SetText("")

				if self._owner.PostUpdateButton then
					self._owner:PostUpdateButton(self, "Timer")
				end
			end	
			self.elapsed = 0
		end
	end
end

-- Use this to initiate the timer bars and spirals on the auras
Aura.SetTimer = function(self, fullDuration, expirationTime)
	if fullDuration and (fullDuration > 0) then
		self.fullDuration = fullDuration
		self.timeStarted = expirationTime - fullDuration
		self.timeLeft = expirationTime - GetTime()

		local bar = self:GetElement("Timer").Bar
		bar:SetMinMaxValues(0, fullDuration)
		bar:SetValue(self.timeLeft)

		if (not self._owner.hideTimerBar) then
			self:GetElement("Timer"):Show()
		end

		self:SetScript("OnUpdate", self.UpdateTimer)
		self:SetCooldownTimer(self.timeStarted, self.fullDuration)
	else
		self:SetScript("OnUpdate", nil)
		self:SetCooldownTimer(0,0)

		self:GetElement("Time"):SetText("")
		self:GetElement("Timer"):Hide()

		local bar = self:GetElement("Timer").Bar
		bar:SetValue(0)
		bar:SetMinMaxValues(0,0)

		self.fullDuration = 0
		self.timeStarted = 0
		self.timeLeft = 0

		if self._owner.PostUpdateButton then
			self._owner:PostUpdateButton(self, "Timer")
		end
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

	local Timer = button:CreateFrame()
	Timer:Hide()
	Timer:SetPoint("TOPLEFT", Scaffold, "BOTTOMLEFT", 0, -1)
	Timer:SetPoint("TOPRIGHT", Scaffold, "BOTTOMRIGHT", 0, -1)
	Timer:SetPoint("BOTTOMLEFT", Scaffold, "BOTTOMLEFT", 0, -9)
	Timer:SetPoint("BOTTOMRIGHT", Scaffold, "BOTTOMRIGHT", 0, -9)

	local TimerScaffold = Timer:CreateFrame()
	TimerScaffold:SetPoint("TOPLEFT", 0, 0)
	TimerScaffold:SetPoint("BOTTOMRIGHT", 0, 0)
	TimerScaffold:SetBackdrop(currentBackdrop)
	TimerScaffold:SetFrameLevel(Timer:GetFrameLevel() + 1)
	Timer.Scaffold = TimerScaffold

	local TimerBarBackground = TimerScaffold:CreateTexture()
	TimerBarBackground:SetDrawLayer("BACKGROUND")
	TimerBarBackground:SetPoint("TOPLEFT", 2, -2)
	TimerBarBackground:SetPoint("BOTTOMRIGHT", -2, 2)
	TimerBarBackground:SetTexture(BLANK_TEXTURE)
	Timer.Background = TimerBarBackground

	local TimerBar = Timer:CreateStatusBar()
	TimerBar:SetStatusBarTexture(BLANK_TEXTURE)
	TimerBar:SetPoint("TOPLEFT", 2, -2)
	TimerBar:SetPoint("BOTTOMRIGHT", -2, 2)
	TimerBar:SetFrameLevel(Timer:GetFrameLevel() + 2)
	Timer.Bar = TimerBar

	button.SetBorderColor = function(self, r, g, b)
		Scaffold:SetBackdropColor(r * 1/3, g * 1/3, b * 1/3)
		Scaffold:SetBackdropBorderColor(r, g, b)

		TimerScaffold:SetBackdropColor(r * 1/3, g * 1/3, b * 1/3)
		TimerScaffold:SetBackdropBorderColor(r, g, b)

		TimerBarBackground:SetVertexColor(r * 1/3, g * 1/3, b * 1/3)
		TimerBar:SetStatusBarColor(r * 2/3, g * 2/3, b * 2/3)
	end
	
	button:SetElement("Icon", Icon)
	button:SetElement("Count", Count)
	button:SetElement("Cooldown", Cooldown)
	button:SetElement("Time", Time)
	button:SetElement("Timer", Timer)
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

	local previous
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
	if GameTooltip:IsForbidden() then
		return
	end
	if (event == "MODIFIER_STATE_CHANGED") and ((arg1 == "LSHIFT") or (arg1 == "RSHIFT")) then
		if GameTooltip:IsShown() and auraCache[GameTooltip:GetOwner()] then 
			GameTooltip:GetOwner():UpdateTooltip()
		end
	end
end


-- Thanks to Blazeflack and Azilroka over at 
-- the TukUI forums for figuring this one out. 
-- http://www.tukui.org/forums/topic.php?id=34384
local FixFrameStack = function(header, index)
	-- /framestack fails when frames that are created as indices of a table are visible,
	-- so in order for it to work we need to have hashed names for all of them. Blizzard bug. 
	--header[tostring(index)] = header[index]
end

local Update = function(self, event, ...)
	local unit = self.unit
	local arg1 = ...

	-- The secure state driver that changes the unit when entering a vehicle 
	-- can sometimes be fairly slow, so when relying on that alone auras won't
	-- be properly updated before the auras on your vehicle change again. 
	-- So we hook into vehicle events to figure out what unit actually to query.
	-- 
	-- Todo: Let the unitframe handler deal with this entire thing, 
	--       and fire callbacks to update the unitframes automatically. 
	local realUnit = self:GetRealUnit()
	if (realUnit == "player") and ((event == "UNIT_ENTERED_VEHICLE") or (event == "UNIT_ENTERING_VEHICLE") or (event == "UNIT_EXITED_VEHICLE") or (event == "UNIT_EXITING_VEHICLE")) then
		if UnitHasVehicleUI(realUnit) then
			unit = "vehicle"
		else
			unit = realUnit
		end
	else
		if not((event == "PLAYER_ENTERING_WORLD") or (event == "FREQUENT") or (event == "FORCED") or (event == "PLAYER_TARGET_CHANGED")) and (unit ~= arg1) then
			return
		end
	end

	local Auras = self.Auras
	if Auras then
		if not UnitExists(unit) then
			Auras:Hide()
		else
			local visible = 0
			local visibleBuffs = 0
			local visibleDebuffs = 0

			if Auras.PreUpdate then
				Auras:PreUpdate(unit)
			end

			local filter = Auras.filter

			-- count buffs
			for i = 1, BUFF_MAX_DISPLAY do

				local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer = UnitBuff(unit, i, filter)

				if not name then
					break
				end

				-- This won't replace the normal filter, but be applied after it
				if name and (Auras.BuffFilter or Auras.AuraFilter) then
					local show = (Auras.BuffFilter or Auras.AuraFilter)(Auras, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
					if not show then
						name = nil
					end
				end

				if name then
					visible = visible + 1
					visibleBuffs = visibleBuffs + 1

					local visibleKey = tostring(visible)

					if (not Auras[visibleKey]) then
						Auras[visibleKey] = Auras.CreateButton and Auras:CreateButton() or CreateAuraButton(Auras)
						if Auras.PostCreateButton then
							Auras:PostCreateButton(Auras[visibleKey])
						end
					end

					local button = Auras[visibleKey]
					if button:IsShown() then
						button:Hide() 
					end

					button:SetID(i)

					button.isBuff = true
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

					button:GetElement("Icon"):SetTexture(icon)
					button:GetElement("Count"):SetText((count > 1) and count or "")
					
					button:SetTimer(duration, expirationTime)

					if Auras.PostUpdateButton then
						Auras:PostUpdateButton(button)
					end

					if (not button:IsShown()) then
						button:Show()
					end

				end
	
			end


			-- count debuffs
			for i = 1, DEBUFF_MAX_DISPLAY do

				local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer = UnitDebuff(unit, i, filter)

				if not name then
					break
				end

				-- This won't replace the normal filter, but be applied after it
				if name and (Auras.DebuffFilter or Auras.AuraFilter) then
					local show = (Auras.DebuffFilter or Auras.AuraFilter)(Auras, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
					if not show then
						name = nil
					end
				end

				if name then
					visible = visible + 1
					visibleDebuffs = visibleDebuffs + 1

					local visibleKey = tostring(visible)

					if (not Auras[visibleKey]) then
						Auras[visibleKey] = Auras.CreateButton and Auras:CreateButton() or CreateAuraButton(Auras)
						if Auras.PostCreateButton then
							Auras:PostCreateButton(Auras[visibleKey])
						end
					end

					local button = Auras[visibleKey]
					if button:IsShown() then
						button:Hide() 
					end

					button:SetID(i)

					button.isBuff = false
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

					button:GetElement("Icon"):SetTexture(icon)
					button:GetElement("Count"):SetText((count > 1) and count or "")
					
					button:SetTimer(duration, expirationTime)
					
					if Auras.PostUpdateButton then
						Auras:PostUpdateButton(button)
					end

					if not button:IsShown() then
						button:Show()
					end

				end
			end

			if (visible == 0) then
				if Auras:IsShown() then
					Auras:Hide()
				end
			else
				local nextAura = SetPosition(Auras, visible) + 1
				local visibleKey = tostring(nextAura)
				while (Auras[visibleKey]) do
					Auras[visibleKey]:Hide()
					Auras[visibleKey]:SetScript("OnUpdate", nil)
					Auras[visibleKey]:SetTimer(0,0)
					nextAura = nextAura + 1
					visibleKey = tostring(nextAura)
				end
				if (not Auras:IsShown()) then
					Auras:Show()
				end
			end

			if Auras.PostUpdate then
				Auras:PostUpdate()
			end	
		end
	end

	local Buffs = self.Buffs
	if Buffs then
		if not UnitExists(unit) then
			Buffs:Hide()
		else
			local visible = 0
			local filter = Buffs.filter

			for i = 1, BUFF_MAX_DISPLAY do

				local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer = UnitAura(unit, i, filter)

				if (not name) then
					break
				end

				-- This won't replace the normal filter, but be applied after it
				if (name and Buffs.BuffFilter) then
					if (not Buffs:BuffFilter(name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)) then
						name = nil
					end
				end

				if name then
					visible = visible + 1
					local visibleKey = tostring(visible)

					if (not Buffs[visibleKey]) then
						Buffs[visibleKey] = Buffs.CreateButton and Buffs:CreateButton() or CreateAuraButton(Buffs)
						if Buffs.PostCreateButton then
							Buffs:PostCreateButton(Buffs[visibleKey])
						end
					end

					local button = Buffs[visibleKey]
					if button:IsShown() then
						button:Hide() 
					end

					button:SetID(i)

					button.isBuff = true
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

					button:GetElement("Icon"):SetTexture(icon)
					button:GetElement("Count"):SetText((count > 1) and count or "")
					
					button:SetTimer(duration, expirationTime)
					
					if Buffs.PostUpdateButton then
						Buffs:PostUpdateButton(button)
					end

					if (not button:IsShown()) then
						button:Show()
					end

				end
			end

			if (visible == 0) then
				if Buffs:IsShown() then
					Buffs:Hide()
				end
			else
				local nextBuff = SetPosition(Buffs, visible) + 1
				local visibleKey = tostring(nextBuff)
				while (Buffs[visibleKey]) do
					Buffs[visibleKey]:Hide()
					Buffs[visibleKey]:SetScript("OnUpdate", nil)
					Buffs[visibleKey]:SetTimer(0,0)
					nextBuff = nextBuff + 1
					visibleKey = tostring(nextBuff)
				end
				if (not Buffs:IsShown()) then
					Buffs:Show()
				end
			end

			if Buffs.PostUpdate then
				Buffs:PostUpdate()
			end		
		end
	end

	local Debuffs = self.Debuffs
	if Debuffs then
		if not UnitExists(unit) then
			Debuffs:Hide()
		else
			local visible = 0
			local filter = Debuffs.filter

			for i = 1, DEBUFF_MAX_DISPLAY do

				local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer = UnitAura(unit, i, filter)

				if not name then
					break
				end

				-- This won't replace the normal filter, but be applied after it
				if name and Debuffs.DebuffFilter then
					local show = Debuffs:DebuffFilter(name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId, isBossDebuff, isCastByPlayer)
					if not show then
						name = nil
					end
				end

				if name then
					visible = visible + 1
					local visibleKey = tostring(visible)

					if (not Debuffs[visibleKey]) then
						Debuffs[visibleKey] = Debuffs.CreateButton and Debuffs:CreateButton() or CreateAuraButton(Debuffs)
						if Debuffs.PostCreateButton then
							Debuffs:PostCreateButton(Debuffs[visibleKey])
						end
					end

					local button = Debuffs[visibleKey]
					if button:IsShown() then
						button:Hide() 
					end

					button:SetID(i)

					button.isBuff = false
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

					button:GetElement("Icon"):SetTexture(icon)
					button:GetElement("Count"):SetText((count > 1) and count or "")
					
					button:SetTimer(duration, expirationTime)
					
					if Debuffs.PostUpdateButton then
						Debuffs:PostUpdateButton(button)
					end

					if (not button:IsShown()) then
						button:Show()
					end

				end
			end

			if (visible == 0) then
				if Debuffs:IsShown() then
					Debuffs:Hide()
				end
			else
				local nextDebuff = SetPosition(Debuffs, visible) + 1
				local visibleKey = tostring(nextDebuff)
				while (Debuffs[visibleKey]) do
					Debuffs[visibleKey]:Hide()
					Debuffs[visibleKey]:SetScript("OnUpdate", nil)
					Debuffs[visibleKey]:SetTimer(0,0)
					nextDebuff = nextDebuff + 1
					visibleKey = tostring(nextDebuff)
				end
				if (not Debuffs:IsShown()) then
					Debuffs:Show()
				end
			end

			if Debuffs.PostUpdate then
				Debuffs:PostUpdate()
			end
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
		local frequent = (Auras and Auras.frequent) or (Buffs and Buffs.frequent) or (Debuffs and Debuffs.frequent)
		if frequent then
			self:EnableFrequentUpdates("Auras", frequent)
		else
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
		end

		return true
	end
end

local Disable = function(self, unit)
	local Auras = self.Auras
	local Buffs = self.Buffs
	local Debuffs = self.Debuffs
	if Auras or Buffs or Debuffs then
		if Auras then
			Auras.unit = nil
		end
		if Buffs then
			Buffs.unit = nil
		end
		if Debuffs then
			Debuffs.unit = nil
		end
		if not ((Auras and Auras.frequent) or (Buffs and Buffs.frequent) or (Debuffs and Debuffs.frequent)) then
			self:UnregisterEvent("UNIT_AURA", Update)
			self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
			self:UnregisterEvent("UNIT_ENTERED_VEHICLE", Update)
			self:UnregisterEvent("UNIT_ENTERING_VEHICLE", Update)
			self:UnregisterEvent("UNIT_EXITING_VEHICLE", Update)
			self:UnregisterEvent("UNIT_EXITED_VEHICLE", Update)
			self:UnregisterEvent("MODIFIER_STATE_CHANGED", UpdateTooltip)

			if (unit == "target") or (unit == "targettarget") then
				self:UnregisterEvent("PLAYER_TARGET_CHANGED", Update)
			end
		end
	end
end

Handler:RegisterElement("Auras", Enable, Disable, Update)
