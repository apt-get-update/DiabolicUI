-- Run from the addon root: lua5.1 tests/test_sample_tool.lua
--
-- tools/sample.lua, Components' sample window in the editor: every component's
-- controls drawn, by the game's styling, with what's not saved yet.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")

-- (os.tmpname() always uses /tmp, which a sandbox may not let us write)
local EDITS = (os.getenv("TMPDIR") or "/tmp") .. "/diabolicui_test_" .. os.time() .. "_" .. math.random(1e9)

-- `text` (JSON of plain values) as a Lua table.
local Decode = function(text)
	local out, quoted = {}, false
	local i = 1
	while (i <= #text) do
		local c = text:sub(i, i)
		if (c == "\\") and quoted then
			out[#out + 1] = text:sub(i, i + 1)
			i = i + 1
		else
			if (c == '"') then
				quoted = not quoted
			end
			if quoted or (c == '"') then
				out[#out + 1] = c
			elseif (c == "[") or (c == "{") then
				out[#out + 1] = "{"
			elseif (c == "]") or (c == "}") then
				out[#out + 1] = "}"
			elseif (c == ":") then
				out[#out + 1] = "="
			else
				out[#out + 1] = c
			end
		end
		i = i + 1
	end
	-- (a key's quotes in brackets)
	local lua = table.concat(out):gsub('"([%w_]+)"=', "%1=")
	return assert(loadstring("return " .. lua))()
end

-- What the tool answers for `edits` (a Lua table's text), as text and as a table.
local Sample = function(edits)
	if edits then
		local file = assert(io.open(EDITS, "w"))
		file:write("return { [\"@components\"] = " .. edits .. " }")
		file:close()
	end
	-- (recorded under the coverage run too: os.exit is what writes it)
	local stats = os.getenv("DIABOLICUI_COVERAGE_STATS")
	local command = "lua5.1 tools/sample.lua " .. (edits and EDITS or "")
	if stats then
		command = string.format("DIABOLICUI_COVERAGE_STATS=%s lua5.1 -e 'dofile(\"tests/coverage/hook.lua\"); arg = { [0] = \"tools/sample.lua\", %s }; dofile(\"tools/sample.lua\"); os.exit(0)'",
			stats:gsub("%.out$", "") .. ".sample.out", edits and string.format("%q", EDITS):gsub('"', '\"') or "")
	end
	local pipe = io.popen(command .. " 2>&1")
	local text = pipe:read("*a")
	pipe:close()
	return Decode(text)
end

local Find = function(list, test)
	for _, item in ipairs(list) do
		if test(item) then
			return item
		end
	end
end

local Uses = function(sample, image)
	return Find(sample.art, function(item) return item.image == image end)
end

TestSample = {}

function TestSample:tearDown()
	os.remove(EDITS)
end

function TestSample:test_every_component_is_drawn_and_nothing_fails()
	local sample = Sample()
	lu.assertEquals(sample.problems, {})
	local drawn = {}
	for _, control in ipairs(sample.controls) do
		drawn[control.component] = true
	end
	local pipe = io.popen("ls windows/components/*.qml")
	for path in pipe:lines() do
		local name = path:match("([^/]+)%.qml$")
		-- (TabRow's a distance: how far the window's top is lowered)
		if (name ~= "TabRow") then
			lu.assertTrue(drawn[name], name)
		end
	end
	pipe:close()
end

-- What breaks is said, as it's built and as it shows: for the editor to show it.
function TestSample:test_what_breaks_is_said()
	local sample = Sample('{ Window = { layout = false } }')
	lu.assertTrue(#sample.problems >= 2)
	lu.assertStrContains(sample.problems[1], "layout")
	lu.assertStrContains(sample.problems[#sample.problems], "ERROR:")
end

function TestSample:test_a_button_shows_only_its_state()
	local sample = Sample()
	-- each button's three slices, its lit one's, its disabled one's; the pressed
	-- ones and what's only under the mouse not over them
	lu.assertNotNil(Uses(sample, "media/textures/DiabolicUI_D3_ButtonLit.tga"))
	local plate = Find(sample.texts, function(text) return text.text == "Disabled" end)
	lu.assertAlmostEquals(plate.color[1], .5, 1e-6)
end

function TestSample:test_a_change_not_saved_shows()
	-- a texture
	local sample = Sample('{ ScrollBar = { thumb = "textures/DiabolicUI_D3_Close.tga" } }')
	lu.assertNil(Uses(sample, "media/textures/DiabolicUI_Slider_22x36_Thumb.tga"))
	lu.assertNotNil(Uses(sample, "media/textures/DiabolicUI_D3_Close.tga"))
	-- a color, on a text
	sample = Sample('{ Section = { color = { .1, .2, .3 } } }')
	local title = Find(sample.texts, function(text) return text.text == "Section" end)
	lu.assertEquals(title.color[3], .3)
	-- a font, replaced
	sample = Sample('{ Section = { font = "DiabolicFont_Narrow14" } }')
	title = Find(sample.texts, function(text) return text.text == "Section" end)
	lu.assertEquals(title.size, 14)
	-- a size
	sample = Sample('{ CloseButton = { size = 40 } }')
	local close = Find(sample.controls, function(control) return control.component == "CloseButton" end)
	lu.assertEquals(close.rect[3], 40)
end

function TestSample:test_a_changes_nothing_on_disk()
	local Read = function(path)
		local file = assert(io.open(path))
		local text = file:read("*a")
		file:close()
		return text
	end
	local component, generated = Read("windows/components/CloseButton.qml"), Read("settings/components.lua")
	Sample('{ CloseButton = { size = 40 } }')
	lu.assertEquals(Read("windows/components/CloseButton.qml"), component)
	lu.assertEquals(Read("settings/components.lua"), generated)
end

os.exit(lu.LuaUnit.run())
