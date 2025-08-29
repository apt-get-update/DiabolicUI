local ADDON, Engine = ...
local C = Engine:GetDB("Data: Colors")
local BLANK_TEXTURE = Engine:GetConstant("BLANK_TEXTURE")
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- Lua API
local math_ceil = math.ceil

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
			icon = {

			}
		},
		cc = {
			size = { 48, 48 },
			place = { "TOP", 0, 74 },
			glow = {
				size = { 60, 60 },
				place = { "CENTER", .5, -.25 }, 
				backdrop = {
					bgFile = nil, 
					edgeFile = path .. [[textures\DiabolicUI_GlowBorder_128x16.tga]],
					edgeSize = 8,
					tile = false,
					tileSize = 0,
					insets = {
						left = 0,
						right = 0,
						top = 0,
						bottom = 0
					}
				},
				borderColor = { C.General.DarkRed[1], C.General.DarkRed[2], C.General.DarkRed[3], .75 }
			},
			icon = {
				size = { 44, 44 }, 
				place = { "CENTER", 0, 0 }, 
				texCoord = { 5/64, 59/64, 5/64, 59/64 },
				shade = {
					size = { 44, 44 },
					place = { "CENTER", 0, 0 }, 
					color = { 0, 0, 0, .5 }, 
					path = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
				},
			},
			border = {
				size = { 48, 48 },
				place = { "CENTER", 0, 0 }, 
				backdrop = {
					bgFile = nil, 
					edgeFile = BLANK_TEXTURE,
					edgeSize = 1,
					tile = false,
					tileSize = 0,
					insets = {
						left = 0,
						right = 0,
						top = 0,
						bottom = 0
					}
				},
				borderColor = { C.General.DimRed[1], C.General.DimRed[2], C.General.DimRed[3], 1 }
			},
			time = {
				place = { "TOPLEFT", 4, -4 }, 
				fontObject = DiabolicFont_SansBold18,
				shadowOffset = { 1.25, -1.25 },
				shadowColor = { 0, 0, 0, 1 }
			},
			count = {
				place = { "BOTTOMRIGHT", -1, 1 }, 
				fontObject = DiabolicFont_SansBold12,
				shadowOffset = { 1.25, -1.25 },
				shadowColor = { 0, 0, 0, 1 }
			}
		},
		auras = {
			place = { "BOTTOM", 0, -(4 + 28) }, -- below the frame
			--place = { "TOP", 0, 4 + 12 + 4 + 28 }, -- above the name
			rowsize = math_ceil((64 + 8 + 4)/(28 + 2)), -- maximum number of auras per row
			padding = 2, -- space between auras
			button = {
				size = { 28, 28 },
				--anchor = "BOTTOMLEFT", 
				anchor = "TOPLEFT", 
				growthY = -1,
				growthX = 1,
				backdrop = {
					bgFile = BLANK_TEXTURE,
					edgeFile = BLANK_TEXTURE,
					edgeSize = 1,
					insets = { 
						left = -1, 
						right = -1, 
						top = -1, 
						bottom = -1
					}
				},
				icon = {
					size = { 22, 22 }, -- should be main size - 6
					texCoord = { 5/64, 59/64, 5/64, 59/64 },
					place = { "TOPLEFT", 2, -2 }, -- relative to the scaffold, which is 1px inset into the button
					shade = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
				},
				time = {
					place = { "TOPLEFT", 1, -1 }, 
					fontObject = DiabolicFont_SansBold10,
					fontStyle = "THINOUTLINE",
					fontSize = 9,
					shadowOffset = { 1.25, -1.25 },
					shadowColor = { 0, 0, 0, 1 }
				},
				count = {
					place = { "BOTTOMRIGHT", -1, 1 }, 
					fontObject = DiabolicFont_SansBold12,
					fontStyle = "THINOUTLINE",
					fontSize = 9,
					shadowOffset = { 1.25, -1.25 },
					shadowColor = { 0, 0, 0, 1 }
				}
			}
		},
	},
	textures = {
		bar_shade = {
			size = { 128 + 16, 32 },
			position = { "CENTER", 0, 4 },
			color = { 0, 0, 0, .5 },
			path = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
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
			size = { 64 + 8, 8 },
			position = { "TOPLEFT", 0, 0 },
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Normal_Warcraft.tga]]
		},
		bar_overlay = {
			size = { 64 + 8, 8 },
			position = { "TOPLEFT", 0, 0 },
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Overlay_Warcraft.tga]]
		},
		bar_threat = {
			size = { 64 + 8, 8 },
			position = { "TOPLEFT", 0, 0 },
			path = path .. [[statusbars\DiabolicUI_StatusBar_64x8_Threat_Warcraft.tga]]
		}
	}
})

