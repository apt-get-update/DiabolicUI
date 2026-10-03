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
local _, ns = ..., DiabolicUIMinimapNS

local color = function(r, g, b)
	return { r / 255, g / 255, b / 255 }
end

ns.Colors = {
	normal = color(229, 178, 38),
	highlight = color(250, 250, 250),
	title = color(255, 234, 137),
	offwhite = color(196, 196, 196),
	green = color(25, 178, 25),
	ui = color(192, 192, 192),
	quest = {
		green = color(89, 201, 89)
	},
	-- zone names, by GetZonePVPInfo's pvp type
	zone = {
		arena = color(175, 76, 56),
		combat = color(175, 76, 56),
		contested = color(229, 159, 28),
		friendly = color(64, 175, 38),
		hostile = color(175, 76, 56),
		sanctuary = color(104, 204, 239)
	}
}
