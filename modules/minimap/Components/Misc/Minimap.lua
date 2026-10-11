--[[

	The MIT License (MIT)

	Copyright (c) 2024 Lars Norberg

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
local _, ns = ..., DiabolicUIMinimapNS
local MinimapMod = ns:NewModule("Minimap", "AceTimer-3.0")

-- Lua API
local math_cos = math.cos
local half_pi = math.pi / 2
local math_sin = math.sin
local next = next
local string_format = string.format
local unpack = unpack

-- Addon API
local Colors = ns.Colors
local GetMedia = ns.API.GetMedia
local IsAddOnEnabled = ns.API.IsAddOnEnabled
local UIHider = ns.Hider
local noop = ns.Noop
local GetFont = ns.API.GetFont
local GetLocalTime = ns.API.GetLocalTime
local GetServerTime = ns.API.GetServerTime

-- WoW Strings
local L_HAVE_MAIL = HAVE_MAIL -- "You have unread mail"
local L_HAVE_MAIL_FROM = HAVE_MAIL_FROM -- "Unread mail from:"

local Time_UpdateTooltip = function(self)
	local r, g, b = unpack(Colors.normal)
	local rh, gh, bh = unpack(Colors.highlight)

	GameTooltip:SetOwner(self:GetParent(), "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -40, 0)
	GameTooltip:AddLine(TIMEMANAGER_TOOLTIP_TITLE, unpack(Colors.title))
	GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_LOCALTIME, string_format("%02.0f:%02.0f", GetLocalTime()), rh, gh, bh, r, g, b)
	GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_REALMTIME, string_format("%02.0f:%02.0f", GetServerTime()), rh, gh, bh, r, g, b)
	GameTooltip:AddLine("<"..GAMETIME_TOOLTIP_TOGGLE_CALENDAR..">", unpack(Colors.quest.green))
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

local Time_OnClick = function(self, mouseButton)
	if (not InCombatLockdown()) then
		ToggleCalendar()
	end
end

-- The map's size in the Diabolic look (198 / 140 would be Blizzard's).
local mapScale = 1.614

-- Returns the base scale of the minimap widget,
-- before the user's own edit mode resizing is factored in.
MinimapMod.GetBaseScale = function(self)
    return mapScale * ns.API.GetEffectiveScale()
end

-- Returns the user's chosen size multiplier, as set in edit mode.
MinimapMod.GetUserScale = function(self)
    return (ns.db and ns.db.global.minimap.userScale) or 1
end

-- Blizzard's own minimap pieces, and the parents they normally have.
local Objects = {}
local ObjectOwners = {}

-- The ones the Diabolic look hides: it draws its own border, clock, zone
-- name and mail button. The dungeon finder eye and the battleground queue
-- button stay.
local HIDDEN = {
    BorderTop = true, BorderClassic = true, Calendar = true, Clock = true, Compass = true,
    Difficulty = true, Mail = true, Tracking = true, Zone = true, ZoomIn = true, ZoomOut = true,
    WorldMap = true
}

-- Its own textures behind and around the map (sizes before the map scale).
local MAP_TEXTURES = {
    { path = "minimap-mask-opaque", size = 280, point = { "CENTER" }, layer = "BACKGROUND", level = -7, color = { 0, 0, 0, .75 } },
    { path = "minimap-border", size = 340, point = { "CENTER", -1, 0 }, layer = "BORDER", level = 1, color = { Colors.ui[1], Colors.ui[2], Colors.ui[3] } },
    { path = "shade-circle", size = 280, point = { "CENTER", -1, 0 }, layer = "BORDER", level = 1, color = { Colors.ui[1], Colors.ui[2], Colors.ui[3] } }
}

-- The group finder eye is a button on the minimap's border, sized and
-- offset exactly like the mail button, in the top corner on the screen-edge
-- side: top right while the minimap is on the right half of the screen (the
-- default), mirrored to top left once it's been moved to the left half.
-- The mail button takes the opposite top corner, so the two never overlap.
local EYE_BUTTON_SIZE = 48 -- same as the mail and MBB buttons
local PlaceGroupFinderEye = function()
    local minimapX = Minimap:GetCenter()
    local screenX = UIParent:GetCenter()

    MiniMapLFGFrame:ClearAllPoints()
    if (minimapX and screenX and minimapX < screenX) then
        MiniMapLFGFrame:SetPoint("TOPLEFT", Minimap, -4, 2)
    else
        MiniMapLFGFrame:SetPoint("TOPRIGHT", Minimap, 4, 2)
    end
end

-- A texture on `parent` in the Diabolic look's orange eye.
local CreateEye = function(parent, size)
    local eye = parent:CreateTexture()
    eye:SetSize(size, size)
    eye:SetPoint("CENTER", 0, 0)
    eye:SetTexture(GetMedia("group-finder-eye-orange"))
    eye:SetDrawLayer("BORDER", 2)
    eye:SetVertexColor(.90, .95, 1)
    return eye
end

-- Element Callbacks
--------------------------------------------
local Minimap_OnMouseWheel = function(self, delta)
    if (delta > 0) then
        MinimapZoomIn:Click()
    elseif (delta < 0) then
        MinimapZoomOut:Click()
    end
end

local Minimap_OnMouseUp = function(self, button)
    if (button == "RightButton") then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor")
    else
        Minimap_OnClick(self)
    end
end

local Mail_OnEnter = function(self)
    GameTooltip_SetDefaultAnchor(GameTooltip, self)

    -- Add unread mail notifier.
    local sender1, sender2, sender3 = GetLatestThreeSenders()
    if (sender1 or sender2 or sender3) then
        GameTooltip:AddLine(L_HAVE_MAIL_FROM, unpack(Colors.highlight))
        if (sender1) then
            GameTooltip:AddLine(sender1, unpack(Colors.green))
        end
        if (sender2) then
            GameTooltip:AddLine(sender2, unpack(Colors.green))
        end
        if (sender3) then
            GameTooltip:AddLine(sender3, unpack(Colors.green))
        end
    else
        GameTooltip:AddLine(L_HAVE_MAIL, unpack(Colors.highlight))
    end

    GameTooltip:Show()
end

local Mail_OnLeave = function(self)
    GameTooltip:Hide()
end

-- Element API
--------------------------------------------
MinimapMod.UpdateCompass = function(self)
    local compass = self.compass
    if (self.rotateMinimap) then
        local playerFacing = GetPlayerFacing()
        if (not playerFacing) then
            compass:SetAlpha(0)
            return
        end
        compass:SetAlpha(1)
        local radius = compass:GetWidth() / 2
        local angle = -playerFacing
        compass.north:SetPoint("CENTER", radius * math_cos(angle + half_pi), radius * math_sin(angle + half_pi))
    else
        compass:SetAlpha(0)
    end
end

MinimapMod.UpdateClock = function(self)
	if (ns.db.global.minimap.useServerTime) then
		self.time:SetFormattedText("%02d:%02d", GetServerTime())
	else
		self.time:SetFormattedText("%02d:%02d", GetLocalTime())
	end
end

MinimapMod.UpdateMail = function(self)
    local mail = self.mail
    if (HasNewMail()) then
        mail:Show()
        mail.frame:Show()
    else
        mail:Hide()
        mail.frame:Hide()
    end
end

MinimapMod.UpdateTimers = function(self)
  self.rotateMinimap = GetCVarBool("rotateMinimap")

  if (self.rotateMinimap) then
      if (not self.compassTimer) then
          self.compassTimer = self:ScheduleRepeatingTimer("UpdateCompass", 1 / 60)
      end
  elseif (self.compassTimer) then
      self:CancelTimer(self.compassTimer)
      self.compassTimer = nil
  end
  self:UpdateCompass()
  if (not self.clockTimer) then
    self.clockTimer = self:ScheduleRepeatingTimer("UpdateClock", 1)
    self:UpdateClock()
  end
end

-- Addon Styling & Initialization
--------------------------------------------
MinimapMod.InitializeMBB = function(self)
    local button = CreateFrame("Frame", nil, Minimap)
    button:SetFrameLevel(button:GetFrameLevel() + 10)

    button:SetSize(48, 48)
    button:SetFrameStrata("LOW") -- MEDIUM collides with Immersion

    self.mbbButton = button
    self:UpdateMBBButtonPosition()

    local frame = _G.MBB_MinimapButtonFrame
    frame:SetParent(button)
    frame:RegisterForDrag()
    frame:SetSize(48, 48)
    frame:ClearAllPoints()
    frame:SetFrameStrata("LOW") -- MEDIUM collides with Immersion
    frame:SetPoint("CENTER", 0, 0)
    frame:SetHighlightTexture("")
    frame:DisableDrawLayer("OVERLAY")

    frame.ClearAllPoints = noop
    frame.SetPoint = noop
    frame.SetAllPoints = noop

    local icon = _G.MBB_MinimapButtonFrame_Texture
    icon:ClearAllPoints()
    icon:SetPoint("CENTER", 0, 0)
    icon:SetSize(48, 48)
    icon:SetTexture(GetMedia("button-toggle-plus"))
    icon:SetTexCoord(0, 1, 0, 1)
    icon:SetAlpha(.85)

    local down, over
    local setalpha = function()
        if (down and over) then
            icon:SetAlpha(1)
        elseif (down or over) then
            icon:SetAlpha(.95)
        else
            icon:SetAlpha(.85)
        end
    end

    frame:SetScript("OnMouseDown", function(self)
        down = true
        setalpha()
    end)

    frame:SetScript("OnMouseUp", function(self)
        down = false
        setalpha()
    end)

    frame:SetScript("OnEnter", function(self)
        MBB_ShowTimeout = -1
        over = true
        setalpha()

        GameTooltip_SetDefaultAnchor(GameTooltip, self)
        GameTooltip:AddLine("MinimapButtonBag v" .. MBB_Version)
        GameTooltip:AddLine(MBB_TOOLTIP1, 0, 1, 0, true)
        GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function(self)
        MBB_ShowTimeout = 0
        over = false
        setalpha()

        GameTooltip:Hide()
    end)
end

-- Aligns the zone name's outer edge with the minimap's outer edge -
-- right edges flush when the minimap sits on the right half of the
-- screen (the default), mirrored to the left edges when it's been
-- moved to the left half - so the label never runs past the minimap
-- towards the nearest side of the screen.
MinimapMod.UpdateZoneTextPosition = function(self)
    local zoneName = self.zoneName
    local minimapX = Minimap:GetCenter()
    local screenX = UIParent:GetCenter()

    zoneName:ClearAllPoints()
    if (minimapX and screenX and minimapX < screenX) then
        zoneName:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 25)
        zoneName:SetJustifyH("LEFT")
    else
        zoneName:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 25)
        zoneName:SetJustifyH("RIGHT")
    end
end

-- Keeps the MBB button on the outer side of the minimap - bottom-left
-- when the minimap sits on the right half of the screen (the default),
-- mirrored to bottom-right when it's been moved to the left half.
MinimapMod.UpdateMBBButtonPosition = function(self)
    local button = self.mbbButton
    if (not button) then return end

    local minimapX = Minimap:GetCenter()
    local screenX = UIParent:GetCenter()

    button:ClearAllPoints()
    if (minimapX and screenX and minimapX < screenX) then
        button:SetPoint("BOTTOMRIGHT", Minimap, 4, -2)
    else
        button:SetPoint("BOTTOMLEFT", Minimap, -4, -2)
    end
end

-- Same outer-side alignment as the MBB button, mirrored to the top.
MinimapMod.UpdateMailButtonPosition = function(self)
    local button = self.mail.frame
    local minimapX = Minimap:GetCenter()
    local screenX = UIParent:GetCenter()

    button:ClearAllPoints()
    if (minimapX and screenX and minimapX < screenX) then
        button:SetPoint("TOPRIGHT", Minimap, 4, 2)
    else
        button:SetPoint("TOPLEFT", Minimap, -4, 2)
    end
end

MinimapMod.InitializeAddon = function(self, addon)
    if (not IsAddOnEnabled(addon)) then
        return
    end
    if (not IsAddOnLoaded(addon)) then
        LoadAddOn(addon)
    end
    self["Initialize" .. addon](self)
end

-- The Diabolic look: hides the Blizzard pieces it replaces, keeps the
-- others under their usual parent, and adds its own backdrop, border and
-- shade, and its own dungeon finder eye and battleground queue button.
MinimapMod.ApplyTheme = function(self)
    for element, object in next, Objects do
        object:SetParent(HIDDEN[element] and UIHider or ObjectOwners[element])
    end

    for _, texture in next, MAP_TEXTURES do
        local object = Minimap:CreateTexture()
        object:SetSize(texture.size / mapScale, texture.size / mapScale)
        object:SetPoint(unpack(texture.point))
        object:SetTexture(GetMedia(texture.path))
        object:SetDrawLayer(texture.layer, texture.level)
        object:SetVertexColor(unpack(texture.color))
    end

    -- Dungeon finder eye: a border button like the mail button, a little
    -- larger art than the mail icon
    CreateEye(MiniMapLFGFrame, 40)
    MiniMapLFGFrame:SetParent(Minimap)
    MiniMapLFGFrame:SetFrameLevel(100)
    MiniMapLFGFrame:SetSize(EYE_BUTTON_SIZE, EYE_BUTTON_SIZE)
    MiniMapLFGFrame:SetScale(1) -- same scale as the mail button
    PlaceGroupFinderEye()
    MiniMapLFGFrame:SetHitRectInsets(0, 0, 0, 0)
    -- Blizzard's own hover glow, desaturated to a neutral white so
    -- it doesn't clash with the orange eye.
    local highlight = MiniMapLFGFrame:GetHighlightTexture()
    if (highlight) then
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

-- Minimap Widget Settings
--------------------------------------------
-- Create our custom elements
MinimapMod.CreateCustomElements = function(self)
    local db = ns.Config.Minimap

    local frame = CreateFrame("Frame", nil, Minimap)
    frame:SetFrameLevel(Minimap:GetFrameLevel())
    frame:SetAllPoints(Minimap)

    self.widgetFrame = frame

    -- Compass
    local compass = CreateFrame("Frame", nil, frame)
    compass:SetFrameLevel(Minimap:GetFrameLevel() + 5)
    compass:SetPoint("TOPLEFT", db.CompassInset, -db.CompassInset)
    compass:SetPoint("BOTTOMRIGHT", -db.CompassInset, db.CompassInset)

    local north = compass:CreateFontString(nil, "ARTWORK", nil, 1)
    north:SetFontObject(db.CompassFont)
    north:SetTextColor(unpack(db.CompassColor))
    north:SetText(db.CompassNorthTag)
    compass.north = north

    self.compass = compass

    -- Zone
    local zoneName = Minimap:CreateFontString()
    zoneName:SetDrawLayer("OVERLAY", 1)
    zoneName:SetFontObject(GetFont(16,true))
    zoneName:SetAlpha(.85)
    self.zoneName = zoneName
    self.zoneTargetAlpha = .85 -- the "resting" alpha FadeZoneText fades in towards
    self:UpdateZoneTextPosition()

    -- Time
    local timeFrame = CreateFrame("Button", nil, Minimap)
    timeFrame:SetScript("OnEnter", Time_OnEnter)
    timeFrame:SetScript("OnLeave", Time_OnLeave)
    timeFrame:SetScript("OnClick", Time_OnClick)
    timeFrame:RegisterForClicks("AnyUp")

    local time = timeFrame:CreateFontString()
    time:SetDrawLayer("OVERLAY", 1)
    time:SetJustifyH("CENTER")
    time:SetJustifyV("TOP")
    time:SetFontObject(GetFont(14,true))
    time:SetTextColor(unpack(Colors.offwhite))
    time:SetAlpha(.85)
    time:SetPoint("TOP", Minimap, "BOTTOM", 0, 20)
    timeFrame:SetAllPoints(time)
    self.time = time

    -- Mail
    -- Styled the same simple way as the MBB "+" button: a single icon
    -- texture filling a plain frame, parented straight to the minimap.
    -- button-mail.tga already has the mail icon baked into the button art.
    local mailFrame = CreateFrame("Frame", nil, Minimap)
    mailFrame:SetFrameLevel(mailFrame:GetFrameLevel() + 10)
    mailFrame:SetFrameStrata("LOW")
    mailFrame:SetSize(unpack(db.MailSize))

    local mailButton = CreateFrame("Button", nil, mailFrame)
    mailButton:SetAllPoints(mailFrame)
    mailButton:SetScript("OnEnter", Mail_OnEnter)
    mailButton:SetScript("OnLeave", Mail_OnLeave)

    local mail = mailFrame:CreateTexture(nil, "ARTWORK")
    mail:SetAllPoints(mailFrame)
    mail:SetTexture(GetMedia("button-mail"))
    mail:SetTexCoord(0, 1, 0, 1)
    mail:SetAlpha(.85)

    mail.frame = mailFrame
    self.mail = mail
    self:UpdateMailButtonPosition()
end

MinimapMod.PostUpdatePositionAndScale = function(self)
    local scale = ns.API.GetEffectiveScale() / self:GetBaseScale()
    self.widgetFrame:SetScale(scale)
    MiniMapBattlefieldFrame:SetScale(scale)
    -- The eye is a border button like the mail button,
    -- so it keeps the minimap's own scale.
    MiniMapLFGFrame:SetScale(1)
end

-- Applies the base map scale together with the user's
-- own edit mode size adjustment, then updates dependent elements.
-- In combat it waits for the end of it (see OnEnable).
MinimapMod.UpdateSize = function(self)
    if (InCombatLockdown()) then
        self.updateneeded = true
        return
    end

    self.updateneeded = nil

    self.frame:SetScale(self:GetBaseScale() * self:GetUserScale())
    self:PostUpdatePositionAndScale()
end

-- Steps the zone text through a fade-out/fade-in when the zone changes:
-- alpha ramps down to 0, the (already-computed) new text/color is applied
-- right at the bottom, then alpha ramps back up to its resting value and
-- stays there - the label is always visible except for this brief
-- transition. Durations are user-configurable (see the Minimap options
-- menu). ScheduleRepeatingTimer only accepts a method name (see
-- UpdateCompass/UpdateClock above), not an inline closure, so this is its
-- own method.
MinimapMod.FadeZoneText = function(self)
  local zoneName = self.zoneName
  local db = ns.db.global.minimap
  local elapsed = GetTime() - self.zoneFadeStart

  if (self.zoneFadePhase == "out") then
    local progress = elapsed / db.zoneFadeDuration
    if (progress >= 1) then
      local pending = self.zonePendingZone
      zoneName:SetText(pending.text)
      zoneName:SetTextColor(pending.r, pending.g, pending.b, self.zoneTargetAlpha)
      zoneName:SetAlpha(0)
      self.zonePendingZone = nil
      self.zoneFadePhase = "in"
      self.zoneFadeStart = GetTime()
    else
      zoneName:SetAlpha(self.zoneTargetAlpha * (1 - progress))
    end
  else -- "in"
    local progress = elapsed / db.zoneFadeDuration
    if (progress >= 1) then
      zoneName:SetAlpha(self.zoneTargetAlpha)
      self:CancelTimer(self.zoneFadeTimer)
      self.zoneFadeTimer = nil
      self.zoneFadePhase = nil
    else
      zoneName:SetAlpha(self.zoneTargetAlpha * progress)
    end
  end
end

MinimapMod.UpdateZone = function(self)
  local zoneName = self.zoneName
  local a = self.zoneTargetAlpha -- needed to preserve alpha after text color changes
  local minimapZoneName = GetMinimapZoneText()
  local color = Colors.zone[GetZonePVPInfo() or ""] or Colors.normal
  local r, g, b = color[1], color[2], color[3]

  -- Fade the text out then in whenever the zone actually changes (and the
  -- option's enabled), rather than on every call to this (also triggered
  -- by unrelated PvP-status updates) - the new text/color only gets
  -- applied once the fade-out reaches 0, by FadeZoneText itself.
  if (minimapZoneName ~= self.lastZoneName) and ns.db.global.minimap.zoneFadeEnabled then
    self.lastZoneName = minimapZoneName
    self.zonePendingZone = { text = minimapZoneName, r = r, g = g, b = b }
    self.zoneFadePhase = "out"
    self.zoneFadeStart = GetTime()
    if (not self.zoneFadeTimer) then
      self.zoneFadeTimer = self:ScheduleRepeatingTimer("FadeZoneText", 1/30)
    end
  else
    self.lastZoneName = minimapZoneName
    zoneName:SetTextColor(r, g, b, a)
    zoneName:SetText(minimapZoneName)
  end
end

-- Everything placed on the minimap's outer side follows it around.
MinimapMod.UpdateOuterElements = function(self)
    self:UpdateMBBButtonPosition()
    self:UpdateMailButtonPosition()
    self:UpdateZoneTextPosition()
    PlaceGroupFinderEye()
end

MinimapMod.UpdatePosition = function(self)
    local db = ns.Config.Minimap
    local stored = ns.db.global.minimap.storedPosition

    Minimap:ClearAllPoints()
    if (stored) then
        Minimap:SetPoint(stored.point, UIParent, stored.point, stored.x, stored.y)
    else
        Minimap:SetPoint(unpack(db.Position))
    end
    Minimap:SetMovable(true)
    self:UpdateOuterElements()
end

-- Stores the minimap's current position, relative to UIParent,
-- so it can be restored on the next login.
MinimapMod.SavePosition = function(self)
    local point, x, y = ns.API.GetPosition(Minimap)
    ns.db.global.minimap.storedPosition = { point = point, x = x, y = y }
    self:UpdateOuterElements()
end

MinimapMod.InitializeObjectTables = function(self)
    Objects.BorderTop = MinimapBorderTop
    Objects.BorderClassic = MinimapBorder
    Objects.Calendar = GameTimeFrame
    Objects.Clock = TimeManagerClockButton
    Objects.Compass = MinimapCompassTexture
    Objects.Difficulty = MiniMapInstanceDifficulty
    Objects.Eye = MiniMapLFGFrame
    Objects.EyeClassicPvP = MiniMapBattlefieldFrame
    Objects.Mail = MiniMapMailFrame
    Objects.Tracking = MiniMapTracking
    Objects.Zone = MinimapZoneTextButton
    Objects.ZoomIn = MinimapZoomIn
    Objects.ZoomOut = MinimapZoomOut
    Objects.WorldMap = MiniMapWorldMapButton

    ObjectOwners.BorderTop = MinimapCluster
    ObjectOwners.BorderClassic = MinimapBackdrop
    ObjectOwners.Calendar = MinimapCluster
    ObjectOwners.Clock = MinimapCluster
    ObjectOwners.Compass = MinimapBackdrop
    ObjectOwners.Difficulty = MinimapCluster
    ObjectOwners.Eye = MinimapBackdrop
    ObjectOwners.EyeClassicPvP = Minimap
    ObjectOwners.Mail = Minimap
    ObjectOwners.Tracking = MinimapCluster
    ObjectOwners.Zone = MinimapCluster
    ObjectOwners.ZoomIn = Minimap
    ObjectOwners.ZoomOut = Minimap
    ObjectOwners.WorldMap = MinimapBackdrop
end

-- Edit Mode
-- Lets the user freely move and resize the minimap.
-- The result is saved and restored on future logins.
-- Turned on and off by DiabolicUI's Unlock Frames (modules/menu/menu.lua),
-- along with the other frames that can be moved.
--------------------------------------------
local editModeActive = false

-- Applies a live cursor-drag delta to the user scale.
local ApplyResizeDelta = function(self)
    local db = ns.Config.Minimap
    local uiScale = UIParent:GetEffectiveScale()
    local x, y = GetCursorPosition()
    local delta = ((x - self.startX) + (self.startY - y)) / 2 / uiScale

    local newScale = self.startScale + delta / 200
    if (newScale < db.MinUserScale) then
        newScale = db.MinUserScale
    elseif (newScale > db.MaxUserScale) then
        newScale = db.MaxUserScale
    end

    ns.db.global.minimap.userScale = newScale
    MinimapMod:UpdateSize()
end

-- Left-drag anywhere on the border overlay moves the minimap,
-- right-drag resizes it - covering the decorative border ring,
-- which is bigger than the minimap's own (circular) hit area.
local EditOverlay_OnDragStart = function(self, button)
    if (button == "RightButton") then
        self.resizing = true
        self.startX, self.startY = GetCursorPosition()
        self.startScale = MinimapMod:GetUserScale()
    else
        self.moving = true
        Minimap:StartMoving()
    end
end

local EditOverlay_OnDragStop = function(self)
    if (self.resizing) then
        self.resizing = false
    elseif (self.moving) then
        self.moving = false
        Minimap:StopMovingOrSizing()
        MinimapMod:SavePosition()
    end
end

local EditOverlay_OnUpdate = function(self)
    if (not self.resizing) then return end
    ApplyResizeDelta(self)
end

-- Lazily creates the widgets only needed while in edit mode.
MinimapMod.CreateEditModeWidgets = function(self)
    if (self.editHighlight) then return end

    -- Highlight border shown around the minimap while editing.
    -- *Outset a bit to also cover the decorative border ring,
    --  which extends past the minimap's own (circular) edges,
    --  and doubles as the click target for border-drag resizing.
    local highlight = CreateFrame("Frame", nil, Minimap)
    highlight:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -19, 19)
    highlight:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 19, -19)
    highlight:SetFrameLevel(Minimap:GetFrameLevel() + 20)
    highlight:SetBackdrop({ edgeFile = GetMedia("border-tooltip"), edgeSize = 16 })
    highlight:SetBackdropBorderColor(Colors.normal[1], Colors.normal[2], Colors.normal[3])
    highlight:EnableMouse(true)
    highlight:RegisterForDrag("LeftButton", "RightButton")
    highlight:SetScript("OnDragStart", EditOverlay_OnDragStart)
    highlight:SetScript("OnDragStop", EditOverlay_OnDragStop)
    highlight:SetScript("OnUpdate", EditOverlay_OnUpdate)
    highlight:Hide()
    self.editHighlight = highlight
end

MinimapMod.IsEditModeActive = function(self)
    return editModeActive
end

MinimapMod.EnterEditMode = function(self)
    if (InCombatLockdown()) or (editModeActive) then return end

    editModeActive = true

    self:CreateEditModeWidgets()

    -- The border overlay sits above the minimap and is bigger,
    -- so it intercepts all clicks in the area while shown - the
    -- minimap's own click handling (world map, tracking dropdown)
    -- never sees them, and doesn't need to be touched.
    Minimap:SetMovable(true)

    self.editHighlight:Show()
end

MinimapMod.ExitEditMode = function(self)
    if (not editModeActive) then return end

    editModeActive = false

    -- In case edit mode is left mid-drag.
    Minimap:StopMovingOrSizing()

    if (self.editHighlight) then
        self.editHighlight.moving = false
        self.editHighlight.resizing = false
        self.editHighlight:Hide()
    end

    self:SavePosition()
end

-- Blizzard_TimeManager creates its saved stopwatch settings table when it
-- loads, and writes to it on logout and /reload. Loaded this early on 3.3.5,
-- a late VARIABLES_LOADED can reset that table to nil afterwards, and the
-- stopwatch then errors ("attempt to index global 'BlizzardStopwatchOptions'").
-- Recreate it the same way Blizzard's own code does.
local EnsureStopwatchOptions = function()
    if (not _G.BlizzardStopwatchOptions) then
        _G.BlizzardStopwatchOptions = {}
    end
end

MinimapMod.OnEnable = function(self)
    LoadAddOn("Blizzard_TimeManager")
    EnsureStopwatchOptions()
    self:InitializeObjectTables()

    MinimapCluster:EnableMouse(false)
    MinimapCluster:SetFrameLevel(1)
    Minimap:RegisterEvent("PLAYER_ENTERING_WORLD")
    Minimap:RegisterEvent("PLAYER_REGEN_ENABLED")
    Minimap:RegisterEvent("VARIABLES_LOADED")
    Minimap:RegisterEvent("CVAR_UPDATE")
    Minimap:RegisterEvent("UPDATE_PENDING_MAIL")
    Minimap:RegisterEvent("ZONE_CHANGED")
    Minimap:RegisterEvent("ZONE_CHANGED_INDOORS")
    Minimap:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    Minimap:SetScript("OnEvent", function(frame, event, ...)
        if (event == "PLAYER_ENTERING_WORLD") then
          EnsureStopwatchOptions()
          self:UpdateZone()
          self:UpdateMail()
          self:UpdateTimers()
        elseif (event == "PLAYER_REGEN_ENABLED") then
          if (self.updateneeded) then
            self:UpdateSize() -- a resize asked for in combat
          end
        elseif (event == "VARIABLES_LOADED") then
          EnsureStopwatchOptions()
          self:UpdateTimers()
          self:UpdateSize()
          self:UpdatePosition()
        elseif (event == "UPDATE_PENDING_MAIL") then
            self:UpdateMail()
        elseif (event == "CVAR_UPDATE") then
            self:UpdateTimers()
        else -- the zone changed
            self:UpdateZone()
        end
    end)
    self.frame = Minimap
    self.frame:SetSize(280 / mapScale, 280 / mapScale)
    self.frame:SetMovable(true)
    self.frame:EnableMouseWheel(true)
    self.frame:SetScript("OnMouseWheel", Minimap_OnMouseWheel)
    self.frame:SetScript("OnMouseUp", Minimap_OnMouseUp)

    self:CreateCustomElements()
    self:ApplyTheme()
    self:UpdateMail()
    self:UpdateTimers()
    self:UpdatePosition()
    self:UpdateSize()
    self:InitializeAddon("MBB")
end
