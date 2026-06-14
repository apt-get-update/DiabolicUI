local _, Engine = ...

-- This module needs a HIGH priority, 
-- as other modules rely on it for positioning. 
local Module = Engine:NewModule("Minimap", "HIGH")
local BlizzardUI = Engine:GetHandler("BlizzardUI")
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")
local L = Engine:GetLocale()

-- Some constants needed later on
local MBB = Engine:IsAddOnEnabled("MBB") 
local MBF = Engine:IsAddOnEnabled("MinimapButtonFrame")

-- If carbonite is loaded, 
-- and the setting to move the minimap into the carbonite map is enabled, 
-- we leave the whole minimap to carbonite and just exit our module completely.
Module:SetIncompatible("Carbonite", function(self)
	if NxData and NxData.NXGOpts.MapMMOwn then
		return true
	end
end)

-- Complete Minimap replacements
Module:SetIncompatible("Mappy")
Module:SetIncompatible("SexyMap")
Module:SetIncompatible("DragonUI")

-- Speed constants, because we can never get enough
------------------------------------------------------------------
local ENGINE_BFA 			= Engine:IsBuild("BfA")
local ENGINE_LEGION_730 	= Engine:IsBuild("7.3.0")
local ENGINE_LEGION_725 	= Engine:IsBuild("7.2.5")
local ENGINE_LEGION_715 	= Engine:IsBuild("7.1.5")
local ENGINE_WOD 			= Engine:IsBuild("WoD")
local ENGINE_MOP 			= Engine:IsBuild("MoP")
local ENGINE_CATA 			= Engine:IsBuild("Cata")

-- Lua API
local _G = _G
local date = date
local ipairs = ipairs
local math_floor = math.floor
local math_sqrt = math.sqrt
local pairs = pairs
local select = select
local string_format = string.format
local table_insert = table.insert
local table_wipe = table.wipe
local unpack = unpack

-- WoW API
local C_Map = _G.C_Map
local GetBestMapForUnit = C_Map and C_Map.GetBestMapForUnit
local GetCurrentMapAreaID = _G.GetCurrentMapAreaID
local GetCursorPosition = _G.GetCursorPosition
local GetDifficultyInfo = _G.GetDifficultyInfo
local GetGameTime = _G.GetGameTime
local GetInstanceInfo = _G.GetInstanceInfo
local GetLatestThreeSenders = _G.GetLatestThreeSenders
local GetMinimapZoneText = _G.GetMinimapZoneText
local GetPlayerMapPosition = ENGINE_BFA and C_Map and C_Map.GetPlayerMapPosition or _G.GetPlayerMapPosition
local GetSubZoneText = _G.GetSubZoneText
local GetZonePVPInfo = _G.GetZonePVPInfo
local GetZoneText = _G.GetZoneText
local HasNewMail = _G.HasNewMail
local IsAddOnLoaded = _G.IsAddOnLoaded
local IsInInstance = _G.IsInInstance
local PlaySoundKitID = ENGINE_LEGION_730 and _G.PlaySound or _G.PlaySoundKitID
local RegisterStateDriver = _G.RegisterStateDriver
local SetMapToCurrentZone = _G.SetMapToCurrentZone
local ToggleDropDownMenu = _G.ToggleDropDownMenu


-- WoW frames and objects referenced frequently
------------------------------------------------------------------
local GameTooltip = _G.GameTooltip
local Minimap = _G.Minimap
local MinimapBackdrop = _G.MinimapBackdrop
local MinimapCluster = _G.MinimapCluster
local MinimapZoomIn = _G.MinimapZoomIn
local MinimapZoomOut = _G.MinimapZoomOut
local WorldMapFrame = _G.WorldMapFrame


-- WoW strings
------------------------------------------------------------------

-- Zonetext
local DUNGEON_DIFFICULTY1 = _G.DUNGEON_DIFFICULTY1
local DUNGEON_DIFFICULTY2 = _G.DUNGEON_DIFFICULTY2
local SANCTUARY_TERRITORY = _G.SANCTUARY_TERRITORY
local FREE_FOR_ALL_TERRITORY = _G.FREE_FOR_ALL_TERRITORY
local FACTION_CONTROLLED_TERRITORY = _G.FACTION_CONTROLLED_TERRITORY
local CONTESTED_TERRITORY = _G.CONTESTED_TERRITORY
local COMBAT_ZONE = _G.COMBAT_ZONE

-- Time
local TIMEMANAGER_AM = _G.TIMEMANAGER_AM
local TIMEMANAGER_PM = _G.TIMEMANAGER_PM
local TIMEMANAGER_TITLE = _G.TIMEMANAGER_TITLE
local TIMEMANAGER_TOOLTIP_LOCALTIME = _G.TIMEMANAGER_TOOLTIP_LOCALTIME
local TIMEMANAGER_TOOLTIP_REALMTIME = _G.TIMEMANAGER_TOOLTIP_REALMTIME

-- Mail 
local HAVE_MAIL = _G.HAVE_MAIL
local HAVE_MAIL_FROM = _G.HAVE_MAIL_FROM

-- Difficulty and group sizes
local SOLO = SOLO
local GROUP = GROUP


-- Map functions
------------------------------------------------------------------
local onMouseWheel = function(self, delta)
	if (delta > 0) then
		MinimapZoomIn:Click()
	elseif (delta < 0) then
		MinimapZoomOut:Click()
	end
end
	
local onMouseUp = function(self, button)
	if (button == "RightButton") then
		ToggleDropDownMenu(1, nil,  _G.MiniMapTrackingDropDown, self)
		PlaySoundKitID(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON, "SFX")
	else
		local effectiveScale = self:GetEffectiveScale()

		local x, y = GetCursorPosition()
		x = x / effectiveScale
		y = y / effectiveScale

		local cx, cy = self:GetCenter()
		x = x - cx
		y = y - cy

		if (math_sqrt(x * x + y * y) < (self:GetWidth() / 2)) then
			self:PingLocation(x, y)
		end
	end
end

local onUpdate = function(self, elapsed)
	-- Update clock
	self.elapsedTime = (self.elapsedTime or 0) + elapsed
	if (self.elapsedTime > 1) or (self.refreshTime) then 

		local db = self.db
		local time = self.widgets.time
		local h, m

		if db.useGameTime then
			h, m = GetGameTime()
		else
			local dateTable = date("*t")
			h = dateTable.hour
			m = dateTable.min 
		end
		
		if db.use24hrClock then
			time:SetFormattedText("%02d:%02d", h, m)
		else

			-- 12-hour clock: https://en.wikipedia.org/wiki/12-hour_clock
			if (h < 12) then										
				if (h == 0) then
					time:SetFormattedText("%d:%02d%s", h + 12, m, TIMEMANAGER_AM) -- Midnight to one, displayed as 12AM
				else
					time:SetFormattedText("%d:%02d%s", h, m, TIMEMANAGER_AM) -- One to noon (0100 to 1159), same in both 12- and 24-hour clocks. AM.
				end
			else 													
				if (h == 12) then
					time:SetFormattedText("%d:%02d%s", h, m, TIMEMANAGER_PM) -- Noon to 1PM - 1200-1259, displayed as 12PM 
				elseif h < 24 then
					time:SetFormattedText("%d:%02d%s", h - 12, m, TIMEMANAGER_PM) -- 1PM to Midnight - 1300-2359, displayed as (hour-12)PM 
				else 
					time:SetFormattedText("%d:%02d%s", h - 12, m, TIMEMANAGER_AM) -- Midnight (start of the NEXT day, listed as 12AM)
				end
			end
		end

		self.elapsedTime = 0
		self.refreshTime = nil
	end

	-- Update player coordinates
	self.elapsedCoords = (self.elapsedCoords or 0) + elapsed
	if self.elapsedCoords > .1 then 

		local coordinates = self.widgets.coordinates
		local x, y

		if ENGINE_BFA then 
			local mapID = C_Map.GetBestMapForUnit("player")
			if mapID then 
				local mapPosObject = C_Map.GetPlayerMapPosition(mapID, "player")
				if mapPosObject then 
					x, y = mapPosObject:GetXY()
				end 
			end 
		else 
			x, y = GetPlayerMapPosition("player")

			local worldMapVisible = WorldMapFrame:IsShown()
			if worldMapVisible then
				local mapID = GetCurrentMapAreaID()
				if (mapID ~= self.data.currentZoneID) then
					x, y = 0, 0
				end
			end
		end 

		x = x or 0
		y = y or 0

		if (x + y > 0) then
			coordinates:SetAlpha(1)
			coordinates:SetFormattedText("%.1f %.1f", x*100, y*100) -- "%02d, %02d" "%.2f %.2f"
		else
			coordinates:SetAlpha(0)
		end
		
		self.elapsedCoords = 0
	end

	local buttonBag = self.widgets.buttonBag
	if buttonBag then
		self.elapsedButtonBag = (self.elapsedButtonBag or 0) - elapsed
		if (self.elapsedButtonBag < 0)  then
			local hiddenButtons = buttonBag.buttons
			local checkedButtons = buttonBag.checkedButtons
			local oldMap = self.old.map
			local numChildren = oldMap:GetNumChildren()
			if (buttonBag.numButtons ~= numChildren) then
				local child
				for i = 1, numChildren do
					child = select(i, oldMap:GetChildren())
					if (child and not(checkedButtons[child]) and (child.HasScript and child:HasScript("OnClick")) and (child.GetName and child:GetName())) then 
						local ignore
						local childName = child:GetName()
						for name in pairs(buttonBag.ignoredButtons) do
							if childName:find(name) then
								ignore = true
								checkedButtons[child] = true
								break
							end
						end
						if (not ignore) then
							buttonBag.add(child)
						end
					end
				end
				self.numButtons = numChildren
			end
			self.elapsedButtonBag = 3
		end	
	end

end

Module.UpdateZoneData = function(self, event, ...)
	
	if (event == "PLAYER_ENTERING_WORLD") or (event == "ZONE_CHANGED_INDOORS") or (event == "ZONE_CHANGED_NEW_AREA") or (event == "WORLD_MAP_CLOSED") then
		-- Don't force this anymore, we don't want to mess with the WorldMap, 
		-- as zone changing when looking at things when taking a taxi is super annoying. 
		-- We're queueing all updates until the world map is closed now, like with the tracker.
		if (not ENGINE_BFA) and (not WorldMapFrame:IsShown()) then
			SetMapToCurrentZone() -- required for coordinates to function too
		end
	end

	local mapID
	if ENGINE_BFA then 
		mapID = C_Map.GetBestMapForUnit("player")
	else 
		mapID = GetCurrentMapAreaID()
	end 

	local minimapZoneName = GetMinimapZoneText()
	local pvpType, isSubZonePvP, factionName = GetZonePVPInfo()
	local zoneName = GetZoneText()
	local subzoneName = GetSubZoneText()
	local instance = IsInInstance()

	if (subzoneName == zoneName) then 
		subzoneName = "" 
	end

	-- This won't be available directly at first login
	local territory
	if pvpType == "sanctuary" then
		territory = SANCTUARY_TERRITORY
	elseif pvpType == "arena" then
		territory = FREE_FOR_ALL_TERRITORY
	elseif pvpType == "friendly" then
		territory = format(FACTION_CONTROLLED_TERRITORY, factionName)
	elseif pvpType == "hostile" then
		territory = format(FACTION_CONTROLLED_TERRITORY, factionName)
	elseif pvpType == "contested" then
		territory = CONTESTED_TERRITORY
	elseif pvpType == "combat" then
		territory = COMBAT_ZONE
	end

	if instance then
		local _
		local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize
		local groupType, isHeroic, isChallengeMode, toggleDifficultyID

		if ENGINE_MOP then
			name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo()
			_, groupType, isHeroic, isChallengeMode, toggleDifficultyID = GetDifficultyInfo(difficultyID)
		else
			name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic = GetInstanceInfo()
		end
		
		local maxMembers, instanceDescription
		if instanceType == "party" then
			if difficultyID == 2 then 
				instanceDescription = DUNGEON_DIFFICULTY2
			else
				instanceDescription = DUNGEON_DIFFICULTY1
			end
			maxMembers = 5
		elseif instanceType == "raid" then
			-- 10 player raids
			if difficultyID == 3 then 
				instanceDescription = RAID_DIFFICULTY1
				maxMembers = 10

			-- 25 player raids
			elseif difficultyID == 4 then 
				instanceDescription = RAID_DIFFICULTY2
				maxMembers = 25

			-- 10 player heoric
			elseif difficultyID == 5 then 
				instanceDescription = RAID_DIFFICULTY3
				maxMembers = 10

			-- 25 player heroic
			elseif difficultyID == 6 then 
				instanceDescription = RAID_DIFFICULTY4
				maxMembers = 25

			-- Legacy LFR (prior to Siege of Orgrimmar)
			elseif difficultyID == 7 then 
				instanceDescription = RAID 
				maxMembers = 25
			
			-- 40 player raids
			elseif difficultyID == 9 then 
				instanceDescription = RAID_DIFFICULTY_40PLAYER
				maxMembers = 40
			
			-- normal raid (WoD)
			elseif difficultyID == 14 then 

			-- heroic raid (WoD)
			elseif difficultyID == 15 then 

			-- mythic raid  (WoD)
			elseif difficultyID == 16 then 

			-- LFR 
			elseif difficultyID == 17 then 
				instanceDescription = RAID 
				maxMembers = 40
			end
		elseif instanceType == "scenario" then
		elseif instanceType == "arena" then
		elseif instanceType == "pvp" then
			instanceDescription = PVP
		else 
			-- "none" -- This shouldn't happen, ever.
		end
		if (IsInRaid() or IsInGroup()) then
			self.data.difficulty = instanceDescription or difficultyName
		else
			local where = instanceDescription or difficultyName
			if where and where ~= "" then
				self.data.difficulty = "(" .. SOLO .. ") " .. where
			else
				-- I'll be surprised if this ever occurs. 
				self.data.difficulty = SOLO
			end
		end
		self.data.instanceName = name or minimapZoneName or ""
	else
		-- make sure it doesn't bug out at login from unavailable data 
		if (territory and territory ~= "") then
			if IsInRaid() then
				self.data.difficulty = RAID .. " " .. territory 
			elseif IsInGroup() then
				self.data.difficulty = PARTY .. " " .. territory 
			else 
				self.data.difficulty = SOLO .. " " .. territory 
			end
		else
			if IsInRaid() then
				self.data.difficulty = RAID 
			elseif IsInGroup() then
				self.data.difficulty = PARTY 
			else 
				self.data.difficulty = SOLO
			end
		end
		self.data.instanceName = ""
	end
	
	self.data.currentZoneID = mapID
	self.data.minimapZoneName = minimapZoneName or ""
	self.data.zoneName = zoneName or ""
	self.data.subZoneName = subzoneName or ""
	self.data.pvpType = pvpType or ""
	self.data.territory = territory or ""

	self:UpdateZoneText()
end

Module.UpdateZoneText = function(self)
	local config = self.config 
	self.frame.widgets.zone:SetText(self.data.minimapZoneName)
	self.frame.widgets.zone:SetTextColor(unpack(C.General.Highlight))
	self.frame.widgets.difficulty:SetText(self.data.difficulty .. " ")
end

Module.GetFrame = function(self)
	return self.frame
end

Module.OnEvent = function(self, event, ...)
	if (event == "UPDATE_PENDING_MAIL") or (event == "PLAYER_ENTERING_WORLD") then 
		local playerMailFrame = self.frame.widgets.mail
		if HasNewMail() then
			playerMailFrame:Show()
			playerMailFrame:UpdateTooltip()
		else
			playerMailFrame:Hide()
		end
		if (event == "UPDATE_PENDING_MAIL") then 
			return 
		end
	end

	-- This might be causing taint when called in combat, better restrict it.
	if (event == "PLAYER_ENTERING_WORLD") or (event == "VARIABLES_LOADED") then 
		self:AlignMinimap(event, ...)
	end 

	self:UpdateZoneData(event, ...)
end

Module.AlignMinimap = function(self)
	local config = self:GetDB("Minimap")

	local map = self.frame.custom.map
	local mapContent = self.frame.custom.map.content

	mapContent:SetParent(self.frame) 
	mapContent:SetFrameLevel(2) 
	mapContent:SetResizable(true)
	mapContent:SetMovable(true)
	mapContent:SetUserPlaced(true)
	mapContent:ClearAllPoints()
	mapContent:SetPoint("CENTER", map, "CENTER", 0, 0)
	mapContent:SetSize(map:GetWidth(), map:GetHeight())
	mapContent:SetScale(1)
	mapContent:SetFrameStrata("LOW") 
	mapContent:SetFrameLevel(2)
	mapContent:SetMaskTexture(config.map.mask)
	mapContent:EnableMouseWheel(true)
	mapContent:SetScript("OnMouseWheel", onMouseWheel)
	mapContent:SetScript("OnMouseUp", onMouseUp)

	-- Getting dead tired of the random resizes. 
	mapContent.SetSize = function() end
	mapContent.SetWidth = function() end
	mapContent.SetHeight = function() end
	mapContent.SetParent = function() end
	mapContent.SetPoint = function() end
	mapContent.SetAllPoints = function() end
	mapContent.ClearAllPoints = function() end
end

Module.InitMap = function(self)
	local config = self:GetDB("Minimap")
end

Module.InitMBB = function(self)
	local config = self:GetDB("Minimap")
	local mapContent = self.frame.custom.map.content

	local mbbFrame = _G.MBB_MinimapButtonFrame
	mbbFrame:SetParent(self.frame.scaffold.border)
	mbbFrame:SetFrameStrata("MEDIUM") -- Get it above the map which is in LOW
	mbbFrame:RegisterForDrag()
	mbbFrame:SetSize(unpack(config.widgets.buttonBag.size)) 
	mbbFrame:ClearAllPoints()
	mbbFrame:SetPoint(unpack(config.widgets.buttonBag.point))
	mbbFrame:SetHighlightTexture("") 
	mbbFrame:DisableDrawLayer("OVERLAY") 

	mbbFrame.ClearAllPoints = function() end
	mbbFrame.SetPoint = function() end
	mbbFrame.SetAllPoints = function() end

	local mbbIcon = _G.MBB_MinimapButtonFrame_Texture
	mbbIcon:ClearAllPoints()
	mbbIcon:SetPoint("CENTER", 0, 0)
	mbbIcon:SetSize(unpack(config.widgets.buttonBag.size))
	mbbIcon:SetTexture(config.widgets.buttonBag.texture)
	mbbIcon:SetTexCoord(0,1,0,1)
	mbbIcon:SetAlpha(.85)
	
	local down, over
	local setalpha = function()
		if (down and over) then
			mbbIcon:SetAlpha(1)
		elseif (down or over) then
			mbbIcon:SetAlpha(.95)
		else
			mbbIcon:SetAlpha(.85)
		end
	end

	mbbFrame:SetScript("OnMouseDown", function(self) 
		down = true
		setalpha()
	end)

	mbbFrame:SetScript("OnMouseUp", function(self) 
		down = false
		setalpha()
	end)

	mbbFrame:SetScript("OnEnter", function(self) 
		over = true
		_G.MBB_ShowTimeout = -1

		if (not GameTooltip:IsForbidden()) then
			GameTooltip:SetOwner(mapContent, "ANCHOR_PRESERVE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("TOPRIGHT", mapContent, "TOPLEFT", -10, -10)
			GameTooltip:AddLine("MinimapButtonBag v" .. MBB_Version)
			GameTooltip:AddLine(MBB_TOOLTIP1, 0, 1, 0)
			GameTooltip:Show()
		end

		setalpha()
	end)

	mbbFrame:SetScript("OnLeave", function(self) 
		over = false
		_G.MBB_ShowTimeout = 0

		if (not GameTooltip:IsForbidden()) then
			GameTooltip:Hide()
		end

		setalpha()
	end)

end

Module.WaitForMBB = function(self, event, addon)
	if (addon == "MBB") then
		self:InitMBB()
		self:UnregisterEvent("ADDON_LOADED", "WaitForMBB")
	end
end

Module.OnInit = function(self)
	local config = self:GetDB("Minimap")
	local db = self:GetConfig("Minimap")
	local data = {
		currentZoneID = 0,
		minimapZoneName = "",
		difficulty = "",
		instanceName = "",
		zoneName = "",
		subZoneName = "",
		pvpType = "", 
		territory = ""
	}

	local old = {}
	local scaffold = {}
	local custom = {}
	local widgets = {}

	local oldBackdrop = MinimapBackdrop
	oldBackdrop:SetMovable(true)
	oldBackdrop:SetUserPlaced(true)
	oldBackdrop:ClearAllPoints()
	oldBackdrop:SetPoint("CENTER", -8, -23)

	-- The global function GetMaxUIPanelsWidth() calculates the available space for 
	-- blizzard windows such as the character frame, pvp frame etc based on the 
	-- position of the MinimapCluster. 
	-- Unless the MinimapCluster is set to movable and user placed, it will be assumed
	-- that it's still in its default position, and the end result will be.... bad. 
	-- In this case it caused the blizzard UI to think there was no space at all, 
	-- and all the frames would spawn in the exact same place. 
	-- Setting it to movable and user placed solved it. :)
	local oldCluster = MinimapCluster
	oldCluster:SetMovable(true)
	oldCluster:SetUserPlaced(true)
	oldCluster:ClearAllPoints()
	oldCluster:EnableMouse(false)
	
	-- bottom layer, handles pet battle hiding(?)
	--	self.frame = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
	--	RegisterStateDriver(self.frame, "visibility", "[petbattle] hide; show")
	local frame = Engine:CreateFrame("Frame", nil, "UICenter")
	frame:SetFrameStrata("LOW")
	frame:SetFrameLevel(0)
	frame:SetSize(config.size[1], config.size[2])
	frame:Place(unpack(config.point))

	-- visibility layer to better control the visibility of the minimap
	local visibility = frame:CreateFrame()
	visibility:SetAllPoints()
	visibility:SetFrameStrata("LOW")
	visibility:SetFrameLevel(0)

	-- We could hook these messages directly to the minimap, but for the purpose of semantics 
	-- and easier future compatibility if we decide to make a fully custom minimap, 
	-- we keep them connected to our own visibility layer instead. 
	visibility:HookScript("OnHide", function() self:SendMessage("ENGINE_MINIMAP_VISIBLE_CHANGED", false) end)
	visibility:HookScript("OnShow", function() self:SendMessage("ENGINE_MINIMAP_VISIBLE_CHANGED", true) end)
	
	-- border layer meant to place widgets in
	local border = visibility:CreateFrame()
	border:SetAllPoints()
	border:SetFrameLevel(4)

	-- minimap holder
	local map = visibility:CreateFrame()
	map:SetFrameStrata("LOW") 
	map:SetFrameLevel(2)
	map:SetPoint(unpack(config.map.point))
	map:SetSize(unpack(config.map.size))

	oldCluster:SetAllPoints(map)
	oldBackdrop:SetParent(map)

	local UIHider = CreateFrame("Frame")
	UIHider:Hide()
	UIHider.Show = UIHider.Hide

	-- Parent the minimap to our dummy, 
	-- and let the user decide minimap visibility 
	-- by hooking our own regions' visibility to it.
	local oldMinimap = Minimap
	oldMinimap:SetParent(frame) 
	oldMinimap:SetFrameLevel(2) 
	oldMinimap:HookScript("OnHide", function() visibility:Hide() end)
	oldMinimap:HookScript("OnShow", function() visibility:Show() end)

	-- In Cata and again in WoD the blob textures turned butt fugly, 
	-- so we change the settings to something far easier on the eye, 
	-- and also a lot easier to navigate with.
	if ENGINE_CATA then
		-- These "alpha" values range from 0 to 255, for some obscure reason,
		-- so a value of 127 would be 127/255 ≃ 0.5ish in the normal API.
		oldMinimap:SetQuestBlobInsideAlpha(0) -- "blue" areas with quest mobs/items in them
		oldMinimap:SetQuestBlobOutsideAlpha(127) -- borders around the "blue" areas 
		oldMinimap:SetQuestBlobRingAlpha(0) -- the big fugly edge ring texture!
		oldMinimap:SetQuestBlobRingScalar(0) -- ring texture inside quest areas?

		oldMinimap:SetArchBlobInsideAlpha(0) -- "blue" areas with quest mobs/items in them
		oldMinimap:SetArchBlobOutsideAlpha(127) -- borders around the "blue" areas 
		oldMinimap:SetArchBlobRingAlpha(0) -- the big fugly edge ring texture!
		oldMinimap:SetArchBlobRingScalar(0) -- ring texture inside quest areas?

		if ENGINE_WOD then
			oldMinimap:SetTaskBlobInsideAlpha(0) -- "blue" areas with quest mobs/items in them
			oldMinimap:SetTaskBlobOutsideAlpha(127) -- borders around the "blue" areas 
			oldMinimap:SetTaskBlobRingAlpha(0) -- the big fugly edge ring texture!
			oldMinimap:SetTaskBlobRingScalar(0) -- ring texture inside quest areas?
		end	
	end

	-- minimap content/real map (size it to the map holder)
	-- *enables mousewheel zoom, and right click tracking menu
	local mapContent = oldMinimap
	mapContent:SetResizable(true)
	mapContent:SetMovable(true)
	mapContent:SetUserPlaced(true)
	mapContent:ClearAllPoints()
	mapContent:SetPoint("CENTER", map, "CENTER", 0, 0)
	mapContent:SetFrameStrata("LOW") 
	mapContent:SetFrameLevel(2)
	mapContent:SetMaskTexture(config.map.mask)
	mapContent:SetBlipTexture(config.map.blips)
	mapContent:EnableMouseWheel(true)
	mapContent:SetScript("OnMouseWheel", onMouseWheel)
	mapContent:SetScript("OnMouseUp", onMouseUp)

	mapContent:SetSize(map:GetWidth(), map:GetHeight())
	mapContent:SetScale(1)

	-- Register our Minimap as a keyword with the Engine, 
	-- to capture other module's attempt to anchor to it.
	Engine:RegisterKeyword("Minimap", function() return mapContent end)

	-- Add a dark backdrop using the mask texture
	local mapBackdrop = visibility:CreateTexture()
	mapBackdrop:SetDrawLayer("BACKGROUND")
	mapBackdrop:SetPoint("CENTER", map, "CENTER", 0, 0)
	mapBackdrop:SetSize(map:GetWidth(), map:GetHeight())
	mapBackdrop:SetTexture(config.map.mask)
	mapBackdrop:SetVertexColor(0, 0, 0, 1)

	-- Add a dark overlay using the mask texture
	local mapOverlayHolder = visibility:CreateFrame()
	mapOverlayHolder:SetFrameLevel(3)
	--mapOverlayHolder:SetAllPoints()
	
	local mapOverlay = mapContent:CreateTexture()
	--local mapOverlay = mapOverlayHolder:CreateTexture()
	mapOverlay:SetDrawLayer("BORDER")
	mapOverlay:SetPoint("CENTER", map, "CENTER", 0, 0)
	mapOverlay:SetSize(map:GetWidth(), map:GetHeight())
	mapOverlay:SetTexture(config.map.mask)
	mapOverlay:SetVertexColor(0, 0, 0, .15)

	local mapBorder = border:CreateTexture()
	mapBorder:SetDrawLayer("BACKGROUND")
	mapBorder:SetPoint(unpack(config.border.point))
	mapBorder:SetSize(unpack(config.border.size))
	mapBorder:SetTexture(config.border.path)


	-- player coordinates
	local playerCoordinates = border:CreateFontString()
	playerCoordinates:SetFontObject(config.text.coordinates.normalFont)
	playerCoordinates:SetTextColor(unpack(C.General.Title))
	playerCoordinates:SetDrawLayer("OVERLAY", 3)
	playerCoordinates:Place(unpack(config.text.coordinates.point))
	playerCoordinates:SetJustifyV("BOTTOM")
	
	-- mail notifications
	local playerMailFrame = border:CreateFrame("Frame")
	playerMailFrame:SetPoint("BOTTOM", playerCoordinates, "TOP", 0, 2)
	playerMailFrame:Hide()

	local playerMail = playerMailFrame:CreateFontString()
	playerMail:SetFontObject(config.text.coordinates.normalFont)
	playerMail:SetTextColor(unpack(C.General.Title))
	playerMail:SetDrawLayer("OVERLAY", 3)
	playerMail:SetPoint("BOTTOM", playerCoordinates, "TOP", 0, 2)
	playerMail:SetJustifyV("BOTTOM")
	playerMail:SetText(L["New Mail!"])
	playerMail:SetTextColor(1, 1, 1, 1)

	playerMailFrame.OnEnter = function(self)
		if (GameTooltip:IsForbidden()) then 
			return 
		end
		GameTooltip:SetOwner(mapContent, "ANCHOR_PRESERVE")
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPRIGHT", mapContent, "TOPLEFT", -10, -10)
		self:UpdateTooltip()
	end
	
	playerMailFrame.OnLeave = function(self)
		if (GameTooltip:IsForbidden()) then 
			return 
		end
		GameTooltip:Hide()
	end 

	playerMailFrame.UpdateTooltip = function(self)
		if (GameTooltip:IsForbidden()) or (not GameTooltip:IsOwned(mapContent)) then 
			return 
		end

		local sender1,sender2,sender3 = GetLatestThreeSenders()
		local toolText
		
		if( sender1 or sender2 or sender3 ) then
			toolText = HAVE_MAIL_FROM
		else
			toolText = HAVE_MAIL
		end
		
		if sender1 then
			toolText = toolText.."|n"..sender1
		end
		if sender2 then
			toolText = toolText.."|n"..sender2
		end
		if sender3 then
			toolText = toolText.."|n"..sender3
		end
		GameTooltip:SetText(toolText)
	end

	playerMailFrame:SetPoint("LEFT", playerMail, "LEFT", 0, 0)
	playerMailFrame:SetPoint("RIGHT", playerMail, "RIGHT", 0, 0)
	playerMailFrame:SetPoint("TOP", playerMail, "TOP", 0, 0)
	playerMailFrame:SetScript("OnEnter",playerMailFrame.OnEnter )
	playerMailFrame:SetScript("OnLeave", playerMailFrame.OnLeave)


	-- Holder frame for widgets that should remain visible 
	-- even when the minimap is hidden.
	local info = Engine:CreateFrame("Frame", nil, "UICenter")
	info:SetFrameStrata("LOW") 
	info:SetFrameLevel(5)

	-- zone name
	local zoneName = info:CreateFontString()
	zoneName:SetFontObject(config.text.zone.normalFont)
	zoneName:SetDrawLayer("ARTWORK", 0)
	zoneName:Place(unpack(config.text.zone.point))
	zoneName:SetJustifyV("BOTTOM")

	-- time
	local time = info:CreateFontString()
	time:SetFontObject(config.text.time.normalFont)
	time:SetDrawLayer("ARTWORK", 0)
	time:SetTextColor(C.General.Title[1], C.General.Title[2], C.General.Title[3])
	time:Place(unpack(config.text.time.point))
	time:SetJustifyV("BOTTOM")

	local timeClick = info:CreateFrame("Button")
	timeClick:SetAllPoints(time)
	timeClick:RegisterForClicks("RightButtonUp", "LeftButtonUp", "MiddleButtonUp")
	timeClick.UpdateTooltip = function(self)
		if GameTooltip:IsForbidden() then
			return
		end

		local localTime, realmTime
		local dateTable = date("*t")
		local h, m = dateTable.hour,  dateTable.min 
		local gH, gM = GetGameTime()

		if db.use24hrClock then
			localTime = string_format("%02d:%02d", h, m)
			realmTime = string_format("%02d:%02d", gH, gM)
		else
			if (h > 12) then 
				localTime = string_format("%d:%02d%s", h - 12, m, TIMEMANAGER_PM)
			elseif (h < 1) then
				localTime = string_format("%d:%02d%s", h + 12, m, TIMEMANAGER_AM)
			else
				localTime = string_format("%d:%02d%s", h, m, TIMEMANAGER_AM)
			end
			if (gH > 12) then 
				realmTime = string_format("%d:%02d%s", gH - 12, gM, TIMEMANAGER_PM)
			elseif (gH < 1) then
				realmTime = string_format("%d:%02d%s", gH + 12, gM, TIMEMANAGER_AM)
			else
				realmTime = string_format("%d:%02d%s", gH, gM, TIMEMANAGER_AM)
			end
		end

		local r, g, b = unpack(C.General.OffWhite)

		GameTooltip:SetOwner(mapContent, "ANCHOR_PRESERVE")
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPRIGHT", mapContent, "TOPLEFT", -10, -10)
		GameTooltip:AddLine(TIMEMANAGER_TITLE)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_LOCALTIME, localTime, r, g, b)
		GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_REALMTIME, realmTime, r, g, b)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["<Left-click> to toggle calendar."], unpack(C.General.OffGreen))
		GameTooltip:AddLine(L["<Right-click> to toggle 12/24-hour clock."], unpack(C.General.OffGreen))
		GameTooltip:AddLine(L["<Middle-click> to toggle local/game time."], unpack(C.General.OffGreen))
		GameTooltip:Show()
	end

	timeClick:SetScript("OnEnter", timeClick.UpdateTooltip)
	timeClick:SetScript("OnLeave", function(self) 
		if (not GameTooltip:IsForbidden()) then
			GameTooltip:Hide() 
		end
	end)
	timeClick:SetScript("OnClick", function(_, mouseButton)
		if (mouseButton == "LeftButton") then
			ToggleCalendar()
		elseif (mouseButton == "MiddleButton") then 
			db.useGameTime = not db.useGameTime
			timeClick:UpdateTooltip()
			self.frame.refreshTime = true
		elseif (mouseButton == "RightButton") then 
			db.use24hrClock = not db.use24hrClock
			timeClick:UpdateTooltip()
			self.frame.refreshTime = true
		end
	end)


	-- group and difficulty status
	local zoneDifficulty = info:CreateFontString()
	zoneDifficulty:SetFontObject(config.text.time.normalFont)
	zoneDifficulty:SetDrawLayer("ARTWORK", 0)
	zoneDifficulty:SetTextColor(unpack(C.General.Title))
	zoneDifficulty:SetPoint("BOTTOMRIGHT", time, "BOTTOMLEFT", 0, 0)
	zoneDifficulty:SetJustifyV("BOTTOM")


	-- group finder button(s)

	--local groupConfig = config.widgets.group
	if ENGINE_MOP then
		local queueButton = _G.QueueStatusMinimapButton
		if queueButton then
			local button = border:CreateFrame()
			button:SetPoint(unpack(config.widgets.group.point))
			button:SetSize(unpack(config.widgets.group.size))

			queueButton:SetParent(button)
			--queueButton:SetFrameLevel(5)
			queueButton:ClearAllPoints()
			queueButton:SetPoint("CENTER", 0, 0)
			queueButton:SetSize(unpack(config.widgets.group.size))

			local borderTexture = queueButton:CreateTexture()
			borderTexture:SetDrawLayer("BORDER")
			borderTexture:SetPoint(unpack(config.widgets.group.border_point))
			borderTexture:SetSize(unpack(config.widgets.group.border_size))
			borderTexture:SetTexture(config.widgets.group.border_texture)
			borderTexture:SetTexCoord(unpack(config.widgets.group.border_texcoord))

			local iconTexture = queueButton:CreateTexture()
			iconTexture:SetDrawLayer("ARTWORK")
			iconTexture:SetPoint(unpack(config.widgets.group.icon_point))
			iconTexture:SetSize(unpack(config.widgets.group.icon_size))
			iconTexture:SetTexture(config.widgets.group.icon_texture)
			iconTexture:SetTexCoord(unpack(config.widgets.group.icon_texcoord))
		end
	else
		local lfgButton = _G.MiniMapLFGFrame
		if lfgButton then
			local button = border:CreateFrame()
			button:SetPoint(unpack(config.widgets.group.point))
			button:SetSize(unpack(config.widgets.group.size))

			lfgButton:SetParent(button)
			--lfgButton:SetFrameLevel(5)
			lfgButton:ClearAllPoints()
			lfgButton:SetPoint("CENTER", 0, 0)
			lfgButton:SetSize(unpack(config.widgets.group.size))

			local borderTexture = lfgButton:CreateTexture()
			borderTexture:SetDrawLayer("BORDER")
			borderTexture:SetPoint(unpack(config.widgets.group.border_point))
			borderTexture:SetSize(unpack(config.widgets.group.border_size))
			borderTexture:SetTexture(config.widgets.group.border_texture)
			borderTexture:SetTexCoord(unpack(config.widgets.group.border_texcoord))

			local iconTexture = lfgButton:CreateTexture()
			iconTexture:SetDrawLayer("ARTWORK")
			iconTexture:SetPoint(unpack(config.widgets.group.icon_point))
			iconTexture:SetSize(unpack(config.widgets.group.icon_size))
			iconTexture:SetTexture(config.widgets.group.icon_texture)
			iconTexture:SetTexCoord(unpack(config.widgets.group.icon_texcoord))
		end

		local pvpButton = _G.MiniMapBattlefieldFrame
		if pvpButton then
			local button = border:CreateFrame()
			button:SetPoint(unpack(config.widgets.group.point))
			button:SetSize(unpack(config.widgets.group.size))

			pvpButton:SetParent(button)
			--pvpButton:SetFrameLevel(5)
			pvpButton:ClearAllPoints()
			pvpButton:SetPoint("CENTER", 0, 0)
			pvpButton:SetSize(unpack(config.widgets.group.size))

			local borderTexture = pvpButton:CreateTexture()
			borderTexture:SetDrawLayer("BORDER")
			borderTexture:SetPoint(unpack(config.widgets.group.border_point))
			borderTexture:SetSize(unpack(config.widgets.group.border_size))
			borderTexture:SetTexture(config.widgets.group.border_texture)
			borderTexture:SetTexCoord(unpack(config.widgets.group.border_texcoord))

			local iconTexture = pvpButton:CreateTexture()
			iconTexture:SetDrawLayer("ARTWORK")
			iconTexture:SetPoint(unpack(config.widgets.group.icon_point))
			iconTexture:SetSize(unpack(config.widgets.group.icon_size))
			iconTexture:SetTexture(config.widgets.group.icon_texture)
			iconTexture:SetTexCoord(unpack(config.widgets.group.icon_texcoord))
		end
	end

	-- buttonbags
	-- Style the MBB button
	if (not MBF) and MBB then
		if IsAddOnLoaded("MBB") then 
			self:InitMBB("MBB")
		else
			self:RegisterEvent("ADDON_LOADED", "WaitForMBB")
		end
	end

	-- Initiate or own button grabber
	if not(MBB or MBF) then

		-- Use an extra layer to hide it
		local buttonBagHider = frame:CreateFrame("Frame")
		buttonBagHider:Hide() 

		-- The actual bag that captures all buttons
		local buttonBag = buttonBagHider:CreateFrame("Frame")
		buttonBag.numButtons = 0
		buttonBag.hiddenButtons = {}
		buttonBag.checkedButtons = {}
		buttonBag.ignoredButtons = {
			-- New icon list added Feb 1st 2018 (imported from gUI4)
			BookOfTracksFrame = true,
			CartographerNotesPOI = true,
			DA_Minimap = true,
			FWGMinimapPOI = true,
			GatherArchNote = true,
			GatherMatePin = true,
			GatherNote = true,
			HandyNotesPin = true,
			MiniNotePOI = true,
			poiMinimap = true,
			QuestPointerPOI = true,	
			RecipeRadarMinimapIcon = true,
			TDial_TrackButton = true,
			TDial_TrackingIcon = true,

			--FishingExtravaganzaMini = true,
			MBB_MinimapButtonFrame = true,
			MinimapButtonFrame = true,
			--MiniMapPing = true,
			ZGVMarker = true
		}
		buttonBag.add = function(button)
			buttonBag.numButtons = buttonBag.numButtons + 1
			buttonBag.hiddenButtons[button] = true
			button:SetParent(buttonBag)
			button:SetSize(24,24)
			button:ClearAllPoints() 
			button:SetPoint("TOPLEFT", 0, 0)
			button:SetPoint("BOTTOMRIGHT", 0, 0)
		end
		widgets.buttonBag = buttonBag
	end



	-- Mapping
	---------------------------------------------------------------
	self.config = config
	self.data = data
	self.db = db

	self.frame = frame
	self.frame.db = db 
	self.frame.data = data 
	self.frame.visibility = visibility

	self.frame.scaffold = scaffold
	self.frame.scaffold.border = border

	self.frame.custom = custom
	self.frame.custom.info = info
	self.frame.custom.map = map
	self.frame.custom.map.content = mapContent
	self.frame.custom.map.overlay = mapOverlay

	self.frame.widgets = widgets
	self.frame.widgets.time = time
	self.frame.widgets.zone = zoneName
	self.frame.widgets.difficulty = zoneDifficulty
	self.frame.widgets.coordinates = playerCoordinates
	self.frame.widgets.mail = playerMailFrame
	self.frame.widgets.finder = finder

	self.frame.old = old 
	self.frame.old.map = oldMinimap
	self.frame.old.backdrop = oldBackdrop
	self.frame.old.cluster = oldCluster

end

Module.OnEnable = function(self)
	BlizzardUI:GetElement("Minimap"):Disable()
	BlizzardUI:GetElement("Menu_Option"):Remove(true, "InterfaceOptionsDisplayPanelShowClock")

	-- Faking an event here
	WorldMapFrame:HookScript("OnHide", function() self:OnEvent("WORLD_MAP_CLOSED") end)	

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnEvent")
	self:RegisterEvent("VARIABLES_LOADED", "OnEvent")
	self:RegisterEvent("UPDATE_PENDING_MAIL", "OnEvent")

	self:UpdateZoneData()

	-- Initiate updates for time, coordinates, etc
	self.frame:SetScript("OnUpdate", onUpdate)

	-- Report the initial minimap visibility, and enforce booleans (avoid the 1/nil blizzard is so fond of)
	-- *Note that I plan to make minimap visibility save between sessions, so strictly speaking this is not redundant, 
	--  event though the minimap technically always is visible at /reload. 
	self:SendMessage("ENGINE_MINIMAP_VISIBLE_CHANGED", not not(self.frame.visibility:IsShown()))

end
