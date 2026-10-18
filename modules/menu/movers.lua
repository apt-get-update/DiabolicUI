-- Unlock Frames (/dui move): boxes over the frames that can be moved, to
-- drag them, and one Lock Frames button to put them back.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:GetModule("Menu")

-- Lua API
local ipairs = ipairs

-- WoW API
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown

-- the controls (controls.lua)
local C = Module.Controls
local BUTTON_HEIGHT = C.BUTTON_HEIGHT

-- Unlock Frames: every frame that can be moved at once - the minimap
-- (modules/minimap, its edit mode), Blizzard's quest tracker
-- (modules/objectives/tracker.lua), Questie's tracker (its own lock), the
-- main chat window and the menu buttons with the gold and fps texts - with
-- one Lock Frames button to put them back. Not in combat: the minimap and
-- the menu buttons are secure, and entering combat locks them.
-------------------------------------------------------
local GetMinimap = function()
	local minimap = _G.DiabolicUIMinimapNS
	return minimap and minimap:GetModule("Minimap", true)
end
Module.GetMinimap = GetMinimap -- for the UI scale (menu.lua)

-- Questie's tracker, while it's in use: it moves once Questie's own
-- "trackerLocked" is off.
local GetQuestieTracker = function()
	local questie, loader = _G.Questie, _G.QuestieLoader
	if questie and questie.db and questie.db.profile and questie.db.profile.trackerEnabled and loader then
		return questie.db.profile, loader:ImportModule("TrackerBaseFrame")
	end
end

-- A frame's effective scale; a text's or texture's, its first frame's.
local EffectiveScale = function(region)
	while region and (not region.GetEffectiveScale) do
		region = region:GetParent()
	end
	return region and region:GetEffectiveScale() or 1
end

-- The box covers `target` and the `extra` frames attached to it (the
-- chat's buttons and edit box), or only those (the menu buttons and their
-- texts, inside a wider holder): their outer edges, measured each time
-- it's shown, kept as offsets from `target` so it follows the drag. An
-- extra given as { frame, "lr" } only counts for those edges (left, right,
-- top, bottom): the chat's button column reaches below its last button.
local FitMover = function(mover, target, extra, extraOnly, padding)
	local left, right, top, bottom = target:GetLeft(), target:GetRight(), target:GetTop(), target:GetBottom()
	mover:ClearAllPoints()
	if not (left and right and top and bottom) then
		mover:SetAllPoints(target)
		return
	end
	local l, r, t, b = left, right, top, bottom
	if extraOnly then
		l, r, t, b = math.huge, -math.huge, -math.huge, math.huge
	end
	for _, entry in ipairs(extra) do
		local frame, edges = entry, "lrtb"
		if (type(entry) == "table") and (not entry.GetLeft) then
			frame, edges = entry[1], entry[2]
		end
		local fl, fr, ft, fb = frame:GetLeft(), frame:GetRight(), frame:GetTop(), frame:GetBottom()
		if fl and fr and ft and fb then
			-- in the target's own scale (a text's or texture's is its
			-- frame's: 3.3.5 gives them none of their own)
			local scale = EffectiveScale(frame) / EffectiveScale(target)
			fl, fr, ft, fb = fl * scale, fr * scale, ft * scale, fb * scale
			if edges:find("l") then l = math.min(l, fl) end
			if edges:find("r") then r = math.max(r, fr) end
			if edges:find("t") then t = math.max(t, ft) end
			if edges:find("b") then b = math.min(b, fb) end
		end
	end
	if (l > r) then -- none of them placed
		mover:SetAllPoints(target)
		return
	end
	padding = padding or 0
	l, r, t, b = l - padding, r + padding, t + padding, b - padding
	mover:SetPoint("TOPLEFT", target, "TOPLEFT", l - left, t - top)
	mover:SetPoint("BOTTOMRIGHT", target, "BOTTOMRIGHT", r - right, b - bottom)
end

-- A box over a frame that drags it: `onDragStart` and `onDragStop` run
-- around the move.
-- On top of what it covers, so its buttons can't be clicked meanwhile
-- (the menu buttons are DIALOG themselves). `padding` makes it that much
-- bigger than what it fits around.
local CreateMover = function(name, target, text, onDragStart, onDragStop, extra, extraOnly, padding)
	local mover = CreateFrame("Frame", name, UIParent)
	mover:SetFrameStrata("FULLSCREEN_DIALOG")
	mover:SetAllPoints(target)
	if extra then
		mover:SetScript("OnShow", function(self) FitMover(self, target, extra, extraOnly, padding) end)
	end
	mover:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	mover:SetBackdropColor(.6, .1, .1, .5)
	mover:SetBackdropBorderColor(1, .82, 0, 1)
	mover:EnableMouse(true)
	mover:RegisterForDrag("LeftButton")
	mover.Text = mover:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mover.Text:SetPoint("CENTER")
	mover.Text:SetText(text)
	mover:SetScript("OnDragStart", function()
		if onDragStart then
			onDragStart()
		end
		target:SetMovable(true)
		target:StartMoving()
	end)
	mover:SetScript("OnDragStop", function()
		target:StopMovingOrSizing()
		if onDragStop then
			onDragStop()
		end
	end)
	mover.target = target
	mover:Hide()
	return mover
end

Module.GetMovers = function(self)
	if self.Movers then
		return self.Movers
	end
	local chat = Engine:GetModule("ChatWindows")
	local menu = Engine:GetModule("ActionBars"):GetWidget("Controller: Menu")
	local menuButtons = Engine:GetModule("ActionBars"):GetWidget("Menu: Main")
	local master = menuButtons.MasterMenuButton
	self.Movers = {
		-- dropped by hand: no longer placed automatically, and kept there
		-- (modules/chat/windows.lua saves it)
		CreateMover("DiabolicUIChatMover", _G.ChatFrame1, L["Chat"], function()
			chat.db.autoposition = false
		end, function()
			chat:SaveChatFrameLayout()
		end, { { _G.ChatFrame1ButtonFrame, "lr" }, { _G.ChatFrameMenuButton, "lrt" }, _G.ChatFrame1EditBox }),
		CreateMover("DiabolicUIMenuMover", menu:GetFrame(), L["Menu"], nil, function()
			menu:SavePosition()
		end, { master, menuButtons.BagBarMenuButton, master.Gold, master.Performance }, true, 6)
	}
	-- TrinketMenu's worn trinkets, saved where TrinketMenu keeps them
	local trinkets = _G.TrinketMenu_MainFrame
	if trinkets and _G.TrinketMenuPerOptions then
		table.insert(self.Movers, CreateMover("DiabolicUITrinketMenuMover", trinkets, "TrinketMenu", nil, function()
			_G.TrinketMenuPerOptions.XPos = trinkets:GetLeft()
			_G.TrinketMenuPerOptions.YPos = trinkets:GetTop()
			self:PinTrinketMenu()
		end))
	end
	return self.Movers
end

Module.AreFramesUnlocked = function(self)
	return self.framesUnlocked and true or false
end

Module.GetLockButton = function(self)
	if self.LockButton then
		return self.LockButton
	end
	local button = CreateFrame("Button", "DiabolicUILockFramesButton", UIParent, "UIPanelButtonTemplate")
	button:SetFrameStrata("TOOLTIP") -- above the boxes
	button:SetSize(160, BUTTON_HEIGHT)
	button:SetPoint("TOP", UIParent, "TOP", 0, -120)
	button:SetText(L["Lock Frames"])
	button:SetScript("OnClick", function() self:SetFramesUnlocked(false) end)
	button.Hint = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	button.Hint:SetPoint("TOP", button, "BOTTOM", 0, -6)
	button.Hint:SetText(L["Drag the highlighted frames to move them. Right-drag the minimap to resize it."])
	button:Hide()
	self.LockButton = button
	return button
end

Module.SetFramesUnlocked = function(self, unlocked)
	if unlocked and InCombatLockdown() then
		print(L["You can't move frames in combat."])
		return
	end
	self.framesUnlocked = unlocked
	-- the quest tracker in use: Questie's when it's on, Blizzard's otherwise
	local questie, questieTracker = GetQuestieTracker()
	Engine:GetModule("ObjectiveTracker"):SetTrackerUnlocked(unlocked and not questie)
	for _, mover in ipairs(self:GetMovers()) do
		if unlocked and mover.target:IsShown() then
			mover:Show()
		else
			mover:Hide()
		end
	end
	-- Questie's tracker: unlocked, then back to the way it was. It drags
	-- and saves itself, so its box only shows it: clicks go through.
	if questie then
		if unlocked then
			self.questieWasLocked = questie.trackerLocked
			questie.trackerLocked = false
		elseif (self.questieWasLocked ~= nil) then
			questie.trackerLocked = self.questieWasLocked
			self.questieWasLocked = nil
		end
		questieTracker:Update()
	end
	local questieFrame = _G.Questie_BaseFrame
	if unlocked and questie and questieFrame then
		if (not self.QuestieBox) then
			self.QuestieBox = CreateMover("DiabolicUIQuestieMover", questieFrame, "Questie", nil, nil)
			self.QuestieBox:EnableMouse(false)
		end
		self.QuestieBox:Show()
	elseif self.QuestieBox then
		self.QuestieBox:Hide()
	end
	local minimap = GetMinimap()
	if minimap then
		if unlocked then
			minimap:EnterEditMode()
		else
			minimap:ExitEditMode()
		end
	end
	local lockButton = self:GetLockButton()
	if unlocked then
		lockButton:Show()
	else
		lockButton:Hide()
	end
	if self.UnlockFramesButton then
		self.UnlockFramesButton:SetText(unlocked and L["Lock Frames"] or L["Unlock Frames"])
	end
end
