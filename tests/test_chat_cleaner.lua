-- Run from the addon root: lua5.1 tests/test_chat_cleaner.lua
--
-- Loads the *real* modules/chat/cleaner.lua with the WotLK 3.3.5 enUS
-- global strings its rules read, and runs chat lines through the message
-- event filters it registers, the way Blizzard's ChatFrame_MessageEventHandler
-- does: loot, money, experience, reputation, honor, skills, level ups,
-- quests, away/busy/rested, online/offline, auctions and achievements
-- become short colored lines, each group behind its own option; channel
-- notices and empty lines are hidden. Also the pattern builder itself,
-- with translations that reorder their arguments.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

-- The 3.3.5 enUS texts (Interface\FrameXML\GlobalStrings.lua)
local STRINGS = {
	LOOT_ITEM_SELF = "You receive loot: %s.", LOOT_ITEM_SELF_MULTIPLE = "You receive loot: %sx%d.",
	LOOT_ITEM = "%s receives loot: %s.", LOOT_ITEM_MULTIPLE = "%s receives loot: %sx%d.",
	LOOT_ITEM_PUSHED_SELF = "You receive item: %s.", LOOT_ITEM_PUSHED_SELF_MULTIPLE = "You receive item: %sx%d.",
	LOOT_ITEM_CREATED_SELF = "You create: %s.", LOOT_ITEM_CREATED_SELF_MULTIPLE = "You create: %sx%d.",
	LOOT_ROLL_YOU_WON = "You won: %s", YOU_LOOT_MONEY = "You loot %s", LOOT_MONEY_SPLIT = "Your share of the loot is %s.",
	GOLD_AMOUNT = "%d Gold", SILVER_AMOUNT = "%d Silver", COPPER_AMOUNT = "%d Copper",
	COMBATLOG_XPGAIN_FIRSTPERSON = "%s dies, you gain %d experience.",
	COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED = "You gain %d experience.",
	ERR_QUEST_REWARD_EXP_I = "Experience gained: %d.",
	LEVEL_UP = "Congratulations, you have reached level %d!",
	LEVEL_UP_HEALTH_MANA = "You have gained %d hit points and %d mana.", LEVEL_UP_HEALTH = "You have gained %d hit points.",
	LEVEL_UP_STAT = "Your %s increases by %d.",
	FACTION_STANDING_INCREASED = "Reputation with %s increased by %d.", FACTION_STANDING_DECREASED = "Reputation with %s decreased by %d.",
	FACTION_STANDING_INCREASED_GENERIC = "Reputation with %s increased.", FACTION_STANDING_DECREASED_GENERIC = "Reputation with %s decreased.",
	FACTION_STANDING_CHANGED = "You are now %s with %s.",
	COMBATLOG_HONORGAIN = "%s dies, honorable kill Rank: %s (%d Honor Points)",
	COMBATLOG_HONORGAIN_NO_RANK = "%s dies, honorable kill (%d Honor Points)",
	COMBATLOG_HONORAWARD = "You have been awarded %d honor points.",
	SKILL_RANK_UP = "Your skill in %s has increased to %d.",
	ERR_QUEST_ACCEPTED_S = "Quest accepted: %s", ERR_QUEST_COMPLETE_S = "%s completed.",
	ERR_QUEST_REWARD_ITEM_S = "Received item: %s.", ERR_QUEST_REWARD_MONEY_S = "Received %s.",
	ERR_QUEST_REWARD_ITEM_MULT_IS = "Received %d of item: %s.",
	MARKED_AFK = "You are now Away.", MARKED_AFK_MESSAGE = "You are now Away: %s", CLEARED_AFK = "You are no longer Away.",
	MARKED_DND = "You are now Busy: %s.", CLEARED_DND = "You are no longer marked Busy.",
	ERR_EXHAUSTION_RESTED = "You feel rested.", ERR_EXHAUSTION_WELLRESTED = "You feel well rested.",
	ERR_EXHAUSTION_NORMAL = "You feel normal.",
	ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h has come online.", ERR_FRIEND_OFFLINE_S = "%s has gone offline.",
	ERR_AUCTION_STARTED = "Auction created.", ERR_AUCTION_REMOVED = "Auction cancelled.", ERR_AUCTION_BID_PLACED = "Bid accepted.",
	ERR_AUCTION_WON_S = "You won an auction for %s", ERR_AUCTION_SOLD_S = "A buyer has been found for your auction of %s.",
	ERR_AUCTION_OUTBID_S = "You have been outbid on %s.", ERR_AUCTION_EXPIRED_S = "Your auction of %s has expired.",
	ACHIEVEMENT_BROADCAST = "%s has earned the achievement %s!",
	FRIENDS_LIST_AWAY = "Away", FRIENDS_LIST_BUSY = "Busy", TUTORIAL_TITLE26 = "Rested",
	DEFAULT_AFK_MESSAGE = "Away", DEFAULT_DND_MESSAGE = "Busy",
	XP = "XP", REPUTATION = "Reputation", HONOR = "Honor", LEVEL = "Level", HEALTH = "Health", MANA = "Mana",
}

local PLUS, MINUS = "|cff33cc33+|r ", "|cffcc3333-|r "
local ITEM = "|cff1eff00|Hitem:33470:0:0:0:0:0:0:0|h[Frostweave Cloth]|h|r"

local filters, db, Module

local function load()
	for name, text in pairs(STRINGS) do
		_G[name] = text
	end
	filters = {}
	_G.ChatFrame_AddMessageEventFilter = function(event, filter)
		filters[event] = filters[event] or {}
		table.insert(filters[event], filter)
	end
	local Engine = EngineMock.new()
	Engine:NewStaticConfig("Library: Format", { Money = function(copper) return "<" .. copper .. ">" end })
	db = {
		cleanLoot = true, cleanProgress = true, cleanQuests = true, cleanStatus = true, cleanOnline = true,
		cleanAuctions = true, cleanAchievements = true, hideChatNoise = true,
	}
	Engine.GetConfig = function() return db end
	assert(loadfile("modules/chat/cleaner.lua"))("DiabolicUI", Engine)
	Module = Engine:GetModule("ChatCleaner")
	Module:OnInit()
	Module:OnEnable()
end

-- Blizzard's handler: every filter in turn; one returning true hides the
-- line, one returning new arguments passes them on. Returns the line shown,
-- or nil when hidden.
local frame = { channelList = {}, zoneChannelList = {} }
local function chat(event, msg, ...)
	local args = { msg, ... }
	for _, filter in ipairs(filters[event] or {}) do
		local result = { filter(frame, event, unpack(args, 1, 12)) }
		if result[1] then
			return nil
		elseif result[2] then
			args = { unpack(result, 2, 13) }
		end
	end
	return args[1]
end

TestChatCleaner = {}

function TestChatCleaner:setUp()
	load()
end

function TestChatCleaner:test_loot_and_money()
	lu.assertEquals(chat("CHAT_MSG_LOOT", "You receive loot: " .. ITEM .. "x3."), PLUS .. ITEM .. " (3)")
	lu.assertEquals(chat("CHAT_MSG_LOOT", "You receive loot: " .. ITEM .. "."), PLUS .. ITEM)
	lu.assertEquals(chat("CHAT_MSG_LOOT", "You receive item: " .. ITEM .. "x2."), PLUS .. ITEM .. " (2)")
	lu.assertEquals(chat("CHAT_MSG_LOOT", "You create: " .. ITEM .. "."), PLUS .. ITEM)
	lu.assertEquals(chat("CHAT_MSG_LOOT", "You won: " .. ITEM), PLUS .. ITEM)
	lu.assertEquals(chat("CHAT_MSG_LOOT", "Ally receives loot: " .. ITEM .. "x5."), "Ally: " .. ITEM .. " (5)")
	lu.assertEquals(chat("CHAT_MSG_LOOT", "Ally receives loot: " .. ITEM .. "."), "Ally: " .. ITEM)
	lu.assertEquals(chat("CHAT_MSG_MONEY", "You loot 1 Gold, 20 Silver, 5 Copper"), PLUS .. "<12005>")
	lu.assertEquals(chat("CHAT_MSG_MONEY", "Your share of the loot is 35 Copper."), PLUS .. "<35>")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Received 2 Gold."), PLUS .. "<20000>")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Received 4 of item: " .. ITEM .. "."), PLUS .. ITEM .. " (4)")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Received item: " .. ITEM .. "."), PLUS .. ITEM)
	-- money we can't read stays as it is
	lu.assertEquals(chat("CHAT_MSG_MONEY", "You loot a lot"), "You loot a lot")
end

function TestChatCleaner:test_experience_reputation_honor_skills_levels()
	lu.assertEquals(chat("CHAT_MSG_COMBAT_XP_GAIN", "Kobold Vermin dies, you gain 250 experience."), PLUS .. "250 XP: Kobold Vermin")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_XP_GAIN", "Kobold Vermin dies, you gain 250 experience. (+125 exp Rested bonus)"),
		PLUS .. "250 XP: Kobold Vermin |cff999999(+125 exp Rested bonus)|r")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_XP_GAIN", "You gain 80 experience."), PLUS .. "80 XP")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Experience gained: 4400."), PLUS .. "4400 XP")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_FACTION_CHANGE", "Reputation with Argent Crusade increased by 75."),
		PLUS .. "75 Reputation: |cffffd200Argent Crusade|r")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_FACTION_CHANGE", "Reputation with Booty Bay decreased by 25."),
		MINUS .. "25 Reputation: |cffffd200Booty Bay|r")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_FACTION_CHANGE", "Reputation with Ravenholdt increased."), PLUS .. "Reputation: |cffffd200Ravenholdt|r")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_FACTION_CHANGE", "Reputation with Ravenholdt decreased."), MINUS .. "Reputation: |cffffd200Ravenholdt|r")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_FACTION_CHANGE", "You are now Revered with Argent Crusade."), "|cffffd200Argent Crusade|r: Revered")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_HONOR_GAIN", "Thrall dies, honorable kill Rank: Warlord (15 Honor Points)"), PLUS .. "15 Honor: Thrall (Warlord)")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_HONOR_GAIN", "Thrall dies, honorable kill (12 Honor Points)"), PLUS .. "12 Honor: Thrall")
	lu.assertEquals(chat("CHAT_MSG_COMBAT_HONOR_GAIN", "You have been awarded 300 honor points."), PLUS .. "300 Honor")
	lu.assertEquals(chat("CHAT_MSG_SKILL", "Your skill in Tailoring has increased to 441."), PLUS .. "|cffffd200Tailoring|r: 441")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Congratulations, you have reached level 80!"), PLUS .. "|cffffd200Level 80|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You have gained 120 hit points and 90 mana."), PLUS .. "120 Health, " .. PLUS .. "90 Mana")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You have gained 120 hit points."), PLUS .. "120 Health")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Your Stamina increases by 3."), PLUS .. "3 Stamina")
end

function TestChatCleaner:test_quests_status_online_auctions()
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Quest accepted: The Lich King"), PLUS .. "Quest accepted: |cffffd200The Lich King|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "The Lich King completed."), PLUS .. "|cffffd200The Lich King|r completed")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You are now Away."), "|cffff9900+ Away|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You are now Away: Away"), "|cffff9900+ Away|r") -- the default message
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You are now Away: brb"), "|cffff9900+ Away: brb|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You are no longer Away."), "|cff33cc33- Away|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You are now Busy: Busy."), "|cffff9900+ Busy|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You are no longer marked Busy."), "|cff33cc33- Busy|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You feel rested."), PLUS .. "Rested")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You feel well rested."), PLUS .. "Rested")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You feel normal."), "|cff999999- Rested|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "|Hplayer:Ally|h[Ally]|h has come online."), PLUS .. "|Hplayer:Ally|h[Ally]|h has come online")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Ally has gone offline."), "|cff999999- Ally has gone offline|r")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Auction created."), PLUS .. "Auction created")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Auction cancelled."), MINUS .. "Auction cancelled")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Bid accepted."), PLUS .. "Bid accepted")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "A buyer has been found for your auction of Silk Cloth."), PLUS .. "A buyer has been found for your auction of Silk Cloth")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You won an auction for Silk Cloth"), PLUS .. "You won an auction for Silk Cloth")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "You have been outbid on Silk Cloth."), MINUS .. "You have been outbid on Silk Cloth")
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Your auction of Silk Cloth has expired."), MINUS .. "Your auction of Silk Cloth has expired")
	-- anything else stays as it is
	lu.assertEquals(chat("CHAT_MSG_SYSTEM", "Welcome to ChromieCraft."), "Welcome to ChromieCraft.")
end

function TestChatCleaner:test_achievements_keep_the_name_slot()
	local link = "|cffffff00|Hachievement:6:0:0:0:0:0:0:0:0:0:0|h[Level 10]|h|r"
	lu.assertEquals(chat("CHAT_MSG_ACHIEVEMENT", "%s has earned the achievement " .. link .. "!", "Ally"), "%s: " .. link)
	lu.assertEquals(chat("CHAT_MSG_GUILD_ACHIEVEMENT", "%s has earned the achievement " .. link .. "!", "Ally"), "%s: " .. link)
	-- already filled in by someone: left alone
	lu.assertEquals(chat("CHAT_MSG_ACHIEVEMENT", "Ally has earned the achievement " .. link .. "!"), "Ally has earned the achievement " .. link .. "!")
end

function TestChatCleaner:test_each_group_has_its_option()
	for setting, line in pairs({
		cleanLoot = { "CHAT_MSG_LOOT", "You receive loot: " .. ITEM .. "." },
		cleanProgress = { "CHAT_MSG_COMBAT_XP_GAIN", "You gain 80 experience." },
		cleanQuests = { "CHAT_MSG_SYSTEM", "Quest accepted: The Lich King" },
		cleanStatus = { "CHAT_MSG_SYSTEM", "You are now Away." },
		cleanOnline = { "CHAT_MSG_SYSTEM", "Ally has gone offline." },
		cleanAuctions = { "CHAT_MSG_SYSTEM", "Auction created." },
		cleanAchievements = { "CHAT_MSG_ACHIEVEMENT", "%s has earned the achievement [x]!" },
	}) do
		db[setting] = false
		lu.assertEquals(chat(line[1], line[2]), line[2], setting)
		db[setting] = true
		lu.assertNotEquals(chat(line[1], line[2]), line[2], setting)
	end
end

function TestChatCleaner:test_channel_notices_and_empty_lines_are_hidden()
	-- CHANNEL_NOTICE: arg1 the notice, arg4 the channel, arg7 the zone channel, arg9 its name
	local function notice(kind, channel, zone, name)
		return chat("CHAT_MSG_CHANNEL_NOTICE", kind, "", "", channel, "", "", zone, 1, name)
	end
	lu.assertNil(notice("YOU_JOINED", "1. General - Dalaran", 1, "General"))
	lu.assertNil(notice("YOU_CHANGED", "1. General - Dalaran", 1, "General"))
	lu.assertEquals(notice("SUSPENDED", "1. General - Dalaran", 1, "General"), "SUSPENDED")

	-- leaving: Blizzard's bookkeeping, done for it
	frame.channelList = { "General", "Trade", "MyChannel" }
	frame.zoneChannelList = { 1, 2, 0 }
	lu.assertNil(notice("YOU_LEFT", "2. Trade - City", 2, "Trade"))
	lu.assertNil(frame.channelList[2])
	lu.assertNil(notice("YOU_LEFT", "5. MyChannel", 0, "mychannel"))
	lu.assertNil(frame.channelList[3])
	lu.assertEquals(frame.channelList[1], "General")

	lu.assertNil(chat("CHAT_MSG_SAY", "   ", "Ally"))
	lu.assertEquals(chat("CHAT_MSG_SAY", "hi", "Ally"), "hi")

	db.hideChatNoise = false
	lu.assertEquals(notice("YOU_JOINED", "1. General - Dalaran", 1, "General"), "YOU_JOINED")
	lu.assertEquals(chat("CHAT_MSG_SAY", "", "Ally"), "")
end

function TestChatCleaner:test_patterns_follow_reordered_translations()
	local pattern, order = Module.ToPattern("Ruf bei %2$s um %1$d gestiegen (100%).")
	lu.assertEquals(pattern, "^Ruf bei (.-) um (%d+) gestiegen %(100%%%)%.$")
	lu.assertEquals(order, { 2, 1 })
	pattern = Module.ToPattern("You gain %d experience.", true)
	lu.assertEquals(pattern, "^You gain (%d+) experience%.(.*)$")
end

os.exit(lu.LuaUnit.run())
