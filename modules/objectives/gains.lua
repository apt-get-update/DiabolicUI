-- What you gain, in small lines at the right that fade out: gold, experience
-- and loot, the same again added to its line while that's still there.
-- (Not the loot if pretty_lootalert shows that. The chat keeps its lines.)
local _, Engine = ...
local Module = Engine:NewModule("Gains", "LOW")

-- Lua API
local _G = _G
local ipairs = ipairs
local math_min = math.min
local string_format = string.format
local table_insert = table.insert
local table_remove = table.remove
local tonumber = tonumber
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local GetItemIcon = _G.GetItemIcon
local GetMoney = _G.GetMoney
local UnitXP = _G.UnitXP

-- A global string ("You receive loot: %sx%d.") as a pattern: the link, the count.
local ToPattern = function(text)
	text = text:gsub("%%%d?%$?s", "\1"):gsub("%%%d?%$?d", "\2")
	text = text:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
	return "^" .. text:gsub("\1", "(.+)"):gsub("\2", "(%%d+)")
end

Module.Layout = function(self)
	local step = self.config.row_height + self.config.row_gap
	for i, row in ipairs(self.active) do
		row:ClearAllPoints()
		row:SetPoint("BOTTOMRIGHT", self.Holder, "BOTTOMRIGHT", 0, (i - 1) * step)
	end
end

Module.Release = function(self, index)
	local row = table_remove(self.active, index)
	row:Hide()
	row.key = nil
	table_insert(self.free, row)
end

Module.NewRow = function(self)
	local row = table_remove(self.free)
	if row then
		return row
	end
	local config = self.config
	row = CreateFrame("Frame", nil, self.Holder)
	row:SetSize(config.row_width, config.row_height)
	row.Icon = row:CreateTexture(nil, "ARTWORK")
	row.Icon:SetSize(config.row_height, config.row_height)
	row.Icon:SetPoint("RIGHT")
	row.Icon:SetTexCoord(unpack(config.icon_coords))
	row.Text = row:CreateFontString(nil, "OVERLAY")
	row.Text:SetFontObject(_G[config.font])
	row.Text:SetJustifyH("RIGHT")
	row.Text:SetPoint("RIGHT", -(config.row_height + config.row_gap), 0)
	return row
end

-- `amount` more of `key`: its line says Describe(the amount so far).
Module.Add = function(self, key, icon, Describe, amount)
	if not self.db.worldMessages then
		return
	end
	local row
	for _, active in ipairs(self.active) do
		if active.key == key then
			row = active
		end
	end
	if row then
		row.amount = row.amount + amount
	else
		row = self:NewRow()
		row.key, row.amount = key, amount
		row.Icon:SetTexture(icon)
		row:Show()
		table_insert(self.active, 1, row)
		while #self.active > self.config.max_rows do
			self:Release(#self.active)
		end
		self:Layout()
	end
	row.age = 0
	row:SetAlpha(1)
	row.Text:SetText(Describe(row.amount))
	self.Holder:Show()
end

Module.Tick = function(self, elapsed)
	local config, released = self.config, false
	for i = #self.active, 1, -1 do
		local row = self.active[i]
		row.age = row.age + elapsed
		local left = config.hold + config.fade - row.age
		if left <= 0 then
			self:Release(i)
			released = true
		else
			row:SetAlpha(math_min(1, left / config.fade))
		end
	end
	if released then
		self:Layout()
	end
	if not self.active[1] then
		self.Holder:Hide()
	end
end

local DescribeMoney = function(amount)
	return "+" .. Engine.CoinString(amount)
end

local DescribeXP = function(amount)
	return string_format("+%d %s", amount, _G.XP)
end

Module.PLAYER_MONEY = function(self)
	local money = GetMoney()
	local gained = money - self.money
	self.money = money
	if gained > 0 then
		self:Add("money", nil, DescribeMoney, gained)
	end
end

Module.PLAYER_XP_UPDATE = function(self)
	local xp = UnitXP("player")
	local gained = xp - self.xp
	self.xp = xp
	if gained > 0 then -- (less on a new level)
		self:Add("xp", nil, DescribeXP, gained)
	end
end

Module.AddItem = function(self, link, count)
	local color = link:match("|c%x%x%x%x%x%x%x%x") or ""
	local name = color .. (link:match("%[(.-)%]") or link)
	self:Add(link, GetItemIcon(link), function(amount)
		return (amount > 1) and string_format("%s x%d", name, amount) or name
	end, count)
end

Module.CHAT_MSG_LOOT = function(self, event, message)
	for _, pattern in ipairs(self.patterns) do
		local link, count = message:match(pattern)
		if link then
			self:AddItem(link, tonumber(count) or 1)
			return
		end
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Objectives").gains
	self.db = self:GetConfig("ObjectiveTracker")
end

Module.OnEnable = function(self)
	local config = self.config
	self.active, self.free = {}, {}
	self.money, self.xp = GetMoney(), UnitXP("player")

	self.Holder = Engine:CreateFrame("Frame", nil, Engine:GetFrame())
	self.Holder:SetSize(config.row_width, config.row_height)
	self.Holder:Place(unpack(config.position))
	self.Holder:SetFrameStrata("MEDIUM")
	self.Holder:Hide()
	self.Holder:SetScript("OnUpdate", function(_, elapsed)
		self:Tick(elapsed)
	end)

	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("PLAYER_XP_UPDATE")
	if not Engine:IsAddOnEnabled("pretty_lootalert") then
		-- (those with a count first: "%s" alone would take it in)
		self.patterns = {
			ToPattern(_G.LOOT_ITEM_SELF_MULTIPLE),
			ToPattern(_G.LOOT_ITEM_PUSHED_SELF_MULTIPLE),
			ToPattern(_G.LOOT_ITEM_SELF),
			ToPattern(_G.LOOT_ITEM_PUSHED_SELF),
		}
		self:RegisterEvent("CHAT_MSG_LOOT")
	end
end
