-- The Positions page of /dui config, a card for each: the UI scale with
-- Unlock Frames and Reset Positions; the tooltip on the cursor; the
-- minimap's screen anchor and size.
-- The pickers show what they pick: a tooltip with the cursor on it, a
-- screen with the minimap in its place.
local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage, EDGE, SLIDER_COLUMN, BUTTON_HEIGHT, ROW_GAP =
	C.NewPage, C.EDGE, C.SLIDER_COLUMN, C.BUTTON_HEIGHT, C.ROW_GAP
local SLIDER_BLOCK_HEIGHT, SLIDER_LABEL_HEIGHT, HEADER_GAP = C.SLIDER_BLOCK_HEIGHT, C.SLIDER_LABEL_HEIGHT, C.HEADER_GAP
local PICKER_HEIGHT, RADIO_OVERHANG, LABEL_HEIGHT = C.PICKER_HEIGHT, C.RADIO_OVERHANG, C.LABEL_HEIGHT
local CARD_PAD, CARD_WIDTH, CARD_TITLE_GAP = C.CARD_PAD, C.CARD_WIDTH, C.CARD_TITLE_GAP
local CreateButton, CreateValueSlider, CreateOffsetSlider = C.CreateButton, C.CreateValueSlider, C.CreateOffsetSlider
local CreateCard, CreateAnchorPointPicker, ANCHOR_POINTS = C.CreateCard, C.CreateAnchorPointPicker, C.ANCHOR_POINTS

local CARD_GAP = 8 -- between two cards
local CONTENT_TOP = -(CARD_PAD + LABEL_HEIGHT + CARD_TITLE_GAP) -- below a card's title
local PICKER_BLOCK_HEIGHT = PICKER_HEIGHT + RADIO_OVERHANG * 2
local WHITE = [[Interface\Buttons\WHITE8X8]]
local TEXTURES = ([[Interface\AddOns\%s\media\textures\]]):format(Addon)

-- The tooltip's preview: the cursor this many times its offsets away from
-- the picked point, at most this far
local TOOLTIP_PREVIEW_SCALE, TOOLTIP_PREVIEW_REACH = 0.2, 24
-- The minimap's: a round map this wide at 100%, in from the screen's edge
local MINIMAP_PREVIEW_SIZE, MINIMAP_PREVIEW_INSET, MINIMAP_PREVIEW_RIM = 24, 10, 2

-- The minimap snaps to a screen corner or edge (no center), this far in
local MINIMAP_POINTS = { "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }
local MINIMAP_OFFSETS = {
	TOPLEFT = { 30, -30 },
	TOP = { 0, -30 },
	TOPRIGHT = { -30, -30 },
	LEFT = { 30, 0 },
	RIGHT = { -30, 0 },
	BOTTOMLEFT = { 30, 30 },
	BOTTOM = { 0, 30 },
	BOTTOMRIGHT = { -30, 30 },
}

-- Which way a point's corner or edge lies from the center: -1, 0 or 1 across
-- and up.
local Direction = function(point)
	local x = point:find("LEFT") and -1 or point:find("RIGHT") and 1 or 0
	local y = point:find("TOP") and 1 or point:find("BOTTOM") and -1 or 0
	return x, y
end

-- A card across the page, `height` high, the next one down.
local PlaceCard = function(layout, card, height)
	card:SetHeight(height)
	layout:Place(card, EDGE - CARD_PAD, layout:Row(height, CARD_GAP))
end

-- A slider placed in a card by the top of its label.
local PlaceSlider = function(slider, card, x, top)
	slider:SetPoint("TOPLEFT", card, "TOPLEFT", x, top - SLIDER_LABEL_HEIGHT)
end

-- A picker placed in a card by the top left of its radios.
local PlacePicker = function(picker, card, top)
	picker:SetPoint("TOPLEFT", card, "TOPLEFT", CARD_PAD + RADIO_OVERHANG, top - RADIO_OVERHANG)
end

-- Fills a picker's box with a tooltip's lines: a name and two lines of text.
local DrawTooltipLines = function(box)
	for _, line in ipairs({ { 64, 5, -14, { 1, 0.82, 0 } }, { 84, 3, -24 }, { 70, 3, -58 } }) do
		local texture = box:CreateTexture(nil, "ARTWORK")
		texture:SetTexture(WHITE)
		texture:SetSize(line[1], line[2])
		texture:SetPoint("TOPLEFT", 14, line[3])
		local color = line[4] or { 0.6, 0.6, 0.6 }
		texture:SetVertexColor(color[1], color[2], color[3], 0.8)
	end
end

Module.CreatePositionsPage = function(self)
	local page, layout = NewPage("DiabolicUIOptionsPanelPositions", L["Positions"])
	layout:Row(0, HEADER_GAP - CARD_GAP)

	-- The UI scale, with Unlock Frames and Reset Positions beside it ----------

	-- the size of DiabolicUI's own frame ("ScreenScaling", also /dui setscale);
	-- applied out of combat (the frame is secure)
	local scaling = Engine:GetConfig("ScreenScaling")
	local frames = CreateCard(page, "Frames", CARD_WIDTH, L["Interface"])
	local buttonsHeight = BUTTON_HEIGHT * 2 + ROW_GAP
	PlaceCard(layout, frames, -CONTENT_TOP + buttonsHeight + CARD_PAD)
	local uiScale = CreateValueSlider(
		frames,
		"UIScale",
		L["UI Scale"],
		L["The size of DiabolicUI's bars, orbs and frames.|n|nAlso: /dui setscale 0.9"],
		50,
		150,
		function()
			return math.floor(scaling.scale * 100 + 0.5)
		end,
		function(value)
			scaling.scale = value / 100
			Engine:OnDisplaySizeEvent()
			self:ApplyUIScale()
		end
	)
	PlaceSlider(uiScale, frames, CARD_PAD, CONTENT_TOP - (buttonsHeight - SLIDER_BLOCK_HEIGHT) / 2)

	local unlockFrames = CreateButton(
		frames,
		"UnlockFrames",
		L["Unlock Frames"],
		L["Drag the minimap, chat, menu buttons, quest tracker and TrinketMenu. Right-drag the minimap to resize it.|n|nAlso: /dui move"],
		function(button)
			self:SetFramesUnlocked(not self:AreFramesUnlocked())
		end
	)
	-- what Unlock Frames moved, back in its place
	local resetPositions = CreateButton(
		frames,
		"ResetPositions",
		L["Reset Positions"],
		L["Puts the moved frames back in their places."],
		function(button)
			Engine:GetModule("ActionBars"):GetWidget("Controller: Menu"):ResetPosition()
			local chat = Engine:GetModule("ChatWindows")
			chat.db.autoposition = true
			chat:PositionChatFrames()
			Engine:GetModule("ObjectiveTracker"):ResetTrackerPosition()
		end
	)
	unlockFrames:SetPoint("TOPLEFT", frames, "TOPLEFT", CARD_PAD + SLIDER_COLUMN, CONTENT_TOP)
	resetPositions:SetPoint(
		"TOPLEFT",
		frames,
		"TOPLEFT",
		CARD_PAD + SLIDER_COLUMN,
		CONTENT_TOP - BUTTON_HEIGHT - ROW_GAP
	)
	self.UnlockFramesButton = unlockFrames

	-- The tooltip on the cursor -------------------------------------------------
	local tooltipsDB = Engine:GetConfig("Tooltips")
	local tooltip = CreateCard(
		page,
		"Tooltip",
		CARD_WIDTH,
		L["Tooltip Anchor"],
		L["The point of the tooltip that sits on your cursor."]
	)
	local slidersHeight = SLIDER_BLOCK_HEIGHT * 2 + ROW_GAP
	PlaceCard(layout, tooltip, -CONTENT_TOP + math.max(PICKER_BLOCK_HEIGHT, slidersHeight) + CARD_PAD)

	local tooltipPicker = CreateAnchorPointPicker(tooltip, "Anchor", ANCHOR_POINTS, function()
		return tooltipsDB.anchorPoint
	end, function(value)
		tooltipsDB.anchorPoint = value
	end)
	PlacePicker(tooltipPicker, tooltip, CONTENT_TOP - (slidersHeight - PICKER_BLOCK_HEIGHT) / 2)
	DrawTooltipLines(tooltipPicker)
	-- the cursor where it sits: the picked point, less the offsets
	local cursor = tooltipPicker:CreateTexture(nil, "OVERLAY")
	cursor:SetTexture([[Interface\Cursor\Point]])
	cursor:SetSize(20, 20)
	tooltipPicker.OnRefresh = function(box, point)
		local reach = function(offset)
			return math.max(-TOOLTIP_PREVIEW_REACH, math.min(TOOLTIP_PREVIEW_REACH, -offset * TOOLTIP_PREVIEW_SCALE))
		end
		cursor:ClearAllPoints()
		cursor:SetPoint("TOPLEFT", box, point or "BOTTOM", reach(tooltipsDB.offsetX), reach(tooltipsDB.offsetY))
	end

	-- its offset sliders stacked in the second column
	local offsetX = CreateOffsetSlider(
		tooltip,
		"TooltipOffsetX",
		L["Horizontal Offset"],
		L["At 0, the tooltip is centered horizontally on the cursor."],
		function()
			return tooltipsDB.offsetX
		end,
		function(value)
			tooltipsDB.offsetX = value
			tooltipPicker:Refresh()
		end
	)
	local offsetY = CreateOffsetSlider(
		tooltip,
		"TooltipOffsetY",
		L["Vertical Offset"],
		L["At 0, the cursor is at the bottom edge of the tooltip."],
		function()
			return tooltipsDB.offsetY
		end,
		function(value)
			tooltipsDB.offsetY = value
			tooltipPicker:Refresh()
		end
	)
	local slidersTop = CONTENT_TOP - math.max(0, PICKER_BLOCK_HEIGHT - slidersHeight) / 2
	PlaceSlider(offsetX, tooltip, CARD_PAD + SLIDER_COLUMN, slidersTop)
	PlaceSlider(offsetY, tooltip, CARD_PAD + SLIDER_COLUMN, slidersTop - SLIDER_BLOCK_HEIGHT - ROW_GAP)

	-- The minimap -----------------------------------------------------------------
	local minimapModule = Engine:GetModule("Minimap", true)
	local minimapPicker, minimapSize
	if minimapModule then
		local minimapDB = Engine:GetConfig("Minimap")
		local minimap = CreateCard(
			page,
			"Minimap",
			CARD_WIDTH,
			L["Minimap Anchor"],
			L["The screen corner or edge the minimap snaps to."]
		)
		PlaceCard(layout, minimap, -CONTENT_TOP + math.max(PICKER_BLOCK_HEIGHT, SLIDER_BLOCK_HEIGHT) + CARD_PAD)

		minimapPicker = CreateAnchorPointPicker(minimap, "MinimapAnchor", MINIMAP_POINTS, function()
			return (minimapModule:GetAnchor())
		end, function(point)
			local offset = MINIMAP_OFFSETS[point]
			minimapDB.position = { point = point, x = offset[1], y = offset[2] }
			minimapModule:UpdatePosition()
		end)
		PlacePicker(minimapPicker, minimap, CONTENT_TOP)
		-- the minimap in its place on the screen, as big as it's set
		local map = minimapPicker:CreateTexture(nil, "ARTWORK")
		map:SetTexture(TEXTURES .. "minimap-mask-opaque")
		map:SetVertexColor(0.2, 0.3, 0.25, 1)
		-- its rim, a bronze disc a little wider behind it (the border's own
		-- stone is too dark to show on the box)
		local ring = minimapPicker:CreateTexture(nil, "BORDER")
		ring:SetTexture(TEXTURES .. "minimap-mask-opaque")
		ring:SetVertexColor(0.62, 0.48, 0.25, 1)
		ring:SetPoint("CENTER", map, "CENTER")
		minimapPicker.OnRefresh = function(box, point)
			local size = MINIMAP_PREVIEW_SIZE * minimapDB.size
			map:SetSize(size, size)
			ring:SetSize(size + MINIMAP_PREVIEW_RIM * 2, size + MINIMAP_PREVIEW_RIM * 2)
			local x, y = Direction(point or "TOPRIGHT")
			map:ClearAllPoints()
			map:SetPoint(
				point or "TOPRIGHT",
				box,
				point or "TOPRIGHT",
				-x * MINIMAP_PREVIEW_INSET,
				-y * MINIMAP_PREVIEW_INSET
			)
		end

		local config = Engine:GetDB("Minimap")
		minimapSize = CreateValueSlider(
			minimap,
			"MinimapSize",
			L["Minimap Size"],
			L["Also: right-drag the minimap while frames are unlocked."],
			config.minSize * 100,
			config.maxSize * 100,
			function()
				return minimapDB.size * 100
			end,
			function(value)
				minimapModule:SetUserScale(value / 100)
				minimapPicker:Refresh()
			end
		)
		PlaceSlider(
			minimapSize,
			minimap,
			CARD_PAD + SLIDER_COLUMN,
			CONTENT_TOP - (PICKER_BLOCK_HEIGHT - SLIDER_BLOCK_HEIGHT) / 2
		)
	end

	-- the minimap's, kept live while the page is open (it can be dragged
	-- and resized at the same time); not over a number being typed
	local refreshMinimap = function()
		if minimapPicker then
			minimapPicker:Refresh()
			if not minimapSize.Input:HasFocus() then
				minimapSize:SetValueSilently(minimapModule:GetUserScale() * 100)
			end
		end
	end
	local elapsed = 0
	page:HookScript("OnUpdate", function(_, delta)
		elapsed = elapsed + delta
		if elapsed >= 0.2 then
			elapsed = 0
			refreshMinimap()
		end
	end)

	page.okay = function() end
	page.cancel = function()
		unlockFrames:SetText(self:AreFramesUnlocked() and L["Lock Frames"] or L["Unlock Frames"])
		uiScale:SetValueSilently(math.floor(scaling.scale * 100 + 0.5))
		offsetX:SetValueSilently(tooltipsDB.offsetX)
		offsetY:SetValueSilently(tooltipsDB.offsetY)
		tooltipPicker:Refresh()
		refreshMinimap()
	end
	page.refresh = page.cancel
	page.cancel()
	return page
end
