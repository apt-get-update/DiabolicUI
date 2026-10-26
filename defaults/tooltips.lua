-- User settings for tooltip placement (saved per profile in DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("Tooltips", {
	offsetX = 0, -- horizontal offset from the cursor, in pixels
	offsetY = 15, -- vertical offset from the cursor, in pixels
	anchorPoint = "BOTTOM", -- which point on the tooltip the cursor (plus offset) is anchored to
	reskinTooltip = true -- Diablo III style item and ability tooltips (modules/blizzard/itemtooltips.lua, spelltooltips.lua)
})
