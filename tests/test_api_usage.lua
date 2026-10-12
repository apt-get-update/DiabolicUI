-- Run from the addon root: lua5.1 tests/test_api_usage.lua
--
-- Catches code that can't work on the WotLK 3.3.5a client, across every
-- addon file (the minimap's vendored Libs excepted):
--  - reading a lowercase global nobody defines: almost always a typo or a
--    missing local (`hasVehicleUI` for `HAS_VEHICLE_UI`, `level` for
--    `unitLevel`), which reads nil and quietly breaks the feature
--  - registering an event that only later expansions fire (the handler
--    never runs on 3.3.5)
--  - using an API function or frame method from a later expansion (an error
--    when reached, or a branch that can never run)
--  - a secure snippet calling a method nobody defines (control:CallMethod)
-- test_wotlk_globals.lua does the same for ALL-CAPS UI strings and constants.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

-- A temporary file name in $TMPDIR (os.tmpname() always uses /tmp, which a
-- sandbox may not let us write to).
local function tempName()
	return (os.getenv("TMPDIR") or "/tmp") .. "/diabolicui_test_" .. os.time() .. "_" .. math.random(1e9)
end

local LUAC = os.getenv("LUAC") or "luac5.1"

-- Lowercase globals that exist: Lua's own, and the ones WoW adds.
local LOWERCASE_GLOBALS = {}
for name in ([[
	_G assert bit collectgarbage coroutine date debug debugstack error format gcinfo
	getfenv geterrorhandler getmetatable hooksecurefunc ipairs issecurevariable
	loadstring math next pairs pcall print rawequal rawget rawset securecall select
	seterrorhandler setfenv setmetatable string strjoin strsplit strtrim strupper
	strlower strmatch strfind strlen strsub strrep gsub table time tinsert tonumber
	tostring tremove type unpack wipe xpcall floor ceil abs max min random sqrt
]]):gmatch("%S+") do
	LOWERCASE_GLOBALS[name] = true
end

-- Events only later expansions fire, and what 3.3.5 uses instead.
local LATER_EVENTS = {
	GROUP_ROSTER_UPDATE = "PARTY_MEMBERS_CHANGED / RAID_ROSTER_UPDATE",
	GUILD_RANKS_UPDATE = "GUILD_ROSTER_UPDATE",
	LOSS_OF_CONTROL_ADDED = "(nothing: Mists of Pandaria)",
	LOSS_OF_CONTROL_UPDATE = "(nothing: Mists of Pandaria)",
	NEUTRAL_FACTION_SELECT_RESULT = "(nothing: Mists of Pandaria)",
	PLAYER_ENTERING_VEHICLE = "UNIT_ENTERING_VEHICLE",
	PLAYER_ENTERED_VEHICLE = "UNIT_ENTERED_VEHICLE",
	PLAYER_EXITING_VEHICLE = "UNIT_EXITING_VEHICLE",
	PLAYER_EXITED_VEHICLE = "UNIT_EXITED_VEHICLE",
	PLAYER_SPECIALIZATION_CHANGED = "ACTIVE_TALENT_GROUP_CHANGED",
	UNIT_POWER_UPDATE = "UNIT_MANA, UNIT_RAGE, ...",
	UNIT_POWER_FREQUENT = "UNIT_MANA, UNIT_RAGE, ...",
	UNIT_TARGETABLE_CHANGED = "(nothing: Cataclysm)",
	UPDATE_OVERRIDE_ACTIONBAR = "UPDATE_BONUS_ACTIONBAR",
	UPDATE_SUMMONPETS_ACTION = "(nothing: battle pets)",
	ARCHAEOLOGY_CLOSED = "(nothing: Cataclysm)",
	PET_BATTLE_OPENING_START = "(nothing: battle pets)",
}

-- API functions and frame methods only later expansions have.
local LATER_GLOBALS = {
	Enum = true, BreakUpLargeNumbers = true, FindSpellBookSlotBySpellID = true,
	GetAddOnEnableState = true, GetLossOfControlCooldown = true, GetSpecialization = true,
	GetSpellCharges = true, StartChargeCooldown = true, UnitHasVehiclePlayerFrameUI = true,
	UnitIsTapDenied = true, -- DiabolicUI has its own, Engine.UnitIsTapDenied
}
local LATER_METHODS = {
	RegisterUnitEvent = true, SetAtlas = true, SetBlingTexture = true, SetColorTexture = true,
	SetDrawBling = true, SetDrawEdge = true, SetDrawSwipe = true, SetEdgeTexture = true,
	SetHideCountdownNumbers = true, SetIgnoreParentAlpha = true, SetShown = true,
	SetSnapToPixelGrid = true, SetSpellByID = true, SetSwipeColor = true,
}

local readFile = function(path)
	local file = assert(io.open(path, "rb"))
	local text = file:read("*a")
	file:close()
	return text
end

-- Source without comments or string contents (event names stay: they're
-- matched before this, on the raw text).
local stripComments = function(text)
	text = text:gsub("%-%-%[(=*)%[.-%]%1%]", "")
	return (text:gsub("%-%-[^\n]*", ""))
end

local listSourceFiles = function()
	local files = {}
	local pipe = io.popen("find engine handlers modules settings defaults data locale -name '*.lua' -not -path '*/Libs/*' | sort")
	for path in pipe:lines() do
		files[#files + 1] = path
	end
	pipe:close()
	return files
end

-- Globals a file reads and writes, from its bytecode ({ name = "file:line" }).
local scanGlobals = function(path)
	local reads, writes = {}, {}
	local pipe = io.popen(LUAC .. " -p -l '" .. path .. "' 2>&1")
	for line in pipe:lines() do
		local lineNumber, op, name = line:match("%[(%d+)%]%s+([GS]ETGLOBAL)%s.-;%s*([%a_][%w_]*)%s*$")
		if name then
			if op == "GETGLOBAL" then
				reads[name] = reads[name] or (path .. ":" .. lineNumber)
			else
				writes[name] = true
			end
		end
	end
	pipe:close()
	return reads, writes
end

-- Finds the problems in one file's source and bytecode.
local scanFile = function(path, source)
	local problems = { lowercase = {}, events = {}, globals = {}, methods = {} }
	local reads = scanGlobals(path)
	for name, where in pairs(reads) do
		if name:match("^[%l_]") then
			problems.lowercase[name] = where
		end
		if LATER_GLOBALS[name] then
			problems.globals[name] = where
		end
	end
	local lineOf = function(text, position)
		local _, count = text:sub(1, position):gsub("\n", "")
		return path .. ":" .. (count + 1)
	end
	for position, event in source:gmatch("()RegisterEvent%(%s*[\"']([%u%d_]+)[\"']") do
		if LATER_EVENTS[event] then
			problems.events[event] = lineOf(source, position)
		end
	end
	local code = stripComments(source)
	for position, method in code:gmatch("():([%a_][%w_]*)%s*%(") do
		if LATER_METHODS[method] then
			problems.methods[method] = lineOf(code, position)
		end
	end
	for position, name in code:gmatch("()_G%.([%a_][%w_]*)") do
		if LATER_GLOBALS[name] then
			problems.globals[name] = lineOf(code, position)
		end
	end
	return problems
end

local scanAll = function()
	local all = { lowercase = {}, events = {}, globals = {}, methods = {} }
	local defined = {}
	for _, path in ipairs(listSourceFiles()) do
		local problems = scanFile(path, readFile(path))
		for kind, found in pairs(problems) do
			for name, where in pairs(found) do
				all[kind][name] = all[kind][name] or where
			end
		end
		local _, writes = scanGlobals(path)
		for name in pairs(writes) do
			defined[name] = true
		end
	end
	for name in pairs(all.lowercase) do
		if LOWERCASE_GLOBALS[name] or defined[name] then
			all.lowercase[name] = nil
		end
	end
	return all
end

local report = function(found, describe)
	local lines = {}
	for name, where in pairs(found) do
		lines[#lines + 1] = where .. "  " .. name .. (describe and describe(name) or "")
	end
	table.sort(lines)
	return table.concat(lines, "\n  ")
end

TestApiUsage = {}

function TestApiUsage:setUp()
	self.found = self.found or scanAll()
end

function TestApiUsage:test_no_undefined_lowercase_globals()
	local found = scanAll().lowercase
	if next(found) then
		lu.fail("Undefined lowercase globals (a typo or a missing local?):\n  " .. report(found))
	end
end

function TestApiUsage:test_no_events_from_later_expansions()
	local found = scanAll().events
	if next(found) then
		lu.fail("Events 3.3.5 never fires:\n  " .. report(found, function(name) return "  (use " .. LATER_EVENTS[name] .. ")" end))
	end
end

function TestApiUsage:test_no_api_from_later_expansions()
	local all = scanAll()
	local found = {}
	for name, where in pairs(all.globals) do found[name] = where end
	for name, where in pairs(all.methods) do found[":" .. name] = where end
	if next(found) then
		lu.fail("API that 3.3.5 doesn't have:\n  " .. report(found))
	end
end

-- Secure snippets are code in strings, run by Blizzard's secure handlers:
-- a method they call with control:CallMethod("Name") only fails in game,
-- at the moment the snippet runs ("Invalid method 'Name'").
function TestApiUsage:test_secure_snippets_only_call_methods_that_exist()
	local defined, called = {}, {}
	for _, path in ipairs(listSourceFiles()) do
		local source = readFile(path)
		for name in source:gmatch("[.:]([%a_][%w_]*)%s*=%s*function") do
			defined[name] = true
		end
		for name in source:gmatch("[.:]([%a_][%w_]*)%s*=%s*Engine:Wrap%(function") do
			defined[name] = true
		end
		for name in source:gmatch("function%s+[%w_.]+[.:]([%a_][%w_]*)") do
			defined[name] = true
		end
		local lineNumber = 0
		for line in (source .. "\n"):gmatch("(.-)\r?\n") do
			lineNumber = lineNumber + 1
			if not line:match("^%s*%-%-") then
				for name in line:gmatch("CallMethod%(%s*[\"']([%a_][%w_]*)[\"']") do
					called[name] = called[name] or (path .. ":" .. lineNumber)
				end
			end
		end
	end
	local missing = {}
	for name, where in pairs(called) do
		if not defined[name] then
			missing[name] = where
		end
	end
	if next(missing) then
		lu.fail("Secure snippets call methods nobody defines:\n  " .. report(missing))
	end
	lu.assertNotNil(called.SaveNumBars) -- the scan does see the bar toggles' calls
end

function TestApiUsage:test_detectors_catch_planted_mistakes()
	local tmp = tempName()
	local source = table.concat({
		"local f = CreateFrame('Frame')",
		"f:RegisterEvent(\"GROUP_ROSTER_UPDATE\")",
		"if hasVehicleUI then f:SetShown(true) end",
		"local n = _G.BreakUpLargeNumbers",
		"local ok = GetSpellCharges",
		"-- f:SetColorTexture(1, 1, 1) in a comment is fine",
	}, "\n")
	local file = assert(io.open(tmp, "w"))
	file:write(source)
	file:close()
	local problems = scanFile(tmp, source)
	os.remove(tmp)
	lu.assertEquals(problems.events.GROUP_ROSTER_UPDATE, tmp .. ":2")
	lu.assertEquals(problems.lowercase.hasVehicleUI, tmp .. ":3")
	lu.assertEquals(problems.methods.SetShown, tmp .. ":3")
	lu.assertEquals(problems.globals.BreakUpLargeNumbers, tmp .. ":4")
	lu.assertEquals(problems.globals.GetSpellCharges, tmp .. ":5")
	lu.assertNil(problems.methods.SetColorTexture)
end

os.exit(lu.LuaUnit.run())
