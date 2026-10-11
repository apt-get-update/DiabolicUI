-- User settings for the action bars (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("ActionBars", {
	num_bars = 1, -- UnitLevel("player") < 80 and 1 or 2, -- number of main/bottom bars (1-3)
	num_side_bars = 0, -- number of side bars (0-2)
	cast_on_down = 0, -- this setting is only used for WotLK
	showGold = true,
	showPerformance = false,
	showSpecSwitch = true, -- the talent specialization switch on top of the skull
	-- what runs after switching to the primary (1) or secondary (2)
	-- specialization; false leaves it as it is
	specEquipSet1 = false, -- an equipment set's name
	specEquipSet2 = false,
	specProfile1 = false, -- an Action Bar Saver profile's name
	specProfile2 = false,
	specBars1 = false, -- num_bars (1-3)
	specBars2 = false,
	specSideBars1 = false, -- num_side_bars (0-2)
	specSideBars2 = false,
	specMacroBefore1 = false, -- a macro's name, run by the button's click that switches
	specMacroBefore2 = false,
	specMacroName1 = false, -- a macro's name, run by a click on the button after the switch
	specMacroName2 = false
})
