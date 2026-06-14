local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local MenuWidget = Module:SetWidget("Menu: Main")
local L = Engine:GetLocale()

-- Lua API
local ipairs, unpack = ipairs, unpack
local floor = math.floor

-- WoW API
local CreateFrame = _G.CreateFrame
local GetFramerate = _G.GetFramerate
local GetNetStats = _G.GetNetStats
local InCombatLockdown = _G.InCombatLockdown
local PlaySoundKitID = Engine:IsBuild("7.3.0") and _G.PlaySound or _G.PlaySoundKitID
local UnitFactionGroup = _G.UnitFactionGroup

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Client version constants
local ENGINE_WOD 	= Engine:IsBuild("WoD")
local ENGINE_MOP 	= Engine:IsBuild("MoP")
local ENGINE_CATA 	= Engine:IsBuild("Cata")

local UIHider = CreateFrame("Frame")
UIHider:Hide()


MenuWidget.UpdateMicroButtons = function(self, event, ...)
	self.MicroMenuWindow:Arrange()
	self:UnregisterEvent(event, "UpdateMicroButtons")
end

MenuWidget.Strip = function(self, button)
	-- kill off blizzard's textures
	local normal = button:GetNormalTexture()
	if normal then
		button:SetNormalTexture("")
		normal:SetAlpha(0)
		normal:SetSize(.0001, .0001)
	end

	local pushed = button:GetPushedTexture()
	if pushed then
		button:SetPushedTexture("")
		pushed:SetTexture(nil)
		pushed:SetAlpha(0)
		pushed:SetSize(.0001, .0001)
	end

	local highlight = button:GetNormalTexture()
	if highlight then
		button:SetHighlightTexture("")
		highlight:SetAlpha(0)
		highlight:SetSize(.0001, .0001)
	end
	
	-- in cata some buttons are missing this
	local disabled = button:GetDisabledTexture()
	if disabled then
		button:SetNormalTexture("")
		disabled:SetAlpha(0)
		disabled:SetSize(.0001, .0001)
	end
	
	-- this was first introduced in cata
	local flash = _G[button:GetName().."Flash"]
	if flash then
		flash:SetTexture(nil)
		flash:SetAlpha(0)
		flash:SetSize(.0001, .0001)
	end
end

MenuWidget.Skin = function(self, button, config, icon)
	local icon_config = Module.config.visuals.menus.icons

	button.Normal = button:CreateTexture(nil, "BORDER")
	button.Normal:ClearAllPoints()
	button.Normal:SetPoint(unpack(config.button.texture_position))
	button.Normal:SetSize(unpack(config.button.texture_size))
	button.Normal:SetTexture(config.button.textures.normal)
	
	button.Pushed = button:CreateTexture(nil, "BORDER")
	button.Pushed:Hide()
	button.Pushed:ClearAllPoints()
	button.Pushed:SetPoint(unpack(config.button.texture_position))
	button.Pushed:SetSize(unpack(config.button.texture_size))
	button.Pushed:SetTexture(config.button.textures.pushed)

	button.Icon = button:CreateTexture(nil, "OVERLAY")
	button.Icon:SetSize(unpack(icon_config.size))
	button.Icon:SetPoint(unpack(icon_config.position))
	button.Icon:SetAlpha(icon_config.alpha)
	button.Icon:SetTexture(icon_config.texture)
	button.Icon:SetTexCoord(unpack(icon_config.texcoords[icon]))
	
	local position = icon_config.position
	local position_pushed = icon_config.pushed.position
	local alpha = icon_config.alpha
	local alpha_pushed = icon_config.pushed.alpha

	button.OnButtonState = function(self, state, lock)
		if state == "PUSHED" then
			self.Pushed:Show()
			self.Normal:Hide()
			self.Icon:ClearAllPoints()
			self.Icon:SetPoint(unpack(position_pushed))
			self.Icon:SetAlpha(alpha_pushed)
		else
			self.Normal:Show()
			self.Pushed:Hide()
			self.Icon:ClearAllPoints()
			self.Icon:SetPoint(unpack(position))
			self.Icon:SetAlpha(alpha)
		end
	end
	hooksecurefunc(button, "SetButtonState", button.OnButtonState)

	button:HookScript("OnEnable", function(self) 
		self:SetAlpha(1) 
		self.Icon:SetVertexColor(1,1,1)
		self.Normal:SetVertexColor(1,1,1)
	end)
	button:HookScript("OnDisable", function(self) 
		self:SetAlpha(1) 
		self.Icon:SetVertexColor(.4,.4,.4)
		self.Normal:SetVertexColor(.4,.4,.4)
	end)

	button:SetAlpha(1)

	if button:IsEnabled() then
		button.Icon:SetVertexColor(1,1,1)
		button.Normal:SetVertexColor(1,1,1)
	else
		button.Icon:SetVertexColor(.4,.4,.4)
		button.Normal:SetVertexColor(.4,.4,.4)
	end

	button:SetHitRectInsets(0, 0, 0, 0)
	button:OnButtonState(button:GetButtonState())
end

MenuWidget.NewMenuButton = function(self, parent, config, label)
	local button = CreateFrame("Button", nil, parent, "SecureHandlerClickTemplate")
	button:RegisterForClicks("AnyUp")
	button:SetSize(unpack(config.size))

	button.normal = button:CreateTexture(nil, "ARTWORK")
	button.normal:SetPoint("CENTER")

	button.highlight = button:CreateTexture(nil, "ARTWORK")
	button.highlight:SetPoint("CENTER")

	button.pushed = button:CreateTexture(nil, "ARTWORK")
	button.pushed:SetPoint("CENTER")
	
	button.text = {
		normal = button:CreateFontString(nil, "OVERLAY"),
		highlight = button:CreateFontString(nil, "OVERLAY"),
		pushed = button:CreateFontString(nil, "OVERLAY"),

		SetPoint = function(self, ...)
			self.normal:SetPoint(...)
			self.highlight:SetPoint(...)
			self.pushed:SetPoint(...)
		end,

		ClearAllPoints = function(self)
			self.normal:ClearAllPoints()
			self.highlight:ClearAllPoints()
			self.pushed:ClearAllPoints()
		end,

		SetText = function(self, ...)
			self.normal:SetText(...)
			self.highlight:SetText(...)
			self.pushed:SetText(...)
		end

	}
	button.text:SetPoint("CENTER")
	
	button:HookScript("OnEnter", function(self) self:UpdateLayers() end)
	button:HookScript("OnLeave", function(self) self:UpdateLayers() end)
	button:HookScript("OnMouseDown", function(self) 
		self.isDown = true 
		self:UpdateLayers()
	end)
	button:HookScript("OnMouseUp", function(self) 
		self.isDown = false
		self:UpdateLayers()
	end)
	button:HookScript("OnShow", function(self) 
		self.isDown = false
		self:UpdateLayers()
	end)
	button:HookScript("OnHide", function(self) 
		self.isDown = false
		self:UpdateLayers()
	end)
	button.UpdateLayers = function(self)
		if self.isDown then
			self.normal:Hide()
			if self:IsMouseOver() then
				self.highlight:Hide()
				self.pushed:Show()
				self.text:ClearAllPoints()
				self.text:SetPoint("CENTER", 0, -4)
				self.text.pushed:Show()
				self.text.normal:Hide()
				self.text.highlight:Hide()
			else
				self.pushed:Hide()
				self.normal:Hide()
				self.highlight:Show()
				self.text:ClearAllPoints()
				self.text:SetPoint("CENTER", 0, 0)
				self.text.pushed:Hide()
				self.text.normal:Hide()
				self.text.highlight:Show()
			end
		else
			self.text:ClearAllPoints()
			self.text:SetPoint("CENTER", 0, 0)
			if self:IsMouseOver() then
				self.pushed:Hide()
				self.normal:Hide()
				self.highlight:Show()
				self.text.pushed:Hide()
				self.text.normal:Hide()
				self.text.highlight:Show()
			else
				self.normal:Show()
				self.highlight:Hide()
				self.pushed:Hide()
				self.text.pushed:Hide()
				self.text.normal:Show()
				self.text.highlight:Hide()
			end
		end
	end
	
	button:SetSize(unpack(config.size))
	
	button.normal:SetTexture(config.texture.normal)
	button.normal:SetSize(unpack(config.texture_size))
	button.normal:ClearAllPoints()
	button.normal:SetPoint("CENTER")

	button.highlight:SetTexture(config.texture.highlight)
	button.highlight:SetSize(unpack(config.texture_size))
	button.highlight:ClearAllPoints()
	button.highlight:SetPoint("CENTER")

	button.pushed:SetTexture(config.texture.pushed)
	button.pushed:SetSize(unpack(config.texture_size))
	button.pushed:ClearAllPoints()
	button.pushed:SetPoint("CENTER")
	
	button.text.normal:SetFontObject(config.normalFont)
	button.text.highlight:SetFontObject(config.highlightFont)
	button.text.pushed:SetFontObject(config.pushedFont)

	button.text:SetText(label)

	button:UpdateLayers() -- update colors and layers
	
	return button
end

MenuWidget.HookBagnon = function(self, menuButton, menuWindow)
	local inventory = _G.BagnonFrameinventory
	if (not inventory) then
		local bagnon = _G.Bagnon
		if bagnon then
			-- Add in the OnInitialize method for WotLK
			hooksecurefunc(bagnon, bagnon.OnEnable and "OnEnable" or "OnInitialize", function() 
				self:HookBagnon(menuButton, menuWindow)
			end)
		end
		return
	end
	inventory:HookScript("OnShow", function(self) 
		menuButton:SetButtonState("PUSHED", 1)
	end)
	inventory:HookScript("OnHide", function(self) 
		if (not menuWindow:IsShown()) then
			menuButton:SetButtonState("NORMAL")
		end
	end)
end

MenuWidget.HookLiteBag = function(self, menuButton, menuWindow)
	local inventory = _G.LiteBagInventory
	inventory:HookScript("OnShow", function(self) 
		menuButton:SetButtonState("PUSHED", 1)
	end)
	inventory:HookScript("OnHide", function(self) 
		if (not menuWindow:IsShown()) then
			menuButton:SetButtonState("NORMAL")
		end
	end)
end

MenuWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db

	local Main = Module:GetWidget("Controller: Main"):GetFrame()
	local Menu = Module:GetWidget("Controller: Menu"):GetFrame()
	local MenuButton = Module:GetWidget("Template: MenuButton")
	local FlyoutBar = Module:GetWidget("Template: FlyoutBar")

	-- config table shortcuts
	local main_menu_config = config.structure.controllers.mainmenu
	local micro_menu_config = config.visuals.menus.main.micromenu
	local actionbar_menu_config = config.visuals.menus.main.barmenu
	local bagbar_menu_config = config.visuals.menus.main.bagmenu


	-- Main Buttons
	---------------------------------------------
	local MasterMenuButton = MenuButton:New(Menu)
	MasterMenuButton:SetPoint("BOTTOMRIGHT")
	MasterMenuButton:SetSize(unpack(micro_menu_config.button.size))
	self:Skin(MasterMenuButton, micro_menu_config, "cogs")

	local BagBarMenuButton = MenuButton:New(Menu)
	BagBarMenuButton:SetPoint("BOTTOMRIGHT", MasterMenuButton, "BOTTOMLEFT", -main_menu_config.padding, 0 )
	BagBarMenuButton:SetSize(unpack(bagbar_menu_config.button.size))
	self:Skin(BagBarMenuButton, micro_menu_config, "bag")

	local MicroMenuButton = MenuButton:New(Menu)
	MicroMenuButton:SetSize(unpack(micro_menu_config.button.size))
	self:Skin(MicroMenuButton, micro_menu_config, "mainmenu")

	local ActionBarMenuButton = MenuButton:New(Menu)
	ActionBarMenuButton:SetSize(unpack(actionbar_menu_config.button.size))
	self:Skin(ActionBarMenuButton, micro_menu_config, "bars")


	-- Menu Window #0: MasterMenu
	---------------------------------------------
	local MasterMenuWindow = FlyoutBar:New(MasterMenuButton)
	MasterMenuWindow:AttachToButton(MasterMenuButton)
	MasterMenuWindow:SetPoint(unpack(micro_menu_config.position))
	MasterMenuWindow:SetBackdrop(micro_menu_config.backdrop)
	MasterMenuWindow:SetBackdropColor(unpack(micro_menu_config.backdrop_color))
	MasterMenuWindow:SetBackdropBorderColor(unpack(micro_menu_config.backdrop_border_color))
	MasterMenuWindow:SetWindowInsets(unpack(micro_menu_config.insets))
	MasterMenuWindow:SetButtonSize(unpack(micro_menu_config.button.size))
	MasterMenuWindow:SetButtonPadding(micro_menu_config.button.padding)
	MasterMenuWindow:SetButtonAnchor("BOTTOMRIGHT")
	MasterMenuWindow:SetButtonGrowthX("LEFT")
	MasterMenuWindow:SetButtonGrowthY("UP")
	MasterMenuWindow:SetJustify("RIGHT")
	MasterMenuWindow:SetRowSize(1)
	MasterMenuWindow:SetRowSpacing(micro_menu_config.button.spacing)
	MasterMenuWindow:InsertButton(MicroMenuButton)
	MasterMenuWindow:InsertButton(ActionBarMenuButton)
	MasterMenuWindow:Arrange()

	self.MasterMenuWindow = MasterMenuWindow


	-- Menu Window #1: MicroMenu
	---------------------------------------------
	local MicroMenuWindow = FlyoutBar:New(MicroMenuButton)
	MicroMenuWindow:AttachToButton(MicroMenuButton)
	MicroMenuWindow:SetBackdrop(micro_menu_config.backdrop)
	MicroMenuWindow:SetBackdropColor(unpack(micro_menu_config.backdrop_color))
	MicroMenuWindow:SetBackdropBorderColor(unpack(micro_menu_config.backdrop_border_color))
	MicroMenuWindow:SetWindowInsets(unpack(micro_menu_config.insets))
	MicroMenuWindow:SetButtonSize(unpack(micro_menu_config.button.size))
	MicroMenuWindow:SetButtonPadding(micro_menu_config.button.padding)
	MicroMenuWindow:SetRowSpacing(micro_menu_config.button.spacing)
	MicroMenuWindow:SetButtonAnchor("BOTTOMRIGHT")
	MicroMenuWindow:SetPoint("BOTTOMRIGHT", MicroMenuButton, "BOTTOMLEFT", -micro_menu_config.button.padding, 0)
	MicroMenuWindow:SetButtonGrowthX("LEFT")
	MicroMenuWindow:SetButtonGrowthY("UP")
	MicroMenuWindow:SetJustify("LEFT")
	MicroMenuWindow:SetRowSize(5)

	self.MicroMenuWindow = MicroMenuWindow -- needed for some callbacks later on
	
	local button_to_icon = {} -- simple mapping of icons to the buttons
	local faction = UnitFactionGroup("player") -- to get the right faction icon, or neutral
	
	-- There are no visual changes from WoD to Legion, so we're using the same code.
	-- Should be noted though that the HelpMicroButton was removed from the game 
	-- in wow client patch 7.2.0 (Legion), so it can't be referenced at all from this point.
	if ENGINE_WOD then
		MicroMenuWindow:InsertButton(CharacterMicroButton)
		MicroMenuWindow:InsertButton(SpellbookMicroButton)
		MicroMenuWindow:InsertButton(TalentMicroButton)
		MicroMenuWindow:InsertButton(AchievementMicroButton)
		MicroMenuWindow:InsertButton(QuestLogMicroButton)
		MicroMenuWindow:InsertButton(GuildMicroButton)
		MicroMenuWindow:InsertButton(LFDMicroButton)
		MicroMenuWindow:InsertButton(CollectionsMicroButton)
		MicroMenuWindow:InsertButton(EJMicroButton)
		
		-- Starter Edition accounts haven't got this feature.
		if C_StorePublic and C_StorePublic.IsEnabled() then
			MicroMenuWindow:InsertButton(StoreMicroButton)
		end
		
		MicroMenuWindow:InsertButton(MainMenuMicroButton)

		button_to_icon = {
			[CharacterMicroButton] = "character", 
			[SpellbookMicroButton] = "spellbook", 
			[TalentMicroButton] = "talents", 
			[AchievementMicroButton] = "achievements", 
			[QuestLogMicroButton] = "worldmap", 
			[GuildMicroButton] = "guild", 
			[LFDMicroButton] = "raid", 
			[CollectionsMicroButton] = "mount", 
			[EJMicroButton] = "encounterjournal", 
			[StoreMicroButton] = "store", 
			[MainMenuMicroButton] = "cogs"
		}
	
	elseif ENGINE_MOP then
		MicroMenuWindow:InsertButton(CharacterMicroButton)
		MicroMenuWindow:InsertButton(SpellbookMicroButton)
		MicroMenuWindow:InsertButton(TalentMicroButton)
		MicroMenuWindow:InsertButton(AchievementMicroButton)
		MicroMenuWindow:InsertButton(QuestLogMicroButton)
		MicroMenuWindow:InsertButton(GuildMicroButton)
		MicroMenuWindow:InsertButton(PVPMicroButton)
		MicroMenuWindow:InsertButton(LFDMicroButton)
		MicroMenuWindow:InsertButton(CompanionsMicroButton)
		MicroMenuWindow:InsertButton(EJMicroButton)
		MicroMenuWindow:InsertButton(StoreMicroButton)
		MicroMenuWindow:InsertButton(MainMenuMicroButton)

		button_to_icon = {
			[CharacterMicroButton] = "character", 
			[SpellbookMicroButton] = "spellbook", 
			[TalentMicroButton] = "talents", 
			[AchievementMicroButton] = "achievements", 
			[QuestLogMicroButton] = "questlog", 
			[GuildMicroButton] = "guild", 
			[PVPMicroButton] = faction == "Alliance" and "alliance" or faction == "Horde" and "horde" or "neutral", 
			[LFDMicroButton] = "raid", 
			[CompanionsMicroButton] = "mount", 
			[EJMicroButton] = "encounterjournal", 
			[StoreMicroButton] = "store", 
			[MainMenuMicroButton] = "cogs"
		}

	elseif ENGINE_CATA then
		MicroMenuWindow:InsertButton(CharacterMicroButton)
		MicroMenuWindow:InsertButton(SpellbookMicroButton)
		MicroMenuWindow:InsertButton(TalentMicroButton)
		MicroMenuWindow:InsertButton(AchievementMicroButton)
		MicroMenuWindow:InsertButton(QuestLogMicroButton)
		MicroMenuWindow:InsertButton(GuildMicroButton)
		MicroMenuWindow:InsertButton(PVPMicroButton)
		MicroMenuWindow:InsertButton(LFDMicroButton)
		MicroMenuWindow:InsertButton(RaidMicroButton)
		MicroMenuWindow:InsertButton(EJMicroButton)
		MicroMenuWindow:InsertButton(MainMenuMicroButton)
		
		button_to_icon = {
			[CharacterMicroButton] = "character", 
			[SpellbookMicroButton] = "spellbook", 
			[TalentMicroButton] = "talents", 
			[AchievementMicroButton] = "achievements", 
			[QuestLogMicroButton] = "questlog", 
			[GuildMicroButton] = "guild", 
			[PVPMicroButton] = faction == "Alliance" and "alliance" or faction == "Horde" and "horde" or "neutral", 
			[LFDMicroButton] = "group", 
			[RaidMicroButton] = "raid", 
			[EJMicroButton] = "encounterjournal", 
			[MainMenuMicroButton] = "cogs"
		}

	else
		MicroMenuWindow:InsertButton(CharacterMicroButton)
		MicroMenuWindow:InsertButton(SpellbookMicroButton)
		MicroMenuWindow:InsertButton(TalentMicroButton)
		MicroMenuWindow:InsertButton(AchievementMicroButton)
		MicroMenuWindow:InsertButton(QuestLogMicroButton)
		MicroMenuWindow:InsertButton(SocialsMicroButton)
		MicroMenuWindow:InsertButton(PVPMicroButton)
		MicroMenuWindow:InsertButton(LFDMicroButton)
		MicroMenuWindow:InsertButton(MainMenuMicroButton)
		MicroMenuWindow:InsertButton(HelpMicroButton)

		button_to_icon = {
			[CharacterMicroButton] = "character", 
			[SpellbookMicroButton] = "spellbook", 
			[TalentMicroButton] = "talents", 
			[AchievementMicroButton] = "achievements", 
			[QuestLogMicroButton] = "questlog", 
			[SocialsMicroButton] = "group", 
			[PVPMicroButton] = faction == "Alliance" and "alliance" or faction == "Horde" and "horde" or "neutral", 
			[LFDMicroButton] = "raid", 
			[MainMenuMicroButton] = "cogs",
			[HelpMicroButton] = "bug"
		}

	end
	
	-- Disable Blizzard texture changes and stuff from these buttons.
	-- Also re-align their tooltips to be above our menu.
	for index,button in MicroMenuWindow:GetAll() do
	
		self:Strip(button)
		self:Skin(button, micro_menu_config, button_to_icon[button])
		
		button.OnEnter = button:GetScript("OnEnter")
		button.OnLeave = button:GetScript("OnLeave")

		button:SetScript("OnEnter", function(self) 
			if GameTooltip:IsForbidden() then
				return
			end
			self:OnEnter()
			if GameTooltip:IsShown() and GameTooltip:GetOwner() == self then
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOMRIGHT", MicroMenuWindow, "TOPRIGHT", -10, 10)
			end
		end)
		
		button:SetScript("OnLeave", function(self) 
			if GameTooltip:IsForbidden() then
				return
			end
			self:OnLeave()
		end)
		
		MasterMenuWindow:AddToAutoHide(button)
	end
	
	-- Remove the character button portrait
	if MicroButtonPortrait then
		MicroButtonPortrait:SetParent(UIHider)
	end
	
	-- Remove the guild tabard
	if GuildMicroButtonTabard then
		GuildMicroButtonTabard:SetParent(UIHider)
	end	

	-- Remove the pvp frame icon, and add our own
	if PVPMicroButtonTexture then 
		PVPMicroButtonTexture:SetParent(UIHider)
	end
	
	-- Kill off the game menu button latency display
	if MainMenuBarPerformanceBar then
		MainMenuBarPerformanceBar:SetParent(UIHider)
	end
	
	-- wild hacks to control the tooltip position
	if MainMenuBarPerformanceBarFrame_OnEnter then
		hooksecurefunc("MainMenuBarPerformanceBarFrame_OnEnter", function() 
			if GameTooltip:IsForbidden() then
				return
			end
			if GameTooltip:IsShown() and GameTooltip:GetOwner() == MainMenuMicroButton then
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOMRIGHT", MicroMenuWindow, "TOPRIGHT", -10, 10)
			end
		end)
	end

	-- Kill of the game menu button download texture
	if MainMenuBarDownload then
		MainMenuBarDownload:SetParent(UIHider)
	end

	if UpdateMicroButtonsParent then
		hooksecurefunc("UpdateMicroButtonsParent", function(parent) 
			if InCombatLockdown() then
				self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateMicroButtons")
			else
				MicroMenuWindow:Arrange()
			end
		end)
	end

	if MoveMicroButtons then
		hooksecurefunc("MoveMicroButtons", function() 
			if InCombatLockdown() then
				self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateMicroButtons")
			else
				MicroMenuWindow:Arrange()
			end
		end)
	end
	
	if UpdateMicroButtons then
		hooksecurefunc("UpdateMicroButtons", function() 
			if InCombatLockdown() then
				self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateMicroButtons")
			else
				MicroMenuWindow:Arrange()
			end
		end)
	end

	-- Arrange the buttons and size the window
	MicroMenuWindow:Arrange()
	


	-- Menu Window #2: ActionBars
	---------------------------------------------
	local ActionBarMenuWindow = FlyoutBar:New(ActionBarMenuButton)
	ActionBarMenuWindow:AttachToButton(ActionBarMenuButton)
	ActionBarMenuWindow:SetSize(unpack(actionbar_menu_config.size))
	ActionBarMenuWindow:SetPoint("BOTTOMRIGHT", MicroMenuWindow, "BOTTOMRIGHT", 15, -17)
	ActionBarMenuWindow:SetBackdrop(actionbar_menu_config.backdrop)
	ActionBarMenuWindow:SetBackdropColor(unpack(actionbar_menu_config.backdrop_color))
	ActionBarMenuWindow:SetBackdropBorderColor(unpack(actionbar_menu_config.backdrop_border_color))
	ActionBarMenuWindow:SetWindowInsets(unpack(actionbar_menu_config.insets))
	ActionBarMenuWindow:SetButtonSize(unpack(actionbar_menu_config.button.size))
	ActionBarMenuWindow:SetButtonAnchor(actionbar_menu_config.button.anchor)
	ActionBarMenuWindow:SetButtonPadding(actionbar_menu_config.button.padding)
	ActionBarMenuWindow:SetButtonGrowthX(actionbar_menu_config.button.growthX)
	ActionBarMenuWindow:SetButtonGrowthY(actionbar_menu_config.button.growthY)
	
	MasterMenuWindow:AddToAutoHide(ActionBarMenuWindow)

	-- Raise your hand if you hate writing menus!!!1 >:(
	do
		local insets = actionbar_menu_config.insets
		local ui_width = ActionBarMenuWindow:GetWidth() - (insets[1] + insets[2])
		local ui_padding = 4
		local ui_paragraph = 10
		
		local style_table = actionbar_menu_config.ui.window
		local style_table_button = actionbar_menu_config.ui.menubutton
		local new = ActionBarMenuWindow
		
			-- Header1
			------------------------------------------------------------------
			new.header = CreateFrame("Frame", nil, new)
			new.header:SetPoint("TOP", 0, -style_table.header.insets[3])
			new.header:SetPoint("LEFT", style_table.header.insets[1], 0)
			new.header:SetPoint("RIGHT", -style_table.header.insets[2], 0)
			new.header:SetHeight(style_table.header.height)
			new.header:SetBackdrop(style_table.header.backdrop)
			new.header:SetBackdropColor(unpack(style_table.header.backdrop_color))
			new.header:SetBackdropBorderColor(unpack(style_table.header.backdrop_border_color))
			
			-- title
			new.title = new.header:CreateFontString(nil, "ARTWORK")
			new.title:SetPoint("CENTER")
			new.title:SetJustifyV("TOP")
			new.title:SetJustifyH("CENTER")
			new.title:SetFontObject(style_table.header.title.normalFont) 
			new.title:SetText(L["Action Bars"])
			
			-- Body
			------------------------------------------------------------------
			new.body = CreateFrame("Frame", nil, new)
			new.body:SetPoint("TOP", new.header, "BOTTOM", 0, -style_table.padding)
			new.body:SetPoint("LEFT", style_table.body.insets[1], 0)
			new.body:SetPoint("RIGHT", -style_table.body.insets[2], 0)
			new.body:SetBackdrop(style_table.body.backdrop)
			new.body:SetBackdropColor(unpack(style_table.body.backdrop_color))
			new.body:SetBackdropBorderColor(unpack(style_table.body.backdrop_border_color))
			new.body:SetHeight(style_table_button.size[2]*3 + 16*2 + 4*2)
			
			-- Buttons
			------------------------------------------------------------------
			new.button1 = self:NewMenuButton(new.body, style_table_button, L["One"])
			new.button1:SetPoint("TOP", 0, -16 )
			new.button1:SetFrameRef("controller", Main)
			new.button1:SetAttribute("_onclick", [[
				local controller = self:GetFrameRef("controller");
				controller:SetAttribute("numbars", 1);
			]])

			new.button2 = self:NewMenuButton(new.body, style_table_button, L["Two"])
			new.button2:SetPoint("TOP", new.button1, "BOTTOM", 0, -4 )
			new.button2:SetFrameRef("controller", Main)
			new.button2:SetAttribute("_onclick", [[
				local controller = self:GetFrameRef("controller");
				controller:SetAttribute("numbars", 2);
			]])

			new.button3 = self:NewMenuButton(new.body, style_table_button, L["Three"])
			new.button3:SetPoint("TOP", new.button2, "BOTTOM", 0, -4 )
			new.button3:SetFrameRef("controller", Main)
			new.button3:SetAttribute("_onclick", [[
				local controller = self:GetFrameRef("controller");
				controller:SetAttribute("numbars", 3);
			]])


			-- Header2
			------------------------------------------------------------------
			new.header2 = CreateFrame("Frame", nil, new)
			new.header2:SetPoint("TOP", new.body, "BOTTOM", 0, -style_table.padding)
			new.header2:SetPoint("LEFT", style_table.header.insets[1], 0)
			new.header2:SetPoint("RIGHT", -style_table.header.insets[2], 0)
			new.header2:SetHeight(style_table.header.height)
			new.header2:SetBackdrop(style_table.header.backdrop)
			new.header2:SetBackdropColor(unpack(style_table.header.backdrop_color))
			new.header2:SetBackdropBorderColor(unpack(style_table.header.backdrop_border_color))

			-- title2
			new.title2 = new.header2:CreateFontString(nil, "ARTWORK")
			new.title2:SetPoint("CENTER")
			new.title2:SetJustifyV("TOP")
			new.title2:SetJustifyH("CENTER")
			new.title2:SetFontObject(style_table.header.title.normalFont)  
			new.title2:SetText(L["Side Bars"])


			-- Body2
			------------------------------------------------------------------
			new.body2 = CreateFrame("Frame", nil, new)
			new.body2:SetPoint("TOP", new.header2, "BOTTOM", 0, -style_table.padding)
			new.body2:SetPoint("LEFT", style_table.body.insets[1], 0)
			new.body2:SetPoint("RIGHT", -style_table.body.insets[2], 0)
			new.body2:SetBackdrop(style_table.body.backdrop)
			new.body2:SetBackdropColor(unpack(style_table.body.backdrop_color))
			new.body2:SetBackdropBorderColor(unpack(style_table.body.backdrop_border_color))
			new.body2:SetHeight(style_table_button.size[2]*3 + 16*2 + 4*2)
			
			-- Buttons2
			------------------------------------------------------------------
			new.button4 = self:NewMenuButton(new.body2, style_table_button, L["No Bars"])
			new.button4:SetPoint("TOP", 0, -16 )
			new.button4:SetFrameRef("controller", Main)
			new.button4:SetAttribute("_onclick", [[
				local controller = self:GetFrameRef("controller");
				controller:SetAttribute("numsidebars", 0);
			]])

			new.button5 = self:NewMenuButton(new.body2, style_table_button, L["One"])
			new.button5:SetPoint("TOP", new.button4, "BOTTOM", 0, -4 )
			new.button5:SetFrameRef("controller", Main)
			new.button5:SetAttribute("_onclick", [[
				local controller = self:GetFrameRef("controller");
				controller:SetAttribute("numsidebars", 1);
			]])

			new.button6 = self:NewMenuButton(new.body2, style_table_button, L["Two"])
			new.button6:SetPoint("TOP", new.button5, "BOTTOM", 0, -4 )
			new.button6:SetFrameRef("controller", Main)
			new.button6:SetAttribute("_onclick", [[
				local controller = self:GetFrameRef("controller");
				controller:SetAttribute("numsidebars", 2);
			]])


			-- Footer
			------------------------------------------------------------------
			new.footer = CreateFrame("Frame", nil, new)
			new.footer:SetPoint("TOP", new.body2, "BOTTOM", 0, -style_table.footer.offset)
			new.footer:SetPoint("LEFT", style_table.footer.insets[1], 0)
			new.footer:SetPoint("RIGHT", -style_table.footer.insets[2], 0)
			new.footer:SetPoint("BOTTOM", 0, style_table.footer.insets[3])
			new.footer:SetBackdrop(style_table.footer.backdrop)
			new.footer:SetBackdropColor(unpack(style_table.footer.backdrop_color))
			new.footer:SetBackdropBorderColor(unpack(style_table.footer.backdrop_border_color))

			-- message
			new.message = new.footer:CreateFontString(nil, "ARTWORK")
			new.message:SetWidth(new.footer:GetWidth() - (style_table.footer.message.insets[1] + style_table.footer.message.insets[2]))
			new.message:SetPoint("TOP")
			new.message:SetPoint("LEFT")
			new.message:SetPoint("RIGHT")
			new.message:SetJustifyV("TOP")
			new.message:SetJustifyH("CENTER")
			new.message:SetIndentedWordWrap(false)
			new.message:SetWordWrap(true)
			new.message:SetNonSpaceWrap(false)
			new.message:SetSpacing(0) -- or it will become truncated
			new.message:SetPoint("TOP", 0, -style_table.footer.message.insets[3])
			new.message:SetPoint("LEFT", style_table.footer.message.insets[1], 0)
			new.message:SetPoint("RIGHT", -style_table.footer.message.insets[2], 0)
			new.message:SetFontObject(style_table.footer.message.normalFont) 
			new.message:SetText(L["Hold |cff00b200<Alt+Ctrl+Shift>|r and drag to remove spells, macros and items from the action buttons."])
		

	end
	


	-- Menu Window #3: BagBar
	---------------------------------------------
	local BagBarMenuWindow = FlyoutBar:New(BagBarMenuButton)
	BagBarMenuWindow:Hide()
	--BagBarMenuWindow:AttachToButton(BagBarMenuButton)
	BagBarMenuWindow:SetSize(unpack(bagbar_menu_config.size))
	BagBarMenuWindow:SetPoint(unpack(bagbar_menu_config.position))
	BagBarMenuWindow:SetBackdrop(bagbar_menu_config.backdrop)
	BagBarMenuWindow:SetBackdropColor(unpack(bagbar_menu_config.backdrop_color))
	BagBarMenuWindow:SetBackdropBorderColor(unpack(bagbar_menu_config.backdrop_border_color))
	
	BagBarMenuButton.OnEnter = function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		if MasterMenuButton:GetButtonState() == "PUSHED"
		or BagBarMenuButton:GetButtonState() == "PUSHED" then
			GameTooltip:Hide()
			return
		end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(L["Bags"])
		GameTooltip:AddLine(L["<Left-click> to toggle bags."], 0, .7, 0)
		GameTooltip:AddLine(L["<Right-click> to toggle bag bar."], 0, .7, 0)
		GameTooltip:Show()
	end
	BagBarMenuButton:SetScript("OnEnter", BagBarMenuButton.OnEnter)
	BagBarMenuButton:SetScript("OnLeave", function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		GameTooltip:Hide() 
	end)

	MasterMenuButton.OnEnter = function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		if MasterMenuButton:GetButtonState() == "PUSHED" 
		or BagBarMenuButton:GetButtonState() == "PUSHED" then
			GameTooltip:Hide()
			return
		end
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(L["Main Menu"])
		GameTooltip:AddLine(L["<Left-click> to toggle menu."], 0, .7, 0)
		GameTooltip:Show()
	end
	MasterMenuButton:SetScript("OnEnter", MasterMenuButton.OnEnter)
	MasterMenuButton:SetScript("OnLeave", function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		GameTooltip:Hide() 
	end)
	MasterMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			self:OnEnter() -- update tooltips
		end
	end


	ActionBarMenuButton.OnEnter = function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		if ActionBarMenuButton:GetButtonState() == "PUSHED"
		or MicroMenuButton:GetButtonState() == "PUSHED" then
			GameTooltip:Hide()
			return
		end
		GameTooltip:SetOwner(MicroMenuButton, "ANCHOR_NONE")
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOMRIGHT", MicroMenuButton, "BOTTOMLEFT", -10, 10)
		GameTooltip:AddLine(L["Action Bars"])
		GameTooltip:AddLine(L["<Left-click> to toggle action bar menu."], 0, .7, 0)
		GameTooltip:Show()
	end
	ActionBarMenuButton:SetScript("OnEnter", ActionBarMenuButton.OnEnter)
	ActionBarMenuButton:SetScript("OnLeave", function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		GameTooltip:Hide() 
	end)
	ActionBarMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			self:OnEnter() -- update tooltips
		end
	end

	MicroMenuButton.OnEnter = function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		if MicroMenuButton:GetButtonState() == "PUSHED" 
		or ActionBarMenuButton:GetButtonState() == "PUSHED" then
				GameTooltip:Hide()
			return
		end
		GameTooltip:SetOwner(MicroMenuButton, "ANCHOR_NONE")
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOMRIGHT", MicroMenuButton, "BOTTOMLEFT", -10, 10)
		GameTooltip:AddLine(L["Blizzard Micro Menu"])
		GameTooltip:AddLine(L["Here you'll find all the common interface panels|nlike the spellbook, talents, achievements etc."], .9,.9,.9)
		GameTooltip:AddLine(L["<Left-click> to toggle menu."], 0, .7, 0)
		GameTooltip:Show()
	end
	MicroMenuButton:SetScript("OnEnter", MicroMenuButton.OnEnter)
	MicroMenuButton:SetScript("OnLeave", function(self) 
		if GameTooltip:IsForbidden() then
			return
		end
		GameTooltip:Hide() 
	end)
	MicroMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			self:OnEnter() -- update tooltips
		end
	end


	local BagWindow = ContainerFrame1 -- to easier transition to our custom bags later
	
	-- Move the backpack-, bag- and keyring buttons to a visible frame
	MainMenuBarBackpackButton:SetParent(BagBarMenuWindow)
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", BagBarMenuWindow, "BOTTOMRIGHT", -bagbar_menu_config.insets[2], bagbar_menu_config.insets[4])
	
	CharacterBag0Slot:SetParent(BagBarMenuWindow)
	CharacterBag1Slot:SetParent(BagBarMenuWindow)
	CharacterBag2Slot:SetParent(BagBarMenuWindow)
	CharacterBag3Slot:SetParent(BagBarMenuWindow)

	-- The keyring was removed in 4.2.0 in Cata
	if not ENGINE_CATA then
		KeyRingButton:SetParent(BagBarMenuWindow)
		KeyRingButton:Show()
	end

	BagBarMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			if ENGINE_CATA then
				-- This leads to a taint sometimes:
				-- Global variable BACKPACK_HEIGHT tainted by DiabolicUI - Interface\FrameXML\ContainerFrame.lua:792 ContainerFrame_GenerateFrame()
				ToggleAllBags() -- functionality on OpenAllBags was changed in Cata from toggle to pure open.
			else
				OpenAllBags() -- Toggle bag frames. This was actually a toggle function in WotLK.
			end
		elseif button == "RightButton" then
			-- Bagbar was toggled by the secure environement. Put any post updates here, if needed.
		end
		-- toggle anchors
		if false then
			if updateContainerFrameAnchors then
				updateContainerFrameAnchors() 
			elseif UpdateContainerFrameAnchors then
				UpdateContainerFrameAnchors()
			end
		end 
		self:OnEnter() -- update tooltips
	end
	
	
	-- Hook the bagbutton's pushed state to the backpack.
	BagBarMenuWindow:HookScript("OnShow", function() BagBarMenuButton:SetButtonState("PUSHED", 1) end)
	BagBarMenuWindow:HookScript("OnHide", function() 
		if not BagWindow:IsShown() then
			BagBarMenuButton:SetButtonState("NORMAL") 
		end
	end)

	BagWindow:HookScript("OnShow", function(self) 
		BagBarMenuButton:SetButtonState("PUSHED", 1)
	end)
	
	BagWindow:HookScript("OnHide", function(self) 
		if not BagBarMenuWindow:IsShown() then
			BagBarMenuButton:SetButtonState("NORMAL")
		end
	end)

	if Engine:IsAddOnEnabled("Bagnon") then
		if IsAddOnLoaded("Bagnon") then
			self:HookBagnon(BagBarMenuButton, BagBarMenuWindow)
		else
			local proxy 
			proxy = function(_, event, addon) 
				if (addon ~= "Bagnon") then
					return
				end
				self:HookBagnon(BagBarMenuButton, BagBarMenuWindow)
				self:UnregisterEvent("ADDON_LOADED", proxy)
			end
			self:RegisterEvent("ADDON_LOADED", proxy)
		end
	end

	if Engine:IsAddOnEnabled("LiteBag") then
		if IsAddOnLoaded("LiteBag") then
			self:HookLiteBag(BagBarMenuButton, BagBarMenuWindow)
		else
			local proxy 
			proxy = function(_, event, addon) 
				if (addon ~= "LiteBag") then
					return
				end
				self:HookLiteBag(BagBarMenuButton, BagBarMenuWindow)
				self:UnregisterEvent("ADDON_LOADED", proxy)
			end
			self:RegisterEvent("ADDON_LOADED", proxy)
		end
	end

	
	BagBarMenuButton:SetFrameRef("bags", BagWindow)
	BagBarMenuButton:SetFrameRef("window", BagBarMenuWindow)
	BagBarMenuButton:SetFrameRef("otherwindow1", ActionBarMenuWindow)
	BagBarMenuButton:SetFrameRef("otherwindow2", MicroMenuWindow)
	BagBarMenuButton:SetFrameRef("otherwindow3", MasterMenuWindow)
	BagBarMenuButton:SetAttribute("_onclick", [[
		self:GetFrameRef("otherwindow1"):Hide();
		self:GetFrameRef("otherwindow2"):Hide();
		self:GetFrameRef("otherwindow3"):Hide();
		
		local window = self:GetFrameRef("window"); -- bag bar
		local bags
		if not PlayerInCombat() then
			bags = self:GetFrameRef("bags"); -- backpack (insecure frame, can't be accessed in combat)
		end

		if button == "LeftButton" then
			if bags then 
				if bags:IsShown() and window:IsShown() then
					window:Hide(); -- hide the bagbar when hiding the bags (only works out of combat)
				end
			end
		elseif button == "RightButton" then
			-- this will toggle the bagbar
			if window:IsShown() then
				window:Hide();
			else
				window:Show();
			end
		end
		control:CallMethod("OnClick", button);
	]])

	 -- Close the bags when showing any of our other windows.
	MasterMenuWindow:HookScript("OnShow", CloseAllBags)
	MicroMenuWindow:HookScript("OnShow", CloseAllBags)
	ActionBarMenuWindow:HookScript("OnShow", CloseAllBags)
		
	-- Make sure clicking one main button hides the rest and their windows.
	MicroMenuButton:SetFrameRef("otherwindow1", ActionBarMenuWindow)
	MicroMenuButton:SetFrameRef("otherwindow2", BagBarMenuWindow)
	MicroMenuButton:SetAttribute("leftclick", [[
		self:GetFrameRef("otherwindow1"):Hide()
		self:GetFrameRef("otherwindow2"):Hide()
		--self:GetFrameRef("otherwindow3"):Hide()
	]])

	-- Make sure clicking one main button hides the rest and their windows.
	MasterMenuButton:SetFrameRef("otherwindow1", BagBarMenuWindow)
	MasterMenuButton:SetFrameRef("otherwindow2", ActionBarMenuWindow)
	MasterMenuButton:SetFrameRef("otherwindow3", MicroMenuWindow)
	MasterMenuButton:SetAttribute("leftclick", [[
		self:GetFrameRef("otherwindow1"):Hide()
		self:GetFrameRef("otherwindow2"):Hide()
		self:GetFrameRef("otherwindow3"):Hide()
	]])

	ActionBarMenuButton:SetFrameRef("otherwindow1", MicroMenuWindow)
	ActionBarMenuButton:SetFrameRef("otherwindow2", BagBarMenuWindow)
	ActionBarMenuButton:SetAttribute("leftclick", [[
		self:GetFrameRef("otherwindow1"):Hide();
		self:GetFrameRef("otherwindow2"):Hide();
	]])


	-- Texts
	---------------------------------------------
	local Performance = MasterMenuButton:CreateFontString()
	Performance:SetDrawLayer("ARTWORK")
	Performance:SetFontObject(micro_menu_config.performance.normalFont)
	Performance:SetPoint(unpack(micro_menu_config.performance.position))
	
	MasterMenuButton.Performance = Performance
	
	local performance_string = "%d%s - %d%s"
	local performance_hz = 1
	local MILLISECONDS_ABBR = MILLISECONDS_ABBR
	local FPS_ABBR = FPS_ABBR
	
	local floor = math.floor


	local Gold = MasterMenuButton:CreateFontString()
	Gold:SetDrawLayer("ARTWORK")
	Gold:SetFontObject(micro_menu_config.performance.normalFont)
	Gold:SetPoint(unpack(micro_menu_config.performance.position))
	MasterMenuButton.Gold = Gold

	MasterMenuButton:SetScript("OnEvent", function(self, event, ...) 
		local money = GetMoney()
		local gold = floor(money / 100 / 100)
		local silver = floor((money / 100) % 100)
		local copper = money % 100
		if (gold > 0) then
			self.Gold:SetFormattedText("%d|cffc98910g|r %d|cffa8a8a8s|r %d|cffb87333c|r", gold, silver, copper)
		elseif (silver > 0) then
			self.Gold:SetFormattedText("%d|cffa8a8a8s|r %d|cffb87333c|r", silver, copper)
		else 
			self.Gold:SetFormattedText("%d|cffb87333c|r", copper)
		end
	end)

	MasterMenuButton:RegisterEvent("PLAYER_MONEY")
	MasterMenuButton:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	-- MasterMenuButton:SetScript("OnUpdate", function(self, elapsed) 
	-- 	self.elapsed = (self.elapsed or 0) + elapsed
	-- 	if self.elapsed > performance_hz then
	-- 		local _, _, chat_latency, cast_latency = GetNetStats()
	-- 		local fps = floor(GetFramerate())
	-- 		if not cast_latency or cast_latency == 0 then
	-- 			cast_latency = chat_latency
	-- 		end
	-- 		self.Performance:SetFormattedText(performance_string, cast_latency, MILLISECONDS_ABBR, fps, FPS_ABBR)
	-- 		self.elapsed = 0
	-- 	end
	-- end)


	-- Sounds
	---------------------------------------------
	ActionBarMenuWindow:HookScript("OnShow", function(self) PlaySoundKitID(SOUNDKIT.IG_MAINMENU_OPEN, "SFX") end)
	ActionBarMenuWindow:HookScript("OnHide", function(self) PlaySoundKitID(SOUNDKIT.IG_MAINMENU_CLOSE, "SFX") end)

	MicroMenuWindow:HookScript("OnShow", function(self) PlaySoundKitID(SOUNDKIT.IG_MAINMENU_OPEN, "SFX") end)
	MicroMenuWindow:HookScript("OnHide", function(self) PlaySoundKitID(SOUNDKIT.IG_MAINMENU_CLOSE, "SFX") end)

	MasterMenuWindow:HookScript("OnShow", function(self) PlaySoundKitID(SOUNDKIT.IG_MAINMENU_OPEN, "SFX") end)
	MasterMenuWindow:HookScript("OnHide", function(self) PlaySoundKitID(SOUNDKIT.IG_MAINMENU_CLOSE, "SFX") end)
	

	-- We need to manually handle this, as our actionbar script 
	-- is blocking this event for the talent button. Or?
	self:RegisterEvent("PLAYER_LEVEL_UP", "OnEvent")	
end

MenuWidget.OnEvent = function(self, event, ...)
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
	end

	-- This should fire off our own post updates too.
	UpdateMicroButtons() 
end
