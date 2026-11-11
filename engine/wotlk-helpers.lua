--[[
	The MIT License (MIT)
	Copyright (c) 2017 Lars "Goldpaw" Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]
--

-- Small WotLK 3.3.5 helpers shared by the rest of the addon. They live on
-- the addon's private Engine table, never in the global namespace: other
-- addons use the presence of newer API names to detect the client version.
local _, Engine = ...

-- Lua API
local ipairs = ipairs
local math_floor = math.floor
local table_concat = table.concat
local unpack = unpack

-- WoW API
local UnitIsFriend = _G.UnitIsFriend
local UnitIsTapped = _G.UnitIsTapped
local UnitIsTappedByAllThreatList = _G.UnitIsTappedByAllThreatList
local UnitIsTappedByPlayer = _G.UnitIsTappedByPlayer
local UnitPlayerControlled = _G.UnitPlayerControlled

-- True when someone outside your group tagged the unit, so you won't get
-- loot or credit from it (grayed-out health bars).
Engine.UnitIsTapDenied = function(unit)
	return UnitIsTapped(unit)
		and not (
			UnitPlayerControlled(unit)
			or UnitIsTappedByPlayer(unit)
			or UnitIsTappedByAllThreatList(unit)
			or UnitIsFriend("player", unit)
		)
end

-- Money in our coins (settings/ui.lua), COIN_SIZE tall, the coins of 0
-- left out: "1[gold] 25[copper]" (Blizzard's GetCoinTextureString in ours).
local COINS = { { "gold", 10000 }, { "silver", 100 }, { "copper", 1 } }
local COIN_CANVAS = 64 -- the coins' texture: its coords in pixels in the escape
local COIN_SIZE = 16 -- (round, at the text's height they read as dots)
local CoinIcon = function(kind)
	local coin = Engine:GetDB("UI").coin
	local l, r, t, b = unpack(coin[kind .. "_texcoord"])
	return ("|T%s:%d:%d:2:0:%d:%d:%d:%d:%d:%d|t"):format(
		coin[kind .. "_texture"],
		COIN_SIZE,
		COIN_SIZE,
		COIN_CANVAS,
		COIN_CANVAS,
		l * COIN_CANVAS,
		r * COIN_CANVAS,
		t * COIN_CANVAS,
		b * COIN_CANVAS
	)
end

Engine.CoinString = function(amount)
	local parts = {}
	for _, kind in ipairs(COINS) do
		local count = math_floor(amount / kind[2])
		amount = amount - count * kind[2]
		if count > 0 then
			parts[#parts + 1] = count .. CoinIcon(kind[1])
		end
	end
	return (parts[1] and table_concat(parts, " ")) or ("0" .. CoinIcon("copper"))
end

-- `text` with Blizzard's coin icons (GOLD_AMOUNT_TEXTURE and the others:
-- GetCoinTextureString's, Postal's) as ours.
Engine.OurCoins = function(text)
	return (
		text:gsub("|TInterface\\MoneyFrame\\UI%-(%a+)Icon[^|]*|t", function(kind)
			kind = kind:lower()
			if (kind == "gold") or (kind == "silver") or (kind == "copper") then
				return CoinIcon(kind)
			end
		end)
	)
end

-- /rl, /reload and /reloadui
_G.SLASH_RELOADUI1 = "/rl"
_G.SLASH_RELOADUI2 = "/reload"
_G.SLASH_RELOADUI3 = "/reloadui"
_G.SlashCmdList.RELOADUI = _G.ReloadUI
