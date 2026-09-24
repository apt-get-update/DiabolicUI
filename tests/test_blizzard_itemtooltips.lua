-- Run from the addon root: lua5.1 tests/test_blizzard_itemtooltips.lua
--
-- Loads the *real* modules/blizzard/itemtooltips.lua (Diablo III style item
-- tooltips) and exercises the parts that don't need the game's layout
-- engine:
--  - ToPattern: Blizzard's format strings turned into Lua patterns, for the
--    English and French clients
--  - OnTooltipSetItem: reads the item (name, icon, quality color, sell
--    price), frees the DPS or armor line for the big number, moves the
--    durability line to the footer, finds the name under "Currently
--    Equipped" on comparison tooltips, and leaves uncached items alone
--  - SpaceComparisons: side by side comparison tooltips pushed apart, on
--    whichever side Blizzard put them
--  - OnTooltipAddMoney: Blizzard's "Sell Price:" line goes to the footer on
--    styled item tooltips (whether the price arrives before or after the
--    item is known), and is added as usual everywhere else
-- The on-screen layout itself (Layout) needs real frame geometry and is
-- checked in game.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local ENGLISH = {
	DPS_TEMPLATE = "(%.1f damage per second)",
	ARMOR_TEMPLATE = "%d Armor",
	DURABILITY_TEMPLATE = "Durability %d / %d",
}

local FRENCH = {
	DPS_TEMPLATE = "(%.1f dégâts par seconde)",
	ARMOR_TEMPLATE = "Armure : %d",
	DURABILITY_TEMPLATE = "Durabilité %d / %d",
}

local items -- link -> GetItemInfo returns

local function loadModule(strings)
	for key, value in pairs(strings) do
		_G[key] = value
	end
	_G.CURRENTLY_EQUIPPED = "Currently Equipped"
	_G.ITEM_SOULBOUND = "Soulbound"
	_G.ITEM_BIND_ON_PICKUP = "Binds when picked up"
	_G.ITEM_BIND_ON_EQUIP = "Binds when equipped"
	_G.ITEM_BIND_ON_USE = "Binds when used"
	_G.ITEM_BIND_TO_ACCOUNT = "Binds to account"
	_G.ITEM_ACCOUNTBOUND = "Account Bound"
	_G.ITEM_UNIQUE = "Unique"
	_G.ITEM_UNIQUE_EQUIPPABLE = "Unique-Equipped"
	_G.ITEM_CLASSES_ALLOWED = "Classes: %s"
	_G.ITEM_UNIQUE_MULTIPLE = "Unique (%d)"
	_G.ITEM_LIMIT_CATEGORY = "Unique: %s (%d)"
	_G.ITEM_LIMIT_CATEGORY_MULTIPLE = "Unique-Equipped: %s (%d)"
	_G.ITEM_BIND_QUEST = "Quest Item"
	_G.ITEM_MIN_LEVEL = "Requires Level %d"
	_G.ITEM_LEVEL_RANGE = "Requires level %d to %d"
	_G.ITEM_LEVEL_RANGE_CURRENT = "Requires level %d to %d (%d)"
	_G.ITEM_MIN_SKILL = "Requires %s (%d)"
	_G.ITEM_REQ_SKILL = "Requires %s"
	_G.ITEM_REQ_REPUTATION = "Requires %s - %s"
	_G.ITEM_REQ_ARENA_RATING = "Requires personal and team arena rating of %d"
	_G.ITEM_MOD_DAMAGE_PER_SECOND_SHORT = "Damage Per Second"
	_G.ARMOR = "Armor"
	_G.GetItemInfo = function(link)
		local item = items[link]
		if item then
			return item.name, link, item.quality, 200, 80, "Weapon", "Swords", 1, "INVTYPE_WEAPON", item.icon, item.sellPrice
		end
	end
	_G.GetItemQualityColor = function(quality)
		return quality / 10, .5, 1
	end
	_G.hooksecurefunc = function() end

	local Engine = EngineMock.new()
	Engine:NewStaticConfig("Library: Format", { Money = function(money) return money .. "c" end })
	assert(loadfile("modules/blizzard/itemtooltips.lua"))("DiabolicUI", Engine)
	local Module = Engine:GetModule("Blizzard: ItemTooltips")
	Module.db = { reskinTooltip = true } -- the "Reskin Tooltip" option
	return Module
end

-- A fake tooltip named "TestTooltip" whose lines are real globals, like
-- Blizzard's TestTooltipTextLeft1..N.
-- Lines are "text" or { "text", r, g, b }; plain text is Blizzard's white.
local function newTooltip(link, lines, tooltipName)
	local tooltip = { shows = 0 }
	function tooltip:GetName() return tooltipName or "TestTooltip" end
	function tooltip:GetItem() return link and "Item", link end
	function tooltip:NumLines() return #lines end
	function tooltip:Show() self.shows = self.shows + 1 end
	for i, line in ipairs(lines) do
		local text, r, g, b = line, 1, 1, 1
		if type(line) == "table" then
			text, r, g, b = line[1], line[2], line[3], line[4]
		end
		_G["TestTooltipTextLeft" .. i] = {
			text = text,
			color = { r, g, b },
			GetText = function(self) return self.text end,
			SetText = function(self, value) self.text = value end,
			GetTextColor = function(self) return unpack(self.color) end,
			SetTextColor = function(self, r, g, b) self.color = { r, g, b } end,
			SetAlpha = function() end,
			ClearAllPoints = function() end,
			SetPoint = function() end,
		}
	end
	return tooltip
end

local function lineText(i)
	return _G["TestTooltipTextLeft" .. i].text
end

TestItemTooltipPatterns = {}

function TestItemTooltipPatterns:test_english()
	local Module = loadModule(ENGLISH)
	lu.assertEquals(string.match("(50.5 damage per second)", Module.ToPattern(ENGLISH.DPS_TEMPLATE)), "50.5")
	lu.assertEquals(string.match("1234 Armor", Module.ToPattern(ENGLISH.ARMOR_TEMPLATE)), "1234")
	lu.assertEquals({ string.match("Durability 31 / 50", Module.ToPattern(ENGLISH.DURABILITY_TEMPLATE)) }, { "31", "50" })
	-- whole-line matches only
	lu.assertNil(string.match("Equip: +10 Armor", Module.ToPattern(ENGLISH.ARMOR_TEMPLATE)))
end

function TestItemTooltipPatterns:test_text_placeholders()
	local Module = loadModule(ENGLISH)
	lu.assertEquals(string.match("Classes: Priest, Mage", Module.ToPattern("Classes: %s")), "Priest, Mage")
	lu.assertEquals({ string.match("Unique-Equipped: Jewelcrafter's Gems (3)", Module.ToPattern("Unique-Equipped: %s (%d)")) }, { "Jewelcrafter's Gems", "3" })
end

function TestItemTooltipPatterns:test_french()
	local Module = loadModule(FRENCH)
	lu.assertEquals(string.match("(50,5 dégâts par seconde)", Module.ToPattern(FRENCH.DPS_TEMPLATE)), "50,5")
	lu.assertEquals(string.match("Armure : 1234", Module.ToPattern(FRENCH.ARMOR_TEMPLATE)), "1234")
	lu.assertEquals({ string.match("Durabilité 31 / 50", Module.ToPattern(FRENCH.DURABILITY_TEMPLATE)) }, { "31", "50" })
end

TestItemTooltipSetItem = {}

function TestItemTooltipSetItem:setUp()
	self.Module = loadModule(ENGLISH)
	items = {
		["item:1"] = { name = "Gladiator's Sword", quality = 4, icon = "icon-sword", sellPrice = 12345 },
		["item:2"] = { name = "Chestguard", quality = 3, icon = "icon-chest", sellPrice = 0 },
	}
end

function TestItemTooltipSetItem:test_weapon()
	local tooltip = newTooltip("item:1", {
		"Gladiator's Sword", "Binds when picked up", "One-Hand      Sword",
		"145 - 218 Damage      Speed 2.60", "(50.5 damage per second)",
		"+35 Strength", "Durability 31 / 50", "Requires Level 80",
	})
	self.Module:OnTooltipSetItem(tooltip)
	local info = tooltip.DiabolicItemInfo

	lu.assertEquals(info.name, "Gladiator's Sword")
	lu.assertEquals(info.icon, "icon-sword")
	lu.assertEquals(info.sellPrice, 12345)
	lu.assertEquals({ info.r, info.g, info.b }, { .4, .5, 1 })
	lu.assertEquals(info.titleIndex, 1)

	lu.assertEquals(info.bigLine, 5)
	lu.assertEquals(info.bigNumber, "50.5")
	lu.assertEquals(info.bigLabel, "Damage Per Second")
	lu.assertEquals(lineText(5), " ") -- emptied for the big number

	lu.assertEquals(info.durability, "Durability 31 / 50")
	lu.assertEquals(lineText(7), "")
	lu.assertEquals(lineText(6), "+35 Strength")
	lu.assertEquals(tooltip.shows, 1) -- re-measured, which runs the layout
end

function TestItemTooltipSetItem:test_binding_class_and_unique_lines_are_highlighted()
	local tooltip = newTooltip("item:2", {
		"Chestguard", "Soulbound", "Unique-Equipped", "Classes: Priest",
		"Unique-Equipped: Jewelcrafter's Gems (3)", "+20 Stamina",
	})
	self.Module:OnTooltipSetItem(tooltip)
	local gold = { .85, .75, .55 }
	for i = 2, 5 do
		lu.assertEquals(_G["TestTooltipTextLeft" .. i].color, gold, lineText(i))
	end
	lu.assertEquals(_G["TestTooltipTextLeft6"].color, { 1, 1, 1 })
end

function TestItemTooltipSetItem:test_combined_lines_are_highlighted_part_by_part()
	-- ChromieTransmog puts its label and Blizzard's "Soulbound" in one line
	local tooltip = newTooltip("item:2", { "Mantle", "|cffff80ffTransmogrified|r\n|cffffffffSoulbound", "Shoulder" })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(lineText(2), "|cffff80ffTransmogrified|r\n|cffd8bf8cSoulbound|r")

	-- and a combined line without a match is left alone
	tooltip = newTooltip("item:2", { "Mantle", "|cffff80ffTransmogrified|r\n|cffffffffShoulder" })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(lineText(2), "|cffff80ffTransmogrified|r\n|cffffffffShoulder")
end

function TestItemTooltipSetItem:test_quest_item_and_requirements_are_highlighted()
	local tooltip = newTooltip("item:2", {
		"Chestguard", "Quest Item", "Requires Level 80", "Requires Tailoring (400)",
		"Requires Kirin Tor - Exalted", "Requires personal and team arena rating of 1800",
		"Equip: Improves critical strike rating by 20.",
	})
	self.Module:OnTooltipSetItem(tooltip)
	local gold = { .85, .75, .55 }
	for i = 2, 6 do
		lu.assertEquals(_G["TestTooltipTextLeft" .. i].color, gold, lineText(i))
	end
	lu.assertEquals(_G["TestTooltipTextLeft7"].color, { 1, 1, 1 })

	-- a level you don't have yet: Blizzard's red stays
	tooltip = newTooltip("item:2", { "Chestguard", { "Requires Level 80", 1, .13, .13 } })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(_G["TestTooltipTextLeft2"].color, { 1, .13, .13 })
end

function TestItemTooltipSetItem:test_red_restrictions_stay_red()
	local tooltip = newTooltip("item:2", { "Chestguard", { "Classes: Mage", 1, .13, .13 }, { "Unique-Equipped", 1, .13, .13 } })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(_G["TestTooltipTextLeft2"].color, { 1, .13, .13 })
	lu.assertEquals(_G["TestTooltipTextLeft3"].color, { 1, .13, .13 })
end

function TestItemTooltipSetItem:test_armor()
	local tooltip = newTooltip("item:2", { "Chestguard", "Chest      Plate", "1234 Armor", "+20 Stamina" })
	self.Module:OnTooltipSetItem(tooltip)
	local info = tooltip.DiabolicItemInfo
	lu.assertEquals(info.bigNumber, "1234")
	lu.assertEquals(info.bigLabel, "Armor")
	lu.assertNil(info.durability)
end

function TestItemTooltipSetItem:test_comparison_tooltip_title_is_second_line()
	local tooltip = newTooltip("item:2", { "Currently Equipped", "Chestguard", "1234 Armor" })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(tooltip.DiabolicItemInfo.titleIndex, 2)
	lu.assertEquals(tooltip.DiabolicItemInfo.bigLine, 3)
end

function TestItemTooltipSetItem:test_uncached_item_is_left_alone()
	local tooltip = newTooltip("item:999", { "Retrieving item information", "(50.5 damage per second)" })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertNil(tooltip.DiabolicItemInfo)
	lu.assertEquals(lineText(2), "(50.5 damage per second)")
	lu.assertEquals(tooltip.shows, 0)
end

function TestItemTooltipSetItem:test_not_an_item()
	local tooltip = newTooltip(nil, { "Fireball" })
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertNil(tooltip.DiabolicItemInfo)
end

TestItemTooltipMoney = {}

function TestItemTooltipMoney:setUp()
	self.Module = loadModule(ENGLISH)
	self.added = {}
	self.Module.AddMoney = function(tooltip, cost, maxcost)
		table.insert(self.added, { cost, maxcost })
	end
	items = { ["item:1"] = { name = "Sword", quality = 4, icon = "icon", sellPrice = 100 } }
end

-- "GameTooltip" is one of the styled tooltips; the lines stay TestTooltip's.
function TestItemTooltipMoney:tooltip(link)
	local tooltip = newTooltip(link, { "Sword", "One-Hand" }, "GameTooltip")
	_G.GameTooltipTextLeft1, _G.GameTooltipTextLeft2 = _G.TestTooltipTextLeft1, _G.TestTooltipTextLeft2
	return tooltip
end

function TestItemTooltipMoney:test_price_before_the_item_goes_to_the_footer()
	local tooltip = self:tooltip("item:1")
	self.Module:OnTooltipAddMoney(tooltip, 2000) -- a stack of 20
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(self.added, {})
	lu.assertEquals(tooltip.DiabolicSellPrice, 2000)
	lu.assertEquals(tooltip.DiabolicItemState, "styled")
end

function TestItemTooltipMoney:test_price_after_the_item_goes_to_the_footer()
	local tooltip = self:tooltip("item:1")
	self.Module:OnTooltipSetItem(tooltip)
	local shows = tooltip.shows
	self.Module:OnTooltipAddMoney(tooltip, 2000)
	lu.assertEquals(self.added, {})
	lu.assertEquals(tooltip.DiabolicSellPrice, 2000)
	lu.assertEquals(tooltip.shows, shows + 1) -- laid out again with the price
end

function TestItemTooltipMoney:test_uncached_item_gets_blizzards_line_back()
	local tooltip = self:tooltip("item:999")
	self.Module:OnTooltipAddMoney(tooltip, 500)
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertEquals(self.added, { { 500 } })
	lu.assertNil(tooltip.DiabolicSellPrice)

	-- and later prices on that tooltip go straight through
	self.Module:OnTooltipAddMoney(tooltip, 600)
	lu.assertEquals(self.added, { { 500 }, { 600 } })
end

function TestItemTooltipMoney:test_option_off_keeps_blizzards_tooltip()
	self.Module.db.reskinTooltip = false
	local tooltip = self:tooltip("item:1")
	self.Module:OnTooltipAddMoney(tooltip, 2000)
	self.Module:OnTooltipSetItem(tooltip)
	lu.assertNil(tooltip.DiabolicItemInfo)
	lu.assertEquals(tooltip.DiabolicItemState, "plain")
	lu.assertEquals(self.added, { { 2000 } }) -- Blizzard's sell price line
end

function TestItemTooltipMoney:test_price_ranges_and_other_tooltips_are_untouched()
	local tooltip = self:tooltip("item:1")
	self.Module:OnTooltipAddMoney(tooltip, 100, 200) -- a min/max range
	lu.assertEquals(self.added, { { 100, 200 } })

	local other = newTooltip("item:1", { "Sword" }, "SomeAddonTooltip")
	self.Module:OnTooltipAddMoney(other, 300)
	lu.assertEquals(self.added, { { 100, 200 }, { 300 } })
end

TestItemTooltipCompare = {}

local function newCompareTooltip(point, shown)
	return {
		point = { point, "Anchor", point == "TOPLEFT" and "TOPRIGHT" or "TOPLEFT", 0, -10 },
		IsShown = function() return shown end,
		GetPoint = function(self) return unpack(self.point) end,
		SetPoint = function(self, ...) self.point = { ... } end,
	}
end

function TestItemTooltipCompare:test_pushes_comparisons_apart()
	local Module = loadModule(ENGLISH)
	Module.compareGap = 24
	local right = newCompareTooltip("TOPLEFT", true)
	local left = newCompareTooltip("TOPRIGHT", true)
	local hidden = newCompareTooltip("TOPLEFT", false)
	Module:SpaceComparisons({ shoppingTooltips = { right, left, hidden } })
	lu.assertEquals(right.point, { "TOPLEFT", "Anchor", "TOPRIGHT", 24, -10 })
	lu.assertEquals(left.point, { "TOPRIGHT", "Anchor", "TOPLEFT", -24, -10 })
	lu.assertEquals(hidden.point[4], 0)
end

os.exit(lu.LuaUnit.run())
