-- Blizzard's StaticPopup dialogs in DiabolicUI's frames: a wide backdrop
-- with room for bigger buttons, flat buttons that light up on hover, and a
-- plain input box.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: PopUps")

-- Lua API
local _G = _G
local select = select
local unpack = unpack

Module.StylePopUp = function(self, popup)
	local config = self.config.popup

	-- add a bigger backdrop frame with room for our larger buttons
	if not popup.backdrop then
		popup.backdrop = CreateFrame("Frame", nil, popup)
		popup.backdrop:SetFrameLevel(popup:GetFrameLevel())
		popup.backdrop:SetPoint("LEFT", -(config.body.insets[1] -3), 0)
		popup.backdrop:SetPoint("RIGHT", (config.body.insets[2] -3), 0)
		popup.backdrop:SetPoint("TOP", 0, (config.body.insets[3] -4))
		popup.backdrop:SetPoint("BOTTOM", 0, -(config.body.insets[4] -2))
	end	
	popup.backdrop:SetBackdrop(config.backdrop)
	popup.backdrop:SetBackdropColor(unpack(config.backdropColor))
	popup.backdrop:SetBackdropBorderColor(unpack(config.backdropBorderColor))
	
	-- add another inner backdrop	
	popup:SetBackdrop(nil)
	popup:SetBackdrop(config.header.backdrop)
	popup:SetBackdropColor(unpack(config.header.backdropColor))
	popup:SetBackdropBorderColor(unpack(config.header.backdropBorderColor))

	-- remove button artwork
	for i = 1,4 do
		local button = popup["button"..i]
		if button then
			-- only making the artwork transparent
			button:GetNormalTexture():SetVertexColor(0, 0, 0, 0)
			button:GetHighlightTexture():SetVertexColor(0, 0, 0, 0)
			button:GetPushedTexture():SetVertexColor(0, 0, 0, 0)
			button:GetDisabledTexture():SetVertexColor(0, 0, 0, 0)

			button:SetBackdrop(nil)
			button:SetBackdrop(config.footer.button.backdrop)
			button:SetBackdropColor(unpack(config.footer.button.backdropColor))
			button:SetBackdropBorderColor(unpack(config.footer.button.backdropBorderColor))

			button:HookScript("OnEnter", function(self) 
				button:SetBackdropColor(unpack(config.footer.button.backdropColor_hover))
				button:SetBackdropBorderColor(unpack(config.footer.button.backdropBorderColor_hover))
			end)

			button:HookScript("OnLeave", function(self) 
				button:SetBackdropColor(unpack(config.footer.button.backdropColor))
				button:SetBackdropBorderColor(unpack(config.footer.button.backdropBorderColor))
			end)
		end
	end

	-- remove editbox artwork (Blizzard's chat input border, nameless)
	local editbox = _G[popup:GetName() .. "EditBox"]
	for i = 1, select("#", editbox:GetRegions()) do
		local region = select(i, editbox:GetRegions())
		if (region:GetObjectType() == "Texture") then
			region:SetTexture(nil)
		end
	end

	editbox:SetBackdrop(nil)
	editbox:SetBackdrop(config.body.input.backdrop)
	editbox:SetBackdropColor(unpack(config.body.input.backdropColor))
	editbox:SetBackdropBorderColor(unpack(config.body.input.backdropBorderColor))
	editbox:SetTextInsets(6,6,0,0)
end

-- Not strictly certain if moving them in combat would taint them, 
-- but knowing the blizzard UI, I'm not willing to take that chance.
Module.UpdateLayout = Module:Wrap(function(self)
	local config = self.config.popup
	local previous
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local popup = _G["StaticPopup"..i]
		local point, anchor, rpoint = popup:GetPoint()
		if anchor == previous then
			-- We only change the offsets values, not the anchor points, 
			-- since experience tells me that this is a safer way to avoid potential taint!
			popup:ClearAllPoints()
			popup:SetPoint(point, anchor, rpoint, 0, -(config.insets[4] + 20 + config.insets[3]))
		end
		previous = popup
	end
end)

Module.StylePopUps = function(self)
	for i = 1, STATICPOPUP_NUMDIALOGS do
		self:StylePopUp(_G["StaticPopup"..i])
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("UI")
	
	self:StylePopUps() -- initial styling (is more needed?)
	self:UpdateLayout() -- initial layout update
	
	-- The popups are re-anchored by blizzard, so we need to re-adjust them when they do.
	hooksecurefunc("StaticPopup_SetUpPosition", function() self:UpdateLayout() end)
end

Module.OnEnable = function(self)
end
