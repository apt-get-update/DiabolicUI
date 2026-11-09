-- User settings for other addons (saved account wide in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("AddOnConflicts", {
	kept = {}, -- [addon] = true: asked once, and the player kept it
})
