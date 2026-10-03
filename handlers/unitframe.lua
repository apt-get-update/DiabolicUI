-- "UnitFrame" handler: builds unit frames and runs their elements.
-- Handler:New(unit, parent, styleFunc) creates a secure unit button and calls
-- styleFunc to build its widgets; every element file in
-- modules/unitframes/elements/ registers itself with
-- :RegisterElement(name, Enable, Update) and is enabled on each frame
-- that has the matching widget (frame.Health, frame.Portrait, ...).
-- Elements can ask for OnUpdate polling with :EnableFrequentUpdates().
local _, Engine = ...
local Handler = Engine:NewHandler("UnitFrame")

-- Lua API
local _G = _G
local pairs = pairs
local setmetatable = setmetatable
local string_format = string.format
local string_match = string.match
local string_upper = string.upper
local table_insert = table.insert
local table_remove = table.remove
local tonumber = tonumber

-- Blizzard API
local CreateFrame = _G.CreateFrame
local FriendsDropDown = _G.FriendsDropDown
local GameTooltip = _G.GameTooltip
local GetCurrentTitle = _G.GetCurrentTitle
local GetTitleName = _G.GetTitleName
local ToggleDropDownMenu = _G.ToggleDropDownMenu

local Elements = {} -- element registry
local Events = {} -- registry of frame and element event callbacks
local FrequentUpdates = {} -- registry of frame updates


-- UnitFrame Right Click Menus
--------------------------------------------------------------------------
-- get rid of stuff we don't want from the dropdown menus
-- * this appears to be causing taint for elements other than set/clear focus
-- * blizzard added fixes/secure menus for 3rd party frames in 5.2.0(?)
local UnWanted = {
	["SET_FOCUS"] = true,
	["CLEAR_FOCUS"] = true,

	-- WotLK
	["LOCK_FOCUS_FRAME"] = true,
	["UNLOCK_FOCUS_FRAME"] = true,

	-- Cata
	["MOVE_PLAYER_FRAME"] = true,
	["LOCK_PLAYER_FRAME"] = true,
	["UNLOCK_PLAYER_FRAME"] = true,
	["RESET_PLAYER_FRAME_POSITION"] = true,
	["PLAYER_FRAME_SHOW_CASTBARS"] = true,

	["MOVE_TARGET_FRAME"] = true,
	["LOCK_TARGET_FRAME"] = true,
	["UNLOCK_TARGET_FRAME"] = true,
	["TARGET_FRAME_BUFFS_ON_TOP"] = true,
	["RESET_TARGET_FRAME_POSITION"] = true
}

local UnitPopupMenus = _G.UnitPopupMenus
for id,menu in pairs(UnitPopupMenus) do
	for i = #menu, 1, -1 do
		local option = UnitPopupMenus[id][i]
		if option and UnWanted[option] then
			table_remove(UnitPopupMenus[id], i)
		end
	end
end

local UnitFrameMenu = function(self)
	if not self.unit then
		return
	end
	if self.unit == "targettarget" or self.unit == "focustarget" or self.unit == "pettarget" then
		return
	end
	local unit = self.unit:gsub("(.)", string_upper, 1)
	if _G[unit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
		return

	elseif self.unit:match("party") then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
		return

	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
	end
end


-- Hidden frames (empty raid and party slots, boss and arena frames outside
-- those fights, everything while the UI is hidden) are skipped: they're
-- brought up to date by the first update after they show again.
local OnUpdate = function(self, elapsed)
	for object, elements in pairs(FrequentUpdates) do
		if object:IsVisible() then
			for element, frequency in pairs(elements) do
				frequency.elapsed = frequency.elapsed + elapsed
				if frequency.elapsed >= frequency.hz then
					Elements[element].Update(object, "FREQUENT", elapsed)
					frequency.elapsed = 0
				end
			end
		end
	end
end

-- the one frame running every frequent update
local updater




-- Unitframe Template
--------------------------------------------------------------------------
local UnitFrame = Engine:CreateFrame("Button")
local UnitFrame_MT = { __index = UnitFrame }

-- store some meta methods
local RegisterEvent = UnitFrame_MT.__index.RegisterEvent
local IsEventRegistered = UnitFrame_MT.__index.IsEventRegistered


UnitFrame.OnEvent = function(self, event, ...)
	if (not self:IsShown()) or (not Events[self]) or (not Events[self][event]) then
		return
	end

	local events = Events[self][event]

	for i = 1, #events do
		events[i](self, event, ...)
	end
end

UnitFrame.RegisterEvent = function(self, event, func)
	-- create the event registry if it doesn't exist
	if not Events[self] then
		Events[self] = {}
	end
	if not Events[self][event] then
		Events[self][event] = {}
	end

	local events = Events[self][event]

	-- silently fail for duplicate calls
	for i = 1, #events do
		if events[i] == func then
			return
		end
	end

	-- insert the function into the event's registry
	table_insert(events, func)

	-- register the event
	if not IsEventRegistered(self, event) then
		RegisterEvent(self, event)
	end
end

UnitFrame.UpdateAllElements = function(self)
	for element in pairs(self._enabledelements) do
		Elements[element].Update(self, "PLAYER_ENTERING_WORLD")
	end
end

-- (Handler.New enables each registered element once)
UnitFrame.EnableElement = function(self, element)
	if Elements[element].Enable(self, self.unit) then
		self._enabledelements[element] = true
	end
end

-- Updates the element every `frequency` seconds while the frame is visible.
UnitFrame.EnableFrequentUpdates = function(self, element, frequency)
	if not FrequentUpdates[self] then
		FrequentUpdates[self] = {}
	end
	FrequentUpdates[self][element] = { elapsed = 0, hz = frequency }
	if not updater then
		updater = CreateFrame("Frame", nil, Engine:GetFrame())
		updater:SetScript("OnUpdate", OnUpdate)
	end
end

UnitFrame.OnEnter = function(self)
	GameTooltip:Hide()
	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	GameTooltip:SetUnit(self.unit)

	-- The default tooltip doesn't include your own title, unlike
	-- other players (whose title comes from the server as part of
	-- their name), so it's added here manually.
	if (self.unit == "player") then
		local titleIndex = GetCurrentTitle and GetCurrentTitle()
		local title = titleIndex and titleIndex > 0 and GetTitleName(titleIndex)
		if title then
			GameTooltip:AddLine(title)
			GameTooltip:Show()
		end
	end
	local r, g, b = GameTooltip_UnitColor(self.unit)
	GameTooltipTextLeft1:SetTextColor(r, g, b)
end

UnitFrame.OnLeave = function(self)
	GameTooltip:Hide()
end

UnitFrame.OnAttributeChanged = function(self, name, value)
	if (name == "unit") then
		self.unit = value
		self:UpdateAllElements()
	end
end

UnitFrame.GetRealUnit = function(self)
	return self:GetAttribute("real_unit")
end



-- Handler API
--------------------------------------------------------------------------
-- spawn and style a new unitframe
-- (a plain button rather than a secure unit button if 'nonSecure' is true)
Handler.New = function(self, unit, parent, styleFunc, nonSecure, ...)
	local secure = not nonSecure
	local object = setmetatable(Engine:CreateFrame("Button", nil, parent, secure and "SecureUnitButtonTemplate" or nil), UnitFrame_MT)
	object:SetFrameStrata("LOW")

	object.unit = unit
	object.id = tonumber((string_match(unit, "%d+"))) -- the index of numbered units
	object._enabledelements = {}

	-- Apply these script before the styling function,
	-- so the styling has the option to override them.
	object:SetScript("OnEnter", UnitFrame.OnEnter)
	object:SetScript("OnLeave", UnitFrame.OnLeave)
	object:RegisterForClicks("AnyUp")

	-- Apply the custom style function if it exists
	if styleFunc then
		styleFunc(object, object.unit, object.id, ...) -- pass both the unitid and unit index to the styling function
	end

	-- Parse the unitframe for known elements
	for element in pairs(Elements) do
		object:EnableElement(element)
	end

	-- Store the actual unit for later,
	-- as it's needed by frames that sometimes change their unit,
	-- like pet and player frames when the player has a vehicle UI.
	object:SetAttribute("real_unit", unit)

	-- left click to target
	object:SetAttribute("unit", unit)
	object:SetAttribute("*type1", "target")

	-- right click for menu
	-- Tainted menus, but set focus is removed, so nothing bad ever happens.
	-- Frame unlocking and all that jazz have also been removed.
	object:SetAttribute("*type2", "menu")
	object.menu = UnitFrameMenu

	-- alt left click to focus
	if unit == "focus" then
		object:SetAttribute("alt-type1", "macro")
		object:SetAttribute("macrotext", "/clearfocus")
	else
		object:SetAttribute("alt-type1", "focus")
	end

	object:SetScript("OnEvent", UnitFrame.OnEvent)
	object:SetScript("OnAttributeChanged", UnitFrame.OnAttributeChanged)
	object:HookScript("OnShow", UnitFrame.UpdateAllElements)


	if (unit == "target") then
		object:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrame.UpdateAllElements)
	elseif (unit == "focus") then
		object:RegisterEvent("PLAYER_FOCUS_CHANGED", UnitFrame.UpdateAllElements)
	elseif (unit:match("boss%d?$")) then
		object:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", UnitFrame.UpdateAllElements)
	elseif (unit:match("arena%d?$")) then
		object:RegisterEvent("ARENA_OPPONENT_UPDATE", UnitFrame.UpdateAllElements)
	elseif (unit:match("%w+target")) then
		-- No events fire for these units changing, so they're polled,
		-- or stuff like their names would very often be wrong.
		local timer = 0
		local OnUpdate = function(self, elapsed)
			timer = timer + elapsed
			if timer >= .5 then
				self:UpdateAllElements()
				timer = 0
			end
		end
		object:SetScript("OnUpdate", OnUpdate)
	end

	-- When we have a vehicleUI, we switch the player frame to vehicle, and pet frame to player.
	if (unit == "player") or (unit == "pet") then
		local VehicleUpdater = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")
		VehicleUpdater:SetFrameRef("unitframe", object)
		VehicleUpdater:SetAttribute("real-unit", unit)
		VehicleUpdater.UpdateUnit = function(self, unit) object.unit = unit end


		if (unit == "player") then
			VehicleUpdater:SetAttribute("_onstate-vehicleupdate", [[
				-- the vehicle's unit while in one
				local newUnit = (newstate == "invehicle") and "pet" or "player";

				-- update lua unit
				control:CallMethod("UpdateUnit", newUnit);

				-- update secure unit
				self:GetFrameRef("unitframe"):SetAttribute("unit", newUnit);
			]])

			-- We never hide the player unitframe. Ever.
			RegisterStateDriver(object, "visibility", "show")
		else
			VehicleUpdater:SetAttribute("_onstate-vehicleupdate", [[
				-- the player while in a vehicle
				local newUnit = (newstate == "invehicle") and "player" or self:GetAttribute("real-unit");

				-- update lua unit
				control:CallMethod("UpdateUnit", newUnit);

				-- update secure unit
				self:GetFrameRef("unitframe"):SetAttribute("unit", newUnit);
			]])

			-- Pet frames are used as player frames when we have a vehicleui
			RegisterStateDriver(object, "visibility", "[@pet,exists][vehicleui]show;hide")
		end

		-- Register our vehicleswitcher
		RegisterStateDriver(VehicleUpdater, "vehicleupdate", "[bonusbar:5][vehicleui] invehicle; notinvehicle")
	else
		-- Other units only need their own existence checks.
		RegisterStateDriver(object, "visibility", string_format("[@%s,exists]show;hide", object.unit))
	end

	return object
end

-- register a widget/element
Handler.RegisterElement = function(self, element, enableFunc, updateFunc)
	Elements[element] = {
		Enable = enableFunc,
		Update = updateFunc
	}
end
