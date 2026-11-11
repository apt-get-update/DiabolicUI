-- The class trainer's window (panels.lua puts its list and the chosen
-- training on parchment, its filter in the band): the trainings in inks
-- of their kind, the chosen one in an orange box, its requirements and
-- cost in ink (Blizzard sets them again as it updates, so after it does);
-- the trainer's words on a dark panel, as said to you.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Trainer", "LOW")
local kit

local ADDON = "Blizzard_TrainerUI"

-- The trainings' text in their kind's ink (Blizzard's colors are for a
-- dark background), the chosen one too (its box is see-through); no
-- shadows (they blur it on parchment).
Module.ShadeList = function(self)
	local inks = self.config.inks
	for i = 1, _G.CLASS_TRAINER_SKILLS_DISPLAYED do
		local button = _G["ClassTrainerSkill" .. i]
		local text = button and button:GetFontString()
		if text and button:IsShown() then
			local _, _, kind = GetTrainerServiceInfo(button:GetID())
			if inks[kind] then
				local r, g, b = unpack(inks[kind])
				text:SetTextColor(r, g, b)
				text:SetShadowColor(0, 0, 0, 0)
				local sub = _G["ClassTrainerSkill" .. i .. "SubText"]
				sub:SetTextColor(r, g, b)
				sub:SetShadowColor(0, 0, 0, 0)
				button.r, button.g, button.b = r, g, b -- (what Blizzard sets it back to as the mouse leaves)
			end
		end
	end
end

-- As many trainings as fit the list (its height: settings/positions.lua), the
-- others hidden. (Blizzard sets its count as it opens, by the trainer's kind.)
local ROWS = 11
local FitList = function()
	local rows =
		kit:RowsFitting(_G.ClassTrainerListScrollFrame, _G.CLASS_TRAINER_SKILL_HEIGHT, ROWS, _G.ClassTrainerSkill1)
	_G.CLASS_TRAINER_SKILLS_DISPLAYED = rows
	for i = rows + 1, ROWS do
		_G["ClassTrainerSkill" .. i]:Hide()
	end
end

local ColorCode = Engine.ColorCode

-- The chosen training's requirements and cost in ink, on its lined
-- parchment: Blizzard's white (met) in ink, its red (not met) in red ink.
Module.InkDetails = function(self)
	local ink = kit.config.ink
	local requirements = _G.ClassTrainerSkillRequirements
	local text = requirements:GetText()
	if text then
		local inkCode, missingCode = ColorCode(ink), ColorCode(self.config.missing_color)
		requirements:SetText((text:gsub("|c%x%x(%x%x%x%x%x%x)", function(hex)
			return (hex:lower() == "ffffff") and inkCode or missingCode
		end)))
	end
	for _, coin in ipairs({ "Gold", "Silver", "Copper" }) do
		local button = _G["ClassTrainerDetailMoneyFrame" .. coin .. "Button"]
		local text = button and button:GetFontString()
		if text then
			text:SetTextColor(unpack(ink))
			text:SetShadowColor(0, 0, 0, 0)
		end
	end
end

Module.StyleTrainer = function(self)
	local config = self.config
	kit:LightRow(_G.ClassTrainerSkillHighlight) -- the chosen one in an orange box
	kit:StyleExpanderRows("ClassTrainerSkill", ROWS) -- (Blizzard shows 10 or 11)
	kit:StyleExpanders(_G.ClassTrainerCollapseAllButton)
	-- its All on the list's parchment, in the headers' ink
	local all = CreateFont("DiabolicUITrainerAll")
	all:SetFont(_G.GameFontNormalLeft:GetFont())
	all:SetTextColor(unpack(config.inks.header))
	all:SetShadowColor(0, 0, 0, 0)
	_G.ClassTrainerCollapseAllButton:SetNormalFontObject(all)
	_G.ClassTrainerCollapseAllButton:SetHighlightFontObject(all)
	-- the trainer's words in the middle of their panel
	local greeting = _G.ClassTrainerGreetingText
	greeting:SetJustifyH("CENTER")
	greeting:SetJustifyV("MIDDLE")
	kit:AddPanel(greeting, config.greeting_insets)
	-- a training under the mouse in black ink, not Blizzard's white
	local hover = CreateFont("DiabolicUITrainerHover")
	hover:SetFont(_G.GameFontHighlightLeft:GetFont())
	hover:SetJustifyH("LEFT")
	hover:SetTextColor(unpack(config.hover_color))
	hover:SetShadowColor(0, 0, 0, 0)
	for i = 1, ROWS do
		local button = _G["ClassTrainerSkill" .. i]
		button:SetHighlightFontObject(hover)
		button:HookScript("OnEnter", function()
			_G["ClassTrainerSkill" .. i .. "SubText"]:SetTextColor(unpack(config.hover_color))
		end)
	end
	_G.UIDropDownMenu_SetWidth(_G.ClassTrainerFrameFilterDropDown, config.filter_width)
	hooksecurefunc("ClassTrainer_SetToClassTrainer", FitList)
	hooksecurefunc("ClassTrainer_SetToTradeSkillTrainer", FitList)
	hooksecurefunc("ClassTrainerFrame_Update", function()
		self:ShadeList()
	end)
	hooksecurefunc("ClassTrainer_SetSelection", function()
		self:InkDetails()
	end)
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").trainer
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	self:WhenLoaded(ADDON, "StyleTrainer")
end
