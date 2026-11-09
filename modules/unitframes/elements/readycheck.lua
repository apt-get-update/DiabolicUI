-- "ReadyCheck" element: waiting, ready or not ready on the unit during a
-- ready check, kept up a while after it ends (frame.ReadyCheck, a frame with
-- the texture .Icon). Who never answered counts as not ready by then.
local _, Engine = ...
local Handler = Engine:GetHandler("UnitFrame")

-- Lua API
local _G = _G

-- WoW API
local GetReadyCheckStatus = _G.GetReadyCheckStatus

local STAY_TIME = 10 -- seconds the answers stay up once it's over, as on Blizzard's frames

local TEXTURES = {
	waiting = _G.READY_CHECK_WAITING_TEXTURE,
	ready = _G.READY_CHECK_READY_TEXTURE,
	notready = _G.READY_CHECK_NOT_READY_TEXTURE,
}

local SetStatus = function(ReadyCheck, status)
	ReadyCheck.status = status
	ReadyCheck.Icon:SetTexture(TEXTURES[status])
end

local OnUpdate = function(ReadyCheck, elapsed)
	ReadyCheck.stay = ReadyCheck.stay - elapsed
	if ReadyCheck.stay <= 0 then
		ReadyCheck:SetScript("OnUpdate", nil)
		ReadyCheck:Hide()
	end
end

local Update = function(self, event)
	local ReadyCheck = self.ReadyCheck
	if event == "READY_CHECK_FINISHED" then
		if ReadyCheck:IsShown() then
			if ReadyCheck.status == "waiting" then
				SetStatus(ReadyCheck, "notready")
			end
			ReadyCheck.stay = STAY_TIME
			ReadyCheck:SetScript("OnUpdate", OnUpdate)
		end
		return
	end
	local status = GetReadyCheckStatus(self.unit)
	if status then
		ReadyCheck:SetScript("OnUpdate", nil)
		SetStatus(ReadyCheck, status)
		ReadyCheck:Show()
	elseif not ReadyCheck:GetScript("OnUpdate") then -- (not while the answers stay up)
		ReadyCheck:Hide()
	end
end

local Enable = function(self)
	if self.ReadyCheck then
		self:RegisterEvent("READY_CHECK", Update)
		self:RegisterEvent("READY_CHECK_CONFIRM", Update)
		self:RegisterEvent("READY_CHECK_FINISHED", Update)
		return true
	end
end

Handler:RegisterElement("ReadyCheck", Enable, Update)
