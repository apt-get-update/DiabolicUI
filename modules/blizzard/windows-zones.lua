-- The windows' zones (windows.lua's kit): panels, stone and parchment under
-- lists, iron bars, the foot, the rows' expanders and light, and the coins.
local _, Engine = ...
local Module = Engine:GetModule("Blizzard: Windows")

-- Lua and WoW API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local select = select
local setmetatable = setmetatable
local unpack = unpack
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local LitRows = Module.LitRows
local Private = Module.Private
local NameFor = Private.NameFor
local Slices = Private.Slices

-- A darker panel behind `frame` (a list's scroll frame), `insets` (left,
-- top, right, bottom) past it, under what its parent (`parent`, its own
-- by default) shows.
Module.AddPanel = function(self, frame, insets, parent)
	parent = parent or frame:GetParent()
	local panel = CreateFrame("Frame", NameFor(frame, "DiabolicPanel"), parent)
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
	local edge = spec.border * (spec.scale or Module.config.material_scale)
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
	local spec = Module.config.materials[material]
	local edge = spec.border * (spec.scale or Module.config.material_scale)
	-- each column: its left and right sides as the frame's side and an
	-- offset; each row the same, top and bottom
	local columns = {
		{ "LEFT", 0, "LEFT", edge },
		{ "LEFT", edge, "RIGHT", -edge },
		{ "RIGHT", -edge, "RIGHT", 0 },
	}
	local rows = {
		{ "TOP", 0, "TOP", -edge },
		{ "TOP", -edge, "BOTTOM", edge },
		{ "BOTTOM", edge, "BOTTOM", 0 },
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
	local fit = function()
		FitNine(frame, slices, spec)
	end
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
	local zone = CreateFrame("Frame", NameFor(frame, "DiabolicZone"), parent)
	zone:SetFrameLevel(parent:GetFrameLevel())
	zone:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	zone:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	zone.Material = self:CreateNine(zone, "BACKGROUND", material)
	zone.DiabolicContent = true
	zone.DiabolicMaterial = material
	return zone
end

-- A table's column names on a dark bar, over its zone's top.
Module.AddHeaderBar = function(self, zone)
	local section = Module.config.section
	local bar = CreateFrame("Frame", NameFor(zone, "ColumnBar"), zone)
	bar:SetFrameLevel(zone:GetFrameLevel())
	bar:SetPoint("BOTTOMLEFT", zone, "TOPLEFT", 0, 0)
	bar:SetPoint("BOTTOMRIGHT", zone, "TOPRIGHT", 0, 0)
	bar:SetHeight(section.height)
	local slices = self:CreateSlices(bar, "ARTWORK", section, section.texture, section.height)
	-- (its ends plain, the middle's: their diamonds would sit under the
	-- first and last columns)
	local width = section.canvas[1]
	for i, cap in pairs({ [1] = section.left, [3] = section.right }) do
		slices[i]:SetTexCoord(section.middle[1] / width, (section.middle[1] + cap[2] - cap[1]) / width, 0, 1)
	end
	bar.DiabolicContent = true -- (the list's top: its names on it)
	return bar
end

-- A table's column names (Blizzard's buttons `prefix`1 to `count`): as
-- tall as their dark bar, Diablo III's red under the one hovered, a thin
-- bronze line between each and the next (window.columns).
Module.StyleColumnHeaders = function(self, prefix, count)
	local spec = Module.config.columns
	for i = 1, count do
		local header = _G[prefix .. i]
		if header then
			header:SetHeight(Module.config.section.height)
			local highlight = header:GetHighlightTexture()
			if highlight then
				highlight:SetTexture(unpack(spec.hover_color))
				highlight:SetBlendMode("BLEND")
				highlight:ClearAllPoints()
				highlight:SetAllPoints(header)
			end
			if i < count then
				local line = header:CreateTexture(nil, "OVERLAY")
				line:SetTexture(unpack(spec.line_color))
				line:SetWidth(1)
				line:SetPoint("TOPRIGHT", header, "TOPRIGHT", -1, -spec.line_inset) -- (the next one starts 2 left of its right)
				line:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT", -1, spec.line_inset)
			end
		end
	end
end

-- A bar of the window's iron (its frame's left edge, turned: the part
-- footer_rail cuts, the bar and its shadows), drawn by `owner`.
local IronBar = function(owner)
	local spec, size = Module.config.footer_rail, Module.config.backdrop.edgeSize
	local outer, inner = spec.cut[1] / size / 8, spec.cut[2] / size / 8
	local bar = owner:CreateTexture(nil, "OVERLAY")
	bar:SetTexture(Module.config.backdrop.edgeFile)
	bar:SetTexCoord(outer, 0, inner, 0, outer, 1, inner, 1)
	bar:SetHeight(spec.cut[2] - spec.cut[1])
	return bar
end

-- A bar of the window's iron across `window` between two of its zones,
-- its middle `y` under the window's top, its ends under the frame's
-- sides (as the foot's): over what the window shows, under its frame.
-- (Its frame is the bar: settings/positions.lua can hang it elsewhere.)
Module.AddIronBar = function(self, window, y)
	local spec = Module.config.footer_rail
	local holder = CreateFrame("Frame", NameFor(window, "IronBar"), window)
	holder:SetFrameLevel(window:GetFrameLevel() + 2)
	local bar = IronBar(holder)
	local top = y - ((spec.bar[1] + spec.bar[2]) / 2 - spec.cut[1]) -- (the bar's middle in its cut)
	holder:SetPoint("TOPLEFT", window, "TOPLEFT", spec.bar[1], -top)
	holder:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.bar[1], -top)
	holder:SetHeight(bar:GetHeight())
	bar:SetAllPoints(holder)
	return bar
end

-- The window's foot in Diablo III's rough stone, inside its iron frame, along
-- its bottom, `height` high (see SetFooter), with the buttons and the money
-- Blizzard keeps there: drawn by the window over its painting, set apart from
-- the content by a bar of the frame's iron along its top (the frame's left edge
-- turned), its ends under the frame's sides. Always placed, shown or not: its
-- buttons are placed on it (settings/positions.lua).
Module.AddFooter = function(self, window, height)
	local foot = CreateFrame("Frame", NameFor(window, "Foot"), window)
	foot.Window = window
	foot.Material = self:CreateNine(foot, "ARTWORK", "footer", window)
	local spec = Module.config.footer_rail
	local rail = IronBar(foot)
	local x, y = spec.bar[1] - Module.config.backdrop.insets.left, spec.cut[2] - spec.bar[2]
	rail:SetPoint("BOTTOMLEFT", foot, "TOPLEFT", x, -y)
	rail:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", -x, -y)
	foot.Rail = rail
	local insets = Module.config.backdrop.insets
	foot:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT", insets.left, insets.bottom)
	foot:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -insets.right, insets.bottom)
	foot:SetHeight(Module.config.footer_height)
	window.DiabolicFoot = foot
	self:SetFooter(foot, height)
	Engine:GetModule("Blizzard: Adjust"):PlaceWaiting()
	return foot
end

-- How far over a foot's top its iron bar reaches: what's over the foot is
-- placed from there.
Module.FootBar = function(self)
	return Module.config.footer_rail.bar[2] - Module.config.footer_rail.cut[1]
end

-- A foot `height` high (true: window.footer_height, a row of buttons); none
-- on a page left without one.
Module.SetFooter = function(self, foot, height)
	foot.DiabolicShown = height and true -- (the slices can't say)
	if not height then
		foot.Material:Hide()
		foot.Rail:Hide()
		return
	end
	foot:SetHeight((height == true) and Module.config.footer_height or height)
	foot.Material:Show()
	foot.Rail:Show()
end

-- A list's + or - (a header's, its collapse-all) as Diablo III's red
-- square, each time Blizzard sets it (by the art it asks for); its round
-- glow out of sight.
local Expander = function(button)
	local texture = button:GetNormalTexture()
	local file = texture and texture:GetTexture()
	file = file and file:lower() or ""
	local spec = Module.config.expander
	local coords = (file:find("minusbutton") and spec.minus) or (file:find("plusbutton") and spec.plus)
	if coords then
		texture:SetTexture(spec.texture)
		texture:SetTexCoord(unpack(coords))
	end
end

Module.StyleExpanders = function(self, ...)
	for i = 1, select("#", ...) do
		local button = select(i, ...)
		if button and not button.DiabolicExpander then
			button.DiabolicExpander = true
			local glow = button:GetHighlightTexture()
			local file = glow and glow:GetTexture()
			if file and file:lower():find("plusbutton") then
				glow:SetAlpha(0)
			end
			hooksecurefunc(button, "SetNormalTexture", Expander)
			Expander(button)
		end
	end
end

-- The buttons named `prefix` 1 to `count` (those there) as StyleExpanders'.
Module.StyleExpanderRows = function(self, prefix, count)
	for i = 1, count do
		self:StyleExpanders(_G[prefix .. i])
	end
end

-- `texture` (a list's highlight on its chosen row) as Diablo III's chosen
-- row: faintly lit, in a thin orange box shown with it; in its own colours
-- (Blizzard tints it by the row's kind). Its blend kept: an added one (the
-- quest log's) lies over the row's text.
local BOX_SIDES = {
	{ "TOPLEFT", "TOPRIGHT" },
	{ "BOTTOMLEFT", "BOTTOMRIGHT" },
	{ "TOPLEFT", "BOTTOMLEFT" },
	{ "TOPRIGHT", "BOTTOMRIGHT" },
}

Module.LightRow = function(self, texture)
	local spec = Module.config.chosen_row
	LitRows[#LitRows + 1] = texture
	texture:SetTexture(unpack(spec.fill))
	texture:SetVertexColor(1, 1, 1)
	local box = {}
	for i, side in ipairs(BOX_SIDES) do
		local line = texture:GetParent():CreateTexture(nil, "OVERLAY")
		line:SetTexture(unpack(spec.line))
		line:SetPoint(side[1], texture, side[1])
		line:SetPoint(side[2], texture, side[2])
		if i <= 2 then
			line:SetHeight(spec.width)
		else
			line:SetWidth(spec.width)
		end
		box[i] = line
	end
	texture.DiabolicBox = box
	local Follow = function()
		for _, line in ipairs(box) do
			if texture:IsShown() == 1 then
				line:Show()
			else
				line:Hide()
			end
		end
	end
	hooksecurefunc(texture, "Show", Follow)
	hooksecurefunc(texture, "Hide", Follow)
	Follow()
	local busy
	hooksecurefunc(texture, "SetVertexColor", function()
		if not busy then
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
	insets = insets or Module.config.parchment_insets
	local holder = CreateFrame("Frame", NameFor(frame, "DiabolicParchment"), parent or frame)
	holder:SetFrameLevel(frame:GetFrameLevel())
	holder:SetPoint("TOPLEFT", frame, "TOPLEFT", -insets[1], insets[2])
	holder:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insets[3], -insets[4])
	holder.DiabolicContent = true
	holder.DiabolicMaterial = material or "page"
	return self:CreateNine(holder, "BACKGROUND", material or "page")
end

-- How many rows of `height` a list shows, at most `most`, from its `first` row's
-- top (something over them on its parchment: its All) down to its bottom (the
-- last may reach a little past it, onto the parchment's edge).
Module.RowsFitting = function(self, list, height, most, first)
	local top, bottom = first and first:GetTop(), list:GetBottom()
	local room = (top and bottom) and (top - bottom) or list:GetHeight()
	return math_max(0, math_min(math_floor(room / height + 0.25), most))
end

-- A parchment's scroll bar (UIPanelScrollFrameTemplate's) out past its
-- pages' edges, or `x` from its text's right.
Module.PlaceParchmentBar = function(self, frame, x)
	local bar = _G[frame:GetName() .. "ScrollBar"]
	if bar then
		x = x or Module.config.parchment_bar_x
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
local COINS = { [0] = "gold", [0.25] = "silver", [0.5] = "copper" }
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
