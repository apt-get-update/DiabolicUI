-- Gives Blizzard's stack split box (shift-click a stack) and its coins'
-- (a click on your money) Diablo III's: its stone with the count in the
-- black field between its two arrow boxes (the coins' sum with our coin),
-- Okay and Cancel in its red buttons, in our windows' iron frame. Art,
-- fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: StackSplit", "LOW")

local kit

-- Lua API
local _G = _G
local pairs = pairs
local select = select
local unpack = unpack

-- A part of the atlas, at `x`, `y` and `width` by `height`, as texcoords.
local Coords = function(spec, x, y, width, height)
	local w, h = spec.atlas_size[1], spec.atlas_size[2]
	return x / w, (x + width) / w, y / h, (y + height) / h
end

-- `button`'s states from the atlas: `states` holds each one's top left,
-- all `width` by `height`; the lit one drawn as it is, not added.
local SetStates = function(spec, button, states, width, height)
	button:SetNormalTexture(spec.texture)
	button:SetPushedTexture(spec.texture)
	button:SetDisabledTexture(spec.texture)
	button:SetHighlightTexture(spec.texture)
	button:GetHighlightTexture():SetBlendMode("BLEND")
	local textures = { normal = button:GetNormalTexture(), pushed = button:GetPushedTexture(),
		disabled = button:GetDisabledTexture(), lit = button:GetHighlightTexture() }
	for state, texture in pairs(textures) do
		local place = states[state]
		texture:SetTexCoord(Coords(spec, place[1], place[2], width, height))
	end
end

-- The box `prefix` .. "Frame" and its parts (Blizzard names them alike).
Module.StyleSplit = function(self, prefix)
	local spec = self.config
	local frame = _G[prefix .. "Frame"]
	local scale = spec.scale

	-- Blizzard's money frame art out of sight, Diablo III's stone (inside
	-- its own frame) in its place, our iron around it
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		local file = region:IsObjectType("Texture") and region:GetTexture()
		if file and file:lower():find("ui%-moneyframe") then
			region:SetAlpha(0)
		end
	end
	local x, y, width, height = unpack(spec.panel)
	local border = spec.border -- our iron's width, outside the stone
	frame:SetSize(width * scale + border * 2, height * scale + border * 2)
	frame:SetBackdrop({ edgeFile = kit.config.backdrop.edgeFile, edgeSize = kit.config.backdrop.edgeSize })
	frame:SetBackdropBorderColor(unpack(kit.config.backdrop_border_color))
	local panel = frame:CreateTexture(nil, "BACKGROUND", nil, -8) -- under the count
	panel:SetTexture(spec.texture)
	panel:SetTexCoord(Coords(spec, x, y, width, height))
	panel:SetPoint("TOPLEFT", border, -border)
	panel:SetPoint("BOTTOMRIGHT", -border, border)

	-- a place in the stone's art, from the frame's top left
	local Place = function(place)
		return border + place[1] * scale, -border + place[2] * scale
	end

	local text = _G[prefix .. "Text"]
	text:ClearAllPoints()
	text:SetPoint("CENTER", frame, "TOPLEFT", Place(spec.text))

	local arrow = spec.arrow_size * scale
	for side, name in pairs({ left = "LeftButton", right = "RightButton" }) do
		local button, states = _G[prefix .. name], {}
		for state, at in pairs(spec.arrows[side]) do
			states[state] = { at, spec.arrows_y }
		end
		SetStates(spec, button, states, spec.arrow_size, spec.arrow_size)
		button:SetSize(arrow, arrow)
		button:ClearAllPoints()
		button:SetPoint("CENTER", frame, "TOPLEFT", Place(spec[side]))
	end

	-- Okay and Cancel: normal and lit drawn under their text (their own
	-- normal art over the lit one, the highlight layer over the text)
	local states = spec.button_states
	for place, name in pairs({ okay = "OkayButton", cancel = "CancelButton" }) do
		local button = _G[prefix .. name]
		SetStates(spec, button, { normal = states.normal, lit = states.lit, pushed = states.dark, disabled = states.dark },
			spec.button[1], spec.button[2])
		button:GetNormalTexture():SetAlpha(0)
		button:GetHighlightTexture():SetAlpha(0)
		button:SetSize(spec.button[1] * scale, spec.button[2] * scale)
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", Place(spec[place]))
		kit:SetButtonFont(button, kit.config.button_font)
		for layer, state in pairs({ BACKGROUND = states.normal, BORDER = states.lit }) do
			local art = button:CreateTexture(nil, layer)
			art:SetTexture(spec.texture)
			art:SetTexCoord(Coords(spec, state[1], state[2], spec.button[1], spec.button[2]))
			art:SetAllPoints()
			if (layer == "BORDER") then
				button.DiabolicNotLit = function() return button:IsEnabled() == 0 end
				kit:AddLit(button, art)
			end
		end
	end
end

-- The coins' box as the stack's, the sum and its coin (ours, the one
-- shown) together in the middle of the black field.
Module.StyleCoinPickup = function(self)
	local frame = _G.CoinPickupFrame
	self:StyleSplit("CoinPickup")
	kit:StyleCoins(frame)
	local spec, text = self.config, _G.CoinPickupText
	local x, y = spec.border + spec.text[1] * spec.scale, -spec.border + spec.text[2] * spec.scale
	text:SetPoint("CENTER", frame, "TOPLEFT", x - (spec.coin_size + spec.coin_gap) / 2, y)
	for _, kind in pairs({ "Gold", "Silver", "Copper" }) do
		local coin = _G["CoinPickup" .. kind .. "Icon"]
		coin:SetSize(spec.coin_size, spec.coin_size)
		coin:ClearAllPoints()
		coin:SetPoint("LEFT", text, "RIGHT", spec.coin_gap, 0)
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").stacksplit
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	self:StyleSplit("StackSplit")
	self:StyleCoinPickup()
end
