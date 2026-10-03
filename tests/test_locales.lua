-- Run from the addon root: lua5.1 tests/test_locales.lua
--
-- Checks the translations in locale/ against the code that uses them:
--  - locale_handler.lua: the game-locale table falls back to English for
--    anything it doesn't translate, `true` means "the key is the text", and
--    NewLocale only hands out a table for enUS and the client's own locale
--  - every locale file loads, assigns each key once, and every key it
--    translates exists in locale-enUS.lua (a key only a translation has
--    is a typo, or text the code no longer shows)
--  - every literal L["..."] key the addon's code looks up exists in
--    locale-enUS.lua; a missing one prints "There's a missing locale" in
--    the player's chat frame
--  - and every key in locale-enUS.lua is looked up somewhere

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

local LOCALES = { "deDE", "esES", "esMX", "frFR", "koKR", "ruRU", "zhCN", "zhTW" }

-- Loads locale_handler.lua for the given client locale, then the given
-- locale files through it (like locale.xml does). Returns the Engine table.
local function loadLocales(gameLocale, files)
	_G.GetLocale = function() return gameLocale end
	local Engine = {}
	assert(loadfile("locale/locale_handler.lua"))("DiabolicUI", Engine)
	for _, file in ipairs(files) do
		assert(loadfile(file))("DiabolicUI", Engine)
	end
	return Engine
end

-- Every key a locale file assigns, read by handing the file a recording
-- table instead of the real locale. Also returns the keys it assigns twice.
local function keysOf(file)
	local keys, twice = {}, {}
	local recorder = setmetatable({}, { __newindex = function(_, key)
		if keys[key] then
			table.insert(twice, key)
		end
		keys[key] = true
	end })
	assert(loadfile(file))("DiabolicUI", { NewLocale = function() return recorder end })
	return keys, twice
end

-- Silences the handler's "missing locale" chat message while `func` runs,
-- and returns what it would have printed.
local function capturePrint(func)
	local printed = {}
	local print = _G.print
	_G.print = function(...) table.insert(printed, table.concat({ ... }, " ")) end
	local ok, err = pcall(func)
	_G.print = print
	assert(ok, err)
	return printed
end

TestLocaleHandler = {}

function TestLocaleHandler:test_english_client_reads_english()
	local Engine = loadLocales("enUS", { "locale/locale-enUS.lua" })
	local L = Engine:GetLocale()
	-- `L[key] = true` entries read back as the key itself
	lu.assertEquals(L["Show Portrait"], "Show Portrait")
end

function TestLocaleHandler:test_translation_wins_and_english_fills_gaps()
	local Engine = loadLocales("frFR", { "locale/locale-enUS.lua", "locale/locale-frFR.lua" })
	local L = Engine:GetLocale()
	lu.assertEquals(L["Alt"], "A")
	lu.assertEquals(Engine:GetGameLocale(), "frFR")

	-- a key frFR doesn't translate falls back to the English text
	local frKeys = keysOf("locale/locale-frFR.lua")
	for key in pairs(keysOf("locale/locale-enUS.lua")) do
		if not frKeys[key] then
			lu.assertEquals(L[key], key)
			break
		end
	end
end

function TestLocaleHandler:test_new_locale_only_for_english_and_client_locale()
	local Engine = loadLocales("deDE", {})
	lu.assertNotNil(Engine:NewLocale("enUS"))
	lu.assertIs(Engine:NewLocale("deDE"), Engine:GetLocale())
	lu.assertNil(Engine:NewLocale("frFR"))
end

function TestLocaleHandler:test_unknown_key_returns_itself_and_complains()
	local Engine = loadLocales("enUS", { "locale/locale-enUS.lua" })
	local L = Engine:GetLocale()
	local value
	local printed = capturePrint(function() value = L["No such text"] end)
	lu.assertEquals(value, "No such text")
	lu.assertEquals(#printed, 1)
	lu.assertStrContains(printed[1], "missing locale")
end

TestLocaleFiles = {}

function TestLocaleFiles:test_every_locale_loads_for_its_own_client()
	for _, locale in ipairs(LOCALES) do
		local file = "locale/locale-" .. locale .. ".lua"
		local ok, err = pcall(loadLocales, locale, { "locale/locale-enUS.lua", file })
		lu.assertTrue(ok, file .. ": " .. tostring(err))
	end
end

-- (a second assignment of a key would store a bare `true`, which reads
-- back as true instead of the text)
function TestLocaleFiles:test_no_key_is_assigned_twice()
	local twice = {}
	for _, locale in ipairs({ "enUS", unpack(LOCALES) }) do
		local _, dupes = keysOf("locale/locale-" .. locale .. ".lua")
		for _, key in ipairs(dupes) do
			table.insert(twice, locale .. ": " .. key)
		end
	end
	lu.assertEquals(twice, {})
end

function TestLocaleFiles:test_translations_only_use_english_keys()
	local english = keysOf("locale/locale-enUS.lua")
	local stray = {}
	for _, locale in ipairs(LOCALES) do
		for key in pairs(keysOf("locale/locale-" .. locale .. ".lua")) do
			if not english[key] then
				table.insert(stray, locale .. ": " .. key)
			end
		end
	end
	table.sort(stray)
	lu.assertEquals(stray, {}, "keys missing from locale-enUS.lua")
end

-- Literal keys only: L["Button" .. i] and friends are built at runtime.
local function literalKeysUsedBy(path)
	local file = assert(io.open(path, "r"))
	local source = file:read("*a")
	file:close()
	local keys = {}
	for quote, raw in source:gmatch("L%[([\"'])([^\"'\n]-)%1%]") do
		-- decode escapes such as \n exactly like the compiler does
		local key = assert(loadstring("return " .. quote .. raw .. quote))()
		keys[#keys + 1] = key
	end
	return keys
end

function TestLocaleFiles:test_code_only_uses_known_keys()
	local english = keysOf("locale/locale-enUS.lua")
	local pipe = assert(io.popen("find engine handlers modules data defaults settings -name '*.lua' -not -path 'modules/minimap/*' | sort"))
	local missing = {}
	for path in pipe:lines() do
		for _, key in ipairs(literalKeysUsedBy(path)) do
			if not english[key] then
				table.insert(missing, path .. ": " .. key)
			end
		end
	end
	pipe:close()
	lu.assertEquals(missing, {}, "keys missing from locale-enUS.lua")
end

-- Every key in locale-enUS.lua shows up in the code as a quoted string
-- (looked up as L["..."], or handed to code that looks it up).
function TestLocaleFiles:test_every_english_key_is_used()
	local sources = {}
	local pipe = assert(io.popen("find engine handlers modules data defaults settings -name '*.lua' -not -path 'modules/minimap/*' | sort"))
	for path in pipe:lines() do
		local file = assert(io.open(path, "r"))
		sources[#sources + 1] = file:read("*a")
		file:close()
	end
	pipe:close()
	local code = table.concat(sources, "\n")
	local unused = {}
	for key in pairs(keysOf("locale/locale-enUS.lua")) do
		local written = key:gsub("\n", "\\n") -- as the source spells a line break
		local quoted = code:find('"' .. written .. '"', 1, true) or code:find("'" .. written .. "'", 1, true)
		-- (the mouse button names are looked up as L["Button" .. i])
		if (not quoted) and (not key:match("^Button%d+$")) then
			table.insert(unused, key)
		end
	end
	table.sort(unused)
	lu.assertEquals(unused, {}, "texts in locale-enUS.lua that nothing shows")
end

os.exit(lu.LuaUnit.run())
