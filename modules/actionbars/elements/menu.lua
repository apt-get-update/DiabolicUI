local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local MenuWidget = Module:SetWidget("Menu: Main")
local L = Engine:GetLocale()

-- Lua API
local ipairs, select, unpack = ipairs, select, unpack
local floor = math.floor

-- WoW API
local CreateFrame = _G.CreateFrame
local GetFramerate = _G.GetFramerate
local GetGuildRosterInfo = _G.GetGuildRosterInfo
local GetNetStats = _G.GetNetStats
local GetNumFriends = _G.GetNumFriends
local GetNumGuildMembers = _G.GetNumGuildMembers
local GuildRoster = _G.GuildRoster
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local IsInGuild = _G.IsInGuild
local PlaySound = _G.PlaySound
local UnitFactionGroup = _G.UnitFactionGroup

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

local UIHider = CreateFrame("Frame")
UIHider:Hide()


-- Adds the other guild members and the friends online to `tooltip` (the
-- social button's), after a blank line, when there are any. 3.3.5's
-- GetNumGuildMembers only gives one count: the roster, offline members
-- included, says who's online. A fresh roster is asked for the next time.
local AddPeopleLines = function(tooltip)
	local guildies = 0
	if IsInGuild() then
		GuildRoster()
		for i = 1, GetNumGuildMembers(true) do
			if select(9, GetGuildRosterInfo(i)) then
				guildies = guildies + 1
			end
		end
		guildies = guildies - 1 -- not you
	end
	local _, friends = GetNumFriends()

	if (guildies > 0) or (friends > 0) then
		tooltip:AddLine(" ")
		if (guildies > 0) then
			tooltip:AddDoubleLine(L["Guild Members Online:"], guildies, 1,1,1,1,.82,0)
		end
		if (friends > 0) then
			tooltip:AddDoubleLine(L["Friends Online:"], friends, 1,1,1,1,.82,0)
		end
	end
end

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

	local highlight = button:GetHighlightTexture()
	if highlight then
		button:SetHighlightTexture("")
		highlight:SetAlpha(0)
		highlight:SetSize(.0001, .0001)
	end

	-- the character and PvP buttons have none
	local disabled = button:GetDisabledTexture()
	if disabled then
		button:SetDisabledTexture("")
		disabled:SetAlpha(0)
		disabled:SetSize(.0001, .0001)
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
	local widget = self
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
	self.MicroMenuButton = MicroMenuButton
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

	-- Disable Blizzard texture changes and stuff from these buttons.
	-- Also re-align their tooltips to be above our menu.
	for index,button in MicroMenuWindow:GetAll() do
	
		self:Strip(button)
		self:Skin(button, micro_menu_config, button_to_icon[button])
		
		button.OnEnter = button:GetScript("OnEnter")
		button.OnLeave = button:GetScript("OnLeave")

		button:SetScript("OnEnter", function(self) 
			self:OnEnter()
			if GameTooltip:IsShown() and GameTooltip:GetOwner() == self then
				if (self == SocialsMicroButton) then
					AddPeopleLines(GameTooltip)
					GameTooltip:Show() -- resize to the new lines
				end
				widget:AnchorMicroTooltip()
			end
		end)
		
		button:SetScript("OnLeave", function(self) 
			self:OnLeave()
		end)
		
		MasterMenuWindow:AddToAutoHide(button)
	end
	
	-- Remove the character button portrait
	MicroButtonPortrait:SetParent(UIHider)

	-- Remove the pvp frame icon, and add our own
	PVPMicroButtonTexture:SetParent(UIHider)

	-- Kill off the game menu button latency display
	MainMenuBarPerformanceBar:SetParent(UIHider)

	-- wild hacks to control the tooltip position
	hooksecurefunc("MainMenuBarPerformanceBarFrame_OnEnter", function()
		if GameTooltip:IsShown() and GameTooltip:GetOwner() == MainMenuMicroButton then
			self:AnchorMicroTooltip()
		end
	end)

	-- re-arranged after combat if Blizzard changed the buttons in it
	hooksecurefunc("UpdateMicroButtons", function()
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateMicroButtons")
		else
			MicroMenuWindow:Arrange()
		end
	end)

	-- Arrange the buttons and size the window
	MicroMenuWindow:Arrange()
	


	-- Menu Window #2: ActionBars
	---------------------------------------------
	local ActionBarMenuWindow = FlyoutBar:New(ActionBarMenuButton)
	ActionBarMenuWindow:AttachToButton(ActionBarMenuButton)
	ActionBarMenuWindow:SetSize(unpack(actionbar_menu_config.size))
	ActionBarMenuWindow:SetPoint("BOTTOMRIGHT", MicroMenuWindow, "BOTTOMRIGHT", 15, -17)
	self.ActionBarMenuWindow = ActionBarMenuWindow
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
	BagBarMenuWindow:SetSize(unpack(bagbar_menu_config.size))
	BagBarMenuWindow:SetPoint(unpack(bagbar_menu_config.position))
	BagBarMenuWindow:SetBackdrop(bagbar_menu_config.backdrop)
	BagBarMenuWindow:SetBackdropColor(unpack(bagbar_menu_config.backdrop_color))
	BagBarMenuWindow:SetBackdropBorderColor(unpack(bagbar_menu_config.backdrop_border_color))
	
	BagBarMenuButton.OnEnter = function(self) 
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
		GameTooltip:Hide() 
	end)

	MasterMenuButton.OnEnter = function(self) 
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
		GameTooltip:Hide() 
	end)
	MasterMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			self:OnEnter() -- update tooltips
		end
	end


	ActionBarMenuButton.OnEnter = function(self) 
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
		GameTooltip:Hide() 
	end)
	ActionBarMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			self:OnEnter() -- update tooltips
		end
	end

	MicroMenuButton.OnEnter = function(self) 
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
	KeyRingButton:SetParent(BagBarMenuWindow)
	KeyRingButton:Show()

	BagBarMenuButton.OnClick = function(self, button) 
		if button == "LeftButton" then
			OpenAllBags() -- Toggle bag frames. This was actually a toggle function in WotLK.
		elseif button == "RightButton" then
			-- Bagbar was toggled by the secure environement. Put any post updates here, if needed.
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

	MasterMenuButton.Performance = Performance

	local performance_string = "%d%s - %d%s"
	local performance_hz = 1
	local MILLISECONDS_ABBR = MILLISECONDS_ABBR
	local FPS_ABBR = FPS_ABBR


	local Gold = MasterMenuButton:CreateFontString()
	Gold:SetDrawLayer("ARTWORK")
	Gold:SetFontObject(micro_menu_config.performance.normalFont)
	Gold:SetPoint(unpack(micro_menu_config.performance.position))
	MasterMenuButton.Gold = Gold

	local F = Engine:GetDB("Library: Format")
	MasterMenuButton:SetScript("OnEvent", function(self, event, ...)
		self.Gold:SetText(F.Money(GetMoney()))
	end)

	MasterMenuButton:RegisterEvent("PLAYER_MONEY")
	MasterMenuButton:RegisterEvent("PLAYER_ENTERING_WORLD")

	MasterMenuButton:SetScript("OnUpdate", function(self, elapsed)
		if not db.showPerformance then
			return
		end
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed > performance_hz then
			local _, _, latency = GetNetStats()
			local fps = floor(GetFramerate())
			self.Performance:SetFormattedText(performance_string, latency, MILLISECONDS_ABBR, fps, FPS_ABBR)
			self.elapsed = 0
		end
	end)

	self.MasterMenuButton = MasterMenuButton
	self.BagBarMenuButton = BagBarMenuButton
	self.BagBarMenuWindow = BagBarMenuWindow
	self:ApplySide()
	self:UpdateGoldVisibility()
	self:UpdatePerformanceVisibility()

	-- Ctrl+R (Blizzard's "Toggle Framerate" key binding) toggles our
	-- fps & latency text instead of Blizzard's own framerate display.
	hooksecurefunc("ToggleFramerate", function() self:TogglePerformance() end)


	-- Sounds
	---------------------------------------------
	ActionBarMenuWindow:HookScript("OnShow", function(self) PlaySound("igMainMenuOpen") end)
	ActionBarMenuWindow:HookScript("OnHide", function(self) PlaySound("igMainMenuClose") end)

	MicroMenuWindow:HookScript("OnShow", function(self) PlaySound("igMainMenuOpen") end)
	MicroMenuWindow:HookScript("OnHide", function(self) PlaySound("igMainMenuClose") end)

	MasterMenuWindow:HookScript("OnShow", function(self) PlaySound("igMainMenuOpen") end)
	MasterMenuWindow:HookScript("OnHide", function(self) PlaySound("igMainMenuClose") end)
	

	-- We need to manually handle this, as our actionbar script 
	-- is blocking this event for the talent button. Or?
	self:RegisterEvent("PLAYER_LEVEL_UP", "OnEvent")	
end

-- A config position { point, x, y } as seen in a mirror: left for right.
local Mirror = function(position)
	local point, x, y = unpack(position)
	return point:gsub("RIGHT", "\0"):gsub("LEFT", "RIGHT"):gsub("%z", "LEFT"), -x, y
end

-- Which side of the screen the menu buttons are on (moved with Unlock
-- Frames): on the right, the bags then the main menu, everything opening
-- leftwards; on the left, mirrored - the main menu then the bags. And on
-- the top half, the windows open downwards instead of upwards.
MenuWidget.GetSide = function(self)
	local controller = Module:GetWidget("Controller: Menu"):GetFrame()
	local x, y = controller:GetCenter()
	local centerX, centerY = Engine:GetFrame():GetCenter()
	local side = (x and centerX and x < centerX) and "LEFT" or "RIGHT"
	local edge = (y and centerY and y > centerY) and "TOP" or "BOTTOM"
	return side, edge
end

-- A point ("BOTTOMRIGHT") turned to that side and edge.
local Turn = function(point, side, edge)
	if (side == "LEFT") then
		point = point:gsub("RIGHT", "\0"):gsub("LEFT", "RIGHT"):gsub("%z", "LEFT")
	end
	if (edge == "TOP") then
		point = point:gsub("BOTTOM", "\0"):gsub("TOP", "BOTTOM"):gsub("%z", "TOP")
	end
	return point
end

-- The micro buttons' tooltips: beside their window, on its open side.
MenuWidget.AnchorMicroTooltip = function(self)
	local side, edge = self.side or "RIGHT", self.edge or "BOTTOM"
	local x, y = (side == "LEFT") and 10 or -10, (edge == "TOP") and -10 or 10
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint(Turn("BOTTOMRIGHT", side, edge), self.MicroMenuWindow, Turn("TOPRIGHT", side, edge), x, y)
end

-- The main menu's windows, opening away from the screen's edges.
MenuWidget.ApplyWindowSides = function(self, side, edge)
	local config = Module.config.visuals.menus.main.micromenu
	local padding = config.button.padding
	local h, v = (side == "LEFT") and -1 or 1, (edge == "TOP") and -1 or 1

	local master = self.MasterMenuWindow
	local point, x, y = unpack(config.position)
	master:ClearAllPoints()
	master:SetPoint(Turn(point, side, edge), x * h, y * v)
	master:SetButtonAnchor(Turn("BOTTOMRIGHT", side, edge))
	master:SetButtonGrowthX((side == "LEFT") and "RIGHT" or "LEFT")
	master:SetButtonGrowthY((edge == "TOP") and "DOWN" or "UP")
	master:SetJustify((side == "LEFT") and "LEFT" or "RIGHT")
	master:Arrange()

	local micro = self.MicroMenuWindow
	micro:ClearAllPoints()
	micro:SetPoint(Turn("BOTTOMRIGHT", side, edge), self.MicroMenuButton, Turn("BOTTOMLEFT", side, edge), -padding * h, 0)
	micro:SetButtonAnchor(Turn("BOTTOMRIGHT", side, edge))
	micro:SetButtonGrowthX((side == "LEFT") and "RIGHT" or "LEFT")
	micro:SetButtonGrowthY((edge == "TOP") and "DOWN" or "UP")
	micro:SetJustify((side == "LEFT") and "RIGHT" or "LEFT")
	micro:Arrange()

	local bars = self.ActionBarMenuWindow
	bars:ClearAllPoints()
	bars:SetPoint(Turn("BOTTOMRIGHT", side, edge), micro, Turn("BOTTOMRIGHT", side, edge), 15 * h, -17 * v)
end

-- Places the buttons, their texts and windows for that side. Secure
-- buttons: out of combat, when the menu is created or moved.
MenuWidget.ApplySide = function(self)
	local master, bags = self.MasterMenuButton, self.BagBarMenuButton
	if not (master and bags) then
		return
	end
	local config = Module.config
	local padding = config.structure.controllers.mainmenu.padding
	local micro = config.visuals.menus.main.micromenu
	local bagmenu = config.visuals.menus.main.bagmenu
	local side, edge = self:GetSide()
	self.side, self.edge = side, edge
	master:ClearAllPoints()
	bags:ClearAllPoints()
	self.BagBarMenuWindow:ClearAllPoints()
	master.Gold:ClearAllPoints()
	if (side == "LEFT") then
		master:SetPoint("BOTTOMLEFT")
		bags:SetPoint("BOTTOMLEFT", master, "BOTTOMRIGHT", padding, 0)
		self.BagBarMenuWindow:SetPoint(Mirror(bagmenu.position))
		master.Gold:SetPoint(Mirror(micro.performance.position))
	else
		master:SetPoint("BOTTOMRIGHT")
		bags:SetPoint("BOTTOMRIGHT", master, "BOTTOMLEFT", -padding, 0)
		self.BagBarMenuWindow:SetPoint(unpack(bagmenu.position))
		master.Gold:SetPoint(unpack(micro.performance.position))
	end
	self:ApplyWindowSides(side, edge)
	self:UpdatePerformanceAnchor()
end

-- The performance text (fps/latency) sits before the gold text when both
-- are shown (to its left on the right side, to its right on the left side),
-- but falls back to the gold text's own base position (taking its place)
-- whenever gold is disabled.
MenuWidget.UpdatePerformanceAnchor = function(self)
	local button = self.MasterMenuButton
	local position = Module.config.visuals.menus.main.micromenu.performance.position
	button.Performance:ClearAllPoints()
	if (self.side == "LEFT") then
		if Module.db.showGold then
			button.Performance:SetPoint("LEFT", button.Gold, "RIGHT", 8, 0)
		else
			button.Performance:SetPoint(Mirror(position))
		end
	elseif Module.db.showGold then
		button.Performance:SetPoint("RIGHT", button.Gold, "LEFT", -8, 0)
	else
		button.Performance:SetPoint(unpack(position))
	end
end

MenuWidget.UpdateGoldVisibility = function(self)
	local button = self.MasterMenuButton
	if button and button.Gold then
		if Module.db.showGold then button.Gold:Show() else button.Gold:Hide() end
	end
	self:UpdatePerformanceAnchor()
end

MenuWidget.UpdatePerformanceVisibility = function(self)
	local button = self.MasterMenuButton
	if button and button.Performance then
		if Module.db.showPerformance then button.Performance:Show() else button.Performance:Hide() end
	end
	self:UpdatePerformanceAnchor()
end

-- Same setting as the "Show FPS & Latency" option. Blizzard's framerate
-- text stays hidden, so its toggle always takes the "show" branch.
MenuWidget.TogglePerformance = function(self)
	for _, name in ipairs({ "FramerateLabel", "FramerateText", "MapFramerateLabel", "MapFramerateText" }) do
		_G[name]:Hide()
	end
	Module.db.showPerformance = not Module.db.showPerformance
	self:UpdatePerformanceVisibility()
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
