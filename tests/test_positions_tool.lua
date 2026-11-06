-- tools/positions.lua: windows/*.qml written from what /dui layout saw and read
-- back (their pins, notes, anchors), settings/positions.lua and the editor's
-- tools/layout.json written from them.
package.path = "tests/?.lua;" .. package.path
local lu = require("luaunit")

local LUA = os.getenv("LUA") or "lua5.1"

-- A temporary file name in $TMPDIR (os.tmpname() always uses /tmp, which a
-- sandbox may not let us write).
local TempName = function()
	return (os.getenv("TMPDIR") or "/tmp") .. "/diabolicui_test_" .. os.time() .. "_" .. math.random(1e9)
end

local Write = function(path, text)
	local file = assert(io.open(path, "w"))
	file:write(text)
	file:close()
end

local Read = function(path)
	local file = assert(io.open(path))
	local text = file:read("*a")
	file:close()
	return text
end

local pipe = io.popen("pwd")
local ROOT = pipe:read("*l")
pipe:close()

-- Runs tools/positions.lua with `args` (paths) from `dir` (the addon's
-- folder by default), what it says returned; its lines recorded when the
-- coverage runs (tests/coverage/run.sh), into a file of its own there.
local Run = function(args, dir)
	local quoted = {}
	for i, path in ipairs(args) do
		quoted[i] = string.format("%q", path)
	end
	local code = string.format('arg = { [0] = "tools/positions.lua", %s }; '
		.. 'local file = assert(io.open(%q)); local chunk = assert(loadstring(file:read("*a"), "@tools/positions.lua")); '
		.. 'file:close(); chunk()', table.concat(quoted, ", "), ROOT .. "/tools/positions.lua")
	local env = ""
	local stats = os.getenv("DIABOLICUI_COVERAGE_STATS")
	if stats then
		stats = (stats:sub(1, 1) == "/") and stats or (ROOT .. "/" .. stats)
		code = string.format("dofile(%q); ", ROOT .. "/tests/coverage/hook.lua") .. code .. "; os.exit(0)"
		env = "DIABOLICUI_COVERAGE_STATS=" .. stats:gsub("%.out$", "") .. ".tool.out "
	end
	local run = io.popen("cd '" .. (dir or ROOT) .. "' && " .. env .. LUA .. " -e '" .. code .. "' 2>&1")
	local said = run:read("*a")
	run:close()
	return said
end

TestPositionsTool = {}

-- A folder for a run: the saved variables, what's written.
local Folder = function()
	local dir = TempName()
	os.execute("mkdir -p '" .. dir .. "/windows'")
	return dir
end

local Runs = function(dir, edits)
	return Run({ dir .. "/saved.lua", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows", edits })
end

local PositionsOf = function(dir)
	local positions
	assert(loadstring(Read(dir .. "/positions.lua")))("DiabolicUI", { NewStaticConfig = function(_, _, t) positions = t end })
	return positions
end

local SCAN = [[
DiabolicUI_Layout = {
	["windows"] = {
		["FriendsFrame"] = { ["parts"] = {
			["WhoFrame"] = { "TOPLEFT", "FriendsFrame", "TOPLEFT", 10, -20, 300, 400, kind = "Frame", rect = { 20, 112, 300, 400 } },
			["WhoFrameEditBox"] = { "BOTTOM", "WhoFrame", "BOTTOM", -20, 100, 296, 32, kind = "EditBox",
				points = { { "BOTTOM", "WhoFrame", "BOTTOM", -20, 100 } }, parent = "WhoFrame", rect = { 50, 100, 296, 32 },
				strata = "MEDIUM", level = 3, tabs = { FriendsFrameTab2 = true }, control = true },
			["WhoFrameTotals"] = { "LEFT", "WhoFrame", "LEFT", 4.5, 0, kind = "FontString", text = "738 \"People\"" },
			["Odd-Name"] = { "TOP", "WhoFrame", "TOP", 0, 0, 10, 10, kind = "Frame" },
			["WhoFrameOld"] = "an older scan's line",
			-- (one placed by several points: the place keeping it where it is)
			["WhoFrameBar"] = { "TOP", "WhoFrame", "TOP", 0, 0, 5, 5, kind = "Frame", rect = { 30, 490, 300, 12 },
				points = { { "TOP", "WhoFrame", "TOP", 0, 0 }, { "LEFT", nil, "LEFT", 0, 0 } }, parent = "WhoFrame" },
			-- (placed on what's in no part of it: a Ghost, seen from each side)
			["OnLeft"] = { "LEFT", "Elsewhere", "LEFT", 1, 2, 10, 10, kind = "Frame", rect = { 100, 200, 10, 10 } },
			["OnCentre"] = { "CENTER", "Elsewhere", "CENTER", 0, 0, 10, 10, kind = "Frame", rect = { 145, 195, 10, 10 } },
			["OnBottom"] = { "TOP", "Below", "BOTTOM", 0, 0, 10, 10, kind = "Frame", rect = { 100, 300, 10, 10 } },
			["OnRight"] = { "RIGHT", "Beside", "RIGHT", 0, 0, 10, 10, kind = "Frame", rect = { 100, 300, 10, 10 } },
			["OnUnseen"] = { "TOP", "Unseen", "TOP", 0, 0, 10, 10, kind = "Frame" },
			-- (reserved words, names taken)
			["Name"] = { "TOP", "FriendsFrame", "TOP", 0, 0, 1, 1, kind = "Frame" },
			["name"] = { "TOP", "FriendsFrame", "TOP", 0, 0, 1, 1, kind = "Frame" },
			["1st"] = { "TOP", "FriendsFrame", "TOP", 0, 0, 1, 1, kind = "Frame" },
		}, ["rect"] = { 10, 112, 384, 500 }, ["window"] = { 0, 100, 400, 520 }, ["checked"] = "today",
			["views"] = {
				["FriendsFrameTab2"] = { label = "Who", rect = { 10, 112, 384, 500 }, window = { 0, 100, 400, 520 }, art = {} },
				["FriendsFrameTab1"] = { label = "Friends", art = {} },
			} },
		["AuctionFrame"] = { ["parts"] = {
			["WhoFrameTotals"] = { "TOP", "AuctionFrame", "TOP", 0, 0, kind = "FontString", text = "Seen \"first\"" },
		} },
	},
}
]]

local LINES = [[
local _, Engine = ...
Engine:NewStaticConfig("Positions", {
	-- why it's there,
	-- on two lines
	WhoFrameTotals = { "LEFT", "WhoFrame", "LEFT", 8, 0 }, -- (a note at its end)
	OnLeft = { "LEFT", "Elsewhere", "LEFT", 1, 2, 10, 10 }, -- Frame
	GoneFrame = { "TOP", "UIParent", "TOP", 0, -10, 50, 20 },

	-- DressUpFrame -------------------------------------------------------
	-- OldLine = { "TOP", "UIParent", "TOP", 0, 0 },
	-- a size only
	SizedFrame = { 10, 20 },

	-- Not seen by /dui layout --------------------------------------------
	PlaceOnly = { "TOP", "UIParent", "TOP", 0, 0 },
})
]]

-- The first run: the files written from the scan and settings/positions.lua's
-- lines, with their notes.
function TestPositionsTool:test_the_windows_written_from_the_scan_and_the_lines()
	local dir = Folder()
	Write(dir .. "/saved.lua", SCAN)
	Write(dir .. "/positions.lua", LINES)
	local said = Runs(dir)
	lu.assertStrContains(said, "16 parts, 5 in use.")
	local friends = Read(dir .. "/windows/FriendsFrame.qml")
	local notSeen = Read(dir .. "/windows/NotSeen.qml")
	local dressUp = Read(dir .. "/windows/DressUpFrame.qml")
	local auction = Read(dir .. "/windows/AuctionFrame.qml")
	local text = Read(dir .. "/positions.lua")
	local positions = PositionsOf(dir)
	local exported = Read(dir .. "/layout.json")
	-- a part: its anchors for its point, y and margins the other way round
	lu.assertStrContains(friends, [[
    Part {
        id: whoFrameEditBox
        name: "WhoFrameEditBox"
        kind: "EditBox"
        wowParent: "WhoFrame"
        anchors.horizontalCenter: whoFrame.horizontalCenter
        anchors.horizontalCenterOffset: -20
        anchors.bottom: whoFrame.bottom
        anchors.bottomMargin: 100
        width: 296
        height: 32
    }
]])
	lu.assertStrContains(friends, "    id: friendsFrame\n    name: \"FriendsFrame\"\n    width: 384\n    height: 500\n")
	lu.assertStrContains(friends, 'anchors.left: friendsFrame.left\n        anchors.leftMargin: 10\n        anchors.top: friendsFrame.top\n        anchors.topMargin: 20')
	-- the scan's rect for a text's box, the first window seen keeps a part
	lu.assertStrContains(friends, 'id: odd_Name')
	lu.assertStrContains(friends, 'id: name_\n')
	lu.assertStrContains(friends, 'id: _1st\n')
	-- its notes over it, the note at its end after it; on another window, kept
	lu.assertStrContains(auction, '    // why it\'s there,\n    // on two lines\n    Part {\n        id: whoFrameTotals')
	lu.assertStrContains(auction, '        width: 72\n        height: 12\n    } // (a note at its end)')
	lu.assertStrContains(auction, 'text: "Seen \\"first\\""')
	-- several points: the place that keeps it where it is, its rect's size
	lu.assertStrContains(friends, 'name: "WhoFrameBar"\n        kind: "Frame"\n        wowParent: "WhoFrame"\n'
		.. '        anchors.horizontalCenter: whoFrame.horizontalCenter\n        anchors.horizontalCenterOffset: 10\n        anchors.top: whoFrame.top\n        anchors.topMargin: 10\n        width: 300\n        height: 12')
	-- what's not in it stands in as a Ghost, where what's on it says
	lu.assertStrContains(friends, 'Ghost { id: elsewhere; name: "Elsewhere"; x: 89; y: 409; width: 102; height: 0 }')
	lu.assertStrContains(friends, 'Ghost { id: below; name: "Below"; x: 95; y: 302; width: 0; height: 0 }')
	lu.assertStrContains(friends, 'Ghost { id: beside; name: "Beside"; x: 100; y: 307; width: 0; height: 0 }')
	lu.assertStrContains(friends, 'Ghost { id: unseen; name: "Unseen"; x: 0; y: 0; width: 0; height: 0 }')
	-- in use in a window no scan saw, or none: kept, a size alone without anchors
	lu.assertStrContains(dressUp, '    // a size only\n    Part {\n        id: sizedFrame\n        name: "SizedFrame"\n        pin: "size"\n        width: 10\n        height: 20')
	lu.assertStrContains(notSeen, 'name: "GoneFrame"\n        pin: "all"')
	lu.assertStrContains(notSeen, 'name: "PlaceOnly"\n        pin: "place"')
	lu.assertNil(friends:find("WhoFrameOld", 1, true))
	lu.assertNil(friends:find("OldLine", 1, true))
	-- settings/positions.lua: the pinned ones, by window, their notes kept
	lu.assertStrContains(text, "\t-- AuctionFrame ---")
	lu.assertStrContains(text, "\t-- why it's there,\n\t-- on two lines\n"
		.. '\tWhoFrameTotals = { "LEFT", "WhoFrame", "LEFT", 8, 0 }, -- (a note at its end)')
	lu.assertStrContains(text, '\tOnLeft = { "LEFT", "Elsewhere", "LEFT", 1, 2, 10, 10 }, -- Frame')
	lu.assertStrContains(text, "\t-- a size only\n\tSizedFrame = { 10, 20 },")
	lu.assertStrContains(text, "-- Not seen by /dui layout")
	lu.assertNil(positions.WhoFrameEditBox)
	lu.assertNil(positions["Odd-Name"])
	lu.assertNil(positions.WhoFrame)
	-- for the editor: the parts, their pins, where they were, their tabs, the views
	lu.assertStrContains(exported, '"WhoFrameEditBox":{"control":true,"kind":"EditBox","level":3,"parent":"WhoFrame",'
		.. '"place":["BOTTOM","WhoFrame","BOTTOM",-20,100],"points":[["BOTTOM","WhoFrame","BOTTOM",-20,100]],'
		.. '"rect":[50,100,296,32],"size":[296,32],"strata":"MEDIUM","tabs":["FriendsFrameTab2"]}')
	lu.assertStrContains(exported, '"points":[["TOP","WhoFrame","TOP",0,0],["LEFT","WhoFrame","LEFT",0,0]]')
	lu.assertStrContains(exported, '"views":[{"key":"FriendsFrameTab1","label":"Friends"},{"key":"FriendsFrameTab2","label":"Who","rect":[10,112,384,500],"window":[0,100,400,520]}]')
	lu.assertStrContains(exported, '"file":"' .. dir .. '/windows/FriendsFrame.qml"')
	os.execute("rm -rf '" .. dir .. "'")
end

-- The files then come first: run again they're the same; changed by hand,
-- what's read goes in settings/positions.lua; a pin gone, the scan's back.
function TestPositionsTool:test_the_windows_read_back()
	local dir = Folder()
	Write(dir .. "/saved.lua", SCAN)
	Write(dir .. "/positions.lua", LINES)
	Runs(dir)
	local first, lines = Read(dir .. "/windows/FriendsFrame.qml"), Read(dir .. "/positions.lua")
	Runs(dir)
	lu.assertEquals(Read(dir .. "/windows/FriendsFrame.qml"), first)
	lu.assertEquals(Read(dir .. "/positions.lua"), lines)
	-- pinned by hand, a text kept with its own size; comments dropped inside a
	-- block, a statement after another on a line; let go by hand
	local text = first:gsub('name: "Odd%-Name"\n', 'name: "Odd-Name"; pin: "all" // a comment\n'):gsub("    } // nothing", "")
	text = text:gsub('name: "OnLeft"\n(.-)pin: "all"\n', 'name: "OnLeft"\n%1')
	Write(dir .. "/windows/FriendsFrame.qml", text)
	Write(dir .. "/saved.lua", 'DiabolicUI_Layout = { windows = { FriendsFrame = { parts = { OnLeft = { "LEFT", "Elsewhere", "LEFT", 7, 7, 10, 10, kind = "Frame" } } } } }')
	Runs(dir)
	local positions = PositionsOf(dir)
	lu.assertEquals(positions["Odd-Name"], { "TOP", "WhoFrame", "TOP", 0, 0, 10, 10 })
	lu.assertNil(positions.OnLeft)
	lu.assertStrContains(Read(dir .. "/windows/FriendsFrame.qml"), 'anchors.left: elsewhere.left\n        anchors.leftMargin: 7\n')
	-- the editor's changes; a part gone from every file: nothing
	Write(dir .. "/edits.lua", [[return {
		WhoFrame = { place = { "TOP", "FriendsFrame", "TOP", 3, 4 }, size = { 30, 40 }, pin = "all" },
		["Odd-Name"] = { pin = "" },
		Nothing = { pin = "" },
	}]])
	Runs(dir, dir .. "/edits.lua")
	positions = PositionsOf(dir)
	lu.assertEquals(positions.WhoFrame, { "TOP", "FriendsFrame", "TOP", 3, 4, 30, 40 })
	lu.assertNil(positions["Odd-Name"])
	-- without a scan: as they are, and how big a window is from its file
	local said = Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	lu.assertStrContains(said, "in use.")
	lu.assertEquals(PositionsOf(dir).WhoFrame, { "TOP", "FriendsFrame", "TOP", 3, 4, 30, 40 })
	lu.assertStrContains(Read(dir .. "/windows/FriendsFrame.qml"), "    width: 384\n    height: 500\n")
	os.execute("rm -rf '" .. dir .. "'")
end

-- A window never scanned, none of its size in its file: as far as what's
-- placed from its top left goes; the types themselves aren't windows.
function TestPositionsTool:test_a_window_from_its_parts()
	local dir = Folder()
	Write(dir .. "/windows/Part.qml", "import QtQuick\nItem {}\n")
	Write(dir .. "/windows/Ghost.qml", "import QtQuick\nItem {}\n")
	Write(dir .. "/windows/WowWindow.qml", "import QtQuick\nItem {}\n")
	Write(dir .. "/windows/Mine.qml", [[
// a comment on the file
import QtQuick
WowWindow {
    id: mine
    name: "Mine"
    // over a part
    Part { id: far; name: "Far"; pin: "all"; anchors.left: mine.left; anchors.leftMargin: 500; anchors.top: mine.top; anchors.topMargin: 600; width: 10; height: 20 }
    Part {
        name: "NoId"
        anchors.right: far.right
        anchors.verticalCenter: far.verticalCenter
        anchors.verticalCenterOffset: 3
        anchors.rightMargin: 2
        width: 1; height: 2
    }
    Part { name: "Word"; kind: "FontString"; text: "a \\ \"text\""; anchors.horizontalCenter: mine.horizontalCenter; anchors.bottom: mine.bottom }
    Part { name: "Open"; pin: "size"; width: 4; height: 5 }
    Ghost { id: extra; name: "Extra"; x: 1; y: 2 }
}
]])
	Write(dir .. "/saved.lua", "OtherThing = 1")
	lu.assertStrContains(Runs(dir), "4 parts, 2 in use.")
	local text = Read(dir .. "/windows/Mine.qml")
	lu.assertStrContains(text, '    id: mine\n    name: "Mine"\n    width: 510\n    height: 620\n')
	lu.assertStrContains(text, '    // over a part\n    Part {\n        id: far')
	lu.assertStrContains(text, 'name: "NoId"\n        anchors.right: far.right\n        anchors.rightMargin: 2\n        anchors.verticalCenter: far.verticalCenter\n        anchors.verticalCenterOffset: 3\n')
	lu.assertStrContains(text, 'text: "a \\\\ \\"text\\""\n        anchors.horizontalCenter: mine.horizontalCenter\n        anchors.bottom: mine.bottom\n')
	lu.assertEquals(PositionsOf(dir).Open, { 4, 5 })
	os.execute("rm -rf '" .. dir .. "'")
end

-- What can't be read is said, naming it, and nothing's written.
function TestPositionsTool:test_what_cant_be_read()
	local cases = {
		{ "Rectangle {\n}\n", "only a WowWindow" },
		{ 'WowWindow {\n name: "W"\n Rectangle {\n }\n}\n', "only a WowWindow" },
		{ 'WowWindow {\n name: "W"\n Part {\n Item {\n }\n }\n}\n', "only a WowWindow" },
		{ 'WowWindow {\n name: "W"\n Part {\n id: a\n }\n}\n', "a part needs a name" },
		{ 'WowWindow {\n name: "W"\n Part {\n }\n}\n', "a part needs a name" },
		{ 'WowWindow {\n name: W\n}\n', "needs a text" },
		{ 'WowWindow {\n width: 3 + 4\n}\n', "needs a number" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n anchors.leftMargin: 1 + 2\n }\n}\n', "needs a number" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n anchors.left: w\n }\n}\n', "needs a part and its line" },
		{ 'WowWindow {\n id: w\n name: "W"\n Part {\n name: "P"\n anchors.left: w.left\n anchors.right: w.right\n }\n}\n', "one anchor across" },
		{ 'WowWindow {\n id: w\n name: "W"\n Part {\n name: "P"\n anchors.left: w.left\n }\n}\n', "one anchor across and one down" },
		{ 'WowWindow {\n id: w\n name: "W"\n Part {\n name: "P"\n anchors.left: w.left\n anchors.top: x.top\n }\n}\n', "one anchor across and one down" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n anchors.left: x.left\n anchors.top: x.top\n }\n}\n', "one anchor across and one down" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n anchors.fill: parent\n }\n}\n', "can't be read" },
		{ 'WowWindow {\n name: "W"\n onClicked: a()\n}\n', "can't be read" },
		{ 'WowWindow {\n name: "W"\n a b c\n}\n', "not a property" },
		{ 'WowWindow {\n id: w\n}\n', "a window needs a name" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n pin: "some"\n }\n}\n', "its pin is" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n pin: "place"\n }\n}\n', "its pin needs anchors" },
		{ 'WowWindow {\n name: "W"\n Part {\n name: "P"\n pin: "size"\n }\n}\n', "its pin needs a width" },
	}
	for _, case in ipairs(cases) do
		local dir = Folder()
		Write(dir .. "/windows/W.qml", case[1])
		Write(dir .. "/positions.lua", "-- as it was")
		local said = Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
		lu.assertStrContains(said, "W.qml")
		lu.assertStrContains(said, case[2])
		lu.assertEquals(Read(dir .. "/positions.lua"), "-- as it was")
		os.execute("rm -rf '" .. dir .. "'")
	end
end

-- What's in the repository agrees: settings/positions.lua is what
-- windows/*.qml say, and they stay as they are when read and written back.
function TestPositionsTool:test_the_files_agree()
	local dir = Folder()
	os.execute("cp '" .. ROOT .. "'/windows/*.qml '" .. dir .. "/windows/'")
	Write(dir .. "/positions.lua", "")
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	local written = Read(dir .. "/positions.lua")
	local same = os.execute("diff -r '" .. ROOT .. "/windows' '" .. dir .. "/windows' >/dev/null")
	os.execute("rm -rf '" .. dir .. "'")
	lu.assertEquals(written, Read(ROOT .. "/settings/positions.lua"))
	lu.assertEquals(same, 0)
end

-- Without paths: the newest saved variables, three folders up (the game's
-- WTF), into settings/positions.lua (not there yet).
function TestPositionsTool:test_the_newest_saved_variables_by_default()
	local base = TempName()
	local addon = base .. "/Interface/AddOns/DiabolicUI"
	os.execute("mkdir -p '" .. addon .. "/settings' '" .. addon .. "/tools' '" .. base .. "/WTF/Account/ME/SavedVariables'")
	Write(base .. "/WTF/Account/ME/SavedVariables/DiabolicUI.lua", [[
DiabolicUI_Layout = { ["windows"] = { ["BankFrame"] = { ["parts"] = {
	["BankCloseButton"] = { "TOPRIGHT", "BankFrame", "TOPRIGHT", -46, -8, 32, 32, kind = "Button" },
} } } }
]])
	local said = Run({}, addon)
	lu.assertStrContains(said, "settings/positions.lua: 1 parts, 0 in use.")
	local window = Read(addon .. "/windows/BankFrame.qml")
	lu.assertStrContains(Read(addon .. "/tools/layout.json"), '"BankCloseButton":{"kind":"Button"')
	os.execute("rm -rf '" .. base .. "'")
	lu.assertStrContains(window, 'anchors.right: bankFrame.right\n        anchors.rightMargin: 46\n        anchors.top: bankFrame.top\n        anchors.topMargin: 8\n        width: 32')
end

-- A .tga `width` wide, one high: its header (raw or packed, its bits, its
-- first row the top one or not), then its pixels.
local Tga = function(kind, bits, top, width, pixels)
	return string.char(0, 0, kind, 0, 0, 0, 0, 0, 0, 0, 0, 0, width, 0, 1, 0, bits, top and 32 or 0) .. pixels
end

-- Our art for the editor: its files as .bmp pictures (in tools/art/, each
-- made once), white ones said white, the ones not found or not read left out.
function TestPositionsTool:test_our_art_as_pictures_a_browser_reads()
	local addon = TempName()
	os.execute("mkdir -p '" .. addon .. "/media/textures' '" .. addon .. "/tools'")
	Write(addon .. "/media/textures/Raw32.tga", Tga(2, 32, false, 2, "\1\2\3\4\5\6\7\8"))
	Write(addon .. "/media/textures/Raw24.tga", Tga(2, 24, true, 2, "\1\2\3\4\5\6"))
	Write(addon .. "/media/textures/Packed.tga", Tga(10, 32, false, 3, "\128\9\9\9\9" .. "\1\1\2\3\4\5\6\7\8"))
	Write(addon .. "/media/textures/Mapped.tga", Tga(1, 8, false, 1, "\0"))
	local ours = [[Interface\\AddOns\\DiabolicUI\\media\\textures\\]]
	local item = function(file) return string.format('{ file = "%s", rect = { 0, 0, 2, 1 }, coords = { 0, 0, 0, 1, .125, 0, .125, 1 }, color = { 1, 1, 1, 1 }, alpha = 1, owner = "W" },', file) end
	-- (a part's second point on nothing: on its parent)
	Write(addon .. "/saved.lua", "DiabolicUI_Layout = { windows = { W = { parts = { P = { 'TOP', 'W', 'TOP', 0, 0, 1, 1, kind = 'Frame', parent = 'W',"
		.. " points = { { 'TOP', 'W', 'TOP', 0, 0 }, { 'CENTER', nil, 'CENTER', 0, 0 } } } }, art = {\n"
		.. item(ours .. "Raw32") .. item(ours .. "raw24.TGA") .. item(ours .. "Packed") .. item(ours .. "Raw32")
		.. item(ours .. "Mapped") .. item(ours .. "Missing") .. item([[Interface\\Buttons\\WHITE8X8]]) .. item([[Interface\\Icons\\INV_Sword.blp]])
		.. '{ backdrop = { bgFile = [[Interface\\ChatFrame\\ChatFrameBackground]], edgeFile = "' .. ours .. 'Packed", edgeSize = 32, tile = true, insets = { 1, 2, 3, 4 } }, rect = { 0, 0, 9, 9 }, scale = 1 },'
		.. '{ backdrop = { edgeFile = "' .. ours .. 'Missing" }, rect = { 0, 0, 9, 9 } },'
		.. "} } } }")
	Run({ addon .. "/saved.lua", addon .. "/positions.lua", addon .. "/tools/layout.json", addon .. "/windows" }, addon)
	local json = Read(addon .. "/tools/layout.json")
	local bmp = {}
	for _, name in ipairs({ "Raw32", "Raw24", "Packed" }) do
		bmp[name] = Read(addon .. "/tools/art/textures-" .. name .. ".bmp")
	end
	local made = io.open(addon .. "/tools/art/textures-Mapped.bmp")
	os.execute("rm -rf '" .. addon .. "'")
	lu.assertNil(made)
	-- (a 32-bit .bmp: its header 122 long, its height negative when its
	-- first row is the top one, its pixels as they were, an alpha added)
	lu.assertEquals(bmp.Raw32:sub(1, 2), "BM")
	lu.assertEquals(bmp.Raw32:sub(19, 26), "\2\0\0\0\1\0\0\0")
	lu.assertEquals(bmp.Raw32:sub(123), "\1\2\3\4\5\6\7\8")
	lu.assertEquals(bmp.Raw24:sub(23, 26), "\255\255\255\255")
	lu.assertEquals(bmp.Raw24:sub(123), "\1\2\3\255\4\5\6\255")
	lu.assertEquals(bmp.Packed:sub(123), "\9\9\9\9\1\2\3\4\5\6\7\8")
	lu.assertStrContains(json, '"art":[{"alpha":1,"color":[1,1,1,1],"coords":[0,0,0,1,0.125,0,0.125,1],"image":"art/textures-Raw32.bmp"')
	lu.assertStrContains(json, '"image":"art/textures-Raw24.bmp"')
	lu.assertStrContains(json, '"image":true')
	lu.assertStrContains(json, '"image":"game/interface/icons/inv_sword"')
	lu.assertStrContains(json, '"backdrop":{"bg":true,"edge":"art/textures-Packed.bmp","edgeSize":32,"insets":[1,2,3,4],"tile":true}')
	lu.assertStrContains(json, '"points":[["TOP","W","TOP",0,0],["CENTER","W","CENTER",0,0]]')
	lu.assertNotStrContains(json, "Mapped")
	lu.assertNotStrContains(json, "Missing")
	local _, count = json:gsub('"owner"', "")
	lu.assertEquals(count, 6)
end

os.exit(lu.LuaUnit.run())
