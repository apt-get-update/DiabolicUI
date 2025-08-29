local _, Engine = ...
local Handler = Engine:NewHandler("Orb")

-- Lua API
local _G = _G
local math_abs = math.abs
local math_max = math.max
local math_sqrt = math.sqrt
local select = select
local setmetatable = setmetatable
local type = type
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame

local Orb = CreateFrame("Frame")
local Orb_MT = { __index = Orb }


Orb.Update = function(self, elapsed)
	local value = self._ignoresmoothing and self.value or self.smoothing and self.displayValue or self.value
	local min, max = self.minValue, self.maxValue
	local width, height = self.scaffold:GetSize()
	local spark = self.overlay.spark
	
	if value > max then
		value = max
	elseif value < min then
		value = min
	end
		
	local newHeight
	if value > 0 and value > min and max > min then
		newHeight = (value-min)/(max-min) * height
	else
		newHeight = 0
	end
	
	if value <= min or max == min then
		-- this just bugs out at small values in Legion, 
		-- so it's easier to simply hide it. 
		self.scrollframe:Hide()
	else
		local new_size
		local mult = max > min and ((value-min)/(max-min)) or min
		if max > min then
			new_size = mult * width
		else
			new_size = 0
			mult = 0.0001
		end
		local displaySize = math_max(new_size, 0.0001) -- sizes can't be 0 in Legion

		self.scrollframe:SetHeight(displaySize)
		self.scrollframe:SetVerticalScroll(height - newHeight)
		
		if not self.scrollframe:IsShown() then
			self.scrollframe:Show()
		end
	end
	
	if value == max or value == min then
		if spark:IsShown() then
			spark:Hide()
			spark:SetAlpha(spark.minAlpha)
			spark.flashDirection = "IN"
			spark.glow:Hide()
			spark.glow:SetAlpha(spark.minAlpha)
		end
	else
		local spark = spark
		local glow = spark.glow

		-- freaking pythagoras
		--	r^2 = x^2 + y^2
		--	x^2 = r^2 - y^2
		--	x = sqrt(r^2 - y^2)
		local y = math_abs(height/2 - newHeight)
		local r = height/2
		local x = math_sqrt(r^2 - y^2) * 2
		local sparkWidth = x == 0 and 0.0001 or x
		local sparkHeight = spark._height/2 + sparkWidth/width * spark._height

		local scrollframe = self.scrollframe
		local leftCrop, rightCrop = self.leftCrop, self.rightCrop

		local texLeft, texRight = 0, 1 -- spark texcoords
		local sparkSpace = (width - x)/2 -- space between spark and the full frame width

		local sparkAnchor = "TOP"
		local sparkPoint = "CENTER"

		-- The orb is cropped over the edges of the spark, 
		-- so we need to adjust its size and texcoords.
		if leftCrop > sparkSpace then
			local overflow = leftCrop - sparkSpace
			texLeft = overflow/x
			sparkWidth = sparkWidth - overflow
			sparkAnchor = "TOPLEFT"
			sparkPoint = "LEFT"
		end

		if rightCrop > sparkSpace then
			local overflow = rightCrop - sparkSpace
			texRight = 1 - overflow/x
			sparkWidth = sparkWidth - overflow
			sparkAnchor = "TOPRIGHT"
			sparkPoint = "RIGHT"
		end

		spark:SetTexCoord(texLeft, texRight, 0, 1)
		spark:ClearAllPoints()
		spark:SetPoint(sparkPoint, scrollframe, sparkAnchor, sparkOffset, -1)
		spark:SetSize(sparkWidth, sparkHeight)

		glow:SetTexCoord(texLeft, texRight, 0, 1)
		glow:ClearAllPoints()
		glow:SetPoint(sparkPoint, scrollframe, sparkAnchor, sparkOffset, -1)
		glow:SetSize(sparkWidth, sparkHeight/spark._height * spark.glow._height)

		if elapsed then
			local currentAlpha = spark.glow:GetAlpha()
			local targetAlpha = spark.flashDirection == "IN" and spark.maxAlpha or spark.minAlpha
			local range = spark.maxAlpha - spark.minAlpha
			local alphaChange = elapsed/(spark.flashDirection == "IN" and spark.durationIn or spark.durationOut) * range
		
			if spark.flashDirection == "IN" then
				if currentAlpha + alphaChange < targetAlpha then
					currentAlpha = currentAlpha + alphaChange
				else
					currentAlpha = targetAlpha
					spark.flashDirection = "OUT"
				end
			elseif spark.flashDirection == "OUT" then
				if currentAlpha + alphaChange > targetAlpha then
					currentAlpha = currentAlpha - alphaChange
				else
					currentAlpha = targetAlpha
					spark.flashDirection = "IN"
				end
			end
			spark:SetAlpha(currentAlpha)
			--spark:SetAlpha(spark.maxAlpha)
			glow:SetAlpha(currentAlpha)
		end
		if not spark:IsShown() then
			spark:Show()
			glow:Show()
		end
	end
end

local smoothMinValue = 1 -- if a value is lower than this, we won't smoothe
local smoothHZ = .2 -- time for the smooth transition to complete
local smoothLimit = 1/120 -- max updates per second
Orb.OnUpdate = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < smoothLimit then
		return
	else
		self.elapsed = 0
	end
	if self.smoothing then
		local goal = self.value
		local display = self.displayValue
		local change = (goal-display)*(elapsed/(self._smoothHZ or smoothHZ))

		if display < smoothMinValue then
			self.displayValue = goal
			self.smoothing = nil
		else
			if goal > display then
				if goal > (display + change) then
					self.displayValue = display + change
				else
					self.displayValue = goal
					self.smoothing = nil
				end
			elseif goal < display then
				if goal < (display + change) then
					self.displayValue = display + change
				else
					self.displayValue = goal
					self.smoothing = nil
				end
			else
				self.displayValue = goal
				self.smoothing = nil
			end
		end
	else
		if self.displayValue <= self.minValue or self.displayValue >= self.maxValue then
			self.scaffold:SetScript("OnUpdate", nil)
			self.smoothing = nil
		end
	end
	self:Update(elapsed)
end

Orb.SetSmoothHZ = function(self, HZ)
	self._smoothHZ = smoothHZ
end

Orb.DisableSmoothing = function(self, disable)
	self._ignoresmoothing = disable
end

-- sets the value the orb should move towards
Orb.SetValue = function(self, value)
	local min, max = self.minValue, self.maxValue
	if value > max then
		value = max
	elseif value < min then
		value = min
	end
	if not self._ignoresmoothing then
		if self.displayValue > max then
			self.displayValue = max
		elseif self.displayValue < min then
			self.displayValue = min
		end
	end
	self.value = value
	if value ~= self.displayValue then
		self.smoothing = true
	end
	if self.smoothing or self.displayValue > min or self.displayValue < max then
		if not self.scaffold:GetScript("OnUpdate") then
			self.scaffold:SetScript("OnUpdate", function(_, ...) self:OnUpdate(...) end)
		end
	end
	self:Update()
end

-- forces a hard reset to zero
Orb.Clear = function(self)
	self.value = self.minValue
	self.displayValue = self.minValue
	self:Update()
end

Orb.SetMinMaxValues = function(self, min, max)
	if self.value > max then
		self.value = max
	elseif self.value < min then
		self.value = min
	end
	if self.displayValue > max then
		self.displayValue = max
	elseif self.displayValue < min then
		self.displayValue = min
	end
	self.minValue = min
	self.maxValue = max
	self:Update()
end

Orb.SetStatusBarColor = function(self, r, g, b, ...)
	local numArgs = select("#", ...)
	local a, id
	if numArgs == 1 then
		local arg = ...
		if type(arg) == "string" then
			id = arg
		elseif type(arg) == "number" then
			a = arg
		end
	elseif numArgs == 2 then
		a, id = ...
	end

	local scaffold = self.scaffold
	local colors = scaffold.colors

	id = id or "bar" -- redundant? we don't think of any layer as "the real one" any more.

	if id == "ALL" then
		for layerID,colorTable in pairs(colors) do
			local factor
			-- These factors are the same I use as a basis
			-- for my own custom orb colors. 
			-- I do however reduce the green component of yellow and orange colors by A LOT,
			-- and this script doesn't take special considerations like that. Maybe one day.
			if layerID == "bar" then
				factor = 1/4
			elseif layerID == "moon" then
				factor = 1/2
			elseif layerID == "smoke" then
				factor = 1
			elseif layerID == "shade" then 
				factor = 1/10
			else
				-- This never happens unless you screw up, 
				-- but I actually expect that to happen. So there! :)
				factor = 1/2
			end
			colorTable[1] = r * factor
			colorTable[2] = g * factor
			colorTable[3] = b * factor
			if a then 
				colorTable[4] = a
			end
			scaffold[layerID]:SetVertexColor(r, g, b, a)
		end
	else
		if id and colors[id] then
			colors[id][1] = r
			colors[id][2] = g
			colors[id][3] = b
			if a then 
				colors[id][4] = a
			end
		end
		scaffold[id]:SetVertexColor(r, g, b, a)
	end
	
	-- Changed the base color for the spark from "bar" to "smoke", 
	-- as in most cases its' the smoke layer that has the original color.
	if (id == "smoke") or (id == "ALL") then
		-- make the spark a really bright shade of the same colors, 
		-- but take the "green" effect of darker overlays into account.
		local newRed =  (1 - r)*.75 + r
		local newGreen =  (1 - g)*.75 + g
		local newBlue =  (1 - b)*.75 + b
		if (newRed > newGreen) and (newRed > newBlue) then 
			newGreen = newGreen * .8
		end
		if (newBlue > newRed) and (newBlue > newGreen) then 
			newGreen = newGreen * .75
			newRed = newRed * .5
		end
		if (newGreen > newRed) and (newGreen > newBlue) then
		end

		self.overlay.spark:SetVertexColor(newRed, newGreen, newBlue)
		self.overlay.spark.glow:SetVertexColor(newRed, newGreen, newBlue)
	end
end

Orb.SetStatusBarTexture = function(self, ...)
	local numArgs = select("#", ...)
	local path, r, g, b, a, id
	if numArgs == 1 then
		path = ...
	elseif numArgs == 2 then
		path, id = ...
	elseif numArgs == 3 then
		r, g, b = ...
	elseif numArgs == 4 then
		r, g, b, a = ...
		if type(a) == "string" then
			id = arg
			a = nil
		elseif type(a) == "number" then
			a = arg
		end
	elseif numArgs == 5 then
		r, g, b, a, id = ...
	end
	id = id or "bar"
	if path then
		self.scaffold[id]:SetTexture(path)
	else
		self.scaffold[id]:SetColorTexture(r, g, b, a)
	end
	--if id == "shade" then
	--	local id = "backgroundShade"
	--	if path then
	--		self.scaffold[id]:SetTexture(path)
	--		self.scaffold[id]:SetVertexColor(0, 0, 0, .75)
	--	else
	--		self.scaffold[id]:SetColorTexture(0, 0, 0, .75)
	--	end
	--end
end

Orb.SetSparkTexture = function(self, path)
	self.overlay.spark:SetTexture(path)
	self:Update()
end

Orb.SetSparkSize = function(self, width, height)
	local spark = self.overlay.spark
	spark._width = width
	spark._height = height
--	spark:SetHeight(height)
	self:Update()
end

Orb.SetSparkOverflow = function(self, overflow)
	self.overlay.spark.overflowWidth = overflow
	self:Update()
end

Orb.SetSparkFlash = function(self, durationIn, durationOut, minAlpha, maxAlpha)
	local spark = self.overlay.spark
	spark.durationIn = durationIn
	spark.durationOut = durationOut
	spark.minAlpha = minAlpha
	spark.maxAlpha = maxAlpha
	spark.flashDirection = "IN"
	spark:SetAlpha(minAlpha)
	spark.glow:SetAlpha(minAlpha)
end

Orb.SetSparkFlashSize = function(self, width, height)
	local glow = self.overlay.spark.glow
	glow._width = width
	glow._height = height
end

Orb.SetSparkFlashTexture = function(self, texture)
	local glow = self.overlay.spark.glow
	glow:SetTexture(texture)
end

Orb.ClearAllPoints = function(self)
	self.scaffold:ClearAllPoints()
end

Orb.SetPoint = function(self, ...)
	self.scaffold:SetPoint(...)
end

Orb.SetAllPoints = function(self, ...)
	self.scaffold:SetAllPoints(...)
end

Orb.GetPoint = function(self, ...)
	return self.scaffold:GetPoint(...)
end

Orb.SetSize = function(self, width, height)
	local leftCrop, rightCrop = self.leftCrop, self.rightCrop
	local crop = leftCrop + rightCrop
	local offset = leftCrop/2 - rightCrop/2

	self.scaffold:SetSize(width, height)
	self.scrollchild:SetSize(width, height)

	local scrollFrame = self.scrollframe
	scrollFrame:SetWidth(width - crop)
	scrollFrame:SetHorizontalScroll(leftCrop)
	scrollFrame:ClearAllPoints()
	scrollFrame:SetPoint("BOTTOM", offset, 0)

	self:Update()
end

Orb.SetWidth = function(self, width)
	local leftCrop, rightCrop = self.leftCrop, self.rightCrop
	local crop = leftCrop + rightCrop
	local offset = leftCrop/2 - rightCrop/2

	self.scaffold:SetWidth(width)
	self.scrollchild:SetWidth(width)

	local scrollFrame = self.scrollframe
	scrollFrame:SetWidth(width - crop)
	scrollFrame:SetHorizontalScroll(leftCrop)
	scrollFrame:ClearAllPoints()
	scrollFrame:SetPoint("BOTTOM", offset, 0)

	self:Update()
end

Orb.SetHeight = function(self, height)
	self.scaffold:SetHeight(height)
	self.scrollchild:SetHeight(height)
	self:Update()
end

Orb.SetParent = function(self, parent)
	self.scaffold:SetParent()
end

Orb.GetValue = function(self)
	return self.value
end

Orb.GetMinMaxValues = function(self)
	return self.minValue, self.maxValue
end

Orb.GetStatusBarColor = function(self, id)
	local colors = self.scaffold and self.scaffold.colors or self.colors
	if id and colors and colors[id] then
	  return colors[id][1], colors[id][2], colors[id][3], colors[id][4]
	elseif colors and colors.smoke then
	  return colors.smoke[1], colors.smoke[2], colors.smoke[3], colors.smoke[4]
	end
end

Orb.GetParent = function(self)
	return self.scaffold and self.scaffold:GetParent()
end

Orb.CreateTexture = function(self, ...)
	self.scaffold:CreateTexture(...)
end

Orb.CreateFontString = function(self, ...)
	self.scaffold:CreateFontString(...)
end

Orb.SetScript = function(self, ...)
	self.scaffold:SetScript(...)
end

Orb.GetScript = function(self, ...)
	return self.scaffold:GetScript(...)
end

Orb.GetObjectType = function(self) return "Orb" end
Orb.IsObjectType = function(self, type) return type == "Orb" end

Orb.Show = function(self) self.scaffold:Show() end
Orb.Hide = function(self) self.scaffold:Hide() end
Orb.IsShown = function(self) return self.scaffold:IsShown() end

Orb.IsForbidden = function(self) return true end

-- proxy method to return the orbs's overlay frame, for adding texts, icons etc
Orb.GetOverlay = function(self) return self.overlay end

-- Fancy method allowing us to crop the orb's sides
Orb.SetCrop = function(self, leftCrop, rightCrop)
	self.leftCrop = leftCrop
	self.rightCrop = rightCrop
	self:SetSize(self.scrollchild:GetSize()) 
end

Orb.GetCrop = function(self)
	return self.leftCrop, self.rightCrop
end

Handler.OnEnable = function(self)

end

Handler.New = function(self, parent, rotateClockwise, speedModifier)

	-- The scaffold is the top level frame object 
	-- that will respond to SetSize, SetPoint and similar.
	local scaffold = CreateFrame("Frame", nil, parent)

	-- The scrollchild is where we put rotating textures that needs to be cropped.
	local scrollchild = CreateFrame("Frame", nil, scaffold)
	scrollchild:SetSize(1,1)

	-- The scrollframe defines the height/filling of the orb.
	local scrollframe = CreateFrame("ScrollFrame", nil, scaffold)
	scrollframe:SetScrollChild(scrollchild)
	scrollframe:SetPoint("BOTTOM")
	scrollframe:SetSize(1,1)

	-- The overlay is meant to hold overlay textures like the spark, glow, etc
	local overlay = CreateFrame("Frame", nil, scaffold)
	overlay:SetFrameLevel(scaffold:GetFrameLevel() + 5)
	overlay:SetAllPoints(scaffold)

	local bar = scrollchild:CreateTexture(nil, "BACKGROUND")
	bar:SetAllPoints()
	
	local moon = scrollchild:CreateTexture(nil, "BORDER")
	moon:SetAllPoints()

	local moonAnimGroup = moon:CreateAnimationGroup()    
	local moonAnim = moonAnimGroup:CreateAnimation("Rotation")
	moonAnim:SetDegrees(rotateClockwise and 360 or -360)
	moonAnim:SetDuration(20 * 1/(speedModifier or 1))
	moonAnimGroup:SetLooping("REPEAT")
	moonAnimGroup:Play()

	local smoke = scrollchild:CreateTexture(nil, "ARTWORK")
	smoke:SetAllPoints()

	local smokeAnimGroup = smoke:CreateAnimationGroup()    
	local smokeAnim = smokeAnimGroup:CreateAnimation("Rotation")
	smokeAnim:SetDegrees(rotateClockwise and -360 or 360)
	smokeAnim:SetDuration(30 * 1/(speedModifier or 1))
	smokeAnimGroup:SetLooping("REPEAT")
	smokeAnimGroup:Play()

	-- We need the shade above the spark, but it still cropped by the scrollframe.
	-- So since sublayers couldn't really be set in WotLK, we need another frame for it.
	local shadeFrame = CreateFrame("Frame", nil, scrollchild)
	shadeFrame:SetAllPoints()

	local shade = shadeFrame:CreateTexture(nil, "OVERLAY")
	shade:SetAllPoints()

	-- Backdrop frame
	local backdropFrame  = CreateFrame("Frame", nil, scaffold)
	backdropFrame:SetFrameLevel(scaffold:GetFrameLevel() - 1)
	backdropFrame:SetAllPoints(scaffold)

	-- We want the backdrops darker, to be easier on the eye on bright backgrounds.
	--local backgroundShade = backdropFrame:CreateTexture(nil, "BACKGROUND")
	--backgroundShade:SetAllPoints()

	local spark = scrollchild:CreateTexture(nil, "OVERLAY")
	spark:SetPoint("CENTER", scrollframe, "TOP", 0, -1)
	spark:SetSize(1,1)
	spark:SetAlpha(.35)
	spark._height = 1
	spark._width = 1
	spark.overflowWidth = 0 
	spark.flashDirection = "IN"
	spark.durationIn = .75 -- 2.75
	spark.durationOut = .55 -- 1.25
	spark.minAlpha = .35
	spark.maxAlpha = .85

	local glow = overlay:CreateTexture(nil, "ARTWORK")
	glow:SetPoint("CENTER", scrollframe, "TOP", 0, -1)
	glow:SetSize(1, 1)
	glow._width = 1
	glow._height = 1
	spark.glow = glow

	overlay.spark = spark

	scaffold.bar = bar
	scaffold.moon = moon
	scaffold.smoke = smoke
	scaffold.shade = shade
	--scaffold.backgroundShade = backgroundShade -- not part of the layer cache, still grabs the same texture as 'shade', though'
	scaffold.layers = { bar, moon, smoke, shade }
	scaffold.colors = {
		bar = { .6, .6, .6, 1 },
		smoke = { .6, .6, .6, .9 },
		moon = { .6, .6, .6, .5 },
		shade = { .1, .1, .1, 1 }
	}

	-- The orb is the virtual object that we return to the user.
	-- This contains all the methods.
	local orb = Engine:CreateFrame("Frame", nil, scaffold)
	orb:SetAllPoints() -- lock down the points before we overwrite the methods

	setmetatable(orb, Orb_MT)

	orb.minValue = 0
	orb.maxValue = 1
	orb.value = 0
	orb.displayValue = 0
	orb.leftCrop = 0
	orb.rightCrop = 0

	-- I usually don't like exposing things like this to the user, 
	-- but we're going for maximum performance here. 
	orb.overlay = overlay
	orb.scrollchild = scrollchild
	orb.scrollframe = scrollframe
	orb.scaffold = scaffold
	
	orb:Update()

	return orb
end
