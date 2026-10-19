-- Gives Blizzard's mailbox Diablo III's windows (windows.lua): the inbox
-- and send tabs in one, the opened letter in another beside it, each the
-- stone window in its iron frame instead of the parchment, its title in
-- the plate over the red band, the tabs in a row under it, the mail on
-- its crafting window's ruled paper (a row between two lines), the
-- letters on its parchment, in darker panels, the attachments in its stone
-- pane, the buttons
-- ours (Postal's too, as they come). Blizzard places their parts against
-- the whole frame, so the windows grow around them instead of moving them.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Mail", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

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
	kit:SetBackground(window, "slabs")
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
	-- the rough stone foot up to the tab's buttons
	local foot = kit:AddFooter(window, config.footers.inbox)
	_G.InboxFrame:HookScript("OnShow", function()
		title:SetText(_G.INBOX)
		kit:SetFooter(foot, config.footers.inbox)
	end)
	_G.SendMailFrame:HookScript("OnShow", function()
		title:SetText(_G.SENDMAIL)
		kit:SetFooter(foot, config.footers.send)
	end)

	-- the tabs in a row under the band (Blizzard sizes them)
	local tab = _G.MailFrameTab1
	tab:ClearAllPoints()
	tab:SetPoint("TOPLEFT", header, "BOTTOMLEFT", unpack(config.tab_offset))
	kit:AddTabStrip(header)
	for i = 1, 2 do
		kit:StyleTab(_G["MailFrameTab" .. i], { inset = config.tab_inset, font = config.tab_font })
	end

	-- the mail as entries on planks, the letter being written on lined
	-- parchment, its text dark
	local insets = config.list_panel_insets
	local panel = CreateFrame("Frame", nil, _G.InboxFrame)
	panel:SetFrameLevel(_G.InboxFrame:GetFrameLevel())
	panel:SetPoint("TOPLEFT", _G.MailItem1, "TOPLEFT", -insets[1], insets[2])
	panel:SetPoint("BOTTOMRIGHT", _G["MailItem" .. NUM_ITEMS], "BOTTOMRIGHT", insets[3], -insets[4])
	self:AddPaper(panel)
	kit:AddPanel(_G.SendMailScrollFrame, config.text_panel_insets)
	kit:AddParchment(_G.SendMailScrollFrame, config.parchment_insets, "lined")
	_G.SendMailBodyEditBox:SetTextColor(unpack(config.text_color))

	-- the letter opened, right of it
	local open = _G.OpenMailFrame
	local openWindow, openHeader = self:StyleFrame(open, config.open_insets)
	kit:SetTitle(openHeader, _G.OpenMailTitleText)
	kit:StyleClose(_G.OpenMailCloseButton, openWindow, openHeader)
	kit:AddFooter(openWindow, config.footers.open)
	open:ClearAllPoints()
	open:SetPoint("TOPLEFT", frame, "TOPRIGHT", config.insets[3] + config.open_insets[1] + config.open_gap, 0)
	kit:AddPanel(_G.OpenMailScrollFrame, config.text_panel_insets)
	kit:AddParchment(_G.OpenMailScrollFrame, config.parchment_insets, "parchment")
	for _, name in ipairs(STATIONERY) do
		if _G[name] then
			_G[name]:SetAlpha(0)
		end
	end
	_G.OpenMailBodyText:SetTextColor(unpack(config.text_color))
	for name, spec in pairs(config.attachment_panes) do
		self:AddAttachmentPane(_G[name], _G[spec[1]], unpack(spec, 2))
	end

	-- Blizzard's buttons, and those addons add as the mailbox opens
	kit:StyleButtons(frame)
	kit:StyleButtons(open)
	frame:HookScript("OnShow", function()
		kit:StyleButtons(frame)
		self:PlacePostal()
	end)
	open:HookScript("OnShow", function() kit:StyleButtons(open) end)
end

-- Postal's parts on the paper, each moved once (they come as it enables;
-- its Open All's arrow follows its button).
Module.PlacePostal = function(self)
	self.PostalPlaced = self.PostalPlaced or {}
	for name, offset in pairs(self.config.postal_offsets) do
		for _, suffix in ipairs({ "", 1, 2, 3, 4, 5, 6, 7 }) do -- the button, the rows' boxes
			local part = _G[name .. suffix]
			if part and (not self.PostalPlaced[part]) then
				self.PostalPlaced[part] = true
				local point, relative, relativePoint, x, y = part:GetPoint()
				part:SetPoint(point, relative, relativePoint, x + offset[1], y + offset[2])
			end
		end
	end
end

-- The mail on planks (`panel`'s), the page buttons under it.
Module.AddPaper = function(self, panel)
	local config = self.config
	local insets = config.list_paper_insets
	local planks = CreateFrame("Frame", nil, panel)
	planks:SetPoint("TOPLEFT", _G.MailItem1, "TOPLEFT", -insets[1], insets[2])
	planks:SetPoint("BOTTOMRIGHT", _G["MailItem" .. NUM_ITEMS], "BOTTOMRIGHT", insets[3], -insets[4])
	kit:CreateNine(planks, "BORDER", "planks")
	for _, name in ipairs({ "InboxPrevPageButton", "InboxNextPageButton", "InboxCurrentPage" }) do
		local region = _G[name]
		local point, relative, relativePoint, x, y = region:GetPoint()
		region:SetPoint(point, relative, relativePoint, x, y + config.page_offset)
	end
	-- Blizzard colors them on each update (the days left by a code)
	local ink = config.list_ink
	hooksecurefunc("InboxFrame_Update", function()
		for i = 1, NUM_ITEMS do
			local sender, subject = _G["MailItem" .. i .. "Sender"], _G["MailItem" .. i .. "Subject"]
			local read = (sender:GetTextColor() < .8) -- Blizzard's grey (.75) for read mail
			sender:SetTextColor(unpack(read and ink.read or ink.sender))
			subject:SetTextColor(unpack(read and ink.read or ink.subject))
			sender:SetShadowColor(0, 0, 0, 0)
			subject:SetShadowColor(0, 0, 0, 0)
			local expire = _G["MailItem" .. i .. "ExpireTime"]
			local text, days = expire:GetText(), expire:GetFontString()
			if text and days then
				local expiring = text:find(_G.RED_FONT_COLOR_CODE, 1, true)
				expire:SetText((text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")))
				days:SetTextColor(unpack(expiring and ink.expiring or ink.days))
				days:SetShadowColor(0, 0, 0, 0)
			end
		end
	end)
end

-- `frame`'s attachments in Diablo III's stone pane: from `under` under
-- `bar`'s top (Blizzard moves it as their rows change) to `over` over the
-- window's bottom, `left` and `right` in from its sides.
Module.AddAttachmentPane = function(self, frame, bar, under, over, left, right)
	if (not frame) or (not bar) then
		return
	end
	local pane = CreateFrame("Frame", nil, frame)
	pane:SetFrameLevel(frame:GetFrameLevel())
	pane:SetPoint("TOP", bar, "TOP", 0, -under)
	pane:SetPoint("LEFT", frame, "LEFT", left, 0)
	pane:SetPoint("RIGHT", frame, "RIGHT", -right, 0)
	pane:SetPoint("BOTTOM", frame, "BOTTOM", 0, over)
	kit:StylePane(pane)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").mail
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleMail()
end
