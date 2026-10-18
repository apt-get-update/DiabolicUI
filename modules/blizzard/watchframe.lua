-- Blizzard's objectives tracker (the WatchFrame) in Diablo III's look: its
-- "OBJECTIVES" title in Exocet capitals, off-white, the quest titles in
-- Exocet and gold, and our red square to collapse it (shared with Questie's
-- tracker, questietracker.lua). Fonts, colors and textures only: the lines
-- keep Blizzard's sizes and layout.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: WatchFrame", "LOW")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc

local style = Engine:GetDB("Objectives").style

-- Our red square on a collapse button, with the texture coordinates its
-- code already sets (the same layout as Blizzard's), and no round glow.
Module.StyleCollapseButton = function(self, button)
	button:SetNormalTexture(style.collapse.texture)
	button:SetPushedTexture(style.collapse.texture)
	button:SetSize(style.collapse.size, style.collapse.size)
	local highlight = button:GetHighlightTexture()
	if highlight then
		highlight:SetTexture(nil)
	end
end

-- Each line as Blizzard sets it up: a quest or achievement title, or one
-- of its objectives (Blizzard reuses lines, so every time).
local StyleLine = function(line, anchor, verticalOffset, isHeader)
	if isHeader then
		line.text:SetFontObject(style.title_font)
		line.text:SetTextColor(unpack(style.title_color))
	else
		line.text:SetFontObject(style.line_font)
	end
	line.dash:SetFontObject(style.line_font)
end

-- The title in capitals, every time Blizzard sets it ("Objectives (3)").
local SetTitle = function(title, text)
	if text and (text ~= text:upper()) then
		title:SetText(text:upper())
	end
end

Module.OnEnable = function(self)
	local title = _G.WatchFrameTitle
	title:SetFontObject(style.header_font)
	title:SetTextColor(unpack(style.header_color))
	hooksecurefunc(title, "SetText", SetTitle)
	SetTitle(title, title:GetText())
	self:StyleCollapseButton(_G.WatchFrameCollapseExpandButton)
	hooksecurefunc("WatchFrame_SetLine", StyleLine)
end
