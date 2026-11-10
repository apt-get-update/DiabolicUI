-- Names over heads and nameplates only in combat: out of it they're off, as
-- the game's own settings, and back as they were once combat starts (set as
-- it starts, before the lockdown) and at logout, so Config.wtf keeps yours.
-- Enemy players' names stay: they're a threat in combat or not.
local _, Engine = ...
local Module = Engine:NewModule("CombatNames", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs

-- WoW API
local GetCVar = _G.GetCVar
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

-- The names off, yours kept to put back.
Module.Hide = function(self)
	if self.hiding then
		return
	end
	self.hiding = true
	for _, cvar in ipairs(CVARS) do
		self.saved[cvar] = GetCVar(cvar)
		SetCVar(cvar, "0")
	end
end

Module.Restore = function(self)
	if not self.hiding then
		return
	end
	self.hiding = nil
	for _, cvar in ipairs(CVARS) do
		SetCVar(cvar, self.saved[cvar])
	end
end

-- On or off as the option says, and as combat is (the options panel calls it;
-- not "Update": that's the engine's own event dispatcher).
Module.Apply = function(self)
	if self.db.combatNames and not InCombatLockdown() then
		self:Hide()
	else
		self:Restore()
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
end
