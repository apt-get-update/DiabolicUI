-- The trade skills' window on parchment (panels.lua puts its recipes and
-- the chosen one's details on it): the recipes' difficulty colors darkened
-- to read on it, the reagents' names in ink. Blizzard sets both again as
-- it updates, so after it does.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Trade Skill", "LOW")
local kit

-- Lua API
local _G = _G
local unpack = unpack

-- WoW API
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded

local ADDON = "Blizzard_TradeSkillUI"

-- The recipes' text in their difficulty's color, darker; no shadows (they
-- blur it on parchment).
Module.ShadeList = function(self)
	local shade = self.config.shade
	for i = 1, _G.TRADE_SKILLS_DISPLAYED do
		local button = _G["TradeSkillSkill" .. i]
		local text, count = button and button:GetFontString(), _G["TradeSkillSkill" .. i .. "Count"]
		if text and button.r then
			text:SetTextColor(button.r * shade, button.g * shade, button.b * shade)
			text:SetShadowColor(0, 0, 0, 0)
			if count then
				count:SetVertexColor(button.r * shade, button.g * shade, button.b * shade)
				count:SetShadowColor(0, 0, 0, 0)
			end
		end
	end
end

-- The chosen recipe's reagents in ink, lighter for those short.
Module.InkReagents = function(self)
	for i = 1, _G.MAX_TRADE_SKILL_REAGENTS do
		local name = _G["TradeSkillReagent" .. i .. "Name"]
		if name then
			local r = name:GetTextColor()
			name:SetTextColor(unpack((r < .9) and self.config.missing_color or kit.config.ink))
			name:SetShadowColor(0, 0, 0, 0)
		end
	end
end

Module.StyleTradeSkill = function(self)
	hooksecurefunc("TradeSkillFrame_Update", function() self:ShadeList() end)
	hooksecurefunc("TradeSkillFrame_SetSelection", function() self:InkReagents() end)
end

Module.ADDON_LOADED = function(self, event, addon)
	if (addon == ADDON) then
		self:UnregisterEvent("ADDON_LOADED")
		self:StyleTradeSkill()
	end
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").tradeskill
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if (not kit:IsSkinning()) then
		return
	end
	if IsAddOnLoaded(ADDON) then
		self:StyleTradeSkill()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end
