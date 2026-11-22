-- The test realm's film wardrobe and stage (tools/realm): what you wear, as
-- others and the camera see it, without the items themselves (any class's
-- look), and the trailer's Lich King. Game masters only.
--   .angel        Tyrael's white and gold (Sanctified Lightsworn, no helm)
--   .angel off    your own items' look again
--   .film lk      the Lich King 16 yards ahead, a little to the left, facing you
--   .film clean   the GM-only helpers near you gone (a runeforge's bunny)
--   .film teleports  the Alliance's teleports and Death Gate (.cheat power on: no mana asked)
--   .film jeer    Stormwind turns on you as you walk (Where Kings Walk); .film jeer off
--   .film kaiju   Gymer on Stormwind, all of the above in one; .film kaiju off
--   .film phase   the city near you into your phase (Gymer's ride has its own)
--   .film war     the Alliance can be fought (your faction the Horde's); .film war off
--   .film draw    your sword out
--   .film strike  he attacks you, you him (the fight begins)
--   .film end     he's gone
local LOOK = {
	[2] = 51279, -- shoulders
	[4] = 51275, -- chest
	[6] = 51278, -- legs
	[9] = 51276, -- hands
}
local VISIBLE = 283 -- PLAYER_VISIBLE_ITEM_1_ENTRYID (3.3.5a); a slot's 2 fields on
local LICH_KING, FROSTMOURNE = 36597, 36942
local COMBO = { 49909, 49921, 51425, 55268, 49895 } -- Icy Touch, Plague Strike, Obliterate, Frost Strike, Death Coil (rank 80)
local TELEPORTS = { 3561, 3562, 3565, 32271, 49359, 33690, 53140, 50977 } -- Stormwind, Ironforge, Darnassus, Exodar, Theramore, Shattrath, Dalaran, Death Gate
local JEERS = { -- (yelled: what the Scarlet Enclave's death knights did, and what the city calls them)
	"Murderer! You burned Havenshire to the ground!",
	"You took my boy's head in New Avalon! He was nine!",
	"Whole families burned in their beds, and you walk our streets!",
	"Corpse-dwarf! Crawl back into your grave!",
	"Rotting stunty! Ironforge should bury you twice!",
	"Scourge maggot! Get out of the king's city!",
	"You stink of the plague cauldrons, bag of bones!",
	"How many children did you put to the sword, knight?",
	"You hanged the miners of Havenshire! I know that face!",
	"Light burn you, deadite!",
	"Children's heads on your pikes, and they let you through the gate?",
	"The Ebon Blade? The butcher's blade!",
	"Undead filth wearing a dwarf's beard!",
	"Shame on Ironforge for ever birthing you!",
	"You cut down New Avalon's square, mothers and babes alike!",
	"Go back to Acherus, walking carrion!",
	"Varian should hang you from the gate!",
	"You smell of the Plaguelands, rot-beard!",
	"Grave-worm! There's no blood left in you!",
	"You set the chapel alight with the people still praying!",
	"My brother rode to Light's Hope. Was it you who gutted him?",
	"Don't you look at me with those dead eyes!",
	"Lich King's lapdog! Your master's leash still shows!",
	"Butcher of farmers! Butcher of babes!",
	"Your kind poisoned the grain! Half my village died vomiting black!",
}
local GRIEF = { -- (said, in tears)
	"My daughter... my little girl... they never found her head...",
	"Light... why did you let them back in...",
	"They burned my mother in her house. She couldn't walk...",
	"Twelve children in the chapel at New Avalon... twelve...",
	"Please... just make it go away...",
}
local SPITS = { "spits at the death knight's feet.", "spits on the death knight.", "hawks and spits in the death knight's face." }
local SOUND = { laugh = { [0] = 6923, [1] = 6918 }, chicken = { [0] = 6919, [1] = 6914 }, cry = { [0] = 6921, [1] = 6916 } } -- (human male, female)
local THROWS = { 58509, 58513 } -- Rotten Apple Toss, Rotten Banana Toss (the original welcome)
local Pick = function(list) return list[math.random(#list)] end
local Voice = function(citizen, kind) citizen:PlayDistanceSound(SOUND[kind][citizen:GetGender() == 1 and 1 or 0]) end
local Act = function(citizen, player) -- (one of: insult, spit, throw, weep)
	citizen:SetFacingToObject(player)
	local roll = math.random(10)
	if roll <= 4 then
		citizen:PerformEmote(math.random(2) == 1 and 25 or 14) -- point, rude
		citizen:SendUnitYell(Pick(JEERS), 0)
		Voice(citizen, math.random(2) == 1 and "laugh" or "chicken")
	elseif roll <= 6 then
		citizen:PerformEmote(14)
		citizen:SendUnitEmote(Pick(SPITS), player)
	elseif roll <= 9 then
		citizen:CastSpell(player, Pick(THROWS), true)
		citizen:SendUnitYell(Pick(JEERS), 0)
	else
		citizen:PerformEmote(18) -- cry
		citizen:SendUnitSay(Pick(GRIEF), 0)
		Voice(citizen, "cry")
	end
end
local UNIT_FLAGS, UNIT_TARGET = 59, 18 -- UNIT_FIELD_FLAGS, UNIT_FIELD_TARGET (3.3.5a)

RegisterPlayerEvent(42, function(_, player, command) -- PLAYER_EVENT_ON_COMMAND
	local what = command:match("^angel%s*(%a*)$")
	if (not what) or not player or (player:GetGMRank() < 1) then
		return
	end
	for slot, entry in pairs(LOOK) do
		local own = player:GetEquippedItemBySlot(slot)
		local shown = (what == "off") and (own and own:GetEntry() or 0) or entry
		player:SetUInt32Value(VISIBLE + slot * 2, shown)
	end
	player:SendBroadcastMessage(what == "off" and "Your own look." or "The angel's look.")
	return false
end)

local Clear = function(player) -- (every one near: a reload of the scripts forgets them)
	for _, lk in ipairs(player:GetCreaturesInRange(300, LICH_KING, 0, 0) or {}) do -- (hostile or not, dead or alive)
		lk:DespawnOrUnsummon(0)
	end
end

local Has = function(mask, bit) return math.floor(mask / bit) % 2 == 1 end
local Phase = function(player) -- (Gymer's ride phases you out of the city: the city near you into yours too;
	-- what you ride never moved, a vehicle's phase changed under you stalls it)
	local mine = player:GetPhaseMask()
	local x, y, z, o = player:GetLocation()
	local probe = player:SpawnCreature(18721, x, y, z, o, 3, 2000) -- (an invisible trigger in every phase: a search
	if not probe then -- finds only its own phase's)
		return
	end
	probe:SetPhaseMask(4294967295, false)
	local near = probe:GetCreaturesInRange(60) or {}
	probe:DespawnOrUnsummon(0)
	for _, citizen in ipairs(near) do
		local theirs = citizen:GetPhaseMask()
		local add = 0
		for i = 0, 31 do
			local bit = 2 ^ i
			if Has(mine, bit) and not Has(theirs, bit) then
				add = add + bit
			end
		end
		if add > 0 then
			citizen:SetPhaseMask(theirs + add, true)
		end
	end
end
local GYMER = 29884
WorldDBExecute("INSERT IGNORE INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, Comment) VALUES (13, 1, 55516, 11, 24, 7, 'Gymer''s Grab: humanoids too (film.lua, Stormwind)')")
-- (Gymer's Grab took only the quest's Scourge; then .reload conditions: the insert is queued, not done here)
local jeered, jeering = {} -- (who shouted when; the running jeer's event)
local Jeer = function(_, _, _, player) -- (up to three not heard from in 20 s, each 3 s, in Stormwind)
	if player:GetZoneId() ~= 1519 then
		return
	end
	Phase(player)
	local gymer = player:GetNearestCreature(30, GYMER)
	if gymer and gymer:GetFaction() ~= 2 then
		gymer:SetFaction(2) -- (his is friendly to all: the Horde's, the city his foe)
	end
	local now, shouted = os.time(), 0
	for _, citizen in ipairs(player:GetCreaturesInRange(30) or {}) do
		local who = citizen:GetGUIDLow()
		if shouted < 3 and citizen:GetCreatureType() == 7 and now - (jeered[who] or 0) > 20 then -- (humanoids, the guards too)
			jeered[who], shouted = now, shouted + 1
			Act(citizen, player)
		end
	end
end

RegisterPlayerEvent(42, function(_, player, command)
	if command == "film kaiju off" then -- (Alliance again, mortal, a GM, the city quiet)
		player:SetFaction(3)
		player:RunCommand("cheat god off")
		player:RunCommand("gm on")
		if jeering then
			player:RemoveEventById(jeering)
			jeering = nil
		end
		return false
	end
	if command == "film war off" then -- (back to a dwarf's own: Ironforge)
		player:SetFaction(3)
		return false
	end
	if command == "film jeer off" and jeering then
		player:RemoveEventById(jeering)
		jeering = nil
		return false
	end
	local what = command:match("^film%s+(%a+)$")
	if (not what) or not player or (player:GetGMRank() < 1) then
		return
	end
	local lk = player:GetNearestCreature(300, LICH_KING)
	if what == "lk" then
		Clear(player)
		local x, y, z, o = player:GetLocation()
		local a = o + 0.45 -- (ahead, a little to the left: the diagonal, not one behind the other)
		x, y = x + 16 * math.cos(a), y + 16 * math.sin(a)
		o = (a + math.pi) % (2 * math.pi)
		lk = player:SpawnCreature(LICH_KING, x, y, z, o, 3, 600000) -- (TEMPSUMMON_TIMED_DESPAWN, 10 min)
		if not lk then -- (as .npc add temp spawns)
			lk = PerformIngameSpawn(1, LICH_KING, player:GetMapId(), player:GetInstanceId(), x, y, z, o, false, 600000, player:GetPhaseMask())
		end
		if lk then -- (his template's sword, missing on a spawn outside Icecrown)
			lk:SetEquipmentSlots(FROSTMOURNE, 0, 0)
			lk:SetSheath(1)
			lk:SetStandState(0)
		end
	elseif what == "strike" and lk then
		player:SetGameMaster(false) -- (a GM can't be attacked; off only now: he waits calm till here)
		lk:SetUInt32Value(UNIT_FLAGS, 0) -- (his template's: immune, passive outside Icecrown)
		lk:SetFaction(14)
		lk:SetInCombatWith(player)
		player:SetInCombatWith(lk)
		lk:AddThreat(player, 1000)
		lk:AttackStart(player)
		lk:MoveChase(player)
		player:SetUInt64Value(UNIT_TARGET, lk:GetGUID()) -- (his boss frame on Morgrim's screen)
		player:Attack(lk, true)
		player:SetFacingToObject(lk)
		for i, spell in ipairs(COMBO) do -- (one a second and a bit, his runes and range not asked)
			player:RegisterEvent(function(_, _, _, me)
				local target = me:GetNearestCreature(60, LICH_KING)
				if target then
					me:CastSpell(target, spell, true)
				end
			end, 300 + (i - 1) * 1300, 1)
		end
	elseif what == "teleports" then -- (a mage's, as any class can learn them; Death Gate)
		for _, spell in ipairs(TELEPORTS) do
			player:LearnSpell(spell)
		end
		player:AddItem(17031, 20) -- Rune of Teleportation
	elseif what == "jeer" then -- (Stormwind's welcome to a death knight, all through the city)
		jeering = jeering or player:RegisterEvent(Jeer, 3000, 0)
	elseif what == "kaiju" then -- (Gymer on Stormwind: at war, no GM, immortal, the city jeering)
		player:SetFaction(2)
		player:RunCommand("gm off")
		player:RunCommand("cheat god on")
		if not player:HasQuest(12919) then
			player:AddQuest(12919) -- The Storm King's Vengeance (Gymer's ride)
		end
		if player:GetZoneId() ~= 1519 then
			player:RunCommand("tele stormwind")
		end
		player:RegisterEvent(function(_, _, _, me) -- (after the loading screen)
			me:CastSpell(me, 55431, true) -- Summon Gymer
			jeering = jeering or me:RegisterEvent(Jeer, 3000, 0)
		end, 5000, 1)
	elseif what == "phase" then
		Phase(player)
	elseif what == "war" then -- (the Alliance's enemy: the Horde's faction; the race's again at login)
		player:SetFaction(2)
	elseif what == "draw" then
		player:SetSheath(1) -- (the melee weapon out)
	elseif what == "clean" then -- (the helpers a GM sees, out of the shot: they come back on their own)
		for _, helper in ipairs(player:GetCreaturesInRange(20) or {}) do
			if helper:GetName():find("Bunny") then
				helper:DespawnOrUnsummon(0)
			end
		end
	elseif what == "end" then
		Clear(player)
	end
	return false
end)
