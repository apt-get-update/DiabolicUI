local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: 3")


-- Lua API
local select = select
local setmetatable = setmetatable

-- WoW API
local CreateFrame = CreateFrame
local RegisterStateDriver = RegisterStateDriver

local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS or 12

BarWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db

	local Artwork = Module:GetWidget("Artwork")
	local Bar = Module:GetHandler("ActionBar"):New(BOTTOMRIGHT_ACTIONBAR_PAGE, Module:GetWidget("Controller: Main"):GetFrame(), Artwork:GetBarTemplate())

	--------------------------------------------------------------------
	-- Buttons
	--------------------------------------------------------------------

	-- Spawn the action buttons
	for i = 1,NUM_ACTIONBAR_BUTTONS do
		-- Make sure the standard bars
		-- get button IDs that reflect their actual actions
		-- local button_id = (Bar.id - 1) * NUM_ACTIONBAR_BUTTONS + i
		
		local button = Bar:NewButton("action", i, Artwork:GetButtonTemplate())
		button:SetStateAction(0, "action", i)
		for state = 1,14 do
			button:SetStateAction(state, "action", (state - 1) * NUM_ACTIONBAR_BUTTONS + i)
		end
	end

	
	Bar:SetAttribute("_onstate-page", [[ 
		self:SetAttribute("state", newstate);
		for i = 1, self:GetAttribute("num_buttons") do
			local Button = self:GetFrameRef("Button"..i);
			Button:SetAttribute("actionpage", tonumber(newstate)); 
		end
		control:CallMethod("UpdateAction");
	]])	

	-- reset the page before applying a new page driver
	Bar:SetAttribute("state-page", "0") 
	
	-- enable the new page driver
	RegisterStateDriver(Bar, "page", tostring(BOTTOMRIGHT_ACTIONBAR_PAGE)) 
	
	--------------------------------------------------------------------
	-- Visibility Drivers
	--------------------------------------------------------------------
	Bar:SetAttribute("_onstate-vis", [[
		if newstate == "hide" then
			self:Hide();
		elseif newstate == "show" then
			self:Show();
		end
	]])

	-- Register a proxy visibility driver
	local visibility_driver = "[bonusbar:5]hide;[vehicleui]hide;show"
	RegisterStateDriver(Bar, "vis", visibility_driver)

	local Visibility = Bar:GetParent()
	Visibility:SetAttribute("_childupdate-set_numbars", [[
		local num = tonumber(message);
		
		-- update bar visibility
		if num == 1 then
			self:Hide();
		elseif num == 2 then
			self:Hide();
		elseif num == 3 then
			self:Show();
		else
			self:Hide();
		end
		
		local Bar = self:GetFrameRef("Bar");
		control:RunFor(Bar, [=[
			local num = ...
			
			-- update bar size
			local old_bar_width = self:GetAttribute("bar_width");
			local old_bar_height = self:GetAttribute("bar_height");
			local bar_width = self:GetAttribute("bar_width-"..num);
			local bar_height = self:GetAttribute("bar_height-"..num);
			
			if old_bar_width ~= bar_width or old_bar_height ~= bar_height then
				self:SetWidth(bar_width);
				self:SetHeight(bar_height);
			end
			
			-- update button size
			local old_button_size = self:GetAttribute("old_button_size");
			local button_size = self:GetAttribute("button_size-"..num);
			local padding = self:GetAttribute("padding");

			if old_button_size ~= button_size then
				for i = 1, self:GetAttribute("num_buttons") do
					local Button = self:GetFrameRef("Button"..i);
					Button:SetWidth(button_size);
					Button:SetHeight(button_size);
					Button:ClearAllPoints();
					Button:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", (i-1)*(button_size + padding), 0);
				end
				self:SetAttribute("old_button_size", button_size);
			end

		]=], num);
	]])


	-- store bar settings
	local bar_config = config.structure.bars.bar3
	Bar:SetAttribute("flyout_direction", bar_config.flyout_direction)
	Bar:SetAttribute("growth_x", bar_config.growthX)
	Bar:SetAttribute("growth_y", bar_config.growthY)
	Bar:SetAttribute("padding", bar_config.padding)
	
	for i = 1,3 do
		local id = tostring(i)
		Bar:SetAttribute("bar_width-"..id, bar_config.bar_size[id][1])
		Bar:SetAttribute("bar_height-"..id, bar_config.bar_size[id][2])
		Bar:SetAttribute("button_size-"..id, bar_config.buttonsize[id])
	end
	
	local previous = Module:GetWidget("Bar: 2"):GetFrame()
	Bar:SetPoint("BOTTOMLEFT", previous, "TOPLEFT", 0, config.structure.bars.padding)

	self.Bar = Bar
end

BarWidget.GetFrame = function(self)
	return self.Bar
end
