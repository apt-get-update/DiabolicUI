local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: 5")

-- Lua API
local select = select
local setmetatable = setmetatable
local tinsert, tconcat, twipe = table.insert, table.concat, table.wipe

-- WoW API
local CreateFrame = CreateFrame
local RegisterStateDriver = RegisterStateDriver

local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS or 12

BarWidget.OnEnable = function(self)
	local config = Module.config
	local db = Module.db
	local bar_config = config.structure.bars.bar5

	local Artwork = Module:GetWidget("Artwork")
	local Bar = Module:GetHandler("ActionBar"):New(LEFT_ACTIONBAR_PAGE, Module:GetWidget("Controller: Main"):GetFrame(), Artwork:GetBarTemplate())
	Bar:SetFrameStrata("MEDIUM")
	Bar:SetFrameLevel(50)
	Bar:Place(unpack(bar_config.position))
	Bar:SetAttribute("flyout_direction", bar_config.flyout_direction)
	Bar:SetAttribute("growth_x", bar_config.growthX)
	Bar:SetAttribute("growth_y", bar_config.growthY)
	Bar:SetAttribute("growth", bar_config.growth)
	Bar:SetAttribute("padding", bar_config.padding)
	Bar.hideGrid = bar_config.hideGrid

	for i = 0,2 do
		local id = tostring(i)
		Bar:SetAttribute("bar_width-"..id, bar_config.bar_size[id][1])
		Bar:SetAttribute("bar_height-"..id, bar_config.bar_size[id][2])
		if i > 0 then
			Bar:SetAttribute("button_size-"..id, bar_config.buttonsize[id])
		end
	end
	

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
		button:SetAttribute("flyoutDirection", "LEFT")
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
	RegisterStateDriver(Bar, "page", tostring(LEFT_ACTIONBAR_PAGE)) 
	
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
	local visibility_driver = ENGINE_MOP and "[overridebar][possessbar][shapeshift]hide;[vehicleui]hide;show" or "[bonusbar:5]hide;[vehicleui]hide;show"
	RegisterStateDriver(Bar, "vis", visibility_driver)
	
	local Visibility = Bar:GetParent()
	Visibility:SetAttribute("_childupdate-set_numsidebars", [[
		local num = tonumber(message);
		
		-- update bar visibility
		if num == 1 then
			self:Hide();
		elseif num == 2 then
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
			
			-- only change button size when bars are visible
			if num > 0 then
				local old_button_size = self:GetAttribute("old_button_size");
				local button_size = self:GetAttribute("button_size-"..num);

				-- update button size
				if old_button_size ~= button_size then
					local padding = self:GetAttribute("padding"); 
					local growth_x = self:GetAttribute("growth_x");
					local growth_y = self:GetAttribute("growth_y");
					local growth = self:GetAttribute("growth"); 

					local columns = floor(bar_width / button_size); 
					local rows = floor(bar_height / button_size);

					for i = 1, self:GetAttribute("num_buttons") do
						local Button = self:GetFrameRef("Button"..i);
						Button:SetWidth(button_size);
						Button:SetHeight(button_size);
						Button:ClearAllPoints();

						-- Just set some fallback values incase the attributes aren't defined
						local anchor = "TOPRIGHT"; 
						local x = 0;
						local y = 0;
						if growth_x == "RIGHT" then
							x = 1; 
							if growth_y == "UP" then
								anchor = "BOTTOMLEFT"; 
								y = 1;
							elseif growth_y == "DOWN" then
								anchor = "TOPLEFT"; 
								y = -1;
							end
						elseif growth_x == "LEFT" then
							x = -1;
							if growth_y == "UP" then
								anchor = "BOTTOMRIGHT";
								y = 1;
							elseif growth_y == "DOWN" then
								anchor = "TOPRIGHT";
								y = -1;
							end
						end

						if i == 1 then
							Button:SetPoint(anchor, self, anchor, 0, 0); 
						else
							if growth == "VERTICAL" then
								local column = floor((i-1)/rows);
								local row = mod(i-1, rows);
								Button:SetPoint(anchor, self, anchor, x*(column)*(button_size + padding), y*(row)*(button_size + padding) );
							elseif growth == "HORIZONTAL" then
								local column = mod(i-1, columns);
								local row = floor((i-1)/columns);
								Button:SetPoint(anchor, self, anchor, x*(column)*(button_size + padding), y*(row)*(button_size + padding) );
							end
						end
					end
					self:SetAttribute("old_button_size", button_size);
				end

			end

		]=], num);
	]])
	
	self.Bar = Bar
	
end

BarWidget.GetFrame = function(self)
	return self.Bar
end
