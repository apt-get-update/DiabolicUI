local _, Engine = ...
local Module = Engine:NewModule("CaptureBars")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local table_insert = table.insert
local tostring = tostring
local unpack = unpack

-- WoW API
local GetNumWorldStateUI = _G.GetNumWorldStateUI
local GetWorldStateUIInfo = _G.GetWorldStateUIInfo

local CaptureBar = Engine:CreateFrame("Frame")
local CaptureBar_MT = { __index = CaptureBar }

Module.NewCaptureBar = function(self, barID)
	local config = self.config

	local captureBar = setmetatable(Engine:CreateFrame("Frame", nil, "UICenter"), CaptureBar_MT)
	captureBar:SetSize(unpack(config.size))
	captureBar:SetFrameStrata("MEDIUM")
	captureBar:Hide()

	captureBar.id = barID
	captureBar.width = config.size[1]
	captureBar.neutralZone = 0.0001
	captureBar.min = 0
	captureBar.max = 1
	captureBar.value = 1/2

	local backdrop = captureBar:CreateTexture()
	backdrop:SetDrawLayer("BACKGROUND")
	backdrop:SetPoint(unpack(config.texture_position))
	backdrop:SetSize(unpack(config.backdrop_size))
	backdrop:SetTexture(config.backdrop_texture)

	local barMiddle = captureBar:CreateTexture()
	barMiddle:SetDrawLayer("BORDER")
	barMiddle:SetTexture(config.statusbar_texture)
	barMiddle:SetVertexColor(unpack(C.Faction.Neutral))
	barMiddle:SetPoint("TOP")
	barMiddle:SetPoint("BOTTOM")
	barMiddle:SetWidth(captureBar.neutralZone)

	local barLeft = captureBar:CreateTexture()
	barLeft:SetDrawLayer("BORDER")
	barLeft:SetTexture(config.statusbar_texture)
	barLeft:SetVertexColor(unpack(C.Faction.Alliance))
	barLeft:SetPoint("TOP")
	barLeft:SetPoint("LEFT")
	barLeft:SetPoint("RIGHT", barMiddle, "LEFT")
	barLeft:SetPoint("BOTTOM")

	local barRight = captureBar:CreateTexture()
	barRight:SetDrawLayer("BORDER")
	barRight:SetTexture(config.statusbar_texture)
	barRight:SetVertexColor(unpack(C.Faction.Horde))
	barRight:SetPoint("TOP")
	barRight:SetPoint("RIGHT")
	barRight:SetPoint("LEFT", barMiddle, "RIGHT")
	barRight:SetPoint("BOTTOM")

	local spark = captureBar:CreateTexture()
	spark:SetDrawLayer("ARTWORK")
	spark:SetPoint("CENTER", 0, 0)
	spark:SetSize(unpack(config.spark_size))
	spark:SetTexture(config.spark_texture)

	local border = captureBar:CreateTexture()
	border:SetDrawLayer("OVERLAY")
	border:SetPoint(unpack(config.texture_position))
	border:SetSize(unpack(config.texture_size))
	border:SetTexture(config.texture)

	local leftIndicator = captureBar:CreateTexture()
	leftIndicator:SetDrawLayer("ARTWORK")
	leftIndicator:SetPoint("CENTER", spark, -4, .5)
	leftIndicator:SetSize(6, 13)
	leftIndicator:SetTexture([[Interface\WorldStateFrame\WorldState-CaptureBar]])
	leftIndicator:SetTexCoord(186/256, 193/256, 9/64, 23/64)
	leftIndicator:SetAlpha(.75)
	leftIndicator:Hide()

	local rightIndicator = captureBar:CreateTexture()
	rightIndicator:SetDrawLayer("ARTWORK")
	rightIndicator:SetPoint("CENTER", spark, 4, .5)
	rightIndicator:SetSize(6, 13)
	rightIndicator:SetTexture([[Interface\WorldStateFrame\WorldState-CaptureBar]])
	rightIndicator:SetTexCoord(193/256, 186/256, 9/64, 23/64)
	rightIndicator:SetAlpha(.75)
	rightIndicator:Hide()

	captureBar.left = barLeft
	captureBar.middle = barMiddle
	captureBar.right = barRight
	captureBar.spark = spark
	captureBar.leftIndicator = leftIndicator
	captureBar.rightIndicator = rightIndicator

	self.captureBars[#self.captureBars + 1] = captureBar
	self.captureBarsByID[barID] = captureBar

	return captureBar
end

Module.UpdateCaptureBar = function(self, barID, value, neutralZone, min, max)
	local captureBar = self.captureBarsByID[barID] or self:NewCaptureBar(barID)

	-- Get existing values, if any
	local oldNeutralZone = captureBar.neutralZone
	local oldValue = captureBar.value
	local oldMin = captureBar.min
	local oldMax = captureBar.max

	-- it needs a minimum size, or it'll disappear and bug out the bar
	local adjustedNeutralZone = math_min(math_max(neutralZone, 0.0001), 100) 
	if (oldNeutralZone ~= adjustedNeutralZone) then 
		-- Resize and adjust the size and textures
		local x = adjustedNeutralZone/100
		captureBar.middle:SetWidth(captureBar.width * x)
		captureBar.left:SetTexCoord(0, x, 0, 1)
		captureBar.middle:SetTexCoord(x, 1-x, 0, 1)
		captureBar.right:SetTexCoord(1-x, 1, 0, 1)

		-- Store the new value
		captureBar.neutralZone = adjustedNeutralZone
	end

	-- Adjust spark and indicators
	if (value ~= oldValue) or (min ~= oldMin) or (max ~= oldMax) then

		local fraction = (value - min)/(max - min)
		local x = captureBar.width * (fraction - 1/2)

		-- Reposition the spark
		captureBar.spark:ClearAllPoints()
		captureBar.spark:SetPoint("CENTER", x, 0 )

		-- hide directional indicators close to the edges
		if (fraction < .005) or (fraction > .995) or (value == oldValue) then 
			captureBar.leftIndicator:Hide()
			captureBar.rightIndicator:Hide()

		-- moving left
		elseif (value < oldValue) then 
			captureBar.leftIndicator:Show()
			captureBar.rightIndicator:Hide()
		
		-- moving right
		elseif (value > oldValue) then 
			captureBar.leftIndicator:Hide()
			captureBar.rightIndicator:Show()
		end	

		-- Update stored values
		captureBar.value = value
		captureBar.min = min
		captureBar.max = max
	end	

	if (not captureBar:IsShown()) then
		captureBar:Show()
	end
end

Module.UpdateWorldStates = function(self)
	local config = self.config
	local captureBars = self.captureBars
	local visibleCaptureBars = self.visibleCaptureBars
	local numVisibleBars = 0

	-- temporarily set all bar visibility statuses to hidden
	for id in pairs(visibleCaptureBars) do
		visibleCaptureBars[id] = false
	end

	-- Iterate blizzard extended UIs to find any active capturebars 	
	for i = 1, (GetNumWorldStateUI() or 0) do
		-- extendedUIState1 = value ( from 100 - 0, where 100 is all ally side (left))
		-- extendedUIState2 = size of neutral zone in percent
		-- extendedUIState3 = id of the capture bar
		local uiType, state, hidden, text, icon, dynamicIcon, tooltip, dynamicTooltip, extendedUI, extendedUIState1, extendedUIState2, extendedUIState3
		uiType, state, text, icon, dynamicIcon, tooltip, dynamicTooltip, extendedUI, extendedUIState1, extendedUIState2, extendedUIState3 = GetWorldStateUIInfo(i)


		if ((state > 0) and (extendedUI == "CAPTUREPOINT") and (not hidden)) then
			-- Let's create a unique text based identifier for the bar, for faster lookups
			local barID = (type(extendedUIState3) == "number") and "BlizzardCaptureBar"..extendedUIState3 or extendedUIState3

			-- Count the bars
			numVisibleBars = numVisibleBars + 1

			-- Set the bar's status to visible
			visibleCaptureBars[barID] = true 
			
			-- Update or create the capture bar
			self:UpdateCaptureBar(barID, 100 - extendedUIState1, extendedUIState2, 0, 100) 
		end
	end

	-- Use the messagesystem to tell other modules about the visibility
	if (numVisibleBars > 0) then
		self:SendMessage("ENGINE_CAPTUREBAR_VISIBLE", numVisibleBars)
	else
		self:SendMessage("ENGINE_CAPTUREBAR_HIDDEN")
	end

	-- Position capture bars
	-- we only have a single bar currently in WoW, but our system supports multiple, 
	-- and thus we need to realign them on worldstate updates.
	local previousBar
	for i,captureBar in ipairs(captureBars) do
		if visibleCaptureBars[captureBar.id] then
			captureBar:ClearAllPoints()
			if previousBar then 
				captureBar:SetPoint("CENTER", previousBar, "CENTER", 0, -config.padding)
			else
				captureBar:Place(unpack(config.position))
			end
			previousBar = captureBar
		end
	end

	-- hide unused bars
	for i,captureBar in ipairs(captureBars) do
		if (not visibleCaptureBars[captureBar.id]) then
			captureBar:Hide()
		end
	end
end

Module.Clear = function(self)
	for i,captureBar in ipairs(self.captureBars) do
		captureBar:Hide()
	end
end

Module.OnEvent = function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		self:Clear() 
	end
	self:UpdateWorldStates()
end

Module.OnInit = function(self)
	self.config = self:GetDB("Objectives").capturebar
	self.captureBars = {}
	self.captureBarsByID = {}
	self.visibleCaptureBars = {}
end

Module.OnEnable = function(self)
	Engine:GetHandler("BlizzardUI"):GetElement("CaptureBars"):Disable()

	self:RegisterEvent("UPDATE_WORLD_STATES", "OnEvent")
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "OnEvent")
	self:RegisterEvent("BATTLEGROUND_POINTS_UPDATE", "OnEvent")
	self:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND", "OnEvent")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "OnEvent")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnEvent")
end
