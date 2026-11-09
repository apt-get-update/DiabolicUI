-- Run from the addon root: lua5.1 tests/test_session_group_combat_chat.lua
--
-- In the fake client: combo points, the marks of a channel's ticks, the raid
-- frames' range, marks and ready checks, the health orb's cutaway, short
-- channel names and the chat history.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client, module

local function boot(options)
	client = Client.boot(options)
	module = client:GetModule("UnitFrames")
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

local function playerOrb()
	return (module:GetWidget("Unit: Player"):GetFrame())
end

-- Combo points -------------------------------------------------------------------

TestComboPoints = {}

function TestComboPoints:tearDown()
	client, module = nil, nil
end

function TestComboPoints:test_lit_up_to_the_points_on_the_target()
	boot({ class = "ROGUE" })
	local points = playerOrb().ComboPoints
	lu.assertFalse(shown(points))

	client.world.comboPoints = 3
	client:FireEvent("UNIT_COMBO_POINTS", "player")
	lu.assertTrue(shown(points))
	lu.assertEquals(#points, 5)
	lu.assertTrue(shown(points[3].Fill))
	lu.assertTrue(shown(points[3].Glow))
	lu.assertFalse(shown(points[4].Fill))

	client.world.comboPoints = 0
	client:FireEvent("PLAYER_TARGET_CHANGED")
	lu.assertFalse(shown(points))
	assertClean(client)
end

-- Channel ticks ------------------------------------------------------------------

TestChannelTicks = {}

function TestChannelTicks:setUp()
	boot({
		class = "MAGE",
		world = function(world)
			world.spells[5143] = { name = "Arcane Missiles" }
		end,
	})
	self.bar = playerOrb().CastBar
	self.me = client.world.units.player
end

function TestChannelTicks:tearDown()
	client, module, self.bar, self.me = nil, nil, nil, nil
end

local function channel(me, name, seconds)
	local now = client.world.time * 1000
	me.channeling = { name = name, startTime = now, endTime = now + seconds * 1000 }
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
end

local function shownTicks(bar)
	local count = 0
	for _, tick in ipairs(bar.Ticks) do
		if shown(tick) then
			count = count + 1
		end
	end
	return count
end

function TestChannelTicks:test_marks_between_the_ticks_counted_from_the_right()
	channel(self.me, "Arcane Missiles", 5)
	lu.assertEquals(shownTicks(self.bar), 4)
	local point, _, _, x = self.bar.Ticks[1]:GetPoint()
	lu.assertEquals(point, "RIGHT")
	lu.assertAlmostEquals(x, -self.bar:GetWidth() / 5, 0.01)
	assertClean(client)
end

function TestChannelTicks:test_pushback_drops_the_last_marks_and_keeps_the_interval()
	channel(self.me, "Arcane Missiles", 5)
	self.me.channeling.endTime = self.me.channeling.endTime - 1000
	client:FireEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
	lu.assertEquals(shownTicks(self.bar), 3)
	local _, _, _, x = self.bar.Ticks[1]:GetPoint()
	lu.assertAlmostEquals(x, -self.bar:GetWidth() / 4, 0.01)
	assertClean(client)
end

function TestChannelTicks:test_other_channels_and_casts_have_none()
	channel(self.me, "Arcane Missiles", 5)
	channel(self.me, "Fishing", 5)
	lu.assertEquals(shownTicks(self.bar), 0)

	channel(self.me, "Arcane Missiles", 5)
	self.me.channeling = nil
	local now = client.world.time * 1000
	self.me.casting = { name = "Frostbolt", startTime = now, endTime = now + 2000 }
	client:FireEvent("UNIT_SPELLCAST_START", "player")
	lu.assertEquals(shownTicks(self.bar), 0)
	assertClean(client)
end

-- Raid frames --------------------------------------------------------------------

TestRaidStatus = {}

function TestRaidStatus:setUp()
	boot({
		world = function(world)
			local member = Client.newUnit({ class = "PRIEST" })
			member.subgroup = 1
			member.inRange = true
			world.units.raid1 = member
		end,
	})
	client:FireEvent("RAID_ROSTER_UPDATE")
	client:Tick(0.5)
	self.frame = module:GetWidget("Unit: Raid"):GetFrame(1)
	self.member = client.world.units.raid1
end

function TestRaidStatus:tearDown()
	client, module, self.frame, self.member = nil, nil, nil, nil
end

function TestRaidStatus:test_out_of_range_fades()
	lu.assertEquals(self.frame:GetAlpha(), 1)
	self.member.inRange = false
	client:Tick(0.5)
	lu.assertEquals(self.frame:GetAlpha(), 0.45)
	self.member.inRange = true
	client:Tick(0.5)
	lu.assertEquals(self.frame:GetAlpha(), 1)
	assertClean(client)
end

function TestRaidStatus:test_raid_marks()
	lu.assertFalse(shown(self.frame.RaidMark))
	self.member.raidTarget = 8
	client:FireEvent("RAID_TARGET_UPDATE")
	lu.assertTrue(shown(self.frame.RaidMark))
	self.member.raidTarget = nil
	client:FireEvent("RAID_TARGET_UPDATE")
	lu.assertFalse(shown(self.frame.RaidMark))
	assertClean(client)
end

function TestRaidStatus:test_a_ready_check_and_who_never_answered()
	local check = self.frame.ReadyCheck
	lu.assertFalse(shown(check))
	self.member.readyCheck = "waiting"
	client:FireEvent("READY_CHECK", "Leader", 30)
	lu.assertTrue(shown(check))
	lu.assertEquals(check.status, "waiting")

	self.member.readyCheck = nil
	client:FireEvent("READY_CHECK_FINISHED")
	lu.assertTrue(shown(check))
	lu.assertEquals(check.status, "notready")
	client:Tick(11, 0.5)
	lu.assertFalse(shown(check))
	assertClean(client)
end

function TestRaidStatus:test_an_answer_overrides_the_wait()
	local check = self.frame.ReadyCheck
	self.member.readyCheck = "waiting"
	client:FireEvent("READY_CHECK", "Leader", 30)
	self.member.readyCheck = "ready"
	client:FireEvent("READY_CHECK_CONFIRM", "raid1", 1)
	lu.assertEquals(check.status, "ready")
	self.member.readyCheck = nil
	client:FireEvent("READY_CHECK_FINISHED")
	lu.assertEquals(check.status, "ready") -- an answer stays what it was
	assertClean(client)
end

-- The health orb's cutaway --------------------------------------------------------

TestCutaway = {}

function TestCutaway:setUp()
	boot()
	self.me = client.world.units.player
	self.me.healthMax = 1000
	self.me.health = 1000
	client:Tick(0.5)
	self.orb = playerOrb().Health
end

function TestCutaway:tearDown()
	client, module, self.me, self.orb = nil, nil, nil, nil
end

function TestCutaway:test_a_loss_stays_then_drains_away()
	lu.assertFalse(shown(self.orb.cutaway))
	self.me.health = 500
	client:Tick(0.1, 0.05)
	lu.assertTrue(shown(self.orb.cutaway))
	lu.assertEquals(self.orb.cutaway.value, 1000)
	client:Tick(3, 0.05)
	lu.assertFalse(shown(self.orb.cutaway))
	assertClean(client)
end

function TestCutaway:test_healing_past_it_ends_it()
	self.me.health = 500
	client:Tick(0.1, 0.05)
	self.me.health = 1000
	client:Tick(0.1, 0.05)
	lu.assertFalse(shown(self.orb.cutaway))
	assertClean(client)
end

function TestCutaway:test_a_new_maximum_ends_it()
	self.me.health = 500
	client:Tick(0.1, 0.05)
	self.me.healthMax = 800
	client:Tick(0.1, 0.05)
	lu.assertFalse(shown(self.orb.cutaway))
	assertClean(client)
end

-- Chat ---------------------------------------------------------------------------

local function setChannelFormats()
	_G.CHAT_GUILD_GET = "|Hchannel:GUILD|h[Guild]|h %s:\32"
	_G.CHAT_RAID_LEADER_GET = "|Hchannel:RAID|h[Raid Leader]|h %s:\32"
end

local function lastLine(frame)
	local messages = client.widgetState[frame].messages
	return messages[#messages].text
end

-- A line of conversation on its way to the window, as Blizzard runs it.
local function say(frame, text, r, g, b)
	for _, filter in ipairs(client.chatFilters.CHAT_MSG_GUILD) do
		filter(frame, "CHAT_MSG_GUILD", text)
	end
	frame:AddMessage(text, r, g, b)
end

TestShortChannels = {}

function TestShortChannels:tearDown()
	client, module = nil, nil
end

function TestShortChannels:test_names_and_numbers()
	boot({ world = setChannelFormats })
	local frame = _G.ChatFrame1
	frame:AddMessage("|Hchannel:GUILD|h[Guild]|h Bob: hi")
	lu.assertStrContains(lastLine(frame), "|Hchannel:GUILD|hG|h")
	frame:AddMessage("|Hchannel:RAID|h[Raid Leader]|h Bob: hi")
	lu.assertStrContains(lastLine(frame), "|Hchannel:RAID|hRL|h")
	frame:AddMessage("|Hchannel:channel:2|h[2. Trade - City]|h Bob: wts")
	lu.assertStrContains(lastLine(frame), "|Hchannel:channel:2|h2.|h")
	assertClean(client)
end

function TestShortChannels:test_turned_off()
	boot({ world = setChannelFormats })
	client:GetModule("ChatFilters").db.shortChannels = false
	local frame = _G.ChatFrame1
	frame:AddMessage("|Hchannel:channel:2|h[2. Trade - City]|h Bob: wts")
	lu.assertStrContains(lastLine(frame), "[2. Trade - City]")
	assertClean(client)
end

TestChatHistory = {}

function TestChatHistory:tearDown()
	client, module = nil, nil
end

function TestChatHistory:test_keeps_conversation_only()
	boot()
	local frame = _G.ChatFrame1
	local log = client:GetModule("ChatHistory").db
	say(frame, "hello", 0.2, 0.3, 0.4)
	frame:AddMessage("You receive loot") -- nothing marked it
	lu.assertEquals(#log.ChatFrame1, 1)
	lu.assertEquals(log.ChatFrame1[1], { "hello", 0.2, 0.3, 0.4 })
	assertClean(client)
end

function TestChatHistory:test_a_mark_goes_stale()
	boot()
	local frame = _G.ChatFrame1
	for _, filter in ipairs(client.chatFilters.CHAT_MSG_GUILD) do
		filter(frame, "CHAT_MSG_GUILD", "hello")
	end
	client:Tick(0.1)
	frame:AddMessage("You receive loot")
	lu.assertNil(client:GetModule("ChatHistory").db.ChatFrame1)
	assertClean(client)
end

function TestChatHistory:test_a_whisper_window_opened_later_keeps_none()
	boot()
	local history = client:GetModule("ChatHistory")
	local whisperWindow = {}
	for _, filter in ipairs(client.chatFilters.CHAT_MSG_GUILD) do
		filter(whisperWindow, "CHAT_MSG_GUILD", "hello")
	end
	history:Record(whisperWindow, "hello")
	lu.assertNil(next(history.db))
	assertClean(client)
end

function TestChatHistory:test_the_last_100_lines()
	boot()
	local frame = _G.ChatFrame1
	for i = 1, 105 do
		say(frame, "line " .. i)
	end
	local lines = client:GetModule("ChatHistory").db.ChatFrame1
	lu.assertEquals(#lines, 100)
	lu.assertEquals(lines[1][1], "line 6")
	assertClean(client)
end

function TestChatHistory:test_turned_off_keeps_nothing()
	boot()
	client:GetModule("ChatFilters").db.chatHistory = false
	say(_G.ChatFrame1, "hello")
	lu.assertNil(client:GetModule("ChatHistory").db.ChatFrame1)
	assertClean(client)
end

-- Boots with `lines` saved for this character.
local function bootWithSaved(lines, filters)
	boot()
	local character = _G.UnitName("player") .. "-" .. _G.GetRealmName()
	boot({
		savedVariables = {
			DiabolicUI_DB = {
				ChatHistory = { profiles = { character = { [character] = { ChatFrame1 = lines } } } },
				ChatFilters = { profiles = { global = filters } },
			},
		},
	})
end

local function texts(frame)
	local found = {}
	for _, message in ipairs(client.widgetState[frame].messages) do
		found[message.text] = message
	end
	return found
end

function TestChatHistory:test_comes_back_after_a_reload()
	bootWithSaved({ { "old line", 0.2, 0.3, 0.4 } }, {})
	local found = texts(_G.ChatFrame1)
	lu.assertNotNil(found["old line"])
	lu.assertEquals(found["old line"].r, 0.2)
	lu.assertNotNil(found["(earlier messages)"])
	assertClean(client)
end

function TestChatHistory:test_turned_off_forgets_it_at_login()
	bootWithSaved({ { "old line", 1, 1, 1 } }, { chatHistory = false })
	lu.assertNil(texts(_G.ChatFrame1)["old line"])
	lu.assertNil(client:GetModule("ChatHistory").db.ChatFrame1)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
