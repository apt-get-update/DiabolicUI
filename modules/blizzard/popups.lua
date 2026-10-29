-- Blizzard's StaticPopup dialogs, and the Dungeon Finder's, in DiabolicUI's
-- frames: a wide backdrop with room for bigger buttons, flat buttons that
-- light up on hover, and a plain input box.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: PopUps")

-- Lua API
local _G = _G
local pairs = pairs
local select = select
local unpack = unpack

-- Our backdrops on a Blizzard dialog box: a bigger one around it, with
-- room for our larger buttons, and the header's inside.
Module.StyleFrame = function(self, frame)
	local config = self.config.popup

	frame.backdrop = CreateFrame("Frame", nil, frame)
	frame.backdrop:SetFrameLevel(frame:GetFrameLevel())
	frame.backdrop:SetPoint("LEFT", -(config.body.insets[1] -3), 0)
	frame.backdrop:SetPoint("RIGHT", (config.body.insets[2] -3), 0)
	frame.backdrop:SetPoint("TOP", 0, (config.body.insets[3] -4))
	frame.backdrop:SetPoint("BOTTOM", 0, -(config.body.insets[4] -2))
	frame.backdrop:SetBackdrop(config.backdrop)
	frame.backdrop:SetBackdropColor(unpack(config.backdropColor))
	frame.backdrop:SetBackdropBorderColor(unpack(config.backdropBorderColor))

	frame:SetBackdrop(nil)
	frame:SetBackdrop(config.header.backdrop)
	frame:SetBackdropColor(unpack(config.header.backdropColor))
	frame:SetBackdropBorderColor(unpack(config.header.backdropBorderColor))
end

-- A flat button that lights up on hover, instead of Blizzard's red one.
Module.StyleButton = function(self, button)
	local config = self.config.popup.footer.button

	-- only making the artwork transparent: the button textures, or the
	-- three UIPanelButtonTemplate2 draws itself (and swaps on clicks)
	local name = button:GetName()
	for _, texture in pairs({ button:GetNormalTexture(), button:GetHighlightTexture(), button:GetPushedTexture(),
		button:GetDisabledTexture(), _G[name .. "Left"], _G[name .. "Middle"], _G[name .. "Right"] }) do
		texture:SetVertexColor(0, 0, 0, 0)
	end

	button:SetBackdrop(nil)
	button:SetBackdrop(config.backdrop)
	button:SetBackdropColor(unpack(config.backdropColor))
	button:SetBackdropBorderColor(unpack(config.backdropBorderColor))

	button:HookScript("OnEnter", function(self) 
		self:SetBackdropColor(unpack(config.backdropColor_hover))
		self:SetBackdropBorderColor(unpack(config.backdropBorderColor_hover))
	end)

	button:HookScript("OnLeave", function(self) 
		self:SetBackdropColor(unpack(config.backdropColor))
		self:SetBackdropBorderColor(unpack(config.backdropBorderColor))
	end)
end

Module.StylePopUp = function(self, popup)
	local config = self.config.popup

	self:StyleFrame(popup)
	for i = 1,4 do
		local button = popup["button"..i]
		if button then
			self:StyleButton(button)
		end
	end

	-- remove editbox artwork: Blizzard's chat input border, two nameless
	-- textures. Only those: the text selection and the cursor are textures
	-- of the editbox too.
	local editbox = _G[popup:GetName() .. "EditBox"]
	for i = 1, select("#", editbox:GetRegions()) do
		local region = select(i, editbox:GetRegions())
		local file = (region:GetObjectType() == "Texture") and region:GetTexture()
		if file and file:lower():find("ui%-chatinputborder") then
			region:SetTexture(nil)
		end
	end

	editbox:SetBackdrop(nil)
	editbox:SetBackdrop(config.body.input.backdrop)
	editbox:SetBackdropColor(unpack(config.body.input.backdropColor))
	editbox:SetBackdropBorderColor(unpack(config.body.input.backdropBorderColor))
	editbox:SetTextInsets(6,6,0,0)

	-- the money's coins ours (the guild bank's deposit and withdrawal)
	local money = _G[popup:GetName() .. "MoneyInputFrame"]
	if money then
		Engine:GetModule("Blizzard: Windows"):StyleCoins(money)
	end
end

-- The Dungeon Finder's dialogs: the role check, the "group has been formed"
-- dialog (its dungeon picture kept, its gold filigree gone) and the ready
-- check status that follows it.
Module.StyleDungeonFinder = function(self)
	self:StyleFrame(LFDRoleCheckPopup)
	self:StyleButton(LFDRoleCheckPopupAcceptButton)
	self:StyleButton(LFDRoleCheckPopupDeclineButton)

	self:StyleFrame(LFDDungeonReadyDialog)
	LFDDungeonReadyDialogFiligree:SetTexture(nil)
	LFDDungeonReadyDialogBottomArt:SetTexture(nil)
	self:StyleButton(LFDDungeonReadyDialogEnterDungeonButton)
	self:StyleButton(LFDDungeonReadyDialogLeaveQueueButton)

	self:StyleFrame(LFDDungeonReadyStatus)
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
	self:StyleDungeonFinder()
	self:UpdateLayout() -- initial layout update
	
	-- The popups are re-anchored by blizzard, so we need to re-adjust them when they do.
	hooksecurefunc("StaticPopup_SetUpPosition", function() self:UpdateLayout() end)
end

Module.OnEnable = function(self)
end
