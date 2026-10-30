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
local CreateFrame = _G.CreateFrame
local GetDailyQuestsCompleted = _G.GetDailyQuestsCompleted
local GetMaxDailyQuests = _G.GetMaxDailyQuests
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local GetQuestResetTime = _G.GetQuestResetTime
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

-- The quests' count in the title ("Quest Log 15/25"), Blizzard's box for
-- it out of sight in the log (shown in the details' own window, where
-- Blizzard moves it).
Module.UpdateCount = function(self, numQuests)
	local count = _G.QuestLogCount
	local inLog = (count:GetParent() == _G.QuestLogFrame)
	count:SetAlpha(inLog and 0 or 1)
	_G.QuestLogDailyQuestCountMouseOverFrame:EnableMouse(not inLog)
	if numQuests then
		_G.QuestLogTitleText:SetText(_G.QUEST_LOG .. "  " .. numQuests .. "/" .. _G.MAX_QUESTLOG_QUESTS)
	end
end

-- The title's tooltip: the dailies done today, when they reset.
Module.AddCountTooltip = function(self)
	local title = _G.QuestLogTitleText
	local hover = CreateFrame("Frame", nil, title:GetParent())
	hover:SetAllPoints(title)
	hover:EnableMouse(true)
	hover:SetScript("OnEnter", function()
		local tooltip = _G.GameTooltip
		tooltip:SetOwner(hover, "ANCHOR_BOTTOM")
		tooltip:SetText(_G.QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests()))
		tooltip:AddLine(_G.QUEST_LOG_DAILY_TOOLTIP:format(GetMaxDailyQuests(), _G.SecondsToTime(GetQuestResetTime(), nil, 1)), 1, 1, 1, true)
		tooltip:Show()
	end)
	hover:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
end

-- The map's button in the foot, at its right (Blizzard puts it back each
-- time), over the foot's stone as the buttons left of it.
Module.PlaceMapButton = function(self)
	local button = _G.QuestLogFrameShowMapButton
	if (button:GetParent() == _G.QuestLogFrame) then
		button:ClearAllPoints()
		button:SetPoint("RIGHT", self.Window, "BOTTOMRIGHT", unpack(self.config.map_button))
		button:SetFrameLevel(_G.QuestLogFrameAbandonButton:GetFrameLevel())
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
		scroll:SetHeight(self.config.details_height)
		kit:PlaceParchmentBar(scroll)
	end
end

Module.StyleQuestLog = function(self)
	local config = self.config
	local frame = _G.QuestLogFrame

	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "cliffs")
	kit:AddFooter(window, config.footer)
	self.Window = window
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + config.insets[3])
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(self.Header, _G.QuestLogTitleText)
	kit:StyleClose(_G.QuestLogFrameCloseButton, window, self.Header)
	kit:DropBand(self.Header) -- (nothing in it: the quests up in its place)
	_G.QuestLogFrameCancelButton:SetAlpha(0) -- the window's X closes it
	_G.QuestLogFrameCancelButton:EnableMouse(false)

	-- the quests' count in the title, the dailies' in its tooltip; the
	-- map's button in the foot
	self:AddCountTooltip()
	hooksecurefunc("QuestLog_UpdateQuestCount", function(numQuests) self:UpdateCount(numQuests) end)
	self:UpdateCount()
	self:PlaceMapButton()
	hooksecurefunc("QuestLogShowMapPOI_UpdatePosition", function() self:PlaceMapButton() end)

	-- the quests on the left on slate, the details on the right on parchment
	local list = _G.QuestLogScrollFrame
	list:ClearAllPoints()
	list:SetPoint("TOPLEFT", window, "TOPLEFT", unpack(config.list))
	list:SetHeight(config.list_height)
	kit:AddZone(list, "slate", config.list_panel_insets, list) -- (in the list: over the painting, under its rows)
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
	-- the chosen quest on the copper bar, from inside the slate's edge out
	-- to the scroll bar (Blizzard's row starts on the edge, stops short of it)
	local highlight = _G.QuestLogSkillHighlight
	kit:LightRow(highlight)
	highlight:ClearAllPoints()
	highlight:SetPoint("TOPLEFT", _G.QuestLogHighlightFrame, "TOPLEFT", config.highlight_left, 0)
	highlight:SetPoint("BOTTOMRIGHT", _G.QuestLogHighlightFrame, "BOTTOMRIGHT", config.highlight_reach, 0)

	-- Abandon, Share and Track under the quests
	local abandon, share, track = _G.QuestLogFrameAbandonButton, _G.QuestLogFramePushQuestButton, _G.QuestLogFrameTrackButton
	for _, button in ipairs({ abandon, share, track }) do
		kit:StyleButton(button, config.button_height)
	end
	-- apart (Blizzard's touch: Share stretched between the other two)
	local gap = kit.config.layout.button_gap
	share:ClearAllPoints()
	share:SetPoint("LEFT", abandon, "RIGHT", gap, 0)
	share:SetPoint("RIGHT", track, "LEFT", -gap, 0)
	self:PlaceControls()
	hooksecurefunc("QuestLogControlPanel_UpdatePosition", function() self:PlaceControls() end)
	kit:StyleScrollBars(frame)
	kit:StyleScrollBar(_G.QuestLogDetailScrollFrameScrollBar) -- (the details' window's until it shows)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").questlog
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	self:StyleQuestLog()
end
