-- Bag and bank slots: a border in the item's quality color (gold for quest
-- items), the item level on gear, greyed out junk, and a smaller quest
-- starter "!".
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Containers")
local C = Engine:GetDB("Data: Colors")

Module:SetIncompatible("BlizzardBagsPlus")
Module:SetIncompatible("Backpacker")

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerItemLink = _G.GetContainerItemLink
local GetContainerItemQuestInfo = _G.GetContainerItemQuestInfo
local GetItemInfo = _G.GetItemInfo
local GetItemQualityColor = _G.GetItemQualityColor
local hooksecurefunc = _G.hooksecurefunc
local BANK_CONTAINER = _G.BANK_CONTAINER

-- Item qualities
local QUALITY_POOR = 0
local QUALITY_COMMON = 1

local borderCache = {} -- item button -> our border
local itemLevelCache = {} -- item button -> its item level text

-- The item level text, created the first time a button shows one.
local getItemLevelFrame = function(self)
	if (not itemLevelCache[self]) then
		local holder = CreateFrame("Frame", nil, self)
		holder:SetAllPoints()

		-- Using standard blizzard fonts here
		local itemLevel = holder:CreateFontString()
		itemLevel:SetDrawLayer("ARTWORK")
		itemLevel:SetPoint("TOPLEFT", 4, -4)
		itemLevel:SetFontObject(_G.NumberFont_Outline_Med)
		itemLevel:SetFont(itemLevel:GetFont(), 14, "OUTLINE")
		itemLevel:SetShadowOffset(1, -1)
		itemLevel:SetShadowColor(0, 0, 0, .5)

		itemLevelCache[self] = itemLevel
	end
	return itemLevelCache[self]
end

-- Replaces the slot's square normal texture with our border, doubled up
-- with an additive copy to make the quality colors stand out.
local styleItem = function(self)
	local normalTexture = _G[self:GetName().."NormalTexture"]
	normalTexture:Hide()
	normalTexture:SetAlpha(0)

	local iconBorder = self:CreateTexture()
	iconBorder:SetDrawLayer("ARTWORK")
	iconBorder:SetTexture([[Interface\Buttons\UI-Quickslot2]])
	iconBorder:SetAllPoints(normalTexture)
	iconBorder:Hide()

	local iconBorderDoubler = self:CreateTexture()
	iconBorderDoubler:SetDrawLayer("OVERLAY")
	iconBorderDoubler:SetAllPoints(iconBorder)
	iconBorderDoubler:SetTexture(iconBorder:GetTexture())
	iconBorderDoubler:SetBlendMode("ADD")
	iconBorderDoubler:Hide()

	hooksecurefunc(iconBorder, "SetVertexColor", function(_, ...) iconBorderDoubler:SetVertexColor(...) end)
	hooksecurefunc(iconBorder, "Show", function() iconBorderDoubler:Show() end)

	borderCache[self] = iconBorder
end

-- Shows the item level on equippable gear of uncommon quality or better.
local updateItemLevel = function(self, itemLink)
	if itemLink then
		local itemLevel = getItemLevelFrame(self)
		local _, _, itemRarity, iLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		if (itemRarity and (itemRarity > QUALITY_COMMON)) and (itemEquipLoc and _G[itemEquipLoc]) then
			local r, g, b = GetItemQualityColor(itemRarity)
			itemLevel:SetTextColor(r, g, b)
			itemLevel:SetText(iLevel or "")
		else
			itemLevel:SetText("")
		end
	elseif itemLevelCache[self] then
		itemLevelCache[self]:SetText("")
	end
end

-- Restyles a slot after Blizzard updated it.
local updateItem = function(self, bagID)
	local iconBorder = borderCache[self]
	if (not iconBorder) then
		return -- not an item slot (the bank's bag slots use the same update)
	end

	local slotID = self:GetID()
	local _, _, _, quality = GetContainerItemInfo(bagID, slotID)
	local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bagID, slotID)

	if (questId or isQuestItem) then
		iconBorder:SetVertexColor(unpack(C.General.Gold))
	elseif (quality and (quality > QUALITY_COMMON) and C.Quality[quality]) then
		iconBorder:SetVertexColor(unpack(C.Quality[quality]))
	else
		iconBorder:SetVertexColor(unpack(C.General.UIBorder))
	end
	iconBorder:Show()

	local iconTexture = _G[self:GetName().."IconTexture"]
	if (quality == QUALITY_POOR) then
		iconTexture:SetDesaturated(true)
		iconTexture:SetVertexColor(unpack(C.General.UIBackdrop))
	else
		iconTexture:SetDesaturated(false)
		iconTexture:SetVertexColor(1, 1, 1)
	end

	-- A smaller quest starter "!" (Blizzard's is a bit too bright), and
	-- the gold border instead of Blizzard's quest item one.
	local questTexture = _G[self:GetName().."IconQuestTexture"]
	if (questId and (not isActive)) then
		questTexture:SetDrawLayer("ARTWORK")
		questTexture:SetAlpha(1)
		questTexture:SetTexCoord(10/64, 54/64, 10/64, 54/64)
		questTexture:ClearAllPoints()
		questTexture:SetPoint("TOPLEFT", 6, -6)
		questTexture:SetPoint("BOTTOMRIGHT", -6, 6)
	else
		questTexture:Hide()
	end

	updateItemLevel(self, GetContainerItemLink(bagID, slotID))
end

local updateContainer = function(self)
	local name, bagID = self:GetName(), self:GetID()
	for i = 1, self.size do
		updateItem(_G[name.."Item"..i], bagID)
	end
end

local updateBankItem = function(self)
	updateItem(self, BANK_CONTAINER)
end

Module.OnInit = function(self)
	-- every bag's slots
	for container = 1, NUM_CONTAINER_FRAMES do
		local item, i = _G["ContainerFrame"..container.."Item1"], 1
		while item do
			styleItem(item)
			i = i + 1
			item = _G["ContainerFrame"..container.."Item"..i]
		end
	end

	-- the bank's own slots
	for i = 1, NUM_BANKGENERIC_SLOTS do
		styleItem(_G["BankFrameItem"..i])
	end

	hooksecurefunc("BankFrameItemButton_Update", updateBankItem)
	hooksecurefunc("ContainerFrame_Update", updateContainer)
end
