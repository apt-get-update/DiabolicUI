-- A minimal stand-in for the addon's "Engine" object, just enough to let a
-- real addon file load standalone under plain Lua (outside the WoW client)
-- so its pure logic can be unit tested. It intentionally does NOT try to
-- reimplement the real engine/engine-core.lua - only the handful of calls
-- addon files make at file-load time (module/handler registration, locale
-- and static-DB lookups), plus the handful of methods our tests call
-- directly on the resulting module table.
--
-- Usage:
--   local EngineMock = require("mocks.engine_mock")
--   local Engine = EngineMock.new()
--   local chunk = assert(loadfile("modules/blizzard/tooltips.lua"))
--   chunk("DiabolicUI", Engine)
--   local Module = Engine:GetModule("Blizzard: Tooltips")

local EngineMock = {}

-- An "infinite mock" value: calling it, indexing it (however deep) or
-- concatenating it with a string all silently succeed instead of erroring,
-- so a file-scope chain like `config.fonts.text_normal.path` or
-- `self:Foo():Bar()` on something we didn't bother mocking is harmless
-- instead of a load error. Same idea as mocks/auto_stub.lua, duplicated
-- narrowly here so this file has no dependency on it.
local Stub = {}
Stub.__index = function() return setmetatable({}, Stub) end
Stub.__call = function() return setmetatable({}, Stub) end
Stub.__concat = function(a, b)
	local function str(v)
		if type(v) == "table" and getmetatable(v) == Stub then return "" end
		return tostring(v)
	end
	return str(a) .. str(b)
end

local function noOp()
	return setmetatable({}, Stub)
end

-- Makes any *undefined* method/field access on `t` resolve to noOp() instead
-- of nil, so a file-scope call to some module/handler setup method we
-- haven't explicitly mocked is a harmless no-op instead of a load error.
-- Real, explicitly defined methods always take priority.
local function permissive(t)
	return setmetatable(t, { __index = function() return noOp() end })
end

local ModuleMT = {}
ModuleMT.__index = ModuleMT
permissive(ModuleMT)

-- Shared constructor for modules, handlers and widgets alike - they're all
-- the same shape of thing in this mock. `engine` is whichever Engine
-- instance created it, so instance methods below can delegate back to it.
local function newModuleInstance(engine, name)
	return setmetatable({ name = name, _engine = engine, widgets = {} }, ModuleMT)
end

-- No-op stand-ins for the handful of module-level setup calls addon files
-- make at file scope (not inside a function body), so loading the file
-- doesn't error before we ever get to the functions we actually want to test.
function ModuleMT:SetIncompatible() end
function ModuleMT:SetWidget(name)
	self.widgets[name] = self.widgets[name] or newModuleInstance(self._engine, name)
	return self.widgets[name]
end
function ModuleMT:GetWidget(name)
	return self.widgets[name]
end

-- Real module/widget/handler objects in the addon can call straight back
-- into the shared Engine's DB/config/handler/module lookups on themselves
-- (e.g. `self.config = self:GetDB("ActionBars")`), not just via `Engine:...`
-- - so those need to delegate to whichever Engine instance created us.
function ModuleMT:GetDB(...) return self._engine:GetDB(...) end
function ModuleMT:GetConfig(...) return self._engine:GetConfig(...) end
function ModuleMT:NewStaticConfig(...) return self._engine:NewStaticConfig(...) end
function ModuleMT:NewConfig(...) return self._engine:NewConfig(...) end
function ModuleMT:GetHandler(...) return self._engine:GetHandler(...) end
function ModuleMT:GetModule(...) return self._engine:GetModule(...) end

function EngineMock.new()
	local modules = {}
	local handlers = {}
	local staticConfigs = {}
	local configs = {}

	-- Every unlisted locale string just returns its own English key, same
	-- fallback behaviour as the real locale_handler.lua.
	local locale = setmetatable({}, { __index = function(_, key) return key end })

	local Engine = {}

	function Engine:NewModule(name)
		local module = newModuleInstance(Engine, name)
		modules[name] = module
		return module
	end

	function Engine:GetModule(name)
		-- Falls back to a permissive stand-in instead of nil for a module
		-- that (from this fresh mock's point of view) was never created -
		-- e.g. a file referencing a sibling module that a smoke test loaded
		-- under its own separate, isolated Engine instance. A real,
		-- targeted test that needs to inspect a specific module should
		-- register it first via Engine:NewModule so this branch isn't hit.
		if not modules[name] then
			modules[name] = newModuleInstance(Engine, name)
		end
		return modules[name]
	end

	function Engine:NewHandler(name)
		local handler = newModuleInstance(Engine, name)
		handlers[name] = handler
		return handler
	end

	function Engine:GetHandler(name)
		if not handlers[name] then
			handlers[name] = newModuleInstance(Engine, name)
		end
		return handlers[name]
	end

	function Engine:GetLocale()
		return locale
	end

	-- Static (non-persisted) per-name config tables, mirroring
	-- Engine:NewStaticConfig / Engine:GetDB in engine/engine-core.lua.
	function Engine:NewStaticConfig(name, config)
		staticConfigs[name] = config
	end

	function Engine:GetDB(name)
		return staticConfigs[name] or permissive({})
	end

	-- Persisted per-name user config tables, mirroring
	-- Engine:NewConfig / Engine:GetConfig in engine/engine-core.lua.
	function Engine:NewConfig(name, config)
		configs[name] = config
	end

	function Engine:GetConfig(name)
		return configs[name] or permissive({})
	end

	function Engine:SetConstant() end
	function Engine:GetConstant() end
	function Engine:RegisterKeyword() end
	function Engine:RegisterKeywordDefault() end
	function Engine:IsBuild() return false end

	-- Used by several files as a base "class" table for their own local
	-- widget/bar prototypes (e.g. `local Bar = Engine:CreateFrame("Frame")`
	-- then `setmetatable(x, { __index = Bar })`) - a permissive table means
	-- any method later called through that chain is a harmless no-op.
	function Engine:CreateFrame()
		return permissive({})
	end

	-- Anything else called on Engine at file scope that we haven't
	-- explicitly mocked above is a harmless no-op instead of a load error.
	return permissive(Engine)
end

return EngineMock
