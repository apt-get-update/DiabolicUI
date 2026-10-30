-- /dui cpu [seconds]: measures for a few seconds which functions use the
-- CPU (DiabolicUI's, and every frame's OnUpdate and OnEvent scripts), and
-- prints the busiest in the chat. Needs the client's script profiling (the
-- scriptProfile CVar) on.
local ADDON, Engine = ...
local Handler = Engine:NewHandler("Profiler")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local coroutine_create = coroutine.create
local ipairs = ipairs
local math_min = math.min
local next = next
local pairs = pairs
local pcall = pcall
local rawget = rawget
local string_format = string.format
local table_sort = table.sort
local tonumber = tonumber
local tostring = tostring
local type = type

-- WoW API
local CreateFrame = _G.CreateFrame
local EnumerateFrames = _G.EnumerateFrames
local GetAddOnCPUUsage = _G.GetAddOnCPUUsage
local GetCVar = _G.GetCVar
local GetFunctionCPUUsage = _G.GetFunctionCPUUsage
local UpdateAddOnCPUUsage = _G.UpdateAddOnCPUUsage

local TOP = 15 -- lines printed
local DEPTH = 3 -- how far into the objects' tables frames and functions are looked for
local SCRIPTS = { "OnUpdate", "OnEvent" }

local Print = function(msg)
	_G.DEFAULT_CHAT_FRAME:AddMessage(msg)
end

-- The client crashes when asked for the time of one of its own C functions
-- (GetFunctionCPUUsage), or of some frames (GetFrameCPUUsage, so that one
-- isn't used at all). A coroutine can only be made from a Lua function, and
-- making one runs nothing.
local IsLuaFunction = function(func)
	return type(func) == "function" and (pcall(coroutine_create, func))
end

local IsFrame = function(value)
	return type(rawget(value, 0)) == "userdata"
end

-- Names the functions to time: event handlers after their event
-- ("Nameplates UNIT_AURA"), what the engine's objects keep after where they
-- keep it ("Unitframes: Player.Left.Update"), then every frame's scripts
-- ("Unit: Player.Left OnUpdate").
local Collect = function()
	local objectName, events = Engine:GetRegistries()
	local functions, frames, seen = {}, {}, {}
	local Add = function(func, label)
		if (not functions[func]) and IsLuaFunction(func) then
			functions[func] = label
		end
	end

	for event, registry in pairs(events) do
		for object, list in pairs(registry) do
			local name = objectName[object] or "Engine"
			for _, func in ipairs(list) do
				if type(func) == "string" then
					func = object[func]
				end
				Add(func, name .. " " .. event)
			end
		end
	end

	local walk
	walk = function(value, label, depth)
		if seen[value] then
			return
		end
		seen[value] = true
		if IsFrame(value) then
			frames[value] = label
		end
		for key, field in next, value do
			if type(field) == "function" then
				Add(field, label .. "." .. tostring(key))
			elseif type(field) == "table" and depth < DEPTH then
				walk(field, label .. "." .. tostring(key), depth + 1)
			end
		end
	end
	for object, name in pairs(objectName) do
		walk(object, name, 1)
	end

	-- A frame's name, or the nearest parent we can name.
	local Describe = function(frame)
		local name = frames[frame] or frame:GetName()
		if name then
			return name
		end
		local parent = frame:GetParent()
		while parent do
			local parentName = (parent == Engine:GetFrame() and "UICenter") or frames[parent] or parent:GetName()
			if parentName then
				return string_format("(%s in %s)", frame:GetObjectType(), parentName)
			end
			parent = parent:GetParent()
		end
		return string_format("(%s without a parent)", frame:GetObjectType())
	end
	local frame = EnumerateFrames()
	while frame do
		for _, script in ipairs(SCRIPTS) do
			local ok, func = pcall(frame.GetScript, frame, script)
			if ok and func and not functions[func] then
				Add(func, Describe(frame) .. " " .. script)
			end
		end
		frame = EnumerateFrames(frame)
	end

	return functions
end

local Snapshot = function(functions)
	local used = {}
	for func in pairs(functions) do
		used[func] = GetFunctionCPUUsage(func, true)
	end
	UpdateAddOnCPUUsage()
	return used, GetAddOnCPUUsage(ADDON)
end

Handler.Measure = function(self, seconds)
	if GetCVar("scriptProfile") ~= "1" then
		Print(L["Turn on the CPU profiling first: /console scriptProfile 1, then /reload. Turn it off the same way afterwards (0), it slows the game down."])
		return
	end
	if self.timer and self.timer:IsShown() then
		return
	end

	local functions = Collect()
	local before, addonBefore = Snapshot(functions)

	Print(string_format(L["Measuring DiabolicUI's CPU use for %d seconds..."], seconds))
	self.timer = self.timer or CreateFrame("Frame")
	self.timer.left = seconds
	self.timer:SetScript("OnUpdate", function(timer, elapsed)
		timer.left = timer.left - elapsed
		if timer.left > 0 then
			return
		end
		timer:Hide()
		local after, addonAfter = Snapshot(functions)
		local rows = {}
		for func, start in pairs(before) do
			local used = after[func] - start
			if used > 0 then
				rows[#rows + 1] = { functions[func], used / seconds }
			end
		end
		table_sort(rows, function(a, b) return a[2] > b[2] end)
		Print(string_format(L["DiabolicUI used %.2f ms per second. The busiest functions, with what they call (ms per second):"], (addonAfter - addonBefore) / seconds))
		for i = 1, math_min(TOP, #rows) do
			Print(string_format("  %.2f  %s", rows[i][2], rows[i][1]))
		end
	end)
	self.timer:Show()
end

Handler.OnEnable = function(self)
	self:GetHandler("ChatCommand"):Register("cpu", function(seconds)
		self:Measure(tonumber(seconds) or 10)
	end)
end
