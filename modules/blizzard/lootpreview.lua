-- The boss's loot coming up, in a list on the right of the screen (with the
-- roll window, rollwindow.lua, and its option): what the master looter posts
-- in the chat once they open the boss, as Raid Loot Suite ("Loot from Boss:
-- [a] [b]") and RollFor ("Boss dropped 2 items:", then "1. [a]") do, or
-- what someone with DiabolicUI saw opening the boss, sent to the group in
-- addon messages as Raid Roll did. The item being rolled stands out, and
-- goes from the list once its roll is over.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: LootPreview", "LOW")
local RollWindow = Engine:GetModule("Blizzard: RollWindow")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local string_gmatch = string.gmatch
local table_concat = table.concat
local table_remove = table.remove
local tonumber = tonumber
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetItemInfo = _G.GetItemInfo
local GetLootMethod = _G.GetLootMethod
local GetLootSlotInfo = _G.GetLootSlotInfo
local GetLootSlotLink = _G.GetLootSlotLink
local GetLootThreshold = _G.GetLootThreshold
local GetNumLootItems = _G.GetNumLootItems
local GetNumPartyMembers = _G.GetNumPartyMembers
local GetNumRaidMembers = _G.GetNumRaidMembers
local GetTime = _G.GetTime
local SendAddonMessage = _G.SendAddonMessage
local UnitGUID = _G.UnitGUID
local UnitIsDead = _G.UnitIsDead
local UnitIsPlayer = _G.UnitIsPlayer
local UnitName = _G.UnitName

local CHATS = {
	CHAT_MSG_RAID_WARNING = true, CHAT_MSG_RAID = true, CHAT_MSG_RAID_LEADER = true,
	CHAT_MSG_PARTY = true, CHAT_MSG_PARTY_LEADER = true
}

local LINK = "|c%x+|Hitem:[^|]+|h%[[^%]]+%]|h|r"

-- RollFor's numbered lines follow its "dropped" line within this time
local FOLLOW_UP = 10

-- The addon messages: "corpse~boss~slot~link", one per item
local PREFIX = "DiabolicUI"

-- The list ------------------------------------------------------------------

local Item_OnEnter = function(row)
	_G.GameTooltip:SetOwner(row, "ANCHOR_LEFT")
	_G.GameTooltip:SetHyperlink(row.link)
	_G.GameTooltip:Show()
end

local Item_OnLeave = function()
	_G.GameTooltip:Hide()
end

Module.CreateRow = function(self)
	local config = self.config
	local row = CreateFrame("Frame", nil, self.frame)
	row:SetSize(config.width, config.row_height)
	row:EnableMouse(true)
	row:SetScript("OnEnter", Item_OnEnter)
	row:SetScript("OnLeave", Item_OnLeave)

	local rolling = row:CreateTexture(nil, "BACKGROUND")
	rolling:SetAllPoints()
	rolling:SetTexture(unpack(config.rolling_color))

	local icon = row:CreateTexture(nil, "ARTWORK")
	icon:SetSize(config.icon_size, config.icon_size)
	icon:SetPoint("LEFT", 0, 0)
	icon:SetTexCoord(unpack(self.look.icon.texcoords))

	local name = row:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(config.name_font)
	name:SetJustifyH("LEFT")
	name:SetSize(config.width - config.icon_size - config.gap, config.row_height)
	name:SetPoint("LEFT", icon, "RIGHT", config.gap, 0)

	row.Rolling, row.Icon, row.Name = rolling, icon, name
	return row
end

-- The rows for the items, one under the other; the window goes with the last
Module.Update = function(self)
	local config, frame, items = self.config, self.frame, self.items
	self.waitingForInfo = nil
	for i, item in ipairs(items) do
		local row = self.rows[i] or self:CreateRow()
		self.rows[i] = row
		local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(item.link)
		self.waitingForInfo = self.waitingForInfo or (not texture)
		row.link = item.link
		row.Icon:SetTexture(texture or [[Interface\Icons\INV_Misc_QuestionMark]])
		row.Name:SetText(item.link)
		row:SetAlpha(item.rolling and 1 or config.waiting_alpha)
		if item.rolling then
			row.Rolling:Show()
		else
			row.Rolling:Hide()
		end
		row:ClearAllPoints()
		row:SetPoint("TOP", frame, "TOP", 0, -(config.top_padding + (i - 1) * config.row_height))
		row:Show()
	end
	for i = #items + 1, #self.rows do
		self.rows[i]:Hide()
	end
	if (#items == 0) then
		frame:Hide()
		return
	end
	frame:SetHeight(config.top_padding + #items * config.row_height + config.bottom_padding)
	frame:Show()
end

-- A new boss: its own list. `source`: the corpse, for a list from the
-- addon messages
Module.Start = function(self, boss, source)
	self.items, self.slots = {}, {}
	self.boss, self.source = boss, source
	self.title:SetText(boss or L["Coming Up"])
end

-- The links in a chat message: those the addon messages listed already
-- once are left out
Module.AddLinks = function(self, message)
	local listed = {}
	if self.source then
		for _, item in ipairs(self.items) do
			listed[item.link] = true
		end
	end
	for link in string_gmatch(message, LINK) do
		if (not listed[link]) then
			self.items[#self.items + 1] = { link = link }
		end
	end
	self:Update()
end

-- The first of these items not rolled yet, or the first rolled
local Find = function(items, link, rolling)
	for i, item in ipairs(items) do
		if (item.link == link) and ((not rolling) or (not item.rolling)) then
			return i, item
		end
	end
end

Module.OnRollStarted = function(self, event, link)
	local _, item = Find(self.items, link, true)
	if item then
		item.rolling = true
		self:Update()
	end
end

Module.OnRollEnded = function(self, event, link)
	for i, item in ipairs(self.items) do
		if (item.link == link) and item.rolling then
			table_remove(self.items, i)
			return self:Update()
		end
	end
end

-- The addon messages ---------------------------------------------------------

-- What you see opening a corpse under master loot, for the group: what the
-- master looter can give, the items at or above the loot threshold
Module.OnLootOpened = function(self)
	local channel = (GetNumRaidMembers() > 0) and "RAID" or (GetNumPartyMembers() > 0) and "PARTY"
	if (not channel) or (GetLootMethod() ~= "master") then
		return
	end
	local corpse, boss = "chest", nil
	if UnitIsDead("target") and not UnitIsPlayer("target") then
		corpse, boss = UnitGUID("target"), UnitName("target")
	end
	for slot = 1, GetNumLootItems() do
		local _, _, _, quality = GetLootSlotInfo(slot)
		local link = GetLootSlotLink(slot)
		if link and quality and (quality >= GetLootThreshold()) then
			SendAddonMessage(PREFIX, corpse .. "~" .. (boss or "") .. "~" .. slot .. "~" .. link, channel)
		end
	end
end

-- Anyone's, yours included: each slot of a corpse once, whoever opened it
Module.OnAddonMessage = function(self, event, prefix, message)
	if (prefix ~= PREFIX) then
		return
	end
	local corpse, boss, slot, link = message:match("^(.-)~(.-)~(%d+)~(" .. LINK .. ")$")
	if not corpse then
		return
	end
	if (corpse ~= self.source) then
		self:Start((boss ~= "") and boss or nil, corpse)
	end
	if (not self.slots[slot]) then
		self.slots[slot] = true
		self.items[#self.items + 1] = { link = link }
		self:Update()
	end
end

-- The chat ----------------------------------------------------------------

Module.OnChat = function(self, event, message, sender)
	if (not message) or not RollWindow.CanPutUpRolls(event, sender) then
		return
	end
	-- Raid Loot Suite: "Loot from Boss: [a] [b]", in several lines when long
	local boss = message:match("^Loot from (.-): ")
	if boss then
		-- the same boss the addon messages listed: theirs, the missing added
		if (boss ~= self.boss) or ((not self.source) and (GetTime() > self.lastLine + FOLLOW_UP)) then
			self:Start(boss)
		end
		self.lastLine = GetTime()
		return self:AddLinks(message)
	end
	-- RollFor: "Boss dropped 2 items:" or "2 items dropped:", then "1. [a]"
	if message:match("^%d+ items? dropped:$") then
		self:Start()
		self.lastLine = GetTime()
		return
	end
	boss = message:match("^(.-) dropped %d+ items?:$")
	if boss then
		self:Start(boss)
		self.lastLine = GetTime()
		return
	end
	if message:match("^%d+%. ") and (GetTime() <= self.lastLine + FOLLOW_UP) then
		self.lastLine = GetTime()
		-- "2x[a]": twice
		local count = tonumber(message:match("^%d+%. (%d+)x|c")) or 1
		for _ = 1, count do
			self:AddLinks(message)
		end
	end
end

-- Fake Loot Roll (/dui config, AddOns): a boss's loot and a roll on its
-- first item, as a raid warning puts them, to try both windows solo
local FAKE_LOOT = {
	"|cffff8000|Hitem:19019:0:0:0:0:0:0:0:0|h[Thunderfury, Blessed Blade of the Windseeker]|h|r",
	"|cff0070dd|Hitem:6182:0:0:0:0:0:0:0:0|h[Wirt's Third Leg]|h|r"
}

Module.ShowFakeRoll = function(self)
	if (not self.frame) then
		return
	end
	local player = UnitName("player")
	self:OnChat("CHAT_MSG_RAID_WARNING", "Loot from " .. L["Fake Boss"] .. ": " .. table_concat(FAKE_LOOT, " "), player)
	RollWindow:OnChat("CHAT_MSG_RAID_WARNING", "Roll for " .. FAKE_LOOT[1] .. " 20s", player)
end

-- The window ----------------------------------------------------------------

Module.CreateWindow = function(self)
	local config, look = self.config, self.look
	local frame = CreateFrame("Frame", "DiabolicLootPreviewFrame", _G.UIParent)
	frame:Hide()
	frame:SetFrameStrata("MEDIUM")
	frame:SetClampedToScreen(true)
	frame:SetWidth(config.width + 2 * config.side_padding)
	frame:SetPoint(unpack(config.position))
	frame:SetBackdrop(look.backdrop)
	frame:SetBackdropColor(unpack(look.backdrop_color))
	frame:SetBackdropBorderColor(unpack(look.backdrop_border_color))
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	-- items not seen by the client yet get their icon once it has them
	local sinceUpdate = 0
	frame:SetScript("OnUpdate", function(_, elapsed)
		sinceUpdate = sinceUpdate + elapsed
		if self.waitingForInfo and (sinceUpdate > .5) then
			sinceUpdate = 0
			self:Update()
		end
	end)

	local title = frame:CreateFontString(nil, "OVERLAY")
	title:SetFontObject(config.title_font)
	title:SetPoint("TOP", 0, -14)

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", 2, 2)
	close:SetScript("OnClick", function()
		self:Start()
		self:Update()
	end)

	self.frame, self.title, self.close = frame, title, close
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").preview
	self.look = self:GetDB("Blizzard").loot
	self.items, self.rows, self.lastLine = {}, {}, 0
end

Module.OnEnable = function(self)
	if (not self:GetConfig("LootFrame").rollWindow) then
		return
	end
	self:CreateWindow()
	self:Start()
	for event in pairs(CHATS) do
		self:RegisterEvent(event, "OnChat")
	end
	self:RegisterEvent("LOOT_OPENED", "OnLootOpened")
	self:RegisterEvent("CHAT_MSG_ADDON", "OnAddonMessage")
	self:RegisterMessage("ENGINE_ROLL_STARTED", "OnRollStarted")
	self:RegisterMessage("ENGINE_ROLL_ENDED", "OnRollEnded")
end
