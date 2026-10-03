local ADDON, Engine = ...
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- This is a general config meant to streamline 
-- the look of UI elements used by multiple modules.
-- 
-- Example (shows a popup with the style created here):
-- 		local PopUpMessage = Engine:GetHandler("PopUpMessage") -- get the popup handler
-- 		PopUpMessage:RegisterPopUp("MY_POP", popup_table) -- register a virtual popup
-- 		PopUpMessage:ShowPopUp("MY_POP", Engine:GetDB("UI").popup) -- show the popup with this visual style
local config = {
	coin = {
		gold_texture = path .. [[textures\DiabolicUI_Coins_32x32.tga]],
		gold_texcoord = { 0/64, 32/64, 0/64, 32/64 }, 
		gold_size = { 16, 16 },
		
		silver_texture = path .. [[textures\DiabolicUI_Coins_32x32.tga]],
		silver_texcoord = { 32/64, 64/64, 0/64, 32/64 }, 
		silver_size = { 16, 16 },

		copper_texture = path .. [[textures\DiabolicUI_Coins_32x32.tga]],
		copper_texcoord = { 0/64, 32/64, 32/64, 64/64 }, 
		copper_size = { 16, 16 },
		
		price_offsetY = -1, -- value added to the Y coordinate of numbers following text, to align
		coin_offset = { 2, -4 }, -- x,y values added to the position of the coin textures to align them properly
		coin_padding = 4
	},
	menubutton = {
		size = { 300, 51 },
		normalFont= DiabolicFont_HeaderRegular18Title,
		highlightFont = DiabolicFont_HeaderRegular18Highlight,
		pushedFont = DiabolicFont_HeaderRegular18Highlight,
		texture_size = { 512, 128 },
		texture = {
			normal = path .. [[textures\DiabolicUI_UIButton_300x51_Normal.tga]],
			highlight = path .. [[textures\DiabolicUI_UIButton_300x51_Highlight.tga]],
			pushed = path .. [[textures\DiabolicUI_UIButton_300x51_Pushed.tga]]
		}
	},
	popup = {
		minwidth = 420,
		maxwidth = 687 + 40,
		padding = 5,
		insets = { 6, 6, 6, 6 }, -- left, right, top, bottom
		backdrop = {
			bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
			edgeFile = path .. [[textures\DiabolicUI_Tooltip_Border.tga]],
			edgeSize = 32,
			tile = false,
			tileSize = 0,
			insets = {
				left = 23,
				right = 23,
				top = 23,
				bottom = 23
			}
		},
		backdropColor = { 0, 0, 0, .75 },
		backdropBorderColor = { 1, 1, 1, 1 },
		header = {
			insets = { 29, 29, 29, 29 },
			height = 40, 
			backdrop = {
				bgFile = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]],
				edgeFile = path .. [[textures\DiabolicUI_Tooltip_Header.tga]],
				edgeSize = 32,
				insets = {
					left = 3,
					right = 3,
					top = 3,
					bottom = 3
				}
			},
			backdropColor = { 0, 0, 0, .5 },
			backdropBorderColor = { 1, 1, 1, 1 },
			title = {
				normalFont = DiabolicFont_HeaderRegular18Title
			}
		},
		body = {
			insets = { 29, 29, 29, 29 },
			backdrop = {
				bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
				edgeFile = path .. [[textures\DiabolicUI_Tooltip_Body.tga]],
				edgeSize = 32,
				insets = {
					left = 3,
					right = 3,
					top = 2,
					bottom = 2
				}
			},
			backdropColor = { 0, 0, 0, 0 },
			backdropBorderColor = { 71/255 *3.5, 56/255 *3.5, 28/255 *3.5, 1 },
			message = {
				insets = { 15, 15, 15, 15 },
				normalFont = DiabolicFont_SansRegular14,
				fontColor = { 240/255, 240/255, 240/255 } -- { 255/255, 234/255, 137/255 }
			},
			input = {
				backdrop = {
					bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
					edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
					edgeSize = 1,
					tile = false,
					tileSize = 0,
					insets = {
						left = -6,
						right = -6,
						top = 0,
						bottom = 0
					}
				},
				backdropColor = { 0, 0, 0, 0 },
				backdropBorderColor = { .15, .1, .05, 1 }
			}
		},
		footer = {
			button_spacing = 29, -- horizontal space between buttons, if multiple
			insets = { 28, 28, 28, 28 }, -- left, right, top, bottom
			backdrop = {
				bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
				edgeFile = path .. [[textures\DiabolicUI_Tooltip_Footer.tga]],
				edgeSize = 16,
				insets = {
					left = 3,
					right = 3,
					top = 3,
					bottom = 3
				}
			},
			backdropColor = { 0, 0, 0, 0 },
			backdropBorderColor = { 1, 1, 1, 1 },
			button = {
				size = { 193, 55 },
				insets = { 19, 19, 12, 12 }, -- left, right, top, bottom
				normalFont = DiabolicFont_SansRegular14,
				fontColor = {
					normal = { 255/255, 234/255, 137/255 },
					highlight = { 255/255, 255/255, 255/255 }, 
					pushed = { 255/255, 255/255, 255/255 }
				},
				backdrop = {
					bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
					edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
					edgeSize = 1,
					tile = false,
					tileSize = 0,
					insets = {
						left = -1,
						right = -1,
						top = -1,
						bottom = -1
					}
				},
				backdropColor = { 0, 0, 0, .25 },
				backdropBorderColor = { .20, .125, .075, 1 },
				backdropColor_hover = { .25, .2, .15, .25 },
				backdropBorderColor_hover = { .5, .4, .3, 1 },
				texture_size = { 256, 128 },
				texture = {
					normal = path .. [[textures\DiabolicUI_UIButton_193x55_Normal.tga]],
					highlight = path .. [[textures\DiabolicUI_UIButton_193x55_Highlight.tga]],
					pushed = path .. [[textures\DiabolicUI_UIButton_193x55_Pushed.tga]]
				}
				
			}
		}
	}
}

Engine:NewStaticConfig("UI", config)
