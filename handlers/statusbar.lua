-- "StatusBar" handler: a StatusBar lookalike with smoothing and a spark.
-- Handler:New(parent) returns an object with the usual SetValue /
-- SetMinMaxValues / SetStatusBarColor / SetOrientation API; the texture is
-- cropped (not squashed) to the current value.
local _, Engine = ...
local Handler = Engine:NewHandler("StatusBar")

-- Lua API
local _G = _G
local math_abs = math.abs
local math_max = math.max
local math_min = math.min
local setmetatable = setmetatable
local type = type

-- WoW API
local CreateFrame = _G.CreateFrame

----------------------------------------------------------------
-- Statusbar template
----------------------------------------------------------------
local StatusBar = Engine:CreateFrame("Frame")
local StatusBar_MT = { __index = StatusBar }

-- The spark's pulse is a looping alpha animation the client plays by
-- itself, so a bar that holds still runs no Lua at all.
local SetPulse = function(spark)
	local range = spark._max_alpha - spark._min_alpha
	spark:SetAlpha(spark._min_alpha)
	spark._pulse_in:SetDuration(spark._duration_in)
	spark._pulse_in:SetChange(range)
	spark._pulse_out:SetDuration(spark._duration_out)
	spark._pulse_out:SetChange(-range)
end

StatusBar.Update = function(self)
	local value = self._ignoresmoothing and self._value or self._displayvalue
	local min, max = self._min, self._max
	local orientation = self._orientation
	local width, height = self:GetSize() 
	local bar = self.bar
	local spark = self.spark

	-- (SetValue and SetMinMaxValues keep both values in range)
	if value == min or max == min then
		self._laid.value = nil -- laid out again once it shows
		bar:Hide()
		if spark:IsShown() then
			spark:Hide()
			spark._pulse:Stop()
		end
	else
		-- The bar only needs laying out again when its value or shape changed.
		local laid = self._laid
		if (value ~= laid.value) or (min ~= laid.min) or (max ~= laid.max) or (width ~= laid.width) or (height ~= laid.height)
		or (orientation ~= laid.orientation) or (spark._width ~= laid.sparkWidth) or (spark._height ~= laid.sparkHeight) then
			laid.value, laid.min, laid.max, laid.width, laid.height = value, min, max, width, height
			laid.orientation, laid.sparkWidth, laid.sparkHeight = orientation, spark._width, spark._height
			local mult = (value-min)/(max-min)
			-- (WoW takes a size of 0 as no size set at all)
			local display_size = math_max(mult * ((orientation == "RIGHT" or orientation == "LEFT") and width or height), 0.0001)
		
			if orientation == "RIGHT" then
				bar:SetTexCoord(0, mult, 0, 1)
				bar:ClearAllPoints()
				bar:SetPoint("TOP")
				bar:SetPoint("BOTTOM")
				bar:SetPoint("LEFT")
				bar:SetSize(display_size, height)
			
				spark:ClearAllPoints()
				spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
				spark:SetSize(spark._width, height)
		
			elseif orientation == "LEFT" then
				bar:SetTexCoord(1-mult, 1, 0, 1)
				bar:ClearAllPoints()
				bar:SetPoint("TOP")
				bar:SetPoint("BOTTOM")
				bar:SetPoint("RIGHT")
				bar:SetSize(display_size, height)
			
				spark:ClearAllPoints()
				spark:SetPoint("CENTER", bar, "LEFT", 0, 0)
				spark:SetSize(spark._width, height)

			elseif orientation == "UP" then
				bar:SetTexCoord(0, 1, 1-mult, 1)
				bar:ClearAllPoints()
				bar:SetPoint("LEFT")
				bar:SetPoint("RIGHT")
				bar:SetPoint("BOTTOM")
				bar:SetSize(width, display_size)
			
				spark:ClearAllPoints()
				spark:SetPoint("CENTER", bar, "TOP", 0, 0)
				spark:SetSize(width, spark._height)

			elseif orientation == "DOWN" then
				bar:SetTexCoord(0, 1, 0, mult)
				bar:ClearAllPoints()
				bar:SetPoint("LEFT")
				bar:SetPoint("RIGHT")
				bar:SetPoint("TOP")
				bar:SetSize(width, display_size)

				spark:ClearAllPoints()
				spark:SetPoint("CENTER", bar, "BOTTOM", 0, 0)
				spark:SetSize(width, spark._height)
			end
		end

		if not spark:IsShown() then
			spark:Show()
		end
		-- A full bar keeps its spark, still, like it always had.
		if value >= max then
			spark._pulse:Stop()
		elseif not spark._pulse:IsPlaying() then
			spark._pulse:Play()
		end
		if not bar:IsShown() then
			bar:Show()
		end
	end

end

local smooth_minimum_value = 1 -- if a value is lower than this, we won't smoothe
local smooth_HZ = .2 -- each frame closes elapsed/smooth_HZ of the gap
local smooth_limit = 1/120 -- max updates per second
local smooth_finish = 1/1000 -- the last bit of the gap (a share of the range) is jumped

-- Runs only while the shown value slides towards the real one.
StatusBar.OnUpdate = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < smooth_limit then
		return
	else
		self.elapsed = 0
	end
	if self.smoothing and not self._ignoresmoothing then
		local goal = self._value
		local display = self._displayvalue
		-- Closing a share of the gap every frame never quite gets there,
		-- so the last bit is jumped (and so is all of it from nothing).
		local next_display = display + (goal - display) * math_min(elapsed/smooth_HZ, 1)
		if (display < smooth_minimum_value) or (math_abs(goal - next_display) <= (self._max - self._min) * smooth_finish) then
			self._displayvalue = goal
			self.smoothing = nil
		else
			self._displayvalue = next_display
		end
	else
		self._displayvalue = self._value
		self.smoothing = nil
	end
	if not self.smoothing then
		self.scaffold:SetScript("OnUpdate", nil)
	end
	self:Update()
end

StatusBar.DisableSmoothing = function(self, disable)
	self._ignoresmoothing = disable
end

StatusBar.SetValue = function(self, value)
	local min, max = self._min, self._max
	if value > max then
		value = max
	elseif value < min then
		value = min
	end
	self._value = value
	if value ~= self._displayvalue then
		self.smoothing = true
	end
	if self._ignoresmoothing then
		self._displayvalue = value
		self.smoothing = nil
	elseif self.smoothing then
		if not self.scaffold:GetScript("OnUpdate") then
			self.scaffold:SetScript("OnUpdate", function(_, ...) self:OnUpdate(...) end)
		end
	end
	self:Update()
end

StatusBar.Clear = function(self)
	self._value = self._min
	self._displayvalue = self._min
	self:Update()
end

StatusBar.SetMinMaxValues = function(self, min, max)
	if self._value > max then
		self._value = max
	elseif self._value < min then
		self._value = min
	end
	if self._displayvalue > max then
		self._displayvalue = max
	elseif self._displayvalue < min then
		self._displayvalue = min
	end
	self._min = min
	self._max = max
	self:Update()
end

StatusBar.SetStatusBarColor = function(self, ...)
	self.bar:SetVertexColor(...)
end

StatusBar.SetStatusBarTexture = function(self, ...)
	self.bar:SetTexture(...)
	self._laid.value = nil -- a new texture needs its crop again
	self:Update()
end

StatusBar.SetSparkTexture = function(self, ...)
	self.spark:SetTexture(...)
end

StatusBar.SetSparkSize = function(self, width, height)
	local spark = self.spark
	spark._width = width
	spark._height = height
end

StatusBar.SetSparkFlash = function(self, duration_in, duration_out, min, max)
	local spark = self.spark
	spark._duration_in = duration_in
	spark._duration_out = duration_out
	spark._min_alpha = min
	spark._max_alpha = max
	SetPulse(spark)
	if spark._pulse:IsPlaying() then
		spark._pulse:Stop()
		spark._pulse:Play()
	end
end

StatusBar.SetOrientation = function(self, orientation)
	self._orientation = orientation
end

StatusBar.CreateFrame = function(self, type, name, ...)
	return CreateFrame(type or "Frame", name, self.scaffold, ...)
end

StatusBar.CreateTexture = function(self, ...)
	return self.scaffold:CreateTexture(...)
end

StatusBar.CreateFontString = function(self, ...)
	return self.scaffold:CreateFontString(...)
end

StatusBar.SetScript = function(self, ...)
	self.scaffold:SetScript(...)
end

StatusBar.GetScript = function(self, ...)
	return self.scaffold:GetScript(...)
end

StatusBar.ClearAllPoints = function(self)
	self.scaffold:ClearAllPoints()
end

StatusBar.SetPoint = function(self, ...)
	self.scaffold:SetPoint(...)
end

StatusBar.SetAllPoints = function(self, ...)
	self.scaffold:SetAllPoints(...)
end

StatusBar.GetPoint = function(self, ...)
	return self.scaffold:GetPoint(...)
end

StatusBar.SetSize = function(self, ...)
	self.scaffold:SetSize(...)
	self:Update()
end

StatusBar.SetWidth = function(self, ...)
	self.scaffold:SetWidth(...)
	self:Update()
end

StatusBar.SetHeight = function(self, ...)
	self.scaffold:SetHeight(...)
	self:Update()
end

StatusBar.GetHeight = function(self, ...)
	local top = self:GetTop()
	local bottom = self:GetBottom()
	if top and bottom then
		return top - bottom
	else
		return self.scaffold:GetHeight(...)
	end
end

StatusBar.GetWidth = function(self, ...)
	local left = self:GetLeft()
	local right = self:GetRight()
	if left and right then
		return right - left
	else
		return self.scaffold:GetWidth(...)
	end
end

StatusBar.GetSize = function(self, ...)
	local width, height

	local top = self:GetTop()
	local bottom = self:GetBottom()
	local left = self:GetLeft()
	local right = self:GetRight()

	if left and right then
		width = right - left
	end

	if top and bottom then
		height = top - bottom
	end

	return width or self.scaffold:GetWidth(), height or self.scaffold:GetHeight()
end

StatusBar.SetFrameLevel = function(self, ...)
	self.scaffold:SetFrameLevel(...)
end

StatusBar.SetFrameStrata = function(self, ...)
	self.scaffold:SetFrameStrata(...)
end

StatusBar.SetAlpha = function(self, ...)
	self.scaffold:SetAlpha(...)
end

StatusBar.SetParent = function(self, parent)
	self.scaffold:SetParent(parent)
end

StatusBar.GetValue = function(self)
	return self._value
end

StatusBar.GetMinMaxValues = function(self)
	return self._min, self._max
end

StatusBar.GetStatusBarColor = function(self)
	return self.bar:GetVertexColor()
end

StatusBar.GetFrameLevel = function(self)
	return self.scaffold:GetFrameLevel()
end

StatusBar.GetFrameStrata = function(self)
	return self.scaffold:GetFrameStrata()
end

StatusBar.GetAlpha = function(self)
	return self.scaffold:GetAlpha()
end

StatusBar.GetParent = function(self)
	return self.scaffold and self.scaffold:GetParent()
end

StatusBar.GetObjectType = function(self) return "StatusBar" end
StatusBar.IsObjectType = function(self, type) return type == "StatusBar" end

StatusBar.Show = function(self) self.scaffold:Show() end
StatusBar.Hide = function(self) self.scaffold:Hide() end
StatusBar.IsShown = function(self) return self.scaffold:IsShown() end

Handler.New = function(self, parent)

	-- The scaffold is the top level frame object 
	-- that will respond to SetSize, SetPoint and similar.
	local scaffold = CreateFrame("Frame", nil, parent)
	scaffold:SetSize(1,1)

	-- the bar texture
	local bar = scaffold:CreateTexture(nil, "BORDER")
	bar:SetPoint("TOP")
	bar:SetPoint("BOTTOM")
	bar:SetPoint("LEFT")
	bar:SetWidth(scaffold:GetWidth())
	
	-- the spark texture
	local spark = scaffold:CreateTexture(nil, "OVERLAY")
	spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
	spark:SetSize(1,1)
	spark._width = 1
	spark._height = 1
	spark._duration_in = 2.75
	spark._duration_out = 1.25
	spark._min_alpha = .35
	spark._max_alpha = .85
	spark._pulse = spark:CreateAnimationGroup()
	spark._pulse:SetLooping("REPEAT")
	spark._pulse_in = spark._pulse:CreateAnimation("Alpha")
	spark._pulse_in:SetOrder(1)
	spark._pulse_out = spark._pulse:CreateAnimation("Alpha")
	spark._pulse_out:SetOrder(2)
	SetPulse(spark)

	-- The statusbar is the virtual object that we return to the user.
	-- This contains all the methods.
	local statusbar = CreateFrame("Frame", nil, scaffold)
	statusbar:SetAllPoints() -- lock down the points before we overwrite the methods

	setmetatable(statusbar, StatusBar_MT)

	statusbar._min = 0 -- min value
	statusbar._max = 1 -- max value
	statusbar._value = 0 -- real value
	statusbar._displayvalue = 0 -- displayed value while smoothing
	statusbar._orientation = "RIGHT" -- direction the bar is growing in 
	statusbar._laid = {} -- what Update last laid out

	-- I usually don't like exposing things like this to the user, 
	-- but we're going for performance here. 
	statusbar.bar = bar
	statusbar.spark = spark
	statusbar.scaffold = scaffold
	
	statusbar:Update()

	return statusbar
end
