-- Asks once per addon that made DiabolicUI turn a part of itself off: keep
-- that addon (never asked again), or turn it off and use DiabolicUI's part.
local _, Engine = ...
local L = Engine:GetLocale()
local Module = Engine:NewModule("AddOnConflicts", "LOW")

Module.Ask = function(self, addon)
	local id = "DIABOLICUI_ADDON_CONFLICT_" .. addon
	local PopUpMessage = self:GetHandler("PopUpMessage")
	PopUpMessage:RegisterPopUp(id, {
		title = L["AddOn Conflict"],
		text = L["%s does a job DiabolicUI also does, so DiabolicUI has turned that part of itself off.|n|nKeep %s, or turn it off and use DiabolicUI's?"]:format(
			addon,
			addon
		),
		button1 = L["Keep It"],
		button2 = L["Turn It Off"],
		OnAccept = function()
			self.db.kept[addon] = true
		end,
		OnCancel = function()
			DisableAddOn(addon)
			ReloadUI()
		end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	})
	PopUpMessage:ShowPopUp(id, self:GetDB("UI").popup)
end

Module.OnInit = function(self)
	self.db = self:GetConfig("AddOnConflicts")
end

Module.OnEnable = function(self)
	for addon in pairs(Engine:GetAddOnConflicts()) do
		if not self.db.kept[addon] then
			self:Ask(addon)
		end
	end
end
