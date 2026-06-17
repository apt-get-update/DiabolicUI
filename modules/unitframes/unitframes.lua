local Addon, Engine = ...
local Module = Engine:NewModule("UnitFrames")

-- Lua API
local unpack = unpack

-- WoW API
local CreateFrame = CreateFrame

Module.LoadArtWork = function(self)
	local config = self.config.visuals.artwork
	local db = self.db

	local Main = Engine:GetModule("ActionBars"):GetWidget("Controller: Main"):GetFrame()

	self.artwork = {}

	local backdrop = CreateFrame("Frame", nil, Main)
	backdrop:SetFrameStrata("BACKGROUND")
	backdrop:SetAllPoints()

	local overlay = CreateFrame("Frame", nil, Main)
	overlay:SetFrameStrata("MEDIUM")
	overlay:SetAllPoints()

	local new = function(parent, config, flip)
		local artwork = parent:CreateTexture(nil, drawLayer or "ARTWORK")
		artwork:SetSize(unpack(config.size))
		artwork:SetTexture(config.texture)
		artwork:SetVertexColor(unpack(config.color))
		artwork:SetPoint(unpack(config.position))
		artwork:SetBlendMode(alhpaMode or "BLEND")
		return artwork
	end

	self.artwork["healthshade"] = new(backdrop, config.health.shade)
	self.artwork["healthborder"] = new(overlay, config.health.overlay)

	self.artwork["powershade"] = new(backdrop, config.power.shade)
	self.artwork["powerborder"] = new(overlay, config.power.overlay)

end

Module.OnInit = function(self)
	self.config = self:GetDB("UnitFrames") -- setup
	self.db = self:GetConfig("UnitFrames") -- user settings

	self:GetWidget("Controller: Party"):Enable()
	self:GetWidget("Controller: Raid"):Enable()

	self:LoadArtWork()
	self:GetWidget("Unit: Player"):Enable()
	self:GetWidget("Unit: Pet"):Enable()
	self:GetWidget("Unit: Focus"):Enable()
	self:GetWidget("Unit: Target"):Enable()
	self:GetWidget("Unit: ToT"):Enable()

	self:GetWidget("Unit: Party"):Enable()
	self:GetWidget("Unit: Raid"):Enable()
	self:GetWidget("Unit: Arena"):Enable()
	self:GetWidget("Unit: Boss"):Enable()

	-- Set a keyword for our petframe,
	-- for modules like the actionbars to hook into.
	local PetFrame = self:GetWidget("Unit: Pet"):GetFrame()
	Engine:RegisterKeyword("PetFrame", function() return PetFrame end)

end

Module.OnEnable = function(self)
	local BlizzardUI = self:GetHandler("BlizzardUI")
	BlizzardUI:GetElement("UnitFrames"):Disable()

	BlizzardUI:GetElement("Menu_Panel"):Remove(9, "InterfaceOptionsStatusTextPanel")
	BlizzardUI:GetElement("Menu_Panel"):Remove(10, "InterfaceOptionsUnitFramePanel")

	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelPartyBackground")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelPartyInRaid")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelPartyPets")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelRaidRange")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelFullSizeFocusFrame")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelArenaEnemyFrames")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelArenaEnemyCastBar")
	--BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsUnitFramePanelArenaEnemyPets")

	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelTargetOfTarget")
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelTOTDropDown")
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelEnemyCastBars")
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait")
--	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates")
end
