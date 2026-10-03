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

function TestOptionsMenu:test_four_pages_under_diabolicui()
	local names = {}
	for _, panel in ipairs(client.optionsPanels) do
		if panel:GetName() and panel:GetName():find("^DiabolicUIOptionsPanel") then
			names[#names + 1] = (panel.parent and (panel.parent .. "/") or "") .. panel.name
		end
	end
	lu.assertEquals(names, { "DiabolicUI", "DiabolicUI/Tooltips", "DiabolicUI/Units", "DiabolicUI/Chat" })
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

	chat.timeVisible = 90
	_G.DiabolicUIOptionsPanelChat.refresh()
	lu.assertEquals(widget("ChatTimeVisibleInput"):GetText(), "90")
	assertClean(client)
end

function TestOptionsMenu:test_cancel_on_the_main_and_units_pages()
	local bars = db("ActionBars", "character")
	bars.showGold = true
	widget("ShowGold"):SetChecked(false)
	_G.DiabolicUIOptionsPanel.cancel()
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
