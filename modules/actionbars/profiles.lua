-- Each specialization's action bars: saved from the options' Specializations
-- page, put back as they were once switched to it (or by Restore there),
-- with how many bars and side bars were shown.
-- The Action Bar Saver profiles the specializations used come over while
-- that addon is still installed.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("ActionBars: Profiles", "LOW")

local SLOTS = 144
local POSSESS_FIRST, POSSESS_LAST = 121, 132 -- (the vehicle's and possession's, the game's own)
local MAX_MACROS = 54

local Print = function(text)
	DEFAULT_CHAT_FRAME:AddMessage("|cffff7f2fDiabolicUI|r: " .. text)
end

local IsSaved = function(slot)
	return slot < POSSESS_FIRST or slot > POSSESS_LAST
end

-- Talent group `group`'s name ("Shadow"), or Primary / Secondary.
local SpecName = function(group)
	local name = Engine:GetModule("ActionBars"):GetWidget("Button: Spec Switch"):GetSpec(group)
	return name or (group == 1 and _G.PRIMARY or _G.SECONDARY)
end

-- What's in `slot`, as saved: { kind, what to find it by }.
local ReadSlot = function(slot)
	local kind, id, subType = GetActionInfo(slot)
	if kind == "spell" then
		local name = GetSpellName(id, BOOKTYPE_SPELL)
		return name and { kind, name }
	elseif kind == "item" or kind == "equipmentset" then
		return { kind, id }
	elseif kind == "macro" then
		local name, _, body = GetMacroInfo(id)
		return name and { kind, name, body }
	elseif kind == "companion" then
		return { kind, subType, id }
	end
end

Module.HasSaved = function(self, group)
	return self.db["specActions" .. group] and true or false
end

Module.Save = function(self, group)
	local set = {}
	for slot = 1, SLOTS do
		if IsSaved(slot) then
			set[slot] = ReadSlot(slot)
		end
	end
	set.bars, set.sideBars = self.db.num_bars, self.db.num_side_bars
	self.db["specActions" .. group] = set
	Print(L["Action bars saved for %s."]:format(SpecName(group)))
end

-- The spellbook's spells by name, at their highest rank.
local FindSpells = function()
	local spells = {}
	for tab = 1, GetNumSpellTabs() do
		local _, _, offset, count = GetSpellTabInfo(tab)
		for index = offset + 1, offset + count do
			local name = GetSpellName(index, BOOKTYPE_SPELL)
			if name then
				spells[name] = index
			end
		end
	end
	return spells
end

-- A macro by its body, else its name.
local FindMacro = function(name, body)
	local byName
	for index = 1, MAX_MACROS do
		local macroName, _, macroBody = GetMacroInfo(index)
		if macroBody and macroBody == body then
			return index
		end
		if macroName == name then
			byName = byName or index
		end
	end
	return byName
end

-- `entry` onto the cursor.
local Pickup = function(entry, spells)
	local kind, what, extra = entry[1], entry[2], entry[3]
	if kind == "spell" then
		if spells[what] then
			PickupSpell(spells[what], BOOKTYPE_SPELL)
		end
	elseif kind == "item" then
		PickupItem(what)
	elseif kind == "macro" then
		local index = FindMacro(what, extra)
		if index then
			PickupMacro(index)
		end
	elseif kind == "equipmentset" then
		for index = 1, GetNumEquipmentSets() do
			if GetEquipmentSetInfo(index) == what then
				PickupEquipmentSet(index)
			end
		end
	elseif kind == "companion" then
		PickupCompanion(what, extra)
	end
	return GetCursorInfo() == kind
end

-- Every slot as saved, emptied when it was; what can't be found any more
-- (a spell not learned, an item not carried) left empty and counted. Out
-- of combat: waits for its end.
Module.Restore = Engine:Wrap(function(self, group)
	local set = self.db["specActions" .. group]
	if not set then
		Print(L["No action bars saved for %s yet."]:format(SpecName(group)))
		return
	end
	local spells, missing = FindSpells(), 0
	local sound = GetCVar("Sound_EnableAllSound")
	SetCVar("Sound_EnableAllSound", 0) -- (each pick up and drop clicks)
	ClearCursor()
	for slot = 1, SLOTS do
		if IsSaved(slot) then
			if GetActionInfo(slot) then
				PickupAction(slot)
				ClearCursor()
			end
			local entry = set[slot]
			if entry then
				if Pickup(entry, spells) then
					PlaceAction(slot)
				else
					missing = missing + 1
				end
				ClearCursor()
			end
		end
	end
	SetCVar("Sound_EnableAllSound", sound)
	if set.bars then
		self.db.num_bars, self.db.num_side_bars = set.bars, set.sideBars
		Engine:GetModule("ActionBars"):ApplySettings()
	end
	if missing > 0 then
		Print(L["%s's action bars restored, %d buttons couldn't be found."]:format(SpecName(group), missing))
	else
		Print(L["%s's action bars restored."]:format(SpecName(group)))
	end
end)

-- The Action Bar Saver profile each specialization used (its name, kept
-- in specProfile until then), in our form: its are "kind|id|binding|...".
Module.ImportActionBarSaver = function(self)
	local old = _G.ActionBarSaverDB
	local sets = old and old.sets and old.sets[select(2, UnitClass("player"))] or {}
	for group = 1, 2 do
		local set = sets[self.db["specProfile" .. group] or ""]
		if set and not self.db["specActions" .. group] then
			local ours = {}
			for slot, text in pairs(set) do
				local kind, id, _, a, b, c = string.split("|", text)
				if kind == "spell" then
					ours[slot] = { kind, a }
				elseif kind == "item" then
					ours[slot] = { kind, tonumber(id) }
				elseif kind == "macro" then
					ours[slot] = { kind, (a:gsub("/124", "|")), (c:gsub("/n", "\n"):gsub("/124", "|")) }
				elseif kind == "equipmentset" then
					ours[slot] = { kind, id }
				elseif kind == "companion" then
					ours[slot] = { kind, b, tonumber(id) }
				end
			end
			-- (with the bar counts the specialization was set to)
			ours.bars = self.db["specBars" .. group] or self.db.num_bars
			ours.sideBars = self.db["specSideBars" .. group] or self.db.num_side_bars
			self.db["specActions" .. group] = ours
			self.db["specProfile" .. group] = false
		end
	end
end

Module.OnInit = function(self)
	self.db = Engine:GetConfig("ActionBars", "character")
end

Module.OnEnable = function(self)
	self:ImportActionBarSaver()
end
