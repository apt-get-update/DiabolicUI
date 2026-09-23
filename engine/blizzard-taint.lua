--[[

	The MIT License (MIT)
	Copyright (c) 2017 Lars "Goldpaw" Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]--

-- WoW API
local SetCVar = _G.SetCVar

-- Forcefully showing script errors because I need this.
-- I also forcefully enable the taint log.
--
-- TODO:
-- Write an error handler of my own that is unintrusive,
-- which people can use to copy premade bug reports to me!
SetCVar("scriptErrors", 1)
SetCVar("taintLog", 1)

---------------------------------------------------------------
-- UIDropDown taints
---------------------------------------------------------------
if UIDropDownMenu_InitializeHelper then
	if ((UIDROPDOWNMENU_VALUE_PATCH_VERSION or 0) < 2) then
		UIDROPDOWNMENU_VALUE_PATCH_VERSION = 2
		hooksecurefunc("UIDropDownMenu_InitializeHelper", function()
			if UIDROPDOWNMENU_VALUE_PATCH_VERSION ~= 2 then
				return
			end
			for i=1, UIDROPDOWNMENU_MAXLEVELS do
				for j=1, UIDROPDOWNMENU_MAXBUTTONS do
					local b = _G["DropDownList" .. i .. "Button" .. j]
					if not (issecurevariable(b, "value") or b:IsShown()) then
						b.value = nil
						repeat
							j, b["fx" .. j] = j+1
						until issecurevariable(b, "value")
					end
				end
			end
		end)
	end
end
