-- "PopUpMessage" handler: DiabolicUI-styled replacement for StaticPopup.
-- Register a popup once with :RegisterPopUp(id, info), then
-- :ShowPopUp(id, styleTable). The info table takes from StaticPopupDialogs:
-- title, text, button1 (OnAccept), button2 (OnCancel), button3 (OnAlt),
-- and OnShow / OnHide.
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
local PlaySound = _G.PlaySound


local popups = {} -- registry of virtual popup tables
local popupFrames = {} -- registry of all created popup frames
local activePopups = {} -- registry of active popup frames

local PopUp = CreateFrame("Frame")
local PopUp_MT = { __index = PopUp }

-- the button callbacks of a popup's info table, by button
local CALLBACKS = { "OnAccept", "OnCancel", "OnAlt" }

-- a footer button's look: pressed while held down over it, lit while
-- the mouse is over it (or it's held down elsewhere), normal otherwise
local LOOKS = { "normal", "highlight", "pushed" }

local UpdateLayers = function(self)
	local over = self:IsMouseOver()
	local look = (self.isDown and over and "pushed") or ((self.isDown or over) and "highlight") or "normal"
	for _, layer in ipairs(LOOKS) do
		if layer == look then
			self[layer]:Show()
		else
			self[layer]:Hide()
		end
	end
	local text = self.text
	local color = text[look .. "Color"]
	text:ClearAllPoints()
	text:SetPoint("CENTER", 0, (look == "pushed") and -4 or 0)
	text:SetTextColor(color[1], color[2], color[3])
end

local OnMouseDown = function(self)
	self.isDown = true
	self:UpdateLayers()
end

local OnMouseUp = function(self)
	self.isDown = false
	self:UpdateLayers()
end

local OnClick = function(self)
	local frame = self.popupFrame
	local callback = popups[frame.id][CALLBACKS[self.index]]
	if callback then
		callback(frame)
	end
	frame:Hide()
end


PopUp.OnShow = function(self)
	PlaySound("igMainMenuOpen")

	local id = self.id
	local popup = popups[id]
	if popup.OnShow then
		popup.OnShow(self)
	end

	activePopups[id] = self

	Handler:UpdateLayout()
end

PopUp.OnHide = function(self)
	PlaySound("igMainMenuClose")

	local id = self.id
	local popup = popups[id]
	if popup.OnHide then
		popup.OnHide(self)
	end

	activePopups[id] = nil

	Handler:UpdateLayout()
end


-- updates the content, style and layout of a popup frame
PopUp.Update = function(self, styleTable)

	-- Get the virtual popup registered to this frame
	local id = self.id
	local popup = popups[id]

	-- Always use the passed styleTable if it exists,
	-- but store it and re-use it if the Update function
	-- is recalled later with no styleTable argument.
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

	else
		title:Hide()
		header:SetHeight(0.0001)
		header:SetBackdrop(nil)
	end


	-- body (below the header, a sliver without a title)
	------------------------------------------------------
	body:ClearAllPoints()
	body:SetPoint("TOP", header, "BOTTOM", 0, -styleTable.padding)
	body:SetPoint("LEFT", styleBody.insets[1], 0)
	body:SetPoint("RIGHT", -styleBody.insets[2], 0)
	body:SetBackdrop(nil)

	if styleBody.backdrop then
		body:SetBackdrop(styleBody.backdrop)
		body:SetBackdropColor(unpack(styleBody.backdropColor))
		body:SetBackdropBorderColor(unpack(styleBody.backdropBorderColor))
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

			button.isDown = false -- not still held from the last time it showed
			button:UpdateLayers()

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
	local textHeight = 0
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

		-- WotLK cuts off the last line unless the fontstring is a few lines
		-- taller than its text; the body only makes room for the text itself.
		local _, messageFontHeight = message:GetFontObject():GetFont()
		textHeight = message:GetStringHeight()
		message:SetHeight(textHeight + (messageFontHeight * 4))
		message:Show()
	else
		message:Hide()
	end

	-- figure out body height
	local bodyHeight = 0.0001 + styleBody.insets[3] + styleBody.insets[4] + textHeight
	body:SetHeight(bodyHeight)

	-- figure out the frame height
	local frameHeight = 0.0001
	frameHeight = frameHeight + header:GetHeight()
	frameHeight = frameHeight + styleTable.padding -- padding to body
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

				button.index = i
				button.popupFrame = new
				button.UpdateLayers = UpdateLayers
				button:SetScript("OnEnter", UpdateLayers)
				button:SetScript("OnLeave", UpdateLayers)
				button:SetScript("OnMouseDown", OnMouseDown)
				button:SetScript("OnMouseUp", OnMouseUp)
				button:SetScript("OnClick", OnClick)

				new["button"..i] = button
			end

			new.body = body
			new.footer = footer
			new.header = header
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

-- update the layout and position of visible popups
Handler.UpdateLayout = function(self)
	local order = self.order
	table_wipe(order)
	for activeID in pairs(activePopups) do
		table_insert(order, activeID)
	end
	table_sort(order)
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
end

Handler.OnEnable = function(self)
	self.order = {}
end
