-- Gives the Immersion addon's dialogue box DiabolicUI's look: the text and
-- the choices on warm dark glass in the tooltips' frame (see-through: the
-- world behind it), the NPC in Diablo III's bronze-edged frame (its
-- 2DUIConversation's), the windows' close button, the titles (the NPC's
-- name, the quest's headers) in Exocet, and our coins.
-- Only the dialogue Immersion (ImmersionFrame), not the addon of the same
-- name that hides the UI.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Immersion", "LOW")
local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local pairs = pairs
local unpack = unpack

-- WoW API
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

Module.StyleImmersion = function(self)
	local config = self.config
	local talkBox = _G.ImmersionFrame.TalkBox

	local close = talkBox.MainFrame.CloseButton
	if close then
		kit:SkinClose(close)
	end
	self:StyleBox(talkBox)
	self:FixKidCamera()
	if talkBox.Hilite then
		talkBox.Hilite:SetBackdrop(nil) -- (its blue edge, lit under the mouse)
	end

	-- in Exocet at their own color: Immersion sets that, never the font
	local Exocet = function(fontString, size)
		if fontString then
			fontString:SetFont(config.title_font, size, "")
		end
	end
	-- the choices, each as Immersion makes it
	local titles = _G.ImmersionFrame.TitleButtons
	for _, button in pairs(titles.Buttons) do
		self:StyleChoice(button)
	end
	hooksecurefunc(titles, "GetButton", function(_, index)
		self:StyleChoice(titles.Buttons[index])
	end)

	local elements = talkBox.Elements
	self:StyleElements(elements)
	local content = elements.Content
	local rewards = content.RewardsFrame
	Exocet(talkBox.NameFrame.Name, config.name_size)
	Exocet(content.ObjectivesHeader, config.header_size)
	Exocet(rewards.Header, config.header_size)
	Exocet(elements.Progress.ReqText, config.header_size)

	-- our coins in the money it gives or asks for, and on the reward
	-- worth the most
	local money = { [rewards.MoneyFrame] = true, [elements.Progress.MoneyFrame] = true }
	hooksecurefunc("MoneyFrame_Update", function(frame)
		frame = _G[frame] or frame
		if money[frame] then
			kit:StyleCoins(frame)
		end
	end)
	local coin = Engine:GetDB("UI").coin
	local icon = rewards.MoneyIcon
	icon:SetSize(unpack(coin.gold_size))
	icon.MoneyIcon:SetTexture(coin.gold_texture)
	icon.MoneyIcon:SetTexCoord(unpack(coin.gold_texcoord))
end

-- A child NPC in the portrait: Immersion's camera for children (one,
-- shared by them all) looks past them, the frame left empty; framed as
-- its grown-ups and gnomes are instead (its numbers ours).
Module.FixKidCamera = function(self)
	local cameras = _G.EnumConst and _G.EnumConst.UiModelPositionCamera
	local camera = cameras and cameras.Original and cameras.Original["humanmalekid/humanmalekid"]
	if camera then
		local x, y, z, yaw = unpack(self.config.kid_camera)
		camera[1], camera[2], camera[3], camera[4], camera[5] = x, y, z, yaw, true
	end
end

-- The quest's objectives and rewards under the box on the same plate and
-- smoke, in place of Immersion's backdrop (set again as its solid
-- background option changes).
Module.StyleElements = function(self, elements)
	elements:SetBackdrop(nil)
	hooksecurefunc(elements, "SetBackdrop", function(frame, backdrop)
		if backdrop then
			frame:SetBackdrop(nil)
		end
	end)
	self:AddSmoke(elements, self:AddPlate(elements, elements, self.config.plate.edge_size))
end

-- The tooltips' frame around warm dark glass in place of Immersion's art,
-- from under the portrait's frame (Diablo III's) to its right, as high as
-- that frame; black behind the model (shown with the portrait: Immersion
-- can turn it off); the X and the NPC's kind in the box's top right; what's
-- said in warm white, its pages' count in the titles' font.
Module.StyleBox = function(self, talkBox)
	local config = self.config
	local background, portrait = talkBox.BackgroundFrame, talkBox.PortraitFrame
	local main = talkBox.MainFrame
	local model = main.Model
	-- its art, the shadow over the model, and its glows and sheens on it
	-- (flashed as a box shows, some left lit beside the portrait)
	local overlay = main.Overlay or model.Overlay or {}
	for _, art in pairs({ background.TextBackground, background.SolidBackground, portrait.Portrait, model.PortraitBG,
		model.ModelShadow, main.Sheen, main.TextSheen, overlay.Glow_TopBar, overlay.Glow_LeftBar, overlay.Glow_RightBar }) do
		if art then
			art:SetTexture(nil)
		end
	end

	local scale = model:GetWidth() / config.glass[1]
	-- dark red glass, fading to black at its sides (a shade, black at its
	-- edges, a layer over it: textures sharing one aren't drawn in a set
	-- order)
	local glass = background:CreateTexture(nil, "BORDER")
	glass:SetTexture(unpack(config.vignette.color))
	glass:SetSize(config.glass[1] * scale, config.glass[2] * scale)
	glass:SetPoint("CENTER", model, "CENTER")
	local shade = background:CreateTexture(nil, "ARTWORK")
	shade:SetTexture(config.vignette.shade)
	shade:SetVertexColor(0, 0, 0)
	shade:SetAllPoints(glass)
	local frameWidth, frameHeight = unpack(config.portrait_size)
	local frame = portrait:CreateTexture(nil, "OVERLAY")
	frame:SetTexture(config.portrait)
	frame:SetTexCoord(0, frameWidth / 256, 0, frameHeight / 256)
	frame:SetSize(frameWidth * scale, frameHeight * scale)
	frame:SetPoint("CENTER", model, "CENTER", config.portrait_offset[1] * scale, config.portrait_offset[2] * scale)
	local back = { glass, shade }
	local Show = function(shown)
		for _, part in ipairs(back) do
			if shown then
				part:Show()
			else
				part:Hide()
			end
		end
	end
	portrait:HookScript("OnShow", function() Show(true) end)
	portrait:HookScript("OnHide", function() Show(false) end)
	Show(portrait:IsShown())

	-- the box: from under the portrait frame's right side (no left edge:
	-- the frame's), its top and bottom with the frame's art, not its
	-- shadow under it (Immersion's model is placed from the box's top left)
	local _, _, _, x, y = model:GetPoint()
	local middleX = x + model:GetWidth() / 2 + config.portrait_offset[1] * scale
	local middleY = y - model:GetHeight() / 2 + config.portrait_offset[2] * scale
	local canvasLeft, canvasTop = middleX - frameWidth * scale / 2, middleY + frameHeight * scale / 2
	local artTop, artBottom, artRight = unpack(config.portrait_art)
	local box = CreateFrame("Frame", nil, talkBox)
	box:SetPoint("TOPLEFT", talkBox, "TOPLEFT", canvasLeft + artRight * scale, canvasTop - artTop * scale)
	box:SetPoint("BOTTOMRIGHT", talkBox, "TOPRIGHT", -config.box_right, canvasTop - artBottom * scale)
	local fill = self:AddPlate(background, box, config.plate.edge_size, true)
	self:AddSmoke(background, fill)
	self:AddRule(background, talkBox.NameFrame.Name)

	local close = main.CloseButton
	if close then
		close:ClearAllPoints()
		close:SetPoint("TOPRIGHT", box, "TOPRIGHT", -config.close_inset, -config.close_inset)
		local indicator = main.Indicator
		if indicator then
			indicator:ClearAllPoints()
			indicator:SetPoint("RIGHT", close, "LEFT", -config.indicator_gap, 0)
			indicator:SetDesaturated(true) -- (kept as Immersion sets its file)
			indicator:SetVertexColor(unpack(config.icon_color))
		end
	end
	local text = talkBox.TextFrame
	if text then
		text.Text:SetTextColor(unpack(config.text_color))
		local pages = text.SpeechProgress
		pages:SetFont(config.title_font, config.header_size, "")
		pages:SetTextColor(unpack(kit.config.title_plate.color))
		pages:SetShadowOffset(1, -1)
	end
end

-- The tooltips' frame (their backdrop's edge, piece by piece) around warm
-- dark glass over `box`, drawn by `owner`, its corners `size` (the
-- tooltips' 32 halved on a choice: two must fit its height): Immersion
-- draws its text over its own frames, not over frames we'd add. The
-- frame's sides from its left edge, turned (its file's top and bottom
-- pieces are drawn turned).
Module.AddPlate = function(self, owner, box, size, openLeft)
	local spec = self.config.plate
	local e = 1/8
	local inset = spec.inset * size / spec.edge_size
	local fill = owner:CreateTexture(nil, "BACKGROUND")
	fill:SetTexture(unpack(spec.color))
	fill:SetPoint("TOPLEFT", box, "TOPLEFT", openLeft and 0 or inset, -inset)
	fill:SetPoint("BOTTOMRIGHT", box, "BOTTOMRIGHT", -inset, inset)
	local Piece = function(...)
		local piece = owner:CreateTexture(nil, "ARTWORK")
		piece:SetTexture(spec.edge)
		piece:SetTexCoord(...)
		return piece
	end
	local corners = {}
	for i, point in ipairs({ "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT" }) do
		local corner = Piece((3 + i) * e, (4 + i) * e, 0, 1)
		corner:SetSize(size, size)
		corner:SetPoint(point, box, point)
		corners[point] = corner
	end
	local left, right = Piece(0, e, 0, 1), Piece(e, 2 * e, 0, 1)
	local top, bottom = Piece(0, 0, e, 0, 0, 1, e, 1), Piece(e, 0, 0, 0, e, 1, 0, 1)
	left:SetPoint("TOPLEFT", corners.TOPLEFT, "BOTTOMLEFT")
	left:SetPoint("BOTTOMRIGHT", corners.BOTTOMLEFT, "TOPRIGHT")
	right:SetPoint("TOPLEFT", corners.TOPRIGHT, "BOTTOMLEFT")
	right:SetPoint("BOTTOMRIGHT", corners.BOTTOMRIGHT, "TOPRIGHT")
	top:SetPoint("TOPLEFT", corners.TOPLEFT, "TOPRIGHT")
	top:SetPoint("BOTTOMRIGHT", corners.TOPRIGHT, "BOTTOMLEFT")
	bottom:SetPoint("TOPLEFT", corners.BOTTOMLEFT, "TOPRIGHT")
	bottom:SetPoint("BOTTOMRIGHT", corners.BOTTOMRIGHT, "BOTTOMLEFT")
	-- `openLeft`: no left edge, the top and bottom ones from its left end
	if openLeft then
		for _, piece in ipairs({ left, corners.TOPLEFT, corners.BOTTOMLEFT }) do
			piece:Hide()
		end
		top:SetPoint("TOPLEFT", box, "TOPLEFT")
		bottom:SetPoint("TOPLEFT", box, "BOTTOMLEFT", 0, size)
	end
	return fill
end

-- Diablo III's dialogue on `fill`: dark smoke drifting over it (a cloud
-- of the globes', its round edge left out), a red glow up from its foot.
Module.AddSmoke = function(self, owner, fill)
	local spec = self.config.smoke
	local smoke = owner:CreateTexture(nil, "BACKGROUND")
	smoke:SetDrawLayer("BACKGROUND", 1)
	smoke:SetTexture(spec.texture)
	smoke:SetTexCoord(unpack(spec.texcoord))
	smoke:SetVertexColor(unpack(spec.color))
	smoke:SetAllPoints(fill)
	local glow = owner:CreateTexture(nil, "BACKGROUND")
	glow:SetDrawLayer("BACKGROUND", 2)
	glow:SetTexture(1, 1, 1, 1)
	local r, g, b = unpack(spec.glow_color)
	glow:SetGradientAlpha("VERTICAL", r, g, b, spec.glow_alpha, r, g, b, 0)
	glow:SetPoint("BOTTOMLEFT", fill, "BOTTOMLEFT")
	glow:SetPoint("BOTTOMRIGHT", fill, "BOTTOMRIGHT")
	glow:SetHeight(spec.glow_height)
end

-- A thin gold rule under the NPC's name, its ends faded (Diablo III's
-- under a speaker's).
Module.AddRule = function(self, owner, name)
	local spec = self.config.rule
	local r, g, b, a = unpack(spec.color)
	local left = owner:CreateTexture(nil, "ARTWORK")
	left:SetTexture(1, 1, 1, 1)
	left:SetGradientAlpha("HORIZONTAL", r, g, b, 0, r, g, b, a)
	left:SetHeight(spec.height)
	left:SetWidth(spec.width / 2)
	left:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -spec.gap)
	local right = owner:CreateTexture(nil, "ARTWORK")
	right:SetTexture(1, 1, 1, 1)
	right:SetGradientAlpha("HORIZONTAL", r, g, b, a, r, g, b, 0)
	right:SetHeight(spec.height)
	right:SetWidth(spec.width / 2)
	right:SetPoint("LEFT", left, "RIGHT")
end

-- A choice (gossip option, quest) on the same plate, its text in Diablo
-- III's pale gold, its speech bubble too; the copper bar under its text on
-- the one under the mouse or the keys' (Immersion's blue frames gone, its
-- glow and growth too).
Module.StyleChoice = function(self, button)
	local config = self.config
	if button.DiabolicGlass then
		return
	end
	button.DiabolicGlass = true
	for _, frame in ipairs({ button, button.Overlay, button.Hilite }) do
		frame:SetBackdrop(nil)
	end
	local insets = config.choice_insets
	local box = CreateFrame("Frame", nil, button)
	box:SetPoint("TOPLEFT", button, "TOPLEFT", insets[1], -insets[2])
	box:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -insets[3], insets[4])
	local fill = self:AddPlate(button, box, config.plate.choice_edge_size)
	button.Label:SetTextColor(unpack(kit.config.title_plate.color))
	button:GetHighlightTexture():SetAlpha(0)
	button.enterScale = config.choice_scale
	-- (Immersion fades its Hilite frame in and out: the bar with it)
	local lit = button:CreateTexture(nil, "BORDER")
	lit:SetTexture(kit.config.row_bars.lit)
	lit:SetAllPoints(fill)
	lit:SetAlpha(0)
	hooksecurefunc(button.Hilite, "SetAlpha", function(_, alpha)
		lit:SetAlpha(alpha * config.choice_lit_alpha)
	end)
	-- Blizzard's white speech bubbles in pale gold (the quests' marks as
	-- they are), as Immersion sets them
	local icon = button.Icon
	if icon and button.SetGossipIcon then
		local Tint = function(gossip)
			icon:SetDesaturated(gossip)
			if gossip then
				icon:SetVertexColor(unpack(config.icon_color))
			end
		end
		hooksecurefunc(button, "SetGossipIcon", function() Tint(true) end)
		hooksecurefunc(button, "SetGossipQuestIcon", function() Tint(false) end)
		hooksecurefunc(button, "SetIcon", function() Tint(false) end)
	end
end

-- the dialogue Immersion, once it has made its frame
local IsLoaded = function()
	local frame = _G.ImmersionFrame
	return frame and frame.TalkBox and frame.TalkBox.Elements and true
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
