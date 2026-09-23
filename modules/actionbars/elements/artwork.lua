local ADDON, Engine = ...
local Module = Engine:GetModule("ActionBars")
local Widget = Module:SetWidget("Artwork")
local L = Engine:GetLocale()

-- Media
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON) 
local auraShade = path .. [[textures\DiabolicUI_Shade_64x64.tga]]

-- Bar & Button objects
local Button = {}
local Bar = {}

-- Maximum number of mouse buttons
local NUM_MOUSE_BUTTONS = 31

-- Track stuff to reduce artwork updates
local PLAYER_HAS_XP
local PLAYER_VISIBLE_BARS
local PLAYER_HAS_PET
local PLAYER_BAR_STATE
local PLAYER_BAR_ID

local colors = {
	-- icon overlays
	unusableOverlay 	= { 51/255, 17/255, 6/255, .25 }, -- C.General.UIOverlay
	flightOverlay 		= { 51/255, 17/255, 6/255, .7 }, -- C.General.UIOverlay
	rangeOverlay 		= { 51/255, 17/255, 6/255, .10 }, -- C.General.UIOverlay
}

-- Hotkey abbreviations for better readability
local ToShortKey = function(key)
	if key then
		key = key:upper()
		key = key:gsub(" ", "")
		key = key:gsub("ALT%-", L["Alt"])
		key = key:gsub("CTRL%-", L["Ctrl"])
		key = key:gsub("SHIFT%-", L["Shift"])
		key = key:gsub("NUMPAD", L["NumPad"])

		key = key:gsub("PLUS", "%+")
		key = key:gsub("MINUS", "%-")
		key = key:gsub("MULTIPLY", "%*")
		key = key:gsub("DIVIDE", "%/")

		key = key:gsub("BACKSPACE", L["Backspace"])

		for i = 1, NUM_MOUSE_BUTTONS do
			key = key:gsub("BUTTON" .. i, L["Button" .. i])
		end

		key = key:gsub("CAPSLOCK", L["Capslock"])
		key = key:gsub("CLEAR", L["Clear"])
		key = key:gsub("DELETE", L["Delete"])
		key = key:gsub("END", L["End"])
		key = key:gsub("HOME", L["Home"])
		key = key:gsub("INSERT", L["Insert"])
		key = key:gsub("MOUSEWHEELDOWN", L["Mouse Wheel Down"])
		key = key:gsub("MOUSEWHEELUP", L["Mouse Wheel Up"])
		key = key:gsub("NUMLOCK", L["Num Lock"])
		key = key:gsub("PAGEDOWN", L["Page Down"])
		key = key:gsub("PAGEUP", L["Page Up"])
		key = key:gsub("SCROLLLOCK", L["Scroll Lock"])
		key = key:gsub("SPACEBAR", L["Spacebar"])
		key = key:gsub("TAB", L["Tab"])

		key = key:gsub("DOWNARROW", L["Down Arrow"])
		key = key:gsub("LEFTARROW", L["Left Arrow"])
		key = key:gsub("RIGHTARROW", L["Right Arrow"])
		key = key:gsub("UPARROW", L["Up Arrow"])

		return key
	end
end

-- utility function to set multiple points at once
local SetPoints = function(element, points)
	element:ClearAllPoints()

	-- multiple points or a single one?
	if (#points > 0) then
		for i,pos in ipairs(points) do
			element:SetPoint(unpack(pos))
		end
	else
		element:SetPoint(unpack(points))
	end
end

local SetTexture = function(element, config)
	if config.size then
		element:SetSize(unpack(config.size))
	end
	if config.points then
		SetPoints(element, config.points)
	end
	if config.texture then
		element:SetTexture(config.texture)
	end
	if config.texcoords then
		element:SetTexCoord(unpack(config.texcoords))
	end
	if config.color then
		element:SetVertexColor(unpack(config.color))
	end
	if config.alpha then
		element:SetAlpha(config.alpha)
	end
	element.visibleAlpha = config.alpha or 1
end

local SetFont = function(element, config)
	if config.normalFont then
		element:SetFontObject(config.normalFont)
	end
	if config.size then
		element:SetSize(unpack(config.size))
	end
	if config.points then
		SetPoints(element, config.points)
	end
	if config.alpha then
		element:SetAlpha(config.alpha)
	end
	element.visibleAlpha = config.alpha or 1
end

-- Called whenever the visibility of the artwork layers need
-- to be updated, like when the button is hovered over or checked.
Button.PostUpdate = function(self, forced)
	local hasAction = self:HasAction()
	local isChecked = self._checked
	local isHighlighted = self._highlighted

	local isActionShown = self.isActionShown
	local isCheckedShown = self.isCheckedShown
	local isHighlightShown = self.isHighlightShown

	-- Bail out if there's no change
	if (not forced) and ((isChecked == isCheckedShown) and (isHighlighted == isHighlightShown) and (hasAction == isActionShown)) then
		return
	end

	local border = self.border

	if hasAction then
		border.empty:SetAlpha(0)
		border.empty_highlight:SetAlpha(0)

		if checked then
			border.normal:SetAlpha(0)
			border.normal_highlight:SetAlpha(0)
			if isHighlighted then
				border.checked:SetAlpha(0)
				border.checked_highlight:SetAlpha(border.checked_highlight.visibleAlpha or 1)
			else
				border.checked:SetAlpha(border.checked.visibleAlpha or 1)
				border.checked_highlight:SetAlpha(0)
			end
		else
			border.checked:SetAlpha(0)
			border.checked_highlight:SetAlpha(0)
			if isHighlighted then
				border.normal:SetAlpha(0)
				border.normal_highlight:SetAlpha(border.normal_highlight.visibleAlpha or 1)
			else
				border.normal:SetAlpha(border.normal.visibleAlpha or 1)
				border.normal_highlight:SetAlpha(0)
			end
		end
	else
		border.normal:SetAlpha(0)
		border.normal_highlight:SetAlpha(0)
		border.checked:SetAlpha(0)
		border.checked_highlight:SetAlpha(0)

		if isHighlighted then
			border.empty:SetAlpha(0)
			border.empty_highlight:SetAlpha(border.empty_highlight.visibleAlpha or 1)
		else
			border.empty:SetAlpha(border.empty.visibleAlpha or 1)
			border.empty_highlight:SetAlpha(0)
		end

		self._checked = nil
		self._pushed = nil
	end

	self.isActionShown = isActionShown
	self.isCheckedShown = isCheckedShown
	self.isHighlightShown = isHighlightShown
end

-- No need for extra functions here, 
-- we're only updating for visual layers anyway.
Button.PostMouseDown = Button.PostUpdate
Button.PostMouseUp = Button.PostUpdate
Button.PostMouseEnter = Button.PostUpdate
Button.PostMouseLeave = Button.PostUpdate
Button.PostUpdateChecked = Button.PostUpdate

Button.PostUpdateUsable = function(self, usableState, canDesaturate)
	local dark = self.icon.dark
	local colors = colors

	-- Attempt to desaturate when on a taxi or flying, 
	-- to give the impression of a deactivated button.
	if (usableState == "taxi") then
		if canDesaturate then
			dark:SetVertexColor(colors.flightOverlay[1], colors.flightOverlay[2], colors.flightOverlay[3], colors.flightOverlay[4])
			dark:SetAlpha(colors.flightOverlay[4] or 1)
		else
			-- fallback to standard darkening if desaturation fails
			dark:SetVertexColor(colors.unusableOverlay[1], colors.unusableOverlay[2], colors.unusableOverlay[3], colors.unusableOverlay[4])
			dark:SetAlpha(colors.unusableOverlay[4] or 1)
		end
	else
		if (usableState == "unusable") then
			dark:SetVertexColor(colors.unusableOverlay[1], colors.unusableOverlay[2], colors.unusableOverlay[3], colors.unusableOverlay[4])
			dark:SetAlpha(colors.unusableOverlay[4] or 1)
		elseif (usableState == "range") then
			dark:SetVertexColor(colors.rangeOverlay[1], colors.rangeOverlay[2], colors.rangeOverlay[3], colors.rangeOverlay[4])
			dark:SetAlpha(colors.rangeOverlay[4] or 1)
		elseif (usableState == "usable") then
			dark:SetAlpha(0)
		elseif (usableState == "mana") then
			dark:SetAlpha(0)
		end
	end 
end

Button.OverrideBindingKey = function(self, key)
	local keybind = self.keybind
	if (self.type_by_state == "stance") or (key == RANGE_INDICATOR) then
		keybind:SetText("")
		keybind:SetAlpha(0)
	else
		keybind:SetText(ToShortKey(key))
		keybind:SetAlpha(keybind.visibleAlpha or 1)
	end
end

-- Called from the secure environment when the parent bar's 
-- layout, size or buttonsize changes.
-- This is where we change textures and fonts.
Button.UpdateStyle = function(self, STYLE)
	-- slot
	SetTexture(self.slot, STYLE.slot)
	
	-- icon
	SetTexture(self.icon, STYLE.icon)
	
	-- empty button border
	SetTexture(self.border.empty, STYLE.border_empty)
	SetTexture(self.border.empty_highlight, STYLE.border_empty_highlight)
	
	-- normal border
	SetTexture(self.border.normal, STYLE.border_normal)
	SetTexture(self.border.normal_highlight, STYLE.border_normal_highlight)
	
	-- checked border
	SetTexture(self.border.checked, STYLE.border_checked)
	SetTexture(self.border.checked_highlight, STYLE.border_checked_highlight)

	-- keybind
	SetFont(self.keybind, STYLE.keybind)
	
	-- stack size
	SetFont(self.stack, STYLE.stacksize)
	
	-- macro name
	SetFont(self.name, STYLE.nametext)
	
	-- cooldowncount
	SetFont(self.cooldowncount, STYLE.cooldown_numbers)

	-- Need a post update to adjust alpha values upon bar layout changes, 
	-- or we'll end with a situation where all the layers are visible at once.
	-- * 	this still happens in cata. weird. 
	-- ** 	added a 'forced' flag to the post update to make sure the one called
	-- 		called from this styling function always gets through. 
	self:PostUpdate(true)
end

Button.PostCreate = function(self, buttonType)

	-- Speeeed!
	local icon = self.icon
	local keybind = self.keybind
	local stack = self.stack
	local name = self.name
	local cooldowncount = self.cooldowncount

	local iconShade = self:CreateTexture(nil, "OVERLAY")
	iconShade:SetAllPoints(icon)
	iconShade:SetTexture(auraShade)
	iconShade:SetVertexColor(0, 0, 0, .75)

	-- darker texture for unusable actions
	local iconDimmer = self:CreateTexture(nil, "OVERLAY")
	iconDimmer:SetAlpha(0)
	iconDimmer:SetAllPoints(icon)
	iconDimmer:SetTexture(.3, .3, .3, 1)

	-- backdrop and shadow
	local backdrop = self:CreateTexture(nil, "BACKGROUND")
	backdrop:SetAllPoints()

	-- empty slot
	local slot = self:CreateTexture(nil, "BORDER")
	slot:SetAllPoints()

	-- overlay frame holding border, gloss and texts
	local border = self:CreateFrame("Frame")
	border:SetAllPoints()
	border:SetFrameLevel(self:GetFrameLevel() + 4)

	-- normal border
	border.normal = border:CreateTexture(nil, "BORDER")
	border.normal:SetAllPoints()

	-- normal border highlighted
	border.normal_highlight = border:CreateTexture(nil, "BORDER")
	border.normal_highlight:SetAllPoints()
	border.normal_highlight:SetAlpha(0)
	
	-- border when the ability is checked
	border.checked = border:CreateTexture(nil, "BORDER")
	border.checked:SetAllPoints()
	border.checked:SetAlpha(0)

	-- border when the ability is checked and highlighted
	border.checked_highlight = border:CreateTexture(nil, "BORDER")
	border.checked_highlight:SetAllPoints()
	border.checked_highlight:SetAlpha(0)

	-- border when the self is empty
	border.empty = border:CreateTexture(nil, "BORDER")
	border.empty:SetAllPoints()
	border.empty:SetAlpha(0)

	-- border when the self is empty and highlighted
	border.empty_highlight = border:CreateTexture(nil, "BORDER")
	border.empty_highlight:SetAllPoints()
	border.empty_highlight:SetAlpha(0)

	local buttonName = self:GetName()

	-- autocast textures. exists on pet templates.
	local autocastable = _G[buttonName .. "AutoCastable"]
	if autocastable then
		self.autocastable = autocastable
		self.autocastable:SetParent(border)
		self.autocastable:SetDrawLayer("OVERLAY")
	end

	local autocast = _G[buttonName .. "Shine"]
	if autocast then
		self.autocast = autocast
		self.autocast:SetParent(border)
		self.autocast:SetAllPoints(icon)
		self.autocast:SetFrameLevel(border:GetFrameLevel() + 4)
	end

	local chargeCooldown = self.chargeCooldown
	if chargeCooldown then
	end

	-- Reparent existing texts to our border frame
	keybind:SetParent(border)
	stack:SetParent(border)
	name:SetParent(border)
	cooldowncount:SetParent(border)

	-- Add references
	icon.shade = iconShade
	icon.dark = iconDimmer
	
	self.backdrop = backdrop
	self.slot = slot
	self.border = border

end

-- update visual styles and cosmetic textures
Bar.PostUpdate = function(self)
	local buttonSize = self:GetAttribute("old_button_size")
	if buttonSize then
		local styleTable = Module.config.visuals.buttons[buttonSize]
		if styleTable then 
			local buttons = self.buttons
			for i in ipairs(buttons) do
				if buttons[i].UpdateStyle then
					buttons[i]:UpdateStyle(styleTable)
				end
			end
		end
	end
end

Widget.GetButtonTemplate = function(self)
	return Button
end

Widget.GetBarTemplate = function(self)
	return Bar
end

Widget.OnEnable = function(self)
	self.config = self:GetDB("ActionBars") -- static config
	self.db = self:GetConfig("ActionBars", "character") -- per user settings for bars

	self:RegisterEvent("PLAYER_ALIVE", "UpdateArtwork")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateArtwork")
	self:RegisterMessage("ENGINE_ACTIONBAR_PET_CHANGED", "UpdateArtwork")
	self:RegisterMessage("ENGINE_ACTIONBAR_VEHICLE_CHANGED", "UpdateArtwork")
	self:RegisterMessage("ENGINE_ACTIONBAR_VISIBLE_CHANGED", "UpdateArtwork")
	self:RegisterMessage("ENGINE_ACTIONBAR_XP_VISIBLE_CHANGED", "UpdateArtwork")
	self:RegisterMessage("ENGINE_ACTIONBAR_REPUTATION_VISIBLE_CHANGED", "UpdateArtwork")

end

Widget.LoadArtwork = function(self)
	local config = self.config.visuals.artwork
	local db = self.db
	
	local Main = Module:GetWidget("Controller: Main"):GetFrame()

	-- holder for the artwork behind the buttons and globes
	local background = Main:CreateFrame("Frame")
	background:SetFrameStrata("BACKGROUND")
	background:SetFrameLevel(10) -- room for the xp/rep bar
	background:SetAllPoints()
	
	-- artwork overlaying the globes (demon and angel)
	local overlay = Main:CreateFrame("Frame")
	overlay:SetFrameStrata("MEDIUM")
	-- Deliberately low: the player unit frame/globes are a lower frame
	-- STRATA entirely ("LOW", see handlers/unitframe.lua), so strata alone
	-- already keeps this artwork above them regardless of level - what
	-- actually matters here is staying *below* the action buttons (also
	-- MEDIUM strata), and their bar has been observed dropping from its
	-- intended level 50 down to ~28 on a fresh login (see UpdateArtwork's
	-- own comment) - so this needs a comfortable margin under that, not
	-- just under 50.
	overlay:SetFrameLevel(20)
	overlay:SetAllPoints()

	local artworkCache = {}

	for element in pairs(config) do
		local e = config[element]
		if (not e.disableAutomation) then 

			local artwork = (e.layer == "BACKGROUND" and background or e.layer == "OVERLAY" and overlay):CreateTexture(e.globalName, "ARTWORK")
			artwork:SetSize(unpack(e.size))
			artwork.Update = e.callback == "position" and "Place" or e.callback == "texture" and "SetTexture"

			if e.callback == "position" then
				artwork:SetTexture(e.texture)
			elseif e.callback == "texture" then
				artwork:SetPoint(unpack(e.position))
			end

			artworkCache[artwork] = e[e.callback]
		end 
	end
	
	return artworkCache
end

Widget.LoadPetBarArtwork = function(self)
	local config = Module.config.visuals.artwork.pet
	local db = Module.db

	-- Hooking the visibility to the bar, the position to the controller
	local artworkHolder = Module:GetWidget("Bar: Pet"):GetFrame():CreateFrame("Frame")
	artworkHolder:SetAllPoints()
	artworkHolder:SetFrameStrata("BACKGROUND")
	artworkHolder:SetFrameLevel(5)
	
	local artwork = artworkHolder:CreateTexture()
	artwork:SetDrawLayer("ARTWORK")
	artwork:SetSize(unpack(config.size))
	artwork:SetPoint(unpack(config.position))
	artwork:SetTexture(config.texture)
	artwork:SetTexCoord(unpack(config.texcoords))

	self.petartwork = artworkHolder

	self.LoadPetBarArtwork = nil
end

Widget.UpdateArtwork = function(self, event, ...)
	local db = self.db

	-- On a fresh login (as opposed to a UI reload), a side bar (bar4/bar5 -
	-- confirmed by direct in-game print debugging) loses its explicitly-set
	-- frame level at some point after creation - dropping from 50 down to
	-- ~28, well below this artwork - for reasons that weren't pinned down
	-- (it isn't a Show()/Hide() transition, and it isn't caused by anything
	-- else in this addon's own code). This re-levels every button relative
	-- to whatever its bar's *current* level actually is, on every single
	-- call, unconditionally and before the "avoid pointless updates"
	-- early-return below - cheap and idempotent to just always redo it.
	for barNum, bar in pairs(Module:GetBars()) do
		for i, button in bar:GetAll() do
			button:SetFrameLevel(bar:GetFrameLevel() + 1)
		end
	end

	if (self.LoadPetBarArtwork) then
		self:LoadPetBarArtwork()
	end


	-- figure out which backdrop texture to show
	local Main = Module:GetWidget("Controller: Main"):GetFrame()
	local Pet = Module:GetWidget("Bar: Pet"):GetFrame()
	local hasXP = Module:IsXPVisible() or Module:IsReputationVisible()
	local hasPet = Pet:IsShown() 
	local numBars = tostring(Main:GetAttribute("numbars"))
	local barState = tostring(Main:GetAttribute("state-page"))
	local barID = ((barState == "possess") or (barState == "vehicle")) and "vehicle" or numBars
	local petID = hasPet and "pet" or ""
	local xpID = hasXP and "xp" or ""

	-- Avoid pointless updates
	if (PLAYER_HAS_XP == hasXP) 
	and (PLAYER_VISIBLE_BARS == numBars) 
	and (PLAYER_HAS_PET == hasPet) 
	and (PLAYER_BAR_STATE == barState) 
	and (PLAYER_BAR_ID == barID)
	then
		return
	end

	if PLAYER_BAR_ID ~= barID then
		for barNum, bar in pairs(Module:GetBars()) do
			if bar:IsShown() and bar.PostUpdate then
				bar:PostUpdate()
			end
		end
	end

	-- Store current values, to avoid multiple calls
	PLAYER_HAS_XP = hasXP
	PLAYER_VISIBLE_BARS = numBars
	PLAYER_HAS_PET = hasPet
	PLAYER_BAR_STATE = barState
	PLAYER_BAR_ID = barID


	-- we do a load on demand system here
	-- that creates the artwork upon the first bar update
	self.artworkCache = self.artworkCache or self:LoadArtwork()

	for artwork, artworkDB in pairs(self.artworkCache) do

		local id
		if artworkDB[barID .. xpID .. petID] then
			id = barID .. xpID .. petID
		elseif artworkDB[barID .. xpID] then
			id = barID .. xpID
		elseif artworkDB[barID .. petID] then
			id = barID .. petID
		elseif artworkDB[barID] then
			id = barID
		end

		if id then
			if type(artworkDB[id]) == "table" then
				artwork[artwork.Update](artwork, unpack(artworkDB[id]))
			else
				artwork[artwork.Update](artwork, artworkDB[id])
			end
		end
	end

end

