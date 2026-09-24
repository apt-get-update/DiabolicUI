-- "Template: FloatButton" widget: the round standalone buttons around the
-- action bars (vehicle exit, taxi early landing, stance toggle).
-- :New(type, parent, name) makes one; :Build(button, parent) restyles an
-- existing secure button.
local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local FloatButtonWidget = Module:SetWidget("Template: FloatButton")

-- Lua API
local _G = _G
local setmetatable = setmetatable

-- WoW API
local StartChargeCooldown = _G.StartChargeCooldown

-- Blizzard textures
local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local BLING_TEXTURE = [[Interface\Cooldown\star4]]
local EDGE_LOC_TEXTURE = [[Interface\Cooldown\edge-LoC]]
local EDGE_NORMAL_TEXTURE = [[Interface\Cooldown\edge]]

-- Our button template
local FloatButton = {

	UpdateLayers = function(self)
		if self.isDown then
			if self:IsMouseOver() then
				self.Pushed:Show()
				self.Highlight:Hide()
			else
				self.Highlight:Show()
				self.Pushed:Hide()
			end
			self.Normal:Hide()
		else
			if self:IsMouseOver() then
				self.Highlight:Show()
				self.Normal:Hide()
			else
				self.Normal:Show()
				self.Highlight:Hide()
			end
			self.Pushed:Hide()
		end
	end,

	OnEnter = function(self)
		self.isMouseOver = true
		if self.PostEnter then
			self:PostEnter(button)
		end
		self:UpdateLayers()
	end,

	OnLeave = function(self)
		self.isMouseOver = false
		self.isDown = false
		if self.PostLeave then
			self:PostLeave(button)
		end
		self:UpdateLayers()
	end,

	OnMouseDown = function(self)
		self.isDown = true 
		self:UpdateLayers()
	end,

	OnMouseUp = function(self)
		self.isDown = false
		self:UpdateLayers()
	end,

	OnShow = function(self)
		self.isDown = false
		self:UpdateLayers()
	end,

	OnHide = function(self)
		self.isDown = false
		self:UpdateLayers()
	end,

	OnClick = function(self, button)
		if self.PostClick then
			self:PostClick(button)
		end
		self:UpdateLayers() 
	end,

	SetClickTarget = function(self, target)
		self:SetFrameRef("window", target)
		self:SetAttribute("_onclick", [[
			if button == "LeftButton" then
				local window = self:GetFrameRef("window");
				local visibility = window:GetFrameRef("Visibility");
				if visibility then
					if visibility:IsShown() then
						visibility:Hide();
					else
						visibility:Show();
						visibility:RegisterAutoHide(.5);
						visibility:AddToAutoHide(self);
						visibility:AddToAutoHide(window);
					end
				else
					if window:IsShown() then
						window:Hide();
					else
						window:Show();
						window:RegisterAutoHide(.5);
						window:AddToAutoHide(self);
					end
				end
				local leftclick = self:GetAttribute("leftclick");
				if leftclick then
					control:RunAttribute("leftclick", button);
				end
			elseif button == "RightButton" then
				local rightclick = self:GetAttribute("rightclick");
				if rightclick then
					control:RunAttribute("rightclick", button);
				end
			end
			control:CallMethod("OnClick", button);
		]])
	end
}

local buttonScripts = {
	All = {
		OnClick = FloatButton.OnClick,
		OnEnter = FloatButton.OnEnter,
		OnLeave = FloatButton.OnLeave, 
		OnHide = FloatButton.OnHide,
		OnShow = FloatButton.OnShow, 
		OnMouseDown = FloatButton.OnMouseDown,
		OnMouseUp = FloatButton.OnMouseUp
	},
	Action = {
		OnEnter = FloatButton.OnEnter,
		OnLeave = FloatButton.OnLeave, 
		OnHide = FloatButton.OnHide,
		OnShow = FloatButton.OnShow, 
		OnMouseDown = FloatButton.OnMouseDown,
		OnMouseUp = FloatButton.OnMouseUp
	},
	Click = {
		OnEnter = FloatButton.OnEnter,
		OnLeave = FloatButton.OnLeave, 
		OnHide = FloatButton.OnHide,
		OnShow = FloatButton.OnShow, 
		OnMouseDown = FloatButton.OnMouseDown,
		OnMouseUp = FloatButton.OnMouseUp
	}
}

local buttonEmbeds = {
	All = {
		UpdateLayers = FloatButton.UpdateLayers
	},
	Action = {
		OnClick = FloatButton.OnClick,
		UpdateLayers = FloatButton.UpdateLayers
	},
	Click = {
		OnClick = FloatButton.OnClick,
		SetClickTarget = FloatButton.SetClickTarget,
		UpdateLayers = FloatButton.UpdateLayers
	},
	ActionClick = {
		OnClick = FloatButton.OnClick,
		SetClickTarget = FloatButton.SetClickTarget,
		UpdateLayers = FloatButton.UpdateLayers
	}
}

local buttonTemplates = {
	Action = "SecureActionButtonTemplate",
	Click = "SecureHandlerClickTemplate"
}


-- This is for our own buttons, that we make from scratch. 
-- Most of these should be macro driven for visibility. 
FloatButtonWidget.New = function(self, buttonType, parent, name)
	local button = parent:CreateFrame("CheckButton", name, buttonType and buttonTemplates[buttonType])
	button:SetFrameStrata("MEDIUM")
	button:RegisterForClicks("AnyUp")

	local embeds = buttonType and buttonEmbeds[buttonType] or buttonEmbeds.All
	if embeds then
		for method, func in pairs(embeds) do
			button[method] = func
		end
	end

	local scripts = buttonType and buttonScripts[buttonType] or buttonScripts.All
	for handler, method in pairs(scripts) do 
		button:SetScript(handler, method)
	end

	-- Create a frame to hold the border objects
	local buttonBorder = CreateFrame("Frame", nil, button)
	buttonBorder:SetAllPoints()
	buttonBorder:SetFrameLevel(button:GetFrameLevel() + 10) -- get it above the cooldown frame

	-- Border Layers
	button.Normal = buttonBorder:CreateTexture(nil, "BORDER")
	button.Highlight = buttonBorder:CreateTexture(nil, "BORDER")
	button.Pushed = buttonBorder:CreateTexture(nil, "BORDER")
	button.Disabled = buttonBorder:CreateTexture(nil, "BORDER")

	button.Highlight:Hide()
	button.Pushed:Hide()
	button.Disabled:Hide()

	-- Icon Texture
	button.Icon = button:CreateTexture(nil, "BACKGROUND")
	button.Icon:SetSize(button:GetSize())
	button.Icon:SetPoint("CENTER", 0, 0)
	button.Icon:SetTexCoord(5/64, 59/64, 5/64, 59/64) 

	-- Keybind Text
	button.Bind = button:CreateFontString(nil, "OVERLAY")
	button.Bind:SetFontObject(GameFontNormal)
	button.Bind:SetPoint("TOPRIGHT")

	-- let blizz handle this one
	-- *note that this is the icon overlay, not the border!
	local buttonPushed = button:CreateTexture(nil, "OVERLAY")
	buttonPushed:SetAllPoints(button.Icon)
	buttonPushed:SetTexture(1, 1, 1, .25)

	button:SetPushedTexture(buttonPushed)
	button:GetPushedTexture():SetBlendMode("BLEND")

	return button
end

-- This is meant for secure buttons that already exist (like ExtraActionButton1),
-- which can't have their original scripts or methods replaced.
FloatButtonWidget.Build = function(self, button, parent)

	button:SetFrameStrata("MEDIUM")
	button:RegisterForClicks("AnyUp")

	-- Embed needed methods
	for method, func in pairs(buttonEmbeds.All) do
		button[method] = func
	end
		-- Hook our own scripts rather than overwrite, 
	-- since the original Blizzard scripts are the magic here. 
	for handler, method in pairs(buttonScripts.All) do 
		button:HookScript(handler, method)
	end

	-- Reference original Blizzard objects
	button.Icon = button.icon or button.Icon
	button.Bind = button.HotKey
	button.Count = button.Count
	button.Flash = button.Flash
	button.Cooldown = button.cooldown or button.Cooldown
	button.Style = button.style or button.Style

	-- Create a frame to hold the border objects
	local buttonBorder = CreateFrame("Frame", nil, button)
	buttonBorder:SetAllPoints()
	buttonBorder:SetFrameLevel(button:GetFrameLevel() + 10) -- get it above the cooldown frame

	-- Border Layers
	button.Normal = buttonBorder:CreateTexture(nil, "BORDER")
	button.Highlight = buttonBorder:CreateTexture(nil, "BORDER")
	button.Pushed = buttonBorder:CreateTexture(nil, "BORDER")
	button.Disabled = buttonBorder:CreateTexture(nil, "BORDER")

	button.Highlight:Hide()
	button.Pushed:Hide()
	button.Disabled:Hide()

	-- Hide the keybind, we don't want it here
	if button.Bind then
		button.Bind:Hide()
		button.Bind.Show = button.Bind.Hide -- It tends to pop back up, so we're trying this hack for now.
	end

	-- We're doing these ourselves with our own system, 
	-- so we simply blank out the ones existing
	-- in the blizzard templates. 
	--if button.SetCheckedTexture then button:SetCheckedTexture("") end
	if button.SetHighlightTexture then button:SetHighlightTexture("") end
	if button.SetNormalTexture then button:SetNormalTexture("") end

	-- Add a simpler checked texture
	if button.SetCheckedTexture then
		local checked = button:CreateTexture(nil, "BORDER")
		checked:SetAllPoints(button.Icon)
		checked:SetTexture(.9, .8, .1, .3)

		button:SetCheckedTexture(checked)
	end
	
	-- kill the style textures (ExtraActionButton1)
	if button.Style then
		button.Style:Hide()
		button.Style.Show = button.Style.Hide -- Is there any need for this?
	end

	-- cooldown frame
	-- stance and pet buttons have this in their template, I think
	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"] or button.Cooldown
	if cooldown then
		button.Cooldown = cooldown
		button.Cooldown:ClearAllPoints()
		button.Cooldown:SetAllPoints(button.Icon)
		button.Cooldown:SetFrameLevel(button:GetFrameLevel() + 2)
	else
		button.Cooldown = button:CreateFrame("Cooldown", nil, "CooldownFrameTemplate")
		button.Cooldown:SetAllPoints(button.Icon)
		button.Cooldown:SetFrameLevel(button:GetFrameLevel() + 2)
	end

	if button.Cooldown then
		-- If we have the bling and nonsense added in WoD, we need to handle it
		if (button.Cooldown.SetSwipeColor) then
			local resetCooldown = function()
				button.Cooldown:SetSwipeColor(0, 0, 0, .75)
				button.Cooldown:SetBlingTexture(BLING_TEXTURE, .3, .6, 1, .75) -- what wow uses, only with slightly lower alpha
				button.Cooldown:SetEdgeTexture("")
				button.Cooldown:SetDrawSwipe(true)
				button.Cooldown:SetDrawBling(true)
				button.Cooldown:SetDrawEdge(false)
				button.Cooldown:SetHideCountdownNumbers(true) 
			end
			hooksecurefunc(button.Cooldown, "SetCooldown", resetCooldown)
			
			if StartChargeCooldown then
				hooksecurefunc("StartChargeCooldown", function(parent, chargeStart, chargeDuration, enable) 
					if parent == button then
						if parent.chargeCooldown and not button.chargeCooldown then
							button.chargeCooldown = parent.chargeCooldown
							button.chargeCooldown:SetSize(unpack(config.icon.size))
							button.chargeCooldown:ClearAllPoints()
							button.chargeCooldown:SetPoint(unpack(config.icon.position))
							button.chargeCooldown:SetFrameLevel(button:GetFrameLevel() + 2)

							local resetCooldown = function()
								button.chargeCooldown:SetSwipeColor(0, 0, 0, 0)
								button.chargeCooldown:SetBlingTexture("", 0, 0, 0, 0) 
								button.chargeCooldown:SetEdgeTexture("")
								button.chargeCooldown:SetDrawSwipe(false)
								button.chargeCooldown:SetDrawBling(false)
								button.chargeCooldown:SetDrawEdge(false)
								button.chargeCooldown:SetHideCountdownNumbers(true)
								
								-- just use the normal cooldownframe
								button.Cooldown:SetCooldown(chargeStart, chargeDuration)
							end
							hooksecurefunc(button.chargeCooldown, "SetCooldown", resetCooldown)
						end
					end
				end)
			end
			resetCooldown()
		end
	end
	
	-- let blizz handle this one
	-- *note that this is the icon overlay, not the border!
	local buttonPushed = button:CreateTexture(nil, "OVERLAY")
	buttonPushed:SetAllPoints(button.Icon)
	buttonPushed:SetTexture(1, 1, 1, .25)

	button:SetPushedTexture(buttonPushed)
	button:GetPushedTexture():SetBlendMode("BLEND")

	return button
end

