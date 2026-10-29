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

local function shown(widget)
	return widget:IsShown() == 1
end

local function color(...)
	local r, g, b = ...
	return { r, g, b }
end

local function near(actual, expected)
	for i = 1, 3 do
		lu.assertAlmostEquals(actual[i], expected[i], 1e-6)
	end
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
		-- its header, hidden by default, and its "?" (shown again on each update)
		local headerFrame = CreateFrame("Button", "Questie_HeaderFrame", _G.UIParent)
		headerFrame:Hide()
		headerFrame.questieIcon = CreateFrame("Button", nil, _G.UIParent)
		headerFrame.questieIcon:SetScript("OnClick", function(_, button) client.questieOptions = button end)
		local header = { headerFrame = headerFrame, Update = function() headerFrame.questieIcon:Show() end }
		local modules = { TrackerLinePool = pool, TrackerBaseFrame = { Update = function() end }, QuestieTracker = tracker, TrackerHeaderFrame = header }
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
	local style = client.Engine:GetDB("Objectives").style
	local header, title, questieColor = { unpack(style.header_color) }, { unpack(style.title_color) }, { 1, .82, 0 }
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
	-- the zone in Exocet capitals, the quest in Exocet and gold
	assertLine(zone, "DiabolicFont_HeaderRegular12", header, "DRAGONBLIGHT")
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
	assertLine(line, "DiabolicFont_HeaderRegular12", { unpack(client.Engine:GetDB("Objectives").style.title_color) }, "A Quest")
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
	-- Blizzard's title in capitals, and our red square at the tracker's
	-- right edge, its bar
	local style = client.Engine:GetDB("Objectives").style
	lu.assertEquals(zone.label:GetText(), _G.OBJECTIVES_TRACKER_LABEL:upper())
	lu.assertEquals({ zone.CollapseButton:GetPoint() }, { "TOPRIGHT", _G.UIParent, "TOPRIGHT", -4, (style.collapse.size - zone.label:GetHeight()) / 2 })
	local button = zone.CollapseButton
	lu.assertEquals(button:IsShown(), 1)
	lu.assertEquals(button:GetNormalTexture():GetTexture(), client.Engine:GetDB("Objectives").style.collapse.texture)
	lu.assertEquals({ button:GetNormalTexture():GetTexCoord() }, { 0, .5, 0, 1, .5, .5, .5, 1 }) -- (0, .5, .5, 1)
	-- a click on the line collapses it, with Blizzard's sound, its cross
	client.sounds = {}
	client:RunScript(zone.expandZone, "OnMouseUp", "LeftButton")
	lu.assertEquals(zone.expandZone.mode, 0)
	lu.assertEquals(client.sounds, { "igMiniMapClose" })
	lu.assertEquals({ button:GetNormalTexture():GetTexCoord() }, { 0, 0, 0, .5, .5, 0, .5, .5 }) -- (0, .5, 0, .5)
	-- Questie redraws it collapsed: no " +", the button says so
	zone.expandZone:SetMode(0)
	zone.label:SetText("|cFFC0C0C0Quests (By Proximity) +|r")
	lu.assertEquals(zone.label:GetText(), _G.OBJECTIVES_TRACKER_LABEL:upper())
	-- the button expands it again
	client:Click(button)
	lu.assertEquals(zone.expandZone.mode, 1)
	lu.assertEquals(client.sounds, { "igMiniMapClose", "igMiniMapOpen" })
	-- Shift-click is Questie's (all its quests): no sound
	client.world.modifiers.shift = true
	client:RunScript(zone.expandZone, "OnMouseUp", "LeftButton")
	client.world.modifiers.shift = false
	lu.assertEquals(#client.sounds, 2)
	-- a right-click: Questie's options, as its "?" opens them
	client:RunScript(zone.expandZone, "OnMouseUp", "RightButton")
	lu.assertEquals(client.questieOptions, "LeftButton")
	lu.assertEquals(#client.sounds, 2)
	-- its "?" out of sight, again after each update; by its own header, kept
	local header = _G.QuestieLoader:ImportModule("TrackerHeaderFrame")
	lu.assertNil(header.headerFrame.questieIcon:IsShown())
	header:Update()
	lu.assertNil(header.headerFrame.questieIcon:IsShown())
	header.headerFrame:Show()
	header:Update()
	lu.assertEquals(header.headerFrame.questieIcon:IsShown(), 1)
	-- a real zone keeps its name
	zone.label:SetText("|cFFC0C0C0Dragonblight +|r")
	lu.assertEquals(zone.label:GetText(), "DRAGONBLIGHT")
	lu.assertEquals(select(4, button:GetPoint()), zone.label:GetStringWidth() + 4)
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
	lu.assertEquals(printed, { L["DiabolicUI: Questie has changed, its tracker is left as it is."] .. " (TrackerLinePool.GetNextLine)" })
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

function TestQuestieTracker:test_each_change_is_named()
	local L
	local cases = {
		{ "line.SetMode", function(line) line.SetMode = nil end },
		{ "line.label._SetText", function(line) line.label._SetText = nil end },
		{ "line.expandZone.SetMode", function(line) line.expandZone.SetMode = nil end },
		{ "line.expandZone OnMouseUp", function(line) line.expandZone:SetScript("OnMouseUp", nil) end },
	}
	for _, case in ipairs(cases) do
		local printed = bootChangedQuestie(function(pool)
			pool.Initialize(1)
			case[2](pool.GetLine(1))
		end)
		_G.print = print
		L = client.Engine:GetLocale()
		lu.assertEquals(printed, { L["DiabolicUI: Questie has changed, its tracker is left as it is."] .. " (" .. case[1] .. ")" }, case[1])
		assertClean(client)
	end
end

function TestQuestieTracker:test_a_missing_module_or_loader_is_named()
	-- no QuestieTracker module
	local printed = {}
	boot({ world = function(world)
		_G.print = function(text) printed[#printed + 1] = text end
		questie(world, true)
		local import = _G.QuestieLoader.ImportModule
		_G.QuestieLoader.ImportModule = function(loader, name)
			if name ~= "QuestieTracker" then
				return import(loader, name)
			end
		end
	end })
	_G.print = print
	lu.assertStrContains(printed[1], "(QuestieTracker)")
	assertClean(client)
	-- a loader without ImportModule as a function (still callable)
	printed = {}
	boot({ world = function(world)
		_G.print = function(text) printed[#printed + 1] = text end
		questie(world, true)
		local import = _G.QuestieLoader.ImportModule
		_G.QuestieLoader.ImportModule = setmetatable({}, { __call = function(_, loader, name) return import(loader, name) end })
	end })
	_G.print = print
	lu.assertStrContains(printed[1], "(QuestieLoader.ImportModule)")
	assertClean(client)
end

function TestQuestieTracker:test_lines_styled_before_a_change_are_left_alone_after()
	-- the second of three lines already made is different: the first was
	-- styled, the third isn't, and none is touched from then on
	local printed = bootChangedQuestie(function(pool)
		pool.Initialize(3)
		pool.GetLine(2).label.frame = nil
	end)
	_G.print = print
	lu.assertEquals(#printed, 1)
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	lu.assertTrue(pool.GetLine(1).DiabolicStyled)
	lu.assertNil(pool.GetLine(3).DiabolicStyled)
	pool.GetLine(1):SetMode("quest")
	lu.assertEquals({ pool.GetLine(1).label:GetFont() }, { [[Fonts\FRIZQT__.TTF]], 11, "OUTLINE" })
	assertClean(client)
end

-- Immersion -----------------------------------------------------------------------

-- A frame of Immersion's, under `key` of its parent, as its Frame.xml's
-- parentKeys make them.
local function part(parent, key, kind)
	local frame = CreateFrame(kind or "Frame", nil, parent)
	parent[key] = frame
	return frame
end

-- A money frame's gold coin, as MoneyFrameTemplate draws it.
local function coin(frame)
	local texture = frame:CreateTexture()
	texture:SetTexture([[Interface\MoneyFrame\UI-MoneyIcons]])
	texture:SetTexCoord(0, .25, 0, 1)
	return texture
end

-- Immersion's dialogue box: the parts the skin uses.
local function immersion(world)
	table.insert(world.addons, { name = "Immersion", enabled = true, onLoad = function()
		local frame = CreateFrame("Frame", "ImmersionFrame", _G.UIParent)
		local talkBox = part(frame, "TalkBox", "Button")
		talkBox:SetSize(570, 155)
		local main = part(talkBox, "MainFrame")
		part(main, "CloseButton", "Button")
		local model = part(main, "Model", "PlayerModel")
		model:SetSize(115, 115)
		model:SetPoint("TOPLEFT", talkBox, "TOPLEFT", 21, -21)
		model.PortraitBG = model:CreateTexture(nil, "BACKGROUND")
		local background = part(talkBox, "BackgroundFrame")
		background.TextBackground = background:CreateTexture(nil, "BACKGROUND")
		background.TextBackground:SetTexture([[Interface\AddOns\Immersion\Textures\TalkingHeads.blp]])
		background.SolidBackground = background:CreateTexture(nil, "BACKGROUND")
		part(talkBox, "PortraitFrame").Portrait = talkBox.PortraitFrame:CreateTexture(nil, "OVERLAY")
		part(talkBox, "NameFrame").Name = talkBox.NameFrame:CreateFontString(nil, "ARTWORK")
		talkBox.NameFrame.Name:SetFont([[Fonts\MORPHEUS.TTF]], 22, "")
		talkBox.NameFrame.Name:SetTextColor(1, .82, 0)
		local elements = part(talkBox, "Elements")
		local content = part(elements, "Content")
		content.ObjectivesHeader = content:CreateFontString(nil, "BACKGROUND")
		local rewards = part(content, "RewardsFrame")
		rewards.Header = rewards:CreateFontString(nil, "BACKGROUND")
		coin(part(rewards, "MoneyFrame"))
		part(rewards, "MoneyIcon").MoneyIcon = rewards.MoneyIcon:CreateTexture(nil, "ARTWORK")
		local progress = part(elements, "Progress")
		progress.ReqText = progress:CreateFontString(nil, "BACKGROUND")
		coin(part(progress, "MoneyFrame"))
		-- the choices (gossip options, quests): one made, the others as
		-- they're asked for
		local titles = part(frame, "TitleButtons")
		titles.Buttons = {}
		function titles:GetButton(index)
			local button = self.Buttons[index]
			if not button then
				button = CreateFrame("Button", nil, self)
				button:SetSize(300, 40)
				button:SetBackdrop({ bgFile = [[Interface\Buttons\WHITE8X8]] })
				button:SetHighlightTexture([[Interface\AddOns\Immersion\Textures\Hilite]])
				button.Overlay = CreateFrame("Frame", nil, button)
				button.Overlay:SetBackdrop({ bgFile = [[Interface\Buttons\WHITE8X8]] })
				button.Hilite = CreateFrame("Frame", nil, button)
				button.Hilite:SetBackdrop({ bgFile = [[Interface\Buttons\WHITE8X8]] })
				button.Label = button:CreateFontString(nil, "ARTWORK")
				self.Buttons[index] = button
			end
			return button
		end
		titles:GetButton(1)
	end })
end

TestImmersion = {}

function TestImmersion:tearDown()
	client = nil
end

function TestImmersion:test_loaded_after_us_it_gets_styled()
	boot({ world = immersion })
	-- another addon first: nothing to style yet
	client:FireEvent("ADDON_LOADED", "SomethingElse")
	client.api.LoadAddOn("Immersion")
	local config = client.Engine:GetDB("Blizzard").immersion
	local window = client.Engine:GetDB("Blizzard").window
	local talkBox = _G.ImmersionFrame.TalkBox
	local elements = talkBox.Elements
	local rewards = elements.Content.RewardsFrame

	-- the windows' close button, where Immersion put it
	local close = talkBox.MainFrame.CloseButton
	lu.assertEquals(close:GetNormalTexture():GetTexture(), window.close.texture.normal)

	-- the titles in Exocet, in Immersion's colors
	local name = talkBox.NameFrame.Name
	lu.assertEquals({ name:GetFont() }, { config.title_font, config.name_size, "" })
	lu.assertEquals({ name:GetTextColor() }, { 1, .82, 0, 1 })
	for _, header in ipairs({ elements.Content.ObjectivesHeader, rewards.Header, elements.Progress.ReqText }) do
		lu.assertEquals({ header:GetFont() }, { config.title_font, config.header_size, "" })
	end

	-- our coins: in the money it gives or asks for once it's shown, and on
	-- the reward worth the most
	local ui = client.Engine:GetDB("UI").coin
	for _, frame in ipairs({ rewards.MoneyFrame, elements.Progress.MoneyFrame }) do
		_G.MoneyFrame_Update(frame, 2)
		lu.assertEquals(frame:GetRegions():GetTexture(), ui.gold_texture)
	end
	lu.assertEquals(rewards.MoneyIcon.MoneyIcon:GetTexture(), ui.gold_texture)

	-- the choices on our glass, in Diablo III's pale gold, without
	-- Immersion's blue frames: the one there and those made later (once)
	local titles = _G.ImmersionFrame.TitleButtons
	local first = titles.Buttons[1]
	lu.assertNil(first:GetBackdrop())
	lu.assertNil(first.Overlay:GetBackdrop())
	lu.assertNil(first.Hilite:GetBackdrop())
	near(color(first.Label:GetTextColor()), window.title_plate.color)
	-- the copper bar with Immersion's glow (its own gone), not grown
	lu.assertEquals(first:GetHighlightTexture():GetAlpha(), 0)
	lu.assertEquals(first.enterScale, config.choice_scale)
	local lit
	for _, region in ipairs({ first:GetRegions() }) do
		if region:IsObjectType("Texture") and (region:GetTexture() == window.row_bars.lit) then
			lit = region
		end
	end
	first.Hilite:SetAlpha(1)
	lu.assertEquals(lit:GetAlpha(), config.choice_lit_alpha)
	first.Hilite:SetAlpha(0)
	lu.assertEquals(lit:GetAlpha(), 0)
	local second = titles:GetButton(2)
	lu.assertTrue(second.DiabolicGlass)
	local regions = select("#", second:GetRegions())
	titles:GetButton(2)
	lu.assertEquals(select("#", second:GetRegions()), regions)

	-- the black behind the portrait's frame only with the portrait
	local portrait = talkBox.PortraitFrame
	local black
	for _, region in ipairs({ talkBox.BackgroundFrame:GetRegions() }) do
		if region:GetDrawLayer() == "BORDER" then
			black = region
		end
	end
	lu.assertTrue(shown(black))
	portrait:Hide()
	lu.assertFalse(shown(black))
	portrait:Show()
	lu.assertTrue(shown(black))
	assertClean(client)
end

function TestImmersion:test_loaded_before_us_too()
	boot({ world = function(world)
		immersion(world)
		local addon = world.addons[#world.addons]
		addon.loaded = true
		addon.onLoad()
		-- its portrait turned off
		_G.ImmersionFrame.TalkBox.PortraitFrame:Hide()
	end })
	local config = client.Engine:GetDB("Blizzard").immersion
	lu.assertEquals(select(2, _G.ImmersionFrame.TalkBox.NameFrame.Name:GetFont()), config.name_size)
	-- no black behind the portrait's frame
	for _, region in ipairs({ _G.ImmersionFrame.TalkBox.BackgroundFrame:GetRegions() }) do
		if region:GetDrawLayer() == "BORDER" then
			lu.assertFalse(shown(region))
		end
	end
	assertClean(client)
end

function TestImmersion:test_the_ui_hiding_immersion_is_left_alone()
	-- Immersion-WOTLK: the same name, no dialogue box
	boot({ world = function(world)
		table.insert(world.addons, { name = "Immersion", enabled = true, onLoad = function() end })
	end })
	client.api.LoadAddOn("Immersion")
	lu.assertNil(_G.ImmersionFrame)
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

function TestWatchFrame:test_diablo_iii_objectives()
	boot()
	local style = client.Engine:GetDB("Objectives").style
	-- the title in Exocet capitals, off-white, every time Blizzard sets it
	local header = _G.WatchFrameTitle
	lu.assertEquals(header:GetFontObject(), _G.DiabolicFont_HeaderRegular12)
	lu.assertEquals({ header:GetTextColor() }, { style.header_color[1], style.header_color[2], style.header_color[3], 1 })
	header:SetText(_G.OBJECTIVES_TRACKER_LABEL .. " (3)")
	lu.assertEquals(header:GetText(), _G.OBJECTIVES_TRACKER_LABEL:upper() .. " (3)")
	-- our red square to collapse it, without Blizzard's round glow
	local button = _G.WatchFrameCollapseExpandButton
	lu.assertEquals(button:GetNormalTexture():GetTexture(), style.collapse.texture)
	lu.assertEquals(button:GetPushedTexture():GetTexture(), style.collapse.texture)
	lu.assertEquals({ button:GetSize() }, { style.collapse.size, style.collapse.size })

	-- a quest title in Exocet and gold, its objectives in the body font
	local title, objective = watchLine(), watchLine()
	_G.WatchFrame_SetLine(title, nil, 0, true, "The Lich King")
	_G.WatchFrame_SetLine(objective, nil, 0, false, "Defeat him: 0/1", 1)
	lu.assertEquals(title.text:GetFontObject(), _G.DiabolicFont_HeaderRegular12)
	lu.assertEquals({ title.text:GetTextColor() }, { style.title_color[1], style.title_color[2], style.title_color[3], 1 })
	lu.assertEquals(objective.text:GetFontObject(), _G.DiabolicFont_SansRegular12)
	lu.assertEquals(objective.dash:GetFontObject(), _G.DiabolicFont_SansRegular12)
	lu.assertEquals(objective.dash:GetAlpha(), 1)
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

function TestChatSlide:test_new_lines_slide_in()
	boot()
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
