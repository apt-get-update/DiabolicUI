local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Tooltips")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")

-- Register module incompatibilities
Module:SetIncompatible("TipTac")
Module:SetIncompatible("TinyTip")
Module:SetIncompatible("TinyTooltip")

-- Lua API 
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local math_max = math.max
local pairs= pairs
local select = select
local string_find = string.find
local string_format = string.format
local string_match = string.match
local table_concat = table.concat
local table_insert = table.insert
local table_wipe = table.wipe
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local CanInspect = _G.CanInspect
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetItemInfo = _G.GetItemInfo
local GetItemStats = _G.GetItemStats
local GetMouseFocus = _G.GetMouseFocus
local GetTime = _G.GetTime
local GetQuestGreenRange = _G.GetQuestGreenRange
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local IsShiftKeyDown = _G.IsShiftKeyDown
local NotifyInspect = _G.NotifyInspect
local UnitClass = _G.UnitClass
local UnitClassification = _G.UnitClassification
local UnitCreatureFamily = _G.UnitCreatureFamily
local UnitExists = _G.UnitExists
local UnitFactionGroup = _G.UnitFactionGroup
local UnitGUID = _G.UnitGUID
local UnitIsAFK = _G.UnitIsAFK
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDead = _G.UnitIsDead
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsDND = _G.UnitIsDND
local UnitIsGhost = _G.UnitIsGhost
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsPVP = _G.UnitIsPVP
local UnitIsPVPFreeForAll = _G.UnitIsPVPFreeForAll
local UnitIsUnit = _G.UnitIsUnit
local UnitIsVisible = _G.UnitIsVisible
local UnitLevel = _G.UnitLevel
local UnitName = _G.UnitName
local UnitOnTaxi = _G.UnitOnTaxi
local UnitPVPName = _G.UnitPVPName
local UnitReaction = _G.UnitReaction

-- WoW API (New in Cata)
local GetAverageItemLevel = _G.GetAverageItemLevel 

-- WoW API (New in MoP)
local GetInspectSpecialization = _G.GetInspectSpecialization 
local GetSpecializationInfo = _G.GetSpecializationInfo 
local GetSpecializationInfoByID = _G.GetSpecializationInfoByID 
local UnitBattlePetLevel = _G.UnitBattlePetLevel 
local UnitIsBattlePetCompanion = _G.UnitIsBattlePetCompanion 
local UnitIsWildBattlePet = _G.UnitIsWildBattlePet 

-- WOW API (New in Legion, but added to previous clients by our own API)
local UnitIsTapDenied = _G.UnitIsTapDenied 

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip


-- Blizzard textures we use 
local BOSS_TEXTURE = "|TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:16:16:-2:1|t"
local FFA_TEXTURE = "|TInterface\\TargetingFrame\\UI-PVP-FFA:16:12:-2:1:64:64:6:34:0:40|t"
local FACTION_ALLIANCE_TEXTURE = "|TInterface\\TargetingFrame\\UI-PVP-Alliance:16:12:-2:1:64:64:6:34:0:40|t"
local FACTION_NEUTRAL_TEXTURE = "|TInterface\\TargetingFrame\\UI-PVP-Neutral:16:12:-2:1:64:64:6:34:0:40|t"
local FACTION_HORDE_TEXTURE = "|TInterface\\TargetingFrame\\UI-PVP-Horde:16:16:-4:0:64:64:0:40:0:40|t"

-- WoW client versions
local ENGINE_LEGION 	= Engine:IsBuild("Legion")
local ENGINE_MOP 		= Engine:IsBuild("MoP")
local ENGINE_CATA 		= Engine:IsBuild("Cata")

-- Upgraded Item Bonus 
local UGBonus = {
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

-- Timewarped Items 
local TWItems = {
	-- Timewarped
	["615"] = 660, ["692"] = 675,
	-- Warforged
	["656"] = 675
}

-- BOA Items 
local BOAItems = {
	["133585"] = true, -- Judgment of the Naaru
	["133595"] = true, -- Gronntooth War Horn
	["133596"] = true, -- Orb of Voidsight
	["133597"] = true, -- Infallible Tracking Charm 
	["133598"] = true -- Purified Shard of the Third Moon
}

-- Item stats indicating an item is a PvP item
-- *both do not exist in all expansions, but one of them always does
local KnownPvPStats = {
	ITEM_MOD_RESILIENCE_RATING_SHORT = true,
	ITEM_MOD_PVP_POWER_SHORT = true
}

-- Inventory Slot IDs we need to check for average item levels
local InventorySlots = {
	INVSLOT_HEAD, INVSLOT_NECK, INVSLOT_SHOULDER, INVSLOT_CHEST, 
	INVSLOT_WAIST, INVSLOT_LEGS, INVSLOT_FEET, INVSLOT_WRIST, INVSLOT_HAND, 
	INVSLOT_FINGER1, INVSLOT_FINGER2, INVSLOT_TRINKET1, INVSLOT_TRINKET2, 
	INVSLOT_BACK, INVSLOT_MAINHAND, INVSLOT_OFFHAND, INVSLOT_RANGED
}

-- Menus to skin
local menus = {
	"ChatMenu",
	"EmoteMenu",
	"FriendsTooltip",
	"LanguageMenu",
	"VoiceMacroMenu"
	--"PetBattleUnitFrameDropDown"
}

-- Tooltips to skin
local tooltips = {
	"GameTooltip",
	"ShoppingTooltip1",
	"ShoppingTooltip2",
	"ShoppingTooltip3",
	"ItemRefTooltip",
	"ItemRefShoppingTooltip1",
	"ItemRefShoppingTooltip2",
	"ItemRefShoppingTooltip3",
	"WorldMapTooltip",
	"WorldMapCompareTooltip1",
	"WorldMapCompareTooltip2",
	"WorldMapCompareTooltip3",
	"DatatextTooltip",
	"VengeanceTooltip",
	"hbGameTooltip",
	"EventTraceTooltip",
	"FrameStackTooltip",
	"FloatingGarrisonFollowerTooltip",
	"PetBattlePrimaryUnitTooltip",
	"PetBattlePrimaryAbilityTooltip",
	"QueueStatusFrame"
}	

-- Textures in the combat pet tooltips
-- introduced in MoP.
local pet_textures = { 
	"BorderTopLeft", 
	"BorderTopRight", 
	"BorderBottomRight", 
	"BorderBottomLeft", 
	"BorderTop", 
	"BorderRight", 
	"BorderBottom", 
	"BorderLeft", 
	"Background" 
}

local GearDB, SpecDB = {}, {}
local nextInspectRequest, lastInspectRequest = 0, 0
local currentUNIT, currentGUID

local gearPrefix
if ENGINE_CATA then
	gearPrefix = STAT_AVERAGE_ITEM_LEVEL .. ": " 
else
	gearPrefix = ITEM_LEVEL:gsub("(%%d)", ""):gsub("(%s)$", "") .. ": "
end

local specPrefix
if ENGINE_MOP then
	specPrefix = SPECIALIZATION .. ": " -- specializations instead of just talents got added in MoP
else
	specPrefix = TALENTS .. ": " -- still using talent builds in WotLK and Cata
end

local playerLevel = UnitLevel("player")


-- Utility Functions
------------------------------------------------------------
--[[
local getlevelcolor = function(level)
	level = level - playerLevel
	if level > 4 then
		return C.General.DimRed
	elseif level > 2 then
		return C.General.Orange
	elseif level >= -2 then
		return C.General.Normal
	elseif level >= -GetQuestGreenRange() then
		return C.General.OffGreen
	else
		return C.General.Gray
	end
end

local GetDifficultyColor = function(self, level, isboss)
	local color
	if isboss then
		color = getlevelcolor(playerLevel + 4)
	elseif level and level > 0 then
		color = getlevelcolor(level)
	end
	return color or getlevelcolor(playerLevel)
end
]]--

local IsPVPItem = function(itemLink)
	local itemStats = GetItemStats(itemLink)
	for stat in pairs(itemStats) do
		if KnownPvPStats[stat] then
			return true
		end
	end
end

local GetBOALevel = function(level, id)
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


-- Unit Tooltips
------------------------------------------------------------
Module.GetTooltipUnit = function(self, tooltip)
	local _, unit = tooltip:GetUnit()
	if (not unit) and UnitExists("mouseover") then
		unit = "mouseover"
	end
	if unit and UnitIsUnit(unit, "mouseover") then
		unit = "mouseover"
	end
	return UnitExists(unit) and unit	
end

Module.Tooltip_OnTooltipSetUnit = function(self, tooltip)
	local unit = self:GetTooltipUnit(tooltip)
	if not unit then 
		tooltip:Hide()
		tooltip.unit = nil
		self.unit = nil
		return 
	end

	-- We leave player tooltips to our own custom module
	local isplayer = UnitIsPlayer(unit)
	--if isplayer then
	--	tooltip:Hide()
	--	tooltip.unit = nil
	--	self.unit = nil
	--	return
	--end

	self.unit = unit

	local level = UnitLevel(unit)
	local name, realm = UnitName(unit)
	local faction = UnitFactionGroup(unit)
	local isdead = UnitIsDead(unit) or UnitIsGhost(unit)

	local disconnected, pvp, ffa, pvpname, afk, dnd, class, classname, caninspect
	local classification, creaturetype, iswildpet, isbattlepet
	local isboss, reaction, istapped
	local color

	if isplayer then
		disconnected = not UnitIsConnected(unit)
		pvp = UnitIsPVP(unit)
		ffa = UnitIsPVPFreeForAll(unit)
		pvpname = UnitPVPName(unit)
		afk = UnitIsAFK(unit)
		dnd = UnitIsDND(unit)
		classname, class = UnitClass(unit)
		caninspect = CanInspect(unit) and (level and level > 10)
	else
		classification = UnitClassification(unit)
		creaturetype = UnitCreatureFamily(unit) or UnitCreatureType(unit)
		isboss = classification == "worldboss"
		reaction = UnitReaction(unit, "player")
		istapped = UnitIsTapDenied(unit)
		
		if ENGINE_MOP then
			iswildpet = UnitIsWildBattlePet(unit)
			isbattlepet = UnitIsBattlePetCompanion(unit)
			if isbattlepet or iswildpet then
				level = UnitBattlePetLevel(unit)
			end
		end
		
		if level == -1 then
			classification = "worldboss"
			isboss = true
		end
	end
	
	-- inspect the target if possible
	if caninspect then
		currentUNIT, currentGUID = unit, UnitGUID(unit)
		self:ScanUnit(unit)
	end

	-- figure out name coloring based on collected data
	if isdead then 
		color = C.General.Dead
	elseif isplayer then
		if disconnected then
			color = C.General.Disconnected
		elseif class then
			color = C.Class[class]
		else
			color = C.General.Normal
		end
	elseif reaction then
		if istapped then
			color = C.General.Tapped
		else
			color = C.Reaction[reaction]
		end
	else
		color = C.General.Normal
	end

	-- this can sometimes happen when hovering over battlepets
	if not name or not color then
		tooltip:Hide()
		return
	end

	-- clean up the tip
	for i = 2, tooltip:NumLines() do
		local line = _G[tooltip:GetName().."TextLeft"..i]
		if line then
			--line:SetTextColor(unpack(C.General.Gray)) -- for the time being this will just be confusing
			local text = line:GetText()
			if text then
				if text == PVP_ENABLED then
					line:SetText("") -- kill pvp line, we're adding icons instead!
				end
				if text == FACTION_ALLIANCE or text == FACTION_HORDE then
					line:SetText("") -- kill faction name, the pvp icons will describe this well enough!
				end
				if text == " " then
					local nextLine = _G[tooltip:GetName().."TextLeft"..(i + 1)]
					if nextLine then
						local nextText = nextLine:GetText()
						if COALESCED_REALM_TOOLTIP and INTERACTIVE_REALM_TOOLTIP then -- super simple check for connected realms
							if nextText == COALESCED_REALM_TOOLTIP or nextText == INTERACTIVE_REALM_TOOLTIP then
								line:SetText("")
								nextLine:SetText(nil)
							end
						end
					end
				end
			end
		end
	end
	
	local name_string = self.name_string or {} 
	table_wipe(name_string)

	if isplayer then
		if ffa then
			table_insert(name_string, FFA_TEXTURE)
		elseif pvp and faction then
			if faction == "Horde" then
				table_insert(name_string, FACTION_HORDE_TEXTURE)
			elseif faction == "Alliance" then
				table_insert(name_string, FACTION_ALLIANCE_TEXTURE)
			elseif faction == "Neutral" then
				if ENGINE_LEGION then
					-- They changed this to their new atlas garbage in Legion, 
					-- so for the sake of simplicty we'll just use the FFA PvP icon instead. Works.
					table_insert(name_string, FFA_TEXTURE)
				else
					table_insert(name_string, FACTION_NEUTRAL_TEXTURE)
				end
			end
		end
		table_insert(name_string, name)
	else
		if isboss then
			table_insert(name_string, BOSS_TEXTURE)
		end
		table_insert(name_string, name)
	end
	
	-- Need color codes for the text to always be correctly colored,
	-- or blizzard will from time to time overwrite it with their own.
	local title = _G[tooltip:GetName().."TextLeft1"]
	title:SetText(F.Colorize(table_concat(name_string, " "), unpack(color))) 

	-- Color the statusbar in the same color as the unit name.
	local statusbar = _G[tooltip:GetName().."StatusBar"]
	if statusbar and statusbar:IsShown() then
		if color == C.General.Normal then
			statusbar:SetStatusBarColor(unpack(C.General.HealthGreen))
			statusbar.color = C.General.HealthGreen
		else
			statusbar:SetStatusBarColor(unpack(color))
			statusbar.color = color
		end
	end		
	
	-- just doesn't look good below this
	tooltip:SetMinimumWidth(120) 

	-- force an update if any lines were removed
	tooltip:Show()
end

-- Set Unit Info
Module.SetUnitInfo = function(self, gear, spec)
	if GameTooltip:IsForbidden() then
		return
	end

	if not(gear and spec) or not(IsShiftKeyDown()) then 
		return 
	end

	local unit = self:GetTooltipUnit(GameTooltip)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local gearLine, specLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G["GameTooltipTextLeft" .. i]
		local text = line:GetText()
		if text then
			if string_find(text, gearPrefix) then
				gearLine = _G["GameTooltipTextRight" .. i]
			elseif string_find(text, specPrefix) then
				specLine = _G["GameTooltipTextRight" .. i]
			end
		end
	end

	if not (gearLine or specLine) then
		GameTooltip:AddLine(" ")
	end

	local r, g, b = unpack(C.General.Prefix)
	local r2, g2, b2 = unpack(C.General.Detail)

	if gear then
		if gearLine then
			gearLine:SetText(gear)
			gearLine:SetTextColor(r2, g2, b2)
		else
			GameTooltip:AddDoubleLine(gearPrefix, gear, r, g, b, r2, g2, b2)
		end
	end

	if spec then
		if specLine then
			specLine:SetText(spec)
			specLine:SetTextColor(r2, g2, b2)
		else
			GameTooltip:AddDoubleLine(specPrefix, spec, r, g, b, r2, g2, b2)
		end
	end

	GameTooltip:Show()
end

-- Unit Gear Info 
Module.GetUnitGear = function(self, unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local ulvl = UnitLevel(unit)
	local class = select(2, UnitClass(unit))

	local _
	local delay
	local ilvl, boa, pvp = 0, 0, 0
	local total, count = 0, ENGINE_MOP and 16 or 17 -- include the relic/ranged slot in WotLK/Cata
	local mainhand, offhand, twohand = 1, 1, 0

	if UnitIsUnit("player", unit) then
		for _,i in ipairs(InventorySlots) do
			local itemTexture = GetInventoryItemTexture(unit, i)
			if itemTexture then
				local itemLink = GetInventoryItemLink(unit, i)
				if not itemLink then
					delay = true
				else
					local _, _, quality, level = GetItemInfo(itemLink)
					if (not quality) or (not level) then
						delay = true
					else
						if (quality == 7) then
							boa = boa + 1
						else
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end
						end
					end
				end
			end
		end
	else
		for _,i in ipairs(InventorySlots) do
			local itemTexture = GetInventoryItemTexture(unit, i)
			if itemTexture then
				local itemLink = GetInventoryItemLink(unit, i)

				if not itemLink then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)

					if (not quality) or (not level) then
						delay = true
					else
						if (quality == 7) then
							boa = boa + 1
							local id = string_match(itemLink, "item:(%d+)")
							total = total + GetBOALevel(ulvl, id)
						else
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end

							local tid = string_match(itemLink, ".+:512:22.+:(%d+):100")
							if TWItems[tid] then
								level = TWItems[tid]
							elseif level >= 458 then
								local uid = string_match(itemLink, ".+:(%d+)")
								if UGBonus[uid] then
									level = level + UGBonus[uid]
								end
							end

							total = total + level
						end

						if (i >= 16) then
							-- INVTYPE_RANGED = Bows
							-- INVTYPE_RANGEDRIGHT = Wands, Guns, and Crossbows
							-- INVTYPE_THROWN = Ranged (throwing weapons for Warriors, Rogues in WotLK/Cata)
							if ENGINE_MOP then
								if (slot == "INVTYPE_2HWEAPON") or (slot == "INVTYPE_RANGED") or ((slot == "INVTYPE_RANGEDRIGHT") and (class == "HUNTER")) then
									twohand = twohand + 1
								end
							else
								if (slot == "INVTYPE_2HWEAPON") then
									twohand = twohand + 1
								end
							end
						end
					end
				end
			else
				if i == 16 then
					mainhand = 0
				elseif i == 17 then
					offhand = 0
				end
			end
		end

		if (mainhand == 0) and (offhand == 0) or (twohand == 1) then
			count = count - 1
		end
	end

	if not delay then
		if (unit == "player") and (GetAverageItemLevel() > 0) then
			_, ilvl = GetAverageItemLevel()
		else
			ilvl = total / count
		end
		if ilvl > 0 then 
			ilvl = string_format("%.1f", ilvl) 
			if boa > 0 and pvp > 0 then
				return string_format("%.1f  %s %s, %d %s", ilvl, F.Colorize(boa, unpack(C.General.BoA)), F.Colorize(L["BoA"], unpack(C.General.BoA)), pvp, F.Colorize(L["PvP"], unpack(C.General.PvP)))
			elseif boa > 0 then
				return string_format("%.1f  %s %s", ilvl, F.Colorize(boa, unpack(C.General.BoA)), F.Colorize(L["BoA"], unpack(C.General.BoA)))
			elseif pvp > 0 then
				return string_format("%.1f  %s %s", ilvl, F.Colorize(pvp, unpack(C.General.PvP)), F.Colorize(L["PvP"], unpack(C.General.PvP)))
			else
			end
		end
	else
		ilvl = nil
	end

	return ilvl
end

do 
	local tree = {}
	Module.GetTalentSpec = function(self, unit, isInspect)
		local group = GetActiveTalentGroup(isInspect)
		local maxTree, specName
		for i = 1, 3 do
			local points, _
			if ENGINE_CATA then
				_, _, _, _, points = GetTalentTabInfo(i, isInspect, nil, group)
			else
				_, _, points = GetTalentTabInfo(i, isInspect, nil, group)
			end
			tree[i] = points
			if points > 0 then
				if maxTree then
					if tree[i] > tree[maxTree] then
						maxTree = i
					end
				else
					maxTree = i
				end
			end
		end
		if maxTree then
			local name, _
			if ENGINE_CATA then
				_, name = GetTalentTabInfo(maxTree, isInspect, nil, group)
			else
				name = GetTalentTabInfo(maxTree, isInspect, nil, group)
			end
			specName = string_format("%d/%d/%d (%s)", tree[1], tree[2], tree[3], name)
		else
			specName = NONE
		end
		return specName
	end
end

-- Unit Specialization & Talent Build
Module.GetUnitSpec = function(self, unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local specName
	if ENGINE_MOP then
		if unit == "player" then
			local specIndex = GetSpecialization()
			if specIndex then
				_, specName = GetSpecializationInfo(specIndex)
			else
				specName = NONE
			end
		else
			local specID = GetInspectSpecialization(unit)
			if specID and (specID > 0) then
				_, specName = GetSpecializationInfoByID(specID)
			elseif (specID == 0) then
				specName = NONE
			end
		end
	else
		if UnitIsUnit("player", unit) then
			specName = self:GetTalentSpec(unit)
		else
			specName = self:GetTalentSpec(unit, true)
		end
	end
	return specName
end


-- Scan Current Unit 
Module.ScanUnit = function(self, unit, forced)
	local cachedGear, cachedSpec

	if UnitIsUnit(unit, "player") then
		cachedGear = self:GetUnitGear("player")
		cachedSpec = self:GetUnitSpec("player")

		self:SetUnitInfo(cachedGear or CONTINUED, cachedSpec or CONTINUED)
	else
		if UnitIsDeadOrGhost("player") or UnitOnTaxi("player") then return end
		if InspectFrame and InspectFrame:IsShown() then return end
		if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end
		if (not UnitIsVisible(unit)) then return end

		cachedGear = GearDB[currentGUID]
		cachedSpec = SpecDB[currentGUID]

		if not (IsShiftKeyDown() or forced) then
			if cachedGear and cachedSpec then return end
		end

		--if cachedGear or forced then
		--	self:SetUnitInfo(cachedGear or CONTINUED, cachedSpec)
		--end

		--if cachedGear then
			self:SetUnitInfo(cachedGear or CONTINUED, cachedSpec)
		--end

		--self:SetUnitInfo(CONTINUED, cachedSpec or CONTINUED)

		if InCombatLockdown() then 
			self.inspect:Hide()
			return 
		end

		local timeSinceLastInspect = GetTime() - lastInspectRequest
		if (timeSinceLastInspect >= 1.5) then
			nextInspectRequest = 0
		else
			nextInspectRequest = 1.5 - timeSinceLastInspect
		end
		self.inspect:Show()
	end
end


-- Item Tooltips
------------------------------------------------------------
Module.Tooltip_OnTooltipSetItem = function(self, tooltip)
end


-- Spell Tooltips
------------------------------------------------------------
Module.Tooltip_OnTooltipSetSpell = function(self, tooltip)
	local spellName, spellRank, spellID = GameTooltip:GetSpell()
	if IsShiftKeyDown() then
	end
end


local singlePattern = function(msg, plain)
	msg = msg:gsub("%%%d?$?c", ".+")
	msg = msg:gsub("%%%d?$?d", "%%d+")
	msg = msg:gsub("%%%d?$?s", ".+")
	msg = msg:gsub("([%(%)])", "%%%1")
	msg = msg:gsub("|4(.+):.+;", "%1")
	return plain and msg or ("^" .. msg)
end

local pluralPattern = function(msg, plain)
	msg = msg:gsub("%%%d?$?c", ".+")
	msg = msg:gsub("%%%d?$?d", "%%d+")
	msg = msg:gsub("%%%d?$?s", ".+")
	msg = msg:gsub("([%(%)])", "%%%1")
	msg = msg:gsub("|4.+:(.+);", "%1")
	return plain and msg or ("^" .. msg)
end


local remainingTime = {
	singlePattern(_G.SPELL_TIME_REMAINING_DAYS),
	singlePattern(_G.SPELL_TIME_REMAINING_HOURS),
	singlePattern(_G.SPELL_TIME_REMAINING_MIN),
	singlePattern(_G.SPELL_TIME_REMAINING_SEC),
	pluralPattern(_G.SPELL_TIME_REMAINING_DAYS),
	pluralPattern(_G.SPELL_TIME_REMAINING_HOURS),
	pluralPattern(_G.SPELL_TIME_REMAINING_MIN),
	pluralPattern(_G.SPELL_TIME_REMAINING_SEC)
}

Module.Tooltip_SetUnitBuff = function(self, tooltip, unit, index, filter)
	if GameTooltip:IsForbidden() then
		return
	end

	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellId = UnitBuff(unit, index, filter)
	local color = debuffType and C.Debuff[debuffType] or C.General.Title
	local gray = C.General.Gray

	local tooltipName = tooltip:GetName()
	_G[tooltipName.."TextLeft1"]:SetText(name)
	_G[tooltipName.."TextLeft1"]:SetTextColor(color[1], color[2], color[3])

	if not ENGINE_CATA then
		_G[tooltipName.."TextRight1"]:SetText(rank)
		_G[tooltipName.."TextRight1"]:SetTextColor(gray[1], gray[2], gray[3])
	end

	for i = 2, tooltip:NumLines() do
		local line = _G[tooltipName.."TextLeft"..i]
		if line then
			local msg = line:GetText()
			if msg then
				local isTime
				for i = 1,#remainingTime do
					if string_match(msg, remainingTime[i]) then
						isTime = true
						break
					end
				end
				if isTime then
					line:SetTextColor(C.General.Title[1], C.General.Title[2], C.General.Title[3])
				else
					line:SetTextColor(gray[1], gray[2], gray[3])
				end
			end
		end
	end

	if IsShiftKeyDown() then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L["SpellID:"], spellId, C.General.Blue[1], C.General.Blue[2], C.General.Blue[3], C.General.OffWhite[1], C.General.OffWhite[2], C.General.OffWhite[3])
		if (unitCaster) then
			local casterName = UnitName(unitCaster)
			local caster = (unitCaster == "player") and YOU or (casterName and (casterName ~= "")) and casterName or unitCaster
			if caster then
				GameTooltip:AddDoubleLine(L["Caster:"], caster, C.General.Blue[1], C.General.Blue[2], C.General.Blue[3], C.General.OffWhite[1], C.General.OffWhite[2], C.General.OffWhite[3])
			end
		end
		GameTooltip:Show()
	end
end

Module.Tooltip_SetUnitDebuff = function(self, tooltip, unit, index, filter)
	if GameTooltip:IsForbidden() then
		return
	end

	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellId  = UnitDebuff(unit, index, filter)
	local color = debuffType and C.Debuff[debuffType] or C.General.Title
	local gray = C.General.Gray

	local tooltipName = tooltip:GetName()
	_G[tooltipName.."TextLeft1"]:SetText(name)
	_G[tooltipName.."TextLeft1"]:SetTextColor(color[1], color[2], color[3])

	if not ENGINE_CATA then
		_G[tooltipName.."TextRight1"]:SetText(rank)
		_G[tooltipName.."TextRight1"]:SetTextColor(gray[1], gray[2], gray[3])
	end

	for i = 2, tooltip:NumLines() do
		local line = _G[tooltipName.."TextLeft"..i]
		if line then
			local msg = line:GetText()
			if msg then
				local isTime
				for i = 1,#remainingTime do
					if string_match(msg, remainingTime[i]) then
						isTime = true
						break
					end
				end
				if isTime then
					line:SetTextColor(C.General.Title[1], C.General.Title[2], C.General.Title[3])
				else
					line:SetTextColor(gray[1], gray[2], gray[3])
				end
			end
		end
	end

	if IsShiftKeyDown() then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L["SpellID:"], spellId, C.General.Blue[1], C.General.Blue[2], C.General.Blue[3], C.General.OffWhite[1], C.General.OffWhite[2], C.General.OffWhite[3])
		local caster = unitCaster == "player" and YOU or unitCaster
		if caster then
			GameTooltip:AddDoubleLine(L["Caster:"], caster, C.General.Blue[1], C.General.Blue[2], C.General.Blue[3], C.General.OffWhite[1], C.General.OffWhite[2], C.General.OffWhite[3])
		end
		GameTooltip:Show()
	end
end


-- General 
------------------------------------------------------------
Module.Tooltip_OnUpdate = function(self, tooltip, elapsed)
	-- correct the backdrop color for world items (benches, signs)
	--if self.scheduleRefresh then
	--	self:SetBackdropColor(tooltip)
	--	self.scheduleRefresh = false
	--end

	-- instantly hide tips instead of fading
	if self.scheduleHide 
	or (tooltip.unit and not UnitExists("mouseover")) -- fading unit tips
	or (tooltip:GetAlpha() < 1) then -- fading structure tips (walls, gates, etc)
		tooltip:Show() -- this kills the blizzard fading
		tooltip:Hide()
		self.scheduleHide = false
	end
	
	-- lock the tooltip to our anchor
	--local point, owner, relpoint, x, y = tooltip:GetPoint()
	--if owner == UIParent then -- self:GetOwner() == UIParent -- this bugs out
	--	tooltip:ClearAllPoints()
	--	tooltip:SetPoint(self.anchor:GetPoint())
	--end
end

Module.Tooltip_OnShow = function(self, tooltip)
	--if tooltip:IsOwned(UIParent) and not tooltip:GetUnit() then
	--	self.scheduleRefresh = true
	--end
end

Module.Tooltip_OnHide = function(self, tooltip)
	self.unit = nil
end

Module.Tooltip_SetDefaultAnchor = function(self, tooltip, owner)
	-- On behalf of the whole community I would like to say
	-- FUCK YOUR FORBIDDEN TOOLTIPS BLIZZARD! >:( 
	if tooltip:IsForbidden() then 
		return 
	end

	-- We're only repositioning from the default position, 
	-- and we shouldn't interfere with tooltips placed next to their owners.  
	if (tooltip:GetAnchorType() ~= "ANCHOR_NONE") then 
		return 
	end

	--tooltip:SetOwner(owner or self.anchor, "ANCHOR_NONE")
	tooltip:ClearAllPoints()
	tooltip:SetPoint(self.anchor:GetPoint())
end

-- StatusBars 
------------------------------------------------------------
Module.StatusBar_OnShow = function(self, statusbar)
	self:StatusBar_OnValueChanged(statusbar)
end

Module.StatusBar_OnHide = function(self, statusbar)
	statusbar:GetStatusBarTexture():SetTexCoord(0, 1, 0, 1)
end

Module.StatusBar_OnValueChanged = function(self, statusbar)
	local value = statusbar:GetValue()
	local min, max = statusbar:GetMinMaxValues()
	
	-- Hide the bar if values are missing, or if max or min is 0. 
	if (not min) or (not max) or (not value) or (max == 0) or (value == min) then
		statusbar:Hide()
		return
	end
	
	-- Just in case somebody messed up, 
	-- we silently correct out of range values.
	if value > max then
		value = max
	elseif value < min then
		value = min
	end
	
	if statusbar.value then
		if value == 0 then
			statusbar.value:SetText(DEAD)
		elseif value == max then
			statusbar.value:SetFormattedText("%s", F.Short(max))
		elseif value > 1 then
			statusbar.value:SetFormattedText("%s ∕ %d%%", F.Short(value), floor((value-min)/max*100))
		else
			-- walls and gates only have 1 health, so only percentage is needed. 
			statusbar.value:SetFormattedText("%d%%", floor((value-min)/max*100))
		end
	end

	-- Because blizzard shrink the textures instead of cropping them.
	statusbar:GetStatusBarTexture():SetTexCoord(0, (value-min)/(max-min), 0, 1)

	-- The color needs to be updated, or it will pop back to green
	if statusbar.color then
		if not self.unit then
			statusbar.color = C.General.HealthGreen
		end
		statusbar:SetStatusBarColor(unpack(statusbar.color))
	end
end

-- Styling
------------------------------------------------------------
Module.CreateBackdrop = function(self, object)
	local config = self.config
	local backdrops = self.backdrops or {}
	
	local backdrop = CreateFrame("Frame", nil, object)
	backdrop:SetFrameStrata(object:GetFrameStrata())
	backdrop:SetFrameLevel(object:GetFrameLevel())
	backdrop:SetPoint("LEFT", -config.offsets[1], 0)
	backdrop:SetPoint("RIGHT", config.offsets[2], 0)
	backdrop:SetPoint("TOP", 0, config.offsets[3])
	backdrop:SetPoint("BOTTOM", 0, -config.offsets[4])
	backdrop:SetBackdrop(config.backdrop)
	backdrop:SetBackdropColor(unpack(config.backdrop_color))
	backdrop:SetBackdropBorderColor(unpack(config.backdrop_border_color))

	hooksecurefunc(object, "SetFrameStrata", function(self) backdrop:SetFrameLevel(self:GetFrameLevel()) end)
	hooksecurefunc(object, "SetFrameLevel", function(self) backdrop:SetFrameLevel(self:GetFrameLevel()) end)
	hooksecurefunc(object, "SetParent", function(self) backdrop:SetFrameLevel(self:GetFrameLevel()) end)

	backdrops[object] = backdrop

	object:SetBackdrop(nil) -- a reset is needed first, or we'll get weird bugs
	object.SetBackdrop = function() end -- kill off the original backdrop function
	object.GetBackdrop = function() return config.dummy_backdrop end
	object.GetBackdropColor = function() return unpack(config.dummy_backdrop_color) end
	object.GetBackdropBorderColor = function() return unpack(config.dummy_backdrop_border_color) end

end

Module.StyleMenu = function(self, object)
	self:CreateBackdrop(object)

	-- initial scaling
	-- note: We're only scaling the backdrop/artwork here,
	-- not the potentially secure dropdown frame itself.
	self:Tooltip_UpdateScale(object)

	-- hook our scaling to the display of the actual dropdown
	object:GetParent():HookScript("OnShow", function() 
		self:Tooltip_UpdateScale(object)
	end)
end

Module.StyleTooltip = function(self, object)
	local config = self.config

	-- remove pet textures
	for _,t in ipairs(pet_textures) do
		if object[t] then
			object[t]:SetTexture(nil)
		end
	end
	
	-- add our own backdrop
	self:CreateBackdrop(object)

	-- initial scaling
	self:Tooltip_UpdateScale(object)

	-- hook our scaling
	object:HookScript("OnShow", function(object) 
		self:Tooltip_UpdateScale(object)
	end)
	
	-- modify the health bar
	local statusbar = _G[object:GetName().."StatusBar"]
	if statusbar and (not self.styled[object]) then
		statusbar:ClearAllPoints()
		statusbar:SetPoint("BOTTOMLEFT", object, "BOTTOMLEFT", -config.statusbar.offsets[1], -config.statusbar.offsets[4])
		statusbar:SetPoint("BOTTOMRIGHT", object, "BOTTOMRIGHT", config.statusbar.offsets[2], -config.statusbar.offsets[4])
		statusbar:SetHeight(config.statusbar.size)
		statusbar:SetStatusBarTexture(config.statusbar.texture)

		statusbar.value = statusbar:CreateFontString()
		statusbar.value:SetDrawLayer("OVERLAY")
		statusbar.value:SetFontObject(DiabolicFont_SansBold10)
		statusbar.value:SetPoint("CENTER")

		-- this allows us to track unitless tips with healthbars (walls, gates, etc)
		statusbar:HookScript("OnShow", function(...) self:StatusBar_OnShow(...) end)
		statusbar:HookScript("OnHide", function(...) self:StatusBar_OnHide(...) end)
		statusbar:HookScript("OnValueChanged", function(...) self:StatusBar_OnValueChanged(...) end)
	end
	
end

Module.GetStyledCache = function(self)
	if (not self.styled) then
		self.styled = {}
	end
	return self.styled
end

Module.StyleDropDowns = function(self)
	local styled = self:GetStyledCache()

	local num = UIDROPDOWNMENU_MAXLEVELS
	local num_styled = self.num_menus or 0

	if num > num_styled then
		for i = num_styled+1, num do
			local menu =  _G["DropDownList"..i.."MenuBackdrop"]
			local dropdown = _G["DropDownList"..i.."Backdrop"]

			if menu and not styled[menu] then
				self:StyleMenu(menu)
				styled[menu] = true
			end

			if dropdown and not styled[dropdown] then
				self:StyleMenu(dropdown)
				styled[dropdown] = true
			end
		end
		self.num_menus = num
	end
end

Module.StyleMenus = function(self)
	local styled = self:GetStyledCache()
	
	for i, name in ipairs(menus) do
		local object = _G[name]
		if object and (not styled[object]) then
			self:StyleMenu(object)
			styled[object] = true
		end
	end
end

Module.StyleTooltips = function(self)
	local styled = self:GetStyledCache()
	
	for i, name in ipairs(tooltips) do
		local object = _G[name]
		if object and (not styled[object]) then
			self:StyleTooltip(object)
			styled[object] = true
		end
	end
end

Module.Tooltip_UpdateScale = function(self, object)
	local UICenter = Engine:GetFrame()
	local original = object
	repeat
		object = object:GetParent()
		if object == UICenter then
			original:SetScale(1)
			return
		end
	until not object
	original:SetScale(UICenter:GetScale())
end

Module.UpdateStyles = function(self)
	self:StyleTooltips()	
	self:StyleMenus()
	self:StyleDropDowns()

	-- initial positioning of the game tooltip
	self:Tooltip_SetDefaultAnchor(GameTooltip)
	
	-- hook the creation of further dropdown levels
	if not self.dropdowns_hooked then
		hooksecurefunc("UIDropDownMenu_CreateFrames", function(...) self:StyleDropDowns(...) end)
		self.dropdowns_hooked = true
	end
end


-- This requires both VARIABLES_LOADED and PLAYER_ENTERING_WORLD to have fired!
Module.HookGameTooltip = function(self)
	local tooltip = _G.GameTooltip
	--tooltip:HookScript("OnUpdate", function(...) self:Tooltip_OnUpdate(...) end)
	--tooltip:HookScript("OnShow", function(...) self:Tooltip_OnShow(...) end)
	--tooltip:HookScript("OnHide", function(...) self:Tooltip_OnHide(...) end)
	--tooltip:HookScript("OnTooltipCleared", function(...) self:Tooltip_OnTooltipCleared(...) end)
	--tooltip:HookScript("OnTooltipSetItem", function(...) self:Tooltip_OnTooltipSetItem(...) end)

	tooltip:HookScript("OnTooltipSetUnit", function(...) self:Tooltip_OnTooltipSetUnit(...) end)
	tooltip:HookScript("OnTooltipSetSpell", function(...) self:Tooltip_OnTooltipSetSpell(...) end)
	hooksecurefunc(tooltip, "SetUnitBuff", function(...) self:Tooltip_SetUnitBuff(...) end)
	hooksecurefunc(tooltip, "SetUnitDebuff", function(...) self:Tooltip_SetUnitDebuff(...) end)
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(...) self:Tooltip_SetDefaultAnchor(...) end)

	self:Tooltip_SetDefaultAnchor(tooltip, UIParent)
end

Module.SkinDebugTools = function(self)
	self:UpdateStyles()

	local eventFrame = _G.EventTraceFrame
	local UICenter = Engine:GetFrame()

	_G.FrameStackTooltip:HookScript("OnShow", function(self) self:SetScale(UICenter:GetEffectiveScale()) end)

	-- Strip away border textures 
	for i = 1, eventFrame:GetNumRegions() do
		local region = select(i, eventFrame:GetRegions())
		if region.SetTexture then
			region:SetTexture(nil)
		end
	end

	-- Add our own backdrop
	self:CreateBackdrop(eventFrame)
end

Module.OnEvent = function(self, event, ...)
	local arg1 = ...
	if (event == "ADDON_LOADED") and (arg1 == "Blizzard_DebugTools") then
		self:UnregisterEvent("ADDON_LOADED", "OnEvent")
		self:SkinDebugTools()

	elseif event == "PLAYER_LEVEL_UP" then
		playerLevel = UnitLevel("player")
		
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:HookGameTooltip()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
		
	elseif (event == "UNIT_INVENTORY_CHANGED") and arg1 and (UnitGUID(arg1) == currentGUID) then
		self:ScanUnit(arg1, true)
		
	elseif (event == "MODIFIER_STATE_CHANGED") and ((arg1 == "LSHIFT") or (arg1 == "RSHIFT")) then
		if GameTooltip:IsForbidden() then
			return
		end
		if GameTooltip:IsShown() then 
			local unit = self:GetTooltipUnit(GameTooltip)
			if (unit and currentUNIT and currentGUID) and (UnitIsUnit(unit, currentUNIT) and (UnitGUID(unit) == currentGUID)) then
				GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
				GameTooltip:SetUnit(unit)
				GameTooltip:Show()
			end
		end
	elseif (event == "INSPECT_READY") and (arg1 == currentGUID) then
		local gear = self:GetUnitGear(currentUNIT)
		GearDB[currentGUID] = gear

		local spec = self:GetUnitSpec(currentUNIT)
		SpecDB[currentGUID] = spec

		if not(gear and spec) then
			self:ScanUnit(currentUNIT, true)
		else
			self:SetUnitInfo(gear, spec)
		end
		
	elseif event == "INSPECT_TALENT_READY" then
		local GUID = UnitGUID("mouseover")
		if GUID == currentGUID then
			local unit = "mouseover"
			if UnitExists(unit) then
				local gear = self:GetUnitGear(currentUNIT)
				GearDB[currentGUID] = gear

				local spec = self:GetUnitSpec(currentUNIT)
				SpecDB[currentGUID] = spec

				if not(gear and spec) then
					self:ScanUnit(currentUNIT, true)
				else
					self:SetUnitInfo(gear, spec)
				end
			end

			-- If this is a WotLK client we need to unregister the event,
			-- as it was only possible to inspect one unit at a time back then, 
			-- so we should only ever track this event directly after a NotifyInspect request has been sent!
			self:UnregisterEvent("INSPECT_TALENT_READY", "OnEvent")
		end
	end

end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").tooltips

	-- create an anchor to hook the tooltip to
	self.anchor = CreateFrame("Frame", nil, Engine:GetFrame())
	self.anchor:SetSize(1,1)
	self.anchor:SetPoint(unpack(self.config.position))
	
	-- we need a frame with its on update handler for our inspect script
	self.inspect = CreateFrame("Frame", nil, Engine:GetFrame())
end

Module.OnEnable = function(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterEvent("VARIABLES_LOADED", "OnEvent")
	self:RegisterEvent("PLAYER_LEVEL_UP", "OnEvent")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")
	self:RegisterEvent("MODIFIER_STATE_CHANGED", "OnEvent")
	self:RegisterEvent("ADDON_LOADED", "OnEvent")

	if ENGINE_CATA then
		self:RegisterEvent("INSPECT_READY", "OnEvent")
	end

	self:UpdateStyles()

	self.inspect:SetScript("OnUpdate", function(_, elapsed)
		nextInspectRequest = nextInspectRequest - elapsed
		if nextInspectRequest > 0 then 
			return 
		end

		self.inspect:Hide()

		if currentUNIT and currentGUID and (UnitGUID(currentUNIT) == currentGUID) then
			lastInspectRequest = GetTime() 
			
			if not ENGINE_CATA then
				-- In WotLK, we could only inspect one unit at a time, 
				-- so to avoid confusion we only register the event on demand, 
				-- and will remove it once it fires.
				self:RegisterEvent("INSPECT_TALENT_READY", "OnEvent")
			end
			NotifyInspect(currentUNIT)
		end

	end)
	
	-- Character Info Sheet
	-- TODO: move this somewhere more fitting.
	hooksecurefunc("PaperDollFrame_SetArmor", function(frame, unit)
		
		return

		--[[
		if ENGINE_LEGION then
			if unit ~= "player" then 
				return 
			end
		else
			if not unit then
				unit = "player"
			end
		end

		local msg
		if ENGINE_LEGION then
			PaperDollFrame_SetItemLevel(CharacterStatsPane.ItemLevelFrame, unit)
			CharacterStatsPane.ItemLevelCategory:Show()
			CharacterStatsPane.ItemLevelFrame:Show()
			CharacterStatsPane.AttributesCategory:SetPoint("TOP", CharacterStatsPane.ItemLevelFrame, "BOTTOM", 0, -10)
			msg = CharacterStatsPane.ItemLevelFrame.Value
		else
			if not CharacterLevelText.ItemLevel then
				CharacterLevelText.ItemLevel = CharacterModelFrame:CreateFontString(nil, "OVERLAY") 
				CharacterLevelText.ItemLevel:SetFontObject(GameFontNormalSmall)
				CharacterLevelText.ItemLevel:SetPoint("BOTTOMLEFT", CharacterModelFrame, "BOTTOMLEFT", 10, 30)
			end
			msg = CharacterLevelText.ItemLevel
		end
		
		local total, equip = GetAverageItemLevel()
		if ENGINE_LEGION then
			if total > 0 then
				if equip == total then
					msg:SetFormattedText("|cffffeeaa%.1f|r", equip)
				else
					msg:SetFormattedText("|cffffeeaa%.1f / %.1f|r", equip, total)
				end	
			else
				msg:SetFormattedText("|cffffeeaa%s|r", NONE)
			end
		else
			if equip > 0 then
				msg:SetFormattedText("%s |cffffeeaa%.1f|r", gearPrefix, equip)
			else
				msg:SetFormattedText("%s |cffffeeaa%s|r", gearPrefix, NONE)
			end
		end
		--]]
		
	end)
end
