-- The game API half of the fake WoW client (tests/mocks/client.lua): unit,
-- action, inventory, group, zone... functions, all answering from one
-- editable `world` table, so a test sets up a situation (a target at 30%
-- health casting a spell, an empty mana bar, a raid of 25) and the addon
-- sees exactly that.
--
-- Signatures and return values follow the 3.3.5a client, not later ones:
-- UnitGroupRolesAssigned returns three booleans, GetNetStats three numbers,
-- UnitAura has no nameplate or boss flags, and so on.

local Api = {}

------------------------------------------------------------------------
-- The world
------------------------------------------------------------------------

local CLASS_NAMES = {
	WARRIOR = "Warrior", PALADIN = "Paladin", HUNTER = "Hunter", ROGUE = "Rogue", PRIEST = "Priest",
	DEATHKNIGHT = "Death Knight", SHAMAN = "Shaman", MAGE = "Mage", WARLOCK = "Warlock", DRUID = "Druid",
}
Api.CLASS_NAMES = CLASS_NAMES

local POWER_TYPES = {
	WARRIOR = 1, ROGUE = 3, DEATHKNIGHT = 6, HUNTER = 0, PALADIN = 0, PRIEST = 0, SHAMAN = 0,
	MAGE = 0, WARLOCK = 0, DRUID = 0,
}
local POWER_TOKENS = { [0] = "MANA", [1] = "RAGE", [2] = "FOCUS", [3] = "ENERGY", [4] = "HAPPINESS", [5] = "RUNES", [6] = "RUNIC_POWER" }

local guidSerial = 0

-- A unit, with every field the unit API reads. `fields` overrides any.
function Api.newUnit(fields)
	fields = fields or {}
	guidSerial = guidSerial + 1
	local class = fields.class or "WARRIOR"
	local powerType = fields.powerType or POWER_TYPES[class] or 0
	local unit = {
		guid = string.format("0x%016X", guidSerial),
		name = "Unit" .. guidSerial,
		realm = nil,
		class = class,
		level = 80,
		race = "Human", raceFile = "Human",
		sex = 2,
		classification = "normal",
		creatureType = "Humanoid",
		creatureFamily = nil,
		isPlayer = true,
		health = 10000, healthMax = 10000,
		powerType = powerType,
		power = powerType == 1 and 0 or 5000,
		powerMax = (powerType == 1 or powerType == 6) and 100 or (powerType == 3 and 100 or 5000),
		dead = false, ghost = false, connected = true, visible = true,
		reaction = 5, faction = "Alliance",
		canAttack = false, isEnemy = false, isFriend = true,
		tapped = false, tappedByPlayer = false, tappedByAll = false,
		playerControlled = true,
		pvp = false, ffa = false, afk = false, dnd = false,
		possessed = false, charmed = false,
		hasVehicleUI = false, inVehicle = false,
		inRange = true,
		role = nil, -- "TANK", "HEALER", "DAMAGER"
		onTaxi = false,
		combat = false,
		auras = {},
		casting = nil, channeling = nil,
		target = nil,
		threat = nil,
		raidTarget = nil,
		pvpName = nil,
		comboPoints = 0,
	}
	for key, value in pairs(fields) do
		unit[key] = value
	end
	if fields.name == nil then
		unit.name = unit.isPlayer and ("Player" .. guidSerial) or ("Creature" .. guidSerial)
	end
	return unit
end

-- A fresh world: a level 80 character of `class`, alone, out of combat,
-- in Stormwind, with a full action bar.
function Api.newWorld(class)
	class = class or "WARRIOR"
	local world = {
		time = 1000,
		gameTime = { 12, 30 },
		inCombat = false,
		loggedIn = false,
		realm = "ChromieCraft",
		locale = "enUS",
		money = 1234567,
		xp = 1000, xpMax = 5000, exhaustion = 2000, restState = 1, resting = false,
		maxLevel = 80,
		watchedFaction = nil, -- { name, standing, min, max, value }
		units = {},
		actions = {},
		bonusBarOffset = 0,
		actionBarPage = 1,
		forms = {}, -- { texture, name, active, castable, cooldown }
		petActions = {}, -- [slot] = { name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled }
		petActionsUsable = true,
		containers = { [0] = { size = 16, items = {} } },
		inventory = {}, -- [slot] = link
		durability = {}, -- [slot] = { cur, max }
		loot = {}, -- { texture, name, quantity, quality, locked, isCoin, link, looted }
		zone = { zone = "Stormwind City", subzone = "Trade District", minimap = "Trade District", pvpType = "sanctuary", faction = nil },
		instance = { inInstance = nil, type = "none", name = "", difficulty = 1, maxPlayers = 0 },
		worldStates = {}, -- { uiType, state, text, icon, dynamicIcon, tooltip, dynamicTooltip, extendedUI, extended1, extended2, extended3 }
		cvars = {
			lockActionBars = "1", alwaysShowActionBars = "0",
			uiScale = "1", useUiScale = "0", gxResolution = "1920x1080", gxWindow = "0", gxMaximize = "1",
			chatBubbles = "1", chatBubblesParty = "1", chatStyle = "classic", conversationMode = "inline",
			chatMouseScroll = "1", showTimestamps = "none", cameraDistanceMax = "15",
			cameraDistanceMaxFactor = "1", timeMgrUseLocalTime = "0", timeMgrUseMilitaryTime = "0",
			showToastWindow = "0", screenshotQuality = "3", autoLootDefault = "0", Sound_EnableAllSound = "1",
			showNewbieTips = "0", showTutorials = "0", showQuestTrackingTooltips = "1", nameplateShowEnemies = "1",
			nameplateShowFriends = "0", UnitNameOwn = "0", ShowClassColorInNameplate = "1", rotateMinimap = "0",
			bloatthreat = "0", bloattest = "0", bloatnameplates = "0", spreadnameplates = "1",
			scriptErrors = "0", taintLog = "0", enableCombatText = "1", CombatDamage = "1", CombatHealing = "1",
			fctSpellMechanics = "0", consolidateBuffs = "0", buffDurations = "1", showPartyBackground = "0",
			hidePartyInRaid = "1", showArenaEnemyFrames = "1", showRaidRange = "0", fullSizeFocusFrame = "0",
			threatWarning = "3", threatShowNumeric = "0", displayFreeBagSlots = "1", xpBarText = "0",
			statusBarText = "0", showTargetOfTarget = "1", targetOfTargetMode = "5", combatTextFloatMode = "1",
			mapQuestDifficulty = "1", profanityFilter = "0", colorblindMode = "0", movieSubtitle = "0",
			Sound_EnableMusic = "1", guildMemberNotify = "1", showLootSpam = "1", lootUnderMouse = "0",
		},
		bindings = {}, -- [action] = { key1, key2 }
		overrideBindings = {},
		addons = {}, -- { name, title, notes, enabled, loadable, reason, loaded }
		friends = {}, -- { name, level, class, area, connected, status, note }
		guild = nil, -- { name, members = { {name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFile} } }
		talentGroup = 1,
		talents = { { "Arms", "", 0 }, { "Fury", "", 0 }, { "Protection", "", 0 } },
		runes = {}, -- [1..6] = { start, duration, ready, type }
		totems = {}, -- [1..4] = { name, start, duration, icon }
		mirrorTimers = {}, -- [1..3] = { timer, value, maxvalue, scale, paused, label }
		mail = false, mailSenders = {},
		mounted = false, flying = false, swimming = false, stealthed = false,
		taxi = false,
		modifiers = { shift = false, ctrl = false, alt = false },
		cursor = { 960, 540 },
		framerate = 60,
		latency = 45,
		facing = 0,
		quests = {}, -- { title, level, tag, group, isHeader, collapsed, complete, daily, id, objectives = { {text, type, finished} }, watched }
		achievements = {},
		weaponEnchants = { false, 0, 0, false, 0, 0 },
		comboPoints = 0,
		inspectReady = true,
		titles = {},
		spells = {},
		itemInfo = {}, -- [itemId] = { name, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice, stats }
		screen = { 1920, 1080 },
		expansion = 2,
		noShaders = false, -- a graphics card without shaders: textures can't be desaturated
		trackingTypes = {},
		lfgStatus = nil,
		battlefields = {},
	}
	local player = Api.newUnit({ class = class, name = "Tester", isPlayer = true, faction = "Alliance" })
	player.combat = false
	world.units.player = player
	for slot = 1, 12 do
		world.actions[slot] = {
			type = "spell", id = 100 + slot, name = "Spell " .. slot,
			texture = "Interface\\Icons\\Spell_" .. slot, count = 0,
			cooldown = { 0, 0, 1 }, usable = true, noMana = false, inRange = 1, hasRange = true,
		}
	end
	for bag = 1, 4 do
		world.containers[bag] = { size = 16, items = {} }
	end
	return world
end

------------------------------------------------------------------------
-- The functions
------------------------------------------------------------------------

function Api.install(client)
	local api = {}
	Api.client = client

	local function world()
		return client.world
	end

	-- "target", "PARTY1", "targettarget", "party2pettarget", "mouseover" ->
	-- the unit table, or nil when nobody is there.
	local function resolve(unit)
		if type(unit) ~= "string" then
			return nil
		end
		unit = unit:lower()
		local units = world().units
		local direct = units[unit]
		if direct then
			return direct
		end
		if unit == "vehicle" then
			return units.player and units.player.vehicle
		end
		local base = unit:match("^(.-)target$")
		if base and base ~= "" then
			local owner = resolve(base)
			local target = owner and owner.target
			if type(target) == "string" then
				return resolve(target)
			end
			return target
		end
		local owner = unit:match("^(party%d)pet$") or unit:match("^(raid%d+)pet$")
		if owner then
			local data = resolve(owner)
			return data and data.pet
		end
		return nil
	end
	api.resolveUnit = resolve

	local function has(unit)
		return resolve(unit) ~= nil
	end

	local function flag(value)
		return value and 1 or nil
	end

	api.UnitExists = function(unit) return flag(has(unit)) end
	api.UnitGUID = function(unit)
		local u = resolve(unit)
		return u and u.guid
	end
	api.UnitName = function(unit)
		local u = resolve(unit)
		if u then
			return u.name, u.realm
		end
	end
	api.UnitPVPName = function(unit)
		local u = resolve(unit)
		return u and (u.pvpName or u.name)
	end
	api.UnitClass = function(unit)
		local u = resolve(unit)
		if u then
			return CLASS_NAMES[u.class] or u.class, u.class
		end
	end
	api.UnitRace = function(unit)
		local u = resolve(unit)
		if u then
			return u.race, u.raceFile
		end
	end
	api.UnitSex = function(unit)
		local u = resolve(unit)
		return u and u.sex
	end
	api.UnitLevel = function(unit)
		local u = resolve(unit)
		return u and u.level or 0
	end
	api.UnitClassification = function(unit)
		local u = resolve(unit)
		return u and u.classification
	end
	api.UnitCreatureType = function(unit)
		local u = resolve(unit)
		return u and u.creatureType
	end
	api.UnitCreatureFamily = function(unit)
		local u = resolve(unit)
		return u and u.creatureFamily
	end
	api.UnitIsPlayer = function(unit)
		local u = resolve(unit)
		return flag(u and u.isPlayer)
	end
	api.UnitPlayerControlled = function(unit)
		local u = resolve(unit)
		return flag(u and u.playerControlled)
	end
	api.UnitHealth = function(unit)
		local u = resolve(unit)
		return u and u.health or 0
	end
	api.UnitHealthMax = function(unit)
		local u = resolve(unit)
		return u and u.healthMax or 0
	end
	api.UnitPowerType = function(unit)
		local u = resolve(unit)
		if u then
			return u.powerType, POWER_TOKENS[u.powerType]
		end
		return 0, "MANA"
	end
	api.UnitPower = function(unit, powerType)
		local u = resolve(unit)
		if not u then return 0 end
		if powerType == nil or powerType == u.powerType then
			return u.power
		end
		return u.powers and u.powers[powerType] or 0
	end
	api.UnitPowerMax = function(unit, powerType)
		local u = resolve(unit)
		if not u then return 0 end
		if powerType == nil or powerType == u.powerType then
			return u.powerMax
		end
		return u.powersMax and u.powersMax[powerType] or 0
	end
	api.UnitMana = function(unit) return api.UnitPower(unit) end
	api.UnitManaMax = function(unit) return api.UnitPowerMax(unit) end
	api.UnitIsDead = function(unit)
		local u = resolve(unit)
		return flag(u and u.dead)
	end
	api.UnitIsGhost = function(unit)
		local u = resolve(unit)
		return flag(u and u.ghost)
	end
	api.UnitIsDeadOrGhost = function(unit)
		local u = resolve(unit)
		return flag(u and (u.dead or u.ghost))
	end
	api.UnitIsConnected = function(unit)
		local u = resolve(unit)
		return flag(u and u.connected)
	end
	api.UnitIsVisible = function(unit)
		local u = resolve(unit)
		return flag(u and u.visible)
	end
	api.UnitIsAFK = function(unit)
		local u = resolve(unit)
		return flag(u and u.afk)
	end
	api.UnitIsDND = function(unit)
		local u = resolve(unit)
		return flag(u and u.dnd)
	end
	api.UnitIsPVP = function(unit)
		local u = resolve(unit)
		return flag(u and u.pvp)
	end
	api.UnitIsPVPFreeForAll = function(unit)
		local u = resolve(unit)
		return flag(u and u.ffa)
	end
	api.UnitIsPVPSanctuary = function() return nil end
	api.UnitFactionGroup = function(unit)
		local u = resolve(unit)
		if u and u.faction then
			return u.faction, u.faction
		end
	end
	api.UnitReaction = function(unit, other)
		local u = resolve(unit)
		local o = resolve(other)
		if u and o then
			if u == o then return 5 end
			local npc = (u ~= world().units.player) and u or o
			return npc.reaction or nil -- false: an object without a reaction
		end
	end
	api.UnitCanAttack = function(unit, other)
		local u, o = resolve(unit), resolve(other)
		if not (u and o) or u == o then return nil end
		local npc = (u ~= world().units.player) and u or o
		return flag(npc.canAttack)
	end
	api.UnitCanAssist = function(unit, other)
		local u, o = resolve(unit), resolve(other)
		if not (u and o) then return nil end
		if u == o then return 1 end
		local npc = (u ~= world().units.player) and u or o
		return flag(not npc.canAttack)
	end
	api.UnitCanCooperate = api.UnitCanAssist
	api.UnitIsEnemy = function(unit, other)
		local u, o = resolve(unit), resolve(other)
		if not (u and o) or u == o then return nil end
		local npc = (u ~= world().units.player) and u or o
		return flag(npc.isEnemy)
	end
	api.UnitIsFriend = function(unit, other)
		local u, o = resolve(unit), resolve(other)
		if not (u and o) then return nil end
		if u == o then return 1 end
		local npc = (u ~= world().units.player) and u or o
		return flag(npc.isFriend)
	end
	api.UnitIsTapped = function(unit)
		local u = resolve(unit)
		return flag(u and u.tapped)
	end
	api.UnitIsTappedByPlayer = function(unit)
		local u = resolve(unit)
		return flag(u and u.tappedByPlayer)
	end
	api.UnitIsTappedByAllThreatList = function(unit)
		local u = resolve(unit)
		return flag(u and u.tappedByAll)
	end
	api.UnitIsUnit = function(a, b)
		local ua, ub = resolve(a), resolve(b)
		return flag(ua and ub and ua == ub)
	end
	api.UnitIsPossessed = function(unit)
		local u = resolve(unit)
		return flag(u and u.possessed)
	end
	api.UnitIsCharmed = function(unit)
		local u = resolve(unit)
		return flag(u and u.charmed)
	end
	api.UnitIsTrivial = function() return nil end
	api.UnitIsInMyGuild = function(unit)
		local u = resolve(unit)
		return flag(u and u.inMyGuild)
	end
	api.UnitHasVehicleUI = function(unit)
		local u = resolve(unit)
		return flag(u and u.hasVehicleUI)
	end
	api.UnitInVehicle = function(unit)
		local u = resolve(unit)
		return flag(u and u.inVehicle)
	end
	api.UnitUsingVehicle = api.UnitInVehicle
	api.UnitControllingVehicle = api.UnitInVehicle
	api.UnitVehicleSkin = function() return nil end
	api.UnitVehicleSeatCount = function() return 0 end
	api.UnitVehicleSeatInfo = function() return nil end
	api.CanExitVehicle = function()
		return flag(world().units.player.inVehicle)
	end
	api.VehicleExit = function()
		local player = world().units.player
		player.inVehicle, player.hasVehicleUI, player.vehicle = false, false, nil
	end
	api.GetVehicleUIIndicator = function() return "Interface\\Vehicles\\SeatIndicator\\Vehicle", 2 end
	api.GetVehicleUIIndicatorSeat = function(_, i) return i, 0.5, i / 3 end
	api.UnitOnTaxi = function(unit)
		local u = resolve(unit)
		return flag(u and u.onTaxi)
	end
	api.TaxiRequestEarlyLanding = function() world().units.player.landingRequested = true end
	api.UnitAffectingCombat = function(unit)
		local u = resolve(unit)
		if u == world().units.player then
			return flag(world().inCombat)
		end
		return flag(u and u.combat)
	end
	api.InCombatLockdown = function() return flag(world().inCombat) end
	api.UnitInParty = function(unit)
		local u = resolve(unit)
		if not u then return nil end
		if u == world().units.player then return 1 end
		for i = 1, 4 do
			if world().units["party" .. i] == u then return 1 end
		end
	end
	api.UnitInRaid = function(unit)
		local u = resolve(unit)
		if not u then return nil end
		for i = 1, 40 do
			if world().units["raid" .. i] == u then return i - 1 end
		end
	end
	api.UnitPlayerOrPetInParty = api.UnitInParty
	api.UnitPlayerOrPetInRaid = function(unit) return api.UnitInRaid(unit) and 1 or nil end
	api.UnitIsPartyLeader = function(unit)
		local u = resolve(unit)
		return flag(u and u.leader)
	end
	api.UnitIsRaidOfficer = function(unit)
		local u = resolve(unit)
		return flag(u and u.assistant)
	end
	api.IsPartyLeader = function() return flag(world().units.player.leader) end
	api.IsRaidLeader = api.IsPartyLeader
	api.IsRaidOfficer = function() return flag(world().units.player.assistant) end
	api.GetPartyLeaderIndex = function()
		for i = 1, 4 do
			local u = world().units["party" .. i]
			if u and u.leader then return i end
		end
		return 0
	end
	api.GetRealNumPartyMembers = function() return api.GetNumPartyMembers() end
	api.GetRealNumRaidMembers = function() return api.GetNumRaidMembers() end
	api.GetNumPartyMembers = function()
		local count = 0
		for i = 1, 4 do
			if world().units["party" .. i] then count = count + 1 end
		end
		return count
	end
	api.GetNumRaidMembers = function()
		local count = 0
		for i = 1, 40 do
			if world().units["raid" .. i] then count = count + 1 end
		end
		return count
	end
	-- world.lootMethod = { method, partyID, raidID } (partyID 0: the player)
	api.GetLootMethod = function()
		local loot = world().lootMethod
		if loot then
			return loot[1], loot[2], loot[3]
		end
		return "group"
	end
	api.GetRaidRosterInfo = function(index)
		local u = world().units["raid" .. index]
		if u then
			return u.name, u.rank or 0, u.subgroup or math.floor((index - 1) / 5) + 1, u.level,
				CLASS_NAMES[u.class], u.class, "Icecrown Citadel", u.connected and 1 or nil,
				u.dead and 1 or nil, u.raidRole, u.masterLooter
		end
	end
	api.UnitGroupRolesAssigned = function(unit)
		local u = resolve(unit)
		local role = u and u.role
		return role == "TANK", role == "HEALER", role == "DAMAGER"
	end
	api.GetLFGRoles = function() return false, false, true, true end
	api.UnitThreatSituation = function(unit, mob)
		local u = resolve(unit)
		return u and u.threat
	end
	api.UnitDetailedThreatSituation = function(unit, mob)
		local u = resolve(unit)
		if u and u.threat then
			return u.threat >= 2 and 1 or nil, u.threat, 100, 100, 1000
		end
	end
	api.GetThreatStatusColor = function(status)
		local colors = { [0] = { 0.69, 0.69, 0.69 }, { 1, 1, 0.47 }, { 1, 0.6, 0 }, { 1, 0, 0 } }
		local c = colors[status] or colors[0]
		return c[1], c[2], c[3]
	end
	api.UnitIsUnitInRange = nil
	api.UnitInRange = function(unit)
		local u = resolve(unit)
		return flag(u and u.inRange), 1
	end
	api.CheckInteractDistance = function(unit)
		local u = resolve(unit)
		return flag(u and u.inRange)
	end
	api.GetRaidTargetIndex = function(unit)
		local u = resolve(unit)
		return u and u.raidTarget
	end
	api.SetRaidTarget = function(unit, index)
		local u = resolve(unit)
		if u then u.raidTarget = index end
	end
	api.SetPortraitTexture = function(texture, unit)
		texture:SetTexture("Portrait:" .. tostring(api.UnitName(unit)))
	end
	api.GetComboPoints = function(unit, target)
		return world().comboPoints or 0
	end
	api.UnitXP = function() return world().xp end
	api.UnitXPMax = function() return world().xpMax end
	api.GetXPExhaustion = function() return world().exhaustion end
	api.GetRestState = function()
		local rs = world().restState
		return rs, rs == 1 and "Rested" or "Normal", rs == 1 and 2 or 1
	end
	api.IsResting = function() return flag(world().resting) end
	-- (nothing in a real 3.3.5 client, as far as we know, unless a test sets it)
	api.GetTimeToWellRested = function() return world().timeToWellRested end
	api.IsXPUserDisabled = function() return nil end
	api.GetWatchedFactionInfo = function()
		local f = world().watchedFaction
		if f then
			return f.name, f.standing, f.min, f.max, f.value, f.id
		end
	end
	api.GetMoney = function() return world().money end

	-- Auras -----------------------------------------------------------------

	local function auraMatches(aura, filter)
		filter = filter or "HELPFUL"
		local harmful = filter:find("HARMFUL") ~= nil
		if (aura.harmful and true or false) ~= harmful then
			return false
		end
		if filter:find("PLAYER") and not (aura.caster == "player" or aura.caster == "pet" or aura.caster == "vehicle") then
			return false
		end
		if filter:find("RAID") and not aura.raid then
			return false
		end
		if filter:find("CANCELABLE") and aura.notCancelable then
			return false
		end
		return true
	end

	api.UnitAura = function(unit, index, filter)
		local u = resolve(unit)
		if not u then return nil end
		if type(index) == "string" then
			for _, aura in ipairs(u.auras) do
				if aura.name == index and auraMatches(aura, filter) then
					return api.auraReturns(aura)
				end
			end
			return nil
		end
		local n = 0
		for _, aura in ipairs(u.auras) do
			if auraMatches(aura, filter) then
				n = n + 1
				if n == index then
					return api.auraReturns(aura)
				end
			end
		end
	end
	function api.auraReturns(aura)
		return aura.name, aura.rank or "", aura.icon or "Interface\\Icons\\Aura", aura.count or 0,
			aura.debuffType, aura.duration or 0, aura.expires or 0, aura.caster,
			aura.stealable and 1 or nil, aura.consolidate and 1 or nil, aura.spellId or 1
	end
	api.UnitBuff = function(unit, index, filter)
		return api.UnitAura(unit, index, "HELPFUL" .. (filter and ("|" .. filter) or ""))
	end
	api.UnitDebuff = function(unit, index, filter)
		return api.UnitAura(unit, index, "HARMFUL" .. (filter and ("|" .. filter) or ""))
	end
	api.CancelUnitBuff = function(unit, index, filter)
		local u = resolve(unit)
		if u then u.cancelled = index end
	end
	api.GetWeaponEnchantInfo = function() return unpack(world().weaponEnchants) end

	-- Casting ---------------------------------------------------------------

	api.UnitCastingInfo = function(unit)
		local u = resolve(unit)
		local c = u and u.casting
		if c then
			return c.name, c.subtext or "", c.text or c.name, c.texture or "Interface\\Icons\\Spell",
				c.startTime, c.endTime, c.tradeSkill, c.castID or 1, c.notInterruptible
		end
	end
	api.UnitChannelInfo = function(unit)
		local u = resolve(unit)
		local c = u and u.channeling
		if c then
			return c.name, c.subtext or "", c.text or c.name, c.texture or "Interface\\Icons\\Spell",
				c.startTime, c.endTime, c.tradeSkill, c.notInterruptible
		end
	end

	-- Actions ---------------------------------------------------------------

	local function action(slot)
		return world().actions[slot]
	end
	api.HasAction = function(slot) return flag(action(slot)) end
	api.GetActionTexture = function(slot)
		local a = action(slot)
		return a and a.texture
	end
	api.GetActionInfo = function(slot)
		local a = action(slot)
		if a then
			return a.type, a.id, a.subType
		end
	end
	api.GetActionCount = function(slot)
		local a = action(slot)
		return a and a.count or 0
	end
	api.GetActionCooldown = function(slot)
		local a = action(slot)
		if a and a.cooldown then
			return a.cooldown[1], a.cooldown[2], a.cooldown[3]
		end
		return 0, 0, 0
	end
	api.IsUsableAction = function(slot)
		local a = action(slot)
		if not a then return nil, nil end
		return flag(a.usable), flag(a.noMana)
	end
	api.IsActionInRange = function(slot)
		local a = action(slot)
		return a and a.inRange
	end
	api.ActionHasRange = function(slot)
		local a = action(slot)
		return flag(a and a.hasRange)
	end
	api.IsCurrentAction = function(slot)
		local a = action(slot)
		return flag(a and a.current)
	end
	api.IsAutoRepeatAction = function(slot)
		local a = action(slot)
		return flag(a and a.autoRepeat)
	end
	api.IsAttackAction = function(slot)
		local a = action(slot)
		return flag(a and a.attack)
	end
	api.IsEquippedAction = function(slot)
		local a = action(slot)
		return flag(a and a.equipped)
	end
	api.IsConsumableAction = function(slot)
		local a = action(slot)
		return flag(a and a.consumable)
	end
	api.IsStackableAction = function(slot)
		local a = action(slot)
		return flag(a and a.stackable)
	end
	api.GetActionText = function(slot)
		local a = action(slot)
		return a and a.text
	end
	api.GetBonusBarOffset = function() return world().bonusBarOffset end
	api.GetActionBarPage = function() return world().actionBarPage end
	api.ChangeActionBarPage = function(page) world().actionBarPage = page end
	api.GetActionBarToggles = function() return 1, 1, 1, 1 end
	api.SetActionBarToggles = function(...) world().barToggles = { ... } end
	api.PickupAction = function(slot) world().cursorAction = slot end
	api.PlaceAction = function(slot) world().cursorAction = nil end
	api.GetMacroSpell = function(id) return nil end
	api.GetMacroItem = function(id) return nil end
	-- world.macros = { [index] = { name, icon, body } }: account macros at
	-- 1-36, character ones from 37. Without it, every macro is the same one.
	api.GetMacroInfo = function(id)
		local macros = world().macros
		if not macros then
			return "Macro", "Interface\\Icons\\Macro", "/cast Spell"
		end
		if type(id) == "string" then
			id = api.GetMacroIndexByName(id)
		end
		local macro = macros[id]
		if macro then
			return macro[1], macro[2], macro[3], id > 36 and 1 or nil
		end
	end
	api.GetMacroIndexByName = function(name)
		for index, macro in pairs(world().macros or {}) do
			if macro[1] == name then
				return index
			end
		end
		return 0
	end
	api.CreateMacro = function(name, iconIndex, body, perCharacter)
		local macros = world().macros or {}
		world().macros = macros
		local index = perCharacter and 37 or 1
		while macros[index] do
			index = index + 1
		end
		macros[index] = { name, "Interface\\Icons\\INV_Misc_QuestionMark", body }
		return index
	end
	api.GetPossessInfo = function(i) return "Interface\\Icons\\Possess", "Possess", 1 end
	api.IsPossessBarVisible = function() return nil end
	api.GetPetActionInfo = function(slot)
		local a = world().petActions[slot]
		if a then
			return a.name, a.subtext, a.texture, a.isToken, a.isActive, a.autoCastAllowed, a.autoCastEnabled
		end
	end
	api.GetPetActionCooldown = function(slot)
		local a = world().petActions[slot]
		if a and a.cooldown then
			return a.cooldown[1], a.cooldown[2], a.cooldown[3]
		end
		return 0, 0, 0
	end
	api.GetPetActionsUsable = function() return flag(world().petActionsUsable) end
	api.GetPetActionSlotUsable = function() return 1 end
	api.PetHasActionBar = function() return flag(next(world().petActions)) end
	api.HasPetUI = function()
		return flag(world().units.pet), world().units.pet and world().units.pet.isHunterPet
	end
	api.GetPetHappiness = function() return 3, 0, 0 end
	api.PetCanBeAbandoned = function() return 1 end
	api.GetNumShapeshiftForms = function() return #world().forms end
	api.GetShapeshiftFormInfo = function(index)
		local f = world().forms[index]
		if f then
			return f.texture, f.name, flag(f.active), flag(f.castable ~= false)
		end
	end
	api.GetShapeshiftForm = function()
		for index, f in ipairs(world().forms) do
			if f.active then return index end
		end
		return 0
	end
	api.GetShapeshiftFormCooldown = function(index)
		local f = world().forms[index]
		if f and f.cooldown then
			return f.cooldown[1], f.cooldown[2], f.cooldown[3]
		end
		return 0, 0, 0
	end

	-- Spells and items --------------------------------------------------------

	api.GetSpellInfo = function(spell)
		if spell == nil then return nil end
		local info = world().spells[spell]
		if info then
			return info.name, info.rank or "", info.icon or "Interface\\Icons\\Spell", info.cost or 0,
				nil, info.powerType or 0, info.castTime or 0, 0, 40
		end
		if type(spell) == "number" then
			return "Spell" .. spell, "", "Interface\\Icons\\Spell" .. spell, 0, nil, 0, 1500, 0, 40
		end
		return spell, "", "Interface\\Icons\\Spell", 0, nil, 0, 1500, 0, 40
	end
	api.GetSpellTexture = function(spell) return select(3, api.GetSpellInfo(spell)) end
	api.GetSpellCooldown = function() return 0, 0, 1 end
	api.IsSpellKnown = function(id) return world().spells[id] ~= nil end
	api.IsUsableSpell = function() return 1, nil end
	api.IsSpellInRange = function() return 1 end
	api.GetSpellLink = function(spell) return "|cff71d5ff|Hspell:" .. tostring(spell) .. "|h[" .. tostring(spell) .. "]|h|r" end

	local function itemIdOf(item)
		if type(item) == "number" then return item end
		if type(item) == "string" then
			return tonumber(item:match("item:(%d+)")) or tonumber(item)
		end
	end
	api.itemIdOf = itemIdOf
	api.GetItemInfo = function(item)
		local id = itemIdOf(item)
		local info = id and world().itemInfo[id]
		if not info then
			if type(item) == "string" and not id then
				-- by name
				for itemId, data in pairs(world().itemInfo) do
					if data.name == item then
						return api.GetItemInfo(itemId)
					end
				end
			end
			return nil
		end
		local link = info.link or string.format("|cffa335ee|Hitem:%d:0:0:0:0:0:0:0:80|h[%s]|h|r", id, info.name)
		return info.name, link, info.quality or 1, info.iLevel or 200, info.reqLevel or 80,
			info.class or "Armor", info.subclass or "Plate", info.maxStack or 1, info.equipSlot or "",
			info.texture or "Interface\\Icons\\Item", info.vendorPrice or 0
	end
	api.GetItemIcon = function(item) return select(10, api.GetItemInfo(item)) end
	api.GetItemCount = function() return 1 end
	api.GetItemCooldown = function() return 0, 0, 1 end
	api.GetItemStats = function(link, t)
		local id = itemIdOf(link)
		local info = id and world().itemInfo[id]
		local stats = t or {}
		for key, value in pairs(info and info.stats or {}) do
			stats[key] = value
		end
		return stats
	end
	api.GetItemQualityColor = function(quality)
		local colors = {
			[0] = { 0.62, 0.62, 0.62, "ff9d9d9d" }, { 1, 1, 1, "ffffffff" }, { 0.12, 1, 0, "ff1eff00" },
			{ 0, 0.44, 0.87, "ff0070dd" }, { 0.64, 0.21, 0.93, "ffa335ee" }, { 1, 0.5, 0, "ffff8000" },
			{ 0.9, 0.8, 0.5, "ffe6cc80" }, { 0.9, 0.8, 0.5, "ffe6cc80" },
		}
		local c = colors[quality] or colors[1]
		return c[1], c[2], c[3], "|c" .. c[4]
	end
	api.IsEquippableItem = function() return 1 end
	api.IsEquippedItem = function() return nil end
	api.GetInventoryItemLink = function(unit, slot)
		if resolve(unit) == world().units.player then
			return world().inventory[slot]
		end
		local u = resolve(unit)
		return u and u.inventory and u.inventory[slot]
	end
	api.GetInventoryItemTexture = function(unit, slot)
		-- known from the inventory itself, even before the item is cached
		local link = api.GetInventoryItemLink(unit, slot)
		if not link then
			-- an inspected unit whose item links haven't arrived yet
			local u = resolve(unit)
			return u and u.inventoryTextures and u.inventoryTextures[slot]
		end
		return select(10, api.GetItemInfo(link)) or "Interface\\Icons\\INV_Misc_QuestionMark"
	end
	api.GetInventoryItemID = function(unit, slot) return itemIdOf(api.GetInventoryItemLink(unit, slot)) end
	api.GetInventoryItemDurability = function(slot)
		local d = world().durability[slot]
		if d then return d[1], d[2] end
	end
	api.GetInventoryAlertStatus = function(slot)
		local d = world().durability[slot]
		if d and d[2] > 0 then
			if d[1] == 0 then return 2 end
			if d[1] / d[2] < 0.25 then return 1 end
		end
		return 0
	end
	api.GetInventorySlotInfo = function(name) return 1, "Interface\\PaperDoll\\UI-PaperDoll-Slot-Head" end
	api.GetContainerNumSlots = function(bag)
		local c = world().containers[bag]
		return c and c.size or 0
	end
	api.GetContainerNumFreeSlots = function(bag)
		local c = world().containers[bag]
		if not c then return 0, 0 end
		local used = 0
		for _ in pairs(c.items) do used = used + 1 end
		return c.size - used, 0
	end
	api.GetContainerItemInfo = function(bag, slot)
		local c = world().containers[bag]
		local item = c and c.items[slot]
		if item then
			return item.texture or "Interface\\Icons\\Item", item.count or 1, item.locked, item.quality or 1,
				item.readable, item.lootable, item.link
		end
	end
	api.GetContainerItemLink = function(bag, slot)
		local c = world().containers[bag]
		local item = c and c.items[slot]
		return item and item.link
	end
	api.GetContainerItemID = function(bag, slot) return itemIdOf(api.GetContainerItemLink(bag, slot)) end
	api.GetContainerItemQuestInfo = function(bag, slot)
		local c = world().containers[bag]
		local item = c and c.items[slot]
		if item then
			return item.isQuestItem, item.questId, item.isActive
		end
	end
	api.GetContainerItemCooldown = function() return 0, 0, 1 end
	api.GetBagName = function(bag) return world().containers[bag] and ("Bag " .. bag) end
	api.ContainerIDToInventoryID = function(bag) return 19 + bag end
	api.GetKeyRingSize = function() return 32 end
	api.HasKey = function() return 1 end

	-- Loot --------------------------------------------------------------------

	api.GetNumLootItems = function() return #world().loot end
	api.GetLootSlotInfo = function(slot)
		local l = world().loot[slot]
		if l and not l.looted then -- a looted slot stays, empty
			return l.texture or "Interface\\Icons\\Item", l.name, l.quantity or 1, l.quality or 1, l.locked
		end
	end
	api.GetLootSlotLink = function(slot)
		local l = world().loot[slot]
		return l and l.link
	end
	api.LootSlotIsCoin = function(slot)
		local l = world().loot[slot]
		return flag(l and l.isCoin)
	end
	api.LootSlotIsItem = function(slot)
		local l = world().loot[slot]
		return flag(l and not l.isCoin)
	end
	api.LootSlot = function(slot) world().looted = slot end
	api.CloseLoot = function() world().lootClosed = true end
	api.IsFishingLoot = function() return nil end
	api.GetLootThreshold = function() return 2 end
	api.ConfirmLootSlot = function() end

	-- Places --------------------------------------------------------------------

	api.GetZoneText = function() return world().zone.zone end
	api.GetRealZoneText = function() return world().zone.zone end
	api.GetSubZoneText = function() return world().zone.subzone end
	api.GetMinimapZoneText = function() return world().zone.minimap end
	api.GetZonePVPInfo = function()
		local z = world().zone
		return z.pvpType, z.isSubZonePvP, z.faction
	end
	api.IsInInstance = function()
		local i = world().instance
		return i.inInstance, i.type
	end
	api.GetInstanceInfo = function()
		local i = world().instance
		return i.name, i.type, i.difficulty, "Normal", i.maxPlayers, i.dynamic, i.isDynamic
	end
	api.GetInstanceDifficulty = function() return world().instance.difficulty end
	api.GetDungeonDifficulty = function() return 1 end
	api.GetRaidDifficulty = function() return 1 end
	api.GetCurrentMapAreaID = function() return 301 end
	api.GetCurrentMapContinent = function() return 2 end
	api.GetCurrentMapZone = function() return 0 end
	api.SetMapToCurrentZone = function() end
	api.GetPlayerMapPosition = function() return 0.5, 0.5 end
	api.GetPlayerFacing = function() return world().facing end
	api.GetNumWorldStateUI = function() return #world().worldStates end
	api.GetWorldStateUIInfo = function(index)
		local w = world().worldStates[index]
		if w then
			return w.uiType or 0, w.state or 1, w.text, w.icon, w.dynamicIcon, w.tooltip, w.dynamicTooltip,
				w.extendedUI or "", w.extended1 or 0, w.extended2 or 0, w.extended3 or 0
		end
	end
	api.GetBattlefieldStatus = function(index)
		local b = world().battlefields[index]
		if b then
			return b.status, b.map, b.instanceId, b.minLevel, b.maxLevel, b.teamSize, b.registeredMatch
		end
		return "none"
	end
	api.GetMaxBattlefieldID = function() return 2 end
	api.GetBattlefieldPortExpiration = function() return 0 end
	api.GetBattlefieldEstimatedWaitTime = function() return 0 end
	api.GetBattlefieldTimeWaited = function() return 0 end
	api.GetLFGMode = function() return world().lfgStatus end
	api.GetLFGQueueStats = function() return nil end
	api.MiniMapLFG_Update = nil
	api.GetTrackingTexture = function() return "Interface\\Minimap\\Tracking\\None" end
	api.GetNumTrackingTypes = function() return #world().trackingTypes end
	api.GetTrackingInfo = function(id)
		local t = world().trackingTypes[id]
		if t then return t.name, t.texture, t.active, t.category end
	end
	api.SetTracking = function(id) end

	-- Settings -------------------------------------------------------------------

	api.GetCVar = function(name)
		local value = world().cvars[name]
		if value == nil then return nil end
		return tostring(value)
	end
	api.GetCVarBool = function(name)
		local value = world().cvars[name]
		return flag(value ~= nil and value ~= "0" and value ~= 0 and value ~= false)
	end
	api.GetCVarDefault = function(name) return world().cvarDefaults and world().cvarDefaults[name] or "0" end
	api.GetCVarInfo = function(name)
		local value = world().cvars[name]
		if value ~= nil then
			return tostring(value), "0", nil, nil, nil
		end
	end
	api.SetCVar = function(name, value, eventName)
		world().cvars[name] = value ~= nil and tostring(value) or nil
		if eventName then
			client:FireEvent("CVAR_UPDATE", eventName, value)
		end
	end
	api.RegisterCVar = function(name, default)
		if world().cvars[name] == nil then
			world().cvars[name] = default ~= nil and tostring(default) or ""
		end
	end
	api.GetBindingKey = function(command)
		local b = world().bindings[command]
		if b then return b[1], b[2] end
	end
	api.GetBindingAction = function(key)
		for command, keys in pairs(world().bindings) do
			if keys[1] == key or keys[2] == key then return command end
		end
		return ""
	end
	api.GetBindingText = function(key, prefix) return key end
	api.GetBindingFromClick = function(button) return nil end
	api.SetBinding = function(key, command)
		if command then
			world().bindings[command] = { key }
		end
		return 1
	end
	api.SetBindingClick = function(key, button) world().bindings["CLICK " .. tostring(button)] = { key } return 1 end
	api.SetBindingSpell = function() return 1 end
	api.SetBindingMacro = function() return 1 end
	api.SetBindingItem = function() return 1 end
	api.SetOverrideBinding = function(owner, priority, key, command)
		world().overrideBindings[key] = command
	end
	api.SetOverrideBindingClick = function(owner, priority, key, button, mouse)
		world().overrideBindings[key] = "CLICK " .. tostring(button) .. ":" .. tostring(mouse or "LeftButton")
	end
	api.SetOverrideBindingSpell = function(owner, priority, key, spell) world().overrideBindings[key] = spell end
	api.ClearOverrideBindings = function(owner) world().overrideBindings = {} end
	api.GetNumBindings = function() return 0 end
	api.GetBinding = function(i) return nil end
	api.GetCurrentBindingSet = function() return 1 end
	api.SaveBindings = function() end
	api.LoadBindings = function() end
	api.RunBinding = function(command) world().ranBinding = command end

	-- Addons ----------------------------------------------------------------------

	local function addonEntry(index)
		local addons = world().addons
		if type(index) == "number" then
			return addons[index]
		end
		for _, a in ipairs(addons) do
			if a.name == index then return a end
		end
	end
	api.GetNumAddOns = function() return #world().addons end
	api.GetAddOnInfo = function(index)
		local a = addonEntry(index)
		if a then
			return a.name, a.title or a.name, a.notes or "", flag(a.enabled ~= false), flag(a.loadable ~= false),
				a.reason, a.security or "INSECURE"
		end
	end
	api.IsAddOnLoaded = function(index)
		local a = addonEntry(index)
		return flag(a and a.loaded)
	end
	api.LoadAddOn = function(index)
		local a = addonEntry(index)
		if a and a.enabled ~= false then
			a.loaded = true
			if a.onLoad then
				a.onLoad(client) -- the addon's own files (frames, globals)
			end
			client:FireEvent("ADDON_LOADED", a.name)
			return 1
		end
		return nil, "MISSING"
	end
	api.EnableAddOn = function(index)
		local a = addonEntry(index)
		if a then a.enabled = true end
	end
	api.DisableAddOn = function(index)
		local a = addonEntry(index)
		if a then a.enabled = false end
	end
	api.IsAddOnLoadOnDemand = function(index)
		local a = addonEntry(index)
		return flag(a and a.loadOnDemand)
	end
	api.GetAddOnMetadata = function(index, field)
		local a = addonEntry(index)
		return a and a.metadata and a.metadata[field]
	end
	api.GetAddOnDependencies = function() return nil end
	api.UpdateAddOnMemoryUsage = function() end
	api.GetAddOnMemoryUsage = function(index)
		local a = addonEntry(index)
		return a and a.memory or 0
	end
	api.UpdateAddOnCPUUsage = function() end
	api.GetAddOnCPUUsage = function() return 0 end

	-- Social ----------------------------------------------------------------------

	api.GetNumFriends = function()
		local online = 0
		for _, f in ipairs(world().friends) do
			if f.connected then online = online + 1 end
		end
		return #world().friends, online
	end
	api.GetFriendInfo = function(index)
		local f = world().friends[index]
		if f then
			return f.name, f.level, f.class, f.area, f.connected, f.status, f.note
		end
	end
	api.ShowFriends = function() end
	api.IsInGuild = function() return flag(world().guild) end
	api.GetGuildInfo = function(unit)
		local g = world().guild
		if g and resolve(unit) == world().units.player then
			return g.name, "Member", 1
		end
	end
	api.GuildRoster = function() end
	api.GetNumGuildMembers = function(includeOffline)
		local g = world().guild
		if not g then return 0 end
		local online = 0
		for _, m in ipairs(g.members) do
			if m.online then online = online + 1 end
		end
		return includeOffline and #g.members or online
	end
	api.GetGuildRosterInfo = function(index)
		local g = world().guild
		local m = g and g.members[index]
		if m then
			return m.name, m.rank or "Member", m.rankIndex or 1, m.level or 80, CLASS_NAMES[m.class] or m.class,
				m.zone or "Dalaran", m.note or "", m.officernote or "", m.online and 1 or nil, m.status or 0, m.class
		end
	end
	api.GetGuildRosterShowOffline = function() return 1 end
	api.SetGuildRosterShowOffline = function() end
	api.GetNumWhoResults = function() return 0, 0 end

	-- Talents, runes, totems, timers ---------------------------------------------

	api.GetActiveTalentGroup = function() return world().talentGroup end
	api.GetNumTalentGroups = function() return world().numTalentGroups or 2 end
	api.SetActiveTalentGroup = function(group)
		world().talentGroup = group
		client:FireEvent("ACTIVE_TALENT_GROUP_CHANGED", group, 3 - group)
	end
	api.GetNumTalentTabs = function() return #world().talents end

	-- equipment manager sets: world.equipmentSets = { { name, icon }, ... }
	api.GetNumEquipmentSets = function() return #(world().equipmentSets or {}) end
	api.GetEquipmentSetInfo = function(index)
		local set = (world().equipmentSets or {})[index]
		if set then
			return set[1], set[2], index
		end
	end
	api.GetEquipmentSetInfoByName = function(name)
		for index, set in ipairs(world().equipmentSets or {}) do
			if set[1] == name then
				return set[2], index
			end
		end
	end
	api.GetTalentTabInfo = function(tab, inspect, pet, group)
		local t = (inspect and world().inspectTalents
			or (group == 2) and world().secondaryTalents or world().talents)[tab]
		if t then
			return t[1], t[2], t[3], t[4]
		end
	end
	api.CanInspect = function(unit)
		local u = resolve(unit)
		return flag(u and u.isPlayer and world().inspectReady)
	end
	api.NotifyInspect = function(unit)
		world().inspecting = unit
	end
	api.ClearInspectPlayer = function() world().inspecting = nil end
	api.GetRuneCooldown = function(index)
		local r = world().runes[index]
		if r then
			return r.start or 0, r.duration or 10, r.ready ~= false
		end
		return 0, 10, true
	end
	api.GetRuneType = function(index)
		local r = world().runes[index]
		return r and r.type or math.floor((index + 1) / 2)
	end
	api.GetRuneCount = function() return 1 end
	api.GetTotemInfo = function(slot)
		local t = world().totems[slot]
		if t then
			return true, t.name, t.start or 0, t.duration or 0, t.icon or "Interface\\Icons\\Totem"
		end
		return false, "", 0, 0, ""
	end
	api.GetTotemTimeLeft = function(slot)
		local t = world().totems[slot]
		return t and math.max(0, (t.start + t.duration) - world().time) or 0
	end
	api.DestroyTotem = function() end
	api.GetMultiCastTotemSpells = function() return nil end
	api.GetMirrorTimerInfo = function(index)
		local t = world().mirrorTimers[index]
		if t then
			return t.timer, t.value, t.maxvalue, t.scale or -1, t.paused or 0, t.label
		end
		return "UNKNOWN", 0, 0, 0, 0, ""
	end
	api.GetMirrorTimerProgress = function(timer)
		for _, t in ipairs(world().mirrorTimers) do
			if t.timer == timer then return t.value end
		end
		return 0
	end

	-- Quests ------------------------------------------------------------------------

	api.GetNumQuestLogEntries = function()
		local quests = 0
		for _, q in ipairs(world().quests) do
			if not q.isHeader then quests = quests + 1 end
		end
		return #world().quests, quests
	end
	api.GetQuestLogTitle = function(index)
		local q = world().quests[index]
		if q then
			return q.title, q.level or 80, q.tag, q.group or 0, q.isHeader, q.collapsed, q.complete, q.daily, q.id
		end
	end
	api.GetNumQuestLeaderBoards = function(index)
		local q = world().quests[index or world().selectedQuest or 0]
		return q and q.objectives and #q.objectives or 0
	end
	api.GetQuestLogLeaderBoard = function(objective, index)
		local q = world().quests[index or world().selectedQuest or 0]
		local o = q and q.objectives and q.objectives[objective]
		if o then return o.text, o.type or "monster", o.finished end
	end
	api.GetNumQuestWatches = function()
		local n = 0
		for _, q in ipairs(world().quests) do
			if q.watched then n = n + 1 end
		end
		return n
	end
	api.GetQuestIndexForWatch = function(watchIndex)
		local n = 0
		for index, q in ipairs(world().quests) do
			if q.watched then
				n = n + 1
				if n == watchIndex then return index end
			end
		end
	end
	api.IsQuestWatched = function(index)
		local q = world().quests[index]
		return flag(q and q.watched)
	end
	api.AddQuestWatch = function(index) world().quests[index].watched = true end
	api.RemoveQuestWatch = function(index) world().quests[index].watched = false end
	api.GetQuestLogSelection = function() return world().selectedQuest or 0 end
	api.SelectQuestLogEntry = function(index) world().selectedQuest = index end
	api.GetQuestLogSpecialItemInfo = function() return nil end
	api.GetQuestLogQuestText = function() return "Quest text", "Objectives" end
	api.GetQuestDifficultyColor = function(level)
		local diff = level - api.UnitLevel("player")
		if diff >= 5 then return { r = 1, g = 0.1, b = 0.1 } end
		if diff >= 3 then return { r = 1, g = 0.5, b = 0.25 } end
		if diff >= -2 then return { r = 1, g = 0.82, b = 0 } end
		if -diff <= api.GetQuestGreenRange() then return { r = 0.25, g = 0.75, b = 0.25 } end
		return { r = 0.5, g = 0.5, b = 0.5 }
	end
	api.GetQuestGreenRange = function() return 8 end
	api.GetNumAutoQuestPopUps = nil -- Cataclysm

	-- Achievements, titles --------------------------------------------------------

	api.GetAchievementInfo = function(id)
		local a = world().achievements[id]
		if a then
			return id, a.name, a.points or 10, a.completed, 1, 1, 2010, a.description or "", 0, a.icon or "", ""
		end
	end
	api.GetTotalAchievementPoints = function() return 1000 end
	api.GetCurrentTitle = function() return world().currentTitle or 0 end
	api.GetTitleName = function(id)
		local t = world().titles[id]
		return t and t.name, t and t.playerTitle
	end
	api.GetNumTitles = function() return #world().titles end
	api.IsTitleKnown = function(id) return flag(world().titles[id]) end

	-- The client itself ---------------------------------------------------------

	api.GetTime = function() return world().time end
	api.GetGameTime = function() return world().gameTime[1], world().gameTime[2] end
	api.GetFramerate = function() return world().framerate end
	api.GetNetStats = function() return 10, 5, world().latency end
	api.GetBuildInfo = function() return "3.3.5", "12340", "Jun 24 2010", 30300 end
	api.GetLocale = function() return world().locale end
	api.GetRealmName = function() return world().realm end
	api.GetAccountExpansionLevel = function() return world().expansion end
	api.GetExpansionLevel = function() return world().expansion end
	api.IsLoggedIn = function() return flag(world().loggedIn) end
	api.IsMacClient = function() return nil end
	api.IsWindowsClient = function() return 1 end
	api.IsLinuxClient = function() return nil end
	api.IsShiftKeyDown = function() return flag(world().modifiers.shift) end
	api.IsControlKeyDown = function() return flag(world().modifiers.ctrl) end
	api.IsAltKeyDown = function() return flag(world().modifiers.alt) end
	api.IsModifierKeyDown = function()
		local m = world().modifiers
		return flag(m.shift or m.ctrl or m.alt)
	end
	api.IsLeftShiftKeyDown = api.IsShiftKeyDown
	api.IsRightShiftKeyDown = function() return nil end
	api.IsModifiedClick = function(action)
		if action == "CHATLINK" or action == "SHIFT" then return api.IsShiftKeyDown() end
		if action == "DRESSUP" then return api.IsControlKeyDown() end
		if action == "SELFCAST" then return api.IsAltKeyDown() end
		return nil
	end
	api.GetModifiedClick = function(action) return "SHIFT" end
	api.IsMouseButtonDown = function() return nil end
	api.GetMouseButtonClicked = function() return "LeftButton" end
	api.GetCursorPosition = function() return world().cursor[1], world().cursor[2] end
	api.GetCursorInfo = function() return world().cursorInfo end
	api.CursorHasItem = function() return nil end
	api.ClearCursor = function() world().cursorInfo = nil end
	api.GetMouseFocus = function() return client.mouseFocus end
	api.GetScreenWidth = function() return world().screen[1] end
	api.GetScreenHeight = function() return world().screen[2] end
	api.GetScreenResolutions = function() return "800x600", "1024x768", "1920x1080" end
	api.GetCurrentResolution = function() return 3 end
	api.IsMounted = function() return flag(world().mounted) end
	api.IsFlying = function() return flag(world().flying) end
	api.IsSwimming = function() return flag(world().swimming) end
	api.IsStealthed = function() return flag(world().stealthed) end
	api.IsIndoors = function() return nil end
	api.IsOutdoors = function() return 1 end
	api.IsFalling = function() return nil end
	api.GetUnitSpeed = function() return 0, 7, 7, 4.7 end
	api.HasNewMail = function() return flag(world().mail) end
	api.GetLatestThreeSenders = function() return unpack(world().mailSenders) end
	api.GetNumPartyMembersInGroup = nil
	api.PlaySound = function(sound) client.sounds[#client.sounds + 1] = sound end
	api.PlaySoundFile = function(path) client.sounds[#client.sounds + 1] = path end
	api.PlayMusic = function() end
	api.StopMusic = function() end
	api.ReloadUI = function() client.reloaded = (client.reloaded or 0) + 1 end
	api.Logout = function() client.loggedOut = true end
	api.Quit = function() client.quit = true end
	api.ForceQuit = api.Quit
	api.Screenshot = function() end
	api.DoEmote = function(emote, target) client.emotes[#client.emotes + 1] = { emote, target } end
	api.SendChatMessage = function(msg, chatType, language, channel)
		client.chat[#client.chat + 1] = { msg, chatType, language, channel }
	end
	-- the server answers with a CHAT_MSG_SYSTEM ("Name rolls 87 (1-100)"),
	-- the tests fire it themselves
	api.RandomRoll = function(low, high)
		client.rolls = client.rolls or {}
		client.rolls[#client.rolls + 1] = { tonumber(low), tonumber(high) }
	end
	api.AcceptResurrect = function() end
	api.RepopMe = function() end
	api.UseAction = function(slot) world().usedAction = slot end
	api.CastSpellByName = function() end
	api.CastShapeshiftForm = function() end
	api.CastPetAction = function() end
	api.TogglePetAutocast = function() end
	api.PetAttack = function() end
	api.SpellStopCasting = function() end
	api.TargetUnit = function() end
	api.AssistUnit = function() end
	api.FocusUnit = function() end
	api.ClearTarget = function() world().units.target = nil end
	api.ClearFocus = function() world().units.focus = nil end
	api.InitiateTrade = function() end
	api.FollowUnit = function() end
	api.InviteUnit = function() end
	api.UninviteUnit = function() end
	api.LeaveParty = function() end
	api.PromoteToLeader = function() end
	api.RequestTimePlayed = function() end
	api.GetNumMacros = function()
		local account, character = 0, 0
		for index in pairs(world().macros or {}) do
			if index > 36 then character = character + 1 else account = account + 1 end
		end
		return account, character
	end
	api.GetGMTicket = function() end
	api.IsTrialAccount = nil
	api.GetGuildBankMoney = function() return 0 end
	api.GetCoinTextureString = function(money)
		local gold, silver, copper = math.floor(money / 10000), math.floor(money / 100) % 100, money % 100
		return string.format("%dg %ds %dc", gold, silver, copper)
	end
	api.GetCoinText = api.GetCoinTextureString
	api.debugprofilestop = function() return os.clock() * 1000 end
	api.debugprofilestart = function() end
	api.GetTickTime = function() return 0.016 end
	api.GetAutoCompleteResults = function() return nil end
	api.GetChannelList = function() return 1, "General", 2, "Trade" end
	api.GetChannelName = function(id) return 0, nil end
	api.EnumerateServerChannels = function() return "General", "Trade", "LocalDefense" end
	api.GetChatWindowChannels = function() return nil end
	api.GetChatWindowMessages = function() return nil end
	api.GetChatWindowInfo = function(index)
		local w = client.chatWindows and client.chatWindows[index] or {}
		return w.name or (index == 1 and "General" or index == 2 and "Combat Log" or ""), w.fontSize or 14,
			0, 0, 0, w.alpha or 0, w.shown or (index <= 2 and 1 or nil), w.locked, w.docked or (index <= 2 and index or nil), w.uninteractable
	end
	api.GetChatWindowSavedPosition = function() return "BOTTOMLEFT", 0, 0 end
	api.GetChatWindowSavedDimensions = function() return 430, 120 end
	api.SetChatWindowSavedPosition = function() end
	api.SetChatWindowSavedDimensions = function() end
	api.SetChatWindowAlpha = function() end
	api.SetChatWindowColor = function() end
	api.SetChatWindowLocked = function() end
	api.SetChatWindowShown = function() end
	api.SetChatWindowDocked = function() end
	api.SetChatWindowUninteractable = function() end
	api.SetChatWindowName = function() end
	api.SetChatWindowSize = function() end
	api.ChangeChatColor = function() end
	api.JoinChannelByName = function() end
	api.LeaveChannelByName = function() end
	api.AddChatWindowMessages = function() end
	api.RemoveChatWindowMessages = function() end
	api.AddChatWindowChannel = function() end
	api.RemoveChatWindowChannel = function() end
	api.GetDefaultLanguage = function() return "Common" end
	api.GetLanguageByIndex = function(index) return index == 1 and "Common" or nil end
	api.GetNumLanguages = function() return 1 end
	api.GetFramesRegisteredForEvent = function(event)
		local list = {}
		for _, widget in ipairs(client.widgets) do
			if client.widgetState[widget].events and client.widgetState[widget].events[event] then
				list[#list + 1] = widget
			end
		end
		return unpack(list)
	end

	return api
end

return Api
