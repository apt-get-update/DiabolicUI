-- Run from the addon root: lua5.1 tests/test_session_auction.lua
--
-- The auction house on its grid (modules/blizzard/auction.lua) in the fake
-- client: each page, Blizzard's and Auctionator's, its parts where the grid puts them,
-- the categories as our buttons, Auctionator's own art gone and its band's
-- buttons on one row.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Blizzard = require("mocks.client_blizzard")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client

-- The auction house open (Auctionator's too, if `withAuctionator`), the
-- layout check on.
local function open(withAuctionator)
	client = Client.boot(withAuctionator and { world = function(world)
		table.insert(world.addons, { name = "Auctionator", enabled = true, onLoad = Blizzard.Auctionator })
	end } or nil)
	client:Tick(0.2)
	client.api.LoadAddOn("Blizzard_AuctionUI")
	if withAuctionator then
		client.api.LoadAddOn("Auctionator")
	end
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("layout")
	local frame = _G.AuctionFrame
	frame:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 0, -104)
	frame:Show()
	return frame
end

-- The page of tab `i` shown.
local function page(i)
	_G.AuctionFrameTab_OnClick(_G["AuctionFrameTab" .. i])
	client:Tick(1.2, 0.1)
end

-- `part`'s edges in the auction frame's units: left, top, right, bottom
-- (y down from its top).
local function edges(part)
	local frame = _G.AuctionFrame
	return part:GetLeft() - frame:GetLeft(), frame:GetTop() - part:GetTop(), part:GetRight() - frame:GetLeft(),
		frame:GetTop() - part:GetBottom()
end

-- The slate zones shown on `holder`, by their left edge.
local function zones(holder)
	local found = {}
	for i = 1, select("#", holder:GetChildren()) do
		local child = select(i, holder:GetChildren())
		if child.DiabolicContent and child:IsVisible() then
			found[#found + 1] = child
		end
	end
	table.sort(found, function(a, b) return a:GetLeft() < b:GetLeft() end)
	return found
end

TestAuctionHouse = {}

function TestAuctionHouse:tearDown()
	client = nil
end

function TestAuctionHouse:test_each_blizzard_page_shows()
	open()
	for i = 1, 3 do
		page(i)
	end
	assertClean(client)
end

function TestAuctionHouse:test_each_auctionator_page_shows()
	open(true)
	for i = 1, 6 do
		page(i)
	end
	assertClean(client)
end

-- The bottom row in the foot, right up against its side: Blizzard's own spots
-- no longer count.
function TestAuctionHouse:test_the_bottom_rows_on_the_foot()
	open(true)
	local foot = _G.AuctionFrameDiabolicFoot
	lu.assertEquals(foot:GetHeight(), 35)
	for _, row in ipairs({ { "BrowseBidButton", "BrowseCloseButton" }, { "BidBidButton", "BidCloseButton" },
		{ "AuctionsCancelAuctionButton", "AuctionsCloseButton" }, { "Atr_Buy1_Button", "AuctionatorCloseButton" } }) do
		local first, last = _G[row[1]], _G[row[2]]
		local _, on = first:GetPoint()
		lu.assertEquals(on, foot, row[1])
		lu.assertEquals(first:GetBottom() - foot:GetBottom(), 7, row[1])
		lu.assertTrue(math.abs(foot:GetRight() - last:GetRight() - 9) < .2, row[2])
	end
	local _, money = _G.AuctionFrameMoneyFrame:GetPoint()
	lu.assertEquals(money, foot)
	assertClean(client)
end

function TestAuctionHouse:test_browse_on_the_grid()
	open()
	page(1)
	-- (placed from windows/AuctionFrame.qml)
	local positions = client.Engine:GetDB("Positions")
	local spot = positions.AuctionFrameBrowseDiabolicCategories
	-- the categories and the results side by side, tops and bottoms lined
	-- up; the column names on the results
	local categories, results = unpack(zones(_G.AuctionFrameBrowse))
	local left, top, right, bottom = edges(categories)
	lu.assertEquals({ left, top, right - left, bottom - top }, { spot[4], -spot[5], spot[6], spot[7] })
	local _, resultsTop, _, resultsBottom = edges(results)
	lu.assertEquals({ resultsTop, resultsBottom }, { top, bottom })
	lu.assertTrue(select(1, edges(results)) > right)
	-- the toolbar over them: Reset over the categories' buttons, as wide;
	-- the search's checkboxes side by side after the count; the arrows
	-- ending with the column names
	local resetLeft, _, resetRight, resetBottom = edges(_G.BrowseResetButton)
	local buttonLeft = edges(_G.AuctionFilterButton1)
	lu.assertEquals({ resetLeft, resetRight }, { buttonLeft, buttonLeft + _G.BrowseResetButton:GetWidth() })
	lu.assertTrue(resetBottom < top)
	local usable, onPlayer = _G.IsUsableCheckButton, _G.ShowOnPlayerCheckButton
	lu.assertTrue(usable:GetLeft() > _G.BrowseSearchCountText:GetLeft())
	lu.assertTrue(onPlayer:GetLeft() > _G.IsUsableCheckButtonText:GetRight())
	lu.assertEquals(select(2, usable:GetCenter()), select(2, onPlayer:GetCenter()))
	lu.assertTrue(select(2, edges(usable)) > select(4, edges(_G.BrowseSearchButton))) -- (under the band)
	lu.assertEquals(select(3, edges(_G.BrowseNextPageButton)), select(3, edges(results)) + positions.BrowseNextPageButton[4])
	local headerLeft, headerTop = edges(_G.BrowseQualitySort)
	lu.assertEquals(headerTop, top - positions.BrowseQualitySort[5])
	lu.assertTrue(headerLeft > select(1, edges(results)))
	assertClean(client)
end

function TestAuctionHouse:test_bids_and_auctions_rows_in_their_zones_middle()
	open()
	-- Bids' rows (their icon too) as far from the zone's sides, the bar
	-- by their end
	page(2)
	local left, _, right = edges(_G.BidButton1)
	local zoneLeft, _, zoneRight = edges(zones(_G.AuctionFrameBid)[1])
	lu.assertTrue(math.abs((left - zoneLeft) - (zoneRight - right)) <= 1)
	-- Auctions' item in a dark slot of ours
	page(3)
	local button, found = _G.AuctionsItemButton, false
	for i = 1, select("#", button:GetRegions()) do
		local region = select(i, button:GetRegions())
		if region:IsObjectType("Texture") and (region:GetTexture() or ""):find("64x64_Backdrop") then
			found = region:IsVisible() and (region:GetAlpha() > 0)
		end
	end
	lu.assertTrue(found)
	assertClean(client)
end

function TestAuctionHouse:test_the_categories_red_by_kind()
	open()
	page(1)
	local alpha = client.Engine:GetDB("Blizzard").auction.browse.filter_alpha
	local button = _G.AuctionFilterButton1
	-- Blizzard's art out of sight, ours by the button's kind
	lu.assertEquals(_G.AuctionFilterButton1NormalTexture:GetAlpha(), 0)
	lu.assertEquals(button.DiabolicArt[1]:GetAlpha(), alpha.class)
	_G.FilterButton_SetType(button, "subclass", "Axes")
	lu.assertEquals(_G.AuctionFilterButton1NormalTexture:GetAlpha(), 0)
	lu.assertEquals(button.DiabolicArt[1]:GetAlpha(), alpha.subclass)
	_G.FilterButton_SetType(button, "invtype", "Head")
	lu.assertEquals(button.DiabolicArt[1]:GetAlpha(), alpha.invtype)
	assertClean(client)
end

function TestAuctionHouse:test_browse_pages_numbered_between_its_arrows()
	open()
	page(1)
	local spec = client.Engine:GetDB("Blizzard").auction.pages
	local pages = client:GetModule("Blizzard: Auction House").Pages
	local previous, nextPage = _G.BrowsePrevPageButton, _G.BrowseNextPageButton
	-- all on one page: no numbers, the arrows side by side
	client.world.auctions = { 30, 30 }
	_G.AuctionFrameBrowse_Update()
	for _, button in ipairs(pages) do
		lu.assertNotEquals(button:IsShown(), 1)
	end
	lu.assertEquals(select(2, previous:GetPoint()), nextPage)
	-- 8 pages, the 4th shown: 2 to 6 between the arrows, the 4th boxed
	client.world.auctions = { 50, 380 }
	_G.AuctionFrameBrowse.page = 3
	_G.AuctionFrameBrowse_Update()
	local numbers = {}
	for i = #pages, 1, -1 do
		numbers[#numbers + 1] = tostring(pages[i]:GetText())
	end
	lu.assertEquals(numbers, { "2", "3", "4", "5", "6" })
	lu.assertEquals(select(2, pages[1]:GetPoint()), nextPage)
	lu.assertEquals(select(2, previous:GetPoint()), pages[5])
	lu.assertEquals({ pages[3]:GetBackdropBorderColor() }, spec.shown_border)
	lu.assertEquals({ pages[2]:GetBackdropBorderColor() }, spec.border)
	-- a click asks for its page
	pages[1]:Click()
	lu.assertEquals(client.auctionQuery, 5)
	lu.assertEquals(tostring(pages[1]:GetText()), "8")
	assertClean(client)
end

function TestAuctionHouse:test_styled_once_without_auctionators_dialogs()
	open()
	local module = client:GetModule("Blizzard: Auction House")
	local spec = client.Engine:GetDB("Blizzard").auction.pages
	-- loaded before us: styled at once, only once (its page numbers too)
	local count = #module.Pages
	module:OnEnable()
	lu.assertEquals(#module.Pages, count)
	lu.assertEquals(count, spec.shown)
	-- no Auctionator: no dialogs of its to place
	module:PlaceAuctionatorDialogs()
	lu.assertNil(_G.Atr_Mask)
	assertClean(client)
end

function TestAuctionHouse:test_auctionators_page_on_the_grid()
	open(true)
	page(5)
	-- its two columns on slate across the content, as the auctions' (made as it
	-- first shows: placed then, windows/AuctionFrame.qml)
	local column, rest = unpack(zones(_G.Atr_Main_Panel))
	local spot = client.Engine:GetDB("Positions").Atr_Main_PanelDiabolicLeft
	local left, top, right, bottom = edges(column)
	lu.assertEquals({ left, top, right - left, bottom - top }, { spot[4], -spot[5], spot[6], spot[7] })
	local restLeft, restTop, _, restBottom = edges(rest)
	lu.assertEquals({ restTop, restBottom }, { top, bottom })
	lu.assertTrue(restLeft > right)
	-- its own black and its headings' bar gone
	lu.assertNil(_G.Atr_Hlist:GetBackdrop())
	lu.assertEquals(_G.Atr_HeadingsBarMiddle:GetAlpha(), 0)
	-- its band's buttons as tall as its Search, its "+" square
	local height = _G.Atr_Search_Button:GetHeight()
	for _, name in ipairs({ "Atr_Adv_Search_Button", "Atr_FullScanButton", "Auctionator1Button" }) do
		lu.assertEquals(_G[name]:GetHeight(), height, name)
	end
	lu.assertEquals(_G.Atr_Adv_Search_Button:GetWidth(), height)
	-- moved once, however often it shows
	local x = select(4, _G.Atr_Hlist:GetPoint())
	_G.AuctionFrame:Hide()
	_G.AuctionFrame:Show()
	lu.assertEquals(select(4, _G.Atr_Hlist:GetPoint()), x)
	assertClean(client)
end

function TestAuctionHouse:test_auctionators_dialogs_over_the_window()
	open(true)
	page(6)
	-- its shade over the window, its dialog in the window's middle, as
	-- they show (Auctionator's places are for Blizzard's window)
	local frame, dialog, mask = _G.AuctionFrame, _G.Atr_CheckActives_Frame, _G.Atr_Mask
	dialog:Show()
	mask:Show()
	local window
	for _, child in ipairs({ frame:GetChildren() }) do
		if child.Frame == frame then
			window = child
		end
	end
	lu.assertEquals({ mask:GetLeft(), mask:GetTop(), mask:GetRight(), mask:GetBottom() },
		{ window:GetLeft(), window:GetTop(), window:GetRight(), window:GetBottom() })
	local x, y = dialog:GetCenter()
	local wx, wy = window:GetCenter()
	lu.assertEquals({ x, y }, { wx, wy })
	-- our popup's backdrop around it, our buttons
	lu.assertNotNil(dialog.backdrop)
	lu.assertNotNil(_G.Atr_CheckActives_Yes_Button:GetBackdrop())
	assertClean(client)
end

function TestAuctionHouse:test_auctionators_band_tabs_and_foot()
	open(true)
	page(4)
	-- its title gone (the tabs say it); its search in the band, its Full
	-- Scan at its right end; its dropdowns ours, its list's tabs too
	lu.assertEquals(_G.AuctionatorTitle:GetAlpha(), 0)
	lu.assertEquals((_G.Atr_FullScanButton:GetPoint()), "RIGHT")
	lu.assertNotNil(_G.Atr_Search_Box.DiabolicOutset)
	lu.assertNotNil(_G.Atr_Duration.DiabolicPlate)
	lu.assertNotNil(_G.Atr_ListTabsTab1.DiabolicArt)
	-- its foot's buttons in the foot, as it shows and again
	lu.assertEquals(select(5, _G.Atr_Buy1_Button:GetPoint()), 7)
	_G.AuctionFrame:Hide()
	_G.AuctionFrame:Show()
	lu.assertEquals(select(5, _G.Atr_Buy1_Button:GetPoint()), 7)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
