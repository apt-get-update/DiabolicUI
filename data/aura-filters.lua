local _, Engine = ...

-- The purpose of this file is to unify 
-- how auras are filtered across the various modules. 
-- 
-- This database should only contain functions. 


-- Need the aura database for this one
local AuraData = Engine:GetDB("Data: Auras")

-- Need the constants for aura time limits here too
local TIME_LIMIT = Engine:GetConstant("AURA_TIME_LIMIT")
local TIME_LIMIT_LOW = Engine:GetConstant("AURA_TIME_LIMIT_LOW")


-- Various filter functions 
---------------------------------------------------------------
local unitIsPlayer = { player = true, pet = true, vehicle = true }
local unitIsImportant = { worldboss = true, rare = true, rareelite = true }

local filters = {
	-- Unit filters
	UnitIsFriendlyPlayer = 	function(unit, unitCaster) return UnitPlayerControlled(unit) and UnitIsFriend("player", unit) end,
	UnitIsHostilePlayer = 	function(unit, unitCaster) return UnitPlayerControlled(unit) and UnitIsEnemy("player", unit) end,
	UnitIsHostileNPC = 		function(unit, unitCaster) return UnitCanAttack("player", unit) and (not UnitPlayerControlled(unit)) end,
	UnitIsImportant = 		function(unit, unitCaster) 
								local level, classification = UnitLevel(unit), UnitClassification(unit)
								return (classification and unitIsImportant[classification]) or (level and level < 1)
							end,

	-- Caster filters
	CasterIsPlayer = 		function(unit, unitCaster) return unitIsPlayer[unitCaster] end,
	CasterIsUnit = 			function(unit, unitCaster) return unitCaster and ((unitCaster == unit) or UnitIsUnit(unit, unitCaster)) end,
	CasterIsVehicle = 		function(unit, unitCaster) return unitCaster and ((unitCaster == "vehicle") or UnitIsUnit("vehicle", unitCaster)) end,

	-- Aura filters 

}


Engine:NewStaticConfig("Library: AuraFilters", filters)
