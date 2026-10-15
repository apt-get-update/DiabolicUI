-- A window for the master looter's rolls (the "LootFrame" settings'
-- rollWindow option): when the master looter, the leader or a raid warning
-- puts an item up for a roll in the group's chat, it shows the item, the
-- time left, and buttons to roll for it: main spec (/roll 100) or off spec
-- (/roll 99). Your roll shows on it, and it goes once the item is won or
-- the time is up. In the loot window's look (lootframe.lua).
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: RollWindow", "LOW")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local math_ceil = math.ceil
local math_max = math.max
local pairs = pairs
local string_gmatch = string.gmatch
local string_lower = string.lower
local table_remove = table.remove
local tonumber = tonumber
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetItemInfo = _G.GetItemInfo
local GetLootMethod = _G.GetLootMethod
local GetNumRaidMembers = _G.GetNumRaidMembers
local GetRaidRosterInfo = _G.GetRaidRosterInfo
local GetTime = _G.GetTime
local RandomRoll = _G.RandomRoll
local UnitName = _G.UnitName

-- Words that end a roll, in the message naming its winner
local ENDINGS = { "wins", "won", "winner", "awarded", "finished", "no one", "nobody", "cancel" }

-- "Name rolls 87 (1-100)" (GlobalStrings.lua)
local ROLL_PATTERN = "^" .. _G.RANDOM_ROLL_RESULT:gsub("([%(%)%-])", "%%%1"):gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)") .. "$"

-- The chat a roll can be put up in
local CHATS = {
	CHAT_MSG_RAID_WARNING = true, CHAT_MSG_RAID = true, CHAT_MSG_RAID_LEADER = true,
	CHAT_MSG_PARTY = true, CHAT_MSG_PARTY_LEADER = true
}

-- Who puts rolls up ------------------------------------------------------

-- The master looter's name, if there's one
local MasterLooter = function()
	local method, partyID, raidID = GetLootMethod()
	if (method ~= "master") then
		return
	end
	if raidID then
		return (GetRaidRosterInfo(raidID))
	elseif (partyID == 0) then
		return (UnitName("player"))
	elseif partyID then
		return (UnitName("party" .. partyID))
	end
end

-- The leader's or an assistant's name, in a raid
local IsRaidOfficer = function(name)
	for i = 1, GetNumRaidMembers() do
		local member, rank = GetRaidRosterInfo(i)
		if (member == name) then
			return rank and (rank > 0)
		end
	end
end

-- A raid warning can only come from them; the leader's messages say so;
-- in the raid's or party's chat, the master looter or an officer.
local CanPutUpRolls = function(event, sender)
	if (event == "CHAT_MSG_RAID_WARNING") or (event == "CHAT_MSG_RAID_LEADER") or (event == "CHAT_MSG_PARTY_LEADER") then
		return true
	end
	return (sender == MasterLooter()) or IsRaidOfficer(sender)
end

-- The rows -----------------------------------------------------------------

local OnRowUpdate = function(row, elapsed)
	local timeLeft = row.endTime - GetTime()
	if (timeLeft <= 0) then
		return Module:RemoveRow(row)
	end
	row.Bar:SetValue(timeLeft)
	row.Time:SetText(math_ceil(timeLeft))
	if (not row.hasInfo) then
		Module:UpdateItem(row) -- not seen by the client yet when it was put up
	end
end

local Roll = function(button)
	local row = button.row
	RandomRoll(1, button.max)
	row.rolling = true
end

local CreateRollButton = function(row, text, max)
	local config = Module.config.button
	local button = CreateFrame("Button", nil, row)
	button:SetSize(unpack(config.size))
	button.row, button.max = row, max

	local scale = config.size[1] / config.art_size[1]
	local width, height = config.texture_size[1] * scale, config.texture_size[2] * scale
	for _, state in ipairs({ "Normal", "Highlight", "Pushed" }) do
		local texture = button:CreateTexture(nil, (state == "Highlight") and "HIGHLIGHT" or "ARTWORK")
		texture:SetSize(width, height)
		texture:SetPoint("CENTER")
		texture:SetTexture(config.texture[state:lower()])
		button["Set" .. state .. "Texture"](button, texture)
	end

	local label = button:CreateFontString(nil, "OVERLAY")
	label:SetFontObject(config.font)
	label:SetPoint("CENTER")
	label:SetText(text)
	button:SetFontString(label)

	button:SetScript("OnClick", Roll)
	return button
end

local Item_OnEnter = function(icon)
	_G.GameTooltip:SetOwner(icon, "ANCHOR_RIGHT")
	_G.GameTooltip:SetHyperlink(icon.row.link)
	_G.GameTooltip:Show()
end

local Item_OnLeave = function()
	_G.GameTooltip:Hide()
end

Module.CreateRow = function(self)
	local config, iconConfig = self.config, self.look.icon
	local row = CreateFrame("Frame", nil, self.frame)
	row:SetSize(config.width, config.row_height)

	local item = CreateFrame("Frame", nil, row)
	item:SetSize(iconConfig.size, iconConfig.size)
	item:SetPoint("TOPLEFT", 0, 0)
	item:EnableMouse(true)
	item:SetScript("OnEnter", Item_OnEnter)
	item:SetScript("OnLeave", Item_OnLeave)
	item.row = row

	local icon = item:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints()
	icon:SetTexCoord(unpack(iconConfig.texcoords))

	-- the loot window's icon border
	local border = item:CreateTexture(nil, "OVERLAY")
	border:SetSize(unpack(iconConfig.border_size))
	border:SetPoint("TOPLEFT", unpack(iconConfig.border_offset))
	border:SetTexture(iconConfig.border_texture)

	local name = row:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(config.name_font)
	name:SetJustifyH("LEFT")
	name:SetPoint("TOPLEFT", item, "TOPRIGHT", config.gap, 0)
	name:SetPoint("RIGHT", row, "RIGHT", 0, 0)
	name:SetHeight(14)

	local bar = CreateFrame("StatusBar", nil, row)
	bar:SetStatusBarTexture(config.bar.texture)
	bar:SetStatusBarColor(unpack(config.bar.color))
	bar:SetHeight(config.bar.height)
	bar:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -4)
	bar:SetPoint("RIGHT", row, "RIGHT", -24, 0)
	local barBackdrop = bar:CreateTexture(nil, "BACKGROUND")
	barBackdrop:SetAllPoints()
	barBackdrop:SetTexture(0, 0, 0, .75)

	local time = row:CreateFontString(nil, "OVERLAY")
	time:SetFontObject(config.time_font)
	time:SetPoint("LEFT", bar, "RIGHT", 6, 0)

	local mainSpec = CreateRollButton(row, L["Main Spec"], config.main_spec)
	mainSpec:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, -6)
	local offSpec = CreateRollButton(row, L["Off Spec"], config.off_spec)
	offSpec:SetPoint("LEFT", mainSpec, "RIGHT", config.gap, 0)

	-- your roll, in the buttons' place once rolled
	local result = row:CreateFontString(nil, "OVERLAY")
	result:SetFontObject(config.result_font)
	result:SetPoint("LEFT", mainSpec, "LEFT", 0, 0)

	row.Icon, row.Name, row.Bar, row.Time, row.Result = icon, name, bar, time, result
	row.MainSpec, row.OffSpec = mainSpec, offSpec
	row:SetScript("OnUpdate", OnRowUpdate)
	return row
end

-- The item's icon and name, colored by its quality
Module.UpdateItem = function(self, row)
	local name, _, _, _, _, _, _, _, _, texture = GetItemInfo(row.link)
	row.hasInfo = name and true
	row.Icon:SetTexture(texture or [[Interface\Icons\INV_Misc_QuestionMark]])
	row.Name:SetText(row.link)
end

-- The window's size and its rows, one under the other
Module.Layout = function(self)
	local config, frame = self.config, self.frame
	local rows = self.rows
	for i, row in ipairs(rows) do
		row:ClearAllPoints()
		row:SetPoint("TOP", frame, "TOP", 0, -(config.top_padding + (i - 1) * (config.row_height + config.row_gap)))
	end
	if (#rows == 0) then
		frame:Hide()
		return
	end
	frame:SetHeight(config.top_padding + #rows * config.row_height + (#rows - 1) * config.row_gap + config.bottom_padding)
	frame:Show()
end

Module.FindRow = function(self, link)
	for _, row in ipairs(self.rows) do
		if (row.link == link) then
			return row
		end
	end
end

-- An item put up for a roll, for `seconds`: again, and its time starts over
Module.AddRoll = function(self, link, seconds)
	local row = self:FindRow(link)
	if (not row) then
		row = table_remove(self.unused) or self:CreateRow()
		row.link, row.rolling, row.rolled = link, nil, nil
		row.Result:SetText("")
		row.MainSpec:Show()
		row.OffSpec:Show()
		self.rows[#self.rows + 1] = row
		self:UpdateItem(row)
	end
	row.endTime = GetTime() + seconds
	row.Bar:SetMinMaxValues(0, seconds)
	row.Bar:SetValue(seconds)
	row:Show()
	self:Layout()
end

Module.RemoveRow = function(self, row)
	for i, shown in ipairs(self.rows) do
		if (shown == row) then
			table_remove(self.rows, i)
			break
		end
	end
	row:Hide()
	row.link = nil
	self.unused[#self.unused + 1] = row
	self:Layout()
end

-- The chat ----------------------------------------------------------------

-- "8s", "8 sec", "8 seconds" in a message
local SecondsIn = function(text)
	local seconds = text:match("(%d+)%s*s%f[%A]") or text:match("(%d+)%s*sec")
	return seconds and tonumber(seconds)
end

Module.OnChat = function(self, event, message, sender)
	if (not message) or not CanPutUpRolls(event, sender) then
		return
	end
	local lower = string_lower(message)
	local ending
	for _, word in ipairs(ENDINGS) do
		if lower:find(word, 1, true) then
			ending = true
			break
		end
	end
	local found
	for link in string_gmatch(message, "|c%x+|Hitem:[^|]+|h%[[^%]]+%]|h|r") do
		found = true
		local row = self:FindRow(link)
		if ending then
			if row then
				self:RemoveRow(row)
			end
		elseif lower:find("roll", 1, true) then
			self:AddRoll(link, math_max(SecondsIn(lower:gsub("|c%x+|h.-|h|r", "")) or self.config.seconds, 1))
		end
	end
	-- "Stopping rolls in 3": the last item's time
	if (not found) and (not ending) and self.rows[#self.rows] then
		local seconds = lower:find("roll", 1, true) and tonumber(lower:match("(%d+)"))
		if seconds and (seconds <= 60) then
			local row = self.rows[#self.rows]
			row.endTime = GetTime() + seconds
		end
	end
end

-- Your roll's result, in place of the buttons
Module.OnSystemMessage = function(self, event, message)
	local name, roll, low, high = (message or ""):match(ROLL_PATTERN)
	if (name ~= UnitName("player")) then
		return
	end
	high = tonumber(high)
	for _, row in ipairs(self.rows) do
		if row.rolling and (not row.rolled) then
			row.rolled = true
			row.MainSpec:Hide()
			row.OffSpec:Hide()
			row.Result:SetFormattedText(L["You rolled %d (%s)"], roll, (high == self.config.main_spec) and L["Main Spec"] or L["Off Spec"])
			return
		end
	end
end

-- The window ----------------------------------------------------------------

Module.CreateWindow = function(self)
	local config, look = self.config, self.look
	local frame = CreateFrame("Frame", "DiabolicRollFrame", _G.UIParent)
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
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

	local title = frame:CreateFontString(nil, "OVERLAY")
	title:SetFontObject(look.title_font)
	title:SetPoint("TOP", unpack(look.title_offset))
	title:SetText(L["Rolls"])

	self.frame = frame
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").rolls
	self.look = self:GetDB("Blizzard").loot
	self.rows, self.unused = {}, {}
end

Module.OnEnable = function(self)
	if (not self:GetConfig("LootFrame").rollWindow) then
		return
	end
	self:CreateWindow()
	for event in pairs(CHATS) do
		self:RegisterEvent(event, "OnChat")
	end
	self:RegisterEvent("CHAT_MSG_SYSTEM", "OnSystemMessage")
end
