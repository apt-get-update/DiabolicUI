-- Names over heads and nameplates only in combat: out of it they're off, as
-- the game's own settings, and back as they were once combat starts (set as
-- it starts, before the lockdown) and at logout, so Config.wtf keeps yours.
-- Enemy players' names stay, they're a threat in combat or not, except in a
-- sanctuary (Dalaran, Shattrath) where nobody can attack.
local _, Engine = ...
local Module = Engine:NewModule("CombatNames", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs
local table_insert = table.insert

-- WoW API
local GetCVar = _G.GetCVar
local GetZonePVPInfo = _G.GetZonePVPInfo
local InCombatLockdown = _G.InCombatLockdown
local SetCVar = _G.SetCVar

local CVARS = {
	"UnitNameOwn",
	"UnitNameNPC",
	"UnitNameNonCombatCreatureName",
	"UnitNameFriendlyPlayerName",
	"UnitNameFriendlyPetName",
	"UnitNameFriendlyGuardianName",
	"UnitNameFriendlyTotemName",
	"nameplateShowEnemies",
	"nameplateShowFriends",
}

-- In a sanctuary, the enemies' names too.
local SANCTUARY_CVARS = {
	"UnitNameEnemyPlayerName",
	"UnitNameEnemyPetName",
	"UnitNameEnemyGuardianName",
	"UnitNameEnemyTotemName",
}
for _, cvar in ipairs(CVARS) do
	table_insert(SANCTUARY_CVARS, cvar)
end

-- These names off (CVARS or SANCTUARY_CVARS), yours kept to put back.
Module.Hide = function(self, cvars)
	self.hiding = cvars
	for _, cvar in ipairs(cvars) do
		self.saved[cvar] = GetCVar(cvar)
		SetCVar(cvar, "0")
	end
end

Module.Restore = function(self)
	if not self.hiding then
		return
	end
	for _, cvar in ipairs(self.hiding) do
		SetCVar(cvar, self.saved[cvar])
	end
	self.hiding = nil
end

-- On or off as the option says, as combat is and as the zone is (the
-- options panel calls it; not "Update": that's the engine's own event
-- dispatcher).
Module.Apply = function(self)
	local cvars
	if self.db.combatNames and not InCombatLockdown() then
		cvars = (GetZonePVPInfo() == "sanctuary") and SANCTUARY_CVARS or CVARS
	end
	if cvars ~= self.hiding then
		self:Restore()
		if cvars then
			self:Hide(cvars)
		end
	end
end

Module.PLAYER_REGEN_DISABLED = function(self)
	self:Restore()
end

Module.PLAYER_REGEN_ENABLED = function(self)
	self:Apply()
end

Module.PLAYER_LOGOUT = function(self)
	self:Restore()
end

Module.OnInit = function(self)
	self.db = self:GetConfig("UnitFrames")
end

Module.OnEnable = function(self)
	self.saved = {}
	self:Apply()
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "Apply")
	self:RegisterEvent("ZONE_CHANGED", "Apply")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "Apply")
end
