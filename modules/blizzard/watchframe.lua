-- Blizzard's objectives tracker (the WatchFrame) in DiabolicUI's fonts and
-- colors: its "Objectives" title and quest
-- titles in Exocet, in the title color, the objectives in the body font.
-- Fonts and colors only: the lines keep Blizzard's sizes and layout.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: WatchFrame", "LOW")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc

local TITLE_FONT = "DiabolicFont_HeaderRegular12"
local LINE_FONT = "DiabolicFont_SansRegular12"

-- Each line as Blizzard sets it up: a quest or achievement title, or one
-- of its objectives (Blizzard reuses lines, so every time).
local StyleLine = function(line, anchor, verticalOffset, isHeader)
	if isHeader then
		line.text:SetFontObject(TITLE_FONT)
		line.text:SetTextColor(unpack(C.General.Title))
	else
		line.text:SetFontObject(LINE_FONT)
	end
	line.dash:SetFontObject(LINE_FONT)
end

Module.OnEnable = function(self)
	local title = _G.WatchFrameTitle
	title:SetFontObject(TITLE_FONT)
	title:SetTextColor(unpack(C.General.Title))
	hooksecurefunc("WatchFrame_SetLine", StyleLine)
end
