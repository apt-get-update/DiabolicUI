-- Gives the Immersion addon's dialogue box Diablo III's conversation look
-- (its 2DUIConversation: the text on torn dark glass, the NPC in a
-- bronze-edged frame), the windows' close button, the titles (the NPC's
-- name, the quest's headers) in Exocet, and our coins.
-- Only the dialogue Immersion (ImmersionFrame), not the addon of the same
-- name that hides the UI.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Immersion", "LOW")
local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc

Module.StyleImmersion = function(self)
	local config = self.config
	local talkBox = _G.ImmersionFrame.TalkBox

	local close = talkBox.MainFrame.CloseButton
	if close then
		kit:SkinClose(close)
	end
	self:StyleBox(talkBox)

	-- in Exocet at their own color: Immersion sets that, never the font
	local Exocet = function(fontString, size)
		if fontString then
			fontString:SetFont(config.title_font, size, "")
		end
	end
	local elements = talkBox.Elements
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

-- Diablo III's conversation box in place of Immersion's art: the glass
-- in three parts (its ends as they are, the middle stretched), its left
-- end under the portrait's frame; the frame over the model's edges, black
-- behind it (shown with the portrait: Immersion can turn it off).
Module.StyleBox = function(self, talkBox)
	local config = self.config
	local background, portrait = talkBox.BackgroundFrame, talkBox.PortraitFrame
	local model = talkBox.MainFrame.Model
	for _, art in ipairs({ background.TextBackground, background.SolidBackground, portrait.Portrait, model.PortraitBG }) do
		if art then
			art:SetTexture(nil)
		end
	end

	local insets = config.bar_insets
	local width, height = unpack(config.bar_size)
	local cap = config.bar_cap * (talkBox:GetHeight() - insets[2] - insets[4]) / height
	local Part = function(left, right)
		local part = background:CreateTexture(nil, "BACKGROUND")
		part:SetTexture(config.bar)
		part:SetTexCoord(left / 1024, right / 1024, 0, height / 256)
		return part
	end
	local left, middle, right = Part(0, config.bar_cap), Part(config.bar_cap, width - config.bar_cap), Part(width - config.bar_cap, width)
	left:SetWidth(cap)
	left:SetPoint("TOPLEFT", talkBox, "TOPLEFT", insets[1], -insets[2])
	left:SetPoint("BOTTOMLEFT", talkBox, "BOTTOMLEFT", insets[1], insets[4])
	right:SetWidth(cap)
	right:SetPoint("TOPRIGHT", talkBox, "TOPRIGHT", -insets[3], -insets[2])
	right:SetPoint("BOTTOMRIGHT", talkBox, "BOTTOMRIGHT", -insets[3], insets[4])
	middle:SetPoint("TOPLEFT", left, "TOPRIGHT")
	middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")

	local scale = model:GetWidth() / config.glass[1]
	local glass = background:CreateTexture(nil, "BORDER")
	glass:SetTexture(0, 0, 0, 1)
	glass:SetSize(config.glass[1] * scale, config.glass[2] * scale)
	glass:SetPoint("CENTER", model, "CENTER")
	local frameWidth, frameHeight = unpack(config.portrait_size)
	local frame = portrait:CreateTexture(nil, "OVERLAY")
	frame:SetTexture(config.portrait)
	frame:SetTexCoord(0, frameWidth / 256, 0, frameHeight / 256)
	frame:SetSize(frameWidth * scale, frameHeight * scale)
	frame:SetPoint("CENTER", model, "CENTER", config.portrait_offset[1] * scale, config.portrait_offset[2] * scale)
	portrait:HookScript("OnShow", function() glass:Show() end)
	portrait:HookScript("OnHide", function() glass:Hide() end)
	if (not portrait:IsShown()) then
		glass:Hide()
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
