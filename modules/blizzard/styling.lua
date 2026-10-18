-- Tints Blizzard's character and world map frames
-- (and the bags, unless a bag addon replaces them), in DiabolicUI's colors:
-- textures in the backdrop color, text in the title color.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Styling", "LOW")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local pairs = pairs
local select = select
local unpack = unpack

-- Ignore the container frames if one of our standalone bag addons are loaded
local Backpacker = not(Engine:IsAddOnEnabled("Backpacker") or Engine:IsAddOnEnabled("BlizzardBagsPlus")) or nil

-- List of elements to be styled
local elements = {
	["CharacterFrame"] = true,
	["CharacterModelFrame"] = true,
	["CharacterFrameTab1"] = true,
	["CharacterFrameTab2"] = true,
	["CharacterFrameTab3"] = true,
	["CharacterFrameTab4"] = true,
	["CharacterFrameTab5"] = true,
	["ContainerFrame1"] = Backpacker,
	["ContainerFrame2"] = Backpacker,
	["ContainerFrame3"] = Backpacker,
	["ContainerFrame4"] = Backpacker,
	["ContainerFrame5"] = Backpacker,
	["ContainerFrame6"] = Backpacker,
	["ContainerFrame7"] = Backpacker,
	["ContainerFrame8"] = Backpacker,
	["ContainerFrame9"] = Backpacker,
	["ContainerFrame10"] = Backpacker,
	["ContainerFrame11"] = Backpacker,
	["ContainerFrame12"] = Backpacker,
	["ContainerFrame13"] = Backpacker,
	["PaperDollFrame"] = true,
	["PlayerStatFrameLeftDropDown"] = true,
	["PlayerStatFrameLeftDropDownButton"] = true,
	["PlayerStatFrameRightDropDown"] = true,
	["PlayerStatFrameRightDropDownButton"] = true,
	["PlayerTitleFrame"] = true,
	["PlayerTitleFrameButton"] = true,
	["WorldMapFrame"] = true
}

Module.StyleRegion = function(self, region)
	local objectType = region:GetObjectType()
	if (objectType == "Texture") then
		region:SetVertexColor(unpack(C.General.UIBackdrop))
	elseif (objectType == "FontString") then
		region:SetTextColor(unpack(C.General.Title))
	end
end

Module.StyleFrame = function(self, frame)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		self:StyleRegion(region)
	end
end

Module.OnEnable = function(self)
	for frameName in pairs(elements) do
		local object = _G[frameName]
		if (not object) then
			-- replaced by an addon
		elseif (object:IsObjectType("Frame")) then
			self:StyleFrame(object)
		else
			self:StyleRegion(object)
		end
	end
end
