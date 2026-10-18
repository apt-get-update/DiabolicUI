-- The Engine: DiabolicUI's own small framework. Every file reaches it
-- through the addon table: `local ADDON, Engine = ...`.
--
-- Objects
--   Handlers  Engine:NewHandler(name)   Reusable libraries (unit frames,
--             action buttons, orbs...). Enabled before any module, and get
--             events before modules do.
--   Elements  handler:SetElement(name)  Parts of a handler, such as the
--             Blizzard UI pieces handlers/blizzard.lua can disable.
--   Modules   Engine:NewModule(name[, priority])  Features. They get an
--             OnInit and an OnEnable call; priority is "HIGH", "NORMAL"
--             (default) or "LOW".
--   Widgets   module:SetWidget(name)    Parts of a module, which enables
--             them itself. They receive events while their module is enabled.
--
-- Startup
--   Once both ADDON_LOADED and VARIABLES_LOADED have fired (in either order):
--   saved settings are merged in (ParseSavedVariables), handlers are enabled,
--   every module's OnInit runs, then OnEnable for HIGH and NORMAL modules.
--   LOW modules are enabled on PLAYER_LOGIN, or straight away after a /reload.
--   A module marked with SetIncompatible is skipped entirely when that addon
--   is enabled.
--
-- Events and messages
--   object:RegisterEvent(event[, method]), object:RegisterMessage(message
--   [, method]) and Engine:Fire(message, ...). The method is a method name or
--   a function, "Update" by default: that calls object[event] if it exists,
--   object:OnEvent otherwise. Disabled objects don't receive anything.
--
-- Settings
--   Engine:NewConfig(name, defaults)    Saved settings, with global, realm,
--   Engine:GetConfig(name[, profile])   faction and character profiles.
--   Engine:NewStaticConfig(name, t)     Static tables (layouts, textures,
--   Engine:GetDB(name)                  colors) that are never saved.
--
-- Combat
--   Engine:Wrap(func) returns a function that runs func right away out of
--   combat, and once, with the latest arguments, when combat ends otherwise.
--   Module Enable/Disable calls go through it.
--
-- Covered by tests/test_engine_core.lua; docs/ goes into more depth.
local ADDON, Engine = ...
local L = Engine:GetLocale()

-------------------------------------------------------------
-- Lua API
-------------------------------------------------------------
local _G = _G
local assert = assert
local debugstack = debugstack
local error = error
local getmetatable = getmetatable
local ipairs = ipairs
local math_floor = math.floor
local pairs = pairs
local select = select
local setmetatable = setmetatable
local string_join = string.join
local string_lower = string.lower
local string_match = string.match
local table_concat = table.concat
local table_remove = table.remove
local tonumber = tonumber
local tostring = tostring
local type = type
local unpack = unpack
local xpcall = xpcall


-------------------------------------------------------------
-- WOW API
-------------------------------------------------------------
local CreateFrame = _G.CreateFrame
local GetAddOnInfo = _G.GetAddOnInfo
local GetNumAddOns = _G.GetNumAddOns
local GetRealmName = _G.GetRealmName
local geterrorhandler = _G.geterrorhandler
local InCombatLockdown = _G.InCombatLockdown
local IsLoggedIn = _G.IsLoggedIn
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitFactionGroup = _G.UnitFactionGroup
local UnitName = _G.UnitName


-------------------------------------------------------------
-- WOW Frames & Tables
-------------------------------------------------------------
local UIParent = _G.UIParent
local WorldFrame = _G.WorldFrame


-------------------------------------------------------------
-- Engine Registries
-------------------------------------------------------------
local events = {} -- event registry

local configs = {} -- config registry saved between sessions
local staticConfigs = {} -- static configurations set by the modules
local privateConfigs = {} -- static configurations only directly available to the Engine

local handlers = {} -- handler registry
local handlerElements = {} -- handler element registry
local handlerElementsEnabledState = {} -- registry to "reverse" the enable/disable status of handler elements

local modules = {} -- module registry
local moduleWidgets = {} -- module widget registry
local moduleLoadPriority = { HIGH = {}, NORMAL = {}, LOW = {} } -- module load priorities

local initializedObjects = {} -- hash table for initialized objects
local enabledObjects = {} -- hash table for enabled modules, widgets and handler elements

local objectName = {} -- table to hold the display names (ID) of all handlers, modules, widgets and elements
local objectType = {} -- table to quickly look up what sort of object we're working with (handler, module, widget, element)

local queue = {} -- [func] = its arguments, for calls the out of combat wrapper put off

local keyWords = {} -- keyword registry to translate words to frame handles used for anchoring or parenting

local incompats = {} -- table holding module/widget/handler incompatibilities

-------------------------------------------------------------
-- Flags and other values meant to be read-only
-------------------------------------------------------------
local INCOMBAT = UnitAffectingCombat("player") -- flag to track combat status
local INLOCKDOWN = InCombatLockdown() -- flag to track combat lockdown status

local PRIORITY_HASH = { HIGH = true, NORMAL = true, LOW = true } -- hashed priority table, for faster validity checks
local PRIORITY_INDEX = { "HIGH", "NORMAL", "LOW" } -- indexed/ordered priority table
local DEFAULT_MODULE_PRIORITY = "NORMAL" -- default load priority for new modules

local KEYWORD_DEFAULT -- default keyword used as a fallback. this will not be user editable.

-------------------------------------------------------------
-- Saved variables
-------------------------------------------------------------
DiabolicUI_DB = {} 

-------------------------------------------------------------
-- Engine Frames & UI Widgets
-------------------------------------------------------------

-- Frame meant for events
local Frame = CreateFrame("Frame", nil, WorldFrame) -- parented to world frame to keep running even if the UI is hidden
local FrameMethods = getmetatable(Frame).__index


-- Frame for UI positioning, because sometimes (with multimonitor setups etc) the regular UIParent won't work.
-- We also need this one to have a secure scaling option for the UI, which the user can change graphically even in combat!
local UICenter = CreateFrame("Frame", nil, UIParent, "SecureHandlerAttributeTemplate")
UICenter:SetFrameLevel(UIParent:GetFrameLevel())
UICenter:SetSize(UIParent:GetSize())
UICenter:SetPoint("BOTTOM", UIParent, "BOTTOM")

-- Frame for all UI config dialogs
local UIConfig = CreateFrame("Frame", nil, UICenter, "SecureHandlerAttributeTemplate")
UIConfig:SetFrameStrata("DIALOG")
UIConfig:SetAllPoints(UICenter)
UIConfig:Hide()


-------------------------------------------------------------
-- Declarations of stuff we embed later
-------------------------------------------------------------
local Orb
local StatusBar


-------------------------------------------------------------
-- Utility Functions
-------------------------------------------------------------

-- Syntax check (A shout-out to Haste for this one!)
local check = function(self, value, num, ...)
	assert(type(num) == "number", L["Bad argument #%d to '%s': %s expected, got %s"]:format(2, "Check", "number", type(num)))
	for i = 1,select("#", ...) do
		if type(value) == select(i, ...) then 
			return 
		end
	end
	local types = string_join(", ", ...)
	local name = string_match(debugstack(2, 2, 0), ": in function [`<](.-)['>]")
	error(L["Bad argument #%d to '%s': %s expected, got %s"]:format(num, name, types, type(value)), 3)
end

-- Translate keywords to frame handles used for anchoring.
local parseAnchor = function(anchor)
	return anchor and (keyWords[anchor] and keyWords[anchor]() or _G[anchor] and _G[anchor] or anchor) or KEYWORD_DEFAULT and keyWords[KEYWORD_DEFAULT]() or WorldFrame
end

-- Embed source methods into target.
local embed = function(target, source)
	for i,v in pairs(source) do
		if (type(v) == "function") then
			target[i] = v
		end
	end
	return target
end

-- Deep copy a table into a new table 
-- or into the optional target.
local copyTable
copyTable = function(source, target)
	local new = target or {}
	for i,v in pairs(source) do
		if (type(v) == "table") then
			if (new[i] and (type(new[i]) == "table")) then
				new[i] = copyTable(source[i], new[i]) 
			else
				new[i] = copyTable(source[i])
			end
		else
			new[i] = source[i]
		end
	end
	return new
end




-------------------------------------------------------------
-- Event & OnUpdate Handler
-------------------------------------------------------------

-- Calls everything one object registered for an event or message, in
-- order. A function can unregister itself (or another) while this runs:
-- the list closes up, so the one after it moves into its place.
local call = function(object, list, missing, event, ...)
	local i, calls, max = 1, 0, #list -- (max: anything registered meanwhile waits for the next time)
	local func = list[i]
	while func and (calls < max) do
		calls = calls + 1
		if type(func) == "string" then
			local method = object[func]
			if not method then
				return error((object == Engine) and L[missing]:format(func) or L[missing]:format(tostring(object), func))
			end
			method(object, event, ...)
		else
			func(object, event, ...)
		end
		if (list[i] == func) then
			i = i + 1
		end
		func = list[i]
	end
end

-- Delivers a game event (withElements) or an addon message to every object
-- registered for it: the Engine, then enabled handlers (and for events,
-- their elements), then enabled modules by priority, and their widgets.
local deliver = function(withElements, event, ...)
	local registry = events[event]
	if not registry then
		return
	end
	local list = registry[Engine]
	if list then
		call(Engine, list, "The Engine has no method named '%s'!", event, ...)
	end
	for _, handler in pairs(handlers) do
		if enabledObjects[handler] then
			list = registry[handler]
			if list then
				call(handler, list, "The handler '%s' has no method named '%s'!", event, ...)
			end
			if withElements then
				for _, element in pairs(handlerElements[handler]) do
					list = registry[element]
					if list then
						call(element, list, "The handler element '%s' has no method named '%s'!", event, ...)
					end
				end
			end
		end
	end
	for _, priority in ipairs(PRIORITY_INDEX) do
		for _, module in pairs(moduleLoadPriority[priority]) do
			if enabledObjects[module] then
				list = registry[module]
				if list then
					call(module, list, "The module '%s' has no method named '%s'!", event, ...)
				end
				for _, widget in pairs(moduleWidgets[module]) do
					list = registry[widget]
					if list then
						call(widget, list, "The module widget '%s' has no method named '%s'!", event, ...)
					end
				end
			end
		end
	end
end

-- script handler for Frame's OnEvent
local OnEvent = function(self, event, ...)
	return deliver(true, event, ...)
end

-- engine and object methods
-- Sends an addon message to every object registered for it: the Engine,
-- then enabled handlers, then enabled modules (by priority) and their widgets.
local Fire = function(self, message, ...)
	self:Check(message, 1, "string")
	return deliver(false, message, ...)
end

-- Calls func (a method name, a function, or "Update" when nil) on this
-- object whenever the game event fires. Registering the same func twice
-- is ignored.
local RegisterEvent = function(self, event, func)
	self:Check(event, 1, "string")
	self:Check(func, 2, "string", "function", "nil")
	if not events[event] then
		events[event] = {}
	end
	if not events[event][self] then
		events[event][self] = {}
	end
	if not Frame:IsEventRegistered(event) then
		Frame:RegisterEvent(event)
		if not Frame.eventRegistry then
			Frame.eventRegistry = {}
		end
		if not Frame.eventRegistry[event] then
			Frame.eventRegistry[event] = 0
		end
	end
	if func == nil then 
		func = "Update"
	end
	for i = 1, #events[event][self] do
		if events[event][self][i] == func then -- avoid duplicate calls to the same function
			return 
		end
	end
	events[event][self][#events[event][self] + 1] = func

	-- This needs to come down here, so that multiple instances of the same event will each get a count
	Frame.eventRegistry[event] = Frame.eventRegistry[event] + 1
end

local IsEventRegistered = function(self, event, func)
	self:Check(event, 1, "string")
	self:Check(func, 2, "string", "function", "nil")
	if not Frame:IsEventRegistered(event) then 
		return false
	end
	if not(events[event] and events[event][self]) then
		return false
	end
	if func == nil then 
		func = "Update"
	end
	for i = 1, #events[event][self] do
		if events[event][self][i] == func then 
			return true
		end
	end
	return false	
end

-- Undoes RegisterEvent for the same func. Errors when it wasn't registered.
local UnregisterEvent = function(self, event, func)
	self:Check(event, 1, "string")
	self:Check(func, 2, "string", "function", "nil")
	if not events[event] then
		return error(L["The event '%s' isn't currently registered to any object."]:format(event))
	end
	if not events[event][self] then
		return error(L["The event '%s' isn't currently registered to the object '%s'."]:format(event, tostring(self)))
	end
	if func == nil then 
		func = "Update"
	end
	for i = #events[event][self], 1, -1 do
		if events[event][self][i] == func then 
			table_remove(events[event][self], i)
			if Frame.eventRegistry and Frame.eventRegistry[event] then
				Frame.eventRegistry[event] = Frame.eventRegistry[event] - 1
				if Frame.eventRegistry[event] == 0 then
					Frame:UnregisterEvent(event)
				end
			end
			return 
		end
	end
	if type(func) == "string" then
		if func == "Update" then
			return error(L["Attempting to unregister the general occurence of the event '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterEvent?"]:format(event, tostring(self)))
		else
			return error(L["The method named '%s' isn't registered for the event '%s' in the object '%s'."]:format(func, event, tostring(self)))
		end
	else
		return error(L["The function call assigned to the event '%s' in the object '%s' doesn't exist."]:format(event, tostring(self)))
	end
end

-- Like RegisterEvent, for the addon's own messages sent with Engine:Fire.
local RegisterMessage = function(self, message, func)
	self:Check(message, 1, "string")
	self:Check(func, 2, "string", "function", "nil")
	if not events[message] then
		events[message] = {}
	end
	if not events[message][self] then
		events[message][self] = {}
	end
	if func == nil then 
		func = "Update"
	end
	for i = 1, #events[message][self] do
		if events[message][self][i] == func then -- avoid duplicate calls to the same function
			return 
		end
	end
	events[message][self][#events[message][self] + 1] = func
end

local IsMessageRegistered = function(self, message, func)
	self:Check(message, 1, "string")
	self:Check(func, 2, "string", "function", "nil")
	if not(events[message] and events[message][self]) then
		return false
	end
	if func == nil then 
		func = "Update"
	end
	for i = 1, #events[message][self] do
		if events[message][self][i] == func then 
			return true
		end
	end
	return false
end

local UnregisterMessage = function(self, message, func)
	self:Check(message, 1, "string")
	self:Check(func, 2, "string", "function", "nil")
	if not events[message] then
		return error(L["The message '%s' isn't currently registered to any object."]:format(message))
	end
	if not events[message][self] then
		return error(L["The message '%s' isn't currently registered to the object '%s'."]:format(message, tostring(self)))
	end
	if func == nil then 
		func = "Update"
	end
	for i = #events[message][self], 1, -1 do
		if events[message][self][i] == func then 
			table_remove(events[message][self], i)
			return 
		end
	end
	if type(func) == "string" then
		if func == "Update" then
			return error(L["Attempting to unregister the general occurence of the message '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterMessage?"]:format(message, tostring(self)))
		else
			return error(L["The method named '%s' isn't registered for the message '%s' in the object '%s'."]:format(func, message, tostring(self)))
		end
	else
		return error(L["The function call assigned to the message '%s' in the object '%s' doesn't exist."]:format(message, tostring(self)))
	end
	
end



-------------------------------------------------------------
-- Config
-------------------------------------------------------------

-- Merges the saved DiabolicUI_DB into the registered configs (saved values
-- win over defaults, profile by profile), then points DiabolicUI_DB back at
-- the live profiles so changes are saved on logout. Runs once, before any
-- module's OnInit. Saved data for configs nobody registers is left alone.
Engine.ParseSavedVariables = function(self)
	-- Merge and/or overwrite current configs with stored settings.
	-- *doesn't matter that we mess up any links by replacing the tables, 
	--  because this all happens before any module's OnInit or OnEnable,
	--  meaning if the modules do it right, they haven't fetched their config or db yet.
	for name,data in pairs(DiabolicUI_DB) do
		if data.profiles and configs[name] and configs[name].profiles then
			local profiles = data.profiles -- speeeed!

			-- add stored realm dbs to our db
			if profiles.realm then
				for realm,realmdata in pairs(profiles.realm) do
					configs[name].profiles.realm[realm] = copyTable(profiles.realm[realm], configs[name].profiles.realm[realm])
				end
			end

			-- add stored faction dbs to our db
			if profiles.faction then
				for faction,factiondata in pairs(profiles.faction) do
					configs[name].profiles.faction[faction] = copyTable(profiles.faction[faction], configs[name].profiles.faction[faction])
				end
			end

			-- add stored character dbs to our db
			if profiles.character then
				for char,chardata in pairs(profiles.character) do
					configs[name].profiles.character[char] = copyTable(profiles.character[char], configs[name].profiles.character[char])
				end
			end

			-- global config
			if profiles.global then
				configs[name].profiles.global = copyTable(profiles.global, configs[name].profiles.global)
			end
		end
	end	
	
	-- Point the saved variables back to our configs.
	-- *This isn't redundant, because there can be new configs here 
	--  that hasn't previously been saved either because of me adding a new module, 
	--	or because it's the first time running the addon.
	for name,data in pairs(configs) do
		DiabolicUI_DB[name] = { profiles = configs[name].profiles }
	end
end


-- Registers saved settings. `config` holds the defaults; each profile
-- (global, realm, faction, character) starts as its own copy of them.
local NewConfig = function(self, name, config)
	self:Check(name, 1, "string")
	self:Check(config, 2, "table")
	if configs[name] then
		return error(L["The config '%s' already exists!"]:format(name))
	end	
	
	local faction = UnitFactionGroup("player")
	local realm = GetRealmName() 
	local character = UnitName("player")	

	configs[name] = {
		defaults = copyTable(config),
		profiles = {
			realm = { [realm] = copyTable(config) },
			faction = { [faction] = copyTable(config) },
			character = { [character.."-"..realm] = copyTable(config) }, -- we need the realm name here to avoid duplicates
			global = copyTable(config)
		}
	}
end

-- if the 'profile' argument is left out, the 'global' profile will be returned
local GetConfig = function(self, name, profile, option, silentFail)
	self:Check(name, 1, "string")
	self:Check(profile, 2, "string", "nil")
	self:Check(option, 3, "string", "nil")
	if not configs[name] then
		if silentFail then 
			return 
		end
		return error(L["The config '%s' doesn't exist!"]:format(name))
	end	
	local config
	if (profile == "realm") then
		config = configs[name].profiles.realm[(GetRealmName())]
		
	elseif (profile == "character") then
		config = configs[name].profiles.character[UnitName("player").."-"..GetRealmName()]
		
	elseif (profile == "faction") then
		config = configs[name].profiles.faction[(UnitFactionGroup("player"))]
		
	elseif (not profile) then
		config = configs[name].profiles.global
	end
	if (not config) then
		return error(L["The config '%s' doesn't have a profile named '%s'!"]:format(name, profile))
	end
	return config
end

-- Returns a static table registered with NewStaticConfig. Private ones
-- (such as "Data: Constants") are for the Engine itself only.
local GetDB = function(self, name, private)
	self:Check(name, 1, "string")
	if (private and (self ~= Engine)) then
		return error(L["Only the Engine can access private configs"])
	end
	local configTable = private and privateConfigs or staticConfigs
	if (not configTable[name]) then
		return error(L["The static config '%s' doesn't exist!"]:format(name))
	end	
	return configTable[name]
end

-- Registers a static (never saved) table under a name. It's copied, so
-- changing the original afterwards has no effect.
local NewStaticConfig = function(self, name, config, private)
	self:Check(name, 1, "string")
	self:Check(config, 2, "table")
	local configTable = private and privateConfigs or staticConfigs
	if configTable[name] then
		return error(L["The static config '%s' already exists!"]:format(name))
	end	
	configTable[name] = copyTable(config)
end



-------------------------------------------------------------
-- Secure/OutOfCombat Wrapper
-------------------------------------------------------------

-- Runs func(...) now, or once combat ends if it's locked down. Calls put
-- off for the same function are merged: the last arguments are kept.
local safeCall = function(func, ...)
	-- (PLAYER_REGEN_DISABLED fires just before the lockdown starts:
	-- until then, calls still run right away)
	if INCOMBAT and (not INLOCKDOWN) then
		INLOCKDOWN = InCombatLockdown()
	end
	if (not INCOMBAT) or (not INLOCKDOWN) then
		func(...)
		return
	end
	queue[func] = { n = select("#", ...), ... }
end

local combatStarts = function(self, event, ...)
	INCOMBAT = true -- combat starts
end

local combatEnds = function(self, event, ...)
	INCOMBAT = false
	INLOCKDOWN = false
	for func, args in pairs(queue) do
		queue[func] = nil
		func(unpack(args, 1, args.n))
	end
end

-- Local wrapper function to turn a function into a safecall 
-- that will be queued to combat end if called while 
-- the player or the player's pet or minion is in combat.
local wrap = function(self, func)
	return function(...)
		return safeCall(func, ...)
	end
end



-------------------------------------------------------------
-------------------------------------------------------------
-- Prototypes
-------------------------------------------------------------
-------------------------------------------------------------

-- default event handler 
local Update = function(self, event, ...)
	if not enabledObjects[self] then
		return
	end
	if self[event] then
		return self[event](self, event, ...)
	end
	if self.OnEvent then
		return self:OnEvent(event, ...)
	end
end

-- Runs OnInit once, unless the object is incompatible.
local Init = function(self, ...)
	if self:IsIncompatible() then
		return
	end
	if (not initializedObjects[self]) then 
		initializedObjects[self] = true
		if self.OnInit then
			return self:OnInit(...)
		end
	end
end

-- Runs OnEnable once and marks the object enabled (so it gets events),
-- unless it's incompatible.
local Enable = function(self, ...)
	if self:IsIncompatible() then
		return
	end
	if (not enabledObjects[self]) then 
		enabledObjects[self] = true
		if self.OnEnable then
			self:OnEnable(...)
		end
		return
	end
end

-- Marks the object disabled (no more events) and runs OnDisable.
local Disable = function(self, ...)
	if enabledObjects[self] then 
		enabledObjects[self] = false
		if self.OnDisable then
			return self:OnDisable(...)
		end
	end
end

local IsEnabled = function(self)
	return enabledObjects[self]
end

local GetHandler = function(self, name, silent)
	self:Check(name, 1, "string")
	self:Check(silent, 2, "boolean", "nil")
	if handlers[name] then
		return handlers[name]
	end
	if not silent then
		return error(L["Bad argument #%d to '%s': No handler named '%s' exist!"]:format(1, "Get", name))
	end
end

local GetModule = function(self, name, silent)
	self:Check(name, 1, "string")
	self:Check(silent, 2, "boolean", "nil")
	if modules[name] then
		return modules[name]
	end
	if not silent then
		return error(L["Bad argument #%d to '%s': No module named '%s' exist!"]:format(1, "Get", name))
	end
end

local IsIncompatible = function(self)
	if (not incompats[self]) then
		return false
	end
	for addonName, condition in pairs(incompats[self]) do
		if (type(condition) == "function") then
			if Engine:IsAddOnEnabled(addonName) then
				return condition(self)
			end
		else
			if Engine:IsAddOnEnabled(addonName) then
				return true
			end
		end
	end
	return false
end

-- object:SetIncompatible("AddOn"[, condition], ...): skip this object while
-- that addon is enabled. With a condition function, skip only when it
-- returns true.
local SetIncompatible = function(self, ...)
	if (not incompats[self]) then
		incompats[self] = {}
	end
	local numArgs = select("#", ...)
	local currentArg = 1

	while currentArg <= numArgs do
		local addonName = select(currentArg, ...)
		self:Check(addonName, currentArg, "string")

		local condition
		if (numArgs > currentArg) then
			local nextArg = select(currentArg + 1, ...)
			if (type(nextArg) == "function") then
				condition = nextArg
				currentArg = currentArg + 1
			end
		end
		currentArg = currentArg + 1
		incompats[self][addonName] = condition and condition or true
	end
end


-- core object that all inherits from
local corePrototype = {
	Check = check,
	Update = Update,
	Enable = wrap(Engine, Enable),
	Disable = wrap(Engine, Disable), 
	IsEnabled = IsEnabled,
	RegisterEvent = RegisterEvent,
	RegisterMessage = RegisterMessage,
	UnregisterEvent = UnregisterEvent,
	UnregisterMessage = UnregisterMessage,
	IsEventRegistered = IsEventRegistered,
	IsMessageRegistered = IsMessageRegistered,
	SetIncompatible = SetIncompatible,
	IsIncompatible = IsIncompatible,
	SendMessage = Fire,
	GetHandler = GetHandler,
	GetModule = GetModule,
	NewConfig = NewConfig,
	GetConfig = GetConfig,
	NewStaticConfig = NewStaticConfig,
	GetDB = GetDB,
	Wrap = wrap
}
local corePrototype_MT = { __index = corePrototype, __tostring = function(t) return objectName[t] end }



-------------------------------------------------------------
-- Handlers & Elements
-------------------------------------------------------------
-- 	Handlers are the parts of the engine that function as libraries.
-- 	They are loaded before any modules, and any events or messages 
-- 	are sent to the handlers before the modules. 
-- 	This is intentional.
-------------------------------------------------------------

-- handler element prototype
local elementPrototype = setmetatable({}, corePrototype_MT)
local elementPrototype_MT = { __index = elementPrototype, __tostring = function(t) return objectName[t] end }

-- handler prototype
local handlerPrototype = setmetatable({
	GetElement = function(self, name, ...)
		self:Check(name, 1, "string")
		local elementPool = handlerElements[self]
		return elementPool[name]
	end, 
	
	-- Handler elements, like every object, are enabled and disabled out of
	-- combat only (see Engine:Wrap).
	SetElement = function(self, name, template)
		self:Check(name, 1, "string")
		self:Check(template, 2, "table", "nil")

		local elementPool = handlerElements[self]
		if elementPool[name] then
			return error(L["The element '%s' is already registered to the '%s' handler!"]:format(name, tostring(self)))
		end

		local element = setmetatable(template or {}, elementPrototype_MT)

		objectName[element] = name
		objectType[element] = "element"
		
		if handlerElementsEnabledState[self] then
			enabledObjects[element] = true
		end

		elementPool[name] = element
		
		return element
	end, 
	
	SetElementDefaultEnabledState = function(self, state)
		handlerElementsEnabledState[self] = state
	end

}, corePrototype_MT)
local handlerPrototype_MT = { __index = handlerPrototype, __tostring = function(t) return objectName[t] end }



-------------------------------------------------------------
-- Modules & Widgets
-------------------------------------------------------------
-- *not considered part of the engine
-------------------------------------------------------------

-- module widget prototype
local widgetPrototype = setmetatable({
	Init = Init,
}, corePrototype_MT)
local widgetPrototype_MT = { __index = widgetPrototype, __tostring = function(t) return objectName[t] end }

-- module prototype
local modulePrototype = setmetatable({
	Init = Init,
	GetWidget = function(self, name, ...)
		self:Check(name, 1, "string")
		local widgetPool = moduleWidgets[self]
		return widgetPool[name]
	end, 
	SetWidget = function(self, name)
		self:Check(name, 1, "string")

		local widgetPool = moduleWidgets[self]
		if widgetPool[name] then
			return error(L["The widget '%s' is already registered to the '%s' module!"]:format(name, tostring(self)))
		end

		local widget = setmetatable({}, widgetPrototype_MT)
		
		objectName[widget] = name -- store the name
		objectType[widget] = "widget" -- store the object type
		
		widgetPool[name] = widget
		
		return widget
	end
}, corePrototype_MT)
local modulePrototype_MT = { __index = modulePrototype, __tostring = function(t) return objectName[t] end }



-------------------------------------------------------------
-- Custom Frames & UI Widgets
-------------------------------------------------------------
local framePrototype
local frameWidgetPrototype

local blizzardCreateFontString = FrameMethods.CreateFontString
local blizzardCreateTexture = FrameMethods.CreateTexture

frameWidgetPrototype = {

	-- Position a frame, and accept keywords as anchors
	-- to easily hook frames into the secure actionbar controllers.
	-- Place(point) or Place(point, anchor[, relativePoint[, x, y]])
	Place = function(self, point, anchor, ...)
		self:ClearAllPoints()
		if (anchor == nil) then
			self:SetPoint(point)
		else
			self:SetPoint(point, parseAnchor(anchor), ...)
		end
	end
}

framePrototype = {
	-- Create a new orb as a child of the current frame.
	-- *The orb handler inherits from this frame object, 
	--  so all the same methods are available to it too.
	CreateOrb = function(self, ...)
		return Orb:New(self, ...)
	end,

	-- Create a new statusbar as a child of the current frame.
	-- *Same inheritance as the orb objects
	CreateStatusBar = function(self, ...)
		return StatusBar:New(self, ...)
	end,

	-- Create a new frame as a child of the current frame.
	-- *Same inheritance as the orb objects
	CreateFrame = function(self, frameType, frameName, template) 
		return embed(CreateFrame(frameType or "Frame", frameName, self, template), framePrototype)
	end,

	CreateFontString = function(self, ...)
		return embed(blizzardCreateFontString(self, ...), frameWidgetPrototype)
	end,

	CreateTexture = function(self, ...)
		return embed(blizzardCreateTexture(self, ...), frameWidgetPrototype)
	end

}

-- Embed custom frame widget methods in the main frame prototype too 
embed(framePrototype, frameWidgetPrototype)



-------------------------------------------------------------
-------------------------------------------------------------
-- Engine
-------------------------------------------------------------
-------------------------------------------------------------


-------------------------------------------------------------
-- Keyword handling
-------------------------------------------------------------

-- register a keyword to trigger a function call when used as an anchor on a frame
Engine.RegisterKeyword = function(self, keyWord, func)
	keyWords[keyWord] = func
end

-- set the default keyword. can only be done once.
Engine.RegisterKeywordDefault = function(self, keyWord, func)
	KEYWORD_DEFAULT = keyWord
	keyWords[KEYWORD_DEFAULT] = func

	-- clear the function after the first use
	self.RegisterKeywordDefault = nil
end


-------------------------------------------------------------
-- Frame creation
-------------------------------------------------------------
-- Returns the UICenter frame, which should be 
-- the parent of everything except the nameframes.
Engine.GetFrame = function(self, anchor)
	return anchor and parseAnchor(anchor) or UICenter
end

-- Create a frame with certain extra methods we like to have
Engine.CreateFrame = function(self, frameType, frameName, parent, template) 
	return embed(CreateFrame(frameType or "Frame", frameName, parseAnchor(parent), template), framePrototype)
end



-------------------------------------------------------------
-- General engine API
-------------------------------------------------------------

Engine.GetConstant = function(self, constant)
	return self:GetDB("Data: Constants", true)[constant]
end

Engine.SetConstant = function(self, constant, value)
	-- Allow other modules to set constants, 
	-- but only if the given constant doesn't exist.
	local constants = self:GetDB("Data: Constants", true)
	if (constants[constant] == nil) then
		constants[constant] = value
	end
end



-------------------------------------------------------------
-- Addon handling
-------------------------------------------------------------

-- Check if an addon exists in the addon listing and loadable on demand
Engine.IsAddOnLoadable = function(self, target)
	local target = string_lower(target)
	for i = 1,GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = self:GetAddOnInfo(i)
		if (string_lower(name) == target) then
			-- If its dependency is disabled, it can't be loaded.
			-- *an exception might be if the dependency is ondemand too. But really...
			if (reason and (reason == "DISABLED" or reason == "DEP_DISABLED")) then 
				return 
			end 
			if loadable then
				return true
			end
		end
	end
end

Engine.GetAddOnInfo = function(self, index)
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(index)
	-- Unlike the blizz API call, we want our "enabled" return to explain
	-- wether or not the addon is actually going to be loaded. 
	if (reason and (reason == "DISABLED" or reason == "DEP_DISABLED")) then 
		enabled = nil
	end 
	return name, title, notes, enabled, loadable, reason, security
end

-- Check if an addon is enabled	in the addon listing
Engine.IsAddOnEnabled = function(self, target)
	local target = string_lower(target)
	for i = 1,GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = self:GetAddOnInfo(i)
		if (string_lower(name) == target) then
			if enabled then
				return true
			end
		end
	end
end	

-------------------------------------------------------------
-- Handlers and Modules
-------------------------------------------------------------

-- define a new handler/library
Engine.NewHandler = function(self, name)
	self:Check(name, 1, "string")
	
	if handlers[name] then
		return error(L["A handler named '%s' is already registered!"]:format(name))
	end
	
	local handler = setmetatable({}, handlerPrototype_MT) 

	handlerElements[handler] = {} -- local elementpool for the handler
	
	objectName[handler] = name -- store the handler name for easier reference
	objectType[handler] = "handler" -- store the object type

	handlers[name] = handler
	
	return handler
end

-- create a new user module
-- *set loadPriority to "LOW" to delay OnEnable until after PLAYER_LOGIN!
Engine.NewModule = function(self, name, loadPriority)
	self:Check(name, 1, "string")
	self:Check(loadPriority, 2, "string", "nil")

	if handlers[name] then
		return error(L["Bad argument #%d to '%s': The name '%s' is reserved for a handler!"]:format(1, "New", name))
	end
	if modules[name] then
		return error(L["Bad argument #%d to '%s': A module named '%s' already exists!"]:format(1, "New", name))
	end
	if loadPriority and not PRIORITY_HASH[loadPriority] then
		return error(L["Bad argument #%d to '%s': The load priority '%s' is invalid! Valid priorities are: %s"]:format(2, "New", loadPriority, table_concat(PRIORITY_INDEX, ", ")))
	end
	if not loadPriority then
		loadPriority = DEFAULT_MODULE_PRIORITY
	end
	
	local module = setmetatable({}, modulePrototype_MT)

	moduleWidgets[module] = {} -- local widgetpool for the module

	objectName[module] = name -- store the module name for easier reference
	objectType[module] = "module" -- store the object type

	moduleLoadPriority[loadPriority][name] = module -- store the module load priority

	modules[name] = module -- insert the new module into the registry
	
	return module
end

-- Hands an error to the client's error handler (BugSack and the like) where
-- it happened, so the stack shown is the faulty module's.
local reportError = function(err)
	return geterrorhandler()(err)
end

local failedModules = {} -- [module] = true once one of its ForAll calls errored

-- Calls the method `method` of every module of load priority `priority` that
-- has it. A module that errors is reported and left out from then on (no
-- OnEnable on a half-built module); the others still run.
Engine.ForAll = function(self, method, priority, ...)
	self:Check(method, 1, "string")
	self:Check(priority, 2, "string")
	if (not PRIORITY_HASH[priority]) then
		return error(L["Bad argument #%d to '%s': The load priority '%s' is invalid! Valid priorities are: %s"]:format(2, "ForAll", priority, table_concat(PRIORITY_INDEX, ", ")))
	end
	local numArgs, args = select("#", ...), { ... }
	for name, module in pairs(moduleLoadPriority[priority]) do
		if module[method] and (not failedModules[module]) then
			-- Lua 5.1's xpcall passes no arguments, hence the closure
			if (not xpcall(function() return module[method](module, unpack(args, 1, numArgs)) end, reportError)) then
				failedModules[module] = true
			end
		end
	end
end

-------------------------------------------------------------
-- Resolution and scale handling
-------------------------------------------------------------
-- The UI Scale (ScreenScaling.scale) multiplies this base size.
local BASE_UI_SCALE = 1.1

local SetDisplaySize
do

	local data = {}

	-- Return a value rounded to the nearest integer.
	local round = function(value)
		return (value + .5) - (value + .5)%1
	end

	SetDisplaySize = function(scale)
		if (not scale) then 
			if Engine and Engine.GetConfig then 
				local db = Engine:GetConfig("ScreenScaling", nil, nil, true)
				if db then 
					scale = db.scale
				end
			end 
		end

		--Retrieve UIParent size
		local width, height = UIParent:GetSize()
		width = round(width)
		height = round(height)
	
		-- 100% of the UI Scale is what 110% used to be
		local scale = height/1080 * BASE_UI_SCALE * (tonumber(scale) or 1)
	
		local displayWidth = (((width/height) >= (16/10)*3) and width/3 or width)/scale
		local displayHeight = height/scale
	
		UICenter:SetFrameStrata(UIParent:GetFrameStrata())
		UICenter:SetFrameLevel(UIParent:GetFrameLevel())
		UICenter:ClearAllPoints()
		UICenter:SetPoint("BOTTOM", UIParent, "BOTTOM")
		UICenter:SetScale(scale)
		UICenter:SetSize(round(displayWidth), round(displayHeight))
	end 
	SetDisplaySize()

	Engine.GetFrameSize = function(self, frame)
		local width, height = frame:GetSize()
		return math_floor(width + .5), math_floor(height + .5)
	end 

	Engine.UpdateWorldScales = function(self)

		local oldWidth, oldHeight = data.worldWidth, data.worldHeight
		local newWidth, newHeight = self:GetFrameSize(WorldFrame)

		local oldScale
		if (oldWidth and oldHeight) then
			oldScale = math_floor((oldWidth/oldHeight)*100)*100
		end 
		local newScale = math_floor((newWidth/newHeight)*100)*100

		data.worldWidth = newWidth
		data.worldHeight = newHeight
		data.worldScale = newScale

		return newScale ~= oldScale 
	end 

	Engine.UpdateInterfaceScales = function(self)

		local oldWidth, oldHeight = data.interfaceWidth, data.interfaceHeight
		local newWidth, newHeight = self:GetFrameSize(UIParent)

		local oldScale
		if (oldWidth and oldHeight) then
			oldScale = math_floor((oldWidth/oldHeight)*100)*100
		end 
		local newScale = math_floor((newWidth/newHeight)*100)*100

		data.interfaceWidth = newWidth
		data.interfaceHeight = newHeight
		data.interfaceScale = newScale

		return (newScale ~= oldScale) or (newWidth ~= oldWidth) or (newHeight ~= oldHeight)
	end 

	-- (UICenter is secure: it's resized out of combat only)
	Engine.OnDisplaySizeEvent = function(self, event, ...)
		if (InCombatLockdown()) then
			return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnDisplaySizeEvent")
		elseif (event == "PLAYER_REGEN_ENABLED") then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnDisplaySizeEvent")
		end
		SetDisplaySize()
	end

	Engine.OnDisplayScaleEvent = function(self, event, ...)
		if self:UpdateWorldScales() then 
			self:OnDisplaySizeEvent()
		end 
		if self:UpdateInterfaceScales() then 
			self:OnDisplaySizeEvent()
		end 
	end


end

Engine.ReloadUI = function(self)
	local PopUpMessage = self:GetHandler("PopUpMessage")
	if not PopUpMessage:GetPopUp("ENGINE_GENERAL_RELOADUI") then
		PopUpMessage:RegisterPopUp("ENGINE_GENERAL_RELOADUI", {
			title = L["Reload Needed"],
			text = L["The user interface has to be reloaded for the changes to be applied.|n|nDo you wish to do this now?"],
			button1 = L["Accept"],
			button2 = L["Cancel"],
			OnAccept = function() ReloadUI() end,
			OnCancel = function() end,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			hideOnEscape = false
		})
	end
	PopUpMessage:ShowPopUp("ENGINE_GENERAL_RELOADUI", self:GetDB("UI").popup) 
end



-------------------------------------------------------------
-- Engine startup and initialization
-------------------------------------------------------------
local queueWorldEnterEvent
do
	local engineIsLoaded, engineVariablesAreLoaded
	Engine.PreInit = function(self, event, ...)
		if (event == "ADDON_LOADED") then
			local arg1 = ...
			if arg1 == ADDON then
				engineIsLoaded = true
				self:UnregisterEvent("ADDON_LOADED", "PreInit")
			end
		elseif (event == "VARIABLES_LOADED") then
			engineVariablesAreLoaded = true
			self:UnregisterEvent("VARIABLES_LOADED", "PreInit")
		end
		if (engineVariablesAreLoaded and engineIsLoaded) then
			if (not IsLoggedIn()) then
				self:RegisterEvent("PLAYER_LOGIN", "Enable")
			else 
				-- On the first startup when no WTF settings is 
				-- saved for the current character in WotLK, 
				-- the VARIABLES_LOADED event will fire after 
				-- the PLAYER_ENTERING_WORLD world event, 
				-- so we have to queue a fake one for the 
				-- modules to be properly initialized. 
				queueWorldEnterEvent = true
			end
			return self:Init(event, ADDON)
		end
	end
end

-- called by PreInit once the addon and its saved variables are loaded
Engine.Init = function(self, event, ...)
	-- chat filters and emoticons
	Engine:NewConfig("ScreenScaling", {
		scale = 1
	})

	-- update stored settings (needs to happen before init)
	self:ParseSavedVariables()

	-- 100% used to be smaller (110% was the size to play with): a scale
	-- chosen before keeps its size on screen, in the new percentages
	local scaling = self:GetConfig("ScreenScaling")
	if (not scaling.rebased) then
		if (scaling.scale ~= 1) then
			scaling.scale = math.floor(scaling.scale / BASE_UI_SCALE * 100 + .5) / 100
		end
		scaling.rebased = true
	end

	SetDisplaySize(self:GetConfig("ScreenScaling").scale)

	-- Initialize all handlers here.
	-- They will not be optional.
	for name, handler in pairs(handlers) do
		handler:Enable()
	end

	-- Cache up shortcuts to some select handlers
	-- we want modules to gain access to directly.
	Orb 		= self:GetHandler("Orb")
	StatusBar 	= self:GetHandler("StatusBar")

	-- New system only needs to capture changes and events
	-- affecting display size or the cinematic frame visibility.
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnDisplaySizeEvent")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnDisplayScaleEvent") 
	self:RegisterEvent("DISPLAY_SIZE_CHANGED", "OnDisplayScaleEvent") -- window/resolution changes
	self:RegisterEvent("UI_SCALE_CHANGED", "OnDisplayScaleEvent") -- scale slider changes

	UIParent:HookScript("OnSizeChanged", function() self:OnDisplayScaleEvent() end)
	WorldFrame:HookScript("OnSizeChanged", function() self:OnDisplayScaleEvent() end)

	-- Add a command to reset setups to their default state.
	local ChatCommand = self:GetHandler("ChatCommand")
	ChatCommand:Register("resetsetup", function()
		-- chat window autoposition
		local db = self:GetConfig("ChatWindows")
		db.hasbeenqueried = false
		db.autoposition = true
		self:GetModule("ChatWindows"):PositionChatFrames()
	end)

	-- /diabolic setscale <number>: saved, and applied out of combat only
	-- (UICenter is secure)
	ChatCommand:Register("setscale", function(scale)
		scale = tonumber(scale)
		if (not scale) then
			return
		end
		self:GetConfig("ScreenScaling").scale = scale
		self:OnDisplaySizeEvent()
		-- what's scaled along with it (modules/menu/menu.lua)
		self:Fire("ENGINE_UI_SCALE_CHANGED")
	end)

	-- initialize all modules
	for i = 1, #PRIORITY_INDEX do
		self:ForAll("Init", PRIORITY_INDEX[i], event, ...)
	end
	
	-- enable all objects of NORMAL and HIGH priority
	for i = 1, 2 do
		self:ForAll("Enable", PRIORITY_INDEX[i], event, ...)
	end

	-- this could happen on WotLK clients
	if (IsLoggedIn() and (not self:IsEnabled())) then
		self:Enable()
	end
end

-- called after the player has logged in (always after Init)
Engine.Enable = function(self, event, ...)
	-- enable all objects of LOW priority
	for i = 3, #PRIORITY_INDEX do
		self:ForAll("Enable", PRIORITY_INDEX[i], event, ...)
	end

	-- This happens sometimes on the very first login 
	-- on chars without saved settings in WTF in WotLK.
	-- As both handlers and modules rely on this event,
	-- we need to fire it once manually to make 
	-- sure everything starts as intended.
	if queueWorldEnterEvent then
		self:Fire("PLAYER_ENTERING_WORLD")
	end

	enabledObjects[self] = true
end

-- check if the engine is fully enabled
Engine.IsEnabled = function(self)
	return enabledObjects[self]
end



-- add general API calls to the Engine
-- *TODO: make a better system for inheritance here
Engine.Check = check 
Engine.Wrap = wrap
Engine.Fire = Fire
Engine.RegisterEvent = RegisterEvent
Engine.RegisterMessage = RegisterMessage
Engine.IsEventRegistered = IsEventRegistered
Engine.IsMessageRegistered = IsMessageRegistered
Engine.UnregisterEvent = UnregisterEvent
Engine.UnregisterMessage = UnregisterMessage
Engine.GetHandler = GetHandler
Engine.GetModule = GetModule
Engine.NewConfig = NewConfig
Engine.GetConfig = GetConfig
Engine.NewStaticConfig = NewStaticConfig
Engine.GetDB = GetDB

-- For /dui cpu (engine/profiler.lua): every object's name, and who's
-- registered for which event. Read only.
Engine.GetRegistries = function(self)
	return objectName, events
end



-- Finalize the Engine and write protect it,
-- because we don't want other addons to be able 
-- to insert methods into the core.
-- Not that there's actually any global access to it, though. 
local protected_MT = {
	__newindex = function(self)
		return error(L["The Engine can't be tampered with!"])
	end,
	__metatable = false
}
setmetatable(Engine, protected_MT)


-- Set the UICenter frame as the default keyword
Engine:RegisterKeywordDefault("UICenter", function() return UICenter end)

-- Add the UIConfig frame too, so all modules can hook to it
Engine:RegisterKeyword("UIConfig", function() return UIConfig end)

-- Register combat tracking events for our safecall wrapper.
Engine:RegisterEvent("PLAYER_REGEN_DISABLED", combatStarts)
Engine:RegisterEvent("PLAYER_REGEN_ENABLED", combatEnds)

-- Register basic startup events with our event handler.
-- In WotLK the VARIABLES_LOADED event fires when saved variables for
-- addons are fully loaded, meaning we should hold back all init procedures
-- relying on the saved settings until after this event has fired.
--
-- The order was often random, so the only secure way was to register both
-- events, and start the init procedures once both had fired for our addon.
--
-- This is also why we're holding back the PLAYER_LOGIN enable event here,
-- because we don't want to risk it firing before the variables are loaded.
-- So the PLAYER_LOGIN event is registered during initialization instead,
-- or its method fired directly if the player already has logged into the game.
Engine:RegisterEvent("ADDON_LOADED", "PreInit")
Engine:RegisterEvent("VARIABLES_LOADED", "PreInit")

-- apply scripts to our event frame
Frame:SetScript("OnEvent", OnEvent)
