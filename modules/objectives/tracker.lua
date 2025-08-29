local _, Engine = ...
local Module = Engine:NewModule("ObjectiveTracker")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")
--local QuestZones = Engine:GetDB("Data: QuestZones") -- not currently in use

-- Dev Switch (you can uncomment it to disable this tracker)
--Module:SetIncompatible("DiabolicUI")

-- Register incompabilities
Module:SetIncompatible("!KalielsTracker")
Module:SetIncompatible("EskaQuestTracker")
Module:SetIncompatible("rObjectiveTracker")
Module:SetIncompatible("Questie")

-- Lua API
local _G = _G
local bit_band = bit.band
local ipairs = ipairs
local math_abs = math.abs
local math_floor = math.floor
local math_huge = math.huge
local math_sqrt = math.sqrt
local pairs = pairs
local rawget = rawget
local select = select
local setmetatable = setmetatable
local string_match = string.match
local string_gmatch = string.gmatch
local string_gsub = string.gsub
local string_lower = string.lower
local string_upper = string.upper
local table_insert = table.insert
local table_remove = table.remove
local table_sort = table.sort
local table_wipe = table.wipe
local tonumber = tonumber
local unpack = unpack

-- WoW API
local AddQuestWatch = _G.AddQuestWatch
local AddWorldQuestWatch = _G.AddWorldQuestWatch
local C_TaskQuest = _G.C_TaskQuest
local ChatEdit_GetActiveWindow = _G.ChatEdit_GetActiveWindow
local ChatEdit_InsertLink = _G.ChatEdit_InsertLink
local CloseDropDownMenus = _G.CloseDropDownMenus
local GetAuctionItemClasses = _G.GetAuctionItemClasses
local GetAuctionItemSubClasses = _G.GetAuctionItemSubClasses
local GetAutoQuestPopUp = _G.GetAutoQuestPopUp
local GetCurrentMapAreaID = _G.GetCurrentMapAreaID
local GetCVarBool = _G.GetCVarBool
local GetDistanceSqToQuest = _G.GetDistanceSqToQuest
local GetFactionInfoByID = _G.GetFactionInfoByID
local GetItemSubClassInfo = _G.GetItemSubClassInfo
local GetMapNameByID = _G.GetMapNameByID
local GetMoney = _G.GetMoney
local GetNumAutoQuestPopUps = _G.GetNumAutoQuestPopUps
local GetNumQuestLeaderBoards = _G.GetNumQuestLeaderBoards
local GetNumQuestLogEntries = _G.GetNumQuestLogEntries
local GetNumQuestWatches = _G.GetNumQuestWatches
local GetNumWorldQuestWatches = _G.GetNumWorldQuestWatches
local GetPlayerMapPosition = _G.GetPlayerMapPosition
local GetProfessions = _G.GetProfessions
local GetQuestDifficultyColor = _G.GetQuestDifficultyColor
local GetQuestID = _G.GetQuestID
local GetQuestLogCompletionText = _G.GetQuestLogCompletionText
local GetQuestLogIndexByID = _G.GetQuestLogIndexByID
local GetQuestLogQuestText = _G.GetQuestLogQuestText
local GetQuestLogRequiredMoney = _G.GetQuestLogRequiredMoney
local GetQuestLogSelection = _G.GetQuestLogSelection
local GetQuestLogSpecialItemInfo = _G.GetQuestLogSpecialItemInfo
local GetQuestLogTitle = _G.GetQuestLogTitle
local GetQuestObjectiveInfo = _G.GetQuestObjectiveInfo
local GetQuestProgressBarPercent = _G.GetQuestProgressBarPercent
local GetQuestTagInfo = _G.GetQuestTagInfo
local GetQuestWatchInfo = _G.GetQuestWatchInfo
local GetQuestWorldMapAreaID = _G.GetQuestWorldMapAreaID
local GetSuperTrackedQuestID = _G.GetSuperTrackedQuestID
local GetTaskInfo = _G.GetTaskInfo
local GetWorldQuestWatchInfo = _G.GetWorldQuestWatchInfo
local HaveQuestData = _G.HaveQuestData
local IsModifiedClick = _G.IsModifiedClick
local IsQuestBounty = _G.IsQuestBounty
local IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted
local IsQuestInvasion = _G.IsQuestInvasion
local IsQuestTask = _G.IsQuestTask
local IsQuestWatched = _G.IsQuestWatched
local IsWorldQuestWatched = _G.IsWorldQuestWatched
local PlaySoundKitID = Engine:IsBuild("7.3.0") and _G.PlaySound or _G.PlaySoundKitID
local QuestGetAutoAccept = _G.QuestGetAutoAccept
local QuestHasPOIInfo = _G.QuestHasPOIInfo
local QuestLog_OpenToQuest = _G.QuestLog_OpenToQuest
local QuestLogPopupDetailFrame_Show = _G.QuestLogPopupDetailFrame_Show
local QuestUtils_IsQuestWorldQuest = _G.QuestUtils_IsQuestWorldQuest or _G.QuestMapFrame_IsQuestWorldQuest -- 7.0.3 API
local RemoveQuestWatch = _G.RemoveQuestWatch
local RemoveWorldQuestWatch = _G.RemoveWorldQuestWatch
local SelectQuestLogEntry = _G.SelectQuestLogEntry
local SetMapToCurrentZone = _G.SetMapToCurrentZone
local SetSuperTrackedQuestID = _G.SetSuperTrackedQuestID
local ShowQuestComplete = _G.ShowQuestComplete
local ShowQuestOffer = _G.ShowQuestOffer
local WorldMap_GetWorldQuestRewardType = _G.WorldMap_GetWorldQuestRewardType

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip
local QuestFrame = _G.QuestFrame
local QuestFrameAcceptButton = _G.QuestFrameAcceptButton
local QuestFrameRewardPanel = _G.QuestFrameRewardPanel
local WorldMapFrame = _G.WorldMapFrame

-- Copied from WorldMapFrame.lua in Legion
local WQ = {
	WORLD_QUEST_REWARD_TYPE_FLAG_GOLD = _G.WORLD_QUEST_REWARD_TYPE_FLAG_GOLD, -- 0x0001
	WORLD_QUEST_REWARD_TYPE_FLAG_ORDER_RESOURCES = _G.WORLD_QUEST_REWARD_TYPE_FLAG_ORDER_RESOURCES, -- 0x0002
	WORLD_QUEST_REWARD_TYPE_FLAG_ARTIFACT_POWER = _G.WORLD_QUEST_REWARD_TYPE_FLAG_ARTIFACT_POWER, -- 0x0004
	WORLD_QUEST_REWARD_TYPE_FLAG_MATERIALS = _G.WORLD_QUEST_REWARD_TYPE_FLAG_MATERIALS, -- 0x0008
	WORLD_QUEST_REWARD_TYPE_FLAG_EQUIPMENT = _G.WORLD_QUEST_REWARD_TYPE_FLAG_EQUIPMENT -- 0x0010

}
	
-- Lua enums used to identify various types of Legion world quests
local LE = {
	LE_QUEST_TAG_TYPE_INVASION = _G.LE_QUEST_TAG_TYPE_INVASION,
	LE_QUEST_TAG_TYPE_DUNGEON = _G.LE_QUEST_TAG_TYPE_DUNGEON,
	LE_QUEST_TAG_TYPE_RAID = _G.LE_QUEST_TAG_TYPE_RAID,
	LE_WORLD_QUEST_QUALITY_RARE = _G.LE_WORLD_QUEST_QUALITY_RARE,
	LE_WORLD_QUEST_QUALITY_EPIC = _G.LE_WORLD_QUEST_QUALITY_EPIC,
	LE_QUEST_TAG_TYPE_PVP = _G.LE_QUEST_TAG_TYPE_PVP,
	LE_QUEST_TAG_TYPE_PET_BATTLE = _G.LE_QUEST_TAG_TYPE_PET_BATTLE,
	LE_QUEST_TAG_TYPE_PROFESSION = _G.LE_QUEST_TAG_TYPE_PROFESSION,
	LE_ITEM_QUALITY_COMMON = _G.LE_ITEM_QUALITY_COMMON
}

-- Client Constants
local ENGINE_BFA 		= Engine:IsBuild("BfA")
local ENGINE_LEGION 	= Engine:IsBuild("Legion")
local ENGINE_WOD 		= Engine:IsBuild("WoD")
local ENGINE_MOP 		= Engine:IsBuild("MoP")
local ENGINE_CATA 		= Engine:IsBuild("Cata")

-- Using our own constant list as a proxy for this value
local WORLD_QUESTS_AVAILABLE_QUEST_ID = Engine:GetConstant("WORLD_QUESTS_AVAILABLE_QUEST_ID")
local HAS_WORLD_QUESTS = ENGINE_LEGION and IsQuestFlaggedCompleted(WORLD_QUESTS_AVAILABLE_QUEST_ID)

-- 	Tracking quest zones is a tricky thing, since the map needs to be changed  
-- 	to the current zone in order to retrieve that information about regular quests. 
-- 	However, doing this while the worldmap is open will lock it to the current zone, 
--  preventing the user from changing the visible zone. 
-- 	
-- 	So in order to minimize the impact on the game experience, avoid overriding player choices related to the visible map zone, 
-- 	and also allow us to view quests from other zones in the tracker depending on what zone the visible map is set to, 
-- 	we track both the actual player zone and the current map zone individually.
local CURRENT_PLAYER_ZONE -- The zone the player is in, updated upon entering the world, and zone changes
local CURRENT_MAP_ZONE -- The zone the world map is set to, updated on map display and map zone changes
local CURRENT_PLAYER_X, CURRENT_PLAYER_Y -- Tracking player position when the map isn't set to the current zone

-- Tracking number of available world quests, 
-- in an attempt to avoid blanking out the tracker.
local NUM_WORLD_QUESTS = 0
local NUM_WORLD_QUEST_ZONES = 0

-- Constant to attempt to track the virtual size of an on-screen pixel
local PIXEL_SIZE 

local questData = {} -- quest status and objectives by questID 

local allTrackedQuests = {} -- all tracked quests
local zoneTrackedQuests = {} -- quests auto tracked by zone
local userTrackedQuests = {} -- quests manually tracked by the user

local sortedTrackedQuests = {} -- indexed table with the currently tracked quests sorted
local trackedQuestsByQuestID = {} -- a fast lookup table to decide if a quest is visible
local questWatchQueue = {} -- temporary cache for quests to be tracked
local worldQuestWatchQueue = {} -- temporary cache for world quests to be tracked

local questLogCache = {} -- cache of the current questlog
local worldQuestCache = {} -- cache of the current world quests

local itemButtons = {} -- item button cache, mostly for easier naming
local activeItemButtons = {} -- cache of active and visible item buttons

-- game client locale
local DEFAULT_CAPS = GetLocale() == "deDE"

-- Broken Isles zones 
-- used to parse for available world quests.
local brokenIslesContinent = 1007 -- Broken Isles (The whole continent)
local brokenIslesZones = {
	1015,	-- Aszuna
	1021,	-- Broken Shore
	1014,	-- Dalaran
	1098,	-- Eye of Azshara
	1024,	-- Highmountain
	1017,	-- Stormheim
	1033,	-- Suramar
	1018,	-- Val'sharah

	1170, 	-- Mac'Aree
	1171, 	-- Antoran Wastes
	1135, 	-- Krokuun
	1184, 	-- Argus 
	1080 	-- Thunder Totem
}

local proxyZones = {
	[ 864] = 30, 	-- Northshire 					> Elwynn Forest
	[1077] = 1018,	-- The Dreamgrove (Druid) 		> Val'sharah
	[1080] = 1024, 	-- Thunder Totem 				> Highmountain
	[1072] = 1024 	-- Trueshot Lodge (Hunter) 		> Highmountain
}


-- Create a faster lookup table to figure out if we're in a Legion outdoors zone
-- We're including the main continent map in this lookup table too, 
-- since we're using this table to decide whether or not to scan world quests. 
local isLegionZone = { [brokenIslesContinent] = true }
for _,zoneID in pairs(brokenIslesZones) do
	isLegionZone[zoneID] = true
end

-- Emissary quests
local emissaryQuestIDs = {
	[42170] = true, -- The Dreamweavers 
	[42233] = true, -- Highmountain Tribes
	[42234] = true, -- The Valarjar
	[42420] = true, -- Court of Farondis 
	[42421] = true, -- The Nightfallen 
	[42422] = true  -- The Wardens
}

-- Order Hall zones
-- *Note that Death Knights, Paladins, Rogues and Warlocks 
--  have order halls that either are inside existing cities 
--  or instanced zones not part of the broken isles, 
--  and therefore aren't needed in this list. 
local orderHallZones = {
	1052,	-- Mardum, the Shattered Abyss		Demon Hunter
	1077,	-- The Dreamgrove					Druid
	1072,	-- Trueshot Lodge					Hunter
	1068,	-- Hall of the Guardian				Mage
	1044,	-- The Wandering Isle				Monk
	1040,	-- Netherlight Temple				Priest
	1057,	-- The Heart of Azeroth				Shaman
	1035	-- Skyhold							Warrior
}

-- Legion Raids 
local legionRaids = {
	1094,	-- The Emerald Nightmare
	1114,	-- Trial of Valor
	1088,	-- The Nighthold
	1147	-- Tomb of Sargeras
}

-- Legion Dungeons
local legionDungeons = {
	1081,	-- Black Rook Hold
	1146,	-- Cathedral of Eternal Night
	1087,	-- Court of Stars
	1067,	-- Darkheart Thicket
	1046,	-- Eye of Azshara
	1041,	-- Halls of Valor
	1042,	-- Maw of Souls
	1065,	-- Neltharion's Lair
	1115,	-- Return to Karazhan
	1079,	-- The Arcway
	1045,	-- Vault of the Wardens
	1066	-- Violet Hold
}

-- Localized Blizzard strings
local BLIZZ_LOCALE = {
	ACCEPT = _G.ACCEPT,
	COMPLETE = _G.COMPLETE,
	COMPLETE_QUEST = _G.COMPLETE_QUEST,
	CONTINUE = _G.CONTINUE,
	FAILED = _G.FAILED,
	NEW = _G.NEW,
	OBJECTIVES = _G.OBJECTIVES_TRACKER_LABEL,
	QUEST_COMPLETE = _G.QUEST_WATCH_QUEST_READY or _G.QUEST_WATCH_QUEST_COMPLETE or _G.QUEST_COMPLETE,
	QUEST_FAILED = _G.QUEST_FAILED,
	QUEST_WATCH_CLICK_TO_COMPLETE = _G.QUEST_WATCH_CLICK_TO_COMPLETE,
	QUEST = ENGINE_LEGION and GetItemSubClassInfo(_G.LE_ITEM_CLASS_QUESTITEM, (select(1, GetAuctionItemSubClasses(_G.LE_ITEM_CLASS_QUESTITEM)))) or ENGINE_CATA and (select(10, GetAuctionItemClasses())) or (select(12, GetAuctionItemClasses())) or "Quest", -- the fallback isn't actually needed
	UPDATE = _G.UPDATE,
	WORLD_QUEST_COMPLETE = _G.WORLD_QUEST_COMPLETE
}

-- Blizzard textures 
local TEXTURE = {
	BLANK = [[Interface\ChatFrame\ChatFrameBackground]],
	BLING = [[Interface\Cooldown\star4]],
	EDGE_LOC = [[Interface\Cooldown\edge-LoC]],
	EDGE_NORMAL = [[Interface\Cooldown\edge]]
}


-- We'll create search patterns from these later on, 
-- to better parse quest objectives and figure out what we need, 
-- what has changed, what events to look out for and so on. 
-- 
--	QUEST_SUGGESTED_GROUP_NUM = "Suggested Players [%d]";
--	QUEST_SUGGESTED_GROUP_NUM_TAG = "Group: %d";
--	QUEST_FACTION_NEEDED = "%s:  %s / %s";
--	QUEST_ITEMS_NEEDED = "%s: %d/%d";
--	QUEST_MONSTERS_KILLED = "%s slain: %d/%d";
--	QUEST_OBJECTS_FOUND = "%s: %d/%d";
--	QUEST_PLAYERS_KILLED = "Players slain: %d/%d";
--	QUEST_FACTION_NEEDED_NOPROGRESS = "%s:  %s";
--	QUEST_INTERMEDIATE_ITEMS_NEEDED = "%s: (%d)";
--	QUEST_ITEMS_NEEDED_NOPROGRESS = "%s x %d";
--	QUEST_MONSTERS_KILLED_NOPROGRESS = "%s x %d";
--	QUEST_OBJECTS_FOUND_NOPROGRESS = "%s x %d";
--	QUEST_PLAYERS_KILLED_NOPROGRESS = "Players x %d";
-- 
local questCaptures = setmetatable({
	item 		= string_gsub(string_gsub("^" .. _G.QUEST_ITEMS_NEEDED, 	"%%[0-9%$]-s", "(.-)"), "%%[0-9%$]-d", "(%%d+)"),
	monster 	= string_gsub(string_gsub("^" .. _G.QUEST_MONSTERS_KILLED, 	"%%[0-9%$]-s", "(.-)"), "%%[0-9%$]-d", "(%%d+)"),
	faction 	= string_gsub(string_gsub("^" .. _G.QUEST_FACTION_NEEDED, 	"%%[0-9%$]-s", "(.-)"), "%%[0-9%$]-d", "(%%d+)"),
	reputation 	= string_gsub(string_gsub("^" .. _G.QUEST_FACTION_NEEDED, 	"%%[0-9%$]-s", "(.-)"), "%%[0-9%$]-d", "(%%d+)"),
	unknown 	= string_gsub(string_gsub("^" .. _G.QUEST_OBJECTS_FOUND, 	"%%[0-9%$]-s", "(.-)"), "%%[0-9%$]-d", "(%%d+)")
}, { __index = function(self) return rawget(self, "unknown") end})

-- Hackz!
if ENGINE_BFA then 
	GetCurrentMapAreaID = function()
		if WorldMapFrame:IsShown() then 
			return WorldMapFrame:GetMapID()
		else 
			return C_Map.GetBestMapForUnit("player")
		end 
	end

	-- removed, haven't figured out how to replace it yet
	GetQuestWorldMapAreaID = function(questID)
	end
end 

-- Utility functions and stuff
-----------------------------------------------------
-- Strip a string of its line breaks
local stripString = function(msg)
	if (not msg) then
		return ""
	end
	msg = string_gsub(msg, "\|n", "")
	msg = string_gsub(msg, "\\n", "") -- this one is vital, a lot of quest texts use it!
	msg = string_gsub(msg, "|n", "")
	return msg
end

-- Capitalize the first letter in each word
local titleCase = function(first, rest) return string_upper(first)..string_lower(rest) end
local capitalizeString = function(msg)
	return string_gsub(msg or "", "(%a)([%w_']*)", titleCase)
end


-- Parse a string for info about sizes and words.
-- The fontString should be set to a LARGE size before doing this. 
local parseString = function(msg, fontString, words, wordWidths)
	words = words and table_wipe(words) or {}
	wordWidths = wordWidths and table_wipe(wordWidths) or {}

	-- Retrieve the dummyString for calculations
	local dummyString = fontString.dummyString

	-- Get the width of the full string
	dummyString:SetText(msg)
	local fullWidth = math_floor(dummyString:GetStringWidth() + 1)

	-- Get the width of a single space character
	dummyString:SetText(" ")
	local spaceWidth = math_floor(dummyString:GetStringWidth() + 1)

	-- Split the string into words
	for word in  string_gmatch(msg, "%S+") do 
		words[#words + 1] = word
	end

	-- Calculate word word widths
	for i in ipairs(words) do
		dummyString:SetText(words[i])
		wordWidths[i] = math_floor(dummyString:GetStringWidth() + .5)
	end

	-- Return sized and tables 
	return fullWidth, spaceWidth, wordWidths, words
end


-- Set a message and calculate it's best size for display.
-- *The excessive amount of comments here is because my brain 
-- turns to mush when working with scripts like this, 
-- and without them I just keep messing things up. 
-- I guess my near photographic memory from my teenage years is truly dead. :'(
local dummy = Engine:CreateFrame("Frame", nil, "UICenter")
dummy:Place("TOP", "UICenter", "BOTTOM", 0, -1000) -- this should be offscreen on all setups
dummy:SetAlpha(0) -- just in case some total lunatic has 9 monitors placed in a grid with the main one in the center
dummy:SetSize(2,2) 

local setTextAndGetSize = function(fontString, msg, minWidth, minHeight)
	fontString:Hide() -- hide the madness we're about to do

	local lineSpacing = fontString:GetSpacing()
	local newHeight, newMsg

	-- Get rid of line breaks, we're making our own later on instead.
	if DEFAULT_CAPS then 
		msg = stripString(msg)
	else 
		-- capitalize words in most locales
		msg = capitalizeString(stripString(msg))
	end 

	local dummyString = fontString.dummyString 
	if (not dummyString) then
		dummyString = dummy:CreateFontString()
		dummyString:Hide()
		dummyString:SetFontObject(fontString:GetFontObject())
		dummyString:SetPoint("TOP", 0, 0)
		fontString.dummyString = dummyString
	end
	dummyString:SetSize(minWidth*10, minHeight*10 + lineSpacing*9)

	-- Parse the string, split into words and calculate all sizes 
	fontString.fullWidth, fontString.spaceWidth, fontString.wordWidths, 
	fontString.words = parseString(msg, fontString, fontString.words, fontString.wordWidths)

	-- Because Blizzard keeps changing 20 to 19.9999995
	-- We also need an extra space's width to avoid the strings
	-- getting truncated in Legion. Because large enough isn't large enough anymore. /sigh
	minWidth = math_floor(minWidth + 1 + fontString.spaceWidth)

	local wordsPerLine = table_wipe(fontString.wordsPerLine or {})

	-- Figure out the height and lines of the text
	if fontString.fullWidth > minWidth then
		local currentWidth = 0
		local currentLineWords = 0

		-- Figure out the minimum number of lines
		local numLines = 1
		for i in ipairs(fontString.wordWidths) do
			-- Retrieve the length of the next word
			local nextWordWidth = fontString.wordWidths[i]

			-- see if it's space for the current word, if not start a new line
			if ((currentWidth + nextWordWidth) > minWidth) then

				-- Store the number of words on the current line
				wordsPerLine[numLines] = currentLineWords

				-- Increase the line counter, as one more is needed
				numLines = numLines + 1
				
				-- Reset the width of the current line, as we're starting a new one
				currentWidth = 0

				-- Reset the number of words on the current line, as we're starting a new one
				currentLineWords = 0
			end

			-- Add the width of the current word to the length of the current line
			currentWidth = currentWidth + nextWordWidth

			-- Add the current word to the current line's word count
			currentLineWords = currentLineWords + 1

			-- are there more words, if so should we break or continue?
			if (i < #fontString.wordWidths) then

				-- see if there's room for a space, if not we start a new line
				if (currentWidth + fontString.spaceWidth) > minWidth then
					-- Store the number of words on the current line
					wordsPerLine[numLines] = currentLineWords

					-- Increase the line counter, as one more is needed
					numLines = numLines + 1
					
					-- Reset the width of the current line, as we're starting a new one
					currentWidth = 0

					-- Reset the number of words on the current line, as we're starting a new one
					currentLineWords = 0

				else
					-- We have room for a space character, so we add one.
					currentWidth = currentWidth + fontString.spaceWidth
				end
			else
				-- Last word, so store the number of words on this line now, 
				-- as this loop won't run again and it feels clunky adding it afterwords. :)
				wordsPerLine[numLines] = currentLineWords
			end
		end

		-- Store the table with the number of words per line in the fontstring
		fontString.wordsPerLine = wordsPerLine

		-- Figure out if the last line has so few words it looks weird
		if (numLines > 1) then
			local wordsOnLastLine = fontString.wordsPerLine[numLines]
			local wordsOnSecondToLastLine = fontString.wordsPerLine[numLines - 1]
			local lastWord = #fontString.wordWidths
			local lastWordOnSecondToLastLine = lastWord - wordsOnLastLine

			-- Get the width of the last line
			local lastLineWidth = 0
			for i = 1, fontString.wordsPerLine[numLines] do
				lastLineWidth = lastLineWidth + fontString.wordWidths[lastWordOnSecondToLastLine + i]
			end

			-- Get the width of the second to last line
			local secondToLastLineWidth = 0
			local lastWordOnThirdLastLine = lastWordOnSecondToLastLine - wordsOnSecondToLastLine
			for i = 1, fontString.wordsPerLine[numLines - 1] do
				secondToLastLineWidth = secondToLastLineWidth + fontString.wordWidths[lastWordOnThirdLastLine + i]
			end

			-- Split the words on the 2 last lines, but keep the second to last larger
			for i = lastWord - 1, 1, -1 do
				local currentWordWidth = fontString.wordWidths[i]
				if ((lastLineWidth + currentWordWidth) < minWidth) and ((secondToLastLineWidth - currentWordWidth) > (lastLineWidth + currentWordWidth)) then
					fontString.wordsPerLine[numLines] = fontString.wordsPerLine[numLines] + 1
					fontString.wordsPerLine[numLines - 1] = fontString.wordsPerLine[numLines - 1] - 1

					secondToLastLineWidth = secondToLastLineWidth - currentWordWidth
					lastLineWidth = lastLineWidth + currentWordWidth
				else
					break
				end
			end
		end

		-- Format the string with our own line breaks
		newMsg = ""
		local currentWord = 1
		for currentLine, numWords in ipairs(fontString.wordsPerLine) do
			for i = 1, numWords do
				newMsg = newMsg .. fontString.words[currentWord]
				if (i == numWords) then
					if (currentLine < numLines) then
						newMsg = newMsg .. "\n" -- add a line break
					end
				else
					newMsg = newMsg .. " " -- add a space between the words
				end
				currentWord = currentWord + 1
			end
		end
		newHeight = minHeight*numLines + (numLines-1)*lineSpacing
	end

	-- Set our new sizes
	fontString:SetHeight(newHeight or minHeight) 
	fontString:SetText(newMsg or msg)

	-- Show the fontstring again
	fontString:Show() 

	-- Return the sizes
	return newHeight or minHeight
end

-- Create a square/dot used for unfinished objectives (and the completion texts)
local createDot = function(parent)
	local backdrop = {
		bgFile = TEXTURE.BLANK,
		edgeFile = TEXTURE.BLANK,
		edgeSize = 1,
		insets = {
			left = -1,
			right = -1,
			top = -1,
			bottom = -1
		}
	}
	local dot = parent:CreateFrame("Frame")
	dot:SetSize(10, 10)
	dot:SetBackdrop(backdrop)
	dot:SetBackdropColor(0, 0, 0, .75)
	dot:SetBackdropBorderColor( 240/255, 240/255, 240/255, .85)

	return dot
end

-- Sort function for our tracker display
-- 	world quests > normal quests
-- 	world quest proximity > level > name

local sortByLevelAndName = function(a,b)
	if (a.questLevel and b.questLevel and (a.questLevel ~= b.questLevel)) then
		return (a.questLevel < b.questLevel)
	elseif a.questTitle and b.questTitle then
		return (a.questTitle < b.questTitle)
	else
		return false
	end
end

-- Be careful to only call this in Legion, 
-- as it's using API calls added there.
local sortByProximity = function(a,b)

	-- Get current player coordinates
	local posX, posY = GetPlayerMapPosition("player")

	-- Store them for later if they exist
	if (posX and posY) and (posX > 0) and (posY > 0) then
		CURRENT_PLAYER_X, CURRENT_PLAYER_Y = posX, posY
	else 
		posX, posY = CURRENT_PLAYER_X, CURRENT_PLAYER_Y
	end

	-- Figure out which is closest, if we have current or stored player coordinates available
	if (posX and posY) and (a.x and a.y and b.x and b.y) then
		local distanceA = C_TaskQuest.GetDistanceSqToQuest(a.questID)
		local distanceB = C_TaskQuest.GetDistanceSqToQuest(b.questID)
		if (distanceA or distanceB) then
			if (distanceA and distanceB) then
				return (distanceA < distanceB)
			elseif distanceA then 
				return true
			end
		else
			return sortByLevelAndName(a,b)
		end 
	else
		return sortByLevelAndName(a,b)
	end
end

local sortFunction = function(a,b)

	-- This happens, no idea why. Appears to have something to do with nested tables.
	if (not b) then 
		return true 
	end

	-- Emissary Quests(ALWAYS first) > World Quests > Normal Quests > Elite World Quests > Completed Quests(ALWAYS last)
	if a.isComplete or b.isComplete then
		if a.isComplete == b.isComplete then
			return a.questTitle < b.questTitle
		else
			return not a.isComplete
		end
	elseif a.isEmissaryQuest or b.isEmissaryQuest then
		if a.isEmissaryQuest == b.isEmissaryQuest then
			return sortByProximity(a,b)
		else
			return a.isEmissaryQuest
		end
	else
		local aWQ = a.isWorldQuest and (not a.isElite)
		local bWQ = b.isWorldQuest and (not b.isElite)
		if aWQ or bWQ then
			if aWQ == bWQ then
				return sortByProximity(a,b)
			else
				return aWQ
			end
		else
			if a.isNormalQuest or b.isNormalQuest then
				if a.isNormalQuest == b.isNormalQuest then
					return sortByLevelAndName(a,b)
				else
					return a.isNormalQuest
				end
			else
				return sortByLevelAndName(a,b)
			end
		end
	end

end

local sortFunctionWQLast = function(a,b)

	-- This happens, no idea why. Appears to have something to do with nested tables.
	if (not b) then 
		return true 
	end

	-- Emissary Quests(ALWAYS first) > World Quests > Normal Quests > Elite World Quests > Completed Quests(ALWAYS last)
	if a.isComplete or b.isComplete then
		if a.isComplete == b.isComplete then
			return a.questTitle < b.questTitle
		else
			return not a.isComplete
		end

	elseif a.isNormalQuest or b.isNormalQuest then
		if a.isNormalQuest == b.isNormalQuest then
			if a.isProfessionQuest or b.isProfessionQuest then
				if a.isProfessionQuest == b.isProfessionQuest then
					return sortByLevelAndName(a,b)
				else
					return a.isProfessionQuest
				end
			else 
				return sortByLevelAndName(a,b)
			end
		else
			return a.isNormalQuest
		end
	else
		local aWQ = a.isWorldQuest and (not a.isElite)
		local bWQ = b.isWorldQuest and (not b.isElite)
		if aWQ or bWQ then
			if aWQ == bWQ then
				return sortByProximity(a,b)
			else
				return aWQ
			end
		else
			if a.isEmissaryQuest or b.isEmissaryQuest then
				if a.isEmissaryQuest == b.isEmissaryQuest then
					return sortByProximity(a,b)
				else
					return a.isEmissaryQuest
				end
			else
				return sortByLevelAndName(a,b)
			end
		end
	end
end

-- Maximize/Minimize button Template
-----------------------------------------------------
local MinMaxButton = Engine:CreateFrame("Button")
MinMaxButton_MT = { __index = MinMaxButton }

MinMaxButton.OnClick = function(self, mouseButton)
	if self:IsEnabled() then
		if (self.currentState == "maximized") then
			self.body:Hide()
			self.currentState = "minimized"
			self.title:Place(unpack(self.title.positionMinimized))
			PlaySoundKitID(SOUNDKIT.IG_QUEST_LIST_CLOSE, "SFX")
		else
			self.body:Show()
			self.currentState = "maximized"
			self.title:Place(unpack(self.title.position))
			PlaySoundKitID(SOUNDKIT.IG_QUEST_LIST_OPEN, "SFX")
		end
		if GameTooltip:IsForbidden() then
			return
		end
		if GameTooltip:IsShown() and (GameTooltip:GetOwner() == self) then
			self:OnEnter()
		end
	end	
end

MinMaxButton.OnEnter = function(self)
	if GameTooltip:IsForbidden() then
		return
	end

	do return end -- not today

	local r, g, b = unpack(C.General.OffWhite)
	local maximized = self.currentState == "maximized"

	if maximized then 
		GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -20, 0)
	else
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
	end

	local numQuests, numXPQuests, numWorldQuests = 0, 0, 0
	for questID in pairs(questLogCache) do
		numQuests = numQuests + 1
		numXPQuests = numXPQuests + 1
	end

	if ENGINE_LEGION then
		for questID in pairs(worldQuestCache) do
			numQuests = numQuests + 1
			numWorldQuests = numWorldQuests + 1
		end
	end

	GameTooltip:AddLine(self.title:GetText())
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Quests in this zone:", #sortedTrackedQuests, r, g, b)

	if ENGINE_LEGION then
		GameTooltip:AddDoubleLine("World Quests:", numWorldQuests, r, g, b)
	end

	GameTooltip:AddDoubleLine("XP Quests:", numXPQuests, r, g, b)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total quests:", numQuests, r, g, b)
	GameTooltip:AddLine(" ")

	if maximized then 
		GameTooltip:AddLine("<Left-click> to minimize the tracker.", unpack(C.General.OffGreen))
	else
		GameTooltip:AddLine("<Left-click> to maximize the tracker.", unpack(C.General.OffGreen))
	end

	GameTooltip:Show()
end 

MinMaxButton.OnLeave = function(self)
	do return end -- not today
	if (not GameTooltip:IsForbidden()) then
		GameTooltip:Hide()
	end
end


-- Item Template
-----------------------------------------------------
local Item = Engine:CreateFrame("Button")
Item_MT = { __index = Item }


-- Item Cache 
-- *purpose is to allow spawning of new buttons
--  while engaged in combat without risking taint.
-----------------------------------------------------
local ItemCache = { stack = {} }

ItemCache.Push = function(self, item)
end 

ItemCache.Pull = function(self)
end 


-- Entry Title (clickable button)
-----------------------------------------------------
local Title = Engine:CreateFrame("Button")
Title_MT = { __index = Title }

Title.OnClick = function(self, mouseButton)
	local owner = self._owner
	local questLogIndex = owner.questLogIndex
	local currentQuestData = questData[owner.questID]

	-- This is needed to open to the correct index in Legion
	-- *Might be needed in other versions too, not sure. 
	--  Function got added in Cata, so that's where we start too.
	if ENGINE_CATA and (not currentQuestData.isWorldQuest) then
		questLogIndex = GetQuestLogIndexByID(owner.questID)
	end

	if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
		local questLink = GetQuestLink(questLogIndex)
		if questLink then
			ChatEdit_InsertLink(questLink)
		end

	elseif (mouseButton == "MiddleButton") and WorldQuestGroupFinder and currentQuestData.isWorldQuest and (not currentQuestData.isComplete) then
		WorldQuestGroupFinder.HandleBlockClick(owner.questID)

	elseif not(mouseButton == "RightButton") and (not currentQuestData.isWorldQuest) then
		CloseDropDownMenus()
		if ENGINE_WOD then
			if currentQuestData.isAutoComplete then 
				ShowQuestComplete(questLogIndex)
			else 
				QuestLogPopupDetailFrame_Show(questLogIndex)
			end 
		else
			QuestLog_OpenToQuest(questLogIndex)
		end
	end
end


-- Entry Template (tracked quests, achievements, etc)
-----------------------------------------------------
local Entry = Engine:CreateFrame("Frame")
Entry_MT = { __index = Entry }

-- Creates a new objective element
Entry.AddObjective = function(self, objectiveType)
	local objectives = self.objectives

	local width = math_floor(self:GetWidth() + .5)

	local objective = self:CreateFrame("Frame")
	objective:SetSize(width, .0001)

	-- Objective text
	local msg = objective:CreateFontString()
	msg:SetHeight(objectives.standardHeight)
	msg:SetWidth(width)
	msg:ClearAllPoints()
	msg:Point("TOP", objective, "TOP", 0, 0)
	msg:Point("LEFT", self, "LEFT", objectives.leftMargin, 0)
	msg:SetDrawLayer("BACKGROUND")
	msg:SetJustifyH("LEFT")
	msg:SetJustifyV("TOP")
	msg:SetIndentedWordWrap(false)
	msg:SetWordWrap(true)
	msg:SetNonSpaceWrap(false)
	msg:SetFontObject(objectives.normalFont)
	msg:SetSpacing(objectives.lineSpacing)

	-- Unfinished objective dot
	local dot = createDot(objective)
	dot:ClearAllPoints()
	dot:Point("TOP", msg, "TOPLEFT", -math_floor(objectives.leftMargin/2), objectives.dotAdjust)

	objective.msg = msg
	objective.dot = dot

	return objective
end

local UIHider = CreateFrame("Frame")
UIHider:Hide()

-- Creates a new quest item element
Entry.AddQuestItem = function(self)
	local config = self.config
	local num = #itemButtons + 1
	local name = "Engine_QuestItemButton"..num

	local item = setmetatable(self:CreateFrame("Button", name, ENGINE_WOD and "QuestObjectiveItemButtonTemplate" or "WatchFrameItemButtonTemplate"), Item_MT)
	item:Hide()
	item:EnableMouse(true)
	item:RegisterForClicks("AnyUp")

	-- We just clean out everything from the old template, 
	-- as we're really only after its inherited functionality.
	-- The looks and elements will be manually created by us instead.
	if ENGINE_WOD then
		for i,key in ipairs({ "Cooldown", "Count", "icon", "HotKey", "NormalTexture" }) do
			local exists = item[key]
			if exists then
				exists:SetParent(UIHider)
				exists:Hide()
			end
		end
	else
		for i,key in ipairs({ "Cooldown", "Count", "HotKey", "IconTexture", "NormalTexture", "Stock" }) do
			local exists = _G[name..key]
			if exists then
				exists:SetParent(UIHider)
				exists:Hide()
			end
		end
	end

	item:SetScript("OnUpdate", nil)
	item:SetScript("OnEvent", nil)
	item:UnregisterAllEvents()
	item:SetPushedTexture("")
	item:SetHighlightTexture("")

	item:SetSize(config.body.entry.item.size[1], config.body.entry.item.size[2])
	item:SetFrameLevel(self:GetFrameLevel() + 10) -- gotta get it above the title button

	local glow = item:CreateFrame("Frame")
	glow:SetFrameLevel(item:GetFrameLevel())
	glow:SetPoint("CENTER", 0, 0)
	glow:SetSize(config.body.entry.item.glow.size[1], config.body.entry.item.glow.size[2])
	glow:SetBackdrop(config.body.entry.item.glow.backdrop)
	glow:SetBackdropColor(0, 0, 0, 0)
	glow:SetBackdropBorderColor(0, 0, 0, 1)

	local scaffold = item:CreateFrame("Frame")
	scaffold:SetFrameLevel(item:GetFrameLevel() + 1)
	scaffold:SetPoint("CENTER", 0, 0)
	scaffold:SetSize(config.body.entry.item.border.size[1], config.body.entry.item.border.size[2])
	scaffold:SetBackdrop({
		bgFile = TEXTURE.BLANK,
		edgeFile = TEXTURE.BLANK,
		edgeSize = 1,
		insets = {
			left = -1,
			right = -1,
			top = -1,
			bottom = -1
		}
	})
	scaffold:SetBackdropColor(0, 0, 0, 1)
	scaffold:SetBackdropBorderColor(C.General.UIBorder[1], C.General.UIBorder[2], C.General.UIBorder[3], 1)

	local newIconTexture = scaffold:CreateTexture()
	newIconTexture:SetDrawLayer("BORDER")
	newIconTexture:SetPoint("CENTER", 0, 0)
	newIconTexture:SetSize(config.body.entry.item.icon.size[1], config.body.entry.item.icon.size[2])

	local newCooldown = item:CreateFrame("Cooldown", nil, "CooldownFrameTemplate") -- All fails without the template
	newCooldown:SetFrameLevel(item:GetFrameLevel() + 2)
	newCooldown:Hide()
	newCooldown:SetAllPoints(newIconTexture)

	if ENGINE_WOD then
		newCooldown:SetSwipeColor(0, 0, 0, .75)
		newCooldown:SetBlingTexture(TEXTURE.BLING, .3, .6, 1, .75) -- what wow uses, only with slightly lower alpha
		newCooldown:SetEdgeTexture(TEXTURE.EDGE_NORMAL)
		newCooldown:SetDrawSwipe(true)
		newCooldown:SetDrawBling(true)
		newCooldown:SetDrawEdge(false)
		newCooldown:SetHideCountdownNumbers(false) -- todo: add better numbering
	end

	local overlay = item:CreateFrame("Frame")
	overlay:SetFrameLevel(item:GetFrameLevel() + 3)
	overlay:SetAllPoints(scaffold)

	local newIconDarken = overlay:CreateTexture()
	newIconDarken:SetDrawLayer("ARTWORK")
	newIconDarken:SetAllPoints(newIconTexture)
	newIconDarken:SetColorTexture(0, 0, 0, .15)

	local newIconShade = overlay:CreateTexture()
	newIconShade:SetDrawLayer("OVERLAY")
	newIconShade:SetAllPoints(newIconTexture)
	newIconShade:SetTexture(config.body.entry.item.shade)
	newIconShade:SetVertexColor(0, 0, 0, 1)

	item.SetItemCooldown = ENGINE_WOD and function(self, start, duration, enable)
		newCooldown:SetSwipeColor(0, 0, 0, .75)
		newCooldown:SetDrawEdge(false)
		newCooldown:SetDrawBling(false)
		newCooldown:SetDrawSwipe(true)

		if duration > .5 then
			newCooldown:SetCooldown(start, duration)
			newCooldown:Show()
		else
			newCooldown:Hide()
		end

	end or function(self, start, duration, enable)
		-- Try to prevent the strange WotLK bug where the end shine effect
		-- constantly pops up for a random period of time. 
		if duration > .5 then
			newCooldown:SetCooldown(start, duration)
			newCooldown:Show()
		else
			newCooldown:Hide()
		end
	end
	
	item.SetItemTexture = function(self, ...)
		newIconTexture:SetTexture(...)
	end

	itemButtons[num] = item

	return item
end

-- Updates an objective, and adds new ones as needed
Entry.SetObjective = function(self, objectiveID)
	local objectives = self.objectives
	local objective = objectives[objectiveID] or self:AddObjective()
	local currentQuestData = questData[self.questID] 
	local currentQuestObjectives = currentQuestData.questObjectives[objectiveID]

	-- We're not currently using progress bars, 
	-- so objectives that are bars are displayed as a percentage only. 
	-- Also note that item count and percentages are displayed in forced green after the text, 
	-- and hidden from view when their value is at 0 and the player hasn't started progressing yet.
	local description
	if currentQuestObjectives.item then
		local current = tonumber(currentQuestObjectives.numCurrent) or 0
		if (current == 0) then
			description = currentQuestObjectives.item
		else
			if currentQuestObjectives.objectiveType == "progressbar" then
				description = currentQuestObjectives.item .. " |cff66aa22" .. currentQuestObjectives.numCurrent .. "%|r"
			else
				description = currentQuestObjectives.item .. " |cff66aa22" .. currentQuestObjectives.numCurrent .. "/" .. currentQuestObjectives.numNeeded .. "|r"
			end
		end
	else
		description = currentQuestObjectives.description
	end

	objective:SetHeight(setTextAndGetSize(objective.msg, description, objectives.standardWidth, objectives.standardHeight))
	objective:Show()

	-- Update the pointer in case it's a new objective, 
	-- or the order got changed(?) (gotta revisit this)
	objectives[objectiveID] = objective

	return objective
end

-- Clears an objective
Entry.ClearObjective = function(self, objectiveID)
	local objective = self.objectives[objectiveID]
	if (not objective) then
		return
	end
	objective.msg:SetText("")
	objective:ClearAllPoints()
	objective:Hide()
end

-- Clears all displayed objectives
Entry.ClearObjectives = function(self)
	for objectiveID in pairs(self.objectives) do
		-- We're keeping the layout info in this table also, 
		-- so we need to make sure we're only dealing with numbered entries.
		if (type(objectiveID) == "number") then
			self:ClearObjective(objectiveID)
		end
	end
end

-- Sets the questID of the current tracker entry
Entry.SetQuest = function(self, questLogIndex, questID)
	local entryHeight = 0.0001

	-- Set the IDs of this entry, and thus tell the tracker it's in use
	self.questID = questID
	self.questLogIndex = questLogIndex

	-- Grab the data about the current quest
	local currentQuestData = questData[questID]

	-- Shortcuts to our own elements
	local title = self.title
	local titleText = self.title.msg
	local body = self.body
	local completionText = self.completionText

	-- Set and size the title
	-- We add a blue or purple plus sign for elite world quests, 
	-- to indicate their difficulty in a non-intrusive manner.
	local titleMessage 
	if currentQuestData.isElite and currentQuestData.rarity and C.WorldQuestRarity[currentQuestData.rarity] then
		titleMessage = currentQuestData.questTitle .. " " .. C.WorldQuestRarity[currentQuestData.rarity].colorCode .. "+" .. "|r"
	else
		titleMessage = currentQuestData.questTitle
	end
	local titleHeight = setTextAndGetSize(titleText, titleMessage, title:GetWidth(), title.standardHeight)
	title:SetHeight(titleHeight) 

	entryHeight = entryHeight + titleHeight

	-- Tone down completed entries
	self:SetAlpha((currentQuestData.isComplete and currentQuestData.numQuestObjectives > 0) and .5 or 1)
	--self:SetAlpha(currentQuestData.isComplete and .5 or 1)

	-- Update objective descriptions and completion text
	if currentQuestData.isComplete then
		-- Clear away all objectives to avoid overlapping texts
		self:ClearObjectives()

		local height
		if currentQuestData.isAutoComplete then 
			-- Change quest description to the 
			local completeMsg = (currentQuestData.completionText and currentQuestData.completionText ~= "") and currentQuestData.completionText or BLIZZ_LOCALE.QUEST_WATCH_CLICK_TO_COMPLETE
			height = setTextAndGetSize(completionText, completeMsg, completionText.standardWidth, completionText.standardHeight)
			completionText:SetHeight(height)
			completionText.dot:Show()
		else 
			-- Change quest description to the completion text
			local completeMsg = (currentQuestData.completionText and currentQuestData.completionText ~= "") and currentQuestData.completionText or BLIZZ_LOCALE.QUEST_COMPLETE
			height = setTextAndGetSize(completionText, completeMsg, completionText.standardWidth, completionText.standardHeight)
			completionText:SetHeight(height)
			completionText.dot:Show()
		end 


		entryHeight = entryHeight + completionText.topOffset + height + completionText.bottomMargin

	else
		-- Just make sure the completion text is hidden
		completionText:SetText("")
		completionText:SetSize(completionText.standardWidth, completionText.standardHeight)
		completionText.dot:Hide()

		-- Update the current or remaining quest objectives
		local objectives = self.objectives
		local objectiveOffset = objectives.topOffset
		local currentQuestObjectives = currentQuestData.questObjectives

		local visibleObjectives = 0
		local numObjectives = #currentQuestObjectives

		if numObjectives > 0 then
			local currentObjectiveID = 0
			for objectiveID = 1, numObjectives  do

				-- Use a manual counter to avoid skipping objectiveIDs
				currentObjectiveID = currentObjectiveID + 1

				-- Only display unfinished quest objectives
				if (currentQuestObjectives[currentObjectiveID].isCompleted) then
					self:ClearObjective(currentObjectiveID)
				else
					visibleObjectives = visibleObjectives + 1

					-- We're using the table index to indicate objectiveID, 
					-- but this will in some cases leave us with empty indices
					-- if a quest had completed objectives at logon or reload. 
					-- This will prevent us from using normal ipairs iteration.
					local objective = self:SetObjective(currentObjectiveID)
					local height = objective:GetHeight()

					if visibleObjectives > 1 then
						objectiveOffset = objectiveOffset + objectives.topMargin
						entryHeight = entryHeight + objectives.topMargin
					end

					-- Since the order and visibility of the objectives 
					-- change based on the visible ones, we need to reset
					-- all the points here, or the objective will "disappear".
					objective:ClearAllPoints()
					objective:Point("TOP", self.title, "BOTTOM", 0, -objectiveOffset)
					objective:Point("LEFT", self, "LEFT", 0, 0)

					objectiveOffset = objectiveOffset + height
					entryHeight = entryHeight + height
				end
			end
			
			-- Only add the bottom padding if there 
			-- actually was any unfinished objectives to show. 
			if visibleObjectives > 0 then
				entryHeight = entryHeight + objectives.bottomMargin
			end
		end

		-- A lot of quests in especially in the Cata (and higher) starting zones are 
		-- of the "go to some NPC"-type, has no objectives, and are finished the instant they start.
		-- For some reason though they still get counted as not finished in my tracker,
		-- so we simply squeeze in a slightly more descriptive text here. 
		if visibleObjectives == 0 then

			-- Change quest description to the completion text
			local completeMsg = (currentQuestData.completionText and currentQuestData.completionText ~= "") and currentQuestData.completionText or BLIZZ_LOCALE.QUEST_COMPLETE
			local height = setTextAndGetSize(completionText, completeMsg, completionText.standardWidth, completionText.standardHeight)
			completionText:SetHeight(height)
			completionText.dot:Show()

			entryHeight = entryHeight + completionText.topOffset + height + completionText.bottomMargin
		end

		-- Clear finished objectives (or remnants from previously tracked quests)
		for objectiveID in pairs(objectives) do
			-- We're keeping the layout info in this table also, 
			-- so we need to make sure we're only dealing with numbered entries.
			if (type(objectiveID) == "number") and (objectiveID > numObjectives) then
				self:ClearObjective(objectiveID)
			end
		end
	end

	self:SetHeight(entryHeight)

end

-- Sets which quest item to display along with the quest entry
-- *Todo: add support for equipped items too! 
Entry.SetQuestItem = function(self, questID)
	local questLogIndex

	-- Get the correct ID
	questID = questID or self.questID

	-- This is needed to get the correct log index, 
	-- or the item won't function properly until a /reload! 
	if ENGINE_CATA then
		questLogIndex = GetQuestLogIndexByID(questID)
	else
		questLogIndex = questLogCache[questID]
	end

	-- Clear the item (if any) and return
 	if (not questLogIndex) then
		return self:ClearQuestItem()
	end

	-- Retrieve or add an item, and set it to the correct log index.
	local item = self.questItem or self:AddQuestItem()
	item:SetID(questLogIndex)
	item:ClearAllPoints()
	item:Point("TOP", self, "TOP", 0, -4)
	item:Place("RIGHT", self, "LEFT", -20, 0)
	item:SetItemTexture(questData[questID].icon)
	item:UpdateItemCooldown()
	item:Show()

	-- Store the reference
	self.questItem = item

	activeItemButtons[item] = self

	return questItem
end

Entry.UpdateQuestItem = function(self, questID)
	local questLogIndex

	-- Get the correct ID
	questID = questID or self.questID

	-- This is needed to get the correct log index, 
	-- or the item won't function properly until a /reload! 
	if ENGINE_CATA then
		questLogIndex = GetQuestLogIndexByID(questID) 
	else
		questLogIndex = questLogCache[questID]
	end

	if (questLogIndex) then
		local item = self.questItem
		if item then 
			item:SetID(questLogIndex)
			item:SetItemTexture(questData[questID].icon)
			item:UpdateItemCooldown()
			item:Show()
		end
	else
		return self:ClearQuestItem()
	end
end

-- Removes any item currently connected with the entry's current quest.
Entry.ClearQuestItem = function(self)
	local item = self.questItem
	if item then
		item:Hide()
		activeItemButtons[item] = nil
	end
end

-- Returns the questID of the entry's current quest, or nil if none.
Entry.GetQuestID = function(self)
	return self.questID
end

-- Clear the entry
Entry.Clear = function(self)
	self.questID = nil
	self.questLogIndex = nil

	-- Clear the messages 
	self.title.msg:SetText("")
	self.completionText:SetText("")

	-- Clear the quest item, if any
	self:ClearQuestItem()

	-- Clear away all objectives
	self:ClearObjectives()	
end



-- Tracker Template
-----------------------------------------------------
local Tracker = Engine:CreateFrame("Frame")
Tracker_MT = { __index = Tracker }

Tracker.AddEntry = function(self)
	local config = self.config

	local width = math_floor(self:GetWidth() + .5) 

	local entry = setmetatable(self.body:CreateFrame("Frame"), Entry_MT)
	entry:Hide()
	entry:SetHeight(0.0001)
	entry:SetWidth(width)
	entry.config = config
	entry.topMargin = config.body.entry.topMargin
	
	-- Title region
	-----------------------------------------------------------
	local title = setmetatable(entry:CreateFrame("Button"), Title_MT)
	title:ClearAllPoints()
	title:Point("TOP", entry, "TOP", 0, 0)
	title:Point("LEFT", entry, "LEFT", 0, 0)
	title:SetWidth(width)
	title:SetHeight(config.body.entry.title.height)
	title.standardHeight = config.body.entry.title.height
	title.maxLines = config.body.entry.title.maxLines -- not currently used
	title.leftMargin = config.body.entry.title.leftMargin
	title.rightMargin = config.body.entry.title.rightMargin

	title._owner = entry
	title:EnableMouse(true)
	title:SetHitRectInsets(-10, -10, -10, -10)
	title:RegisterForClicks("AnyUp")
	title:SetScript("OnClick", Title.OnClick)

	-- Quest title
	local titleText = title:CreateFontString()
	titleText:SetHeight(title.standardHeight)
	titleText:SetWidth(width)
	titleText:ClearAllPoints()
	titleText:Point("TOP", title, "TOP", 0, 0)
	titleText:Point("LEFT", entry, "LEFT", 0, 0)
	titleText:SetDrawLayer("BACKGROUND")
	titleText:SetJustifyH("LEFT")
	titleText:SetJustifyV("TOP")
	titleText:SetIndentedWordWrap(false)
	titleText:SetWordWrap(true)
	titleText:SetNonSpaceWrap(false)
	titleText:SetFontObject(config.body.entry.title.normalFont)
	titleText:SetSpacing(config.body.entry.title.lineSpacing)

	title.msg = titleText

	-- Flash messages like "NEW", "UPDATE", "COMPLETED" and so on
	local flashMessage = title:CreateFontString()
	flashMessage:SetDrawLayer("BACKGROUND")
	flashMessage:SetPoint("RIGHT", title, "LEFT", 0, -10)


	-- Body region
	-----------------------------------------------------------
	local body = entry:CreateFrame("Frame")
	body:SetWidth(width)
	body:SetHeight(.0001)
	body:ClearAllPoints()
	body:Point("TOP", title, "BOTTOM", 0, config.body.margins.top)
	body:Point("LEFT", entry, "LEFT", config.body.margins.left, 0)

	-- Quest complete text
	local completionText = body:CreateFontString()
	completionText.topOffset = config.body.entry.complete.topOffset
	completionText.leftMargin = config.body.entry.complete.leftMargin
	completionText.rightMargin = config.body.entry.complete.rightMargin
	completionText.topMargin = config.body.entry.complete.topMargin
	completionText.bottomMargin = config.body.entry.complete.bottomMargin
	completionText.lineSpacing = config.body.entry.complete.lineSpacing
	completionText.standardHeight = config.body.entry.complete.height
	completionText.standardWidth = width - completionText.leftMargin - completionText.rightMargin
	completionText.maxLines = config.body.entry.complete.maxLines -- not currently used
	completionText.dotAdjust = config.body.entry.complete.dotAdjust

	completionText:SetFontObject(config.body.entry.complete.normalFont)
	completionText:SetSpacing(completionText.lineSpacing)
	completionText:SetWidth(width)
	completionText:SetHeight(completionText.standardHeight)

	completionText:ClearAllPoints()
	--completionText:Place("TOPLEFT", title, "BOTTOMLEFT", completionText.leftMargin, -completionText.topOffset)
	completionText:Point("TOP", title, "BOTTOM", 0, -completionText.topOffset)
	completionText:Point("LEFT", entry, "LEFT", completionText.leftMargin, 0)
	completionText:SetDrawLayer("BACKGROUND")
	completionText:SetJustifyH("LEFT")
	completionText:SetJustifyV("TOP")
	completionText:SetIndentedWordWrap(false)
	completionText:SetWordWrap(true)
	completionText:SetNonSpaceWrap(false)

	completionText.dot = createDot(body)
	completionText.dot:ClearAllPoints()
	completionText.dot:Point("TOP", completionText, "TOPLEFT", -math_floor(completionText.leftMargin/2), completionText.dotAdjust)
	completionText.dot:Hide()

	-- Cache of the current quest objectives
	local objectives = {
		standardHeight = config.body.entry.objective.height,
		standardWidth = width - config.body.entry.objective.leftMargin - config.body.entry.objective.rightMargin,
		topOffset = config.body.entry.objective.topOffset,
		leftMargin = config.body.entry.objective.leftMargin,
		rightMargin = config.body.entry.objective.rightMargin,
		topMargin = config.body.entry.objective.topMargin,
		bottomMargin = config.body.entry.objective.bottomMargin,
		lineSpacing = config.body.entry.objective.lineSpacing,
		normalFont = config.body.entry.objective.normalFont,
		dotAdjust = config.body.entry.objective.dotAdjust
	} 

	entry.body = body
	entry.completionText = completionText
	entry.flash = flashMessage
	entry.objectives = objectives
	entry.title = title

	return entry
end

Tracker.Clear = function(self, firstEntry, lastEntry)
	if firstEntry then
		for entryID = firstEntry, (lastEntry or firstEntry) do
			local entry = self.entries[entryID]
			if entry then
				entry:Hide()
				entry:Clear()
				entry:ClearAllPoints()
			end
		end
	else
		local numEntries = #self.entries
		if (numEntries > 0) then
			for entryID = 1, numEntries do
				local entry = self.entries[entryID]
				if entry then
					entry:Hide()
					entry:Clear()
					entry:ClearAllPoints()
				end
			end
		end
	end
end

Tracker.NumVisibleEntries = function(self)
	local numEntries = 0
	for i = 1, #self.entries do
		local entry = self.entries[i]
		if entry and entry:IsShown() then
			numEntries = numEntries +1
		end
	end
	return numEntries
end

Tracker.GetCurrentMapAreaID = function(self)
	local questMapID = GetCurrentMapAreaID()
	if (not ENGINE_CATA) then
		if questMapID > 0 then
			questMapID = questMapID - 1 -- WotLK bug
		end
	end
	return proxyZones[questMapID] or questMapID, isContinent
end

-- Full tracker update.
Tracker.Update = function(self)
	local entries = self.entries
	local maxTrackerHeight = self:GetHeight()
	local currentTrackerHeight = self.header:GetHeight() + 4

	-- Supertrack if we have a valid quest to track
	if ENGINE_CATA then
		local superTrackID
		local numQuests = #sortedTrackedQuests
		if (numQuests > 0) then
			for i = 1, numQuests do
				local currentQuestData = sortedTrackedQuests[i]
				if currentQuestData and (not currentQuestData.isEmissaryQuest) then
					superTrackID = currentQuestData.questID
					break
				end
			end
		end
		SetSuperTrackedQuestID(superTrackID or 0)
	end
	
	self.oldZone = self.currentZone -- What zone was prevously shown?
	self.oldNumVisibleEntries = self.numVisibleEntries -- How many visible entries did we have?
	
	self.currentZone = self:GetCurrentMapAreaID() -- Store the current zone
	self.numVisibleEntries = self:NumVisibleEntries() -- store the number of currently visible entries

	-- Clear everything and return if nothing is tracked in the zone
	local numZoneQuests = #sortedTrackedQuests
	if (numZoneQuests == 0) then
		self:Clear()
		return
	end 

	if (not self.displayCache) then

		-- If this is the first time calling this, 
		-- we simply create the cache, and continue.  
		self.displayCache = {}

	else

		-- Grab our local display cache
		local displayCache = self.displayCache
	
		-- Figure out if all the previous quests are still here, 
		-- if this call is in the same zone as the previous call
		if (self.currentZone == self.oldZone) and (self.numVisibleEntries == self.oldNumVisibleEntries) then 
			local needUpdate
			if (#self.displayCache == numZoneQuests) then
				for i = 1,numZoneQuests do

					-- Tracked quests, their proximity or their objectives have changed
					local currentQuestData = sortedTrackedQuests[i]
					if (self.displayCache[i] ~= currentQuestData) or (currentQuestData.updateDescription) then
						needUpdate = true
						break
					end
				end

				if (not needUpdate) then
					return 
				end
			end
		end
	end

	-- Make a copy of the tracker display list
	local displayCache = table_wipe(self.displayCache)
	for i,v in pairs(sortedTrackedQuests) do
		self.displayCache[i] = v
	end


	-- Update existing and create new entries
	local anchor = self.header -- current anchor
	local offset = 0 -- current vertical offset from the top of the tracker
	local entryID = 0 -- current entry in the tracker
	local allComplete = true -- true until proven false while parsing

	for i = 1, numZoneQuests do

		local currentQuestData = sortedTrackedQuests[i]
		if currentQuestData then

			-- If the quest is incomplete, our all-true check fails.
			if (not currentQuestData.isComplete) then
				allComplete = false
			end

			-- Increase the entry counter
			entryID = entryID + 1

			-- Get the entry or create one
			local entry = entries[entryID]
			if (not entry) then
				-- Update entry pointers for new entries
				entries[entryID] = self:AddEntry()
				entry = entries[entryID]
			end

			-- Set the entry's quest
			entry:SetQuest(currentQuestData.questLogIndex, currentQuestData.questID)

			-- Store the current entryID of the quest 
			trackedQuestsByQuestID[currentQuestData.questID] = i
			
			-- Set the entry's usable item, if any
			if currentQuestData.hasQuestItem and ((not currentQuestData.isComplete) or currentQuestData.showItemWhenComplete) then
				entry:SetQuestItem(currentQuestData.questID)
			else
				entry:ClearQuestItem()
			end

			-- Don't show more entries than there's room for,
			-- forcefully quit and hide the rest when it would overflow.
			-- Will add a better system later.
			local entrySize = entry.topMargin + entry:GetHeight()
			if ((currentTrackerHeight + entrySize) > maxTrackerHeight) then
				numZoneQuests = i - 1
				entryID = entryID - 1 
				break
			else
				-- Add the top margin to the offset
				offset = offset + entry.topMargin

				-- Position the entry
				entry:ClearAllPoints()
				--entry:Place("TOPLEFT", anchor, "BOTTOMLEFT", 0, -offset)
				entry:Point("TOP", anchor, "BOTTOM", 0, -offset)
				entry:Point("LEFT", self, "LEFT", 0, 0)
				entry:Show()

				-- Add the entry's size to the offset
				offset = offset + entry:GetHeight()

				-- Add the full size of the entry with its margin to the tracker height 
				currentTrackerHeight = currentTrackerHeight + entrySize
			end

		end
	end

	-- Do an alpha adjustment sweep for situations when ALL quests are completed, 
	-- and the completed ones no longer needs to be toned down. 
	if allComplete then
		for i = 1, entryID do
			local entry = entries[i]
			if entry then
				entry:SetAlpha(1)
			end
		end
	end

	-- Hide unused entries 
	-- *not working as intended
	self:Clear(entryID + 1, #entries)

	-- Store the number of visible entries after parsing, 
	-- as this can vary from what is visible going into the update.
	self.numVisibleEntries = self:NumVisibleEntries()

end

Item.UpdateItemCooldown = function(self)
	local id = self:GetID()
	if (not id) then
		return self:SetItemCooldown(0, 0, false)
	end 
	local start, duration, enable = GetQuestLogSpecialItemCooldown(id)
	if start and enable and (duration and (duration > 0)) then
		self:SetItemCooldown(start, duration, enable)
	else
		self:SetItemCooldown(0, 0, false)
	end
end

Module.UpdateItemCooldowns = function(self)
	for item,entry in pairs(activeItemButtons) do
		item:UpdateItemCooldown()
	end
end

Module.UpdateItemButtons = function(self)
	for item,entry in pairs(activeItemButtons) do
		entry:UpdateQuestItem()
	end
end

local allQuestTimers = {}
local activeQuestTimers = {}
local finishedQuestTimers = {}

Module.ParseTimers = function(self, ...)
	local numTimers = select("#", ...)
	for timerId = 1, numTimers do
		local questLogIndex = GetQuestIndexForTimer(timerId)

		local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID
		if ENGINE_WOD then
			questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(questLogIndex)
		else
			questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(questLogIndex)
		end

		local timeFirst = select(timerId, ...)
		activeQuestTimers[questID] = timeFirst

	end
end

-- Fairly big copout here, and we need to expand 
-- on it later to avoid overriding user choices. 
-- Based on self:QuestSuperTracking_ChooseClosestQuest()
Module.UpdateSuperTracking = function(self)
	local closestQuestID, closestFinishedQuestID
	local minDistSqr = math_huge
	local minDistSqrFinished = minDistSqr

	-- World quest watches got introduced in Legion
	-- 
	-- Update 2017-07-06:
	-- This appears to be tracking "hidden" bonus objectives too, not just world quests. 
	-- This leads to the wrong objective getting its arrow on the Minimap, 
	-- pointing the player to a different objective than what the tracker shows. 
	-- 
	if ENGINE_LEGION then
		local closestQuest
		for i = 1, GetNumWorldQuestWatches() do
			local watchedWorldQuestID = GetWorldQuestWatchInfo(i)
			if watchedWorldQuestID then
				local currentQuestData = questData[watchedWorldQuestID]
				if (currentQuestData and (not currentQuestData.isComplete)) then
					local distanceSq = C_TaskQuest.GetDistanceSqToQuest(watchedWorldQuestID)
					if (distanceSq and (distanceSq <= minDistSqr)) then
						minDistSqr = distanceSq
						closestQuestID = watchedWorldQuestID
					end
				end
			end
		end
	end

	if ENGINE_WOD then
		if (not closestQuestID) then
			for i = 1, GetNumQuestWatches() do
				local questID, title, questLogIndex = GetQuestWatchInfo(i)
				if ( questID and QuestHasPOIInfo(questID) ) then
					local distSqr, onContinent = GetDistanceSqToQuest(questLogIndex)
					if (onContinent and distSqr <= minDistSqr) then
						minDistSqr = distSqr
						closestQuestID = questID
					end
				end
			end
		end
	end

	-- If nothing with POI data is being tracked expand search to quest log
	if (not closestQuestID) then
		for questLogIndex = 1, GetNumQuestLogEntries() do
			local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(questLogIndex)
			if (not isHeader and QuestHasPOIInfo(questID)) then
				local distSqr, onContinent = GetDistanceSqToQuest(questLogIndex)
				if (onContinent and distSqr <= minDistSqr) then
					minDistSqr = distSqr
					closestQuestID = questID
				end
			end
		end
	end

	-- Supertrack if we have a valid quest
	if closestQuestID then
		SetSuperTrackedQuestID(closestQuestID)
	else
		SetSuperTrackedQuestID(0)
	end
end

Module.ParseAutoQuests = function(self)
	if (not ENGINE_CATA) then 
		return 
	end
	for i = 1, GetNumAutoQuestPopUps() do
		local questID, popUpType = GetAutoQuestPopUp(i)
		if (questId == questID) then
			if (popUpType == "OFFER") then
				ShowQuestOffer(questLogIndex)

			else
				PlaySoundKitID(SOUNDKIT.UI_AUTO_QUEST_COMPLETE, "SFX")
				ShowQuestComplete(questLogIndex)
			end
		end
	end
end

-- All the isSomething entries will return strict true/false values here
-- @return questID, questTitle, questLevel, suggestedGroup, isHeader, isComplete, isFailed, isRepeatable
Module.GetQuestLogTitle = ENGINE_WOD and function(self, questLogIndex)
	local questTitle, questLevel, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(questLogIndex)
	return questID, questTitle, questLevel, suggestedGroup, isHeader, (isComplete == 1), (isComplete == -1), (frequency > 1)

end or function(self, questLogIndex)
	local questTitle, questLevel, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(questLogIndex)
	return questID, questTitle, questLevel, suggestedGroup, (isHeader == 1), (isComplete == 1), (isComplete == -1), (isDaily == 1)
end

Module.GetQuestLogLeaderBoard = function(self, objectiveIndex, questLogIndex)
	local description, objectiveType, isCompleted = GetQuestLogLeaderBoard(objectiveIndex, questLogIndex)
	if (not description) then 
		return -- can happen with certain dailies like the brewfast barking quests
	end
	local item, numCurrent, numNeeded = string_match(description, questCaptures[objectiveType]) 

	if (objectiveType == "progressbar") then
		item = description
		numCurrent = GetQuestProgressBarPercent((self:GetQuestLogTitle(questLogIndex)))
		numNeeded = 100
	end

	-- Some quests have objective type 'monster' yet are displayed using the ITEMS formatting.
	-- Thank you Zygor for figuring this one out. 
	if (objectiveType == "monster") and (not item) then
		item, numCurrent, numNeeded = string_match(description, questCaptures.item)
	end

	if tonumber(item) then
		local newItem = string_gsub(description, questCaptures.item, "")
		local newCurrent, newNeeded = item, numCurrent
		item, numCurrent, numNeeded = newItem, newCurrent, newNeeded
	end

	if item then
		if (objectiveType == "reputation") or (objectiveType == "faction") then
			-- We're keeping these as strings, as they most often are. (e.g. Friendly/Revered)
			return description, objectiveType, isCompleted, item, numCurrent, numNeeded 
		else
			return description, objectiveType, isCompleted, item, tonumber(numCurrent), tonumber(numNeeded)
		end
	else
		return description, objectiveType, isCompleted
	end

end

Module.GetQuestObjectiveInfo = function(self, questID, objectiveIndex)
	local description, objectiveType, isCompleted = GetQuestObjectiveInfo(questID, objectiveIndex, false)

	-- Sometimes we get empty objectives in world quests, no idea why. 
	-- Returning early since without the description there's nothing else to parse.
	if (not description) then
		return description, objectiveType, isCompleted
	end

	local item, numCurrent, numNeeded = string_match(description, questCaptures[objectiveType])

	if (objectiveType == "progressbar") then
		item = description
		numCurrent = GetQuestProgressBarPercent(questID)
		numNeeded = 100
	else
		if (objectiveType == "monster") and (not item) then
			item, numCurrent, numNeeded = string_match(description, questCaptures.item)
		end
	end

	if tonumber(item) then
		local newItem = string_gsub(description, questCaptures.item, "")
		local newCurrent, newNeeded = item, numCurrent
		item, numCurrent, numNeeded = newItem, newCurrent, newNeeded
	end
	
	if item then
		if (objectiveType == "reputation") or (objectiveType == "faction") then
			-- We're keeping these as strings, as they most often are. (e.g. Friendly/Revered)
			return string_gsub(description, "[.]$", ""), objectiveType, isCompleted, string_gsub(item, "[.]$", ""), numCurrent, numNeeded 
		else
			return string_gsub(description, "[.]$", ""), objectiveType, isCompleted, string_gsub(item, "[.]$", ""), tonumber(numCurrent), tonumber(numNeeded)
		end
	else
		return string_gsub(description, "[.]$", ""), objectiveType, isCompleted
	end
end

Module.GetCurrentMapAreaID = function(self)
	local questMapID, isContinent = GetCurrentMapAreaID()
	if questMapID and (questMapID > 0) then
		if (not ENGINE_CATA) then
			if (questMapID > 0) then
				questMapID = questMapID - 1 -- WotLK bug
			end
		end
		return proxyZones[questMapID] or questMapID, isContinent
	end
end

-- Triggers WORLD_MAP_UPDATE QUEST_LOG_UPDATE
Module.GetQuestWorldMapAreaID = function(self, questID)
	local questMapID = GetQuestWorldMapAreaID(questID) -- Triggers SetMapToCurrentZone() 
	if questMapID and (questMapID > 0) then
		return proxyZones[questMapID] or questMapID
	end
end

-- This updates both the Blizzard POI map tracking 
-- as well as what our own tracker should show.
Module.UpdateTrackerWatches = function(self)
	-- This step is crucial to make sure completed or removed quests
	-- are also removed from our own tracker(s). 
	-- This was what was causing the world quest update to fail. 
	for questID in pairs(allTrackedQuests) do
		if (not questLogCache[questID]) or (not worldQuestCache[questID]) then
			allTrackedQuests[questID] = nil
			zoneTrackedQuests[questID] = nil -- true -- why was this true?
		end
	end

	for questID, questLogIndex in pairs(questLogCache) do
		if questWatchQueue[questID] then

			-- Tell our own systems about the tracking
			zoneTrackedQuests[questID] = true
			allTrackedQuests[questID] = true

			-- Tell the Blizzard POI system about it
			-- TODO: I should figure out some way to decide what quests to track 
			-- when the amount of quests we wish to track excede the blizzard limit.
			if (not IsQuestWatched(questLogIndex)) then
				AddQuestWatch(questLogIndex)
			end
		else
			-- Remove the Blizzard quest watch 
			if IsQuestWatched(questLogIndex) then
				RemoveQuestWatch(questLogIndex)
			end
		end
	end

	if ENGINE_LEGION then
		local currentZone = CURRENT_MAP_ZONE or CURRENT_PLAYER_ZONE
		for questID in pairs(worldQuestCache) do
			if worldQuestWatchQueue[questID] then
				local currentQuestData = questData[questID]
				local questMapID = currentQuestData.questMapID
				if proxyZones[questMapID] then
					questMapID = proxyZones[questMapID]
				end 
				allTrackedQuests[questID] = (questMapID and (questMapID == currentZone)) 
					and (currentQuestData.isWorldQuest and (not currentQuestData.isComplete) and self:DoesWorldQuestPassFilters(questID))
					or nil
			end
		end

		for i = 1, GetNumQuestWatches() do
			local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isBounty, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)

			-- Need to add in this to allow for clicking the quest to complete it.
			if allTrackedQuests[questID] then 
				local currentQuestData = questData[questID]
				currentQuestData.isAutoComplete = isAutoComplete
			end 
		end 

	end

	-- Wipe the table, it's only a bunch of references anyway
	table_wipe(sortedTrackedQuests)

	local numAllTracked = 0

	-- Insert all the tracked quests
	for questID in pairs(allTrackedQuests) do
		numAllTracked = numAllTracked + 1
		sortedTrackedQuests[#sortedTrackedQuests + 1] = questData[questID]
	end

	-- Sort it to something more readable
	if (#sortedTrackedQuests > 1) then
		--table_sort(sortedTrackedQuests, sortFunction)
		table_sort(sortedTrackedQuests, sortFunctionWQLast)
	end

	self.tracker:Update()

	local isInInstance, instanceType = IsInInstance()
	if isInInstance and (instanceType == "pvp" or instanceType == "arena") then
		return self.tracker:Hide()
	end

	if (#sortedTrackedQuests > 0) then
		return self.tracker:Show()
	else
		return self.tracker:Hide()
	end

end

-- This will forcefully set the map zone to the current, 
-- to retrieve zone information about existing quest log entries.
-- This should only be called upon entering the world, or changing zones,
-- or we run the risk of "locking" the world map to the current zone.
Module.GatherQuestZoneData = function(self)
	local questData = questData

	-- Enforcing this, regardless of whether or not the 
	-- world map is currently visible. 
	-- This is only called when changing zones or entering the world, 
	-- so it's a compromise we can live with. It doesn't affect gameplay much,
	-- and the blizzard map and tracker actually does the same. 
	if (not ENGINE_BFA) then
		SetMapToCurrentZone() -- Will trigger a WORLD_MAP_UPDATE, then a QUEST_LOG_UPDATE!
		end 

	-- Update what zone the player is actually in
	CURRENT_PLAYER_ZONE = self:GetCurrentMapAreaID()


	-- Parse the quest cache for quests with missing zone data, 
	-- which at the first time this is called should be all of them.
	-- Note that the API call GetQuestWorldMapAreaID also calls SetMapToCurrentZone,
	-- thus also forcing the map to the current zone. 
	for questID, data in pairs(questData) do
		data.questMapID = data.questMapID or self:GetQuestWorldMapAreaID(questID)
	end
end

-- Figure out what quests to display for the current zone. 
-- The "current" zone is the zone the worldmap is set to if open, 
-- or the actual zone the player is in if the worldmap is closed. 
Module.UpdateZoneTracking = function(self)

	-- Store the current map zone
	CURRENT_MAP_ZONE = self:GetCurrentMapAreaID()
	local currentZone = CURRENT_MAP_ZONE or CURRENT_PLAYER_ZONE
	
	-- https://wow.gamepedia.com/API_IsInInstance
	local isInInstance, instanceType = IsInInstance()

	-- Clear this table out, to avoid weird bugs 
	-- with autocompleted entries and whatnot.
	table_wipe(questWatchQueue)

	-- Parse the current questlog cache for quests in the active map zone
	for questID, questLogIndex in pairs(questLogCache) do

		-- Get the quest data for the current questlog entry
		local data = questData[questID]
		if data then 
			-- Figure out if it should be tracked or not
			local shouldBeTracked

			if (not data.isWorldQuest) then 
				-- https://wow.gamepedia.com/API_GetQuestTagInfo
				local dungeonQuest = (QUEST_TAG_DUNGEON_TYPES and data.tagID) and QUEST_TAG_DUNGEON_TYPES[data.tagID]	
				if (isInInstance and dungeonQuest) or ((not isInInstance) and (not dungeonQuest)) then
					shouldBeTracked = ((data.questMapID == currentZone) or (data.isComplete)) 
				end 
			end  

			-- Add it to the questwatch update queue
			questWatchQueue[questID] = shouldBeTracked and questLogIndex
		end
	end

	-- Parse for world quests in the current zone
	if ENGINE_LEGION then
		for questID in pairs(worldQuestCache) do
			-- Get the quest data for the current world quest
			local data = questData[questID]
	
			-- Figure out if it should be tracked or not
			worldQuestWatchQueue[questID] = (data and (data.questMapID == currentZone) and (data.isWorldQuest)) or false
		end
	end
end

-- Most of the below is a copy of the WorldMap_DoesWorldQuestInfoPassFilters API call from WorldMapFrame.lua
Module.DoesWorldQuestPassFilters = function(self, questID)
	local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(questID)
	if ( worldQuestType == LE.LE_QUEST_TAG_TYPE_PROFESSION ) then
		local prof1, prof2, arch, fish, cook, firstAid = GetProfessions()
		if ((tradeskillLineIndex == prof1) or (tradeskillLineIndex == prof2)) then
			if (not GetCVarBool("primaryProfessionsFilter")) then
				return false
			end
		end
		if ((tradeskillLineIndex == fish) or (tradeskillLineIndex == cook) or (tradeskillLineIndex == firstAid)) then
			if (not GetCVarBool("secondaryProfessionsFilter")) then
				return false
			end
		end
	elseif (worldQuestType == LE_QUEST_TAG_TYPE_PET_BATTLE) then
		if (not GetCVarBool("showTamers")) then
			return false
		end
	else
		local dataLoaded, rewardType = WorldMap_GetWorldQuestRewardType(questID)
		if (not dataLoaded) then
			return false
		end
		local typeMatchesFilters = (GetCVarBool("worldQuestFilterGold") and bit_band(rewardType, WQ.WORLD_QUEST_REWARD_TYPE_FLAG_GOLD) ~= 0) 
			or (GetCVarBool("worldQuestFilterOrderResources") and bit_band(rewardType, WQ.WORLD_QUEST_REWARD_TYPE_FLAG_ORDER_RESOURCES) ~= 0) 
			or (GetCVarBool("worldQuestFilterArtifactPower") and bit_band(rewardType, WQ.WORLD_QUEST_REWARD_TYPE_FLAG_ARTIFACT_POWER) ~= 0) 
			or (GetCVarBool("worldQuestFilterProfessionMaterials") and bit_band(rewardType, WQ.WORLD_QUEST_REWARD_TYPE_FLAG_MATERIALS) ~= 0) 
			or (GetCVarBool("worldQuestFilterEquipment") and bit_band(rewardType, WQ.WORLD_QUEST_REWARD_TYPE_FLAG_EQUIPMENT) ~= 0) 

		-- We always want to show quests that do not fit any of the enumerated reward types.
		if ((rewardType ~= 0) and (not typeMatchesFilters)) then
			return false
		end
	end
	return true
end

-- Parse worldquests and store the data
Module.GatherWorldQuestData = function(self)
	if ENGINE_LEGION and (not HAS_WORLD_QUESTS) then
		HAS_WORLD_QUESTS = IsQuestFlaggedCompleted(WORLD_QUESTS_AVAILABLE_QUEST_ID)
	end
	if (not HAS_WORLD_QUESTS) then
		return
	end

	-- Trying this for a while, to avoid replacing the table.
	if (not isLegionZone[(self:GetCurrentMapAreaID())]) then
		return 
	end

	-- Don't update the cache in combat lockdown, 
	-- as WQs tend to not be there then....?
	--if self.inLockdown then 
	--	return 
	--end

	local oldCache = worldQuestCache
	local newCache = {}

	-- Track number of discovered quests, and number of zones that have them
	-- in an effort to minimize "empty" updates and stop the tracker from "flickering".
	local oldNumWorldQuests = NUM_WORLD_QUESTS
	local oldNumWorldQuestZones = NUM_WORLD_QUEST_ZONES
	local currentNumQuestZones = 0
	local currentNumWorldQuests = 0

	if not ENGINE_BFA then 
		local continentIndex, continentID = GetCurrentMapContinent()
		local continentMaps = { GetMapZones(continentIndex) }

		-- Iterate all known outdoor Legion zones
		for i = 1, #continentMaps, 2 do
		--for i = 1, #brokenIslesZones do
			--local questMapID = brokenIslesZones[i]
			local questMapID = continentMaps[i]

			-- Triggers QUEST_LOG_UPDATE and WORLD_MAP_UPDATE after a 5 sec delay!
			local worldQuests = C_TaskQuest.GetQuestsForPlayerByMapID(continentMaps[i], continentID)

			--local worldQuests = C_TaskQuest.GetQuestsForPlayerByMapID(questMapID) 
			if (worldQuests ~= nil) and (#worldQuests > 0) then

				-- Increase the zone counter since this zone has quests
				currentNumQuestZones = currentNumQuestZones + 1

				for i,questInfo in ipairs(worldQuests) do
					local questID = questInfo.questId
					if (HaveQuestData(questID) and QuestUtils_IsQuestWorldQuest(questID) and (not (IsQuestInvasion and IsQuestInvasion(questID)))) then

						-- Increase the quest counter, since we found quests with available data
						currentNumWorldQuests = currentNumWorldQuests + 1

						-- Add the quest to the current cache
						newCache[questID] = true

						-- Retrieve the existing quest database, if any 
						local currentQuestData = questData[questID] or {}

						local questTitle, factionID, capped = C_TaskQuest.GetQuestInfoByQuestID(questID)
						local factionName = factionID and GetFactionInfoByID(factionID)
						local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(questID)
						local isInArea, isOnMap, numObjectives, taskName, displayAsObjective = GetTaskInfo(questID)

						local numQuestObjectives = questInfo.numObjectives or 0
						local questObjectives = currentQuestData.questObjectives or {}

						local questUpdated, questCompleted
						local numVisibleObjectives = 0
						for objectiveIndex = 1, numQuestObjectives do
							local objectiveText, objectiveType, isCompleted, item, numCurrent, numNeeded = self:GetQuestObjectiveInfo(questID, objectiveIndex)

							if isCompleted then
								if (questCompleted == nil) then
									questCompleted = true
								end
							else
								questCompleted = false
							end
							
							-- Appears to exist some empty objectives in these world quests, no idea why. 
							-- For the sake of simplicity we're doing the same as everybody else and just skip them. Or?
							if (objectiveText and #objectiveText > 0) then
								numVisibleObjectives = numVisibleObjectives + 1
								local questObjective = questObjectives[numVisibleObjectives]
								if questObjective then
									if not((objectiveText == questObjective.description) and (objectiveType == questObjective.objectiveType) and (isCompleted == questObjective.isCompleted) and (item == questObjective.item) and (numCurrent == questObjective.numCurrent) and (numNeeded == questObjective.numNeeded)) then

										-- Something was changed
										questUpdated = BLIZZ_LOCALE.UPDATE
									end

									questObjective.description = objectiveText
									questObjective.objectiveType = objectiveType
									questObjective.isCompleted = isCompleted
									questObjective.item = item
									questObjective.numCurrent = numCurrent
									questObjective.numNeeded = numNeeded

								else
									-- new quest
									questObjective = {
										description = objectiveText,
										objectiveType = objectiveType,
										isCompleted = isCompleted,
										item = item,
										numCurrent = numCurrent, 
										numNeeded = numNeeded
									}
									questUpdated = BLIZZ_LOCALE.NEW
								end
								questObjectives[numVisibleObjectives] = questObjective
							end
						end

						-- Can't really imagine why a quest's number of objectives should 
						-- change after creation, but just in case we wipe away any unneeded entries.
						-- Point is that we're using #questObjectives to determine number of objectives.
						for i = #questObjectives, numVisibleObjectives + 1, -1 do

							-- Got a nil bug here, so for some reason some of these tables don't exist...?..?
							if questObjectives[i] then
								table_wipe(questObjectives[i])
							end
						end

						-- If we're dealing with an update, figure out what kind. New quest? Failed? Completed? Updated objectives?
						currentQuestData.updateDescription = questUpdated

						-- The data most used
						currentQuestData.questID = questID
						currentQuestData.questTitle = questTitle
						currentQuestData.questMapID = (questMapID and (questMapID > 0)) and questMapID or nil

						-- Information about the faction the quest belongs to. 
						-- Eventually I'll add this to the filtering system, 
						-- to reduce the display priority of quests 
						-- whose factions we're already maxed out with. 
						currentQuestData.factionID = factionID
						currentQuestData.factionName = factionName

						currentQuestData.numQuestObjectives = numQuestObjectives
						currentQuestData.questObjectives = questObjectives
						--currentQuestData.questDescription = questDescription -- what to use?

						-- Will be true if we're currently in the quest area and progressing on it
						currentQuestData.inProgress = questInfo.inProgress
						currentQuestData.timeLeft = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
						currentQuestData.isComplete = questCompleted or (not (currentQuestData.timeLeft and currentQuestData.timeLeft > 0))
						currentQuestData.isFailed = false
						currentQuestData.isWorldQuest = true -- obviously true, since we're ONLY checking for world quests here

						-- Figure out what type of world quest we're dealing with
						currentQuestData.isQuestBounty = IsQuestBounty(questID)
						currentQuestData.isQuestTask = IsQuestTask(questID)
						currentQuestData.isInvasion = worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION -- IsQuestInvasion(questID)
						currentQuestData.isDungeon = worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON
						currentQuestData.isRaid = worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID
						currentQuestData.isPvP = worldQuestType == LE.LE_QUEST_TAG_TYPE_PVP
						currentQuestData.isPetBattle = worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE
						currentQuestData.isTradeSkill = worldQuestType == LE.LE_QUEST_TAG_TYPE_PROFESSION
						currentQuestData.isElite = isElite
						currentQuestData.rarity = rarity 
						currentQuestData.tagID = tagID

						-- Store coordinates if any
						-- Will be used to figure out the closest world quest to track (maybe)
						currentQuestData.x = questInfo.x
						currentQuestData.y = questInfo.y

						-- Just some debugging because my proximity calculations seem to fail
						--currentQuestData.questTitle = currentQuestData.questTitle .. ( "[%.2f,%.2f]"):format(currentQuestData.x, currentQuestData.y)

						-- update pointer in case it was a newly added quest
						questData[questID] = currentQuestData
					end
				end
			end

		end
	end 

	NUM_WORLD_QUEST_ZONES = currentNumQuestZones
	NUM_WORLD_QUESTS = currentNumWorldQuests

	-- Point the questlog cache to our new table
	worldQuestCache = newCache
end

-- Parse the questlog and store its data
-- Returns true if anything changed since last parsing
Module.GatherQuestLogData = function(self, forced)

	local playerMoney = GetMoney()
	local numEntries, numQuests = GetNumQuestLogEntries() 

	local questData = questData
	local oldCache = questLogCache
	local newCache = {} 

	local needUpdate -- we set this to true if something has changed
	local questHeader -- name of the current questlog- or zone header

	-- Store the user/wow selected quest in the questlog
	local selection = GetQuestLogSelection()

	-- Profession name info
	local prof1, prof2, archaeology, fishing, cooking, firstAid
	local profName1, profName2, archaeologyName, fishingName, cookingName, firstAidName
	if (GetProfessions and GetProfessionInfo) then
		prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
		profName1 = prof1 and GetProfessionInfo(prof1)
		profName2 = prof2 and GetProfessionInfo(prof2)
		archaeology = archaeology and GetProfessionInfo(archaeology)
		fishingName = fishing and GetProfessionInfo(fishing)
		cookingName = cooking and GetProfessionInfo(cooking)
		firstAidName = firstAid and GetProfessionInfo(firstAid)
	end

	-- Debugging shows this is working succesfully, picking up both added and removed quests. 
	-- My update problem is NOT here
	for questLogIndex = 1, numEntries do
		local questID, questTitle, questLevel, suggestedGroup, isHeader, isComplete, isFailed, isRepeatable = self:GetQuestLogTitle(questLogIndex)

		-- Remove level from quest title, if it exists. This applies to Legion emissary quests, amongst others. 
		-- *I used the quest title "[110] The Wardens" for my testing, because I suck at patterns. 
		if questTitle then
			questTitle = string.gsub(questTitle, "^(%[%d+%]%s+)", "")
		end

		if isHeader then
			-- Store the title of the current header, as this usually also is the zone name
			questHeader = questTitle

		-- Going to ignore all quests that are world quests here, 
		-- as we're tracking all of them separately.
		elseif (not ENGINE_LEGION) or (not QuestUtils_IsQuestWorldQuest(questID)) then

			-- Select the entry in the quest log, for functions that require it to return info
			SelectQuestLogEntry(questLogIndex)

			-- If this is a new quest, report that we need an update
			if (not oldCache[questID]) then
				needUpdate = true
			end

			-- Add the quest to the current cache
			newCache[questID] = questLogIndex

			-- Retrieve the existing quest database, if any 
			local currentQuestData = questData[questID]
			if (not currentQuestData) then
				currentQuestData = {}
				needUpdate = true
			end

			local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft
			if ENGINE_LEGION then
				tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(questID)
			end

			local link, icon, charges, showItemWhenComplete = GetQuestLogSpecialItemInfo(questLogIndex) -- only an iconID in Legion, not a texture link
			local questCompletionText = isFailed and BLIZZ_LOCALE.QUEST_FAILED or GetQuestLogCompletionText(questLogIndex)
			local numQuestObjectives = GetNumQuestLeaderBoards(questLogIndex)
			local questDescription, questObjectivesDescription = GetQuestLogQuestText()

			local requiredMoney = GetQuestLogRequiredMoney(questLogIndex) or 0
			if (numQuestObjectives == 0) and (requiredMoney > 0) and (playerMoney >= requiredMoney) then
				isComplete = true
			end

			-- Update the quest objectives
			local questUpdated
			local questObjectives = currentQuestData.questObjectives or {}
			local numObjectivesCompleted = 0
			for i = 1, numQuestObjectives do
				
				local questObjective = questObjectives[i]
				if questObjective then
					local description, objectiveType, isCompleted, item, numCurrent, numNeeded = self:GetQuestLogLeaderBoard(i, questLogIndex)

					if not((description == questObjective.description) and (objectiveType == questObjective.objectiveType) and (isCompleted == questObjective.isCompleted) and (item == questObjective.item) and (numCurrent == questObjective.numCurrent) and (numNeeded == questObjective.numNeeded)) then

						-- Something was changed
						questUpdated = BLIZZ_LOCALE.UPDATE
					end

					questObjective.description = description
					questObjective.objectiveType = objectiveType
					questObjective.isCompleted = isCompleted
					questObjective.item = item
					questObjective.numCurrent = numCurrent
					questObjective.numNeeded = numNeeded
					
				else
					questObjective = {}

					-- new quest
					questObjective.description, 
					questObjective.objectiveType, 
					questObjective.isCompleted, 
					questObjective.item, 
					questObjective.numCurrent, 
					questObjective.numNeeded = self:GetQuestLogLeaderBoard(i, questLogIndex)

				end

				-- Needed for emissary quests to register as completed
				if (questObjective.item) and (questObjective.numCurrent == questObjective.numNeeded) and (questObjective.numNeeded > 0) then
					questObjective.isCompleted = true
				end
				if questObjective.isCompleted then
					numObjectivesCompleted = numObjectivesCompleted + 1
				end

				questObjectives[i] = questObjective
			end

			-- Can't really imagine why a quest's number of objectives should 
			-- change after creation, but just in case we wipe away any unneeded entries.
			-- Point is that we're using #questObjectives to determine number of objectives.
			for i = #questObjectives, numQuestObjectives + 1, -1 do
				if questObjectives[i] then
					table_wipe(questObjectives[i])
				end
			end

			-- If we're dealing with an update, figure out what kind. New quest? Failed? Completed? Updated objectives?
			currentQuestData.updateDescription = 
				(not questData[questID]) and BLIZZ_LOCALE.NEW or 
				(isComplete and (not currentQuestData.isComplete)) and BLIZZ_LOCALE.QUEST_COMPLETE or 
				(isFailed and (not currentQuestData.isFailed)) and BLIZZ_LOCALE.QUEST_FAILED or questUpdated

			currentQuestData.questID = questID
			currentQuestData.questTitle = questTitle
			currentQuestData.questLevel = questLevel
			--currentQuestData.questMapID = questMapID -- we're doing this later
			currentQuestData.questHeader = questHeader
			currentQuestData.suggestedGroup = suggestedGroup

			-- This should fire, since it requires itself to be turned in
			local currentQuestIsComplete = isComplete or (numQuestObjectives > 0 and numObjectivesCompleted == numQuestObjectives) 

			-- Need to change this to display a better suited text. "Ready for turn-in" just doesn't do it. 
			-- Also, we don't need this until we replace the Blizzard alert frame system. 
			--if dataExists and (emissaryQuestIDs[questID]) and (currentQuestIsComplete) and (not currentQuestData.isComplete) then
			--	local Warnings = Engine:GetModule("Warnings")
			--	if Warnings then
			--		Warnings:AddMessage(BLIZZ_LOCALE.QUEST_COMPLETE, "info")
			--	end
			--end
			currentQuestData.isComplete =  currentQuestIsComplete

			currentQuestData.isFailed = isFailed
			currentQuestData.isRepeatable = isRepeatable
			currentQuestData.completionText = questCompletionText
			currentQuestData.numQuestObjectives = numQuestObjectives
			currentQuestData.questObjectives = questObjectives
			currentQuestData.questDescription = questDescription
			currentQuestData.questObjectivesDescription = questObjectivesDescription
			currentQuestData.requiredMoney = requiredMoney
			currentQuestData.icon = icon
			currentQuestData.hasQuestItem = icon and ((not isComplete) or showItemWhenComplete)
			currentQuestData.showItemWhenComplete = showItemWhenComplete
			currentQuestData.questLogIndex = questLogIndex 
			currentQuestData.isEmissaryQuest = emissaryQuestIDs[questID]
			currentQuestData.isNormalQuest = not emissaryQuestIDs[questID]
			currentQuestData.isProfessionQuest = questHeader and (
				questHeader == profName1 or
				questHeader == profName2 or 
				questHeader == archaeologyName or 
				questHeader == cookingName or 
				questHeader == fishingName or 
				questHeader == firstAidName) 
			currentQuestData.tagID = tagID

			-- If anything was updated within this quest, report it back
			if (currentQuestData.updateDescription) then
				needUpdate = true
			end

			-- update pointer in case it was a newly added quest
			questData[questID] = currentQuestData
			
		end
	end

	-- Check if a quest was removed from the log since last iteration
	for questID, questLogIndex in pairs(oldCache) do
		if (questID ~= self:GetQuestLogTitle(questLogIndex)) then 
			needUpdate = true
			break
		end
	end

	-- Return the selected quest to whatever it was before our parsing.
	-- If we don't do this, hovering over quest rewards in the embedded worldmap 
	-- will bug out in client versions using the new map. 
	-- Return the selection to whatever the user or wow set it to seems to fix it.
	if (GetQuestLogSelection() ~= selection) then
		SelectQuestLogEntry(selection)
	end

	if needUpdate then

		-- Point the questlog cache to our new table
		questLogCache = newCache
	end
end

Module.AddWorldQuest = function(self, questID)
end

Module.RemoveWorldQuest = function(self, questID)
	-- Clear out completed entries
	worldQuestWatchQueue[questID] = nil
end 

Module.AddQuest = function(self, questID, questLogIndex)
end 

Module.RemoveQuest = function(self, questID)
end

Module.OnEvent = function(self, event, ...)
	-- Debugging
	--print(event, ...)

	if (event == "PLAYER_ENTERING_WORLD") then
		self:GatherQuestLogData() -- parse the quest log
		self:GatherWorldQuestData() -- parse for world quests

		self:GatherQuestZoneData() -- gather quest zone information (fires WORLD_MAP_UPDATE QUEST_LOG_UPDATE)
		self:UpdateZoneTracking() -- parse the zone for what to track
		self:ParseAutoQuests() -- parse automatic quests
	
	elseif (event == "PLAYER_REGEN_DISABLED") then
		self.inLockdown = true

	elseif (event == "PLAYER_REGEN_ENABLED") then
		self.inLockdown = false

	elseif (event == "QUEST_ACCEPTED") then
		local questLogIndex, questID = ...

		self:AddQuest(questID, questLogIndex)

		self:GatherQuestLogData() -- parse the quest log
		self:UpdateItemButtons() -- update item buttons in case of changed log indices

		if (not WorldMapFrame:IsShown()) then
			self:GatherQuestZoneData() -- gather quest zone information (fires WORLD_MAP_UPDATE QUEST_LOG_UPDATE)
		end

		self:UpdateZoneTracking() -- parse the zone for what to track

	elseif (event == "QUEST_REMOVED") then
		local questID = ...

		self:RemoveQuest(questID)

		self:GatherQuestLogData() -- parse the quest log
		self:UpdateItemButtons() -- update item buttons in case of changed log indices

		if (not WorldMapFrame:IsShown()) then
			self:GatherQuestZoneData() -- gather quest zone information (fires WORLD_MAP_UPDATE QUEST_LOG_UPDATE)
		end

		self:UpdateZoneTracking() -- parse the zone for what to track

	elseif (event == "QUEST_LOG_UPDATE") then 
		self:GatherQuestLogData() -- parse the quest log for changes to quests
		self:UpdateItemButtons() -- update item buttons in case of changed log indices

		self:GatherWorldQuestData() -- parse for world quests
		self:UpdateZoneTracking() -- parse the zone for what to track

	elseif (event == "QUEST_AUTOCOMPLETE") then
		-- from cata and up
		-- Auto completion and auto offering of quests
		PlaySoundKitID(SOUNDKIT.UI_AUTO_QUEST_COMPLETE, "SFX")
		ShowQuestComplete(GetQuestLogIndexByID((...)))

	elseif (event == "QUEST_POI_UPDATE") then
		self:GatherQuestLogData() -- parse the quest log
		self:UpdateItemButtons() -- update item buttons in case of changed log indices
		self:GatherWorldQuestData() -- parse for world quests

	elseif (event == "QUEST_TURNED_IN") then 
		-- world quest update 
		local questID, xp, money = ...

		self:RemoveWorldQuest(questID)

		if (HAS_WORLD_QUESTS and (questID and worldQuestCache[questID])) then
			self:SendMessage("ENGINE_WORLD_QUEST_COMPLETE", questID, xp, money)
			self:GatherWorldQuestData() -- parse for world quests
		
		elseif ((not HAS_WORLD_QUESTS) and (questID == WORLD_QUESTS_AVAILABLE_QUEST_ID)) then
			HAS_WORLD_QUESTS = true -- Tell the addon we now have access to world quests
			self:GatherWorldQuestData() -- parse for world quests
		end

	elseif (event == "WORLD_MAP_CLOSED") then
		self:GatherQuestZoneData() -- gather quest zone information (fires WORLD_MAP_UPDATE QUEST_LOG_UPDATE)
		self:UpdateZoneTracking() -- parse the zone for what to track

	elseif (event == "WORLD_MAP_UPDATE") then
		-- This could be triggered by C_TaskQuest.GetQuestsForPlayerByMapID(questMapID), 
		-- in which case we technically should ignore it. 

		-- This is where we register when the world map changes zone
		-- There are a TON of updates here, so we need to filter out the ones that matter
		self:UpdateZoneTracking() -- parse the zone for what to track

	elseif (event == "WORLD_QUEST_COMPLETED_BY_SPELL") then 
		-- world quest update
		-- QUEST_TURNED_IN will fire after this

	elseif (event == "ZONE_CHANGED") then
		local inMicroDungeon = IsPlayerInMicroDungeon and IsPlayerInMicroDungeon()
		if (inMicroDungeon ~= self.inMicroDungeon) then

			-- Inform the module we're in a micro dungeon.
			-- When implemented this will affect what objectives are shown,
			-- as we would like to track things only relevant to the dungeon, 
			-- or preferably none at all, thus keeping the screen clean. 
			self.inMicroDungeon = inMicroDungeon
			self:UpdateZoneTracking() -- parse the zone for what to track
		end
		self:ParseAutoQuests() -- parse automatic quests

	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		self:GatherQuestZoneData() -- gather quest zone information (fires WORLD_MAP_UPDATE QUEST_LOG_UPDATE)
		self:UpdateZoneTracking() -- parse the zone for what to track
		self:ParseAutoQuests() -- parse automatic quests

	elseif (event == "BAG_UPDATE_COOLDOWN") then
		self:UpdateItemButtons() -- update item buttons in case of changed log indices
		self:UpdateItemCooldowns() -- quest item cooldowns
	end

	self:UpdateTrackerWatches() 

end

Module.SetUpEvents = function(self, event, ...)
	-- Unregister whatever event brought us here
	self:UnregisterEvent(event, "SetUpEvents")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent") -- All

	-- Prior to MoP quest data wasn't available until this event
	-- This event doesn't always fire at the same point in the loading process in WotLK, 
 	-- but if we skip it or try to rely on other events, the tracker will fail at the initial startip. 
	 if (not ENGINE_MOP) then
		self:RegisterEvent("PLAYER_ALIVE", "OnEvent")
	end

	self:RegisterEvent("QUEST_ACCEPTED", "OnEvent") -- Filter
	self:RegisterEvent("QUEST_REMOVED", "OnEvent") -- Filter
	--self:RegisterEvent("QUESTLINE_UPDATE", "OnEvent")
	self:RegisterEvent("QUEST_LOG_UPDATE", "OnEvent")

	--self:RegisterEvent("PLAYER_MONEY", "OnEvent")
	--self:RegisterEvent("BAG_UPDATE", "OnEvent")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN", "OnEvent")
	--self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")
	

	self:RegisterEvent("QUEST_POI_UPDATE", "OnEvent") -- Items

	if (not ENGINE_BFA) then 
		self:RegisterEvent("WORLD_MAP_UPDATE", "OnEvent") -- Items
	end 
	
	self:RegisterEvent("ZONE_CHANGED", "OnEvent") -- Items
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnEvent") -- Filter

	if ENGINE_CATA then
		self:RegisterEvent("QUEST_AUTOCOMPLETE", "OnEvent")

		-- Auto-accept and auto-completion introduced in Cata
		-- Quests could be automatically accepted in WotLK too, 
		-- but no specific events existed for it back then.
		self:RegisterEvent("QUEST_AUTOCOMPLETE", "OnEvent")
		self:RegisterEvent("QUEST_POI_UPDATE", "OnEvent") -- world quest update

		if ENGINE_WOD then
			--self:RegisterEvent("QUEST_WATCH_LIST_CHANGED", "OnEvent") -- world quest update

			-- There are no events for world quests, 
			-- so the easiest way is to hook into the Blizzard API.
			-- Like with the world map, we create a dummy event here.
			-- *Need to figure out everything we need to hook this into.
			if ENGINE_LEGION then
				self:RegisterEvent("WORLD_QUEST_COMPLETED_BY_SPELL", "OnEvent") -- world quest update
				self:RegisterEvent("QUEST_TURNED_IN", "OnEvent") -- local questID, xp, money = ... -- fires on world quests
		
				self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEvent")
				self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
			end
		end
	end

	-- Need some fake events to update quest zones 
	-- that couldn't be retrieved while the map was open
	WorldMapFrame:HookScript("OnHide", function() self:OnEvent("WORLD_MAP_CLOSED") end)
	WorldMapFrame:HookScript("OnShow", function() self:OnEvent("WORLD_MAP_OPENED") end)

	-- Do an initial full update
	self:OnEvent("PLAYER_ENTERING_WORLD")
end

Module.OnInit = function(self)
	self.config = self:GetDB("Objectives").tracker
	self.db = self:GetConfig("ObjectiveTracker") -- user settings. will save manually tracked quests here later.

	local config = self.config


	-- Tracker visibility layer
	-----------------------------------------------------------
	-- The idea here is that we simply do NOT want it visible while in an arena, 
	-- or while engaged in a boss fight.  
	-- We want as little clutter and distractions as possible during those 
	-- types of fights, and the quest tracker is simply just in the way then. 
	-- Same goes for pet battles in MoP and beyond. 
	local visibility = Engine:CreateFrame("Frame", nil, "UICenter", "SecureHandlerAttributeTemplate")
	if ENGINE_MOP then
		RegisterStateDriver(visibility, "visibility", "[petbattle][@boss1,exists][@arena1,exists]hide;show")
	else
		RegisterStateDriver(visibility, "visibility", "[@boss1,exists][@arena1,exists]hide;show")
	end


	-- Mythic+ Affix Frame
	-----------------------------------------------------------
	if ENGINE_LEGION then
		-- totally on my todo list
	end


	-- Quest Tracker frame
	-----------------------------------------------------------
	local tracker = setmetatable(visibility:CreateFrame("Frame"), Tracker_MT)
	tracker:Hide() -- keep it initially hidden
	tracker:SetFrameStrata("LOW")
	tracker:SetFrameLevel(15)
	tracker.config = config
	tracker.entries = {} -- table to hold entries

	for i,point in ipairs(config.points) do
		tracker:Point(unpack(point))
	end


	-- Header region
	-----------------------------------------------------------
	local header = tracker:CreateFrame("Frame")
	header:SetHeight(config.header.height)
	for i,point in ipairs(config.header.points) do
		header:Point(unpack(point))
	end

	-- Tracker title
	local title = header:CreateFontString()
	title:SetDrawLayer("BACKGROUND")
	title:SetFontObject(config.header.title.normalFont)
	title:Place(unpack(config.header.title.position))
	title:SetText(BLIZZ_LOCALE.OBJECTIVES)
	title.position = config.header.title.position
	title.positionMinimized = config.header.title.positionMinimized

	-- Maximize/minimize button (embedded in the tracker title)
	local button = setmetatable(header:CreateFrame("Button"), MinMaxButton_MT)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonDown")
	button:SetAllPoints(title)


	-- Body region
	-----------------------------------------------------------
	local body = tracker:CreateFrame("Frame")
	body:Point("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
	body:Point("TOPRIGHT", header, "BOTTOMRIGHT", 0, -4)
	body:Point("BOTTOMLEFT", 0, 0)
	body:Point("BOTTOMRIGHT", 0, 0)


	-- Apply scripts
	-----------------------------------------------------------
	button.body = body
	button.title = title
	button.currentState = "maximized" -- todo: save this between sessions(?)

	button:SetScript("OnClick", MinMaxButton.OnClick)
	button:SetScript("OnEnter", MinMaxButton.OnEnter)
	button:SetScript("OnLeave", MinMaxButton.OnLeave)

	tracker.header = header
	tracker.body = body

	self.tracker = tracker

end

Module.OnEnable = function(self)

	-- Kill off the blizzard objectives tracker, 
	-- as well as the WorldMap quest tracking options.
	local BlizzardUI = self:GetHandler("BlizzardUI")
	BlizzardUI:GetElement("ObjectiveTracker"):Disable()
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsObjectivesPanelWatchFrameWidth")
	BlizzardUI:GetElement("WorldMap"):Remove("QuestTracking")

	if ENGINE_MOP then

		-- No real need to track any events at all prior to this
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "SetUpEvents")

		if ENGINE_LEGION then

			-- Do we have world quests?
			HAS_WORLD_QUESTS = HAS_WORLD_QUESTS or IsQuestFlaggedCompleted(WORLD_QUESTS_AVAILABLE_QUEST_ID)

			-- My tests show this to be available at PLAYER_ALIVE, 
			-- but I thought that event hadn't fired for available 
			-- quest data since prior to MoP. Is this a TrinityCore issue?
			if (not HAS_WORLD_QUESTS) then
				local lateChecker 
				lateChecker = function(self, event)
					HAS_WORLD_QUESTS = HAS_WORLD_QUESTS or IsQuestFlaggedCompleted(WORLD_QUESTS_AVAILABLE_QUEST_ID)
					if HAS_WORLD_QUESTS then 
					end
					self:UnregisterEvent(event, lateChecker)
				end
				self:RegisterEvent("VARIABLES_LOADED", lateChecker)
				self:RegisterEvent("PLAYER_ALIVE", lateChecker)
			end
		end
	else
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "SetUpEvents")
	end

	--local debugger = CreateFrame("Frame")
	--debugger:RegisterAllEvents()
	--debugger:SetScript("OnEvent", function(self, ...) print(...) end)

end
