-- Gives Blizzard's Dungeon Finder and Raid Browser Diablo III's window
-- (windows.lua): the stone window in its iron frame instead of their frame
-- art, the title in a plate on its top edge (the Raid Browser's tabs in
-- a row under it, the Dungeon Finder's choice in its band), the lists in darker panels (the random dungeon's text
-- pale on its), the buttons ours. Blizzard
-- places their parts against the whole frame, so the window grows around
-- it instead of moving them.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: LFG", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local select = select
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame

-- their frame art, by its file (lowercase, as patterns)
local ART = {
	"ui%-lfg%-frame", "ui%-lfr%-frame", "ui%-lfg%-portrait", "ui%-lfr%-portrait", "ui%-character%-scrollbar", "ui%-lfg%-filigree",
	"ui%-lfg%-background%-questpaper"
}

-- the lists, each on slate
local LISTS = { "LFDQueueFrameSpecificListScrollFrame", "LFDQueueFrameRandomScrollFrame" }
local RAID_LISTS = { "LFRQueueFrameSpecificListScrollFrame", "LFRBrowseFrameListScrollFrame" }

-- the random dungeon's text, drawn for the parchment: pale on our panel
local RANDOM = "LFDQueueFrameRandomScrollFrameChildFrame"
local RANDOM_HEADERS = { "Title", "RewardsLabel" }
local RANDOM_TEXTS = { "Description", "RewardsDescription", "PUGDescription", "MoneyLabel", "XPLabel" }

-- `frame` in our window, `spec` its settings, `title` its title's font
-- string; its header returned.
Module.StyleFrame = function(self, frame, spec, title)
	local config = self.config
	local window = kit:CreateWindow(frame, spec.insets)
	kit:SetBackground(window, spec.background or "saron")
	kit:AddDrag(window, frame)
	kit:SetPanelLayout(frame, spec.insets, spec.insets[1], spec.offset_y)
	kit:HideArt(frame, ART)
	local header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(header, title)
	local close = kit:FindClose(frame)
	if close then
		kit:StyleClose(close, window, header)
	end
	kit:StyleButtons(frame)
	return header
end

Module.StyleLFG = function(self)
	local config = self.config
	if _G.LFDParentFrame then
		local header = self:StyleFrame(_G.LFDParentFrame, config.dungeons, _G.LFDQueueFrameTitleText)
		local window = header:GetParent()
		-- the eye in the corner (Blizzard's portrait, animated while queued)
		_G.LFDParentFramePortrait:SetAlpha(0)
		kit:AddFooter(window, true)
		for _, name in ipairs(RANDOM_HEADERS) do
			_G[RANDOM .. name]:SetTextColor(unpack(config.header_color))
		end
		for _, name in ipairs(RANDOM_TEXTS) do
			_G[RANDOM .. name]:SetTextColor(unpack(config.text_color))
		end
		-- the dungeon's choice at the band's left end, Diablo III's, its
		-- label gone, wide enough for the longest choice (Blizzard sets
		-- its width each time it's shown)
		local dropdown = _G.LFDQueueFrameTypeDropDown
		if dropdown then
			kit:StyleDropDown(dropdown)
			kit:LineBand(header, { dropdown })
			_G.UIDropDownMenu_SetWidth(dropdown, config.type_width)
			dropdown:HookScript("OnShow", function() _G.UIDropDownMenu_SetWidth(dropdown, config.type_width) end)
			_G.LFDQueueFrameTypeDropDownName:SetAlpha(0)
			-- its text in the middle of the plate's room left of the arrow
			-- (Blizzard's sits right-aligned, above the middle)
			local text, spec = _G.LFDQueueFrameTypeDropDownText, kit.config.dropdown
			text:ClearAllPoints()
			text:SetPoint("CENTER", dropdown, "CENTER", -(spec.arrow_size + spec.arrow_gap) / 2, 0)
			text:SetJustifyH("CENTER")
		end
		self:CenterRoles(window, "LFDQueueFrameRoleButton", { "Tank", "Healer", "DPS", "Leader" }, config.roles_top)
		-- the list longer: its rows more (its update shows as many as
		-- NUM_LFD_CHOICE_BUTTONS)
		self:AddDungeonRows(config.extra_rows, config.list_bottom_raise)
	end
	if _G.LFRParentFrame then
		local header = self:StyleFrame(_G.LFRParentFrame, config.raids, _G.LFRQueueFrameTitleText)
		-- the rough stone foot
		kit:AddFooter(header:GetParent(), true)
		-- its lists' zones across the window, their rows further left
		-- (Blizzard's lists reach under its right side)
		local window, insets, margins = header:GetParent(), config.list_panel_insets, config.raid_list_margins
		if _G.LFRBrowseFrameColumnHeader1 then
			kit:StyleColumnHeaders("LFRBrowseFrameColumnHeader", 7)
		end
		-- a row more in the browse list's room gained (Blizzard's 19)
		local count = _G.NUM_LFR_LIST_BUTTONS
		local last = count and _G["LFRBrowseFrameListButton" .. count]
		if last then
			local row = CreateFrame("Button", "LFRBrowseFrameListButton" .. (count + 1), last:GetParent(), "LFRBrowseButtonTemplate")
			row:SetID(count + 1)
			row:SetPoint("TOPLEFT", last, "BOTTOMLEFT")
			-- (its scroll frame's bottom right on the last row's, as Blizzard's)
			_G.LFRBrowseFrameListScrollFrame:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 5, -2)
			_G.NUM_LFR_LIST_BUTTONS = count + 1
		end
		local Across = function(zone, frame, top, bottom)
			zone:ClearAllPoints()
			zone:SetPoint("TOP", frame, "TOP", 0, top)
			zone:SetPoint("BOTTOM", frame, "BOTTOM", 0, -bottom)
			zone:SetPoint("LEFT", window, "LEFT", margins[1], 0)
			zone:SetPoint("RIGHT", window, "RIGHT", -margins[2], 0)
		end
		for _, name in ipairs(RAID_LISTS) do
			local list = _G[name]
			if list then
				local zone = kit:AddZone(list, "slate", insets)
				Across(zone, list, (name == "LFRBrowseFrameListScrollFrame") and config.raid_browse_top or insets[2], insets[4])
				-- (the browse list's column names on a dark bar, as the who list's)
				if (name == "LFRBrowseFrameListScrollFrame") then
					kit:AddHeaderBar(zone)
				end
				-- the queue's down to over its foot: its room under it as over it
				if (name == "LFRQueueFrameSpecificListScrollFrame") then
					zone:SetPoint("BOTTOM", _G.LFRQueueFrameFindGroupButton, "TOP", 0, kit:FootReach() + config.raid_queue_gap)
				end
			end
		end
		-- the comment in the band, one line on Diablo III's plate, its hint
		-- (its first sentence) pale in it while it's empty; the button
		-- that focuses it over it
		local comment = _G.LFRQueueFrameComment
		if comment then
			local width, height = unpack(config.comment_size)
			comment:SetMultiLine(false)
			comment:SetSize(width, height)
			comment:SetFrameLevel(header:GetFrameLevel() + 1)
			kit:StyleEditBox(comment)
			kit:LineBand(header, { comment })
			local hint, text = _G.LFRQueueFrameCommentExplanation, _G.TYPE_LFR_COMMENT_HERE
			hint:SetText(text:match("^[^%.]+%.") or text)
			hint:SetFontObject(config.comment_hint_font)
			hint:SetTextColor(unpack(config.comment_hint_color))
			hint:SetSize(width, height)
			hint:SetJustifyV("MIDDLE")
			local button = _G.LFRQueueFrameCommentTextButton
			button:SetSize(width, height)
			button:SetFrameLevel(header:GetFrameLevel() + 2)
		end
		-- the browse tab's raid choice in the band, "Browsing:" left of it
		local browse = _G.LFRBrowseFrameRaidDropDown
		if browse then
			kit:StyleDropDown(browse)
			local label = _G.LFRBrowseFrameRaidDropDownName
			kit:LineBand(header, { label, browse })
		end
		self:CenterRoles(window, "LFRQueueFrameRoleButton", { "Tank", "Healer", "DPS" }, config.raid_roles_top)
		-- the same title on both tabs: one in the plate
		if _G.LFRBrowseFrameTitleText then
			_G.LFRBrowseFrameTitleText:SetAlpha(0)
		end
		-- the tabs as banners hanging from the window's foot
		kit:HangTabs(window, { _G.LFRParentFrameTab1, _G.LFRParentFrameTab2 }, config.tab_sigils)
		kit:DropTop(window)
	end
	for _, name in ipairs(LISTS) do
		if _G[name] then
			kit:AddZone(_G[name], "slate", config.list_panel_overrides[name] or config.list_panel_insets)
		end
	end
	-- Find Group and Close over the lists' slate, which reaches down to
	-- them (at their level, it would hide their art)
	for _, name in ipairs({ "LFDQueueFrameFindGroupButton", "LFDQueueFrameCancelButton" }) do
		local button = _G[name]
		if button then
			button:SetFrameLevel(button:GetFrameLevel() + 2)
		end
	end
end

-- `count` more rows in the Dungeon Finder's list, under Blizzard's, its
-- scroll frame down to the last, its bottom `raise` higher.
Module.AddDungeonRows = function(self, count, raise)
	local first = _G.NUM_LFD_CHOICE_BUTTONS
	local list = _G.LFDQueueFrameSpecificListScrollFrame
	local last = _G["LFDQueueFrameSpecificListButton" .. first]
	local point, _, relativePoint, x, y = list:GetPoint(2) -- (its bottom right, on the last row's)
	for i = first + 1, first + count do
		local row = CreateFrame("Frame", "LFDQueueFrameSpecificListButton" .. i, _G.LFDQueueFrameSpecific, "LFDFrameDungeonChoiceTemplate")
		row:SetID(i)
		row:SetPoint("TOPLEFT", last, "BOTTOMLEFT")
		last = row
	end
	list:SetPoint(point, last, relativePoint, x, y + raise)
	_G.NUM_LFD_CHOICE_BUTTONS = first + count
end

-- A row of roles (`prefix` and each of `roles`: Blizzard's in a row from
-- the first, each from the one before) in the middle of the window, `top`
-- from its top: its width from their sizes and Blizzard's gaps.
Module.CenterRoles = function(self, window, prefix, roles, top)
	local width = 0
	for i, role in ipairs(roles) do
		local button = _G[prefix .. role]
		width = width + button:GetWidth()
		if (i > 1) then
			width = width + select(4, button:GetPoint())
		end
	end
	local first = _G[prefix .. roles[1]]
	first:ClearAllPoints()
	first:SetPoint("TOPLEFT", window, "TOP", -width / 2, top)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").lfg
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleLFG()
end
