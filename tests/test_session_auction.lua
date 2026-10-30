-- Run from the addon root: lua5.1 tests/test_session_auction.lua
--
-- The auction house on its grid (modules/blizzard/auction.lua) in the fake
-- client: each page, Blizzard's and Auctionator's, kept to the layout's
-- rules (/dui layout finds nothing), its parts where the grid puts them,
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

-- The page of tab `i` shown, checked; its problems.
local function page(i)
	_G.AuctionFrameTab_OnClick(_G["AuctionFrameTab" .. i])
	client:Tick(1.2, 0.1)
	local entry = _G.DiabolicUI_Layout.windows.AuctionFrame
	return entry and entry.problems or {}
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

function TestAuctionHouse:test_each_blizzard_page_keeps_the_rules()
	open()
	for i = 1, 3 do
		lu.assertEquals(page(i), {}, "tab " .. i)
	end
	assertClean(client)
end

function TestAuctionHouse:test_each_auctionator_page_keeps_the_rules()
	open(true)
	for i = 1, 6 do
		lu.assertEquals(page(i), {}, "tab " .. i)
	end
	assertClean(client)
end

function TestAuctionHouse:test_browse_on_the_grid()
	open()
	page(1)
	local config = client.Engine:GetDB("Blizzard").auction
	local content = config.content
	-- the toolbar under the band: Reset over the categories, the arrows at
	-- the right end
	local left, top, right, bottom = edges(_G.BrowseResetButton)
	lu.assertEquals({ left, top, right, bottom }, { content.left, content.top, content.left + config.browse.column,
		content.top + config.toolbar })
	lu.assertEquals(select(3, edges(_G.BrowseNextPageButton)), content.right)
	-- the categories and the results side by side under it, tops and
	-- bottoms lined up, apart by the gap; the column names on the results
	local categories, results = unpack(zones(_G.AuctionFrameBrowse))
	local zoneTop = content.top + config.toolbar + config.gap
	lu.assertEquals({ edges(categories) }, { content.left, zoneTop, content.left + config.browse.column, content.bottom })
	lu.assertEquals({ edges(results) }, { content.left + config.browse.column + config.gap, zoneTop, content.right, content.bottom })
	local headerLeft, headerTop = edges(_G.BrowseQualitySort)
	lu.assertEquals(headerTop, zoneTop + config.pad)
	lu.assertTrue(headerLeft > select(1, edges(results)))
	assertClean(client)
end

function TestAuctionHouse:test_bids_and_auctions_rows_in_their_zones_middle()
	open()
	local content = client.Engine:GetDB("Blizzard").auction.content
	-- Bids' rows (their icon too) as far from the zone's sides, the bar
	-- by their end
	page(2)
	local left, _, right = edges(_G.BidButton1)
	lu.assertTrue(math.abs((left - content.left) - (content.right - right)) <= 1)
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
	local config = client.Engine:GetDB("Blizzard").auction
	local content = config.content
	-- its two columns on slate across the content
	local column, rest = unpack(zones(_G.Atr_Main_Panel))
	local split = content.left + config.auctionator.column
	lu.assertEquals({ edges(column) }, { content.left, content.top, split, content.bottom })
	lu.assertEquals({ edges(rest) }, { split + config.gap, content.top, content.right, content.bottom })
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
	-- its foot's buttons lower (26), once
	lu.assertEquals(select(5, _G.AuctionatorCloseButton:GetPoint()), 14 - 26)
	_G.AuctionFrame:Hide()
	_G.AuctionFrame:Show()
	lu.assertEquals(select(5, _G.AuctionatorCloseButton:GetPoint()), 14 - 26)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
