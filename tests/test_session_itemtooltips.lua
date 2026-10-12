-- Run from the addon root: lua5.1 tests/test_session_itemtooltips.lua
--
-- modules/blizzard/itemtooltips.lua in the fake client, whose tooltips
-- anchor their lines and size themselves on Show() like Blizzard's: the
-- Diablo III layout itself (the part tests/test_blizzard_itemtooltips.lua
-- leaves to the game): title banner in the quality color, icon box, body
-- moved beside it, the DPS or armor as a big number with room made for it,
-- the footer with the sell price and durability, the "Equipped" tag on
-- comparison tooltips, and the layout coming back when Blizzard redoes its
-- own.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client

local SHIFT = 56 + 10 -- ICON_BOX + ICON_GAP

local WEAPON = {
	name = "Shadowmourne", quality = 5, vendorPrice = 123456, texture = "Interface\\Icons\\Axe",
	lines = {
		{ "Shadowmourne", nil, { 1, 0.5, 0 } },
		"Binds when picked up",
		{ "Two-Hand", "Axe" },
		{ "954 - 1431 Damage", "Speed 3.70" },
		"(322.3 damage per second)",
		{ "+198 Strength", nil, { 0, 1, 0 } },
		"Durability 118 / 145",
		"Requires Level 80",
		{ "Classes: Paladin", nil, { 1, 0.1, 0.1 } }, -- red: not our class
	},
}

local ARMOR = {
	name = "Plain Vest", quality = 1,
	lines = { "Plain Vest", { "Chest", "Cloth" }, "35 Armor" },
}

local function parts(tooltip)
	return tooltip.DiabolicItemParts
end

local function show(tooltip, id, item)
	local link = Session.item(client, id, item)
	tooltip:SetOwner(_G.UIParent, "ANCHOR_NONE")
	tooltip:SetPoint("BOTTOMRIGHT", _G.UIParent, "BOTTOMRIGHT", -100, 100)
	tooltip:SetHyperlink(link)
	return link
end

local function line(tooltip, i)
	return _G[tooltip:GetName() .. "TextLeft" .. i]
end

TestItemTooltipLayout = {}

function TestItemTooltipLayout:setUp()
	client = Client.boot({ class = "WARRIOR" })
end

function TestItemTooltipLayout:tearDown()
	client = nil
end

function TestItemTooltipLayout:test_a_weapon_in_the_diablo_style()
	local tooltip = _G.GameTooltip
	show(tooltip, 49623, WEAPON)
	local p = parts(tooltip)
	lu.assertNotNil(p)

	-- the name moves to the banner, in its quality color
	lu.assertEquals(line(tooltip, 1):GetAlpha(), 0)
	lu.assertEquals(p.title:GetText(), "Shadowmourne")
	lu.assertEquals(p.header:IsShown(), 1)
	local r, g, b = p.title:GetTextColor()
	lu.assertEquals({ r, g, b }, { 1, 0.5, 0 })

	-- the body sits right of the icon box
	local _, relativeTo, _, x = line(tooltip, 2):GetPoint()
	lu.assertEquals(relativeTo, line(tooltip, 1))
	lu.assertEquals(x, SHIFT)
	lu.assertEquals(p.icon:GetTexture(), "Interface\\Icons\\Axe")
	lu.assertEquals(p.iconQuality:IsShown(), 1, "legendary: colored border")

	-- the DPS line becomes the big number, the next line moves down
	lu.assertEquals(p.bigNumber:GetText(), "322.3")
	lu.assertEquals(p.bigLabel:GetText(), _G.ITEM_MOD_DAMAGE_PER_SECOND_SHORT)
	lu.assertEquals(line(tooltip, 5):GetText(), " ")
	local _, _, _, _, gapY = line(tooltip, 6):GetPoint()
	lu.assertTrue(gapY < -40, "room for the big number")

	-- durability and price go to the footer; no "Sell Price" line
	lu.assertEquals(p.durability:GetText(), "Durability 118 / 145")
	lu.assertStrContains(p.sellValue:GetText(), _G.SELL_PRICE)
	for i = 1, tooltip:NumLines() do
		lu.assertNotStrContains(line(tooltip, i):GetText() or "", _G.SELL_PRICE)
	end

	-- the binding and requirement lines turn gold, the red one stays red
	lu.assertAlmostEquals(line(tooltip, 2):GetTextColor(), 0.85, 0.001)
	lu.assertAlmostEquals(line(tooltip, 8):GetTextColor(), 0.85, 0.001)
	lu.assertEquals(line(tooltip, 9):GetTextColor(), 1)
	lu.assertEquals(select(2, line(tooltip, 9):GetTextColor()), 0.1)

	-- wider by the icon, taller for the banner, big number and footer
	lu.assertTrue(tooltip:GetWidth() >= SHIFT)
	lu.assertTrue(tooltip:GetHeight() > 200)
	assertClean(client)
end

function TestItemTooltipLayout:test_plain_armor_without_price_or_durability()
	local tooltip = _G.GameTooltip
	show(tooltip, 2000, ARMOR)
	local p = parts(tooltip)
	lu.assertEquals(p.bigNumber:GetText(), "35")
	lu.assertEquals(p.bigLabel:GetText(), _G.ARMOR)
	lu.assertNil(p.iconQuality:IsShown(), "common: no colored border")
	lu.assertNil(p.sellValue:IsShown(), "nothing for the footer")
	lu.assertNil(p.footerBox.bg:IsShown())
	lu.assertNil(p.tagHeader:IsShown())
	assertClean(client)
end

function TestItemTooltipLayout:test_the_big_number_on_the_last_line()
	local tooltip = _G.GameTooltip
	show(tooltip, 2001, { name = "Buckler", quality = 2, lines = { "Buckler", "120 Armor" } })
	lu.assertEquals(parts(tooltip).bigNumber:GetText(), "120")
	assertClean(client)
end

function TestItemTooltipLayout:test_comparison_tooltips_get_the_equipped_tag()
	local tooltip = _G.ShoppingTooltip1
	local item = { name = "Old Axe", quality = 3, vendorPrice = 100, lines = { _G.CURRENTLY_EQUIPPED, "Old Axe", "(80.0 damage per second)" } }
	show(tooltip, 3000, item)
	local p = parts(tooltip)
	lu.assertEquals(p.title:GetText(), "Old Axe")
	lu.assertEquals(p.tagHeader:IsShown(), 1)
	lu.assertEquals(line(tooltip, 1):GetAlpha(), 0)

	-- Blizzard puts it beside the game tooltip; the backdrops need room
	show(_G.GameTooltip, 49623, WEAPON)
	tooltip:ClearAllPoints()
	tooltip:SetPoint("TOPLEFT", _G.GameTooltip, "TOPRIGHT", 0, -10)
	tooltip:Show()
	_G.GameTooltip_ShowCompareItem(_G.GameTooltip)
	local _, _, _, x = tooltip:GetPoint()
	lu.assertTrue(x > 0)
	assertClean(client)
end

function TestItemTooltipLayout:test_the_layout_comes_back_after_blizzard_redoes_its_own()
	local tooltip = _G.GameTooltip
	show(tooltip, 49623, WEAPON)
	local width = tooltip:GetWidth()

	-- the item refresh puts the lines back in their default place
	line(tooltip, 2):ClearAllPoints()
	line(tooltip, 2):SetPoint("TOPLEFT", line(tooltip, 1), "BOTTOMLEFT", 0, -2)
	client:Tick(0.05)
	local _, _, _, x = line(tooltip, 2):GetPoint()
	lu.assertEquals(x, SHIFT)

	-- and the gap under the big number
	line(tooltip, 6):ClearAllPoints()
	line(tooltip, 6):SetPoint("TOPLEFT", line(tooltip, 5), "BOTTOMLEFT", 0, -2)
	client:Tick(0.05)
	local _, _, _, _, y = line(tooltip, 6):GetPoint()
	lu.assertTrue(y < -40)

	-- another addon adds a line: Blizzard re-measures, the layout follows
	tooltip:AddLine("Questie")
	lu.assertTrue(tooltip:GetWidth() < width, "measured again, without our room")
	client:Tick(0.05)
	lu.assertTrue(tooltip:GetWidth() >= SHIFT)
	lu.assertEquals(tooltip.DiabolicItemInfo.width, tooltip:GetWidth())
	assertClean(client)
end

-- ChromieCraft's client patch: two more texts under the name, with the
-- line after the name moved under them (and put back there every 0.2
-- seconds by the tooltip's OnUpdate).
function TestItemTooltipLayout:test_the_client_patch_transmog_texts_go_beside_the_icon()
	local tooltip = _G.GameTooltip
	local first = tooltip:CreateFontString(nil, "ARTWORK")
	first:SetPoint("TOPLEFT", line(tooltip, 1), "BOTTOMLEFT", 0, -2)
	local second = tooltip:CreateFontString(nil, "ARTWORK")
	second:SetPoint("TOPLEFT", first, "BOTTOMLEFT", 0, -2)
	first:Hide()
	second:Hide()
	tooltip.TransmogText1, tooltip.TransmogText2 = first, second

	-- not transmogrified: as always
	show(tooltip, 49623, WEAPON)
	local _, relativeTo, _, x = line(tooltip, 2):GetPoint()
	lu.assertEquals({ relativeTo, x }, { line(tooltip, 1), SHIFT })

	-- transmogrified: the texts beside the icon, the next line under them
	tooltip:Hide()
	show(tooltip, 49623, WEAPON)
	first:SetText("Transmogrified to:")
	second:SetText("Sword Breaker's Bulwark")
	first:Show()
	second:Show()
	tooltip:Show()
	_, relativeTo, _, x = first:GetPoint()
	lu.assertEquals({ relativeTo, x }, { line(tooltip, 1), SHIFT })
	_, relativeTo, _, x = line(tooltip, 2):GetPoint()
	lu.assertEquals({ relativeTo, x }, { second, 0 })

	-- the patch putting the line back under them is fine as it is
	line(tooltip, 2):ClearAllPoints()
	line(tooltip, 2):SetPoint("TOPLEFT", second, "BOTTOMLEFT", 0, -2)
	local width = tooltip:GetWidth()
	client:Tick(0.05)
	_, relativeTo = first:GetPoint()
	lu.assertEquals(relativeTo, line(tooltip, 1))
	lu.assertEquals(tooltip:GetWidth(), width)

	-- hidden: back where the patch had them
	tooltip:Hide()
	local _, _, _, x2 = first:GetPoint()
	lu.assertEquals(x2, 0)
	assertClean(client)
end

function TestItemTooltipLayout:test_lines_other_addons_change()
	local tooltip = _G.GameTooltip
	show(tooltip, 49623, WEAPON)
	-- ChromieTransmog: two texts in one line, plain white
	line(tooltip, 2):SetText("Transmogrified\nBinds when picked up")
	line(tooltip, 2):SetTextColor(1, 1, 1)
	-- an emptied line
	line(tooltip, 3):SetText(nil)
	tooltip:Show()
	lu.assertStrContains(line(tooltip, 2):GetText(), "|cff")
	assertClean(client)
end

function TestItemTooltipLayout:test_a_chat_link_laid_out_once_placed()
	local tooltip = _G.ItemRefTooltip
	local link = Session.item(client, 49623, WEAPON)
	tooltip:ClearAllPoints()
	_G.SetItemRef(link:match("|H(item:[^|]+)|h"), link, "LeftButton")
	-- not on screen yet: nothing to measure against
	lu.assertNil(tooltip.DiabolicItemInfo.width)
	-- the chat link replaces its OnUpdate script: the check stays hooked
	tooltip:SetScript("OnUpdate", function() end)
	tooltip:SetPoint("CENTER", _G.UIParent, "CENTER")
	client:Tick(0.05)
	lu.assertNotNil(tooltip.DiabolicItemInfo.width)
	assertClean(client)
end

function TestItemTooltipLayout:test_another_item_without_the_item_event_resets()
	local tooltip = _G.GameTooltip
	show(tooltip, 49623, WEAPON)
	-- the tooltip now shows a different item, without OnTooltipSetItem
	Client.Widgets.state[tooltip].item = Session.item(client, 2, { name = "Other", quality = 1 })
	tooltip:Show()
	lu.assertNil(tooltip.DiabolicItemInfo)
	lu.assertNil(parts(tooltip).header:IsShown())
	assertClean(client)
end

function TestItemTooltipLayout:test_prices_reach_the_footer_whenever_they_arrive()
	local tooltip = _G.GameTooltip
	local late = { name = "Late Price", quality = 2, vendorPrice = 555, moneyFirst = false, lines = { "Late Price", "Durability 1 / 1" } }
	show(tooltip, 4000, late)
	lu.assertStrContains(parts(tooltip).sellValue:GetText(), _G.SELL_PRICE)

	-- a price range (auction house) and a tooltip not in our style: Blizzard's line
	tooltip:SetOwner(_G.UIParent)
	tooltip:SetText("Auction")
	client:RunScript(tooltip, "OnTooltipAddMoney", 10, 20)
	lu.assertStrContains(line(tooltip, 2):GetText(), _G.SELL_PRICE)
	local other = _G.WorldMapTooltip
	other:SetOwner(_G.UIParent)
	other:SetText("Map")
	client:RunScript(other, "OnTooltipAddMoney", 10)
	lu.assertStrContains(_G.WorldMapTooltipTextLeft2:GetText(), _G.SELL_PRICE)
	assertClean(client)
end

function TestItemTooltipLayout:test_uncached_items_and_the_option_off_stay_plain()
	local tooltip = _G.GameTooltip
	tooltip:SetOwner(_G.UIParent, "ANCHOR_NONE")
	tooltip:SetHyperlink("|cffffffff|Hitem:77777:0:0:0:0:0:0:0:80|h[Unknown]|h|r")
	lu.assertNil(tooltip.DiabolicItemInfo)
	lu.assertEquals(tooltip.DiabolicItemState, "plain")

	client.Engine:GetConfig("Tooltips").reskinTooltip = false
	show(tooltip, 49623, WEAPON)
	lu.assertNil(tooltip.DiabolicItemInfo)
	local found
	for i = 1, tooltip:NumLines() do
		if (line(tooltip, i):GetText() or ""):find(_G.SELL_PRICE, 1, true) then
			found = true
		end
	end
	lu.assertTrue(found, "Blizzard's sell price line")
	client.Engine:GetConfig("Tooltips").reskinTooltip = true
	assertClean(client)
end

function TestItemTooltipLayout:test_hiding_puts_everything_back()
	local tooltip = _G.GameTooltip
	show(tooltip, 49623, WEAPON)
	tooltip:Hide()
	lu.assertNil(tooltip.DiabolicItemInfo)
	lu.assertEquals(line(tooltip, 1):GetAlpha(), 1)
	local _, relativeTo, _, x = line(tooltip, 2):GetPoint()
	lu.assertEquals(relativeTo, line(tooltip, 1))
	lu.assertEquals(x, 0)

	-- comparison tooltips too
	local compare = _G.ShoppingTooltip1
	show(compare, 3000, { name = "Old", quality = 2, lines = { _G.CURRENTLY_EQUIPPED, "Old", "10 Armor", "Soulbound" } })
	compare:Hide()
	lu.assertEquals(_G.ShoppingTooltip1TextLeft1:GetAlpha(), 1)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
