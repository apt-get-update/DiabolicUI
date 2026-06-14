local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: XP")
local StatusBar = Engine:GetHandler("StatusBar")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")

-- Lua API
local _G = _G
local math_floor = math.floor
local math_min = math.min
local select = select
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API

local BreakUpLargeNumbers = _G.BreakUpLargeNumbers
local CreateFrame = _G.CreateFrame
local GetRestState = _G.GetRestState
local GetTimeToWellRested = _G.GetTimeToWellRested
local GetXPExhaustion = _G.GetXPExhaustion
local HideUIPanel = _G.HideUIPanel
local IsResting = _G.IsResting
local IsXPUserDisabled = _G.IsXPUserDisabled
local MAX_PLAYER_LEVEL_TABLE = _G.MAX_PLAYER_LEVEL_TABLE
local SocketInventoryItem = _G.SocketInventoryItem
local UnitHasVehicleUI = _G.UnitHasVehicleUI
local UnitHasVehiclePlayerFrameUI = _G.UnitHasVehiclePlayerFrameUI
local UnitLevel = _G.UnitLevel
local UnitRace = _G.UnitRace
local UnitXP = _G.UnitXP
local UnitXPMax = _G.UnitXPMax

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Track XP/Rep bar visibility
local XPBARVISIBLE

-- Pandaren can get 300% rested bonus
local maxRested = select(2, UnitRace("player")) == "Pandaren" and 3 or 1.5

-- Various string formatting for our tooltips and bars
local shortXPString = "%s%%"
local longXPString = "%s / %s"
local fullXPString = "%s / %s - %s%%"
local restedString = " (%s%% %s)"
local shortLevelString = "%s %d"

-- Just to avoid some updates we don't need
local vehicleEvents = {
	UNIT_ENTERING_VEHICLE = "player",
	UNIT_EXITING_VEHICLE = "player",
	UNIT_ENTERED_VEHICLE = "player",
	UNIT_EXITED_VEHICLE = "player"
}

-- Bar Templates
----------------------------------------------------------

local Bar = Engine:CreateFrame("Frame")
local Bar_MT = { __index = Bar }

-- high priority, will override almost everything else (not that it's implemented yet...)
local Bar_Reputation = setmetatable({}, { __index = Bar })
local Bar_Reputation_MT = { __index = Bar_Reputation }

-- shown if no reputation is tracked, and user still can gain experience
local Bar_XP = setmetatable({}, { __index = Bar })
local Bar_XP_MT = { __index = Bar_XP }

-- Standard methods we'll let the module assume always exist
Bar.UpdateData = function(self) return self.data end
Bar.Update = function(self) end
Bar.OnEnter = function(self) end
Bar.OnLeave = function(self) end

-- Colors
--local C_XP = "XP"
--local C_XP_RESTED = "XPRested"
--local C_XP_BONUS = "XPRestedBonus"

local C_XP = "XPBright"
local C_XP_RESTED = "XPRestedBright"
local C_XP_BONUS = "XPBonusBright"

-- XP Bar Methods
--------------------------------------------------
Bar_XP.UpdateData = function(self)
	self.data.resting = IsResting()
	self.data.restState, self.data.restedName, self.data.mult = GetRestState()
	self.data.restedLeft, self.data.restedTimeLeft = GetXPExhaustion(), GetTimeToWellRested()
	self.data.xp, self.data.xpMax = UnitXP("player"), UnitXPMax("player")
	self.data.color = self.data.restedLeft and C_XP_RESTED or C_XP
	self.data.mult = (self.data.mult or 1) * 100
	if self.data.xpMax == 0 then
		self.data.xpMax = nil
	end
	return self.data
end

Bar_XP.Update = function(self)
	local data = self:UpdateData()
	if (not data.xpMax) then return end
	local r, g, b = unpack(C.General[data.color])
	self.XP:SetStatusBarColor(r, g, b)
	self.XP:SetMinMaxValues(0, data.xpMax)
	self.XP:SetValue(data.xp)
	self.Rested:SetMinMaxValues(0, data.xpMax)
	self.Rested:SetValue(math_min(data.xpMax, data.xp + (data.restedLeft or 0)))
	if (not self.Rested:IsShown()) then
		self.Rested:Show()
	end
	if data.restedLeft then
		local r, g, b = unpack(C.General.XPRestedBonus)
		self.Backdrop:SetVertexColor(r *.25, g *.25, b *.25)
	else
		self.Backdrop:SetVertexColor(r *.25, g *.25, b *.25)
	end
	if self.mouseIsOver then
		if data.restedLeft then
			self.Value:SetFormattedText(fullXPString..F.Colorize(restedString, "OffGreen"), F.Colorize(F.Short(data.xp), "Normal"), F.Colorize(F.Short(data.xpMax), "Normal"), F.Colorize(F.Short(math_floor(data.xp/data.xpMax*100)), "Normal"), F.Short(math_floor(data.restedLeft/data.xpMax*100)), L["Rested"])
		else
			self.Value:SetFormattedText(fullXPString, F.Colorize(F.Short(data.xp), "Normal"), F.Colorize(F.Short(data.xpMax), "Normal"), F.Colorize(F.Short(math_floor(data.xp/data.xpMax*100)), "Normal"))
		end
	else
		self.Value:SetFormattedText(shortXPString, F.Colorize(F.Short(math_floor(data.xp/data.xpMax*100)), "Normal"))
	end
end

Bar_XP.OnEnter = function(self)
	local data = self:UpdateData()
	if not data.xpMax then return end

	if GameTooltip:IsForbidden() then
		return
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	--GameTooltip:SetOwner(self.Controller, "ANCHOR_NONE")

	local r, g, b = unpack(C.General.Highlight)
	local r2, g2, b2 = unpack(C.General.OffWhite)

	GameTooltip:AddLine(shortLevelString:format(LEVEL, UnitLevel("player")))
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(F.Colorize("Experience", "Normal"))
	GameTooltip:AddDoubleLine(L["Current XP: "], longXPString:format(F.Colorize(F.Short(data.xp), "Normal"), F.Colorize(F.Short(data.xpMax), "Normal")), r2, g2, b2, r2, g2, b2)

	-- add rested bonus if it exists
	if data.restedLeft and data.restedLeft > 0 then
		GameTooltip:AddDoubleLine(L["Rested Bonus: "], longXPString:format(F.Colorize(F.Short(data.restedLeft), "Normal"), F.Colorize(F.Short(data.xpMax * maxRested), "Normal")), r2, g2, b2, r2, g2, b2)
	end

	if data.restState == 1 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["Rested"], unpack(C.General.Highlight))
		GameTooltip:AddLine(L["%s of normal experience\ngained from monsters."]:format(shortXPString:format(data.mult)), unpack(C.General.Green))
		if data.resting and data.restedTimeLeft and data.restedTimeLeft > 0 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L["Resting"], unpack(C.General.Highlight))
			if data.restedTimeLeft > hour*2 then
				GameTooltip:AddLine(L["You must rest for %s additional\nhours to become fully rested."]:format(F.Colorize(math_floor(data.restedTimeLeft/hour), "OffWhite")), unpack(C.General.Normal))
			else
				GameTooltip:AddLine(L["You must rest for %s additional\nminutes to become fully rested."]:format(F.Colorize(math_floor(data.restedTimeLeft/minute), "OffWhite")), unpack(C.General.Normal))
			end
		end
	elseif data.restState >= 2 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["Normal"], unpack(C.General.Highlight))
		GameTooltip:AddLine(L["%s of normal experience\ngained from monsters."]:format(shortXPString:format(data.mult)), unpack(C.General.Green))

		if not(data.restedTimeLeft and data.restedTimeLeft > 0) then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L["You should rest at an Inn."], unpack(C.General.DimRed))
		end
	end

	GameTooltip:Show()
end

Bar_XP.OnLeave = function(self)
	if (not GameTooltip:IsForbidden()) then
		GameTooltip:Hide()
	end
end

-- Reputation Bar Methods
--------------------------------------------------
Bar_Reputation.UpdateData = function(self)
  local repName, repStanding, repMin, repMax, repValue = GetWatchedFactionInfo()

  if repName then
    local curRep, maxRep = repValue - repMin, repMax - repMin
    if maxRep <= 0 then maxRep = 1 end
    local standingLabel = _G["FACTION_STANDING_LABEL"..repStanding] or ""

    self.data.curRep = curRep
    self.data.maxRep = maxRep
    self.data.repName = repName
    self.data.repStanding = repStanding
    self.data.standingLabel = standingLabel
  else
    self.data.curRep = nil
    self.data.maxRep = nil
    self.data.repName = nil
    self.data.repStanding = nil
    self.data.standingLabel = nil
  end
	return self.data
end

Bar_Reputation.Update = function(self)
	local data = self:UpdateData()
	if (not data.repName) then return end
  local r, g, b = unpack(C.Reaction[data.repStanding])

	self.XP:SetStatusBarColor(r, g, b)
	self.XP:SetMinMaxValues(0, data.maxRep)
	self.XP:SetValue(data.curRep)
  self.Backdrop:SetVertexColor(r *.25, g *.25, b *.25)
	if self.mouseIsOver then
    self.Value:SetFormattedText(fullXPString, F.Colorize(F.Short(data.curRep), "Normal"), F.Colorize(F.Short(data.maxRep), "Normal"), F.Colorize(F.Short(math_floor(data.curRep/data.maxRep*100)), "Normal"))
  else
		self.Value:SetFormattedText(shortXPString, F.Colorize(F.Short(math_floor(data.curRep/data.maxRep*100)), "Normal"))
  end
end

Bar_Reputation.OnEnter = function(self)
	local data = self:UpdateData()
	if (not data.repName) then return end

	if GameTooltip:IsForbidden() then
		return
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, self)

	local r, g, b = unpack(C.General.Highlight)
	local r2, g2, b2 = unpack(C.General.OffWhite)
  local r3, g3, b3 = unpack(C.Reaction[data.repStanding])

	GameTooltip:AddLine(data.repName)
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(F.Colorize(data.standingLabel, {r3, g3, b3} ))
	GameTooltip:AddDoubleLine(L["Reputation: "], longXPString:format(F.Colorize(F.Short(data.curRep), "Normal"), F.Colorize(F.Short(data.maxRep), "Normal")), r, g, b, r2, g2, b2)
	GameTooltip:Show()
end

Bar_Reputation.OnLeave = function(self)
	if (not GameTooltip:IsForbidden()) then
		GameTooltip:Hide()
	end
end

Bar_Reputation.OnClick = function(self)
  ToggleCharacter("ReputationFrame")
end

BarWidget.OnEnter = function(self)
	self.Bar.mouseIsOver = true
	self.Bar:OnEnter()
	self:UpdateBar()
end

BarWidget.OnLeave = function(self)
	self.Bar.mouseIsOver = false
	self.Bar:OnLeave()
	self:UpdateBar()
end

BarWidget.Update = function(self, event, unit)
	if event and vehicleEvents[event] and (vehicleEvents[event] ~= unit) then
		return
	end
	if self:UpdateVisibility() then
		self:UpdateBarType()
		self:UpdateBar()
	end
end

BarWidget.OnClick = function(self, ...)
	if (self.Bar.OnClick) then
		self.Bar:OnClick(...)
	end
end

BarWidget.UpdateVisibility = function(self)
	local isXPVisible = Module:IsXPVisible()
	if isXPVisible then
		if (not self.Controller:IsShown()) then
			self.Controller:Show()
		end
	else
		if self.Controller:IsShown() then
			self.Controller:Hide()
		end
	end
	if (XPBARVISIBLE ~= isXPVisible) then
		self:SendMessage("ENGINE_ACTIONBAR_XP_VISIBLE_CHANGED", isXPVisible)
		XPBARVISIBLE = isXPVisible
	end
	return isXPVisible
end

BarWidget.UpdateBarType = function(self)

	-- Get info about visible XP type
	local xp, reputation = Module:IsXPVisible()
	local barType = reputation and "reputation" or xp and "xp" or "none"

	-- Initiate a bar change if the XP type has changed
	if (self.barType ~= barType) then

		-- Store the old tooltip state in case it's visible
		local mouseIsOver = self.mouseIsOver

		-- Kill of old tooltip if visible on bar changes
		self:OnLeave()

		-- Choose the correct inheritance for our current bar
		if (barType == "xp") then
			setmetatable(self.Bar, Bar_XP_MT)
		elseif (barType == "reputation") then
			setmetatable(self.Bar, Bar_Reputation_MT)
		end

		-- Store the current bartype
		self.barType = barType

		-- Show the tooltip belonging to the current bartype
		if mouseIsOver then
			self:OnEnter()
		end
	end
end

BarWidget.UpdateBar = function(self)
	self.Bar:Update()
end

BarWidget.UpdateBarSettings = function(self)
	local structure_config = Module.config.structure.controllers.xp
	local art_config = Module.config.visuals.xp
	local num_bars = tostring(self.Controller:GetParent():GetAttribute("numbars"))

	self.Controller:SetSize(unpack(structure_config.size[num_bars]))
	self.Bar:SetSize(self.Controller:GetSize())
	self.Bar.XP:SetSize(self.Controller:GetSize())
	self.Bar.Rested:SetSize(self.Controller:GetSize())
	self.Bar.Backdrop:SetTexture(art_config.backdrop.textures[num_bars])
end

BarWidget.OnEnable = function(self)
	local structure_config = Module.config.structure.controllers.xp
	local art_config = Module.config.visuals.xp
	local num_bars = tostring(Module.db.num_bars)

	local Main = Module:GetWidget("Controller: Main"):GetFrame()

	local controller = Main:CreateFrame("Frame")
	controller:SetFrameStrata("BACKGROUND")
	controller:SetFrameLevel(0)
	controller:SetSize(unpack(Module.config.structure.controllers.xp.size[num_bars]))
	controller:SetPoint(unpack(Module.config.structure.controllers.xp.position))
	controller:EnableMouse(true)
	controller:SetScript("OnEnter", function() self:OnEnter() end)
	controller:SetScript("OnLeave", function() self:OnLeave() end)
	controller:SetScript("OnMouseUp", function(_, ...) self:OnClick(...) end)
	self.Controller = controller

	local bar = setmetatable(controller:CreateFrame("Frame"), Bar_MT)
	bar:SetSize(controller:GetSize())
	bar:SetAllPoints(controller)
	bar.data = {}

	local backdrop = bar:CreateTexture(nil, "BACKGROUND")
	backdrop:SetSize(unpack(art_config.backdrop.texture_size))
	backdrop:SetPoint(unpack(art_config.backdrop.texture_position))
	backdrop:SetTexture(art_config.backdrop.textures[num_bars])
	backdrop:SetAlpha(.75)

	local rested = StatusBar:New(controller)
	rested:SetSize(controller:GetSize())
	rested:SetAllPoints()
	rested:SetFrameLevel(1)
	rested:SetAlpha(art_config.rested.alpha)
	rested:SetStatusBarTexture(art_config.rested.texture)
	rested:SetStatusBarColor(unpack(C.General[C_XP_BONUS]))
	rested:SetSparkTexture(art_config.rested.spark.texture)
	rested:SetSparkSize(unpack(art_config.rested.spark.size))
	rested:SetSparkFlash(2.75, 1.25, .175, .425)

	local xp = StatusBar:New(controller)
	xp:SetSize(controller:GetSize())
	xp:SetAllPoints()
	xp:SetFrameLevel(2)
	xp:SetAlpha(art_config.bar.alpha)
	xp:SetStatusBarTexture(art_config.bar.texture)
	xp:SetSparkTexture(art_config.bar.spark.texture)
	xp:SetSparkSize(unpack(art_config.bar.spark.size))
	xp:SetSparkFlash(2.75, 1.25, .35, .85)

	local overlay = controller:CreateFrame("Frame")
	overlay:SetFrameStrata("MEDIUM")
	overlay:SetFrameLevel(35) -- above the actionbar artwork
	overlay:SetAllPoints()

	local value = overlay:CreateFontString(nil, "OVERLAY")
	value:SetPoint("CENTER")
	value:SetFontObject(art_config.normalFont)
	value:Hide()

	bar.Backdrop = backdrop
	bar.Rested = rested
	bar.XP = xp
	bar.Value = value

	self.Bar = bar

	-- Our XP/Rep bars aren't secure, so we need to update their sizes
	-- from normal Lua, not the secure environment.
	Main:HookScript("OnAttributeChanged", function(_, name, value)
		if (name == "numbars") then
			self:UpdateBarSettings()
		elseif (name == "state-page") then
			self.InVehicle = (value == "possess") or (value == "vehicle")
		end
		bar:Update()
	end)

	self:RegisterEvent("PLAYER_ALIVE", "Update")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
	self:RegisterEvent("PLAYER_LEVEL_UP", "Update")
	self:RegisterEvent("PLAYER_XP_UPDATE", "Update")
	self:RegisterEvent("PLAYER_LOGIN", "Update")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED", "Update")
	self:RegisterEvent("DISABLE_XP_GAIN", "Update")
	self:RegisterEvent("ENABLE_XP_GAIN", "Update")
	self:RegisterEvent("PLAYER_UPDATE_RESTING", "Update")
	self:RegisterEvent("UNIT_ENTERING_VEHICLE", "Update")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE", "Update")
	self:RegisterEvent("UNIT_EXITING_VEHICLE", "Update")
	self:RegisterEvent("UNIT_EXITED_VEHICLE", "Update")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "Update")
  self:RegisterEvent("UNIT_PET", "Update")
  self:RegisterEvent("UPDATE_FACTION")
	-- Note to self for later:
	-- 	ReputationWatchBarStatusBar ( >= WoD)
	-- 	ReputationWatchBar.StatusBar (Legion > )

end

BarWidget.GetFrame = function(self)
	return self.Controller
end

