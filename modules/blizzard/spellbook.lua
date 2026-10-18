-- Gives Blizzard's spellbook Diablo III's window (windows.lua), laid out as
-- Pretty GUI's: wide, the title in the plate over the red band, the tabs
-- in a row under it, an open book on its leather: the spells in ink on
-- its two pages (six each, their names and ranks), the schools its red
-- ribbon bookmarks out past its right edge, the pages and the "all ranks" box at its
-- bottom (the box's choice saved:
-- the game's own setting doesn't keep it). The companions and
-- mounts move here from the character window's pet tab, in two more tabs:
-- the model in a panel, the companions in three columns of four with
-- their names. They're drawn on a cover over the spells: Blizzard's spell
-- buttons are secure, hiding them from here would taint the casts.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Spellbook", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local select = select
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCompanionInfo = _G.GetCompanionInfo
local GetNumCompanions = _G.GetNumCompanions
local HasPetUI = _G.HasPetUI
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local SetCVar = _G.SetCVar
local SetPortraitToTexture = _G.SetPortraitToTexture

local NUM_SPELLS = 12 -- SPELLS_PER_PAGE
local NUM_SCHOOLS = 8 -- MAX_SKILLLINE_TABS
local NUM_COMPANIONS = 12 -- NUM_COMPANIONS_PER_PAGE

-- the companions' and mounts' tabs: their mode and title
local PAGES = { { "CRITTER", "COMPANIONS" }, { "MOUNT", "MOUNTS" } }

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
-- the fold. On the window, over its leather (a frame of its own at its
-- level could draw under it).
Module.CreateBook = function(self, window)
	local config = self.config
	local x, y, width, height = unpack(config.book)
	local half = width / 2
	self.Book = {}
	for side = 0, 1 do
		local page = window:CreateTexture(nil, "ARTWORK")
		page:SetTexture(kit.config.parchment)
		page:SetPoint("TOPLEFT", window, "TOPLEFT", x + side * half, y)
		page:SetSize(half, height)
		page:SetTexCoord(1 - side, side, 0, 1)
		local fold = window:CreateTexture(nil, "OVERLAY")
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
		self.Book[#self.Book + 1] = page
		self.Book[#self.Book + 1] = fold
	end
end

Module.LayoutSpells = function(self, window)
	local config = self.config
	local frame = _G.SpellBookFrame
	self:CreateBook(window)
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
	end)

	-- the schools as the book's bookmarks: Diablo III's red ribbon's
	-- notched end out past its right edge, each school's icon on it over
	-- the pages' edge
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
		cloth:SetTexCoord(unpack(ribbon.coords))
		cloth:SetPoint("TOPLEFT", -ribbon.left, ribbon.pad)
		cloth:SetPoint("BOTTOMRIGHT", ribbon.right, -ribbon.pad)
	end

	-- the bottom row
	local ranks = _G.ShowAllSpellRanksCheckBox
	ranks:ClearAllPoints()
	ranks:SetPoint("TOPLEFT", window, "TOPLEFT", unpack(config.ranks_box))
	ranks:HookScript("OnClick", function() self.db.showAllRanks = ranks:GetChecked() and true or false end)
	local prev, nextPage, text = _G.SpellBookPrevPageButton, _G.SpellBookNextPageButton, _G.SpellBookPageText
	nextPage:ClearAllPoints()
	nextPage:SetPoint("TOPRIGHT", window, "TOPRIGHT", unpack(config.pages))
	text:ClearAllPoints()
	text:SetWidth(0)
	text:SetPoint("RIGHT", nextPage, "LEFT", -config.page_gap, 0)
	text:SetTextColor(unpack(kit.config.ink))
	text:SetShadowColor(0, 0, 0, 0)
	local label = _G.ShowAllSpellRanksCheckBoxText
	if label then
		label:SetTextColor(unpack(kit.config.ink))
		label:SetShadowColor(0, 0, 0, 0)
	end
	prev:ClearAllPoints()
	prev:SetPoint("RIGHT", text, "LEFT", -config.page_gap, 0)
	-- their "Prev" and "Next" out of sight: the page is between them
	for _, button in ipairs({ prev, nextPage }) do
		for i = 1, select("#", button:GetRegions()) do
			local region = select(i, button:GetRegions())
			if region:IsObjectType("FontString") then
				region:SetAlpha(0)
			end
		end
	end
end

-- The band's medallion (the character window's), the school shown
-- round over its glass (its swords on the companions' pages and the pet's
-- book).
Module.AddMedallion = function(self)
	local medallion = kit:AddMedallion(self.Header, "swords")
	local glass = self:GetDB("Blizzard").character.spec
	local size = medallion:GetWidth() * glass.glass
	local holder = CreateFrame("Frame", nil, _G.SpellBookFrame)
	holder:SetFrameLevel(self.Header:GetFrameLevel() + 2)
	holder:SetSize(size, size)
	holder:SetPoint("CENTER", medallion, "CENTER", unpack(glass.glass_offset))
	local icon = holder:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints()
	local Update = function()
		local frame = _G.SpellBookFrame
		local _, texture = _G.GetSpellTabInfo(frame.selectedSkillLine or 1)
		if texture and (not self.page) and (frame.bookType == _G.BOOKTYPE_SPELL) then
			SetPortraitToTexture(icon, texture)
			holder:Show()
		else
			holder:Hide()
		end
	end
	hooksecurefunc("SpellBookFrame_Update", Update)
	self.UpdateMedallion = Update
	Update()
end

-- A tab as ours, `config.tab_height` high and sized to its text.
Module.StyleTab = function(self, tab)
	local config = self.config
	tab:SetHeight(config.tab_height)
	tab:SetHitRectInsets(0, 0, 0, 0)
	-- Blizzard's art (the chosen tab's is its disabled texture)
	for _, art in ipairs({ tab:GetNormalTexture(), tab:GetDisabledTexture(), tab:GetPushedTexture() }) do
		art:SetAlpha(0)
	end
	kit:StyleTab(tab, { inset = config.tab_inset, padding = config.tab_padding })
end

-- The companions' and mounts' tabs after Blizzard's, the one shown chosen.
Module.CreateTabs = function(self)
	local frame = _G.SpellBookFrame
	self.Tabs = {}
	for i, page in ipairs(PAGES) do
		local tab = CreateFrame("Button", "DiabolicUISpellBookTab" .. page[1], frame)
		tab:SetFrameLevel(frame:GetFrameLevel() + 2)
		tab:SetNormalFontObject(kit.config.tab.font)
		tab:SetText(_G[page[2]])
		tab:SetScript("OnClick", function() self:ShowPage(page[1]) end)
		tab.mode = page[1]
		self:StyleTab(tab)
		self.Tabs[i] = tab
	end
	-- over Blizzard's chosen tab while a page shows: a click goes back to
	-- the spells (Blizzard's own would close the spellbook)
	local back = CreateFrame("Button", nil, frame)
	back:SetFrameLevel(frame:GetFrameLevel() + 5)
	back:Hide()
	back:SetScript("OnClick", function() self:ShowPage(nil) end)
	back:SetScript("OnEnter", function() if back.tab then back.tab:LockHighlight() end end)
	back:SetScript("OnLeave", function() if back.tab then back.tab:UnlockHighlight() end end)
	self.Back = back
end

-- The tabs in a row under the band (Blizzard's shown ones, then ours),
-- the chosen one lit.
Module.UpdateTabs = function(self)
	local frame = _G.SpellBookFrame
	local config = self.config
	local previous, active
	for i = 1, 3 do
		local tab = _G["SpellBookFrameTabButton" .. i]
		if tab and tab:IsShown() then
			tab:ClearAllPoints()
			if previous then
				tab:SetPoint("LEFT", previous, "RIGHT", config.tab_gap, 0)
			else
				tab:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", unpack(config.tab_offset))
				kit:AddTabStrip(self.Header)
			end
			if (tab.bookType == frame.bookType) then
				active = tab
				-- unchosen while a page shows; Blizzard disables the chosen one
				if self.page then
					tab:Enable()
				else
					tab:Disable()
				end
			end
			kit:UpdateTab(tab)
			previous = tab
		end
	end
	for _, tab in ipairs(self.Tabs) do
		if (GetNumCompanions(tab.mode) > 0) then
			tab:Show()
			tab:ClearAllPoints()
			if previous then
				tab:SetPoint("LEFT", previous, "RIGHT", config.tab_gap, 0)
			else
				tab:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", unpack(config.tab_offset))
				kit:AddTabStrip(self.Header)
			end
			previous = tab
		else
			tab:Hide()
		end
		if (self.page == tab.mode) then
			tab:Disable()
		else
			tab:Enable()
		end
		kit:UpdateTab(tab)
	end
	local back = self.Back
	if self.page and active then
		back.tab = active
		back:ClearAllPoints()
		back:SetAllPoints(active)
		back:Show()
	else
		back:Hide()
	end
	-- the page's title in the plate
	if self.page then
		local title = (self.page == "MOUNT") and _G.MOUNTS or _G.COMPANIONS
		_G.SpellBookTitleText:SetText(title)
	end
end

-- Blizzard's companions frame on the cover: the model in a panel, its
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
	panel:SetPoint("TOPLEFT", frame, "TOPLEFT", box[1], box[2])
	panel:SetSize(box[3], box[4])
	kit:StylePanel(panel)
	local model = _G.CompanionModelFrame
	model:ClearAllPoints()
	model:SetPoint("TOPLEFT", panel, "TOPLEFT", config.model_inset, -config.model_inset)
	model:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -config.model_inset, config.model_inset)
	local left = _G.CompanionModelFrameRotateLeftButton
	left:ClearAllPoints()
	left:SetPoint("TOPLEFT", model, "TOPLEFT", 0, 0)
	local name = _G.CompanionSelectedName
	name:ClearAllPoints()
	name:SetPoint("TOP", panel, "TOP", 0, config.name_top)
	local summon = _G.CompanionSummonButton
	summon:ClearAllPoints()
	summon:SetPoint("BOTTOM", panel, "BOTTOM", 0, config.summon_offset)
	summon:SetSize(unpack(config.summon_size))
	kit:StyleButton(summon, config.summon_size[2])

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

-- The companions or mounts (`mode`) on the cover over the spells, or the
-- spells again (nil). Not in combat: the cover holds Blizzard's secure
-- companion buttons.
Module.ShowPage = function(self, mode)
	if InCombatLockdown() then
		_G.UIErrorsFrame:AddMessage(_G.ERR_NOT_IN_COMBAT, 1, .1, .1)
		return
	end
	self.page = mode
	if mode then
		self:ApplyPage()
	else
		self.Cover:Hide()
		local frame = _G.SpellBookFrame
		_G.SpellBookTitleText:SetText((frame.bookType == _G.BOOKTYPE_PET) and frame.petTitle or _G.SPELLBOOK)
	end
	self:UpdateTabs()
	self:UpdateMedallion()
end

-- Blizzard's companions frame in the page's mode (as its own tabs set it).
Module.ApplyPage = function(self)
	local frame = _G.PetPaperDollFrameCompanionFrame
	frame.mode = self.page
	frame:Show()
	self.Cover:Show()
	_G.PetPaperDollFrame_SetCompanionPage((self.page == "MOUNT") and frame.pageMount or frame.pageCritter)
	_G.PetPaperDollFrame_UpdateCompanionPreview()
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
	-- the book's leather cover around its pages
	kit:SetBackground(window, "leather")
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + config.insets[3])
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(self.Header, _G.SpellBookTitleText)
	kit:StyleClose(_G.SpellBookCloseButton, window, self.Header)
	self:AddMedallion()

	self:LayoutSpells(window)
	for i = 1, 3 do
		local tab = _G["SpellBookFrameTabButton" .. i]
		if tab then
			self:StyleTab(tab)
		end
	end
	self:CreateTabs()

	-- the companions' cover
	self.Cover = kit:CreateCover(window, config.cover_insets, config.cover_level)
	self.Cover:Hide()
	self:LayoutCompanions(self.Cover)
	-- the book closed under it (its pages show through the stone)
	self.Cover:HookScript("OnShow", function()
		for _, texture in ipairs(self.Book) do
			texture:Hide()
		end
	end)
	self.Cover:HookScript("OnHide", function()
		for _, texture in ipairs(self.Book) do
			texture:Show()
		end
	end)

	hooksecurefunc("SpellBookFrame_Update", function() self:UpdateTabs() end)
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
		if self.page then
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
	SetCVar("ShowAllSpellRanks", self.db.showAllRanks and "1" or "0")
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "Start")
	else
		self:StyleSpellbook()
	end
end
