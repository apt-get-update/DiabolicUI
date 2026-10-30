-- /dui config: the options pages under DiabolicUI in the AddOns tab (one
-- page-*.lua each, their controls in controls.lua), Unlock Frames
-- (movers.lua), and the UI scale beyond DiabolicUI's own frame.
local _, Engine = ...
local Module = Engine:NewModule("Menu")

-- Lua API
local ipairs = ipairs

-- WoW API
local InCombatLockdown = InCombatLockdown
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory

-- Pages
-------------------------------------------------------
Module.CreateOptionsPanel = function(self)
	local panel = self:CreateMainPage()
	InterfaceOptions_AddCategory(panel)

	-- the pages, from the main frames to the extras (the minimap's goes
	-- before Quests, modules/minimap/Components/Menu/Menu.lua)
	for _, page in ipairs({ self:CreateActionBarsPage(), self:CreateSpecsPage(), self:CreateUnitsPage(), self:CreateChatPage(),
		self:CreateMessagesPage(), self:CreateQuestsPage(), self:CreateTooltipsPage(), self:CreateAddOnsPage() }) do
		InterfaceOptions_AddCategory(page)
	end

	self.OptionsPanel = panel

	self:GetHandler("ChatCommand"):Register("config", function()
		InterfaceOptionsFrame_OpenToCategory(panel)
		InterfaceOptionsFrame_OpenToCategory(panel) -- needs to be called twice to work around a blizzard bug
	end)
end

-- The UI Scale, beyond DiabolicUI's own frame: the minimap (its size
-- multiplies it, modules/minimap), Questie's tracker (Questie leaves its
-- scale alone) and TrinketMenu's windows (on top of TrinketMenu's own
-- scales, which it keeps setting and saving: its frames' SetScale and
-- GetScale go through these). Out of combat: they hold secure buttons.
-------------------------------------------------------
local GetUIScale = function()
	return Engine:GetConfig("ScreenScaling").scale or 1
end

local ScaleWithUI = function(frame)
	if frame.DiabolicOwnScale then
		return
	end
	local SetScale, GetScale = frame.SetScale, frame.GetScale
	frame.DiabolicOwnScale = GetScale(frame)
	frame.SetScale = function(self, scale)
		self.DiabolicOwnScale = scale
		SetScale(self, scale * GetUIScale())
	end
	frame.GetScale = function(self)
		return self.DiabolicOwnScale
	end
end

-- TrinketMenu places its window from its saved spot (TOPLEFT, in its own
-- scale), and the game's layout cache can add another anchor for it once
-- it's been dragged: with two, the window stretches between them. One
-- anchor only, the saved one, and no layout cache. A spot off the screen
-- (saved at another scale) is brought back to its edge, and saved there.
Module.PinTrinketMenu = function(self)
	local frame, saved = _G.TrinketMenu_MainFrame, _G.TrinketMenuPerOptions
	if not (frame and saved and saved.XPos and saved.YPos) or InCombatLockdown() then
		return
	end
	-- the screen, in the window's own scale
	local ratio = UIParent:GetEffectiveScale() / frame:GetEffectiveScale()
	local width, height = frame:GetWidth(), frame:GetHeight()
	saved.XPos = math.max(0, math.min(saved.XPos, UIParent:GetWidth() * ratio - width))
	saved.YPos = math.max(height, math.min(saved.YPos, UIParent:GetHeight() * ratio))
	frame:SetUserPlaced(false)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", saved.XPos, saved.YPos)
end

Module.ApplyUIScale = function(self)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnScaleCombatEnded")
		return
	end
	local minimap = self.GetMinimap()
	if minimap then
		minimap:UpdateSize()
	end
	local questie = _G.Questie_BaseFrame
	if questie then
		questie:SetScale(GetUIScale())
	end
	for _, name in ipairs({ "TrinketMenu_MainFrame", "TrinketMenu_MenuFrame" }) do
		local frame = _G[name]
		if frame then
			ScaleWithUI(frame)
			frame:SetScale(frame.DiabolicOwnScale)
		end
	end
	-- its saved spot is in its own scale: a new UI Scale converts it, so the
	-- window stays where it is on screen (from login on, where it was saved
	-- at the UI Scale it's loaded with)
	local saved, scale = _G.TrinketMenuPerOptions, GetUIScale()
	if saved and saved.XPos and saved.YPos and self.trinketMenuUIScale and (self.trinketMenuUIScale ~= scale) then
		saved.XPos = saved.XPos * self.trinketMenuUIScale / scale
		saved.YPos = saved.YPos * self.trinketMenuUIScale / scale
	end
	self.trinketMenuUIScale = scale
	self:PinTrinketMenu()
end

Module.OnScaleCombatEnded = function(self)
	self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnScaleCombatEnded")
	self:ApplyUIScale()
end

-- Questie builds its tracker some time after login: scaled once it's updated.
Module.OnEnteringWorld = function(self)
	local loader = _G.QuestieLoader
	if loader and (not self.questieHooked) then
		self.questieHooked = true
		hooksecurefunc(loader:ImportModule("TrackerBaseFrame"), "Update", function()
			local frame = _G.Questie_BaseFrame
			if frame and (frame:GetScale() ~= GetUIScale()) and not InCombatLockdown() then
				frame:SetScale(GetUIScale())
			end
		end)
	end
	self:ApplyUIScale()
end

-- combat starting while unlocked: everything goes back
Module.OnCombatStart = function(self)
	if self.framesUnlocked then
		self:SetFramesUnlocked(false)
	end
end

Module.OnEnable = function(self)
	self:CreateOptionsPanel()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStart")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEnteringWorld")
	self:RegisterMessage("ENGINE_UI_SCALE_CHANGED", "ApplyUIScale") -- /dui setscale
	self:GetHandler("ChatCommand"):Register("move", function()
		self:SetFramesUnlocked(not self:AreFramesUnlocked())
	end)
end
