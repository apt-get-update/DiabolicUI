-- Run from the addon root: lua5.1 tests/test_session_blizzard.lua
--
-- The restyled Blizzard frames in the fake client: the loot window, the
-- bag and bank slots, the tinted panels, the Escape menu, the mirror
-- timers, the durability and vehicle seat anchors, the fonts and combat
-- text, and the popups.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client, C

local function boot(options)
	client = Client.boot(options)
	C = client.Engine:GetDB("Data: Colors")
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

local function color(...)
	local r, g, b = ...
	return { r, g, b }
end

local function near(actual, expected, message)
	for i = 1, 3 do
		lu.assertAlmostEquals(actual[i], expected[i], 1e-6, message)
	end
end

-- The loot window --------------------------------------------------------------

TestLootWindow = {}

local SKIN = { DiabolicUI_DB = { LootFrame = { profiles = { global = { enableSkin = true } } } } }

function TestLootWindow:tearDown()
	client, C = nil, nil
end

local function openLoot(items)
	client.world.loot = items
	client:FireEvent("LOOT_OPENED", 0)
end

function TestLootWindow:test_off_by_default()
	boot()
	lu.assertNil(_G.DiabolicLootFrame)
	-- Blizzard's window still handles the loot
	lu.assertEquals(_G.LootFrame:IsEventRegistered("LOOT_OPENED"), 1)
	assertClean(client)
end

function TestLootWindow:test_shows_the_loot_in_rows()
	boot({ savedVariables = SKIN })
	local frame = _G.DiabolicLootFrame
	openLoot({
		{ name = "Linen Cloth", quantity = 3, quality = 1 },
		{ name = "12 Copper", quantity = 0, isCoin = true },
		{ name = "Sword of the Very Long Name", quality = 4 },
	})
	lu.assertTrue(shown(frame))
	lu.assertFalse(shown(_G.LootFrame))
	local module = client:GetModule("Blizzard: LootFrame")
	local rows = module.rows
	lu.assertEquals(#rows, 3)
	lu.assertEquals(rows[1].text:GetText(), "Linen Cloth")
	lu.assertEquals(_G.DiabolicLootButton1Count:GetText(), "3")
	near(color(rows[2].text:GetTextColor()), C.General.Title, "coins")
	near(color(rows[3].text:GetTextColor()), color(_G.GetItemQualityColor(4)), "epic")
	-- stacked, all as wide as the longest name needs
	lu.assertEquals({ rows[2]:GetPoint() }, { "TOPLEFT", rows[1], "BOTTOMLEFT", 0, -module.config.row.gap })
	lu.assertEquals(rows[1]:GetWidth(), rows[3]:GetWidth())
	lu.assertTrue(frame:GetWidth() >= rows[1]:GetWidth())
	-- Escape closes it
	local special
	for _, name in ipairs(_G.UISpecialFrames) do
		if name == "DiabolicLootFrame" then special = true end
	end
	lu.assertTrue(special)
	assertClean(client)
end

function TestLootWindow:test_hovering_and_clicking_a_row()
	boot({ savedVariables = SKIN })
	local wool = Session.item(client, 2592, { name = "Wool Cloth" })
	openLoot({ { name = "Linen Cloth" }, { name = "Wool Cloth", link = wool } })
	local row = client:GetModule("Blizzard: LootFrame").rows[2]
	client:Hover(row)
	lu.assertTrue(shown(_G.GameTooltip))
	lu.assertTrue(shown(row.highlight))
	lu.assertFalse(shown(row.normal))
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	lu.assertFalse(shown(row.highlight))
	lu.assertTrue(shown(row.normal))
	client:Click(row)
	lu.assertEquals(client.world.looted, 2)
	assertClean(client)
end

function TestLootWindow:test_rows_go_as_items_are_looted()
	boot({ savedVariables = SKIN })
	local frame = _G.DiabolicLootFrame
	openLoot({ { name = "Linen Cloth" }, { name = "Wool Cloth" } })
	local rows = client:GetModule("Blizzard: LootFrame").rows
	client.world.loot[1].looted = true
	client:FireEvent("LOOT_SLOT_CLEARED", 1)
	lu.assertTrue(shown(rows[1]))
	lu.assertFalse(shown(rows[2]))
	lu.assertEquals(rows[1]:GetID(), 2)
	lu.assertEquals(rows[1].text:GetText(), "Wool Cloth")

	-- the last one: the window closes, and so does the looting
	client.world.loot[2].looted = true
	client:FireEvent("LOOT_SLOT_CLEARED", 2)
	lu.assertFalse(shown(frame))
	lu.assertTrue(client.world.lootClosed)
	assertClean(client)
end

function TestLootWindow:test_closing()
	boot({ savedVariables = SKIN })
	local frame = _G.DiabolicLootFrame
	openLoot({ { name = "Linen Cloth" } })
	client:FireEvent("LOOT_CLOSED")
	lu.assertFalse(shown(frame))

	-- the close button
	openLoot({ { name = "Linen Cloth" } })
	client.world.lootClosed = nil
	local close
	for _, child in ipairs({ frame:GetChildren() }) do
		if not child:GetName() then
			close = child -- the rows have names
		end
	end
	client:Click(close)
	lu.assertTrue(client.world.lootClosed)
	assertClean(client)
end

-- Bags and bank -------------------------------------------------------------------

TestBags = {}

function TestBags:tearDown()
	client, C = nil, nil
end

-- Our border on an item slot: the ARTWORK quick slot texture.
local function borderOf(button)
	for _, region in ipairs({ button:GetRegions() }) do
		if region:GetObjectType() == "Texture" and region:GetDrawLayer() == "ARTWORK"
			and region:GetTexture() == [[Interface\Buttons\UI-Quickslot2]] then
			return region
		end
	end
end

function TestBags:test_every_bag_and_the_bank_get_our_slots()
	boot()
	for _, name in ipairs({ "ContainerFrame1Item1", "ContainerFrame2Item1", "ContainerFrame5Item36",
		"ContainerFrame13Item7", "BankFrameItem1", "BankFrameItem28" }) do
		lu.assertEquals(_G[name .. "NormalTexture"]:GetAlpha(), 0, name)
		lu.assertNotNil(borderOf(_G[name]), name)
	end
	-- the bank's bag slots aren't item slots
	lu.assertNil(borderOf(_G.BankFrameBag1))
	assertClean(client)
end

function TestBags:test_slots_show_quality_quests_junk_and_item_levels()
	boot()
	local epic = Session.item(client, 100, { quality = 4, iLevel = 213, equipSlot = "INVTYPE_WEAPON" })
	local cloth = Session.item(client, 101, { quality = 1, iLevel = 20, equipSlot = "" })
	client.world.containers[0] = { size = 6, items = {
		[1] = { quality = 4, link = epic },
		[2] = { quality = 0 },
		[3] = { quality = 1, questId = 123, isActive = false },
		[4] = { quality = 1, isQuestItem = true },
		[5] = { quality = 1, link = cloth },
	} }
	local bag = _G.ContainerFrame1
	bag:SetID(0)
	bag.size = 6
	_G.ContainerFrame_Update(bag)

	local function slot(i) return _G["ContainerFrame1Item" .. i] end
	near(color(borderOf(slot(1)):GetVertexColor()), C.Quality[4], "epic")
	near(color(borderOf(slot(2)):GetVertexColor()), C.General.UIBorder, "junk")
	near(color(borderOf(slot(3)):GetVertexColor()), C.General.Gold, "quest starter")
	near(color(borderOf(slot(4)):GetVertexColor()), C.General.Gold, "quest item")
	near(color(borderOf(slot(6)):GetVertexColor()), C.General.UIBorder, "empty")
	lu.assertTrue(shown(borderOf(slot(6))))

	-- junk is greyed out
	lu.assertEquals(_G.ContainerFrame1Item2IconTexture:IsDesaturated(), 1)
	lu.assertNil(_G.ContainerFrame1Item1IconTexture:IsDesaturated())

	-- the quest starter's "!" shrinks, the quest item's border goes
	lu.assertEquals({ _G.ContainerFrame1Item3IconQuestTexture:GetPoint(1) }, { "TOPLEFT", slot(3), "TOPLEFT", 6, -6 })
	lu.assertFalse(shown(_G.ContainerFrame1Item4IconQuestTexture))

	-- item levels on gear only
	local function itemLevelOf(button)
		for _, child in ipairs({ button:GetChildren() }) do
			for _, region in ipairs({ child:GetRegions() }) do
				if region:GetObjectType() == "FontString" then return region end
			end
		end
	end
	lu.assertEquals(itemLevelOf(slot(1)):GetText(), "213")
	lu.assertEquals(itemLevelOf(slot(5)):GetText(), "")

	-- the epic is gone: no item level left behind
	client.world.containers[0].items[1] = nil
	_G.ContainerFrame_Update(bag)
	lu.assertEquals(itemLevelOf(slot(1)):GetText(), "")
	lu.assertNil(itemLevelOf(slot(6)))
	assertClean(client)
end

function TestBags:test_bank_slots_read_the_bank()
	boot()
	client.world.containers[0] = { size = 16, items = { [1] = { quality = 4 } } }
	client.world.containers[-1] = { size = 28, items = { [1] = { quality = 3 } } }
	_G.BankFrameItemButton_Update(_G.BankFrameItem1)
	near(color(borderOf(_G.BankFrameItem1):GetVertexColor()), C.Quality[3])
	-- the bank's bags go through the same update
	_G.BankFrameItemButton_Update(_G.BankFrameBag1)
	assertClean(client)
end

-- Tinted panels -----------------------------------------------------------------------

TestStyling = {}

function TestStyling:tearDown()
	client, C = nil, nil
end

function TestStyling:test_panels_get_our_colors()
	boot()
	near(color(_G.CharacterFramePortrait:GetVertexColor()), C.General.UIBackdrop)
	near(color(_G.CharacterNameText:GetTextColor()), C.General.Title)
	-- the find group button keeps its text color
	local r, g, b = _G.LFDQueueFrameFindGroupButtonText:GetTextColor()
	lu.assertNotEquals({ r, g, b }, C.General.Title)
	assertClean(client)
end

function TestStyling:test_bags_are_left_to_bag_addons()
	boot({ world = function(world)
		table.insert(world.addons, { name = "Backpacker", enabled = true })
	end })
	lu.assertNil(client:GetModule("Blizzard: Containers"):IsEnabled())
	assertClean(client)
end

-- The Escape menu -----------------------------------------------------------------------

TestGameMenu = {}

function TestGameMenu:setUp()
	self.addons = function(world)
		table.insert(world.addons, { name = "MoveAnything", enabled = true, onLoad = function()
			local b = CreateFrame("Button", "GameMenuButtonMoveAnything", _G.GameMenuFrame, "UIPanelButtonTemplate")
			b:SetText("MoveAnything")
		end })
		table.insert(world.addons, { name = "ACP", enabled = true, onLoad = function()
			local b = CreateFrame("Button", "GameMenuButtonAddOns", _G.GameMenuFrame, "UIPanelButtonTemplate")
			b:SetText("AddOns")
			b:SetScript("OnShow", function() b.movedByACP = true end)
		end })
	end
end

function TestGameMenu:tearDown()
	client, C = nil, nil
end

function TestGameMenu:test_buttons_are_restyled_and_centered()
	boot()
	local menu = client:GetModule("Blizzard: GameMenu")
	local options = _G.GameMenuButtonOptions
	lu.assertEquals(options.text.normal:GetText(), _G.VIDEOOPTIONS_MENU)
	lu.assertEquals(options:GetFontString():GetAlpha(), 0)
	lu.assertEquals(options.normal:GetAlpha(), 1)
	lu.assertEquals(options.highlight:GetAlpha(), 0)
	-- stacked from the first one down, the Korean ratings and mac buttons left out
	lu.assertEquals({ _G.GameMenuButtonSoundOptions:GetPoint() },
		{ "TOPLEFT", options, "BOTTOMLEFT", 0, -menu.config.button_spacing })
	lu.assertEquals(select(2, _G.GameMenuButtonLogout:GetPoint()), _G.GameMenuButtonMacros)
	lu.assertNil(_G.GameMenuButtonMacOptions:IsVisible())
	-- centered
	local center = client.Engine:GetFrame()
	local top, bottom = options:GetTop(), _G.GameMenuButtonContinue:GetBottom()
	lu.assertAlmostEquals(center:GetTop() - top, bottom - center:GetBottom(), 0.5)
	-- a bare window
	lu.assertNil(_G.GameMenuFrame:IsMouseEnabled())
	lu.assertEquals(_G.GameMenuFrameHeaderText:GetText(), "")
	assertClean(client)
end

function TestGameMenu:test_buttons_light_up_and_press()
	boot()
	local button = _G.GameMenuButtonLogout
	client:Hover(button)
	lu.assertEquals(button.highlight:GetAlpha(), 1)
	lu.assertEquals(button.normal:GetAlpha(), 0)
	client:RunScript(button, "OnMouseDown", "LeftButton")
	lu.assertEquals(button.pushed:GetAlpha(), 1)
	lu.assertEquals(button.text.pushed:GetAlpha(), 1)
	lu.assertEquals(select(5, button.text.pushed:GetPoint()), -4)
	-- dragged off while held
	client:Leave()
	lu.assertEquals(button.highlight:GetAlpha(), 1)
	lu.assertEquals(button.pushed:GetAlpha(), 0)
	client:RunScript(button, "OnMouseUp", "LeftButton")
	lu.assertEquals(button.normal:GetAlpha(), 1)
	lu.assertEquals(select(5, button.text.normal:GetPoint()), 0)
	-- reopening resets it
	button.isDown = true
	_G.GameMenuFrame:Show()
	button:Hide()
	button:Show()
	lu.assertFalse(button.isDown)
	assertClean(client)
end

function TestGameMenu:test_addon_buttons_are_styled_once_their_addons_load()
	boot({ world = self.addons })
	local menu = client:GetModule("Blizzard: GameMenu")
	lu.assertTrue(menu.looking_for_addons)
	client.api.LoadAddOn("MoveAnything")
	local moveAnything = _G.GameMenuButtonMoveAnything
	lu.assertEquals(moveAnything.text.normal:GetText(), "MoveAnything")
	lu.assertEquals(select(2, _G.GameMenuButtonMacros:GetPoint()), moveAnything)
	lu.assertTrue(menu.looking_for_addons)

	client.api.LoadAddOn("ACP")
	lu.assertEquals(_G.GameMenuButtonAddOns.text.normal:GetText(), "AddOns")
	_G.GameMenuButtonAddOns:Hide()
	_G.GameMenuButtonAddOns:Show()
	lu.assertNil(_G.GameMenuButtonAddOns.movedByACP)
	lu.assertNil(menu.looking_for_addons)
	assertClean(client)
end

function TestGameMenu:test_the_mac_options_on_a_mac()
	boot({ world = function() _G.IsMacClient = function() return 1 end end })
	local mac = _G.GameMenuButtonMacOptions
	lu.assertEquals(mac.text.normal:GetText(), _G.MAC_OPTIONS)
	lu.assertEquals(select(2, mac:GetPoint()), _G.GameMenuButtonUIOptions)
	assertClean(client)
end

function TestGameMenu:test_the_layout_follows_screen_changes()
	boot()
	local options = _G.GameMenuButtonOptions
	options:ClearAllPoints()
	client:FireEvent("UI_SCALE_CHANGED")
	lu.assertEquals(options:GetNumPoints(), 1)
	options:ClearAllPoints()
	client:Click(_G.VideoOptionsFrameApply)
	lu.assertEquals(options:GetNumPoints(), 1)
	options:ClearAllPoints()
	client:Click(_G.VideoOptionsFrameOkay)
	lu.assertEquals(options:GetNumPoints(), 1)
	-- not in combat: once it's over
	client:EnterCombat()
	options:ClearAllPoints()
	client:FireEvent("DISPLAY_SIZE_CHANGED")
	lu.assertEquals(options:GetNumPoints(), 0)
	client:LeaveCombat()
	lu.assertEquals(options:GetNumPoints(), 1)
	assertClean(client)
end

-- Mirror timers --------------------------------------------------------------------------

TestMirrorTimers = {}

function TestMirrorTimers:setUp()
	boot()
	self.config = client.Engine:GetDB("Blizzard").mirrortimers
end

function TestMirrorTimers:tearDown()
	client, C = nil, nil
	self.config = nil
end

function TestMirrorTimers:test_timers_are_restyled_and_stacked()
	local config = self.config
	_G.MirrorTimer_Show("BREATH", 60000, 60000, -1, 0, "Breath")
	local breath = _G.MirrorTimer1
	lu.assertTrue(shown(breath))
	lu.assertEquals(_G.MirrorTimer1StatusBar:GetStatusBarTexture():GetTexture(), config.statusbar_texture)
	near(color(_G.MirrorTimer1StatusBar:GetStatusBarColor()), C.Timer.BREATH)
	lu.assertEquals(select(5, breath:GetPoint()), config.position[5])

	-- the bar's texture is cropped, not squeezed
	_G.MirrorTimer1StatusBar:SetValue(30)
	local left, _, _, _, right = _G.MirrorTimer1StatusBar:GetStatusBarTexture():GetTexCoord()
	lu.assertEquals({ left, right }, { 0, 0.5 })

	_G.MirrorTimer_Show("EXHAUSTION", 30000, 60000, -1, 0, "Fatigue")
	local fatigue = _G.MirrorTimer2
	lu.assertEquals({ fatigue:GetPoint() }, { "CENTER", breath, "CENTER", 0, -config.padding })

	-- a capture bar takes the first spot
	local captureBars = client:GetModule("CaptureBars")
	captureBars:SendMessage("ENGINE_CAPTUREBAR_VISIBLE", 1)
	lu.assertEquals(select(5, breath:GetPoint()), config.positionOffsetByOne[5])
	captureBars:SendMessage("ENGINE_CAPTUREBAR_HIDDEN")
	lu.assertEquals(select(5, breath:GetPoint()), config.position[5])

	-- out of the water: fatigue moves up
	breath:Hide()
	lu.assertEquals(select(5, fatigue:GetPoint()), config.position[5])
	assertClean(client)
end

-- Anchors ---------------------------------------------------------------------------------

TestAnchors = {}

function TestAnchors:tearDown()
	client, C = nil, nil
end

function TestAnchors:test_blizzard_cant_move_them_back()
	boot()
	for _, name in ipairs({ "DurabilityFrame", "VehicleSeatIndicator" }) do
		local frame = _G[name]
		local _, holder = frame:GetPoint()
		lu.assertEquals(select(1, frame:GetPoint()), "BOTTOM", name)
		frame:SetPoint("TOPRIGHT", _G.UIParent, "TOPRIGHT", -40, -200)
		lu.assertEquals(frame:GetNumPoints(), 1, name)
		lu.assertEquals({ frame:GetPoint() }, { "BOTTOM", holder, "BOTTOM", 0, 0 }, name)
	end
	assertClean(client)
end

function TestAnchors:test_frames_mappy_took_over_are_taken_back()
	boot({ world = function(world)
		table.insert(world.addons, { name = "Mappy", enabled = true })
	end })
	lu.assertTrue(_G.DurabilityFrame.Mappy_DidHook)
	lu.assertTrue(_G.VehicleSeatIndicator.Mappy_DidHook)
	assertClean(client)
end

-- Fonts and combat text -------------------------------------------------------------------

TestFonts = {}

function TestFonts:tearDown()
	client, C = nil, nil
end

function TestFonts:test_blizzard_fonts_use_ours()
	boot()
	local fonts = client.Engine:GetDB("Fonts").fonts
	local face, size = _G.QuestFont_Large:GetFont()
	lu.assertEquals(face, fonts.header_normal.path)
	lu.assertEquals(size, 14)
	lu.assertEquals({ _G.CombatTextFont:GetShadowOffset() }, { -2.5, -2.5 })
	lu.assertEquals(_G.STANDARD_TEXT_FONT, fonts.text_normal.path)
	assertClean(client)
end

function TestFonts:test_fonts_without_the_locales_letters_are_kept()
	boot({ world = function(world) world.locale = "zhCN" end })
	local fonts = client.Engine:GetDB("Fonts").fonts
	local face = _G.QuestFont_Large:GetFont()
	lu.assertNotEquals(face, fonts.header_normal.path)
	assertClean(client)
end

function TestFonts:test_combat_text_once_it_loads()
	boot()
	client.api.LoadAddOn("Blizzard_CombatText")
	lu.assertEquals(_G.COMBAT_TEXT_HEIGHT, 8)
	_G.CombatText_UpdateDisplayedMessages()
	lu.assertEquals(_G.COMBAT_TEXT_LOCATIONS.startY, 220)
	lu.assertEquals(_G.COMBAT_TEXT_LOCATIONS.endY, 440)
	assertClean(client)
end

-- Popups -----------------------------------------------------------------------------------

TestPopups = {}

function TestPopups:tearDown()
	client, C = nil, nil
end

function TestPopups:test_popups_get_our_frames()
	boot()
	local config = client.Engine:GetDB("UI").popup
	-- Blizzard's input border is gone
	for _, region in ipairs({ _G.StaticPopup1EditBox:GetRegions() }) do
		if region:GetObjectType() == "Texture" then
			lu.assertNil(region:GetTexture())
		end
	end
	lu.assertNotNil(_G.StaticPopup1EditBox:GetBackdrop())
	-- the buttons light up
	local button = _G.StaticPopup1Button1
	near(color(button:GetBackdropColor()), config.footer.button.backdropColor)
	client:Hover(button)
	near(color(button:GetBackdropColor()), config.footer.button.backdropColor_hover)
	client:Leave()
	near(color(button:GetBackdropColor()), config.footer.button.backdropColor)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
