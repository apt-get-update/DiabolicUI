-- "Template: FloatButton" widget: the round standalone buttons around the
-- action bars (vehicle exit, taxi early landing, stance toggle).
-- :New(type, parent, name) makes one: "Action" for a secure action button
-- (a macro), "Click" for one toggling a window (see SetClickTarget).
local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local FloatButtonWidget = Module:SetWidget("Template: FloatButton")

-- Lua API
local ipairs = ipairs
local pairs = pairs

local LAYERS = { "Normal", "Highlight", "Pushed" }

-- Our button template
local FloatButton = {

	-- pressed, lit under the mouse, or normal (moving off a pressed button
	-- lets go of it: see OnLeave)
	UpdateLayers = function(self)
		local look = (self.isDown and "Pushed") or (self:IsMouseOver() and "Highlight") or "Normal"
		for _, layer in ipairs(LAYERS) do
			if (layer == look) then
				self[layer]:Show()
			else
				self[layer]:Hide()
			end
		end
	end,

	OnEnter = function(self)
		if self.PostEnter then
			self:PostEnter()
		end
		self:UpdateLayers()
	end,

	OnLeave = function(self)
		self.isDown = false
		if self.PostLeave then
			self:PostLeave()
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

-- The scripts every float button runs
local buttonScripts = {
	OnEnter = FloatButton.OnEnter,
	OnLeave = FloatButton.OnLeave,
	OnHide = FloatButton.OnHide,
	OnShow = FloatButton.OnShow,
	OnMouseDown = FloatButton.OnMouseDown,
	OnMouseUp = FloatButton.OnMouseUp
}

-- The methods each type gets
local buttonEmbeds = {
	Action = {
		UpdateLayers = FloatButton.UpdateLayers
	},
	Click = {
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
	local button = parent:CreateFrame("CheckButton", name, buttonTemplates[buttonType])
	button:SetFrameStrata("MEDIUM")
	button:RegisterForClicks("AnyUp")

	for method, func in pairs(buttonEmbeds[buttonType]) do
		button[method] = func
	end
	for handler, method in pairs(buttonScripts) do
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

	-- let blizz handle this one
	-- *note that this is the icon overlay, not the border!
	local buttonPushed = button:CreateTexture(nil, "OVERLAY")
	buttonPushed:SetAllPoints(button.Icon)
	buttonPushed:SetTexture(1, 1, 1, .25)

	button:SetPushedTexture(buttonPushed)
	button:GetPushedTexture():SetBlendMode("BLEND")

	return button
end

