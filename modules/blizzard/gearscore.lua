-- GearScore, as GearScoreLite counts it (the score most 3.3.5 players and
-- raid leaders read), with its colors: on equippable items' tooltips
-- (tooltips.lua and itemtooltips.lua ask here), with the average item
-- level under the model in the inspect window, in the character window's
-- right column (character.lua asks here), and by players' names
-- (tooltips.lua).
-- Our own code from GearScoreLite's formula: each item scores from its item
-- level, quality and slot; a player's score adds up their gear but the
-- shirt and tabard.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: GearScore", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local next = next
local pairs = pairs
local select = select
local string_format = string.format
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetItemInfo = _G.GetItemInfo
local IsAddOnLoaded = _G.IsAddOnLoaded
local UnitClass = _G.UnitClass
local UnitLevel = _G.UnitLevel

-- each slot's share of the score
local SLOT_SCALE = {
	INVTYPE_HEAD = 1, INVTYPE_CHEST = 1, INVTYPE_ROBE = 1, INVTYPE_LEGS = 1,
	INVTYPE_SHOULDER = .75, INVTYPE_WAIST = .75, INVTYPE_FEET = .75, INVTYPE_HAND = .75,
	INVTYPE_NECK = .5625, INVTYPE_WRIST = .5625, INVTYPE_FINGER = .5625, INVTYPE_TRINKET = .5625, INVTYPE_CLOAK = .5625,
	INVTYPE_2HWEAPON = 2, INVTYPE_WEAPON = 1, INVTYPE_WEAPONMAINHAND = 1, INVTYPE_WEAPONOFFHAND = 1,
	INVTYPE_SHIELD = 1, INVTYPE_HOLDABLE = 1,
	INVTYPE_RANGED = .3164, INVTYPE_RANGEDRIGHT = .3164, INVTYPE_THROWN = .3164, INVTYPE_RELIC = .3164
}

-- the item level curve, by quality (2 uncommon to 4 epic), above and up to
-- item level 120
local CURVE_HIGH = { [2] = { 73, 1 }, [3] = { 81.375, .8125 }, [4] = { 91.45, .65 } }
local CURVE_LOW = { [1] = { 0, 2.25 }, [2] = { 8, 2 }, [3] = { .75, 1.8 }, [4] = { 26, 1.2 } }
local SCALE = 1.8618

-- the color of a score, by thousands: { from, per point } for red, green, blue
local COLORS = {
	{ { .55, 0, .00045 }, { .55, 0, .00045 }, { .55, 0, .00045 } }, -- grey
	{ { 1, 1000, -.00088 }, { 1, 0, 0 }, { 1, 1000, -.001 } }, -- white
	{ { .12, 2000, -.00012 }, { 1, 2000, -.0005 }, { 0, 2000, .001 } }, -- green
	{ { 0, 3000, .00069 }, { .5, 3000, -.00022 }, { 1, 3000, -.00003 } }, -- blue
	{ { .69, 4000, .00025 }, { .28, 4000, .00019 }, { .97, 4000, -.00096 } }, -- purple
	{ { .94, 5000, .00006 }, { .47, 5000, -.00047 }, { 0, 0, 0 } } -- orange
}

-- a hunter's weapons count little, their ranged weapon a lot
local HUNTER_MELEE, HUNTER_RANGED = .3164, 5.3224

local MAIN_HAND, OFF_HAND, RANGED, SHIRT = 16, 17, 18, 4

Module.GetColor = function(self, score)
	if (not score) or (score <= 0) then
		return .55, .55, .55
	end
	score = math_min(score, 5999)
	local band = COLORS[math_floor((score - 1) / 1000) + 1]
	local color = {}
	for i = 1, 3 do
		local c = band[i]
		color[i] = c[1] + (score - c[2]) * c[3]
	end
	return color[1], color[2], color[3]
end

-- An item's score and item level; nil while it isn't cached, 0 when it
-- isn't gear.
Module.GetItemScore = function(self, item)
	local name, _, quality, level, _, _, _, _, equipLoc = GetItemInfo(item)
	if (not name) or (not level) then
		return
	end
	local slot = SLOT_SCALE[equipLoc]
	if (not slot) or (not quality) then
		return 0, level
	end
	local qualityScale = 1
	if (quality == 5) then -- legendary
		quality, qualityScale = 4, 1.3
	elseif (quality <= 1) then -- poor and common
		quality, qualityScale = 2, .005
	elseif (quality == 7) then -- heirloom: as a blue of 187
		quality, level = 3, 187.05
	end
	local curve = ((level > 120) and CURVE_HIGH or CURVE_LOW)[quality]
	if not curve then
		return 0, level
	end
	local score = math_floor((level - curve[1]) / curve[2] * slot * SCALE * qualityScale)
	return math_max(score, 0), level
end

-- Heirlooms scale with the wearer: their item level from theirs.
local HeirloomLevel = function(level)
	if level > 67 then
		return 187 - (80 - level) * 4
	elseif level > 57 then
		return 105 - (67 - level) * 2.8
	end
	return level + 5
end

-- A player's score and average item level (over 17 slots, 16 with a
-- two-hander alone); nil while some of their gear isn't cached.
Module.GetUnitScore = function(self, unit)
	local _, class = UnitClass(unit)
	local hunter = (class == "HUNTER")
	local mainHand, offHand = GetInventoryItemLink(unit, MAIN_HAND), GetInventoryItemLink(unit, OFF_HAND)
	-- Titan's Grip: two two-handers count half each
	local titanGrip = 1
	for _, link in ipairs({ mainHand or false, offHand or false }) do
		if link and (select(9, GetItemInfo(link)) == "INVTYPE_2HWEAPON") and mainHand and offHand then
			titanGrip = .5
		end
	end
	local score, levels, count, twoHander = 0, 0, 0, false
	for slot = 1, RANGED do
		if (slot ~= SHIRT) then
			local link = GetInventoryItemLink(unit, slot)
			if (not link) and GetInventoryItemTexture(unit, slot) then
				return -- there, not known yet (inspecting)
			end
			if link then
				local itemScore, level = self:GetItemScore(link)
				if not itemScore then
					return
				end
				if (slot == MAIN_HAND) or (slot == OFF_HAND) then
					itemScore = itemScore * titanGrip * (hunter and HUNTER_MELEE or 1)
					twoHander = twoHander or (select(9, GetItemInfo(link)) == "INVTYPE_2HWEAPON")
				elseif (slot == RANGED) and hunter then
					itemScore = itemScore * HUNTER_RANGED
				end
				if (select(3, GetItemInfo(link)) == 7) then
					level = HeirloomLevel(UnitLevel(unit))
				end
				score = score + itemScore
				levels = levels + level
				count = count + 1
			end
		end
	end
	local slots = (twoHander and (not offHand)) and 16 or 17
	return math_floor(score), (count > 0) and (levels / slots) or 0
end

-- "GS 5234   Item Level 245", the score in its color.
Module.FormatUnit = function(self, score, level)
	local r, g, b = self:GetColor(score)
	return string_format("|cff%02x%02x%02xGS %d|r   %s", r * 255, g * 255, b * 255, score, _G.ITEM_LEVEL:format(level))
end

-- The line under a model: the score and average item level of `unit`,
-- again a little later while its gear isn't all known.
local CreateLine = function(parent, anchor, config)
	local line = parent:CreateFontString(nil, "OVERLAY")
	line:SetFontObject(config.font)
	line:SetPoint(unpack(anchor))
	return line
end

Module.UpdateLine = function(self, line, unit)
	local score, level = self:GetUnitScore(unit)
	if score then
		line:SetText(self:FormatUnit(score, math_floor(level)))
		line.tries = nil
	else
		line:SetText("")
		line.tries = (line.tries or 0) + 1
		if (line.tries <= self.config.retries) then
			self.pending[line] = unit
			self.timer:Show()
		end
	end
end

-- the lines waiting on gear, tried again every `retry_delay`
Module.OnTimer = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if (self.elapsed < self.config.retry_delay) then
		return
	end
	self.elapsed = 0
	local waiting = self.pending
	self.pending = {}
	for line, unit in pairs(waiting) do
		self:UpdateLine(line, unit)
	end
	if not next(self.pending) then
		self.timer:Hide()
	end
end

Module.UpdateInspect = function(self)
	local frame = _G.InspectFrame
	if self.InspectLine and frame and frame:IsShown() and frame.unit then
		self:UpdateLine(self.InspectLine, frame.unit)
	end
end

Module.StyleInspect = function(self)
	local model = _G.InspectModelFrame
	if model and (not self.InspectLine) then
		self.InspectLine = CreateLine(model, { "BOTTOM", model, "BOTTOM", 0, self.config.inspect_offset }, self.config)
		_G.InspectFrame:HookScript("OnShow", function() self:UpdateInspect() end)
	end
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "Blizzard_InspectUI") then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleInspect()
	end
end

Module.OnEvent = function(self, event, unit)
	if (event == "INSPECT_TALENT_READY") then
		self:UpdateInspect()
	elseif (event == "UNIT_INVENTORY_CHANGED") then
		local frame = _G.InspectFrame
		if frame and frame.unit and (unit == frame.unit) then
			self:UpdateInspect()
		end
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").gearscore
	self.pending = {}
	self.timer = CreateFrame("Frame")
	self.timer:Hide()
	self.timer:SetScript("OnUpdate", function(_, elapsed) self:OnTimer(elapsed) end)
end

Module.OnEnable = function(self)
	self:RegisterEvent("INSPECT_TALENT_READY", "OnEvent")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")
	if IsAddOnLoaded("Blizzard_InspectUI") then
		self:StyleInspect()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
