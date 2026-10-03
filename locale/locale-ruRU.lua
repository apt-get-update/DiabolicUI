local _, Engine = ...

local L = Engine:NewLocale("ruRU")
if not L then return end

---------------------------------------------------------------------
-- System Messages -- Системные сообщения
---------------------------------------------------------------------

-- Core Engine -- Движок ядра
L["Bad argument #%d to '%s': %s expected, got %s"] = "Неверный аргумент #%d в '%s': %s ожидается, получено %s"
L["The Engine has no method named '%s'!"] = "У движка нет метода с именем '%s'!"
L["The handler '%s' has no method named '%s'!"] = "Обработчик '%s' не имеет метода с именем '%s'!"
L["The handler element '%s' has no method named '%s'!"] = "Элемент обработчика '%s' не имеет метода с именем '%s'!"
L["The module '%s' has no method named '%s'!"] = "Модуль '%s' не имеет метода с именем '%s'!"
L["The module widget '%s' has no method named '%s'!"] = "Виджет модуля '%s' не имеет метода с именем '%s'!"
L["The event '%s' isn't currently registered to any object."] = "Событие '%s' в настоящее время не зарегистрировано ни одному объекту."
L["The event '%s' isn't currently registered to the object '%s'."] = "Событие '%s' в настоящее время не зарегистрировано для объекта '%s'."
L["Attempting to unregister the general occurence of the event '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterEvent?"] = "Попытка отменить регистрацию общего события события '%s' в объекте '%s', не была зарегистрирована. Забыли ли вы добавить имя функции или имя метода в UnregisterEvent?"
L["The method named '%s' isn't registered for the event '%s' in the object '%s'."] = "Метод с именем '%s' не зарегистрирован для события '%s' в объекте '%s'."
L["The function call assigned to the event '%s' in the object '%s' doesn't exist."] = "Вызов функции, назначенный событию '%s' в объекте '%s' не существует."
L["The message '%s' isn't currently registered to any object."] = "Сообщение '%s' в настоящее время не зарегистрировано ни одному объекту."
L["The message '%s' isn't currently registered to the object '%s'."] = "Сообщение '%s' в настоящее время не зарегистрировано для объекта '%s'."
L["Attempting to unregister the general occurence of the message '%s' in the object '%s', when no such thing has been registered. Did you forget to add function or method name to UnregisterMessage?"] = "Попытка отменить регистрацию общего появления сообщения '%s' в объекте '%s', не была зарегистрирована. Не забыли ли вы добавить имя функции или имя метода в UnregisterEvent?"
L["The method named '%s' isn't registered for the message '%s' in the object '%s'."] = "Метод с именем '%s' не зарегистрирован для сообщения '%s' в объекте '%s'."
L["The function call assigned to the message '%s' in the object '%s' doesn't exist."] = "Вызов функции, назначенный сообщению '%s' в объекте '%s', не существует."
L["The config '%s' already exists!"] = "Конфигурация '%s' уже существует!"
L["The config '%s' doesn't exist!"] = "Конфигурация '%s' не существует!"
L["The config '%s' doesn't have a profile named '%s'!"] = "Конфигурация '%s' не имеет профиля с именем '%s'!"
L["The static config '%s' doesn't exist!"] = "Постоянной конфигурации '%s' не существует!"
L["The static config '%s' already exists!"] = "Постоянная конфигурация '%s' уже существует!"
L["Only the Engine can access private configs"] = "Только движок может получить доступ к приватным настройкам"
L["Bad argument #%d to '%s': No handler named '%s' exist!"] = "Неверный аргумент #%d в '%s': Нет обработчика с именем '%s'!"
L["Bad argument #%d to '%s': No module named '%s' exist!"] = "Неверный аргумент #%d в '%s': Нет модуля с именем '%s'!"
L["The element '%s' is already registered to the '%s' handler!"] = "Элемент '%s' уже зарегистрирован в '%s' обработчике!"
L["The widget '%s' is already registered to the '%s' module!"] = "Виджет '%s' уже зарегистрирован в '%s' модуле!"
L["A handler named '%s' is already registered!"] = "Обработчик с именем '%s' уже зарегистрирован!"
L["Bad argument #%d to '%s': The name '%s' is reserved for a handler!"] = "Неверный аргумент #%d to '%s': Имя '%s' уже зарезервировано для обработчика!"
L["Bad argument #%d to '%s': A module named '%s' already exists!"] = "Неверный аргумент #%d to '%s': Имя модуля '%s' уже существует!"
L["Bad argument #%d to '%s': The load priority '%s' is invalid! Valid priorities are: %s"] = "Неверный аргумент #%d в '%s': Приоритет нагрузки '%s' недопустим! Правильный приоритет: %s"
L["Accept"] = "Принять"
L["Cancel"] = "Отменить"
L["Reload Needed"] = "Необходима перезагрузка"
L["The user interface has to be reloaded for the changes to be applied.|n|nDo you wish to do this now?"] = "Пользовательский интерфейс должен быть перезагружен для внесения изменений.|n|nВы хотите сделать это сейчас?"
L["The Engine can't be tampered with!"] = "В работу движка нельзя вмешиваться!"

-- Blizzard Handler  -- Обработчик Blizzard


---------------------------------------------------------------------
-- User Interface -- Пользовательский интерфейс
---------------------------------------------------------------------


-- actionbar module -- модуль панели действий 
---------------------------------------------------------------------
-- button tooltips -- подсказки кнопок
L["Main Menu"] = true
L["<Left-click> to toggle menu."] = "<Щелкните левой кнопкой мыши> для переключения меню."
L["Blizzard Micro Menu"] = "Blizzard микро меню"
L["Here you'll find all the common interface panels|nlike the spellbook, talents, achievements etc."] = "Здесь вы найдете все общие интерфейсные панели|nнапример, книгу заклинаний, таланты, достижения и т.д."

L["Action Bars"] = "Панели действия"
L["<Left-click> to toggle action bar menu."] = "<Щелкните левой кнопкой мыши> для переключения панели действия."
L["Bags"] = "Сумки"
L["<Left-click> to toggle bags."] = "<Щелкните левой кнопкой мыши> для переключения окна сумок."
L["<Right-click> to toggle bag bar."] = "<Щелкните правой кнопкой мыши> для переключения сумки."
L["Chat"] = "Чат"
L["<Left-click> or <Enter> to chat."] = "<Щелкните левой кнопкой мыши> или <Enter> для чата."
L["Friends & Guild"] = "Друзья и Гильдия"
L["<Left-click> to toggle social frames."] = "<Щелкните левой кнопкой мыши> для переключения социального окна."
L["<Right-click> to toggle Guild frame."] = "<Щелкните правой кнопкой мыши> для переключения окна гильдии."
L["Guild Members Online:"] = "Члены гильдии в сети:" 
L["Friends Online:"] = "Друзья в сети:"

-- actionbar menu -- меню панели действий
--L["Action Bars"] = "Панели действия"
L["Side Bars"] = "Боковые панели"
L["Hold |cff00b200<Alt+Ctrl+Shift>|r and drag to remove spells, macros and items from the action buttons."] = "Держите |cff00b200<Alt+Ctrl+Shift>|r и перетащите, чтобы удалить заклинания, макросы и элементы из кнопок действий."
L["No Bars"] = "Нет панелей"
L["One"] = "Одна"
L["Two"] = "Две"
L["Three"] = "Три"

-- xp bar -- панель опыта
L["Current XP: "] = "Текущий опыт: "
L["Experience"] = "Опыт"
L["Rested Bonus: "] = "Бонус отдыха: "
L["Rested"] = "Отдохнувший"
L["%s of normal experience\ngained from monsters."] = "%s от нормального опыта\nполучаемого от монстров."
L["Resting"] = "Отдыхающий"
L["You must rest for %s additional\nhours to become fully rested."] = "Вы должны отдохнуть для %s дополнительных\nчасов, чтобы полностью отдохнуть."
L["You must rest for %s additional\nminutes to become fully rested."] = "Вы должны отдохнуть для %s дополнительных\nминут, чтобы полностью отдохнуть."
L["Normal"] = "Нормально"
L["You should rest at an Inn."] = "Ты должен отдохнуть в трактире."

-- artifact bar -- панель артефакта

-- honor bar -- панель чести

-- floating buttons -- всплывающие кнопки
L["Stances"] = "Стойки"
L["<Left-click> to toggle stance bar."] = "<Щелкните левой кнопкой мыши> для переключения стойки."
L["<Right-click> to cancel current form."] = "<Щелкните правой кнопкой мыши> для отмены текущей формы."
L["<Left-click> to leave the vehicle."] = "<Щелкните левой кнопкой мыши> чтобы покинуть транспортное средство."

-- added to the interface options menu in WotLK -- добавлено в меню опций интерфейса в WotLK
L["Cast action keybinds on key down"] = "Включение клавиш с клавишами вниз"


-- keybinds -- привязки клавиш
L["Alt"] = "A"
L["Ctrl"] = "C"
L["Shift"] = "S"
L["NumPad"] = "Ц"
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
L["Mouse Wheel Down"] = "КМВХ"
L["Mouse Wheel Up"] = "КМВЗ"
L["Num Lock"] = "NL"
L["Page Down"] = "PD"
L["Page Up"] = "PU"
L["Scroll Lock"] = "SL"
L["Spacebar"] = "Прбл"
L["Tab"] = "Tb"
L["Down Arrow"] = "Dn"
L["Left Arrow"] = "Lf"
L["Right Arrow"] = "Rt"
L["Up Arrow"] = "Up"


-- chat module -- модуль чата
---------------------------------------------------------------------
L["Chat Setup"] = "Настройки чата"
L["Would you like to automatically have the main chat window sized and positioned to match Diablo III, or would you like to manually handle this yourself?|n|nIf you choose to manually position things yourself, you won't be asked about this issue again."] = "Хотите ли вы, чтобы окно основного чата было настроено и позиционировалось в соответствии с Diablo III, или Вы хотите, сами справиться с этим?|n|nЕсли вы сами решите вручную позиционировать его, то вас больше не будут спрашивать об этой проблеме."
L["Auto"] = "Авто"
L["Manual"] = "Вручную"
L["You can re-enable the auto positioning by typing |cff448800/diabolic autoposition|r in the chat at any time."] = "Вы можете повторно включить автоматическое позиционирование, набрав в диалоговом режиме |cff448800/diabolic autoposition|r в чате в любое время."
L["Auto positioning of chat windows has been enabled."] = "Автоматическое позиционирование окон чата включено."
L["Auto positioning of chat windows has been disabled."] = "Автоматическое позиционирование окон чата выключено."


-- minimap module -- модуль миникарты
---------------------------------------------------------------------
--L["<Middle-click> to toggle stopwatch."] = "<Щелкните средней кнопкой мыши> для переключения секундомера."
--L["<Right-click> to configure clock."] = "<Щелкните правой кнопкой мыши> для конфигурации часов."

-- tooltips -- подсказки
---------------------------------------------------------------------
L["BoA"] = "BoA"
L["PvP"] = "PvP" 
L["SpellID:"] = "ID умения:"
L["Caster:"] = "Заклинатель:"


-- unitframe module
---------------------------------------------------------------------


-- worldmap module -- модуль мировой карты
---------------------------------------------------------------------

-- abbreviations -- аббревиатуры 
---------------------------------------------------------------------
L["d"] = "д" -- abbreviation for "days" when showing time -- аббревиатура для "дни" при показе времени
L["h"] = "ч" -- abbreviation for "hours" when showing time -- аббревиатура для "часы" при показе времени
L["m"] = "м" -- abbreviation for "minutes" when showing time -- аббревиатура для "минуты" при показе времени
L["s"] = "с" -- abbreviation for "seconds" when showing time -- аббревиатура для "секунды" при показе времени
