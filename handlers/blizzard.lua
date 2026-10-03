-- "BlizzardUI" handler: hides and disables pieces of Blizzard's default UI
-- that DiabolicUI replaces. Every piece is a handler element (ActionBars,
-- UnitFrames, Minimap, CastBars, ZoneText, ...) that starts out enabled;
-- modules call :GetElement(name):Disable() for what they take over, and
-- Menu_Panel / Menu_Option remove Interface Options entries that no longer
-- apply.
local _, Engine = ... 
local Handler = Engine:NewHandler("BlizzardUI")

-- Lua API
local _G = _G
local pairs = pairs
local type = type

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
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

local getFrame = function(baseName)
	if type(baseName) == "string" then
		return _G[baseName]
	else
		return baseName
	end
end

-- kill off an existing frame in a secure, taint free way
-- @usage kill(object)
-- @param object <table> frame, fontstring or texture to hide
local kill = function(object)
	if not UIHider[object] then
		UIHider[object] = {
			parent = object:GetParent(),
			isshown = object:IsShown(),
			point = { object:GetPoint() }
		}
	end
	object:SetParent(UIHider)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
end


------------------------------------------------------------------------
--	Unit Frames
------------------------------------------------------------------------

-- (baseName: the frame, or its name; frames that don't exist are skipped)
local killUnitFrame = function(baseName)
	local frame = getFrame(baseName)
	if frame then
		kill(frame)
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
	end
end

-- @usage disableUnitFrame(unit)
-- @description disables a unitframe based on "unit"
-- @param unit <string> the unitID of the unit whose blizzard frame to disable (http://wowpedia.org/UnitId)
local disableUnitFrame = function(unit)
	if unit == "player" then
		local PlayerFrame = _G.PlayerFrame

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
		-- (killed rather than turned off through the showTargetOfTarget
		-- CVar or SHOW_TARGET_OF_TARGET: changing those taints)
		TargetofTarget_Update(TargetFrameToT)
		killUnitFrame(TargetFrameToT)
	elseif unit == "boss" then
		for i = 1, 4 do -- MAX_BOSS_FRAMES
			killUnitFrame("Boss" .. i .. "TargetFrame")
		end
	elseif unit == "party" then
		for i = 1, 4 do -- MAX_PARTY_MEMBERS
			killUnitFrame("PartyMemberFrame" .. i)
		end
	elseif unit == "arena" then
		-- (only there when another addon loaded Blizzard's arena UI)
		for i = 1, 5 do -- MAX_ARENA_ENEMIES
			killUnitFrame("ArenaEnemyFrame" .. i)
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
			local TutorialFrameAlertButton = _G.TutorialFrameAlertButton
			local UIPARENT_MANAGED_FRAME_POSITIONS = _G.UIPARENT_MANAGED_FRAME_POSITIONS

			MainMenuBar:EnableMouse(false)
			MainMenuBar:UnregisterAllEvents()
			MainMenuBar:SetAlpha(0)
			MainMenuBar:SetScale(0.00001)

			MainMenuBarArtFrame:UnregisterAllEvents()
			MainMenuBarArtFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE") -- make the character currency tab appear
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

			UIPARENT_MANAGED_FRAME_POSITIONS["MainMenuBar"] = nil
			UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
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
			local PartyMemberBackground = _G.PartyMemberBackground

			disableUnitFrame("player")
			disableUnitFrame("pet")
			disableUnitFrame("target")
			disableUnitFrame("targettarget")
			disableUnitFrame("focus")

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
	WorldState = {
		OnDisable = function(self)
			local WorldStateAlwaysUpFrame = _G.WorldStateAlwaysUpFrame
			WorldStateAlwaysUpFrame:SetParent(UIHider)
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
			
			SubZoneTextFrame:SetParent(UIHider)
			SubZoneTextFrame:UnregisterAllEvents()
			SubZoneTextFrame:SetScript("OnUpdate", nil)
			
			AutoFollowStatus:SetParent(UIHider)
			AutoFollowStatus:UnregisterAllEvents()
			AutoFollowStatus:SetScript("OnUpdate", nil)
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
