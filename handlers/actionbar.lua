local _, Engine = ...
local Handler = Engine:NewHandler("ActionBar")
local ActionButton = Engine:GetHandler("ActionButton")

-- Lua API
local setmetatable = setmetatable
local tinsert = table.insert

-- WoW API
local PlaySoundKitID = Engine:IsBuild("7.3.0") and _G.PlaySound or _G.PlaySoundKitID

local Bar = Engine:CreateFrame("Button")
local Bar_MT = { __index = Bar }

local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]

local visibilityHandlers = {}
local visibilityDrivers = {}

-- update button lock, text visibility, cast on down/up here!
Bar.UpdateButtonSettings = function(self)
end

-- update the action and action textures
Bar.UpdateAction = function(self)
	local buttons = self.buttons
	for i in ipairs(self.buttons) do 
		buttons[i]:UpdateAction()
	end
end

Bar.Update = function(self)
	if self.PostUpdate then
		return self:PostUpdate()
	end
end

Bar.ForAll = function(self, method, ...)
	for i, button in self:GetAll() do
		button[method](button, ...)
	end
end

Bar.GetAll = function(self)
	return ipairs(self.buttons)
end

Bar.NewButton = function(self, button_type, button_id, ...)
	local Button = ActionButton:New(button_type, button_id, self, ...)
	Button:SetFrameStrata("MEDIUM")
	
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

Bar.RegisterVisibilityDriver = function(self, driver)
	local visibility = visibilityHandlers[self]
	local driver = visibilityDrivers[self]
	if driver then
		visibilityDrivers[self] = nil
		UnregisterStateDriver(visibility, "visibility")
	end
	RegisterStateDriver(visibility, "visibility", driver)
end

Bar.UnregisterVisibilityDriver = function(self)
	if (visibilityDrivers[self]) then
		visibilityDrivers[self] = nil
		UnregisterStateDriver(visibilityHandlers[self], "visibility")
	end
end

Bar.GetVisibilityDriver = function(self)
	return visibilityDrivers[self]
end

Handler.New = function(self, id, parent, barTemplate, ...)

	-- the visibility layer is used for user controlled toggling of bars
	local visibility = CreateFrame("Frame", nil, parent, "SecureHandlerStateTemplate")
	visibility:SetAllPoints()
	
	local bar = setmetatable(Engine:CreateFrame("Frame", nil, visibility, "SecureHandlerStateTemplate"), Bar_MT)
	bar:SetFrameStrata("LOW")
	bar.id = id or 0
	bar.buttons = {}

	-- Store this bar's visibility handler locally, but avoid giving the user direct access.
	visibilityHandlers[bar] = visibility

	-- Tell the bar where to find its visibility layer
	-- *Let's try NOT giving it access
	bar:SetFrameRef("Visibility", visibility)

	-- Sounds
	bar:HookScript("OnShow", function(self) PlaySoundKitID(SOUNDKIT.IG_CHARACTER_INFO_OPEN, "SFX") end)
	bar:HookScript("OnHide", function(self) PlaySoundKitID(SOUNDKIT.IG_CHARACTER_INFO_CLOSE, "SFX") end)

	-- Tell the visibility layer where to find the bar
	visibility:SetFrameRef("Bar", bar)

	-- Add any methods from the optional template.
	-- This can NOT override existing methods!
	if barTemplate then
		for name, method in pairs(barTemplate) do
			if (not bar[name]) then
				bar[name] = method
			end
		end
	end

	-- Call the post create method if it exists, and pass along any remaining arguments.
	-- This is to allow user modules to add their own styling during creation.
	if bar.PostCreate then
		bar:PostCreate(...)
	end

	return bar
end

