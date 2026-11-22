-- The test realm's .ui (tools/realm): the windows only an NPC opens, opened
-- on you from the server, no walking. Its NPCs spawned beside you for a
-- few minutes (any found in the world's database). Game masters only.
--   .ui all       each in turn, a few seconds apart (for /dui layout)
--   .ui vendor | trainer | skill | auction | bank | mail | taxi | tabard | battle | arena
-- (a trainer's, a flight master's and a battlemaster's windows only open as
-- you right-click them: they're spawned in front of you for it)
local SECONDS = 6 -- each window's (the scan saves one shown half a second, its tabs one a second)
local GAP = 5 -- (from you, in yards)

-- (what it did, for whoever drives the test client: logs/ui.log)
local Log = function(line)
	local file = io.open("/azerothcore/env/dist/logs/ui.log", "a")
	if file then
		file:write(os.date("%H:%M:%S "), line, "\n")
		file:close()
	end
end

local First = function(query)
	local found = WorldDBQuery(query)
	return found and found:GetUInt32(0)
end

-- (each found once)
local Entries = {}
local Entry = function(key, query)
	if Entries[key] == nil then
		Entries[key] = First(query) or false
	end
	return Entries[key]
end

-- (the last one spawned gone first: one NPC at a time, in front of you, to right-click if need be)
local Last = {}
local Spawn = function(player, entry)
	local last = Last[player:GetGUIDLow()] and player:GetMap():GetWorldObject(Last[player:GetGUIDLow()])
	if last then
		last:DespawnOrUnsummon()
	end
	local x, y, z, o = player:GetLocation()
	local npc = entry
		and player:SpawnCreature(entry, x + GAP * math.cos(o), y + GAP * math.sin(o), z, o + math.pi, 3, 300000)
	Last[player:GetGUIDLow()] = npc and npc:GetGUID()
	return npc
end

-- its window sent once the client has the NPC (a trainer's list before it: dropped)
local Later = function(player, npc, send)
	if npc then
		local guid = npc:GetGUID()
		player:RegisterEvent(function(_, _, _, who)
			local found = who:GetMap():GetWorldObject(guid)
			Log(send .. (found and " sent" or ": its NPC gone"))
			if found then
				who[send](who, found)
			end
		end, 1500, 1)
	end
	return npc
end

local WINDOWS = {
	vendor = function(player)
		local npc = Spawn(
			player,
			Entry(
				"vendor",
				"SELECT v.entry FROM npc_vendor v JOIN creature_template c ON c.entry = v.entry"
					.. " GROUP BY v.entry HAVING COUNT(*) BETWEEN 16 AND 30 ORDER BY v.entry LIMIT 1"
			)
		)
		return Later(player, npc, "SendListInventory")
	end,
	trainer = function(player)
		local npc = Spawn(
			player,
			Entry(
				"trainer" .. player:GetClass(),
				"SELECT d.CreatureId FROM creature_default_trainer d"
					.. " JOIN trainer t ON t.Id = d.TrainerId WHERE t.Type = 0 AND t.Requirement = "
					.. player:GetClass()
					.. " LIMIT 1"
			)
		)
		return Later(player, npc, "SendTrainerList")
	end,
	skill = function(player) -- (a profession's trainer: tailoring)
		local npc = Spawn(
			player,
			Entry(
				"skill",
				"SELECT entry FROM creature_template WHERE subname = 'Tailoring Trainer' AND faction IN (12, 35) LIMIT 1"
			)
		)
		return Later(player, npc, "SendTrainerList")
	end,
	auction = function(player)
		local npc = Spawn(
			player,
			Entry(
				"auction",
				"SELECT entry FROM creature_template WHERE npcflag & 2097152 AND faction IN (12, 29, 35) ORDER BY faction = 35 DESC LIMIT 1"
			)
		)
		return Later(player, npc, "SendAuctionMenu")
	end,
	bank = function(player)
		local npc = Spawn(player, Entry("bank", "SELECT entry FROM creature_template WHERE npcflag & 131072 LIMIT 1"))
		return Later(player, npc, "SendShowBank")
	end,
	mail = function(player)
		player:SendShowMailBox()
		return true
	end,
	taxi = function(player)
		local npc = Spawn(player, Entry("taxi", "SELECT entry FROM creature_template WHERE npcflag & 8192 LIMIT 1"))
		return Later(player, npc, "SendTaxiMenu")
	end,
	battle = function(player) -- (no window from the server: right-click it, its gossip)
		return Spawn(
			player,
			Entry(
				"battle",
				"SELECT entry FROM creature_template WHERE npcflag & 1048576 AND faction IN (12, 35) AND subname NOT LIKE 'Arena%' LIMIT 1"
			)
		)
	end,
	arena = function(player) -- (right-click it too)
		return Spawn(
			player,
			Entry(
				"arena",
				"SELECT entry FROM creature_template WHERE npcflag & 1048576 AND faction IN (12, 35) AND subname LIKE 'Arena%' LIMIT 1"
			)
		)
	end,
	tabard = function(player)
		local npc = Spawn(
			player,
			Entry(
				"tabard",
				"SELECT entry FROM creature_template WHERE npcflag & 524288 AND faction IN (12, 35) LIMIT 1"
			)
		)
		return Later(player, npc, "SendTabardVendorActivate")
	end,
}
local ORDER = { "vendor", "trainer", "skill", "auction", "bank", "mail", "taxi", "tabard", "battle", "arena" }

local Open = function(player, what)
	local opened = WINDOWS[what](player)
	if type(opened) == "userdata" then
		Log(what .. ": " .. opened:GetName() .. " (" .. opened:GetEntry() .. ")")
	elseif not opened then
		Log(what .. ": no NPC in the database")
		player:SendBroadcastMessage("|cffe0a640.ui|r: no NPC for " .. what .. " in the database")
	end
end

RegisterPlayerEvent(42, function(_, player, command) -- PLAYER_EVENT_ON_COMMAND
	local what = command:match("^ui%s*(%a*)$")
	if (not what) or not player or (player:GetGMRank() < 1) then
		return
	end
	if what == "all" then
		for i, name in ipairs(ORDER) do
			player:RegisterEvent(function(_, _, _, who)
				Open(who, name)
			end, (i - 1) * SECONDS * 1000 + 1, 1)
		end
	elseif WINDOWS[what] then
		Open(player, what)
	else
		player:SendBroadcastMessage("|cffe0a640.ui|r all, " .. table.concat(ORDER, ", "))
	end
	return false
end)

-- what the test client says back: a "dui:" line said in chat, to logs/ui.log
-- (/run SendChatMessage("dui:" .. tostring(x), "SAY"))
RegisterPlayerEvent(18, function(_, player, message) -- PLAYER_EVENT_ON_CHAT
	if player:GetGMRank() > 0 and message:sub(1, 4) == "dui:" then
		Log("client: " .. message:sub(5))
		return false
	end
end)

-- .uisql <query>: the world database's first rows, to logs/ui.log (to find NPCs)
RegisterPlayerEvent(42, function(_, player, command)
	local query = command:match("^uisql%s+(.+)$")
	if (not query) or not player or (player:GetGMRank() < 1) then
		return
	end
	local rows = WorldDBQuery(query)
	local n = 0
	while rows and n < 10 do
		local cells = {}
		for i = 0, rows:GetColumnCount() - 1 do
			cells[#cells + 1] = tostring(rows:GetString(i))
		end
		Log("sql: " .. table.concat(cells, " | "))
		n = n + 1
		if not rows:NextRow() then
			break
		end
	end
	Log("sql: " .. n .. " rows")
	return false
end)
