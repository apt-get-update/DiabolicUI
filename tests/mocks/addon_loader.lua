-- Loads the addon's files the way the WoW client does: reads DiabolicUI.toc,
-- follows every <Include> and <Script> of the XML files it lists, in order,
-- and runs each Lua file with the same ("DiabolicUI", addonTable) pair.
--
--   local Loader = require("mocks.addon_loader")
--   local order, missing = Loader.loadOrder()   -- file paths, and referenced files that don't exist
--   local failures = Loader.load(addonTable, createFont)  -- runs them all; returns the errors
--
-- The addon's XML also defines font objects (<Font name=...>). They're in
-- the load order too, as { font = spec } entries, and Loader.load hands
-- them to createFont(spec) when it reaches them, so a Lua file that reads
-- a font at load time finds it, like in game.

local Loader = {}

Loader.ADDON = "DiabolicUI"
Loader.TOC = "DiabolicUI.toc"

local function dirname(path)
	return path:match("^(.*)/[^/]*$") or ""
end

local function joinPath(dir, file)
	file = file:gsub("\\", "/")
	return (dir == "") and file or (dir .. "/" .. file)
end

function Loader.readFile(path)
	local file = io.open(path, "rb")
	if not file then
		return nil
	end
	local text = file:read("*a")
	file:close()
	return text
end

-- Every Lua file in load order, plus any file an XML or the .toc points at
-- that doesn't exist.
function Loader.loadOrder()
	local order, missing = {}, {}

	local function readXml(path)
		local text = Loader.readFile(path)
		if not text then
			table.insert(missing, path)
			return
		end
		text = text:gsub("<!%-%-.-%-%->", "")
		local position = 1
		while true do
			local first, last, tag, attributes, closed = text:find("<(%a+)(%s[^>]-)(/?)>", position)
			if not first then
				break
			end
			position = last + 1
			local file = attributes:match("file%s*=%s*[\"']([^\"']+)[\"']")
			if tag == "Include" and file then
				readXml(joinPath(dirname(path), file))
			elseif tag == "Script" and file then
				table.insert(order, joinPath(dirname(path), file))
			elseif tag == "Font" then
				local body = ""
				if closed == "" then
					local close = text:find("</Font>", position, true)
					body = text:sub(position, (close or position) - 1)
					position = close and (close + 7) or position
				end
				table.insert(order, { font = Loader.parseFont(attributes, body) })
			end
		end
	end

	for line in io.lines(Loader.TOC) do
		line = line:gsub("\r", ""):match("^%s*(.-)%s*$")
		if line ~= "" and not line:match("^#") then
			local path = line:gsub("\\", "/")
			if path:match("%.xml$") then
				readXml(path)
			else
				table.insert(order, path)
			end
		end
	end
	return order, missing
end

-- A <Font> element's attributes and body, as the fields CreateFont and
-- the Font methods take.
function Loader.parseFont(attributes, body)
	local function attr(name)
		return attributes:match(name .. "%s*=%s*[\"']([^\"']*)[\"']")
	end
	local spec = {
		name = attr("name"), inherits = attr("inherits"), font = attr("font"),
		justifyH = attr("justifyH"), justifyV = attr("justifyV"), outline = attr("outline"),
		height = tonumber(body:match("<FontHeight>.-val%s*=%s*[\"']([%d%.]+)")),
	}
	local shadow = body:match("<Shadow>(.-)</Shadow>")
	if shadow then
		spec.shadowOffset = { tonumber(shadow:match("x%s*=%s*[\"']([-%d%.]+)")) or 0, tonumber(shadow:match("y%s*=%s*[\"']([-%d%.]+)")) or 0 }
		body = body:gsub("<Shadow>.-</Shadow>", "")
	end
	local r, g, b = body:match("<Color%s+r%s*=%s*[\"']([%d%.]+)[\"']%s+g%s*=%s*[\"']([%d%.]+)[\"']%s+b%s*=%s*[\"']([%d%.]+)")
	if r then
		spec.color = { tonumber(r), tonumber(g), tonumber(b) }
	end
	return spec
end

-- loadfile, minus the UTF-8 byte order mark some files start with: the
-- client skips it, plain Lua doesn't.
function Loader.loadFile(path)
	local text = Loader.readFile(path)
	if not text then
		return nil, "cannot open " .. path
	end
	text = text:gsub("^\239\187\191", "")
	return loadstring(text, "@" .. path)
end

-- Runs every file in load order. Returns a list of "path: error" strings.
function Loader.load(addonTable, createFont)
	local failures = {}
	for _, entry in ipairs(Loader.loadOrder()) do
		if type(entry) == "table" then
			if createFont then
				createFont(entry.font)
			end
		else
			local chunk, err = Loader.loadFile(entry)
			if chunk then
				local ok, runErr = xpcall(function() return chunk(Loader.ADDON, addonTable) end, function(message)
					return debug.traceback(tostring(message), 2)
				end)
				if not ok then
					table.insert(failures, entry .. ": " .. tostring(runErr))
				end
			elseif Loader.readFile(entry) then
				table.insert(failures, entry .. ": " .. tostring(err))
			end
		end
	end
	return failures
end

return Loader
