-- The trade skills' window on parchment (panels.lua puts its recipes and
-- the chosen one's details on it): the recipes in inks of their
-- difficulty, the chosen one in an orange box, the reagents' names in
-- ink (Blizzard sets both again as it updates, so after it does); the
-- search in the band, Have Materials right of it, the rank in the title,
-- the dropdowns under the band; the chosen recipe as a chapter's title.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Trade Skill", "LOW")
local kit

local ADDON = "Blizzard_TradeSkillUI"

-- The recipes' text in their difficulty's ink (Blizzard's colors are for
-- a dark background); no shadows (they blur it on parchment).
Module.ShadeList = function(self)
	local inks = self.config.inks
	for i = 1, _G.TRADE_SKILLS_DISPLAYED do
		local button = _G["TradeSkillSkill" .. i]
		local text, count = button and button:GetFontString(), _G["TradeSkillSkill" .. i .. "Count"]
		local _, kind = GetTradeSkillInfo(button:GetID())
		if text and button:IsShown() and inks[kind] then
			-- (the chosen one too: its box is see-through)
			local r, g, b = unpack(inks[kind])
			text:SetTextColor(r, g, b)
			text:SetShadowColor(0, 0, 0, 0)
			if count then
				count:SetVertexColor(r, g, b)
				count:SetShadowColor(0, 0, 0, 0)
			end
		end
	end
end

-- The chosen recipe's (`id`) reagents in ink, red for those short, their
-- icons framed as in the bags, in their quality's color; their label in
-- ink, closer to the description (Blizzard sets both on each choice).
Module.InkReagents = function(self, id)
	local bags = Engine:GetModule("Blizzard: Containers")
	local label = _G.TradeSkillReagentLabel
	label:SetTextColor(unpack(kit.config.ink))
	label:SetShadowColor(0, 0, 0, 0)
	local point, relative, relativePoint = label:GetPoint()
	if relativePoint == "BOTTOMLEFT" then
		label:SetPoint(point, relative, relativePoint, 0, -self.config.reagents_label_gap)
	end
	for i = 1, _G.MAX_TRADE_SKILL_REAGENTS do
		local name, icon = _G["TradeSkillReagent" .. i .. "Name"], _G["TradeSkillReagent" .. i .. "IconTexture"]
		if name then
			local r = name:GetTextColor()
			name:SetTextColor(unpack((r < 0.9) and self.config.missing_color or kit.config.ink))
			name:SetShadowColor(0, 0, 0, 0)
		end
		if icon then
			icon.DiabolicBorder = icon.DiabolicBorder or bags:FrameIcon(_G["TradeSkillReagent" .. i], icon)
			local link = id and GetTradeSkillReagentItemLink(id, i)
			bags:SetIconQuality(icon.DiabolicBorder, link and select(3, GetItemInfo(link)))
		end
	end
end

-- The chosen recipe's requirement wrapped short of Auctionator's Scan AH
-- (its name is: panels.lua), its description under both.
Module.ClearScan = function(self)
	local config = self.config
	local scan, text = _G.Auctionator_Search, _G.TradeSkillRequirementText
	local child, description = _G.TradeSkillDetailScrollChildFrame, _G.TradeSkillDescription
	if not (scan and scan:IsShown() and scan:GetLeft() and text:GetLeft()) then
		return
	end
	text:SetWidth(math.max(1, scan:GetLeft() - text:GetLeft() - config.scan_gap))
	local lowest = math.min(_G.TradeSkillSkillIcon:GetBottom(), text:GetBottom(), scan:GetBottom())
	local top = math.max(config.description_top, child:GetTop() - lowest + config.scan_gap)
	description:SetPoint("TOPLEFT", child, "TOPLEFT", config.description_left, -top)
end

-- The chosen recipe's box across the parchment, from its left edge to
-- the scroll bar (Blizzard's from the rows' left, short of it): its place
-- from Blizzard's offsets, the page's frame not laid out yet.
Module.SpanHighlight = function(self)
	local list, frame = _G.TradeSkillListScrollFrame, _G.TradeSkillFrame
	local insets = kit.config.parchment_insets
	local _, _, _, listRight = list:GetPoint() -- its top right, from the frame's
	local _, _, _, rowLeft = _G.TradeSkillSkill1:GetPoint()
	local left = frame:GetWidth() + listRight - list:GetWidth() - insets[1] - rowLeft
	local bar, holder = _G.TradeSkillHighlight, _G.TradeSkillHighlightFrame
	local inset = self.config.highlight_inset -- (inside the parchment's torn edges)
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", holder, "TOPLEFT", left + inset, 0)
	bar:SetPoint("BOTTOMLEFT", holder, "BOTTOMLEFT", left + inset, 0)
	bar:SetWidth(list:GetWidth() + insets[1] + insets[3] - inset * 2)
end

-- The profession's rank in its title ("Enchanting 450/450"), its bar hidden:
-- the dropdowns in its row (settings/positions.lua). Blizzard sets the title
-- as it updates and on each choice.
Module.RankTitle = function(self)
	local name, rank, most = GetTradeSkillLine()
	if name and most and (most > 0) then
		_G.TradeSkillFrameTitleText:SetFormattedText("%s %d/%d", name, rank, most)
	end
end

-- As many recipes as fit the list (its height: settings/positions.lua), the
-- others hidden. Whether that changed the count.
Module.FitList = function(self)
	local rows = kit:RowsFitting(_G.TradeSkillListScrollFrame, _G.TRADE_SKILL_HEIGHT, self.Rows, _G.TradeSkillSkill1)
	if rows == _G.TRADE_SKILLS_DISPLAYED then
		return false
	end
	_G.TRADE_SKILLS_DISPLAYED = rows
	for i = rows + 1, self.Rows do
		_G["TradeSkillSkill" .. i]:Hide()
	end
	return true
end

-- The search in the band (the title on the window's top edge), Have
-- Materials right of it; the filters, the recipes and the chosen one up
-- into the search's old row; the dropdowns and the reagents' names on
-- the parchment, without Blizzard's plates.
Module.Layout = function(self)
	local config = self.config
	local frame = _G.TradeSkillFrame
	local search, filter = _G.TradeSkillFrameEditBox, _G.TradeSkillFrameAvailableFilterCheckButton
	search:SetWidth(config.search_width)
	kit:StyleEditBox(search)
	-- the spellbook's search's look: its font, Blizzard's "Search" pale
	-- (the box's text until typed in), what's typed white (the bands')
	local book = self:GetDB("Blizzard").spellbook
	search:SetFontObject(book.search_font)
	local r, g, b = unpack(kit.config.band_text.value)
	local Hint = function()
		if search:GetText() == _G.SEARCH then
			search:SetTextColor(unpack(book.search_hint_color))
		else
			search:SetTextColor(r, g, b)
		end
	end
	search:HookScript("OnTextChanged", Hint)
	Hint()
	kit:StyleCheckBox(filter)
	-- over the band (the window's level + 1), under the iron's (+ 3)
	for _, part in ipairs({ search, filter }) do
		part:SetFrameLevel(frame:GetFrameLevel() + 2)
	end
	-- how many to make: our box between our arrows (the pages'), in the
	-- room between Create All and Create
	local count = config.count
	local less, box, more = _G.TradeSkillDecrementButton, _G.TradeSkillInputBox, _G.TradeSkillIncrementButton
	kit:StylePager(less, more)
	kit:StyleEditBox(box)
	less:SetSize(count.arrow_size, count.arrow_size)
	more:SetSize(count.arrow_size, count.arrow_size)
	box:SetWidth(count.box_width)
	box:SetJustifyH("CENTER")
	_G.TradeSkillDescription:SetFontObject(config.description_font)
	for _, name in ipairs({ "TradeSkillSubClassDropDown", "TradeSkillInvSlotDropDown" }) do
		kit:StyleDropDown(_G[name])
	end
	-- the chosen recipe's name in ink on the parchment, out of its box,
	-- its icon in the action buttons' border
	kit:HideArt(_G.TradeSkillDetailScrollChildFrame, { "ui%-classtrainer%-detailheader" })
	local icon = _G.TradeSkillSkillIcon
	kit:AddBorder(icon, icon:GetWidth())
	-- its icon and name as a chapter's title, on a dark strip
	local chapter = config.chapter
	local strip = _G.TradeSkillDetailScrollChildFrame:CreateTexture(nil, "BACKGROUND")
	strip:SetTexture(chapter.texture)
	strip:SetTexCoord(unpack(chapter.texcoords))
	strip:SetSize(unpack(chapter.size))
	strip:SetPoint("TOPLEFT", _G.TradeSkillDetailScrollChildFrame, "TOPLEFT", chapter.offset[1], chapter.offset[2])
	-- the reagents' names smaller, wider: most on one line
	for i = 1, _G.MAX_TRADE_SKILL_REAGENTS do
		local plate = _G["TradeSkillReagent" .. i .. "NameFrame"]
		if plate then
			plate:SetAlpha(0)
		end
		local name = _G["TradeSkillReagent" .. i .. "Name"]
		if name then
			name:SetFontObject(config.reagent_font)
			name:SetWidth(config.reagent_name_width)
		end
	end
end

-- The profession's icon socketed in the title plate, the search at the
-- band's left end: as the window first updates (its band and plate are
-- the panel's, made as Blizzard's addon loads).
Module.UpdateGem = function(self)
	local holder = self.Gem
	if not holder then
		local header = _G.TradeSkillFrameTitleText.DiabolicHeader
		if not header then
			return
		end
		holder = kit:AddTitleGem(header)
		holder:EnableMouse(false)
		kit:LineBand(header, { _G.TradeSkillFrameEditBox })
		self.Gem = holder
	end
	-- the profession's spell, by its name (Mining's its own)
	local texture = select(3, GetSpellInfo((GetTradeSkillLine())))
	if texture then
		SetPortraitToTexture(holder.icon, texture)
		holder:Show()
	else
		holder:Hide()
	end
end

Module.StyleTradeSkill = function(self)
	self:Layout()
	self.Rows = _G.TRADE_SKILLS_DISPLAYED
	kit:LightRow(_G.TradeSkillHighlight) -- the chosen recipe in an orange box
	kit:StyleExpanderRows("TradeSkillSkill", self.Rows)
	kit:StyleExpanders(_G.TradeSkillCollapseAllButton)
	-- its All on the recipes' parchment (settings/positions.lua), in the headers' ink
	local all = CreateFont("DiabolicUITradeSkillAll")
	all:SetFont(_G.GameFontNormalLeft:GetFont())
	all:SetTextColor(unpack(self.config.inks.header))
	all:SetShadowColor(0, 0, 0, 0)
	_G.TradeSkillCollapseAllButton:SetNormalFontObject(all)
	_G.TradeSkillCollapseAllButton:SetHighlightFontObject(all)
	self:SpanHighlight()
	hooksecurefunc("TradeSkillFrame_Update", function()
		-- (its count changed: again with it, for the scroll bar)
		if self:FitList() then
			_G.TradeSkillFrame_Update()
			return
		end
		self:ShadeList()
		self:UpdateGem()
		self:RankTitle()
	end)
	hooksecurefunc("TradeSkillFrame_SetSelection", function(id)
		self:InkReagents(id)
		self:ClearScan()
		self:RankTitle()
	end)
	_G.TradeSkillRankFrame:Hide() -- (still there for its event: Blizzard updates on it)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").tradeskill
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	self:WhenLoaded(ADDON, "StyleTradeSkill")
end
