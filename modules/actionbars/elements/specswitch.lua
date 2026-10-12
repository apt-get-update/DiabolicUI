-- "Button: Spec Switch" widget: a button on top of the skull in the middle
-- of the action bar artwork that switches to your other talent
-- specialization. Shown while the "showSpecSwitch" option is on, once you
-- have learned Dual Talent Specialization.
--
-- Whichever way the specialization gets switched, once the switch completes
-- what's saved for the new one (set on the options' Specializations page)
-- runs, in this order: its equipment set ("specEquipSet1"/"2"), its Action
-- Bar Saver profile ("specProfile1"/"2"), then its number of action bars and
-- side bars ("specBars1"/"2", "specSideBars1"/"2"). false leaves it as it is.
--
-- A specialization can also have two macros. Blizzard never lets an addon
-- run a macro (nor /use, /cast...), only a click on a secure button, so the
-- button is one. Its "before" macro ("specMacroBefore1"/"2") runs on the
-- click that switches to it, as the switch starts. Its "after" macro
-- ("specMacroName1"/"2") once the switch is done: the button glows, and its
-- next click runs the macro instead of switching. Without macros, the
-- default, it only ever switches.
local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local ButtonWidget = Module:SetWidget("Button: Spec Switch")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local select = select
local table_concat = table.concat
local table_sort = table.sort
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local CreateMacro = _G.CreateMacro
local GetActiveTalentGroup = _G.GetActiveTalentGroup
local GetEquipmentSetInfo = _G.GetEquipmentSetInfo
local GetEquipmentSetInfoByName = _G.GetEquipmentSetInfoByName
local GetMacroIndexByName = _G.GetMacroIndexByName
local GetMacroInfo = _G.GetMacroInfo
local GetNumEquipmentSets = _G.GetNumEquipmentSets
local GetNumMacros = _G.GetNumMacros
local GetNumTalentGroups = _G.GetNumTalentGroups
local GetNumTalentTabs = _G.GetNumTalentTabs
local GetTalentTabInfo = _G.GetTalentTabInfo
local InCombatLockdown = _G.InCombatLockdown
local RegisterStateDriver = _G.RegisterStateDriver
local SetActiveTalentGroup = _G.SetActiveTalentGroup
local UnitClass = _G.UnitClass
local UnregisterStateDriver = _G.UnregisterStateDriver

-- WoW Frames & Objects
local GameTooltip = _G.GameTooltip

-- Seconds to wait after a switch before setting it up, so the server is
-- done handing out the new specialization's action bars.
local SETUP_DELAY = 1

-- Blizzard_MacroUI's MAX_ACCOUNT_MACROS and MAX_CHARACTER_MACROS (that
-- addon loads on demand): character macros come after the account ones.
local ACCOUNT_MACROS = 36
local CHARACTER_MACROS = 18
local MACRO_NAME_LENGTH = 16
local MACRO_BODY_LENGTH = 255

-- The specialization of talent group `group`: the name of its tree with
-- the most points, its points per tree ("51/20/0") and the tree's icon.
-- No name or icon while no points are spent.
local GetSpec = function(group)
	local name, icon, most, points = nil, nil, 0, {}
	for tab = 1, GetNumTalentTabs() do
		local tabName, tabIcon, spent = GetTalentTabInfo(tab, false, false, group)
		points[tab] = spent
		if (spent > most) then
			name, icon, most = tabName, tabIcon, spent
		end
	end
	return name, table_concat(points, "/"), icon
end
ButtonWidget.GetSpec = function(self, group)
	return GetSpec(group)
end

-- The textures are whole button images: one shown at a time.
local UpdateTexture = function(button)
	local textures = button.textures
	if button.pushed then
		button.Art:SetTexture(textures.pushed)
	elseif button.hovered then
		button.Art:SetTexture(textures.highlight)
	else
		button.Art:SetTexture(textures.normal)
	end
end

local OnEnter = function(self)
	self.hovered = true
	UpdateTexture(self)

	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	local active = GetActiveTalentGroup()
	GameTooltip:AddLine(L["Talent Specialization"])
	for group, label in ipairs({ _G.PRIMARY, _G.SECONDARY }) do
		local name, points = GetSpec(group)
		local r, g, b = 1, 1, 1
		if (group ~= active) then
			r, g, b = .6, .6, .6
		end
		GameTooltip:AddDoubleLine(label, (name or _G.NONE) .. " (" .. points .. ")", r, g, b, r, g, b)
	end
	if self.macro then
		GameTooltip:AddLine(L["<Left-click> to run your '%s' macro"]:format(self.macro), 0, .7, 0)
	else
		GameTooltip:AddLine(L["<Left-click> to switch"], 0, .7, 0)
		local before = Module.db["specMacroBefore" .. (3 - active)]
		if before then
			GameTooltip:AddLine(L["Runs your '%s' macro first"]:format(before), .6, .6, .6)
		end
	end
	GameTooltip:Show()
end

local OnLeave = function(self)
	self.hovered = nil
	self.pushed = nil
	UpdateTexture(self)
	GameTooltip:Hide()
end

local OnMouseDown = function(self)
	self.pushed = true
	UpdateTexture(self)
end

local OnMouseUp = function(self)
	self.pushed = nil
	UpdateTexture(self)
end

local Print = function(message)
	_G.DEFAULT_CHAT_FRAME:AddMessage(message, 1, .3, .3)
end

-- The glow of a macro waiting for its click: the highlight art, pulsing.
local SetGlow = function(button, shown)
	if shown then
		button.Glow:Show()
		button.Glow.Pulse:Play()
	else
		button.Glow.Pulse:Stop()
		button.Glow:Hide()
	end
end

-- The button's secure click runs the macro its attributes name, if any
-- (SecureActionButton_OnClick); otherwise our PostClick switches.
local SetMacroAttributes = function(button, macro)
	button:SetAttribute("type", macro and "macro")
	button:SetAttribute("macro", macro)
end

-- No macro waiting anymore. Secure attributes can't change in combat, so
-- after a click in combat they're cleared once it ends.
local ClearMacro = function(button)
	button.macro = nil
	SetGlow(button, false)
	if InCombatLockdown() then
		ButtonWidget:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnded")
	else
		SetMacroAttributes(button, nil)
	end
	if button.hovered then
		OnEnter(button)
	end
end

-- Before the template's OnClick: a waiting "after" macro runs, or the
-- "before" macro of the specialization this click switches to gets set up
-- for it (the switch can't happen in combat, so neither can this).
local PreClick = function(self)
	self.ranMacro = nil
	if (self:GetAttribute("type") == "macro") then
		self.ranMacro = "after"
	elseif (GetNumTalentGroups() > 1) and not InCombatLockdown() then
		local before = Module.db["specMacroBefore" .. (3 - GetActiveTalentGroup())]
		if before and (GetMacroIndexByName(before) == 0) then
			Print(L["Macro '%s' not found."]:format(before))
		elseif before then
			SetMacroAttributes(self, before)
			self.ranMacro = "before"
		end
	end
end

local PostClick = function(self)
	if (self.ranMacro == "after") then
		ClearMacro(self)
		return
	end
	if (self.ranMacro == "before") then
		SetMacroAttributes(self, nil)
	end
	if (GetNumTalentGroups() > 1) then
		SetActiveTalentGroup(3 - GetActiveTalentGroup())
	end
end

-- The choices for the options page's dropdowns, each { text, value, icon }.
-- The equipment sets: name and icon, as the equipment manager lists them.
ButtonWidget.GetEquipmentSets = function(self)
	local sets = {}
	for i = 1, GetNumEquipmentSets() do
		local name, icon = GetEquipmentSetInfo(i)
		sets[#sets + 1] = { text = name, value = name, icon = icon }
	end
	return sets
end

-- Your macros: the account ones, then the character ones.
ButtonWidget.GetMacros = function(self)
	local macros = {}
	local numAccount, numCharacter = GetNumMacros()
	local add = function(index)
		local name, icon = GetMacroInfo(index)
		if name then
			macros[#macros + 1] = { text = name, value = name, icon = icon }
		end
	end
	for index = 1, numAccount do
		add(index)
	end
	for index = ACCOUNT_MACROS + 1, ACCOUNT_MACROS + numCharacter do
		add(index)
	end
	return macros
end

-- Action Bar Saver's profiles for your class, by name, or nil while the
-- addon isn't loaded. It saves the names in lower case.
ButtonWidget.GetActionBarProfiles = function(self)
	local db = _G.ActionBarSaverDB
	if (not (db and db.sets and _G.SlashCmdList.ABS)) then
		return
	end
	local profiles = {}
	for name in pairs(db.sets[select(2, UnitClass("player"))] or {}) do
		profiles[#profiles + 1] = name
	end
	table_sort(profiles)
	for i, name in ipairs(profiles) do
		profiles[i] = { text = name, value = name }
	end
	return profiles
end

-- Everything saved for talent group `group`, in order.
local RunSpec = function(group)
	local db = Module.db

	local set = db["specEquipSet" .. group]
	if set then
		if GetEquipmentSetInfoByName(set) then
			_G.EquipmentManager_EquipSet(set)
		else
			Print(L["Equipment set '%s' not found."]:format(set))
		end
	end

	local profile = db["specProfile" .. group]
	if profile then
		if _G.SlashCmdList.ABS then
			_G.SlashCmdList.ABS("restore " .. profile)
		else
			Print(L["Action Bar Saver isn't loaded, can't restore '%s'."]:format(profile))
		end
	end

	local bars, sideBars = db["specBars" .. group], db["specSideBars" .. group]
	if bars or sideBars then
		db.num_bars = bars or db.num_bars
		db.num_side_bars = sideBars or db.num_side_bars
		Module:ApplySettings()
	end

	ButtonWidget:SetMacro(db["specMacroName" .. group])
end
ButtonWidget.RunSpec = function(self, group)
	RunSpec(group)
end

-- The macro the button's next click runs, or none. The switch that leads
-- here can't happen in combat, so the attributes can be set.
ButtonWidget.SetMacro = function(self, macro)
	local button = self.Button
	if macro and (GetMacroIndexByName(macro) == 0) then
		Print(L["Macro '%s' not found."]:format(macro))
		macro = nil
	end
	if macro and not (button and Module.db.showSpecSwitch) then
		Print(L["Turn on the specialization switch button to run your '%s' macro."]:format(macro))
		macro = nil
	end
	if (not button) then
		return
	end
	if macro then
		button.macro = macro
		SetMacroAttributes(button, macro)
		SetGlow(button, true)
		if button.hovered then
			OnEnter(button)
		end
	elseif button.macro then
		ClearMacro(button)
	end
end

ButtonWidget.OnCombatEnded = function(self)
	self:UnregisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnded")
	if self.Button and not self.Button.macro then
		SetMacroAttributes(self.Button, nil)
	end
	if self.placeAfterCombat then
		self.placeAfterCombat = nil
		self:PlaceButton()
	end
	if self.updateAfterCombat then
		self.updateAfterCombat = nil
		self:Update()
	end
end

-- Before the macros, each specialization had a box of slash commands
-- ("specMacro1"/"2"). What's left in it becomes a character macro named
-- after the specialization, picked for it. Kept until there's a free slot.
ButtonWidget.MoveCommandsToMacros = function(self)
	local db = Module.db
	for group = 1, 2 do
		local text = db["specMacro" .. group]
		if text and not text:find("%S") then
			db["specMacro" .. group] = nil
		elseif text and not db["specMacroName" .. group] then
			local name = ("DUI " .. (GetSpec(group) or (group == 1 and _G.PRIMARY or _G.SECONDARY))):sub(1, MACRO_NAME_LENGTH)
			local _, numCharacter = GetNumMacros()
			if (#text > MACRO_BODY_LENGTH) then
				Print(L["Your %s commands are too long for a macro, make one yourself: %s"]:format(name, text))
				db["specMacro" .. group] = nil
			elseif (GetMacroIndexByName(name) > 0) then
				-- one with that name already: picked as it is
				db["specMacroName" .. group], db["specMacro" .. group] = name, nil
			elseif (numCharacter < CHARACTER_MACROS) then
				CreateMacro(name, 1, text, 1)
				db["specMacroName" .. group], db["specMacro" .. group] = name, nil
				Print(L["Your other commands are now the character macro '%s', run by a click on the skull after switching."]:format(name))
			else
				Print(L["No free character macro slot for your %s commands, they're kept until there's one."]:format(name))
			end
		end
	end
end

-- What's saved for the specialization just switched to, a moment later.
local OnSetupUpdate = function(self, elapsed)
	self.delay = self.delay - elapsed
	if (self.delay <= 0) then
		self:Hide()
		RunSpec(self.group)
	end
end

ButtonWidget.OnTalentGroupChanged = function(self)
	local group = GetActiveTalentGroup()
	-- The group at login is no switch; only a change from it is.
	if self.talentGroup and (group ~= self.talentGroup) then
		local timer = self.SetupTimer
		if (not timer) then
			timer = CreateFrame("Frame")
			timer:SetScript("OnUpdate", OnSetupUpdate)
			self.SetupTimer = timer
		end
		timer.group, timer.delay = group, SETUP_DELAY
		timer:Show()
	end
	self.talentGroup = group
	self:Update()
end

ButtonWidget.OnEnteringWorld = function(self)
	self.talentGroup = self.talentGroup or GetActiveTalentGroup()
	if (not InCombatLockdown()) then
		self:MoveCommandsToMacros()
	end
	self:Update()
end

ButtonWidget.Update = function(self)
	local button = self.Button
	if (not button) then
		return -- not placed yet
	end
	if InCombatLockdown() then
		-- a secure button: shown, hidden and enabled out of combat only
		self.updateAfterCombat = true
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnded")
		return
	end
	-- hidden until Dual Talent Specialization is learned: nothing to switch.
	-- Shown through a state driver, which hides it in a vehicle or while
	-- possessing (the bars are the vehicle's then), like the stance toggle.
	UnregisterStateDriver(button, "visibility")
	if (not Module.db.showSpecSwitch) or (GetNumTalentGroups() < 2) then
		if button.macro then
			ClearMacro(button)
		end
		RegisterStateDriver(button, "visibility", "hide")
		return
	end
	UpdateTexture(button)
	RegisterStateDriver(button, "visibility", "[vehicleui][bonusbar:5]hide;show")
	if button.hovered then
		OnEnter(button) -- the tooltip follows a switch
	end
end

-- The skull is created with the rest of the artwork on the first bar update
-- (elements/artwork.lua), so the button is too.
ButtonWidget.CreateButton = function(self)
	if InCombatLockdown() then
		-- a /reload in combat: a secure button is placed out of it
		self.createAfterCombat = true
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "CreateButton")
		return
	end
	if self.createAfterCombat then
		self.createAfterCombat = nil
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "CreateButton")
	end
	local config = Module.config.visuals.specswitch
	local skull = _G.DiabolicUISkullTexture

	local button = CreateFrame("Button", "DiabolicUISpecSwitchButton", skull:GetParent(), "SecureActionButtonTemplate")
	button:SetFrameLevel(skull:GetParent():GetFrameLevel() + 2)
	button:SetSize(unpack(config.size))
	button:RegisterForClicks("LeftButtonUp")
	button.textures = config.textures

	button.Art = button:CreateTexture(nil, "ARTWORK")
	button.Art:SetSize(unpack(config.texture_size))
	button.Art:SetPoint("CENTER")

	button.Glow = button:CreateTexture(nil, "OVERLAY")
	button.Glow:SetAllPoints(button.Art)
	button.Glow:SetTexture(config.textures.highlight)
	button.Glow:SetBlendMode("ADD")
	button.Glow:Hide()
	button.Glow.Pulse = button.Glow:CreateAnimationGroup()
	button.Glow.Pulse:SetLooping("BOUNCE")
	local fade = button.Glow.Pulse:CreateAnimation("Alpha")
	fade:SetChange(-.8)
	fade:SetDuration(.8)

	-- OnClick is the template's: it runs the macro the attributes name
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnMouseDown", OnMouseDown)
	button:SetScript("OnMouseUp", OnMouseUp)
	button:SetScript("PreClick", PreClick)
	button:SetScript("PostClick", PostClick)

	self.Button = button
	if self.waitingForArtwork then
		self.waitingForArtwork = nil
		self:UnregisterMessage("ENGINE_ACTIONBAR_ARTWORK_LOADED", "CreateButton")
	end
	self:PlaceButton()
	self:Update()
end

-- On the skull. The client drops a secure button's anchor to a texture, or
-- to anything anchored to one, so the button copies the skull's own anchor
-- (to the artwork frame) plus its offset, each time the skull moves. Out
-- of combat only: a move in combat is followed once it ends.
ButtonWidget.PlaceButton = function(self)
	local button = self.Button
	if (not button) then
		return
	end
	if InCombatLockdown() then
		self.placeAfterCombat = true
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnded")
		return
	end
	local point, relativeTo, relativePoint, x, y = _G.DiabolicUISkullTexture:GetPoint()
	if (not point) then
		return -- not placed yet
	end
	-- (the skull's points are all BOTTOM ones, like the button's)
	local position = Module.config.visuals.specswitch.position
	button:ClearAllPoints()
	button:SetPoint(position[1], relativeTo, relativePoint, x + position[2], y + position[3])
end

ButtonWidget.OnEnable = function(self)
	self.waitingForArtwork = true
	self:RegisterMessage("ENGINE_ACTIONBAR_ARTWORK_LOADED", "CreateButton")
	self:RegisterMessage("ENGINE_ACTIONBAR_ARTWORK_PLACED", "PlaceButton")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEnteringWorld")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "Update")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "OnTalentGroupChanged")
end

ButtonWidget.GetFrame = function(self)
	return self.Button
end
