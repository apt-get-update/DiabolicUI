-- The main page of /dui config: what's where, the UI scale, Unlock Frames
-- and Reset Positions, and the chat commands.
local Addon, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Lua API
local math_floor = math.floor

-- WoW API
local CreateFrame = CreateFrame
local GetAddOnMetadata = GetAddOnMetadata

-- the controls (controls.lua)
local C = Module.Controls
local EDGE, SLIDER_COLUMN, TITLE_HEIGHT, LABEL_HEIGHT = C.EDGE, C.SLIDER_COLUMN, C.TITLE_HEIGHT, C.LABEL_HEIGHT
local BUTTON_HEIGHT, SLIDER_BLOCK_HEIGHT, INTRO_WIDTH, LOGO_HEIGHT = C.BUTTON_HEIGHT, C.SLIDER_BLOCK_HEIGHT, C.INTRO_WIDTH, C.LOGO_HEIGHT
local SECTION_GAP, HEADER_GAP, NewLayout, CreateTitle = C.SECTION_GAP, C.HEADER_GAP, C.NewLayout, C.CreateTitle
local CreateHeader, CreateButton, CreateValueSlider = C.CreateHeader, C.CreateButton, C.CreateValueSlider

-- The DiabolicUI page itself; the others go under it
Module.CreateMainPage = function(self)
	local panel = CreateFrame("Frame", "DiabolicUIOptionsPanel", InterfaceOptionsFramePanelContainer)
	panel.name = "DiabolicUI"
	panel:Hide()

	local layout = NewLayout(panel)
	CreateTitle(panel, layout, "DiabolicUI")

	local logo = panel:CreateTexture(nil, "ARTWORK")
	logo:SetSize(160, LOGO_HEIGHT)
	logo:SetPoint("TOPRIGHT", -EDGE, -EDGE)
	logo:SetTexture(([[Interface\AddOns\%s\media\textures\DiabolicUI_Logo.tga]]):format(Addon))

	-- what's where
	local intro = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	intro:SetJustifyH("LEFT")
	intro:SetWidth(INTRO_WIDTH)
	intro:SetText(L["A Diablo III style interface. Its settings are on the pages below this one."])
	layout:Place(intro, EDGE, layout:Row(LABEL_HEIGHT * 2, LOGO_HEIGHT - TITLE_HEIGHT + SECTION_GAP))

	-- the size of DiabolicUI's own frame ("ScreenScaling", also /dui setscale);
	-- applied out of combat (the frame is secure)
	local scaling = Engine:GetConfig("ScreenScaling")
	local uiScale = CreateValueSlider(panel, "UIScale", L["UI Scale"], L["The size of DiabolicUI's bars, orbs, frames and everything on them, as a percentage of the size made for your screen. WoW's own UI scale and other addons aren't changed.|n|nAlso: /dui setscale 0.9"],
		50, 150,
		function() return math_floor(scaling.scale * 100 + .5) end,
		function(value)
			scaling.scale = value / 100
			Engine:OnDisplaySizeEvent()
			self:ApplyUIScale()
		end)
	layout:PlaceSlider(uiScale, EDGE, layout:Row(SLIDER_BLOCK_HEIGHT, SECTION_GAP))

	local unlockFrames = CreateButton(panel, "UnlockFrames", L["Unlock Frames"], L["Highlights the frames you can move - the minimap, the chat, the menu buttons, the quest tracker (Blizzard's or Questie's) and TrinketMenu - to drag them around. Right-drag the minimap to resize it. A Lock Frames button locks them in their new places.|n|nAlso: /dui move"], function(button)
		self:SetFramesUnlocked(not self:AreFramesUnlocked())
	end)
	-- what Unlock Frames moved, back in its place
	local resetPositions = CreateButton(panel, "ResetPositions", L["Reset Positions"], L["Puts the menu buttons, the chat and Blizzard's quest tracker back in their places."], function(button)
		Engine:GetModule("ActionBars"):GetWidget("Controller: Menu"):ResetPosition()
		local chat = Engine:GetModule("ChatWindows")
		chat.db.autoposition = true
		chat:PositionChatFrames()
		Engine:GetModule("ObjectiveTracker"):ResetTrackerPosition()
	end)
	local moveRow = layout:Row(BUTTON_HEIGHT, SECTION_GAP)
	layout:Place(unlockFrames, EDGE, moveRow)
	layout:Place(resetPositions, EDGE + SLIDER_COLUMN, moveRow)
	self.UnlockFramesButton = unlockFrames

	CreateHeader(panel, layout, L["Chat Commands"])
	local commands = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	commands:SetJustifyH("LEFT")
	commands:SetWidth(INTRO_WIDTH)
	commands:SetText(L["/dui config - these options|n/dui move - unlocks the minimap, the chat, the menu buttons and the quest tracker to move them"])
	layout:Place(commands, EDGE, layout:Row(LABEL_HEIGHT * 3, HEADER_GAP))

	local version = panel:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
	version:SetPoint("BOTTOMRIGHT", -EDGE, EDGE)
	version:SetText(L["Version %s"]:format(GetAddOnMetadata(Addon, "Version") or "?"))

	panel.okay = function() end
	panel.cancel = function()
		unlockFrames:SetText(self:AreFramesUnlocked() and L["Lock Frames"] or L["Unlock Frames"])
		uiScale:SetValueSilently(math_floor(scaling.scale * 100 + .5))
	end
	panel.refresh = panel.cancel
	return panel
end
