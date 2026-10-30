-- The Quests page of /dui config: the quest tracker's fading.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- the controls (controls.lua)
local C = Module.Controls
local NewPage = C.NewPage
local CHECK_X, INDENT, SLIDER_COLUMN, CHECK_HEIGHT = C.CHECK_X, C.INDENT, C.SLIDER_COLUMN, C.CHECK_HEIGHT
local SLIDER_BLOCK_HEIGHT, HEADER_GAP, ROW_GAP, CreateHeader = C.SLIDER_BLOCK_HEIGHT, C.HEADER_GAP, C.ROW_GAP, C.CreateHeader
local CreateCheckbox, CreateValueSlider = C.CreateCheckbox, C.CreateValueSlider

-- The Quests page
Module.CreateQuestsPage = function(self)
	local objectivesDB = Engine:GetConfig("ObjectiveTracker")
	local questsPanel, layout = NewPage("DiabolicUIOptionsPanelQuests", L["Quests"])

	CreateHeader(questsPanel, layout, L["Objectives"])

	local updateTrackerSlidersEnabled -- assigned once the sliders exist

	local trackerGroup = layout:BeginGroup(HEADER_GAP)

	local fadeTracker = CreateCheckbox(trackerGroup, "FadeTracker", L["Fade Quest Tracker"], L["Fades the quest tracker out after it hasn't been moused over for a while, and shows it again as soon as you mouse over it.|n|nUses Questie's tracker when it's enabled, Blizzard's otherwise."], function(button)
		objectivesDB.fadeTracker = button:GetChecked() and true or false
		Engine:GetModule("ObjectiveTracker"):ApplyFadeSetting()
		updateTrackerSlidersEnabled()
	end)
	layout:Place(fadeTracker, CHECK_X, layout:Row(CHECK_HEIGHT))

	local trackerTimeFading = CreateValueSlider(trackerGroup, "ObjectivesTimeFading", L["Time Fading"], L["How many seconds the tracker stays fully visible before it starts fading, once you stop hovering it."],
		1, 30,
		function() return objectivesDB.fadeDelay end,
		function(value) objectivesDB.fadeDelay = value end)

	local trackerOpacity = CreateValueSlider(trackerGroup, "ObjectivesOpacity", L["Opacity"], L["How visible the tracker stays once it has fully faded, as a percentage."],
		0, 100,
		function() return objectivesDB.fadeOpacity end,
		function(value) objectivesDB.fadeOpacity = value end)

	local trackerSliders = layout:Row(SLIDER_BLOCK_HEIGHT, ROW_GAP)
	layout:PlaceSlider(trackerTimeFading, INDENT, trackerSliders)
	layout:PlaceSlider(trackerOpacity, INDENT + SLIDER_COLUMN, trackerSliders)

	layout:EndGroup(trackerGroup)

	-- Time Fading / Opacity only matter while the tracker fade is
	-- actually enabled, so grey them out and block input otherwise.
	updateTrackerSlidersEnabled = function()
		trackerTimeFading:SetEnabled(objectivesDB.fadeTracker)
		trackerOpacity:SetEnabled(objectivesDB.fadeTracker)
	end

	questsPanel.okay = function() end
	questsPanel.cancel = function()
		fadeTracker:SetChecked(objectivesDB.fadeTracker)
		trackerTimeFading:SetValueSilently(objectivesDB.fadeDelay)
		trackerOpacity:SetValueSilently(objectivesDB.fadeOpacity)
		updateTrackerSlidersEnabled()
	end
	questsPanel.refresh = questsPanel.cancel
	questsPanel.cancel()
	return questsPanel
end
