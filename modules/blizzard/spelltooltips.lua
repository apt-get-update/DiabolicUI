-- Diablo III style ability tooltips, in the look of the item tooltips
-- (itemtooltips.lua): the spell's name in Exocet on a dark title banner,
-- its rank at the banner's right, the icon in a box on the left with the
-- rest of the tooltip beside it, the numbers of the cost, range, cast time
-- and cooldown lines in green, and a gap before the description.
--
-- Styles the tooltips filled by SetAction (spells and macros on action
-- bars), SetSpell (spellbook), SetTalent, SetShapeshift and spell links,
-- right after Blizzard fills them; auras and items are left alone.
local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: SpellTooltips")
local Shared = Engine:GetModule("Blizzard: ItemTooltips").Shared

-- Same incompatibilities as the tooltip styling itself
Module:SetIncompatible("TipTac")
Module:SetIncompatible("TinyTip")
Module:SetIncompatible("TinyTooltip")

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local select = select
local tonumber = tonumber
local unpack = unpack
local math_abs = math.abs
local math_max = math.max
local string_find = string.find
local string_gsub = string.gsub
local string_match = string.match
local xpcall = xpcall

-- WoW API
local GetActionTexture = _G.GetActionTexture
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local GetSpellInfo = _G.GetSpellInfo
local GetSpellTexture = _G.GetSpellTexture
local GetTalentInfo = _G.GetTalentInfo
local geterrorhandler = _G.geterrorhandler
local hooksecurefunc = _G.hooksecurefunc

local CreateBox, PlaceBox = Shared.CreateBox, Shared.PlaceBox
local CreateHeader, PlaceHeader = Shared.CreateHeader, Shared.PlaceHeader
local OffsetFromTop, IsDefaultColor = Shared.OffsetFromTop, Shared.IsDefaultColor
local PADDING, ICON_BOX, ICON_SIZE = Shared.PADDING, Shared.ICON_BOX, Shared.ICON_SIZE
local SHIFT, TITLE_GAP, BANNER_PAD = Shared.SHIFT, Shared.TITLE_GAP, Shared.BANNER_PAD

-- Tooltips that show spells
local TOOLTIPS = { "GameTooltip", "ItemRefTooltip" }

local DESCRIPTION_GAP = 8 -- the blank space before the description
local NUMBER_COLOR = "|cff3fc83f" -- Diablo III's green values
local TITLE_COLOR = { 1, 1, 1 }
local RANK_COLOR = { .6, .6, .6 }
local BANNER_COLOR = { .05, .05, .05 }

-- The icon of what the tooltip was filled with, by the method that filled it.
-- Nothing means that tooltip isn't an ability.
local ICONS = {
	SetAction = function(tooltip, slot)
		if (not tooltip:GetItem()) and tooltip:GetSpell() then
			return GetActionTexture(slot)
		end
	end,
	SetSpell = function(tooltip, id, bookType)
		return GetSpellTexture(id, bookType)
	end,
	SetTalent = function(tooltip, ...)
		return (select(2, GetTalentInfo(...)))
	end,
	SetShapeshift = function(tooltip, index)
		return (GetShapeshiftFormInfo(index))
	end,
	SetHyperlink = function(tooltip, link)
		local id = string_match(link or "", "spell:(%d+)")
		return id and (select(3, GetSpellInfo(tonumber(id))))
	end
}

-- Blizzard's spell descriptions are in its gold (NORMAL_FONT_COLOR).
local IsDescriptionColor = function(line)
	local r, g, b = line:GetTextColor()
	return (r > .99) and (g > .8) and (g < .84) and (b < .01)
end

-- The per-tooltip widgets, created on first use.
local GetParts = function(tooltip)
	local parts = tooltip.DiabolicSpellParts
	if parts then
		return parts
	end
	parts = {}

	parts.header = CreateHeader(tooltip)
	parts.title = parts.header:CreateFontString(nil, "OVERLAY")
	parts.title:SetFontObject(DiabolicFont_HeaderRegular16)
	parts.title:SetTextColor(TITLE_COLOR[1], TITLE_COLOR[2], TITLE_COLOR[3])
	parts.title:SetPoint("CENTER", parts.header, "CENTER", 0, 0)
	parts.rank = parts.header:CreateFontString(nil, "OVERLAY")
	parts.rank:SetFontObject(DiabolicFont_SansRegular12)
	parts.rank:SetTextColor(RANK_COLOR[1], RANK_COLOR[2], RANK_COLOR[3])
	parts.rank:SetPoint("RIGHT", parts.header, "RIGHT", -PADDING, 0)

	parts.iconBox = tooltip:CreateTexture(nil, "BACKGROUND")
	parts.iconBox:SetTexture(1, 1, 1)
	parts.iconBox:SetSize(ICON_BOX, ICON_BOX)

	parts.icon = tooltip:CreateTexture(nil, "BORDER")
	parts.icon:SetTexCoord(5/64, 59/64, 5/64, 59/64)
	parts.icon:SetPoint("CENTER", parts.iconBox, "CENTER", 0, 0)
	parts.icon:SetSize(ICON_SIZE, ICON_SIZE)

	parts.iconBorder = tooltip:CreateTexture(nil, "ARTWORK")
	parts.iconBorder:SetTexture(Shared.ICON_FRAME)
	parts.iconBorder:SetPoint("CENTER", parts.iconBox, "CENTER", 0, 0)
	parts.iconBorder:SetSize(ICON_BOX * Shared.ICON_ART_SCALE, ICON_BOX * Shared.ICON_ART_SCALE)

	parts.contentBox = CreateBox(tooltip)

	parts.all = { parts.header, parts.iconBox, parts.icon, parts.iconBorder }
	for _, region in ipairs(parts.contentBox.regions) do
		parts.all[#parts.all + 1] = region
	end
	tooltip.DiabolicSpellParts = parts
	return parts
end

-- Undoes the layout: the tooltip goes back to Blizzard's.
local Reset = function(tooltip)
	local info = tooltip.DiabolicSpellInfo
	tooltip.DiabolicSpellInfo = nil
	local parts = tooltip.DiabolicSpellParts
	if parts then
		for _, region in ipairs(parts.all) do
			region:Hide()
		end
	end
	if info then
		local name = tooltip:GetName()
		local title = _G[name .. "TextLeft1"]
		title:SetAlpha(1)
		_G[name .. "TextRight1"]:SetAlpha(1)
		local nextLine = _G[name .. "TextLeft2"]
		if nextLine then
			nextLine:ClearAllPoints()
			nextLine:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
		end
		if info.descLine then
			local desc = _G[name .. "TextLeft" .. info.descLine]
			desc:ClearAllPoints()
			desc:SetPoint("TOPLEFT", _G[name .. "TextLeft" .. (info.descLine - 1)], "BOTTOMLEFT", 0, -2)
		end
	end
end

-- Runs after Blizzard has sized the tooltip: arranges our parts around its
-- lines, then grows it to fit.
local Layout = function(tooltip)
	local info = tooltip.DiabolicSpellInfo
	if (not info) then
		return
	end
	local name = tooltip:GetName()
	local titleLine = _G[name .. "TextLeft1"]
	if (titleLine:GetText() ~= info.name) then
		return Reset(tooltip) -- something else was put in the tooltip
	end
	local parts = GetParts(tooltip)

	-- Body text moves right, next to the icon, the description down.
	titleLine:SetAlpha(0)
	_G[name .. "TextRight1"]:SetAlpha(0)
	if (tooltip:NumLines() > 1) then
		local nextLine = _G[name .. "TextLeft2"]
		nextLine:ClearAllPoints()
		nextLine:SetPoint("TOPLEFT", titleLine, "BOTTOMLEFT", SHIFT, -(BANNER_PAD + TITLE_GAP))
	end
	if info.descLine then
		local desc = _G[name .. "TextLeft" .. info.descLine]
		desc:ClearAllPoints()
		desc:SetPoint("TOPLEFT", _G[name .. "TextLeft" .. (info.descLine - 1)], "BOTTOMLEFT", 0, -(2 + DESCRIPTION_GAP))
	end

	local titleBottom = OffsetFromTop(tooltip, titleLine, "BOTTOM")
	if (not titleBottom) then
		return -- not placed on screen yet; CheckLayout retries next frame
	end

	-- Title banner, with the rank at its right
	local bannerBottom = titleBottom - BANNER_PAD
	PlaceHeader(parts.header, tooltip, -1, bannerBottom, BANNER_COLOR[1], BANNER_COLOR[2], BANNER_COLOR[3])
	parts.title:SetText(info.name)
	parts.rank:SetText(info.rank or "")

	-- Icon box
	parts.iconBox:ClearAllPoints()
	parts.iconBox:SetPoint("TOPLEFT", tooltip, "TOPLEFT", PADDING, bannerBottom - TITLE_GAP)
	parts.iconBox:SetGradientAlpha("VERTICAL", .05, .05, .05, 1, .25, .25, .25, 1)
	parts.icon:SetTexture(info.icon)

	-- Size: wider by the icon shift, tall enough for the icon. Start from
	-- Blizzard's own measurement; when the tooltip still has the size set
	-- here last time, that's the one measured back then.
	local baseWidth, baseHeight = tooltip:GetWidth(), tooltip:GetHeight()
	if info.width and (math_abs(baseWidth - info.width) < .5) and (math_abs(baseHeight - info.height) < .5) then
		baseWidth, baseHeight = info.baseWidth, info.baseHeight
	end
	info.baseWidth, info.baseHeight = baseWidth, baseHeight
	-- the name stays centered, clear of the rank on either side
	local titleWidth = parts.title:GetStringWidth() + (info.rank and (parts.rank:GetStringWidth() + PADDING) * 2 or 0)
	local width = math_max(baseWidth + SHIFT, titleWidth + PADDING * 4)
	local height = baseHeight + (BANNER_PAD + TITLE_GAP - 2) + (info.descLine and DESCRIPTION_GAP or 0)
	height = math_max(height, -bannerBottom + TITLE_GAP + ICON_BOX + PADDING)
	tooltip:SetWidth(width)
	tooltip:SetHeight(height)
	info.width, info.height = width, height

	PlaceBox(parts.contentBox, tooltip, "TOPLEFT", bannerBottom - Shared.CONTENT_TOP_GAP, Shared.BOTTOM_Y)

	for _, region in ipairs(parts.all) do
		region:Show()
	end
end

-- A line added on its own re-measures the tooltip (dropping the extra room
-- made above): lay out again then, or for the first time if the tooltip
-- wasn't on screen yet when it was shown. (Only for an ability's tooltip.)
local CheckLayout = function(tooltip)
	local info = tooltip.DiabolicSpellInfo
	if (not info.width) or (math_abs(tooltip:GetWidth() - info.width) > .5) or (math_abs(tooltip:GetHeight() - info.height) > .5) then
		return Layout(tooltip)
	end
end

-- The numbers of a stat line in green. Lines Blizzard colored (a red
-- "Requires ...") or that already carry colors are left alone.
local ColorNumbers = function(info, line)
	local text = line and line:IsShown() and line:GetText()
	if text and (not string_find(text, "|c", 1, true)) and IsDefaultColor(line) then
		local colored, count = string_gsub(text, "(%d[%d%.,]*)", NUMBER_COLOR .. "%1|r")
		if (count > 0) then
			info.texts[line] = text
			line:SetText(colored)
		end
	end
end

-- Reads the ability from the tooltip Blizzard just filled, and colors its
-- stat lines.
Module.Style = function(self, tooltip, icon)
	Reset(tooltip)
	if (not self.db.reskinTooltip) or (not icon) then
		return
	end
	local name = tooltip:GetName()
	local title = _G[name .. "TextLeft1"]:GetText()
	if (not title) or (title == "") or self.failed[title] then
		return
	end
	local rankLine = _G[name .. "TextRight1"]
	local rank = rankLine:IsShown() and rankLine:GetText()
	local info = {
		name = title,
		rank = (rank and (rank ~= "")) and rank or nil,
		icon = icon,
		texts = {} -- fontstring -> text before the numbers were colored
	}
	tooltip.DiabolicSpellInfo = info -- already, so Unstyle can undo a partial edit

	-- Stat lines run from the second line to the description.
	local numLines = tooltip:NumLines()
	local last = numLines
	for i = 2, numLines do
		if IsDescriptionColor(_G[name .. "TextLeft" .. i]) then
			last = i - 1
			if (i > 2) then
				info.descLine = i
			end
			break
		end
	end
	for i = 2, last do
		ColorNumbers(info, _G[name .. "TextLeft" .. i])
		ColorNumbers(info, _G[name .. "TextRight" .. i])
	end

	tooltip:Show() -- Blizzard re-measures the edited lines, then Layout runs
end

-- Puts back Blizzard's plain tooltip.
Module.Unstyle = function(self, tooltip)
	local info = tooltip.DiabolicSpellInfo
	if info then
		for line, text in pairs(info.texts) do
			line:SetText(text)
		end
		self.failed[info.name] = true
	end
	Reset(tooltip)
	tooltip:Show()
end

-- Runs one of the steps above. Should it error, the error is reported once
-- and the ability stays in Blizzard's plain style for the rest of the
-- session, rather than erroring again on every frame the tooltip is shown.
local guardedStep, guardedArgs
local RunGuardedStep = function()
	return guardedStep(unpack(guardedArgs, 1, guardedArgs.n))
end
local ReportError = function(err)
	return geterrorhandler()(err)
end

Module.Guard = function(self, tooltip, step, ...)
	guardedStep, guardedArgs = step, { n = select("#", ...) + 1, tooltip, ... }
	if (not xpcall(RunGuardedStep, ReportError)) then
		self:Unstyle(tooltip)
	end
end

Module.OnEnable = function(self)
	self.db = self:GetConfig("Tooltips") -- reskinTooltip, read on every tooltip so the option applies at once
	self.failed = {} -- names whose layout errored: shown plain from then on

	local style = function(tooltip, getIcon, ...) return self:Style(tooltip, getIcon(tooltip, ...)) end
	local onShow = function(tooltip) self:Guard(tooltip, Layout) end
	local onUpdate = function(tooltip)
		if tooltip.DiabolicSpellInfo then
			self:Guard(tooltip, CheckLayout)
		end
	end

	for _, tooltipName in ipairs(TOOLTIPS) do
		local tooltip = _G[tooltipName]
		if tooltip then
			for method, getIcon in pairs(ICONS) do
				hooksecurefunc(tooltip, method, function(tooltip, ...)
					self:Guard(tooltip, style, getIcon, ...)
				end)
			end
			tooltip:HookScript("OnTooltipCleared", Reset)
			tooltip:HookScript("OnHide", Reset)
			hooksecurefunc(tooltip, "Show", onShow)
			-- ItemRefTooltip (chat links) replaces its OnUpdate script on
			-- enter, leave and hide, which drops hooks: hook it again each time.
			tooltip:HookScript("OnUpdate", onUpdate)
			hooksecurefunc(tooltip, "SetScript", function(tooltip, script)
				if (script == "OnUpdate") then
					tooltip:HookScript("OnUpdate", onUpdate)
				end
			end)
		end
	end
end

-- Exposed for tests/test_blizzard_spelltooltips.lua.
Module.Layout = Layout
Module.CheckLayout = CheckLayout
Module.ICONS = ICONS
