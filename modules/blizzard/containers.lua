-- Bag and bank slots: the item tooltips' icon frame, its edge in the
-- item's quality color (gold for quest items), a faint glow of that color up from the slot's bottom (Diablo
-- III's quality-colored slots), greyed out junk, items you can't use in
-- red, and a smaller quest starter "!". The character window's slots get
-- the quality border and glow too, and so do the inspected player's.
local ADDON, Engine = ...
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
local IsAddOnLoaded = _G.IsAddOnLoaded
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

-- Masque_Diabolic's "DiabolicUI BagButton" (as the item tooltips' icon):
-- its frame, its quality-colored border and its backdrop have their 64px
-- art in 128px files, drawn at twice the slot; the icon fills 54/64 of it
local ICON_TEXTURES = [[Interface\AddOns\]] .. ADDON .. [[\media\textures\]]
local ICON_FRAME = ICON_TEXTURES .. "DiabolicUI_Button_64x64_Border.tga"
local ICON_QUALITY_BORDER = ICON_TEXTURES .. "DiabolicUI_Button_64x64_BorderHighlight.tga"
local ICON_BACKDROP = ICON_TEXTURES .. "DiabolicUI_Button_64x64_BackdropBag.tga"
local ICON_ART_SCALE = 128/64
local ICON_FILL = 54/64
local EMPTY_SLOT_ALPHA = .6 -- an empty gear slot's silhouette, added over the dark slot

local borderCache = {} -- item button -> our border
local glowCache = {} -- item button -> its quality glow
local unusableCache = {} -- item link -> whether its tooltip has red lines
local scanner -- hidden tooltip read for those red lines

-- Replaces the slot's square normal texture with Masque_Diabolic's bag
-- button: its backdrop, the icon inside its frame, the frame swapped for
-- its border in a quality's color (each shades the icon: one at a time).
-- A slot Masque skins (AdiBags') keeps its backdrop and icon: 3.3.5 has no
-- sublevels to put ours under its icon, in the same layer.
local styleItem = function(self, masqued)
	-- (the inspect window's slots have theirs unnamed)
	local normalTexture = _G[self:GetName().."NormalTexture"] or self:GetNormalTexture()
	if normalTexture then
		normalTexture:Hide()
		normalTexture:SetAlpha(0)
	end

	local width, height = self:GetWidth() * ICON_ART_SCALE, self:GetHeight() * ICON_ART_SCALE
	if (not masqued) then
		local backdrop = self:CreateTexture()
		backdrop:SetDrawLayer("BACKGROUND")
		backdrop:SetTexture(ICON_BACKDROP)
		backdrop:SetPoint("CENTER", self, "CENTER", 0, 0)
		backdrop:SetSize(width, height)

		local icon = _G[self:GetName().."IconTexture"]
		icon:ClearAllPoints()
		icon:SetPoint("CENTER", self, "CENTER", 0, 0)
		icon:SetSize(self:GetWidth() * ICON_FILL, self:GetHeight() * ICON_FILL)
		icon:SetTexCoord(5/64, 59/64, 5/64, 59/64)

		-- hovered: its border lit faintly (Masque's), not Blizzard's blue square
		local highlight = self:GetHighlightTexture()
		if highlight then
			highlight:SetTexture(ICON_QUALITY_BORDER)
			highlight:ClearAllPoints()
			highlight:SetPoint("CENTER", self, "CENTER", 0, 0)
			highlight:SetSize(width, height)
			highlight:SetBlendMode("ADD")
			highlight:SetVertexColor(1, 1, 1, .25)
		end
	end
	local iconFrame = self:CreateTexture()
	iconFrame:SetDrawLayer("ARTWORK")
	iconFrame:SetTexture(ICON_FRAME)
	iconFrame:SetPoint("CENTER", self, "CENTER", 0, 0)
	iconFrame:SetSize(width, height)

	local iconBorder = self:CreateTexture()
	iconBorder:SetDrawLayer("OVERLAY")
	iconBorder:SetTexture(ICON_QUALITY_BORDER)
	iconBorder:SetPoint("CENTER", self, "CENTER", 0, 0)
	iconBorder:SetSize(width, height)
	iconBorder:Hide()
	hooksecurefunc(iconBorder, "Show", function() iconFrame:Hide() end)
	hooksecurefunc(iconBorder, "Hide", function() iconFrame:Show() end)

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
		iconBorder:Show()
	elseif (quality and (quality > QUALITY_COMMON) and C.Quality[quality]) then
		iconBorder:SetVertexColor(unpack(C.Quality[quality]))
		iconBorder:Show()
	else
		iconBorder:Hide()
	end
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

-- A character window slot (`unit`'s gear), after Blizzard updated it: our
-- quality border, instead of the one some client patches give the item buttons.
local updateGearSlot = function(self, unit)
	local slotID = self:GetID()
	if (slotID < FIRST_GEAR_SLOT) or (slotID > LAST_GEAR_SLOT) then
		return
	end
	if self.IconBorder then
		self.IconBorder:SetAlpha(0)
	end
	local itemLink = GetInventoryItemLink(unit, slotID)
	if (not borderCache[self]) then
		styleItem(self)
	end
	-- an empty one's silhouette (Blizzard's, near black) lit, as a ghost
	local icon = _G[self:GetName() .. "IconTexture"]
	if icon then
		icon:SetBlendMode(itemLink and "BLEND" or "ADD")
		icon:SetAlpha(itemLink and 1 or EMPTY_SLOT_ALPHA)
	end
	local iconBorder = borderCache[self]
	local quality = itemLink and select(3, GetItemInfo(itemLink))
	if (quality and (quality > QUALITY_COMMON) and C.Quality[quality]) then
		iconBorder:SetVertexColor(unpack(C.Quality[quality]))
		iconBorder:Show()
	else
		iconBorder:Hide()
	end
	updateQualityGlow(self, quality)
end

local updateCharacterSlot = function(self)
	updateGearSlot(self, "player")
end

local updateInspectSlot = function(self)
	local unit = _G.InspectFrame.unit
	if unit then
		updateGearSlot(self, unit)
	end
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

-- Another addon's bag slot (AdiBags'), after it updated it: as ours, its
-- item's icon cut inside the frame again (AdiBags shows it whole on each
-- update) unless Masque skins it.
Module.StyleSlot = function(self, button, bagID)
	local group = button.masqueGroup
	local masqued = group and not (group.db and group.db.Disabled)
	if (not borderCache[button]) then
		styleItem(button, masqued)
	end
	updateItem(button, bagID)
	if button.texture and (not masqued) then
		_G[button:GetName().."IconTexture"]:SetTexCoord(5/64, 59/64, 5/64, 59/64)
	end
end

-- The bags' frame around another window's item icon (`icon`, a texture
-- of `owner`'s: the reagents'), the icon cut inside it; its border, in a
-- quality's color by SetIconQuality, returned.
Module.FrameIcon = function(self, owner, icon)
	local size = icon:GetWidth() / ICON_FILL * ICON_ART_SCALE
	icon:SetTexCoord(5/64, 59/64, 5/64, 59/64)
	local iconFrame = owner:CreateTexture(nil, "ARTWORK")
	iconFrame:SetTexture(ICON_FRAME)
	iconFrame:SetPoint("CENTER", icon, "CENTER", 0, 0)
	iconFrame:SetSize(size, size)
	local iconBorder = owner:CreateTexture(nil, "OVERLAY")
	iconBorder:SetTexture(ICON_QUALITY_BORDER)
	iconBorder:SetPoint("CENTER", icon, "CENTER", 0, 0)
	iconBorder:SetSize(size, size)
	iconBorder:Hide()
	hooksecurefunc(iconBorder, "Show", function() iconFrame:Hide() end)
	hooksecurefunc(iconBorder, "Hide", function() iconFrame:Show() end)
	return iconBorder
end

-- A FrameIcon border in `quality`'s color, the plain frame up to common.
Module.SetIconQuality = function(self, iconBorder, quality)
	if (quality and (quality > QUALITY_COMMON) and C.Quality[quality]) then
		iconBorder:SetVertexColor(unpack(C.Quality[quality]))
		iconBorder:Show()
	else
		iconBorder:Hide()
	end
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
	if IsAddOnLoaded("Blizzard_InspectUI") then
		hooksecurefunc("InspectPaperDollItemSlotButton_Update", updateInspectSlot)
	else
		self:RegisterEvent("ADDON_LOADED", "ADDON_LOADED")
	end
end

-- The inspect window loads on demand.
Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "Blizzard_InspectUI") then
		hooksecurefunc("InspectPaperDollItemSlotButton_Update", updateInspectSlot)
		self:UnregisterEvent("ADDON_LOADED", "ADDON_LOADED")
	end
end
