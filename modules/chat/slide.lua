-- New chat lines slide in (the "slideMessages" option): when a line is
-- added, the window's text starts one line lower and eases up into place,
-- instead of jumping up a line.
--
-- Blizzard's chat window draws all its lines itself, so single lines can't
-- be animated: the whole window is, with a Translation animation, which
-- only shifts how it's drawn, never its anchors. Its tab, edit box and
-- buttons move with it, so it only plays while those are out of sight:
-- not while typing in it or hovering it, nor scrolled up in it.
local _, Engine = ...
local Module = Engine:NewModule("ChatSlide")

-- Lua API
local _G = _G
local select = select

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local MouseIsOver = _G.MouseIsOver

local SLIDE_DURATION = .3
local LINE_SPACING = 2

local GetSlide = function(frame)
	if frame.DiabolicSlide then
		return frame.DiabolicSlide
	end
	-- one line down at once, then back up, easing in and out
	local slide = frame:CreateAnimationGroup()
	slide.down = slide:CreateAnimation("Translation")
	slide.down:SetOrder(1)
	slide.down:SetDuration(0)
	slide.up = slide:CreateAnimation("Translation")
	slide.up:SetOrder(2)
	slide.up:SetDuration(SLIDE_DURATION)
	slide.up:SetSmoothing("IN_OUT")
	frame.DiabolicSlide = slide
	return slide
end

-- Whether the window's tab, edit box or buttons may be showing.
local IsBusy = function(frame)
	local editBox = frame.editBox or _G[frame:GetName() .. "EditBox"]
	return (editBox and editBox:IsShown()) or MouseIsOver(frame)
end

local OnAddMessage = function(frame)
	if not (Module.db.slideMessages and frame:IsVisible()) then
		return
	end
	if (not frame:AtBottom()) or IsBusy(frame) then
		return
	end
	local height = (select(2, frame:GetFont()) or 14) + LINE_SPACING
	local slide = GetSlide(frame)
	slide:Stop() -- a new line during a slide starts over from it
	slide.down:SetOffset(0, -height)
	slide.up:SetOffset(0, height)
	slide:Play()
end

Module.HookFrame = function(self, frame)
	if frame and not frame.DiabolicSlideHooked then
		frame.DiabolicSlideHooked = true
		hooksecurefunc(frame, "AddMessage", OnAddMessage)
	end
end

Module.OnInit = function(self)
	self.db = self:GetConfig("ChatWindows")
end

Module.OnEnable = function(self)
	for i = 1, _G.NUM_CHAT_WINDOWS do
		-- not the combat log: it scrolls constantly
		if (i ~= 2) then
			self:HookFrame(_G["ChatFrame" .. i])
		end
	end
	-- whispers and the like popped out into their own windows
	hooksecurefunc("FCF_OpenTemporaryWindow", function()
		for _, name in _G.ipairs(_G.CHAT_FRAMES) do
			self:HookFrame(_G[name])
		end
	end)
end
