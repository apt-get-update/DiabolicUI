
-- WoW API
local blizzardCollectgarbage = _G.collectgarbage

-- Fix the bug where trainer window bugs out 
-- after being automatically opened when a quest window close.
--[[
Message: ...ace\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.lua:184: attempt to compare number with nil
Time: 02/03/18 08:30:56
Count: 1
Stack: ...ace\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.lua:184: in function `ClassTrainerFrame_SetServiceButton'
...ace\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.lua:128: in function `ClassTrainerFrame_Update'
...ace\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.lua:92: in function <...ace\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.lua:84>
[C]: in function `Show'
Interface\FrameXML\UIParent.lua:2374: in function `SetUIPanel'
Interface\FrameXML\UIParent.lua:2270: in function `ShowUIPanel'
Interface\FrameXML\UIParent.lua:2086: in function <Interface\FrameXML\UIParent.lua:2082>
[C]: in function `SetAttribute'
Interface\FrameXML\UIParent.lua:2868: in function `ShowUIPanel'
...ace\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.lua:42: in function `ClassTrainerFrame_Show'
Interface\FrameXML\UIParent.lua:1476: in function <Interface\FrameXML\UIParent.lua:907>

Locals: skillButton = ClassTrainerFrameSkillStepButton {
 0 = <userdata>
 disabledBG = <unnamed> {
 }
 name = ClassTrainerFrameSkillStepButtonName {
 }
 selectedTex = <unnamed> {
 }
 money = ClassTrainerFrameSkillStepButtonMoneyFrame {
 }
 lock = <unnamed> {
 }
 icon = ClassTrainerFrameSkillStepButtonIcon {
 }
 subText = ClassTrainerFrameSkillStepButtonSubText {
 }
}
skillIndex = 13
playerMoney = 188783859
selected = nil
isTradeSkill = true
unavailable = false
serviceName = "Unknown"
serviceSubText = nil
serviceType = nil
texture = nil
reqLevel = nil
requirements = ""
separator = ""
(*temporary) = nil
(*temporary) = true
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = nil
(*temporary) = "attempt to compare number with nil"
]]

-- Garbage collection is being overused and misused,
-- and it's causing lag and performance drops. 
blizzardCollectgarbage("setpause", 110)
blizzardCollectgarbage("setstepmul", 200)

_G.collectgarbage = function(opt, arg)
	if (opt == "collect") or (opt == nil) then
	elseif (opt == "count") then
		return blizzardCollectgarbage(opt, arg)
	elseif (opt == "setpause") then
		return blizzardCollectgarbage("setpause", 110)
	elseif opt == "setstepmul" then
		return blizzardCollectgarbage("setstepmul", 200)
	elseif (opt == "stop") then
	elseif (opt == "restart") then
	elseif (opt == "step") then
		if (arg ~= nil) then
			if (arg <= 10000) then
				return blizzardCollectgarbage(opt, arg)
			end
		else
			return blizzardCollectgarbage(opt, arg)
		end
	else
		return blizzardCollectgarbage(opt, arg)
	end
end

-- Memory usage is unrelated to performance, and tracking memory usage does not track "bad" addons.
-- Developers can uncomment this line to enable the functionality when looking for memory leaks, 
-- but for the average end-user this is a completely pointless thing to track. 
_G.UpdateAddOnMemoryUsage = function() end
