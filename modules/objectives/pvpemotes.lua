-- Emotes at players you land the killing blow on: a /hug until the "Make Love,
-- Not Warcraft" achievement is earned, then a random emote.
local _, Engine = ...
local Module = Engine:NewModule("PvPEmotes")

-- Lua API
local _G = _G
local bit_band = bit.band
local math_random = math.random
local select = select

-- Wow API
local DoEmote = _G.DoEmote
local GetAchievementInfo = _G.GetAchievementInfo
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local COMBATLOG_OBJECT_TYPE_PLAYER = _G.COMBATLOG_OBJECT_TYPE_PLAYER

-- Obey the alphabet!
local emotes = {
	"BARK", "BECKON", "BYE", "BITE", "BONK", 
	"CACKLE", "CALM", "CHUCKLE", "COMFORT", "CUDDLE", "CURTSEY", "FLEX", 
	"GIGGLE", "GLOAT", "GRIN", "GROWL", "GUFFAW", "INSULT", "LAUGH", "LICK", 
	"MOCK", "MOO", "MOON", "MOURN", "NO", "PITY", "RASP", "ROAR", "ROFL", "RUDE", 
	"SCRATCH", "SHOO", "SIGH", "SLAP", "SMIRK", "SNARL", "SNICKER", "SNIFF", "SNUB", "SOOTHE", 
	"TAP", "TAUNT", "TEASE", "THANK", "TICKLE", "VETO", "VIOLIN", "YAWN"
}

-- The damage events whose overkill also marks a killing blow, in case
-- PARTY_KILL doesn't fire, and where their overkill is in the 3.3.5 combat
-- log (timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID,
-- destName, destFlags, then the event's own values).
local overkillIndex = {
	SWING_DAMAGE = 10, -- amount, overkill, ...
	RANGE_DAMAGE = 13, -- spellId, spellName, spellSchool, amount, overkill, ...
	SPELL_DAMAGE = 13,
	SPELL_BUILDING_DAMAGE = 13,
	SPELL_PERIODIC_DAMAGE = 13
}

Module.OnEvent = function(self, event, _, subEvent, sourceGUID, _, _, destGUID, destName, destFlags, ...)
	if (bit_band(destFlags or 0, COMBATLOG_OBJECT_TYPE_PLAYER) == 0) then
		return
	end

	local isKillingBlow
	if (subEvent == "PARTY_KILL") then
		isKillingBlow = (sourceGUID == UnitGUID("player"))
	elseif overkillIndex[subEvent] then
		local overkill = select(overkillIndex[subEvent] - 8, ...)
		isKillingBlow = overkill and (overkill > 0) and ((sourceGUID == UnitGUID("player")) or (sourceGUID == UnitGUID("pet")))
	end

	-- one emote per kill: the overkill hit and PARTY_KILL both report it
	local now = GetTime()
	if (not isKillingBlow) or ((destGUID == self.lastVictim) and (now - self.lastKillTime < 2)) then
		return
	end
	self.lastVictim, self.lastKillTime = destGUID, now

	if self.alreadyHugged or select(4, GetAchievementInfo(247)) then
		-- Fire off a random emote, to keep it interesting.
		DoEmote(emotes[math_random(1, #emotes)], destName)
	else
		-- Do a hug to attempt to get the achievement "Make love, not Warcraft".
		DoEmote("HUG", destName)

		-- Set a flag indicating we have tried it once,
		-- in case we're dealing with a bugged achievement.
		-- No point spamming hug forever when the issue requires
		-- a server restart or client relog to be fixed anyway.
		self.alreadyHugged = true
	end
end

Module.OnEnable = function(self)
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "OnEvent")
end
