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
L["The Engine has no method named '%s'!"] = true
L["The handler '%s' has no method named '%s'!"] = true
L["The module '%s' has no method named '%s'!"] = true
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
L["Attention!"] = true
L["The UI scale is wrong, so the graphics might appear fuzzy or pixelated. If you choose to ignore it, you won't be asked about this issue again.|n|nFix this issue now?"] = true
L["UI scaling is activated and needs to be disabled, otherwise you'll might get fuzzy borders or pixelated graphics. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = true
L["UI scaling was turned off but needs to be enabled, otherwise you'll might get fuzzy borders or pixelated graphics. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = true
L["The UI scale is wrong, so the graphics might appear fuzzy or pixelated. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = true
L["Your resolution is too low for this UI, but the UI scale can still be adjusted to make it fit. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = true
L["Accept"] = true
L["Cancel"] = true
L["Ignore"] = true
L["You can re-enable the auto scaling by typing |cff448800/diabolic autoscale|r in the chat at any time."] = true
L["Auto scaling of the UI has been enabled."] = true
L["Auto scaling of the UI has been disabled."] = true
L["Reload Needed"] = true
L["The user interface has to be reloaded for the changes to be applied.|n|nDo you wish to do this now?"] = true
L["The Engine can't be tampered with!"] = true

-- Blizzard Handler
L["Bad argument #%d to '%s'. No object named '%s' exists."] = true


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
L["Diabolic Options"] = true

L["Action Bars"] = true
L["<Left-click> to toggle action bar menu."] = true
L["Bags"] = true
L["<Left-click> to toggle bags."] = true
L["<Right-click> to toggle bag bar."] = true
L["Chat"] = true
L["<Left-click> or <Enter> to chat."] = true
L["Friends & Guild"] = true
L["<Left-click> to toggle social frames."] = true
L["<Right-click> to toggle Guild frame."] = true
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
L["Rested Bonus: "] = true
L["Rested"] = true
L["%s of normal experience\ngained from monsters."] = true
L["Resting"] = true
L["You must rest for %s additional\nhours to become fully rested."] = true
L["You must rest for %s additional\nminutes to become fully rested."] = true
L["Normal"] = true
L["You should rest at an Inn."] = true

-- artifact bar 
L["Current Artifact Power: "] = true 
L["<Left-Click to toggle Artifact Window>"] = true

-- honor bar 
L["Current Honor Points: "] = true
L["<Left-Click to toggle Honor Talents Window>"] = true

-- floating buttons
L["Stances"] = true
L["<Left-click> to toggle stance bar."] = true
L["<Right-click> to cancel current form."] = true
L["<Left-click> to leave the vehicle."] = true

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
L["Side Bars set to %d."] = true
L["Action Bars set to %d."] = true
L["Reputation: "] = true
L["Failed to update side bars, must be %d or %d or %d"] = true
L["Failed to update action bars, must be %d or %d or %d"] = true


-- minimap module
---------------------------------------------------------------------
L["<Left-click> to toggle calendar."] = true
L["<Middle-click> to toggle local/game time."] = true
L["<Right-click> to toggle 12/24-hour clock."] = true
--L["<Middle-click> to toggle stopwatch."] = true
--L["<Right-click> to configure clock."] = true
L["Calendar"] = true
L["New Event!"] = true
L["New Mail!"] = true

-- tooltips
---------------------------------------------------------------------
L["BoA"] = true
L["PvP"] = true
L["SpellID:"] = true
L["Caster:"] = true


-- unitframe module
---------------------------------------------------------------------


-- worldmap module
---------------------------------------------------------------------
L["Reveal"] = true
L["Reveal Hidden Areas"] = true
L["Hide Undiscovered Areas"] = true
L["Disable to hide areas|nyou have not yet discovered."] = true
L["Enable to show hidden areas|nyou have not yet discovered."] = true
L["Press <CTRL+C> to copy."] = true

-- abbreviations
---------------------------------------------------------------------
L["d"] = true -- abbreviation for "days" when showing time
L["h"] = true -- abbreviation for "hours" when showing time
L["m"] = true -- abbreviation for "minutes" when showing time
L["s"] = true -- abbreviation for "seconds" when showing time
