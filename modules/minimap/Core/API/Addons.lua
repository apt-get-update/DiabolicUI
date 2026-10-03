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
local API = ns.API or {}
ns.API = API

-- Lua API
local string_lower = string.lower

-- Is an addon (any letter case) in the addon list?
API.IsAddOnAvailable = function(target)
	target = string_lower(target)
	for i = 1, _G.GetNumAddOns() do
		if (string_lower((_G.GetAddOnInfo(i))) == target) then
			return true
		end
	end
end

-- Is an addon in the addon list, enabled and loadable?
API.IsAddOnEnabled = function(target)
	target = string_lower(target)
	for i = 1, _G.GetNumAddOns() do
		local name, _, _, enabled, loadable = _G.GetAddOnInfo(i)
		if (string_lower(name) == target) then
			return (enabled and loadable) and true or nil
		end
	end
end
