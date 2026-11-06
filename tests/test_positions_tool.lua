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
	local code = string.format('arg = { [0] = %q, %s }; '
		.. 'local file = assert(io.open(%q)); local chunk = assert(loadstring(file:read("*a"), "@tools/positions.lua")); '
		.. 'file:close(); chunk()', ROOT .. "/tools/positions.lua", table.concat(quoted, ", "), ROOT .. "/tools/positions.lua")
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
	lu.assertStrContains(exported, '"WhoFrameEditBox":{"control":true,"current":{"FriendsFrameTab1":true,"FriendsFrameTab2":true},"kind":"EditBox","level":3,"parent":"WhoFrame",'
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

-- What every window shares: windows/components/*.qml written for the game
-- (our files, the game's, our fonts; added to the window's settings, or under
-- its objectName), and for the editor, each property on its own; the editor's
-- changes written back on their lines, the rest as it was.
function TestPositionsTool:test_the_components()
	local dir = Folder()
	os.execute("mkdir -p '" .. dir .. "/windows/components'")
	local path = dir .. "/windows/components/Thing.qml"
	Write(path, table.concat({
		"// A thing, on two",
		"// lines.",
		"// Shared by every window: settings/components.lua is written from this by",
		"// tools/positions.lua (or the editor's Components). One line per property.",
		"import QtQml",
		"",
		"QtObject {",
		'    objectName: "thing"',
		"",
		"    // how wide",
		"    property real width: 16 // Blizzard's",
		'    property string art: "textures/A.tga"',
		'    property string blank: "Interface/Buttons/WHITE8X8"',
		'    property string font: "DiabolicFont_Narrow14"',
		"    property var coords: [14/64, 1]",
		"    property var line_color: [.5, 1, 0]",
		'    property var up: ({ normal: "textures/U.tga", deep: { size: 2 } })',
		"}",
		"",
	}, "\n"))
	Write(dir .. "/windows/components/Flat.qml", 'import QtQml\nQtObject {\n    objectName: ""\n    property real gap: 6\n}\n')
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	local lua, json = Read(dir .. "/components.lua"), Read(dir .. "/layout.json")
	lu.assertStrContains(lua, "\tthing = {\n\t\twidth = 16,\n\t\tart = path .. [[textures\\A.tga]],\n\t\tblank = [[Interface\\Buttons\\WHITE8X8]],\n\t\tfont = DiabolicFont_Narrow14,\n\t\tcoords = { 0.21875, 1 },")
	lu.assertStrContains(lua, "up = { deep = { size = 2 }, normal = path .. [[textures\\U.tga]] },")
	lu.assertStrContains(lua, "Merge(window, {\n\tgap = 6,\n})")
	lu.assertStrContains(json, '{"comment":"A thing, on two lines.","fields":[{"key":"width","kind":"number","note":"how wide","value":16}')
	lu.assertStrContains(json, '{"key":"art","kind":"texture","value":"textures/A.tga"}')
	lu.assertStrContains(json, '{"key":"line_color","kind":"color","value":[0.5,1,0]}')
	lu.assertStrContains(json, '{"key":"coords","kind":"list","value":[0.2188,1]}')
	lu.assertStrContains(json, '{"key":"up.deep.size","kind":"number","value":2}')
	-- the editor's changes
	Write(dir .. "/edits.lua", 'return { ["@components"] = { Thing = { width = 18, ["up.deep.size"] = 3, line_color = { 1, 1, 1 } }, Gone = { a = 1 } } }')
	local before = Read(path)
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows", dir .. "/edits.lua" })
	local after = Read(path)
	lua = Read(dir .. "/components.lua")
	lu.assertStrContains(after, "    // how wide\n    property real width: 18 // Blizzard's\n")
	lu.assertStrContains(after, '    property var up: ({ deep: { size: 3 }, normal: "textures/U.tga" })\n')
	lu.assertStrContains(after, "    property var line_color: [1, 1, 1]\n")
	lu.assertStrContains(after, "    property var coords: [14/64, 1]\n") -- (what's not changed, as it was)
	lu.assertNotEquals(after, before)
	lu.assertStrContains(lua, "width = 18,")
	lu.assertStrContains(lua, "up = { deep = { size = 3 }")
	-- what can't be read is said, naming it, and nothing's written
	for _, case in ipairs({
		{ "    property var a: nope", "needs a plain value" },
		{ "    property var a: [1,", "needs a plain value" },
		{ "    onClicked: a()", "not a property" },
	}) do
		Write(path, "import QtQml\nQtObject {\n    objectName: \"thing\"\n" .. case[1] .. "\n}\n")
		Write(dir .. "/components.lua", "-- as it was")
		local said = Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
		lu.assertStrContains(said, "Thing.qml")
		lu.assertStrContains(said, case[2])
		lu.assertEquals(Read(dir .. "/components.lua"), "-- as it was")
	end
	Write(path, "import QtQml\nQtObject {\n    property real a: 1\n}\n")
	lu.assertStrContains(Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" }), "needs an objectName")
	os.execute("rm -rf '" .. dir .. "'")
end

-- What's in the repository agrees: settings/positions.lua is what
-- windows/*.qml say, and they stay as they are when read and written back.
function TestPositionsTool:test_the_files_agree()
	local dir = Folder()
	os.execute("cp -r '" .. ROOT .. "'/windows/. '" .. dir .. "/windows/'")
	Write(dir .. "/positions.lua", "")
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	local written, components = Read(dir .. "/positions.lua"), Read(dir .. "/components.lua")
	local same = os.execute("diff -r '" .. ROOT .. "/windows' '" .. dir .. "/windows' >/dev/null")
	os.execute("rm -rf '" .. dir .. "'")
	lu.assertEquals(written, Read(ROOT .. "/settings/positions.lua"))
	lu.assertEquals(components, Read(ROOT .. "/settings/components.lua"))
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

-- The art for the editor: our files as they are in media/ (whatever their
-- case), white ones said white, the game's by their paths, the ones not found
-- left out.
function TestPositionsTool:test_the_art_by_its_files()
	local addon = TempName()
	os.execute("mkdir -p '" .. addon .. "/media/textures' '" .. addon .. "/tools'")
	Write(addon .. "/media/textures/Raw32.tga", "")
	Write(addon .. "/media/textures/Raw24.tga", "")
	local ours = [[Interface\\AddOns\\DiabolicUI\\media\\textures\\]]
	local item = function(file) return string.format('{ file = "%s", rect = { 0, 0, 2, 1 }, coords = { 0, 0, 0, 1, .125, 0, .125, 1 }, color = { 1, 1, 1, 1 }, alpha = 1, owner = "W" },', file) end
	-- (a part's second point on nothing: on its parent)
	Write(addon .. "/saved.lua", "DiabolicUI_Layout = { windows = { W = { parts = { P = { 'TOP', 'W', 'TOP', 0, 0, 1, 1, kind = 'Frame', style = 'ScrollBar', parent = 'W',"
		.. " points = { { 'TOP', 'W', 'TOP', 0, 0 }, { 'CENTER', nil, 'CENTER', 0, 0 } } } }, art = {\n"
		.. item(ours .. "Raw32") .. item(ours .. "raw24.TGA") .. item(ours .. "Missing") .. item([[Interface\\Buttons\\WHITE8X8]]) .. item([[Interface\\Icons\\INV_Sword.blp]])
		.. '{ backdrop = { bgFile = [[Interface\\ChatFrame\\ChatFrameBackground]], edgeFile = "' .. ours .. 'Raw24", edgeSize = 32, tile = true, insets = { 1, 2, 3, 4 } }, rect = { 0, 0, 9, 9 }, scale = 1 },'
		.. '{ backdrop = { edgeFile = "' .. ours .. 'Missing" }, rect = { 0, 0, 9, 9 } },'
		.. "} } } }")
	Run({ addon .. "/saved.lua", addon .. "/positions.lua", addon .. "/tools/layout.json", addon .. "/windows" }, addon)
	local json = Read(addon .. "/tools/layout.json")
	local window = Read(addon .. "/windows/W.qml")
	-- (the component a part is styled as, from the scan, and read back)
	Run({ "-", addon .. "/positions.lua", addon .. "/tools/layout.json", addon .. "/windows" }, addon)
	local again = Read(addon .. "/tools/layout.json")
	os.execute("rm -rf '" .. addon .. "'")
	lu.assertStrContains(window, 'style: "ScrollBar"')
	lu.assertStrContains(json, '"style":"ScrollBar"')
	lu.assertStrContains(again, '"style":"ScrollBar"')
	lu.assertStrContains(json, '"art":[{"alpha":1,"color":[1,1,1,1],"coords":[0,0,0,1,0.125,0,0.125,1],"image":"media/textures/Raw32.tga"')
	lu.assertStrContains(json, '"image":"media/textures/Raw24.tga"')
	lu.assertStrContains(json, '"image":true')
	lu.assertStrContains(json, '"image":"game/interface/icons/inv_sword"')
	lu.assertStrContains(json, '"backdrop":{"bg":true,"edge":"media/textures/Raw24.tga","edgeSize":32,"insets":[1,2,3,4],"tile":true}')
	lu.assertStrContains(json, '"points":[["TOP","W","TOP",0,0],["CENTER","W","CENTER",0,0]]')
	lu.assertNotStrContains(json, "Missing")
	local _, count = json:gsub('"owner"', "")
	lu.assertEquals(count, 4)
end

-- The rules go by what each view has: the window and foot where it has them, not
-- where their one part was last seen; a list in a column aside says nothing of the
-- window's sides.
function TestPositionsTool:test_the_rules_by_what_a_view_has()
	local pipe = io.popen("command -v node 2>/dev/null")
	local node = pipe:read("*l")
	pipe:close()
	if (not node) then
		lu.skip("needs node")
	end
	local dir = Folder()
	Write(dir .. "/layout.json", [=[{ "rules": { "button_gap": 6, "content_gap": 6, "uneven": 8 }, "unit": 1, "windows": {
		"Stale": { "views": [ { "key": "a", "frame": "Win", "foot": "Foot", "railOver": 0, "rect": [0, 0, 200, 100], "window": [0, 0, 200, 100], "footRect": [0, 0, 200, 16] } ],
			"parts": { "Win": { "rect": [0, 0, 100, 100] }, "Foot": { "rect": [0, 0, 200, 24] }, "Zone": { "zone": "Z", "rect": [10, 26, 180, 64] } } },
		"Aside": { "views": [ { "key": "a", "frame": "Win", "rect": [0, 0, 200, 100], "window": [0, 0, 200, 100] } ],
			"parts": { "Win": { "rect": [0, 0, 200, 100] }, "Zone": { "zone": "Z", "aside": true, "rect": [150, 26, 30, 64] } } },
		"Sides": { "views": [ { "key": "a", "frame": "Win", "rect": [0, 0, 200, 100], "window": [0, 0, 200, 100] } ],
			"parts": { "Win": { "rect": [0, 0, 200, 100] }, "Zone": { "zone": "Z", "rect": [150, 26, 30, 64] } } },
		"Bags": { "views": [ { "key": "a", "frame": "Win", "rect": [0, 0, 200, 100], "window": [0, 0, 200, 100] } ],
			"parts": { "Win": { "rect": [0, 0, 200, 100] }, "AdiBagsItemButton1": { "control": true, "rect": [500, 0, 37, 37] },
				"AdiBagsBankItemButton1": { "control": true, "rect": [500, 0, 37, 37] }, "OtherButton": { "control": true, "rect": [500, 0, 37, 37] } } }
	} }]=])
	local Said = function(window)
		local run = io.popen("node tests/rules_run.js '" .. dir .. "/layout.json' " .. window .. " 2>&1")
		local text = run:read("*a")
		run:close()
		return text
	end
	local stale, aside, sides, bags = Said("Stale"), Said("Aside"), Said("Sides"), Said("Bags")
	os.execute("rm -rf '" .. dir .. "'")
	lu.assertEquals(stale, "")
	lu.assertNotStrContains(aside, "of room left of the content")
	lu.assertStrContains(sides, "of room left of the content")
	lu.assertStrContains(bags, "OtherButton is out of the window")
	lu.assertNotStrContains(bags, "AdiBags")
end

-- A part seen only with no tab chosen shows only then; which views' last look saw a
-- part; one only placed and never scanned sized from what's placed on its points.
function TestPositionsTool:test_what_a_view_saw_and_a_parts_size_from_others()
	local dir = Folder()
	Write(dir .. "/saved.lua", [=[DiabolicUI_Layout = { windows = { W = { rect = { 0, 0, 200, 200 }, window = { 0, 0, 200, 200 },
		views = { [""] = { rect = { 0, 0, 200, 200 }, stamp = 2 }, Tab1 = { label = "One", rect = { 0, 0, 200, 200 }, stamp = 3 } },
		parts = {
			NoTab = { "TOPLEFT", "W", "TOPLEFT", 0, 0, 10, 10, kind = "Frame", rect = { 0, 190, 10, 10 }, tabs = {}, last = { [""] = 2 } },
			Gone = { "TOPLEFT", "W", "TOPLEFT", 0, 0, 10, 10, kind = "Frame", rect = { 0, 190, 10, 10 }, tabs = { Tab1 = true }, last = { Tab1 = 1 } },
			There = { "TOPLEFT", "W", "TOPLEFT", 0, 0, 10, 10, kind = "Frame", rect = { 0, 190, 10, 10 }, tabs = { Tab1 = true }, last = { Tab1 = 3 } },
			OnTopLeft = { "TOPLEFT", "Texture", "TOPLEFT", 0, 0, 10, 10, kind = "Frame", rect = { 20, 170, 10, 10 } },
			OnBottomRight = { "BOTTOMRIGHT", "Texture", "BOTTOMRIGHT", 0, 0, 10, 10, kind = "Frame", rect = { 74, 106, 10, 10 } },
		} } } }]=])
	Write(dir .. "/positions.lua", [=[
local _, Engine = ...
Engine:NewStaticConfig("Positions", {
	-- W ---------------------------------------------------------------------
	Texture = { "TOPLEFT", "W", "TOPLEFT", 20, -20 },
})
]=])
	Runs(dir)
	local json, file = Read(dir .. "/layout.json"), Read(dir .. "/windows/W.qml")
	os.execute("rm -rf '" .. dir .. "'")
	lu.assertStrContains(json, '"NoTab":{"current":{"":true}')
	lu.assertStrContains(json, '"tabs":[""]')
	lu.assertStrContains(json, '"Gone":{"current":{}')
	lu.assertStrContains(json, '"There":{"current":{"Tab1":true}')
	-- (from the one's top left to the other's bottom right: 64 by 74)
	lu.assertStrContains(file, "width: 64")
	lu.assertStrContains(file, "height: 74")
end

-- A window the game scales: its rects on screen in its own units, as its parts'
-- places and sizes are; a part held by two points sized with them.
function TestPositionsTool:test_a_scaled_windows_rects_in_its_own_units()
	local dir = Folder()
	Write(dir .. "/saved.lua", [=[DiabolicUI_Layout = { windows = { W = { rect = { 100, 100, 220, 110 }, window = { 100, 100, 220, 110 },
		views = { [""] = { rect = { 100, 100, 220, 110 }, window = { 100, 100, 220, 110 }, frame = "W",
			art = { { file = "Interface\\Buttons\\WHITE8X8", rect = { 122, 188, 44, 11 }, coords = { 0, 0, 0, 1, 1, 0, 1, 1 }, scale = 1.1 } } } },
		parts = {
			Box = { "TOPLEFT", "W", "TOPLEFT", 20, -10, 40, 20, kind = "Frame", rect = { 122, 177, 44, 22 } },
			Field = { "LEFT", "Box", "LEFT", 0, 0, 40, 10, kind = "Frame", rect = { 122, 182.5, 44, 11 },
				points = { { "LEFT", "Box", "LEFT", 0, 0 }, { "RIGHT", "Box", "RIGHT", 0, 0 } } },
		} } } }]=])
	Runs(dir)
	local json, file = Read(dir .. "/layout.json"), Read(dir .. "/windows/W.qml")
	os.execute("rm -rf '" .. dir .. "'")
	-- the window from its top left, its art, its parts
	lu.assertStrContains(json, '"rect":[100,110,200,100]')
	lu.assertStrContains(json, '"scale":1.1')
	lu.assertStrContains(json, '"rect":[120,190,40,10]')
	lu.assertStrContains(json, '"rect":[120,180,40,20]')
	lu.assertStrContains(file, "width: 200")
	-- the one held by two points, not its size on screen
	lu.assertStrContains(json, '"size":[40,10]')
	lu.assertNotStrContains(file, "width: 44")
end

os.exit(lu.LuaUnit.run())
