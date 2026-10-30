-- Styles Questie's quest tracker like Blizzard's in DiabolicUI, in Diablo
-- III's look (watchframe.lua): the zones in Exocet capitals, off-white, the
-- quest titles in Exocet and gold, the objectives in the body font, and the
-- same space after every quest. Its "Quests (By ...)" line, when it doesn't sort by zone, reads
-- "OBJECTIVES" like Blizzard's title, its button at the right edge; each zone line gets our red square to
-- collapse it, and Blizzard's sounds, a right-click opening Questie's
-- options instead of its yellow "?" by the title; the quest items' buttons look like
-- the action bars' (like TrinketMenu's, trinketmenu.lua).
-- Questie's settings, and the colors of its objectives, are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: QuestieTracker", "LOW")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local math_max = math.max
local type = type
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local IsShiftKeyDown = _G.IsShiftKeyDown
local PlaySound = _G.PlaySound

-- Blizzard's tracker title (WatchFrameTitle)
local OBJECTIVES = _G.OBJECTIVES_TRACKER_LABEL

local style = Engine:GetDB("Objectives").style
-- the action bars' stack size font (settings/actionbars.lua; the copy kept
-- there has no methods of its own)
local COUNT_FONT = "DiabolicFont_SansBold10"
local FONT_SIZE = 12

-- the color Questie's lines start with (GameFontNormal's): its own colors
-- come in the text
local QUESTIE_COLOR = { 1, .82, 0 }

-- What the skin relies on in Questie's code, none of it an API Questie
-- promises: one missing, and Questie has changed. Its tracker is then left
-- as it is from there on, rather than risk errors in it.
local POOL_FUNCTIONS = { "GetLine", "GetNextLine", "GetCurrentLine", "GetHighestIndex" }
local TRACKER_FUNCTIONS = { "Update", "UpdateHeight" }
local broken

-- `missing`: what wasn't there, named in the message
local Break = function(missing)
	if not broken then
		broken = true
		_G.print(L["DiabolicUI: Questie has changed, its tracker is left as it is."] .. " (" .. missing .. ")")
	end
end

-- the first of `names` that isn't a function of `module`, if any
local MissingFunction = function(module, moduleName, names)
	if type(module) ~= "table" then
		return moduleName
	end
	for _, name in ipairs(names) do
		if type(module[name]) ~= "function" then
			return moduleName .. "." .. name
		end
	end
end

-- what a line lacks of those Questie's TrackerLinePool makes, if anything
local MissingFromLine = function(line)
	local label, expandZone = line.label, line.expandZone
	if type(line.SetMode) ~= "function" then
		return "line.SetMode"
	elseif type(label) ~= "table" or (label.frame ~= line) then
		return "line.label.frame"
	elseif type(label._SetText) ~= "function" then
		return "line.label._SetText"
	elseif type(expandZone) ~= "table" or (type(expandZone.SetMode) ~= "function") then
		return "line.expandZone.SetMode" -- (its mode is cleared before every update)
	elseif not expandZone:GetScript("OnMouseUp") then
		return "line.expandZone OnMouseUp"
	end
end

-- zones, quests and achievements: titles over the objectives
local IsTitle = function(mode)
	return (mode == "zone") or (mode == "quest") or (mode == "achieve")
end

-- The font of each kind of line, every time Questie sets one (it sets its
-- own font when a line changes kind). With SetFont, like Questie: a font
-- set that way wins over any font object.
local SetMode = function(line, mode)
	if broken then
		return
	end
	local label = line.label
	if line.CollapseButton and (mode ~= "zone") then
		line.CollapseButton:Hide()
	end
	line.DiabolicTitle = nil
	local font, color
	if (mode == "zone") then
		font, color = style.header_font, style.header_color
	elseif IsTitle(mode) then
		font, color = style.title_font, style.title_color
	else
		font, color = style.line_font, QUESTIE_COLOR
	end
	font = _G[font]
	label:SetFont(font:GetFont())
	label:SetShadowOffset(font:GetShadowOffset())
	label:SetShadowColor(font:GetShadowColor())
	label:SetTextColor(unpack(color))
	label:SetHeight(FONT_SIZE)
end

-- The collapse button, in the layout of Blizzard's (WatchFrame.xml): its
-- bar while the zone shows its quests (expandZone's mode 1), its cross
-- once collapsed.
local UpdateCollapseButton = function(line)
	local button, expanded = line.CollapseButton, (line.expandZone.mode == 1)
	local top = expanded and .5 or 0
	button:GetNormalTexture():SetTexCoord(0, .5, top, top + .5)
	button:GetPushedTexture():SetTexCoord(.5, 1, top, top + .5)
	-- at the tracker's right edge on the "OBJECTIVES" line (the first), as
	-- in Diablo III; just after the text on a zone's
	button:ClearAllPoints()
	if line.DiabolicTitle then
		button:SetPoint("TOPRIGHT", line:GetParent(), "TOPRIGHT", -4, (button:GetHeight() - line.label:GetHeight()) / 2)
	else
		button:SetPoint("LEFT", line.label, "LEFT", line.label:GetStringWidth() + 4, 0)
	end
	button:Show()
end

-- Questie's "?" by its title, which opens its options on a left-click
-- (TrackerHeaderFrame), if it has one.
local QuestieIcon = function()
	local header = _G.QuestieLoader:ImportModule("TrackerHeaderFrame")
	return (type(header) == "table") and header.headerFrame and header.headerFrame.questieIcon, header
end

-- The "?" out of sight when it's by our title (without Questie's own
-- header), every time Questie shows it again.
local HideQuestieIcon = function()
	local icon, header = QuestieIcon()
	if icon and not header.headerFrame:IsShown() then
		icon:Hide()
	end
end

-- Questie's options, as its "?" opens them.
local OpenOptions = function()
	local icon = QuestieIcon()
	local click = icon and icon:GetScript("OnClick")
	if click then
		click(icon, "LeftButton")
	end
end

-- A zone collapsed or expanded, by its line or its button: Questie's own
-- click, and Blizzard's sounds. A right-click: Questie's options.
local ToggleZone = function(expandZone, original, mouseButton)
	original(expandZone, mouseButton)
	if (mouseButton == "RightButton") then
		OpenOptions()
	elseif (mouseButton == "LeftButton") and not IsShiftKeyDown() then
		PlaySound((expandZone.mode == 1) and "igMiniMapOpen" or "igMiniMapClose")
		UpdateCollapseButton(expandZone:GetParent())
	end
end

local CreateCollapseButton = function(line)
	local expandZone = line.expandZone
	local original = expandZone:GetScript("OnMouseUp")
	expandZone:SetScript("OnMouseUp", function(self, mouseButton) ToggleZone(self, original, mouseButton) end)
	local button = CreateFrame("Button", nil, line)
	button:SetFrameLevel(expandZone:GetFrameLevel() + 1) -- over the line's click area
	Engine:GetModule("Blizzard: WatchFrame"):StyleCollapseButton(button)
	button:SetScript("OnClick", function() ToggleZone(expandZone, original, "LeftButton") end)
	line.CollapseButton = button
end

-- A title's own colors (its level's, an achievement's yellow, a zone's
-- gray) taken out, so it shows in ours. A zone line: in capitals, "OBJECTIVES" for Questie's
-- "Quests (By ...)", and its button instead of Questie's " +".
local SetText = function(label, text)
	local line = label.frame
	if broken or (not text) then
		return
	end
	if IsTitle(line.mode) then
		local plain = (text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
		if (line.mode == "zone") then
			plain = plain:gsub(" %+$", "")
			line.DiabolicTitle = (plain:find("^Quests %(By .*%)$") ~= nil) or nil
			if line.DiabolicTitle then
				plain = OBJECTIVES
			end
			plain = plain:upper()
		end
		if (plain ~= text) then
			label:_SetText(plain) -- Questie's label keeps the original as _SetText
		end
		if (line.mode == "zone") and line.expandZone then
			if not line.CollapseButton then
				CreateCollapseButton(line)
			end
			UpdateCollapseButton(line)
		end
	end
end

local StyleLine = function(line)
	if broken or line.DiabolicStyled then
		return
	end
	local missing = MissingFromLine(line)
	if missing then
		return Break(missing)
	end
	hooksecurefunc(line, "SetMode", SetMode)
	hooksecurefunc(line.label, "SetText", SetText)
	line.DiabolicStyled = true
	-- already in use
	if line.mode then
		SetMode(line, line.mode)
		SetText(line.label, line.label:GetText())
	end
end

-- The same space after every quest. Questie gives the last line of each
-- quest its "Padding Between Quests", but sizes the wrapped objective lines
-- again afterwards without it: quests ending on a wrapped line ran into the
-- next one. Every line is sized again here, as Questie does: its text
-- (font size + 1 a line when it wraps), then 1 below an objective, 4 below
-- a title, the padding below a quest's last line.
Module.UpdateSpacing = function(self)
	local tracker, questie = self.Tracker, _G.Questie
	if broken or InCombatLockdown() or not (tracker.started and questie and questie.db and questie.db.profile) then
		return
	end
	local pool = self.LinePool
	if not pool.GetCurrentLine() then -- nothing tracked (Questie measures nothing then either)
		return
	end
	local padding = (questie.db.profile.trackerQuestPadding or 0) + 2
	local count = pool.GetHighestIndex()
	for i = 1, count do
		local line = pool.GetLine(i)
		if line and line:IsShown() and line.mode then
			local label = line.label
			local lines = label.GetNumLines and label:GetNumLines() or 1
			if (lines > 1) then
				local _, size = label:GetFont()
				label:SetHeight((size + 1) * lines + 1)
			end
			local nextLine = (i < count) and pool.GetLine(i + 1)
			local gap
			if (not nextLine) or (not nextLine:IsShown()) or IsTitle(nextLine.mode) then
				gap = (line.mode == "zone") and 4 or padding -- a quest's last line
			else
				gap = (line.mode == "objective") and 1 or 4
			end
			line:SetHeight(math_max(label:GetHeight(), FONT_SIZE) + gap)
		end
	end
	tracker:UpdateHeight()
end

-- A quest item's button like the action bars' 36px ones, at Questie's size:
-- the icon inset in the border, the slot behind it. Every time Questie
-- gives it an item, as it sets its textures and sizes again then.
local Place = function(texture, element, scale)
	texture:ClearAllPoints()
	texture:SetSize(element.size[1] * scale, element.size[2] * scale)
	for _, point in ipairs(element.points) do
		texture:SetPoint(point[1], point[2] * scale, point[3] * scale)
	end
end

local SetItem = function(button)
	if broken or not (button.itemId and button:IsShown()) then
		return
	end
	local style = Module:GetDB("ActionBars").visuals.buttons[36]
	local scale = button:GetWidth() / 36
	for _, icon in ipairs({ button:GetNormalTexture(), button:GetPushedTexture() }) do
		Place(icon, style.icon, scale)
		icon:SetTexCoord(unpack(style.icon.texcoords))
	end
	if not button.DiabolicBorder then
		button.DiabolicSlot = button:CreateTexture(nil, "BACKGROUND")
		button.DiabolicSlot:SetTexture(style.slot.texture)
		button.DiabolicBorder = button:CreateTexture(nil, "OVERLAY")
		button.DiabolicBorder:SetTexture(style.border_normal.texture)
	end
	Place(button.DiabolicSlot, style.slot, scale)
	Place(button.DiabolicBorder, style.border_normal, scale)
	button:SetHighlightTexture(style.border_normal_highlight.texture)
	Place(button:GetHighlightTexture(), style.border_normal_highlight, scale)
	-- the cooldown over the icon, the charges in the bars' font
	for _, child in ipairs({ button:GetChildren() }) do
		if (child:GetObjectType() == "Cooldown") then
			child:ClearAllPoints()
			child:SetAllPoints(button:GetNormalTexture())
		end
	end
	if button.count then
		button.count:SetFont(_G[COUNT_FONT]:GetFont())
	end
end

local StyleItemButton = function(button)
	if button and (not button.DiabolicStyled) and (type(button.SetItem) == "function") then
		hooksecurefunc(button, "SetItem", SetItem)
		button.DiabolicStyled = true
	end
end

-- The lines Questie has made by now.
Module.StyleLines = function(self)
	local pool = self.LinePool
	local i = 1
	while pool.GetLine(i) do
		StyleLine(pool.GetLine(i))
		i = i + 1
	end
end

-- Questie makes its lines when its tracker starts, some time after login,
-- in a coroutine that yields between them: hooking that would fail (a hook
-- is C code, nothing can yield inside it). Each line is styled when Questie
-- takes it to use instead, before it sets its kind and text.
Module.StyleQuestie = function(self)
	local loader = _G.QuestieLoader
	if type(loader.ImportModule) ~= "function" then
		return Break("QuestieLoader.ImportModule")
	end
	local pool, tracker = loader:ImportModule("TrackerLinePool"), loader:ImportModule("QuestieTracker")
	local missing = MissingFunction(pool, "TrackerLinePool", POOL_FUNCTIONS) or MissingFunction(tracker, "QuestieTracker", TRACKER_FUNCTIONS)
	if missing then
		return Break(missing)
	end
	self.LinePool, self.Tracker = pool, tracker
	self:StyleLines()
	local _, header = QuestieIcon()
	if (type(header) == "table") and (type(header.Update) == "function") then
		hooksecurefunc(header, "Update", HideQuestieIcon)
		HideQuestieIcon()
	end
	hooksecurefunc(self.Tracker, "Update", function() self:UpdateSpacing() end)
	hooksecurefunc(pool, "GetNextLine", function()
		local line = (not broken) and pool.GetCurrentLine()
		if line then
			StyleLine(line)
		end
	end)
	-- its quest items' buttons, the same way (left as they are without these)
	if not MissingFunction(pool, "TrackerLinePool", { "GetNextItemButton", "GetCurrentButton" }) then
		hooksecurefunc(pool, "GetNextItemButton", function()
			if not broken then
				StyleItemButton(pool.GetCurrentButton())
			end
		end)
	end
end

Module.ADDON_LOADED = function(self, event, addon)
	if _G.QuestieLoader then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleQuestie()
	end
end

Module.OnEnable = function(self)
	if _G.QuestieLoader then
		self:StyleQuestie()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
