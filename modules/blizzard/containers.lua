-- Bag and bank slots: a border in the item's quality color (gold for quest
-- items), a faint glow of that color up from the slot's bottom (Diablo
-- III's quality-colored slots), greyed out junk, items you can't use in
-- red, and a smaller quest starter "!". The character window's slots get
-- the quality border and glow too.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Containers")
local C = Engine:GetDB("Data: Colors")

Module:SetIncompatible("BlizzardBagsPlus")
Module:SetIncompatible("Backpacker")

-- Lua API
local _G = _G
local pairs = pairs
local select = select
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerItemLink = _G.GetContainerItemLink
local GetContainerItemQuestInfo = _G.GetContainerItemQuestInfo
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = _G.GetItemInfo
local hooksecurefunc = _G.hooksecurefunc
local BANK_CONTAINER = _G.BANK_CONTAINER

-- Item qualities
local QUALITY_POOR = 0
local QUALITY_COMMON = 1

-- Character window slots that are gear (0 is the ammo slot)
local FIRST_GEAR_SLOT, LAST_GEAR_SLOT = 1, 19

-- the icon of an item you can't use: tinted red, like an action out of range
local UNUSABLE_COLOR = { 1, .3, .3 }

-- how strong the quality glow is at the slot's bottom (it fades to none
-- at the top), kept faint so the icon stays readable
local QUALITY_GLOW_ALPHA = .35

local borderCache = {} -- item button -> our border
local glowCache = {} -- item button -> its quality glow
local unusableCache = {} -- item link -> whether its tooltip has red lines
local scanner -- hidden tooltip read for those red lines

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

	local qualityGlow = self:CreateTexture()
	qualityGlow:SetDrawLayer("ARTWORK")
	qualityGlow:SetTexture([[Interface\ChatFrame\ChatFrameBackground]])
	qualityGlow:SetBlendMode("ADD")
	qualityGlow:SetAllPoints(_G[self:GetName().."IconTexture"])
	qualityGlow:Hide()

	borderCache[self] = iconBorder
	glowCache[self] = qualityGlow
end

-- The quality glow, in the item's quality color, or none.
local updateQualityGlow = function(self, quality)
	local qualityGlow = glowCache[self]
	local color = quality and (quality > QUALITY_COMMON) and C.Quality[quality]
	if color then
		local r, g, b = unpack(color)
		qualityGlow:SetGradientAlpha("VERTICAL", r, g, b, QUALITY_GLOW_ALPHA, r, g, b, 0)
		qualityGlow:Show()
	else
		qualityGlow:Hide()
	end
end

-- Whether a tooltip line is in the red the client uses for what you can't
-- meet: a level, class, skill or reputation, an armor or weapon type.
local isRed = function(line)
	if line and line:IsShown() and line:GetText() then
		local r, g, b = line:GetTextColor()
		return (r > .99) and (g < .15) and (b < .15)
	end
end

-- Whether the item's tooltip has a red line, remembered per item until the
-- player levels up or learns something. Items not cached yet count as
-- usable, and are asked again on the next update.
local isUnusable = function(itemLink)
	local unusable = unusableCache[itemLink]
	if (unusable ~= nil) then
		return unusable
	end
	if (not GetItemInfo(itemLink)) then
		return false
	end
	if (not scanner) then
		scanner = CreateFrame("GameTooltip", "DiabolicUnusableScanner", _G.WorldFrame, "GameTooltipTemplate")
	end
	scanner:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
	scanner:SetHyperlink(itemLink)
	unusable = false
	for i = 2, scanner:NumLines() do
		if isRed(_G["DiabolicUnusableScannerTextLeft"..i]) or isRed(_G["DiabolicUnusableScannerTextRight"..i]) then
			unusable = true
			break
		end
	end
	scanner:Hide()
	unusableCache[itemLink] = unusable
	return unusable
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
	updateQualityGlow(self, (not (questId or isQuestItem)) and quality)

	local itemLink = GetContainerItemLink(bagID, slotID)
	local iconTexture = _G[self:GetName().."IconTexture"]
	if (quality == QUALITY_POOR) then
		iconTexture:SetDesaturated(true)
		iconTexture:SetVertexColor(unpack(C.General.UIBackdrop))
	else
		iconTexture:SetDesaturated(false)
		if itemLink and isUnusable(itemLink) then
			iconTexture:SetVertexColor(unpack(UNUSABLE_COLOR))
		else
			iconTexture:SetVertexColor(1, 1, 1)
		end
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

end

-- A character window slot, after Blizzard updated it: our quality border,
-- unless the slot already has one of its own (some client patches give the
-- item buttons one).
local updateCharacterSlot = function(self)
	local slotID = self:GetID()
	if self.IconBorder or (slotID < FIRST_GEAR_SLOT) or (slotID > LAST_GEAR_SLOT) then
		return
	end
	local itemLink = GetInventoryItemLink("player", slotID)
	if (not borderCache[self]) then
		styleItem(self)
	end
	local iconBorder = borderCache[self]
	local quality = itemLink and select(3, GetItemInfo(itemLink))
	if (quality and (quality > QUALITY_COMMON) and C.Quality[quality]) then
		iconBorder:SetVertexColor(unpack(C.Quality[quality]))
	else
		iconBorder:SetVertexColor(unpack(C.General.UIBorder))
	end
	iconBorder:Show()
	updateQualityGlow(self, quality)
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

-- Another addon's bag slot (AdiBags'), after it updated it: as ours.
Module.StyleSlot = function(self, button, bagID)
	if (not borderCache[button]) then
		styleItem(button)
	end
	updateItem(button, bagID)
end

-- What's usable changes with the player's level, skills and recipes.
Module.ForgetUnusable = function(self)
	for itemLink in pairs(unusableCache) do
		unusableCache[itemLink] = nil
	end
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

	self:RegisterEvent("PLAYER_LEVEL_UP", "ForgetUnusable")
	self:RegisterEvent("SKILL_LINES_CHANGED", "ForgetUnusable")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB", "ForgetUnusable")
	hooksecurefunc("PaperDollItemSlotButton_Update", updateCharacterSlot)
end
