-- Run from the addon root: lua5.1 tests/test_session_tooltips.lua
--
-- modules/blizzard/tooltips.lua in the fake client: unit tooltips (name
-- colored by class, reaction or status, PvP and boss icons, the health bar
-- and its text), Shift to inspect a player's gear level and talents, aura
-- tooltips (spell ID and caster with Shift), the tooltip following the
-- cursor, and the skinning of tooltips, menus and dropdowns.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean, stripColors = Session.assertClean, Session.stripColors

local client, C

-- Hovers `unit` in the 3D world: it becomes the mouseover and the game
-- tooltip shows it.
local function hover(unit)
	client.world.units.mouseover = unit
	_G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, _G.UIParent)
	_G.GameTooltip:SetUnit("mouseover")
	return _G.GameTooltipTextLeft1:GetText()
end

local function colorOf(text)
	return (text or ""):match("^|c[fF][fF](%x%x%x%x%x%x)")
end

local function hex(color)
	return string.format("%02X%02X%02X", color[1] * 255 + 0.5, color[2] * 255 + 0.5, color[3] * 255 + 0.5)
end

TestTooltips = {}

function TestTooltips:setUp()
	client = Client.boot({ class = "WARRIOR" })
	C = client.Engine:GetDB("Data: Colors")
end

function TestTooltips:tearDown()
	client = nil
end

function TestTooltips:test_players_are_class_colored_with_their_pvp_icon()
	local title = hover(Client.newUnit({ name = "Thrall", class = "SHAMAN", faction = "Horde", pvp = true }))
	lu.assertStrContains(title, "UI-PVP-Horde")
	lu.assertStrContains(title, "Thrall")
	lu.assertEquals(colorOf(title), hex(C.Class.SHAMAN))
	-- the faction and PvP lines the icon replaces are emptied
	local lines = Session.tooltipLines(_G.GameTooltip)
	for i = 2, #lines do
		lu.assertNotEquals(lines[i], "PvP")
		lu.assertNotEquals(lines[i], "Horde")
	end
	lu.assertStrContains(hover(Client.newUnit({ name = "Jaina", class = "MAGE", faction = "Alliance", pvp = true })), "UI-PVP-Alliance")
	lu.assertStrContains(hover(Client.newUnit({ name = "Nobody", class = "MAGE", faction = "Neutral", pvp = true })), "UI-PVP-Neutral")
	lu.assertStrContains(hover(Client.newUnit({ name = "Brawler", class = "ROGUE", ffa = true })), "UI-PVP-FFA")
	lu.assertEquals(_G.GameTooltip:IsShown(), 1)
	assertClean(client)
end

function TestTooltips:test_npcs_are_colored_by_reaction_and_bosses_get_a_skull()
	local hostile = hover(Client.newUnit({ name = "Defias", isPlayer = false, reaction = 2 }))
	lu.assertEquals(colorOf(hostile), hex(C.Reaction[2]))
	local friendly = hover(Client.newUnit({ name = "Guard", isPlayer = false, reaction = 5 }))
	lu.assertEquals(colorOf(friendly), hex(C.Reaction[5]))
	lu.assertStrContains(hover(Client.newUnit({ name = "Arthas", isPlayer = false, reaction = 2, classification = "worldboss" })), "Skull")
	lu.assertStrContains(hover(Client.newUnit({ name = "Hidden", isPlayer = false, reaction = 2, level = -1 })), "Skull")
	local object = hover(Client.newUnit({ name = "Chair", isPlayer = false, reaction = false }))
	lu.assertEquals(colorOf(object), hex(C.General.Normal))
	assertClean(client)
end

function TestTooltips:test_dead_offline_and_tapped_units_keep_their_tooltip()
	local dead = hover(Client.newUnit({ name = "Corpse", isPlayer = false, reaction = 2, dead = true }))
	lu.assertEquals(_G.GameTooltip:IsShown(), 1, "a dead unit's tooltip stays up")
	lu.assertEquals(colorOf(dead), hex(C.Status.Dead))

	local offline = hover(Client.newUnit({ name = "Gone", class = "PRIEST", connected = false }))
	lu.assertEquals(_G.GameTooltip:IsShown(), 1, "an offline player's tooltip stays up")
	lu.assertEquals(colorOf(offline), hex(C.Status.Disconnected))

	local tapped = hover(Client.newUnit({ name = "Taken", isPlayer = false, playerControlled = false, reaction = 2, tapped = true, isFriend = false }))
	lu.assertEquals(_G.GameTooltip:IsShown(), 1, "a tapped unit's tooltip stays up")
	lu.assertEquals(colorOf(tapped), hex(C.Status.Tapped))
	assertClean(client)
end

function TestTooltips:test_the_health_bar_follows_the_unit()
	local bar = _G.GameTooltipStatusBar
	hover(Client.newUnit({ name = "Wounded", isPlayer = false, reaction = 2, health = 2500, healthMax = 10000 }))
	lu.assertEquals(bar:IsShown(), 1)
	lu.assertEquals(stripColors(bar.value:GetText()), "2.5k ∕ 25%")
	local r = bar:GetStatusBarColor()
	lu.assertAlmostEquals(r, C.Reaction[2][1], 0.01)

	-- full health: just the total
	hover(Client.newUnit({ name = "Healthy", isPlayer = false, reaction = 5, health = 10000, healthMax = 10000 }))
	lu.assertEquals(bar.value:GetText(), "10k")

	-- walls and gates have 1 health point: only the percentage
	bar:SetMinMaxValues(0, 2)
	bar:SetValue(1)
	lu.assertEquals(bar.value:GetText(), "50%")

	-- an empty bar hides; a dead unit reads "Dead"
	bar:SetValue(0)
	lu.assertNil(bar:IsShown())
	bar:SetMinMaxValues(-1, 10)
	bar:Show()
	bar:SetValue(0)
	lu.assertEquals(bar.value:GetText(), _G.DEAD)
	assertClean(client)
end

function TestTooltips:test_no_unit_no_tooltip()
	client.world.units.mouseover = nil
	_G.GameTooltip:Show()
	client:RunScript(_G.GameTooltip, "OnTooltipSetUnit")
	lu.assertNil(_G.GameTooltip:IsShown())

	-- a tooltip the client fills for what's under the mouse, without a unit
	client.world.units.mouseover = Client.newUnit({ name = "Under", isPlayer = false })
	_G.GameTooltip:SetOwner(_G.UIParent)
	_G.GameTooltip:SetText("Under")
	client:RunScript(_G.GameTooltip, "OnTooltipSetUnit")
	lu.assertStrContains(_G.GameTooltipTextLeft1:GetText(), "Under")
	assertClean(client)
end

-- Inspecting ---------------------------------------------------------------

local function gear(unit, items)
	unit.inventory = {}
	for slot, item in pairs(items) do
		unit.inventory[slot] = Session.item(client, 1000 + slot, item)
	end
end

local function standardGear(unit, level)
	local items = {}
	for _, slot in ipairs({ 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 }) do
		items[slot] = { iLevel = level, quality = 4, equipSlot = "INVTYPE_CHEST" }
	end
	gear(unit, items)
end

local function linesText()
	return table.concat(Session.tooltipLines(_G.GameTooltip), "\n")
end

function TestTooltips:test_shift_inspects_a_players_gear_and_talents()
	local unit = Client.newUnit({ name = "Tank", class = "PALADIN" })
	standardGear(unit, 232)
	client.world.inspectTalents = { { "Holy", "", 5 }, { "Protection", "", 53 }, { "Retribution", "", 13 } }
	client.world.modifiers.shift = true
	hover(unit)
	client:Tick(0.1) -- the inspect request goes out
	lu.assertEquals(client.world.inspecting, "mouseover")
	client:FireEvent("INSPECT_TALENT_READY")
	local text = linesText()
	lu.assertStrContains(text, "232.0")
	lu.assertStrContains(text, "5/53/13 (Protection)")
	-- GearScore by the item level: 17 epics of 232, (232 - 91.45) / .65 * 1.8618 each
	lu.assertStrContains(stripColors(text), "232.0  GS 6834")

	-- a second hover uses what's cached, updating the lines in place
	hover(unit)
	lu.assertStrContains(linesText(), "232.0")
	assertClean(client)
end

function TestTooltips:test_heirlooms_pvp_gear_and_weapons_count_right()
	local unit = Client.newUnit({ name = "Twink", class = "ROGUE", level = 70 })
	local items = {}
	for _, slot in ipairs({ 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }) do
		items[slot] = { iLevel = 150, quality = 4 }
	end
	items[1] = { iLevel = 1, quality = 7 } -- heirloom: counted from the wearer's level
	items[5] = { iLevel = 150, quality = 4, stats = { ITEM_MOD_RESILIENCE_RATING_SHORT = 40 } }
	items[16] = { iLevel = 150, quality = 4, equipSlot = "INVTYPE_2HWEAPON" } -- no offhand: one slot less
	gear(unit, items)
	client.world.modifiers.shift = true
	hover(unit)
	client:Tick(0.1)
	client:FireEvent("INSPECT_TALENT_READY")
	local text = stripColors(linesText())
	lu.assertStrContains(text, "1 BoA, 1 PvP")
	lu.assertStrContains(text, _G.NONE, "no talents spent")

	-- heirlooms at every level band
	for _, level in ipairs({ 60, 20 }) do
		local twink = Client.newUnit({ name = "Twink" .. level, class = "ROGUE", level = level })
		gear(twink, { [1] = { iLevel = 1, quality = 7 } })
		hover(twink)
		client:Tick(2)
		client:FireEvent("INSPECT_TALENT_READY")
		lu.assertStrContains(stripColors(linesText()), "BoA")
	end
	assertClean(client)
end

function TestTooltips:test_own_gear_not_known_yet()
	local player = client.world.units.player
	player.inventoryTextures = { [5] = "Interface\\Icons\\Chest" }
	-- not asked for (no Shift): no gear line until it's known
	hover(player)
	lu.assertNotStrContains(linesText(), "GS")
	lu.assertNotStrContains(linesText(), _G.CONTINUED)
	assertClean(client)
end

function TestTooltips:test_own_gear_level()
	local player = client.world.units.player
	for slot, item in pairs({ [1] = { iLevel = 200, quality = 4 }, [16] = { iLevel = 200, quality = 4, equipSlot = "INVTYPE_2HWEAPON" } }) do
		client.world.inventory[slot] = Session.item(client, 2000 + slot, item)
	end
	client.world.modifiers.shift = true
	hover(player)
	local text = linesText()
	-- 400 over 16 slots (the offhand is empty and there's a two-hander)
	lu.assertStrContains(text, "25.0")
	assertClean(client)
end

function TestTooltips:test_items_not_in_the_cache_are_asked_for_again()
	local unit = Client.newUnit({ name = "Fresh", class = "DRUID" })
	unit.inventory = { [1] = "|cffa335ee|Hitem:99999:0:0:0:0:0:0:0:80|h[Unknown]|h|r" }
	client.world.modifiers.shift = true
	hover(unit)
	client:Tick(0.1)
	client:FireEvent("INSPECT_TALENT_READY")
	lu.assertStrContains(linesText(), _G.CONTINUED)
	-- a slot the client shows an icon for, before its link arrives
	local slow = Client.newUnit({ name = "Slow", class = "DRUID" })
	slow.inventoryTextures = { [5] = "Interface\\Icons\\Chest" }
	hover(slow)
	client:Tick(2)
	client:FireEvent("INSPECT_TALENT_READY")
	lu.assertStrContains(linesText(), _G.CONTINUED)
	hover(unit)

	-- the item arrives: the next inventory update fills it in
	Session.item(client, 99999, { iLevel = 245, quality = 4 })
	client:Tick(2)
	client:FireEvent("UNIT_INVENTORY_CHANGED", "mouseover")
	client:Tick(2)
	client:FireEvent("INSPECT_TALENT_READY")
	lu.assertStrContains(linesText(), "15.3") -- 245 over 16 slots: no weapons
	assertClean(client)
end

function TestTooltips:test_no_inspecting_in_combat_or_while_dead()
	local unit = Client.newUnit({ name = "Busy", class = "HUNTER" })
	standardGear(unit, 200)
	client.world.modifiers.shift = true
	client:EnterCombat()
	hover(unit)
	client:Tick(2)
	lu.assertNil(client.world.inspecting)
	client:LeaveCombat()
	client.world.units.player.dead = true
	hover(unit)
	client:Tick(2)
	lu.assertNil(client.world.inspecting)
	assertClean(client)
end

function TestTooltips:test_pressing_shift_adds_the_talents()
	local unit = Client.newUnit({ name = "Later", class = "WARLOCK" })
	standardGear(unit, 219)
	client.world.inspectTalents = { { "Affliction", "", 0 }, { "Demonology", "", 0 }, { "Destruction", "", 57 } }
	hover(unit)
	client:Tick(2)
	client:FireEvent("INSPECT_TALENT_READY")
	-- the gear (item level, GearScore) without Shift, not the talents
	lu.assertStrContains(linesText(), "219.0")
	lu.assertNotStrContains(linesText(), "Destruction", "no Shift, no talents")
	-- hovered again: the gear known already
	hover(unit)
	lu.assertStrContains(linesText(), "219.0")
	client.world.modifiers.shift = true
	client:FireEvent("MODIFIER_STATE_CHANGED", "LSHIFT", 1)
	lu.assertStrContains(linesText(), "Destruction")
	assertClean(client)
end

-- Auras ------------------------------------------------------------------------

function TestTooltips:test_aura_tooltips_show_the_spell_id_and_caster_with_shift()
	local player = client.world.units.player
	player.auras = {
		{ name = "Blessing of Kings", rank = "Rank 1", caster = "party1", spellId = 20217 },
		{ name = "Curse of Agony", harmful = true, debuffType = "Curse", caster = "player", spellId = 980 },
		{ name = "Unknown Source", caster = "raid40", spellId = 1 },
	}
	client.world.units.party1 = Client.newUnit({ name = "Paladin" })
	local tooltip = _G.GameTooltip
	tooltip:SetOwner(_G.UIParent)
	tooltip:SetUnitBuff("player", 1)
	lu.assertEquals(_G.GameTooltipTextLeft1:GetText(), "Blessing of Kings")
	lu.assertNotStrContains(linesText(), "20217")

	client.world.modifiers.shift = true
	tooltip:AddLine(_G.SPELL_TIME_REMAINING_MIN:format(5))
	tooltip:SetUnitBuff("player", 1)
	lu.assertStrContains(linesText(), "20217")
	lu.assertStrContains(linesText(), "Paladin")

	tooltip:SetUnitDebuff("player", 1)
	lu.assertStrContains(linesText(), _G.YOU)
	local r = _G.GameTooltipTextLeft1:GetTextColor()
	lu.assertAlmostEquals(r, C.Debuff.Curse[1], 0.01)

	tooltip:SetUnitBuff("player", 2) -- the caster isn't around: its unit ID
	lu.assertStrContains(linesText(), "raid40")
	assertClean(client)
end

function TestTooltips:test_remaining_time_lines_stand_out()
	local tooltip = _G.GameTooltip
	local now = client.world.time
	client.world.units.player.auras = {
		{ name = "Hours", spellId = 5, duration = 7200, expires = now + 7200 },
		{ name = "Minutes", spellId = 6, duration = 600, expires = now + 300 },
		{ name = "Seconds", harmful = true, spellId = 7, duration = 30, expires = now + 20 },
	}
	local title, gray = client.Engine:GetDB("Data: Colors").General.Title, client.Engine:GetDB("Data: Colors").General.Gray
	tooltip:SetOwner(_G.UIParent)
	for i, show in ipairs({ "SetUnitBuff", "SetUnitBuff", "SetUnitDebuff" }) do
		tooltip[show](tooltip, "player", show == "SetUnitDebuff" and 1 or i)
		lu.assertAlmostEquals(_G.GameTooltipTextLeft2:GetTextColor(), gray[1], 0.01, "the description")
		lu.assertAlmostEquals(_G.GameTooltipTextLeft3:GetTextColor(), title[1], 0.01, "the time left")
	end
	assertClean(client)
end

-- Position and style ------------------------------------------------------------

function TestTooltips:test_tooltips_follow_the_cursor()
	local tooltip = _G.GameTooltip
	local db = client.Engine:GetConfig("Tooltips")
	_G.GameTooltip_SetDefaultAnchor(tooltip, _G.UIParent)
	tooltip:SetText("Follow me")
	client.world.cursor = { 500, 400 } -- the mouse moves; the tooltip follows
	client:Tick(0.1)
	-- the cursor is in screen pixels, the tooltip's points in its own scale
	local scale = tooltip:GetEffectiveScale()
	local left, bottom = tooltip:GetLeft(), tooltip:GetBottom()
	local width, height = tooltip:GetSize()
	local h, v = client:GetModule("Blizzard: Tooltips"):Tooltip_GetAnchorFractions()
	lu.assertAlmostEquals(left + width * h, 500 / scale + db.offsetX, 0.01)
	lu.assertAlmostEquals(bottom + height * v, 400 / scale + db.offsetY, 0.01)

	-- world tooltips stay anchored to the cursor, only nudged
	tooltip:SetOwner(_G.UIParent, "ANCHOR_CURSOR")
	tooltip:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 480, 390)
	tooltip:Show()
	client:Tick(0.1)
	lu.assertEquals(tooltip:GetAnchorType(), "ANCHOR_CURSOR")
	lu.assertAlmostEquals(tooltip:GetLeft() + tooltip:GetWidth() * h, 500 / scale + db.offsetX, 0.01)

	-- a fading tooltip is hidden right away
	tooltip:SetAlpha(0.5)
	client:Tick(0.1)
	lu.assertNil(tooltip:IsShown())
	tooltip:SetAlpha(1)

	-- tooltips placed next to their owner are left alone
	tooltip:SetOwner(_G.UIParent, "ANCHOR_RIGHT")
	client:GetModule("Blizzard: Tooltips"):Tooltip_SetDefaultAnchor(tooltip, _G.UIParent)
	lu.assertEquals(tooltip:GetAnchorType(), "ANCHOR_RIGHT")
	assertClean(client)
end

function TestTooltips:test_menus_dropdowns_and_debug_tools_get_skinned()
	local module = client:GetModule("Blizzard: Tooltips")
	lu.assertTrue(module.styled[_G.GameTooltip])
	lu.assertTrue(module.styled[_G.ChatMenu])
	lu.assertTrue(module.styled[_G.DropDownList1MenuBackdrop])
	-- a styled object keeps our backdrop
	lu.assertNotNil(_G.GameTooltip:GetBackdrop())
	_G.GameTooltip:SetBackdrop(nil)
	lu.assertNotNil(_G.GameTooltip:GetBackdrop())
	_G.GameTooltip:SetFrameLevel(10)

	-- a third dropdown level
	_G.UIDROPDOWNMENU_MAXLEVELS = 3
	local list = _G.CreateFrame("Button", "DropDownList3", _G.UIParent)
	_G.CreateFrame("Frame", "DropDownList3Backdrop", list)
	_G.CreateFrame("Frame", "DropDownList3MenuBackdrop", list)
	_G.UIDropDownMenu_CreateFrames(3, 1)
	lu.assertTrue(module.styled[_G.DropDownList3Backdrop])
	-- the lines' hover Diablo III's red box, those added later too
	local menu = module.config.menu
	lu.assertEquals(_G.DropDownList1Button1Highlight:GetTexture(), menu.texture)
	lu.assertEquals(_G.DropDownList2Button32Highlight:GetTexture(), menu.texture)
	_G.UIDROPDOWNMENU_MAXBUTTONS = 33
	local line = _G.CreateFrame("Button", "DropDownList3Button33", list)
	-- (UIDropDownMenuButtonTemplate's: its hover and its submenu's arrow)
	line:CreateTexture("DropDownList3Button33Highlight")
	local arrow = _G.CreateFrame("Button", "DropDownList3Button33ExpandArrow", line)
	arrow:SetNormalTexture([[Interface\ChatFrame\ChatFrameExpandArrow]])
	_G.UIDropDownMenu_CreateFrames(3, 33)
	lu.assertTrue(module.styled[line])
	lu.assertEquals(_G.DropDownList3Button33Highlight:GetTexture(), menu.texture)
	list:Show()
	_G.DropDownList1:Show()

	-- a menu of its own (the friends' tooltip): its backdrop under its text,
	-- however low it's put
	local friends = _G.FriendsTooltip
	local backdrop = friends:GetChildren()
	friends:SetFrameLevel(0)
	lu.assertEquals(friends:GetFrameLevel(), 1)
	lu.assertEquals(backdrop:GetFrameLevel(), 0)
	friends:Show()
	lu.assertEquals(backdrop:GetFrameLevel(), friends:GetFrameLevel() - 1)

	-- Blizzard_DebugTools loads
	_G.LoadAddOn("Blizzard_DebugTools")
	lu.assertTrue(module.styled[_G.FrameStackTooltip])
	_G.FrameStackTooltip:Show()
	assertClean(client)
end

function TestTooltips:test_tooltip_scale_follows_the_ui()
	local module = client:GetModule("Blizzard: Tooltips")
	local UICenter = client.Engine:GetFrame()
	UICenter:SetScale(0.8)
	_G.GameTooltip:Hide()
	_G.GameTooltip:Show()
	lu.assertEquals(_G.GameTooltip:GetScale(), 0.8)
	local child = _G.CreateFrame("GameTooltip", "ChildTooltip", UICenter)
	module:Tooltip_UpdateScale(child)
	lu.assertEquals(child:GetScale(), 1, "already inside the scaled UI")
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
