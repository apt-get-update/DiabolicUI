-- What tools/positions.lua and tools/sample.lua share: windows/components/*.qml
-- read and changed, settings/components.lua written from them, what's handed to
-- the editor in JSON and how our art's files are found.
local Shared = {}

local Sorted = function(list)
	local names = {}
	for name in pairs(list) do
		names[#names + 1] = name
	end
	table.sort(names)
	return names
end

local Unquote = function(value)
	local inner = value:match('^"(.*)"$')
	return inner and (inner:gsub("\\(.)", "%1"))
end

-- Its property's value, "..." or [...] or ({...}), and what's after it (a //).
local ValueAndTail = function(text)
	local quoted = false
	for i = 1, #text do
		local c = text:sub(i, i)
		if (c == '"') then
			quoted = not quoted
		elseif (not quoted) and (text:sub(i, i + 1) == "//") then
			return text:sub(1, i - 1):match("^(.-)%s*$"), text:sub(i)
		end
	end
	return text:match("^(.-)%s*$"), nil
end

local LUA_OF = { ["["] = "{", ["]"] = "}", [":"] = "=" }
local ValueOf = function(text)
	local out, quoted = {}, false
	for c in (text:match("^%((.*)%)$") or text):gmatch(".") do
		if (c == '"') then
			quoted = not quoted
		end
		out[#out + 1] = (not quoted) and LUA_OF[c] or c
	end
	local chunk = loadstring("return " .. table.concat(out))
	if chunk then
		local ok, value = pcall(setfenv(chunk, {}))
		if ok and (value ~= nil) then
			return value
		end
	end
end

local IsList = function(value)
	return (next(value) ~= nil) and (#Sorted(value) == #value)
end

-- A value back as the file writes it.
local JsOf
JsOf = function(value)
	if (type(value) == "string") then
		return string.format("%q", value)
	elseif (type(value) == "number") then
		return string.format("%.10g", value)
	elseif (type(value) ~= "table") then
		return tostring(value)
	elseif IsList(value) then
		local out = {}
		for i, item in ipairs(value) do
			out[i] = JsOf(item)
		end
		return "[" .. table.concat(out, ", ") .. "]"
	end
	local out = {}
	for _, key in ipairs(Sorted(value)) do
		out[#out + 1] = key .. ": " .. JsOf(value[key])
	end
	return "{ " .. table.concat(out, ", ") .. " }"
end

local ReadComponent = function(path)
	local name = path:match("([^/]+)%.qml$")
	local component = { name = name, path = path, lines = {}, comment = {}, order = {}, values = {}, at = {}, notes = {} }
	local Problem = function(what)
		error(path .. ": " .. what, 0)
	end
	local notes, started = {}, false
	for line in io.lines(path) do
		local at = #component.lines + 1
		component.lines[at] = line
		local kind, key, rest = line:match("^%s*property%s+(%w+)%s+([%w_]+):%s*(.-)%s*$")
		local note = line:match("^%s*//%s?(.*)$")
		if key then
			local text, tail = ValueAndTail(rest)
			local value = ValueOf(text)
			if (value == nil) then
				Problem(key .. ": needs a plain value on its line, not " .. text)
			end
			component.order[#component.order + 1] = key
			component.values[key], component.at[key] = value, { line = at, kind = kind, tail = tail }
			component.notes[key] = table.concat(notes, " ")
			notes = {}
		elseif note then
			if started then
				notes[#notes + 1] = note
			elseif (not note:find("^Shared by every window")) and (not note:find("^tools/positions.lua")) then
				component.comment[#component.comment + 1] = note
			end
		elseif line:find("^%s*objectName:") then
			component.key = Unquote(line:match("^%s*objectName:%s*(.-)%s*$")) or Problem("objectName needs a text")
		elseif line:find("^%s*QtObject") then
			started = true
		elseif (line ~= "") and (not line:find("^import ")) and (not line:find("^%s*}%s*$")) then
			Problem("not a property of its own line: " .. line)
		end
	end
	if (not component.key) then
		Problem("needs an objectName (\"\": its properties directly in the window's settings)")
	end
	component.comment = table.concat(component.comment, " ")
	return component
end

-- `changes` (by property's path: "up.normal") in its values and its lines.
local ChangeComponent = function(component, changes)
	for path, value in pairs(changes) do
		local head, rest = path:match("^([^.]+)%.?(.*)$")
		local holder, key = component.values, head
		if (rest ~= "") then
			for step in rest:gmatch("[^.]+") do
				holder = holder[key]
				key = step
			end
		end
		holder[key] = value
		local at = component.at[head]
		local text = JsOf(component.values[head])
		text = ((type(component.values[head]) == "table") and (not IsList(component.values[head]))) and ("(" .. text .. ")") or text
		component.lines[at.line] = "    property " .. at.kind .. " " .. head .. ": " .. text .. (at.tail and (" " .. at.tail) or "")
	end
end

-- A value in Lua: our files from the media folder, the game's with its slashes,
-- our fonts by their names.
local LuaOf
LuaOf = function(value)
	if (type(value) == "string") then
		if value:find("^textures/") or value:find("^fonts/") then
			return "path .. [[" .. value:gsub("/", "\\") .. "]]"
		elseif value:find("^Interface/") then
			return "[[" .. value:gsub("/", "\\") .. "]]"
		elseif value:find("^DiabolicFont_") then
			return value
		end
		return string.format("%q", value)
	elseif (type(value) == "number") then
		return string.format("%.10g", value)
	elseif (type(value) ~= "table") then
		return tostring(value)
	end
	local out = {}
	if IsList(value) then
		for i, item in ipairs(value) do
			out[i] = LuaOf(item)
		end
	else
		for _, key in ipairs(Sorted(value)) do
			out[#out + 1] = key .. " = " .. LuaOf(value[key])
		end
	end
	return "{ " .. table.concat(out, ", ") .. " }"
end

-- settings/components.lua's text.
local ComponentsLua = function(components)
	local out = { [[
-- What every window shares, the generic window and its controls: added to
-- settings/blizzard.lua's `window`.
-- Written from windows/components/*.qml by tools/positions.lua: change those (docs:
-- Common Tasks), this file is overwritten.
local ADDON, Engine = ...
local path = ([=[Interface\AddOns\%s\media\]=]):format(ADDON)
local window = Engine:GetDB("Blizzard").window

local Merge
Merge = function(into, values)
	for key, value in pairs(values) do
		-- (a font is a table too, with a metatable: replaced, not mixed)
		if (type(value) == "table") and (type(into[key]) == "table") and (not getmetatable(value)) then
			Merge(into[key], value)
		else
			into[key] = value
		end
	end
end
]] }
	for _, component in ipairs(components) do
		out[#out + 1] = "-- " .. component.name
		out[#out + 1] = "Merge(window, {"
		local into = ""
		if (component.key ~= "") then
			out[#out + 1] = "\t" .. component.key .. " = {"
			into = "\t"
		end
		for _, key in ipairs(component.order) do
			out[#out + 1] = into .. "\t" .. key .. " = " .. LuaOf(component.values[key]) .. ","
		end
		if (component.key ~= "") then
			out[#out + 1] = "\t},"
		end
		out[#out + 1] = "})"
		out[#out + 1] = ""
	end
	return table.concat(out, "\n")
end

-- `value` (a string, a number or a table) in JSON: a table with 1..n only
-- an array, else an object (its keys sorted).
local Encode
Encode = function(value, out)
	local kind = type(value)
	if (kind == "string") then
		local escaped = value:gsub('[%c"\\]', function(c)
			return (c == '"' and '\\"') or (c == "\\" and "\\\\") or string.format("\\u%04x", c:byte())
		end)
		out[#out + 1] = '"' .. escaped .. '"'
	elseif (kind == "number") then
		out[#out + 1] = (string.format("%.4f", value):gsub("%.?0+$", ""))
	elseif (kind == "boolean") then
		out[#out + 1] = tostring(value)
	elseif (kind == "table") and (next(value) ~= nil) and (#Sorted(value) == #value) then
		out[#out + 1] = "["
		for i, item in ipairs(value) do
			out[#out + 1] = (i > 1) and "," or ""
			Encode(item, out)
		end
		out[#out + 1] = "]"
	else
		out[#out + 1] = "{"
		for i, key in ipairs(Sorted(value)) do
			out[#out + 1] = (i > 1) and "," or ""
			Encode(tostring(key), out)
			out[#out + 1] = ":"
			Encode(value[key], out)
		end
		out[#out + 1] = "}"
	end
end

-- the media files by their names in lower case (the game's aren't fussy)
local media = {}
local pipe = io.popen("find media -type f -iname '*.tga' 2>/dev/null")
for path in pipe:lines() do
	media[path:lower()] = path
end
pipe:close()

-- a texture's file as the editor finds it: ours in media/, the game's (read by
-- tools/gametextures.py), true if white, or nil
local WHITE = { ["interface/chatframe/chatframebackground"] = true, ["interface/buttons/white8x8"] = true }
local Picture = function(file)
	if (not file) then
		return
	end
	local rest = file:gsub("\\", "/"):match("[Dd]iabolic[Uu][Ii]/(.*)$")
	if (not rest) then
		local path = file:gsub("\\", "/"):lower():gsub("%.%a+$", "")
		return WHITE[path] or ("game/" .. path)
	end
	return media[rest:lower()] or media[rest:lower() .. ".tga"]
end

-- a window's art as the editor draws it: its files as their pictures
-- (the ones not found or read left out; none: nil)
local Pictures = function(art)
	local out = {}
	for _, item in ipairs(art or {}) do
		local copy = {}
		for key, value in pairs(item) do
			copy[key] = value
		end
		copy.file, copy.image = nil, Picture(item.file)
		if item.backdrop then
			local backdrop = {}
			for key, value in pairs(item.backdrop) do
				backdrop[key] = value
			end
			backdrop.bgFile, backdrop.edgeFile = nil, nil
			backdrop.bg, backdrop.edge = Picture(item.backdrop.bgFile), Picture(item.backdrop.edgeFile)
			copy.backdrop = backdrop
		end
		if copy.image or (copy.backdrop and (copy.backdrop.bg or copy.backdrop.edge)) then
			out[#out + 1] = copy
		end
	end
	return out[1] and out or nil
end

Shared.Sorted, Shared.Unquote, Shared.IsList, Shared.Pictures = Sorted, Unquote, IsList, Pictures
Shared.ReadComponent, Shared.ChangeComponent, Shared.ComponentsLua = ReadComponent, ChangeComponent, ComponentsLua
Shared.Encode = function(value)
	local out = {}
	Encode(value, out)
	return table.concat(out)
end
return Shared
