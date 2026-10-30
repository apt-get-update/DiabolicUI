-- The Action Bars page of /dui config: the gold and fps next to the menu
-- buttons.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local CHECK_X, CHECK_HEIGHT, HEADER_GAP, ROW_GAP = C.CHECK_X, C.CHECK_HEIGHT, C.HEADER_GAP, C.ROW_GAP
local CreateHeader, CreateCheckbox = C.CreateHeader, C.CreateCheckbox

-- The Action Bars page
Module.CreateActionBarsPage = function(self)
	local actionbarsDB = Engine:GetConfig("ActionBars", "character")
	local actionBarsPanel, layout = NewPage("DiabolicUIOptionsPanelActionBars", L["Action Bars"])

	CreateHeader(actionBarsPanel, layout, L["Menu"])

	local showGold = CreateCheckbox(actionBarsPanel, "ShowGold", L["Show Gold"], L["Shows how much money you're carrying, next to the menu button in the bottom right corner."], function(button)
		actionbarsDB.showGold = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdateGoldVisibility()
	end)
	layout:Place(showGold, CHECK_X, layout:Row(CHECK_HEIGHT, HEADER_GAP))

	local showPerformance = CreateCheckbox(actionBarsPanel, "ShowPerformance", L["Show FPS & Latency"], L["Shows your framerate and latency, next to the menu button in the bottom right corner."], function(button)
		actionbarsDB.showPerformance = button:GetChecked() and true or false
		Engine:GetModule("ActionBars"):GetWidget("Menu: Main"):UpdatePerformanceVisibility()
	end)
	layout:Place(showPerformance, CHECK_X, layout:Row(CHECK_HEIGHT, ROW_GAP))

	actionBarsPanel.okay = function() end
	actionBarsPanel.cancel = function()
		showGold:SetChecked(actionbarsDB.showGold)
		showPerformance:SetChecked(actionbarsDB.showPerformance)
	end
	actionBarsPanel.refresh = actionBarsPanel.cancel
	actionBarsPanel.cancel()
	return actionBarsPanel
end
