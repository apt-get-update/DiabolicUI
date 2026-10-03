-- The widget half of the fake WoW client (tests/mocks/client.lua): frames,
-- textures, font strings, tooltips, animations, with the 3.3.5 method set.
--
-- Each widget keeps its real state (points, size, text, values, scripts...)
-- in a private table, so an addon field such as `frame.shown` or
-- `frame.text` never collides with it. A method the widget type doesn't
-- have in 3.3.5 is simply missing, so calling one fails the way it would
-- in game ("attempt to call method 'SetShown' (a nil value)").
--
-- Scripts run through client.RunScript, which catches and records errors
-- the way the client hands them to the error handler: the caller carries on.

local Widgets = {}

local state = setmetatable({}, { __mode = "k" }) -- widget -> private state
Widgets.state = state

local client -- set by Widgets.attach

-- Like in game, every widget table holds a userdata at [0], and that is
-- what the client goes by: a plain copy of a frame table (the engine
-- deep-copies static configs holding UIParent) still works as an anchor
-- or parent.
local handles = setmetatable({}, { __mode = "v" }) -- userdata -> widget

local function resolve(value)
	if type(value) == "table" and not state[value] then
		local handle = rawget(value, 0)
		if handle ~= nil and handles[handle] then
			return handles[handle]
		end
	end
	return value
end
Widgets.resolve = resolve

function Widgets.attach(owner)
	client = owner
end

-- The frames combat lockdown protects: every method below refuses to run on
-- a protected frame in combat, like the real client (ADDON_ACTION_BLOCKED).
local RESTRICTED = {
	Show = true, Hide = true, SetPoint = true, ClearAllPoints = true, SetAllPoints = true,
	SetParent = true, SetWidth = true, SetHeight = true, SetSize = true, SetScale = true,
	SetAttribute = true,
}

local classes = {}
Widgets.classes = classes

local function newClass(name, ...)
	local methods = {}
	for i = 1, select("#", ...) do
		for key, value in pairs(classes[select(i, ...)].methods) do
			methods[key] = value
		end
	end
	local class = { name = name, methods = methods, meta = { __index = methods }, isA = { [name] = true } }
	for i = 1, select("#", ...) do
		for parentName in pairs(classes[select(i, ...)].isA) do
			class.isA[parentName] = true
		end
	end
	classes[name] = class
	return methods
end

-- Adds methods to a class and every class built from it later.
local function define(methods, list)
	for key, value in pairs(list) do
		methods[key] = value
	end
end

-- Color setters take numbers: the client reads anything else as 0 (a table
-- passed as the color makes it black and opaque), so a test fails instead.
local function checkColor(method, r, g, b)
	assert(type(r) == "number" and type(g) == "number" and type(b) == "number",
		method .. ": r, g and b must be numbers, got " .. type(r) .. ", " .. type(g) .. ", " .. type(b))
end

local function guard(self, method)
	local s = state[self]
	if s and s.protected and client and client.world.inCombat and not client.secureContext and RESTRICTED[method] then
		client:Blocked(self, method)
		return true
	end
end

local function wrapRestricted(methods)
	for name in pairs(RESTRICTED) do
		local original = methods[name]
		if original then
			methods[name] = function(self, ...)
				if guard(self, name) then
					return
				end
				return original(self, ...)
			end
		end
	end
end

------------------------------------------------------------------------
-- UIObject / Region
------------------------------------------------------------------------

local UIObject = newClass("UIObject")

define(UIObject, {
	GetName = function(self) return state[self].name end,
	GetObjectType = function(self) return state[self].class.name end,
	IsObjectType = function(self, name)
		return state[self].class.isA[name] or false
	end,
	GetParent = function(self) return state[self].parent end,
	IsForbidden = function() return false end,
	GetAlpha = function(self) return state[self].alpha end,
	SetAlpha = function(self, alpha)
		assert(type(alpha) == "number", "SetAlpha: alpha must be a number")
		state[self].alpha = math.max(0, math.min(1, alpha))
	end,
})

local function isVisible(widget)
	local s = state[widget]
	while s do
		if not s.shown then
			return false
		end
		if not s.parent then
			return true
		end
		s = state[s.parent]
	end
	return true
end
Widgets.isVisible = isVisible

-- Fires OnShow / OnHide on a widget and every shown descendant whose
-- visibility just changed.
local function propagateVisibility(widget, visible, script)
	local s = state[widget]
	if s.scripts then
		client:RunScript(widget, script)
	end
	for child in pairs(s.children or {}) do
		if state[child].shown then
			propagateVisibility(child, visible, script)
		end
	end
end

local function setShown(self, shown)
	local s = state[self]
	local was = isVisible(self)
	s.shown = shown and true or false
	local now = isVisible(self)
	if was ~= now then
		propagateVisibility(self, now, now and "OnShow" or "OnHide")
	end
end

local function setParent(self, parent)
	if type(parent) == "string" then
		parent = _G[parent]
	end
	parent = resolve(parent)
	local s = state[self]
	local was = isVisible(self)
	if s.parent and state[s.parent] and state[s.parent].children then
		state[s.parent].children[self] = nil
	end
	s.parent = parent
	if parent and state[parent] and state[parent].children then
		state[parent].children[self] = true
	end
	local now = isVisible(self)
	if was ~= now then
		propagateVisibility(self, now, now and "OnShow" or "OnHide")
	end
end
Widgets.setParent = setParent

------------------------------------------------------------------------
-- Layout: a small anchor solver, enough for GetCenter/GetLeft/... to give
-- sensible numbers.
------------------------------------------------------------------------

local POINT_OFFSETS = {
	TOPLEFT = { 0, 1 }, TOP = { 0.5, 1 }, TOPRIGHT = { 1, 1 },
	LEFT = { 0, 0.5 }, CENTER = { 0.5, 0.5 }, RIGHT = { 1, 0.5 },
	BOTTOMLEFT = { 0, 0 }, BOTTOM = { 0.5, 0 }, BOTTOMRIGHT = { 1, 0 },
}

local function normalizePoint(self, point, relativeTo, relativePoint, x, y)
	assert(type(point) == "string" and POINT_OFFSETS[point:upper()], "SetPoint: bad point " .. tostring(point))
	point = point:upper()
	if type(relativeTo) == "number" then
		relativeTo, relativePoint, x, y = nil, nil, relativeTo, relativePoint
	elseif type(relativeTo) == "string" and POINT_OFFSETS[relativeTo:upper()] and relativePoint == nil then
		-- SetPoint("TOP", "BOTTOM")? not valid; treat as a frame name
		relativeTo = _G[relativeTo]
	elseif type(relativeTo) == "string" then
		local name = relativeTo:gsub("%$parent", state[self].parent and state[state[self].parent] and (state[state[self].parent].name or "") or "")
		relativeTo = _G[name]
		assert(relativeTo, "SetPoint: unknown frame " .. name)
	end
	if type(relativePoint) == "number" then
		relativePoint, x, y = nil, relativePoint, x
	end
	relativeTo = resolve(relativeTo)
	if relativeTo ~= nil then
		assert(state[relativeTo], "SetPoint: relativeTo isn't a widget: " .. tostring(relativeTo) .. " (" .. type(relativeTo) .. ")")
		assert(relativeTo ~= self, "SetPoint: can't anchor to itself")
	end
	relativeTo = relativeTo or state[self].parent
	relativePoint = relativePoint and relativePoint:upper() or point
	assert(POINT_OFFSETS[relativePoint], "SetPoint: bad relative point " .. tostring(relativePoint))
	return point, relativeTo, relativePoint, x or 0, y or 0
end

local rectOf, stretchedSize

local function sizeOf(widget)
	local s = state[widget]
	local w, h = s.width, s.height
	if (w == 0 or h == 0) and s.allPoints then
		local _, _, rw, rh = rectOf(s.allPoints)
		rw, rh = rw or 0, rh or 0
		if w == 0 then w = rw end
		if h == 0 then h = rh end
	end
	if (w == 0 or h == 0) and s.class.isA.FontString and s.text then
		if w == 0 then w = #tostring(s.text) * 6 end
		if h == 0 then h = 12 end
	end
	return w, h
end

local depth = 0
function rectOf(widget)
	local s = state[widget]
	if s.isScreen then
		return 0, 0, s.width, s.height
	end
	depth = depth + 1
	if depth > 40 then
		depth = depth - 1
		return 0, 0, 0, 0
	end
	local w, h = sizeOf(widget)
	local left, bottom
	if s.allPoints then
		local l, b, rw, rh = rectOf(s.allPoints)
		depth = depth - 1
		if not l then return nil end
		return l, b, rw, rh
	end
	local anchor = s.points[1]
	if anchor then
		local point, relativeTo, relativePoint, x, y = unpack(anchor)
		local rl, rb, rw, rh = 0, 0, 0, 0
		if relativeTo and state[relativeTo] then
			rl, rb, rw, rh = rectOf(relativeTo)
			if not rl then
				depth = depth - 1
				return nil -- anchored to something that isn't placed
			end
		end
		local ro, po = POINT_OFFSETS[relativePoint], POINT_OFFSETS[point]
		local ax, ay = rl + rw * ro[1] + x, rb + rh * ro[2] + y
		left, bottom = ax - w * po[1], ay - h * po[2]
		-- a second point on the other side stretches the frame
		local other = s.points[2]
		if other and (w == 0 or h == 0) then
			local p2, rel2, rp2, x2, y2 = unpack(other)
			local l2, b2, w2, h2 = 0, 0, 0, 0
			if rel2 and state[rel2] then
				l2, b2, w2, h2 = rectOf(rel2)
				l2, b2, w2, h2 = l2 or 0, b2 or 0, w2 or 0, h2 or 0
			end
			local o2, q2 = POINT_OFFSETS[rp2], POINT_OFFSETS[p2]
			local bx, by = l2 + w2 * o2[1] + x2, b2 + h2 * o2[2] + y2
			if w == 0 and q2[1] ~= po[1] then
				w = math.abs(bx - ax)
				left = math.min(ax, bx)
			end
			if h == 0 and q2[2] ~= po[2] then
				h = math.abs(by - ay)
				bottom = math.min(ay, by)
			end
		end
	end
	depth = depth - 1
	if not left then
		return nil
	end
	return left, bottom, w, h
end
Widgets.rectOf = rectOf

-- The size, counting a size the frame only gets from two anchor points.
function stretchedSize(widget)
	local w, h = sizeOf(widget)
	if (w == 0 or h == 0) and #state[widget].points >= 2 then
		local _, _, rw, rh = rectOf(widget)
		if w == 0 then w = rw or 0 end
		if h == 0 then h = rh or 0 end
	end
	return w, h
end

local Region = newClass("Region", "UIObject")

define(Region, {
	SetParent = setParent,
	Show = function(self) setShown(self, true) end,
	Hide = function(self) setShown(self, false) end,
	IsShown = function(self) return state[self].shown and 1 or nil end,
	IsVisible = function(self) return isVisible(self) and 1 or nil end,
	SetPoint = function(self, ...)
		local point, relativeTo, relativePoint, x, y = normalizePoint(self, ...)
		local s = state[self]
		s.allPoints = nil
		for i, existing in ipairs(s.points) do
			if existing[1] == point then
				s.points[i] = { point, relativeTo, relativePoint, x, y }
				return
			end
		end
		s.points[#s.points + 1] = { point, relativeTo, relativePoint, x, y }
	end,
	SetAllPoints = function(self, relativeTo)
		if type(relativeTo) == "string" then
			relativeTo = _G[relativeTo]
		end
		relativeTo = resolve(relativeTo)
		local s = state[self]
		s.points = {}
		s.allPoints = relativeTo or s.parent
	end,
	ClearAllPoints = function(self)
		local s = state[self]
		s.points = {}
		s.allPoints = nil
	end,
	GetNumPoints = function(self)
		local s = state[self]
		return s.allPoints and 2 or #s.points
	end,
	GetPoint = function(self, index)
		local s = state[self]
		if s.allPoints then
			return "TOPLEFT", s.allPoints, "TOPLEFT", 0, 0
		end
		local p = s.points[index or 1]
		if p then
			return p[1], p[2], p[3], p[4], p[5]
		end
	end,
	SetWidth = function(self, width)
		assert(type(width) == "number", "SetWidth: width must be a number")
		state[self].width = width
		if state[self].scripts then client:RunScript(self, "OnSizeChanged", sizeOf(self)) end
	end,
	SetHeight = function(self, height)
		assert(type(height) == "number", "SetHeight: height must be a number")
		state[self].height = height
		if state[self].scripts then client:RunScript(self, "OnSizeChanged", sizeOf(self)) end
	end,
	SetSize = function(self, width, height)
		assert(type(width) == "number" and type(height) == "number", "SetSize: needs two numbers")
		state[self].width, state[self].height = width, height
		if state[self].scripts then client:RunScript(self, "OnSizeChanged", width, height) end
	end,
	GetWidth = function(self) return (stretchedSize(self)) end,
	GetHeight = function(self) return select(2, stretchedSize(self)) end,
	GetSize = function(self) return stretchedSize(self) end,
	GetRect = function(self) return rectOf(self) end,
	GetLeft = function(self) return (rectOf(self)) end,
	GetBottom = function(self) return select(2, rectOf(self)) end,
	GetRight = function(self)
		local l, _, w = rectOf(self)
		return l and l + w
	end,
	GetTop = function(self)
		local l, b, _, h = rectOf(self)
		return l and b + h
	end,
	GetCenter = function(self)
		local l, b, w, h = rectOf(self)
		if l then
			return l + w / 2, b + h / 2
		end
	end,
	CreateAnimationGroup = function(self, name)
		return Widgets.new("AnimationGroup", name, self)
	end,
	StopAnimating = function(self)
		for group in pairs(client.playing) do
			if state[group].parent == self then
				group:Stop()
			end
		end
	end,
	IsProtected = function(self) return state[self].protected and 1 or nil, state[self].protected and 1 or nil end,
	CanChangeProtectedState = function(self) return not (client.world.inCombat and state[self].protected) end,
	IsMouseOver = function(self)
		local focus = client.mouseFocus
		while focus do
			if focus == self then return 1 end
			focus = state[focus] and state[focus].parent
		end
		return nil
	end,
	GetEffectiveScale = function(self)
		local scale, s = 1, state[self]
		while s do
			scale = scale * (s.scale or 1)
			s = s.parent and state[s.parent]
		end
		return scale
	end,
})

local LayeredRegion = newClass("LayeredRegion", "Region")

define(LayeredRegion, {
	SetDrawLayer = function(self, layer, sublevel)
		state[self].drawLayer, state[self].subLevel = layer, sublevel
	end,
	GetDrawLayer = function(self) return state[self].drawLayer or "ARTWORK", state[self].subLevel or 0 end,
	SetVertexColor = function(self, r, g, b, a)
		checkColor("SetVertexColor", r, g, b)
		state[self].vertexColor = { r, g, b, a or 1 }
	end,
	GetVertexColor = function(self)
		local c = state[self].vertexColor or { 1, 1, 1, 1 }
		return c[1], c[2], c[3], c[4]
	end,
})

------------------------------------------------------------------------
-- Texture
------------------------------------------------------------------------

local Texture = newClass("Texture", "LayeredRegion")

define(Texture, {
	SetTexture = function(self, texture, ...)
		local s = state[self]
		if type(texture) == "number" then
			s.texture, s.color = nil, { texture, ... }
		else
			s.texture, s.color = texture, nil
		end
		return texture ~= nil and 1 or nil
	end,
	GetTexture = function(self) return state[self].texture end,
	SetTexCoord = function(self, ...)
		local n = select("#", ...)
		assert(n == 4 or n == 8, "SetTexCoord: needs 4 or 8 numbers")
		state[self].texCoord = { ... }
	end,
	GetTexCoord = function(self)
		local c = state[self].texCoord or { 0, 1, 0, 1 }
		if #c == 4 then
			return c[1], c[3], c[1], c[4], c[2], c[3], c[2], c[4]
		end
		return unpack(c)
	end,
	-- 1 when it worked: without shader support (world.noShaders) it can't
	SetDesaturated = function(self, flag)
		if client.world.noShaders then
			state[self].desaturated = false
			return nil
		end
		state[self].desaturated = flag and true or false
		return 1
	end,
	IsDesaturated = function(self) return state[self].desaturated and 1 or nil end,
	SetBlendMode = function(self, mode) state[self].blendMode = mode end,
	GetBlendMode = function(self) return state[self].blendMode or "BLEND" end,
	SetGradient = function() end,
	SetGradientAlpha = function() end,
	SetRotation = function(self, radians) state[self].rotation = radians end,
	SetNonBlocking = function() end,
	GetNonBlocking = function() return nil end,
})

------------------------------------------------------------------------
-- Fonts: Font objects, FontStrings, and the font methods other widgets share
------------------------------------------------------------------------

local fontMethods = {
	SetFont = function(self, path, size, flags)
		assert(type(path) == "string", "SetFont: path must be a string")
		local s = state[self]
		s.font = { path, size or 12, flags or "" }
		return 1
	end,
	GetFont = function(self)
		local s = state[self]
		if s.font then
			return s.font[1], s.font[2], s.font[3]
		end
		if s.fontObject and state[s.fontObject] then
			return s.fontObject:GetFont()
		end
		return "Fonts\\FRIZQT__.TTF", 12, ""
	end,
	SetFontObject = function(self, font)
		if type(font) == "string" then
			font = _G[font]
		end
		font = resolve(font)
		assert(font == nil or state[font], "SetFontObject: not a font")
		local s = state[self]
		s.fontObject, s.font = font, nil
	end,
	GetFontObject = function(self) return state[self].fontObject end,
	SetTextColor = function(self, r, g, b, a) checkColor("SetTextColor", r, g, b) state[self].textColor = { r, g, b, a or 1 } end,
	GetTextColor = function(self)
		local c = state[self].textColor or { 1, 1, 1, 1 }
		return c[1], c[2], c[3], c[4]
	end,
	SetShadowColor = function(self, r, g, b, a) checkColor("SetShadowColor", r, g, b) state[self].shadowColor = { r, g, b, a or 1 } end,
	GetShadowColor = function(self)
		local c = state[self].shadowColor or { 0, 0, 0, 0 }
		return c[1], c[2], c[3], c[4]
	end,
	SetShadowOffset = function(self, x, y) state[self].shadowOffset = { x, y } end,
	GetShadowOffset = function(self)
		local o = state[self].shadowOffset or { 0, 0 }
		return o[1], o[2]
	end,
	SetJustifyH = function(self, justify) state[self].justifyH = justify end,
	GetJustifyH = function(self) return state[self].justifyH or "CENTER" end,
	SetJustifyV = function(self, justify) state[self].justifyV = justify end,
	GetJustifyV = function(self) return state[self].justifyV or "MIDDLE" end,
	SetSpacing = function(self, spacing) state[self].spacing = spacing end,
	GetSpacing = function(self) return state[self].spacing or 0 end,
	-- 3.3's chat frames indent wrapped lines (FrameXML's indented="true")
	SetIndentedWordWrap = function(self, wrap) state[self].indentedWordWrap = wrap end,
	GetIndentedWordWrap = function(self) return state[self].indentedWordWrap and 1 or nil end,
}

local Font = newClass("Font", "UIObject")
define(Font, fontMethods)
define(Font, {
	CopyFontObject = function(self, other)
		if type(other) == "string" then other = _G[other] end
		other = resolve(other)
		local o = state[other]
		local s = state[self]
		s.font = { other:GetFont() }
		s.textColor = o.textColor
		s.shadowColor = o.shadowColor
		s.shadowOffset = o.shadowOffset
	end,
})

local FontString = newClass("FontString", "LayeredRegion")
define(FontString, fontMethods)

define(FontString, {
	SetText = function(self, text)
		if text ~= nil then
			text = tostring(text)
		end
		state[self].text = text
	end,
	GetText = function(self) return state[self].text end,
	SetFormattedText = function(self, fmt, ...)
		state[self].text = string.format(fmt, ...)
	end,
	GetStringWidth = function(self)
		local text = state[self].text or ""
		text = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "  ")
		return #text * 6
	end,
	GetStringHeight = function(self)
		local text = state[self].text or ""
		local _, lines = text:gsub("\n", "")
		return 12 * (lines + 1)
	end,
	SetWordWrap = function(self, wrap) state[self].wordWrap = wrap end,
	CanWordWrap = function(self) return state[self].wordWrap ~= false and 1 or nil end,
	SetNonSpaceWrap = function(self, wrap) state[self].nonSpaceWrap = wrap end,
	CanNonSpaceWrap = function(self) return state[self].nonSpaceWrap and 1 or nil end,
	SetAlphaGradient = function() return nil end,
	SetTextHeight = function(self, height) state[self].textHeight = height end,
	IsTruncated = function() return nil end,
})

------------------------------------------------------------------------
-- Animations
------------------------------------------------------------------------

local ANIMATION_SCRIPTS = { OnPlay = true, OnFinished = true, OnStop = true, OnUpdate = true, OnLoop = true, OnPause = true }

local scriptMethods = {
	SetScript = function(self, script, func)
		local s = state[self]
		assert(type(script) == "string", "SetScript: script name must be a string")
		assert(func == nil or type(func) == "function", "SetScript: handler must be a function or nil")
		assert(s.class.validScripts == nil or s.class.validScripts[script],
			s.class.name .. " doesn't have a \"" .. script .. "\" script")
		s.scripts[script] = func
		s.hooks[script] = nil
		if script == "OnUpdate" and func then
			client.updaters[self] = true
		end
	end,
	GetScript = function(self, script)
		return state[self].scripts[script]
	end,
	HookScript = function(self, script, func)
		local s = state[self]
		assert(type(func) == "function", "HookScript: handler must be a function")
		assert(s.class.validScripts == nil or s.class.validScripts[script],
			s.class.name .. " doesn't have a \"" .. script .. "\" script")
		if script == "OnUpdate" then
			client.updaters[self] = true
		end
		if not s.scripts[script] then
			s.scripts[script] = func
			return
		end
		s.hooks[script] = s.hooks[script] or {}
		table.insert(s.hooks[script], func)
	end,
	HasScript = function(self, script)
		local s = state[self]
		return (s.class.validScripts == nil or s.class.validScripts[script]) and 1 or nil
	end,
}
Widgets.scriptMethods = scriptMethods

local AnimationGroup = newClass("AnimationGroup", "UIObject")
classes.AnimationGroup.validScripts = ANIMATION_SCRIPTS
define(AnimationGroup, scriptMethods)
define(AnimationGroup, {
	CreateAnimation = function(self, animationType, name)
		local anim = Widgets.new(animationType or "Animation", name, self)
		table.insert(state[self].animations, anim)
		return anim
	end,
	GetAnimations = function(self) return unpack(state[self].animations) end,
	Play = function(self)
		local s = state[self]
		s.playing, s.elapsed = true, 0
		client.playing[self] = true
		client:RunScript(self, "OnPlay")
	end,
	Stop = function(self)
		local s = state[self]
		if s.playing then
			s.playing = false
			client.playing[self] = nil
			client:RunScript(self, "OnStop")
		end
	end,
	Finish = function(self)
		local s = state[self]
		if s.playing then
			s.playing = false
			client.playing[self] = nil
			client:RunScript(self, "OnFinished")
		end
	end,
	Pause = function(self)
		state[self].playing = false
		client.playing[self] = nil
	end,
	IsPlaying = function(self) return state[self].playing and 1 or nil end,
	IsPaused = function() return nil end,
	IsDone = function(self) return not state[self].playing and 1 or nil end,
	SetLooping = function(self, looping) state[self].looping = looping end,
	GetLooping = function(self) return state[self].looping or "NONE" end,
	GetProgress = function(self)
		local s = state[self]
		local total = Widgets.animationDuration(self)
		return total > 0 and math.min(1, (s.elapsed or 0) / total) or 0
	end,
	GetDuration = function(self) return Widgets.animationDuration(self) end,
})

function Widgets.animationDuration(group)
	local total = 0
	for _, anim in ipairs(state[group].animations) do
		local a = state[anim]
		total = math.max(total, (a.startDelay or 0) + (a.duration or 0) + (a.endDelay or 0))
	end
	return total
end

-- Called from client:Tick for every playing group.
function Widgets.advanceAnimation(group, elapsed)
	local s = state[group]
	s.elapsed = (s.elapsed or 0) + elapsed
	client:RunScript(group, "OnUpdate", elapsed)
	for _, anim in ipairs(s.animations) do
		client:RunScript(anim, "OnUpdate", elapsed)
	end
	if not s.playing then
		return
	end
	local total = Widgets.animationDuration(group)
	if s.elapsed >= total then
		for _, anim in ipairs(s.animations) do
			client:RunScript(anim, "OnFinished")
		end
		if s.looping and s.looping ~= "NONE" then
			s.elapsed = 0
			client:RunScript(group, "OnLoop", "FORWARD")
		else
			s.playing = false
			client.playing[group] = nil
			client:RunScript(group, "OnFinished")
		end
	end
end

local Animation = newClass("Animation", "UIObject")
classes.Animation.validScripts = ANIMATION_SCRIPTS
define(Animation, scriptMethods)
define(Animation, {
	SetDuration = function(self, duration) state[self].duration = duration end,
	GetDuration = function(self) return state[self].duration or 0 end,
	SetStartDelay = function(self, delay) state[self].startDelay = delay end,
	GetStartDelay = function(self) return state[self].startDelay or 0 end,
	SetEndDelay = function(self, delay) state[self].endDelay = delay end,
	SetOrder = function(self, order) state[self].order = order end,
	GetOrder = function(self) return state[self].order or 1 end,
	SetSmoothing = function(self, smoothing) state[self].smoothing = smoothing end,
	SetMaxFramerate = function() end,
	GetRegionParent = function(self) return state[state[self].parent].parent end,
	Play = function(self) state[self].playing = true end,
	Stop = function(self) state[self].playing = false end,
	IsPlaying = function(self) return state[self].playing and 1 or nil end,
	GetProgress = function() return 0 end,
	GetElapsed = function() return 0 end,
})

newClass("Alpha", "Animation")
define(classes.Alpha.methods, { SetChange = function(self, change) state[self].change = change end })
classes.Alpha.validScripts = ANIMATION_SCRIPTS
newClass("Scale", "Animation")
define(classes.Scale.methods, {
	SetScale = function(self, x, y) state[self].scaleTo = { x, y } end,
	SetOrigin = function() end,
})
classes.Scale.validScripts = ANIMATION_SCRIPTS
newClass("Rotation", "Animation")
define(classes.Rotation.methods, {
	SetDegrees = function(self, degrees) state[self].degrees = degrees end,
	GetDegrees = function(self) return state[self].degrees or 0 end,
	SetRadians = function(self, radians) state[self].degrees = math.deg(radians) end,
	SetOrigin = function() end,
})
classes.Rotation.validScripts = ANIMATION_SCRIPTS
newClass("Translation", "Animation")
define(classes.Translation.methods, { SetOffset = function(self, x, y) state[self].offset = { x, y } end })
classes.Translation.validScripts = ANIMATION_SCRIPTS

------------------------------------------------------------------------
-- Frame
------------------------------------------------------------------------

local Frame = newClass("Frame", "Region")
define(Frame, scriptMethods)

local FRAME_SCRIPTS = {
	OnAttributeChanged = true, OnChar = true, OnDisable = true, OnDragStart = true, OnDragStop = true,
	OnEnable = true, OnEnter = true, OnEvent = true, OnHide = true, OnKeyDown = true, OnKeyUp = true,
	OnLeave = true, OnLoad = true, OnMouseDown = true, OnMouseUp = true, OnMouseWheel = true,
	OnReceiveDrag = true, OnShow = true, OnSizeChanged = true, OnUpdate = true,
}

local function scriptSet(...)
	local set = {}
	for name in pairs(FRAME_SCRIPTS) do
		set[name] = true
	end
	for i = 1, select("#", ...) do
		set[select(i, ...)] = true
	end
	return set
end
classes.Frame.validScripts = scriptSet()

local STRATA = {
	BACKGROUND = true, LOW = true, MEDIUM = true, HIGH = true, DIALOG = true,
	FULLSCREEN = true, FULLSCREEN_DIALOG = true, TOOLTIP = true, PARENT = true,
}

define(Frame, {
	CreateTexture = function(self, name, layer, inherits)
		local texture = Widgets.new("Texture", name, self, inherits)
		state[texture].drawLayer = layer
		return texture
	end,
	CreateFontString = function(self, name, layer, inherits)
		local fontString = Widgets.new("FontString", name, self)
		state[fontString].drawLayer = layer
		if inherits then
			fontString:SetFontObject(inherits)
		end
		return fontString
	end,
	RegisterEvent = function(self, event)
		assert(type(event) == "string", "RegisterEvent: event must be a string")
		state[self].events[event] = true
		client.eventFrames[self] = true
	end,
	UnregisterEvent = function(self, event)
		state[self].events[event] = nil
	end,
	RegisterAllEvents = function(self)
		state[self].allEvents = true
		client.eventFrames[self] = true
	end,
	UnregisterAllEvents = function(self)
		state[self].events = {}
		state[self].allEvents = nil
	end,
	IsEventRegistered = function(self, event)
		return (state[self].events[event] or state[self].allEvents) and 1 or nil
	end,
	SetFrameLevel = function(self, level)
		assert(type(level) == "number", "SetFrameLevel: level must be a number")
		state[self].frameLevel = math.max(0, math.floor(level))
	end,
	GetFrameLevel = function(self) return state[self].frameLevel end,
	SetFrameStrata = function(self, strata)
		assert(STRATA[strata], "SetFrameStrata: bad strata " .. tostring(strata))
		state[self].frameStrata = strata
	end,
	GetFrameStrata = function(self)
		local s = state[self]
		if s.frameStrata == "PARENT" or not s.frameStrata then
			return s.parent and state[s.parent] and s.parent.GetFrameStrata and s.parent:GetFrameStrata() or "MEDIUM"
		end
		return s.frameStrata
	end,
	SetScale = function(self, scale)
		assert(type(scale) == "number" and scale > 0, "SetScale: scale must be a positive number")
		state[self].scale = scale
	end,
	GetScale = function(self) return state[self].scale end,
	EnableMouse = function(self, enable) state[self].mouse = enable and true or false end,
	IsMouseEnabled = function(self) return state[self].mouse and 1 or nil end,
	EnableMouseWheel = function(self, enable) state[self].mouseWheel = enable and true or false end,
	IsMouseWheelEnabled = function(self) return state[self].mouseWheel and 1 or nil end,
	EnableKeyboard = function(self, enable) state[self].keyboard = enable and true or false end,
	IsKeyboardEnabled = function(self) return state[self].keyboard and 1 or nil end,
	SetMovable = function(self, movable) state[self].movable = movable and true or false end,
	IsMovable = function(self) return state[self].movable and 1 or nil end,
	SetResizable = function(self, resizable) state[self].resizable = resizable and true or false end,
	IsResizable = function(self) return state[self].resizable and 1 or nil end,
	SetMinResize = function(self, w, h) state[self].minResize = { w, h } end,
	GetMinResize = function(self)
		local m = state[self].minResize or { 0, 0 }
		return m[1], m[2]
	end,
	SetMaxResize = function(self, w, h) state[self].maxResize = { w, h } end,
	GetMaxResize = function(self)
		local m = state[self].maxResize or { 0, 0 }
		return m[1], m[2]
	end,
	StartMoving = function(self) state[self].moving = true end,
	StartSizing = function(self) state[self].sizing = true end,
	StopMovingOrSizing = function(self) state[self].moving, state[self].sizing = nil, nil end,
	SetUserPlaced = function(self, placed) state[self].userPlaced = placed and true or false end,
	IsUserPlaced = function(self) return state[self].userPlaced and 1 or nil end,
	SetDontSavePosition = function(self, flag) state[self].dontSavePosition = flag end,
	RegisterForDrag = function(self, ...) state[self].dragButtons = { ... } end,
	SetClampedToScreen = function(self, clamped) state[self].clamped = clamped and true or false end,
	IsClampedToScreen = function(self) return state[self].clamped and 1 or nil end,
	SetClampRectInsets = function(self, l, r, t, b) state[self].clampInsets = { l, r, t, b } end,
	GetClampRectInsets = function(self)
		local c = state[self].clampInsets or { 0, 0, 0, 0 }
		return c[1], c[2], c[3], c[4]
	end,
	SetHitRectInsets = function(self, l, r, t, b) state[self].hitInsets = { l, r, t, b } end,
	GetHitRectInsets = function(self)
		local c = state[self].hitInsets or { 0, 0, 0, 0 }
		return c[1], c[2], c[3], c[4]
	end,
	SetToplevel = function(self, toplevel) state[self].toplevel = toplevel end,
	IsToplevel = function(self) return state[self].toplevel and 1 or nil end,
	Raise = function(self) state[self].frameLevel = state[self].frameLevel + 1 end,
	Lower = function(self) state[self].frameLevel = math.max(0, state[self].frameLevel - 1) end,
	SetBackdrop = function(self, backdrop)
		assert(backdrop == nil or type(backdrop) == "table", "SetBackdrop: backdrop must be a table or nil")
		state[self].backdrop = backdrop
	end,
	GetBackdrop = function(self) return state[self].backdrop end,
	SetBackdropColor = function(self, r, g, b, a) checkColor("SetBackdropColor", r, g, b) state[self].backdropColor = { r, g, b, a or 1 } end,
	GetBackdropColor = function(self)
		local c = state[self].backdropColor or { 1, 1, 1, 1 }
		return c[1], c[2], c[3], c[4]
	end,
	SetBackdropBorderColor = function(self, r, g, b, a) checkColor("SetBackdropBorderColor", r, g, b) state[self].backdropBorderColor = { r, g, b, a or 1 } end,
	GetBackdropBorderColor = function(self)
		local c = state[self].backdropBorderColor or { 1, 1, 1, 1 }
		return c[1], c[2], c[3], c[4]
	end,
	SetID = function(self, id)
		assert(type(id) == "number", "SetID: id must be a number")
		state[self].id = id
	end,
	GetID = function(self) return state[self].id or 0 end,
	GetChildren = function(self)
		local list = {}
		for _, widget in ipairs(client.widgets) do
			if state[self].children[widget] and state[widget].class.isA.Frame then
				list[#list + 1] = widget
			end
		end
		return unpack(list)
	end,
	GetNumChildren = function(self) return select("#", self:GetChildren()) end,
	GetRegions = function(self)
		local list = {}
		for _, widget in ipairs(client.widgets) do
			if state[self].children[widget] and state[widget].class.isA.LayeredRegion then
				list[#list + 1] = widget
			end
		end
		return unpack(list)
	end,
	GetNumRegions = function(self) return select("#", self:GetRegions()) end,
	SetAttribute = function(self, name, value)
		local s = state[self]
		s.attributes[name] = value
		client:RunScript(self, "OnAttributeChanged", name, value)
		client.secure.attributeChanged(self, name, value)
	end,
	GetAttribute = function(self, name)
		local s = state[self]
		local value = s.attributes[name]
		if value == nil and type(name) == "string" then
			-- the secure templates' "*name" and "name1" fallbacks
			value = s.attributes["*" .. name:gsub("%d+$", "")]
		end
		return value
	end,
	SetDepth = function() end,
	IgnoreDepth = function() end,
	EnableDrawLayer = function() end,
	DisableDrawLayer = function() end,
	CreateTitleRegion = function(self) return Widgets.new("Region", nil, self) end,
	GetTitleRegion = function() return nil end,
	SetAlpha = UIObject.SetAlpha,
})

-- Every widget type below is a Frame too.
local function frameClass(name, parentName, ...)
	local methods = newClass(name, parentName or "Frame")
	classes[name].validScripts = scriptSet(...)
	return methods
end

------------------------------------------------------------------------
-- Buttons
------------------------------------------------------------------------

local Button = frameClass("Button", "Frame", "OnClick", "PreClick", "PostClick", "OnDoubleClick")

local function buttonTexture(self, key, layer)
	return function(self, texture)
		local s = state[self]
		if texture == nil then
			if s[key] then s[key]:SetTexture(nil) end
			return
		end
		if type(texture) == "string" then
			s[key] = s[key] or Widgets.new("Texture", nil, self)
			s[key]:SetTexture(texture)
			s[key]:SetAllPoints(self)
			state[s[key]].drawLayer = layer
		else
			s[key] = texture
			if state[texture].parent ~= self then
				setParent(texture, self)
			end
		end
	end
end

define(Button, {
	SetNormalTexture = buttonTexture(nil, "normalTexture", "ARTWORK"),
	GetNormalTexture = function(self) return state[self].normalTexture end,
	SetPushedTexture = buttonTexture(nil, "pushedTexture", "ARTWORK"),
	GetPushedTexture = function(self) return state[self].pushedTexture end,
	SetHighlightTexture = function(self, texture, mode)
		buttonTexture(nil, "highlightTexture", "HIGHLIGHT")(self, texture)
		if state[self].highlightTexture and mode then
			state[self].highlightTexture:SetBlendMode(mode)
		end
	end,
	GetHighlightTexture = function(self) return state[self].highlightTexture end,
	SetDisabledTexture = buttonTexture(nil, "disabledTexture", "ARTWORK"),
	GetDisabledTexture = function(self) return state[self].disabledTexture end,
	SetText = function(self, text)
		local s = state[self]
		s.fontString = s.fontString or Widgets.new("FontString", nil, self)
		s.fontString:SetText(text)
	end,
	GetText = function(self)
		local s = state[self]
		return s.fontString and s.fontString:GetText()
	end,
	SetFormattedText = function(self, ...)
		self:SetText(string.format(...))
	end,
	GetFontString = function(self) return state[self].fontString end,
	SetFontString = function(self, fontString) state[self].fontString = fontString end,
	GetTextWidth = function(self)
		local s = state[self]
		return s.fontString and s.fontString:GetStringWidth() or 0
	end,
	SetNormalFontObject = function(self, font) font = resolve(font) state[self].normalFont = font end,
	GetNormalFontObject = function(self) return state[self].normalFont end,
	SetHighlightFontObject = function(self, font) font = resolve(font) state[self].highlightFont = font end,
	GetHighlightFontObject = function(self) return state[self].highlightFont end,
	SetDisabledFontObject = function(self, font) font = resolve(font) state[self].disabledFont = font end,
	SetTextFontObject = function(self, font) font = resolve(font) state[self].normalFont = font end,
	RegisterForClicks = function(self, ...)
		state[self].clicks = { ... }
	end,
	Click = function(self, button, down)
		local s = state[self]
		if s.disabled then
			return
		end
		button = button or "LeftButton"
		client:RunScript(self, "PreClick", button, down)
		client:RunScript(self, "OnClick", button, down)
		client:RunScript(self, "PostClick", button, down)
	end,
	Enable = function(self)
		local s = state[self]
		if s.disabled then
			s.disabled = false
			client:RunScript(self, "OnEnable")
		end
	end,
	Disable = function(self)
		local s = state[self]
		if not s.disabled then
			s.disabled = true
			client:RunScript(self, "OnDisable")
		end
	end,
	IsEnabled = function(self) return (not state[self].disabled) and 1 or nil end,
	SetButtonState = function(self, buttonState, locked)
		assert(buttonState == "NORMAL" or buttonState == "PUSHED" or buttonState == "DISABLED",
			"SetButtonState: bad state " .. tostring(buttonState))
		state[self].buttonState, state[self].stateLocked = buttonState, locked
	end,
	GetButtonState = function(self) return state[self].buttonState or "NORMAL" end,
	LockHighlight = function(self) state[self].highlightLocked = true end,
	UnlockHighlight = function(self) state[self].highlightLocked = false end,
	SetPushedTextOffset = function() end,
	GetPushedTextOffset = function() return 0, 0 end,
})

local CheckButton = frameClass("CheckButton", "Button", "OnClick", "PreClick", "PostClick", "OnDoubleClick")

define(CheckButton, {
	SetChecked = function(self, checked)
		state[self].checked = (checked and checked ~= 0) and true or false
	end,
	GetChecked = function(self) return state[self].checked and 1 or nil end,
	SetCheckedTexture = buttonTexture(nil, "checkedTexture", "OVERLAY"),
	GetCheckedTexture = function(self) return state[self].checkedTexture end,
	SetDisabledCheckedTexture = buttonTexture(nil, "disabledCheckedTexture", "OVERLAY"),
	GetDisabledCheckedTexture = function(self) return state[self].disabledCheckedTexture end,
	Click = function(self, button, down)
		local s = state[self]
		if s.disabled then
			return
		end
		s.checked = not s.checked
		button = button or "LeftButton"
		client:RunScript(self, "PreClick", button, down)
		client:RunScript(self, "OnClick", button, down)
		client:RunScript(self, "PostClick", button, down)
	end,
})

------------------------------------------------------------------------
-- StatusBar, Slider
------------------------------------------------------------------------

local StatusBar = frameClass("StatusBar", "Frame", "OnValueChanged", "OnMinMaxChanged")

define(StatusBar, {
	SetMinMaxValues = function(self, min, max)
		assert(type(min) == "number" and type(max) == "number", "SetMinMaxValues: needs two numbers")
		local s = state[self]
		s.min, s.max = min, max
		client:RunScript(self, "OnMinMaxChanged", min, max)
	end,
	GetMinMaxValues = function(self) return state[self].min, state[self].max end,
	SetValue = function(self, value)
		assert(type(value) == "number", "SetValue: value must be a number")
		local s = state[self]
		value = math.max(s.min, math.min(s.max, value))
		if value ~= s.value then
			s.value = value
			client:RunScript(self, "OnValueChanged", value)
		end
	end,
	GetValue = function(self) return state[self].value end,
	SetStatusBarTexture = function(self, texture, layer)
		local s = state[self]
		if type(texture) == "string" then
			s.barTexture = s.barTexture or Widgets.new("Texture", nil, self)
			s.barTexture:SetTexture(texture)
			if layer then s.barTexture:SetDrawLayer(layer) end
		elseif texture then
			s.barTexture = texture
		end
	end,
	GetStatusBarTexture = function(self)
		local s = state[self]
		s.barTexture = s.barTexture or Widgets.new("Texture", nil, self)
		return s.barTexture
	end,
	SetStatusBarColor = function(self, r, g, b, a)
		checkColor("SetStatusBarColor", r, g, b)
		state[self].barColor = { r, g, b, a or 1 }
	end,
	GetStatusBarColor = function(self)
		local c = state[self].barColor or { 1, 1, 1, 1 }
		return c[1], c[2], c[3], c[4]
	end,
	SetOrientation = function(self, orientation)
		assert(orientation == "HORIZONTAL" or orientation == "VERTICAL", "SetOrientation: bad orientation")
		state[self].orientation = orientation
	end,
	GetOrientation = function(self) return state[self].orientation or "HORIZONTAL" end,
	SetRotatesTexture = function() end,
})

local Slider = frameClass("Slider", "Frame", "OnValueChanged", "OnMinMaxChanged")

define(Slider, {
	SetMinMaxValues = StatusBar.SetMinMaxValues,
	GetMinMaxValues = StatusBar.GetMinMaxValues,
	SetValue = StatusBar.SetValue,
	GetValue = StatusBar.GetValue,
	SetValueStep = function(self, step) state[self].step = step end,
	GetValueStep = function(self) return state[self].step or 0 end,
	SetOrientation = StatusBar.SetOrientation,
	GetOrientation = StatusBar.GetOrientation,
	SetThumbTexture = function(self, texture)
		local s = state[self]
		if type(texture) == "string" then
			s.thumb = s.thumb or Widgets.new("Texture", nil, self)
			s.thumb:SetTexture(texture)
		else
			s.thumb = texture
		end
	end,
	GetThumbTexture = function(self) return state[self].thumb end,
	Enable = function(self) state[self].disabled = false end,
	Disable = function(self) state[self].disabled = true end,
	IsEnabled = function(self) return (not state[self].disabled) and 1 or nil end,
})

------------------------------------------------------------------------
-- EditBox, ScrollFrame, message frames
------------------------------------------------------------------------

local EditBox = frameClass("EditBox", "Frame", "OnEnterPressed", "OnEscapePressed", "OnSpacePressed",
	"OnTabPressed", "OnTextChanged", "OnTextSet", "OnCursorChanged", "OnInputLanguageChanged",
	"OnEditFocusGained", "OnEditFocusLost", "OnArrowPressed", "OnChar")
define(EditBox, fontMethods)

define(EditBox, {
	SetText = function(self, text)
		state[self].text = tostring(text or "")
		client:RunScript(self, "OnTextSet")
		client:RunScript(self, "OnTextChanged", false)
	end,
	GetText = function(self) return state[self].text or "" end,
	Insert = function(self, text)
		state[self].text = (state[self].text or "") .. tostring(text)
		client:RunScript(self, "OnTextChanged", true)
	end,
	GetNumLetters = function(self) return #(state[self].text or "") end,
	SetFocus = function(self)
		if client.focus ~= self then
			local old = client.focus
			client.focus = self
			if old then client:RunScript(old, "OnEditFocusLost") end
			client:RunScript(self, "OnEditFocusGained")
		end
	end,
	ClearFocus = function(self)
		if client.focus == self then
			client.focus = nil
			client:RunScript(self, "OnEditFocusLost")
		end
	end,
	HasFocus = function(self) return client.focus == self and 1 or nil end,
	SetAutoFocus = function(self, flag) state[self].autoFocus = flag end,
	SetMaxLetters = function(self, max) state[self].maxLetters = max end,
	GetMaxLetters = function(self) return state[self].maxLetters or 0 end,
	SetMultiLine = function(self, flag) state[self].multiLine = flag end,
	IsMultiLine = function(self) return state[self].multiLine and 1 or nil end,
	HighlightText = function() end,
	SetTextInsets = function(self, l, r, t, b) state[self].textInsets = { l, r, t, b } end,
	GetTextInsets = function(self)
		local i = state[self].textInsets or { 0, 0, 0, 0 }
		return i[1], i[2], i[3], i[4]
	end,
	SetCursorPosition = function() end,
	GetCursorPosition = function(self) return #(state[self].text or "") end,
	SetAltArrowKeyMode = function(self, flag) state[self].altArrow = flag end,
	SetHistoryLines = function() end,
	AddHistoryLine = function() end,
	SetNumeric = function() end,
	SetPassword = function() end,
	SetBlinkSpeed = function() end,
	IsInIMECompositionMode = function() return nil end,
	GetInputLanguage = function() return "ROMAN" end,
	ToggleInputLanguage = function() end,
})

local ScrollFrame = frameClass("ScrollFrame", "Frame", "OnHorizontalScroll", "OnVerticalScroll", "OnScrollRangeChanged")

define(ScrollFrame, {
	SetScrollChild = function(self, child)
		child = resolve(child)
		state[self].scrollChild = child
		setParent(child, self)
	end,
	GetScrollChild = function(self) return state[self].scrollChild end,
	SetHorizontalScroll = function(self, value) state[self].hScroll = value end,
	GetHorizontalScroll = function(self) return state[self].hScroll or 0 end,
	SetVerticalScroll = function(self, value) state[self].vScroll = value end,
	GetVerticalScroll = function(self) return state[self].vScroll or 0 end,
	GetVerticalScrollRange = function(self)
		local child = state[self].scrollChild
		if not child then return 0 end
		return math.max(0, child:GetHeight() - self:GetHeight())
	end,
	GetHorizontalScrollRange = function() return 0 end,
	UpdateScrollChildRect = function() end,
})

local MessageFrame = frameClass("MessageFrame", "Frame")
define(MessageFrame, fontMethods)
define(MessageFrame, {
	AddMessage = function(self, text, r, g, b, id, holdTime)
		table.insert(state[self].messages, { text = text, r = r, g = g, b = b, id = id })
	end,
	Clear = function(self) state[self].messages = {} end,
	SetFading = function(self, fading) state[self].fading = fading end,
	GetFading = function(self) return state[self].fading ~= false and 1 or nil end,
	SetTimeVisible = function(self, seconds) state[self].timeVisible = seconds end,
	GetTimeVisible = function(self) return state[self].timeVisible or 10 end,
	SetFadeDuration = function(self, seconds) state[self].fadeDuration = seconds end,
	GetFadeDuration = function(self) return state[self].fadeDuration or 3 end,
	SetInsertMode = function(self, mode) state[self].insertMode = mode end,
	GetInsertMode = function(self) return state[self].insertMode or "BOTTOM" end,
})

local ScrollingMessageFrame = frameClass("ScrollingMessageFrame", "Frame", "OnHyperlinkClick",
	"OnHyperlinkEnter", "OnHyperlinkLeave", "OnMessageScrollChanged")
define(ScrollingMessageFrame, fontMethods)
define(ScrollingMessageFrame, MessageFrame)
define(ScrollingMessageFrame, {
	SetMaxLines = function(self, lines) state[self].maxLines = lines end,
	GetMaxLines = function(self) return state[self].maxLines or 128 end,
	GetNumMessages = function(self) return #state[self].messages end,
	GetCurrentLine = function(self) return #state[self].messages end,
	GetNumLinesDisplayed = function(self) return math.min(#state[self].messages, 10) end,
	GetCurrentScroll = function(self) return state[self].scroll or 0 end,
	SetScrollOffset = function(self, offset) state[self].scroll = offset end,
	ScrollUp = function(self) state[self].scroll = (state[self].scroll or 0) + 1 end,
	ScrollDown = function(self) state[self].scroll = math.max(0, (state[self].scroll or 0) - 1) end,
	ScrollToTop = function(self) state[self].scroll = #state[self].messages end,
	ScrollToBottom = function(self) state[self].scroll = 0 end,
	PageUp = function(self) state[self].scroll = (state[self].scroll or 0) + 10 end,
	PageDown = function(self) state[self].scroll = math.max(0, (state[self].scroll or 0) - 10) end,
	AtTop = function(self) return (state[self].scroll or 0) >= #state[self].messages and 1 or nil end,
	AtBottom = function(self) return (state[self].scroll or 0) == 0 and 1 or nil end,
	SetHyperlinksEnabled = function() end,
	UpdateColorByID = function() end,
})

local SimpleHTML = frameClass("SimpleHTML", "Frame", "OnHyperlinkClick", "OnHyperlinkEnter", "OnHyperlinkLeave")
define(SimpleHTML, fontMethods)
define(SimpleHTML, {
	SetText = function(self, text) state[self].text = text end,
	GetText = function(self) return state[self].text end,
})

------------------------------------------------------------------------
-- GameTooltip
------------------------------------------------------------------------

local GameTooltip = frameClass("GameTooltip", "Frame", "OnTooltipSetUnit", "OnTooltipSetItem",
	"OnTooltipSetSpell", "OnTooltipCleared", "OnTooltipAddMoney", "OnTooltipSetDefaultAnchor")

-- The TextLeftN / TextRightN font strings, created as the tooltip grows,
-- named like the real ones so `_G[name .. "TextLeft" .. i]` finds them.
local tooltipLine
function tooltipLine(self, side, index)
	local s = state[self]
	local key = side .. index
	if not s.lines[key] then
		local name = s.name and (s.name .. "Text" .. side .. index)
		local fontString = Widgets.new("FontString", name, self)
		fontString:Hide()
		s.lines[key] = fontString
		-- anchored like GameTooltipTemplate's lines
		if side == "Right" then
			fontString:SetPoint("RIGHT", tooltipLine(self, "Left", index), "LEFT", 40, 0)
		elseif index == 1 then
			fontString:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
		else
			fontString:SetPoint("TOPLEFT", tooltipLine(self, "Left", index - 1), "BOTTOMLEFT", 0, -2)
		end
	end
	return s.lines[key]
end
Widgets.tooltipLine = tooltipLine

local function clearTooltip(self)
	local s = state[self]
	for _, fontString in pairs(s.lines) do
		fontString:SetText(nil)
		fontString:Hide()
	end
	s.numLines, s.unit, s.item, s.spell = 0, nil, nil, nil
	client:RunScript(self, "OnTooltipCleared")
end

-- The size the client gives a tooltip: its widest line, all lines' height.
local function measureTooltip(self)
	local s = state[self]
	local width, height = 0, 0
	for i = 1, s.numLines do
		local left, right = tooltipLine(self, "Left", i), tooltipLine(self, "Right", i)
		local w = left:GetStringWidth() + ((state[right].shown and right:GetText()) and (right:GetStringWidth() + 20) or 0)
		width = math.max(width, w)
		height = height + left:GetStringHeight() + ((i > 1) and 2 or 0)
	end
	s.width = math.max(width + 20, s.minWidth or 0)
	s.height = height + 20
end

local function addTooltipLine(self, left, right, lr, lg, lb, rr, rg, rb)
	local s = state[self]
	s.numLines = s.numLines + 1
	local l = tooltipLine(self, "Left", s.numLines)
	l:SetText(left)
	l:SetTextColor(lr or 1, lg or 0.82, lb or 0)
	l:Show()
	local r = tooltipLine(self, "Right", s.numLines)
	r:SetText(right)
	if right then
		r:SetTextColor(rr or 1, rg or 0.82, rb or 0)
		r:Show()
	else
		r:Hide()
	end
	-- a line added to a shown tooltip makes the client measure it again
	if s.shown then
		measureTooltip(self)
	end
end

local function s_name(self)
	return state[self].name
end

local function showTooltipContent(self, kind, value, script, lines)
	clearTooltip(self)
	local s = state[self]
	s[kind] = value
	for _, line in ipairs(lines or {}) do
		addTooltipLine(self, line[1], line[2])
	end
	self:Show()
	if script then
		client:RunScript(self, script)
	end
end

define(GameTooltip, {
	-- the client sizes a tooltip to its lines each time it's shown
	Show = function(self)
		measureTooltip(self)
		setShown(self, true)
	end,
	SetOwner = function(self, owner, anchor, x, y)
		assert(owner, "SetOwner: owner is nil")
		owner = resolve(owner)
		local s = state[self]
		s.owner, s.anchor = owner, anchor or "ANCHOR_LEFT"
		clearTooltip(self)
		self:Hide()
	end,
	GetOwner = function(self) return state[self].owner end,
	IsOwned = function(self, frame) return state[self].owner == frame and 1 or nil end,
	GetAnchorType = function(self) return state[self].anchor or "ANCHOR_NONE" end,
	ClearLines = clearTooltip,
	AddLine = function(self, text, r, g, b, wrap)
		addTooltipLine(self, text, nil, r, g, b)
	end,
	AddDoubleLine = function(self, left, right, lr, lg, lb, rr, rg, rb)
		addTooltipLine(self, left, right, lr, lg, lb, rr, rg, rb)
	end,
	AddTexture = function() end,
	AppendText = function(self, text)
		local s = state[self]
		if s.numLines > 0 then
			local l = tooltipLine(self, "Left", 1)
			l:SetText((l:GetText() or "") .. text)
		end
	end,
	SetText = function(self, text, r, g, b)
		clearTooltip(self)
		addTooltipLine(self, text, nil, r, g, b)
		self:Show()
	end,
	NumLines = function(self) return state[self].numLines end,
	SetMinimumWidth = function(self, width) state[self].minWidth = width end,
	SetPadding = nil, -- Cataclysm
	FadeOut = function(self) self:Hide() end,
	GetUnit = function(self)
		local unit = state[self].unit
		if unit then
			return client.api.UnitName(unit), unit
		end
	end,
	GetItem = function(self)
		local link = state[self].item
		if link then
			return client.api.GetItemInfo(link), link
		end
	end,
	GetSpell = function(self)
		local id = state[self].spell
		if id then
			return client.api.GetSpellInfo(id), nil, id
		end
	end,
	SetUnit = function(self, unit)
		local api = client.api
		if not api.UnitExists(unit) then
			return
		end
		-- the lines 3.3.5 shows: name, level line, faction, PvP
		local lines = { { api.UnitName(unit) }, { "Level " .. tostring(api.UnitLevel(unit)) } }
		local faction = api.UnitFactionGroup(unit)
		if faction then
			lines[#lines + 1] = { _G["FACTION_" .. faction:upper()] or faction }
		end
		if api.UnitIsPVP(unit) then
			lines[#lines + 1] = { _G.PVP_ENABLED }
		end
		-- GameTooltipStatusBar follows the unit's health
		local bar = s_name(self) and _G[s_name(self) .. "StatusBar"]
		if bar then
			bar:SetMinMaxValues(0, api.UnitHealthMax(unit))
			bar:SetValue(api.UnitHealth(unit))
			bar:Show()
		end
		showTooltipContent(self, "unit", unit, "OnTooltipSetUnit", lines)
	end,
	SetHyperlink = function(self, link)
		assert(type(link) == "string", "SetHyperlink: link must be a string")
		if link:match("item:%d+") then
			-- the item's lines (world.itemInfo[id].lines: text or { left, right,
			-- { r, g, b } }, white by default), its sell price through
			-- OnTooltipAddMoney, then OnTooltipSetItem
			local api = client.api
			local id = api.itemIdOf(link)
			local info = client.world.itemInfo[id] or {}
			local name, itemLink = api.GetItemInfo(link)
			clearTooltip(self)
			local st = state[self]
			st.item = itemLink or link
			for _, line in ipairs(info.lines or { name or "Item" }) do
				if type(line) == "string" then
					line = { line }
				end
				local c = line[3] or { 1, 1, 1 }
				addTooltipLine(self, line[1], line[2], c[1], c[2], c[3], 1, 1, 1)
			end
			local price = info.vendorPrice
			if price and price > 0 and info.moneyFirst ~= false then
				client:RunScript(self, "OnTooltipAddMoney", price * (info.stack or 1))
			end
			self:Show()
			client:RunScript(self, "OnTooltipSetItem")
			if price and price > 0 and info.moneyFirst == false then
				client:RunScript(self, "OnTooltipAddMoney", price * (info.stack or 1))
			end
		elseif link:match("spell:%d+") then
			showTooltipContent(self, "spell", tonumber(link:match("spell:(%d+)")), "OnTooltipSetSpell", { { "Spell" } })
		else
			showTooltipContent(self, nil, nil, nil, { { link } })
		end
	end,
	-- 1 when the slot has something to show (Blizzard's buttons keep their
	-- tooltip up to date only then)
	SetAction = function(self, slot)
		local action = client.world.actions[slot]
		if not action then return end
		if action.itemLink then
			self:SetHyperlink(action.itemLink)
		else
			showTooltipContent(self, "spell", action.id, "OnTooltipSetSpell", { { action.name or "Action" } })
		end
		return 1
	end,
	SetInventoryItem = function(self, unit, slot)
		local link = client.api.GetInventoryItemLink(unit, slot)
		if link then
			self:SetHyperlink(link)
			return 1
		end
	end,
	SetBagItem = function(self, bag, slot)
		local link = client.api.GetContainerItemLink(bag, slot)
		if link then self:SetHyperlink(link) end
	end,
	SetLootItem = function(self, slot)
		local link = client.api.GetLootSlotLink(slot)
		if link then self:SetHyperlink(link) end
	end,
	SetUnitAura = function(self, unit, index, filter)
		local api = client.api
		local name, _, _, _, _, _, expires, _, _, _, spellId = api.UnitAura(unit, index, filter)
		if name then
			-- title, description, and the time left like the client words it
			local lines = { { name }, { "Aura effect." } }
			local left = (expires or 0) - client.world.time
			if (expires or 0) > 0 and left > 0 then
				if left >= 3600 then
					lines[3] = { string.format("%d hours remaining", left / 3600) }
				elseif left >= 60 then
					lines[3] = { string.format("%d minutes remaining", left / 60) }
				else
					lines[3] = { string.format("%d seconds remaining", left) }
				end
			end
			showTooltipContent(self, "spell", spellId, "OnTooltipSetSpell", lines)
		end
	end,
	SetUnitBuff = function(self, unit, index, filter)
		self:SetUnitAura(unit, index, "HELPFUL" .. (filter and ("|" .. filter) or ""))
	end,
	SetUnitDebuff = function(self, unit, index, filter)
		self:SetUnitAura(unit, index, "HARMFUL" .. (filter and ("|" .. filter) or ""))
	end,
	SetPetAction = function(self, slot)
		local name = client.api.GetPetActionInfo(slot)
		if name then showTooltipContent(self, nil, nil, nil, { { name } }) end
	end,
	SetShapeshift = function(self, index)
		local _, name = client.api.GetShapeshiftFormInfo(index)
		if name then showTooltipContent(self, nil, nil, nil, { { name } }) end
	end,
	SetSpell = function(self, id)
		showTooltipContent(self, "spell", id, "OnTooltipSetSpell", { { "Spell" } })
	end,
	SetTotem = function(self, slot)
		showTooltipContent(self, nil, nil, nil, { { "Totem " .. slot } })
	end,
	SetMerchantItem = function() end,
	SetQuestItem = function() end,
	SetQuestLogItem = function() end,
	SetTrackingSpell = function() end,
	SetBackpackToken = function() end,
	SetCurrencyToken = function() end,
	SetInventoryItemByID = nil, -- Cataclysm
	IsUnit = function(self, unit)
		return state[self].unit and client.api.UnitIsUnit(state[self].unit, unit) or nil
	end,
})

------------------------------------------------------------------------
-- Cooldown, models, minimap
------------------------------------------------------------------------

local Cooldown = frameClass("Cooldown", "Frame")
define(Cooldown, {
	SetCooldown = function(self, start, duration)
		assert(type(start) == "number" and type(duration) == "number", "SetCooldown: needs two numbers")
		state[self].cooldown = { start, duration }
	end,
	GetCooldownTimes = function(self)
		local c = state[self].cooldown or { 0, 0 }
		return c[1] * 1000, c[2] * 1000
	end,
	SetReverse = function(self, reverse) state[self].reverse = reverse end,
	GetReverse = function(self) return state[self].reverse and 1 or nil end,
	SetDrawEdge = nil, -- Cataclysm
})

local Model = frameClass("Model", "Frame", "OnAnimFinished", "OnUpdateModel")
define(Model, {
	SetModel = function(self, path) state[self].model = path end,
	GetModel = function(self) return state[self].model or "" end,
	ClearModel = function(self) state[self].model, state[self].unit = nil, nil end,
	SetCamera = function(self, index) state[self].camera = index end,
	SetPosition = function(self, x, y, z) state[self].position = { x, y, z } end,
	GetPosition = function(self)
		local p = state[self].position or { 0, 0, 0 }
		return p[1], p[2], p[3]
	end,
	SetFacing = function(self, facing) state[self].facing = facing end,
	GetFacing = function(self) return state[self].facing or 0 end,
	SetModelScale = function(self, scale) state[self].modelScale = scale end,
	GetModelScale = function(self) return state[self].modelScale or 1 end,
	SetLight = function() end,
	SetFogColor = function() end,
	SetFogNear = function() end,
	SetFogFar = function() end,
	ClearFog = function() end,
	SetSequence = function() end,
	SetSequenceTime = function() end,
	AdvanceTime = function() end,
	ReplaceIconTexture = function() end,
	SetGlow = function() end,
})

local PlayerModel = frameClass("PlayerModel", "Model", "OnAnimFinished", "OnUpdateModel")
define(PlayerModel, {
	SetUnit = function(self, unit)
		state[self].unit = unit
		state[self].model = client.api.UnitExists(unit) and ("Creature\\" .. tostring(client.api.UnitName(unit)) .. ".m2") or ""
	end,
	RefreshUnit = function(self)
		if state[self].unit then self:SetUnit(state[self].unit) end
	end,
	SetCreature = function(self, id) state[self].model = "creature:" .. tostring(id) end,
	SetRotation = function(self, radians) state[self].facing = radians end,
	SetDisplayInfo = function(self, id) state[self].model = "display:" .. tostring(id) end,
	SetPortraitZoom = nil, -- Cataclysm
})
frameClass("DressUpModel", "PlayerModel")
frameClass("TabardModel", "PlayerModel")

local Minimap = frameClass("Minimap", "Frame", "OnMouseWheel")
define(Minimap, {
	SetZoom = function(self, zoom) state[self].zoom = zoom end,
	GetZoom = function(self) return state[self].zoom or 0 end,
	GetZoomLevels = function() return 6 end,
	SetMaskTexture = function(self, path) state[self].mask = path end,
	SetBlipTexture = function(self, path) state[self].blips = path end,
	SetIconTexture = function(self, path) state[self].icons = path end,
	SetClassBlipTexture = nil,
	SetPlayerTexture = function() end,
	SetPlayerTextureHeight = function() end,
	SetPlayerTextureWidth = function() end,
	SetArrowModel = function() end,
	SetPlayerModel = function() end,
	GetPingPosition = function() return 0, 0 end,
	PingLocation = function() end,
	SetCorpsePOIArrowTexture = function() end,
	SetPOIArrowTexture = function() end,
	SetStaticPOIArrowTexture = function() end,
})

local ColorSelect = frameClass("ColorSelect", "Frame", "OnColorSelect")
define(ColorSelect, {
	SetColorRGB = function(self, r, g, b) state[self].color = { r, g, b } end,
	GetColorRGB = function(self)
		local c = state[self].color or { 1, 1, 1 }
		return c[1], c[2], c[3]
	end,
})

frameClass("MovieFrame", "Frame")
frameClass("QuestPOIFrame", "Frame")
frameClass("WorldFrame", "Frame")

for _, class in pairs(classes) do
	if class.isA.Region then
		wrapRestricted(class.methods)
	end
end

------------------------------------------------------------------------
-- Construction
------------------------------------------------------------------------

-- Templates: the child regions a Blizzard template gives a named frame, so
-- `_G[name .. "Icon"]` and friends exist, like in game.
local TEMPLATE_CHILDREN = {
	ActionButtonTemplate = {
		{ "Texture", "Icon" }, { "Texture", "Flash" }, { "FontString", "HotKey" }, { "FontString", "Count" },
		{ "FontString", "Name" }, { "Texture", "Border" }, { "Cooldown", "Cooldown" },
		{ "Texture", "NormalTexture", "normal" },
	},
	PetActionButtonTemplate = {
		inherits = "ActionButtonTemplate",
		{ "Texture", "AutoCastable" }, { "Frame", "Shine" }, { "Texture", "NormalTexture2", "normal" },
	},
	ShapeshiftButtonTemplate = { inherits = "ActionButtonTemplate" },
	ActionBarButtonTemplate = { inherits = "ActionButtonTemplate" },
	OptionsSliderTemplate = {
		{ "FontString", "Text" }, { "FontString", "Low" }, { "FontString", "High" }, { "Texture", "Thumb", "thumb" },
	},
	UIPanelButtonTemplate = {
		{ "Texture", "Left" }, { "Texture", "Middle" }, { "Texture", "Right" }, { "FontString", "Text", "text" },
	},
	UIPanelButtonTemplate2 = {
		{ "Texture", "Left" }, { "Texture", "Middle" }, { "Texture", "Right" }, { "FontString", "Text", "text" },
	},
	InterfaceOptionsCheckButtonTemplate = { { "FontString", "Text" } },
	OptionsCheckButtonTemplate = { { "FontString", "Text" } },
	UICheckButtonTemplate = { { "FontString", "Text" } },
	UIRadioButtonTemplate = { { "FontString", "Text" } },
	LootButtonTemplate = {
		{ "Texture", "IconTexture" }, { "FontString", "Count" }, { "FontString", "Text" }, { "Texture", "NameFrame" },
		{ "Texture", "IconQuestTexture" },
	},
	UIDropDownMenuTemplate = {
		{ "Texture", "Left" }, { "Texture", "Middle" }, { "Texture", "Right" }, { "FontString", "Text" },
		{ "Button", "Button" }, { "Texture", "Icon" },
	},
	InputBoxTemplate = { { "Texture", "Left" }, { "Texture", "Middle" }, { "Texture", "Right" } },
	UIPanelScrollFrameTemplate = { { "Slider", "ScrollBar" } },
	GameTooltipTemplate = {},
	CooldownFrameTemplate = {},
	ItemButtonTemplate = {
		{ "Texture", "IconTexture" }, { "FontString", "Count" }, { "FontString", "Stock" },
		{ "Texture", "NormalTexture", "normal" },
	},
}

local SECURE_TEMPLATES = {
	SecureHandlerStateTemplate = true, SecureHandlerAttributeTemplate = true, SecureHandlerClickTemplate = true,
	SecureHandlerBaseTemplate = true, SecureHandlerShowHideTemplate = true, SecureHandlerEnterLeaveTemplate = true,
	SecureActionButtonTemplate = true, SecureUnitButtonTemplate = true, SecureFrameTemplate = true,
	SecureGroupHeaderTemplate = true, SecurePartyHeaderTemplate = true, SecureRaidGroupHeaderTemplate = true,
	SecureAnchorButtonTemplate = true, SecureHandlerDragTemplate = true, SecureHandlerMouseUpDownTemplate = true,
	SecureHandlerMouseWheelTemplate = true, ActionButtonTemplate = true, PetActionButtonTemplate = true,
	ShapeshiftButtonTemplate = true,
}

local function addTemplateChildren(frame, template, made)
	local children = TEMPLATE_CHILDREN[template]
	if not children then
		return
	end
	if children.inherits then
		addTemplateChildren(frame, children.inherits, made)
	end
	local s = state[frame]
	for _, child in ipairs(children) do
		local widgetType, suffix, role = child[1], child[2], child[3]
		if not made[suffix] then
			made[suffix] = true
			local widget = Widgets.new(widgetType, s.name and (s.name .. suffix), frame)
			if role == "normal" and frame.SetNormalTexture then
				s.normalTexture = widget
			elseif role == "thumb" then
				s.thumb = widget
			elseif role == "text" then
				s.fontString = widget
			end
			if suffix == "Text" and s.class.isA.CheckButton then
				rawset(frame, "text", widget)
			end
		end
	end
end

local function applyTemplates(frame, templates)
	if not templates then
		return
	end
	local s = state[frame]
	local made = {}
	for template in templates:gmatch("[^,%s]+") do
		if SECURE_TEMPLATES[template] then
			s.protected = true
		end
		if template:match("^SecureHandler") then
			s.secureTemplates = s.secureTemplates or {}
			s.secureTemplates[template] = true
			for key, value in pairs(client.secure.headerMethods()) do
				rawset(frame, key, value)
			end
			if template == "SecureHandlerClickTemplate" then
				s.scripts.OnClick = client.secure.onClick
			end
		end
		addTemplateChildren(frame, template, made)
	end
	s.templates = templates
end

local nextWidgetId = 0

-- Creates a widget of `widgetType`. `parent` may be a widget, a name, or nil.
function Widgets.new(widgetType, name, parent, templates)
	local class = classes[widgetType]
	assert(class, "CreateFrame: unknown frame type " .. tostring(widgetType))
	assert(name == nil or type(name) == "string", "CreateFrame: the name must be a string or nil, got a " .. type(name))
	if type(parent) == "string" then
		parent = _G[parent]
	end
	parent = resolve(parent)
	if name and name:find("$parent", 1, true) then
		local parentName = parent and state[parent] and state[parent].name or ""
		name = name:gsub("%$parent", parentName)
	end
	nextWidgetId = nextWidgetId + 1
	local handle = newproxy(false)
	local widget = setmetatable({ [0] = handle }, class.meta)
	handles[handle] = widget
	state[widget] = {
		id = nil,
		serial = nextWidgetId,
		class = class,
		name = name,
		parent = nil,
		shown = true,
		alpha = 1,
		scale = 1,
		width = 0,
		height = 0,
		points = {},
		children = {},
		scripts = {},
		hooks = {},
		events = {},
		attributes = {},
		frameLevel = parent and state[parent] and state[parent].frameLevel and (state[parent].frameLevel + 1) or 1,
		frameStrata = nil,
		min = 0,
		max = 0,
		value = 0,
		numLines = 0,
		lines = {},
		messages = {},
		animations = {},
		text = nil,
	}
	if parent then
		assert(state[parent], "CreateFrame: parent isn't a widget")
		state[widget].parent = parent
		state[parent].children[widget] = true
	end
	if name then
		_G[name] = widget
	end
	client.widgets[#client.widgets + 1] = widget
	applyTemplates(widget, templates)
	return widget
end

-- A stand-in for the screen frames (UIParent, WorldFrame).
function Widgets.newScreen(name, width, height)
	local frame = Widgets.new("Frame", name)
	state[frame].isScreen = true
	state[frame].width, state[frame].height = width, height
	return frame
end

return Widgets
