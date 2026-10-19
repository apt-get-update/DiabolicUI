-- The spellbook's search box (Pretty GUI's, in Diablo III's look), at
-- the top of its book's left page (spellbook.lua): the spells whose names hold
-- what's typed, on a book of their own on the cover over Blizzard's, in
-- the spells' own places, twelve a page. Ours are secure buttons casting
-- them (and dragged to the bars): Blizzard's can't be told which spells to
-- show without tainting their casts. Not in combat, as the cover.
local _, Engine = ...
local Module = Engine:GetModule("Blizzard: Spellbook")
local L = Engine:GetLocale()

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local math_ceil = math.ceil
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local string_lower = string.lower
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCVar = _G.GetCVar
local GetNumSpellTabs = _G.GetNumSpellTabs
local GetSpellName = _G.GetSpellName
local GetSpellTabInfo = _G.GetSpellTabInfo
local GetSpellTexture = _G.GetSpellTexture
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local IsPassiveSpell = _G.IsPassiveSpell
local PickupSpell = _G.PickupSpell

local NUM_FOUND = 12 -- a page, as the spells'

-- A found spell's button: its icon in the action buttons' border, its
-- name and rank in ink beside it, as Blizzard's spells.
Module.CreateFoundButton = function(self, parent, window, i)
	local config = self.config
	local size = _G.SpellButton1:GetWidth()
	local button = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
	button:SetSize(size, size)
	button:RegisterForClicks("AnyUp")
	button:RegisterForDrag("LeftButton")
	-- down the left page, then the right one, as Blizzard's spells
	local x, y = unpack(config.spells)
	local half = NUM_FOUND / 2
	local row, column = (i - 1) % half, math_floor((i - 1) / half)
	button:SetPoint("TOPLEFT", window, "TOPLEFT",
		x + column * config.slot_pitch[1] + config.icon_inset,
		y - row * config.slot_pitch[2] - (config.slot_size[2] - size) / 2)
	button.Icon = button:CreateTexture(nil, "ARTWORK")
	button.Icon:SetAllPoints()
	kit:AddBorder(button, size)
	local highlight = button:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints()
	button.Name = button:CreateFontString(nil, "OVERLAY")
	button.Name:SetFontObject(config.name_font)
	button.Name:SetWidth(config.name_width)
	button.Name:SetJustifyH("LEFT")
	button.Name:SetShadowColor(0, 0, 0, 0)
	button.Name:SetPoint("LEFT", button, "RIGHT", config.name_offset, 4)
	button.Rank = button:CreateFontString(nil, "OVERLAY")
	button.Rank:SetFontObject(config.rank_font)
	button.Rank:SetWidth(config.name_width)
	button.Rank:SetJustifyH("LEFT")
	button.Rank:SetTextColor(unpack(config.rank_color))
	button.Rank:SetShadowColor(0, 0, 0, 0)
	button.Rank:SetPoint("TOPLEFT", button.Name, "BOTTOMLEFT", 0, -2)
	button:SetScript("OnEnter", function()
		_G.GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
		_G.GameTooltip:SetSpell(button.index, _G.BOOKTYPE_SPELL)
	end)
	button:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
	button:SetScript("OnDragStart", function()
		if (not InCombatLockdown()) then
			PickupSpell(button.index, _G.BOOKTYPE_SPELL)
		end
	end)
	return button
end

-- The box, the page of spells found on the cover (a book of its own), and
-- its pages' arrows.
Module.CreateSearch = function(self, window, cover)
	kit = Engine:GetModule("Blizzard: Windows")
	local config = self.config
	local frame = _G.SpellBookFrame

	local box = CreateFrame("EditBox", "DiabolicUISpellBookSearchBox", frame)
	box:SetFrameLevel(cover:GetFrameLevel() + 2) -- over the spells found
	box:SetSize(unpack(config.search_size))
	box:SetPoint("TOPLEFT", window, "TOPLEFT", unpack(config.search_box))
	box:SetAutoFocus(false)
	box:SetFontObject(config.search_font)
	box:SetTextInsets(config.search_inset, config.search_inset, 0, 0)
	kit:StylePanel(box)
	local hint = box:CreateFontString(nil, "OVERLAY")
	hint:SetFontObject(config.search_font)
	hint:SetTextColor(unpack(config.search_hint_color))
	hint:SetPoint("LEFT", box, "LEFT", config.search_inset, 0)
	hint:SetText(_G.SEARCH)
	box:SetScript("OnEditFocusGained", function() hint:Hide() end)
	box:SetScript("OnEditFocusLost", function()
		if (box:GetText() == "") then
			hint:Show()
		end
	end)
	box:SetScript("OnEscapePressed", function()
		box:SetText("")
		box:ClearFocus()
	end)
	box:SetScript("OnEnterPressed", function() box:ClearFocus() end)
	box:SetScript("OnTextChanged", function()
		if (not self.Clearing) then
			self:Search(box:GetText())
		end
	end)
	self.SearchBox, self.SearchHint = box, hint

	local found = CreateFrame("Frame", nil, cover)
	found:SetAllPoints(cover)
	found:SetFrameLevel(cover:GetFrameLevel() + 1)
	found:Hide()
	self:CreateBook(window, found)
	self.FoundButtons = {}
	for i = 1, NUM_FOUND do
		self.FoundButtons[i] = self:CreateFoundButton(found, window, i)
	end
	local none = found:CreateFontString(nil, "OVERLAY")
	none:SetFontObject(config.name_font)
	none:SetTextColor(unpack(config.rank_color))
	none:SetShadowColor(0, 0, 0, 0)
	none:SetPoint("TOP", window, "TOP", 0, config.spells[2] - 12)
	none:SetText(L["No spell found"])
	found.None = none

	-- its pages, as the spells': the next page's arrow, the page, the previous
	local nextPage = CreateFrame("Button", nil, found)
	nextPage:SetSize(32, 32)
	nextPage:SetPoint("TOPRIGHT", window, "TOPRIGHT", unpack(config.pages))
	nextPage:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]])
	nextPage:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]])
	nextPage:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]])
	nextPage:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")
	nextPage:SetScript("OnClick", function() self:TurnFound(1) end)
	local text = found:CreateFontString(nil, "OVERLAY")
	text:SetFontObject(_G.SpellBookPageText:GetFontObject())
	text:SetTextColor(unpack(kit.config.ink))
	text:SetShadowColor(0, 0, 0, 0)
	text:SetPoint("RIGHT", nextPage, "LEFT", -config.page_gap, 0)
	local prev = CreateFrame("Button", nil, found)
	prev:SetSize(32, 32)
	prev:SetPoint("RIGHT", text, "LEFT", -config.page_gap, 0)
	prev:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]])
	prev:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]])
	prev:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]])
	prev:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")
	prev:SetScript("OnClick", function() self:TurnFound(-1) end)
	found.Next, found.Prev, found.Page = nextPage, prev, text
	self.Found = found

	-- back to the player's spells for another book
	hooksecurefunc("SpellBookFrame_Update", function()
		if (frame.bookType ~= _G.BOOKTYPE_SPELL) and (self.page == "SEARCH") and (not InCombatLockdown()) then
			self:ShowPage(nil)
		end
		self:UpdateSearchBox()
	end)
end

-- The box on the player's spells and the spells found only, not over the
-- pet's book or the other pages.
Module.UpdateSearchBox = function(self)
	local box = self.SearchBox
	if (not box) then
		return
	end
	if (_G.SpellBookFrame.bookType == _G.BOOKTYPE_SPELL) and ((self.page == nil) or (self.page == "SEARCH")) then
		box:Show()
	else
		box:Hide()
	end
end

-- The player's spells whose names hold `query` (in any case): the best
-- rank of each, or every rank while all ranks show (Blizzard's box).
Module.FindSpells = function(self, query)
	query = string_lower(query)
	local total = 0
	for tab = 1, GetNumSpellTabs() do
		local _, _, offset, count = GetSpellTabInfo(tab)
		total = math_max(total, offset + count)
	end
	local everyRank = (GetCVar("ShowAllSpellRanks") == "1")
	local found, byName = {}, {}
	for index = 1, total do
		local name, rank = GetSpellName(index, _G.BOOKTYPE_SPELL)
		if name and string_lower(name):find(query, 1, true) then
			local spell = byName[name]
			if spell and (not everyRank) then
				spell.index, spell.rank = index, rank -- a later rank, a better one
			else
				spell = { index = index, name = name, rank = rank }
				byName[name] = spell
				found[#found + 1] = spell
			end
		end
	end
	return found
end

-- What's typed: its spells on the cover, the spells again once it's empty.
Module.Search = function(self, text)
	if (text == "") then
		if (self.page == "SEARCH") then
			self:ShowPage(nil)
		end
		return
	end
	if InCombatLockdown() then
		_G.UIErrorsFrame:AddMessage(_G.ERR_NOT_IN_COMBAT, 1, .1, .1)
		return
	end
	self.FoundSpells = self:FindSpells(text)
	self.FoundPage = 1
	if (self.page == "SEARCH") then
		self:UpdateFound()
	else
		self:ShowPage("SEARCH")
	end
end

-- The box emptied (the page left), without searching again.
Module.ClearSearch = function(self)
	local box = self.SearchBox
	if box and (box:GetText() ~= "") then
		self.Clearing = true
		box:SetText("")
		self.Clearing = nil
		box:ClearFocus()
		self.SearchHint:Show()
	end
end

-- Another page of the spells found, `step` on.
Module.TurnFound = function(self, step)
	if InCombatLockdown() then
		return
	end
	local pages = math_max(1, math_ceil(#self.FoundSpells / NUM_FOUND))
	self.FoundPage = math_min(pages, math_max(1, self.FoundPage + step))
	self:UpdateFound()
end

-- The page of spells found on their buttons, the rest out of sight.
Module.UpdateFound = function(self)
	if InCombatLockdown() then
		return
	end
	local spells = self.FoundSpells or {}
	local pages = math_max(1, math_ceil(#spells / NUM_FOUND))
	local first = (self.FoundPage - 1) * NUM_FOUND
	for i, button in ipairs(self.FoundButtons) do
		local spell = spells[first + i]
		if spell then
			local passive = IsPassiveSpell(spell.index, _G.BOOKTYPE_SPELL)
			button.index = spell.index
			button.Icon:SetTexture(GetSpellTexture(spell.index, _G.BOOKTYPE_SPELL))
			button.Icon:SetDesaturated(passive and true or false)
			button.Name:SetText(spell.name)
			button.Name:SetTextColor(unpack(passive and self.config.passive_color or kit.config.ink))
			button.Rank:SetText(spell.rank or "")
			-- the rank cast, as shown (a passive one not cast)
			local cast = spell.name
			if spell.rank and (spell.rank ~= "") then
				cast = cast .. "(" .. spell.rank .. ")"
			end
			button:SetAttribute("type", (not passive) and "spell" or nil)
			button:SetAttribute("spell", cast)
			button:Show()
		else
			button.index = nil
			button:SetAttribute("type", nil)
			button:Hide()
		end
	end
	local found = self.Found
	if (#spells == 0) then
		found.None:Show()
	else
		found.None:Hide()
	end
	found.Page:SetText(_G.PAGE_NUMBER:format(self.FoundPage))
	if (self.FoundPage > 1) then
		found.Prev:Enable()
	else
		found.Prev:Disable()
	end
	if (self.FoundPage < pages) then
		found.Next:Enable()
	else
		found.Next:Disable()
	end
end
