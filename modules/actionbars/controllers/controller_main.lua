local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local ControllerWidget = Module:SetWidget("Controller: Main")

-- Lua API
local _G = _G
local pairs = pairs
local setmetatable = setmetatable
local table_concat = table.concat
local table_insert = table.insert
local tonumber = tonumber
local tostring = tostring

-- WoW API
local CreateFrame = _G.CreateFrame

local Controller = Engine:CreateFrame("Frame")
local Controller_MT = { __index = Controller }

-- Saves settings when the number of bars are changed
Controller.SaveNumBars = function(self)
	local db = self.db
	if not db then
		return
	end
	db.num_bars = tonumber(self:GetAttribute("numbars"))
end

Controller.SaveNumSideBars = function(self)
	local db = self.db
	if not db then
		return
	end
	db.num_side_bars = tonumber(self:GetAttribute("numsidebars"))
end

Controller.InVehicle = function(self)
	local state = tostring(self:GetAttribute("state-page"))
	return (state == "possess") or (state == "vehicle")
end

Controller.GetNumBars = function(self)
	return tonumber(self:GetAttribute("numbars"))
end

Controller.GetNumSideBars = function(self)
	return tonumber(self:GetAttribute("numsidebars"))
end

Controller.UpdateLayout = function(self)
	local state = tostring(self:GetAttribute("state-page"))
	Module:SendMessage("ENGINE_ACTIONBAR_VEHICLE_CHANGED", (state == "possess") or (state == "vehicle")) -- arg1 == true means player has vehicleUI
	Module:SendMessage("ENGINE_ACTIONBAR_VISIBLE_CHANGED", tonumber(self:GetAttribute("numbars"))) -- arg1 returns number of bars when not in a vehicle
end

-- Updates bar and button artwork upon bar num changes and vehicles/possess
Controller.UpdateBarArtwork = function(self)
	for i = 1,self:GetAttribute("numbars") do
		local Bar = Module:GetWidget("Bar: "..i):GetFrame()
		if Bar and Bar.PostUpdate then
			Bar:PostUpdate()
		end
	end
end

Controller.UpdateSideBarArtwork = function(self)
	for i = 1,self:GetAttribute("numsidebars") do
		local Bar = Module:GetWidget("Bar: "..(i+3)):GetFrame()
		if Bar and Bar.PostUpdate then
			Bar:PostUpdate()
		end
	end
end

ControllerWidget.OnEnable = function(self)
	local db = Module.db
	local config = Module.config
	local controlConfig = config.structure.controllers.main
	local controlPosition = config.structure.controllers.main.position

	--self.Controller = setmetatable(CreateFrame("Frame", nil, Engine:GetFrame(), "SecureHandlerAttributeTemplate"), Controller_MT)
	self.Controller = setmetatable(Engine:CreateFrame("Frame", nil, Engine:GetFrame(), "SecureHandlerAttributeTemplate"), Controller_MT)
	self.Controller:SetFrameStrata("BACKGROUND")
	self.Controller:SetAllPoints()
	self.Controller.db = db
	
	-- store controller settings
	for id in pairs(controlConfig.size) do
		self.Controller:SetAttribute("controller_width-"..id, controlConfig.size[id][1])
		self.Controller:SetAttribute("controller_height-"..id, controlConfig.size[id][2])
	end
	self.Controller:SetAttribute("padding", controlConfig.padding)
	self.Controller:Place(controlPosition.point, controlPosition.anchor, controlPosition.anchor_point, controlPosition.xoffset, controlPosition.yoffset)
	
	-- reset the page before applying a new page driver
	self.Controller:SetAttribute("state-page", "0") 
	
	-- Paging based on class/stance
	-- *in theory a copy of what the main actionbar uses
	-- *also supports user changed paging
	local driver = {}
	local _, playerClass = UnitClass("player")

	table_insert(driver, "[bonusbar:5]vehicle")
	table_insert(driver, "[vehicleui]vehicle")
	--table_insert(driver, "[bonusbar:5]11")
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
	local page_driver = table_concat(driver, "; ")
	
	-- attribute driver to handle number of visible bars, layouts, sizes etc
	self.Controller:SetAttribute("_onattributechanged", [[

		-- In theory we could use this to create different artworks and layouts
		-- for each stance, actionpage or macro conditional there is. 
		-- For our current UI though, we're only using it to capture vehicles and possessions.
		if name == "state-page" then
			local previous_state = self:GetAttribute("previous_state");
			
			-- entering a vehicle
			if value == "vehicle" or value == "possess" then
				if previous_state ~= "vehicle" then
					self:SetAttribute("previous_state", "vehicle");

					local width = self:GetAttribute("controller_width-vehicle");
					local height = self:GetAttribute("controller_height-vehicle");

					self:SetWidth(width);
					self:SetHeight(height);

					-- tell the addon to update artwork
					--control:CallMethod("UpdateArtwork");
					control:CallMethod("UpdateLayout");
				end
				value = 11;
			else
				-- leaving a vehicle
				if previous_state == "vehicle" then
					self:SetAttribute("previous_state", value);

					local num = tonumber(self:GetAttribute("numbars"));
					local width = self:GetAttribute("controller_width-"..num);
					local height = self:GetAttribute("controller_height-"..num);

					self:SetWidth(width);
					self:SetHeight(height);

					-- tell the addon to update artwork
					--control:CallMethod("UpdateArtwork");
					control:CallMethod("UpdateLayout");
				end
			end

			local page = tonumber(value);
			if page then
				self:SetAttribute("state", page);
			end
		end
		
		-- new action page
		if name == "state" then
		end
		
		-- user changed number of visible bars
		if name == "numbars" then
			local num = tonumber(value);
			if num then
			
				-- make sure we only fire this if the number actually changes
				local old_num = self:GetAttribute("old_numbars");
				if old_num ~= num then

					-- tell the secure children about the bar number update
					control:ChildUpdate("set_numbars", num);
					self:SetAttribute("old_numbars", num);
					
					-- update button artwork
					control:CallMethod("UpdateBarArtwork");
					
					-- update controller size
					-- *don't do this if we're currently in a vehicle
					local current_state = self:GetAttribute("state-page");
					if tonumber(current_state) then					
						local width = self:GetAttribute("controller_width-"..num);
						local height = self:GetAttribute("controller_height-"..num);

						self:SetWidth(width);
						self:SetHeight(height);

						-- tell the addon to update artwork
						--control:CallMethod("UpdateArtwork");
						control:CallMethod("UpdateLayout");
					end
					
					-- save the number of bars
					control:CallMethod("SaveNumBars");
				end
			end
		end

		-- change the number of floating side bars
		if name == "numsidebars" then
			local num = tonumber(value);
			if num then
				local old_num = self:GetAttribute("old_numsidebars");
				if old_num ~= num then 
					
					-- tell the secure children about the bar number update
					control:ChildUpdate("set_numsidebars", num);
					self:SetAttribute("old_numsidebars", num);
					
					-- update button artwork
					control:CallMethod("UpdateSideBarArtwork");

					-- save the number of bars
					control:CallMethod("SaveNumSideBars");
				end
			end
		end
	]])
	
	-- enable the new page driver
	RegisterStateDriver(self.Controller, "page", page_driver)
	
end

ControllerWidget.GetFrame = function(self)
	return self.Controller
end
