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
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

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
	kit:SetBackground(window, "smoke")
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

	-- the tabs in a row under the band (Blizzard sizes them)
	local tab = _G.FriendsFrameTab1
	tab:ClearAllPoints()
	tab:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", unpack(config.tab_offset))
	kit:AddTabStrip(self.Header)
	local i = 1
	while _G["FriendsFrameTab" .. i] do
		kit:StyleTab(_G["FriendsFrameTab" .. i], { inset = config.tab_inset, font = config.tab_font })
		i = i + 1
	end
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

	for _, name in ipairs(LISTS) do
		if _G[name] then
			kit:AddPanel(_G[name], config.list_panel_overrides[name] or config.list_panel_insets)
		end
	end
	kit:StyleButtons(frame)
end

-- The friends' tab with more room: your status (its dropdown) at the
-- band's left end, the friends' own tabs right under the window's, the
-- list from under them down to its buttons (Blizzard made enough rows for
-- more height).
-- A dropdown at the band's left end, over the window's frame.
Module.PlaceInBand = function(self, window, dropdown)
	kit:PlaceInBand(window, self.Header, dropdown, "LEFT", self.config.status_offset)
end

Module.LayoutFriends = function(self, window)
	local config = self.config
	local status = _G.FriendsFrameStatusDropDown
	if status then
		self:PlaceInBand(window, status)
	end
	local own = _G.FriendsTabHeaderTab1
	own:ClearAllPoints()
	own:SetPoint("TOPLEFT", _G.FriendsFrameTab1, "BOTTOMLEFT", 0, -config.own_tab_gap)
	local list = _G.FriendsFrameFriendsScrollFrame
	local _, _, _, x, y = list:GetPoint()
	list:ClearAllPoints()
	list:SetPoint("TOPLEFT", _G.FriendsFrame, "TOPLEFT", x, config.friends_top)
	list:SetHeight(config.friends_bottom + config.friends_top)
	list.scrollHeight = list:GetHeight()
	-- the ignored as high, under their tabs too, down to the same bottom
	local raise = config.friends_top - y
	for _, part in ipairs({ _G.FriendsFrameIgnoreScrollFrame, _G.FriendsFrameIgnoreButton1 }) do
		local point, relative, relativePoint, px, py = part:GetPoint()
		part:ClearAllPoints()
		part:SetPoint(point, relative, relativePoint, px, py + raise)
	end
	local ignored = _G.FriendsFrameIgnoreScrollFrame
	ignored:SetHeight(ignored:GetHeight() + raise)
end

-- The who list with more room: the column's dropdown (zone, guild or
-- race) at the band's left end, the column named after it, the headers
-- and the rows from right under the tabs, more rows in the room gained.
Module.LayoutWho = function(self, window)
	local config = self.config
	local dropdown, column = _G.WhoFrameDropDown, _G.WhoFrameColumnHeader2
	kit:StyleDropDown(dropdown)
	self:PlaceInBand(window, dropdown)
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

	-- "1612 People Found" lower, closer to the buttons under it
	local totals = _G.WhoFrameTotals
	local point, relative, relativePoint, tx, ty = totals:GetPoint()
	totals:SetPoint(point, relative, relativePoint, tx, ty - config.who_totals_drop)

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
	list:SetHeight(list:GetHeight() + extra * height)
end

-- The guild's: its message of the day in a darker panel, a member's card
-- a dark panel right of the window (the equipment manager's icon
-- picker's), its notes in darker ones, its X and buttons ours.
Module.StyleGuild = function(self, window)
	local config = self.config
	local label, text = _G.GuildFrameNotesLabel, _G.GuildFrameNotesText
	if label and text then
		local insets = config.motd_panel_insets
		local panel = CreateFrame("Frame", nil, _G.GuildFrame)
		panel:SetFrameLevel(_G.GuildFrame:GetFrameLevel())
		panel:SetPoint("TOPLEFT", label, "TOPLEFT", -insets[1], insets[2])
		panel:SetPoint("BOTTOMRIGHT", text, "BOTTOMRIGHT", insets[3], -insets[4])
		kit:StylePanel(panel)
	end
	local card = _G.GuildMemberDetailFrame
	if not card then
		return
	end
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
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").social
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	self:StyleSocial()
end
