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

-- The quality glow on an item button: its color at the bottom, or nil
-- while it's hidden.
local function glowOf(button)
	for _, region in ipairs({ button:GetRegions() }) do
		if region:GetObjectType() == "Texture" and region:GetBlendMode() == "ADD"
			and region:GetTexture() == [[Interface\ChatFrame\ChatFrameBackground]] then
			local gradient = client.widgetState[region].gradient
			return shown(region) and { gradient[2], gradient[3], gradient[4] } or nil
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

	-- the quality glow: on the epic, not on junk, quest items or empty slots
	near(glowOf(slot(1)), C.Quality[4], "epic glow")
	lu.assertNil(glowOf(slot(2)), "junk")
	lu.assertNil(glowOf(slot(4)), "quest item")
	lu.assertNil(glowOf(slot(6)), "empty")

	-- junk is greyed out
	lu.assertEquals(_G.ContainerFrame1Item2IconTexture:IsDesaturated(), 1)
	lu.assertNil(_G.ContainerFrame1Item1IconTexture:IsDesaturated())

	-- the quest starter's "!" shrinks, the quest item's border goes
	lu.assertEquals({ _G.ContainerFrame1Item3IconQuestTexture:GetPoint(1) }, { "TOPLEFT", slot(3), "TOPLEFT", 6, -6 })
	lu.assertFalse(shown(_G.ContainerFrame1Item4IconQuestTexture))

	-- no item levels on the slots
	for _, button in ipairs({ slot(1), slot(5) }) do
		for _, child in ipairs({ button:GetChildren() }) do
			for _, region in ipairs({ child:GetRegions() }) do
				lu.assertNotEquals(region:GetObjectType(), "FontString")
			end
		end
	end
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
	-- (the character's name is the window's: in the band's pale gold)
	near(color(_G.CharacterNameText:GetTextColor()), client.Engine:GetDB("Blizzard").window.band_title.color)
	-- the find group button keeps its text color
	local r, g, b = _G.LFDQueueFrameFindGroupButtonText:GetTextColor()
	lu.assertNotEquals({ r, g, b }, C.General.Title)
	assertClean(client)
end

function TestStyling:test_talents_and_professions_once_loaded()
	boot()
	lu.assertNil(_G.PlayerTalentFrame)
	client.api.LoadAddOn("Blizzard_TalentUI")
	-- our window: Blizzard's frame art out of sight, the title in the band
	local talents = client:GetModule("Blizzard: Talents")
	lu.assertNotNil(talents.Window)
	lu.assertEquals(_G.PlayerTalentFrameTopLeft:GetAlpha(), 0)
	lu.assertEquals(_G.PlayerTalentFrameTitleText:GetParent(), talents.Header)
	-- the talents' icons keep their colors
	near(color(_G.PlayerTalentFrameTalent1IconTexture:GetVertexColor()), { 1, 1, 1 })
	-- other addons are none of its business
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	client.api.LoadAddOn("Blizzard_TradeSkillUI")
	lu.assertTrue(_G.TradeSkillFrame.DiabolicPanel)
	near(color(_G.TradeSkillSkillIconIconTexture:GetVertexColor()), { 1, 1, 1 })
	assertClean(client)
end

function TestStyling:test_bags_are_left_to_bag_addons()
	boot({ world = function(world)
		table.insert(world.addons, { name = "Backpacker", enabled = true })
	end })
	lu.assertNil(client:GetModule("Blizzard: Containers"):IsEnabled())
	assertClean(client)
end


-- The character window ---------------------------------------------------------------

TestCharacter = {}

function TestCharacter:tearDown()
	client, C = nil, nil
end

-- The textures of a frame's own drawing `file`, by their alphas.
local function alphasOf(frame, file)
	local alphas = {}
	for _, region in ipairs({ frame:GetRegions() }) do
		if region:IsObjectType("Texture") and (region:GetTexture() or ""):find(file, 1, true) then
			alphas[#alphas + 1] = region:GetAlpha()
		end
	end
	return alphas
end

function TestCharacter:test_our_window_on_every_tab()
	boot()
	local config = client.Engine:GetDB("Blizzard").character
	local window = client.Engine:GetDB("Blizzard").window
	local module = client:GetModule("Blizzard: Character")
	local frame = _G.CharacterFrame

	-- the stone window where the panel art was, under the tabs' frames, its
	-- iron frame over the band; wide for the character tab's two columns
	local backdrop = module.Backdrop
	lu.assertEquals(backdrop.Border:GetBackdrop().edgeFile, window.backdrop.edgeFile)
	lu.assertTrue(backdrop.Border:GetFrameLevel() > module.Header:GetFrameLevel())
	lu.assertEquals(backdrop:GetFrameLevel(), frame:GetFrameLevel())
	local insets, wide = config.insets, config.paperdoll.wide_insets
	lu.assertEquals({ backdrop:GetPoint(1) }, { "TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2] })
	lu.assertEquals({ backdrop:GetPoint(2) }, { "BOTTOMRIGHT", frame, "BOTTOMRIGHT", wide[3], -wide[4] })
	-- Blizzard told the width, for the window opened next to it
	lu.assertEquals(frame:GetAttribute("UIPanelLayout-width"), frame:GetWidth() + wide[3])

	-- every tab's panel art out of sight
	lu.assertEquals(alphasOf(_G.PaperDollFrame, "UI-Character-CharacterTab-"), { 0, 0, 0, 0 })
	lu.assertEquals(alphasOf(_G.ReputationFrame, "UI-Character-General-"), { 0, 0, 0, 0 })
	lu.assertEquals(alphasOf(_G.PetPaperDollFrame, "UI-PetPaperDollFrame-"), { 0, 0, 0, 0 })
	lu.assertEquals(alphasOf(_G.SkillFrame, "SkillFrame-Bot"), { 0, 0 })
	-- the other tabs' own "Close" buttons gone: the window has one
	lu.assertFalse(shown(_G.SkillFrameCancelButton))
	frame:Show()
	_G.SkillFrame:Show()
	_G.SkillFrameCancelButton:Show()
	lu.assertFalse(shown(_G.SkillFrameCancelButton))
	_G.SkillFrame:Hide()
	frame:Hide()
	-- the currency tab, once it loads: its buttons too
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	client.api.LoadAddOn("Blizzard_TokenUI")
	lu.assertEquals(alphasOf(_G.TokenFrame, "UI-TalentFrame-"), { 0, 0, 0, 0 })
	lu.assertFalse(shown(_G.TokenFrameCancelButton))
	for _, child in ipairs({ _G.TokenFrame:GetChildren() }) do
		if child:IsObjectType("Button") then
			lu.assertFalse(shown(child))
		end
	end

	-- no round portrait; the name in the band, centred clear of the
	-- medallion at its left end; the close button in its socket in the
	-- window's corner
	lu.assertEquals(_G.CharacterFramePortrait:GetAlpha(), 0)
	lu.assertEquals(_G.CharacterNameText:GetParent(), module.Header)
	near(color(_G.CharacterNameText:GetTextColor()), window.band_title.color)
	lu.assertEquals({ _G.CharacterNameText:GetPoint() }, { "CENTER", module.Header, "CENTER", 0, 0 })
	lu.assertEquals({ module.Medallion:GetPoint() }, { "LEFT", module.Header, "LEFT", window.medallion.offset, 0 })
	local socket = window.close.socket_size
	lu.assertEquals({ _G.CharacterFrameCloseButton:GetPoint() }, { "CENTER", backdrop, "TOPRIGHT", -socket / 2, -socket / 2 })
	lu.assertEquals(_G.CharacterFrameCloseButton:GetNormalTexture():GetTexture(), window.close.texture.normal)
	-- the band's glass and the stone in tiles, laid again at a new size
	frame:Show()
	local band, stone = module.Header.DiabolicBand, backdrop.DiabolicStone
	lu.assertTrue(#band > 0)
	lu.assertTrue(#stone > 0)
	client:RunScript(module.Header, "OnSizeChanged")
	client:RunScript(backdrop, "OnSizeChanged")
	lu.assertTrue(shown(band[1]))
	lu.assertTrue(shown(stone[1]))
	frame:Hide()
	-- the ammo slot in the action buttons' border instead of its frame art
	lu.assertEquals(alphasOf(_G.CharacterAmmoSlot, "UI-Character-AmmoSlot"), { 0 })

	-- the tabs: the chosen one red, the others dark, in a row under the band
	local first, second = _G.CharacterFrameTab1, _G.CharacterFrameTab2
	lu.assertEquals({ first:GetPoint() }, { "TOPLEFT", module.Header, "BOTTOMLEFT", unpack(config.tab_offset) })
	lu.assertEquals(_G.CharacterFrameTab1Left:GetAlpha(), 0)
	_G.PanelTemplates_SetTab(frame, 1)
	lu.assertTrue(shown(first.DiabolicArt.red[2]))
	lu.assertFalse(shown(first.DiabolicArt.dark[2]))
	lu.assertTrue(shown(second.DiabolicArt.dark[2]))
	lu.assertEquals(first.DiabolicArt.red[2]:GetTexture(), window.rect_button.texture.lit)
	_G.PanelTemplates_SetTab(frame, 2)
	lu.assertFalse(shown(first.DiabolicArt.red[2]))
	lu.assertTrue(shown(second.DiabolicArt.red[2]))

	-- another tab: the window narrow again, Blizzard told
	frame:Show()
	local updates = client.panelUpdates or 0
	_G.PaperDollFrame:Hide()
	lu.assertEquals({ backdrop:GetPoint(2) }, { "BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4] })
	lu.assertEquals(frame:GetAttribute("UIPanelLayout-width"), frame:GetWidth() + insets[3])
	lu.assertEquals(client.panelUpdates, updates + 1)

	-- the pet tab: its name in the band, its own tabs in a row in its middle
	_G.PetPaperDollFrame:Show()
	lu.assertEquals(_G.PetNameText:GetParent(), module.Header)
	local pet, companions, mounts = _G.PetPaperDollFrameTab1, _G.PetPaperDollFrameTab2, _G.PetPaperDollFrameTab3
	local spec = config.companion
	-- (gone: the companions and mounts are the spellbook's tabs)
	_G.PetPaperDollFrame_UpdateTabs()
	for _, tab in ipairs({ pet, companions, mounts }) do
		lu.assertFalse(shown(tab))
	end
	-- shown again (by another addon): in a row in its middle
	companions:Show()
	mounts:Show()
	module:CenterPetTabs()
	local width = companions:GetWidth() + mounts:GetWidth() + spec.tab_gap
	lu.assertEquals({ companions:GetPoint() }, { "TOPLEFT", _G.PetPaperDollFrame, "TOP", spec.tab_position[1] - width / 2, spec.tab_position[2] })
	lu.assertEquals({ mounts:GetPoint() }, { "LEFT", companions, "RIGHT", spec.tab_gap, 0 })
	-- none shown, none placed
	companions:Hide()
	mounts:Hide()
	module:CenterPetTabs()
	lu.assertEquals({ mounts:GetPoint() }, { "LEFT", companions, "RIGHT", spec.tab_gap, 0 })
	assertClean(client)
end

function TestCharacter:test_the_currency_tab_loaded_before_us()
	boot({ world = function(world, c)
		c.api.LoadAddOn("Blizzard_TokenUI")
	end })
	lu.assertEquals(alphasOf(_G.TokenFrame, "UI-TalentFrame-"), { 0, 0, 0, 0 })
	lu.assertFalse(shown(_G.TokenFrameCancelButton))
	assertClean(client)
end

function TestCharacter:test_the_gear_column()
	boot()
	local config = client.Engine:GetDB("Blizzard").character
	local layout = config.paperdoll
	local module = client:GetModule("Blizzard: Character")
	-- the slots in two columns in the gear's column, the model between them
	local pane = module.GearPane
	lu.assertEquals(pane:GetWidth(), layout.pane_width)
	lu.assertEquals({ _G.CharacterHeadSlot:GetPoint() }, { "TOPLEFT", pane, "TOPLEFT", layout.slot_margin, layout.slot_top })
	lu.assertEquals({ _G.CharacterNeckSlot:GetPoint() }, { "TOP", _G.CharacterHeadSlot, "BOTTOM", 0, -layout.slot_gap })
	lu.assertEquals({ _G.CharacterHandsSlot:GetPoint() }, { "TOPRIGHT", pane, "TOPRIGHT", -layout.slot_margin, layout.slot_top })
	-- (its frame past its panel's top and bottom: the character larger
	-- and lower in it, as the dressing room's)
	local reach = layout.model_reach
	lu.assertEquals({ _G.CharacterModelFrame:GetSize() }, { layout.model_size[1], layout.model_size[2] + reach[1] + reach[2] })
	-- the weapons in a row under the model's panel
	local main, off, ranged = _G.CharacterMainHandSlot, _G.CharacterSecondaryHandSlot, _G.CharacterRangedSlot
	local point, panel, relative, x, y = off:GetPoint()
	lu.assertEquals({ point, relative, x, y }, { "TOP", "BOTTOM", 0, layout.weapon_top })
	lu.assertEquals(panel:GetBackdrop(), client.Engine:GetDB("Blizzard").window.panel.backdrop)
	lu.assertEquals({ main:GetPoint() }, { "TOPRIGHT", off, "TOPLEFT", -layout.weapon_gap, 0 })
	lu.assertEquals({ ranged:GetPoint() }, { "TOPLEFT", off, "TOPRIGHT", layout.weapon_gap, 0 })
	-- Blizzard's stat columns out of sight for good
	lu.assertFalse(shown(_G.CharacterAttributesFrame))
	_G.CharacterFrame:Show()
	_G.CharacterAttributesFrame:Show()
	lu.assertFalse(shown(_G.CharacterAttributesFrame))
	-- the title picker dark
	near(color(_G.PlayerTitlePickerFrame:GetBackdropColor()), config.popup_color)
	assertClean(client)
end

function TestCharacter:test_the_right_column()
	boot()
	local module = client:GetModule("Blizzard: Character")
	local gearScore = client:GetModule("Blizzard: GearScore")
	-- the GearScore, big in its color, the item level under it: a
	-- two-hander of 232 alone is 2 slots' worth, the average over 16 slots
	client.world.inventory[16] = Session.item(client, 3016, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_2HWEAPON" })
	client.world.inventory[1] = Session.item(client, 3001, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_HEAD" })
	_G.CharacterFrame:Show()
	lu.assertEquals(module.Score:GetText(), "1207")
	near(color(module.Score:GetTextColor()), color(gearScore:GetColor(1207)))
	lu.assertEquals(module.ItemLevel:GetText(), "Item Level 29")
	-- a change of gear
	client.world.inventory[1] = nil
	client:FireEvent("PLAYER_EQUIPMENT_CHANGED", 1)
	lu.assertEquals(module.Score:GetText(), "805")
	-- not while the tab is hidden, nor for gear not known yet
	_G.CharacterFrame:Hide()
	client.world.inventory[1] = Session.item(client, 3001, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_HEAD" })
	client:FireEvent("PLAYER_EQUIPMENT_CHANGED", 1)
	lu.assertEquals(module.Score:GetText(), "805")
	client.world.units.player.inventoryTextures = { [5] = "Interface\\Icons\\Chest" }
	_G.CharacterFrame:Show()
	lu.assertEquals(module.Score:GetText(), "805")
	client.world.units.player.inventoryTextures = nil

	-- two groups of stats, Blizzard's choice, Blizzard's lines
	local first, second = _G.DiabolicUICharacterStats11Label, _G.DiabolicUICharacterStats21Label
	lu.assertEquals(first:GetText(), "PLAYERSTAT_BASE_STATS 1")
	lu.assertEquals(second:GetText(), "PLAYERSTAT_MELEE_COMBAT 1")
	-- a click on a title bar shows the next group, the last the first
	local point, header = _G.DiabolicUICharacterStats21:GetPoint()
	lu.assertEquals(header.title:GetText(), "Melee")
	client:Click(header)
	lu.assertEquals(client.api.GetCVar("playerStatRightDropdown"), "PLAYERSTAT_RANGED_COMBAT")
	lu.assertEquals(header.title:GetText(), "Ranged")
	lu.assertEquals(second:GetText(), "PLAYERSTAT_RANGED_COMBAT 1")
	client.api.SetCVar("playerStatRightDropdown", "PLAYERSTAT_DEFENSES")
	client:Click(header)
	lu.assertEquals(header.title:GetText(), "Base Stats")
	-- none chosen yet: left alone
	client.api.SetCVar("playerStatRightDropdown", "")
	_G.PaperDollFrame_UpdateStats()
	lu.assertEquals(header.title:GetText(), "Base Stats")
	assertClean(client)
end

function TestCharacter:test_the_equipment_manager()
	boot({ world = function(world)
		world.equipmentSets = { { "Holy", "Interface\\Icons\\Holy" }, { "Shadow", "Interface\\Icons\\Shadow" } }
	end })
	local config = client.Engine:GetDB("Blizzard").character.paperdoll.gear_manager
	local module = client:GetModule("Blizzard: Character")
	local dialog = _G.GearManagerDialog
	-- in the right column, its frame and Blizzard's button gone, open a
	-- frame after the tab (Blizzard closes it as a child window then)
	lu.assertFalse(shown(_G.GearManagerToggleButton))
	lu.assertFalse(shown(_G.GearManagerDialogClose))
	lu.assertEquals(_G.GearManagerDialogTopLeft:GetAlpha(), 0)
	_G.CharacterFrame:Show()
	-- (on the column's sets page, not with the stats)
	client:Tick(0.1)
	lu.assertFalse(shown(dialog))
	client:Click(_G.DiabolicUICharacterSideTab3)
	_G.CloseChildWindows()
	lu.assertFalse(shown(dialog))
	client:Tick(0.1)
	lu.assertTrue(shown(dialog))

	-- the sets in rows (`config.rows` in each), scaled to fit the title
	-- bar's width
	local sets = dialog.buttons
	local widest = math.max(unpack(config.rows))
	local row = widest * 36 + (widest - 1) * config.set_gap
	local scale = math.min(1, module.GearHeader:GetWidth() / row)
	lu.assertAlmostEquals(sets[1]:GetScale(), scale, 1e-6)
	lu.assertEquals({ sets[2]:GetPoint() }, { "LEFT", sets[1], "RIGHT", config.set_gap, 0 })
	lu.assertEquals({ sets[config.rows[1] + 1]:GetPoint() }, { "TOP", sets[1], "BOTTOM", 0, -config.row_gap })
	-- not before its sets have a size: tried again the next frames
	sets[1]:SetWidth(0)
	_G.CloseChildWindows()
	client:Tick(0.1)
	lu.assertTrue(shown(dialog))
	lu.assertNil(module:LayoutSets())
	sets[1]:SetWidth(36)
	client:Tick(0.1)
	lu.assertTrue(module:LayoutSets())

	-- equip, save and delete as icons in a column right of the shorter
	-- rows, their text in a tooltip
	local equip, save, delete = _G.GearManagerDialogEquipSet, _G.GearManagerDialogSaveSet, _G.GearManagerDialogDeleteSet
	local point, relative, relativePoint = equip:GetPoint()
	lu.assertEquals({ point, relative, relativePoint }, { "TOP", module.GearHeader, "BOTTOMLEFT" })
	lu.assertEquals({ save:GetPoint() }, { "TOP", equip, "BOTTOM", 0, -config.action_gap })
	lu.assertEquals(equip:GetText(), "")
	client:Hover(equip)
	lu.assertEquals(_G.GameTooltipTextLeft1:GetText(), "Equip")
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	-- faded until a set is chosen
	local icon
	for _, region in ipairs({ equip:GetRegions() }) do
		if region:IsObjectType("Texture") and (region:GetTexture() == config.icons) then
			icon = region
		end
	end
	lu.assertEquals(icon:GetAlpha(), .4)
	client:Click(sets[2])
	lu.assertEquals(icon:GetAlpha(), 1)

	-- the first free set a "+": a click names a new one, no set chosen
	local free = sets[3]
	lu.assertTrue(free.DiabolicNew)
	lu.assertEquals(free:IsEnabled(), 1)
	lu.assertEquals(free.icon:GetTexture(), config.icons)
	lu.assertEquals(select(5, free.icon:GetTexCoord()), .25)
	client:Hover(free)
	lu.assertEquals(_G.GameTooltipTextLeft1:GetText(), "New Equipment Set")
	client:Leave()
	client:Click(free)
	lu.assertNil(dialog.selectedSetName)
	lu.assertTrue(shown(_G.GearManagerDialogPopup))
	lu.assertEquals(_G.GearManagerDialogPopupEditBox:GetText(), "")
	-- a set's own tooltip is Blizzard's
	client:Hover(sets[1])
	client:Leave()
	client:Click(sets[1])
	lu.assertEquals(dialog.selectedSetName, "Holy")

	-- off in the game's options: no title bar either
	_G.CharacterFrame:Hide()
	client.api.SetCVar("equipmentManager", "0")
	_G.CharacterFrame:Show()
	client:Tick(0.1)
	lu.assertFalse(shown(dialog))
	assertClean(client)
end

function TestCharacter:test_dragged_by_its_stone()
	boot()
	local backdrop = client:GetModule("Blizzard: Character").Backdrop
	_G.CharacterFrame:Show()
	-- nothing moves it: nothing happens
	client:RunScript(backdrop, "OnDragStart")
	-- BlizzMove's handler on the tab: the stone hands it the drag
	local dragged = {}
	_G.PaperDollFrame:SetScript("OnDragStart", function(self) dragged[#dragged + 1] = "start" end)
	_G.PaperDollFrame:SetScript("OnDragStop", function(self) dragged[#dragged + 1] = "stop" end)
	client:RunScript(backdrop, "OnDragStart")
	client:RunScript(backdrop, "OnDragStop")
	lu.assertEquals(dragged, { "start", "stop" })
	assertClean(client)
end

function TestCharacter:test_gearscore_under_the_inspect_model()
	boot()
	local module = client:GetModule("Blizzard: GearScore")
	-- inspecting: the gear comes in later
	local friend = Client.newUnit({ name = "Friend", class = "WARRIOR" })
	friend.inventoryTextures = { [5] = "Interface\\Icons\\Chest" }
	client.world.units.target = friend
	client.api.LoadAddOn("Blizzard_InspectUI")
	_G.InspectFrame.unit = "target"
	_G.InspectFrame:Show()
	lu.assertEquals(module.InspectLine:GetText(), "")
	friend.inventory = { [5] = Session.item(client, 3005, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_CHEST" }) }
	client:Tick(.6)
	lu.assertEquals(Session.stripColors(module.InspectLine:GetText()), "GS 402   Item Level 13")
	assertClean(client)
end

function TestCharacter:test_gearscore_counts_like_gearscorelite()
	boot()
	local module = client:GetModule("Blizzard: GearScore")
	local item = function(id, fields) return Session.item(client, id, fields) end
	-- grey gear next to nothing, heirlooms as blues of 187, artifacts and
	-- what isn't gear nothing
	lu.assertEquals({ module:GetItemScore(item(4001, { iLevel = 200, quality = 0, equipSlot = "INVTYPE_HEAD" })) }, { 1, 200 })
	lu.assertEquals({ module:GetItemScore(item(4002, { iLevel = 1, quality = 7, equipSlot = "INVTYPE_HEAD" })) }, { 242, 187.05 })
	lu.assertEquals({ module:GetItemScore(item(4003, { iLevel = 200, quality = 6, equipSlot = "INVTYPE_HEAD" })) }, { 0, 200 })
	lu.assertEquals({ module:GetItemScore(item(4004, { iLevel = 200, quality = 4, equipSlot = "INVTYPE_BAG" })) }, { 0, 200 })

	-- Titan's Grip: two two-handers count half each
	local warrior = Client.newUnit({ name = "Warrior", class = "WARRIOR" })
	warrior.inventory = {
		[16] = item(4016, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_2HWEAPON" }),
		[17] = item(4017, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_2HWEAPON" })
	}
	client.world.units.target = warrior
	lu.assertEquals(module:GetUnitScore("target"), 805)
	-- a hunter's weapons count little, the ranged one a lot
	local hunter = Client.newUnit({ name = "Hunter", class = "HUNTER" })
	hunter.inventory = {
		[16] = item(4026, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_WEAPON" }),
		[18] = item(4028, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_RANGED" })
	}
	client.world.units.target = hunter
	lu.assertEquals(module:GetUnitScore("target"), 803)
	-- an item not cached yet: no score yet
	hunter.inventory[1] = "|cffa335ee|Hitem:99999:0:0:0:0:0:0:0:80|h[Unknown]|h|r"
	lu.assertNil(module:GetUnitScore("target"))
	assertClean(client)
end

function TestCharacter:test_the_inspect_window_loaded_before_us()
	local friend = Client.newUnit({ name = "Friend", class = "WARRIOR" })
	boot({ world = function(world, c)
		c.api.LoadAddOn("Blizzard_InspectUI")
	end })
	local module = client:GetModule("Blizzard: GearScore")
	lu.assertNotNil(module.InspectLine)
	-- their gear changing while inspected; another's isn't theirs
	client.world.units.target = friend
	_G.InspectFrame.unit = "target"
	_G.InspectFrame:Show()
	friend.inventory = { [5] = Session.item(client, 3005, { iLevel = 232, quality = 4, equipSlot = "INVTYPE_CHEST" }) }
	client:FireEvent("UNIT_INVENTORY_CHANGED", "focus")
	lu.assertEquals(Session.stripColors(module.InspectLine:GetText()), "GS 0   Item Level 0")
	client:FireEvent("UNIT_INVENTORY_CHANGED", "target")
	lu.assertEquals(Session.stripColors(module.InspectLine:GetText()), "GS 402   Item Level 13")
	assertClean(client)
end

function TestCharacter:test_the_talent_spec_in_the_band()
	boot({ world = function(world)
		world.talents = { { "Discipline", "Interface\\Icons\\Disc", 13 }, { "Holy", "Interface\\Icons\\Holy", 58 }, { "Shadow", "", 0 } }
	end })
	local module = client:GetModule("Blizzard: Character")
	local spec = module.Spec
	-- the tree with the most points, its icon round over the medallion's glass
	lu.assertTrue(shown(spec))
	local glass = client.Engine:GetDB("Blizzard").character.spec.glass_offset
	lu.assertEquals({ spec:GetPoint() }, { "CENTER", module.Medallion, "CENTER", glass[1], glass[2] })
	lu.assertEquals(spec.icon:GetTexture(), "Interface\\Icons\\Holy")
	lu.assertEquals({ spec.name, spec.points }, { "Holy", "13/58/0" })
	-- its points on hover
	client:Hover(spec)
	lu.assertEquals(_G.GameTooltipTextLeft1:GetText(), "Holy")
	lu.assertEquals(_G.GameTooltipTextLeft2:GetText(), "13/58/0")
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	-- the talents on a click
	client:Click(spec)
	lu.assertEquals(client.toggled, "PlayerTalentFrame")
	-- a respec
	client.world.talents = { { "Discipline", "", 0 }, { "Holy", "", 0 }, { "Shadow", "Interface\\Icons\\Shadow", 71 } }
	client:FireEvent("PLAYER_TALENT_UPDATE")
	lu.assertEquals({ spec.name, spec.points }, { "Shadow", "0/0/71" })
	-- no points: nothing to show
	client.world.talents = { { "Discipline", "", 0 }, { "Holy", "", 0 }, { "Shadow", "", 0 } }
	client:FireEvent("PLAYER_TALENT_UPDATE")
	lu.assertFalse(shown(spec))
	assertClean(client)
end

-- The achievement window -------------------------------------------------------------

TestAchievements = {}

function TestAchievements:tearDown()
	client, C = nil, nil
end

function TestAchievements:test_our_window_once_it_loads()
	boot()
	lu.assertNil(_G.AchievementFrame)
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	client.api.LoadAddOn("Blizzard_AchievementUI")
	local config = client.Engine:GetDB("Blizzard").achievements
	local window = client.Engine:GetDB("Blizzard").window
	local frame = _G.AchievementFrame
	local module = client.Engine:GetModule("Blizzard: Achievements")

	-- the stone window instead of the wood, reaching up over the band
	local backdrop = module.Window
	lu.assertEquals(backdrop:GetParent(), frame)
	lu.assertEquals(backdrop.Border:GetBackdrop().edgeFile, window.backdrop.edgeFile)
	lu.assertEquals({ backdrop:GetPoint(1) }, { "TOPLEFT", frame, "TOPLEFT", -config.insets[1], config.insets[2] })
	-- its own art out of sight, the watermark too when Blizzard sets it again
	for _, name in ipairs({ "AchievementFrameBackground", "AchievementFrameMetalBorderLeft",
		"AchievementFrameWoodBorderTopLeft", "AchievementFrameCategoriesBG", "AchievementFrameHeaderLeft",
		"AchievementFrameAchievementsBackground", "AchievementFrameSummaryBackground",
		"AchievementFrameComparisonWatermark", "AchievementFrameStatsBGTexture" }) do
		lu.assertEquals(_G[name]:GetAlpha(), 0, name)
	end
	_G.AchievementFrameWaterMark:SetTexture([[Interface\AchievementFrame\UI-Achievement-StatWatermark]])
	lu.assertEquals(_G.AchievementFrameWaterMark:GetAlpha(), 0)

	-- the title in the band, the points big in a
	-- cartouche in the band after the shield, the close button in the band
	local title = _G.AchievementFrameHeaderTitle
	lu.assertEquals(title:GetText(), "Achievements")
	lu.assertEquals(title:GetFontObject(), window.band_title.font)
	lu.assertEquals(title:GetParent(), module.Header)
	local points, shield = _G.AchievementFrameHeaderPoints, _G.AchievementFrameHeaderShield
	local cartouche = points:GetParent()
	lu.assertEquals(shield:GetParent(), cartouche)
	lu.assertEquals({ cartouche:GetPoint() }, { "CENTER", module.Header, "CENTER", 0, 0 })
	points:SetText("3290")
	lu.assertEquals(cartouche:GetWidth(), points:GetStringWidth() + shield:GetWidth() + window.cartouche.padding)
	lu.assertEquals(shield:GetAlpha(), 1)
	local socket = window.close.socket_size
	lu.assertEquals({ _G.AchievementFrameCloseButton:GetPoint() }, { "CENTER", backdrop, "TOPRIGHT", -socket / 2, -socket / 2 })
	-- Blizzard's header over the band only, the list's filter under it
	lu.assertEquals({ _G.AchievementFrameHeader:GetPoint(1) }, { "TOPLEFT", module.Header, "TOPLEFT", 0, 0 })
	lu.assertEquals({ _G.AchievementFrameFilterDropDown:GetPoint() }, { "TOPRIGHT", module.Header, "BOTTOMRIGHT", unpack(config.filter_position) })

	-- the lists in our panels
	lu.assertEquals(_G.AchievementFrameCategories:GetBackdrop(), window.panel.backdrop)
	local panel = (_G.AchievementFrameAchievements:GetChildren())
	lu.assertEquals(panel:GetBackdrop(), window.panel.backdrop)

	-- the categories as red buttons, the subcategories a list under them
	local category = _G.AchievementFrameCategoriesContainerButton1
	_G.AchievementFrameCategories_DisplayButton(category, { name = "General" })
	lu.assertEquals(category.background:GetAlpha(), 0)
	lu.assertEquals(category.DiabolicArt[1]:GetTexture(), window.rect_button.texture.normal)
	lu.assertEquals(category.label:GetFontObject(), config.category_font)
	lu.assertFalse(shown(category.DiabolicBullet))
	_G.AchievementFrameCategories_DisplayButton(category, { name = "Quests", parent = 92 })
	lu.assertFalse(shown(category.DiabolicArt[2]))
	lu.assertTrue(shown(category.DiabolicBullet))
	lu.assertEquals(category.label:GetFontObject(), config.subcategory_font)
	lu.assertEquals({ category.label:GetPoint() }, { "LEFT", category, "LEFT", config.subcategory_text_offset, 0 })
	_G.AchievementFrameCategories_DisplayButton(category, { name = "General" })

	-- the summary's bars orange in spiked frames, the right column past the spikes
	local spike = window.bar.spike
	local big, first, second = _G.AchievementFrameSummaryCategoriesStatusBar,
		_G.AchievementFrameSummaryCategoriesCategory1, _G.AchievementFrameSummaryCategoriesCategory2
	lu.assertEquals(_G.AchievementFrameSummaryCategoriesCategory1Left:GetAlpha(), 0)
	lu.assertEquals(first.DiabolicBorder[1]:GetTexture(), window.bar.texture)
	near(color(first:GetStatusBarColor()), window.bar.color)
	lu.assertEquals(big:GetWidth(), config.summary_width - spike * 2)
	lu.assertEquals(first:GetWidth(), (config.summary_width - spike * 4 - config.bar_gap) / 2)
	lu.assertEquals({ second:GetPoint() }, { "TOPLEFT", first, "TOPRIGHT", spike * 2 + config.bar_gap, 0 })

	-- the achievements darker (already colored when we came), the unearned
	-- ones darker still, their description light
	local row = _G.AchievementFrameAchievementsContainerButton1
	near(color(_G.AchievementFrameAchievementsContainerButton1Background:GetVertexColor()), config.row_color)
	row:Desaturate()
	near(color(_G.AchievementFrameAchievementsContainerButton1Background:GetVertexColor()), config.row_color_unearned)
	row:Saturate()
	near(color(row.description:GetTextColor()), config.row_text_color)

	-- the summary's recent ones, made the first time it shows (always earned)
	local recent = _G.CreateFrame("Button", "AchievementFrameSummaryAchievement1", _G.AchievementFrameSummaryAchievements)
	_G.CreateFrame("Frame", nil, recent) -- (a texture holder)
	local recentBackground = recent:CreateTexture("AchievementFrameSummaryAchievement1Background")
	recent.Saturate, recent.Desaturate = function() end, function() end
	table.insert(_G.AchievementFrameSummaryAchievements.buttons, recent)
	_G.AchievementFrameSummary_UpdateAchievements()
	near(color(recentBackground:GetVertexColor()), config.row_color)

	-- a category lit under the mouse and while chosen, under its text
	lu.assertEquals(category.DiabolicLit[1]:GetDrawLayer(), "BORDER")
	lu.assertFalse(shown(category.DiabolicLit[1]))
	category:LockHighlight()
	lu.assertTrue(shown(category.DiabolicLit[1]))
	category:UnlockHighlight()
	lu.assertFalse(shown(category.DiabolicLit[1]))

	-- the tabs in a row under the band, and one an addon adds, once the window shows
	lu.assertEquals({ _G.AchievementFrameTab1:GetPoint() }, { "TOPLEFT", module.Header, "BOTTOMLEFT", unpack(config.tab_offset) })
	-- their text kept in their middle (Overachiever moves it)
	local text = _G.AchievementFrameTab1:GetFontString()
	text:SetPoint("CENTER", _G.AchievementFrameTab1, "CENTER", 0, -5)
	lu.assertEquals({ text:GetPoint() }, { "CENTER", _G.AchievementFrameTab1, "CENTER", 0, window.tab.text_offset })
	lu.assertTrue(shown(_G.AchievementFrameTab1.DiabolicArt.red[2]))
	lu.assertTrue(shown(_G.AchievementFrameTab2.DiabolicArt.dark[2]))
	-- Overachiever's, added once the window shows
	frame:Show()
	local added = _G.CreateFrame("Button", "AchievementFrameTab3", frame)
	_G.PanelTemplates_SetNumTabs(frame, 3)
	lu.assertNotNil(added.DiabolicArt)
	assertClean(client)
end

function TestAchievements:test_loaded_before_us()
	boot({ world = function(world, c)
		c.api.LoadAddOn("Blizzard_AchievementUI")
	end })
	lu.assertNotNil(client.Engine:GetModule("Blizzard: Achievements").Window)
	lu.assertEquals(_G.AchievementFrameHeaderTitle:GetText(), "Achievements")
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
	-- Blizzard's input border is gone, the editbox's other textures (its
	-- text selection) stay
	local textures = {}
	for _, region in ipairs({ _G.StaticPopup1EditBox:GetRegions() }) do
		if region:GetObjectType() == "Texture" then
			textures[#textures + 1] = region:GetTexture() or false
		end
	end
	lu.assertEquals(textures, { false, false, [[Interface\Buttons\WHITE8X8]] })
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

function TestPopups:test_the_dungeon_finder_gets_our_frames()
	boot()
	local config = client.Engine:GetDB("UI").popup
	for _, name in ipairs({ "LFDRoleCheckPopup", "LFDDungeonReadyDialog", "LFDDungeonReadyStatus" }) do
		lu.assertEquals(_G[name]:GetBackdrop(), config.header.backdrop, name)
		lu.assertEquals(_G[name].backdrop:GetBackdrop(), config.backdrop, name)
	end
	-- the dungeon's picture stays, the gold filigree goes
	lu.assertNotNil(_G.LFDDungeonReadyDialogBackground:GetTexture())
	lu.assertNil(_G.LFDDungeonReadyDialogFiligree:GetTexture())
	lu.assertNil(_G.LFDDungeonReadyDialogBottomArt:GetTexture())
	-- flat buttons: Blizzard's own three textures, swapped on clicks, stay invisible
	local enter = _G.LFDDungeonReadyDialogEnterDungeonButton
	lu.assertEquals(select(4, _G.LFDDungeonReadyDialogEnterDungeonButtonMiddle:GetVertexColor()), 0)
	client:Hover(enter)
	near(color(enter:GetBackdropColor()), config.footer.button.backdropColor_hover)
	client:Leave()
	-- the queue's status is one of our tooltips, on the minimap's eye
	lu.assertEquals(_G.LFDSearchStatus:GetBackdrop(), client.Engine:GetDB("Blizzard").tooltips.dummy_backdrop)
	assertClean(client)
end

-- Bag items you can't use, and the character window's slots ---------------------------

TestItemSlots = {}

function TestItemSlots:tearDown()
	client, C = nil, nil
end

local RED = { 1, .125, .125 }

function TestItemSlots:test_items_with_a_red_tooltip_line_are_tinted_red()
	boot()
	local plate = Session.item(client, 200, { quality = 3, lines = { "Plate Helm", { "Head", "Plate", RED } } })
	local cloth = Session.item(client, 201, { quality = 3, lines = { "Cloth Hood", { "Head", "Cloth" } } })
	local level = Session.item(client, 202, { quality = 2, lines = { "Big Sword", { "Requires Level 85", nil, RED } } })
	client.world.containers[0] = { size = 4, items = {
		[1] = { quality = 3, link = plate },
		[2] = { quality = 3, link = cloth },
		[3] = { quality = 2, link = level },
		[4] = { quality = 3, link = "|cff0070dd|Hitem:99998:0:0:0:0:0:0:0:80|h[Not Cached]|h|r" },
	} }
	local bag = _G.ContainerFrame1
	bag:SetID(0)
	bag.size = 4
	_G.ContainerFrame_Update(bag)
	near(color(_G.ContainerFrame1Item1IconTexture:GetVertexColor()), { 1, .3, .3 }, "red armor type")
	near(color(_G.ContainerFrame1Item2IconTexture:GetVertexColor()), { 1, 1, 1 }, "usable")
	near(color(_G.ContainerFrame1Item3IconTexture:GetVertexColor()), { 1, .3, .3 }, "red requirement")
	near(color(_G.ContainerFrame1Item4IconTexture:GetVertexColor()), { 1, 1, 1 }, "not cached yet: usable")

	-- learned to wear plate: asked again after the next level
	client.world.itemInfo[200].lines = { "Plate Helm", { "Head", "Plate" } }
	_G.ContainerFrame_Update(bag)
	near(color(_G.ContainerFrame1Item1IconTexture:GetVertexColor()), { 1, .3, .3 }, "remembered")
	client:FireEvent("PLAYER_LEVEL_UP", 81)
	_G.ContainerFrame_Update(bag)
	near(color(_G.ContainerFrame1Item1IconTexture:GetVertexColor()), { 1, 1, 1 }, "asked again")
	assertClean(client)
end

-- The item level text on an item button, if it has one.
local function itemLevelOf(button)
	for _, child in ipairs({ button:GetChildren() }) do
		for _, region in ipairs({ child:GetRegions() }) do
			if region:GetObjectType() == "FontString" then return region end
		end
	end
end

function TestItemSlots:test_character_slots_get_a_quality_border_and_glow_only()
	boot()
	client.world.inventory[1] = Session.item(client, 300, { quality = 4, iLevel = 245, equipSlot = "INVTYPE_HEAD" })
	client.world.inventory[4] = Session.item(client, 301, { quality = 1, iLevel = 1, equipSlot = "INVTYPE_BODY" })
	local head, shirt = _G.CharacterHeadSlot, _G.CharacterShirtSlot
	head:SetID(1)
	shirt:SetID(4)
	_G.PaperDollItemSlotButton_Update(head)
	_G.PaperDollItemSlotButton_Update(shirt)
	near(color(borderOf(head):GetVertexColor()), C.Quality[4], "epic border")
	lu.assertNil(itemLevelOf(head), "no item level")
	near(color(borderOf(shirt):GetVertexColor()), C.General.UIBorder, "a common shirt")
	near(glowOf(head), C.Quality[4], "epic glow")
	lu.assertNil(glowOf(shirt), "no glow on the shirt")

	-- the item gone: nothing left behind
	client.world.inventory[1] = nil
	_G.PaperDollItemSlotButton_Update(head)
	near(color(borderOf(head):GetVertexColor()), C.General.UIBorder)
	lu.assertNil(glowOf(head))
	assertClean(client)
end

function TestItemSlots:test_slots_with_their_own_border_keep_it()
	boot()
	-- a client patch's item buttons, with a quality border of their own
	local head = _G.CharacterHeadSlot
	head.IconBorder = head:CreateTexture()
	head:SetID(1)
	client.world.inventory[1] = Session.item(client, 300, { quality = 4, iLevel = 245, equipSlot = "INVTYPE_HEAD" })
	_G.PaperDollItemSlotButton_Update(head)
	lu.assertNil(itemLevelOf(head))
	lu.assertNil(borderOf(head))
	lu.assertEquals(_G.CharacterHeadSlotNormalTexture:GetAlpha(), 1)
	assertClean(client)
end

function TestItemSlots:test_the_ammo_slot_is_left_alone()
	boot()
	local ammo = _G.CharacterAmmoSlot
	ammo:SetID(0)
	client.world.inventory[0] = Session.item(client, 302, { quality = 2, iLevel = 80, equipSlot = "INVTYPE_AMMO" })
	_G.PaperDollItemSlotButton_Update(ammo)
	lu.assertNil(itemLevelOf(ammo))
	lu.assertNil(borderOf(ammo))
	assertClean(client)
end

-- The Sell Junk button ----------------------------------------------------------------

TestSellJunk = {}

function TestSellJunk:tearDown()
	client, C = nil, nil
end

local GREY = "|cff9d9d9d|Hitem:%d:0:0:0:0:0:0:0:1|h[%s]|h|r"

-- three Broken Fangs (25 copper each), a grey item no merchant takes, and a
-- blue one
local function junkBags()
	client.world.itemInfo[1] = { name = "Broken Fang", quality = 0, vendorPrice = 25, link = GREY:format(1, "Broken Fang") }
	client.world.itemInfo[2] = { name = "Grey Keepsake", quality = 0, vendorPrice = 0, link = GREY:format(2, "Grey Keepsake") }
	local blue = Session.item(client, 3, { quality = 3, vendorPrice = 900 })
	client.world.containers[0] = { size = 4, items = {
		[1] = { quality = 0, count = 3, link = GREY:format(1, "Broken Fang") },
		[2] = { quality = 0, link = GREY:format(2, "Grey Keepsake") },
		[3] = { quality = 3, link = blue },
	} }
end

local function openMerchant()
	_G.MerchantFrame.selectedTab = 1
	_G.MerchantFrame:Show()
	client:FireEvent("MERCHANT_SHOW")
	_G.MerchantFrame_Update()
end

function TestSellJunk:test_sells_the_grey_items_a_merchant_takes()
	boot()
	junkBags()
	local said = {}
	hooksecurefunc(_G.DEFAULT_CHAT_FRAME, "AddMessage", function(_, text) said[#said + 1] = text end)
	openMerchant()
	local button = _G.DiabolicSellJunkButton
	lu.assertTrue(shown(button))
	lu.assertEquals(button:IsEnabled(), 1)

	client:Hover(button)
	lu.assertStrContains(Session.tooltipLines(_G.GameTooltip)[2], "1 grey items")
	client:Leave()

	client:Click(button)
	lu.assertEquals(#client.world.sold, 1)
	lu.assertEquals(client.world.sold[1].count, 3)
	lu.assertNotNil(client.world.containers[0].items[2], "worth nothing: kept")
	lu.assertNotNil(client.world.containers[0].items[3], "not junk")
	lu.assertStrContains(said[#said], "Sold 1 junk items for " .. _G.GetCoinTextureString(75))

	-- nothing left to sell: greyed out, said so, and nothing sold
	client:FireEvent("BAG_UPDATE", 0)
	lu.assertEquals(button:IsEnabled(), 0)
	client:Hover(button)
	lu.assertEquals(Session.tooltipLines(_G.GameTooltip)[2], "No grey items in your bags.")
	client:Leave()
	client:GetModule("Blizzard: SellJunk"):SellJunk()
	lu.assertEquals(#client.world.sold, 1)
	assertClean(client)
end

function TestSellJunk:test_only_on_the_merchants_tab_and_bags_watched_while_open()
	boot()
	junkBags()
	openMerchant()
	local module = client:GetModule("Blizzard: SellJunk")
	lu.assertTrue(module.watching)
	_G.MerchantFrame.selectedTab = 2
	_G.MerchantFrame_Update()
	lu.assertFalse(shown(_G.DiabolicSellJunkButton))
	_G.MerchantFrame.selectedTab = 1
	_G.MerchantFrame_Update()
	lu.assertTrue(shown(_G.DiabolicSellJunkButton))

	-- closed (twice, as the client sometimes does)
	_G.MerchantFrame:Hide()
	client:FireEvent("MERCHANT_CLOSED")
	client:FireEvent("MERCHANT_CLOSED")
	lu.assertNil(module.watching)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
