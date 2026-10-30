-- Blizzard's half of the fake WoW client (tests/mocks/client.lua): the
-- FrameXML frames, constants and functions DiabolicUI touches, shaped like
-- their 3.3.5a versions (names, types, children and parentKeys follow the
-- client's FrameXML), and created before the addon loads, like in game.
--
-- Only what the addon reaches is here. When a test fails with "attempt to
-- index global 'SomeFrame' (a nil value)", check the frame exists in 3.3.5
-- (FrameXML/*.xml) and add it with the same structure.

local Widgets = require("mocks.client_widgets")

local Blizzard = {}

local state = Widgets.state

------------------------------------------------------------------------
-- Constants
------------------------------------------------------------------------

local CLASS_COLORS = {
	WARRIOR = { 0.78, 0.61, 0.43, "ffc79c6e" }, PALADIN = { 0.96, 0.55, 0.73, "fff58cba" },
	HUNTER = { 0.67, 0.83, 0.45, "ffabd473" }, ROGUE = { 1, 0.96, 0.41, "fffff569" },
	PRIEST = { 1, 1, 1, "ffffffff" }, DEATHKNIGHT = { 0.77, 0.12, 0.23, "ffc41f3b" },
	SHAMAN = { 0, 0.44, 0.87, "ff0070de" }, MAGE = { 0.41, 0.8, 0.94, "ff69ccf0" },
	WARLOCK = { 0.58, 0.51, 0.79, "ff9482c9" }, DRUID = { 1, 0.49, 0.04, "ffff7d0a" },
}

local function constants()
	local c = {
		NUM_ACTIONBAR_BUTTONS = 12, NUM_PET_ACTION_SLOTS = 10, NUM_POSSESS_SLOTS = 2,
		NUM_SHAPESHIFT_SLOTS = 10, NUM_MULTIBAR_BUTTONS = 12, VEHICLE_MAX_ACTIONBUTTONS = 6,
		BUFF_MAX_DISPLAY = 32, DEBUFF_MAX_DISPLAY = 16, NUM_CHAT_WINDOWS = 10, MAX_PARTY_MEMBERS = 4,
		MAX_RAID_MEMBERS = 40, MAX_BOSS_FRAMES = 4, MAX_ARENA_ENEMIES = 5, MAX_PLAYER_LEVEL = 80,
		NUM_BAG_SLOTS = 4, NUM_BANKBAGSLOTS = 7, NUM_BANKGENERIC_SLOTS = 28, NUM_CONTAINER_FRAMES = 13, BANK_CONTAINER = -1, KEYRING_CONTAINER = -2,
		MAX_CONTAINER_ITEMS = 36, MAX_TOTEMS = 4, MIRRORTIMER_NUMTIMERS = 3, STATICPOPUP_NUMDIALOGS = 4,
		UIDROPDOWNMENU_MAXBUTTONS = 32, UIDROPDOWNMENU_MAXLEVELS = 2, UIDROPDOWNMENU_BORDER_HEIGHT = 15, UIDROPDOWNMENU_VALUE_PATCH_VERSION = nil,
		LEFT_ACTIONBAR_PAGE = 4, RIGHT_ACTIONBAR_PAGE = 3, BOTTOMLEFT_ACTIONBAR_PAGE = 6,
		BOTTOMRIGHT_ACTIONBAR_PAGE = 5, NUM_ACTIONBAR_PAGES = 6, MAX_WATCHABLE_QUESTS = 25,
		MAX_QUESTLOG_QUESTS = 25, LOOTFRAME_NUMBUTTONS = 4, NUM_GROUP_LOOT_FRAMES = 4,
		MAX_SKILLLINE_TABS = 8, NUM_WORLDMAP_POIS = 0, MAX_NUM_TALENTS = 40, MAX_TALENT_TABS = 3,
		INVSLOT_AMMO = 0, INVSLOT_HEAD = 1, INVSLOT_NECK = 2, INVSLOT_SHOULDER = 3, INVSLOT_BODY = 4,
		INVSLOT_CHEST = 5, INVSLOT_WAIST = 6, INVSLOT_LEGS = 7, INVSLOT_FEET = 8, INVSLOT_WRIST = 9,
		INVSLOT_HAND = 10, INVSLOT_FINGER1 = 11, INVSLOT_FINGER2 = 12, INVSLOT_TRINKET1 = 13,
		INVSLOT_TRINKET2 = 14, INVSLOT_BACK = 15, INVSLOT_MAINHAND = 16, INVSLOT_OFFHAND = 17,
		INVSLOT_RANGED = 18, INVSLOT_TABARD = 19, INVSLOT_FIRST_EQUIPPED = 1, INVSLOT_LAST_EQUIPPED = 19,
		SPELL_POWER_MANA = 0, SPELL_POWER_RAGE = 1, SPELL_POWER_FOCUS = 2, SPELL_POWER_ENERGY = 3,
		SPELL_POWER_HAPPINESS = 4, SPELL_POWER_RUNES = 5, SPELL_POWER_RUNIC_POWER = 6,
		COMBATLOG_OBJECT_CONTROL_PLAYER = 0x00000100, COMBATLOG_OBJECT_TYPE_PLAYER = 0x00000400,
		COMBATLOG_OBJECT_REACTION_HOSTILE = 0x00000040, COMBATLOG_OBJECT_AFFILIATION_MINE = 0x00000001,
		LE_PARTY_CATEGORY_HOME = nil,
		SHOW_TARGET_OF_TARGET = "1", SHOW_TARGET_OF_TARGET_STATE = "5", SHOW_PARTY_BACKGROUND = "0",
		PLAYER_FRAME_CASTBARS_SHOWN = "0",
		DEFAULT_CHATFRAME_ALPHA = 0.25, CHAT_FRAME_FADE_TIME = 0.15, CHAT_FRAME_FADE_OUT_TIME = 2,
		CHAT_TAB_SHOW_DELAY = 0.2, CHAT_TAB_HIDE_DELAY = 1, CHAT_FRAME_MIN_WIDTH = 296,
		CHAT_FRAME_NORMAL_MIN_HEIGHT = 120, CHAT_FRAME_BIGGER_MIN_HEIGHT = 147,
		UIPARENT_MANAGED_FRAME_POSITIONS = {
			MainMenuBar = {}, ShapeshiftBarFrame = {}, PossessBarFrame = {}, PETACTIONBAR_YPOS = {},
			MultiCastActionBarFrame = {}, MULTICASTACTIONBAR_YPOS = {},
		},
		RAID_CLASS_COLORS = {},
		CLASS_ICON_TCOORDS = {},
		CLASS_SORT_ORDER = { "WARRIOR", "DEATHKNIGHT", "PALADIN", "PRIEST", "SHAMAN", "DRUID", "ROGUE", "MAGE", "WARLOCK", "HUNTER" },
		LOCALIZED_CLASS_NAMES_MALE = {}, LOCALIZED_CLASS_NAMES_FEMALE = {},
		ITEM_QUALITY_COLORS = {},
		PowerBarColor = {
			MANA = { r = 0, g = 0, b = 1 }, RAGE = { r = 1, g = 0, b = 0 }, FOCUS = { r = 1, g = 0.5, b = 0.25 },
			ENERGY = { r = 1, g = 1, b = 0 }, HAPPINESS = { r = 0, g = 1, b = 1 }, RUNES = { r = 0.5, g = 0.5, b = 0.5 },
			RUNIC_POWER = { r = 0, g = 0.82, b = 1 },
		},
		FACTION_BAR_COLORS = {
			{ r = 0.8, g = 0.3, b = 0.22 }, { r = 0.8, g = 0.3, b = 0.22 }, { r = 0.75, g = 0.27, b = 0 },
			{ r = 0.9, g = 0.7, b = 0 }, { r = 0, g = 0.6, b = 0.1 }, { r = 0, g = 0.6, b = 0.1 },
			{ r = 0, g = 0.6, b = 0.1 }, { r = 0, g = 0.6, b = 0.1 },
		},
		MAX_PLAYER_LEVEL_TABLE = { [0] = 60, 70, 80 },
		ChatTypeInfo = {},
		ChatTypeGroup = { SYSTEM = { "CHAT_MSG_SYSTEM" }, SAY = { "CHAT_MSG_SAY" } },
		CHAT_FRAMES = {},
		CHAT_FRAME_TEXTURES = {
			"Background", "TopLeftTexture", "BottomLeftTexture", "TopRightTexture", "BottomRightTexture",
			"LeftTexture", "RightTexture", "BottomTexture", "TopTexture",
			"ButtonFrameBackground", "ButtonFrameTopLeftTexture", "ButtonFrameBottomLeftTexture",
			"ButtonFrameTopRightTexture", "ButtonFrameBottomRightTexture", "ButtonFrameLeftTexture",
			"ButtonFrameRightTexture", "ButtonFrameBottomTexture", "ButtonFrameTopTexture",
		},
		StaticPopupDialogs = {},
		UnitPopupMenus = {
			SELF = { "RAID_TARGET_ICON", "CANCEL" }, PARTY = { "CANCEL" }, PLAYER = { "CANCEL" }, RAID_PLAYER = { "CANCEL" },
			TARGET = { "SET_FOCUS", "RAID_TARGET_ICON", "CANCEL" },
			FOCUS = { "LOCK_FOCUS_FRAME", "UNLOCK_FOCUS_FRAME", "RAID_TARGET_ICON", "CLEAR_FOCUS", "CANCEL" },
		},
		UnitPopupButtons = {},
		SlashCmdList = {},
		hash_SlashCmdList = {},
		UISpecialFrames = {},
		UIChildWindows = { "GearManagerDialog" },
		NUM_GEARSETS_PER_ROW = 5,
		PLAYERSTAT_DROPDOWN_OPTIONS = { "PLAYERSTAT_BASE_STATS", "PLAYERSTAT_MELEE_COMBAT", "PLAYERSTAT_RANGED_COMBAT",
			"PLAYERSTAT_SPELL_COMBAT", "PLAYERSTAT_DEFENSES" },
		-- the windows' (FriendsFrame.lua, SpellBookFrame.lua, QuestInfo.lua)
		NUM_LFD_CHOICE_BUTTONS = 15, -- LFDFrame.lua
		WHOS_TO_DISPLAY = 17, FRIENDS_FRAME_WHO_HEIGHT = 16, MAX_OBJECTIVES = 10, NUM_FACTIONS_DISPLAYED = 15,
		WHOFRAME_DROPDOWN_LIST = { { name = "Zone", sortType = "zone" }, { name = "Guild", sortType = "guild" },
			{ name = "Race", sortType = "race" } },
		BOOKTYPE_SPELL = "spell", BOOKTYPE_PET = "pet",
		PLAYERSTAT_BASE_STATS = "Base Stats", PLAYERSTAT_MELEE_COMBAT = "Melee", PLAYERSTAT_RANGED_COMBAT = "Ranged",
		PLAYERSTAT_SPELL_COMBAT = "Spell", PLAYERSTAT_DEFENSES = "Defenses",
		EQUIPMENT_MANAGER = "Equipment Manager", ACHIEVEMENTS = "Achievements", OBJECTIVES_TRACKER_LABEL = "Objectives",
		DELETE = "Delete", EQUIPSET_EQUIP = "Equip", SAVE = "Save",
		UIPanelWindows = {},
		COMBAT_TEXT_LOCATIONS = {
			startX = 0, startY = 384, endX = 0, endY = 609,
		},
		COMBAT_TEXT_HEIGHT = 25, COMBAT_TEXT_SCROLLSPEED = 1.9, COMBAT_TEXT_FADEOUT_TIME = 1.3,
		COMBAT_TEXT_SPACING = 10, COMBAT_TEXT_MAX_OFFSET = 130, NUM_COMBAT_TEXT_LINES = 20,
		MICRO_BUTTONS = nil,
		DEFAULT_CHAT_FRAME = nil, SELECTED_CHAT_FRAME = nil, SELECTED_DOCK_FRAME = nil,
		GENERAL_CHAT_DOCK = nil,
		CUSTOM_CLASS_COLORS = nil,
		TOOLTIP_DEFAULT_COLOR = { r = 1, g = 1, b = 1 },
		TOOLTIP_DEFAULT_BACKGROUND_COLOR = { r = 0.09, g = 0.09, b = 0.19 },
		NORMAL_FONT_COLOR = { r = 1, g = 0.82, b = 0 }, HIGHLIGHT_FONT_COLOR = { r = 1, g = 1, b = 1 },
		RED_FONT_COLOR = { r = 1, g = 0.1, b = 0.1 }, GREEN_FONT_COLOR = { r = 0.1, g = 1, b = 0.1 },
		GRAY_FONT_COLOR = { r = 0.5, g = 0.5, b = 0.5 }, YELLOW_FONT_COLOR = { r = 1, g = 1, b = 0 },
		NORMAL_FONT_COLOR_CODE = "|cffffd200", HIGHLIGHT_FONT_COLOR_CODE = "|cffffffff",
		RED_FONT_COLOR_CODE = "|cffff2020", GREEN_FONT_COLOR_CODE = "|cff20ff20",
		GRAY_FONT_COLOR_CODE = "|cff808080", FONT_COLOR_CODE_CLOSE = "|r",
		STANDARD_TEXT_FONT = "Fonts\\FRIZQT__.TTF", UNIT_NAME_FONT = "Fonts\\FRIZQT__.TTF",
		DAMAGE_TEXT_FONT = "Fonts\\FRIZQT__.TTF", NAMEPLATE_FONT = "Fonts\\FRIZQT__.TTF",
		COPPER_PER_SILVER = 100, SILVER_PER_GOLD = 100, COPPER_PER_GOLD = 10000,
		SECONDS_PER_MIN = 60, SECONDS_PER_HOUR = 3600, SECONDS_PER_DAY = 86400,
		GOLD_AMOUNT = "%dg", SILVER_AMOUNT = "%ds", COPPER_AMOUNT = "%dc",
		SELL_PRICE = "Sell Price", CURRENTLY_EQUIPPED = "Currently Equipped", ARMOR = "Armor",
		ITEM_MOD_DAMAGE_PER_SECOND_SHORT = "Damage Per Second", ITEM_SOULBOUND = "Soulbound",
		ITEM_BIND_ON_PICKUP = "Binds when picked up", ITEM_BIND_ON_EQUIP = "Binds when equipped",
		ITEM_BIND_ON_USE = "Binds when used", ITEM_BIND_TO_ACCOUNT = "Binds to account",
		ITEM_ACCOUNTBOUND = "Account Bound", ITEM_BIND_QUEST = "Quest Item", ITEM_UNIQUE = "Unique",
		ITEM_UNIQUE_EQUIPPABLE = "Unique-Equipped",
		-- UI strings whose placeholders the addon depends on
		UNIT_LEVEL_TEMPLATE = "Level %s", UNIT_TYPE_LEVEL_TEMPLATE = "Level %s %s",
		UNIT_PLUS_LEVEL_TEMPLATE = "Level %s Elite", UNIT_TYPE_PLUS_LEVEL_TEMPLATE = "Level %s Elite %s",
		UNIT_LEVEL_DEAD_TEMPLATE = "Level %s (Dead)", FRIENDS_LEVEL_TEMPLATE = "Level %d %s",
		ITEM_LEVEL = "Item Level %d", TALENTS = "Talents", LEVEL = "Level", DEAD = "Dead",
		PLAYER_OFFLINE = "Offline", AFK = "AFK", DND = "DND", ELITE = "Elite", NONE = "None",
		HAVE_MAIL = "You have unread mail", HAVE_MAIL_FROM = "Unread mail from:",
		RANDOM_ROLL_RESULT = "%s rolls %d (%d-%d)",
		FPS_ABBR = "fps", MILLISECONDS_ABBR = "ms", YOU = "You", CLOSE = "Close", CONTINUED = "...", GROUP = "Group",
		FACTION_ALLIANCE = "Alliance", FACTION_HORDE = "Horde", PVP_ENABLED = "PvP",
		SPELL_TIME_REMAINING_DAYS = "%d |4day:days; remaining", SPELL_TIME_REMAINING_HOURS = "%d |4hour:hours; remaining",
		SPELL_TIME_REMAINING_MIN = "%d |4minute:minutes; remaining", SPELL_TIME_REMAINING_SEC = "%d |4second:seconds; remaining",
		CONTAINER_SLOTS = "%d Slot %s", DPS_TEMPLATE = "(%.1f damage per second)", ARMOR_TEMPLATE = "%d Armor",
		DURABILITY_TEMPLATE = "Durability %d / %d", ITEM_CLASSES_ALLOWED = "Classes: %s",
		ITEM_UNIQUE_MULTIPLE = "Unique (%d)", ITEM_LIMIT_CATEGORY = "Unique: %s (%d)",
		ITEM_LIMIT_CATEGORY_MULTIPLE = "Unique-Equipped: %s (%d)", ITEM_MIN_LEVEL = "Requires Level %d",
		ITEM_LEVEL_RANGE = "Requires level %d to %d", ITEM_LEVEL_RANGE_CURRENT = "Requires level %d to %d (%d)",
		ITEM_MIN_SKILL = "Requires %s (%d)", ITEM_REQ_SKILL = "Requires %s", ITEM_REQ_REPUTATION = "Requires %s - %s",
		ITEM_REQ_ARENA_RATING = "Requires personal and team arena rating of %d",
		ERR_QUEST_ADD_KILL_SII = "%s slain: %d/%d", ERR_QUEST_ADD_ITEM_SII = "%s: %d/%d",
		ERR_QUEST_ADD_FOUND_SII = "%s: %d/%d", ERR_QUEST_ADD_PLAYER_KILL_SII = "Players slain: %d/%d",
		ERR_QUEST_OBJECTIVE_COMPLETE_S = "%s (Complete)", ERR_QUEST_COMPLETE_S = "%s completed.",
		ERR_QUEST_ACCEPTED_S = "Quest accepted: %s", ERR_QUEST_FAILED_S = "%s failed.",
		ERR_QUEST_REWARD_EXP_I = "Experience gained: %d.", ERR_QUEST_REWARD_MONEY_S = "Received %s.",
		ERR_QUEST_REWARD_ITEM_S = "Received item: %s.", ERR_QUEST_REWARD_ITEM_MULT_IS = "Received %d of item: %s.",
		ERR_KILLED_BY_S = "%s has slain you.", ERR_USE_LOCKED_WITH_ITEM_S = "Requires %s",
		ERR_USE_LOCKED_WITH_SPELL_S = "Requires %s", ERR_USE_LOCKED_WITH_SPELL_KNOWN_SI = "Requires %s %d",
		ERR_USE_PREVENTED_BY_MECHANIC_S = "Can't do that while %s",
		ERR_ATTACK_PREVENTED_BY_MECHANIC_S = "Can't attack while %s",
		ERR_QUEST_FAILED_BAG_FULL_S = "%s failed: Inventory is full.", ERR_QUEST_FAILED_MAX_COUNT_S = "%s failed: max count",
		ERR_QUEST_FORCE_REMOVED_S = "The quest %s has been removed from your quest log.",
		ERR_QUEST_FAILED_TOO_MANY_DAILY_QUESTS_I = "You have completed %d daily quests today",
		SPELL_FAILED_CASTER_AURASTATE = "You can't do that yet", SPELL_EQUIPPED_ITEM = "Requires %s",
		SPELL_EQUIPPED_ITEM_NOSPACE = "Requires %s", SPELL_REQUIRED_FORM = "Must be in %s",
		SPELL_REQUIRED_FORM_NOSPACE = "Must be in %s", LOCKED_WITH_ITEM = "Requires %s",
		LOCKED_WITH_SPELL = "Requires %s", LOCKED_WITH_SPELL_KNOWN = "Requires %s",
		TIMEMANAGER_AM = "AM", TIMEMANAGER_PM = "PM", TIMEMANAGER_TOOLTIP_LOCALTIME = "Local Time:",
		TIMEMANAGER_TOOLTIP_REALMTIME = "Realm Time:", TIMEMANAGER_TOOLTIP_TITLE = "Time Info",
		GAMETIME_TOOLTIP_TOGGLE_CALENDAR = "Click to toggle the calendar.",
		MBB_TOOLTIP1 = nil,
		SLASH_RELOADUI1 = nil,
	}
	for class, color in pairs(CLASS_COLORS) do
		c.RAID_CLASS_COLORS[class] = { r = color[1], g = color[2], b = color[3], colorStr = color[4] }
		c.CLASS_ICON_TCOORDS[class] = { 0, 0.25, 0, 0.25 }
		c.LOCALIZED_CLASS_NAMES_MALE[class] = class:sub(1, 1) .. class:sub(2):lower()
		c.LOCALIZED_CLASS_NAMES_FEMALE[class] = c.LOCALIZED_CLASS_NAMES_MALE[class]
	end
	for quality = 0, 7 do
		local colors = {
			[0] = { 0.62, 0.62, 0.62, "|cff9d9d9d" }, { 1, 1, 1, "|cffffffff" }, { 0.12, 1, 0, "|cff1eff00" },
			{ 0, 0.44, 0.87, "|cff0070dd" }, { 0.64, 0.21, 0.93, "|cffa335ee" }, { 1, 0.5, 0, "|cffff8000" },
			{ 0.9, 0.8, 0.5, "|cffe6cc80" }, { 0.9, 0.8, 0.5, "|cffe6cc80" },
		}
		local q = colors[quality]
		c.ITEM_QUALITY_COLORS[quality] = { r = q[1], g = q[2], b = q[3], hex = q[4] }
	end
	for _, chatType in ipairs({ "SYSTEM", "SAY", "PARTY", "RAID", "GUILD", "WHISPER", "YELL", "CHANNEL", "EMOTE", "RAID_WARNING" }) do
		c.ChatTypeInfo[chatType] = { r = 1, g = 1, b = 1, id = 1, sticky = 0 }
	end
	return c
end

-- ALL CAPS globals that read nil in the client (the fallback would make
-- them a string).
local NIL_CAPS = {
	CUSTOM_CLASS_COLORS = true, MBB_TOOLTIP1 = true, SLASH_RELOADUI1 = true, SLASH_RELOADUI2 = true,
	UIDROPDOWNMENU_VALUE_PATCH_VERSION = true, LE_PARTY_CATEGORY_HOME = true, MICRO_BUTTONS = true,
	DEFAULT_CHAT_FRAME = true, SELECTED_CHAT_FRAME = true, SELECTED_DOCK_FRAME = true,
	GENERAL_CHAT_DOCK = true, ACTION_BUTTON_SHOW_GRID_REASON_CVAR = true, NUM_LE_BAG_FILTER_FLAGS = true,
	MAX_ACCOUNT_MACROS = true, PLAYER_FRAME_UNLOCKED = true,
}
Blizzard.NIL_CAPS = NIL_CAPS

------------------------------------------------------------------------
-- Fonts
------------------------------------------------------------------------

local FONTS = {
	"GameFontNormal", "GameFontHighlight", "GameFontNormalSmall", "GameFontHighlightSmall", "GameFontHighlightSmallLeft",
	"GameFontNormalLarge", "GameFontHighlightLarge", "GameFontDisable", "GameFontDisableSmall",
	"GameFontGreen", "GameFontRed", "GameFontWhite", "GameFontBlack", "GameFontNormalHuge",
	"GameTooltipText", "GameTooltipTextSmall", "GameTooltipHeaderText", "NumberFontNormal",
	"NumberFontNormalSmall", "NumberFontNormalLarge", "NumberFontNormalHuge", "NumberFont_Normal_Med",
	"NumberFont_Outline_Med", "NumberFont_Outline_Large", "NumberFont_Outline_Huge", "NumberFont_Shadow_Med",
	"NumberFont_Shadow_Small", "ChatFontNormal", "ChatFontSmall", "ChatFontLarge", "SystemFont_Small",
	"SystemFont_Med1", "SystemFont_Med2", "SystemFont_Med3", "SystemFont_Large", "SystemFont_Huge1",
	"SystemFont_OutlineThick_Huge2", "SystemFont_OutlineThick_Huge4", "SystemFont_OutlineThick_WTF",
	"SystemFont_Shadow_Small", "SystemFont_Shadow_Med1", "SystemFont_Shadow_Med3", "SystemFont_Shadow_Large",
	"SystemFont_Shadow_Huge1", "SystemFont_Tiny", "SystemFont_Outline_Small", "SystemFont_InverseShadow_Large",
	"QuestFont", "QuestFont_Large", "QuestFont_Shadow_Huge", "QuestFont_Shadow_Small", "QuestFontNormalSmall",
	"QuestFontHighlight", "QuestTitleFont", "QuestTitleFontBlackShadow", "FriendsFont_Normal", "FriendsFont_Large",
	"FriendsFont_Small", "FriendsFont_UserText", "MailFont_Large", "SpellFont_Small", "InvoiceFont_Med",
	"InvoiceFont_Small", "ReputationDetailFont", "AchievementFont_Small", "CombatTextFont", "CombatLogFont",
	"ErrorFont", "TextStatusBarText", "TextStatusBarTextLarge", "ZoneTextFont", "SubZoneTextFont",
	"PVPInfoTextFont", "WorldMapTextFont", "DialogButtonNormalText", "DialogButtonHighlightText",
	"GameFontNormalLeft", "GameFontHighlightLeft", "GameFontNormalMed3", "BossEmoteNormalHuge",
	"NumberFontNormalRightRed", "NumberFontNormalYellow", "CombatTextFontOutline", "MovieSubtitleFont",
	"Tooltip_Med", "Tooltip_Small", "GameFont_Gigantic", "Game13Font", "Game15Font",
}

------------------------------------------------------------------------
-- Frames
------------------------------------------------------------------------

local client -- the client being installed

local function new(widgetType, name, parent, templates)
	return Widgets.new(widgetType, name, parent, templates)
end

local function hidden(widget)
	state[widget].shown = false
	return widget
end

-- A button with its four state textures, named like FrameXML's.
local function button(widgetType, name, parent, templates)
	local b = new(widgetType or "Button", name, parent, templates)
	local s = state[b]
	s.normalTexture = s.normalTexture or new("Texture", name and (name .. "NormalTexture"), b)
	s.pushedTexture = s.pushedTexture or new("Texture", nil, b)
	s.highlightTexture = s.highlightTexture or new("Texture", nil, b)
	s.disabledTexture = s.disabledTexture or new("Texture", nil, b)
	return b
end

-- A panel's tab (CharacterFrameTabButtonTemplate, AchievementFrameTabButtonTemplate):
-- its art in three, again for when it's chosen, and its text.
local function tab(name, parent, text)
	local t = button("Button", name, parent)
	t:SetSize(115, 32)
	for _, part in ipairs({ "Left", "Middle", "Right", "LeftDisabled", "MiddleDisabled", "RightDisabled" }) do
		new("Texture", name .. part, t)
	end
	t:SetText(text)
	t.text = t:GetFontString()
	return t
end

local function tooltip(name, parent)
	local t = hidden(new("GameTooltip", name, parent or UIParent))
	for i = 1, 8 do
		Widgets.tooltipLine(t, "Left", i)
		Widgets.tooltipLine(t, "Right", i)
	end
	-- GameTooltipTemplate's scripts
	t:SetScript("OnTooltipAddMoney", function(self, cost, maxcost)
		_G.GameTooltip_OnTooltipAddMoney(self, cost, maxcost)
	end)
	t:SetScript("OnTooltipCleared", function(self)
		_G.GameTooltip_ClearMoney(self)
	end)
	return t
end

local function statusBar(name, parent)
	local bar = new("StatusBar", name, parent)
	bar:SetMinMaxValues(0, 1)
	return bar
end

local function unitFrame(name, withSpellbar)
	local frame = new("Button", name, UIParent, "SecureUnitButtonTemplate")
	frame.healthbar = statusBar(name .. "HealthBar", frame)
	frame.manabar = statusBar(name .. "ManaBar", frame)
	if withSpellbar then
		frame.spellbar = statusBar(name .. "SpellBar", frame)
	end
	new("Texture", name .. "Portrait", frame)
	new("FontString", name .. "Name", frame)
	new("Frame", name .. "DropDown", frame, "UIDropDownMenuTemplate")
	return frame
end

local function chatFrame(index)
	local name = "ChatFrame" .. index
	local frame = new("ScrollingMessageFrame", name, UIParent)
	frame:SetID(index)
	if index > 1 then
		hidden(frame)
	end
	frame.isDocked = index <= 2 and 1 or nil
	frame:SetSize(430, 120)
	frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 32, 95)
	for _, texture in ipairs({ "Background", "TopLeftTexture", "BottomLeftTexture", "TopRightTexture",
		"BottomRightTexture", "LeftTexture", "RightTexture", "BottomTexture", "TopTexture" }) do
		new("Texture", name .. texture, frame)
	end
	local buttonFrame = new("Frame", name .. "ButtonFrame", frame)
	frame.buttonFrame = buttonFrame
	for _, texture in ipairs({ "Background", "TopLeftTexture", "BottomLeftTexture", "TopRightTexture",
		"BottomRightTexture", "LeftTexture", "RightTexture", "BottomTexture", "TopTexture" }) do
		new("Texture", name .. "ButtonFrame" .. texture, buttonFrame)
	end
	for _, b in ipairs({ "UpButton", "DownButton", "BottomButton", "MinimizeButton" }) do
		button("Button", name .. "ButtonFrame" .. b, buttonFrame)
	end
	button("Button", name .. "ClickAnywhereButton", frame)
	button("Button", name .. "ResizeButton", frame)
	local tab = button("Button", name .. "Tab", UIParent)
	tab:SetID(index)
	for _, texture in ipairs({ "Left", "Middle", "Right", "SelectedLeft", "SelectedMiddle", "SelectedRight",
		"HighlightLeft", "HighlightMiddle", "HighlightRight", "Flash", "Glow", "ConversationIcon" }) do
		new("Texture", name .. "Tab" .. texture, tab)
	end
	local tabText = new("FontString", name .. "TabText", tab)
	state[tab].fontString = tabText
	local editBox = hidden(new("EditBox", name .. "EditBox", frame))
	frame.editBox = editBox
	editBox.chatFrame = frame
	for _, texture in ipairs({ "Left", "Right", "Mid", "FocusLeft", "FocusRight", "FocusMid" }) do
		new("Texture", name .. "EditBox" .. texture, editBox)
	end
	new("FontString", name .. "EditBoxHeader", editBox)
	button("Button", name .. "EditBoxLanguage", editBox)
	_G.CHAT_FRAMES[#_G.CHAT_FRAMES + 1] = name
	return frame
end

local function actionButtons(prefix, parent, count, templates)
	for i = 1, count do
		local b = button("CheckButton", prefix .. i, parent, templates or "ActionBarButtonTemplate, SecureActionButtonTemplate")
		b:SetID(i)
		b.icon = _G[prefix .. i .. "Icon"]
		b.cooldown = _G[prefix .. i .. "Cooldown"]
	end
end

local function staticPopup(index)
	local name = "StaticPopup" .. index
	local popup = hidden(new("Frame", name, UIParent))
	popup:SetID(index)
	popup:SetSize(320, 100)
	if index == 1 then
		popup:SetPoint("TOP", UIParent, "TOP", 0, -135)
	else
		popup:SetPoint("TOP", _G["StaticPopup" .. (index - 1)], "BOTTOM")
	end
	popup.text = new("FontString", name .. "Text", popup)
	for i = 1, 3 do
		popup["button" .. i] = button("Button", name .. "Button" .. i, popup, "UIPanelButtonTemplate")
	end
	popup.editBox = hidden(new("EditBox", name .. "EditBox", popup))
	-- its chat input border: nameless left and right textures
	new("Texture", nil, popup.editBox):SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Left]])
	new("Texture", nil, popup.editBox):SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Right]])
	-- and a texture of its own (as the client's text selection is)
	new("Texture", nil, popup.editBox):SetTexture([[Interface\Buttons\WHITE8X8]])
	popup.wideEditBox = hidden(new("EditBox", name .. "WideEditBox", popup))
	popup.moneyFrame = hidden(new("Frame", name .. "MoneyFrame", popup))
	popup.moneyInputFrame = hidden(new("Frame", name .. "MoneyInputFrame", popup))
	popup.itemFrame = hidden(new("Button", name .. "ItemFrame", popup))
	new("Texture", name .. "AlertIcon", popup)
	button("Button", name .. "CloseButton", popup)
	return popup
end

local function dropDownList(index)
	local name = "DropDownList" .. index
	local list = hidden(new("Button", name, UIParent))
	list:SetID(index)
	new("Frame", name .. "Backdrop", list)
	new("Frame", name .. "MenuBackdrop", list)
	for i = 1, 32 do
		local b = button("Button", name .. "Button" .. i, list)
		b:SetID(i)
		new("FontString", name .. "Button" .. i .. "NormalText", b)
		new("Texture", name .. "Button" .. i .. "Icon", b)
		new("Texture", name .. "Button" .. i .. "Check", b)
		new("Texture", name .. "Button" .. i .. "Highlight", b)
		hidden(button("Button", name .. "Button" .. i .. "ExpandArrow", b))
	end
	return list
end

-- A character window tab's panel art: its unnamed corner textures.
local function panelArt(frame, prefix, parts)
	for _, part in ipairs(parts) do
		new("Texture", nil, frame):SetTexture([[Interface\]] .. prefix .. part)
	end
end

local function itemButton(name, parent, templates)
	local b = button("Button", name, parent, templates or "ItemButtonTemplate")
	new("Texture", name .. "IconQuestTexture", b)
	new("Cooldown", name .. "Cooldown", b)
	return b
end

-- The windows' frames as Blizzard's FrameXML makes them
-- (tests/data/framexml.lua, generated from it by tests/tools/framexml.py):
-- what's not made by hand above is made from it, under the frames made by
-- hand when there are some. `addon`: a load-on-demand addon's, or nil.
local FRAMEXML
local BUTTON_ROLES = {
	normal = "normalTexture", pushed = "pushedTexture", disabled = "disabledTexture", highlight = "highlightTexture",
	checked = "checkedTexture", disabledChecked = "disabledCheckedTexture", thumb = "thumb", bar = "barTexture",
	text = "fontString",
}
local function fromFrameXML(addon)
	FRAMEXML = FRAMEXML or dofile("tests/data/framexml.lua")
	local entries = FRAMEXML[addon or ""]
	if not entries then
		return
	end
	local made, fresh = {}, {}
	for _, entry in ipairs(entries) do
		local id, kind, name, parent, size, anchor, file, text, hide, layer, role, number = unpack(entry, 1, 12)
		local owner = (type(parent) == "number") and made[parent] or rawget(_G, parent)
		local object = name and rawget(_G, name)
		local key = role and BUTTON_ROLES[role]
		if (not object) and owner and key and state[owner][key] then
			object = state[owner][key] -- the art the hand-made button has
		end
		if (not object) and owner then
			object = new(Widgets.isType(kind) and kind or "Frame", name, owner)
			fresh[#fresh + 1] = { object, owner, size, anchor }
			if key then
				state[owner][key] = object
			elseif (role == "scrollChild") then
				owner:SetScrollChild(object)
			end
			if file and object.SetTexture then
				object:SetTexture(file)
			end
			if layer and object.SetDrawLayer then
				object:SetDrawLayer(layer)
			end
			if text and object.SetText then
				local value = rawget(_G, text)
				object:SetText((type(value) == "string") and value or text)
			end
			if hide then
				hidden(object)
			end
			if number and object.SetID then
				object:SetID(number)
			end
		end
		made[id] = object
	end
	for _, each in ipairs(fresh) do
		local object, owner, size, anchor = unpack(each, 1, 4)
		if size then
			if size[1] and size[1] > 0 then
				object:SetWidth(size[1])
			end
			if size[2] and size[2] > 0 then
				object:SetHeight(size[2])
			end
		end
		if anchor then
			local relative = anchor[2] and rawget(_G, anchor[2]) or owner
			object:SetPoint(anchor[1], relative, anchor[3], anchor[4], anchor[5])
		end
	end
end

-- Auctionator in the auction house (its own code isn't run): its page from
-- its XML (Atr_AddMainPanel's), its three tabs after Blizzard's
-- (Atr_AddSellTab's), and its tabs' click (Atr_AuctionFrameTab_OnClick, in
-- place of Blizzard's) showing its page with the parts it shows on each:
-- Buy, its search and the shopping lists; Sell, an item picked (its selling
-- column, the recommended price, its results); More, the history and Check
-- for Undercuts. Made as the auction house loads (an addon's onLoad).
local AUCTIONATOR_PARTS = {
	{ "Atr_Hlist", "Atr_Hlist_ScrollFrame", "Atr_Search_Box", "Atr_Search_Button", "Atr_Adv_Search_Button",
		"Atr_AddToSListButton", "Atr_RemFromSListButton", "Atr_NewSListButton", "Atr_MngSListsButton",
		"Atr_SrchSListButton", "Atr_DropDownSL", "Atr_HeadingsBar", "Atr_ListTabs" },
	{ "Atr_SellControls", "Atr_HeadingsBar", "Atr_ListTabs", "Atr_Recommend_Text", "Atr_Recommend_Basis_Text",
		"Atr_RecommendPerStack_Text", "Atr_RecommendPerItem_Text", "Atr_RecommendItem_Tex" },
	{ "Atr_Hlist", "Atr_Hlist_ScrollFrame", "Atr_ActiveItems_Text", "Atr_CheckActiveButton", "Atr_HeadingsBar",
		"Atr_ListTabs" },
}
function Blizzard.Auctionator()
	fromFrameXML("Auctionator")
	local frame = _G.AuctionFrame
	for i, text in ipairs({ "Buy", "Sell", "More..." }) do
		local n = 3 + i
		-- (AuctionTabTemplate's: its art, its text)
		local tab = new("Button", "AuctionFrameTab" .. n, frame)
		for _, part in ipairs({ "Left", "Middle", "Right", "LeftDisabled", "MiddleDisabled", "RightDisabled" }) do
			new("Texture", "AuctionFrameTab" .. n .. part, tab)
		end
		tab:SetFontString(new("FontString", "AuctionFrameTab" .. n .. "Text", tab))
		tab:SetID(n)
		tab:SetText(text)
		tab:SetSize(10, 32)
		tab:SetPoint("LEFT", _G["AuctionFrameTab" .. (n - 1)], "RIGHT", -8, 0)
	end
	frame.numTabs = 6
	local all = {}
	for _, names in ipairs(AUCTIONATOR_PARTS) do
		for _, name in ipairs(names) do
			all[name] = true
		end
	end
	local blizzard = _G.AuctionFrameTab_OnClick
	_G.AuctionFrameTab_OnClick = function(self)
		local index = self:GetID()
		_G.Atr_Main_Panel:Hide()
		blizzard(self)
		if (index > 3) then
			for name in pairs(all) do
				_G[name]:Hide()
			end
			for _, name in ipairs(AUCTIONATOR_PARTS[index - 3]) do
				_G[name]:Show()
			end
			-- (the history shorter over the shopping lists' buttons)
			local height = (index == 4) and 252 or 335
			_G.Atr_Hlist:SetHeight(height)
			_G.Atr_Hlist_ScrollFrame:SetHeight(height)
			_G.Atr_Main_Panel:Show()
		end
	end
end

local function buildFrames()
	local UIParent = _G.UIParent

	-- tooltips
	for _, name in ipairs({ "GameTooltip", "ItemRefTooltip", "ShoppingTooltip1", "ShoppingTooltip2",
		"ShoppingTooltip3", "ItemRefShoppingTooltip1", "ItemRefShoppingTooltip2", "ItemRefShoppingTooltip3",
		"WorldMapTooltip" }) do
		tooltip(name)
	end
	_G.GameTooltip.shoppingTooltips = { _G.ShoppingTooltip1, _G.ShoppingTooltip2, _G.ShoppingTooltip3 }
	_G.ItemRefTooltip.shoppingTooltips = { _G.ItemRefShoppingTooltip1, _G.ItemRefShoppingTooltip2, _G.ItemRefShoppingTooltip3 }
	button("Button", "ItemRefCloseButton", _G.ItemRefTooltip)
	new("StatusBar", "GameTooltipStatusBar", _G.GameTooltip):SetMinMaxValues(0, 1)
	_G.GameTooltip.statusBar = _G.GameTooltipStatusBar
	new("Frame", "GameTooltipMoneyFrame1", _G.GameTooltip)
	local friendsTooltip = hidden(new("Frame", "FriendsTooltip", UIParent))
	friendsTooltip:SetFrameStrata("TOOLTIP")
	local small = hidden(new("Frame", "SmallTextTooltip", UIParent))
	new("FontString", "SmallTextTooltipText", small)
	for i = 1, 2 do
		dropDownList(i)
	end

	-- chat
	local dock = new("Frame", "GeneralDockManager", UIParent)
	dock.DOCKED_CHAT_FRAMES = {}
	dock.primary = nil
	_G.GENERAL_CHAT_DOCK = dock
	for i = 1, 10 do
		local frame = chatFrame(i)
		if frame.isDocked then
			table.insert(dock.DOCKED_CHAT_FRAMES, frame)
		end
	end
	dock.primary = _G.ChatFrame1
	dock.selected = _G.ChatFrame1
	_G.DEFAULT_CHAT_FRAME = _G.ChatFrame1
	_G.SELECTED_CHAT_FRAME = _G.ChatFrame1
	_G.SELECTED_DOCK_FRAME = _G.ChatFrame1
	local menuButton = button("Button", "ChatFrameMenuButton", UIParent)
	menuButton:SetPoint("BOTTOM", _G.ChatFrame1ButtonFrameUpButton, "TOP")
	new("Frame", "ChatMenu", UIParent)
	new("Frame", "EmoteMenu", _G.ChatMenu)
	new("Frame", "LanguageMenu", _G.ChatMenu)
	new("Frame", "VoiceMacroMenu", _G.ChatMenu)
	button("Button", "FriendsMicroButton", UIParent) -- the chat's friends button (3.3.5)
	new("Frame", "ChatFrameEditBoxGlow", nil)

	-- action bars
	local mainMenuBar = new("Frame", "MainMenuBar", UIParent)
	local art = new("Frame", "MainMenuBarArtFrame", mainMenuBar)
	actionButtons("ActionButton", art, 12)
	for _, bar in ipairs({ "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarLeft", "MultiBarRight" }) do
		local frame = new("Frame", bar, UIParent)
		actionButtons(bar .. "Button", frame, 12)
	end
	local bonus = hidden(new("Frame", "BonusActionBarFrame", mainMenuBar))
	actionButtons("BonusActionButton", bonus, 12)
	local shapeshift = new("Frame", "ShapeshiftBarFrame", mainMenuBar)
	for _, part in ipairs({ "Left", "Middle", "Right" }) do
		new("Texture", "ShapeshiftBar" .. part, shapeshift)
	end
	actionButtons("ShapeshiftButton", shapeshift, 10, "ShapeshiftButtonTemplate")
	local petBar = hidden(new("Frame", "PetActionBarFrame", UIParent))
	actionButtons("PetActionButton", petBar, 10, "PetActionButtonTemplate")
	local possess = hidden(new("Frame", "PossessBarFrame", UIParent))
	actionButtons("PossessButton", possess, 2, "SecureActionButtonTemplate, ActionButtonTemplate")
	hidden(new("Frame", "VehicleMenuBar", UIParent))
	statusBar("MainMenuExpBar", mainMenuBar)
	hidden(new("Frame", "MainMenuBarMaxLevelBar", mainMenuBar))
	local rep = new("Frame", "ReputationWatchBar", mainMenuBar)
	statusBar("ReputationWatchStatusBar", rep)
	local perf = button("Button", "MainMenuBarPerformanceBarFrame", mainMenuBar)
	new("Texture", "MainMenuBarPerformanceBar", perf)
	local multicast = hidden(new("Frame", "MultiCastActionBarFrame", UIParent))
	button("Button", "MultiCastRecallSpellButton", multicast)
	button("Button", "MultiCastSummonSpellButton", multicast)
	for _, name in ipairs({ "CharacterMicroButton", "SpellbookMicroButton", "TalentMicroButton",
		"AchievementMicroButton", "QuestLogMicroButton", "SocialsMicroButton", "PVPMicroButton",
		"LFDMicroButton", "MainMenuMicroButton", "HelpMicroButton" }) do
		local micro = button("Button", name, mainMenuBar)
		-- MainMenuBarMicroButton's tooltip scripts
		micro:SetScript("OnEnter", function(self)
			_G.GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			_G.GameTooltip:SetText(name)
		end)
		micro:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
	end
	new("Texture", "MicroButtonPortrait", _G.CharacterMicroButton)
	new("Texture", "PVPMicroButtonTexture", _G.PVPMicroButton)
	new("Texture", "MainMenuBarDownload", _G.MainMenuMicroButton)
	itemButton("MainMenuBarBackpackButton", mainMenuBar)
	for i = 0, 3 do
		itemButton("CharacterBag" .. i .. "Slot", mainMenuBar)
	end
	button("CheckButton", "KeyRingButton", mainMenuBar)
	hidden(new("Frame", "TutorialFrame", UIParent))
	button("Button", "TutorialFrameAlertButton", UIParent)

	-- unit frames
	local player = unitFrame("PlayerFrame", false)
	player.unit = "player"
	unitFrame("PetFrame")
	local target = unitFrame("TargetFrame", true)
	target.unit = "target"
	unitFrame("TargetFrameToT")
	local focus = unitFrame("FocusFrame", true)
	focus.unit = "focus"
	unitFrame("TargetofFocusFrame")
	new("Frame", "ComboFrame", UIParent)
	for i = 1, 4 do
		unitFrame("PartyMemberFrame" .. i)
		unitFrame("Boss" .. i .. "TargetFrame", true)
		unitFrame("PartyMemberFrame" .. i .. "PetFrame")
	end
	new("Frame", "PartyMemberBackground", UIParent)
	local castbar = hidden(statusBar("CastingBarFrame", UIParent))
	new("FontString", "CastingBarFrameText", castbar)
	new("Texture", "CastingBarFrameIcon", castbar)
	hidden(statusBar("PetCastingBarFrame", UIParent))
	new("Frame", "RuneFrame", player)
	new("Frame", "TotemFrame", player)

	-- auras and misc HUD
	new("Frame", "BuffFrame", UIParent)
	new("Frame", "TemporaryEnchantFrame", UIParent)
	hidden(new("Button", "ConsolidatedBuffs", _G.BuffFrame))
	hidden(new("Frame", "DurabilityFrame", UIParent))
	for _, slot in ipairs({ "Head", "Shoulders", "Chest", "Waist", "Legs", "Feet", "Wrists", "Hands", "Weapon",
		"Shield", "Ranged" }) do
		new("Texture", "Durability" .. slot, _G.DurabilityFrame)
	end
	hidden(new("Frame", "VehicleSeatIndicator", UIParent))
	new("Texture", "VehicleSeatIndicatorBackgroundTexture", _G.VehicleSeatIndicator)
	for i = 1, 6 do
		button("Button", "VehicleSeatIndicatorButton" .. i, _G.VehicleSeatIndicator)
	end
	local watch = new("Frame", "WatchFrame", UIParent)
	new("Frame", "WatchFrameLines", watch)
	new("Frame", "WatchFrameHeader", watch)
	new("FontString", "WatchFrameTitle", watch)
	button("Button", "WatchFrameCollapseExpandButton", watch)
	new("Frame", "WorldStateAlwaysUpFrame", UIParent)
	new("Frame", "WorldStateCaptureBar1", UIParent)
	new("MessageFrame", "UIErrorsFrame", UIParent)
	new("MessageFrame", "RaidWarningFrame", UIParent)
	new("MessageFrame", "RaidBossEmoteFrame", UIParent)
	new("Frame", "ZoneTextFrame", UIParent)
	new("FontString", "ZoneTextString", _G.ZoneTextFrame)
	new("Frame", "SubZoneTextFrame", UIParent)
	new("FontString", "SubZoneTextString", _G.SubZoneTextFrame)
	new("Frame", "AutoFollowStatus", UIParent)
	for i = 1, 3 do
		local timer = hidden(new("Frame", "MirrorTimer" .. i, UIParent))
		new("FontString", "MirrorTimer" .. i .. "Text", timer)
		statusBar("MirrorTimer" .. i .. "StatusBar", timer)
		new("Texture", "MirrorTimer" .. i .. "Border", timer)
		timer.timer = nil
	end
	hidden(new("Frame", "LevelUpDisplay", UIParent))

	-- loot, bags, bank
	local loot = hidden(new("Frame", "LootFrame", UIParent))
	for _, event in ipairs({ "LOOT_OPENED", "LOOT_SLOT_CLEARED", "LOOT_CLOSED" }) do
		loot:RegisterEvent(event)
	end
	for i = 1, 4 do
		local b = button("Button", "LootButton" .. i, loot, "LootButtonTemplate")
		b:SetID(i)
	end
	button("Button", "LootFrameUpButton", loot)
	button("Button", "LootFrameDownButton", loot)
	button("Button", "LootCloseButton", loot)
	new("Texture", "LootFramePortraitOverlay", loot)
	for i = 1, 13 do
		local container = hidden(new("Frame", "ContainerFrame" .. i, UIParent))
		container:SetID(i)
		new("FontString", "ContainerFrame" .. i .. "Name", container)
		new("Texture", "ContainerFrame" .. i .. "Portrait", container)
		button("Button", "ContainerFrame" .. i .. "PortraitButton", container)
		button("Button", "ContainerFrame" .. i .. "CloseButton", container)
		new("Frame", "ContainerFrame" .. i .. "MoneyFrame", container)
		for j = 1, 36 do
			local item = itemButton("ContainerFrame" .. i .. "Item" .. j, container)
			item:SetID(j)
		end
	end
	local bank = hidden(new("Frame", "BankFrame", UIParent))
	for i = 1, 28 do
		itemButton("BankFrameItem" .. i, bank):SetID(i)
	end
	for i = 1, 7 do
		itemButton("BankFrameBag" .. i, bank):SetID(i)
	end

	-- popups, menus, options
	for i = 1, 4 do
		staticPopup(i)
	end
	local gameMenu = hidden(new("Frame", "GameMenuFrame", UIParent))
	new("Texture", "GameMenuFrameHeader", gameMenu)
	new("FontString", "GameMenuFrameHeaderText", gameMenu)
	for _, name in ipairs({ "Options", "SoundOptions", "UIOptions", "Keybindings", "Macros",
		"MacOptions", "Ratings", "Logout", "Quit", "Continue" }) do
		button("Button", "GameMenuButton" .. name, gameMenu, "UIPanelButtonTemplate")
	end
	_G.GameMenuButtonRatings:Hide() -- shown in Korea only
	local options = hidden(new("Frame", "InterfaceOptionsFrame", UIParent))
	options.lastFrame = nil
	options:SetSize(648, 520) -- InterfaceOptionsFrame.xml
	options:SetPoint("CENTER")
	local container = new("Frame", "InterfaceOptionsFramePanelContainer", options)
	-- right of the 175x429 category list at (22, -40), 16 apart: 413x428
	container:SetPoint("TOPLEFT", options, "TOPLEFT", 22 + 175 + 16, -40)
	container:SetPoint("BOTTOMRIGHT", options, "BOTTOMRIGHT", -22, 520 - 40 - 428)
	new("Frame", "InterfaceOptionsFrameCategories", options)
	for i = 1, 31 do
		button("Button", "InterfaceOptionsFrameCategoriesButton" .. i, _G.InterfaceOptionsFrameCategories)
	end
	button("Button", "InterfaceOptionsFrameOkay", options, "UIPanelButtonTemplate")
	button("Button", "InterfaceOptionsFrameCancel", options, "UIPanelButtonTemplate")
	for _, name in ipairs({ "Controls", "Combat", "Display", "Objectives", "Social", "ActionBars", "Names",
		"CombatText", "StatusText", "Party", "UnitFrame", "Camera", "Mouse", "Help", "Buffs", "Features" }) do
		local panel = hidden(new("Frame", "InterfaceOptions" .. name .. "Panel", _G.InterfaceOptionsFramePanelContainer))
		panel.name = name
	end
	for _, name in ipairs({ "InterfaceOptionsCombatPanelTargetOfTarget",
		"InterfaceOptionsCombatPanelEnemyCastBars", "InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait",
		"InterfaceOptionsDisplayPanelShowFreeBagSpace", "InterfaceOptionsUnitFramePanelPartyBackground",
		"InterfaceOptionsActionBarsPanelBottomLeft", "InterfaceOptionsActionBarsPanelBottomRight",
		"InterfaceOptionsActionBarsPanelRight", "InterfaceOptionsActionBarsPanelRightTwo",
		"InterfaceOptionsActionBarsPanelAlwaysShowActionBars", "InterfaceOptionsBuffsPanelConsolidateBuffs" }) do
		local panelName = name:match("^(InterfaceOptions%u%l+%a-Panel)")
		new("CheckButton", name, _G[panelName] or _G.InterfaceOptionsCombatPanel, "InterfaceOptionsCheckButtonTemplate")
	end
	new("Frame", "InterfaceOptionsCombatPanelTOTDropDown", _G.InterfaceOptionsCombatPanel, "UIDropDownMenuTemplate")
	new("Frame", "InterfaceOptionsCombatPanelSelfCastKeyDropDown", _G.InterfaceOptionsCombatPanel, "UIDropDownMenuTemplate")
	local video = hidden(new("Frame", "VideoOptionsFrame", UIParent))
	new("Frame", "VideoOptionsResolutionPanel", video)
	new("CheckButton", "VideoOptionsResolutionPanelUseUIScale", _G.VideoOptionsResolutionPanel, "OptionsCheckButtonTemplate")
	new("Slider", "VideoOptionsResolutionPanelUIScaleSlider", _G.VideoOptionsResolutionPanel, "OptionsSliderTemplate")
	button("Button", "VideoOptionsFrameOkay", video, "UIPanelButtonTemplate")
	button("Button", "VideoOptionsFrameApply", video, "UIPanelButtonTemplate")
	button("Button", "VideoOptionsFrameCancel", video, "UIPanelButtonTemplate")
	hidden(new("Frame", "AudioOptionsFrame", UIParent))
	hidden(new("Frame", "KeyBindingFrame", UIParent))

	-- panels
	local character = hidden(new("Frame", "CharacterFrame", UIParent))
	character:SetSize(384, 512)
	character:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -104)
	new("Texture", "CharacterFramePortrait", character)
	button("Button", "CharacterFrameCloseButton", character, "UIPanelCloseButton")
	new("FontString", "CharacterNameText", character)
	new("FontString", "CharacterLevelText", character)
	new("FontString", "CharacterGuildText", character)
	-- each from the one before (CharacterFrame.xml)
	for i, text in ipairs({ "Character", "Pet", "Reputation", "Skills", "Currency" }) do
		local t = tab("CharacterFrameTab" .. i, character, text)
		if (i == 1) then
			t:SetPoint("BOTTOMLEFT", character, "BOTTOMLEFT", 11, 46)
		else
			t:SetPoint("LEFT", _G["CharacterFrameTab" .. (i - 1)], "RIGHT", -15, 0)
		end
	end
	character.numTabs = 5
	local model = new("PlayerModel", "CharacterModelFrame", character)
	button("Button", "CharacterModelFrameRotateLeftButton", model)
	button("Button", "CharacterModelFrameRotateRightButton", model)
	local paperDoll = new("Frame", "PaperDollFrame", character)
	panelArt(paperDoll, "PaperDollInfoFrame\\UI-Character-CharacterTab-", { "L1", "R1", "BottomLeft", "BottomRight" })
	-- the stats' boxes, two columns
	local attributes = new("Frame", "CharacterAttributesFrame", paperDoll)
	for _, side in ipairs({ "Left", "Right" }) do
		for _, part in ipairs({ "Top", "Middle", "Bottom" }) do
			new("Texture", "PlayerStat" .. side .. part, attributes):SetTexture([[Interface\PaperDollInfoFrame\UI-Character-StatBackground]])
		end
	end
	for _, slot in ipairs({ "Head", "Neck", "Shoulder", "Back", "Chest", "Shirt", "Tabard", "Wrist", "Hands",
		"Waist", "Legs", "Feet", "Finger0", "Finger1", "Trinket0", "Trinket1", "MainHand", "SecondaryHand",
		"Ranged", "Ammo" }) do
		itemButton("Character" .. slot .. "Slot", paperDoll)
	end
	-- the ammo slot's frame art (PaperDollFrame.xml)
	new("Texture", nil, _G.CharacterAmmoSlot):SetTexture("Interface\\PaperdollInfoFrame\\UI-Character-AmmoSlot")
	local titles = new("Frame", "PlayerTitleFrame", paperDoll)
	button("Button", "PlayerTitleFrameButton", titles)
	for _, side in ipairs({ "Left", "Right" }) do
		local dd = new("Frame", "PlayerStatFrame" .. side .. "DropDown", paperDoll, "UIDropDownMenuTemplate")
		button("Button", "PlayerStatFrame" .. side .. "DropDownButton", dd)
	end
	-- their art in three
	for _, name in ipairs({ "PlayerTitleFrame", "PlayerStatFrameLeftDropDown", "PlayerStatFrameRightDropDown" }) do
		for _, part in ipairs({ "Left", "Middle", "Right" }) do
			if not _G[name .. part] then
				new("Texture", name .. part, _G[name])
			end
		end
	end
	local resistances = new("Frame", "CharacterResistanceFrame", paperDoll)
	-- its five schools (MagicResistanceFrameTemplate): the icon, the value
	for i, coords in ipairs({ { .2265625, .33984375 }, { 0, .11328125 }, { .11328125, .2265625 },
		{ .33984375, .453125 }, { .453125, .56640625 } }) do
		local resistance = new("Frame", "MagicResFrame" .. i, resistances)
		resistance:SetSize(32, 29)
		local icon = new("Texture", nil, resistance)
		icon:SetTexture([[Interface\PaperDollInfoFrame\UI-Character-ResistanceIcons]])
		icon:SetTexCoord(0, 1, coords[1], coords[2])
		new("FontString", "MagicResText" .. i, resistance)
	end
	-- the title picker (PlayerTitlePickerFrame, a HybridScrollFrame's buttons)
	local picker = hidden(new("Frame", "PlayerTitlePickerFrame", titles))
	local pickerScroll = new("ScrollFrame", "PlayerTitlePickerScrollFrame", picker)
	pickerScroll.buttons = { button("Button", "PlayerTitlePickerScrollFrameButton1", pickerScroll) }
	-- the equipment manager (GearManagerDialog, UIPanelDialogTemplate) and its button
	button("Button", "GearManagerToggleButton", paperDoll)
	local gear = hidden(new("Frame", "GearManagerDialog", paperDoll))
	for _, part in ipairs({ "TopLeft", "TopRight", "Top", "BottomLeft", "BottomRight", "Bottom", "Left", "Right",
		"TitleBG", "DialogBG" }) do
		new("Texture", "GearManagerDialog" .. part, gear)
	end
	gear.title = new("FontString", nil, gear)
	gear.title:SetText("Equipment Manager")
	button("Button", "GearManagerDialogClose", gear, "UIPanelCloseButton")
	for _, part in ipairs({ { "DeleteSet", "Delete" }, { "EquipSet", "Equip" }, { "SaveSet", "Save" } }) do
		local b = button("Button", "GearManagerDialog" .. part[1], gear, "UIPanelButtonTemplate")
		b:SetSize(78, 22)
		b:SetText(part[2])
	end
	gear.buttons = {}
	for i = 1, 10 do
		-- GearSetButtonTemplate: its icon the normal texture
		local set = button("CheckButton", "GearSetButton" .. i, gear)
		set:SetSize(36, 36)
		set.icon = set:GetNormalTexture()
		set.text = new("FontString", "GearSetButton" .. i .. "Name", set)
		set:SetScript("OnClick", function(self) _G.GearSetButton_OnClick(self) end)
		gear.buttons[i] = set
	end
	local popup = hidden(new("Frame", "GearManagerDialogPopup", gear))
	for _, part in ipairs({ "TopLeft", "TopRight", "BotLeft", "BotRight" }) do
		new("Texture", nil, popup):SetTexture("Interface\\MacroFrame\\MacroPopup-" .. part)
	end
	new("EditBox", "GearManagerDialogPopupEditBox", popup)
	button("Button", "GearManagerDialogPopupOkay", popup, "UIPanelButtonTemplate")
	button("Button", "GearManagerDialogPopupCancel", popup, "UIPanelButtonTemplate")
	gear:SetScript("OnShow", function() _G.GearManagerDialog_Update() end)
	paperDoll:SetScript("OnShow", function() _G.PaperDollFrame_UpdateStats() end)
	paperDoll:SetScript("OnHide", function() gear:Hide() end)
	local rep = hidden(new("Frame", "ReputationFrame", character))
	rep.name = "ReputationFrame" -- its art and parts from FrameXML
	local pet = hidden(new("Frame", "PetPaperDollFrame", character))
	new("FontString", "PetNameText", pet)
	new("Frame", "PetPaperDollFrameCompanionFrame", pet)
	for i, text in ipairs({ "Pet", "Companions", "Mounts" }) do
		tab("PetPaperDollFrameTab" .. i, pet, text)
	end
	button("Button", "PetPaperDollCloseButton", pet, "UIPanelButtonTemplate")
	panelArt(pet, "PaperDollInfoFrame\\UI-Character-General-", { "TopLeft", "TopRight" })
	panelArt(pet, "PetPaperDollFrame\\UI-PetPaperDollFrame-", { "BotLeft", "BotRight" })
	_G.SKILLS_TO_DISPLAY = 12 -- (SkillFrame.lua)
	local skills = hidden(new("Frame", "SkillFrame", character))
	panelArt(skills, "PaperDollInfoFrame\\UI-Character-General-", { "TopLeft", "TopRight" })
	panelArt(skills, "PaperDollInfoFrame\\SkillFrame-", { "BotLeft", "BotRight" })
	new("ScrollFrame", "SkillDetailScrollFrame", skills)
	button("Button", "SkillFrameCancelButton", skills, "UIPanelButtonTemplate")
	local spellbook = hidden(new("Frame", "SpellBookFrame", UIParent))
	for i = 1, 8 do
		button("CheckButton", "SpellBookSkillLineTab" .. i, spellbook)
	end
	local friends = hidden(new("Frame", "FriendsFrame", UIParent))
	new("Frame", "FriendsDropDown", friends, "UIDropDownMenuTemplate")
	local lfd = hidden(new("Frame", "LFDParentFrame", UIParent))
	local queue = new("Frame", "LFDQueueFrame", lfd)
	local find = button("Button", "LFDQueueFrameFindGroupButton", queue, "UIPanelButtonTemplate")
	state[find].fontString = _G.LFDQueueFrameFindGroupButtonText
	new("Frame", "LFDQueueFrameTypeDropDown", queue, "UIDropDownMenuTemplate")
	new("Frame", "LFDQueueFrameRandom", queue)
	local scroll = new("ScrollFrame", "LFDQueueFrameSpecificListScrollFrame", queue)
	local scrollBar = new("Slider", "LFDQueueFrameSpecificListScrollFrameScrollBar", scroll)
	button("Button", "LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton", scrollBar)
	button("Button", "LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton", scrollBar)
	-- the Dungeon Finder's dialogs (LFDFrame.xml), with UIPanelButtonTemplate2
	-- buttons: no button textures, but three of their own
	local function button2(name, parent)
		local b = new("Button", name, parent, "UIPanelButtonTemplate2")
		state[b].highlightTexture = new("Texture", nil, b)
		for _, side in ipairs({ "Left", "Middle", "Right" }) do
			new("Texture", name .. side, b)
		end
		return b
	end
	local roleCheck = hidden(new("Frame", "LFDRoleCheckPopup", UIParent))
	button2("LFDRoleCheckPopupAcceptButton", roleCheck)
	button2("LFDRoleCheckPopupDeclineButton", roleCheck)
	local readyPopup = hidden(new("Frame", "LFDDungeonReadyPopup", UIParent))
	new("Frame", "LFDDungeonReadyStatus", readyPopup)
	local readyDialog = new("Frame", "LFDDungeonReadyDialog", readyPopup)
	new("Texture", "LFDDungeonReadyDialogBackground", readyDialog):SetTexture([[Interface\LFGFrame\UI-LFG-BACKGROUND-RANDOMDUNGEON]])
	new("Texture", "LFDDungeonReadyDialogFiligree", readyDialog):SetTexture([[Interface\LFGFrame\UI-LFG-FILIGREE]])
	new("Texture", "LFDDungeonReadyDialogBottomArt", readyDialog):SetTexture([[Interface\LFGFrame\UI-LFG-FILIGREE]])
	button2("LFDDungeonReadyDialogEnterDungeonButton", readyDialog)
	button2("LFDDungeonReadyDialogLeaveQueueButton", readyDialog)
	local merchant = hidden(new("Frame", "MerchantFrame", UIParent))
	for i = 1, 2 do
		button("Button", "MerchantFrameTab" .. i, merchant)
	end
	for i = 1, 12 do
		local item = new("Frame", "MerchantItem" .. i, merchant)
		new("Texture", "MerchantItem" .. i .. "SlotTexture", item)
		itemButton("MerchantItem" .. i .. "ItemButton", item)
	end
	for _, name in ipairs({ "MerchantRepairItemButton", "MerchantRepairAllButton", "MerchantGuildBankRepairButton",
		"MerchantNextPageButton", "MerchantPrevPageButton", "MerchantBuyBackItem" }) do
		button("Button", name, merchant)
	end
	local worldMap = hidden(new("Frame", "WorldMapFrame", UIParent))
	-- the zone you hover and its description (WorldMapFrame.xml)
	new("FontString", "WorldMapFrameAreaLabel", worldMap):SetFont([[Fonts\FRIZQT__.TTF]], 22, "OUTLINE")
	new("FontString", "WorldMapFrameAreaDescription", worldMap):SetFont([[Fonts\FRIZQT__.TTF]], 16, "OUTLINE")
	-- the framerate texts (Ctrl+R): WorldFrame.xml and WorldMapFrame.xml
	hidden(new("FontString", "FramerateLabel", _G.WorldFrame))
	hidden(new("FontString", "FramerateText", _G.WorldFrame))
	hidden(new("FontString", "MapFramerateLabel", worldMap))
	hidden(new("FontString", "MapFramerateText", worldMap))
	tooltip("WorldMapCompareTooltip1", _G.WorldMapFrame)
	tooltip("WorldMapCompareTooltip2", _G.WorldMapFrame)
	tooltip("WorldMapCompareTooltip3", _G.WorldMapFrame)
	hidden(new("Frame", "QuestLogFrame", UIParent))
	hidden(new("Frame", "PVPFrame", UIParent))
	hidden(new("Frame", "HelpFrame", UIParent))

	-- minimap
	local cluster = new("Frame", "MinimapCluster", UIParent)
	local minimap = new("Minimap", "Minimap", cluster)
	minimap:SetSize(140, 140)
	minimap:SetPoint("CENTER", cluster, "TOP", 9, -92)
	new("Texture", "MinimapBorder", cluster)
	new("Texture", "MinimapBorderTop", cluster)
	local backdrop = new("Frame", "MinimapBackdrop", minimap)
	new("Texture", "MinimapCompassTexture", backdrop)
	new("Texture", "MinimapNorthTag", minimap)
	button("Button", "MinimapZoomIn", minimap):SetScript("OnClick", function() _G.Minimap_ZoomIn() end)
	button("Button", "MinimapZoomOut", minimap):SetScript("OnClick", function() _G.Minimap_ZoomOut() end)
	local zone = button("Button", "MinimapZoneTextButton", cluster)
	new("FontString", "MinimapZoneText", zone)
	button("Button", "MiniMapWorldMapButton", minimap)
	local tracking = new("Frame", "MiniMapTracking", minimap)
	new("Texture", "MiniMapTrackingIcon", tracking)
	new("Texture", "MiniMapTrackingBackground", tracking)
	local trackingButton = button("Button", "MiniMapTrackingButton", tracking)
	new("Texture", "MiniMapTrackingButtonBorder", trackingButton)
	new("Frame", "MiniMapTrackingDropDown", tracking, "UIDropDownMenuTemplate")
	local mail = hidden(new("Frame", "MiniMapMailFrame", minimap))
	new("Texture", "MiniMapMailIcon", mail)
	new("Texture", "MiniMapMailBorder", mail)
	local battlefield = hidden(button("Button", "MiniMapBattlefieldFrame", minimap))
	new("Texture", "MiniMapBattlefieldIcon", battlefield)
	new("Texture", "MiniMapBattlefieldBorder", battlefield)
	new("Texture", "BattlegroundShine", battlefield)
	new("FontString", "BattlefieldIconText", minimap)
	new("Frame", "MiniMapBattlefieldDropDown", battlefield, "UIDropDownMenuTemplate")
	local lfg = hidden(button("Button", "MiniMapLFGFrame", minimap))
	new("Texture", "MiniMapLFGFrameBorder", lfg)
	local eye = new("Frame", "MiniMapLFGFrameIcon", lfg)
	lfg.eye = eye
	eye.texture = new("Texture", "MiniMapLFGFrameIconTexture", eye)
	new("Frame", "MiniMapLFGFrameDropDown", lfg, "UIDropDownMenuTemplate")
	hidden(new("Frame", "LFDSearchStatus", lfg)):SetBackdrop({})
	local difficulty = hidden(new("Frame", "MiniMapInstanceDifficulty", minimap))
	new("Texture", "MiniMapInstanceDifficultyTexture", difficulty)
	new("FontString", "MiniMapInstanceDifficultyText", difficulty)
	hidden(button("Button", "MiniMapVoiceChatFrame", minimap))
	button("CheckButton", "GameTimeFrame", minimap)

	fromFrameXML(nil)
	-- the Dungeon Finder's list over its rows, made by hand before them
	scroll:SetPoint("TOPLEFT", _G.LFDQueueFrameSpecificListButton1, "TOPLEFT", 0, 7)
	scroll:SetPoint("BOTTOMRIGHT", _G.LFDQueueFrameSpecificListButton15, "BOTTOMRIGHT", 1, -7)
end

-- Frames of Blizzard's load-on-demand addons, made by LoadAddOn.
local ON_DEMAND = {
	Blizzard_TimeManager = function()
		local clock = button("Button", "TimeManagerClockButton", _G.Minimap)
		new("FontString", "TimeManagerClockTicker", clock)
		new("Texture", "TimeManagerAlarmFiredTexture", clock)
		hidden(new("Frame", "TimeManagerFrame", _G.UIParent))
		hidden(new("Frame", "StopwatchFrame", _G.UIParent))
		_G.TimeManager_Toggle = function() end
		_G.Stopwatch_Toggle = function() end
	end,
	Blizzard_TalentUI = function()
		local talents = hidden(new("Frame", "PlayerTalentFrame", _G.UIParent))
		talents:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		new("Texture", "PlayerTalentFramePortrait", talents)
		new("Texture", "PlayerTalentFrameTopLeft", talents)
		new("FontString", "PlayerTalentFrameTitleText", talents)
		-- the talent tree's background, set per tree
		local scroll = new("ScrollFrame", "PlayerTalentFrameScrollFrame", talents)
		new("Texture", "PlayerTalentFrameBackgroundTopLeft", scroll)
		for i = 1, 4 do
			button("Button", "PlayerTalentFrameTab" .. i, talents)
		end
		local talent = button("Button", "PlayerTalentFrameTalent1", talents)
		new("Texture", "PlayerTalentFrameTalent1IconTexture", talent)
		-- Blizzard_TalentUI.lua
		_G.PlayerTalentFrame_UpdateSpecs = function() end
		_G.PlayerTalentFrame_UpdateControls = function() end
		_G.PlayerTalentFrame_UpdateTabs = function() end -- (names the tabs after the trees)
	end,
	Blizzard_InspectUI = function()
		local frame = hidden(new("Frame", "InspectFrame", _G.UIParent))
		new("PlayerModel", "InspectModelFrame", new("Frame", "InspectPaperDollFrame", frame))
		-- Blizzard_InspectUI.lua
		_G.InspectFrame_UnitChanged = function() end
		-- InspectFrame.lua
		_G.InspectFrame_Show = function(unit)
			_G.InspectFrame.unit = unit
			_G.ShowUIPanel(_G.InspectFrame)
		end
		_G.InspectPaperDollItemSlotButton_Update = function() end
		-- InspectTalentFrame.lua: each tab named after its tree, sized to it
		_G.InspectTalentFrame_UpdateTabs = function()
			local talents = _G.InspectTalentFrame
			for i = 1, 3 do
				local tab = _G["InspectTalentFrameTab" .. i]
				local name = _G.GetTalentTabInfo(i, talents.inspect, talents.pet, talents.talentGroup)
				if tab and name then
					tab:SetText(name)
					_G.PanelTemplates_TabResize(tab, -10)
					tab:Show()
				end
			end
		end
	end,
	Blizzard_TrainerUI = function()
		-- Blizzard_TrainerUI.lua: the list and the chosen service's details,
		-- without the scrolling
		_G.CLASS_TRAINER_SKILLS_DISPLAYED = 11
		_G.ClassTrainer_SetToTradeSkillTrainer = function()
			_G.CLASS_TRAINER_SKILLS_DISPLAYED = 10
			_G.ClassTrainerSkill11:Hide()
			_G.ClassTrainerDetailScrollFrame:SetHeight(135)
		end
		_G.ClassTrainer_SetToClassTrainer = function()
			_G.CLASS_TRAINER_SKILLS_DISPLAYED = 11
			_G.ClassTrainerDetailScrollFrame:SetHeight(119)
		end
		_G.ClassTrainerFrame_Update = function()
			if _G.IsTradeskillTrainer() then
				_G.ClassTrainer_SetToTradeSkillTrainer()
			else
				_G.ClassTrainer_SetToClassTrainer()
			end
			for i = 1, _G.CLASS_TRAINER_SKILLS_DISPLAYED do
				local button = _G["ClassTrainerSkill" .. i]
				local name, subText = _G.GetTrainerServiceInfo(i)
				button:SetID(i)
				if name then
					button:SetText(name)
					_G["ClassTrainerSkill" .. i .. "SubText"]:SetText(subText or "")
					button:Show()
				else
					button:Hide()
				end
			end
		end
		_G.ClassTrainer_SetSelection = function(id)
			local service = id and client.world.trainer.services[id]
			if (not service) or (service.kind == "header") then
				return
			end
			_G.SelectTrainerService(id)
			_G.ClassTrainerSkillRequirements:SetText(service.requirements)
		end
	end,
	Blizzard_TradeSkillUI = function()
		-- Blizzard_TradeSkillUI.lua: the list and the chosen recipe's
		-- reagents, without the scrolling and filters
		_G.TRADE_SKILLS_DISPLAYED, _G.MAX_TRADE_SKILL_REAGENTS = 8, 8
		_G.TradeSkillFrame_Update = function()
			local selected = _G.GetTradeSkillSelectionIndex()
			for i = 1, _G.TRADE_SKILLS_DISPLAYED do
				local button = _G["TradeSkillSkill" .. i]
				local name, kind, available = _G.GetTradeSkillInfo(i)
				button:SetID(i)
				button.isHighlighted = (i == selected) or nil
				if name then
					button:SetText(name)
					_G["TradeSkillSkill" .. i .. "Count"]:SetText((available > 0) and ("[" .. available .. "]") or "")
					local color = (kind ~= "header") and _G.TradeSkillTypeColor[kind]
					if color then
						button:GetFontString():SetTextColor(color.r, color.g, color.b)
					end
					button:Show()
				else
					button:Hide()
				end
			end
		end
		-- (its own, as Blizzard_TradeSkillUI.lua names them)
		_G.TradeSkillTypeColor = {
			optimal = { r = 1, g = .5, b = .25 }, medium = { r = 1, g = 1, b = 0 },
			easy = { r = .25, g = .75, b = .25 }, trivial = { r = .5, g = .5, b = .5 },
			header = { r = 1, g = .82, b = 0 },
		}
		_G.TradeSkillFrame_SetSelection = function(id)
			client.world.tradeSkill.selected = id
			for i = 1, _G.MAX_TRADE_SKILL_REAGENTS do
				local name, _, need, have = _G.GetTradeSkillReagentInfo(id, i)
				local text = _G["TradeSkillReagent" .. i .. "Name"]
				if name then
					text:SetText(name)
					-- (grey when short, white when not)
					if (have < need) then
						text:SetTextColor(.5, .5, .5)
					else
						text:SetTextColor(1, 1, 1)
					end
					_G["TradeSkillReagent" .. i]:Show()
				else
					_G["TradeSkillReagent" .. i]:Hide()
				end
			end
		end
	end,
	Blizzard_CombatText = function()
		new("Frame", "CombatText", _G.UIParent)
		_G.CombatText_UpdateDisplayedMessages = function() end
		_G.CombatText_ClearAnimationList = function() end
		_G.CombatText_AddMessage = function() end
	end,
	Blizzard_DebugTools = function()
		local trace = hidden(new("Frame", "EventTraceFrame", _G.UIParent))
		for _, part in ipairs({ "TopLeft", "TopRight", "BottomLeft", "BottomRight" }) do
			new("Texture", "EventTraceFrame" .. part, trace)
		end
		new("FontString", "EventTraceFrameTitle", trace)
		tooltip("EventTraceTooltip")
		tooltip("FrameStackTooltip")
	end,
	Blizzard_ArenaUI = function()
		local arena = new("Frame", "ArenaEnemyFrames", _G.UIParent)
		for i = 1, 5 do
			unitFrame("ArenaEnemyFrame" .. i, true):SetParent(arena)
		end
	end,
	Blizzard_Calendar = function()
		hidden(new("Frame", "CalendarFrame", _G.UIParent))
	end,
	Blizzard_TokenUI = function()
		local token = hidden(new("Frame", "TokenFrame", _G.CharacterFrame))
		panelArt(token, "PaperDollInfoFrame\\UI-Character-General-", { "TopLeft", "TopRight" })
		panelArt(token, "TalentFrame\\UI-TalentFrame-", { "BotLeft", "BotRight" })
		button("Button", "TokenFrameCancelButton", token, "UIPanelButtonTemplate")
		button("Button", nil, token, "UIPanelCloseButton") -- its unnamed X
	end,
	-- Blizzard_AuctionUI.lua: its tabs (AuctionFrameTab_OnClick: one page
	-- shown), the categories' list (AuctionFrameFilters_Update: a
	-- button per class shown, the rest hidden) and Browse's pages (its
	-- search asks for AuctionFrameBrowse.page: client.auctionQuery); its
	-- frames from FrameXML
	Blizzard_AuctionUI = function()
		_G.NUM_AUCTION_ITEMS_PER_PAGE = 50
		_G.AuctionFrameBrowse_Update = function() end
		_G.AuctionFrameBrowse_Search = function()
			client.auctionQuery = _G.AuctionFrameBrowse.page
			_G.AuctionFrameBrowse_Update()
		end
		local classes = { "Weapon", "Armor", "Container", "Consumable", "Glyph", "Trade Goods", "Projectile", "Quiver",
			"Recipe", "Gem", "Miscellaneous", "Quest" }
		-- (a button's kind: its art's alpha, its text's indent)
		_G.FilterButton_SetType = function(button, kind, text)
			local name = button:GetName()
			button:SetText(text)
			local alpha, indent = 1, 4
			if (kind == "subclass") then
				alpha, indent = .4, 12
			elseif (kind == "invtype") then
				alpha, indent = 0, 20
			end
			_G[name .. "NormalTexture"]:SetAlpha(alpha)
			_G[name .. "NormalText"]:SetPoint("LEFT", button, "LEFT", indent, 0)
			button.type = kind
		end
		_G.AuctionFrameFilters_Update = function()
			for i = 1, 15 do
				local filter = _G["AuctionFilterButton" .. i]
				if classes[i] then
					_G.FilterButton_SetType(filter, "class", classes[i])
					filter:Show()
				else
					filter:Hide()
				end
			end
		end
		_G.AuctionFrameTab_OnClick = function(self)
			local frame, index = _G.AuctionFrame, self:GetID()
			frame.numTabs = math.max(frame.numTabs or 0, 3)
			_G.PanelTemplates_SetTab(frame, index)
			_G.AuctionFrameAuctions:Hide()
			_G.AuctionFrameBrowse:Hide()
			_G.AuctionFrameBid:Hide()
			if (index == 1) then
				_G.AuctionFrameBrowse:Show()
				_G.AuctionFrameFilters_Update()
			elseif (index == 2) then
				_G.AuctionFrameBid:Show()
			elseif (index == 3) then
				_G.AuctionFrameAuctions:Show()
			end
		end
	end,
	Blizzard_AchievementUI = function()
		local frame = hidden(new("Frame", "AchievementFrame", _G.UIParent))
		frame:SetSize(768, 500)
		frame:SetBackdrop({ edgeFile = [[Interface\AchievementFrame\UI-Achievement-WoodBorder]] })
		for _, part in ipairs({ "Background", "MetalBorderLeft", "CategoriesBG", "WaterMark", "WoodBorderTopLeft" }) do
			new("Texture", "AchievementFrame" .. part, frame)
		end
		local header = new("Frame", "AchievementFrameHeader", frame)
		for _, part in ipairs({ "Left", "Right", "PointBorder", "RightDDLInset", "Shield" }) do
			new("Texture", "AchievementFrameHeader" .. part, header)
		end
		new("FontString", "AchievementFrameHeaderTitle", header)
		new("FontString", "AchievementFrameHeaderPoints", header)
		-- a panel in the tooltip's border, gold (AchievementFrameAchievementsBackdrop_OnLoad)
		local function panel(f)
			f:SetBackdrop({ edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16 })
			f:SetBackdropBorderColor(1, .675, .125, 1)
			return f
		end
		local categories = panel(new("Frame", "AchievementFrameCategories", frame))
		-- the categories' buttons (AchievementCategoryTemplate)
		for i = 1, 3 do
			local b = new("Button", "AchievementFrameCategoriesContainerButton" .. i, categories)
			b:SetSize(158, 24)
			b.background = new("Texture", "AchievementFrameCategoriesContainerButton" .. i .. "Background", b)
			b.label = new("FontString", "AchievementFrameCategoriesContainerButton" .. i .. "Label", b)
			b:SetHighlightTexture([[Interface\AchievementFrame\UI-Achievement-Category-Highlight]])
		end
		local achievements = new("Frame", "AchievementFrameAchievements", frame)
		new("Texture", "AchievementFrameAchievementsBackground", achievements)
		panel(new("Frame", nil, achievements))
		-- an achievement (AchievementTemplate), in its list's buttons
		local container = new("ScrollFrame", "AchievementFrameAchievementsContainer", achievements)
		local row = new("Button", "AchievementFrameAchievementsContainerButton1", container)
		new("Texture", "AchievementFrameAchievementsContainerButton1Background", row)
		new("Texture", "AchievementFrameAchievementsContainerButton1TitleBackground", row)
		row.description = new("FontString", "AchievementFrameAchievementsContainerButton1Description", row)
		container.buttons = { row }
		local stats = hidden(new("Frame", "AchievementFrameStats", frame))
		local statsBG = new("Frame", "AchievementFrameStatsBG", stats)
		new("Texture", "AchievementFrameStatsBGTexture", statsBG)
		panel(new("Frame", nil, statsBG))
		local summary = hidden(new("Frame", "AchievementFrameSummary", frame))
		new("Texture", "AchievementFrameSummaryBackground", summary)
		panel(new("Frame", nil, summary))
		new("Frame", "AchievementFrameSummaryAchievements", summary).buttons = {}
		for _, name in ipairs({ "AchievementFrameSummaryCategoriesHeader", "AchievementFrameSummaryAchievementsHeader" }) do
			local h = new("Frame", name, summary)
			new("Texture", name .. (name:find("Categories") and "Texture" or "Header"), h)
			new("FontString", name .. "Title", h)
		end
		-- the summary's bars (AchievementFrameSummaryCategoryTemplate), two
		-- columns under the big one
		local function bar(name, label)
			local b = new("StatusBar", name, summary)
			b:SetSize(234, 21)
			for _, part in ipairs({ "Left", "Right", "Middle" }) do
				new("Texture", name .. part, b)
			end
			local glow = new("Button", name .. "Button", b)
			for _, part in ipairs({ "Left", "Right", "Middle" }) do
				new("Texture", name .. "Button" .. part, glow)
			end
			new("FontString", name .. label, b)
			new("FontString", name .. "Text", b)
			return b
		end
		bar("AchievementFrameSummaryCategoriesStatusBar", "Title"):SetSize(488, 21)
		for i = 1, 8 do
			local b = bar("AchievementFrameSummaryCategoriesCategory" .. i, "Label")
			if (i % 2 == 0) then
				b:SetPoint("TOPLEFT", _G["AchievementFrameSummaryCategoriesCategory" .. (i - 1)], "TOPRIGHT", 20, 0)
			end
		end
		local comparison = hidden(new("Frame", "AchievementFrameComparison", frame))
		for _, part in ipairs({ "Background", "Dark", "Watermark" }) do
			new("Texture", "AchievementFrameComparison" .. part, comparison)
		end
		button("Button", "AchievementFrameCloseButton", frame)
		new("Frame", "AchievementFrameFilterDropDown", frame, "UIDropDownMenuTemplate")
		for i, text in ipairs({ "Achievements", "Statistics" }) do
			tab("AchievementFrameTab" .. i, frame, text):SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 11, -30)
		end
		frame.numTabs = 2
		_G.PanelTemplates_SetTab(frame, 1)

		-- Blizzard_AchievementUI.lua
		_G.AchievementFrameSummary_UpdateAchievements = function() end
		_G.AchievementFrameCategories_DisplayButton = function(b, element)
			if type(element.parent) == "number" then
				b.label:SetFontObject(_G.GameFontHighlight)
				b.parentID = element.parent
				b.background:SetVertexColor(0.6, 0.6, 0.6)
			else
				b.label:SetFontObject(_G.GameFontNormal)
				b.parentID = element.parent
				b.background:SetVertexColor(1, 1, 1)
			end
			b.label:SetText(element.name)
		end
		_G.AchievementButton_Saturate = function(self)
			self.saturated = true
			_G[self:GetName() .. "Background"]:SetTexture([[Interface\AchievementFrame\UI-Achievement-Parchment-Horizontal]])
			self.description:SetTextColor(0, 0, 0, 1)
		end
		_G.AchievementButton_Desaturate = function(self)
			self.saturated = nil
			_G[self:GetName() .. "Background"]:SetTexture([[Interface\AchievementFrame\UI-Achievement-Parchment-Horizontal-Desaturated]])
			self.description:SetTextColor(1, 1, 1, 1)
		end
		-- AchievementButton_OnLoad: its own copies
		row.Saturate, row.Desaturate = _G.AchievementButton_Saturate, _G.AchievementButton_Desaturate
		row:Saturate()
	end,
}
Blizzard.ON_DEMAND = ON_DEMAND

------------------------------------------------------------------------
-- FrameXML functions
------------------------------------------------------------------------

local function noop() end

local function frameXML(client)
	local api = client.api
	local f = {}

	-- secure state drivers, unit watches, option parsing
	f.SecureCmdOptionParse = function(options)
		for clause in (options .. ";"):gmatch("%s*([^;]*);") do
			local conditions, value = clause:match("^(%b[].-)%s*([^%]]*)$")
			if not conditions then
				return clause:match("^%s*(.-)%s*$")
			end
			local all = {}
			for group in conditions:gmatch("%[(.-)%]") do
				all[#all + 1] = group
			end
			for _, group in ipairs(all) do
				if client:EvaluateConditions(group) then
					return value:match("^%s*(.-)%s*$")
				end
			end
		end
		return nil
	end
	f.RegisterStateDriver = function(frame, stateName, values)
		f.UnregisterStateDriver(frame, stateName)
		table.insert(client.stateDrivers, { frame = frame, state = stateName, values = values })
		client:UpdateStateDrivers()
	end
	f.UnregisterStateDriver = function(frame, stateName)
		for i = #client.stateDrivers, 1, -1 do
			local driver = client.stateDrivers[i]
			if driver.frame == frame and driver.state == stateName then
				table.remove(client.stateDrivers, i)
			end
		end
	end
	f.RegisterUnitWatch = function(frame) client.unitWatches[frame] = true client:UpdateStateDrivers() end
	f.UnregisterUnitWatch = function(frame) client.unitWatches[frame] = nil end
	f.UnitWatchRegistered = function(frame) return client.unitWatches[frame] and 1 or nil end
	f.SecureHandler_OnLoad = noop
	f.SecureHandlerWrapScript = noop
	f.SecureHandlerUnwrapScript = noop
	f.SecureHandlerExecute = noop
	f.SecureHandlerSetFrameRef = function(frame, label, ref) frame:SetAttribute("frameref-" .. label, ref) end

	f.CreateFont = function(name)
		local font = Widgets.new("Font", name)
		return font
	end
	f.CreateFrame = function(frameType, name, parent, templates)
		assert(type(frameType) == "string", "CreateFrame: frame type must be a string")
		return Widgets.new(frameType, name, parent, templates)
	end

	-- chat
	f.FCF_GetCurrentChatFrame = function() return _G.SELECTED_CHAT_FRAME end
	f.FCF_SavePositionAndDimensions = noop
	f.FCF_SetLocked = function(frame, locked) frame.isLocked = locked end
	f.FCF_SetWindowAlpha = function(frame, alpha) frame.oldAlpha = alpha end
	f.FCF_SetWindowColor = noop
	f.FCF_Tab_OnClick = function(tab, button) end
	f.FCF_UpdateButtonSide = noop
	f.FCF_SetButtonSide = noop
	f.FCF_OpenTemporaryWindow = function(chatType, chatTarget)
		local frame = chatFrame(#_G.CHAT_FRAMES + 1)
		frame.chatType, frame.chatTarget = chatType, chatTarget
		frame:Show()
		_G.SELECTED_CHAT_FRAME = frame
		return frame
	end
	f.FCF_FadeInChatFrame = noop
	f.FCF_FadeOutChatFrame = noop
	f.FCF_DockUpdate = noop
	f.FCF_StartAlertFlash = noop
	f.FCF_StopAlertFlash = noop
	f.FCF_ResetChatWindows = noop
	f.FCF_SetChatWindowFontSize = noop
	f.FCF_GetChatWindowInfo = function(id) return api.GetChatWindowInfo(id) end
	f.FloatingChatFrame_OnMouseScroll = noop
	f.FCFDock_GetSelectedWindow = function(dock) return dock.selected end
	f.FCFTab_UpdateColors = noop
	f.ChatFrame_AddMessageEventFilter = function(event, filter)
		client.chatFilters[event] = client.chatFilters[event] or {}
		table.insert(client.chatFilters[event], filter)
	end
	f.ChatFrame_RemoveMessageEventFilter = function(event, filter)
		for i, existing in ipairs(client.chatFilters[event] or {}) do
			if existing == filter then
				table.remove(client.chatFilters[event], i)
				return
			end
		end
	end
	f.ChatFrame_GetMessageEventFilters = function(event) return client.chatFilters[event] end
	f.ChatFrame_AddMessageGroup = noop
	f.ChatFrame_RemoveMessageGroup = noop
	f.ChatFrame_RemoveAllMessageGroups = noop
	f.ChatFrame_AddChannel = noop
	f.ChatFrame_RemoveAllChannels = noop
	f.ChatFrame_OpenChat = function(text) _G.ChatFrame1EditBox:Show() _G.ChatFrame1EditBox:SetText(text or "") end
	f.ChatFrame_OnHyperlinkShow = noop
	f.ChatEdit_GetActiveWindow = function() return _G.ChatFrame1EditBox:IsShown() and _G.ChatFrame1EditBox or nil end
	f.ChatEdit_GetLastActiveWindow = function() return _G.ChatFrame1EditBox end
	f.ChatEdit_ActivateChat = function(editBox) editBox:Show() end
	f.ChatEdit_DeactivateChat = function(editBox) editBox:Hide() end
	f.ChatEdit_FocusActiveWindow = noop
	f.ChatEdit_InsertLink = function(link) return nil end
	f.ChatEdit_SendText = noop
	f.EquipmentManager_EquipSet = function(name) client.world.equippedSet = name end
	f.ChatEdit_OnEscapePressed = function(editBox) editBox:Hide() end
	f.ChatTypeInfo = nil

	-- tooltips
	f.GameTooltip_SetDefaultAnchor = function(tooltip, parent)
		tooltip:SetOwner(parent, "ANCHOR_NONE")
		tooltip:ClearAllPoints()
		tooltip:SetPoint("BOTTOMRIGHT", _G.UIParent, "BOTTOMRIGHT", -13, 64)
		tooltip.default = 1
	end
	f.GameTooltip_UnitColor = function(unit)
		local r, g, b = 1, 1, 1
		if api.UnitIsPlayer(unit) then
			local _, class = api.UnitClass(unit)
			local color = _G.RAID_CLASS_COLORS[class]
			if color then r, g, b = color.r, color.g, color.b end
		elseif api.UnitCanAttack("player", unit) then
			r, g, b = 1, 0.1, 0.1
		end
		return r, g, b
	end
	f.GameTooltip_OnTooltipAddMoney = function(self, cost, maxcost)
		if not maxcost then
			self:AddLine(_G.SELL_PRICE .. ": " .. tostring(cost), 1, 1, 1)
		else
			self:AddLine(_G.SELL_PRICE .. ":", 1, 1, 1)
			self:AddLine("    Minimum: " .. tostring(cost), 1, 1, 1)
			self:AddLine("    Maximum: " .. tostring(maxcost), 1, 1, 1)
		end
	end
	f.GameTooltip_ShowCompareItem = function(self) end
	f.GameTooltip_ClearMoney = noop
	f.GameTooltip_OnHide = noop
	f.GameTooltip_AddNewbieTip = noop
	f.SetItemRef = function(link, text, button)
		if link:match("^item:") then
			_G.ItemRefTooltip:SetOwner(_G.UIParent, "ANCHOR_PRESERVE")
			_G.ItemRefTooltip:SetHyperlink(link)
		end
	end

	-- menus and dropdowns
	f.UIDropDownMenu_Initialize = function(frame, init, displayMode, level, menuList)
		frame.initialize = init
		frame.displayMode = displayMode
		frame.menuList = menuList
		if init then
			client:Call(init, frame, level or 1, menuList)
		end
	end
	f.UIDropDownMenu_CreateInfo = function() return {} end
	-- (UIDropDownMenu.lua's: the list's next line, its text in Blizzard's
	-- small font, a title or a disabled one disabled, the list as wide as
	-- its widest, measured before the font is set)
	f.UIDropDownMenu_AddButton = function(info, level)
		client.dropDownButtons[#client.dropDownButtons + 1] = info
		local list = rawget(_G, "DropDownList" .. (level or 1))
		if not list then
			return
		end
		-- (past UIDROPDOWNMENU_MAXBUTTONS Blizzard warns and adds nothing)
		local index = (list.numButtons or 0) + 1
		local button = rawget(_G, list:GetName() .. "Button" .. index)
		if not button then
			return
		end
		list.numButtons = index
		button:SetText(info.text)
		local width = button:GetFontString():GetStringWidth() + (info.notCheckable and 10 or 40)
		list.maxWidth = math.max(list.maxWidth or 0, width)
		button:SetNormalFontObject(info.fontObject or _G.GameFontHighlightSmallLeft)
		button:SetHighlightFontObject(info.fontObject or _G.GameFontHighlightSmallLeft)
		if info.isTitle or info.disabled then
			button:Disable()
		else
			button:Enable()
		end
		button:Show()
	end
	-- (UIDropDownMenu.lua's: its middle that wide, the frame its ends wider)
	f.UIDropDownMenu_SetWidth = function(frame, width, padding)
		frame.width = width
		local name = frame:GetName()
		local middle, text = name and rawget(_G, name .. "Middle"), name and rawget(_G, name .. "Text")
		if middle then
			middle:SetWidth(width)
		end
		frame:SetWidth(width + (padding or 50))
		if text then
			text:SetWidth(width - (padding or 25))
		end
		frame.noResize = 1
	end
	f.UIDropDownMenu_SetButtonWidth = noop
	f.UIDropDownMenu_SetText = function(frame, text) frame.text = text end
	f.UIDropDownMenu_GetText = function(frame) return frame.text end
	f.UIDropDownMenu_SetSelectedValue = function(frame, value) frame.selectedValue = value end
	f.UIDropDownMenu_GetSelectedValue = function(frame) return frame.selectedValue end
	f.UIDropDownMenu_SetSelectedID = function(frame, id) frame.selectedID = id end
	f.UIDropDownMenu_GetSelectedID = function(frame) return frame.selectedID end
	f.UIDropDownMenu_SetSelectedName = function(frame, name) frame.selectedName = name end
	f.UIDropDownMenu_JustifyText = noop
	f.UIDropDownMenu_EnableDropDown = noop
	f.UIDropDownMenu_DisableDropDown = noop
	f.UIDropDownMenu_Refresh = noop
	f.UIDropDownMenu_InitializeHelper = function(frame)
		client.dropDownButtons = {}
		for level = 1, _G.UIDROPDOWNMENU_MAXLEVELS or 2 do
			local list = rawget(_G, "DropDownList" .. level)
			if list then
				list.numButtons, list.maxWidth = 0, 0
			end
		end
	end
	f.UIDropDownMenu_CreateFrames = noop
	f.ToggleDropDownMenu = function(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList)
		client.openDropDown = dropDownFrame
		if dropDownFrame and dropDownFrame.initialize then
			-- securecall("UIDropDownMenu_InitializeHelper", ...): by name, hooks included
			_G.UIDropDownMenu_InitializeHelper(dropDownFrame)
			client:Call(dropDownFrame.initialize, dropDownFrame, level or 1, menuList)
		end
		_G.DropDownList1:Show()
	end
	f.CloseDropDownMenus = function() _G.DropDownList1:Hide() _G.DropDownList2:Hide() end
	f.EasyMenu = function(menuList, menuFrame) client.easyMenu = menuList end
	f.UnitPopup_ShowMenu = noop
	f.UnitPopup_OnUpdate = noop
	f.RaidFrameDropDown_Initialize = noop
	f.PlayerFrameDropDown_Initialize = noop
	f.TargetFrameDropDown_Initialize = noop
	f.StaticPopup_Show = function(which, text1, text2, data)
		local info = _G.StaticPopupDialogs[which]
		if not info then return nil end
		local popup = _G.StaticPopup1
		popup.which, popup.data = which, data
		popup.text:SetText(string.format(info.text or "", text1 or "", text2 or ""))
		if info.hasEditBox then popup.editBox:Show() else popup.editBox:Hide() end
		popup:Show()
		if info.OnShow then client:Call(info.OnShow, popup, data) end
		return popup
	end
	f.StaticPopup_Hide = function(which)
		for i = 1, 4 do
			local popup = _G["StaticPopup" .. i]
			if popup.which == which then popup:Hide() end
		end
	end
	f.StaticPopup_Visible = function(which)
		for i = 1, 4 do
			local popup = _G["StaticPopup" .. i]
			if popup.which == which and popup:IsShown() then return popup:GetName(), popup end
		end
	end
	f.StaticPopup_SetUpPosition = noop
	f.StaticPopup_EscapePressed = noop

	-- interface options
	-- the AddOns tab's list, as InterfaceOptionsFrame.lua keeps it: a child
	-- after its parent's other children, a parent at the end
	f.INTERFACEOPTIONS_ADDONCATEGORIES = {}
	f.InterfaceOptions_AddCategory = function(panel)
		client.optionsPanels[#client.optionsPanels + 1] = panel
		local categories = f.INTERFACEOPTIONS_ADDONCATEGORIES
		local position = #categories + 1
		for i, category in ipairs(categories) do
			if panel.parent and (category.name == panel.parent) then
				position = i + 1
				while categories[position] and (categories[position].parent == panel.parent) do
					position = position + 1
				end
				break
			end
		end
		table.insert(categories, position, panel)
	end
	f.InterfaceOptionsFrame_OpenToCategory = function(panel)
		client.openedOptions = panel
		_G.InterfaceOptionsFrame:Show()
		if type(panel) == "table" then
			panel:Show()
		end
	end
	f.InterfaceOptionsFrame_Show = function() _G.InterfaceOptionsFrame:Show() end
	f.InterfaceOptionsFrameOkay_OnClick = noop
	f.BlizzardOptionsPanel_OnLoad = noop
	f.BlizzardOptionsPanel_RegisterControl = noop
	f.VideoOptionsFrameOkay_OnClick = noop
	f.VideoOptionsFrame_Toggle = noop

	-- panels
	local function toggle(name)
		return function()
			local frame = _G[name]
			if frame then
				if frame:IsShown() then frame:Hide() else frame:Show() end
			end
		end
	end
	-- tabs (UIPanelTemplates.lua)
	f.PanelTemplates_DeselectTab = function(tab)
		local name = tab:GetName()
		_G[name .. "Left"]:Show(); _G[name .. "Middle"]:Show(); _G[name .. "Right"]:Show()
		tab:Enable()
		_G[name .. "LeftDisabled"]:Hide(); _G[name .. "MiddleDisabled"]:Hide(); _G[name .. "RightDisabled"]:Hide()
	end
	f.PanelTemplates_SelectTab = function(tab)
		local name = tab:GetName()
		_G[name .. "Left"]:Hide(); _G[name .. "Middle"]:Hide(); _G[name .. "Right"]:Hide()
		tab:Disable()
		tab:SetDisabledFontObject(_G.GameFontHighlightSmall)
		_G[name .. "LeftDisabled"]:Show(); _G[name .. "MiddleDisabled"]:Show(); _G[name .. "RightDisabled"]:Show()
	end
	f.PanelTemplates_SetNumTabs = function(frame, numTabs) frame.numTabs = numTabs end
	f.PanelTemplates_GetSelectedTab = function(frame) return frame.selectedTab end
	-- sized to its text, plus `padding` (24 without)
	f.PanelTemplates_TabResize = function(tab, padding)
		tab:SetWidth(tab:GetFontString():GetStringWidth() + (padding or 24) + 2 * _G[tab:GetName() .. "Left"]:GetWidth())
	end
	f.PanelTemplates_UpdateTabs = function(frame)
		if frame.selectedTab then
			for i = 1, frame.numTabs do
				local tab = _G[frame:GetName() .. "Tab" .. i]
				if (i == frame.selectedTab) then
					_G.PanelTemplates_SelectTab(tab)
				else
					_G.PanelTemplates_DeselectTab(tab)
				end
			end
		end
	end
	f.PanelTemplates_SetTab = function(frame, id)
		frame.selectedTab = id
		_G.PanelTemplates_UpdateTabs(frame)
	end
	-- the panels' places (UIParent.lua), and the windows closed with them
	f.UpdateUIPanelPositions = function(frame) client.panelUpdates = (client.panelUpdates or 0) + 1 end
	f.CloseChildWindows = function()
		for _, name in ipairs(_G.UIChildWindows) do
			if _G[name] then
				_G[name]:Hide()
			end
		end
	end
	-- the character window's (PaperDollFrame.lua, PetPaperDollFrame.lua)
	f.UpdatePaperdollStats = function(prefix, index)
		for i = 1, 6 do
			local label = _G[prefix .. i .. "Label"]
			if label then
				label:SetText(index .. " " .. i)
				_G[prefix .. i .. "StatText"]:SetText(i)
			end
		end
	end
	f.PaperDollFrame_UpdateStats = function()
		_G.UpdatePaperdollStats("PlayerStatFrameLeft", _G.GetCVar("playerStatLeftDropdown"))
		_G.UpdatePaperdollStats("PlayerStatFrameRight", _G.GetCVar("playerStatRightDropdown"))
	end
	f.PetPaperDollFrame_UpdateTabs = function() end
	f.PetPaperDollFrame_SetTab = noop
	f.PetPaperDollFrame_UpdateCompanions = noop
	f.PetPaperDollFrame_UpdateCompanionPreview = noop
	f.PetPaperDollFrame_SetCompanionPage = function(num)
		local frame = _G.PetPaperDollFrameCompanionFrame
		if frame.mode == "CRITTER" then
			frame.pageCritter = num
		else
			frame.pageMount = num
		end
		_G.PetPaperDollFrame_UpdateCompanions()
	end
	f.PetPaperDollFrame_UpdateIsAvailable = noop
	f.ReputationFrame_Update = noop
	f.InboxFrame_Update = noop -- MailFrame.lua: the inbox's page of letters
	f.SendMailFrame_Update = noop -- MailFrame.lua: the letter being written
	-- MailFrame.lua: the letter opened, its attachments placed from its
	-- foot on each update (the label, then the money's and the first
	-- item's buttons, listed as placed)
	f.OpenMail_Update = function()
		local open = _G.OpenMailFrame
		_G.OpenMailAttachmentText:SetText(_G.TAKE_ATTACHMENTS)
		_G.OpenMailAttachmentText:SetTextColor(1, 1, 1)
		_G.OpenMailAttachmentText:ClearAllPoints()
		_G.OpenMailAttachmentText:SetPoint("TOPLEFT", open, "BOTTOMLEFT", 23, 150)
		-- (the letter's money and its item; none when `world.emptyLetter`)
		open.activeAttachmentButtons = {}
		if not client.world.emptyLetter then
			open.activeAttachmentButtons = { _G.OpenMailMoneyButton, _G.OpenMailAttachmentButton1 }
		end
		for i, button in ipairs(open.activeAttachmentButtons) do
			button:ClearAllPoints()
			button:SetPoint("TOPLEFT", open, "BOTTOMLEFT", 23 + 50 * (i - 1), 130)
			button:Show()
		end
	end
	-- the spellbook (SpellBookFrame.lua): each spell button updated
	f.SpellButton_UpdateButton = noop
	-- a spell button's spell in the book (every rank shown: its own slot)
	f.SpellBook_GetSpellID = function(id)
		local slot = id + (_G.SpellBookFrame.selectedSkillLineOffset or 0)
		return slot, slot
	end
	f.SpellBookFrame_Update = function()
		for i = 1, 12 do
			if _G["SpellButton" .. i] then
				_G.SpellButton_UpdateButton(_G["SpellButton" .. i])
			end
		end
	end
	-- the who list (FriendsFrame.lua)
	f.WhoList_Update = noop
	f.WhoFrameDropDownButton_OnClick = function(self)
		_G.UIDropDownMenu_SetSelectedID(_G.WhoFrameDropDown, self:GetID())
		_G.WhoList_Update()
	end
	f.MerchantFrame_UpdateRepairButtons = noop
	-- the quest log (QuestLogFrame.lua, QuestInfo.lua)
	f.QuestInfo_Display = noop
	f.QuestLogControlPanel_UpdatePosition = noop
	f.QuestLogDetailFrame_AttachToQuestLog = noop
	f.QuestLogShowMapPOI_UpdatePosition = noop
	f.MAX_QUESTLOG_QUESTS = 25 -- QuestLogFrame.lua
	f.QuestLog_UpdateQuestCount = noop
	f.GetMaterialTextColors = function()
		return { 0, 0, 0 }, { 0, 0, 0 }
	end
	f.GearManagerDialog_Update = function()
		local dialog = _G.GearManagerDialog
		dialog.selectedSet = nil
		for i, set in ipairs(dialog.buttons) do
			local name, icon = _G.GetEquipmentSetInfo(i)
			if name then
				set:Enable()
				set.name = name
				set.text:SetText(name)
				set.icon:SetTexture(icon)
				set:SetChecked(dialog.selectedSetName == name)
				if (dialog.selectedSetName == name) then
					dialog.selectedSet = set
				end
			else
				set:Disable()
				set:SetChecked(false)
				set.name = nil
				set.text:SetText("")
				set.icon:SetTexture("")
			end
		end
		for _, name in ipairs({ "GearManagerDialogDeleteSet", "GearManagerDialogEquipSet" }) do
			if dialog.selectedSet then
				_G[name]:Enable()
			else
				_G[name]:Disable()
			end
		end
	end
	f.GearSetButton_OnClick = function(self)
		if self.name and (self.name ~= "") then
			_G.GearManagerDialog.selectedSetName = self.name
			_G.GearManagerDialog_Update()
		else
			self:SetChecked(false)
		end
	end
	f.GearManagerDialogSaveSet_OnClick = function(self)
		_G.GearManagerDialogPopup:Show()
	end
	f.ShowUIPanel = function(frame) if frame then frame:Show() end end
	f.HideUIPanel = function(frame) if frame then frame:Hide() end end
	f.ToggleFrame = function(frame) if frame:IsShown() then frame:Hide() else frame:Show() end end
	f.ToggleCharacter = function(tab) client.toggled = "CharacterFrame:" .. tostring(tab) toggle("CharacterFrame")() end
	f.ToggleSpellBook = function(book) client.toggled = "SpellBookFrame" toggle("SpellBookFrame")() end
	f.ToggleTalentFrame = function() client.toggled = "PlayerTalentFrame" end
	f.ToggleAchievementFrame = function() client.toggled = "AchievementFrame" end
	f.ToggleFriendsFrame = function(tab) client.toggled = "FriendsFrame:" .. tostring(tab) toggle("FriendsFrame")() end
	f.ToggleCalendar = function() client.toggled = "Calendar" end
	f.ToggleGameMenu = function() client.toggled = "GameMenu" toggle("GameMenuFrame")() end
	f.ToggleHelpFrame = function() client.toggled = "HelpFrame" end
	f.ToggleLFDParentFrame = function() client.toggled = "LFDParentFrame" toggle("LFDParentFrame")() end
	f.TogglePVPFrame = function() client.toggled = "PVPFrame" end
	f.ToggleLFRParentFrame = function() client.toggled = "LFRParentFrame" toggle("LFRParentFrame")() end
	-- UIParent.lua: the load-on-demand windows' loaders, and every window
	-- closed (the panels Blizzard places, the special frames, the bags)
	f.MacroFrame_LoadUI = function() api.LoadAddOn("Blizzard_MacroUI") end
	f.KeyBindingFrame_LoadUI = function() api.LoadAddOn("Blizzard_BindingUI") end
	f.ShowMacroFrame = function()
		_G.MacroFrame_LoadUI()
		_G.ShowUIPanel(_G.MacroFrame)
	end
	f.CloseAllWindows = function()
		local closed
		for _, name in ipairs({ "CharacterFrame", "SpellBookFrame", "PlayerTalentFrame", "FriendsFrame", "QuestLogFrame",
			"AchievementFrame", "LFDParentFrame", "LFRParentFrame", "PVPParentFrame", "MacroFrame", "KeyBindingFrame",
			"DressUpFrame", "MerchantFrame", "TradeSkillFrame", "ClassTrainerFrame" }) do
			local frame = rawget(_G, name)
			if frame and frame:IsShown() then
				frame:Hide()
				closed = 1
			end
		end
		return closed
	end
	f.ToggleQuestLog = function() client.toggled = "QuestLogFrame" end
	f.ToggleWorldMap = function() client.toggled = "WorldMapFrame" end
	f.ToggleKeyRing = function() client.toggled = "KeyRing" end
	f.ToggleBackpack = function() client.toggled = "Backpack" end
	f.ToggleBag = function(id) client.toggled = "Bag" .. tostring(id) end
	f.ToggleAllBags = function() client.toggled = "AllBags" end
	f.OpenAllBags = function() client.bagsOpen = true end
	f.CloseAllBags = function() client.bagsOpen = false end
	f.OpenBackpack = function() client.bagsOpen = true end
	f.CloseBackpack = function() client.bagsOpen = false end
	f.ToggleFramerate = function()
		local shown = not _G.FramerateText:IsShown()
		for _, name in ipairs({ "FramerateLabel", "FramerateText", "MapFramerateLabel", "MapFramerateText" }) do
			if shown then _G[name]:Show() else _G[name]:Hide() end
		end
	end
	f.TalentFrame_LoadUI = function() api.LoadAddOn("Blizzard_TalentUI") end
	f.InspectFrame_LoadUI = function() api.LoadAddOn("Blizzard_InspectUI") end
	-- UIParent.lua
	f.InspectUnit = function(unit)
		_G.InspectFrame_LoadUI()
		if _G.InspectFrame_Show then
			_G.InspectFrame_Show(unit)
		end
	end
	f.TimeManager_LoadUI = function() api.LoadAddOn("Blizzard_TimeManager") end
	f.Calendar_LoadUI = function() api.LoadAddOn("Blizzard_Calendar") end
	f.Arena_LoadUI = function() api.LoadAddOn("Blizzard_ArenaUI") end
	f.UpdateMicroButtons = noop
	f.MainMenuBar_UpdateKeyRing = noop
	f.MainMenuBarPerformanceBarFrame_OnEnter = function(self) _G.GameTooltip:SetOwner(self) _G.GameTooltip:AddLine("Latency") _G.GameTooltip:Show() end
	f.Minimap_OnClick = function() client.minimapPinged = true end
	f.Minimap_ZoomIn = function() _G.Minimap:SetZoom(_G.Minimap:GetZoom() + 1) end
	f.Minimap_ZoomOut = function() _G.Minimap:SetZoom(math.max(0, _G.Minimap:GetZoom() - 1)) end
	f.MiniMapTracking_Update = noop
	f.MiniMapLFGFrame_OnClick = noop
	f.BattlefieldFrame_UpdateStatus = noop
	f.PVPBattleground_UpdateQueueStatus = noop
	f.MiniMapBattlefieldDropDown_OnLoad = noop
	f.TargetofTarget_Update = noop
	f.MirrorTimer_Show = function(timer, value, maxvalue, scale, paused, label)
		for i = 1, 3 do
			local frame = _G["MirrorTimer" .. i]
			if not frame.timer or frame.timer == timer then
				frame.timer = timer
				frame.value = value / 1000
				frame.scale = scale
				_G["MirrorTimer" .. i .. "Text"]:SetText(label)
				_G["MirrorTimer" .. i .. "StatusBar"]:SetMinMaxValues(0, maxvalue / 1000)
				_G["MirrorTimer" .. i .. "StatusBar"]:SetValue(value / 1000)
				frame:Show()
				return frame
			end
		end
	end
	f.MirrorTimerFrame_OnUpdate = noop
	f.AutoCastShine_AutoCastStart = function(shine) shine.autocasting = true end
	f.AutoCastShine_AutoCastStop = function(shine) shine.autocasting = false end
	f.SetItemButtonTexture = function(b, texture)
		local icon = _G[b:GetName() .. "IconTexture"]
		if icon then icon:SetTexture(texture) end
	end
	f.SetItemButtonCount = function(b, count)
		local text = _G[b:GetName() .. "Count"]
		b.count = count
		if text then text:SetText(count and count > 1 and count or "") end
	end
	f.SetItemButtonDesaturated = noop
	f.SetItemButtonNormalTextureVertexColor = noop
	f.SetItemButtonTextureVertexColor = noop
	f.ContainerFrame_Update = noop
	f.ContainerFrame_GetOpenFrame = function() return _G.ContainerFrame1 end
	f.BankFrameItemButton_Update = noop
	f.PaperDollFrame_SetArmor = noop
	f.PaperDollItemSlotButton_Update = noop
	-- MerchantFrame.lua: the merchant's tab or the buyback one, by selectedTab
	f.MerchantFrame_UpdateMerchantInfo = noop
	f.MerchantFrame_UpdateBuybackInfo = noop
	f.MerchantFrame_Update = function()
		if (_G.MerchantFrame.selectedTab == 1) then
			_G.MerchantFrame_UpdateMerchantInfo()
		else
			_G.MerchantFrame_UpdateBuybackInfo()
		end
	end
	f.CharacterFrame_ShowSubFrame = noop
	f.ActionButton_UpdateHotkeys = noop
	f.ActionButton_Update = noop
	f.ActionButton_ShowGrid = noop
	f.ActionButton_HideGrid = noop
	f.PetActionBar_Update = noop
	f.ShapeshiftBar_Update = noop
	f.MultiActionBar_Update = noop
	f.UIParent_ManageFramePositions = noop
	f.VehicleMenuBar_MoveMicroButtons = noop
	f.ShowFriends = noop
	f.FriendsFrame_ShowDropdown = noop
	f.GuildFrame_Toggle = noop
	f.GuildStatus_Update = noop -- FriendsFrame.lua: the guild's roster
	f.GuildEventLog_Update = noop -- and its log

	-- time and number formatting
	f.SecondsToTime = function(seconds)
		seconds = math.floor(seconds or 0)
		if seconds >= 3600 then return string.format("%d Hr %d Min", seconds / 3600, (seconds % 3600) / 60) end
		if seconds >= 60 then return string.format("%d Min %d Sec", seconds / 60, seconds % 60) end
		return string.format("%d Sec", seconds)
	end
	f.SecondsToTimeAbbrev = function(seconds)
		if seconds >= 86400 then return "%d d", math.ceil(seconds / 86400) end
		if seconds >= 3600 then return "%d h", math.ceil(seconds / 3600) end
		if seconds >= 60 then return "%d m", math.ceil(seconds / 60) end
		return "%d s", seconds
	end
	f.GameTime_GetTime = function(showAMPM)
		local hour, minute = api.GetGameTime()
		return string.format("%02d:%02d", hour, minute)
	end
	f.GameTime_GetLocalTime = f.GameTime_GetTime
	f.GameTime_GetGameTime = f.GameTime_GetTime
	f.GameTime_ComputeMilitaryTime = function(hour) return hour end
	f.GameTime_ComputeStandardTime = function(hour) return hour > 12 and hour - 12 or hour, hour >= 12 and 1 or 0 end

	-- fades and flashes
	f.UIFrameFadeIn = function(frame, time, from, to) frame:SetAlpha(to or 1) frame:Show() end
	f.UIFrameFadeOut = function(frame, time, from, to) frame:SetAlpha(to or 0) end
	f.UIFrameFade = function(frame, info) frame:SetAlpha(info.endAlpha or 1) end
	f.UIFrameFadeRemoveFrame = noop
	f.UIFrameIsFading = function() return nil end
	f.UIFrameFlash = noop
	f.UIFrameFlashStop = noop
	f.UIFrameIsFlashing = function() return nil end

	-- misc
	f.EventTraceFrame_HandleSlashCmd = noop
	f.ScriptErrorsFrame_OnError = noop
	f.CombatLog_Object_IsA = function() return nil end
	f.RaidNotice_AddMessage = function(frame, text) frame:AddMessage(text) end
	f.PlaySound = api.PlaySound
	f.QuestLog_Update = noop
	f.WatchFrame_Update = noop
	f.WorldMapFrame_Update = noop
	-- a tracker line's text (WatchFrame.lua): titles in gold, the dash
	-- before an objective (1: shown, 2: hidden but its room kept)
	f.WatchFrame_SetLine = function(line, anchor, verticalOffset, isHeader, text, dash, hasItem, isComplete)
		line.text:SetText(text)
		if isHeader then
			line.text:SetTextColor(.75, .61, 0)
		end
		if (dash == 1) then
			line.dash:SetText("- ")
		elseif (dash == 2) then
			line.dash:SetText("- ")
			line.dash:Hide()
		end
	end
	f.MouseIsOver = function(frame) return frame:IsMouseOver() end
	f.WatchFrame_Expand = noop
	f.WatchFrame_Collapse = noop
	f.WorldStateAlwaysUpFrame_Update = noop
	f.ExtendedUI_Update = noop
	f.CaptureBar_Update = noop
	f.LFDSearchStatus_Update = noop
	f.BuffFrame_Update = noop
	f.TemporaryEnchantFrame_Update = noop
	f.DurabilityFrame_SetAlerts = noop
	f.VehicleSeatIndicator_SetUpVehicle = noop
	f.VehicleSeatIndicator_UnloadTextures = noop
	f.TotemFrame_Update = noop
	f.RuneFrame_OnLoad = noop
	f.CastingBarFrame_OnLoad = noop
	f.TextStatusBar_UpdateTextString = noop
	f.UnitFrame_Update = noop
	f.UnitFrameHealthBar_Update = noop
	f.UnitFrameManaBar_Update = noop
	f.PartyMemberFrame_UpdateMember = noop
	f.HidePartyFrame = noop
	f.ShowPartyFrame = noop
	f.RaidOptionsFrame_UpdatePartyFrames = noop
	f.TargetFrame_Update = noop
	f.FocusFrame_Update = noop
	f.ComboFrame_Update = noop
	f.PlayerFrame_Update = noop
	f.PetFrame_Update = noop
	f.LootFrame_Update = noop
	f.LootButton_OnClick = noop
	f.GroupLootFrame_OnShow = noop
	f.MoneyFrame_Update = noop
	f.SetMoneyFrameColor = noop
	f.RealPartyIsFull = function() return nil end
	f.AbbreviateLargeNumbers = nil -- Cataclysm
	f.BreakUpLargeNumbers = nil -- Cataclysm
	f.GetMouseFocus = api.GetMouseFocus
	return f
end

------------------------------------------------------------------------
-- Macro conditions, for state drivers
------------------------------------------------------------------------

local function installConditions(client)
	local api = client.api
	function client:EvaluateConditions(group)
		local unit = "target"
		local w = self.world
		for condition in (group .. ","):gmatch("%s*([^,]*),") do
			condition = condition:match("^%s*(.-)%s*$")
			if condition ~= "" then
				local negate = false
				if condition:sub(1, 2) == "no" and condition ~= "none" then
					negate, condition = true, condition:sub(3)
				end
				local name, arg = condition:match("^([^:]+):?(.*)$")
				local result
				if name:sub(1, 1) == "@" then
					unit, result = name:sub(2), true
				elseif name:match("^target=") then
					unit, result = name:sub(8), true
				elseif name == "combat" then
					result = w.inCombat
				elseif name == "vehicleui" then
					result = w.units.player.hasVehicleUI
				elseif name == "canexitvehicle" then
					result = w.units.player.inVehicle
				elseif name == "bonusbar" then
					result = (arg == "" and w.bonusBarOffset > 0) or (arg ~= "" and tostring(w.bonusBarOffset) == arg)
				elseif name == "possessbar" then
					result = w.possessBar
				elseif name == "actionbar" then
					result = tostring(w.actionBarPage) == arg
				elseif name == "stance" or name == "form" then
					local form = api.GetShapeshiftForm()
					result = (arg == "" and form > 0) or (arg ~= "" and tostring(form) == arg)
				elseif name == "mod" or name == "modifier" then
					local m = w.modifiers
					if arg == "" then
						result = m.shift or m.ctrl or m.alt
					else
						result = (arg == "shift" and m.shift) or (arg == "ctrl" and m.ctrl) or (arg == "alt" and m.alt)
					end
				elseif name == "exists" then
					result = api.UnitExists(unit)
				elseif name == "harm" then
					result = api.UnitCanAttack("player", unit)
				elseif name == "help" then
					result = api.UnitExists(unit) and not api.UnitCanAttack("player", unit)
				elseif name == "dead" then
					result = api.UnitIsDead(unit)
				elseif name == "pet" then
					result = api.UnitExists("pet")
				elseif name == "group" then
					if arg == "raid" then
						result = api.GetNumRaidMembers() > 0
					else
						result = api.GetNumPartyMembers() > 0 or api.GetNumRaidMembers() > 0
					end
				elseif name == "mounted" then
					result = w.mounted
				elseif name == "flying" then
					result = w.flying
				elseif name == "swimming" then
					result = w.swimming
				elseif name == "stealth" then
					result = w.stealthed
				elseif name == "indoors" then
					result = false
				elseif name == "outdoors" then
					result = true
				elseif name == "channeling" then
					result = w.units.player.channeling ~= nil
				elseif name == "flyable" then
					result = w.flyable
				elseif name == "petbattle" or name == "overridebar" or name == "extrabar" or name == "shapeshift" then
					result = false -- later expansions
				else
					result = false
				end
				if negate then
					result = not result
				end
				if not result then
					return false
				end
			end
		end
		return true
	end
end

------------------------------------------------------------------------
-- Nameplates
------------------------------------------------------------------------

-- 3.3.5's nameplates: unnamed children of WorldFrame the client makes for
-- units in view. Addons find them by their first region's texture and read
-- everything from their regions: the name and level texts, the health bar
-- (its color tells the reaction or class), the elite/boss/raid icons, the
-- threat glow's color, the highlight on mouseover, and the frame's alpha
-- (1 for the current target).
--
-- spec: name, level (nil: "??"), health, healthMax, color = { r, g, b },
-- elite, rare, boss, raidIcon = { l, r, t, b }, threat (0-3), inCombat,
-- mouseover, target, hidden
local THREAT_COLORS = { [0] = { 0, 0, 0 }, { 1, 1, 0.47 }, { 1, 0.6, 0 }, { 1, 0, 0 } }

function Blizzard.addNamePlate(client, spec)
	local plate = new("Frame", nil, _G.WorldFrame)
	plate:SetSize(128, 32)
	plate:SetPoint("BOTTOMLEFT", _G.WorldFrame, "BOTTOMLEFT", spec.x or 500, spec.y or 400)
	local health = statusBar(nil, plate)
	local cast = hidden(statusBar(nil, plate))
	local threat = new("Texture", nil, plate)
	threat:SetTexture([[Interface\TargetingFrame\UI-TargetingFrame-Flash]])
	local regions = {
		threat = threat,
		healthborder = new("Texture", nil, plate),
		castshield = new("Texture", nil, plate),
		castborder = new("Texture", nil, plate),
		casticon = new("Texture", nil, plate),
		highlight = new("Texture", nil, plate),
		name = new("FontString", nil, plate),
		level = new("FontString", nil, plate),
		bossicon = new("Texture", nil, plate),
		raidicon = new("Texture", nil, plate),
		eliteicon = new("Texture", nil, plate),
	}
	local nameplate = { frame = plate, health = health, cast = cast, regions = regions }
	function nameplate:Update(changes)
		for key, value in pairs(changes or {}) do
			spec[key] = value
		end
		regions.name:SetText(spec.name or "Unknown")
		if spec.inCombat then
			regions.name:SetTextColor(1, 0.1, 0.1)
		else
			regions.name:SetTextColor(1, 1, 1)
		end
		regions.level:SetText(spec.level and tostring(spec.level) or "??")
		health:SetMinMaxValues(0, spec.healthMax or 100)
		health:SetValue(spec.health or spec.healthMax or 100)
		local color = spec.color or { 1, 0, 0 }
		health:SetStatusBarColor(color[1], color[2], color[3])
		if spec.threat then
			threat:Show()
			local c = THREAT_COLORS[spec.threat]
			threat:SetVertexColor(c[1], c[2], c[3])
		else
			threat:Hide()
		end
		regions.eliteicon:SetTexture([[Interface\Tooltips\EliteNameplateIcon]])
		if spec.elite or spec.rare then
			regions.eliteicon:Show()
			if spec.rare then
				regions.eliteicon:SetVertexColor(0.75, 0.75, 0.75)
			else
				regions.eliteicon:SetVertexColor(1, 1, 1)
			end
		else
			regions.eliteicon:Hide()
		end
		if spec.boss then regions.bossicon:Show() else regions.bossicon:Hide() end
		if spec.raidIcon then
			regions.raidicon:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
			regions.raidicon:SetTexCoord(unpack(spec.raidIcon))
			regions.raidicon:Show()
		else
			regions.raidicon:Hide()
		end
		if spec.mouseover then regions.highlight:Show() else regions.highlight:Hide() end
		plate:SetAlpha(spec.target and 1 or 0.5)
		if spec.hidden then plate:Hide() else plate:Show() end
	end
	nameplate:Update()
	client.namePlates[#client.namePlates + 1] = nameplate
	return nameplate
end

------------------------------------------------------------------------
-- Install
------------------------------------------------------------------------

function Blizzard.install(owner)
	client = owner
	client.chatFilters = {}
	client.dropDownButtons = {}
	client.optionsPanels = {}
	client.snippets = {}
	client.namePlates = {}
	installConditions(client)

	for name, value in pairs(constants()) do
		_G[name] = value
	end
	for name, fn in pairs(frameXML(client)) do
		_G[name] = fn
	end
	client.api.SecureCmdOptionParse = _G.SecureCmdOptionParse
	for _, name in ipairs(FONTS) do
		Widgets.new("Font", name)
	end

	_G.UIParent = Widgets.newScreen("UIParent", 1920, 1080)
	_G.WorldFrame = Widgets.newScreen("WorldFrame", 1920, 1080)
	buildFrames()

	-- Blizzard's load-on-demand addons: in the addon list, loaded on request
	for _, name in ipairs({ "Blizzard_TimeManager", "Blizzard_TalentUI", "Blizzard_InspectUI",
		"Blizzard_CombatText", "Blizzard_DebugTools", "Blizzard_ArenaUI", "Blizzard_Calendar",
		"Blizzard_AchievementUI", "Blizzard_TradeSkillUI", "Blizzard_TokenUI", "Blizzard_GlyphUI", "Blizzard_AuctionUI",
		"Blizzard_MacroUI", "Blizzard_TrainerUI", "Blizzard_GuildBankUI", "Blizzard_ItemSocketingUI", "Blizzard_BindingUI" }) do
		table.insert(client.world.addons, { name = name, title = name, enabled = true, loadOnDemand = true, blizzard = true })
	end
	local loadAddOn = client.api.LoadAddOn
	client.api.LoadAddOn = function(name)
		local build = ON_DEMAND[name]
		if name and (name:find("^Blizzard_")) and not client.loadedOnDemand[name] then
			client.loadedOnDemand[name] = true
			if build then
				build()
			end
			fromFrameXML(name)
		end
		return loadAddOn(name)
	end
	client.loadedOnDemand = {}
	_G.LoadAddOn = client.api.LoadAddOn

	-- whatever else is read: ALL CAPS strings read as their own name,
	-- anything else nil. Slash command names (SLASH_<KEY><n>) are nil
	-- unless registered: lookups walk them until the first missing one.
	setmetatable(_G, {
		__index = function(_, key)
			if type(key) ~= "string" then
				return nil
			end
			client.missing[key] = (client.missing[key] or 0) + 1
			if key:match("^[%u%d_]+$") and key:match("%u") and not NIL_CAPS[key] and not key:match("^SLASH_") then
				return key
			end
			return nil
		end,
	})
end

return Blizzard
