-- Chat cleaner: Blizzard's long system lines (loot, money, experience,
-- reputation, quests, ...) rewritten as short colored ones, "+ [Item] (3)"
-- or "+ 75 Reputation: Argent Crusade", each group behind its own option.
-- In the spirit of Goldpaw's ChatCleaner (backported in CleanerChat), so
-- it stays off when either is loaded.
--
-- Works with chat message event filters: a line is matched against the
-- global string Blizzard built it from (so any client language works),
-- and rewritten before any chat window shows it.
local _, Engine = ...
local Module = Engine:NewModule("ChatCleaner")
local F = Engine:GetDB("Library: Format")

Module:SetIncompatible("ChatCleaner")
Module:SetIncompatible("CleanerChat")

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local select = select
local string_find = string.find
local string_format = string.format
local string_gsub = string.gsub
local string_len = string.len
local string_match = string.match
local string_upper = string.upper
local tonumber = tonumber

-- WoW API
local ChatFrame_AddMessageEventFilter = _G.ChatFrame_AddMessageEventFilter

local PLUS = "|cff33cc33+|r "
local MINUS = "|cffcc3333-|r "
local HIGHLIGHT = "|cffffd200%s|r"
local DIM = "|cff999999%s|r"
local STATUS_ON = "|cffff9900+ %s|r"
local STATUS_OFF = "|cff33cc33- %s|r"

-- Patterns -----------------------------------------------------------------

-- The Lua pattern matching what the global string `template` prints, and
-- for each capture the number of the argument it is (translations can
-- reorder them, as "%2$s"). With `open`, whatever follows is one more
-- capture (experience lines can end with a rested bonus).
local ToPattern = function(template, open)
	local order, count = {}, 0
	local pattern = string_gsub(template, "%%(%d*)%$?([sd])", function(index, kind)
		count = count + 1
		order[count] = tonumber(index) or count
		return (kind == "d") and "\2" or "\1"
	end)
	pattern = string_gsub(pattern, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
	pattern = string_gsub(string_gsub(pattern, "\1", "(.-)"), "\2", "(%%d+)")
	return "^" .. pattern .. (open and "(.*)$" or "$"), order
end

-- The arguments `msg` was printed with, in their own order, or nil when
-- the rule's global string didn't print it.
local Match = function(rule, msg)
	local captures = { string_match(msg, rule.pattern) }
	if (captures[1] == nil) then
		return
	end
	local args = {}
	for i, index in ipairs(rule.order) do
		args[index] = captures[i]
	end
	args.rest = captures[#rule.order + 1]
	return args
end

-- Copper in a money text like "1 Gold, 20 Silver, 5 Copper", or nil.
-- each coin's pattern, from its global string ("%d Gold"), and its copper;
-- made on first use
local coins

local ParseMoney = function(text)
	coins = coins or {
		{ (string_gsub(_G.GOLD_AMOUNT, "%%d", "(%%d+)")), 10000 },
		{ (string_gsub(_G.SILVER_AMOUNT, "%%d", "(%%d+)")), 100 },
		{ (string_gsub(_G.COPPER_AMOUNT, "%%d", "(%%d+)")), 1 }
	}
	local copper, found = 0, false
	for _, coin in ipairs(coins) do
		local amount = string_match(text, coin[1])
		if amount then
			copper = copper + tonumber(amount) * coin[2]
			found = true
		end
	end
	return found and copper or nil
end

-- The line without its final period.
local Trim = function(msg)
	return (string_gsub(msg, "%.$", ""))
end

-- Rules ----------------------------------------------------------------------

local Item = function(args) return PLUS .. args[1] end
local Items = function(args) return string_format("%s%s (%d)", PLUS, args[1], args[2]) end
local Money = function(args)
	local copper = ParseMoney(args[1])
	return copper and (PLUS .. F.Money(copper))
end
local Gained = function(args, msg) return PLUS .. Trim(msg) end
local Lost = function(args, msg) return MINUS .. Trim(msg) end
-- "+ 250 XP: Kobold Vermin (+125 exp Rested bonus)", the bonus dimmed
local Experience = function(args, msg, source)
	local rest = string_gsub(args.rest or "", "^%s+", "")
	return PLUS .. args[1] .. " " .. _G.XP .. (source and (": " .. source) or "")
		.. ((rest ~= "") and (" " .. string_format(DIM, rest)) or "")
end
local Status = function(label, message, default)
	if message and (message ~= "") and (message ~= default) then
		return string_format(STATUS_ON, label .. ": " .. message)
	end
	return string_format(STATUS_ON, label)
end

-- Each group: its option, and per chat event the rules tried in turn (the
-- one with a count before the one without: "%sx%d." also reads as "%s.").
-- A rule: the global string it reads, and what the line becomes (nil
-- leaves it as it is).
local GROUPS = {
	{ setting = "cleanLoot", events = {
		CHAT_MSG_LOOT = {
			{ "LOOT_ITEM_SELF_MULTIPLE", Items },
			{ "LOOT_ITEM_PUSHED_SELF_MULTIPLE", Items },
			{ "LOOT_ITEM_CREATED_SELF_MULTIPLE", Items },
			{ "LOOT_ITEM_SELF", Item },
			{ "LOOT_ITEM_PUSHED_SELF", Item },
			{ "LOOT_ITEM_CREATED_SELF", Item },
			{ "LOOT_ROLL_YOU_WON", Item },
			{ "LOOT_ITEM_MULTIPLE", function(args) return string_format("%s: %s (%d)", args[1], args[2], args[3]) end },
			{ "LOOT_ITEM", function(args) return args[1] .. ": " .. args[2] end },
		},
		CHAT_MSG_MONEY = {
			{ "YOU_LOOT_MONEY", Money },
			{ "LOOT_MONEY_SPLIT", Money },
		},
		CHAT_MSG_SYSTEM = {
			{ "ERR_QUEST_REWARD_ITEM_MULT_IS", function(args) return string_format("%s%s (%d)", PLUS, args[2], args[1]) end },
			{ "ERR_QUEST_REWARD_ITEM_S", Item },
			{ "ERR_QUEST_REWARD_MONEY_S", Money }, -- "Received %s." reads the item lines too
		},
	} },
	{ setting = "cleanProgress", events = {
		CHAT_MSG_COMBAT_XP_GAIN = {
			{ "COMBATLOG_XPGAIN_FIRSTPERSON", function(args, msg)
				return Experience({ args[2], rest = args.rest }, msg, args[1])
			end, open = true },
			{ "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED", Experience, open = true },
		},
		CHAT_MSG_COMBAT_FACTION_CHANGE = {
			{ "FACTION_STANDING_INCREASED", function(args)
				return string_format("%s%d %s: " .. HIGHLIGHT, PLUS, args[2], _G.REPUTATION, args[1])
			end },
			{ "FACTION_STANDING_DECREASED", function(args)
				return string_format("%s%d %s: " .. HIGHLIGHT, MINUS, args[2], _G.REPUTATION, args[1])
			end },
			{ "FACTION_STANDING_INCREASED_GENERIC", function(args)
				return string_format("%s%s: " .. HIGHLIGHT, PLUS, _G.REPUTATION, args[1])
			end },
			{ "FACTION_STANDING_DECREASED_GENERIC", function(args)
				return string_format("%s%s: " .. HIGHLIGHT, MINUS, _G.REPUTATION, args[1])
			end },
			{ "FACTION_STANDING_CHANGED", function(args)
				return string_format(HIGHLIGHT .. ": %s", args[2], args[1])
			end },
		},
		CHAT_MSG_COMBAT_HONOR_GAIN = {
			{ "COMBATLOG_HONORGAIN", function(args)
				return string_format("%s%d %s: %s (%s)", PLUS, args[3], _G.HONOR, args[1], args[2])
			end },
			{ "COMBATLOG_HONORGAIN_NO_RANK", function(args)
				return string_format("%s%d %s: %s", PLUS, args[2], _G.HONOR, args[1])
			end },
			{ "COMBATLOG_HONORAWARD", function(args)
				return string_format("%s%d %s", PLUS, args[1], _G.HONOR)
			end },
		},
		CHAT_MSG_SKILL = {
			{ "SKILL_RANK_UP", function(args)
				return string_format("%s" .. HIGHLIGHT .. ": %d", PLUS, args[1], args[2])
			end },
		},
		CHAT_MSG_SYSTEM = {
			{ "ERR_QUEST_REWARD_EXP_I", Experience },
			{ "LEVEL_UP", function(args)
				return string_format("%s" .. HIGHLIGHT, PLUS, _G.LEVEL .. " " .. args[1])
			end },
			{ "LEVEL_UP_HEALTH_MANA", function(args)
				return string_format("%s%d %s, %s%d %s", PLUS, args[1], _G.HEALTH, PLUS, args[2], _G.MANA)
			end },
			{ "LEVEL_UP_HEALTH", function(args)
				return string_format("%s%d %s", PLUS, args[1], _G.HEALTH)
			end },
			{ "LEVEL_UP_STAT", function(args)
				return string_format("%s%d %s", PLUS, args[2], args[1])
			end },
		},
	} },
	{ setting = "cleanQuests", events = {
		CHAT_MSG_SYSTEM = {
			{ "ERR_QUEST_ACCEPTED_S", function(args)
				return PLUS .. string_format(_G.ERR_QUEST_ACCEPTED_S, string_format(HIGHLIGHT, args[1]))
			end },
			{ "ERR_QUEST_COMPLETE_S", function(args)
				return PLUS .. Trim(string_format(_G.ERR_QUEST_COMPLETE_S, string_format(HIGHLIGHT, args[1])))
			end },
		},
	} },
	{ setting = "cleanStatus", events = {
		CHAT_MSG_SYSTEM = {
			{ "MARKED_AFK", function() return Status(_G.FRIENDS_LIST_AWAY) end },
			{ "MARKED_AFK_MESSAGE", function(args) return Status(_G.FRIENDS_LIST_AWAY, args[1], _G.DEFAULT_AFK_MESSAGE) end },
			{ "CLEARED_AFK", function() return string_format(STATUS_OFF, _G.FRIENDS_LIST_AWAY) end },
			{ "MARKED_DND", function(args) return Status(_G.FRIENDS_LIST_BUSY, args[1], _G.DEFAULT_DND_MESSAGE) end },
			{ "CLEARED_DND", function() return string_format(STATUS_OFF, _G.FRIENDS_LIST_BUSY) end },
			{ "ERR_EXHAUSTION_RESTED", function() return PLUS .. _G.TUTORIAL_TITLE26 end },
			{ "ERR_EXHAUSTION_WELLRESTED", function() return PLUS .. _G.TUTORIAL_TITLE26 end },
			{ "ERR_EXHAUSTION_NORMAL", function() return string_format(DIM, "- " .. _G.TUTORIAL_TITLE26) end },
		},
	} },
	{ setting = "cleanOnline", events = {
		CHAT_MSG_SYSTEM = {
			{ "ERR_FRIEND_ONLINE_SS", Gained },
			{ "ERR_FRIEND_OFFLINE_S", function(args, msg) return string_format(DIM, "- " .. Trim(msg)) end },
		},
	} },
	{ setting = "cleanAuctions", events = {
		CHAT_MSG_SYSTEM = {
			{ "ERR_AUCTION_STARTED", Gained },
			{ "ERR_AUCTION_REMOVED", Lost },
			{ "ERR_AUCTION_BID_PLACED", Gained },
			{ "ERR_AUCTION_WON_S", Gained },
			{ "ERR_AUCTION_SOLD_S", Gained },
			{ "ERR_AUCTION_OUTBID_S", Lost },
			{ "ERR_AUCTION_EXPIRED_S", Lost },
		},
	} },
	{ setting = "cleanAchievements", events = {
		-- "%s has earned the achievement [Name]!": the %s is left in, Blizzard
		-- puts the player's name there afterwards
		CHAT_MSG_ACHIEVEMENT = {
			{ "ACHIEVEMENT_BROADCAST", function(args) return (args[1] == "%s") and ("%s: " .. args[2]) end },
		},
		CHAT_MSG_GUILD_ACHIEVEMENT = {
			{ "ACHIEVEMENT_BROADCAST", function(args) return (args[1] == "%s") and ("%s: " .. args[2]) end },
		},
	} },
}

-- What player chat events carry empty lines ("ghost" messages some servers
-- and relay addons send).
local PLAYER_CHAT = {
	"CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_EMOTE", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_BATTLEGROUND", "CHAT_MSG_BATTLEGROUND_LEADER", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER", "CHAT_MSG_CHANNEL",
}

-- Filters -------------------------------------------------------------------

-- event -> the rules for it, each with its group's setting
local rulesByEvent = {}

local CleanLine = function(frame, event, msg, ...)
	local db = Module.db
	for _, rule in ipairs(rulesByEvent[event]) do
		if db[rule.setting] then
			local args = Match(rule, msg)
			local cleaned = args and rule.clean(args, msg) -- (nil: not for this rule after all)
			if cleaned then
				return false, cleaned, ...
			end
		end
	end
	return false
end

local HideEmptyLine = function(frame, event, msg)
	return Module.db.hideChatNoise and (not string_find(msg, "%S"))
end

-- The notices of joining, changing and leaving a channel. Blizzard forgets
-- a channel it left only while showing that notice, so a hidden one is
-- forgotten here.
local HideChannelNotice = function(frame, event, notice, ...)
	-- The server sends notices 3.3.5 has no string for (NOT_IN_LFG from the
	-- LookingForGroup channel); Blizzard's handler would format(nil) and error.
	if (not _G["CHAT_"..notice.."_NOTICE"]) and (not _G["CHAT_"..notice.."_NOTICE_BN"]) then
		return true
	end
	if (not Module.db.hideChatNoise) then
		return false
	end
	if (notice == "YOU_LEFT") then
		local channel, _, _, zoneChannel, _, name = select(3, ...)
		for index, value in pairs(frame.channelList) do
			if (string_len(channel) > string_len(value))
			and (((zoneChannel > 0) and (frame.zoneChannelList[index] == zoneChannel)) or (string_upper(value) == string_upper(name))) then
				frame.channelList[index] = nil
				frame.zoneChannelList[index] = nil
				break
			end
		end
		return true
	end
	return (notice == "YOU_JOINED") or (notice == "YOU_CHANGED")
end

Module.OnInit = function(self)
	self.db = self:GetConfig("ChatFilters")
	for _, group in ipairs(GROUPS) do
		for event, rules in pairs(group.events) do
			rulesByEvent[event] = rulesByEvent[event] or {}
			for _, rule in ipairs(rules) do
				local pattern, order = ToPattern(_G[rule[1]], rule.open)
				local list = rulesByEvent[event]
				list[#list + 1] = { setting = group.setting, pattern = pattern, order = order, clean = rule[2] }
			end
		end
	end
end

Module.OnEnable = function(self)
	for event in pairs(rulesByEvent) do
		ChatFrame_AddMessageEventFilter(event, CleanLine)
	end
	for _, event in ipairs(PLAYER_CHAT) do
		ChatFrame_AddMessageEventFilter(event, HideEmptyLine)
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", HideChannelNotice)
end

-- Exposed for tests/test_chat_cleaner.lua.
Module.ToPattern = ToPattern
