-- "Orb" handler: the round health and power globes. Handler:New(parent)
-- returns an object that behaves like a StatusBar (SetValue, SetMinMaxValues,
-- SetStatusBarColor, ...) but fills a circle from the bottom, with smoothing,
-- rotating layers and a spark riding the fluid surface.
local _, Engine = ...
local Handler = Engine:NewHandler("Orb")

-- Lua API
local _G = _G
local math_abs = math.abs
local math_max = math.max
local math_min = math.min
local math_sqrt = math.sqrt
local pairs = pairs
local select = select
local setmetatable = setmetatable
local type = type

-- WoW API
local CreateFrame = _G.CreateFrame

local Orb = CreateFrame("Frame")
local Orb_MT = { __index = Orb }

-- How bright each layer is drawn when one color is given for them all
-- (SetStatusBarColor(r, g, b, "ALL")). These are the factors the hand-picked
-- orb colors in data/colors.lua started from.
local SHADES = { bar = 1/4, moon = 1/2, smoke = 1, shade = 1/10 }


-- The spark and its glow pulse in a looping alpha animation the client
-- plays by itself, so an orb that holds still runs no Lua at all.
local SetPulse = function(spark)
	local range = spark.maxAlpha - spark.minAlpha
	for _, texture in pairs({ spark, spark.glow }) do
		texture:SetAlpha(spark.minAlpha)
		texture.pulseIn:SetDuration(spark.durationIn)
		texture.pulseIn:SetChange(range)
		texture.pulseOut:SetDuration(spark.durationOut)
		texture.pulseOut:SetChange(-range)
	end
end

local CreatePulse = function(texture)
	texture.pulse = texture:CreateAnimationGroup()
	texture.pulse:SetLooping("REPEAT")
	texture.pulseIn = texture.pulse:CreateAnimation("Alpha")
	texture.pulseIn:SetOrder(1)
	texture.pulseOut = texture.pulse:CreateAnimation("Alpha")
	texture.pulseOut:SetOrder(2)
end

Orb.Update = function(self)
	local value = self._ignoresmoothing and self.value or self.smoothing and self.displayValue or self.value
	local min, max = self.minValue, self.maxValue
	local width, height = self.scaffold:GetSize()
	local spark = self.overlay.spark
	-- (SetValue and SetMinMaxValues keep both values in range)

	-- The fluid and the spark only need placing again when the value or the
	-- shape changed.
	local laid = self._laid
	local glow = spark.glow
	local changed = (value ~= laid.value) or (min ~= laid.min) or (max ~= laid.max) or (width ~= laid.width) or (height ~= laid.height)
		or (self.leftCrop ~= laid.leftCrop) or (self.rightCrop ~= laid.rightCrop) or (spark._height ~= laid.sparkHeight) or (glow._height ~= laid.glowHeight)
	if changed then
		laid.value, laid.min, laid.max, laid.width, laid.height = value, min, max, width, height
		laid.leftCrop, laid.rightCrop, laid.sparkHeight, laid.glowHeight = self.leftCrop, self.rightCrop, spark._height, glow._height
	end

	local newHeight = (max > min) and (value-min)/(max-min) * height or 0

	if value <= min or max == min then
		-- empty: no fluid at all, rather than a sliver of it
		self.scrollframe:Hide()
		laid.value = nil -- placed again once it shows
	elseif changed then
		self.scrollframe:SetHeight(math_max(newHeight, 0.0001)) -- (WoW takes a size of 0 as no size set at all)
		self.scrollframe:SetVerticalScroll(height - newHeight)
		
		if not self.scrollframe:IsShown() then
			self.scrollframe:Show()
		end
	end
	
	if value == max or value == min then
		if spark:IsShown() then
			spark:Hide()
			spark.pulse:Stop()
			glow:Hide()
			glow.pulse:Stop()
		end
	else
		if changed then
			-- freaking pythagoras
			--	r^2 = x^2 + y^2
			--	x^2 = r^2 - y^2
			--	x = sqrt(r^2 - y^2)
			local y = math_abs(height/2 - newHeight)
			local r = height/2
			local x = math_sqrt(r^2 - y^2) * 2 -- never 0: neither empty nor full here
			local sparkWidth = x
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
			spark:SetPoint(sparkPoint, scrollframe, sparkAnchor, 0, -1)
			spark:SetSize(sparkWidth, sparkHeight)

			glow:SetTexCoord(texLeft, texRight, 0, 1)
			glow:ClearAllPoints()
			glow:SetPoint(sparkPoint, scrollframe, sparkAnchor, 0, -1)
			glow:SetSize(sparkWidth, sparkHeight/spark._height * spark.glow._height)
		end

		if not spark:IsShown() then
			spark:Show()
			glow:Show()
		end
		if not spark.pulse:IsPlaying() then
			-- together, so the spark and its glow stay in step
			spark.pulse:Play()
			glow.pulse:Stop()
			glow.pulse:Play()
		end
	end
end

local smoothMinValue = 1 -- if a value is lower than this, we won't smoothe
local smoothHZ = .2 -- each frame closes elapsed/smoothHZ of the gap
local smoothLimit = 1/120 -- max updates per second
local smoothFinish = 1/1000 -- the last bit of the gap (a share of the range) is jumped
-- Runs only while the shown value slides towards the real one.
Orb.OnUpdate = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < smoothLimit then
		return
	else
		self.elapsed = 0
	end
	if self.smoothing and not self._ignoresmoothing then
		local goal = self.value
		local display = self.displayValue
		-- Closing a share of the gap every frame never quite gets there,
		-- so the last bit is jumped (and so is all of it from nothing).
		local nextDisplay = display + (goal - display) * math_min(elapsed/smoothHZ, 1)
		if (display < smoothMinValue) or (math_abs(goal - nextDisplay) <= (self.maxValue - self.minValue) * smoothFinish) then
			self.displayValue = goal
			self.smoothing = nil
		else
			self.displayValue = nextDisplay
		end
	else
		self.displayValue = self.value
		self.smoothing = nil
	end
	if not self.smoothing then
		self.scaffold:SetScript("OnUpdate", nil)
	end
	self:Update()
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
	self.value = value
	if value ~= self.displayValue then
		self.smoothing = true
	end
	if self._ignoresmoothing then
		self.displayValue = value
		self.smoothing = nil
	elseif self.smoothing then
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

	id = id or "bar"

	if id == "ALL" then
		for layerID, colorTable in pairs(colors) do
			local factor = SHADES[layerID]
			colorTable[1] = r * factor
			colorTable[2] = g * factor
			colorTable[3] = b * factor
			if a then 
				colorTable[4] = a
			end
			scaffold[layerID]:SetVertexColor(colorTable[1], colorTable[2], colorTable[3], colorTable[4])
		end
	else
		local colorTable = colors[id]
		colorTable[1] = r
		colorTable[2] = g
		colorTable[3] = b
		if a then
			colorTable[4] = a
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
		if type(a) == "string" then -- r, g, b, id
			id, a = a, nil
		end
	elseif numArgs == 5 then
		r, g, b, a, id = ...
	end
	id = id or "bar"
	if path then
		self.scaffold[id]:SetTexture(path)
	else
		self.scaffold[id]:SetTexture(r, g, b, a)
	end
end

Orb.SetSparkTexture = function(self, path)
	self.overlay.spark:SetTexture(path)
	self._laid.value = nil
	self:Update()
end

-- Only the height counts: the spark is as wide as the fluid's surface.
Orb.SetSparkSize = function(self, width, height)
	self.overlay.spark._height = height
	self:Update()
end

Orb.SetSparkFlash = function(self, durationIn, durationOut, minAlpha, maxAlpha)
	local spark = self.overlay.spark
	spark.durationIn = durationIn
	spark.durationOut = durationOut
	spark.minAlpha = minAlpha
	spark.maxAlpha = maxAlpha
	SetPulse(spark)
	if spark.pulse:IsPlaying() then
		spark.pulse:Stop()
		spark.glow.pulse:Stop()
		spark.pulse:Play()
		spark.glow.pulse:Play()
	end
end

-- Only the height counts, as for the spark.
Orb.SetSparkFlashSize = function(self, width, height)
	self.overlay.spark.glow._height = height
end

Orb.SetSparkFlashTexture = function(self, texture)
	local glow = self.overlay.spark.glow
	glow:SetTexture(texture)
	self._laid.value = nil
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
	self.scaffold:SetParent(parent)
end

Orb.GetValue = function(self)
	return self.value
end

Orb.GetMinMaxValues = function(self)
	return self.minValue, self.maxValue
end

-- The color of a layer, the smoke's by default (the orb's main color).
Orb.GetStatusBarColor = function(self, id)
	local color = self.scaffold.colors[id or "smoke"]
	return color[1], color[2], color[3], color[4]
end

Orb.GetParent = function(self)
	return self.scaffold and self.scaffold:GetParent()
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

-- proxy method to return the orbs's overlay frame, for adding texts, icons etc
Orb.GetOverlay = function(self) return self.overlay end

-- Fancy method allowing us to crop the orb's sides
Orb.SetCrop = function(self, leftCrop, rightCrop)
	self.leftCrop = leftCrop
	self.rightCrop = rightCrop
	self:SetSize(self.scrollchild:GetSize()) 
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

	local spark = scrollchild:CreateTexture(nil, "OVERLAY")
	spark:SetPoint("CENTER", scrollframe, "TOP", 0, -1)
	spark:SetSize(1,1)
	spark._height = 1
	spark.durationIn = .75
	spark.durationOut = .55
	spark.minAlpha = .35
	spark.maxAlpha = .85

	local glow = overlay:CreateTexture(nil, "ARTWORK")
	glow:SetPoint("CENTER", scrollframe, "TOP", 0, -1)
	glow:SetSize(1, 1)
	glow._height = 1
	spark.glow = glow

	CreatePulse(spark)
	CreatePulse(glow)
	SetPulse(spark)

	overlay.spark = spark

	scaffold.bar = bar
	scaffold.moon = moon
	scaffold.smoke = smoke
	scaffold.shade = shade
	scaffold.colors = {
		bar = { .6, .6, .6, 1 },
		smoke = { .6, .6, .6, .9 },
		moon = { .6, .6, .6, .5 },
		shade = { .1, .1, .1, 1 }
	}

	-- The orb is the virtual object that we return to the user.
	-- This contains all the methods. As an engine frame it also has the
	-- engine's CreateFrame, CreateTexture, ... : what's made with them
	-- sits on the orb frame, above the scaffold.
	local orb = Engine:CreateFrame("Frame", nil, scaffold)
	orb:SetAllPoints() -- lock down the points before we overwrite the methods

	setmetatable(orb, Orb_MT)

	orb.minValue = 0
	orb.maxValue = 1
	orb.value = 0
	orb.displayValue = 0
	orb.leftCrop = 0
	orb.rightCrop = 0
	orb._laid = {} -- what Update last placed

	-- I usually don't like exposing things like this to the user, 
	-- but we're going for maximum performance here. 
	orb.overlay = overlay
	orb.scrollchild = scrollchild
	orb.scrollframe = scrollframe
	orb.scaffold = scaffold
	
	orb:Update()

	return orb
end
