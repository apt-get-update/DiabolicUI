local ADDON, Engine = ...
local L = Engine:GetLocale()

-- Uncomment when the saved settings bug out,
-- or just to reset the saved settings.
--local DEVELOPER_RESET = true

-------------------------------------------------------------
-- Lua API
-------------------------------------------------------------
local _G = _G
local assert = assert
local debugstack = debugstack
local error = error
local getmetatable = getmetatable
local ipairs = ipairs
local math_abs = math.abs
local math_floor = math.floor
local pairs = pairs
local pcall = pcall
local print = print
local select = select
local setmetatable = setmetatable
local string_join = string.join
local string_lower = string.lower
local string_match = string.match
local table_concat = table.concat
local tonumber = tonumber
local tostring = tostring
local type = type


-------------------------------------------------------------
-- WOW API
-------------------------------------------------------------
local CreateFrame = _G.CreateFrame
local GetAddOnEnableState = _G.GetAddOnEnableState
local GetAddOnInfo = _G.GetAddOnInfo
local GetBuildInfo = _G.GetBuildInfo
local GetCurrentResolution = _G.GetCurrentResolution
local GetCVar = _G.GetCVar
local GetCVarBool = _G.GetCVarBool
local GetLocale = _G.GetLocale
local GetNumAddOns = _G.GetNumAddOns
local GetRealmName = _G.GetRealmName
local GetResolution = _G.GetResolution
local GetScreenHeight = _G.GetScreenHeight
local GetScreenWidth = _G.GetScreenWidth
local GetScreenResolutions = _G.GetScreenResolutions
local EnableAddOn = _G.EnableAddOn
local InCombatLockdown = _G.InCombatLockdown
local InCinematic = _G.InCinematic
local IsLoggedIn = _G.IsLoggedIn
local IsMacClient = _G.IsMacClient
local LoadAddOn = _G.LoadAddOn
local RegisterStateDriver = _G.RegisterStateDriver
local StaticPopup_Show = _G.StaticPopup_Show
local StaticPopupDialogs = _G.StaticPopupDialogs
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
local timers = {} -- timer registry

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

local stack = {} -- local table stack for indexed tables
local queue = {} -- queued function calls for the secure out of combat wrapper
local scale = {} -- screen resolution and UI scale data (not used?)

local keyWords = {} -- keyword registry to translate words to frame handles used for anchoring or parenting

local incompats = {} -- table holding module/widget/handler incompatibilities
local dependencies = {} -- table holding module/widget/handler dependencies

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

-- Frame meant for events, timers, etc
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

-- Error handling to keep the Engine running.
local protected_call = function(...)
	local _, catch = pcall(...)
	if catch and GetCVarBool("scriptErrors") then
		ScriptErrorsFrame_OnError(catch, false)
	end
end

-- Wipe a table and push it to the stack.
local push = function(tbl)
	if #tbl > 0 then
		for i = #tbl, 1, -1 do
			tbl[i] = nil
		end
	end
	stack[#stack + 1] = tbl
end

-- Pull a table from the stack, or create a new one.
local pop = function()
	if #stack > 0 then
		local tbl = stack[#stack]
		stack[#stack] = nil
		return tbl
	end
	return {}
end

-- Not using camel case for the names of these two, 
-- since we're sort of pretending they're regular lua math calls.
local math_round = function(n, accuracy) 
	return (math_floor(n*accuracy + .5))/accuracy -- adding the .5 to fix numbers blizzard have rounded down (?)
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

-- Using this as sort of a "catch all" copy function
local fullCopy
fullCopy = function(source)
	do return source end

	-- Tables need to be deep copied, or the referenced table can disappear, causing mayhem.
	if (type(source) == "table") then
		-- If it's a WoW UI object, we just return it as is. 
		if source.GetObjectType then
			return source
		-- If it's a normal table, we do a full deep copy of it.
		else
			return copyTable(source)
		end 
	end

	-- Non table values are copied by default, simply returning the value is enough.
	return source
end



-------------------------------------------------------------
-- Event & OnUpdate Handler
-------------------------------------------------------------

-- script handler for Frame's OnEvent
local OnEvent = function(self, event, ...)
	local eventRegistry = events[event]
	if not eventRegistry then
		return 
	end
	
	-- iterate engine events first
	local engine = Engine
	local engineEvents = eventRegistry[engine]
	if engineEvents then
		for index,func in ipairs(engineEvents) do
			if type(func) == "string" then
				if engine[func] then
					engine[func](engine, event, ...)
				else
					return error(L["The Engine has no method named '%s'!"]:format(func))
				end
			else
				func(engine, event, ...)
			end
		end
	end
	
	-- iterate handlers
	for name,handler in pairs(handlers) do
		if enabledObjects[handler] then
			local handler_events = eventRegistry[handler]
			if handler_events then
				for index,func in ipairs(handler_events) do
					if type(func) == "string" then
						if handler[func] then
							handler[func](handler, event, ...)
						else
							return error(L["The handler '%s' has no method named '%s'!"]:format(tostring(handler), func))
						end
					else
						func(handler, event, ...)
					end
				end
			end
			
			-- iterate the elements registered to the current handler
			local elementPool = handlerElements[handler]
			for name,element in pairs(elementPool) do
				local element_events = eventRegistry[element]
				if element_events then
					for index,func in ipairs(element_events) do
						if type(func) == "string" then
							if element[func] then
								element[func](element, event, ...)
							else
								return error(L["The handler element '%s' has no method named '%s'!"]:format(tostring(element), func))
							end
						else
							func(element, event, ...)
						end
					end
				end
			end
			
		end
	end

	-- iterate module events and fire according to priorities
	for index,priority in ipairs(PRIORITY_INDEX) do
		for name,module in pairs(moduleLoadPriority[priority]) do
			if enabledObjects[module] then
				local moduleEvents = eventRegistry[module]
				if moduleEvents then
					for index,func in ipairs(moduleEvents) do
						if type(func) == "string" then
							if module[func] then
								module[func](module, event, ...)
							else
								return error(L["The module '%s' has no method named '%s'!"]:format(tostring(module), func))
							end
						else
							func(module, event, ...)
						end
					end
				end

				-- iterate the widgets registered to the current module
				local widgetPool = moduleWidgets[module]
				for name,widget in pairs(widgetPool) do
					local widgetEvents = eventRegistry[widget]
					if widgetEvents then
						for index,func in ipairs(widgetEvents) do
							if type(func) == "string" then
								if widget[func] then
									widget[func](widget, event, ...)
								else
									return error(L["The module widget '%s' has no method named '%s'!"]:format(tostring(widget), func))
								end
							else
								func(widget, event, ...)
							end
						end
					end
				end
			end
		end
	end

end

-- script handler for Frame's OnUpdate
local OnUpdate = function(self, elapsed, ...)
end

-- engine and object methods
local Fire = function(self, message, ...)
	self:Check(message, 1, "string")
	local eventRegistry = events[message]
	if not eventRegistry then
		return 
	end

	-- iterate engine messages first
	local engine = Engine
	local engineEvents = eventRegistry[engine]
	if engineEvents then
		for index,func in ipairs(engineEvents) do
			if type(func) == "string" then
				if engine[func] then
					engine[func](engine, message, ...)
				else
					return error(L["The Engine has no method named '%s'!"]:format(func))
				end
			else
				func(engine, message, ...)
			end
		end
	end
	
	-- iterate handlers
	for name,handler in pairs(handlers) do
		if enabledObjects[handler] then
			local handler_events = eventRegistry[handler]
			if handler_events then
				for index,func in ipairs(handler_events) do
					if type(func) == "string" then
						if handler[func] then
							handler[func](handler, message, ...)
						else
							return error(L["The handler '%s' has no method named '%s'!"]:format(tostring(handler), func))
						end
					else
						func(handler, message, ...)
					end
				end
			end
		end
	end
	
	-- iterate module messages and fire according to priorities
	for index,priority in ipairs(PRIORITY_INDEX) do
		for name,module in pairs(moduleLoadPriority[priority]) do
			if enabledObjects[module] then
				local moduleEvents = eventRegistry[module]
				if moduleEvents then
					for index,func in ipairs(moduleEvents) do
						if type(func) == "string" then
							if module[func] then
								module[func](module, message, ...)
							else
								return error(L["The module '%s' has no method named '%s'!"]:format(tostring(module), func))
							end
						else
							func(module, message, ...)
						end
					end
				end

				-- iterate the widgets registered to the current module
				local widgetPool = moduleWidgets[module]
				for name,widget in pairs(widgetPool) do
					local widgetEvents = eventRegistry[widget]
					if widgetEvents then
						for index,func in ipairs(widgetEvents) do
							if type(func) == "string" then
								if widget[func] then
									widget[func](widget, message, ...)
								else
									return error(L["The module widget '%s' has no method named '%s'!"]:format(tostring(widget), func))
								end
							else
								func(widget, message, ...)
							end
						end
					end
				end

			end
		end
	end
end

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
			events[event][self][i] = nil
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
			events[message][self][i] = nil
			return 
		end
	end
	if type(func) == "string" then
		if func == "Update" then
			return error(L["Attempting to unregister the general occurence of the message '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterMessage?"]:format(event, tostring(self)))
		else
			return error(L["The method named '%s' isn't registered for the message '%s' in the object '%s'."]:format(func, message, tostring(self)))
		end
	else
		return error(L["The function call assigned to the message '%s' in the object '%s' doesn't exist."]:format(message, tostring(self)))
	end
	
end



-------------------------------------------------------------
-- Timers
-- *Not implemented yet. So don't use them!
-------------------------------------------------------------

-- create a new timer object
local new_timer = function(owner, method, delay, loop, ...)

end

local ScheduleTimer = function(self, method, delay, ...)
	self:Check(method, 1, "string", "function")
	self:Check(delay, 2, "number")

	if not timers[self] then
		timers[self] = {}
	end
	
	local timer = new_timer(owner, method, delay, false, ...)

	timers[self][timer] = method

	return timer
end

local ScheduleRepeatingTimer = function(self, method, callback, ...)
	self:Check(method, 1, "string", "function")
	self:Check(delay, 2, "number")

	if not timers[self] then
		timers[self] = {}
	end
	
	local timer = new_timer(owner, method, delay, true, ...)

	timers[self][timer] = method

	return timer
end

local CancelTimer = function(self, id)
	if not timers[self] then
		return 
	end
end

local CancelAllTimers = function(self)
	if not timers[self] then
		return 
	end
end



-------------------------------------------------------------
-- Config
-------------------------------------------------------------

Engine.ParseSavedVariables = function(self)
	-- Fix format changes during development. 
	if DEVELOPER_RESET then
		wipe(DiabolicUI_DB) 
	end

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

local GetConfigDefaults = function(self, name)
	self:Check(name, 1, "string")
	if (not configs[name]) then
		return error(L["The config '%s' doesn't exist!"]:format(name))
	end	
	return configs[name].defaults
end

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

local safeCall = function(func, ...)

	-- perform the function right away when not in combat
	if (not INCOMBAT) then
		if queue[func] then -- check if the function has been previously queued during combat
			push(queue[func]) -- push the table to the stack
			queue[func] = nil -- remove the element's reference from the queue
		end
		func(...) 
		return
	end

	-- combat has ended but the event hasn't fired yet
	if (not INLOCKDOWN) then
		INLOCKDOWN = InCombatLockdown() -- still in PLAYER_REGEN_DISABLED?
		if (not INLOCKDOWN) then
			if queue[func] then -- check if the function has been previously queued during combat
				push(queue[func]) -- push the table to the stack
				queue[func] = nil -- remove the element's reference from the queue
			end
			func(...)
			return
		end
	end
	
	-- we're still in combat, we need to queue the function call.
	-- if it has been previously queued, we simply update the arguments
	if queue[func] then
		local tbl, oldArgs = queue[func], #queue[func]
		local numArgs = select("#", ...)
		for i = 1, numArgs do
			tbl[i] = fullCopy(select(i, ...)) -- give each argument its own entry
		end
		if (oldArgs > numArgs) then
			for i = oldArgs + 1, numArgs do
				tbl[i] = nil -- kill of excess args from the previous queue, if any
			end
		end
	else
		local tbl = pop() -- request a fresh table from the stack
		local numArgs = select("#", ...)
		for i = 1, numArgs do
			tbl[i] = fullCopy(select(i, ...)) -- give each argument its own entry
		end
		-- To avoid multiple calls of the same function, 
		-- we use the actual function as the key.
		--
		-- 	Note: 	This isn't guaranteed to work, though, since a function 
		-- 			can easily be copied when passed, and thus we can still get 
		-- 			multiple calls to the same function. 
		-- 			So I should rewrite the whole freaking system to use 
		--			some kind of unique IDs. Major TODO. -_-
		queue[func] = tbl 
	end
end

local combatStarts = function(self, event, ...)
	INCOMBAT = true -- combat starts
end

local combatEnds = function(self, event, ...)
	INCOMBAT = false
	INLOCKDOWN = false
	for func,args in pairs(queue) do
		if func then
			local args = args
			func(unpack(args)) 
			if queue[func] then -- the previous function may have deleted itself
				push(queue[func]) -- push the table to the stack
				queue[func] = nil -- remove the element from the queue
			elseif args then -- the table might still be there, even if the reference is gone
				push(args) -- push the table to the stack
			end
		end
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

local Init = function(self, ...)
	if (self:IsIncompatible() or self:DependencyFailed()) then
		return
	end
	if (not initializedObjects[self]) then 
		initializedObjects[self] = true
		if self.OnInit then
			return self:OnInit(...)
		end
	end
end

local Enable = function(self, ...)
	if (self:IsIncompatible() or self:DependencyFailed()) then
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

local DependencyFailed = function(self)
	if (not dependencies[self]) then
		return false
	end
	local dependencyFailed = false
	for addonName, condition in pairs(dependencies[self]) do
		if (type(condition) == "function") then
			if Engine:IsAddOnEnabled(addonName) then
				if (not condition(self)) then
					dependencyFailed = true
				end
			end
		else
			if (not Engine:IsAddOnEnabled(addonName)) then
				dependencyFailed = true
			end
		end
	end
	return dependencyFailed
end

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

local SetDependency = function(self, ...)
	if (not dependencies[self]) then
		dependencies[self] = {}
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
		dependencies[self][addonName] = condition and condition or true
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
	SetDependency = SetDependency,
	DependencyFailed = DependencyFailed,
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

-- handler element prototypes
local elementPrototype = setmetatable({}, corePrototype_MT)
local elementUnsecurePrototype = setmetatable({
	Enable = Enable,
	Disable = Disable
}, { __index = elementPrototype })
local elementPrototype_MT = { __index = elementPrototype, __tostring = function(t) return objectName[t] end }
local elementUnsecurePrototype_MT = { __index = elementUnsecurePrototype }

-- handler prototype
local handlerPrototype = setmetatable({
	GetElement = function(self, name, ...)
		self:Check(name, 1, "string")
		local elementPool = handlerElements[self]
		return elementPool[name]
	end, 
	
	-- Handler elements are by default blocked from usage in combat. 
	-- To avoid this behavior the 'makeUnsecure' flag must be set to 
	-- 'true' during element creation!
	SetElement = function(self, name, template, makeUnsecure)
		self:Check(name, 1, "string")
		self:Check(template, 2, "table", "nil", "boolean")
		self:Check(makeUnsecure, 3, "boolean", "nil")
		
		if makeUnsecure == nil and type(template) == "boolean" then
			makeUnsecure = template
			template = nil
		end
		
		local elementPool = handlerElements[self]
		if elementPool[name] then
			return error(L["The element '%s' is already registered to the '%s' handler!"]:format(name, tostring(self)))
		end

		local element = setmetatable(template or {}, makeUnsecure and elementUnsecurePrototype_MT or elementPrototype_MT)

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
	end,

	IterateElements = function(self)
		return pairs(handlerElements[self])
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
local widgetUnsecurePrototype = setmetatable({
	Enable = Enable,
	Disable = Disable
}, { __index = widgetPrototype })
local widgetPrototype_MT = { __index = widgetPrototype, __tostring = function(t) return objectName[t] end }
local widgetUnsecurePrototype_MT = { __index = widgetUnsecurePrototype, __tostring = function(t) return objectName[t] end }

-- module prototype
local modulePrototype = setmetatable({
	Init = Init,
	GetWidget = function(self, name, ...)
		self:Check(name, 1, "string")
		local widgetPool = moduleWidgets[self]
		return widgetPool[name]
	end, 
	SetWidget = function(self, name, makeUnsecure)
		self:Check(name, 1, "string")
		self:Check(makeUnsecure, 2, "boolean", "nil")
		
		local widgetPool = moduleWidgets[self]
		if widgetPool[name] then
			return error(L["The widget '%s' is already registered to the '%s' module!"]:format(name, tostring(self)))
		end

		local widget = setmetatable({}, makeUnsecure and widgetUnsecurePrototype_MT or widgetPrototype_MT)
		
		objectName[widget] = name -- store the name
		objectType[widget] = "widget" -- store the object type
		
		widgetPool[name] = widget
		
		return widget
	end
}, corePrototype_MT)
local moduleUnsecurePrototype = setmetatable({
	Enable = Enable,
	Disable = Disable
}, { __index = modulePrototype })
local modulePrototype_MT = { __index = modulePrototype, __tostring = function(t) return objectName[t] end }
local moduleUnsecurePrototype_MT = { __index = moduleUnsecurePrototype, __tostring = function(t) return objectName[t] end }



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
	Place = function(self, ...)
		local numArgs = select("#", ...)
		if numArgs == 1 then
			local point = ...
			self:ClearAllPoints()
			self:SetPoint(point)
		elseif numArgs == 2 then
			local point, anchor = ...
			self:ClearAllPoints()
			self:SetPoint(point, parseAnchor(anchor))
		elseif numArgs == 3 then
			local point, anchor, rpoint = ...
			self:ClearAllPoints()
			self:SetPoint(point, parseAnchor(anchor), rpoint)
		elseif numArgs == 5 then
			local point, anchor, rpoint, xoffset, yoffset = ...
			self:ClearAllPoints()
			self:SetPoint(point, parseAnchor(anchor), rpoint, xoffset, yoffset)
		else
			self:ClearAllPoints()
			self:SetPoint(...)
		end
	end,

	-- Set a single point on a frame without clearing first. 
	-- Like the above function, this too accepts keywords as anchors.
	Point = function(self, ...)
		local numArgs = select("#", ...)
		if numArgs == 1 then
			local point = ...
			self:SetPoint(point)
		elseif numArgs == 2 then
			local point, anchor = ...
			self:SetPoint(point, parseAnchor(anchor))
		elseif numArgs == 3 then
			local point, anchor, rpoint = ...
			self:SetPoint(point, parseAnchor(anchor), rpoint)
		elseif numArgs == 5 then
			local point, anchor, rpoint, xoffset, yoffset = ...
			self:SetPoint(point, parseAnchor(anchor), rpoint, xoffset, yoffset)
		else
			self:SetPoint(...)
		end
	end,

	-- Size a frame, and accept single input values for square frames.
	Size = function(self, ...)
		local numArgs = select("#", ...)
		if numArgs == 1 then
			local size = ...
			self:SetSize(size, size)
		elseif numArgs == 2 then
			self:SetSize(...)
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
-- Track loading screens
-------------------------------------------------------------
do
	local offWorldStatus
	Engine.UpdateOffWorld = function(self, event, ...)
		if event == "PLAYER_LEAVING_WORLD" then
			offWorldStatus = true
		elseif event == "PLAYER_ENTERING_WORLD" then
			offWorldStatus = false
		end
	end

	-- Returns true if the player is in the world.
	-- This is defined by whether the player has entered the world after the last login or reload, 
	-- and will return false if the game client is still starting up or the player is on a loading screen. 
	Engine.IsInWorld = function(self)
		return offWorldStatus == false
	end

	-- Returns true if the player is currently on a loading screen,
	-- but will return false both when the player is in the world or not yet have fully logged in.
	-- The purpose if this function is to specifically check for loading screens while in-game.
	Engine.IsOffWorld = function(self)
		return offWorldStatus == true
	end
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
Engine.NewModule = function(self, name, loadPriority, makeUnsecure)
	self:Check(name, 1, "string")
	self:Check(loadPriority, 2, "string", "nil")
	self:Check(makeUnsecure, 3, "boolean", "nil")
	
	if handlers[name] then
		return error(L["Bad argument #%d to '%s': The name '%s' is reserved for a handler!"]:format(1, "New", name))
	end
	if modules[name] then
		return error(L["Bad argument #%d to '%s': A module named '%s' already exists!"]:format(1, "New", name))
	end
	if loadPriority and not PRIORITY_HASH[loadPriority] then
		return error(L["Bad argument #%d to '%s': The load priority '%s' is invalid! Valid priorities are: %s"]:format(5, "New", loadPriority, table_concat(PRIORITY_INDEX, ", ")))
	end
	if not loadPriority then
		loadPriority = DEFAULT_MODULE_PRIORITY
	end
	
	local module = setmetatable({}, makeUnsecure and moduleUnsecurePrototype_MT or modulePrototype_MT) 

	moduleWidgets[module] = {} -- local widgetpool for the module

	objectName[module] = name -- store the module name for easier reference
	objectType[module] = "module" -- store the object type

	moduleLoadPriority[loadPriority][name] = module -- store the module load priority

	modules[name] = module -- insert the new module into the registry
	
	return module
end

-- perform a function or method on all registered modules
Engine.ForAll = function(self, func, priorityFilter, ...) 
	self:Check(func, 1, "string", "function")
	self:Check(priorityFilter, 2, "string", "nil")

	-- if a valid priority filter is set, only modules of that given priority will be called
	if priorityFilter then
		if (not PRIORITY_HASH[priorityFilter]) then
			return error(L["Bad argument #%d to '%s': The load priority '%s' is invalid! Valid priorities are: %s"]:format(2, "ForAll", priorityFilter, table_concat(PRIORITY_INDEX, ", ")))
		end
		for name,module in pairs(moduleLoadPriority[priorityFilter]) do
			if type(func) == "string" then
				if module[func] then
					module[func](module, ...)
				end
			else
				func(module, ...)
			end
		end
		return
	end
	
	-- if no priority filter is set, we iterate through all modules, but still by priority
	for index,priority in ipairs(PRIORITY_INDEX) do
		for name,module in pairs(moduleLoadPriority[priority]) do
			if type(func) == "string" then
				if module[func] then
					module[func](module, ...)
				end
			else
				func(module, ...)
			end
		end
	end
end

-------------------------------------------------------------
-- Resolution and scale handling
-------------------------------------------------------------
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
	
		local precision = 1e5
		local scale = height/1080 * (tonumber(scale) or 1)
	
		local displayWidth = (((width/height) >= (16/10)*3) and width/3 or width)/scale
		local displayHeight = height/scale
		local displayRatio = displayWidth/displayHeight
	
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
		if (not newWidth) or (not newHeight) then 
			return 
		end 

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
		if (not newWidth) or (not newHeight) then 
			return 
		end 

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

	Engine.UpdateDisplaySize = function(self)
		if (InCombatLockdown()) then 
			return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent") 
		end 
		SetDisplaySize()
	end

	Engine.OnDisplaySizeEvent = function(self, event, ...)
		if (InCombatLockdown()) then 
			return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnDisplaySizeEvent") 
		elseif (event == "PLAYER_REGEN_ENABLED") then 
			self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnDisplaySizeEvent")
		end 
		self:UpdateDisplaySize()
	end

	Engine.OnDisplayScaleEvent = function(self, event, ...)
		if self:UpdateWorldScales() then 
			self:OnDisplaySizeEvent()
		end 
		if self:UpdateInterfaceScales() then 
			self:OnDisplaySizeEvent()
		end 
	end

	local onlyRunOnce
	Engine.KillBlizzard = wrap(Engine, function(self)
		if onlyRunOnce then
			return
		end
		
		-- Killing the UI scale checkbox and slider will prevent blizzards' UI 
		-- from slightly modifying the stored scale everytime we enter the video options. 
		-- If we don't do this, the user will either get spammed with reload requests, 
		-- or the scale will eventually become slightly wrong, and the graphics slightly fuzzy.
		self:GetHandler("BlizzardUI"):GetElement("Menu_Option"):Remove(true, "VideoOptionsResolutionPanelUseUIScale")
		self:GetHandler("BlizzardUI"):GetElement("Menu_Option"):Remove(true, "VideoOptionsResolutionPanelUIScaleSlider")
		
		onlyRunOnce = true
	end)

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

-- called when the addon is fully loaded
Engine.Init = function(self, event, ...)
	local arg1 = ...
	if (arg1 ~= ADDON) then
		return 
	end

	-- Kill off the event, we don't need it anymore
	if self:IsEventRegistered("ADDON_LOADED", "Init") then
		self:UnregisterEvent("ADDON_LOADED", "Init")
	end

	-- chat filters and emoticons
	Engine:NewConfig("ScreenScaling", {
		scale = 1
	})

	-- update stored settings (needs to happen before init)
	self:ParseSavedVariables()

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

	ChatCommand:Register("setscale", function(scale, ...) 
		local db = self:GetConfig("ScreenScaling")
		db.scale = scale
		SetDisplaySize(scale)
	end)

	-- initialize all modules
	for i = 1, #PRIORITY_INDEX do
		self:ForAll("Init", PRIORITY_INDEX[i], event, ...)
	end
	
	-- enable all objects of NORMAL and HIGH priority
	for i = 1, 2 do
		self:ForAll("Enable", PRIORITY_INDEX[i], event, ...)
	end
	
	initializedObjects[self] = true
	
	-- this could happen on WotLK clients
	if (IsLoggedIn() and (not self:IsEnabled())) then
		self:Enable()
	end
end

-- called after the player has logged in
Engine.Enable = function(self, event, ...)
	if (not self:IsInitialized()) then
		-- Since the :Init() procedure will call this function, 
		-- we need to return to avoid duplicate calls
		return self:Init("Forced", ADDON)
	end

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

-- check if the engine has been initialized
Engine.IsInitialized = function(self)
	return initializedObjects[self]
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
(function(tbl)
	local old_MT = getmetatable(tbl)
	if old_MT then
		local new_meta = {}
		for i,v in pairs(old_MT) do
			new_meta[i] = v
		end
		for i,v in pairs(protected_MT) do
			new_meta[i] = v
		end
		return setmetatable(tbl, new_meta)
	else
		return setmetatable(tbl, protected_MT)
	end
end)(Engine)


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

-- Our offworld tracking allows us to know when we're on a loading screen.
Engine:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateOffWorld")
Engine:RegisterEvent("PLAYER_LEAVING_WORLD", "UpdateOffWorld")

-- apply scripts to our event/update frame
Frame:SetScript("OnEvent", OnEvent)
Frame:SetScript("OnUpdate", OnUpdate)
