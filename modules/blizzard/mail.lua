-- Gives Blizzard's mailbox Diablo III's windows (windows.lua): the inbox
-- and send tabs in one, the opened letter in another beside it, each the
-- stone window in its iron frame instead of the parchment, its title in
-- the plate over the red band, the tabs in a row under it, the mail and
-- the letters on Diablo III's parchment in darker panels, the buttons
-- ours (Postal's too, as they come). Blizzard places their parts against
-- the whole frame, so the windows grow around them instead of moving them.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Mail", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame

-- the frames' art, by its file (lowercase, as patterns)
local ART = {
	"ui%-itemtext%-", "ui%-spellbookpanel%-", "mail%-icon", "ui%-classtrainer%-", "ui%-openmail%-",
	"ui%-character%-scrollbar", "mailitemborder" -- the rows' parchment bars and empty icon sockets
}

-- the letters' paper (Blizzard sets its file as they show): ours instead
local STATIONERY = {
	"SendStationeryBackgroundLeft", "SendStationeryBackgroundRight",
	"OpenStationeryBackgroundLeft", "OpenStationeryBackgroundRight"
}

local NUM_ITEMS = 7 -- INBOXITEMS_TO_DISPLAY

-- `frame` in our window, its header returned.
Module.StyleFrame = function(self, frame, insets)
	local config = self.config
	local window = kit:CreateWindow(frame, insets)
	kit:SetBackground(window, "leather")
	kit:AddDrag(window, frame)
	kit:HideArt(frame, ART)
	return window, kit:CreateHeader(window, config.header_height, config.header_insets)
end

Module.StyleMail = function(self)
	local config = self.config
	local frame = _G.MailFrame

	local window, header = self:StyleFrame(frame, config.insets)
	kit:SetPanelLayout(frame, config.insets, config.insets[1], config.offset_y)
	kit:StyleClose(_G.InboxCloseButton, window, header)
	-- one title for both tabs, theirs out of sight
	local title = frame:CreateFontString(nil, "OVERLAY")
	kit:SetTitle(header, title)
	title:SetText(_G.INBOX)
	_G.InboxTitleText:SetAlpha(0)
	_G.SendMailTitleText:SetAlpha(0)
	_G.InboxFrame:HookScript("OnShow", function() title:SetText(_G.INBOX) end)
	_G.SendMailFrame:HookScript("OnShow", function() title:SetText(_G.SENDMAIL) end)

	-- the tabs in a row under the band (Blizzard sizes them)
	local tab = _G.MailFrameTab1
	tab:ClearAllPoints()
	tab:SetPoint("TOPLEFT", header, "BOTTOMLEFT", unpack(config.tab_offset))
	kit:AddTabStrip(header)
	for i = 1, 2 do
		kit:StyleTab(_G["MailFrameTab" .. i], { inset = config.tab_inset, font = config.tab_font })
	end

	-- the mail in a panel, the letter being written in another, its text dark
	local insets = config.list_panel_insets
	local panel = CreateFrame("Frame", nil, _G.InboxFrame)
	panel:SetFrameLevel(_G.InboxFrame:GetFrameLevel())
	panel:SetPoint("TOPLEFT", _G.MailItem1, "TOPLEFT", -insets[1], insets[2])
	panel:SetPoint("BOTTOMRIGHT", _G["MailItem" .. NUM_ITEMS], "BOTTOMRIGHT", insets[3], -insets[4])
	kit:StylePanel(panel)
	kit:AddPanel(_G.SendMailScrollFrame, config.text_panel_insets)
	kit:AddParchment(_G.SendMailScrollFrame, config.parchment_insets)
	_G.SendMailBodyEditBox:SetTextColor(unpack(config.text_color))

	-- the letter opened, right of it
	local open = _G.OpenMailFrame
	local openWindow, openHeader = self:StyleFrame(open, config.open_insets)
	kit:SetTitle(openHeader, _G.OpenMailTitleText)
	kit:StyleClose(_G.OpenMailCloseButton, openWindow, openHeader)
	open:ClearAllPoints()
	open:SetPoint("TOPLEFT", frame, "TOPRIGHT", config.insets[3] + config.open_insets[1] + config.open_gap, 0)
	kit:AddPanel(_G.OpenMailScrollFrame, config.text_panel_insets)
	kit:AddParchment(_G.OpenMailScrollFrame, config.parchment_insets)
	for _, name in ipairs(STATIONERY) do
		if _G[name] then
			_G[name]:SetAlpha(0)
		end
	end
	_G.OpenMailBodyText:SetTextColor(unpack(config.text_color))

	-- Blizzard's buttons, and those addons add as the mailbox opens
	kit:StyleButtons(frame)
	kit:StyleButtons(open)
	frame:HookScript("OnShow", function() kit:StyleButtons(frame) end)
	open:HookScript("OnShow", function() kit:StyleButtons(open) end)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").mail
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	self:StyleMail()
end
