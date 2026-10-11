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
	lu.assertEquals(names, { "DiabolicUI", "DiabolicUI/Action Bars", "DiabolicUI/Specializations", "DiabolicUI/Tooltips", "DiabolicUI/Units",
		"DiabolicUI/Chat", "DiabolicUI/Messages", "DiabolicUI/Quests", "DiabolicUI/Frames & AddOns" })
	-- the main page: what's where, the commands and the version
	_G.DiabolicUIOptionsPanel.refresh()
	assertClean(client)
end

function TestOptionsMenu:test_the_menu_checkboxes()
	local bars = db("ActionBars", "character")
	local menu = client:GetModule("ActionBars"):GetWidget("Menu: Main")
	local gold = bars.showGold
	click("ShowGold")
	lu.assertEquals(bars.showGold, not gold)
	click("ShowGold")
	lu.assertEquals(bars.showGold, gold)
	local performance = bars.showPerformance
	click("ShowPerformance")
	lu.assertEquals(bars.showPerformance, not performance)
	lu.assertEquals(menu.MasterMenuButton.Performance:IsShown() == 1, not performance)
	local spec = client:GetModule("ActionBars"):GetWidget("Button: Spec Switch"):GetFrame()
	click("ShowSpecSwitch")
	lu.assertFalse(bars.showSpecSwitch)
	lu.assertNil(spec:IsShown())
	click("ShowSpecSwitch")
	lu.assertEquals(spec:IsShown(), 1)
	assertClean(client)
end

function TestOptionsMenu:test_the_tracker_fade_and_its_sliders()
	local objectives = db("ObjectiveTracker")
	objectives.fadeTracker = true
	widget("FadeTracker"):SetChecked(true)
	click("FadeTracker")
	lu.assertFalse(objectives.fadeTracker)
	-- greyed out while the fade is off
	local slider = widget("ObjectivesTimeFading")
	lu.assertEquals(slider:GetAlpha(), 0.5)
	lu.assertNil(widget("ObjectivesTimeFadingInput"):IsMouseEnabled())
	click("FadeTracker")
	lu.assertTrue(objectives.fadeTracker)
	lu.assertEquals(slider:GetAlpha(), 1)

	-- dragged: whole seconds, both ways in sync
	slider:SetValue(12.4)
	lu.assertEquals(objectives.fadeDelay, 12)
	lu.assertEquals(widget("ObjectivesTimeFadingInput"):GetText(), "12")
	-- typed in, kept in range
	enter("ObjectivesOpacity", "40")
	lu.assertEquals(objectives.fadeOpacity, 40)
	lu.assertEquals(widget("ObjectivesOpacity"):GetValue(), 40)
	enter("ObjectivesOpacity", "500")
	lu.assertEquals(objectives.fadeOpacity, 100)
	enter("ObjectivesOpacity", "-5")
	lu.assertEquals(objectives.fadeOpacity, 0)
	-- not a number, or escape: back to what it was
	enter("ObjectivesOpacity", "lots")
	lu.assertEquals(widget("ObjectivesOpacityInput"):GetText(), "0")
	widget("ObjectivesOpacityInput"):SetText("77")
	client:RunScript(widget("ObjectivesOpacityInput"), "OnEscapePressed")
	lu.assertEquals(widget("ObjectivesOpacityInput"):GetText(), "0")
	lu.assertEquals(objectives.fadeOpacity, 0)

	-- the entry box lights up on hover
	local input = widget("ObjectivesOpacityInput")
	client:Hover(input)
	lu.assertEquals(select(4, input:GetBackdropBorderColor()), 1)
	client:Leave()
	assertClean(client)
end

function TestOptionsMenu:test_settings_needing_a_reload_ask_for_it()
	local loot = db("LootFrame")
	click("ReskinLoot")
	lu.assertTrue(loot.enableSkin)
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

	-- clicked back without a change: no question
	popupFrame("ENGINE_GENERAL_RELOADUI"):Hide()
	widget("ShowPortrait"):SetChecked(units.showPortrait)
	client:RunScript(widget("ShowPortrait"), "OnClick", "LeftButton")
	lu.assertNil(popupFrame("ENGINE_GENERAL_RELOADUI"))
	assertClean(client)
end

function TestOptionsMenu:test_the_tooltip_page()
	local tooltips = db("Tooltips")
	click("ReskinTooltip")
	lu.assertEquals(tooltips.reskinTooltip, widget("ReskinTooltip"):GetChecked() and true or false)

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
	_G.DiabolicUIOptionsPanelTooltips.cancel()
	lu.assertEquals(widget("TooltipOffsetX"):GetValue(), 40)
	lu.assertEquals(widget("AnchorCENTER"):GetChecked(), 1)
	assertClean(client)
end

function TestOptionsMenu:test_descriptions_on_hover()
	-- the anchor picker's label
	local label
	for _, region in ipairs({ _G.DiabolicUIOptionsPanelTooltips:GetRegions() }) do
		if region:GetObjectType() == "FontString" and region:GetText() == client.Engine:GetLocale()["Tooltip mouse anchor"] then
			label = region
		end
	end
	local hitbox
	for _, child in ipairs({ _G.DiabolicUIOptionsPanelTooltips:GetChildren() }) do
		if child:GetPoint() and select(2, child:GetPoint()) == label then
			hitbox = child
		end
	end
	client:Hover(hitbox)
	lu.assertEquals(tooltipLines(_G.GameTooltip)[1], label:GetText())
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())

	client:Hover(widget("ToggleFakeParty"))
	lu.assertEquals(tooltipLines(_G.GameTooltip)[1], widget("ToggleFakeParty"):GetText())
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())
	assertClean(client)
end

function TestOptionsMenu:test_the_fake_group_buttons()
	local units = db("UnitFrames")
	client:Click(widget("ToggleFakeParty"))
	lu.assertTrue(units.testPartyMode)
	client:Click(widget("ToggleFakeRaid"))
	lu.assertTrue(units.testRaidMode)
	client:Click(widget("ToggleFakeParty"))
	client:Click(widget("ToggleFakeRaid"))
	lu.assertFalse(units.testPartyMode)
	lu.assertFalse(units.testRaidMode)
	assertClean(client)
end

function TestOptionsMenu:test_the_chat_page()
	local chat, filters = db("ChatWindows"), db("ChatFilters")
	widget("ChatBackgroundOpacity"):SetValue(60)
	lu.assertEquals(chat.backgroundOpacity, 60)

	chat.fadeChat = true
	widget("FadeChat"):SetChecked(true)
	click("FadeChat")
	lu.assertFalse(chat.fadeChat)
	lu.assertNil(_G.ChatFrame1:GetFading())
	lu.assertEquals(widget("ChatTimeVisible"):GetAlpha(), 0.5)
	click("FadeChat")
	widget("ChatTimeFading"):SetValue(4)
	lu.assertEquals(_G.CHAT_FRAME_FADE_OUT_TIME, 4)
	widget("ChatTimeVisible"):SetValue(30)
	lu.assertEquals(_G.ChatFrame1:GetTimeVisible(), 30)

	local copy = filters.copyWebLinks
	click("ChatCopyWebLinks")
	lu.assertEquals(filters.copyWebLinks, not copy)

	-- the shorter messages, on their own page, one checkbox each
	for i, setting in ipairs({ "cleanProgress", "cleanQuests", "cleanStatus", "cleanOnline",
		"cleanLoot", "cleanAuctions", "cleanAchievements", "hideChatNoise" }) do
		local before = filters[setting]
		click("MessagesCleaner" .. i)
		lu.assertEquals(filters[setting], not before, setting)
		filters[setting] = before
	end
	_G.DiabolicUIOptionsPanelMessages.refresh()
	lu.assertEquals(widget("MessagesCleaner1"):GetChecked() and true or false, filters.cleanProgress)

	chat.timeVisible = 90
	_G.DiabolicUIOptionsPanelChat.refresh()
	lu.assertEquals(widget("ChatTimeVisibleInput"):GetText(), "90")
	assertClean(client)
end

-- Every page fits in Blizzard's options window (648x520, its pages
-- 424 high): the lowest widget of each stays above the page's bottom.
-- The texts and icons of the Specializations page's regions.
local function specsRegions()
	local texts, icons = {}, {}
	for _, region in ipairs({ _G.DiabolicUIOptionsPanelSpecs:GetRegions() }) do
		if region:GetObjectType() == "FontString" then
			texts[region:GetText() or ""] = true
		elseif region:GetObjectType() == "Texture" then
			icons[region:GetTexture() or ""] = true
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
	client.world.talents = { { "Discipline", "Interface\\Icons\\Disc", 13 }, { "Holy", "Interface\\Icons\\Holy", 58 }, { "Shadow", "", 0 } }
	client.world.secondaryTalents = { { "Discipline", "", 14 }, { "Holy", "", 0 }, { "Shadow", "Interface\\Icons\\Shadow", 57 } }
	client.world.equipmentSets = { { "Holy", "Interface\\Icons\\HolySet" }, { "Shadow", "Interface\\Icons\\ShadowSet" } }
	bars.specEquipSet2, bars.specBars2 = "Shadow", 3
	_G.DiabolicUIOptionsPanelSpecs.refresh()

	-- one column per specialization: its icon and name over its settings
	local texts, icons = specsRegions()
	lu.assertTrue(texts.Holy and texts.Shadow)
	lu.assertTrue(icons["Interface\\Icons\\Holy"] and icons["Interface\\Icons\\Shadow"])
	lu.assertEquals(widget("Spec2EquipSet").text, "|TInterface\\Icons\\ShadowSet:16:16:0:0|t Shadow")
	lu.assertEquals(widget("Spec1EquipSet").text, L["None"])
	lu.assertEquals(widget("Spec2Bars").text, "3")
	lu.assertEquals(widget("Spec2SideBars").text, L["Unchanged"])
	lu.assertEquals(widget("Spec1Profile").text, "|cff808080" .. L["Action Bar Saver isn't loaded"] .. "|r")

	-- picking from the dropdowns saves
	lu.assertEquals(openDropDown("Spec1EquipSet", "|TInterface\\Icons\\HolySet:16:16:0:0|t Holy"),
		{ L["None"], "|TInterface\\Icons\\HolySet:16:16:0:0|t Holy", "|TInterface\\Icons\\ShadowSet:16:16:0:0|t Shadow" })
	lu.assertEquals(bars.specEquipSet1, "Holy")
	lu.assertEquals(widget("Spec1EquipSet").text, "|TInterface\\Icons\\HolySet:16:16:0:0|t Holy")
	lu.assertEquals(openDropDown("Spec1Bars", "2"), { L["Unchanged"], "1", "2", "3" })
	lu.assertEquals(bars.specBars1, 2)
	lu.assertEquals(openDropDown("Spec1SideBars", "0"), { L["Unchanged"], "0", "1", "2" })
	lu.assertEquals(bars.specSideBars1, 0)
	openDropDown("Spec2Bars", L["Unchanged"])
	lu.assertFalse(bars.specBars2)

	-- Action Bar Saver loaded: its profiles
	_G.SlashCmdList.ABS = function() end
	_G.ActionBarSaverDB = { sets = { WARRIOR = { holy = {}, shadow = {} } } }
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	lu.assertEquals(widget("Spec1Profile").text, L["None"])
	lu.assertEquals(openDropDown("Spec1Profile", "holy"), { L["None"], "holy", "shadow" })
	lu.assertEquals(bars.specProfile1, "holy")

	-- a saved set that's gone shows greyed out
	client.world.equipmentSets = {}
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	lu.assertEquals(widget("Spec1EquipSet").text, "|cff808080Holy|r")
	_G.SlashCmdList.ABS, _G.ActionBarSaverDB = nil, nil

	-- no points spent yet: the group's name and a question mark
	client.world.secondaryTalents = { { "Discipline", "", 0 }, { "Holy", "", 0 }, { "Shadow", "", 0 } }
	_G.DiabolicUIOptionsPanelSpecs.refresh()
	texts, icons = specsRegions()
	lu.assertTrue(texts[_G.SECONDARY])
	lu.assertTrue(icons["Interface\\Icons\\INV_Misc_QuestionMark"])

	lu.assertTrue(texts[L["Macro Before"]] and texts[L["Macro After"]])
	assertClean(client)
end

function TestOptionsMenu:test_the_specialization_macros()
	local L = client.Engine:GetLocale()
	local bars = db("ActionBars", "character")
	client.world.macros = { [1] = { "Toy", "Interface\\Icons\\Toy", "/use item:44430" }, [37] = { "DUI Holy", "Interface\\Icons\\Q", "" } }
	bars.specMacroName2 = "Toy"
	_G.DiabolicUIOptionsPanelSpecs.refresh()

	lu.assertEquals(widget("Spec1Macro").text, L["None"])
	lu.assertEquals(widget("Spec2Macro").text, "|TInterface\\Icons\\Toy:16:16:0:0|t Toy")
	lu.assertEquals(openDropDown("Spec1Macro", "|TInterface\\Icons\\Q:16:16:0:0|t DUI Holy"),
		{ L["None"], "|TInterface\\Icons\\Toy:16:16:0:0|t Toy", "|TInterface\\Icons\\Q:16:16:0:0|t DUI Holy" })
	lu.assertEquals(bars.specMacroName1, "DUI Holy")
	openDropDown("Spec2Macro", L["None"])
	lu.assertFalse(bars.specMacroName2)

	-- they run on a click of the skull's button: greyed out without it
	click("ShowSpecSwitch")
	lu.assertFalse(bars.showSpecSwitch)
	lu.assertEquals(widget("Spec1Macro").text, "|cff808080" .. L["Needs Show Specialization Switch"] .. "|r")
	click("ShowSpecSwitch")
	lu.assertEquals(widget("Spec1Macro").text, "|TInterface\\Icons\\Q:16:16:0:0|t DUI Holy")
	assertClean(client)
end

function TestOptionsMenu:test_the_addons_page_and_the_tracker_buttons()
	local L = client.Engine:GetLocale()
	local skins = db("AddOnSkins")
	-- each styling asks for a reload when it changes
	for _, case in ipairs({ { "StyleTrinketMenu", "styleTrinketMenu" }, { "StyleWorldMap", "styleWorldMap" }, { "StyleTracker", "styleTracker" } }) do
		click(case[1])
		lu.assertFalse(skins[case[2]])
		local popup = popupFrame("ENGINE_GENERAL_RELOADUI")
		lu.assertNotNil(popup, case[1])
		popup:Hide()
		-- clicked back without a change: no question
		widget(case[1]):SetChecked(skins[case[2]])
		client:RunScript(widget(case[1]), "OnClick", "LeftButton")
		lu.assertNil(popupFrame("ENGINE_GENERAL_RELOADUI"), case[1])
	end
	_G.DiabolicUIOptionsPanelAddOns.refresh()
	lu.assertNil(widget("StyleTrinketMenu"):GetChecked())

	-- unlocking and resetting Blizzard's tracker
	local tracker = client:GetModule("ObjectiveTracker")
	local unlock = widget("UnlockTracker")
	client:Click(unlock)
	lu.assertTrue(tracker:IsTrackerUnlocked())
	lu.assertEquals(unlock:GetText(), L["Lock Tracker"])
	_G.DiabolicUIOptionsPanelQuests.refresh()
	lu.assertEquals(unlock:GetText(), L["Lock Tracker"])
	client:Click(unlock)
	lu.assertFalse(tracker:IsTrackerUnlocked())
	client:Click(unlock)
	client:Click(widget("ResetTracker"))
	lu.assertFalse(tracker:IsTrackerUnlocked())
	lu.assertEquals(unlock:GetText(), L["Unlock Tracker"])

	-- the chat slide
	local chat = db("ChatWindows")
	click("ChatSlideMessages")
	lu.assertFalse(chat.slideMessages) -- on by default
	click("ChatSlideMessages")
	lu.assertTrue(chat.slideMessages)

	-- a specialization label's description on hover
	local label
	for _, child in ipairs({ _G.DiabolicUIOptionsPanelSpecs:GetChildren() }) do
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
					lu.assertTrue(right <= container:GetRight(), panel:GetName() .. ": " .. tostring(child:GetName()) .. " sticks out")
				end
			end
		end
	end
	assertClean(client)
end

function TestOptionsMenu:test_cancel_on_the_action_bars_and_units_pages()
	local bars = db("ActionBars", "character")
	bars.showGold = true
	widget("ShowGold"):SetChecked(false)
	_G.DiabolicUIOptionsPanelActionBars.cancel()
	lu.assertEquals(widget("ShowGold"):GetChecked(), 1)
	local units = db("UnitFrames")
	units.showPortrait = true
	_G.DiabolicUIOptionsPanelUnits.refresh()
	lu.assertEquals(widget("ShowPortrait"):GetChecked(), 1)
	assertClean(client)
end

function TestOptionsMenu:test_the_config_command()
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("config")
	lu.assertEquals(client.openedOptions, _G.DiabolicUIOptionsPanel)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
