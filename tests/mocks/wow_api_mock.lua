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

	-- modules/blizzard/itemtooltips.lua builds its DPS / armor / durability
	-- match patterns from these at file scope
	_G.DPS_TEMPLATE = "(%.1f damage per second)"
	_G.ARMOR_TEMPLATE = "%d Armor"
	_G.DURABILITY_TEMPLATE = "Durability %d / %d"
	_G.ITEM_CLASSES_ALLOWED = "Classes: %s"
	_G.ITEM_UNIQUE_MULTIPLE = "Unique (%d)"
	_G.ITEM_LIMIT_CATEGORY = "Unique: %s (%d)"
	_G.ITEM_LIMIT_CATEGORY_MULTIPLE = "Unique-Equipped: %s (%d)"
	_G.ITEM_MIN_LEVEL = "Requires Level %d"
	_G.ITEM_LEVEL_RANGE = "Requires level %d to %d"
	_G.ITEM_LEVEL_RANGE_CURRENT = "Requires level %d to %d (%d)"
	_G.ITEM_MIN_SKILL = "Requires %s (%d)"
	_G.ITEM_REQ_SKILL = "Requires %s"
	_G.ITEM_REQ_REPUTATION = "Requires %s - %s"
	_G.ITEM_REQ_ARENA_RATING = "Requires personal and team arena rating of %d"
end

return WowApiMock
