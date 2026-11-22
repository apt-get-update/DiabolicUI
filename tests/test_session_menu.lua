-- Run from the addon root: lua5.1 tests/test_session_menu.lua
--
-- The options pages in the fake client's Interface Options: every
-- checkbox, slider (dragged, typed in, snapped, greyed out), the tooltip
-- anchor picker, the buttons, the hover descriptions, the reload question,
-- cancel and refresh, and /diabolic config.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean, tooltipLines = Session.assertClean, Session.tooltipLines

local client

local function boot(options)
	client = Client.boot(options)
	client:Tick(0.2)
end

local function widget(name)
	return _G["DiabolicUIOptionsPanel" .. name]
end

local function db(name, profile)
	return client.Engine:GetConfig(name, profile)
end

local function click(name)
	local checkbox = widget(name)
	checkbox:SetChecked(not checkbox:GetChecked())
	client:RunScript(checkbox, "OnClick", "LeftButton")
end

-- Types a value into a slider's entry box.
local function enter(name, text)
	local input = widget(name .. "Input")
	input:SetText(text)
	client:RunScript(input, "OnEnterPressed")
end

-- The shown popup of the popup handler for `id`.
local function popupFrame(id)
	for _, child in ipairs({ client.Engine:GetFrame():GetChildren() }) do
		if child.id == id and child:IsShown() then
			return child
		end
	end
end

TestOptionsMenu = {}

function TestOptionsMenu:setUp()
	boot()
end

function TestOptionsMenu:tearDown()
	client = nil
end

function TestOptionsMenu:test_the_pages_under_diabolicui()
	local names = {}
	for _, panel in ipairs(client.optionsPanels) do
		if panel:GetName() and panel:GetName():find("^DiabolicUIOptionsPanel") then
			names[#names + 1] = (panel.parent and (panel.parent .. "/") or "") .. panel.name
		end
	end
	lu.assertEquals(names, {
		"DiabolicUI",
		"DiabolicUI/Positions",
		"DiabolicUI/Specializations",
	})
	-- the main page: the switches and the version
	_G.DiabolicUIOptionsPanel.refresh()
	assertClean(client)
end

function TestOptionsMenu:test_the_menu_checkboxes()
	local bars = db("ActionBars", "character")
	local gold = bars.showGold
	click("ShowGold")
	lu.assertEquals(bars.showGold, not gold)
	click("ShowGold")
	lu.assertEquals(bars.showGold, gold)
	local objectives = db("ObjectiveTracker")
	click("WorldMessages")
	lu.assertFalse(objectives.worldMessages)
	click("WorldMessages")
	lu.assertTrue(objectives.worldMessages)
	local units = db("UnitFrames")
	click("CombatNames")
	lu.assertFalse(units.combatNames)
	click("CombatNames")
	lu.assertTrue(units.combatNames)
	assertClean(client)
end

function TestOptionsMenu:test_typing_in_a_slider()
	local scaling = db("ScreenScaling")
	-- typed in, kept in range
	enter("UIScale", "90")
	lu.assertEquals(scaling.scale, 0.9)
	lu.assertEquals(widget("UIScale"):GetValue(), 90)
	enter("UIScale", "500")
	lu.assertEquals(scaling.scale, 1.5)
	enter("UIScale", "5")
	lu.assertEquals(scaling.scale, 0.5)
	-- not a number, or escape: back to what it was
	enter("UIScale", "lots")
	lu.assertEquals(widget("UIScaleInput"):GetText(), "50")
	widget("UIScaleInput"):SetText("77")
	client:RunScript(widget("UIScaleInput"), "OnEscapePressed")
	lu.assertEquals(widget("UIScaleInput"):GetText(), "50")
	lu.assertEquals(scaling.scale, 0.5)

	-- the entry box lights up on hover
	local input = widget("UIScaleInput")
	client:Hover(input)
	lu.assertEquals(select(4, input:GetBackdropBorderColor()), 1)
	client:Leave()
	widget("UIScale"):SetValue(100)
	assertClean(client)
end

function TestOptionsMenu:test_settings_needing_a_reload_ask_for_it()
	local windows = db("Windows")
	click("ReskinWindows")
	lu.assertFalse(windows.enableSkin)
	local popup = popupFrame("ENGINE_GENERAL_RELOADUI")
	lu.assertNotNil(popup)
	client:Click(popup.button1)
	lu.assertEquals(client.reloaded, 1)

	local units = db("UnitFrames")
	local classColors = units.showClassColors
	click("ClassColors")
	lu.assertEquals(units.showClassColors, not classColors)
	client:Click(popupFrame("ENGINE_GENERAL_RELOADUI").button2)
	lu.assertNil(popupFrame("ENGINE_GENERAL_RELOADUI"))
	click("ShowPortrait")
	lu.assertNotNil(popupFrame("ENGINE_GENERAL_RELOADUI"))
	lu.assertEquals(client.reloaded, 1)

	popupFrame("ENGINE_GENERAL_RELOADUI"):Hide()
	local warning = units.lowHealthWarning
	click("LowHealthWarning")
	lu.assertEquals(units.lowHealthWarning, not warning)
	lu.assertNotNil(popupFrame("ENGINE_GENERAL_RELOADUI"))

	-- clicked back without a change: no question
	popupFrame("ENGINE_GENERAL_RELOADUI"):Hide()
	widget("ShowPortrait"):SetChecked(units.showPortrait)
	client:RunScript(widget("ShowPortrait"), "OnClick", "LeftButton")
	lu.assertNil(popupFrame("ENGINE_GENERAL_RELOADUI"))
	assertClean(client)
end

function TestOptionsMenu:test_the_tooltip_anchor()
	local tooltips = db("Tooltips")
	-- the anchor picker
	client:RunScript(widget("AnchorTOPLEFT"), "OnClick", "LeftButton")
	lu.assertEquals(tooltips.anchorPoint, "TOPLEFT")
	lu.assertEquals(widget("AnchorTOPLEFT"):GetChecked(), 1)
	lu.assertNil(widget("AnchorBOTTOM"):GetChecked())

	-- offsets snap to 0 near it
	widget("TooltipOffsetX"):SetValue(3)
	lu.assertEquals(tooltips.offsetX, 0)
	widget("TooltipOffsetX"):SetValue(-150)
	lu.assertEquals(tooltips.offsetX, -150)
	enter("TooltipOffsetY", "25")
	lu.assertEquals(tooltips.offsetY, 25)

	-- cancel puts the widgets back to the saved values
	tooltips.offsetX, tooltips.anchorPoint = 40, "CENTER"
	_G.DiabolicUIOptionsPanelPositions.cancel()
	lu.assertEquals(widget("TooltipOffsetX"):GetValue(), 40)
	lu.assertEquals(widget("AnchorCENTER"):GetChecked(), 1)
	assertClean(client)
end

function TestOptionsMenu:test_descriptions_on_hover()
	-- the tooltip card's title
	local card = widget("TooltipCard")
	local label, hitbox = card.title, card.hitbox
	lu.assertEquals(label:GetText(), client.Engine:GetLocale()["Tooltip Anchor"])
	client:Hover(hitbox)
	lu.assertEquals(tooltipLines(_G.GameTooltip)[1], label:GetText())
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())

	client:Hover(widget("ResetPositions"))
	lu.assertEquals(tooltipLines(_G.GameTooltip)[1], widget("ResetPositions"):GetText())
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())
	assertClean(client)
end

function TestOptionsMenu:test_the_pages_under_the_main_one()
	local names = {}
	for _, category in ipairs(_G.INTERFACEOPTIONS_ADDONCATEGORIES) do
		if category.parent == "DiabolicUI" then
			names[#names + 1] = category.name
		end
	end
	lu.assertEquals(names, { "Positions", "Specializations" })
end

function TestOptionsMenu:test_the_fake_group_commands()
	local units = db("UnitFrames")
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("party")
	lu.assertTrue(units.testPartyMode)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("raid")
	lu.assertTrue(units.testRaidMode)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("party")
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("raid")
	lu.assertFalse(units.testPartyMode)
	lu.assertFalse(units.testRaidMode)
	assertClean(client)
end

function TestOptionsMenu:test_the_chat_checkboxes()
	local filters = db("ChatFilters")
	for name, setting in pairs({
		ShortMessages = "shortMessages",
		HideChannelNotices = "hideChatNoise",
		ShortChannels = "shortChannels",
		ChatHistory = "chatHistory",
	}) do
		local before = filters[setting]
		click(name)
		lu.assertEquals(filters[setting], not before, setting)
		filters[setting] = before
	end
	_G.DiabolicUIOptionsPanel.refresh()
	lu.assertEquals(widget("ShortMessages"):GetChecked() and true or false, filters.shortMessages)
	assertClean(client)
end

-- Every page fits in Blizzard's options window (648x520, its pages
-- 424 high): the lowest widget of each stays above the page's bottom.
-- The texts and icons of the Specializations page's regions.
-- (on the page and on its shown cards)
local function specsCards()
	local cards = {}
	for _, child in ipairs({ _G.DiabolicUIOptionsPanelSpecs:GetChildren() }) do
		if child:GetBackdrop() then
			cards[#cards + 1] = child
		end
	end
	return cards
end

local function specsRegions()
	local texts, icons = {}, {}
	local frames = specsCards()
	table.insert(frames, _G.DiabolicUIOptionsPanelSpecs)
	for _, frame in ipairs(frames) do
		for _, region in ipairs({ frame:GetRegions() }) do
			if region:IsShown() and (frame == _G.DiabolicUIOptionsPanelSpecs or frame:IsShown()) then
				if region:GetObjectType() == "FontString" then
					texts[region:GetText() or ""] = true
				elseif region:GetObjectType() == "Texture" then
					icons[region:GetTexture() or ""] = true
				end
			end
		end
	end
	return texts, icons
end

-- Opens a dropdown and returns its choices' texts, and picks `pick` (a
-- choice's text) if given.
local function openDropDown(name, pick)
	local dropDown = widget(name)
	client.dropDownButtons = {}
	client:Call(dropDown.initialize, dropDown, 1)
	local texts = {}
	for _, info in ipairs(client.dropDownButtons) do
		texts[#texts + 1] = info.text
		if info.text == pick then
			info.func(nil, info.arg1)
		end
	end
	return texts
end

function TestOptionsMenu:test_the_specializations_page()
	local L = client.Engine:GetLocale()
	local bars = db("ActionBars", "character")
	client.world.talents = {
		{ "Discipline", "Interface\\Icons\\Disc", 13 },
		{ "Holy", "Interface\\Icons\\Holy", 58 },
		{ "Shadow", "", 0 },
	}
	client.world.secondaryTalents =
		{ { "Discipline", "", 14 }, { "Holy", "", 0 }, { "Shadow", "Interface\\Icons\\Shadow", 57 } }
	client.world.equipmentSets =
		{ { "Holy", "Interface\\Icons\\HolySet" }, { "Shadow", "Interface\\Icons\\ShadowSet" } }
	bars.specEquipSet2 = "Shadow"
	_G.DiabolicUIOptionsPanelSpecs.refresh()

	-- one column per specialization: its icon and name over its settings
	local texts, icons = specsRegions()
	lu.assertTrue(texts.Holy and texts.Shadow)
	lu.assertTrue(icons["Interface\\Icons\\Holy"] and icons["Interface\\Icons\\Shadow"])
	lu.assertEquals(widget("Spec2EquipSet").text, "|TInterface\\Icons\\ShadowSet:16:16:0:0|t Shadow")
	lu.assertEquals(widget("Spec1EquipSet").text, L["None"])
	-- the active one lit
	lu.assertTrue(texts[L["Active"]])

	-- picking from the dropdowns saves
	lu.assertEquals(openDropDown("Spec1EquipSet", "|TInterface\\Icons\\HolySet:16:16:0:0|t Holy"), {
		L["None"],
		"|TInterface\\Icons\\HolySet:16:16:0:0|t Holy",
		"|TInterface\\Icons\\ShadowSet:16:16:0:0|t Shadow",
	})
	lu.assertEquals(bars.specEquipSet1, "Holy")
	lu.assertEquals(widget("Spec1EquipSet").text, "|TInterface\\Icons\\HolySet:16:16:0:0|t Holy")

	-- the action bars: Restore once saved
	local restore = _G.DiabolicUIOptionsPanelSpec1RestoreBars
	lu.assertEquals(restore:IsEnabled(), 0)
	client:Click(_G.DiabolicUIOptionsPanelSpec1SaveBars)
	lu.assertTrue(bars.specActions1 and true)
	lu.assertEquals(restore:IsEnabled(), 1)
	client:Click(restore)
	-- the other specialization's: off, the bars on screen aren't its own
	lu.assertEquals(_G.DiabolicUIOptionsPanelSpec2SaveBars:IsEnabled(), 0)
	bars.specActions2 = { bars = 1 }
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	lu.assertEquals(_G.DiabolicUIOptionsPanelSpec2RestoreBars:IsEnabled(), 0)

	-- a saved set that's gone shows greyed out
	client.world.equipmentSets = {}
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	lu.assertEquals(widget("Spec1EquipSet").text, "|cff808080Holy|r")

	-- no points spent yet: the group's name and a question mark
	client.world.secondaryTalents = { { "Discipline", "", 0 }, { "Holy", "", 0 }, { "Shadow", "", 0 } }
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	texts, icons = specsRegions()
	lu.assertTrue(texts[_G.SECONDARY])
	lu.assertTrue(icons["Interface\\Icons\\INV_Misc_QuestionMark"])

	lu.assertTrue(texts[L["Macro Before"]] and texts[L["Macro After"]])

	-- no Dual Talent Specialization yet: only a hint
	client.world.numTalentGroups = 1
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	texts = specsRegions()
	lu.assertTrue(texts[L["Learn Dual Talent Specialization to set this up."]])
	lu.assertNil(texts[L["Macro Before"]])
	client.world.numTalentGroups = nil
	assertClean(client)
end

function TestOptionsMenu:test_the_specialization_macros()
	local L = client.Engine:GetLocale()
	local bars = db("ActionBars", "character")
	client.world.macros = {
		[1] = { "Toy", "Interface\\Icons\\Toy", "/use item:44430" },
		[37] = { "DUI Holy", "Interface\\Icons\\Q", "" },
	}
	bars.specMacroName2 = "Toy"
	_G.DiabolicUIOptionsPanelSpecs.refresh()

	lu.assertEquals(widget("Spec1Macro").text, L["None"])
	lu.assertEquals(widget("Spec2Macro").text, "|TInterface\\Icons\\Toy:16:16:0:0|t Toy")
	lu.assertEquals(
		openDropDown("Spec1Macro", "|TInterface\\Icons\\Q:16:16:0:0|t DUI Holy"),
		{ L["None"], "|TInterface\\Icons\\Toy:16:16:0:0|t Toy", "|TInterface\\Icons\\Q:16:16:0:0|t DUI Holy" }
	)
	lu.assertEquals(bars.specMacroName1, "DUI Holy")
	openDropDown("Spec2Macro", L["None"])
	lu.assertFalse(bars.specMacroName2)
	assertClean(client)
end

function TestOptionsMenu:test_the_addons_page_and_the_tracker_buttons()
	local L = client.Engine:GetLocale()
	local loot = db("LootFrame")
	-- the roll window asks for a reload when it changes
	click("RollWindow")
	lu.assertTrue(loot.rollWindow)
	local popup = popupFrame("ENGINE_GENERAL_RELOADUI")
	lu.assertNotNil(popup)
	popup:Hide()
	-- clicked back without a change: no question
	widget("RollWindow"):SetChecked(loot.rollWindow)
	client:RunScript(widget("RollWindow"), "OnClick", "LeftButton")
	lu.assertNil(popupFrame("ENGINE_GENERAL_RELOADUI"))
	loot.rollWindow = false
	_G.DiabolicUIOptionsPanel.refresh()
	lu.assertNil(widget("RollWindow"):GetChecked())
	-- /dui loot with the roll window off (its default): nothing
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("loot")
	lu.assertNil(_G.DiabolicLootPreviewFrame)

	-- Unlock Frames: the minimap and the tracker at once, one button to lock
	local menu = client:GetModule("Menu")
	local tracker = client:GetModule("ObjectiveTracker")
	local minimap = client:GetModule("Minimap")
	local unlock = widget("UnlockFrames")
	client:Click(unlock)
	lu.assertTrue(menu:AreFramesUnlocked())
	lu.assertTrue(tracker:IsTrackerUnlocked())
	lu.assertTrue(minimap:IsEditModeActive())
	lu.assertEquals(unlock:GetText(), L["Lock Frames"])
	local lock = _G.DiabolicUILockFramesButton
	lu.assertEquals(lock:IsShown(), 1)
	lu.assertEquals(
		lock.Hint:GetText(),
		L["Drag the highlighted frames to move them. Right-drag the minimap to resize it."]
	)
	_G.DiabolicUIOptionsPanelPositions.refresh()
	lu.assertEquals(unlock:GetText(), L["Lock Frames"])
	client:Click(lock)
	lu.assertFalse(menu:AreFramesUnlocked())
	lu.assertFalse(tracker:IsTrackerUnlocked())
	lu.assertFalse(minimap:IsEditModeActive())
	lu.assertNil(lock:IsShown())
	lu.assertEquals(unlock:GetText(), L["Unlock Frames"])

	-- the chat and the menu buttons, by their own boxes
	local chat = client:GetModule("ChatWindows")
	local menuController = client:GetModule("ActionBars"):GetWidget("Controller: Menu")
	local bars = db("ActionBars", "character")
	client:Click(unlock)
	local chatMover, menuMover = _G.DiabolicUIChatMover, _G.DiabolicUIMenuMover
	lu.assertEquals({ chatMover:IsShown(), menuMover:IsShown() }, { 1, 1 })
	-- the menu's box: over its buttons (on top: they can't be clicked meanwhile)
	local master = client:GetModule("ActionBars"):GetWidget("Menu: Main").MasterMenuButton
	lu.assertEquals(
		{ menuMover:GetRight(), (menuMover:GetBottom()) <= (master:GetBottom()) },
		{ master:GetRight() + 6, true }
	)
	lu.assertEquals(menuMover:GetFrameStrata(), "FULLSCREEN_DIALOG") -- above the buttons' DIALOG
	chat.db.autoposition = true
	client:RunScript(chatMover, "OnDragStart", "LeftButton")
	_G.ChatFrame1:ClearAllPoints()
	_G.ChatFrame1:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 300, 200)
	client:RunScript(chatMover, "OnDragStop", "LeftButton")
	lu.assertFalse(chat.db.autoposition) -- placed by hand now
	lu.assertEquals({ chat.db.positionX, chat.db.positionY }, { 300, 200 })
	local controller = menuController:GetFrame()
	client:RunScript(menuMover, "OnDragStart", "LeftButton")
	controller:ClearAllPoints()
	controller:SetPoint("BOTTOMRIGHT", client.Engine:GetFrame(), "BOTTOMRIGHT", -300, 100)
	client:RunScript(menuMover, "OnDragStop", "LeftButton")
	lu.assertEquals(bars.menuPosition, { -300, 100 })
	client:Click(_G.DiabolicUILockFramesButton)
	lu.assertEquals({ chatMover:IsShown(), menuMover:IsShown() }, { nil, nil })

	-- on the left half of the screen, the buttons mirror: main menu, then bags
	local menuWidget = client:GetModule("ActionBars"):GetWidget("Menu: Main")
	local ui = client.Engine:GetFrame()
	bars.menuPosition = { -(ui:GetWidth() - 300), 100 }
	menuController:PlaceController()
	lu.assertEquals((menuWidget:GetSide()), "LEFT")
	lu.assertEquals(select(1, master:GetPoint()), "BOTTOMLEFT")
	lu.assertTrue(menuWidget.BagBarMenuButton:GetLeft() > master:GetRight())
	lu.assertEquals(select(1, master.Gold:GetPoint()), "BOTTOMLEFT")
	lu.assertEquals(select(1, master.Performance:GetPoint()), "LEFT") -- after the gold
	lu.assertEquals(select(1, menuWidget.MasterMenuWindow:GetPoint()), "BOTTOMLEFT")
	-- its windows open rightwards, their tooltips on that side
	local point, _, relativePoint = menuWidget.MicroMenuWindow:GetPoint()
	lu.assertEquals({ point, relativePoint }, { "BOTTOMLEFT", "BOTTOMRIGHT" })
	lu.assertEquals(menuWidget.MicroMenuWindow:GetButtonGrowthX(), "RIGHT")
	lu.assertEquals(select(1, menuWidget.ActionBarMenuWindow:GetPoint()), "BOTTOMLEFT")
	menuWidget:AnchorMicroTooltip()
	lu.assertEquals(select(1, _G.GameTooltip:GetPoint()), "BOTTOMLEFT")

	-- on the top half, they open downwards
	bars.menuPosition = { -(ui:GetWidth() - 300), ui:GetHeight() - 150 }
	menuController:PlaceController()
	lu.assertEquals({ menuWidget:GetSide() }, { "LEFT", "TOP" })
	point, _, relativePoint = menuWidget.MicroMenuWindow:GetPoint()
	lu.assertEquals({ point, relativePoint }, { "TOPLEFT", "TOPRIGHT" })
	lu.assertEquals(menuWidget.MasterMenuWindow:GetButtonGrowthY(), "DOWN")
	lu.assertEquals(select(1, menuWidget.MasterMenuWindow:GetPoint()), "TOPLEFT")
	menuWidget:AnchorMicroTooltip()
	lu.assertEquals(select(1, _G.GameTooltip:GetPoint()), "TOPLEFT")
	lu.assertEquals(select(1, menuWidget.BagBarMenuWindow:GetPoint()), "TOPLEFT")
	bars.showGold = false
	menuWidget:UpdatePerformanceAnchor()
	lu.assertEquals(select(1, master.Performance:GetPoint()), "BOTTOMLEFT") -- in its place
	bars.showGold = true
	menuWidget:UpdatePerformanceAnchor()

	-- Reset Positions, on the main page
	client:Click(widget("ResetPositions"))
	lu.assertNil(bars.menuPosition)
	lu.assertEquals({ menuWidget:GetSide() }, { "RIGHT", "BOTTOM" }) -- back: bags, then main menu
	local point, _, relativePoint = menuWidget.MicroMenuWindow:GetPoint()
	lu.assertEquals({ point, relativePoint }, { "BOTTOMRIGHT", "BOTTOMLEFT" })
	lu.assertEquals(select(1, master:GetPoint()), "BOTTOMRIGHT")
	lu.assertTrue(menuWidget.BagBarMenuButton:GetRight() < master:GetLeft())
	client:Click(widget("ResetPositions"))
	lu.assertTrue(chat.db.autoposition)
	bars.menuPosition = { -10, 10 }
	client:EnterCombat()
	client:Click(widget("ResetPositions")) -- forgotten now, placed after a reload
	lu.assertNil(bars.menuPosition)
	client:LeaveCombat()

	-- Questie's tracker: unlocked, then locked back as it was
	local updates = 0
	_G.Questie = { db = { profile = { trackerEnabled = true, trackerLocked = true } } }
	CreateFrame("Frame", "Questie_BaseFrame", _G.UIParent)
	_G.QuestieLoader = {
		ImportModule = function()
			return {
				Update = function()
					updates = updates + 1
				end,
			}
		end,
	}
	client:Click(unlock)
	lu.assertFalse(_G.Questie.db.profile.trackerLocked)
	lu.assertFalse(tracker:IsTrackerUnlocked()) -- Questie's instead of Blizzard's
	-- a box over it, clicks going through to Questie, which drags and saves it
	local questieBox = _G.DiabolicUIQuestieMover
	lu.assertEquals(questieBox:IsShown(), 1)
	lu.assertNil(questieBox:IsMouseEnabled())
	client:RunScript(questieBox, "OnDragStop") -- nothing to save
	client:Click(unlock)
	client:Click(unlock)
	client:Click(unlock)
	lu.assertTrue(_G.Questie.db.profile.trackerLocked)
	lu.assertEquals(updates, 4)
	_G.Questie.db.profile.trackerEnabled = false -- not in use: Blizzard's
	client:Click(unlock)
	lu.assertTrue(tracker:IsTrackerUnlocked())
	client:Click(unlock)
	lu.assertEquals(updates, 4)
	lu.assertNil(questieBox:IsShown())
	_G.Questie, _G.QuestieLoader, _G.Questie_BaseFrame = nil, nil, nil

	-- TrinketMenu's worn trinkets, while its window is shown; saved where it keeps them
	local trinkets = CreateFrame("Frame", "TrinketMenu_MainFrame", _G.UIParent)
	trinkets:SetPoint("TOPLEFT", _G.UIParent, "BOTTOMLEFT", 400, 300)
	trinkets:SetSize(92, 52)
	_G.TrinketMenuPerOptions = {}
	menu.Movers = nil -- built again, now with it
	client:Click(unlock)
	local trinketMover = _G.DiabolicUITrinketMenuMover
	lu.assertEquals(trinketMover:IsShown(), 1)
	client:RunScript(trinketMover, "OnDragStart", "LeftButton")
	trinkets:ClearAllPoints()
	trinkets:SetPoint("TOPLEFT", _G.UIParent, "BOTTOMLEFT", 500, 350)
	client:RunScript(trinketMover, "OnDragStop", "LeftButton")
	lu.assertEquals({ _G.TrinketMenuPerOptions.XPos, _G.TrinketMenuPerOptions.YPos }, { 500, 350 })
	client:Click(unlock)
	trinkets:Hide() -- its window hidden: no box
	client:Click(unlock)
	lu.assertNil(trinketMover:IsShown())
	client:Click(unlock)
	_G.TrinketMenuPerOptions, _G.TrinketMenu_MainFrame = nil, nil

	-- /dui move; combat locks them, and they don't unlock in it
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("move")
	lu.assertTrue(menu:AreFramesUnlocked())
	client:EnterCombat()
	lu.assertFalse(menu:AreFramesUnlocked())
	local printed, print = {}, _G.print
	_G.print = function(text)
		printed[#printed + 1] = text
	end
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("move")
	_G.print = print
	lu.assertFalse(menu:AreFramesUnlocked())
	lu.assertEquals(printed, { L["You can't move frames in combat."] })
	client:LeaveCombat()
	client:FireEvent("PLAYER_REGEN_DISABLED") -- locked already: nothing to do
	client.world.inCombat = false

	-- Reset Positions puts the tracker back too
	tracker.db.trackerPosition = { 1, 2 }
	client:Click(widget("ResetPositions"))
	lu.assertNil(tracker.db.trackerPosition)

	-- a specialization label's description on hover
	local label
	for _, child in ipairs({ specsCards()[1]:GetChildren() }) do
		if child:GetScript("OnEnter") and child:GetObjectType() == "Frame" and not child.initialize then
			label = child
			break
		end
	end
	client:Hover(label)
	lu.assertEquals(_G.GameTooltip:IsShown(), 1)
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())
	assertClean(client)
end

function TestOptionsMenu:test_the_chat_box_covers_its_buttons()
	local chat, buttons, menuButton = _G.ChatFrame1, _G.ChatFrame1ButtonFrame, _G.ChatFrameMenuButton
	chat:ClearAllPoints()
	chat:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 100, 100)
	chat:SetSize(400, 200)
	-- the buttons on its left, the menu button above them
	buttons:ClearAllPoints()
	buttons:SetPoint("TOPRIGHT", chat, "TOPLEFT", -2, 0)
	buttons:SetSize(30, 260) -- reaching below its last button: only its sides count
	menuButton:ClearAllPoints()
	menuButton:SetPoint("BOTTOM", buttons, "TOP", 0, 0)
	menuButton:SetSize(30, 30)
	-- the edit box under it (hidden while not typing: still counted)
	local editBox = _G.ChatFrame1EditBox
	editBox:ClearAllPoints()
	editBox:SetPoint("TOPLEFT", chat, "BOTTOMLEFT", 0, -4)
	editBox:SetPoint("TOPRIGHT", chat, "BOTTOMRIGHT", 0, -4)
	editBox:SetHeight(26)
	editBox:Hide()
	client:GetModule("Menu"):SetFramesUnlocked(true)
	local mover = _G.DiabolicUIChatMover
	lu.assertEquals({ mover:GetLeft(), mover:GetRight(), mover:GetTop(), (mover:GetBottom()) }, { 68, 500, 330, 70 })
	-- and follows the chat
	chat:ClearAllPoints()
	chat:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 200, 150)
	lu.assertEquals({ mover:GetLeft(), (mover:GetBottom()) }, { 168, 120 })
	client:GetModule("Menu"):SetFramesUnlocked(false)
	assertClean(client)
end

function TestOptionsMenu:test_a_box_over_unplaced_frames_covers_its_frame()
	local menu = client:GetModule("Menu")
	-- the chat not placed yet: its box takes its points, and follows once it is
	local chat = _G.ChatFrame1
	chat:ClearAllPoints()
	menu:SetFramesUnlocked(true)
	local mover = _G.DiabolicUIChatMover
	lu.assertNil(mover:GetLeft())
	chat:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 100, 100)
	chat:SetSize(400, 200)
	lu.assertEquals({ mover:GetLeft(), mover:GetRight(), mover:GetTop(), (mover:GetBottom()) }, { 100, 500, 300, 100 })
	menu:SetFramesUnlocked(false)

	-- the menu's box covers only its buttons and texts: none of them placed,
	-- it covers the menu's frame instead
	local buttons = client:GetModule("ActionBars"):GetWidget("Menu: Main")
	local master = buttons.MasterMenuButton
	for _, frame in ipairs({ master, buttons.BagBarMenuButton, master.Gold, master.Performance }) do
		frame:ClearAllPoints()
	end
	menu:SetFramesUnlocked(true)
	local frame = client:GetModule("ActionBars"):GetWidget("Controller: Menu"):GetFrame()
	mover = _G.DiabolicUIMenuMover
	lu.assertEquals(
		{ mover:GetLeft(), mover:GetRight(), mover:GetTop(), (mover:GetBottom()) },
		{ frame:GetLeft(), frame:GetRight(), frame:GetTop(), (frame:GetBottom()) }
	)
	menu:SetFramesUnlocked(false)
	assertClean(client)
end

function TestOptionsMenu:test_the_ui_scale_slider()
	local scaling = db("ScreenScaling")
	local frame = client.Engine:GetFrame()
	local before = frame:GetScale()
	widget("UIScale"):SetValue(80)
	lu.assertEquals(scaling.scale, 0.8)
	lu.assertAlmostEquals(frame:GetScale(), before * 0.8, 1e-6)
	-- the page shows the saved value, /dui setscale included
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("setscale 1.2")
	_G.DiabolicUIOptionsPanelPositions.refresh()
	lu.assertEquals(widget("UIScale"):GetValue(), 120)
	-- in combat, it waits for its end
	client:EnterCombat()
	widget("UIScale"):SetValue(100)
	lu.assertAlmostEquals(frame:GetScale(), before * 1.2, 1e-6)
	client:LeaveCombat()
	lu.assertAlmostEquals(frame:GetScale(), before, 1e-6)

	-- the minimap, Questie's tracker and TrinketMenu's windows scale with it
	local minimap = client:GetModule("Minimap")
	local mapBefore = minimap:GetBaseScale()
	local questie = CreateFrame("Frame", "Questie_BaseFrame", _G.UIParent)
	local trinkets = CreateFrame("Frame", "TrinketMenu_MainFrame", _G.UIParent)
	trinkets:SetScale(1.5) -- TrinketMenu's own scale
	widget("UIScale"):SetValue(80)
	lu.assertAlmostEquals(minimap:GetBaseScale(), mapBefore * 0.8, 1e-6)
	lu.assertAlmostEquals(questie:GetScale(), 0.8, 1e-6)
	-- TrinketMenu's still reads and sets its own scale, ours on top
	lu.assertEquals(trinkets:GetScale(), 1.5)
	lu.assertAlmostEquals(trinkets:GetEffectiveScale(), 1.5 * 0.8 * _G.UIParent:GetEffectiveScale(), 1e-6)
	trinkets:SetScale(1)
	lu.assertAlmostEquals(trinkets:GetEffectiveScale(), 0.8 * _G.UIParent:GetEffectiveScale(), 1e-6)
	-- in combat, it waits for its end
	client:EnterCombat()
	widget("UIScale"):SetValue(100)
	lu.assertAlmostEquals(questie:GetScale(), 0.8, 1e-6)
	client:LeaveCombat()
	lu.assertAlmostEquals(questie:GetScale(), 1, 1e-6)
	-- /dui setscale too
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("setscale 0.7")
	lu.assertAlmostEquals(minimap:GetBaseScale(), mapBefore * 0.7, 1e-6)
	lu.assertAlmostEquals(questie:GetScale(), 0.7, 1e-6)
	lu.assertAlmostEquals(trinkets:GetEffectiveScale(), 0.7 * _G.UIParent:GetEffectiveScale(), 1e-6)

	-- Questie building its tracker later: scaled on its next update
	local updated
	local trackerModule = {
		Update = function()
			updated = true
		end,
	}
	_G.QuestieLoader = {
		ImportModule = function()
			return trackerModule
		end,
	}
	widget("UIScale"):SetValue(90)
	client:FireEvent("PLAYER_ENTERING_WORLD")
	questie:SetScale(1) -- Questie remade it
	trackerModule.Update()
	lu.assertTrue(updated)
	lu.assertAlmostEquals(questie:GetScale(), 0.9, 1e-6)
	client:EnterCombat()
	questie:SetScale(1)
	trackerModule.Update() -- in combat: left alone
	lu.assertEquals(questie:GetScale(), 1)
	client:LeaveCombat()
	_G.QuestieLoader, _G.Questie_BaseFrame, _G.TrinketMenu_MainFrame = nil, nil, nil
	assertClean(client)
end

function TestOptionsMenu:test_scales_chosen_before_keep_their_size()
	-- 110% of the UI Scale is the new 100% (the minimap's: test_session_minimap.lua)
	client = nil
	boot({
		savedVariables = {
			DiabolicUI_DB = { ScreenScaling = { profiles = { global = { scale = 1.21 } } } },
		},
	})
	lu.assertEquals(db("ScreenScaling").scale, 1.1)
	-- only once
	lu.assertTrue(db("ScreenScaling").rebased)
	assertClean(client)
end

function TestOptionsMenu:test_trinketmenu_keeps_one_anchor()
	-- dragged once, the game's layout cache added an anchor to TrinketMenu's
	-- own: the window would stretch between them
	local trinkets = CreateFrame("Frame", "TrinketMenu_MainFrame", _G.UIParent)
	trinkets:SetSize(92, 52)
	trinkets:SetPoint("TOPLEFT", _G.UIParent, "BOTTOMLEFT", 400, 300)
	trinkets:SetPoint("BOTTOMRIGHT", _G.UIParent, "BOTTOMRIGHT", -20, 20)
	trinkets:SetUserPlaced(true)
	_G.TrinketMenuPerOptions = { XPos = 400, YPos = 300 }
	local menu = client:GetModule("Menu")
	menu:ApplyUIScale()
	lu.assertEquals(trinkets:GetNumPoints(), 1)
	lu.assertEquals({ trinkets:GetPoint() }, { "TOPLEFT", _G.UIParent, "BOTTOMLEFT", 400, 300 })
	lu.assertFalse(trinkets:IsUserPlaced() and true or false)
	-- in combat: left for later
	client:EnterCombat()
	trinkets:SetPoint("BOTTOMRIGHT", _G.UIParent, "BOTTOMRIGHT", -20, 20)
	menu:PinTrinketMenu()
	lu.assertEquals(trinkets:GetNumPoints(), 2)
	client:LeaveCombat()
	_G.TrinketMenuPerOptions, _G.TrinketMenu_MainFrame = nil, nil
	assertClean(client)
end

function TestOptionsMenu:test_trinketmenu_stays_on_screen_when_the_ui_scale_changes()
	local trinkets = CreateFrame("Frame", "TrinketMenu_MainFrame", _G.UIParent)
	trinkets:SetSize(92, 52)
	_G.TrinketMenuPerOptions = { XPos = 400, YPos = 300 }
	local menu = client:GetModule("Menu")
	menu:ApplyUIScale()
	local left, top =
		trinkets:GetLeft() * trinkets:GetEffectiveScale(), trinkets:GetTop() * trinkets:GetEffectiveScale()
	-- its saved spot converts to the new scale: same place on screen
	widget("UIScale"):SetValue(80)
	lu.assertAlmostEquals(_G.TrinketMenuPerOptions.XPos, 500, 1e-6)
	lu.assertAlmostEquals(_G.TrinketMenuPerOptions.YPos, 375, 1e-6)
	lu.assertAlmostEquals(trinkets:GetLeft() * trinkets:GetEffectiveScale(), left, 1e-6)
	lu.assertAlmostEquals(trinkets:GetTop() * trinkets:GetEffectiveScale(), top, 1e-6)
	widget("UIScale"):SetValue(100)
	lu.assertAlmostEquals(_G.TrinketMenuPerOptions.XPos, 400, 1e-6)

	-- a spot off the screen (saved at another scale) comes back to its edge
	local width, height = _G.UIParent:GetWidth(), _G.UIParent:GetHeight()
	_G.TrinketMenuPerOptions.XPos, _G.TrinketMenuPerOptions.YPos = width + 200, height + 100
	menu:PinTrinketMenu()
	lu.assertEquals({ _G.TrinketMenuPerOptions.XPos, _G.TrinketMenuPerOptions.YPos }, { width - 92, height })
	lu.assertEquals({ trinkets:GetRight(), trinkets:GetTop() }, { width, height })
	_G.TrinketMenuPerOptions.XPos, _G.TrinketMenuPerOptions.YPos = -50, 10
	menu:PinTrinketMenu()
	lu.assertEquals({ trinkets:GetLeft(), (trinkets:GetBottom()) }, { 0, 0 })
	_G.TrinketMenuPerOptions, _G.TrinketMenu_MainFrame = nil, nil
	widget("UIScale"):SetValue(100)
	assertClean(client)
end

function TestOptionsMenu:test_every_page_fits_in_the_window()
	local container = _G.InterfaceOptionsFramePanelContainer
	for _, panel in ipairs(client.optionsPanels) do
		if panel:GetName() and panel:GetName():find("^DiabolicUIOptionsPanel") then
			panel:SetAllPoints(container)
			for _, child in ipairs({ panel:GetChildren() }) do
				local bottom, right = child:GetBottom(), child:GetRight()
				if bottom and child:IsShown() then
					lu.assertTrue(bottom >= container:GetBottom(), panel:GetName() .. ": " .. tostring(child:GetName()))
				end
				-- (a dropdown's frame runs past its art, so those are left out)
				if right and child:IsShown() and not child.initialize then
					lu.assertTrue(
						right <= container:GetRight(),
						panel:GetName() .. ": " .. tostring(child:GetName()) .. " sticks out"
					)
				end
			end
		end
	end
	assertClean(client)
end

function TestOptionsMenu:test_cancel_on_the_main_page()
	local bars = db("ActionBars", "character")
	bars.showGold = true
	widget("ShowGold"):SetChecked(false)
	_G.DiabolicUIOptionsPanel.cancel()
	lu.assertEquals(widget("ShowGold"):GetChecked(), 1)
	local units = db("UnitFrames")
	units.showPortrait = true
	_G.DiabolicUIOptionsPanel.refresh()
	lu.assertEquals(widget("ShowPortrait"):GetChecked(), 1)
	assertClean(client)
end

function TestOptionsMenu:test_the_config_command()
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("config")
	lu.assertEquals(client.openedOptions, _G.DiabolicUIOptionsPanel)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
