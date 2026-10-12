-- Run from the addon root: lua5.1 tests/test_session_skins.lua
--
-- Other addons and Blizzard frames styled in the fake client: TrinketMenu's
-- buttons, Questie's tracker, the world map's zone names, Blizzard's
-- objectives tracker (its fonts, and moving it), and new chat lines sliding in.

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

-- Saved settings for the "AddOnSkins" config.
local function skins(settings)
	return { DiabolicUI_DB = { AddOnSkins = { profiles = { global = settings } } } }
end

-- TrinketMenu ---------------------------------------------------------------------

-- TrinketMenu's frames, as its XML makes them.
local function trinketMenu(world)
	table.insert(world.addons, { name = "TrinketMenu", enabled = true, onLoad = function()
		local backdrop = { bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]] }
		local main = CreateFrame("Frame", "TrinketMenu_MainFrame", _G.UIParent)
		main:SetBackdrop(backdrop)
		local menu = CreateFrame("Frame", "TrinketMenu_MenuFrame", _G.UIParent)
		menu:SetBackdrop(backdrop)
		local button = function(name, parent)
			local b = CreateFrame("CheckButton", name, parent, "ActionButtonTemplate")
			b:SetSize(36, 36)
			_G[name .. "Icon"]:SetAllPoints()
			_G[name .. "Border"]:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
			local time = CreateFrame("Frame", nil, b)
			time:CreateFontString(name .. "Time", "OVERLAY", "NumberFontNormal")
			return b
		end
		button("TrinketMenu_Trinket0", main)
		button("TrinketMenu_Trinket1", main)
		for i = 1, 30 do
			button("TrinketMenu_Menu" .. i, menu)
		end
	end })
end

TestTrinketMenu = {}

function TestTrinketMenu:tearDown()
	client = nil
end

local function assertStyled(name)
	local style = client.Engine:GetDB("ActionBars").visuals.buttons[36]
	local b = _G[name]
	local icon = _G[name .. "Icon"]
	lu.assertEquals({ icon:GetTexCoord() }, { 5/64, 5/64, 5/64, 59/64, 59/64, 5/64, 59/64, 59/64 }, name)
	lu.assertEquals({ icon:GetSize() }, style.icon.size, name)
	lu.assertEquals(icon:GetDrawLayer(), "BORDER", name) -- over the slot
	lu.assertEquals(b:GetNormalTexture():GetTexture(), style.border_normal.texture, name)
	lu.assertEquals(b:GetHighlightTexture():GetTexture(), style.border_normal_highlight.texture, name)
	lu.assertEquals(b:GetPushedTexture():GetTexture(), style.border_normal_highlight.texture, name)
	lu.assertEquals(b:GetCheckedTexture():GetTexture(), style.border_checked.texture, name)
	lu.assertEquals({ b:GetNormalTexture():GetSize() }, style.border_normal.size, name)
	lu.assertNil(_G[name .. "Border"]:GetTexture(), name)
	lu.assertEquals(_G[name .. "Time"]:GetFontObject(), style.keybind.normalFont, name)
	lu.assertEquals(_G[name .. "HotKey"]:GetFontObject(), style.keybind.normalFont, name)
end

function TestTrinketMenu:test_loaded_after_us_it_gets_styled()
	boot({ world = trinketMenu })
	client.api.LoadAddOn("TrinketMenu")
	assertStyled("TrinketMenu_Trinket0")
	assertStyled("TrinketMenu_Trinket1")
	assertStyled("TrinketMenu_Menu1")
	assertStyled("TrinketMenu_Menu30")
	-- no backgrounds behind them
	lu.assertNil(_G.TrinketMenu_MainFrame:GetBackdrop())
	lu.assertNil(_G.TrinketMenu_MenuFrame:GetBackdrop())
	-- styled once only
	client:GetModule("Blizzard: TrinketMenu"):StyleButton(_G.TrinketMenu_Trinket0)
	client:GetModule("Blizzard: TrinketMenu"):StyleButton(nil)
	-- another addon loading is none of its business
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	assertClean(client)
end

function TestTrinketMenu:test_loaded_before_us_too()
	boot({ world = function(world)
		trinketMenu(world)
		local addon = world.addons[#world.addons]
		addon.loaded = true
		addon.onLoad()
	end })
	assertStyled("TrinketMenu_Trinket0")
	assertClean(client)
end

function TestTrinketMenu:test_the_option_off()
	boot({ world = trinketMenu, savedVariables = skins({ styleTrinketMenu = false }) })
	client.api.LoadAddOn("TrinketMenu")
	lu.assertNotNil(_G.TrinketMenu_MainFrame:GetBackdrop())
	lu.assertNil(_G.TrinketMenu_Trinket0.DiabolicStyled)
	assertClean(client)
end

-- Questie's tracker ---------------------------------------------------------------

-- Questie's tracker lines, made the way its TrackerLinePool makes them: a
-- label whose SetText keeps the original as _SetText, and SetMode setting
-- Questie's own font when a line changes kind.
local function questie(world, loadedBeforeUs, lineInUse)
	local addon = { name = "Questie-335", enabled = true, onLoad = function()
		local lines, current = {}, 0
		local buttons, currentButton = {}, 0
		local pool = {
			GetNextItemButton = function()
				currentButton = currentButton + 1
				return buttons[currentButton]
			end,
			GetCurrentButton = function() return buttons[currentButton] end,
			GetLine = function(i) return lines[i] end,
			GetNextLine = function()
				current = current + 1
				return lines[current]
			end,
			GetCurrentLine = function() return lines[current] end,
			GetHighestIndex = function() return current end,
			SetMode = function(self, mode)
				if mode ~= self.mode then
					self.mode = mode
					self.label:SetFont([[Fonts\FRIZQT__.TTF]], 11, "OUTLINE")
					self.label:SetHeight(11)
				end
			end,
		}
		pool.Initialize = function(count)
			for i = 1, count do
				local line = CreateFrame("Button", "linePool" .. i, _G.UIParent)
				line.label = line:CreateFontString(nil, "ARTWORK", "GameFontNormal")
				line.label._SetText = line.label.SetText
				line.label.frame = line
				line.label.SetText = function(self, text) self:_SetText(text) end
				line.SetMode = pool.SetMode
				-- the zone line's click area: collapses or expands the zone
				local expandZone = CreateFrame("Button", nil, line)
				expandZone.SetMode = function(self, mode) self.mode = mode end
				expandZone:SetMode(1)
				expandZone.mode = nil -- cleared before every update (ResetLinesForChange)
				expandZone:SetScript("OnMouseUp", function(self, button)
					if button == "LeftButton" and not IsShiftKeyDown() then
						self:SetMode((self.mode == 1) and 0 or 1)
					end
				end)
				line.expandZone = expandZone
				lines[i] = line
				-- a quest item's button, as Questie makes them
				local button = CreateFrame("Button", "Questie_ItemButton" .. i, _G.UIParent, "SecureActionButtonTemplate")
				CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
				button.count = button:CreateFontString(nil, "ARTWORK", "SystemFont_Outline_Small")
				button.SetItem = function(self, itemId, questId, size)
					self.itemId = itemId
					self:SetNormalTexture([[Interface\Icons\INV_Misc_Bomb_01]])
					self:SetPushedTexture([[Interface\Icons\INV_Misc_Bomb_01]])
					self:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
					self:SetSize(size, size)
					self.count:SetFont([[Fonts\FRIZQT__.TTF]], 11, "OUTLINE")
					self:Show()
					return true
				end
				buttons[i] = button
				-- a few at a time, in a coroutine
				if coroutine.running() then
					coroutine.yield()
				end
			end
		end
		local tracker = {
			started = true,
			Update = function() end,
			UpdateHeight = function(self) self.heightUpdated = true end,
		}
		local modules = { TrackerLinePool = pool, TrackerBaseFrame = { Update = function() end }, QuestieTracker = tracker }
		_G.Questie = { db = { profile = { trackerQuestPadding = 10 } } }
		_G.QuestieLoader = { ImportModule = function(_, name) return modules[name] end }
		if lineInUse then
			pool.Initialize(1)
			pool.GetNextLine()
			lines[1]:SetMode("quest")
			lines[1].label:SetText("|cFFFF8040A Quest|r")
		end
	end }
	if loadedBeforeUs then
		addon.loaded = true
		addon.onLoad()
	end
	table.insert(world.addons, addon)
end

TestQuestieTracker = {}

function TestQuestieTracker:tearDown()
	_G.QuestieLoader, _G.Questie = nil, nil
	client = nil
end

local function assertLine(line, font, color, text)
	lu.assertEquals({ line.label:GetFont() }, { _G[font]:GetFont() })
	lu.assertEquals({ line.label:GetShadowOffset() }, { -1, -1 })
	local r, g, b = line.label:GetTextColor()
	lu.assertEquals({ r, g, b }, color)
	lu.assertEquals(line.label:GetText(), text)
end

function TestQuestieTracker:test_lines_in_our_fonts_and_titles_in_gold()
	boot({ world = function(world) questie(world, true) end })
	local title, questieColor = { unpack(client.Engine:GetDB("Data: Colors").General.Title) }, { 1, .82, 0 }
	-- its tracker starts some time after login, in a coroutine
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	local start = coroutine.create(pool.Initialize)
	repeat
		local ok, err = coroutine.resume(start, 3)
		lu.assertTrue(ok, err)
	until coroutine.status(start) == "dead"
	local zone, quest, objective = pool.GetNextLine(), pool.GetNextLine(), pool.GetNextLine()
	zone:SetMode("zone")
	zone.label:SetText("|cFFC0C0C0Dragonblight|r")
	quest:SetMode("quest")
	quest.label:SetText("|cFFFF8040[72] The Might of the Horde|r |cFF00FF00(50%)|r")
	objective:SetMode("objective")
	objective.label:SetText("|cFFEEEEEE- Wolves slain: 2/5|r")
	assertLine(zone, "DiabolicFont_HeaderRegular12", title, "Dragonblight")
	assertLine(quest, "DiabolicFont_HeaderRegular12", title, "[72] The Might of the Horde (50%)")
	assertLine(objective, "DiabolicFont_SansRegular12", questieColor, "|cFFEEEEEE- Wolves slain: 2/5|r")
	lu.assertEquals(quest.label:GetHeight(), 12)
	-- a line used for something else
	quest:SetMode("objective")
	quest.label:SetText("|cFFEEEEEE- Quest Complete!|r")
	assertLine(quest, "DiabolicFont_SansRegular12", questieColor, "|cFFEEEEEE- Quest Complete!|r")
	quest:SetMode("achieve")
	quest.label:SetText("|cFFFFFF00Northrend Dungeonmaster|r")
	assertLine(quest, "DiabolicFont_HeaderRegular12", title, "Northrend Dungeonmaster")
	quest.label:SetText(nil)
	assertClean(client)
end

function TestQuestieTracker:test_questie_loaded_after_us_with_a_line_in_use()
	boot({ world = function(world) questie(world, false, true) end })
	client.api.LoadAddOn("Questie-335")
	client:FireEvent("ADDON_LOADED", "Questie-335")
	local line = _G.QuestieLoader:ImportModule("TrackerLinePool").GetLine(1)
	assertLine(line, "DiabolicFont_HeaderRegular12", { unpack(client.Engine:GetDB("Data: Colors").General.Title) }, "A Quest")
	-- once is enough
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	assertClean(client)
end

function TestQuestieTracker:test_the_same_space_after_every_quest()
	boot({ world = function(world) questie(world, true) end })
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	local tracker = _G.QuestieLoader:ImportModule("QuestieTracker")
	-- nothing tracked yet: nothing to space
	tracker:Update()
	lu.assertNil(tracker.heightUpdated)
	pool.Initialize(5)
	local lines = {}
	for i, mode in ipairs({ "zone", "quest", "objective", "quest", "objective" }) do
		lines[i] = pool.GetNextLine()
		lines[i]:SetMode(mode)
		lines[i].label:SetText("Text")
	end
	-- the first quest ends on an objective wrapped on two lines, which
	-- Questie sized again without the padding below it
	lines[3].label.GetNumLines = function() return 2 end
	lines[3]:SetHeight(28)
	-- in combat: left for later
	client:EnterCombat()
	tracker:Update()
	lu.assertEquals(lines[3]:GetHeight(), 28)
	client:LeaveCombat()
	tracker:Update()
	local heights = {}
	for i = 1, 5 do
		heights[i] = lines[i]:GetHeight()
	end
	-- zone and titles 12 + 4, the wrapped line (12 + 1) * 2 + 1, each quest
	-- then padded by 10 + 2
	lu.assertEquals(heights, { 16, 16, 27 + 12, 16, 12 + 12 })
	lu.assertEquals(lines[3].label:GetHeight(), 27)
	lu.assertTrue(tracker.heightUpdated)
	assertClean(client)
end

function TestQuestieTracker:test_the_objectives_line_and_its_collapse_button()
	boot({ world = function(world) questie(world, true) end })
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	pool.Initialize(2)
	local zone = pool.GetNextLine()
	zone:SetMode("zone")
	zone.expandZone:SetMode(1)
	zone.label:SetText("|cFFC0C0C0Quests (By Proximity)|r")
	-- Blizzard's title, and its button just after it, arrow up
	lu.assertEquals(zone.label:GetText(), _G.OBJECTIVES_TRACKER_LABEL)
	local button = zone.CollapseButton
	lu.assertEquals(button:IsShown(), 1)
	lu.assertEquals(button:GetNormalTexture():GetTexture(), [[Interface\Buttons\UI-Panel-QuestHideButton]])
	lu.assertEquals({ button:GetNormalTexture():GetTexCoord() }, { 0, .5, 0, 1, .5, .5, .5, 1 }) -- (0, .5, .5, 1)
	lu.assertEquals(select(4, button:GetPoint()), zone.label:GetStringWidth() + 4)
	-- a click on the line collapses it, with Blizzard's sound, arrow down
	client.sounds = {}
	client:RunScript(zone.expandZone, "OnMouseUp", "LeftButton")
	lu.assertEquals(zone.expandZone.mode, 0)
	lu.assertEquals(client.sounds, { "igMiniMapClose" })
	lu.assertEquals({ button:GetNormalTexture():GetTexCoord() }, { 0, 0, 0, .5, .5, 0, .5, .5 }) -- (0, .5, 0, .5)
	-- Questie redraws it collapsed: no " +", the button says so
	zone.expandZone:SetMode(0)
	zone.label:SetText("|cFFC0C0C0Quests (By Proximity) +|r")
	lu.assertEquals(zone.label:GetText(), _G.OBJECTIVES_TRACKER_LABEL)
	-- the button expands it again
	client:Click(button)
	lu.assertEquals(zone.expandZone.mode, 1)
	lu.assertEquals(client.sounds, { "igMiniMapClose", "igMiniMapOpen" })
	-- Shift-click is Questie's (all its quests): no sound
	client.world.modifiers.shift = true
	client:RunScript(zone.expandZone, "OnMouseUp", "LeftButton")
	client.world.modifiers.shift = false
	lu.assertEquals(#client.sounds, 2)
	-- a real zone keeps its name
	zone.label:SetText("|cFFC0C0C0Dragonblight +|r")
	lu.assertEquals(zone.label:GetText(), "Dragonblight")
	-- the line used for a quest: no button
	zone:SetMode("quest")
	lu.assertNil(button:IsShown())
	assertClean(client)
end

function TestQuestieTracker:test_quest_items_like_the_action_bars_buttons()
	boot({ world = function(world) questie(world, true) end })
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	pool.Initialize(1)
	local button = pool.GetNextItemButton()
	button:SetItem(12345, 678, 18) -- 18: half the bars' 36
	local style = client.Engine:GetDB("ActionBars").visuals.buttons[36]
	local icon = button:GetNormalTexture()
	lu.assertEquals({ icon:GetSize() }, { 14, 14 })
	lu.assertEquals({ icon:GetPoint() }, { "TOPLEFT", button, "TOPLEFT", 2, -2 })
	lu.assertEquals({ icon:GetTexCoord() }, { 5/64, 5/64, 5/64, 59/64, 59/64, 5/64, 59/64, 59/64 })
	lu.assertEquals({ button:GetPushedTexture():GetSize() }, { 14, 14 })
	lu.assertEquals(button.DiabolicBorder:GetTexture(), style.border_normal.texture)
	lu.assertEquals({ button.DiabolicBorder:GetSize() }, { 32, 32 })
	lu.assertEquals({ button.DiabolicBorder:GetPoint() }, { "TOPLEFT", button, "TOPLEFT", -7, 7 })
	lu.assertEquals(button.DiabolicSlot:GetTexture(), style.slot.texture)
	lu.assertEquals(button:GetHighlightTexture():GetTexture(), style.border_normal_highlight.texture)
	lu.assertEquals({ button:GetHighlightTexture():GetSize() }, { 32, 32 })
	local cooldown = button:GetChildren()
	lu.assertEquals({ cooldown:GetPoint() }, { "TOPLEFT", icon, "TOPLEFT", 0, 0 })
	lu.assertEquals({ button.count:GetFont() }, { _G.DiabolicFont_SansBold10:GetFont() })
	-- given another item later: styled again, its border made once
	local border = button.DiabolicBorder
	button:SetItem(12346, 679, 36)
	lu.assertEquals({ icon:GetSize() }, { 28, 28 })
	lu.assertEquals(button.DiabolicBorder, border)
	-- no item: left alone
	button.itemId = nil
	button:Hide()
	button:SetItem(nil, 680, 36)
	assertClean(client)
end

-- Questie changed: its tracker left alone, with one message.
local function bootChangedQuestie(change)
	local printed = {}
	boot({ world = function(world)
		_G.print = function(text) printed[#printed + 1] = text end -- (booting resets the globals)
		questie(world, true)
		change(_G.QuestieLoader:ImportModule("TrackerLinePool"))
	end })
	return printed
end

function TestQuestieTracker:test_a_changed_line_pool_is_left_alone()
	local printed = bootChangedQuestie(function(pool) pool.GetNextLine = nil end)
	_G.print = print
	local L = client.Engine:GetLocale()
	lu.assertEquals(printed, { L["DiabolicUI: Questie has changed, its tracker is left as it is. Turn off Style Questie's Tracker in /dui config if it misbehaves."] .. " (TrackerLinePool.GetNextLine)" })
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	pool.Initialize(1)
	pool.GetLine(1):SetMode("quest")
	lu.assertNil(pool.GetLine(1).DiabolicStyled)
	assertClean(client)
end

function TestQuestieTracker:test_changed_lines_are_left_alone()
	local printed = bootChangedQuestie(function(pool)
		local initialize = pool.Initialize
		pool.Initialize = function(count)
			initialize(count)
			for i = 1, count do
				pool.GetLine(i).label.frame = nil -- built some other way
			end
		end
	end)
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	local tracker = _G.QuestieLoader:ImportModule("QuestieTracker")
	pool.Initialize(2)
	local line = pool.GetNextLine()
	line:SetMode("quest")
	line.label:SetText("|cFFFF8040A Quest|r")
	pool.GetNextLine():SetMode("objective")
	tracker:Update()
	_G.print = print
	-- once only, nothing styled, nothing spaced
	lu.assertEquals(#printed, 1)
	lu.assertStrContains(printed[1], "(line.label.frame)")
	lu.assertNil(line.DiabolicStyled)
	lu.assertEquals(line.label:GetText(), "|cFFFF8040A Quest|r")
	lu.assertNil(tracker.heightUpdated)
	assertClean(client)
end

function TestQuestieTracker:test_the_option_off()
	boot({ world = function(world) questie(world, true) end, savedVariables = skins({ styleQuestieTracker = false }) })
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	pool.Initialize(1)
	pool.GetLine(1):SetMode("quest")
	lu.assertNil(pool.GetLine(1).DiabolicStyled)
	assertClean(client)
end

-- The world map -------------------------------------------------------------------

TestWorldMap = {}

function TestWorldMap:tearDown()
	client = nil
end

function TestWorldMap:test_zone_names_in_exocet()
	boot()
	local label, description = _G.WorldMapFrameAreaLabel, _G.WorldMapFrameAreaDescription
	lu.assertEquals({ label:GetFont() }, { [[Interface\AddOns\DiabolicUI\media\fonts\ExocetBlizzardMedium.ttf]], 22, "OUTLINE" })
	lu.assertEquals(select(2, description:GetFont()), 16)
	lu.assertStrContains(description:GetFont(), "Exocet")
	-- reset by something else: back on the next map update
	label:SetFont([[Fonts\FRIZQT__.TTF]], 22, "OUTLINE")
	_G.WorldMapFrame_Update()
	lu.assertStrContains(label:GetFont(), "Exocet")
	assertClean(client)
end

-- Blizzard's objectives tracker ---------------------------------------------------

TestWatchFrame = {}

function TestWatchFrame:tearDown()
	client = nil
end

-- A tracker line, as WatchFrameLineTemplate makes it.
local function watchLine()
	local line = CreateFrame("Frame", nil, _G.WatchFrameLines)
	line.text = line:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	line.dash = line:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	return line
end

function TestWatchFrame:test_titles_in_exocet_objectives_in_the_body_font()
	boot()
	local C = client.Engine:GetDB("Data: Colors")
	lu.assertEquals(_G.WatchFrameTitle:GetFontObject(), _G.DiabolicFont_HeaderRegular12)
	local title, objective = watchLine(), watchLine()
	_G.WatchFrame_SetLine(title, nil, 0, true, "The Lich King")
	_G.WatchFrame_SetLine(objective, nil, 0, false, "- Defeat him: 0/1")
	lu.assertEquals(title.text:GetFontObject(), _G.DiabolicFont_HeaderRegular12)
	local r, g, b = title.text:GetTextColor()
	lu.assertAlmostEquals({ r, g, b }, { C.General.Title[1], C.General.Title[2], C.General.Title[3] }, 1e-6)
	lu.assertEquals(objective.text:GetFontObject(), _G.DiabolicFont_SansRegular12)
	lu.assertEquals(objective.dash:GetFontObject(), _G.DiabolicFont_SansRegular12)
	-- lines get reused: a title line later used for an objective
	_G.WatchFrame_SetLine(title, nil, 0, false, "- Loot it")
	lu.assertEquals(title.text:GetFontObject(), _G.DiabolicFont_SansRegular12)
	assertClean(client)
end

function TestWatchFrame:test_moving_it()
	boot()
	local L = client.Engine:GetLocale()
	local tracker = client:GetModule("ObjectiveTracker")
	local watch = _G.WatchFrame
	lu.assertFalse(tracker:IsTrackerUnlocked())

	-- unlocked: a box on its top to drag it by
	tracker:SetTrackerUnlocked(true)
	local mover = _G.DiabolicUITrackerMover
	lu.assertTrue(tracker:IsTrackerUnlocked())
	lu.assertEquals(mover.Text:GetText(), L["Drag to move the tracker"])
	client:RunScript(mover, "OnDragStart", "LeftButton")
	mover:ClearAllPoints()
	mover:SetPoint("TOPRIGHT", _G.UIParent, "BOTTOMLEFT", 600, 500)
	client:RunScript(mover, "OnDragStop", "LeftButton")
	lu.assertEquals(tracker.db.trackerPosition, { 600, 500 })
	lu.assertEquals({ watch:GetRight(), watch:GetTop(), (watch:GetBottom()) }, { 600, 500, 70 })
	lu.assertEquals(watch:IsUserPlaced(), 1)

	-- Blizzard re-laying its frames out keeps it there
	watch:ClearAllPoints()
	watch:SetPoint("TOPRIGHT", _G.UIParent, "TOPRIGHT", 0, -200)
	_G.UIParent_ManageFramePositions()
	lu.assertEquals({ watch:GetRight(), watch:GetTop() }, { 600, 500 })

	-- locked again; unlocking again starts from where it is
	tracker:SetTrackerUnlocked(false)
	lu.assertFalse(tracker:IsTrackerUnlocked())
	tracker:SetTrackerUnlocked(true)
	lu.assertEquals({ mover:GetRight(), mover:GetTop() }, { 600, 500 })

	-- reset while unlocked: back to Blizzard's spot, its box with it
	watch:SetSize(204, 400)
	watch:SetPoint("TOPRIGHT", _G.UIParent, "TOPRIGHT", -10, -200)
	tracker:ResetTrackerPosition()
	lu.assertNil(tracker.db.trackerPosition)
	lu.assertTrue(tracker:IsTrackerUnlocked())
	lu.assertEquals(mover:GetTop(), watch:GetTop())
	lu.assertFalse(watch:IsUserPlaced() and true or false)
	tracker:PlaceTracker() -- nothing saved: nothing to do
	tracker:SetTrackerUnlocked(false)
	tracker:ResetTrackerPosition() -- locked: stays locked
	lu.assertFalse(tracker:IsTrackerUnlocked())

	-- /dui tracker is /dui move now; /dui tracker reset
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("tracker")
	lu.assertTrue(tracker:IsTrackerUnlocked())
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("tracker")
	lu.assertFalse(tracker:IsTrackerUnlocked())
	tracker.db.trackerPosition = { 1, 2 }
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("tracker reset")
	lu.assertNil(tracker.db.trackerPosition)
	assertClean(client)
end

function TestWatchFrame:test_unlocked_before_it_was_ever_moved()
	boot()
	local tracker = client:GetModule("ObjectiveTracker")
	-- where Blizzard put it
	_G.WatchFrame:SetSize(204, 400)
	_G.WatchFrame:SetPoint("TOPRIGHT", _G.UIParent, "TOPRIGHT", -10, -200)
	tracker:SetTrackerUnlocked(true)
	local mover = _G.DiabolicUITrackerMover
	lu.assertEquals({ mover:GetRight(), mover:GetTop() }, { _G.WatchFrame:GetRight(), _G.WatchFrame:GetTop() })
	-- the box isn't made twice
	tracker:SetTrackerUnlocked(false)
	tracker:SetTrackerUnlocked(true)
	lu.assertEquals(tracker:GetMover(), mover)
	assertClean(client)
end

-- New chat lines sliding in -------------------------------------------------------

TestChatSlide = {}

function TestChatSlide:tearDown()
	client = nil
end

local function chatSlide(on)
	return { DiabolicUI_DB = { ChatWindows = { profiles = { global = { slideMessages = on } } } } }
end

function TestChatSlide:test_on_by_default_and_off()
	boot()
	_G.ChatFrame1:Show()
	_G.ChatFrame1:AddMessage("hello")
	lu.assertEquals(_G.ChatFrame1.DiabolicSlide:IsPlaying(), 1)
	client = nil

	boot({ savedVariables = chatSlide(false) })
	_G.ChatFrame1:Show()
	_G.ChatFrame1:AddMessage("hello")
	lu.assertNil(_G.ChatFrame1.DiabolicSlide)
	assertClean(client)
end

function TestChatSlide:test_new_lines_slide_in()
	boot({ savedVariables = chatSlide(true) })
	local frame = _G.ChatFrame1
	frame:Show()
	frame:AddMessage("hello")
	local slide = frame.DiabolicSlide
	lu.assertEquals(slide:IsPlaying(), 1)
	-- one line down at once, then back up
	local height = select(2, frame:GetFont()) + 2
	local down, up = slide.down, slide.up
	lu.assertEquals(client.widgetState[down].offset, { 0, -height })
	lu.assertEquals(client.widgetState[up].offset, { 0, height })
	lu.assertEquals(up:GetDuration(), .3)
	client:Tick(.5)
	lu.assertNil(slide:IsPlaying())
	-- the next line plays the same slide again
	frame:AddMessage("again")
	lu.assertEquals(frame.DiabolicSlide, slide)
	lu.assertEquals(slide:IsPlaying(), 1)
	client:Tick(.5)

	-- not while typing in it, hovering it, or scrolled up in it
	frame.editBox:Show()
	frame:AddMessage("typing")
	lu.assertNil(slide:IsPlaying())
	frame.editBox:Hide()
	client:Hover(frame)
	frame:AddMessage("hovering")
	lu.assertNil(slide:IsPlaying())
	client:Leave()
	frame:ScrollUp()
	frame:AddMessage("scrolled up")
	lu.assertNil(slide:IsPlaying())
	frame:ScrollToBottom()

	-- nor in the combat log, nor in a window that isn't shown
	_G.ChatFrame2:AddMessage("Hit for 10")
	lu.assertNil(_G.ChatFrame2.DiabolicSlide)
	frame:Hide()
	frame:AddMessage("hidden")
	lu.assertNil(slide:IsPlaying())

	-- whisper windows popped out later too
	_G.CHAT_FRAMES[#_G.CHAT_FRAMES + 1] = "ChatFrame3"
	_G.FCF_OpenTemporaryWindow("WHISPER", "Someone")
	lu.assertTrue(_G.ChatFrame3.DiabolicSlideHooked)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
