-- The Escape menu: Blizzard's buttons in DiabolicUI's big menu buttons,
-- centered on the screen, on a bare window. Buttons added by MoveAnything
-- and ACP get the same look once those addons have loaded.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: GameMenu")

-- Lua API
local _G = _G
local ipairs = ipairs
local select = select
local table_insert = table.insert
local type = type
local unpack = unpack

-- A button's three looks
local LAYERS = { "normal", "highlight", "pushed" }

-- Shows the look for the button's state: pushed while held down with the
-- mouse over it, highlighted while hovered or held, normal otherwise.
local updateLayers = function(self)
	local over = self:IsMouseOver()
	local layer = (self.isDown and over) and "pushed" or (self.isDown or over) and "highlight" or "normal"
	for _, name in ipairs(LAYERS) do
		local alpha = (name == layer) and 1 or 0
		self[name]:SetAlpha(alpha)
		self.text[name]:SetAlpha(alpha)
	end
	self.text:ClearAllPoints()
	self.text:SetPoint("CENTER", 0, (layer == "pushed") and -4 or 0)
end

local setDown = function(self, isDown)
	self.isDown = isDown
	self:UpdateLayers()
end

-- to avoid potential taint, we safewrap the layout method
Module.UpdateButtonLayout = Module:Wrap(function(self)
	local config = self.config
	local UICenter = Engine:GetFrame()

	local previous
	local first, last
	for i,v in ipairs(self.buttons) do
		local button = v.button
		if button and button:IsShown() then
			button:ClearAllPoints()
			if previous then
				button:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -config.button_spacing)
			else
				button:SetPoint("TOP", UICenter, "TOP", 0, -300) -- we'll change this later
				first = button
			end
			previous = button
			last = button
		end
	end	

	-- re-align first button so that the menu will be vertically centered
	local top = first:GetTop()
	local bottom = last:GetBottom()
	local screen_height = UICenter:GetHeight()
	local height = top - bottom
	local y_position = (screen_height - height)/2

	first:ClearAllPoints()
	first:SetPoint("TOP", UICenter, "TOP", 0, -y_position)

end)

Module.StyleButtons = function(self)
	local uiconfig = self.uiconfig

	local need_addon_watch
	for i,v in ipairs(self.buttons) do
		-- figure out the real frame handle of the button
		local button
		if type(v.content) == "string" then
			button = _G[v.content]
		else
			button = v.content
		end

		if v.styled then
			-- already done
		elseif button then
			local label
			if type(v.label) == "function" then
				label = v.label()
			else
				label = v.label
			end

			-- run custom scripts on the button, if any
			if v.run then
				v.run(button)
			end

			-- Clear away blizzard artwork
			button:SetNormalTexture("")
			button:SetHighlightTexture("")
			button:SetPushedTexture("")

			-- Hide Blizzard's label. We can NOT replace its SetText, as secure code
			-- sometimes calls it, and we would end up with a tainted GameMenuFrame!
			local fontstring = button:GetFontString()
			if fontstring then
				fontstring:SetAlpha(0)
			end

			-- create our own artwork and label, one per look
			button.text = {
				SetPoint = function(self, ...)
					for _, name in ipairs(LAYERS) do
						self[name]:SetPoint(...)
					end
				end,
				ClearAllPoints = function(self)
					for _, name in ipairs(LAYERS) do
						self[name]:ClearAllPoints()
					end
				end
			}
			for _, name in ipairs(LAYERS) do
				local texture = button:CreateTexture(nil, "ARTWORK")
				texture:SetTexture(uiconfig.menubutton.texture[name])
				texture:SetSize(unpack(uiconfig.menubutton.texture_size))
				texture:SetPoint("CENTER")
				button[name] = texture

				local text = button:CreateFontString(nil, "OVERLAY")
				text:SetFontObject(uiconfig.menubutton[name.."Font"])
				text:SetText(label)
				button.text[name] = text
			end

			button.UpdateLayers = updateLayers
			button:HookScript("OnEnter", updateLayers)
			button:HookScript("OnLeave", updateLayers)
			button:HookScript("OnMouseDown", function(self) setDown(self, true) end)
			button:HookScript("OnMouseUp", function(self) setDown(self, false) end)
			button:HookScript("OnShow", function(self) setDown(self, false) end)
			button:HookScript("OnHide", function(self) setDown(self, false) end)

			button:SetSize(unpack(uiconfig.menubutton.size))
			button:UpdateLayers() -- update colors and layers

			v.button = button -- add a reference to the frame handle for the layout function
			v.styled = true -- avoid double styling

		elseif v.addon then
			-- a button from an addon that isn't loaded yet
			need_addon_watch = true
		end
	end

	-- Watch for the addons whose buttons are missing.
	if need_addon_watch then
		if not self.looking_for_addons then
			self:RegisterEvent("ADDON_LOADED", "StyleButtons")
			self.looking_for_addons = true
		end
	elseif self.looking_for_addons then
		self:UnregisterEvent("ADDON_LOADED", "StyleButtons")
		self.looking_for_addons = nil
	end

	self:UpdateButtonLayout()
end

-- A bare window: only the buttons take the mouse.
Module.StyleWindow = function(self)
	self.frame:EnableMouse(false)
	self.frame:SetBackdrop(nil)

	self.frame:SetFrameStrata("DIALOG")
	self.frame:SetFrameLevel(120)

	for i = 1, self.frame:GetNumRegions() do
		local region = select(i, self.frame:GetRegions())
		if (region:GetObjectType() == "Texture") then
			region:SetTexture(nil)
			region:SetAlpha(0)
		else
			region:SetText("")
		end
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").gamemenu
	self.uiconfig = self:GetDB("UI")
	self.frame = GameMenuFrame

	self.frame:SetParent(Engine:GetFrame())

	-- ACP's own show and hide scripts would move its button
	local Fix_ACP = function(self)
		self:SetScript("OnShow", nil)
		self:SetScript("OnHide", nil)
	end

	self.buttons = {
		{ content = GameMenuButtonOptions, label = VIDEOOPTIONS_MENU },
		{ content = GameMenuButtonSoundOptions, label = VOICE_SOUND }, -- SOUNDOPTIONS_MENU
		{ content = GameMenuButtonUIOptions, label = UIOPTIONS_MENU },
		{ content = GameMenuButtonKeybindings, label = KEY_BINDINGS },
		{ content = "GameMenuButtonMoveAnything", label = function() return GameMenuButtonMoveAnything:GetText() end, addon = true }, -- MoveAnything
		{ content = GameMenuButtonMacros, label = MACROS },
		{ content = "GameMenuButtonAddOns", label = function() return GameMenuButtonAddOns:GetText() end, run = Fix_ACP, addon = true }, -- ACP (Addon Control Panel)
		{ content = GameMenuButtonRatings, label = RATINGS_MENU },
		{ content = GameMenuButtonLogout, label = LOGOUT },
		{ content = GameMenuButtonQuit, label = EXIT_GAME },
		{ content = GameMenuButtonContinue, label = RETURN_TO_GAME }
	}

	-- the mac options button, on a mac client only
	if IsMacClient() then
		table_insert(self.buttons, 4, { content = GameMenuButtonMacOptions, label = MAC_OPTIONS })
	else
		local UIHider = CreateFrame("Frame")
		UIHider:Hide()
		GameMenuButtonMacOptions:UnregisterAllEvents()
		GameMenuButtonMacOptions:SetParent(UIHider)
		GameMenuButtonMacOptions.SetParent = function() end
	end

	self:RegisterEvent("UI_SCALE_CHANGED", "UpdateButtonLayout")
	self:RegisterEvent("DISPLAY_SIZE_CHANGED", "UpdateButtonLayout")

	VideoOptionsFrameApply:HookScript("OnClick", function() self:UpdateButtonLayout() end)
	VideoOptionsFrameOkay:HookScript("OnClick", function() self:UpdateButtonLayout() end)
end

Module.OnEnable = function(self)
	self:StyleWindow()
	self:StyleButtons()
end

