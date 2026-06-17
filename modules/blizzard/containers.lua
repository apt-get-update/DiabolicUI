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
local IsArtifactRelicItem = _G.IsArtifactRelicItem

local LEGION_730_CRUCIBLE = false

-- Tooltip used for scanning
local scanner = CreateFrame("GameTooltip", "DiabolicUIPaperDollScannerTooltip", WorldFrame, "GameTooltipTemplate")
local scannerName = scanner:GetName()

-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
local S_ITEM_LEVEL = "^" .. string_gsub(_G.ITEM_LEVEL, "%%d", "(%%d+)")
-- Redoing this to take other locales into consideration, 
-- and to make sure we're capturing the slot count, and not the bag type. 
--local S_CONTAINER_SLOTS = "^" .. string_gsub(string_gsub(_G.CONTAINER_SLOTS, "%%d", "(%%d+)"), "%%s", "(%.+)")
local S_CONTAINER_SLOTS = "^" .. (string.gsub(string.gsub(CONTAINER_SLOTS, "%%([%d%$]-)d", "(%%d+)"), "%%([%d%$]-)s", "%.+"))

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

-- Check if it's a caged battle pet
local GetBattlePetInfo = function(itemLink)
	if (not string_find(itemLink, "battlepet")) then
		return
	end
	local data, name = string_match(itemLink, "|H(.-)|h(.-)|h")
	local  _, _, level, rarity = string_match(data, "(%w+):(%d+):(%d+):(%d+)")
	return true, level or 1, tonumber(rarity) or 0
end

local updateItemLevel = (GetDetailedItemLevelInfo and IsArtifactRelicItem) and function(self, itemLink, bagID, slotID)

	if itemLink then

		-- Retrieve or create this button's itemlevel text
		local itemLevel = itemLevelCache[self] or getItemLevelFrame(self)

		-- Get some blizzard info about the current item
		local _, _, itemRarity, iLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(itemLink)
		local effectiveLevel, previewLevel, origLevel = GetDetailedItemLevelInfo(itemLink)
		local isBattlePet, battlePetLevel, battlePetRarity = GetBattlePetInfo(itemLink)

		-- Retrieve the itemID from the itemLink
		local itemID = tonumber(string_match(itemLink, "item:(%d+)"))

		if (itemEquipLoc == "INVTYPE_BAG") then 

			scanner.owner = self
			scanner:SetOwner(self, "ANCHOR_NONE")
			scanner:SetBagItem(bagID or self:GetParent():GetID(), slotID or self:GetID())
		
			local scannedSlots
			local line = _G[scannerName.."TextLeft3"]
			if line then
				local msg = line:GetText()
				if msg and string_find(msg, S_CONTAINER_SLOTS) then
					local bagSlots = string_match(msg, S_CONTAINER_SLOTS)
					if bagSlots and (tonumber(bagSlots) > 0) then
						scannedSlots = bagSlots
					end
				else
					line = _G[scannerName.."TextLeft4"]
					if line then
						local msg = line:GetText()
						if msg and string_find(msg, S_CONTAINER_SLOTS) then
							local bagSlots = string_match(msg, S_CONTAINER_SLOTS)
							if bagSlots and (tonumber(bagSlots) > 0) then
								scannedSlots = bagSlots
							end
						end
					end
				end
			end

			if scannedSlots then 
				--local r, g, b = GetItemQualityColor(itemRarity)
				local r, g, b = 240/255, 240/255, 240/255
				itemLevel:SetTextColor(r, g, b)
				itemLevel:SetText(scannedSlots)
			else 
				itemLevel:SetText("")
			end 

		-- Display item level of equippable gear and artifact relics
		elseif ((itemRarity and (itemRarity > 0)) and ((itemEquipLoc and _G[itemEquipLoc]) or (itemID and IsArtifactRelicItem(itemID)))) or (isBattlePet) then

			local scannedLevel
			if (not isBattlePet) then
				scanner.owner = self
				scanner:SetOwner(self, "ANCHOR_NONE")
				scanner:SetBagItem(bagID or self:GetParent():GetID(), slotID or self:GetID())

				local line = _G[scannerName.."TextLeft2"]
				if line then
					local msg = line:GetText()
					if msg and string_find(msg, S_ITEM_LEVEL) then
						local itemLevel = string_match(msg, S_ITEM_LEVEL)
						if itemLevel and (tonumber(itemLevel) > 0) then
							scannedLevel = itemLevel
						end
					else
						-- Check line 3, some artifacts have the ilevel there
						line = _G[scannerName.."TextLeft3"]
						if line then
							local msg = line:GetText()
							if msg and string_find(msg, S_ITEM_LEVEL) then
								local itemLevel = string_match(msg, S_ITEM_LEVEL)
								if itemLevel and (tonumber(itemLevel) > 0) then
									scannedLevel = itemLevel
								end
							end
						end
					end
				end
			end

			local r, g, b = GetItemQualityColor(battlePetRarity or itemRarity)
			itemLevel:SetTextColor(r, g, b)
			itemLevel:SetText(scannedLevel or battlePetLevel or effectiveLevel or iLevel or "")

		else
			itemLevel:SetText("")
		end

	else
		if itemLevelCache[self] then
			itemLevelCache[self]:SetText("")
		end
	end	
end 
or 
IsArtifactRelicItem and function(self, itemLink)
	if itemLink then

		-- Retrieve or create this button's itemlevel text
		local itemLevel = itemLevelCache[self] or getItemLevelFrame(self)

		-- Get some blizzard info about the current item
		local _, _, itemRarity, iLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		local isBattlePet, battlePetLevel, battlePetRarity = GetBattlePetInfo(itemLink)

		-- Retrieve the itemID from the itemLink
		local itemID = tonumber(string_match(itemLink, "item:(%d+)"))

		-- Display item level of equippable gear and artifact relics
		if ((itemRarity and (itemRarity > 1)) and ((itemEquipLoc and _G[itemEquipLoc]) or (itemID and IsArtifactRelicItem(itemID)))) or (isBattlePet) then
			local r, g, b = GetItemQualityColor(battlePetRarity or itemRarity)
			itemLevel:SetTextColor(r, g, b)
			itemLevel:SetText(battlePetLevel or iLevel or "")
		else
			itemLevel:SetText("")
		end
	else
		if itemLevelCache[self] then
			itemLevelCache[self]:SetText("")
		end
	end	
end 
or 
function(self, itemLink)
	if itemLink then

		-- Retrieve or create this button's itemlevel text
		local itemLevel = itemLevelCache[self] or getItemLevelFrame(self)


		-- Get some blizzard info about the current item
		local _, _, itemRarity, iLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)

		-- Retrieve the itemID from the itemLink
		local itemID = tonumber(string_match(itemLink, "item:(%d+)"))

		-- Retrieve potential BattlePet information
		local isBattlePet, battlePetLevel, battlePetRarity = GetBattlePetInfo(itemLink)

		-- Display item level of equippable gear and artifact relics
		if ((itemRarity and (itemRarity > 1)) and ((itemEquipLoc and _G[itemEquipLoc]))) or (isBattlePet) then
			local r, g, b = GetItemQualityColor(battlePetRarity or itemRarity)
			itemLevel:SetTextColor(r, g, b)
			itemLevel:SetText(battlePetLevel or iLevel or "")
		else
			itemLevel:SetText("")
		end

	else
		if itemLevelCache[self] then
			itemLevelCache[self]:SetText("")
		end
	end	
end 

local updateArtifactPower = function(self)
end

local updateAncientMana = function(self)
end

local updateBindStatus = function(self)
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
			if (itemRarity >= (LE_ITEM_QUALITY_COMMON + 1)) and C.Quality[itemRarity] then
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
				if (itemRarity >= (LE_ITEM_QUALITY_COMMON + 1)) and C.Quality[itemRarity] then
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
		if itemRarity and (itemRarity < LE_ITEM_QUALITY_COMMON) and (itemRarity > -1) then
			iconTexture:SetDesaturated(true)
			iconTexture:SetVertexColor(unpack(C.General.UIBackdrop))
		else
			iconTexture:SetDesaturated(false)
			iconTexture:SetVertexColor(1, 1, 1)
		end
		if itemRarity and (itemRarity < (LE_ITEM_QUALITY_COMMON + 1)) and (itemRarity > -1) then
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

Module.CrucibleListener = function(self, event, id) 
	if (event == "ACHIEVEMENT_EARNED") then
		if (id == 12072) then
			LEGION_730_CRUCIBLE = true
			self:UnregisterEvent(event, "CrucibleListener")
		end
	end
end
