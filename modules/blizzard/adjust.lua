-- Moves and resizes any part by its name, as settings/positions.lua says
-- (written from windows/*.qml: tools/editor.py): once the part exists (an
-- addon's once it loads), and again each time something else moves or resizes
-- it. A part Blizzard protects waits out combat.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Adjust", "LOW")

local kit

-- Lua API
local _G = _G
local pairs = pairs
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown

local Placed, Sized = {}, {} -- the parts followed: their names (by part)
local Applying -- (our own moves, not to be undone)

-- A part's place and size: { point, relative frame's name, its point, x,
-- y, width, height } (the size if given; { width, height }: a size only).
Module.GetEntry = function(self, name)
	return self.config[name]
end

local IsPlace = function(entry)
	return entry and (type(entry[1]) == "string")
end

local SizeOf = function(entry)
	if IsPlace(entry) then
		return entry[6], entry[7]
	end
	return entry[1], entry[2]
end

-- (not in combat if it's protected: tried again after)
local CanMove = function(part)
	return not (Applying or (part.IsProtected and part:IsProtected() and InCombatLockdown()))
end

local Place = function(part)
	local entry = Module:GetEntry(Placed[part])
	if (not IsPlace(entry)) or (not CanMove(part)) then
		return
	end
	Applying = true
	local point, relative, relativePoint, x, y = unpack(entry)
	part:ClearAllPoints()
	part:SetPoint(point, _G[relative] or relative, relativePoint, x, y)
	Applying = nil
end

local Size = function(part)
	local width, height = SizeOf(Module:GetEntry(Sized[part]) or {})
	if (not width) or (not CanMove(part)) then
		return
	end
	Applying = true
	part:SetWidth(width)
	part:SetHeight(height)
	Applying = nil
end

-- `name`'s part, if it's there, followed and put in its place and size.
local Follow = function(name)
	local part = _G[name]
	local entry = Module:GetEntry(name)
	if (not part) or (not part.SetPoint) or (not entry) then
		return
	end
	if not Placed[part] then
		Placed[part] = name
		local Again = function() Place(part) end
		hooksecurefunc(part, "SetPoint", Again)
		hooksecurefunc(part, "SetAllPoints", Again)
	end
	Place(part)
	if SizeOf(entry) and (not Sized[part]) then
		Sized[part] = name
		local Again = function() Size(part) end
		hooksecurefunc(part, "SetWidth", Again)
		hooksecurefunc(part, "SetHeight", Again)
		if part.SetSize then
			hooksecurefunc(part, "SetSize", Again)
		end
	end
	Size(part)
end

Module.Apply = function(self)
	-- every part let go first: Blizzard's own anchors may chain them the
	-- other way round (the PvP Join button hangs off Cancel)
	for name in pairs(self.config) do
		local part = _G[name]
		if part and part.ClearAllPoints and IsPlace(self:GetEntry(name)) and CanMove(part) then
			part:ClearAllPoints()
		end
	end
	for name in pairs(self.config) do
		Follow(name)
	end
end

-- `part`'s place as it is: its first anchor, or (on an unnamed frame) its
-- top left from its first named parent's.
local PlaceOf = function(part)
	local point, relative, relativePoint, x, y = part:GetPoint()
	if relative and relative:GetName() then
		return { point, relative:GetName(), relativePoint, x, y }
	end
	local holder = part:GetParent()
	while holder and (not holder:GetName()) do
		holder = holder:GetParent()
	end
	holder = holder or _G.UIParent
	local scale = kit.ScaleOf(part) / holder:GetEffectiveScale()
	return { "TOPLEFT", holder:GetName(), "TOPLEFT", part:GetLeft() - holder:GetLeft() / scale,
		part:GetTop() - holder:GetTop() / scale }
end
Module.PlaceOf = PlaceOf

Module.ADDON_LOADED = function(self)
	self:Apply()
end

Module.PLAYER_REGEN_ENABLED = function(self)
	self:Apply()
end

Module.OnInit = function(self)
	self.config = self:GetDB("Positions")
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:Apply()
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end
