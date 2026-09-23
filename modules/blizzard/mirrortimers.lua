local _, Engine = ...
local Module = Engine:NewModule("Blizzard: MirrorTimers")
local C = Engine:GetDB("Data: Colors")

-- Lua API
local _G = _G
local math_floor = math.floor
local table_insert = table.insert
local table_sort = table.sort
local table_wipe = table.wipe
local unpack = unpack

-- WoW API
local hooksecurefunc = hooksecurefunc

local sort = function(a, b)
	if a.type == b.type then
		return a.id < b.id -- same type, order by their id
	else
		return a.type == "mirror" -- different type, so we want any mirrors first
	end
end

Module.UpdateTimer = function(self, frame)
	local timer = self.timers[frame]
	local min, max = timer.bar:GetMinMaxValues()
	local value = timer.bar:GetValue()
	if (not min) or (not max) or (not value) then
		return
	end
	if value > max then
		value = max
	elseif value < min then
		value = min
	end
	timer.bar:GetStatusBarTexture():SetTexCoord(0, (value-min)/(max-min), 0, 1) -- cropping, not shrinking
end

-- These aren't secure, no? So it's safe to move whenever?
Module.UpdateAnchors = function(self)
	local config = self.config
	local timers = self.timers
	local order = self.order or {}

	table_wipe(order)
	
	-- parse mirror timers	
	for frame,timer in pairs(timers) do
		frame:ClearAllPoints() -- clear points of hidden too
		if frame:IsShown() then
			table_insert(order, timer) -- only include visible timers
		end
	end	
	
	-- sort and arrange visible timers
	if #order > 0 then
		table_sort(order, sort) -- sort by type -> id
		order[1].frame:SetPoint(unpack(self.captureBarVisible and config.position or config.positionOffsetByOne))
		if #order > 1 then
			for i = 2, #order do
				order[i].frame:SetPoint("CENTER", order[i-1].frame, "CENTER", 0, -config.padding)
			end
		end
	end
end

Module.Skin = function(self, frame)
	local config = self.config

	local timer = self.timers[frame]

	timer.frame:SetFrameLevel(timer.frame:GetFrameLevel() + 10)

	timer.backdropFrame = timer.backdropFrame or CreateFrame("Frame", nil, timer.bar)
	timer.backdropFrame:SetAllPoints()
	timer.backdropFrame:SetFrameLevel(timer.frame:GetFrameLevel() - 10)

	timer.backdropFrame.texture = timer.backdropFrame:CreateTexture()
	timer.backdropFrame.texture:SetDrawLayer("BACKGROUND")
	timer.backdropFrame.texture:SetPoint(unpack(config.texture_position))
	timer.backdropFrame.texture:SetSize(unpack(config.texture_size))
	timer.backdropFrame.texture:SetTexture(config.backdrop_texture)

	timer.bar:SetStatusBarTexture(config.statusbar_texture)
	timer.bar:SetFrameLevel(timer.frame:GetFrameLevel() + 5)

	timer.spark = timer.spark or timer.bar:CreateTexture()
	timer.spark:SetDrawLayer("OVERLAY") -- needs to be OVERLAY, as ARTWORK will sometimes be behind the bars
	timer.spark:SetPoint("CENTER", timer.bar:GetStatusBarTexture(), "RIGHT", 0, 0)
	timer.spark:SetSize(config.spark_size[1], timer.bar:GetHeight() + 2)
	timer.spark:SetTexture(config.spark_texture)

	timer.borderFrame = timer.borderFrame or CreateFrame("Frame", nil, timer.bar)
	timer.borderFrame:SetAllPoints()
	timer.borderFrame:SetFrameLevel(timer.frame:GetFrameLevel() + 10)

	timer.border:SetParent(timer.borderFrame)
	timer.border:ClearAllPoints()
	timer.border:SetPoint(unpack(config.texture_position))
	timer.border:SetSize(unpack(config.texture_size))
	timer.border:SetTexture(config.texture)

	timer.msg:SetParent(timer.borderFrame)
	timer.msg:ClearAllPoints()
	timer.msg:SetPoint("CENTER", 0, 0)
	timer.msg:SetFontObject(config.font_object)
	
	hooksecurefunc(timer.bar, "SetValue", function(...) self:UpdateTimer(frame) end)
	hooksecurefunc(timer.bar, "SetMinMaxValues", function(...) self:UpdateTimer(frame) end)
	
	self:UpdateAnchors()
end


Module.MirrorTimer_Show = function(self, timer, value, maxvalue, scale, paused, label)
	local timers = self.timers
	for i = 1, MIRRORTIMER_NUMTIMERS do
		local frame = _G["MirrorTimer"..i]
		if frame and (not timers[frame]) then
			timers[frame] = {}
			timers[frame].frame = frame
			timers[frame].bar = _G[frame:GetName().."StatusBar"]
			timers[frame].msg = _G[frame:GetName().."Text"] or _G[frame:GetName().."StatusBarTimeText"]
			timers[frame].border = _G[frame:GetName().."Border"] or _G[frame:GetName().."StatusBarBorder"]
			timers[frame].type = "mirror"
			timers[frame].id = i
			self:Skin(frame)
		end
		if frame:IsShown() and timer and frame.timer == timer then
			local color = C.Timer[frame.timer]
			if color then
				timers[frame].bar:SetStatusBarColor(unpack(color))
			end
		end
	end
	self:UpdateAnchors()
end

Module.CaptureBarVisible = function(self)
	self.captureBarVisible = true
end

Module.CaptureBarHidden = function(self)
	self.captureBarVisible = nil
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").mirrortimers
	self.timers = {}
	
	if MirrorTimer_Show then
		hooksecurefunc("MirrorTimer_Show", function(...) self:MirrorTimer_Show(...) end)
	end
	
	self:RegisterMessage("ENGINE_CAPTUREBAR_VISIBLE", "CaptureBarVisible")
	self:RegisterMessage("ENGINE_CAPTUREBAR_HIDDEN", "CaptureBarHidden")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAnchors")
end

