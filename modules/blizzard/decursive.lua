-- Gives Decursive's squares (its micro unit frames) Diablo III's look when
-- it's loaded: an afflicted player's a stained-glass medallion (the
-- quests' medallions of Diablo III's acts), a healthy one's nothing: its
-- glass lit in the affliction's colour (Magic blue,
-- Curse purple, Disease orange, Poison gold), with a little mouse showing
-- the button to click (and its modifier's letter). As you dispel it, a
-- burst in that colour, its glass dark for a moment, then gone.
-- Art only: Decursive's code and its secure clicks are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Decursive", "LOW")

local kit

-- Decursive's statuses (DcrC's): the ones we draw differently
local AFFLICTED_NIR = 512

-- The little mouse: its two buttons over its body, the one to click lit.
local CreateMouse = function(frame, spec)
	local mouse = CreateFrame("Frame", nil, frame)
	mouse:SetSize(unpack(spec.size))
	mouse:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", spec.offset[1], spec.offset[2])
	mouse:SetFrameLevel(frame:GetFrameLevel() + 3)
	local width, height = unpack(spec.size)
	local back = mouse:CreateTexture(nil, "BACKGROUND")
	back:SetTexture(unpack(spec.back_color))
	back:SetAllPoints()
	local half = (width - 3) / 2
	mouse.Left = mouse:CreateTexture(nil, "ARTWORK")
	mouse.Left:SetSize(half, spec.button_height)
	mouse.Left:SetPoint("TOPLEFT", mouse, "TOPLEFT", 1, -1)
	mouse.Right = mouse:CreateTexture(nil, "ARTWORK")
	mouse.Right:SetSize(half, spec.button_height)
	mouse.Right:SetPoint("TOPRIGHT", mouse, "TOPRIGHT", -1, -1)
	local body = mouse:CreateTexture(nil, "ARTWORK")
	body:SetSize(width - 2, height - spec.button_height - 3)
	body:SetPoint("BOTTOM", mouse, "BOTTOM", 0, 1)
	body:SetTexture(unpack(spec.dim_color))
	-- a modifier's letter (C, S, A) left of it
	mouse.Key = mouse:CreateFontString(nil, "OVERLAY")
	mouse.Key:SetFontObject(spec.font)
	mouse.Key:SetTextColor(unpack(spec.lit_color))
	mouse.Key:SetPoint("RIGHT", mouse, "LEFT", -1, 0)
	mouse:Hide()
	return mouse
end

-- The burst as you dispel: Blizzard's star, grown and faded.
local CreateBurst = function(frame, spec)
	local burst = CreateFrame("Frame", nil, frame)
	burst:SetSize(spec.size, spec.size)
	burst:SetPoint("CENTER")
	burst:SetFrameLevel(frame:GetFrameLevel() + 4)
	burst.Star = burst:CreateTexture(nil, "OVERLAY")
	burst.Star:SetTexture(spec.texture)
	burst.Star:SetBlendMode("ADD")
	burst.Star:SetAllPoints()
	local group = burst:CreateAnimationGroup()
	local grow = group:CreateAnimation("Scale")
	grow:SetScale(spec.scale, spec.scale)
	grow:SetDuration(spec.duration)
	local fade = group:CreateAnimation("Alpha")
	fade:SetChange(-1)
	fade:SetDuration(spec.duration)
	group:SetScript("OnFinished", function()
		burst:Hide()
	end)
	burst.Play = group
	burst:Hide()
	return burst
end

-- A medallion's place in the sheet (settings: decursive.medallions).
local SetMedallion = function(texture, cell, size)
	local column, row = unpack(cell)
	texture:SetTexCoord(column * size, (column + 1) * size, row * size, (row + 1) * size)
end

-- A square (once): its medallion, mouse and burst; Decursive's own
-- squares of colour and its class border out of sight.
Module.StyleSquare = function(self, square)
	if square.DiabolicMedallion then
		return
	end
	local spec, frame = self.config, square.Frame
	for i = 1, 4 do
		square["OuterTexture" .. i]:Hide()
	end
	local medallion = frame:CreateTexture(nil, "BORDER") -- (under its timer and raid icon)
	medallion:SetTexture(spec.texture)
	medallion:SetPoint("CENTER")
	-- (its ornaments past the square: its glass as big as the square)
	medallion:SetSize(frame:GetWidth() * spec.medallion_scale, frame:GetHeight() * spec.medallion_scale)
	square.DiabolicMedallion = medallion
	-- its timer small and light in a corner, the glass seen through
	local timer = square.ChronoFontString
	timer:SetFontObject(spec.timer.font)
	timer:ClearAllPoints()
	timer:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", spec.timer.offset[1], spec.timer.offset[2])
	square.DiabolicMouse = CreateMouse(frame, spec.mouse)
	square.DiabolicBurst = CreateBurst(frame, spec.burst)
	-- the glass kept dark a moment after you dispel it, then stone again
	local hold = frame:CreateAnimationGroup()
	local wait = hold:CreateAnimation("Alpha")
	wait:SetChange(0)
	wait:SetDuration(spec.cleansed_time)
	hold:SetScript("OnFinished", function()
		square.DiabolicCleansed = nil
		self:UpdateSquare(square)
	end)
	square.DiabolicHold = hold
	self:UpdateSquare(square)
end

-- What a square shows, after Decursive set its state: the lit glass while
-- afflicted (dimmer out of range) and the mouse button to click; the dark
-- glass just after your dispel; nothing while all is well.
Module.UpdateSquare = function(self, square)
	local medallion = square.DiabolicMedallion
	if not medallion then
		return
	end
	local spec = self.config
	local cells, size = spec.medallions, spec.cell
	square.Texture:Hide() -- (Decursive's square of colour)
	square.ChronoFontString:SetTextColor(unpack(spec.timer.color)) -- (Decursive's red again on a full update)
	local debuff = square.IsDebuffed and square.Debuffs and square.Debuffs[1]
	local type = debuff and _G.DcrC and _G.DcrC.TypeNames and _G.DcrC.TypeNames[debuff.Type]
	if debuff and cells[type] then
		SetMedallion(medallion, cells[type].lit, size)
		medallion:SetAlpha((square.UnitStatus == AFFLICTED_NIR) and spec.out_of_range_alpha or 1)
		medallion:Show()
		square.DiabolicType = type
		self:ShowMouse(square)
		return
	end
	square.DiabolicMouse:Hide()
	if square.DiabolicCleansed and cells[square.DiabolicCleansed] then
		SetMedallion(medallion, cells[square.DiabolicCleansed].dark, size)
		medallion:SetAlpha(1)
		medallion:Show()
	else
		medallion:Hide() -- (nothing to do there: nothing shown)
	end
end

-- The mouse button (and modifier) Decursive set for the affliction's spell.
Module.ShowMouse = function(self, square)
	local mouse, spec = square.DiabolicMouse, self.config.mouse
	local D = _G.Dcr
	local buttons = D and D.db and D.db.global and D.db.global.AvailableButtons
	local click = buttons and square.Debuff1Prio and buttons[square.Debuff1Prio]
	if not click then
		mouse:Hide()
		return
	end
	local button = tonumber(click:match("(%d)$"))
	local key = click:match("^(%a+)%-")
	mouse.Left:SetTexture(unpack((button == 1) and spec.lit_color or spec.dim_color))
	mouse.Right:SetTexture(unpack((button == 2) and spec.lit_color or spec.dim_color))
	mouse.Key:SetText(key and key:sub(1, 1):upper() or "")
	mouse:Show()
end

-- A dispel of yours: the burst on that player's square, in the colour of
-- what it showed, its glass dark a moment.
Module.OnCombatLog = function(self, event, _, subEvent, sourceGUID, _, _, destGUID)
	if (subEvent ~= "SPELL_DISPEL") or (sourceGUID ~= UnitGUID("player")) then
		return
	end
	local squares = _G.Dcr and _G.Dcr.MicroUnitF and _G.Dcr.MicroUnitF.ExistingPerUNIT
	for unit, square in pairs(squares or {}) do
		if square.DiabolicBurst and (UnitGUID(unit) == destGUID) then
			local burst = square.DiabolicBurst
			local color = self.config.colors[square.DiabolicType] or self.config.colors.none
			burst.Star:SetVertexColor(unpack(color))
			burst:Show()
			burst.Play:Stop()
			burst.Play:Play()
			square.DiabolicCleansed = square.DiabolicType
			square.DiabolicHold:Stop()
			square.DiabolicHold:Play()
			self:UpdateSquare(square)
			return
		end
	end
end

Module.StyleDecursive = function(self)
	local D = _G.Dcr
	local squares = D and D.MicroUnitF
	if not (squares and squares.prototype) then
		return
	end
	hooksecurefunc(squares.prototype, "init", function(square)
		self:StyleSquare(square)
	end)
	hooksecurefunc(squares.prototype, "SetColor", function(square)
		self:UpdateSquare(square)
	end)
	for _, square in pairs(squares.ExistingPerUNIT or {}) do
		self:StyleSquare(square)
	end
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "OnCombatLog")
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").decursive
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	self:WhenLoaded("Decursive", "StyleDecursive")
end
