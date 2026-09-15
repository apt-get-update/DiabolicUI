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
	if not (trackerFrame and Module.db and Module.db.fadeTracker) then
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

local HookTracker = function()
	if trackerFrame then
		return
	end
	trackerFrame = _G.Questie_BaseFrame
end

-- Questie builds its tracker frame lazily, from a coroutine kicked off
-- sometime around PLAYER_LOGIN/PLAYER_ENTERING_WORLD - there's no single
-- event that reliably fires *after* that frame actually exists (and if
-- Questie loads before this file runs, its own ADDON_LOADED has already
-- fired and would never be seen here anyway). Polling for the global
-- itself sidesteps all of that: cheap, and self-cancelling once found.
local waiter = CreateFrame("Frame")
waiter.elapsed = 0
waiter:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if (self.elapsed < 1) then
		return
	end
	self.elapsed = 0
	HookTracker()
	if trackerFrame then
		self:SetScript("OnUpdate", nil)
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
