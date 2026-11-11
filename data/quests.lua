local _, Engine = ...

-- This database will contain lists of quests
-- that for some reason reports the wrong zone.
-- *Eventually we will add lists of dailies to
-- auto-accept, auto-complete and similar stuff.

-- MapIDs retrieved from: http://wow.gamepedia.com/MapID
local questZones = {

	-- Icecrown dailies (WotLK)
	[13716] = 492, -- The Valiant's Charge
	[13752] = 490, -- A Blade Fit For A Champion
	[13789] = 492, -- Taking The Battle To The Enemy
	[14076] = 495, -- Breakfast Of Champions
	[14090] = 495, -- Gormok Wants His Snobolds
	[14096] = 492, -- You've Really Done It This Time, Kul
	[14112] = 492, -- What Do You Feed A Yeti Anyways?

	-- Death Knight starter zone (WotLK)
	[12593] = 502, -- In Service Of The Lich King
	[12619] = 502, -- The Emblazoned Runeblade
	[12636] = 502, -- The Eye Of Acherus
	[12641] = 502, -- Death Comes From On High
	[12657] = 502, -- The Might Of The Scourge
	[12670] = 502, -- The Scarlet Harvest
	[12678] = 502, -- If Chaos Drives, Let Suffering Hold The Reins
	[12679] = 502, -- Tonight We Dine In Havenshire
	[12680] = 502, -- Grand Theft Palomino
	[12687] = 502, -- Into The Realm Of Shadows
	[12697] = 502, -- Gothik The Harvester
	[12698] = 502, -- The Gift That Keeps On Giving
	[12700] = 502, -- An Attack Of Opportunity
	[12701] = 502, -- Massacre At Light's Point
	[12707] = 502, -- Victory At Death's Breach
	[12711] = 502, -- Abandoned Mail
	[12714] = 502, -- The Will Of The Lich King
	[12715] = 502, -- The Crypt Of Remembrance
	[12717] = 502, -- Noth's Special Brew
	[12718] = 502, -- More Skulls For Brew
	[12719] = 502, -- Nowhere To Run And Nowhere To Hide
	[12720] = 502, -- How To Win Friends And Influence Enemies
	[12722] = 502, -- Lambs To The Slaughter
	[12723] = 502, -- Behind Scarlet Lines
	[12724] = 502, -- The Path Of The Righteous Crusader
	[12725] = 502, -- Brothers In Death
	[12727] = 502, -- A Bloody Breakout
	[12733] = 502, -- Death's Challenge
	[12738] = 502, -- A Cry For Vengeance!
	[12739] = 502, -- A Special Surprise (Tauren)
	[12742] = 502, -- A Special Surprise (Human)
	[12743] = 502, -- A Special Surprise (Night Elf)
	[12744] = 502, -- A Special Surprise (Dwarf)
	[12745] = 502, -- A Special Surprise (Gnome)
	[12746] = 502, -- A Special Surprise (Draenei)
	[12747] = 502, -- A Special Surprise (Blood Elf)
	[12748] = 502, -- A Special Surprise (Orc)
	[12749] = 502, -- A Special Surprise (Troll)
	[12750] = 502, -- A Special Surprise (Undead)
	[12751] = 502, -- A Sort Of Homecoming
	[12754] = 502, -- Ambush At The Overlook
	[12755] = 502, -- A Meeting With Fate
	[12756] = 502, -- The Scarlet Onslaught Emerges
	[12757] = 502, -- Scarlet Armies Approach...
	[12778] = 502, -- The Scarlet Apocalypse
	[12779] = 502, -- An End To All Things...
	[12800] = 502, -- The Lich King's Command
	[12801] = 502, -- The Light Of Dawn
	[12842] = 502, -- Runeforging: Preperation For Battle
	[12848] = 502, -- The Endless Hunger
	[12850] = 502, -- Report To Scourge Commander Thalanor
	[13165] = 502, -- Taking Back Acherus
	[13166] = 502, -- The Battle For Ebon Hold
	[13188] = 301, -- Where Kings Walk
	[13189] = 321, -- Saurfang's Blessing
}

Engine:NewStaticConfig("Data: QuestZones", questZones)
