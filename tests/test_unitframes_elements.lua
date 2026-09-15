-- Run from the addon root: lua5.1 tests/test_unitframes_elements.lua
--
-- Loads the *real* modules/unitframes/elements/name.lua and
-- modules/unitframes/elements/threat.lua under a minimal Engine/WoW mock
-- and exercises their Update functions:
--  - name.lua: colors a unit frame's name text white by default, blue for
--    an elite/rare-elite (only if the frame opted in via Name.colorElite),
--    and purple for a world boss (only if Name.colorBoss) - then bails out
--    entirely if the unit doesn't exist, or (on UNIT_TARGET) isn't the
--    frame's own current target.
--  - threat.lua: shows the threat glow in the aggro-status color while the
--    unit has a threat situation, hides it otherwise - and ignores a
--    UNIT_THREAT_SITUATION_UPDATE event for a different unit than its own.
--
-- Both files end with `Handler:RegisterElement("Name"/"Threat", Enable,
-- Disable, Update)` - since the shared EngineMock's module/handler stand-in
-- doesn't define RegisterElement, it's overridden here to capture the three
-- local functions directly, the same "small hand-written fake standing in
-- for a WoW object" idiom the rest of the suite uses, just applied to the
-- handler instead of a frame (see tests/README.md).

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local elements

-- Purpose-built fakes rather than a generic catch-all spy: a metatable
-- that auto-vivifies *any* missing method into a recording stub would also
-- make plain data fields like `Name.colorBoss`/`Name.colorElite` (left
-- unset in most tests, and meant to then read back falsy) resolve to an
-- always-truthy stub function instead of nil - exactly the "mock
-- permissiveness" pitfall from tests/README.md, just self-inflicted this
-- time. Only the few real methods each element calls are defined below.
local function newFakeNameText()
	return { calls = {},
		SetText = function(self, text) table.insert(self.calls, { "SetText", text }) end,
		SetTextColor = function(self, r, g, b) table.insert(self.calls, { "SetTextColor", r, g, b }) end,
	}
end

local function newFakeThreatTexture()
	return { calls = {},
		SetVertexColor = function(self, r, g, b) table.insert(self.calls, { "SetVertexColor", r, g, b }) end,
		Show = function(self) table.insert(self.calls, { "Show" }) end,
		Hide = function(self) table.insert(self.calls, { "Hide" }) end,
	}
end

-- A fake unit database the mocked Unit* globals read from, keyed by unit
-- token, so each test can script exactly what the "game state" looks like.
local units

local function loadUnitFrameElements()
	units = {}

	_G.UnitExists = function(unit) return units[unit] ~= nil end
	_G.UnitName = function(unit) return units[unit] and units[unit].name end
	_G.UnitClassification = function(unit) return units[unit] and units[unit].classification end
	_G.UnitIsUnit = function(a, b) return a == b end
	_G.UnitThreatSituation = function(unit) return units[unit] and units[unit].threat end
	_G.GetThreatStatusColor = function(status)
		if status == 3 then return 1, 0, 0 end -- tanking, securely
		return 1, 1, 0 -- has threat, not securely tanking
	end

	local Engine = EngineMock.new()
	local Handler = Engine:NewHandler("UnitFrame")
	local captured = {}
	Handler.RegisterElement = function(self, name, Enable, Disable, Update)
		captured[name] = { Enable = Enable, Disable = Disable, Update = Update }
	end

	assert(loadfile("modules/unitframes/elements/name.lua"))("DiabolicUI", Engine)
	assert(loadfile("modules/unitframes/elements/threat.lua"))("DiabolicUI", Engine)

	return captured
end

TestUnitFrameName = {}

function TestUnitFrameName:setUp()
	elements = loadUnitFrameElements()
	self.Update = elements.Name.Update
	self.Name = newFakeNameText()
end

function TestUnitFrameName:test_colors_a_normal_unit_white()
	units.target = { name = "Ragnaros" }
	local frame = { unit = "target", Name = self.Name }

	self.Update(frame, "UNIT_NAME_UPDATE")

	lu.assertEquals(self.Name.calls[1], { "SetText", "Ragnaros" })
	lu.assertEquals(self.Name.calls[2], { "SetTextColor", 1, 1, 1 })
end

function TestUnitFrameName:test_colors_a_world_boss_purple_only_when_opted_in()
	units.target = { name = "Ragnaros", classification = "worldboss" }
	self.Name.colorBoss = true
	local frame = { unit = "target", Name = self.Name }

	self.Update(frame, "UNIT_NAME_UPDATE")

	lu.assertEquals(self.Name.calls[2], { "SetTextColor", 163/255, 53/255, 255/238 })
end

function TestUnitFrameName:test_world_boss_is_not_colored_without_opting_in()
	units.target = { name = "Ragnaros", classification = "worldboss" }
	local frame = { unit = "target", Name = self.Name } -- Name.colorBoss left unset

	self.Update(frame, "UNIT_NAME_UPDATE")

	lu.assertEquals(self.Name.calls[2], { "SetTextColor", 1, 1, 1 })
end

function TestUnitFrameName:test_colors_an_elite_blue_only_when_opted_in()
	units.target = { name = "A Sentry", classification = "elite" }
	self.Name.colorElite = true
	local frame = { unit = "target", Name = self.Name }

	self.Update(frame, "UNIT_NAME_UPDATE")

	lu.assertEquals(self.Name.calls[2], { "SetTextColor", 0, 112/255, 221/255 })
end

function TestUnitFrameName:test_does_nothing_when_the_unit_does_not_exist()
	local frame = { unit = "target", Name = self.Name } -- units.target left unset -> UnitExists false

	self.Update(frame, "UNIT_NAME_UPDATE")

	lu.assertEquals(#self.Name.calls, 0)
end

function TestUnitFrameName:test_unit_target_event_is_ignored_for_a_different_frame_unit()
	units.target = { name = "Ragnaros" }
	units.targettarget = { name = "Firelord" }
	local frame = { unit = "target", Name = self.Name }

	-- UNIT_TARGET fires for the frame's unit ("target"), but the frame's
	-- own current target (unit.."target" = "targettarget") isn't itself -
	-- UnitIsUnit("target", "targettarget") is false, so this should bail.
	self.Update(frame, "UNIT_TARGET")

	lu.assertEquals(#self.Name.calls, 0)
end

TestUnitFrameThreat = {}

function TestUnitFrameThreat:setUp()
	elements = loadUnitFrameElements()
	self.Update = elements.Threat.Update
	self.Threat = newFakeThreatTexture()
end

function TestUnitFrameThreat:test_shows_the_threat_glow_with_the_status_color()
	units.target = { threat = 3 }
	local frame = { unit = "target", Threat = self.Threat }

	self.Update(frame, "UNIT_THREAT_SITUATION_UPDATE", "target")

	lu.assertEquals(self.Threat.calls[1], { "SetVertexColor", 1, 0, 0 })
	lu.assertEquals(self.Threat.calls[2][1], "Show")
end

function TestUnitFrameThreat:test_hides_the_glow_when_there_is_no_threat()
	units.target = { threat = 0 }
	local frame = { unit = "target", Threat = self.Threat }

	self.Update(frame, "UNIT_THREAT_SITUATION_UPDATE", "target")

	lu.assertEquals(self.Threat.calls[1][1], "Hide")
end

function TestUnitFrameThreat:test_ignores_the_event_for_a_different_unit()
	units.target = { threat = 3 }
	local frame = { unit = "target", Threat = self.Threat }

	self.Update(frame, "UNIT_THREAT_SITUATION_UPDATE", "party1")

	lu.assertEquals(#self.Threat.calls, 0)
end

function TestUnitFrameThreat:test_does_nothing_when_the_unit_does_not_exist()
	local frame = { unit = "target", Threat = self.Threat } -- units.target left unset

	self.Update(frame, "PLAYER_TARGET_CHANGED")

	lu.assertEquals(#self.Threat.calls, 0)
end

os.exit(lu.LuaUnit.run())
