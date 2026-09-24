-- User settings for the quest tracker fade (saved per profile in DiabolicUI_DB).
local Addon, Engine = ...

Engine:NewConfig("ObjectiveTracker", {
	fadeTracker = false, -- fade the quest tracker (Questie's if in use, else Blizzard's) out when it hasn't been moused over for a while
	fadeDelay = 3, -- seconds the tracker stays fully visible before it starts fading, 1-30
	fadeOpacity = 25 -- opacity (%) the tracker fades down to, 0-100
})
