local ADDON, Engine = ...

-- Lua API
local math_floor = math.floor
local select = select
local unpack = unpack

local _, playerClass = UnitClass("player")

local hex = function(r, g, b)
	return ("|cff%02x%02x%02x"):format(math_floor(r*255), math_floor(g*255), math_floor(b*255))
end

local prepare = function(...)
	local tbl
	if select("#", ...) == 1 then
		local old = ...
		if old.r then 
			tbl = {}
			tbl[1] = old.r or 1
			tbl[2] = old.g or 1
			tbl[3] = old.b or 1
		else
			tbl = { unpack(old) }
		end
	else
		tbl = { ... }
	end
	if #tbl == 3 then
		tbl.colorCode = hex(unpack(tbl))
	end
	return tbl
end

local C = {
	-- General coloring
	General = {
		-- Standard colors used by most modules
		Normal 			= prepare( 229/255, 178/255,  38/255 ),
		Highlight 		= prepare( 250/255, 250/255, 250/255 ),
		Title 			= prepare( 255/255, 234/255, 137/255 ),

		Gray 			= prepare( 120/255, 120/255, 120/255 ),
		Green 			= prepare(  38/255, 201/255,  38/255 ),
		Gold 			= prepare( 255/255, 180/255,  64/255 ),
		Orange 			= prepare( 255/255, 128/255,  64/255 ),
		Blue 			= prepare(  64/255, 128/255, 255/255 ),

		DarkRed 		= prepare( 178/255,  25/255,  25/255 ),
		DimRed 			= prepare( 204/255,  26/255,  26/255 ),
		OffGreen 		= prepare(  89/255, 201/255,  89/255 ),
		OffWhite 		= prepare( 201/255, 201/255, 201/255 ),

		-- XP Bar coloring
		XP 				= prepare( 251/255, 120/255,  29/255 ), -- also used for buffs... gotta fix that
		XPRested 		= prepare( 251/255, 120/255,  29/255 ), 
		XPRestedBonus 	= prepare(  84/255,  40/255,   9/255 ),
		XPBright 		= prepare( 255/255, 214/255, 137/255 ), 
		XPRestedBright 	= prepare( 255/255, 214/255, 137/255 ), 
		XPBonusBright 	= prepare(  85/255,  71/255,  46/255 ),
		XPComplimentary = prepare(  33/255,  82/255, 166/255 ),
		Honor 			= prepare( 230/255, 204/255, 128/255 ),

		-- UI Colors
		UIBackdrop 		= prepare( 140/255, 118/255, 110/255 ),
		UIBorder 		= prepare(  70/255,  59/255,  55/255 ),
		UIOverlay 		= prepare(  51/255,  17/255,   6/255 ),

		-- Fallback health color for tooltips
		HealthGreen 	= prepare(  64/255, 131/255,  38/255 ),

		-- gear information about inspected players
		Prefix 			= prepare( 255/255, 238/255, 170/255 ),
		Detail 			= prepare( 250/255, 250/255, 250/255 ),
		BoA 			= prepare( 230/255, 204/255, 128/255 ), 
		PvP 			= prepare( 163/255,  53/255, 238/255 )
	
	},

	-- Unit Class Coloring (slightly different from Blizzard's)
	Class = {
		DEATHKNIGHT 	= prepare( 176/255,  31/255,  79/255 ), -- slightly more blue, less red, to stand out from angry mobs better
		DEMONHUNTER 	= prepare( 163/255,  48/255, 201/255 ),
		DRUID 			= prepare( 255/255, 125/255,  10/255 ),
		HUNTER 			= prepare( 191/255, 232/255, 115/255 ), -- slightly more green and yellow, to stand more out from friendly players/npcs
		MAGE 			= prepare( 105/255, 204/255, 240/255 ),
		MONK 			= prepare(   0/255, 255/255, 150/255 ),
		PALADIN 		= prepare( 245/255, 140/255, 186/255 ), -- original 
		PRIEST 			= prepare( 220/255, 235/255, 250/255 ), -- tilted slightly towards blue, and somewhat toned down. chilly.
		ROGUE 			= prepare( 255/255, 225/255,  95/255 ), -- slightly more orange than Blizz, to avoid the green effect when shaded with black
		SHAMAN 			= prepare(  32/255, 122/255, 222/255 ), -- brighter, to move it a bit away from the mana color
		WARLOCK 		= prepare( 148/255, 130/255, 201/255 ),
		WARRIOR 		= prepare( 199/255, 156/255, 110/255 ),
		UNKNOWN 		= prepare( 195/255, 202/255, 217/255 )
	},

	-- aura coloring
	Debuff = {
		none 			= prepare( 204/255,   0/255,   0/255 ),
		Magic 			= prepare(  51/255, 153/255, 255/255 ),
		Curse 			= prepare( 204/255,   0/255, 255/255 ),
		Disease 		= prepare( 153/255, 102/255,   0/255 ),
		Poison 			= prepare(   0/255, 153/255,   0/255 ),
		[""] 			= prepare(   0/255,   0/255,   0/255 )
	},

	Faction = {
		Alliance 		= prepare(  74/255,  84/255, 232/255 ), -- Alliance
		Horde 			= prepare( 229/255,  13/255,  18/255 ), -- Horde
		Neutral 		= prepare( 192/255, 192/255, 133/255 )
		--Neutral 		= prepare( 255/255, 255/255, 178/255 )
	},

	-- Unit Friendships
	Friendship = {
		[1] = prepare( 192/255,  68/255,   0/255 ), -- Stranger
		[2] = prepare( 249/255, 178/255,  35/255 ), -- Acquaintance 
		[3] = prepare(  64/255, 131/255,  38/255 ), -- Buddy
		[4]	= prepare(  64/255, 131/255,  69/255 ), -- Friend (honored color)
		[5]	= prepare(  64/255, 131/255, 104/255 ), -- Good Friend (revered color)
		[6]	= prepare(  64/255, 131/255, 131/255 ), -- Best Friend (exalted color)
		[7]	= prepare(  64/255, 131/255, 131/255 ), -- Best Friend (exalted color) - brawler's stuff
		[8]	= prepare(  64/255, 131/255, 131/255 ), -- Best Friend (exalted color) - brawler's stuff
	},

	-- Orb color groups
	-- 	*Most of these could be done by a single RGB color and a smart script, 
	-- 	 but for now we will leave it as it is. 
	-- 	 It allows for some unusual combinations this way. 
	Orb = {
		-- Blood Color (Health fallback color for various modules)
		HEALTH = {
			{ 178/255,  10/255,  10/255,  1, "bar" },
			{ 178/255,  10/255,  10/255, .9, "moon" },
			{ 139/255,  10/255,  10/255, .5, "smoke" },
			{   0/255,   0/255,   0/255,  1, "shade" }	
		},

		-- Power Colors
		CHI = {
			{  91/255, 127/255, 117/255,  1, "bar" },
			{  91/255, 127/255, 117/255, .9, "moon" },
			{ 181/255, 255/255, 234/255, .5, "smoke" },
			{   8/255,  25/255,  13/255,  1, "shade" }
		},
		ENERGY = (playerClass == "DRUID" or playerClass == "MONK") and {
			{ 122/255,  82/255,  72/255,  1, "bar" },
			{ 122/255,  82/255,  72/255, .9, "moon" },
			{ 254/255, 245/255, 145/255, .5, "smoke" },
			{  55/255,  25/255,   4/255,  1, "shade" }
		} or {
			{  94/255,  42/255,   7/255,  1, "bar" },
			{ 157/255,  84/255,  13/255, .9, "moon" },
			{ 255/255, 188/255,  25/255, .5, "smoke" },
			{  35/255,  12/255,   2/255,  1, "shade" }
		},
		FOCUS = {
			{ 250/255, 125/255,  62/255,  1, "bar" },
			{ 255/255, 127/255,  63/255, .9, "moon" },
			{ 218/255, 109/255,  54/255, .5, "smoke" },
			{ 139/255,  69/255,  34/255,  1, "shade" }
		},
		FURY = {
			{ 121/255,  53/255, 146/255,  1, "bar" },
			{ 121/255,  53/255, 146/255, .9, "moon" },
			{ 201/255,  66/255, 253/255, .5, "smoke" },
			{  10/255,   3/255,  12/255,  1, "shade" }
		},
		HOLY_POWER = {
			{ 122/255,  82/255,  72/255,  1, "bar" },
			{ 122/255,  82/255,  72/255, .9, "moon" },
			{ 245/255, 254/255, 145/255, .5, "smoke" },
			{  55/255,  25/255,   4/255,  1, "shade" }
		},
		INSANITY = {
			{  26/255,   2/255,  31/255,  1, "bar" },
			{  51/255,   8/255,  72/255, .9, "moon" },
			{ 102/255,  34/255, 204/255, .5, "smoke" },
			{  10/255,   3/255,  23/255,  1, "shade" }
		},
		LUNAR_POWER = {	
			{  31/255,  38/255,  48/255,  1, "bar" },
			{  61/255,  76/255,  96/255, .9, "moon" },
			{ 121/255, 152/255, 192/255, .5, "smoke" },
			{   1/255,   5/255,  19/255,  1, "shade" }
		},
		
		MAELSTROM = {
			{  24/255,  40/255,  64/255,  1, "bar" },
			{  48/255,  80/255, 127/255, .9, "moon" },
			{  96/255, 160/255, 255/255, .5, "smoke" },
			{   1/255,   6/255,  25/255,  1, "shade" }
		},
		MANA = (playerClass == "DRUID" or playerClass == "MONK") and {
			{   4/255,  17/255,  64/255,  1, "bar" },
			{   9/255,  34/255, 127/255, .9, "moon" },
			{  27/255, 102/255, 255/255, .4, "smoke" },
			{   0/255,   3/255,  23/255,  1, "shade" }
		} or {
			{   4/255,  17/255,  64/255,  1, "bar" },
			{   9/255,  34/255, 127/255, .9, "moon" },
			{  18/255,  68/255, 255/255, .5, "smoke" },
			{   0/255,   3/255,  23/255,  1, "shade" }
		}, 
		PAIN = {
			{  88/255,  52/255,   0/255,  1, "bar" },
			{  88/255,  52/255,   0/255, .9, "moon" },
			{ 237/255, 105/255,   0/255, .5, "smoke" },
			{  21/255,  10/255,   0/255,  1, "shade" }
		},
		RAGE = {
			{  78/255,   5/255,   0/255,  1, "bar" },
			{  78/255,   5/255,   0/255, .9, "moon" },
			{ 239/255,  10/255,   0/255, .5, "smoke" },
			{  24/255,   5/255,   0/255,  1, "shade" }
		},
		RUNIC_POWER = {
			{  83/255, 124/255, 127/255,  1, "bar" },
			{  83/255, 124/255, 127/255, .9, "moon" },
			{ 166/255, 239/255, 255/255, .5, "smoke" },
			{   6/255,  12/255,  35/255,  1, "shade" }
		},

		-- Pet Happines
		HAPPINESS = {
			{   0/255, 255/255, 255/255,  1, "bar" },
			{   0/255, 255/255, 255/255, .9, "moon" },
			{   0/255, 255/255, 255/255, .5, "smoke" },
			{   0/255,   0/255,   0/255,  1, "shade" }
		},

		-- Vehicles
		AMMOSLOT = {
			{ 204/255, 153/255,   0/255,  1, "bar" },
			{ 204/255, 153/255,   0/255, .9, "moon" },
			{ 204/255, 153/255,   0/255, .5, "smoke" },
			{   0/255,   0/255,   0/255,  1, "shade" }
		},
		FUEL = {
			{   0/255, 140/255, 127/255,  1, "bar" },
			{   0/255, 140/255, 127/255, .9, "moon" },
			{   0/255, 140/255, 127/255, .5, "smoke" },
			{   0/255,   0/255,   0/255,  1, "shade" }
		},
		POWER_TYPE_FEL_ENERGY = {
			{  56/255,  46/255,   0/255,  1, "bar" },
			{ 112/255,  91/255,   0/255, .9, "moon" },
			{ 224/255, 250/255,   0/255, .5, "smoke" },
			{  24/255,  25/255,   0/255,  1, "shade" }
		},
		POWER_TYPE_PYRITE = {
			{   0/255,  41/255,  65/255,  1, "bar" },
			{   0/255,  91/255, 127/255, .9, "moon" },
			{   0/255, 182/255, 255/255, .5, "smoke" },
			{   0/255,  12/255,  25/255,  1, "shade" }
		},
		POWER_TYPE_STEAM = {
			{  61/255,  61/255,  61/255,  1, "bar" },
			{ 121/255, 121/255, 121/255, .9, "moon" },
			{ 242/255, 242/255, 242/255, .5, "smoke" },
			{  24/255,  24/255,  24/255,  1, "shade" }
		},
		POWER_TYPE_HEAT = {
			{  64/255,  31/255,   0/255,  1, "bar" },
			{ 127/255,  63/255,   0/255, .9, "moon" },
			{ 255/255, 125/255,   0/255, .5, "smoke" },
			{  25/255,   9/255,   0/255,  1, "shade" }
		},
		POWER_TYPE_BLOOD_POWER = {
			{  47/255,   0/255,  65/255,  1, "bar" },
			{  94/255,   0/255, 127/255, .9, "moon" },
			{ 188/255,   0/255, 255/255, .5, "smoke" },
			{  18/255,   0/255,  25/255,  1, "shade" }
		},
		POWER_TYPE_OOZE = {
			{  49/255,  65/255,   0/255,  1, "bar" },
			{  97/255, 127/255,   0/255, .9, "moon" },
			{ 193/255, 255/255,   0/255, .5, "smoke" },
			{  18/255,   0/255,   0/255,  1, "shade" }
		},


		-- Class Colors
		-- *These are designed to look good through the orb overlay textures,  
		--  meaning they are often darker and a lot more tilted towards 
		--  red and orange than their original counterparts. 
		--  If we don't do this, the orbs will look green and washed out! :o
		DEATHKNIGHT = {
			{  98/255,  16/255,  19/255,  1, "bar" },
			{  98/255,  16/255,  19/255, .9, "moon" },
			{ 226/255,  21/255,  39/255, .5, "smoke" }, 
			{  22/255,   2/255,   3/255,  1, "shade" } 
		},
		DEMONHUNTER = {
			{  62/255,   4/255,  81/255,  1, "bar" },
			{  62/255,   4/255,  81/255, .9, "moon" },
			{ 163/255,  48/255, 201/255, .5, "smoke" },
			{  16/255,   4/255,  20/255,  1, "shade" }
		},
		DRUID = {
			{  84/255,  27/255,   2/255,  1, "bar" },
			{ 127/255,  43/255,   5/255, .9, "moon" },
			{ 255/255, 105/255,  10/255, .5, "smoke" },
			{  25/255,   4/255,   1/255,  1, "shade" }	
		},
		HUNTER = {
			{  85/255, 106/255,  56/255,  1, "bar" },
			{  85/255, 106/255,  56/255, .9, "moon" },
			{ 171/255, 212/255, 115/255, .5, "smoke" },
			{   7/255,  21/255,   1/255,  1, "shade" }
		},
		MAGE = {
			{  26/255,  51/255,  60/255,  1, "bar" },
			{  52/255, 102/255, 180/255, .9, "moon" },
			{ 105/255, 204/255, 240/255, .5, "smoke" },
			{   5/255,  10/255,  44/255,  1, "shade" }
		},
		MONK = {
			{   0/255, 127/255,  75/255,  1, "bar" },
			{   0/255, 127/255,  75/255, .9, "moon" },
			{   0/255, 255/255, 150/255, .5, "smoke" },
			{   0/255,  25/255,  15/255,  1, "shade" }
		},
		PALADIN = {
			{ 122/255,  40/255,  63/255,  1, "bar" },
			{ 122/255,  40/255,  63/255, .9, "moon" },
			{ 245/255, 140/255, 186/255, .5, "smoke" },
			{  24/255,  14/255,  18/255,  1, "shade" }
		},
		PRIEST = {
			{  55/255,  58/255,  62/255,  1, "bar" },
			{ 110/255, 117/255, 125/255, .9, "moon" },
			{ 220/255, 235/255, 250/255, .5, "smoke" },
			{  22/255,  23/255,  44/255,  1, "shade" }
		},
		ROGUE = {
			{  94/255,  57/255,  33/255,  1, "bar" },
			{ 167/255, 113/255,  65/255, .9, "moon" },
			{ 255/255, 225/255,  85/255, .5, "smoke" },
			{  25/255,  12/255,   8/255,  1, "shade" }
		}, 
		SHAMAN = {
			{   0/255,  34/255, 127/255,  1, "bar" },
			{   0/255,  34/255, 127/255, .9, "moon" },
			{  32/255, 112/255, 222/255, .5, "smoke" },
			{   0/255,   6/255,  42/255,  1, "shade" }
		},
		WARLOCK = {
			{  74/255,  65/255, 101/255,  1, "bar" },
			{  74/255,  65/255, 101/255, .9, "moon" },
			{ 148/255, 130/255, 201/255, .5, "smoke" },
			{  14/255,  13/255,  20/255,  1, "shade" }
		}, 
		WARRIOR = {
			{ 159/255, 124/255,  88/255,  1, "bar" },
			{ 159/255, 124/255,  88/255, .9, "moon" },
			{ 199/255, 156/255, 110/255, .5, "smoke" },
			{  19/255,  15/255,  11/255,  1, "shade" }
		}

	},

	-- Unit Power 
	Power = {
		-- Primary Resources
		CHI 					= prepare(181/255, 255/255, 234/255), -- Monk (MoP)
		ENERGY 					= prepare(255/255, 168/255,  25/255), -- Rogues, Druids, Monks (MoP)
		FOCUS 					= prepare(255/255, 128/255,  64/255), -- Hunters (Cata) and Hunter Pets
		FURY 					= prepare(192/255,  89/255, 217/255), -- Vengeance Demon Hunter (Legion)
		HOLY_POWER 				= prepare(245/255, 254/255, 145/255), -- Paladins (All in Cata, only Retribution in Legion)
		INSANITY 				= prepare(102/255,  64/255, 204/255), -- Shadow Priests (Legion)
		LUNAR_POWER 			= prepare(121/255, 152/255, 192/255), -- Balance Druid Astral Power in (Legion)
		MAELSTROM 				= prepare( 96/255, 160/255, 255/255), -- Shamans (Legion)
		MANA 					= prepare( 18/255,  68/255, 255/255), -- Druid, Hunter (WotLK), Mage, Monk, Paladin, Priest, Shaman, Warlock
		PAIN 					= prepare(217/255, 105/255,   0/255), -- Havoc Demon Hunter (Legion)
		RAGE 					= prepare(255/255,   0/255,   0/255), -- Druids, Warriors
		RUNIC_POWER 			= prepare(  0/255, 209/255, 255/255), -- Death Knights
		COMBO_POINTS 			= prepare(220/255, 68/255,  25/255), -- All

		-- Point based secondary resources
		ARCANE_CHARGES 			= prepare(121/255, 152/255, 192/255), -- Arcane Mage
		BURNING_EMBERS 			= prepare(151/255,  45/255,  24/255), -- Destruction Warlock (Cata, MoP, WoD)
		DEMONIC_FURY 			= prepare(105/255,  53/255, 142/255), -- Demonology Warlock (MoP, WoD)
		ECLIPSE = { 
			negative 			= prepare( 90/255, 110/255, 172/255), -- Balance Druid (WotLK, Cata, MoP, WoD)
			positive 			= prepare(255/255, 211/255, 117/255)  -- Balance Druid (WotLK, Cata, MoP, WoD)
		},
		RUNES 					= prepare(100/255, 155/255, 225/255), -- Death Knight (Legion) (only one rune type now)
		RUNES_BLOOD 			= prepare(196/255,  31/255,  60/255), -- Death Knight (WotLK, Cata, MoP, WoD)
		RUNES_UNHOLY 			= prepare( 73/255, 180/255,  28/255), -- Death Knight (WotLK, Cata, MoP, WoD)
		RUNES_FROST 			= prepare( 63/255, 103/255, 154/255), -- Death Knight (WotLK, Cata, MoP, WoD)
		RUNES_DEATH 			= prepare(173/255,  62/255, 145/255), -- Death Knight (WotLK, Cata, MoP, WoD)
		SHADOW_ORBS 			= prepare(128/255, 128/255, 192/255), -- Shadow Priest (Cata, MoP) 
		SOUL_SHARDS 			= prepare(148/255, 130/255, 201/255), -- Warlock (All in Cata, Legion, Affliction only in MoP, WoD)

		-- Pets
		HAPPINESS 				= prepare(  0/255, 255/255, 255/255),

		-- Vehicles
		AMMOSLOT 				= prepare(204/255, 153/255,   0/255),
		FUEL 					= prepare(  0/255, 140/255, 127/255),
		POWER_TYPE_FEL_ENERGY 	= prepare(224/255, 250/255,   0/255),
		POWER_TYPE_PYRITE 		= prepare(  0/255, 202/255, 255/255),
		POWER_TYPE_STEAM 		= prepare(242/255, 242/255, 242/255),
		POWER_TYPE_HEAT 		= prepare(255/255, 125/255,   0/255),
		POWER_TYPE_BLOOD_POWER 	= prepare(188/255,   0/255, 255/255),
		POWER_TYPE_OOZE 		= prepare(193/255, 255/255,   0/255),
		STAGGER = { 
								  prepare(132/255, 255/255, 132/255), 
								  prepare(255/255, 250/255, 183/255), 
								  prepare(255/255, 107/255, 107/255) 
		},
		UNUSED 					= prepare(195/255, 202/255, 217/255)  -- Fallback for the rare cases where an unknown type is requested.
	},

	-- Added later on
	Quality = {

	},

	-- World Quest Rarity
	WorldQuestRarity = {
	},

	-- Unit Reactions
	Reaction = {
		[1] 			= prepare( 205/255,  46/255,  36/255 ), -- hated
		[2] 			= prepare( 205/255,  46/255,  36/255 ), -- hostile
		[3] 			= prepare( 192/255,  68/255,   0/255 ), -- unfriendly
		[4] 			= prepare( 249/255, 158/255,  35/255 ), -- neutral 
		[5] 			= prepare(  64/255, 131/255,  38/255 ), -- friendly
		[6] 			= prepare(  64/255, 131/255,  69/255 ), -- honored
		[7] 			= prepare(  64/255, 131/255, 104/255 ), -- revered
		[8] 			= prepare(  64/255, 131/255, 131/255 ), -- exalted
		civilian 		= prepare(  64/255, 131/255,  38/255 )  -- used for friendly player nameplates
	},

	-- Various Unit statuses
	Status = {
		Disconnected 	= prepare( 120/255, 120/255, 120/255 ), -- the color of offline players
		Dead 			= prepare(  73/255,  25/255,   9/255 ), -- the color of dead or ghosted units
		Tapped 			= prepare( 161/255, 141/255, 120/255 ), -- the color of units that can't be tapped by the player
		OutOfMana 		= prepare(  77/255,  77/255, 179/255 ), -- overlay or vertex coloring for spells you lack mana to cast
		OutOfRange 		= prepare( 255/255,   0/255,   0/255 )  -- overlay or vertex coloring for spells with an out of range target
	},

	-- Timers (breath, fatigue, etc)
	Timer = {
		UNKNOWN 		= prepare( 179/255,  77/255,   0/255 ), -- fallback for timers and unknowns
		EXHAUSTION 		= prepare( 179/255,  77/255,   0/255 ),
		BREATH 			= prepare(   0/255, 128/255, 255/255 ),
		DEATH 			= prepare( 217/255,  90/255,   0/255 ), 
		FEIGNDEATH 		= prepare( 217/255,  90/255,   0/255 ) 
	},

	-- Threat Situation
	-- similar returns as from GetThreatStatusColor(i)
	Threat = {
		[0] 			= prepare( 175/255, 165/255, 155/255 ), -- gray, low on threat
		[1] 			= prepare( 255/255, 128/255,  64/255 ), -- light yellow, you are overnuking 
		[2] 			= prepare( 255/255,  64/255,  12/255 ), -- orange, tanks that are losing threat
		[3] 			= prepare( 255/255,   0/255,   0/255 ) -- red, you securely tanking, or totally fucked :) 
	},

	-- Zone Coloring
	Zone = {
		sanctuary 	= prepare( 104/255, 204/255, 239/255 ), 
		arena 		= prepare( 175/255,  76/255,  56/255 ),
		friendly 	= prepare(  64/255, 175/255,  38/255 ), 
		hostile 	= prepare( 175/255,  76/255,  56/255 ), 
		contested 	= prepare( 229/255, 159/255,  28/255 ),
		combat 		= prepare( 175/255,  76/255,  56/255 ), 

		-- instances, bgs, contested zones on pve realms 
		unknown 	= prepare( 255/255, 234/255, 137/255 )
	}
}

for i in pairs(ITEM_QUALITY_COLORS) do
	local r, g, b = ITEM_QUALITY_COLORS[i].r, ITEM_QUALITY_COLORS[i].g, ITEM_QUALITY_COLORS[i].b
	C.Quality[i] = prepare(r, g, b)
end

C.WorldQuestRarity[LE_WORLD_QUEST_QUALITY_COMMON] = C.Quality[1]
C.WorldQuestRarity[LE_WORLD_QUEST_QUALITY_RARE] = C.Quality[3]
C.WorldQuestRarity[LE_WORLD_QUEST_QUALITY_EPIC] = C.Quality[4]

-- Allow us to use power type index to get the color
C.Power[0] = C.Power.MANA
C.Power[1] = C.Power.RAGE
C.Power[2] = C.Power.FOCUS
C.Power[3] = C.Power.ENERGY
C.Power[4] = C.Power.HAPPINESS
C.Power[5] = C.Power.RUNES
C.Power[6] = C.Power.RUNIC_POWER
C.Power[7] = C.Power.SOUL_SHARDS
C.Power[8] = C.Power.LUNAR_POWER
C.Power[9] = C.Power.HOLY_POWER
C.Power[11] = C.Power.MAELSTROM
C.Power[13] = C.Power.INSANITY
C.Power[17] = C.Power.FURY
C.Power[18] = C.Power.PAIN

Engine:NewStaticConfig("Data: Colors", C)
