local ADDON, Engine = ...
local path = ([[Interface\AddOns\%s\media\]]):format(ADDON)

-- The purpose of this database is to contain static values 
-- with information about layout, sizes, textures, etc, 
-- that several modules in the UI need access to, 
-- without having to rely on any of those modules 
-- to provide those values.
--
-- TODO: Add most blizzard constants into this, and our own proxy versions in the modules. 
-- 		 This will work as an extra compatibility and control layer. 
-- 
Engine:NewStaticConfig("Data: Constants", {
	-- Defined in FrameXML\BuffFrame.lua
	BUFF_MAX_DISPLAY = BUFF_MAX_DISPLAY or 32, 
	DEBUFF_MAX_DISPLAY = DEBUFF_MAX_DISPLAY or 16,

	-- Time in seconds, used for aura modules.
	DAY = 86400, 
	HOUR = 3600, 
	MINUTE = 60,

	AURA_TIME_LIMIT = 300,
	AURA_TIME_LIMIT_LOW = 60,

	-- ActionButton Numbers
	NUM_ACTIONBAR_SLOTS = NUM_ACTIONBAR_BUTTONS or 12, -- number of buttons on a standard bar
	NUM_PET_SLOTS = NUM_PET_ACTION_SLOTS or 10, -- number of pet buttons
	NUM_POSSESS_SLOTS = NUM_POSSESS_SLOTS or 2, -- number of possess buttons
	NUM_STANCE_SLOTS = NUM_SHAPESHIFT_SLOTS or 10, -- number of stance buttons
	NUM_VEHICLE_SLOTS = VEHICLE_MAX_ACTIONBUTTONS or 6, -- number of vehicle buttons

	-- Textures
	BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]], -- used as a single color texture
	EMPTY_TEXTURE = path .. [[textures\DiabolicUI_Texture_16x16_Empty.tga]]	-- Used to hide UI elements

}, true)
