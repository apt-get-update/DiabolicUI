-- /dui layout: saves the windows as they show, for tools/positions.lua and
-- the editor (tools/editor.py), in DiabolicUI_Layout (WTF, after a /reload):
-- each named part with where it is and how it's placed, the tabs it shows in,
-- each window's art by the tabs chosen. While it's on each window is saved as it shows and each second (for
-- its pages). /dui layout all opens each window that needs no NPC, page by
-- page, to save them all at once. It says what's left (/dui layout left, saved
-- for the editor too): the windows we style not scanned, their tabs not
-- visited; and any Blizzard or addon window seen shown
-- that we don't style.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Layout Scan", "LOW")
local L = Engine:GetLocale()

-- Lua API
local _G = _G
local ipairs = ipairs
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local pairs = pairs
local pcall = pcall
local select = select
local string_find = string.find
local string_format = string.format
local table_concat = table.concat
local table_sort = table.sort

-- WoW API
local CreateFrame = _G.CreateFrame
local GetAddOnInfo = _G.GetAddOnInfo
local GetTime = _G.GetTime
local InCombatLockdown = _G.InCombatLockdown
local date = _G.date

local kit
local Said -- what's been said (by text)
local Counted -- the windows whose parts were counted (by name)
local LeftCount -- how many things were left to scan, last said
local Walked -- the NPC windows' tabs looked at this scan (by window: the last one, false when all were)
local Saved -- DiabolicUI_Layout: { windows = { [name] = { checked, parts, views } } }
local Shown = {} -- when each window shown was first seen so (by window)
local SETTLE_TIME = 0.5 -- a window saved once shown that long (an addon's lays itself out over a few frames)

-- The chat window the scan talks in: "Layout", opened the first time (with
-- nothing else in it). All windows taken, the default one: opening another
-- would write over the last.
local ChatWindow = function()
	local free = false
	for i = 1, _G.NUM_CHAT_WINDOWS do
		local name, _, _, _, _, _, shown = _G.GetChatWindowInfo(i)
		if shown or _G["ChatFrame" .. i].isDocked then
			if name == L["Layout"] then
				return _G["ChatFrame" .. i]
			end
		else
			free = true
		end
	end
	if not free then
		return _G.DEFAULT_CHAT_FRAME
	end
	local frame = _G.FCF_OpenNewWindow(L["Layout"])
	_G.ChatFrame_RemoveAllMessageGroups(frame)
	_G.ChatFrame_RemoveAllChannels(frame)
	return frame
end

local Print = function(text)
	ChatWindow():AddMessage("|cffff8000DiabolicUI|r " .. text)
end

-- The named parts shown in `frame` and all it holds (frames and texts), not
-- in `skip` (the window), by name.
local CollectNamed
CollectNamed = function(frame, skip, found)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		local name = region:GetName()
		if name and region:IsObjectType("FontString") and region:IsVisible() then
			found[name] = region
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if (child ~= skip) and child:IsVisible() then
			local name = child:GetName()
			if name then
				found[name] = child
			end
			CollectNamed(child, skip, found)
		end
	end
end

-- Where a part is, as settings/positions.lua takes it (tools/positions.lua
-- writes them there): { point, the frame it's placed on, its point, x, y,
-- width, height } (a text's size its own), with its kind and text; for an
-- editor (tools/layout.json) too: all its points (the
-- frame they're on "?" if it has no name, its parent if none), its parent,
-- where it is on screen ({ left, bottom, width, height } in UIParent's
-- units), its strata and level (a text: its layer and its frame's level).
local Round = function(value)
	return math_floor(value * 10 + 0.5) / 10
end

local NameOf = function(frame)
	return frame and (frame:GetName() or "?")
end

-- (`part` placed: Entry's, a window shown)
local Rect = function(part)
	local left, bottom, width, height = part:GetRect()
	local scale = kit.ScaleOf(part) / _G.UIParent:GetEffectiveScale()
	return { Round(left * scale), Round(bottom * scale), Round(width * scale), Round(height * scale) }
end

-- What only the game knows: a part faded to nothing, a text's width and how
-- it's justified, a button's text's width (a row's room shares by it).
local Facts = function(part, entry, window, rows)
	local frame = part
	while frame and (frame ~= window.Frame) do
		entry.faded = (frame:GetAlpha() <= 0) or entry.faded or nil
		frame = frame:GetParent()
	end
	if part:IsObjectType("FontString") then
		entry.textWidth, entry.justify = Round(part:GetStringWidth()), part:GetJustifyH()
	elseif rows[part] then
		entry.textWidth = Round(part:GetTextWidth())
	end
end

local Round3 = function(...)
	local values = { ... }
	for i, value in ipairs(values) do
		values[i] = math_floor(value * 1000 + 0.5) / 1000
	end
	return values
end

-- Most of `region` past the edges of a scroll frame whose scroll child holds
-- it: the game cuts it off, so the editor isn't told about its art or words.
local ScrolledOut = function(region)
	local left, bottom, right, top = kit.Edges(region) -- (placed: those asking go by that first)
	local child, frame = region, region:GetParent()
	while frame do
		if frame:IsObjectType("ScrollFrame") and (frame:GetScrollChild() == child) then
			local outerLeft, outerBottom, outerRight, outerTop = kit.Edges(frame)
			if outerLeft then
				local across = math_min(right, outerRight) - math_max(left, outerLeft)
				local down = math_min(top, outerTop) - math_max(bottom, outerBottom)
				if
					(across < math_min(right - left, outerRight - outerLeft) / 2)
					or (down < math_min(top - bottom, outerTop - outerBottom) / 2)
				then
					return true
				end
			end
		end
		child, frame = frame, frame:GetParent()
	end
end

-- How `text` (a font string) is drawn, for the editor.
local LookOf = function(text, entry)
	local file, size, flags = text:GetFont()
	if file then
		entry.font, entry.fontSize = file, Round(size)
		entry.outline = (flags and string_find(flags, "OUTLINE")) and true or nil
	end
	entry.color = Round3(text:GetTextColor())
	entry.shadow = (text:GetShadowOffset() ~= 0) or nil
	entry.justifyV = text:GetJustifyV()
end

-- What `part` says now as the game shows it (colour codes, lines), for the
-- editor: nothing if it's scrolled out of sight.
local WordsOf = function(part)
	local text = part.GetText and part:GetText()
	if text and (text ~= "") and (not ScrolledOut(part)) then
		return text
	end
end

local Entry = function(part, window, rows)
	if not part:GetLeft() then
		return
	end
	local entry = Engine:GetModule("Blizzard: Adjust").PlaceOf(part)
	entry[4], entry[5] = Round(entry[4]), Round(entry[5])
	if not part:IsObjectType("FontString") then
		entry[6], entry[7] = Round(part:GetWidth()), Round(part:GetHeight())
	end
	entry.kind = part:GetObjectType()
	entry.style = part.DiabolicStyle -- (windows/components/: what it inherits)
	local text = part.GetText and part:GetText()
	if text and (text ~= "") and (not string_find(text, "[|\n]")) then
		entry.text = text
	end
	-- (a button's text is drawn by its font string, named or not)
	local drawn = part:IsObjectType("FontString") and part or (part.GetFontString and part:GetFontString())
	if drawn and text and (text ~= "") then
		LookOf(drawn, entry)
	end
	entry.points = {}
	for i = 1, part:GetNumPoints() do
		local point, relative, relativePoint, x, y = part:GetPoint(i)
		entry.points[i] = { point, NameOf(relative or part:GetParent()), relativePoint, Round(x), Round(y) }
	end
	entry.parent = NameOf(part:GetParent())
	entry.rect = Rect(part)
	if part.GetFrameLevel then
		entry.strata, entry.level = part:GetFrameStrata(), part:GetFrameLevel()
	else
		entry.layer, entry.level = part:GetDrawLayer(), part:GetParent():GetFrameLevel()
	end
	Facts(part, entry, window, rows)
	return entry
end

-- A window's art, ours and the game's, for the editor out of the game to draw:
-- each texture shown with where it is, its file, the part of it shown (its 8
-- corners), its color, alpha, blend and gradient (ours: kit.Gradient); each
-- backdrop with its files, sizes and colors. In the order the game draws them,
-- with the nearest named frame (`owner`) they follow when it moves.
local IsFile = function(file)
	return (type(file) == "string") and (file ~= "")
end

local STRATA =
	{ BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5, FULLSCREEN = 6, FULLSCREEN_DIALOG = 7, TOOLTIP = 8 }
local LAYERS = { BACKGROUND = 1, BORDER = 2, ARTWORK = 3, OVERLAY = 4 } -- (HIGHLIGHT: only under the cursor)

local CollectArt
CollectArt = function(frame, owner, alpha, art)
	owner, alpha = frame:GetName() or owner, alpha * frame:GetAlpha()
	local order = { STRATA[frame:GetFrameStrata()] or 3, frame:GetFrameLevel() }
	local backdrop = frame:GetBackdrop()
	if
		backdrop
		and (IsFile(backdrop.bgFile) or IsFile(backdrop.edgeFile))
		and frame:GetLeft()
		and (not ScrolledOut(frame))
	then
		local insets = backdrop.insets or {}
		art[#art + 1] = {
			order = { order[1], order[2], 0, #art },
			owner = owner,
			alpha = alpha,
			rect = Rect(frame),
			scale = kit.ScaleOf(frame) / _G.UIParent:GetEffectiveScale(),
			backdrop = {
				bgFile = backdrop.bgFile,
				edgeFile = backdrop.edgeFile,
				edgeSize = backdrop.edgeSize,
				tile = backdrop.tile and true,
				tileSize = backdrop.tileSize,
				insets = { insets.left or 0, insets.right or 0, insets.top or 0, insets.bottom or 0 },
			},
			color = Round3(frame:GetBackdropColor()),
			border = Round3(frame:GetBackdropBorderColor()),
		}
	end
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if
			region:IsObjectType("Texture")
			and region:IsShown()
			and IsFile(region:GetTexture())
			and LAYERS[region:GetDrawLayer()]
			and region:GetLeft()
			and (not ScrolledOut(region))
		then
			art[#art + 1] = {
				order = { order[1], order[2], LAYERS[region:GetDrawLayer()], #art },
				owner = region:GetName() or owner,
				alpha = alpha * region:GetAlpha(),
				rect = Rect(region),
				file = region:GetTexture(),
				coords = Round3(region:GetTexCoord()),
				color = Round3(region:GetVertexColor()),
				blend = region:GetBlendMode(),
				gradient = region.DiabolicGradient,
			}
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsVisible() then
			CollectArt(child, owner, alpha, art)
		end
	end
	return art
end

local DrawnFirst = function(a, b)
	for i = 1, 4 do
		if a.order[i] ~= b.order[i] then
			return a.order[i] < b.order[i]
		end
	end
end

local Art = function(frame)
	local art = CollectArt(frame, nil, 1, {})
	table_sort(art, DrawnFirst)
	for _, item in ipairs(art) do
		item.order = nil
	end
	return art
end
Module.ArtOf = Art -- (tools/sample.lua's)

-- A value as Lua's text, for the saved variables: a window's art takes a third of
-- the room in one string an item (tools/positions.lua reads them back).
local Packed
Packed = function(value)
	local kind = type(value)
	if kind == "string" then
		return string_format("%q", value)
	elseif kind ~= "table" then
		return tostring(value)
	end
	local out = {}
	for i, item in ipairs(value) do
		out[i] = Packed(item)
	end
	for key, item in pairs(value) do
		if type(key) == "string" then
			out[#out + 1] = key .. "=" .. Packed(item)
		end
	end
	return "{" .. table_concat(out, ",") .. "}"
end

local PackedArt = function(frame)
	local art = Art(frame)
	for i, item in ipairs(art) do
		art[i] = Packed(item)
	end
	return art
end

-- What's in a bag changes all the time and AdiBags places it: only what the
-- last look saw is kept, for the editor's preview.
local IsBagItem = function(name)
	return string_find(name, "^AdiBagsItemButton%d") or string_find(name, "^AdiBagsBankItemButton%d")
end

-- The tabs chosen among `named` (a window's parts, a tab bar in a tab too):
-- what the window shows now, by their names and as they read. (Our own
-- pages' too: the spellbook's companions, mounts and professions.)
local IsTab = function(name, part)
	return (string_find(name, "Tab%d+$") or string_find(name, "TabButton%d+$") or part.DiabolicPageTab)
		and part:IsObjectType("Button")
end

-- How a tab reads: its text, or its tooltip's for an icon's (else its name).
local LabelOf = function(name, part)
	local text = part:GetText()
	if (text ~= nil) and (text ~= "") then
		return text
	end
	return part.tooltip or name
end

local ViewOf = function(named)
	local names = {}
	for name, part in pairs(named) do
		-- (a spellbook school's and a talent spec's are checked, not disabled)
		if IsTab(name, part) and (kit.IsSelected(part) or (part.GetChecked and part:GetChecked())) then
			names[#names + 1] = name
		end
	end
	table_sort(names)
	local labels = {}
	for i, name in ipairs(names) do
		labels[i] = LabelOf(name, named[name])
	end
	return table_concat(names, "+"), table_concat(labels, " / ")
end

-- `window` saved: its parts with where they are and the tabs they showed in,
-- its art, by the tabs chosen.
local Scan = function(window)
	local frame = window.Frame
	local title = frame:GetName() or L["a window"]
	local windows = Saved.windows
	windows[title] = windows[title] or {}
	local seen = windows[title]
	seen.problems, seen.art = nil, nil -- (an older version's)
	seen.checked = date("%Y-%m-%d %H:%M")
	seen.parts = seen.parts or {}
	seen.views = seen.views or {}
	seen.tabButtons = seen.tabButtons or {}
	local named, parts, rows = {}, seen.parts, {}
	-- (our window's parts too: its band, its foot...)
	CollectNamed(frame, nil, named)
	for _, button in ipairs(kit.CollectShown(frame, {})) do
		rows[button] = true
	end
	seen.rect = Rect(frame)
	seen.window = Rect(window)
	for name, part in pairs(named) do
		if IsTab(name, part) then
			seen.tabButtons[name] = LabelOf(name, part)
		end
	end
	local view, label = ViewOf(named)
	-- (this look at it: what's not in it now, a state ago, isn't checked with what is)
	Saved.stamp = (Saved.stamp or 0) + 1
	seen.views[view] = {
		label = label,
		art = PackedArt(frame),
		rect = seen.rect,
		window = seen.window,
		stamp = Saved.stamp,
		worded = true,
	} -- (its parts' `words` say what shows in it)
	local new = 0
	for name, part in pairs(named) do
		local entry = Entry(part, window, rows)
		if entry then
			local old = parts[name]
			new = new + ((type(old) == "table") and 0 or 1)
			entry.tabs = (type(old) == "table") and old.tabs or {}
			if view ~= "" then
				entry.tabs[view] = true
			end
			entry.last = (type(old) == "table") and old.last or {}
			entry.last[view] = Saved.stamp
			entry.words = (type(old) == "table") and old.words or {}
			entry.words[view] = WordsOf(part)
			parts[name] = entry
		end
	end
	for name in pairs(parts) do
		if IsBagItem(name) and not named[name] then
			parts[name] = nil
		end
	end
	-- its parts counted once, and again when new ones show (a page, a tab):
	-- none new, it's all been seen
	if (new > 0) or not Counted[title] then
		Counted[title] = true
		local total = 0
		for _, entry in pairs(parts) do
			total = total + ((type(entry) == "table") and 1 or 0)
		end
		Print(title .. ": " .. string_format(L["%d parts saved (%d new)."], total, new))
	end
end

-- The windows we style: those made, those to come (ours for an addon only if
-- it's there), by name.
local Styled = function()
	local names = {}
	for _, window in ipairs(kit.Windows) do
		local name = window.Frame:GetName()
		if name then
			names[name] = true
		end
	end
	local Add = function(spec)
		if (not spec.addon) or select(5, GetAddOnInfo(spec.addon)) then
			names[spec.frame] = true
		end
	end
	for _, spec in ipairs(Module:GetDB("Blizzard").panels.frames) do
		Add(spec)
	end
	for _, spec in ipairs(kit.config.layout.on_demand) do
		Add(spec)
	end
	return names
end

-- `frame`, or what it's in, one of our windows.
local InOurs = function(frame)
	local ours = {}
	for _, window in ipairs(kit.Windows) do
		ours[window.Frame] = true
	end
	while frame do
		if ours[frame] then
			return true
		end
		frame = frame:GetParent()
	end
end

-- `name` (in the game's lists of windows) shown and not ours: said once, kept.
local NoteUnstyled = function(name)
	local frame = _G[name]
	if
		(type(frame) == "table")
		and frame.IsVisible
		and frame:IsVisible()
		and not kit.config.layout.not_windows[name]
		and (not InOurs(frame))
		and not Saved.unstyled[name]
	then
		Saved.unstyled[name] = true
		Print(string_format(L["Not styled: %s."], name))
	end
end

local FindUnstyled = function()
	Saved.unstyled = Saved.unstyled or {}
	for _, name in ipairs(_G.UISpecialFrames) do
		NoteUnstyled(name)
	end
	for name in pairs(_G.UIPanelWindows) do
		NoteUnstyled(name)
	end
end

-- What's left to scan: { windows, old, tabs (window (its tabs)), unstyled, count }.
local Left = function()
	local left = { windows = {}, old = {}, tabs = {}, unstyled = {}, count = 0 }
	local styled = Styled()
	for name in pairs(styled) do
		local seen = Saved.windows[name]
		if (not seen) or not seen.parts then
			left.windows[#left.windows + 1] = name
			left.count = left.count + 1
		elseif not seen.views then
			left.old[#left.old + 1] = name
			left.count = left.count + 1
		else
			local labels = {}
			for tab, label in pairs(seen.tabButtons or {}) do
				local visited = false
				for key in pairs(seen.views) do
					visited = visited or (("+" .. key .. "+"):find("+" .. tab .. "+", 1, true) ~= nil)
				end
				if not visited then
					labels[#labels + 1] = label
				end
			end
			if labels[1] then
				table_sort(labels)
				left.tabs[#left.tabs + 1] = name .. " (" .. table_concat(labels, ", ") .. ")"
				left.count = left.count + #labels
			end
		end
	end
	Saved.unstyled = Saved.unstyled or {}
	for name in pairs(Saved.unstyled) do
		-- (styled since)
		if styled[name] then
			Saved.unstyled[name] = nil
		else
			left.unstyled[#left.unstyled + 1] = name
		end
	end
	table_sort(left.windows)
	table_sort(left.old)
	table_sort(left.tabs)
	table_sort(left.unstyled)
	Saved.left = left
	return left
end

-- All that's left, said.
Module.Report = function(self)
	local left = Left()
	LeftCount = left.count
	if left.windows[1] then
		Print(string_format(L["Still to open: %s."], table_concat(left.windows, ", ")))
	end
	if left.old[1] then
		Print(string_format(L["Scanned by an older version, open again: %s."], table_concat(left.old, ", ")))
	end
	if left.tabs[1] then
		Print(string_format(L["Tabs not visited: %s."], table_concat(left.tabs, ", ")))
	end
	if left.unstyled[1] then
		Print(string_format(L["Not styled: %s."], table_concat(left.unstyled, ", ")))
	end
	if left.count == 0 then
		Print(L["Every window scanned, every tab visited."])
	end
end

-- Each window's time shown (each frame, while it's on).
local Watch = function()
	for _, window in ipairs(kit.Windows) do
		if window.Frame:IsVisible() then
			Shown[window] = Shown[window] or GetTime()
		else
			Shown[window] = nil
		end
	end
end

-- The tabs of a window only an NPC opens are looked at one by one once it
-- shows, once a scan, then back on the first.
local NPC_TABS = { AuctionFrame = true, GuildBankFrame = true, MailFrame = true, MerchantFrame = true }
local Walk = function(window)
	local name = window.Frame:GetName()
	if (not NPC_TABS[name]) or (Walked[name] == false) or InCombatLockdown() then
		return
	end
	local i, tab = Walked[name] or 0
	repeat
		i = i + 1
		tab = _G[name .. "Tab" .. i]
	until (not tab) or (tab:IsVisible() and (not kit.IsSelected(tab)))
	Walked[name] = tab and i or false
	tab = tab or _G[name .. "Tab1"]
	if tab and (not kit.IsSelected(tab)) then
		tab:Click()
	end
end

local CheckShown = function()
	Watch()
	for _, window in ipairs(kit.Windows) do
		if window.Frame:IsVisible() and window:GetLeft() and (GetTime() - Shown[window] >= SETTLE_TIME) then
			-- (one that breaks said once, the others still saved)
			local ok, err = pcall(Scan, window)
			if ok then
				ok, err = pcall(Walk, window)
			end
			if (not ok) and not Said[err] then
				Said[err] = true
				Print(string_format(L["%s couldn't be scanned: %s"], window.Frame:GetName() or L["a window"], err))
			end
		end
	end
	FindUnstyled()
	-- (less left: how much, as it goes)
	local left = Left()
	if LeftCount and (left.count < LeftCount) then
		Print(string_format(L["%d left to scan (/dui layout left)."], left.count))
	end
	LeftCount = left.count
end

Module.Start = function(self)
	Said, Counted, Walked = {}, {}, {}
	-- (those already shown: settled)
	for _, window in ipairs(kit.Windows) do
		if window.Frame:IsVisible() then
			Shown[window] = GetTime() - SETTLE_TIME
		end
	end
	CheckShown()
	self.Ticker:Show()
end

Module.Toggle = function(self)
	if self.Ticker:IsShown() then
		self.Ticker:Hide()
		Print(L["Layout scan off: /reload to write it."])
		return
	end
	Print(L["Layout scan on: each window is saved as it shows. /dui layout again to stop."])
	self:Start()
	self:Report()
end

-- The sweep's steps: each shows a window or one of its pages (the window
-- before closed), saved after it (once its layout is done).
local Open = function(open)
	return function()
		_G.CloseAllWindows()
		open()
	end
end
local Tab = function(name)
	return function()
		local tab = _G[name]
		if tab and tab:IsVisible() then
			tab:Click()
		end
	end
end
-- One of the spellbook's own pages (companions, mounts, professions),
-- when the character has it.
local Page = function(mode)
	return function()
		local book = Engine:GetModule("Blizzard: Spellbook")
		if _G.SpellBookFrame:IsShown() and book.HasPage and ((not mode) or book:HasPage(mode)) then
			book:ShowPage(mode)
		end
	end
end
local STEPS = {
	Open(function()
		_G.ToggleCharacter("PaperDollFrame")
	end),
	Tab("DiabolicUICharacterSideTab2"),
	Tab("DiabolicUICharacterSideTab3"),
	Tab("DiabolicUICharacterSideTab1"), -- titles, sets, stats
	function()
		_G.ToggleCharacter("ReputationFrame")
	end,
	function()
		_G.ToggleCharacter("SkillFrame")
	end,
	function()
		_G.ToggleCharacter("TokenFrame")
	end,
	function()
		if _G.TokenFramePopup then
			_G.TokenFramePopup:Show()
		end
	end,
	function()
		_G.ToggleCharacter("PetPaperDollFrame")
	end, -- (the pet's, or the companions')
	Tab("PetPaperDollFrameTab2"),
	Tab("PetPaperDollFrameTab3"),
	Open(function()
		_G.ToggleSpellBook(_G.BOOKTYPE_SPELL)
	end),
	Tab("SpellBookSkillLineTab2"),
	Tab("SpellBookSkillLineTab3"),
	Tab("SpellBookSkillLineTab4"),
	Tab("SpellBookSkillLineTab1"),
	Page("CRITTER"),
	Page("MOUNT"),
	Page("PROFESSIONS"),
	Page(nil),
	Tab("SpellBookFrameTabButton2"), -- the pet's book
	Open(function()
		_G.ToggleTalentFrame()
	end),
	Tab("PlayerTalentFrameTab1"),
	Tab("PlayerTalentFrameTab2"),
	Tab("PlayerTalentFrameTab3"),
	Tab("PlayerTalentFrameTab4"),
	Tab("PlayerSpecTab2"),
	Tab("PlayerSpecTab3"), -- the second spec, the pet's
	Open(function()
		_G.ToggleFriendsFrame(1)
	end),
	Tab("FriendsTabHeaderTab2"),
	Tab("FriendsTabHeaderTab3"), -- ignored, pending
	function()
		_G.ToggleFriendsFrame(2)
	end,
	function()
		_G.ToggleFriendsFrame(3)
	end,
	Tab("GuildFrameGuildInformationButton"),
	function()
		_G.ToggleFriendsFrame(4)
	end,
	function()
		_G.ToggleFriendsFrame(5)
	end,
	Tab("RaidFrameRaidInfoButton"),
	Open(function()
		_G.ToggleFrame(_G.QuestLogFrame)
	end),
	Open(function()
		_G.ToggleAchievementFrame()
	end),
	Tab("AchievementFrameTab2"),
	Tab("AchievementFrameTab3"), -- and Overachiever's
	Tab("AchievementFrameTab4"),
	Tab("AchievementFrameTab5"),
	Tab("AchievementFrameTab6"),
	Open(function()
		_G.ToggleLFDParentFrame()
	end),
	Open(function()
		_G.ToggleLFRParentFrame()
	end),
	Tab("LFRParentFrameTab2"),
	Open(function()
		_G.TogglePVPFrame()
	end),
	Tab("PVPParentFrameTab2"),
	Open(function()
		_G.ShowMacroFrame()
	end),
	Tab("MacroFrameTab2"),
	Open(function()
		_G.ShowUIPanel(_G.DressUpFrame)
	end),
	Open(function()
		local board = _G.GroupBulletinBoard_Addon
		if board and board.ShowWindow then
			board.ShowWindow()
		end
	end),
	-- the one targeted, when a player in reach
	Open(function()
		if _G.UnitIsPlayer("target") and _G.CanInspect("target") and _G.CheckInteractDistance("target", 1) then
			_G.InspectUnit("target")
		end
	end),
	Tab("InspectFrameTab2"),
	Tab("InspectFrameTab3"),
	-- (closed, it opens the game menu, and no panel opens over that: the next
	-- ones aren't panels)
	Open(function()
		_G.KeyBindingFrame_LoadUI()
		_G.ShowUIPanel(_G.KeyBindingFrame)
	end),
	Open(function()
		Engine:GetModule("ChatCopy"):Show(_G.ChatFrame1)
	end),
	Open(function()
		_G.OpenAllBags()
	end),
	function()
		_G.CloseAllBags()
		_G.CloseAllWindows()
	end,
}
local STEP_TIME = 0.6 -- each step's wait before it's saved (the layout done on the next frame)

-- Each window that needs no NPC opened in turn, page by page, and saved.
Module.Sweep = function(self)
	if InCombatLockdown() then
		Print(L["Not in combat."])
		return
	end
	Print(L["Layout scan: each window opened in turn."])
	if not self.Ticker:IsShown() then
		self:Start()
	end
	local step, elapsed = 0, STEP_TIME
	self.Sweeper:SetScript("OnUpdate", function(sweeper, delta)
		elapsed = elapsed + delta
		if elapsed < STEP_TIME then
			return
		end
		elapsed = 0
		CheckShown()
		step = step + 1
		if InCombatLockdown() or not STEPS[step] then
			sweeper:SetScript("OnUpdate", nil)
			local windows = 0
			for _ in pairs(Saved.windows) do
				windows = windows + 1
			end
			Print(string_format(L["Layout scan done: %d windows saved (/reload to write them)."], windows))
			self:Report()
			return
		end
		local ok, err = pcall(STEPS[step])
		if not ok then
			Print(string_format(L["%s couldn't be scanned: %s"], L["a window"], err))
		end
	end)
end

Module.OnEnable = function(self)
	kit = Engine:GetModule("Blizzard: Windows")
	local ticker, elapsed = CreateFrame("Frame"), 0
	ticker:Hide()
	ticker:SetScript("OnUpdate", function(_, delta)
		Watch()
		elapsed = elapsed + delta
		if elapsed >= 1 then
			elapsed = 0
			CheckShown()
		end
	end)
	self.Ticker = ticker
	self.Sweeper = CreateFrame("Frame")
	Saved = _G.DiabolicUI_Layout or {}
	Saved.windows = Saved.windows or {}
	Saved.on, Saved.moved, Saved.adjust = nil, nil, nil -- (an older version's)
	-- (their views from before a checked tab counted, and our pages' tabs:
	-- seen again by the next scan)
	for _, dropped in ipairs({
		{ "checkedTabs", "SpellBookFrame", "PlayerTalentFrame" },
		{ "pageTabs", "SpellBookFrame" },
	}) do
		if not Saved[dropped[1]] then
			Saved[dropped[1]] = true
			for i = 2, #dropped do
				local seen = Saved.windows[dropped[i]]
				if seen then
					seen.views = nil
					for _, part in pairs(seen.parts or {}) do
						if type(part) == "table" then
							part.tabs, part.last, part.words = nil, nil, nil
						end
					end
				end
			end
		end
	end
	_G.DiabolicUI_Layout = Saved
	self:GetHandler("ChatCommand"):Register("layout", function(what)
		if what == "all" then
			self:Sweep()
		elseif what == "left" then
			self:Report()
		else
			self:Toggle()
		end
	end)
end
