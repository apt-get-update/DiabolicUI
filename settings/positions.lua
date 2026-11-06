-- The parts placed for good: { point, the frame it's placed on, that frame's
-- point, x, y, width, height } (x right, y up), without a width and height it
-- keeps its size, { width, height } alone sizes it where it is, whatever else
-- moves it (modules/blizzard/adjust.lua).
-- Written from windows/*.qml by tools/positions.lua: change those (docs:
-- Common Tasks), this file is overwritten.
local _, Engine = ...

Engine:NewStaticConfig("Positions", {

	-- BattlefieldFrame ------------------------------------------------------
	-- the rewards on slate too, under the instances: 16 higher (its panel clear
	-- of the buttons), its top 7 lower (apart from theirs; Blizzard's 232 high)
	BattlefieldFrameInfoScrollFrame = { "BOTTOMLEFT", "BattlefieldFrame", "BOTTOMLEFT", 19, 116, 298, 209 }, -- ScrollFrame
	-- "Battlefield Instance:" 5 higher, apart from its list
	BattlefieldFrameNameHeader = { "TOPLEFT", "BattlefieldFrame", "TOPLEFT", 75, -50 }, -- FontString "Battlefield Instance:"

	-- ClassTrainerFrame -----------------------------------------------------
	-- the chosen one's page 6 under the list's (Blizzard's 8 under its text)
	ClassTrainerDetailScrollFrame = { "TOPLEFT", "ClassTrainerListScrollFrame", "BOTTOMLEFT", 0, -14 }, -- ScrollFrame
	-- "All" and the list under the greeting (the chosen one's height: trainer.lua)
	ClassTrainerExpandButtonFrame = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 15, -66 }, -- Frame
	-- the greeting across the list's width under the band, its panel's left on
	-- the parchments', its right on their panels'
	ClassTrainerGreetingText = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 11, -34, 350, 24 }, -- FontString "Hello, priest!  Ready for some training?"
	ClassTrainerListScrollFrame = { "TOPRIGHT", "ClassTrainerFrame", "TOPRIGHT", -67, -102 }, -- ScrollFrame

	-- DressUpFrame ----------------------------------------------------------
	-- its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
	DressUpFrameDescriptionText = { "CENTER", "DressUpFrame", "TOP", -11, -50 },

	-- GuildBankFrame --------------------------------------------------------
	-- the slots, logs and info 27 higher than Blizzard's: as far from the band
	-- as from the foot's iron bar
	GuildBankColumn1 = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 30, -43 }, -- Frame
	GuildBankFrameLog = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 0, 27 }, -- Frame
	GuildBankInfo = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 33, -46 }, -- Frame
	-- the info's page the logs' size, in the same place
	GuildBankInfoScrollFrame = { 688, 304 }, -- ScrollFrame
	GuildBankTabInfoEditBox = { 688, 218 }, -- EditBox
	GuildBankTransactionsScrollFrame = { "TOPRIGHT", "GuildBankFrame", "TOPRIGHT", -50, -48 }, -- ScrollFrame

	-- InspectFrame ----------------------------------------------------------
	-- the level line (the guild's under it) out of the band, over the model
	InspectLevelText = { "BOTTOM", "InspectModelFrame", "TOP", 0, 22 }, -- FontString "Level 58 Draenei Shaman"

	-- KeyBindingFrame -------------------------------------------------------
	KeyBindingFrameBinding1 = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 27, -72 }, -- Frame
	KeyBindingFrameCancelButton = { "BOTTOMRIGHT", "KeyBindingFrame", "BOTTOMRIGHT", -64, -16 }, -- Button "Cancel"
	-- the buttons 16 lower, on the foot, as far in from both sides
	KeyBindingFrameDefaultButton = { "BOTTOMLEFT", "KeyBindingFrame", "BOTTOMLEFT", 10, -16 }, -- Button "Reset To Default"
	-- what a key was bound to between the list and the foot
	KeyBindingFrameOutputText = { "TOP", "KeyBindingFrame", "TOPLEFT", 293, -465 }, -- FontString
	-- the list (its rows too) 6 under the column names
	KeyBindingFrameScrollFrame = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 2, -72 }, -- ScrollFrame

	-- MacroFrame ------------------------------------------------------------
	-- the icons and the macro 20 up and 6 left (as far from the band as from the
	-- foot's bar, from the sides)
	MacroButtonScrollFrame = { "TOPLEFT", "MacroFrame", "TOPLEFT", 17, -56 }, -- ScrollFrame
	-- the buttons 10 down (30 over the window's bottom)
	MacroDeleteButton = { "BOTTOMLEFT", "MacroFrame", "BOTTOMLEFT", 17, 69 }, -- Button "Delete"
	MacroExitButton = { "CENTER", "MacroFrame", "TOPLEFT", 303, -432 }, -- Button "Exit"
	-- the count of characters right of "Enter Macro Commands:" (Blizzard's
	-- under the text, over the foot)
	MacroFrameCharLimitText = { "BOTTOMRIGHT", "MacroFrameScrollFrame", "TOPRIGHT", 0, 8 }, -- FontString "80/255 Characters Used"
	MacroFrameSelectedMacroBackground = { "TOPLEFT", "MacroFrame", "TOPLEFT", 10, -208 },
	MacroNewButton = { "CENTER", "MacroFrame", "TOPLEFT", 222, -432 }, -- Button "New"

	-- PVPParentFrame --------------------------------------------------------
	-- the battlegrounds' block (title row, list, rewards) 5 left: in the middle
	BattlegroundType1 = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 18, -79 }, -- Button "Random Battleground"
	-- 8 apart
	PVPBattlegroundFrameCancelButton = { "LEFT", "PVPBattlegroundFrameJoinButton", "RIGHT", 8, 0 }, -- Button "Cancel"
	-- 8 apart
	PVPBattlegroundFrameGroupJoinButton = { "RIGHT", "PVPBattlegroundFrameJoinButton", "LEFT", -8, 0 }, -- Button "Join as Group"
	-- the rewards 208 high (Blizzard's 232): 6 over the foot's iron bar, 6 under the list
	PVPBattlegroundFrameInfoScrollFrame = { "BOTTOMLEFT", "PVPBattlegroundFrame", "BOTTOMLEFT", 15, 122, 298, 208 }, -- ScrollFrame
	-- the buttons in the middle of the window's foot (its middle 15 left of the
	-- frame's; Join as Party wider than Cancel, so Join Battle 27 right of it),
	-- room between the rewards and the foot
	PVPBattlegroundFrameJoinButton = { "BOTTOM", "PVPParentFrame", "BOTTOM", 12, 69 }, -- Button "Join Battle"
	PVPBattlegroundFrameNameHeader = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 65, -53 }, -- FontString "Battleground"
	WintergraspTimer = { "RIGHT", "PVPBattlegroundFrame", "TOPRIGHT", -45, -53 }, -- Frame

	-- TradeFrame ------------------------------------------------------------
	-- the names over their columns, out from under the band (Blizzard's beside portraits)
	TradeFramePlayerNameText = { "BOTTOM", "TradePlayerItem1", "TOP", 0, 50 }, -- FontString "Padirac"
	TradeFrameRecipientNameText = { "BOTTOM", "TradeRecipientItem1", "TOP", 0, 50 }, -- FontString "Unluckylock"

	-- TradeSkillFrame -------------------------------------------------------
	-- the skill's bar centred on our window (24 left of the frame, 14 right of it:
	-- room for the scroll bars), its rank in it
	TradeSkillRankFrame = { "TOP", "TradeSkillFrame", "TOPLEFT", 187, -32 }, -- StatusBar
	TradeSkillRankFrameSkillRank = { "CENTER", "TradeSkillRankFrame", "CENTER", 0, 0 }, -- FontString "450/450"
})
