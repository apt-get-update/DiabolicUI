--[[

	The MIT License (MIT)

	Copyright (c) 2023 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
-- "Minimap" module: the Diabolic look for Blizzard's minimap (its own
-- border, clock, zone name, mail button and compass), moved and resized with
-- Unlock Frames or on the options' Positions page. Its size and place are
-- the "Minimap" config (defaults/minimap.lua), the rest settings/minimap.lua.
local ADDON, Engine = ...
local Module = Engine:NewModule("Minimap", "LOW")

local TEXTURES = ([[Interface\AddOns\%s\media\textures\]]):format(ADDON)

-- The map's size in the Diabolic look (198 / 140 would be Blizzard's): its
-- art and frame are laid out for it. At the 100% of the player's size, the
-- whole minimap is SIZE_BASE of that.
local DIABOLIC_MAP_SCALE = 1.614
local SIZE_BASE = 0.8

local config, db, colors -- (settings/minimap.lua, defaults/minimap.lua, config.colors)

-- Blizzard's pieces the Diabolic look replaces are parented to this.
local hider = CreateFrame("Frame")
hider:Hide()
Module.hider = hider

-- Clock ---------------------------------------------------------------------

local LocalTime = function()
	return tonumber(date("%H")), tonumber(date("%M"))
end

local Time_UpdateTooltip = function(self)
	local r, g, b = unpack(colors.normal)
	local rh, gh, bh = unpack(colors.highlight)
	GameTooltip:SetOwner(self:GetParent(), "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -40, 0)
	GameTooltip:AddLine(TIMEMANAGER_TOOLTIP_TITLE, unpack(colors.title))
	GameTooltip:AddDoubleLine(
		TIMEMANAGER_TOOLTIP_LOCALTIME,
		string.format("%02.0f:%02.0f", LocalTime()),
		rh,
		gh,
		bh,
		r,
		g,
		b
	)
	GameTooltip:AddDoubleLine(
		TIMEMANAGER_TOOLTIP_REALMTIME,
		string.format("%02.0f:%02.0f", GetGameTime()),
		rh,
		gh,
		bh,
		r,
		g,
		b
	)
	GameTooltip:AddLine("<" .. GAMETIME_TOOLTIP_TOGGLE_CALENDAR .. ">", unpack(colors.questGreen))
	GameTooltip:Show()
end

local Time_OnEnter = function(self)
	self.UpdateTooltip = Time_UpdateTooltip
	self:UpdateTooltip()
end

local Time_OnLeave = function(self)
	self.UpdateTooltip = nil
	GameTooltip:Hide()
end

local Time_OnClick = function(self)
	if not InCombatLockdown() then
		ToggleCalendar()
	end
end

-- once a second
local Time_OnUpdate = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 1 then
		self.elapsed = 0
		Module:UpdateClock()
	end
end

Module.UpdateClock = function(self)
	self.time:SetFormattedText("%02d:%02d", LocalTime())
end

-- Mail ----------------------------------------------------------------------

local Mail_OnEnter = function(self)
	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	local sender1, sender2, sender3 = GetLatestThreeSenders()
	if sender1 or sender2 or sender3 then
		GameTooltip:AddLine(HAVE_MAIL_FROM, unpack(colors.highlight))
		for _, sender in ipairs({ sender1, sender2, sender3 }) do
			GameTooltip:AddLine(sender, unpack(colors.green))
		end
	else
		GameTooltip:AddLine(HAVE_MAIL, unpack(colors.highlight))
	end
	GameTooltip:Show()
end

local Mail_OnLeave = function()
	GameTooltip:Hide()
end

Module.UpdateMail = function(self)
	local mail = self.mail
	if HasNewMail() then
		mail:Show()
		mail.frame:Show()
	else
		mail:Hide()
		mail.frame:Hide()
	end
end

-- Compass: a rotating minimap's N, following the player's facing ------------

Module.UpdateCompass = function(self)
	local compass = self.compass
	local facing = self.rotateMinimap and GetPlayerFacing()
	if not facing then
		compass:SetAlpha(0)
		return
	end
	compass:SetAlpha(1)
	local radius = compass:GetWidth() / 2
	local angle = -facing + math.pi / 2
	compass.north:SetPoint("CENTER", radius * math.cos(angle), radius * math.sin(angle))
end

local Compass_OnUpdate = function()
	Module:UpdateCompass()
end

-- every frame while the minimap rotates (its own option in the game's)
Module.UpdateRotation = function(self)
	self.rotateMinimap = GetCVarBool("rotateMinimap")
	self.compass:SetScript("OnUpdate", self.rotateMinimap and Compass_OnUpdate or nil)
	self:UpdateCompass()
end

-- Zone name: a crossfade to each new zone -----------------------------------

-- Fades the name out, puts the new one in at the bottom, and fades it back in.
local ZoneFade_OnUpdate = function(self, elapsed)
	local zoneName = Module.zoneName
	local progress = math.min(1, (self.progress or 0) + elapsed / config.zoneFadeDuration)
	self.progress = progress
	if self.pending then
		zoneName:SetAlpha(Module.zoneAlpha * (1 - progress))
		if progress == 1 then
			local pending = self.pending
			zoneName:SetText(pending.text)
			zoneName:SetTextColor(pending.r, pending.g, pending.b, Module.zoneAlpha)
			zoneName:SetAlpha(0)
			self.pending, self.progress = nil, 0
		end
	else
		zoneName:SetAlpha(Module.zoneAlpha * progress)
		if progress == 1 then
			self:SetScript("OnUpdate", nil)
		end
	end
end

Module.UpdateZone = function(self)
	local text = GetMinimapZoneText()
	local color = colors.zone[GetZonePVPInfo() or ""] or colors.normal
	local r, g, b = color[1], color[2], color[3]
	-- (also called by PvP status updates in the same zone: no fade then)
	if text ~= self.lastZoneName then
		self.lastZoneName = text
		local fader = self.zoneFader
		fader.pending = { text = text, r = r, g = g, b = b }
		fader.progress = 0
		fader:SetScript("OnUpdate", ZoneFade_OnUpdate)
	elseif not self.zoneFader.pending then
		self.zoneName:SetTextColor(r, g, b, self.zoneAlpha)
	end
end

-- Pieces on the minimap's outer side ----------------------------------------

-- Which half of the screen the minimap is on: they sit on the side facing the
-- screen's edge, mirrored once it's moved to the left half.
local IsOnTheLeft = function()
	local minimapX, screenX = Minimap:GetCenter(), UIParent:GetCenter()
	return minimapX and screenX and minimapX < screenX
end

-- Each piece: its point on the right half of the screen, then on the left.
local OUTER = {
	eye = { { "TOPRIGHT", 4, 2 }, { "TOPLEFT", -4, 2 } },
	mail = { { "TOPLEFT", -4, 2 }, { "TOPRIGHT", 4, 2 } },
	mbb = { { "BOTTOMLEFT", -4, -2 }, { "BOTTOMRIGHT", 4, -2 } },
}

local PlaceOuter = function(frame, where, left)
	local point, x, y = unpack(where[left and 2 or 1])
	frame:ClearAllPoints()
	frame:SetPoint(point, Minimap, x, y)
end

Module.UpdateOuterElements = function(self)
	local left = IsOnTheLeft()
	PlaceOuter(MiniMapLFGFrame, OUTER.eye, left)
	PlaceOuter(self.mail.frame, OUTER.mail, left)
	if self.mbbButton then
		PlaceOuter(self.mbbButton, OUTER.mbb, left)
	end
	-- the zone name's outer edge flush with the minimap's
	local zoneName = self.zoneName
	local point = left and "TOPLEFT" or "TOPRIGHT"
	zoneName:ClearAllPoints()
	zoneName:SetPoint(point, Minimap, point, 0, 25)
	zoneName:SetJustifyH(left and "LEFT" or "RIGHT")
end

-- The look -------------------------------------------------------------------

-- Blizzard's pieces: hidden ones the Diabolic look replaces, and the parents
-- of the ones it keeps.
local BLIZZARD = {
	MinimapBorderTop = false,
	MinimapBorder = false,
	GameTimeFrame = false,
	TimeManagerClockButton = false,
	MinimapCompassTexture = false,
	MiniMapInstanceDifficulty = false,
	MiniMapMailFrame = false,
	MiniMapTracking = false,
	MinimapZoneTextButton = false,
	MinimapZoomIn = false,
	MinimapZoomOut = false,
	MiniMapWorldMapButton = false,
	MiniMapLFGFrame = "MinimapBackdrop",
	MiniMapBattlefieldFrame = "Minimap",
}

-- Its own textures behind and around the map (sizes before the map scale),
-- in the UI color unless they have their own.
local MAP_TEXTURES = {
	{
		path = "minimap-mask-opaque",
		size = 280,
		point = { "CENTER" },
		layer = "BACKGROUND",
		level = -7,
		color = { 0, 0, 0, 0.75 },
	},
	{ path = "minimap-border", size = 340, point = { "CENTER", -1, 0 }, layer = "BORDER", level = 1 },
	{ path = "shade-circle", size = 280, point = { "CENTER", -1, 0 }, layer = "BORDER", level = 1 },
}

-- A texture on `parent` in the Diabolic look's orange eye.
local CreateEye = function(parent, size)
	local eye = parent:CreateTexture()
	eye:SetSize(size, size)
	eye:SetPoint("CENTER", 0, 0)
	eye:SetTexture(TEXTURES .. "group-finder-eye-orange")
	eye:SetDrawLayer("BORDER", 2)
	eye:SetVertexColor(0.90, 0.95, 1)
	return eye
end

-- Outlined, shadowless fonts in the mail's typeface.
local CreateMinimapFont = function(size)
	local font = CreateFont("DiabolicFont_Minimap" .. size)
	font:SetFontObject(MailFont_Large)
	font:SetFont(font:GetFont(), size, "OUTLINE")
	font:SetShadowColor(0, 0, 0, 0)
	font:SetShadowOffset(0, 0)
	font:SetJustifyH("LEFT")
	return font
end

Module.ApplyTheme = function(self)
	for name, parent in pairs(BLIZZARD) do
		_G[name]:SetParent(parent and _G[parent] or hider)
	end

	for _, texture in ipairs(MAP_TEXTURES) do
		local object = Minimap:CreateTexture()
		object:SetSize(texture.size / DIABOLIC_MAP_SCALE, texture.size / DIABOLIC_MAP_SCALE)
		object:SetPoint(unpack(texture.point))
		object:SetTexture(TEXTURES .. texture.path)
		object:SetDrawLayer(texture.layer, texture.level)
		object:SetVertexColor(unpack(texture.color or colors.ui))
	end

	-- Dungeon finder eye: a border button the size of the mail button, its
	-- art a little larger than the mail icon
	CreateEye(MiniMapLFGFrame, 40)
	MiniMapLFGFrame:SetParent(Minimap)
	MiniMapLFGFrame:SetFrameLevel(100)
	MiniMapLFGFrame:SetSize(48, 48)
	MiniMapLFGFrame:SetScale(1) -- the mail button's (not the art's)
	MiniMapLFGFrame:SetHitRectInsets(0, 0, 0, 0)
	-- Blizzard's own hover glow, desaturated so it doesn't clash with the eye
	local highlight = MiniMapLFGFrame:GetHighlightTexture()
	if highlight then
		highlight:SetDesaturated(true)
	end
	MiniMapLFGFrameBorder:Hide()
	MiniMapLFGFrameIcon:Hide()

	-- Battleground queue: the same eye at the bottom left, instead of
	-- Blizzard's icon, border and shine
	CreateEye(MiniMapBattlefieldFrame, 64)
	PVPBattleground_UpdateQueueStatus()
	BattlefieldFrame_UpdateStatus(false)
	MiniMapBattlefieldFrame:SetFrameStrata("MEDIUM")
	MiniMapBattlefieldFrame:SetFrameLevel(70) -- Minimap's XP button is 60
	MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, 4, 2)
	MiniMapBattlefieldFrame:SetHitRectInsets(-8, -8, -8, -8)
	MiniMapBattlefieldIcon:Hide()
	MiniMapBattlefieldBorder:Hide()
	BattlegroundShine:Hide()
	BattlefieldIconText:Hide()
end

-- The border art, clock, zone name and compass sit in a frame scaled down by
-- the map's own enlargement: they grow and shrink with the map.
Module.CreateCustomElements = function(self)
	local font16, font14 = CreateMinimapFont(16), CreateMinimapFont(14)

	local frame = CreateFrame("Frame", nil, Minimap)
	frame:SetFrameLevel(Minimap:GetFrameLevel())
	frame:SetAllPoints(Minimap)
	frame:SetScale(1 / DIABOLIC_MAP_SCALE)
	self.widgetFrame = frame

	local compass = CreateFrame("Frame", nil, frame)
	compass:SetFrameLevel(Minimap:GetFrameLevel() + 5)
	compass:SetPoint("TOPLEFT", config.compassInset, -config.compassInset)
	compass:SetPoint("BOTTOMRIGHT", -config.compassInset, config.compassInset)
	local north = compass:CreateFontString(nil, "ARTWORK", nil, 1)
	north:SetFontObject(font16)
	north:SetTextColor(colors.normal[1], colors.normal[2], colors.normal[3], 0.75)
	north:SetText(config.compassNorthTag)
	compass.north = north
	self.compass = compass

	local zoneName = Minimap:CreateFontString()
	zoneName:SetDrawLayer("OVERLAY", 1)
	zoneName:SetFontObject(font16)
	zoneName:SetAlpha(0.85)
	self.zoneName = zoneName
	self.zoneAlpha = 0.85
	self.zoneFader = CreateFrame("Frame", nil, Minimap)

	local timeFrame = CreateFrame("Button", nil, Minimap)
	timeFrame:SetScript("OnEnter", Time_OnEnter)
	timeFrame:SetScript("OnLeave", Time_OnLeave)
	timeFrame:SetScript("OnClick", Time_OnClick)
	timeFrame:SetScript("OnUpdate", Time_OnUpdate)
	timeFrame:RegisterForClicks("AnyUp")
	local time = timeFrame:CreateFontString()
	time:SetDrawLayer("OVERLAY", 1)
	time:SetJustifyH("CENTER")
	time:SetJustifyV("TOP")
	time:SetFontObject(font14)
	time:SetTextColor(unpack(colors.offwhite))
	time:SetAlpha(0.85)
	time:SetPoint("TOP", Minimap, "BOTTOM", 0, 20)
	timeFrame:SetAllPoints(time)
	self.time = time

	-- the mail icon is baked into the button's art
	local mailFrame = CreateFrame("Frame", nil, Minimap)
	mailFrame:SetFrameLevel(mailFrame:GetFrameLevel() + 10)
	mailFrame:SetFrameStrata("LOW")
	mailFrame:SetSize(unpack(config.mailSize))
	local mailButton = CreateFrame("Button", nil, mailFrame)
	mailButton:SetAllPoints(mailFrame)
	mailButton:SetScript("OnEnter", Mail_OnEnter)
	mailButton:SetScript("OnLeave", Mail_OnLeave)
	local mail = mailFrame:CreateTexture(nil, "ARTWORK")
	mail:SetAllPoints(mailFrame)
	mail:SetTexture(TEXTURES .. "button-mail")
	mail:SetAlpha(0.85)
	mail.frame = mailFrame
	self.mail = mail

	-- the battleground eye too
	MiniMapBattlefieldFrame:SetScale(1 / DIABOLIC_MAP_SCALE)
end

-- MinimapButtonBag: its button as a "+" on the minimap's border.
Module.StyleMBB = function(self)
	local button = CreateFrame("Frame", nil, Minimap)
	button:SetFrameLevel(button:GetFrameLevel() + 10)
	button:SetSize(48, 48)
	button:SetFrameStrata("LOW") -- MEDIUM collides with Immersion
	self.mbbButton = button

	local frame = _G.MBB_MinimapButtonFrame
	frame:SetParent(button)
	frame:RegisterForDrag()
	frame:SetSize(48, 48)
	frame:ClearAllPoints()
	frame:SetFrameStrata("LOW")
	frame:SetPoint("CENTER", 0, 0)
	frame:SetHighlightTexture("")
	frame:DisableDrawLayer("OVERLAY")
	local noop = function() end
	frame.ClearAllPoints = noop
	frame.SetPoint = noop
	frame.SetAllPoints = noop

	local icon = _G.MBB_MinimapButtonFrame_Texture
	icon:ClearAllPoints()
	icon:SetPoint("CENTER", 0, 0)
	icon:SetSize(48, 48)
	icon:SetTexture(TEXTURES .. "button-toggle-plus")
	icon:SetTexCoord(0, 1, 0, 1)
	icon:SetAlpha(0.85)

	local down, over
	local SetAlpha = function()
		icon:SetAlpha((down and over) and 1 or (down or over) and 0.95 or 0.85)
	end
	frame:SetScript("OnMouseDown", function()
		down = true
		SetAlpha()
	end)
	frame:SetScript("OnMouseUp", function()
		down = false
		SetAlpha()
	end)
	frame:SetScript("OnEnter", function(frame)
		_G.MBB_ShowTimeout = -1
		over = true
		SetAlpha()
		GameTooltip_SetDefaultAnchor(GameTooltip, frame)
		GameTooltip:AddLine("MinimapButtonBag v" .. _G.MBB_Version)
		GameTooltip:AddLine(_G.MBB_TOOLTIP1, 0, 1, 0, true)
		GameTooltip:Show()
	end)
	frame:SetScript("OnLeave", function()
		_G.MBB_ShowTimeout = 0
		over = false
		SetAlpha()
		GameTooltip:Hide()
	end)
end

-- Size and place -------------------------------------------------------------

-- The map's scale at 100%: the Diabolic size on a 1080 pixels high screen,
-- times DiabolicUI's UI Scale.
Module.GetBaseScale = function(self)
	local scaling = Engine:GetConfig("ScreenScaling")
	return DIABOLIC_MAP_SCALE * SIZE_BASE * (768 / 1080) / UIParent:GetScale() * (scaling.scale or 1)
end

-- The size the player chose, within its limits.
Module.GetUserScale = function(self)
	return db.size
end

Module.SetUserScale = function(self, size)
	db.size = math.min(config.maxSize, math.max(config.minSize, size))
	self:UpdateSize()
end

-- (out of combat: waits for its end otherwise)
Module.UpdateSize = Engine:Wrap(function(self)
	Minimap:SetScale(self:GetBaseScale() * db.size)
end)

Module.UpdatePosition = function(self)
	local position = db.position or config.position
	Minimap:ClearAllPoints()
	Minimap:SetPoint(position.point, UIParent, position.point, position.x, position.y)
	self:UpdateOuterElements()
end

-- The point of UIParent the minimap is nearest to (its corners, its edges'
-- middles or its center) and the offset from there, in the minimap's scale.
Module.GetAnchor = function(self)
	local frame = Minimap
	local x, y = frame:GetCenter()
	if not (x and y) then
		return "CENTER", 0, 0
	end
	local scale, uiScale = frame:GetEffectiveScale(), UIParent:GetEffectiveScale()
	x, y = x * scale, y * scale
	local width, height = UIParent:GetWidth() * uiScale, UIParent:GetHeight() * uiScale
	local left = frame:GetLeft() * scale - UIParent:GetLeft() * uiScale
	local bottom = frame:GetBottom() * scale - UIParent:GetBottom() * uiScale
	local right = frame:GetRight() * scale - UIParent:GetRight() * uiScale
	local top = frame:GetTop() * scale - UIParent:GetTop() * uiScale

	local horizontal, offsetX = "", x - width / 2
	if x < width / 3 then
		horizontal, offsetX = "LEFT", left
	elseif x > width * 2 / 3 then
		horizontal, offsetX = "RIGHT", right
	end
	local vertical, offsetY = "", y - height / 2
	if y < height / 3 then
		vertical, offsetY = "BOTTOM", bottom
	elseif y > height * 2 / 3 then
		vertical, offsetY = "TOP", top
	end
	local point = (vertical .. horizontal ~= "") and (vertical .. horizontal) or "CENTER"
	return point, offsetX / scale, offsetY / scale
end

Module.SavePosition = function(self)
	local point, x, y = self:GetAnchor()
	db.position = { point = point, x = x, y = y }
	self:UpdateOuterElements()
end

-- Edit mode: Unlock Frames (modules/menu/movers.lua) turns it on and off.
-- Left-drag moves the minimap, right-drag resizes it. -------------------------

local editModeActive = false

local EditOverlay_OnDragStart = function(self, button)
	if button == "RightButton" then
		self.resizing = true
		self.startX, self.startY = GetCursorPosition()
		self.startScale = db.size
	else
		self.moving = true
		Minimap:StartMoving()
	end
end

local EditOverlay_OnDragStop = function(self)
	if self.resizing then
		self.resizing = false
	elseif self.moving then
		self.moving = false
		Minimap:StopMovingOrSizing()
		Module:SavePosition()
	end
end

-- while resizing: bigger to the bottom right, smaller to the top left
local EditOverlay_OnUpdate = function(self)
	if self.resizing then
		local x, y = GetCursorPosition()
		local delta = ((x - self.startX) + (self.startY - y)) / 2 / UIParent:GetEffectiveScale()
		Module:SetUserScale(self.startScale + delta / 200)
	end
end

-- The box over the minimap while editing: the same as DiabolicUI's other
-- frames' (modules/menu/movers.lua), covering the border ring too.
Module.CreateEditModeWidgets = function(self)
	local highlight = CreateFrame("Frame", nil, Minimap)
	highlight:SetFrameStrata("FULLSCREEN_DIALOG") -- over MBB's "+" and the mail and eye buttons too
	highlight:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 },
	})
	highlight:SetBackdropColor(0.6, 0.1, 0.1, 0.5)
	highlight:SetBackdropBorderColor(1, 0.82, 0, 1)
	highlight.Text = highlight:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	highlight.Text:SetPoint("CENTER")
	highlight.Text:SetText(MINIMAP_LABEL)
	highlight:EnableMouse(true)
	highlight:RegisterForDrag("LeftButton", "RightButton")
	highlight:SetScript("OnDragStart", EditOverlay_OnDragStart)
	highlight:SetScript("OnDragStop", EditOverlay_OnDragStop)
	highlight:SetScript("OnUpdate", EditOverlay_OnUpdate)
	highlight:Hide()
	self.editHighlight = highlight
end

-- The box covers the border ring, and MBB's button when it's shown: measured
-- each time edit mode starts, as offsets from the minimap.
local RING = 19
Module.FitEditHighlight = function(self)
	local left, right, top, bottom = Minimap:GetLeft(), Minimap:GetRight(), Minimap:GetTop(), Minimap:GetBottom()
	local l, r, t, b = -RING, RING, RING, -RING
	local mbb = _G.MBB_MinimapButtonFrame
	if (left and right and top and bottom) and (mbb and mbb:IsShown()) then
		local fl, fr, ft, fb = mbb:GetLeft(), mbb:GetRight(), mbb:GetTop(), mbb:GetBottom()
		if fl and fr and ft and fb then
			-- in the minimap's own scale (it's resizable, the button isn't)
			local scale = mbb:GetEffectiveScale() / Minimap:GetEffectiveScale()
			fl, fr, ft, fb = fl * scale, fr * scale, ft * scale, fb * scale
			l, r = math.min(l, fl - left), math.max(r, fr - right)
			t, b = math.max(t, ft - top), math.min(b, fb - bottom)
		end
	end
	local highlight = self.editHighlight
	highlight:ClearAllPoints()
	highlight:SetPoint("TOPLEFT", Minimap, "TOPLEFT", l, t)
	highlight:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", r, b)
end

Module.IsEditModeActive = function(self)
	return editModeActive
end

Module.EnterEditMode = function(self)
	if InCombatLockdown() or editModeActive then
		return
	end
	editModeActive = true
	if not self.editHighlight then
		self:CreateEditModeWidgets()
	end
	self:FitEditHighlight()
	self.editHighlight:Show()
end

Module.ExitEditMode = function(self)
	if not editModeActive then
		return
	end
	editModeActive = false
	Minimap:StopMovingOrSizing() -- (left mid-drag)
	local highlight = self.editHighlight
	highlight.moving, highlight.resizing = false, false
	highlight:Hide()
	self:SavePosition()
end

-- Setup ----------------------------------------------------------------------

-- Blizzard_TimeManager creates its saved stopwatch settings when it loads.
-- Loaded this early on 3.3.5, a late VARIABLES_LOADED can reset them to nil,
-- and the stopwatch then errors: made again the way Blizzard's code does.
local EnsureStopwatchOptions = function()
	if not _G.BlizzardStopwatchOptions then
		_G.BlizzardStopwatchOptions = {}
	end
end

-- Up to 1.6.6, the minimap kept its own saved settings: brought over once.
-- Its size then counted from another 100% ("sizeBase"), and /setscale
-- multiplied it.
local ImportOldSettings = function()
	local old = _G.DiabolicUI_Minimap_DB
	old = old and old.global
	if not old then
		return
	end
	local minimap = old.minimap or {}
	local relativeScale = old.core and old.core.relativeScale or 1
	local base = minimap.sizeBase or (minimap.sizeRebased and 0.8) or 1
	local size = (minimap.userScale and minimap.userScale * base / SIZE_BASE or 1) * relativeScale
	db.size = math.floor(size * 100 + 0.5) / 100
	db.position = minimap.storedPosition
	_G.DiabolicUI_Minimap_DB = nil
end

Module.OnEvent = function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		EnsureStopwatchOptions()
		self:UpdateZone()
		self:UpdateMail()
		self:UpdateRotation()
		self:UpdateClock()
	elseif event == "VARIABLES_LOADED" then
		EnsureStopwatchOptions()
		self:UpdateRotation()
		self:UpdateSize()
		self:UpdatePosition()
	elseif event == "UPDATE_PENDING_MAIL" then
		self:UpdateMail()
	elseif event == "CVAR_UPDATE" then
		self:UpdateRotation()
	else -- the zone changed
		self:UpdateZone()
	end
end

Module.OnInit = function(self)
	config = Engine:GetDB("Minimap")
	colors = config.colors
	db = Engine:GetConfig("Minimap")
	ImportOldSettings()
	db.size = math.min(config.maxSize, math.max(config.minSize, db.size))
end

Module.OnEnable = function(self)
	LoadAddOn("Blizzard_TimeManager")
	EnsureStopwatchOptions()

	MinimapCluster:EnableMouse(false)
	MinimapCluster:SetFrameLevel(1)
	Minimap:SetSize(280 / DIABOLIC_MAP_SCALE, 280 / DIABOLIC_MAP_SCALE)
	Minimap:SetMovable(true)
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript("OnMouseWheel", function(_, delta)
		if delta > 0 then
			MinimapZoomIn:Click()
		elseif delta < 0 then
			MinimapZoomOut:Click()
		end
	end)
	Minimap:SetScript("OnMouseUp", function(frame, button)
		if button == "RightButton" then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor")
		else
			Minimap_OnClick(frame)
		end
	end)

	self:CreateCustomElements()
	self:ApplyTheme()
	if Engine:IsAddOnEnabled("MBB") then
		if not IsAddOnLoaded("MBB") then
			LoadAddOn("MBB")
		end
		self:StyleMBB()
	end
	self:UpdateMail()
	self:UpdateRotation()
	self:UpdateClock()
	self:UpdatePosition()
	self:UpdateSize()

	for _, event in ipairs({
		"PLAYER_ENTERING_WORLD",
		"VARIABLES_LOADED",
		"CVAR_UPDATE",
		"UPDATE_PENDING_MAIL",
		"ZONE_CHANGED",
		"ZONE_CHANGED_INDOORS",
		"ZONE_CHANGED_NEW_AREA",
	}) do
		self:RegisterEvent(event, "OnEvent")
	end
end
