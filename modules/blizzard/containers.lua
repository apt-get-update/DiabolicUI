local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: Containers")
local C = Engine:GetDB("Data: Colors")

Module:SetIncompatible("BlizzardBagsPlus")
Module:SetIncompatible("Backpacker")

-- Lua API
local _G = _G
local string_find = string.find
local string_gsub = string.gsub
local string_match = string.match
local tonumber = tonumber

-- WoW API
local CreateFrame = _G.CreateFrame
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerItemQuestInfo = _G.GetContainerItemQuestInfo
local GetItemInfo = _G.GetItemInfo
local GetItemQualityColor = _G.GetItemQualityColor

-- Item quality index for common (white) items.
local QUALITY_COMMON = 1

local styleFrameCache = {} -- Cache of style frames
local itemLevelCache = {} -- Cache of itemlevel texts
local newItemCache = {} -- Cache of new item flash textures
local borderCache = {} -- Cache of custom old client borders

-- Retrieve or create the master style frame
local getStyleFrame = function(self)
	if (not styleFrameCache[self]) then
		local styleFrame = CreateFrame("Frame", nil, self)
		styleFrame:SetAllPoints()
		styleFrameCache[self] = styleFrame
	end
	return styleFrameCache[self]
end

-- Retrieve or create the itemlevel frame
local getItemLevelFrame = function(self)
	if (not itemLevelCache[self]) then

		-- Using standard blizzard fonts here
		local itemLevel = getStyleFrame(self):CreateFontString()
		itemLevel:SetDrawLayer("ARTWORK")
		itemLevel:SetPoint("TOPLEFT", 4, -4)
		itemLevel:SetFontObject(_G.NumberFont_Outline_Med or _G.NumberFontNormal) 
		itemLevel:SetFont(itemLevel:GetFont(), 14, "OUTLINE")
		itemLevel:SetShadowOffset(1, -1)
		itemLevel:SetShadowColor(0, 0, 0, .5)

		itemLevelCache[self] = itemLevel
	end
	return itemLevelCache[self]
end

local styleItem = function(self)
	local buttonName = self:GetName()

	-- Tone down the over emphasized texture for flashing new items
	--
	-- *Note that this is for default Blizzard bags only, 
	--  the user still has to manually disable new item  
	--  flashing in third party addons like Bagnon.
	local newItemTexture = self.NewItemTexture
	if newItemTexture then
		local proxy = CreateFrame("Frame", nil, newItemTexture:GetParent())
		proxy:SetAllPoints()
		newItemTexture:SetParent(proxy)
		newItemTexture:SetAlpha(.25)
		newItemCache[self] = proxy
	end

	local normalTexture = _G[buttonName.."NormalTexture"] or self:GetNormalTexture()
	if normalTexture then
		normalTexture:Hide()
		normalTexture:SetAlpha(0)
	end

	local iconBorder = self.IconBorder
	if (not iconBorder) then
		local iconBorder = self:CreateTexture()
		iconBorder:SetDrawLayer("ARTWORK")
		iconBorder:SetTexture([[Interface\Buttons\UI-Quickslot2]])
		iconBorder:SetAllPoints(normalTexture or self)
		iconBorder:Hide()

		local iconBorderDoubler = self:CreateTexture()
		iconBorderDoubler:SetDrawLayer("OVERLAY")
		iconBorderDoubler:SetAllPoints(iconBorder)
		iconBorderDoubler:SetTexture(iconBorder:GetTexture())
		iconBorderDoubler:SetBlendMode("ADD")
		iconBorderDoubler:Hide()

		hooksecurefunc(iconBorder, "SetVertexColor", function(_, ...) iconBorderDoubler:SetVertexColor(...) end)
		hooksecurefunc(iconBorder, "Show", function() iconBorderDoubler:Show() end)
		hooksecurefunc(iconBorder, "Hide", function() iconBorderDoubler:Hide() end)

		borderCache[self] = iconBorder
	end
end

-- Show the item level on equippable gear of uncommon quality or better.
local updateItemLevel = function(self, itemLink)
	if itemLink then
		local itemLevel = itemLevelCache[self] or getItemLevelFrame(self)
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


local updateItem = function(self)

	local bagID = self:GetParent():GetID()
	local slotID = self:GetID()
	local buttonName = self:GetName()

	local texture, itemCount, locked, itemRarity, readable, _, _, isFiltered, noValue, itemID = GetContainerItemInfo(bagID, slotID)
	local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bagID, slotID)
	local itemLink = GetContainerItemLink(bagID, slotID)

	local iconBorder = self.IconBorder
	if iconBorder then
		iconBorder:SetTexture([[Interface\Common\WhiteIconFrame]])
		if itemRarity then
			if (itemRarity >= (QUALITY_COMMON + 1)) and C.Quality[itemRarity] then
				iconBorder:Show()
				iconBorder:SetVertexColor(unpack(C.Quality[itemRarity]))
			else
				iconBorder:Show()
				iconBorder:SetVertexColor(unpack(C.General.UIBorder))
			end
		else
			iconBorder:Hide()
		end
	else
		iconBorder = borderCache[self]
		if iconBorder then
			if itemRarity then
				if (itemRarity >= (QUALITY_COMMON + 1)) and C.Quality[itemRarity] then
					iconBorder:Show()
					iconBorder:SetVertexColor(unpack(C.Quality[itemRarity]))
				else
					iconBorder:Show()
					iconBorder:SetVertexColor(unpack(C.General.UIBorder))
				end
			else
				iconBorder:Hide()
				iconBorder:Show()
				iconBorder:SetVertexColor(unpack(C.General.UIBorder))
			end
		end
	end

	local iconTexture = buttonName and _G[buttonName.."IconTexture"]
	if iconTexture then
		if itemRarity and (itemRarity < QUALITY_COMMON) and (itemRarity > -1) then
			iconTexture:SetDesaturated(true)
			iconTexture:SetVertexColor(unpack(C.General.UIBackdrop))
		else
			iconTexture:SetDesaturated(false)
			iconTexture:SetVertexColor(1, 1, 1)
		end
		if itemRarity and (itemRarity < (QUALITY_COMMON + 1)) and (itemRarity > -1) then
			if newItemCache[self] then
				newItemCache[self]:Hide()
			end
		else
			if newItemCache[self] then
				newItemCache[self]:Show()
			end
		end
	end

	-- Tone down the quest item and quest starter overlays, 
	-- as they are a bit too bright for my taste.				
	local questTexture = buttonName and _G[buttonName.."IconQuestTexture"]
	if questTexture then
		if questId and not isActive then 
			questTexture:SetDrawLayer("ARTWORK")
			questTexture:SetAlpha(1)
			questTexture:SetTexCoord(10/64, 54/64, 10/64, 54/64)
			questTexture:ClearAllPoints()
			questTexture:SetPoint("TOPLEFT",6,-6)
			questTexture:SetPoint("BOTTOMRIGHT",-6,6)
			local iconBorder = iconBorder or borderCache[self]
			if iconBorder then 
				iconBorder:Show()
				iconBorder:SetVertexColor(unpack(C.General.Gold))
			end
		elseif questId or isQuestItem then
			questTexture:Hide()
			local iconBorder = iconBorder or borderCache[self]
			if iconBorder then 
				iconBorder:Show()
				iconBorder:SetVertexColor(unpack(C.General.Gold))
			end
		else
			questTexture:Hide()
		end
	end

	updateItemLevel(self, itemLink, bagID, slotID)
	
end

local updateContainer = function(self)
	local name = self:GetName()
	for i = 1, self.size, 1 do
		updateItem(_G[name.."Item"..i])
	end
end

Module.OnInit = function(self)

	--[[
		TODO:

		create proxy items:
		- each proxy references the original bagbutton
		- each proxy has :methods() to update various aspects
		- each proxy should be identifiable by original button (table index?)
		- inheritance?

	]]

	local currentContainer = 1
	local currentItem = 1
	local container = _G["ContainerFrame"..currentContainer]
	local item = _G["ContainerFrame"..currentContainer.."Item"..currentItem]
	
	-- Setup all container itembuttons
	while container do 
		while item do 
			styleItem(item)
			currentItem = currentItem + 1
			item = _G["ContainerFrame"..currentContainer.."Item"..currentItem]
		end
		currentContainer = currentContainer + 1
		container = _G["ContainerFrame"..currentContainer]
	end

	-- Setup bankframe itembuttons
	currentItem = 1
	item = _G["BankFrameItem"..currentItem]
	while item do 
		styleItem(item)
		currentItem = currentItem + 1
		item = _G["BankFrameItem"..currentItem]
	end

	-- Hook bankframe itembutton updates
	-- This is where we update the itembuttons found within the main bankframe.
	if _G.BankFrameItemButton_Update then
		hooksecurefunc("BankFrameItemButton_Update", updateItem)
	end

	-- Hook bag- and bankframe subcontainer updates
	-- This is where we update all the other itembuttons
	if _G.ContainerFrame_Update then
		hooksecurefunc("ContainerFrame_Update", updateContainer)
	end
end
