-- A permissive "auto-mock": once installed, any WoW/Blizzard global the
-- addon reads that we haven't explicitly stubbed resolves to a Stub value
-- instead of nil, so `SomeGlobal(...)`, `SomeGlobal:method(...)` and
-- `SomeGlobal .. "text"` all silently succeed (with a meaningless result)
-- instead of erroring with "attempt to call/index/concatenate a nil value".
--
-- This exists purely so that "does this file load without crashing" smoke
-- tests can cover the whole addon without having to individually enumerate
-- every single global every single file touches at load time - that's the
-- one thing a Stub can't safely paper over (see wow_api_mock.lua), because
-- the *type* of value matters there (a real function vs. a real string),
-- but for a load-only smoke test the exact return value never matters.
--
-- Usage: require("mocks.auto_stub").install()
-- Real, meaningful mocks (wow_api_mock, engine_mock, or a test's own fakes)
-- should always be installed/looked up first - this only fills whatever
-- gap is left.

local AutoStub = {}

local Stub = {}
-- A table (itself permissive) rather than a function, so code that grabs
-- the shared frame methods with `getmetatable(frame).__index` - the engine
-- does - gets something it can index, just like with a real frame.
Stub.__index = setmetatable({}, { __index = function() return Stub.new() end })
Stub.__call = function(_, ...) return Stub.new() end
Stub.__concat = function(a, b)
	local function str(v)
		if type(v) == "table" and getmetatable(v) == Stub then
			return ""
		end
		return tostring(v)
	end
	return str(a) .. str(b)
end
Stub.__tostring = function() return "" end
Stub.__unm = function() return Stub.new() end
Stub.__len = function() return 0 end

function Stub.new()
	return setmetatable({}, Stub)
end

AutoStub.Stub = Stub

function AutoStub.install()
	setmetatable(_G, {
		__index = function(_, _) return Stub.new() end,
	})
end

return AutoStub
