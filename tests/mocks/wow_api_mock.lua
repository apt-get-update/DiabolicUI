-- Stubs for the small set of real WoW globals that get called directly at
-- file-load time (outside any function body) by the addon files under
-- test, so `loadfile(...)` on them doesn't error before we ever reach the
-- functions we actually want to exercise. Deliberately narrow: add to this
-- only when a new file-under-test needs it, not speculatively.
--
-- Usage: require("mocks.wow_api_mock").install()

local WowApiMock = {}

function WowApiMock.install()
	-- modules/blizzard/tooltips.lua reads these at file scope to build its
	-- "Item Level:" / "Talents:" tooltip line prefixes, and to seed
	-- playerLevel from the (fake) currently logged in character.
	_G.ITEM_LEVEL = "Item Level %d"
	_G.TALENTS = "Talents"
	_G.UnitLevel = _G.UnitLevel or function() return 80 end

	-- used to build match patterns for remaining-buff-time tooltip lines
	_G.SPELL_TIME_REMAINING_DAYS = "%d Days"
	_G.SPELL_TIME_REMAINING_HOURS = "%d Hours"
	_G.SPELL_TIME_REMAINING_MIN = "%d Min"
	_G.SPELL_TIME_REMAINING_SEC = "%d Sec"

	-- modules/blizzard/containers.lua builds a bag-slot-count match pattern
	-- from this at file scope
	_G.CONTAINER_SLOTS = "%d Slots"
end

return WowApiMock
