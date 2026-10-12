-- Styles Questie's quest tracker like Blizzard's in DiabolicUI
-- (watchframe.lua; the "styleQuestieTracker" option): the zones and the
-- quest titles in Exocet and the title color, the objectives in the body
-- font, and the same space after every quest. Its "Quests (By ...)" line,
-- when it doesn't sort by zone, reads "Objectives" like Blizzard's title;
-- each zone line gets Blizzard's collapse button, and its sounds.
-- Questie's settings, and the colors of its objectives, are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: QuestieTracker", "LOW")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")

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

local TITLE_FONT = "DiabolicFont_HeaderRegular12"
local LINE_FONT = "DiabolicFont_SansRegular12"
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

local Break = function()
	if not broken then
		broken = true
		_G.print(L["DiabolicUI: Questie has changed, its tracker is left as it is. Turn off Style Questie's Tracker in /dui config if it misbehaves."])
	end
end

local HasFunctions = function(module, names)
	if type(module) ~= "table" then
		return false
	end
	for _, name in ipairs(names) do
		if type(module[name]) ~= "function" then
			return false
		end
	end
	return true
end

-- a line as Questie's TrackerLinePool makes it
local IsQuestieLine = function(line)
	local label, expandZone = line.label, line.expandZone
	return (type(line.SetMode) == "function") and label and (label.frame == line)
		and (type(label._SetText) == "function") and expandZone and (type(expandZone.mode) == "number")
		and expandZone:GetScript("OnMouseUp") and true or false
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
	local font = _G[((mode == "objective") or (mode == nil)) and LINE_FONT or TITLE_FONT]
	label:SetFont(font:GetFont())
	label:SetShadowOffset(font:GetShadowOffset())
	label:SetShadowColor(font:GetShadowColor())
	label:SetTextColor(unpack(IsTitle(mode) and C.General.Title or QUESTIE_COLOR))
	label:SetHeight(FONT_SIZE)
end

-- Blizzard's collapse button (WatchFrame.xml): its arrow points up while
-- the zone shows its quests (expandZone's mode 1), down once collapsed.
local UpdateCollapseButton = function(line)
	local button, expanded = line.CollapseButton, (line.expandZone.mode == 1)
	local top = expanded and .5 or 0
	button:GetNormalTexture():SetTexCoord(0, .5, top, top + .5)
	button:GetPushedTexture():SetTexCoord(.5, 1, top, top + .5)
	-- just after the text
	button:ClearAllPoints()
	button:SetPoint("LEFT", line.label, "LEFT", line.label:GetStringWidth() + 4, 0)
	button:Show()
end

-- A zone collapsed or expanded, by its line or its button: Questie's own
-- click, and Blizzard's sounds.
local ToggleZone = function(expandZone, original, mouseButton)
	original(expandZone, mouseButton)
	if (mouseButton == "LeftButton") and not IsShiftKeyDown() then
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
	button:SetSize(16, 16)
	button:SetNormalTexture([[Interface\Buttons\UI-Panel-QuestHideButton]])
	button:SetPushedTexture([[Interface\Buttons\UI-Panel-QuestHideButton]])
	button:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]], "ADD")
	button:SetScript("OnClick", function() ToggleZone(expandZone, original, "LeftButton") end)
	line.CollapseButton = button
end

-- A title's own colors (its level's, an achievement's yellow, a zone's gray)
-- taken out, so it shows in the title color. A zone line: "Objectives" for
-- Questie's "Quests (By ...)", and its button instead of Questie's " +".
local SetText = function(label, text)
	local line = label.frame
	if (not broken) and IsTitle(line.mode) and text then
		local plain = (text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
		if (line.mode == "zone") then
			plain = plain:gsub(" %+$", "")
			if plain:find("^Quests %(By .*%)$") then
				plain = OBJECTIVES
			end
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
	if not IsQuestieLine(line) then
		return Break()
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
		return Break()
	end
	local pool, tracker = loader:ImportModule("TrackerLinePool"), loader:ImportModule("QuestieTracker")
	if not (HasFunctions(pool, POOL_FUNCTIONS) and HasFunctions(tracker, TRACKER_FUNCTIONS)) then
		return Break()
	end
	self.LinePool, self.Tracker = pool, tracker
	self:StyleLines()
	hooksecurefunc(self.Tracker, "Update", function() self:UpdateSpacing() end)
	hooksecurefunc(pool, "GetNextLine", function()
		local line = (not broken) and pool.GetCurrentLine()
		if line then
			StyleLine(line)
		end
	end)
end

Module.ADDON_LOADED = function(self, event, addon)
	if _G.QuestieLoader then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleQuestie()
	end
end

Module.OnEnable = function(self)
	if (not self:GetConfig("AddOnSkins").styleQuestieTracker) then
		return
	end
	if _G.QuestieLoader then
		self:StyleQuestie()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
