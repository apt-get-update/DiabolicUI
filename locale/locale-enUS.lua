-- English strings, and the reference list of every locale key. `L[key] = true`
-- means the text is the key itself; other locale files only translate keys
-- listed here (tests/test_locales.lua checks that).
local _, Engine = ...

local L = Engine:NewLocale("enUS")
if not L then return end

---------------------------------------------------------------------
-- System Messages
---------------------------------------------------------------------

-- Core Engine
L["Bad argument #%d to '%s': %s expected, got %s"] = true
L["The Engine has no method named '%s'!"] = true
L["The handler '%s' has no method named '%s'!"] = true
L["The handler element '%s' has no method named '%s'!"] = true
L["The module '%s' has no method named '%s'!"] = true
L["The module widget '%s' has no method named '%s'!"] = true
L["The event '%s' isn't currently registered to any object."] = true
L["The event '%s' isn't currently registered to the object '%s'."] = true
L["Attempting to unregister the general occurence of the event '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterEvent?"] = true
L["The method named '%s' isn't registered for the event '%s' in the object '%s'."] = true
L["The function call assigned to the event '%s' in the object '%s' doesn't exist."] = true
L["The message '%s' isn't currently registered to any object."] = true
L["The message '%s' isn't currently registered to the object '%s'."] = true
L["Attempting to unregister the general occurence of the message '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterMessage?"] = true
L["The method named '%s' isn't registered for the message '%s' in the object '%s'."] = true
L["The function call assigned to the message '%s' in the object '%s' doesn't exist."] = true
L["The config '%s' already exists!"] = true
L["The config '%s' doesn't exist!"] = true
L["The config '%s' doesn't have a profile named '%s'!"] = true
L["The static config '%s' doesn't exist!"] = true
L["The static config '%s' already exists!"] = true
L["Only the Engine can access private configs"] = true
L["Bad argument #%d to '%s': No handler named '%s' exist!"] = true
L["Bad argument #%d to '%s': No module named '%s' exist!"] = true
L["The element '%s' is already registered to the '%s' handler!"] = true
L["The widget '%s' is already registered to the '%s' module!"] = true
L["A handler named '%s' is already registered!"] = true
L["Bad argument #%d to '%s': The name '%s' is reserved for a handler!"] = true
L["Bad argument #%d to '%s': A module named '%s' already exists!"] = true
L["Bad argument #%d to '%s': The load priority '%s' is invalid! Valid priorities are: %s"] = true
L["Accept"] = true
L["Cancel"] = true
L["Reload Needed"] = true
L["The user interface has to be reloaded for the changes to be applied.|n|nDo you wish to do this now?"] = true
L["The Engine can't be tampered with!"] = true

-- /dui cpu (engine/profiler.lua)
L["Turn on the CPU profiling first: /console scriptProfile 1, then /reload. Turn it off the same way afterwards (0), it slows the game down."] = true
L["Measuring DiabolicUI's CPU use for %d seconds..."] = true
L["DiabolicUI used %.2f ms per second. The busiest functions, with what they call (ms per second):"] = true

-- Blizzard Handler


---------------------------------------------------------------------
-- User Interface
---------------------------------------------------------------------


-- actionbar module
---------------------------------------------------------------------
-- button tooltips
L["Main Menu"] = true
L["<Left-click> to toggle menu."] = true
L["Blizzard Micro Menu"] = true
L["Here you'll find all the common interface panels|nlike the spellbook, talents, achievements etc."] = true

L["Action Bars"] = true
L["<Left-click> to toggle action bar menu."] = true
L["Bags"] = true
L["<Left-click> to toggle bags."] = true
L["<Right-click> to toggle bag bar."] = true
L["Chat"] = true
L["Guild Members Online:"] = true 
L["Friends Online:"] = true

-- actionbar menu
--L["Action Bars"] = true
L["Side Bars"] = true
L["Hold |cff00b200<Alt+Ctrl+Shift>|r and drag to remove spells, macros and items from the action buttons."] = true
L["No Bars"] = true
L["One"] = true
L["Two"] = true
L["Three"] = true

-- xp bar
L["Current XP: "] = true
L["Experience"] = true
L["Rested Bonus: "] = true
L["Rested"] = true
L["%s of normal experience\ngained from monsters."] = true
L["Resting"] = true
L["You must rest for %s additional\nhours to become fully rested."] = true
L["You must rest for %s additional\nminutes to become fully rested."] = true
L["Normal"] = true
L["You should rest at an Inn."] = true

-- artifact bar 

-- honor bar 

-- floating buttons
L["Stances"] = true
L["<Left-click> to toggle stance bar."] = true
L["<Left-click> to use %s."] = true
L["<Right-click> to cancel current form."] = true
L["<Left-click> to leave the vehicle."] = true
L["Request Stop"] = true

-- item tooltips
L["Equipped"] = true
L["Reskin Tooltip"] = true
L["Shows item tooltips in the Diablo III style: the item's name on a title banner in its quality color, its icon on the left, damage per second or armor as a big number, and the sell price and durability at the bottom.|n|nWhen disabled, Blizzard's own item tooltips are used."] = true
L["<Left-click> to land at the next flight point."] = true

-- added to the interface options menu in WotLK
L["Cast action keybinds on key down"] = true

-- keybinds
L["Alt"] = "A"
L["Ctrl"] = "C"
L["Shift"] = "S"
L["NumPad"] = "N"
L["Backspace"] = "BS"
L["Button1"] = "B1"
L["Button2"] = "B2"
L["Button3"] = "B3"
L["Button4"] = "B4"
L["Button5"] = "B5"
L["Button6"] = "B6"
L["Button7"] = "B7"
L["Button8"] = "B8"
L["Button9"] = "B9"
L["Button10"] = "B10"
L["Button11"] = "B11"
L["Button12"] = "B12"
L["Button13"] = "B13"
L["Button14"] = "B14"
L["Button15"] = "B15"
L["Button16"] = "B16"
L["Button17"] = "B17"
L["Button18"] = "B18"
L["Button19"] = "B19"
L["Button20"] = "B20"
L["Button21"] = "B21"
L["Button22"] = "B22"
L["Button23"] = "B23"
L["Button24"] = "B24"
L["Button25"] = "B25"
L["Button26"] = "B26"
L["Button27"] = "B27"
L["Button28"] = "B28"
L["Button29"] = "B29"
L["Button30"] = "B30"
L["Button31"] = "B31"
L["Capslock"] = "Cp"
L["Clear"] = "Cl"
L["Delete"] = "Del"
L["End"] = "En"
L["Home"] = "HM"
L["Insert"] = "Ins"
L["Mouse Wheel Down"] = "WD"
L["Mouse Wheel Up"] = "WU"
L["Num Lock"] = "NL"
L["Page Down"] = "PD"
L["Page Up"] = "PU"
L["Scroll Lock"] = "SL"
L["Spacebar"] = "Sp"
L["Tab"] = "Tb"
L["Down Arrow"] = "Dn"
L["Left Arrow"] = "Lf"
L["Right Arrow"] = "Rt"
L["Up Arrow"] = "Up"


-- chat module
---------------------------------------------------------------------
L["Chat Setup"] = true
L["Would you like to automatically have the main chat window sized and positioned to match Diablo III, or would you like to manually handle this yourself?|n|nIf you choose to manually position things yourself, you won't be asked about this issue again."] = true
L["Auto"] = true
L["Manual"] = true
L["You can re-enable the auto positioning by typing |cff448800/diabolic autoposition|r in the chat at any time."] = true
L["Auto positioning of chat windows has been enabled."] = true
L["Auto positioning of chat windows has been disabled."] = true
L["Reputation: "] = true


-- minimap module
---------------------------------------------------------------------
--L["<Middle-click> to toggle stopwatch."] = true
--L["<Right-click> to configure clock."] = true

-- tooltips
---------------------------------------------------------------------
L["BoA"] = true
L["PvP"] = true
L["SpellID:"] = true
L["Caster:"] = true


-- unitframe module
---------------------------------------------------------------------
L["Units"] = true
L["Show class colors"] = true
L["Colors the player, target, party, raid and tab-target of target health bars by the unit's class.|n|nRequires a UI reload to apply."] = true
L["Show Portrait"] = true
L["Shows an animated 3D model portrait on party and focus frames.|n|nRequires a UI reload to apply."] = true
L["Toggle Fake Party"] = true
L["Shows or hides a mock party of fake members, to preview the party frames' look without needing a real group."] = true
L["Toggle Fake Raid"] = true
L["Shows or hides a mock raid of fake members, to preview the raid frames' look without needing a real group."] = true
L["Menu"] = true
L["Show Gold"] = true
L["Shows how much money you're carrying, next to the menu button in the bottom right corner."] = true
L["Show FPS & Latency"] = true
L["Shows your framerate and latency, next to the menu button in the bottom right corner."] = true
L["Objectives"] = true
L["Fade Quest Tracker"] = true
L["Fades the quest tracker out after it hasn't been moused over for a while, and shows it again as soon as you mouse over it.|n|nUses Questie's tracker when it's enabled, Blizzard's otherwise."] = true
L["How many seconds the tracker stays fully visible before it starts fading, once you stop hovering it."] = true
L["Opacity"] = true
L["How visible the tracker stays once it has fully faded, as a percentage."] = true
L["Items"] = true -- loot window title
L["Reskin Windows"] = true
L["Show unassigned spells"] = true
L["Rings the spells you can cast that are on none of your action bars."] = true
L["No spell found"] = true
L["Apprentice"] = true -- a profession's ranks, by its highest skill
L["Journeyman"] = true
L["Expert"] = true
L["Artisan"] = true
L["Master"] = true
L["Grand Master"] = true
L["Missing Primary Profession"] = true
L["Visit a profession trainer in a capital city to learn one."] = true
L["Not learned yet: visit its trainer to learn it."] = true
L["Shows Blizzard's windows in the Diablo III style: the character, spellbook, talents, quest log, social, mail, merchant, achievements and the other windows, and AdiBags' bags. When disabled, Blizzard's own windows are used.|n|nRequires a UI reload to apply."] = true
L["Reskin Loot Window"] = true
L["Re-styles the loot window to match the rest of the UI. When disabled, Blizzard's own loot window is used instead.|n|nRequires a UI reload to apply."] = true
L["Roll Window"] = true
L["Coming Up"] = true
L["Fake Loot Roll"] = true
L["Fake Boss"] = true
L["Shows the roll window and the loot list with fake loot, to try them without a raid. Needs the roll window on."] = true
L["Shows a window when the master looter, the leader or a raid warning puts an item up for a roll, with its time left and buttons to roll for it: Main Spec (/roll 100) or Off Spec (/roll 99). The boss's loot they post in the chat shows in a list on the right.|n|nRequires a UI reload to apply."] = true
L["Rolls"] = true -- roll window title
L["Main Spec"] = true
L["Off Spec"] = true
L["Pass"] = true
L["You passed"] = true
L["You rolled %d (%s)"] = true -- your roll, and Main Spec or Off Spec

-- tooltip module
---------------------------------------------------------------------
L["Tooltips"] = true
L["Horizontal Offset"] = true
L["Vertical Offset"] = true
L["At 0, the tooltip is centered horizontally on the cursor."] = true
L["At 0, the cursor is at the bottom edge of the tooltip."] = true
L["Tooltip mouse anchor"] = true
L["Which point of the tooltip gets anchored to your cursor, so you can pick the corner or edge that overlaps your mouse the least."] = true
L["Top Left"] = true
L["Top"] = true
L["Top Right"] = true
L["Left"] = true
L["Center"] = true
L["Right"] = true
L["Bottom Left"] = true
L["Bottom"] = true
L["Bottom Right"] = true

-- chat module
---------------------------------------------------------------------
L["Appearance"] = true
L["Fade Chat"] = true
L["Fades chat text out after it has been visible for a while, instead of leaving it on screen permanently."] = true
L["Time Fading"] = true
L["How many seconds it takes for chat text to fade out."] = true
L["Time Visible"] = true
L["How many seconds chat text stays fully visible before it starts fading."] = true
L["Background Opacity"] = true
L["How opaque the chat window's background is while you're typing."] = true
L["Click to copy the link."] = true

-- Talent specialization switch
L["Talent Specialization"] = true
L["<Left-click> to switch"] = true
L["Specializations"] = true
L["Equipment set '%s' not found."] = true
L["Action Bar Saver isn't loaded, can't restore '%s'."] = true
L["Action Bar Saver isn't loaded"] = true
L["Equipment Set"] = true
L["New Equipment Set"] = true
L["Stats"] = true
L["Titles"] = true
L["Sets"] = true
L["The equipment set to put on once you switch to this specialization, from the equipment manager of your character window."] = true
L["Action Bar Saver Profile"] = true
L["The Action Bar Saver profile to restore once you switch to this specialization. Save one with '/abs save <name>'."] = true
L["None"] = true
L["Unchanged"] = true
L["Macro Before"] = true
L["A macro of yours to run as you switch to this specialization: the click on the skull's specialization button that switches runs it first."] = true
L["Macro After"] = true
L["Runs your '%s' macro first"] = true
L["A macro of yours to run once you switch to this specialization. The game only runs macros on a click, so the specialization button on the skull glows, and its next click runs the macro."] = true
L["<Left-click> to run your '%s' macro"] = true
L["Macro '%s' not found."] = true
L["Your %s commands are too long for a macro, make one yourself: %s"] = true
L["Your other commands are now the character macro '%s', run by a click on the skull after switching."] = true
L["No free character macro slot for your %s commands, they're kept until there's one."] = true

-- Shorter Messages (chat cleaner)
L["Messages"] = true
L["Shorter Messages"] = true
L["Loot & Money"] = true
L["'You receive loot: [Item]x3.' becomes '+ [Item] (3)', and looted money shows as coins."] = true
L["Experience, Reputation & Honor"] = true
L["Shorter experience, reputation, honor, skill and level up lines, like '+ 75 Reputation: Argent Crusade'."] = true
L["Quests"] = true
L["Shorter lines for quests accepted and completed."] = true
L["Away, Busy & Rested"] = true
L["'You are now Away.' becomes '+ Away', and the same for busy and rested."] = true
L["Online & Offline"] = true
L["Marks friends and guild members coming online with a green +, and dims them going offline."] = true
L["Auctions"] = true
L["Marks auctions created, sold and won with a green +, and cancelled, outbid and expired ones with a red -."] = true
L["Achievements"] = true
L["'Name has earned the achievement [Name]!' becomes 'Name: [Name]'."] = true
L["Hide Channel Notices"] = true
L["Hides the notices of joining, leaving and changing chat channels, and empty chat lines."] = true


-- worldmap module
---------------------------------------------------------------------

-- abbreviations
---------------------------------------------------------------------
L["d"] = true -- abbreviation for "days" when showing time
L["h"] = true -- abbreviation for "hours" when showing time
L["m"] = true -- abbreviation for "minutes" when showing time
L["s"] = true -- abbreviation for "seconds" when showing time

-- AddOns page (other addons styled)
L["DiabolicUI: Questie has changed, its tracker is left as it is."] = true
L["Drag to move the tracker"] = true
L["Reset Positions"] = true
L["Preview"] = true
L["Puts the menu buttons, the chat and Blizzard's quest tracker back in their places."] = true
L["Sell Junk"] = true
L["Sold %d junk items for %s."] = true
L["%d grey items, for %s."] = true
L["No grey items in your bags."] = true
L["Copy Chat"] = true
L["Low Health Warning"] = true
L["The edges of the screen pulse red while your health is under 35%, like in Diablo III.|n|nRequires a UI reload to apply."] = true
L["Frames & AddOns"] = true
L["Blizzard Frames"] = true
L["Chat Commands"] = true
L["Version %s"] = true
L["A Diablo III style interface. Its settings are on the pages below this one."] = true
L["/dui config - these options|n/dui move - unlocks the minimap, the chat, the menu buttons and the quest tracker to move them"] = true
L["Unlock Frames"] = true
L["Lock Frames"] = true
L["Highlights the frames you can move - the minimap, the chat, the menu buttons, the quest tracker (Blizzard's or Questie's) and TrinketMenu - to drag them around. Right-drag the minimap to resize it. A Lock Frames button locks them in their new places.|n|nAlso: /dui move"] = true
L["Drag the highlighted frames to move them. Right-drag the minimap to resize it."] = true
L["You can't move frames in combat."] = true
L["UI Scale"] = true
L["The size of DiabolicUI's bars, orbs, frames and everything on them, as a percentage of the size made for your screen. WoW's own UI scale and other addons aren't changed.|n|nAlso: /dui setscale 0.9"] = true
