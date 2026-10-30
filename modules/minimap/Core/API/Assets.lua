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
local API = ns.API or {}
ns.API = API

-- WoW API
local CreateFont = CreateFont

-- Lua API
local rawset = rawset
local setmetatable = setmetatable
local string_format = string.format
local type = type

-- Font objects by type, outline and size, made on first use.
local count, font_mt = 0
font_mt = {
	__index = function(t, k)
		-- Create a new category and subtable
		if (type(k) == "string") then
			local new = setmetatable({}, font_mt)
			rawset(t, k, new)
			return new
		end
		-- Create a new font object
		count = count + 1
		local new = CreateFont(string_format(ns.Prefix .. "Font%d", count))
		new:SetJustifyH("LEFT")
		rawset(t, k, new)
		return new
	end
}
local Fonts = setmetatable({}, font_mt)

-- Return a font object, re-use existing ones that match.
API.GetFont = function(size, outline, type)
	local inherit = type == "Chat" and _G.ChatFontNormal or type == "Number" and _G.NumberFont_Normal_Med or
	_G.MailFont_Large
	local fontObject = Fonts[type or "Normal"][outline and "Outline" or "None"][size]
	if (fontObject:GetFontObject() ~= inherit) then
		fontObject:SetFontObject(inherit)
		fontObject:SetFont(fontObject:GetFont(), size, outline and "OUTLINE" or "")
		fontObject:SetShadowColor(0, 0, 0, 0)
		fontObject:SetShadowOffset(0, 0)
	end
	return fontObject
end

-- Retrieve an asset from the addon's media/textures folder.
API.GetMedia = function(name, type)
	return string_format([[Interface\AddOns\%s\media\textures\%s.%s]], Addon, name, type or "tga")
end
