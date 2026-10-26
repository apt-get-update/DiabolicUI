-- Gives Blizzard's social window (friends, who, guild, chat channels,
-- raid) Diablo III's (windows.lua): the stone window in its iron frame
-- instead of each tab's art, the title in the plate over the red band, the
-- tabs in a row under it, the lists in darker panels, the buttons ours;
-- the friends' status and the who list's column choice in the band.
-- Blizzard places much of each tab against the whole frame, so the window
-- grows around it (up over the band and the tabs) instead of moving it.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Social", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local select = select
local string_format = string.format
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

-- A color as a text's code.
local ColorCode = function(color)
	return string_format("|cff%02x%02x%02x", color[1] * 255, color[2] * 255, color[3] * 255)
end

-- `text` kept in `color` (Blizzard colours some on each update).
local KeepColor = function(text, color)
	local busy
	local Paint = function()
		if (not busy) then
			busy = true
			text:SetTextColor(unpack(color))
			busy = nil
		end
	end
	hooksecurefunc(text, "SetTextColor", Paint)
	Paint()
end

-- the tabs' art, by its file (lowercase, as patterns): the frames, their
-- scroll bar tracks, the column headers' backgrounds
local ART = {
	"ui%-friendsframe", "friendsframescrollicon", "ui%-character%-scrollbar", "ui%-classtrainer%-",
	"whoframe%-", "guildframe%-", "ui%-channelframe", "ui%-character%-general", "ui%-raidframe%-"
}

-- the tabs' frames
local TABS = { "FriendsListFrame", "IgnoreListFrame", "PendingListFrame", "WhoFrame", "GuildFrame", "ChannelFrame", "RaidFrame" }

-- the lists, each in a darker panel (not the chat channels': their rows
-- are bars of their own)
local LISTS = {
	"FriendsFrameFriendsScrollFrame", "FriendsFrameIgnoreScrollFrame", "FriendsFramePendingScrollFrame",
	"WhoListScrollFrame", "GuildListScrollFrame"
}

Module.StyleSocial = function(self)
	local config = self.config
	local frame = _G.FriendsFrame

	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "cracked")
	-- the rough stone foot up to the page shown's buttons
	local foot = kit:AddFooter(window)
	for _, name in ipairs(TABS) do
		local page = _G[name]
		if page then
			page:HookScript("OnShow", function() kit:SetFooter(foot, config.footers[name]) end)
		end
	end
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	kit:SetPanelLayout(frame, config.insets, config.insets[1], config.offset_y)
	for _, name in ipairs(TABS) do
		if _G[name] then
			kit:HideArt(_G[name], ART)
		end
	end
	kit:HideArt(_G.FriendsTabHeader, ART)
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(self.Header, _G.FriendsFrameTitleText)
	kit:StyleClose(_G.FriendsFrameCloseButton, window, self.Header)

	-- the tabs as banners hanging from the window's foot
	local tabs = {}
	while _G["FriendsFrameTab" .. (#tabs + 1)] do
		tabs[#tabs + 1] = _G["FriendsFrameTab" .. (#tabs + 1)]
	end
	kit:HangTabs(window, tabs, config.tab_sigils)
	kit:DropTop(window)
	-- the friends' own tabs (friends, ignored, pending)
	for i = 1, 3 do
		local own = _G["FriendsTabHeaderTab" .. i]
		if own then
			kit:StyleTab(own, { inset = config.own_tab_inset, font = config.tab_font })
		end
	end

	self:LayoutFriends(window)
	self:LayoutWho(window)
	self:StyleGuild(window)
	self:StyleChannelPopup()
	self:StyleRaid()

	for _, name in ipairs(LISTS) do
		local list = _G[name]
		if list then
			local insets = config.list_panel_overrides[name] or config.list_panel_insets
			local zone = kit:AddZone(list, "leather", insets)
			local button = _G[config.list_bottoms[name] or ""]
			if button then
				self:SetZoneBottom(zone, list, insets, button, kit.config.footer_margin + (config.list_gaps[name] or config.list_gap))
			elseif (name == "GuildListScrollFrame") and self.MOTD then
				self:SetZoneBottom(zone, list, insets, self.MOTD, config.list_gap)
			end
			if config.header_bars[name] then
				self:AddHeaderBar(zone)
			end
		end
	end
	kit:StyleButtons(frame)
end

-- A list's panel down to `gap` over `under`'s top, its sides and top
-- still its list's.
Module.SetZoneBottom = function(self, zone, list, insets, under, gap)
	zone:ClearAllPoints()
	zone:SetPoint("TOPLEFT", list, "TOPLEFT", -insets[1], insets[2])
	zone:SetPoint("TOPRIGHT", list, "TOPRIGHT", insets[3], insets[2])
	zone:SetPoint("BOTTOM", under, "TOP", 0, gap)
end

-- A table's column names on a dark bar, over its panel's top.
Module.AddHeaderBar = function(self, zone)
	local section = kit.config.section
	local bar = CreateFrame("Frame", nil, zone)
	bar:SetFrameLevel(zone:GetFrameLevel())
	bar:SetPoint("BOTTOMLEFT", zone, "TOPLEFT", 0, 0)
	bar:SetPoint("BOTTOMRIGHT", zone, "TOPRIGHT", 0, 0)
	bar:SetHeight(section.height)
	kit:CreateSlices(bar, "ARTWORK", section, section.texture, section.height)
	bar.DiabolicContent = true -- (the list's top: its names on it)
end

-- A part moved `by` up from where Blizzard put it.
local Raise = function(part, by)
	local point, relative, relativePoint, x, y = part:GetPoint()
	part:ClearAllPoints()
	part:SetPoint(point, relative, relativePoint, x, y + by)
end

-- The friends' tab with more room: your status (its dropdown) at the
-- band's left end, the friends' own tabs after it, the list from under
-- the band down to its buttons (Blizzard made enough rows for
-- more height).
Module.LayoutFriends = function(self, window)
	local config = self.config
	-- their own tabs (friends, ignored) in the band after it, over it
	local status, own = _G.FriendsFrameStatusDropDown, _G.FriendsTabHeaderTab1
	if status then
		kit:StyleDropDown(status)
	end
	kit:LineBand(self.Header, status and { status, own } or { own })
	for i = 1, 3 do
		local tab = _G["FriendsTabHeaderTab" .. i]
		if tab then
			tab:SetFrameLevel(self.Header:GetFrameLevel() + 1)
		end
	end
	local list = _G.FriendsFrameFriendsScrollFrame
	local _, _, _, x = list:GetPoint()
	list:ClearAllPoints()
	list:SetPoint("TOPLEFT", _G.FriendsFrame, "TOPLEFT", x, config.friends_top)
	list:SetHeight(config.friends_bottom + config.friends_top)
	list.scrollHeight = list:GetHeight()
	-- its scroll bar up with it (Blizzard's top hangs off the frame's)
	local bar = _G.FriendsFrameFriendsScrollFrameScrollBar
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", list, "TOPRIGHT", 6, -15)
	bar:SetPoint("BOTTOMLEFT", list, "BOTTOMRIGHT", 6, 15)
	-- the ignored as high, under their tabs too, down to the same bottom
	local ignored = _G.FriendsFrameIgnoreScrollFrame
	local raise = config.friends_top - select(5, ignored:GetPoint())
	for _, part in ipairs({ ignored, _G.FriendsFrameIgnoreButton1 }) do
		local point, relative, relativePoint, px, py = part:GetPoint()
		part:ClearAllPoints()
		part:SetPoint(point, relative, relativePoint, px, py + raise)
	end
	ignored:SetHeight(config.friends_bottom + config.friends_top)
end

-- The who list with more room: the column's dropdown (zone, guild or
-- race) at the band's left end, the column named after it, the headers
-- and the rows from right under the tabs, more rows in the room gained.
Module.LayoutWho = function(self, window)
	local config = self.config
	local dropdown, column = _G.WhoFrameDropDown, _G.WhoFrameColumnHeader2
	kit:StyleDropDown(dropdown)
	-- its text in the middle of the plate's room left of the arrow
	local text, spec = _G.WhoFrameDropDownText, kit.config.dropdown
	text:ClearAllPoints()
	text:SetPoint("CENTER", dropdown, "CENTER", -(spec.arrow_size + spec.arrow_gap) / 2, 0)
	text:SetJustifyH("CENTER")
	-- one control with its arrow: a click on it opens the menu (Blizzard's
	-- sorted the list), its hover the arrow's, not Blizzard's blue one;
	-- the list sorted by the choice instead
	local button = _G.WhoFrameDropDownButton
	_G.WhoFrameDropDownHighlightTexture:SetAlpha(0)
	dropdown:SetScript("OnMouseUp", function() button:Click() end)
	dropdown:HookScript("OnEnter", function() button:LockHighlight() end)
	dropdown:HookScript("OnLeave", function() button:UnlockHighlight() end)
	hooksecurefunc("WhoFrameDropDownButton_OnClick", function()
		local choice = _G.WHOFRAME_DROPDOWN_LIST[_G.UIDropDownMenu_GetSelectedID(dropdown)]
		if choice and choice.sortType then
			_G.SortWho(choice.sortType)
		end
	end)
	-- narrow, for its short choices (Blizzard widens it at each update)
	local NameColumn = function()
		local choice = _G.WHOFRAME_DROPDOWN_LIST[_G.UIDropDownMenu_GetSelectedID(dropdown) or 1]
		column:SetText(choice and choice.name)
		_G.UIDropDownMenu_SetWidth(dropdown, config.who_dropdown_width)
	end
	NameColumn()
	hooksecurefunc("WhoList_Update", NameColumn)

	-- "1612 People Found" in the band right of the dropdown, in its labels'
	-- font
	local totals = _G.WhoFrameTotals
	totals:SetParent(self.Header)
	totals:SetDrawLayer("OVERLAY")
	totals:SetFontObject(kit.config.check_box.font)
	totals:SetTextColor(unpack(kit.config.title_plate.color))
	totals:SetJustifyH("LEFT")
	kit:LineBand(self.Header, { dropdown, totals })
	-- the search (/who's) on the foot over the buttons, on our plate
	-- (Blizzard draws its box in the frame's art, out of sight)
	kit:StyleEditBox(_G.WhoFrameEditBox)
	-- (the band's on every tab: there while the who list is)
	_G.WhoFrame:HookScript("OnShow", function() totals:Show() end)
	_G.WhoFrame:HookScript("OnHide", function() totals:Hide() end)
	if not _G.WhoFrame:IsShown() then
		totals:Hide()
	end
	local header = _G.WhoFrameColumnHeader1
	local _, _, _, x, y = header:GetPoint()
	header:ClearAllPoints()
	header:SetPoint("TOPLEFT", _G.WhoFrame, "TOPLEFT", x, config.who_top)
	local raise = config.who_top - y
	local first = _G.WhoFrameButton1
	_, _, _, x, y = first:GetPoint()
	first:ClearAllPoints()
	first:SetPoint("TOPLEFT", _G.WhoFrame, "TOPLEFT", x, y + raise)
	-- rows of Blizzard's template in the room gained, the list told of them
	local count, height = _G.WHOS_TO_DISPLAY, _G.FRIENDS_FRAME_WHO_HEIGHT
	local extra = math_floor(raise / height)
	for i = count + 1, count + extra do
		local row = CreateFrame("Button", "WhoFrameButton" .. i, _G.WhoFrame, "FriendsFrameWhoButtonTemplate")
		row:SetID(i)
		row:SetPoint("TOPLEFT", _G["WhoFrameButton" .. (i - 1)], "BOTTOMLEFT", 0, 0)
	end
	_G.WHOS_TO_DISPLAY = count + extra
	local list = _G.WhoListScrollFrame
	local point, relative, relativePoint
	point, relative, relativePoint, x, y = list:GetPoint()
	list:ClearAllPoints()
	list:SetPoint(point, relative, relativePoint, x, y + raise)
	list:SetHeight(list:GetHeight() + extra * height - config.who_list_trim)
end

-- The guild's: its message of the day on parchment between the list and
-- the foot (the totals up under the rows for it), a member's card
-- a dark panel right of the window (the equipment manager's icon
-- picker's), its notes in darker ones, its X and buttons ours.
Module.StyleGuild = function(self, window)
	local config = self.config
	local label, text = _G.GuildFrameNotesLabel, _G.GuildFrameNotesText
	if label and text then
		local insets = config.motd_panel_insets
		text:SetHeight(config.motd_text_height)
		Raise(_G.GuildFrameTotals, config.guild_totals_raise)
		_G.GuildListScrollFrame:SetHeight(config.guild_list_height)
		-- the message of the day on parchment, in ink
		local panel = CreateFrame("Frame", nil, _G.GuildFrame)
		self.MOTD = panel
		panel:SetFrameLevel(_G.GuildFrame:GetFrameLevel())
		panel:SetPoint("TOPLEFT", label, "TOPLEFT", -insets[1], insets[2])
		panel:SetPoint("BOTTOMRIGHT", text, "BOTTOMRIGHT", insets[3], -insets[4])
		kit:CreateNine(panel, "BACKGROUND", "parchment")
		panel.DiabolicContent = true
		panel.DiabolicMaterial = "parchment"
		label:SetTextColor(unpack(config.motd_title_color))
		label:SetShadowOffset(0, 0)
		text:SetShadowOffset(0, 0)
		-- (Blizzard colours it on each update: white, grey if you can't edit it)
		KeepColor(text, kit.config.ink)
	end
	-- the list and the message of the day higher (what's placed from the
	-- frame's top or sides, not its foot's buttons): as far from the band
	-- as from the foot. Blizzard places the list's toggle again on each
	-- update.
	local guild = _G.GuildFrame
	local toggle = _G.GuildFrameGuildListToggleButton
	local parts = { guild:GetChildren() }
	for _, holder in ipairs({ _G.GuildPlayerStatusFrame, _G.GuildStatusFrame }) do
		for _, part in ipairs({ holder:GetChildren() }) do
			parts[#parts + 1] = part
		end
	end
	for _, part in ipairs({ guild:GetRegions() }) do
		parts[#parts + 1] = part
	end
	for _, part in ipairs(parts) do
		if (part ~= toggle) and (part:GetNumPoints() == 1) then
			local _, relative, relativePoint = part:GetPoint()
			if (relative == guild) and (not relativePoint:find("^BOTTOM")) then
				Raise(part, config.guild_raise)
			end
		end
	end
	if toggle then
		local Place = function()
			local point, relative, relativePoint, x = toggle:GetPoint()
			toggle:SetPoint(point, relative, relativePoint, x, config.guild_toggle_y + config.guild_totals_raise + config.guild_raise)
		end
		hooksecurefunc("GuildStatus_Update", Place)
		Place()
	end
	-- Show Offline Members at the band's left end, its box ours, left of
	-- its label (Blizzard's frame round it out of sight)
	local offline = _G.GuildFrameLFGButton
	if offline then
		for _, part in ipairs({ "Left", "Middle", "Right" }) do
			local region = _G["GuildFrameLFGFrame" .. part]
			if region then
				region:SetAlpha(0)
			end
		end
		kit:StyleCheckBox(offline)
		kit:LineBand(self.Header, { offline })
		offline:SetFrameLevel(self.Header:GetFrameLevel() + 1)
	end
	local card = _G.GuildMemberDetailFrame
	kit:HideTextures(card)
	kit:StylePanel(card)
	card:SetBackdropColor(unpack(self:GetDB("Blizzard").character.popup_color))
	card:ClearAllPoints()
	card:SetPoint("TOPLEFT", window, "TOPRIGHT", unpack(config.guild_detail_offset))
	for _, name in ipairs({ "GuildMemberNoteBackground", "GuildMemberOfficerNoteBackground" }) do
		if _G[name] then
			kit:StylePanel(_G[name])
		end
	end
	kit:SkinClose(_G.GuildMemberDetailCloseButton)
	kit:StyleButtons(card)
	-- the guild's information and its log the same, their text on
	-- parchment in ink (the message of the day's), where the card is (not
	-- over the window's frame), their page lower: clear of their X
	local Place = function(popup, page, scroll)
		popup:ClearAllPoints()
		popup:SetPoint("TOPLEFT", window, "TOPRIGHT", unpack(config.guild_detail_offset))
		local lower = config.guild_page_lower
		local point, relative, relativePoint, x, y = page:GetPoint()
		page:SetPoint(point, relative, relativePoint, x, y - lower)
		page:SetHeight(page:GetHeight() - lower)
		scroll:SetHeight(scroll:GetHeight() - lower)
	end
	if _G.GuildInfoFrame then
		self:StylePopup(_G.GuildInfoFrame, _G.GuildInfoTitle, _G.GuildInfoCloseButton)
		Place(_G.GuildInfoFrame, _G.GuildInfoTextBackground, _G.GuildInfoFrameScrollFrame)
		self:AddPage(_G.GuildInfoTextBackground, _G.GuildInfoEditBox, config.raid_description_font)
		kit:StyleScrollBar(_G.GuildInfoFrameScrollFrameScrollBar)
	end
	if _G.GuildEventLogFrame then
		local inks = self:GetDB("Blizzard").panels.log_inks
		self:StylePopup(_G.GuildEventLogFrame, _G.GuildEventLogTitle, _G.GuildEventLogCloseButton)
		Place(_G.GuildEventLogFrame, _G.GuildEventFrame, _G.GuildEventLogScrollFrame)
		local text = _G.GuildEventMessage
		self:AddPage(_G.GuildEventFrame, text, inks.font)
		-- in from the page's left as the guild information's
		local scroll, width = _G.GuildEventLogScrollFrame, config.guild_log_width
		scroll:SetWidth(width)
		_G.GuildEventLogScrollChildFrame:SetWidth(width)
		text:SetWidth(width)
		kit:StyleScrollBar(_G.GuildEventLogScrollFrameScrollBar)
		-- the times in their darker ink, not Blizzard's teal
		local time = ColorCode(inks.time)
		hooksecurefunc("GuildEventLog_Update", function()
			text:SetText((text:GetText() or ""):gsub("|cff009999", time))
		end)
	end
end

-- A popup by the window (the guild's information, its log, a new
-- channel) as a member's card: a dark panel, its title pale, its X and
-- buttons ours.
Module.StylePopup = function(self, frame, title, close)
	kit:HideTextures(frame)
	kit:StylePanel(frame)
	frame:SetBackdropColor(unpack(self:GetDB("Blizzard").character.popup_color))
	if title then
		title:SetTextColor(unpack(kit.config.title_plate.color))
	end
	if close then
		kit:SkinClose(close)
	end
	kit:StyleButtons(frame)
end

-- `frame` (a popup's text's backdrop) a page of parchment, `text` on it
-- in ink (Blizzard's guild information greys or whitens it on each show),
-- in `font`.
Module.AddPage = function(self, frame, text, font)
	frame:SetBackdrop(nil)
	kit:CreateNine(frame, "BACKGROUND", "parchment")
	text:SetFontObject(font)
	KeepColor(text, kit.config.ink)
	text:SetShadowColor(0, 0, 0, 0)
end

-- The chat tab's new channel popup: its fields on Diablo III's plates,
-- their labels as the band's.
Module.StyleChannelPopup = function(self)
	local frame = _G.ChannelFrameDaughterFrame
	if (not frame) then
		return
	end
	self:StylePopup(frame, _G.ChannelFrameDaughterFrameName, _G.ChannelFrameDaughterFrameDetailCloseButton)
	for _, name in ipairs({ "ChannelFrameDaughterFrameChannelName", "ChannelFrameDaughterFrameChannelPassword" }) do
		local box = _G[name]
		kit:StyleEditBox(box)
		local label = _G[name .. "Label"]
		label:SetFontObject(kit.config.check_box.font)
		label:SetTextColor(unpack(kit.config.title_plate.color))
	end
	if _G.ChannelFrameDaughterFrameVoiceChat then
		kit:StyleCheckBox(_G.ChannelFrameDaughterFrameVoiceChat)
	end
end

-- The raid tab's: Convert to Raid and Raid Info in the band's middle,
-- what raids are on parchment, in ink (its first lines dark red, as the
-- message of the day's title). In a raid, Blizzard puts Raid Info back
-- by its ready check.
Module.StyleRaid = function(self)
	local config = self.config
	local convert, info = _G.RaidFrameConvertToRaidButton, _G.RaidFrameRaidInfoButton
	if convert and info then
		local level = self.Header:GetFrameLevel() + 1
		convert:ClearAllPoints()
		convert:SetPoint("RIGHT", self.Header, "CENTER", -config.raid_band_gap / 2, 0)
		info:ClearAllPoints()
		info:SetPoint("LEFT", self.Header, "CENTER", config.raid_band_gap / 2, 0)
		convert:SetFrameLevel(level)
		info:SetFrameLevel(level)
	end
	local text = _G.RaidFrameRaidDescription
	if text then
		local ink, insets = kit.config.ink, config.raid_description_insets
		local panel = CreateFrame("Frame", nil, _G.RaidFrameNotInRaid)
		panel:SetFrameLevel(_G.RaidFrameNotInRaid:GetFrameLevel())
		panel:SetPoint("TOPLEFT", text, "TOPLEFT", -insets[1], insets[2])
		panel:SetPoint("BOTTOMRIGHT", text, "BOTTOMRIGHT", insets[3], -insets[4])
		kit:CreateNine(panel, "BACKGROUND", "parchment")
		panel.DiabolicContent = true
		panel.DiabolicMaterial = "parchment"
		local code = string_format("|cff%02x%02x%02x", ink[1] * 255, ink[2] * 255, ink[3] * 255)
		text:SetFontObject(config.raid_description_font)
		text:SetText((_G.RAID_DESCRIPTION:gsub("|c%x%x%x%x%x%x%x%x", code)))
		text:SetTextColor(unpack(config.motd_title_color))
		text:SetShadowOffset(0, 0)
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").social
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleSocial()
end
