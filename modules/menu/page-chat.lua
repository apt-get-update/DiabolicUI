-- The Chat and Messages pages of /dui config: the chat's look and fading,
-- and the shorter system lines (modules/chat/cleaner.lua).
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Lua API
local ipairs = ipairs
local pairs = pairs

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local EDGE, CHECK_X, INDENT, SLIDER_COLUMN = C.EDGE, C.CHECK_X, C.INDENT, C.SLIDER_COLUMN
local CHECK_COLUMN, CHECK_HEIGHT, SLIDER_BLOCK_HEIGHT, SECTION_GAP = C.CHECK_COLUMN, C.CHECK_HEIGHT, C.SLIDER_BLOCK_HEIGHT, C.SECTION_GAP
local HEADER_GAP, ROW_GAP, CreateHeader, CreateCheckbox = C.HEADER_GAP, C.ROW_GAP, C.CreateHeader, C.CreateCheckbox
local CreateValueSlider = C.CreateValueSlider

-- The Chat page
Module.CreateChatPage = function(self)
	local chatDB = Engine:GetConfig("ChatWindows")
	local chatFiltersDB = Engine:GetConfig("ChatFilters")
	local applyChatFadeSettings = function()
		Engine:GetModule("ChatWindows"):ApplyFadeSettings()
	end

	local chatPanel, layout = NewPage("DiabolicUIOptionsPanelChat", L["Chat"])

	-- Appearance
	CreateHeader(chatPanel, layout, L["Appearance"])

	local backgroundOpacity = CreateValueSlider(chatPanel, "ChatBackgroundOpacity", L["Background Opacity"], L["How opaque the chat window's background is while you're typing."],
		0, 100,
		function() return chatDB.backgroundOpacity end,
		function(value)
			chatDB.backgroundOpacity = value
			Engine:GetModule("ChatWindows"):ApplyBackgroundOpacity()
		end)
	layout:PlaceSlider(backgroundOpacity, EDGE, layout:Row(SLIDER_BLOCK_HEIGHT, HEADER_GAP))

	local updateFadeSlidersEnabled -- assigned once the sliders exist

	local fadeGroup = layout:BeginGroup(SECTION_GAP)

	local fadeChat = CreateCheckbox(fadeGroup, "FadeChat", L["Fade Chat"], L["Fades chat text out after it has been visible for a while, instead of leaving it on screen permanently."], function(button)
		chatDB.fadeChat = button:GetChecked() and true or false
		applyChatFadeSettings()
		updateFadeSlidersEnabled()
	end)
	layout:Place(fadeChat, CHECK_X, layout:Row(CHECK_HEIGHT))

	local timeFading = CreateValueSlider(fadeGroup, "ChatTimeFading", L["Time Fading"], L["How many seconds it takes for chat text to fade out."],
		1, 5,
		function() return chatDB.timeFading end,
		function(value)
			chatDB.timeFading = value
			applyChatFadeSettings()
		end)

	local timeVisible = CreateValueSlider(fadeGroup, "ChatTimeVisible", L["Time Visible"], L["How many seconds chat text stays fully visible before it starts fading."],
		5, 120,
		function() return chatDB.timeVisible end,
		function(value)
			chatDB.timeVisible = value
			applyChatFadeSettings()
		end)

	local fadeSliders = layout:Row(SLIDER_BLOCK_HEIGHT, ROW_GAP)
	layout:PlaceSlider(timeFading, INDENT, fadeSliders)
	layout:PlaceSlider(timeVisible, INDENT + SLIDER_COLUMN, fadeSliders)

	layout:EndGroup(fadeGroup)

	-- Time Fading / Time Visible only matter while chat is actually
	-- set to fade, so grey them out and block input otherwise.
	updateFadeSlidersEnabled = function()
		timeFading:SetEnabled(chatDB.fadeChat)
		timeVisible:SetEnabled(chatDB.fadeChat)
	end

	chatPanel.okay = function() end
	chatPanel.cancel = function()
		fadeChat:SetChecked(chatDB.fadeChat)
		timeFading:SetValueSilently(chatDB.timeFading)
		timeVisible:SetValueSilently(chatDB.timeVisible)
		updateFadeSlidersEnabled()
		backgroundOpacity:SetValueSilently(chatDB.backgroundOpacity)
	end
	chatPanel.refresh = chatPanel.cancel
	chatPanel.cancel()
	return chatPanel
end

-- The Messages page
Module.CreateMessagesPage = function(self)
	local chatFiltersDB = Engine:GetConfig("ChatFilters")
	local messagesPanel, layout = NewPage("DiabolicUIOptionsPanelMessages", L["Messages"])

	CreateHeader(messagesPanel, layout, L["Shorter Messages"])

	local cleanerChecks, cleanerRow = {}
	-- two per row, the longer labels on the left
	for i, option in ipairs({
		{ "cleanProgress", L["Experience, Reputation & Honor"], L["Shorter experience, reputation, honor, skill and level up lines, like '+ 75 Reputation: Argent Crusade'."] },
		{ "cleanQuests", L["Quests"], L["Shorter lines for quests accepted and completed."] },
		{ "cleanStatus", L["Away, Busy & Rested"], L["'You are now Away.' becomes '+ Away', and the same for busy and rested."] },
		{ "cleanOnline", L["Online & Offline"], L["Marks friends and guild members coming online with a green +, and dims them going offline."] },
		{ "cleanLoot", L["Loot & Money"], L["'You receive loot: [Item]x3.' becomes '+ [Item] (3)', and looted money shows as coins."] },
		{ "cleanAuctions", L["Auctions"], L["Marks auctions created, sold and won with a green +, and cancelled, outbid and expired ones with a red -."] },
		{ "cleanAchievements", L["Achievements"], L["'Name has earned the achievement [Name]!' becomes 'Name: [Name]'."] },
		{ "hideChatNoise", L["Hide Channel Notices"], L["Hides the notices of joining, leaving and changing chat channels, and empty chat lines."] },
	}) do
		local setting = option[1]
		local check = CreateCheckbox(messagesPanel, "MessagesCleaner" .. i, option[2], option[3], function(button)
			chatFiltersDB[setting] = button:GetChecked() and true or false
		end)
		if (i % 2 == 1) then
			cleanerRow = layout:Row(CHECK_HEIGHT, (i == 1) and HEADER_GAP or ROW_GAP)
		end
		layout:Place(check, (i % 2 == 1) and CHECK_X or (CHECK_X + CHECK_COLUMN), cleanerRow)
		cleanerChecks[setting] = check
	end

	messagesPanel.okay = function() end
	messagesPanel.cancel = function()
		for setting, check in pairs(cleanerChecks) do
			check:SetChecked(chatFiltersDB[setting])
		end
	end
	messagesPanel.refresh = messagesPanel.cancel
	messagesPanel.cancel()
	return messagesPanel
end
