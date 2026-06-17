local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Floaters")
local FloatButton = Module:GetWidget("Template: FloatButton")
local C = Engine:GetDB("Data: Colors")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local GetNumShapeshiftForms = _G.GetNumShapeshiftForms
local HasExtraActionBar = _G.HasExtraActionBar
local InCombatLockdown = _G.InCombatLockdown
local RegisterStateDriver = _G.RegisterStateDriver
local TaxiRequestEarlyLanding = _G.TaxiRequestEarlyLanding
local UnitOnTaxi = _G.UnitOnTaxi
local UnregisterStateDriver = _G.UnregisterStateDriver

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Tracking number of visible forms
local NUM_FORMS = 0

BarWidget.UpdateTaxiExitButtonVisibility = Engine:Wrap(function(self, event, ...)
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateTaxiExitButtonVisibility")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdateTaxiExitButtonVisibility")
	end
	if UnitOnTaxi("player") then
		self.TaxiBar:Show()
		self.TaxiExitButton:Enable()
		self.StanceBarButton:SetAlpha(0)
	else
		self.TaxiBar:Hide()
		self.TaxiExitButton:Disable()
		self.StanceBarButton:SetAlpha(1)
	end
end)

BarWidget.UpdateStanceButtonVisibility = function(self, event, ...)
	local numForms = GetNumShapeshiftForms()
	if (numForms == NUM_FORMS) then
		return
	end
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateStanceButtonVisibility")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdateStanceButtonVisibility")
	end
	if (GetNumShapeshiftForms() == 0) then
		UnregisterStateDriver(self.StanceBarButton, "visibility")
		RegisterStateDriver(self.StanceBarButton, "hide")
	else
		UnregisterStateDriver(self.StanceBarButton, "visibility")
		RegisterStateDriver(self.StanceBarButton, "visibility", "[bonusbar:5][vehicleui]hide;show")
	end
end

BarWidget.OnEnable = function(self)
	local db = Module.db
	local barConfig = Module.config.structure.bars.floaters

	local Artwork = Module:GetWidget("Artwork")
	local Main = Module:GetWidget("Controller: Main"):GetFrame()
	
	local Bar = Module:GetHandler("ActionBar"):New("floaters", Main, Artwork:GetBarTemplate())
	Bar:SetSize(unpack(barConfig.size))
	Bar:SetPoint(unpack(barConfig.position))

	self.Bar = Bar

	-- Stancebar toggle button
	self.StanceBarButton = self:SpawnStanceBarButton()

	-- Exit buttons
	self.VehicleExitButton = self:SpawnVehicleExitButton()
	self.TaxiBar, self.TaxiExitButton = self:SpawnTaxiExitButton()

	-- Zone ability buttons
	self.DraenorZoneAbilityButton = self:StyleZoneButton(_G.DraenorZoneAbilityFrame) -- this was removed at some point
	self.LegionZoneAbilityButton = self:StyleZoneButton(_G.ZoneAbilityFrame)

end

BarWidget.GetFrame = function(self)
	return self.Bar
end


BarWidget.SpawnStanceBarButton = function(self)
	local visualConfig = Module.config.visuals.floaters.stance

	local StanceBarButton = FloatButton:New("Click", self:GetFrame(), "EngineStanceBarButton") 
	StanceBarButton:Hide()
	StanceBarButton:SetFrameLevel(10)
	StanceBarButton:SetSize(unpack(visualConfig.size))
	StanceBarButton:SetPoint(unpack(visualConfig.position))

	StanceBarButton.Icon:SetTexture(visualConfig.icon.texture)
	StanceBarButton.Icon:SetSize(unpack(visualConfig.icon.size))
	StanceBarButton.Icon:SetTexCoord(unpack(visualConfig.icon.texcoords))

	StanceBarButton.Normal:SetSize(unpack(visualConfig.border.size))
	StanceBarButton.Normal:SetPoint(unpack(visualConfig.border.position))
	StanceBarButton.Normal:SetTexture(visualConfig.border.textures.normal)

	StanceBarButton.Highlight:SetSize(unpack(visualConfig.border.size))
	StanceBarButton.Highlight:SetPoint(unpack(visualConfig.border.position))
	StanceBarButton.Highlight:SetTexture(visualConfig.border.textures.highlight)

	StanceBarButton.Pushed:SetSize(unpack(visualConfig.border.size))
	StanceBarButton.Pushed:SetPoint(unpack(visualConfig.border.position))
	StanceBarButton.Pushed:SetTexture(visualConfig.border.textures.highlight)

	StanceBarButton.PostEnter = function(self)
		if GameTooltip:IsForbidden() then
			return
		end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(L["Stances"], 1, 1, 1)
		GameTooltip:AddLine(L["<Left-click> to toggle stance bar."], unpack(C.General.OffGreen))

		local form = GetShapeshiftForm(true)
		if (form and (form ~= 0)) then 
			GameTooltip:AddLine(L["<Right-click> to cancel current form."], unpack(C.General.OffGreen))
		end

		GameTooltip:Show()
	end
	
	StanceBarButton.PostLeave = function(self) 
		if (not GameTooltip:IsForbidden()) then
			GameTooltip:Hide()
		end
	end

	StanceBarButton:SetClickTarget(Module:GetWidget("Bar: Stance"):GetFrame())

	local ProxyButton = CreateFrame("Button", nil, StanceBarButton, "SecureActionButtonTemplate")
	ProxyButton:RegisterForClicks("AnyUp")
	ProxyButton:SetAllPoints()
	ProxyButton:SetAttribute("type1", "click")
	ProxyButton:SetAttribute("clickbutton1", StanceBarButton)
	ProxyButton:SetAttribute("type2", "macro")
	ProxyButton:SetAttribute("macrotext", "/cancelform [form]")
	ProxyButton:SetScript("OnEnter", function() StanceBarButton:GetScript("OnEnter")(StanceBarButton) end)
	ProxyButton:SetScript("OnLeave", function() StanceBarButton:GetScript("OnLeave")(StanceBarButton) end)

	ProxyButton:SetScript("OnEvent", function(self)
		if GameTooltip:IsForbidden() then
			return
		end
		if (GameTooltip:GetOwner() == StanceBarButton) then
			self:GetScript("OnEnter")()
		end
	end)
	ProxyButton:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	ProxyButton:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	ProxyButton:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")

	-- Events needed to track stance button visibilty
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_BONUS_ACTIONBAR", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR", "UpdateStanceButtonVisibility")
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_SHAPESHIFT_USABLE", "UpdateStanceButtonVisibility")
	self:RegisterEvent("UPDATE_POSSESS_BAR", "UpdateStanceButtonVisibility")
	
	return StanceBarButton
end

BarWidget.SpawnVehicleExitButton = function(self)
	local visualConfig = Module.config.visuals.floaters.exit

	local VehicleExitButton = FloatButton:New("Action", self:GetFrame(), "EngineVehicleExitButton")
	VehicleExitButton:Hide()
	VehicleExitButton:SetFrameLevel(15)
	VehicleExitButton:SetSize(unpack(visualConfig.size))
	VehicleExitButton:SetPoint(unpack(visualConfig.position))
	VehicleExitButton:SetHitRectInsets(-1, -1, -1, -1)

	VehicleExitButton.Normal:SetSize(unpack(visualConfig.texture_size))
	VehicleExitButton.Normal:SetPoint(unpack(visualConfig.texture_position))
	VehicleExitButton.Normal:SetTexture(visualConfig.textures.normal)

	VehicleExitButton.Highlight:SetSize(unpack(visualConfig.texture_size))
	VehicleExitButton.Highlight:SetPoint(unpack(visualConfig.texture_position))
	VehicleExitButton.Highlight:SetTexture(visualConfig.textures.highlight)

	VehicleExitButton.Pushed:SetSize(unpack(visualConfig.texture_size))
	VehicleExitButton.Pushed:SetPoint(unpack(visualConfig.texture_position))
	VehicleExitButton.Pushed:SetTexture(visualConfig.textures.pushed)

	VehicleExitButton.Disabled:SetSize(unpack(visualConfig.texture_size))
	VehicleExitButton.Disabled:SetPoint(unpack(visualConfig.texture_position))
	VehicleExitButton.Disabled:SetTexture(visualConfig.textures.disabled)
	
	VehicleExitButton.PostEnter = function(self)
		if GameTooltip:IsForbidden() then
			return
		end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(LEAVE_VEHICLE, 1, 1, 1)
		GameTooltip:AddLine(L["<Left-click> to leave the vehicle."], unpack(C.General.OffGreen))
		GameTooltip:Show()
	end
	
	VehicleExitButton.PostLeave = function(self) 
		if (not GameTooltip:IsForbidden()) then
			GameTooltip:Hide()
		end
	end

	VehicleExitButton:SetAttribute("type", "macro")
	VehicleExitButton:SetAttribute("macrotext", "/leavevehicle [target=vehicle,exists]")
	
	RegisterStateDriver(VehicleExitButton, "visibility", "[target=vehicle,exists] show; hide")

	return VehicleExitButton
end

BarWidget.SpawnTaxiExitButton = function(self)
	local visualConfig = Module.config.visuals.floaters.exit
	
	local TaxiBar = self:GetFrame():CreateFrame("Frame")
	TaxiBar:SetFrameLevel(20)
	TaxiBar:SetFrameStrata("MEDIUM") 
	TaxiBar:SetAllPoints()
	TaxiBar:SetHitRectInsets(-1, -1, -1, -1)
	
	local TaxiExitButton = FloatButton:New("Click", TaxiBar, "EngineTaxiExitButton")
	TaxiExitButton:Hide()
	TaxiExitButton:SetSize(unpack(visualConfig.size))
	TaxiExitButton:SetPoint(unpack(visualConfig.position))

	TaxiExitButton.Normal = TaxiExitButton:CreateTexture(nil, "BORDER")
	TaxiExitButton.Normal:SetSize(unpack(visualConfig.texture_size))
	TaxiExitButton.Normal:SetPoint(unpack(visualConfig.texture_position))
	TaxiExitButton.Normal:SetTexture(visualConfig.textures.normal)

	TaxiExitButton.Highlight = TaxiExitButton:CreateTexture(nil, "BORDER")
	TaxiExitButton.Highlight:Hide()
	TaxiExitButton.Highlight:SetSize(unpack(visualConfig.texture_size))
	TaxiExitButton.Highlight:SetPoint(unpack(visualConfig.texture_position))
	TaxiExitButton.Highlight:SetTexture(visualConfig.textures.highlight)

	TaxiExitButton.Pushed = TaxiExitButton:CreateTexture(nil, "BORDER")
	TaxiExitButton.Pushed:Hide()
	TaxiExitButton.Pushed:SetSize(unpack(visualConfig.texture_size))
	TaxiExitButton.Pushed:SetPoint(unpack(visualConfig.texture_position))
	TaxiExitButton.Pushed:SetTexture(visualConfig.textures.pushed)

	TaxiExitButton.Disabled = TaxiExitButton:CreateTexture(nil, "BORDER")
	TaxiExitButton.Disabled:Hide()
	TaxiExitButton.Disabled:SetSize(unpack(visualConfig.texture_size))
	TaxiExitButton.Disabled:SetPoint(unpack(visualConfig.texture_position))
	TaxiExitButton.Disabled:SetTexture(visualConfig.textures.disabled)
	
	TaxiExitButton.PostEnter = function(self)
		if GameTooltip:IsForbidden() then
			return
		end
		if UnitOnTaxi("player") then
			GameTooltip_SetDefaultAnchor(GameTooltip, self)
			GameTooltip:SetText(TAXI_CANCEL, 1, 1, 1)
			GameTooltip:AddLine(TAXI_CANCEL_DESCRIPTION, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
			GameTooltip:Show()
		end
	end
	
	TaxiExitButton.PostLeave = function(self) 
		if (not GameTooltip:IsForbidden()) then
			GameTooltip:Hide()
		end
	end

	TaxiExitButton.PostClick = function(self, button)
		if UnitOnTaxi("player") and (not InCombatLockdown()) then
			TaxiRequestEarlyLanding()
		end
	end

			
	self:RegisterEvent("UPDATE_BONUS_ACTIONBAR", "UpdateTaxiExitButtonVisibility")
	self:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR", "UpdateTaxiExitButtonVisibility")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE", "UpdateTaxiExitButtonVisibility")
	self:RegisterEvent("UNIT_EXITED_VEHICLE", "UpdateTaxiExitButtonVisibility")
	self:RegisterEvent("VEHICLE_UPDATE", "UpdateTaxiExitButtonVisibility")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateTaxiExitButtonVisibility")
	
	RegisterStateDriver(TaxiExitButton, "visibility", "[target=vehicle,exists,canexitvehicle] hide; show")
	
	return TaxiBar, TaxiExitButton
end

BarWidget.StyleZoneButton = function(self, frame)
	return frame and self:StyleButton(frame.SpellButton, frame, Module.config.visuals.floaters.zone)
end

BarWidget.StyleButton = function(self, button, parent, visualConfig)

	FloatButton:Build(button)

	-- The Zone ability buttons have this
	if parent then
		parent:SetParent(self:GetFrame())
		parent:SetSize(unpack(visualConfig.size))
		parent:ClearAllPoints()
		parent:SetPoint(unpack(visualConfig.position))
		parent.ignoreFramePositionManager = true
	end

	button:SetSize(unpack(visualConfig.size))
	button:ClearAllPoints()
	button:SetPoint("CENTER", 0, 0)

	button.Icon:SetTexture(visualConfig.icon.texture)
	button.Icon:SetSize(unpack(visualConfig.icon.size))
	button.Icon:SetTexCoord(unpack(visualConfig.icon.texcoords))

	button.Normal:SetSize(unpack(visualConfig.border.size))
	button.Normal:SetPoint(unpack(visualConfig.border.position))
	button.Normal:SetTexture(visualConfig.border.textures.normal)

	button.Highlight:SetSize(unpack(visualConfig.border.size))
	button.Highlight:SetPoint(unpack(visualConfig.border.position))
	button.Highlight:SetTexture(visualConfig.border.textures.highlight)

	button.Pushed:SetSize(unpack(visualConfig.border.size))
	button.Pushed:SetPoint(unpack(visualConfig.border.position))
	button.Pushed:SetTexture(visualConfig.border.textures.highlight)

	return button
end
