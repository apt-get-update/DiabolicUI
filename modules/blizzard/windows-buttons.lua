-- What the windows' buttons and scroll bars get (windows.lua's kit): Blizzard's
-- art hidden, scroll bars in iron, each row of buttons fitted on one line.
local _, Engine = ...
local Module = Engine:GetModule("Blizzard: Windows")

-- Lua and WoW API
local _G = _G
local ipairs = ipairs
local table_sort = table.sort
local math_abs = math.abs
local math_max = math.max
local math_min = math.min
local pairs = pairs
local select = select
local unpack = unpack
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown

local Private = Module.Private
local NameFor = Private.NameFor

-- Where Blizzard places `frame` as a panel and how wide it is to the next
-- one, our window (`insets` past it) included: `x`, `y` move it.
Module.SetPanelLayout = function(self, frame, insets, x, y)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + insets[3])
	if x then
		frame:SetAttribute("UIPanelLayout-xoffset", x)
	end
	if y then
		frame:SetAttribute("UIPanelLayout-yoffset", y)
	end
end

-- The textures whose file matches one of `patterns` (lowercase, as
-- patterns), on `frame` and all it holds, out of sight through their
-- alpha (Blizzard sets their files again, never that).
Module.HideArt = function(self, frame, patterns)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		local file = region:IsObjectType("Texture") and region:GetTexture()
		if file then
			file = file:lower()
			for _, pattern in ipairs(patterns) do
				if file:find(pattern) then
					region:SetAlpha(0)
					break
				end
			end
		end
	end
	for i = 1, select("#", frame:GetChildren()) do
		self:HideArt((select(i, frame:GetChildren())), patterns)
	end
end

-- Blizzard's push buttons in `frame` and all it holds as ours, at their
-- own height; each once. UIPanelButtonTemplate's art is the button's,
-- UIPanelButtonTemplate2's three named textures.
local IsPanelButton = function(button)
	local name = button:GetName()
	local texture = button:GetNormalTexture() or (name and _G[name .. "Left"])
	local file = texture and texture.GetTexture and texture:GetTexture()
	return file and file:lower():find("ui%-panel%-button")
end

local CollectButtons
CollectButtons = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsObjectType("Button") and not child.DiabolicStyled and IsPanelButton(child) then
			found[#found + 1] = child
		end
		CollectButtons(child, found)
	end
	return found
end

-- Every button StyleButtons styled in `frame` (an addon's, added later,
-- too).
local CollectStyled
CollectStyled = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child.DiabolicPanelButton then
			found[#found + 1] = child
		end
		CollectStyled(child, found)
	end
	return found
end

-- An edit box's label (`text`) pale in it while it's empty and not typed
-- in (window.hint's look).
Module.AddHint = function(self, box, text)
	local spec = Module.config.hint
	local hint = box:CreateFontString(nil, "OVERLAY")
	hint:SetFontObject(spec.font)
	hint:SetTextColor(unpack(spec.color))
	hint:SetPoint("LEFT", box, "LEFT", spec.inset, 0)
	hint:SetText(text)
	local Update = function()
		if (box:GetText() == "") and not box.DiabolicFocused then
			hint:Show()
		else
			hint:Hide()
		end
	end
	box:HookScript("OnEditFocusGained", function()
		box.DiabolicFocused = true
		Update()
	end)
	box:HookScript("OnEditFocusLost", function()
		box.DiabolicFocused = nil
		Update()
	end)
	box:HookScript("OnTextChanged", Update)
	Update()
	return hint
end

-- Whether every button's text fits in it (Blizzard sized them for its own
-- font).
local AllFit = function(buttons)
	for _, button in ipairs(buttons) do
		if button:GetTextWidth() > button:GetWidth() - Module.config.button_text_margin * 2 then
			return false
		end
	end
	return true
end

-- A scroll bar (UIPanelScrollBarTemplate's, HybridScrollBarTemplate's) as
-- Diablo III's: a black track in a thin bronze line, its arrows and its
-- thumb (three grips) in red, lit under the mouse; each once.
Module.StyleScrollBar = function(self, bar)
	local name = bar:GetName()
	local up, down = name and _G[name .. "ScrollUpButton"], name and _G[name .. "ScrollDownButton"]
	if bar.DiabolicStyled or not (up and down) then
		return
	end
	bar.DiabolicStyled = true
	bar.DiabolicStyle, up.DiabolicStyle, down.DiabolicStyle = "ScrollBar", "ScrollBar", "ScrollBar"
	local spec = Module.config.scrollbar
	-- its own track (the hybrid ones have one, the light ones an edge)
	local thumb = bar:GetThumbTexture()
	for i = 1, select("#", bar:GetRegions()) do
		local region = select(i, bar:GetRegions())
		if region:IsObjectType("Texture") and (region ~= thumb) then
			region:SetAlpha(0)
		end
	end
	if bar.SetBackdrop then
		bar:SetBackdrop(nil)
	end
	for button, art in pairs({ [up] = spec.up, [down] = spec.down }) do
		button:SetSize(spec.width, spec.width)
		button:SetNormalTexture(art.normal)
		button:SetPushedTexture(art.lit)
		button:SetDisabledTexture(art.disabled)
		button:SetHighlightTexture(art.lit)
		button:GetHighlightTexture():SetBlendMode("BLEND")
		for _, texture in ipairs({
			button:GetNormalTexture(),
			button:GetPushedTexture(),
			button:GetDisabledTexture(),
			button:GetHighlightTexture(),
		}) do
			texture:SetTexCoord(unpack(spec.arrow_texcoords))
			texture:ClearAllPoints()
			texture:SetAllPoints()
		end
	end
	thumb:SetTexture(spec.thumb)
	thumb:SetTexCoord(unpack(spec.thumb_texcoords))
	thumb:SetSize(spec.width, spec.thumb_height)
	-- the track from the up arrow's top to the down arrow's bottom, the
	-- line just outside it
	local track = CreateFrame("Frame", NameFor(bar, "DiabolicTrack"), bar)
	track:SetFrameLevel(math_max(bar:GetFrameLevel() - 1, 0))
	track:SetPoint("TOP", up, "TOP", 0, spec.line)
	track:SetPoint("BOTTOM", down, "BOTTOM", 0, -spec.line)
	track:SetWidth(spec.width + spec.line * 2)
	track:SetBackdrop({
		bgFile = spec.blank,
		edgeFile = spec.blank,
		edgeSize = spec.line,
		insets = { left = spec.line, right = spec.line, top = spec.line, bottom = spec.line },
	})
	track:SetBackdropColor(unpack(spec.track_color))
	track:SetBackdropBorderColor(unpack(spec.line_color))
end

-- The scroll bars in `frame` and all it holds as ours.
Module.StyleScrollBars = function(self, frame)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsObjectType("Slider") then
			self:StyleScrollBar(child)
		end
		self:StyleScrollBars(child)
	end
end

-- A part's scale on screen (a texture's or a text's: its frame's, as
-- 3.3.5's regions have none of their own).
local ScaleOf = function(part)
	return (part.GetEffectiveScale and part or part:GetParent()):GetEffectiveScale()
end
Module.ScaleOf = ScaleOf

-- A part's sides on screen (in the screen's units, whatever its scale):
-- left, bottom, right, top.
local Edges = function(part)
	local left, bottom, width, height = part:GetRect()
	if not left then
		return
	end
	local scale = ScaleOf(part)
	return left * scale, bottom * scale, (left + width) * scale, (bottom + height) * scale
end
Module.Edges = Edges

-- Our buttons shown in `frame` and all it holds (not those out of sight,
-- nor our other parts: dropdowns, edit boxes).
local CollectShown
CollectShown = function(frame, found)
	for i = 1, select("#", frame:GetChildren()) do
		local child = select(i, frame:GetChildren())
		if child:IsVisible() then
			if child.DiabolicStyled and child:IsObjectType("Button") and (child:GetAlpha() > 0) and child:GetLeft() then
				found[#found + 1] = child
			end
			CollectShown(child, found)
		end
	end
	return found
end
Module.CollectShown = CollectShown

local ByLeft = function(a, b)
	return (Edges(a)) < (Edges(b))
end

-- `buttons` (a row's, left to right) too close: as wide in all, each as
-- much narrower, window.layout.button_gap apart, each placed on its own
-- from `frame`'s nearer corner (Blizzard chains them either way round).
local Spread = function(frame, buttons)
	for _, button in ipairs(buttons) do
		if button:IsProtected() and InCombatLockdown() then
			return
		end
	end
	local scale = buttons[1]:GetEffectiveScale()
	local gap = Module.config.layout.button_gap * scale
	local left = Edges(buttons[1])
	local _, _, right = Edges(buttons[#buttons])
	local widths = 0
	for _, button in ipairs(buttons) do
		widths = widths + button:GetWidth() * scale
	end
	local fit = (right - left - gap * (#buttons - 1)) / widths
	if fit <= 0 then
		return
	end
	local frameLeft, frameBottom, frameRight, frameTop = Edges(frame)
	local _, bottom, _, top = Edges(buttons[1])
	local side = ((left + right) / 2 < (frameLeft + frameRight) / 2) and "LEFT" or "RIGHT"
	local edge = ((bottom + top) / 2 < (frameBottom + frameTop) / 2) and "BOTTOM" or "TOP"
	local x = left
	for _, button in ipairs(buttons) do
		local width = button:GetWidth() * scale * fit
		local _, buttonBottom, _, buttonTop = Edges(button)
		local dx = (side == "LEFT") and (x - frameLeft) or (x + width - frameRight)
		local dy = (edge == "BOTTOM") and (buttonBottom - frameBottom) or (buttonTop - frameTop)
		button:SetWidth(width / scale)
		button:ClearAllPoints()
		button:SetPoint(edge .. side, frame, edge .. side, dx / scale, dy / scale)
		x = x + width + gap
	end
end

-- The rule for buttons on a row: our buttons shown in `frame` whose
-- middles are level and that touch or nearly (closer than
-- window.layout.button_gap, but not one over another) spread apart.
local LineRows = function(frame)
	local wanted = Module.config.layout.button_gap
	local buttons = CollectShown(frame, {})
	table_sort(buttons, ByLeft)
	local taken = {}
	for i, first in ipairs(buttons) do
		if not taken[first] then
			local _, bottom, _, top = Edges(first)
			local row = { first }
			for j = i + 1, #buttons do
				local other = buttons[j]
				local _, otherBottom, _, otherTop = Edges(other)
				if (not taken[other]) and (math_abs((otherBottom + otherTop - bottom - top) / 2) <= 2) then
					row[#row + 1] = other
					taken[other] = true
				end
			end
			local close = { first }
			for k = 2, #row + 1 do
				local before, button = row[k - 1], row[k]
				local apart
				if button then
					local _, _, beforeRight = Edges(before)
					apart = ((Edges(button)) - beforeRight) / button:GetEffectiveScale()
				end
				if
					apart
					and (apart < wanted - 0.5)
					and (apart > -math_min(before:GetWidth(), button:GetWidth()) / 2)
				then
					close[#close + 1] = button
				else
					if #close > 1 then
						Spread(frame, close)
					end
					close = { button }
				end
			end
		end
	end
end

-- Frames whose rows are lined up on the next frame drawn (once Blizzard
-- has placed what it shows).
local Queued = {}
local Liner -- (OnInit)
local QueueRows = function(frame)
	Queued[frame] = true
	if Liner then
		Liner:Show()
	end
end

-- The buttons (and the scroll bars, theirs too) of `frame` and all it
-- holds; their rows lined up (LineRows) as they show.
Module.StyleButtons = function(self, frame)
	self:StyleScrollBars(frame)
	local buttons = CollectButtons(frame, {})
	QueueRows(frame)
	for _, button in ipairs(buttons) do
		button.DiabolicStyled = true
		button.DiabolicPanelButton = true
		button:HookScript("OnShow", function()
			QueueRows(frame)
		end)
		local name = button:GetName()
		for _, part in ipairs({ "Left", "Middle", "Right" }) do
			local region = name and _G[name .. part]
			if region and region.SetAlpha then
				region:SetAlpha(0)
			end
		end
		self:StyleButton(button, button:GetHeight())
	end
	-- one font for all the window's buttons (those styled before too: an
	-- addon's, added later), the first in which every text fits: they read
	-- as one
	local all = CollectStyled(frame, {})
	local fonts = { Module.config.button_font, Module.config.button_font_small, Module.config.button_font_narrow }
	for _, font in ipairs(fonts) do
		for _, button in ipairs(all) do
			self:SetButtonFont(button, font)
		end
		if AllFit(all) then
			break
		end
	end
end

-- The frame that lines the queued rows up on the next frame (OnInit, when skinning).
Module.StartLiner = function(self)
	Liner = CreateFrame("Frame")
	Liner:Hide()
	Liner:SetScript("OnUpdate", function()
		Liner:Hide()
		for frame in pairs(Queued) do
			Queued[frame] = nil
			if frame:IsVisible() then
				LineRows(frame)
			end
		end
	end)
end
