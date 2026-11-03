-- Moves and resizes any part by its name, as `adjust` in settings/blizzard.lua
-- says: once the part exists (an addon's once it loads), and again each time
-- something else moves or resizes it. A part Blizzard protects waits out
-- combat. /dui adjust moves them in game: hover a part, drag it or nudge it
-- with the arrow keys; saved in DiabolicUI_Layout.adjust (WTF, after a
-- /reload), to copy into the settings.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Adjust", "LOW")
local L = Engine:GetLocale()

local kit

-- Lua API
local _G = _G
local pairs = pairs
local string_format = string.format
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCursorPosition = _G.GetCursorPosition
local GetMouseFocus = _G.GetMouseFocus
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local IsShiftKeyDown = _G.IsShiftKeyDown

local Saved -- DiabolicUI_Layout.adjust: { places, sizes }, what was moved in game
local Placed, Sized = {}, {} -- the parts followed: their names (by part)
local Applying -- (our own moves, not to be undone)

local NUDGE, BIG_NUDGE = 1, 10 -- an arrow key's move, with Shift

-- A part's place and size: moved in game, else the settings'.
Module.GetPlace = function(self, name)
	return Saved.places[name] or self.config.places[name]
end

Module.GetSize = function(self, name)
	return Saved.sizes[name] or self.config.sizes[name]
end

-- (not in combat if it's protected: tried again after)
local CanMove = function(part)
	return not (Applying or (part.IsProtected and part:IsProtected() and InCombatLockdown()))
end

-- Its place: { point, relative frame's name, its point, x, y }.
local Place = function(part)
	local place = Module:GetPlace(Placed[part])
	if (not place) or (not CanMove(part)) then
		return
	end
	Applying = true
	local point, relative, relativePoint, x, y = unpack(place)
	part:ClearAllPoints()
	part:SetPoint(point, _G[relative] or relative, relativePoint, x, y)
	Applying = nil
end

-- Its size: { width, height }.
local Size = function(part)
	local size = Module:GetSize(Sized[part])
	if (not size) or (not CanMove(part)) then
		return
	end
	Applying = true
	part:SetWidth(size[1])
	part:SetHeight(size[2])
	Applying = nil
end

-- `name`'s part, if it's there, followed and put in its place and size.
local Follow = function(name)
	local part = _G[name]
	if (not part) or (not part.SetPoint) then
		return
	end
	if Module:GetPlace(name) then
		if not Placed[part] then
			Placed[part] = name
			local Again = function() Place(part) end
			hooksecurefunc(part, "SetPoint", Again)
			hooksecurefunc(part, "SetAllPoints", Again)
		end
		Place(part)
	end
	if Module:GetSize(name) then
		if not Sized[part] then
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
end

Module.Apply = function(self)
	for _, list in pairs({ self.config.places, self.config.sizes, Saved.places, Saved.sizes }) do
		for name in pairs(list) do
			Follow(name)
		end
	end
end

-- Moving in game (/dui adjust)
-------------------------------------------------------

-- The named part under the mouse (or the first named one holding it).
local Hovered = function()
	local part = GetMouseFocus()
	while part and (not part:GetName()) do
		part = part:GetParent()
	end
	if part and (part ~= _G.UIParent) and (part ~= _G.WorldFrame) and (part ~= Module.Box) then
		return part
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
	local scale = part:GetEffectiveScale() / holder:GetEffectiveScale()
	return { "TOPLEFT", holder:GetName(), "TOPLEFT", part:GetLeft() - holder:GetLeft() / scale,
		part:GetTop() - holder:GetTop() / scale }
end

local Describe = function(name)
	local point, relative, relativePoint, x, y = unpack(Module:GetPlace(name))
	return string_format("%s: %s on %s %s %.0f, %.0f", name, point, relative, relativePoint, x, y)
end

-- `part` moved by `dx`, `dy` from `from` (its place when the move began),
-- saved; one placed by two points keeps its size.
local Move = function(part, from, dx, dy)
	local name = part:GetName()
	if (part:GetNumPoints() > 1) and (not Module:GetSize(name)) then
		Saved.sizes[name] = { part:GetWidth(), part:GetHeight() }
	end
	Saved.places[name] = { from[1], from[2], from[3], from[4] + dx, from[5] + dy }
	Follow(name)
end

-- The box over the part hovered: it takes the drags, the arrow keys
-- and right-clicks.
local CreateBox = function(self)
	local box = CreateFrame("Frame", nil, _G.UIParent)
	box:SetFrameStrata("TOOLTIP")
	box:SetBackdrop({ edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1 })
	box:SetBackdropBorderColor(1, .6, .15, 1)
	box:EnableMouse(true)
	box:EnableKeyboard(true)
	box.Name = box:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	box.Name:SetPoint("BOTTOMLEFT", box, "TOPLEFT", 0, 2)
	box:Hide()
	box:SetScript("OnLeave", function()
		if not box.Drag then
			box:Hide()
		end
	end)
	box:SetScript("OnMouseDown", function(_, button)
		local part = box.Part
		if (button == "RightButton") then
			local name = part:GetName()
			Saved.places[name], Saved.sizes[name] = nil, nil
			Place(part) -- (the settings' place, if they give one)
			Size(part)
			self:Print(string_format(L["%s put back (as it was at login: /reload)."], name))
			return
		end
		local x, y = GetCursorPosition()
		box.Drag = { x, y, PlaceOf(part) }
	end)
	box:SetScript("OnMouseUp", function()
		if box.Drag then
			box.Drag = nil
			self:Print(Describe(box.Part:GetName()))
		end
	end)
	box:SetScript("OnUpdate", function()
		local drag, part = box.Drag, box.Part
		if drag and CanMove(part) then
			local x, y = GetCursorPosition()
			local scale = part:GetEffectiveScale()
			Move(part, drag[3], (x - drag[1]) / scale, (y - drag[2]) / scale)
		end
	end)
	box:SetScript("OnKeyDown", function(_, key)
		local step = IsShiftKeyDown() and BIG_NUDGE or NUDGE
		local dx = (key == "LEFT" and -step) or (key == "RIGHT" and step) or 0
		local dy = (key == "DOWN" and -step) or (key == "UP" and step) or 0
		if (key == "ESCAPE") then
			self:Toggle()
		elseif ((dx ~= 0) or (dy ~= 0)) and CanMove(box.Part) then
			Move(box.Part, PlaceOf(box.Part), dx, dy)
			self:Print(Describe(box.Part:GetName()))
		end
	end)
	return box
end

-- The box over what's hovered, each frame.
local Watch = function()
	local box = Module.Box
	if box:IsShown() then
		return
	end
	local part = Hovered()
	if part then
		box.Part = part
		box:ClearAllPoints()
		box:SetAllPoints(part)
		box.Name:SetText(part:GetName())
		box:Show()
	end
end

Module.Print = function(self, text)
	_G.DEFAULT_CHAT_FRAME:AddMessage("|cffff8000DiabolicUI|r " .. text)
end

Module.Toggle = function(self)
	if self.Watcher:IsShown() then
		self.Watcher:Hide()
		self.Box:Hide()
		self:Print(L["Adjust off. /reload to write what you moved."])
	elseif InCombatLockdown() then
		self:Print(L["Not in combat."])
	else
		self.Watcher:Show()
		self:Print(L["Adjust on: hover a part, drag it or nudge it with the arrow keys (Shift: 10), right-click to put it back. Escape to stop."])
	end
end

Module.ADDON_LOADED = function(self)
	self:Apply()
end

Module.PLAYER_REGEN_ENABLED = function(self)
	self:Apply()
end

Module.PLAYER_REGEN_DISABLED = function(self)
	if self.Watcher:IsShown() then
		self:Toggle()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").adjust
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	local layout = _G.DiabolicUI_Layout or {}
	_G.DiabolicUI_Layout = layout
	layout.adjust = layout.adjust or {}
	Saved = layout.adjust
	Saved.places, Saved.sizes = Saved.places or {}, Saved.sizes or {}
	self.Box = CreateBox(self)
	self.Watcher = CreateFrame("Frame")
	self.Watcher:Hide()
	self.Watcher:SetScript("OnUpdate", Watch)
	self:Apply()
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:GetHandler("ChatCommand"):Register("adjust", function() self:Toggle() end)
end
