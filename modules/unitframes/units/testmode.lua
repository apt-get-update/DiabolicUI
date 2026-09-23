local Addon, Engine = ...
local Module = Engine:GetModule("UnitFrames")

-- Lua API
local math_floor = math.floor
local unpack = unpack

-- WoW API
local IsMounted = IsMounted

local C = Engine:GetDB("Data: Colors")

-- Test Mode: mock party/raid preview
-------------------------------------------------------------------
-- Mirrors modules/unitframes/elements/role.lua's own (locally-scoped)
-- texcoord table - duplicated here rather than exported just for this.
-- Inset by a couple of texels to stay clear of the neighboring icon's
-- edge-glow bleed at the shared 0.5 seam (see role.lua for the detail).
local epsilon = 2/64
local ROLE_TEXCOORDS = {
	TANK = { 0 + epsilon, 0.5 - epsilon, 0 + epsilon, 0.5 - epsilon },
	HEALER = { 0.5 + epsilon, 1 - epsilon, 0 + epsilon, 0.5 - epsilon },
	DAMAGER = { 0 + epsilon, 0.5 - epsilon, 0.5 + epsilon, 1 - epsilon }
}

-- A small, clearly-fake roster used to preview the party/raid layout and
-- styling (health bar, name, role icon, class color) without needing a
-- real group. Cycled to cover up to 40 raid slots.
local FAKE_NAMES = {
	"Aldric", "Brynn", "Caelum", "Doran", "Elowen", "Fenwick", "Garrick", "Hilda",
	"Ivo", "Jorah", "Kestrel", "Liora", "Maren", "Nyx", "Orin", "Petra",
	"Quill", "Ravi", "Sable", "Tamsin"
}
local FAKE_CLASSES = {
	"WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST",
	"DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID"
}
local FAKE_ROLES = { "TANK", "HEALER", "DAMAGER", "DAMAGER", "DAMAGER" }

local GetFakeUnitData = function(i)
	local name = FAKE_NAMES[((i - 1) % #FAKE_NAMES) + 1]
	if (i > #FAKE_NAMES) then
		name = name .. math_floor((i - 1) / #FAKE_NAMES) + 1
	end

	local max = 18000 + ((i * 733) % 9000)
	local cur = (i % 4 == 0) and math_floor(max * 0.62) or max

	return {
		name = name,
		class = FAKE_CLASSES[((i - 1) % #FAKE_CLASSES) + 1],
		role = FAKE_ROLES[((i - 1) % #FAKE_ROLES) + 1],
		cur = cur,
		max = max
	}
end

-- Pushes fake data directly onto a frame's sub-widgets, bypassing the real
-- unit-token-driven Update functions entirely (there's no real unit behind
-- these frames, so nothing would ever call those anyway).
local ApplyFakeData = function(frame, data, showClassColors)
	local Health = frame.Health
	if Health then
		Health:SetMinMaxValues(0, data.max)
		Health:SetValue(data.cur)

		local r, g, b
		if showClassColors then
			r, g, b = unpack(C.Class[data.class] or C.Class.UNKNOWN)
		else
			r, g, b = unpack(C.Orb.HEALTH[1])
		end
		Health:SetStatusBarColor(r, g, b)

		if Health.Value then
			Health.Value:SetFormattedText("%d / %d", data.cur, data.max)
		end
	end

	if frame.Name then
		frame.Name:SetText(data.name)
	end

	if frame.Role then
		local texcoord = ROLE_TEXCOORDS[data.role]
		if texcoord then
			frame.Role:SetTexCoord(unpack(texcoord))
			frame.Role:Show()
		else
			frame.Role:Hide()
		end
	end

	-- There's no real unit behind these fake members to model, so the
	-- player's own (always-available) model is used for every slot -
	-- enough to preview that the portrait shows up, animates and is
	-- positioned correctly, even if it isn't actually "their" character.
	-- *Must Show() before SetUnit()/SetCamera() - an unshown model won't
	--  properly react to the camera change, and renders blank/black.
	if frame.Portrait then
		frame.Portrait:Show()
		frame.Portrait:ClearModel()
		frame.Portrait:SetUnit("player")
		-- Camera 0 is a close-up bust preset tuned for a plain humanoid -
		-- forcing it onto a much bigger mounted unit is what blows the
		-- framing up into a huge, spilling-out mess. Leave the widget's
		-- own default (whole-unit) camera in place while mounted instead.
		-- *SetCamDistanceScale() would be the proper fix for this, but
		--  Immersion hooks that method with code incompatible with this
		--  client and errors on any call to it, from any addon.
		if not IsMounted("player") then
			frame.Portrait:SetCamera(0)
		end
	end
end

Module.SetPartyMockShown = function(self, shown)
	if (not shown) then
		if self.partyContainer then
			self.partyContainer:Hide()
		end
		return
	end

	if (not self.partyContainer) then
		local PartyWidget = self:GetWidget("Unit: Party")
		local config = self:GetDB("UnitFrames").visuals.units.party
		local db = self:GetConfig("UnitFrames")

		local container = Engine:CreateFrame("Frame", nil, "UICenter")
		container:Place(unpack(config.position))
		container:SetSize(config.size[1], config.size[2] * 4 + config.offset * 3)

		self.partyContainer = container
		self.partyFrames = {}

		for i = 1, 4 do
			local frame = Engine:CreateFrame("Button", nil, container)
			PartyWidget.Style(frame, "party" .. i)
			ApplyFakeData(frame, GetFakeUnitData(i), db.showClassColors)
			frame:Show()
			self.partyFrames[i] = frame
		end
	end

	self.partyContainer:Show()
end

Module.SetRaidMockShown = function(self, shown)
	if (not shown) then
		if self.raidContainer then
			self.raidContainer:Hide()
		end
		return
	end

	if (not self.raidContainer) then
		local RaidWidget = self:GetWidget("Unit: Raid")
		local config = self:GetDB("UnitFrames").visuals.units.raid
		local db = self:GetConfig("UnitFrames")

		-- Mirrors modules/unitframes/units/raid.lua's own LayoutRaidFrames
		-- grid math (8 groups of 5, 2 groups per column), just fed a fake
		-- 40-member roster (all 8 subgroups full) instead of real roster data.
		local membersPerGroup = 5
		local groupsPerColumn = 2
		local numColumns = math_floor(8 / groupsPerColumn)
		local xOffset = config.size[1] + (config.offset or 5) + (config.auras.button.size[1] or 0) + 3
		local yOffset = -(config.size[2] + (config.offset or 5))

		local container = Engine:CreateFrame("Frame", nil, "UICenter")
		container:Place(unpack(config.position))
		-- A frame needs both a resolved anchor *and* a defined size for
		-- its geometry (GetCenter/GetLeft/etc.) to resolve at all - without
		-- this, nothing anchored to it renders, despite reporting IsShown/
		-- IsVisible as true.
		container:SetSize(numColumns * xOffset, groupsPerColumn * membersPerGroup * -yOffset)

		self.raidContainer = container
		self.raidFrames = {}

		for i = 1, 40 do
			local frame = Engine:CreateFrame("Button", nil, container)
			RaidWidget.Style(frame, "raid" .. i)
			ApplyFakeData(frame, GetFakeUnitData(i), db.showClassColors)

			local subgroup = math_floor((i - 1) / membersPerGroup) -- 0..7
			local indexInGroup = (i - 1) % membersPerGroup
			local col = math_floor(subgroup / groupsPerColumn)
			local groupInColumn = subgroup % groupsPerColumn
			local anchorX = col * xOffset
			local anchorY = (groupInColumn * membersPerGroup + indexInGroup) * yOffset

			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", container, "TOPLEFT", anchorX, anchorY)
			frame:Show()

			self.raidFrames[i] = frame
		end
	end

	self.raidContainer:Show()
end
