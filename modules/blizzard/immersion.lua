-- Styles the Immersion addon's dialogue box like Diablo III's: a warm stone
-- panel in bronze lines instead of its "talking head" art, starting behind
-- the NPC's portrait, which stands taller than it (out over its top, its
-- bottom with the panel's), the name in gold serif inside it, the text in
-- white under it, the windows' close button in its corner, the model on
-- black in the panel's bronze lines, the quest's text and rewards under it
-- in the same, and the dialogue options as darker rows that light up red.
-- Backdrops, textures and fonts only: Immersion's own code is left as it is.
-- Only the dialogue Immersion (ImmersionFrame), not the addon of the same
-- name that hides the UI.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Immersion", "LOW")
local C = Engine:GetDB("Data: Colors")
local kit

-- Lua API
local _G = _G
local math_max = math.max
local pairs = pairs
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

-- Puts Immersion's art out of sight through its alpha: its code sets the
-- textures again, never the alpha, and its fade-ins only add to it.
local Hide = function(region)
	if region then
		region:SetAlpha(0)
	end
end

-- `backdrop` on one of Immersion's frames (none if nil), and again
-- whenever Immersion sets its own (its "solid background" option does).
Module.SetBackdrop = function(self, frame, backdrop, color, borderColor)
	frame:SetBackdrop(backdrop)
	if backdrop then
		frame:SetBackdropColor(unpack(color))
		frame:SetBackdropBorderColor(unpack(borderColor))
	end
	if (not frame.DiabolicBackdrop) then
		frame.DiabolicBackdrop = true
		hooksecurefunc(frame, "SetBackdrop", function(_, current)
			if (current ~= backdrop) then
				self:SetBackdrop(frame, backdrop, color, borderColor)
			end
		end)
	end
end

-- A dialogue option (Immersion's title buttons, made as they're needed).
Module.StyleOption = function(self, button)
	if (not button) or button.DiabolicStyled then
		return
	end
	button.DiabolicStyled = true
	local config = self.config
	local panel = Engine:GetModule("Blizzard: Windows").config.panel
	self:SetBackdrop(button, panel.backdrop, config.option_backdrop_color, panel.backdrop_border_color)
	-- its own edges, on its overlay frames: none, and ours in red on the
	-- one in focus (Immersion shows that one through the frame's alpha)
	if button.Overlay then
		button.Overlay:SetBackdrop(nil)
	end
	if button.Hilite then
		button.Hilite:SetBackdrop(config.option_focus_backdrop)
		button.Hilite:SetBackdropBorderColor(unpack(C.General.DimRed))
	end
	local highlight = button:GetHighlightTexture()
	if highlight then
		highlight:SetVertexColor(unpack(C.General.DimRed))
	end
end

Module.StyleImmersion = function(self)
	local config = self.config
	local talkBox = _G.ImmersionFrame.TalkBox

	-- the stone panel from under the model to the right, the quest text and
	-- rewards under it in the same; none of Immersion's own
	self:SetBackdrop(talkBox, nil)
	local panel = CreateFrame("Frame", nil, talkBox)
	-- under the box's text and model, which are drawn at the box's level
	panel:SetFrameLevel(math_max(talkBox:GetFrameLevel() - 1, 0))
	panel:SetPoint("TOPLEFT", talkBox, "TOPLEFT", config.panel_insets[1], config.panel_insets[2])
	panel:SetPoint("BOTTOMRIGHT", talkBox, "BOTTOMRIGHT", config.panel_insets[3], config.panel_insets[4])
	self:SetBackdrop(panel, config.backdrop, config.backdrop_color, config.backdrop_border_color)
	self.Panel = panel
	-- the quest's text and rewards under it in the same, only with some:
	-- Immersion leaves their frame shown at 1x1 without, which would draw
	-- a stub of the edge
	local elements = talkBox.Elements
	self:SetBackdrop(elements, nil)
	local rewards = CreateFrame("Frame", nil, elements)
	rewards:SetAllPoints()
	self:SetBackdrop(rewards, config.backdrop, config.backdrop_color, config.backdrop_border_color)
	local FitRewards = function()
		if (elements:GetHeight() > config.backdrop.edgeSize) then
			rewards:Show()
		else
			rewards:Hide()
		end
	end
	elements:HookScript("OnSizeChanged", FitRewards)
	FitRewards()
	Hide(talkBox.BackgroundFrame.TextBackground)
	Hide(talkBox.BackgroundFrame.SolidBackground)
	-- the windows' close button (windows.lua) in the panel's corner
	local close = talkBox.MainFrame.CloseButton
	if close then
		kit:SkinClose(close) -- no iron frame for a socket: its own place
		close:SetFrameLevel(panel:GetFrameLevel() + 5)
		close:ClearAllPoints()
		close:SetPoint("TOPRIGHT", panel, "TOPRIGHT", unpack(config.close_offset))
		-- the quest's mark (?, !) left of it, not over the panel's edge
		local mark = talkBox.MainFrame.Indicator
		if mark then
			mark:ClearAllPoints()
			mark:SetPoint("RIGHT", close, "LEFT", -config.mark_gap, 0)
		end
	end

	-- its glow under the mouse: our red edge around the panel, not its
	-- blue one around the whole box
	local hilite = talkBox.Hilite
	if hilite then
		hilite:ClearAllPoints()
		hilite:SetAllPoints(panel)
		self:SetBackdrop(hilite, config.option_focus_backdrop, config.hilite_color, C.General.DimRed)
	end

	-- the model on black in the panel's bronze lines (Diablo III's
	-- portrait), instead of the round frame and its glows
	local model = talkBox.MainFrame.Model
	Hide(model.PortraitBG)
	Hide(talkBox.MainFrame.Overlay)
	Hide(talkBox.PortraitFrame.Portrait)
	local back = CreateFrame("Frame", nil, model:GetParent())
	back:SetFrameLevel(math_max(model:GetFrameLevel() - 1, 0))
	back:SetAllPoints(model)
	back:SetBackdrop({ bgFile = config.backdrop.bgFile })
	back:SetBackdropColor(unpack(config.model_backdrop_color))
	local pad = config.portrait_padding
	local border = CreateFrame("Frame", nil, model)
	border:SetFrameLevel(model:GetFrameLevel() + 2)
	border:SetPoint("TOPLEFT", model, "TOPLEFT", -pad, pad)
	border:SetPoint("BOTTOMRIGHT", model, "BOTTOMRIGHT", pad, -pad)
	border:SetBackdrop({ edgeFile = config.backdrop.edgeFile, edgeSize = config.backdrop.edgeSize })
	border:SetBackdropBorderColor(unpack(config.backdrop_border_color))

	-- the name in gold serif inside the panel, the text under it in white,
	-- inside it too (Immersion's ends under the box). Immersion picks the
	-- text's font again for each line, which resets its color.
	local name = talkBox.NameFrame.Name
	name:SetFontObject(config.name_font)
	name:SetTextColor(unpack(config.name_color))
	name:ClearAllPoints()
	name:SetPoint("TOPLEFT", panel, "TOPLEFT", unpack(config.name_offset))
	local text = talkBox.TextFrame.Text
	text:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", unpack(config.text_bottom_right))
	text:SetTextColor(unpack(config.text_color))
	hooksecurefunc(text, "SetFontObject", function()
		text:SetTextColor(unpack(config.text_color))
	end)

	-- the dialogue options, those made already and those to come
	local titles = _G.ImmersionFrame.TitleButtons
	for _, button in pairs(titles.Buttons) do
		self:StyleOption(button)
	end
	hooksecurefunc(titles, "GetButton", function(_, index)
		self:StyleOption(titles.Buttons[index])
	end)
end

-- the dialogue Immersion, once it has made its frame
local IsLoaded = function()
	local frame = _G.ImmersionFrame
	return frame and frame.TalkBox and frame.TitleButtons and true
end

Module.ADDON_LOADED = function(self)
	if IsLoaded() then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleImmersion()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").immersion
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if IsLoaded() then
		self:StyleImmersion()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
