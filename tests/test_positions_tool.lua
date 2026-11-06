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
				strata = "MEDIUM", level = 3, tabs = { FriendsFrameTab2 = true } },
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
	-- (in what it's placed on, whatever its parent in the game)
	lu.assertStrContains(friends, [[
    Frame {
        name: "WhoFrame"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 300
        height: 400
]])
	lu.assertStrContains(friends, [[
        EditBox {
            name: "WhoFrameEditBox"
            wowParent: "WhoFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            width: 296
            height: 32
        }
    }
]])
	lu.assertStrContains(friends, "WowWindow {\n    name: \"FriendsFrame\"\n    width: 384\n    height: 500\n")
	lu.assertNil(friends:find("id:", 1, true))
	-- the scan's rect for a text's box, the first window seen keeps a part
	lu.assertStrContains(friends, 'name: "Odd-Name"')
	-- its notes over it, the note at its end after it; on another window, kept
	lu.assertStrContains(auction, '        // why it\'s there,\n        // on two lines\n        FontString {\n            name: "WhoFrameTotals"')
	lu.assertStrContains(auction, '            width: 72\n            height: 12\n        } // (a note at its end)')
	lu.assertStrContains(auction, 'text: "Seen \\"first\\""')
	-- several points: the place that keeps it where it is, its rect's size
	lu.assertStrContains(friends, 'Frame {\n            name: "WhoFrameBar"\n            wowParent: "WhoFrame"\n'
		.. '            anchors.horizontalCenter: parent.horizontalCenter\n            anchors.horizontalCenterOffset: 10\n            anchors.top: parent.top\n')
	-- what's not in it stands in as a Ghost, where what's on it says
	-- (with what's on it inside it)
	lu.assertStrContains(friends, 'Ghost {\n        name: "Elsewhere"\n        x: 89\n        y: 409\n        width: 102\n        height: 0\n\n        Frame {\n            name: "OnCentre"')
	lu.assertStrContains(friends, 'Ghost {\n        name: "Below"\n        x: 95\n        y: 302\n')
	lu.assertStrContains(friends, 'Ghost {\n        name: "Beside"\n        x: 100\n        y: 307\n')
	lu.assertStrContains(friends, 'Ghost {\n        name: "Unseen"\n        x: 0\n        y: 0\n')
	-- in use in a window no scan saw, or none: kept, a size alone without anchors
	lu.assertStrContains(dressUp, '    // a size only\n    Part {\n        name: "SizedFrame"\n        pin: "size"\n        width: 10\n        height: 20')
	lu.assertStrContains(notSeen, 'name: "GoneFrame"\n            pin: "all"')
	lu.assertStrContains(notSeen, 'name: "PlaceOnly"\n            pin: "place"')
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
	lu.assertStrContains(exported, '"WhoFrameEditBox":{"current":{"FriendsFrameTab1":true,"FriendsFrameTab2":true},"kind":"EditBox","level":3,"parent":"WhoFrame",'
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
	lu.assertStrContains(Read(dir .. "/windows/FriendsFrame.qml"), 'name: "OnLeft"\n            anchors.left: parent.left\n            anchors.leftMargin: 7\n')
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
	lu.assertStrContains(text, 'WowWindow {\n    name: "Mine"\n    width: 510\n    height: 620\n')
	lu.assertStrContains(text, '    // over a part\n    Part {\n        name: "Far"')
	-- (an id of the file: in that part from now on, by `parent`)
	lu.assertStrContains(text, 'name: "NoId"\n            anchors.right: parent.right\n            anchors.rightMargin: 2\n            anchors.verticalCenter: parent.verticalCenter\n')
	lu.assertStrContains(text, 'text: "a \\\\ \\"text\\""\n        anchors.horizontalCenter: parent.horizontalCenter\n        anchors.bottom: parent.bottom\n')
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
	lu.assertStrContains(window, 'anchors.right: parent.right\n        anchors.rightMargin: 46\n        anchors.top: parent.top\n        anchors.topMargin: 8\n')
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

-- How the editor draws a text comes through, by the tabs chosen for its words.
function TestPositionsTool:test_how_the_editor_draws_a_text()
	local dir = Folder()
	Write(dir .. "/saved.lua", [=[
DiabolicUI_Layout = { windows = { W = { rect = { 0, 0, 400, 200 }, views = { Tab1 = { label = "One", art = {}, stamp = 1, worded = true } }, parts = {
	Said = { "TOPLEFT", "W", "TOPLEFT", 1, -1, kind = "FontString", rect = { 10, 20, 30, 40 }, tabs = { Tab1 = true }, last = { Tab1 = 1 },
		words = { Tab1 = "|cffff0000Red|r" }, color = { 1, 0.5, 0, 1 }, font = "Fonts\\A.TTF", fontSize = 12, justifyV = "TOP", outline = true, shadow = true },
} } } }
]=])
	Runs(dir)
	local json = Read(dir .. "/layout.json")
	os.execute("rm -rf '" .. dir .. "'")
	lu.assertStrContains(json, '"words":{"Tab1":"|cffff0000Red|r"}')
	lu.assertStrContains(json, '"color":[1,0.5,0,1]')
	lu.assertStrContains(json, '"font":"Fonts\\\\A.TTF","fontSize":12')
	lu.assertStrContains(json, '"justifyV":"TOP"')
	lu.assertStrContains(json, '"outline":true')
	lu.assertStrContains(json, '"worded":true')
end

-- A row: its parts placed and sized to fit the room, kept as a row in its file; a
-- part stretched on two sides, in the file and for the game.
function TestPositionsTool:test_what_only_shows_in_the_preview()
	local dir = Folder()
	local lines = { "DiabolicUI_Layout = { windows = { W = { rect = { 0, 0, 400, 200 }, parts = {" }
	local Add = function(name, kind, text)
		lines[#lines + 1] = string.format('[%q] = { "TOPLEFT", "W", "TOPLEFT", 1, -1, 30, 40, kind = %q, text = %s, rect = { 10, 20, 30, 40 } },', name, kind, text and string.format("%q", text) or "nil")
	end
	for i = 1, 9 do
		Add("ListRow" .. i, "Button")
		Add("ListRow" .. i .. "Name", "FontString", "Row " .. i)
	end
	for i = 1, 7 do
		Add("Short" .. i, "Button")
	end
	for i = 1, 8 do
		Add("WinTab" .. i, "Button")
	end
	Add("AdiBagsItemButton5", "Button")
	Add("AdiBagsItemButton5Count", "FontString", "20")
	Add("Other", "Frame")
	lines[#lines + 1] = "} } } }"
	Write(dir .. "/saved.lua", table.concat(lines, "\n"))
	-- pinned, one of them stays, and what's placed on one of the others has it as a Ghost
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    id: w
    name: "W"
    width: 400
    height: 200
    Button { id: listRow5; name: "ListRow5"; pin: "all"; anchors.left: w.left; anchors.top: w.top; width: 5; height: 5 }
    Frame { id: on; name: "On"; pin: "place"; anchors.left: ghost.left; anchors.top: ghost.top; width: 5; height: 5 }
    Ghost { id: ghost; name: "ListRow7"; x: 0; y: 0; width: 0; height: 0 }
}
]=])
	Runs(dir)
	local file, json = Read(dir .. "/windows/W.qml"), Read(dir .. "/layout.json")
	for _, name in ipairs({ "ListRow1", "ListRow1Name", "ListRow5", "Short7", "WinTab8", "Other", "On" }) do
		lu.assertStrContains(file, 'name: "' .. name .. '"\n')
	end
	for _, name in ipairs({ "ListRow2", "ListRow9", "ListRow2Name", "AdiBagsItemButton5", "AdiBagsItemButton5Count" }) do
		lu.assertNil(file:find('name: "' .. name .. '"\n', 1, true), name)
	end
	lu.assertStrContains(file, 'Ghost {\n        name: "ListRow7"\n        x: 10\n')
	-- the editor still has them all, to draw
	lu.assertStrContains(json, '"ListRow2":{')
	lu.assertStrContains(json, '"AdiBagsItemButton5Count":{')
	lu.assertStrContains(json, '"preview":true')
	-- it settles
	Runs(dir)
	lu.assertEquals(Read(dir .. "/windows/W.qml"), file)
end

function TestPositionsTool:test_the_art_as_the_scan_packs_it()
	local dir = Folder()
	Write(dir .. "/saved.lua", [=[DiabolicUI_Layout = { windows = { W = { rect = { 0, 0, 400, 200 }, window = { 0, 0, 400, 200 }, views = { [""] = { label = "", rect = { 0, 0, 400, 200 }, art = {
		'{owner="W",alpha=1,rect={1,2,3,4},file="Interface\\\\Icons\\\\INV_Thing",coords={0,0,0,1,1,0,1,1},color={1,1,1,1},blend="BLEND"}',
	} } }, parts = { A = { "TOP", "W", "TOP", 0, 0, 3, 4, kind = "Frame", rect = { 1, 2, 3, 4 } } } } } }]=])
	Runs(dir)
	lu.assertStrContains(Read(dir .. "/layout.json"), '"image":"game/interface/icons/inv_thing","owner":"W","rect":[1,2,3,4]')
end

function TestPositionsTool:test_a_part_written_as_its_kind()
	local dir = Folder()
	-- (a kind's own file there isn't a window)
	Write(dir .. "/windows/FontString.qml", 'Part { kind: "FontString" }\n')
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    id: w
    name: "W"
    width: 400
    height: 200
    Part { id: old; name: "Old"; kind: "Button"; pin: "all"; anchors.left: w.left; anchors.top: w.top; width: 50; height: 20 }
    FontString { id: words; name: "Words"; text: "Hi"; pin: "place"; anchors.left: w.left; anchors.top: w.top }
    Part { id: odd; name: "Odd"; kind: "Cooldown"; width: 5; height: 6 }
    Part { id: plain; name: "Plain"; width: 7; height: 8 }
}
]=])
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	local file = Read(dir .. "/windows/W.qml")
	lu.assertStrContains(file, 'Button {\n        name: "Old"\n        pin: "all"')
	lu.assertStrContains(file, 'FontString {\n        name: "Words"\n        text: "Hi"')
	lu.assertStrContains(file, 'Part {\n        name: "Odd"\n        kind: "Cooldown"')
	lu.assertStrContains(file, 'Part {\n        name: "Plain"\n        width: 7')
	lu.assertStrContains(Read(dir .. "/layout.json"), '"kind":"FontString"')
	-- it settles
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	lu.assertEquals(Read(dir .. "/windows/W.qml"), file)
end

-- Every block in a window's file has its type there, for the editor to open it.
function TestPositionsTool:test_every_kind_has_its_file()
	local pipe = io.popen("ls '" .. ROOT .. "'/windows/*.qml")
	for path in pipe:lines() do
		local text = Read(path)
		if text:find("\nWowWindow {", 1, true) then
			for kind in text:gmatch("\n%s*(%u%w*) {") do
				lu.assertNotNil(io.open(ROOT .. "/windows/" .. kind .. ".qml"), path .. ": no windows/" .. kind .. ".qml")
			end
		end
	end
	pipe:close()
end

function TestPositionsTool:test_the_editors_changes_to_rows_and_stretches()
	local dir = Folder()
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    id: w
    name: "W"
    width: 400
    height: 200
    Part { id: c; name: "C"; kind: "Frame"; pin: "place"; anchors.left: w.left; anchors.top: w.top; anchors.topMargin: 30; width: 40; height: 20 }
    Part {
        id: d
        name: "D"
        kind: "Frame"
        pin: "place"
        anchors.left: w.left
        anchors.right: w.right
        anchors.top: w.top
        width: 400
        height: 20
    }
    WowRow {
        name: "Row"
        fit: "equal"
        anchors.left: w.left
        anchors.right: w.right
        anchors.bottom: w.bottom
        Part { name: "A"; kind: "Button"; pin: "all"; width: 50; height: 20 }
        Part { name: "B"; kind: "Button"; pin: "all"; width: 70; height: 20 }
    }
}
]=])
	Write(dir .. "/edits.lua", [=[return {
		["@rows"] = { W = { Row = { fit = "ends", left = 10, right = 20, y = 5 } } },
		C = { window = "W", place = { "TOPLEFT", "W", "TOPLEFT", 10, -30 }, size = { 40, 20 }, pin = "place",
			second = { "TOPRIGHT", "TOPRIGHT", -30, -30 } },
		D = { window = "W", place = { "TOPLEFT", "W", "TOPLEFT", 0, 0 }, size = { 400, 20 }, pin = "all" },
	}]=])
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows", dir .. "/edits.lua" })
	local file, text, json = Read(dir .. "/windows/W.qml"), Read(dir .. "/positions.lua"), Read(dir .. "/layout.json")
	-- the row told: "ends" in 370 of room, the parts pinned at their size stay so
	lu.assertStrContains(file, 'fit: "ends"')
	lu.assertStrContains(file, "anchors.leftMargin: 10\n        anchors.right: parent.right\n        anchors.rightMargin: 20")
	lu.assertStrContains(file, "anchors.bottomMargin: 5")
	lu.assertStrContains(text, 'A = { "BOTTOMLEFT", "W", "BOTTOMLEFT", 10, 5,')
	lu.assertNotStrContains(file, 'fit: "equal"')
	-- stretched from the editor, its far side in its file and the game's
	lu.assertStrContains(text, 'C = { "TOPLEFT", "W", "TOPLEFT", 10, -30, second = { "TOPRIGHT", "TOPRIGHT", -30, -30 } }')
	lu.assertStrContains(file, "anchors.right: parent.right\n        anchors.rightMargin: 30")
	-- no longer stretched: its second side gone, its size held
	lu.assertStrContains(text, 'D = { "TOPLEFT", "W", "TOPLEFT", 0, 0, 400, 20 }')
	-- for the editor: the rows, and which part's in one
	lu.assertStrContains(json, '"inRow":"Row"')
	lu.assertStrContains(json, '"gap":6')
	-- it settles: run again, the same
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	lu.assertEquals(Read(dir .. "/windows/W.qml"), file)
	lu.assertEquals(Read(dir .. "/positions.lua"), text)
end

function TestPositionsTool:test_a_stretch_from_the_editor_needs_a_pin()
	local dir = Folder()
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    id: w
    name: "W"
    width: 400
    height: 200
    Part { id: a; name: "A"; kind: "Frame"; width: 50; height: 20 }
}
]=])
	Write(dir .. "/edits.lua", [=[return { A = { window = "W", place = { "TOPLEFT", "W", "TOPLEFT", 0, 0 }, size = { 50, 20 }, pin = "",
		second = { "TOPRIGHT", "TOPRIGHT", 0, 0 } } }]=])
	lu.assertStrContains(Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows", dir .. "/edits.lua" }), "it needs a pin")
end

function TestPositionsTool:test_a_row_of_equal_widths()
	local dir = Folder()
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    id: w
    name: "W"
    width: 400
    height: 200
    WowRow {
        name: "Same"
        Part { name: "A"; kind: "Button"; text: "A long text"; width: 50; height: 20 }
        Part { name: "B"; kind: "Button"; text: "B"; width: 90; height: 20 }
        Part { name: "C"; kind: "Button"; width: 40; height: 20 }
        fit: "equal"
        spacing: 5
        anchors.left: w.left
        anchors.leftMargin: 10
        anchors.right: w.right
        anchors.rightMargin: 10
        anchors.bottom: w.bottom
        anchors.bottomMargin: 8
    }
}
]=])
	Write(dir .. "/saved.lua", [=[DiabolicUI_Layout = { windows = { W = { parts = {
		A = { "CENTER", "W", "CENTER", 0, 0, 50, 20, kind = "Button", text = "A long text", textWidth = 70, rect = { 0, 0, 50, 20 } },
		B = { "CENTER", "W", "CENTER", 0, 0, 90, 20, kind = "Button", text = "B", textWidth = 8, rect = { 0, 0, 90, 20 } },
	} } } }]=])
	Runs(dir)
	local text = Read(dir .. "/positions.lua")
	-- 380 of room, 10 of gaps: 370 in three, the last taking what rounding left
	lu.assertStrContains(text, 'A = { "BOTTOMLEFT", "W", "BOTTOMLEFT", 10, 8, 123.3, 20 }')
	lu.assertStrContains(text, 'B = { "LEFT", "A", "RIGHT", 5, 0, 123.3, 20 }')
	lu.assertStrContains(text, 'C = { "LEFT", "B", "RIGHT", 5, 0, 123.4, 20 }')
	lu.assertStrContains(Read(dir .. "/windows/W.qml"), 'fit: "equal"')
end

function TestPositionsTool:test_rows_and_what_stretches()
	local dir = Folder()
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    id: w
    name: "W"
    width: 400
    height: 200
    Part {
        id: wide
        name: "Wide"
        pin: "place"
        anchors.left: w.left
        anchors.leftMargin: 10
        anchors.right: w.right
        anchors.rightMargin: 20
        anchors.top: w.top
        anchors.topMargin: 5
        anchors.bottom: w.bottom
        anchors.bottomMargin: 15
        width: 1
        height: 1
    }
    // the room shared
    WowRow {
        name: "Fills"
        Part { name: "A"; kind: "Button"; text: "Aaa"; width: 50; height: 20 }
        Part { name: "B"; kind: "Button"; text: "Bb"; width: 50; height: 20 }
        Part { name: "C"; kind: "Button"; width: 40; height: 20 }
        spacing: 10
        anchors.left: w.left
        anchors.leftMargin: 20
        anchors.right: w.right
        anchors.rightMargin: 20
        anchors.bottom: w.bottom
        anchors.bottomMargin: 8
    }
    WowRow {
        name: "Middle"
        Part { name: "D"; kind: "Button"; width: 40; height: 20 }
        Part { name: "E"; kind: "Button"; width: 40; height: 20 }
        fit: "center"
        spacing: 10
        anchors.left: w.left
        anchors.right: w.right
        anchors.top: w.top
    }
    WowRow {
        name: "Ends"
        Part { name: "F"; kind: "Button"; width: 30; height: 20 }
        fit: "ends"
        anchors.left: w.left
        anchors.right: w.right
        anchors.verticalCenter: w.verticalCenter
    }
}
]=])
	Write(dir .. "/saved.lua", [=[DiabolicUI_Layout = { windows = { W = { parts = {
		A = { "CENTER", "W", "CENTER", 0, 0, 50, 20, kind = "Button", text = "Aaa", textWidth = 30, rect = { 0, 0, 50, 20 } },
		B = { "CENTER", "W", "CENTER", 0, 0, 50, 20, kind = "Button", text = "Bb", textWidth = 20, rect = { 0, 0, 50, 20 } },
	} } } }]=])
	local Run = function()
		Runs(dir)
		return Read(dir .. "/windows/W.qml"), Read(dir .. "/positions.lua"), Read(dir .. "/layout.json")
	end
	local file, text, json = Run()
	-- 360 of room, 20 of gaps, 40 of the one with no text, 50 of the texts: 250 shared
	lu.assertStrContains(text, 'A = { "BOTTOMLEFT", "W", "BOTTOMLEFT", 20, 8, 155, 20 }')
	lu.assertStrContains(text, 'B = { "LEFT", "A", "RIGHT", 10, 0, 145, 20 }')
	lu.assertStrContains(text, 'C = { "LEFT", "B", "RIGHT", 10, 0, 40, 20 }')
	-- 90 wide together, in the middle of 400; one at its ends: in the middle
	lu.assertStrContains(text, 'D = { "TOPLEFT", "W", "TOPLEFT", 155, 0 }')
	lu.assertStrContains(text, 'E = { "LEFT", "D", "RIGHT", 10, 0 }')
	lu.assertStrContains(text, 'F = { "LEFT", "W", "LEFT", 185, 0 }')
	-- stretched: both its points for the game, its size from them
	lu.assertStrContains(text, 'Wide = { "TOPLEFT", "W", "TOPLEFT", 10, -5, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -20, 15 } }')
	lu.assertStrContains(file, "anchors.rightMargin: 20")
	lu.assertStrContains(file, "anchors.bottomMargin: 15")
	lu.assertStrContains(file, "width: 370")
	lu.assertStrContains(file, "height: 180")
	-- the rows kept; what they hold not to be dragged
	lu.assertStrContains(file, "// the room shared\n    WowRow {")
	lu.assertStrContains(file, 'anchors.bottomMargin: 8\n\n        Button {\n            name: "A"\n            text: "Aaa"\n            pin: "all"\n            width: 155\n')
	lu.assertStrContains(file, '\n        }\n\n        Button {\n            name: "B"')
	lu.assertStrContains(json, '"heldBy":"row Fills"')
	lu.assertStrContains(json, '"heldBy":"its two sides"')
	-- again: the same
	local again, textAgain = Run()
	lu.assertEquals(again, file)
	lu.assertEquals(textAgain, text)
	os.execute("rm -rf '" .. dir .. "'")
end

function TestPositionsTool:test_what_a_row_or_a_stretch_cant_be()
	local Says = function(body)
		local dir = Folder()
		Write(dir .. "/windows/W.qml", 'WowWindow {\n    id: w\n    name: "W"\n    width: 100\n    height: 100\n' .. body .. "\n}\n")
		local pipe = io.popen(string.format("cd '%s' && lua5.1 '%s/tools/positions.lua' - '%s/positions.lua' '%s/layout.json' '%s/windows' 2>&1; echo $?",
			os.getenv("PWD"), os.getenv("PWD"), dir, dir, dir))
		local said = pipe:read("*a")
		pipe:close()
		os.execute("rm -rf '" .. dir .. "'")
		return said
	end
	lu.assertStrContains(Says('    Part { id: a; name: "A"; anchors.left: w.left; anchors.right: w.right; anchors.top: w.top; width: 1; height: 1 }'),
		"stretched, it needs a pin")
	lu.assertStrContains(Says('    Part { id: a; name: "A"; pin: "place"; anchors.left: w.left; anchors.horizontalCenter: w.horizontalCenter; anchors.top: w.top; width: 1; height: 1 }'),
		"stretches between left and right only")
	lu.assertStrContains(Says('    WowRow { name: "R"; anchors.left: w.left; anchors.top: w.top; Part { name: "A" } }'), "a row goes from")
	lu.assertStrContains(Says('    WowRow { name: "R"; anchors.left: w.left; anchors.right: w.right; anchors.top: w.top }'), "a row needs its parts")
	lu.assertStrContains(Says('    WowRow { name: "R"; anchors.left: w.left; anchors.right: w.right; anchors.top: w.top; Part { name: "A"; anchors.left: parent.left; anchors.top: parent.top } }'), "its row places it")
	lu.assertStrContains(Says('    WowRow { name: "R"; anchors.left: w.left; anchors.right: w.right; anchors.top: w.top; Frame { name: "A"; WowRow { name: "S" } } }'), "a row goes from")
	lu.assertStrContains(Says('    Part { name: "A"; Ghost { name: "G" } }'), "only a WowWindow")
end

-- Each part in what it's placed on: moved there by the editor, or by the scan;
-- parts placed on each other can't nest, so one stands in the window.
function TestPositionsTool:test_a_part_goes_in_what_its_placed_on()
	local dir = Folder()
	Write(dir .. "/windows/W.qml", [=[
import QtQuick
WowWindow {
    name: "W"
    width: 400
    height: 200
    Frame {
        name: "Foot"
        pin: "all"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 400
        height: 35
    }
    Button {
        name: "Go"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 37
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        width: 80
        height: 22
    }
}
]=])
	Write(dir .. "/edits.lua", [=[return { Go = { window = "W", place = { "BOTTOMLEFT", "Foot", "BOTTOMLEFT", 37, 6 }, size = { 80, 22 }, pin = "all" } }]=])
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows", dir .. "/edits.lua" })
	local file, text = Read(dir .. "/windows/W.qml"), Read(dir .. "/positions.lua")
	lu.assertStrContains(file, 'height: 35\n\n        Button {\n            name: "Go"\n            pin: "all"\n            anchors.left: parent.left\n            anchors.leftMargin: 37\n')
	lu.assertStrContains(text, 'Go = { "BOTTOMLEFT", "Foot", "BOTTOMLEFT", 37, 6, 80, 22 }')
	-- it settles
	Run({ "-", dir .. "/positions.lua", dir .. "/layout.json", dir .. "/windows" })
	lu.assertEquals(Read(dir .. "/windows/W.qml"), file)
	lu.assertEquals(Read(dir .. "/positions.lua"), text)
	-- on each other, as a scan may say: one in the window, the other in it
	dir = Folder()
	Write(dir .. "/saved.lua", [=[DiabolicUI_Layout = { windows = { W = { rect = { 0, 0, 400, 200 }, parts = {
		A = { "TOP", "B", "BOTTOM", 0, 0, 10, 10, kind = "Frame", rect = { 0, 0, 10, 10 } },
		B = { "TOP", "A", "BOTTOM", 0, 0, 10, 10, kind = "Frame", rect = { 0, 0, 10, 10 } },
	} } } }]=])
	Runs(dir)
	file = Read(dir .. "/windows/W.qml")
	lu.assertStrContains(file, '    Frame {\n        name: "A"\n        width: 10\n        height: 10\n\n        Frame {\n            name: "B"\n')
	-- pinned, it can't be: said
	Write(dir .. "/positions.lua", 'local _, E = ...\nE:NewStaticConfig("Positions", {\n\tA = { "TOP", "B", "BOTTOM", 0, 0 },\n\tB = { "TOP", "A", "BOTTOM", 0, 0 },\n})\n')
	os.execute("rm -rf '" .. dir .. "/windows'")
	lu.assertStrContains(Runs(dir), "is placed on what's placed on it")
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
