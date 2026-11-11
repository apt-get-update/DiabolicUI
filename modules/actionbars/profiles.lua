-- Action bar profiles: what's on your bars saved under a name, put back as it
-- was (/dui bars, and the specialization button). Action Bar Saver's
-- profiles are brought over while it's still installed.
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

-- This class's profiles, by name.
Module.GetSets = function(self)
	local class = select(2, UnitClass("player"))
	self.db.sets[class] = self.db.sets[class] or {}
	return self.db.sets[class]
end

-- Their names, sorted.
Module.GetNames = function(self)
	local names = {}
	for name in pairs(self:GetSets()) do
		names[#names + 1] = name
	end
	table.sort(names)
	return names
end

-- What's in `slot`, as saved: { kind, what to find it by }.
local ReadSlot = function(slot)
	local kind, id, subType = GetActionInfo(slot)
	if kind == "spell" then
		local name = GetSpellName(id, BOOKTYPE_SPELL)
		return name and { kind, name }
	elseif kind == "item" then
		return { kind, id }
	elseif kind == "macro" then
		local name, _, body = GetMacroInfo(id)
		return name and { kind, name, body }
	elseif kind == "equipmentset" then
		return { kind, id }
	elseif kind == "companion" then
		return { kind, subType, id }
	end
end

Module.Save = function(self, name)
	local set = {}
	for slot = 1, SLOTS do
		if IsSaved(slot) then
			set[slot] = ReadSlot(slot)
		end
	end
	self:GetSets()[name] = set
	Print(L["Action bars saved as '%s'."]:format(name))
end

Module.Delete = function(self, name)
	self:GetSets()[name] = nil
	Print(L["Action bar profile '%s' deleted."]:format(name))
end

-- The spellbook's spells by name, at their highest rank; the macros by body,
-- then by name.
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
Module.Restore = Engine:Wrap(function(self, name)
	local set = self:GetSets()[name]
	if not set then
		Print(L["No action bar profile named '%s'."]:format(name))
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
	if missing > 0 then
		Print(L["Action bars '%s' restored, %d buttons couldn't be found."]:format(name, missing))
	else
		Print(L["Action bars '%s' restored."]:format(name))
	end
end)

-- Action Bar Saver's profiles we don't have yet, in our form (its are
-- "kind|id|binding|name|...").
Module.ImportActionBarSaver = function(self)
	local old = _G.ActionBarSaverDB
	for class, sets in pairs(old and old.sets or {}) do
		self.db.sets[class] = self.db.sets[class] or {}
		for name, set in pairs(sets) do
			if not self.db.sets[class][name] then
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
				self.db.sets[class][name] = ours
			end
		end
	end
end

-- /dui bars [save|restore|delete <name>]: the profiles listed without.
Module.OnCommand = function(self, action, ...)
	local name = table.concat({ ... }, " ")
	if (action == "save" or action == "restore" or action == "delete") and name ~= "" then
		local run = { save = self.Save, restore = self.Restore, delete = self.Delete }
		run[action](self, name)
		return
	end
	local names = self:GetNames()
	Print(
		#names > 0 and L["Action bar profiles: %s."]:format(table.concat(names, ", "))
			or L["No action bar profiles yet."]
	)
	Print(L["/dui bars save, restore or delete <name>"])
end

Module.OnInit = function(self)
	self.db = Engine:GetConfig("ActionBarProfiles")
end

Module.OnEnable = function(self)
	self:ImportActionBarSaver()
	self:GetHandler("ChatCommand"):Register("bars", function(...)
		self:OnCommand(...)
	end)
end
