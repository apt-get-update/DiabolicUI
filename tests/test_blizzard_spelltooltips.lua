-- Run from the addon root: lua5.1 tests/test_blizzard_spelltooltips.lua
--
-- Loads the *real* modules/blizzard/spelltooltips.lua (Diablo III style
-- ability tooltips) and exercises the parts that don't need the game's
-- layout engine:
--  - Style: reads the spell's name, rank and icon, colors the numbers of the
--    stat lines (not the description, not red "Requires" lines), finds the
--    description, and leaves non-abilities and the option turned off alone
--  - the icon of each filling method (action, spellbook, talent, link)
--  - Guard: a step that errors is reported once, the numbers go back to
--    Blizzard's, and the ability stays plain for the rest of the session
-- The on-screen layout itself (Layout) needs real frame geometry and is
-- checked in game.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local GREEN = "|cff3fc83f"
local GOLD = { 1, .82, 0 }
local RED = { 1, .125, .125 }

local errors -- what reached the error handler

local function loadModule()
	_G.GetActionTexture = function(slot) return "icon-action-" .. slot end
	_G.GetSpellTexture = function(id, book) return "icon-book-" .. id .. "-" .. book end
	_G.GetTalentInfo = function(tab, index) return "Talent", "icon-talent-" .. tab .. "-" .. index end
	_G.GetShapeshiftFormInfo = function(index) return "icon-form-" .. index end
	_G.GetSpellInfo = function(id) return "Spell", nil, "icon-spell-" .. id end
	errors = {}
	_G.geterrorhandler = function()
		return function(err) errors[#errors + 1] = err end
	end

	local Engine = EngineMock.new()
	-- the look shared by itemtooltips.lua: only Layout (checked in game) draws with it
	Engine:NewModule("Blizzard: ItemTooltips").Shared = {
		IsDefaultColor = function(line)
			local r, g, b = line:GetTextColor()
			return (r > .99) and (g > .99) and (b > .99)
		end
	}
	assert(loadfile("modules/blizzard/spelltooltips.lua"))("DiabolicUI", Engine)
	local Module = Engine:GetModule("Blizzard: SpellTooltips")
	Module.db = { reskinTooltip = true } -- the "Reskin Tooltip" option
	Module.failed = {} -- set up by OnEnable
	return Module
end

local function newLine(text, color)
	return {
		text = text,
		color = color or { 1, 1, 1 },
		shown = text ~= nil,
		GetText = function(self) return self.text end,
		SetText = function(self, value) self.text = value end,
		IsShown = function(self) return self.shown end,
		GetTextColor = function(self) return unpack(self.color) end,
		SetAlpha = function() end,
		ClearAllPoints = function() end,
		SetPoint = function() end,
	}
end

-- A fake tooltip named "TestTooltip" whose lines are real globals.
-- Lines are { left, right, leftColor }; colors default to Blizzard's white.
local function newTooltip(lines, item, spell)
	local tooltip = { shows = 0 }
	function tooltip:GetName() return "TestTooltip" end
	function tooltip:GetItem() return item and "Item", item end
	function tooltip:GetSpell() return spell end
	function tooltip:NumLines() return #lines end
	function tooltip:Show() self.shows = self.shows + 1 end
	for i, line in ipairs(lines) do
		_G["TestTooltipTextLeft" .. i] = newLine(line[1], line[3])
		_G["TestTooltipTextRight" .. i] = newLine(line[2])
	end
	return tooltip
end

local function left(i) return _G["TestTooltipTextLeft" .. i].text end
local function right(i) return _G["TestTooltipTextRight" .. i].text end

-- Blizzard's 3.3.5 Frostbolt tooltip
local FROSTBOLT = {
	{ "Frostbolt", "Rank 16" },
	{ "11% of base mana", "30 yd range" },
	{ "3 sec cast" },
	{ "Requires Frost Form", nil, RED },
	{ "Launches a bolt of frost at the enemy, causing 803 to 866 Frost damage.", nil, GOLD },
}

TestSpellTooltipStyle = {}

function TestSpellTooltipStyle:setUp()
	self.Module = loadModule()
end

function TestSpellTooltipStyle:test_reads_the_spell()
	local tooltip = newTooltip(FROSTBOLT)
	self.Module:Style(tooltip, "icon-frostbolt")
	local info = tooltip.DiabolicSpellInfo
	lu.assertEquals(info.name, "Frostbolt")
	lu.assertEquals(info.rank, "Rank 16")
	lu.assertEquals(info.icon, "icon-frostbolt")
	lu.assertEquals(info.descLine, 5)
	lu.assertEquals(tooltip.shows, 1) -- laid out by the Show hook
end

function TestSpellTooltipStyle:test_numbers_of_stat_lines_turn_green()
	local tooltip = newTooltip(FROSTBOLT)
	self.Module:Style(tooltip, "icon")
	lu.assertEquals(left(2), GREEN .. "11|r% of base mana")
	lu.assertEquals(right(2), GREEN .. "30|r yd range")
	lu.assertEquals(left(3), GREEN .. "3|r sec cast")
	-- the red requirement and the description keep Blizzard's text
	lu.assertEquals(left(4), "Requires Frost Form")
	lu.assertEquals(left(5), FROSTBOLT[5][1])
	-- the title too
	lu.assertEquals(left(1), "Frostbolt")
end

function TestSpellTooltipStyle:test_decimals_stay_one_number()
	local tooltip = newTooltip({ { "Fireball" }, { "1.5 sec cast", "8 sec cooldown" } })
	self.Module:Style(tooltip, "icon")
	lu.assertEquals(left(2), GREEN .. "1.5|r sec cast")
	lu.assertEquals(right(2), GREEN .. "8|r sec cooldown")
	lu.assertNil(tooltip.DiabolicSpellInfo.descLine) -- no description
	lu.assertNil(tooltip.DiabolicSpellInfo.rank)
end

function TestSpellTooltipStyle:test_description_right_under_the_title_gets_no_gap()
	local tooltip = newTooltip({ { "Passive" }, { "Increases your 5 things.", nil, GOLD } })
	self.Module:Style(tooltip, "icon")
	lu.assertNil(tooltip.DiabolicSpellInfo.descLine)
	lu.assertEquals(left(2), "Increases your 5 things.")
end

function TestSpellTooltipStyle:test_not_an_ability_is_left_alone()
	local tooltip = newTooltip(FROSTBOLT)
	self.Module:Style(tooltip, nil)
	lu.assertNil(tooltip.DiabolicSpellInfo)
	lu.assertEquals(left(2), "11% of base mana")
	lu.assertEquals(tooltip.shows, 0)
end

function TestSpellTooltipStyle:test_option_off_is_left_alone()
	self.Module.db.reskinTooltip = false
	local tooltip = newTooltip(FROSTBOLT)
	self.Module:Style(tooltip, "icon")
	lu.assertNil(tooltip.DiabolicSpellInfo)
	lu.assertEquals(left(2), "11% of base mana")
end

TestSpellTooltipIcons = {}

function TestSpellTooltipIcons:setUp()
	self.ICONS = loadModule().ICONS
end

function TestSpellTooltipIcons:test_each_method()
	local spell = newTooltip(FROSTBOLT, nil, "Frostbolt")
	lu.assertEquals(self.ICONS.SetAction(spell, 7), "icon-action-7")
	lu.assertEquals(self.ICONS.SetSpell(spell, 12, "spell"), "icon-book-12-spell")
	lu.assertEquals(self.ICONS.SetTalent(spell, 2, 5), "icon-talent-2-5")
	lu.assertEquals(self.ICONS.SetShapeshift(spell, 3), "icon-form-3")
	lu.assertEquals(self.ICONS.SetHyperlink(spell, "|cff71d5ff|Hspell:116|h[Frostbolt]|h|r"), "icon-spell-116")
end

function TestSpellTooltipIcons:test_items_are_not_abilities()
	-- an item on an action bar, an item link: the item tooltips have them
	lu.assertNil(self.ICONS.SetAction(newTooltip(FROSTBOLT, "item:1", nil), 7))
	lu.assertNil(self.ICONS.SetAction(newTooltip(FROSTBOLT, nil, nil), 7)) -- an empty macro
	lu.assertNil(self.ICONS.SetHyperlink(newTooltip(FROSTBOLT), "|Hitem:1|h[Sword]|h"))
end

TestSpellTooltipGuard = {}

function TestSpellTooltipGuard:setUp()
	self.Module = loadModule()
end

function TestSpellTooltipGuard:test_failing_step_puts_back_blizzards_tooltip()
	local tooltip = newTooltip(FROSTBOLT)
	self.Module:Guard(tooltip, function(tooltip)
		self.Module:Style(tooltip, "icon")
		error("layout broke")
	end)
	lu.assertEquals(#errors, 1)
	lu.assertEquals(left(2), "11% of base mana")
	lu.assertEquals(right(2), "30 yd range")
	lu.assertNil(tooltip.DiabolicSpellInfo)

	-- and stays plain from then on
	self.Module:Style(newTooltip(FROSTBOLT), "icon")
	lu.assertEquals(left(2), "11% of base mana")
end

function TestSpellTooltipGuard:test_passes_every_argument()
	-- SetTalent(tab, index, inspect, pet, talentGroup): nils in the middle
	local got
	self.Module:Guard(newTooltip(FROSTBOLT), function(tooltip, a, b, c, d)
		got = { a, b, c, d }
	end, 1, nil, nil, 4)
	lu.assertEquals(got, { 1, nil, nil, 4 })
	lu.assertEquals(#errors, 0)
end

os.exit(lu.LuaUnit.run())
