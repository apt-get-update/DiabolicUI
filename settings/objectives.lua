local ADDON, Engine = ...
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

Engine:NewStaticConfig("Objectives", {
	capturebar = {
		position = { "TOP", "UICenter", "TOP", 0, -300 }, 
		size = { 195, 13 + 2 }, -- bar size
		padding = 50, 
		
		backdrop_texture = path .. [[textures\DiabolicUI_Target_227x15_Backdrop.tga]],
		backdrop_size = { math.floor(512 * (195/227)) + 2, 64 }, -- crazy math to shrink a too wide backdrop to this

		statusbar_texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]],

		texture = path .. [[textures\DiabolicUI_Target_195x13_Border.tga]],
		texture_size = { 512, 64 },
		texture_position = { "TOP", 0, 25 },

		spark_size = { 128, 13 + 2 },
		spark_texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_Spark_Warcraft.tga]]

	},

	-- Our own custom quest and objectives tracker. 
	-- As most other things this is a work in progress, 
	-- and elements will be added as they are created. 
	tracker = {
		size = {},
		points = {
			-- New layout that doesn't require the old MINIMAP_SIZE constant, 
			-- and instead relies on the Minimap and UICenter keywords. 
			-- Alignment is only done relative to the bottom of the Minimap 
			-- and the right side of the UICenter, so different Minimap sizes 
			-- should only affect the top anchor of the tracker, not the width.
			{ "TOP", "Minimap", "BOTTOM", 0, -30 },
			{ "RIGHT", "UICenter", "RIGHT", -21.5, 0 },
			{ "LEFT", "UICenter", "RIGHT", -293, 0 },
			{ "BOTTOM", "UICenter", "BOTTOM", 0, 220 }
		},
		header = {
			height = 25,
			points = {
				{ "TOPLEFT", 0, 0 },
				{ "TOPRIGHT", -20, 0 } -- keeping it centered relative to the Minimap 
			},
			title = {
				position = { "LEFT", 0, 0 },
				positionMinimized = { "CENTER", 0, 0 },
				normalFont = DiabolicFont_HeaderRegular16White
			},
			button = {
				size = { 22, 21 },
				position = { "RIGHT", -4, 0 },
				textureSize = { 32, 32 },
				texturePosition = { "CENTER", 0, 0 }, 
				textures = {
					enabled = path .. [[textures\DiabolicUI_ExpandCollapseButton_22x21.tga]],
					disabled = path .. [[textures\DiabolicUI_ExpandCollapseButton_22x21_Disabled.tga]]
				},
				texcoords = {
					maximized = { 0/64, 32/64, 0/64, 32/64 },
					minimized = { 0/64, 32/64, 32/64, 64/64 },
					maximizedHighlight = { 32/64, 64/64, 0/64, 32/64 },
					minimizedHighlight = { 32/64, 64/64, 32/64, 64/64 },
					disabled = { 0, 1, 0, 1 }
				}
			}
		},
		body = {
			margins = {
				left = 0, 
				right = 0,
				top = -2,
				bottom = 0
			},
			entry = {
				topMargin = 16,

				-- Flashing message ("NEW!", "UPDATE!", "COMPLET!" and so on)
				flash = {
					height = 18,
					normalFont = DiabolicFont_HeaderRegular18Text
				},
				-- Quest/Objective titles
				title = {
					height = 12,
					maxLines = 6,
					lineSpacing = 7,
					leftMargin = 0, 
					rightMargin = 0, -- 56, -- space for quest items
					normalFont = DiabolicFont_HeaderBold12Title
				},
				item = {
					size = { 26, 26 },
					glow = {
						size = { 36, 36 },
						backdrop = {
							bgFile = nil, 
							edgeFile = path .. [[textures\DiabolicUI_GlowBorder_128x16.tga]],
							edgeSize = 4,
							tile = false,
							tileSize = 0,
							insets = {
								left = 0,
								right = 0,
								top = 0,
								bottom = 0
							}
						}
					},	
					border = {
						size = { 30, 30 }
					},
					icon = {
						size = { 26, 26 }
					},
					shade = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
				},
				-- Objectives (e.g "Kill many wolves: 0/many")
				objective = {
					topOffset = 10, -- offset of first objective from title
					height = 12,
					maxLines = 6,
					lineSpacing = 4,
					leftMargin = 30, -- 30, -- space for dots
					rightMargin = 0, 
					topMargin = 6, -- margin before every objective
					bottomMargin = 12, -- margin after ALL objectives are listed
					dotAdjust = -1,
					normalFont = DiabolicFont_SansRegular12White
				},
				-- Completed quest (e.g "Return to some NPC at some place")
				-- This has pretty much the same settings as the objectives, 
				-- but we separate them since I intend to upgrade it later.
				complete = {
					topOffset = 10,
					height = 12,
					maxLines = 6,
					lineSpacing = 4,
					leftMargin = 30, -- space for dots
					rightMargin = 0, 
					topMargin = 6,
					bottomMargin = 0, -- something else is being added, can't seem to figure out what :S 
					dotAdjust = -1,
					normalFont = DiabolicFont_SansRegular12White
				}
			}
		}
	}, 

	-- This will contain both current pvp objectives (flags, timers, points, etc), 
	-- waves of enemies in dungeons and raid instances, 
	-- as well as class order hall information. 
	zoneinfo = {
		orderhall = {

		},
		worldstate = {
			size = { 200, 32 },
			place = { "TOP", "UICENTER", "TOP", 0, -300 }, -- can't be there, just for testing
			height = 24, -- custom frameheight for each worldstate item. not implemented from here yet.
			texPath = path .. [[textures\DiabolicUI_Texture_32x32_WorldStateGrid_Warcraft.tga]],
			texSize = { 32, 32 },
			texHitRects = { 4, 4, 4, 4 }, -- custom hitrects for icons
			texCoords = {
				alliance 		= {   0/128,  32/128,   0/128,  32/128 }, 
				horde 			= {  32/128,  64/128,   0/128,  32/128 }, 
				allianceflag 	= {  64/128,  96/128,   0/128,  32/128 }, 
				hordeflag 		= {  96/128, 128/128,   0/128,  32/128 }, 
				alliancetower 	= {   0/128,  32/128,  32/128,  64/128 }, 
				hordetower 		= {  32/128,  64/128,  32/128,  64/128 }, 
				neutraltower 	= {  64/128,  96/128,  32/128,  64/128 }
			}
		}
	}
	
})
