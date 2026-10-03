-- "ActionButton" handler: DiabolicUI's own action button implementation.
-- Handler:New(buttonType, id, header, template) builds a secure button for an
-- action, pet, stance, spell, item or macro slot, and this file keeps them all
-- updated: icons, cooldowns, counts, range and usability coloring, keybind
-- text, grid visibility while dragging, and tooltips.
local _, Engine = ...
local Handler = Engine:NewHandler("ActionButton")

-- Lua API
local _G = _G
local pairs = pairs
local select = select
local setmetatable = setmetatable
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local AutoCastShine_AutoCastStart = _G.AutoCastShine_AutoCastStart
local AutoCastShine_AutoCastStop = _G.AutoCastShine_AutoCastStop
local CreateFrame = _G.CreateFrame
local GetActionCooldown = _G.GetActionCooldown
local GetActionCount = _G.GetActionCount
local GetActionTexture = _G.GetActionTexture
local GetPetActionCooldown = _G.GetPetActionCooldown
local GetPetActionInfo = _G.GetPetActionInfo
local GetPetActionsUsable = _G.GetPetActionsUsable
local GetShapeshiftFormCooldown = _G.GetShapeshiftFormCooldown
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local HasAction = _G.HasAction
local InCombatLockdown = _G.InCombatLockdown
local IsActionInRange = _G.IsActionInRange
local IsAttackAction = _G.IsAttackAction
local IsAutoRepeatAction = _G.IsAutoRepeatAction
local IsCurrentAction = _G.IsCurrentAction
local IsConsumableAction = _G.IsConsumableAction
local IsStackableAction = _G.IsStackableAction
local IsUsableAction = _G.IsUsableAction
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost

-- Will replace these with our custom tooltiplib later on!
local GameTooltip = _G.GameTooltip 

-- Registries
local ButtonRegistry = {} -- all buttons
local ActiveButtons = {} -- currently active buttons
local ActionButtons = {} -- action and stance buttons that currently hold an action

-- Stacks above this show as "*"
local MAX_DISPLAY_COUNT = 9999

-- Timer values for range and flash updates
local FLASH_TIMER = 0
local RANGE_TIMER = -1

-- Tracking whether or not all three modifiers are down.
-- We're using this to correcly fire the show/hide grid functions when holding the modifiers, 
-- without destroying the normal show/hide behaviour of the button grids.
local MODIFIERS_DOWN = false


-- Button Prototypes
------------------------------------------------------
local Button = CreateFrame("CheckButton")
local Button_MT = { __index = Button }

local ActionButton = setmetatable({}, { __index = Button })
local ActionButton_MT = { __index = ActionButton }

local PetActionButton = setmetatable({}, { __index = Button })
local PetActionButton_MT = { __index = PetActionButton }

local StanceButton = setmetatable({}, { __index = Button })
local StanceButton_MT = { __index = StanceButton }

-- button type meta mapping: the types the bars use (the same names as the
-- secure templates' button types)
local button_type_meta_map = {
	empty = Button_MT,
	action = ActionButton_MT,
	pet = PetActionButton_MT,
	stance = StanceButton_MT
}

-- Frame to gather up stuff we want to hide from the actionbutton templates
local UIHider = CreateFrame("Frame")
UIHider:Hide()

-- Button coloring
local colors = {
	-- icon coloring
	usable 				= { 1, 1, 1 }, -- normal icons
	unusable 			= { .3, .3, .3 }, -- used when icons can't be desaturated
	outOfRange 			= { 1, 0, 0 }, -- spell target is out of range (too far / too close)
	outOfMana 			= { 77/255, 77/255, 179/255 }, -- player has too little mana

	-- button texts
	keyText 			= { 1, 1, 1, 1 },
	keyTextDisabled 	= { .3 + .5*73/255, .3 + .5*25/255, .3 + .5*9/255 } -- C.Status.Dead
}

-- Button frequent update handler (range, flash)
local OnUpdate = function(self, elapsed)
	FLASH_TIMER = FLASH_TIMER - elapsed
	RANGE_TIMER = RANGE_TIMER - elapsed
	
	if (RANGE_TIMER <= 0) or (FLASH_TIMER <= 0) then
		for button in next, ActiveButtons do
			if button:IsShown() then

				-- Put the flash check before the range timer check
				if (button.flashing == 1) and (FLASH_TIMER <= 0) then
					if button.flash:IsShown() then
						button.flash:Hide()
					else
						button.flash:Show()
					end
				end

				if (RANGE_TIMER <= 0) then
					local outOfRange = not button:IsInRange()
					if (outOfRange ~= button.outOfRange) then
						button.outOfRange = outOfRange
						button:UpdateUsable("range")
					end
				end
			end
		end

		if (FLASH_TIMER <= 0) then
			FLASH_TIMER = .4 -- ATTACK_BUTTON_FLASH_TIME
		end

		if (RANGE_TIMER <= 0) then
			RANGE_TIMER = .2 -- TOOLTIP_UPDATE_TIME
		end
	end
end

-- In WotLK (possibly other old clients as well) desaturation of icons 
-- fail at the initial login or reload, for reasons I can't figure out. 
-- 
-- Might be something with the older graphics engine, or might even be 
-- the Wine Direct3D command stream since I'm using linux, for all I know. 
-- Though in the latter case, I would expect ALL clients to be affected, 
-- not just the older ones. So I'm leaning towards a blizzard problem. 
-- 
-- However, a simply 1 sec postponing of the update process along with 
-- a forced button usable update seems to handle the problem. 
local WaitForUpdates = function(self, elapsed)
	self.scheduleUpdate = (self.scheduleUpdate or 1) - elapsed
	if self.scheduleUpdate <= 0 then
		for button in next, ActiveButtons do
			button:UpdateUsable("forced")
		end	
		self:SetScript("OnUpdate", OnUpdate)
		self.scheduleUpdate = nil
	end
end


-- Tooltip Updates
--------------------------------------------------------------------
local UpdateTooltip
UpdateTooltip = function(self)
	if (GetCVar("UberTooltips") == "1") then
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	if self:SetTooltip() then
		self.UpdateTooltip = UpdateTooltip
	else
		self.UpdateTooltip = nil
	end
end


-- Button Template
--------------------------------------------------------------------

-- Figure out if the grid should be shown or not
Button.UpdateGrid = function(self)
	local showGrid
	if (self.showgrid == 0) then
		if self:GetTexture() or self:HasAction() then 
			showGrid = true
		else 
			if self.hidegrid then
				showGrid = false
			else
				showGrid = true
			end
		end
	else
		showGrid = true
	end

	self:SetAlpha(showGrid and 1 or 0)
end

-- Called when a show grid event is fired, 
-- not the same as definitely showing the grid. 
Button.ShowGrid = function(self)
	self.showgrid = self.showgrid + 1
	self:UpdateGrid()
end

-- Same applies to this as the show grid method.
Button.HideGrid = function(self)
	if self.showgrid > 0 then 
		self.showgrid = self.showgrid - 1 
	end
	self:UpdateGrid()
end

Button.UpdateTexture = function(self)
	local texture = self:GetTexture()
	if texture then
		self.icon:SetTexture(texture)
		self.icon:Show()
		self.keybind:SetVertexColor(unpack(colors.keyText))
	else
		self.icon:Hide()
		self.cooldown:Hide()
		self.keybind:SetVertexColor(unpack(colors.keyTextDisabled))
	end
end

Button.Update = function(self)
	if self:HasAction() then
		ActiveButtons[self] = true
		
		if (self.type_by_state == "pet") then
			ActionButtons[self] = nil

			local name, subtext, _, isToken, _, autoCastAllowed, autoCastEnabled = GetPetActionInfo(self.id)
		
			-- needed for tooltip functionality
			self.tooltipName = isToken and _G[name] or name
			self.tooltipSubtext = subtext
			
			if autoCastAllowed then
				if autoCastEnabled then
					self.autocastable:Hide()
					AutoCastShine_AutoCastStart(self.autocast)
				else
					self.autocastable:Show()
					AutoCastShine_AutoCastStop(self.autocast)
				end
			else
				self.autocastable:Hide()
				AutoCastShine_AutoCastStop(self.autocast)
			end

		else
			-- (only action, pet and stance buttons ever hold an action)
			ActionButtons[self] = true
		end

		self.icon:Show()

		self:SetAlpha(1.0)

		self:UpdateChecked()
		self:UpdateUsable()
		self:UpdateCooldown()
		self:UpdateFlash()

	else
		ActiveButtons[self] = nil
		ActionButtons[self] = nil

		if (self.type_by_state == "pet") then
			self.autocastable:Hide()
			AutoCastShine_AutoCastStop(self.autocast)

			self:SetNormalTexture("")
		end

		self.icon:Hide()
		self.cooldown:Hide()

		self:SetChecked(false)
	end

	self:UpdateTexture()
	self:UpdateBindings()
	self:UpdateGrid()
	self:UpdateCount()

	if (GameTooltip:GetOwner() == self) then
		UpdateTooltip(self)
	end

	if self.PostUpdate then
		return self:PostUpdate()
	end	

end

-- Updates the current action of the button
-- for the insecure environment. 
Button.UpdateAction = function(self, force)
	local button_type, button_action = self:GetAction()
	if force or (button_type ~= self.type_by_state) or (button_action ~= self.action_by_state) then
		if force or (self.type_by_state ~= button_type) then
			setmetatable(self, button_type_meta_map[button_type] or button_type_meta_map.empty)
			self.type_by_state = button_type
		end
		self.action_by_state = button_action
		self:Update()
	end	
end

-- Retrieves button type and button action for the current state.
-- Unless the button_state is given, the header's state will be assumed.
Button.GetAction = function(self, button_state)
	if not button_state then 
		button_state = self.header:GetAttribute("state") 
	end
	button_state = tostring(button_state)
	return self._type_by_state[button_state] or "empty", self._action_by_state[button_state]
end

-- assign a type and an action to a button for the given state
Button.SetStateAction = function(self, button_state, button_type, button_action)
	button_state = tostring(button_state)
	self._type_by_state[button_state] = button_type
	self._action_by_state[button_state] = button_action
	
	self:SetAttribute(format("type-by-state-%s", button_state), button_type)
	self:SetAttribute(format("action-by-state-%s", button_state), button_action)
end

Button.OnEnter = function(self)
	self._highlighted = true
	UpdateTooltip(self)
	if self.PostMouseEnter then
		return self:PostMouseEnter()
	end	
end

Button.OnLeave = function(self)
	self._highlighted = nil
	GameTooltip:Hide()
	if self.PostMouseLeave then
		return self:PostMouseLeave()
	end	
end

Button.OnMouseDown = function(self, ...) 
	if self.PostMouseDown then
		return self:PostMouseDown(...)
	end	
end

Button.OnMouseUp = function(self, ...)  
	if self.PostMouseUp then
		return self:PostMouseUp(...)
	end	
end

-- update the checked status of a button (pet/minion autocast)
Button.UpdateChecked = function(self)
	local checked
	if (self.type_by_state == "pet") then
		if (self:IsCurrentlyActive() or self:IsAutoRepeat()) then
			checked = true
		else
			checked = false
		end
	else
		local get_checked = self:GetChecked()
		checked = (get_checked == true) or (get_checked == 1)
	end

	if (self._checked == checked) then
		return
	end

	self._checked = checked
	self:SetChecked(checked)

	if self.PostUpdateChecked then
		return self:PostUpdateChecked(checked)
	end	
end

-- The button template's OverrideBindingKey writes the binding text
-- (shortened, see modules/actionbars/elements/artwork.lua).
Button.UpdateBindings = function(self)
	return self:OverrideBindingKey((self:GetKeyBind() or ""))
end

Button.GetKeyBind = function(self)
	return self.keybindAction and GetBindingKey(self.keybindAction) or GetBindingKey("CLICK "..self:GetName()..":LeftButton")
end

Button.SetBindingAction = function(self, keybindAction)
	self.keybindAction = keybindAction
end

-- updates whether or not the button is usable
Button.UpdateUsable = function(self, updateType)
	-- Speed!
	local colors = colors
	local icon = self.icon

	local isUsable, notEnoughMana = self:IsUsable()
	local previousUsableState = self.usableState

	-- Values we pass on to PostUpdate
	local canDesaturate, usableState
	-- (IsUsableAction reports "not enough mana" as not usable, so it's checked first)
	if UnitIsDeadOrGhost("player") then
		usableState = "taxi"
	elseif notEnoughMana then
		usableState = "mana"
	elseif (not isUsable) then
		usableState = "unusable"
	elseif (self.outOfRange or not(self:IsInRange())) then
		usableState = "range"
	else
		usableState = "usable"
	end

	-- bail out of nothing actually has changed
	if (previousUsableState == usableState) and (updateType ~= "forced") then 
		return
	end

	-- store the current state to avoid extra updates
	self.usableState = usableState

	-- Change what needs to be changed
	--  "taxi" is meant to apply to all states where 
	--   the buttons can't really be used at all.
	if (usableState == "taxi") then
		-- NOTE!
		-- SetDesaturated FAILS early in the reload process, for reasons unknown.
		-- I've only encountered this in WotLK so far, not in Legion. 
		-- I've yet to try Cata and MoP. Will do later. 

		-- attempt to desaturate when on a taxi or flying, 
		-- to give the impression of a deactivated button
		canDesaturate = icon:SetDesaturated(true) -- need to pass on the results of this to PostUpdate 
		if canDesaturate then 
			icon:SetVertexColor(colors.usable[1], colors.usable[2], colors.usable[3])
		else
			-- fallback to standard darkening if desaturation fails
			icon:SetDesaturated(false)
			icon:SetVertexColor(colors.unusable[1], colors.unusable[2], colors.unusable[3])
		end
	else
		if (usableState == "unusable") then
			icon:SetDesaturated(false)
			icon:SetVertexColor(colors.unusable[1], colors.unusable[2], colors.unusable[3])
		elseif (usableState == "range") then
			icon:SetDesaturated(false)
			icon:SetVertexColor(colors.outOfRange[1], colors.outOfRange[2], colors.outOfRange[3])
		elseif (usableState == "usable") then
			icon:SetDesaturated(false)
			icon:SetVertexColor(colors.usable[1], colors.usable[2], colors.usable[3])
		elseif (usableState == "mana") then
			icon:SetDesaturated(false)
			icon:SetVertexColor(colors.outOfMana[1], colors.outOfMana[2], colors.outOfMana[3])
		end
	end 

	if self.PostUpdateUsable then
		return self:PostUpdateUsable(usableState, canDesaturate)
	end	
end

-- Updates the cooldown of a button
Button.UpdateCooldown = function(self)
	local start, duration, enable = self:GetCooldown()
	if (enable ~= 0) and (duration > .5) then
		self.cooldown:SetCooldown(start, duration)
		self.cooldown:Show()
	else
		self.cooldown:Hide()
	end
end

Button.StartFlash = function(self)
	self.flashing = 1
end

Button.StopFlash = function(self)
	self.flashing = 0
	self.flash:Hide()
end

Button.UpdateFlash = function(self)
	if (self:IsAttack() and self:IsCurrentlyActive()) or self:IsAutoRepeat() then
		self:StartFlash()
	else
		self:StopFlash()
	end
end

Button.UpdateCount = function(self)
	if (not self:HasAction()) then
		self.stack:SetText("")
		return
	end
	if self:IsConsumableOrStackable() then
		local count = self:GetCount()
		if count > MAX_DISPLAY_COUNT then
			self.stack:SetText("*")
		else
			self.stack:SetText(count)
		end
	else
		self.stack:SetText("")
	end
end


-- Button API Mapping
-----------------------------------------------------------

--- Generic Button API mapping
Button.HasAction						= function(self) return nil end
Button.GetTexture						= function(self) return nil end
Button.GetCount							= function(self) return 0 end
Button.GetCooldown						= function(self) return 0, 0, 0 end
Button.IsAttack							= function(self) return nil end
Button.IsCurrentlyActive				= function(self) return nil end
Button.IsAutoRepeat						= function(self) return nil end
Button.IsUsable							= function(self) return nil end
Button.IsConsumableOrStackable 			= function(self) return nil end
Button.GetRangeCheck					= function(self) return nil end -- 1 in range, 0 out of it, nil no range
Button.IsInRange						= function(self)
	-- (no range counts as in range)
	return self:GetRangeCheck() ~= 0
end
Button.SetTooltip						= function(self) return nil end

-- Action Button API mapping
ActionButton.HasAction					= function(self) return HasAction(self.action_by_state) end
ActionButton.GetTexture					= function(self) return GetActionTexture(self.action_by_state) end
ActionButton.GetCount					= function(self) return GetActionCount(self.action_by_state) end
ActionButton.GetCooldown				= function(self) return GetActionCooldown(self.action_by_state) end
ActionButton.IsAttack					= function(self) return IsAttackAction(self.action_by_state) end
ActionButton.IsCurrentlyActive			= function(self) return IsCurrentAction(self.action_by_state) end
ActionButton.IsAutoRepeat				= function(self) return IsAutoRepeatAction(self.action_by_state) end
ActionButton.IsUsable					= function(self) return IsUsableAction(self.action_by_state) end
ActionButton.IsConsumableOrStackable	= function(self) return IsConsumableAction(self.action_by_state) or IsStackableAction(self.action_by_state) end
ActionButton.GetRangeCheck				= function(self) return IsActionInRange(self.action_by_state) end
ActionButton.SetTooltip					= function(self) return GameTooltip:SetAction(self.action_by_state) end


--- Pet Button
PetActionButton.HasAction				= function(self) return GetPetActionInfo(self.id) end
PetActionButton.GetCooldown				= function(self) return GetPetActionCooldown(self.id) end
PetActionButton.IsCurrentlyActive		= function(self) return select(5, GetPetActionInfo(self.id)) end
PetActionButton.IsAutoRepeat			= function(self) return nil end
PetActionButton.SetTooltip				= function(self) 
	if (not self.tooltipName) then
		return
	end

	GameTooltip:SetText(self.tooltipName, 1.0, 1.0, 1.0)

	if self.tooltipSubtext then
		GameTooltip:AddLine(self.tooltipSubtext, 0.5, 0.5, 0.5)
	end

	-- We need an extra :Show(), or the tooltip will get the wrong height if it has a subtext.
	-- (Not GameTooltip:SetPetAction: it doesn't work for the generic attack, defend and so on.)
	return GameTooltip:Show()
end
PetActionButton.IsAttack				= function(self) return nil end
PetActionButton.IsUsable				= function(self) return GetPetActionsUsable() end
PetActionButton.GetTexture				= function(self)
	local _, _, texture, isToken = GetPetActionInfo(self.id)
	return isToken and _G[texture] or texture
end

--- Stance Button
StanceButton.HasAction 					= function(self) return GetShapeshiftFormInfo(self.id) end
StanceButton.GetCooldown 				= function(self) return GetShapeshiftFormCooldown(self.id) end
StanceButton.GetTexture 				= function(self) return GetShapeshiftFormInfo(self.id) end
StanceButton.IsCurrentlyActive 			= function(self) return select(3,GetShapeshiftFormInfo(self.id)) end
StanceButton.IsUsable 					= function(self) return select(4,GetShapeshiftFormInfo(self.id)) end
StanceButton.SetTooltip					= function(self) return GameTooltip:SetShapeshift(self.id) end


Handler.OnEvent = function(self, event, ...)
	local arg1 = ...


	if (event == "ACTIONBAR_SLOT_CHANGED") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) and (button.type_by_state == "action") and ((arg1 == 0) or (arg1 == tonumber(button.action_by_state))) then
				button:Update()
			end
		end
		
	elseif (event == "UPDATE_SHAPESHIFT_FORM") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:UpdateTexture()
			end
		end
	elseif (event == "CURRENT_SPELL_CAST_CHANGED") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:UpdateTexture()
			end
		end
	elseif (event == "PLAYER_ENTERING_WORLD") or (event == "UPDATE_VEHICLE_ACTIONBAR") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:Update()
			end
		end

	elseif (event == "ACTIONBAR_SHOWGRID") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) and (button.type_by_state ~= "pet") then
				button:ShowGrid()
			end
		end

	elseif (event == "ACTIONBAR_HIDEGRID") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) and (button.type_by_state ~= "pet") then
				button:HideGrid()
			end
		end
	
	elseif (event == "MODIFIER_STATE_CHANGED") then
		if IsShiftKeyDown() and IsAltKeyDown() and IsControlKeyDown() then
			if (not MODIFIERS_DOWN) then
				MODIFIERS_DOWN = true
				for button in next, ButtonRegistry do
					if (button:IsShown()) then
						button:ShowGrid()
					end
				end
			end
		else
			if MODIFIERS_DOWN then
				MODIFIERS_DOWN = false
				for button in next, ButtonRegistry do
					button:HideGrid()
				end
			end
		end
	
	elseif (event == "UPDATE_BINDINGS") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:UpdateBindings()
			end
		end

	elseif (event == "ACTIONBAR_UPDATE_STATE") 
	or ((event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE") and (arg1 == "player")) 
	or ((event == "COMPANION_UPDATE") and (arg1 == "MOUNT")) then
		for button in next, ActiveButtons do
			button:UpdateUsable()
		end

		-- needed after ACTIONBAR_UPDATE_STATE 
		for button in next, ActionButtons do
			button:UpdateUsable()
		end

	elseif (event == "ACTIONBAR_UPDATE_USABLE") then
		for button in next, ActionButtons do
			button:UpdateUsable()
		end
		
	elseif (event == "UPDATE_SHAPESHIFT_COOLDOWN")
	or (event == "ACTIONBAR_UPDATE_COOLDOWN") then
		for button in next, ActionButtons do
			button:UpdateCooldown()
		end

	elseif (event == "TRADE_SKILL_SHOW") or (event == "TRADE_SKILL_CLOSE") then
		for button in next, ActiveButtons do
			button:UpdateChecked()
		end
	
	elseif (event == "PLAYER_ENTER_COMBAT") then
		for button in next, ActiveButtons do
			if button:IsAttack() then
				button:StartFlash()
			end
		end
	
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		for button in next, ActiveButtons do
			if button:IsAttack() then
				button:StopFlash()
			end
		end
	
	elseif (event == "START_AUTOREPEAT_SPELL") then
		for button in next, ActiveButtons do
			if button:IsAutoRepeat() then
				button:StartFlash()
			end
		end
	
	elseif (event == "STOP_AUTOREPEAT_SPELL") then
		for button in next, ActiveButtons do
			if (button.flashing == 1) and (not button:IsAttack()) then
				button:StopFlash()
			end
		end
	
	elseif (event == "PET_STABLE_UPDATE") or (event == "PET_STABLE_SHOW") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:Update()
			end
		end
	
	elseif (event == "PET_BAR_SHOWGRID") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) and (button.type_by_state == "pet") then
				button:ShowGrid()
			end
		end
	
	elseif (event == "PET_BAR_HIDEGRID") then
		for button in next, ButtonRegistry do
			if (button.type_by_state == "pet") then
				button:HideGrid()
			end
		end
	
	-- Various pet bar related updates
	elseif (event == "PET_BAR_UPDATE") 
	or (event == "SPELLS_CHANGED")
	or (event == "PET_BAR_UPDATE_COOLDOWN")
	or (event == "UNIT_PET" and arg1 == "player") 
	or ((event == "UNIT_FLAGS" or event == "UNIT_AURA") and arg1 == "pet")
	or (event == "PLAYER_FARSIGHT_FOCUS_CHANGED") then
		for button in next, ButtonRegistry do
			if (button.type_by_state == "pet") and (button:IsShown()) then
				button:Update()
			end
		end

	-- Usable pet spells changed 
	elseif (event == "PET_BAR_UPDATE_USABLE") then
		for button in next, ButtonRegistry do
			if (button.type_by_state == "pet") and (button:IsShown()) then
				button:UpdateUsable()
			end
		end

	-- Fired when player control is lost/gained or when the player takes an automated flight path
	elseif (event == "PLAYER_CONTROL_LOST") or (event == "PLAYER_CONTROL_GAINED") then
		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:Update()
			end
		end

	-- Cast on key down or up. In most cases this won't happen in combat,
	-- but better to be safe than sorry.
	elseif ((event == "CVAR_UPDATE") and ((arg1 == "ACTION_BUTTON_USE_KEY_DOWN") or (arg1 == "LOCK_ACTIONBAR_TEXT")))
	or (event == "PLAYER_REGEN_ENABLED") then
		if InCombatLockdown() then
			return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
		end
		if (event == "PLAYER_REGEN_ENABLED") then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
		end
		local clicks = GetCVarBool("ActionButtonUseKeyDown") and "AnyDown" or "AnyUp"
		for button in next, ButtonRegistry do
			button:RegisterForClicks(clicks)
		end
	end
end

Handler.LoadEvents = function(self)
	-- Ordering them by the alphabet, because my brain turns to mush here.

	self:RegisterEvent("ACTIONBAR_HIDEGRID", "OnEvent")
	self:RegisterEvent("ACTIONBAR_SHOWGRID", "OnEvent")
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "OnEvent")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "OnEvent")
	self:RegisterEvent("ACTIONBAR_UPDATE_STATE", "OnEvent")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE", "OnEvent")
	self:RegisterEvent("COMPANION_UPDATE", "OnEvent")
	self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", "OnEvent")
	self:RegisterEvent("CVAR_UPDATE", "OnEvent") -- cast on up/down
	self:RegisterEvent("MODIFIER_STATE_CHANGED", "OnEvent") -- to track modifier / grid display
	self:RegisterEvent("PET_BAR_HIDEGRID", "OnEvent")
	self:RegisterEvent("PET_BAR_SHOWGRID", "OnEvent")
	self:RegisterEvent("PET_BAR_UPDATE", "OnEvent")
	self:RegisterEvent("PET_BAR_UPDATE_USABLE", "OnEvent")
	self:RegisterEvent("PET_STABLE_SHOW", "OnEvent")
	self:RegisterEvent("PET_STABLE_UPDATE", "OnEvent")
	self:RegisterEvent("PLAYER_CONTROL_GAINED", "OnEvent")
	self:RegisterEvent("PLAYER_CONTROL_LOST", "OnEvent")
	self:RegisterEvent("PLAYER_ENTER_COMBAT", "OnEvent")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT", "OnEvent")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
	self:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED", "OnEvent")
	self:RegisterEvent("START_AUTOREPEAT_SPELL", "OnEvent")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL", "OnEvent")
	self:RegisterEvent("TRADE_SKILL_CLOSE", "OnEvent")
	self:RegisterEvent("TRADE_SKILL_SHOW", "OnEvent")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE", "OnEvent")
	self:RegisterEvent("UNIT_EXITED_VEHICLE", "OnEvent")
	self:RegisterEvent("UNIT_AURA", "OnEvent")
	self:RegisterEvent("UNIT_PET", "OnEvent")
	self:RegisterEvent("UPDATE_BINDINGS", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "OnEvent")
	self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", "OnEvent")
	self:RegisterEvent("SPELLS_CHANGED", "OnEvent")
	self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", "OnEvent")
end

Handler.Start = function(self, event)
	-- Unregister the event that brought us here
	self:UnregisterEvent(event, "Start")

	-- Initialize the handler for real
	self:LoadEvents()

	-- Start the range and flash updates
	Engine:CreateFrame("Frame", nil, "UICenter"):SetScript("OnUpdate", WaitForUpdates)

	-- Fire the original event in the new event handler
	self:OnEvent(event)
end

Handler.OnEnable = function(self)
	-- Only register this event here, 
	-- to avoid the handler starting updates too early.
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Start")
end

-- button constructor
Handler.New = function(self, buttonType, id, header, buttonTemplate, ...)

	-- I would like to completely avoid frame names in this UI, 
	-- to avoid any sort of external tampering, 
	-- but currently button names are required to fully support
	-- the keybind functionality of the blizzard UI. >:(
	local name
	if (type(header.id) == "number") and (header.id > 0) then
		local button_num = id > NUM_ACTIONBAR_BUTTONS and id%NUM_ACTIONBAR_BUTTONS or id
		local bar_num
		if header.id == 1 then
			bar_num = 1
		elseif header.id == BOTTOMLEFT_ACTIONBAR_PAGE then
			bar_num = 2
		elseif header.id == BOTTOMRIGHT_ACTIONBAR_PAGE then
			bar_num = 3
		elseif header.id == RIGHT_ACTIONBAR_PAGE then
			bar_num = 4
		elseif header.id == LEFT_ACTIONBAR_PAGE then
			bar_num = 5
		end
		name = "EngineBar"..bar_num.."Button"..button_num
	elseif (header.id == "stance") then
		name = "EngineStanceBarButton"..id
	elseif (header.id == "pet") then
		name = "EnginePetBarButton"..id
	elseif (header.id == "vehicle") then
		name = "EngineVehicleBarButton"..id
	end
	
	local button
	if (buttonType == "pet") then
		button = setmetatable(Engine:CreateFrame("CheckButton", name , header, "PetActionButtonTemplate"), Button_MT)
		button:UnregisterAllEvents()
		button:SetScript("OnEvent", nil)
		button:SetScript("OnUpdate", nil)
		button:SetScript("OnDragStart", nil)
		button:SetScript("OnReceiveDrag", nil)
		
	elseif (buttonType == "stance") then
		button = setmetatable(Engine:CreateFrame("CheckButton", name , header, "ShapeshiftButtonTemplate"), Button_MT)
		button:UnregisterAllEvents()
		button:SetScript("OnEvent", nil)
		
	else
		button = setmetatable(Engine:CreateFrame("CheckButton", name , header, "SecureActionButtonTemplate, ActionButtonTemplate"), Button_MT)
		button:RegisterForDrag("LeftButton", "RightButton")
		
		local cast_on_down = GetCVarBool("ActionButtonUseKeyDown")
		if cast_on_down then
			button:RegisterForClicks("AnyDown")
		else
			button:RegisterForClicks("AnyUp")
		end
	end
	
	button.config = header.config
	button.id = id -- the initial id (or action) of the button
	button.header = header -- header/parent containing statedrivers and layout methods
	button.showgrid = 0 -- mostly used for pet and stance, but we're adding it in for all
	button.hidegrid = header.hideGrid

	-- (Our own checked and highlight looks are kept in button._checked
	-- and button._highlighted.)

	-- tables to hold the button type and button action, 
	-- for the various states the button can have. 
	button._action_by_state = {} -- if the button action changes with its state/page
	button._type_by_state = {} -- if the button type changes with its state/page
	button.action_by_state = button.id -- initial/current action
	button.type_by_state = buttonType -- store the button type for faster reference

	button:SetID(id)
	button:SetAttribute("type", buttonType) -- assign the correct button type for the secure templates

	-- TODO: let the user control clicks and locks
	button:SetAttribute("buttonlock", true)

	-- Drag N Drop Fuctionality, allow the user to pick up and drop stuff on the buttons! 
	-- params:
	-- 		self = the actionbutton frame handle
	-- 		button = the mousebutton clicked to start the drag
	--  	kind = what kind of action is picked up (nil?)
	-- 		value = detail of the thing on the cursor 
	--
	-- returns: ["clear",] kind, value
	header:WrapScript(button, "OnDragStart", [[
		local button_state = self:GetParent():GetAttribute("state"); 
		if not button_state then
			return
		end
		local action_by_state = self:GetAttribute(format("action-by-state-%s", button_state));
		if action_by_state and (IsShiftKeyDown() and IsAltKeyDown() and IsControlKeyDown()) then
			if self:GetAttribute("type") == "pet" then
				return "petaction", action_by_state
			else
				return "action", action_by_state
			end
		end
	]])
	setmetatable(button, button_type_meta_map[buttonType]) -- assign correct metatable

	-- Explicitly place the button above its own bar, instead of relying on
	-- whatever level the button template or CreateFrame's default happens
	-- to pick. Without this, decorative overlay artwork (like the demon
	-- and angel textures next to the side bars) could end up drawn on top
	-- of the buttons instead of behind them.
	button:SetFrameLevel(header:GetFrameLevel() + 1)

	-- Frames and Layers
	---------------------------------------------------------

	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetSize(button:GetSize())
	button.icon:SetPoint("CENTER", 0, 0)
	button.icon:SetTexCoord(5/64, 59/64, 5/64, 59/64) 

	button.flash = button:CreateTexture(nil, "OVERLAY")
	button.flash:SetAllPoints(button.icon)
	button.flash:SetTexture(.7, 0, 0, .3)
	button.flash:Hide()

	button.name = button:CreateFontString(nil, "OVERLAY")
	button.name:SetFontObject(GameFontNormal)
	button.name:SetPoint("BOTTOM")

	button.stack = button:CreateFontString(nil, "OVERLAY")
	button.stack:SetFontObject(GameFontNormal)
	button.stack:SetPoint("BOTTOMRIGHT")

	button.keybind = button:CreateFontString(nil, "OVERLAY")
	button.keybind:SetFontObject(GameFontNormal)
	button.keybind:SetPoint("TOPRIGHT")

	-- We're doing these ourselves with our own system, 
	-- so we simply blank out the ones existing
	-- in the blizzard templates. 
	button:SetCheckedTexture("")
	button:SetHighlightTexture("")
	button:SetNormalTexture("")

	-- cooldown frame
	-- stance and pet buttons have this in their template, I think
	local oldCooldown = _G[button:GetName().."Cooldown"] 
	if oldCooldown then
		oldCooldown:SetParent(UIHider)
		oldCooldown:SetAlpha(0)
		oldCooldown:Hide()
	end

	button.cooldown = button:CreateFrame("Cooldown", nil, "CooldownFrameTemplate")
	button.cooldown:SetAllPoints(button.icon)
	button.cooldown:SetFrameLevel(button:GetFrameLevel() + 3)

	button.cooldown:SetAlpha(.75)

	-- let blizz handle this one
	button.pushed = button:CreateTexture(nil, "OVERLAY")
	button.pushed:SetAllPoints(button.icon)
	button.pushed:SetTexture(1, 1, 1, .25)

	button:SetPushedTexture(button.pushed)
	button:GetPushedTexture():SetBlendMode("BLEND")
	
	-- We need to put it back in its correct drawlayer, 
	-- or Blizzard will set it to ARTWORK which can lead 
	-- to it randomly being drawn behind the icon texture. 
	button:GetPushedTexture():SetDrawLayer("OVERLAY") 
		
	-- cooldown numbers
	button.cooldowncount = button:CreateFontString(nil, "OVERLAY")
	button.cooldowncount:SetFontObject(GameFontNormal)
	button.cooldowncount:SetPoint("CENTER")

	-- autocast texture
	-- exists on pet button templates
	if (buttonType == "pet") then
		button.autocastable = _G[button:GetName() .. "AutoCastable"]
		button.autocastable:SetDrawLayer("OVERLAY")
		
		button.autocast = _G[button:GetName() .. "Shine"]
		button.autocast:SetAllPoints(button.icon)
		button.autocast:SetFrameLevel(button:GetFrameLevel() + 4)
	end

	-- assign our own scripts
	button:SetScript("OnEnter", button.OnEnter)
	button:SetScript("OnLeave", button.OnLeave)
	button:SetScript("OnMouseDown", button.OnMouseDown)
	button:SetScript("OnMouseUp", button.OnMouseUp)

	-- This solves the checking for our custom textures
	hooksecurefunc(button, "SetChecked", function(self)
		if self.PostUpdateChecked then
			return self:PostUpdateChecked(self._checked)
		end	
	end)

	-- Add any methods from the optional template.
	-- This can NOT override existing methods!
	if buttonTemplate then
		for name, method in pairs(buttonTemplate) do
			if (not button[name]) then
				button[name] = method
			end
		end
	end

	-- Call the post create method if it exists, 
	-- and pass along any remaining arguments.
	if button.PostCreate then
		button:PostCreate(...)
	end

	-- Add the new button to our registry
	ButtonRegistry[button] = true
	
	-- Return the button to whatever requested it
	return button
end
