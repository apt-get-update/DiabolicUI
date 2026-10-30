-- A fake WoW 3.3.5a client that boots the whole addon and lets a test play
-- the game at it: fire events, move time forward, hover and click frames,
-- enter combat, change the target... then check what the addon did.
--
--   local Client = require("mocks.client")
--   local client = Client.boot({ class = "MAGE" })  -- loads DiabolicUI.toc, logs in
--   client.world.units.target = client.newUnit({ name = "Hogger", isPlayer = false })
--   client:FireEvent("PLAYER_TARGET_CHANGED")
--   client:Tick(0.5)
--   assert(#client.errors == 0)
--
-- What it models (tests/mocks/client_*.lua):
--  - widgets with the 3.3.5 method set and real state (client_widgets.lua);
--    a method a widget type doesn't have is missing, like in game
--  - the game API, answering from `client.world` (client_api.lua)
--  - Blizzard's own frames and FrameXML functions the addon touches
--    (client_blizzard.lua), created when first read
--  - scripts and events: every handler runs protected, and an error is
--    recorded in `client.errors` (with a traceback) instead of stopping
--    the test, the way the client hands it to the error handler
--  - combat lockdown: Show/Hide/SetPoint/SetAttribute... on a protected
--    frame (one built from a secure template) in combat are refused and
--    recorded in `client.blocked`, like ADDON_ACTION_BLOCKED
--  - state drivers and unit watches, evaluated after every event
--
-- A global the addon reads that nothing here defines reads nil, except ALL
-- CAPS names (UI strings), which read as their own name. Both are listed
-- in `client.missing`.

local Widgets = require("mocks.client_widgets")
local Api = require("mocks.client_api")
local Blizzard = require("mocks.client_blizzard")
local Secure = require("mocks.client_secure")
local Loader = require("mocks.addon_loader")

local Client = {}
Client.__index = Client

Client.newUnit = Api.newUnit
Client.newWorld = Api.newWorld
Client.Widgets = Widgets

local state = Widgets.state

-- _G as plain Lua left it, restored before every boot.
local pristine = {}
for key, value in pairs(_G) do
	pristine[key] = value
end
local pristineString = {}
for key, value in pairs(string) do
	pristineString[key] = value
end

local function resetGlobals()
	setmetatable(_G, nil)
	for key in pairs(_G) do
		if pristine[key] == nil then
			_G[key] = nil
		end
	end
	for key, value in pairs(pristine) do
		_G[key] = value
	end
	for key in pairs(string) do
		if pristineString[key] == nil then
			string[key] = nil
		end
	end
	package.loaded["mocks.client"] = Client
	-- the last boot's widgets let go: Lua 5.1's weak keys aren't
	-- ephemerons, so a state holding its widget (its parent, its
	-- children, its scripts) kept every boot's whole UI alive
	for widget in pairs(state) do
		state[widget] = nil
	end
end

------------------------------------------------------------------------
-- Running scripts
------------------------------------------------------------------------

function Client:RecordError(message)
	self.errors[#self.errors + 1] = message
end

-- Calls fn(...) protected. Returns true on success.
function Client:Call(fn, ...)
	local args, n = { ... }, select("#", ...)
	local ok, err = xpcall(function() return fn(unpack(args, 1, n)) end, function(message)
		return debug.traceback(tostring(message), 2)
	end)
	if not ok then
		self:RecordError(err)
	end
	return ok
end

function Client:RunScript(widget, script, ...)
	local s = state[widget]
	if not s then
		return
	end
	local handler = s.scripts[script]
	if handler then
		if s.wrapped and s.wrapped[script] then
			-- a secure header wrapped it (see mocks/client_secure.lua)
			local call = function(...) self:Call(handler, ...) end
			Secure.runWrapped(widget, script, call, widget, ...)
		else
			self:Call(handler, widget, ...)
		end
	end
	local hooks = s.hooks[script]
	if hooks then
		for _, hook in ipairs(hooks) do
			self:Call(hook, widget, ...)
		end
	end
end

function Client:Blocked(widget, method)
	self.blocked[#self.blocked + 1] = (state[widget].name or tostring(widget)) .. ":" .. method .. "()\n" .. debug.traceback("", 3)
end

------------------------------------------------------------------------
-- Driving the game
------------------------------------------------------------------------

-- Fires an event at every frame registered for it, in creation order.
function Client:FireEvent(event, ...)
	local targets = {}
	for widget in pairs(self.eventFrames) do
		local s = state[widget]
		if s.events[event] or s.allEvents then
			targets[#targets + 1] = widget
		end
	end
	table.sort(targets, function(a, b) return state[a].serial < state[b].serial end)
	for _, widget in ipairs(targets) do
		local s = state[widget]
		-- a handler earlier in the list may have unregistered it
		if s.events[event] or s.allEvents then
			self:RunScript(widget, "OnEvent", event, ...)
		end
	end
	self.firedEvents[event] = (self.firedEvents[event] or 0) + 1
	self:UpdateStateDrivers()
end

-- Moves time forward: OnUpdate on every visible frame, animations,
-- state drivers. Big steps are split into frames of at most 0.1s.
function Client:Tick(seconds, frameTime)
	seconds = seconds or 0.1
	frameTime = frameTime or math.min(seconds, 0.1)
	local done = 0
	repeat
		local elapsed = math.min(frameTime, seconds - done)
		if elapsed <= 0 then
			elapsed = frameTime
		end
		done = done + elapsed
		self.world.time = self.world.time + elapsed
		local updaters = {}
		for widget in pairs(self.updaters) do
			local s = state[widget]
			if (s.scripts.OnUpdate or s.hooks.OnUpdate) and s.class.isA.Frame and Widgets.isVisible(widget) then
				updaters[#updaters + 1] = widget
			end
		end
		table.sort(updaters, function(a, b) return state[a].serial < state[b].serial end)
		for _, widget in ipairs(updaters) do
			self:RunScript(widget, "OnUpdate", elapsed)
		end
		local groups = {}
		for group in pairs(self.playing) do
			groups[#groups + 1] = group
		end
		table.sort(groups, function(a, b) return state[a].serial < state[b].serial end)
		for _, group in ipairs(groups) do
			Widgets.advanceAnimation(group, elapsed)
		end
		Secure.updateAutoHide(elapsed)
		self:UpdateStateDrivers()
	until done >= seconds - 1e-9
end

-- The mouse: enters a frame (leaving the previous one).
function Client:Hover(widget, ...)
	if self.mouseFocus and self.mouseFocus ~= widget then
		local old = self.mouseFocus
		self.mouseFocus = nil
		self:RunScript(old, "OnLeave")
	end
	self.mouseFocus = widget
	if widget then
		self:RunScript(widget, "OnEnter", ...)
	end
end

function Client:Leave()
	self:Hover(nil)
end

function Client:Click(widget, button, down)
	button = button or "LeftButton"
	if widget.Click then
		widget:Click(button, down)
	else
		self:RunScript(widget, "OnMouseDown", button)
		self:RunScript(widget, "OnMouseUp", button)
	end
end

-- Every widget of the addon's (or Blizzard's) with `script` set.
function Client:WidgetsWithScript(script)
	local list = {}
	for _, widget in ipairs(self.widgets) do
		local s = state[widget]
		if s.scripts[script] or s.hooks[script] then
			list[#list + 1] = widget
		end
	end
	return list
end

-- Every event some frame is registered for.
function Client:RegisteredEvents()
	local events = {}
	for widget in pairs(self.eventFrames) do
		for event in pairs(state[widget].events) do
			events[event] = true
		end
	end
	return events
end

function Client:EnterCombat()
	self.world.inCombat = true
	self:FireEvent("PLAYER_REGEN_DISABLED")
	self:FireEvent("PLAYER_ENTER_COMBAT")
end

function Client:LeaveCombat()
	self.world.inCombat = false
	self:FireEvent("PLAYER_LEAVE_COMBAT")
	self:FireEvent("PLAYER_REGEN_ENABLED")
end

-- Adds one of 3.3.5's nameplates to the WorldFrame (see
-- mocks/client_blizzard.lua for the spec). Returns a handle with :Update(changes).
function Client:AddNamePlate(spec)
	return Blizzard.addNamePlate(self, spec or {})
end

-- Sets a unit (or removes it with nil) and fires what the client would.
function Client:SetUnit(token, unit)
	self.world.units[token] = unit
	if token == "target" then
		self:FireEvent("PLAYER_TARGET_CHANGED")
		self:FireEvent("UNIT_TARGET", "player")
	elseif token == "focus" then
		self:FireEvent("PLAYER_FOCUS_CHANGED")
	elseif token == "pet" then
		self:FireEvent("UNIT_PET", "player")
	elseif token:match("^party%d$") then
		self:FireEvent("PARTY_MEMBERS_CHANGED")
	elseif token:match("^raid%d+$") then
		self:FireEvent("RAID_ROSTER_UPDATE")
	elseif token:match("^boss%d$") then
		self:FireEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	elseif token:match("^arena%d$") then
		self:FireEvent("ARENA_OPPONENT_UPDATE", token, unit and "seen" or "cleared")
	end
end

------------------------------------------------------------------------
-- Secure state drivers and unit watches
------------------------------------------------------------------------

-- Runs fn in "secure code": combat lockdown doesn't apply.
function Client:Secure(fn, ...)
	local was = self.secureContext
	self.secureContext = true
	local ok, err = pcall(fn, ...)
	self.secureContext = was
	if not ok then
		error(err, 0)
	end
end

function Client:UpdateStateDrivers()
	if self.updatingDrivers then
		return
	end
	self.updatingDrivers = true
	for _, driver in ipairs(self.stateDrivers) do
		local value = self.api.SecureCmdOptionParse(driver.values)
		if value ~= driver.last then
			driver.last = value
			self:Secure(function()
				if driver.state == "visibility" then
					if value == "show" then
						driver.frame:Show()
					elseif value == "hide" then
						driver.frame:Hide()
					end
				else
					driver.frame:SetAttribute("state-" .. driver.state, value)
				end
			end)
		end
	end
	for frame in pairs(self.unitWatches) do
		local unit = frame:GetAttribute("unit")
		local exists = unit and self.api.UnitExists(unit)
		local shown = frame:IsShown()
		if exists and not shown then
			self:Secure(frame.Show, frame)
		elseif not exists and shown then
			self:Secure(frame.Hide, frame)
		end
	end
	self.updatingDrivers = false
end

------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------

-- WoW's global shortcuts to the Lua standard library, and its additions.
local function installLua(client)
	local aliases = {
		strbyte = string.byte, strchar = string.char, strfind = string.find,
		format = string.format, gsub = string.gsub, strlen = string.len, strlower = string.lower,
		strmatch = string.match, strrep = string.rep, strrev = string.reverse, strsub = string.sub,
		strupper = string.upper, gmatch = string.gmatch,
		tinsert = table.insert, tremove = table.remove, sort = table.sort, getn = table.getn,
		foreach = table.foreach, foreachi = table.foreachi,
		abs = math.abs, ceil = math.ceil, floor = math.floor, max = math.max, min = math.min,
		mod = math.fmod, sqrt = math.sqrt, random = math.random, exp = math.exp, log = math.log,
		log10 = math.log10, frexp = math.frexp, ldexp = math.ldexp, deg = math.deg, rad = math.rad,
		sin = function(degrees) return math.sin(math.rad(degrees)) end,
		cos = function(degrees) return math.cos(math.rad(degrees)) end,
		tan = function(degrees) return math.tan(math.rad(degrees)) end,
		asin = function(x) return math.deg(math.asin(x)) end,
		acos = function(x) return math.deg(math.acos(x)) end,
		atan = function(x) return math.deg(math.atan(x)) end,
		atan2 = function(y, x) return math.deg(math.atan2(y, x)) end,
		date = os.date, time = os.time, difftime = os.difftime,
	}
	for name, value in pairs(aliases) do
		_G[name] = value
	end
	local function strtrim(text, chars)
		chars = chars and ("[" .. chars:gsub("[%]%^%-]", "%%%0") .. "]") or "%s"
		return (text:gsub("^" .. chars .. "+", ""):gsub(chars .. "+$", ""))
	end
	local function strsplit(sep, text, limit)
		local parts, pattern = {}, "[" .. sep:gsub("[%]%^%-%%]", "%%%0") .. "]"
		local start = 1
		while true do
			if limit and #parts == limit - 1 then
				parts[#parts + 1] = text:sub(start)
				break
			end
			local first, last = text:find(pattern, start)
			if not first then
				parts[#parts + 1] = text:sub(start)
				break
			end
			parts[#parts + 1] = text:sub(start, first - 1)
			start = last + 1
		end
		return unpack(parts)
	end
	local function strjoin(sep, ...)
		return table.concat({ ... }, sep)
	end
	_G.strtrim, _G.strsplit, _G.strjoin = strtrim, strsplit, strjoin
	_G.strconcat = function(...) return table.concat({ ... }) end
	_G.tostringall = function(...)
		local t = { ... }
		for i = 1, select("#", ...) do t[i] = tostring(t[i]) end
		return unpack(t, 1, select("#", ...))
	end
	-- the same functions: string.split(delimiter, text), like strsplit
	string.trim, string.split, string.join = strtrim, strsplit, strjoin
	_G.wipe = function(t)
		for key in pairs(t) do t[key] = nil end
		return t
	end
	table.wipe = _G.wipe
	_G.tContains = function(t, value)
		for _, v in pairs(t) do
			if v == value then return 1 end
		end
		return nil
	end
	_G.tDeleteItem = function(t, value)
		for i = #t, 1, -1 do
			if t[i] == value then table.remove(t, i) end
		end
	end
	-- the parts of LuaBitOp WoW ships
	local function toBits(n)
		n = n % 4294967296
		return n
	end
	local function bitOp(a, b, op)
		a, b = toBits(a), toBits(b)
		local result, bitValue = 0, 1
		for _ = 1, 32 do
			local x, y = a % 2, b % 2
			if op(x, y) then result = result + bitValue end
			a, b = (a - x) / 2, (b - y) / 2
			bitValue = bitValue * 2
		end
		return result
	end
	_G.bit = {
		band = function(a, b, ...)
			local r = bitOp(a, b, function(x, y) return x == 1 and y == 1 end)
			if ... then return _G.bit.band(r, ...) end
			return r
		end,
		bor = function(a, b, ...)
			local r = bitOp(a, b, function(x, y) return x == 1 or y == 1 end)
			if ... then return _G.bit.bor(r, ...) end
			return r
		end,
		bxor = function(a, b) return bitOp(a, b, function(x, y) return x ~= y end) end,
		bnot = function(a) return 4294967295 - toBits(a) end,
		lshift = function(a, n) return toBits(a * 2 ^ n) end,
		rshift = function(a, n) return math.floor(toBits(a) / 2 ^ n) end,
	}
	_G.debugstack = function() return debug.traceback("", 2) end
	_G.geterrorhandler = function()
		return client.errorHandler
	end
	_G.seterrorhandler = function(handler)
		assert(type(handler) == "function", "seterrorhandler: needs a function")
		client.errorHandler = handler
	end
	_G.securecall = function(fn, ...)
		if type(fn) == "string" then fn = _G[fn] end
		local results = { pcall(fn, ...) }
		if not results[1] then
			client:RecordError(results[2])
			return
		end
		return unpack(results, 2)
	end
	_G.issecure = function() return client.secureContext and 1 or nil end
	-- every value in the fake world was set by the addon (tainted); a key
	-- with nothing in it is secure
	_G.issecurevariable = function(t, name)
		if name == nil then
			t, name = _G, t
		end
		if rawget(t, name) == nil then
			return 1
		end
		return nil, "DiabolicUI"
	end
	_G.forceinsecure = function() end
	_G.hooksecurefunc = function(target, name, hook)
		if type(target) == "string" then
			target, name, hook = _G, target, name
		end
		local original = target[name]
		assert(type(original) == "function", "hooksecurefunc(): " .. tostring(name) .. " is not a function")
		assert(type(hook) == "function", "hooksecurefunc(): hook is not a function")
		local wrapped = function(...)
			-- the game's hook is C code: a coroutine can't yield inside what
			-- it wraps ("attempt to yield across metamethod/C-call
			-- boundary"), pcall is a C call too
			local results = { pcall(original, ...) }
			if not results[1] then
				error(results[2], 0)
			end
			table.remove(results, 1)
			local n = select("#", ...)
			local args = { ... }
			client:Call(function() hook(unpack(args, 1, n)) end)
			return unpack(results)
		end
		if target == _G then
			rawset(_G, name, wrapped)
		else
			rawset(target, name, wrapped)
		end
	end
end

------------------------------------------------------------------------
-- Construction
------------------------------------------------------------------------

function Client.new(options)
	options = options or {}
	resetGlobals()
	local client = setmetatable({
		world = Api.newWorld(options.class),
		widgets = {},
		widgetState = state,
		eventFrames = {}, -- every frame that registered an event once
		updaters = {}, -- every widget that got an OnUpdate script once
		playing = {},
		errors = {},
		blocked = {},
		missing = {},
		sounds = {},
		emotes = {},
		chat = {},
		stateDrivers = {},
		unitWatches = {},
		autoHideFrames = {},
		firedEvents = {},
		options = options,
	}, Client)
	client.errorHandler = function(message)
		client:RecordError(debug.traceback(tostring(message), 2))
	end
	Widgets.attach(client)
	Secure.attach(client)
	client.secure = Secure
	installLua(client)
	client.api = Api.install(client)
	for name, fn in pairs(client.api) do
		_G[name] = fn
	end
	Blizzard.install(client)
	if options.world then
		options.world(client.world, client)
	end
	return client
end

-- Loads the addon from the .toc and runs the login sequence.
-- options: class, world = function(world, client), savedVariables = { DiabolicUI_DB = ..., DiabolicUI_Layout = ... },
-- login = false to stop after loading the files.
function Client.boot(options)
	options = options or {}
	local client = Client.new(options)
	client.addonTable = {}
	local failures = Loader.load(client.addonTable, function(spec)
		client:CreateXmlFont(spec)
	end)
	for _, failure in ipairs(failures) do
		client:RecordError(failure)
	end
	-- like in game: the saved variables replace whatever the files set,
	-- after they ran and before ADDON_LOADED
	for _, name in ipairs({ "DiabolicUI_DB", "DiabolicUI_Minimap_DB", "DiabolicUI_Layout" }) do
		local saved = options.savedVariables and options.savedVariables[name]
		if saved ~= nil then
			rawset(_G, name, saved)
		end
	end
	client.Engine = client.addonTable
	if options.login ~= false then
		client:Login()
	end
	return client
end

function Client:Login()
	self:FireEvent("ADDON_LOADED", "DiabolicUI")
	self:FireEvent("SPELLS_CHANGED")
	self:FireEvent("VARIABLES_LOADED")
	self.world.loggedIn = true
	self:FireEvent("PLAYER_LOGIN")
	self:FireEvent("PLAYER_ENTERING_WORLD")
	self:FireEvent("PLAYER_ALIVE")
	self:FireEvent("UPDATE_BINDINGS")
	self:FireEvent("UPDATE_SHAPESHIFT_FORMS")
	self:FireEvent("ACTIONBAR_SLOT_CHANGED", 0)
	self:FireEvent("UPDATE_BONUS_ACTIONBAR")
	self:Tick(0.5)
end

-- A <Font> from the addon's XML (see mocks/addon_loader.lua).
function Client:CreateXmlFont(spec)
	local font = _G.CreateFont(spec.name)
	if spec.inherits and _G[spec.inherits] then
		font:CopyFontObject(_G[spec.inherits])
	end
	if spec.font or spec.height then
		local path, height, flags = font:GetFont()
		font:SetFont(spec.font or path, spec.height or height, spec.outline or flags)
	end
	if spec.justifyH then font:SetJustifyH(spec.justifyH) end
	if spec.justifyV then font:SetJustifyV(spec.justifyV) end
	if spec.shadowOffset then font:SetShadowOffset(unpack(spec.shadowOffset)) end
	if spec.color then font:SetTextColor(unpack(spec.color)) end
	return font
end

-- The engine's modules and handlers, and the minimap's Ace3 addon.
function Client:GetModule(name)
	return self.Engine:GetModule(name)
end

function Client:GetHandler(name)
	return self.Engine:GetHandler(name)
end

-- The errors and blocked actions so far, as one readable string ("" when
-- none): each distinct one once, with the addon's part of its stack.
function Client:Problems()
	local lines, seen = {}, {}
	local function add(kind, text)
		local first = text:match("^[^\n]*")
		local where = {}
		for line in text:gmatch("\n%s*([^\n]+)") do
			if not (line:match("tests/") or line:match("^stack traceback") or line:match("%[C%]")
				or line:match("tail call") or line:match("^%.%.%.")) and #where < 4 then
				where[#where + 1] = "    " .. line
			end
		end
		local key = kind .. first .. (where[1] or "")
		if not seen[key] then
			seen[key] = 1
			lines[#lines + 1] = key
			lines[key] = kind .. ": " .. first .. (#where > 0 and ("\n" .. table.concat(where, "\n")) or "")
		else
			seen[key] = seen[key] + 1
		end
	end
	for _, err in ipairs(self.errors) do
		add("ERROR", err)
	end
	for _, blocked in ipairs(self.blocked) do
		add("BLOCKED", blocked)
	end
	local out = {}
	for _, key in ipairs(lines) do
		out[#out + 1] = lines[key] .. (seen[key] > 1 and ("\n    (" .. seen[key] .. " times)") or "")
	end
	return table.concat(out, "\n")
end

function Client:ClearProblems()
	self.errors = {}
	self.blocked = {}
end

return Client
