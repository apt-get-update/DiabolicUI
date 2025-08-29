local ADDON, Engine = ...
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- chat windows and frames
Engine:NewStaticConfig("ChatWindows", {
	size = { 375, 228 }, -- Diablo 3 uses a large 308 height window, but that's too big for WoW, so we shrink it a bit. 
	--size = { 475, 308 }, -- 440, 136 
	minimum_size = { 330, 136 }, -- was 120, but need more to fit the buttons! 
	position = { "BOTTOMLEFT", "UICenter", "BOTTOMLEFT", (13 + 36 + 2), 0 },
	position2 = { "BOTTOMRIGHT", "UICenter", "BOTTOMRIGHT", -(13 + 36 + 2), (125 + 36 + 3) }, -- not really used
	clamps = { -(13 + 36 + 2), -(13 + 36 + 2), -13, -(20 + 36 + 3) }, -- required padding to screen edges (with room for buttons and inputbox)
	fade = true, 
	time_visible = UnitName("player") == "Goldpaw" and 15 or 25, 
	button_frame = {
		size = 36,
		position = { "BOTTOMLEFT", -(36 + 2), 0 }, -- not used?
		padding = 0, -- vertical padding between buttons 
		slider = {
			size = 36,
			thumb = {
				size = { 22, 36 },
				textures = {
					normal = path .. [[textures\DiabolicUI_Slider_22x36_Thumb.tga]],
					disabled = path .. [[textures\DiabolicUI_Slider_22x36_ThumbDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_Slider_22x36_ThumbHighlight.tga]]
				}
			}
		},
		buttons = {
			size = { 36, 36 },
			texture_size = { 64, 64 },
			texture_position = { "CENTER", 0, 0 },
			textures = {
				menu = {
					normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_ChatMenu.tga]],
					disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_ChatMenuDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_ChatButtons_36x36_ChatMenuHighlight.tga]]
				},
				minimize = {
					normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Minimize.tga]],
					disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_MinimizeDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_ChatButtons_36x36_MinimizeHighlight.tga]]
				},
				maximize = {
					normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Maximize.tga]],
					disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_MaximizeDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_ChatButtons_36x36_MaximizeHighlight.tga]]
				},
				up = {
					normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Up.tga]],
					disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_UpDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_ChatButtons_36x36_UpHighlight.tga]]
				},
				down = {
					normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Down.tga]],
					disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_DownDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_ChatButtons_36x36_DownHighlight.tga]]
				},
				bottom = {
					normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Bottom.tga]],
					disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_BottomDisabled.tga]],
					highlight = path .. [[textures\DiabolicUI_ChatButtons_36x36_BottomHighlight.tga]]
				}
			}
		}
	},
	editbox = {
		size = 34, -- height of the editbox frame
		offsets = { 1, 1, 4 + 7, 4 + 7 }, -- offset from editbox to surrounding content. 
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
		glow = {
			offsets = { 4, 4, 4, 4 },
			backdrop = {
				bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
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
		-- this is just added as decoration, to match d3
		icon = {
			size = { 36, 36 },
			position = {
				left = { "TOPLEFT", -(36 + 3), 1 }, -- align it with our border, not the frame
				right = { "TOPRIGHT", (36 + 3), 1}
			}, 
			texture_size = { 64, 64 },
			texture_position = { "CENTER", 0, 0 },
			texture = path .. [[textures\DiabolicUI_ChatButtons_36x36_ChatIcon.tga]]
		},
		colors = {
			backdrop = { 0, 0, 0, .5 },
			border = { 0, 0, 0, .2 }, -- comes on top of the backdrop, so we don't need a high alpha value here
			glow = { 0, 0, 0, .5 },
			shade = { 0, 0, 0, .7 }
		}
	},
	tab = {
		
	}
	--clamps = { -40, -40, -40, -220 },
	--position = { "BOTTOMLEFT", UICenter, "BOTTOMLEFT", 0, 0 },
})

-- chat filters and emoticons
Engine:NewStaticConfig("ChatFilters", {
	useCustomClassColors = true
})

-- chat bubbles
Engine:NewStaticConfig("ChatBubbles", {})

-- chat sounds
Engine:NewStaticConfig("ChatSounds", {})
