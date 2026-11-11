-- Other addons' minimap buttons, gathered in a drawer that a "+" on the
-- minimap's border opens (what MinimapButtonBag did: off while it's on).
local ADDON, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("Minimap: Buttons", "LOW")
Module:SetIncompatible("MBB")

local TEXTURES = ([[Interface\AddOns\%s\media\textures\]]):format(ADDON)

-- Named frames on the minimap that aren't addon buttons: Blizzard's pieces,
-- and other addons' map pins (by their exact names: Questie's own button is
-- LibDBIcon10_Questie).
local IGNORE = {
	"^MiniMap",
	"^Minimap",
	"^GameTimeFrame",
	"^TimeManager",
	"^QuestieFrame",
	"^HandyNotesPin",
	"^GatherMatePin",
	"^GatherNote",
	"^GatherArchNote",
	"^ZGVMarker",
	"POI",
}

local noop = function() end

-- An addon's button: named, clickable, not on the ignore list.
local IsAddonButton = function(frame)
	local name = frame:GetName()
	if not (name and frame:HasScript("OnClick") and frame:GetScript("OnClick")) then
		return false
	end
	for _, pattern in ipairs(IGNORE) do
		if name:find(pattern) then
			return false
		end
	end
	return true
end

-- `button` into the drawer, kept there: its addon can't move or drag it back
-- onto the minimap.
Module.Take = function(self, button)
	local methods = getmetatable(button).__index
	button:SetParent(self.drawer)
	button:RegisterForDrag()
	button.ClearAllPoints, button.SetPoint = noop, noop
	button.DiabolicPlace = function(...)
		methods.ClearAllPoints(button)
		methods.SetPoint(button, ...)
	end
	self.buttons[#self.buttons + 1] = button
end

-- The buttons shown, in rows, the drawer around them; the "+" only while
-- there are some.
Module.Layout = function(self)
	local spec, shown = self.config, {}
	for _, button in ipairs(self.buttons) do
		if button:IsShown() then
			shown[#shown + 1] = button
		end
	end
	local columns = math.max(1, math.min(#shown, spec.columns))
	for i, button in ipairs(shown) do
		local column, row = (i - 1) % columns, math.floor((i - 1) / columns)
		button.DiabolicPlace(
			"TOPLEFT",
			self.drawer,
			"TOPLEFT",
			spec.padding + column * spec.cell,
			-spec.padding - row * spec.cell
		)
	end
	local rows = math.max(1, math.ceil(#shown / columns))
	self.drawer:SetSize(spec.padding * 2 + columns * spec.cell, spec.padding * 2 + rows * spec.cell)
	if #self.buttons > 0 then
		self.toggle:Show()
	else
		self.toggle:Hide()
	end
end

Module.Gather = function(self)
	for _, parent in ipairs({ Minimap, MinimapBackdrop }) do
		for _, child in ipairs({ parent:GetChildren() }) do
			if IsAddonButton(child) then
				self:Take(child)
			end
		end
	end
	self:Layout()
end

-- Open: buttons made since gathered too, the drawer under the "+" towards
-- the screen's middle.
Module.Open = function(self)
	self:Gather()
	local drawer, left = self.drawer, self.minimap:IsOnTheLeft()
	drawer:ClearAllPoints()
	drawer:SetPoint(left and "TOPLEFT" or "TOPRIGHT", self.toggle, left and "BOTTOMRIGHT" or "BOTTOMLEFT", 0, 0)
	drawer:Show()
end

Module.Toggle = function(self)
	if self.drawer:IsShown() then
		self.drawer:Hide()
	else
		self:Open()
	end
end

Module.CreateToggle = function(self)
	local spec = self.config
	local toggle = CreateFrame("Button", nil, Minimap)
	toggle:SetFrameStrata("LOW") -- (MEDIUM collides with Immersion)
	toggle:SetFrameLevel(toggle:GetFrameLevel() + 10)
	toggle:SetSize(spec.toggle_size, spec.toggle_size)
	local icon = toggle:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints()
	icon:SetTexture(TEXTURES .. "button-toggle-plus")
	icon:SetAlpha(0.85)
	toggle:SetScript("OnClick", function()
		self:Toggle()
	end)
	toggle:SetScript("OnEnter", function()
		icon:SetAlpha(1)
		GameTooltip_SetDefaultAnchor(GameTooltip, toggle)
		GameTooltip:AddLine(L["Minimap Buttons"])
		GameTooltip:AddLine(L["Click to show your addons' minimap buttons."], 0, 1, 0, true)
		GameTooltip:Show()
	end)
	toggle:SetScript("OnLeave", function()
		icon:SetAlpha(0.85)
		GameTooltip:Hide()
	end)
	self.toggle = toggle

	local panel = Engine:GetDB("Blizzard").window.panel
	local drawer = CreateFrame("Frame", nil, toggle)
	drawer:SetFrameStrata("HIGH")
	drawer:SetBackdrop(panel.backdrop)
	drawer:SetBackdropColor(unpack(panel.backdrop_color))
	drawer:SetBackdropBorderColor(unpack(panel.backdrop_border_color))
	drawer:Hide()
	self.drawer = drawer
end

Module.OnInit = function(self)
	self.config = Engine:GetDB("Minimap").buttons
	self.minimap = Engine:GetModule("Minimap")
	self.buttons = {}
end

Module.OnEnable = function(self)
	self:CreateToggle()
	-- placed with the minimap's other outer pieces (now if it's up already)
	self.minimap.buttonsToggle = self.toggle
	if self.minimap:IsEnabled() then
		self.minimap:UpdateOuterElements()
	end
	self:Gather()
	-- (addons that make theirs at login, after us)
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Gather")
end
