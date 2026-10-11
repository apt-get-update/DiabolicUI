-- User settings for the styling of other addons and Blizzard frames (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("AddOnSkins", {
	styleTrinketMenu = true, -- TrinketMenu's buttons in the action bars' style, its menu in the tooltips'
	styleWorldMap = true, -- the world map's zone names in Exocet
	styleTracker = true -- Blizzard's objectives tracker in DiabolicUI's fonts and colors
})
