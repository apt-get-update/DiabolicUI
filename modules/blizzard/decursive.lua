-- Gives Decursive's squares (its micro unit frames) Diablo III's look when
-- it's loaded: an afflicted player's a stained-glass medallion (the
-- quests' medallions of Diablo III's acts), a healthy one's nothing: its
-- glass lit in the affliction's colour (Magic blue, Curse purple, Disease
-- orange, Poison gold). In a raid, smaller, and plain round glass in that
-- colour (25 medallions are too busy). As you dispel it, a burst in that
-- colour, its glass dark for a moment, then gone.
-- Art only: Decursive's code and its secure clicks are left as they are.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Decursive", "LOW")

local kit

-- Decursive's statuses (DcrC's): the ones we draw differently
local AFFLICTED_NIR = 512

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

-- A square (once): its medallion and burst; Decursive's own
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
	medallion:SetPoint("CENTER")
	square.DiabolicMedallion = medallion
	-- (the raid's glass lit: a copy of it added over it)
	local light = frame:CreateTexture(nil, "BORDER")
	light:SetTexture(spec.raid.glass)
	light:SetTexCoord(unpack(spec.raid.coords))
	light:SetBlendMode("ADD")
	light:SetAllPoints(frame)
	square.DiabolicLight = light
	-- its timer small and light in a corner, the glass seen through
	local timer = square.ChronoFontString
	timer:SetFontObject(spec.timer.font)
	timer:ClearAllPoints()
	timer:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", spec.timer.offset[1], spec.timer.offset[2])
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

-- A square's glass of `type`, lit or dark: the medallion, or in a raid
-- the plain round glass (lit by its copy added over it).
local SetGlass = function(square, spec, type, lit, alpha)
	local medallion, light, frame = square.DiabolicMedallion, square.DiabolicLight, square.Frame
	if Module.raid then
		local raid = spec.raid
		local r, g, b = unpack(raid.colors[type])
		local k = lit and 1 or raid.dark
		medallion:SetTexture(raid.glass)
		medallion:SetTexCoord(unpack(raid.coords))
		medallion:SetSize(frame:GetWidth(), frame:GetHeight())
		medallion:SetVertexColor(r * k, g * k, b * k)
		light:SetVertexColor(r, g, b)
		light:SetAlpha(alpha)
		if lit then
			light:Show()
		else
			light:Hide()
		end
	else
		-- (its ornaments past the square: its glass as big as the square)
		medallion:SetTexture(spec.texture)
		SetMedallion(medallion, spec.medallions[type][lit and "lit" or "dark"], spec.cell)
		medallion:SetSize(frame:GetWidth() * spec.medallion_scale, frame:GetHeight() * spec.medallion_scale)
		medallion:SetVertexColor(1, 1, 1)
		light:Hide()
	end
	medallion:SetAlpha(alpha)
	medallion:Show()
end

-- What a square shows, after Decursive set its state: the lit glass while
-- afflicted (dimmer out of range); the dark glass just after your dispel;
-- nothing while all is well.
Module.UpdateSquare = function(self, square)
	local medallion = square.DiabolicMedallion
	if not medallion then
		return
	end
	local spec = self.config
	local cells = spec.medallions
	square.Texture:Hide() -- (Decursive's square of colour)
	square.ChronoFontString:SetTextColor(unpack(spec.timer.color)) -- (Decursive's red again on a full update)
	local debuff = square.IsDebuffed and square.Debuffs and square.Debuffs[1]
	local type = debuff and _G.DcrC and _G.DcrC.TypeNames and _G.DcrC.TypeNames[debuff.Type]
	if debuff and cells[type] then
		SetGlass(square, spec, type, true, (square.UnitStatus == AFFLICTED_NIR) and spec.out_of_range_alpha or 1)
		square.DiabolicType = type
	elseif square.DiabolicCleansed and cells[square.DiabolicCleansed] then
		SetGlass(square, spec, square.DiabolicCleansed, false, 1)
	else
		medallion:Hide() -- (nothing to do there: nothing shown)
		square.DiabolicLight:Hide()
	end
end

-- In a raid or not: the squares' art, and their size (Decursive's own
-- scale times the raid's), set out of combat (they're secure buttons).
Module.UpdateGroup = function(self, event)
	local D = _G.Dcr
	Module.raid = GetNumRaidMembers() > 0
	for _, square in pairs(D.MicroUnitF.ExistingPerUNIT or {}) do
		self:UpdateSquare(square)
	end
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateGroup")
		return
	end
	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED", "UpdateGroup")
	end
	local scale = ((D.profile and D.profile.DebuffsFrameElemScale) or 1) * (Module.raid and self.config.raid.scale or 1)
	if math.abs(_G.DcrMUFsContainer:GetScale() - scale) > 0.001 then
		self.scaling = true
		D.MicroUnitF:SetScale(scale)
		self.scaling = nil
	end
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
	self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateGroup")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateGroup")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateGroup")
	-- (Decursive sets its own scale as it starts and from its options)
	hooksecurefunc(_G.DcrMUFsContainer, "SetScale", function()
		if not self.scaling then
			self:UpdateGroup()
		end
	end)
	self:UpdateGroup()
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
