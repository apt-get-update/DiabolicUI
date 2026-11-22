-- The item socketing window in the look of the other windows: the item's
-- text on slate, its sockets in a row on a stone pane under it (round in
-- the title gem's amber ring: a gem, or their colour's glass; a gem put
-- in, a ring of light around it), the item round in the title plate's gem,
-- Socket Gems in the foot. Art and places only:
-- Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Socketing", "LOW")

local kit

-- The slate, the text on it, the item's gem and Socket Gems (once, as the
-- window first updates: its title plate is the panel's by then). A column:
-- the slate, the sockets' pane under it as wide, the foot; Fit sizes it.
Module.Build = function(self)
	local spec, frame = self.config, _G.ItemSocketingFrame
	-- (on a frame of its own: Blizzard resizes the text's width)
	local slate = CreateFrame("Frame", "ItemSocketingFrameDiabolicSlate", frame)
	slate:SetPoint("TOPLEFT", frame, "TOPLEFT", spec.slate[1], -spec.slate[2])
	slate:SetSize(spec.slate[3], spec.text_height + 2 * spec.text_y)
	local zone = kit:AddZone(slate, "slate", { 0, 0, 0, 0 })
	kit:SeatScrollBar(_G.ItemSocketingScrollFrameScrollBar, zone) -- (on the slate's right, as every list's)
	self.slate = slate
	local pane = CreateFrame("Frame", "ItemSocketingFrameDiabolicPane", frame)
	pane:SetFrameLevel(frame:GetFrameLevel())
	pane:SetPoint("TOP", slate, "BOTTOM", 0, -spec.gap)
	pane:SetSize(spec.slate[3], spec.pane_height)
	kit:StylePane(pane)
	self.pane = pane
	self.gem = kit:AddTitleGem(_G.ItemSocketingFrameDiabolicTitle.DiabolicHeader)
	self.gem:EnableMouse(false)
	local button = _G.ItemSocketingSocketButton
	button:ClearAllPoints()
	button:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", unpack(spec.button))
	for i = 1, spec.sockets do
		self:StyleSocket(i)
	end
	-- (Blizzard's width for the text changes with its scroll bar)
	hooksecurefunc("ItemSocketingSocketButton_OnScrollRangeChanged", function()
		self:Fit()
	end)
	self.built = true
end

-- The column to the text: the slate as tall as it (up to text_height, then
-- it scrolls, its bar on the slate's right), the window as tall as the
-- column and the foot.
Module.Fit = function(self)
	local spec, scroll = self.config, _G.ItemSocketingScrollFrame
	local height = math.min(math.max(_G.ItemSocketingDescription:GetHeight(), spec.text_min), spec.text_height)
	-- what scrolls as tall as the text (Blizzard's 250: a scroll bar on any
	-- item), a scroll bar only for a long one
	_G.ItemSocketingScrollChild:SetHeight(math.max(1, _G.ItemSocketingDescription:GetHeight()))
	scroll:SetHeight(height)
	scroll:ClearAllPoints()
	scroll:SetPoint("TOPLEFT", self.slate, "TOPLEFT", spec.text_x, -spec.text_y)
	self.slate:SetHeight(height + 2 * spec.text_y)
	_G.ItemSocketingFrame:SetHeight(spec.slate[2] + height + 2 * spec.text_y + spec.gap + spec.pane_height + spec.gap + spec.foot)
end

-- A socket as the title's gem: Blizzard's art out of sight, round glass
-- for when it's empty, the amber ring, its ring of light under it.
Module.StyleSocket = function(self, i)
	local spec, name = self.config, "ItemSocketingSocket" .. i
	local socket, gem = _G[name], kit.config.title_plate.gem
	kit:HideArt(socket, { "ui%-itemsockets" })
	socket:SetSize(spec.socket_size, spec.socket_size)
	_G[name .. "IconTexture"]:SetSize(spec.gem_size, spec.gem_size)
	local empty = socket:CreateTexture(nil, "BORDER")
	empty:SetTexture(spec.glass)
	empty:SetSize(spec.gem_size, spec.gem_size)
	empty:SetPoint("CENTER")
	socket.DiabolicEmpty = empty
	local light = socket:CreateTexture(nil, "OVERLAY")
	light:SetTexture(spec.glow)
	light:SetTexCoord(unpack(spec.ring.coords))
	light:SetBlendMode("ADD")
	light:SetSize(spec.ring.size, spec.ring.size)
	light:SetPoint("CENTER")
	socket.DiabolicRing = light
	local ring = socket:CreateTexture(nil, "OVERLAY")
	ring:SetTexture(gem.ring)
	ring:SetSize(spec.gem_size / gem.glass, spec.gem_size / gem.glass)
	ring:SetPoint("CENTER")
end

-- After each of Blizzard's updates: the item in the gem, the sockets in a
-- row, their gems round, each empty one's glass, the new gems' rings of
-- light, the item's name.
Module.Update = function(self)
	if not self.built then
		self:Build()
	end
	local spec = self.config
	local _, icon = GetSocketItemInfo()
	if icon then
		SetPortraitToTexture(self.gem.icon, icon)
	end
	local count = math.min(GetNumSockets(), spec.sockets)
	for i = 1, count do
		local name = "ItemSocketingSocket" .. i
		local socket = _G[name]
		socket:ClearAllPoints()
		socket:SetPoint("CENTER", self.pane, "CENTER", (i - (count + 1) / 2) * spec.socket_gap, 0)
		local gem = _G[name .. "IconTexture"]
		local file = gem:IsShown() and gem:GetTexture()
		if file then
			SetPortraitToTexture(gem, file)
			socket.DiabolicEmpty:Hide()
		else
			local column = spec.glass_cells[GetSocketTypes(i)] or spec.glass_cells.Socket
			socket.DiabolicEmpty:SetTexCoord(column * spec.glass_cell, (column + 1) * spec.glass_cell, 0, 1)
			socket.DiabolicEmpty:Show()
		end
		if GetNewSocketInfo(i) then
			socket.DiabolicRing:Show()
		else
			socket.DiabolicRing:Hide()
		end
	end
	-- its name a title (Exocet, its quality's colour kept)
	_G.ItemSocketingDescriptionTextLeft1:SetFontObject(spec.title_font)
	self:Fit()
end

Module.StyleSocketing = function(self)
	if not _G.ItemSocketingFrame_Update then
		return
	end
	-- its size before the window's stone is laid
	_G.ItemSocketingFrame:SetSize(unpack(self.config.size))
	kit:SetPanelLayout(_G.ItemSocketingFrame, self.config.insets)
	hooksecurefunc("ItemSocketingFrame_Update", function()
		self:Update()
	end)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").socketing
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	self:WhenLoaded("Blizzard_ItemSocketingUI", "StyleSocketing")
end
