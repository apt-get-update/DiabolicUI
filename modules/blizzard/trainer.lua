-- The class trainer's window, a List (panels.lua puts the trainings on
-- slate, the chosen one on parchment, its filter in the band): the chosen
-- one in an orange box, its requirements and cost in ink (Blizzard sets
-- them again as it updates, so after it does); the trainer's words on a
-- dark panel, as said to you.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Trainer", "LOW")
local kit

local ADDON = "Blizzard_TrainerUI"

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
	-- the trainer's words in the middle of their panel
	local greeting = _G.ClassTrainerGreetingText
	greeting:SetJustifyH("CENTER")
	greeting:SetJustifyV("MIDDLE")
	kit:AddPanel(greeting, config.greeting_insets)
	_G.UIDropDownMenu_SetWidth(_G.ClassTrainerFrameFilterDropDown, config.filter_width)
	hooksecurefunc("ClassTrainer_SetToClassTrainer", FitList)
	hooksecurefunc("ClassTrainer_SetToTradeSkillTrainer", FitList)
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
