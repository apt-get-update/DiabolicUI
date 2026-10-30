-- Gives the rest of Blizzard's windows Diablo III's (windows.lua), from a
-- table in settings/blizzard.lua (`panels`): PvP, bank, trade, flight map,
-- books and letters, quest givers, gossip, tabard, charters, stable,
-- dressing room, trainer, professions, macros, inspect, socketing, auction
-- house, guild bank, key bindings. Each gets the stone window in its iron frame instead of its
-- art, its title on a plate on its top edge, its X in the band, its
-- tabs in a row under it, its lists in darker panels, its buttons ours and
-- its dark text (drawn for parchment) pale, or its text on Diablo III's
-- parchment (quests, gossip, books). Blizzard places their parts
-- against the whole frame, so the window grows around it instead of moving
-- them. The load-on-demand ones are styled as their addon loads.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Panels", "LOW")

local kit
local Placed = {} -- the bands' parts placed (PlaceBand), by their settings

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local type = type
local select = select
local string_format = string.format
local math_max = math.max
local math_min = math.min
local tonumber = tonumber
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded

-- their scroll bars' tracks, by file (lowercase, as patterns)
local ART = { "ui%-character%-scrollbar", "ui%-classtrainer%-scrollbar", "ui%-itemsocketingframe%-scrollbar" }

-- Whether a region's name matches one of `keep` (patterns).
local Kept = function(region, keep)
	local name = region:GetName()
	if name and keep then
		for _, pattern in ipairs(keep) do
			if name:find(pattern) then
				return true
			end
		end
	end
end

-- A frame's own textures out of sight, but those it keeps.
local HideOwnArt = function(frame, keep)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") and not Kept(region, keep) then
			region:SetAlpha(0)
		end
	end
end

-- The font strings in `frame` and all it holds showing `text` (a title
-- with no name of its own) out of sight; buttons' kept (a tab can read
-- the same: the auction house's "Auctions").
local HideText
HideText = function(frame, text)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("FontString") and (region:GetText() == text) then
			region:SetAlpha(0)
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if not child:IsObjectType("Button") then
			HideText(child, text)
		end
	end
end

-- `color`'s code for a text's colors.
local ColorCode = function(color)
	return string_format("|cff%02x%02x%02x", color[1] * 255, color[2] * 255, color[3] * 255)
end

-- A text's other colors as dark inks on parchment: white `ink` (its
-- code), the others (item qualities, Blizzard's red) darkened to `bright`
-- at most.
local DarkenCodes = function(text, ink, bright)
	return (text:gsub("|c%x%x(%x%x)(%x%x)(%x%x)", function(r, g, b)
		r, g, b = tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255
		local top = math_max(r, g, b)
		if (top <= bright) then
			return nil
		elseif (math_min(r, g, b) > .8) then
			return ink
		end
		return ColorCode({ r * bright / top, g * bright / top, b * bright / top })
	end))
end

-- The dark text in `frame` and all it holds (drawn for parchment) pale.
local PaleText
PaleText = function(frame, color)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("FontString") then
			local r, g, b = region:GetTextColor()
			if (r + g + b < 1) then
				region:SetTextColor(unpack(color))
			end
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		PaleText((select(i, frame:GetChildren())), color)
	end
end

-- The tabs as banners hanging from the window's foot, `sigils` their
-- emblems; again as it shows (addons add theirs later).
Module.HangTabs = function(self, window, prefix, sigils)
	local tabs = {}
	local i = 1
	while _G[prefix .. i] do
		tabs[i] = _G[prefix .. i]
		i = i + 1
	end
	kit:HangTabs(window, tabs, sigils)
end

-- A rod in Blizzard's art (`rail`: its halves, each { name, tip, from, to }
-- in its file's pixels, the left one `left`) run on as far as the content
-- under it (`rail.reach` in from the window's sides, inside its iron): each
-- half cut at its plain stretch (`from` to `to`), its tapered tip (`tip` to
-- the stretch) moved out to the content's edge, the stretch drawn out
-- between them.
local ExtendRail = function(window, rail)
	local fits = {}
	for _, side in ipairs(rail) do
		local art = _G[side[1]]
		local file = art:GetWidth() -- (drawn at its file's size)
		local tip, from, to = side[2], side[3], side[4]
		local _, top, _, bottom = art:GetTexCoord()
		local Piece = function(left, right)
			local piece = window:CreateTexture(nil, "ARTWORK")
			piece:SetTexture(art:GetTexture())
			piece:SetTexCoord(left / file, right / file, top, bottom)
			piece:SetSize(right - left, art:GetHeight())
			return piece
		end
		local stretch = Piece(from, to)
		if side.left then
			local tipPiece = Piece(tip, from)
			tipPiece:SetPoint("TOPRIGHT", stretch, "TOPLEFT")
			local point, relative, relativePoint, x, y = art:GetPoint()
			art:SetPoint(point, relative, relativePoint, x + to, y)
			art:SetWidth(file - to)
			art:SetTexCoord(to / file, 1, top, bottom)
			stretch:SetPoint("TOPRIGHT", art, "TOPLEFT")
			fits[#fits + 1] = { stretch, function() return art:GetLeft() - (from - tip) - window:GetLeft() - rail.reach end }
		else
			local tipPiece = Piece(to, tip)
			tipPiece:SetPoint("TOPLEFT", stretch, "TOPRIGHT")
			art:SetWidth(from)
			art:SetTexCoord(0, from / file, top, bottom)
			stretch:SetPoint("TOPLEFT", art, "TOPRIGHT")
			fits[#fits + 1] = { stretch, function() return window:GetRight() - rail.reach - (tip - to) - art:GetRight() end }
		end
	end
	-- (as wide as the room left, once the window is placed)
	local Fit = function()
		if (not window:GetLeft()) then
			return
		end
		for _, fit in ipairs(fits) do
			fit[1]:SetWidth(math_max(1, fit[2]()))
		end
	end
	window:HookScript("OnShow", Fit)
	window:HookScript("OnSizeChanged", Fit)
	Fit()
end

-- What's placed from `holder`'s top (by one point) `by` higher, each once.
local Raise = function(holder, by, ...)
	for i = 1, select("#", ...) do
		local part = select(i, ...)
		if (not part.DiabolicRaised) and (part:GetNumPoints() == 1) then
			local point, relative, relativePoint, x, y = part:GetPoint()
			if (relative == holder or relative == nil) and relativePoint:find("^TOP") then
				part:SetPoint(point, relative, relativePoint, x, y + by)
				part.DiabolicRaised = true
			end
		end
	end
end

-- What's placed from `holder`'s bottom (by one point) `by` lower, each
-- once.
local Lower = function(holder, by, ...)
	for i = 1, select("#", ...) do
		local part = select(i, ...)
		if (not part.DiabolicLowered) and (part:GetNumPoints() == 1) then
			local point, relative, relativePoint, x, y = part:GetPoint()
			if (relative == holder or relative == nil) and relativePoint:find("^BOTTOM") then
				part:SetPoint(point, relative, relativePoint, x, y - by)
				part.DiabolicLowered = true
			end
		end
	end
end

-- The parts an addon adds to a window once it's shown (`late`, its
-- spec's), each once.
-- Controls moved into `header`'s band (the band's rule: LineBand), once:
-- `left`, from its left end (a table in it: controls one under the
-- other); `right`, from its right end; `hints`, edit boxes' labels (their
-- global strings' names) pale in them while they're empty. Its texts in
-- its labels' font, its boxes on Diablo III's plates, its checkboxes
-- Diablo III's, all over the band.
Module.PlaceBand = function(self, header, band)
	if Placed[band] then
		return
	end
	local level = header:GetFrameLevel() + 1
	local Prepare = function(name, stacked)
		local part = _G[name]
		if not part then
			return
		end
		if part:IsObjectType("FontString") then
			part:SetFontObject(kit.config.check_box.font)
			part:SetTextColor(unpack(kit.config.title_plate.color))
			return part
		end
		if part:IsObjectType("EditBox") then
			kit:StyleEditBox(part)
		elseif part:IsObjectType("CheckButton") then
			kit:StyleCheckBox(part, stacked and kit.config.check_box.stacked)
		end
		if (part:GetFrameLevel() < level) then
			part:SetFrameLevel(level)
		end
		return part
	end
	for name, text in pairs(band.hints or {}) do
		if _G[name] then
			kit:AddHint(_G[name], _G[text])
		end
	end
	local left, right = {}, {}
	for _, entry in ipairs(band.left or {}) do
		if (type(entry) == "table") then
			-- one under the other, in a holder as wide as the widest
			local holder = CreateFrame("Frame", nil, header)
			local width, height = 0, 0
			for _, name in ipairs(entry) do
				local part = Prepare(name, true)
				if part then
					local inLeft, inRight = kit.ArtInsets(part)
					part:ClearAllPoints()
					part:SetPoint("TOPLEFT", holder, "TOPLEFT", -inLeft, -height)
					width = math_max(width, part:GetWidth() - inLeft - inRight)
					height = height + part:GetHeight()
				end
			end
			holder:SetSize(width, height)
			left[#left + 1] = holder
		else
			left[#left + 1] = Prepare(entry)
		end
	end
	for _, name in ipairs(band.right or {}) do
		right[#right + 1] = Prepare(name)
	end
	kit:LineBand(header, left)
	kit:LineBand(header, right, true)
	-- (an addon's, once they're there)
	Placed[band] = (#left + #right > 0)
end

Module.StyleLate = function(self, late, header)
	local config = self.config
	for _, name in ipairs(late.hide or {}) do
		if _G[name] then
			_G[name]:SetAlpha(0)
		end
	end
	for _, entry in ipairs(late.beside or {}) do
		local part, other = _G[entry[1]], _G[entry[2]]
		if part and other then
			part:SetWidth(entry[3])
		end
	end
	for _, entry in ipairs(late.hide_texts or {}) do
		-- { a frame, its text (any, if left out) }: its labels out of sight
		local frame = _G[entry[1]]
		for i = 1, frame and select("#", frame:GetRegions()) or 0 do
			local region = select(i, frame:GetRegions())
			if region:IsObjectType("FontString") and ((not entry[2]) or (region:GetText() == entry[2])) then
				region:SetAlpha(0)
			end
		end
	end
	for _, name in ipairs(late.lower_skip or {}) do
		if _G[name] then
			_G[name].DiabolicLowered = true -- (kept where Blizzard put it)
		end
	end
	for _, name in ipairs(late.lower_in or {}) do
		local holder = _G[name]
		if holder then
			Lower(holder, late.lower, holder:GetChildren())
			Lower(holder, late.lower, holder:GetRegions())
		end
	end
	for name, by in pairs(late.raise_in or {}) do
		local holder = _G[name]
		if holder then
			Raise(holder, by, holder:GetChildren())
			Raise(holder, by, holder:GetRegions())
		end
	end
	for _, entry in ipairs(late.panels or {}) do
		local frame = _G[entry[1]]
		if frame and not frame.DiabolicPanel then
			frame.DiabolicPanel = true
			frame:SetBackdrop(nil)
			HideOwnArt(frame)
			-- (under it, shown with it: Auctionator's pages share them)
			local panel = kit:AddPanel(frame, entry[2])
			if not frame:IsShown() then
				panel:Hide()
			end
			frame:HookScript("OnShow", function() panel:Show() end)
			frame:HookScript("OnHide", function() panel:Hide() end)
		end
	end
	for _, name in ipairs(late.dropdowns or {}) do
		local dropdown = _G[name]
		if dropdown and not dropdown.DiabolicPlate then
			dropdown.DiabolicPlate = true
			kit:StyleDropDown(dropdown)
		end
	end
	local i = 1
	while late.tabs and _G[late.tabs .. i] do
		local tab = _G[late.tabs .. i]
		if not tab.DiabolicArt then
			kit:StyleTab(tab, { inset = config.own_tab_inset, font = config.tab_font })
			kit:UpdateTab(tab)
		end
		i = i + 1
	end
	if late.band then
		self:PlaceBand(header, late.band)
	end
end

Module.StylePanel = function(self, spec)
	local config = self.config
	local frame = _G[spec.frame]
	if (not frame) or frame.DiabolicPanel then
		return
	end
	frame.DiabolicPanel = true

	-- no band (nothing in it): its room given back, the frame and all it
	-- holds up into it, the window's top where it was, its foot higher
	local insets, offsetY = spec.insets, spec.offset_y
	if (spec.band == false) then
		insets = { insets[1], insets[2] - config.header_height, insets[3], insets[4] }
		offsetY = (offsetY or 0) + config.header_height
	end
	local window = kit:CreateWindow(frame, insets)
	kit:SetBackground(window, spec.background or config.background)
	if (type(spec.footer) == "table") then
		-- one page's: there while it shows
		local foot = kit:AddFooter(window)
		for page, top in pairs(spec.footer) do
			if _G[page] then
				_G[page]:HookScript("OnShow", function() kit:SetFooter(foot, top) end)
				_G[page]:HookScript("OnHide", function() kit:SetFooter(foot, nil) end)
				kit:SetFooter(foot, _G[page]:IsShown() and top or nil)
			end
		end
	elseif spec.footer then
		kit:AddFooter(window, spec.footer)
	end
	kit:AddDrag(window, frame)
	if (spec.panel ~= false) then
		kit:SetPanelLayout(frame, insets, insets[1], offsetY)
	end
	HideOwnArt(frame, spec.keep)
	for _, name in ipairs(spec.subframes or {}) do
		if _G[name] then
			HideOwnArt(_G[name], spec.keep)
		end
	end
	for _, name in ipairs(spec.hide or {}) do
		local part = _G[name]
		if part then
			part:SetAlpha(0)
			-- a button out of sight can't be clicked either
			if part.EnableMouse then
				part:EnableMouse(false)
			end
		end
	end
	-- every part let go first: Blizzard's own anchors may chain them the
	-- other way round (the PvP Join button hangs off Cancel)
	for name in pairs(spec.places or {}) do
		if _G[name] then
			_G[name]:ClearAllPoints()
		end
	end
	for name, place in pairs(spec.places or {}) do
		local part = _G[name]
		if part then
			local point, relative, relativePoint, x, y = unpack(place)
			part:SetPoint(point, _G[relative], relativePoint, x, y)
		end
	end
	for _, y in ipairs(spec.iron_bars or {}) do
		kit:AddIronBar(window, y)
	end
	for _, name in ipairs(spec.outside or {}) do
		if _G[name] then
			_G[name].DiabolicOutside = true -- (/dui layout: not out of the window by mistake)
		end
	end
	for name, size in pairs(spec.sizes or {}) do
		if _G[name] then
			_G[name]:SetSize(unpack(size))
		end
	end
	for _, name in ipairs(spec.bars or {}) do
		kit:StyleBar(_G[name], { _G[name .. "Border"], _G[name .. "Background"] })
	end
	kit:HideArt(frame, ART)
	if spec.art then
		kit:HideArt(frame, spec.art)
	end

	local header = kit:CreateHeader(window, config.header_height, config.header_insets)
	local title = spec.title and _G[spec.title]
	if (not title) and spec.text then
		-- a title of our own, Blizzard's (no name to it) out of sight
		HideText(frame, _G[spec.text])
		title = frame:CreateFontString(nil, "OVERLAY")
		title:SetFontObject(_G.GameFontNormal)
		title:SetText(_G[spec.text])
	end
	if title then
		kit:SetTitle(header, title)
	end
	-- a line of its own in the band's left (the guild bank tab's name and
	-- rights), its frame (Blizzard's) out of sight
	local text = spec.band_text and _G[spec.band_text]
	if text then
		text:SetParent(header)
		text:SetDrawLayer("OVERLAY")
		text:SetFontObject(kit.config.check_box.font)
		text:SetTextColor(unpack(kit.config.title_plate.color))
		text:SetJustifyH("LEFT")
		kit:LineBand(header, { text })
	end
	for _, name in ipairs(spec.dropdowns or {}) do
		local dropdown = _G[name]
		if dropdown and not dropdown.DiabolicPlate then
			dropdown.DiabolicPlate = true
			kit:StyleDropDown(dropdown)
		end
	end
	if (spec.band == false) then
		kit:DropBand(header)
	elseif spec.band then
		self:PlaceBand(header, spec.band)
	end
	-- (true: its unnamed one)
	local close = spec.close and ((spec.close == true) and kit:FindClose(frame) or _G[spec.close])
	if close then
		kit:StyleClose(close, window, header)
	end
	-- its crest (the guild bank's tabard) over the iron, its foot (the
	-- rod's) `crest_y` over the iron's top edge (as far left as Blizzard
	-- has it), the title's plate over it
	local crest = spec.crest and _G[spec.crest]
	if crest then
		local level = window.Border:GetFrameLevel()
		crest:SetFrameLevel(level + 1)
		if spec.crest_y then
			local _, _, _, x = crest:GetPoint()
			crest:ClearAllPoints()
			crest:SetPoint("BOTTOM", window.Border, "TOP", x, spec.crest_y)
		end
		if window.DiabolicPlate then
			window.DiabolicPlate:SetFrameLevel(level + 2)
		end
	end
	if spec.rail then
		ExtendRail(window, spec.rail)
	end

	if spec.tabs then
		self:HangTabs(window, spec.tabs, spec.sigils)
		kit:DropTop(window)
	end
	for _, pane in ipairs(spec.panes or {}) do
		-- { the first part, the last one or false, open }
		local first, last = _G[pane[1]], pane[2] and _G[pane[2]]
		if first then
			kit:AddPane(first, last, pane[3])
		end
	end
	local zones = {}
	for _, list in ipairs(spec.lists or {}) do
		-- a name, or { name, how much further left its rows start, an
		-- earlier one whose sides its zone takes, its own material, its
		-- zone in it (over the window's painting, under its text: a scroll
		-- frame that never hides) }
		local name, wider, under, material, inside = list, 0, nil, nil, nil
		if type(list) == "table" then
			name, wider, under, material, inside = list[1], list[2] or 0, list[3], list[4], list[5]
		end
		if _G[name] then
			local insets = spec.list_insets or config.list_panel_insets
			local zone = kit:AddZone(_G[name], material or spec.list_material or "slate", { insets[1] + wider, insets[2], insets[3], insets[4] },
				inside and _G[name] or nil)
			zones[name] = zone
			if under and zones[under] then
				zone:ClearAllPoints()
				zone:SetPoint("TOP", _G[name], "TOP", 0, insets[2])
				zone:SetPoint("BOTTOM", _G[name], "BOTTOM", 0, -insets[4])
				zone:SetPoint("LEFT", zones[under], "LEFT")
				zone:SetPoint("RIGHT", zones[under], "RIGHT")
			end
		end
	end
	local pages = {}
	for _, parchment in ipairs(spec.parchments or {}) do
		-- a name, or { name, its material, the page whose sides it takes,
		-- how far its top reaches over its text's }
		local name, material, under, raise = parchment, nil, nil, nil
		if type(parchment) == "table" then
			name, material, under, raise = parchment[1], parchment[2], parchment[3], parchment[4]
		end
		local scroll = _G[name]
		if scroll then
			kit:AddPanel(scroll, spec.parchment_panel or kit.config.parchment_panel_insets)
			-- (its window's: Blizzard hides a list's scroll frame when it all fits)
			local page = kit:AddParchment(scroll, nil, material, scroll:GetParent())[1]:GetParent()
			pages[name] = page
			if under and pages[under] then
				local insets = kit.config.parchment_insets
				page:ClearAllPoints()
				page:SetPoint("TOP", scroll, "TOP", 0, insets[2] + (raise or 0))
				page:SetPoint("BOTTOM", scroll, "BOTTOM", 0, -insets[4])
				page:SetPoint("LEFT", pages[under], "LEFT", 0, 0)
				page:SetPoint("RIGHT", pages[under], "RIGHT", 0, 0)
			end
			kit:PlaceParchmentBar(scroll, spec.parchment_bar_x)
		end
	end
	-- text Blizzard colors for its page's material, dark on ours (after it
	-- has, as the page shows)
	if spec.ink then
		local Ink = function()
			for _, name in ipairs(spec.ink) do
				if _G[name] then
					_G[name]:SetTextColor(unpack(kit.config.ink))
					_G[name]:SetShadowColor(0, 0, 0, 0) -- (a black one blurs it on parchment)
				end
			end
		end
		frame:HookScript("OnEvent", Ink)
		frame:HookScript("OnShow", Ink)
	end
	-- the lines Blizzard adds to a log (white, the names gold, the times
	-- teal): in ink on its parchment, in bold, the names and times in
	-- darker ones, the items' and Blizzard's other colors darkened
	for _, name in ipairs(spec.ink_messages or {}) do
		local log = _G[name]
		if log then
			local add, ink, inks = log.AddMessage, kit.config.ink, config.log_inks
			local nameCode, timeCode, inkCode = ColorCode(inks.name), ColorCode(inks.time), ColorCode(ink)
			local time = _G.GUILD_BANK_LOG_TIME_PREPEND and _G.GUILD_BANK_LOG_TIME_PREPEND:match("|c%x+")
			log.AddMessage = function(owner, text, ...)
				text = text:gsub(_G.NORMAL_FONT_COLOR_CODE, nameCode)
				if time then
					text = text:gsub(time, timeCode)
				end
				text = DarkenCodes(text, inkCode, inks.bright)
				return add(owner, text, ink[1], ink[2], ink[3])
			end
			log:SetFontObject(inks.font)
			log:SetShadowColor(0, 0, 0, 0)
		end
	end
	kit:StyleButtons(frame)
	if spec.pale then
		PaleText(frame, config.text_color)
	end
	-- what Blizzard and addons add or set as it shows: buttons, tabs, text
	frame:HookScript("OnShow", function()
		if spec.late then
			self:StyleLate(spec.late, header)
		end
		kit:StyleCoins(frame)
		kit:StyleButtons(frame)
		if spec.tabs then
			self:HangTabs(window, spec.tabs, spec.sigils)
		end
		if spec.pale then
			PaleText(frame, config.text_color)
		end
	end)
end

-- The windows of `addon` (nil: those always loaded).
Module.StyleAddon = function(self, addon)
	for _, spec in ipairs(self.config.frames) do
		if (spec.addon == addon) then
			self:StylePanel(spec)
		end
	end
end

Module.ADDON_LOADED = function(self, event, addon)
	if self.Waiting[addon] then
		self.Waiting[addon] = nil
		self:StyleAddon(addon)
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").panels
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleAddon(nil)
	self.Waiting = {}
	for _, spec in ipairs(self.config.frames) do
		if spec.addon then
			self.Waiting[spec.addon] = true
		end
	end
	for addon in pairs(self.Waiting) do
		if IsAddOnLoaded(addon) then
			self.Waiting[addon] = nil
			self:StyleAddon(addon)
		end
	end
	self:RegisterEvent("ADDON_LOADED")
end
