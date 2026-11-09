-- Interface, Video and Audio options (panels.lua makes them our windows): what
-- the control under the mouse does, beside the settings instead of in a
-- tooltip. Its tooltip is read as it shows, so Blizzard's controls and ours
-- need nothing done to them.
local _, Engine = ...
local Module = Engine:NewModule("Blizzard: Options", "LOW")
local kit

-- Lua API
local _G = _G
local ipairs = ipairs
local table_concat = table.concat

local FRAMES = { "InterfaceOptionsFrame", "VideoOptionsFrame", "AudioOptionsFrame" }

local IsIn = function(part, frame)
	while part do
		if part == frame then
			return true
		end
		part = part:GetParent()
	end
	return false
end

local RestoreTooltip = function(pane)
	if pane.hiding then
		pane.hiding = nil
		_G.GameTooltip:SetAlpha(1)
	end
end

local OnUpdate = function(pane)
	local tooltip = _G.GameTooltip
	local owner = tooltip:IsShown() and tooltip:GetOwner()
	if owner and IsIn(owner, pane:GetParent()) then
		local lines = {}
		for i = 2, tooltip:NumLines() do
			lines[#lines + 1] = _G["GameTooltipTextLeft" .. i]:GetText()
		end
		pane.Title:SetText(_G.GameTooltipTextLeft1:GetText())
		pane.Body:SetText(table_concat(lines, "\n"))
		pane.hiding = true
		tooltip:SetAlpha(0)
	else
		RestoreTooltip(pane)
	end
end

Module.AddPane = function(self, frame)
	local config = self.config
	local pane = _G.CreateFrame("Frame", frame:GetName() .. "Description", frame)
	pane:SetPoint("TOPLEFT", frame, "TOPRIGHT", config.gap, config.top)
	pane:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", config.gap, config.bottom)
	pane:SetWidth(config.width)
	local title = pane:CreateFontString(nil, "OVERLAY")
	title:SetFontObject(_G[config.title_font])
	title:SetJustifyH("LEFT")
	title:SetWidth(config.width)
	title:SetPoint("TOPLEFT")
	local body = pane:CreateFontString(nil, "OVERLAY")
	body:SetFontObject(_G[config.body_font])
	body:SetJustifyH("LEFT")
	body:SetJustifyV("TOP")
	body:SetWidth(config.width)
	body:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -config.line_gap)
	pane.Title, pane.Body = title, body
	pane:SetScript("OnUpdate", OnUpdate)
	pane:SetScript("OnHide", RestoreTooltip)
	pane:SetScript("OnShow", function()
		title:SetText("")
		body:SetText("")
	end)
	return pane
end

Module.OnInit = function(self)
	self.config = self:GetDB("Blizzard").options
	kit = Engine:GetModule("Blizzard: Windows")
end

Module.OnEnable = function(self)
	if not kit:IsSkinning() then
		return
	end
	self.Panes = {}
	for _, name in ipairs(FRAMES) do
		self.Panes[name] = self:AddPane(_G[name])
	end
end
