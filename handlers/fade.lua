local ADDON, Engine = ...
local Handler = Engine:NewHandler("Fade")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local select = select
local setmetatable = setmetatable
local table_concat = table.concat
local table_insert = table.insert
local table_wipe = table.wipe

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCursorInfo = _G.GetCursorInfo
local MouseIsOver = _G.MouseIsOver
local RegisterStateDriver = _G.RegisterStateDriver
local SpellFlyout = _G.SpellFlyout
local UnitDebuff = _G.UnitDebuff
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitOnTaxi = _G.UnitOnTaxi
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType
local UnregisterStateDriver = _G.UnregisterStateDriver

-- WoW frames and objects
local UIParent = _G.UIParent

local FadeManager = CreateFrame("Frame", nil, UIParent)
local FadeManager_MT = { __index = FadeManager }

local managers = {} -- table to hold all managers
local STATE
local FORCED -- when true, all managers are forcefully shown

--[[
-- cache up spellnames so we only need one actual function call per spellID
-- tempo tempo tempo tempo... woooooooh!
local _GetSpellInfo = GetSpellInfo
local spellcache = setmetatable({}, { __index = function(t, v) 
	local a = {  _GetSpellInfo(v) } 
	if _GetSpellInfo(v) then 
		t[v] = a 
	end 
	return a 
end})
local GetSpellInfo = function(a) return unpack(spellcache[a]) end

-- keeping it safe. and fast. 
local _UnitAura = UnitAura
local UnitAura = function(unit, spell) 
	if not(unit and spell) then
		return
	else
		return _UnitAura(unit, spell)
	end
end

-- auras that we wish to treat as if the player were mounted
local mountAuras = {
	-- classes
	--------------------------------------------------------
	-- Druid
	[1066] = true, -- Aquatic Form
	[33943] = true, -- Flight Form
	[40120] = true, -- Swift Flight Form
	[783] = true, -- Travel Form
	-- Shaman
	[2645] = true, -- Ghost Wolf

	-- races
	--------------------------------------------------------
	-- Worgen
	[87840] = true -- Running Wild (Racial)
	
}
]]--

-- debuffs we ignore, so the ui can still fade out with them active
local whiteList = {
	-- deserters
	[26013] = true, -- PvP Deserter 
	[71041] = true, -- Dungeon Deserter 
	[144075] = true, -- Dungeon Deserter
	[99413] = true, -- Deserter (no idea what type)
	[158263] = true, -- Craven "You left an Arena without entering combat and must wait before entering another one." -- added 6.0.1
	[194958] = true, -- Ashran Deserter

	-- heal cooldowns
	[11196] = true, -- Recently Bandaged
	[6788] = true, -- Weakened Soul
	[178857] = true, -- Contender (Gladiator's Sanctum buff)
	
	-- burst cooldowns
	[57723] = true, -- Exhaustion from Heroism
	[57724] = true, -- Sated from Bloodlust
	[80354] = true, -- Temporal Displacement from Time Warp
	[95809] = true, -- Insanity from Ancient Hysteria

	-- resources
	[36032] = true, -- Arcane Charges
	
	-- seasonal 
	[26680] = true, -- Adored "You have received a gift of adoration!" 
	[26898] = true, -- Heartbroken "You have been rejected and can no longer give Love Tokens!"
	[71909] = true, -- Heartbroken "Suffering from a broken heart."
	[69438] = true, -- Sample Satisfaction (some love crap)
	[42146] = true, -- Brewfest Racing Ram Aura
	[43052] = true, -- Ram Fatigue "Your racing ram is fatigued."
	
	-- weird debuffs 
	[174958] = true, -- Acid Trail "Riding on the slippery back of a Goren!"  -- added 6.0.1
	[160510] = true, -- Encroaching Darkness "Something is watching you..." -- some zone in WoD
	[156154] = true, -- Might of Ango'rosh -- WoD, Talador zone buff

	-- stupid fish debuffs
	[174524] = true, -- Awesomefish
	[174528] = true, -- Grieferfish
	
	-- follower deaths 
	[173660] = true, -- Aeda Brightdawn
	[173657] = true, -- Defender Illona 
	[173658] = true, -- Delvar Ironfist
	[173976] = true, -- Leorajh 
	[173659] = true, -- Talonpriest Ishaal
	[173649] = true, -- Tormmok 
	[173661] = true, -- Vivianne 
}

local defaults = {
	profile = {
		fade = true
	}
}

local defaultFadeManagerSettings = {
	enabled = true, -- whether to fade at all
	enableActionFade = true, -- mouseover (and picking up items with the cursor for actionbars)
	enablePerilFade = true, -- fades in when the player is in peril (quest tracker has this disabled)
	enableSafeFade = true -- fades out when in a "safe" state
}

local pickupGrid = {
	item = true,
	macro = true, 
	spell = true,
	petaction = true,
	money = false,
	merchant = false, 
	battlepet = false
}

FadeManager.SetConfigAlpha = function(self)
	if not self.faded then
		self:SetAlpha(1) -- maybe we'll add options later
	end
end

-- returns the current state of the current fademanager instance
-- will check for mouseover or return the global fadestate
FadeManager.GetLocalState = function(self)
	if self.hoverTargets then
		for frame in pairs(self.hoverTargets) do
			if MouseIsOver(frame) and frame:IsVisible() and ((frame.unit and frame:IsMouseEnabled()) or not frame.unit) -- filter out hidden oUF objects
			or (SpellFlyout:IsShown() and MouseIsOver(SpellFlyout) and SpellFlyout:GetParent() and SpellFlyout:GetParent():GetParent() == frame) then -- keep bars visible while using flyouts
				return "mouseover"
			end
		end
	end
	return STATE
end

FadeManager.SetUserForced = function(self, state) self.forceShow = state end -- request constant visibility
FadeManager.IsUserForced = function(self) return self.forceShow end -- whether or not the user/module has manually requested visibility
FadeManager.SetForcedDuration = function(self, seconds) self.forceFadeIn = seconds end -- forces visibility a given duration
FadeManager.GetForcedDuration = function(self) return self.forceFadeIn end -- returns the current duration, if any
FadeManager.IsTempForced = function(self) return self.forceFadeIn ~= nil end -- returns true/false

-- action forced currently only applies to actionbars hwne pickup up stuff with the cursor
-- *set the parameter .showGrid in the manager's settings to anything but nil to activate
FadeManager.IsActionForced = function(self)
	if self.hoverTargets then
		for frame in pairs(self.hoverTargets) do
			if frame.settings and (frame.settings.showGrid ~= nil) then 
				local item = GetCursorInfo()
				if item and pickupGrid[item] then
					return true
				end
			end
		end
	end
end

FadeManager.UpdateFadeAlpha = function(self, elapsed)
	local oldAlpha = self:GetAlpha()
	if oldAlpha ~= self.currentAlpha then
		self.currentAlpha = self:GetAlpha() -- just to catch alpha changes done by profile resets, theme changes and similar
	end
	if FORCED or self:IsUserForced() or self:IsActionForced() or self:IsTempForced() then
		self.targetAlpha = 1
		self.step = elapsed/.75
		self.delay = 0
	else
		local state = self:GetLocalState() 
		if state == "mouseover" or (state == "peril" and self.settings.enablePerilFade) then 
			self.targetAlpha = 1
			self.step = elapsed/.25 -- fade in
			self.delay = 0
		else
			self.targetAlpha = 0
			self.step = elapsed/1.5 -- fade out
			self.delay = 1
		end
		if self.currentAlpha == 0 or state == self.oldstate then
			self.delay = 0 -- prevent the delay unless the previous state was fully achieved
		else
			if self.oldTargetAlpha == self.currentAlpha then
				-- self.delay = self.settings.states[state].fadeDelay -- only delay when we reached whatever the previous goal was 
			else
				self.delay = 0
			end
		end
	end
	if self.forceFadeIn then
		self.forceFadeIn = self.forceFadeIn - elapsed
		if self.forceFadeIn <= 0 then
			self.forceFadeIn = nil
		end
	end
	if self.currentAlpha ~= self.targetAlpha then
		self.fading = true
		if self.elapsed > self.delay then
			if self.targetAlpha > self.currentAlpha + self.step then
				self.currentAlpha = self.currentAlpha + self.step -- fade in
			elseif self.targetAlpha < self.currentAlpha - self.step then
				self.currentAlpha = self.currentAlpha - self.step -- fade out
			else
				self.currentAlpha = self.targetAlpha -- fading done
				self.oldTargetAlpha = self.targetAlpha
				self.fading = false
				self.elapsed = 0
				self.oldstate = self:GetLocalState()
      end
		end
		self:SetAlpha(self.currentAlpha)
	else
		self.fading = false
		self.elapsed = 0
	end
end

FadeManager.ApplySettings = Engine:Wrap(function(self, settings)
	self.settings = setmetatable(settings or self.settings or {}, { __index = defaultFadeManagerSettings }) 
	self:SetConfigAlpha()
	self:ApplyVisibilityDriver()
end)

FadeManager.Enable = Engine:Wrap(function(self)
	if self.enabled then return end
	local settings = self.settings
	settings.enabled = true
	self.enabled = true
	self:ApplyVisibilityDriver()
end)

FadeManager.Disable = Engine:Wrap(function(self)
	if not self.enabled then return end
	local settings = self.settings
	settings.enabled = false
	self.enabled = false
	self:ApplyVisibilityDriver()
end)

FadeManager.IsEnabled = function(self)
	return self.enabled
end

FadeManager.ApplyVisibilityDriver = Engine:Wrap(function(self)
	local settings = self.settings
	self:SetAttribute("_onstate-vis", [[
		if not newstate then return end
		if newstate == "show" then
			self:Show()
			self:SetAttribute("fade", false)
		elseif strsub(newstate, 1, 4) == "fade" then
			self:Show()
			self:SetAttribute("fade", newstate == "fade") 
		elseif newstate == "hide" then
			self:Hide()
		end
	]])
	UnregisterStateDriver(self, "vis")
	if settings.enabled then 
		RegisterStateDriver(self, "vis", "[petbattle]hide;fade")
	else
		RegisterStateDriver(self, "vis", "[petbattle]hide;show")
	end
end)

FadeManager.RegisterObject = Engine:Wrap(function(self, object)
	if not self.hoverTargets then
		self.hoverTargets = {}
	end
	local parent = object:GetParent()
	object:SetParent(self)
	self.hoverTargets[object] = parent
end)

FadeManager.RegisterHoverObject = Engine:Wrap(function(self, object)
	if not self.hoverTargets then
		self.hoverTargets = {}
	end
	self.hoverTargets[object] = true
end)

FadeManager.UnregisterObject = Engine:Wrap(function(self, object)
	if not self.hoverTargets then return end
	local parent = self.hoverTargets[object]
	if parent ~= true then
		object:SetParent(parent)
	end
	self.hoverTargets[object] = nil
end)

FadeManager.UnregisterAllObjects = Engine:Wrap(function(self)
	if not self.hoverTargets then return end
	for object, parent in pairs(self.hoverTargets) do
		object:SetParent(parent)
    table_wipe(self.hoverTargets[object])
	end
end)

Handler.GetState = function(self) return self._mainState end
Handler.GetSecureState = function(self) return self._secureState end
Handler.GetNonSecureState = function(self) return self._nonSecureState end
Handler.IsFadeManager = function(self, frame)
	for _,manager in ipairs(managers) do
		if frame == manager then 
			return true 
		end
	end
end
Handler.CreateFadeManager = function(self, name, ...)
	local numManagers = #managers or 0
	local manager = setmetatable(CreateFrame("Frame", "GUI4_FadeManager"..(numManagers + 1)..(name or ""), UIParent, "SecureHandlerStateTemplate"), FadeManager_MT)
	manager.settings = setmetatable({}, { __index = defaultFadeManagerSettings }) 
	manager:SetSize(1,1)
	manager:SetPoint("TOPLEFT", 0, 0)
	manager:SetPoint("BOTTOMRIGHT", 0, 0)
	manager.currentAlpha = 1
	manager.elapsed = 0
	manager:HookScript("OnAttributeChanged", function(self, attribute, value)
		if attribute == "fade" then
			if value then
				self:SetScript("OnUpdate", function(self, elapsed)
					self.elapsed = self.elapsed + elapsed
					if self.elapsed < .05 then 
						return 
					end
					self:UpdateFadeAlpha(elapsed)
				end)
			else
				self:SetScript("OnUpdate", nil)
				self.elapsed = 0
				self.faded = nil
				self:SetConfigAlpha()
			end
		end
	end)
	table_insert(managers, manager)
	if (...) then
		for i = 1, select("#", ...) do
			manager:RegisterObject(select(i, ...))
		end
	end
	return manager
end

Handler.ForAll = function(self, method, ...)
	for _,manager in ipairs(managers) do
		if manager[method] then
			manager[method](manager, ...)
		end
	end
end

Handler.ApplySettings = Engine:Wrap(function(self)
	self:ForAll("ApplySettings")
end)

Handler.GetState = function(self) return STATE end
Handler.SetState = function(self, state) STATE = state end
Handler.GetSecureState = function(self) return self._secureState end
Handler.SetSecureState = function(self, state) self._secureState = state end
Handler.GetNonSecureState = function(self) return self._nonSecureState end
Handler.SetNonSecureState = function(self, state) self._nonSecureState = state end

Handler.UpdateState = function(self)
	local new
	local old = self:GetState()
	local primary = self:GetSecureState()
	if primary == "target" then
		new = "peril"
	elseif primary == "dead" then
		new = "safe"
	elseif primary == "combat" or primary == "override" then
		new = "peril"
	elseif primary == "mounted" or primary == "resting" or primary == "nocombat" then
		local secondary = self:GetNonSecureState()
		if secondary == "lowhealth" or secondary == "lowpower" or secondary == "debuff" then
			new = "peril"
		else
			new = "safe"
		end
	end
	if new ~= old then
		self:SetState(new)
		Engine:Fire("ENGINE_FADESTATE_UPDATE", new)
	end
end

Handler.UpdateSecureState = function(self, state)
	self:SetSecureState(state)
	self:UpdateState()
end

local first
local unitEvents = {
	ENTER = {
		PLAYER_ENTERING_WORLD = true
	},
	HEALTH = {
		UNIT_HEALTH = true,
		UNIT_MAXHEALTH = true
	},
	POWER = {
		UNIT_MANA = true,
		UNIT_RAGE = true,
		UNIT_FOCUS = true,
		UNIT_ENERGY = true,
		UNIT_RUNIC_POWER = true,
		UNIT_MAXMANA = true,
		UNIT_MAXRAGE = true,
		UNIT_MAXFOCUS = true,
		UNIT_MAXENERGY = true,
		UNIT_DISPLAYPOWER = true,
		UNIT_MAXRUNIC_POWER = true
	},
	AURA = {
		UNIT_AURA = true
	}
}
Handler.UpdateNonSecureState = function(self, event, ...)
	local state
	if event then
		if unitEvents.ENTER[event] then
			if not first then
				self:ForAll("SetForcedDuration", 5) -- force initial visibility, to give people a clue what's where
				first = true
				return
			end
		end
		
		if unitEvents.HEALTH[event] then
			local min, max = UnitHealth("player"), UnitHealthMax("player")
			self.unitData.lowhealth = min/max < .9
		end

		if unitEvents.POWER[event] then
			local _, type = UnitPowerType("player")
			local min, max = UnitPower("player"), UnitPowerMax("player")
			if type == "MANA" then
				self.unitData.lowpower = min/max < .75
			elseif type == "ENERGY" or type == "FOCUS" then
				self.unitData.lowpower = min/max < .5
			elseif type == "RUNIC_POWER" then
				self.unitData.lowpower = min/max > .85 
			elseif type == "RAGE" then
				self.unitData.lowpower = min/max > .85 -- because warriors seem to be swimming in it
			else 
				self.unitData.lowpower = false
			end
		end

		if unitEvents.AURA[event] then
			self.unitData.badaura = false
			for i = 1, 40 do
				local spellId = select(11, UnitDebuff("player", i))
				if spellId then
					if not whiteList[spellId] then
						self.unitData.badaura = true
						break
					end
				else
					break
				end
			end
		end
	end

	if self.unitData.lowhealth then 
		state = "lowhealth"
	elseif self.unitData.lowpower then 
		state = "lowpower"
	elseif self.unitData.badaura then 
		state = "debuff"
	end
	
	-- if UnitOnTaxi("player") then
		-- state = "taxi"
		-- return 
	-- end
	
	-- for spellID in pairs(mountAuras) do
		-- self.unitData.mountaura = false
		-- if UnitAura("player", GetSpellInfo(spellID)) then
			-- self.unitData.mountaura = true
			-- break
		-- end
	-- end
	-- if self.unitData.mountaura then 
		-- state = "travelform"
		-- return 
	-- end
	
	self:SetNonSecureState(state)
	self:UpdateState()
end

Handler.ProcessUnitEvents = function(self, event, unit, ...)
	if unit ~= "player" then return end
	self:UpdateNonSecureState(event, ...)
end

Handler.EnableFade = function(self)
	FORCED = false
end

Handler.DisableFade = function(self)
	FORCED = true
end

Handler.OnEnable = function(self)
	FORCED = false
	
	-- table to hold info about the player's health & auras
	self.unitData = {}
	
	-- keeping track of the main states by piggybacking on a state driver
	self.stateframe = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
	self.stateframe:SetScript("OnAttributeChanged", function(_, attribute, value) 
		if not attribute then return end
		if attribute:find("fadecondition") then
			self:UpdateSecureState(value)
		end
	end)

	-- doing it this way for more clearity regarding priority of fade states
	-- note to self: remember the order, remember remember!
	local driver = "[@target,exists]target;"
	driver = driver .. "[@player,dead]dead;"
	driver = driver .. "[combat]combat;"
	driver = driver .. ""
	driver = driver .. "[bonusbar:5][vehicleui]override;"
	driver = driver .. "[flying][mounted]mounted;"
	driver = driver .. "nocombat"

	RegisterStateDriver(self.stateframe, "fadecondition", driver)
	
	-- add unit events we need 
	for _,eventList in pairs(unitEvents) do
		for event in pairs(eventList) do
			self:RegisterEvent(event, "ProcessUnitEvents")
		end
	end

	-- event driven states we need to watch out for
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateNonSecureState")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateNonSecureState")

	-- only good way to know when to check for taxis
	hooksecurefunc("TakeTaxiNode", function() self:UpdateNonSecureState("TAXI") end) 
end
