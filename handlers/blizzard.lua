local _, Engine = ... 
local Handler = Engine:NewHandler("BlizzardUI")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local assert = assert
local error = error
local pairs = pairs
local select = select
local type = type
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCVarBool = _G.GetCVarBool
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded
local RegisterStateDriver = _G.RegisterStateDriver
local SetCVar = _G.SetCVar
local TargetofTarget_Update = _G.TargetofTarget_Update

-- WoW Frames & Tables
local UIParent = _G.UIParent

-- Frame to securely hide items
local UIHider = CreateFrame("Frame", nil, UIParent)
UIHider:Hide()
UIHider:SetPoint("TOPLEFT", 0, 0)
UIHider:SetPoint("BOTTOMRIGHT", 0, 0)
UIHider.children = {}
RegisterStateDriver(UIHider, "visibility", "hide")

------------------------------------------------------------------------
--	Utility Functions
------------------------------------------------------------------------

-- proxy function (we eliminate the need for the 'self' argument)
local check = function(...) return Engine:Check(...) end

local getFrame = function(baseName)
	if type(baseName) == "string" then
		return _G[baseName]
	else
		return baseName
	end
end

-- kill off an existing frame in a secure, taint free way
-- @usage kill(object, [keepEvents], [silent])
-- @param object <table, string> frame, fontstring or texture to hide
-- @param keepEvents <boolean, nil> 'true' to leave a frame's events untouched
-- @param silent <boolean, nil> 'true' to return 'false' instead of producing an error for non existing objects
local kill = function(object, keepEvents, silent)
	check(object, 1, "string", "table")
	check(keepEvents, 2, "boolean", "nil")
	if type(object) == "string" then
		if silent and not _G[object] then
			return false
		end
		assert(_G[object], L["Bad argument #%d to '%s'. No object named '%s' exists."]:format(1, "Kill", object))
		object = _G[object]
	end
	if not UIHider[object] then
		UIHider[object] = {
			parent = object:GetParent(),
			isshown = object:IsShown(),
			point = { object:GetPoint() }
		}
	end
	object:SetParent(UIHider)
	if object.UnregisterAllEvents and not keepEvents then
		object:UnregisterAllEvents()
	end
	return true
end


------------------------------------------------------------------------
--	Unit Frames
------------------------------------------------------------------------

local killUnitFrame = function(baseName, keepParent)
	local frame = getFrame(baseName)
	if frame then
		if not keepParent then
			kill(frame, false, true)
		end
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", -400, 500)

		local health = frame.healthbar
		if health then
			health:UnregisterAllEvents()
		end

		local power = frame.manabar
		if power then
			power:UnregisterAllEvents()
		end

		local spell = frame.spellbar
		if spell then
			spell:UnregisterAllEvents()
		end

		local altpowerbar = frame.powerBarAlt
		if altpowerbar then
			altpowerbar:UnregisterAllEvents()
		end
	end
end

-- @usage disableUnitFrame(unit)
-- @description disables a unitframe based on "unit"
-- @param unit <string> the unitID of the unit whose blizzard frame to disable (http://wowpedia.org/UnitId)
local disableUnitFrame = function(unit)
	if unit == "focus-target" then unit = "focustarget" end
	if unit == "playerpet" then unit = "pet" end
	if unit == "tot" then unit = "targettarget" end
	if unit == "player" then
		local PlayerFrame = _G.PlayerFrame
		local MonkStaggerBar = _G.MonkStaggerBar

		killUnitFrame(PlayerFrame)
		
		-- A lot of blizz modules relies on PlayerFrame.unit
		-- This includes the aura frame and several others. 
		PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		PlayerFrame:RegisterEvent("UNIT_ENTERING_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_EXITING_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_EXITED_VEHICLE")

		-- User placed frames don't animate
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetDontSavePosition(true)

		-- Disable stagger bar events in MoP and higher
		if MonkStaggerBar then
			MonkStaggerBar:UnregisterAllEvents()
		end

	elseif unit == "pet" then
		killUnitFrame(_G.PetFrame)
	elseif unit == "target" then
		killUnitFrame(_G.TargetFrame)
		killUnitFrame(_G.ComboFrame)
	elseif unit == "focus" then
		killUnitFrame(_G.FocusFrame)
		killUnitFrame(_G.TargetofFocusFrame)
	elseif unit == "targettarget" then
		local TargetFrameToT = _G.TargetFrameToT
		-- originalValue["showTargetOfTarget"] = GetCVar("showTargetOfTarget")
		--SetCVar("showTargetOfTarget", "0", "SHOW_TARGET_OF_TARGET_TEXT")
		--SHOW_TARGET_OF_TARGET = "0" -- causes taint!!
		TargetofTarget_Update(TargetFrameToT)
		killUnitFrame(TargetFrameToT)
	elseif unit:match("(boss)%d?$") == "boss" then
		local id = unit:match("boss(%d)")
		if id then
			killUnitFrame("Boss" .. id .. "TargetFrame")
		else
			for i=1, 4 do
				killUnitFrame(("Boss%dTargetFrame"):format(i))
			end
		end
	elseif unit:match("(party)%d?$") == "party" then
		local id = unit:match("party(%d)")
		if id then
			killUnitFrame("PartyMemberFrame" .. id)
		else
			for i=1, 4 do
				killUnitFrame(("PartyMemberFrame%d"):format(i))
			end
		end
	elseif unit:match("(arena)%d?$") == "arena" then
		local id = unit:match("arena(%d)")
		if id then
			killUnitFrame("ArenaEnemyFrame" .. id)
		else
			for i=1, 4 do
				killUnitFrame(("ArenaEnemyFrame%d"):format(i))
			end
		end

		-- Blizzard_ArenaUI should not be loaded
		_G.Arena_LoadUI = function() end
		SetCVar("showArenaEnemyFrames", "0", "SHOW_ARENA_ENEMY_FRAMES_TEXT")
	end
end

local elements = {
	Menu_Panel = {
		Remove = function(self, panel_id, panel_name)
			-- remove an entire blizzard options panel, 
			-- and disable its automatic cancel/okay functionality
			-- this is needed, or the option will be reset when the menu closes
			-- it is also a major source of taint related to the Compact group frames!
			if panel_id then
				local category = _G["InterfaceOptionsFrameCategoriesButton" .. panel_id]
				if category then
					category:SetScale(0.00001)
					category:SetAlpha(0)
				end
			end
			if panel_name then
				local panel = _G[panel_name]
				if panel then
					panel:SetParent(UIHider)
					if panel.UnregisterAllEvents then
						panel:UnregisterAllEvents()
					end
					panel.cancel = function() end
					panel.okay = function() end
					panel.refresh = function() end
				end
			end
		end
	},
	Menu_Option = {
		Remove = function(self, option_shrink, option_name)
			local option = _G[option_name]
			if not(option) or not(option.IsObjectType) or not(option:IsObjectType("Frame")) then
				return
			end
			option:SetParent(UIHider)
			if option.UnregisterAllEvents then
				option:UnregisterAllEvents()
			end
			if option_shrink then
				option:SetHeight(0.00001)
				option:SetScale(0.00001) -- needed for the options to shrink properly. Watch out for side effects(?)
			end
			option.cvar = ""
			option.uvar = ""
			option.value = nil
			option.oldValue = nil
			option.defaultValue = nil
			option.setFunc = function() end
		end
	},

	ActionBars = {
		OnDisable = function(self, ...)
			local _G = _G
			local UIHider = UIHider
			local ExtraActionBarFrame = _G.ExtraActionBarFrame
			local MainMenuBar = _G.MainMenuBar
			local MainMenuBarArtFrame = _G.MainMenuBarArtFrame
			local MainMenuBarMaxLevelBar = _G.MainMenuBarMaxLevelBar
			local MainMenuExpBar = _G.MainMenuExpBar
			local MultiBarBottomLeft = _G.MultiBarBottomLeft
			local MultiBarBottomRight = _G.MultiBarBottomRight
			local MultiBarLeft = _G.MultiBarLeft
			local MultiBarRight = _G.MultiBarRight
			local PetActionBarFrame = _G.PetActionBarFrame
			local PossessBarFrame = _G.PossessBarFrame
			local ReputationWatchBar = _G.ReputationWatchBar
			local StreamingIcon = _G.StreamingIcon
			local TutorialFrameAlertButton = _G.TutorialFrameAlertButton
			local UIPARENT_MANAGED_FRAME_POSITIONS = _G.UIPARENT_MANAGED_FRAME_POSITIONS

			MainMenuBar:EnableMouse(false)
			MainMenuBar:UnregisterAllEvents()
			MainMenuBar:SetAlpha(0)
			MainMenuBar:SetScale(0.00001)

			MainMenuBarArtFrame:UnregisterAllEvents()
			MainMenuBarArtFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE") -- make the character currency tab appear (not working in BfA)
			MainMenuBarArtFrame:Hide()
			MainMenuBarArtFrame:SetAlpha(0)
			MainMenuBarArtFrame:SetParent(UIHider)

			MainMenuExpBar:EnableMouse(false)
			MainMenuExpBar:UnregisterAllEvents()
			MainMenuExpBar:Hide()
			MainMenuExpBar:SetAlpha(0)
			MainMenuExpBar:SetScale(0.00001)
			MainMenuExpBar:SetParent(UIHider)

			-- Trying to work around a bug sometimes happening
			-- on level 20 starter edition characters. 
			MainMenuExpBar:SetScript("OnShow", nil)
			MainMenuExpBar:SetScript("OnHide", nil)
			MainMenuExpBar:SetScript("OnEvent", nil)
			MainMenuExpBar:SetScript("OnUpdate", nil)
			MainMenuExpBar:SetScript("OnEnter", nil)
			MainMenuExpBar:SetScript("OnLeave", nil)
			MainMenuExpBar:SetScript("OnValueChanged", nil)

			local BonusActionBarFrame = _G.BonusActionBarFrame
			local VehicleMenuBar = _G.VehicleMenuBar

			BonusActionBarFrame:UnregisterAllEvents()
			BonusActionBarFrame:Hide()
			BonusActionBarFrame:SetAlpha(0)
			
			VehicleMenuBar:UnregisterAllEvents()
			VehicleMenuBar:Hide()
			VehicleMenuBar:SetAlpha(0)
			VehicleMenuBar:SetScale(0.00001)

			PossessBarFrame:UnregisterAllEvents()
			PossessBarFrame:Hide()
			PossessBarFrame:SetAlpha(0)
			PossessBarFrame:SetParent(UIHider)

			PetActionBarFrame:EnableMouse(false)
			PetActionBarFrame:UnregisterAllEvents()
			PetActionBarFrame:SetParent(UIHider)
			PetActionBarFrame:Hide()
			PetActionBarFrame:SetAlpha(0)

			MultiBarBottomLeft:SetParent(UIHider)
			MultiBarBottomRight:SetParent(UIHider)
			MultiBarLeft:SetParent(UIHider)
			MultiBarRight:SetParent(UIHider)
			
			TutorialFrameAlertButton:UnregisterAllEvents()
			TutorialFrameAlertButton:Hide()

			MainMenuBarMaxLevelBar:SetParent(UIHider)
			MainMenuBarMaxLevelBar:Hide()
			ReputationWatchBar:SetParent(UIHider)

			-- Attempting to avoid bugs related to container frame repositioning,
			-- as events fired by the honor bare will initiate container anchor updates.
			if HonorWatchBar then
				HonorWatchBar:UnregisterAllEvents()
				HonorWatchBar:Hide()
			end
			
			local ShapeshiftBarFrame = _G.ShapeshiftBarFrame
			local ShapeshiftBarLeft = _G.ShapeshiftBarLeft
			local ShapeshiftBarMiddle = _G.ShapeshiftBarMiddle
			local ShapeshiftBarRight = _G.ShapeshiftBarRight

			ShapeshiftBarFrame:EnableMouse(false)
			ShapeshiftBarFrame:UnregisterAllEvents()
			ShapeshiftBarFrame:Hide()
			ShapeshiftBarFrame:SetAlpha(0)

			ShapeshiftBarLeft:Hide()
			ShapeshiftBarLeft:SetAlpha(0)

			ShapeshiftBarMiddle:Hide()
			ShapeshiftBarMiddle:SetAlpha(0)

			ShapeshiftBarRight:Hide()
			ShapeshiftBarRight:SetAlpha(0)

			for i = 1,12 do
				local ActionButton = _G["ActionButton" .. i]
				local MultiBarBottomLeftButton = _G["MultiBarBottomLeftButton" .. i]
				local MultiBarBottomRightButton = _G["MultiBarBottomRightButton" .. i]
				local MultiBarRightButton = _G["MultiBarRightButton" .. i]
				local MultiBarLeftButton = _G["MultiBarLeftButton" .. i]

				ActionButton:Hide()
				ActionButton:UnregisterAllEvents()
				ActionButton:SetAttribute("statehidden", true)

				MultiBarBottomLeftButton:Hide()
				MultiBarBottomLeftButton:UnregisterAllEvents()
				MultiBarBottomLeftButton:SetAttribute("statehidden", true)

				MultiBarBottomRightButton:Hide()
				MultiBarBottomRightButton:UnregisterAllEvents()
				MultiBarBottomRightButton:SetAttribute("statehidden", true)

				MultiBarRightButton:Hide()
				MultiBarRightButton:UnregisterAllEvents()
				MultiBarRightButton:SetAttribute("statehidden", true)

				MultiBarLeftButton:Hide()
				MultiBarLeftButton:UnregisterAllEvents()
				MultiBarLeftButton:SetAttribute("statehidden", true)
			end

			--UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarRight"] = nil
			--UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarLeft"] = nil
			--UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomLeft"] = nil
			--UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomRight"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["MainMenuBar"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["StanceBarFrame"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["PETACTIONBAR_YPOS"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["MULTICASTACTIONBAR_YPOS"] = nil

			
			if _G.PlayerTalentFrame then
				_G.PlayerTalentFrame:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
			else
				hooksecurefunc("TalentFrame_LoadUI", function() _G.PlayerTalentFrame:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED") end)
			end 
		end 
	},
	Auras = {
		OnDisable = function(self)
			local _G = _G
			local UIHider = UIHider
			local BuffFrame = _G.BuffFrame
			local TemporaryEnchantFrame = _G.TemporaryEnchantFrame

			BuffFrame:SetScript("OnLoad", nil)
			BuffFrame:SetScript("OnUpdate", nil)
			BuffFrame:SetScript("OnEvent", nil)
			BuffFrame:SetParent(UIHider)
			BuffFrame:UnregisterAllEvents()

			TemporaryEnchantFrame:SetScript("OnUpdate", nil)
			TemporaryEnchantFrame:SetParent(UIHider)

			local ConsolidatedBuffs = _G.ConsolidatedBuffs
			ConsolidatedBuffs:SetScript("OnUpdate", nil)
			ConsolidatedBuffs:SetParent(UIHider)
		end
	},
	Alerts = {
		OnDisable = function(self)
			self:DisableAlerts()
		end,
		DisableAlerts = function(self)
			if AlertFrame then
				--AlertFrame:UnregisterAllEvents()
				--AlertFrame:SetParent(UIHider)
			end
		end
	},
	CaptureBars = {
		OnDisable = function(self)
		end
	},
	CastBars = {
		Remove = function(self, unit)
			if unit == "player" then
				local _G = _G
				local UIHider = UIHider
				local CastingBarFrame = _G.CastingBarFrame
				local PetCastingBarFrame = _G.PetCastingBarFrame

				-- player's castbar
				CastingBarFrame:SetScript("OnEvent", nil)
				CastingBarFrame:SetScript("OnUpdate", nil)
				CastingBarFrame:SetParent(UIHider)
				CastingBarFrame:UnregisterAllEvents()
				
				-- player's pet's castbar
				PetCastingBarFrame:SetScript("OnEvent", nil)
				PetCastingBarFrame:SetScript("OnUpdate", nil)
				PetCastingBarFrame:SetParent(UIHider)
				PetCastingBarFrame:UnregisterAllEvents()
			end
		end
	},
	LevelUpDisplay = {
		OnDisable = function(self)
			if _G.LevelUpDisplay then
				self:DisableLevelUpDisplay()
			end
		end,
		DisableLevelUpDisplay = function(self)
			local LevelUpDisplay = _G.LevelUpDisplay
			
			LevelUpDisplay:UnregisterAllEvents()

			-- Older versions (Cata) lack this method
			if LevelUpDisplay.StopBanner then
				LevelUpDisplay:StopBanner()
			end
		end
	},
	Minimap = {
		OnDisable = function(self)
			local _G = _G
			local UIHider = UIHider
			local GameTimeFrame = _G.GameTimeFrame
			local TimeManagerClockButton = _G.TimeManagerClockButton

			GameTimeFrame:SetParent(UIHider)
			GameTimeFrame:UnregisterAllEvents()

			_G.MinimapBorder:SetParent(UIHider)
			_G.MinimapBorderTop:SetParent(UIHider)
			_G.MinimapCluster:SetParent(UIHider)
			_G.MiniMapMailBorder:SetParent(UIHider)
			_G.MiniMapMailFrame:SetParent(UIHider)
			_G.MinimapBackdrop:SetParent(UIHider) -- MinimapCompassTexture
			_G.MinimapNorthTag:SetParent(UIHider)
			_G.MiniMapTracking:SetParent(UIHider)
			_G.MiniMapTrackingButton:SetParent(UIHider)

		  _G.MiniMapVoiceChatFrame:SetParent(UIHider)

			_G.MiniMapWorldMapButton:SetParent(UIHider)
			_G.MinimapZoomIn:SetParent(UIHider)
			_G.MinimapZoomOut:SetParent(UIHider)
			_G.MinimapZoneTextButton:SetParent(UIHider)
			
			-- Instance difficulty
			_G.MiniMapInstanceDifficulty:SetParent(UIHider)

			-- Elements that got removed in MoP
			local MiniMapLFGFrame = _G.MiniMapLFGFrame
			local MiniMapLFGFrameBorder = _G.MiniMapLFGFrameBorder
			local MiniMapBattlefieldFrame = _G.MiniMapBattlefieldFrame
			local MiniMapBattlefieldBorder = _G.MiniMapBattlefieldBorder
			local BattlegroundShine = _G.BattlegroundShine
			local MiniMapBattlefieldIcon = _G.MiniMapBattlefieldIcon

			-- WotLK and Cata Dungeon Finder Eye
			MiniMapLFGFrame:SetHighlightTexture("") -- the annoying blue hover circle around it
			MiniMapLFGFrame.eye.texture:SetParent(UIHider)
			MiniMapLFGFrame.eye.texture:SetAlpha(0)
			MiniMapLFGFrameBorder:SetTexture(nil)

			-- WotLK and Cata PvP battleground and Wintergrasp queue
			MiniMapBattlefieldBorder:SetTexture(nil) -- the butt fugly standard border
			BattlegroundShine:SetTexture(nil) -- annoying background "shine"
			MiniMapBattlefieldIcon:SetParent(UIHider)
			MiniMapBattlefieldIcon:SetAlpha(0)

			if TimeManagerClockButton then
				TimeManagerClockButton:SetParent(UIHider)
				TimeManagerClockButton:UnregisterAllEvents()
			else
				self:RegisterEvent("ADDON_LOADED", "DisableClock")
			end
		end,
		DisableClock = function(self, event, ...)
			local arg1 = ... 
			if arg1 == "Blizzard_TimeManager" then
				local TimeManagerClockButton = _G.TimeManagerClockButton
				TimeManagerClockButton:SetParent(UIHider)
				TimeManagerClockButton:UnregisterAllEvents()
				self:UnregisterEvent("ADDON_LOADED", "DisableClock")
			end
		end
	}, 
	MirrorTimer = {
		OnDisable = function(self)
			for i = 1, MIRRORTIMER_NUMTIMERS or 1 do
				local timer = _G["MirrorTimer"..i]
				timer:SetScript("OnEvent", nil)
				timer:SetScript("OnUpdate", nil)
				timer:SetParent(UIHider)
				timer:UnregisterAllEvents()
			end
		end
	},
	ObjectiveTracker = {
		OnDisable = function(self)
			local WatchFrame = _G.WatchFrame
			WatchFrame:UnregisterAllEvents()
			WatchFrame:SetScript("OnEvent", nil) 
			WatchFrame:SetScript("OnUpdate", nil) 
			WatchFrame:SetParent(UIHider)
			WatchFrame:Hide()
		end,
		-- Not strictly certain what I'm doing here
		DisableTracker = function(self, event, ...)
			local arg1 = ... 
			if (arg1 == "Blizzard_ObjectiveTracker") then
				local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
				ObjectiveTrackerFrame:UnregisterAllEvents()
				ObjectiveTrackerFrame:SetScript("OnLoad", nil)
				ObjectiveTrackerFrame:SetScript("OnEvent", nil)
				ObjectiveTrackerFrame:SetScript("OnUpdate", nil)
				ObjectiveTrackerFrame:SetScript("OnSizeChanged", nil)
				ObjectiveTrackerFrame:SetParent(UIHider)

				local ObjectiveTrackerBlocksFrame = _G.ObjectiveTrackerBlocksFrame
				ObjectiveTrackerBlocksFrame:UnregisterAllEvents()
				ObjectiveTrackerBlocksFrame:SetScript("OnLoad", nil)
				ObjectiveTrackerBlocksFrame:SetScript("OnEvent", nil)
				ObjectiveTrackerBlocksFrame:SetScript("OnUpdate", nil)
				ObjectiveTrackerBlocksFrame:SetScript("OnSizeChanged", nil)
				ObjectiveTrackerBlocksFrame:SetParent(UIHider)

				-- Will this kill the keystoned mythic spam errors?
				local ScenarioBlocksFrame = _G.ScenarioBlocksFrame
				ScenarioBlocksFrame:UnregisterAllEvents()
				ScenarioBlocksFrame:SetScript("OnLoad", nil)
				ScenarioBlocksFrame:SetScript("OnEvent", nil)
				ScenarioBlocksFrame:SetScript("OnUpdate", nil)
				ScenarioBlocksFrame:SetScript("OnSizeChanged", nil)
				ScenarioBlocksFrame:SetParent(UIHider)
				
				if self:IsEventRegistered("ADDON_LOADED") then
					self:UnregisterEvent("ADDON_LOADED", "DisableTracker")
				end
			end
		end	
	},
	OrderHall = {
		OnDisable = function(self)
		end
	},
	TimerTracker = {
		OnDisable = function(self)
			-- Added in cata, but since we check for the existence anyway, 
			-- it's faster to skip the client check for this one.
			local TimerTracker = _G.TimerTracker
			if TimerTracker then
				TimerTracker:SetScript("OnEvent", nil)
				TimerTracker:SetScript("OnUpdate", nil)
				TimerTracker:UnregisterAllEvents()
				if TimerTracker.timerList then
					for _, bar in pairs(TimerTracker.timerList) do
						bar:SetScript("OnEvent", nil)
						bar:SetScript("OnUpdate", nil)
						bar:SetParent(UIHider)
						bar:UnregisterAllEvents()
					end
				end
			end
		end
	},
	Tutorials = {
		OnDisable = function(self)
			if _G.TutorialFrame then
				self:DisableAll()
			end
		end,
		DisableAll = function(self)
			local TutorialFrame = _G.TutorialFrame
			TutorialFrame:UnregisterAllEvents()
			TutorialFrame:Hide()
			TutorialFrame.Show = TutorialFrame.Hide
		end
	},
	UnitFrames = {
		OnDisable = function(self)
			local UIHider = UIHider
			local disableUnitFrame = disableUnitFrame
			local killUnitFrame = killUnitFrame

			local _G = _G
			local InterfaceOptionsUnitFramePanelPartyBackground = _G.InterfaceOptionsUnitFramePanelPartyBackground
			local MEMBERS_PER_RAID_GROUP = _G.MEMBERS_PER_RAID_GROUP
			local PartyMemberBackground = _G.PartyMemberBackground

			disableUnitFrame("player")
			disableUnitFrame("pet")
			disableUnitFrame("pettarget")
			disableUnitFrame("target")
			disableUnitFrame("targettarget")
			disableUnitFrame("focus")
			disableUnitFrame("focustarget")

			disableUnitFrame("party")
			disableUnitFrame("boss")
			disableUnitFrame("arena")

			-- I can not remembe when the following two got removed, 
			-- so instead of the more correct build checks, 
			-- we decided to go with simple existence checks here. 
			if InterfaceOptionsUnitFramePanelPartyBackground then
				InterfaceOptionsUnitFramePanelPartyBackground:Hide()
				InterfaceOptionsUnitFramePanelPartyBackground:SetAlpha(0)
			end 
			if PartyMemberBackground then
				PartyMemberBackground:SetParent(UIHider)
				PartyMemberBackground:Hide()
				PartyMemberBackground:SetAlpha(0)
			end

			-- I can't remember when the compact version of party frames 
			-- got absorbed into the compact raid frame system, 
			-- nor can I remember exactly when it was added. 
			-- So instead of doing build checks and the required research, 
			-- I do the same simple existence checks here too. 
			-- Will just have to do for now.
			if _G.CompactPartyFrame then -- 4.0?
				--killUnitFrame(_G.CompactPartyFrame)
				--for i=1, _G.MEMBERS_PER_RAID_GROUP do
				--	killUnitFrame(_G["CompactPartyFrameMember" .. i])
				--end	
			elseif _G.CompactPartyFrame_Generate then -- 4.1?
				--hooksecurefunc("CompactPartyFrame_Generate", function() 
				--	killUnitFrame(_G.CompactPartyFrame)
				--	for i=1, _G.MEMBERS_PER_RAID_GROUP do
				--		killUnitFrame(_G["CompactPartyFrameMember" .. i])
				--	end	
				--end)
			end

		end,
	},
	Warnings = {
		OnDisable = function(self)
			local _G = _G
			local UIHider = UIHider
			local UIErrorsFrame = _G.UIErrorsFrame
			local RaidWarningFrame = _G.RaidWarningFrame
			local RaidBossEmoteFrame = _G.RaidBossEmoteFrame

			UIErrorsFrame:SetParent(UIHider)
			UIErrorsFrame:UnregisterAllEvents()
			
			RaidWarningFrame:SetParent(UIHider)
			RaidWarningFrame:UnregisterAllEvents()
			
			RaidBossEmoteFrame:SetParent(UIHider)
			RaidBossEmoteFrame:UnregisterAllEvents()
		end
	},
	WorldMap = {
		Remove = function(self, element)

			if (element == "BlackoutWorld") then

				-- Don't black out the world with the full screen WorldMap, 
				-- we want to see what's going on in the background in case of danger!
				if _G.BlackoutWorld then
					_G.BlackoutWorld:SetAlpha(0)
				end

			elseif (element == "QuestTracking") then

				-- WoW API
				local CanAbandonQuest = _G.CanAbandonQuest
				local GetQuestLogIndexByID = _G.GetQuestLogIndexByID
				local GetQuestLogPushable = _G.GetQuestLogPushable
				local IsInGroup = _G.IsInGroup
				local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
				local UIDropDownMenu_CreateInfo = _G.UIDropDownMenu_CreateInfo
				local UIDropDownMenu_Initialize = _G.UIDropDownMenu_Initialize
				local QuestMapQuestOptions_AbandonQuest = _G.QuestMapQuestOptions_AbandonQuest

				-- WoW Frames & Objects
				local QuestMapQuestOptionsDropDown = _G.QuestMapQuestOptionsDropDown

				-- Remove the blizzard tracking options from the WorldMapFrame, 
				-- since we're replacing this tracking system with our own.
				if _G.QuestMapQuestOptions_TrackQuest then
					_G.QuestMapQuestOptions_TrackQuest = function() end
				end 

				-- Replace the WorldMap questlog dropdown with one without "Track Quest".
				if _G.QuestMapQuestOptionsDropDown_Initialize then 
					_G.QuestMapQuestOptionsDropDown_Initialize = function(self)
						local questLogIndex = GetQuestLogIndexByID(self.questID)
						local info = UIDropDownMenu_CreateInfo()
						info.isNotRadio = true
						info.notCheckable = true

						info.text = SHARE_QUEST
						info.func = function(_, questID) QuestMapQuestOptions_ShareQuest(questID) end
						info.arg1 = self.questID

						if ( not GetQuestLogPushable(questLogIndex) or not IsInGroup() ) then
							info.disabled = 1
						end

						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

						if CanAbandonQuest(self.questID) then
							info.text = ABANDON_QUEST
							info.func = function(_, questID) QuestMapQuestOptions_AbandonQuest(questID) end
							info.arg1 = self.questID
							info.disabled = nil
							UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
						end
					end
					QuestMapQuestOptionsDropDown.questID = 0
					UIDropDownMenu_Initialize(QuestMapQuestOptionsDropDown, QuestMapQuestOptionsDropDown_Initialize, "MENU")
				end	
			end
		end
	},
	WorldState = {
		OnDisable = function(self)
			WorldStateAlwaysUpFrame = _G.WorldStateAlwaysUpFrame
			WorldStateAlwaysUpFrame:SetParent(UIHider)
			-- WorldStateAlwaysUpFrame:Hide()
			WorldStateAlwaysUpFrame:SetScript("OnEvent", nil) 
			WorldStateAlwaysUpFrame:SetScript("OnUpdate", nil) 
			WorldStateAlwaysUpFrame:UnregisterAllEvents()
		end
	},
	ZoneText = {
		OnDisable = function(self)
			local _G = _G
			local UIHider = UIHider
			local ZoneTextFrame = _G.ZoneTextFrame
			local SubZoneTextFrame = _G.SubZoneTextFrame
			local AutoFollowStatus = _G.AutoFollowStatus

			ZoneTextFrame:SetParent(UIHider)
			ZoneTextFrame:UnregisterAllEvents()
			ZoneTextFrame:SetScript("OnUpdate", nil)
			-- ZoneTextFrame:Hide()
			
			SubZoneTextFrame:SetParent(UIHider)
			SubZoneTextFrame:UnregisterAllEvents()
			SubZoneTextFrame:SetScript("OnUpdate", nil)
			-- SubZoneTextFrame:Hide()
			
			AutoFollowStatus:SetParent(UIHider)
			AutoFollowStatus:UnregisterAllEvents()
			AutoFollowStatus:SetScript("OnUpdate", nil)
			-- AutoFollowStatus:Hide()
		end
	}
	
}


Handler.OnEnable = function(self)
	-- This handler is "reversed", meaning that all elements
	-- are considered "enabled" upon creation, even when no enable function has been called!
	-- We're doing it this way, since it seems more correct to think of the original 
	-- blizzard UI elements as "enabled" until forcefully disabled by this handler!
	self:SetElementDefaultEnabledState(true)

	-- register elements 
	for name, element in pairs(elements) do
		self:SetElement(name, element)
	end
end
