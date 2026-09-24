-- A small fake of the WoW frame API, for tests that load code which creates
-- frames at file scope and later drives them through their scripts (the
-- engine's event frame being the main example).
--
-- Every frame shares one metatable, like real frames do, so code that reads
-- `getmetatable(frame).__index` to grab the base frame methods works too.
-- Only the methods listed below exist: there's deliberately no catch-all,
-- so a plain field read such as `frame.eventRegistry` stays nil until the
-- code under test sets it (see "mock permissiveness" in tests/README.md).
--
-- Usage:
--   local FrameMock = require("mocks.frame_mock")
--   local frames = FrameMock.new()      -- fresh registry of created frames
--   _G.CreateFrame = frames.CreateFrame
--   ...
--   frames.created[1]:Fire("OnEvent", "PLAYER_LOGIN")

local FrameMock = {}

local methods = {}
local frameMT = { __index = methods }

local function newFrame(frameType, name, parent)
	return setmetatable({
		frameType = frameType,
		name = name,
		parent = parent,
		events = {},
		scripts = {},
		hooks = {},
		points = {},
		width = 0,
		height = 0,
		frameLevel = 1,
		frameStrata = "MEDIUM",
		scale = 1,
		shown = true,
	}, frameMT)
end

function methods:RegisterEvent(event) self.events[event] = true end
function methods:UnregisterEvent(event) self.events[event] = nil end
function methods:IsEventRegistered(event) return self.events[event] or false end

function methods:SetScript(script, func) self.scripts[script] = func end
function methods:GetScript(script) return self.scripts[script] end
function methods:HookScript(script, func)
	self.hooks[script] = self.hooks[script] or {}
	table.insert(self.hooks[script], func)
end

-- Test helper, not a WoW API: runs a script handler and its hooks the way
-- the client would.
function methods:Fire(script, ...)
	if self.scripts[script] then
		self.scripts[script](self, ...)
	end
	for _, hook in ipairs(self.hooks[script] or {}) do
		hook(self, ...)
	end
end

function methods:SetSize(width, height) self.width, self.height = width, height end
function methods:GetSize() return self.width, self.height end
function methods:SetWidth(width) self.width = width end
function methods:SetHeight(height) self.height = height end
function methods:GetWidth() return self.width end
function methods:GetHeight() return self.height end
function methods:SetScale(scale) self.scale = scale end
function methods:GetScale() return self.scale end
function methods:SetFrameLevel(level) self.frameLevel = level end
function methods:GetFrameLevel() return self.frameLevel end
function methods:SetFrameStrata(strata) self.frameStrata = strata end
function methods:GetFrameStrata() return self.frameStrata end
function methods:SetPoint(...) table.insert(self.points, { ... }) end
function methods:ClearAllPoints() self.points = {} end
function methods:SetAllPoints(target) self.points = { { "ALL", target } } end
function methods:Show() self.shown = true end
function methods:Hide() self.shown = false end
function methods:IsShown() return self.shown end
function methods:SetParent(parent) self.parent = parent end
function methods:GetParent() return self.parent end

-- Regions are frames too, as far as these tests care.
function methods:CreateTexture() return newFrame("Texture", nil, self) end
function methods:CreateFontString() return newFrame("FontString", nil, self) end

-- Returns a fresh registry: its CreateFrame records every frame it makes in
-- `created`, in creation order.
function FrameMock.new()
	local registry = { created = {} }
	registry.CreateFrame = function(frameType, name, parent, template)
		local frame = newFrame(frameType, name, parent)
		frame.template = template
		table.insert(registry.created, frame)
		if name then
			_G[name] = frame
		end
		return frame
	end
	return registry
end

-- A standalone frame, for globals such as UIParent and WorldFrame.
FrameMock.newFrame = newFrame

return FrameMock
