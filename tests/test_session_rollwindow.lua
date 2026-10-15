-- Run from the addon root: lua5.1 tests/test_session_rollwindow.lua
--
-- modules/blizzard/rollwindow.lua in the fake client: a raid's master
-- looter, leader or raid warning puts items up for a roll in the chat, the
-- window shows each with its time left and the Main Spec (/roll 100) and
-- Off Spec (/roll 99) buttons, then your roll, and lets the item go once
-- it's won or the time is up. Others' messages, and the option off, show nothing.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local client, module

-- a raid: you, its leader, and Loot, the master looter
local function boot(savedVariables)
	client = Client.boot({ savedVariables = savedVariables })
	client.world.units.raid1 = Client.newUnit({ name = client.world.units.player.name, rank = 0 })
	client.world.units.raid2 = Client.newUnit({ name = "Boss", rank = 2 })
	client.world.units.raid3 = Client.newUnit({ name = "Loot", rank = 0 })
	client.world.units.raid4 = Client.newUnit({ name = "Someone", rank = 0 })
	client.world.lootMethod = { "master", nil, 3 }
	module = client:GetModule("Blizzard: RollWindow")
	client:Tick(0.2)
end

local function say(event, message, sender)
	client:FireEvent(event, message, sender)
end

local function rows()
	return module.rows
end

TestRollWindow = {}

function TestRollWindow:tearDown()
	client, module = nil, nil
end

function TestRollWindow:test_the_master_looters_roll_and_yours()
	boot()
	local sword = Session.item(client, 100, { name = "Sword", quality = 4, texture = "Interface\\Icons\\Sword" })
	say("CHAT_MSG_RAID", "Roll for " .. sword .. ": /roll (MS) or /roll 99 (OS). 20s", "Loot")
	lu.assertEquals(#rows(), 1)
	local row = rows()[1]
	lu.assertEquals(_G.DiabolicRollFrame:IsShown(), 1)
	lu.assertEquals(row.Icon:GetTexture(), "Interface\\Icons\\Sword")
	lu.assertEquals(row.Name:GetText(), sword)
	client:Tick(5)
	lu.assertEquals(row.Time:GetText(), "15")

	-- off spec
	row.OffSpec:Click()
	lu.assertEquals(client.rolls, { { 1, 99 } })
	say("CHAT_MSG_SYSTEM", client.world.units.player.name .. " rolls 87 (1-99)")
	lu.assertNil(row.OffSpec:IsShown())
	lu.assertEquals(row.Result:GetText(), "You rolled 87 (Off Spec)")
	-- someone else's roll changes nothing
	say("CHAT_MSG_SYSTEM", "Someone rolls 12 (1-100)")
	lu.assertEquals(row.Result:GetText(), "You rolled 87 (Off Spec)")

	-- won: gone, and the window with it
	say("CHAT_MSG_RAID", "Someone wins " .. sword .. " with a roll of 95.", "Loot")
	lu.assertEquals(#rows(), 0)
	lu.assertNil(_G.DiabolicRollFrame:IsShown())
	Session.assertClean(client)
end

function TestRollWindow:test_several_items_and_the_time_running_out()
	boot()
	local ring = Session.item(client, 101, { name = "Ring" })
	local cloak = Session.item(client, 102, { name = "Cloak" })
	say("CHAT_MSG_RAID_WARNING", "Roll " .. ring .. " " .. cloak, "Boss")
	lu.assertEquals(#rows(), 2)
	rows()[2].MainSpec:Click()
	lu.assertEquals(client.rolls, { { 1, 100 } })
	-- 15 seconds when the message doesn't say: then gone
	client:Tick(14)
	lu.assertEquals(#rows(), 2)
	-- "Stopping rolls in 5": the last one's time
	say("CHAT_MSG_RAID_LEADER", "Stopping rolls in 5", "Boss")
	client:Tick(2)
	lu.assertEquals(#rows(), 1)
	lu.assertEquals(rows()[1].Name:GetText(), cloak)
	client:Tick(4)
	lu.assertEquals(#rows(), 0)
	Session.assertClean(client)
end

function TestRollWindow:test_an_item_not_seen_yet_gets_its_icon_later()
	boot()
	local link = "|cffa335ee|Hitem:200:0:0:0:0:0:0:0:80|h[Unknown Helm]|h|r"
	say("CHAT_MSG_RAID", "roll " .. link, "Loot")
	local row = rows()[1]
	lu.assertEquals(row.Icon:GetTexture(), "Interface\\Icons\\INV_Misc_QuestionMark")
	client.world.itemInfo[200] = { name = "Unknown Helm", texture = "Interface\\Icons\\Helm" }
	client:Tick(0.2)
	lu.assertEquals(row.Icon:GetTexture(), "Interface\\Icons\\Helm")
	Session.assertClean(client)
end

function TestRollWindow:test_others_and_the_option_off_show_nothing()
	boot()
	local sword = Session.item(client, 100, { name = "Sword" })
	-- not the master looter nor an officer, or no roll in it
	say("CHAT_MSG_RAID", "roll for " .. sword .. " pls", "Someone")
	say("CHAT_MSG_RAID", "Nice " .. sword, "Loot")
	lu.assertEquals(#rows(), 0)

	boot({ DiabolicUI_DB = { LootFrame = { profiles = { global = { rollWindow = false } } } } })
	say("CHAT_MSG_RAID", "Roll for " .. Session.item(client, 100, { name = "Sword" }), "Loot")
	lu.assertEquals(#rows(), 0)
	lu.assertNil(_G.DiabolicRollFrame)
	Session.assertClean(client)
end

os.exit(lu.LuaUnit.run())
