-- Styles the TrinketMenu addon when it's loaded (the "styleTrinketMenu"
-- option): its buttons, the worn trinkets and the menu's, like the side
-- bars' 36px buttons, without TrinketMenu's backgrounds behind them.
-- Textures and fonts only: TrinketMenu's own
-- code and secure clicks are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: TrinketMenu", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs
local unpack = unpack

-- WoW API
local IsAddOnLoaded = _G.IsAddOnLoaded

-- How many menu buttons TrinketMenu.xml makes (TrinketMenu.MaxTrinkets).
local NUM_MENU_BUTTONS = 30

-- A texture of the button style, sized and placed as it says.
local Place = function(texture, element)
	texture:ClearAllPoints()
	texture:SetSize(unpack(element.size))
	for _, point in ipairs(element.points) do
		texture:SetPoint(unpack(point))
	end
end

local SetFont = function(fontString, element)
	if fontString and element then
		fontString:SetFontObject(element.normalFont)
	end
end

Module.StyleButton = function(self, button)
	if (not button) or button.DiabolicStyled then
		return
	end
	local style = self:GetDB("ActionBars").visuals.buttons[36]
	local name = button:GetName()

	-- the icon inset in the border, like the bars'. ActionButtonTemplate
	-- draws it in the BACKGROUND layer, where the slot below goes too, and
	-- a layer's textures draw in no set order: it moves up one.
	local icon = _G[name .. "Icon"]
	Place(icon, style.icon)
	icon:SetTexCoord(unpack(style.icon.texcoords))
	icon:SetDrawLayer("BORDER")

	local cooldown = _G[name .. "Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetAllPoints(icon)
	end

	-- the empty slot behind the icon
	local slot = button:CreateTexture(nil, "BACKGROUND")
	Place(slot, style.slot)
	slot:SetTexture(style.slot.texture)

	-- the border, and its highlighted, pushed and checked looks
	button:SetNormalTexture(style.border_normal.texture)
	Place(button:GetNormalTexture(), style.border_normal)
	button:SetHighlightTexture(style.border_normal_highlight.texture)
	Place(button:GetHighlightTexture(), style.border_normal_highlight)
	button:SetPushedTexture(style.border_normal_highlight.texture)
	Place(button:GetPushedTexture(), style.border_normal_highlight)
	button:SetCheckedTexture(style.border_checked.texture)
	Place(button:GetCheckedTexture(), style.border_checked)
	local border = _G[name .. "Border"] -- Blizzard's green "equipped" ring
	if border then
		border:SetTexture(nil)
	end

	SetFont(_G[name .. "HotKey"], style.keybind)
	SetFont(_G[name .. "Count"], style.stacksize)
	SetFont(_G[name .. "Time"], style.keybind) -- TrinketMenu's cooldown time

	button.DiabolicStyled = true
end

Module.StyleTrinketMenu = function(self)
	-- the worn trinkets float, like the side bars
	_G.TrinketMenu_MainFrame:SetBackdrop(nil)
	self:StyleButton(_G.TrinketMenu_Trinket0)
	self:StyleButton(_G.TrinketMenu_Trinket1)

	-- the menu of the others too
	_G.TrinketMenu_MenuFrame:SetBackdrop(nil)
	for i = 1, NUM_MENU_BUTTONS do
		self:StyleButton(_G["TrinketMenu_Menu" .. i])
	end
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "TrinketMenu") then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleTrinketMenu()
	end
end

Module.OnEnable = function(self)
	if (not self:GetConfig("AddOnSkins").styleTrinketMenu) then
		return
	end
	if IsAddOnLoaded("TrinketMenu") then
		self:StyleTrinketMenu()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
