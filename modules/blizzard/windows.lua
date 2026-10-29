-- Diablo III's window, in parts the Blizzard window skins put together
-- (achievements.lua, character.lua, spellbook.lua and the others): the
-- stone window in its iron frame, a red stained-glass band along its top
-- with the title in a plate on its top edge, a stone cartouche for a key
-- number, darker panels, section title bars, flat red buttons and tabs,
-- the windows' own tabs as banners hanging from their foot, and spiked
-- bars; a cover of the same stone for another page over one.
-- Buttons and bars are cut in three so their ends keep their shape at any
-- width.
-- Settings in settings/blizzard.lua (window).
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Windows")

-- Lua API
local _G = _G
local ipairs = ipairs
local table_insert = table.insert
local table_remove = table.remove
local table_sort = table.sort
local math_abs = math.abs
local math_ceil = math.ceil
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local select = select
local setmetatable = setmetatable
local string_find = string.find
local string_upper = string.upper
local type = type
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown

local config
local BannerIndex -- an emblem's place in the banners' atlas, by name (OnInit)
local Windows = {} -- every window made, its Blizzard frame its .Frame (/dui layout checks them)
Module.Windows = Windows
local LitRows = {} -- every chosen row's copper bar (LightRow; /dui layout reads text on it)
Module.LitRows = LitRows

-- How far `window`'s top is lowered (DropTop): the tab row it no longer needs.
local Drop = function(window)
	return window.DiabolicDrop or 0
end

-- Three textures that draw `spec`'s art across `frame` at `height`, their
-- ends at its sides (`inset` in from them), centred on it; drawn by `owner`
-- when it's another frame than `frame`.
local Slices = {}
Slices.__index = Slices

Slices.SetTexture = function(self, file)
	for _, texture in ipairs(self) do
		texture:SetTexture(file)
	end
end

Slices.SetAlpha = function(self, alpha)
	for _, texture in ipairs(self) do
		texture:SetAlpha(alpha)
	end
end

Slices.Show = function(self)
	for _, texture in ipairs(self) do
		texture:Show()
	end
end

Slices.Hide = function(self)
	for _, texture in ipairs(self) do
		texture:Hide()
	end
end

Module.CreateSlices = function(self, frame, layer, spec, file, height, inset, owner)
	local width, canvasHeight = spec.canvas[1], spec.canvas[2]
	local x0, y0, x1, y1 = unpack(spec.art)
	local scale = height / (y1 - y0)
	-- the art's centre on the frame's
	local y = ((y0 + y1) / 2 - canvasHeight / 2) * scale
	inset = inset or 0
	owner = owner or frame
	local left = owner:CreateTexture(nil, layer)
	left:SetSize((spec.left[2] - spec.left[1]) * scale, canvasHeight * scale)
	left:SetPoint("LEFT", frame, "LEFT", inset - (x0 - spec.left[1]) * scale, y)
	left:SetTexCoord(spec.left[1] / width, spec.left[2] / width, 0, 1)
	local right = owner:CreateTexture(nil, layer)
	right:SetSize((spec.right[2] - spec.right[1]) * scale, canvasHeight * scale)
	right:SetPoint("RIGHT", frame, "RIGHT", -inset + (spec.right[2] - x1) * scale, y)
	right:SetTexCoord(spec.right[1] / width, spec.right[2] / width, 0, 1)
	local middle = owner:CreateTexture(nil, layer)
	middle:SetPoint("TOPLEFT", left, "TOPRIGHT")
	middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")
	middle:SetTexCoord(spec.middle[1] / width, spec.middle[2] / width, 0, 1)
	local slices = setmetatable({ left, middle, right }, Slices)
	slices:SetTexture(file)
	return slices
end

-- The window's stone, in tiles of the texture's own size laid side by
-- side, the last ones cut: the client stretches a backdrop's tiled
-- background into streaks past its first tile. Drawn on `frame` from its
-- corner (`left`, `top` in) over `width` by `height`, which start `x`, `y`
-- into the window's stone: a cover's stone carries on its window's. Its
-- tiles the window's own stone (DiabolicTile: a backdrop of tiles) if it
-- has one, our stone otherwise.
local TileStone = function(frame, left, top, x, y, width, height)
	local backdrop = config.backdrop
	local stone = frame.DiabolicTile
	local size = stone and stone.tile or backdrop.tileSize
	local file = stone and stone.texture or backdrop.bgFile
	local color = stone and stone.color or config.backdrop_color
	local tiles = frame.DiabolicStone
	for _, tile in pairs(tiles) do
		tile:Hide()
	end
	if (width <= 0) or (height <= 0) then
		return
	end
	local n = 0
	for row = math_floor(y / size), math_ceil((y + height) / size) - 1 do
		local y0, y1 = math_max(y, row * size), math_min(y + height, (row + 1) * size)
		for column = math_floor(x / size), math_ceil((x + width) / size) - 1 do
			local x0, x1 = math_max(x, column * size), math_min(x + width, (column + 1) * size)
			n = n + 1
			local tile = tiles[n]
			if not tile then
				tile = frame:CreateTexture(nil, "BACKGROUND")
				tiles[n] = tile
			end
			tile:SetTexture(file)
			tile:SetVertexColor(unpack(color))
			tile:ClearAllPoints()
			tile:SetPoint("TOPLEFT", frame, "TOPLEFT", left + x0 - x, -top - (y0 - y))
			tile:SetSize(x1 - x0, y1 - y0)
			tile:SetTexCoord((x0 - column * size) / size, (x1 - column * size) / size, (y0 - row * size) / size, (y1 - row * size) / size)
			tile:Show()
		end
	end
end

-- The window's painted background cut to its shape (the middle of the
-- art kept), so it isn't stretched.
local FitBackground = function(window, width, height)
	local background = window.DiabolicBackground
	if (not background) or (width <= 0) or (height <= 0) then
		return
	end
	local aspect = width / height
	local art = window.DiabolicBackgroundAspect
	if (aspect > art) then
		local cut = (1 - art / aspect) / 2
		background:SetTexCoord(0, 1, cut, 1 - cut)
	else
		local cut = (1 - aspect / art) / 2
		background:SetTexCoord(cut, 1 - cut, 0, 1)
	end
end

-- `frame` laid out by `layout` on the next frame drawn, and each one after
-- while it has no size yet (built before the client placed it: the first
-- time a window opens after logging in, no size change follows).
local Later = function(frame, layout)
	frame:SetScript("OnUpdate", function()
		frame:SetScript("OnUpdate", nil)
		layout(frame)
	end)
end

local LayoutStone
LayoutStone = function(window)
	local insets = config.backdrop.insets
	local top = insets.top + Drop(window)
	local width = window:GetWidth() - insets.left - insets.right
	local height = window:GetHeight() - top - insets.bottom
	if (width <= 0) or (height <= 0) then
		Later(window, LayoutStone)
	end
	TileStone(window, insets.left, top, 0, 0, width, height)
	FitBackground(window, width, height)
end

-- The painted background inside the iron.
local PlaceBackground = function(window)
	local background = window.DiabolicBackground
	if background then
		local insets = config.backdrop.insets
		background:ClearAllPoints()
		background:SetPoint("TOPLEFT", insets.left, -insets.top - Drop(window))
		background:SetPoint("BOTTOMRIGHT", -insets.right, insets.bottom)
	end
end

-- `window`'s painted background (config.backgrounds' `name`) over its
-- stone, inside the iron, under all it shows; or, one in tiles (`tile`,
-- their size), its stone instead.
Module.SetBackground = function(self, window, name)
	local spec = config.backgrounds[name]
	local insets = config.backdrop.insets
	if spec.tile then
		window.DiabolicTile = spec
		if window.DiabolicBackground then
			window.DiabolicBackground:Hide()
		end
		LayoutStone(window)
		return
	end
	window.DiabolicTile = nil
	local background = window.DiabolicBackground
	if not background then
		background = window:CreateTexture(nil, "BORDER")
		window.DiabolicBackground = background
		PlaceBackground(window)
	end
	background:SetTexture(spec.texture)
	background:Show()
	window.DiabolicBackgroundAspect = spec.aspect
	LayoutStone(window)
end

local LayoutCover
LayoutCover = function(cover)
	if (cover:GetWidth() <= 0) or (cover:GetHeight() <= 0) then
		Later(cover, LayoutCover)
	end
	local insets = config.backdrop.insets
	local y = cover.DiabolicY - insets.top - Drop(cover.DiabolicWindow)
	TileStone(cover, 0, 0, cover.DiabolicX - insets.left, y, cover:GetWidth(), cover:GetHeight())
end

-- The window's iron, from its (lowered) top.
local PlaceBorder = function(window)
	local border = window.Border
	border:ClearAllPoints()
	border:SetPoint("TOPLEFT", window, "TOPLEFT", 0, -Drop(window))
	border:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT")
end

-- The window behind `frame`, from its corners by `insets` (left, top,
-- right, bottom; positive outward), under its children: its stone our
-- tiles, its iron frame a backdrop over the title bar's band, so the band
-- sits inside it (Diablo III's).
Module.CreateWindow = function(self, frame, insets)
	local window = CreateFrame("Frame", nil, frame)
	window:SetFrameLevel(frame:GetFrameLevel())
	window:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	window:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	-- over the band (+1), under the close button's socket (+4)
	local border = CreateFrame("Frame", nil, window)
	border:SetFrameLevel(window:GetFrameLevel() + 3)
	border:SetBackdrop({
		edgeFile = config.backdrop.edgeFile,
		edgeSize = config.backdrop.edgeSize,
		insets = config.backdrop.insets
	})
	border:SetBackdropBorderColor(unpack(config.backdrop_border_color))
	window.Border = border
	PlaceBorder(window)
	window.DiabolicStone = {}
	window.DiabolicHeaders, window.DiabolicCovers = {}, {}
	window:SetScript("OnSizeChanged", LayoutStone)
	window:HookScript("OnShow", LayoutStone) -- (its size may have come with no change told)
	LayoutStone(window)
	window.Frame = frame
	Windows[#Windows + 1] = window
	return window
end

-- A part of `window`'s stone over what it shows, `insets` (left, top,
-- right, bottom) in from its corners, `level` frames up: another page in
-- the same place, over the one under it without touching it (Blizzard's
-- secure buttons can't be hidden by us without tainting them). It takes
-- the mouse, so nothing under it is clicked.
Module.CreateCover = function(self, window, insets, level)
	local cover = CreateFrame("Frame", nil, window:GetParent())
	cover:SetFrameLevel(window:GetFrameLevel() + level)
	cover:SetPoint("TOPLEFT", window, "TOPLEFT", insets[1], -insets[2])
	cover:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -insets[3], insets[4])
	cover:EnableMouse(true)
	cover.DiabolicX, cover.DiabolicY = insets[1], insets[2]
	cover.DiabolicWindow = window
	table_insert(window.DiabolicCovers, cover)
	cover.DiabolicTile = window.DiabolicTile
	cover.DiabolicStone = {}
	cover:SetScript("OnSizeChanged", LayoutCover)
	cover:SetScript("OnShow", LayoutCover)
	LayoutCover(cover)
	return cover
end

-- The window dragged by its own stone too, where it reaches past
-- Blizzard's frame, as `frame` is dragged (BlizzMove's handlers).
Module.AddDrag = function(self, window, frame)
	window:EnableMouse(true)
	window:RegisterForDrag("LeftButton")
	for _, script in ipairs({ "OnDragStart", "OnDragStop" }) do
		window:SetScript(script, function()
			local handler = frame:GetScript(script)
			if handler then
				handler(frame)
			end
		end)
	end
end

-- The band's tiles across the header, each at the band's height and its
-- art's shape, the last one cut (later if it has no size yet).
local LayoutBand
LayoutBand = function(header)
	local band = config.band
	local height = header:GetHeight()
	local width = header:GetWidth()
	local size = height * band.canvas[1] / band.canvas[2]
	local tiles = header.DiabolicBand
	for _, tile in pairs(tiles) do
		tile:Hide()
	end
	if (width <= 0) or (height <= 0) then
		Later(header, LayoutBand)
		return
	end
	for i = 1, math_ceil(width / size) do
		local tile = tiles[i]
		if not tile then
			tile = header:CreateTexture(nil, "BACKGROUND")
			tile:SetTexture(band.texture)
			tiles[i] = tile
		end
		local w = math_min(size, width - (i - 1) * size)
		tile:ClearAllPoints()
		tile:SetPoint("TOPLEFT", header, "TOPLEFT", (i - 1) * size, 0)
		tile:SetSize(w, height)
		tile:SetTexCoord(0, w / size, 0, 1)
		tile:Show()
	end
end

-- The title bar along the top of `window`, `height` tall, `insets` (x, y)
-- in from its edges: the red band (the window's controls go in it). Returns
-- the band's place.
local PlaceHeader = function(header)
	local window, insets = header:GetParent(), header.DiabolicInsets
	header:ClearAllPoints()
	header:SetPoint("TOPLEFT", insets[1], -insets[2] - Drop(window))
	header:SetPoint("TOPRIGHT", -insets[1], -insets[2] - Drop(window))
end

Module.CreateHeader = function(self, window, height, insets)
	local header = CreateFrame("Frame", nil, window)
	header.DiabolicInsets = insets
	PlaceHeader(header)
	if window.DiabolicHeaders then
		table_insert(window.DiabolicHeaders, header)
	end
	header:SetHeight(height)
	header.DiabolicBand = {}
	header:SetScript("OnSizeChanged", LayoutBand)
	header:SetScript("OnShow", LayoutBand)
	LayoutBand(header)
	-- the band glowing in its middle
	local glow = header:CreateTexture(nil, "ARTWORK")
	glow:SetTexture(config.band.glow)
	glow:SetBlendMode("ADD")
	glow:SetAlpha(config.band.glow_alpha)
	glow:SetSize(height * config.band.glow_width, height)
	glow:SetPoint("CENTER")
	return header
end

-- `header`'s band dropped (a window with nothing in it): out of sight,
-- no longer its window's (its title still on the window's plate).
Module.DropBand = function(self, header)
	header:Hide()
	local headers = header:GetParent().DiabolicHeaders
	for i = #headers, 1, -1 do
		if (headers[i] == header) then
			table_remove(headers, i)
		end
	end
end

-- `plate` `width` wide: its plain stretches (between its ends and its
-- middle) drawn out, the rest as drawn.
local SizePlate = function(plate, width)
	plate:SetWidth(width)
	local stretch = (width - plate.DiabolicFixed) / 2
	for _, piece in ipairs(plate.DiabolicStretches) do
		piece:SetWidth(stretch)
	end
end

-- The title on its plate, the plate as wide as its widest title shown (up
-- to `max_width`, and clear of the window's corners: `side_room` from each
-- side), cut short past that (one line).
local FitTitle = function(title)
	local spec = config.title_plate
	local plate = title:GetParent()
	local margin = spec.width - spec.text_width
	local room = plate:GetParent():GetWidth() - 2 * spec.side_room
	local most = math_max(spec.text_width, math_min(spec.max_width, room) - margin)
	title:SetSize(0, 0)
	if title:GetStringWidth() > most then
		title:SetSize(most, select(2, title:GetFont()) + 2)
	end
	local width = spec.width
	for _, shown in ipairs(plate.DiabolicTitles) do
		if shown:IsShown() and ((shown:GetText() or "") ~= "") then
			width = math_max(width, math_min(shown:GetStringWidth(), most) + margin)
		end
	end
	SizePlate(plate, width)
end

-- `title` (a font string) on Diablo III's plate on the top edge of
-- `header`'s window (one plate for its titles: the character's and its
-- pet's), fitted again each time its text changes (a guild's rank and name
-- can be long). The band left to the window's own controls.
Module.SetTitle = function(self, header, title)
	local spec = config.title_plate
	local window = header:GetParent()
	local plate = window.DiabolicPlate
	if not plate then
		plate = CreateFrame("Frame", nil, window)
		plate:SetFrameLevel(window.Border:GetFrameLevel()) -- (its art over the iron's)
		plate:SetSize(spec.width, spec.height)
		-- (on the iron's top, lowered with it: DropTop)
		plate:SetPoint("CENTER", window.Border, "TOP", 0, spec.y)
		-- its art in pieces at its cuts (in its file's pixels), every
		-- other one a plain stretch drawn out as it grows
		local scale = spec.width / spec.file_width
		local cuts = { 0, unpack(spec.cuts) }
		cuts[#cuts + 1] = spec.file_width
		plate.DiabolicFixed, plate.DiabolicStretches, plate.DiabolicTitles = 0, {}, {}
		local previous
		for i = 1, #cuts - 1 do
			local piece = plate:CreateTexture(nil, "ARTWORK")
			piece:SetTexture(spec.texture)
			piece:SetTexCoord(cuts[i] / spec.file_width, cuts[i + 1] / spec.file_width, 0, spec.rows)
			piece:SetSize((cuts[i + 1] - cuts[i]) * scale, spec.height)
			if previous then
				piece:SetPoint("LEFT", previous, "RIGHT")
			else
				piece:SetPoint("LEFT", plate, "LEFT")
			end
			if (i % 2 == 0) then
				plate.DiabolicStretches[#plate.DiabolicStretches + 1] = piece
			else
				plate.DiabolicFixed = plate.DiabolicFixed + piece:GetWidth()
			end
			previous = piece
		end
		window.DiabolicPlate = plate
		-- (fitted again as the window's width changes: the character's tabs)
		window:HookScript("OnSizeChanged", function()
			for _, shown in ipairs(plate.DiabolicTitles) do
				FitTitle(shown)
			end
		end)
	end
	plate.DiabolicTitles[#plate.DiabolicTitles + 1] = title
	title:SetParent(plate)
	title:SetDrawLayer("OVERLAY")
	title:SetFontObject(spec.font)
	title:SetTextColor(unpack(config.title_plate.color))
	title:SetShadowOffset(1, -1)
	title:SetJustifyH("CENTER")
	title:ClearAllPoints()
	title:SetPoint("CENTER", plate, "CENTER", 0, spec.text_offset)
	title.DiabolicHeader = header
	if not title.DiabolicFitted then
		title.DiabolicFitted = true
		hooksecurefunc(title, "SetText", FitTitle)
		hooksecurefunc(title, "SetFormattedText", FitTitle)
	end
	FitTitle(title)
end

-- A gem socketed in the left cross of `header`'s title plate (SetTitle's,
-- first): a round icon (gem.icon, SetPortraitToTexture's) in Diablo III's
-- amber ring, a button for the window's tooltip and click.
Module.AddTitleGem = function(self, header)
	local spec = config.title_plate.gem
	local plate = header:GetParent().DiabolicPlate
	local gem = CreateFrame("Button", nil, plate)
	gem:SetFrameLevel(plate:GetFrameLevel() + 2)
	gem:SetSize(spec.size, spec.size)
	gem:SetPoint("CENTER", plate, "LEFT", spec.x, spec.y)
	local glass = spec.size * spec.glass
	gem.icon = gem:CreateTexture(nil, "ARTWORK")
	gem.icon:SetSize(glass, glass)
	gem.icon:SetPoint("CENTER", gem, "CENTER", unpack(spec.glass_offset))
	local ring = gem:CreateTexture(nil, "OVERLAY")
	ring:SetTexture(spec.ring)
	ring:SetAllPoints()
	return gem
end

-- A stone cartouche in the middle of the header's band, for a key number:
-- `text` in it after `icon`, the cartouche fitted to them.
local FitCartouche = function(text)
	local cartouche = text.DiabolicCartouche
	cartouche:SetWidth(text:GetStringWidth() + cartouche.icon:GetWidth() + config.cartouche.padding)
end

Module.CreateCartouche = function(self, header, text, icon)
	local spec = config.cartouche
	local cartouche = CreateFrame("Frame", nil, header)
	cartouche:SetPoint("CENTER", header, "CENTER")
	cartouche:SetHeight(spec.height)
	self:CreateSlices(cartouche, "BACKGROUND", spec, spec.texture, spec.height)
	text:SetParent(cartouche)
	text:SetDrawLayer("OVERLAY")
	text:SetFont(unpack(spec.font))
	text:SetTextColor(unpack(spec.color))
	text:SetShadowOffset(1, -1)
	text:ClearAllPoints()
	-- the pair, centred: the icon left of the number
	cartouche.icon = icon
	icon:SetParent(cartouche)
	icon:ClearAllPoints()
	icon:SetPoint("RIGHT", text, "LEFT", -2, 0)
	text:SetPoint("CENTER", cartouche, "CENTER", icon:GetWidth() / 2, 0)
	text.DiabolicCartouche = cartouche
	hooksecurefunc(text, "SetText", FitCartouche)
	FitCartouche(text)
	return cartouche
end

-- A section's title bar on `frame` (its own art out of sight): `title` on
-- its left in orange.
Module.StyleSection = function(self, frame, title, regions)
	for _, region in ipairs(regions or {}) do
		region:SetAlpha(0)
	end
	local spec = config.section
	self:CreateSlices(frame, "BACKGROUND", spec, spec.texture, spec.height)
	if title then
		title:SetFontObject(spec.font)
		title:SetTextColor(unpack(spec.color))
		title:SetJustifyH("LEFT")
		title:ClearAllPoints()
		title:SetPoint("LEFT", frame, "LEFT", unpack(spec.text_offset))
	end
end

-- A frame's backdrop as one of the window's panels.
Module.StylePanel = function(self, frame)
	frame:SetBackdrop(config.panel.backdrop)
	frame:SetBackdropColor(unpack(config.panel.backdrop_color))
	frame:SetBackdropBorderColor(unpack(config.panel.backdrop_border_color))
end

-- Diablo III's stone pane (window.materials') on `frame`, for a model or
-- a grid of slots, in place of a panel; `open`: its frame alone, over
-- what `frame` draws behind it (a scene, a picture) up to its line. Its
-- slices returned.
Module.StylePane = function(self, frame, open)
	local slices = self:CreateNine(frame, open and "BORDER" or "BACKGROUND", open and "pane_open" or "pane")
	if open then
		slices[5]:Hide()
	end
	return slices
end

-- A pane around `first` (to `last`'s bottom right, when given),
-- window.pane_outset past it, on a frame of its own over `first`'s
-- parent (`open`: around its picture) or under its parts. The frame returned.
Module.AddPane = function(self, first, last, open)
	local parent = first:GetParent()
	local outset = config.pane_outset
	local pane = CreateFrame("Frame", nil, parent)
	pane:SetFrameLevel(parent:GetFrameLevel() + (open and 1 or 0))
	pane:SetPoint("TOPLEFT", first, "TOPLEFT", -outset, outset)
	pane:SetPoint("BOTTOMRIGHT", last or first, "BOTTOMRIGHT", outset, -outset)
	self:StylePane(pane, open)
	return pane
end

-- A status bar in Diablo III's orange, in the spiked frame; its own
-- `regions` (Blizzard's frame) out of sight.
Module.StyleBar = function(self, bar, regions)
	for _, region in ipairs(regions or {}) do
		region:SetAlpha(0)
	end
	local spec = config.bar
	bar:SetStatusBarTexture(spec.statusbar)
	bar:SetStatusBarColor(unpack(spec.color))
	-- kept orange: Blizzard colors some on each update (the professions' blue)
	local r, g, b = unpack(spec.color)
	hooksecurefunc(bar, "SetStatusBarColor", function(_, red, green, blue)
		if (red ~= r) or (green ~= g) or (blue ~= b) then
			bar:SetStatusBarColor(r, g, b)
		end
	end)
	if (not bar.DiabolicTrack) then
		local track = bar:CreateTexture(nil, "BACKGROUND")
		track:SetTexture(spec.track)
		track:SetAllPoints()
		bar.DiabolicTrack = track
	end
	bar.DiabolicBorder = self:CreateSlices(bar, "OVERLAY", spec, spec.texture, bar:GetHeight())
end

-- Lit art for `button`, shown under the mouse and while it's locked lit
-- (a chosen category), drawn under its text: the button's own highlight
-- layer would cover it. `IsLit` can veto it (a chosen tab isn't lit).
local UpdateLit = function(button)
	local lit = button.DiabolicLit
	local on = (button.DiabolicLocked or button:IsMouseOver()) and (not button.DiabolicNotLit or not button.DiabolicNotLit(button))
	if on then
		lit:Show()
	else
		lit:Hide()
	end
end

Module.AddLit = function(self, button, slices)
	button.DiabolicLit = slices
	slices:Hide()
	button:HookScript("OnEnter", UpdateLit)
	button:HookScript("OnLeave", UpdateLit)
	hooksecurefunc(button, "LockHighlight", function() button.DiabolicLocked = true UpdateLit(button) end)
	hooksecurefunc(button, "UnlockHighlight", function() button.DiabolicLocked = nil UpdateLit(button) end)
end

-- Tabs (PanelTemplates'): the selected one a lit red button, the others
-- dark ones, red under the mouse, their text in Exocet; `inset` keeps their
-- art apart where Blizzard overlaps them.
-- (3.3.5's IsEnabled is 1 or 0: Blizzard disables the chosen tab.)
local IsSelected = function(tab)
	return tab:IsEnabled() == 0
end

-- A tab's text in its art's middle.
local PlaceTabText = function(tab)
	local text = tab:GetFontString()
	if text then
		text.DiabolicPlacing = true
		text:ClearAllPoints()
		text:SetPoint("CENTER", tab, "CENTER", 0, config.tab.text_offset)
		text.DiabolicPlacing = nil
	end
end

-- A banner tab (StyleBanner): red and longer while chosen, dark otherwise;
-- its emblem brighter while chosen. Its text in the invisible font again
-- (Blizzard gives the chosen tab its own) and hidden: the client ignores
-- a font's alpha.
local UpdateBanner = function(tab)
	local art, spec = tab.DiabolicBanner, config.banner
	local chosen = IsSelected(tab)
	art.cloth:SetVertexColor(unpack(chosen and spec.chosen_color or spec.cloth_color))
	if art.gold then
		art.sigil:SetVertexColor(unpack(chosen and spec.chosen_sigil_color or spec.sigil_color))
	end
	-- its top (under the rail) not drawn: a banner over the rail (Blizzard's
	-- tabs aren't all at one level) can't show it
	local height = chosen and (spec.height + spec.drop) or spec.height
	art.cloth:SetHeight(height - spec.tuck)
	for _, texture in ipairs({ art.cloth, art.trim, art.lit }) do
		texture:SetTexCoord(0, 1, spec.tuck / height, 1)
	end
	-- the rail's shadow: the same rows of the cloth and trim, however long
	for _, shadow in ipairs(art.shadows) do
		shadow:SetTexCoord(0, 1, spec.tuck / height, (spec.tuck + spec.shadow) / height)
	end
	local font = spec.name_font
	tab:SetNormalFontObject(font)
	tab:SetHighlightFontObject(font)
	tab:SetDisabledFontObject(font)
	local text = tab:GetFontString()
	if text then
		text:SetFontObject(font)
		text:Hide()
		if not text.DiabolicHidden then
			text.DiabolicHidden = true
			hooksecurefunc(text, "Show", text.Hide)
		end
	end
	UpdateLit(tab)
end

local UpdateTab = function(tab)
	if tab.DiabolicBanner then
		return UpdateBanner(tab)
	end
	local art = tab.DiabolicArt
	if not art then
		return
	end
	if IsSelected(tab) then
		art.red:Show()
		art.dark:Hide()
	else
		art.red:Hide()
		art.dark:Show()
	end
	UpdateLit(tab)
	-- Blizzard gives the chosen tab its own font; the shown text doesn't
	-- follow a new disabled font by itself
	tab:SetDisabledFontObject(tab.DiabolicFont)
	local text = tab:GetFontString()
	if text then
		text:SetFontObject(tab.DiabolicFont)
	end
	PlaceTabText(tab)
end

-- A tab sized to its text, again each time Blizzard sizes it (its tabs do
-- when they show).
local FitTab = function(tab)
	if tab.DiabolicBanner then
		tab:SetWidth(config.banner.width)
		return
	end
	local text = tab:GetFontString()
	if tab.DiabolicWidth and text then
		tab:SetWidth(text:GetStringWidth() + tab.DiabolicWidth)
	end
end

-- A tab's look and width again after it's chosen or not by other means
-- than PanelTemplates' (Enable and Disable), or given another text.
Module.UpdateTab = function(self, tab)
	UpdateTab(tab) -- (its font first: the width follows its text)
	FitTab(tab)
end

-- `options`: inset, the art kept in from the tab's sides; font; padding,
-- the room around its text if it's to be sized to it (leave it out when
-- Blizzard sizes it).
Module.StyleTab = function(self, tab, options)
	local inset = options.inset or 0
	local name = tab:GetName()
	-- (and the achievement tabs' yellow hover glow)
	for _, part in ipairs({ "Left", "Middle", "Right", "LeftDisabled", "MiddleDisabled", "RightDisabled",
		"LeftHighlight", "MiddleHighlight", "RightHighlight" }) do
		local region = _G[name .. part]
		if region then
			region:SetAlpha(0)
		end
	end
	local highlight = tab:GetHighlightTexture()
	if highlight then
		highlight:SetAlpha(0)
	end
	local height = config.tab.height
	local spec = config.rect_button
	tab.DiabolicArt = {
		red = self:CreateSlices(tab, "BACKGROUND", spec, spec.texture.lit, height, inset),
		dark = self:CreateSlices(tab, "BACKGROUND", spec, spec.texture.dark, height, inset)
	}
	tab.DiabolicNotLit = IsSelected
	self:AddLit(tab, self:CreateSlices(tab, "BORDER", spec, spec.texture.normal, height, inset))
	local font = options.font or config.tab.font
	tab.DiabolicFont = font
	tab:SetNormalFontObject(font)
	tab:SetHighlightFontObject(font)
	-- the text stays put when clicked: Blizzard disables the tab while it's
	-- pressed, which would leave it pushed down
	tab:SetPushedTextOffset(0, 0)
	-- and where it's put back (Overachiever moves the tabs' text on clicks)
	local text = tab:GetFontString()
	if text then
		hooksecurefunc(text, "SetPoint", function()
			if not text.DiabolicPlacing then
				PlaceTabText(tab)
			end
		end)
	end
	UpdateTab(tab)
	if options.padding then
		tab.DiabolicWidth = options.padding + inset * 2
		FitTab(tab)
	end
end

-- Tabs as Diablo III's banners (its heroes'), hanging side by side from a
-- window's foot, their tops under its iron: dark cloth in gold trim with
-- an emblem, the chosen one red and hanging lower; the name on hover only.

-- The tab's name under it, unless the tab shows a tooltip of its own (the
-- character's, with its key).
local ShowBannerName = function(tab)
	local tooltip = _G.GameTooltip
	if tooltip:IsOwned(tab) then
		return
	end
	local text = tab:GetText()
	if text and (text ~= "") then
		tooltip:SetOwner(tab, "ANCHOR_BOTTOM")
		tooltip:SetText(text, 1, 1, 1)
	end
end

local HideBannerName = function(tab)
	if _G.GameTooltip:IsOwned(tab) then
		_G.GameTooltip:Hide()
	end
end

-- For a button over a banner (the spellbook's back to its spells).
Module.ShowBannerName = function(self, tab)
	ShowBannerName(tab)
end

-- `tab`'s emblem: one of Diablo III's by name (config.banner.sigil_names),
-- dyed gold; or a WoW icon's file, round, in its own colors (a talent
-- tree's). Anything else gets the default emblem.
Module.SetBannerIcon = function(self, tab, icon)
	local art, spec = tab.DiabolicBanner, config.banner
	local sigil = art.sigil
	local index = icon and BannerIndex[icon]
	if (not index) and not (icon and string_find(icon, "\\", 1, true)) then
		index = BannerIndex[spec.fallback]
	end
	if index then
		local columns, rows = spec.sigil_columns, spec.sigil_rows
		local column, row = (index - 1) % columns, math_floor((index - 1) / columns)
		sigil:SetTexture(spec.sigils)
		sigil:SetTexCoord(column / columns, (column + 1) / columns, row / rows, (row + 1) / rows)
		sigil:SetSize(spec.sigil_size, spec.sigil_size)
		art.gold = true
	else
		_G.SetPortraitToTexture(sigil, icon)
		sigil:SetTexCoord(0, 1, 0, 1)
		sigil:SetSize(spec.icon_size, spec.icon_size)
		sigil:SetVertexColor(1, 1, 1)
		art.gold = nil
	end
	UpdateBanner(tab)
end

-- `tab` (PanelTemplates' or one of ours) as a banner, `icon` its emblem
-- (SetBannerIcon). Blizzard's art out of sight, its text in the invisible
-- font (UpdateBanner); its own width and height kept (FitTab).
Module.StyleBanner = function(self, tab, icon)
	local spec = config.banner
	local name = tab:GetName()
	for _, part in ipairs({ "Left", "Middle", "Right", "LeftDisabled", "MiddleDisabled", "RightDisabled",
		"LeftHighlight", "MiddleHighlight", "RightHighlight" }) do
		local region = name and _G[name .. part]
		if region then
			region:SetAlpha(0)
		end
	end
	for _, texture in ipairs({ tab:GetNormalTexture() or false, tab:GetPushedTexture() or false,
		tab:GetDisabledTexture() or false, tab:GetHighlightTexture() or false }) do
		if texture then
			texture:SetAlpha(0)
		end
	end
	local art = {}
	art.cloth = tab:CreateTexture(nil, "BACKGROUND")
	art.cloth:SetTexture(spec.cloth)
	art.cloth:SetPoint("TOP", tab, "TOP", 0, -spec.tuck)
	art.cloth:SetWidth(spec.width)
	art.trim = tab:CreateTexture(nil, "BORDER")
	art.trim:SetTexture(spec.trim)
	art.trim:SetAllPoints(art.cloth)
	art.sigil = tab:CreateTexture(nil, "ARTWORK")
	art.sigil:SetPoint("CENTER", art.cloth, "TOP", 0, spec.sigil_y + spec.tuck)
	-- under the mouse: the cloth lit
	local lit = tab:CreateTexture(nil, "ARTWORK")
	lit:SetTexture(spec.cloth)
	lit:SetBlendMode("ADD")
	lit:SetAlpha(spec.lit_alpha)
	lit:SetVertexColor(unpack(spec.lit_color))
	lit:SetAllPoints(art.cloth)
	art.lit = lit
	-- the rail's shadow down its top, in its own shape (UpdateBanner)
	art.shadows = {}
	for _, file in ipairs({ spec.cloth, spec.trim }) do
		local shadow = tab:CreateTexture(nil, "OVERLAY")
		shadow:SetTexture(file)
		shadow:SetPoint("TOP", art.cloth, "TOP", 0, 0)
		shadow:SetSize(spec.width, spec.shadow)
		shadow:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 0, 0, 0, spec.shadow_alpha)
		table_insert(art.shadows, shadow)
	end
	tab.DiabolicBanner = art
	tab.DiabolicNotLit = IsSelected
	self:AddLit(tab, setmetatable({ lit }, Slices))
	-- room for the chosen one, longer; not clicked under the iron
	tab:SetSize(spec.width, spec.height + spec.drop)
	tab:SetHitRectInsets(0, 0, spec.tuck, 0)
	tab:HookScript("OnEnter", ShowBannerName)
	tab:HookScript("OnLeave", HideBannerName)
	-- (a text given later, its font string made then: ours too)
	hooksecurefunc(tab, "SetText", UpdateBanner)
	self:SetBannerIcon(tab, icon)
end

-- The iron rail `window`'s banners hang from, in three slices: its ends
-- kept, its middle stretched.
local CreateRail = function(window)
	local spec = config.banner.rail
	local rail = CreateFrame("Frame", nil, window)
	rail:SetHeight(spec.height)
	local left = rail:CreateTexture(nil, "ARTWORK")
	left:SetTexture(spec.texture)
	left:SetTexCoord(0, spec.cap, 0, spec.rows)
	left:SetPoint("TOPLEFT", rail, "TOPLEFT", 0, 0)
	left:SetSize(spec.cap_width, spec.height)
	local right = rail:CreateTexture(nil, "ARTWORK")
	right:SetTexture(spec.texture)
	right:SetTexCoord(1 - spec.cap, 1, 0, spec.rows)
	right:SetPoint("TOPRIGHT", rail, "TOPRIGHT", 0, 0)
	right:SetSize(spec.cap_width, spec.height)
	local middle = rail:CreateTexture(nil, "ARTWORK")
	middle:SetTexture(spec.texture)
	middle:SetTexCoord(spec.cap, 1 - spec.cap, 0, spec.rows)
	middle:SetPoint("TOPLEFT", left, "TOPRIGHT", 0, 0)
	middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT", 0, 0)
	rail.Clasps = {}
	return rail
end

-- `window`'s banners (those shown) side by side from the left of its
-- foot, hanging from the rail (over them, under the window's iron).
local HangBanners = function(window)
	local spec = config.banner
	local shown = {}
	for _, tab in ipairs(window.DiabolicBanners) do
		if tab:IsShown() then
			shown[#shown + 1] = tab
		end
	end
	local rail = window.DiabolicRail
	if (#shown == 0) then
		if rail then
			rail:Hide()
		end
		return
	end
	if (not rail) then
		rail = CreateRail(window)
		window.DiabolicRail = rail
	end
	local below = spec.rail.height - spec.rail.up -- the rail's height under the foot
	-- over every banner (Blizzard's tabs aren't all at one level)
	local level = 0
	for _, tab in ipairs(shown) do
		level = math_max(level, tab:GetFrameLevel())
	end
	rail:SetFrameLevel(level + 1)
	rail:SetWidth(#shown * spec.width + (#shown - 1) * spec.gap + 2 * spec.rail.overhang)
	rail:ClearAllPoints()
	rail:SetPoint("TOPLEFT", window, "BOTTOMLEFT", spec.left - spec.rail.overhang, spec.rail.up)
	rail:Show()
	window.DiabolicHanging = true
	for i, tab in ipairs(shown) do
		local x = spec.left + (i - 1) * (spec.width + spec.gap)
		tab:ClearAllPoints()
		tab:SetPoint("TOPLEFT", window, "BOTTOMLEFT", x, spec.tuck - below)
		-- its clasps, on the rail (over it and the banner's top)
		for j, middle in ipairs(spec.clasp.x) do
			local index = (i - 1) * #spec.clasp.x + j
			local clasp = rail.Clasps[index]
			if (not clasp) then
				clasp = rail:CreateTexture(nil, "OVERLAY")
				clasp:SetTexture(spec.clasp.texture)
				clasp:SetVertexColor(unpack(spec.clasp.color))
				clasp:SetSize(spec.clasp.width, spec.clasp.height)
				rail.Clasps[index] = clasp
			end
			clasp:ClearAllPoints()
			clasp:SetPoint("CENTER", rail, "BOTTOMLEFT", x - (spec.left - spec.rail.overhang) + middle, spec.clasp.y)
			clasp:Show()
		end
	end
	for index = #shown * #spec.clasp.x + 1, #rail.Clasps do
		rail.Clasps[index]:Hide()
	end
	window.DiabolicHanging = nil
end

-- Again when one shows, hides or is moved (Blizzard places its own as it
-- shows them: the pet's tab).
local Rehang = function(tab)
	local window = tab.DiabolicWindow
	if window and (not window.DiabolicHanging) then
		HangBanners(window)
	end
end

-- `tabs` (in their order) as banners hanging from `window`'s foot, `icons`
-- their emblems (by the same index). Tabs given again are kept as they
-- are; new ones join the row.
Module.HangTabs = function(self, window, tabs, icons)
	window.DiabolicBanners = window.DiabolicBanners or {}
	for i, tab in ipairs(tabs) do
		if not tab.DiabolicBanner then
			self:StyleBanner(tab, icons and icons[i])
			tab.DiabolicWindow = window
			table_insert(window.DiabolicBanners, tab)
			hooksecurefunc(tab, "SetPoint", Rehang)
			tab:HookScript("OnShow", Rehang)
			tab:HookScript("OnHide", Rehang)
		end
	end
	HangBanners(window)
end

-- `window`'s top lowered by the tab row under its band it no longer needs
-- (its tabs hang, HangTabs): its stone, iron, band and close button. The
-- frame itself stays where it is, so what's laid out from it doesn't move;
-- its part above the iron takes no clicks.
Module.DropTop = function(self, window)
	window.DiabolicDrop = config.tab_row
	window:SetHitRectInsets(0, 0, config.tab_row, 0)
	PlaceBorder(window)
	PlaceBackground(window)
	LayoutStone(window)
	for _, header in ipairs(window.DiabolicHeaders) do
		PlaceHeader(header)
	end
	for _, cover in ipairs(window.DiabolicCovers) do
		LayoutCover(cover)
	end
	local socket, close = window.DiabolicSocket, window.DiabolicClose
	if socket then
		local spec = config.close
		socket:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.socket_inset, -spec.socket_inset - config.tab_row)
	end
	if close then
		local spec = config.close
		close:SetPoint("CENTER", window, "TOPRIGHT", -spec.socket_size / 2, -spec.socket_size / 2 - config.tab_row)
	end
end

-- A close button (UIPanelCloseButton's) as Diablo III's, in a socket of
-- `window`'s iron frame at its top right corner: lit under the mouse,
-- darker pressed. (`header` is the band's, kept for its callers.)
Module.StyleClose = function(self, button, window, header)
	local spec = config.close
	self:SkinClose(button)
	if not window.DiabolicSocket then
		window.DiabolicSocket = self:CreateSocket(window)
	end
	window.DiabolicClose = button
	button:ClearAllPoints()
	button:SetPoint("CENTER", window, "TOPRIGHT", -spec.socket_size / 2, -spec.socket_size / 2 - Drop(window))
	-- over its socket, again as the window shows: a toplevel one (the
	-- achievements') is raised then, its X put back under the socket
	local Raise = function()
		button:SetFrameLevel(window.Border:GetFrameLevel() + 2)
	end
	Raise()
	window:HookScript("OnShow", Raise)
end

-- The close button's socket, over the window's iron: the window's left
-- edge (its file's first eighth) on its left, and again on its side along
-- its bottom, outside down, so both bars are lit as the window's sides,
-- the two mitred in its corner; black inside the window's iron, its top and right ends cut at the middle
-- of that iron.
Module.CreateSocket = function(self, window)
	local spec, edge = config.close, config.backdrop.edgeSize
	local file = config.backdrop.edgeFile
	local size = spec.socket_size - spec.socket_inset
	local socket = CreateFrame("Frame", nil, window)
	socket:SetFrameLevel(window.Border:GetFrameLevel() + 1)
	socket:SetSize(size, size)
	socket:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.socket_inset, -spec.socket_inset - Drop(window))
	local fill = socket:CreateTexture(nil, "BACKGROUND")
	fill:SetTexture(unpack(spec.socket_color))
	-- the black from the window's iron's inner edge: its iron over it shows
	local inner = config.backdrop.insets.top - spec.socket_inset
	fill:SetPoint("TOPLEFT", socket, "TOPLEFT", spec.socket_inset, -inner)
	fill:SetPoint("BOTTOMRIGHT", socket, "BOTTOMRIGHT", -inner, spec.socket_inset)
	local left = socket:CreateTexture(nil, "BORDER")
	left:SetTexture(file)
	left:SetTexCoord(0, 1/8, 0, 1)
	left:SetPoint("TOPLEFT", socket, "TOPLEFT")
	left:SetSize(edge, size - edge)
	-- up to the window's iron, not over it
	local bottom = socket:CreateTexture(nil, "BORDER")
	bottom:SetTexture(file)
	bottom:SetTexCoord(1/8, 0, 0, 0, 1/8, 1, 0, 1)
	bottom:SetPoint("BOTTOMRIGHT", socket, "BOTTOMRIGHT", -inner, 0)
	bottom:SetSize(size - edge - inner, edge)
	local corner = socket:CreateTexture(nil, "BORDER")
	corner:SetTexture(spec.socket_corner)
	corner:SetPoint("BOTTOMLEFT", socket, "BOTTOMLEFT")
	corner:SetSize(edge, edge)
	for _, texture in ipairs({ left, bottom, corner }) do
		texture:SetVertexColor(unpack(config.backdrop_border_color))
	end
	return socket
end

-- The close button's look alone, for windows of our own (loot, rolls).
Module.SkinClose = function(self, button)
	local spec = config.close
	button:SetSize(spec.size, spec.size)
	button:SetNormalTexture(spec.texture.normal)
	button:SetPushedTexture(spec.texture.pushed)
	button:SetDisabledTexture(spec.texture.normal)
	button:SetHighlightTexture(spec.texture.lit)
	button:GetHighlightTexture():SetBlendMode("BLEND")
	button:GetDisabledTexture():SetDesaturated(true)
	for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
		texture:SetTexCoord(unpack(spec.texcoords))
		texture:ClearAllPoints()
		texture:SetAllPoints()
	end
end

-- A dropdown (UIDropDownMenuTemplate's, or one drawn like it) in Diablo III's
-- dropdown plate, its own art out of sight; `offset` moves the plate up where its
-- text sits above its frame's middle, `inset` is how far in from its sides
-- the plate's art is drawn (the template's own by default).
Module.StyleDropDown = function(self, frame, offset, inset)
	local name = frame:GetName()
	-- as wide as its art first: one never sized (Auctionator's,
	-- Overachiever's) is narrower, its art reaching past it
	local middle = name and _G[name .. "Middle"]
	if middle and (frame:GetWidth() < middle:GetWidth()) then
		_G.UIDropDownMenu_SetWidth(frame, middle:GetWidth())
	end
	for _, part in ipairs({ "Left", "Middle", "Right" }) do
		local region = name and _G[name .. part]
		if region then
			region:SetAlpha(0)
		end
	end
	local spec = config.dropdown
	frame.DiabolicInset = inset
	frame.DiabolicDropDown = true
	local plate = CreateFrame("Frame", nil, frame)
	plate:SetPoint("LEFT", 0, offset or 0)
	plate:SetPoint("RIGHT", 0, offset or 0)
	plate:SetHeight(spec.height)
	self:CreateSlices(plate, "BACKGROUND", spec.plate, spec.plate.texture, spec.height, inset or spec.inset, frame)
	frame.DiabolicPlate = plate -- (raised with it: LineBand)
	-- its button Diablo III's, in the plate's right end, in its middle
	local button = name and _G[name .. "Button"]
	if button then
		local arrow = spec.arrow
		button:SetSize(spec.arrow_size, spec.arrow_size)
		button:ClearAllPoints()
		button:SetPoint("RIGHT", plate, "RIGHT", -(inset or spec.inset) - spec.arrow_gap, 0)
		button:SetNormalTexture(arrow.normal)
		button:SetPushedTexture(arrow.pushed)
		button:SetDisabledTexture(arrow.normal)
		button:SetHighlightTexture(arrow.lit)
		button:GetHighlightTexture():SetBlendMode("BLEND")
		button:GetDisabledTexture():SetDesaturated(true)
		for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
			texture:SetTexCoord(unpack(spec.arrow_texcoords))
			texture:ClearAllPoints()
			texture:SetAllPoints()
		end
		-- its text from the plate's left, up to the arrow (Blizzard's
		-- reaches under it, right-aligned)
		local text = _G[name .. "Text"]
		if text then
			text:ClearAllPoints()
			text:SetPoint("LEFT", plate, "LEFT", (inset or spec.inset) + spec.text_padding, 0)
			text:SetPoint("RIGHT", button, "LEFT", -spec.arrow_gap, 0)
			text:SetJustifyH("LEFT")
		end
	end
end

-- An edit box (InputBoxTemplate's, or drawn like it: a search) on the
-- dropdowns' plate of Diablo III's, its own art out of sight; the plate
-- `edit_padding` past its sides, around its text.
Module.StyleEditBox = function(self, box)
	local name = box:GetName()
	for _, part in ipairs({ "Left", "Middle", "Right" }) do
		local region = name and _G[name .. part]
		if region then
			region:SetAlpha(0)
		end
	end
	local spec = config.dropdown
	box.DiabolicOutset = config.edit_padding
	local plate = CreateFrame("Frame", nil, box)
	plate:SetPoint("LEFT", -config.edit_padding, 0)
	plate:SetPoint("RIGHT", config.edit_padding, 0)
	plate:SetHeight(spec.height)
	return self:CreateSlices(plate, "BACKGROUND", spec.plate, spec.plate.texture, spec.height, 0, box)
end

-- A checkbox (OptionsCheckButtonTemplate's) as Diablo III's: its dark box
-- in a bronze frame, the frame lit under the mouse, its orange X checked;
-- its label (Blizzard's "Text") right of it in the title's gold; its size
-- and its label's font `look`'s (check_box.stacked) if not check_box's.
Module.StyleCheckBox = function(self, button, look)
	local spec = config.check_box
	look = look or spec
	button:SetSize(look.size, look.size)
	button:SetNormalTexture(spec.texture)
	button:SetPushedTexture(spec.texture)
	button:SetHighlightTexture(spec.texture)
	button:SetCheckedTexture(spec.texture)
	button:SetDisabledCheckedTexture(spec.texture)
	button:GetNormalTexture():SetTexCoord(unpack(spec.box))
	local pushed = button:GetPushedTexture()
	pushed:SetTexCoord(unpack(spec.box))
	pushed:SetVertexColor(unpack(spec.pushed_color))
	local lit = button:GetHighlightTexture()
	lit:SetTexCoord(unpack(spec.lit))
	lit:SetBlendMode("ADD")
	button:GetCheckedTexture():SetTexCoord(unpack(spec.checked))
	local disabled = button:GetDisabledCheckedTexture()
	disabled:SetTexCoord(unpack(spec.checked))
	disabled:SetDesaturated(true)
	local label = _G[button:GetName() .. "Text"]
	button.DiabolicLabel = label
	if label then
		label:SetFontObject(look.font)
		label:SetTextColor(unpack(config.title_plate.color))
		label:SetShadowOffset(1, -1)
		label:ClearAllPoints()
		label:SetPoint("LEFT", button, "RIGHT", spec.label_gap, 0)
	end
end

-- How far in from a band control's sides its art is drawn (a dropdown's
-- plate), negative out past them (an edit box's plate, a checkbox's
-- label): left, right.
local ArtInsets = function(part)
	local name = part:GetName()
	if name and _G[name .. "Button"] and _G[name .. "Middle"] then
		local inset = part.DiabolicInset or config.dropdown.inset
		return inset, inset
	elseif part.DiabolicOutset then
		return -part.DiabolicOutset, -part.DiabolicOutset
	elseif part.DiabolicLabel then
		return 0, -(config.check_box.label_gap + part.DiabolicLabel:GetStringWidth())
	end
	return 0, 0
end
Module.ArtInsets = ArtInsets

-- `parts` (controls, texts) in a row along `header`'s band from its left:
-- the first from its end, their art
-- window.layout.band_gap apart, each placed on the one before it (moved
-- as it's resized); `fromRight`: from its right end instead (short of the
-- X's socket), the last part rightmost. Dropdowns over the window's frame.
Module.LineBand = function(self, header, parts, fromRight)
	local layout = config.layout
	local level = header:GetParent():GetFrameLevel() + 4
	local previous, previousInset
	for i = fromRight and #parts or 1, fromRight and 1 or #parts, fromRight and -1 or 1 do
		local part = parts[i]
		if part:IsObjectType("FontString") then
			part:SetWidth(0) -- (as wide as its text)
		end
		local left, right = ArtInsets(part)
		part:ClearAllPoints()
		if fromRight and previous then
			part:SetPoint("RIGHT", previous, "LEFT", previousInset - layout.band_gap + right, 0)
		elseif fromRight then
			part:SetPoint("RIGHT", header, "RIGHT", right - layout.band_right_edge, 0)
		elseif previous then
			part:SetPoint("LEFT", previous, "RIGHT", layout.band_gap - previousInset - left, 0)
		else
			part:SetPoint("LEFT", header, "LEFT", layout.band_edge - left, 0)
		end
		previous, previousInset = part, fromRight and left or right
		local name = part:GetName()
		if name and _G[name .. "Button"] and _G[name .. "Middle"] then
			-- (its plate first, under it: a child keeps its own level)
			for _, piece in ipairs({ part.DiabolicPlate or false, part, _G[name .. "Button"], _G[name .. "MouseOver"] or false }) do
				if piece then
					piece:SetFrameLevel(level)
					level = level + 1
				end
			end
		end
	end
end

-- A push button (UIPanelButtonTemplate's) as a flat red one, `height`
-- high: lit under the mouse, dark while disabled.
Module.StyleButton = function(self, button, height)
	for _, texture in ipairs({ button:GetNormalTexture() or false, button:GetPushedTexture() or false,
		button:GetDisabledTexture() or false, button:GetHighlightTexture() or false }) do
		if texture then
			texture:SetAlpha(0)
		end
	end
	local spec = config.rect_button
	local normal = self:CreateSlices(button, "BACKGROUND", spec, spec.texture.normal, height)
	local dark = self:CreateSlices(button, "BACKGROUND", spec, spec.texture.dark, height)
	button.DiabolicNotLit = function() return button:IsEnabled() == 0 end
	self:AddLit(button, self:CreateSlices(button, "BORDER", spec, spec.texture.lit, height))
	local update = function()
		if (button:IsEnabled() == 0) then
			normal:Hide()
			dark:Show()
		else
			normal:Show()
			dark:Hide()
		end
		UpdateLit(button)
		-- its text grey while disabled, back to its own color once enabled
		-- (a color set on the text stays until another is)
		local text = button:GetFontString()
		if text then
			text:SetTextColor(unpack((button:IsEnabled() == 0) and config.button_disabled_color or config.button_text_color))
		end
	end
	hooksecurefunc(button, "Enable", update)
	hooksecurefunc(button, "Disable", update)
	self:SetButtonFont(button, config.button_font)
	update()
end

-- `frame`'s own close button, an unnamed child (Blizzard's panel close).
Module.FindClose = function(self, frame)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		local texture = child:IsObjectType("Button") and child:GetNormalTexture()
		local file = texture and texture:GetTexture()
		if file and file:lower():find("ui%-panel%-minimizebutton") then
			return child
		end
	end
end

-- Page buttons (back, on) as the scroll bars' arrows, turned to point
-- left and right.
Module.StylePager = function(self, prev, nextPage)
	local spec = config.scrollbar
	local left, right, top, bottom = unpack(spec.arrow_texcoords)
	for button, art in pairs({ [prev] = spec.up, [nextPage] = spec.down }) do
		button:SetSize(config.pager_size, config.pager_size)
		button:SetNormalTexture(art.normal)
		button:SetPushedTexture(art.lit)
		button:SetDisabledTexture(art.disabled)
		button:SetHighlightTexture(art.lit)
		button:GetHighlightTexture():SetBlendMode("BLEND")
		for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
			-- (a quarter turn: the art's top on the left)
			texture:SetTexCoord(right, top, left, top, right, bottom, left, bottom)
			texture:ClearAllPoints()
			texture:SetAllPoints()
		end
	end
end

-- `font` in all of a button's states.
Module.SetButtonFont = function(self, button, font)
	button:SetNormalFontObject(font)
	button:SetHighlightFontObject(font)
	button:SetDisabledFontObject(font)
	if (button:IsEnabled() == 0) and button:GetFontString() then
		button:GetFontString():SetTextColor(unpack(config.button_disabled_color))
	end
end

-- The action buttons' border (made for 44px ones) around a `size` button.
Module.AddBorder = function(self, button, size)
	local spec = config.button_border
	local scale = size / 44
	local border = button:CreateTexture(nil, "OVERLAY")
	border:SetTexture(spec.texture)
	border:SetSize(spec.size[1] * scale, spec.size[2] * scale)
	border:SetPoint("TOPLEFT", spec.offset[1] * scale, spec.offset[2] * scale)
	return border
end

-- Where Blizzard places `frame` as a panel and how wide it is to the next
-- one, our window (`insets` past it) included: `x`, `y` move it.
Module.SetPanelLayout = function(self, frame, insets, x, y)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + insets[3])
	if x then
		frame:SetAttribute("UIPanelLayout-xoffset", x)
	end
	if y then
		frame:SetAttribute("UIPanelLayout-yoffset", y)
	end
end

-- The textures whose file matches one of `patterns` (lowercase, as
-- patterns), on `frame` and all it holds, out of sight through their
-- alpha (Blizzard sets their files again, never that).
Module.HideArt = function(self, frame, patterns)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		local file = region:IsObjectType("Texture") and region:GetTexture()
		if file then
			file = file:lower()
			for _, pattern in ipairs(patterns) do
				if file:find(pattern) then
					region:SetAlpha(0)
					break
				end
			end
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		self:HideArt((select(i, frame:GetChildren())), patterns)
	end
end

-- Blizzard's push buttons in `frame` and all it holds as ours, at their
-- own height; each once. UIPanelButtonTemplate's art is the button's,
-- UIPanelButtonTemplate2's three named textures.
local IsPanelButton = function(button)
	local name = button:GetName()
	local texture = button:GetNormalTexture() or (name and _G[name .. "Left"])
	local file = texture and texture.GetTexture and texture:GetTexture()
	return file and file:lower():find("ui%-panel%-button")
end

local CollectButtons
CollectButtons = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsObjectType("Button") and (not child.DiabolicStyled) and IsPanelButton(child) then
			found[#found + 1] = child
		end
		CollectButtons(child, found)
	end
	return found
end

-- An edit box's label (`text`) pale in it while it's empty and not typed
-- in (window.hint's look).
Module.AddHint = function(self, box, text)
	local spec = config.hint
	local hint = box:CreateFontString(nil, "OVERLAY")
	hint:SetFontObject(spec.font)
	hint:SetTextColor(unpack(spec.color))
	hint:SetPoint("LEFT", box, "LEFT", spec.inset, 0)
	hint:SetText(text)
	local Update = function()
		if (box:GetText() == "") and (not box.DiabolicFocused) then
			hint:Show()
		else
			hint:Hide()
		end
	end
	box:HookScript("OnEditFocusGained", function() box.DiabolicFocused = true Update() end)
	box:HookScript("OnEditFocusLost", function() box.DiabolicFocused = nil Update() end)
	box:HookScript("OnTextChanged", Update)
	Update()
	return hint
end

-- Whether every button's text fits in it (Blizzard sized them for its own
-- font).
local AllFit = function(buttons)
	for _, button in ipairs(buttons) do
		if (button:GetTextWidth() > button:GetWidth() - config.button_text_margin * 2) then
			return false
		end
	end
	return true
end

-- A scroll bar (UIPanelScrollBarTemplate's, HybridScrollBarTemplate's) as
-- Diablo III's: a black track in a thin bronze line, its arrows and its
-- thumb (three grips) in red, lit under the mouse; each once.
Module.StyleScrollBar = function(self, bar)
	local name = bar:GetName()
	local up, down = name and _G[name .. "ScrollUpButton"], name and _G[name .. "ScrollDownButton"]
	if bar.DiabolicStyled or not (up and down) then
		return
	end
	bar.DiabolicStyled = true
	local spec = config.scrollbar
	-- its own track (the hybrid ones have one, the light ones an edge)
	local thumb = bar:GetThumbTexture()
	for i = 1, select("#", bar:GetRegions()) do
		local region = select(i, bar:GetRegions())
		if region:IsObjectType("Texture") and (region ~= thumb) then
			region:SetAlpha(0)
		end
	end
	if bar.SetBackdrop then
		bar:SetBackdrop(nil)
	end
	for button, art in pairs({ [up] = spec.up, [down] = spec.down }) do
		button:SetSize(spec.width, spec.width)
		button:SetNormalTexture(art.normal)
		button:SetPushedTexture(art.lit)
		button:SetDisabledTexture(art.disabled)
		button:SetHighlightTexture(art.lit)
		button:GetHighlightTexture():SetBlendMode("BLEND")
		for _, texture in ipairs({ button:GetNormalTexture(), button:GetPushedTexture(), button:GetDisabledTexture(), button:GetHighlightTexture() }) do
			texture:SetTexCoord(unpack(spec.arrow_texcoords))
			texture:ClearAllPoints()
			texture:SetAllPoints()
		end
	end
	thumb:SetTexture(spec.thumb)
	thumb:SetTexCoord(unpack(spec.thumb_texcoords))
	thumb:SetSize(spec.width, spec.thumb_height)
	-- the track from the up arrow's top to the down arrow's bottom, the
	-- line just outside it
	local track = CreateFrame("Frame", nil, bar)
	track:SetFrameLevel(math_max(bar:GetFrameLevel() - 1, 0))
	track:SetPoint("TOP", up, "TOP", 0, spec.line)
	track:SetPoint("BOTTOM", down, "BOTTOM", 0, -spec.line)
	track:SetWidth(spec.width + spec.line * 2)
	track:SetBackdrop({ bgFile = spec.blank, edgeFile = spec.blank, edgeSize = spec.line, insets = { left = spec.line, right = spec.line, top = spec.line, bottom = spec.line } })
	track:SetBackdropColor(unpack(spec.track_color))
	track:SetBackdropBorderColor(unpack(spec.line_color))
end

-- The scroll bars in `frame` and all it holds as ours.
Module.StyleScrollBars = function(self, frame)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsObjectType("Slider") then
			self:StyleScrollBar(child)
		end
		self:StyleScrollBars(child)
	end
end

-- A part's scale on screen (a texture's or a text's: its frame's, as
-- 3.3.5's regions have none of their own).
local ScaleOf = function(part)
	return (part.GetEffectiveScale and part or part:GetParent()):GetEffectiveScale()
end
Module.ScaleOf = ScaleOf

-- A part's sides on screen (in the screen's units, whatever its scale):
-- left, bottom, right, top.
local Edges = function(part)
	local left, bottom, width, height = part:GetRect()
	if not left then
		return
	end
	local scale = ScaleOf(part)
	return left * scale, bottom * scale, (left + width) * scale, (bottom + height) * scale
end
Module.Edges = Edges

-- Our buttons shown in `frame` and all it holds (not those out of sight,
-- nor our other parts: dropdowns, edit boxes).
local CollectShown
CollectShown = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsVisible() then
			if child.DiabolicStyled and child:IsObjectType("Button") and (child:GetAlpha() > 0) and child:GetLeft() then
				found[#found + 1] = child
			end
			CollectShown(child, found)
		end
	end
	return found
end
Module.CollectShown = CollectShown

local ByLeft = function(a, b)
	return (Edges(a)) < (Edges(b))
end

-- `buttons` (a row's, left to right) too close: as wide in all, each as
-- much narrower, window.layout.button_gap apart, each placed on its own
-- from `frame`'s nearer corner (Blizzard chains them either way round).
local Spread = function(frame, buttons)
	for _, button in ipairs(buttons) do
		if button:IsProtected() and InCombatLockdown() then
			return
		end
	end
	local scale = buttons[1]:GetEffectiveScale()
	local gap = config.layout.button_gap * scale
	local left = Edges(buttons[1])
	local _, _, right = Edges(buttons[#buttons])
	local widths = 0
	for _, button in ipairs(buttons) do
		widths = widths + button:GetWidth() * scale
	end
	local fit = (right - left - gap * (#buttons - 1)) / widths
	if (fit <= 0) then
		return
	end
	local frameLeft, frameBottom, frameRight, frameTop = Edges(frame)
	local _, bottom, _, top = Edges(buttons[1])
	local side = ((left + right) / 2 < (frameLeft + frameRight) / 2) and "LEFT" or "RIGHT"
	local edge = ((bottom + top) / 2 < (frameBottom + frameTop) / 2) and "BOTTOM" or "TOP"
	local x = left
	for _, button in ipairs(buttons) do
		local width = button:GetWidth() * scale * fit
		local _, buttonBottom, _, buttonTop = Edges(button)
		local dx = (side == "LEFT") and (x - frameLeft) or (x + width - frameRight)
		local dy = (edge == "BOTTOM") and (buttonBottom - frameBottom) or (buttonTop - frameTop)
		button:SetWidth(width / scale)
		button:ClearAllPoints()
		button:SetPoint(edge .. side, frame, edge .. side, dx / scale, dy / scale)
		x = x + width + gap
	end
end

-- The rule for buttons on a row: our buttons shown in `frame` whose
-- middles are level and that touch or nearly (closer than
-- window.layout.button_gap, but not one over another) spread apart.
local LineRows = function(frame)
	local wanted = config.layout.button_gap
	local buttons = CollectShown(frame, {})
	table_sort(buttons, ByLeft)
	local taken = {}
	for i, first in ipairs(buttons) do
		if not taken[first] then
			local _, bottom, _, top = Edges(first)
			local row = { first }
			for j = i + 1, #buttons do
				local other = buttons[j]
				local _, otherBottom, _, otherTop = Edges(other)
				if (not taken[other]) and (math_abs((otherBottom + otherTop - bottom - top) / 2) <= 2) then
					row[#row + 1] = other
					taken[other] = true
				end
			end
			local close = { first }
			for k = 2, #row + 1 do
				local before, button = row[k - 1], row[k]
				local apart
				if button then
					local _, _, beforeRight = Edges(before)
					apart = ((Edges(button)) - beforeRight) / button:GetEffectiveScale()
				end
				if apart and (apart < wanted - .5) and (apart > -math_min(before:GetWidth(), button:GetWidth()) / 2) then
					close[#close + 1] = button
				else
					if (#close > 1) then
						Spread(frame, close)
					end
					close = { button }
				end
			end
		end
	end
end

-- Frames whose rows are lined up on the next frame drawn (once Blizzard
-- has placed what it shows).
local Queued = {}
local Liner -- (OnInit)
local QueueRows = function(frame)
	Queued[frame] = true
	if Liner then
		Liner:Show()
	end
end

-- The buttons (and the scroll bars, theirs too) of `frame` and all it
-- holds; their rows lined up (LineRows) as they show.
Module.StyleButtons = function(self, frame)
	self:StyleScrollBars(frame)
	local buttons = CollectButtons(frame, {})
	QueueRows(frame)
	for _, button in ipairs(buttons) do
		button.DiabolicStyled = true
		button:HookScript("OnShow", function() QueueRows(frame) end)
		local name = button:GetName()
		for _, part in ipairs({ "Left", "Middle", "Right" }) do
			local region = name and _G[name .. part]
			if region and region.SetAlpha then
				region:SetAlpha(0)
			end
		end
		self:StyleButton(button, button:GetHeight())
	end
	-- one font for them all, the first in which every text fits: a row of
	-- them reads as one
	for _, font in ipairs({ config.button_font_small, config.button_font_narrow }) do
		if AllFit(buttons) then
			break
		end
		for _, button in ipairs(buttons) do
			self:SetButtonFont(button, font)
		end
	end
end

-- A darker panel behind `frame` (a list's scroll frame), `insets` (left,
-- top, right, bottom) past it, under what its parent (`parent`, its own
-- by default) shows.
Module.AddPanel = function(self, frame, insets, parent)
	parent = parent or frame:GetParent()
	local panel = CreateFrame("Frame", nil, parent)
	panel:SetFrameLevel(parent:GetFrameLevel())
	panel:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	panel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	self:StylePanel(panel)
	panel.DiabolicContent = true
	return panel
end

-- A material's slices' texture coordinates for `frame`'s size: its
-- middle at one scale both ways, as much of it as covers the frame, cut
-- evenly off the long way (its emboss in the middle, unstretched); its
-- edges cut to match.
local FitNine = function(frame, slices, spec)
	local width, height = unpack(spec.size)
	local edge = spec.border * (spec.scale or config.material_scale)
	local shownWidth, shownHeight = frame:GetWidth() - 2 * edge, frame:GetHeight() - 2 * edge
	if (shownWidth <= 0) or (shownHeight <= 0) then
		return
	end
	local artWidth, artHeight = width - 2 * spec.border, height - 2 * spec.border
	local scale = math_max(shownWidth / artWidth, shownHeight / artHeight)
	local u, v = spec.border / width, spec.border / height
	-- the middle's span: what's shown of it, centred
	local cutU = (1 - 2 * u) * (1 - shownWidth / scale / artWidth) / 2
	local cutV = (1 - 2 * v) * (1 - shownHeight / scale / artHeight) / 2
	local columns = { { 0, u }, { u + cutU, 1 - u - cutU }, { 1 - u, 1 } }
	local rows = { { 0, v }, { v + cutV, 1 - v - cutV }, { 1 - v, 1 } }
	for i, slice in ipairs(slices) do
		local column, row = columns[(i - 1) % 3 + 1], rows[math_floor((i - 1) / 3) + 1]
		slice:SetTexCoord(column[1], column[2], row[1], row[2])
	end
end

-- One of Diablo III's materials (window.materials') over all of `frame`
-- in nine slices of its file: its corners and edges at their own size
-- (`border` of its art's pixels, at its own scale or the materials'), its middle
-- fit to the frame (FitNine); drawn by `owner` when it's another frame
-- than `frame`. Its slices returned.
Module.CreateNine = function(self, frame, layer, material, owner)
	local spec = config.materials[material]
	local edge = spec.border * (spec.scale or config.material_scale)
	-- each column: its left and right sides as the frame's side and an
	-- offset; each row the same, top and bottom
	local columns = {
		{ "LEFT", 0, "LEFT", edge },
		{ "LEFT", edge, "RIGHT", -edge },
		{ "RIGHT", -edge, "RIGHT", 0 }
	}
	local rows = {
		{ "TOP", 0, "TOP", -edge },
		{ "TOP", -edge, "BOTTOM", edge },
		{ "BOTTOM", edge, "BOTTOM", 0 }
	}
	local slices = setmetatable({}, Slices)
	for _, row in ipairs(rows) do
		for _, column in ipairs(columns) do
			local slice = (owner or frame):CreateTexture(nil, layer)
			slice:SetPoint("TOPLEFT", frame, row[1] .. column[1], column[2], row[2])
			slice:SetPoint("BOTTOMRIGHT", frame, row[3] .. column[3], column[4], row[4])
			slices[#slices + 1] = slice
		end
	end
	slices:SetTexture(spec.texture)
	local fit = function() FitNine(frame, slices, spec) end
	frame:HookScript("OnSizeChanged", fit)
	fit()
	return slices
end

-- A zone of one of Diablo III's materials (window.materials': parchment
-- to read, slate or leather for lists...) behind `frame`, `insets` (left,
-- top, right, bottom) past it, under what its parent (`parent`, its own by
-- default) shows.
Module.AddZone = function(self, frame, material, insets, parent)
	parent = parent or frame:GetParent()
	local zone = CreateFrame("Frame", nil, parent)
	zone:SetFrameLevel(parent:GetFrameLevel())
	zone:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	zone:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	zone.Material = self:CreateNine(zone, "BACKGROUND", material)
	zone.DiabolicContent = true
	zone.DiabolicMaterial = material
	return zone
end

-- A bar of the window's iron (its frame's left edge, turned: the part
-- footer_rail cuts, the bar and its shadows), drawn by `owner`.
local IronBar = function(owner)
	local spec, size = config.footer_rail, config.backdrop.edgeSize
	local outer, inner = spec.cut[1] / size / 8, spec.cut[2] / size / 8
	local bar = owner:CreateTexture(nil, "OVERLAY")
	bar:SetTexture(config.backdrop.edgeFile)
	bar:SetTexCoord(outer, 0, inner, 0, outer, 1, inner, 1)
	bar:SetHeight(spec.cut[2] - spec.cut[1])
	return bar
end

-- A bar of the window's iron across `window` between two of its zones,
-- its middle `y` under the window's top, its ends under the frame's
-- sides (as the foot's): over what the window shows, under its frame.
Module.AddIronBar = function(self, window, y)
	local spec = config.footer_rail
	local holder = CreateFrame("Frame", nil, window)
	holder:SetFrameLevel(window:GetFrameLevel() + 2)
	holder:SetAllPoints()
	local bar = IronBar(holder)
	local top = y - ((spec.bar[1] + spec.bar[2]) / 2 - spec.cut[1]) -- (the bar's middle in its cut)
	bar:SetPoint("TOPLEFT", window, "TOPLEFT", spec.bar[1], -top)
	bar:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.bar[1], -top)
	return bar
end

-- The window's foot in Diablo III's rough stone, inside its iron frame,
-- up to `top` (see SetFooter), under the buttons and the money Blizzard
-- keeps there: drawn by the window over its painting, set apart from the
-- content by a bar of the frame's iron along its top (the frame's left
-- edge turned), its ends under the frame's sides.
Module.AddFooter = function(self, window, top)
	local foot = CreateFrame("Frame", nil, window)
	foot.Window = window
	foot.Material = self:CreateNine(foot, "ARTWORK", "footer", window)
	local spec = config.footer_rail
	local rail = IronBar(foot)
	local x, y = spec.bar[1] - config.backdrop.insets.left, spec.cut[2] - spec.bar[2]
	rail:SetPoint("BOTTOMLEFT", foot, "TOPLEFT", x, -y)
	rail:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", -x, -y)
	foot.Rail = rail
	window.DiabolicFoot = foot
	self:SetFooter(foot, top)
	return foot
end

-- How far over the top of a foot's highest button its iron bar reaches
-- (window.footer_margin, then the bar over the foot's top): what's over
-- the foot is placed from there.
Module.FootReach = function(self)
	return config.footer_margin + config.footer_rail.bar[2] - config.footer_rail.cut[1]
end

-- A footer up to the page shown's buttons: `top`, the name of the highest
-- (window.footer_margin over its top), or { that name, how much higher };
-- none on a page left without one.
Module.SetFooter = function(self, foot, top)
	local raise = 0
	if type(top) == "table" then
		top, raise = top[1], top[2]
	end
	local part = top and _G[top]
	foot.DiabolicShown = part and true -- (the slices can't say)
	if (not part) then
		foot.Material:Hide()
		foot.Rail:Hide()
		return
	end
	local insets = config.backdrop.insets
	foot:ClearAllPoints()
	foot:SetPoint("BOTTOMLEFT", foot.Window, "BOTTOMLEFT", insets.left, insets.bottom)
	foot:SetPoint("BOTTOMRIGHT", foot.Window, "BOTTOMRIGHT", -insets.right, insets.bottom)
	-- (its top only: its sides are the window's)
	foot:SetPoint("TOP", part, "TOP", 0, config.footer_margin + raise)
	foot.Material:Show()
	foot.Rail:Show()
end

-- `texture` (a list's highlight on its chosen row) as Diablo III's copper
-- bar, in its own colours: Blizzard tints it by the row's kind. Its blend
-- kept: an added one (the quest log's) lies over the row's text.
Module.LightRow = function(self, texture)
	LitRows[#LitRows + 1] = texture
	texture:SetTexture(config.row_bars.lit)
	texture:SetTexCoord(0, 1, 0, 1)
	texture:SetVertexColor(1, 1, 1)
	local busy
	hooksecurefunc(texture, "SetVertexColor", function()
		if (not busy) then
			busy = true
			texture:SetVertexColor(1, 1, 1)
			busy = nil
		end
	end)
end

-- A page of Diablo III's parchment (`material`, its tall page if left out)
-- under `frame` (a scroll frame of text drawn for parchment), `insets`
-- (left, top, right, bottom) around it, on a frame of its own at its level
-- (over a panel around it, under its text), carried with it (Blizzard
-- moves the quest log's details between windows), or by `parent` (a
-- list's scroll frame, which Blizzard hides when it all fits).
Module.AddParchment = function(self, frame, insets, material, parent)
	insets = insets or config.parchment_insets
	local holder = CreateFrame("Frame", nil, parent or frame)
	holder:SetFrameLevel(frame:GetFrameLevel())
	holder:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	holder:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	holder.DiabolicContent = true
	holder.DiabolicMaterial = material or "page"
	return self:CreateNine(holder, "BACKGROUND", material or "page")
end

-- A parchment's scroll bar (UIPanelScrollFrameTemplate's) out past its
-- pages' edges, or `x` from its text's right.
Module.PlaceParchmentBar = function(self, frame, x)
	local bar = _G[frame:GetName() .. "ScrollBar"]
	if bar then
		x = x or config.parchment_bar_x
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", frame, "TOPRIGHT", x, -16)
		bar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", x, 16)
	end
end

-- The textures of a frame's own (not its children's), out of sight.
Module.HideTextures = function(self, frame)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") then
			region:SetAlpha(0)
		end
	end
end

-- The coin icons Blizzard draws from its money icons (money inputs'), in
-- `frame` and all it holds, ours.
local COINS = { [0] = "gold", [.25] = "silver", [.5] = "copper" }
Module.StyleCoins = function(self, frame)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		local file = region:IsObjectType("Texture") and region:GetTexture()
		local kind = file and file:lower():find("ui%-moneyicons") and COINS[(region:GetTexCoord())]
		if kind then
			local coin = Engine:GetDB("UI").coin
			region:SetTexture(coin[kind .. "_texture"])
			region:SetTexCoord(unpack(coin[kind .. "_texcoord"]))
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		self:StyleCoins((select(i, frame:GetChildren())))
	end
end

-- Whether Blizzard's windows get Diablo III's look (the options' Reskin
-- Windows): the skins check it before styling anything.
Module.IsSkinning = function(self)
	return self.db.enableSkin
end

Module.OnInit = function(self)
	config = self:GetDB("Blizzard").window
	self.config = config
	BannerIndex = {}
	for i, name in ipairs(config.banner.sigil_names) do
		BannerIndex[name] = i
	end
	self.db = self:GetConfig("Windows")
	-- Blizzard's own windows (and their tabs and coins) when it's off
	if (not self.db.enableSkin) then
		return
	end
	Liner = CreateFrame("Frame")
	Liner:Hide()
	Liner:SetScript("OnUpdate", function()
		Liner:Hide()
		for frame in pairs(Queued) do
			Queued[frame] = nil
			if frame:IsVisible() then
				LineRows(frame)
			end
		end
	end)
	hooksecurefunc("PanelTemplates_SelectTab", UpdateTab)
	hooksecurefunc("PanelTemplates_DeselectTab", UpdateTab)
	hooksecurefunc("PanelTemplates_TabResize", FitTab)
	-- every money frame's coins ours (Blizzard makes them on its first update)
	local coin = Engine:GetDB("UI").coin
	hooksecurefunc("MoneyFrame_Update", function(frame)
		-- (an unnamed one, Immersion's: no coins of its name)
		local name = frame
		if (type(frame) == "table") then
			name = frame:GetName()
		end
		for _, kind in ipairs({ "gold", "silver", "copper" }) do
			local button = name and _G[name .. kind:gsub("^%l", string_upper) .. "Button"]
			local texture = button and button:GetNormalTexture()
			if texture then
				texture:SetTexture(coin[kind .. "_texture"])
				texture:SetTexCoord(unpack(coin[kind .. "_texcoord"]))
			end
		end
	end)
end
