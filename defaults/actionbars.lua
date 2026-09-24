-- User settings for the action bars (saved per profile in DiabolicUI_DB).
local ADDON, Engine = ...

Engine:NewConfig("ActionBars", {
	num_bars = 1, -- UnitLevel("player") < 80 and 1 or 2, -- number of main/bottom bars (1-3)
	num_side_bars = 0, -- number of side bars (0-2)
	cast_on_down = 0, -- this setting is only used for WotLK
	showGold = true,
	showPerformance = false
})
