-- Other addons' minimap buttons, gathered in a row that a "+" on the
-- minimap's border opens (what MinimapButtonBag did: off while it's on),
-- each in the minimap's own ring (the "+"'s) instead of Blizzard's.
local ADDON, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("Minimap: Buttons", "LAST") -- (after the minimap, which places its "+")
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

-- The round minimap art addons give their buttons (LibDBIcon's and most
-- others'): hidden, for our border.
local ROUND_ART = { "trackingborder", "minimap%-background", "minimap%-zoombutton%-highlight" }

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

local IsRoundArt = function(texture)
	local file = (texture:GetTexture() or ""):lower()
	for _, pattern in ipairs(ROUND_ART) do
		if file:find(pattern) then
			return true
		end
	end
	return false
end

-- `button` as the minimap's own buttons: Blizzard's ring and background
-- hidden, its icon on a dark disc inside the "+"'s ring, the ring lit
-- under the mouse.
Module.Style = function(self, button)
	local spec = self.config
	local icon = spec.size * spec.icon
	button:SetSize(spec.size, spec.size)
	for _, region in ipairs({ button:GetRegions() }) do
		if region:IsObjectType("Texture") then
			if IsRoundArt(region) then
				region:SetAlpha(0)
			elseif region ~= button:GetHighlightTexture() then
				region:ClearAllPoints()
				region:SetPoint("CENTER")
				region:SetSize(icon, icon)
				region:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			end
		end
	end
	local disc = button:CreateTexture(nil, "BACKGROUND", nil, -8)
	disc:SetTexture(TEXTURES .. "minimap-mask-opaque")
	disc:SetVertexColor(0, 0, 0)
	disc:SetPoint("CENTER")
	disc:SetSize(icon, icon)
	local ring = button:CreateTexture(nil, "OVERLAY", nil, 7)
	ring:SetTexture(TEXTURES .. "button-ring")
	ring:SetAllPoints()
	ring:SetAlpha(0.85)
	button:HookScript("OnEnter", function()
		ring:SetAlpha(1)
	end)
	button:HookScript("OnLeave", function()
		ring:SetAlpha(0.85)
	end)
end

-- `button` into the row, kept there: its addon can't move or drag it back
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
	self:Style(button)
	self.buttons[#self.buttons + 1] = button
end

-- The buttons shown, in a row from the "+" towards the screen's middle;
-- the "+" only while there are some.
Module.Layout = function(self)
	local spec, shown = self.config, {}
	for _, button in ipairs(self.buttons) do
		if button:IsShown() then
			shown[#shown + 1] = button
		end
	end
	local left = self.minimap:IsOnTheLeft()
	local point, step = left and "LEFT" or "RIGHT", (spec.size + spec.gap) * (left and 1 or -1)
	for i, button in ipairs(shown) do
		button.DiabolicPlace(point, self.drawer, point, (i - 1) * step, 0)
	end
	self.drawer:SetSize(math.max(1, #shown * (spec.size + spec.gap) - spec.gap), spec.size)
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

-- Open: buttons made since gathered too, the row beside the "+" towards
-- the screen's middle.
Module.Open = function(self)
	self:Gather()
	local drawer, left = self.drawer, self.minimap:IsOnTheLeft()
	drawer:ClearAllPoints()
	drawer:SetPoint(
		left and "LEFT" or "RIGHT",
		self.toggle,
		left and "RIGHT" or "LEFT",
		left and self.config.gap or -self.config.gap,
		0
	)
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

	local drawer = CreateFrame("Frame", nil, toggle)
	drawer:SetFrameStrata("HIGH")
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
	-- placed with the minimap's other outer pieces (unless it's off)
	self.minimap.buttonsToggle = self.toggle
	if self.minimap:IsEnabled() then
		self.minimap:UpdateOuterElements()
	end
	self:Gather()
	-- and every few seconds (addons that make theirs later, like Questie)
	local elapsed = 0
	CreateFrame("Frame"):SetScript("OnUpdate", function(_, delta)
		elapsed = elapsed + delta
		if elapsed >= self.config.scan_every then
			elapsed = 0
			self:Gather()
		end
	end)
end
