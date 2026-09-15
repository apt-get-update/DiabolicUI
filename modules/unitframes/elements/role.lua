local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- WoW API
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitClass = UnitClass
local UnitName = UnitName
local UnitExists = UnitExists
local UnitIsConnected = UnitIsConnected
local CanInspect = CanInspect
local NotifyInspect = NotifyInspect
local GetTalentTabInfo = GetTalentTabInfo
local GetTime = GetTime
local IsInGroup = IsInGroup

-- Each role icon occupies one quadrant of a 64x64 grid, but the artwork's
-- edge glow bleeds a texel or two past its own quadrant boundary. Sampled
-- at the exact 0.5 seam, bilinear filtering blends that bleed in from the
-- *neighboring* icon, showing up as a faint line along the shared edge
-- (most visibly along the top of the DAMAGER icon, fed by TANK's glow
-- right above it). Insetting the crop by a couple of texels keeps it
-- safely inside its own quadrant instead.
local epsilon = 2/64
local texcoords = {
	TANK = { 0 + epsilon, 0.5 - epsilon, 0 + epsilon, 0.5 - epsilon },
	HEALER = { 0.5 + epsilon, 1 - epsilon, 0 + epsilon, 0.5 - epsilon },
	DAMAGER = { 0 + epsilon, 0.5 - epsilon, 0.5 + epsilon, 1 - epsilon }
}

-- Role guessed from a class's primary (most points spent) talent tree,
-- used only as a fallback for groups with no real assigned role (i.e.
-- anything not formed through the Dungeon/Raid Finder).
-- Druid tab 2 (Feral) covers both bear tanks and cat dps and can't be told
-- apart from talent points alone, so it's guessed as DAMAGER.
-- Death Knight tab 1 (Blood) is guessed as TANK, its common raid role in 3.3.5.
local specRoles = {
	WARRIOR     = { "DAMAGER", "DAMAGER", "TANK" },
	PALADIN     = { "HEALER", "TANK", "DAMAGER" },
	HUNTER      = { "DAMAGER", "DAMAGER", "DAMAGER" },
	ROGUE       = { "DAMAGER", "DAMAGER", "DAMAGER" },
	PRIEST      = { "HEALER", "HEALER", "DAMAGER" },
	DEATHKNIGHT = { "TANK", "DAMAGER", "DAMAGER" },
	SHAMAN      = { "DAMAGER", "DAMAGER", "HEALER" },
	MAGE        = { "DAMAGER", "DAMAGER", "DAMAGER" },
	WARLOCK     = { "DAMAGER", "DAMAGER", "DAMAGER" },
	DRUID       = { "DAMAGER", "DAMAGER", "HEALER" }
}

-- Cached fallback role per player name, filled in by the inspect queue
-- below. `false` means "already checked, no role could be determined".
local roleByName = {}

-- Frames currently displaying a Role icon, keyed by unit id, so a
-- finished inspect can push its result straight to the right frame.
local activeFrames = {}

local inspectQueue = {}
local queuedNames = {}
local currentInspectUnit, currentInspectName
local nextInspectTime = 0
local INSPECT_INTERVAL = 1.2 -- seconds between inspect requests

local Update

local scanner = CreateFrame("Frame")
scanner:Hide()
scanner:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 0.2 then
		return
	end
	self.elapsed = 0

	if currentInspectUnit then
		if GetTime() - (self.requestedAt or 0) > 5 then
			queuedNames[currentInspectName] = nil
			currentInspectUnit, currentInspectName = nil, nil
		else
			return
		end
	end

	if GetTime() < nextInspectTime then
		return
	end

	local unit = table.remove(inspectQueue, 1)
	while unit and not (UnitExists(unit) and CanInspect(unit)) do
		local name = UnitName(unit)
		if name then
			queuedNames[name] = nil
		end
		unit = table.remove(inspectQueue, 1)
	end

	if not unit then
		self:Hide()
		return
	end

	currentInspectUnit = unit
	currentInspectName = UnitName(unit)
	self.requestedAt = GetTime()
	NotifyInspect(unit)
end)

local inspectListener = CreateFrame("Frame")
inspectListener:RegisterEvent("INSPECT_TALENT_READY")
inspectListener:SetScript("OnEvent", function()
	if not currentInspectUnit then
		return
	end

	local unit, name = currentInspectUnit, currentInspectName
	currentInspectUnit, currentInspectName = nil, nil
	nextInspectTime = GetTime() + INSPECT_INTERVAL
	queuedNames[name] = nil

	local _, class = UnitClass(unit)
	local roles = class and specRoles[class]
	local role

	if roles then
		local bestTab, bestPoints = 1, -1
		for tab = 1, 3 do
			local _, _, points = GetTalentTabInfo(tab, true)
			points = points or 0
			if points > bestPoints then
				bestPoints, bestTab = points, tab
			end
		end
		role = roles[bestTab]
	end

	roleByName[name] = role or false

	local frame = activeFrames[unit]
	if frame then
		Update(frame, "INSPECT_TALENT_READY")
	end
end)

local queueInspect = function(unit, name)
	queuedNames[name] = true
	table.insert(inspectQueue, unit)
	scanner:Show()
end

Update = function(self, event, ...)
	local Role = self.Role
	local unit = self.unit

	-- Party/raid roles only mean anything while actually grouped - skip
	-- the assigned-role lookup and the inspect-queue fallback entirely
	-- otherwise, instead of polling/inspecting nonexistent unit tokens.
	if not IsInGroup() then
		Role:Hide()
		return
	end

	local role = UnitGroupRolesAssigned(unit)
	if role ~= "TANK" and role ~= "HEALER" and role ~= "DAMAGER" then
		role = nil

		local name = UnitName(unit)
		if name then
			role = roleByName[name]
			if role == nil and not queuedNames[name] and UnitIsConnected(unit) and CanInspect(unit) then
				queueInspect(unit, name)
			end
		end
	end

	local texcoord = role and texcoords[role]
	if texcoord then
		Role:SetTexCoord(unpack(texcoord))
		Role:Show()
	else
		Role:Hide()
	end

	if Role.PostUpdate then
		return Role:PostUpdate(unit, role)
	end
end

-- Update only re-queues an inspect when CanInspect(unit) is true *at that
-- exact moment* - out of range/line of sight at login is common for party
-- members, and since that's a one-shot attempt gated behind fairly rare
-- events (GROUP_ROSTER_UPDATE, PARTY_MEMBER_ENABLE, entering/exiting a
-- vehicle), a frame that missed its window could otherwise be stuck
-- roleless for the rest of the session even once the unit comes into
-- range. Periodically retrying every active frame is what actually makes
-- this "refresh" instead of relying on the right event firing at the
-- right time - Update itself is cheap and idempotent when the role is
-- already known or an inspect is already queued.
local refresher = CreateFrame("Frame")
refresher:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 3 then
		return
	end
	self.elapsed = 0

	for unit, frame in pairs(activeFrames) do
		Update(frame, "ROLE_REFRESH")
	end
end)

local Enable = function(self, unit)
	local Role = self.Role
	if Role then
		activeFrames[unit] = self

		self:RegisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:RegisterEvent("UNIT_EXITED_VEHICLE", Update)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:RegisterEvent("GROUP_ROSTER_UPDATE", Update)

		if unit:find("party") then
			self:RegisterEvent("PARTY_MEMBER_ENABLE", Update)
		end

		return true
	end
end

local Disable = function(self, unit)
	local Role = self.Role
	if Role then
		activeFrames[unit] = nil

		self:UnregisterEvent("UNIT_ENTERED_VEHICLE", Update)
		self:UnregisterEvent("UNIT_EXITED_VEHICLE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:UnregisterEvent("GROUP_ROSTER_UPDATE", Update)

		if unit:find("party") then
			self:UnregisterEvent("PARTY_MEMBER_ENABLE", Update)
		end
	end
end

Handler:RegisterElement("Role", Enable, Disable, Update)
