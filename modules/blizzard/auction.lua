-- Gives the auction house's pages one layout: under the band Browse's toolbar
-- (Reset over its categories, the results' count and the page arrows over
-- its results), then each page's columns down to the foot, each on slate:
-- the categories, the selling column, the results with their column names on
-- top. Blizzard's Browse, Bids and Auctions pages, and Auctionator's (its own
-- page, under its tabs). The slate zones and what's in them are placed from
-- windows/AuctionFrame.qml; the window itself (its band, tabs and foot) is
-- panels.lua's. Browse's page numbers are ours (Diablo III's, between its
-- arrows); Blizzard's and Auctionator's code are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Auction House", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local math_ceil = math.ceil
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local select = select
local unpack = unpack

-- WoW API
local CanSendAuctionQuery = _G.CanSendAuctionQuery
local CreateFrame = _G.CreateFrame
local GetNumAuctionItems = _G.GetNumAuctionItems
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded

-- Each part named is placed from windows/AuctionFrame.qml: kept where it
-- is (panels' raise and lower are for what's not ours).
local Ours = function(...)
	for i = 1, select("#", ...) do
		local part = _G[select(i, ...)]
		if part then
			part.DiabolicRaised, part.DiabolicLowered = true, true
		end
	end
end

-- A zone of slate named `name` on `page`, under what the page holds (shown
-- with it), placed and sized from windows/AuctionFrame.qml.
local Zone = function(page, name)
	local holder = CreateFrame("Frame", name, page)
	Engine:GetModule("Blizzard: Adjust"):Add(name)
	return kit:AddZone(holder, "slate", { 0, 0, 0, 0 }, page)
end

-- A list of results on `page`, on slate (the zone `name`): its column names
-- (from `header`, the first) along its top, its rows (from `row`, the first)
-- and their scroll frame `list` (Blizzard's: its bar by their end) under them.
Module.PlaceResults = function(self, page, name, header, row, list)
	Zone(page, name)
	Ours(header, row, list)
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
	local page = _G.AuctionFrameBrowse

	-- the toolbar: Reset, the results' count, the search's two checkboxes
	-- side by side (Diablo III's), the page arrows (the previous one left
	-- of the numbers: CreatePages)
	Ours(
		"BrowseResetButton",
		"BrowseSearchCountText",
		"IsUsableCheckButton",
		"ShowOnPlayerCheckButton",
		"BrowseNextPageButton"
	)
	for _, name in ipairs({ "IsUsableCheckButton", "ShowOnPlayerCheckButton" }) do
		kit:StyleCheckBox(_G[name])
	end
	_G.BrowsePrevPageButton:SetSize(config.toolbar, config.toolbar)

	-- the categories: their buttons, their scroll bar beside them
	Zone(page, "AuctionFrameBrowseDiabolicCategories")
	Ours("AuctionFilterButton1", "BrowseFilterScrollFrame", "BrowseNoResultsText")
	local i = 1
	while _G["AuctionFilterButton" .. i] do
		StyleFilter(_G["AuctionFilterButton" .. i])
		i = i + 1
	end
	if _G.FilterButton_SetType then
		hooksecurefunc("FilterButton_SetType", StyleFilter)
	end

	self:PlaceResults(
		page,
		"AuctionFrameBrowseDiabolicResults",
		"BrowseQualitySort",
		"BrowseButton1",
		"BrowseScrollFrame"
	)
end

-- Browse's pages as Diablo III's: up to `pages.shown` numbers between its
-- arrows, around the one shown (boxed in orange); a click asks for that
-- page, as the arrows do. None while it all fits on one.
Module.CreatePages = function(self)
	local spec, gap = self.config.pages, self.config.arrow_gap
	local browse, previous, nextPage = _G.AuctionFrameBrowse, _G.BrowsePrevPageButton, _G.BrowseNextPageButton
	local Ask = function(button)
		if CanSendAuctionQuery() and (browse.page ~= button.page) then
			browse.page = button.page
			_G.BrowseScrollFrameScrollBar:SetValue(0)
			_G.AuctionFrameBrowse_Search()
		end
	end
	local buttons = {}
	for i = 1, spec.shown do
		local button = CreateFrame("Button", nil, browse)
		button:SetSize(spec.size, spec.size)
		button:SetBackdrop(spec.backdrop)
		button:SetBackdropColor(unpack(spec.color))
		button:SetFontString(button:CreateFontString(nil, "OVERLAY"))
		button:SetNormalFontObject(spec.font)
		button:SetScript("OnClick", Ask)
		buttons[i] = button
	end
	self.Pages = buttons -- (the rightmost first)
	local Update = function()
		local total = select(2, GetNumAuctionItems("list")) or 0
		local pages = math_ceil(total / _G.NUM_AUCTION_ITEMS_PER_PAGE)
		local current = browse.page or 0
		local count = (pages > 1) and math_min(pages, spec.shown) or 0
		local first = math_max(0, math_min(current - math_floor(spec.shown / 2), pages - count))
		-- from the right, the last one by the next arrow
		local anchor = nextPage
		for i = 1, spec.shown do
			local button = buttons[i]
			if i <= count then
				button.page = first + count - i
				button:SetText(button.page + 1)
				local shown = (button.page == current)
				button:SetBackdropBorderColor(unpack(shown and spec.shown_border or spec.border))
				button:GetFontString():SetTextColor(unpack(shown and spec.shown_color or spec.text_color))
				button:ClearAllPoints()
				button:SetPoint("RIGHT", anchor, "LEFT", -gap, 0)
				button:Show()
				anchor = button
			else
				button:Hide()
			end
		end
		previous:ClearAllPoints()
		previous:SetPoint("RIGHT", anchor, "LEFT", -gap, 0)
	end
	if _G.AuctionFrameBrowse_Update then
		hooksecurefunc("AuctionFrameBrowse_Update", Update)
	end
	Update()
end

-- Bids: its results across the page.
Module.PlaceBids = function(self)
	self:PlaceResults(
		_G.AuctionFrameBid,
		"AuctionFrameBidDiabolicResults",
		"BidQualitySort",
		"BidButton1",
		"BidScrollFrame"
	)
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
			local left = x
				- (point:find("RIGHT$") and part:GetWidth() or point:find("LEFT$") and 0 or part:GetWidth() / 2)
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
	local spec = self.config.auctions
	local page = _G.AuctionFrameAuctions
	Zone(page, "AuctionFrameAuctionsDiabolicSelling")
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
	self:PlaceResults(
		page,
		"AuctionFrameAuctionsDiabolicResults",
		"AuctionsQualitySort",
		"AuctionsButton1",
		"AuctionsScrollFrame"
	)
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
	local spec = self.config.auctionator
	Zone(page, "Atr_Main_PanelDiabolicLeft")
	Zone(page, "Atr_Main_PanelDiabolicRight")
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
	Atr_FullScanFrame = { "Atr_FullScanStartButton", "Atr_FullScanDone" },
}
Module.PlaceAuctionatorDialogs = function(self)
	local window
	for i = 1, select("#", _G.AuctionFrame:GetChildren()) do
		local child = select(i, _G.AuctionFrame:GetChildren())
		if child.Frame == _G.AuctionFrame then
			window = child
		end
	end
	local mask = _G.Atr_Mask
	if (not window) or not mask then
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
	self:CreatePages()
	self:PlaceBids()
	self:PlaceAuctions()
	self:PlaceAuctionator()
	_G.AuctionFrame:HookScript("OnShow", function()
		self:PlaceAuctionator()
	end)
end

Module.ADDON_LOADED = function(self, event, addon)
	if addon == "Blizzard_AuctionUI" then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleAuctionHouse()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").auction
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	if IsAddOnLoaded("Blizzard_AuctionUI") then
		self:StyleAuctionHouse()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
