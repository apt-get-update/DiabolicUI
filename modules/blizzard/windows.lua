-- Diablo III's window, in parts the Blizzard window skins put together
-- (achievements.lua, character.lua, spellbook.lua and the others): the
-- stone window in its iron frame, a red stained-glass band along its top
-- with the title in a plate on its top edge, a stone cartouche for a key
-- number, darker panels, section title bars, flat red buttons and tabs,
-- the windows' own tabs as banners hanging from their foot, and spiked
-- bars; a cover of the same stone for another page over one.
-- Buttons and bars are cut in three so their ends keep their shape at any
-- width.
-- The kit's other files: windows-tabs.lua, windows-controls.lua, windows-buttons.lua
-- and windows-zones.lua.
-- Settings in settings/blizzard.lua (window).
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Windows")

-- Lua API
local _G = _G
local ipairs = ipairs
local table_insert = table.insert
local table_remove = table.remove
local math_abs = math.abs
local math_ceil = math.ceil
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local rawget = rawget
local select = select
local setmetatable = setmetatable
local string_upper = string.upper
local type = type
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local config
local Windows = {} -- every window made, its Blizzard frame its .Frame (/dui layout saves them)
Module.Windows = Windows
local LitRows = {} -- every chosen row's light (LightRow; /dui layout reads text on it)
Module.LitRows = LitRows

-- A texture's colors from one end to the other (SetGradientAlpha's), kept
-- on it: the game can't say them back, /dui layout saves them for the
-- editor out of the game to draw.
local Gradient = function(texture, orientation, ...)
	texture:SetGradientAlpha(orientation, ...)
	texture.DiabolicGradient = { orientation, ... }
end
Module.Gradient = Gradient

-- A name for a part we make for `owner`: its name and `suffix` (a number
-- after them if that's taken), so /dui layout lists it and
-- settings/positions.lua can place it. None if `owner` has none.
local NameFor = function(owner, suffix)
	local base = owner and owner:GetName()
	if not base then
		return nil
	end
	local name, count = base .. suffix, 1
	while rawget(_G, name) do
		count = count + 1
		name = base .. suffix .. count
	end
	return name
end
Module.NameFor = NameFor

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
			tile:SetTexCoord(
				(x0 - column * size) / size,
				(x1 - column * size) / size,
				(y0 - row * size) / size,
				(y1 - row * size) / size
			)
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
	if aspect > art then
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

-- The glyph only where the window holds all of it (a small one, the loot
-- preview's, would have it hanging out below).
local FitWatermark = function(window)
	local spec, mark = config.watermark, window.DiabolicWatermark
	local x, y = spec.position[2], spec.position[3]
	if (window:GetWidth() >= spec.size + math_abs(x)) and (window:GetHeight() >= spec.size + math_abs(y)) then
		mark:Show()
	else
		mark:Hide()
	end
end

-- One pale glyph in `window`'s corner, a different one by its name.
local AddWatermark = function(window)
	local spec = config.watermark
	local name, sum = window:GetName() or "", 0
	for i = 1, #name do
		sum = sum + name:byte(i)
	end
	local glyph, width, height = sum % spec.count, spec.glyph_size[1], spec.glyph_size[2]
	local mark = window:CreateTexture(nil, "ARTWORK")
	mark:SetTexture(spec.texture)
	mark:SetTexCoord(glyph * width, (glyph + 1) * width, spec.row * height, (spec.row + 1) * height)
	mark:SetSize(spec.size, spec.size)
	mark:SetPoint(unpack(spec.position))
	mark:SetAlpha(spec.alpha)
	window.DiabolicWatermark = mark
	window:HookScript("OnSizeChanged", FitWatermark)
	window:HookScript("OnShow", FitWatermark)
	FitWatermark(window)
end

-- The window behind `frame`, from its corners by `insets` (left, top,
-- right, bottom; positive outward), under its children: its stone our
-- tiles, its iron frame a backdrop over the title bar's band, so the band
-- sits inside it (Diablo III's).
Module.CreateWindow = function(self, frame, insets)
	local window = CreateFrame("Frame", NameFor(frame, "Diabolic"), frame)
	window:SetFrameLevel(frame:GetFrameLevel())
	window:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	window:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	-- over the band (+1), under the close button's socket (+4)
	local border = CreateFrame("Frame", NameFor(window, "Border"), window)
	border:SetFrameLevel(window:GetFrameLevel() + 3)
	border:SetBackdrop({
		edgeFile = config.backdrop.edgeFile,
		edgeSize = config.backdrop.edgeSize,
		insets = config.backdrop.insets,
	})
	border:SetBackdropBorderColor(unpack(config.backdrop_border_color))
	window.Border = border
	PlaceBorder(window)
	window.DiabolicStone = {}
	window.DiabolicHeaders, window.DiabolicCovers = {}, {}
	window:SetScript("OnSizeChanged", LayoutStone)
	window:HookScript("OnShow", LayoutStone) -- (its size may have come with no change told)
	LayoutStone(window)
	AddWatermark(window)
	window.Frame = frame
	Windows[#Windows + 1] = window
	Engine:GetModule("Blizzard: Adjust"):PlaceWaiting()
	return window
end

-- A part of `window`'s stone over what it shows, `insets` (left, top,
-- right, bottom) in from its corners, `level` frames up: another page in
-- the same place, over the one under it without touching it (Blizzard's
-- secure buttons can't be hidden by us without tainting them). It takes
-- the mouse, so nothing under it is clicked.
Module.CreateCover = function(self, window, insets, level)
	local cover = CreateFrame("Frame", NameFor(window, "Cover"), window:GetParent())
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
	local header = CreateFrame("Frame", NameFor(window, "Band"), window)
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
	Engine:GetModule("Blizzard: Adjust"):PlaceWaiting()
	return header
end

-- `header`'s band dropped (a window with nothing in it): out of sight,
-- no longer its window's (its title still on the window's plate).
Module.DropBand = function(self, header)
	header:Hide()
	local headers = header:GetParent().DiabolicHeaders
	for i = #headers, 1, -1 do
		if headers[i] == header then
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
		plate = CreateFrame("Frame", NameFor(window, "TitlePlate"), window)
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
			if i % 2 == 0 then
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
	local gem = CreateFrame("Button", NameFor(plate, "Gem"), plate)
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
	local cartouche = CreateFrame("Frame", NameFor(text, "DiabolicCartouche"), header)
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
	frame.DiabolicStyle = "Section"
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
	local pane = CreateFrame("Frame", NameFor(first, "DiabolicPane"), parent)
	pane:SetFrameLevel(parent:GetFrameLevel() + (open and 1 or 0))
	pane:SetPoint("TOPLEFT", first, "TOPLEFT", -outset, outset)
	pane:SetPoint("BOTTOMRIGHT", last or first, "BOTTOMRIGHT", outset, -outset)
	self:StylePane(pane, open)
	return pane
end

-- A status bar in Diablo III's orange, in the spiked frame; its own
-- `regions` (Blizzard's frame) out of sight.
Module.StyleBar = function(self, bar, regions)
	bar.DiabolicStyle = "Bar"
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
	if not bar.DiabolicTrack then
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
	local on = (button.DiabolicLocked or button:IsMouseOver())
		and (not button.DiabolicNotLit or not button.DiabolicNotLit(button))
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
	hooksecurefunc(button, "LockHighlight", function()
		button.DiabolicLocked = true
		UpdateLit(button)
	end)
	hooksecurefunc(button, "UnlockHighlight", function()
		button.DiabolicLocked = nil
		UpdateLit(button)
	end)
end

-- What the kit's other files share (windows-tabs.lua and the others).
Module.Private = {
	NameFor = NameFor,
	Gradient = Gradient,
	Slices = Slices,
	Drop = Drop,
	UpdateLit = UpdateLit,
	PlaceBorder = PlaceBorder,
	PlaceBackground = PlaceBackground,
	LayoutStone = LayoutStone,
	PlaceHeader = PlaceHeader,
	LayoutCover = LayoutCover,
}

-- Whether Blizzard's windows get Diablo III's look (the options' Reskin
-- Windows): the skins check it before styling anything.
Module.IsSkinning = function(self)
	return self.db.enableSkin
end

Module.OnInit = function(self)
	config = self:GetDB("Blizzard").window
	self.config = config
	self:IndexBanners()
	self.db = self:GetConfig("Windows")
	-- Blizzard's own windows (and their tabs and coins) when it's off
	if not self.db.enableSkin then
		return
	end
	self:StartLiner()
	self:HookTabs()
	-- every money frame's coins ours (Blizzard makes them on its first update)
	local coin = Engine:GetDB("UI").coin
	hooksecurefunc("MoneyFrame_Update", function(frame)
		-- (an unnamed one, Immersion's: no coins of its name)
		local name = frame
		if type(frame) == "table" then
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
