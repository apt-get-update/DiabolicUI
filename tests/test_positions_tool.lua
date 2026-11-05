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

function TestPositionsTool:test_written_kept_and_moved()
	local saved, out, json = TempName(), TempName(), TempName()
	Write(saved, [[
DiabolicUI_Layout = {
	["moved"] = { ["WhoFrameEditBox"] = { "BOTTOM", "WhoFrame", "BOTTOM", -20.04, 103 } },
	["windows"] = {
		["FriendsFrame"] = { ["parts"] = {
			["WhoFrameEditBox"] = { "BOTTOM", "WhoFrame", "BOTTOM", -20, 100, 296, 32, kind = "EditBox",
				points = { { "BOTTOM", "WhoFrame", "BOTTOM", -20, 100 } }, parent = "WhoFrame", rect = { 50, 100, 296, 32 },
				strata = "MEDIUM", level = 3 },
			["WhoFrameTotals"] = { "LEFT", "WhoFrame", "LEFT", 4.5, 0, kind = "FontString", text = "738 \"People\"" },
			["Odd-Name"] = { "TOP", "WhoFrame", "TOP", 0, 0, 10, 10, kind = "Frame" },
			["WhoFrameOld"] = "an older scan's line",
		}, ["rect"] = { 10, 20, 384, 512 } },
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
	local said = Run({ saved, out, json })
	lu.assertStrContains(said, "3 parts, 4 in use.")
	local text = Read(out)
	local exported = Read(json)
	os.remove(saved)
	os.remove(out)
	os.remove(json)
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
	-- for an editor: each window's parts as the scan saw them (their place
	-- and size apart), the lines in use beside them, those of no window
	lu.assertStrContains(exported, '"FriendsFrame":{"parts":{')
	lu.assertStrContains(exported, '"rect":[10,20,384,512]')
	lu.assertStrContains(exported, '"WhoFrameEditBox":{"kind":"EditBox","level":3,"parent":"WhoFrame",'
		.. '"place":["BOTTOM","WhoFrame","BOTTOM",-20,100],"points":[["BOTTOM","WhoFrame","BOTTOM",-20,100]],'
		.. '"rect":[50,100,296,32],"size":[296,32],"strata":"MEDIUM","use":{"place":["BOTTOM","WhoFrame","BOTTOM",-20.04,103]}}')
	lu.assertStrContains(exported, '"text":"738 \\"People\\""')
	lu.assertStrContains(exported, '"unseen":{"GoneFrame":{"place":["TOP","UIParent","TOP",0,-10],"size":[50,20]},'
		.. '"SizedFrame":{"size":[10,20]}}')
	lu.assertNil(exported:find('"WhoFrameOld"', 1, true))
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
	local text = Read(addon .. "/settings/positions.lua")
	lu.assertStrContains(Read(addon .. "/tools/layout.json"), '"BankCloseButton":{"kind":"Button"')
	os.execute("rm -rf '" .. base .. "'")
	lu.assertStrContains(text, '\t-- BankCloseButton = { "TOPRIGHT", "BankFrame", "TOPRIGHT", -46, -8, 32, 32 }, -- Button')
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
		.. item(ours .. "Mapped") .. item(ours .. "Missing") .. item([[Interface\\Buttons\\WHITE8X8]])
		.. '{ backdrop = { bgFile = [[Interface\\ChatFrame\\ChatFrameBackground]], edgeFile = "' .. ours .. 'Packed", edgeSize = 32, tile = true, insets = { 1, 2, 3, 4 } }, rect = { 0, 0, 9, 9 }, scale = 1 },'
		.. '{ backdrop = { edgeFile = "' .. ours .. 'Missing" }, rect = { 0, 0, 9, 9 } },'
		.. "} } } }")
	Run({ addon .. "/saved.lua", addon .. "/positions.lua", addon .. "/tools/layout.json" }, addon)
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
	lu.assertStrContains(json, '"backdrop":{"bg":true,"edge":"art/textures-Packed.bmp","edgeSize":32,"insets":[1,2,3,4],"tile":true}')
	lu.assertStrContains(json, '"points":[["TOP","W","TOP",0,0],["CENTER","W","CENTER",0,0]]')
	lu.assertNotStrContains(json, "Mapped")
	lu.assertNotStrContains(json, "Missing")
	local _, count = json:gsub('"owner"', "")
	lu.assertEquals(count, 5)
end

os.exit(lu.LuaUnit.run())
