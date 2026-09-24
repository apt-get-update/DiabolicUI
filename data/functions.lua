local _, Engine = ...
local C = Engine:GetDB("Data: Colors")
local F = {}


-- Lua API
local math_floor = math.floor
local tonumber = tonumber
local tostring = tostring
local type = type
local unpack = unpack

-- Get the current client locale
local gameLocale = GetLocale()



-- Number abbreviations
---------------------------------------------------------------------	
F.Short = (gameLocale == "zhCN") and function(value)
	value = tonumber(value)
	if not value then return "" end
	if value >= 1e8 then
		return ("%.1f亿"):format(value / 1e8):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e4 or value <= -1e3 then
		return ("%.1f万"):format(value / 1e4):gsub("%.?0+([km])$", "%1")
	else
		return tostring(math_floor(value))
	end 
end

or function(value)
	value = tonumber(value)
	if not value then return "" end
	if value >= 1e9 then
		return ("%.1fb"):format(value / 1e9):gsub("%.?0+([kmb])$", "%1")
	elseif value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([kmb])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([kmb])$", "%1")
	else
		return tostring(math_floor(value))
	end	
end


-- Colorize a piece of text with the given color
---------------------------------------------------------------------
F.Colorize = function(str, ...)
	local r, g, b = ...
	if type(r) == "table" then
		r, g, b = unpack(r)
	elseif type(r) == "string" then
		r, g, b = unpack(C.General[r])
	end
	return ("|cff%02X%02X%02X%s|r"):format(math_floor(r*255), math_floor(g*255), math_floor(b*255), str or "")
end



-- Money with coin icons ("12[g] 34[s] 56[c]"), leaving out leading zero
-- denominations. The icons come from the shared coin style in
-- settings/ui.lua, built on first use since settings load after data.
-- yOffset (optional) moves the coins up or down, to center them on text
-- of a different size than the micro menu's gold counter they're tuned for.
---------------------------------------------------------------------
local coinIconSets = {}

local BuildCoinIcon = function(texture, texcoord, size, offset)
	local width, height = size[1], size[2]
	local atlasSize = 64 -- the texcoords are fractions of this
	local left, right = texcoord[1] * atlasSize, texcoord[2] * atlasSize
	local top, bottom = texcoord[3] * atlasSize, texcoord[4] * atlasSize
	return ("|T%s:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d|t"):format(texture, height, width, offset[1], offset[2], atlasSize, atlasSize, left, right, top, bottom)
end

F.Money = function(money, yOffset)
	local coin = Engine:GetDB("UI").coin
	yOffset = yOffset or coin.coin_offset[2]
	local coinIcons = coinIconSets[yOffset]
	if (not coinIcons) then
		local offset = { coin.coin_offset[1], yOffset }
		coinIcons = {
			gold = BuildCoinIcon(coin.gold_texture, coin.gold_texcoord, coin.gold_size, offset),
			silver = BuildCoinIcon(coin.silver_texture, coin.silver_texcoord, coin.silver_size, offset),
			copper = BuildCoinIcon(coin.copper_texture, coin.copper_texcoord, coin.copper_size, offset)
		}
		coinIconSets[yOffset] = coinIcons
	end
	money = math_floor(tonumber(money) or 0)
	local gold = math_floor(money / 10000)
	local silver = math_floor((money / 100) % 100)
	local copper = money % 100
	if (gold > 0) then
		return ("%d%s %d%s %d%s"):format(gold, coinIcons.gold, silver, coinIcons.silver, copper, coinIcons.copper)
	elseif (silver > 0) then
		return ("%d%s %d%s"):format(silver, coinIcons.silver, copper, coinIcons.copper)
	else
		return ("%d%s"):format(copper, coinIcons.copper)
	end
end



Engine:NewStaticConfig("Library: Format", F)
