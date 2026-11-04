-- tools/positions.lua: settings/positions.lua written from what /dui layout
-- saw (each part commented out), its lines in use kept (their notes and
-- windows too), what /dui adjust moved added in use.
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

TestPositionsTool = {}

function TestPositionsTool:test_written_kept_and_moved()
	local saved, out = TempName(), TempName()
	Write(saved, [[
DiabolicUI_Layout = {
	["moved"] = { ["WhoFrameEditBox"] = { "BOTTOM", "WhoFrame", "BOTTOM", -20.04, 103 } },
	["windows"] = {
		["FriendsFrame"] = { ["parts"] = {
			["WhoFrameEditBox"] = { "BOTTOM", "WhoFrame", "BOTTOM", -20, 100, 296, 32, kind = "EditBox" },
			["WhoFrameTotals"] = { "LEFT", "WhoFrame", "LEFT", 4.5, 0, kind = "FontString", text = "738 \"People\"" },
			["Odd-Name"] = { "TOP", "WhoFrame", "TOP", 0, 0, 10, 10, kind = "Frame" },
			["WhoFrameOld"] = "an older scan's line",
		} },
		["AuctionFrame"] = { ["parts"] = {
			["WhoFrameTotals"] = { "TOP", "AuctionFrame", "TOP", 0, 0, kind = "FontString", text = "Seen \"first\"" },
		} },
	},
}
]])
	Write(out, [[
local _, Engine = ...
Engine:NewStaticConfig("Positions", {
	-- why it's there,
	-- on two lines
	WhoFrameTotals = { "LEFT", "WhoFrame", "LEFT", 8, 0 }, -- (a note at its end)
	GoneFrame = { "TOP", "UIParent", "TOP", 0, -10, 50, 20 },

	-- DressUpFrame -------------------------------------------------------
	-- OldLine = { "TOP", "UIParent", "TOP", 0, 0 },
	-- a size only
	SizedFrame = { 10, 20 },
})
]])
	local pipe = io.popen(LUA .. " tools/positions.lua " .. saved .. " " .. out)
	local said = pipe:read("*a")
	pipe:close()
	lu.assertStrContains(said, "3 parts, 4 in use.")
	local text = Read(out)
	os.remove(saved)
	os.remove(out)
	-- each window's parts, sorted; one seen twice under its first window
	lu.assertStrContains(text, "\t-- AuctionFrame ---")
	lu.assertStrContains(text, "\t-- why it's there,\n\t-- on two lines\n"
		.. '\tWhoFrameTotals = { "LEFT", "WhoFrame", "LEFT", 8, 0 }, -- (a note at its end)')
	lu.assertStrContains(text, '\t-- ["Odd-Name"] = { "TOP", "WhoFrame", "TOP", 0, 0, 10, 10 }, -- Frame')
	lu.assertStrContains(text, '\tWhoFrameEditBox = { "BOTTOM", "WhoFrame", "BOTTOM", -20, 103 }, -- EditBox')
	lu.assertNil(string.find(text, "WhoFrameOld", 1, true))
	lu.assertTrue(text:find("-- AuctionFrame", 1, true) < text:find("-- FriendsFrame", 1, true))
	lu.assertEquals(select(2, text:gsub("WhoFrameTotals", "")), 1)
	-- in use but not seen: kept at the end
	lu.assertStrContains(text, '-- Not seen by /dui layout')
	lu.assertStrContains(text, '\tGoneFrame = { "TOP", "UIParent", "TOP", 0, -10, 50, 20 },')
	-- in use in a window no scan saw: kept there, a size alone too
	lu.assertStrContains(text, "\t-- DressUpFrame ---")
	lu.assertStrContains(text, "\t-- a size only\n\tSizedFrame = { 10, 20 },")
	lu.assertTrue(text:find("-- DressUpFrame", 1, true) < text:find("-- FriendsFrame", 1, true))
	lu.assertNil(string.find(text, "OldLine", 1, true))
	-- a file the game loads
	local positions
	assert(loadstring(text))("DiabolicUI", { NewStaticConfig = function(_, name, t) positions = t end })
	lu.assertEquals(positions.WhoFrameEditBox, { "BOTTOM", "WhoFrame", "BOTTOM", -20, 103 })
	lu.assertNil(positions["Odd-Name"])
end

os.exit(lu.LuaUnit.run())
