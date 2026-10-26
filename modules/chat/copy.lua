-- Double-click a chat tab to copy its text: a window with the tab's last
-- lines as plain text, selected, ready for Ctrl+C. The lines are kept as
-- they're added, since the 3.3.5 chat window can't give them back.
local _, Engine = ...
local Module = Engine:NewModule("ChatCopy")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local table_concat = table.concat

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

local MAX_LINES = 200 -- kept per chat window
local WIDTH, HEIGHT = 560, 380
local SIDE = 36 -- the text from the window's sides and bottom (its iron is 23)
local PADDING = 12 -- the text under the band (its panel 6 under it, window.layout.content_gap)
local BAR = 24 -- the scroll bar's room, inside the text's panel

local history = {} -- [chat window] = { lines in a ring, count = lines ever added }

-- Colors, links and icons out, their text kept.
local PlainText = function(text)
	text = text:gsub("|c%x%x%x%x%x%x%x%x", "")
	text = text:gsub("|r", "")
	text = text:gsub("|H.-|h(.-)|h", "%1")
	text = text:gsub("|T.-|t", "")
	return text
end

local OnAddMessage = function(frame, text)
	local lines = history[frame]
	lines.count = lines.count + 1
	lines[(lines.count - 1) % MAX_LINES + 1] = text
end

-- The window's lines, oldest first.
Module.GetText = function(self, frame)
	local lines = history[frame]
	if (not lines) then
		return ""
	end
	local text, first = {}, lines.count - MAX_LINES + 1
	for i = (first > 1 and first or 1), lines.count do
		text[#text + 1] = PlainText(lines[(i - 1) % MAX_LINES + 1])
	end
	return table_concat(text, "\n")
end

Module.CreateWindow = function(self)
	local kit = Engine:GetModule("Blizzard: Windows")
	local look = self:GetDB("Blizzard").panels
	local frame = CreateFrame("Frame", "DiabolicChatCopyFrame", _G.UIParent)
	frame:Hide()
	frame:SetSize(WIDTH, HEIGHT)
	frame:SetPoint("CENTER")
	frame:SetFrameStrata("DIALOG")
	frame:SetClampedToScreen(true)
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	_G.tinsert(_G.UISpecialFrames, "DiabolicChatCopyFrame") -- Escape closes it

	-- the windows' (windows.lua): stone in its iron frame, the title in the
	-- red band, the X in its socket, the text in a darker panel
	local window = kit:CreateWindow(frame, { 0, 0, 0, 0 })
	kit:SetBackground(window, "dome")
	local header = kit:CreateHeader(window, look.header_height, look.header_insets)
	local title = frame:CreateFontString(nil, "OVERLAY")
	kit:SetTitle(header, title)
	title:SetText(L["Copy Chat"])
	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	kit:StyleClose(close, window, header)

	local top = look.header_insets[2] + look.header_height + PADDING
	local scroll = CreateFrame("ScrollFrame", "DiabolicChatCopyScroll", frame, "UIPanelScrollFrameTemplate")
	scroll:SetPoint("TOPLEFT", SIDE, -top)
	scroll:SetPoint("BOTTOMRIGHT", -SIDE - BAR, SIDE)
	kit:StyleScrollBar(_G.DiabolicChatCopyScrollScrollBar)
	kit:AddPanel(scroll, look.list_panel_insets)

	local editBox = CreateFrame("EditBox", nil, scroll)
	editBox:SetMultiLine(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(_G.ChatFontNormal)
	editBox:SetWidth(WIDTH - 2 * SIDE - BAR)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	scroll:SetScrollChild(editBox)

	self.frame, self.editBox = frame, editBox
end

Module.Show = function(self, chatFrame)
	if (not self.frame) then
		self:CreateWindow()
	end
	self.frame:Show()
	self.editBox:SetText(self:GetText(chatFrame))
	self.editBox:SetFocus()
	self.editBox:HighlightText()
end

Module.HookFrame = function(self, frame)
	if (not frame) or history[frame] then
		return
	end
	history[frame] = { count = 0 }
	hooksecurefunc(frame, "AddMessage", OnAddMessage)
	-- Blizzard's double-click only minimizes undocked windows
	_G[frame:GetName() .. "Tab"]:HookScript("OnDoubleClick", function(_, button)
		if (button ~= "RightButton") then
			self:Show(frame)
		end
	end)
end

Module.OnEnable = function(self)
	for i = 1, _G.NUM_CHAT_WINDOWS do
		-- not the combat log: it scrolls constantly
		if (i ~= 2) then
			self:HookFrame(_G["ChatFrame" .. i])
		end
	end
	-- whispers and the like popped out into their own windows
	hooksecurefunc("FCF_OpenTemporaryWindow", function()
		for _, name in ipairs(_G.CHAT_FRAMES) do
			self:HookFrame(_G[name])
		end
	end)
end
