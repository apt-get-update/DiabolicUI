--[[
	The MIT License (MIT)
	Copyright (c) 2017 Lars "Goldpaw" Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]--

-- Small WotLK 3.3.5 helpers shared by the rest of the addon. They live on
-- the addon's private Engine table, never in the global namespace: other
-- addons use the presence of newer API names to detect the client version.
local _, Engine = ...

-- WoW API
local UnitIsFriend = _G.UnitIsFriend
local UnitIsTapped = _G.UnitIsTapped
local UnitIsTappedByAllThreatList = _G.UnitIsTappedByAllThreatList
local UnitIsTappedByPlayer = _G.UnitIsTappedByPlayer
local UnitPlayerControlled = _G.UnitPlayerControlled

-- True when someone outside your group tagged the unit, so you won't get
-- loot or credit from it (grayed-out health bars).
Engine.UnitIsTapDenied = function(unit)
	return UnitIsTapped(unit) and not(UnitPlayerControlled(unit) or UnitIsTappedByPlayer(unit) or UnitIsTappedByAllThreatList(unit) or UnitIsFriend("player", unit))
end

-- /rl, /reload and /reloadui
_G.SLASH_RELOADUI1 = "/rl"
_G.SLASH_RELOADUI2 = "/reload"
_G.SLASH_RELOADUI3 = "/reloadui"
_G.SlashCmdList.RELOADUI = _G.ReloadUI
