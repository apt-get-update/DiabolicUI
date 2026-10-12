-- Run from the addon root: lua5.1 tests/test_unitframes_raid.lua
--
-- Loads the *real* modules/unitframes/units/raid.lua and exercises its
-- debuff filter, which decides which debuffs raid frames show: boss
-- debuffs always, anything else only when the player's class can remove
-- it, following the WotLK 3.3.5 dispel list:
--   PRIEST  Magic, Disease         PALADIN Magic, Poison, Disease
--   DRUID   Curse, Poison          MAGE    Curse
--   SHAMAN  Poison, Disease, plus Curse with the Cleanse Spirit talent
-- (druids and shamans only gained Magic removal in Cataclysm).
-- And its layout: the 40 raid frames are placed by subgroup, under a
-- "Group N" label, whenever the roster changes, but being secure frames
-- they can't move in combat, so a change in combat is laid out when combat
-- ends.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local CLEANSE_SPIRIT_ID = 51886

local state

local function loadRaidDebuffFilter()
	state = { class = "PRIEST", knowsCleanseSpirit = false }

	_G.UnitClass = function() return state.class, state.class end
	_G.GetNumRaidMembers = function() return 0 end
	-- By spell ID it always answers; by name only when the spell is in the
	-- player's spellbook - same as the real client.
	_G.GetSpellInfo = function(spell)
		if spell == CLEANSE_SPIRIT_ID then
			return "Cleanse Spirit"
		elseif spell == "Cleanse Spirit" and state.knowsCleanseSpirit then
			return "Cleanse Spirit"
		end
	end

	local Engine = EngineMock.new()
	local Module = Engine:NewModule("UnitFrames")
	assert(loadfile("modules/unitframes/units/raid.lua"))("DiabolicUI", Engine)
	return Module:GetWidget("Unit: Raid").DebuffFilter
end

-- debuffFilter(self, name, rank, icon, count, debuffType, duration,
--              expirationTime, unitCaster, isStealable, spellId, isBossDebuff)
local function shows(filter, debuffType, isBossDebuff)
	return filter(nil, "Debuff", nil, nil, 1, debuffType, 0, 0, "boss1", nil, 1, isBossDebuff)
end

local DEBUFF_TYPES = { "Magic", "Curse", "Poison", "Disease" }

-- Which debuff types each class sees, as a set.
local EXPECTED = {
	PRIEST = { Magic = true, Disease = true },
	PALADIN = { Magic = true, Poison = true, Disease = true },
	DRUID = { Curse = true, Poison = true },
	MAGE = { Curse = true },
	SHAMAN = { Poison = true, Disease = true },
	WARRIOR = {},
	ROGUE = {},
	HUNTER = {},
	WARLOCK = {},
	DEATHKNIGHT = {},
}

TestRaidDebuffFilter = {}

function TestRaidDebuffFilter:setUp()
	self.filter = loadRaidDebuffFilter()
end

function TestRaidDebuffFilter:test_each_class_sees_what_it_can_dispel()
	for class, expected in pairs(EXPECTED) do
		state.class = class
		for _, debuffType in ipairs(DEBUFF_TYPES) do
			lu.assertEquals(shows(self.filter, debuffType), expected[debuffType] or false,
				class .. " / " .. debuffType)
		end
	end
end

function TestRaidDebuffFilter:test_shaman_curses_need_cleanse_spirit()
	state.class = "SHAMAN"
	lu.assertFalse(shows(self.filter, "Curse"))
	state.knowsCleanseSpirit = true
	lu.assertTrue(shows(self.filter, "Curse"))
	-- a respec away from the talent is picked up again
	state.knowsCleanseSpirit = false
	lu.assertFalse(shows(self.filter, "Curse"))
end

function TestRaidDebuffFilter:test_boss_debuffs_always_show()
	state.class = "WARRIOR"
	lu.assertTrue(shows(self.filter, nil, true))
	lu.assertTrue(shows(self.filter, "Magic", true))
end

function TestRaidDebuffFilter:test_typeless_debuffs_are_hidden()
	state.class = "PALADIN"
	lu.assertFalse(shows(self.filter, nil))
end

TestRaidLayout = {}

local function newFrame()
	local frame = { points = {}, shown = true, events = {} }
	function frame:ClearAllPoints() self.points = {} end
	function frame:SetPoint(...) self.points[#self.points + 1] = { ... } end
	function frame:Show() self.shown = true end
	function frame:Hide() self.shown = false end
	function frame:Place() end
	function frame:RegisterEvent(event) self.events[event] = true end
	function frame:UnregisterEvent(event) self.events[event] = nil end
	function frame:SetScript(script, func) self.onEvent = func end
	function frame:SetFontObject() end
	function frame:SetWidth(width) self.width = width end
	function frame:SetJustifyH(justify) self.justify = justify end
	function frame:SetText(text) self.text = text end
	function frame:CreateFontString() return newFrame() end
	return frame
end

function TestRaidLayout:setUp()
	state = { class = "PRIEST", inCombat = false, roster = { { "Tank", 1 }, { "Healer", 2 } } }
	_G.UnitClass = function() return state.class, state.class end
	_G.GetSpellInfo = function() end
	_G.InCombatLockdown = function() return state.inCombat end
	_G.RegisterStateDriver = function() end
	_G.GetNumRaidMembers = function() return #state.roster end
	_G.GetRaidRosterInfo = function(i) return state.roster[i][1], nil, state.roster[i][2] end
	_G.GROUP = "Group"

	local Engine = EngineMock.new()
	Engine:NewStaticConfig("UnitFrames", { visuals = { units = { raid = {
		position = { "TOPLEFT", 0, 0 }, size = { 100, 30 }, offset = 5, auras = { button = { size = { 20, 20 } } },
		groups = { label_height = 40, spacing = 10 },
	} } } })
	Engine.CreateFrame = function() return newFrame() end
	local UnitFrame = Engine:NewHandler("UnitFrame")
	UnitFrame.New = function() return newFrame() end
	local Module = Engine:NewModule("UnitFrames")
	assert(loadfile("modules/unitframes/units/raid.lua"))("DiabolicUI", Engine)
	self.Widget = Module:GetWidget("Unit: Raid")
end

function TestRaidLayout:rosterChanges()
	local holder = self.Widget.UnitFrame
	holder.onEvent(holder, "RAID_ROSTER_UPDATE")
end

function TestRaidLayout:test_members_are_placed_out_of_combat()
	self.Widget:OnEnable()
	local frames = self.Widget.UnitFrames
	lu.assertTrue(frames[1].shown)
	lu.assertEquals(#frames[1].points, 1)
	lu.assertTrue(frames[2].shown)
	lu.assertFalse(frames[3].shown) -- nobody in slot 3
end

-- the points of `frame`'s one anchor: x, y
local function at(frame)
	return { frame.points[1][4], frame.points[1][5] }
end

function TestRaidLayout:test_members_are_placed_by_group_under_its_label()
	-- groups 1 and 2 share a column, 3 has the next; 2 rows of 35, a column of 128
	state.roster = { { "A", 1 }, { "B", 2 }, { "C", 1 }, { "D", 3 }, { "E", 2 } }
	self.Widget:OnEnable()
	local frames, labels = self.Widget.UnitFrames, self.Widget.GroupLabels
	lu.assertEquals(at(frames[1]), { 0, -40 })
	lu.assertEquals(at(frames[3]), { 0, -75 }) -- group 1's second
	lu.assertEquals(at(frames[2]), { 0, -265 }) -- group 2 under group 1's 40 + 5 * 35 + 10, then its label
	lu.assertEquals(at(frames[5]), { 0, -300 })
	lu.assertEquals(at(frames[4]), { 128, -40 })
	lu.assertEquals(labels[2].text, "Group 2")
	lu.assertEquals({ labels[2].width, labels[2].justify }, { 100, "CENTER" }) -- over the frames
	lu.assertEquals(at(labels[2]), { 0, -225 })
	lu.assertEquals(at(labels[3]), { 128, 0 })
	-- only the groups with someone in them are labeled
	lu.assertEquals({ labels[1].shown, labels[2].shown, labels[3].shown, labels[4].shown }, { true, true, true, false })

	-- group 3 leaves
	state.roster[4] = { "D", 1 }
	self:rosterChanges()
	lu.assertFalse(labels[3].shown)
	lu.assertEquals(at(frames[4]), { 0, -110 })
end

function TestRaidLayout:test_roster_change_in_combat_waits_for_the_end_of_combat()
	self.Widget:OnEnable()
	local frames, holder = self.Widget.UnitFrames, self.Widget.UnitFrame
	state.inCombat = true
	state.roster[3] = { "Newcomer", 1 }
	self:rosterChanges()
	lu.assertFalse(frames[3].shown) -- secure frames untouched in combat
	lu.assertTrue(holder.events.PLAYER_REGEN_ENABLED)

	state.inCombat = false
	holder.onEvent(holder, "PLAYER_REGEN_ENABLED")
	lu.assertTrue(frames[3].shown)
	lu.assertNil(holder.events.PLAYER_REGEN_ENABLED)
end

os.exit(lu.LuaUnit.run())
