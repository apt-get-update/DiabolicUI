local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Stance")

-- Lua API
local _G = _G

-- WoW API
local GetNumShapeshiftForms = _G.GetNumShapeshiftForms
local GetShapeshiftForm = _G.GetShapeshiftForm
local RegisterStateDriver = _G.RegisterStateDriver

local NUM_BUTTONS = NUM_SHAPESHIFT_SLOTS or 10

local UIHider = CreateFrame("Frame")
UIHider:Hide()

-- Update visible number of buttons, and adjust the bar size to match
local UpdateStanceButtons = Engine:Wrap(function(self)
	local buttons = self.buttons or {}

	local numShown = 0
	local numForms = GetNumShapeshiftForms() or 0
	local currentForm = GetShapeshiftForm()
	local needUpdate
	
	for i = 1, #buttons do
		if buttons[i]:IsShown() then
			numShown = numShown + 1
		end
	end
	
	if (numShown ~= numForms) then
		needUpdate = true
	end
	
	for i = 1, numForms do
		buttons[i]:Show()
		buttons[i]:SetAttribute("statehidden", nil)
		buttons[i]:UpdateAction(true) -- force an update, in case it's a new ability (?)
	end

	for i = numForms+1, #buttons do
		buttons[i]:Hide()
		buttons[i]:SetAttribute("statehidden", true)
		buttons[i]:SetChecked(nil)
	end

	if (numForms == 0) then
		self.disabled = true
	else
		self.disabled = false
	end
	
	if needUpdate then
		self:SetSize(unpack(Module.config.structure.bars.stance.bar_size[numForms]))	
	end
end)

-- Update the checked state of the buttons
local UpdateButtonStates = function(self)
	local buttons = self.buttons or {}
	local numForms = GetNumShapeshiftForms()
	local currentForm = GetShapeshiftForm()
	for i = 1, numForms do 
		if currentForm == i then
			buttons[i]:SetChecked(true)
		else
			buttons[i]:SetChecked(nil)
		end
	end
	UpdateStanceButtons(self)
end

BarWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db
	local barConfig = Module.config.structure.bars.stance

	local Artwork = Module:GetWidget("Artwork")

	local Bar = Module:GetHandler("ActionBar"):New("stance", Module:GetWidget("Controller: Main"):GetFrame(), Artwork:GetBarTemplate())
	Bar:SetSize(unpack(barConfig.bar_size[GetNumShapeshiftForms() or 0]))
	Bar:Place(unpack(barConfig.position))
	Bar:SetAttribute("old_button_size", barConfig.buttonsize)
	Bar:GetParent():Hide()

	-- Add these methods into the bar object
	Bar.UpdateButtonStates = UpdateButtonStates
	Bar.UpdateStanceButtons = UpdateStanceButtons

	
	--------------------------------------------------------------------
	-- Buttons
	--------------------------------------------------------------------
	-- figure out anchor points
	local banchor, bx, by
	if (barConfig.growth == "UP") then
		banchor = "BOTTOM"
		bx = 0
		by = 1
	elseif (barConfig.growth == "DOWN") then
		banchor = "TOP"
		bx = 0
		by = -1
	elseif (barConfig.growth == "LEFT") then
		banchor = "RIGHT"
		bx = -1
		by = 0
	elseif (barConfig.growth == "RIGHT") then
		banchor = "LEFT"
		bx = 1
		by = 0
	end
	local padding = config.structure.controllers.main.padding

	-- Spawn the action buttons
	for i = 1,NUM_BUTTONS do
		local button = Bar:NewButton("stance", i, Artwork:GetButtonTemplate())
		button:SetStateAction(0, "stance", i) -- no real effect whatsoever for stances
		button:SetSize(barConfig.buttonsize, barConfig.buttonsize)
		button:SetPoint(banchor, (barConfig.buttonsize + padding) * (i-1) * bx, (barConfig.buttonsize + padding) * (i-1) * by)
	end

	Bar:SetAttribute("state", "0") 

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterEvent("UPDATE_BONUS_ACTIONBAR", "OnEvent")
	self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", "OnEvent")
	self:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR", "OnEvent")
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_USABLE", "OnEvent")
	self:RegisterEvent("UPDATE_POSSESS_BAR", "OnEvent")

	self.Bar = Bar
end

BarWidget.OnEvent = function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UpdateBarArtwork() -- this is where we style the stancebuttons
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", "OnEvent") -- should only need it once
	end
	self:UpdateStanceButton()

	local Bar = self:GetFrame()
	if Bar then
		Bar:UpdateButtonStates()
	end
end

BarWidget.UpdateStanceButton = function(self)
	local Bar = self.Bar

	local oldNumForms = Bar.numForms
	local numForms = GetNumShapeshiftForms()

	if (oldNumForms == numForms) then
		return
	end

	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateStanceButton")
	end

	if (numForms == 0) then
		UnregisterStateDriver(Bar, "visibility")
		RegisterStateDriver(Bar, "visibility", "hide")
	else
		UnregisterStateDriver(Bar, "visibility")
		RegisterStateDriver(Bar, "visibility", "[bonusbar:5][vehicleui]hide;show")
	end

	Bar.numForms = numForms
		
	--Bar:RegisterVisibilityDriver()
	-- should be options somewhere for this
	--local Bar = Module:GetWidget("Bar: Stance"):GetFrame()
	--if Bar then
	--	self.StanceWindow:SetSize(Bar:GetSize())
	--end
end

-- Callback to update the actual stance bar's button artwork.
-- The bar and buttons are created later, so it can't be done on controller init.
BarWidget.UpdateBarArtwork = function(self)
	local Bar = self.Bar
	if (Bar and Bar.PostUpdate) then
		Bar:PostUpdate()
	end
end

BarWidget.GetFrame = function(self)
	return self.Bar
end
