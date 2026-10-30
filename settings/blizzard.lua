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
		-- the title on the window's top edge (the band left to its own
		-- controls): Diablo III's skills pane's plate, its art 512 x 70 in
		-- its 512 x 128 file, its name in its inlay
		title_plate = {
			texture = path .. [[textures\DiabolicUI_D3_TitlePlate.tga]],
			rows = 70/128,
			width = 300,
			height = 41,
			y = -13, -- its middle, from the window's top: on the iron
			text_width = 200, -- its inlay (between its crosses)
			-- longer titles: the plate wider (its plain stretches between its
			-- ends and its middle drawn out), up to `max_width`
			file_width = 512,
			cuts = { 96, 140, 376, 420 }, -- its pieces, in its file's pixels: the 2nd and 4th stretched
			max_width = 440,
			side_room = 62, -- and short of the window's sides by this much (the X's socket)
			text_offset = 1, -- from its middle; Exocet's capitals sit low
			font = DiabolicFont_HeaderRegular14,
			color = { .86, .76, .6 }, -- Diablo III's pale gold
			-- a window's icon (the spec, the profession) socketed in its
			-- left cross: round in the minimap's spiked bronze ring (cut to
			-- its spikes, 64 square: a TGA drawn far smaller than its file
			-- looks jagged)
			gem = {
				ring = path .. [[textures\DiabolicUI_D3_GemRing.tga]],
				size = 40,
				x = 35, -- its middle from the plate's left end: on the cross
				y = 0,
				glass = .66, -- the icon, of its size: its edge under the ring
				glass_offset = { 0, 0 } -- the icon's middle from the ring's
			}
		},
		-- a checkbox (StyleCheckBox): Diablo III's options' box, 42 x 43 at
		-- the top left of each 64 x 64 slot of its file: empty, its frame
		-- alone lit (under the mouse), checked
		check_box = {
			texture = path .. [[textures\DiabolicUI_D3_CheckBox.tga]],
			box = { 0, 42/256, 0, 43/64 },
			lit = { 64/256, 106/256, 0, 43/64 },
			checked = { 128/256, 170/256, 0, 43/64 },
			size = 20,
			pushed_color = { .7, .7, .7 },
			label_gap = 4, -- its label from it
			font = DiabolicFont_SansBold12, -- its label, in the title's gold
			stacked = { size = 16, font = DiabolicFont_SansBold10 } -- two one under the other in a band: within its height
		},
		-- a window's painted background over its stone, inside the iron, as
		-- big as the window without stretching (cut to its shape): Diablo
		-- III's, one per kind of window (`aspect`, its art's width / height)
		backgrounds = {
			smoke = { texture = path .. [[textures\DiabolicUI_D3_BackgroundSmoke.tga]], aspect = 1.218 }, -- a demon in red smoke (the options')
			-- Diablo III's floors (dungeons', an inn's), darkened, in tiles (`tile`: their size)
			slabs = { texture = path .. [[textures\DiabolicUI_D3_BackgroundStoneSlabs.tga]], tile = 256, color = { 1, 1, 1, 1 } }, -- Tristram's flooded dungeon (mail, trade, banks, registrars)
			floor = { texture = path .. [[textures\DiabolicUI_D3_BackgroundWoodenFloor.tga]], tile = 256, color = { 1, 1, 1, 1 } }, -- Tristram's inn's planks (vendors)
			lava = { texture = path .. [[textures\DiabolicUI_D3_BackgroundCraterLava.tga]], tile = 384, color = { 1, 1, 1, 1 } }, -- the Arreat Crater's rock, its lava faint (PvP, battlemasters)
			tiles = { texture = path .. [[textures\DiabolicUI_D3_BackgroundZoltunTiles.tga]], tile = 320, color = { 1, 1, 1, 1 } }, -- Zoltun Kulle's slate tiles, carved arches (dungeon finder)
			zoltun = { texture = path .. [[textures\DiabolicUI_D3_BackgroundStoneZoltun.tga]], tile = 384, color = { 1, 1, 1, 1 } }, -- Zoltun Kulle's library (NPC talk, trainers, macros, bindings, socketing, achievements)
			cracked = { texture = path .. [[textures\DiabolicUI_D3_BackgroundStoneCracked.tga]], tile = 384, color = { 1, 1, 1, 1 } }, -- the Arreat Crater (social, Bulletin Board, arena registrar)
			artisan = { texture = path .. [[textures\DiabolicUI_D3_BackgroundArtisan.tga]], aspect = .776 }, -- Diablo III's artisans' leather, its rivets (professions: stretched to their window)
			cliffs = { texture = path .. [[textures\DiabolicUI_D3_BackgroundCliffs.tga]], aspect = 1.603 }, -- a camp under the falls, The Art of Wrath of the Lich King's (quest log, quest givers)
			fortress = { texture = path .. [[textures\DiabolicUI_D3_BackgroundFortress.tga]], aspect = .821 }, -- a fortress in flames, The Art of Wrath of the Lich King's (unused: PvP's is the lava)
			saron = { texture = path .. [[textures\DiabolicUI_D3_BackgroundSaron.tga]], aspect = 1.643 }, -- the Pit of Saron, The Art of Wrath of the Lich King's (raid browser)
			street = { texture = path .. [[textures\DiabolicUI_D3_BackgroundStreet.tga]], aspect = 2.129 }, -- Dalaran's streets (auction house)
			dome = { texture = path .. [[textures\DiabolicUI_D3_BackgroundDome.tga]], aspect = 1.043 }, -- the Violet Hold (copy chat)
			waypoint = { texture = path .. [[textures\DiabolicUI_D3_BackgroundWaypoint.tga]], aspect = .628 } -- Diablo III's waypoint window's, red-veined (flight master)
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
		-- Diablo III's materials for a window's zones (docs/reports/window-materials.adoc),
		-- cropped from its UI atlases: `size`, the crop's pixels (its file
		-- is resized to a power of two); `border`, its edge in them, kept
		-- unstretched when the zone is sliced in nine
		materials = {
			parchment = { texture = path .. [[textures\DiabolicUI_D3_Material_Parchment2.tga]], size = { 484, 480 }, border = 18 }, -- the artisans' recipe: text to read
			lined = { texture = path .. [[textures\DiabolicUI_D3_Material_ParchmentLined.tga]], size = { 350, 354 }, border = 14 }, -- the artisans' order: text written
			page = { texture = path .. [[textures\DiabolicUI_D3_Material_ParchmentTall.tga]], size = { 404, 580 }, border = 18 }, -- the lore journal's: a long text
			slate = { texture = path .. [[textures\DiabolicUI_D3_Material_Slate.tga]], size = { 1422, 842 }, border = 24 }, -- the extended experiences' grey stone: lists, tables
			leather = { texture = path .. [[textures\DiabolicUI_D3_Material_Leather.tga]], size = { 752, 832 }, border = 18 }, -- the achievements' leather: rosters, collections
			planks = { texture = path .. [[textures\DiabolicUI_D3_Material_Planks.tga]], size = { 463, 729 }, border = 18 }, -- the journal's entries: one under the other
			studded = { texture = path .. [[textures\DiabolicUI_D3_Material_Studded.tga]], size = { 368, 751 }, border = 62 }, -- the blacksmith's iron plate, its rivets in its edges: the merchant's counter
			pane = { texture = path .. [[textures\DiabolicUI_D3_Material_Pane.tga]], size = { 936, 904 }, border = 110, scale = .25 }, -- the skills pane (its title plate and the band over it cut, its top left quarter mirrored both ways; its corners' curls in its border): models, slots
			pane_open = { texture = path .. [[textures\DiabolicUI_D3_Material_PaneOpen.tga]], size = { 936, 904 }, border = 36, scale = .25 }, -- the pane's frame alone, clear inside: around a picture
			footer = { texture = path .. [[textures\DiabolicUI_D3_Material_Footer.tga]], size = { 563, 205 }, border = 20 }, -- the stash's foot: money, buttons
			rows = { texture = path .. [[textures\DiabolicUI_D3_Material_Rows.tga]], size = { 345, 392 }, border = 10 } -- the blacksmith's grooved list
		},
		material_scale = .4, -- their edges' size on screen, of their art's (a material's `scale` instead)
		pane_outset = 6, -- a pane (a model's, slots') past what it holds
		footer_margin = 6, -- a window's foot (its rough stone, inside its iron frame): over its buttons' top
		-- the iron bar along the foot's top: the frame's left edge (its file's
		-- first 32px), turned; `cut`, the part of it drawn (the bar and its
		-- shadows), `bar`, the bar itself (from the window's edge, as drawn)
		footer_rail = { cut = { 12, 28 }, bar = { 15, 24 } },
		hint = { font = DiabolicFont_SansRegular12, color = { .5, .45, .4 }, inset = 2 }, -- an edit box's label pale in it while it's empty: its look, from its left
		-- the rules every window's layout follows (windows.lua), and that
		-- /dui layout checks: buttons on a row (LineRows), the band's
		-- controls (LineBand), the content's room
		layout = {
			button_gap = 6, -- between buttons on a row: those closer narrowed, as wide in all
			band_edge = 10, -- the band's first control (its art), from its left end
			band_gap = 12, -- between the band's controls (their art)
			band_right_edge = 48, -- the band's last control on its right, from its right end (short of the X's socket)
			content_gap = 6, -- the least room over the content (its zones and parchments) and under it
			uneven = 8 -- the most room over it may differ from the room under it
		},
		-- Diablo III's bars for a row: the chosen one (copper), a section's
		-- or a column's header (dark)
		row_bars = {
			lit = path .. [[textures\DiabolicUI_D3_Material_BarLit.tga]],
			dark = path .. [[textures\DiabolicUI_D3_Material_BarDark.tga]],
			header = path .. [[textures\DiabolicUI_D3_Material_Header.tga]] -- a zone's title with its seal
		},
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
			-- Diablo III's breath meter: a thin frame with metal caps, its red
			-- fill over its faint track
			texture = path .. [[textures\DiabolicUI_D3_BreathMeter.tga]],
			canvas = { 256, 64 },
			art = { 12, 10, 202, 35 }, -- the frame's inside: the bar
			left = { 0, 14 }, middle = { 14, 200 }, right = { 200, 214 },
			statusbar = path .. [[textures\DiabolicUI_D3_BreathMeterFill.tga]],
			track = path .. [[textures\DiabolicUI_D3_BreathMeterTrack.tga]],
			color = { 1, 1, 1 }, -- the fill's own red
			spike = 8 -- how far its caps reach past the bar
		},
		-- the windows' tabs as Diablo III's hero banners hanging from the
		-- window's foot (windows.lua, HangTabs): dark cloth in gold trim with
		-- an emblem, the chosen one red and hanging lower, the name on hover
		-- (built from Diablo III's banner art: its Knight003 shape)
		banner = {
			cloth = path .. [[textures\DiabolicUI_D3_BannerCloth.tga]], -- white, its folds kept: dyed here
			trim = path .. [[textures\DiabolicUI_D3_BannerTrim.tga]],
			sigils = path .. [[textures\DiabolicUI_D3_BannerSigils.tga]], -- white, dyed here
			-- the emblems in the atlas, 64 square, 8 to a row (Diablo III's names)
			sigil_names = {
				"hoodedface", "WolfHead", "shield", "hellforge", "stein", "openbook", "owl", "horse",
				"crow", "TwoHeadHawk", "lion", "AllSeeing", "time", "star", "sword", "flames",
				"tree", "wizardhat", "sun", "scarab", "fleur", "skullcrossbones", "Clover", "orbLight",
				"summoningrune", "pentagram", "monkRune", "gryphon", "khalimswill", "leoric_crown", "swan", "Demon"
			},
			sigil_columns = 8,
			sigil_rows = 4,
			fallback = "star", -- a tab with no emblem of its own (an addon's)
			width = 52, -- the banner: its art fills its 128 x 256 canvas
			height = 104,
			tuck = 22, -- its top (the rod's notches) not drawn: it starts under the rail
			drop = 12, -- the chosen one that much longer
			gap = 6,
			left = 28, -- the first one's left, from the window's (Blizzard's tabs start at the left too)
			shadow = 14, -- the rail's shadow down each one's top
			shadow_alpha = .8,
			-- the iron rail they hang from, along the window's foot: Diablo
			-- III's dark plate with its gold ends, bronze edged (its ends
			-- kept, its middle stretched)
			rail = {
				texture = path .. [[textures\DiabolicUI_D3_BannerRail.tga]],
				height = 18,
				up = 19, -- its top under the window's iron (15 to 24 in from its edge)
				overhang = 10, -- past the first and last banners
				cap = 26/512, -- each end, of its file's width
				cap_width = 9,
				rows = 1
			},
			-- the bronze clasps holding each to the rail, over its trim's sides
			clasp = {
				texture = path .. [[textures\DiabolicUI_D3_BannerClasp.tga]],
				width = 8,
				height = 20,
				x = { 4, 48 }, -- their middles, from the banner's left
				y = 2, -- their middles, over the rail's bottom
				color = { .85, .85, .85 } -- a little darker: as worn as the trim
			},
			sigil_size = 30,
			sigil_y = -38, -- the emblem's middle, from the banner's top: in its cloth
			icon_size = 26, -- a WoW icon in its place, round
			cloth_color = { .13, .11, .1 }, -- near black, as the window's stone
			chosen_color = { .45, .07, .05 }, -- deep red
			sigil_color = { .72, .6, .4 },
			chosen_sigil_color = { 1, .85, .55 },
			lit_alpha = .25, -- the cloth lit under the mouse
			lit_color = { .9, .3, .18 }, -- warm (white turns the dark cloth grey)
			name_font = DiabolicFont_Hidden -- its text: the name shows on hover instead
		},
		tab_row = 32, -- the tab row under the band: taken out of a window whose tabs hang
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
			-- ends at the middle of the window's iron, the X inside: its top
			-- and right on the middle of the window's iron, its left and
			-- bottom on the middle of the socket's (one frame round it)
			socket_size = 62, -- from the window's corner to its bars' outside: the X (22) and the two irons' halves (20 each)
			socket_inset = 20, -- the middle of the window's iron
			socket_corner = path .. [[textures\DiabolicUI_D3_SocketCorner.tga]], -- the left edge's art mitred with itself
			socket_color = { 0, 0, 0, 1 }
		},
		-- the dropdowns, in Diablo III's dropdown plate
		edit_padding = 8, -- an edit box's plate (the dropdowns'), past its sides
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
		},
		pager_size = 26, -- the page buttons (back, on): the scroll bars' arrows turned
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
		insets = { 0, 64, 0, 18 }, -- the window past Blizzard's frame: up over the band, down past the lists' panels
		offset_y = 32, -- Blizzard's frame up into its tabs' old row (the tabs hang from the foot): the lists 6 under the band
		header_height = 48, -- the red band
		header_insets = { 24, 24 }, -- inside the iron frame, its solid part
		tab_sigils = { "star", "sun" }, -- the tabs' emblems (window.banner's): achievements, statistics; an addon's get the default
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
		filter_padding = 8, -- and padded in from the band's left end
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
		row_color = { .5, .3, .2 },
		row_color_unearned = { .36, .32, .29 },
		row_text_color = { .95, .9, .82 },
		row_title_color = { .8, .45, .35 },
		row_title_color_unearned = { .5, .45, .42 }
	},
	-- the character window in Diablo III's (modules/blizzard/character.lua)
	character = {
		-- the window over Blizzard's frame: { left, top, right, bottom },
		-- positive outward. Wider and taller than Blizzard's panel art, for
		-- room around the slots; the other tabs are moved by `content_offset`
		-- into the middle of it.
		-- No band (nothing in it): Blizzard's frame up by its height
		-- (UIPanelLayout's), the window's top where it was, its foot higher.
		insets = { 0, -4, 18, -18 }, -- up over the tabs
		content_offset = { 19, -20 },
		-- the character tab in two columns, laid out from the window's edges:
		-- the gear around a tall model on the left (as wide as the window on
		-- the other tabs), the GearScore and stats, the titles and the
		-- equipment sets in pages on the right, the window wider for it
		-- (`wide_insets`, as `insets`)
		paperdoll = {
			wide_insets = { 0, 36, 266, -30 }, -- (its foot 6 under the weapons' row, past the iron)
			pane_width = 418, -- the gear's column
			slot_margin = 38, -- the slot columns from its sides
			slot_top = -66, -- from its top, under the iron (the model's panel 6 under it, as the stats')
			slot_gap = 4,
			title_top = -60, -- the title's dropdown, from its top (out of sight: the titles' page has them)
			model_top = -66, -- the model's top, from its top: with the slots'
			model_size = { 240, 314 }, -- between the slot columns, 14 from each; as tall as them (its bottom where it was)
			model_panel_inset = 4, -- the panel around it
			-- its frame past the panel, up and down: the character larger and
			-- lower in it, on the scene's floor (the dressing room's is so)
			model_reach = { 26, 32 },
			weapon_top = -10, -- the weapons' row, under the model's panel
			weapon_gap = 6,
			ammo_size = 27, -- Blizzard's ammo slot, in the action buttons' border
			-- the right column: the level, two groups of stats (Blizzard's
			-- choice, a click on their title bar shows the next)
			stats = {
				left = -14, -- from the gear's column's right
				top = -62, -- (6 under the iron)
				right = 38, -- from the window's right (inside its iron frame): as far as the gear's from its left
				bottom = 28,
				padding = 6, -- top and bottom
				side_padding = 24, -- inside the stats panel's light line (~19 in)
				header_height = 16,
				header_gap = 2, -- under each title bar
				line_height = 12,
				line_inset = 8, -- each line from the panel's sides
				group_gap = 10,
				-- the level in a pentagram's middle, the resistances on its points
				pentagram = {
					texture = path .. [[textures\DiabolicUI_D3_Pentagram.tga]], -- Diablo III's banner sigil (white: dyed), its middle in its file's
					size = 120,
					color = { .4, .02, .04, .95 }, -- dark blood
					shadow_color = { 0, 0, 0, .85 }, -- itself again under it, soaked into the stone
					shadow_offset = { 2, -2 },
					tip = .9, -- its points, of its half size from its middle
					-- each resistance's point (Blizzard's order: arcane, fire, nature,
					-- frost, shadow), as the elements' on an inverted pentagram: air
					-- left, fire up right, earth up left, water right, spirit down
					angles = { 198, 54, 126, -18, -90 },
					level_y = 2, -- the level, from its middle
					-- its glow: itself again, added, a little larger, its light
					-- slowly coming and going
					glow_color = { .6, 0, .05 },
					glow_scale = 1.04,
					glow_alpha = { .05, .3 },
					glow_period = 3, -- seconds, a pulse
					below = 12 -- the stats under it (the bottom point's resistance past it)
				},
				resistance_size = 26,
				resistance_crop = 3, -- Blizzard's bevel round each icon (of its 32 x 29), cut off
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
				bottom = 24, -- (its parchment as far in from the column's foot as from its sides)
				bar_room = 22, -- its scroll bar, right of it
				row_height = 16,
				font = { path .. [[fonts\NotoSans-Bold.ttf]], 11 }, -- bold, to read on the parchment
				parchment_insets = { 4, 4, 4, 4 }, -- the parchment around the list
				color = { .18, .12, .06 }, -- ink (the windows')
				worn_color = { .5, .1, 0 } -- red ink
			},
			score_font = { path .. [[fonts\ExocetBlizzardMedium.ttf]], 28 }, -- the level, in the pentagram: Diablo III's capitals
			stats_panel = path .. [[textures\DiabolicUI_D3_StatsPanel.tga]], -- Diablo III's (dark red, in its own line)
			stats_panel_inset = 3,
			-- the equipment manager (Blizzard's dialog, its frame hidden) on its page
			gear_manager = {
				height = 194, -- under its title bar, until its sets are laid out (then as their rows need)
				top = 8, -- its sets, from its top
				rows = { 3, 3, 4 }, -- the sets in each row; the icons right of the shorter ones
				set_gap = 8, -- between them
				row_gap = 14, -- room for their names
				names_height = 14, -- under the last row
				-- equip, save and delete as icons in a column right of the sets
				icons = path .. [[textures\DiabolicUI_Window_Icons.tga]], -- new, equip, delete, save
				icon_count = 4,
				equip = { size = 30, icon_size = 22 }, -- the one used most
				save = { size = 24, icon_size = 16 },
				delete = { size = 24, icon_size = 16, color = { 1, .25, .18 } },
				action_gap = 6,
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
		inspect_trees = { size = 28, gap = 6, offset = { -6, 12 } }, -- the inspected one's talent trees as icons: over the tree's panel (its inset 6, then a gap of 6)
		level_font = DiabolicFont_HeaderRegular14, -- the inspected one's "Level 80 Dwarf Priest", over the model
		token_popup_offset = { -8, -96 }, -- a currency's options, there too
		token_popup_close = 1, -- their X, in from their top right corner: its frame's top and right on their border line (both about 1-4 in), one border
		token_popup_box_gap = 6, -- between their two boxes
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
		tab_sigils = { "hoodedface", "WolfHead", "shield", "sword", "leoric_crown" }, -- the tabs' emblems (window.banner's): character, pet, reputation, skills, currency
	},
	-- the mailbox in Diablo III's (modules/blizzard/mail.lua): the windows
	-- grow around Blizzard's 384x512 frames, whose parts are placed against
	-- them (the letter's fields start 46 down)
	-- the auction house's pages on one grid (modules/blizzard/auction.lua),
	-- in its frame's units from its top left (y down); its window, band,
	-- tabs and foot are panels'
	auction = {
		-- the content's room: 16 in from the window's sides, 6 under the
		-- band, 6 over the foot's iron bar
		content = { left = -8, right = 840, top = 46, bottom = 413 },
		gap = 8, -- between two zones, and under the toolbar
		pad = 4, -- a zone's parts in from its edges
		toolbar = 24, -- Browse's row under the band: Reset, the results' count, the page arrows
		arrow_gap = 4,
		row_gap = 2, -- the first row under its column names
		header_height = 19,
		-- each page's results: their rows and scroll bar `width` wide in all
		-- (their rows' widest, without the bar: Blizzard's), in the middle of
		-- their zone; their rows that far right of their column names (Bids':
		-- left, their icon), their scroll frame's right that far right of
		-- the rows' left (Blizzard's)
		-- Browse: the categories' column too (their buttons and a scroll bar
		-- beside them, `inset` in from its sides), "no results" that far under
		-- the results' top; its categories' buttons red by their kind (a
		-- category, a subcategory, an item type)
		browse = { column = 178, inset = 10, filter_width = 136, width = 625, row_from = 9, reach = 602, no_results_y = 40,
			filter_alpha = { class = 1, subclass = .45, invtype = 0 } },
		bids = { width = 793, row_from = -38, reach = 771 },
		-- Auctions: the selling column too (Blizzard's parts, moved as one:
		-- right, up; its item's slot dark, framed)
		auctions = { column = 210, width = 601, row_from = 0, reach = 579, move = { -16, 2 },
			slot_texture = path .. [[textures\DiabolicUI_Button_64x64_Backdrop.tga]], slot_scale = 2 },
		-- Auctionator's page: its left column (its history, shopping lists
		-- or selling column) and the rest (the recommended price, its
		-- results), each moved as one (right, up)
		auctionator = { column = 212, left_move = { -15, 25 }, right_move = { 10, 25 } },
	},
	mail = {
		-- the rough stone foot up to each tab's highest button: the inbox's
		-- pages, the letter's buttons and money, the open one's
		footers = { inbox = "InboxPrevPageButton", send = "SendMailMailButton", open = "OpenMailCancelButton" },
		insets = { 16, 68, 0, -40 }, -- up over the band and the tabs
		offset_y = -32, -- the window's top with the others'
		open_insets = { 16, 68, 0, -40 }, -- the letter opened, its top with the inbox's
		open_gap = 8, -- between the two windows
		header_height = 40,
		header_insets = { 24, 24 },
		tab_sigils = { "crow", "TwoHeadHawk" }, -- the tabs' emblems (window.banner's): inbox, send
		-- the mail's parchment, from the inbox's top left: in the window's
		-- middle (its stone 8 to 360), up to under the band (its foot 28
		-- under the inbox's top), past the rows (28 or Postal's 48 to 333)
		-- and Postal's boxes on their left
		list_box = { 16, -36, 336, 369 }, -- left, top, width, height
		rows_top = -44, -- the first row's (Blizzard's and Postal's -80)
		rows_gap = 6, -- between the rows (Blizzard's 0): down to its old foot
		-- Postal's Open and Return in the band, side by side in its middle
		select_buttons = { width = 110, gap = 8 },
		-- the letter's To, Subject (their labels pale in them while empty)
		-- and postage (its sum alone) in the band, from its left; its text
		-- up under it
		send_band = {
			x = 10, -- the To box's plate's left
			name_width = 86, -- a name: 12 letters at most
			arrow_gap = 4, -- right of it: Postal's address book's arrow, that far from its plate
			arrow_width = 20, -- the arrow's room (its art: about 20 of its 25)
			gap = 10, -- between the parts (from a box's plate); the subject stretches up to the postage
			postage_right = 48, -- the sum's right, from the band's (left of Postal's menu)
			hint_font = DiabolicFont_SansRegular12,
			hint_color = { .5, .45, .4 }, -- as the spellbook's search's
			hint_inset = 2 -- from the box's left, with its text
		},
		text_rise = 55, -- the letter's text up, and that much taller
		send_text_lower = -13, -- its foot that much higher (6 over the attachments' pane)
		open_text_rise = 84, -- the letter opened's (its From and Subject in the band)
		open_text_lower = -16, -- its foot that much higher
		open_attachments_floor = 112, -- the attachments between the letter's panel and this, over the window's bottom (14 over the foot's iron)
		open_band = { x = 10, label_gap = 5 }, -- the letter opened's From and Subject in the band: their labels' left, from its left
		-- moved once, up: the money
		send_offsets = { SendMailMoneyButton = { 0, 10 } },
		page_offset = -24, -- Blizzard's page buttons, down from over its bottom
		postal_offsets = { -- Postal's: its checkboxes right, its Open All (and its menu's arrow) down between the pages, its menu onto the band
			PostalInboxCB = { 4, 0 }, PostalOpenAllButton = { 0, -22 }, Postal_ModuleMenuButton = { 0, 16 } },
		-- the rows' ink on the parchment: unread, read (grey in Blizzard's),
		-- the days left (its green or red)
		list_ink = { sender = { .4, .12, .04 }, subject = { .18, .12, .06 }, read = { .3, .24, .17 },
			days = { .16, .38, .08 }, expiring = { .65, .1, .05 } },
		text_panel_insets = { 6, 6, 28, 6 }, -- around a letter, its scroll bar inside on the right
		text_color = { .18, .12, .06 }, -- dark ink on the letter's parchment
		parchment_insets = { 4, 4, 4, 4 }, -- its text narrower than its scroll frame
		-- the attachments in a stone pane, between Blizzard's bar over them
		-- (it moves it with their rows: its name, how far under its top)
		-- and the window's bottom (how far over it), its sides in from the
		-- window's (Blizzard's margins)
		attachment_panes = {
			SendMailFrame = { "SendMailHorizontalBarLeft2", 1, 157, 25, 40 } -- (6 over the money to send)
		}
	},
	-- the merchant window in Diablo III's (modules/blizzard/merchant.lua).
	-- Offsets from the window's top left.
	merchant = {
		footer = { "MerchantBuyBackItem", 8 }, -- the rough stone foot (up to it and 8 higher: they sit on it): buyback, repairs, Sell Junk, the money
		insets = { 0, 36, 116, -40 }, -- the window over Blizzard's 384x512 frame: 500 wide, its foot 40 higher (no band)
		header_height = 40,
		header_insets = { 24, 24 },
		tab_sigils = { "stein", "time" }, -- the tabs' emblems (window.banner's): merchant, buyback
		background = "floor", -- (a name from `window.backgrounds`)
		slot_texture = path .. [[textures\DiabolicUI_D3_Slot.tga]], -- Diablo III's vendor's: the icon's box, the name's
		slot_glow = { 1, .7, .3, .14 }, -- over the hovered slot, added
		border_highlight = path .. [[textures\DiabolicUI_Button_44x44_BorderHighlight.tga]], -- its icon's border, hovered
		-- the wares in two columns of dark slots, the icon in each one's
		-- top left, its name right of it and its price under that
		items = { 32, -68 }, -- the first slot (6 under the iron: no band)
		slot_size = { 208, 46 },
		slot_pitch = { 218, 52 },
		slot_canvas = { 256, 128 }, -- the slot's art, stretched to each slot
		slot_box = { 9, 11, 56, 117 }, -- its icon box's inside, the icon filling it: left, top, right, bottom
		name_offset = 16, -- from the icon, into the name's box
		name_width = 150,
		name_height = 26, -- two lines
		price_offset = 31, -- the price at the icon's bottom (Blizzard hangs it 31 over its name art)
		page_gap = 8, -- the page's arrows, from its text
		pages_y = -384, -- the pages' row, under the slots
		page_color = { .86, .76, .6 },
		-- the bottom row: the last item sold, the repairs, Sell Junk and the money
		buyback = { 32, -430 },
		buyback_size = { 204, 44 },
		buyback_price_offset = 25,
		repair = { 288, -434 }, -- repair all's top left; repair one left of it, the guild's right
		sell_junk = { -32, -434 }, -- its top right, from the window's top right
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
		glyph_sigil = "summoningrune", -- the glyphs' tab's emblem (window.banner's; the trees' show their icons)
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
		footer = "QuestLogFrameAbandonButton", -- the rough stone foot under Abandon, Share and Track
		insets = { 0, 36, 70, -20 }, -- the window over Blizzard's 682x447 frame: wider, for room around its panes; its foot 40 higher (no band)
		header_height = 40,
		header_insets = { 24, 24 },
		map_button = { -32, 41 }, -- the map's button: its right, in the foot (level with Abandon's middle)
		list = { 30, -40 }, -- the quests' top left (Blizzard's 305 wide, its bar right of it): under the iron (no band, the count in the title)
		list_height = 340, -- (Blizzard's 335): its panel 6 over the foot's iron bar
		list_panel_insets = { 6, 6, 22, 4 }, -- (its bottom 4: clear of the foot)
		highlight_left = 4, -- the chosen quest's bar, in from its row's left: off the slate's edge
		highlight_reach = 14, -- the chosen quest's bar, past its row's right: to the scroll bar
		details = { -74, -44 }, -- the details' top right (Blizzard's 298 wide, its bar right of it): clear of the dailies' count
		details_height = 336, -- down to the quests' bottom
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
		-- the rough stone foot up to each page's highest button (none on the
		-- others); the who list's to its search's plate (26 high in its 32)
		footers = { FriendsListFrame = "FriendsFrameAddFriendButton", IgnoreListFrame = "FriendsFrameIgnorePlayerButton",
			WhoFrame = { "WhoFrameEditBox", -3 }, GuildFrame = "GuildFrameGuildInformationButton" },
		insets = { 20, 68, -4, -40 }, -- (its right: the lists' scroll bars as far in as their left)
		offset_y = -32, -- Blizzard's frame that much lower: the window's top with the others'
		header_height = 40,
		header_insets = { 24, 24 },
		tab_offset = { 4, 1 },
		tab_sigils = { "swan", "AllSeeing", "lion", "crow", "Demon" }, -- the tabs' emblems (window.banner's): friends, who, guild, chat, raid
		tab_inset = 8, -- Blizzard overlaps them by 14
		tab_font = DiabolicFont_HeaderRegular10,
		own_tab_inset = 2, -- the friends' own tabs
		friends_top = -36, -- the friends' list, from the frame's top: under the band (its panel window.layout.content_gap under it)
		friends_bottom = 384, -- its bottom, its panel's clear of the foot's iron bar
		who_dropdown_width = 64, -- its middle: room for Zone, Guild or Race
		who_top = -36, -- the who list's column headers, from the frame's top: under the band (Blizzard's 70 down), as far as its panel over the foot's bar
		motd_panel_insets = { 8, 6, 7, 4 }, -- the guild's message of the day, its parchment around its title and text (its sides the list's panel's)
		motd_text_height = 36, -- its three lines (Blizzard's 45 reach into the foot)
		guild_totals_raise = 8, -- "Guild Members" and Player Status, up under the list's rows
		guild_toggle_y = -67, -- Player Status's, from the frame's left (Blizzard's, set on each update)
		guild_raise = 25, -- the guild's list and message of the day, up: as far from the band as from the foot
		raid_band_gap = 8, -- the raid tab's Convert to Raid and Raid Info, apart in the band
		raid_description_insets = { 10, 8, 10, 8 }, -- what raids are, its parchment around it
		raid_description_font = DiabolicFont_SansBold12, -- bold, to read on the parchment
		guild_list_height = 228, -- its scroll bar's (Blizzard's 237), above the totals' panel's bottom
		who_list_trim = 21, -- the who list's scroll bar shorter, inside its panel
		list_gap = 6, -- a list's panel, short of what's under it (the foot's iron bar, the message of the day)
		list_gaps = { WhoListScrollFrame = 3 }, -- (the who list's foot 3 lower: footers)
		motd_title_color = { .42, .08, .02 }, -- its title, dark red on it (as the quest log's)
		guild_detail_offset = { 6, -96 }, -- a member's card, right of the window, under its tabs
		guild_page_lower = 10, -- the guild information's and log's parchment (and text), from Blizzard's: under their X
		guild_log_width = 325, -- the guild log's text (Blizzard's 340, its scroll bar 28 in from the page's right): 22 in from its left, off the parchment's edge
		list_panel_insets = { 6, 6, 28, 6 }, -- the scroll bar inside on the right
		-- lists with less room: the friends' between their tabs and their
		-- buttons, the guild's with its scroll bar's lower arrow below it
		list_panel_overrides = {
			FriendsFrameFriendsScrollFrame = { 6, 2, 28, 2 },
			FriendsFrameIgnoreScrollFrame = { 6, 2, 28, 2 },
			FriendsFramePendingScrollFrame = { 6, 2, 28, 2 }
		},
		-- a list's panel down to the top of what's under it: the foot (its
		-- button's) or, the guild's, the message of the day's
		list_bottoms = { FriendsFrameFriendsScrollFrame = "FriendsFrameAddFriendButton", WhoListScrollFrame = "WhoFrameEditBox" },
		header_bars = { WhoListScrollFrame = true, GuildListScrollFrame = true } -- tables: a dark bar under their column names
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
		own_tab_inset = 2, -- a page's own tabs
		tab_font = DiabolicFont_HeaderRegular10,
		list_panel_insets = { 6, 6, 28, 6 }, -- the scroll bar inside on the right
		text_color = { .9, .86, .8 }, -- their dark text (drawn for parchment), pale
		-- a log on parchment (`ink_messages`): its names and times; its
		-- other colors (items' qualities) darkened to `bright` at most; bold
		log_inks = { name = { .42, .08, .02 }, time = { .15, .3, .3 }, bright = .45, font = DiabolicFont_SansBold12 },
		-- `frame`; `addon` if it loads on demand; `insets`; `offset_y`, the
		-- frame lower to put the window's top with the others' (`panel` false
		-- for those Blizzard doesn't place); its title: `title`, a font
		-- string, or `text`, a global string (theirs has no name);
		-- `close` (none if left out); `tabs`, their names' prefix; `lists`, in
		-- panels (a name, or { name, how much further left its rows
		-- start, an earlier one whose sides its panel takes or false, its
		-- material }), on slate (`list_material` for another); `keep`, its own textures not its frame's art (patterns on
		-- their names); `subframes`, whose own textures are art too; `hide`,
		-- more by name; `places`, parts moved ({ point, relative's name,
		-- relativePoint, x, y } by name); `list_insets`, its lists' panels'
		-- insets if not the windows'; `sizes`, parts resized ({ width,
		-- height } by name); `art`, by file; `pale`, its dark text pale;
		-- `band_text`, a font string (its name) moved to the band's left;
		-- `ink_messages`, logs (scrolling message frames) whose lines are
		-- written in ink;
		-- `parchments`, text on Diablo III's parchment in a panel (a name, or
		-- { name, material, an earlier one whose sides it takes, how far
		-- its page reaches over its top }: its tall
		-- page by default), `parchment_panel` its panel's insets if not the
		-- windows' (parchment_panel_insets), `parchment_bar_x` their scroll
		-- bars' from their text's right if not the windows'; `ink`, text
		-- Blizzard colors for its page's material, dark on ours; `background`,
		-- its painted one (window.backgrounds'), `background` below if left out;
		-- `late`, parts an addon adds once it's shown (Auctionator's pages):
		-- `hide` as above; `panels`, their own backdrop gone,
		-- in ours ({ name, insets }); `dropdowns`, Diablo III's; `tabs`, their
		-- prefix; `lower`, how much lower what's placed from the bottom of
		-- one of `lower_in` goes; `beside`, { part, an addon's part over it,
		-- the first's width once the second is there }. `bars`, status bars
		-- in Diablo III's (Blizzard's skill bars: their Border and Background
		-- out of sight). `sigils`, its tabs' emblems (window.banner's
		-- names), in their order. `panes`, Diablo III's stone pane around a model
		-- ({ a part, the last one it reaches or false, open: its middle out,
		-- around a picture }). `footer`, its rough stone foot: the name of the highest of its buttons
		-- (or { [a page] = that name }: on that page only). `close`, its close
		-- button's name (true: an unnamed one); `crest`, a frame over the
		-- band shown over the iron, the title over it. `dropdowns` (in
		-- `late` too), Diablo III's (before the band's). `band` (in `late`
		-- too), controls moved into the band: `left` from its left end (a
		-- table in it: one under the other), `right` from its right end;
		-- false: no band (nothing in it), its room given back (the frame
		-- up into it, the window's top where it was, its foot higher);
		-- `hints` edit boxes' labels in them ({ [box] = a global string's
		-- name }). `outside`, parts out past the window on purpose (the
		-- guild bank's tabs). `iron_bars`, bars of the window's iron across
		-- it between its zones: their middles, from its top.
		background = "smoke",
		frames = {
			{ frame = "PVPParentFrame", band = false, insets = { 24, 68, -6, -39 }, offset_y = -32, background = "lava", text = "PLAYER_V_PLAYER",
				close = "PVPParentFrameCloseButton", tabs = "PVPParentFrameTab", sigils = { "sword", "flames" }, subframes = { "PVPFrame", "PVPBattlegroundFrame" },
				hide = { "PVPBattlegroundFrameFrameLabel" }, pale = true, -- the battlegrounds' own title, under the tabs
				-- the battlegrounds, the chosen one's text as wide (Blizzard's
				-- reaches out of the window), the foot on their page only
				lists = { "PVPBattlegroundFrameTypeScrollFrame", { "PVPBattlegroundFrameInfoScrollFrame", 0, "PVPBattlegroundFrameTypeScrollFrame" } },
				footer = { PVPBattlegroundFrame = "PVPBattlegroundFrameJoinButton" },
				-- the battlegrounds' buttons in the middle of the window's foot
				-- (its middle 15 left of the frame's; Join as Party wider than
				-- Cancel, so Join Battle 27 right of it), 8 apart, room between
				-- the rewards and the foot. The page's block (title row, list,
				-- rewards) 5 left: in the middle too
				places = {
					PVPBattlegroundFrameNameHeader = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 65, -53 },
					WintergraspTimer = { "RIGHT", "PVPBattlegroundFrame", "TOPRIGHT", -45, -53 },
					BattlegroundType1 = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 18, -79 },
					PVPBattlegroundFrameInfoScrollFrame = { "BOTTOMLEFT", "PVPBattlegroundFrame", "BOTTOMLEFT", 15, 122 },
					PVPBattlegroundFrameJoinButton = { "BOTTOM", "PVPParentFrame", "BOTTOM", 12, 69 },
					PVPBattlegroundFrameGroupJoinButton = { "RIGHT", "PVPBattlegroundFrameJoinButton", "LEFT", -8, 0 },
					PVPBattlegroundFrameCancelButton = { "LEFT", "PVPBattlegroundFrameJoinButton", "RIGHT", 8, 0 } },
				sizes = { PVPBattlegroundFrameInfoScrollFrame = { 298, 208 } } }, -- (Blizzard's 232: 6 over the foot's iron bar, 6 under the list)
			{ frame = "BattlefieldFrame", band = false, insets = { 19, 40, -5, -39 }, offset_y = -4, background = "lava", title = "BattlefieldFrameFrameLabel",
				close = "BattlefieldFrameCloseButton", lists = { "BattlefieldListScrollFrame", { "BattlefieldFrameInfoScrollFrame", 0, "BattlefieldListScrollFrame" } }, pale = true,
				-- the rewards on slate too, under the instances: 16 higher (its
				-- panel clear of the buttons), its top 7 lower (apart from theirs);
				-- "Battlefield Instance:" 5 higher, apart from its list
				places = { BattlefieldFrameInfoScrollFrame = { "BOTTOMLEFT", "BattlefieldFrame", "BOTTOMLEFT", 19, 116 },
					BattlefieldFrameNameHeader = { "TOPLEFT", "BattlefieldFrame", "TOPLEFT", 75, -50 } },
				sizes = { BattlefieldFrameInfoScrollFrame = { 298, 209 } } }, -- (Blizzard's 232)
			{ frame = "BankFrame", band = false, insets = { 24, 40, -6, -34 }, offset_y = -4, title = "BankFrameTitleText", close = "BankCloseButton" },
			{ frame = "TradeFrame", band = false, background = "slabs", insets = { 24, 40, 14, -16 }, offset_y = -4, text = "TRADE", close = "TradeFrameCloseButton",
				-- the names over their columns, out from under the band (Blizzard's beside portraits)
				places = { TradeFramePlayerNameText = { "BOTTOM", "TradePlayerItem1", "TOP", 0, 50 },
					TradeFrameRecipientNameText = { "BOTTOM", "TradeRecipientItem1", "TOP", 0, 50 } } },
			-- the flight master's: the window around its map (Blizzard's 316 x 352,
			-- 21 in from the frame's left, 75 from its top, 47 from its right, 85
			-- from its foot), in the stone pane, 10 in from the iron's solid
			-- part (24) and the band's foot (64); as high as the others
			{ frame = "TaxiFrame", band = false, insets = { 19, 5, -7, -45 }, offset_y = 31, title = "TaxiMerchant", close = "TaxiCloseButton", background = "waypoint",
				keep = { "^TaxiMap$" }, panes = { { "TaxiMap", false, true } } },
			{ frame = "ItemTextFrame", band = false, insets = { 24, 40, 14, -34 }, offset_y = -4, title = "ItemTextTitleText", close = "ItemTextCloseButton",
				parchments = { "ItemTextScrollFrame" }, ink = { "ItemTextPageText" }, background = "slabs" }, -- stone and marble plaques too
			{ frame = "QuestFrame", band = false, insets = { 24, 40, 14, -34 }, offset_y = -4, title = "QuestFrameNpcNameText", close = "QuestFrameCloseButton", background = "cliffs",
				subframes = { "QuestFrameGreetingPanel", "QuestFrameDetailPanel", "QuestFrameProgressPanel", "QuestFrameRewardPanel" },
				parchments = { "QuestGreetingScrollFrame", "QuestDetailScrollFrame", "QuestProgressScrollFrame", "QuestRewardScrollFrame" } },
			{ frame = "GossipFrame", band = false, insets = { 24, 40, 14, -34 }, offset_y = -4, title = "GossipFrameNpcNameText", close = "GossipFrameCloseButton", background = "zoltun",
				subframes = { "GossipFrameGreetingPanel" }, parchments = { "GossipGreetingScrollFrame" } },
			{ frame = "TabardFrame", band = false, background = "slabs", insets = { 24, 40, -6, -9 }, offset_y = -4, title = "TabardFrameNameText", close = "TabardFrameCloseButton",
				keep = { "^TabardFrameBackground$" }, pale = true, panes = { { "TabardFrameBackground", false, true } } },
			{ frame = "PetitionFrame", band = false, background = "slabs", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "PetitionFrameNpcNameText",
				close = "PetitionFrameCloseButton", pale = true },
			{ frame = "GuildRegistrarFrame", band = false, background = "slabs", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "GuildRegistrarFrameNpcNameText",
				close = "GuildRegistrarFrameCloseButton", pale = true },
			{ frame = "ArenaRegistrarFrame", band = false, background = "cracked", insets = { 24, 40, -6, -34 }, offset_y = -4, title = "ArenaRegistrarFrameNpcNameText",
				close = "ArenaRegistrarFrameCloseButton", pale = true },
			{ frame = "PetStableFrame", band = false, background = "slabs", insets = { 24, 40, -10, -39 }, offset_y = -4, title = "PetStableTitleLabel",
				close = "PetStableFrameCloseButton", pale = true, panes = { { "PetStableModel" } } },
			{ frame = "DressUpFrame", band = false, insets = { 24, 40, -6, -9 }, offset_y = -4, title = "DressUpFrameTitleText",
				close = "DressUpFrameCloseButton", keep = { "^DressUpBackground" }, -- the race's backdrop behind the model, in a pane
				panes = { { "DressUpBackgroundTopLeft", "DressUpBackgroundBotRight", true } },
				-- its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
				places = { DressUpFrameDescriptionText = { "CENTER", "DressUpFrame", "TOP", -11, -50 } } },
			{ frame = "ClassTrainerFrame", background = "zoltun", addon = "Blizzard_TrainerUI", insets = { 24, 40, 10, -39 }, offset_y = -4, -- (its right: the scroll bars' panel as far in as the left)
				title = "ClassTrainerNameText", close = "ClassTrainerFrameCloseButton", footer = "ClassTrainerTrainButton",
				dropdowns = { "ClassTrainerFrameFilterDropDown" },
				band = { left = { "ClassTrainerFrameFilterDropDown" } }, -- the filter in the band (modules/blizzard/trainer.lua)
				-- the trainings, and the chosen one, on parchment, as the recipes
				parchments = { { "ClassTrainerListScrollFrame", "parchment" }, { "ClassTrainerDetailScrollFrame", "lined", "ClassTrainerListScrollFrame" } },
				ink = { "ClassTrainerSkillName", "ClassTrainerSubSkillName", "ClassTrainerSkillRequirements", "ClassTrainerCostLabel",
					"ClassTrainerSkillDescription" },
				hide = { "ClassTrainerExpandTabLeft", "ClassTrainerExpandTabMiddle", "ClassTrainerExpandTabRight" }, -- "All"'s tab
				-- the greeting across the list's width under the band, "All" and
				-- the list under it (the chosen one's height: trainer.lua)
				places = { ClassTrainerGreetingText = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 9, -34 },
					ClassTrainerExpandButtonFrame = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 15, -66 },
					ClassTrainerListScrollFrame = { "TOPRIGHT", "ClassTrainerFrame", "TOPRIGHT", -67, -102 },
					-- the chosen one's page 6 under the list's (Blizzard's 8 under its text)
					ClassTrainerDetailScrollFrame = { "TOPLEFT", "ClassTrainerListScrollFrame", "BOTTOMLEFT", 0, -14 } },
				sizes = { ClassTrainerGreetingText = { 352, 24 } } }, -- (its panel as wide as the parchments')
			{ frame = "TradeSkillFrame", addon = "Blizzard_TradeSkillUI", insets = { 24, 40, 14, -43 }, offset_y = -4, background = "artisan", footer = "TradeSkillCreateAllButton",
				-- the search in the band (modules/blizzard/tradeskill.lua)
				title = "TradeSkillFrameTitleText", close = "TradeSkillFrameCloseButton",
				-- the recipes, and the chosen one with its reagents, on parchment
				-- (their colors darkened for it: modules/blizzard/tradeskill.lua)
				parchments = { { "TradeSkillListScrollFrame", "parchment" }, { "TradeSkillDetailScrollFrame", "lined", "TradeSkillListScrollFrame", 6 } },
				ink = { "TradeSkillSkillName", "TradeSkillRequirementLabel", "TradeSkillRequirementText", "TradeSkillSkillLineName",
					"TradeSkillDescription", "TradeSkillReagentLabel" },
				bars = { "TradeSkillRankFrame" }, -- the skill's, its rank in it
				-- centred on our window (24 left of the frame, 14 right of it: room for the scroll bars)
				places = { TradeSkillRankFrame = { "TOP", "TradeSkillFrame", "TOPLEFT", 187, -32 },
					TradeSkillRankFrameSkillRank = { "CENTER", "TradeSkillRankFrame", "CENTER", 0, 0 } },
				hide = { "TradeSkillExpandTabLeft", "TradeSkillExpandTabMiddle", "TradeSkillExpandTabRight" }, -- "All"'s tab
				-- the window's iron across between the recipes and the chosen one
				iron_bars = { 275 },
				-- the recipe's name wrapped short of Auctionator's Scan AH, over it
				late = { beside = { { "TradeSkillSkillName", "Auctionator_Search", 146 } } } },
			{ frame = "MacroFrame", band = false, background = "zoltun", addon = "Blizzard_MacroUI", insets = { 24, 68, -10, -39 }, offset_y = -32, text = "CREATE_MACROS", footer = "MacroExitButton",
				close = "MacroFrameCloseButton", tabs = "MacroFrameTab", sigils = { "openbook", "hoodedface" },
				lists = { { "MacroButtonScrollFrame", 0, false, "pane" }, { "MacroFrameScrollFrame", 0, false, nil, true } }, -- the icons in the stone pane, the text on slate over the painting
				keep = { "^MacroFrameSelectedMacroBackground$" },
				hide = { "MacroFrameTextBackground" }, -- the text's tooltip backdrop (blue), on our slate instead
				-- the icons and the macro 20 up and 6 left (as far from the band
				-- as from the foot's bar, from the sides), the buttons 10 down
				-- (30 over the window's bottom); the count of characters right of
				-- "Enter Macro Commands:" (Blizzard's under the text, over the foot)
				places = { MacroButtonScrollFrame = { "TOPLEFT", "MacroFrame", "TOPLEFT", 17, -56 },
					MacroFrameSelectedMacroBackground = { "TOPLEFT", "MacroFrame", "TOPLEFT", 10, -208 },
					MacroFrameCharLimitText = { "BOTTOMRIGHT", "MacroFrameScrollFrame", "TOPRIGHT", 0, 8 },
					MacroDeleteButton = { "BOTTOMLEFT", "MacroFrame", "BOTTOMLEFT", 17, 69 },
					MacroNewButton = { "CENTER", "MacroFrame", "TOPLEFT", 222, -432 },
					MacroExitButton = { "CENTER", "MacroFrame", "TOPLEFT", 303, -432 } } },
			{ frame = "InspectFrame", band = false, addon = "Blizzard_InspectUI", insets = { 19, 68, -1, -9 }, offset_y = -32, title = "InspectNameText",
				close = "InspectFrameCloseButton", tabs = "InspectFrameTab", sigils = { "hoodedface", "tree", "sword" },
				subframes = { "InspectPaperDollFrame", "InspectPVPFrame", "InspectTalentFrame" },
				keep = { "^InspectTalentFrameBackground" }, -- the tree's art (its spec's)
				hide = { "InspectTalentFrameCloseButton" }, -- the talent page's own X, under the window's
				-- the level line (the guild's under it) out of the band, over the model
				places = { InspectLevelText = { "BOTTOM", "InspectModelFrame", "TOP", 0, 22 } },
				lists = { "InspectTalentFrameScrollFrame" } },
			{ frame = "ItemSocketingFrame", band = false, background = "zoltun", addon = "Blizzard_ItemSocketingUI", insets = { 24, 40, 24, 36 }, offset_y = -4,
				text = "ITEM_SOCKETING", close = "ItemSocketingCloseButton", lists = { "ItemSocketingScrollFrame" } },
			{ frame = "AuctionFrame", addon = "Blizzard_AuctionUI", insets = { 24, 56, 24, 48 }, offset_y = -20, text = "AUCTIONS", background = "street", footer = "BrowseCloseButton",
				close = "AuctionFrameCloseButton", tabs = "AuctionFrameTab", sigils = { "AllSeeing", "scarab", "stein" }, art = { "ui%-auctionframe%-" },
				hide = { "BrowseTitle", "BidTitle", "AuctionsTitle", -- the pages' own titles, under the tabs
					"BrowseNameText", "BrowseDropDownName" }, -- the search's labels (Name in its box)
				-- the search in the band, its two checkboxes one under the other
				band = { left = { "BrowseName", "BrowseLevelText", "BrowseMinLevel", "BrowseLevelHyphen", "BrowseMaxLevel", "BrowseDropDown",
					{ "IsUsableCheckButton", "ShowOnPlayerCheckButton" }, "BrowseSearchButton" }, hints = { BrowseName = "NAME" } },
				-- (its pages' content: modules/blizzard/auction.lua)
				-- Auctionator's pages too: its title gone (the tabs say it), its
				-- lists and the sell column on their black, Blizzard's tabs over
				-- its results; the pages' bottom rows lower, nearer the frame (the
				-- window 12 taller: the lists 6 over the foot's iron bar)
				late = { hide = { "AuctionatorTitle", "Atr_ActiveItems_Text" }, -- (the tabs say them)
					hide_texts = { { "Atr_SellControls", "Sell" }, { "BrowsePrevPageButton" }, { "BrowseNextPageButton" } },
					-- its search and its Full Scan and Options in the band
					band = { left = { "Atr_DropDownSL", "Atr_Search_Box", "Atr_Search_Button", "Atr_Adv_Search_Button" },
						right = { "Atr_FullScanButton", "Auctionator1Button" } },
					dropdowns = { "BrowseDropDown", "PriceDropDown", "DurationDropDown", "Atr_DropDownSL", "Atr_Duration" },
					tabs = "Atr_ListTabsTab", lower = 26,
					lower_in = { "AuctionFrame", "AuctionFrameBrowse", "AuctionFrameBid", "AuctionFrameAuctions", "Atr_Main_Panel" } } },
			{ frame = "GuildBankFrame", addon = "Blizzard_GuildBankUI", band = false, insets = { 24, 68, 24, 36 }, offset_y = -32, text = "GUILD_BANK", background = "slabs",
				close = true, crest = "GuildBankEmblemFrame", crest_y = -15, -- its rod on the iron's visible top (its art starts under its frame's edge), its foot behind the title's plate
				-- its crest's gold rod run on as far as the slots and the logs'
				-- parchment, its tips at their edges (in its file's pixels: the
				-- tip's end, then the plain stretch drawn out)
				rail = { { "GuildBankEmblemFrameLeft", 96, 144, 160, left = true }, { "GuildBankEmblemFrameRight", 244, 168, 184 }, reach = 48 },
				tabs = "GuildBankFrameTab", sigils = { "lion", "openbook", "time", "fleur" }, art = { "ui%-guildbankframe%-left", "ui%-guildbankframe%-right" },
				-- the logs and the tab's info on parchment, in ink; Deposit,
				-- Withdraw and the money on the stone foot on each tab
				-- (the recipe's parchment: the lore journal's tall page blurs stretched this wide)
				parchments = { { "GuildBankMessageFrame", "parchment" }, { "GuildBankInfoScrollFrame", "parchment" } },
				ink_messages = { "GuildBankMessageFrame" },
				ink = { "GuildBankTabInfoEditBox" }, footer = "GuildBankFrameDepositButton",
				-- the tab's name and your rights in it in the band, at its left,
				-- its frame gone
				band_text = "GuildBankTabTitle",
				-- the slots, logs and info 27 higher than Blizzard's: as far
				-- from the band as from the foot's iron bar
				places = { GuildBankColumn1 = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 30, -43 },
					GuildBankFrameLog = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 0, 27 },
					GuildBankTransactionsScrollFrame = { "TOPRIGHT", "GuildBankFrame", "TOPRIGHT", -50, -48 },
					GuildBankInfo = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 33, -46 } },
				-- its tabs out on the window's right, as Blizzard's
				outside = { "GuildBankTab1", "GuildBankTab2", "GuildBankTab3", "GuildBankTab4", "GuildBankTab5", "GuildBankTab6" },
				-- the info's page the logs' size, in the same place
				sizes = { GuildBankInfoScrollFrame = { 688, 304 }, GuildBankTabInfoEditBox = { 688, 218 } },
				-- the pages' panel only round them: their scroll bars on the stone
				parchment_panel = { 16, 6, 26, 6 },
				-- the info's scroll bar on its page's right edge, where the
				-- logs' is (Blizzard's, 4 right of their text)
				parchment_bar_x = 4,
				hide = { "GuildBankTabTitleBackground", "GuildBankTabTitleBackgroundLeft", "GuildBankTabTitleBackgroundRight" } },
			-- (its right: as far from the list's scroll bar as the window's
			-- left from the list)
			{ frame = "KeyBindingFrame", background = "zoltun", addon = "Blizzard_BindingUI", insets = { 24, 40, -30, 46 }, panel = false,
				title = "KeyBindingFrameHeaderText", lists = { "KeyBindingFrameScrollFrame" }, footer = "KeyBindingFrameDefaultButton",
				band = { right = { "KeyBindingFrameCharacterButton" } }, -- "Character Specific Key Bindings"
				-- the list (its rows too) 6 under the column names; what a
				-- key was bound to between it and the foot; the buttons 16
				-- lower, on the foot, as far in from both sides
				places = { KeyBindingFrameScrollFrame = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 2, -72 },
					KeyBindingFrameBinding1 = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 27, -72 },
					KeyBindingFrameOutputText = { "TOP", "KeyBindingFrame", "TOPLEFT", 293, -465 },
					KeyBindingFrameDefaultButton = { "BOTTOMLEFT", "KeyBindingFrame", "BOTTOMLEFT", 10, -16 },
					KeyBindingFrameCancelButton = { "BOTTOMRIGHT", "KeyBindingFrame", "BOTTOMRIGHT", -64, -16 } } }
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
		-- the raid browser's rough stone foot up to each page's buttons
		footers = { LFRQueueFrame = "LFRQueueFrameFindGroupButton", LFRBrowseFrame = "LFRBrowseFrameSendMessageButton" },
		header_height = 40,
		header_insets = { 24, 24 },
		dungeons = {
			background = "tiles", -- (window.backgrounds'; the raid browser's the Pit of Saron)
			insets = { 24, 40, 34, 2 }, -- its lists 40 in from the sides, Find Group and Close on a stone foot under them
			offset_y = -4 -- the window's top with the others'
		},
		raids = {
			insets = { 16, 68, -1, 36 }, -- up over the band and the tabs (its right: the scroll bars as far in as the lists' left)
			offset_y = -32
		},
		tab_sigils = { "time", "AllSeeing" }, -- the raid browser's tabs' emblems (window.banner's): queue, browse
		list_panel_insets = { 6, 6, 28, 6 },
		raid_list_margins = { 18, 22 }, -- the Raid Browser's lists' zones, from the window's left and right (inside its iron frame)
		raid_rows_left = 8, -- its lists' rows, left of Blizzard's
		raid_browse_top = 4, -- the browse list's zone over its rows (the others' 6): clear of its column names
		raid_queue_gap = 12, -- the queue's list's zone over its foot's iron bar (about as far as under the roles)
		raid_browse_raise = 12, -- the browse list's rows up: its zone 6 over the foot's iron bar
		raid_headers_raise = 19, -- its column names up: 6 over its zone
		raid_roles_top = -128, -- its roles' row, from the window's top (Blizzard's)
		comment_size = { 250, 20 },
		comment_hint_font = DiabolicFont_SansRegular12,
		comment_hint_color = { .5, .45, .4 }, -- "Type your comment here.", pale in it (the mail's hints')
		comment_right = 21, -- the Raid Browser's comment button, from its right (List Me is 21 from its left)
		button_margin = 34, -- the Dungeon Finder's buttons, from the window's sides, on its stone foot
		button_bottom = 30, -- and from its bottom (the iron's 23, the foot's margin)
		header_color = { 1, .6, .2 }, -- the random dungeon's titles, as the quest log's
		text_color = { .9, .86, .8 },
		type_width = 230, -- its middle: room for the longest choice
		roles_top = -72, -- the roles' row, from the window's top (Blizzard's 100 down), under the band
		lists_raise = 62, -- the random dungeon and the list, up into the dropdown's old room
		extra_rows = 1, -- the dungeons' list's rows past Blizzard's 15, down to over the foot
		random_raise = 4 -- the random dungeon's bottom up: its zone 6 over the foot's iron bar
	},
	-- the spellbook in Diablo III's (modules/blizzard/spellbook.lua), laid
	-- out as Pretty GUI's: wide, the spells in two columns of six with
	-- their names, the schools down its left, the companions and mounts in
	-- their own tabs. Offsets from the window's top left.
	spellbook = {
		insets = { 0, 36, 166, 0 }, -- the window over Blizzard's 384x512 frame, as the character window's: 550 wide
		header_height = 40,
		header_insets = { 24, 24 },
		tab_sigils = { "openbook", "WolfHead", "star", "owl", "horse", "hellforge" }, -- the tabs' emblems (window.banner's): spells, pet, (Blizzard's third), companions, mounts, professions
		-- the schools (Blizzard's side tabs): the book's bookmarks, their
		-- icons over its right edge
		schools = { 486, -116 }, -- the first's icon
		school_size = 36,
		school_gap = 12,
		school_idle_alpha = .6, -- the schools not shown: grey and dimmed
		-- the pennant under each (Diablo III's achievements list's, turned
		-- to point right): dark, red while chosen; its point out past the
		-- window's iron
		school_ribbon = {
			texture = path .. [[textures\DiabolicUI_D3_Bookmark.tga]],
			idle = { 0, .5, 21/128, 107/128 },
			chosen = { .5, 1, 21/128, 107/128 },
			left = 2, right = 30, pad = 5 -- past the icon (its art's shape: 128 by 86)
		},
		-- an open book: two pages (x, y, width, height), a shadow in the fold
		book = { 30, -100, 464, 412 }, -- the window's smoke left and right of it, the index tabs on the right
		fold_width = 22,
		fold_alpha = .45,
		-- the spells on its pages, a column on each: the icon, its name and
		-- rank in ink right of it
		spells = { 46, -136 }, -- the first slot
		slot_size = { 200, 45 },
		slot_pitch = { 232, 50 }, -- from a slot to the next, across and down: a page
		icon_inset = 4, -- the icon from the slot's left
		name_offset = 12, -- the name from the icon, past its border
		name_width = 145,
		name_font = DiabolicFont_SansBold12,
		rank_font = DiabolicFont_SansRegular10,
		rank_color = { .4, .3, .2 }, -- lighter ink
		passive_color = { .4, .3, .2 }, -- the passive ones' names (Blizzard's grey)
		-- a spell on no action bar: a gold halo around its icon, drawn
		-- as it is (an added glow vanishes on the light pages)
		unassigned = {
			texture = path .. [[textures\DiabolicUI_D3_SpellGlowGold.tga]], -- (its orange one in gold)
			scale = 72/44, -- its canvas over the icon's (its brightest ring just past the border)
			color = { 1, 1, 1, 1 }
		},
		-- the search box (in the band), the spells found on the book's pages
		search_size = { 160, 20 },
		search_inset = 0, -- its text from its edges (its plate reaches past them)
		search_font = DiabolicFont_SansRegular12,
		search_hint_color = { .5, .45, .4 },
		-- the pages at the right of the book's foot (from the window's top),
		-- as the companions': back, the page, on
		pages_y = -483, -- their middles
		next_x = -72, -- on's right, from the window's right
		page_gap = 4,
		page_color = { .86, .76, .6 }, -- the companions' pages (on stone)
		-- the companions and mounts: a cover over the spells (inside the
		-- iron frame, under the tabs), the model in a panel on top, the
		-- companions in three columns of four under it
		cover_insets = { 23, 97, 23, 23 }, -- up to the iron frame and the tabs' strip: nothing of the book shows past it
		bare_pages = { PROFESSIONS = true }, -- no band on those (nothing in it): the cover up to the iron
		bare_cover_top = 23, -- from the iron's top (the window's, lowered by its hanging tabs' room)
		cover_level = 6, -- over the spells' buttons and their cooldowns
		-- paintings, cut to the cover's shape), darkened under the panels
		cover_art = {
			CRITTER = path .. [[textures\DiabolicUI_D3_Companions.tga]],
			MOUNT = path .. [[textures\DiabolicUI_D3_Mounts.tga]],
			PROFESSIONS = path .. [[textures\DiabolicUI_D3_BackgroundArtisan.tga]] -- the professions' leather
		},
		cover_art_color = { .33, .33, .33 }, -- as dark as the windows' paintings
		cover_art_colors = { PROFESSIONS = { 1, 1, 1 } }, -- art already dark
		model_panel = { 0, -15, 490, 154 }, -- in the cover, centred (x from its middle; its pane's bottom clear of the slots)
		model_inset = 4,
		summon_size = { 140, 24 },
		summon_bottom = 6, -- Summon and the turning arrows, in from the model's foot (the arrows from its corners)
		selected_name_font = DiabolicFont_HeaderRegular14,
		companions = { 12, -185 }, -- the first slot, in the cover
		companion_slot_size = { 156, 45 },
		companion_pitch = { 162, 48 },
		companion_name_width = 98,
		companion_pages = { -12, -387 }, -- the next page's top right, in the cover
		-- the professions page, in the cover: the primary ones, then the
		-- secondary ones, a panel each (its icon opens it, its rank in a
		-- bar, its other spell on the right)
		professions = { 12, -40 }, -- the first panel (its section's title clear of the leather's top bolts)
		professions_inset = 24, -- the page inside the leather's stitched border
		professions_scale = .9, -- and scaled down to fit in it
		profession_width = 480,
		profession_heights = { 70, 52 }, -- a primary one's, a secondary one's
		profession_gap = 8,
		profession_section_gap = 30, -- above a section, for its title
		profession_icons = { 48, 36 }, -- primary, secondary
		profession_inset = 11, -- the icon from the panel's left
		profession_bar = { 240, 14 }, -- its rank's bar
		profession_extra = 36, -- its other spell's button
		profession_title_font = DiabolicFont_HeaderRegular14,
		profession_title_color = { .86, .76, .6 },
		profession_rank_gap = 8, -- its rank's title (Artisan...) after its name
		profession_rank_color = { .6, .55, .5 },
		-- one not learned yet: what it is, where to learn it (Pretty GUI's)
		profession_help_font = DiabolicFont_SansRegular12,
		profession_help_color = { .6, .55, .5 },
		profession_missing_icon = [[Interface\Icons\INV_Scroll_04]]
	},
	-- the trade skills' window on parchment (modules/blizzard/tradeskill.lua)
	tradeskill = {
		-- the recipes' difficulties in inks that read on parchment (by
		-- GetTradeSkillInfo's kind: Blizzard's orange, yellow, green, grey)
		inks = {
			header = { .42, .08, .02 }, -- dark red, as the quest log's titles
			optimal = { .5, .1, 0 },
			medium = { .3, .17, 0 },
			easy = { 0, .22, 0 },
			trivial = { .2, .16, .12 }
		},
		missing_color = { .5, .1, .04 }, -- a reagent short of what's needed: red ink
		-- Offsets in Blizzard's frame (384x512): the search in the band (the
		-- title on the window's top edge); the rest up into the search's
		-- old row, the buttons lower for their frames
		search_width = 128,
		filter_gap = 12, -- Have Materials, right of the search's plate
		filters_lower = -18, -- "All" and the dropdowns, up under the skill bar
		dropdowns_gap = 8, -- between the two dropdowns
		list_lower = -7, -- the recipes, up (Blizzard's 96 down): 6 under "All" and the dropdowns, down to the iron bar over the chosen one
		list_trim = 5, -- and that much shorter (Blizzard's 130), over the chosen one's
		detail = { 20, -255 }, -- the chosen recipe's top left (Blizzard's 234 down)
		detail_height = 132, -- down to 6 over the foot's iron bar (Blizzard's 176)
		buttons_lower = 6, -- the buttons
		count = { arrow_size = 20, box_width = 26, gap = 2 }, -- how many to make: its arrows, its box (its plate past it), from Create All (86 to Create)
		reagents_top = 4, reagents_gap = 4, -- the reagents' rows, lower than Blizzard's: room for their icons' frames
		reagent_font = DiabolicFont_SansBold10, reagent_name_width = 100, -- their names (Blizzard's 12, 90 wide): most on one line
		highlight_inset = 6, -- the chosen recipe's copper bar, in from the parchment's sides
		scan_gap = 6, -- the requirement short of Auctionator's Scan AH, the description under them
		description_left = 5, description_top = 50, -- the description's place (Blizzard's), at the least that low
		reagents_label_gap = 4, -- "Reagents:" under the description (Blizzard's 10)
		description_font = DiabolicFont_SansBold10 -- in bold, to read on the parchment
	},
	-- the class trainer's (modules/blizzard/trainer.lua; panels.lua puts it on parchment)
	trainer = {
		-- the trainings in inks that read on parchment (by GetTrainerServiceInfo's
		-- kind: Blizzard's green, red, grey), as the recipes'
		inks = {
			header = { .42, .08, .02 },
			available = { 0, .22, 0 },
			unavailable = { .5, .1, 0 },
			used = { .2, .16, .12 }
		},
		greeting_insets = { 4, 4, 4, 4 }, -- the trainer's words, a dark panel around them
		missing_color = { .5, .1, .04 }, -- a requirement not met: red ink
		hover_color = { 0, 0, 0 }, -- a training under the mouse: black ink (Blizzard's white)
		filter_width = 80, -- the filter's, in the band left of the title
		detail_trim = 28 -- the chosen one's, shorter than Blizzard's (set as it opens): over the foot
	},
	-- Immersion's own dialogue box with our close button, Exocet titles and
	-- coins (modules/blizzard/immersion.lua)
	immersion = {
		title_font = path .. [[fonts\ExocetBlizzardLight.ttf]],
		name_size = 18, -- the NPC's name (Immersion's is Morpheus 22)
		header_size = 15, -- Quest Objectives, Rewards, the items to hand in
		-- the box and the choices on the tooltips' frame (their backdrop's
		-- edge, 32 a corner) around warm dark glass, the world seen
		-- through it: what Immersion is for
		plate = {
			edge = path .. [[textures\DiabolicUI_Tooltip_Small.tga]],
			edge_size = 32,
			choice_edge_size = 16, -- a choice's (a line's height: two corners fit it)
			inset = 6, -- the glass, in from the frame's outside (at 32)
			color = { .07, .045, .03, .88 } -- (the world dimly through it, its colors not tinting it)
		},
		-- Diablo III's dialogue on the box's glass: dark smoke (a cloud of
		-- the globes', its round edge left out), a red glow up from its foot
		smoke = {
			texture = path .. [[textures\DiabolicUI_HealthGlobe512x512_Smoke.tga]],
			texcoord = { .2, .8, .38, .62 },
			color = { .3, .18, .12, .35 },
			glow_color = { .55, .08, .04 },
			glow_alpha = .35,
			glow_height = 48
		},
		rule = { color = { .85, .65, .3, .8 }, height = 1, width = 360, gap = 3 }, -- the gold under the NPC's name
		-- behind the NPC: a dark red glow in the middle of the black
		vignette = { color = { .28, .04, .03 }, shade = path .. [[textures\DiabolicUI_Shade_64x64.tga]] },
		-- the NPC's frame (Diablo III's 2DUIConversation's), its art
		-- 146x168 in its 256x256 (its shadow on the right cut off: it fell
		-- on D3's bar, here on the box as a dark strip), its glass (the
		-- model's place, black) 122x132, the art's middle from the
		-- glass's; the box from under its middle to Immersion's right,
		-- as high as its art
		portrait = path .. [[textures\DiabolicUI_D3_ConversationPortrait.tga]],
		portrait_size = { 146, 168 },
		portrait_art = { 3, 159, 144 }, -- its art's top, bottom (its edge's middle, as it fades) and right side (past its window), in its file: the box's top, bottom and left
		glass = { 124, 134 },
		portrait_offset = { -8.5, -3.5 },
		kid_camera = { .6, 0, -1, -.28 }, -- a child NPC (Immersion's camera for them): nearer (x), aside (y), down (z), its turn
		box_right = 0, -- the box's right, in from Immersion's
		close_inset = 10, -- the X, in from the box's top right corner
		indicator_gap = 6, -- the NPC's kind (its speech bubble), left of the X
		text_color = { .9, .86, .8 }, -- what's said: warm white
		icon_color = { .86, .76, .6 }, -- the speech bubbles (Blizzard's white), in the titles' pale gold
		choice_insets = { 4, 6, 4, 6 }, -- a choice's plate in its button (Immersion's rows overlap by their frames')
		choice_lit_alpha = .7, -- the copper bar on the one under the mouse or the keys' (as a list's chosen row)
		choice_scale = 1 -- the one under the mouse kept its size (Immersion's grows it 1.1, out of the column)
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
	-- the stack split box (shift-click a stack) and the coins' (a click on
	-- your money) as Diablo III's
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
		coin_size = 14, -- the coins' box: its coin right of the sum
		coin_gap = 3,
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
