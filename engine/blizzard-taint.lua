--[[
	
	The MIT License (MIT)
	Copyright (c) 2017 Lars "Goldpaw" Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]--

-- Get the current addon's name for our ADDON_LOADED script
local ADDON = ...

-- Lua API
local select = select
local tonumber = tonumber

-- WoW API
-- *For the sake of speed, we put most of the WoW API locals within 
-- the parent namespace of whatever functions are using them. 
local DisableAddOn = _G.DisableAddOn
local GetBuildInfo = _G.GetBuildInfo
local IsAddOnLoaded = _G.IsAddOnLoaded
local SetCVar = _G.SetCVar

-- Retrive the current game client version (default to WOTLK)
local BUILD = tonumber((select(2, GetBuildInfo()))) or 12340

-- Shortcuts to identify client versions
local BFA 			= BUILD >= 26788 -- 8.0.1
local LEGION_730 	= BUILD >= 24500 -- 7.3.0 
local LEGION_23530 	= BUILD >= 23530 -- 7.2.0.23530 (PTR) 
local LEGION_23478 	= BUILD >= 23478 -- 7.2.0.23478 (PTR)
local LEGION_23436 	= BUILD >= 23436 -- 7.2.0.23436 (PTR)
local LEGION_720 	= BUILD >= 23436 -- 7.2.0 (PTR)
local LEGION_710 	= BUILD >= 22900 -- 7.1.0 "Return to Karazhan"
local LEGION 		= BUILD >= 22410 -- 7.0.3 "Legion"
local WOD_610 		= BUILD >= 19702 -- 6.1.0 "Garrisons Update"
local WOD 			= BUILD >= 19034 -- 6.0.2 "The Iron Tide"
local MOP_510 		= BUILD >= 16309 -- 5.1.0 "Landfall"
local MOP 			= BUILD >= 16016 -- 5.0.4 "Mists of Pandaria"
local CATA_420 		= BUILD >= 14333 -- 4.2.0 "Rage of the Firelands"
local CATA 			= BUILD >= 13164 -- 4.0.1 "Cataclysm Systems"
local WOTLK_330 	= BUILD >= 10958 -- 3.3.0 "Fall of the Lich King"
local WOTLK_310 	= BUILD >=  9767 -- 3.1.0 "Secrets of Ulduar"
local WOTLK 		= BUILD >=  9056 -- 3.0.1 "Echoes of Doom"


-- Forcefully showing script errors because I need this.
-- I also forcefully enable the taint log. 
--
-- TODO: 
-- Write an error handler of my own that is unintrusive, 
-- which people can use to copy premade bug reports to me!
SetCVar("scriptErrors", 1)
SetCVar("taintLog", 1)

---------------------------------------------------------------
-- Blizzard_NamePlates (Legion 7.3.0)
---------------------------------------------------------------
-- If these are enabled the GameTooltip will become protected, 
-- and all sort of taints and bugs will occur.
-- This happens on specs that can dispel when hovering over nameplate auras.
-- We create our own auras anyway, so we don't need these. 
if LEGION_730 then
	SetCVar("nameplateShowDebuffsOnFriendly", 0) 
end

---------------------------------------------------------------
-- Blizzard_AuthChallengeUI login bug (MoP)
---------------------------------------------------------------
-- fix some weird MoP bug I can't really explain
if MOP and (not WOD) then
	if not C_AuthChallenge then
		DisableAddOn("Blizzard_AuthChallengeUI")
	end
end


---------------------------------------------------------------
-- WorldMapBlobFrame Taint Fix (WotLK, Cata, MoP)
---------------------------------------------------------------
-- if not WOD then
-- 	
-- 	-- WoW API
-- 	local WatchFrame_Update = _G.WatchFrame_Update
-- 	local ShowUIPanel = _G.ShowUIPanel
-- 	local HideUIPanel = _G.HideUIPanel
-- 	local WorldMap_ToggleSizeDown = _G.WorldMap_ToggleSizeDown
-- 
-- 	-- WoW Frames
-- 	local WorldMapQuestShowObjectives = _G.WorldMapQuestShowObjectives
-- 	local WorldMapTrackQuest = _G.WorldMapTrackQuest
-- 	local WorldMapTitleButton = _G.WorldMapTitleButton
-- 	local WorldMapFrameSizeUpButton = _G.WorldMapFrameSizeUpButton
-- 	local WorldMapBlobFrame = _G.WorldMapBlobFrame
-- 	local WorldMapPOIFrame = _G.WorldMapPOIFrame
-- 
-- 	local frame = CreateFrame("Frame", nil, UIParent)
-- 	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
-- 	frame:RegisterEvent("PLAYER_REGEN_ENABLED") 
-- 	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
-- 
-- 	frame:SetScript("OnEvent", function(self)
-- 		if event == "PLAYER_ENTERING_WORLD" then
-- 			-- Toggling the WorldMap on entering the world 
-- 			-- prevents it from being tainted by what we're doing later on.
-- 			ShowUIPanel(WorldMapFrame)
-- 			HideUIPanel(WorldMapFrame)
-- 		
-- 		elseif event == "PLAYER_REGEN_DISABLED" then
-- 
-- 			-- Store the current user setting for WorldMap quest tracking
-- 			if WorldMapQuestShowObjectives:GetChecked() then
-- 				self.worldMapQuestTrack = true
-- 			else
-- 				self.worldMapQuestTrack = false
-- 			end
-- 			
-- 			-- Size the map down and hide it upon entering combat
-- 			HideUIPanel(WorldMapFrame)
-- 			WorldMap_ToggleSizeDown()
-- 
-- 			-- Kill and hide the ability to track quests on the WorldMap in combat
-- 			WatchFrame.showObjectives = nil
-- 			WorldMapQuestShowObjectives:SetChecked(false)
-- 
-- 			-- Hide the POI and tracking system 
-- 			-- by hiding the frames and replacing their Show methods
-- 			-- with an empty function call. 
-- 			WorldMapQuestShowObjectives:Hide()
-- 			WorldMapTrackQuest:Hide()
-- 			WorldMapTitleButton:Hide()
-- 			WorldMapFrameSizeUpButton:Hide()
-- 			WorldMapBlobFrame:Hide()
-- 			WorldMapPOIFrame:Hide()
-- 
-- 			WorldMapQuestShowObjectives.Show = function() end
-- 			WorldMapTrackQuest.Show = function() end
-- 			WorldMapTitleButton.Show = function() end
-- 			WorldMapFrameSizeUpButton.Show = function() end
-- 			WorldMapBlobFrame.Show = function() end
-- 			WorldMapPOIFrame.Show = function() end
-- 			
-- 			-- Update the map with the changes
-- 			WatchFrame_Update()
-- 		
-- 		elseif event == "PLAYER_REGEN_ENABLED" then
-- 			
-- 			-- Restore the original Show metamethod
-- 			-- by deleting our empty dummy function
-- 			WorldMapFrameSizeUpButton.Show = nil
-- 			WorldMapQuestShowObjectives.Show = nil
-- 			WorldMapTrackQuest.Show = nil
-- 			WorldMapTitleButton.Show = nil
-- 			WorldMapBlobFrame.Show = nil
-- 			WorldMapPOIFrame.Show = nil
-- 
-- 			-- Restore visibility of the quest tracking and map maximizing buttons
-- 			WorldMapQuestShowObjectives:Show()
-- 			WorldMapTitleButton:Show()
-- 			WorldMapFrameSizeUpButton:Show()
-- 			
-- 			-- Restore the quest tracking setting, 
-- 			-- and restore visibility of the POI system.
-- 			if self.worldMapQuestTrack then
-- 				WatchFrame.showObjectives = true
-- 				WorldMapQuestShowObjectives:SetChecked(true)
-- 				
-- 				WorldMapTrackQuest:Show()
-- 				WorldMapBlobFrame:Show()
-- 				WorldMapPOIFrame:Show()
-- 				
-- 				WatchFrame_Update()
-- 			else
-- 				WatchFrame.showObjectives = nil
-- 				WorldMapQuestShowObjectives:SetChecked(false)
-- 			end
-- 
-- 		end
-- 	end)
-- end


---------------------------------------------------------------
-- SpellBookFrame taint 
---------------------------------------------------------------
-- Turns out we can avoid the spellbook taint
-- by opening it once before we login. Thanks TukUI! :)
-- NB! taiting the GameTooltip taints the spellbook too, so DON'T! o.O
if WOD then
	local PetJournal_LoadUI = _G.PetJournal_LoadUI
	local ToggleFrame = _G.ToggleFrame

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(self, event, addon)
		if addon ~= ADDON then 
			return 
		end

		ToggleFrame(SpellBookFrame)

		-- Don't load this in 6.1, it's not there!
		if not WOD_610 then 
			PetJournal_LoadUI()
		end

		self:UnregisterEvent("ADDON_LOADED")
	end)
end



---------------------------------------------------------------
-- WorldMapFrame Zoom bugs & various taints 
---------------------------------------------------------------
if LEGION and (not BFA) then
	-- Should be noted that this solution only works if the 
	-- Blizzard_ObjectiveTracker addon is disabled! 
	-- So this fix probably isn't very helpful for others, 
	-- unless they too have made their own custom tracker. 
	-- But feel free to use my code for that in your projects, folks! :D 

	-- The first problem is that WorldMapScrollFrame_ResetZoom doesn't work properly in combat. 
	-- The second problem is that changing it taints the WorldMap and probably the POI system and Objectives Tracker too.
	-- The "solution" is to remove events and script handlers that call it while engaged in combat. 

	-- WoW frames & functions
	local WorldMapFrame = _G.WorldMapFrame
	local WorldMapFrame_OnHide = _G.WorldMapFrame_OnHide
	local WorldMapLevelButton_OnClick = _G.WorldMapLevelButton_OnClick

	local frame = CreateFrame("Frame", nil, UIParent)
	frame:RegisterEvent("PLAYER_REGEN_ENABLED") 
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	frame:SetScript("OnEvent", function(self)
		if event == "PLAYER_REGEN_DISABLED" then
			WorldMapFrame:UnregisterEvent("WORLD_MAP_UPDATE")
			WorldMapFrame:SetScript("OnHide", nil)
			WorldMapLevelButton:SetScript("OnClick", nil)
		elseif event == "PLAYER_REGEN_ENABLED" then
			WorldMapFrame:RegisterEvent("WORLD_MAP_UPDATE")
			WorldMapFrame:SetScript("OnHide", WorldMapFrame_OnHide)
			WorldMapLevelButton:SetScript("OnClick", WorldMapLevelButton_OnClick)
		end
	end)


end



---------------------------------------------------------------
-- WorldMapFrame Dropdown bug 
---------------------------------------------------------------
if LEGION and (not LEGION_23436) then

	-- Legion legendaries are unique-equipped up to two at the same time, 
	-- but the UseEquipmentSet API is stupid, it will fail should you try 
	-- to swap to a different legendary without unequipping a previous 
	-- one first (fails with the "Too many legendaries equipped" error).

	-- This fix was supplied by p3lim@WowInterface. 
	-- http://www.wowinterface.com/forums/showthread.php?t=54889

	-- WoW API
	local EquipmentManager_EquipItemByLocation = _G.EquipmentManager_EquipItemByLocation
	local EquipmentManager_RunAction = _G.EquipmentManager_RunAction
	local EquipmentSetContainsLockedItems = _G.EquipmentSetContainsLockedItems
	local GetEquipmentSetLocations = _G.GetEquipmentSetLocations
	local GetInventoryItemLink = _G.GetInventoryItemLink
	local GetInventoryItemQuality = _G.GetInventoryItemQuality
	local UnitCastingInfo = _G.UnitCastingInfo
	local UIErrorsFrame = _G.UIErrorsFrame

	local equipSet = function(name)
		if EquipmentSetContainsLockedItems(name) or UnitCastingInfo("player") then
			UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1, 0.1, 0.1, 1)
			return
		end
	
		-- BUG: legion legendaries will halt the set equipping if the user is swapping
		-- different slotted legendaries beyond the 1/2 equipped limit
		local locations = GetEquipmentSetLocations(name)
		for inventoryID = 1, 17 do
			local itemLink = GetInventoryItemLink("player", inventoryID)
			if(itemLink) then
				local rarity = GetInventoryItemQuality("player", inventoryID)
				if(rarity == 5) then
					-- legendary item found, manually replace it with the item from the new set
					local action = EquipmentManager_EquipItemByLocation(locations[inventoryID], inventoryID)
					if action then
						EquipmentManager_RunAction(action)
						locations[inventoryID] = nil
					end
				end
			end
		end
	
		-- Equip remaining items through _RunAction to avoid blocking from UseEquipmentSet
		for inventoryID, location in next, locations do
			local action = EquipmentManager_EquipItemByLocation(location, inventoryID)
			if action then
				EquipmentManager_RunAction(action)
			end
		end
	end

	_G.EquipmentManager_EquipSet = equipSet

end



---------------------------------------------------------------
-- Equipment Manager Legendary swap bug 
---------------------------------------------------------------
if LEGION_710 and (not LEGION_23478) then

	-- In 7.1 if you open the world map and open any dropdown in the UI 
	-- (from the world map frame or any other frame) the dropdown will suddenly close itself.
	
	-- This little fix was supplied by Ellypse@WowInterface. 
	-- http://www.wowinterface.com/forums/showthread.php?t=54979
	
	-- 2017-06-24-1349: 
	-- "Script ran too long"
	-- Not going to use this for now. 

	--local DropDownList1 = _G.DropDownList1
	--local oldUpdate = _G.WorldMapLevelDropDown_Update
	--local newUpdate = function()
	--	if not DropDownList1:IsVisible() then
	--		oldUpdate()
	--	end
	--end

	--_G.WorldMapLevelDropDown_Update = newUpdate

end


---------------------------------------------------------------
-- Pointless Taint Reports at the 7.2 PTR 
---------------------------------------------------------------
if LEGION_720 and (not LEGION_23530) then

	-- A taint message would fire off at any login with any 
	-- addon activated at the 7.2.0 PTR. The taint reports didn't 
	-- indicate a source or anything wrong at all, so we concluded 
	-- this was a Blizzard bug and simply hid the message instead. 
	--
	-- In build 23530 the problem was removed. 

	_G.INTERFACE_ACTION_BLOCKED = ""
end


---------------------------------------------------------------
-- UIDropDown taints
---------------------------------------------------------------
if UIDropDownMenu_InitializeHelper then 
	if ((UIDROPDOWNMENU_VALUE_PATCH_VERSION or 0) < 2) then 
		UIDROPDOWNMENU_VALUE_PATCH_VERSION = 2 
		hooksecurefunc("UIDropDownMenu_InitializeHelper", function() 
			if UIDROPDOWNMENU_VALUE_PATCH_VERSION ~= 2 then 
				return 
			end 
			for i=1, UIDROPDOWNMENU_MAXLEVELS do 
				for j=1, UIDROPDOWNMENU_MAXBUTTONS do 
					local b = _G["DropDownList" .. i .. "Button" .. j] 
					if not (issecurevariable(b, "value") or b:IsShown()) then 
						b.value = nil 
						repeat 
							j, b["fx" .. j] = j+1 
						until issecurevariable(b, "value") 
					end 
				end 
			end 
		end) 
	end 
end
