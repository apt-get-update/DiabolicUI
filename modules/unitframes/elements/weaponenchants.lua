local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- Weapon enchants (temporary main/off hand buffs) are displayed inline in
-- the player's Buffs container (see aura.lua), since GetWeaponEnchantInfo()
-- doesn't fire an event when a charge is consumed or a buff naturally
-- expires. This element just periodically forces that container to
-- refresh so those two cases don't leave a stale icon on screen.
local Update = function(self, event, ...)
	local Buffs = self.Buffs
	if Buffs and Buffs.ForceUpdate then
		Buffs:ForceUpdate()
	end
end

local Enable = function(self, unit)
	if self.WeaponEnchants and unit == "player" then
		self:EnableFrequentUpdates("WeaponEnchants", 1)
		return true
	end
end

local Disable = function(self, unit) end

Handler:RegisterElement("WeaponEnchants", Enable, Disable, Update)
