-- Gives the Group Bulletin Board addon's window Diablo III's (windows.lua):
-- the window in its iron frame instead of its dark square, its title in the
-- plate over the red band, its close and settings buttons in the band, its
-- buttons ours. Its requests a guild's notice board: parchment notes nailed
-- to the planks in rows, under their dungeon's name. The window grows
-- around its frame, which it sizes and places itself.
-- Art, fonts and places only: the addon's code is left as it is (its notes
-- are its own rows, placed again after each of its updates).
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Bulletin Board", "LOW")

local kit

local ADDON = "GroupBulletinBoard"

-- The colours in a text (|cAARRGGBB: class names, links) darker, for ink
-- on paper.
local Darken = function(text, factor)
	return (
		text:gsub("|c(%x%x)(%x%x)(%x%x)(%x%x)", function(a, r, g, b)
			local dark = function(hex)
				return math.floor(tonumber(hex, 16) * factor)
			end
			return ("|c%s%02x%02x%02x"):format(a, dark(r), dark(g), dark(b))
		end)
	)
end

-- A row of the addon's made a note (once): its paper and its nail.
Module.StyleNote = function(self, frame, index)
	if frame.DiabolicNote then
		return
	end
	local spec = self.config.board
	local paper = frame:CreateTexture(nil, "BACKGROUND")
	paper:SetTexture(spec.notes)
	local row = index % spec.note_rows
	paper:SetTexCoord(0, 1, row / spec.note_rows, (row + 1) / spec.note_rows)
	frame.DiabolicNote = paper
	local nail = frame:CreateTexture(nil, "OVERLAY")
	nail:SetTexture(spec.nail)
	nail:SetSize(spec.nail_size, spec.nail_size)
	nail:SetPoint("CENTER", frame, "TOP", 0, -spec.nail_y)
	local line = frame:CreateTexture(nil, "BORDER")
	line:SetTexture(unpack(spec.line_color))
	line:SetHeight(1)
	frame.DiabolicLine = line
	self:SizeNote(frame)
end

-- Its paper (and shadow) around the note, whatever its size.
Module.SizeNote = function(self, frame)
	local spec = self.config.board
	local left, top, right, bottom = unpack(spec.art)
	local cw, ch = unpack(spec.canvas)
	local sx, sy = frame:GetWidth() / (right - left), frame:GetHeight() / (bottom - top)
	local paper = frame.DiabolicNote
	paper:ClearAllPoints()
	paper:SetPoint("TOPLEFT", frame, "TOPLEFT", -left * sx, top * sy)
	paper:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", (cw - right) * sx, -(ch - bottom) * sy)
end

-- Its name, message and time on the paper, in ink.
Module.WriteNote = function(self, frame)
	local spec = self.config.board
	local name = frame:GetName()
	local who, message, when = _G[name .. "_name"], _G[name .. "_message"], _G[name .. "_time"]
	local side, top, bottom = unpack(spec.padding)
	local width = frame:GetWidth() - side * 2
	who:SetFontObject(spec.name_font)
	who:SetShadowColor(0, 0, 0, 0)
	who:SetTextColor(unpack(spec.ink))
	who:ClearAllPoints()
	who:SetPoint("TOPLEFT", frame, "TOPLEFT", side, -top)
	who:SetWidth(width)
	who:SetText(Darken(who:GetText() or "", spec.darken))
	local line = frame.DiabolicLine
	line:ClearAllPoints()
	line:SetPoint("TOPLEFT", who, "BOTTOMLEFT", 0, -spec.name_gap)
	line:SetWidth(width)
	message:SetFontObject(spec.message_font)
	message:SetShadowColor(0, 0, 0, 0)
	message:SetTextColor(unpack(spec.ink))
	message:ClearAllPoints()
	message:SetPoint("TOPLEFT", line, "BOTTOMLEFT", 0, -spec.name_gap)
	message:SetWidth(width)
	message:SetHeight(math.ceil(select(2, message:GetFont()) * spec.line_height * spec.lines))
	message:SetText(Darken(message:GetText() or "", spec.darken))
	when:SetFontObject(spec.time_font)
	when:SetShadowColor(0, 0, 0, 0)
	when:SetTextColor(unpack(spec.time_ink))
	when:ClearAllPoints()
	when:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -side, bottom)
end

-- After each of the addon's updates: its dungeons' names across the board,
-- their requests as notes in rows under them.
Module.LayOutBoard = function(self)
	local GBB = _G.GroupBulletinBoard_Addon
	local list = GBB and GBB.RequestList
	local rows = GBB and GBB.FramesEntries
	if not (list and rows) then
		return
	end
	local spec = self.config.board
	local child = _G.GroupBulletinBoardFrame_ScrollChildFrame
	local left, top, right = unpack(spec.margin)
	local room = _G.GroupBulletinBoardFrame_ScrollFrame:GetWidth() - left - right
	local columns = math.max(1, math.floor((room + spec.gap) / (spec.width + spec.gap)))
	local width = (room - spec.gap * (columns - 1)) / columns
	local y, column, dungeon, headers = top, 0, nil, {}
	for index, request in ipairs(list) do
		local header = rows[request.dungeon]
		if (request.dungeon ~= dungeon) and header and header:IsShown() then
			dungeon = request.dungeon
			if column > 0 then
				y, column = y + spec.height + spec.gap, 0
			end
			header:ClearAllPoints()
			header:SetPoint("TOPLEFT", child, "TOPLEFT", left, -y)
			header:SetPoint("RIGHT", child, "RIGHT", -right, 0)
			header:SetHeight(spec.header_height)
			_G[header:GetName() .. "_name"]:SetFontObject(spec.header_font)
			headers[dungeon] = y
			y = y + spec.header_height
		end
		local frame = rows[index]
		if frame and frame:IsShown() then
			-- (off the grid a little, the same each time)
			local dx = (index * 7) % (spec.jitter * 2 + 1) - spec.jitter
			local dy = (index * 5) % (spec.jitter * 2 + 1) - spec.jitter
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", child, "TOPLEFT", left + column * (width + spec.gap) + dx, -(y + dy))
			frame:SetSize(width, spec.height)
			self:StyleNote(frame, index)
			self:SizeNote(frame)
			self:WriteNote(frame)
			column = column + 1
			if column == columns then
				y, column = y + spec.height + spec.gap, 0
			end
		end
	end
	if column > 0 then
		y = y + spec.height + spec.gap
	end
	GBB.dungeonHeaderY = headers -- (where it keeps the top dungeon in sight)
	local scroll = _G.GroupBulletinBoardFrame_ScrollFrame
	child:SetHeight(math.max(y, scroll:GetHeight()))
	scroll:SetVerticalScroll(math.min(scroll:GetVerticalScroll(), math.max(0, y - scroll:GetHeight())))
end

Module.StyleBoard = function(self)
	local config = self.config
	local frame = _G.GroupBulletinBoardFrame
	kit:HideTextures(frame) -- its dark square and its icon
	local window = kit:CreateWindow(frame, config.insets)
	kit:SetBackground(window, "floor") -- the board's planks
	local header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(header, _G.GroupBulletinBoardFrameTitle)
	local close = _G.GroupBulletinBoardFrameCloseButton
	kit:StyleClose(close, window, header)
	-- (its settings button left of it: windows/GroupBulletinBoardFrame.qml)
	local settings = _G.GroupBulletinBoardFrameSettingsButton
	if settings then
		settings:SetFrameLevel(close:GetFrameLevel())
	end
	kit:StyleButtons(frame)
	local GBB = _G.GroupBulletinBoard_Addon
	if GBB and GBB.UpdateList then
		hooksecurefunc(GBB, "UpdateList", function()
			self:LayOutBoard()
		end)
	end
end

Module.ADDON_LOADED = function(self, event, addon)
	if addon == ADDON then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleBoard()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").bulletin_board
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	if IsAddOnLoaded(ADDON) and _G.GroupBulletinBoardFrame then
		self:StyleBoard()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
