-- User settings for the styling of other addons and Blizzard frames (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("AddOnSkins", {
	styleTrinketMenu = true, -- TrinketMenu's buttons in the action bars' style, without its backgrounds
	styleQuestieTracker = true -- Questie's tracker in the fonts and colors of Blizzard's
})
