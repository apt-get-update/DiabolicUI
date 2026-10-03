local _, Engine = ...

-- UnitAura, UnitBuff and UnitDebuff with two extra return values the aura
-- filters use, which the 3.3.5 client doesn't give: isBossDebuff (cast by a
-- "bossN" unit) and isCastByPlayer (cast by the player, their pet, or their
-- vehicle while they're in one).

-- Blizzard API
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff
local UnitHasVehicleUI = _G.UnitHasVehicleUI

-- UnitAura on the WotLK 3.3.5 client:
-- local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster,
--       isStealable, shouldConsolidate, spellId = UnitAura(unit, index, filter)

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
