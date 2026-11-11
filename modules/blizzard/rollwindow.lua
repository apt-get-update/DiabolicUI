-- A window for the master looter's rolls (the "LootFrame" settings'
-- rollWindow option): when the master looter, the leader or a raid warning
-- puts an item up for a roll in the group's chat, it shows the item, the
-- time left, and buttons to roll for it: main spec (/roll 100) or off spec
-- (/roll 99). Your roll shows on it, and it goes once the item is won or
-- the time is up. In the loot window's look (lootframe.lua). With the
-- BiS-Tooltip Renewed addon, a line says if it's BiS for your specs.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: RollWindow", "LOW")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local math_ceil = math.ceil
local math_max = math.max
local math_min = math.min
local pairs = pairs
local string_gmatch = string.gmatch
local string_lower = string.lower
local table_concat = table.concat
local table_remove = table.remove
local tonumber = tonumber
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetItemInfo = _G.GetItemInfo
local GetItemQualityColor = _G.GetItemQualityColor
local GetLootMethod = _G.GetLootMethod
local GetNumRaidMembers = _G.GetNumRaidMembers
local GetRaidRosterInfo = _G.GetRaidRosterInfo
local GetTime = _G.GetTime
local RandomRoll = _G.RandomRoll
local UnitClass = _G.UnitClass
local UnitName = _G.UnitName

-- Words that end a roll, in the message naming its winner
local ENDINGS = { "wins", "won", "winner", "awarded", "finished", "no one", "nobody", "cancel" }

-- "Name rolls 87 (1-100)" (GlobalStrings.lua)
local ROLL_PATTERN = "^"
	.. _G.RANDOM_ROLL_RESULT:gsub("([%(%)%-])", "%%%1"):gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)")
	.. "$"

-- The chat a roll can be put up in
local CHATS = {
	CHAT_MSG_RAID_WARNING = true,
	CHAT_MSG_RAID = true,
	CHAT_MSG_RAID_LEADER = true,
	CHAT_MSG_PARTY = true,
	CHAT_MSG_PARTY_LEADER = true,
}

-- Who puts rolls up ------------------------------------------------------

-- The master looter's name, if there's one
local MasterLooter = function()
	local method, partyID, raidID = GetLootMethod()
	if method ~= "master" then
		return
	end
	if raidID then
		return (GetRaidRosterInfo(raidID))
	elseif partyID == 0 then
		return (UnitName("player"))
	elseif partyID then
		return (UnitName("party" .. partyID))
	end
end

-- The leader's or an assistant's name, in a raid
local IsRaidOfficer = function(name)
	for i = 1, GetNumRaidMembers() do
		local member, rank = GetRaidRosterInfo(i)
		if member == name then
			return rank and (rank > 0)
		end
	end
end

-- A raid warning can only come from them; the leader's messages say so;
-- in the raid's or party's chat, the master looter or an officer.
local CanPutUpRolls = function(event, sender)
	if
		(event == "CHAT_MSG_RAID_WARNING")
		or (event == "CHAT_MSG_RAID_LEADER")
		or (event == "CHAT_MSG_PARTY_LEADER")
	then
		return true
	end
	return (sender == MasterLooter()) or IsRaidOfficer(sender)
end
Module.CanPutUpRolls = CanPutUpRolls -- for the loot preview (lootpreview.lua)

-- BiS-Tooltip Renewed's ranks for your class's specs, in the phase picked
-- in its window: "T9: Holy BIS, Shadow alt 2". Nothing without it.
local BisText = function(link)
	local bis = _G.BisTooltipAddon
	local entries = bis and bis.ReverseLookup and bis.ReverseLookup[tonumber(link:match("item:(%d+)"))]
	local phases, db = _G.BisTooltip_PhaseData, bis and bis.db and bis.db.char
	local phase = entries and phases and db and phases[db.phase_index]
	if not phase then
		return
	end
	local _, token = UnitClass("player")
	local class = (token == "DEATHKNIGHT") and "Death Knight" or (token:sub(1, 1) .. token:sub(2):lower())
	local specs = {}
	for _, entry in ipairs(entries) do
		if entry.class == class then
			-- its labels: "T8 BIS / T9 alt 2"
			for label in (entry.rightText .. " / "):gmatch("(.-) / ") do
				local rank = label:match("^" .. phase .. " (.+)$")
				if rank then
					specs[#specs + 1] = entry.spec .. " " .. rank
				end
			end
		end
	end
	if #specs > 0 then
		return phase .. ": " .. table_concat(specs, ", ")
	end
end

-- The rows -----------------------------------------------------------------

-- The icon at this scale, around its own center
local SetItemScale = function(row, scale)
	local half = Module.config.icon_size / 2
	row.Item:SetScale(scale)
	row.Item:ClearAllPoints()
	row.Item:SetPoint("CENTER", row, "TOPLEFT", half / scale, -half / scale)
end

local OnRowUpdate = function(row, elapsed)
	-- a new item lands: it fades in, its icon shrinks to its size
	if row.appear then
		local config = Module.config
		row.appear = row.appear + elapsed
		local progress = math_min(row.appear / config.appear_time, 1)
		row:SetAlpha(progress)
		SetItemScale(row, config.appear_scale + (1 - config.appear_scale) * progress)
		if progress >= 1 then
			row.appear = nil
		end
	end
	local timeLeft = row.endTime - GetTime()
	if timeLeft <= 0 then
		return Module:RemoveRow(row)
	end
	row.Bar:SetValue(timeLeft)
	row.Time:SetText(math_ceil(timeLeft))
	if not row.hasInfo then
		Module:UpdateItem(row) -- not seen by the client yet when it was put up
	end
end

local Roll = function(button)
	local row = button.row
	RandomRoll(1, button.max)
	row.rolling = true
end

local Item_OnLeave = function()
	_G.GameTooltip:Hide()
end

-- The buttons' width, the slot right of the name they share with the roll
local ButtonsWidth = function()
	local config = Module.config.button
	return 3 * config.size + 2 * config.gap
end

-- The buttons, shown again when it's put up again
local ShowButtons = function(row)
	for _, button in ipairs(row.Buttons) do
		button:Show()
	end
	row.Result:SetText("")
	row.Slot:SetWidth(ButtonsWidth())
end

-- Your roll in the buttons' place, the bar shorter if it's wider
local ShowResult = function(row, text)
	row.rolled = true
	for _, button in ipairs(row.Buttons) do
		button:Hide()
	end
	row.Result:SetText(text)
	row.Slot:SetWidth(math_max(row.Result:GetStringWidth(), ButtonsWidth()))
end

-- Not rolling is passing: nothing to send
local Pass = function(button)
	ShowResult(button.row, L["You passed"])
end

local Button_OnEnter = function(button)
	_G.GameTooltip:SetOwner(button, "ANCHOR_TOP")
	_G.GameTooltip:AddLine(button.label)
	if button.max then
		_G.GameTooltip:AddLine("/roll " .. button.max, 1, 1, 1)
	end
	_G.GameTooltip:Show()
end

-- A roll's icon button (`art`: its textures), its name in its tooltip
local CreateRollButton = function(row, label, max, art)
	local config = Module.config.button
	local button = CreateFrame("Button", nil, row.Slot)
	if art then
		button:SetNormalTexture(art.normal)
		button:SetHighlightTexture(art.highlight, "ADD")
		button:SetPushedTexture(art.pushed)
	else
		Engine:GetModule("Blizzard: Windows"):SkinClose(button) -- the windows' X
	end
	button:SetSize(config.size, config.size)
	button.row, button.max, button.label = row, max, label
	button:SetScript("OnClick", Roll)
	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", Item_OnLeave)
	return button
end

local Item_OnEnter = function(icon)
	_G.GameTooltip:SetOwner(icon, "ANCHOR_RIGHT")
	_G.GameTooltip:SetHyperlink(icon.row.link)
	_G.GameTooltip:Show()
end

Module.CreateRow = function(self)
	local config, iconConfig = self.config, self.look.icon
	local row = CreateFrame("Frame", nil, self.frame)
	row:SetSize(config.width, config.row_height)

	local item = CreateFrame("Frame", nil, row)
	item:SetSize(config.icon_size, config.icon_size)
	item:EnableMouse(true)
	item:SetScript("OnEnter", Item_OnEnter)
	item:SetScript("OnLeave", Item_OnLeave)
	item.row = row

	local icon = item:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints()
	icon:SetTexCoord(unpack(iconConfig.texcoords))

	-- the loot window's icon border, and a glow behind, in the quality's color
	local border = item:CreateTexture(nil, "OVERLAY")
	border:SetSize(unpack(config.border_size))
	border:SetPoint("TOPLEFT", unpack(config.border_offset))
	border:SetTexture(iconConfig.border_texture)

	local glow = item:CreateTexture(nil, "BACKGROUND")
	glow:SetSize(config.glow_size, config.glow_size)
	glow:SetPoint("CENTER")
	glow:SetTexture(config.glow_texture)
	glow:SetBlendMode("ADD")
	glow:SetAlpha(config.glow_alpha)
	glow:Hide()

	-- at the right, level with the icon's middle: the buttons, then your roll
	local slot = CreateFrame("Frame", nil, row)
	slot:SetSize(ButtonsWidth(), config.button.size)
	slot:SetPoint("RIGHT", row, "TOPRIGHT", 0, -config.icon_size / 2)
	row.Slot = slot

	-- the name over the time bar, the two centered on the icon
	local name = row:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(config.name_font)
	name:SetJustifyH("LEFT")
	name:SetPoint(
		"TOPLEFT",
		row,
		"TOPLEFT",
		config.icon_size + config.gap,
		-(config.icon_size - config.name_height - 6 - config.bar.height) / 2
	)
	name:SetPoint("RIGHT", slot, "LEFT", -config.gap, 0)
	name:SetHeight(config.name_height)

	local bar = CreateFrame("StatusBar", nil, row)
	bar:SetStatusBarTexture(config.bar.texture)
	bar:SetStatusBarColor(unpack(config.bar.color))
	bar:SetHeight(config.bar.height)
	bar:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -6)
	bar:SetPoint("RIGHT", slot, "LEFT", -(config.gap + 20), 0) -- (the time's room)
	local barBackdrop = bar:CreateTexture(nil, "BACKGROUND")
	barBackdrop:SetAllPoints()
	barBackdrop:SetTexture(0, 0, 0, 0.75)

	local time = row:CreateFontString(nil, "OVERLAY")
	time:SetFontObject(config.time_font)
	time:SetPoint("LEFT", bar, "RIGHT", 6, 0)

	local gap = config.button.gap
	local pass = CreateRollButton(row, L["Pass"])
	pass:SetPoint("RIGHT", slot, "RIGHT", 0, 0)
	pass:SetScript("OnClick", Pass)
	local offSpec = CreateRollButton(row, L["Off Spec"], config.off_spec, config.button.off_spec)
	offSpec:SetPoint("RIGHT", pass, "LEFT", -gap, 0)
	local mainSpec = CreateRollButton(row, L["Main Spec"], config.main_spec, config.button.main_spec)
	mainSpec:SetPoint("RIGHT", offSpec, "LEFT", -gap, 0)

	-- your roll, in the buttons' place once rolled
	local result = slot:CreateFontString(nil, "OVERLAY")
	result:SetFontObject(config.result_font)
	result:SetPoint("RIGHT", slot, "RIGHT", 0, 0)

	-- BiS-Tooltip's ranks, under the bar
	local bis = row:CreateFontString(nil, "OVERLAY")
	bis:SetFontObject(config.bis_font)
	bis:SetTextColor(unpack(config.bis_color))
	bis:SetJustifyH("LEFT")
	bis:SetHeight(config.bis_height - 4)
	bis:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, -4)
	bis:SetPoint("RIGHT", slot, "RIGHT", 0, 0)

	row.Item, row.Icon, row.Border, row.Glow = item, icon, border, glow
	row.Name, row.Bar, row.Time, row.Result, row.Bis = name, bar, time, result, bis
	SetItemScale(row, 1)
	row.MainSpec, row.OffSpec, row.Pass = mainSpec, offSpec, pass
	row.Buttons = { mainSpec, offSpec, pass }
	row:SetScript("OnUpdate", OnRowUpdate)
	return row
end

-- The item's icon and name, colored by its quality
Module.UpdateItem = function(self, row)
	local name, _, quality, _, _, _, _, _, _, texture = GetItemInfo(row.link)
	row.hasInfo = name and true
	row.quality = quality
	row.Icon:SetTexture(texture or [[Interface\Icons\INV_Misc_QuestionMark]])
	row.Name:SetText(row.link)
	row.Bis:SetText(BisText(row.link) or "")
	if quality and (quality >= self.config.min_quality) then
		local r, g, b = GetItemQualityColor(quality)
		row.Border:SetVertexColor(r, g, b)
		row.Glow:SetVertexColor(r, g, b)
		row.Glow:Show()
	else
		row.Border:SetVertexColor(1, 1, 1)
		row.Glow:Hide()
	end
	self:TintFrame()
end

-- The window's border in the best item's quality color
Module.TintFrame = function(self)
	local best
	for _, row in ipairs(self.rows) do
		if row.quality and (row.quality >= self.config.min_quality) and ((not best) or (row.quality > best)) then
			best = row.quality
		end
	end
	if best then
		local r, g, b = GetItemQualityColor(best)
		self.frame:SetBackdropBorderColor(r, g, b, 1)
	else
		self.frame:SetBackdropBorderColor(unpack(self.look.backdrop_border_color))
	end
end

-- The window's size and its rows, one under the other, taller with
-- BiS-Tooltip for its line
Module.Layout = function(self)
	local config, frame = self.config, self.frame
	local rows = self.rows
	local rowHeight = config.row_height + (_G.BisTooltipAddon and config.bis_height or 0)
	-- as wide as the longest name needs, from width up to max_width
	local nameWidth = 0
	for _, row in ipairs(rows) do
		row:SetWidth(config.max_width) -- (its name measured cut short otherwise)
		nameWidth = math_max(nameWidth, row.Name:GetStringWidth())
	end
	local width = math_min(
		math_max(config.width, config.icon_size + config.gap + nameWidth + 4 + config.gap + ButtonsWidth()),
		config.max_width
	)
	frame:SetWidth(width + 2 * config.side_padding)
	for i, row in ipairs(rows) do
		row:SetWidth(width)
		row:SetHeight(rowHeight)
		row:ClearAllPoints()
		row:SetPoint("TOP", frame, "TOP", 0, -(config.top_padding + (i - 1) * (rowHeight + config.row_gap)))
	end
	if #rows == 0 then
		frame:Hide()
		return
	end
	self:TintFrame()
	frame:SetHeight(config.top_padding + #rows * rowHeight + (#rows - 1) * config.row_gap + config.bottom_padding)
	frame:Show()
end

Module.FindRow = function(self, link)
	for _, row in ipairs(self.rows) do
		if row.link == link then
			return row
		end
	end
end

-- An item put up for a roll, for `seconds`: again, and its time starts over
Module.AddRoll = function(self, link, seconds)
	local row = self:FindRow(link)
	if not row then
		row = table_remove(self.unused) or self:CreateRow()
		row.link, row.rolling, row.rolled = link, nil, nil
		ShowButtons(row)
		self.rows[#self.rows + 1] = row
		self:UpdateItem(row)
		row.appear = 0
		row:SetAlpha(0)
		SetItemScale(row, self.config.appear_scale)
		self:SendMessage("ENGINE_ROLL_STARTED", link)
	end
	row.endTime = GetTime() + seconds
	row.Bar:SetMinMaxValues(0, seconds)
	row.Bar:SetValue(seconds)
	row:Show()
	self:Layout()
end

Module.RemoveRow = function(self, row)
	for i, shown in ipairs(self.rows) do
		if shown == row then
			table_remove(self.rows, i)
			break
		end
	end
	row:Hide()
	self:SendMessage("ENGINE_ROLL_ENDED", row.link)
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
	if (not found) and not ending and self.rows[#self.rows] then
		local seconds = lower:find("roll", 1, true) and tonumber(lower:match("(%d+)"))
		if seconds and (seconds <= 60) then
			local row = self.rows[#self.rows]
			row.endTime = GetTime() + seconds
		end
	end
end

-- Your roll's result, in place of the buttons
Module.OnSystemMessage = function(self, event, message)
	local name, roll, _, high = (message or ""):match(ROLL_PATTERN)
	if name ~= UnitName("player") then
		return
	end
	high = tonumber(high)
	for _, row in ipairs(self.rows) do
		if row.rolling and not row.rolled then
			ShowResult(
				row,
				L["You rolled %d (%s)"]:format(
					roll,
					(high == self.config.main_spec) and L["Main Spec"] or L["Off Spec"]
				)
			)
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
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	-- the loot window's light popup: no title (its buttons say what it is)
	frame:SetBackdrop(look.backdrop)
	frame:SetBackdropColor(unpack(look.backdrop_color))
	frame:SetBackdropBorderColor(unpack(look.backdrop_border_color))

	self.frame = frame
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").rolls
	self.look = self:GetDB("Blizzard").loot
	self.rows, self.unused = {}, {}
end

Module.OnEnable = function(self)
	if not self:GetConfig("LootFrame").rollWindow then
		return
	end
	self:CreateWindow()
	for event in pairs(CHATS) do
		self:RegisterEvent(event, "OnChat")
	end
	self:RegisterEvent("CHAT_MSG_SYSTEM", "OnSystemMessage")
end
