-- User settings for Blizzard's windows in Diablo III's look (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("Windows", {
	enableSkin = true -- character, spellbook, quest log and the other windows (modules/blizzard/windows.lua and its skins); Blizzard's own otherwise
})
