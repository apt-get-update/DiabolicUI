-- Static minimap setup ("Minimap"): its default place, the limits of its
-- size, and the colors and sizes of its clock, zone name, compass and mail
-- button (modules/minimap/minimap.lua).
local _, Engine = ...

local color = function(r, g, b)
	return { r / 255, g / 255, b / 255 }
end

Engine:NewStaticConfig("Minimap", {
	position = { point = "TOPRIGHT", x = -30, y = -30 }, -- (relative to the same point of UIParent)

	-- the size players can choose (the Positions page, or right-drag while
	-- frames are unlocked), around its 100%
	minSize = 0.5,
	maxSize = 1.5,

	zoneFadeDuration = 0.25, -- seconds each half (out, then in) of the zone name's crossfade takes

	compassInset = 10,
	compassNorthTag = "N",
	mailSize = { 48, 48 },

	-- the addons' minimap buttons (modules/minimap/buttons.lua): the "+",
	-- each button (the "+"'s ring) and the gap between them in their row,
	-- their icon's size of it (inside the ring's opening), and how often (in
	-- seconds) the minimap is looked at for new ones
	buttons = { toggle_size = 48, size = 40, gap = -8, icon = 0.42, scan_every = 3 }, -- (negative: the ring art has room around it)

	colors = {
		normal = color(229, 178, 38),
		highlight = color(250, 250, 250),
		title = color(255, 234, 137),
		offwhite = color(196, 196, 196),
		green = color(25, 178, 25),
		ui = color(192, 192, 192),
		questGreen = color(89, 201, 89),
		-- zone names, by GetZonePVPInfo's pvp type
		zone = {
			arena = color(175, 76, 56),
			combat = color(175, 76, 56),
			contested = color(229, 159, 28),
			friendly = color(64, 175, 38),
			hostile = color(175, 76, 56),
			sanctuary = color(104, 204, 239),
		},
	},
})
