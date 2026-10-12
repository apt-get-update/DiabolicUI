--[[

	The MIT License (MIT)

	Copyright (c) 2023 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
local Addon, ns = ..., DiabolicUIMinimapNS
ns = LibStub("AceAddon-3.0"):NewAddon(ns, Addon, "AceConsole-3.0")
ns.Hider = CreateFrame("Frame"); ns.Hider:Hide()
ns.Noop = function() end

-- The minimap's 100% size, from the original Diabolic one (it was .64
-- for a while: sizes saved then convert back).
ns.SIZE_BASE = .8

-- Default settings
local defaults = {
	global = {
		core = {
			relativeScale = 1
		},
		minimap = {
			useServerTime = false,
			userScale = 1, -- of the size below (what 80% used to be)
			zoneFadeEnabled = true,
			zoneFadeDuration = .25 -- seconds each half (out, then in) of the zone label's crossfade takes
		}
	}
}

-- Lua API
local math_max = math.max
local math_min = math.min
local next = next
local string_lower = string.lower
local tonumber = tonumber

-- WoW API
local EnableAddOn = EnableAddOn
local DisableAddOn = DisableAddOn
local InCombatLockdown = InCombatLockdown
local ReloadUI = ReloadUI

-- Addon API
local IsAddOnAvailable = ns.API.IsAddOnAvailable
local SetRelativeScale = ns.API.SetRelativeScale


local LimitScale = function(scale)
	return math_min(1.5, math_max(.5, scale))
end

-- Keeps the relative scale within bounds.
local SanitizeSettings = function(db)
	local scale = db.global.core.relativeScale
	if (scale) then
		db.global.core.relativeScale = LimitScale(scale)
	end
	return db
end

-- Stores and applies a new relative scale.
local ApplyRelativeScale = function(self, scale)
	self.db.global.core.relativeScale = scale
	SetRelativeScale(scale)
	self:GetModule("Minimap"):UpdateSize()
end

-- /resetscale
ns.ResetScale = function(self)
	if (InCombatLockdown()) then
		return
	end
	local defaultScale = defaults.global.core.relativeScale
	if (self.db.global.core.relativeScale ~= defaultScale) then
		ApplyRelativeScale(self, defaultScale)
	end
end

-- /setscale 0.5-1.5
ns.SetScale = function(self, input)
	if (InCombatLockdown()) then
		return
	end
	local scale = tonumber((self:GetArgs(string_lower(input))))
	if (scale) then
		-- Sanitize it, don't want crazy values
		scale = LimitScale(scale)
		if (self.db.global.core.relativeScale ~= scale) then
			ApplyRelativeScale(self, scale)
		end
	end
end

-- /go and /switchto: switches to another of Goldpaw's UIs.
ns.SwitchUI = function(self, input)
	if (not self._ui_list) then
		-- Create a list of currently installed UIs.
		self._ui_list = {}
		for ui, cmds in next, {
			["AzeriteUI"]   = { "azerite", "azui" },
			["DiabolicUI2"] = { "diabolic", "diablo", "dui" },
			["GoldpawUI"]   = { "goldpaw", "gui" },
			["JourneyUI"]   = { "journey", "jui" }
		} do
			-- Only include existing UIs that can be switched to.
			if (IsAddOnAvailable(ui)) then
				for _, cmd in next, cmds do
					self._ui_list[cmd] = ui
				end
			end
		end
	end
	local arg = self:GetArgs(string_lower(input))
	local target = arg and self._ui_list[arg]
	if (target) then
		EnableAddOn(target)      -- Enable the desired UI
		for cmd, ui in next, self._ui_list do
			if (ui ~= target) then -- Don't disable target UI
				DisableAddOn(ui) -- Disable all other UIs
			end
		end
		DisableAddOn(Addon) -- Disable the current UI
		ReloadUI()    -- Reload interface to the selected UI
	end
end

ns.OnInitialize = function(self)
	self.db = SanitizeSettings(LibStub("AceDB-3.0"):New("DiabolicUI_Minimap_DB", defaults, true))

	-- The size's 100% has changed (to 80%, briefly to 80% of that): a size
	-- chosen before keeps its size on screen, in the new percentages.
	-- "sizeBase" is the 100% a saved size counts from. (AceDB fills in the
	-- defaults, and old defaults were never saved: 1 is always the new one.)
	local minimap = self.db.global.minimap
	local base = minimap.sizeBase or (minimap.sizeRebased and .8) or 1
	if (base ~= ns.SIZE_BASE) then
		if (minimap.userScale ~= 1) then
			minimap.userScale = math.floor(minimap.userScale * base / ns.SIZE_BASE * 100 + .5) / 100
		end
		minimap.sizeBase = ns.SIZE_BASE
		minimap.sizeRebased = nil
	end
	-- within the slider's range
	local config = ns.Config.Minimap
	minimap.userScale = math_min(config.MaxUserScale, math_max(config.MinUserScale, minimap.userScale))

	-- Apply user scale to all elements
	SetRelativeScale(self.db.global.core.relativeScale)

	-- Add a command to clear all chat frames.
	-- I mainly use this to remove clutter before taking screenshots.
	-- You could theoretically put this in a macro and clear chat then screenshot.
	self:RegisterChatCommand("clear", function()
		for _, frameName in pairs(_G.CHAT_FRAMES) do
			local frame = _G[frameName]
			if (frame:IsShown()) then
				frame:Clear()
			end
		end
	end)

	-- Our UI switcher. Because I have many. And use them all.
	self:RegisterChatCommand("go", "SwitchUI")
	self:RegisterChatCommand("switchto", "SwitchUI")

	-- Fully experimental
	self:RegisterChatCommand("setscale", "SetScale")
	self:RegisterChatCommand("resetscale", "ResetScale")
end
