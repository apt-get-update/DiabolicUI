local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Pet")

-- WoW API
local InCombatLockdown = _G.InCombatLockdown
local RegisterStateDriver = _G.RegisterStateDriver

local NUM_BUTTONS = NUM_PET_ACTION_SLOTS

-- Picks the pet bar's vertical clearance depending on whether the
-- combined xp/reputation bar slot above it is currently in use.
-- The xp and reputation bars are never both shown at once.
local GetPetBarPosition = function(bar_config)
	if (Module:IsXPVisible() or Module:IsReputationVisible()) then
		return bar_config.positionXP
	else
		return bar_config.position
	end
end

BarWidget.OnEnable = function(self)
	local config = Module.config
	local bar_config = Module.config.structure.bars.pet

	local Artwork = Module:GetWidget("Artwork")
	local Bar = Module:GetHandler("ActionBar"):New("pet", Module:GetWidget("Controller: Pet"):GetFrame(), Artwork:GetBarTemplate())
	Bar:Hide()
	Bar:SetFrameStrata("MEDIUM")
	Bar:SetFrameLevel(5)
	Bar:SetSize(unpack(bar_config.bar_size))
	Bar:Place(unpack(GetPetBarPosition(bar_config)))
	Bar:SetAttribute("old_button_size", bar_config.buttonsize)

	Bar.hideGrid = bar_config.hideGrid

	--------------------------------------------------------------------
	-- Buttons
	--------------------------------------------------------------------
	-- figure out anchor points
	local banchor, bx, by = unpack(Module.GROWTH[bar_config.growth])
	local padding = config.structure.controllers.pet.padding

	-- Spawn the action buttons
	for i = 1,NUM_BUTTONS do
		local button = Bar:NewButton("pet", i, Artwork:GetButtonTemplate())
		button:SetStateAction(0, "pet", i)
		button:SetSize(bar_config.buttonsize, bar_config.buttonsize)
		button:SetPoint(banchor, (bar_config.buttonsize + padding) * (i-1) * bx, (bar_config.buttonsize + padding) * (i-1) * by)
	end
	
	Bar:SetAttribute("state", 0) 

	--------------------------------------------------------------------
	-- Visibility Drivers
	--------------------------------------------------------------------
	Bar:SetAttribute("_onstate-vis", [[
		if newstate == "hide" then
			if self:IsShown() then
				self:Hide();
			end
		elseif newstate == "show" then
			if (not self:IsShown()) then
				self:Show();
			end
		end
	]])

	Bar:SetScript("OnShow", function(self) BarWidget:SendMessage("ENGINE_ACTIONBAR_PET_CHANGED", true) end)
	Bar:SetScript("OnHide", function(self) BarWidget:SendMessage("ENGINE_ACTIONBAR_PET_CHANGED", false) end)

	self.Bar = Bar

	self:RegisterMessage("ENGINE_ACTIONBAR_XP_VISIBLE_CHANGED", "UpdatePosition")
	self:RegisterMessage("ENGINE_ACTIONBAR_REPUTATION_VISIBLE_CHANGED", "UpdatePosition")

	self:UpdateVisibility()

end

-- Shown with a pet (a warlock's imp from level 1, a hunter's from 10),
-- but not while possessing something or in a vehicle.
BarWidget.UpdateVisibility = function(self, event)
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateVisibility")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdateVisibility")
	end
	RegisterStateDriver(self.Bar, "vis", "[bonusbar:5]hide;[vehicleui][target=vehicle,exists]hide;[pet]show;hide")
end

BarWidget.UpdatePosition = function(self, event, ...)
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdatePosition")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdatePosition")
	end
	self.Bar:Place(unpack(GetPetBarPosition(Module.config.structure.bars.pet)))
end

BarWidget.GetFrame = function(self)
	return self.Bar
end
