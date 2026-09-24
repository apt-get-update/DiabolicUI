-- Diablo III style item tooltips: the item name in Exocet on a title banner
-- tinted by quality, the item's icon in a quality-colored box on the left
-- with the rest of the tooltip beside it, weapon DPS or armor as a big
-- number, and a bottom bar with the sell value and durability.
--
-- Works on Blizzard's own tooltips without replacing them, so other addons
-- adding lines (Questie, Altoholic, ...) keep working. Blizzard sizes the
-- tooltip itself; the layout here runs right after (a Show hook), shifts
-- the lines right of the icon, and grows the tooltip to make room. Space
-- for the big number is made by moving the line after it down, never by
-- changing a line's font: Blizzard reuses lines, so a changed font would
-- leak into the next tooltip (and comparison tooltips use a smaller one).
local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: ItemTooltips")
local F = Engine:GetDB("Library: Format")
local L = Engine:GetLocale()

-- Same incompatibilities as the tooltip styling itself
Module:SetIncompatible("TipTac")
Module:SetIncompatible("TinyTip")
Module:SetIncompatible("TinyTooltip")

-- Lua API
local _G = _G
local CreateFrame = _G.CreateFrame
local ipairs = ipairs
local pairs = pairs
local unpack = unpack
local math_abs = math.abs
local math_max = math.max
local math_floor = math.floor
local math_min = math.min
local string_gsub = string.gsub
local string_find = string.find
local string_gmatch = string.gmatch
local string_lower = string.lower
local string_match = string.match
local table_concat = table.concat

-- WoW API
local GetItemInfo = _G.GetItemInfo
local GetItemQualityColor = _G.GetItemQualityColor
local hooksecurefunc = _G.hooksecurefunc

-- Tooltips that show items
local TOOLTIPS = {
	"GameTooltip",
	"ItemRefTooltip",
	"ShoppingTooltip1", "ShoppingTooltip2", "ShoppingTooltip3",
	"ItemRefShoppingTooltip1", "ItemRefShoppingTooltip2", "ItemRefShoppingTooltip3"
}

-- Layout, in tooltip pixels
local PADDING = 10 -- Blizzard's own tooltip padding
local ICON_BOX = 56 -- the quality-colored box around the icon

-- The icon is drawn like Masque_Diabolic's "DiabolicUI BagButton" skin, with
-- DiabolicUI's copies of its textures: the frame and its quality-colored
-- border have their 64px art in 128px files, so they're drawn at twice the
-- box size, and the icon fills 54/64 of the box.
local ICON_TEXTURES = [[Interface\AddOns\]] .. ADDON .. [[\media\textures\]]
local ICON_FRAME = ICON_TEXTURES .. "DiabolicUI_Button_64x64_Border.tga"
local ICON_QUALITY_BORDER = ICON_TEXTURES .. "DiabolicUI_Button_64x64_BorderHighlight.tga"
local ICON_ART_SCALE = 128/64
local ICON_SIZE = ICON_BOX * 54/64
local ICON_QUALITY_MIN = 2 -- colored border from uncommon (green) up, like bag addons
local ICON_GAP = 10 -- between the box and the text beside it
local SHIFT = ICON_BOX + ICON_GAP -- how far the body text moves right
local TITLE_GAP = 8 -- between the title banner and the body
local BANNER_PAD = 8 -- banner space above and below the item name

-- The title banner is a small frame with the header border (a backdrop edge
-- file with ornamented top corners) over a dark background. The border
-- needs at least two corners' height, so it shrinks on short banners.
local HEADER_BORDER = [[Interface\AddOns\]] .. ADDON .. [[\media\textures\DiabolicUI_Tooltip_Header.tga]]
local HEADER_EDGE_SIZE = 16
local HEADER_INSET = 3

-- The Diablo III title glow: the header's soft oval background, tinted by
-- quality, behind the name.
local TITLE_GLOW = [[Interface\AddOns\]] .. ADDON .. [[\media\textures\DiabolicUI_Tooltip_Header_TitleBackground.tga]]
local TITLE_GLOW_MARGIN = 40 -- how far the glow reaches past the name on each side
local TITLE_GLOW_ALPHA = .6

-- Comparison tooltips: "Currently Equipped" becomes an "Equipped" tag in
-- its own frame above the name, as in Diablo III.
local TAG_GAP = 12 -- between the tag's line and the name's line
local TAG_COLOR = { .85, .75, .55 }

-- Space between side by side tooltips (comparisons): the backdrop reaches
-- past each tooltip's edge by its border offsets, plus this much air.
local COMPARE_GAP = 0
local BIG_NUMBER_TOP = 8 -- space above the big number
local BIG_NUMBER_HEIGHT = 66 -- from the big number's line to the next one: number, label, space around

-- Diablo III frames the content (everything between the title and the
-- price) and the price bar separately: thin bronze borders, the price bar
-- on a slightly lighter background.
local BOX_INSET = 2 -- boxes stay this far inside the tooltip's edges
local BOX_BORDER_COLOR = { .38, .32, .22, 1 }
local FOOTER_COLOR = { .1, .1, .1, 1 }
local CONTENT_TOP_GAP = 3 -- between the title banner and the content box
local FOOTER_BOX = 22 -- height of the price box
local FOOTER_GAP = 4 -- between the content box and the price box
-- DiabolicUI's tooltip backdrop reaches 12px below the tooltip (room for a
-- unit's health bar) but 8px on the other sides; the bottom box reaches
-- this much lower to even out the margin.
local BOTTOM_DROP = 4
local BOTTOM_Y = BOX_INSET - BOTTOM_DROP -- the lowest box's bottom, above the tooltip's bottom
local FOOTER_HEIGHT = BOTTOM_Y + FOOTER_BOX + FOOTER_GAP -- room added below the content
local COIN_Y_OFFSET = -2 -- centers the coin icons on the footer's 12px text

-- Turns a Blizzard format string ("(%.1f damage per second)") into a Lua
-- pattern capturing its numbers and texts, so it works for every client
-- language.
local ToPattern = function(template)
	local pattern = string_gsub(template, "%%[%d%.]*s", "\002")
	pattern = string_gsub(pattern, "%%[%d%.]*[df]", "\001")
	pattern = string_gsub(pattern, "([%(%)%.%+%-%*%?%[%]%^%$%%])", "%%%1")
	pattern = string_gsub(pattern, "\001", "([%%d%%.,]+)")
	pattern = string_gsub(pattern, "\002", "(.-)")
	return "^" .. pattern .. "$"
end

local DPS_PATTERN = ToPattern(_G.DPS_TEMPLATE)
local ARMOR_PATTERN = ToPattern(_G.ARMOR_TEMPLATE)
local DURABILITY_PATTERN = ToPattern(_G.DURABILITY_TEMPLATE)

-- Binding, quest item, class restriction, uniqueness and requirement lines
-- get their own color, the tag's gold. Only while Blizzard shows them in its
-- default white: a line it turned red (a class you're not, a level or skill
-- you don't have yet, a unique item you can't equip again) stays red.
local TAG_LINES = {
	[_G.ITEM_SOULBOUND] = true,
	[_G.ITEM_BIND_ON_PICKUP] = true,
	[_G.ITEM_BIND_ON_EQUIP] = true,
	[_G.ITEM_BIND_ON_USE] = true,
	[_G.ITEM_BIND_TO_ACCOUNT] = true,
	[_G.ITEM_ACCOUNTBOUND] = true,
	[_G.ITEM_BIND_QUEST] = true,
	[_G.ITEM_UNIQUE] = true,
	[_G.ITEM_UNIQUE_EQUIPPABLE] = true
}
local TAG_LINE_PATTERNS = {
	ToPattern(_G.ITEM_CLASSES_ALLOWED),
	ToPattern(_G.ITEM_UNIQUE_MULTIPLE),
	ToPattern(_G.ITEM_LIMIT_CATEGORY),
	ToPattern(_G.ITEM_LIMIT_CATEGORY_MULTIPLE),
	ToPattern(_G.ITEM_MIN_LEVEL),
	ToPattern(_G.ITEM_LEVEL_RANGE),
	ToPattern(_G.ITEM_LEVEL_RANGE_CURRENT),
	ToPattern(_G.ITEM_MIN_SKILL),
	ToPattern(_G.ITEM_REQ_SKILL),
	ToPattern(_G.ITEM_REQ_REPUTATION),
	ToPattern(_G.ITEM_REQ_ARENA_RATING)
}

local IsTagLine = function(text)
	if TAG_LINES[text] then
		return true
	end
	for _, pattern in ipairs(TAG_LINE_PATTERNS) do
		if string_match(text, pattern) then
			return true
		end
	end
end

-- Blizzard's default tooltip text color is pure white.
local IsDefaultColor = function(line)
	local r, g, b = line:GetTextColor()
	return (r > .99) and (g > .99) and (b > .99)
end

local TAG_COLOR_CODE = ("|cff%02x%02x%02x"):format(TAG_COLOR[1] * 255, TAG_COLOR[2] * 255, TAG_COLOR[3] * 255)

-- Colors the binding / class / unique text of a line. Some addons put
-- several texts in one line (ChromieTransmog turns "Soulbound" into
-- "Transmogrified" + a line break + "Soulbound"), so those are colored part
-- by part with color codes, leaving the other parts alone.
local HighlightTagLine = function(line)
	local text = line:GetText()
	if (not text) then
		return
	end
	if (not string_find(text, "\n", 1, true)) and (not string_find(text, "|c", 1, true)) then
		if IsTagLine(text) and IsDefaultColor(line) then
			line:SetTextColor(unpack(TAG_COLOR))
		end
		return
	end
	local segments, changed = {}, false
	for segment in string_gmatch(text .. "\n", "(.-)\n") do
		local plain = string_gsub(string_gsub(segment, "|c%x%x%x%x%x%x%x%x", ""), "|r", "")
		local isWhite
		if string_find(segment, "|c", 1, true) then
			isWhite = string_find(string_lower(segment), "^|c%x%xffffff") and true
		else
			isWhite = IsDefaultColor(line)
		end
		if isWhite and IsTagLine(plain) then
			segment = TAG_COLOR_CODE .. plain .. "|r"
			changed = true
		end
		segments[#segments + 1] = segment
	end
	if changed then
		line:SetText(table_concat(segments, "\n"))
	end
end

local HighlightTagLines = function(tooltip, info)
	local name = tooltip:GetName()
	for i = info.titleIndex + 1, tooltip:NumLines() do
		local line = _G[name .. "TextLeft" .. i]
		if line then
			HighlightTagLine(line)
		end
	end
end

-- A bordered box drawn on the tooltip itself (behind its text): an optional
-- background plus four 1px border lines.
local CreateBox = function(tooltip, backgroundColor)
	local box = {}
	box.bg = tooltip:CreateTexture(nil, "BACKGROUND")
	box.bg:SetTexture(1, 1, 1)
	if backgroundColor then
		box.bg:SetVertexColor(unpack(backgroundColor))
	else
		box.bg:SetVertexColor(0, 0, 0, 0)
	end
	local lines = {
		top = { "TOPLEFT", "TOPRIGHT" },
		bottom = { "BOTTOMLEFT", "BOTTOMRIGHT" },
		left = { "TOPLEFT", "BOTTOMLEFT" },
		right = { "TOPRIGHT", "BOTTOMRIGHT" }
	}
	box.regions = { box.bg }
	for side, points in pairs(lines) do
		local line = tooltip:CreateTexture(nil, "BORDER")
		line:SetTexture(1, 1, 1)
		line:SetVertexColor(unpack(BOX_BORDER_COLOR))
		line:SetPoint(points[1], box.bg, points[1])
		line:SetPoint(points[2], box.bg, points[2])
		if (side == "top") or (side == "bottom") then
			line:SetHeight(1)
		else
			line:SetWidth(1)
		end
		box.regions[#box.regions + 1] = line
	end
	return box
end

-- From topY (measured from the tooltip's topPoint) down to bottomY above
-- the tooltip's bottom, full width.
local PlaceBox = function(box, tooltip, topPoint, topY, bottomY)
	box.bg:ClearAllPoints()
	box.bg:SetPoint("TOPLEFT", tooltip, topPoint, BOX_INSET, topY)
	box.bg:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -BOX_INSET, bottomY)
end

-- A title banner: a child frame of the tooltip, one level above it so its
-- border draws over the tooltip's own (hidden) title line.
local CreateHeader = function(tooltip)
	local header = CreateFrame("Frame", nil, tooltip)
	header:Hide()
	return header
end

-- Spans the tooltip's width between top and bottom (offsets from the
-- tooltip's top), with the border as large as the banner allows.
local PlaceHeader = function(header, tooltip, top, bottom, r, g, b)
	header:SetFrameLevel(tooltip:GetFrameLevel() + 1)
	header:ClearAllPoints()
	header:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 1, top)
	header:SetPoint("BOTTOMRIGHT", tooltip, "TOPRIGHT", -1, bottom)
	local edgeSize = math_min(HEADER_EDGE_SIZE, math_floor((top - bottom) / 2))
	if (header.edgeSize ~= edgeSize) then
		header.edgeSize = edgeSize
		header:SetBackdrop({
			bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
			edgeFile = HEADER_BORDER,
			edgeSize = edgeSize,
			insets = { left = HEADER_INSET, right = HEADER_INSET, top = HEADER_INSET, bottom = HEADER_INSET }
		})
	end
	header:SetBackdropColor(r, g, b, 1)
	header:SetBackdropBorderColor(1, 1, 1, 1)
end

-- The per-tooltip widgets, created on first use. Apart from the banners,
-- everything is a region of the tooltip itself, so it draws above the
-- backdrop and below the text.
local GetParts = function(tooltip)
	local parts = tooltip.DiabolicItemParts
	if parts then
		return parts
	end
	parts = {}

	parts.header = CreateHeader(tooltip)
	parts.title = parts.header:CreateFontString(nil, "OVERLAY")
	parts.title:SetFontObject(DiabolicFont_HeaderRegular16)
	parts.title:SetJustifyH("CENTER")
	parts.title:SetPoint("CENTER", parts.header, "CENTER", 0, 0)
	parts.titleGlow = parts.header:CreateTexture(nil, "ARTWORK")
	parts.titleGlow:SetTexture(TITLE_GLOW)
	parts.titleGlow:SetBlendMode("ADD")
	parts.titleGlow:SetPoint("CENTER", parts.header, "CENTER", 0, 0)

	parts.tagHeader = CreateHeader(tooltip)
	parts.tagText = parts.tagHeader:CreateFontString(nil, "OVERLAY")
	parts.tagText:SetFontObject(DiabolicFont_HeaderRegular12)
	parts.tagText:SetTextColor(unpack(TAG_COLOR))
	parts.tagText:SetText(L["Equipped"])
	parts.tagText:SetPoint("CENTER", parts.tagHeader, "CENTER", 0, 0)

	parts.iconBox = tooltip:CreateTexture(nil, "BACKGROUND")
	parts.iconBox:SetTexture(1, 1, 1)
	parts.iconBox:SetSize(ICON_BOX, ICON_BOX)

	parts.icon = tooltip:CreateTexture(nil, "BORDER")
	parts.icon:SetTexCoord(5/64, 59/64, 5/64, 59/64)
	parts.icon:SetPoint("CENTER", parts.iconBox, "CENTER", 0, 0)
	parts.icon:SetSize(ICON_SIZE, ICON_SIZE)

	parts.iconBorder = tooltip:CreateTexture(nil, "ARTWORK")
	parts.iconBorder:SetTexture(ICON_FRAME)
	parts.iconBorder:SetPoint("CENTER", parts.iconBox, "CENTER", 0, 0)
	parts.iconBorder:SetSize(ICON_BOX * ICON_ART_SCALE, ICON_BOX * ICON_ART_SCALE)

	parts.iconQuality = tooltip:CreateTexture(nil, "OVERLAY")
	parts.iconQuality:SetTexture(ICON_QUALITY_BORDER)
	parts.iconQuality:SetPoint("CENTER", parts.iconBox, "CENTER", 0, 0)
	parts.iconQuality:SetSize(ICON_BOX * ICON_ART_SCALE, ICON_BOX * ICON_ART_SCALE)

	parts.bigNumber = tooltip:CreateFontString(nil, "ARTWORK")
	parts.bigNumber:SetFontObject(DiabolicFont_SerifRegular28)
	parts.bigNumber:SetTextColor(1, 1, 1)

	parts.bigLabel = tooltip:CreateFontString(nil, "ARTWORK")
	parts.bigLabel:SetFontObject(DiabolicFont_SansRegular12)
	parts.bigLabel:SetTextColor(.6, .6, .6)
	parts.bigLabel:SetPoint("TOPLEFT", parts.bigNumber, "BOTTOMLEFT", 1, -1)

	parts.contentBox = CreateBox(tooltip)
	parts.footerBox = CreateBox(tooltip, FOOTER_COLOR)

	parts.sellValue = tooltip:CreateFontString(nil, "ARTWORK")
	parts.sellValue:SetFontObject(DiabolicFont_SansRegular12)
	parts.sellValue:SetTextColor(.75, .75, .75)

	parts.durability = tooltip:CreateFontString(nil, "ARTWORK")
	parts.durability:SetFontObject(DiabolicFont_SansRegular12)
	parts.durability:SetTextColor(.75, .75, .75)

	parts.all = {
		parts.header, parts.tagHeader,
		parts.iconBox, parts.icon, parts.iconBorder, parts.iconQuality,
		parts.bigNumber, parts.bigLabel, parts.sellValue, parts.durability
	}
	for _, box in ipairs({ parts.contentBox, parts.footerBox }) do
		for _, region in ipairs(box.regions) do
			parts.all[#parts.all + 1] = region
		end
	end
	parts.tag = { parts.tagHeader }
	tooltip.DiabolicItemParts = parts
	return parts
end

-- Undoes everything: the tooltip goes back to Blizzard's layout.
local Reset = function(tooltip)
	local info = tooltip.DiabolicItemInfo
	tooltip.DiabolicItemInfo = nil
	local parts = tooltip.DiabolicItemParts
	if parts then
		for _, region in ipairs(parts.all) do
			region:Hide()
		end
	end
	if info then
		local name = tooltip:GetName()
		local title = _G[name .. "TextLeft" .. info.titleIndex]
		if title then
			title:SetAlpha(1)
		end
		local nextLine = _G[name .. "TextLeft" .. (info.titleIndex + 1)]
		if nextLine then
			nextLine:ClearAllPoints()
			nextLine:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
		end
		if (info.titleIndex == 2) then
			local tagLine = _G[name .. "TextLeft1"]
			tagLine:SetAlpha(1)
			title:ClearAllPoints()
			title:SetPoint("TOPLEFT", tagLine, "BOTTOMLEFT", 0, -2)
		end
		if info.bigLine then
			local afterBig = _G[name .. "TextLeft" .. (info.bigLine + 1)]
			if afterBig then
				afterBig:ClearAllPoints()
				afterBig:SetPoint("TOPLEFT", _G[name .. "TextLeft" .. info.bigLine], "BOTTOMLEFT", 0, -2)
			end
		end
	end
end

-- The top of a region, relative to the top of the tooltip.
local OffsetFromTop = function(tooltip, region, edge)
	local top = tooltip:GetTop()
	local y = (edge == "BOTTOM") and region:GetBottom() or region:GetTop()
	if top and y then
		return y - top
	end
end

-- Runs after Blizzard has sized the tooltip: arranges our parts around
-- its lines, then grows it to fit.
local Layout = function(tooltip)
	local info = tooltip.DiabolicItemInfo
	if (not info) then
		return
	end
	local _, link = tooltip:GetItem()
	if (link ~= info.link) then
		return Reset(tooltip)
	end

	local name = tooltip:GetName()
	local titleLine = _G[name .. "TextLeft" .. info.titleIndex]
	local nextLine = _G[name .. "TextLeft" .. (info.titleIndex + 1)]
	local parts = GetParts(tooltip)
	local r, g, b = info.r, info.g, info.b

	-- (again: other addons may have edited lines since OnTooltipSetItem)
	HighlightTagLines(tooltip, info)

	-- Comparison tooltips: the "Currently Equipped" line makes room for the tag.
	local tagLine = (info.titleIndex == 2) and _G[name .. "TextLeft1"]
	if tagLine then
		tagLine:SetAlpha(0)
		titleLine:ClearAllPoints()
		titleLine:SetPoint("TOPLEFT", tagLine, "BOTTOMLEFT", 0, -TAG_GAP)
	end

	-- Body text moves right, next to the icon.
	titleLine:SetAlpha(0)
	if nextLine then
		nextLine:ClearAllPoints()
		-- below the banner (which reaches BANNER_PAD under the name), level with the icon
		nextLine:SetPoint("TOPLEFT", titleLine, "BOTTOMLEFT", SHIFT, -(BANNER_PAD + TITLE_GAP))
	end

	local titleTop = OffsetFromTop(tooltip, titleLine, "TOP")
	local titleBottom = OffsetFromTop(tooltip, titleLine, "BOTTOM")
	if (not titleTop) or (not titleBottom) then
		return -- not placed on screen yet; the next Show lays it out
	end

	-- Title banner
	local bannerTop, bannerBottom = titleTop + BANNER_PAD, titleBottom - BANNER_PAD
	if (info.titleIndex == 1) then
		bannerTop = -1
	end
	-- nearly black, so the glow behind the name stands out
	PlaceHeader(parts.header, tooltip, bannerTop, bannerBottom, r * .08, g * .08, b * .08)

	-- "Equipped" tag, in the room left by the "Currently Equipped" line
	if tagLine then
		local tagBottom = OffsetFromTop(tooltip, tagLine, "BOTTOM") - 4
		PlaceHeader(parts.tagHeader, tooltip, -1, tagBottom, .1, .09, .07)
	end

	parts.title:SetText(info.name)
	parts.title:SetTextColor(r, g, b)

	parts.titleGlow:SetVertexColor(r, g, b, TITLE_GLOW_ALPHA)

	-- Icon box
	parts.iconBox:ClearAllPoints()
	parts.iconBox:SetPoint("TOPLEFT", tooltip, "TOPLEFT", PADDING, bannerBottom - TITLE_GAP)
	parts.iconBox:SetGradientAlpha("VERTICAL", r * .15, g * .15, b * .15, 1, r * .55, g * .55, b * .55, 1)
	parts.icon:SetTexture(info.icon)
	parts.iconQuality:SetVertexColor(r, g, b)

	-- Big number, on its emptied line, with the next line moved down to
	-- make room for it
	local bigLine = info.bigLine and _G[name .. "TextLeft" .. info.bigLine]
	local bigExtra = 0
	if bigLine then
		parts.bigNumber:ClearAllPoints()
		parts.bigNumber:SetPoint("TOPLEFT", bigLine, "TOPLEFT", 0, -BIG_NUMBER_TOP)
		parts.bigNumber:SetText(info.bigNumber)
		parts.bigLabel:SetText(info.bigLabel)

		local gap = BIG_NUMBER_HEIGHT - bigLine:GetHeight()
		local afterBig = _G[name .. "TextLeft" .. (info.bigLine + 1)]
		if afterBig and (info.bigLine < tooltip:NumLines()) then
			afterBig:ClearAllPoints()
			afterBig:SetPoint("TOPLEFT", bigLine, "BOTTOMLEFT", 0, -gap)
			info.gapOffset = -gap
			bigExtra = gap - 2 -- Blizzard already counted its usual 2px
		else
			info.gapOffset = nil
			bigExtra = gap
		end
	end

	-- Footer: sell value (unless Blizzard already shows a price) and durability
	-- (the stack's price Blizzard passed along, else one item's)
	local sellPrice = tooltip.DiabolicSellPrice or info.sellPrice
	local sellValue = (sellPrice and sellPrice > 0) and F.Money(sellPrice, COIN_Y_OFFSET)
	local hasFooter = sellValue or info.durability

	-- Size: wider by the icon shift, tall enough for the icon, plus the footer.
	-- Start from Blizzard's own measurement; when the tooltip still has the
	-- size set here last time, that's the one measured back then.
	local baseWidth, baseHeight = tooltip:GetWidth(), tooltip:GetHeight()
	if info.width and (math_abs(baseWidth - info.width) < .5) and (math_abs(baseHeight - info.height) < .5) then
		baseWidth, baseHeight = info.baseWidth, info.baseHeight
	end
	info.baseWidth, info.baseHeight = baseWidth, baseHeight
	local width = math_max(baseWidth + SHIFT, parts.title:GetStringWidth() + PADDING * 4)
	local height = baseHeight + (BANNER_PAD + TITLE_GAP - 2) + bigExtra + (tagLine and (TAG_GAP - 2) or 0)
	height = math_max(height, -bannerBottom + TITLE_GAP + ICON_BOX + PADDING)
	if hasFooter then
		height = height + FOOTER_HEIGHT
	end
	tooltip:SetWidth(width)
	tooltip:SetHeight(height)
	info.width, info.height = width, height

	-- the glow stays inside the banner's border
	local glowWidth = math_min(parts.title:GetStringWidth() + TITLE_GLOW_MARGIN * 2, width - PADDING * 4)
	parts.titleGlow:SetSize(glowWidth, bannerTop - bannerBottom)

	-- Content box: from under the banner to above the price box
	PlaceBox(parts.contentBox, tooltip, "TOPLEFT", bannerBottom - CONTENT_TOP_GAP, hasFooter and FOOTER_HEIGHT or BOTTOM_Y)

	if hasFooter then
		PlaceBox(parts.footerBox, tooltip, "BOTTOMLEFT", BOTTOM_Y + FOOTER_BOX, BOTTOM_Y)
		local textY = BOTTOM_Y + (FOOTER_BOX - 12) / 2 -- centered in the box
		parts.sellValue:ClearAllPoints()
		parts.sellValue:SetPoint("BOTTOMLEFT", tooltip, "BOTTOMLEFT", PADDING, textY)
		parts.sellValue:SetText(sellValue and (_G.SELL_PRICE .. ": " .. sellValue) or "")
		parts.durability:ClearAllPoints()
		parts.durability:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -PADDING, textY)
		parts.durability:SetText(info.durability or "")
	end

	for _, region in ipairs(parts.all) do
		region:Show()
	end
	if (not bigLine) then
		parts.bigNumber:Hide()
		parts.bigLabel:Hide()
	end
	if (info.quality < ICON_QUALITY_MIN) then
		parts.iconQuality:Hide()
	end
	if (not hasFooter) then
		for _, region in ipairs(parts.footerBox.regions) do
			region:Hide()
		end
		parts.sellValue:Hide()
		parts.durability:Hide()
	end
	if (not tagLine) then
		for _, region in ipairs(parts.tag) do
			region:Hide()
		end
	end
end

-- Blizzard sometimes lays the lines out again without a Show(): a line
-- added on its own re-measures the tooltip (dropping the extra room made
-- above), and the item refresh every 0.2 seconds puts the lines back in
-- their default place without changing the size. Either way, redo the
-- layout as soon as it happens.
local OnUpdate = function(tooltip)
	local info = tooltip.DiabolicItemInfo
	if (not info) or (not info.width) then
		return
	end
	local width, height = tooltip:GetWidth(), tooltip:GetHeight()
	if (math_abs(width - info.width) > .5) or (math_abs(height - info.height) > .5) then
		return Layout(tooltip)
	end
	local name = tooltip:GetName()
	local nextLine = _G[name .. "TextLeft" .. (info.titleIndex + 1)]
	if nextLine then
		local _, relativeTo, _, x = nextLine:GetPoint()
		if (relativeTo ~= _G[name .. "TextLeft" .. info.titleIndex]) or (not x) or (math_abs(x - SHIFT) > .5) then
			return Layout(tooltip)
		end
	end
	if info.gapOffset then
		local afterBig = _G[name .. "TextLeft" .. (info.bigLine + 1)]
		local _, _, _, _, y = afterBig:GetPoint()
		if (not y) or (math_abs(y - info.gapOffset) > .5) then
			Layout(tooltip)
		end
	end
end

-- Reads the item from the tooltip Blizzard just filled, and replaces the
-- lines that move into the big number and the footer.
Module.OnTooltipSetItem = function(self, tooltip)
	Reset(tooltip)

	local _, link = tooltip:GetItem()
	local itemName, quality, icon, sellPrice
	if link and self.db.reskinTooltip then
		itemName, _, quality, _, _, _, _, _, _, icon, sellPrice = GetItemInfo(link)
	end
	if (not itemName) or (not quality) then
		-- Reskin turned off, not an item, or not cached yet: Blizzard's plain
		-- tooltip, including the sell price line held back for the footer.
		tooltip.DiabolicItemState = "plain"
		local heldBack = tooltip.DiabolicSellPrice
		if heldBack then
			tooltip.DiabolicSellPrice = nil
			self.AddMoney(tooltip, heldBack)
			tooltip:Show()
		end
		return
	end

	local name = tooltip:GetName()
	local titleIndex = 1
	local first = _G[name .. "TextLeft1"]
	if first and (first:GetText() == _G.CURRENTLY_EQUIPPED) then
		titleIndex = 2 -- comparison tooltips: "Currently Equipped" above the name
	end

	local r, g, b = GetItemQualityColor(quality)
	local info = {
		link = link,
		name = itemName,
		icon = icon,
		sellPrice = sellPrice,
		quality = quality,
		titleIndex = titleIndex,
		r = r, g = g, b = b
	}

	for i = titleIndex + 1, tooltip:NumLines() do
		local line = _G[name .. "TextLeft" .. i]
		local text = line and line:GetText()
		if text then
			local dps = string_match(text, DPS_PATTERN)
			local armor = (not dps) and string_match(text, ARMOR_PATTERN)
			if (dps or armor) and (not info.bigLine) then
				info.bigLine = i
				info.bigNumber = dps or armor
				info.bigLabel = dps and _G.ITEM_MOD_DAMAGE_PER_SECOND_SHORT or _G.ARMOR
				line:SetText(" ")
			elseif string_match(text, DURABILITY_PATTERN) then
				info.durability = text
				line:SetText("")
			end
		end
	end

	HighlightTagLines(tooltip, info)
	tooltip.DiabolicItemInfo = info
	tooltip.DiabolicItemState = "styled"
	tooltip:Show() -- Blizzard re-measures the edited lines, then Layout runs
end

-- Blizzard adds the "Sell Price:" line through the global
-- GameTooltip_OnTooltipAddMoney, which Auctionator also replaces (to hide
-- it when it shows its own vendor price). Chaining onto whatever is there
-- keeps both working: on an item tooltip in our style, the price goes to
-- the footer instead; everywhere else the line is added as before.
-- It can come before or after OnTooltipSetItem, so an early price is held
-- until that decides whether the tooltip gets our style.
local IS_STYLED_TOOLTIP = {}
for _, tooltipName in ipairs(TOOLTIPS) do
	IS_STYLED_TOOLTIP[tooltipName] = true
end

Module.OnTooltipAddMoney = function(self, tooltip, cost, maxcost)
	local state = tooltip.DiabolicItemState
	if maxcost or (state == "plain") or (not self.db.reskinTooltip) or (not IS_STYLED_TOOLTIP[tooltip:GetName() or ""]) then
		return self.AddMoney(tooltip, cost, maxcost)
	end
	tooltip.DiabolicSellPrice = cost
	if (state == "styled") then
		tooltip:Show() -- lay out again, now with the price
	end
end

-- A new tooltip starts over.
local OnTooltipCleared = function(tooltip)
	tooltip.DiabolicItemState = nil
	tooltip.DiabolicSellPrice = nil
	Reset(tooltip)
end

-- Blizzard puts comparison tooltips edge to edge; our backdrop reaches past
-- those edges, so they get pushed apart once Blizzard has placed them.
Module.SpaceComparisons = function(self, tooltip)
	tooltip = tooltip or _G.GameTooltip
	local gap = self.compareGap
	for _, compare in ipairs(tooltip.shoppingTooltips or {}) do
		if compare:IsShown() then
			local point, relativeTo, relativePoint, _, y = compare:GetPoint()
			if (point == "TOPLEFT") then
				compare:SetPoint(point, relativeTo, relativePoint, gap, y)
			elseif (point == "TOPRIGHT") then
				compare:SetPoint(point, relativeTo, relativePoint, -gap, y)
			end
		end
	end
end

Module.OnEnable = function(self)
	self.db = self:GetConfig("Tooltips") -- reskinTooltip, read on every tooltip so the option applies at once
	local offsets = self:GetDB("Tooltips").border.offsets
	self.compareGap = offsets[1] + offsets[2] + COMPARE_GAP
	hooksecurefunc("GameTooltip_ShowCompareItem", function(tooltip) self:SpaceComparisons(tooltip) end)

	self.AddMoney = _G.GameTooltip_OnTooltipAddMoney
	_G.GameTooltip_OnTooltipAddMoney = function(tooltip, cost, maxcost)
		return self:OnTooltipAddMoney(tooltip, cost, maxcost)
	end

	for _, tooltipName in ipairs(TOOLTIPS) do
		local tooltip = _G[tooltipName]
		if tooltip then
			tooltip:HookScript("OnTooltipSetItem", function(tooltip) self:OnTooltipSetItem(tooltip) end)
			tooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
			tooltip:HookScript("OnHide", OnTooltipCleared)
			tooltip:HookScript("OnUpdate", OnUpdate)
			hooksecurefunc(tooltip, "Show", Layout)
		end
	end
end

-- Exposed for tests/test_blizzard_itemtooltips.lua.
Module.ToPattern = ToPattern
