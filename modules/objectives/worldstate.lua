local _, Engine = ...
local Module = Engine:NewModule("WorldState")
--do return end

-- Lua API
local _G = _G
local math_floor = math.floor
local pairs = pairs
local table_insert = table.insert
local table_remove = table.remove
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local GetNumWorldStateUI = _G.GetNumWorldStateUI
local GetTime = _G.GetTime
local GetWorldStateUIInfo = _G.GetWorldStateUIInfo
local UnitAffectingCombat = _G.UnitAffectingCombat

-- Height of the UIs
local uiHeight = 24

-- Module registries
local activeTimers = {}
local activeUIs = {}
local timerInfo = {}
local uiInfo = {}

-- Table used to identify objects
local icons = { -- todo: add the objectives icon used in Ashran!
	[ [[Interface\TargetingFrame\UI-PVP-Horde]] ] = "horde",
	[ [[Interface\WorldStateScore\HordeIcon]] ] = "horde",
	[ [[Interface\WorldStateFrame\HordeTower]] ] = "hordetower",
	[ [[Interface\WorldStateFrame\HordeFlag]] ] = "hordeflag",
	[ [[Interface\WorldStateScore\ColumnIcon-FlagCapture1]] ] = "hordeflag",
	[ [[Interface\WorldStateScore\ColumnIcon-FlagReturn0]] ] = "hordeflag",
	[ [[Interface\TargetingFrame\UI-PVP-Alliance]] ] = "alliance", 
	[ [[Interface\WorldStateScore\AllianceIcon]] ] = "alliance",
	[ [[Interface\WorldStateFrame\AllianceTower]] ] = "alliancetower",
	[ [[Interface\WorldStateFrame\AllianceFlag]] ] = "allianceflag",
	[ [[Interface\WorldStateScore\ColumnIcon-FlagCapture0]] ] = "allianceflag",
	[ [[Interface\WorldStateScore\ColumnIcon-FlagReturn1]] ] = "allianceflag",
	[ [[Interface\WorldStateFrame\NeutralTower]] ] = "neutraltower"
}

local iconData = {}

local getIconData = function(pathName)
	local pathName = icons[pathName]

	local tex = iconData[pathName].path
	local w, h = unpack(iconData[pathName].size)
	local y = (h-(uiHeight or h))/2
	return tex, w, h, y, iconData[pathName].coords
end

local DAY, HOUR, MINUTE = 86400, 3600, 60
local formatTime = function(value)
	if (value < 0) then 
		value = 0
	end
	return ("%02d:%02d"):format(floor(value / MINUTE), value%MINUTE)
end

------------------------------------------------------------------------
-- UI Template
------------------------------------------------------------------------
local WorldStateUI = Engine:CreateFrame("Frame", nil, WorldFrame)
local WorldStateUI_MT = { __index = WorldStateUI }

-- Using the template frame to handle all timers, as its always visible
WorldStateUI.elapsed = 0
WorldStateUI:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if (self.elapsed > .1) then
		local reposition
		for timerIndex = #timerInfo, 1, -1 do
			-- Update time left
			local timer = timerInfo[timerIndex]
			timer.timeLeft = timer.timeEnding - GetTime()

			-- cancel timers that have ran out
			if (timer.timeLeft < 0) then
				table_remove(timerInfo, timerIndex) -- pull the timer out of the info table
				timer.timeLeft = 0
				activeTimers[timer.msg].enabled = false
				if timer.ui then
					timer.ui:Clear()
				end
				reposition = true
			end
			
			-- update the text of active timers
			if activeTimers[timer.msg].enabled then
				if timer.ui then
					timer.ui.text:SetText(formatTime(math_floor(timer.timeLeft)))
					--timer.ui.text:SetText(timer.msg .. formatTime(math_floor(timer.timeLeft)))
				end
			end

		end
		if reposition then
			Module:UpdateUIPositions()
		end
		self.elapsed = 0
	end
end)

WorldStateUI.OnEnter = function(self)
	if self.tooltip then
		if (not GameTooltip:IsForbidden()) then
			GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMRIGHT", 6, -6)
			GameTooltip:AddLine(self.tooltip, 0, 1, 0)
			GameTooltip:Show()
		end
	end
end

WorldStateUI.OnLeave = function(self)
	if (not GameTooltip:IsForbidden()) then	
		GameTooltip:Hide()
	end
end

WorldStateUI.EnableMouseScripts = function(self)
	self:EnableMouse(true)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
end

WorldStateUI.DisableMouseScripts = function(self)
	self:EnableMouse(false)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

WorldStateUI.SetType = function(self, uiType)
	self.uiType = uiType
end

WorldStateUI.GetType = function(self)
	return self.uiType
end

WorldStateUI.SetIcon = function(self, iconType, pathName, reset)
	if (reset or (pathName == "") or (not pathName)) then
		self[iconType]:SetSize(32, 32)
		self[iconType]:SetTexture(pathName or "")
		self[iconType]:SetTexCoord(0, 1, 0, 1)
	else
		local tex, w, h, y, coords = getIconData(pathName)
		self[iconType]:SetSize(w, h)
		self[iconType]:SetTexture(tex)
		self[iconType]:SetTexCoord(unpack(coords))
	end
end

WorldStateUI.Clear = function(self)
	self:Hide()
	self:SetSize(32, uiHeight or 32)
	self:SetHitRectInsets(0, 0, 0, 0)
	self:SetIcon("icon", "")
	self:SetIcon("dynamicIcon", "")

	self.dynamicIcon:Hide()
	self.uiType = nil
	self.infoTable = nil
	self.tooltip = nil
	self.enabled = nil

	self.icon:Place("TOPLEFT", 0, 0)
	self.text:Place("LEFT", 32, 0)
end


Module.GetUI = function(self, uiIndex)

	if (uiIndex > self:GetNumUIs()) then
		local new = setmetatable(self.frame:CreateFrame("Frame"), WorldStateUI_MT) 
		new:EnableMouseScripts()

		new.icon = new:CreateTexture() 
		new.icon:SetSize(32, 32)
		new.icon:SetPoint("TOPLEFT")

		new.text = new:CreateFontString() 
		new.text:SetPoint("LEFT", 32, 0)
		new.text:SetFontObject(GameFontNormalSmall) 
		new.text:SetTextColor(.8, .8, .8) 
		new.text:SetShadowColor(0, 0, 0, 1) 
		new.text:SetShadowOffset(.75, -.75)

		new.holder = self.frame:CreateFrame("Frame")
		new.holder:SetAllPoints()

		new.dynamicIcon = new.holder:CreateTexture()
		new.dynamicIcon:SetSize(32, 32)
		new.dynamicIcon:SetPoint("TOPLEFT", new.text, "TOPRIGHT", 10, 0)

		if (not self.uis) then
			self.uis = {}
		end
		table_insert(self.uis, new)

		self.numTotalUIs = #self.uis

		return new
	else
		return self.uis[uiIndex]
	end
end

Module.GetNumUIs = function(self)
	return self.numTotalUIs or 0
end

Module.GetNumActiveUIs = function(self)
	return self.numActiveUIs or -1
end

Module.UpdateUIPositions = function(self)
	if (not self.numTotalUIs) then 
		return 
	end

	local height = 0
	
	-- hide all redundant uis, if any
	for i = 1, self:GetNumUIs() do
		local ui = self:GetUI(i)
		if not ui.enabled then
			ui:Clear()
		end
	end
	
	-- sort and display the info UIs
	local currentPosition = 0
	for i = 1, self.numInfoUIs do 
		if uiInfo[i] then
			currentPosition = currentPosition + 1
			local ui = uiInfo[i].ui
			if i == 1 then
				ui:Place("TOPLEFT")
			else
				ui:Place("TOPLEFT", uiInfo[i-1].ui, "BOTTOMLEFT", 0, -4)
			end
			height = height + (ui.height or 32)
			ui:Show()
		end
	end
	
	-- sort and display the timer UIs
	for i = 1, self.numTimerUIs do 
		if timerInfo[i] then
			currentPosition = currentPosition + 1
			local ui = timerInfo[i].ui
			if (currentPosition == 1) then -- this is the first ui
				ui:Place("TOPLEFT") 
			elseif i == 1 then -- this is the first timer ui, but there are info uis prior to it
				ui:Place("TOPLEFT", uiInfo[self.numInfoUIs].ui, "BOTTOMLEFT", 0, -4) 
			else -- not the first timer ui
				ui:Place("TOPLEFT", timerInfo[i-1].ui, "BOTTOMLEFT", 0, -4)
			end
			height = height + (ui.height or 32)
			ui:Show()
		end
	end
	
	-- update master visibility
	if (currentPosition == 0) then
		if (self.frame:IsShown()) then
			self.frame:Hide()
		end
		self.height = 10
	else
		if (not self.frame:IsShown()) then
			self.frame:Show()
		end
		self.height = height + 10
	end
	
end

Module.UpdateStates = function(self)
	local numBlizzardUI = GetNumWorldStateUI() or 0
	local uiIndex, infoIndex, timerIndex = 0, 0, 0
	local height = 0
	
	-- halt all timers until new data has been processed
	for msg, info in pairs(activeTimers) do
		info.ui = nil
		info.enabled = false
	end
	
	-- disable all uis until new data has been processed
	for i = 1, self:GetNumUIs() do
		self:GetUI(i).enabled = false
	end
	
	wipe(timerInfo)
	wipe(uiInfo)
	
	for blizzardID = 1, numBlizzardUI do
		-- retrieve info about this specific blizzardUI
		local uiType, state, hidden, text, icon, dynamicIcon, tooltip, dynamicTooltip, extendedUI, extendedUIState1, extendedUIState2, extendedUIState3 = GetWorldStateUIInfo(blizzardID)
		if state > 0 and extendedUI == "" and text ~= nil and not hidden then
			uiIndex = uiIndex + 1 -- increase the ui counter

			local ui = self:GetUI(uiIndex) -- get or create a custom ui
			ui.blizzardID = blizzardID -- store blizzards id here
			ui.height = uiHeight or 32
			
			-- figure out what kind of UI this is
			local mins, secs = text:match("(%d+):(%d+)") -- we assume only 1 time value will be listed in any single ui
			if mins and secs then
				ui.uiType = "timer"
				timerIndex = timerIndex + 1 -- increase the timer ui counter

				ui:SetSize(32, uiHeight or 32)
				ui:SetHitRectInsets(0, 0, 0, 0)
				height = height + (uiHeight or 32)
				-- ui:SetIcon("icon", icon, true)
				ui:SetIcon("icon", "", true) -- only show icons we have customs for
				ui.icon:Place("TOPLEFT", 0, 0)
				ui.text:Place("LEFT", 0, 0) -- center the timer?
				--ui.text:Place("LEFT", 32, 0)
				ui.tooltip = tooltip

				-- calculate actual seconds remaining and grab blizzards msg here
				local seconds = math_floor((mins and tonumber(mins)*60 or 0) + tonumber(secs))
				local msg = text:gsub("(%d+):(%d+)", "") 

				-- feed the timer into our timer table
				if not timerInfo[timerIndex] then
					timerInfo[timerIndex] = {}
				end
				timerInfo[timerIndex].ui = ui
				timerInfo[timerIndex].msg = msg -- just ignore the timer message? Keep it neat?
				timerInfo[timerIndex].timeLeft = seconds
				timerInfo[timerIndex].timeEnding = GetTime() + seconds
				
				-- feed the timer into our active timers listing
				if not activeTimers[msg] then
					activeTimers[msg] = {}
				end
				activeTimers[msg].ui = ui
				activeTimers[msg].enabled = true 
				
				-- give the ui references to its tables
				ui.infoTable = timerInfo[timerIndex]
			else
				ui.uiType = "info"
				infoIndex = infoIndex + 1 -- increase the info ui counter
				
				-- feed the timer into our info table
				if not uiInfo[infoIndex] then
					uiInfo[infoIndex] = {}
				end
				uiInfo[infoIndex].ui = ui
				uiInfo[infoIndex].msg = text
				
				ui.text:SetText(text)
				
				if (icon and icons[icon]) then
					local tex, w, h, y, coords = getIconData(icon)
					ui:SetSize(w, uiHeight or h)
					height = height + uiHeight
					if coords then
						ui:SetHitRectInsets(unpack(coords))
					else 
						ui:SetHitRectInsets(0, 0, 0, 0)
					end
					ui:SetIcon("icon", icon)
					ui.icon:Place("TOPLEFT", 0, 0)
					ui.text:Place("LEFT", 32, 0)
					ui.tooltip = tooltip
				else
					ui:SetSize(32, uiHeight or 32)
					ui:SetHitRectInsets(0, 0, 0, 0)
					height = height + (uiHeight or 32)
					-- ui:SetIcon("icon", icon, true)
					ui:SetIcon("icon", "", true) -- only show icons we have customs for
					ui.icon:Place("TOPLEFT", 0, 0)
					ui.text:Place("LEFT", 32, 0)
					ui.tooltip = nil
				end
				if dynamicIcon then
					if icons[dynamicIcon] then
						ui:SetIcon("dynamicIcon", dynamicIcon)
						ui.dynamicIcon:ClearAllPoints()
						ui.dynamicIcon:SetPoint("TOP", ui.icon, "TOP", 0, 0)
						ui.dynamicIcon:SetPoint("LEFT", ui.text, "RIGHT", 0, 0)
					else
						ui:SetIcon("dynamicIcon", dynamicIcon, true)
						ui.dynamicIcon:Place("TOPLEFT", ui.text, "TOPRIGHT", 0, 0)
					end
					if (state == 2) then -- start flashing ui.holder
						--ui.holder:StartFlash(.5, .5, .5, 1, true)
						ui.dynamicIcon:Show()
					elseif (state == 3) then -- stop flashing ui.holder
						--ui.holder:StopFlash()
						ui.dynamicIcon:Show()
					else -- stop flashing ui.holder
						--ui.holder:StopFlash()
						ui.dynamicIcon:Hide()
					end
				else -- stop flashing ui.holder
					ui:SetIcon("dynamicIcon", "")
					--ui.holder:StopFlash()
					ui.dynamicIcon:Hide()
				end	
				
				-- give the ui references to its tables
				ui.infoTable = uiInfo[infoIndex]
				
			end	
			ui.enabled = true
		end	
	end

	self.height = height
	self.numActiveUIs = uiIndex
	self.numInfoUIs = infoIndex
	self.numTimerUIs = timerIndex

	self:UpdateUIPositions()
end

Module.Clear = function(self)
	self.frame:Hide()
	for i = 1, self:GetNumUIs() do
		self:GetUI(i):Clear()
	end
end

Module.OnEvent = function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		self:Clear() 
	end
	self:UpdateStates()
end

Module.OnInit = function(self)
	self.config = self:GetDB("Objectives").zoneinfo.worldstate

	-- populate icon data tables
	for pathName, texCoords in pairs(self.config.texCoords) do
		iconData[pathName] = {
			path = self.config.texPath,
			size = self.config.texSize,
			rects = self.config.texHitRects,
			coords = texCoords
		}
	end
end

Module.OnEnable = function(self)
	self:GetHandler("BlizzardUI"):GetElement("WorldState"):Disable()

	local parent = Engine:CreateFrame("Frame", nil, "UICenter", "SecureHandlerAttributeTemplate")
	parent:SetSize(2,2)
	parent:SetPoint("TOP")

	RegisterStateDriver(parent, "visibility", "[@target,exists]hide;show")

	self.frame = parent:CreateFrame("Frame")
	self.frame:Hide()
	self.frame:Place("TOP", "UICenter", "TOP", 0, -30)
	self.frame:SetSize(32, 32)

	self:RegisterEvent("UPDATE_WORLD_STATES", "OnEvent")
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "OnEvent")
	self:RegisterEvent("BATTLEGROUND_POINTS_UPDATE", "OnEvent")
	self:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND", "OnEvent")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnEvent")
	self:UpdateStates() 
end
