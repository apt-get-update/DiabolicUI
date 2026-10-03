-- Tints Blizzard's character, spell book, dungeon finder, world map and
-- merchant frames (and the bags, unless a bag addon replaces them) in
-- DiabolicUI's colors: textures in the backdrop color, text in the title
-- color.
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
	["LFDParentFrame"] = true, 
	["LFDQueueFrame"] = true,
	["LFDQueueFrameFindGroupButton"] = true,
	["LFDQueueFrameTypeDropDown"] = true,
	["LFDQueueFrameRandom"] = true,
	["LFDQueueFrameSpecificListScrollFrame"] = true,
	["LFDQueueFrameSpecificListScrollFrameScrollBar"] = true,
	["LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"] = true,
	["LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"] = true,
	["PaperDollFrame"] = true,
	["PlayerStatFrameLeftDropDown"] = true,
	["PlayerStatFrameLeftDropDownButton"] = true,
	["PlayerStatFrameRightDropDown"] = true,
	["PlayerStatFrameRightDropDownButton"] = true,
	["PlayerTitleFrame"] = true,
	["PlayerTitleFrameButton"] = true,
	["SpellBookFrame"] = true,
	["SpellBookSkillLineTab1"] = true,
	["SpellBookSkillLineTab2"] = true,
	["SpellBookSkillLineTab3"] = true,
	["SpellBookSkillLineTab4"] = true,
	["SpellBookSkillLineTab5"] = true,
	["SpellBookSkillLineTab6"] = true,
	["SpellBookSkillLineTab7"] = true,
	["SpellBookSkillLineTab8"] = true,
	["WorldMapFrame"] = true,

	["MerchantFrame"] = true,
	["MerchantItem1"] = true,
	["MerchantItem1SlotTexture"] = true,
	["MerchantItem1ItemButton"] = true,
	["MerchantItem2"] = true,
	["MerchantItem2SlotTexture"] = true,
	["MerchantItem2ItemButton"] = true,
	["MerchantItem3"] = true,
	["MerchantItem3SlotTexture"] = true,
	["MerchantItem3ItemButton"] = true,
	["MerchantItem4"] = true,
	["MerchantItem4SlotTexture"] = true,
	["MerchantItem4ItemButton"] = true,
	["MerchantItem5"] = true,
	["MerchantItem5SlotTexture"] = true,
	["MerchantItem5ItemButton"] = true,
	["MerchantItem6"] = true,
	["MerchantItem6SlotTexture"] = true,
	["MerchantItem6ItemButton"] = true,
	["MerchantItem7"] = true,
	["MerchantItem7SlotTexture"] = true,
	["MerchantItem7ItemButton"] = true,
	["MerchantItem8"] = true,
	["MerchantItem8SlotTexture"] = true,
	["MerchantItem8ItemButton"] = true,
	["MerchantItem9"] = true,
	["MerchantItem9SlotTexture"] = true,
	["MerchantItem9ItemButton"] = true,
	["MerchantItem10"] = true,
	["MerchantItem10SlotTexture"] = true,
	["MerchantItem10ItemButton"] = true,
	["MerchantFrameTab1"] = true,
	["MerchantFrameTab2"] = true,
	["MerchantRepairItemButton"] = true,
	["MerchantRepairAllButton"] = true,
	["MerchantGuildBankRepairButton"] = true,
	["MerchantBuyBackItem"] = true,
	["MerchantNextPageButton"] = true,
	["MerchantPrevPageButton"] = true,

}

-- Regions left as they are
local whiteList = {
	["LFDQueueFrameFindGroupButtonText"] = true
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
		if (not whiteList[region:GetName() or ""]) then
			self:StyleRegion(region)
		end
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
