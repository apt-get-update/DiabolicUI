-- The Tooltips page of /dui config: the Diablo III item tooltips, and where
-- the tooltip sits on the cursor.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local EDGE, CHECK_X, SLIDER_COLUMN, CHECK_HEIGHT = C.EDGE, C.CHECK_X, C.SLIDER_COLUMN, C.CHECK_HEIGHT
local SLIDER_BLOCK_HEIGHT, PICKER_HEIGHT, SECTION_GAP, HEADER_GAP = C.SLIDER_BLOCK_HEIGHT, C.PICKER_HEIGHT, C.SECTION_GAP, C.HEADER_GAP
local ROW_GAP, CreateFieldLabel, CreateCheckbox, CreateOffsetSlider = C.ROW_GAP, C.CreateFieldLabel, C.CreateCheckbox, C.CreateOffsetSlider
local CreateAnchorPointPicker = C.CreateAnchorPointPicker

-- The Tooltips page
Module.CreateTooltipsPage = function(self)
	local tooltipsDB = Engine:GetConfig("Tooltips")
	local tooltipsPanel, layout = NewPage("DiabolicUIOptionsPanelTooltips", L["Tooltips"])

	local reskinTooltip = CreateCheckbox(tooltipsPanel, "ReskinTooltip", L["Reskin Tooltip"], L["Shows item tooltips in the Diablo III style: the item's name on a title banner in its quality color, its icon on the left, damage per second or armor as a big number, and the sell price and durability at the bottom.|n|nWhen disabled, Blizzard's own item tooltips are used."], function(button)
		tooltipsDB.reskinTooltip = button:GetChecked() and true or false
	end)
	layout:Place(reskinTooltip, CHECK_X, layout:Row(CHECK_HEIGHT, SECTION_GAP))

	CreateFieldLabel(tooltipsPanel, layout, L["Tooltip mouse anchor"], L["Which point of the tooltip gets anchored to your cursor, so you can pick the corner or edge that overlaps your mouse the least."], SECTION_GAP)

	-- The picker on the left, its offset sliders stacked in the second column.
	local offsetX = CreateOffsetSlider(tooltipsPanel, "TooltipOffsetX", L["Horizontal Offset"], L["At 0, the tooltip is centered horizontally on the cursor."],
		function() return tooltipsDB.offsetX end,
		function(value) tooltipsDB.offsetX = value end)

	local offsetY = CreateOffsetSlider(tooltipsPanel, "TooltipOffsetY", L["Vertical Offset"], L["At 0, the cursor is at the bottom edge of the tooltip."],
		function() return tooltipsDB.offsetY end,
		function(value) tooltipsDB.offsetY = value end)

	local pickerRow = layout:Row(math.max(PICKER_HEIGHT, SLIDER_BLOCK_HEIGHT * 2 + ROW_GAP), HEADER_GAP)
	local _, refreshAnchorPoint = CreateAnchorPointPicker(tooltipsPanel, layout, pickerRow,
		function() return tooltipsDB.anchorPoint end,
		function(value) tooltipsDB.anchorPoint = value end)
	layout:PlaceSlider(offsetX, EDGE + SLIDER_COLUMN, pickerRow)
	layout:PlaceSlider(offsetY, EDGE + SLIDER_COLUMN, pickerRow - SLIDER_BLOCK_HEIGHT - ROW_GAP)

	tooltipsPanel.okay = function() end
	tooltipsPanel.cancel = function()
		reskinTooltip:SetChecked(tooltipsDB.reskinTooltip)
		offsetX:SetValueSilently(tooltipsDB.offsetX)
		offsetY:SetValueSilently(tooltipsDB.offsetY)
		refreshAnchorPoint()
	end
	tooltipsPanel.refresh = tooltipsPanel.cancel
	tooltipsPanel.cancel()
	return tooltipsPanel
end
