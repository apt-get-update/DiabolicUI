-- "ActionBar" handler: Handler:New(id, parent, barTemplate) builds a
-- secure action bar header inside its own visibility layer (for the user's
-- bar toggles), with the methods of barTemplate added; bar:NewButton(...)
-- adds an ActionButton to it, numbered for the secure snippets.
local _, Engine = ...
local Handler = Engine:NewHandler("ActionBar")
local ActionButton = Engine:GetHandler("ActionButton")

-- Lua API
local ipairs = ipairs
local pairs = pairs
local setmetatable = setmetatable

-- WoW API
local CreateFrame = _G.CreateFrame
local PlaySound = _G.PlaySound

local Bar = Engine:CreateFrame("Button")
local Bar_MT = { __index = Bar }

-- update the action and action textures
-- (called by the bars' secure page snippets, through control:CallMethod)
Bar.UpdateAction = function(self)
	for _, button in ipairs(self.buttons) do
		button:UpdateAction()
	end
end

Bar.GetAll = function(self)
	return ipairs(self.buttons)
end

Bar.NewButton = function(self, button_type, button_id, ...)
	local Button = ActionButton:New(button_type, button_id, self, ...)
	Button:SetFrameStrata("MEDIUM")
	-- A new frame's level otherwise just defaults to whatever WoW resolves
	-- at creation time and never updates on its own afterwards - setting it
	-- explicitly, relative to the bar's own (by-then-already-correct)
	-- level, is what actually keeps every button above the demon/angel
	-- artwork, rather than relying on artwork.lua to notice and fix it up
	-- after the fact once the mismatch is already visible on screen.
	Button:SetFrameLevel(self:GetFrameLevel() + 1)

	-- Increase the bar's local button count
	local num = #self.buttons + 1

	-- Add a secure reference to the button
	self:SetFrameRef("Button"..num, Button)

	-- Update the secure button count
	self:SetAttribute("num_buttons", num)

	-- Store the button in the registry
	self.buttons[num] = Button

	return Button
end

Handler.New = function(self, id, parent, barTemplate)

	-- the visibility layer is used for user controlled toggling of bars
	local visibility = CreateFrame("Frame", nil, parent, "SecureHandlerStateTemplate")
	visibility:SetAllPoints()
	
	local bar = setmetatable(Engine:CreateFrame("Frame", nil, visibility, "SecureHandlerStateTemplate"), Bar_MT)
	bar:SetFrameStrata("LOW")
	bar.id = id or 0
	bar.buttons = {}

	-- Tell the bar where to find its visibility layer
	bar:SetFrameRef("Visibility", visibility)

	-- Sounds
	bar:HookScript("OnShow", function(self) PlaySound("igCharacterInfoOpen") end)
	bar:HookScript("OnHide", function(self) PlaySound("igCharacterInfoClose") end)

	-- Tell the visibility layer where to find the bar
	visibility:SetFrameRef("Bar", bar)

	-- Add the template's methods.
	-- This can NOT override existing methods!
	for name, method in pairs(barTemplate) do
		if (not bar[name]) then
			bar[name] = method
		end
	end

	return bar
end

