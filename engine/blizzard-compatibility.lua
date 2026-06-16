--[[
	The MIT License (MIT)
	Copyright (c) 2017 Lars "Goldpaw" Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]--


-- 	Blizzard API Layer
-------------------------------------------------------------------
-- 	The purpose of this file is to provide a compapatibility layer
-- 	making the different Blizzard API versions more similar. 


-- Lua API
local _G = _G
local getmetatable = getmetatable
local ipairs = ipairs
local math_max = math.max
local pairs = pairs
local select = select
local string_match = string.match
local table_wipe = table.wipe
local type = type

-- Note: 
-- For the sake of speed, we put the WoW API locals within 
-- the parent namespace of whatever functions are using them. 

local globalElements = {} -- registry of global functions and elements
local metaMethods = {} -- registry of meta methods

-- Register a global that will be added if it doesn't exist already.
-- The global can be anything you set it to be.
local addGlobal = function(globalName, targetElement)
	globalElements[globalName] = targetElement
end

-- Register a meta method with the given object type.
-- *If targetElement is a string and the name of an existing meta method, 
--  an alias pointing to that element will be created instead.
--  See the SetColorTexture entry farther down for an example. 
local addMetaMethod = function(objectType, metaMethodName, targetElement)
	if not metaMethods[objectType] then
		metaMethods[objectType] = {}
	end
	metaMethods[objectType][metaMethodName] = targetElement
end



-- Shortcut to ReloadUI
---------------------------------------------------------------------
-- *we want this in all versions
_G.SLASH_RELOADUI1 = "/rl"
_G.SLASH_RELOADUI2 = "/reload"
_G.SLASH_RELOADUI3 = "/reloadui"
_G.SlashCmdList.RELOADUI = _G.ReloadUI



-- Stuff added in Cata that we want in older versions
------------------------------------------------------------------------------------
-- Lua API
local _G = _G
local ipairs = ipairs
local math_max = math_max
local pairs = pairs
local string_match = string_match
local string_split = string_split
local table_wipe = table_wipe

-- WoW API
local GetContainerNumSlots = _G.GetContainerNumSlots
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = _G.GetItemInfo
local GetItemStats = _G.GetItemStats
local IsEquippableItem = _G.IsEquippableItem

-- WoW Constants
local BACKPACK_CONTAINER = _G.BACKPACK_CONTAINER
local NUM_BAG_SLOTS = _G.NUM_BAG_SLOTS


local gearDB, specDB = {}, {}
local itemStatCache, itemPvPCache = {}
local nextInspectRequest, lastInspectRequest = 0, 0
local itemCache
local currentUNIT, currentGUID

-- BOA Items 
local BOAItems = {
	["133585"] = true, -- Judgment of the Naaru
	["133595"] = true, -- Gronntooth War Horn
	["133596"] = true, -- Orb of Voidsight
	["133597"] = true, -- Infallible Tracking Charm 
	["133598"] = true  -- Purified Shard of the Third Moon
}

-- Upgraded Item Bonus 
local upgradedBonusItems = {
	["001"] =  8, ["373"] =  4, ["374"] =  8, ["375"] =  4,
	["376"] =  4, ["377"] =  4, ["379"] =  4, ["380"] =  4,
	["446"] =  4, ["447"] =  8, ["452"] =  8, ["454"] =  4,
	["455"] =  8, ["457"] =  8, ["459"] =  4, ["460"] =  8,
	["461"] = 12, ["462"] = 16, ["466"] =  4, ["467"] =  8,
	["469"] =  4, ["470"] =  8, ["471"] = 12, ["472"] = 16,
	["492"] =  4, ["493"] =  8, ["494"] =  4, ["495"] =  8,
	["496"] =  8, ["497"] = 12, ["498"] = 16, ["504"] = 12,
	["505"] = 16, ["506"] = 20, ["507"] = 24, ["530"] =  5,
	["531"] = 10
}

-- Timewarped/Warforged Items 
local timeWarpedItems = {
	-- Timewarped
	["615"] = 660, ["692"] = 675,

	-- Warforged
	["656"] = 675
}

-- Inventory Slot IDs we need to check for average item levels
local inventorySlots = {
	_G.INVSLOT_HEAD, 		_G.INVSLOT_NECK, 		_G.INVSLOT_SHOULDER, 	_G.INVSLOT_CHEST, 
	_G.INVSLOT_WAIST, 		_G.INVSLOT_LEGS, 		_G.INVSLOT_FEET, 		_G.INVSLOT_WRIST, 		_G.INVSLOT_HAND, 
	_G.INVSLOT_FINGER1, 	_G.INVSLOT_FINGER2, 	_G.INVSLOT_TRINKET1, 	_G.INVSLOT_TRINKET2, 
	_G.INVSLOT_BACK, 		_G.INVSLOT_MAINHAND, 	_G.INVSLOT_OFFHAND, 	_G.INVSLOT_RANGED
}

-- Inventory equip locations of items in our containers we 
-- include in our search for the optimal / maximum item level.
local itemSlot = {
	INVTYPE_HEAD = true, 
	INVTYPE_NECK = true, 
	INVTYPE_SHOULDER = true, 
	INVTYPE_CHEST = true, INVTYPE_ROBE = true, 
	INVTYPE_WAIST = true, 
	INVTYPE_LEGS = true, 
	INVTYPE_FEET = true, 
	INVTYPE_WRIST = true, 
	INVTYPE_HAND = true, 
	INVTYPE_FINGER = true, 
	INVTYPE_TRINKET = true, 
	INVTYPE_CLOAK = true, 
	INVTYPE_2HWEAPON = true, 
	INVTYPE_WEAPON = true, 
	INVTYPE_WEAPONMAINHAND = true, 
	INVTYPE_WEAPONOFFHAND = true, 
	INVTYPE_SHIELD = true, INVTYPE_HOLDABLE = true, 
	INVTYPE_RANGED = true, INVTYPE_THROWN = true, INVTYPE_RANGEDRIGHT = true, INVTYPE_RELIC = true
}

-- Item stats indicating an item is a PvP item
-- *both do not exist in all expansions, but one of them always does
local knownPvPStats = {
	ITEM_MOD_RESILIENCE_RATING_SHORT = true,
	ITEM_MOD_PVP_POWER_SHORT = true
}

-- First clear the cache if one exists, but don't erase any tables,
-- then return it to the user, or create a new table if it's the first call.
local clearCache = function()
	if itemCache then
		for slot,cache in pairs(itemCache) do
			table_wipe(cache)
		end
		return itemCache
	else
		itemCache = {}
		return itemCache
	end
end

-- Add an item into the cache for its slot
local addToCache = function(ilvl, slot)
	if slot == "INVTYPE_ROBE" then
		slot = "INVTYPE_CHEST"
	end
	if not itemCache[slot] then
		itemCache[slot] = {}
	end
	itemCache[slot][#itemCache[slot] + 1] = ilvl
end

local getBOALevel = function(level, id)
	if level > 97 then
		if BOAItems[id] then
			level = 715
		else
			level = 605 - (100 - level) * 5
		end
	elseif level > 90 then
		level = 590 - (97 - level) * 10
	elseif level > 85 then
		level = 463 - (90 - level) * 19.5
	elseif level > 80 then
		level = 333 - (85 - level) * 13.5
	elseif level > 67 then
		level = 187 - (80 - level) * 4
	elseif level > 57 then
		level = 105 - (67 - level) * 2.8
	else
		level = level + 5
	end

	return level
end

local isPvPItem = function(item)
	if itemPvPCache[item] then
	else
		local itemName, itemLink = GetItemInfo(item) 
		if itemLink then 
			local itemString = string_match(itemLink, "item[%-?%d:]+")
			local _, itemID = string_split(":", itemString)

			if itemPvPCache[itemID] then
				return itemPvPCache[itemID]
			else
				local isPvP

				-- cache up the stat table
				itemStatCache[itemID] = GetItemStats(itemLink)

				for stat in pairs(itemStatCache[itemID]) do
					if knownPvPStats[stat] then
						isPvP = true
						break
					end
				end

				-- cache it up
				itemPvPCache[itemID] = isPvP
				itemPvPCache[itemName] = isPvP
				itemPvPCache[itemLink] = isPvP
				itemPvPCache[itemString] = isPvP

				return isPvP
			end
		end
	end
end


-- This isn't perfect, but for most purposes it'll do.
addGlobal("GetAverageItemLevel", function()
	local _, class = UnitClass("player")

	local equip_average_level, equip_total_level, equip_count = 0, 0, 17 -- include the relic/ranged slot in WotLK/Cata
	local mainhand, offhand, twohand = 1, 1, 0
	local boa, pvp = 0, 0
	
	local cache = clearCache()

	-- start scanning equipped items
	for _,invSlot in ipairs(inventorySlots) do
		local itemTexture = GetInventoryItemTexture("player", invSlot)
		if itemTexture then
			local itemLink = GetInventoryItemLink("player", invSlot)
			if itemLink then
				local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)
				if quality and level then
					if quality == 7 then
						boa = boa + 1
						local id = string_match(itemLink, "item:(%d+)")
						level = getBOALevel(player_level, id)
					end
					if invSlot >= 16 then
						-- INVTYPE_RANGED = Bows
						-- INVTYPE_RANGEDRIGHT = Wands, Guns, and Crossbows
						-- INVTYPE_THROWN = Ranged (throwing weapons for Warriors, Rogues in WotLK/Cata)
						if (slot == "INVTYPE_2HWEAPON") then
							twohand = twohand + 1
						end
					end
					equip_total_level = equip_total_level + level
					addToCache(level, slot)
				end
			end
		else
			if invSlot == 16 then
				mainhand = 0
			elseif invSlot == 17 then
				offhand = 0
			end
		end
	end

	if ((mainhand == 0) and (offhand == 0)) or (twohand == 1) then
		equip_count = equip_count - 1
	end
	
	-- the item level of the currently equipped items
	equip_average_level = equip_total_level / equip_count

	-- start scanning the backpack and any equipped bags for gear
	for bagID = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bagID)
		for slotID = 1, numSlots do
			local itemLink = GetContainerItemLink(bagID, slotID)
			if itemLink then
				local canEquip = IsEquippableItem(itemLink)
				if canEquip then
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)
					if quality and level and itemSlot[slot] then
						if quality == 7 then -- don't think these exist here, but still...
							local id = string_match(itemLink, "item:(%d+)")
							local boa_ilvl = getBOALevel(player_level, id)
							addToCache(boa_ilvl, slot)
						else
							addToCache(level, slot)
						end
					end
				end
			end
		end
	end
	
	-- TODO: 
	-- 	Make it return the same values as Blizzard's function.
	-- 	- check for warrior's Titan's Grip
	-- 	- check for heirloom items
	-- 	- figure out what heirlooms count towards the ilvl and not


	-- 	Source: http://wow.gamepedia.com/API_GetAverageItemLevel
	--
	--	Currently Blizzard's formula for equipped average item level is as follows:
	--
	--	 sum of item levels for equipped gear (I)
	--	-----------------------------------------  = Equipped Average Item Level
	--	       number of slots (S)
	--
	--	(I) = in taking the sum, the tabard and shirt always count as zero
	--	      some heirloom items count as zero, other heirlooms count as one
	--
	--	(S) = number of slots depends on the contents of the main and off hand as follows:
	--	      17 with both hands holding items 
	--	      17 with a single one-hand item (or a single two-handed item with Titan's Grip)
	--	      16 with a two-handed item equipped (and no Titan's Grip)
	--	      16 with both hands empty

	
	-- Developer's Notes:
	-- 
	--  1) WotLK featured a ranged slot for all classes, 
	--     with "idols" and similar for the classes lacking the ability to use ranged weapons.
	--     Meaning in WotLK, the number of slots should always be 16 or 17, 
	--     while in MoP and higher, it should be 15 or 16.
	--
	--  2) To properly decide the average and total itemlevels, 
	--     we need to make several passes over the cached table.
	--     Because we can't count both two handers and single handers at the same time. 
	-- 	
	--  3) In WotLK and Cata, all classed had something in their ranged slot, 
	-- 	   while in MoP and beyond nobody had anything, since the ranged slot doesn't exist. 
	--     So the only difference between classes should be whether or not it's a 1h or 2h.

	
	-- Compare the cached items to figure out the highest possible
	-- itemlevel from the possible combination of items in your possession.
	local dual_average, dual_total, dual_count = 0, 0, 3 -- include the relic/ranged slot in WotLK/Cata
	local twohand_average, twohand_total, twohand_count = 0, 0, 2 -- include the relic/ranged slot in WotLK/Cata
	local total_average_level, total_level, total_count = 0, 0, 14 -- 5 armor slots, 1 cloak, 1 wrist, 1 belt, 1 boot(s), 1 neck, 2 rings, 2 trinkets
	local singlehand_max, mainhand_max, offhand_max, twohand_max = 0, 0, 0, 0 -- max ilvls for the various weapon slots

	-- For more information about equip locations / slots:
	-- http://wow.gamepedia.com/ItemEquipLoc
	for slot in pairs(cache) do
		local slotMax = 0
		for i = 1, #cache[slot] do
			-- two-hand
			if slot == "INVTYPE_2HWEAPON" then
				twohand_max = math_max(twohand_max, slotMax)

			-- single-hand (can be equipped in both main and off-hand)
			elseif slot == "INVTYPE_WEAPON" then
				singlehand_max = math_max(singlehand_max, slotMax)
				
			-- main-hand only items
			elseif slot == "INVTYPE_WEAPONMAINHAND" then
				mainhand_max = math_max(mainhand_max, slotMax)
			
			-- off-hand only items
			elseif slot == "INVTYPE_WEAPONOFFHAND" or slot == "INVTYPE_SHIELD" or slot == "INVTYPE_HOLDABLE" then
				offhand_max = math_max(offhand_max, slotMax)

			-- other gear which always should be counted
			else 
				slotMax = math_max(slotMax, cache[slot][i])
			end
		end
		if slotMax > 0 then
			total_level = total_level + slotMax
		end
	end
	
	-- If we have a single-hander with higher level than any main/off-handers, 
	-- then we'll combine that single-hander with the highest of the two others.
	if singlehand_max > mainhand_max or singlehand_max > offhand_max then
		dual_average = (singlehand_max + math_max(offhand_max, mainhand_max) + total_level) / (dual_total + total_count)
	else
		dual_average = (mainhand_max + offhand_max + total_level) / (dual_total + total_count)
	end
	
	-- Max average with a two handed weapon
	twohand_average = (twohand_max + total_level) / (twohand_count + total_count)
	
	-- Max average all things considered. More or less. Can't win 'em all...
	total_average_level = math_max(twohand_average, dual_average)
	
	-- Crossing our fingers that this is right! :) 
	-- *Something bugs out returning a lower total than average sometimes in WotLK, 
	--  so for the sake of simplicity and lesser headaches, we just return equipped twice. -_-
	return math_max(total_average_level, equip_average_level), equip_average_level
end)

-- These functions were renamed in 4.0.1.	
-- Adding the new names as aliases for compatibility.
addGlobal("SetGuildBankWithdrawGoldLimit", _G.SetGuildBankWithdrawLimit)
addGlobal("GetGuildBankWithdrawGoldLimit", _G.GetGuildBankWithdrawLimit)

--local reverseSoundKit
--local playSound = function(ID, channel, forceNoDuplicates)
--	if (not reverseSoundKit) then
--		for key,id in pairs(SOUNDKIT) do
--			reverseSoundKit[id] = key
--		end
--	end
--	local willPlay, soundHandle = PlaySound(reverseSoundKit[ID], channel, forceNoDuplicates)
--	return willPlay, soundHandle
--end
--
-- This was added in Cata
-- The normal PlaySound API call does however accept soundkitIDs, 
-- so we're simply making an alias here instead of the suggested translation table above. 
addGlobal("PlaySoundKitID", _G.PlaySound)

-- Stuff added in MoP that we want in older versions
------------------------------------------------------------------------------------
-- WoW API
local IsActiveBattlefieldArena = _G.IsActiveBattlefieldArena

-- In MoP the old functionality relating to party and raids got for the most parts 
-- replaced by singular group functions, with the addition of an IsInRaid function
-- to determine if we're in a raid group or not. 

-- Returns the number of party members, excluding the player (0 to 4).
-- While in a raid, you are also in a party. You might be the only person in your raidparty, so this function could still return 0.
-- While in a battleground, this function returns information about your battleground party. You may retrieve information about your non-battleground party using GetRealNumPartyMembers().
local GetNumPartyMembers = _G.GetNumPartyMembers
local GetRealNumPartyMembers = _G.GetRealNumPartyMembers

-- Returns number of players in your raid group, including yourself; or 0 if you are not in a raid group.
-- While in battlegrounds, this function returns the number of people in the battleground raid group. You may both be in a battleground raid group and in a normal raid group at the same time; you can use GetRealNumRaidMembers() to retrieve the number of people in the latter.
-- MoP: Replaced by GetNumGroupMembers, and IsInRaid; the former also returns non-zero values for party groups.
local GetNumRaidMembers = _G.GetNumRaidMembers
local GetRealNumRaidMembers = _G.GetRealNumRaidMembers

-- Returns the total number of players in a group.
-- groupType can be:
-- 	LE_PARTY_CATEGORY_HOME (1) - to query information about the player's manually-created group.
-- 	LE_PARTY_CATEGORY_INSTANCE (2) - to query information about the player's instance-specific temporary group (e.g. PvP battleground group, Dungeon Finder group).
-- 		*If omitted, defaults to _INSTANCE if such a group exists, _HOME otherwise.
addGlobal("GetNumGroupMembers", function(groupType) 
	if groupType == 1 then
		local realNumRaid = GetRealNumRaidMembers()
		return (realNumRaid > 0) and realNumRaid or GetRealNumPartyMembers()
	elseif groupType == 2 then
		local realNumRaid = GetRealNumRaidMembers()
		return (realNumRaid > 0) and realNumRaid or GetRealNumPartyMembers()
	else
		local numParty = GetNumPartyMembers()
		local numRaid = GetNumRaidMembers()
		local realNumRaid = GetRealNumRaidMembers()
		return (numRaid > 0) and numRaid or (numParty > 0) and numParty or (realNumRaid > 0) and realNumRaid or GetRealNumPartyMembers()
	end
end)

-- Returns true if the player is in a groupType group (if groupType was not specified, true if in any type of group), false otherwise.
-- 	LE_PARTY_CATEGORY_HOME (1) : checks for home-realm parties.
-- 	LE_PARTY_CATEGORY_INSTANCE (2) : checks for instance-specific groups.
-- 		*The HOME category includes Parties and Raids. It is possible for a character to belong to a party or a raid at the same time they are in an instance group (LFR or Flex). To distinguish between a party and a raid, use the IsInRaid() function.
addGlobal("IsInGroup", function(groupType) 
	if groupType == 1 then
		return (GetRealNumRaidMembers() > 0) or (GetRealNumPartyMembers() > 0)
	elseif (groupType == 2) then
		return (GetNumRaidMembers() > 0) or (GetNumPartyMembers() > 0)
	else
		return (GetRealNumRaidMembers() > 0) or (GetRealNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) or (GetNumPartyMembers() > 0)
	end
end)

-- Returns true if the player is currently in a groupType raid group (if groupType was not specified, true if in any type of raid), false otherwise
-- 	LE_PARTY_CATEGORY_HOME (1) : checks for home-realm parties.
-- 	LE_PARTY_CATEGORY_INSTANCE (2) : checks for instance-specific groups.
-- 		*This returns true in arenas if groupType is LE_PARTY_CATEGORY_INSTANCE or is unspecified.
addGlobal("IsInRaid", function(groupType) 
	if groupType == 1 then
		return GetRealNumRaidMembers() > 0
	elseif (groupType == 2) then
		return IsActiveBattlefieldArena() or GetNumRaidMembers() > 0
	else
		return IsActiveBattlefieldArena() or (GetRealNumRaidMembers() > 0) or (GetNumRaidMembers() > 0)
	end
end)

-- This was added to all UI objects in 5.4.0
-- We're adding a dummy method that always returns false for the tooltips, 
-- to avoid having different checks prior to MoP.
addMetaMethod("GameTooltip", "IsForbidden", function(self) return false end)

-- Stuff added in WoD that we want in older versions
------------------------------------------------------------------------------------
addGlobal("COOLDOWN_TYPE_LOSS_OF_CONTROL", 1)
addGlobal("COOLDOWN_TYPE_NORMAL", 2)

-- Stuff added in Legion that we want in older versions
------------------------------------------------------------------------------------
-- Many rares and quest mobs in both WoD and Legion can be tapped and looted 
-- by multiple groups of players, so in patch 7.0.3 a function was added 
-- to check if you still had the ability to gain credit and loot from the unit in question. 
-- Prior to that we had to check a whole myriad of functions at once to figure out the same.
-- So what we do here is to give previous client versions access to the same functionality

-- WoW API
local UnitIsFriend = _G.UnitIsFriend
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitIsTapped = _G.UnitIsTapped
local UnitIsTappedByAllThreatList = _G.UnitIsTappedByAllThreatList
local UnitIsTappedByPlayer = _G.UnitIsTappedByPlayer

addGlobal("UnitIsTapDenied", function(unit) 
	return UnitIsTapped(unit) and not(UnitPlayerControlled(unit) or UnitIsTappedByPlayer(unit) or UnitIsTappedByAllThreatList(unit) or UnitIsFriend("player", unit))
end)

-- In 7.0.3 the ability to directly set a color as a texture was removed, 
-- and the texture method :SetTexture() could only contain a file path or an atlas ID, 
-- while setting a texture to a pure color received its own method name :SetColorTexture()
-- To simplify development, we're adding SetColorTexture() as an alias of SetTexture()
-- to previous client versions.
-- This won't fix bad SetTexture calls in Legion, but it allows us to use 
-- the Legion API in all client versions with no performance loss.
addMetaMethod("Texture", "SetColorTexture", "SetTexture")

-- Just for the client versions that's missing it, 
-- so we can run this consistently across versions.
-- This will also function as my personal reference table 
-- to figure out exactly what IDs produce what sound.
addGlobal("SOUNDKIT", {
	LOOT_WINDOW_COIN_SOUND = 120,
	INTERFACE_SOUND_LOST_TARGET_UNIT = 684,
	GS_TITLE_OPTIONS = 778,
	GS_TITLE_CREDITS = 790,
	GS_TITLE_OPTION_OK = 798,
	GS_TITLE_OPTION_EXIT = 799,
	GS_LOGIN = 800,
	GS_LOGIN_NEW_ACCOUNT = 801,
	GS_LOGIN_CHANGE_REALM_OK = 805,
	GS_LOGIN_CHANGE_REALM_CANCEL = 807,
	GS_CHARACTER_SELECTION_ENTER_WORLD = 809,
	GS_CHARACTER_SELECTION_DEL_CHARACTER = 810,
	GS_CHARACTER_SELECTION_ACCT_OPTIONS = 811,
	GS_CHARACTER_SELECTION_EXIT = 812,
	GS_CHARACTER_SELECTION_CREATE_NEW = 813,
	GS_CHARACTER_CREATION_CLASS = 814,
	GS_CHARACTER_CREATION_LOOK = 817,
	GS_CHARACTER_CREATION_CREATE_CHAR = 818,
	GS_CHARACTER_CREATION_CANCEL = 819,
	IG_MINIMAP_OPEN = 821,
	IG_MINIMAP_CLOSE = 822,
	IG_MINIMAP_ZOOM_IN = 823,
	IG_MINIMAP_ZOOM_OUT = 824,
	IG_CHAT_EMOTE_BUTTON = 825,
	IG_CHAT_SCROLL_UP = 826,
	IG_CHAT_SCROLL_DOWN = 827,
	IG_CHAT_BOTTOM = 828,
	IG_SPELLBOOK_OPEN = 829,
	IG_SPELLBOOK_CLOSE = 830,
	IG_ABILITY_OPEN = 834,
	IG_ABILITY_CLOSE = 835,
	IG_ABILITY_PAGE_TURN = 836,
	IG_ABILITY_ICON_DROP = 838,
	IG_CHARACTER_INFO_OPEN = 839,
	IG_CHARACTER_INFO_CLOSE = 840,
	IG_CHARACTER_INFO_TAB = 841,
	IG_QUEST_LOG_OPEN = 844,
	IG_QUEST_LOG_CLOSE = 845,
	IG_QUEST_LOG_ABANDON_QUEST = 846,
	IG_MAINMENU_OPEN = 850,
	IG_MAINMENU_CLOSE = 851,
	IG_MAINMENU_OPTION = 852,
	IG_MAINMENU_LOGOUT = 853,
	IG_MAINMENU_QUIT = 854,
	IG_MAINMENU_CONTINUE = 855,
	IG_MAINMENU_OPTION_CHECKBOX_ON = 856,
	IG_MAINMENU_OPTION_CHECKBOX_OFF = 857,
	IG_MAINMENU_OPTION_FAER_TAB = 858,
	IG_INVENTORY_ROTATE_CHARACTER = 861,
	IG_BACKPACK_OPEN = 862,
	IG_BACKPACK_CLOSE = 863,
	IG_BACKPACK_COIN_SELECT = 864,
	IG_BACKPACK_COIN_OK = 865,
	IG_BACKPACK_COIN_CANCEL = 866,
	IG_CHARACTER_NPC_SELECT = 867,
	IG_CREATURE_NEUTRAL_SELECT = 871,
	IG_CREATURE_AGGRO_SELECT = 873,
	IG_QUEST_LIST_OPEN = 875,
	IG_QUEST_LIST_CLOSE = 876,
	IG_QUEST_LIST_SELECT = 877,
	IG_QUEST_LIST_COMPLETE = 878,
	IG_QUEST_CANCEL = 879,
	IG_PLAYER_INVITE = 880,
	MONEY_FRAME_OPEN = 891,
	MONEY_FRAME_CLOSE = 892,
	U_CHAT_SCROLL_BUTTON = 1115,
	PUT_DOWN_SMALL_CHAIN = 1212,
	LOOT_WINDOW_OPEN_EMPTY = 1264,
	TELL_MESSAGE = 3081,
	MAP_PING = 3175,
	FISHING_REEL_IN = 3407,
	IG_PVP_UPDATE = 4574,
	AUCTION_WINDOW_OPEN = 5274,
	AUCTION_WINDOW_CLOSE = 5275,
	TUTORIAL_POPUP = 7355,
	ITEM_REPAIR = 7994,
	PVP_ENTER_QUEUE = 8458,
	PVP_THROUGH_QUEUE = 8459,
	KEY_RING_OPEN = 8938,
	KEY_RING_CLOSE = 8939,
	RAID_WARNING = 8959,
	READY_CHECK = 8960,
	GLUESCREEN_INTRO = 9902,
	AMB_GLUESCREEN_HUMAN = 9903,
	AMB_GLUESCREEN_ORC = 9905,
	AMB_GLUESCREEN_TAUREN = 9906,
	AMB_GLUESCREEN_DWARF = 9907,
	AMB_GLUESCREEN_NIGHTELF = 9908,
	AMB_GLUESCREEN_UNDEAD = 9909,
	AMB_GLUESCREEN_BLOODELF = 9910,
	AMB_GLUESCREEN_DRAENEI = 9911,
	JEWEL_CRAFTING_FINALIZE = 10590,
	MENU_CREDITS01 = 10763,
	MENU_CREDITS02 = 10804,
	GUILD_VAULT_OPEN = 12188,
	GUILD_VAULT_CLOSE = 12189,
	RAID_BOSS_EMOTE_WARNING = 12197,
	GUILD_BANK_OPEN_BAG = 12206,
	GS_LICH_KING = 12765,
	ALARM_CLOCK_WARNING_2 = 12867,
	ALARM_CLOCK_WARNING_3 = 12889,
	MENU_CREDITS03 = 13822,
	ACHIEVEMENT_MENU_OPEN = 13832,
	ACHIEVEMENT_MENU_CLOSE = 13833,
	BARBERSHOP_HAIRCUT = 13873,
	BARBERSHOP_SIT = 14148,
	GM_CHAT_WARNING = 15273,
	LFG_REWARDS = 17316,
	LFG_ROLE_CHECK = 17317,
	LFG_DENIED = 17341,
	UI_BNET_TOAST = 18019,
	ALARM_CLOCK_WARNING_1 = 18871,
	AMB_GLUESCREEN_WORGEN = 20169,
	AMB_GLUESCREEN_GOBLIN = 20170,
	AMB_GLUESCREEN_TROLL = 21136,
	AMB_GLUESCREEN_GNOME = 21137,
	UI_POWER_AURA_GENERIC = 23287,
	UI_REFORGING_REFORGE = 23291,
	UI_AUTO_QUEST_COMPLETE = 23404,
	GS_CATACLYSM = 23640,
	MENU_CREDITS04 = 23812,
	UI_BATTLEGROUND_COUNTDOWN_TIMER = 25477,
	UI_BATTLEGROUND_COUNTDOWN_FINISHED = 25478,
	UI_VOID_STORAGE_UNLOCK = 25711,
	UI_VOID_STORAGE_DEPOSIT = 25712,
	UI_VOID_STORAGE_WITHDRAW = 25713,
	UI_TRANSMOGRIFY_UNDO = 25715,
	UI_ETHEREAL_WINDOW_OPEN = 25716,
	UI_ETHEREAL_WINDOW_CLOSE = 25717,
	UI_TRANSMOGRIFY_REDO = 25738,
	UI_VOID_STORAGE_BOTH = 25744,
	AMB_GLUESCREEN_PANDAREN = 25848,
	MUS_50_HEART_OF_PANDARIA_MAINTITLE = 28509,
	UI_PET_BATTLES_TRAP_READY = 28814,
	UI_EPICLOOT_TOAST = 31578,
	UI_BONUS_LOOT_ROLL_START = 31579,
	UI_BONUS_LOOT_ROLL_LOOP = 31580,
	UI_BONUS_LOOT_ROLL_END = 31581,
	UI_PET_BATTLE_START = 31584,
	UI_SCENARIO_ENDING = 31754,
	UI_SCENARIO_STAGE_END = 31757,
	MENU_CREDITS05 = 32015,
	UI_PET_BATTLE_CAMERA_MOVE_IN = 32047,
	UI_PET_BATTLE_CAMERA_MOVE_OUT = 32052,
	AMB_50_GLUESCREEN_ALLIANCE = 32412,
	AMB_50_GLUESCREEN_HORDE = 32413,
	AMB_50_GLUESCREEN_PANDAREN_NEUTRAL = 32414,
	UI_CHALLENGES_NEW_RECORD = 33338,
	MENU_CREDITS06 = 34020,
	UI_LOSS_OF_CONTROL_START = 34468,
	UI_PET_BATTLES_PVP_THROUGH_QUEUE = 36609,
	AMB_GLUESCREEN_DEATHKNIGHT = 37056,
	UI_RAID_BOSS_WHISPER_WARNING = 37666,
	UI_DIG_SITE_COMPLETION_TOAST = 38326,
	UI_IG_STORE_PAGE_NAV_BUTTON = 39511,
	UI_IG_STORE_WINDOW_OPEN_BUTTON = 39512,
	UI_IG_STORE_WINDOW_CLOSE_BUTTON = 39513,
	UI_IG_STORE_CANCEL_BUTTON = 39514,
	UI_IG_STORE_BUY_BUTTON = 39515,
	UI_IG_STORE_CONFIRM_PURCHASE_BUTTON = 39516,
	UI_IG_STORE_PURCHASE_DELIVERED_TOAST_01 = 39517,
	MUS_60_MAIN_TITLE = 40169,
	UI_GARRISON_MISSION_COMPLETE_ENCOUNTER_FAIL = 43501,
	UI_GARRISON_MISSION_COMPLETE_MISSION_SUCCESS = 43502,
	UI_GARRISON_MISSION_COMPLETE_MISSION_FAIL_STINGER = 43503,
	UI_GARRISON_MISSION_THREAT_COUNTERED = 43505,
	UI_GARRISON_MISSION_100_PERCENT_CHANCE_REACHED_NOT_USED = 43507,
	UI_QUEST_ROLLING_FORWARD_01 = 43936,
	UI_BAG_SORTING_01 = 43937,
	UI_TOYBOX_TABS = 43938,
	UI_GARRISON_TOAST_INVASION_ALERT = 44292,
	UI_GARRISON_TOAST_MISSION_COMPLETE = 44294,
	UI_GARRISON_TOAST_BUILDING_COMPLETE = 44295,
	UI_GARRISON_TOAST_FOLLOWER_GAINED = 44296,
	UI_GARRISON_NAV_TABS = 44297,
	UI_GARRISON_GARRISON_REPORT_OPEN = 44298,
	UI_GARRISON_GARRISON_REPORT_CLOSE = 44299,
	UI_GARRISON_ARCHITECT_TABLE_OPEN = 44300,
	UI_GARRISON_ARCHITECT_TABLE_CLOSE = 44301,
	UI_GARRISON_ARCHITECT_TABLE_UPGRADE = 44302,
	UI_GARRISON_ARCHITECT_TABLE_UPGRADE_CANCEL = 44304,
	UI_GARRISON_ARCHITECT_TABLE_UPGRADE_START = 44305,
	UI_GARRISON_ARCHITECT_TABLE_PLOT_SELECT = 44306,
	UI_GARRISON_ARCHITECT_TABLE_BUILDING_SELECT = 44307,
	UI_GARRISON_ARCHITECT_TABLE_BUILDING_PLACEMENT = 44308,
	UI_GARRISON_COMMAND_TABLE_OPEN = 44311,
	UI_GARRISON_COMMAND_TABLE_CLOSE = 44312,
	UI_GARRISON_COMMAND_TABLE_MISSION_CLOSE = 44313,
	UI_GARRISON_COMMAND_TABLE_NAV_NEXT = 44314,
	UI_GARRISON_COMMAND_TABLE_SELECT_MISSION = 44315,
	UI_GARRISON_COMMAND_TABLE_SELECT_FOLLOWER = 44316,
	UI_GARRISON_COMMAND_TABLE_FOLLOWER_ABILITY_OPEN = 44317,
	UI_GARRISON_COMMAND_TABLE_FOLLOWER_ABILITY_CLOSE = 44318,
	UI_GARRISON_COMMAND_TABLE_ASSIGN_FOLLOWER = 44319,
	UI_GARRISON_COMMAND_TABLE_UNASSIGN_FOLLOWER = 44320,
	UI_GARRISON_COMMAND_TABLE_REDUCED_SUCCESS_CHANCE = 44321,
	UI_GARRISON_COMMAND_TABLE_100_SUCCESS = 44322,
	UI_GARRISON_COMMAND_TABLE_MISSION_START = 44323,
	UI_GARRISON_COMMAND_TABLE_VIEW_MISSION_REPORT = 44324,
	UI_GARRISON_COMMAND_TABLE_MISSION_SUCCESS_STINGER = 44330,
	UI_GARRISON_COMMAND_TABLE_CHEST_UNLOCK = 44331,
	UI_GARRISON_COMMAND_TABLE_CHEST_UNLOCK_GOLD_SUCCESS = 44332,
	UI_GARRISON_MONUMENTS_OPEN = 44344,
	UI_BONUS_EVENT_SYSTEM_VIGNETTES = 45142,
	UI_GARRISON_COMMAND_TABLE_FOLLOWER_LEVEL_UP = 46893,
	UI_GARRISON_ARCHITECT_TABLE_BUILDING_PLACEMENT_ERROR = 47355,
	UI_GARRISON_MONUMENTS_CLOSE = 47373,
	AMB_GLUESCREEN_WARLORDS_OF_DRAENOR = 47544,
	MUS_1_0_MAINTITLE_ORIGINAL = 47598,
	UI_GROUP_FINDER_RECEIVE_APPLICATION = 47615,
	UI_GARRISON_MISSION_ENCOUNTER_ANIMATION_GENERIC = 47704,
	UI_GARRISON_START_WORK_ORDER = 47972,
	UI_GARRISON_SHIPMENTS_WINDOW_OPEN = 48191,
	UI_GARRISON_SHIPMENTS_WINDOW_CLOSE = 48192,
	UI_GARRISON_MONUMENTS_NAV = 48942,
	UI_RAID_BOSS_DEFEATED = 50111,
	UI_PERSONAL_LOOT_BANNER = 50893,
	UI_GARRISON_FOLLOWER_LEARN_TRAIT = 51324,
	UI_GARRISON_SHIPYARD_PLACE_CARRIER = 51385,
	UI_GARRISON_SHIPYARD_PLACE_GALLEON = 51387,
	UI_GARRISON_SHIPYARD_PLACE_DREADNOUGHT = 51388,
	UI_GARRISON_SHIPYARD_PLACE_SUBMARINE = 51389,
	UI_GARRISON_SHIPYARD_PLACE_LANDING_CRAFT = 51390,
	UI_GARRISON_SHIPYARD_START_MISSION = 51401,
	UI_RAID_LOOT_TOAST_LESSER_ITEM_WON = 51402,
	UI_WARFORGED_ITEM_LOOT_TOAST = 51561,
	UI_GARRISON_COMMAND_TABLE_INCREASED_SUCCESS_CHANCE = 51570,
	UI_GARRISON_SHIPYARD_DECOMISSION_SHIP = 51871,
	UI_70_ARTIFACT_FORGE_TRAIT_FIRST_TRAIT = 54126,
	UI_70_ARTIFACT_FORGE_RELIC_PLACE = 54128,
	UI_70_ARTIFACT_FORGE_APPEARANCE_COLOR_SELECT = 54130,
	UI_70_ARTIFACT_FORGE_APPEARANCE_LOCKED = 54131,
	UI_70_ARTIFACT_FORGE_APPEARANCE_APPEARANCE_CHANGE = 54132,
	UI_70_ARTIFACT_FORGE_TOAST_TRAIT_AVAILABLE = 54133,
	UI_70_ARTIFACT_FORGE_APPEARANCE_APPEARANCE_UNLOCK = 54139,
	UI_70_ARTIFACT_FORGE_TRAIT_GOLD_TRAIT = 54125,
	UI_72_ARTIFACT_FORGE_FINAL_TRAIT_UNLOCKED = 83682,
	UI_70_ARTIFACT_FORGE_TRAIT_FINALRANK = 54127,
	UI_70_ARTIFACT_FORGE_TRAIT_RANKUP = 54129,
	AMB_GLUESCREEN_DEMONHUNTER = 56352,
	MUS_70_MAIN_TITLE = 56353,
	MENU_CREDITS07 = 56354,
	UI_TRANSMOG_ITEM_CLICK = 62538,
	UI_TRANSMOG_PAGE_TURN = 62539,
	UI_TRANSMOG_GEAR_SLOT_CLICK = 62540,
	UI_TRANSMOG_REVERTING_GEAR_SLOT = 62541,
	UI_TRANSMOG_APPLY = 62542,
	UI_TRANSMOG_CLOSE_WINDOW = 62543,
	UI_TRANSMOG_OPEN_WINDOW = 62544,
	UI_LEGENDARY_LOOT_TOAST = 63971,
	UI_STORE_UNWRAP = 64329,
	AMB_GLUESCREEN_LEGION = 71535,
	UI_MISSION_200_PERCENT = 72548,
	UI_MISSION_MAP_ZOOM = 72549,
	UI_70_BOOST_THANKSFORPLAYING_SMALLER = 72978,
	UI_70_BOOST_THANKSFORPLAYING = 72977,
	UI_WORLDQUEST_START = 73275,
	UI_WORLDQUEST_MAP_SELECT = 73276,
	UI_WORLDQUEST_COMPLETE = 73277,
	UI_ORDERHALL_TALENT_SELECT = 73279,
	UI_ORDERHALL_TALENT_READY_TOAST = 73280,
	UI_ORDERHALL_TALENT_READY_CHECK = 73281,
	UI_ORDERHALL_TALENT_NUKE_FROM_ORBIT = 73282,
	UI_ORDERHALL_TALENT_WINDOW_OPEN = 73914,
	UI_ORDERHALL_TALENT_WINDOW_CLOSE = 73915,
	UI_PROFESSIONS_WINDOW_OPEN = 73917,
	UI_PROFESSIONS_WINDOW_CLOSE = 73918,
	UI_PROFESSIONS_NEW_RECIPE_LEARNED_TOAST = 73919,
	UI_70_CHALLENGE_MODE_SOCKET_PAGE_OPEN = 74421,
	UI_70_CHALLENGE_MODE_SOCKET_PAGE_CLOSE = 74423,
	UI_70_CHALLENGE_MODE_SOCKET_PAGE_SOCKET = 74431,
	UI_70_CHALLENGE_MODE_SOCKET_PAGE_ACTIVATE_BUTTON = 74432,
	UI_70_CHALLENGE_MODE_KEYSTONE_UPGRADE = 74437,
	UI_70_CHALLENGE_MODE_NEW_RECORD = 74438,
	UI_70_CHALLENGE_MODE_SOCKET_PAGE_REMOVE_KEYSTONE = 74525,
	UI_70_CHALLENGE_MODE_COMPLETE_NO_UPGRADE = 74526,
	UI_MISSION_SUCCESS_CHEERS = 74702,
	UI_PVP_HONOR_PRESTIGE_OPEN_WINDOW = 76995,
	UI_PVP_HONOR_PRESTIGE_WINDOW_CLOSE = 77002,
	UI_PVP_HONOR_PRESTIGE_RANK_UP = 77003,
	UI_71_SOCIAL_QUEUEING_TOAST = 79739,
	UI_72_ARTIFACT_FORGE_ACTIVATE_FINAL_TIER = 83681,
	UI_72_BUILDINGS_CONTRIBUTE_POWER_MENU_CLICK = 84240,
	UI_72_BUILDING_CONTRIBUTION_TABLE_OPEN = 84368,
	UI_72_BUILDINGS_CONTRIBUTION_TABLE_CLOSE = 84369,
	UI_72_BUILDINGS_CONTRIBUTE_RESOURCES = 84378,

	UI_GARRISON_MISSION_COMPLETE_ENCOUNTER_CHANCE = 0, -- missing SoundKit entry!
})

-- To avoid breaking in WotLK and non-Legion clients
addGlobal("LE_WORLD_QUEST_QUALITY_COMMON", 1)
addGlobal("LE_WORLD_QUEST_QUALITY_RARE", 2)
addGlobal("LE_WORLD_QUEST_QUALITY_EPIC", 3)

-- Lua Enums
------------------------------------------------------------------------------------
addGlobal("LE_PARTY_CATEGORY_HOME", 1)
addGlobal("LE_PARTY_CATEGORY_INSTANCE", 2)

addGlobal("LE_NUM_ACTIONS_PER_PAGE", 12)
addGlobal("LE_NUM_BONUS_ACTION_PAGES", 4)
addGlobal("LE_NUM_NORMAL_ACTION_PAGES", 6)

addGlobal("LE_BAG_FILTER_FLAG_IGNORE_CLEANUP", 1)
addGlobal("LE_BAG_FILTER_FLAG_EQUIPMENT", 2)
addGlobal("LE_BAG_FILTER_FLAG_CONSUMABLES", 3)
addGlobal("LE_BAG_FILTER_FLAG_TRADE_GOODS", 4)
addGlobal("LE_BAG_FILTER_FLAG_JUNK", 5)

addGlobal("LE_CHARACTER_UNDELETE_RESULT_OK", 1)
addGlobal("LE_CHARACTER_UNDELETE_RESULT_ERROR_COOLDOWN", 2)
addGlobal("LE_CHARACTER_UNDELETE_RESULT_ERROR_CHAR_CREATE", 3)
addGlobal("LE_CHARACTER_UNDELETE_RESULT_ERROR_DISABLED", 4)
addGlobal("LE_CHARACTER_UNDELETE_RESULT_ERROR_NAME_TAKEN_BY_THIS_ACCOUNT", 5)
addGlobal("LE_CHARACTER_UNDELETE_RESULT_ERROR_UNKNOWN", 6)

addGlobal("LE_EXPANSION_CLASSIC", 0)
addGlobal("LE_EXPANSION_BURNING_CRUSADE", 1)
addGlobal("LE_EXPANSION_WRATH_OF_THE_LICH_KING", 2)
addGlobal("LE_EXPANSION_CATACLYSM", 3)
addGlobal("LE_EXPANSION_MISTS_OF_PANDARIA", 4)
addGlobal("LE_EXPANSION_WARLORDS_OF_DRAENOR", 5)
addGlobal("LE_EXPANSION_LEGION", 6)
addGlobal("LE_EXPANSION_8_0", 7)
addGlobal("LE_EXPANSION_LEVEL_CURRENT", 2)

addGlobal("LE_FRAME_TUTORIAL_GARRISON_BUILDING", 9)
addGlobal("LE_FRAME_TUTORIAL_GARRISON_MISSION_LIST", 10)
addGlobal("LE_FRAME_TUTORIAL_GARRISON_MISSION_PAGE", 11)
addGlobal("LE_FRAME_TUTORIAL_GARRISON_LANDING", 12)
addGlobal("LE_FRAME_TUTORIAL_GARRISON_ZONE_ABILITY", 13)
addGlobal("LE_FRAME_TUTORIAL_WORLD_MAP_FRAME", 14)
addGlobal("LE_FRAME_TUTORIAL_CLEAN_UP_BAGS", 15)
addGlobal("LE_FRAME_TUTORIAL_BAG_SETTINGS", 16)
addGlobal("LE_FRAME_TUTORIAL_REAGENT_BANK_UNLOCK", 17)
addGlobal("LE_FRAME_TUTORIAL_TOYBOX_FAVORITE", 18)
addGlobal("LE_FRAME_TUTORIAL_TOYBOX_MOUSEWHEEL_PAGING", 19)
addGlobal("LE_FRAME_TUTORIAL_LFG_LIST", 20)

addGlobal("LE_ITEM_QUALITY_POOR", 0)
addGlobal("LE_ITEM_QUALITY_COMMON", 1)
addGlobal("LE_ITEM_QUALITY_UNCOMMON", 2)
addGlobal("LE_ITEM_QUALITY_RARE", 3)
addGlobal("LE_ITEM_QUALITY_EPIC", 4)
addGlobal("LE_ITEM_QUALITY_LEGENDARY", 5)
addGlobal("LE_ITEM_QUALITY_ARTIFACT", 6)
addGlobal("LE_ITEM_QUALITY_HEIRLOOM", 7)
addGlobal("LE_ITEM_QUALITY_WOW_TOKEN", 8)

addGlobal("LE_LFG_LIST_DISPLAY_TYPE_ROLE_COUNT", 1)
addGlobal("LE_LFG_LIST_DISPLAY_TYPE_ROLE_ENUMERATE", 2)
addGlobal("LE_LFG_LIST_DISPLAY_TYPE_CLASS_ENUMERATE", 3)
addGlobal("LE_LFG_LIST_DISPLAY_TYPE_HIDE_ALL", 4)

addGlobal("LE_LFG_LIST_FILTER_RECOMMENDED", 1)
addGlobal("LE_LFG_LIST_FILTER_NOT_RECOMMENDED", 2)
addGlobal("LE_LFG_LIST_FILTER_PVE", 4)
addGlobal("LE_LFG_LIST_FILTER_PVP", 8)

addGlobal("LE_MOUNT_JOURNAL_FILTER_COLLECTED", 1)
addGlobal("LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED", 2)

addGlobal("LE_PAN_STEADY", 1)
addGlobal("LE_PAN_NONE", 2)
addGlobal("LE_PAN_NONE_RANGED", 3)
addGlobal("LE_PAN_FAST_SLOW", 4)
addGlobal("LE_PAN_SLOW_FAST", 5)
addGlobal("LE_PAN_AND_JUMP", 6)

addGlobal("LE_PET_JOURNAL_FLAG_DEFAULT", 262144)

addGlobal("LE_QUEST_FACTION_ALLIANCE", 1)
addGlobal("LE_QUEST_FACTION_HORDE", 2)

addGlobal("LE_QUEST_FREQUENCY_DEFAULT", 1)
addGlobal("LE_QUEST_FREQUENCY_DAILY", 2)
addGlobal("LE_QUEST_FREQUENCY_WEEKLY", 3)

addGlobal("LE_RAID_BUFF_HASTE", 4)
addGlobal("LE_RAID_BUFF_CRITICAL_STRIKE", 7) -- 6 in WoD
addGlobal("LE_RAID_BUFF_MASTERY", 8) -- 7 in WoD

--addGlobal("LE_RAID_BUFF_MULITSTRIKE", 8)
--addGlobal("LE_RAID_BUFF_VERSATILITY", 9)

addGlobal("LE_TRACKER_SORTING_MANUAL", 1)
addGlobal("LE_TRACKER_SORTING_PROXIMITY", 2)
addGlobal("LE_TRACKER_SORTING_DIFFICULTY_LOW", 3)
addGlobal("LE_TRACKER_SORTING_DIFFICULTY_HIGH", 4)

addGlobal("LE_UNIT_STAT_STRENGTH", 1)
addGlobal("LE_UNIT_STAT_AGILITY", 2)
addGlobal("LE_UNIT_STAT_STAMINA", 3)
addGlobal("LE_UNIT_STAT_INTELLECT", 4)
addGlobal("LE_UNIT_STAT_SPIRIT", 5)

-- Add global functions
for globalName, targetElement in pairs(globalElements) do
	if not _G[globalName] then
		_G[globalName] = targetElement
	end
end

-- Add meta methods
local frameObject = CreateFrame("Frame")
local tooltipObject = CreateFrame("GameTooltip")
local objectTypes = {
	Frame = frameObject, 
	GameTooltip = tooltipObject,
	Texture = frameObject:CreateTexture()
}
for objectType, methods in pairs(metaMethods) do
	local object = objectTypes[objectType]
	local object_methods = getmetatable(object).__index
	for method, targetElement in pairs(methods) do
		if not object[method] then
			if type(targetElement) == "string" then
				object_methods[method] = object[targetElement]
			else
				object_methods[method] = targetElement
			end
		end
	end
end
