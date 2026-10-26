-- Run from the addon root: lua5.1 tests/test_session_windows.lua
--
-- Blizzard's windows in Diablo III's look (modules/blizzard/windows.lua and
-- the windows built on it) in the fake client: the spellbook and its
-- companions' pages, the social window, the quest log, the talents and
-- glyphs, the other panels (Auctionator's pages too), and the bag and
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
	-- the school's icon in the medallion
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
	-- Blizzard's shown ones, then ours, side by side under the window's
	-- foot, centred; the chosen one off
	local window = spells.DiabolicWindow
	local critters, mounts = module.Tabs[1], module.Tabs[2]
	lu.assertTrue(shown(critters))
	local function row(...)
		local tabs = { ... }
		local left = -(#tabs * banner.width + (#tabs - 1) * banner.gap) / 2
		for i, tab in ipairs(tabs) do
			lu.assertEquals({ tab:GetPoint() }, { "TOPLEFT", window, "BOTTOM", left + (i - 1) * (banner.width + banner.gap), banner.tuck })
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

-- Auctionator's parts of the auction house, made as it shows.
local function auctionator(world)
	table.insert(world.addons, { name = "Auctionator", enabled = true, onLoad = function()
		local main = _G.CreateFrame("Frame", "Atr_Main_Panel", _G.AuctionFrame)
		local row = _G.CreateFrame("Button", "Atr_Buy1_Button", main)
		row:SetPoint("BOTTOMLEFT", main, "BOTTOMLEFT", 10, 20)
		_G.CreateFrame("Frame", "Atr_Hlist", main):SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background" })
		_G.CreateFrame("Frame", "Atr_SellControls", main):Hide()
		main:CreateFontString("AuctionatorTitle", "ARTWORK")
		local dropdown = _G.CreateFrame("Frame", "Atr_Duration", main)
		dropdown:SetWidth(40)
		_G.CreateFrame("Button", "Atr_DurationButton", dropdown)
		dropdown:CreateTexture("Atr_DurationMiddle"):SetWidth(100)
		_G.CreateFrame("Button", "Atr_ListTabsTab1", main)
	end })
end

function TestPanels:test_the_auction_house_with_auctionator()
	boot({ world = auctionator })
	client.api.LoadAddOn("Blizzard_AuctionUI")
	client.api.LoadAddOn("Auctionator")
	local frame = _G.AuctionFrame
	lu.assertTrue(frame.DiabolicPanel)
	-- its pages' rows from their headers, left of their lists
	frame:Show()
	lu.assertEquals(_G.AuctionatorTitle:GetAlpha(), 0)
	lu.assertTrue(_G.Atr_Hlist.DiabolicPanel)
	lu.assertNil(_G.Atr_Hlist:GetBackdrop())
	lu.assertTrue(_G.Atr_Duration.DiabolicPlate)
	lu.assertNotNil(_G.Atr_ListTabsTab1.DiabolicArt)
	-- the bottom rows lower, once
	lu.assertEquals({ _G.Atr_Buy1_Button:GetPoint() }, { "BOTTOMLEFT", _G.Atr_Main_Panel, "BOTTOMLEFT", 10, 6 })
	frame:Hide()
	frame:Show()
	lu.assertEquals(select(5, _G.Atr_Buy1_Button:GetPoint()), 6)
	-- its sell column's panel with it
	_G.Atr_SellControls:Show()
	_G.Atr_SellControls:Hide()
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

-- The windows' kit ------------------------------------------------------------------

TestWindowKit = {}

function TestWindowKit:tearDown()
	client = nil
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

function TestWindowKit:test_the_chosen_row_on_the_copper_bar()
	boot()
	local kit = client:GetModule("Blizzard: Windows")
	local window = client.Engine:GetDB("Blizzard").window
	local highlight = _G.UIParent:CreateTexture(nil, "ARTWORK")
	kit:LightRow(highlight)
	lu.assertEquals(highlight:GetTexture(), window.row_bars.lit)
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
