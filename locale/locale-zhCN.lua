local _, Engine = ...

local L = Engine:NewLocale("zhCN")
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
L["Attention!"] = "注意!"
L["The UI scale is wrong, so the graphics might appear fuzzy or pixelated. If you choose to ignore it, you won't be asked about this issue again.|n|nFix this issue now?"] = "UI尺寸是错误的，所以图形可能会出现模糊或失真。如果你选择忽略，则不会再次询问此问题。|n|n是否修复?"
L["UI scaling is activated and needs to be disabled, otherwise you'll might get fuzzy borders or pixelated graphics. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = "需要关闭UI缩放，否则你会得到边界模糊或失真的图形。如果你选择忽略，则不会再次询问此问题。|n|n是否修复?"
L["UI scaling was turned off but needs to be enabled, otherwise you'll might get fuzzy borders or pixelated graphics. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = "需要启用UI缩放，否则你会得到边界模糊或失真的图形。如果你选择忽略，则不会再次询问此问题。|n|n是否修复?"
L["The UI scale is wrong, so the graphics might appear fuzzy or pixelated. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = "UI尺寸是错误的，所以图形可能会出现模糊或失真。如果你选择忽略自己并处理UI缩放，则不会再次询问此问题。|n|n是否修复?"
L["Your resolution is too low for this UI, but the UI scale can still be adjusted to make it fit. If you choose to ignore it and handle the UI scaling yourself, you won't be asked about this issue again.|n|nFix this issue now?"] = "你的分辨率对于此界面来说太低，但界面的大小仍然可以调整以使其适合。如果你选择忽略它并自己处理UI缩放，则不会再次询问此问题。|n|n是否修复?"
L["Accept"] = "接受"
L["Cancel"] = "取消"
L["Ignore"] = "忽略"
L["You can re-enable the auto scaling by typing |cff448800/diabolic autoscale|r in the chat at any time."] = "你可以通过在聊天框输入|cff448800/diabolic autoscale|r启用自动缩放"
L["Auto scaling of the UI has been enabled."] = "用户界面自动缩放已启用"
L["Auto scaling of the UI has been disabled."] = "用户界面自动缩放已禁用"
L["Reload Needed"] = "需要重新加载"
L["The user interface has to be reloaded for the changes to be applied.|n|nDo you wish to do this now?"] = "用户界面必须重新加载应用更改.你想现在这样做吗?"
L["The Engine can't be tampered with!"] = "引擎不能被篡改!"

-- Blizzard Handler
L["Bad argument #%d to '%s'. No object named '%s' exists."] = true


---------------------------------------------------------------------
-- User Interface
---------------------------------------------------------------------


-- actionbar module
---------------------------------------------------------------------
-- button tooltips
L["Main Menu"] = "主菜单"
L["<Left-click> to toggle menu."] = "<点击左键>打开菜单"
L["Action Bars"] = "动作条"
L["<Left-click> to toggle action bar menu."] = "<点击左键>打开动作条选项"
L["Bags"] ="背包"
L["<Left-click> to toggle bags."] = "<点击左键>打开背包"
L["<Right-click> to toggle bag bar."] = "<点击右键>打开背包栏"
L["Chat"] = "聊天"
L["<Left-click> or <Enter> to chat."] = "<点击左键>或<Enter>打开聊天框"
L["Friends & Guild"] = "社交"
L["<Left-click> to toggle social frames."] = "<点击左键>打开社交框"

-- actionbar menu
--L["Action Bars"] = "动作条"
L["Side Bars"] = "侧边栏"
L["Hold |cff00b200<Alt+Ctrl+Shift>|r and drag to remove spells, macros and items from the action buttons."] = "按住|cff00b200<Alt+Ctrl+Shift>|r拖动或移除动作条上的技能、宏和物品"
L["No Bars"] = "无"
L["One"] = "一栏"
L["Two"] = "两栏"
L["Three"] = "三栏"

-- xp bar
L["Current XP: "] = "当前经验: "
L["Rested Bonus: "] = "休息奖励: "
L["Rested"] = "精力充沛"
L["%s of normal experience\ngained from monsters."] = "从怪物身上获得%s的经验值"
L["Resting"] = "休息"
L["You must rest for %s additional\nhours to become fully rested."] = "你必须休息%s小时,才能充分休息"
L["You must rest for %s additional\nminutes to become fully rested."] = "你必须休息%s分钟,才能充分休息"
L["Normal"] = "正常"
L["You should rest at an Inn."] = "你应该在一个旅馆休息"

-- artifact bar 
L["Current Artifact Power: "] = "目前神器能量: "
L["<Left-Click to toggle Artifact Window>"] = "<点击左键切换神器窗口>"

-- honor bar 
L["Current Honor Points: "] = "当前荣誉点: "
L["<Left-Click to toggle Honor Talents Window>"] = "<点击左键切换荣誉窗口>"

-- floating buttons
L["Stances"] = "姿态栏"
L["<Left-click> to toggle stance bar."] = "<点击左键>切换姿态栏"
L["<Left-click> to leave the vehicle."] = "<点击左键>离开载具"

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
L["Chat Setup"] = "聊天设置"
L["Would you like to automatically have the main chat window sized and positioned to match Diablo III, or would you like to manually handle this yourself?|n|nIf you choose to manually position things yourself, you won't be asked about this issue again."] = "你想让主聊天窗口的大小和位置自动与暗黑破坏神III相匹配吗？还是你想自己动手处理呢?|n|n如果你选择手动设置位置,你就不会再被问到这个问题了"
L["Auto"] = "自动"
L["Manual"] = "说明"
L["You can re-enable the auto positioning by typing |cff448800/diabolic autoposition|r in the chat at any time."] = "你可以通过在聊天框输入|cff448800/diabolic autoposition|r启用自动定位"
L["Auto positioning of chat windows has been enabled."] = "聊天窗口自动定位已启用"
L["Auto positioning of chat windows has been disabled."] = "聊天窗口自动定位已禁用"


-- minimap module
---------------------------------------------------------------------
L["<Left-click> to toggle calendar."] = "<点击左键>打开日历。"
--L["<Middle-click> to toggle stopwatch."] = "<点击中键>打开秒表。"
--L["<Right-click> to configure clock."] = "<点击右键>配置时钟。"
L["Calendar"] = "行事历"
L["New Event!"] = "新事件"
L["New Mail!"] = "新邮件"

-- tooltips
---------------------------------------------------------------------
L["BoA"] = "件传家宝"
L["PvP"] = "件PVP装"
L["SpellID:"] = "法术ID:"
L["Caster:"] = "施法者:"


-- unitframe module
---------------------------------------------------------------------



-- abbreviations
---------------------------------------------------------------------
L["d"] = true -- abbreviation for "days" when showing time
L["h"] = true -- abbreviation for "hours" when showing time
L["m"] = true -- abbreviation for "minutes" when showing time
L["s"] = true -- abbreviation for "seconds" when showing time

