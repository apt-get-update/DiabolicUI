-- "Button: Spec Switch" widget: a button on top of the skull in the middle
-- of the action bar artwork that switches to your other talent
-- specialization. Greyed out without Dual Talent Specialization. Shown
-- while the "showSpecSwitch" option is on.
local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local ButtonWidget = Module:SetWidget("Button: Spec Switch")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local table_concat = table.concat
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetActiveTalentGroup = _G.GetActiveTalentGroup
local GetNumTalentGroups = _G.GetNumTalentGroups
local GetNumTalentTabs = _G.GetNumTalentTabs
local GetTalentTabInfo = _G.GetTalentTabInfo
local SetActiveTalentGroup = _G.SetActiveTalentGroup

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- The specialization of talent group `group`: the name of its tree with
-- the most points, and its points per tree ("51/20/0").
local GetSpec = function(group)
	local name, most, points = nil, -1, {}
	for tab = 1, GetNumTalentTabs() do
		local tabName, _, spent = GetTalentTabInfo(tab, false, false, group)
		points[tab] = spent
		if (spent > most) then
			name, most = tabName, spent
		end
	end
	return name, table_concat(points, "/")
end

-- The textures are whole button images: one shown at a time.
local UpdateTexture = function(button)
	local textures = button.textures
	if (not button:IsEnabled()) then
		button.Art:SetTexture(textures.disabled)
	elseif button.pushed then
		button.Art:SetTexture(textures.pushed)
	elseif button.hovered then
		button.Art:SetTexture(textures.highlight)
	else
		button.Art:SetTexture(textures.normal)
	end
end

local OnEnter = function(self)
	self.hovered = true
	UpdateTexture(self)

	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	if (GetNumTalentGroups() < 2) then
		GameTooltip:AddLine(L["Talent Specialization"])
		GameTooltip:AddLine(L["Learn Dual Talent Specialization from your class trainer to switch between two specializations here."], .9, .9, .9, true)
	else
		local active = GetActiveTalentGroup()
		GameTooltip:AddLine(L["Talent Specialization"])
		for group, label in ipairs({ _G.PRIMARY, _G.SECONDARY }) do
			local name, points = GetSpec(group)
			local r, g, b = 1, 1, 1
			if (group ~= active) then
				r, g, b = .6, .6, .6
			end
			GameTooltip:AddDoubleLine(label, (name or _G.NONE) .. " (" .. points .. ")", r, g, b, r, g, b)
		end
		GameTooltip:AddLine(L["<Left-click> to switch"], 0, .7, 0)
	end
	GameTooltip:Show()
end

local OnLeave = function(self)
	self.hovered = nil
	self.pushed = nil
	UpdateTexture(self)
	GameTooltip:Hide()
end

local OnMouseDown = function(self)
	self.pushed = true
	UpdateTexture(self)
end

local OnMouseUp = function(self)
	self.pushed = nil
	UpdateTexture(self)
end

local OnClick = function(self)
	if (GetNumTalentGroups() > 1) then
		SetActiveTalentGroup(3 - GetActiveTalentGroup())
	end
end

ButtonWidget.Update = function(self)
	local button = self.Button
	if (not button) then
		return -- not placed yet
	end
	if (not Module.db.showSpecSwitch) then
		button:Hide()
		return
	end
	if (GetNumTalentGroups() > 1) then
		button:Enable()
	else
		button:Disable()
	end
	UpdateTexture(button)
	button:Show()
	if button.hovered then
		OnEnter(button) -- the tooltip follows a switch
	end
end

-- The skull is created with the rest of the artwork on the first bar update
-- (elements/artwork.lua), so the button is too.
ButtonWidget.CreateButton = function(self)
	local config = Module.config.visuals.specswitch
	local skull = _G.DiabolicUISkullTexture

	local button = CreateFrame("Button", "DiabolicUISpecSwitchButton", skull:GetParent())
	button:SetFrameLevel(skull:GetParent():GetFrameLevel() + 2)
	button:SetSize(unpack(config.size))
	button:SetPoint(config.position[1], skull, config.position[1], config.position[2], config.position[3])
	button:RegisterForClicks("LeftButtonUp")
	button.textures = config.textures

	button.Art = button:CreateTexture(nil, "ARTWORK")
	button.Art:SetSize(unpack(config.texture_size))
	button.Art:SetPoint("CENTER")

	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnMouseDown", OnMouseDown)
	button:SetScript("OnMouseUp", OnMouseUp)
	button:SetScript("OnClick", OnClick)

	self.Button = button
	self:UnregisterMessage("ENGINE_ACTIONBAR_ARTWORK_LOADED", "CreateButton")
	self:Update()
end

ButtonWidget.OnEnable = function(self)
	self:RegisterMessage("ENGINE_ACTIONBAR_ARTWORK_LOADED", "CreateButton")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "Update")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "Update")
end

ButtonWidget.GetFrame = function(self)
	return self.Button
end
