-- Static layout, textures and colors for the nameplates ("NamePlates").
local ADDON, Engine = ...
local C = Engine:GetDB("Data: Colors")
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- The plate is the focus frame's border (settings/unitframes.lua): its
-- health bar in the border's top slot, its name above the border's art,
-- the cast bar under it.
Engine:NewStaticConfig("NamePlates", {
	size = { 90, 17 },
	widgets = {
		health = {
			size = { 82, 9 },
			place = { "BOTTOM", 0, 7 },
			value = {
				place = { "BOTTOM", 0, 9 + 16 },
				fontObject = DiabolicFont_HeaderRegular12, -- the unit frames' names' Exocet
				color = { C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3] }
			}
		},
		-- in the same border, under the health's: the border's art reaches
		-- 14 above and 17 under the frame, 31 to each side
		cast = {
			size = { 90, 17 },
			place = { "TOP", 0, -(17 + 17 + 14 + 2) },
			color = { .5, .5, 1 },
			bar = {
				size = { 82, 9 },
				place = { "BOTTOM", 0, 7 }
			},
			icon = {
				size = { 18, 18 },
				place = { "RIGHT", "LEFT", -(31 + 4 - 4), 2 } -- { point, the frame's point, x, y }
			},
			value = {
				place = { "LEFT", "RIGHT", 31 + 4 - 4, 2 }, -- { point, the frame's point, x, y }
				fontObject = DiabolicFont_SansBold10
			},
			name = {
				place = { "TOP", 0, -(1 + 17 + 4) },
				fontObject = DiabolicFont_SansBold10,
				color = { C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3] }
			},
		},
		-- yours (auras.lua), a row over the name and the cast's name, in the
		-- unit frames' aura look (settings/unitframes.lua, the target's)
		auras = {
			size = { 22, 22 },
			spacing = 4,
			max = 6,
			place = { "BOTTOM", 0, 7 + 9 + 16 + 14 },
			color = { (C.Status.Dead[1]/3 + .3)*.7, (C.Status.Dead[2]/3 + .3)*.7, (C.Status.Dead[3]/3 + .3)*.7 },
			border = {
				bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
				edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
				edgeSize = 1,
				insets = { left = 0, right = 0, top = 0, bottom = 0 }
			},
			glow = {
				edgeFile = path .. [[textures\DiabolicUI_GlowBorder_128x16.tga]],
				edgeSize = 4,
				insets = { left = 0, right = 0, top = 0, bottom = 0 }
			},
			shade = path .. [[textures\DiabolicUI_Shade_64x64.tga]],
			timeFont = DiabolicFont_SansBold10,
			countFont = DiabolicFont_SansBold10
		}
	},
	textures = {
		-- the focus frame's, around the plate
		border = {
			size = { 256, 64 },
			position = { "TOPLEFT", -83, 24 },
			backdrop = path .. [[textures\DiabolicUI_Target_80x15_Backdrop.tga]],
			normal = path .. [[textures\DiabolicUI_Target_80x15_Border.tga]],
			highlight = path .. [[textures\DiabolicUI_Target_80x15_Highlight.tga]],
			glow = path .. [[textures\DiabolicUI_Target_80x15_Glow.tga]]
		},
		bar_glow = {
			size = { 128 + 16, 32 },
			position = { "TOP", 0, 12 }, -- TOPLEFT, -32, 12
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Glow_Warcraft.tga]]
		},
		bar_backdrop = {
			size = { 64 + 8, 8 },
			position = { "TOPLEFT", 0, 0 },
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Backdrop_Warcraft.tga]]
		},
		bar_texture = {
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Normal_Warcraft.tga]]
		},
		bar_overlay = {
			size = { 64 + 8, 8 },
			position = { "TOPLEFT", 0, 0 },
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Overlay_Warcraft.tga]]
		}
	}
})

