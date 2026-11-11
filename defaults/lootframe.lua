-- User settings for the custom loot window (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("LootFrame", {
	rollWindow = false, -- off until tried in a raid: a window to roll for what the master looter puts up (modules/blizzard/rollwindow.lua)
})
