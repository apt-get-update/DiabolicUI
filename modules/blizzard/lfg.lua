-- Gives Blizzard's Dungeon Finder and Raid Browser Diablo III's window
-- (windows.lua): the stone window in its iron frame instead of their frame
-- art, the title in the plate over the red band (the Raid Browser's tabs in
-- a row under it), the lists in darker panels (the random dungeon's text
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
local select = select
local unpack = unpack

-- their frame art, by its file (lowercase, as patterns)
local ART = {
	"ui%-lfg%-frame", "ui%-lfr%-frame", "ui%-lfg%-portrait", "ui%-lfr%-portrait", "ui%-character%-scrollbar", "ui%-lfg%-filigree",
	"ui%-lfg%-background%-questpaper"
}

-- the lists, each in a darker panel
local LISTS = {
	"LFDQueueFrameSpecificListScrollFrame", "LFDQueueFrameRandomScrollFrame", "LFRQueueFrameSpecificListScrollFrame",
	"LFRBrowseFrameListScrollFrame"
}

-- the random dungeon's text, drawn for the parchment: pale on our panel
local RANDOM = "LFDQueueFrameRandomScrollFrameChildFrame"
local RANDOM_HEADERS = { "Title", "RewardsLabel" }
local RANDOM_TEXTS = { "Description", "RewardsDescription", "PUGDescription", "MoneyLabel", "XPLabel" }

-- The window's own close button (an unnamed child).
local FindClose = function(frame)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		local texture = child:IsObjectType("Button") and child:GetNormalTexture()
		local file = texture and texture:GetTexture()
		if file and file:lower():find("ui%-panel%-minimizebutton") then
			return child
		end
	end
end

-- `frame` in our window, `spec` its settings, `title` its title's font
-- string; its header returned.
Module.StyleFrame = function(self, frame, spec, title)
	local config = self.config
	local window = kit:CreateWindow(frame, spec.insets)
	kit:SetBackground(window, "saron")
	kit:AddDrag(window, frame)
	kit:SetPanelLayout(frame, spec.insets, spec.insets[1], spec.offset_y)
	kit:HideArt(frame, ART)
	local header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(header, title)
	local close = FindClose(frame)
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
		-- Find Group and Close in the window's bottom corners, clear of the
		-- iron frame (Blizzard's sit on its edge)
		local find, cancel = _G.LFDQueueFrameFindGroupButton, _G.LFDQueueFrameCancelButton
		find:ClearAllPoints()
		find:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT", config.button_margin, config.button_bottom)
		cancel:ClearAllPoints()
		cancel:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -config.button_margin, config.button_bottom)
		for _, name in ipairs(RANDOM_HEADERS) do
			_G[RANDOM .. name]:SetTextColor(unpack(config.header_color))
		end
		for _, name in ipairs(RANDOM_TEXTS) do
			_G[RANDOM .. name]:SetTextColor(unpack(config.text_color))
		end
		-- the dungeon's choice under the band (the title's in it), Diablo
		-- III's, its label gone, wide enough for the longest choice
		-- (Blizzard sets its width each time it's shown)
		local dropdown = _G.LFDQueueFrameTypeDropDown
		if dropdown then
			kit:StyleDropDown(dropdown)
			dropdown:ClearAllPoints()
			dropdown:SetPoint("CENTER", window, "TOP", 0, config.type_y)
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
		self:CenterRoles(window)
		-- the random dungeon and the list up into the dropdown's room
		for _, name in ipairs({ "LFDQueueFrameRandom", "LFDQueueFrameSpecific" }) do
			local page = _G[name]
			if page then
				page:ClearAllPoints()
				page:SetPoint("TOPLEFT", _G.LFDQueueFrame, "TOPLEFT", 0, config.lists_raise)
				page:SetPoint("BOTTOMRIGHT", _G.LFDQueueFrame, "BOTTOMRIGHT", 0, config.lists_raise)
			end
		end
	end
	if _G.LFRParentFrame then
		local header = self:StyleFrame(_G.LFRParentFrame, config.raids, _G.LFRQueueFrameTitleText)
		-- the same title on both tabs: one in the plate
		if _G.LFRBrowseFrameTitleText then
			_G.LFRBrowseFrameTitleText:SetAlpha(0)
		end
		-- the comment's button as far in from the right as List Me is from
		-- the left (Blizzard's sits under the window's frame)
		local comment = _G.LFRQueueFrameAcceptCommentButton
		if comment then
			local point, relative, relativePoint, _, y = comment:GetPoint()
			comment:SetPoint(point, relative, relativePoint, -config.comment_right, y)
		end
		local tab = _G.LFRParentFrameTab1
		tab:ClearAllPoints()
		tab:SetPoint("TOPLEFT", header, "BOTTOMLEFT", unpack(config.tab_offset))
		kit:AddTabStrip(header)
		for i = 1, 2 do
			kit:StyleTab(_G["LFRParentFrameTab" .. i], { inset = config.tab_inset, font = config.tab_font })
		end
	end
	for _, name in ipairs(LISTS) do
		if _G[name] then
			kit:AddPanel(_G[name], config.list_panel_insets)
		end
	end
end

-- The roles' row (tank, healer, damage, leader: Blizzard's in a row from
-- the tank, each from the one before) in the middle of the window, under
-- the band: its width from their sizes and Blizzard's gaps.
Module.CenterRoles = function(self, window)
	local width = 0
	for i, role in ipairs({ "Tank", "Healer", "DPS", "Leader" }) do
		local button = _G["LFDQueueFrameRoleButton" .. role]
		width = width + button:GetWidth()
		if (i > 1) then
			width = width + select(4, button:GetPoint())
		end
	end
	local first = _G.LFDQueueFrameRoleButtonTank
	first:ClearAllPoints()
	first:SetPoint("TOPLEFT", window, "TOP", -width / 2, self.config.roles_top)
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
