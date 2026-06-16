local _, Engine = ...
local Handler = Engine:NewHandler("Shine")

-- Lua API
local _G = _G

-- WoW API
local CreateFrame = _G.CreateFrame
local GetTime = _G.GetTime

-- Shine defaults
local MAXALPHA = .5
local SCALE = 5
local DURATION = .75
local TEXTURE = [[Interface\Cooldown\star4]]

local New = function(frameType, parentClass)
	local class = CreateFrame(frameType)
	class.mt = { __index = class }
	if parentClass then
		class = setmetatable(class, { __index = parentClass })
		class.super = function(self, method, ...) parentClass[method](self, ...) end
	end
	class.Bind = function(self, obj) return setmetatable(obj, self.mt) end
	return class
end

local Shine = New("Frame")

Shine.New = function(self, parent, maxAlpha, duration, scale)
	local f = self:Bind(CreateFrame("Frame", nil, parent)) 
	f:Hide() 
	f:SetScript("OnHide", Shine.OnHide) 
	f:SetAllPoints(parent) 
	f:SetToplevel(true) 

	local t = f:CreateTexture(nil, "OVERLAY")
	t:SetPoint("CENTER")
	t:SetBlendMode("ADD") 
	t:SetAllPoints(f) 
	t:SetTexture(TEXTURE)

	f.animation = f:CreateShineAnimation(maxAlpha, duration, scale)
	f.lastPlayed = GetTime()
	f.throttle = 500 
	return f
end

Shine.OnFinished = function(self)
	local parent = self:GetParent()
	if parent:IsShown() then
		parent:Hide()
	end
end

Shine.CreateShineAnimation = function(self, maxAlpha, duration, scale)
	local MAXALPHA = maxAlpha or MAXALPHA
	local SCALE = scale or SCALE
	local DURATION = duration or DURATION

	local g = self:CreateAnimationGroup() 
	g:SetLooping("NONE") 
	g:SetScript("OnFinished", Shine.OnFinished) 

	local a1 = g:CreateAnimation("Alpha")
	a1:SetChange(-1) 
	a1:SetDuration(0) 
	a1:SetOrder(0) 

	local a2 = g:CreateAnimation("Scale") 
	a2:SetOrigin("CENTER", 0, 0) 
	a2:SetScale(SCALE, SCALE) 
	a2:SetDuration(DURATION/2) 
	a2:SetOrder(1) 

	local a3 = g:CreateAnimation("Alpha") 
	a3:SetChange(MAXALPHA) 
	a3:SetDuration(DURATION/2) 
	a3:SetOrder(1)

	local a4 = g:CreateAnimation("Scale") 
	a4:SetOrigin("CENTER", 0, 0) 
	a4:SetScale(-SCALE, -SCALE) 
	a4:SetDuration(DURATION/2) 
	a4:SetOrder(2)

	local a5 = g:CreateAnimation("Alpha") 
	a5:SetChange(-MAXALPHA) 
	a5:SetDuration(DURATION/2) 
	a5:SetOrder(2)

	return g
end

Shine.OnHide = function(self)
	if self.animation:IsPlaying() then
		self.animation:Finish()
	end
	self:Hide()
end

Shine.SetThrottle = function(self, ms)
	self.throttle = ms
end

Shine.Start = function(self)
	if (GetTime() - self.lastPlayed) < self.throttle then
		if self.animation:IsPlaying() then
			self.animation:Finish()
		end
		self:Show()
		self.animation:Play()
	end
	self.lastPlayed = GetTime()
end

-- usage:
-- 	local shine = Handler:ApplyShine(frame, maxAlpha, duration, scale)
-- 	shine:Start() -- start
--	shine:Hide() -- finish
Handler.ApplyShine = function(self, frame, maxAlpha, duration, scale)
	return Shine:New(frame, maxAlpha, duration, scale)
end

Handler.OnEnable = function(self)
end

Handler.OnDisable = function(self)
end
