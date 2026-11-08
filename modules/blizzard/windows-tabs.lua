-- Blizzard's windows' tabs (windows.lua's kit): lit red buttons, or banners
-- hanging from a window's foot.
local _, Engine = ...
local Module = Engine:GetModule("Blizzard: Windows")

local BannerIndex -- an emblem's place in the banners' atlas, by name (OnInit)

-- Lua and WoW API
local _G = _G
local ipairs = ipairs
local table_insert = table.insert
local math_floor = math.floor
local math_max = math.max
local setmetatable = setmetatable
local string_find = string.find
local unpack = unpack
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local Private = Module.Private
local NameFor = Private.NameFor
local Gradient = Private.Gradient
local Slices = Private.Slices
local UpdateLit = Private.UpdateLit
local PlaceBorder = Private.PlaceBorder
local PlaceBackground = Private.PlaceBackground
local LayoutStone = Private.LayoutStone
local PlaceHeader = Private.PlaceHeader
local LayoutCover = Private.LayoutCover

-- Tabs (PanelTemplates'): the selected one a lit red button, the others
-- dark ones, red under the mouse, their text in Exocet; `inset` keeps their
-- art apart where Blizzard overlaps them.
-- (3.3.5's IsEnabled is 1 or 0: Blizzard disables the chosen tab.)
local IsSelected = function(tab)
	return tab:IsEnabled() == 0
end
Module.IsSelected = IsSelected

-- A tab's text in its art's middle.
local PlaceTabText = function(tab)
	local text = tab:GetFontString()
	if text then
		text.DiabolicPlacing = true
		text:ClearAllPoints()
		text:SetPoint("CENTER", tab, "CENTER", 0, Module.config.tab.text_offset)
		text.DiabolicPlacing = nil
	end
end

-- A banner tab (StyleBanner): red and longer while chosen, dark otherwise;
-- its emblem brighter while chosen. Its text in the invisible font again
-- (Blizzard gives the chosen tab its own) and hidden: the client ignores
-- a font's alpha.
local UpdateBanner = function(tab)
	local art, spec = tab.DiabolicBanner, Module.config.banner
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
		tab:SetWidth(Module.config.banner.width)
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
	tab.DiabolicStyle = "Tab"
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
	local height = Module.config.tab.height
	local spec = Module.config.rect_button
	tab.DiabolicArt = {
		red = self:CreateSlices(tab, "BACKGROUND", spec, spec.texture.lit, height, inset),
		dark = self:CreateSlices(tab, "BACKGROUND", spec, spec.texture.dark, height, inset)
	}
	tab.DiabolicNotLit = IsSelected
	self:AddLit(tab, self:CreateSlices(tab, "BORDER", spec, spec.texture.normal, height, inset))
	local font = options.font or Module.config.tab.font
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
	local art, spec = tab.DiabolicBanner, Module.config.banner
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
	tab.DiabolicStyle = "Banner"
	local spec = Module.config.banner
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
		Gradient(shadow, "VERTICAL", 0, 0, 0, 0, 0, 0, 0, spec.shadow_alpha)
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
	local spec = Module.config.banner.rail
	local rail = CreateFrame("Frame", NameFor(window, "Rail"), window)
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
	local spec = Module.config.banner
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
	window.DiabolicDrop = Module.config.tab_row
	window:SetHitRectInsets(0, 0, Module.config.tab_row, 0)
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
		local spec = Module.config.close
		socket:SetPoint("TOPRIGHT", window, "TOPRIGHT", -spec.socket_inset, -spec.socket_inset - Module.config.tab_row)
	end
	if close then
		local spec = Module.config.close
		close:SetPoint("CENTER", window, "TOPRIGHT", -spec.socket_size / 2, -spec.socket_size / 2 - Module.config.tab_row)
	end
end

-- The sigils' places in the banners' atlas, by name (OnInit).
Module.IndexBanners = function(self)
	BannerIndex = {}
	for i, name in ipairs(Module.config.banner.sigil_names) do
		BannerIndex[name] = i
	end
end

-- Blizzard's tab functions followed (OnInit, when skinning).
Module.HookTabs = function(self)
	hooksecurefunc("PanelTemplates_SelectTab", UpdateTab)
	hooksecurefunc("PanelTemplates_DeselectTab", UpdateTab)
	hooksecurefunc("PanelTemplates_TabResize", FitTab)
end
