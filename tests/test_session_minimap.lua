-- Run from the addon root: lua5.1 tests/test_session_minimap.lua
--
-- The minimap module (modules/minimap) in the fake client: the
-- Diabolic look replacing Blizzard's minimap pieces, the zone name with its
-- fade, the clock and its tooltip, the mail button, the compass on a
-- rotating minimap, zooming and clicking, edit mode (drag to move, right
-- drag to resize, saved and restored), the options page, the MinimapButtonBag
-- integration, the settings brought over from 1.6.6, and the /clear and /go
-- commands.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client, module, db, config

local function boot(options)
	client = Client.boot(options or {})
	module = client:GetModule("Minimap")
	db = client.Engine:GetConfig("Minimap")
	config = client.Engine:GetDB("Minimap")
	client:Tick(0.1)
end

local function slash(key, text)
	_G.SlashCmdList[key](text or "")
end

TestMinimap = {}

function TestMinimap:setUp()
	boot()
end

function TestMinimap:tearDown()
	client, module, db, config = nil, nil, nil, nil
end

function TestMinimap:test_the_diabolic_look_replaces_blizzards_pieces()
	for _, name in ipairs({
		"MinimapBorder",
		"MinimapBorderTop",
		"GameTimeFrame",
		"MiniMapTracking",
		"MinimapZoneTextButton",
		"MinimapZoomIn",
		"MinimapZoomOut",
		"MiniMapWorldMapButton",
		"MiniMapMailFrame",
		"MiniMapInstanceDifficulty",
		"TimeManagerClockButton",
	}) do
		lu.assertEquals(_G[name]:GetParent(), module.hider, name)
	end
	-- the dungeon finder eye becomes a border button
	lu.assertEquals(_G.MiniMapLFGFrame:GetParent(), _G.Minimap)
	lu.assertEquals({ _G.MiniMapLFGFrame:GetSize() }, { 48, 48 })
	lu.assertNil(_G.MiniMapLFGFrameBorder:IsShown())
	lu.assertEquals(_G.MiniMapLFGFrame:GetHighlightTexture():IsDesaturated(), 1)
	-- the battleground queue button, bottom left
	lu.assertEquals(select(1, _G.MiniMapBattlefieldFrame:GetPoint()), "BOTTOMLEFT")
	lu.assertNil(_G.MiniMapBattlefieldIcon:IsShown())
	-- scaled from the saved size
	lu.assertAlmostEquals(_G.Minimap:GetScale(), module:GetBaseScale(), 0.0001)
	-- the stopwatch's saved settings exist
	lu.assertNotNil(_G.BlizzardStopwatchOptions)
	assertClean(client)
end

function TestMinimap:test_the_zone_name_fades_to_the_new_zone()
	client.world.zone.minimap = "Valley of Trials"
	client.world.zone.pvpType = "hostile"
	client:FireEvent("ZONE_CHANGED")
	client:Tick(0.1)
	lu.assertTrue(module.zoneName:GetAlpha() < 0.85, "fading out")
	client:Tick(1)
	lu.assertEquals(module.zoneName:GetText(), "Valley of Trials")
	lu.assertAlmostEquals(module.zoneName:GetAlpha(), 0.85, 0.001)
	local r = module.zoneName:GetTextColor()
	lu.assertAlmostEquals(r, 175 / 255, 0.001)

	-- the same zone again (a PvP status update): no fade
	client:FireEvent("ZONE_CHANGED_INDOORS")
	lu.assertAlmostEquals(module.zoneName:GetAlpha(), 0.85, 0.001)

	-- a PvP status change in the same zone: its new color at once
	client.world.zone.pvpType = "sanctuary"
	client:FireEvent("ZONE_CHANGED")
	lu.assertAlmostEquals(module.zoneName:GetTextColor(), 104 / 255, 0.001)

	-- unknown PvP types are gold
	client.world.zone.minimap = "Durotar"
	client.world.zone.pvpType = nil
	client:FireEvent("ZONE_CHANGED_NEW_AREA")
	client:Tick(1)
	lu.assertEquals(module.zoneName:GetText(), "Durotar")
	lu.assertAlmostEquals(module.zoneName:GetTextColor(), config.colors.normal[1], 0.001)
	assertClean(client)
end

function TestMinimap:test_the_clock_and_its_tooltip()
	-- the computer's time, the realm's in its tooltip
	client.world.gameTime = { 21, 5 }
	client:Tick(1.1)
	lu.assertEquals(module.time:GetText(), os.date("%H:%M"))

	local button = module.time:GetParent()
	client:Hover(button)
	local lines = table.concat(Session.tooltipLines(_G.GameTooltip), "\n")
	lu.assertStrContains(lines, "21:05")
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())

	client:Click(button)
	lu.assertEquals(client.toggled, "Calendar")
	client.toggled = nil
	client:EnterCombat()
	client:Click(button)
	lu.assertNil(client.toggled, "not in combat")
	client:LeaveCombat()
	assertClean(client)
end

function TestMinimap:test_the_mail_button_and_its_senders()
	lu.assertNil(module.mail:IsShown())
	client.world.mail = true
	client:FireEvent("UPDATE_PENDING_MAIL")
	lu.assertEquals(module.mail:IsShown(), 1)

	local button = select(1, module.mail.frame:GetChildren())
	client.world.mailSenders = { "Thrall", "Jaina", "Arthas" }
	client:Hover(button)
	local lines = table.concat(Session.tooltipLines(_G.GameTooltip), "\n")
	lu.assertStrContains(lines, "Arthas")
	client.world.mailSenders = {}
	client:Hover(button)
	lu.assertStrContains(_G.GameTooltipTextLeft1:GetText(), _G.HAVE_MAIL)
	client:Leave()

	client.world.mail = false
	client:FireEvent("UPDATE_PENDING_MAIL")
	lu.assertNil(module.mail:IsShown())
	assertClean(client)
end

function TestMinimap:test_the_compass_turns_with_a_rotating_minimap()
	lu.assertEquals(module.compass:GetAlpha(), 0)
	client.world.cvars.rotateMinimap = "1"
	client.world.facing = math.pi / 2
	client:FireEvent("CVAR_UPDATE", "ROTATE_MINIMAP", "1")
	client:Tick(0.1)
	lu.assertEquals(module.compass:GetAlpha(), 1)
	local _, _, _, x = module.compass.north:GetPoint()
	lu.assertTrue(x > 0, "north moved right when facing west")

	client.world.facing = nil -- no facing (a cinematic)
	client:Tick(0.1)
	lu.assertEquals(module.compass:GetAlpha(), 0)

	client.world.cvars.rotateMinimap = "0"
	client:FireEvent("CVAR_UPDATE", "ROTATE_MINIMAP", "0")
	lu.assertNil(module.compass:GetScript("OnUpdate"))
	lu.assertEquals(module.compass:GetAlpha(), 0)
	assertClean(client)
end

function TestMinimap:test_wheel_zooms_and_clicks()
	_G.Minimap:SetZoom(2)
	client:RunScript(_G.Minimap, "OnMouseWheel", 1)
	lu.assertEquals(_G.Minimap:GetZoom(), 3)
	client:RunScript(_G.Minimap, "OnMouseWheel", -1)
	lu.assertEquals(_G.Minimap:GetZoom(), 2)
	client:RunScript(_G.Minimap, "OnMouseUp", "LeftButton")
	lu.assertTrue(client.minimapPinged)
	client:RunScript(_G.Minimap, "OnMouseUp", "RightButton")
	lu.assertEquals(client.openDropDown, _G.MiniMapTrackingDropDown)
	assertClean(client)
end

-- Edit mode ------------------------------------------------------------------

local function overlay()
	return module.editHighlight
end

function TestMinimap:test_edit_mode_moves_and_resizes_the_minimap()
	module:EnterEditMode()
	lu.assertTrue(module:IsEditModeActive())
	lu.assertEquals(overlay():IsShown(), 1)
	module:EnterEditMode() -- already on

	-- left drag: move
	client:RunScript(overlay(), "OnDragStart", "LeftButton")
	_G.Minimap:ClearAllPoints()
	_G.Minimap:SetPoint("CENTER", _G.UIParent, "CENTER", -600, 0) -- the drag moved it left
	client:RunScript(overlay(), "OnDragStop")
	lu.assertEquals(db.position.point, "LEFT")
	-- on the left half, the outer elements mirror
	lu.assertEquals(select(1, _G.MiniMapLFGFrame:GetPoint()), "TOPLEFT")
	lu.assertEquals(select(1, module.zoneName:GetPoint()), "TOPLEFT")
	lu.assertEquals(select(1, module.mail.frame:GetPoint()), "TOPRIGHT")

	-- right drag: resize, within the limits
	client.world.cursor = { 500, 500 }
	client:RunScript(overlay(), "OnDragStart", "RightButton")
	client.world.cursor = { 600, 400 }
	client:Tick(0.1)
	lu.assertTrue(module:GetUserScale() > 1)
	client.world.cursor = { 5000, -5000 }
	client:Tick(0.1)
	lu.assertEquals(module:GetUserScale(), 1.5)
	client.world.cursor = { -5000, 5000 }
	client:Tick(0.1)
	lu.assertEquals(module:GetUserScale(), 0.5)
	client:RunScript(overlay(), "OnDragStop")

	-- left (DiabolicUI's Lock Frames does it, see test_session_menu.lua)
	module:ExitEditMode()
	lu.assertFalse(module:IsEditModeActive())
	lu.assertNil(overlay():IsShown())
	module:ExitEditMode() -- already off
	assertClean(client)
end

function TestMinimap:test_its_art_keeps_its_proportions_at_any_size()
	-- the border, clock and zone text grow and shrink with the map
	for _, size in ipairs({ 0.5, 1, 1.5 }) do
		module:SetUserScale(size)
		lu.assertAlmostEquals(module.widgetFrame:GetScale(), 1 / 1.614, 1e-6)
		-- the frame its border buttons sit on too: laid out for the Diabolic size
		lu.assertAlmostEquals(_G.Minimap:GetWidth(), 280 / 1.614, 1e-6)
	end
	assertClean(client)
end

function TestMinimap:test_no_edit_mode_in_combat_and_resizes_wait_for_its_end()
	client:EnterCombat()
	module:EnterEditMode()
	lu.assertFalse(module:IsEditModeActive())
	local before = _G.Minimap:GetScale()
	module:SetUserScale(1.2)
	lu.assertEquals(_G.Minimap:GetScale(), before)
	client:LeaveCombat()
	lu.assertAlmostEquals(_G.Minimap:GetScale(), module:GetBaseScale() * 1.2, 0.0001)
	client:FireEvent("PLAYER_REGEN_ENABLED") -- nothing pending: nothing to do
	assertClean(client)
end

function TestMinimap:test_the_saved_position_comes_back_after_a_reload()
	module:EnterEditMode()
	client:RunScript(overlay(), "OnDragStart", "LeftButton")
	_G.Minimap:ClearAllPoints()
	_G.Minimap:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 100, 100)
	module:ExitEditMode() -- left mid-drag
	client:FireEvent("PLAYER_LOGOUT")
	boot({ savedVariables = { DiabolicUI_DB = _G.DiabolicUI_DB } })
	lu.assertEquals(select(1, _G.Minimap:GetPoint()), "BOTTOMLEFT")
	-- a late VARIABLES_LOADED (3.3.5) applies them again, and the stopwatch
	-- settings Blizzard_TimeManager lost are made again
	_G.BlizzardStopwatchOptions = nil
	client:FireEvent("VARIABLES_LOADED")
	lu.assertNotNil(_G.BlizzardStopwatchOptions)
	lu.assertEquals(select(1, _G.Minimap:GetPoint()), "BOTTOMLEFT")
	assertClean(client)
end

function TestMinimap:test_positions_are_saved_relative_to_the_nearest_edge()
	local cases = {
		{ "TOP", 0, -30, "TOP" },
		{ "RIGHT", -30, 0, "RIGHT" },
		{ "CENTER", 0, 0, "CENTER" },
		{ "BOTTOM", 0, 30, "BOTTOM" },
		{ "BOTTOMRIGHT", -30, 30, "BOTTOMRIGHT" },
		{ "TOPLEFT", 30, -30, "TOPLEFT" },
	}
	-- (the fake client lays frames out without their scales: at scale 1,
	-- what it computes is what the game would)
	_G.Minimap:SetScale(1)
	for _, case in ipairs(cases) do
		_G.Minimap:ClearAllPoints()
		_G.Minimap:SetPoint(case[1], _G.UIParent, case[1], case[2], case[3])
		module:SavePosition()
		lu.assertEquals(db.position.point, case[4])
	end
	-- not placed anywhere
	_G.Minimap:ClearAllPoints()
	lu.assertEquals({ module:GetAnchor() }, { "CENTER", 0, 0 })
	assertClean(client)
end

-- Settings from 1.6.6 ------------------------------------------------------------

-- the minimap's own saved variable then: its size, /setscale's and its place
local function bootWithOld(minimap, core)
	boot({ savedVariables = { DiabolicUI_Minimap_DB = { global = { minimap = minimap, core = core } } } })
end

function TestMinimap:test_its_settings_up_to_1_6_6_are_brought_over_once()
	local position = { point = "LEFT", x = 30, y = 0 }
	bootWithOld({ userScale = 0.8, sizeRebased = true, storedPosition = position }, { relativeScale = 1.2 })
	lu.assertEquals(db.size, 0.96, "/setscale multiplied it")
	lu.assertEquals(db.position.point, "LEFT")
	lu.assertEquals(select(1, _G.Minimap:GetPoint()), "LEFT")
	lu.assertNil(_G.DiabolicUI_Minimap_DB, "then dropped")

	-- counted from the original Diabolic size's 100%: beyond the slider's 150%
	bootWithOld({ userScale = 1.6 })
	lu.assertEquals(db.size, 1.5)
	-- saved against the 100% it briefly had (.64 of the original)
	bootWithOld({ userScale = 1.25, sizeBase = 0.64 })
	lu.assertEquals(db.size, 1)
	-- already against this 100%
	bootWithOld({ userScale = 0.8, sizeRebased = true })
	lu.assertEquals(db.size, 0.8)
	-- never resized
	bootWithOld({})
	lu.assertEquals(db.size, 1)
	assertClean(client)
end

-- Commands -----------------------------------------------------------------------

function TestMinimap:test_clear_empties_the_shown_chat_frames()
	_G.ChatFrame1:AddMessage("Hello")
	_G.ChatFrame3:AddMessage("Hidden")
	slash("DIABOLICUICLEAR")
	lu.assertEquals(_G.ChatFrame1:GetNumMessages(), 0)
	lu.assertEquals(_G.ChatFrame3:GetNumMessages(), 1, "hidden frames are left alone")
	assertClean(client)
end

function TestMinimap:test_go_switches_to_another_goldpaw_ui()
	table.insert(client.world.addons, { name = "DiabolicUI2", enabled = false })
	table.insert(client.world.addons, { name = "AzeriteUI", enabled = true })
	table.insert(client.world.addons, { name = "DiabolicUI", enabled = true, loaded = true })
	lu.assertEquals(_G.SLASH_DIABOLICUIGO2, "/switchto")
	slash("DIABOLICUIGO", "nothing")
	lu.assertNil(client.reloaded)
	slash("DIABOLICUIGO", "Diabolic")
	lu.assertEquals(client.reloaded, 1)
	lu.assertTrue(client.api.GetAddOnInfo("DiabolicUI2") ~= nil)
	lu.assertEquals(select(4, client.api.GetAddOnInfo("DiabolicUI2")), 1)
	lu.assertNil(select(4, client.api.GetAddOnInfo("AzeriteUI")))
	lu.assertNil(select(4, client.api.GetAddOnInfo("DiabolicUI")))
	assertClean(client)
end

-- The addons' minimap buttons --------------------------------------------------

-- Addons' minimap buttons made at login (LibDBIcon's names), one hidden, a
-- map pin and an unclickable frame, then the world entered.
local function makeButtons()
	for _, name in ipairs({ "LibDBIcon10_SomeAddon", "LibDBIcon10_Hidden", "LibDBIcon10_Questie" }) do
		local button = _G.CreateFrame("Button", name, _G.Minimap)
		button:SetSize(31, 31)
		button:SetScript("OnClick", function() end)
		button:RegisterForDrag("LeftButton")
	end
	_G.LibDBIcon10_Hidden:Hide()
	_G.CreateFrame("Button", "QuestieFrame1", _G.Minimap):SetScript("OnClick", function() end)
	_G.CreateFrame("Button", "SomeAddonNoClick", _G.Minimap)
	client:FireEvent("PLAYER_ENTERING_WORLD")
end

function TestMinimap:test_the_addons_buttons_go_in_a_drawer()
	makeButtons()
	local buttons = client:GetModule("Minimap: Buttons")
	local button, plus, drawer = _G.LibDBIcon10_SomeAddon, buttons.toggle, buttons.drawer
	-- off the minimap, into the closed drawer; pins and the unclickable left
	lu.assertEquals(button:GetParent(), drawer)
	lu.assertEquals(_G.LibDBIcon10_Questie:GetParent(), drawer)
	lu.assertEquals(_G.QuestieFrame1:GetParent(), _G.Minimap)
	lu.assertEquals(_G.SomeAddonNoClick:GetParent(), _G.Minimap)
	lu.assertEvalToFalse(drawer:IsShown())
	lu.assertEquals(module.buttonsToggle, plus)
	lu.assertEquals(select(1, plus:GetPoint()), "BOTTOMLEFT")
	client:Hover(plus)
	lu.assertEquals(_G.GameTooltipTextLeft1:GetText(), "Minimap Buttons")
	client:Leave()

	-- the "+" opens it under itself, towards the screen's middle: the shown
	-- buttons only, in a row
	client:Click(plus)
	lu.assertEvalToTrue(drawer:IsShown())
	lu.assertEquals({ drawer:GetPoint() }, { "TOPRIGHT", plus, "BOTTOMLEFT", 0, 0 })
	lu.assertEquals(
		{ button:GetPoint() },
		{ "TOPLEFT", drawer, "TOPLEFT", config.buttons.padding, -config.buttons.padding }
	)
	lu.assertEquals(drawer:GetWidth(), config.buttons.padding * 2 + config.buttons.cell * 2)
	-- its addon can't move it back
	button:ClearAllPoints()
	button:SetPoint("CENTER", _G.Minimap, "CENTER")
	lu.assertEquals(select(1, button:GetPoint()), "TOPLEFT")
	client:Click(plus)
	lu.assertEvalToFalse(drawer:IsShown())

	-- a button made later is gathered when the drawer opens
	local late = _G.CreateFrame("Button", "LateAddonButton", _G.Minimap)
	late:SetScript("OnClick", function() end)
	client:Click(plus)
	lu.assertEquals(late:GetParent(), drawer)
	lu.assertEquals(drawer:GetWidth(), config.buttons.padding * 2 + config.buttons.cell * 3)

	-- edit mode's box covers the "+", drawn over it
	module:EnterEditMode()
	local box = module.editHighlight
	lu.assertTrue(box:GetLeft() <= plus:GetLeft() and box:GetRight() >= plus:GetRight())
	lu.assertTrue(box:GetTop() >= plus:GetTop() and box:GetBottom() <= plus:GetBottom())
	module:ExitEditMode()

	-- the minimap moves left: the "+" and the drawer mirror
	_G.Minimap:ClearAllPoints()
	_G.Minimap:SetPoint("LEFT", _G.UIParent, "LEFT", 30, 0)
	module:SavePosition()
	lu.assertEquals(select(1, plus:GetPoint()), "BOTTOMRIGHT")
	client:Click(plus)
	client:Click(plus)
	lu.assertEquals({ drawer:GetPoint() }, { "TOPLEFT", plus, "BOTTOMRIGHT", 0, 0 })
	assertClean(client)
end

function TestMinimap:test_no_addon_buttons_no_plus()
	local buttons = client:GetModule("Minimap: Buttons")
	lu.assertEvalToFalse(buttons.toggle:IsShown())
	assertClean(client)
end

function TestMinimap:test_minimap_button_bag_turns_the_drawer_off()
	boot({
		world = function(world)
			table.insert(world.addons, { name = "MBB", enabled = true })
		end,
	})
	lu.assertNil(client:GetModule("Minimap: Buttons").toggle)
	lu.assertNil(module.buttonsToggle)
	lu.assertTrue(client.Engine:GetAddOnConflicts().MBB)
	client:ClearProblems()
end

-- The options page --------------------------------------------------------------

-- the Positions page, in the open options window, with its minimap card's
-- size slider and box and its anchor radios
local function panel()
	_G.InterfaceOptionsFrame:Show()
	local page = _G.DiabolicUIOptionsPanelPositions
	page.sizeSlider = _G.DiabolicUIOptionsPanelMinimapSize
	page.sizeInput = _G.DiabolicUIOptionsPanelMinimapSizeInput
	page.anchorRadios = {}
	for _, point in ipairs({ "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }) do
		page.anchorRadios[point] = _G["DiabolicUIOptionsPanelMinimapAnchor" .. point]
	end
	return page
end

function TestMinimap:test_its_options_are_on_the_positions_page()
	local page = panel()
	lu.assertIs(page, _G.DiabolicUIOptionsPanelPositions)
	_G.Minimap:SetScale(1) -- (the fake client lays frames out without their scales)
	page:Show()
	page.refresh()
	lu.assertEquals(page.sizeInput:GetText(), "100")
	lu.assertEquals(page.anchorRadios.TOPRIGHT:GetChecked(), 1)
	client:Tick(0.3) -- kept live while open
	assertClean(client)
end

function TestMinimap:test_the_anchor_picker_snaps_the_minimap()
	local page = panel()
	page:Show()
	client:Click(page.anchorRadios.BOTTOMLEFT)
	lu.assertEquals(db.position.point, "BOTTOMLEFT")
	lu.assertEquals(select(1, _G.Minimap:GetPoint()), "BOTTOMLEFT")
	assertClean(client)
end

function TestMinimap:test_the_size_slider_and_its_box()
	local page = panel()
	page:Show()
	page.sizeSlider:SetValue(120)
	lu.assertEquals(module:GetUserScale(), 1.2)
	lu.assertEquals(page.sizeInput:GetText(), "120")

	-- typed values, clamped to the limits
	for _, case in ipairs({ { "120", 1.2 }, { "999", 1.5 }, { "1", 0.5 } }) do
		page.sizeInput:SetFocus()
		page.sizeInput:SetText(case[1])
		client:RunScript(page.sizeInput, "OnEnterPressed")
		lu.assertEquals(module:GetUserScale(), case[2])
	end
	page.sizeInput:SetFocus()
	page.sizeInput:SetText("90")
	page.sizeInput:ClearFocus() -- leaving the box commits it too
	lu.assertEquals(module:GetUserScale(), 0.9)
	page.sizeInput:SetFocus()
	page.sizeInput:SetText("abc")
	client:RunScript(page.sizeInput, "OnEscapePressed")
	lu.assertEquals(module:GetUserScale(), 0.9)

	-- kept live, but not over the box while it's being typed in
	page.sizeInput:SetFocus()
	page.sizeInput:SetText("7")
	client:Tick(0.3)
	lu.assertEquals(page.sizeInput:GetText(), "7")
	client:RunScript(page.sizeInput, "OnEscapePressed")
	lu.assertEquals(page.sizeInput:GetText(), "90")
	assertClean(client)
end

function TestMinimap:test_the_tooltips()
	local page = panel()
	page:Show()
	for _, widget in ipairs(client:WidgetsWithScript("OnEnter")) do
		local s = Client.Widgets.state[widget]
		local parent = s.parent
		while parent and parent ~= page do
			parent = Client.Widgets.state[parent].parent
		end
		if parent == page then
			client:Hover(widget)
			client:Leave()
		end
	end
	assertClean(client)
end

function TestMinimap:test_the_overlay_waits_for_a_drag_and_the_panel_is_made_once()
	module:EnterEditMode()
	local point = { _G.Minimap:GetPoint() }
	client:RunScript(overlay(), "OnUpdate", 0.1)
	lu.assertEquals({ _G.Minimap:GetPoint() }, point)
	module:ExitEditMode()
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
