-- The secure half of the fake WoW client (tests/mocks/client.lua): runs the
-- snippets addons give Blizzard's secure handler templates, the way the
-- client does, in a small restricted environment:
--  - SecureHandlerStateTemplate: "_onstate-<id>" when "state-<id>" changes
--    (a state driver, see client.lua, or a SetAttribute)
--  - SecureHandlerAttributeTemplate: "_onattributechanged" for any other
--    attribute not starting with "_"
--  - SecureHandlerClickTemplate: "_onclick" when clicked
--  - header:Execute(snippet), header:WrapScript(frame, script, pre, post)
--  - handle:RunAttribute, handle:ChildUpdate, control:RunFor
-- Snippets see frames as handles (the restricted methods only), `control`
-- and `owner` (the header running them), and a few safe globals. A method
-- they call on a handle that doesn't exist, or a missing CallMethod
-- target, fails the snippet like in game ("Invalid method 'Name'").

local Widgets = require("mocks.client_widgets")

local Secure = {}

local state = Widgets.state
local client

-- Frame handles -------------------------------------------------------------

local handles = setmetatable({}, { __mode = "k" }) -- frame -> handle
local frames = setmetatable({}, { __mode = "k" }) -- handle -> frame
local handleMethods = {}
local handleMT = { __index = handleMethods, __metatable = false }

local function toHandle(frame)
	if frame == nil then
		return nil
	end
	local handle = handles[frame]
	if not handle then
		handle = setmetatable({}, handleMT)
		handles[frame] = handle
		frames[handle] = frame
	end
	return handle
end
Secure.toHandle = toHandle

local function toFrame(value)
	return frames[value] or value
end

local function frameOf(handle)
	local frame = frames[handle]
	assert(frame, "not a frame handle")
	return frame
end

local runSnippet -- forward

-- The methods restricted code may call on a frame handle.
local function passThrough(name)
	handleMethods[name] = function(handle, ...)
		local frame = frameOf(handle)
		local args, n = { ... }, select("#", ...)
		for i = 1, n do
			args[i] = toFrame(args[i])
		end
		return frame[name](frame, unpack(args, 1, n))
	end
end
for _, name in ipairs({ "Show", "Hide", "IsShown", "IsVisible", "SetWidth", "SetHeight", "GetWidth", "GetHeight",
	"SetPoint", "ClearAllPoints", "SetAllPoints", "SetScale", "GetScale", "SetAlpha", "GetAlpha", "GetID",
	"GetName", "GetFrameLevel", "SetFrameLevel", "GetEffectiveScale", "GetObjectType", "IsObjectType" }) do
	passThrough(name)
end

function handleMethods:GetAttribute(name)
	local value = frameOf(self):GetAttribute(name)
	if type(value) == "table" and state[value] then
		return toHandle(value)
	end
	return value
end

function handleMethods:SetAttribute(name, value)
	frameOf(self):SetAttribute(name, toFrame(value))
end

function handleMethods:GetFrameRef(label)
	return toHandle(frameOf(self):GetAttribute("frameref-" .. label))
end

function handleMethods:GetParent()
	return toHandle(frameOf(self):GetParent())
end

function handleMethods:GetChildren()
	local list = {}
	for _, child in ipairs({ frameOf(self):GetChildren() }) do
		list[#list + 1] = toHandle(child)
	end
	return unpack(list)
end

-- control:CallMethod("Name", ...) runs frame:Name(...) insecurely.
function handleMethods:CallMethod(name, ...)
	local frame = frameOf(self)
	local method = frame[name]
	if type(method) ~= "function" then
		error("Invalid method '" .. tostring(name) .. "'", 2)
	end
	client:Call(method, frame, ...)
end

function handleMethods:RunAttribute(name, ...)
	local frame = frameOf(self)
	return runSnippet(frame, frame:GetAttribute(name), { "self" }, frame, ...)
end

-- control:RunFor(otherHandle, snippet, ...): the snippet with self = other.
function handleMethods:RunFor(other, snippet, ...)
	return runSnippet(frameOf(self), snippet, { "self" }, frameOf(other), ...)
end

function handleMethods:Run(snippet, ...)
	local frame = frameOf(self)
	return runSnippet(frame, snippet, { "self" }, frame, ...)
end

-- Runs "_childupdate-<id>" (or "_childupdate") on every child that has one.
function handleMethods:ChildUpdate(id, message)
	for _, child in ipairs({ frameOf(self):GetChildren() }) do
		local snippet = child:GetAttribute("_childupdate-" .. tostring(id)) or child:GetAttribute("_childupdate")
		if snippet then
			runSnippet(child, snippet, { "self", "scriptid", "message" }, child, id, message)
		end
	end
end

-- Auto hide: the frame hides itself once the mouse has been away from it
-- (and the frames added to it) for `duration` seconds.
function handleMethods:RegisterAutoHide(duration)
	local frame = frameOf(self)
	state[frame].autoHide = { duration = tonumber(duration) or 0, frames = { [frame] = true } }
	client.autoHideFrames[frame] = true
end

function handleMethods:UnregisterAutoHide()
	state[frameOf(self)].autoHide = nil
	client.autoHideFrames[frameOf(self)] = nil
end

function handleMethods:AddToAutoHide(other)
	local autoHide = state[frameOf(self)].autoHide
	if autoHide then
		autoHide.frames[frameOf(other)] = true
	end
end

-- Override bindings owned by the frame
function handleMethods:SetBinding(priority, key, action)
	client.api.SetOverrideBinding(frameOf(self), priority, key, action)
end

function handleMethods:SetBindingClick(priority, key, name, button)
	client.api.SetOverrideBindingClick(frameOf(self), priority, key, name, button)
end

function handleMethods:ClearBindings()
	client.api.ClearOverrideBindings(frameOf(self))
end

-- Running snippets -----------------------------------------------------------

local compiled = {} -- "<args>\0<code>" -> chunk

local function compile(code, argNames)
	local key = table.concat(argNames, ",") .. "\0" .. code
	local chunk = compiled[key]
	if not chunk then
		-- the named arguments, then the rest as the snippet's own `...`
		local err
		chunk, err = loadstring("local " .. table.concat(argNames, ", ") .. " = ...\n"
			.. "return (function(...)\n" .. code .. "\nend)(select(" .. (#argNames + 1) .. ", ...))", "=(snippet)")
		assert(chunk, "snippet: " .. tostring(err))
		compiled[key] = chunk
	end
	return chunk
end

-- The globals restricted code can read: 3.3.5's RestrictedExecution.lua
-- (the table functions) and RestrictedEnvironment.lua (the rest).
local RESTRICTED_NAMES = {
	-- string and math functions
	"format", "gmatch", "gsub", "strbyte", "strchar", "strconcat", "strfind", "strjoin", "strlen",
	"strlower", "strmatch", "strrep", "strrev", "strsplit", "strsub", "strtrim", "strupper",
	"abs", "acos", "asin", "atan", "atan2", "ceil", "cos", "deg", "exp", "floor", "frexp", "ldexp",
	"log", "log10", "max", "min", "mod", "rad", "random", "sin", "tan",
}
local RESTRICTED_API_NAMES = {
	-- the macro conditional functions
	"SecureCmdOptionParse", "GetShapeshiftForm", "IsStealthed", "UnitExists", "UnitIsDead", "UnitIsGhost",
	"UnitPlayerOrPetInParty", "UnitPlayerOrPetInRaid", "IsRightAltKeyDown", "IsLeftAltKeyDown", "IsAltKeyDown",
	"IsRightControlKeyDown", "IsLeftControlKeyDown", "IsControlKeyDown", "IsLeftShiftKeyDown",
	"IsRightShiftKeyDown", "IsShiftKeyDown", "IsModifierKeyDown", "IsModifiedClick", "GetMouseButtonClicked",
	"GetActionBarPage", "GetBonusBarOffset", "IsMounted", "IsSwimming", "IsFlying", "IsFlyableArea",
	"IsIndoors", "IsOutdoors",
	-- the other safe ones
	"GetBindingKey", "HasAction", "IsHarmfulSpell", "IsHarmfulItem", "IsHelpfulSpell", "IsHelpfulItem",
	"GetMultiCastTotemSpells", "GetActionInfo",
}

local function restrictedGlobals(header)
	local api = client.api
	local env = {
		control = toHandle(header), owner = toHandle(header),
		newtable = function(...) return { ... } end, pairs = pairs, ipairs = ipairs, next = next,
		unpack = unpack, wipe = _G.wipe, tinsert = table.insert, tremove = table.remove, type = type,
		rtgsub = string.gsub,
		table = { maxn = table.maxn, insert = table.insert, remove = table.remove, sort = table.sort,
			concat = table.concat, wipe = _G.wipe },
		math = math, string = string, select = select, tonumber = tonumber, tostring = tostring, print = print,
		PlayerInCombat = function() return api.InCombatLockdown() end,
		PlayerCanAttack = function(unit) return api.UnitCanAttack("player", unit) end,
		PlayerCanAssist = function(unit) return api.UnitCanAssist("player", unit) end,
		PlayerInGroup = function()
			return (api.GetNumRaidMembers() > 0 and "raid") or (api.GetNumPartyMembers() > 0 and "party")
		end,
		UnitHasVehicleUI = api.UnitHasVehicleUI,
		RegisterStateDriver = function(handle, ...) return _G.RegisterStateDriver(toFrame(handle), ...) end,
	}
	for _, name in ipairs(RESTRICTED_NAMES) do
		env[name] = _G[name]
	end
	for _, name in ipairs(RESTRICTED_API_NAMES) do
		env[name] = api[name]
	end
	return env
end

-- Runs `code` for `header` (the frame whose snippet it is: control and
-- owner), with the named arguments, the first being self's frame.
function runSnippet(header, code, argNames, selfFrame, ...)
	if code == nil or code == "" then
		return
	end
	assert(type(code) == "string", "snippets are strings")
	local chunk = compile(code, argNames)
	local env = restrictedGlobals(header)
	setmetatable(env, { __index = function(_, key)
		client.missing["(snippet) " .. tostring(key)] = true
		return nil
	end })
	setfenv(chunk, env)
	local results
	client:Secure(function(...)
		local args, n = { ... }, select("#", ...)
		results = { chunk(toHandle(selfFrame), unpack(args, 1, n)) }
	end, ...)
	return unpack(results or {})
end

-- Runs a snippet protected: a failing snippet is recorded, like in game.
local function runProtected(header, code, argNames, selfFrame, ...)
	local args, n = { ... }, select("#", ...)
	local results
	client:Call(function()
		results = { runSnippet(header, code, argNames, selfFrame, unpack(args, 1, n)) }
	end)
	return unpack(results or {})
end
Secure.run = runProtected

-- Hooks called by the widgets ------------------------------------------------

-- After an attribute changed on a frame (SetAttribute).
function Secure.attributeChanged(frame, name, value)
	local s = state[frame]
	local templates = s.secureTemplates
	if not templates or type(name) ~= "string" then
		return
	end
	local stateId = name:match("^state%-(.+)$")
	if stateId and templates.SecureHandlerStateTemplate then
		runProtected(frame, s.attributes["_onstate-" .. stateId], { "self", "stateid", "newstate" }, frame, stateId, value)
	end
	if templates.SecureHandlerAttributeTemplate and name:sub(1, 1) ~= "_" then
		runProtected(frame, s.attributes._onattributechanged, { "self", "name", "value" }, frame, name, value)
	end
end

-- The click handler SecureHandlerClickTemplate frames start with.
function Secure.onClick(frame, button, down)
	runProtected(frame, state[frame].attributes._onclick, { "self", "button", "down" }, frame, button, down)
end

-- header:WrapScript(frame, script, pre, post): the pre snippet runs before
-- the frame's handler, which it cancels by returning false; post after it.
function Secure.runWrapped(frame, script, handler, ...)
	local wrap = state[frame].wrapped and state[frame].wrapped[script]
	if not wrap then
		return handler(...)
	end
	local header, pre, post = wrap.header, wrap.pre, wrap.post
	local proceed = runProtected(header, pre, { "self", "button", "down" }, frame, select(2, ...))
	if proceed == false then
		return
	end
	handler(...)
	if post then
		runProtected(header, post, { "self", "message", "button" }, frame, nil, select(2, ...))
	end
end

-- The methods SecureHandler*Template frames have.
function Secure.headerMethods()
	return {
		Execute = function(self, snippet)
			assert(type(snippet) == "string", "Execute: snippet must be a string")
			runProtected(self, snippet, { "self" }, self)
		end,
		WrapScript = function(self, frame, script, pre, post)
			assert(pre == nil or type(pre) == "string", "WrapScript: bad snippet")
			state[frame].wrapped = state[frame].wrapped or {}
			state[frame].wrapped[script] = { header = self, pre = pre, post = post }
			-- a wrapped script runs even when the frame had no handler
			if not frame:GetScript(script) then
				frame:SetScript(script, function() end)
			end
		end,
		UnwrapScript = function(self, frame, script)
			if state[frame].wrapped then
				state[frame].wrapped[script] = nil
			end
		end,
		SetFrameRef = function(self, label, frame)
			self:SetAttribute("frameref-" .. label, frame)
		end,
	}
end

-- Auto hide, checked every frame (see client:Tick).
function Secure.updateAutoHide(elapsed)
	for frame in pairs(client.autoHideFrames) do
		local autoHide = state[frame].autoHide
		if autoHide and frame:IsShown() then
			local over = false
			for member in pairs(autoHide.frames) do
				if member:IsMouseOver() then
					over = true
				end
			end
			if over then
				autoHide.away = 0
			else
				autoHide.away = (autoHide.away or 0) + elapsed
				if autoHide.away >= autoHide.duration then
					autoHide.away = 0
					client:Secure(frame.Hide, frame)
				end
			end
		end
	end
end

function Secure.attach(owner)
	client = owner
	-- the last boot's handles let go (each table's value keeps the other's
	-- key alive: Lua 5.1's weak keys aren't ephemerons)
	for frame in pairs(handles) do
		handles[frame] = nil
	end
	for handle in pairs(frames) do
		frames[handle] = nil
	end
end

return Secure
