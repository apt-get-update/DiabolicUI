-- Run from the addon root: lua5.1 tests/test_no_global_leaks.lua
--
-- Fails if any addon file assigns a global variable that isn't on the
-- ALLOWED list below. A missing `local` silently turns a variable into a
-- global shared with Blizzard's UI and every other addon: two files can
-- clobber each other, and writing a name Blizzard's own code reads (e.g.
-- `_`, or a frame name) taints it.
--
-- Uses the compiler's own bytecode listing (`luac -l`, SETGLOBAL ops), so
-- it only sees plain `name = value` assignments. Explicit `_G.name = value`
-- writes don't show up here, on purpose: those are visibly deliberate.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

local LUAC = os.getenv("LUAC") or "luac5.1"

-- Intentional global writes, per file.
local ALLOWED = {
	["engine/engine-core.lua"] = {
		DiabolicUI_DB = true, -- the SavedVariable itself
	},
	["engine/blizzard-taint.lua"] = {
		UIDROPDOWNMENU_VALUE_PATCH_VERSION = true, -- Blizzard dropdown taint fix
	},
	["modules/blizzard/fonts.lua"] = {
		-- Blizzard's own font/combat-text settings, overridden on purpose
		CHAT_FONT_HEIGHTS = true,
		COMBAT_TEXT_CRIT_MAXHEIGHT = true,
		COMBAT_TEXT_CRIT_MINHEIGHT = true,
		COMBAT_TEXT_HEIGHT = true,
		COMBAT_TEXT_SCROLLSPEED = true,
		DAMAGE_TEXT_FONT = true,
		NAMEPLATE_FONT = true,
		STANDARD_TEXT_FONT = true,
		UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = true,
		UNIT_NAME_FONT = true,
	},
	["modules/chat/windows.lua"] = {
		CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = true, -- Blizzard chat constant
	},
}

-- Vendored third-party code (Ace3 etc.) manages its own globals.
local EXCLUDED_PREFIXES = { "modules/minimap/" }

local listSourceFiles = function()
	local files = {}
	local pipe = io.popen("find engine handlers modules settings defaults data locale -name '*.lua' | sort")
	for path in pipe:lines() do
		local excluded = false
		for _, prefix in ipairs(EXCLUDED_PREFIXES) do
			if path:sub(1, #prefix) == prefix then
				excluded = true
			end
		end
		if not excluded then
			files[#files + 1] = path
		end
	end
	pipe:close()
	return files
end

local findGlobalWrites = function(path)
	local writes = {}
	local pipe = io.popen(LUAC .. " -p -l '" .. path .. "' 2>&1")
	for line in pipe:lines() do
		local lineNumber, name = line:match("%[(%d+)%]%s+SETGLOBAL%s.-;%s*([%w_]+)%s*$")
		if name then
			writes[#writes + 1] = { name = name, line = tonumber(lineNumber) }
		end
	end
	pipe:close()
	return writes
end

TestNoGlobalLeaks = {}

function TestNoGlobalLeaks:test_finds_source_files()
	-- Guards against the scan silently passing because it found nothing
	-- (e.g. run from the wrong directory).
	lu.assertTrue(#listSourceFiles() > 50)
end

function TestNoGlobalLeaks:test_no_unexpected_global_writes()
	local leaks = {}
	for _, path in ipairs(listSourceFiles()) do
		local allowed = ALLOWED[path] or {}
		for _, write in ipairs(findGlobalWrites(path)) do
			if not allowed[write.name] then
				leaks[#leaks + 1] = ("%s:%d  %s"):format(path, write.line, write.name)
			end
		end
	end
	if #leaks > 0 then
		lu.fail("Unexpected global writes (missing `local`?), or add to ALLOWED if intentional:\n  " .. table.concat(leaks, "\n  "))
	end
end

function TestNoGlobalLeaks:test_detector_catches_a_leak()
	-- Proves the bytecode pattern actually matches, so a luac output
	-- format change can't make the main test pass vacuously.
	local tmp = os.tmpname()
	local f = io.open(tmp, "w")
	f:write("local x = 1\nleaked = x\n")
	f:close()
	local writes = findGlobalWrites(tmp)
	os.remove(tmp)
	lu.assertEquals(#writes, 1)
	lu.assertEquals(writes[1].name, "leaked")
	lu.assertEquals(writes[1].line, 2)
end

os.exit(lu.LuaUnit.run())
