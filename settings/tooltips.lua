-- Static styling for tooltips and their health bars ("Tooltips").
local Addon, Engine = ...
local path = ([[Interface\AddOns\%s\media\]]):format(Addon)

Engine:NewStaticConfig("Tooltips", {
	place = { "BOTTOMRIGHT", "UICenter", "BOTTOMRIGHT", -38, 105 },
	border = {
		offsets = { 8, 8, 8, 12 },
		backdrop = {
			bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
			edgeFile = path .. [[textures\DiabolicUI_Tooltip_Small.tga]],
			edgeSize = 32,
			tile = false,
			tileSize = 0,
			insets = {
				left = 6,
				right = 6,
				top = 6,
				bottom = 6
			}
		},
		backdrop_color = { 0, 0, 0, .95 }, -- just very slightly transparent
		backdrop_border_color = { 1, 1, 1, 1 } 
	},
	statusbar = {
		size = 3, -- the height of the bar, the width adjusts itself to the tooltip
		offsets = { -2, -2, 0, 3 }, -- make the bar align to the backdrop border edges
		texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
	}

})
