-- "CastBar" element: cast and channel bars with spell name, timer and, on the
-- player's own bar, the latency (frame.CastBar, with the optional .Name,
-- .Value and .SafeZone).
local _, Engine = ...
local L = Engine:GetLocale()
local Handler = Engine:GetHandler("UnitFrame")

-- Lua API
local _G = _G
local math_floor = math.floor
local pairs = pairs
local select = select

-- WoW API
local CreateFrame = _G.CreateFrame
local GetNetStats = _G.GetNetStats
local GetSpellInfo = _G.GetSpellInfo
local GetTime = _G.GetTime
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitExists = _G.UnitExists
local UnitIsUnit = _G.UnitIsUnit

-- How many times a channel ticks, by a spell ID of it (any rank has its name).
local CHANNEL_TICKS = {
	[1120] = 5, -- Drain Soul
	[689] = 5, -- Drain Life
	[5138] = 5, -- Drain Mana
	[5740] = 4, -- Rain of Fire
	[755] = 10, -- Health Funnel
	[1949] = 15, -- Hellfire
	[740] = 4, -- Tranquility
	[16914] = 10, -- Hurricane
	[15407] = 3, -- Mind Flay
	[48045] = 5, -- Mind Sear
	[47540] = 2, -- Penance (its first bolt leaves at the start)
	[64843] = 4, -- Divine Hymn
	[64901] = 4, -- Hymn of Hope
	[5143] = 5, -- Arcane Missiles
	[10] = 8, -- Blizzard
	[12051] = 4, -- Evocation
	[1510] = 6, -- Volley
	[42650] = 8, -- Army of the Dead
}

local TICK_WIDTH = 2

local CastData = {}
local CastBarPool = {}

local CastTimer = CreateFrame("Frame")

-- Speeeeed!
local day = L["d"]
local hour = L["h"]
local minute = L["m"]
local second = L["s"]

-- Time constants
local DAY, HOUR, MINUTE = 86400, 3600, 60

local formatTime = function(time)
	if time > DAY then -- more than a day
		return ("%1d%s"):format(math_floor(time / DAY), day)
	elseif time > HOUR then -- more than an hour
		return ("%1d%s"):format(math_floor(time / HOUR), hour)
	elseif time > MINUTE then -- more than a minute
		return ("%1d%s %d%s"):format(math_floor(time / MINUTE), minute, math_floor(time % MINUTE), second)
	elseif time > 10 then -- more than 10 seconds
		return ("%d%s"):format(math_floor(time), second)
	elseif time > 0 then
		return ("%.1f"):format(time)
	else
		return ""
	end
end

local utf8sub = function(str, i, dots)
	if not str then
		return
	end
	local bytes = str:len()
	if bytes <= i then
		return str
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = str:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then
				break
			end
		end
		if len == i and pos <= bytes then
			return str:sub(1, pos - 1) .. (dots and "..." or "")
		else
			return str
		end
	end
end

-- Empties and hides a bar whose cast or channel is over.
local Stop = function(CastBar, castdata)
	castdata.casting = nil
	castdata.castID = nil
	castdata.channeling = nil
	castdata.tradeskill = nil
	castdata.sinceText = nil
	CastBar:Clear()
	CastBar:Hide()
end

-- The end of the player's own cast bar that the latency takes up: the
-- next spell can be queued from there on. (Not for channels: the bar's
-- right end is their start.)
local UpdateSafeZone = function(CastBar, unit, castdata)
	local SafeZone = CastBar.SafeZone
	if not SafeZone then
		return
	end
	local _, _, latency = GetNetStats() -- in milliseconds
	if (unit ~= "player") or not castdata.casting or (latency == 0) then
		SafeZone:Hide()
		return
	end
	local share = (latency / 1e3) / castdata.max
	if share > 1 then
		share = 1
	end
	SafeZone:SetWidth(CastBar:GetWidth() * share)
	SafeZone:Show()
end

-- The same table by spell name, built when the first channel asks.
local ticksByName
local GetChannelTicks = function(name)
	if not ticksByName then
		ticksByName = {}
		for spellID, ticks in pairs(CHANNEL_TICKS) do
			local spellName = GetSpellInfo(spellID)
			if spellName then
				ticksByName[spellName] = ticks
			end
		end
	end
	return ticksByName[name]
end

-- Marks the ticks still to come on a bar with .Ticks (the player's). A
-- channel's bar empties towards its left, so they're counted from the right;
-- by the interval rather than as equal parts, because pushback cuts the
-- channel's end off and leaves the ticks before it where they were.
local PlaceTicks = function(CastBar, castdata)
	local Ticks = CastBar.Ticks
	if not Ticks then
		return
	end
	local interval, shown = castdata.tickInterval, 0
	if interval then
		local width, height = CastBar:GetWidth(), CastBar:GetHeight()
		local time = interval
		while time < castdata.max - 1e-3 do
			shown = shown + 1
			local tick = Ticks[shown]
			if not tick then
				tick = CastBar:CreateTexture(nil, "OVERLAY")
				tick:SetTexture(0, 0, 0, 0.7)
				Ticks[shown] = tick
			end
			tick:SetSize(TICK_WIDTH, height)
			tick:SetPoint("RIGHT", -(width * time / castdata.max), 0)
			tick:Show()
			time = time + interval
		end
	end
	for i = shown + 1, #Ticks do
		Ticks[i]:Hide()
	end
end

-- The bar moves every frame; its time text (tenths of a second at most)
-- and the latency's safe zone only this often. A new, delayed or changed
-- cast writes them on its next frame.
local TEXT_INTERVAL = 0.1

-- Whether the text is due, counting this frame.
local TextDue = function(castdata, elapsed)
	local since = castdata.sinceText
	if since and (since + elapsed < TEXT_INTERVAL - 1e-6) then -- (frame times add up a hair short)
		castdata.sinceText = since + elapsed
		return false
	end
	castdata.sinceText = 0
	return true
end

-- Proxy function to allow us to exit the update by returning,
-- but still continue looping through the remaining castbars, if any!
local UpdateCastBar = function(CastBar, unit, castdata, elapsed)
	if not UnitExists(unit) then
		return Stop(CastBar, castdata)
	end
	if castdata.casting or castdata.tradeskill then
		local duration = castdata.duration + elapsed
		if duration >= castdata.max then
			Stop(CastBar, castdata)
		end
		local textDue = TextDue(castdata, elapsed)
		if textDue then
			UpdateSafeZone(CastBar, unit, castdata)
		end
		if CastBar.Value and textDue then
			if castdata.tradeskill then
				CastBar.Value:SetText(formatTime(castdata.max - duration))
			elseif castdata.delay and castdata.delay ~= 0 then
				CastBar.Value:SetFormattedText(
					"%s|cffff0000 -%s|r",
					formatTime(math_floor(castdata.max - duration)),
					formatTime(castdata.delay)
				)
			else
				CastBar.Value:SetText(formatTime(castdata.max - duration))
			end
		end
		castdata.duration = duration
		CastBar:SetValue(duration)
	elseif castdata.channeling then
		local duration = castdata.duration - elapsed
		if duration <= 0 then
			Stop(CastBar, castdata)
		end
		if CastBar.Value and TextDue(castdata, elapsed) then
			if castdata.delay and castdata.delay ~= 0 then
				CastBar.Value:SetFormattedText("%.1f|cffff0000-%.1f|r", duration, castdata.delay)
			else
				CastBar.Value:SetFormattedText("%.1f", duration)
			end
		end
		castdata.duration = duration
		CastBar:SetValue(duration)
	end
end

-- Only bars with a cast running need a tick. (A bar shows only while one
-- does: Stop hides it.)
local OnUpdate = function(self, elapsed)
	for owner, CastBar in pairs(CastBarPool) do
		local castdata = CastData[CastBar]
		if castdata.casting or castdata.channeling or castdata.tradeskill then
			UpdateCastBar(CastBar, owner.unit, castdata, elapsed)
		end
	end
end
CastTimer:SetScript("OnUpdate", OnUpdate)
Handler.CastTimer = CastTimer -- (named in /dui cpu)

local Update -- so we can call it from within itself
Update = function(self, event, ...)
	local arg1 = ...
	local unit = self.unit
	-- (only the unit change events at the end come without a unit)
	if arg1 and not UnitIsUnit(unit, arg1) then
		return
	end

	local CastBar = self.CastBar
	local castdata = CastData[CastBar]
	if event == "UNIT_SPELLCAST_START" then
		local unit = ...
		local name, _, text, _, startTime, endTime, isTradeSkill, castID = UnitCastingInfo(unit)
		if not name then
			CastBar:Clear()
			CastBar:Hide()
			return
		end
		endTime = endTime / 1e3
		startTime = startTime / 1e3

		castdata.castID = castID
		castdata.duration = GetTime() - startTime
		castdata.max = endTime - startTime
		castdata.delay = 0
		castdata.sinceText = nil
		castdata.casting = true
		castdata.channeling = nil
		castdata.tradeskill = isTradeSkill
		castdata.tickInterval = nil
		PlaceTicks(CastBar, castdata)

		CastBar:SetMinMaxValues(0, castdata.max)
		CastBar:SetValue(castdata.duration)

		if CastBar.Name then
			CastBar.Name:SetText(utf8sub(text, 32, true))
		end
		if CastBar.Value then
			CastBar.Value:SetText("")
		end
		UpdateSafeZone(CastBar, unit, castdata)

		CastBar:Show()

	-- (the 4th argument of these is the cast's ID)
	elseif
		(event == "UNIT_SPELLCAST_FAILED")
		or (event == "UNIT_SPELLCAST_STOP")
		or (event == "UNIT_SPELLCAST_INTERRUPTED")
	then
		if castdata.castID == select(4, ...) then
			Stop(CastBar, castdata)
		end
	elseif event == "UNIT_SPELLCAST_DELAYED" then
		local unit = ...
		local _, _, _, _, startTime = UnitCastingInfo(unit)
		if not startTime or not castdata.duration then
			return
		end
		local duration = GetTime() - (startTime / 1000)
		if duration < 0 then
			duration = 0
		end
		castdata.delay = (castdata.delay or 0) + castdata.duration - duration
		castdata.sinceText = nil
		castdata.duration = duration
		CastBar:SetValue(duration)
	elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
		local unit = ...
		local name, _, _, _, startTime, endTime = UnitChannelInfo(unit)
		if not name then
			CastBar:Clear()
			CastBar:Hide()
			return
		end

		endTime = endTime / 1e3
		startTime = startTime / 1e3

		castdata.duration = endTime - GetTime()
		castdata.max = endTime - startTime
		castdata.delay = 0
		castdata.sinceText = nil
		castdata.channeling = true
		castdata.casting = nil
		castdata.castID = nil
		castdata.tradeskill = nil

		local ticks = CastBar.Ticks and (unit == "player") and GetChannelTicks(name)
		castdata.tickInterval = ticks and (castdata.max / ticks) or nil
		PlaceTicks(CastBar, castdata)

		CastBar:SetMinMaxValues(0, castdata.max)
		CastBar:SetValue(castdata.duration)

		if CastBar.Name then
			CastBar.Name:SetText(utf8sub(name, 32, true))
		end
		if CastBar.Value then
			CastBar.Value:SetText("")
		end
		UpdateSafeZone(CastBar, unit, castdata)

		CastBar:Show()
	elseif event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
		local unit = ...
		local name, _, _, _, startTime, endTime = UnitChannelInfo(unit)
		if not name or not castdata.duration then
			return
		end
		local duration = (endTime / 1000) - GetTime()
		castdata.delay = (castdata.delay or 0) + castdata.duration - duration
		castdata.sinceText = nil
		castdata.duration = duration
		castdata.max = (endTime - startTime) / 1000
		PlaceTicks(CastBar, castdata)
		CastBar:SetMinMaxValues(0, castdata.max)
		CastBar:SetValue(duration)
	elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
		if CastBar:IsShown() then
			Stop(CastBar, castdata)
		end
	else
		-- The unit may have changed (UNIT_TARGET, PLAYER_TARGET_CHANGED,
		-- PLAYER_FOCUS_CHANGED): show whatever it's casting now. Also on
		-- PLAYER_ENTERING_WORLD, what the frame updates with when it shows:
		-- a frame that was hidden when its unit changed missed that event.
		if not UnitExists(unit) then
			return
		end
		if UnitCastingInfo(unit) then
			return Update(self, "UNIT_SPELLCAST_START", unit)
		end
		if UnitChannelInfo(unit) then
			return Update(self, "UNIT_SPELLCAST_CHANNEL_START", unit)
		end
		Stop(CastBar, castdata)
	end
end

local Enable = function(self, unit)
	local CastBar = self.CastBar
	if CastBar then
		if not CastData[CastBar] then
			CastData[CastBar] = {}
		end
		if not CastBarPool[self] then
			CastBarPool[self] = CastBar
		end
		self:RegisterEvent("UNIT_SPELLCAST_START", Update)
		self:RegisterEvent("UNIT_SPELLCAST_FAILED", Update)
		self:RegisterEvent("UNIT_SPELLCAST_STOP", Update)
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", Update)
		self:RegisterEvent("UNIT_SPELLCAST_DELAYED", Update)
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", Update)
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", Update)
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", Update)
		self:RegisterEvent("UNIT_TARGET", Update)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)
		self:RegisterEvent("PLAYER_FOCUS_CHANGED", Update)

		return true
	end
end

Handler:RegisterElement("CastBar", Enable, Update)
