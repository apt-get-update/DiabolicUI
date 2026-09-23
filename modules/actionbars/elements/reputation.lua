local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Reputation")
local StatusBar = Engine:GetHandler("StatusBar")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")
local F = Engine:GetDB("Library: Format")

-- Lua API
local _G = _G
local math_floor = math.floor
local unpack = unpack

-- WoW API
local GetWatchedFactionInfo = _G.GetWatchedFactionInfo
local ToggleCharacter = _G.ToggleCharacter

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Track reputation bar visibility
local REPBARVISIBLE

-- Various string formatting for our tooltips and bar, matching the XP bar
local shortXPString = "%s%%"
local longXPString = "%s / %s"
local fullXPString = "%s / %s - %s%%"

-- Bar Template
----------------------------------------------------------
-- This needs to be an actual frame (not a plain table), since we swap it in
-- as the bar's metatable further down - it's the fallback that native frame
-- methods like SetSize/SetPoint resolve through once our own methods don't
-- match.
local Bar = Engine:CreateFrame("Frame")
local Bar_MT = { __index = Bar }

Bar.UpdateData = function(self)
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

Bar.Update = function(self)
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

Bar.OnEnter = function(self)
	local data = self:UpdateData()
	if (not data.repName) then return end


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

Bar.OnLeave = function(self)
	GameTooltip:Hide()
end

Bar.OnClick = function(self)
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

BarWidget.Update = function(self)
	if self:UpdateVisibility() then
		self:UpdateBar()
	end
end

BarWidget.OnClick = function(self, ...)
	self.Bar:OnClick(...)
end

BarWidget.UpdateVisibility = function(self)
	local isVisible = Module:IsReputationVisible()
	if isVisible then
		if (not self.Controller:IsShown()) then
			self.Controller:Show()
		end
	else
		if self.Controller:IsShown() then
			self.Controller:Hide()
		end
	end
	if (REPBARVISIBLE ~= isVisible) then
		self:SendMessage("ENGINE_ACTIONBAR_REPUTATION_VISIBLE_CHANGED", isVisible)
		REPBARVISIBLE = isVisible
	end
	return isVisible
end

BarWidget.UpdateBar = function(self)
	self.Bar:Update()
end

BarWidget.UpdateBarSettings = function(self)
	local structure_config = Module.config.structure.controllers.reputation
	local art_config = Module.config.visuals.xp
	local num_bars = tostring(self.Controller:GetParent():GetAttribute("numbars"))

	self.Controller:SetSize(unpack(structure_config.size[num_bars]))
	self.Bar:SetSize(self.Controller:GetSize())
	self.Bar.XP:SetSize(self.Controller:GetSize())
	self.Bar.Backdrop:SetTexture(art_config.backdrop.textures[num_bars])
end

BarWidget.OnEnable = function(self)
	local structure_config = Module.config.structure.controllers.reputation
	local art_config = Module.config.visuals.xp
	local num_bars = tostring(Module.db.num_bars)

	local Main = Module:GetWidget("Controller: Main"):GetFrame()

	local controller = Main:CreateFrame("Frame")
	controller:SetFrameStrata("BACKGROUND")
	controller:SetFrameLevel(0)
	controller:SetSize(unpack(structure_config.size[num_bars]))
	controller:SetPoint(unpack(structure_config.position))
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
	bar.XP = xp
	bar.Value = value

	self.Bar = bar

	-- Our reputation bar isn't secure, so we need to update its size
	-- from normal Lua, not the secure environment.
	Main:HookScript("OnAttributeChanged", function(_, name, value)
		if (name == "numbars") then
			self:UpdateBarSettings()
		end
		bar:Update()
	end)

	self:RegisterEvent("PLAYER_ALIVE", "Update")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
	self:RegisterEvent("PLAYER_LOGIN", "Update")
	self:RegisterEvent("UNIT_ENTERING_VEHICLE", "Update")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE", "Update")
	self:RegisterEvent("UNIT_EXITING_VEHICLE", "Update")
	self:RegisterEvent("UNIT_EXITED_VEHICLE", "Update")
	self:RegisterEvent("UNIT_PET", "Update")
	self:RegisterEvent("UPDATE_FACTION", "Update")
end

BarWidget.GetFrame = function(self)
	return self.Controller
end
