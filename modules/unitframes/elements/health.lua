-- "Health" element: the health bar and its value text, including the dead,
-- ghost and offline states (frame.Health), and the heals on their way
-- (LibHealComm-4.0: from healers who run an addon with it, and your own).
-- Bar coloring is left to each unit's Health.PostUpdate.
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- Lua API
local _G = _G
local ipairs = ipairs

-- WoW API
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsPlayer = _G.UnitIsPlayer

-- Most frames poll their health 30 times a second ("FREQUENT"). A poll that finds
-- nothing changed skips the work, but a full refresh still happens this
-- often, for colors that change on their own (a mob getting tapped).
local IDLE_REFRESH = 0.5

-- The heals that land within this many seconds (a HoT's later ticks don't).
local INCOMING_WINDOW = 3

-- Bumped on every change LibHealComm reports, so a poll only asks it again
-- when something did change.
local HealComm = _G.LibStub and _G.LibStub("LibHealComm-4.0", true)
local healVersion = 0
if HealComm then
	local Bump = function()
		healVersion = healVersion + 1
	end
	for _, event in ipairs({
		"HealComm_HealStarted",
		"HealComm_HealUpdated",
		"HealComm_HealDelayed",
		"HealComm_HealStopped",
		"HealComm_ModifierChanged",
		"HealComm_GUIDDisappeared",
	}) do
		HealComm.RegisterCallback(Handler, event, Bump)
	end
end

local GetIncoming = function(unit)
	local guid = HealComm and UnitGUID(unit)
	if not guid then
		return 0
	end
	local amount = HealComm:GetHealAmount(guid, HealComm.ALL_HEALS, GetTime() + INCOMING_WINDOW)
	return amount and (amount * HealComm:GetHealModifier(guid)) or 0
end

local Update = function(self, event, ...)
	local Health = self.Health
	local unit = self.unit

	local curHealth = UnitHealth(unit)
	local maxHealth = UnitHealthMax(unit)
	local isUnavailable

	if UnitIsPlayer(unit) then
		if not UnitIsConnected(unit) then
			curHealth = 1
			maxHealth = 1
			isUnavailable = "offline"
		elseif UnitIsDeadOrGhost(unit) then
			curHealth = 0
			maxHealth = 0
			isUnavailable = UnitIsGhost(unit) and "ghost" or "dead"
		end
	elseif UnitIsDead(unit) then
		curHealth = 0
		maxHealth = 0
		isUnavailable = "dead"
	end

	if
		(event == "FREQUENT")
		and (unit == Health._unit)
		and (curHealth == Health._cur)
		and (maxHealth == Health._max)
		and (isUnavailable == Health._state)
		and (healVersion == Health._healVersion)
	then
		Health._idle = Health._idle + ((...) or 0)
		if Health._idle < IDLE_REFRESH then
			return
		end
	end
	Health._unit, Health._cur, Health._max, Health._state, Health._idle = unit, curHealth, maxHealth, isUnavailable, 0
	Health._healVersion = healVersion

	Health:SetMinMaxValues(0, maxHealth)
	Health:SetValue(curHealth)
	if Health.SetIncoming then
		Health:SetIncoming(isUnavailable and 0 or GetIncoming(unit))
	end

	if Health.Value then
		if isUnavailable == "offline" then
			Health.Value:SetText(PLAYER_OFFLINE)
		elseif isUnavailable then -- dead, or a ghost
			Health.Value:SetText(DEAD)
		else
			Health.Value:SetText(((curHealth == 0) or (maxHealth == 0)) and "" or curHealth)
		end
	end

	if Health.PostUpdate then
		return Health:PostUpdate(unit, curHealth, maxHealth, isUnavailable)
	end
end

local Enable = function(self)
	local Health = self.Health
	if Health then
		Health._owner = self
		-- (every frame polls its health: Health.frequent, in seconds)
		self:EnableFrequentUpdates("Health", Health.frequent)
		return true
	end
end

Handler:RegisterElement("Health", Enable, Update)
