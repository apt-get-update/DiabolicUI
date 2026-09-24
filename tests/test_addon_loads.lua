-- Run from the addon root: lua5.1 tests/test_addon_loads.lua
--
-- Loads the *whole addon* the way the WoW client does: reads DiabolicUI.toc,
-- follows every <Include> and <Script> in the XML files it lists, in order,
-- and runs each Lua file with the same ("DiabolicUI", addonTable) pair -
-- the real engine, real handlers, real settings and the embedded minimap
-- module with its vendored Ace3 libraries, all sharing one load.
--
-- Unlike test_all_modules_load.lua (each file alone, against a mock
-- Engine), this catches load-order problems: a file using a handler,
-- static config or constant that a later file defines, an XML file
-- pointing at a file that doesn't exist, or a vendored library that
-- stopped loading.
--
-- WoW's own API still isn't here, so the permissive auto-stub stands in for
-- it (see tests/README.md), with a few exceptions defined below: values
-- that have to be real numbers or strings, globals that must start out nil
-- because the addon (or a library it bundles) defines them itself, and
-- frames whose unset lowercase fields read as nil.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local WowApiMock = require("mocks.wow_api_mock")
local AutoStub = require("mocks.auto_stub")
local Stub = AutoStub.Stub

local ADDON = "DiabolicUI"
local TOC = ADDON .. ".toc"

------------------------------------------------------------------------
-- Load order
------------------------------------------------------------------------

local function dirname(path)
	return path:match("^(.*)/[^/]*$") or ""
end

local function joinPath(dir, file)
	file = file:gsub("\\", "/")
	return (dir == "") and file or (dir .. "/" .. file)
end

local function readFile(path)
	local file = io.open(path, "rb")
	if not file then
		return nil
	end
	local text = file:read("*a")
	file:close()
	return text
end

-- Every Lua file in load order, plus any file an XML or the .toc points at
-- that doesn't exist.
local function collectLoadOrder()
	local order, missing = {}, {}

	local function readXml(path)
		local text = readFile(path)
		if not text then
			table.insert(missing, path)
			return
		end
		text = text:gsub("<!%-%-.-%-%->", "")
		for tag, file in text:gmatch("<(%a+)%s+file%s*=%s*[\"']([^\"']+)[\"']") do
			local full = joinPath(dirname(path), file)
			if tag == "Include" then
				readXml(full)
			elseif tag == "Script" then
				table.insert(order, full)
			end
		end
	end

	for line in io.lines(TOC) do
		line = line:gsub("\r", ""):match("^%s*(.-)%s*$")
		if line ~= "" and not line:match("^#") then
			local path = line:gsub("\\", "/")
			if path:match("%.xml$") then
				readXml(path)
			else
				table.insert(order, path)
			end
		end
	end
	return order, missing
end

------------------------------------------------------------------------
-- The fake client
------------------------------------------------------------------------

-- Globals that exist in the real client before any addon loads, with real
-- values: numbers compared or used in arithmetic at file scope.
local CLIENT_GLOBALS = {
	NUM_ACTIONBAR_BUTTONS = 12,
	NUM_PET_ACTION_SLOTS = 10,
	NUM_POSSESS_SLOTS = 2,
	NUM_SHAPESHIFT_SLOTS = 10,
	VEHICLE_MAX_ACTIONBUTTONS = 6,
	BUFF_MAX_DISPLAY = 32,
	DEBUFF_MAX_DISPLAY = 16,
	UIDROPDOWNMENU_VALUE_PATCH_VERSION = 2,
	GetBuildInfo = function() return "3.3.5", "12340", "Jun 24 2010", 30300 end,
	GetTime = function() return 1000 end,
	GetNumAddOns = function() return 0 end,
	GetLocale = function() return "enUS" end,
	UnitAffectingCombat = function() return false end,
	InCombatLockdown = function() return false end,
	IsLoggedIn = function() return false end,
	-- WoW's string.split(sep, text)
	strsplit = function(sep, text)
		local parts = {}
		for part in (text .. sep):gmatch("(.-)" .. sep:gsub("%p", "%%%0")) do
			parts[#parts + 1] = part
		end
		return unpack(parts)
	end,
	wipe = function(t)
		for key in pairs(t) do
			t[key] = nil
		end
		return t
	end,
}

-- Globals that must read as nil until something defines them: libraries
-- check for an existing copy of themselves before installing.
local UNDEFINED = {
	LibStub = true,
	ChatThrottleLib = true,
	DiabolicUIMinimapNS = true,
	DiabolicUI_DB = true,
	DiabolicUI_Minimap_DB = true,
}

-- A frame: any CamelCase key (a widget method, as far as load time is
-- concerned) is a stub, any lowercase key an addon hasn't set is nil -
-- the engine's `Frame.eventRegistry` bookkeeping depends on that.
local frameMethods = setmetatable({}, {
	__index = function(_, key)
		if type(key) == "string" and key:match("^%u") then
			return Stub.new()
		end
	end,
})
local frameMT = { __index = frameMethods }

-- Event registration has to answer truthfully: the engine only sets up its
-- event bookkeeping for events its frame doesn't have yet.
function frameMethods:RegisterEvent(event)
	rawset(self, "_events", rawget(self, "_events") or {})
	self._events[event] = true
end
function frameMethods:UnregisterEvent(event)
	if rawget(self, "_events") then
		self._events[event] = nil
	end
end
function frameMethods:IsEventRegistered(event)
	return rawget(self, "_events") and self._events[event] or false
end

local function newFrame(fields)
	return setmetatable(fields or {}, frameMT)
end

local function screenFrame()
	return newFrame({
		GetSize = function() return 1920, 1080 end,
		GetWidth = function() return 1920 end,
		GetHeight = function() return 1080 end,
		GetScale = function() return 1 end,
		GetEffectiveScale = function() return 1 end,
	})
end

-- WoW's global shortcuts to the Lua standard library.
local LUA_ALIASES = {
	strbyte = string.byte, strchar = string.char, strfind = string.find,
	strformat = string.format, format = string.format, gsub = string.gsub,
	strlen = string.len, strlower = string.lower, strmatch = string.match,
	strrep = string.rep, strrev = string.reverse, strsub = string.sub,
	strupper = string.upper, gmatch = string.gmatch,
	tinsert = table.insert, tremove = table.remove, sort = table.sort,
	abs = math.abs, ceil = math.ceil, floor = math.floor, max = math.max,
	min = math.min, mod = math.fmod, sqrt = math.sqrt, random = math.random,
}

local function installClient()
	WowApiMock.install()
	for name, value in pairs(LUA_ALIASES) do
		_G[name] = value
	end
	for name, value in pairs(CLIENT_GLOBALS) do
		_G[name] = value
	end
	string.split = string.split or CLIENT_GLOBALS.strsplit
	_G.CreateFrame = function() return newFrame() end
	_G.UIParent = screenFrame()
	_G.WorldFrame = screenFrame()

	setmetatable(_G, {
		__index = function(_, key)
			if UNDEFINED[key] then
				return nil
			end
			return Stub.new()
		end,
	})
end

-- loadfile, minus the UTF-8 byte order mark some files start with: the
-- client skips it, plain Lua doesn't.
local function loadAddonFile(path)
	local text = readFile(path)
	if not text then
		return nil, "cannot open " .. path
	end
	text = text:gsub("^\239\187\191", "")
	return loadstring(text, "@" .. path)
end

------------------------------------------------------------------------
-- Tests
------------------------------------------------------------------------

local loadOrder, missingFiles = collectLoadOrder()

TestAddonLoads = {}

function TestAddonLoads:test_every_file_the_toc_and_xml_reference_exists()
	local missing = {}
	for _, path in ipairs(missingFiles) do
		table.insert(missing, path)
	end
	for _, path in ipairs(loadOrder) do
		if not readFile(path) then
			table.insert(missing, path)
		end
	end
	lu.assertEquals(missing, {})
end

-- Files deliberately left out of the load order, and why.
local NOT_LOADED = {
}

function TestAddonLoads:test_every_lua_file_is_in_the_load_order()
	-- a .lua file nothing loads is dead code, or a forgotten <Script> line
	-- (vendored libraries ship their own extras, so they're skipped)
	local loaded = {}
	for path in pairs(NOT_LOADED) do
		loaded[path] = true
	end
	for _, path in ipairs(loadOrder) do
		loaded[path] = true
	end
	local pipe = assert(io.popen("find . -name '*.lua' -not -path './tests/*' -not -path './docs/*' -not -path '*/Libs/*' | sort"))
	local orphans = {}
	for path in pipe:lines() do
		path = path:gsub("^%./", "")
		if not loaded[path] then
			table.insert(orphans, path)
		end
	end
	pipe:close()
	lu.assertEquals(orphans, {})
end

function TestAddonLoads:test_whole_addon_loads_in_toc_order()
	installClient()
	local addonTable = {}
	local failures = {}
	for _, path in ipairs(loadOrder) do
		local chunk, err = loadAddonFile(path)
		if chunk then
			local ok, runErr = pcall(chunk, ADDON, addonTable)
			if not ok then
				table.insert(failures, path .. ": " .. tostring(runErr))
			end
		elseif readFile(path) then
			table.insert(failures, path .. ": " .. tostring(err))
		end
	end
	lu.assertEquals(failures, {})

	-- The load really happened: the engine registered every module and
	-- handler, and the minimap module set up its Ace3 addon object.
	local Engine = addonTable
	for _, name in ipairs({ "ActionBars", "UnitFrames", "ChatWindows", "ObjectiveTracker", "Blizzard: LootFrame" }) do
		lu.assertNotNil(Engine:GetModule(name, true), "module " .. name)
	end
	for _, name in ipairs({ "UnitFrame", "ActionButton", "ChatCommand", "Orb", "StatusBar", "BlizzardUI" }) do
		lu.assertNotNil(Engine:GetHandler(name, true), "handler " .. name)
	end
	lu.assertEquals(type(Engine:GetDB("Data: Colors").General), "table")
	lu.assertNotNil(_G.LibStub("AceAddon-3.0"):GetAddon(ADDON, true), "minimap Ace3 addon")
end

os.exit(lu.LuaUnit.run())
