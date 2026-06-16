local _, Engine = ...
local Handler = Engine:NewHandler("PopUpMessage")

-- Lua API
local _G = _G
local ipairs = ipairs
local math_max = math.max
local math_min = math.min
local pairs = pairs
local unpack = unpack
local setmetatable = setmetatable
local table_insert = table.insert
local table_sort = table.sort
local table_wipe = table.wipe

-- WoW API
local CreateFrame = _G.CreateFrame
local GetBindingFromClick = _G.GetBindingFromClick
local InCinematic = _G.InCinematic
local PlaySoundKitID = Engine:IsBuild("7.3.0") and _G.PlaySound or _G.PlaySoundKitID
local RunBinding = _G.RunBinding
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost


local popups = {} -- registry of virtual popup tables
local popupFrames = {} -- registry of all created popup frames
local activePopups = {} -- registry of active popup frames

local PopUp = CreateFrame("Frame")
local PopUp_MT = { __index = PopUp }



-- set the title/header text of a popup frame
PopUp.SetTitle = function(self, msg)
end

-- set the message/body text of a popup frame
PopUp.SetText = function(self, msg)
end

-- change the style table of a popup frame
-- *only works for active popups
PopUp.SetStyle = function(self, styleTable)
	local id = self.id
	if not activePopups[id] == self then
		return
	end

	self:Update(styleTable)

	Handler:UpdateLayout()
end


PopUp.OnShow = function(self)
	PlaySoundKitID(SOUNDKIT.IG_MAINMENU_OPEN, "SFX")

	local id = self.id
	local popup = popups[id]
	if popup.OnShow then
		popup.OnShow(self)
	end

	activePopups[id] = self

	Handler:UpdateLayout()
end

PopUp.OnHide = function(self)
	PlaySoundKitID(SOUNDKIT.IG_MAINMENU_CLOSE, "SFX")

	local id = self.id
	local popup = popups[id]
	if popup.OnHide then
		popup.OnHide(self)
	end

	activePopups[id] = nil

	Handler:UpdateLayout()
end


PopUp.OnKeyDown = function(self, key)
	if GetBindingFromClick(key) == "TOGGLEGAMEMENU" then
		return self:OnEscapePressed()
	elseif GetBindingFromClick(key) == "SCREENSHOT" then
		RunBinding("SCREENSHOT")
		return
	end
end

PopUp.OnEnterPressed = function(self)
end

PopUp.OnEscapePressed = function(self)
end

PopUp.OnTextChanged = function(self)
end

PopUp.EditBoxOnEnterPressed = function(self)
end


-- update handler useful for timers and such
PopUp.OnUpdate = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 1/60 then
		local id = self.id
		local popup = popups[id]
		if popup.OnUpdate then
			popup.OnUpdate(self, elapsed)
		else
			-- just in case the popup content changed while being active,
			-- and we for some reason missed this script.
			self:SetScript("OnUpdate", nil)
		end
		self.elapsed = 0 -- inaccurate, but avoids burst calls after a lag spike
	end
end

PopUp.OnEvent = function(self, event, ...)
end

-- updates the content, style and layout of a popup frame
PopUp.Update = function(self, styleTable)

	-- Get the virtual popup registered to this frame
	local id = self.id
	local popup = popups[id]

	-- Always use the passed styleTable if it exists,
	-- but store it and re-use it if the Update function
	-- is recalled later with no styleTable argument.
	-- TODO: Only update body content/message when called without a styleTable!!
	-- TODO: Add generic fallback styles using blizzard textures.
	if styleTable then
		self.styleTable = styleTable
	elseif self.styleTable then
		styleTable = self.styleTable
	end

	-- style table shortcuts
	local style = styleTable.header
	local styleBody = styleTable.body
	local styleFooter = styleTable.footer
	local styleFooterButton = styleTable.footer.button
	local styleMessage = styleTable.body.message

	-- element shortcuts
	local body = self.body
	local button1 = self.button1
	local button2 = self.button2
	local button3 = self.button3
	local footer = self.footer
	local header = self.header
	local input = self.input
	local message = self.message
	local title = self.title

	self:SetBackdrop(nil)
	if styleTable.backdrop then
		self:SetBackdrop(styleTable.backdrop)
		self:SetBackdropColor(unpack(styleTable.backdropColor))
		self:SetBackdropBorderColor(unpack(styleTable.backdropBorderColor))
	end


	-- header
	------------------------------------------------------
	if popup.title then

		title:SetFontObject(style.title.normalFont)
		title:SetText(popup.title)
		--title:SetTextColor(unpack(style.title.fontColor))
		title:Show()

		header:SetBackdrop(nil)
		if style.backdrop then
			header:SetBackdrop(style.backdrop)
			header:SetBackdropColor(unpack(style.backdropColor))
			header:SetBackdropBorderColor(unpack(style.backdropBorderColor))
		end

		header:ClearAllPoints()
		header:SetPoint("TOP", 0, -style.insets[3])
		header:SetPoint("LEFT", style.insets[1], 0)
		header:SetPoint("RIGHT", -style.insets[2], 0)
		header:SetHeight(style.height)
		--header:Show()

	else
		if title:GetFontObject() then
			title:SetText("")
			title:Hide()
		end

		header:SetHeight(0.0001)
		header:SetBackdrop(nil)
		--header:Hide()
	end


	-- body
	------------------------------------------------------
	body:ClearAllPoints()
	if header:IsShown() then
		body:SetPoint("TOP", header, "BOTTOM", 0, -styleTable.padding)
	else
		body:SetPoint("TOP", body, "BOTTOM", 0, -styleBody.insets[3])
	end
	body:SetPoint("LEFT", styleBody.insets[1], 0)
	body:SetPoint("RIGHT", -styleBody.insets[2], 0)
	body:SetBackdrop(nil)

	if styleBody.backdrop then
		body:SetBackdrop(styleBody.backdrop)
		body:SetBackdropColor(unpack(styleBody.backdropColor))
		body:SetBackdropBorderColor(unpack(styleBody.backdropBorderColor))
	end


	if popup.hideOnEscape == 1 then
	else
	end

	if popup.timeout and popup.timeout > 0 then
	else
	end

	if popup.hasEditBox == 1 then
		input:Show()
	else
		input:Hide()
	end

	if popup.hasItemFrame == 1 then
	else
	end

	if popup.hasMoneyFrame == 1 then
	else
	end


	-- footer
	------------------------------------------------------

	footer:SetPoint("LEFT", styleFooter.insets[1], 0)
	footer:SetPoint("RIGHT", -styleFooter.insets[2], 0)
	footer:SetPoint("BOTTOM", 0, styleFooter.insets[3])
	footer:SetBackdrop(nil)

	if styleFooter.backdrop then
		footer:SetBackdrop(styleFooter.backdrop)
		footer:SetBackdropColor(unpack(styleFooter.backdropColor))
		footer:SetBackdropBorderColor(unpack(styleFooter.backdropBorderColor))
	end

	-- left button (accept)
	if popup.button1 then
		button1:SetText(popup.button1)
		button1:Show()
	else
		button1:SetText("")
		button1:Hide()
	end

	-- right button (cancel)
	if popup.button2 then
		button2:SetText(popup.button2)
		button2:Show()
	else
		button2:SetText("")
		button2:Hide()
	end

	-- center button (alternate option)
	if popup.button3 then
		button3:SetText(popup.button3)
		button3:Show()
	else
		button3:SetText("")
		button3:Hide()
	end

	-- figure out number of visible buttons,
	-- and re-align them if need be
	local numButtons = 0
	local buttonWidth = 0
	for i = 1,3 do
		local button = self["button"..i]
		if button:IsShown() then
			button:SetSize(unpack(styleFooterButton.size))

			button.normal:SetTexture(styleFooterButton.texture.normal)
			button.normal:SetSize(unpack(styleFooterButton.texture_size))
			button.normal:ClearAllPoints()
			button.normal:SetPoint("CENTER")

			button.highlight:SetTexture(styleFooterButton.texture.highlight)
			button.highlight:SetSize(unpack(styleFooterButton.texture_size))
			button.highlight:ClearAllPoints()
			button.highlight:SetPoint("CENTER")

			button.pushed:SetTexture(styleFooterButton.texture.pushed)
			button.pushed:SetSize(unpack(styleFooterButton.texture_size))
			button.pushed:ClearAllPoints()
			button.pushed:SetPoint("CENTER")

			button.text:SetFontObject(styleFooterButton.normalFont)
			button.text.normalColor = styleFooterButton.fontColor.normal
			button.text.highlightColor = styleFooterButton.fontColor.highlight
			button.text.pushedColor = styleFooterButton.fontColor.pushed

			button.text:SetText(popup["button"..i])

			button:UpdateLayers() -- update colors and layers

			numButtons = numButtons + 1
		end
	end

	-- anchor all buttons to the footer, not each other
	if numButtons == 3 then
		button1:ClearAllPoints()
		button1:SetPoint("BOTTOMLEFT", styleFooterButton.insets[1], styleFooterButton.insets[4])
		button2:ClearAllPoints()
		button2:SetPoint("BOTTOMRIGHT", -styleFooterButton.insets[1], styleFooterButton.insets[4])
		button3:ClearAllPoints()
		button3:SetPoint("BOTTOM", 0, styleFooterButton.insets[4])

		-- calculate size of the button area
		buttonWidth = buttonWidth + styleFooter.insets[1]
		buttonWidth = buttonWidth + styleFooterButton.insets[1]
		buttonWidth = buttonWidth + styleFooterButton.size[1] * 3
		buttonWidth = buttonWidth + styleFooter.button_spacing * 2
		buttonWidth = buttonWidth + styleFooterButton.insets[2]
		buttonWidth = buttonWidth + styleFooter.insets[2]

	elseif numButtons == 2 then
		if button1:IsShown() then
			button1:ClearAllPoints()
			button1:SetPoint("BOTTOMLEFT", styleFooterButton.insets[1], styleFooterButton.insets[4])
			if button2:IsShown() then
				button2:ClearAllPoints()
				button2:SetPoint("BOTTOMRIGHT", -styleFooterButton.insets[1], styleFooterButton.insets[4])
			else
				button3:ClearAllPoints()
				button3:SetPoint("BOTTOMRIGHT", -styleFooterButton.insets[1], styleFooterButton.insets[4])
			end
		else
			button2:ClearAllPoints()
			button2:SetPoint("BOTTOMRIGHT", -styleFooterButton.insets[1], styleFooterButton.insets[4])
			button3:ClearAllPoints()
			button3:SetPoint("BOTTOMLEFT", styleFooterButton.insets[1], styleFooterButton.insets[4])
		end

		-- calculate size of the button area
		buttonWidth = buttonWidth + styleFooter.insets[1]
		buttonWidth = buttonWidth + styleFooterButton.insets[1]
		buttonWidth = buttonWidth + styleFooterButton.size[1] * 2
		buttonWidth = buttonWidth + styleFooter.button_spacing
		buttonWidth = buttonWidth + styleFooterButton.insets[2]
		buttonWidth = buttonWidth + styleFooter.insets[2]

	elseif numButtons == 1 then
		for i = 1,3 do
			local button = self["button"..i]
			if button:IsShown() then
				button:ClearAllPoints()
				button:SetPoint("BOTTOM", 0, styleFooterButton.insets[4])
				break
			end
		end

		-- calculate size of the button area
		buttonWidth = buttonWidth + styleFooter.insets[1]
		buttonWidth = buttonWidth + styleFooterButton.insets[1]
		buttonWidth = buttonWidth + styleFooterButton.size[1]
		buttonWidth = buttonWidth + styleFooterButton.insets[2]
		buttonWidth = buttonWidth + styleFooter.insets[2]

	end

	local footerHeight = 0.0001
	if numButtons > 0 then
		footerHeight = footerHeight + styleFooter.insets[3]
		footerHeight = footerHeight + styleFooterButton.insets[3] + styleFooterButton.size[2] + styleFooterButton.insets[4]
		footerHeight = footerHeight + styleFooter.insets[4]
		footer:SetHeight(footerHeight)
		footer:Show()
	else
		footer:Hide()
		footer:SetHeight(0.0001)
	end

	-- figure out frame width
	local width = math_min(styleTable.maxwidth, math_max(buttonWidth, styleTable.minwidth))
	self:SetWidth(width)

	-- Now we can set up the message, since we've found our frame width
	local messageHeight = 0.0001
	if popup.text then
		-- We need this, or the text will become truncated
		message:SetSpacing(0)

		-- If we don't set the width, but only the points, the fontstring will still truncate
		-- as if it had its original width (which is tiny), and this is what leads to the
		-- super long and narrow message body we've seen so far in Legion!
		message:SetWidth(width - (styleMessage.insets[1] + styleMessage.insets[2]))
		message:ClearAllPoints()
		message:SetPoint("TOP", 0, -styleMessage.insets[3])
		message:SetPoint("LEFT", styleMessage.insets[1], 0)
		message:SetPoint("RIGHT", -styleMessage.insets[2], 0)
		message:SetFontObject(styleMessage.normalFont)
		message:SetText(popup.text)
		message:SetTextColor(unpack(styleMessage.fontColor))

		-- unless I add height matching a line of text, the last line gets truncated no matter what
		-- *I've only experienced this so far in WotLK, and it seems like a bug
		local _, messageFontHeight = message:GetFontObject():GetFont()
		messageHeight = message:GetStringHeight() + (messageFontHeight * 4)

		message:Show()
		message:SetHeight(messageHeight)
		message.spacing = (messageFontHeight * 4)

	else
		if message:GetFontObject() then
			message:SetHeight(0.0001)
			message.spacing = nil
			message:SetText("")
			message:Hide()
		end
	end

	-- figure out body height
	local bodyHeight = 0.0001 + styleTable.body.insets[3] + styleTable.body.insets[4]
	if message:IsShown() then
		bodyHeight = bodyHeight + messageHeight
		-- account for the weird fontstring bug that truncates when it shouldn't
		if message.spacing then
			bodyHeight = bodyHeight - message.spacing
		end
	end
	if input:IsShown() then
		bodyHeight = bodyHeight + input:GetHeight()
	end
	body:SetHeight(bodyHeight)

	-- figure out the frame height
	local frameHeight = 0.0001
	if header:IsShown() then
		frameHeight = frameHeight + styleTable.header.height
		frameHeight = frameHeight + styleTable.padding -- padding to body
	end
	frameHeight = frameHeight + bodyHeight
	if footer:IsShown() then
		frameHeight = frameHeight + styleTable.padding -- padding to body
		frameHeight = frameHeight + footerHeight
	end
	self:SetHeight(frameHeight)

end

-- register a new popup
Handler.RegisterPopUp = function(self, id, info_table)
	popups[id] = info_table
end

-- get a popup's info table
Handler.GetPopUp = function(self, id)
	return popups[id]
end

-- show a popup
Handler.ShowPopUp = function(self, id, styleTable)
	local popup = popups[id]

	-- is it already visible?
	local frame = activePopups[id]

	if not frame then
		-- find an available frame if it's not
		local frame_id
		for i in ipairs(popupFrames) do
			if not popupFrames[i]:IsShown() then
				frame_id = i
				frame = popupFrames[i]
				break
			end
		end

		-- create a new frame if none are available
		if not frame_id then
			frame_id = #popupFrames + 1
			local new = setmetatable(CreateFrame("Frame", nil, Engine:GetFrame()), PopUp_MT)
			new:EnableMouse(true)
			new:Hide() -- or the initial OnShow won't fire
			new:SetFrameStrata("DIALOG")
			new:SetFrameLevel(100)
			new:SetSize(0.0001, 0.0001)
			new:SetPoint("TOP", UIParent, "BOTTOM", 0, -100)

			-- Header
			------------------------------------------------------------------
			local header = CreateFrame("Frame", nil, new)
			header:SetPoint("TOP")
			header:SetPoint("LEFT")
			header:SetPoint("RIGHT")
			header:SetHeight(0.0001)

			-- artwork
			header.left = header:CreateTexture(nil, "ARTWORK")
			header.right = header:CreateTexture(nil, "ARTWORK")
			header.top = header:CreateTexture(nil, "ARTWORK")

			-- title
			local title = header:CreateFontString(nil, "ARTWORK")
			title:SetPoint("CENTER")
			title:SetJustifyV("TOP")
			title:SetJustifyH("CENTER")


			-- Body
			------------------------------------------------------------------
			local body = CreateFrame("Frame", nil, new)
			body:SetPoint("TOP", header, "BOTTOM")
			body:SetPoint("LEFT")
			body:SetPoint("RIGHT")
			body:SetHeight(0.0001)

			-- message
			local message = body:CreateFontString(nil, "ARTWORK")
			message:SetPoint("TOP")
			message:SetPoint("LEFT")
			message:SetPoint("RIGHT")
			message:SetJustifyV("TOP")
			message:SetJustifyH("CENTER")
			message:SetIndentedWordWrap(false)
			message:SetWordWrap(true)
			message:SetNonSpaceWrap(false)

			-- inputbox
			local input = CreateFrame("EditBox", body)
			input:Hide()
			input:ClearAllPoints()
			input:SetPoint("TOP", message, "BOTTOM")
			input:SetPoint("LEFT", message)
			input:SetPoint("RIGHT", message)

			-- Footer
			------------------------------------------------------------------
			local footer = CreateFrame("Frame", nil, new)
			footer:Hide()
			footer:ClearAllPoints()
			footer:SetPoint("TOP", body, "BOTTOM")
			footer:SetPoint("LEFT")
			footer:SetPoint("RIGHT")
			footer:SetPoint("BOTTOM")
			footer:SetHeight(0.0001)

			for i = 1,3 do
				local button = CreateFrame("Button", nil, footer)

				button.normal = button:CreateTexture(nil, "ARTWORK")
				button.normal:SetPoint("CENTER")

				button.highlight = button:CreateTexture(nil, "ARTWORK")
				button.highlight:SetPoint("CENTER")

				button.pushed = button:CreateTexture(nil, "ARTWORK")
				button.pushed:SetPoint("CENTER")

				button.text = button:CreateFontString(nil, "OVERLAY")
				button.text:SetPoint("CENTER")

				button:SetScript("OnEnter", function(self)
					if new:IsShown() then
						self:UpdateLayers()
					end
				end)
				button:SetScript("OnLeave", function(self)
					if new:IsShown() then
						self:UpdateLayers()
					end
				end)
				button:SetScript("OnMouseDown", function(self)
					if new:IsShown() then
						self.isDown = true
						self:UpdateLayers()
					end
				end)
				button:SetScript("OnMouseUp", function(self)
					if new:IsShown() then
						self.isDown = false
						self:UpdateLayers()
					end
				end)
				button:SetScript("OnShow", function(self)
					if new:IsShown() then
						self.isDown = false
						self:UpdateLayers()
					end
				end)
				button:SetScript("OnHide", function(self)
					if new:IsShown() then
						self.isDown = false
						self:UpdateLayers()
					end
				end)
				button.UpdateLayers = function(self)
					if self.isDown then
						self.normal:Hide()
						if self:IsMouseOver() then
							self.highlight:Hide()
							self.pushed:Show()

							local text = self.text
							text:ClearAllPoints()
							text:SetPoint("CENTER", 0, -4)
							text:SetTextColor(text.pushedColor[1], text.pushedColor[2], text.pushedColor[3])
						else
							self.pushed:Hide()
							self.normal:Hide()
							self.highlight:Show()

							local text = self.text
							text:ClearAllPoints()
							text:SetPoint("CENTER", 0, 0)
							text:SetTextColor(text.highlightColor[1], text.highlightColor[2], text.highlightColor[3])
						end
					else
						local text = self.text
						text:ClearAllPoints()
						text:SetPoint("CENTER", 0, 0)

						if self:IsMouseOver() then
							self.pushed:Hide()
							self.normal:Hide()
							self.highlight:Show()
							text:SetTextColor(text.highlightColor[1], text.highlightColor[2], text.highlightColor[3])
						else
							self.normal:Show()
							self.highlight:Hide()
							self.pushed:Hide()
							text:SetTextColor(text.normalColor[1], text.normalColor[2], text.normalColor[3])
						end
					end
				end

				new["button"..i] = button
			end

			-- 1st button (left)
			new.button1:SetScript("OnClick", function(self)
				local popup = popups[new.id]
				if popup.OnAccept then
					popup.OnAccept(new)
				end
				new:Hide()
			end)

			-- 2nd button (right)
			new.button2:SetScript("OnClick", function(self)
				local popup = popups[new.id]
				if popup.OnCancel then
					popup.OnCancel(new)
				end
				new:Hide()
			end)

			-- 3rd button (center)
			new.button3:SetScript("OnClick", function(self)
				local popup = popups[new.id]
				if popup.OnAlt then
					popup.OnAlt(new)
				end
				new:Hide()
			end)

			new.body = body
			new.footer = footer
			new.header = header
			new.input = input
			new.message = message
			new.title = title

			new:SetScript("OnShow", PopUp.OnShow)
			new:SetScript("OnHide", PopUp.OnHide)

			popupFrames[frame_id] = new

			frame = new
		end
	end

	-- show it
	frame.id = id
	frame:Update(styleTable)
	frame:Show()
end

-- hide any popups using the 'id' virtual popup table
Handler.HidePopUp = function(self, id)
	for activeID, popupFrame in pairs(activePopups) do
		if activeID == id then
			popupFrame:Hide()
			break
		end
	end
	self:UpdateLayout()
end

-- update the layout and position of visible popups
Handler.UpdateLayout = function(self)
	local order = self.order or {}
	if #order > 0 then
		table_wipe(order)
	end
	for activeID, popupFrame in pairs(activePopups) do
		if popupFrame then
			table_insert(order, activeID)
		end
	end
	if #order > 0 then
		table_sort(order)
	end
	local first, previous
	for i, activeID in ipairs(order) do
		local popupFrame = activePopups[activeID]
		if previous then
			popupFrame:ClearAllPoints()
			popupFrame:SetPoint("TOP", previous, "BOTTOM", 0, -20)
		else
			popupFrame:ClearAllPoints()
			popupFrame:SetPoint("TOP", Engine:GetFrame(), "TOP", 0, -200)
			first = popupFrame
		end
		previous = popupFrame
	end

	-- re-align the vertical layout for multiple frames
	if first and previous then
		local top = first:GetTop()
		local bottom = previous:GetBottom()
		local available = Engine:GetFrame():GetHeight()

		first:ClearAllPoints()
		first:SetPoint("TOP", Engine:GetFrame(), "TOP", 0, -(available - (top-bottom))/3)
	end

	self.order = order
end

Handler.OnEnable = function(self)
end
