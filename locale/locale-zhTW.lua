local _, Engine = ...

local L = Engine:NewLocale("zhTW")
if not L then return end

---------------------------------------------------------------------
-- System Messages
---------------------------------------------------------------------


L["Accept"] = "接受"
L["Cancel"] = "取消" 
L["Reload Needed"] = "需要重新加載"
L["The user interface has to be reloaded for the changes to be applied.|n|nDo you wish to do this now?"] = "用戶界面必須重新加載應用更改.妳想現在這樣做嗎?"
L["The Engine can't be tampered with!"] = "引擎不能被篡改!"


---------------------------------------------------------------------
-- User Interface
---------------------------------------------------------------------

-- actionbar module
-- button tooltips
L["Main Menu"] = "主菜單"
L["<Left-click> to toggle menu."] = "<單擊左鍵>打開菜單"
L["Action Bars"] = "動作欄"
L["<Left-click> to toggle action bar menu."] = "<單擊左鍵>打開動作欄選項"
L["Bags"] = "背包"
L["<Left-click> to toggle bags."] = "<單擊左鍵>打開背包"
L["<Right-click> to toggle bag bar."] = "<單擊右鍵>打開背包欄"
L["Chat"] = "聊天"
L["<Left-click> or <Enter> to chat."] = "<單擊左鍵>或<Enter>打開聊天框"
L["Friends & Guild"] = "社交"
L["<Left-click> to toggle social frames."] = "<單擊左鍵>打開社交框"

-- actionbar menu
L["Side Bars"] = "側邊欄"
L["Hold |cff00b200<Alt+Ctrl+Shift>|r and drag to remove spells, macros and items from the action buttons."] = "按住|cff00b200<Alt+Ctrl+Shift>|r拖動或移除動作按鈕上的法術、宏和物品"
L["No Bars"] = "無"
L["One"] = "壹欄"
L["Two"] = "兩欄"
L["Three"] = "三栏"

-- xp bar
L["Current XP: "] = "當前經驗: "
L["Experience"] = "經驗"
L["Rested Bonus: "] = "休息獎勵: "
L["Rested"] = "精力充沛"
L["%s of normal experience\ngained from monsters."] = "從怪物身上獲得%s的經驗值"
L["Resting"] = "休息"
L["You must rest for %s additional\nhours to become fully rested."] = "妳必須休息%s小時,才能充分休息"
L["You must rest for %s additional\nminutes to become fully rested."] = "妳必須休息%s分鐘,才能充分休息"
L["Normal"] = "正常"
L["You should rest at an Inn."] = "妳應該在壹個旅館休息"

-- stance bar
L["Stances"] = "姿態欄"
L["<Left-click> to toggle stance bar."] = "<單擊左鍵>打開姿態欄"

-- keybinds
L["Alt"] = "A"
L["Ctrl"] = "C"
L["Shift"] = "S"
L["NumPad"] = "N"
L["Backspace"] = "BS"
L["Button1"] = "鼠1"
L["Button2"] = "鼠2"
L["Button3"] = "鼠3"
L["Button4"] = "鼠4"
L["Button5"] = "鼠5"
L["Button6"] = "鼠6"
L["Button7"] = "鼠7"
L["Button8"] = "鼠8"
L["Button9"] = "鼠9"
L["Button10"] = "鼠10"
L["Button11"] = "鼠11"
L["Button12"] = "鼠12"
L["Button13"] = "鼠13"
L["Button14"] = "鼠14"
L["Button15"] = "鼠15"
L["Button16"] = "鼠16"
L["Button17"] = "鼠17"
L["Button18"] = "鼠18"
L["Button19"] = "鼠19"
L["Button20"] = "鼠20"
L["Button21"] = "鼠21"
L["Button22"] = "鼠22"
L["Button23"] = "鼠23"
L["Button24"] = "鼠24"
L["Button25"] = "鼠25"
L["Button26"] = "鼠26"
L["Button27"] = "鼠27"
L["Button28"] = "鼠28"
L["Button29"] = "鼠29"
L["Button30"] = "鼠30"
L["Button31"] = "鼠31"
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
L["Down Arrow"] = "下"
L["Left Arrow"] = "左"
L["Right Arrow"] = "右"
L["Up Arrow"] = "上"

-- chat module
L["Chat Setup"] = "聊天設置"
L["Would you like to automatically have the main chat window sized and positioned to match Diablo III, or would you like to manually handle this yourself?|n|nIf you choose to manually position things yourself, you won't be asked about this issue again."] = "妳願意自動設置主聊天窗口的大小和位置,以配合暗黑3,或者妳想手動設置嗎?|n|n如果妳選擇手動設置位置,妳就不會再被問到這個問題了"
L["Auto"] = "自動"
L["Manual"] = "說明"
L["You can re-enable the auto positioning by typing |cff448800/diabolic autoposition|r in the chat at any time."] = "妳可以通過在聊天框輸入|cff448800/diabolic autoposition|r啟用自動定位"
L["Auto positioning of chat windows has been enabled."] = "聊天窗口自動定位已啟用"
L["Auto positioning of chat windows has been disabled."] = "聊天窗口自動定位已禁用"

-- minimap 

--Tooltip
L["BoA"] = "件傳家寶"
L["PvP"] = "件PVP裝"
