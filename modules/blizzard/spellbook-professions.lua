-- The spellbook's professions page (Pretty GUI's, in Diablo III's look),
-- on its cover (spellbook.lua): the primary professions, then the
-- secondary ones, a panel each with its icon (a click opens it), its name,
-- its rank's title, its rank in a bar, its other spell (Disenchant,
-- Prospecting, Smelting's Find Minerals...) on the right (no Unlearn: one
-- click from losing a long grind); one not learned yet says where to learn it. Read from
-- the skill lines: 3.3.5 has no list of professions of its own.
local _, Engine = ...
local Module = Engine:GetModule("Blizzard: Spellbook")
local L = Engine:GetLocale()

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetNumSkillLines = _G.GetNumSkillLines
local GetSkillLineInfo = _G.GetSkillLineInfo
local GetSpellInfo = _G.GetSpellInfo
local InCombatLockdown = _G.InCombatLockdown

local NUM_PRIMARY = 2

-- the secondary ones, a panel each in this order (Pretty GUI's): their
-- skill's spell, as in PROFESSIONS (Riding isn't one)
local SECONDARY = { 2550, 7620, 3273 } -- Cooking, Fishing, First Aid

-- a profession's rank's title by its highest skill (the trainer's)
local RANKS = {
	{ 75, "Apprentice" }, { 150, "Journeyman" }, { 225, "Expert" },
	{ 300, "Artisan" }, { 375, "Master" }, { 450, "Grand Master" }
}

local RankTitle = function(max)
	local title
	for _, rank in ipairs(RANKS) do
		if (max >= rank[1]) then
			title = L[rank[2]]
		end
	end
	return title or ""
end

-- The professions by a spell named as their skill (`skill`), the spell
-- that opens them (`open`, `skill` if left out, none for the gathering
-- ones that have nothing to open) and their other one (`extra`), by ID:
-- the client names them in its own language.
local PROFESSIONS = {
	{ skill = 2259 }, -- Alchemy
	{ skill = 2018 }, -- Blacksmithing
	{ skill = 7411, extra = 13262 }, -- Enchanting, Disenchant
	{ skill = 4036 }, -- Engineering
	{ skill = 45357, extra = 51005 }, -- Inscription, Milling
	{ skill = 25229, extra = 31252 }, -- Jewelcrafting, Prospecting
	{ skill = 2108 }, -- Leatherworking
	{ skill = 3908 }, -- Tailoring
	{ skill = 2575, open = 2656, extra = 2580 }, -- Mining, Smelting, Find Minerals
	{ skill = 2366, open = false, extra = 2383 }, -- Herbalism, Find Herbs
	{ skill = 8613, open = false }, -- Skinning
	{ skill = 2550, extra = 818 }, -- Cooking, Basic Campfire
	{ skill = 3273 }, -- First Aid
	{ skill = 7620 } -- Fishing
}

-- the skill lines' sections the professions are in
local SECTIONS = { [_G.TRADE_SKILLS] = "primary", [(_G.SECONDARY_SKILLS:gsub(":$", ""))] = "secondary" }

-- `id`'s name and icon, and whether the player knows it (only a known
-- spell is found by its name).
local SpellOf = function(id)
	local name, _, icon = GetSpellInfo(id)
	return name, icon, name and (GetSpellInfo(name) ~= nil)
end

-- A profession's data by its skill line's name.
local Find = function(name)
	for _, data in ipairs(PROFESSIONS) do
		if (GetSpellInfo(data.skill) == name) then
			return data
		end
	end
end

-- A secure button casting a spell (set by Update), its icon in the action
-- buttons' border, its tooltip on hover.
local CreateSpellButton = function(parent, size)
	local button = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
	button:SetSize(size, size)
	button:SetAttribute("type", "spell")
	button:RegisterForClicks("AnyUp")
	button.Icon = button:CreateTexture(nil, "ARTWORK")
	button.Icon:SetAllPoints()
	kit:AddBorder(button, size)
	local highlight = button:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints()
	button:SetScript("OnEnter", function()
		if button.spellID then
			_G.GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			_G.GameTooltip:SetHyperlink("spell:" .. button.spellID)
		end
	end)
	button:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
	return button
end

-- `button` casting `id` if the player knows it, out of sight otherwise.
local SetSpell = function(button, id)
	local name, icon, known = SpellOf(id or 0)
	if id and known then
		button.spellID = id
		button.Icon:SetTexture(icon)
		button:SetAttribute("spell", name)
		button:Show()
	else
		button.spellID = nil
		button:SetAttribute("spell", nil)
		button:Hide()
	end
end

-- A profession's panel: its icon, name, rank and bar, its other spell.
Module.CreateProfession = function(self, parent, primary)
	local config = self.config
	local height = config.profession_heights[primary and 1 or 2]
	local size = config.profession_icons[primary and 1 or 2]
	local row = CreateFrame("Frame", nil, parent)
	row:SetSize(config.profession_width, height)
	kit:StylePanel(row)

	-- its icon, under the button opening it (none for a gathering one)
	local holder = CreateFrame("Frame", nil, row)
	holder:SetSize(size, size)
	holder:SetPoint("LEFT", row, "LEFT", config.profession_inset, 0)
	row.Icon = holder:CreateTexture(nil, "ARTWORK")
	row.Icon:SetAllPoints()
	kit:AddBorder(holder, size)
	row.Open = CreateSpellButton(row, size)
	row.Open:SetPoint("CENTER", holder, "CENTER", 0, 0)
	row.Open:SetFrameLevel(holder:GetFrameLevel() + 1)

	row.Name = row:CreateFontString(nil, "OVERLAY")
	row.Name:SetFontObject(config.name_font)
	row.Name:SetJustifyH("LEFT")
	row.Name:SetTextColor(unpack(config.profession_title_color))
	row.Name:SetPoint("TOPLEFT", row.Icon, "TOPRIGHT", config.name_offset, -2)
	row.Rank = row:CreateFontString(nil, "OVERLAY")
	row.Rank:SetFontObject(config.rank_font)
	row.Rank:SetTextColor(unpack(config.profession_rank_color))
	row.Rank:SetPoint("BOTTOMLEFT", row.Name, "BOTTOMRIGHT", config.profession_rank_gap, 0)
	-- one not learned yet: where to learn it, in the bar's place
	row.Help = row:CreateFontString(nil, "OVERLAY")
	row.Help:SetFontObject(config.profession_help_font)
	row.Help:SetTextColor(unpack(config.profession_help_color))
	row.Help:SetJustifyH("LEFT")
	row.Help:SetPoint("BOTTOMLEFT", row.Icon, "BOTTOMRIGHT", config.name_offset, 2)

	local width, barHeight = unpack(config.profession_bar)
	local bar = CreateFrame("StatusBar", nil, row)
	bar:SetSize(width, barHeight)
	bar:SetPoint("BOTTOMLEFT", row.Icon, "BOTTOMRIGHT", config.name_offset, 2)
	kit:StyleBar(bar)
	bar.Text = bar:CreateFontString(nil, "OVERLAY")
	bar.Text:SetFontObject(config.rank_font)
	bar.Text:SetPoint("CENTER", bar, "CENTER", 0, 0)
	row.Bar = bar

	row.Extra = CreateSpellButton(row, config.profession_extra)
	row.Extra:SetPoint("RIGHT", row, "RIGHT", -config.profession_inset, 0)
	return row
end

-- The page: a section title over each kind, their panels under it.
Module.CreateProfessions = function(self, cover)
	kit = Engine:GetModule("Blizzard: Windows")
	local config = self.config
	local page = CreateFrame("Frame", nil, cover)
	page:SetAllPoints(cover)
	page:SetFrameLevel(cover:GetFrameLevel() + 1)
	page:Hide()
	local x, y = unpack(config.professions)
	self.ProfessionRows = { primary = {}, secondary = {} }
	for _, section in ipairs({ { "primary", _G.PRIMARY, NUM_PRIMARY }, { "secondary", _G.SECONDARY, #SECONDARY } }) do
		local kind, label, count = unpack(section)
		local title = page:CreateFontString(nil, "OVERLAY")
		title:SetFontObject(config.profession_title_font)
		title:SetTextColor(unpack(config.profession_title_color))
		title:SetPoint("BOTTOMLEFT", page, "TOPLEFT", x, y + 6)
		title:SetText(label)
		local height = config.profession_heights[(kind == "primary") and 1 or 2]
		for i = 1, count do
			local row = self:CreateProfession(page, kind == "primary")
			row:SetPoint("TOPLEFT", page, "TOPLEFT", x, y)
			self.ProfessionRows[kind][i] = row
			y = y - height - config.profession_gap
		end
		y = y - config.profession_section_gap
	end
	self.Professions = page
	self:RegisterEvent("SKILL_LINES_CHANGED", "OnSkillsChanged")
end

-- The professions the player has, by section: { index, name, rank, max }.
-- A collapsed section is opened first (its lines aren't listed otherwise).
Module.GetProfessions = function(self)
	local found = { primary = {}, secondary = {} }
	local section
	local i = 1
	while (i <= GetNumSkillLines()) do
		local name, header, expanded, rank, _, modifier, max = GetSkillLineInfo(i)
		if header then
			section = SECTIONS[name]
			if section and (not expanded) then
				_G.ExpandSkillHeader(i)
			end
		elseif section then
			local list = found[section]
			list[#list + 1] = { index = i, name = name, rank = rank + (modifier or 0), max = max }
		end
		i = i + 1
	end
	return found
end

Module.HasProfessions = function(self)
	local found = self:GetProfessions()
	return (#found.primary + #found.secondary) > 0
end

-- `row` showing the player's `skill` (from GetProfessions).
Module.FillProfession = function(self, row, skill)
	local data = Find(skill.name) or {}
	local open = (data.open == nil) and data.skill or data.open
	SetSpell(row.Open, open or nil)
	local _, icon = SpellOf(data.skill or 0)
	row.Icon:SetTexture(icon or [[Interface\Icons\INV_Misc_QuestionMark]])
	row.Icon:SetDesaturated(false)
	row.Name:SetText(skill.name)
	row.Rank:SetText(RankTitle(skill.max))
	row.Bar:SetMinMaxValues(0, (skill.max > 0) and skill.max or 1)
	row.Bar:SetValue(skill.rank)
	row.Bar.Text:SetText(skill.rank .. " / " .. skill.max)
	row.Bar:Show()
	row.Help:Hide()
	SetSpell(row.Extra, data.extra)
end

-- `row` for a profession not learned yet: its name and icon (greyed),
-- where to learn it, no bar and no buttons.
Module.ShowMissing = function(self, row, name, icon, help)
	SetSpell(row.Open, nil)
	SetSpell(row.Extra, nil)
	row.Icon:SetTexture(icon)
	row.Icon:SetDesaturated(true)
	row.Name:SetText(name)
	row.Rank:SetText("")
	row.Bar:Hide()
	row.Help:SetText(help)
	row.Help:Show()
end

-- The panels filled: the primary ones the player has, then "missing" in
-- the rest; each secondary one in its place, learned or not. Its secure
-- buttons are set out of combat only (then once it ends).
Module.UpdateProfessions = function(self)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnSkillsChanged")
		return
	end
	local config = self.config
	local found = self:GetProfessions()
	for i, row in ipairs(self.ProfessionRows.primary) do
		local skill = found.primary[i]
		if skill then
			self:FillProfession(row, skill)
		else
			self:ShowMissing(row, L["Missing Primary Profession"], config.profession_missing_icon,
				L["Visit a profession trainer in a capital city to learn one."])
		end
	end
	for i, row in ipairs(self.ProfessionRows.secondary) do
		local name, icon = SpellOf(SECONDARY[i])
		local skill
		for _, learned in ipairs(found.secondary) do
			if (learned.name == name) then
				skill = learned
			end
		end
		if skill then
			self:FillProfession(row, skill)
		else
			self:ShowMissing(row, name or "", icon, L["Not learned yet: visit its trainer to learn it."])
		end
	end
end

Module.OnSkillsChanged = function(self, event)
	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnSkillsChanged")
	end
	if self.Professions:IsShown() then
		self:UpdateProfessions()
	end
	if (not InCombatLockdown()) then
		self:UpdateTabs()
	end
end
