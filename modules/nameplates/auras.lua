-- Your auras on the nameplates (the "NamePlates" module, nameplates.lua),
-- as Kui Nameplates' Auras plugin shows them: your debuffs on enemies, your
-- buffs on friends, with the time left, in a row above the plate, in the
-- unit frames' aura look (units/shared.lua's PostCreateAuraButton).
--
-- 3.3.5's plates have no unit: a plate learns its unit's GUID while it's
-- the target's or the mouseover's, or from its name when no other plate
-- shown has it. The auras are read from the units the client names
-- (target, focus, mouseover, party...), kept by GUID, and the combat log
-- adds and removes yours on units it doesn't name.
local _, Engine = ...
local Module = Engine:GetModule("NamePlates")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local math_floor = math.floor
local pairs = pairs
local math_min = math.min
local table_sort = table.sort
local unpack = unpack
local wipe = _G.wipe

-- WoW API
local GetSpellInfo = _G.GetSpellInfo
local GetTime = _G.GetTime
local UnitAura = _G.UnitAura
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitIsFriend = _G.UnitIsFriend
local UnitName = _G.UnitName

local DAY, HOUR, MINUTE = 86400, 3600, 60

-- how often the time left is written again
local TIMER_HZ = .1

-- yours, from the combat log
local ADDED = { SPELL_AURA_APPLIED = true, SPELL_AURA_REFRESH = true, SPELL_AURA_APPLIED_DOSE = true }
local REMOVED = { SPELL_AURA_REMOVED = true, SPELL_AURA_BROKEN = true, SPELL_AURA_BROKEN_SPELL = true }
local DIED = { UNIT_DIED = true, UNIT_DESTROYED = true }

-- [guid] = { [spellId] = { icon, count, duration, expirationTime } }
local Auras = {}
local PLAYER_GUID

local formatTime = function(time)
	if time >= DAY then
		return ("%d%s"):format(math_floor(time / DAY), L["d"])
	elseif time >= HOUR then
		return ("%d%s"):format(math_floor(time / HOUR), L["h"])
	elseif time >= MINUTE then
		return ("%d%s"):format(math_floor(time / MINUTE), L["m"])
	elseif time >= 10 then
		return ("%d"):format(time)
	elseif time > 0 then
		return ("%.1f"):format(time)
	end
	return ""
end

-- The aura buttons --------------------------------------------------------

local UpdateTimer = function(button, elapsed)
	button.elapsed = (button.elapsed or 0) + elapsed
	if (button.elapsed < TIMER_HZ) then
		return
	end
	button.elapsed = 0
	local timeLeft = button.expirationTime - GetTime()
	if (timeLeft > 0) then
		button.Time:SetText(formatTime(timeLeft))
	else
		-- run out: gone from the plate
		local plate = button.plate
		local auras = plate.guid and Auras[plate.guid]
		if auras then
			auras[button.spellId] = nil
		end
		Module:UpdatePlateAuras(plate)
	end
end

local CreateButton = function(plate)
	local config = plate.config.widgets.auras
	local button = plate.Auras:CreateFrame("Frame")
	button:SetSize(unpack(config.size))
	button.plate = plate

	-- units/shared.lua's aura look: a 1px border and darkened backdrop, a
	-- glow around it, the icon shaded and dimmed a little
	local r, g, b = unpack(config.color)
	local scaffold = button:CreateFrame()
	scaffold:SetAllPoints()
	scaffold:SetFrameLevel(button:GetFrameLevel() + 1)
	scaffold:SetBackdrop(config.border)
	scaffold:SetBackdropColor(r/3, g/3, b/3)
	scaffold:SetBackdropBorderColor(r, g, b)

	local glow = button:CreateFrame()
	glow:SetFrameLevel(button:GetFrameLevel())
	glow:SetPoint("TOPLEFT", scaffold, "TOPLEFT", -4, 4)
	glow:SetPoint("BOTTOMRIGHT", scaffold, "BOTTOMRIGHT", 3, -3)
	glow:SetBackdrop(config.glow)
	glow:SetBackdropBorderColor(r/3, g/3, b/3, .75)

	local icon = scaffold:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("TOPLEFT", 2, -2)
	icon:SetPoint("BOTTOMRIGHT", -2, 2)
	icon:SetTexCoord(5/64, 59/64, 5/64, 59/64)
	icon:SetVertexColor(.85, .85, .85)

	local shade = scaffold:CreateTexture(nil, "OVERLAY")
	shade:SetAllPoints(icon)
	shade:SetTexture(config.shade)
	shade:SetVertexColor(0, 0, 0, 1)

	local overlay = button:CreateFrame()
	overlay:SetFrameLevel(button:GetFrameLevel() + 2)
	overlay:SetAllPoints()

	local time = overlay:CreateFontString(nil, "OVERLAY")
	time:SetFontObject(config.timeFont)
	time:SetPoint("CENTER", icon, "CENTER", 0, 0)

	local count = overlay:CreateFontString(nil, "OVERLAY")
	count:SetFontObject(config.countFont)
	count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)

	button.Icon, button.Time, button.Count = icon, time, count
	return button
end

-- the shortest first, those without a time last
local SortAuras = function(a, b)
	local ta, tb = a.expirationTime, b.expirationTime
	if (ta > 0) ~= (tb > 0) then
		return ta > 0
	end
	return ta < tb
end

-- The plate's buttons for what's kept for its unit, in a row centered over it.
Module.UpdatePlateAuras = function(self, plate)
	local holder = plate.Auras
	local config = plate.config.widgets.auras
	local list = holder.list
	wipe(list)

	local auras = plate.guid and Auras[plate.guid]
	if auras then
		local now = GetTime()
		for spellId, aura in pairs(auras) do
			if (aura.expirationTime > 0) and (aura.expirationTime <= now) then
				auras[spellId] = nil
			else
				aura.spellId = spellId
				list[#list + 1] = aura
			end
		end
		table_sort(list, SortAuras)
	end

	local shown = math_min(#list, config.max)
	local width, spacing = config.size[1], config.spacing
	local left = -(shown * width + (shown - 1) * spacing) / 2
	for i = 1, shown do
		local aura = list[i]
		local button = holder[i] or CreateButton(plate)
		holder[i] = button
		button.spellId = aura.spellId
		button.Icon:SetTexture(aura.icon)
		button.Count:SetText((aura.count and aura.count > 1) and aura.count or "")
		button:ClearAllPoints()
		button:SetPoint("BOTTOMLEFT", holder, "BOTTOM", left + (i - 1) * (width + spacing), 0)
		if (aura.expirationTime > 0) then
			button.expirationTime = aura.expirationTime
			button.elapsed = TIMER_HZ -- written straight away
			button:SetScript("OnUpdate", UpdateTimer)
		else
			button.Time:SetText("")
			button:SetScript("OnUpdate", nil)
		end
		button:Show()
	end
	for i = shown + 1, #holder do
		holder[i]:SetScript("OnUpdate", nil)
		holder[i]:Hide()
	end
end

Module.CreateAuras = function(self, plate)
	local config = plate.config.widgets.auras
	local holder = plate:CreateFrame("Frame")
	holder:SetSize(1, config.size[2])
	holder:SetPoint(unpack(config.place))
	holder.list = {}
	plate.Auras = holder
end

-- Plates and units --------------------------------------------------------

-- the shown plate with this GUID
local PlateByGUID = function(guid)
	for plate, baseFrame in pairs(Module.visiblePlates) do
		if baseFrame and (plate.guid == guid) then
			return plate
		end
	end
end

-- the only shown plate with this name, if only one has it
local PlateByName = function(name)
	local found
	for plate, baseFrame in pairs(Module.visiblePlates) do
		if baseFrame and (plate.info.name == name) then
			if found then
				return
			end
			found = plate
		end
	end
	return found
end

-- The plate learns its unit: the auras kept for it show.
Module.SetPlateGUID = function(self, plate, guid)
	if (plate.guid == guid) then
		return
	end
	local other = guid and PlateByGUID(guid)
	if other then
		other.guid = nil
		self:UpdatePlateAuras(other)
	end
	plate.guid = guid
	self:UpdatePlateAuras(plate)
end

-- A unit's plate: the one that already knows it, the target's, the
-- mouseover's (Blizzard's highlight shows on it), or the only one with its name.
local PlateForUnit = function(unit, guid)
	local plate = PlateByGUID(guid)
	if plate then
		return plate
	end
	for p, baseFrame in pairs(Module.visiblePlates) do
		if baseFrame and (((unit == "target") and p.info.isTarget) or ((unit == "mouseover") and p.old.regions.highlight:IsShown())) then
			plate = p
			break
		end
	end
	plate = plate or PlateByName(UnitName(unit))
	if plate then
		Module:SetPlateGUID(plate, guid)
	end
	return plate
end

-- Each update: the target's and the mouseover's plates know who they are.
Module.UpdatePlateUnit = function(self, plate)
	local unit
	if plate.info.isTarget then
		unit = "target"
	elseif plate.old.regions.highlight:IsShown() then
		unit = "mouseover"
	end
	local guid = unit and UnitExists(unit) and UnitGUID(unit)
	if guid and (plate.guid ~= guid) then
		self:SetPlateGUID(plate, guid)
		self:ScanUnit(unit)
	end
end

Module.ClearPlateAuras = function(self, plate)
	plate.guid = nil
	self:UpdatePlateAuras(plate)
end

-- What a unit has of yours, read again, and shown on its plate.
Module.ScanUnit = function(self, unit)
	local guid = UnitExists(unit) and UnitGUID(unit)
	if not guid then
		return
	end
	local auras = Auras[guid] or {}
	Auras[guid] = auras
	wipe(auras)
	local filter = UnitIsFriend("player", unit) and "HELPFUL|PLAYER" or "HARMFUL|PLAYER"
	for i = 1, 40 do
		local name, _, icon, count, _, duration, expirationTime, _, _, _, spellId = UnitAura(unit, i, filter)
		if not name then
			break
		end
		auras[spellId] = { icon = icon, count = count, duration = duration or 0, expirationTime = expirationTime or 0 }
	end
	local plate = PlateForUnit(unit, guid)
	if plate then
		self:UpdatePlateAuras(plate)
	end
end

-- Events ------------------------------------------------------------------

Module.OnAuraEvent = function(self, event, ...)
	if (event == "UNIT_AURA") then
		self:ScanUnit((...))
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		self:ScanUnit("mouseover")
	elseif (event == "PLAYER_FOCUS_CHANGED") then
		self:ScanUnit("focus")
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local _, logEvent, sourceGUID, _, _, destGUID, _, _, spellId = ...
		if DIED[logEvent] then
			Auras[destGUID] = nil
			local plate = PlateByGUID(destGUID)
			if plate then
				self:UpdatePlateAuras(plate)
			end
			return
		end
		if (sourceGUID ~= PLAYER_GUID) or not (ADDED[logEvent] or REMOVED[logEvent]) then
			return
		end
		local auras = Auras[destGUID]
		if REMOVED[logEvent] then
			if auras then
				auras[spellId] = nil
			end
		else
			-- read from the unit when the client names it (UNIT_AURA does
			-- that), timed again by the duration it had, or shown without one
			auras = auras or {}
			Auras[destGUID] = auras
			local aura = auras[spellId]
			if aura and (aura.duration > 0) then
				aura.expirationTime = GetTime() + aura.duration
			elseif not aura then
				local _, _, icon = GetSpellInfo(spellId)
				auras[spellId] = { icon = icon, count = 1, duration = 0, expirationTime = 0 }
			end
		end
		local plate = PlateByGUID(destGUID)
		if plate then
			self:UpdatePlateAuras(plate)
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		PLAYER_GUID = UnitGUID("player")
		wipe(Auras)
	end
end

Module.EnableAuras = function(self)
	PLAYER_GUID = UnitGUID("player")
	self:RegisterEvent("UNIT_AURA", "OnAuraEvent")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "OnAuraEvent")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "OnAuraEvent")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "OnAuraEvent")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnAuraEvent")
end
