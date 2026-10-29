-- Gives Blizzard's spellbook Diablo III's window (windows.lua), laid out as
-- Pretty GUI's: wide, the title in the plate over the red band, the tabs
-- in a row under it, an open book on its smoke: the spells in ink on
-- its two pages (six each, their names and ranks), the schools its red
-- ribbon bookmarks out past the window, the pages at its bottom; in the
-- band, a search box, the "all ranks" box and ours for the spells on no
-- action bar (their icons ringed) (the boxes' choices saved: the game's
-- own setting doesn't keep it). The companions and mounts move here
-- from the character window's pet tab, in two more tabs: the model in a
-- panel, the companions in three columns of four with their names,
-- Sholazar Basin painted behind them; a third for the professions
-- (spellbook-professions.lua). They're drawn on a cover over the spells, as
-- the spells found are (spellbook-search.lua): Blizzard's spell buttons are
-- secure, hiding them from here would taint the casts.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Spellbook", "LOW")

local kit
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local pairs = pairs
local select = select
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetActionInfo = _G.GetActionInfo
local GetCompanionInfo = _G.GetCompanionInfo
local GetMacroSpell = _G.GetMacroSpell
local GetNumSpellTabs = _G.GetNumSpellTabs
local GetSpellInfo = _G.GetSpellInfo
local GetSpellName = _G.GetSpellName
local GetSpellTabInfo = _G.GetSpellTabInfo
local GetSpellTexture = _G.GetSpellTexture
local GetNumCompanions = _G.GetNumCompanions
local HasPetUI = _G.HasPetUI
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local IsPassiveSpell = _G.IsPassiveSpell
local SetCVar = _G.SetCVar

local NUM_SPELLS = 12 -- SPELLS_PER_PAGE
local NUM_SCHOOLS = 8 -- MAX_SKILLLINE_TABS
local NUM_COMPANIONS = 12 -- NUM_COMPANIONS_PER_PAGE
local NUM_ACTIONS = 120 -- the action bars' slots, all their pages

-- the companions', mounts' and professions' tabs: their mode and title
local PAGES = { { "CRITTER", "COMPANIONS" }, { "MOUNT", "MOUNTS" }, { "PROFESSIONS", "TRADE_SKILLS" } }

-- A texture of `frame`'s own whose file matches `pattern`, out of sight.
local HideArt = function(frame, pattern)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		local file = region:IsObjectType("Texture") and region:GetTexture()
		if file and file:lower():find(pattern) then
			region:SetAlpha(0)
		end
	end
end

-- A dark slot behind `button`: the icon on its left, its name beside it.
local CreateSlot = function(parent, button, size, inset)
	local slot = CreateFrame("Frame", nil, parent)
	slot:SetFrameLevel(parent:GetFrameLevel())
	slot:SetPoint("LEFT", button, "LEFT", -inset, 0)
	slot:SetSize(size[1], size[2])
	kit:StylePanel(slot)
	return slot
end

-- The spells: Blizzard's buttons in two columns (theirs pair the first six
-- with the next six side by side: 1 and 7 are SpellButton1 and 2), each
-- in a slot, the action buttons' border instead of its own.
-- An open book behind the spells: Diablo III's lore book page twice, the
-- left one mirrored (their bound edges meet in the middle), a shadow in
-- the fold. On the window, over its smoke (a frame of its own at its
-- level could draw under it).
-- Its textures returned, on `owner` (the window's by default).
Module.CreateBook = function(self, window, owner)
	local config = self.config
	local x, y, width, height = unpack(config.book)
	local half = width / 2
	local book = {}
	owner = owner or window
	for side = 0, 1 do
		local page = owner:CreateTexture(nil, "ARTWORK")
		page:SetTexture(kit.config.parchment)
		page:SetPoint("TOPLEFT", window, "TOPLEFT", x + side * half, y)
		page:SetSize(half, height)
		page:SetTexCoord(1 - side, side, 0, 1)
		local fold = owner:CreateTexture(nil, "OVERLAY")
		fold:SetTexture([[Interface\Buttons\WHITE8X8]])
		fold:SetSize(config.fold_width, height)
		local dark = config.fold_alpha
		if (side == 0) then
			fold:SetPoint("TOPRIGHT", window, "TOPLEFT", x + half, y)
			fold:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, dark)
		else
			fold:SetPoint("TOPLEFT", window, "TOPLEFT", x + half, y)
			fold:SetGradientAlpha("HORIZONTAL", 0, 0, 0, dark, 0, 0, 0, 0)
		end
		book[#book + 1] = page
		book[#book + 1] = fold
	end
	return book
end

Module.LayoutSpells = function(self, window)
	local config = self.config
	local frame = _G.SpellBookFrame
	self.Book = self:CreateBook(window)
	local x, y = unpack(config.spells)
	for i = 1, NUM_SPELLS do
		local button = _G["SpellButton" .. i]
		local name = button:GetName()
		local row, column = math_floor((i - 1) / 2), (i - 1) % 2
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", window, "TOPLEFT",
			x + column * config.slot_pitch[1] + config.icon_inset,
			y - row * config.slot_pitch[2] - (config.slot_size[2] - button:GetHeight()) / 2)
		_G[name .. "Background"]:SetAlpha(0)
		_G[name .. "NormalTexture"]:SetAlpha(0)
		button.DiabolicBorder = kit:AddBorder(button, button:GetWidth())
		local ring, spec = button:CreateTexture(nil, "OVERLAY"), config.unassigned
		ring:SetTexture(spec.texture)
		ring:SetVertexColor(unpack(spec.color))
		ring:SetSize(button:GetWidth() * spec.scale, button:GetHeight() * spec.scale)
		ring:SetPoint("CENTER", button, "CENTER", 0, 0)
		ring:Hide()
		button.DiabolicUnassigned = ring
		local spell, rank = _G[name .. "SpellName"], _G[name .. "SubSpellName"]
		spell:SetFontObject(config.name_font)
		spell:SetWidth(config.name_width)
		rank:SetFontObject(config.rank_font)
		rank:SetTextColor(unpack(config.rank_color))
		rank:SetWidth(config.name_width)
		-- ink: no shadows (they blur it)
		spell:SetShadowColor(0, 0, 0, 0)
		rank:SetShadowColor(0, 0, 0, 0)
	end
	-- the name past the border, in ink (Blizzard puts back its place and
	-- its gold, or grey for the passive ones, each update)
	hooksecurefunc("SpellButton_UpdateButton", function(button)
		local spell = _G[button:GetName() .. "SpellName"]
		-- an empty one not drawn at all
		if _G[button:GetName() .. "IconTexture"]:IsShown() then
			button.DiabolicBorder:Show()
		else
			button.DiabolicBorder:Hide()
		end
		local _, _, _, _, top = spell:GetPoint()
		spell:SetPoint("LEFT", button, "RIGHT", config.name_offset, top or 0)
		local r = spell:GetTextColor()
		spell:SetTextColor(unpack((r < .9) and config.passive_color or kit.config.ink))
		self:UpdateUnassigned(button)
	end)

	-- the schools as the book's bookmarks: Diablo III's pennants pointing
	-- out past its right edge, red for the chosen one, each school's icon
	-- on its own over the pages' edge, in colour on the chosen one only
	x, y = unpack(config.schools)
	local size, ribbon = config.school_size, config.school_ribbon
	for i = 1, NUM_SCHOOLS do
		local tab = _G["SpellBookSkillLineTab" .. i]
		HideArt(tab, "spellbook%-skilllinetab")
		tab:SetSize(size, size)
		tab:ClearAllPoints()
		tab:SetPoint("TOPLEFT", window, "TOPLEFT", x, y - (i - 1) * (size + config.school_gap))
		kit:AddBorder(tab, size)
		local cloth = tab:CreateTexture(nil, "BACKGROUND")
		cloth:SetTexture(ribbon.texture)
		cloth:SetPoint("TOPLEFT", -ribbon.left, ribbon.pad)
		cloth:SetPoint("BOTTOMRIGHT", ribbon.right, -ribbon.pad)
		-- the others' icons grey and dimmed (after Blizzard sets them)
		local update = function()
			local chosen = tab:GetChecked() and true or false
			cloth:SetTexCoord(unpack(chosen and ribbon.chosen or ribbon.idle))
			local icon = tab:GetNormalTexture()
			if icon then
				icon:SetDesaturated(not chosen)
				icon:SetAlpha(chosen and 1 or config.school_idle_alpha)
			end
		end
		hooksecurefunc(tab, "SetChecked", update)
		update()
		local checked = tab:GetCheckedTexture()
		if checked then
			checked:SetAlpha(0) -- (the pennant says it)
		end
		-- over the window's iron, as a bookmark out of the book
		tab:SetFrameLevel(window.Border:GetFrameLevel() + 1)
	end

	-- the pages at the right of the book's foot
	local prev, nextPage, text = _G.SpellBookPrevPageButton, _G.SpellBookNextPageButton, _G.SpellBookPageText
	self:PlacePages(window, prev, nextPage, text)
	text:SetWidth(0)
	text:SetTextColor(unpack(kit.config.ink))
	text:SetShadowColor(0, 0, 0, 0)
	kit:StylePager(prev, nextPage)
	-- their "Prev" and "Next" out of sight
	for _, button in ipairs({ prev, nextPage }) do
		for i = 1, select("#", button:GetRegions()) do
			local region = select(i, button:GetRegions())
			if region:IsObjectType("FontString") then
				region:SetAlpha(0)
			end
		end
	end
end

-- A book's page buttons (`prev`, `nextPage`) at the right page's foot,
-- the page (`text`) between them, as the companions'.
Module.PlacePages = function(self, window, prev, nextPage, text)
	local config = self.config
	nextPage:ClearAllPoints()
	nextPage:SetPoint("RIGHT", window, "TOPRIGHT", config.next_x, config.pages_y)
	text:ClearAllPoints()
	text:SetPoint("RIGHT", nextPage, "LEFT", -config.page_gap, 0)
	prev:ClearAllPoints()
	prev:SetPoint("RIGHT", text, "LEFT", -config.page_gap, 0)
end

-- In the band right of the search (spellbook-search.lua): Blizzard's "all
-- ranks" box, then ours for the spells on no action bar (their labels
-- short, their tooltips say it all), over the band.
Module.PlaceBoxes = function(self)
	local config = self.config
	local ranks, label = _G.ShowAllSpellRanksCheckBox, _G.ShowAllSpellRanksCheckBoxText
	kit:StyleCheckBox(ranks)
	label:SetText(L["All ranks"])
	ranks:HookScript("OnClick", function() self.db.showAllRanks = ranks:GetChecked() and true or false end)
	ranks:HookScript("OnEnter", function()
		_G.GameTooltip:SetOwner(ranks, "ANCHOR_RIGHT")
		_G.GameTooltip:SetText(_G.SHOW_ALL_SPELL_RANKS)
	end)
	ranks:HookScript("OnLeave", function() _G.GameTooltip:Hide() end)
	local unassigned = self:CreateUnassignedBox()
	kit:LineBand(self.Header, { self.SearchBox, ranks, unassigned })
	for _, box in ipairs({ ranks, unassigned }) do
		box:SetFrameLevel(self.Header:GetFrameLevel() + 1)
	end
end

-- Our box for the spells on no action bar, as Blizzard's "all ranks" one.
-- The box returned.
Module.CreateUnassignedBox = function(self)
	local box = CreateFrame("CheckButton", "DiabolicUISpellBookUnassignedBox", _G.SpellBookFrame, "OptionsCheckButtonTemplate")
	kit:StyleCheckBox(box)
	_G[box:GetName() .. "Text"]:SetText(L["Unassigned"])
	box:SetChecked(self.db.showUnassigned)
	box:SetScript("OnClick", function()
		self.db.showUnassigned = box:GetChecked() and true or false
		self:UpdateAllUnassigned()
	end)
	box:SetScript("OnEnter", function()
		_G.GameTooltip:SetOwner(box, "ANCHOR_RIGHT")
		_G.GameTooltip:SetText(L["Show unassigned spells"])
		_G.GameTooltip:AddLine(L["Rings the spells you can cast that are on none of your action bars."], 1, 1, 1, true)
		_G.GameTooltip:Show()
	end)
	box:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
	self.UnassignedBox = box
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "ForgetAssigned")
	return box
end

-- The spells on the action bars, by name (their own or their macros'),
-- read again once one changes.
Module.GetAssigned = function(self)
	if (not self.Assigned) then
		local assigned = {}
		for slot = 1, NUM_ACTIONS do
			local kind, id, _, spellID = GetActionInfo(slot)
			local name
			if (kind == "spell") then
				name = (spellID and GetSpellInfo(spellID)) or GetSpellName(id, _G.BOOKTYPE_SPELL)
			elseif (kind == "macro") then
				name = GetMacroSpell(id)
			end
			if name then
				assigned[name] = true
			end
		end
		self.Assigned = assigned
	end
	return self.Assigned
end

Module.ForgetAssigned = function(self)
	self.Assigned = nil
	if _G.SpellBookFrame:IsShown() then
		self:UpdateAllUnassigned()
	end
end

-- `button`'s spell ringed while it's on no action bar (and the box is
-- checked): the player's spells only, not the passive ones.
Module.UpdateUnassigned = function(self, button)
	local ring = button.DiabolicUnassigned
	local bookType = _G.SpellBookFrame.bookType
	local show = false
	if self.db.showUnassigned and (bookType == _G.BOOKTYPE_SPELL) and _G[button:GetName() .. "IconTexture"]:IsShown() then
		-- (Blizzard's own checks: a slot past the tab's end, or empty, while
		-- the tab or the ranks shown change, isn't a spell; nor one past the
		-- book's end, while a spell is learned or unlearned)
		local id, displayID = _G.SpellBook_GetSpellID(button:GetID())
		local _, _, offset, count = GetSpellTabInfo(_G.SpellBookFrame.selectedSkillLine or 1)
		local _, _, lastOffset, lastCount = GetSpellTabInfo(GetNumSpellTabs())
		local total = (lastOffset or 0) + (lastCount or 0)
		local texture = id and displayID and (id > 0) and (id <= total)
			and (displayID <= (offset or 0) + (count or 0)) and GetSpellTexture(id, bookType)
		local name = texture and (texture ~= "") and GetSpellName(id, bookType)
		show = name and (not IsPassiveSpell(id, bookType)) and (not self:GetAssigned()[name]) and true or false
	end
	if show then
		ring:Show()
	else
		ring:Hide()
	end
end

Module.UpdateAllUnassigned = function(self)
	for i = 1, NUM_SPELLS do
		self:UpdateUnassigned(_G["SpellButton" .. i])
	end
end

-- The companions', mounts' and professions' tabs after Blizzard's, all as
-- banners hanging from the window's foot, the one shown chosen.
Module.CreateTabs = function(self, window)
	local frame = _G.SpellBookFrame
	self.Tabs = {}
	for i, page in ipairs(PAGES) do
		local tab = CreateFrame("Button", "DiabolicUISpellBookTab" .. page[1], frame)
		tab:SetFrameLevel(frame:GetFrameLevel() + 2)
		tab:SetNormalFontObject(kit.config.tab.font)
		tab:SetText(_G[page[2]])
		tab:SetScript("OnClick", function() self:ShowPage(page[1]) end)
		tab.mode = page[1]
		self.Tabs[i] = tab
	end
	local tabs = {}
	for i = 1, 3 do
		tabs[#tabs + 1] = _G["SpellBookFrameTabButton" .. i]
	end
	for _, tab in ipairs(self.Tabs) do
		tabs[#tabs + 1] = tab
	end
	kit:HangTabs(window, tabs, self.config.tab_sigils)
	kit:DropTop(window)
	-- over Blizzard's chosen tab while a page shows: a click goes back to
	-- the spells (Blizzard's own would close the spellbook)
	local back = CreateFrame("Button", nil, frame)
	back:SetFrameLevel(frame:GetFrameLevel() + 5)
	back:Hide()
	back:SetScript("OnClick", function() self:ShowPage(nil) end)
	back:SetScript("OnEnter", function()
		if back.tab then
			back.tab:LockHighlight()
			kit:ShowBannerName(back.tab)
		end
	end)
	back:SetScript("OnLeave", function()
		if back.tab then
			back.tab:UnlockHighlight()
		end
		_G.GameTooltip:Hide()
	end)
	back:SetHitRectInsets(0, 0, kit.config.banner.tuck, 0) -- as the banner under it
	self.Back = back
end

-- Whether a page's tab shows: companions or mounts known, professions.
Module.HasPage = function(self, mode)
	if (mode == "PROFESSIONS") then
		return self:HasProfessions()
	end
	return GetNumCompanions(mode) > 0
end

-- The tabs (Blizzard's shown ones, then ours: they hang in that order),
-- the chosen one lit (the spells' while spells found show).
Module.UpdateTabs = function(self)
	local frame = _G.SpellBookFrame
	local page = (self.page ~= "SEARCH") and self.page
	local active
	for i = 1, 3 do
		local tab = _G["SpellBookFrameTabButton" .. i]
		if tab and tab:IsShown() then
			if (tab.bookType == frame.bookType) then
				active = tab
				-- unchosen while a page shows; Blizzard disables the chosen one
				if page then
					tab:Enable()
				else
					tab:Disable()
				end
			end
			kit:UpdateTab(tab)
		end
	end
	for _, tab in ipairs(self.Tabs) do
		if self:HasPage(tab.mode) then
			tab:Show()
		else
			tab:Hide()
		end
		if (page == tab.mode) then
			tab:Disable()
		else
			tab:Enable()
		end
		kit:UpdateTab(tab)
	end
	local back = self.Back
	if page and active then
		back.tab = active
		back:ClearAllPoints()
		back:SetAllPoints(active)
		back:Show()
	else
		back:Hide()
	end
	-- the page's title in the plate
	if page then
		for _, spec in ipairs(PAGES) do
			if (spec[1] == page) then
				_G.SpellBookTitleText:SetText(_G[spec[2]])
			end
		end
	end
end

-- Blizzard's companions frame on the cover: the model in a stone pane, its
-- buttons in three columns with their names, the pages at the bottom.
Module.LayoutCompanions = function(self, cover)
	local config = self.config
	local frame = _G.PetPaperDollFrameCompanionFrame
	frame:SetParent(cover)
	frame:ClearAllPoints()
	frame:SetAllPoints(cover)
	kit:HideTextures(frame)

	local box = config.model_panel
	local panel = CreateFrame("Frame", nil, frame)
	local slots = { panel }
	panel:SetPoint("TOP", frame, "TOP", box[1], box[2])
	panel:SetSize(box[3], box[4])
	kit:StylePane(panel) -- (Diablo III's stone behind the companion)
	local model = _G.CompanionModelFrame
	model:ClearAllPoints()
	model:SetPoint("TOPLEFT", panel, "TOPLEFT", config.model_inset, -config.model_inset)
	model:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -config.model_inset, config.model_inset)
	-- the chosen one's name in Exocet, in the title's gold, in the band's
	-- middle (on the cover: shown with the companions' pages)
	local name = _G.CompanionSelectedName
	name:SetFontObject(config.selected_name_font)
	name:SetTextColor(unpack(kit.config.title_plate.color))
	name:SetJustifyH("CENTER")
	name:ClearAllPoints()
	name:SetPoint("CENTER", self.Header, "CENTER", 0, 0)
	-- under it, at the model's foot: Summon (Mount on the mounts' page)
	-- in the middle, the turning arrows in the corners on either side
	local gap = config.summon_bottom
	local left, right = _G.CompanionModelFrameRotateLeftButton, _G.CompanionModelFrameRotateRightButton
	left:ClearAllPoints()
	left:SetPoint("BOTTOMLEFT", model, "BOTTOMLEFT", gap, gap)
	right:ClearAllPoints()
	right:SetPoint("BOTTOMRIGHT", model, "BOTTOMRIGHT", -gap, gap)
	local summon = _G.CompanionSummonButton
	summon:SetSize(unpack(config.summon_size))
	kit:StyleButton(summon, config.summon_size[2])
	summon:ClearAllPoints()
	summon:SetPoint("BOTTOM", model, "BOTTOM", 0, gap + (left:GetHeight() - config.summon_size[2]) / 2)
	-- over the model: a model draws over every frame of its strata,
	-- whatever their levels (a drake's wings over them)
	for _, button in ipairs({ summon, left, right }) do
		button:SetFrameStrata("HIGH")
	end

	local x, y = unpack(config.companions)
	self.CompanionNames, self.CompanionSlots = {}, {}
	for i = 1, NUM_COMPANIONS do
		local button = _G["CompanionButton" .. i]
		local row, column = math_floor((i - 1) / 3), (i - 1) % 3
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", frame, "TOPLEFT",
			x + column * config.companion_pitch[1] + config.icon_inset,
			y - row * config.companion_pitch[2] - (config.companion_slot_size[2] - button:GetHeight()) / 2)
		local slot = CreateSlot(frame, button, config.companion_slot_size, config.icon_inset)
		slots[#slots + 1] = slot
		local empty = button:GetDisabledTexture()
		if empty then
			empty:SetAlpha(0)
		end
		slot.border = kit:AddBorder(button, button:GetWidth())
		self.CompanionSlots[i] = slot
		local label = button:CreateFontString(nil, "OVERLAY")
		label:SetFontObject(config.name_font)
		label:SetJustifyH("LEFT")
		label:SetWidth(config.companion_name_width)
		label:SetPoint("LEFT", button, "RIGHT", config.name_offset, 0)
		self.CompanionNames[i] = label
	end
	hooksecurefunc("PetPaperDollFrame_UpdateCompanions", function() self:UpdateNames() end)

	local prev, nextPage, text = _G.CompanionPrevPageButton, _G.CompanionNextPageButton, _G.CompanionPageNumber
	nextPage:ClearAllPoints()
	nextPage:SetPoint("TOPRIGHT", frame, "TOPRIGHT", unpack(config.companion_pages))
	text:ClearAllPoints()
	text:SetPoint("RIGHT", nextPage, "LEFT", -config.page_gap, 0)
	text:SetTextColor(unpack(config.page_color))
	prev:ClearAllPoints()
	prev:SetPoint("RIGHT", text, "LEFT", -config.page_gap, 0)
	kit:StylePager(prev, nextPage)

	-- above the cover, all of it (a frame keeps its level when it moves)
	local raise
	raise = function(child, level)
		child:SetFrameLevel(level)
		for i = 1, select("#", child:GetChildren()) do
			raise((select(i, child:GetChildren())), level + 1)
		end
	end
	raise(frame, cover:GetFrameLevel() + 1)
	-- the panels under what they hold
	for _, slot in ipairs(slots) do
		slot:SetFrameLevel(frame:GetFrameLevel())
	end
end

-- The companions' names beside them, on the page shown.
Module.UpdateNames = function(self)
	local frame = _G.PetPaperDollFrameCompanionFrame
	local page = (frame.mode == "MOUNT") and frame.pageMount or frame.pageCritter
	for i, label in ipairs(self.CompanionNames) do
		local _, name = GetCompanionInfo(frame.mode, (page or 0) * NUM_COMPANIONS + i)
		local known = _G["CompanionButton" .. i].creatureID
		label:SetText(known and name or "")
		-- an empty one not drawn at all (out of sight, not hidden: the
		-- button's Blizzard's)
		local slot = self.CompanionSlots[i]
		slot:SetAlpha(known and 1 or 0)
		slot.border:SetAlpha(known and 1 or 0)
	end
end

-- The companions, mounts or professions (`mode`), or the spells found
-- ("SEARCH"), on the cover over the spells, or the spells again (nil). Not
-- in combat: the cover holds secure buttons.
Module.ShowPage = function(self, mode)
	if InCombatLockdown() then
		_G.UIErrorsFrame:AddMessage(_G.ERR_NOT_IN_COMBAT, 1, .1, .1)
		return
	end
	self.page = mode
	if (mode ~= "SEARCH") then
		self:ClearSearch()
	end
	if mode then
		self:ApplyPage()
	else
		self.Cover:Hide()
		local frame = _G.SpellBookFrame
		_G.SpellBookTitleText:SetText((frame.bookType == _G.BOOKTYPE_PET) and frame.petTitle or _G.SPELLBOOK)
	end
	self:UpdateTabs()
	self:UpdateBand()
	self:FitCover()
end

-- The band dropped on the pages with nothing in it (`bare_pages`), the
-- cover up into its room; back on the others.
Module.FitCover = function(self)
	local config = self.config
	local cover = self.Cover
	local bare = self.page and config.bare_pages[self.page]
	if bare then
		self.Header:Hide()
	else
		self.Header:Show()
	end
	-- the iron, the title's plate and the X over the cover reaching under
	-- them (the bookmarks, over the iron, are hidden there)
	local window = cover.DiabolicWindow
	local level = bare and (cover:GetFrameLevel() + 1) or (window:GetFrameLevel() + 3)
	window.Border:SetFrameLevel(level)
	for part, above in pairs({ DiabolicPlate = 0, DiabolicSocket = 1, DiabolicClose = 2 }) do
		if window[part] then
			window[part]:SetFrameLevel(level + above)
		end
	end
	local left, top = config.cover_insets[1], bare and (config.bare_cover_top + (window.DiabolicDrop or 0)) or config.cover_insets[2]
	if (cover.DiabolicY ~= top) then
		cover.DiabolicY = top -- (its stone tiled from there: LayoutCover)
		cover:SetPoint("TOPLEFT", cover.DiabolicWindow, "TOPLEFT", left, -top)
	end
end

-- The page's frame on the cover, the others hidden: Blizzard's
-- companions frame in the page's mode (as its own tabs set it), the
-- professions, the spells found.
Module.ApplyPage = function(self)
	local config = self.config
	local page = self.page
	local frame = _G.PetPaperDollFrameCompanionFrame
	local companions = (page == "CRITTER") or (page == "MOUNT")
	self.Cover.Art:SetTexture(config.cover_art[page])
	self.Cover.Art:SetVertexColor(unpack(config.cover_art_colors[page] or config.cover_art_color))
	if (page == "PROFESSIONS") then
		self.Professions:Show()
		self:UpdateProfessions()
	else
		self.Professions:Hide()
	end
	if (page == "SEARCH") then
		self.Found:Show()
		self:UpdateFound()
	else
		self.Found:Hide()
	end
	self.Cover:Show()
	if companions then
		frame.mode = page
		frame:Show()
		_G.PetPaperDollFrame_SetCompanionPage((page == "MOUNT") and frame.pageMount or frame.pageCritter)
		_G.PetPaperDollFrame_UpdateCompanionPreview()
	else
		frame:Hide()
	end
end

-- The character window's pet tab for the pet only, its companions and
-- mounts gone from it: the tab hidden without a pet (as Blizzard hides it
-- without anything to show), no tabs of its own.
Module.PetOnly = function(self)
	if (not HasPetUI()) then
		_G.PetPaperDollFrame.hidden = true
		_G.CharacterFrameTab2:Hide()
		_G.CharacterFrameTab3:SetPoint("LEFT", _G.CharacterFrameTab2, "LEFT", 0, 0)
		if _G.PetPaperDollFrame:IsVisible() then
			_G.ToggleCharacter("PaperDollFrame")
		end
	end
end

Module.HidePetTabs = function(self)
	for i = 1, 3 do
		_G["PetPaperDollFrameTab" .. i]:Hide()
	end
	if HasPetUI() and _G.PetPaperDollFrame:IsVisible() and (_G.PetPaperDollFrame.selectedTab ~= 1) and (not InCombatLockdown()) then
		_G.PetPaperDollFrame_SetTab(1)
	end
end

Module.StyleSpellbook = function(self)
	local config = self.config
	local frame = _G.SpellBookFrame

	local window = kit:CreateWindow(frame, config.insets)
	-- the window's smoke around its pages
	kit:SetBackground(window, "smoke")
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + config.insets[3])
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(self.Header, _G.SpellBookTitleText)
	kit:StyleClose(_G.SpellBookCloseButton, window, self.Header)

	self:LayoutSpells(window)
	self:CreateTabs(window)

	-- the companions' cover
	self.Cover = kit:CreateCover(window, config.cover_insets, config.cover_level)
	self.Cover:Hide()
	-- Sholazar Basin behind them (The Art of Wrath of the Lich King's)
	local art = self.Cover:CreateTexture(nil, "BORDER")
	art:SetAllPoints()
	art:SetVertexColor(unpack(config.cover_art_color))
	self.Cover.Art = art
	self:LayoutCompanions(self.Cover)
	self:CreateProfessions(self.Cover)
	self:CreateSearch(window, self.Cover)
	self:PlaceBoxes()
	-- the book closed under it (its pages show through the stone)
	-- and its bookmarks (over the iron, so over the cover too) out of sight
	local Bookmarks = function(shown)
		for i = 1, NUM_SCHOOLS do
			local tab = _G["SpellBookSkillLineTab" .. i]
			tab:SetAlpha(shown and 1 or 0)
			tab:EnableMouse(shown)
		end
	end
	self.Cover:HookScript("OnShow", function()
		for _, texture in ipairs(self.Book) do
			texture:Hide()
		end
		Bookmarks(false)
	end)
	self.Cover:HookScript("OnHide", function()
		for _, texture in ipairs(self.Book) do
			texture:Show()
		end
		Bookmarks(true)
	end)

	hooksecurefunc("SpellBookFrame_Update", function()
		self:UpdateTabs()
		self:UpdateAllUnassigned()
	end)
	frame:HookScript("OnShow", function() self:UpdateTabs() end)
	-- back to the spells once closed
	frame:HookScript("OnHide", function()
		if self.page then
			if InCombatLockdown() then
				self:RegisterEvent("PLAYER_REGEN_ENABLED", "LeavePage")
			else
				self:ShowPage(nil)
			end
		end
	end)
	-- Blizzard's pet tab changes the companions frame's mode and shows or
	-- hides it: the page's again
	hooksecurefunc("PetPaperDollFrame_SetTab", function()
		if InCombatLockdown() then
			return
		end
		if (self.page == "CRITTER") or (self.page == "MOUNT") then
			self:ApplyPage()
		else
			_G.PetPaperDollFrameCompanionFrame:Hide()
		end
	end)
	hooksecurefunc("PetPaperDollFrame_UpdateIsAvailable", function() self:PetOnly() end)
	hooksecurefunc("PetPaperDollFrame_UpdateTabs", function() self:HidePetTabs() end)
	self:PetOnly()
	self:HidePetTabs()
	self:RegisterEvent("COMPANION_LEARNED", "UpdateTabs")
	self:RegisterEvent("COMPANION_UNLEARNED", "UpdateTabs")
end

Module.LeavePage = function(self)
	self:UnregisterEvent("PLAYER_REGEN_ENABLED", "LeavePage")
	if not _G.SpellBookFrame:IsShown() then
		self:ShowPage(nil)
	end
end

-- Blizzard's secure buttons can only be moved out of combat (a /reload in
-- a fight).
Module.Start = function(self)
	self:UnregisterEvent("PLAYER_REGEN_ENABLED", "Start")
	self:StyleSpellbook()
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").spellbook
	self.db = self:GetConfig("Spellbook")
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	SetCVar("ShowAllSpellRanks", self.db.showAllRanks and "1" or "0")
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "Start")
	else
		self:StyleSpellbook()
	end
end
