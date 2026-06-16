local ADDON, Engine = ...
local Handler = Engine:NewHandler("ActionButton")

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local select = select
local setmetatable = setmetatable
local string_match = string.match
local table_insert = table.insert
local table_remove = table.remove
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

-- WoW API
local AutoCastShine_AutoCastStart = _G.AutoCastShine_AutoCastStart
local AutoCastShine_AutoCastStop = _G.AutoCastShine_AutoCastStop
local CreateFrame = _G.CreateFrame
local FindSpellBookSlotBySpellID = _G.FindSpellBookSlotBySpellID
local FlyoutHasSpell = _G.FlyoutHasSpell
local GetActionCharges = _G.GetActionCharges
local GetActionCooldown = _G.GetActionCooldown
local GetActionCount = _G.GetActionCount
local GetActionInfo = _G.GetActionInfo
local GetActionLossOfControlCooldown = _G.GetActionLossOfControlCooldown
local GetActionText = _G.GetActionText
local GetActionTexture = _G.GetActionTexture
local GetItemCooldown = _G.GetItemCooldown
local GetItemCount = _G.GetItemCount
local GetItemIcon = _G.GetItemIcon
local GetItemInfo = _G.GetItemInfo
local GetMacroInfo = _G.GetMacroInfo
local GetMacroSpell = _G.GetMacroSpell
local GetPetActionCooldown = _G.GetPetActionCooldown
local GetPetActionInfo = _G.GetPetActionInfo
local GetPetActionsUsable = _G.GetPetActionsUsable
local GetShapeshiftFormCooldown = _G.GetShapeshiftFormCooldown
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local GetSpellCharges = _G.GetSpellCharges
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellCount = _G.GetSpellCount
local GetSpellTexture = _G.GetSpellTexture
local HasAction = _G.HasAction
local InCombatLockdown = _G.InCombatLockdown
local IsActionInRange = _G.IsActionInRange
local IsAttackAction = _G.IsAttackAction
local IsAttackSpell = _G.IsAttackSpell
local IsAutoRepeatAction = _G.IsAutoRepeatAction
local IsAutoRepeatSpell = _G.IsAutoRepeatSpell
local IsCurrentAction = _G.IsCurrentAction
local IsConsumableAction = _G.IsConsumableAction
local IsConsumableItem = _G.IsConsumableItem
local IsConsumableSpell = _G.IsConsumableSpell
local IsCurrentItem = _G.IsCurrentItem
local IsCurrentSpell = _G.IsCurrentSpell
local IsEquippedAction = _G.IsEquippedAction
local IsEquippedItem = _G.IsEquippedItem
local IsFlying = _G.IsFlying
local IsInInstance = _G.IsInInstance
local IsItemAction = _G.IsItemAction
local IsItemInRange = _G.IsItemInRange
local IsSpellInRange = _G.IsSpellInRange
local IsStackableAction = _G.IsStackableAction
local IsUsableAction = _G.IsUsableAction
local IsUsableItem = _G.IsUsableItem
local IsUsableSpell = _G.IsUsableSpell
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitOnTaxi = _G.UnitOnTaxi

-- Will replace these with our custom tooltiplib later on!
local GameTooltip = _G.GameTooltip 

-- Cooldown type constants
local COOLDOWN_TYPE_LOSS_OF_CONTROL = _G.COOLDOWN_TYPE_LOSS_OF_CONTROL
local COOLDOWN_TYPE_NORMAL = _G.COOLDOWN_TYPE_NORMAL

-- Registries
local ButtonRegistry = {} -- all buttons
local ActiveButtons = {} -- currently active buttons
local ActionButtons = {} -- buttons that currently hold an action
local NonActionButtons = {} -- buttons that don't hold an action (spell, macro, etc)

-- Blizzard textures needed
local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local EMPTY_SLOT = [[Interface\Buttons\UI-Quickslot]]
local FILLED_SLOT = [[Interface\Buttons\UI-Quickslot2]]

-- these exist in WoD and beyond
local EDGE_LOC_TEXTURE = [[Interface\Cooldown\edge-LoC]]
local EDGE_NORMAL_TEXTURE = [[Interface\Cooldown\edge]]
local BLING_TEXTURE = [[Interface\Cooldown\star4]]

-- Timer values for range and flash updates
local FLASH_TIMER = 0
local RANGE_TIMER = -1

-- Tracking whether or not all three modifiers are down.
-- We're using this to correcly fire the show/hide grid functions when holding the modifiers, 
-- without destroying the normal show/hide behaviour of the button grids.
local MODIFIERS_DOWN = false

-- Tracking whether or not the player is currently flying
local IS_FLYING = nil

-- Tracking whether or not the player is in an instance
local INSTANCE = IsInInstance()


-- Button Prototypes
------------------------------------------------------
local Button = CreateFrame("CheckButton")
local Button_MT = { __index = Button }

local ActionButton = setmetatable({}, { __index = Button })
local ActionButton_MT = { __index = ActionButton }

local PetActionButton = setmetatable({}, { __index = Button })
local PetActionButton_MT = { __index = PetActionButton }

local SpellButton = setmetatable({}, { __index = Button })
local SpellButton_MT = { __index = SpellButton }

local ItemButton = setmetatable({}, { __index = Button })
local ItemButton_MT = { __index = ItemButton }

local MacroButton = setmetatable({}, { __index = Button })
local MacroButton_MT = { __index = MacroButton }

local CustomButton = setmetatable({}, { __index = Button })
local CustomButton_MT = { __index = CustomButton }

local ExtraButton = setmetatable({}, { __index = Button })
local ExtraButton_MT = { __index = ExtraButton }

local StanceButton = setmetatable({}, { __index = Button })
local StanceButton_MT = { __index = StanceButton }

-- button type meta mapping 
-- *types are the same as used by the secure templates
local button_type_meta_map = {
	empty = Button_MT,
	action = ActionButton_MT,
	pet = PetActionButton_MT,
	spell = SpellButton_MT,
	item = ItemButton_MT,
	macro = MacroButton_MT,
	custom = CustomButton_MT,
	extra = ExtraButton_MT,
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
	outOfRange 			= { 1, 0, 0 }, -- spell target is out of range (too far / too close) -- C.Status.OutOfRange
	outOfMana 			= { 77/255, 77/255, 179/255 }, -- player has too little mana -- C.Status.OutOfMana

	-- button texts
	stackText 			= { 1, 1, 1, 1 },
	nameText 			= { 1, 1, 1, 1 },
	keyText 			= { 1, 1, 1, 1 },
	keyTextDisabled 	= { .3 + .5*73/255, .3 + .5*25/255, .3 + .5*9/255 }, -- C.Status.Dead

	-- cooldown counters
	cooldownText = {}
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
			FLASH_TIMER = .4 -- FLASH_TIMER + .4 -- ATTACK_BUTTON_FLASH_TIME (0.4)
		end

		if (RANGE_TIMER <= 0) then
			RANGE_TIMER = .2 -- .05 -- TOOLTIP_UPDATE_TIME (0.2)
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


-- Utility Functions
--------------------------------------------------------------------
-- Item Button API mapping
local getItemId = function(input) 
	return input:match("^item:(%d+)") 
end


-- Tooltip Updates
--------------------------------------------------------------------
local UpdateTooltip
UpdateTooltip = function(self)
	if GameTooltip:IsForbidden() then
		return
	end
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

	if self.PreUpdateGrid then
		self:PreUpdateGrid(showGrid)
	end	

	self:SetAlpha(showGrid and 1 or 0)

	if self.PostUpdateGrid then
		return self:PostUpdateGrid(showGrid)
	end	
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
		if (texture ~= self.icon:GetTexture()) then
			self.icon:SetTexture(texture)
			self.icon:Show()
			self.keybind:SetVertexColor(unpack(colors.keyText))
		end
	else
		self.icon:Hide()
		self.cooldown:Hide()
		self.keybind:SetVertexColor(unpack(colors.keyTextDisabled))
	end
end

Button.Update = function(self)
	if self:HasAction() then
		ActiveButtons[self] = true
		
		if (self.type_by_state == "action") then
			ActionButtons[self] = true
			NonActionButtons[self] = nil
		
		elseif (self.type_by_state == "pet") then
			ActionButtons[self] = nil
			NonActionButtons[self] = nil

			local name, subtext, isToken, autoCastAllowed, autoCastEnabled
			name, subtext, _, isToken, _, autoCastAllowed, autoCastEnabled = GetPetActionInfo(self.id)
		
			-- needed for tooltip functionality
			self.tooltipName = isToken and _G[name] or name -- :GetActionText() also returns this
			self.isToken = isToken
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

		elseif (self.type_by_state == "stance") then
			ActionButtons[self] = true -- good idea? bad?
			NonActionButtons[self] = nil
		else
			ActionButtons[self] = nil
			NonActionButtons[self] = true
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
		NonActionButtons[self] = nil

		if (self.type_by_state == "pet") then
			ActionButtons[self] = nil
			NonActionButtons[self] = nil

			self.autocastable:Hide()
			AutoCastShine_AutoCastStop(self.autocast)

			self:SetNormalTexture("")
		end

		self.icon:Hide()
		self.cooldown:Hide()

		self:SetChecked(false)
	end
	
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
	
	self:UpdateTexture()
	self:UpdateBindings()
	self:UpdateGrid()
	self:UpdateCount()

	self:UpdateFlyout()

	if (not GameTooltip:IsForbidden()) and (GameTooltip:GetOwner() == self) then
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
	if (not button_state) then 
		button_state = self.header:GetAttribute("state") 
	end
	button_state = tostring(button_state)
	if (not button_type) then 
		button_type = "empty" 
	end
	if (button_type == "item") then
		if tonumber(button_action) then
			button_action = format("item:%s", button_action)
		else
			local itemString = string_match(button_action, "^|c%x+|H(item[%d:]+)|h%[")
			if itemString then
				button_action = itemString
			end
		end
	end

	self._type_by_state[button_state] = button_type
	self._action_by_state[button_state] = button_action
	
	self:SetAttribute(format("type-by-state-%s", button_state), button_type)
	self:SetAttribute(format("action-by-state-%s", button_state), button_action)
end

Button.PreClick = function(self)
end

Button.PostClick = function(self)
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
	if (not GameTooltip:IsForbidden()) then
		GameTooltip:Hide()
	end
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

Button.UpdateBindings = function(self)
	-- Allow the user to completely override this method
	-- Use this for custom or abbreviated keybinds
	if self.OverrideBindingKey then
		return self:OverrideBindingKey((self:GetKeyBind() or ""))
	end 

	-- Set to the default blizzard keybind text
	local keybind = self.keybind
	if keybind then
		keybind:SetText((self:GetKeyBind() or ""))
		keybind:Show()
	end

	-- The postupdate is only meant for other visuals, 
	-- not to affect the actual binding text.
	if self.PostUpdateBindings then
		return self:PostUpdateBindings()
	end
end

Button.GetKeyBind = function(self)
	return self.keybindAction and GetBindingKey(self.keybindAction) or GetBindingKey("CLICK "..self:GetName()..":LeftButton")
end

Button.SetBindingAction = function(self, keybindAction)
	self.keybindAction = keybindAction
end

-- updates whether or not the button is usable
Button.UpdateUsable = function(self, updateType, ...)
	if self.OverrideUsable then
		return self:OverrideUsable(updateType, ...)
	end

	-- Speed!
	local colors = colors
	local icon = self.icon

	local isUsable, notEnoughMana = self:IsUsable()
	local previousUsableState = self.usableState
	local cooldown = self:GetCooldown() 

	-- Values we pass on to PostUpdate
	local canDesaturate, usableState
	if UnitIsDeadOrGhost("player") then
		usableState = "taxi"
	elseif (not isUsable) then
		usableState = "unusable"
	elseif (self.outOfRange or not(self:IsInRange())) then
		usableState = "range"
	elseif isUsable then
		usableState = "usable"
	elseif (notEnoughMana) then 
		usableState = "mana"
	else
		usableState = "unusable"
	end

	-- bail out of nothing actually has changed
	if (previousUsableState == usableState) and (not forced) then 
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

Button.OnSecondaryCooldownDone = function(self)
	self:SetScript("OnCooldownDone", nil)
	self:GetParent():UpdateCooldown()
end

Button.OnCooldownDone = function(self)
	self:SetScript("OnCooldownDone", nil)

	-- Avoid the shine effect for very short cooldowns (global cooldown, etc)
	if (self.cooldownDuration) and (self.cooldownDuration >= 2) then
		self.shine:Start()
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
	--self.flash:Show()
end

Button.StopFlash = function(self)
	self.flashing = 0
	self.flash:Hide()
end

Button.UpdateFlash = function(self)
	local action = self.action_by_state
	if (self:IsAttack() and self:IsCurrentlyActive()) or self:IsAutoRepeat() then
		self:StartFlash()
	else
		self:StopFlash()
	end
end

Button.IsFlashing = function(self)
	return (self.flashing == 1)
end

Button.UpdateCount = function(self)
	if (not self:HasAction()) then
		self.stack:SetText("")
		return
	end
	if self:IsConsumableOrStackable() then
		local count = self:GetCount()
		if count > (self.maxDisplayCount or 9999) then
			self.stack:SetText("*")
		else
			self.stack:SetText(count)
		end
	else
		local charges, maxCharges, chargeStart, chargeDuration = self:GetCharges()
		if charges and maxCharges and (maxCharges > 1) and (charges > 0) then
			self.stack:SetText(charges)
		else
			self.stack:SetText("")
		end
	end
end


local unusedOverlays = {}
local numOverlays = 0

local overlayGlowAnimOutFinished = function(animGroup)
	local overlay = animGroup:GetParent()
	local frame = overlay:GetParent()
	overlay:Hide()
	table_insert(unusedOverlays, overlay)
	frame.OverlayGlow = nil
end

local createScaleAnim = function(group, target, order, duration, x, y, delay)
	local scale = group:CreateAnimation("Scale")
	scale:SetTarget(target:GetName())
	scale:SetOrder(order)
	scale:SetDuration(duration)
	scale:SetScale(x, y)

	if delay then
		scale:SetStartDelay(delay)
	end
end

local createAlphaAnim = function(group, target, order, duration, fromAlpha, toAlpha, delay)
	local alpha = group:CreateAnimation("Alpha")
	alpha:SetTarget(target:GetName())
	alpha:SetOrder(order)
	alpha:SetDuration(duration)
	alpha:SetFromAlpha(fromAlpha)
	alpha:SetToAlpha(toAlpha)

	if delay then
		alpha:SetStartDelay(delay)
	end
end

local createOverlayGlow = function()
	numOverlays = numOverlays + 1

	-- create frame and textures
	local name = "ButtonGlowOverlay" .. tostring(numOverlays)
	local overlay = CreateFrame("Frame", name, UIParent)

	-- spark
	overlay.spark = overlay:CreateTexture(name .. "Spark", "BACKGROUND")
	overlay.spark:SetPoint("CENTER")
	overlay.spark:SetAlpha(0)
	overlay.spark:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.spark:SetTexCoord(0.00781250, 0.61718750, 0.00390625, 0.26953125)

	-- inner glow
	overlay.innerGlow = overlay:CreateTexture(name .. "InnerGlow", "ARTWORK")
	overlay.innerGlow:SetPoint("CENTER")
	overlay.innerGlow:SetAlpha(0)
	overlay.innerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

	-- inner glow over
	overlay.innerGlowOver = overlay:CreateTexture(name .. "InnerGlowOver", "ARTWORK")
	overlay.innerGlowOver:SetPoint("TOPLEFT", overlay.innerGlow, "TOPLEFT")
	overlay.innerGlowOver:SetPoint("BOTTOMRIGHT", overlay.innerGlow, "BOTTOMRIGHT")
	overlay.innerGlowOver:SetAlpha(0)
	overlay.innerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.innerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

	-- outer glow
	overlay.outerGlow = overlay:CreateTexture(name .. "OuterGlow", "ARTWORK")
	overlay.outerGlow:SetPoint("CENTER")
	overlay.outerGlow:SetAlpha(0)
	overlay.outerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

	-- outer glow over
	overlay.outerGlowOver = overlay:CreateTexture(name .. "OuterGlowOver", "ARTWORK")
	overlay.outerGlowOver:SetPoint("TOPLEFT", overlay.outerGlow, "TOPLEFT")
	overlay.outerGlowOver:SetPoint("BOTTOMRIGHT", overlay.outerGlow, "BOTTOMRIGHT")
	overlay.outerGlowOver:SetAlpha(0)
	overlay.outerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.outerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

	-- ants
	overlay.ants = overlay:CreateTexture(name .. "Ants", "OVERLAY")
	overlay.ants:SetPoint("CENTER")
	overlay.ants:SetAlpha(0)
	overlay.ants:SetTexture([[Interface\SpellActivationOverlay\IconAlertAnts]])

	-- setup antimations
	overlay.animIn = overlay:CreateAnimationGroup()
	createScaleAnim(overlay.animIn, overlay.spark,          1, 0.2, 1.5, 1.5)
	createAlphaAnim(overlay.animIn, overlay.spark,          1, 0.2, 0, 1)
	createScaleAnim(overlay.animIn, overlay.innerGlow,      1, 0.3, 2, 2)
	createScaleAnim(overlay.animIn, overlay.innerGlowOver,  1, 0.3, 2, 2)
	createAlphaAnim(overlay.animIn, overlay.innerGlowOver,  1, 0.3, 1, 0)
	createScaleAnim(overlay.animIn, overlay.outerGlow,      1, 0.3, 0.5, 0.5)
	createScaleAnim(overlay.animIn, overlay.outerGlowOver,  1, 0.3, 0.5, 0.5)
	createAlphaAnim(overlay.animIn, overlay.outerGlowOver,  1, 0.3, 1, 0)
	createScaleAnim(overlay.animIn, overlay.spark,          1, 0.2, 2/3, 2/3, 0.2)
	createAlphaAnim(overlay.animIn, overlay.spark,          1, 0.2, 1, 0, 0.2)
	createAlphaAnim(overlay.animIn, overlay.innerGlow,      1, 0.2, 1, 0, 0.3)
	createAlphaAnim(overlay.animIn, overlay.ants,           1, 0.2, 0, 1, 0.3)

	overlay.animIn:SetScript("OnPlay", function(group)
		local frame = group:GetParent()
		local frameWidth, frameHeight = frame:GetSize()
		frame.spark:SetSize(frameWidth, frameHeight)
		frame.spark:SetAlpha(0.3)
		frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2)
		frame.innerGlow:SetAlpha(1.0)
		frame.innerGlowOver:SetAlpha(1.0)
		frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2)
		frame.outerGlow:SetAlpha(1.0)
		frame.outerGlowOver:SetAlpha(1.0)
		frame.ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
		frame.ants:SetAlpha(0)
		frame:Show()
	end)
	overlay.animIn:SetScript("OnFinished", function(group)
		local frame = group:GetParent()
		local frameWidth, frameHeight = frame:GetSize()
		frame.spark:SetAlpha(0)
		frame.innerGlow:SetAlpha(0)
		frame.innerGlow:SetSize(frameWidth, frameHeight)
		frame.innerGlowOver:SetAlpha(0.0)
		frame.outerGlow:SetSize(frameWidth, frameHeight)
		frame.outerGlowOver:SetAlpha(0.0)
		frame.outerGlowOver:SetSize(frameWidth, frameHeight)
		frame.ants:SetAlpha(1.0)
	end)

	overlay.animOut = overlay:CreateAnimationGroup()
	createAlphaAnim(overlay.animOut, overlay.outerGlowOver, 1, 0.2, 0, 1)
	createAlphaAnim(overlay.animOut, overlay.ants,          1, 0.2, 1, 0)
	createAlphaAnim(overlay.animOut, overlay.outerGlowOver, 2, 0.2, 1, 0)
	createAlphaAnim(overlay.animOut, overlay.outerGlow,     2, 0.2, 1, 0)

	overlay.animOut:SetScript("OnFinished", overlayGlowAnimOutFinished)

	-- scripts
	overlay:SetScript("OnUpdate", function(self, elapsed)
		AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, 0.01)
		local cooldown = self:GetParent().cooldown
		-- we need some threshold to avoid dimming the glow during the gdc
		-- (using 1500 exactly seems risky, what if casting speed is slowed or something?)
		if(cooldown and cooldown:IsShown() and cooldown:GetCooldownDuration() > 3000) then
			self:SetAlpha(.5)
		else
			self:SetAlpha(1)
		end
	end)
	overlay:SetScript("OnHide", function(self)
		if self.animOut:IsPlaying() then
			self.animOut:Stop()
			overlayGlowAnimOutFinished(self.animOut)
		end
	end)

	return overlay
end

local GetOverlayGlow = function()
	local overlay = table_remove(unusedOverlays)
	if not overlay then
		overlay = createOverlayGlow()
	end
	return overlay
end

Button.ShowOverlayGlow = function(self)
	if self.OverlayGlow then
		if self.OverlayGlow.animOut:IsPlaying() then
			self.OverlayGlow.animOut:Stop()
			self.OverlayGlow.animIn:Play()
		end
	else
		local overlay = GetOverlayGlow()
		local frameWidth, frameHeight = self:GetSize()
		overlay:SetParent(self)
		overlay:SetFrameLevel(self:GetFrameLevel() + 6)
		overlay:ClearAllPoints()
		--Make the height/width available before the next frame:
		overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4)
		overlay:SetPoint("TOPLEFT", self, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2)
		overlay:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2)
		overlay.animIn:Play()
		self.OverlayGlow = overlay
	end
end

Button.HideOverlayGlow = function(self)
	if self.OverlayGlow then
		if self.OverlayGlow.animIn:IsPlaying() then
			self.OverlayGlow.animIn:Stop()
		end
		if self:IsVisible() then
			self.OverlayGlow.animOut:Play()
		else
			overlayGlowAnimOutFinished(self.OverlayGlow.animOut)
		end
	end
end

Button.UpdateOverlayGlow = function(self)
	local spellId = self:GetSpellId()
	if spellId and IsSpellOverlayed(spellId) then
		self:ShowOverlayGlow()
	else
		self:HideOverlayGlow()
	end
end 

Button.UpdateFlyout = function(self)
	if not self.FlyoutBorder or not self.FlyoutBorderShadow then
		return
	end

	self.FlyoutBorder:Hide()
	self.FlyoutBorderShadow:Hide()

	if self.type_by_state == "action" then
		-- based on ActionButton_UpdateFlyout in ActionButton.lua
		local actionType = GetActionInfo(self.action_by_state)
		if actionType == "flyout" then
			-- Update border and determine arrow position
			local arrowDistance
			if (SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self then
				arrowDistance = 5
			else
				arrowDistance = 2
			end

			-- Update arrow
			self.FlyoutArrow:Show()
			self.FlyoutArrow:ClearAllPoints()
			local direction = self:GetAttribute("flyoutDirection")
			if direction == "LEFT" then
				self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
				SetClampedTextureRotation(self.FlyoutArrow, 270)
			elseif direction == "RIGHT" then
				self.FlyoutArrow:SetPoint("RIGHT", self, "RIGHT", arrowDistance, 0)
				SetClampedTextureRotation(self.FlyoutArrow, 90)
			elseif direction == "DOWN" then
				self.FlyoutArrow:SetPoint("BOTTOM", self, "BOTTOM", 0, -arrowDistance)
				SetClampedTextureRotation(self.FlyoutArrow, 180)
			else
				self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
				SetClampedTextureRotation(self.FlyoutArrow, 0)
			end

			-- return here, otherwise flyout is hidden
			return
		end
	end 
	self.FlyoutArrow:Hide()
end

Handler.StyleFlyouts = function(self)
	if not SpellFlyout then 
		return 
	end

	local GetFlyoutInfo = GetFlyoutInfo
	local GetNumFlyouts = GetNumFlyouts
	local GetFlyoutID = GetFlyoutID
	local SpellFlyout = SpellFlyout
	local SpellFlyoutBackgroundEnd = SpellFlyoutBackgroundEnd
	local SpellFlyoutHorizontalBackground = SpellFlyoutHorizontalBackground
	local SpellFlyoutVerticalBackground = SpellFlyoutVerticalBackground
	local numFlyoutButtons = 0
	local flyoutButtons = {}
	local buttonBackdrop = {
		bgFile = BLANK_TEXTURE,
		edgeFile = BLANK_TEXTURE,
		edgeSize = 1,
		insets = { 
			left = -1, 
			right = -1, 
			top = -1, 
			bottom = -1
		}
	}
	local UpdateFlyout = function(self)
		if not self.FlyoutArrow then return end
		SpellFlyoutHorizontalBackground:SetAlpha(0)
		SpellFlyoutVerticalBackground:SetAlpha(0)
		SpellFlyoutBackgroundEnd:SetAlpha(0)
		-- self.FlyoutBorder:SetAlpha(0)
		-- self.FlyoutBorderShadow:SetAlpha(0)
		for i = 1, GetNumFlyouts() do
			local _, _, numSlots, isKnown = GetFlyoutInfo(GetFlyoutID(i))
			if isKnown then
				numFlyoutButtons = numSlots
				break
			end
		end
	end
	local updateFlyoutButton = function(self)
		self.icon:SetTexCoord(5/64, 59/64, 5/64, 59/64)
		self.icon:ClearAllPoints()
		self.icon:SetPoint("TOPLEFT", 2, -2)
		self.icon:SetPoint("BOTTOMRIGHT", -2, 2)
		self.icon:SetDrawLayer("BORDER", 0) -- tends to disappear into BACKGROUND, 0
		self:SetBackdrop(buttonBackdrop)
		self:SetBackdropColor(0, 0, 0, 1)
		self:SetBackdropBorderColor(.15, .15, .15, 1)
	end
	local SetupFlyoutButton = function()
		local button
		for i = 1, numFlyoutButtons do
			button = _G["SpellFlyoutButton"..i]
			if button then
				if not flyoutButtons[button] then
					updateFlyoutButton(button)
					flyoutButtons[button] = true
				end
				if (button:GetChecked() == true) then
					button:SetChecked(false) -- do we need to see this?
				end
			else
				return
			end
		end
	end
	SpellFlyout:HookScript("OnShow", SetupFlyoutButton)
	hooksecurefunc("ActionButton_UpdateFlyout", function(self, ...)
		if ButtonRegistry[self] and self.UpdateFlyout then
			self:UpdateFlyout()
		end
	end)
end



-- Button API Mapping
-----------------------------------------------------------

--- Generic Button API mapping
Button.HasAction						= function(self) return nil end
Button.GetActionText					= function(self) return "" end
Button.GetTexture						= function(self) return nil end
Button.GetCharges						= function(self) return nil end
Button.GetCount							= function(self) return 0 end
Button.GetCooldown						= function(self) return 0, 0, 0 end
Button.IsAttack							= function(self) return nil end
Button.IsEquipped						= function(self) return nil end
Button.IsCurrentlyActive				= function(self) return nil end
Button.IsAutoRepeat						= function(self) return nil end
Button.IsUsable							= function(self) return nil end
Button.IsConsumableOrStackable 			= function(self) return nil end
Button.IsUnitInRange					= function(self, unit) return nil end
Button.IsInRange						= function(self)
	local unit = self:GetAttribute("unit")
	if (unit == "player") then
		unit = nil
	end
	local val = self:IsUnitInRange(unit)
	
	-- map 1/0 to true false, since the return values are inconsistent between actions and spells
	if val == 1 then val = true elseif val == 0 then val = false end
	
	-- map nil to true, to avoid marking spells with no range as out of range
	if val == nil then val = true end

	return val
end
Button.SetTooltip						= function(self) return nil end
Button.GetSpellId						= function(self) return nil end
Button.GetLossOfControlCooldown 		= function(self) return 0, 0 end

-- Action Button API mapping
ActionButton.HasAction					= function(self) return HasAction(self.action_by_state) end
ActionButton.GetActionText				= function(self) return GetActionText(self.action_by_state) end
ActionButton.GetTexture					= function(self) return GetActionTexture(self.action_by_state) end
ActionButton.GetCharges					= function(self) return nil end
ActionButton.GetCount					= function(self) return GetActionCount(self.action_by_state) end
ActionButton.GetCooldown				= function(self) return GetActionCooldown(self.action_by_state) end
ActionButton.IsAttack					= function(self) return IsAttackAction(self.action_by_state) end
ActionButton.IsEquipped					= function(self) return IsEquippedAction(self.action_by_state) end
ActionButton.IsCurrentlyActive			= function(self) return IsCurrentAction(self.action_by_state) end
ActionButton.IsAutoRepeat				= function(self) return IsAutoRepeatAction(self.action_by_state) end
ActionButton.IsUsable					= function(self) return IsUsableAction(self.action_by_state) end
ActionButton.IsConsumableOrStackable	= function(self) return IsConsumableAction(self.action_by_state) or IsStackableAction(self.action_by_state) end
ActionButton.IsUnitInRange				= function(self, unit) return IsActionInRange(self.action_by_state, unit) end
ActionButton.SetTooltip					= function(self) return (not GameTooltip:IsForbidden()) and GameTooltip:SetAction(self.action_by_state) end
ActionButton.GetSpellId					= function(self)
	local actionType, id, subType = GetActionInfo(self.action_by_state)
	if (actionType == "spell") then
		return id
	elseif (actionType == "macro") then
		local _, _, spellId = GetMacroSpell(id)
		return spellId
	end
end
ActionButton.GetLossOfControlCooldown 	= GetActionLossOfControlCooldown and function(self) 
	return GetActionLossOfControlCooldown(self.action_by_state) 
end or function() return 0, 0 end


-- Spell Button API mapping
SpellButton.HasAction					= function(self) return true end
SpellButton.GetActionText				= function(self) return "" end
SpellButton.GetTexture					= function(self) return GetSpellTexture(self.action_by_state) end
SpellButton.GetCharges					= function(self) return GetSpellCharges(self.action_by_state) end
SpellButton.GetCount					= function(self) return GetSpellCount(self.action_by_state) end
SpellButton.GetCooldown					= function(self) return GetSpellCooldown(self.action_by_state) end
SpellButton.IsAttack					= function(self) return IsAttackSpell(FindSpellBookSlotBySpellID(self.action_by_state), "spell") end -- needs spell book id as of 4.0.1.13066
SpellButton.IsEquipped					= function(self) return nil end
SpellButton.IsCurrentlyActive			= function(self) return IsCurrentSpell(self.action_by_state) end
SpellButton.IsAutoRepeat				= function(self) return IsAutoRepeatSpell(FindSpellBookSlotBySpellID(self.action_by_state), "spell") end -- needs spell book id as of 4.0.1.13066
SpellButton.IsUsable					= function(self) return IsUsableSpell(self.action_by_state) end
SpellButton.IsConsumableOrStackable		= function(self) return IsConsumableSpell(self.action_by_state) end
SpellButton.IsUnitInRange				= function(self, unit) return IsSpellInRange(FindSpellBookSlotBySpellID(self.action_by_state), "spell", unit) end -- needs spell book id as of 4.0.1.13066
SpellButton.SetTooltip					= function(self) return (not GameTooltip:IsForbidden()) and GameTooltip:SetSpellByID(self.action_by_state) end
SpellButton.GetSpellId					= function(self) return self.action_by_state end


ItemButton.HasAction					= function(self) return true end
ItemButton.GetActionText				= function(self) return "" end
ItemButton.GetTexture					= function(self) return GetItemIcon(self.action_by_state) end
ItemButton.GetCharges					= function(self) return nil end
ItemButton.GetCount						= function(self) return GetItemCount(self.action_by_state, nil, true) end
ItemButton.GetCooldown					= function(self) return GetItemCooldown(getItemId(self.action_by_state)) end
ItemButton.IsAttack						= function(self) return nil end
ItemButton.IsEquipped					= function(self) return IsEquippedItem(self.action_by_state) end
ItemButton.IsCurrentlyActive			= function(self) return IsCurrentItem(self.action_by_state) end
ItemButton.IsAutoRepeat					= function(self) return nil end
ItemButton.IsUsable						= function(self) return IsUsableItem(self.action_by_state) end
ItemButton.IsConsumableOrStackable		= function(self) 
	local stackSize = select(8, GetItemInfo(self.action_by_state)) -- salvage crates and similar don't register as consumables
	return IsConsumableItem(self.action_by_state) or (stackSize and (stackSize > 1))
end
ItemButton.IsUnitInRange				= function(self, unit) return IsItemInRange(self.action_by_state, unit) end
ItemButton.SetTooltip					= function(self) return (not GameTooltip:IsForbidden()) and GameTooltip:SetHyperlink(self.action_by_state) end
ItemButton.GetSpellId					= function(self) return nil end


--- Macro Button API mapping
MacroButton.HasAction					= function(self) return true end
MacroButton.GetActionText				= function(self) return (GetMacroInfo(self.action_by_state)) end
MacroButton.GetTexture					= function(self) return (select(2, GetMacroInfo(self.action_by_state))) end
MacroButton.GetCharges					= function(self) return nil end
MacroButton.GetCount					= function(self) return 0 end
MacroButton.GetCooldown					= function(self) return 0, 0, 0 end
MacroButton.IsAttack					= function(self) return nil end
MacroButton.IsEquipped					= function(self) return nil end
MacroButton.IsCurrentlyActive			= function(self) return nil end
MacroButton.IsAutoRepeat				= function(self) return nil end
MacroButton.IsUsable					= function(self) return nil end
MacroButton.IsConsumableOrStackable		= function(self) return nil end
MacroButton.IsUnitInRange				= function(self, unit) return nil end
MacroButton.SetTooltip					= function(self) return nil end
MacroButton.GetSpellId					= function(self) return nil end

--- Pet Button
PetActionButton.HasAction				= function(self) return GetPetActionInfo(self.id) end
PetActionButton.GetCooldown				= function(self) return GetPetActionCooldown(self.id) end
PetActionButton.IsCurrentlyActive		= function(self) return select(5, GetPetActionInfo(self.id)) end
PetActionButton.IsAutoRepeat			= function(self) return nil end -- select(7, GetPetActionInfo(self.id))
PetActionButton.SetTooltip				= function(self) 
	if (not self.tooltipName) then
		return
	end
	if GameTooltip:IsForbidden() then
		return
	end

	GameTooltip:SetText(self.tooltipName, 1.0, 1.0, 1.0)

	if self.tooltipSubtext then
		GameTooltip:AddLine(self.tooltipSubtext, "", 0.5, 0.5, 0.5)
	end

	-- We need an extra :Show(), or the tooltip will get the wrong height if it has a subtext
	return GameTooltip:Show() 

	-- This isn't good enough, as it don't work for the generic attack/defense and so on
	--return GameTooltip:SetPetAction(self.id) 
end
PetActionButton.IsAttack				= function(self) return nil end
PetActionButton.IsUsable				= function(self) return GetPetActionsUsable() end
PetActionButton.GetActionText			= function(self)
	local name, _, _, isToken = GetPetActionInfo(self.id)
	return isToken and _G[name] or name
end
PetActionButton.GetTexture				= function(self)
	local _, _, texture, isToken = GetPetActionInfo(self.id)
	return isToken and _G[texture] or texture
end

--- Stance Button
StanceButton.HasAction 					= function(self) return GetShapeshiftFormInfo(self.id) end
StanceButton.GetCooldown 				= function(self) return GetShapeshiftFormCooldown(self.id) end
StanceButton.GetActionText 				= function(self) return select(2,GetShapeshiftFormInfo(self.id)) end
StanceButton.GetTexture 				= function(self) return GetShapeshiftFormInfo(self.id) end
StanceButton.IsCurrentlyActive 			= function(self) return select(3,GetShapeshiftFormInfo(self.id)) end
StanceButton.IsUsable 					= function(self) return select(4,GetShapeshiftFormInfo(self.id)) end
StanceButton.SetTooltip					= function(self) return (not GameTooltip:IsForbidden()) and GameTooltip:SetShapeshift(self.id) end


-- returns an iterator containing button frame handles as keys
Handler.GetAll = function(self)
	return pairs(ButtonRegistry)
end

Handler.OnEvent = function(self, event, ...)
	local arg1 = ...

	--if (event == "UNIT_INVENTORY_CHANGED" and arg1 == "player") 
	--or (event == "LEARNED_SPELL_IN_TAB") then
		-- local tooltipOwner = GameTooltip:GetOwner()
		-- if ButtonRegistry[tooltipOwner] then
			-- tooltipOwner:SetTooltip()
		-- end

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
		local INSTANCE = IsInInstance()

		for button in next, ButtonRegistry do
			if (button:IsShown()) then
				button:Update()
			end
		end
		
	-- elseif event == "ACTIONBAR_PAGE_CHANGED" or event == "UPDATE_BONUS_ACTIONBAR" then
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
		
	elseif (event == "PLAYER_TARGET_CHANGED") then
		-- UpdateRangeTimer()
		
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
		
	elseif (event == "SPELL_UPDATE_USABLE") then
		for button in next, NonActionButtons do
			button:UpdateUsable()
		end

		-- for taxis?
		--for button in next, ActionButtons do
		--	button:UpdateUsable()
		--end
		
	elseif (event == "UPDATE_SHAPESHIFT_COOLDOWN")
	or (event == "ACTIONBAR_UPDATE_COOLDOWN") then
		for button in next, ActionButtons do
			button:UpdateCooldown()
		end
		
	elseif (event == "SPELL_UPDATE_COOLDOWN") then
		for button in next, NonActionButtons do
			button:UpdateCooldown()
		end
		
	elseif (event == "LOSS_OF_CONTROL_ADDED")
	or (event == "LOSS_OF_CONTROL_UPDATE") then
		for button in next, ActiveButtons do
			button:UpdateCooldown()
		end
	
	elseif (event == "TRADE_SKILL_SHOW") or (event == "TRADE_SKILL_CLOSE") or (event == "ARCHAEOLOGY_CLOSED") then
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
	
	elseif (event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW") then
		for button in next, ActiveButtons do
			local spellId = button:GetSpellId()
			if spellId then 
				if (spellId == arg1) or IsSpellOverlayed(spellId) then
					button:ShowOverlayGlow()
				elseif (button.type_by_state == "action") then
					local actionType, id = GetActionInfo(button.action_by_state)
					if (actionType == "flyout") and FlyoutHasSpell(id, arg1) then
						button:ShowOverlayGlow()
					end
				end
			end
		end
	
	elseif (event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE") then
		for button in next, ActiveButtons do
			local spellId = button:GetSpellId()
			if spellId then 
				if (spellId == arg1) or IsSpellOverlayed(spellId) then
					button:HideOverlayGlow()
				elseif (button.type_by_state == "action") then
					local actionType, id = GetActionInfo(button.action_by_state)
					if (actionType == "flyout") and FlyoutHasSpell(id, arg1) then
						button:HideOverlayGlow()
					end
				end
			end
		end
	
	elseif (event == "PLAYER_EQUIPMENT_CHANGED") then
		for button in next, ActiveButtons do
			if (button.type_by_state == "item") then
				button:Update()
			end
		end
	
	elseif (event == "SPELL_UPDATE_CHARGES") then
		for button in next, ActiveButtons do
			button:UpdateCount()
		end
	
	elseif (event == "UPDATE_SUMMONPETS_ACTION") then
		for button in next, ActiveButtons do
			if (button.type_by_state == "action") then
				local actionType, id = GetActionInfo(button.action_by_state)
				if (actionType == "summonpet") then
					local texture = GetActionTexture(button.action_by_state)
					if texture then
						button.icon:SetTexture(texture)
					end
				end
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

	-- If an item is placed at the actionbars, 
	-- we need to update its display when it changes in the bags. 
	elseif (event == "BAG_UPDATE") then
		for button in next, ActiveButtons do
			if (button.type_by_state == "item") then
				button:Update()
			end
		end
	
	-- In most cases this won't happen in combat, but better to be safe than sorry
	elseif ((event == "CVAR_UPDATE") and ((arg1 == "ACTION_BUTTON_USE_KEY_DOWN") or (arg1 == "LOCK_ACTIONBAR_TEXT"))) then
		if InCombatLockdown() then
			return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
		end 

		local cast_on_down = GetCVarBool("ActionButtonUseKeyDown")
		for button in next, ButtonRegistry do
			if cast_on_down then
				button:RegisterForClicks("AnyDown")
			else
				button:RegisterForClicks("AnyUp")
			end
		end

	elseif (event == "PLAYER_REGEN_ENABLED") then

		local cast_on_down = GetCVarBool("ActionButtonUseKeyDown")
		for button in next, ButtonRegistry do
			if cast_on_down then
				button:RegisterForClicks("AnyDown")
			else
				button:RegisterForClicks("AnyUp")
			end
		end
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
	end
end

Handler.LoadEvents = function(self)
	-- Ordering them by the alphabet, because my brain turns to mush here.

	self:RegisterEvent("ACTIONBAR_HIDEGRID", "OnEvent")
	--self:RegisterEvent("ACTIONBAR_PAGE_CHANGED", "OnEvent")
	self:RegisterEvent("ACTIONBAR_SHOWGRID", "OnEvent")
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "OnEvent")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "OnEvent")
	self:RegisterEvent("ACTIONBAR_UPDATE_STATE", "OnEvent")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE", "OnEvent")
	self:RegisterEvent("ARCHAEOLOGY_CLOSED", "OnEvent")
	self:RegisterEvent("BAG_UPDATE", "OnEvent") 
	self:RegisterEvent("BAG_UPDATE_COOLDOWN", "OnEvent")
	self:RegisterEvent("COMPANION_UPDATE", "OnEvent")
	self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", "OnEvent")
	self:RegisterEvent("CVAR_UPDATE", "OnEvent") -- cast on up/down
	self:RegisterEvent("LEARNED_SPELL_IN_TAB", "OnEvent")
	self:RegisterEvent("LOSS_OF_CONTROL_ADDED", "OnEvent")
	self:RegisterEvent("LOSS_OF_CONTROL_UPDATE", "OnEvent")
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
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "OnEvent")
	self:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED", "OnEvent")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnEvent")
	self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE", "OnEvent") -- Cata
	self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", "OnEvent") -- Cata
	self:RegisterEvent("SPELL_UPDATE_CHARGES", "OnEvent")
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN", "OnEvent")
	self:RegisterEvent("SPELL_UPDATE_USABLE", "OnEvent")
	self:RegisterEvent("START_AUTOREPEAT_SPELL", "OnEvent")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL", "OnEvent")
	self:RegisterEvent("TRADE_SKILL_CLOSE", "OnEvent")
	self:RegisterEvent("TRADE_SKILL_SHOW", "OnEvent")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE", "OnEvent")
	self:RegisterEvent("UNIT_EXITED_VEHICLE", "OnEvent")
	self:RegisterEvent("UNIT_AURA", "OnEvent")
	--self:RegisterEvent("UNIT_FLAGS", "OnEvent")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")
	self:RegisterEvent("UNIT_PET", "OnEvent")
	self:RegisterEvent("UPDATE_BINDINGS", "OnEvent")
	--self:RegisterEvent("UPDATE_BONUS_ACTIONBAR", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN", "OnEvent")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "OnEvent")
	self:RegisterEvent("UPDATE_SUMMONPETS_ACTION", "OnEvent")
	self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", "OnEvent")


	self:RegisterEvent("SPELLS_CHANGED", "OnEvent")
	self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", "OnEvent")

	--hooksecurefunc("TakeTaxiNode", function() 
	--	for button in next, ActionButtons do
	--		button:UpdateUsable("taxi")
	--	end
	--end) 
	
end

Handler.Start = function(self, event)
	-- Unregister the event that brought us here
	self:UnregisterEvent(event, "Start")

	-- Initialize the handler for real
	self:StyleFlyouts()
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
		local button_num = id > NUM_ACTIONBAR_BUTTONS and id%NUM_ACTIONBAR_BUTTONS or id -- better?
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
	elseif (header.id == "extra") then
		name = "EngineExtraBarButton"..id
	elseif (header.id == "custom") then
		name = "EngineCustomBarButton"..id
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
		
	--elseif (buttonType == "extra") then
		--button = setmetatable(Engine:CreateFrame("CheckButton", name , header, "ExtraActionButtonTemplate"), Button_MT)
		--button:UnregisterAllEvents()
		--button:SetScript("OnEvent", nil)
	
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

	-- Variables used for our own push/check/highlight textures
	-- They are only listed here for semantic reasons
	button._pushed = nil
	button._checked = nil
	button._highlighted = nil

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
	button:SetAttribute("flyoutDirection", "UP")
	button.action = 0 -- hack needed for the flyouts to not bug out

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
		local type_by_state = self:GetAttribute(format("type-by-state-%s", button_state));
		if action_by_state and (IsShiftKeyDown() and IsAltKeyDown() and IsControlKeyDown()) then
			if self:GetAttribute("type") == "pet" then
				return "petaction", action_by_state
			else
				return "action", action_by_state
			end
		end
	]])
	setmetatable(button, button_type_meta_map[buttonType]) -- assign correct metatable


	-- Frames and Layers
	---------------------------------------------------------

	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetSize(button:GetSize())
	button.icon:SetPoint("CENTER", 0, 0)
	button.icon:SetTexCoord(5/64, 59/64, 5/64, 59/64) 

	button.flash = button:CreateTexture(nil, "OVERLAY")
	button.flash:SetAllPoints(button.icon)
	button.flash:SetColorTexture(.7, 0, 0, .3)
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
	if button.SetCheckedTexture then
		button:SetCheckedTexture("")
	end
	if button.SetHighlightTexture then
		button:SetHighlightTexture("")
	end
	if button.SetNormalTexture then
		button:SetNormalTexture("")
	end

	-- exists on action, pet and stance templates
	local old_flyoutarrow = _G[button:GetName().."FlyoutArrow"]
	if old_flyoutarrow then
		button.FlyoutArrow = old_flyoutarrow
	end
	local old_flyoutborder = _G[button:GetName().."FlyoutBorder"]
	if old_flyoutborder then
		button.FlyoutBorder = old_flyoutborder
		button.FlyoutBorder:SetAlpha(0)
		button.FlyoutBorder:SetParent(UIHider)
	end
	local old_flyoutbordershadow = _G[button:GetName().."FlyoutBorderShadow"]
	if old_flyoutbordershadow then
		button.FlyoutBorderShadow = old_flyoutbordershadow
		button.FlyoutBorderShadow:SetAlpha(0)
		button.FlyoutBorderShadow:SetParent(UIHider)
	end

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
	button.pushed:SetColorTexture(1, 1, 1, .25)

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
	button:SetScript("PreClick", button.PreClick)
	button:SetScript("PostClick", button.PostClick)


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
