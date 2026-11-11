-- Chat history: the last lines of conversation in each chat window (not
-- system lines or loot) are saved per character and come back after a
-- /reload or a relog. The line is taken as shown, from filters.lua's
-- AddMessage, and put back the same way past that function.
local _, Engine = ...
local Module = Engine:NewModule("ChatHistory")
local L = Engine:GetLocale()

local MAX_LINES = 100 -- per window

local names = {} -- [chat window] = its name, for the windows that keep a history
local marked = {} -- [chat window] = when a line of conversation was on its way there

-- Blizzard runs a message's filters and shows it in one go, all within a
-- moment of game time. A filter of another addon may still drop the line, or
-- the window may not be in that channel: the mark then goes stale, which the
-- time tells.
local MarkLine = function(frame)
	marked[frame] = GetTime()
	return false
end

-- Called by filters.lua with every line shown.
Module.Record = function(self, frame, msg, r, g, b)
	if (marked[frame] ~= GetTime()) or not self.filters.chatHistory then
		return
	end
	marked[frame] = nil
	local name = names[frame]
	if not name then
		return
	end
	local lines = self.db[name]
	if not lines then
		lines = {}
		self.db[name] = lines
	end
	table.insert(lines, { msg, r, g, b })
	if #lines > MAX_LINES then
		table.remove(lines, 1)
	end
end

-- Once, as the world shows: a line added during the loading screen would
-- have faded before anybody saw it.
Module.Restore = function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD", "Restore")
	if not self.filters.chatHistory then
		wipe(self.db)
		return
	end
	for name, lines in pairs(self.db) do
		local frame = _G[name]
		if frame and frame.old and (#lines > 0) then
			local show = frame.old.message
			for _, line in ipairs(lines) do
				show(frame, line[1], line[2], line[3], line[4])
			end
			show(frame, L["(earlier messages)"], 0.5, 0.5, 0.5)
		end
	end
end

Module.OnInit = function(self)
	self.db = self:GetConfig("ChatHistory", "character")
	self.filters = self:GetConfig("ChatFilters")
end

Module.OnEnable = function(self)
	for _, name in ipairs(_G.CHAT_FRAMES) do
		names[_G[name]] = name
	end
	for _, event in ipairs(Engine:GetModule("ChatCleaner").PLAYER_CHAT) do
		ChatFrame_AddMessageEventFilter(event, MarkLine)
	end
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Restore")
end
