local _, Engine = ...
local Module = Engine:NewModule("ObjectiveTracker")
local L = Engine:GetLocale()

-- WoW API
local CreateFrame = CreateFrame
local GetCursorPosition = GetCursorPosition
local GetTime = GetTime
local hooksecurefunc = hooksecurefunc

-- How long the actual fade transition itself takes. The delay before it
-- starts (Time Fading) and how far it fades (Opacity) are user settings.
local FADE_DURATION = .3

-- The cursor and the tracker are checked this often; only a fade itself
-- runs every frame.
local CHECK_INTERVAL = 1/20

local trackerFrame
local state -- nil (idle, fully visible) | "waiting" | "fading"
local stateStart
local wasOver = false

-- Questie's tracker when it's actually in use, Blizzard's own WatchFrame
-- otherwise. Resolved every tick rather than once, because Questie builds
-- its frame lazily from a coroutine some time after login (no event
-- reliably fires once it exists), and the player can toggle Questie's
-- tracker on and off at any time from its own options.
local GetTracker = function()
	local questie = _G.Questie_BaseFrame
	if questie and questie:IsShown() then
		return questie
	end
	return _G.WatchFrame
end

-- Questie disables actual mouse input on its tracker (EnableMouse(false))
-- whenever it's locked, which is its default state - meaning OnEnter/
-- OnLeave never fire on it at all. Hovering is detected geometrically
-- instead, comparing the cursor's own screen position to the frame's
-- rect, which works regardless of whether the frame accepts mouse input.
local IsCursorOver = function(frame)
	local left, right = frame:GetLeft(), frame:GetRight()
	local top, bottom = frame:GetTop(), frame:GetBottom()
	if not (left and right and top and bottom) then
		return false
	end
	local scale = frame:GetEffectiveScale()
	local x, y = GetCursorPosition()
	x, y = x / scale, y / scale
	return (x >= left) and (x <= right) and (y >= bottom) and (y <= top)
end

local CancelFade = function()
	state = nil
	if trackerFrame then
		trackerFrame:SetAlpha(1)
	end
end

local ticker = CreateFrame("Frame")
Module.FadeTicker = ticker -- (named in /dui cpu)
ticker:SetScript("OnUpdate", function(self, elapsed)
	if not (Module.db and Module.db.fadeTracker) then
		return
	end
	self.elapsed = (self.elapsed or 0) + elapsed
	if (state ~= "fading") and (self.elapsed < CHECK_INTERVAL) then
		return
	end
	self.elapsed = 0

	-- Switching trackers mid-fade (Questie's toggled on or off) would
	-- otherwise leave the old one stuck at whatever alpha it had reached.
	local tracker = GetTracker()
	if (tracker ~= trackerFrame) then
		CancelFade()
		trackerFrame = tracker
		wasOver = false
	end
	if not (trackerFrame and trackerFrame:IsShown()) then
		return
	end

	local over = IsCursorOver(trackerFrame)
	if over and (not wasOver) then
		CancelFade()
	elseif (not over) and wasOver then
		state = "waiting"
		stateStart = GetTime()
	end
	wasOver = over

	local now = GetTime()
	if (state == "waiting") then
		if (now - stateStart) >= Module.db.fadeDelay then
			state = "fading"
			stateStart = now
		end
	elseif (state == "fading") then
		local fadedAlpha = Module.db.fadeOpacity / 100
		local progress = (now - stateStart) / FADE_DURATION
		if (progress >= 1) then
			trackerFrame:SetAlpha(fadedAlpha)
			state = nil
		else
			trackerFrame:SetAlpha(1 - (1 - fadedAlpha) * progress)
		end
	end
end)

-- Called from the options panel so unticking the checkbox immediately
-- restores full visibility instead of waiting on the next mouseover.
Module.ApplyFadeSetting = function(self)
	if not self.db.fadeTracker then
		CancelFade()
	end
end

Module.OnInit = function(self)
	self.db = self:GetConfig("ObjectiveTracker")
end

-- Moving Blizzard's tracker
-------------------------------------------------------
-- The WatchFrame is placed by UIParent_ManageFramePositions under the
-- minimap, unless it's "user placed". Either way that also anchors its
-- bottom right to the bottom of the screen, which is how it knows how many
-- lines fit. A moved tracker ("trackerPosition", its top right corner from
-- the screen's bottom left) keeps that: its top right where it was put,
-- stretching down to the same bottom, at its own right edge. Nothing in it
-- is secure in 3.3.5, so it can be placed in combat too.

local WATCHFRAME_BOTTOM = 70 -- CONTAINER_OFFSET_Y, above the bags

Module.PlaceTracker = function(self)
	local position = self.db.trackerPosition
	local watchFrame = _G.WatchFrame
	if not (position and watchFrame) then
		return
	end
	local right, top = position[1], position[2]
	watchFrame:SetMovable(true)
	watchFrame:SetUserPlaced(true)
	watchFrame:ClearAllPoints()
	watchFrame:SetPoint("TOPRIGHT", _G.UIParent, "BOTTOMLEFT", right, top)
	watchFrame:SetPoint("BOTTOMRIGHT", _G.UIParent, "BOTTOMLEFT", right, WATCHFRAME_BOTTOM)
end

-- While unlocked, a box on the tracker's top drags it.
Module.GetMover = function(self)
	if self.Mover then
		return self.Mover
	end
	local mover = CreateFrame("Frame", "DiabolicUITrackerMover", _G.UIParent)
	mover:SetFrameStrata("DIALOG")
	mover:SetSize(_G.WatchFrame:GetWidth() > 0 and _G.WatchFrame:GetWidth() or 204, 60)
	mover:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	mover:SetBackdropColor(.6, .1, .1, .5)
	mover:SetBackdropBorderColor(1, .82, 0, 1)
	mover:EnableMouse(true)
	mover:SetMovable(true)
	mover:SetClampedToScreen(true)
	mover:RegisterForDrag("LeftButton")

	mover.Text = mover:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mover.Text:SetPoint("CENTER")
	mover.Text:SetText(L["Drag to move the tracker"])

	mover:SetScript("OnDragStart", function(frame)
		frame:StartMoving()
	end)
	mover:SetScript("OnDragStop", function(frame)
		frame:StopMovingOrSizing()
		self.db.trackerPosition = { frame:GetRight(), frame:GetTop() }
		self:PlaceTracker()
	end)
	self.Mover = mover
	return mover
end

Module.IsTrackerUnlocked = function(self)
	return self.Mover and self.Mover:IsShown() and true or false
end

Module.SetTrackerUnlocked = function(self, unlocked)
	local watchFrame = _G.WatchFrame
	if unlocked then
		local mover = self:GetMover()
		local right, top = watchFrame:GetRight(), watchFrame:GetTop()
		if self.db.trackerPosition then
			right, top = self.db.trackerPosition[1], self.db.trackerPosition[2]
		end
		mover:ClearAllPoints()
		mover:SetPoint("TOPRIGHT", _G.UIParent, "BOTTOMLEFT", right or 0, top or 0)
		mover:Show()
	elseif self.Mover then
		self.Mover:Hide()
	end
end

-- Back under the minimap, where Blizzard puts it. While unlocked, its box
-- follows it there.
Module.ResetTrackerPosition = function(self)
	self.db.trackerPosition = nil
	_G.WatchFrame:SetUserPlaced(false)
	_G.UIParent_ManageFramePositions()
	if self:IsTrackerUnlocked() then
		self:SetTrackerUnlocked(true)
	end
end

Module.OnEnable = function(self)
	-- Blizzard re-lays its frames out often (bags, arena frames, ...)
	hooksecurefunc("UIParent_ManageFramePositions", function() self:PlaceTracker() end)
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "PlaceTracker")
	self:PlaceTracker()
end
