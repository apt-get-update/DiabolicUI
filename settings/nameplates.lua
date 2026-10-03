-- Static layout, textures and colors for the nameplates ("NamePlates").
local ADDON, Engine = ...
local C = Engine:GetDB("Data: Colors")
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

Engine:NewStaticConfig("NamePlates", {
	size = { 72, 20 },
	widgets = {
		health = {
			size = { 72, 8 },
			place = { "TOPLEFT", 0, 0 },
			value = {
				place = { "BOTTOM", 0, 8+6 },
				fontObject = DiabolicFont_SansBold10,
				color = { C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3] }
			}
		},
		cast = {
			size = { 72, 8 },
			place = { "TOPLEFT", 0, -12 },
			color = { .5, .5, 1 }, 
			name = {
				place = { "BOTTOM", 0, 38 },
				fontObject = DiabolicFont_SansBold10,
				color = { C.General.Prefix[1], C.General.Prefix[2], C.General.Prefix[3] }
			},
		}
	},
	textures = {
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

