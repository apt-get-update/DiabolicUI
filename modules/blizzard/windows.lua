-- Diablo III's window, in parts the Blizzard window skins put together
-- (achievements.lua, character.lua, spellbook.lua and the others): the
-- stone window in its iron frame, a red stained-glass band along its top
-- with the title in a plate on its top edge, a stone cartouche for a key
-- number, darker panels, section title bars, flat red buttons and tabs,
-- and spiked bars; a cover of the same stone for another page over one.
-- Buttons and bars are cut in three so their ends keep their shape at any
-- width.
-- Settings in settings/blizzard.lua (window).
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Windows")

-- Lua API
local _G = _G
local ipairs = ipairs
local table_insert = table.insert
local math_ceil = math.ceil
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local select = select
local setmetatable = setmetatable
local string_upper = string.upper
local type = type
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local config
local PlaceTitle -- the title in the band (defined with the header)

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

local LayoutStone = function(window)
	local insets = config.backdrop.insets
	local width = window:GetWidth() - insets.left - insets.right
	local height = window:GetHeight() - insets.top - insets.bottom
	TileStone(window, insets.left, insets.top, 0, 0, width, height)
	FitBackground(window, width, height)
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
		background:SetPoint("TOPLEFT", insets.left, -insets.top)
		background:SetPoint("BOTTOMRIGHT", -insets.right, insets.bottom)
		window.DiabolicBackground = background
	end
	background:SetTexture(spec.texture)
	background:Show()
	window.DiabolicBackgroundAspect = spec.aspect
	LayoutStone(window)
end

local LayoutCover = function(cover)
	local insets = config.backdrop.insets
	TileStone(cover, 0, 0, cover.DiabolicX - insets.left, cover.DiabolicY - insets.top, cover:GetWidth(), cover:GetHeight())
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
	border:SetAllPoints()
	border:SetBackdrop({
		edgeFile = config.backdrop.edgeFile,
		edgeSize = config.backdrop.edgeSize,
		insets = config.backdrop.insets
	})
	border:SetBackdropBorderColor(unpack(config.backdrop_border_color))
	window.Border = border
	window.DiabolicStone = {}
	window:SetScript("OnSizeChanged", LayoutStone)
	LayoutStone(window)
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
	cover.DiabolicTile = window.DiabolicTile
	cover.DiabolicStone = {}
	cover:SetScript("OnSizeChanged", LayoutCover)
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

-- The title in `header`'s band (Diablo III's): left of what's in the band's
-- middle (`header.DiabolicCenter`: the medallion, a cartouche, a status),
-- in the middle if nothing is; one line, cut short past the band's end.
-- `title` if given, else each of its titles (a window can have two: the
-- character's and its pet's).
PlaceTitle = function(header, title)
	if not title then
		for _, each in ipairs(header.DiabolicTitles or {}) do
			PlaceTitle(header, each)
		end
		return
	end
	local spec = config.band_title
	local center = header.DiabolicCenter
	-- (gone while hidden or empty: the talents' status without a second spec)
	if center and ((not center:IsVisible()) or (center.GetText and ((center:GetText() or "") == ""))) then
		center = nil
	end
	local most
	title:ClearAllPoints()
	if center then
		title:SetPoint("RIGHT", center, "LEFT", -spec.gap, 0)
		most = header:GetWidth() / 2 - center:GetWidth() / 2 - spec.gap - spec.margin
	else
		-- centred, clear of a medallion at the band's left end on both sides
		title:SetPoint("CENTER", header, "CENTER", 0, 0)
		most = header:GetWidth() - (header.DiabolicLeftRoom or spec.margin) * 2
	end
	title:SetSize(0, 0)
	if (most > 0) and (title:GetStringWidth() > most) then
		title:SetSize(most, select(2, title:GetFont()) + 2)
	end
end

-- The band's tiles across the header, each at the band's height and its
-- art's shape, the last one cut.
local LayoutBand = function(header)
	local band = config.band
	local height = header:GetHeight()
	local width = header:GetWidth()
	local size = height * band.canvas[1] / band.canvas[2]
	local tiles = header.DiabolicBand
	for _, tile in pairs(tiles) do
		tile:Hide()
	end
	if (width <= 0) or (height <= 0) then
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
	PlaceTitle(header)
end

-- The title bar along the top of `window`, `height` tall, `insets` (x, y)
-- in from its edges: the red band (the title goes in it, SetTitle). Returns
-- the band's place.
Module.CreateHeader = function(self, window, height, insets)
	local header = CreateFrame("Frame", nil, window)
	header:SetPoint("TOPLEFT", insets[1], -insets[2])
	header:SetPoint("TOPRIGHT", -insets[1], -insets[2])
	header:SetHeight(height)
	header.DiabolicBand = {}
	header:SetScript("OnSizeChanged", LayoutBand)
	LayoutBand(header)
	-- the band glowing in its middle, under the title
	local glow = header:CreateTexture(nil, "ARTWORK")
	glow:SetTexture(config.band.glow)
	glow:SetBlendMode("ADD")
	glow:SetAlpha(config.band.glow_alpha)
	glow:SetSize(height * config.band.glow_width, height)
	glow:SetPoint("CENTER")
	return header
end

-- `name`'s emblem (config.medallion's) at the left end of `header`'s
-- band, the title centred clear of it.
Module.AddMedallion = function(self, header, name)
	local spec = config.medallion
	local medallion = header:CreateTexture(nil, "OVERLAY")
	medallion:SetTexture(spec.textures[name])
	local size = header:GetHeight() + spec.grow
	medallion:SetSize(size, size)
	medallion:SetPoint("LEFT", header, "LEFT", spec.offset, 0)
	header.DiabolicLeftRoom = spec.offset + size + config.band_title.gap
	PlaceTitle(header)
	return medallion
end

-- What's in the middle of `header`'s band, the title left of it.
Module.SetBandCenter = function(self, header, region)
	header.DiabolicCenter = region
	-- the titles placed again as it shows, hides or changes, and as the
	-- window shows
	local Replace = function()
		PlaceTitle(header)
	end
	for _, part in ipairs({ region, region:GetParent() }) do
		hooksecurefunc(part, "Show", Replace)
		hooksecurefunc(part, "Hide", Replace)
	end
	if region.SetText then
		hooksecurefunc(region, "SetText", Replace)
	end
	header:HookScript("OnShow", Replace)
	PlaceTitle(header)
end

-- `title` (a font string) in the header's band, placed again each time its
-- text changes (a guild's rank and name can be long).
local Refit = function(title)
	if title:IsShown() then
		PlaceTitle(title.DiabolicHeader, title)
	end
end

Module.SetTitle = function(self, header, title)
	local spec = config.band_title
	title:SetParent(header)
	title:SetDrawLayer("OVERLAY")
	title:SetFontObject(spec.font)
	title:SetTextColor(unpack(spec.color))
	title:SetShadowOffset(1, -1)
	title:SetJustifyH("RIGHT")
	title.DiabolicHeader = header
	if not title.DiabolicFitted then
		title.DiabolicFitted = true
		header.DiabolicTitles = header.DiabolicTitles or {}
		table_insert(header.DiabolicTitles, title)
		hooksecurefunc(title, "SetText", Refit)
		hooksecurefunc(title, "SetFormattedText", Refit)
		hooksecurefunc(title, "Show", Refit)
	end
	PlaceTitle(header, title)
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
	self:SetBandCenter(header, cartouche)
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

local UpdateTab = function(tab)
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

-- A close button (UIPanelCloseButton's) as Diablo III's, in a socket of
-- `window`'s iron frame at its top right corner: lit under the mouse,
-- darker pressed. (`header` is the band's, kept for its callers.)
Module.StyleClose = function(self, button, window, header)
	local spec = config.close
	self:SkinClose(button)
	if not window.DiabolicSocket then
		window.DiabolicSocket = self:CreateSocket(window)
	end
	button:ClearAllPoints()
	button:SetPoint("CENTER", window, "TOPRIGHT", -spec.socket_size / 2, -spec.socket_size / 2)
	-- over its socket, again as the window shows: a toplevel one (the
	-- achievements') is raised then, its X put back under the socket
	local Raise = function()
		button:SetFrameLevel(window.Border:GetFrameLevel() + 2)
	end
	Raise()
	window:HookScript("OnShow", Raise)
end

-- The close button's socket, over the window's iron: the frame's edge
-- (its file's eighths: left, right, top, bottom, then the corners; the
-- top and bottom ones lying on their side) on its left and bottom only,
-- black inside the window's iron, its top and right ends cut at the
-- middle of that iron.
Module.CreateSocket = function(self, window)
	local spec, edge = config.close, config.backdrop.edgeSize
	local file = config.backdrop.edgeFile
	local size = spec.socket_size - spec.socket_inset
	local socket = CreateFrame("Frame", nil, window)
	socket:SetFrameLevel(window.Border:GetFrameLevel() + 1)
	socket:SetSize(size, size)
	socket:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.socket_inset, -spec.socket_inset)
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
	local bottom = socket:CreateTexture(nil, "BORDER")
	bottom:SetTexture(file)
	bottom:SetTexCoord(3/8, 0, 4/8, 0, 3/8, 1, 4/8, 1)
	-- up to the window's iron, not over it
	bottom:SetPoint("BOTTOMRIGHT", socket, "BOTTOMRIGHT", -inner, 0)
	bottom:SetSize(size - edge - inner, edge)
	local corner = socket:CreateTexture(nil, "BORDER")
	corner:SetTexture(file)
	corner:SetTexCoord(6/8, 7/8, 0, 1)
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
	local plate = CreateFrame("Frame", nil, frame)
	plate:SetPoint("LEFT", 0, offset or 0)
	plate:SetPoint("RIGHT", 0, offset or 0)
	plate:SetHeight(spec.height)
	self:CreateSlices(plate, "BACKGROUND", spec.plate, spec.plate.texture, spec.height, inset or spec.inset, frame)
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

-- The dark strip under `header`'s band the tabs sit on, once: its middle
-- under them, its pointed ends over the window's iron frame.
Module.AddTabStrip = function(self, header)
	if header.DiabolicStrip then
		return
	end
	local spec = config.tab_strip
	local window = header:GetParent()
	local strip = CreateFrame("Frame", nil, header)
	strip:SetFrameLevel(window:GetFrameLevel())
	strip:SetPoint("TOPLEFT", header, "BOTTOMLEFT", -spec.extend, spec.offset)
	strip:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", spec.extend, spec.offset)
	strip:SetHeight(spec.height)
	-- the middle drawn by the window itself, over its background: a frame
	-- of the window's level may be drawn under it
	local under = self:CreateSlices(strip, "ARTWORK", spec, spec.texture, spec.height, nil, window)
	under[1]:SetAlpha(0)
	under[3]:SetAlpha(0)
	local ends = CreateFrame("Frame", nil, strip)
	ends:SetFrameLevel(window.Border:GetFrameLevel() + 1)
	ends:SetAllPoints()
	local over = self:CreateSlices(ends, "ARTWORK", spec, spec.texture, spec.height)
	over[2]:SetAlpha(0)
	header.DiabolicStrip = strip
end

-- A dropdown in `header`'s band at `point` (of both), `x` from it, over
-- `window`'s frame.
Module.PlaceInBand = function(self, window, header, dropdown, point, x)
	local name = dropdown:GetName()
	dropdown:ClearAllPoints()
	dropdown:SetPoint(point, header, point, x, 0)
	local level = window:GetFrameLevel() + 4
	for _, part in ipairs({ dropdown, _G[name .. "Button"], _G[name .. "MouseOver"] }) do
		if part then
			part:SetFrameLevel(level)
			level = level + 1
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

-- The buttons (and the scroll bars, theirs too) of `frame` and all it
-- holds.
Module.StyleButtons = function(self, frame)
	self:StyleScrollBars(frame)
	local buttons = CollectButtons(frame, {})
	for _, button in ipairs(buttons) do
		button.DiabolicStyled = true
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
	return panel
end

-- A page of Diablo III's parchment under `frame` (a scroll frame of text
-- drawn for parchment), `insets` (left, top, right, bottom) around it, on
-- a frame of its own at its level (over a panel around it, under its text),
-- carried with it (Blizzard moves the quest log's details between windows).
Module.AddParchment = function(self, frame, insets)
	insets = insets or config.parchment_insets
	local holder = CreateFrame("Frame", nil, frame)
	holder:SetFrameLevel(frame:GetFrameLevel())
	holder:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	holder:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	local page = holder:CreateTexture(nil, "BACKGROUND")
	page:SetTexture(config.parchment)
	page:SetAllPoints()
	return page
end

-- A parchment's scroll bar (UIPanelScrollFrameTemplate's) out past its
-- pages' edges.
Module.PlaceParchmentBar = function(self, frame)
	local bar = _G[frame:GetName() .. "ScrollBar"]
	if bar then
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", frame, "TOPRIGHT", config.parchment_bar_x, -16)
		bar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", config.parchment_bar_x, 16)
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
	self.db = self:GetConfig("Windows")
	-- Blizzard's own windows (and their tabs and coins) when it's off
	if (not self.db.enableSkin) then
		return
	end
	hooksecurefunc("PanelTemplates_SelectTab", UpdateTab)
	hooksecurefunc("PanelTemplates_DeselectTab", UpdateTab)
	hooksecurefunc("PanelTemplates_TabResize", FitTab)
	-- every money frame's coins ours (Blizzard makes them on its first update)
	local coin = Engine:GetDB("UI").coin
	hooksecurefunc("MoneyFrame_Update", function(frame)
		local name = (type(frame) == "table") and frame:GetName() or frame
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
