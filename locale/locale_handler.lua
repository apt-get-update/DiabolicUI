-- Translations: locale-enUS.lua fills in the English texts, and the file of
-- the client's own locale (if there is one) its translations. Code reads
-- them all through Engine:GetLocale(). In both, `L[key] = true` means the
-- text is the key itself.
local _, Engine = ...

-- Lua API
local rawset, rawget = rawset, rawget

local gameLocale = GetLocale() -- current game client locale
local fallbackLocale = "enUS" -- fallback language for the UI if no translation is present

local store = function(self, key, value)
	rawset(self, key, (value == true) and key or value)
end

-- the English texts
local L_fallback = setmetatable({}, { __newindex = store })

-- the client's own locale, English where it has no translation
local L = setmetatable({}, {
	__newindex = store,
	__index = function(self, key)
		local value = rawget(L_fallback, key)
		if (not value) then
			print("Tell Goldpaw! There's a missing locale: ", key)
		end
		return value or key
	end
})

-- The table a locale file fills in: English's, the client's own, or none
-- (a locale the client isn't in).
Engine.NewLocale = function(self, locale)
	if locale == fallbackLocale then
		return L_fallback
	elseif locale == gameLocale then
		return L
	end
end

-- Proxy function to get the game locale,
-- allows us to override the locale for testing.
Engine.GetGameLocale = function(self)
	return gameLocale
end

-- Get the currently active locale
Engine.GetLocale = function(self)
	return L
end
