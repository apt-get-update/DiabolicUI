-- Gives the Group Bulletin Board addon's window Diablo III's (windows.lua):
-- the stone window in its iron frame instead of its dark square, its title
-- in the plate over the red band, its close and settings buttons in the
-- band, the requests on slate, its buttons ours. The window grows
-- around its frame, which it sizes and places itself.
-- Art, fonts and places only: the addon's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Bulletin Board", "LOW")

local kit

-- Lua API
local _G = _G

-- WoW API
local IsAddOnLoaded = _G.IsAddOnLoaded

local ADDON = "GroupBulletinBoard"

Module.StyleBoard = function(self)
	local config = self.config
	local frame = _G.GroupBulletinBoardFrame
	kit:HideTextures(frame) -- its dark square and its icon
	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "cracked")
	local header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(header, _G.GroupBulletinBoardFrameTitle)
	local close = _G.GroupBulletinBoardFrameCloseButton
	kit:StyleClose(close, window, header)
	local settings = _G.GroupBulletinBoardFrameSettingsButton
	if settings then
		settings:SetFrameLevel(close:GetFrameLevel())
		settings:ClearAllPoints()
		settings:SetPoint("RIGHT", close, "LEFT", -config.button_gap, 0)
	end
	kit:AddZone(_G.GroupBulletinBoardFrame_ScrollFrame, "slate", config.list_panel_insets)
	kit:StyleButtons(frame)
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == ADDON) then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleBoard()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").bulletin_board
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	if IsAddOnLoaded(ADDON) and _G.GroupBulletinBoardFrame then
		self:StyleBoard()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
