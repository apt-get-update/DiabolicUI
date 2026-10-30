-- Gives Blizzard's character window Diablo III's (windows.lua): the stone
-- window in its iron frame instead of its panel art, on every tab
-- (character, pet, reputation, skills, currency), the name in a plate on
-- the window's edge over the red band, the level in the band, the tabs as
-- buttons in a row under it. The character tab in two columns, the window
-- wider for it: the gear around a tall model in a stone pane, the
-- character's home city behind it (its race's capital), the GearScore
-- in its bottom; on the right, in pages under their own tabs, the level
-- (under the top one) and two groups of stats, the titles, and the equipment manager (its buttons as icons
-- beside its sets, a "+" for a new set). No round portrait in its corner but
-- the talent spec's icon in the band instead (its points on hover, the
-- talents on a click); the companions in panels, a faction's details in
-- a dark panel beside it. The gear slots get their
-- quality borders from containers.lua.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Character", "LOW")

local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")
local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local math_ceil = math.ceil
local math_cos = math.cos
local math_floor = math.floor
local math_max = math.max
local math_pi = math.pi
local math_rad = math.rad
local math_sin = math.sin
local select = select
local string_format = string.format
local table_insert = table.insert
local table_sort = table.sort
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetActiveTalentGroup = _G.GetActiveTalentGroup
local GetCVar = _G.GetCVar
local GetCVarBool = _G.GetCVarBool
local GetCurrentTitle = _G.GetCurrentTitle
local GetNumTitles = _G.GetNumTitles
local GetTitleName = _G.GetTitleName
local IsTitleKnown = _G.IsTitleKnown
local MouseIsOver = _G.MouseIsOver
local PlaySound = _G.PlaySound
local SetCurrentTitle = _G.SetCurrentTitle
local GetFactionInfo = _G.GetFactionInfo
local GetNumEquipmentSets = _G.GetNumEquipmentSets
local GetSelectedFaction = _G.GetSelectedFaction
local GameTooltip = _G.GameTooltip
local GetTalentTabInfo = _G.GetTalentTabInfo
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded
local SetCVar = _G.SetCVar
local SetPortraitTexture = _G.SetPortraitTexture
local SetPortraitToTexture = _G.SetPortraitToTexture
local UnitLevel = _G.UnitLevel
local UnitRace = _G.UnitRace

-- The character's home city behind the model: the dressing room's art of
-- its race's capital (Blizzard's DressUpTexturePath picks it: Gnomes get
-- Ironforge, Trolls Orgrimmar), its left tiles (the picture and the floor
-- under it, as Blizzard's dressing room shows them; the right ones are
-- strips its frame covers). It fills `scene`, cut at its sides or top: the
-- floor stays, under the model's feet.
-- The tiles' sizes there; of the bottom one's 128 rows, only the top ones
-- are painted (its buttons cover the rest, black)
local SCENE_WIDTH, SCENE_TOP, SCENE_BOTTOM, SCENE_ROWS = 256, 255, 74, 128
local LayoutScene = function(scene)
	local width, height = scene:GetWidth(), scene:GetHeight()
	if (width <= 0) or (height <= 0) then
		return
	end
	-- the part of the picture shown, in its pixels
	local total = SCENE_TOP + SCENE_BOTTOM
	local x0, x1, y0 = 0, SCENE_WIDTH, 0
	if (width / height > SCENE_WIDTH / total) then
		y0 = total - SCENE_WIDTH * height / width
	else
		local cut = (SCENE_WIDTH - total * width / height) / 2
		x0, x1 = cut, SCENE_WIDTH - cut
	end
	local scale = width / (x1 - x0)
	local left, right = x0 / SCENE_WIDTH, x1 / SCENE_WIDTH
	local top, bottom = scene.Top, scene.Bottom
	if (y0 < SCENE_TOP) then
		top:SetHeight((SCENE_TOP - y0) * scale)
		top:SetTexCoord(left, right, y0 / SCENE_TOP, 1)
		top:Show()
		bottom:SetHeight(SCENE_BOTTOM * scale)
		bottom:SetTexCoord(left, right, 0, SCENE_BOTTOM / SCENE_ROWS)
	else
		top:Hide()
		bottom:SetHeight((total - y0) * scale)
		bottom:SetTexCoord(left, right, (y0 - SCENE_TOP) / SCENE_ROWS, SCENE_BOTTOM / SCENE_ROWS)
	end
end

-- The tabs' panel art, by its file (lowercase, as patterns): the frames,
-- the skills' dividers, the scroll bar tracks, the sort tab, the companions'
-- frames. The rest of their textures (bars, stat boxes, icons) stay.
local PANEL_ART = {
	"ui%-character%-general%-", "ui%-character%-charactertab%-", "ui%-petpaperdollframe%-bot",
	"skillframe%-bot", "ui%-talentframe%-bot", "ui%-classtrainer%-horizontalbar",
	"ui%-classtrainer%-scrollbar", "ui%-character%-scrollbar", "ui%-questlogsorttab%-", "ui%-petframe%-frame$", "ui%-petframe%-slots$"
}

-- the tabs' frames; the currency tab's comes with Blizzard_TokenUI
local TABS = { "PaperDollFrame", "PetPaperDollFrame", "ReputationFrame", "SkillFrame" }

local IsPanelArt = function(region)
	local file = region:IsObjectType("Texture") and region:GetTexture()
	if file then
		file = file:lower()
		for _, pattern in ipairs(PANEL_ART) do
			if file:find(pattern) then
				return true
			end
		end
	end
end

-- A tab's panel art out of sight, its own and its frames', through its
-- alpha (Blizzard never sets that on these).
Module.HidePanelArt = function(self, frame)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if IsPanelArt(region) then
			region:SetAlpha(0)
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		self:HidePanelArt((select(i, frame:GetChildren())))
	end
end

-- The spec: the tree with the most points (the first of equals), and the
-- points in each tree. Nothing without any points.
Module.GetSpec = function(self)
	local group = GetActiveTalentGroup()
	local points, best = {}, nil
	for i = 1, 3 do
		points[i] = select(3, GetTalentTabInfo(i, nil, nil, group)) or 0
		if (points[i] > 0) and ((not best) or (points[i] > points[best])) then
			best = i
		end
	end
	if best then
		local name, icon = GetTalentTabInfo(best, nil, nil, group)
		return name, icon, string_format("%d/%d/%d", points[1], points[2], points[3])
	end
end

Module.UpdateSpec = function(self)
	local button = self.Spec
	local name, icon, points = self:GetSpec()
	button.name, button.points = name, points
	if icon then
		SetPortraitToTexture(button.icon, icon)
	end
	if name then
		button:Show()
	else
		button:Hide()
	end
end

local Spec_OnEnter = function(self)
	local tooltip = _G.GameTooltip
	tooltip:SetOwner(self, "ANCHOR_RIGHT")
	tooltip:AddLine(self.name)
	tooltip:AddLine(self.points, 1, 1, 1)
	tooltip:Show()
end

local Spec_OnLeave = function(self)
	_G.GameTooltip:Hide()
end

-- The spec's icon socketed in the title plate, on every tab (only the
-- plate's cross until there's a spec): its points in its tooltip, a click
-- for the talents.
Module.CreateSpec = function(self)
	local button = kit:AddTitleGem(self.Header)
	button:SetScript("OnEnter", Spec_OnEnter)
	button:SetScript("OnLeave", Spec_OnLeave)
	button:SetScript("OnClick", function() _G.ToggleTalentFrame() end)
	self.Spec = button
	self:UpdateSpec()
	_G.CharacterFrame:HookScript("OnShow", function() self:UpdateSpec() end)
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateSpec")
end

-- the gear slots, in their columns from the top, and the weapons
local LEFT_SLOTS = {
	"CharacterHeadSlot", "CharacterNeckSlot", "CharacterShoulderSlot", "CharacterBackSlot",
	"CharacterChestSlot", "CharacterShirtSlot", "CharacterTabardSlot", "CharacterWristSlot"
}
local RIGHT_SLOTS = {
	"CharacterHandsSlot", "CharacterWaistSlot", "CharacterLegsSlot", "CharacterFeetSlot",
	"CharacterFinger0Slot", "CharacterFinger1Slot", "CharacterTrinket0Slot", "CharacterTrinket1Slot"
}

-- the dropdowns (UIDropDownMenuTemplate's art, and the title's own)
local DROPDOWNS = { "PlayerTitleFrame" }

-- The character tab in two columns, with room around everything: the
-- gear on the left, the slots along its sides, a tall model between them in
-- a stone pane, the weapons in a row at the bottom; the right one is
-- CreateColumn's.
Module.LayoutPaperDoll = function(self, window)
	local layout = self.config.paperdoll
	local pane = CreateFrame("Frame", nil, _G.PaperDollFrame)
	pane:SetPoint("TOPLEFT", window, "TOPLEFT")
	pane:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT")
	pane:SetWidth(layout.pane_width)
	self.GearPane = pane

	for _, column in ipairs({ { LEFT_SLOTS, "TOPLEFT", 1 }, { RIGHT_SLOTS, "TOPRIGHT", -1 } }) do
		local slots, point, side = column[1], column[2], column[3]
		local previous
		for _, name in ipairs(slots) do
			local slot = _G[name]
			slot:ClearAllPoints()
			if previous then
				slot:SetPoint("TOP", previous, "BOTTOM", 0, -layout.slot_gap)
			else
				slot:SetPoint(point, pane, point, side * layout.slot_margin, layout.slot_top)
			end
			previous = slot
		end
	end

	-- the model's panel (its scene) between the slot columns
	local width, height = unpack(layout.model_size)
	local inset = layout.model_panel_inset
	local panel = CreateFrame("Frame", nil, _G.PaperDollFrame)
	panel:SetFrameLevel(_G.PaperDollFrame:GetFrameLevel())
	panel:SetPoint("TOP", pane, "TOP", 0, layout.model_top + inset)
	panel:SetSize(width + inset * 2, height + inset * 2)
	kit:StylePane(panel, true) -- (Diablo III's stone around your home city)
	panel.DiabolicContent = true
	self:AddScene(panel)
	-- the GearScore and average item level in its bottom, as the
	-- inspected one's (gearscore.lua)
	local score = _G.CharacterModelFrame:CreateFontString(nil, "OVERLAY")
	score:SetFontObject(self:GetDB("Blizzard").gearscore.font)
	score:SetPoint("BOTTOM", panel, "BOTTOM", 0, self:GetDB("Blizzard").gearscore.inspect_offset)
	self.Score = score
	-- the model's frame past the panel's top and bottom, as the dressing
	-- room's is past its picture: the client frames the character larger
	-- and lower in it, its feet on the scene's floor. Its mouse (turning it,
	-- dropping items on it) the panel's.
	local model = _G.CharacterModelFrame
	local up, down = unpack(layout.model_reach)
	model:ClearAllPoints()
	model:SetPoint("TOPLEFT", panel, "TOPLEFT", inset, up - inset)
	model:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -inset, inset - down)
	model:SetHitRectInsets(0, 0, up, down)
	local turn = _G.CharacterModelFrameRotateLeftButton
	turn:ClearAllPoints()
	turn:SetPoint("TOPLEFT", panel, "TOPLEFT", inset, -inset)
	-- the turning arrows only while the mouse is over the model
	local arrows = { turn, _G.CharacterModelFrameRotateRightButton }
	local shown
	panel:SetScript("OnUpdate", function()
		local over = MouseIsOver(panel) and true or false
		if (over ~= shown) then
			shown = over
			for _, arrow in ipairs(arrows) do
				arrow:SetAlpha(over and 1 or 0)
			end
		end
	end)

	-- (the resistances: the right column's, CreateColumn), the title's
	-- dropdown
	local titles = _G.PlayerTitleFrame
	titles:ClearAllPoints()
	titles:SetPoint("TOP", pane, "TOP", 0, layout.title_top)

	-- Blizzard's two stat columns out of sight: the right column has them
	local attributes = _G.CharacterAttributesFrame
	attributes:Hide()
	attributes:HookScript("OnShow", attributes.Hide)

	-- the weapons in a row at the bottom
	local main, off, ranged = _G.CharacterMainHandSlot, _G.CharacterSecondaryHandSlot, _G.CharacterRangedSlot
	main:ClearAllPoints()
	off:ClearAllPoints()
	ranged:ClearAllPoints()
	off:SetPoint("TOP", panel, "BOTTOM", 0, layout.weapon_top)
	main:SetPoint("TOPRIGHT", off, "TOPLEFT", -layout.weapon_gap, 0)
	ranged:SetPoint("TOPLEFT", off, "TOPRIGHT", layout.weapon_gap, 0)

	-- the ammo slot in the action buttons' border instead of its frame art
	local ammo = _G.CharacterAmmoSlot
	if ammo then
		for i = 1, select("#", ammo:GetRegions()) do
			local region = select(i, ammo:GetRegions())
			local file = region:IsObjectType("Texture") and region:GetTexture()
			if file and file:lower():find("ammoslot") then
				region:SetAlpha(0)
			end
		end
		kit:AddBorder(ammo, layout.ammo_size)
	end

	-- the title picker as a dark panel, its hover bar red
	local picker = _G.PlayerTitlePickerFrame
	if picker then
		kit:StylePanel(picker)
		picker:SetBackdropColor(unpack(self.config.popup_color))
		for _, button in ipairs(_G.PlayerTitlePickerScrollFrame.buttons or {}) do
			local highlight = button:GetHighlightTexture()
			if highlight then
				highlight:SetVertexColor(unpack(self.config.popup_highlight_color))
			end
		end
	end

	self:CreateColumn(window)

	-- the window wide on this tab only
	_G.PaperDollFrame:HookScript("OnShow", function() self:SetWide(true) end)
	_G.PaperDollFrame:HookScript("OnHide", function() self:SetWide(false) end)
	self:SetWide(_G.PaperDollFrame:IsShown())
	_G.CharacterFrame:HookScript("OnShow", function() self:SetWide(_G.PaperDollFrame:IsShown()) end)
end

-- The window's size: wide for the character tab's two columns. Blizzard
-- opens the next window (talents, spellbook) right of it by the width it's
-- told.
Module.SetWide = function(self, wide)
	local insets = wide and self.config.paperdoll.wide_insets or self.config.insets
	local frame = _G.CharacterFrame
	local right = insets[3]
	self.Backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", right, -insets[4])
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + right)
	if frame:IsShown() then
		_G.UpdateUIPanelPositions(frame)
	end
end

-- The window dragged by its own stone too, where it reaches past
-- Blizzard's frame (the right column, the band), as BlizzMove drags it by
-- the tabs.
local Forward = function(script)
	return function()
		local handler = _G.PaperDollFrame:GetScript(script)
		if handler then
			handler(_G.PaperDollFrame)
		end
	end
end

Module.AddDrag = function(self, window)
	window:EnableMouse(true)
	window:RegisterForDrag("LeftButton")
	window:SetScript("OnDragStart", Forward("OnDragStart"))
	window:SetScript("OnDragStop", Forward("OnDragStop"))
end

-- A close button (or the equipment manager's) out of sight for good: the window has one.
local HideClose = function(button)
	if button then
		button:Hide()
		button:HookScript("OnShow", button.Hide)
	end
end

-- The right column in pages under its own tabs (Pretty GUI's sidebar):
-- the level (under the top one) and two groups of stats (the ones Blizzard's dropdowns
-- chose; a click on their title bar shows the next), the titles, the
-- equipment manager.
local STAT_PREFIX = "DiabolicUICharacterStats"
local STAT_CVARS = { "playerStatLeftDropdown", "playerStatRightDropdown" }

-- A section's title bar across `column`, `y` from its top.
local CreateSection = function(column, spec, y, text, kind)
	local header = CreateFrame(kind or "Frame", nil, column)
	header:SetHeight(spec.header_height)
	header:SetPoint("TOPLEFT", column, "TOPLEFT", spec.side_padding, y)
	header:SetPoint("TOPRIGHT", column, "TOPRIGHT", -spec.side_padding, y)
	local title = header:CreateFontString(nil, "OVERLAY")
	kit:StyleSection(header, title) -- (its font first: no text without one)
	title:SetText(text)
	header.title = title
	return header
end

Module.CreateColumn = function(self, window)
	local layout = self.config.paperdoll
	local spec = layout.stats
	local column = CreateFrame("Frame", nil, _G.PaperDollFrame)
	-- from the window, not the gear's column: anchored through it, the
	-- client placed it from the window's old place on the first opening
	column:SetPoint("TOPLEFT", window, "TOPLEFT", layout.pane_width + spec.left, spec.top)
	column:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -spec.right, spec.bottom)
	kit:StylePanel(column)
	column.DiabolicContent = true
	-- Diablo III's stats panel in it, inside its bronze line
	local art = column:CreateTexture(nil, "BACKGROUND")
	art:SetTexture(layout.stats_panel)
	art:SetPoint("TOPLEFT", layout.stats_panel_inset, -layout.stats_panel_inset)
	art:SetPoint("BOTTOMRIGHT", -layout.stats_panel_inset, layout.stats_panel_inset)
	local pages = self:CreatePages(column)

	-- the level in a pentagram's middle (Diablo III's banner sigil), the
	-- resistances on its five points (square, in the action buttons'
	-- border, their value in its corner); the stats under it
	local page = pages[1]
	local penta = spec.pentagram
	local star = CreateFrame("Frame", nil, page)
	star:SetSize(penta.size, penta.size)
	star:SetPoint("TOP", page, "TOP", 0, -spec.score_top)
	local sigil = star:CreateTexture(nil, "ARTWORK")
	sigil:SetTexture(penta.texture)
	sigil:SetVertexColor(unpack(penta.color))
	sigil:SetAllPoints()
	-- its shadow under it
	local shadow = star:CreateTexture(nil, "BORDER")
	shadow:SetTexture(penta.texture)
	shadow:SetVertexColor(unpack(penta.shadow_color))
	shadow:SetSize(penta.size, penta.size)
	shadow:SetPoint("CENTER", unpack(penta.shadow_offset))
	-- its red glow over it, beating like a heart
	local glow = star:CreateTexture(nil, "OVERLAY")
	glow:SetTexture(penta.texture)
	glow:SetVertexColor(unpack(penta.glow_color))
	glow:SetBlendMode("ADD")
	glow:SetPoint("CENTER")
	glow:SetSize(penta.size * penta.glow_scale, penta.size * penta.glow_scale)
	local low, high = unpack(penta.glow_alpha)
	local width = penta.glow_beat_width
	local elapsed = 0
	star:SetScript("OnUpdate", function(_, delta)
		elapsed = (elapsed + delta) % penta.glow_period
		-- the strongest beat under way, each a cosine's rise and fall
		local beat = 0
		for _, b in ipairs(penta.glow_beats) do
			local t = elapsed - b[1]
			if t >= 0 and t < width then
				beat = math_max(beat, b[2] * (1 - math_cos(t / width * 2 * math_pi)) / 2)
			end
		end
		glow:SetAlpha(low + (high - low) * beat)
	end)
	self.Level = star:CreateFontString(nil, "OVERLAY")
	self.Level:SetFont(unpack(layout.score_font))
	self.Level:SetTextColor(unpack(self.config.level_color))
	self.Level:SetShadowOffset(1, -1)
	self.Level:SetPoint("CENTER", star, "CENTER", 0, penta.level_y)
	local stats = CreateFrame("Frame", nil, page)
	stats:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -spec.score_top - penta.size - penta.below)
	stats:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", 0, 0)
	self.Stats = stats
	local size, crop = spec.resistance_size, spec.resistance_crop
	local reach = penta.size / 2 * penta.tip
	for i, angle in ipairs(penta.angles) do
		local resistance = _G["MagicResFrame" .. i]
		resistance:SetParent(star)
		resistance:SetFrameLevel(star:GetFrameLevel() + 1)
		resistance:SetSize(size, size)
		resistance:ClearAllPoints()
		resistance:SetPoint("CENTER", star, "CENTER", reach * math_cos(math_rad(angle)), reach * math_sin(math_rad(angle)))
		-- its school's icon without Blizzard's bevel
		for _, region in ipairs({ resistance:GetRegions() }) do
			if region:IsObjectType("Texture") then
				local left, top, _, bottom, right = region:GetTexCoord()
				local x, v = crop / 32 * (right - left), crop / 29 * (bottom - top)
				region:SetTexCoord(left + x, right - x, top + v, bottom - v)
				region:ClearAllPoints()
				region:SetAllPoints()
			end
		end
		kit:AddBorder(resistance, size)
		-- (over the border: on a frame of its own above it)
		local over = CreateFrame("Frame", nil, resistance)
		over:SetAllPoints()
		over:SetFrameLevel(resistance:GetFrameLevel() + 1)
		local value = _G["MagicResText" .. i]
		value:SetParent(over)
		value:SetFont(layout.stat_value_font[1], layout.stat_value_font[2], "OUTLINE")
		value:ClearAllPoints()
		value:SetPoint("BOTTOMRIGHT", resistance, "BOTTOMRIGHT", -2, 2)
	end
	local y = 0

	-- the stats, Blizzard's lines (StatFrameTemplate) filled by its own
	-- UpdatePaperdollStats each time it updates its two columns
	local titles = {}
	for g, cvar in ipairs(STAT_CVARS) do
		local section = CreateSection(stats, spec, y, "", "Button")
		section:SetScript("OnClick", function() self:NextStats(cvar) end)
		titles[g] = section.title
		for i = 1, 6 do
			local line = CreateFrame("Frame", STAT_PREFIX .. g .. i, stats, "StatFrameTemplate")
			local top = -spec.header_gap - (i - 1) * spec.line_height
			line:SetPoint("TOPLEFT", section, "BOTTOMLEFT", spec.line_inset, top)
			line:SetPoint("TOPRIGHT", section, "BOTTOMRIGHT", -spec.line_inset, top)
			local label, value = _G[line:GetName() .. "Label"], _G[line:GetName() .. "StatText"]
			label:SetFont(unpack(layout.stat_label_font))
			label:SetTextColor(unpack(layout.stat_label_color))
			value:SetFont(unpack(layout.stat_value_font))
		end
		y = y - spec.header_height - spec.header_gap - 6 * spec.line_height - spec.group_gap
	end
	hooksecurefunc("PaperDollFrame_UpdateStats", function()
		for g, cvar in ipairs(STAT_CVARS) do
			local category = GetCVar(cvar)
			if _G[category] then
				titles[g]:SetText(_G[category])
				_G.UpdatePaperdollStats(STAT_PREFIX .. g, category)
			end
		end
	end)

	self:CreateTitles(pages[2])

	-- the equipment manager on its own page
	if _G.GearManagerDialog then
		-- "Equipment Sets", the client's words (its tooltips' "...: %s")
		local title = _G.EQUIPMENT_SETS:match("^(.-)%s*:") or _G.EQUIPMENT_MANAGER
		local header = CreateSection(pages[3], spec, -spec.score_top, title)
		self:EmbedGearManager(header, pages[3])
	end

	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdateScore")
	_G.PaperDollFrame:HookScript("OnShow", function() self:UpdateScore() end)
end

-- The column's tabs (stats, titles, sets) in a row at its top, WoW's art
-- on them (the portrait, an achievement's shield, crossed swords), their names
-- in a tooltip, and a page under them for each, the stats' shown first;
-- the pages returned.
local PAGES = { "Stats", "Titles", "Sets" }
Module.CreatePages = function(self, column)
	local layout = self.config.paperdoll
	local spec, stats = layout.sidebar, layout.stats
	local pages, tabs = {}, {}
	local below = stats.padding + spec.top + spec.tab_height
	local Show = function(chosen)
		for i, page in ipairs(pages) do
			if (i == chosen) then
				page:Show()
				tabs[i]:Disable()
			else
				page:Hide()
				tabs[i]:Enable()
			end
			kit:UpdateTab(tabs[i])
			-- (the others' icons grey and dimmed, the chosen one in colour)
			local shade = (i == chosen) and 1 or spec.icon_dim
			tabs[i].Icon:SetVertexColor(shade, shade, shade)
			tabs[i].Icon:SetDesaturated(i ~= chosen)
		end
	end
	for i, name in ipairs(PAGES) do
		local tab = CreateFrame("Button", "DiabolicUICharacterSideTab" .. i, column)
		tab:SetSize(spec.tab_width, spec.tab_height)
		tab:SetScript("OnClick", function()
			PlaySound("igCharacterInfoTab")
			Show(i)
		end)
		kit:StyleTab(tab, {})
		-- WoW's art with no background of its own (the stats': the
		-- character's portrait)
		local art = spec.icons[i]
		local icon = tab:CreateTexture(nil, "OVERLAY")
		if art.portrait then
			SetPortraitTexture(icon, "player")
			_G.PaperDollFrame:HookScript("OnShow", function() SetPortraitTexture(icon, "player") end)
		else
			icon:SetTexture(art.texture)
			icon:SetTexCoord(unpack(art.coords))
		end
		icon:SetSize(unpack(art.size))
		icon:SetPoint("CENTER")
		tab.Icon = icon
		tab:SetScript("OnEnter", function()
			GameTooltip:SetOwner(tab, "ANCHOR_TOP")
			GameTooltip:SetText(L[name])
			GameTooltip:Show()
		end)
		tab:SetScript("OnLeave", function() GameTooltip:Hide() end)
		tabs[i] = tab
		local page = CreateFrame("Frame", nil, column)
		page:SetPoint("TOPLEFT", 0, -below - spec.gap)
		page:SetPoint("BOTTOMRIGHT", 0, stats.padding)
		pages[i] = page
	end
	-- the middle tab in the column's middle, the others beside it
	tabs[2]:SetPoint("TOP", column, "TOP", 0, -stats.padding - spec.top)
	tabs[1]:SetPoint("RIGHT", tabs[2], "LEFT", -spec.tab_gap, 0)
	tabs[3]:SetPoint("LEFT", tabs[2], "RIGHT", spec.tab_gap, 0)
	Show(1)
	return pages
end

-- The titles the character knows in a list on `page` ("None" first), the
-- worn one checked; a click wears it. Blizzard's dropdown for them out of
-- sight.
Module.CreateTitles = function(self, page)
	local spec = self.config.paperdoll.titles
	local side = self.config.paperdoll.stats.side_padding
	local dropdown = _G.PlayerTitleFrame
	if dropdown then
		dropdown:Hide()
		dropdown:HookScript("OnShow", dropdown.Hide)
	end
	local scroll = CreateFrame("ScrollFrame", "DiabolicUICharacterTitles", page, "UIPanelScrollFrameTemplate")
	scroll:SetPoint("TOPLEFT", side, -spec.top)
	scroll:SetPoint("BOTTOMRIGHT", -side - spec.bar_room, spec.bottom)
	-- on a parchment, in ink (the one worn in red ink)
	kit:AddParchment(scroll, spec.parchment_insets, "page", page)
	local list = CreateFrame("Frame", nil, scroll)
	list:SetSize(1, 1)
	scroll:SetScrollChild(list)
	local rows = {}
	local Update
	local Row = function(i)
		local row = rows[i]
		if not row then
			row = CreateFrame("Button", nil, list)
			row:SetHeight(spec.row_height)
			row:SetPoint("TOPLEFT", 0, -(i - 1) * spec.row_height)
			row:SetPoint("RIGHT", scroll, "RIGHT")
			local lit = row:CreateTexture(nil, "HIGHLIGHT")
			lit:SetTexture([[Interface\QuestFrame\UI-QuestTitleHighlight]])
			lit:SetBlendMode("ADD")
			lit:SetVertexColor(unpack(self.config.popup_highlight_color))
			lit:SetAllPoints()
			local check = row:CreateTexture(nil, "ARTWORK")
			check:SetTexture([[Interface\Buttons\UI-CheckBox-Check]])
			check:SetSize(spec.row_height, spec.row_height)
			check:SetPoint("LEFT")
			local text = row:CreateFontString(nil, "OVERLAY")
			text:SetFont(unpack(spec.font))
			text:SetPoint("LEFT", check, "RIGHT", 2, 0)
			text:SetPoint("RIGHT")
			text:SetJustifyH("LEFT")
			row.check, row.text = check, text
			row:SetScript("OnClick", function()
				PlaySound("igMainMenuOptionCheckBoxOff")
				SetCurrentTitle(row.id)
				Update(row.id)
			end)
			rows[i] = row
		end
		return row
	end
	-- (`current`: the one just chosen, before the client tells of it)
	Update = function(current)
		current = current or GetCurrentTitle()
		local titles = {}
		for id = 1, GetNumTitles() do
			if (IsTitleKnown(id) ~= 0) then
				titles[#titles + 1] = { id = id, name = GetTitleName(id):match("^%s*(.-)%s*$") }
			end
		end
		table_sort(titles, function(a, b) return a.name < b.name end)
		table_insert(titles, 1, { id = -1, name = _G.NONE })
		for i, title in ipairs(titles) do
			local row = Row(i)
			local worn = (title.id == current) or ((title.id == -1) and (current <= 0))
			row.id = title.id
			row.text:SetText(title.name)
			row.text:SetTextColor(unpack(worn and spec.worn_color or spec.color))
			if worn then
				row.check:Show()
			else
				row.check:Hide()
			end
			row:Show()
		end
		for i = #titles + 1, #rows do
			rows[i]:Hide()
		end
		list:SetSize(scroll:GetWidth(), #titles * spec.row_height)
	end
	page:HookScript("OnShow", function() Update() end)
end

-- The next group of stats in a section (Blizzard's dropdowns' list).
Module.NextStats = function(self, cvar)
	local options = _G.PLAYERSTAT_DROPDOWN_OPTIONS
	local current, nextOption = GetCVar(cvar), options[1]
	for i, option in ipairs(options) do
		if (option == current) then
			nextOption = options[i % #options + 1]
		end
	end
	SetCVar(cvar, nextOption)
	_G.PaperDollFrame_UpdateStats()
end

Module.UpdateScore = function(self)
	if not _G.PaperDollFrame:IsVisible() then
		return
	end
	-- the level, in the pentagram's middle
	self.Level:SetText(UnitLevel("player"))
	local gearScore = Engine:GetModule("Blizzard: GearScore")
	local score, level = gearScore:GetUnitScore("player")
	if score then
		self.Score:SetText(gearScore:FormatUnit(score, math_floor(level)))
	end
end

-- The pet tab's own tabs as ours (only the pet's is left: the companions
-- and mounts are in the spellbook, spellbook.lua).
Module.StyleCompanions = function(self)
	local config = self.config.companion
	for i = 1, 3 do
		local tab = _G["PetPaperDollFrameTab" .. i]
		if tab then
			kit:StyleTab(tab, { inset = config.tab_inset })
		end
	end
	-- centred over the panels, as Blizzard shows and places them
	hooksecurefunc("PetPaperDollFrame_UpdateTabs", function() self:CenterPetTabs() end)
	_G.PetPaperDollFrame:HookScript("OnShow", function() self:CenterPetTabs() end)
end

-- The pet tab's own tabs (pet, companions, mounts: those shown), in a row
-- centred over its panels.
Module.CenterPetTabs = function(self)
	local config = self.config.companion
	local shown, width = {}, 0
	for i = 1, 3 do
		local tab = _G["PetPaperDollFrameTab" .. i]
		if tab and tab:IsShown() then
			shown[#shown + 1] = tab
			width = width + tab:GetWidth()
		end
	end
	if (#shown == 0) then
		return
	end
	width = width + config.tab_gap * (#shown - 1)
	local x, y = unpack(config.tab_position)
	for i, tab in ipairs(shown) do
		tab:ClearAllPoints()
		if (i == 1) then
			tab:SetPoint("TOPLEFT", _G.PetPaperDollFrame, "TOP", x - width / 2, y)
		else
			tab:SetPoint("LEFT", shown[i - 1], "RIGHT", config.tab_gap, 0)
		end
	end
end

-- Blizzard's equipment manager in the right column under `header`, open
-- with the tab, its frame and button gone: its sets in rows, its buttons
-- ours. Its icon picker (saving a set) right of the window, a dark panel
-- like the title picker's.
Module.EmbedGearManager = function(self, header, column)
	local spec = self.config.paperdoll.gear_manager
	local dialog = _G.GearManagerDialog
	kit:HideTextures(dialog)
	dialog.title:Hide()
	HideClose(_G.GearManagerDialogClose)
	HideClose(_G.GearManagerToggleButton)
	-- in the column, at its scale (the client's patch may give it another
	-- parent)
	dialog:SetParent(column)
	dialog:SetScale(1)
	dialog:SetFrameStrata(column:GetFrameStrata())
	dialog:SetFrameLevel(column:GetFrameLevel() + 2)
	dialog:ClearAllPoints()
	dialog:SetPoint("TOPLEFT", header, "BOTTOMLEFT")
	dialog:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT")
	dialog:SetHeight(spec.height)

	-- the sets in rows, equip (larger: the one used most), save and delete
	-- (red) as icons in a column beside them, its first free set a "+" for
	-- a new one
	local equip, save, delete = _G.GearManagerDialogEquipSet, _G.GearManagerDialogSaveSet, _G.GearManagerDialogDeleteSet
	-- (placed with the sets, LayoutSets)
	self:IconButton(equip, 1, spec.equip)
	self:IconButton(save, 3, spec.save)
	self:IconButton(delete, 2, spec.delete)
	self.GearHeader, self.GearActions = header, { equip, save, delete }
	self:AddNewSet(dialog)

	local popup = _G.GearManagerDialogPopup
	if popup then
		kit:HideTextures(popup)
		kit:StylePanel(popup)
		popup:SetBackdropColor(unpack(self.config.popup_color))
		popup:ClearAllPoints()
		popup:SetPoint("TOPLEFT", self.Backdrop, "TOPRIGHT", unpack(self.config.gear_manager_offset))
		for _, button in ipairs({ _G.GearManagerDialogPopupOkay, _G.GearManagerDialogPopupCancel }) do
			kit:StyleButton(button, spec.popup_button_height)
		end
	end

	-- open with its page (when the manager is on in the game's options), a
	-- frame later: Blizzard closes it as a child window each time a window
	-- opens, this one included. Its sets laid out once it has a width.
	local opener = CreateFrame("Frame")
	opener:Hide()
	opener:SetScript("OnUpdate", function()
		if GetCVarBool("equipmentManager") then
			header:Show()
			if column:IsVisible() and (not dialog:IsShown()) then
				dialog:Show()
			end
		else
			header:Hide()
		end
		if (not dialog:IsVisible()) or self:LayoutSets() then
			opener:Hide()
		end
	end)
	-- (only on its page: open, it plays its sound and puts Blizzard's
	-- yellow arrows by the slots)
	column:HookScript("OnShow", function() opener:Show() end)
	column:HookScript("OnHide", function() dialog:Hide() end)
	hooksecurefunc("CloseChildWindows", function() opener:Show() end)
end

-- The equipment manager's sets in rows under its title bar (`rows`: how
-- many in each, the last as wide as the bar), the icons in a column in the
-- rows' room right of the shorter ones, the sets scaled to fill its width. Sized and
-- placed against the title bar, whatever scale the dialog gets (the
-- client's patch gives it its own); a scaled frame's offsets are in its own
-- scale. Nothing until they have a size (the frame after it shows): true
-- once done.
Module.LayoutSets = function(self)
	local spec = self.config.paperdoll.gear_manager
	local dialog, header = _G.GearManagerDialog, self.GearHeader
	local buttons, rows = dialog.buttons, spec.rows
	local size = buttons[1]:GetWidth()
	local room = header:GetWidth()
	local perRow = 0
	for _, count in ipairs(rows) do
		perRow = math_max(perRow, count)
	end
	local row = perRow * size + (perRow - 1) * spec.set_gap
	if (room <= 0) or (size <= 0) then
		return
	end
	local ratio = header:GetEffectiveScale() / dialog:GetEffectiveScale()
	local fit = room / row
	local left = (room - row * fit) / 2
	-- each row under the one above's first; past `rows`, as many as its last
	local r, first, count = 1, 1, rows[1]
	for i, button in ipairs(buttons) do
		button:SetScale(fit * ratio)
		button:ClearAllPoints()
		if (i == 1) then
			button:SetPoint("TOPLEFT", header, "BOTTOMLEFT", left / fit, -spec.top / fit)
		elseif (i - first == count) then
			button:SetPoint("TOP", buttons[first], "BOTTOM", 0, -spec.row_gap)
			r, first = r + 1, i
			count = rows[r] or rows[#rows]
		else
			button:SetPoint("LEFT", buttons[i - 1], "RIGHT", spec.set_gap, 0)
		end
	end
	-- the icons in the middle of the shorter rows' empty column
	local short = 0
	while rows[short + 1] and (rows[short + 1] < perRow) do
		short = short + 1
	end
	local icons = (#self.GearActions - 1) * spec.action_gap
	for _, button in ipairs(self.GearActions) do
		icons = icons + button:GetHeight()
	end
	local span = (math_max(short, 1) * size + (math_max(short, 1) - 1) * spec.row_gap) * fit
	local x = left + ((perRow - 1) * (size + spec.set_gap) + size / 2) * fit
	for i, button in ipairs(self.GearActions) do
		button:SetScale(ratio)
		button:ClearAllPoints()
		if (i == 1) then
			button:SetPoint("TOP", header, "BOTTOMLEFT", x, -spec.top - (span - icons) / 2)
		else
			button:SetPoint("TOP", self.GearActions[i - 1], "BOTTOM", 0, -spec.action_gap)
		end
	end
	-- as high as its rows need
	local total, used = 0, 0
	while (used < #buttons) do
		total = total + 1
		used = used + (rows[total] or rows[#rows])
	end
	local height = spec.top + (total * size + (total - 1) * spec.row_gap) * fit + spec.names_height
	dialog:SetHeight(height)
	return true
end

-- An icon of the equipment manager's sheet (new, equip, delete, save).
Module.SetGearIcon = function(self, texture, index)
	local spec = self.config.paperdoll.gear_manager
	texture:SetTexture(spec.icons)
	texture:SetTexCoord(index / spec.icon_count, (index + 1) / spec.icon_count, 0, 1)
end

-- One of the equipment manager's buttons as a square with an icon (`look`:
-- its size, its icon's, the icon's color), its text in a tooltip, the icon
-- faded while it's disabled.
Module.IconButton = function(self, button, index, look)
	local text = button:GetText()
	button:SetText("")
	button:SetSize(look.size, look.size)
	button:ClearAllPoints()
	kit:StyleButton(button, look.size)
	local icon = button:CreateTexture(nil, "OVERLAY")
	icon:SetSize(look.icon_size, look.icon_size)
	icon:SetPoint("CENTER")
	self:SetGearIcon(icon, index)
	if look.color then
		icon:SetVertexColor(unpack(look.color))
	end
	local update = function()
		icon:SetDesaturated(button:IsEnabled() == 0)
		icon:SetAlpha((button:IsEnabled() == 0) and .4 or 1)
	end
	hooksecurefunc(button, "Enable", update)
	hooksecurefunc(button, "Disable", update)
	update()
	button:HookScript("OnEnter", function()
		GameTooltip:SetOwner(button, "ANCHOR_TOP")
		GameTooltip:SetText(text)
		GameTooltip:Show()
	end)
	button:HookScript("OnLeave", function() GameTooltip:Hide() end)
end

-- The first free set as a "+": a click names a new one (Blizzard's save,
-- with no set chosen).
Module.AddNewSet = function(self, dialog)
	local update = function()
		for i, button in ipairs(dialog.buttons) do
			button.icon:SetTexCoord(0, 1, 0, 1)
			button.DiabolicNew = nil
		end
		local free = dialog.buttons[GetNumEquipmentSets() + 1]
		if free then
			free:Enable()
			self:SetGearIcon(free.icon, 0)
			free.DiabolicNew = true
		end
	end
	hooksecurefunc("GearManagerDialog_Update", update)
	for _, button in ipairs(dialog.buttons) do
		button:HookScript("OnClick", function()
			if button.DiabolicNew then
				dialog.selectedSetName = nil
				_G.GearManagerDialog_Update()
				_G.GearManagerDialogPopupEditBox:SetText("")
				_G.GearManagerDialogSaveSet_OnClick(_G.GearManagerDialogSaveSet)
			end
		end)
		button:HookScript("OnEnter", function()
			if button.DiabolicNew then
				GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
				GameTooltip:SetText(L["New Equipment Set"])
				GameTooltip:Show()
			end
		end)
	end
	update()
end

-- The selected skill's details in a panel, so the place reads as theirs
-- while none is chosen.
Module.StyleSkills = function(self)
	local details = _G.SkillDetailScrollFrame
	if details then
		local insets = self.config.skill_detail_insets
		local panel = CreateFrame("Frame", nil, _G.SkillFrame)
		panel:SetFrameLevel(_G.SkillFrame:GetFrameLevel())
		panel:SetPoint("TOPLEFT", details, "TOPLEFT", -insets[1], insets[2])
		panel:SetPoint("BOTTOMRIGHT", details, "BOTTOMRIGHT", insets[3], -insets[4])
		kit:StylePanel(panel)
	end
end

-- the tabs' "Close" buttons at their bottom
local CLOSE_BUTTONS = { "SkillFrameCancelButton", "PetPaperDollCloseButton" }

-- The currency tab: its close buttons (the X and the "Close" one) gone,
-- your money under the list's right end.
Module.StyleTokens = function(self)
	local frame = _G.TokenFrame
	self:HidePanelArt(frame)
	self:CenterTab(frame)
	local money = _G.TokenFrameMoneyFrame
	if money then
		money:ClearAllPoints()
		money:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", unpack(self.config.token_money_offset))
	end
	HideClose(_G.TokenFrameCancelButton)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if (not child:GetName()) and child:IsObjectType("Button") then
			HideClose(child)
		end
	end
	kit:StyleScrollBars(frame)
	self:StyleTokenPopup()
end

-- A currency's options (their popup) as the equipment manager's: a dark
-- panel right of the window, under its tabs, the windows' X, our boxes.
Module.StyleTokenPopup = function(self)
	local config = self.config
	local popup = _G.TokenFramePopup
	if (not popup) or popup.DiabolicStyled then
		return
	end
	popup.DiabolicStyled = true
	kit:HideTextures(popup)
	kit:StylePanel(popup)
	popup:SetBackdropColor(unpack(config.popup_color))
	popup:ClearAllPoints()
	popup:SetPoint("TOPLEFT", self.Backdrop, "TOPRIGHT", unpack(config.token_popup_offset))
	_G.TokenFramePopupTitle:SetTextColor(unpack(kit.config.title_plate.color))
	local close = _G.TokenFramePopupCloseButton
	kit:SkinClose(close)
	close:ClearAllPoints()
	close:SetPoint("TOPRIGHT", popup, "TOPRIGHT", -config.token_popup_close, -config.token_popup_close)
	local unused, backpack = _G.TokenFramePopupInactiveCheckBox, _G.TokenFramePopupBackpackCheckBox
	for _, box in ipairs({ unused, backpack }) do
		kit:StyleCheckBox(box)
	end
	-- apart (Blizzard's overlap their art's empty edges, ours have none)
	backpack:ClearAllPoints()
	backpack:SetPoint("TOPLEFT", unused, "BOTTOMLEFT", 0, -config.token_popup_box_gap)
end

-- `unit`'s home city's art (DressUpTexturePath's, for any unit).
local HomePath = function(unit)
	local _, race = UnitRace(unit)
	local key = race and race:upper()
	if (key == "GNOME") then
		race = "Dwarf"
	elseif (key == "TROLL") or (not key) then
		race = "Orc"
	end
	return [[Interface\DressUpFrame\DressUpBackground-]] .. race
end

-- Your home city in `panel` (`path`'s, yours by default), inside its
-- bronze line, dimmed under the model; the scene returned.
Module.AddScene = function(self, panel, path)
	local config = self.config
	path = path or (_G.DressUpTexturePath and _G.DressUpTexturePath())
	if not path then
		return
	end
	local inset = config.scene_inset
	local scene = CreateFrame("Frame", nil, panel)
	scene:SetPoint("TOPLEFT", inset, -inset)
	scene:SetPoint("BOTTOMRIGHT", -inset, inset)
	local top = panel:CreateTexture(nil, "BACKGROUND")
	top:SetTexture(path .. 1)
	top:SetPoint("TOPLEFT", scene)
	top:SetPoint("TOPRIGHT", scene)
	local bottom = panel:CreateTexture(nil, "BACKGROUND")
	bottom:SetTexture(path .. 3)
	bottom:SetPoint("BOTTOMLEFT", scene)
	bottom:SetPoint("BOTTOMRIGHT", scene)
	for _, texture in ipairs({ top, bottom }) do
		texture:SetVertexColor(unpack(config.scene_color))
	end
	scene.Top, scene.Bottom = top, bottom
	scene:SetScript("OnSizeChanged", LayoutScene)
	LayoutScene(scene)
	return scene
end

-- The inspected's model in a pane with their home city behind it, as
-- yours (each time the window shows someone).
Module.StyleInspect = function(self)
	local model = _G.InspectModelFrame
	if (not model) or self.InspectScene then
		return
	end
	local inset = self.config.paperdoll.model_panel_inset
	local frame = _G.InspectPaperDollFrame
	local panel = CreateFrame("Frame", nil, frame)
	panel:SetFrameLevel(frame:GetFrameLevel())
	panel:SetPoint("TOPLEFT", model, "TOPLEFT", -inset, inset)
	panel:SetPoint("BOTTOMRIGHT", model, "BOTTOMRIGHT", inset, -inset)
	kit:StylePane(panel, true)
	local scene = self:AddScene(panel, HomePath("player"))
	self.InspectScene = scene
	local Update = function()
		local unit = _G.InspectFrame.unit
		if unit then
			local path = HomePath(unit)
			scene.Top:SetTexture(path .. 1)
			scene.Bottom:SetTexture(path .. 3)
		end
	end
	frame:HookScript("OnShow", Update)
	hooksecurefunc("InspectFrame_UnitChanged", Update)

	-- the tree's art (its spec's, as Blizzard sets it) over the darker
	-- panel the list gets (panels.lua), under the talents
	local talents = _G.InspectTalentFrame
	local art = CreateFrame("Frame", nil, talents)
	art:SetAllPoints(talents)
	art:SetFrameLevel(talents:GetFrameLevel() + 1)
	for _, part in ipairs({ "TopLeft", "TopRight", "BottomLeft", "BottomRight" }) do
		local texture = _G["InspectTalentFrameBackground" .. part]
		if texture then
			texture:SetParent(art)
		end
	end
	-- the points under it on the stone, without Blizzard's frame (as yours)
	if _G.InspectTalentFramePointsBar then
		kit:HideTextures(_G.InspectTalentFramePointsBar)
	end
	-- the level line in Diablo III's capitals
	_G.InspectLevelText:SetFontObject(self.config.level_font)
	self:StyleInspectTrees()
end

-- The inspected one's talent trees (Blizzard's tabs) as their icons in the
-- action buttons' border, in a row over the tree's panel: the one shown
-- in color, the others grey, each one's name and points in its tooltip.
Module.StyleInspectTrees = function(self)
	local config = self.config.inspect_trees
	local talents = _G.InspectTalentFrame
	local tabs = {}
	for i = 1, 3 do
		local tab = _G["InspectTalentFrameTab" .. i]
		if tab then
			local name = tab:GetName()
			for _, part in ipairs({ "Left", "Middle", "Right", "LeftDisabled", "MiddleDisabled", "RightDisabled" }) do
				if _G[name .. part] then
					_G[name .. part]:SetAlpha(0)
				end
			end
			if tab:GetHighlightTexture() then
				tab:GetHighlightTexture():SetAlpha(0)
			end
			tab.DiabolicIcon = tab:CreateTexture(nil, "ARTWORK")
			tab.DiabolicIcon:SetAllPoints()
			tab.DiabolicIcon:SetTexCoord(.08, .92, .08, .92)
			kit:AddBorder(tab, config.size)
			tab:ClearAllPoints()
			if (i == 1) then
				tab:SetPoint("BOTTOMLEFT", _G.InspectTalentFrameScrollFrame, "TOPLEFT", unpack(config.offset))
			else
				tab:SetPoint("LEFT", tabs[i - 1], "RIGHT", config.gap, 0)
			end
			tab:HookScript("OnEnter", function()
				local tree, _, points = GetTalentTabInfo(i, talents.inspect, talents.pet, talents.talentGroup)
				if tree then
					_G.GameTooltip:SetOwner(tab, "ANCHOR_RIGHT")
					_G.GameTooltip:SetText(_G.MASTERY_POINTS_SPENT:format(tree, points))
				end
			end)
			tab:HookScript("OnLeave", function() _G.GameTooltip:Hide() end)
			tabs[i] = tab
		end
	end
	-- (Blizzard names and sizes them on each update: the names out of
	-- sight again, in the tooltips only)
	local Update = function()
		local shown = _G.PanelTemplates_GetSelectedTab(talents)
		for i, tab in ipairs(tabs) do
			local text = tab:GetFontString() or _G[tab:GetName() .. "Text"]
			if text then
				text:Hide()
			end
			tab:SetSize(config.size, config.size)
			local _, icon = GetTalentTabInfo(i, talents.inspect, talents.pet, talents.talentGroup)
			tab.DiabolicIcon:SetTexture(icon)
			tab.DiabolicIcon:SetDesaturated(i ~= shown)
		end
	end
	hooksecurefunc("InspectTalentFrame_UpdateTabs", Update)
	Update()
end

-- A faction's details (their popup) as the equipment manager's: a dark
-- panel right of the window, under its tabs, no parchment, the windows'
-- X in its corner, the text pale.
Module.StyleReputationDetail = function(self)
	local config = self.config
	local detail = _G.ReputationDetailFrame
	kit:HideTextures(detail)
	kit:StylePanel(detail)
	-- Diablo III's parchment inside its bronze line, its text in ink
	local page = detail:CreateTexture(nil, "BACKGROUND")
	page:SetTexture(kit.config.parchment)
	page:SetPoint("TOPLEFT", config.reputation_detail_inset, -config.reputation_detail_inset)
	page:SetPoint("BOTTOMRIGHT", -config.reputation_detail_inset, config.reputation_detail_inset)
	detail:ClearAllPoints()
	detail:SetPoint("TOPLEFT", self.Backdrop, "TOPRIGHT", unpack(config.reputation_detail_offset))
	-- no shadows (they blur dark ink), the description in the quests' font
	local ink = config.reputation_detail_ink
	local description = _G.ReputationDetailFactionDescription
	description:SetFontObject(_G.QuestFontLeft)
	for _, name in ipairs({ "ReputationDetailFactionName", "ReputationDetailFactionDescription", "ReputationDetailAtWarCheckBoxText",
		"ReputationDetailInactiveCheckBoxText", "ReputationDetailMainScreenCheckBoxText" }) do
		_G[name]:SetShadowColor(0, 0, 0, 0)
	end
	_G.ReputationDetailFactionName:SetTextColor(unpack(ink.title))
	description:SetTextColor(unpack(ink.text))
	-- the name centred on a red ribbon across their top edge, its tails
	-- past their sides, its shadow back (light text on the ribbon), the
	-- description under the ribbon
	local name, spec = _G.ReputationDetailFactionName, config.reputation_detail_ribbon
	name:ClearAllPoints()
	name:SetPoint("TOP", detail, "TOP", 0, -config.reputation_detail_name_top)
	-- wider than Blizzard's for the long names in Diablo III's capitals,
	-- the name clear of the X on both sides (to stay centred)
	local width = config.reputation_detail_width
	detail:SetWidth(width)
	description:SetWidth(width - config.reputation_detail_text_side * 2)
	name:SetWidth(width - config.reputation_detail_name_side * 2)
	name:SetSpacing(config.reputation_detail_name_spacing)
	name:SetJustifyH("CENTER")
	name:SetFont(unpack(config.reputation_detail_name_font))
	name:SetShadowColor(0, 0, 0, 1)
	description:ClearAllPoints()
	description:SetPoint("TOP", name, "BOTTOM", 0, -config.reputation_detail_name_gap)
	-- the ribbon and the name over the window's iron and its tab strip's
	-- pointed ends (+1): its left tail reaches over them; their X over it
	local holder = CreateFrame("Frame", nil, detail)
	holder:SetAllPoints(detail)
	name:SetParent(holder)
	local ribbon = holder:CreateTexture(nil, "BORDER")
	ribbon:SetTexture(spec.texture)
	ribbon:SetPoint("CENTER", name, "CENTER")
	ribbon:SetWidth(detail:GetWidth() + spec.overhang * 2)
	-- their X on the ribbon, at its right end
	local close = _G.ReputationDetailCloseButton
	kit:SkinClose(close)
	close:ClearAllPoints()
	close:SetPoint("RIGHT", ribbon, "RIGHT", -(spec.overhang + config.reputation_detail_close), 0)
	-- again as they show: the window's levels shift when it's raised,
	-- the ribbon left under their parchment
	local Raise = function()
		holder:SetFrameLevel(math_max(self.Backdrop.Border:GetFrameLevel(), detail:GetFrameLevel()) + 2)
		close:SetFrameLevel(holder:GetFrameLevel() + 1)
	end
	Raise()
	detail:HookScript("OnShow", Raise)
	-- the boxes' labels: Blizzard colors them on each update (red, its
	-- font's yellow or grey), drawn for its dark frame
	-- as tall as its text needs over the boxes (Blizzard's are anchored to
	-- its bottom), never shorter than Blizzard made it
	local height = detail:GetHeight()
	local Ink = function()
		local name = _G.ReputationDetailFactionName
		-- the faction's name in its standing's color, ours
		local _, _, standing, _, _, _, atWar = GetFactionInfo(GetSelectedFaction())
		name:SetTextColor(unpack(C.Reaction[standing] or ink.title))
		-- its ribbon bloodier the worse it is (at war as bloody as Hostile),
		-- more gilded the better
		if atWar and standing and standing > 2 then
			standing = 2
		end
		ribbon:SetTexture(spec.standings[standing] or spec.texture)
		local lines = name:GetStringHeight()
		ribbon:SetHeight((lines + spec.padding * 2) * spec.canvas)
		local text = config.reputation_detail_name_top + lines + config.reputation_detail_name_gap
			+ description:GetHeight() + config.reputation_detail_boxes
		detail:SetHeight(math_max(height, text))
		local war = _G.ReputationDetailAtWarCheckBox
		_G.ReputationDetailAtWarCheckBoxText:SetTextColor(unpack((war:IsEnabled() == 1) and ink.war or ink.off))
		for _, name in ipairs({ "ReputationDetailInactiveCheckBox", "ReputationDetailMainScreenCheckBox" }) do
			local box = _G[name]
			_G[name .. "Text"]:SetTextColor(unpack((box:IsEnabled() == 1) and ink.text or ink.off))
		end
	end
	Ink()
	hooksecurefunc("ReputationFrame_Update", Ink)
	hooksecurefunc("ReputationFrame_Update", function() self:ColorReputation() end)
end

-- The reputation bars in our standings' colors (Blizzard's on each update).
Module.ColorReputation = function(self)
	for i = 1, _G.NUM_FACTIONS_DISPLAYED do
		local row = _G["ReputationBar" .. i]
		if row:IsShown() and row.index then
			local color = C.Reaction[select(3, GetFactionInfo(row.index))]
			if color then
				_G["ReputationBar" .. i .. "ReputationBar"]:SetStatusBarColor(unpack(color))
			end
		end
	end
end

-- The other tabs, in the middle of the bigger window.
Module.CenterTab = function(self, frame)
	if frame then
		local x, y = unpack(self.config.content_offset)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", _G.CharacterFrame, "TOPLEFT", x, y)
		frame:SetPoint("BOTTOMRIGHT", _G.CharacterFrame, "BOTTOMRIGHT", x, y)
	end
end

Module.StyleCharacter = function(self)
	local config = self.config
	local frame = _G.CharacterFrame

	-- the window where the panel art was drawn, under the tabs' frames
	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "smoke")
	self.Backdrop = window
	self:AddDrag(window)
	for i, tab in ipairs(TABS) do
		self:HidePanelArt(_G[tab])
		if (i > 1) then
			self:CenterTab(_G[tab])
		end
	end

	-- the red band on top, the name (the pet's or the companions' on the
	-- pet tab) in the plate on the window's edge, no round portrait
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	_G.CharacterFramePortrait:SetAlpha(0)
	kit:SetTitle(self.Header, _G.CharacterNameText)
	if _G.PetNameText then
		kit:SetTitle(self.Header, _G.PetNameText)
	end
	-- no level line ("Level 80 Dwarf Priest") nor guild: the level's in
	-- the stats column under the top level
	_G.CharacterLevelText:SetAlpha(0)
	if _G.CharacterGuildText then
		_G.CharacterGuildText:SetAlpha(0)
	end

	-- the close button on the iron's corner, the band dropped (nothing in
	-- it) and Blizzard's frame up into its room (config.insets)
	if _G.CharacterFrameCloseButton then
		kit:StyleClose(_G.CharacterFrameCloseButton, window, self.Header)
	end
	kit:DropBand(self.Header)
	frame:SetAttribute("UIPanelLayout-yoffset", config.header_height)

	-- dark dropdowns
	for _, dropdown in ipairs(DROPDOWNS) do
		if _G[dropdown] then
			kit:StyleDropDown(_G[dropdown], config.dropdown_offsets[dropdown])
		end
	end

	-- the tabs as banners hanging from the window's foot (the pet's shown
	-- with a pet)
	local tabs = {}
	while _G["CharacterFrameTab" .. (#tabs + 1)] do
		tabs[#tabs + 1] = _G["CharacterFrameTab" .. (#tabs + 1)]
	end
	kit:HangTabs(window, tabs, config.tab_sigils)
	kit:DropTop(window)

	self:LayoutPaperDoll(window)
	self:StyleCompanions()
	self:StyleSkills()
	self:StyleReputationDetail()
	kit:StyleScrollBars(frame)
	for _, name in ipairs(CLOSE_BUTTONS) do
		HideClose(_G[name])
	end
	self:CreateSpec()
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "Blizzard_TokenUI") then
		self:StyleTokens()
	elseif (addon == "Blizzard_InspectUI") then
		self:StyleInspect()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").character
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleCharacter()
	if IsAddOnLoaded("Blizzard_TokenUI") then
		self:StyleTokens()
	end
	if IsAddOnLoaded("Blizzard_InspectUI") then
		self:StyleInspect()
	end
	self:RegisterEvent("ADDON_LOADED")
end
