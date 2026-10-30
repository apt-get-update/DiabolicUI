-- User settings for the spellbook (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("Spellbook", {
	showAllRanks = false, -- the "Show all spell ranks" box, put back at login (the game's own setting doesn't keep it)
	showUnassigned = true -- our box: the spells on no action bar ringed
})
