local ADDON, Engine = ...
local C = Engine:GetDB("Data: Colors")
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- Lua API
local math_floor = math.floor

local BUTTON_SIZE_VEHICLE = Engine:GetConstant("BUTTON_SIZE_VEHICLE") -- button size with a vehicle UI
local BUTTON_SIZE_SINGLE = Engine:GetConstant("BUTTON_SIZE_SINGLE") -- button size with a single action bar
local BUTTON_SIZE_DOUBLE = Engine:GetConstant("BUTTON_SIZE_DOUBLE") -- button size with two action bars
local BUTTON_SIZE_TRIPLE = Engine:GetConstant("BUTTON_SIZE_TRIPLE") -- button size with three action bars

local NUM_ACTIONBAR_SLOTS = Engine:GetConstant("NUM_ACTIONBAR_SLOTS") -- number of buttons on a standard bar
local NUM_PET_SLOTS = Engine:GetConstant("NUM_PET_SLOTS") -- number of pet buttons
local NUM_POSSESS_SLOTS = Engine:GetConstant("NUM_POSSESS_SLOTS") -- number of possess buttons
local NUM_STANCE_SLOTS = Engine:GetConstant("NUM_STANCE_SLOTS") -- number of stance buttons
local NUM_VEHICLE_SLOTS = Engine:GetConstant("NUM_VEHICLE_SLOTS") -- number of vehicle buttons

local padding, bar_padding = 2, 4 -- for the auras
local petOffset = 10 + BUTTON_SIZE_TRIPLE - 3 -- copied from 'petskulloffset' in the actionbar settings

local orbOffsetX, orbOffsetY = 0, 0 -- -4

Engine:NewStaticConfig("UnitFrames", {
	structure = {
		
	},
	visuals = {
		-- artwork is attached to the actionbar module's "Controller: Main" widget's frame
		artwork = {
			health = {
				shade = {
					size = { 256, 256 },
					position = { "BOTTOMLEFT", orbOffsetX + -256 + (256 - 160)/2 -8, orbOffsetY + -(256 - 160)/2 -6},
					texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Backdrop.tga]],
					color = { 0, 0, 0, 1 }
				},
				overlay = {
					size = { 256, 256 },
					position = { "BOTTOMLEFT", orbOffsetX + -256 + (256 - 160)/2 -8, orbOffsetY + -(256 - 160)/2 -6},
					texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Border.tga]],
					color = { 1, 1, 1, 1 }
				}
			},
			power = {
				shade = {
					size = { 256, 256 },
					position = { "BOTTOMRIGHT", -orbOffsetX + 256 - (256 - 160)/2 +8, orbOffsetY + -(256 - 160)/2 -6},
					texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Backdrop.tga]],
					color = { 0, 0, 0, 1 }
				},
				overlay = {
					size = { 256, 256 },
					position = { "BOTTOMRIGHT", -orbOffsetX + 256 - (256 - 160)/2 +8, orbOffsetY + -(256 - 160)/2 -6},
					texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Border.tga]],
					color = { 1, 1, 1, 1 }
				}
			}
		},
		units = {
			player = {
				classpower = {
					position = { "BOTTOM", "Main", "TOP", 0, 210 + 20 + 15 + 20 }, -- above castbar? 
					point = {
						texture = path .. [[textures\DiabolicUI_Runes.tga]], -- only one texture here
						size = { 70, 70 },
						padding = 0, 
					}
				},
				altpower = {
					size = { 227, 15 },
					position = { "BOTTOM", "Main", "TOP", 0, 210 + 20 + 30 }, -- 0, 210
					positionPet = { "BOTTOM", "Main", "TOP", 0, 210 + 20 + 30 + petOffset }, 
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]],
					color = { .9, .3, .1 }, 
					value = {
						font_object = DiabolicFont_SansBold10,
						position = { "CENTER", 3.5, .5 }
					},
					spark = {
						size = { 128, 128 },
						texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_Spark_Warcraft.tga]],
						flash = { 2.75, 1.25, .45, .95 }
					},
					shade = {
						position = { "CENTER", 0, 0 },
						color = { 0, 0, 0, .5 },
						texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
					},
					backdrop = {
						size = { 512, 64 },
						position =  { "TOPLEFT", -142, 25 },
						texture = path .. [[textures\DiabolicUI_Target_227x15_Backdrop.tga]]
					},
					border = {
						size = { 512, 64 },
						position =  { "TOPLEFT", -142, 25 },
						texture = path .. [[textures\DiabolicUI_Target_227x15_Border.tga]]
					}
				},
				castbar = {
					size = { 227, 15 },
					position = { "BOTTOM", "Main", "TOP", 0, 210 + 20 }, -- 0, 210
					positionPet = { "BOTTOM", "Main", "TOP", 0, 210 + 20 + petOffset }, 
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]],
					color = { .4, .4, .9 }, 
					safezone = {
						delay = {
							font_object = DiabolicFont_SansBold8,
							position = { "BOTTOMRIGHT", -4.5, 1.5 }
						}
					},
					name = {
						font_object = DiabolicFont_HeaderRegular16White,
						position = { "BOTTOM", .5, -30.5 }
					},
					value = {
						font_object = DiabolicFont_SansBold10,
						position = { "CENTER", 3.5, .5 }
					},
					icon = {
						
					},
					spark = {
						size = { 128, 128 },
						texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_Spark_Warcraft.tga]],
						flash = { 2.75, 1.25, .45, .95 }
					},
					shade = {
						position = { "CENTER", 0, 0 },
						color = { 0, 0, 0, .5 },
						texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
					},
					backdrop = {
						size = { 512, 64 },
						position =  { "TOPLEFT", -142, 25 },
						texture = path .. [[textures\DiabolicUI_Target_227x15_Backdrop.tga]]
					},
					border = {
						size = { 512, 64 },
						position =  { "TOPLEFT", -142, 25 },
						texture = path .. [[textures\DiabolicUI_Target_227x15_Border.tga]]
					}
				},
				auras = {
					position = { "TOPRIGHT", "Minimap", "TOPLEFT", -20, 0 }, 
					positionWithoutMinimap = { "TOPRIGHT", "UICenter", "TOPRIGHT", -30, -74 }, 
					size = { 200, 200 },
					spacingH = 4, 
					spacingV = 4, 
					button = {
						size = { 30, 30 },
						color = C.General.UIBorder,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				},
				buffs = {
					position = { "BOTTOMLEFT", "Main", "TOPLEFT", 26, 46 },
					positionPet = { "BOTTOMLEFT", "Main", "TOPLEFT", 26, 46 + petOffset },
					size = { 
						["1"] = { math_floor((BUTTON_SIZE_SINGLE*NUM_ACTIONBAR_SLOTS + bar_padding*(NUM_ACTIONBAR_SLOTS-1))/2) -(16 + 10), 38*2 + 8 + 3 + 2 },
						["2"] = { math_floor((BUTTON_SIZE_DOUBLE*NUM_ACTIONBAR_SLOTS + bar_padding*(NUM_ACTIONBAR_SLOTS-1))/2) -(16 + 10), 38*2 + 8 + 3 + 2 },
						["3"] = { math_floor((BUTTON_SIZE_TRIPLE*NUM_ACTIONBAR_SLOTS + bar_padding*(NUM_ACTIONBAR_SLOTS-1))/2) -(16  + 10), 38*2 + 8 + 3 + 2 },
						["vehicle"] = { math_floor((BUTTON_SIZE_VEHICLE*NUM_VEHICLE_SLOTS + bar_padding*(NUM_VEHICLE_SLOTS-1))/2) -(16 + 10), 38*2 + 8 + 3 + 2 }
					},
					spacingH = 4, 
					spacingV = 12, 
					button = {
						size = { 30, 30 },
						color = C.General.XP,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				},
				debuffs = {
					position = { "BOTTOMRIGHT", "Main", "TOPRIGHT", -26, 46 },
					positionPet = { "BOTTOMRIGHT", "Main", "TOPRIGHT", 26, 46 + petOffset },
					size = { 
						["1"] = { math_floor((BUTTON_SIZE_SINGLE*NUM_ACTIONBAR_SLOTS + bar_padding*(NUM_ACTIONBAR_SLOTS-1))/2) -(16 + 10), 38*2 + 8 + 3 + 2 },
						["2"] = { math_floor((BUTTON_SIZE_DOUBLE*NUM_ACTIONBAR_SLOTS + bar_padding*(NUM_ACTIONBAR_SLOTS-1))/2) -(16 + 10), 38*2 + 8 + 3 + 2 },
						["3"] = { math_floor((BUTTON_SIZE_TRIPLE*NUM_ACTIONBAR_SLOTS + bar_padding*(NUM_ACTIONBAR_SLOTS-1))/2) -(16  + 10), 38*2 + 8 + 3 + 2 },
						["vehicle"] = { math_floor((BUTTON_SIZE_VEHICLE*NUM_VEHICLE_SLOTS + bar_padding*(NUM_VEHICLE_SLOTS-1))/2) -(16 + 10), 38*2 + 8 + 3 + 2 }
					},
					spacingH = 4, 
					spacingV = 12, 
					button = {
						size = { 30, 30 },
						color = C.General.DarkRed,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				},
				left = {
					size = { 140, 140 }, 
					position = { "BOTTOMLEFT", "Main", "BOTTOMLEFT", orbOffsetX -140 + (140 - 160)/2 -8, orbOffsetY -(140 - 160)/2 -6 },
					health = {
						size = { 150, 150 },
						position = { "CENTER" },
						color = { 175/255, 17/255, 28/255 }, -- blood
						--color = { 138/255, 7/255, 7/255 }, -- blood
						spark = {
							size = { 128, 128 },
							overflow = 8,
							texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_SparkVertical_Warcraft.tga]],
							flash = { 2.75, 1.25, .45, .95 },
							flash_size = { 64, 16 },
							flash_texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
						},
						layers = {
							gradient = {
								alpha = .85,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Gradient.tga]]
							},
							moon = {
								alpha = .5,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Moon.tga]]
							},
							smoke = {
								alpha = .5,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Smoke.tga]]
							},
							shade = {
								alpha = .9,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Shade.tga]]
							}
						}
					}
				},
				right = {
					size = { 140, 140 },
					position = { "BOTTOMRIGHT", "Main", "BOTTOMRIGHT", orbOffsetX + 140 - (140 - 160)/2 +8, orbOffsetY -(140 - 160)/2 -6 },
					power = {
						size = { 150, 150 },
						position = { "CENTER" },
						color = { 37/255, 37/255, 198/255 },
						spark = {
							size = { 128, 128 },
							overflow = 8,
							texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_SparkVertical_Warcraft.tga]],
							flash = { 2.75, 1.25, .45, .95 },
							flash_size = { 64, 16 },
							flash_texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
						},
						separator = {
							size = { 256, 256 },
							position = { "CENTER", 0, 0 },
							texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Split.tga]]
						},
						layers = {
							gradient = {
								alpha = .85,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Gradient.tga]]
							},
							moon = {
								alpha = .75,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Moon.tga]]
							},
							smoke = {
								alpha = .5,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Smoke.tga]]
							},
							shade = {
								alpha = .75,
								texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Shade.tga]]
							}
						}
					}
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold10Title,
						position = { "TOP", .5, 24.5 }
					},
					power = {
						font_object = DiabolicFont_SansBold10Title,
						position = { "TOP", .5, 24.5 }
					}
				}
			},
			target = {
				size = { 346, 40 },
				position = { "TOP", "UICenter", "TOP", 0, -(66 + 3) },
				health = {
					size = { 305, 15 },
					position = { "TOP", 0, -3 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				power = { 
					size = { 274, 10 },
					position = { "TOP", 0, -(3 + 25) },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				name = {
					font_object = DiabolicFont_HeaderRegular18,
					position = { "TOP", 0.5, 32.5 + 38 },
					size = { 346 + 80, 38 }
				},
				classification = {
					font_object = DiabolicFont_HeaderRegular10, -- will also apply to spell name when casting
					position = {
						normal_single = { "TOP", 0.5, 26.5 },
						normal_double = { "TOP", 0.5, 26.5 },
						elite_single = { "TOP", 0.5, 26.5 },
						elite_double = { "TOP", 0.5, 26.5 },
						boss_single = { "TOP", 0.5, 26.5 },
						boss_double = { "TOP", 0.5, 26.5 }
					}
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold10,
						position = { "RIGHT", -6, 0 }
					},
					power = {
						font_object = DiabolicFont_SansBold10,
						position = { "RIGHT", -6, 0 }
					},
					castTime = {
						font_object = DiabolicFont_SansBold10,
						position = { "LEFT", 6, 0 } -- should mirror the health text
					}
				},
				textures = {
					size = { 512, 128 },
					position = { "TOP", 0, 53 },
					layers = {
						shade = {
							size = { 768, 256 },
							position = { "CENTER", 0, 0 },
							color = { 0, 0, 0, .5 },
							texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
						},
						backdrop = {
							single = path .. [[textures\DiabolicUI_Target_305x15_Backdrop.tga]],
							double = path .. [[textures\DiabolicUI_Target_305x15_Backdrop2Bars.tga]]
						},
						border = {
							standard_single = {
								normal = path .. [[textures\DiabolicUI_Target_305x15_Border.tga]],
								highlight = path .. [[textures\DiabolicUI_Target_305x15_BorderHighlight.tga]],
								threat = path .. [[textures\DiabolicUI_Target_305x15_Glow.tga]]
							},
							standard_double = {
								normal = path .. [[textures\DiabolicUI_Target_305x15_Border2Bars.tga]],
								highlight = path .. [[textures\DiabolicUI_Target_305x15_Border2BarsHighlight.tga]],
								threat = path .. [[textures\DiabolicUI_Target_305x15_Glow2Bars.tga]]
							},
							elite_single = {
								normal = path .. [[textures\DiabolicUI_Target_305x15_BorderElite.tga]],
								highlight = path .. [[textures\DiabolicUI_Target_305x15_BorderEliteHighlight.tga]],
								threat = path .. [[textures\DiabolicUI_Target_305x15_GlowBoss.tga]]
							},
							elite_double = {
								normal = path .. [[textures\DiabolicUI_Target_305x15_BorderElite2Bars.tga]],
								highlight = path .. [[textures\DiabolicUI_Target_305x15_BorderElite2BarsHighlight.tga]],
								threat = path .. [[textures\DiabolicUI_Target_305x15_GlowBoss2Bars.tga]]
							},
							boss_single = {
								normal = path .. [[textures\DiabolicUI_Target_305x15_BorderBoss.tga]],
								highlight = path .. [[textures\DiabolicUI_Target_305x15_BorderBossHighlight.tga]],
								threat = path .. [[textures\DiabolicUI_Target_305x15_GlowBoss.tga]]
							},
							boss_double = {
								normal = path .. [[textures\DiabolicUI_Target_305x15_BorderBoss2Bars.tga]],
								highlight = path .. [[textures\DiabolicUI_Target_305x15_BorderBoss2BarsHighlight.tga]],
								threat = path .. [[textures\DiabolicUI_Target_305x15_GlowBoss2Bars.tga]]
							}
						}
					}
				},
				auras = {
					position = { "TOP", 0, -45 },
					size = { 30*8 + 4*7 + 1, 44*3 },
					spacingH = 4, 
					spacingV = 12, 
					button = {
						size = { 24, 24 },
						color = { (C.Status.Dead[1]/3 + .3)*.7, (C.Status.Dead[2]/3 + .3)*.7, (C.Status.Dead[3]/3 + .3)*.7 },  -- C.General.XP,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				},
			},
			tot = {
				size = { 148, 35 },
				position = { "TOP", "UICenter", "TOP", -(346/2 + 120), -62 }, 
				shade = {
					size = { 384, 128 },
					position = { "CENTER", 0, 0 },
					color = { 0, 0, 0, .35 },
					texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
				},
				backdrop = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					texture = path .. [[textures\DiabolicUI_Target_114x15_Backdrop.tga]]
				},
				border = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					textures = {
						normal = path .. [[textures\DiabolicUI_Target_114x15_Border.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_114x15_Highlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_114x15_Glow.tga]]
					}
				},
				health = {
					size = { 114, 15 },
					position = { "BOTTOM", 0, 10 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold10,
						position = { "CENTER", 6, 0 }
					}
				},
				name = {
					font_object = DiabolicFont_HeaderRegular16,
					position = { "TOP", 0.5, 24.5 + 17 },
					size = { 148 + 40, 34 }
				}
			},
			focus = {
				size = { 90, 17 },
				--position = { "TOPLEFT", "UICenter", "TOPLEFT", 60, -50 },
				--position = { "CENTER", "UICenter", "CENTER", -440, -50 },
				position = { "BOTTOMLEFT", "Main", "BOTTOMLEFT", orbOffsetX -140 + (140 - 160)/2 -8 + (140-90)/2, 440 },
				--position = { "BOTTOMLEFT", "Main", "BOTTOMLEFT", -(158/2 + 90/2), 220 },
				shade = {
					size = { 196, 64 },
					position = { "BOTTOM", 0, -20 },
					color = { 0, 0, 0, .5 },
					texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
				},
				backdrop = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -83, 24 }, -- -(70 + 8)
					texture = path .. [[textures\DiabolicUI_Target_80x15_Backdrop.tga]]
				},
				border = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -83, 24 }, -- -(70 + 8)
					textures = {
						normal = path .. [[textures\DiabolicUI_Target_80x15_Border.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_80x15_Highlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_80x15_Glow.tga]]
					}
				},
				health = {
					size = { 82, 9 },
					position = { "BOTTOM", 0, 7 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				power = { 
					size = { 82, 3 },
					position = { "BOTTOM", 0, 3 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				portrait = {
					size = { 70, 70 },
					position = { "TOP", 0, 0 },
					texture_size = { 128, 128 }, 
					texture_position = { "CENTER", 0, 0 },
					textures = {
						backdrop = path .. [[textures\DiabolicUI_Target_80x80_PortraitBackdrop.tga]],
						border = path .. [[textures\DiabolicUI_Target_80x80_PortraitBorder.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_80x80_PortraitBorderHighlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_80x80_PortraitGlow.tga]]
					}
				},
				name = {
					font_object = DiabolicFont_HeaderRegular14,
					position = { "TOP", 0.5, 24.5 + 17 },
					size = { 90 + 50, 30 }
				}
			},
			pet = {
				size = { 85 *1.15, 85 *1.15 },
				position = { "BOTTOMLEFT", "Main", "BOTTOMLEFT", orbOffsetX -140 + (140 - 160)/2 -8  -56, orbOffsetY -(140 - 160)/2 -6 +72 },
				health = {
					size = { 75 *1.15, 75 *1.15 },
					position = { "CENTER" },
					color = { 175/255, 17/255, 28/255 }, -- blood
					--color = { 138/255, 7/255, 7/255 }, -- blood
					spark = {
						size = { 64, 64 },
						overflow = 8,
						texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_SparkVertical_Warcraft.tga]],
						flash = { 2.75, 1.25, .45, .95 },
						flash_size = { 64, 16 },
						flash_texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
					},
					shade = {
						size = { 128 *1.15, 128 *1.15 },
						position = { "CENTER", 0, 0 },
						texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Backdrop.tga]],
						color = { 0, 0, 0, 1 }
					},
					overlay = {
						size = { 128 *1.15, 128 *1.15 },
						position = { "CENTER", 0, 0 },
						texture = path .. [[textures\DiabolicUI_PlayerGlobes_150x150_Border.tga]],
						color = { 1, 1, 1, 1 }
					},					
					layers = {
						gradient = {
							alpha = .85,
							texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Gradient.tga]]
						},
						moon = {
							alpha = .5,
							texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Moon.tga]]
						},
						smoke = {
							alpha = .5,
							texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Smoke.tga]]
						},
						shade = {
							alpha = .9,
							texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Shade.tga]]
						}
					}
				}
			},
			party = {
				size = { 148, 35 },
				position = { "TOPLEFT", "UICenter", "TOPLEFT", 60, -90 },
				offset = 20,
				shade = {
					size = { 384, 128 },
					position = { "CENTER", 0, 0 },
					color = { 0, 0, 0, .35 },
					texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
				},
				backdrop = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					texture = path .. [[textures\DiabolicUI_Target_114x15_Backdrop.tga]]
				},
				border = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					textures = {
						normal = path .. [[textures\DiabolicUI_Target_114x15_Border.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_114x15_Highlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_114x15_Glow.tga]]
					}
				},
				health = {
					size = { 114, 15 },
					position = { "BOTTOM", 0, 10 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold10,
						position = { "CENTER", 6, 0 }
					}
				},
				name = {
					font_object = DiabolicFont_HeaderRegular16,
					position = { "TOP", 0.5, 24.5 + 17 },
					size = { 148 + 40, 34 }
				},
				auras = {
					position = { "TOPLEFT", 148 + 30, -4 },
					size = { 26*6 + 4*5 + 1, 40*2 },
					spacingH = 4, 
					spacingV = 4, 
					button = {
						size = { 26, 26 },
						color = { (C.Status.Dead[1]/3 + .3)*.7, (C.Status.Dead[2]/3 + .3)*.7, (C.Status.Dead[3]/3 + .3)*.7 },  -- C.General.XP,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				}				
			},
			raid = {
				size = { 90, 24 },
				position = { "TOPLEFT", "UICenter", "TOPLEFT", 35, -35 },
				offset = 25,
				shade = {
					size = { 234, 78 }, -- scaled from 384×128
					position = { "CENTER", 0, 0 },
					color = { 0, 0, 0, .35 },
					texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
				},
				backdrop = {
					texture_size = { 156, 39 }, -- scaled from 256×64
					texture_position = { "TOPLEFT", -43 + (90-69)/2, 15 -(24-10)/2 },
					texture = path .. [[textures\DiabolicUI_Target_114x15_Backdrop.tga]]
				},
				border = {
					texture_size = { 156, 39 },
					texture_position = { "TOPLEFT", -43 + (90-69)/2, 15 -(24-10)/2 },
					textures = {
						normal = path .. [[textures\DiabolicUI_Target_114x15_Border.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_114x15_Highlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_114x15_Glow.tga]]
					}
				},
				health = {
					size = { 69, 10 }, -- scaled from 114×15
					position = { "BOTTOM", 0, 7 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold8, -- smaller font
						position = { "CENTER", 4, 0 }
					}
				},
				name = {
					font_object = DiabolicFont_HeaderRegular12,
					position = { "TOP", 0.5, 15 + 11 },
					size = { 90 + 24, 22 }
				},
				auras = {
					position = { "TOPLEFT", 90 + 18, -3 },
					size = { 18, 28 },
					spacingH = 3,
					spacingV = 3,
					button = {
						size = { 18, 18 },
						color = { (C.Status.Dead[1]/3 + .3)*.7, (C.Status.Dead[2]/3 + .3)*.7, (C.Status.Dead[3]/3 + .3)*.7 },
						glow = {
							backdrop = {
								bgFile = nil,
								edgeFile = path .. [[textures\DiabolicUI_GlowBorder_128x16.tga]],
								edgeSize = 3,
								tile = false,
								tileSize = 0,
								insets = { left = 0, right = 0, top = 0, bottom = 0 }
							}
						},
						border = {
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
								tile = false,
								tileSize = 0,
								insets = { left = 0, right = 0, top = 0, bottom = 0 }
							}
						},
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					},
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]
					}
				}
			},
			boss = {
				size = { 148, 35 },
				position = { "TOP", "Minimap", "BOTTOM", 0, -100 },
				offset = 20,
				shade = {
					size = { 384, 128 },
					position = { "CENTER", 0, 0 },
					color = { 0, 0, 0, .35 },
					texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
				},
				backdrop = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					texture = path .. [[textures\DiabolicUI_Target_114x15_Backdrop.tga]]
				},
				border = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					textures = {
						normal = path .. [[textures\DiabolicUI_Target_114x15_Border.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_114x15_Highlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_114x15_Glow.tga]]
					}
				},
				health = {
					size = { 114, 15 },
					position = { "BOTTOM", 0, 10 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold10,
						position = { "CENTER", 6, 0 }
					}
				},
				name = {
					font_object = DiabolicFont_HeaderRegular16,
					position = { "TOP", 0.5, 24.5 + 17 },
					size = { 148 + 40, 34 }
				},
				auras = {
					position = { "TOPRIGHT", -(148 + 30), -4 },
					size = { 26*6 + 4*5 + 1, 40*2 },
					spacingH = 4, 
					spacingV = 4, 
					button = {
						size = { 26, 26 },
						color = { (C.Status.Dead[1]/3 + .3)*.7, (C.Status.Dead[2]/3 + .3)*.7, (C.Status.Dead[3]/3 + .3)*.7 },  -- C.General.XP,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				}				
			},
			arena = {
				size = { 148, 35 },
				position = { "TOP", "Minimap", "BOTTOM", 0, -100 },
				offset = 20,
				shade = {
					size = { 384, 128 },
					position = { "CENTER", 0, 0 },
					color = { 0, 0, 0, .35 },
					texture = path .. [[textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
				},
				backdrop = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					texture = path .. [[textures\DiabolicUI_Target_114x15_Backdrop.tga]]
				},
				border = {
					texture_size = { 256, 64 },
					texture_position = { "TOPLEFT", -71 + (148-114)/2, 25 -(35-15)/2 },
					textures = {
						normal = path .. [[textures\DiabolicUI_Target_114x15_Border.tga]],
						highlight = path .. [[textures\DiabolicUI_Target_114x15_Highlight.tga]],
						threat = path .. [[textures\DiabolicUI_Target_114x15_Glow.tga]]
					}
				},
				health = {
					size = { 114, 15 },
					position = { "BOTTOM", 0, 10 },
					texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
				},
				texts = {
					health = {
						font_object = DiabolicFont_SansBold10,
						position = { "CENTER", 6, 0 }
					}
				},
				name = {
					font_object = DiabolicFont_HeaderRegular16,
					position = { "TOP", 0.5, 24.5 + 17 },
					size = { 148 + 40, 34 }
				},
				auras = {
					position = { "TOPRIGHT", -(148 + 30), -4 },
					size = { 26*6 + 4*5 + 1, 40*2 },
					spacingH = 4, 
					spacingV = 4, 
					button = {
						size = { 26, 26 },
						color = { (C.Status.Dead[1]/3 + .3)*.7, (C.Status.Dead[2]/3 + .3)*.7, (C.Status.Dead[3]/3 + .3)*.7 },  -- C.General.XP,
						glow = {
							backdrop = {
								bgFile = nil, -- [[Interface\ChatFrame\ChatFrameBackground]],
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
							backdrop = {
								bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeFile = [[Interface\ChatFrame\ChatFrameBackground]],
								edgeSize = 1,
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
						shade = {
							texture = path .. [[textures\DiabolicUI_Shade_64x64.tga]]
						}
					}, 
					timer = {
						statusBar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]

					}
				}	
			}
		},
		colors = {
			
		}
	}
})

