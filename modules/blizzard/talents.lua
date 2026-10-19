-- Gives Blizzard's talent window Diablo III's (windows.lua), once it loads:
-- the stone window in its iron frame, the title in the plate over the red
-- band, the specs (primary, secondary, pet) as icons at the band's left
-- end and the spec's state (or its Activate button) in its middle, the
-- trees' and glyphs' tabs under it, the tree's art in a darker panel, the
-- points and the preview's Learn and Reset at the bottom. The glyphs fit
-- in the same place.
-- Art, fonts and places only: Blizzard's code is left as it is.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Talents", "LOW")

local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local select = select
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded

local NUM_SPECS = 3 -- the player's two and the pet's
local NUM_TABS = 4 -- three trees and the glyphs

-- Named textures out of sight.
local Hide = function(...)
	for i = 1, select("#", ...) do
		local region = _G[(select(i, ...))]
		if region then
			region:SetAlpha(0)
		end
	end
end

-- The specs shown, in a row at the band's left end (Blizzard stacks them
-- down the frame's side each update).
Module.LayoutSpecs = function(self)
	local config = self.config
	local previous
	for i = 1, NUM_SPECS do
		local tab = _G["PlayerSpecTab" .. i]
		if tab:IsShown() then
			tab:ClearAllPoints()
			if previous then
				tab:SetPoint("LEFT", previous, "RIGHT", config.spec_gap, 0)
			else
				tab:SetPoint("LEFT", self.Header, "LEFT", config.spec_offset, 0)
			end
			previous = tab
		end
	end
end

-- The points under the tree, the preview's bar under them when it shows
-- (Blizzard puts them back each update).
Module.LayoutBars = function(self)
	local bar = _G.PlayerTalentFramePointsBar
	if not _G.PlayerTalentFramePreviewBar:IsShown() then
		bar:SetPoint("BOTTOM", self.Window, "BOTTOM", 0, self.config.bars_bottom)
	end
end

-- The glyphs in the tree's place: their art cropped to its parchment
-- (without the portrait's ring and the title bar Blizzard's frame had),
-- scaled to fit under the tabs and centred, on a cover of the window's
-- stone hiding the tree and the points (their sockets keep their places
-- on the art).
Module.LayoutGlyphs = function(self)
	local config = self.config
	local glyphs = _G.GlyphFrame
	local x, y, width, height = unpack(config.glyph_art)
	local scale = config.glyph_height / height
	glyphs:SetScale(scale)
	glyphs:ClearAllPoints()
	glyphs:SetPoint("TOPLEFT", self.Window, "TOPLEFT",
		(self.Window:GetWidth() - width * scale) / 2 / scale - x, config.glyph_top / scale + y)
	local art = _G.GlyphFrameBackground
	art:ClearAllPoints()
	art:SetPoint("TOPLEFT", glyphs, "TOPLEFT", x, -y)
	art:SetSize(width, height)
	art:SetTexCoord(x / 512, (x + width) / 512, y / 512, (y + height) / 512)
	-- the mouse on the art only: the frame reaches up over the tabs
	glyphs:SetHitRectInsets(x, glyphs:GetWidth() - x - width, y, glyphs:GetHeight() - y - height)
	Hide("GlyphFrameTitleText")
end

-- The art's top left corner, where the portrait's ring was, as its top
-- right one turned over.
Module.AddGlyphCorner = function(self)
	local config = self.config
	local x, y, width = unpack(config.glyph_art)
	local size = config.glyph_corner
	local corner = _G.GlyphFrame:CreateTexture(nil, "ARTWORK", nil)
	corner:SetTexture(_G.GlyphFrameBackground:GetTexture())
	corner:SetSize(size, size)
	corner:SetPoint("TOPLEFT", _G.GlyphFrameBackground, "TOPLEFT")
	corner:SetTexCoord((x + width) / 512, (x + width - size) / 512, y / 512, (y + size) / 512)
end

Module.StyleGlyphs = function(self)
	local glyphs = _G.GlyphFrame
	if glyphs and (not self.GlyphsStyled) then
		self.GlyphsStyled = true
		local cover = kit:CreateCover(self.Window, self.config.glyph_cover_insets, self.config.glyph_cover_level)
		-- the tree's scroll bar is drawn as high as the cover: out of sight
		-- with the tree
		local bar = _G.PlayerTalentFrameScrollFrameScrollBar
		local show = function()
			self:LayoutGlyphs()
			cover:Show()
			bar:SetAlpha(0)
		end
		local hide = function()
			cover:Hide()
			bar:SetAlpha(1)
		end
		self:AddGlyphCorner()
		if glyphs:IsShown() then
			show()
		else
			hide()
		end
		glyphs:HookScript("OnShow", show)
		glyphs:HookScript("OnHide", hide)
	end
end

Module.StyleTalents = function(self)
	local config = self.config
	local frame = _G.PlayerTalentFrame

	local window = kit:CreateWindow(frame, config.insets)
	self.Window = window
	kit:AddDrag(window, frame)
	kit:HideTextures(frame)
	frame:SetAttribute("UIPanelLayout-width", frame:GetWidth() + config.insets[3])
	self.Header = kit:CreateHeader(window, config.header_height, config.header_insets)
	kit:SetTitle(self.Header, _G.PlayerTalentFrameTitleText)
	kit:StyleClose(_G.PlayerTalentFrameCloseButton, window, self.Header)

	-- the specs in the band, as icons in the action buttons' border
	for i = 1, NUM_SPECS do
		local tab = _G["PlayerSpecTab" .. i]
		Hide(tab:GetName() .. "Background")
		tab:SetFrameLevel(window:GetFrameLevel() + 4)
		tab:SetSize(config.spec_size, config.spec_size)
		kit:AddBorder(tab, config.spec_size)
	end
	hooksecurefunc("PlayerTalentFrame_UpdateSpecs", function() self:LayoutSpecs() end)
	self:LayoutSpecs()

	-- the spec's state, or the button that makes it the active one, in the
	-- band's middle
	local status = _G.PlayerTalentFrameStatusFrame
	Hide("PlayerTalentFramePointsLeft", "PlayerTalentFramePointsMiddle", "PlayerTalentFramePointsRight")
	status:ClearAllPoints()
	status:SetPoint("CENTER", self.Header, "CENTER", 0, 0)
	kit:SetBandCenter(self.Header, _G.PlayerTalentFrameStatusText)
	_G.PlayerTalentFrameStatusText:SetTextColor(unpack(config.status_color))
	local activate = _G.PlayerTalentFrameActivateButton
	activate:ClearAllPoints()
	activate:SetPoint("CENTER", self.Header, "CENTER", 0, 0)
	activate:SetFrameLevel(window:GetFrameLevel() + 4)
	kit:StyleButton(activate, config.button_height)
	-- as wide as its text in our font, with room at its ends (Blizzard's
	-- width is for its own smaller font)
	local fit = function()
		activate:SetWidth(activate:GetTextWidth() + config.activate_padding * 2)
	end
	fit()
	activate:HookScript("OnShow", fit)

	-- the tabs in a row under the band (Blizzard sizes them)
	local tab = _G.PlayerTalentFrameTab1
	tab:ClearAllPoints()
	tab:SetPoint("TOPLEFT", self.Header, "BOTTOMLEFT", unpack(config.tab_offset))
	kit:AddTabStrip(self.Header)
	for i = 1, NUM_TABS do
		kit:StyleTab(_G["PlayerTalentFrameTab" .. i], { inset = config.tab_inset, font = config.tab_font })
	end

	-- the tree in a darker panel, its scroll bar inside it
	local scroll = _G.PlayerTalentFrameScrollFrame
	Hide("PlayerTalentFrameScrollFrameBackgroundTop", "PlayerTalentFrameScrollFrameBackgroundBottom")
	local bar = _G.PlayerTalentFramePointsBar
	scroll:ClearAllPoints()
	scroll:SetPoint("TOPLEFT", window, "TOPLEFT", unpack(config.tree))
	scroll:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", config.tree[1] - config.bars_inset, config.tree_gap)
	local insets = config.tree_panel_insets
	local panel = CreateFrame("Frame", nil, frame)
	panel:SetFrameLevel(frame:GetFrameLevel())
	panel:SetPoint("TOPLEFT", scroll, "TOPLEFT", -insets[1], insets[2])
	panel:SetPoint("BOTTOMRIGHT", scroll, "BOTTOMRIGHT", insets[3], -insets[4])
	kit:StylePanel(panel)

	-- the points, and the preview's buttons under them
	Hide("PlayerTalentFramePointsBarBackground", "PlayerTalentFramePointsBarBorderLeft",
		"PlayerTalentFramePointsBarBorderRight", "PlayerTalentFramePointsBarBorderMiddle",
		"PlayerTalentFramePreviewBarButtonBorder", "PlayerTalentFramePreviewBarFillerButtonBackgroundLeft",
		"PlayerTalentFramePreviewBarFillerButtonBackgroundRight", "PlayerTalentFramePreviewBarFillerButtonBackgroundMiddle")
	local preview = _G.PlayerTalentFramePreviewBar
	for _, row in ipairs({ bar, preview }) do
		row:ClearAllPoints()
		row:SetPoint("LEFT", window, "LEFT", config.bars_inset, 0)
		row:SetPoint("RIGHT", window, "RIGHT", -config.bars_inset, 0)
	end
	preview:SetPoint("BOTTOM", window, "BOTTOM", 0, config.bars_bottom)
	self:LayoutBars()
	hooksecurefunc("PlayerTalentFrame_UpdateControls", function() self:LayoutBars() end)
	for _, button in ipairs({ _G.PlayerTalentFrameLearnButton, _G.PlayerTalentFrameResetButton }) do
		kit:StyleButton(button, config.button_height)
	end

	self:StyleGlyphs()
	kit:StyleScrollBars(frame)
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == "Blizzard_TalentUI") then
		self:StyleTalents()
	elseif (addon == "Blizzard_GlyphUI") and self.Window then
		self:StyleGlyphs()
	end
	if self.Window and self.GlyphsStyled then
		self:UnregisterEvent("ADDON_LOADED")
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").talents
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	if IsAddOnLoaded("Blizzard_TalentUI") then
		self:StyleTalents()
	end
	if not (self.Window and self.GlyphsStyled) then
		self:RegisterEvent("ADDON_LOADED")
	end
end
