local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local Widget = Module:SetWidget("Bar: 1")

-- Lua API
local _G = _G
local select = select
local setmetatable = setmetatable
local table_concat = table.concat
local table_insert = table.insert
local table_wipe = table.wipe

-- WoW API
local CreateFrame = _G.CreateFrame
local GetNumShapeshiftForms = _G.GetNumShapeshiftForms
local RegisterStateDriver = _G.RegisterStateDriver
local UnitClass = _G.UnitClass

local NUM_ACTIONBAR_BUTTONS = _G.NUM_ACTIONBAR_BUTTONS or 12

Widget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db

	local Artwork = Module:GetWidget("Artwork")
	local Bar = Module:GetHandler("ActionBar"):New(1, Module:GetWidget("Controller: Main"):GetFrame(), Artwork:GetBarTemplate())


	--------------------------------------------------------------------
	-- Buttons
	--------------------------------------------------------------------

	-- Spawn the action buttons
	for i = 1,NUM_ACTIONBAR_BUTTONS do
		local button = Bar:NewButton("action", i, Artwork:GetButtonTemplate())
		button:SetStateAction(0, "action", i)
		for state = 1,14 do
			button:SetStateAction(state, "action", (state - 1) * NUM_ACTIONBAR_BUTTONS + i)
		end
	end
	

	--------------------------------------------------------------------
	-- Page Driver
	--------------------------------------------------------------------

	-- This driver updates the bar state attribute to follow its current page,
	-- and also moves the vehicle, override, possess and temp shapeshift
	-- bars into the main bar as state/page changes.
	--
	-- After a state change the state-page childupdate is called 
	-- on all the bar's children, which in turn updates button actions 
	-- and initiate a texture update!
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
	
	-- Main actionbar paging based on class/stance
	-- also supports user changed paging
	local driver = {}
	local _, playerClass = UnitClass("player")

	table_insert(driver, "[bonusbar:5]11")
	table_insert(driver, "[bar:2]2; [bar:3]3; [bar:4]4; [bar:5]5; [bar:6]6")

	if playerClass == "DRUID" then
		table_insert(driver, "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10")
	elseif playerClass == "PRIEST" then
		table_insert(driver, "[bonusbar:1] 7")
	elseif playerClass == "ROGUE" then
		table_insert(driver, "[bonusbar:1] 7; [form:3] 8")
	elseif playerClass == "WARLOCK" then
		table_insert(driver, "[form:2] 7")
	elseif playerClass == "WARRIOR" then
		table_insert(driver, "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9")
	end

	table_insert(driver, "1")
	local pageDriver = table_concat(driver, "; ")
	
	-- enable the new page driver
	RegisterStateDriver(Bar, "page", pageDriver) 


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

	table_wipe(driver)
	table_insert(driver, "[bonusbar:5]hide")
	table_insert(driver, "[vehicleui]hide")
	table_insert(driver, "show")

	-- Register a proxy visibility driver
	local visibilityDriver = table_concat(driver, "; ")
	RegisterStateDriver(Bar, "vis", visibilityDriver)
	
	local Visibility = Bar:GetParent()
	Visibility:SetAttribute("_childupdate-set_numbars", [[
		local num = tonumber(message);
		
		-- update bar visibility
		if num == 1 then
			self:Show();
		elseif num == 2 then
			self:Show();
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
	local bar_config = config.structure.bars.bar1
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
	
	Bar:SetPoint("BOTTOM")

	self.Bar = Bar
end

Widget.GetFrame = function(self)
	return self.Bar
end
