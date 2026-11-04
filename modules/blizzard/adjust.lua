-- Moves and resizes any part by its name, as settings/positions.lua
-- says: once the part exists (an addon's once it loads), and again each time
-- something else moves or resizes it. A part Blizzard protects waits out
-- combat. /dui adjust moves them in game: hover a part, drag it or nudge it
-- with the arrow keys, Ctrl + arrows to resize it; saved in
-- DiabolicUI_Layout.moved (WTF, after a /reload), which tools/positions.lua
-- writes into the settings.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Adjust", "LOW")
local L = Engine:GetLocale()

local kit

-- Lua API
local _G = _G
local math_huge = math.huge
local math_max = math.max
local pairs = pairs
local select = select
local string_find = string.find
local string_format = string.format
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCursorPosition = _G.GetCursorPosition
local GetMouseFocus = _G.GetMouseFocus
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local IsControlKeyDown = _G.IsControlKeyDown
local IsShiftKeyDown = _G.IsShiftKeyDown

local Saved -- DiabolicUI_Layout.moved: what was moved in game, as settings/positions.lua's
local Placed, Sized = {}, {} -- the parts followed: their names (by part)
local Applying -- (our own moves, not to be undone)

local NUDGE, BIG_NUDGE = 1, 10 -- an arrow key's move, with Shift

-- A part's place and size, { point, relative frame's name, its point, x,
-- y, width, height } (the size if given): moved in game, else the settings'.
Module.GetEntry = function(self, name)
	return Saved[name] or self.config[name]
end

-- (not in combat if it's protected: tried again after)
local CanMove = function(part)
	return not (Applying or (part.IsProtected and part:IsProtected() and InCombatLockdown()))
end

local Place = function(part)
	local entry = Module:GetEntry(Placed[part])
	if (not entry) or (not CanMove(part)) then
		return
	end
	Applying = true
	local point, relative, relativePoint, x, y = unpack(entry)
	part:ClearAllPoints()
	part:SetPoint(point, _G[relative] or relative, relativePoint, x, y)
	Applying = nil
end

local Size = function(part)
	local entry = Module:GetEntry(Sized[part])
	if (not entry) or (not entry[6]) or (not CanMove(part)) then
		return
	end
	Applying = true
	part:SetWidth(entry[6])
	part:SetHeight(entry[7])
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
	if entry[6] and (not Sized[part]) then
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
	for _, list in pairs({ self.config, Saved }) do
		for name in pairs(list) do
			Follow(name)
		end
	end
end

-- Moving in game (/dui adjust)
-------------------------------------------------------

-- A scroll bar, a button or a dropdown: moved whole, not its pieces.
local IsControl = function(frame)
	local name = frame:GetName()
	return frame:IsObjectType("Slider") or frame:IsObjectType("Button")
		or (name and string_find(name, "DropDown$") and true) or false
end

-- The named part under the mouse (or the first named one holding it; the
-- control it's a piece of).
local Hovered = function()
	local part = GetMouseFocus()
	while part and ((not part:GetName()) or (part:GetParent() and IsControl(part:GetParent()))) do
		part = part:GetParent()
	end
	if part and (part ~= _G.UIParent) and (part ~= _G.WorldFrame) and (part ~= Module.Box) then
		return part
	end
end

-- `part`'s place as it is: its first anchor, or (on an unnamed frame) its
-- top left from its first named parent's (for /dui layout's list too).
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

-- The smallest named part shown in `frame` (itself included) under the
-- cursor: what's inside a bigger part (the window the box first covers)
-- can be picked too.
local Smallest
Smallest = function(frame, x, y, best, area)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsVisible() and (child ~= Module.Box) then
			local left, bottom, width, height = child:GetRect()
			local scale = child:GetEffectiveScale()
			if left and (x >= left * scale) and (x <= (left + width) * scale)
				and (y >= bottom * scale) and (y <= (bottom + height) * scale) then
				local size = width * height * scale * scale
				if child:GetName() and (size > 0) and (size < area) then
					best, area = child, size
				end
			end
			-- (a child may reach out of its parent: looked into either way;
			-- not a control's pieces: a scroll bar's arrows, a dropdown's)
			if (not IsControl(child)) then
				best, area = Smallest(child, x, y, best, area)
			end
		end
	end
	return best, area
end

local Describe = function(name)
	local point, relative, relativePoint, x, y = unpack(Module:GetEntry(name))
	return string_format("%s: %s on %s %s %.0f, %.0f", name, point, relative, relativePoint, x, y)
end

-- `part` moved by `dx`, `dy` from `from` (its place when the move began),
-- saved; one placed by two points keeps its size.
local Move = function(part, from, dx, dy)
	local name = part:GetName()
	local entry = Module:GetEntry(name) or {}
	local width, height = entry[6], entry[7]
	if (not width) and (part:GetNumPoints() > 1) then
		width, height = part:GetWidth(), part:GetHeight()
	end
	Saved[name] = { from[1], from[2], from[3], from[4] + dx, from[5] + dy, width, height }
	Follow(name)
end

-- `part` wider by `dw`, taller by `dh`, saved; placed where it is (by one
-- point: two would keep its size).
local Resize = function(part, dw, dh)
	local name = part:GetName()
	local place = Module:GetEntry(name) or PlaceOf(part)
	local width, height = math_max(1, part:GetWidth() + dw), math_max(1, part:GetHeight() + dh)
	Saved[name] = { place[1], place[2], place[3], place[4], place[5], width, height }
	Follow(name)
	return string_format("%s: %.0f x %.0f", name, width, height)
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
			Saved[name] = nil
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
		elseif ((dx ~= 0) or (dy ~= 0)) and CanMove(box.Part) and IsControlKeyDown() then
			self:Print(Resize(box.Part, dx, dy)) -- (right and up: wider, taller)
		elseif ((dx ~= 0) or (dy ~= 0)) and CanMove(box.Part) then
			Move(box.Part, PlaceOf(box.Part), dx, dy)
			self:Print(Describe(box.Part:GetName()))
		end
	end)
	return box
end

-- The box over what's hovered, each frame: the smallest named part under
-- the cursor, in the one the mouse first found (the box takes the mouse
-- after).
local Watch = function()
	local box = Module.Box
	if box.Drag then
		return
	end
	local root = box:IsShown() and box.Root or Hovered()
	if (not root) then
		return
	end
	box.Root = root
	local x, y = GetCursorPosition()
	local part = IsControl(root) and root or Smallest(root, x, y, root, math_huge)
	if (part ~= box.Part) or (not box:IsShown()) then
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
		self:Print(L["Adjust on: hover a part, drag it or nudge it with the arrow keys (Shift: 10), Ctrl + arrows to resize it, right-click to put it back. Escape to stop."])
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
	self.config = self:GetDB("Positions")
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	local layout = _G.DiabolicUI_Layout or {}
	_G.DiabolicUI_Layout = layout
	layout.adjust = nil -- (the first trials')
	layout.moved = layout.moved or {}
	Saved = layout.moved
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
