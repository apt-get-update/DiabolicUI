-- Styles Questie's quest tracker like Blizzard's in DiabolicUI
-- (watchframe.lua; the "styleQuestieTracker" option): the zones (or "Quests
-- (by proximity)") and the quest titles in Exocet and the title color, the
-- objectives in the body font, and the same space after every quest.
-- Questie's settings, and the colors of its objectives, are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: QuestieTracker", "LOW")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local math_max = math.max
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown

local TITLE_FONT = "DiabolicFont_HeaderRegular12"
local LINE_FONT = "DiabolicFont_SansRegular12"
local FONT_SIZE = 12

-- the color Questie's lines start with (GameFontNormal's): its own colors
-- come in the text
local QUESTIE_COLOR = { 1, .82, 0 }

-- zones, quests and achievements: titles over the objectives
local IsTitle = function(mode)
	return (mode == "zone") or (mode == "quest") or (mode == "achieve")
end

-- The font of each kind of line, every time Questie sets one (it sets its
-- own font when a line changes kind). With SetFont, like Questie: a font
-- set that way wins over any font object.
local SetMode = function(line, mode)
	local label = line.label
	local font = _G[((mode == "objective") or (mode == nil)) and LINE_FONT or TITLE_FONT]
	label:SetFont(font:GetFont())
	label:SetShadowOffset(font:GetShadowOffset())
	label:SetShadowColor(font:GetShadowColor())
	label:SetTextColor(unpack(IsTitle(mode) and C.General.Title or QUESTIE_COLOR))
	label:SetHeight(FONT_SIZE)
end

-- A title's own colors (its level's, an achievement's yellow, a zone's gray) taken out,
-- so it shows in the title color.
local SetText = function(label, text)
	if IsTitle(label.frame.mode) and text then
		local plain = (text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
		if (plain ~= text) then
			label:_SetText(plain) -- Questie's label keeps the original as _SetText
		end
	end
end

local StyleLine = function(line)
	if line.DiabolicStyled then
		return
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
	if InCombatLockdown() or not (tracker and tracker.started and questie and questie.db) then
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
	local pool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	self.LinePool = pool
	self.Tracker = _G.QuestieLoader:ImportModule("QuestieTracker")
	self:StyleLines()
	hooksecurefunc(self.Tracker, "Update", function() self:UpdateSpacing() end)
	hooksecurefunc(pool, "GetNextLine", function()
		local line = pool.GetCurrentLine()
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
