-- Gives the auction house's pages one layout on a grid (settings/blizzard.lua
-- auction): under the band Browse's toolbar (Reset over its categories,
-- the results' count and the page arrows over its results), then each
-- page's columns down to the foot, each on slate: the categories, the
-- selling column, the results with their column names on top. Blizzard's
-- Browse, Bids and Auctions pages, and Auctionator's (its own page, under
-- its tabs). The window itself (its band, tabs and foot) is panels.lua's.
-- Places only: Blizzard's and Auctionator's code are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Auction House", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local math_floor = math.floor
local select = select
local type = type

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded

-- `part` (or the part of that name) placed by its `point` (its top left
-- unless said) `x` right of the auction frame's left and `y` under its top.
local Place = function(part, x, y, point)
	part = (type(part) == "string") and _G[part] or part
	if part then
		part:ClearAllPoints()
		part:SetPoint(point or "TOPLEFT", _G.AuctionFrame, "TOPLEFT", x, -y)
		-- (kept where it is: panels' raise and lower are for what's not ours)
		part.DiabolicRaised, part.DiabolicLowered = true, true
	end
	return part
end

-- A zone of slate on `page` from `left`, `top` to `right`, `bottom`, under
-- what the page holds (shown with it).
local Zone = function(page, left, top, right, bottom)
	local holder = CreateFrame("Frame", nil, page)
	holder:SetPoint("TOPLEFT", _G.AuctionFrame, "TOPLEFT", left, -top)
	holder:SetPoint("BOTTOMRIGHT", _G.AuctionFrame, "TOPLEFT", right, -bottom)
	return kit:AddZone(holder, "slate", { 0, 0, 0, 0 }, page)
end

-- A list of results on `page` in `left`..`right` from `top` down to the
-- content's bottom, on slate: its rows (from `row`, the first) and their
-- scroll bar (`spec.width` wide in all) in its middle; its column names
-- (from `header`, the first) along its top, `spec.row_from` left of the
-- rows; its scroll frame `list` `spec.reach` right of the rows' left
-- (Blizzard's: its bar by their end).
Module.PlaceResults = function(self, page, left, top, right, header, row, list, spec)
	local config = self.config
	local bottom = config.content.bottom
	Zone(page, left, top, right, bottom)
	local x, y = math_floor(left + (right - left - spec.width) / 2), top + config.pad
	Place(header, x - spec.row_from, y)
	local rowsTop = y + config.header_height + config.row_gap
	Place(row, x, rowsTop)
	local scroll = Place(list, x + spec.reach, rowsTop, "TOPRIGHT")
	scroll:SetHeight(bottom - config.pad - rowsTop)
end

-- A category's button as our flat red one (a subcategory's fainter, an
-- item type's without: Blizzard's own art by its kind, out of sight), lit
-- under the mouse or chosen; as Blizzard sets its kind.
local StyleFilter = function(button)
	local alpha = Module.config.browse.filter_alpha
	if not button.DiabolicArt then
		local spec = kit.config.rect_button
		local height = button:GetHeight()
		button.DiabolicArt = kit:CreateSlices(button, "BACKGROUND", spec, spec.texture.normal, height)
		kit:AddLit(button, kit:CreateSlices(button, "BORDER", spec, spec.texture.lit, height))
		local highlight = button:GetHighlightTexture()
		if highlight then
			highlight:SetAlpha(0)
		end
	end
	local name = button:GetName()
	local normal = name and _G[name .. "NormalTexture"]
	if normal then
		normal:SetAlpha(0)
	end
	button.DiabolicArt:SetAlpha(alpha[button.type or "class"] or 0)
end

-- Browse: Reset over the categories, the results' count and the page
-- arrows over the results, in the toolbar; the categories and the results
-- under it.
Module.PlaceBrowse = function(self)
	local config = self.config
	local spec, content = config.browse, config.content
	local page = _G.AuctionFrameBrowse
	local top, middle = content.top, content.top + config.toolbar / 2
	local split = content.left + spec.column
	local zoneTop = top + config.toolbar + config.gap

	local reset = Place("BrowseResetButton", content.left, top)
	reset:SetSize(spec.column, config.toolbar)
	Place("BrowseSearchCountText", split + config.gap + config.pad, middle, "LEFT")
	local nextPage = Place("BrowseNextPageButton", content.right, middle, "RIGHT")
	nextPage:SetSize(config.toolbar, config.toolbar)
	local previous = _G.BrowsePrevPageButton
	previous:ClearAllPoints()
	previous:SetPoint("RIGHT", nextPage, "LEFT", -config.arrow_gap, 0)
	previous:SetSize(config.toolbar, config.toolbar)

	-- the categories: their buttons, their scroll bar beside them
	Zone(page, content.left, zoneTop, split, content.bottom)
	local x, y = content.left + spec.inset, zoneTop + config.pad
	Place("AuctionFilterButton1", x, y)
	local i = 1
	while _G["AuctionFilterButton" .. i] do
		StyleFilter(_G["AuctionFilterButton" .. i])
		i = i + 1
	end
	if _G.FilterButton_SetType then
		hooksecurefunc("FilterButton_SetType", StyleFilter)
	end
	local filters = Place("BrowseFilterScrollFrame", x + spec.filter_width, y, "TOPRIGHT")
	filters:SetHeight(content.bottom - config.pad - y)

	local left = split + config.gap
	self:PlaceResults(page, left, zoneTop, content.right, "BrowseQualitySort", "BrowseButton1", "BrowseScrollFrame", spec)
	Place("BrowseNoResultsText", (left + content.right) / 2, zoneTop + spec.no_results_y, "TOP")
end

-- Bids: its results across the page.
Module.PlaceBids = function(self)
	local content = self.config.content
	self:PlaceResults(_G.AuctionFrameBid, content.left, content.top, content.right, "BidQualitySort", "BidButton1",
		"BidScrollFrame", self.config.bids)
end

-- What's placed on `holder` by its top (by one point) moved by `move`
-- (right, up), once: `Pick`, which of them (by their point on it, their
-- offset from it and their left edge on it).
local Move = function(holder, move, Pick, ...)
	for i = 1, select("#", ...) do
		local part = select(i, ...)
		if (not part.DiabolicPlaced) and (part:GetNumPoints() == 1) then
			local point, relative, relativePoint, x, y = part:GetPoint()
			-- (its left: from its point's offset and its width)
			local left = x - (point:find("RIGHT$") and part:GetWidth() or point:find("LEFT$") and 0 or part:GetWidth() / 2)
			if ((relative == holder) or (relative == nil)) and Pick(relativePoint, x, left) then
				part:SetPoint(point, relative, relativePoint, x + move[1], y + move[2])
				part.DiabolicPlaced, part.DiabolicRaised, part.DiabolicLowered = true, true, true
			end
		end
	end
end

-- Auctions: the selling column (Blizzard's parts placed from the page's
-- left, moved as one) and its results.
Module.PlaceAuctions = function(self)
	local config = self.config
	local content, spec = config.content, config.auctions
	local page = _G.AuctionFrameAuctions
	local split = content.left + spec.column
	Zone(page, content.left, content.top, split, content.bottom)
	-- (by where they are: a dropdown is placed by its right)
	local Left = function(relativePoint, x, left)
		return relativePoint:find("LEFT$") and (left < spec.column)
	end
	Move(page, spec.move, Left, page:GetChildren())
	Move(page, spec.move, Left, page:GetRegions())
	-- (its item's slot: Blizzard's art is the window's, out of sight)
	local button = _G.AuctionsItemButton
	local slot = button:CreateTexture(nil, "BACKGROUND")
	slot:SetTexture(spec.slot_texture)
	slot:SetPoint("CENTER")
	slot:SetSize(button:GetWidth() * spec.slot_scale, button:GetHeight() * spec.slot_scale)
	kit:AddBorder(button, button:GetWidth())
	self:PlaceResults(page, split + config.gap, content.top, content.right, "AuctionsQualitySort", "AuctionsButton1",
		"AuctionsScrollFrame", spec)
end

-- Auctionator's page (it makes it as the auction house loads; placed as
-- the window first shows with it): its left column (left of the page:
-- its history, its shopping lists, its selling column) and the rest (the
-- recommended price, its results' headings and list), each moved as one,
-- each on slate; its own black and its headings' bar gone.
Module.PlaceAuctionator = function(self)
	local page = _G.Atr_Main_Panel
	if (not page) or page.DiabolicPlaced then
		return
	end
	page.DiabolicPlaced = true
	local config = self.config
	local content, spec = config.content, config.auctionator
	local split = content.left + spec.column
	Zone(page, content.left, content.top, split, content.bottom)
	Zone(page, split + config.gap, content.top, content.right, content.bottom)
	local Left = function(relativePoint, x)
		return (relativePoint == "TOPLEFT") and (x < 0)
	end
	local Right = function(relativePoint, x)
		return relativePoint:find("^TOP") and not Left(relativePoint, x)
	end
	Move(page, spec.left_move, Left, page:GetChildren())
	Move(page, spec.left_move, Left, page:GetRegions())
	Move(page, spec.right_move, Right, page:GetChildren())
	Move(page, spec.right_move, Right, page:GetRegions())
	for _, name in ipairs({ "Atr_Hlist", "Atr_SellControls" }) do
		local frame = _G[name]
		if frame then
			if frame.SetBackdrop then
				frame:SetBackdrop(nil)
			end
			kit:HideTextures(frame)
		end
	end
	-- (its buttons in the band as tall as its Search: on one row; its "+" square)
	local search = _G.Atr_Search_Button
	if search then
		local height = search:GetHeight()
		for _, name in ipairs({ "Atr_Adv_Search_Button", "Atr_FullScanButton", "Auctionator1Button" }) do
			if _G[name] then
				_G[name]:SetHeight(height)
			end
		end
		if _G.Atr_Adv_Search_Button then
			_G.Atr_Adv_Search_Button:SetWidth(height)
		end
	end
	if _G.Atr_HeadingsBarMiddle then
		_G.Atr_HeadingsBarMiddle:SetAlpha(0)
	end
	self:PlaceAuctionatorDialogs()
end

-- Auctionator's dialogs as our popups, in the middle of the window, its
-- shade over the window (both are placed for Blizzard's, on the screen).
local DIALOGS = {
	Atr_CheckActives_Frame = { "Atr_CheckActives_Yes_Button", "Atr_CheckActives_No_Button" },
	Atr_Buy_Confirm_Frame = { "Atr_Buy_Confirm_OKBut", "Atr_Buy_Confirm_CancelBut" },
	Atr_Confirm_Frame = { "Atr_Confirm_Cancel" },
	Atr_Error_Frame = {},
	Atr_FullScanFrame = { "Atr_FullScanStartButton", "Atr_FullScanDone" }
}
Module.PlaceAuctionatorDialogs = function(self)
	local window
	for i = 1, select("#", _G.AuctionFrame:GetChildren()) do
		local child = select(i, _G.AuctionFrame:GetChildren())
		if (child.Frame == _G.AuctionFrame) then
			window = child
		end
	end
	local mask = _G.Atr_Mask
	if (not window) or (not mask) then
		return
	end
	local Cover = function()
		mask:ClearAllPoints()
		mask:SetAllPoints(window)
	end
	mask:HookScript("OnShow", Cover)
	Cover()
	local popups = Engine:GetModule("Blizzard: PopUps")
	for name, buttons in pairs(DIALOGS) do
		local dialog = _G[name]
		if dialog then
			popups:StyleFrame(dialog)
			for _, button in ipairs(buttons) do
				if _G[button] then
					popups:StyleButton(_G[button])
				end
			end
			local Center = function()
				dialog:ClearAllPoints()
				dialog:SetPoint("CENTER", window, "CENTER")
			end
			dialog:HookScript("OnShow", Center)
			Center()
		end
	end
end

Module.StyleAuctionHouse = function(self)
	if self.Styled then
		return
	end
	self.Styled = true
	self:PlaceBrowse()
	self:PlaceBids()
	self:PlaceAuctions()
	self:PlaceAuctionator()
	_G.AuctionFrame:HookScript("OnShow", function()
		self:PlaceAuctionator()
	end)
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "Blizzard_AuctionUI") then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleAuctionHouse()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").auction
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	if IsAddOnLoaded("Blizzard_AuctionUI") then
		self:StyleAuctionHouse()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
