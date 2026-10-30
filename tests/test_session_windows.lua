-- Run from the addon root: lua5.1 tests/test_session_windows.lua
--
-- Blizzard's windows in Diablo III's look (modules/blizzard/windows.lua and
-- the windows built on it) in the fake client: the spellbook and its
-- companions' pages, the social window, the quest log, the talents and
-- glyphs, the other panels, and the bag and
-- group addons' windows (AdiBags, Group Bulletin Board).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client

local function boot(options)
	client = Client.boot(options)
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

local function near(actual, expected, message)
	for i = 1, 3 do
		lu.assertAlmostEquals(actual[i], expected[i], 1e-6, message)
	end
end

local function color(...)
	local r, g, b = ...
	return { r, g, b }
end

-- The spellbook ----------------------------------------------------------------------

TestSpellbook = {}

function TestSpellbook:tearDown()
	client = nil
end

local function companions(world)
	world.companions = {
		CRITTER = { { 101, "Mechanical Squirrel", 4055, "Interface\\Icons\\Squirrel" } },
		MOUNT = { { 201, "Swift Gryphon", 32242, "Interface\\Icons\\Gryphon" }, { 202, "Black Stallion", 470, "Interface\\Icons\\Horse" } },
	}
end

function TestSpellbook:test_the_spells_on_the_book()
	boot()
	local module = client:GetModule("Blizzard: Spellbook")
	local config = client.Engine:GetDB("Blizzard").spellbook
	local ink = client.Engine:GetDB("Blizzard").window.ink
	-- a spell: its border, its name in ink right of it
	local button, name = _G.SpellButton1, _G.SpellButton1SpellName
	_G.SpellButton1IconTexture:Show()
	name:SetTextColor(1, .82, 0)
	_G.SpellButton_UpdateButton(button)
	lu.assertTrue(shown(button.DiabolicBorder))
	lu.assertEquals({ name:GetPoint() }, { "LEFT", button, "RIGHT", config.name_offset, 0 })
	near(color(name:GetTextColor()), ink)
	-- a passive one (Blizzard's grey) in its own ink
	name:SetTextColor(.5, .5, .5)
	_G.SpellButton_UpdateButton(button)
	near(color(name:GetTextColor()), config.passive_color)
	-- an empty one not drawn
	_G.SpellButton1IconTexture:Hide()
	_G.SpellButton_UpdateButton(button)
	lu.assertFalse(shown(button.DiabolicBorder))
	-- the book again
	_G.SpellBookFrame.bookType = _G.BOOKTYPE_SPELL
	_G.SpellBookFrame_Update()
	lu.assertTrue(module.Book[1]:IsShown() == 1)
	assertClean(client)
end

function TestSpellbook:test_the_tabs_hang_under_the_window()
	boot({ world = companions })
	local module = client:GetModule("Blizzard: Spellbook")
	local banner = client.Engine:GetDB("Blizzard").window.banner
	local frame = _G.SpellBookFrame
	frame.bookType = _G.BOOKTYPE_SPELL
	local spells, pet = _G.SpellBookFrameTabButton1, _G.SpellBookFrameTabButton2
	spells.bookType, pet.bookType = _G.BOOKTYPE_SPELL, _G.BOOKTYPE_PET
	spells:Show()
	pet:Show()
	_G.SpellBookFrameTabButton3:Hide()
	frame:Show()
	-- Blizzard's shown ones, then ours, side by side from the left of the
	-- window's foot (from its rail); the chosen one off
	local window = spells.DiabolicWindow
	local critters, mounts = module.Tabs[1], module.Tabs[2]
	lu.assertTrue(shown(critters))
	local function row(...)
		local below = banner.rail.height - banner.rail.up
		for i, tab in ipairs({ ... }) do
			lu.assertEquals({ tab:GetPoint() }, { "TOPLEFT", window, "BOTTOMLEFT", banner.left + (i - 1) * (banner.width + banner.gap), banner.tuck - below })
		end
	end
	local shownOwn = {}
	for _, tab in ipairs(module.Tabs) do
		if tab:IsShown() then
			shownOwn[#shownOwn + 1] = tab
		end
	end
	row(spells, pet, unpack(shownOwn))
	lu.assertEquals(spells:IsEnabled(), 0)
	-- no companions: their tab gone, and without Blizzard's the first
	client.world.companions.CRITTER = {}
	spells:Hide()
	pet:Hide()
	client:FireEvent("COMPANION_UNLEARNED")
	lu.assertFalse(shown(critters))
	local left = {}
	for _, tab in ipairs(module.Tabs) do
		if tab:IsShown() then
			left[#left + 1] = tab
		end
	end
	lu.assertEquals(left[1], mounts)
	row(unpack(left))
	assertClean(client)
end

function TestSpellbook:test_the_companions_and_mounts_pages()
	boot({ world = companions })
	local module = client:GetModule("Blizzard: Spellbook")
	local frame = _G.SpellBookFrame
	local spells = _G.SpellBookFrameTabButton1
	frame.bookType, spells.bookType = _G.BOOKTYPE_SPELL, _G.BOOKTYPE_SPELL
	spells:Show()
	frame:Show()
	-- the mounts: their page over the book, their tab chosen, the title theirs
	_G.CompanionButton1.creatureID = 201
	client:Click(module.Tabs[2])
	lu.assertEquals(module.page, "MOUNT")
	lu.assertTrue(shown(module.Cover))
	lu.assertFalse(shown(module.Book[1]))
	lu.assertEquals(_G.PetPaperDollFrameCompanionFrame.mode, "MOUNT")
	lu.assertEquals(_G.SpellBookTitleText:GetText(), _G.MOUNTS)
	lu.assertEquals(module.Tabs[2]:IsEnabled(), 0)
	-- the known ones named, the empty slots out of sight
	lu.assertEquals(module.CompanionNames[1]:GetText(), "Swift Gryphon")
	lu.assertEquals(module.CompanionSlots[1]:GetAlpha(), 1)
	lu.assertEquals(module.CompanionNames[2]:GetText(), "")
	lu.assertEquals(module.CompanionSlots[2]:GetAlpha(), 0)
	-- Blizzard's own pet tab keeps the page's mode
	_G.PetPaperDollFrameCompanionFrame.mode = "CRITTER"
	_G.PetPaperDollFrame_SetTab(2)
	lu.assertEquals(_G.PetPaperDollFrameCompanionFrame.mode, "MOUNT")
	-- the spells' tab, lit under the mouse, back to the book
	lu.assertTrue(shown(module.Back))
	client:Hover(module.Back)
	client:Leave()
	client:Click(module.Back)
	lu.assertNil(module.page)
	lu.assertFalse(shown(module.Cover))
	lu.assertTrue(shown(module.Book[1]))
	lu.assertEquals(_G.SpellBookTitleText:GetText(), _G.SPELLBOOK)
	-- now the pet tab hides the companions
	_G.PetPaperDollFrameCompanionFrame:Show()
	_G.PetPaperDollFrame_SetTab(2)
	lu.assertFalse(shown(_G.PetPaperDollFrameCompanionFrame))
	-- closed on a page: the spells next time
	client:Click(module.Tabs[1])
	frame:Hide()
	lu.assertNil(module.page)
	assertClean(client)
end

function TestSpellbook:test_not_in_combat()
	boot({ world = companions })
	local module = client:GetModule("Blizzard: Spellbook")
	local frame = _G.SpellBookFrame
	frame:Show()
	client:Click(module.Tabs[2])
	client:EnterCombat()
	-- no other page in a fight (the companions' buttons are secure)
	client:Click(module.Tabs[1])
	lu.assertEquals(module.page, "MOUNT")
	-- nor the pet tab's
	_G.PetPaperDollFrame_SetTab(2)
	-- closed in a fight: the spells once it's over
	frame:Hide()
	lu.assertEquals(module.page, "MOUNT")
	client:LeaveCombat()
	lu.assertNil(module.page)
	lu.assertFalse(shown(module.Cover))
	assertClean(client)
end

function TestSpellbook:test_styled_after_a_fight()
	-- (a /reload in a fight: locked down once the files have loaded)
	client = Client.boot({ login = false })
	client.world.inCombat = true
	client:Login()
	local module = client:GetModule("Blizzard: Spellbook")
	lu.assertNil(module.Cover)
	-- (the rest of the addon's own login in a fight is none of this test's)
	client:ClearProblems()
	client:LeaveCombat()
	lu.assertNotNil(module.Cover)
	assertClean(client)
end

function TestSpellbook:test_sholazar_behind_the_companions()
	boot({ world = companions })
	local module = client:GetModule("Blizzard: Spellbook")
	local config = client.Engine:GetDB("Blizzard").spellbook
	_G.SpellBookFrame:Show()
	-- each page its painting, darkened, over the whole cover
	local art = module.Cover.Art
	near(color(art:GetVertexColor()), config.cover_art_color)
	client:Click(module.Tabs[1])
	lu.assertEquals(art:GetTexture(), config.cover_art.CRITTER)
	client:Click(module.Tabs[2])
	lu.assertEquals(art:GetTexture(), config.cover_art.MOUNT)
	assertClean(client)
end

function TestSpellbook:test_the_pet_tab_for_the_pet_only()
	boot()
	-- open on it without a pet: back to the character's
	_G.CharacterFrame:Show()
	_G.PaperDollFrame:Hide()
	_G.PetPaperDollFrame:Show()
	_G.PetPaperDollFrame_UpdateIsAvailable()
	lu.assertEquals(client.toggled, "CharacterFrame:PaperDollFrame")
	-- a pet: its own tab first, on Blizzard's companions tab
	client.world.units.pet = Client.newUnit({ name = "Wolf", isHunterPet = true })
	_G.CharacterFrame:Show()
	_G.PetPaperDollFrame:Show()
	_G.PetPaperDollFrame.selectedTab = 2
	local chosen
	_G.PetPaperDollFrame_SetTab = function(tab) chosen = tab end
	_G.PetPaperDollFrame_UpdateTabs()
	lu.assertEquals(chosen, 1)
	assertClean(client)
end

-- A mage's book: Fireball in two ranks, thirteen more fire spells (two
-- pages found), a passive one, Frostbolt.
local function mageBook(world)
	local book = {
		{ name = "Fireball", rank = "Rank 1", texture = [[Interface\Icons\Spell_Fire_FlameBolt]] },
		{ name = "Fireball", rank = "Rank 2", texture = [[Interface\Icons\Spell_Fire_FlameBolt]] },
		{ name = "Frostbolt", rank = "Rank 1" },
		{ name = "Fire Mastery", rank = "", passive = true },
	}
	for i = 1, 13 do
		book[#book + 1] = { name = "Fire Spell " .. i, rank = "" }
	end
	world.spellBook = book
	-- on the bars: Fireball's best rank, a macro casting Frostbolt
	world.actions[1] = { type = "spell", id = 2, spellID = 143, name = "Fireball", texture = "x", count = 0, cooldown = { 0, 0, 1 } }
	world.spells[143] = { name = "Fireball" }
end

TestSpellbookPages = {}

function TestSpellbookPages:tearDown()
	client = nil
end

function TestSpellbookPages:test_the_search()
	boot({ class = "MAGE", world = mageBook })
	local module = client:GetModule("Blizzard: Spellbook")
	local frame = _G.SpellBookFrame
	frame.bookType = _G.BOOKTYPE_SPELL
	frame:Show()
	local box, hint = module.SearchBox, module.SearchHint
	-- "Search" pale in it until it's typed in
	lu.assertTrue(shown(hint))
	client:RunScript(box, "OnEditFocusGained")
	lu.assertFalse(shown(hint))
	client:RunScript(box, "OnEditFocusLost")
	lu.assertTrue(shown(hint))
	-- the spells found on a book of their own, the best rank of each
	box:SetText("FIRE")
	lu.assertEquals(module.page, "SEARCH")
	lu.assertTrue(shown(module.Found))
	local first = module.FoundButtons[1]
	lu.assertEquals(first.Name:GetText(), "Fireball")
	lu.assertEquals(first.Rank:GetText(), "Rank 2")
	lu.assertEquals(first:GetAttribute("spell"), "Fireball(Rank 2)")
	lu.assertEquals(first:GetAttribute("type"), "spell")
	-- the passive one not cast, greyed
	local passive = module.FoundButtons[2]
	lu.assertEquals(passive.Name:GetText(), "Fire Mastery")
	lu.assertNil(passive:GetAttribute("type"))
	lu.assertTrue(passive.Icon:IsDesaturated() == 1)
	-- two pages of them
	local found = module.Found
	lu.assertEquals(found.Prev:IsEnabled(), 0)
	lu.assertEquals(found.Next:IsEnabled(), 1)
	client:Click(found.Next)
	lu.assertEquals(module.FoundPage, 2)
	lu.assertEquals(found.Next:IsEnabled(), 0)
	lu.assertFalse(shown(module.FoundButtons[12]))
	client:Click(found.Prev)
	lu.assertEquals(module.FoundPage, 1)
	-- a found spell's tooltip, dragged to the bars
	client:Hover(first)
	lu.assertTrue(shown(_G.GameTooltip))
	client:Leave()
	client:RunScript(first, "OnDragStart")
	lu.assertEquals(client.cursor, { "spell", 2, _G.BOOKTYPE_SPELL })
	-- every rank while all ranks show
	client.world.cvars.ShowAllSpellRanks = "1"
	box:SetText("fireball")
	lu.assertEquals(module.FoundButtons[2].Rank:GetText(), "Rank 2")
	client.world.cvars.ShowAllSpellRanks = "0"
	-- none
	box:SetText("arcane")
	lu.assertTrue(shown(found.None))
	-- Enter keeps it, Escape empties it: the spells again
	client:RunScript(box, "OnEnterPressed")
	lu.assertEquals(module.page, "SEARCH")
	client:RunScript(box, "OnEscapePressed")
	lu.assertNil(module.page)
	lu.assertFalse(shown(module.Cover))
	-- (emptied on another page: nothing to leave)
	box:SetText("")
	assertClean(client)
end

function TestSpellbookPages:test_the_search_left_for_other_pages_and_fights()
	boot({ class = "MAGE", world = mageBook })
	local module = client:GetModule("Blizzard: Spellbook")
	local frame = _G.SpellBookFrame
	frame.bookType = _G.BOOKTYPE_SPELL
	frame:Show()
	local box = module.SearchBox
	box:SetText("fire")
	-- another page: the box emptied
	module:ShowPage("MOUNT")
	lu.assertEquals(box:GetText(), "")
	lu.assertFalse(shown(box)) -- (the band's search on the spells only)
	module:ShowPage(nil)
	lu.assertTrue(shown(box))
	-- the pet's book: back to the spells, the search out of sight
	box:SetText("fire")
	frame.bookType = _G.BOOKTYPE_PET
	_G.SpellBookFrame_Update()
	lu.assertNil(module.page)
	lu.assertFalse(shown(box))
	frame.bookType = _G.BOOKTYPE_SPELL
	_G.SpellBookFrame_Update()
	-- in a fight: nothing searched, no page turned
	box:SetText("fire")
	client:EnterCombat()
	module.Clearing = nil
	box:SetText("frost")
	lu.assertEquals(module.FoundButtons[1].Name:GetText(), "Fireball")
	client:Click(module.Found.Next)
	lu.assertEquals(module.FoundPage, 1)
	module:UpdateFound()
	client:RunScript(module.FoundButtons[1], "OnDragStart")
	lu.assertNil(client.cursor)
	-- (the pet's book in a fight: the page kept)
	frame.bookType = _G.BOOKTYPE_PET
	_G.SpellBookFrame_Update()
	lu.assertEquals(module.page, "SEARCH")
	frame.bookType = _G.BOOKTYPE_SPELL
	client:LeaveCombat()
	assertClean(client)
end

function TestSpellbookPages:test_the_spells_on_no_action_bar_ringed()
	boot({ class = "MAGE", world = mageBook })
	local module = client:GetModule("Blizzard: Spellbook")
	local frame = _G.SpellBookFrame
	frame.bookType = _G.BOOKTYPE_SPELL
	frame.selectedSkillLine, frame.selectedSkillLineOffset = 1, 0
	frame:Show()
	local box = module.UnassignedBox
	-- its tooltip, and the "all ranks" box's
	client:Hover(box)
	lu.assertTrue(shown(_G.GameTooltip))
	client:Hover(_G.ShowAllSpellRanksCheckBox)
	lu.assertTrue(shown(_G.GameTooltip))
	client:Leave()
	-- (the left page's buttons: the book's spells 1 to 6)
	local fireball, frostbolt, passive = _G.SpellButton3, _G.SpellButton5, _G.SpellButton7
	for _, button in ipairs({ fireball, frostbolt, passive }) do
		_G[button:GetName() .. "IconTexture"]:Show()
	end
	-- off: none ringed
	client:Click(box)
	lu.assertFalse(module.db.showUnassigned)
	lu.assertFalse(shown(frostbolt.DiabolicUnassigned))
	-- on: Frostbolt (on no bar) ringed, Fireball (on one) and the passive one not
	client:Click(box)
	lu.assertTrue(module.db.showUnassigned)
	lu.assertFalse(shown(fireball.DiabolicUnassigned))
	lu.assertTrue(shown(frostbolt.DiabolicUnassigned))
	lu.assertFalse(shown(passive.DiabolicUnassigned))
	-- Frostbolt on a bar (in a macro): ringed no more
	client.world.actions[2] = { type = "macro", id = 1, name = "Frost", texture = "x", count = 0, cooldown = { 0, 0, 1 } }
	client.world.macroSpells = { [1] = "Frostbolt" }
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 2)
	lu.assertFalse(shown(frostbolt.DiabolicUnassigned))
	-- (the book closed: read again next time)
	frame:Hide()
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 2)
	lu.assertNil(module.Assigned)
	assertClean(client)
end

function TestSpellbookPages:test_the_professions_page()
	boot({ class = "MAGE", world = function(world)
		mageBook(world)
		for id, name in pairs({ [3908] = "Tailoring", [2575] = "Mining", [2656] = "Smelting", [2580] = "Find Minerals",
			[2550] = "Cooking", [818] = "Basic Campfire", [7620] = "Fishing", [3273] = "First Aid" }) do
			world.spells[id] = { name = name, icon = [[Interface\Icons\]] .. name }
		end
		world.unknownSpells = { ["Basic Campfire"] = true }
		-- { name, header, expanded, rank, temp, modifier, max }
		world.skillLines = {
			{ "TRADE_SKILLS", true, nil }, -- (collapsed: opened to read it)
			{ "Tailoring", nil, nil, 290, 0, 10, 450 },
			{ "SECONDARY_SKILLS", true, 1 },
			{ "Cooking", nil, nil, 75, 0, 0, 75 },
			{ "Riding", nil, nil, 150, 0, 0, 150 },
		}
	end })
	local module = client:GetModule("Blizzard: Spellbook")
	local frame = _G.SpellBookFrame
	frame.bookType = _G.BOOKTYPE_SPELL
	frame:Show()
	module:ShowPage("PROFESSIONS")
	lu.assertTrue(shown(module.Professions))
	lu.assertEquals(client.world.skillLines[1][3], 1)
	-- Tailoring: its rank's title, its bar, the button opening it
	local tailoring = module.ProfessionRows.primary[1]
	lu.assertEquals(tailoring.Name:GetText(), "Tailoring")
	lu.assertEquals(tailoring.Bar.Text:GetText(), "300 / 450")
	lu.assertTrue(shown(tailoring.Open))
	lu.assertEquals(tailoring.Open:GetAttribute("spell"), "Tailoring")
	lu.assertFalse(shown(tailoring.Extra))
	client:Hover(tailoring.Open)
	lu.assertTrue(shown(_G.GameTooltip))
	client:Leave()
	-- the second one missing: where to learn one, greyed
	local missing = module.ProfessionRows.primary[2]
	lu.assertFalse(shown(missing.Bar))
	lu.assertTrue(shown(missing.Help))
	lu.assertFalse(shown(missing.Open))
	client:Hover(missing.Open)
	client:Leave()
	-- the secondary ones each in their place: Cooking learned (its
	-- campfire not known), Fishing and First Aid not
	local cooking, fishing = module.ProfessionRows.secondary[1], module.ProfessionRows.secondary[2]
	lu.assertEquals(cooking.Name:GetText(), "Cooking")
	lu.assertFalse(shown(cooking.Extra))
	lu.assertEquals(fishing.Name:GetText(), "Fishing")
	lu.assertTrue(shown(fishing.Help))
	-- Mining learned: Smelting opens it, Find Minerals beside it
	client.world.skillLines[2] = { "Mining", nil, nil, 75, 0, 0, 150 }
	client:FireEvent("SKILL_LINES_CHANGED")
	lu.assertEquals(tailoring.Open:GetAttribute("spell"), "Smelting")
	lu.assertTrue(shown(tailoring.Extra))
	-- in a fight: once it's over
	client.world.skillLines[2] = { "Tailoring", nil, nil, 300, 0, 0, 450 }
	client:EnterCombat()
	client:FireEvent("SKILL_LINES_CHANGED")
	lu.assertEquals(tailoring.Name:GetText(), "Mining")
	client:LeaveCombat()
	lu.assertEquals(tailoring.Name:GetText(), "Tailoring")
	-- (another page: not filled again)
	module:ShowPage(nil)
	client:FireEvent("SKILL_LINES_CHANGED")
	assertClean(client)
end

-- The social window ------------------------------------------------------------------

TestSocial = {}

function TestSocial:tearDown()
	client = nil
end

function TestSocial:test_the_who_list_sorted_by_the_column_chosen()
	boot()
	local sorted
	_G.SortWho = function(sortType) sorted = sortType end
	local option = _G.CreateFrame("Button")
	option:SetID(2)
	_G.WhoFrameDropDownButton_OnClick(option)
	lu.assertEquals(sorted, _G.WHOFRAME_DROPDOWN_LIST[2].sortType)
	assertClean(client)
end

function TestSocial:test_the_guild_logs_times_in_their_ink()
	boot()
	local inks = client.Engine:GetDB("Blizzard").panels.log_inks
	local text = _G.GuildEventMessage
	text:SetText("|cff009999[2 days ago]|r Tester joined the guild.")
	_G.GuildEventLog_Update()
	local code = string.format("|cff%02x%02x%02x", inks.time[1] * 255, inks.time[2] * 255, inks.time[3] * 255)
	lu.assertEquals(text:GetText(), code .. "[2 days ago]|r Tester joined the guild.")
	-- (an empty log)
	text:SetText(nil)
	_G.GuildEventLog_Update()
	assertClean(client)
end

-- The quest log ----------------------------------------------------------------------

TestQuestLog = {}

function TestQuestLog:tearDown()
	client = nil
end

function TestQuestLog:test_the_details_in_ink_on_the_parchment()
	boot()
	local config = client.Engine:GetDB("Blizzard").questlog
	client.world.quests = { { title = "Hogger", level = 10, id = 1,
		objectives = { { text = "Hogger slain: 1/1", finished = true }, { text = "Claws: 0/3", finished = false } } } }
	_G.SelectQuestLogEntry(1)
	_G.QuestLogFrame:Show()
	_G.QuestInfoObjective1:Show()
	_G.QuestInfoObjective2:Show()
	_G.QuestInfo_Display(nil, _G.QuestLogDetailScrollChildFrame)
	near(color(_G.QuestInfoTitleHeader:GetTextColor()), config.header_color)
	near(color(_G.QuestInfoDescriptionText:GetTextColor()), config.text_color)
	near(color(_G.QuestInfoObjective1:GetTextColor()), config.done_color)
	near(color(_G.QuestInfoObjective2:GetTextColor()), config.text_color)
	-- the quest giver's window: Blizzard's colors for its material again
	_G.QuestInfo_Display(nil, _G.QuestDetailScrollChildFrame, nil, nil, "Stone")
	near(color(_G.QuestInfoTitleHeader:GetTextColor()), { 0, 0, 0 })
	assertClean(client)
end

function TestQuestLog:test_the_count_in_the_title_the_dailies_on_hover()
	boot({ world = function(world) world.dailiesDone = 3 end })
	local title = _G.QuestLogTitleText
	_G.QuestLog_UpdateQuestCount(15)
	lu.assertEquals(title:GetText(), "QUEST_LOG  15/25")
	-- the title's tooltip: the dailies done, when they reset
	local hover
	for _, child in ipairs({ title:GetParent():GetChildren() }) do
		if (select(2, child:GetPoint()) == title) then
			hover = child
		end
	end
	client:Hover(hover)
	lu.assertTrue(shown(_G.GameTooltip))
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	assertClean(client)
end

function TestQuestLog:test_the_details_and_buttons_kept_in_place()
	boot()
	local module = client:GetModule("Blizzard: Quest Log")
	local config = client.Engine:GetDB("Blizzard").questlog
	-- Blizzard puts them back in the log, where they were before
	local panel, scroll = _G.QuestLogControlPanel, _G.QuestLogDetailScrollFrame
	panel:SetParent(_G.QuestLogFrame)
	_G.QuestLogControlPanel_UpdatePosition()
	lu.assertEquals({ panel:GetPoint() }, { "BOTTOMLEFT", module.Window, "BOTTOMLEFT", unpack(config.controls) })
	scroll:SetParent(_G.QuestLogFrame)
	_G.QuestLogDetailFrame_AttachToQuestLog()
	lu.assertEquals({ scroll:GetPoint() }, { "TOPRIGHT", module.Window, "TOPRIGHT", unpack(config.details) })
	assertClean(client)
end

-- The talents ------------------------------------------------------------------------

TestTalents = {}

function TestTalents:tearDown()
	client = nil
end

function TestTalents:test_the_specs_in_the_band_and_the_glyphs()
	boot()
	client.api.LoadAddOn("Blizzard_TalentUI")
	local module = client:GetModule("Blizzard: Talents")
	local config = client.Engine:GetDB("Blizzard").talents
	-- the specs shown, in a row from the band's left end
	_G.PlayerSpecTab1:Show()
	_G.PlayerSpecTab2:Show()
	_G.PlayerSpecTab3:Hide()
	_G.PlayerTalentFrame_UpdateSpecs()
	lu.assertEquals({ _G.PlayerSpecTab1:GetPoint() }, { "LEFT", module.Header, "LEFT", config.spec_offset, 0 })
	lu.assertEquals({ _G.PlayerSpecTab2:GetPoint() }, { "LEFT", _G.PlayerSpecTab1, "RIGHT", config.spec_gap, 0 })
	-- the glyphs once they load: on a cover over the tree, its scroll bar gone
	client.api.LoadAddOn("Blizzard_GlyphUI")
	lu.assertTrue(module.GlyphsStyled)
	local bar = _G.PlayerTalentFrameScrollFrameScrollBar
	lu.assertEquals(bar:GetAlpha(), 1)
	_G.GlyphFrame:Show()
	lu.assertEquals(bar:GetAlpha(), 0)
	local x, y, width, height = unpack(config.glyph_art)
	lu.assertEquals({ _G.GlyphFrameBackground:GetSize() }, { width, height })
	lu.assertEquals(_G.GlyphFrame:GetScale(), config.glyph_height / height)
	_G.GlyphFrame:Hide()
	lu.assertEquals(bar:GetAlpha(), 1)
	assertClean(client)
end

function TestTalents:test_the_glyphs_shown_as_they_load()
	boot({ world = function(world, c)
		c.api.LoadAddOn("Blizzard_TalentUI")
		c.api.LoadAddOn("Blizzard_GlyphUI")
		_G.GlyphFrame:Show()
	end })
	lu.assertEquals(_G.PlayerTalentFrameScrollFrameScrollBar:GetAlpha(), 0)
	assertClean(client)
end

-- The other windows ------------------------------------------------------------------

TestPanels = {}

function TestPanels:tearDown()
	client = nil
end

function TestPanels:test_their_dark_text_pale_and_their_titles()
	boot({ world = function(world, c)
		-- a title with no name of its own, and text drawn for parchment
		local title = _G.PVPParentFrame:CreateFontString(nil, "ARTWORK")
		title:SetText(_G.PLAYER_V_PLAYER)
	end })
	local config = client.Engine:GetDB("Blizzard").panels
	local frame = _G.PetitionFrame
	local dark = frame:CreateFontString(nil, "ARTWORK")
	dark:SetTextColor(0, 0, 0)
	frame:Show()
	near(color(dark:GetTextColor()), config.text_color)
	-- styled once
	local module = client:GetModule("Blizzard: Panels")
	local window = select(1, frame:GetChildren())
	module:StylePanel(config.frames[1])
	lu.assertEquals(select(1, frame:GetChildren()), window)
	assertClean(client)
end

function TestPanels:test_books_in_ink()
	boot()
	local ink = client.Engine:GetDB("Blizzard").window.ink
	_G.ItemTextPageText:SetTextColor(1, 1, 1)
	_G.ItemTextFrame:Show()
	near(color(_G.ItemTextPageText:GetTextColor()), ink)
	assertClean(client)
end

function TestPanels:test_the_guild_banks_log_in_ink()
	boot({ world = function()
		-- (its time's code, as the client's global string has it)
		rawset(_G, "GUILD_BANK_LOG_TIME_PREPEND", "|cff009999   (%s)|r")
	end })
	client.api.LoadAddOn("Blizzard_GuildBankUI")
	local inks = client.Engine:GetDB("Blizzard").panels.log_inks
	local ink = client.Engine:GetDB("Blizzard").window.ink
	local function code(c)
		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	end
	local log = _G.GuildBankMessageFrame
	log:AddMessage(_G.NORMAL_FONT_COLOR_CODE .. "Thrall|r deposited |cffa335ee[Frostmourne]|r, |cffffffffLinen|r, |cff1d1d1dgrey|r|cff009999   (2 hours ago)|r")
	local messages = client.widgetState[log].messages
	local message = messages[#messages]
	-- the name and time in their inks, the epic darkened, white as ink,
	-- the dark one kept; the line in ink
	lu.assertStrContains(message.text, code(inks.name) .. "Thrall|r")
	lu.assertStrContains(message.text, code(inks.time) .. "   (2 hours ago)|r")
	lu.assertStrContains(message.text, code(ink) .. "Linen|r")
	lu.assertStrContains(message.text, "|cff1d1d1dgrey|r")
	lu.assertNil(message.text:find("|cffa335ee", 1, true))
	lu.assertEquals({ message.r, message.g, message.b }, ink)
	assertClean(client)
end

function TestPanels:test_the_guild_banks_rail_fitted_once_placed()
	boot()
	client.api.LoadAddOn("Blizzard_GuildBankUI")
	-- (not placed yet: nothing to fit it to)
	local frame = _G.GuildBankFrame
	frame:Hide()
	frame:ClearAllPoints()
	lu.assertNil(frame:GetLeft())
	frame:Show()
	frame:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 0, -104)
	frame:Hide()
	frame:Show()
	lu.assertNotNil(frame:GetLeft())
	assertClean(client)
end

function TestPanels:test_loaded_before_us()
	boot({ world = function(world, c)
		c.api.LoadAddOn("Blizzard_MacroUI")
	end })
	lu.assertTrue(_G.MacroFrame.DiabolicPanel)
	assertClean(client)
end

function TestPanels:test_the_other_load_on_demand_windows()
	boot()
	for _, addon in ipairs({ "Blizzard_GuildBankUI", "Blizzard_BindingUI", "Blizzard_MacroUI", "Blizzard_TrainerUI",
		"Blizzard_ItemSocketingUI" }) do
		client.api.LoadAddOn(addon)
	end
	for _, name in ipairs({ "GuildBankFrame", "KeyBindingFrame", "MacroFrame", "ClassTrainerFrame", "ItemSocketingFrame" }) do
		lu.assertTrue(_G[name].DiabolicPanel, name)
	end
	assertClean(client)
end

-- The mailbox ---------------------------------------------------------------------------

TestMail = {}

function TestMail:tearDown()
	client = nil
end

-- Postal's parts, made as it enables: its Open and Return, its address
-- book's arrow, its checkboxes on the rows, its Open All and menu.
local function postal()
	local inbox = _G.InboxFrame
	for _, name in ipairs({ "PostalSelectOpenButton", "PostalSelectReturnButton", "PostalOpenAllButton" }) do
		local b = _G.CreateFrame("Button", name, inbox, "UIPanelButtonTemplate")
		b:SetSize(80, 22)
		b:SetPoint("TOPLEFT", inbox, "TOPLEFT", 10, -10)
	end
	for i = 1, 7 do
		_G.CreateFrame("CheckButton", "PostalInboxCB" .. i, _G["MailItem" .. i]):SetPoint("RIGHT", _G["MailItem" .. i], "LEFT", 0, 0)
	end
	_G.CreateFrame("Button", "Postal_ModuleMenuButton", _G.MailFrame):SetPoint("TOPRIGHT", _G.MailFrame, "TOPRIGHT", -40, -10)
	_G.CreateFrame("Button", "Postal_BlackBookButton", _G.SendMailFrame):SetPoint("LEFT", _G.SendMailNameEditBox, "RIGHT", 0, 0)
end

function TestMail:test_the_inbox_and_the_letter_being_written()
	boot()
	local module = client:GetModule("Blizzard: Mail")
	local config = client.Engine:GetDB("Blizzard").mail
	local frame = _G.MailFrame
	frame:Show()
	-- one title for both tabs: the tab's
	local title = module.Header:GetParent().DiabolicPlate
	local function titleText()
		for _, region in ipairs({ title:GetRegions() }) do
			if region:IsObjectType("FontString") then
				return region:GetText()
			end
		end
	end
	_G.SendMailFrame:Show()
	lu.assertEquals(titleText(), _G.SENDMAIL)
	_G.SendMailFrame:Hide()
	_G.InboxFrame:Hide()
	_G.InboxFrame:Show()
	lu.assertEquals(titleText(), _G.INBOX)

	-- To and Subject in the band, their labels pale in them while empty
	-- and not typed in
	local name = _G.SendMailNameEditBox
	local hint
	for _, region in ipairs({ name:GetRegions() }) do
		if region:IsObjectType("FontString") and (region:GetText() == (_G.MAIL_TO_LABEL:gsub("%s*:%s*$", ""))) then
			hint = region
		end
	end
	lu.assertTrue(shown(hint))
	client:RunScript(name, "OnEditFocusGained")
	lu.assertFalse(shown(hint))
	client:RunScript(name, "OnEditFocusLost")
	lu.assertTrue(shown(hint))
	name:SetText("Thrall")
	lu.assertFalse(shown(hint))
	-- the subject up to the postage, as its sum grows (not narrower than nothing)
	local cost, subject = _G.SendMailCostMoneyFrame, _G.SendMailSubjectEditBox
	cost:SetWidth(60)
	local wide = subject:GetWidth()
	cost:SetWidth(90)
	lu.assertEquals(subject:GetWidth(), wide - 30)
	cost:SetWidth(1000)
	lu.assertEquals(subject:GetWidth(), wide - 30)

	-- the letters in ink: unread and read, the days left (red: running out)
	local ink = config.list_ink
	_G.MailItem1Sender:SetTextColor(1, .82, 0)
	_G.MailItem2Sender:SetTextColor(.75, .75, .75)
	_G.MailItem1ExpireTime:SetText("|cff20ff2029 Days|r")
	_G.MailItem2ExpireTime:SetText(_G.RED_FONT_COLOR_CODE .. "2 Days|r")
	_G.InboxFrame_Update()
	near(color(_G.MailItem1Sender:GetTextColor()), ink.sender)
	near(color(_G.MailItem1Subject:GetTextColor()), ink.subject)
	near(color(_G.MailItem2Sender:GetTextColor()), ink.read)
	lu.assertEquals(_G.MailItem1ExpireTime:GetText(), "29 Days")
	near(color(_G.MailItem1ExpireTime:GetFontString():GetTextColor()), ink.days)
	near(color(_G.MailItem2ExpireTime:GetFontString():GetTextColor()), ink.expiring)
	-- the icons in color, read or not
	_G.MailItem2ButtonIcon:SetDesaturated(1)
	_G.InboxFrame_Update()
	lu.assertNil(_G.MailItem2ButtonIcon:IsDesaturated())
	-- the rows up under the band, apart, each time it opens (once apart)
	lu.assertEquals(select(5, _G.MailItem1:GetPoint()), config.rows_top)
	local _, _, _, _, y = _G.MailItem2:GetPoint()
	frame:Hide()
	frame:Show()
	lu.assertEquals(select(5, _G.MailItem2:GetPoint()), y)
	assertClean(client)
end

function TestMail:test_the_letters_attachments_alone()
	boot()
	local config = client.Engine:GetDB("Blizzard").mail
	local frame, scroll = _G.OpenMailFrame, _G.OpenMailScrollFrame
	frame:Show()
	_G.OpenMail_Update()
	-- without Blizzard's label
	lu.assertNil(_G.OpenMailAttachmentText:IsShown())
	-- the buttons in the middle of the space under the letter's panel
	local money, item = _G.OpenMailMoneyButton, _G.OpenMailAttachmentButton1
	local insets = config.text_panel_insets
	local left, right = select(4, money:GetPoint()), select(4, item:GetPoint()) + item:GetWidth()
	lu.assertAlmostEquals((left + right) / 2, (scroll:GetLeft() - frame:GetLeft() - insets[1]
		+ scroll:GetRight() - frame:GetLeft() + insets[3]) / 2, 1e-6)
	local y = select(5, money:GetPoint())
	lu.assertEquals(select(5, item:GetPoint()), y)
	lu.assertAlmostEquals(y - money:GetHeight() / 2, (scroll:GetBottom() - frame:GetBottom() - insets[4]
		+ config.open_attachments_floor) / 2, 1e-6)
	-- (again on the next update, from where Blizzard puts them again)
	_G.OpenMail_Update()
	lu.assertEquals(select(5, money:GetPoint()), y)
	assertClean(client)
end

function TestMail:test_postals_parts_in_place()
	boot()
	local module = client:GetModule("Blizzard: Mail")
	local config = client.Engine:GetDB("Blizzard").mail
	postal()
	local frame = _G.MailFrame
	frame:Show()
	-- Open and Return side by side in the band's middle
	local spec = config.select_buttons
	lu.assertEquals({ _G.PostalSelectOpenButton:GetPoint() }, { "RIGHT", module.Header, "CENTER", -spec.gap / 2, 0 })
	lu.assertEquals({ _G.PostalSelectReturnButton:GetPoint() }, { "LEFT", module.Header, "CENTER", spec.gap / 2, 0 })
	lu.assertEquals(_G.PostalSelectOpenButton:GetWidth(), spec.width)
	-- its other parts moved once
	local offset = config.postal_offsets.PostalOpenAllButton
	lu.assertEquals(select(5, _G.PostalOpenAllButton:GetPoint()), -10 + offset[2])
	frame:Hide()
	frame:Show()
	lu.assertEquals(select(5, _G.PostalOpenAllButton:GetPoint()), -10 + offset[2])
	lu.assertEquals(select(4, _G.PostalInboxCB3:GetPoint()), config.postal_offsets.PostalInboxCB[1])
	-- the address book's arrow right of the To box's plate, as the letter shows
	_G.SendMailFrame:Show()
	local band = config.send_band
	lu.assertEquals({ _G.Postal_BlackBookButton:GetPoint() },
		{ "LEFT", _G.SendMailNameEditBox, "RIGHT", client.Engine:GetDB("Blizzard").window.edit_padding + band.arrow_gap, 0 })
	assertClean(client)
end

-- The trade skills and the class trainer ------------------------------------------------

TestTradeSkill = {}

function TestTradeSkill:tearDown()
	client = nil
end

-- A tailor's recipes: a header, one of each difficulty, the first with
-- two reagents (one short, one an uncommon item).
local function recipes(world)
	world.spells.Tailoring = { name = "Tailoring", icon = [[Interface\Icons\Trade_Tailoring]] }
	local cloth = "|cff1eff00|Hitem:200:0:0:0|h[Frostweave]|h|r"
	world.itemInfo[200] = { name = "Frostweave", quality = 2, iLevel = 70 }
	world.tradeSkill.recipes = {
		{ name = "Cloth", kind = "header", expanded = true },
		{ name = "Frostwoven Belt", kind = "optimal", available = 2, reagents = {
			{ name = "Thread", need = 2, have = 0 }, { name = "Frostweave", link = cloth, need = 1, have = 5 } } },
		{ name = "Frostwoven Boots", kind = "medium" },
		{ name = "Frostwoven Cowl", kind = "easy" },
		{ name = "Linen Bandage", kind = "trivial" },
	}
end

function TestTradeSkill:test_the_recipes_and_their_reagents_in_ink()
	boot({ world = recipes })
	client.api.LoadAddOn("Blizzard_TradeSkillUI")
	local module = client:GetModule("Blizzard: Trade Skill")
	local config = client.Engine:GetDB("Blizzard").tradeskill
	local ink = client.Engine:GetDB("Blizzard").window.ink
	local frame = _G.TradeSkillFrame
	frame:Show()
	-- the search at the band's left end (as the window first updates),
	-- Have Materials right of it, both over the band
	local search, filter = _G.TradeSkillFrameEditBox, _G.TradeSkillFrameAvailableFilterCheckButton
	_G.TradeSkillFrame_Update()
	lu.assertEquals((select(2, search:GetPoint())), _G.TradeSkillFrameTitleText.DiabolicHeader)
	lu.assertEquals(search:GetWidth(), config.search_width)
	lu.assertEquals({ filter:GetPoint() }, { "LEFT", search, "RIGHT", config.filter_gap, 0 })
	lu.assertEquals(search:GetFrameLevel(), frame:GetFrameLevel() + 2)
	-- Blizzard's "Search" pale until something's typed
	local book = client.Engine:GetDB("Blizzard").spellbook
	search:SetText(_G.SEARCH)
	near(color(search:GetTextColor()), book.search_hint_color)
	search:SetText("belt")
	lu.assertNotEquals(color(search:GetTextColor())[1], book.search_hint_color[1])
	-- the reagents' plates gone, the chosen one's detail lower
	lu.assertEquals(_G.TradeSkillReagent1NameFrame:GetAlpha(), 0)
	lu.assertEquals({ _G.TradeSkillDetailScrollFrame:GetPoint() }, { "TOPLEFT", frame, "TOPLEFT", config.detail[1], config.detail[2] })
	lu.assertEquals(_G.TradeSkillDetailScrollFrame:GetHeight(), config.detail_height)

	-- the recipes in their difficulty's ink, the chosen one too, no shadows
	client.world.tradeSkill.selected = 3
	_G.TradeSkillFrame_Update()
	near(color(_G.TradeSkillSkill1:GetFontString():GetTextColor()), config.inks.header)
	near(color(_G.TradeSkillSkill2:GetFontString():GetTextColor()), config.inks.optimal)
	near(color(_G.TradeSkillSkill2Count:GetVertexColor()), config.inks.optimal)
	near(color(_G.TradeSkillSkill3:GetFontString():GetTextColor()), config.inks.medium)
	near(color(_G.TradeSkillSkill5:GetFontString():GetTextColor()), config.inks.trivial)
	lu.assertEquals(select(4, _G.TradeSkillSkill2:GetFontString():GetShadowColor()), 0)
	-- (an empty row left alone)
	lu.assertFalse(shown(_G.TradeSkillSkill6))
	-- the profession's icon in the title plate's ring
	lu.assertTrue(shown(module.Gem))
	lu.assertEquals(module.Gem.icon:GetTexture(), [[Interface\Icons\Trade_Tailoring]])
	-- (one with no spell of its name: none)
	client.world.tradeSkill.name = "Mystery"
	client.world.unknownSpells = { Mystery = true }
	_G.TradeSkillFrame_Update()
	lu.assertFalse(shown(module.Gem))

	-- a recipe chosen: its reagents in ink, red ink for those short, the
	-- uncommon one framed in its color; "Reagents:" closer to the description
	_G.TradeSkillFrame_SetSelection(2)
	near(color(_G.TradeSkillReagentLabel:GetTextColor()), ink)
	near(color(_G.TradeSkillReagent1Name:GetTextColor()), config.missing_color)
	near(color(_G.TradeSkillReagent2Name:GetTextColor()), ink)
	local icon = _G.TradeSkillReagent2IconTexture
	lu.assertTrue(shown(icon.DiabolicBorder))
	near(color(icon.DiabolicBorder:GetVertexColor()), client.Engine:GetDB("Data: Colors").Quality[2])
	lu.assertFalse(shown(_G.TradeSkillReagent1IconTexture.DiabolicBorder))
	lu.assertEquals(select(5, _G.TradeSkillReagentLabel:GetPoint()), -config.reagents_label_gap)
	-- (none chosen: the frames kept)
	_G.TradeSkillFrame_SetSelection(nil)
	assertClean(client)
end

function TestTradeSkill:test_the_requirement_short_of_auctionators_scan()
	boot({ world = recipes })
	client.api.LoadAddOn("Blizzard_TradeSkillUI")
	local config = client.Engine:GetDB("Blizzard").tradeskill
	local frame = _G.TradeSkillFrame
	frame:Show()
	-- no Scan AH: left as it is
	local text, description = _G.TradeSkillRequirementText, _G.TradeSkillDescription
	local width = text:GetWidth()
	_G.TradeSkillFrame_SetSelection(2)
	lu.assertEquals(text:GetWidth(), width)
	-- Auctionator's, right of the requirement: the requirement short of it,
	-- the description under both
	local scan = _G.CreateFrame("Button", "Auctionator_Search", _G.TradeSkillDetailScrollChildFrame)
	scan:SetSize(80, 60)
	scan:SetPoint("TOPRIGHT", _G.TradeSkillDetailScrollChildFrame, "TOPRIGHT", 0, 0)
	_G.TradeSkillFrame_SetSelection(2)
	lu.assertEquals(text:GetWidth(), math.max(1, scan:GetLeft() - text:GetLeft() - config.scan_gap))
	-- the recipe's name short of it, once the window shows again
	frame:Hide()
	frame:Show()
	lu.assertEquals(_G.TradeSkillSkillName:GetWidth(), 146)
	local point, relative, _, x = description:GetPoint()
	lu.assertEquals({ point, relative, x }, { "TOPLEFT", _G.TradeSkillDetailScrollChildFrame, config.description_left })
	lu.assertTrue(-select(5, description:GetPoint()) >= config.description_top)
	assertClean(client)
end

function TestTradeSkill:test_loaded_before_us_and_not_without_the_skin()
	boot({ world = function(world, c)
		recipes(world)
		c.api.LoadAddOn("Blizzard_TradeSkillUI")
	end })
	lu.assertEquals(_G.TradeSkillFrameEditBox:GetWidth(), client.Engine:GetDB("Blizzard").tradeskill.search_width)
	assertClean(client)
	-- Blizzard's own windows: left alone
	boot({ savedVariables = { DiabolicUI_DB = { Windows = { profiles = { global = { enableSkin = false } } } } } })
	client.api.LoadAddOn("Blizzard_TradeSkillUI")
	lu.assertEquals(_G.TradeSkillFrameEditBox:GetWidth(), 128)
	assertClean(client)
end

function TestTradeSkill:test_the_gem_waits_for_the_band()
	boot({ world = recipes })
	client.api.LoadAddOn("Blizzard_TradeSkillUI")
	local module = client:GetModule("Blizzard: Trade Skill")
	local header = _G.TradeSkillFrameTitleText.DiabolicHeader
	_G.TradeSkillFrameTitleText.DiabolicHeader = nil
	module:UpdateGem()
	lu.assertNil(module.Gem)
	_G.TradeSkillFrameTitleText.DiabolicHeader = header
	module:UpdateGem()
	lu.assertNotNil(module.Gem)
	assertClean(client)
end

TestTrainer = {}

function TestTrainer:tearDown()
	client = nil
end

local function services(world)
	world.trainer.services = {
		{ name = "Fire", kind = "header", expanded = true },
		{ name = "Fireball", subText = "Rank 2", kind = "available",
			requirements = "Requires: |cffffffffLevel 6|r, |cffff2020Fireball (Rank 1)|r" },
		{ name = "Pyroblast", subText = "Rank 1", kind = "unavailable", requirements = "Requires: |cffff2020Level 20|r" },
		{ name = "Scorch", subText = "Rank 1", kind = "used" },
	}
end

function TestTrainer:test_the_trainings_in_ink()
	boot({ world = services })
	client.api.LoadAddOn("Blizzard_TrainerUI")
	local config = client.Engine:GetDB("Blizzard").trainer
	local ink = client.Engine:GetDB("Blizzard").window.ink
	local frame = _G.ClassTrainerFrame
	frame:Show()
	-- the trainer's words in the middle of a dark panel
	lu.assertEquals(_G.ClassTrainerGreetingText:GetJustifyH(), "CENTER")
	lu.assertEquals(_G.ClassTrainerGreetingText:GetJustifyV(), "MIDDLE")
	-- the trainings in their kind's ink, the chosen one too (and what
	-- Blizzard sets back as the mouse leaves), the header too when chosen
	client.world.trainer.selected = 2
	_G.ClassTrainerFrame_Update()
	near(color(_G.ClassTrainerSkill1:GetFontString():GetTextColor()), config.inks.header)
	near(color(_G.ClassTrainerSkill2:GetFontString():GetTextColor()), config.inks.available)
	near(color(_G.ClassTrainerSkill2SubText:GetTextColor()), config.inks.available)
	near(color(_G.ClassTrainerSkill3:GetFontString():GetTextColor()), config.inks.unavailable)
	near({ _G.ClassTrainerSkill3.r, _G.ClassTrainerSkill3.g, _G.ClassTrainerSkill3.b }, config.inks.unavailable)
	near(color(_G.ClassTrainerSkill4SubText:GetTextColor()), config.inks.used)
	client.world.trainer.selected = 1
	_G.ClassTrainerFrame_Update()
	near(color(_G.ClassTrainerSkill1:GetFontString():GetTextColor()), config.inks.header)
	-- under the mouse in black ink
	client:Hover(_G.ClassTrainerSkill3)
	near(color(_G.ClassTrainerSkill3SubText:GetTextColor()), config.hover_color)
	client:Leave()
	-- the chosen one's requirements in ink, those not met in red ink; its cost in ink
	_G.ClassTrainer_SetSelection(2)
	local function code(c)
		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	end
	lu.assertEquals(_G.ClassTrainerSkillRequirements:GetText(),
		"Requires: " .. code(ink) .. "Level 6|r, " .. code(config.missing_color) .. "Fireball (Rank 1)|r")
	near(color(_G.ClassTrainerDetailMoneyFrameGoldButton:GetFontString():GetTextColor()), ink)
	-- (none: nothing to ink)
	_G.ClassTrainerSkillRequirements:SetText(nil)
	client:GetModule("Blizzard: Trainer"):InkDetails()
	-- the chosen one's page shorter than Blizzard's, for a profession's trainer too
	lu.assertEquals(_G.ClassTrainerDetailScrollFrame:GetHeight(), 119 - config.detail_trim)
	client.world.trainer.tradeskill = true
	_G.ClassTrainerFrame_Update()
	lu.assertEquals(_G.ClassTrainerDetailScrollFrame:GetHeight(), 135 - config.detail_trim)
	assertClean(client)
end

function TestTrainer:test_loaded_before_us_and_not_without_the_skin()
	boot({ world = function(world, c)
		services(world)
		c.api.LoadAddOn("Blizzard_TrainerUI")
	end })
	lu.assertEquals(_G.ClassTrainerGreetingText:GetJustifyV(), "MIDDLE")
	assertClean(client)
	boot({ savedVariables = { DiabolicUI_DB = { Windows = { profiles = { global = { enableSkin = false } } } } } })
	client.api.LoadAddOn("Blizzard_TrainerUI")
	lu.assertNil(_G.DiabolicUITrainerHover)
	assertClean(client)
end

-- The windows' kit ------------------------------------------------------------------

TestWindowKit = {}

function TestWindowKit:tearDown()
	client = nil
end

function TestWindowKit:test_blizzards_own_windows_when_its_off()
	boot({ savedVariables = { DiabolicUI_DB = { Windows = { profiles = { global = { enableSkin = false } } } } } })
	for _, addon in ipairs({ "Blizzard_TalentUI", "Blizzard_GlyphUI", "Blizzard_AchievementUI", "Blizzard_MacroUI" }) do
		client.api.LoadAddOn(addon)
	end
	for _, name in ipairs({ "QuestLogFrame", "MerchantFrame", "FriendsFrame", "SpellBookFrame", "LFDParentFrame",
		"PlayerTalentFrame", "MacroFrame", "AchievementFrame", "CharacterFrame" }) do
		lu.assertNil(_G[name].DiabolicPanel, name)
	end
	assertClean(client)
end

function TestWindowKit:test_the_stack_split_and_coins_boxes()
	boot()
	local spec = client.Engine:GetDB("Blizzard").stacksplit
	-- both on Diablo III's stone in our iron
	for _, frame in ipairs({ _G.StackSplitFrame, _G.CoinPickupFrame }) do
		lu.assertEquals(frame:GetWidth(), spec.panel[3] * spec.scale + spec.border * 2)
	end
	-- the coins' sum left of its coin, the pair in the middle of the black field
	local text = _G.CoinPickupText
	local x = spec.border + spec.text[1] * spec.scale - (spec.coin_size + spec.coin_gap) / 2
	lu.assertEquals({ text:GetPoint() }, { "CENTER", _G.CoinPickupFrame, "TOPLEFT", x, -spec.border + spec.text[2] * spec.scale })
	for _, kind in ipairs({ "Gold", "Silver", "Copper" }) do
		local coin = _G["CoinPickup" .. kind .. "Icon"]
		lu.assertEquals(coin:GetWidth(), spec.coin_size)
		lu.assertEquals({ coin:GetPoint() }, { "LEFT", text, "RIGHT", spec.coin_gap, 0 })
	end
	assertClean(client)
end

-- A frame of `name` at a whole place, its window, band and buttons
-- (UIPanelButtonTemplate's) at `places` ({ x, y, width } from its bottom left).
local function kitFrame(name, places)
	local kit = client:GetModule("Blizzard: Windows")
	local frame = _G.CreateFrame("Frame", name, _G.UIParent)
	frame:SetSize(400, 300)
	frame:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 100, -100)
	local window = kit:CreateWindow(frame, { 0, 0, 0, 0 })
	local buttons = {}
	for i, place in ipairs(places or {}) do
		local b = _G.CreateFrame("Button", name .. "Button" .. i, frame, place[5] or "UIPanelButtonTemplate")
		b:SetNormalTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		b:SetSize(place[3], 22)
		b:SetPoint(place[4] or "BOTTOMLEFT", frame, place[4] or "BOTTOMLEFT", place[1], place[2])
		buttons[i] = b
	end
	frame:Hide()
	return frame, window, buttons
end

function TestWindowKit:test_buttons_on_a_row_spread_apart()
	boot()
	local kit = client:GetModule("Blizzard: Windows")
	local gap = kit.config.layout.button_gap
	-- three touching at the bottom left, two 2 apart at the top right, two
	-- one over the other, one apart enough
	local frame, _, buttons = kitFrame("RowFrame", {
		{ 20, 20, 80 }, { 100, 20, 80 }, { 180, 20, 80 },
		{ -102, -50, 80, "TOPRIGHT" }, { -20, -50, 80, "TOPRIGHT" },
		{ 20, 120, 80 }, { 30, 121, 80 },
		{ 300, 20, 60 },
	})
	kit:StyleButtons(frame)
	frame:Show()
	client:Tick(0.05)
	-- as wide in all, gap apart, each from the frame's nearer corner
	local a, b, c = buttons[1], buttons[2], buttons[3]
	lu.assertAlmostEquals(b:GetLeft() - a:GetRight(), gap, 1e-6)
	lu.assertAlmostEquals(c:GetLeft() - b:GetRight(), gap, 1e-6)
	lu.assertAlmostEquals(c:GetRight() - a:GetLeft(), 240, 1e-6)
	lu.assertEquals((a:GetPoint()), "BOTTOMLEFT")
	lu.assertAlmostEquals(buttons[5]:GetLeft() - buttons[4]:GetRight(), gap, 1e-6)
	lu.assertEquals((buttons[5]:GetPoint()), "TOPRIGHT")
	-- one over another, and one apart enough: left alone
	lu.assertEquals(buttons[6]:GetWidth(), 80)
	lu.assertEquals(buttons[8]:GetWidth(), 60)
	assertClean(client)
end

function TestWindowKit:test_rows_left_alone_in_a_fight_or_too_narrow()
	boot()
	local kit = client:GetModule("Blizzard: Windows")
	-- secure ones in a fight
	local frame, _, buttons = kitFrame("SecureRows", { { 20, 20, 80, nil, "UIPanelButtonTemplate,SecureActionButtonTemplate" }, { 100, 20, 80 } })
	kit:StyleButtons(frame)
	client:EnterCombat()
	frame:Show()
	client:Tick(0.05)
	lu.assertEquals(buttons[1]:GetWidth(), 80)
	client:LeaveCombat()
	-- too narrow to fit their gap
	frame, _, buttons = kitFrame("NarrowRows", { { 20, 20, 2 }, { 22, 20, 2 } })
	kit:StyleButtons(frame)
	frame:Show()
	client:Tick(0.05)
	lu.assertEquals(buttons[1]:GetWidth(), 2)
	-- (hidden again before the next frame: not lined up)
	frame:Hide()
	kit:StyleButtons(frame)
	client:Tick(0.05)
	assertClean(client)
end

function TestWindowKit:test_the_kits_other_parts()
	boot()
	local kit = client:GetModule("Blizzard: Windows")
	local frame, window = kitFrame("KitFrame")
	-- a painted background, then tiles instead
	kit:SetBackground(window, "zoltun")
	kit:SetBackground(window, "smoke")
	lu.assertTrue(shown(window.DiabolicBackground))
	kit:SetBackground(window, "slabs")
	lu.assertFalse(shown(window.DiabolicBackground))
	-- a bar kept orange
	local bar = _G.CreateFrame("StatusBar", nil, frame)
	kit:StyleBar(bar)
	bar:SetStatusBarColor(0, 0, 1)
	near(color(bar:GetStatusBarColor()), kit.config.bar.color)
	-- a tab sized to its text, its text kept in place
	local tab = _G.CreateFrame("Button", "KitFrameTab1", frame)
	tab:SetText("Things")
	kit:StyleTab(tab, { padding = 10, inset = 2 })
	lu.assertEquals(tab:GetWidth(), tab:GetFontString():GetStringWidth() + 14)
	tab:GetFontString():SetPoint("LEFT", tab, "LEFT", 50, 0)
	lu.assertNotEquals(select(4, tab:GetFontString():GetPoint()), 50)
	-- banners: a WoW icon's, round; the name under it on hover (not over a
	-- tooltip of its own); none shown, no rail
	local header = kit:CreateHeader(window, 40, { 24, 24 })
	local banner = _G.CreateFrame("Button", "KitFrameTab2", frame)
	banner:SetText("Fire")
	kit:HangTabs(window, { banner }, { [[Interface\Icons\Spell_Fire_FlameBolt]] })
	lu.assertEquals(banner.DiabolicBanner.sigil:GetTexture(), [[Interface\Icons\Spell_Fire_FlameBolt]])
	lu.assertNil(banner.DiabolicBanner.gold)
	client:Hover(banner)
	lu.assertTrue(_G.GameTooltip:IsOwned(banner) == 1)
	kit:ShowBannerName(banner)
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	frame:Show()
	banner:Hide()
	lu.assertFalse(shown(window.DiabolicRail))
	-- the window's top lowered with its cover
	local cover = kit:CreateCover(window, { 10, 10, 10, 10 }, 2)
	kit:DropTop(window)
	lu.assertEquals(select(5, cover:GetPoint()), -10)
	-- a band's parts from its right end
	local first, second = frame:CreateFontString(), frame:CreateFontString()
	first:SetText("One")
	second:SetText("Two")
	kit:LineBand(header, { first, second }, true)
	lu.assertEquals({ second:GetPoint() }, { "RIGHT", header, "RIGHT", -kit.config.layout.band_right_edge, 0 })
	lu.assertEquals((select(2, first:GetPoint())), second)
	-- an edit box's hint gone as it's typed in
	local box = _G.CreateFrame("EditBox", nil, frame)
	kit:AddHint(box, "Name")
	local hint = select(1, box:GetRegions())
	lu.assertTrue(shown(hint))
	client:RunScript(box, "OnEditFocusGained")
	lu.assertFalse(shown(hint))
	assertClean(client)
end

function TestWindowKit:test_dragged_as_blizzards_frame_is()
	boot()
	local dragged
	_G.QuestLogFrame:SetScript("OnDragStart", function(frame) dragged = frame end)
	client:RunScript(client:GetModule("Blizzard: Quest Log").Window, "OnDragStart")
	lu.assertEquals(dragged, _G.QuestLogFrame)
	assertClean(client)
end

function TestWindowKit:test_a_long_title_cut_short_in_the_band()
	boot()
	local title = _G.QuestFrameNpcNameText
	title:SetText("Archmage Celindra the Unbelievably Long-Winded Keeper of the Violet Citadel's Lesser Archives")
	local width = title:GetWidth()
	lu.assertTrue(width > 0)
	lu.assertTrue(width < title:GetStringWidth())
	-- a short one as wide as its text
	title:SetText("Hogger")
	lu.assertEquals(title:GetWidth(), title:GetStringWidth())
	assertClean(client)
end

function TestWindowKit:test_a_disabled_buttons_text_greyed()
	boot({ world = function(world)
		_G.QuestLogFrameAbandonButton:Disable()
	end })
	local config = client.Engine:GetDB("Blizzard").window
	near(color(_G.QuestLogFrameAbandonButton:GetFontString():GetTextColor()), config.button_disabled_color)
	assertClean(client)
end

function TestWindowKit:test_money_frames_coins_ours()
	boot()
	local coin = client.Engine:GetDB("UI").coin
	-- a money frame's coins, by its name or itself
	local money = _G.CreateFrame("Frame", "TestMoneyFrame", _G.UIParent)
	for _, kind in ipairs({ "Gold", "Silver", "Copper" }) do
		local button = _G.CreateFrame("Button", "TestMoneyFrame" .. kind .. "Button", money)
		button:SetNormalTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
	end
	_G.MoneyFrame_Update("TestMoneyFrame", 12345)
	lu.assertEquals(_G.TestMoneyFrameGoldButton:GetNormalTexture():GetTexture(), coin.gold_texture)
	_G.MoneyFrame_Update(money, 12345)
	lu.assertEquals(_G.TestMoneyFrameCopperButton:GetNormalTexture():GetTexture(), coin.copper_texture)
	assertClean(client)
end

function TestWindowKit:test_a_zone_of_a_material_in_nine_slices()
	boot()
	local kit = client:GetModule("Blizzard: Windows")
	local window = client.Engine:GetDB("Blizzard").window
	local list = _G.CreateFrame("Frame", nil, _G.UIParent)
	local zone = kit:AddZone(list, "slate", { 6, 6, 28, 6 })
	lu.assertEquals({ zone:GetPoint(1) }, { "TOPLEFT", list, "TOPLEFT", -6, 6 })
	lu.assertEquals(#zone.Material, 9)
	local spec = window.materials.slate
	local edge = spec.border * window.material_scale
	-- its corner at its own size, its middle from the edges in
	local corner, middle = zone.Material[1], zone.Material[5]
	lu.assertEquals(corner:GetTexture(), spec.texture)
	lu.assertEquals({ corner:GetPoint(1) }, { "TOPLEFT", zone, "TOPLEFT", 0, 0 })
	lu.assertEquals({ corner:GetPoint(2) }, { "BOTTOMRIGHT", zone, "TOPLEFT", edge, -edge })
	lu.assertEquals({ middle:GetPoint(1) }, { "TOPLEFT", zone, "TOPLEFT", edge, -edge })
	lu.assertEquals({ middle:GetPoint(2) }, { "BOTTOMRIGHT", zone, "BOTTOMRIGHT", -edge, edge })
	assertClean(client)
end

function TestWindowKit:test_the_chosen_row_in_an_orange_box()
	boot()
	local kit = client:GetModule("Blizzard: Windows")
	local highlight = _G.UIParent:CreateTexture(nil, "ARTWORK")
	highlight:SetSize(200, 16)
	highlight:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 10, -10)
	kit:LightRow(highlight)
	-- a line along each of its edges, shown with it
	local box = highlight.DiabolicBox
	lu.assertEquals(#box, 4)
	lu.assertEquals(box[1]:GetWidth(), 200)
	lu.assertEquals(box[3]:GetHeight(), 16)
	highlight:Hide()
	for _, line in ipairs(box) do
		lu.assertNotEquals(line:IsShown(), 1)
	end
	highlight:Show()
	lu.assertEquals(box[2]:IsShown(), 1)
	-- Blizzard's tint by the row's kind: its own colours kept
	highlight:SetVertexColor(1, .5, .25)
	near({ highlight:GetVertexColor() }, { 1, 1, 1 })
	assertClean(client)
end

-- AdiBags ----------------------------------------------------------------------------

TestAdiBags = {}

function TestAdiBags:tearDown()
	client = nil
end

-- AdiBags' classes as the skin uses them: its bags' frames (made as they
-- first show), their buttons.
local function adiBags(world)
	table.insert(world.addons, { name = "AdiBags", enabled = true, onLoad = function()
		local addon = _G.LibStub("AceAddon-3.0"):NewAddon("AdiBags")
		local classes = { Container = { prototype = {} }, ItemButton = { prototype = {} } }
		local container, button = classes.Container.prototype, classes.ItemButton.prototype
		container.UpdateSkin = function(frame) frame:SetBackdrop({ bgFile = "AdiBags" }) end
		container.OnShow = function() end
		button.UpdateBorder = function() end
		addon.GetClass = function(_, name) return classes[name] end
		-- the backpack's frame made, the bank's not yet
		local function bag(name, isBank)
			local frame = _G.CreateFrame("Frame", name, _G.UIParent)
			frame:SetBackdrop({ bgFile = "AdiBags" })
			frame.isBank = isBank
			frame.CloseButton = _G.CreateFrame("Button", nil, frame)
			frame.Title = frame:CreateFontString(nil, "ARTWORK")
			local slots = _G.CreateFrame("Frame", nil, frame)
			slots.Title = slots:CreateFontString(nil, "ARTWORK")
			frame.BagSlotPanel = slots
			return frame
		end
		local backpack = { frame = bag("AdiBagsContainer1") }
		local bank = {}
		backpack.HasFrame = function(self) return self.frame ~= nil end
		backpack.GetFrame = function(self) return self.frame end
		bank.HasFrame = backpack.HasFrame
		addon.IterateBags = function() return ipairs({ backpack, bank }) end
		addon.Bank = bank
		addon.MakeBank = function()
			bank.frame = bag("AdiBagsContainer2", true)
			container.OnShow(bank.frame)
			return bank.frame
		end
		addon.MakeButton = function(name, bagID, slot)
			local item = _G.CreateFrame("Button", name, backpack.frame)
			item:SetID(slot)
			item.bag = bagID
			item:CreateTexture(name .. "NormalTexture")
			item:CreateTexture(name .. "IconTexture")
			item:CreateTexture(name .. "IconQuestTexture")
			button.UpdateBorder(item)
			return item
		end
	end })
end

function TestAdiBags:test_its_bags_in_our_windows()
	boot({ world = adiBags })
	client.api.LoadAddOn("AdiBags")
	local AdiBags = _G.LibStub("AceAddon-3.0"):GetAddon("AdiBags")
	local backpack = _G.AdiBagsContainer1
	-- our stone, its backdrop gone (and kept gone)
	lu.assertNotNil(backpack.DiabolicWindow)
	lu.assertNil(backpack:GetBackdrop())
	AdiBags:GetClass("Container").prototype.UpdateSkin(backpack)
	lu.assertNil(backpack:GetBackdrop())
	-- the equipped bags over it, in a panel
	local config = client.Engine:GetDB("Blizzard").adibags
	lu.assertEquals({ backpack.BagSlotPanel:GetPoint() },
		{ "BOTTOMLEFT", backpack, "TOPLEFT", -config.insets[1], config.insets[2] + config.panel_gap })
	backpack.BagSlotPanel:Show()
	backpack:Show()
	-- the bank once it's made, in smoke; styled once
	local bank = AdiBags.MakeBank()
	local window = bank.DiabolicWindow
	lu.assertNotNil(window)
	AdiBags:GetClass("Container").prototype.OnShow(bank)
	lu.assertEquals(bank.DiabolicWindow, window)
	-- a frame not ours keeps its backdrop
	local other = _G.CreateFrame("Frame")
	other:SetBackdrop({ bgFile = "AdiBags" })
	AdiBags:GetClass("Container").prototype.UpdateSkin(other)
	lu.assertNotNil(other:GetBackdrop())
	-- its slots ours: the quality border
	client.world.containers[0] = { size = 16, items = { [1] = { quality = 4 } } }
	local item = AdiBags.MakeButton("AdiBagsItemButton1", 0, 1)
	lu.assertEquals(_G.AdiBagsItemButton1NormalTexture:GetAlpha(), 0)
	AdiBags:GetClass("ItemButton").prototype.UpdateBorder(item)
	-- an item in it: its icon cut inside the frame again (AdiBags shows it whole)
	local icon = _G.AdiBagsItemButton1IconTexture
	icon:SetTexCoord(0, 1, 0, 1)
	item.texture = [[Interface\Icons\INV_Sword_04]]
	AdiBags:GetClass("ItemButton").prototype.UpdateBorder(item)
	lu.assertAlmostEquals(({ icon:GetTexCoord() })[1], 5 / 64, 1e-6)
	assertClean(client)
end

function TestAdiBags:test_loaded_before_us()
	-- (once our files, and the libraries in them, have loaded)
	client = Client.boot({ world = adiBags, login = false })
	client.api.LoadAddOn("AdiBags")
	client:Login()
	lu.assertNotNil(_G.AdiBagsContainer1.DiabolicWindow)
	assertClean(client)
end

function TestAdiBags:test_another_addon_by_its_name()
	-- (AdiBags in the addon list, not made as an AceAddon)
	boot({ world = function(world)
		table.insert(world.addons, { name = "AdiBags", enabled = true })
	end })
	client.api.LoadAddOn("AdiBags")
	assertClean(client)
end

-- Group Bulletin Board ---------------------------------------------------------------

TestBulletinBoard = {}

function TestBulletinBoard:tearDown()
	client = nil
end

local function bulletinBoard(world)
	table.insert(world.addons, { name = "GroupBulletinBoard", enabled = true, onLoad = function()
		local frame = _G.CreateFrame("Frame", "GroupBulletinBoardFrame", _G.UIParent)
		frame:SetSize(500, 400)
		frame:CreateTexture(nil, "BACKGROUND")
		frame:CreateFontString("GroupBulletinBoardFrameTitle", "ARTWORK"):SetText("GroupBulletinBoard")
		_G.CreateFrame("Button", "GroupBulletinBoardFrameCloseButton", frame)
		_G.CreateFrame("Button", "GroupBulletinBoardFrameSettingsButton", frame)
		_G.CreateFrame("ScrollFrame", "GroupBulletinBoardFrame_ScrollFrame", frame)
	end })
end

function TestBulletinBoard:test_its_window_ours()
	boot({ world = bulletinBoard })
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	client.api.LoadAddOn("GroupBulletinBoard")
	local config = client.Engine:GetDB("Blizzard").bulletin_board
	local close, settings = _G.GroupBulletinBoardFrameCloseButton, _G.GroupBulletinBoardFrameSettingsButton
	-- its settings left of the windows' X
	lu.assertEquals({ settings:GetPoint() }, { "RIGHT", close, "LEFT", -config.button_gap, 0 })
	lu.assertEquals(settings:GetFrameLevel(), close:GetFrameLevel())
	assertClean(client)
end

function TestBulletinBoard:test_loaded_before_us()
	boot({ world = function(world, c)
		bulletinBoard(world)
		c.api.LoadAddOn("GroupBulletinBoard")
	end })
	lu.assertEquals(_G.GroupBulletinBoardFrameSettingsButton:GetFrameLevel(),
		_G.GroupBulletinBoardFrameCloseButton:GetFrameLevel())
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
