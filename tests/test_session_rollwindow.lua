-- Run from the addon root: lua5.1 tests/test_session_rollwindow.lua
--
-- modules/blizzard/rollwindow.lua in the fake client: a raid's master
-- looter, leader or raid warning puts items up for a roll in the chat, the
-- window shows each with its time left and the Main Spec (/roll 100) and
-- Off Spec (/roll 99) buttons, then your roll, and lets the item go once
-- it's won or the time is up. Others' messages, and the option off (its
-- default, until tried in a raid), show nothing.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local client, module

local ON = { DiabolicUI_DB = { LootFrame = { profiles = { global = { rollWindow = true } } } } }

-- a raid: you, its leader, and Loot, the master looter; the option on
-- unless `savedVariables` say otherwise
local function boot(savedVariables)
	client = Client.boot({ savedVariables = savedVariables or ON })
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
	_G.BisTooltipAddon, _G.BisTooltip_PhaseData = nil, nil
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

function TestRollWindow:test_passing_rolls_nothing()
	boot()
	local sword = Session.item(client, 100, { name = "Sword" })
	say("CHAT_MSG_RAID", "Roll for " .. sword, "Loot")
	local row = rows()[1]
	row.Pass:Click()
	lu.assertNil(client.rolls)
	lu.assertNil(row.MainSpec:IsShown())
	lu.assertEquals(row.Result:GetText(), "You passed")
	-- a roll of yours for something else doesn't land on it
	say("CHAT_MSG_SYSTEM", client.world.units.player.name .. " rolls 87 (1-100)")
	lu.assertEquals(row.Result:GetText(), "You passed")
	-- put up again: the buttons are back
	say("CHAT_MSG_RAID", "Someone wins " .. sword, "Loot")
	say("CHAT_MSG_RAID", "Roll for " .. sword, "Loot")
	lu.assertEquals(rows()[1].Pass:IsShown(), 1)
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

	-- off by default
	boot({})
	say("CHAT_MSG_RAID", "Roll for " .. Session.item(client, 100, { name = "Sword" }), "Loot")
	lu.assertEquals(#rows(), 0)
	lu.assertNil(_G.DiabolicRollFrame)
	Session.assertClean(client)
end

function TestRollWindow:test_in_a_party_the_master_looter_is_you_or_a_member()
	client = Client.boot({ savedVariables = ON })
	client.world.units.party1 = Client.newUnit({ name = "Loot" })
	module = client:GetModule("Blizzard: RollWindow")
	client:Tick(0.2)
	-- a member
	client.world.lootMethod = { "master", 1 }
	say("CHAT_MSG_PARTY", "roll " .. Session.item(client, 100, { name = "Sword" }), "Loot")
	lu.assertEquals(#rows(), 1)
	-- you
	client.world.lootMethod = { "master", 0 }
	say("CHAT_MSG_PARTY", "roll " .. Session.item(client, 101, { name = "Ring" }), client.world.units.player.name)
	lu.assertEquals(#rows(), 2)
	-- no master looter: a member's message is just chat
	client.world.lootMethod = { "group" }
	say("CHAT_MSG_PARTY", "roll " .. Session.item(client, 102, { name = "Cloak" }), "Loot")
	lu.assertEquals(#rows(), 2)
	Session.assertClean(client)
end

function TestRollWindow:test_hovering_the_item_shows_its_tooltip()
	boot()
	local sword = Session.item(client, 100, { name = "Sword" })
	say("CHAT_MSG_RAID", "Roll for " .. sword, "Loot")
	client:Hover(rows()[1].Icon:GetParent())
	lu.assertEquals(_G.GameTooltip:IsShown(), 1)
	lu.assertEquals(select(2, _G.GameTooltip:GetItem()), sword)
	client:Leave()
	lu.assertNil(_G.GameTooltip:IsShown())
	Session.assertClean(client)
end

-- BiS-Tooltip Renewed's lookup, as its BuildReverseLookup makes it
local function bisTooltip(phaseIndex)
	_G.BisTooltip_PhaseData = { "PR", "T7", "T8", "T9", "T10", "RS" }
	_G.BisTooltipAddon = { db = { char = { phase_index = phaseIndex } }, ReverseLookup = {
		[100] = {
			{ class = "Mage", spec = "Fire", rightText = "T9 BIS" },
			{ class = "Priest", spec = "Holy", rightText = "T8 alt 1 / T9 BIS" },
			{ class = "Priest", spec = "Shadow", rightText = "T9 alt 2" },
		},
		[101] = { { class = "Priest", spec = "Holy", rightText = "T7 BIS" } },
	} }
end

function TestRollWindow:test_bis_tooltips_ranks_for_your_specs_in_its_phase()
	client = Client.boot({ class = "PRIEST", savedVariables = ON })
	bisTooltip(4) -- T9
	client.world.units.raid1 = Client.newUnit({ name = "Loot", rank = 2 })
	module = client:GetModule("Blizzard: RollWindow")
	client:Tick(0.2)
	say("CHAT_MSG_RAID", "Roll " .. Session.item(client, 100, { name = "Sword" }) .. " " .. Session.item(client, 101, { name = "Ring" }), "Loot")
	lu.assertEquals(rows()[1].Bis:GetText(), "T9: Holy BIS, Shadow alt 2")
	-- not in this phase: no line
	lu.assertEquals(rows()[2].Bis:GetText(), "")
	-- a taller window for the line
	local tall = _G.DiabolicRollFrame:GetHeight()
	_G.BisTooltipAddon, _G.BisTooltip_PhaseData = nil, nil
	module:Layout()
	lu.assertTrue(_G.DiabolicRollFrame:GetHeight() < tall)
	Session.assertClean(client)
end

function TestRollWindow:test_no_line_without_bis_tooltip()
	boot()
	say("CHAT_MSG_RAID", "Roll for " .. Session.item(client, 100, { name = "Sword" }), "Loot")
	lu.assertEquals(rows()[1].Bis:GetText(), "")
	Session.assertClean(client)
end

-- The loot coming up (lootpreview.lua) -------------------------------------

local function preview()
	return client:GetModule("Blizzard: LootPreview")
end

-- the list's item names, the rolled one marked with a *
local function listed()
	local names = {}
	for i, item in ipairs(preview().items) do
		local row = preview().rows[i]
		names[i] = row.Name:GetText():match("%[(.-)%]") .. (row.Rolling:IsShown() and "*" or "")
	end
	return names
end

function TestRollWindow:test_raid_loot_suites_list_and_the_rolls_going_through_it()
	boot()
	local sword = Session.item(client, 100, { name = "Sword", texture = "Interface\\Icons\\Sword" })
	local ring = Session.item(client, 101, { name = "Ring" })
	say("CHAT_MSG_RAID", "Loot from Marrowgar: " .. sword .. " " .. ring .. " ", "Loot")
	-- the long ones go on in a second line
	say("CHAT_MSG_RAID", "Loot from Marrowgar: " .. Session.item(client, 102, { name = "Cloak" }), "Loot")
	lu.assertEquals(listed(), { "Sword", "Ring", "Cloak" })
	lu.assertEquals(_G.DiabolicLootPreviewFrame:IsShown(), 1)
	lu.assertEquals(preview().title:GetText(), "Marrowgar")
	lu.assertEquals(preview().rows[1].Icon:GetTexture(), "Interface\\Icons\\Sword")
	-- rolled: marked, then gone once won
	say("CHAT_MSG_RAID_WARNING", "Roll for " .. ring, "Boss")
	lu.assertEquals(listed(), { "Sword", "Ring*", "Cloak" })
	say("CHAT_MSG_RAID", "Someone wins " .. ring, "Loot")
	lu.assertEquals(listed(), { "Sword", "Cloak" })
	-- hovering shows the item
	client:Hover(preview().rows[1])
	lu.assertEquals(select(2, _G.GameTooltip:GetItem()), sword)
	client:Leave()
	-- the next boss: a new list
	client:Tick(20)
	say("CHAT_MSG_RAID", "Loot from Deathwhisper: " .. ring, "Loot")
	lu.assertEquals(listed(), { "Ring" })
	-- closed: emptied
	client:Click(preview().close)
	lu.assertEquals(#preview().items, 0)
	lu.assertNil(_G.DiabolicLootPreviewFrame:IsShown())
	Session.assertClean(client)
end

function TestRollWindow:test_an_item_not_seen_yet_gets_its_icon_later_in_the_list()
	boot()
	local link = "|cffa335ee|Hitem:200:0:0:0:0:0:0:0:80|h[Unknown Helm]|h|r"
	say("CHAT_MSG_RAID", "Loot from Marrowgar: " .. link, "Loot")
	local row = preview().rows[1]
	lu.assertEquals(row.Icon:GetTexture(), "Interface\\Icons\\INV_Misc_QuestionMark")
	client.world.itemInfo[200] = { name = "Unknown Helm", texture = "Interface\\Icons\\Helm" }
	client:Tick(0.6)
	lu.assertEquals(row.Icon:GetTexture(), "Interface\\Icons\\Helm")
	Session.assertClean(client)
end

function TestRollWindow:test_the_fake_loot_roll()
	boot()
	client.world.lootMethod = nil -- solo: no master looter
	preview():ShowFakeRoll()
	lu.assertEquals(preview().title:GetText(), "Fake Boss")
	lu.assertEquals(listed(), { "Thunderfury, Blessed Blade of the Windseeker*", "Wirt's Third Leg" })
	lu.assertEquals(#rows(), 1)
	rows()[1].MainSpec:Click()
	lu.assertEquals(client.rolls, { { 1, 100 } })
	client:Tick(21)
	lu.assertEquals(#rows(), 0)
	lu.assertEquals(listed(), { "Wirt's Third Leg" })
	Session.assertClean(client)
end

function TestRollWindow:test_rollfors_numbered_list()
	boot()
	local sword = Session.item(client, 100, { name = "Sword" })
	say("CHAT_MSG_RAID_WARNING", "Marrowgar dropped 3 items:", "Boss")
	say("CHAT_MSG_RAID_WARNING", "1. " .. sword .. " (SR by Someone)", "Boss")
	say("CHAT_MSG_RAID_WARNING", "2. 2x" .. Session.item(client, 101, { name = "Ring" }), "Boss")
	lu.assertEquals(listed(), { "Sword", "Ring", "Ring" })
	lu.assertEquals(preview().title:GetText(), "Marrowgar")
	-- a chest: no name
	client:Tick(20)
	say("CHAT_MSG_RAID_WARNING", "1 item dropped:", "Boss")
	say("CHAT_MSG_RAID_WARNING", "1. " .. sword, "Boss")
	lu.assertEquals(listed(), { "Sword" })
	lu.assertEquals(preview().title:GetText(), "Coming Up")
	-- a numbered line long after: just chat
	client:Tick(20)
	say("CHAT_MSG_RAID_WARNING", "2. " .. sword, "Boss")
	lu.assertEquals(#listed(), 1)
	Session.assertClean(client)
end

function TestRollWindow:test_others_lists_and_the_option_off_show_nothing()
	boot()
	say("CHAT_MSG_RAID", "Loot from Marrowgar: " .. Session.item(client, 100, { name = "Sword" }), "Someone")
	lu.assertEquals(#preview().items, 0)
	lu.assertNil(_G.DiabolicLootPreviewFrame:IsShown())
	boot({})
	say("CHAT_MSG_RAID", "Loot from Marrowgar: " .. Session.item(client, 100, { name = "Sword" }), "Loot")
	lu.assertNil(_G.DiabolicLootPreviewFrame)
	Session.assertClean(client)
end

function TestRollWindow:test_what_you_see_opening_the_boss_goes_to_the_raid()
	boot()
	local sword = Session.item(client, 100, { name = "Sword", quality = 4 })
	local ring = Session.item(client, 101, { name = "Ring", quality = 4 })
	client.world.loot = {
		{ name = "Sword", quality = 4, link = sword },
		{ name = "Gold", quality = 0, isCoin = true },
		{ name = "Bone", quality = 1, link = Session.item(client, 102, { name = "Bone", quality = 1 }) },
		{ name = "Ring", quality = 4, link = ring },
	}
	client:SetUnit("target", Client.newUnit({ name = "Marrowgar", guid = "0xF130009069000001", dead = true, isPlayer = false }))
	client:FireEvent("LOOT_OPENED")
	-- what the master looter can give, one message each
	lu.assertEquals(client.addonMessages, {
		{ "DiabolicUI", "0xF130009069000001~Marrowgar~1~" .. sword, "RAID" },
		{ "DiabolicUI", "0xF130009069000001~Marrowgar~4~" .. ring, "RAID" },
	})
	-- back from the server: listed, once even if someone else opens it too
	for _ = 1, 2 do
		for _, sent in ipairs(client.addonMessages) do
			client:FireEvent("CHAT_MSG_ADDON", sent[1], sent[2], "RAID", "Someone")
		end
	end
	lu.assertEquals(listed(), { "Sword", "Ring" })
	lu.assertEquals(preview().title:GetText(), "Marrowgar")
	-- Raid Loot Suite's line for it adds nothing
	say("CHAT_MSG_RAID", "Loot from Marrowgar: " .. sword .. " " .. ring, "Loot")
	lu.assertEquals(listed(), { "Sword", "Ring" })
	-- others' messages, and not under master loot: nothing
	client:FireEvent("CHAT_MSG_ADDON", "Other", "x", "RAID", "Someone")
	client:FireEvent("CHAT_MSG_ADDON", "DiabolicUI", "garbage", "RAID", "Someone")
	lu.assertEquals(#listed(), 2)
	client.addonMessages = nil
	client.world.lootMethod = { "group" }
	client:FireEvent("LOOT_OPENED")
	lu.assertNil(client.addonMessages)
	Session.assertClean(client)
end

os.exit(lu.LuaUnit.run())
