-- A Sell Junk button on the merchant window: sells every grey item in the
-- bags in one click, and says what it brought in. Greyed out without junk.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: SellJunk")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local select = select

-- WoW API
local CreateFrame = _G.CreateFrame
local GetCoinTextureString = _G.GetCoinTextureString
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerNumSlots = _G.GetContainerNumSlots
local GetItemInfo = _G.GetItemInfo
local hooksecurefunc = _G.hooksecurefunc
local UseContainerItem = _G.UseContainerItem

-- Grey links start with this color, even before the item's info is cached.
local JUNK_COLOR = "|cff9d9d9d"

-- The item in that slot, its stack size and sell price, if it's junk.
-- An unknown price (item not cached yet) still counts: only a price of 0
-- means the merchant won't take it.
local GetJunk = function(bag, slot)
	local _, count, locked, _, _, _, link = GetContainerItemInfo(bag, slot)
	if link and (not locked) and (link:sub(1, 10) == JUNK_COLOR) then
		local price = select(11, GetItemInfo(link))
		if (price ~= 0) then
			return link, count or 1, price or 0
		end
	end
end

-- Calls func(bag, slot, count, price) for every junk item in the bags.
local ForEachJunk = function(func)
	for bag = 0, _G.NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
			local link, count, price = GetJunk(bag, slot)
			if link then
				func(bag, slot, count, price)
			end
		end
	end
end

-- How many junk items the bags hold, and what they sell for.
Module.CountJunk = function(self)
	local items, money = 0, 0
	ForEachJunk(function(_, _, count, price)
		items = items + 1
		money = money + count * price
	end)
	return items, money
end

Module.SellJunk = function(self)
	local items, money = self:CountJunk()
	if (items == 0) then
		return
	end
	-- the bag and slot only: a third argument would use it on yourself
	ForEachJunk(function(bag, slot) UseContainerItem(bag, slot) end)
	_G.DEFAULT_CHAT_FRAME:AddMessage(L["Sold %d junk items for %s."]:format(items, GetCoinTextureString(money)))
end

-- Greyed out when there's nothing to sell.
Module.UpdateButton = function(self)
	local items = self:CountJunk()
	if (items > 0) then
		self.button:Enable()
	else
		self.button:Disable()
	end
end

Module.ShowTooltip = function(self, button)
	local items, money = self:CountJunk()
	local tooltip = _G.GameTooltip
	tooltip:SetOwner(button, "ANCHOR_RIGHT")
	tooltip:SetText(L["Sell Junk"])
	if (items > 0) then
		tooltip:AddLine(L["%d grey items, for %s."]:format(items, GetCoinTextureString(money)), 1, 1, 1)
	else
		tooltip:AddLine(L["No grey items in your bags."], 1, 1, 1)
	end
	tooltip:Show()
end

-- In the strip along the window's bottom, left of your money.
Module.CreateButton = function(self)
	local merchant = _G.MerchantFrame
	local button = CreateFrame("Button", "DiabolicSellJunkButton", merchant, "UIPanelButtonTemplate")
	button:SetSize(90, 22)
	button:SetPoint("BOTTOMLEFT", merchant, "BOTTOMLEFT", 22, 64)
	button:SetText(L["Sell Junk"])
	button:SetScript("OnClick", function() self:SellJunk() end)
	button:SetScript("OnEnter", function(button) self:ShowTooltip(button) end)
	button:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
	self.button = button

	-- the merchant's own tab only, not the buyback one
	hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
		button:Show()
		self:UpdateButton()
	end)
	hooksecurefunc("MerchantFrame_UpdateBuybackInfo", function() button:Hide() end)
end

-- The bags are only watched while the window is open. MERCHANT_CLOSED can
-- come twice in a row.
Module.OnMerchantShow = function(self)
	if (not self.watching) then
		self.watching = true
		self:RegisterEvent("BAG_UPDATE", "UpdateButton")
	end
	self:UpdateButton()
end

Module.OnMerchantClosed = function(self)
	if self.watching then
		self.watching = nil
		self:UnregisterEvent("BAG_UPDATE", "UpdateButton")
	end
end

Module.OnEnable = function(self)
	self:CreateButton()
	self:RegisterEvent("MERCHANT_SHOW", "OnMerchantShow")
	self:RegisterEvent("MERCHANT_CLOSED", "OnMerchantClosed")
end
