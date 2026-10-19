-- Gives Blizzard's achievement window Diablo III's (windows.lua): the stone
-- window in its iron frame instead of the wood and metal, the red band on
-- top with "Achievements" in a plate on the window's edge and the points
-- big in a cartouche, the lists in darker panels, the categories as flat
-- red buttons (the chosen one lit), the summary's sections under title
-- bars, its progress bars orange in spiked frames, the achievements
-- darker, and the tabs (Blizzard's and Overachiever's) as buttons in a row
-- under the band, the list's filter at its end; Overachiever's pages
-- (Search, Suggestions, Watch) in the same look. Art, fonts and places
-- only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Achievements", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs
local select = select
local type = type
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded

-- Blizzard's art in the window, by name: the header's banner (its points
-- and shield stay), and the backgrounds of the lists.
local HIDDEN = {
	"AchievementFrameHeaderLeft", "AchievementFrameHeaderRight", "AchievementFrameHeaderPointBorder",
	"AchievementFrameHeaderRightDDLInset", "AchievementFrameAchievementsBackground",
	"AchievementFrameSummaryBackground", "AchievementFrameComparisonBackground",
	"AchievementFrameComparisonDark", "AchievementFrameComparisonWatermark"
}

-- the frames whose panel (a backdrop of their own, or an unnamed child's)
-- becomes one of ours
local PANELS = { "AchievementFrameCategories", "AchievementFrameAchievements", "AchievementFrameStatsBG", "AchievementFrameSummary" }

-- the summary's bars, the big one first, and the parts of Blizzard's frame
-- around each (their hover glow included)
local BARS = { "AchievementFrameSummaryCategoriesStatusBar" }
for i = 1, 8 do
	BARS[i + 1] = "AchievementFrameSummaryCategoriesCategory" .. i
end
local BAR_PARTS = { "Left", "Right", "Middle", "ButtonLeft", "ButtonRight", "ButtonMiddle" }

-- the summary's section headers
local SECTIONS = { "AchievementFrameSummaryCategoriesHeader", "AchievementFrameSummaryAchievementsHeader" }

local kit

-- The panel of each frame in PANELS.
local StylePanels = function()
	for _, name in ipairs(PANELS) do
		local frame = _G[name]
		if frame then
			if frame:GetBackdrop() then
				kit:StylePanel(frame)
			end
			for i = 1, select("#", frame:GetChildren()) do
				local child = select(i, frame:GetChildren())
				if (not child:GetName()) and child:GetBackdrop() then
					kit:StylePanel(child)
				end
			end
		end
	end
end

-- A category as a flat red button, lit when chosen or under the mouse;
-- the subcategories as Diablo III's list under it: a bullet and smaller
-- text on the window's stone, the red only when chosen or under the mouse.
-- The label on the left, kept inside. Every time Blizzard shows one, as it
-- sets its font each time.
local StyleCategory = function(button)
	local config = Module.config
	local spec = kit.config.rect_button
	if not button.DiabolicArt then
		button.background:SetAlpha(0)
		local highlight = button:GetHighlightTexture()
		if highlight then
			highlight:SetAlpha(0)
		end
		local height = button:GetHeight()
		button.DiabolicArt = kit:CreateSlices(button, "BACKGROUND", spec, spec.texture.normal, height)
		button.DiabolicLitArt = kit:CreateSlices(button, "BORDER", spec, spec.texture.lit, height)
		kit:AddLit(button, button.DiabolicLitArt)
		local bullet = button:CreateTexture(nil, "ARTWORK")
		bullet:SetTexture([[Interface\ChatFrame\ChatFrameBackground]])
		bullet:SetVertexColor(unpack(config.bullet_color))
		bullet:SetSize(config.bullet_size, config.bullet_size)
		bullet:SetPoint("LEFT", button, "LEFT", config.bullet_offset, 0)
		button.DiabolicBullet = bullet
	end
	local sub = (type(button.parentID) == "number")
	local x
	if sub then
		button.DiabolicArt:Hide()
		button.DiabolicLitArt:SetAlpha(config.subcategory_lit_alpha)
		button.DiabolicBullet:Show()
		button.label:SetFontObject(config.subcategory_font)
		button.label:SetTextColor(unpack(config.subcategory_color))
		x = config.subcategory_text_offset
	else
		button.DiabolicArt:Show()
		button.DiabolicLitArt:SetAlpha(1)
		button.DiabolicBullet:Hide()
		button.label:SetFontObject(config.category_font)
		button.label:SetTextColor(unpack(config.category_color))
		x = config.category_text_offset
	end
	button.label:SetJustifyH("LEFT")
	button.label:ClearAllPoints()
	button.label:SetPoint("LEFT", button, "LEFT", x, 0)
	button.label:SetWidth(button:GetWidth() - x - config.category_text_offset)
end

-- The achievements darker, the ones not earned darker still, their
-- description light on them (Blizzard's is black, for its parchment).
local StyleRow = function(row, earned)
	local name = row:GetName()
	local background, title = name and _G[name .. "Background"], name and _G[name .. "TitleBackground"]
	local config = Module.config
	local description = row.description or (name and _G[name .. "Description"])
	if description then
		description:SetTextColor(unpack(config.row_text_color))
		description:SetShadowOffset(1, -1)
	end
	if background then
		background:SetVertexColor(unpack((earned ~= false) and config.row_color or config.row_color_unearned))
	end
	if title then
		title:SetVertexColor(unpack((earned ~= false) and config.row_title_color or config.row_title_color_unearned))
	end
end

-- the lists of achievements (HybridScrollFrames'), with their rows
local ROW_LISTS = { "AchievementFrameAchievementsContainer", "AchievementFrameSummaryAchievements", "AchievementFrameComparisonContainer" }

-- Each row, as Blizzard colors it: its Saturate and Desaturate are its own
-- (copied when it loads, so hooking Blizzard's functions misses them).
Module.StyleRows = function(self)
	for _, list in ipairs(ROW_LISTS) do
		local buttons = _G[list] and _G[list].buttons
		for _, button in ipairs(buttons or {}) do
			-- a comparison row is two: the player's and the friend's
			for _, row in ipairs({ button, button.player or false, button.friend or false }) do
				if row and (not row.DiabolicRow) and (type(row.Saturate) == "function") then
					row.DiabolicRow = true
					hooksecurefunc(row, "Saturate", function() StyleRow(row, true) end)
					hooksecurefunc(row, "Desaturate", function() StyleRow(row, false) end)
					-- (the summary's rows don't say: they're all earned)
					StyleRow(row, (row.saturated ~= nil) or (list == "AchievementFrameSummaryAchievements"))
				end
			end
		end
	end
end

-- Blizzard's tabs and any an addon has added (Overachiever does), each once.
Module.StyleTabs = function(self)
	local i, tab = 1, _G.AchievementFrameTab1
	while tab do
		if not tab.DiabolicArt then
			kit:StyleTab(tab, { inset = self.config.tab_inset, padding = self.config.tab_padding })
		end
		i = i + 1
		tab = _G["AchievementFrameTab" .. i]
	end
end

-- Whether `child` is one of UIPanelButtonTemplate's buttons.
local IsPanelButton = function(child)
	local texture = child:IsObjectType("Button") and child:GetNormalTexture()
	local file = texture and texture:GetTexture()
	return file and file:lower():find("ui%-panel%-button")
end

-- The controls on an Overachiever page's left: its labels pale, its
-- buttons ours, its dropdowns in the dark plate; each once.
Module.StyleControls = function(self, panel)
	local config = self.config
	for _, region in ipairs({ panel:GetRegions() }) do
		if region:IsObjectType("FontString") then
			region:SetTextColor(unpack(config.category_color))
		end
	end
	for _, child in ipairs({ panel:GetChildren() }) do
		local name = child:GetName()
		if child.DiabolicStyled then
			-- (done)
		elseif IsPanelButton(child) then
			child.DiabolicStyled = true
			kit:StyleButton(child, config.control_button_height)
		elseif name and _G[name .. "Button"] and _G[name .. "Middle"] then
			child.DiabolicStyled = true
			kit:StyleDropDown(child, config.filter_offset)
		end
	end
end

-- Overachiever's pages (its tabs' frames): the list in our panel instead
-- of the parchment, its rows ours, the controls on the left styled, its
-- title in our section font. Its controls are made after its pages: they
-- are styled each time the window shows.
Module.StyleOverachiever = function(self)
	local i, tab = 1, _G.AchievementFrameTab1
	while tab do
		local frame = tab.frame
		if frame and (not frame.DiabolicStyled) then
			frame.DiabolicStyled = true
			kit:HideTextures(frame)
			for _, child in ipairs({ frame:GetChildren() }) do
				if (not child:GetName()) and child:GetBackdrop() then
					kit:StylePanel(child)
				end
			end
			ROW_LISTS[#ROW_LISTS + 1] = frame:GetName()
		end
		if frame and frame.panel then
			self:StyleControls(frame.panel)
		end
		i = i + 1
		tab = _G["AchievementFrameTab" .. i]
	end
	local left = _G.Overachiever_LeftFrame
	if left and left.label then
		left.label:SetFontObject(kit.config.section.font)
		left.label:SetTextColor(unpack(kit.config.section.color))
	end
	self:StyleRows()
end

Module.StyleAchievements = function(self)
	local config = self.config
	local frame = _G.AchievementFrame

	-- the window, reaching up over the title, instead of the wood and metal
	-- (all textures of the window's own)
	kit:HideTextures(frame)
	for _, name in ipairs(HIDDEN) do
		local region = _G[name]
		if region then
			region:SetAlpha(0)
		end
	end
	if _G.AchievementFrameStatsBG then
		kit:HideTextures(_G.AchievementFrameStatsBG)
	end
	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "zoltun")
	self.Window = window
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)

	-- "Achievements" in the plate on the window's edge, the points big in
	-- a cartouche in the band, after the shield
	local title = _G.AchievementFrameHeaderTitle
	title:SetText(_G.ACHIEVEMENTS)
	kit:SetTitle(self.Header, title)
	kit:CreateCartouche(self.Header, _G.AchievementFrameHeaderPoints, _G.AchievementFrameHeaderShield)

	-- the close button in the band's right end, the list's filter in a
	-- dark plate
	kit:StyleClose(_G.AchievementFrameCloseButton, window, self.Header)
	local filter = _G.AchievementFrameFilterDropDown
	if filter then
		kit:StyleDropDown(filter, config.filter_offset, config.filter_inset)
		filter:ClearAllPoints()
		filter:SetPoint("TOPRIGHT", self.Header, "BOTTOMRIGHT", unpack(config.filter_position))
	end

	StylePanels()

	-- the summary: orange bars in spiked frames, their ends kept apart
	local spike = kit.config.bar.spike
	for i, name in ipairs(BARS) do
		local bar = _G[name]
		if bar then
			local regions = {}
			for _, part in ipairs(BAR_PARTS) do
				regions[#regions + 1] = _G[name .. part]
			end
			bar:SetHeight(config.bar_height)
			kit:StyleBar(bar, regions)
			local label, text = _G[name .. "Label"] or _G[name .. "Title"], _G[name .. "Text"]
			if label then
				label:SetFontObject(config.bar_font)
				label:SetTextColor(unpack(config.bar_label_color))
				label:ClearAllPoints()
				label:SetPoint("LEFT", bar, "LEFT", 8, config.bar_label_offset)
			end
			if text then
				text:SetFontObject(config.bar_text_font)
				text:SetTextColor(unpack(config.bar_text_color))
				text:ClearAllPoints()
				text:SetPoint("RIGHT", bar, "RIGHT", -8, 0)
			end
			if (i == 1) then
				bar:SetWidth(config.summary_width - spike * 2)
			else
				bar:SetWidth((config.summary_width - spike * 4 - config.bar_gap) / 2)
				-- the right column, after the left one's spike and its own
				if (i % 2 == 1) then
					bar:ClearAllPoints()
					bar:SetPoint("TOPLEFT", _G[BARS[i - 1]], "TOPRIGHT", spike * 2 + config.bar_gap, 0)
				end
			end
		end
	end
	-- the summary's sections under title bars
	for _, name in ipairs(SECTIONS) do
		if _G[name] then
			kit:StyleSection(_G[name], _G[name .. "Title"], { _G[name .. "Texture"], _G[name .. "Header"] })
		end
	end

	-- the categories, as Blizzard shows them
	hooksecurefunc("AchievementFrameCategories_DisplayButton", StyleCategory)

	-- the achievements, as Blizzard colors them; the summary's, made the
	-- first time it shows
	self:StyleRows()
	hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function() self:StyleRows() end)

	-- Blizzard's header (its art hidden) over the band only: it reached
	-- down over the tabs' row and took their clicks (Overachiever drags
	-- the window by it, so it keeps its mouse)
	local header = _G.AchievementFrameHeader
	header:ClearAllPoints()
	header:SetAllPoints(self.Header)

	-- the tabs in a row under the band, and any added later, once it shows
	local tab = _G.AchievementFrameTab1
	if tab then
		tab:ClearAllPoints()
		tab:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", unpack(config.tab_offset))
		kit:AddTabStrip(self.Header)
	end
	self:StyleTabs()
	frame:HookScript("OnShow", function()
		self:StyleTabs()
		self:StyleOverachiever()
	end)
	-- Overachiever's, as it adds them (it may do so once the window shows)
	hooksecurefunc("PanelTemplates_SetNumTabs", function(panel)
		if (panel == frame) then
			self:StyleTabs()
		end
	end)
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "Blizzard_AchievementUI") then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleAchievements()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").achievements
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	if IsAddOnLoaded("Blizzard_AchievementUI") then
		self:StyleAchievements()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
