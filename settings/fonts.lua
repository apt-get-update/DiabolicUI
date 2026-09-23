local Addon, Engine = ...
local path = ([[Interface\AddOns\%s\media\fonts\]]):format(Addon)

Engine:NewStaticConfig("Fonts", {
	fontObjects = {
		header = {
			objects = {
				"DiabolicFont_HeaderRegular14",
				"DiabolicFont_HeaderRegular16",
					"DiabolicFont_HeaderRegular16White",
				"DiabolicFont_HeaderRegular18",
					"DiabolicFont_HeaderRegular18Title",
					"DiabolicFont_HeaderRegular18Text",
					"DiabolicFont_HeaderRegular18White",
					"DiabolicFont_HeaderRegular18Highlight",

				"DiabolicFont_HeaderBold12",
				"DiabolicFont_HeaderBold14",
				"DiabolicFont_HeaderBold16",
				"DiabolicFont_HeaderBold18",
				"DiabolicFont_HeaderBold24",
				"DiabolicFont_HeaderBold32"
			},
			replacements = {
				koKR = path .. "NotoSansCJKkr-Regular.otf", -- Korean
				zhTW = path .. "NotoSansCJKtc-Regular.otf",	-- Chinese - Traditional, Taiwan 
				zhCN = path .. "NotoSansCJKsc-Regular.otf"	-- Chinese - Simplified, PRC
			}
		},
		regular = {
			objects = {
				"DiabolicFont_SansRegular10",
					"DiabolicFont_SansRegular10White",
					"DiabolicFont_SansRegular10Text",
				"DiabolicFont_SansRegular12",
					"DiabolicFont_SansRegular12White",
					"DiabolicFont_SansRegular12Title",
					"DiabolicFont_SansRegular12Text",
				"DiabolicFont_SansRegular14",
					"DiabolicFont_SansRegular14White",
					"DiabolicFont_SansRegular14Title",
				"DiabolicFont_SansRegular16",
					"DiabolicFont_SansRegular16Orange",
					"DiabolicFont_SansRegular16Red",
				"DiabolicFont_SansRegular18",

				"DiabolicFont_SansBold8",
				"DiabolicFont_SansBold10",
					"DiabolicFont_SansBold10Gray",
					"DiabolicFont_SansBold10White",
					"DiabolicFont_SansBold10Title",
				"DiabolicFont_SansBold12",
					"DiabolicFont_SansBold12Text",
					"DiabolicFont_SansBold12White",
				"DiabolicFont_SansBold13",
				"DiabolicFont_SansBold14",
				"DiabolicFont_SansBold16",
				"DiabolicFont_SansBold18",
				"DiabolicFont_SansBold28",

				"DiabolicFont_SerifRegular10",
				"DiabolicFont_SerifRegular12",
				"DiabolicFont_SerifRegular14",
				"DiabolicFont_SerifRegular16",
					"DiabolicFont_SerifRegular16Orange",
					"DiabolicFont_SerifRegular16Red",
				"DiabolicFont_SerifRegular18",
				"DiabolicFont_SerifRegular24",
				"DiabolicFont_SerifRegular28",
				"DiabolicFont_SerifRegular32"
			},
			replacements = {
				koKR = path .. "NotoSansCJKkr-Regular.otf", -- Korean
				zhTW = path .. "NotoSansCJKtc-Regular.otf",	-- Chinese - Traditional, Taiwan 
				zhCN = path .. "NotoSansCJKsc-Regular.otf"	-- Chinese - Simplified, PRC
			}
		}

	},
	fonts = {
		text_normal = {
			path = path .. "NotoSans-Bold.ttf", -- DejaVuSans
			locales = {
				enUS  = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		text_narrow = {
			path = path .. "NotoSans-Bold.ttf", -- DejaVuSansCondensed
			locales = {
				enUS  = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		text_serif = {
			path = path .. "NotoSans-Bold.ttf", -- DejaVuSerifCondensed
			locales = {
				enUS  = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		text_serif_italic = {
			path = path .. "NotoSans-Bold.ttf", -- DejaVuSerifCondensed-Italic
			locales = {
				enUS  = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		header_normal = {
			path = path .. "ExocetBlizzardMedium.ttf",
			locales = {
				enUS  = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		header_light = {
			path = path .. "ExocetBlizzardLight.ttf",
			locales = {
				enUS  = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		number = {
			path = path .. "Sylfaen.ttf",
			locales = {
				enUS = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true,
				ruRU = true
			}
		},
		damage = {
			path = path .. "ExocetBlizzardMedium.ttf",
			locales = {
				enUS = true,
				enGB = true,
				deDE = true,
				esES = true,
				esMX = true,
				frFR = true,
				itIT = true,
				ptBR = true,
				ptPT = true
			}
		}
	}
})
