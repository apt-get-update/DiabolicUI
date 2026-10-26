-- Gives Blizzard's mailbox Diablo III's windows (windows.lua): the inbox
-- and send tabs in one, the opened letter in another beside it, each the
-- stone window in its iron frame instead of the parchment, its title in
-- a plate on its top edge, the tabs hanging under it, the mail on
-- parchment up to the band (Postal's Open and Return in it), the letter's
-- To, Subject and postage in the band, the letters on its parchment, in
-- darker panels, the attachments in its stone pane, the buttons
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
local select = select
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

-- `frame`'s font string showing `text` (Blizzard's labels have no name).
local FindText = function(frame, text)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("FontString") and (region:GetText() == text) then
			return region
		end
	end
end

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
	self.Header = header
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

	-- the tabs as banners hanging from the window's foot
	kit:HangTabs(window, { _G.MailFrameTab1, _G.MailFrameTab2 }, config.tab_sigils)
	kit:DropTop(window)

	-- the mail on parchment, the letter being written on lined parchment,
	-- its text dark; the name, the subject and the money a little higher,
	-- the coins ours
	self:StyleRows()
	for name, offset in pairs(config.send_offsets) do
		local part = _G[name]
		local point, relative, relativePoint, x, y = part:GetPoint()
		part:SetPoint(point, relative, relativePoint, x + offset[1], y + offset[2])
	end
	self:PlaceSendBand(header)
	kit:StyleCoins(_G.SendMailMoney)
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
		self:PlaceRows()
	end)
	open:HookScript("OnShow", function() kit:StyleButtons(open) end)
end

-- The letter's To and Subject (their labels pale in them while empty) and
-- its postage's sum (its label out of sight) in `header`'s band, over it; its
-- text up under the band, taller (Blizzard sets its height as the
-- attachments' rows change).
Module.PlaceSendBand = function(self, header)
	local spec = self.config.send_band
	local level = header:GetFrameLevel() + 1
	-- (x: where each part's plate starts, the plates past the boxes' sides)
	local pad = kit.config.edit_padding
	local x = spec.x
	local name, subject = _G.SendMailNameEditBox, _G.SendMailSubjectEditBox
	for _, part in ipairs({ { name, _G.MAIL_TO_LABEL, spec.name_width, spec.arrow_gap + spec.arrow_width + spec.gap },
		{ subject, _G.MAIL_SUBJECT_LABEL, 0, spec.gap } }) do
		local box, width = part[1], part[3]
		local label = FindText(box, part[2])
		if label then
			label:SetAlpha(0)
		end
		-- its label (without its colon) pale in it while it's empty and
		-- not typed in
		local hint = box:CreateFontString(nil, "OVERLAY")
		hint:SetFontObject(spec.hint_font)
		hint:SetTextColor(unpack(spec.hint_color))
		hint:SetPoint("LEFT", box, "LEFT", spec.hint_inset, 0)
		hint:SetText((part[2]:gsub("%s*:%s*$", "")))
		local Hint = function()
			if (box:GetText() == "") and (not box.DiabolicFocused) then
				hint:Show()
			else
				hint:Hide()
			end
		end
		box:HookScript("OnEditFocusGained", function() box.DiabolicFocused = true Hint() end)
		box:HookScript("OnEditFocusLost", function() box.DiabolicFocused = nil Hint() end)
		box:HookScript("OnTextChanged", Hint)
		Hint()
		kit:StyleEditBox(box)
		box:ClearAllPoints()
		box:SetPoint("LEFT", header, "LEFT", x + pad, 0)
		box:SetWidth(width)
		box:SetFrameLevel(level)
		x = x + pad + width + pad + part[4]
	end
	local cost = _G.SendMailCostMoneyFrame
	local label = FindText(cost, _G.SEND_MAIL_COST)
	if label then
		label:SetAlpha(0)
	end
	cost:ClearAllPoints()
	cost:SetPoint("RIGHT", header, "RIGHT", -spec.postage_right, 0)
	cost:SetFrameLevel(level)
	-- the subject stretched up to the postage (its width set as it changes)
	local subjectLeft = x - spec.gap - pad
	local Stretch = function()
		local right = header:GetWidth() - spec.postage_right - cost:GetWidth() - spec.gap - pad
		if (right > subjectLeft) then
			subject:SetWidth(right - subjectLeft)
		end
	end
	hooksecurefunc(cost, "SetWidth", Stretch)
	_G.SendMailFrame:HookScript("OnShow", function()
		self:PlaceAddressBook()
		Stretch()
	end)
	self:PlaceAddressBook()

	local rise = self.config.text_rise
	local scroll, child = _G.SendMailScrollFrame, _G.SendMailScrollChildFrame
	local point, relative, relativePoint, left, top = scroll:GetPoint()
	scroll:SetPoint(point, relative, relativePoint, left, top + rise)
	local Grow = function()
		scroll:SetHeight(scroll:GetHeight() + rise)
		child:SetHeight(child:GetHeight() + rise)
	end
	hooksecurefunc("SendMailFrame_Update", Grow)
	Grow()
end

-- Postal's address book's arrow right of the To box, past its plate (it
-- comes as Postal enables).
Module.PlaceAddressBook = function(self)
	local arrow = _G.Postal_BlackBookButton
	if arrow then
		local spec = self.config.send_band
		arrow:ClearAllPoints()
		arrow:SetPoint("LEFT", _G.SendMailNameEditBox, "RIGHT", kit.config.edit_padding + spec.arrow_gap, 0)
		arrow:SetFrameLevel(self.Header:GetFrameLevel() + 1)
	end
end

-- The mail's rows up under the band, apart down to their old foot (Postal
-- places the first again as its boxes come and go: each time the mailbox
-- opens).
Module.PlaceRows = function(self)
	local config = self.config
	local first = _G.MailItem1
	local point, relative, relativePoint, x = first:GetPoint()
	first:SetPoint(point, relative, relativePoint, x, config.rows_top)
	if not self.RowsApart then
		self.RowsApart = true
		for i = 2, NUM_ITEMS do
			local row = _G["MailItem" .. i]
			local rowPoint, previous, previousPoint, rowX, rowY = row:GetPoint()
			row:SetPoint(rowPoint, previous, previousPoint, rowX, rowY - config.rows_gap)
		end
	end
end

-- Postal's parts on the paper, each moved once (they come as it enables;
-- its Open All's arrow follows its button); its Open and Return in the
-- band, side by side in its middle, over it.
Module.PlacePostal = function(self)
	local spec = self.config.select_buttons
	local open, back = _G.PostalSelectOpenButton, _G.PostalSelectReturnButton
	if open and back and (not self.SelectPlaced) then
		self.SelectPlaced = true
		local header = self.Header
		open:ClearAllPoints()
		open:SetPoint("RIGHT", header, "CENTER", -spec.gap / 2, 0)
		back:ClearAllPoints()
		back:SetPoint("LEFT", header, "CENTER", spec.gap / 2, 0)
		for _, button in ipairs({ open, back }) do
			button:SetWidth(spec.width)
			button:SetFrameLevel(header:GetFrameLevel() + 1)
		end
	end
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

-- The mail on Diablo III's parchment, in dark ink, each icon in the
-- action buttons' border; the page buttons ours, under the rows.
Module.StyleRows = function(self)
	local config = self.config
	local left, top, width, height = unpack(config.list_box)
	local paper = CreateFrame("Frame", nil, _G.InboxFrame)
	paper:SetFrameLevel(_G.InboxFrame:GetFrameLevel())
	paper:SetPoint("TOPLEFT", _G.InboxFrame, "TOPLEFT", left, top)
	paper:SetSize(width, height)
	kit:CreateNine(paper, "BACKGROUND", "parchment")
	for i = 1, NUM_ITEMS do
		local button = _G["MailItem" .. i .. "Button"]
		_G["MailItem" .. i .. "ButtonSlot"]:SetAlpha(0)
		kit:AddBorder(button, button:GetWidth())
	end
	local prev, nextPage = _G.InboxPrevPageButton, _G.InboxNextPageButton
	kit:StylePager(prev, nextPage)
	for _, region in ipairs({ prev, nextPage, _G.InboxCurrentPage }) do
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
