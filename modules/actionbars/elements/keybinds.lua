local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local Widget = Module:SetWidget("Keybinds")

-- Lua API
local ipairs = ipairs
local table_insert = table.insert

-- WoW API
local ClearOverrideBindings = _G.ClearOverrideBindings
local GetBindingKey = _G.GetBindingKey
local RegisterStateDriver = _G.RegisterStateDriver
local SetOverrideBindingClick = _G.SetOverrideBindingClick
local UnregisterStateDriver = _G.UnregisterStateDriver

Widget.OnEnable = function(self)
	self.config = self:GetDB("ActionBars") -- static config
	self.db = self:GetConfig("ActionBars", "character") -- per user settings for bars

	self:GrabKeybinds()
	self:RegisterEvent("UPDATE_BINDINGS", "GrabKeybinds")
end

Widget.GetBindingTable = function(self)
	if (not self.bindingTable) then
		self.bindingTable = {
			"ACTIONBUTTON%d", 				-- main action bar
			"MULTIACTIONBAR1BUTTON%d", 		-- bottomleft bar
			"MULTIACTIONBAR2BUTTON%d", 		-- bottomright bar
			"MULTIACTIONBAR3BUTTON%d",  	-- right sidebar
			"MULTIACTIONBAR4BUTTON%d", 		-- left sidebar
			"BONUSACTIONBUTTON%d", 			-- pet bar
			"SHAPESHIFTBUTTON%d" 			-- stance bar
		}
	end
	return self.bindingTable
end

Widget.GetPetBattleController = function(self)
	return self.petBattleController
end

Widget.GetVehicleController = function(self)
	if (not self.vehicleController) then

		-- We're using a custom vehicle bar, and in order for it to work properly, 
		-- we need to borrow the primary action bar's keybinds temporarily.
		-- This will override the temporary bindings normally assigned to our own main action bar. 
		local vehicle = Engine:CreateFrame("Frame", nil, "UICenter", "SecureHandlerStateTemplate")
		vehicle:SetAttribute("_onstate-vehicle", [[
			if newstate == "vehicle" then
				for i = 1,6 do
					local our_button, vehicle_button = ("ACTIONBUTTON%d"):format(i), ("CLICK EngineVehicleBarButton%d:LeftButton"):format(i)

					-- Grab the keybinds from the default action bar,
					-- and assign them to our custom vehicle bar. 

					for k=1,select("#", GetBindingKey(our_button)) do
						local key = select(k, GetBindingKey(our_button)) -- retrieve the binding key from our own primary bar
						self:SetBinding(true, key, vehicle_button) -- assign that key to the vehicle bar
					end
				end
			else
				-- Return the key bindings to whatever buttons they were
				-- assigned to before we so rudely grabbed them! :o
				self:ClearBindings()
			end
		]])

		-- Do we ever need to update his?
		RegisterStateDriver(vehicle, "vehicle", "[bonusbar:5][vehicleui]vehicle;novehicle")

		self.vehicleController = vehicle
	end

	return self.vehicleController
end

Widget.GrabKeybinds = Module:Wrap(function(self)
	local bars = Module:GetBars()
	local bindingTable = self:GetBindingTable()
	for barNumber,actionName in ipairs(bindingTable) do
		local bar = bars[barNumber] -- upvalue the current bar
		if bar then
			ClearOverrideBindings(bar) -- clear current overridebindings
			for buttonNumber, button in bar:GetAll() do -- only work with the buttons that have actually spawned
				local action = actionName:format(buttonNumber) -- get the correct keybinding action name
				button:SetBindingAction(action) -- store the binding action name on the button
				for keyNumber = 1, select("#", GetBindingKey(action)) do -- iterate through the registered keys for the action
					local key = select(keyNumber, GetBindingKey(action)) -- get a key for the action
					if (key and (key ~= "")) then
						-- this is why we need named buttons
						SetOverrideBindingClick(bars[barNumber], false, key, button:GetName()) -- assign the key to our own button
					end	
				end
			end
		end
	end	
	
	-- update the vehicle bar keybind display
	local vehicleBar = Module:GetWidget("Bar: Vehicle"):GetFrame()
	for buttonNumber, button in vehicleBar:GetAll() do -- only work with the buttons that have actually spawned
		local action = "ACTIONBUTTON"..buttonNumber -- get the correct keybinding action name
		button:SetBindingAction(action) -- store the binding action name on the button
	end

	self:GetPetBattleController()
	self:GetVehicleController()
end)
