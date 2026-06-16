local _, Engine = ...

--
-- The intention of this file is to create consistant return values
-- across expansions for various Aura related API calls.
--
-- I'm not really a big fan of this method, since it leads to an extra function call.
-- It is however from a development point of view the easiest way to implement
-- identical behavior across the various expansions and patches.
--
-- Should be noted that the isCastByPlayer return value in Legion
-- returns true for all auras that the player CAN cast, even when cast by other players.
-- This makes it useless when trying to track our own damage debuffs on enemies.
--

-- Blizzard API
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff
local UnitHasVehicleUI = _G.UnitHasVehicleUI

--[[

	For future reference, here are the full return values of
 	the API function UnitAura for the relevant client patches.

	Legion 7.0.3:
	-----------------------------------------------------------------
	*note that in 7.0.3 the icon return value is a fileID, not a file path.
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, ... = UnitAura("unit", index[, "filter"])


	MOP 5.1.0:
	-----------------------------------------------------------------
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, shouldConsolidate, spellId, canApplyAura, isBossDebuff, isCastByPlayer = UnitAura(unit, index, filter)


	Cata 4.2.0:
	-----------------------------------------------------------------
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, value1, value2, value3 = UnitAura(unit, index, filter)


	WotLK 3.3.0:
	*note that prior to this patch, the shouldConsolidate and spellId return values didn't exist,
	and auras had to be recognized by their names instead.
	-----------------------------------------------------------------
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, index, filter)

]]--

local functions = {
	UnitAura = function(unit, i, filter)
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellId = UnitAura(unit, i, filter)
		return name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId,
			(unitCaster and unitCaster:find("boss")),
			(unitCaster and ((UnitHasVehicleUI("player") and unitCaster == "vehicle") or unitCaster == "player" or unitCaster == "pet"))
	end,

	UnitBuff = function(unit, i, filter)
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellId = UnitBuff(unit, i, filter)
		return name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId,
			(unitCaster and unitCaster:find("boss")),
			(unitCaster and ((UnitHasVehicleUI("player") and unitCaster == "vehicle") or unitCaster == "player" or unitCaster == "pet"))
	end,

	UnitDebuff = function(unit, i, filter)
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellId = UnitDebuff(unit, i, filter)
		return name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, spellId,
			(unitCaster and unitCaster:find("boss")),
			(unitCaster and ((UnitHasVehicleUI("player") and unitCaster == "vehicle") or unitCaster == "player" or unitCaster == "pet"))
	end
}

Engine:NewStaticConfig("Library: AuraFunctions", functions)
