-- Gives Blizzard's quest log Diablo III's window (windows.lua): the stone
-- window in its iron frame, wider for room around its two panes, the title
-- in the plate over the red band, the quest count and the map's button in
-- a row under it, the quests in a darker panel, the selected one's details
-- written on Diablo III's parchment (dark ink), Abandon, Share and Track as our
-- buttons under the quests.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Quest Log", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local select = select
local unpack = unpack

-- WoW API
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local hooksecurefunc = _G.hooksecurefunc

-- the details' text, by its color: Blizzard's titles and the rest
local HEADERS = { "QuestInfoTitleHeader", "QuestInfoDescriptionHeader", "QuestInfoObjectivesHeader", "QuestInfoRewardsHeader" }
local TEXTS = {
	"QuestInfoDescriptionText", "QuestInfoObjectivesText", "QuestInfoGroupSize", "QuestInfoRewardText",
	"QuestInfoItemChooseText", "QuestInfoItemReceiveText", "QuestInfoSpellLearnText",
	"QuestInfoHonorFrameReceiveText", "QuestInfoArenaPointsFrameReceiveText",
	"QuestInfoTalentFrameReceiveText", "QuestInfoXPFrameReceiveText"
}

-- Named textures out of sight.
local Hide = function(...)
	for i = 1, select("#", ...) do
		local region = _G[(select(i, ...))]
		if region then
			region:SetAlpha(0)
		end
	end
end

local SetColor = function(names, color)
	for _, name in ipairs(names) do
		local text = _G[name]
		if text then
			text:SetTextColor(unpack(color))
		end
	end
end

-- The details' text dark on the parchment while the log shows them, and
-- Blizzard's own colors for its parchment elsewhere (the quest giver's
-- window draws them too, with the same text).
Module.ColorDetails = function(self, parent, material)
	local config = self.config
	if (parent == _G.QuestLogDetailScrollChildFrame) and _G.QuestLogFrame:IsShown() then
		SetColor(HEADERS, config.header_color)
		SetColor(TEXTS, config.text_color)
		for i = 1, _G.MAX_OBJECTIVES do
			local objective = _G["QuestInfoObjective" .. i]
			if objective and objective:IsShown() then
				local _, _, finished = GetQuestLogLeaderBoard(i)
				objective:SetTextColor(unpack(finished and config.done_color or config.text_color))
			end
		end
	elseif self.Colored then
		local text, title = _G.GetMaterialTextColors(material)
		SetColor(HEADERS, title)
		SetColor(TEXTS, text)
	end
	self.Colored = true
end

-- The count at the row's left (Blizzard moves it as the dailies show).
Module.PlaceCount = function(self)
	local count = _G.QuestLogCount
	if (count:GetParent() == _G.QuestLogFrame) then
		count:ClearAllPoints()
		count:SetPoint("LEFT", self.Window, "TOPLEFT", self.config.row_inset, self.config.row_y)
	end
end

-- The map's button at the row's right (Blizzard puts it back each time).
Module.PlaceMapButton = function(self)
	local button = _G.QuestLogFrameShowMapButton
	if (button:GetParent() == _G.QuestLogFrame) then
		button:ClearAllPoints()
		button:SetPoint("RIGHT", self.Window, "TOPRIGHT", -self.config.row_inset, self.config.row_y)
	end
end

-- The buttons under the quests (Blizzard puts them back each time).
Module.PlaceControls = function(self)
	local panel = _G.QuestLogControlPanel
	if (panel:GetParent() == _G.QuestLogFrame) then
		local config = self.config
		panel:ClearAllPoints()
		panel:SetPoint("BOTTOMLEFT", self.Window, "BOTTOMLEFT", unpack(config.controls))
		panel:SetWidth(config.controls_width)
	end
end

-- The details right of the quests (Blizzard moves them when they show).
Module.PlaceDetails = function(self)
	local scroll = _G.QuestLogDetailScrollFrame
	if (scroll:GetParent() == _G.QuestLogFrame) then
		scroll:ClearAllPoints()
		scroll:SetPoint("TOPRIGHT", self.Window, "TOPRIGHT", unpack(self.config.details))
		kit:PlaceParchmentBar(scroll)
	end
end

Module.StyleQuestLog = function(self)
	local config = self.config
	local frame = _G.QuestLogFrame

	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "emblem")
	self.Window = window
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + config.insets[3])
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:AddMedallion(self.Header, "grail")
	kit:SetTitle(self.Header, _G.QuestLogTitleText)
	kit:StyleClose(_G.QuestLogFrameCloseButton, window, self.Header)
	_G.QuestLogFrameCancelButton:SetAlpha(0) -- the window's X closes it
	_G.QuestLogFrameCancelButton:EnableMouse(false)

	-- the count and the map's button in a row under the band
	Hide("QuestLogCountTopRight", "QuestLogCountBottomRight", "QuestLogCountRight", "QuestLogCountTopLeft",
		"QuestLogCountBottomLeft", "QuestLogCountLeft", "QuestLogCountTopMiddle", "QuestLogCountMiddleMiddle",
		"QuestLogCountBottomMiddle")
	self:PlaceCount()
	hooksecurefunc("QuestLog_UpdateQuestCount", function() self:PlaceCount() end)
	self:PlaceMapButton()
	hooksecurefunc("QuestLogShowMapPOI_UpdatePosition", function() self:PlaceMapButton() end)

	-- the quests on the left, the details on the right, in panels
	local list = _G.QuestLogScrollFrame
	list:ClearAllPoints()
	list:SetPoint("TOPLEFT", window, "TOPLEFT", unpack(config.list))
	kit:AddPanel(list, config.list_panel_insets)
	local empty = _G.EmptyQuestLogFrame
	kit:HideTextures(empty)
	empty:ClearAllPoints()
	empty:SetAllPoints(list)
	self:PlaceDetails()
	hooksecurefunc("QuestLogDetailFrame_AttachToQuestLog", function() self:PlaceDetails() end)
	-- in the log, not the details' own window Blizzard keeps them in until it shows
	kit:AddPanel(_G.QuestLogDetailScrollFrame, kit.config.parchment_panel_insets, frame)
	kit:AddParchment(_G.QuestLogDetailScrollFrame) -- the scroll bar beside it
	Hide("QuestLogDetailScrollFrameScrollBackgroundTopLeft", "QuestLogDetailScrollFrameScrollBackgroundBottomRight")
	hooksecurefunc("QuestInfo_Display", function(_, parent, _, _, material) self:ColorDetails(parent, material) end)

	-- Abandon, Share and Track under the quests
	for _, button in ipairs({ _G.QuestLogFrameAbandonButton, _G.QuestLogFramePushQuestButton, _G.QuestLogFrameTrackButton }) do
		kit:StyleButton(button, config.button_height)
	end
	self:PlaceControls()
	hooksecurefunc("QuestLogControlPanel_UpdatePosition", function() self:PlaceControls() end)
	kit:StyleScrollBars(frame)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").questlog
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	self:StyleQuestLog()
end
