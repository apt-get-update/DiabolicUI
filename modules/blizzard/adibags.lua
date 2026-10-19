-- Gives AdiBags' bags (the backpack and the bank) Diablo III's look
-- (windows.lua) when it's loaded: each in the stone window in its iron
-- frame instead of AdiBags' backdrop, the windows' X in its socket, its
-- title in our font, its buttons ours, its equipped bags in a darker panel
-- over it, its slots the bags' (containers.lua: the quality border and
-- glow). Art and fonts only: AdiBags' code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: AdiBags", "LOW")

local kit

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded

-- A bag's frame (once): our window around it, its X, title, buttons and
-- equipped bags' panel ours.
Module.StyleContainer = function(self, frame)
	local config = self.config
	if frame.DiabolicWindow then
		return
	end
	frame:SetBackdrop(nil)
	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "smoke")
	frame.DiabolicWindow = window
	kit:StyleClose(frame.CloseButton, window)
	frame.Title:SetFontObject(config.title_font)
	frame.Title:SetTextColor(unpack(kit.config.band_title.color))
	-- over the window's iron, not on it
	local panel = frame.BagSlotPanel
	if panel then
		panel:ClearAllPoints()
		panel:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -config.insets[1], config.insets[2] + config.panel_gap)
		kit:StylePanel(panel)
		panel.Title:SetFontObject(config.title_font)
		panel.Title:SetTextColor(unpack(kit.config.band_title.color))
		panel:HookScript("OnShow", function() kit:StylePanel(panel) end)
	end
	-- its push buttons ours, each once (its modules add theirs as it
	-- shows: sorting, search)
	frame:HookScript("OnShow", function() kit:StyleButtons(frame) end)
	kit:StyleButtons(frame)
end

Module.StyleAdiBags = function(self)
	local AdiBags = _G.LibStub("AceAddon-3.0"):GetAddon("AdiBags", true)
	if not AdiBags then
		return
	end
	local slots = Engine:GetModule("Blizzard: Containers")
	-- AdiBags sets its backdrop again when its skin options change
	local container = AdiBags:GetClass("Container").prototype
	hooksecurefunc(container, "UpdateSkin", function(frame)
		if frame.DiabolicWindow then
			frame:SetBackdrop(nil)
		end
	end)
	hooksecurefunc(container, "OnShow", function(frame) self:StyleContainer(frame) end)
	-- the slots after AdiBags (and its modules) drew theirs
	hooksecurefunc(AdiBags:GetClass("ItemButton").prototype, "UpdateBorder", function(button)
		slots:StyleSlot(button, button.bag)
	end)
	for _, bag in AdiBags:IterateBags() do
		if bag:HasFrame() then
			self:StyleContainer(bag:GetFrame())
		end
	end
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "AdiBags") then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleAdiBags()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").adibags
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	if IsAddOnLoaded("AdiBags") then
		self:StyleAdiBags()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
