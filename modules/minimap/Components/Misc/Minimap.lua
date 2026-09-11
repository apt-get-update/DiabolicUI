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
local MinimapMod = ns:NewModule("Minimap", "LibMoreEvents-1.0", "AceHook-3.0", "AceTimer-3.0",
    "AceConsole-3.0")

-- Lua API
local ipairs = ipairs
local math_cos = math.cos
local half_pi = math.pi / 2
local math_sin = math.sin
local next = next
local pairs = pairs
local string_format = string.format
local string_lower = string.lower
local table_insert = table.insert
local type = type
local unpack = unpack

-- Addon API
local Colors = ns.Colors
local GetMedia = ns.API.GetMedia
local IsAddOnEnabled = ns.API.IsAddOnEnabled
local UIHider = ns.Hider
local noop = ns.Noop
local GetTime = ns.API.GetTime
local GetFont = ns.API.GetFont
local GetLocalTime = ns.API.GetLocalTime
local GetServerTime = ns.API.GetServerTime

-- WoW Strings
local L_FPS = FPS_ABBR -- "fps"
local L_MS = MILLISECONDS_ABBR -- "ms"
local L_RESTING = TUTORIAL_TITLE30 -- "Resting"
local L_NEW = NEW -- "New"
local L_HAVE_MAIL = HAVE_MAIL -- "You have unread mail"
local L_HAVE_MAIL_FROM = HAVE_MAIL_FROM -- "Unread mail from:"

local getTimeStrings = function(h, m, suffix, useHalfClock, abbreviateSuffix)
	if (useHalfClock) then
		return "%.0f:%02.0f |cff888888%s|r", h, m, abbreviateSuffix and string_match(suffix, "^.") or suffix
	else
		return "%02.0f:%02.0f", h, m
	end
end

local Time_UpdateTooltip = function(self)
	if (GameTooltip:IsForbidden()) then return end

	-- local useHalfClock = ns.db.global.minimap.useHalfClock -- the outlandish 12 hour clock the colonials seem to favor so much
	local useHalfClock = false
	local lh, lm, lsuffix = GetLocalTime(useHalfClock) -- local computer time
	local sh, sm, ssuffix = GetServerTime(useHalfClock) -- realm time
	local r, g, b = unpack(Colors.normal)
	local rh, gh, bh = unpack(Colors.highlight)

	GameTooltip:SetOwner(self:GetParent(), "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -40, 0)
	GameTooltip:AddLine(TIMEMANAGER_TOOLTIP_TITLE, unpack(Colors.title))
	GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_LOCALTIME, string_format(getTimeStrings(lh, lm, lsuffix, useHalfClock)), rh, gh, bh, r, g, b)
	GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_REALMTIME, string_format(getTimeStrings(sh, sm, ssuffix, useHalfClock)), rh, gh, bh, r, g, b)
	GameTooltip:AddLine("<"..GAMETIME_TOOLTIP_TOGGLE_CALENDAR..">", unpack(Colors.quest.green))
	GameTooltip:Show()
end

local Time_OnEnter = function(self)
	self.UpdateTooltip = Time_UpdateTooltip
	self:UpdateTooltip()
end

local Time_OnLeave = function(self)
	self.UpdateTooltip = nil
	if (GameTooltip:IsForbidden()) then return end
	GameTooltip:Hide()
end

local Time_OnClick = function(self, mouseButton)
	if (ToggleCalendar) and (not InCombatLockdown()) then
		ToggleCalendar()
	end
end

-- local mapScale = 198 / 140
local mapScale = 1.614

local defaults = {
    enabled = true,
    theme = "Diabolic"
}

MinimapMod.GetScale = function(self)
    return mapScale
end

-- Returns the base scale of the minimap widget,
-- before the user's own edit mode resizing is factored in.
MinimapMod.GetBaseScale = function(self)
    return mapScale * ns.API.GetEffectiveScale()
end

-- Returns the user's chosen size multiplier, as set in edit mode.
MinimapMod.GetUserScale = function(self)
    return (ns.db and ns.db.global.minimap.userScale) or 1
end

local DEFAULT_THEME = "Blizzard"
local CURRENT_THEME = DEFAULT_THEME

local Elements = {}
local Objects = {}
local ObjectOwners = {}

-- Snippets to be run upon object toggling.
----------------------------------------------------
local ObjectSnippets = {
    -- Blizzard Objects
    ------------------------------------------
    Crafting = {
        Enable = function(object)
            object:OnLoad()
            object:SetScript("OnEvent", object.OnEvent)
        end,
        Disable = function(object)
            object:SetScript("OnEvent", nil)
        end,
        Update = function(object)
            object:OnEvent("CRAFTINGORDERS_UPDATE_PERSONAL_ORDER_COUNTS")
        end
    },
    Eye = {
        Enable = function(object)
            object:SetFrameLevel(object:GetParent():GetFrameLevel() + 2)
        end,
        Disable = function() end,
        Update = function() end
    },
    EyeClassicPvP = {
        Enable = function(object)
            MiniMapBattlefieldIcon:Show()
            MiniMapBattlefieldBorder:Show()
            BattlegroundShine:Show()
            if (BattlefieldIconText) then BattlefieldIconText:Show() end
        end,
        Disable = function(object)
            MiniMapBattlefieldIcon:Hide()
            MiniMapBattlefieldBorder:Hide()
            BattlegroundShine:Hide()
            if (BattlefieldIconText) then BattlefieldIconText:Hide() end
        end,
        Update = function(object)
            if (PVPBattleground_UpdateQueueStatus) then PVPBattleground_UpdateQueueStatus() end
            BattlefieldFrame_UpdateStatus(false)
        end
    },
    -- AzeriteUI Objects
    ------------------------------------------
    AzeriteEye = {
        Enable = function(object)
            MiniMapLFGFrame:SetParent(Minimap)
            MiniMapLFGFrame:SetFrameLevel(100)
            MiniMapLFGFrame:ClearAllPoints()
            MiniMapLFGFrame:SetPoint("TOPRIGHT", Minimap, -4, -2)
            MiniMapLFGFrame:SetHitRectInsets(-8, -8, -8, -8)
            MiniMapLFGFrameBorder:Hide()
            MiniMapLFGFrameIcon:Hide()
        end,
        Disable = function(object)
            MiniMapLFGFrame:SetParent(_G[ObjectOwners.Eye])
            MiniMapLFGFrame:SetFrameLevel(MinimapBackdrop:GetFrameLevel() + 2)
            MiniMapLFGFrame:ClearAllPoints()
            MiniMapLFGFrame:SetPoint("TOPLEFT", 25, -100)
            MiniMapLFGFrame:SetHitRectInsets(0, 0, 0, 0)
            MiniMapLFGFrameBorder:Show()
            MiniMapLFGFrameIcon:Show()
        end,
        Update = function(object) end
    },
    AzeriteEyeClassicPvP = {
        Enable = function(object)
            MiniMapBattlefieldFrame:SetFrameStrata("MEDIUM")
            MiniMapBattlefieldFrame:SetFrameLevel(70) -- Minimap's XP button is 60
            MiniMapBattlefieldFrame:ClearAllPoints()
            MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, 4, 2)
            MiniMapBattlefieldFrame:SetHitRectInsets(-8, -8, -8, -8)
            MiniMapBattlefieldIcon:Hide()
            MiniMapBattlefieldBorder:Hide()
            BattlegroundShine:Hide()
            if (BattlefieldIconText) then BattlefieldIconText:Hide() end
        end,
        Disable = function(object)
            MiniMapBattlefieldFrame:SetFrameStrata(Minimap:GetFrameStrata())
            MiniMapBattlefieldFrame:SetFrameLevel(Minimap:GetFrameLevel() + 1)
            MiniMapBattlefieldFrame:ClearAllPoints()
            MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, 13, -13)
            MiniMapBattlefieldFrame:SetHitRectInsets(0, 0, 0, 0)
            MiniMapBattlefieldIcon:Show()
            MiniMapBattlefieldBorder:Show()
            BattlegroundShine:Show()
            if (BattlefieldIconText) then BattlefieldIconText:Show() end
        end,
        Update = function(object)
        end
    }
}

-- Element type of custom elements.
local ElementTypes = {
    Backdrop = "Texture",
    Border = "Texture",
    Shade = "Texture",
    AzeriteEye = "Texture",
    AzeriteEyeClassicPvP = "Texture"
}

-- Mask textures for the supported shapes.
local Shapes = {
    Round = GetMedia("minimap-mask-opaque"),
    RoundTransparent = GetMedia("minimap-mask-transparent")
}

-- Our custom embedded skins.
local Skins = {
    Blizzard = {
        Version = 1,
        Shape = "Round"
    },
    ["Diabolic"] = {
        Version = 1,
        Shape = "RoundTransparent",
        HideElements = {
            Addons = true,        -- retail
            BattleField = false,  -- classic + wrath
            BorderTop = true,
            BorderClassic = true, -- wrath
            Calendar = true,
            Clock = true,
            Compass = true,
            Crafting = true,  -- retail
            Difficulty = true,
            Expansion = true, -- retail
            Eye = false,      -- wrath + retail
            Mail = true,
            Tracking = true,
            ToggleButton = true, -- classic
            Zone = true,
            ZoomIn = true,
            ZoomOut = true,
            WorldMap = true -- wrath
        },
        Elements = {
            Backdrop = {
                Owner = "Minimap",
                DrawLayer = "BACKGROUND",
                DrawLevel = -7,
                Path = GetMedia("minimap-mask-opaque"),
                Size = function() return (280 / mapScale), (280 / mapScale) end,
                Point = { "CENTER" },
                Color = { 0, 0, 0, .75 },
            },
            Border = {
                Owner = "Backdrop",
                DrawLayer = "BORDER",
                DrawLevel = 1,
                Path = GetMedia("minimap-border"),
                Size = function() return (340 / mapScale), (340 / mapScale) end,
                Point = { "CENTER", -1, 0 },
                Color = { Colors.ui[1], Colors.ui[2], Colors.ui[3] },
            },
            Shade = {
                Owner = "Backdrop",
                DrawLayer = "BORDER",
                DrawLevel = 1,
                Path = GetMedia("shade-circle"),
                Size = function() return (280 / mapScale), (280 / mapScale) end,
                Point = { "CENTER", -1, 0 },
                Color = { Colors.ui[1], Colors.ui[2], Colors.ui[3] },
            },
            AzeriteEye = {
                Owner = "Eye",
                DrawLayer = "BORDER",
                DrawLevel = 2,
                Path = GetMedia("group-finder-eye-orange"),
                Size = { 64, 64 },
                Point = { "CENTER", 0, 0 },
                Color = { .90, .95, 1 }
            },
            -- CATA: check
            AzeriteEyeClassicPvP = (ns.IsClassic or ns.IsWrath or ns.IsCata) and {
                Owner = "EyeClassicPvP",
                DrawLayer = "BORDER",
                DrawLevel = 2,
                Path = GetMedia("group-finder-eye-orange"),
                Size = { 64, 64 },
                Point = { "CENTER", 0, 0 },
                Color = { .90, .95, 1 }
            }
        }
    }
}

-- Element Callbacks
--------------------------------------------
local Minimap_OnMouseWheel = function(self, delta)
    if (delta > 0) then
        (Minimap.ZoomIn or MinimapZoomIn):Click()
    elseif (delta < 0) then
        (Minimap.ZoomOut or MinimapZoomOut):Click()
    end
end

local Minimap_OnMouseUp = function(self, button)
    if (button == "RightButton") then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor")
    else
        local func = Minimap.OnClick or Minimap_OnClick
        if (func) then
            func(self)
        end
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
    if (not compass) then
        return
    end
    if (self.rotateMinimap) then
        local radius = self.compassRadius
        if (not radius) then
            local width = compass:GetWidth()
            if (not width) then
                return
            end
            radius = width / 2
        end

        local playerFacing = GetPlayerFacing()
        if (not playerFacing) or (self.supressCompass) then
            compass:SetAlpha(0)
        else
            compass:SetAlpha(1)
        end

        local angle = (self.rotateMinimap and playerFacing) and -playerFacing or 0
        compass.north:SetPoint("CENTER", radius * math_cos(angle + half_pi), radius * math_sin(angle + half_pi))
    else
        compass:SetAlpha(0)
    end
end

MinimapMod.UpdateClock = function(self)
	local time = self.time
  -- local useHalfClock = ns.db.global.minimap.useHalfClock
  local useHalfClock = false
	if (not time) then
		return
	end
	if (ns.db.global.minimap.useServerTime) then
		if (useHalfClock) then
			local h, m, suffix = GetServerTime(true)
			time:SetFormattedText("%.0f:%02d", h, m)
			time.suffix:SetFormattedText(" %s", suffix)
		else
			time:SetFormattedText("%02d:%02d", GetServerTime(false))
			time.suffix:SetText(nil)
		end
	else
		if (useHalfClock) then
			local h, m, suffix = GetLocalTime(true)
			time:SetFormattedText("%.0f:%02d", h, m)
			time.suffix:SetFormattedText(" %s", suffix)
		else
			time:SetFormattedText("%02d:%02d", GetLocalTime(false))
			time.suffix:SetText(nil)
		end
	end
end

MinimapMod.UpdateMail = function(self)
    local mail = self.mail
    if (not mail) then return end
    local hasMail = HasNewMail()
    if (hasMail) then
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
          self:UpdateCompass()
      end
  elseif (self.compassTimer) then
      self:CancelTimer(self.compassTimer)
      self:UpdateCompass()
  end
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

        if (GameTooltip:IsForbidden()) then return end

        GameTooltip_SetDefaultAnchor(GameTooltip, self)
        GameTooltip:AddLine("MinimapButtonBag v" .. MBB_Version)
        GameTooltip:AddLine(MBB_TOOLTIP1, 0, 1, 0, true)
        GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function(self)
        MBB_ShowTimeout = 0
        over = false
        setalpha()

        if (GameTooltip:IsForbidden()) then return end

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
    if (not zoneName) then return end

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
    local button = self.mail and self.mail.frame
    if (not button) then return end

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
    local method = self["Initialize" .. addon]
    if (method) then
        if (not IsAddOnLoaded(addon)) then
            LoadAddOn(addon)
        end
        method(self)
    end
end

-- Module Theme API (really...?)
--------------------------------------------
MinimapMod.RegisterTheme = function(self, name, skin)
    if (Skins[name] or name == DEFAULT_THEME) then return end
    Skins[name] = skin
end

MinimapMod.SetMinimapTheme = function(self, input)
    if (InCombatLockdown()) then return end
    local theme = "diabolic"
    self:SetTheme(theme)
end

MinimapMod.SetTheme = function(self, requestedTheme)
    if (InCombatLockdown()) then return end

    -- Theme names are case sensitive,
    -- but we don't want the input to be.
    local name
    for theme in next, Skins do
        if (string_lower(theme) == string_lower(requestedTheme)) then
            name = theme
            break
        end
    end
    if (not name or not Skins[name] or name == CURRENT_THEME) then return end

    local current, new = Skins[CURRENT_THEME], Skins[name]

    -- Disable unused custom elements.
    if (current.Elements) then
        for element, data in next, current.Elements do
            if (data) and (not new.Elements or not new.Elements[element]) then
                Elements[element]:SetParent(UIHider)
                if (ObjectSnippets[element]) then
                    ObjectSnippets[element].Disable(Objects[element])
                end
            end
        end
    end

    -- Update Blizzard element visibility.
    for element, object in next, Objects do
        if (new.HideElements and new.HideElements[element]) then
            object:SetParent(UIHider)
            if (ObjectSnippets[element]) then
                ObjectSnippets[element].Disable(object)
            end
        else
            object:SetParent(ObjectOwners[element])
            if (ObjectSnippets[element]) then
                ObjectSnippets[element].Enable(object)
                ObjectSnippets[element].Update(object)
            end
        end
    end

    -- Enable new theme's custom elements.
    if (new.Elements) then
        for element, data in next, new.Elements do
            if (data) then
                -- Retrieve the owner of the object
                local owner = data and data.Owner and ObjectOwners[data.Owner] or Minimap

                -- Retrieve the object
                local object, objectParent = Elements[element]

                -- If a custom object does not exist, create it.
                if (not object) then
                    -- Figure out what our custom object should be parented to.
                    objectParent = data and data.Owner and Objects[data.Owner] or Minimap

                    -- Create!
                    if (ElementTypes[element] == "Texture") then
                        object = objectParent:CreateTexture()
                        Elements[element] = object
                    end
                end

                -- Silently ignore non-supported objects.
                if (object) then
                    object:SetParent(objectParent or owner)

                    if (data.Size) then
                        if (type(data.Size) == "function") then
                            object:SetSize(data.Size())
                        else
                            object:SetSize(unpack(data.Size))
                        end
                    else
                        object:SetSize(Minimap:GetSize())
                    end

                    if (data.Point) then
                        object:ClearAllPoints()
                        if (type(data.Point) == "function") then
                            object:SetPoint(data.Point())
                        else
                            object:SetPoint(unpack(data.Point))
                        end
                    end

                    if (ElementTypes[element] == "Texture") then
                        object:SetTexture(data.Path)
                        object:SetDrawLayer(data.DrawLayer or "ARTWORK", data.DrawLevel or 0)
                        if (data.Color) then
                            object:SetVertexColor(unpack(data.Color))
                        else
                            object:SetVertexColor(1, 1, 1, 1)
                        end
                    end

                    -- Run object callbacks.
                    if (ObjectSnippets[element]) then
                        ObjectSnippets[element].Enable(Elements[element])
                        ObjectSnippets[element].Update(Elements[element])
                    end
                end
            end
        end
    end

    CURRENT_THEME = name

    -- Update custom element visibility
    self:UpdateCustomElements()
end

-- Minimap Widget Settings
--------------------------------------------
-- Create our custom elements
-- *This is a temporary and clunky measure,
--  eventually I want this baked into the themes,
--  including the position based visibility.
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

    local timeSuffix = timeFrame:CreateFontString()
    timeSuffix:SetDrawLayer("OVERLAY", 1)
    timeSuffix:SetJustifyH("CENTER")
    timeSuffix:SetJustifyV("TOP")
    timeSuffix:SetFontObject(GetFont(11,true))
    timeSuffix:SetTextColor(unpack(Colors.darkgray))
    timeSuffix:SetAlpha(.75)
    timeSuffix:SetPoint("TOPLEFT", time, "TOPRIGHT", 0, -2)
    time.suffix = timeSuffix

    -- Coordinates
    local coordinates = frame:CreateFontString(nil, "OVERLAY", nil, 1)
    coordinates:SetJustifyH("CENTER")
    coordinates:SetJustifyV("MIDDLE")
    coordinates:SetFontObject(db.CoordinateFont)
    coordinates:SetTextColor(unpack(db.CoordinateColor))
    coordinates:SetPoint(unpack(db.CoordinatePlace))

    self.coordinates = coordinates

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
    mail.base = mailBase
    self.mail = mail
    self:UpdateMailButtonPosition()

    self:UpdateCustomElements()
    self.CreateCustomElements = noop
end

-- Update the visibility of the custom elements
MinimapMod.UpdateCustomElements = function(self)
    if (not self.widgetFrame) then return end
    if (CURRENT_THEME == "Diabolic") then
        self.widgetFrame:Show()
    else
        self.widgetFrame:Hide()
    end
end

MinimapMod.PostUpdatePositionAndScale = function(self)
    local baseScale = self:GetBaseScale()

    self.widgetFrame:SetScale(ns.API.GetEffectiveScale() / baseScale)
    self:UpdateCustomElements()

    if (ns.IsRetail) then
        MinimapCluster.MinimapContainer:SetScale(1)
    end

    -- TODO: Figure out all the elements I should rescale.

    for name in next, {
        MiniMapBattlefieldFrame = true,
        MiniMapLFGFrame = true,
        QueueStatusButton = true
    } do
        local element = _G[name]
        if (element) then
            element:SetScale(ns.API.GetEffectiveScale() / baseScale)
        end
    end
end

-- Applies the base map scale together with the user's
-- own edit mode size adjustment, then updates dependent elements.
MinimapMod.UpdateSize = function(self)
    if (not self.frame) then return end

    if (InCombatLockdown()) then
        self.updateneeded = true
        return
    end

    self.updateneeded = nil

    self.frame:SetScale(self:GetBaseScale() * self:GetUserScale())

    if (self.PostUpdatePositionAndScale) then
        self:PostUpdatePositionAndScale()
    end
end

MinimapMod.UpdateZone = function(self)
  local zoneName = self.zoneName
  if (not zoneName) then
    return
  end
  local a = zoneName:GetAlpha() -- needed to preserve alpha after text color changes
  local minimapZoneName = GetMinimapZoneText()
  local pvpType, isSubZonePvP, factionName = GetZonePVPInfo()
  if (pvpType) then
    local color = Colors.zone[pvpType]
    if (color) then
      zoneName:SetTextColor(color[1], color[2], color[3], a)
    else
      zoneName:SetTextColor(Colors.normal[1], Colors.normal[2], Colors.normal[3], a)
    end
  else
    zoneName:SetTextColor(Colors.normal[1], Colors.normal[2], Colors.normal[3], a)
  end
  zoneName:SetText(minimapZoneName)
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

    self:UpdateMBBButtonPosition()
    self:UpdateMailButtonPosition()
    self:UpdateZoneTextPosition()
end

-- Stores the minimap's current position, relative to UIParent,
-- so it can be restored on the next login.
MinimapMod.SavePosition = function(self)
    local point, x, y = ns.API.GetPosition(Minimap)
    ns.db.global.minimap.storedPosition = { point = point, x = x, y = y }

    self:UpdateMBBButtonPosition()
    self:UpdateMailButtonPosition()
    self:UpdateZoneTextPosition()
end

MinimapMod.UpdateSettings = function(self)
    self:SetTheme(defaults.theme)
    self:UpdateCompass()
    self:UpdateMail()
    self:UpdateTimers()
    self:UpdateCustomElements()
    self:UpdatePosition()
    self:UpdateSize()
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
    ObjectOwners.Expansion = MinimapBackdrop
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
--------------------------------------------
local L_EXIT_EDIT_MODE = "Exit Edit Mode"

local editModeActive = false

local ExitEditModeButton_OnClick = function()
    MinimapMod:ExitEditMode()
end

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

    -- Standalone button to leave edit mode, since the menu
    -- itself is closed while the user is editing.
    local exitButton = CreateFrame("Button", "DiabolicMinimapExitEditModeButton", UIParent, "UIPanelButtonTemplate")
    exitButton:SetFrameStrata("HIGH")
    exitButton:SetSize(160, 24)
    exitButton:SetPoint("TOP", Minimap, "BOTTOM", 0, -16)
    exitButton:SetText(L_EXIT_EDIT_MODE)
    exitButton:SetScript("OnClick", ExitEditModeButton_OnClick)
    exitButton:Hide()
    self.exitEditModeButton = exitButton
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
    self.exitEditModeButton:Show()
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
    if (self.exitEditModeButton) then
        self.exitEditModeButton:Hide()
    end

    self:SavePosition()
end

MinimapMod.OnEnable = function(self)
    LoadAddOn("Blizzard_TimeManager")
    self:InitializeObjectTables()

    MinimapCluster:EnableMouse(false)
    MinimapCluster:SetFrameLevel(1)
    Minimap:RegisterEvent("PLAYER_ENTERING_WORLD")
    Minimap:RegisterEvent("VARIABLES_LOADED")
    Minimap:RegisterEvent("CVAR_UPDATE")
    Minimap:RegisterEvent("UPDATE_PENDING_MAIL")
    Minimap:RegisterEvent("ZONE_CHANGED")
    Minimap:RegisterEvent("ZONE_CHANGED_INDOORS")
    Minimap:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    Minimap:SetScript("OnEvent", function(frame, event, ...)
        if (event == "PLAYER_ENTERING_WORLD") then
          self:UpdateZone()
          self:UpdateMail()
          self:UpdateTimers()
        elseif (event == "VARIABLES_LOADED") then
          self:UpdateTimers()
          self:UpdateSize()
          self:UpdatePosition()
        elseif (event == "UPDATE_PENDING_MAIL") then
            self:UpdateMail()
        elseif (event == "CVAR_UPDATE") then
            self:UpdateTimers()
        elseif (event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA") then
            self:UpdateZone()
        end
    end)
    self.frame = Minimap
    -- self.frame:SetSize(180,180)
    self.frame:SetSize(280 / mapScale, 280 / mapScale)
    self.frame:SetMovable(true)
    self.frame:EnableMouseWheel(true)
    self.frame:SetScript("OnMouseWheel", Minimap_OnMouseWheel)
    self.frame:SetScript("OnMouseUp", Minimap_OnMouseUp)

    self:CreateCustomElements()
    self:UpdateSettings()
    self:RegisterChatCommand("setminimaptheme", "SetMinimapTheme")
    self:InitializeAddon("MBB")
end
