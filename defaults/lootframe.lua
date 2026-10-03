-- User settings for the custom loot window (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("LootFrame", {
	enableSkin = false -- re-skins the loot window to match the rest of the UI; uses Blizzard's own loot window otherwise
})
