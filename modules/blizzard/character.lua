local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: Character")
local C = Engine:GetDB("Data: Colors")

Module:SetIncompatible("DiabolicUI")

-- Lua API
local _G = _G
local pairs = pairs
local string_find = string.find
local string_gsub = string.gsub
local string_match = string.match
local tonumber = tonumber
local unpack = unpack

-- WoW API
local GetAchievementInfo = _G.GetAchievementInfo
local GetDetailedItemLevelInfo = _G.GetDetailedItemLevelInfo
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local GetItemInfo = _G.GetItemInfo

-- WoW Client Constants
local ENGINE_LEGION_730 = Engine:IsBuild("7.3.0") 
local ENGINE_LEGION = Engine:IsBuild("Legion")
local ENGINE_MOP = Engine:IsBuild("MoP")
local ENGINE_CATA = Engine:IsBuild("Cata")
local CRUCIBLE = ENGINE_LEGION_730 and select(4, GetAchievementInfo(12072))

-- Tooltip used for scanning
local scannerTip = CreateFrame("GameTooltip", "DiabolicUIPaperDollScannerTooltip", WorldFrame, "GameTooltipTemplate")
local scannerName = scannerTip:GetName()

-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
local S_ITEM_LEVEL = "^" .. string_gsub(_G.ITEM_LEVEL, "%%d", "(%%d+)")


Module.InitializePaperDoll = function(self)
	local config = self.config
	local buttonCache = {}
	local borderCache = {} -- Cache of custom old client borders
	
	-- The ItemsFrame was added in Cata when the character frame was upgraded to the big one
	local paperDoll = _G.PaperDollItemsFrame or _G.PaperDollFrame 

	for i = 1, select("#", paperDoll:GetChildren()) do
		local child = select(i, paperDoll:GetChildren())
		local childName = child:GetName()

		if (child:GetObjectType() == "Button") and (childName and childName:find("Slot")) then

			local itemLevel = child:CreateFontString()
			itemLevel:SetDrawLayer("OVERLAY")
			itemLevel:SetPoint(unpack(config.itemLevel.point))
			--itemLevel:SetFontObject(config.itemLevel.fontObject)
			itemLevel:SetFontObject(_G.NumberFont_Outline_Med or _G.NumberFontNormal) 
			itemLevel:SetFont(itemLevel:GetFont(), 14, "THINOUTLINE")

			itemLevel.shade = child:CreateTexture()
			itemLevel.shade:SetDrawLayer("ARTWORK")
			itemLevel.shade:SetTexture(config.itemLevel.shadeTexture)
			itemLevel.shade:SetPoint("TOPLEFT", itemLevel, "TOPLEFT", -6, 6)
			itemLevel.shade:SetPoint("BOTTOMRIGHT", itemLevel, "BOTTOMRIGHT", 6, -6)
			itemLevel.shade:SetAlpha(.5)

			buttonCache[child] = itemLevel

			--local normalTexture = _G[childName.."NormalTexture"] or child:GetNormalTexture()
			--if normalTexture then
			--	normalTexture:SetTexture(nil)
			--	normalTexture:SetAlpha(0)
			--	normalTexture:Hide()
			--end

			local iconBorder = child.IconBorder
			if (not iconBorder) then
				local iconBorder = child:CreateTexture()
				iconBorder:SetDrawLayer("ARTWORK")
				iconBorder:SetTexture([[Interface\Buttons\UI-Quickslot2]])
				iconBorder:SetAllPoints(normalTexture or child)
				iconBorder:Hide()

				local iconBorderDoubler = child:CreateTexture()
				iconBorderDoubler:SetDrawLayer("OVERLAY")
				iconBorderDoubler:SetAllPoints(iconBorder)
				iconBorderDoubler:SetTexture(iconBorder:GetTexture())
				iconBorderDoubler:SetBlendMode("ADD")
				iconBorderDoubler:Hide()

				hooksecurefunc(iconBorder, "SetVertexColor", function(_, ...) iconBorderDoubler:SetVertexColor(...) end)
				hooksecurefunc(iconBorder, "Show", function() iconBorderDoubler:Show() end)
				hooksecurefunc(iconBorder, "Hide", function() iconBorderDoubler:Hide() end)

				borderCache[child] = iconBorder
			end
		end
	end

	self.buttonCache = buttonCache
	self.borderCache = borderCache
end

Module.GetInventorySlotItemData = function(self, slotID)
	local itemLink = GetInventoryItemLink("player", slotID) 
	if itemLink then
		local _, _, itemRarity, ilvl = GetItemInfo(itemLink)
		if itemRarity then

			local scannerLevel
			scannerTip.owner = self
			scannerTip:SetOwner(UIParent, "ANCHOR_NONE")
			scannerTip:SetInventoryItem("player", slotID)

			local line = _G[scannerName.."TextLeft2"]
			if line then
				local msg = line:GetText()
				if msg and string_find(msg, S_ITEM_LEVEL) then
					local iLevel = string_match(msg, S_ITEM_LEVEL)
					if iLevel and (tonumber(iLevel) > 0) then
						return itemLink, itemRarity, iLevel
					end
				else
					-- Check line 3, some artifacts have the ilevel there.
					-- *an example is demon hunter artifacts, which have their names on 2 lines 
					line = _G[scannerName.."TextLeft3"]
					if line then
						local msg = line:GetText()
						if msg and string_find(msg, S_ITEM_LEVEL) then
							local iLevel = string_match(msg, S_ITEM_LEVEL)
							if iLevel and (tonumber(iLevel) > 0) then
								return itemLink, itemRarity, iLevel
							end
						end
					end
				end
			end

			-- We're probably still in patch 7.1.5 or not in Legion at all if we made it to this point, so normal checks will suffice
			--local effectiveLevel, previewLevel, origLevel = GetDetailedItemLevelInfo and GetDetailedItemLevelInfo(itemLink)
			--ilvl = effectiveLevel or ilvl
		end
		return itemLink, itemRarity, ilvl
	end
end

Module.UpdateEquippeditemLevels = function(self, event, ...)

	if (event == "UNIT_INVENTORY_CHANGED") then
		local unit = ...
		if (unit ~= "player") then
			return 
		end
	end 

	for itemButton, itemLevel in pairs(self.buttonCache) do
		local normalTexture = _G[itemButton:GetName().."NormalTexture"] or itemButton:GetNormalTexture()
		if normalTexture then
			--normalTexture:SetVertexColor(unpack(C.General.UIBorder))
		end
		local itemLink, itemRarity, ilvl = self:GetInventorySlotItemData(itemButton:GetID())
		if itemLink then
			if itemRarity then

				local r, g, b = unpack(C.Quality[itemRarity])
				itemLevel:SetTextColor(r, g, b)
				itemLevel.shade:SetVertexColor(r, g, b)
				itemLevel:SetText(ilvl or "")

				local iconBorder = itemButton.IconBorder
				if iconBorder then
					iconBorder:SetTexture([[Interface\Common\WhiteIconFrame]])
					if itemRarity then
						if (itemRarity >= (LE_ITEM_QUALITY_COMMON + 1)) and C.Quality[itemRarity] then
							iconBorder:Show()
							iconBorder:SetVertexColor(unpack(C.Quality[itemRarity]))
						else
							iconBorder:Show()
							iconBorder:SetVertexColor(unpack(C.General.UIOverlay))
						end
					else
						iconBorder:Hide()
					end
				else
					iconBorder = self.borderCache[itemButton]
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

			else
				itemLevel:SetTextColor(1, 1, 0)
				itemLevel.shade:SetVertexColor(1, 1, 0)
			end
			if ilvl then
				itemLevel:SetText(ilvl)
				itemLevel.shade:Show()
			else
				itemLevel:SetText("")
				itemLevel.shade:Hide()
			end
		else
			local iconBorder = itemButton.IconBorder
			if iconBorder then
				iconBorder:Hide()
			else
				iconBorder = self.borderCache[itemButton]
				if iconBorder then
					iconBorder:Show()
					iconBorder:SetVertexColor(unpack(C.General.UIBorder))
				end
			end
			itemLevel:SetText("")
			itemLevel.shade:Hide()
		end	
	end

end

Module.CrucibleAchievementListener = function(self, event, id)
	if (id == 12072) then
		CRUCIBLE = true
		self:UnregisterEvent("ACHIEVEMENT_EARNED", "CrucibleAchievementListener")
		self:UpdateEquippeditemLevels()
	end
end

Module.OnInit = function(self)
	self.config = Engine:GetDB("Blizzard").character

	self:InitializePaperDoll()

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateEquippeditemLevels")
	if ENGINE_CATA then
		self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdateEquippeditemLevels")
		if ENGINE_MOP then
			self:RegisterEvent("ITEM_UPGRADE_MASTER_UPDATE", "UpdateEquippeditemLevels")
			self:RegisterEvent("ITEM_UPGRADE_MASTER_SET_ITEM", "UpdateEquippeditemLevels")
		end
	else
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateEquippeditemLevels")
	end

	-- Adding in compatibility with the 7.3.0 upgraded artifact relic itemlevels
	if (ENGINE_LEGION_730 and (not CRUCIBLE)) then
		self:RegisterEvent("ACHIEVEMENT_EARNED", "CrucibleAchievementListener")
	end
	
end
