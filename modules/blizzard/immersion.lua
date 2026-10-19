-- Keeps the Immersion addon's own dialogue box and gives it a few of ours:
-- the windows' close button, the titles (the NPC's name, the quest's
-- headers) in Exocet, and our coins.
-- Only the dialogue Immersion (ImmersionFrame), not the addon of the same
-- name that hides the UI.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Immersion", "LOW")
local kit

-- Lua API
local _G = _G
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
