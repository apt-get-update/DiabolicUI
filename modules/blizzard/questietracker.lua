-- Styles Questie's quest tracker like Blizzard's in DiabolicUI
-- (watchframe.lua; the "styleQuestieTracker" option): the zones and the
-- quest titles in Exocet, the quest titles in the title color, the
-- objectives in the body font. Fonts and colors only: Questie's settings
-- and layout, and the colors of its objectives, are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: QuestieTracker", "LOW")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc

local TITLE_FONT = "DiabolicFont_HeaderRegular12"
local LINE_FONT = "DiabolicFont_SansRegular12"
local FONT_SIZE = 12

-- the color Questie's lines start with (GameFontNormal's): its own colors
-- come in the text
local QUESTIE_COLOR = { 1, .82, 0 }

local IsTitle = function(mode)
	return (mode == "quest") or (mode == "achieve")
end

-- The font of each kind of line, every time Questie sets one (it sets its
-- own font when a line changes kind).
local SetMode = function(line, mode)
	local label = line.label
	label:SetFontObject(((mode == "objective") or (mode == nil)) and LINE_FONT or TITLE_FONT)
	label:SetTextColor(unpack(IsTitle(mode) and C.General.Title or QUESTIE_COLOR))
	label:SetHeight(FONT_SIZE)
end

-- A title's own colors (its level's, an achievement's yellow) taken out,
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

-- Questie makes its lines once, when its tracker starts (some time after
-- login, a few at a time).
Module.StyleLines = function(self)
	local pool = self.LinePool
	local i = 1
	while pool.GetLine(i) do
		StyleLine(pool.GetLine(i))
		i = i + 1
	end
end

Module.StyleQuestie = function(self)
	self.LinePool = _G.QuestieLoader:ImportModule("TrackerLinePool")
	self:StyleLines()
	hooksecurefunc(self.LinePool, "Initialize", function() self:StyleLines() end)
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
