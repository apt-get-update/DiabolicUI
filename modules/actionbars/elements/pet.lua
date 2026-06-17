local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Pet")

-- Lua API
local select = select
local setmetatable = setmetatable
local tinsert, tconcat, twipe = table.insert, table.concat, table.wipe

-- WoW API
local InCombatLockdown = _G.InCombatLockdown
local RegisterStateDriver = _G.RegisterStateDriver

local NUM_BUTTONS = NUM_PET_ACTION_SLOTS or 10

BarWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db
	local bar_config = Module.config.structure.bars.pet

	local Artwork = Module:GetWidget("Artwork")
	local Bar = Module:GetHandler("ActionBar"):New("pet", Module:GetWidget("Controller: Pet"):GetFrame(), Artwork:GetBarTemplate())
	Bar:Hide()
	Bar:SetFrameStrata("MEDIUM")
	Bar:SetFrameLevel(5)
	Bar:SetSize(unpack(bar_config.bar_size))
	Bar:Place(unpack(Module:IsXPVisible() and bar_config.positionXP or bar_config.position))
	Bar:SetAttribute("old_button_size", bar_config.buttonsize)

	Bar.hideGrid = bar_config.hideGrid
	Bar.position = bar_config.position
	Bar.positionXP = bar_config.positionXP

	--------------------------------------------------------------------
	-- Buttons
	--------------------------------------------------------------------
	-- figure out anchor points
	local banchor, bx, by
	if bar_config.growth == "UP" then
		banchor = "BOTTOM"
		bx = 0
		by = 1
	elseif bar_config.growth == "DOWN" then
		banchor = "TOP"
		bx = 0
		by = -1
	elseif bar_config.growth == "LEFT" then
		banchor = "RIGHT"
		bx = -1
		by = 0
	elseif bar_config.growth == "RIGHT" then
		banchor = "LEFT"
		bx = 1
		by = 0
	end
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

	self:RegisterEvent("PLAYER_ENTERING_VEHICLE", "OnEvent")
	self:RegisterEvent("PLAYER_ENTERED_VEHICLE", "OnEvent")
	self:RegisterEvent("PLAYER_EXITING_VEHICLE", "OnEvent")
	self:RegisterEvent("PLAYER_EXITED_VEHICLE", "OnEvent")

	self:UpdateVisibility()

end

BarWidget.OnEvent = function(self, event, ...)
	if (event == "PLAYER_ENTERING_VEHICLE") then
		return self.Bar:SetAlpha(0)
	elseif (event == "PLAYER_ENTERED_VEHICLE") then
		return self.Bar:SetAlpha(0)
	elseif (event == "PLAYER_EXITING_VEHICLE") then
		return self.Bar:SetAlpha(0)
	elseif (event == "PLAYER_EXITED_VEHICLE") then
		return self.Bar:SetAlpha(1)
	end
end

BarWidget.UpdateVisibility = function(self, event, ...)
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateVisibility")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdateVisibility")
	end
	if (event == "PLAYER_LEVEL_UP") then
		local level = ...
		if (level < 10) then 
			return 
		end 
		self:UnregisterEvent("PLAYER_LEVEL_UP", "UpdateVisibility")
	end
	if (UnitLevel("player") >= 10) then 
		local visibility_driver = "[bonusbar:5]hide;[vehicleui][target=vehicle,exists]hide;[pet]show;hide"

		UnregisterStateDriver(self.Bar, "vis")
		RegisterStateDriver(self.Bar, "vis", visibility_driver)
	else
		UnregisterStateDriver(self.Bar, "vis")
		RegisterStateDriver(self.Bar, "vis", "hide")

		self:RegisterEvent("PLAYER_LEVEL_UP", "UpdateVisibility")
	end 
end 

BarWidget.UpdatePosition = function(self, event, ...)
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdatePosition")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdatePosition")
	end
	self.Bar:Place(unpack(Module:IsXPVisible() and Module.config.structure.bars.pet.positionXP or Module.config.structure.bars.pet.position))
end

BarWidget.GetFrame = function(self)
	return self.Bar
end
