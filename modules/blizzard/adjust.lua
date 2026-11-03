-- Moves and resizes any part by its name, as `adjust` in settings/blizzard.lua
-- says: once the part exists (an addon's once it loads), and again each time
-- something else moves or resizes it. A part Blizzard protects waits out
-- combat.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Adjust", "LOW")

local kit

-- Lua API
local _G = _G
local next = next
local pairs = pairs
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown

local Placed, Sized = {}, {} -- the parts followed (by part)
local Applying -- (our own moves, not to be undone)

-- (not in combat if it's protected: tried again after)
local CanMove = function(part)
	return not (Applying or (part.IsProtected and part:IsProtected() and InCombatLockdown()))
end

-- `place`: { point, relative frame's name, its point, x, y }.
local Place = function(part, place)
	if not CanMove(part) then
		return
	end
	Applying = true
	local point, relative, relativePoint, x, y = unpack(place)
	part:ClearAllPoints()
	part:SetPoint(point, _G[relative] or relative, relativePoint, x, y)
	Applying = nil
end

-- `size`: { width, height }.
local Size = function(part, size)
	if not CanMove(part) then
		return
	end
	Applying = true
	part:SetWidth(size[1])
	part:SetHeight(size[2])
	Applying = nil
end

Module.Apply = function(self)
	local config = self.config
	for name, place in pairs(config.places) do
		local part = _G[name]
		if part then
			if not Placed[part] then
				Placed[part] = true
				local Again = function() Place(part, place) end
				hooksecurefunc(part, "SetPoint", Again)
				hooksecurefunc(part, "SetAllPoints", Again)
			end
			Place(part, place)
		end
	end
	for name, size in pairs(config.sizes) do
		local part = _G[name]
		if part then
			if not Sized[part] then
				Sized[part] = true
				local Again = function() Size(part, size) end
				hooksecurefunc(part, "SetWidth", Again)
				hooksecurefunc(part, "SetHeight", Again)
				if part.SetSize then
					hooksecurefunc(part, "SetSize", Again)
				end
			end
			Size(part, size)
		end
	end
end

Module.ADDON_LOADED = function(self)
	self:Apply()
end

Module.PLAYER_REGEN_ENABLED = function(self)
	self:Apply()
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").adjust
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) or (not (next(self.config.places) or next(self.config.sizes))) then
		return
	end
	self:Apply()
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end
