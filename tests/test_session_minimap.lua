-- Run from the addon root: lua5.1 tests/test_session_minimap.lua
--
-- The embedded minimap module (modules/minimap) in the fake client: the
-- Diabolic look replacing Blizzard's minimap pieces, the zone name with its
-- fade, the clock and its tooltip, the mail button, the compass on a
-- rotating minimap, zooming and clicking, edit mode (drag to move, right
-- drag to resize, saved and restored), the options page, the MinimapButtonBag
-- integration, and the /setscale, /resetscale, /clear and /go commands.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client, module, ns

local function boot(options)
	client = Client.boot(options or {})
	ns = _G.DiabolicUIMinimapNS
	module = ns:GetModule("Minimap")
	client:Tick(0.1)
end

local function slash(command, text)
	local key = "ACECONSOLE_" .. command:upper()
	lu.assertNotNil(_G.SlashCmdList[key], "/" .. command)
	_G.SlashCmdList[key](text or "")
end

TestMinimap = {}

function TestMinimap:setUp()
	boot()
end

function TestMinimap:tearDown()
	client, module, ns = nil, nil, nil
end

function TestMinimap:test_the_diabolic_look_replaces_blizzards_pieces()
	for _, name in ipairs({ "MinimapBorder", "MinimapBorderTop", "GameTimeFrame", "MiniMapTracking",
		"MinimapZoneTextButton", "MinimapZoomIn", "MinimapZoomOut", "MiniMapWorldMapButton", "MiniMapMailFrame",
		"MiniMapInstanceDifficulty", "TimeManagerClockButton" }) do
		lu.assertEquals(_G[name]:GetParent(), ns.Hider, name)
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
	lu.assertAlmostEquals(_G.Minimap:GetScale(), module:GetBaseScale() * 0.8, 0.0001)
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

	-- with the fade off, the name changes at once; unknown PvP types are gold
	ns.db.global.minimap.zoneFadeEnabled = false
	client.world.zone.minimap = "Durotar"
	client.world.zone.pvpType = nil
	client:FireEvent("ZONE_CHANGED_NEW_AREA")
	lu.assertEquals(module.zoneName:GetText(), "Durotar")
	lu.assertAlmostEquals(module.zoneName:GetTextColor(), ns.Colors.normal[1], 0.001)
	assertClean(client)
end

function TestMinimap:test_the_clock_and_its_tooltip()
	client.world.gameTime = { 21, 5 }
	ns.db.global.minimap.useServerTime = true
	client:Tick(1.1)
	lu.assertEquals(module.time:GetText(), "21:05")
	ns.db.global.minimap.useServerTime = false
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
	client:Tick(0.5) -- AceTimer runs about every 0.1s
	lu.assertEquals(module.compass:GetAlpha(), 0)

	client.world.cvars.rotateMinimap = "0"
	client:FireEvent("CVAR_UPDATE", "ROTATE_MINIMAP", "0")
	lu.assertNil(module.compassTimer)
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
	local stored = ns.db.global.minimap.storedPosition
	lu.assertEquals(stored.point, "LEFT")
	-- on the left half, the outer elements mirror
	lu.assertEquals(select(1, _G.MiniMapLFGFrame:GetPoint()), "TOPLEFT")
	lu.assertEquals(select(1, module.zoneName:GetPoint()), "TOPLEFT")
	lu.assertEquals(select(1, module.mail.frame:GetPoint()), "TOPRIGHT")

	-- right drag: resize, within the limits
	client.world.cursor = { 500, 500 }
	client:RunScript(overlay(), "OnDragStart", "RightButton")
	client.world.cursor = { 600, 400 }
	client:Tick(0.1)
	lu.assertTrue(module:GetUserScale() > 0.8)
	client.world.cursor = { 5000, -5000 }
	client:Tick(0.1)
	lu.assertEquals(module:GetUserScale(), 1.8)
	client.world.cursor = { -5000, 5000 }
	client:Tick(0.1)
	lu.assertEquals(module:GetUserScale(), 0.6)
	client:RunScript(overlay(), "OnDragStop")

	-- left (DiabolicUI's Lock Frames does it, see test_session_menu.lua)
	module:ExitEditMode()
	lu.assertFalse(module:IsEditModeActive())
	lu.assertNil(overlay():IsShown())
	module:ExitEditMode() -- already off
	assertClean(client)
end

function TestMinimap:test_no_edit_mode_in_combat_and_resizes_wait_for_its_end()
	client:EnterCombat()
	module:EnterEditMode()
	lu.assertFalse(module:IsEditModeActive())
	ns.db.global.minimap.userScale = 1.2
	module:UpdateSize()
	lu.assertTrue(module.updateneeded)
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
	local saved = { DiabolicUI_DB = _G.DiabolicUI_DB, DiabolicUI_Minimap_DB = _G.DiabolicUI_Minimap_DB }
	boot({ savedVariables = saved })
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
		{ "TOP", 0, -30, "TOP" }, { "RIGHT", -30, 0, "RIGHT" }, { "CENTER", 0, 0, "CENTER" },
		{ "BOTTOM", 0, 30, "BOTTOM" }, { "BOTTOMRIGHT", -30, 30, "BOTTOMRIGHT" }, { "TOPLEFT", 30, -30, "TOPLEFT" },
	}
	for _, case in ipairs(cases) do
		_G.Minimap:ClearAllPoints()
		_G.Minimap:SetPoint(case[1], _G.UIParent, case[1], case[2], case[3])
		module:SavePosition()
		lu.assertEquals(ns.db.global.minimap.storedPosition.point, case[4])
	end
	-- a frame that isn't placed anywhere
	lu.assertEquals({ ns.API.GetPosition(_G.CreateFrame("Frame")) }, { "CENTER", 0, 0 })
	assertClean(client)
end

function TestMinimap:test_the_namespace_keeps_its_private_values()
	local ok, err = pcall(function() ns.Prefix = "Other" end)
	lu.assertFalse(ok)
	lu.assertStrContains(err, "Can't replace the protected")
	ns.Custom = true -- anything else is fine
	lu.assertTrue(ns.Custom)
end

-- Commands -----------------------------------------------------------------------

function TestMinimap:test_setscale_and_resetscale()
	slash("setscale", "1.2")
	lu.assertEquals(ns.db.global.core.relativeScale, 1.2)
	lu.assertAlmostEquals(_G.Minimap:GetScale(), module:GetBaseScale() * 0.8, 0.0001)
	local bigger = _G.Minimap:GetScale()
	slash("setscale", "9") -- kept within bounds
	lu.assertEquals(ns.db.global.core.relativeScale, 1.5)
	slash("setscale", "1.5") -- no change
	slash("setscale", "big") -- not a number
	slash("resetscale")
	lu.assertEquals(ns.db.global.core.relativeScale, 1)
	lu.assertTrue(_G.Minimap:GetScale() < bigger)
	slash("resetscale") -- already the default

	client:EnterCombat()
	slash("setscale", "0.7")
	slash("resetscale")
	lu.assertEquals(ns.db.global.core.relativeScale, 1, "not in combat")
	client:LeaveCombat()
	assertClean(client)
end

function TestMinimap:test_clear_empties_the_shown_chat_frames()
	_G.ChatFrame1:AddMessage("Hello")
	_G.ChatFrame3:AddMessage("Hidden")
	slash("clear")
	lu.assertEquals(_G.ChatFrame1:GetNumMessages(), 0)
	lu.assertEquals(_G.ChatFrame3:GetNumMessages(), 1, "hidden frames are left alone")
	assertClean(client)
end

function TestMinimap:test_go_switches_to_another_goldpaw_ui()
	table.insert(client.world.addons, { name = "DiabolicUI2", enabled = false })
	table.insert(client.world.addons, { name = "AzeriteUI", enabled = true })
	table.insert(client.world.addons, { name = "DiabolicUI", enabled = true, loaded = true })
	slash("go", "nothing")
	lu.assertNil(client.reloaded)
	slash("switchto", "Diabolic")
	lu.assertEquals(client.reloaded, 1)
	lu.assertTrue(client.api.GetAddOnInfo("DiabolicUI2") ~= nil)
	lu.assertEquals(select(4, client.api.GetAddOnInfo("DiabolicUI2")), 1)
	lu.assertNil(select(4, client.api.GetAddOnInfo("AzeriteUI")))
	lu.assertNil(select(4, client.api.GetAddOnInfo("DiabolicUI")))
	assertClean(client)
end

-- MinimapButtonBag ------------------------------------------------------------

function TestMinimap:test_minimap_button_bag_gets_a_plus_button()
	local mbb = {
		name = "MBB", enabled = true,
		onLoad = function()
			local frame = _G.CreateFrame("Button", "MBB_MinimapButtonFrame", _G.Minimap)
			frame:CreateTexture("MBB_MinimapButtonFrame_Texture")
			_G.MBB_Version = "0.1"
			_G.MBB_TOOLTIP1 = "Click to open"
		end,
	}
	boot({ world = function(world) table.insert(world.addons, mbb) end })
	local frame = _G.MBB_MinimapButtonFrame
	lu.assertEquals(frame:GetParent(), module.mbbButton)
	lu.assertEquals(select(1, module.mbbButton:GetPoint()), "BOTTOMLEFT")
	local icon = _G.MBB_MinimapButtonFrame_Texture
	client:Hover(frame)
	lu.assertEquals(icon:GetAlpha(), 0.95)
	lu.assertStrContains(_G.GameTooltipTextLeft1:GetText(), "MinimapButtonBag")
	client:RunScript(frame, "OnMouseDown")
	lu.assertEquals(icon:GetAlpha(), 1)
	client:RunScript(frame, "OnMouseUp")
	client:Leave()
	lu.assertEquals(icon:GetAlpha(), 0.85)
	client:RunScript(frame, "OnMouseDown")
	lu.assertEquals(icon:GetAlpha(), 0.95)
	-- it can't be moved away from its place
	frame:SetPoint("TOPLEFT")
	lu.assertEquals(select(1, frame:GetPoint()), "CENTER")
	-- the minimap moves left: the button mirrors
	_G.Minimap:ClearAllPoints()
	_G.Minimap:SetPoint("LEFT", _G.UIParent, "LEFT", 30, 0)
	module:SavePosition()
	lu.assertEquals(select(1, module.mbbButton:GetPoint()), "BOTTOMRIGHT")
	assertClean(client)
end

function TestMinimap:test_a_disabled_minimap_button_bag_is_left_alone()
	boot({ world = function(world) table.insert(world.addons, { name = "MBB", enabled = false }) end })
	lu.assertNil(module.mbbButton)
	assertClean(client)
end

-- The options page --------------------------------------------------------------

local function panel()
	return ns:GetModule("Menu").panel
end

function TestMinimap:test_the_options_page_is_a_diabolicui_subcategory()
	local page = panel()
	lu.assertEquals(page.parent, "DiabolicUI")
	local found
	for _, registered in ipairs(client.optionsPanels) do
		if registered == page then found = true end
	end
	lu.assertTrue(found)
	page:Show()
	lu.assertEquals(page.sizeInput:GetText(), "80")
	lu.assertEquals(page.anchorRadios.TOPRIGHT:GetChecked(), 1)
	client:Tick(0.3) -- kept live while open
	assertClean(client)
end

function TestMinimap:test_the_anchor_picker_snaps_the_minimap()
	local page = panel()
	page:Show()
	client:Click(page.anchorRadios.BOTTOMLEFT)
	lu.assertEquals(ns.db.global.minimap.storedPosition.point, "BOTTOMLEFT")
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
	for _, case in ipairs({ { "150", 1.5 }, { "999", 1.8 }, { "1", 0.6 } }) do
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

	-- the slider doesn't overwrite the box while it's being typed in
	page.sizeInput:SetFocus()
	page.sizeInput:SetText("7")
	page.sizeSlider:SetValue(100)
	lu.assertEquals(page.sizeInput:GetText(), "7")
	page.sizeInput:ClearFocus()
	assertClean(client)
end

function TestMinimap:test_the_zone_fade_options()
	local page = panel()
	page:Show()
	local slider = page.zoneFadeDurationSlider
	client:Click(page.zoneFadeCheckbox)
	lu.assertFalse(ns.db.global.minimap.zoneFadeEnabled)
	lu.assertNil(slider:IsEnabled())
	lu.assertEquals(slider:GetAlpha(), 0.5)
	client:Click(page.zoneFadeCheckbox)
	lu.assertTrue(ns.db.global.minimap.zoneFadeEnabled)
	lu.assertEquals(slider:IsEnabled(), 1)

	slider:SetValue(500)
	lu.assertEquals(ns.db.global.minimap.zoneFadeDuration, 0.5)
	for _, case in ipairs({ { "300", 0.3 }, { "5000", 1 }, { "1", 0.05 } }) do
		slider.input:SetFocus()
		slider.input:SetText(case[1])
		client:RunScript(slider.input, "OnEnterPressed")
		lu.assertAlmostEquals(ns.db.global.minimap.zoneFadeDuration, case[2], 0.0001)
	end
	slider.input:SetFocus()
	slider.input:SetText("x")
	client:RunScript(slider.input, "OnEscapePressed")
	slider.input:SetFocus()
	slider.input:SetText("250")
	slider.input:ClearFocus()
	lu.assertAlmostEquals(ns.db.global.minimap.zoneFadeDuration, 0.25, 0.0001)
	-- while typing, the slider leaves the box alone
	slider.input:SetFocus()
	slider:SetValue(800)
	slider.Refresh()
	slider.input:ClearFocus()
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

os.exit(lu.LuaUnit.run())
