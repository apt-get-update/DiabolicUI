local _, Engine = ...
local Module = Engine:NewModule("ObjectiveTracker")

-- WoW API
local CreateFrame = CreateFrame
local GetCursorPosition = GetCursorPosition
local GetTime = GetTime

-- How long the actual fade transition itself takes. The delay before it
-- starts (Time Fading) and how far it fades (Opacity) are user settings.
local FADE_DURATION = .3

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
ticker:SetScript("OnUpdate", function(self, elapsed)
	if not (Module.db and Module.db.fadeTracker) then
		return
	end

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
