-- The world map's zone names in DiabolicUI's Exocet (the "styleWorldMap"
-- option): the zone you hover and its description. Fonts only, so it works
-- alongside map addons such as Mapster, which move and scale the map but
-- leave these labels' fonts alone.
local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: WorldMap", "LOW")

-- Lua API
local _G = _G

-- WoW API
local hooksecurefunc = _G.hooksecurefunc

local FONT = ([[Interface\AddOns\%s\media\fonts\ExocetBlizzardMedium.ttf]]):format(ADDON)

-- Same size and outline, only the typeface changes.
local SetTypeface = function(fontString)
	if fontString then
		local file, size, flags = fontString:GetFont()
		if (file ~= FONT) then
			fontString:SetFont(FONT, size, flags)
		end
	end
end

Module.UpdateFonts = function(self)
	SetTypeface(_G.WorldMapFrameAreaLabel)
	SetTypeface(_G.WorldMapFrameAreaDescription)
end

Module.OnEnable = function(self)
	if (not self:GetConfig("AddOnSkins").styleWorldMap) then
		return
	end
	self:UpdateFonts()
	-- again whenever the map redraws, should anything have reset them
	hooksecurefunc("WorldMapFrame_Update", function() self:UpdateFonts() end)
end
