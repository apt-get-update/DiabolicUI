-- What every window shares, the generic window and its controls: added to
-- settings/blizzard.lua's `window`.
-- Written from windows/components/*.qml by tools/positions.lua: change those (docs:
-- Common Tasks), this file is overwritten.
local ADDON, Engine = ...
local path = ([=[Interface\AddOns\%s\media\]=]):format(ADDON)
local window = Engine:GetDB("Blizzard").window

local Merge
Merge = function(into, values)
	for key, value in pairs(values) do
		-- (a font is a table too, with a metatable: replaced, not mixed)
		if (type(value) == "table") and (type(into[key]) == "table") and (not getmetatable(value)) then
			Merge(into[key], value)
		else
			into[key] = value
		end
	end
end

-- Banner
Merge(window, {
	banner = {
		cloth = path .. [[textures\DiabolicUI_D3_BannerCloth.tga]],
		trim = path .. [[textures\DiabolicUI_D3_BannerTrim.tga]],
		sigils = path .. [[textures\DiabolicUI_D3_BannerSigils.tga]],
		sigil_names = { "hoodedface", "WolfHead", "shield", "hellforge", "stein", "openbook", "owl", "horse", "crow", "TwoHeadHawk", "lion", "AllSeeing", "time", "star", "sword", "flames", "tree", "wizardhat", "sun", "scarab", "fleur", "skullcrossbones", "Clover", "orbLight", "summoningrune", "pentagram", "monkRune", "gryphon", "khalimswill", "leoric_crown", "swan", "Demon" },
		sigil_columns = 8,
		sigil_rows = 4,
		fallback = "star",
		width = 52,
		height = 104,
		tuck = 22,
		drop = 12,
		gap = 6,
		left = 28,
		shadow = 14,
		shadow_alpha = 0.8,
		rail = { cap = 0.05078125, cap_width = 9, height = 18, overhang = 10, rows = 1, texture = path .. [[textures\DiabolicUI_D3_BannerRail.tga]], up = 19 },
		clasp = { color = { 0.85, 0.85, 0.85 }, height = 20, texture = path .. [[textures\DiabolicUI_D3_BannerClasp.tga]], width = 8, x = { 4, 48 }, y = 2 },
		sigil_size = 30,
		sigil_y = -38,
		icon_size = 26,
		cloth_color = { 0.13, 0.11, 0.1 },
		chosen_color = { 0.45, 0.07, 0.05 },
		sigil_color = { 0.72, 0.6, 0.4 },
		chosen_sigil_color = { 1, 0.85, 0.55 },
		lit_alpha = 0.25,
		lit_color = { 0.9, 0.3, 0.18 },
		name_font = DiabolicFont_Hidden,
	},
})

-- Bar
Merge(window, {
	bar = {
		texture = path .. [[textures\DiabolicUI_D3_BreathMeter.tga]],
		canvas = { 256, 64 },
		art = { 12, 10, 202, 35 },
		left = { 0, 14 },
		middle = { 14, 200 },
		right = { 200, 214 },
		statusbar = path .. [[textures\DiabolicUI_D3_BreathMeterFill.tga]],
		track = path .. [[textures\DiabolicUI_D3_BreathMeterTrack.tga]],
		color = { 1, 1, 1 },
		spike = 8,
	},
})

-- Button
Merge(window, {
	rect_button = { art = { 0, 1, 457, 63 }, canvas = { 512, 64 }, left = { 0, 48 }, middle = { 48, 409 }, right = { 409, 457 }, texture = { dark = path .. [[textures\DiabolicUI_D3_ButtonDark.tga]], lit = path .. [[textures\DiabolicUI_D3_ButtonLit.tga]], normal = path .. [[textures\DiabolicUI_D3_Button.tga]] } },
	button_border = { offset = { -10, 10 }, size = { 64, 64 }, texture = path .. [[textures\DiabolicUI_Button_44x44_Border.tga]] },
	button_font = DiabolicFont_HeaderRegular12,
	button_font_small = DiabolicFont_HeaderRegular10,
	button_font_narrow = DiabolicFont_SansBold10,
	button_text_margin = 6,
	button_text_color = { 1, 1, 1 },
	button_disabled_color = { 0.5, 0.47, 0.44 },
})

-- CheckBox
Merge(window, {
	check_box = {
		texture = path .. [[textures\DiabolicUI_D3_CheckBox.tga]],
		box = { 0, 0.1640625, 0, 0.671875 },
		lit = { 0.25, 0.4140625, 0, 0.671875 },
		check = [[Interface\Buttons\UI-CheckBox-Check]], -- Blizzard's gold tick, over our box
		check_disabled = [[Interface\Buttons\UI-CheckBox-Check-Disabled]],
		check_scale = 1.6, -- its file's 32 for Blizzard's box of about 20: as big over ours
		size = 20,
		pushed_color = { 0.7, 0.7, 0.7 },
		label_gap = 4,
		font = DiabolicFont_Narrow14,
		stacked = { font = DiabolicFont_Narrow12, size = 16 },
	},
})

-- CloseButton
Merge(window, {
	close = {
		size = 22,
		texture = { lit = path .. [[textures\DiabolicUI_D3_CloseLit.tga]], normal = path .. [[textures\DiabolicUI_D3_Close.tga]], pushed = path .. [[textures\DiabolicUI_D3_ClosePushed.tga]] },
		texcoords = { 0.1875, 0.8125, 0.1875, 0.8125 },
		socket_size = 62,
		socket_inset = 20,
		socket_corner = path .. [[textures\DiabolicUI_D3_SocketCorner.tga]],
		socket_color = { 0, 0, 0, 1 },
	},
})

-- Columns
Merge(window, {
	columns = {
		hover_color = { 0.56, 0.1, 0.04, 0.9 },
		line_color = { 0.42, 0.33, 0.18, 1 },
		line_inset = 5,
	},
})

-- DropDown
Merge(window, {
	dropdown = {
		height = 22,
		inset = 16,
		text_padding = 6,
		field = { bevel = { dark = 0.65, light = 1.2 }, line_color = { 0.62, 0.48, 0.25 }, line_dark = { 0.26, 0.19, 0.09 }, sheen_ends = 0.55, stone = path .. [[textures\DiabolicUI_D3_DropDown_Plate.tga]], stone_coords = { 0.078125, 0.44921875, 0.296875, 0.65625 }, texture = [[Interface\Buttons\WHITE8X8]] },
		arrow = { lit = path .. [[textures\DiabolicUI_D3_DropDownLit.tga]], normal = path .. [[textures\DiabolicUI_D3_DropDown.tga]], pushed = path .. [[textures\DiabolicUI_D3_DropDownPushed.tga]] },
		arrow_size = 18,
		arrow_inset = 2,
		arrow_gap = 4,
		arrow_texcoords = { 0, 0.71875, 0, 0.71875 },
	},
})

-- EditBox
Merge(window, {
	edit_padding = 8,
	hint = { color = { 0.5, 0.45, 0.4 }, font = DiabolicFont_Narrow14, inset = 2 },
})

-- ListRow
Merge(window, {
	chosen_row = { fill = { 1, 0.55, 0.15, 0.12 }, line = { 1, 0.6, 0.15, 0.9 }, width = 1 },
	expander = { minus = { 0, 0.5, 0.5, 1 }, plus = { 0, 0.5, 0, 0.5 }, texture = path .. [[textures\DiabolicUI_ExpandCollapseButton_22x21.tga]] },
})

-- Pager
Merge(window, {
	pager_size = 26,
})

-- Panel
Merge(window, {
	panel = {
		backdrop = { bgFile = [[Interface\ChatFrame\ChatFrameBackground]], edgeFile = path .. [[textures\DiabolicUI_Tooltip_Body.tga]], edgeSize = 32, insets = { bottom = 3, left = 3, right = 3, top = 3 } },
		backdrop_color = { 0, 0, 0, 0.5 },
		backdrop_border_color = { 0.9745098039, 0.768627451, 0.3843137255, 1 },
	},
})

-- ScrollBar
Merge(window, {
	scrollbar = {
		width = 16,
		up = { disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_UpDisabled.tga]], lit = path .. [[textures\DiabolicUI_ChatButtons_36x36_UpHighlight.tga]], normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Up.tga]] },
		down = { disabled = path .. [[textures\DiabolicUI_ChatButtons_36x36_DownDisabled.tga]], lit = path .. [[textures\DiabolicUI_ChatButtons_36x36_DownHighlight.tga]], normal = path .. [[textures\DiabolicUI_ChatButtons_36x36_Down.tga]] },
		arrow_texcoords = { 0.21875, 0.78125, 0.21875, 0.78125 },
		thumb = path .. [[textures\DiabolicUI_Slider_22x36_Thumb.tga]],
		thumb_texcoords = { 0.328125, 0.671875, 0.21875, 0.78125 },
		thumb_height = 26,
		blank = [[Interface\Buttons\WHITE8X8]],
		line = 1,
		track_color = { 0, 0, 0, 0.85 },
		line_color = { 0.35, 0.27, 0.15, 1 },
	},
})

-- Section
Merge(window, {
	section = {
		height = 22, -- a table's column names' (its sections' line under their title)
		font = DiabolicFont_HeaderRegular12,
		color = { 1, 0.6, 0.2 },
		line_color = { 0.43, 0.33, 0.2, 1 }, -- the thin line under the title
		text_offset = { 4, 1 },
	},
})

-- Tab
Merge(window, {
	tab = {
		height = 26,
		font = DiabolicFont_HeaderRegular12,
		text_offset = 1,
	},
})

-- TabRow
Merge(window, {
	tab_row = 32,
})

-- Window
Merge(window, {
	backdrop = { bgFile = path .. [[textures\DiabolicUI_Tooltip_Background.tga]], edgeFile = path .. [[textures\DiabolicUI_Tooltip_Border.tga]], edgeSize = 32, insets = { bottom = 23, left = 23, right = 23, top = 23 }, tile = true, tileSize = 256 },
	backdrop_color = { 0.8, 0.65, 0.65, 1 },
	backdrop_border_color = { 1, 1, 1, 1 },
	band = { canvas = { 364, 104 }, texture = path .. [[textures\DiabolicUI_D3_Band.tga]] },
	band_text = { label = { 0.86, 0.76, 0.6 }, label_button_font = DiabolicFont_Narrow14Gold, label_font = DiabolicFont_Narrow14, value = { 1, 1, 1 }, value_font = DiabolicFont_Narrow14 },
	title_plate = { color = { 0.86, 0.76, 0.6 }, cuts = { 96, 140, 376, 420 }, file_width = 512, font = DiabolicFont_HeaderRegular14, gem = { glass = 0.66, glass_offset = { 0, 0 }, ring = path .. [[textures\DiabolicUI_D3_GemRing.tga]], size = 40, x = 35, y = 0 }, height = 41, max_width = 440, rows = 0.546875, side_room = 62, text_offset = 1, text_width = 200, texture = path .. [[textures\DiabolicUI_D3_TitlePlate.tga]], width = 300, y = -15 },
	title_font = DiabolicFont_HeaderRegular18Title,
	footer_height = 35,
	footer_rail = { bar = { 15, 24 }, cut = { 12, 28 } },
	layout = { band_edge = 10, band_gap = 12, band_right_edge = 48, button_gap = 6, content_gap = 6, uneven = 8 },
})
