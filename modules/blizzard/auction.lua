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
local Zone = function(page, name, list)
	local holder = CreateFrame("Frame", name, page)
	Engine:GetModule("Blizzard: Adjust"):Add(name)
	local zone = kit:AddZone(holder, "slate", { 0, 0, 0, 0 }, page)
	-- (the list's scroll bar on the zone's right, as every list's)
	local bar = list and _G[list .. "ScrollBar"]
	if bar then
		kit:SeatScrollBar(bar, zone)
	end
	return zone
end

-- Each list's column names (Blizzard's sort buttons), by its first.
local SORTS = {
	BrowseQualitySort = { "BrowseQualitySort", "BrowseLevelSort", "BrowseDurationSort", "BrowseHighBidderSort", "BrowseCurrentBidSort" },
	BidQualitySort = { "BidQualitySort", "BidLevelSort", "BidDurationSort", "BidBuyoutSort", "BidStatusSort", "BidBidSort" },
	AuctionsQualitySort = { "AuctionsQualitySort", "AuctionsDurationSort", "AuctionsHighBidderSort", "AuctionsBidSort" },
}

-- A list of results on `page`, on slate (the zone `name`): its column names
-- (from `header`, the first) along its top, its rows (from `row`, the first)
-- and their scroll frame `list` (Blizzard's: its bar by their end) under them.
Module.PlaceResults = function(self, page, name, header, row, list)
	Zone(page, name, list)
	Ours(header, row, list)
	-- its column names as the other tables': no tab art, a thin line under
	local sorts = {}
	for _, sort in ipairs(SORTS[header] or {}) do
		sorts[#sorts + 1] = _G[sort]
	end
	kit:StyleColumnButtons(sorts, true)
end

-- A category's button as our flat red one (a subcategory's fainter, an
-- item type's without: Blizzard's own art by its kind, out of sight), lit
-- under the mouse or chosen; as Blizzard sets its kind. Its art `gap`
-- shorter than the button (room between one and the next), its text clear
-- of the art's ends.
local StyleFilter = function(button)
	local spec = Module.config.browse
	if not button.DiabolicArt then
		local art, height = kit.config.rect_button, button:GetHeight() - spec.filter_gap
		local holder = CreateFrame("Frame", nil, button)
		holder:SetFrameLevel(button:GetFrameLevel())
		holder:SetPoint("TOPLEFT", 0, -spec.filter_gap / 2)
		holder:SetPoint("BOTTOMRIGHT", 0, spec.filter_gap / 2)
		button.DiabolicArt = kit:CreateSlices(holder, "BACKGROUND", art, art.texture.normal, height)
		kit:AddLit(button, kit:CreateSlices(holder, "BORDER", art, art.texture.lit, height))
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
	button.DiabolicArt:SetAlpha(spec.filter_alpha[button.type or "class"] or 0)
	local text = name and _G[name .. "NormalText"]
	if text then
		text:SetPoint("LEFT", button, "LEFT", spec.filter_text[button.type or "class"] or spec.filter_text.class, 0)
	end
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
	Zone(page, "AuctionFrameBrowseDiabolicCategories", "BrowseFilterScrollFrame")
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
		local pages = math.ceil(total / _G.NUM_AUCTION_ITEMS_PER_PAGE)
		local current = browse.page or 0
		local count = (pages > 1) and math.min(pages, spec.shown) or 0
		local first = math.max(0, math.min(current - math.floor(spec.shown / 2), pages - count))
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

-- The vault behind a list (`zone`, its column names `header` on top):
-- empty, dust and cobwebs in its corners; holding something, a heap of
-- gold along its bottom, the higher the more it holds (Tao Te Ching, 11:
-- the room inside is what's used). Under the rows, below the names.
Module.AddVault = function(self, zone, header)
	local spec = self.config.vault
	local vault = CreateFrame("Frame", nil, zone)
	vault:SetFrameLevel(zone:GetFrameLevel())
	vault:SetPoint("BOTTOMLEFT", zone, "BOTTOMLEFT", spec.inset, spec.inset)
	vault:SetPoint("BOTTOMRIGHT", zone, "BOTTOMRIGHT", -spec.inset, spec.inset)
	vault.Zone, vault.Header = zone, header
	vault.Webs = {}
	for i, corner in ipairs(spec.webs) do
		local web = vault:CreateTexture(nil, "ARTWORK")
		web:SetTexture(spec.web)
		web:SetSize(corner[2], corner[2])
		web:SetPoint(corner[1], vault, corner[1])
		web:SetTexCoord(unpack(corner[3]))
		web:SetVertexColor(unpack(spec.web_color))
		vault.Webs[i] = web
	end
	local dust = vault:CreateTexture(nil, "ARTWORK")
	dust:SetTexture(spec.dust)
	dust:SetBlendMode("ADD")
	dust:SetVertexColor(unpack(spec.dust_color))
	dust:SetPoint("BOTTOMLEFT")
	dust:SetPoint("BOTTOMRIGHT")
	vault.Dust = dust
	local gold = vault:CreateTexture(nil, "ARTWORK")
	gold:SetTexture(spec.gold)
	gold:SetPoint("BOTTOMLEFT")
	gold:SetPoint("BOTTOMRIGHT")
	vault.Gold = gold
	return vault
end

-- The vault for how many a list holds: none, dust and webs; some, the heap.
Module.FillVault = function(self, vault, count)
	local spec = self.config.vault
	-- (its top under the column names: theirs over the list, not drawn over)
	local top, under = vault.Zone:GetTop(), vault.Header:GetBottom()
	if top and under then
		vault:SetPoint("TOP", vault.Zone, "TOP", 0, under - top - spec.inset)
	end
	local empty = (count or 0) == 0
	for _, web in ipairs(vault.Webs) do
		if empty then
			web:Show()
		else
			web:Hide()
		end
	end
	local height = vault:GetHeight()
	if empty or (height <= 0) then
		vault.Gold:Hide()
		vault.Dust:SetHeight(math.max(1, height * spec.dust_height))
		vault.Dust:Show()
		return
	end
	vault.Dust:Hide()
	local share = spec.heap[1] + (spec.heap[2] - spec.heap[1]) * math.min(count / spec.full, 1)
	vault.Gold:SetHeight(height * share)
	vault.Gold:Show()
end

-- Each list's vault, kept to what it holds (the results, your bids, your auctions).
Module.CreateVaults = function(self)
	local vaults = {}
	for list, place in pairs({
		list = { "AuctionFrameBrowseDiabolicResultsDiabolicZone", "BrowseQualitySort" },
		bidder = { "AuctionFrameBidDiabolicResultsDiabolicZone", "BidQualitySort" },
		owner = { "AuctionFrameAuctionsDiabolicResultsDiabolicZone", "AuctionsQualitySort" },
	}) do
		local zone, header = _G[place[1]], _G[place[2]]
		if zone and header then
			vaults[list] = self:AddVault(zone, header)
		end
	end
	local Fill = function()
		for list, vault in pairs(vaults) do
			self:FillVault(vault, (GetNumAuctionItems(list)))
		end
	end
	for _, event in ipairs({ "AUCTION_ITEM_LIST_UPDATE", "AUCTION_BIDDER_LIST_UPDATE", "AUCTION_OWNED_LIST_UPDATE" }) do
		self:RegisterEvent(event, Fill)
	end
	_G.AuctionFrame:HookScript("OnShow", Fill)
	for _, vault in pairs(vaults) do
		vault:SetScript("OnSizeChanged", Fill)
	end
	Fill()
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
	self:CreateVaults()
	self:PlaceAuctionator()
	_G.AuctionFrame:HookScript("OnShow", function()
		self:PlaceAuctionator()
	end)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").auction
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	self:WhenLoaded("Blizzard_AuctionUI", "StyleAuctionHouse")
end
