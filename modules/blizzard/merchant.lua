-- Gives Blizzard's merchant window Diablo III's (windows.lua): the stone
-- window in its iron frame, the merchant's name in the plate over the red
-- band, the merchant and buyback tabs under it, on Diablo III's dark stone,
-- the wares in two columns of Diablo III's vendor slots (the icon in the
-- action buttons' border, the name and price beside it), the pages under them, the last item sold, the repairs, Sell
-- Junk (selljunk.lua) and your money in a row at the bottom.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Merchant", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local NUM_ITEMS = 12 -- the buyback tab's; the merchant's shows 10

-- Where the icon box is in a slot `size` big (the slot's art stretched to
-- it): its left, its top, its width and height.
local IconBox = function(config, size)
	local box, canvas = config.slot_box, config.slot_canvas
	local x, y = size[1] / canvas[1], size[2] / canvas[2]
	return box[1] * x, box[2] * y, (box[3] - box[1]) * x, (box[4] - box[2]) * y
end

-- An item (MerchantItemTemplate's) in a dark slot: the icon filling the
-- slot's icon box, in the action buttons' border, its name right of it, its price under the name (the
-- price, and the other currencies Blizzard puts beside it, hang off the
-- name's frame art, moved there out of sight).
Module.StyleItem = function(self, item, size, priceOffset)
	local config = self.config
	local name = item:GetName()
	local button = _G[name .. "ItemButton"]
	_G[name .. "SlotTexture"]:SetAlpha(0)
	local art = _G[name .. "NameFrame"]
	art:SetAlpha(0)
	art:ClearAllPoints()
	art:SetPoint("BOTTOMLEFT", button, "BOTTOMRIGHT", config.name_offset, -priceOffset)
	button:GetNormalTexture():SetAlpha(0)
	local left, top, iconWidth, iconHeight = IconBox(config, size)
	button:SetSize(iconWidth, iconHeight)
	kit:AddBorder(button, iconWidth)
	local text = _G[name .. "Name"]
	text:ClearAllPoints()
	text:SetPoint("TOPLEFT", button, "TOPRIGHT", config.name_offset, 1)
	text:SetSize(config.name_width, config.name_height)
	text:SetJustifyV("TOP")
	local slot = CreateFrame("Frame", nil, item)
	slot:SetFrameLevel(item:GetFrameLevel())
	slot:SetPoint("TOPLEFT", button, "TOPLEFT", -left, top)
	slot:SetSize(unpack(size))
	local cell = slot:CreateTexture(nil, "BACKGROUND")
	cell:SetTexture(config.slot_texture)
	cell:SetAllPoints()
	-- the whole slot hovered and clicked (Blizzard's button is the icon
	-- only), lit while it is: a warm glow over it, the icon's border gold
	button:SetHitRectInsets(-left, iconWidth + left - size[1], -top, iconHeight + top - size[2])
	button:GetHighlightTexture():SetAlpha(0)
	local glow = button:CreateTexture(nil, "HIGHLIGHT")
	glow:SetTexture(unpack(config.slot_glow))
	glow:SetBlendMode("ADD")
	glow:SetAllPoints(slot)
	local spec, scale = kit.config.button_border, iconWidth / 44
	local edge = button:CreateTexture(nil, "HIGHLIGHT")
	edge:SetTexture(config.border_highlight)
	edge:SetSize(spec.size[1] * scale, spec.size[2] * scale)
	edge:SetPoint("TOPLEFT", spec.offset[1] * scale, spec.offset[2] * scale)
end

-- The wares in two columns (Blizzard moves the rows on each update).
Module.LayoutItems = function(self)
	local config = self.config
	local x, y = unpack(config.items)
	local left, top = IconBox(config, config.slot_size)
	for i = 1, NUM_ITEMS do
		local item = _G["MerchantItem" .. i]
		local row, column = math_floor((i - 1) / 2), (i - 1) % 2
		item:ClearAllPoints()
		item:SetPoint("TOPLEFT", self.Window, "TOPLEFT",
			x + column * config.slot_pitch[1] + left, y - row * config.slot_pitch[2] - top)
	end
end

-- The repairs right of the last item sold (Blizzard moves them each time
-- it shows them): repair one, repair all, the guild's.
Module.LayoutRepairs = function(self)
	local all = _G.MerchantRepairAllButton
	all:ClearAllPoints()
	all:SetPoint("TOPLEFT", self.Window, "TOPLEFT", unpack(self.config.repair))
end

Module.StyleMerchant = function(self)
	local config = self.config
	local frame = _G.MerchantFrame

	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, config.background)
	self.Window = window
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + config.insets[3])
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:AddMedallion(self.Header, "coinbag")
	kit:SetTitle(self.Header, _G.MerchantNameText)
	kit:StyleClose(_G.MerchantFrameCloseButton, window, self.Header)

	-- the tabs in a row under the band (Blizzard sizes them)
	local tab = _G.MerchantFrameTab1
	tab:ClearAllPoints()
	tab:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", unpack(config.tab_offset))
	kit:AddTabStrip(self.Header)
	for i = 1, 2 do
		kit:StyleTab(_G["MerchantFrameTab" .. i], { inset = config.tab_inset, font = config.tab_font })
	end

	for i = 1, NUM_ITEMS do
		self:StyleItem(_G["MerchantItem" .. i], config.slot_size, config.price_offset)
	end
	self:LayoutItems()
	hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function() self:LayoutItems() end)
	hooksecurefunc("MerchantFrame_UpdateBuybackInfo", function() self:LayoutItems() end)

	-- the pages: back on the left, on on the right, the page between
	local prev, nextPage, page = _G.MerchantPrevPageButton, _G.MerchantNextPageButton, _G.MerchantPageText
	prev:ClearAllPoints()
	prev:SetPoint("LEFT", window, "TOPLEFT", config.items[1], config.pages_y)
	nextPage:ClearAllPoints()
	nextPage:SetPoint("RIGHT", window, "TOPRIGHT", -config.items[1], config.pages_y)
	page:ClearAllPoints()
	page:SetPoint("CENTER", window, "TOP", 0, config.pages_y)
	page:SetTextColor(unpack(config.page_color))

	-- the bottom row
	local buyback = _G.MerchantBuyBackItem
	self:StyleItem(buyback, config.buyback_size, config.buyback_price_offset)
	buyback:ClearAllPoints()
	local left, top = IconBox(config, config.buyback_size)
	buyback:SetPoint("TOPLEFT", window, "TOPLEFT", config.buyback[1] + left, config.buyback[2] - top)
	for _, name in ipairs({ "MerchantRepairItemButton", "MerchantRepairAllButton", "MerchantGuildBankRepairButton" }) do
		local button = _G[name]
		kit:AddBorder(button, button:GetWidth())
	end
	_G.MerchantRepairText:SetAlpha(0) -- their tooltips say it
	self:LayoutRepairs()
	hooksecurefunc("MerchantFrame_UpdateRepairButtons", function() self:LayoutRepairs() end)
	local junk = _G.DiabolicSellJunkButton
	if junk then
		junk:ClearAllPoints()
		junk:SetPoint("TOPRIGHT", window, "TOPRIGHT", unpack(config.sell_junk))
		kit:StyleButton(junk, config.button_height)
	end
	local money = _G.MerchantMoneyFrame
	money:ClearAllPoints()
	money:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", unpack(config.money))
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").merchant
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleMerchant()
end
