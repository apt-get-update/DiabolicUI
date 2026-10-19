-- Gives the rest of Blizzard's windows Diablo III's (windows.lua), from a
-- table in settings/blizzard.lua (`panels`): PvP, bank, trade, flight map,
-- books and letters, quest givers, gossip, tabard, charters, stable,
-- dressing room, trainer, professions, macros, inspect, socketing, auction
-- house, guild bank, key bindings. Each gets the stone window in its iron frame instead of its
-- art, its title in the plate over the red band, its X in the band, its
-- tabs in a row under it, its lists in darker panels, its buttons ours and
-- its dark text (drawn for parchment) pale, or its text on Diablo III's
-- parchment (quests, gossip, books). Blizzard places their parts
-- against the whole frame, so the window grows around it instead of moving
-- them. The load-on-demand ones are styled as their addon loads.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Panels", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local type = type
local select = select
local unpack = unpack

-- WoW API
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

-- The tabs in a row under the band, each once (addons add theirs later),
-- sized to their text when `padding` (the room around it) is given.
Module.StyleTabs = function(self, prefix, header, padding)
	local config = self.config
	local first = _G[prefix .. 1]
	first:ClearAllPoints()
	first:SetPoint("TOPLEFT", header, "BOTTOMLEFT", unpack(config.tab_offset))
	kit:AddTabStrip(header)
	local i = 1
	while _G[prefix .. i] do
		local tab = _G[prefix .. i]
		if not tab.DiabolicArt then
			kit:StyleTab(tab, { inset = config.tab_inset, font = config.tab_font, padding = padding })
			kit:UpdateTab(tab)
		end
		i = i + 1
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
Module.StyleLate = function(self, late)
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
	for _, name in ipairs(late.lower_in or {}) do
		local holder = _G[name]
		if holder then
			Lower(holder, late.lower, holder:GetChildren())
			Lower(holder, late.lower, holder:GetRegions())
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
end

Module.StylePanel = function(self, spec)
	local config = self.config
	local frame = _G[spec.frame]
	if (not frame) or frame.DiabolicPanel then
		return
	end
	frame.DiabolicPanel = true

	local window = kit:CreateWindow(frame, spec.insets)
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
		kit:SetPanelLayout(frame, spec.insets, spec.insets[1], spec.offset_y)
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
	for name, place in pairs(spec.places or {}) do
		local part = _G[name]
		if part then
			local point, relative, relativePoint, x, y = unpack(place)
			part:ClearAllPoints()
			part:SetPoint(point, _G[relative], relativePoint, x, y)
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
	if spec.medallion then
		kit:AddMedallion(header, spec.medallion)
	end
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
	local close = spec.close and _G[spec.close]
	if close then
		kit:StyleClose(close, window, header)
	end

	if spec.tabs then
		self:StyleTabs(spec.tabs, header, spec.tab_padding)
	end
	-- a page's own tabs right under the window's (Blizzard's start 70 in,
	-- the last past the window's side)
	local own = spec.own_tabs and _G[spec.own_tabs .. 1]
	if own and spec.tabs then
		own:ClearAllPoints()
		own:SetPoint("TOPLEFT", _G[spec.tabs .. 1], "BOTTOMLEFT", 0, -config.own_tab_gap)
	end
	local i = 1
	while spec.own_tabs and _G[spec.own_tabs .. i] do
		kit:StyleTab(_G[spec.own_tabs .. i], { inset = config.own_tab_inset, font = config.tab_font })
		i = i + 1
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
		-- earlier one whose sides its zone takes, its own material }
		local name, wider, under, material = list, 0, nil, nil
		if type(list) == "table" then
			name, wider, under, material = list[1], list[2] or 0, list[3], list[4]
		end
		if _G[name] then
			local insets = config.list_panel_insets
			local zone = kit:AddZone(_G[name], material or spec.list_material or "slate", { insets[1] + wider, insets[2], insets[3], insets[4] })
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
			kit:AddPanel(scroll, kit.config.parchment_panel_insets)
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
			kit:PlaceParchmentBar(scroll)
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
	kit:StyleButtons(frame)
	if spec.pale then
		PaleText(frame, config.text_color)
	end
	-- what Blizzard and addons add or set as it shows: buttons, tabs, text
	frame:HookScript("OnShow", function()
		if spec.late then
			self:StyleLate(spec.late)
		end
		kit:StyleCoins(frame)
		kit:StyleButtons(frame)
		if spec.tabs then
			self:StyleTabs(spec.tabs, header, spec.tab_padding)
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
