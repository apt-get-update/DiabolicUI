local ADDON, Engine = ...
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- The styles listed here are meant to skin
-- Blizzard elements we can't replace, like the gamemenu,
-- ...or Blizzard elements we can't be arsed to replace, like the rest. 
Engine:NewStaticConfig("Blizzard", {
	-- Diablo III's window, for the Blizzard windows given its look
	-- (modules/blizzard/windows.lua): a stone window in an iron frame, a title
	-- bar, darker panels in bronze lines, red and dark buttons and tabs, and
	-- spiked bars. The buttons and bars are cut in three (`left`, `middle`,
	-- `right`, in canvas pixels), so their ends keep their shape at any width:
	-- `art` is the visible part of the canvas, scaled to the button's height.
	window = {
		backdrop = {
			bgFile = path .. [[textures\DiabolicUI_Tooltip_Background.tga]],
			edgeFile = path .. [[textures\DiabolicUI_Tooltip_Border.tga]],
			edgeSize = 32,
			tile = true,
			tileSize = 256,
			insets = { left = 23, right = 23, top = 23, bottom = 23 }
		},
		backdrop_color = { .8, .65, .65, 1 }, -- the stone toward red
		backdrop_border_color = { 1, 1, 1, 1 },
		-- Diablo III's title bar: a red stained-glass band along the top,
		-- in tiles (Diablo III's stash window's, mirrored to repeat), the
		-- title in a dark plate on the window's top edge
		band = {
			texture = path .. [[textures\DiabolicUI_D3_Band.tga]],
			canvas = { 364, 104 }, -- its art's shape (squeezed into the file)
			glow = path .. [[textures\DiabolicUI_Window_BandGlow.tga]], -- in its middle, added
			glow_width = 6, -- in band heights
			glow_alpha = .45
		},
		-- the title in the band (Diablo III's): left of what's in its middle
		-- (the medallion, a cartouche, a status), in its middle if nothing is
		band_title = {
			font = DiabolicFont_HeaderRegular16,
			color = { .86, .76, .6 }, -- Diablo III's pale gold
			gap = 10, -- from what's in the middle
			margin = 16 -- the most it reaches: that far in from the band's ends
		},
		-- a window's painted background over its stone, inside the iron, as
		-- big as the window without stretching (cut to its shape): Diablo
		-- III's, one per kind of window (`aspect`, its art's width / height)
		backgrounds = {
			smoke = { texture = path .. [[textures\DiabolicUI_D3_BackgroundSmoke.tga]], aspect = 1.218 }, -- a demon in red smoke (the options')
			emblem = { texture = path .. [[textures\DiabolicUI_D3_BackgroundEmblem.tga]], aspect = .677 }, -- dark stone, Diablo's emblem (the lore book's)
			leather = { texture = path .. [[textures\DiabolicUI_D3_BackgroundLeather.tga]], aspect = .716 } -- brown leather, the emblem pressed in (the stash's)
		},
		-- a window's emblem at its band's left end: Diablo III's round
		-- stained glass under a gargoyle, one per kind of window
		medallion = {
			grow = 6, -- past the band's height
			offset = 4, -- from the band's left end
			textures = {
				chest = path .. [[textures\DiabolicUI_D3_MedallionChest.tga]], -- bank, guild bank
				coinbag = path .. [[textures\DiabolicUI_D3_MedallionCoinBag.tga]], -- merchant
				grail = path .. [[textures\DiabolicUI_D3_MedallionGrail.tga]], -- quest log, quest giver
				map = path .. [[textures\DiabolicUI_D3_MedallionMap.tga]], -- flight master
				swords = path .. [[textures\DiabolicUI_D3_MedallionSwords.tga]] -- character
			}
		},
		-- a key number (achievement points) in a stone cartouche in the band
		cartouche = {
			texture = path .. [[textures\DiabolicUI_Tooltip_TitleDecoration.tga]],
			canvas = { 128, 64 },
			art = { 0, 5, 128, 59 },
			left = { 0, 24 }, middle = { 24, 104 }, right = { 104, 128 },
			height = 38,
			padding = 36, -- around what it holds
			font = { path .. [[fonts\NotoSerif-Bold.ttf]], 22 },
			color = { 1, .62, .2 }
		},
		-- Diablo III's flat buttons in iron edges (categories, tabs): red,
		-- lit (chosen, under the mouse), dark (the tabs not chosen)
		rect_button = {
			texture = {
				normal = path .. [[textures\DiabolicUI_D3_Button.tga]],
				lit = path .. [[textures\DiabolicUI_D3_ButtonLit.tga]],
				dark = path .. [[textures\DiabolicUI_D3_ButtonDark.tga]]
			},
			canvas = { 512, 64 },
			art = { 0, 1, 457, 63 },
			left = { 0, 48 }, middle = { 48, 409 }, right = { 409, 457 } -- its gold corners at the ends
		},
		-- a section's title bar: dark, iron arrows at its ends, its title on
		-- the left in orange
		section = {
			texture = path .. [[textures\DiabolicUI_Window_Section.tga]],
			canvas = { 512, 32 },
			art = { 0, 3, 512, 29 },
			left = { 0, 32 }, middle = { 32, 480 }, right = { 480, 512 },
			height = 22,
			font = DiabolicFont_HeaderRegular12,
			color = { 1, .6, .2 },
			text_offset = { 28, 1 } -- from its left, past the arrow
		},
		-- text drawn for parchment, on Diablo III's (its lore book's page)
		parchment = path .. [[textures\DiabolicUI_D3_Parchment.tga]],
		-- around the text's scroll frame: past its bound edge on the left, its
		-- pages' edges on the right, the scroll bar moved out past them, the
		-- panel around both
		parchment_insets = { 14, 4, 24, 4 },
		parchment_bar_x = 26, -- the scroll bar's left, from the text's right
		parchment_panel_insets = { 16, 6, 48, 6 },
		ink = { .18, .12, .06 }, -- text forced dark on it
		-- what the window shows, a little darker
		panel = {
			backdrop = {
				bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
				edgeFile = path .. [[textures\DiabolicUI_Tooltip_Body.tga]],
				edgeSize = 32,
				insets = { left = 3, right = 3, top = 3, bottom = 3 }
			},
			backdrop_color = { 0, 0, 0, .5 },
			backdrop_border_color = { 71/255 * 3.5, 56/255 * 3.5, 28/255 * 3.5, 1 }
		},
		red_button = {
			texture = {
				normal = path .. [[textures\DiabolicUI_UIButton_193x55_Normal.tga]],
				highlight = path .. [[textures\DiabolicUI_UIButton_193x55_Highlight.tga]],
				pushed = path .. [[textures\DiabolicUI_UIButton_193x55_Pushed.tga]]
			},
			canvas = { 256, 128 },
			art = { 31, 36, 224, 91 },
			left = { 0, 64 }, middle = { 64, 192 }, right = { 192, 256 }
		},
		dark_button = {
			texture = {
				normal = path .. [[textures\DiabolicUI_UIButton_300x51_Normal.tga]],
				highlight = path .. [[textures\DiabolicUI_UIButton_300x51_Highlight.tga]],
				pushed = path .. [[textures\DiabolicUI_UIButton_300x51_Pushed.tga]]
			},
			canvas = { 512, 128 },
			art = { 106, 38, 406, 89 },
			left = { 0, 160 }, middle = { 160, 352 }, right = { 352, 512 }
		},
		-- the bars' frame, its middle a plain stretch of it (not its centrepiece)
		bar = {
			texture = path .. [[textures\DiabolicUI_Target_80x15_Border.tga]],
			canvas = { 256, 64 },
			art = { 88, 24, 168, 39 },
			left = { 0, 104 }, middle = { 100, 110 }, right = { 152, 256 },
			statusbar = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]],
			color = { .85, .42, .08 }, -- Diablo III's orange
			spike = 28 -- how far its ends reach past the bar, at the bars' height
		},
		-- the dark strip the tabs sit on, under the band, in an iron edge
		-- whose pointed ends reach out over the window's frame (Diablo III's
		-- hero creation's)
		tab_strip = {
			texture = path .. [[textures\DiabolicUI_D3_TabStrip.tga]],
			canvas = { 512, 64 },
			art = { 0, 4, 398, 60 },
			left = { 0, 32 }, middle = { 32, 366 }, right = { 366, 398 },
			height = 34,
			offset = 2, -- its top over the band's bottom
			extend = 13 -- past the band's ends: its points out over the iron (15 to 24 in)
		},
		tab = {
			height = 26, -- of its art, in a tab of Blizzard's height
			font = DiabolicFont_HeaderRegular12,
			text_offset = 1 -- from the art's middle (Blizzard's sits lower); Exocet's capitals sit low in their line
		},
		-- Diablo III's close button: a burnt orange square, its X a thin
		-- glowing line, on the window's top right corner
		close = {
			size = 22,
			texture = {
				normal = path .. [[textures\DiabolicUI_D3_Close.tga]],
				lit = path .. [[textures\DiabolicUI_D3_CloseLit.tga]],
				pushed = path .. [[textures\DiabolicUI_D3_ClosePushed.tga]]
			},
			texcoords = { 12/64, 52/64, 12/64, 52/64 }, -- the square in its canvas
			-- in a socket of the window's own iron at its top right corner, as
			-- Diablo III's: the frame's edge (its iron 15 to 24 in) drawn on
			-- its left and bottom only, over the window's, its top and right
			-- ends at the middle of the window's iron, the X inside
			socket_size = 70, -- from the window's corner to its bars' outside
			socket_inset = 20, -- the middle of the window's iron
			socket_color = { 0, 0, 0, 1 }
		},
		-- the dropdowns, in Diablo III's dropdown plate
		dropdown = {
			height = 26,
			inset = 16, -- UIDropDownMenuTemplate's art is drawn that far in
			text_padding = 10, -- its text, in from the plate's left
			-- its plate: dark stone in iron, gold corners at its ends
			plate = {
				texture = path .. [[textures\DiabolicUI_D3_DropDown_Plate.tga]],
				canvas = { 512, 128 },
				art = { 0, 24, 268, 103 },
				left = { 0, 32 }, middle = { 32, 236 }, right = { 236, 268 }
			},
			-- its button: Diablo III's small orange square with its arrow
			arrow = {
				normal = path .. [[textures\DiabolicUI_D3_DropDown.tga]],
				lit = path .. [[textures\DiabolicUI_D3_DropDownLit.tga]],
				pushed = path .. [[textures\DiabolicUI_D3_DropDownPushed.tga]]
			},
			arrow_size = 18,
			arrow_gap = 9, -- from the plate's right end, inside its gold corners
			arrow_texcoords = { 0, 23/32, 0, 23/32 } -- the square in its canvas
		},
		-- the action buttons' border, made for 44 wide ones (the ammo slot's,
		-- the spellbook's)
		button_border = {
			texture = path .. [[textures\DiabolicUI_Button_44x44_Border.tga]],
			size = { 64, 64 },
			offset = { -10, 10 }
		},
		title_font = DiabolicFont_HeaderRegular18Title,
		button_font = DiabolicFont_HeaderRegular12,
		-- Blizzard's buttons whose text is too wide in it get these, in turn
		button_font_small = DiabolicFont_HeaderRegular10,
		button_font_narrow = DiabolicFont_SansBold10,
		button_text_margin = 6, -- kept free at each end
		button_text_color = { 1, 1, 1 }, -- an enabled button's text (its font's own)
		button_disabled_color = { .5, .47, .44 }, -- a disabled button's text
		-- Diablo III's scroll bar: a black track in a thin bronze line, red
		-- arrows (the chat's) and thumb (the sliders'), cut from their
		-- canvas to their art
		scrollbar = {
			width = 16, -- Blizzard's bars'
			up = {
				normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Up.tga]],
				lit = path .. [[textures\DiabolicUI_ChatButtons_36x36_UpHighlight.tga]],
				disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_UpDisabled.tga]]
			},
			down = {
				normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Down.tga]],
				lit = path .. [[textures\DiabolicUI_ChatButtons_36x36_DownHighlight.tga]],
				disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_DownDisabled.tga]]
			},
			arrow_texcoords = { 14/64, 50/64, 14/64, 50/64 }, -- their 36x36 art
			thumb = path .. [[textures\DiabolicUI_Slider_22x36_Thumb.tga]],
			thumb_texcoords = { 21/64, 43/64, 14/64, 50/64 }, -- its 22x36 art
			thumb_height = 26, -- its art's shape at the bar's width
			blank = [[Interface\Buttons\WHITE8X8]],
			line = 1,
			track_color = { 0, 0, 0, .85 },
			line_color = { .35, .27, .15, 1 }
		}
	},
	durability = {
		position = { "CENTER", "UICenter", "CENTER", 190, 0 }
	},
	gamemenu = {
		button_spacing = 4
	},
	-- GearScore under the inspect window's model (modules/blizzard/gearscore.lua;
	-- the character window's in its right column, character.lua)
	gearscore = {
		font = DiabolicFont_HeaderRegular12,
		inspect_offset = 8, -- in the model's bottom
		retries = 10, -- while the gear isn't all known (inspecting)
		retry_delay = .5
	},
	-- the achievement window in Diablo III's (modules/blizzard/achievements.lua)
	achievements = {
		insets = { 0, 96, 0, 18 }, -- the window past Blizzard's frame: up over the band and the tabs, down past the lists' panels
		header_height = 48, -- the red band
		header_insets = { 24, 24 }, -- inside the iron frame, its solid part
		tab_offset = { 4, 1 }, -- the first tab, in a row under the band (Diablo III's)
		filter_position = { -8, -1 }, -- the list's filter at that row's right end
		tab_inset = 3, -- Blizzard overlaps its tabs by 5
		tab_padding = 24, -- around their text (five with Overachiever's, before the list's filter)
		category_font = DiabolicFont_HeaderRegular12,
		category_color = { .93, .86, .74 },
		category_text_offset = 14, -- from the button's left (and kept that far from its right)
		-- the subcategories: a list under their category, as Diablo III's
		subcategory_font = DiabolicFont_HeaderRegular10,
		subcategory_color = { .78, .7, .6 },
		subcategory_text_offset = 22,
		subcategory_lit_alpha = .6, -- the red under the chosen one, fainter
		bullet_size = 4,
		bullet_offset = 10,
		bullet_color = { .85, .35, .15 },
		filter_offset = 4, -- the list's filter: its text sits that far above its middle
		filter_inset = -10, -- its plate reaches past its text's left
		control_button_height = 22, -- Overachiever's pages' buttons
		-- the summary's bars, in Blizzard's 488 wide
		summary_width = 488,
		bar_height = 16,
		bar_gap = 8, -- between the spikes of the two columns
		bar_font = DiabolicFont_HeaderRegular10,
		bar_label_offset = 1, -- Exocet's capitals sit low in their line
		bar_label_color = { .93, .88, .8 }, -- Diablo III's: the label pale, the count orange
		bar_text_font = DiabolicFont_SansBold10,
		bar_text_color = { 1, .62, .2 },
		-- the achievements (Blizzard's parchment, darkened)
		row_color = { .3, .17, .12 },
		row_color_unearned = { .22, .19, .17 },
		row_text_color = { .8, .75, .68 },
		row_title_color = { .8, .45, .35 },
		row_title_color_unearned = { .5, .45, .42 }
	},
	-- the character window in Diablo III's (modules/blizzard/character.lua)
	character = {
		-- the window over Blizzard's frame: { left, top, right, bottom },
		-- positive outward. Wider and taller than Blizzard's panel art, for
		-- room around the slots; the other tabs are moved by `content_offset`
		-- into the middle of it.
		insets = { 0, 36, 18, -18 }, -- up over the band and the tabs
		content_offset = { 19, -20 },
		-- the character tab in two columns, laid out from the window's edges:
		-- the gear around a tall model on the left (as wide as the window on
		-- the other tabs), the GearScore and stats, the titles and the
		-- equipment sets in pages on the right, the window wider for it
		-- (`wide_insets`, as `insets`)
		paperdoll = {
			wide_insets = { 0, 36, 266, -14 },
			pane_width = 418, -- the gear's column
			slot_margin = 38, -- the slot columns from its sides
			slot_top = -104, -- from its top, under the band and the tabs (8 clear of them)
			slot_gap = 4,
			title_top = -100, -- the title's dropdown, from its top (out of sight: the titles' page has them)
			model_top = -104, -- the model's top, from its top: with the slots'
			model_size = { 240, 314 }, -- between the slot columns, 14 from each; as tall as them (its bottom where it was)
			model_panel_inset = 4, -- the panel around it
			-- its frame past the panel, up and down: the character larger and
			-- lower in it, on the scene's floor (the dressing room's is so)
			model_reach = { 26, 32 },
			resistance_offset = { -8, -8 }, -- the resistances, in its top right corner
			weapon_top = -10, -- the weapons' row, under the model's panel
			weapon_gap = 6,
			ammo_size = 27, -- Blizzard's ammo slot, in the action buttons' border
			-- the right column: the level, the GearScore, two groups of stats (Blizzard's
			-- choice, a click on their title bar shows the next)
			stats = {
				left = -14, -- from the gear's column's right
				top = -96,
				right = 28, -- from the window's right (inside its iron frame)
				bottom = 28,
				padding = 6, -- top and bottom
				side_padding = 24, -- inside the stats panel's light line (~19 in)
				header_height = 16,
				header_gap = 2, -- under each title bar
				line_height = 12,
				line_inset = 8, -- each line from the panel's sides
				group_gap = 14,
				level_height = 34, -- the level's room under its title bar
				score_height = 58, -- the GearScore's room under its title bar
				score_gap = 6,
				score_top = 6 -- its title bar, lower than the top padding
			},
			-- its tabs in a row at its top, WoW's art on them (stats, titles,
			-- sets), a page under them for each
			sidebar = {
				top = 6, -- from the column's padding
				tab_width = 44,
				tab_height = 30,
				tab_gap = 6,
				icons = {
					{ portrait = true, size = { 24, 24 } }, -- the character's
					{ texture = [[Interface\AchievementFrame\UI-Achievement-Shields]], coords = { 0, .5, 0, .8125 }, size = { 26, 21 } }, -- the gold one
					{ texture = [[Interface\WorldStateFrame\CombatSwords]], coords = { 0, .5, 0, .5 }, size = { 24, 24 } } -- the combat ones
				},
				icon_dim = .55, -- the unchosen tabs' icons
				gap = 4 -- the pages, under the tabs
			},
			-- the titles' page: the known ones in a list
			titles = {
				top = 6,
				bottom = 6,
				bar_room = 22, -- its scroll bar, right of it
				row_height = 16,
				font = { path .. [[fonts\NotoSans-Regular.ttf]], 11 },
				color = { .82, .74, .6 },
				worn_color = { 1, .82, .4 }
			},
			score_font = { path .. [[fonts\NotoSerif-Bold.ttf]], 24 },
			stats_panel = path .. [[textures\DiabolicUI_D3_StatsPanel.tga]], -- Diablo III's (dark red, in its own line)
			stats_panel_inset = 3,
			-- the equipment manager (Blizzard's dialog, its frame hidden) on its page
			gear_manager = {
				height = 194, -- under its title bar, until its sets are laid out (then as their rows need)
				top = 8, -- its sets, from its top
				rows = { 3, 3, 4 }, -- the sets in each row; the icons right of the shorter ones
				set_gap = 12, -- between them
				row_gap = 14, -- room for their names
				names_height = 14, -- under the last row
				-- equip, save and delete as icons in a column right of the sets
				icons = path .. [[textures\DiabolicUI_Window_Icons.tga]], -- new, equip, delete, save
				icon_count = 4,
				action_size = 22,
				action_icon_size = 16,
				action_gap = 4,
				popup_button_height = 22 -- the icon picker's Okay and Cancel
			},
			stat_label_font = { path .. [[fonts\NotoSans-Regular.ttf]], 10 },
			stat_value_font = { path .. [[fonts\NotoSans-Bold.ttf]], 10 },
			stat_label_color = { .82, .74, .6 }
		},
		popup_color = { 0, 0, 0, .92 }, -- the title picker, the equipment manager
		gear_manager_offset = { 6, 0 }, -- the equipment manager's icon picker, right of the window
		scene_inset = 3, -- your home city behind the model, inside its panel's bronze line
		scene_color = { .75, .75, .75 }, -- dimmed a little under the model
		reputation_detail_offset = { -8, -96 }, -- a faction's details, right of the window, under its tabs (its iron starts ~9px in)
		reputation_detail_close = 8, -- their X on their ribbon, this far in from their right side
		reputation_detail_inset = 3, -- their parchment, inside their panel's bronze line
		reputation_detail_name_top = 2, -- their name's top: its ribbon across their top edge (Blizzard's 21)
		reputation_detail_width = 260, -- their panel (Blizzard's 212)
		reputation_detail_text_side = 21, -- their description from their sides (Blizzard's)
		reputation_detail_name_side = 36, -- their name from their sides: clear of their X (8 + 22 + a gap) on both
		reputation_detail_name_spacing = 3, -- between its lines, when it takes two
		reputation_detail_name_font = { path .. [[fonts\ExocetBlizzardMedium.ttf]], 13 }, -- Diablo III's, as the windows' titles (their Light), heavier on its ribbon
		reputation_detail_name_gap = 20, -- between their name and their description, the ribbon's lower half
		reputation_detail_ribbon = {
			texture = path .. [[textures\DiabolicUI_D3_Ribbon.tga]],
			-- by standing: bloodied below Neutral (Hated drenched, Hostile and at war
			-- dripping, Unfriendly splattered), more gold embroidery above it
			-- (Friendly its lattice, Honored its filigree, Revered stitching,
			-- Exalted studs and a fringe)
			standings = {
				[1] = path .. [[textures\DiabolicUI_D3_Ribbon_Blood3.tga]],
				[2] = path .. [[textures\DiabolicUI_D3_Ribbon_Blood2.tga]],
				[3] = path .. [[textures\DiabolicUI_D3_Ribbon_Blood1.tga]],
				[5] = path .. [[textures\DiabolicUI_D3_Ribbon_Gold1.tga]],
				[6] = path .. [[textures\DiabolicUI_D3_Ribbon_Gold2.tga]],
				[7] = path .. [[textures\DiabolicUI_D3_Ribbon_Gold3.tga]],
				[8] = path .. [[textures\DiabolicUI_D3_Ribbon_Gold4.tga]]
			},
			canvas = 64 / 44, -- its file's height over its band's
			overhang = 22, -- its ends past their sides
			padding = 12 -- its band above and below the name
		},
		reputation_detail_boxes = 68, -- their boxes' room at the bottom, a gap over them
		reputation_detail_ink = {
			title = { .42, .08, .02 }, -- dark red, as the quests' titles
			text = { .18, .12, .06 },
			war = { .55, .04, .02 }, -- At War
			off = { .48, .42, .34 } -- a box that can't be changed, faded
		},
		token_money_offset = { -44, 84 }, -- your money, right-aligned with the currency list's scroll bar (Blizzard's -115)
		-- the selected skill's details, in a panel (its scroll bar inside)
		skill_detail_insets = { 6, 6, 28, 6 },
		popup_highlight_color = { 1, .22, .08 }, -- its hover bar, Blizzard's gold in red
		-- the pet tab's own tabs as ours (the companions and mounts are in
		-- the spellbook, spellbook.lua)
		companion = {
			tab_inset = 2,
			tab_gap = 2,
			tab_position = { -8, -39 } -- the row's middle and top, from the tab's top middle (the panels' middle)
		},
		header_height = 40, -- the red band
		header_insets = { 24, 24 }, -- inside the iron frame, its solid part
		-- the level, big on the stats' page
		level_color = { .86, .76, .6 },
		-- the title's dropdown draws its text above its frame's middle
		dropdown_offsets = { PlayerTitleFrame = 9 },
		tab_offset = { 4, 1 }, -- the first tab, in a row under the band (Diablo III's)
		tab_inset = 8, -- Blizzard overlaps them by 16
		tab_font = DiabolicFont_HeaderRegular10,
		-- the talent spec's icon in the title bar's left end, round, in the
		-- globes' bronze ring and glass (its 136 wide inside in 256)
		-- the spec's icon in the band's medallion, over its glass
		spec = {
			glass = .72, -- of the medallion's size: up to its ring, the swords under it
			glass_offset = { 1, 1 } -- the glass's middle from the medallion's
		}
	},
	-- the mailbox in Diablo III's (modules/blizzard/mail.lua): the windows
	-- grow around Blizzard's 384x512 frames, whose parts are placed against
	-- them (the letter's fields start 46 down)
	mail = {
		insets = { 16, 68, 0, -40 }, -- up over the band and the tabs
		offset_y = -32, -- the window's top with the others'
		open_insets = { 16, 68, 0, -40 }, -- the letter opened, its top with the inbox's
		open_gap = 8, -- between the two windows
		header_height = 40,
		header_insets = { 24, 24 },
		tab_offset = { 4, 1 },
		tab_inset = 8, -- Blizzard overlaps them by 14
		tab_font = DiabolicFont_HeaderRegular10,
		list_panel_insets = { 6, 6, 6, 6 }, -- around the mail
		text_panel_insets = { 6, 6, 28, 6 }, -- around a letter, its scroll bar inside on the right
		text_color = { .18, .12, .06 }, -- dark ink on the letter's parchment
		parchment_insets = { 4, 4, 4, 4 } -- its text narrower than its scroll frame
	},
	-- the merchant window in Diablo III's (modules/blizzard/merchant.lua).
	-- Offsets from the window's top left.
	merchant = {
		insets = { 0, 36, 116, 0 }, -- the window over Blizzard's 384x512 frame: 500 wide
		header_height = 40,
		header_insets = { 24, 24 },
		tab_offset = { 4, 1 },
		tab_inset = 8, -- Blizzard overlaps them by 16
		tab_font = DiabolicFont_HeaderRegular10,
		background = "emblem", -- dark stone (a name from `window.backgrounds`)
		slot_texture = path .. [[textures\DiabolicUI_D3_Slot.tga]], -- Diablo III's vendor's: the icon's box, the name's
		slot_glow = { 1, .7, .3, .14 }, -- over the hovered slot, added
		border_highlight = path .. [[textures\DiabolicUI_Button_44x44_BorderHighlight.tga]], -- its icon's border, hovered
		-- the wares in two columns of dark slots, the icon in each one's
		-- top left, its name right of it and its price under that
		items = { 32, -108 }, -- the first slot
		slot_size = { 208, 46 },
		slot_pitch = { 218, 52 },
		slot_canvas = { 256, 128 }, -- the slot's art, stretched to each slot
		slot_box = { 9, 11, 56, 117 }, -- its icon box's inside, the icon filling it: left, top, right, bottom
		name_offset = 16, -- from the icon, into the name's box
		name_width = 150,
		name_height = 26, -- two lines
		price_offset = 31, -- the price at the icon's bottom (Blizzard hangs it 31 over its name art)
		pages_y = -428, -- the pages' row, under the slots
		page_color = { .86, .76, .6 },
		-- the bottom row: the last item sold, the repairs, Sell Junk and the money
		buyback = { 32, -462 },
		buyback_size = { 204, 44 },
		buyback_price_offset = 25,
		repair = { 288, -466 }, -- repair all's top left; repair one left of it, the guild's right
		sell_junk = { -32, -462 }, -- its top right, from the window's top right
		button_height = 22,
		money = { -24, 30 } -- its bottom right, from the window's bottom right
	},
	-- the talent window in Diablo III's (modules/blizzard/talents.lua).
	-- Offsets from the window's top left.
	talents = {
		insets = { 0, 36, 18, -18 }, -- the window over Blizzard's 384x512 frame, as the character window's
		header_height = 40,
		header_insets = { 24, 24 },
		-- the specs (primary, secondary, pet) as icons at the band's left end
		spec_size = 28,
		spec_offset = 12, -- from the band's left
		spec_gap = 6,
		status_color = { .86, .76, .6 }, -- the spec's state, in the band's middle
		button_height = 22,
		activate_padding = 12, -- the Activate button's text from its ends
		tab_offset = { 4, 1 },
		tab_inset = 8, -- Blizzard overlaps them by 15
		tab_font = DiabolicFont_HeaderRegular10,
		-- the tree (Blizzard's 296 wide and its scroll bar) in a darker panel
		tree = { 42, -110 }, -- its top left
		tree_gap = 8, -- over the points
		tree_panel_insets = { 6, 6, 30, 6 }, -- the scroll bar inside on the right
		bars_inset = 32, -- the points and the preview's bar, from the window's sides
		bars_bottom = 30, -- the lowest, from the window's bottom
		-- the glyphs under the tabs: their art's parchment (x, y, width,
		-- height in Blizzard's frame and its 512 texture), on a cover of
		-- stone under the glyphs' frame (Blizzard raises it 4 levels)
		glyph_art = { 16, 36, 334, 400 },
		glyph_corner = 64, -- its gold corners' size
		glyph_height = 352,
		glyph_top = -108,
		glyph_cover_insets = { 24, 100, 24, 24 },
		glyph_cover_level = 3
	},
	-- the quest log in Diablo III's (modules/blizzard/questlog.lua). Offsets
	-- from the window's top left.
	questlog = {
		insets = { 0, 36, 70, 20 }, -- the window over Blizzard's 682x447 frame: wider, for room around its panes
		header_height = 40,
		header_insets = { 24, 24 },
		row_y = -80, -- the count (left) and the map's button (right), under the band
		row_inset = 32,
		list = { 30, -100 }, -- the quests' top left (Blizzard's 305 wide, its bar right of it)
		list_panel_insets = { 6, 6, 22, 6 },
		details = { -74, -100 }, -- the details' top right (Blizzard's 298 wide, its bar right of it)
		controls = { 30, 28 }, -- Abandon, Share and Track: their bottom left, from the window's
		controls_width = 321, -- the quests' and their bar's
		button_height = 22,
		-- the details on Diablo III's parchment (the windows'), in dark ink
		header_color = { .42, .08, .02 }, -- the details' titles, dark red
		text_color = { .18, .12, .06 }, -- as the mail's
		done_color = { .48, .42, .34 } -- an objective done, faded
	},
	-- the social window in Diablo III's (modules/blizzard/social.lua): the
	-- window grows around Blizzard's 384x512 frame, whose tabs are placed
	-- against it, up over the band and the tabs (Blizzard's start 37 down)
	-- AdiBags' bags (modules/blizzard/adibags.lua)
	adibags = {
		insets = { 18, 18, 18, 18 }, -- the window past its frame: the iron over its 8px margin's outer half
		panel_gap = 4, -- its equipped bags' panel, over the window
		title_font = DiabolicFont_HeaderRegular12
	},
	social = {
		insets = { 20, 68, 8, -40 },
		offset_y = -32, -- Blizzard's frame that much lower: the window's top with the others'
		header_height = 40,
		header_insets = { 24, 24 },
		tab_offset = { 4, 1 },
		tab_inset = 8, -- Blizzard overlaps them by 14
		tab_font = DiabolicFont_HeaderRegular10,
		own_tab_inset = 2, -- the friends' own tabs
		own_tab_gap = 6, -- under the window's
		status_offset = -6, -- your status (its dropdown, its art drawn 16 in), from the band's left
		friends_top = -70, -- the friends' list, from the frame's top: under their tabs
		friends_bottom = 407, -- its bottom, as Blizzard's (over its buttons)
		who_dropdown_width = 64, -- its middle: room for Zone, Guild or Race
		who_totals_drop = 6, -- "People Found", lower than Blizzard's
		who_top = -29, -- the who list's column headers, from the frame's top: 6 under the tabs (Blizzard's 70 down)
		motd_panel_insets = { 6, 6, 6, 4 }, -- the guild's message of the day, around its title and text
		guild_detail_offset = { 6, -96 }, -- a member's card, right of the window, under its tabs
		list_panel_insets = { 6, 6, 28, 6 }, -- the scroll bar inside on the right
		-- lists with less room: the friends' between their tabs and their
		-- buttons, the guild's with its scroll bar's lower arrow below it
		list_panel_overrides = {
			FriendsFrameFriendsScrollFrame = { 6, 2, 28, 2 },
			FriendsFrameIgnoreScrollFrame = { 6, 2, 28, 2 },
			FriendsFramePendingScrollFrame = { 6, 2, 28, 2 },
			GuildListScrollFrame = { 6, 6, 28, 24 }
		}
	},
	-- the rest of Blizzard's windows in Diablo III's
	-- (modules/blizzard/panels.lua): each window grows around Blizzard's
	-- frame. Insets (left, top, right, bottom) past it, from where its art
	-- shows (a 384x512 frame's art stops its hit rect's insets short of
	-- its right and bottom): 24 to the left, 40 up for the band (68 with
	-- the tabs under it), 24 past the art's right, 36 under it, so what's
	-- near its edges stays clear of the iron frame.
	panels = {
		header_height = 40,
		header_insets = { 24, 24 },
		tab_offset = { 4, 1 },
		tab_inset = 8, -- Blizzard overlaps them by 15
		own_tab_inset = 2, -- a page's own tabs (the inspected's talent trees)
		own_tab_gap = 6, -- theirs under the window's
		tab_font = DiabolicFont_HeaderRegular10,
		list_panel_insets = { 6, 6, 28, 6 }, -- the scroll bar inside on the right
		text_color = { .9, .86, .8 }, -- their dark text (drawn for parchment), pale
		-- `frame`; `addon` if it loads on demand; `insets`; `offset_y`, the
		-- frame lower to put the window's top with the others' (`panel` false
		-- for those Blizzard doesn't place); its title: `title`, a font
		-- string, or `text`, a global string (theirs has no name); `close`
		-- (unnamed if left out); `tabs`, their names' prefix; `lists`, in
		-- panels (a name, or { name, how much further left its rows
		-- start }); `keep`, its own textures not its frame's art (patterns on
		-- their names); `subframes`, whose own textures are art too; `hide`,
		-- more by name; `places`, parts moved ({ point, relative's name,
		-- relativePoint, x, y } by name); `art`, by file; `pale`, its dark text pale; `medallion`,
		-- its emblem in the band (window.medallion's);
		-- `parchments`, text on Diablo III's parchment in a panel; `ink`, text
		-- Blizzard colors for its page's material, dark on ours; `background`,
		-- its painted one (window.backgrounds'), `background` below if left out;
		-- `late`, parts an addon adds once it's shown (Auctionator's pages):
		-- `hide` and `places` as above; `panels`, their own backdrop gone,
		-- in ours ({ name, insets }); `dropdowns`, Diablo III's; `tabs`, their
		-- prefix; `lower`, how much lower what's placed from the bottom of
		-- one of `lower_in` goes.
		background = "smoke",
		frames = {
			{ frame = "PVPParentFrame", insets = { 24, 68, -6, -39 }, offset_y = -32, text = "PLAYER_V_PLAYER",
				close = "PVPParentFrameCloseButton", tabs = "PVPParentFrameTab", subframes = { "PVPFrame", "PVPBattlegroundFrame" },
				hide = { "PVPBattlegroundFrameFrameLabel" }, pale = true }, -- the battlegrounds' own title, under the tabs
			{ frame = "BattlefieldFrame", insets = { 24, 40, -10, -39 }, offset_y = -4, title = "BattlefieldFrameFrameLabel",
				close = "BattlefieldFrameCloseButton", lists = { "BattlefieldListScrollFrame" }, pale = true },
			{ frame = "BankFrame", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "BankFrameTitleText", close = "BankCloseButton",
				medallion = "chest", background = "leather" },
			{ frame = "TradeFrame", insets = { 24, 40, 14, -16 }, offset_y = -4, text = "TRADE", close = "TradeFrameCloseButton",
				-- the names over their columns, out from under the band (Blizzard's beside portraits)
				places = { TradeFramePlayerNameText = { "BOTTOM", "TradePlayerItem1", "TOP", 0, 50 },
					TradeFrameRecipientNameText = { "BOTTOM", "TradeRecipientItem1", "TOP", 0, 50 } } },
			{ frame = "TaxiFrame", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "TaxiMerchant", close = "TaxiCloseButton", medallion = "map",
				keep = { "^TaxiMap$" } },
			{ frame = "ItemTextFrame", insets = { 24, 40, 14, -34 }, offset_y = -4, title = "ItemTextTitleText", close = "ItemTextCloseButton",
				parchments = { "ItemTextScrollFrame" }, ink = { "ItemTextPageText" }, background = "emblem" }, -- stone and marble plaques too
			{ frame = "QuestFrame", insets = { 24, 40, 14, -34 }, offset_y = -4, title = "QuestFrameNpcNameText", close = "QuestFrameCloseButton", medallion = "grail", background = "emblem",
				subframes = { "QuestFrameGreetingPanel", "QuestFrameDetailPanel", "QuestFrameProgressPanel", "QuestFrameRewardPanel" },
				parchments = { "QuestGreetingScrollFrame", "QuestDetailScrollFrame", "QuestProgressScrollFrame", "QuestRewardScrollFrame" } },
			{ frame = "GossipFrame", insets = { 24, 40, 14, -34 }, offset_y = -4, title = "GossipFrameNpcNameText", close = "GossipFrameCloseButton", background = "emblem",
				subframes = { "GossipFrameGreetingPanel" }, parchments = { "GossipGreetingScrollFrame" } },
			{ frame = "TabardFrame", insets = { 24, 40, -6, -9 }, offset_y = -4, title = "TabardFrameNameText", close = "TabardFrameCloseButton",
				keep = { "^TabardFrameBackground$", "^TabardFrameOuterFrame" }, pale = true },
			{ frame = "PetitionFrame", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "PetitionFrameNpcNameText",
				close = "PetitionFrameCloseButton", pale = true },
			{ frame = "GuildRegistrarFrame", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "GuildRegistrarFrameNpcNameText",
				close = "GuildRegistrarFrameCloseButton", pale = true },
			{ frame = "ArenaRegistrarFrame", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "ArenaRegistrarFrameNpcNameText",
				close = "ArenaRegistrarFrameCloseButton", pale = true },
			{ frame = "PetStableFrame", insets = { 24, 40, -10, -39 }, offset_y = -4, title = "PetStableTitleLabel",
				close = "PetStableFrameCloseButton", pale = true },
			{ frame = "DressUpFrame", insets = { 24, 40, -6, -9 }, offset_y = -4, title = "DressUpFrameTitleText",
				close = "DressUpFrameCloseButton", keep = { "^DressUpBackground" }, -- the race's backdrop behind the model
				-- its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
				places = { DressUpFrameDescriptionText = { "CENTER", "DressUpFrame", "TOP", -11, -50 } } },
			{ frame = "ClassTrainerFrame", addon = "Blizzard_TrainerUI", insets = { 24, 40, -10, -39 }, offset_y = -4,
				title = "ClassTrainerNameText", close = "ClassTrainerFrameCloseButton",
				lists = { "ClassTrainerListScrollFrame", "ClassTrainerDetailScrollFrame" } },
			{ frame = "TradeSkillFrame", addon = "Blizzard_TradeSkillUI", insets = { 24, 40, -10, -39 }, offset_y = -4,
				title = "TradeSkillFrameTitleText", close = "TradeSkillFrameCloseButton",
				lists = { "TradeSkillListScrollFrame", "TradeSkillDetailScrollFrame" } },
			{ frame = "MacroFrame", addon = "Blizzard_MacroUI", insets = { 24, 68, -10, -39 }, offset_y = -32, text = "CREATE_MACROS",
				close = "MacroFrameCloseButton", tabs = "MacroFrameTab", lists = { "MacroButtonScrollFrame", "MacroFrameScrollFrame" },
				keep = { "^MacroFrameSelectedMacroBackground$" } },
			{ frame = "InspectFrame", addon = "Blizzard_InspectUI", insets = { 24, 68, -6, -9 }, offset_y = -32, title = "InspectNameText",
				close = "InspectFrameCloseButton", tabs = "InspectFrameTab",
				subframes = { "InspectPaperDollFrame", "InspectPVPFrame", "InspectTalentFrame" },
				own_tabs = "InspectTalentFrameTab", -- the talent trees'
				keep = { "^InspectTalentFrameBackground" }, -- the tree's art (its spec's)
				hide = { "InspectTalentFrameCloseButton" }, -- the talent page's own X, under the window's
				-- the level line (the guild's under it) out of the band, over the model
				places = { InspectLevelText = { "BOTTOM", "InspectModelFrame", "TOP", 0, 22 } },
				lists = { "InspectTalentFrameScrollFrame" } },
			{ frame = "ItemSocketingFrame", addon = "Blizzard_ItemSocketingUI", insets = { 24, 40, 24, 36 }, offset_y = -4,
				text = "ITEM_SOCKETING", close = "ItemSocketingCloseButton", lists = { "ItemSocketingScrollFrame" } },
			{ frame = "AuctionFrame", addon = "Blizzard_AuctionUI", insets = { 24, 68, 24, 36 }, offset_y = -32, text = "AUCTIONS",
				close = "AuctionFrameCloseButton", tabs = "AuctionFrameTab", art = { "ui%-auctionframe%-" },
				hide = { "BrowseTitle", "BidTitle", "AuctionsTitle" }, -- the pages' own titles, under the tabs
				-- the results' rows start at their headers, left of their scroll frames
				lists = { "BrowseFilterScrollFrame", { "BrowseScrollFrame", 146 }, { "BidScrollFrame", 146 },
					{ "AuctionsScrollFrame", 144 } },
				-- Auctionator's pages too: its title gone (the tabs say it), its
				-- lists and the sell column on their black, Blizzard's tabs over
				-- its results; the pages' bottom rows lower, nearer the frame
				late = { hide = { "AuctionatorTitle" },
					panels = { { "Atr_Hlist", { 6, 6, 30, 6 } }, { "Atr_SellControls", { 0, 0, 0, 0 } } },
					dropdowns = { "BrowseDropDown", "PriceDropDown", "DurationDropDown", "Atr_DropDownSL", "Atr_Duration" },
					tabs = "Atr_ListTabsTab", lower = 14,
					lower_in = { "AuctionFrame", "AuctionFrameBrowse", "AuctionFrameBid", "AuctionFrameAuctions", "Atr_Main_Panel" } } },
			{ frame = "GuildBankFrame", addon = "Blizzard_GuildBankUI", insets = { 24, 68, 24, 36 }, offset_y = -32, text = "GUILD_BANK", medallion = "chest", background = "leather",
				tabs = "GuildBankFrameTab", art = { "ui%-guildbankframe%-left", "ui%-guildbankframe%-right" } },
			{ frame = "KeyBindingFrame", addon = "Blizzard_BindingUI", insets = { 24, 40, 24, 36 }, panel = false,
				title = "KeyBindingFrameHeaderText", lists = { "KeyBindingFrameScrollFrame" } }
		}
	},
	-- the Group Bulletin Board addon's window in Diablo III's
	-- (modules/blizzard/bulletinboard.lua): the window grows around its
	-- frame (its list starts 30 down, its buttons 10 in from the sides)
	bulletin_board = {
		insets = { 20, 44, 20, 18 },
		header_height = 40,
		header_insets = { 24, 24 },
		button_gap = 6, -- its settings button, left of the close button
		list_panel_insets = { 2, 4, 26, 4 } -- its scroll bar inside on the right
	},
	-- the Dungeon Finder and the Raid Browser in Diablo III's
	-- (modules/blizzard/lfg.lua): the window grows around Blizzard's
	-- 355x440 frames, whose parts are placed against them
	lfg = {
		header_height = 40,
		header_insets = { 24, 24 },
		dungeons = {
			insets = { 24, 40, 34, 2 }, -- its lists 40 in from the sides, Find Group and Close under them (the window 44 shorter: the lists raised)
			offset_y = -4 -- the window's top with the others'
		},
		raids = {
			insets = { 16, 68, 12, 30 }, -- up over the band and the tabs
			offset_y = -32
		},
		tab_offset = { 4, 1 },
		tab_inset = 8,
		tab_font = DiabolicFont_HeaderRegular10,
		list_panel_insets = { 6, 6, 28, 6 },
		comment_right = 21, -- the Raid Browser's comment button, from its right (List Me is 21 from its left)
		button_margin = 50, -- the Dungeon Finder's buttons, from the window's sides (the iron frame is 36)
		button_bottom = 50, -- and from its bottom
		header_color = { 1, .6, .2 }, -- the random dungeon's titles, as the quest log's
		text_color = { .9, .86, .8 },
		type_y = -84, -- the dungeon's dropdown's middle, from the window's top (under the band)
		type_width = 230, -- its middle: room for the longest choice
		roles_top = -110, -- the roles' row, from the window's top (Blizzard's 100 down), under the dropdown
		lists_raise = 18 -- the random dungeon and the list, up into the dropdown's old room
	},
	-- the spellbook in Diablo III's (modules/blizzard/spellbook.lua), laid
	-- out as Pretty GUI's: wide, the spells in two columns of six with
	-- their names, the schools down its left, the companions and mounts in
	-- their own tabs. Offsets from the window's top left.
	spellbook = {
		insets = { 0, 36, 166, 0 }, -- the window over Blizzard's 384x512 frame, as the character window's: 550 wide
		header_height = 40,
		header_insets = { 24, 24 },
		tab_offset = { 4, 1 }, -- the first tab, under the band
		tab_height = 32, -- Blizzard's tabs are 64 high for their art
		tab_gap = 2,
		tab_inset = 3,
		tab_padding = 28, -- around their text
		-- the schools (Blizzard's side tabs): the book's bookmarks, their
		-- icons over its right edge
		schools = { 482, -116 }, -- the first's icon
		school_size = 28,
		school_gap = 16,
		-- the ribbon under each: its notched end (the reputation's red
		-- ribbon's), out to the window's iron
		school_ribbon = {
			texture = path .. [[textures\DiabolicUI_D3_Ribbon_Gold2.tga]], -- its gold filigree: clear on the leather
			coords = { .63, 1, .078, .926 },
			left = 6, right = 26, pad = 4
		},
		-- an open book: two pages (x, y, width, height), a shadow in the fold
		book = { 30, -100, 464, 412 }, -- the window's leather left and right of it, the index tabs on the right
		fold_width = 22,
		fold_alpha = .45,
		-- the spells on its pages, a column on each: the icon, its name and
		-- rank in ink right of it
		spells = { 46, -112 }, -- the first slot
		slot_size = { 200, 45 },
		slot_pitch = { 232, 52 }, -- from a slot to the next, across and down: a page
		icon_inset = 4, -- the icon from the slot's left
		name_offset = 12, -- the name from the icon, past its border
		name_width = 145,
		name_font = DiabolicFont_SansBold12,
		rank_font = DiabolicFont_SansRegular10,
		rank_color = { .4, .3, .2 }, -- lighter ink
		passive_color = { .4, .3, .2 }, -- the passive ones' names (Blizzard's grey)
		-- the bottom row: Blizzard's "all ranks" box on the left, the pages on the right
		ranks_box = { 46, -470 },
		pages = { -76, -470 }, -- the next page's top right, from the window's top right
		page_gap = 4,
		page_color = { .86, .76, .6 }, -- the companions' pages (on stone)
		-- the companions and mounts: a cover over the spells (inside the
		-- iron frame, under the tabs), the model in a panel on top, the
		-- companions in three columns of four under it
		cover_insets = { 23, 97, 23, 23 }, -- up to the iron frame and the tabs' strip: nothing of the book shows past it
		cover_level = 6, -- over the spells' buttons and their cooldowns
		model_panel = { 12, -15, 480, 160 }, -- in the cover
		model_inset = 4,
		summon_size = { 140, 24 },
		summon_offset = 10, -- from the panel's bottom
		name_top = -10, -- the chosen one's name, from the panel's top
		companions = { 12, -185 }, -- the first slot, in the cover
		companion_slot_size = { 156, 45 },
		companion_pitch = { 162, 48 },
		companion_name_width = 98,
		companion_pages = { -12, -387 } -- the next page's top right, in the cover
	},
	-- Immersion's dialogue box in Diablo III's (modules/blizzard/immersion.lua)
	immersion = {
		-- warm stone in bronze lines
		backdrop = {
			bgFile = path .. [[textures\DiabolicUI_Tooltip_Background.tga]],
			edgeFile = path .. [[textures\DiabolicUI_Tooltip_Body.tga]],
			edgeSize = 32,
			tile = true,
			tileSize = 256,
			insets = { left = 3, right = 3, top = 3, bottom = 3 }
		},
		backdrop_color = { .6, .45, .38, .92 },
		backdrop_border_color = { 71/255 * 3.5, 56/255 * 3.5, 28/255 * 3.5, 1 },
		-- the panel in Immersion's 570x155 box: from the model's centre (its
		-- 115 model at 21, 21), the portrait out over its top as Diablo
		-- III's, their bottoms together
		panel_insets = { 78, -44, 0, 17 }, -- left, top, right, bottom offsets
		close_offset = { -10, -10 }, -- the windows' close button, in the panel's corner
		mark_gap = 6, -- the quest's mark, left of it
		hilite_color = { 0, 0, 0, 0 }, -- the box under the mouse: only the red edge
		-- the dialogue options: darker rows, a red edge on the one in focus
		option_backdrop_color = { 0, 0, 0, .6 },
		option_focus_backdrop = {
			edgeFile = path .. [[textures\DiabolicUI_Tooltip_Small.tga]],
			edgeSize = 32
		},
		-- the NPC's model on black in the panel's bronze lines, just
		-- outside it
		model_backdrop_color = { .06, .05, .05, 1 },
		portrait_padding = 4,
		name_font = DiabolicFont_SerifRegular18,
		name_color = { .86, .66, .42 }, -- Diablo III's gold
		name_offset = { 76, -10 }, -- from the panel's top left: 14 right of the portrait
		text_bottom_right = { -42, 10 }, -- the text's room, from the panel's bottom right
		text_color = { .95, .95, .95 }
	},
	loot = {
		-- This builds its own standalone loot window (see
		-- modules/blizzard/lootframe.lua) instead of re-skinning Blizzard's
		-- own live LootFrame - so every size/position below is something we
		-- fully own and control, not a guess about somebody else's layout.
		position = { "CENTER", 200, 0 }, -- relative to UIParent itself (plain SetPoint, not Engine's "UICenter" keyword - see CreateWindow for why)
		width = 260, -- minimum/default content width, grows for longer item names
		top_padding = 44, -- room left for the title before the first row
		bottom_padding = 12,
		row_padding = 15, -- gap kept from the window's own left/right border to each row

		-- Same window skin as GameTooltip's own border, so it reads as the
		-- same "Diablo tooltip" family as the rest of the UI.
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
		backdrop_color = { 0, 0, 0, .95 },
		backdrop_border_color = { 1, 1, 1, 1 },
		title_font = DiabolicFont_HeaderRegular18Title,
		title_offset = { 0, -16 }, -- relative to the window's own TOP
		close_button_offset = { -8, -8 }, -- the windows' close button (windows.lua), in the window's top right corner, clear of the centered title

		icon = {
			-- crops the outer bleed baked into most item icon textures
			texcoords = { 5/64, 59/64, 5/64, 59/64 },
			size = 44,
			icon_padding = 5, -- gap kept between the icon and the row's own edges, on every side (also what defines row height: size + icon_padding*2)
			-- the 44x44 border set's own canvas/offset convention, same as
			-- the action bar buttons that use it elsewhere in this addon
			border_size = { 64, 64 },
			border_offset = { -10, 10 }, -- relative to the icon's own TOPLEFT
			border_texture = path .. [[textures\DiabolicUI_Button_44x44_Border.tga]],
			border_texture_highlight = path .. [[textures\DiabolicUI_Button_44x44_BorderHighlight.tga]]
		},
		row = {
			gap = 5, -- vertical space kept between one row and the next
			text_font = DiabolicFont_SansBold12,
			text_offset = 10, -- gap kept between the icon and the item name text
			text_padding = 10, -- room left after the text before the row's own right edge
			-- the wide ornate button background used for the gamemenu's own
			-- big buttons. Its visible art (size) only fills part of its own
			-- texture canvas (texture_size, with transparent padding around
			-- it), so matching a row's actual size means scaling the whole
			-- canvas up by that same ratio - sizing it to just the row's
			-- pixel dimensions would render the visible art far smaller.
			size = { 300, 51 }, -- the visible button art's own design size
			texture_size = { 512, 128 }, -- the full canvas it sits within
			texture = {
				normal = path .. [[textures\DiabolicUI_UIButton_300x51_Normal.tga]],
				highlight = path .. [[textures\DiabolicUI_UIButton_300x51_Highlight.tga]],
				pushed = path .. [[textures\DiabolicUI_UIButton_300x51_Pushed.tga]]
			}
		}
	},
	-- the master looter's rolls (modules/blizzard/rollwindow.lua), in the
	-- loot window's look: its backdrop, title and icon border
	rolls = {
		position = { "TOP", 0, -160 }, -- relative to UIParent, as the loot window's
		width = 44 + 8 + 3 * 110 + 2 * 8, -- the icon, then the three buttons
		side_padding = 15,
		top_padding = 44, -- room for the title
		bottom_padding = 14,
		row_height = 14 + 4 + 8 + 6 + 22, -- the name, the bar, the buttons
		row_gap = 10,
		gap = 8,
		seconds = 15, -- when the message doesn't say
		main_spec = 100, -- /roll 100
		off_spec = 99, -- /roll 99
		name_font = DiabolicFont_SansBold12,
		time_font = DiabolicFont_SansBold10,
		result_font = DiabolicFont_HeaderRegular12,
		bis_font = DiabolicFont_SansRegular10, -- BiS-Tooltip's ranks, under the buttons
		bis_color = { .1, 1, .1 },
		bis_height = 4 + 10,
		bar = {
			height = 8,
			color = { 1, .82, 0 },
			texture = path .. [[statusbars\DiabolicUI_StatusBar_128x16_Normal_Warcraft.tga]]
		},
		-- the loot window's row buttons, scaled as a whole to this width
		button = {
			size = { 110, 22 },
			art_size = { 300, 51 },
			texture_size = { 512, 128 },
			font = DiabolicFont_HeaderRegular12,
			texture = {
				normal = path .. [[textures\DiabolicUI_UIButton_300x51_Normal.tga]],
				highlight = path .. [[textures\DiabolicUI_UIButton_300x51_Highlight.tga]],
				pushed = path .. [[textures\DiabolicUI_UIButton_300x51_Pushed.tga]]
			}
		}
	},
	-- the boss's loot coming up, posted by the master looter (lootpreview.lua)
	preview = {
		position = { "RIGHT", -110, 60 }, -- relative to UIParent, left of the side bars
		width = 220,
		side_padding = 12,
		top_padding = 40, -- room for the title
		bottom_padding = 12,
		row_height = 22,
		icon_size = 20,
		gap = 6,
		title_font = DiabolicFont_HeaderRegular12,
		name_font = DiabolicFont_SansBold12,
		waiting_alpha = .6, -- the items not rolled yet, dimmer than the one being rolled
		rolling_color = { 1, .82, 0, .15 } -- behind the one being rolled
	},
	-- the stack split box (shift-click a stack) as Diablo III's
	-- (modules/blizzard/stacksplit.lua): parts of one atlas, places in the
	-- art's pixels from the frame's top left, drawn at `scale`
	stacksplit = {
		texture = path .. [[textures\DiabolicUI_D3_StackSplit.tga]],
		atlas_size = { 512, 256 },
		scale = .8,
		panel = { 22, 14, 213, 89 }, -- its stone inside its own frame: x, y, width, height
		border = 24, -- our iron around it (its edge's solid part ends 24 in)
		text = { 106.5, -21 }, -- the count's middle, in the black field
		left = { 22, -21 }, right = { 191, -21 }, -- the arrows' middles, in their boxes
		okay = { 11, -47 }, cancel = { 114, -47 }, -- the buttons' top lefts, on their slots
		button = { 88, 33 },
		button_states = { normal = { 0, 128 }, lit = { 96, 128 }, dark = { 192, 128 } },
		arrow_size = 26,
		arrows_y = 168,
		arrows = { -- each state's x
			left = { normal = 32, lit = 128, pushed = 224, disabled = 160 },
			right = { normal = 64, lit = 192, pushed = 96, disabled = 0 }
		}
	},
	mirrortimers = {
		position = { "TOP", "UIParent", "TOP", 0, -300 }, -- default anchor -180
		positionOffsetByOne = { "TOP", "UIParent", "TOP", 0, -(300 + 50) }, -- notch it 1 bar down (give room for the capture bar)
		padding = 50, -- padding from one bar to the next
		font_object = DiabolicFont_SansBold13,
		backdrop_texture = path .. [[textures\DiabolicUI_Target_227x15_Backdrop.tga]],
		texture = path .. [[textures\DiabolicUI_Target_195x13_Border.tga]],
		texture_size = { 512, 64 },
		texture_position = { "TOP", 0, 25 },
		statusbar_texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]],
		spark_size = { 128, 128 },
		spark_texture = path .. [[statusbars\DiabolicUI_StatusBar_128x128_Spark_Warcraft.tga]]
	},
	tooltips = {
		position = { "BOTTOMRIGHT", -(30 + 8), 20 + 55 + 20 + 10 }, -- relative to UICenter
		offsets = { 8, 8, 8, 8 + 4 },
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
		backdrop_color = { 0, 0, 0, .95 },
		backdrop_border_color = { 1, 1, 1, 1 },
		dummy_backdrop = {
			bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
			edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
			tile = false,
			edgeSize = 16,
			insets = { 
				left = 5,
				right = 4,
				top = 5,
				bottom = 4
			}
		},
		-- the menus (dropdowns, right-click) as Diablo III's: its stone in
		-- its iron, a groove between lines, the hovered one in a red box;
		-- parts of one atlas ({ x, y, width, height })
		menu = {
			texture = path .. [[textures\DiabolicUI_D3_Menu.tga]],
			atlas_size = 512,
			art = { 264, 382 }, -- the panel, at the atlas's top left
			corner = 16, -- its iron, in the art
			edge = 12, -- its iron on screen
			offsets = { 0, 0, 0, 0 }, -- past the menu's sides (Blizzard's lines are 15 in)
			groove = { 0, 400, 244, 8 },
			groove_height = 4,
			highlight = { 0, 416, 244, 31 },
			arrow = { 256, 400, 16, 19 },
			arrow_size = { 9, 11 }
		},
		dummy_backdrop_color = { 0, 0, 0, .95 },
		dummy_backdrop_border_color = { .3, .3, .3, 1 },
		statusbar = {
			size = 3,
			offsets = { -2, -2, 0, -(1 - 4) }, -- make the bar align to the backdrop border edges
			texture = path .. [[statusbars\DiabolicUI_StatusBar_512x64_Dark_Warcraft.tga]]
		}
	},
	totembar = {
		position = { "BOTTOM", "Main", "TOP", 0, 60 }
	},
	vehicleseat = {
		position = { "CENTER", "UIParent", "CENTER", -224, 0 }
	}
})
