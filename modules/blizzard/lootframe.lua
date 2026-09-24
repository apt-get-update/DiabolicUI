-- Optional custom loot window ("LootFrame" settings, off by default).
local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: LootFrame")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")

-- Lua API
local math_max = math.max
local pairs = pairs
local select = select
local unpack = unpack

-- WoW API
local CloseLoot = CloseLoot
local CreateFrame = CreateFrame
local GetItemQualityColor = GetItemQualityColor
local GetLootSlotInfo = GetLootSlotInfo
local GetNumLootItems = GetNumLootItems
local LootSlot = LootSlot
local LootSlotIsCoin = LootSlotIsCoin

--[[
	Rather than re-skinning Blizzard's own live LootFrame (which this module
	used to do), this builds an entirely separate, self-owned loot window,
	the same way well-established addons like xLoot have long done it:

	- LootFrame's own LOOT_OPENED/LOOT_SLOT_CLEARED/LOOT_CLOSED handling is
	  unregistered on enable, and this module registers those same events on
	  itself instead - Blizzard's default window never opens at all while
	  this is active.
	- Its own frame and rows are built once and reused, growing on demand as
	  more rows are needed, never touching Blizzard's LootButtonN objects.
	- Rows are populated straight from GetLootSlotInfo() each update via the
	  same purpose-built API Blizzard's own code uses (SetItemButtonTexture/
	  SetItemButtonCount), not by reading back whatever a Blizzard widget
	  happened to already have shown.

	This sidesteps every recurring issue the re-skin approach kept hitting:
	warped icons from fighting a widget's existing multiple anchor points,
	rows getting clipped by an unknown parent scrollframe, guessing at
	frame levels, and an unreliable IsShown()/texture-timing race for
	knowing whether a row genuinely has an item in it - all of that was
	inherent to patching a live frame we don't fully control. Owning the
	frame outright removes the need for any of those workarounds.
--]]

-- Builds the standalone window itself: backdrop, title, close button.
-- Called once, the first time the feature is ever enabled.
Module.CreateWindow = function(self)
	local config = self.config

	local frame = CreateFrame("Frame", "DiabolicLootFrame", UIParent)
	frame:SetFrameStrata("DIALOG")
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetPoint(unpack(config.position))
	frame:SetBackdrop(config.backdrop)
	frame:SetBackdropColor(unpack(config.backdrop_color))
	frame:SetBackdropBorderColor(unpack(config.backdrop_border_color))
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:Hide()

	local title = frame:CreateFontString(nil, "OVERLAY")
	title:SetFontObject(config.title_font)
	title:SetPoint("TOP", config.title_offset[1], config.title_offset[2])
	title:SetText(L["Items"])

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", config.close_button_offset[1], config.close_button_offset[2])
	close:SetScript("OnClick", function() CloseLoot() end)

	self.frame = frame
	self.rows = {}
end

-- Builds a single row (icon + border + wide button background + name
-- text), grown on demand as more are needed - never shrunk back down,
-- just hidden and reused for the next loot with fewer items.
Module.CreateRow = function(self, index)
	local iconConfig = self.config.icon
	local rowConfig = self.config.row

	local button = CreateFrame("Button", "DiabolicLootButton"..index, self.frame, "LootButtonTemplate")
	button:SetHeight(iconConfig.size + iconConfig.icon_padding * 2)

	-- The template's own Normal/Highlight/Pushed textures are native Button
	-- art auto-shown by the engine on hover/click regardless of scripts -
	-- sized and positioned for the template's own tiny default button, so
	-- left alone they float oddly inside our much bigger custom row.
	button:SetNormalTexture("")
	button:SetHighlightTexture("")
	button:SetPushedTexture("")

	local icon = _G[button:GetName().."IconTexture"]
	icon:SetTexCoord(unpack(iconConfig.texcoords))
	icon:SetSize(iconConfig.size, iconConfig.size)
	icon:ClearAllPoints()
	icon:SetPoint("TOPLEFT", button, "TOPLEFT", iconConfig.icon_padding, -iconConfig.icon_padding)

	local border = button:CreateTexture(nil, "OVERLAY")
	border:SetTexture(iconConfig.border_texture)
	border:SetSize(unpack(iconConfig.border_size))
	border:SetPoint("TOPLEFT", icon, "TOPLEFT", iconConfig.border_offset[1], iconConfig.border_offset[2])

	local borderHighlight = button:CreateTexture(nil, "OVERLAY", nil, 1)
	borderHighlight:SetTexture(iconConfig.border_texture_highlight)
	borderHighlight:SetSize(unpack(iconConfig.border_size))
	borderHighlight:SetPoint("TOPLEFT", icon, "TOPLEFT", iconConfig.border_offset[1], iconConfig.border_offset[2])
	borderHighlight:Hide()

	-- The wide row background, behind the icon and text - our own texture
	-- on our own button, so (unlike the old re-skin) there's no clipping
	-- ancestor to worry about and no need to guess at frame levels.
	local normal = button:CreateTexture(nil, "BACKGROUND")
	normal:SetTexture(rowConfig.texture.normal)

	local highlight = button:CreateTexture(nil, "BACKGROUND", nil, 1)
	highlight:SetTexture(rowConfig.texture.highlight)
	highlight:Hide()

	local pushed = button:CreateTexture(nil, "BACKGROUND", nil, 2)
	pushed:SetTexture(rowConfig.texture.pushed)
	pushed:Hide()

	local text = _G[button:GetName().."Text"]
	text:SetFontObject(rowConfig.text_font)
	text:ClearAllPoints()
	text:SetPoint("LEFT", icon, "RIGHT", rowConfig.text_offset, 0)
	text:SetJustifyH("LEFT")

	-- The template also carries other decorative texture pieces we didn't
	-- ask for (e.g. a border sized around where its own tiny default text
	-- label used to sit) - hide any texture region that isn't one of ours,
	-- rather than trying to guess each one's name. FontStrings (the name/
	-- count text) are left alone; GetObjectType tells them apart.
	local ours = { [icon] = true, [border] = true, [borderHighlight] = true, [normal] = true, [highlight] = true, [pushed] = true }
	for i = 1, select("#", button:GetRegions()) do
		local region = select(i, button:GetRegions())
		if (region and (not ours[region]) and region.GetObjectType and (region:GetObjectType() == "Texture")) then
			region:SetTexture(nil)
			region:Hide()
		end
	end

	-- The template's own OnClick isn't relied on - it's replaced outright
	-- with the one WoW API call actually needed, so behavior doesn't
	-- depend on assumptions about what that template's default does.
	button:SetScript("OnClick", function(self)
		LootSlot(self:GetID())
	end)

	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetLootItem(self:GetID())
		highlight:Show(); normal:Hide()
		borderHighlight:Show(); border:Hide()
	end)

	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
		highlight:Hide(); normal:Show()
		borderHighlight:Hide(); border:Show()
	end)

	-- LootButtonTemplate's own XML also wires up an OnUpdate that keeps
	-- calling Blizzard's native LootItem_OnEnter for as long as the mouse
	-- stays over the button - which assumes it's a child of the real
	-- LootFrame (it reads LootFrame.page directly) and errors since that
	-- was never initialized for a button parented to our own window instead.
	button:SetScript("OnUpdate", nil)

	button.icon = icon
	button.text = text
	button.normal, button.highlight, button.pushed = normal, highlight, pushed

	self.rows[index] = button
	return button
end

-- Re-populates every row from the current loot table and resizes the
-- window to fit - the only place per-loot layout happens, called on every
-- relevant event rather than once at creation.
Module.Update = function(self)
	local config = self.config
	local iconConfig = config.icon
	local rowConfig = config.row
	local rowHeight = iconConfig.size + iconConfig.icon_padding * 2

	local shown = 0
	local maxTextWidth = 0

	for slot = 1, GetNumLootItems() do
		local texture, item, quantity, quality = GetLootSlotInfo(slot)
		if texture then
			shown = shown + 1
			local button = self.rows[shown] or self:CreateRow(shown)
			button:SetID(slot)

			SetItemButtonTexture(button, texture)
			SetItemButtonCount(button, quantity)

			button.text:SetText(item)
			if LootSlotIsCoin(slot) then
				button.text:SetTextColor(unpack(C.General.Title))
			else
				local r, g, b = GetItemQualityColor(quality or 1)
				button.text:SetTextColor(r, g, b)
			end

			maxTextWidth = math_max(maxTextWidth, button.text:GetStringWidth())
			button:Show()
		end
	end

	for i = shown + 1, #self.rows do
		self.rows[i]:Hide()
	end

	if (shown == 0) then
		return
	end

	local rowWidth = math_max(
		config.width - config.row_padding * 2,
		iconConfig.icon_padding + iconConfig.size + rowConfig.text_offset + maxTextWidth + rowConfig.text_padding
	)

	for i = 1, shown do
		local button = self.rows[i]
		button:SetWidth(rowWidth)
		button:ClearAllPoints()
		if (i == 1) then
			button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", config.row_padding, -config.top_padding)
		else
			button:SetPoint("TOPLEFT", self.rows[i - 1], "BOTTOMLEFT", 0, -rowConfig.gap)
		end

		-- The visible button art only fills part of its own canvas
		-- (rowConfig.size vs rowConfig.texture_size, symmetrically centered
		-- within it) - scale the whole canvas by the same ratio the row
		-- itself is being stretched by, so the visible art actually
		-- matches the row's real size instead of rendering undersized.
		local scaleX, scaleY = rowWidth / rowConfig.size[1], rowHeight / rowConfig.size[2]
		local canvasWidth, canvasHeight = rowConfig.texture_size[1] * scaleX, rowConfig.texture_size[2] * scaleY
		for _, texture in pairs({ button.normal, button.highlight, button.pushed }) do
			texture:ClearAllPoints()
			texture:SetSize(canvasWidth, canvasHeight)
			texture:SetPoint("CENTER", button, "CENTER")
		end
	end

	self.frame:SetWidth(rowWidth + config.row_padding * 2)
	self.frame:SetHeight(config.top_padding + (shown * rowHeight) + math_max(0, shown - 1) * rowConfig.gap + config.bottom_padding)
	self.frame:Show()
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").loot
	self.db = self:GetConfig("LootFrame") -- user setting: disabled by default
end

Module.OnEnable = function(self)
	-- Disabled by default - Blizzard's own loot window is left completely
	-- untouched unless the user has explicitly opted into the replacement.
	if (not self.db.enableSkin) then
		return
	end

	self:CreateWindow()

	-- Take these three events over entirely, the same way xLoot (and other
	-- long-established loot replacement addons) do it - Blizzard's own
	-- LootFrame never shows at all while this module is handling them.
	LootFrame:UnregisterEvent("LOOT_OPENED")
	LootFrame:UnregisterEvent("LOOT_SLOT_CLEARED")
	LootFrame:UnregisterEvent("LOOT_CLOSED")

	-- OnUpdate scripts run every frame regardless of Show/Hide state, so
	-- leaving Blizzard's own in place would keep doing whatever per-frame
	-- work it does for a frame that now never actually opens.
	LootFrame:SetScript("OnUpdate", nil)

	self:RegisterEvent("LOOT_OPENED", "Update")
	self:RegisterEvent("LOOT_SLOT_CLEARED", "Update")
	self:RegisterEvent("LOOT_CLOSED", "OnLootClosed")
end

Module.OnLootClosed = function(self)
	self.frame:Hide()
end
