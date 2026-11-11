-- Gives Decursive's squares (its micro unit frames) Diablo III's look when
-- it's loaded: each a dark stone socket in the action buttons' bronze
-- border; an afflicted player's showing the affliction's icon, the border
-- in its type's colour, and a little mouse with the button to click lit
-- (and its modifier's letter); a short burst in that colour as you
-- dispel it. Art only: Decursive's code and its secure clicks are left as
-- they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Decursive", "LOW")

local kit

-- Decursive's statuses (DcrC's): the ones we draw differently
local NORMAL, AFFLICTED_NIR = 8, 512

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

-- A square (once): its socket, border, icon, mouse and burst.
Module.StyleSquare = function(self, square)
	if square.DiabolicSocket then
		return
	end
	local spec, frame = self.config, square.Frame
	for i = 1, 4 do
		square["OuterTexture" .. i]:Hide() -- (its class border: ours instead)
	end
	local socket = frame:CreateTexture(nil, "BACKGROUND")
	socket:SetTexture(unpack(spec.socket_color))
	socket:SetPoint("CENTER")
	socket:SetSize(frame:GetWidth() - 2, frame:GetHeight() - 2)
	square.DiabolicSocket = socket
	square.DiabolicBorder = kit:AddBorder(frame, frame:GetWidth())
	local icon = frame:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("CENTER")
	icon:SetSize(frame:GetWidth() - 4, frame:GetHeight() - 4)
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	icon:Hide()
	square.DiabolicIcon = icon
	square.DiabolicMouse = CreateMouse(frame, spec.mouse)
	square.DiabolicBurst = CreateBurst(frame, spec.burst)
	self:UpdateSquare(square)
end

-- What a square shows, after Decursive set its colour: the stone alone
-- while all is well, Decursive's colour for its other states (far, gone,
-- blacklisted), the affliction's icon (dimmer out of range) and the mouse
-- button to click while afflicted.
Module.UpdateSquare = function(self, square)
	if not square.DiabolicSocket then
		return
	end
	local spec = self.config
	local debuff = square.IsDebuffed and square.Debuffs and square.Debuffs[1]
	local type = debuff and _G.DcrC and _G.DcrC.TypeNames and _G.DcrC.TypeNames[debuff.Type]
	local status = square.UnitStatus
	if debuff then
		square.Texture:Hide()
		square.DiabolicIcon:SetTexture(debuff.Texture)
		square.DiabolicIcon:SetAlpha((status == AFFLICTED_NIR) and spec.out_of_range_alpha or 1)
		square.DiabolicIcon:Show()
		square.DiabolicBorder:SetVertexColor(unpack(spec.colors[type] or spec.colors.none))
		square.DiabolicType = type
		self:ShowMouse(square)
	else
		if status == NORMAL then
			square.Texture:Hide()
		else
			square.Texture:Show()
		end
		square.DiabolicIcon:Hide()
		square.DiabolicBorder:SetVertexColor(1, 1, 1)
		square.DiabolicMouse:Hide()
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
-- what it showed.
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
