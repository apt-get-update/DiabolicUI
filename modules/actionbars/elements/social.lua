-- "Menu: Chat" widget: the chat and social buttons next to the chat window
-- (open the edit box, friends and guild windows).
local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local MenuWidget = Module:SetWidget("Menu: Chat")
local L = Engine:GetLocale()

-- Lua API
local _G = _G

-- WoW API
local GetNumFriends = _G.GetNumFriends
local GetNumGuildMembers = _G.GetNumGuildMembers
local GuildRoster = _G.GuildRoster
local PlaySound = _G.PlaySound

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

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

	button:SetHitRectInsets(0, 0, 0, 0)
	button:OnButtonState(button:GetButtonState())
end

-- The friends and other guild members online, shown on the social button.
-- (3.3.5's GetNumGuildMembers only gives one count: the roster, offline
-- members included, says who's online.)
local CountPeople = function(button)
	local numGuildies = 0
	if IsInGuild() then
		for i = 1, GetNumGuildMembers(true) do
			if select(9, GetGuildRosterInfo(i)) then
				numGuildies = numGuildies + 1
			end
		end
	end
	local _, onlineFriends = GetNumFriends()

	button.numGuildies = numGuildies
	button.numOtherGuildies = (numGuildies > 1) and (numGuildies - 1) or 0
	button.numFriends = onlineFriends or 0
	button.numPeople = button.numFriends + button.numOtherGuildies
	button.People:SetText(((numGuildies > 1) or (button.numFriends > 0)) and button.numPeople or "")
end

MenuWidget.OnEnable = function(self)
	local config = Module.config

	local Menu = Module:GetWidget("Controller: Chat"):GetFrame()
	local MenuButton = Module:GetWidget("Template: MenuButton")

	-- WoW Frames and Objects
	local InputBox = ChatFrame1EditBox
	local FriendsWindow = FriendsFrame

	-- config table shortcuts
	local chat_menu_config = config.structure.controllers.chatmenu
	local input_config = config.visuals.menus.chat.input
	local menu_config = config.visuals.menus.chat.menu

	-- Main Buttons
	---------------------------------------------
	local ChatButton = MenuButton:New(Menu)
	ChatButton:SetPoint("BOTTOMLEFT")
	ChatButton:SetSize(unpack(input_config.button.size))

	self:Skin(ChatButton, input_config, "chat")


	InputBox:HookScript("OnShow", function() 
		ChatButton:SetButtonState("PUSHED", 1)
		PlaySound("igCharacterInfoOpen")
	end)
	InputBox:HookScript("OnHide", function() 
		ChatButton:SetButtonState("NORMAL") 
		PlaySound("igCharacterInfoClose")
	end)


	local SocialButton = MenuButton:New(Menu)
	SocialButton:SetPoint("BOTTOMLEFT", ChatButton, "BOTTOMRIGHT", chat_menu_config.padding, 0 )
	SocialButton:SetSize(unpack(input_config.button.size))
	self:Skin(SocialButton, input_config, "group")

	
	FriendsWindow:HookScript("OnShow", function() SocialButton:SetButtonState("PUSHED", 1) end)
	FriendsWindow:HookScript("OnHide", function() SocialButton:SetButtonState("NORMAL") end)

	ChatButton.OnEnter = function(self) 
		if ChatButton:GetButtonState() == "PUSHED"
		or SocialButton:GetButtonState() == "PUSHED" then
			GameTooltip:Hide()
			return
		end
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 6, 16)
		GameTooltip:AddLine(L["Chat"])
		GameTooltip:AddLine(L["<Left-click> or <Enter> to chat."], 0, .7, 0)
		GameTooltip:Show()
	end
	ChatButton:SetScript("OnEnter", ChatButton.OnEnter)
	ChatButton:SetScript("OnLeave", function(self) 
		GameTooltip:Hide() 
	end)
	
	ChatButton.OnClick = function(self, button)
		if InputBox:IsShown() then
			InputBox:Hide()
		else
			InputBox:Show() 
			InputBox:SetFocus()
		end
		if button == "LeftButton" then
			self:OnEnter() -- update tooltips
		end
	end
	ChatButton:SetAttribute("_onclick", [[ control:CallMethod("OnClick", button); ]])
	
	
	-- (the online guild members are counted from the roster, see OnEvent:
	-- 3.3.5's GetNumGuildMembers only gives one count)
	SocialButton.OnEnter = function(self) 
		local _, onlineFriends = GetNumFriends() 
		local numGuildies = self.numGuildies or 0
		local numFriends = onlineFriends or 0

		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 6, 16)
		GameTooltip:AddLine(IsInGuild() and L["Friends & Guild"] or FRIENDS)

		if (numGuildies > 1) or (numFriends > 0) then
			GameTooltip:AddLine(" ")
			if (numGuildies > 1) then
				GameTooltip:AddDoubleLine(L["Guild Members Online:"], numGuildies - 1, 1,1,1,1,.82,0)
			end
			if (numFriends > 0) then
				GameTooltip:AddDoubleLine(L["Friends Online:"], numFriends, 1,1,1,1,.82,0)
			end
			GameTooltip:AddLine(" ")
		end

		GameTooltip:AddLine(L["<Left-click> to toggle social frames."], 0, .7, 0)
		GameTooltip:AddLine(L["<Right-click> to toggle Guild frame."], 0, .7, 0)
		GameTooltip:Show()
	end
	SocialButton:SetScript("OnEnter", SocialButton.OnEnter)
	SocialButton:SetScript("OnLeave", function(self) 
		GameTooltip:Hide() 
	end)
	
	SocialButton.OnClick = function(self, button)
		if (button == "LeftButton") then
			ToggleFriendsFrame()
		elseif (button == "RightButton") then
			ToggleFriendsFrame(3) -- the guild tab
		end
	end
	SocialButton:SetAttribute("_onclick", [[ control:CallMethod("OnClick", button); ]])


	-- Texts
	---------------------------------------------

	local People = SocialButton:CreateFontString()
	People:SetDrawLayer("ARTWORK")
	People:SetFontObject(menu_config.people.normalFont)
	People:SetPoint(unpack(menu_config.people.position))

	SocialButton:SetScript("OnEvent", function(self, event, ...) 
		local arg1 = ...

		if ((event == "PLAYER_ENTERING_WORLD") or (event == "PLAYER_GUILD_UPDATE")) then
			if IsInGuild() then 
				GuildRoster()
			end
			ShowFriends()

		elseif (event == "GUILD_ROSTER_UPDATE") then
			if (arg1 and IsInGuild()) then
				GuildRoster()
			end
		end
		CountPeople(self)
	end)

	SocialButton.elapsed = 0
	SocialButton:SetScript("OnUpdate", function(self, elapsed) 

		-- Throttle the checks to once every 5 secs
		self.elapsed = self.elapsed + elapsed
		if (self.elapsed < 15) then
			return
		end

		-- Force an event update
		if IsInGuild() then
			GuildRoster()
		end

		-- Reset throttle counter
		self.elapsed = 0
	end)


	SocialButton.People = People
	CountPeople(SocialButton)

	self.ChatButton = ChatButton
	self.SocialButton = SocialButton
	
	SocialButton:RegisterEvent("FRIENDLIST_UPDATE")
	SocialButton:RegisterEvent("GUILD_ROSTER_UPDATE")
	SocialButton:RegisterEvent("GUILDTABARD_UPDATE")
	SocialButton:RegisterEvent("PLAYER_ENTERING_WORLD")
	SocialButton:RegisterEvent("PLAYER_GUILD_UPDATE")

end
