-- User settings for tooltip placement (saved per profile in DiabolicUI_DB).
local ADDON, Engine = ...

Engine:NewConfig("Tooltips", {
	offsetX = 0, -- horizontal offset from the cursor, in pixels
	offsetY = 15, -- vertical offset from the cursor, in pixels
	anchorPoint = "BOTTOM" -- which point on the tooltip the cursor (plus offset) is anchored to
})
