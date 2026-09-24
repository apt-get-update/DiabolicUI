-- Run from the addon root: lua5.1 tests/test_locales.lua
--
-- Checks the translations in locale/ against the code that uses them:
--  - locale_handler.lua: the game-locale table falls back to English for
--    anything it doesn't translate, `true` means "the key is the text", and
--    NewLocale only hands out a table for enUS and the client's own locale
--  - every locale file loads, and every key it translates exists in
--    locale-enUS.lua (a key only a translation has is a typo, or text the
--    code no longer shows)
--  - every literal L["..."] key the addon's code looks up exists in
--    locale-enUS.lua; a missing one prints "There's a missing locale" in
--    the player's chat frame

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

local LOCALES = { "deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ptPT", "ruRU", "zhCN", "zhTW" }

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
-- table instead of the real locale.
local function keysOf(file)
	local keys = {}
	local recorder = setmetatable({}, { __newindex = function(_, key) keys[key] = true end })
	assert(loadfile(file))("DiabolicUI", { NewLocale = function() return recorder end })
	return keys
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

os.exit(lu.LuaUnit.run())
