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

	-- FriendsFrame ----------------------------------------------------------
	FriendsFrameIgnoreButton1 = { "TOPLEFT", "FriendsFrame", "TOPLEFT", 21, -39 }, -- Button
	FriendsFrameIgnoreScrollFrame = { "TOPRIGHT", "FriendsFrame", "TOPRIGHT", -65, -36, 298, 340 }, -- ScrollFrame
	GuildEventLogFrame = { "TOPLEFT", "FriendsFrameDiabolic", "TOPRIGHT", 6, -96 }, -- Frame
	GuildInfoFrame = { "TOPLEFT", "FriendsFrameDiabolic", "TOPRIGHT", 6, -96 }, -- Frame
	GuildMemberDetailFrame = { "TOPLEFT", "FriendsFrameDiabolic", "TOPRIGHT", 6, -96 }, -- Frame
	WhoFrameButton1 = { "TOPLEFT", "WhoFrame", "TOPLEFT", 15, -61 }, -- Button
	WhoFrameColumnHeader1 = { "TOPLEFT", "WhoFrame", "TOPLEFT", 20, -34 }, -- Button "Name"
	WhoListScrollFrame = { "TOPRIGHT", "FriendsFrame", "TOPRIGHT", -67, -62 }, -- ScrollFrame

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
	InspectLevelText = { "BOTTOM", "InspectModelFrame", "TOP", 0, 22 }, -- FontString "Level 80 Human Warlock"

	-- KeyBindingFrame -------------------------------------------------------
	KeyBindingFrameBinding1 = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 27, -72 }, -- Frame
	KeyBindingFrameCancelButton = { "BOTTOMRIGHT", "KeyBindingFrame", "BOTTOMRIGHT", -64, -16 }, -- Button "Cancel"
	-- the buttons 16 lower, on the foot, as far in from both sides
	KeyBindingFrameDefaultButton = { "BOTTOMLEFT", "KeyBindingFrame", "BOTTOMLEFT", 10, -16 }, -- Button "Reset To Default"
	-- what a key was bound to between the list and the foot
	KeyBindingFrameOutputText = { "TOP", "KeyBindingFrame", "TOPLEFT", 293, -465 }, -- FontString
	-- the list (its rows too) 6 under the column names
	KeyBindingFrameScrollFrame = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 2, -72 }, -- ScrollFrame

	-- LFDParentFrame --------------------------------------------------------
	LFDQueueFrameCancelButton = { "BOTTOMRIGHT", "LFDParentFrameDiabolic", "BOTTOMRIGHT", -34, 30 }, -- Button "Close"
	LFDQueueFrameFindGroupButton = { "BOTTOMLEFT", "LFDParentFrameDiabolic", "BOTTOMLEFT", 34, 30 }, -- Button "Find Group"
	LFDQueueFrameRandomScrollFrame = { "BOTTOMRIGHT", "LFDQueueFrameRandom", "BOTTOMRIGHT", -34, 34, 298, 265 }, -- ScrollFrame

	-- LFRParentFrame --------------------------------------------------------
	LFRBrowseFrameColumnHeader1 = { "TOPLEFT", "LFRBrowseFrame", "TOPLEFT", 26, -40 }, -- Button "Name"
	LFRBrowseFrameListButton1 = { "TOPLEFT", "LFRBrowseFrame", "TOPLEFT", 12, -66 }, -- Button
	LFRBrowseFrameSendMessageButton = { "BOTTOMLEFT", "LFRBrowseFrame", "BOTTOMLEFT", 25, -6 }, -- Button "Send Message"
	LFRQueueFrameAcceptCommentButton = { "BOTTOMRIGHT", "LFRQueueFrame", "BOTTOMRIGHT", -21, -6 }, -- Button "Set Comment"
	LFRQueueFrameFindGroupButton = { "BOTTOMLEFT", "LFRQueueFrame", "BOTTOMLEFT", 21, -6 }, -- Button "List My Name"
	LFRQueueFrameSpecificListButton1 = { "TOPLEFT", "LFRQueueFrameSpecific", "TOPLEFT", 17, -132 }, -- Frame

	-- MacroFrame ------------------------------------------------------------
	-- the icons and the macro 20 up and 6 left (as far from the band as from the
	-- foot's bar, from the sides)
	MacroButtonScrollFrame = { "TOPLEFT", "MacroFrame", "TOPLEFT", 17, -56 }, -- ScrollFrame
	-- the buttons 10 down (30 over the window's bottom)
	MacroDeleteButton = { "BOTTOMLEFT", "MacroFrame", "BOTTOMLEFT", 17, 69 }, -- Button "Delete"
	MacroExitButton = { "CENTER", "MacroFrame", "TOPLEFT", 303, -432 }, -- Button "Exit"
	-- the count of characters right of "Enter Macro Commands:" (Blizzard's
	-- under the text, over the foot)
	MacroFrameCharLimitText = { "BOTTOMRIGHT", "MacroFrameScrollFrame", "TOPRIGHT", 0, 8 }, -- FontString "41/255 Characters Used"
	MacroFrameSelectedMacroBackground = { "TOPLEFT", "MacroFrame", "TOPLEFT", 10, -208 },
	MacroNewButton = { "RIGHT", "MacroExitButton", "LEFT", -6, 0 }, -- Button "New"

	-- MailFrame -------------------------------------------------------------
	InboxCurrentPage = { "BOTTOM", "InboxFrame", "BOTTOM", -14, 72 }, -- FontString
	InboxNextPageButton = { "CENTER", "InboxFrame", "BOTTOMLEFT", 314, 80 }, -- Button
	InboxPrevPageButton = { "CENTER", "InboxFrame", "BOTTOMLEFT", 50, 80 }, -- Button
	SendMailMoneyButton = { "BOTTOMLEFT", "SendMailFrame", "BOTTOMLEFT", 30, 120 }, -- Frame

	-- MerchantFrame ---------------------------------------------------------
	DiabolicSellJunkButton = { "TOPRIGHT", "MerchantFrameDiabolic", "TOPRIGHT", -32, -434 }, -- Button "Sell Junk"
	MerchantBuyBackItem = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.2, -433.8 }, -- Frame
	MerchantItem1 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.3, -72 }, -- Frame
	MerchantItem10 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 257.3, -280 }, -- Frame
	MerchantItem11 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.3, -332 }, -- Frame
	MerchantItem12 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 257.3, -332 }, -- Frame
	MerchantItem2 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 257.3, -72 }, -- Frame
	MerchantItem3 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.3, -124 }, -- Frame
	MerchantItem4 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 257.3, -124 }, -- Frame
	MerchantItem5 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.3, -176 }, -- Frame
	MerchantItem6 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 257.3, -176 }, -- Frame
	MerchantItem7 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.3, -228 }, -- Frame
	MerchantItem8 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 257.3, -228 }, -- Frame
	MerchantItem9 = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 39.3, -280 }, -- Frame
	MerchantMoneyFrame = { "BOTTOMRIGHT", "MerchantFrameDiabolic", "BOTTOMRIGHT", -24, 30 }, -- Frame
	MerchantNextPageButton = { "LEFT", "MerchantPageText", "RIGHT", 8, 0 }, -- Button
	MerchantPageText = { "CENTER", "MerchantFrameDiabolic", "TOP", 0, -384 }, -- FontString "Page 1 of 3"
	MerchantPrevPageButton = { "RIGHT", "MerchantPageText", "LEFT", -8, 0 }, -- Button
	MerchantRepairAllButton = { "TOPLEFT", "MerchantFrameDiabolic", "TOPLEFT", 288, -434 }, -- Button

	-- PVPParentFrame --------------------------------------------------------
	-- the battlegrounds' block (title row, list, rewards) 5 left: in the middle
	BattlegroundType1 = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 18, -79 }, -- Button "Arathi Basin (Call to Arms)"
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
	-- as wide with no scroll bar: Blizzard widens the rows it hangs from when
	-- the list doesn't scroll, and the panels would follow
	PVPBattlegroundFrameTypeScrollFrame = { "TOPLEFT", "BattlegroundType1", "TOPLEFT", 0, 2, 295, 87 }, -- ScrollFrame
	WintergraspTimer = { "RIGHT", "PVPBattlegroundFrame", "TOPRIGHT", -45, -53 }, -- Frame

	-- PlayerTalentFrame -----------------------------------------------------
	PlayerTalentFrameActivateButton = { "CENTER", "PlayerTalentFrameDiabolicBand", "CENTER", 0, 0 }, -- Button "Activate These Talents"
	PlayerTalentFrameStatusFrame = { "CENTER", "PlayerTalentFrameDiabolicBand", "CENTER", 0, 0 }, -- Frame

	-- QuestLogFrame ---------------------------------------------------------
	QuestLogScrollFrame = { "TOPLEFT", "QuestLogFrameDiabolic", "TOPLEFT", 30, -40, 305, 340 }, -- ScrollFrame

	-- SpellBookFrame --------------------------------------------------------
	CompanionButton1 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 16, -189 }, -- CheckButton
	CompanionButton10 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 16, -333 }, -- CheckButton
	CompanionButton11 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 178, -333 }, -- CheckButton
	CompanionButton12 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 340, -333 }, -- CheckButton
	CompanionButton2 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 178, -189 }, -- CheckButton
	CompanionButton3 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 340, -189 }, -- CheckButton
	CompanionButton4 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 16, -237 }, -- CheckButton
	CompanionButton5 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 178, -237 }, -- CheckButton
	CompanionButton6 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 340, -237 }, -- CheckButton
	CompanionButton7 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 16, -285 }, -- CheckButton
	CompanionButton8 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 178, -285 }, -- CheckButton
	CompanionButton9 = { "TOPLEFT", "PetPaperDollFrameCompanionFrame", "TOPLEFT", 340, -285 }, -- CheckButton
	CompanionNextPageButton = { "TOPRIGHT", "PetPaperDollFrameCompanionFrame", "TOPRIGHT", -12, -387 }, -- Button
	CompanionPageNumber = { "RIGHT", "CompanionNextPageButton", "LEFT", -4, 0 }, -- FontString "Page 1 of 1"
	CompanionPrevPageButton = { "RIGHT", "CompanionPageNumber", "LEFT", -4, 0 }, -- Button
	SpellBookSkillLineTab1 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -116 }, -- CheckButton
	SpellBookSkillLineTab2 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -164 }, -- CheckButton
	SpellBookSkillLineTab3 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -212 }, -- CheckButton
	SpellBookSkillLineTab4 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -260 }, -- CheckButton
	SpellBookSkillLineTab5 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -308 }, -- CheckButton
	SpellBookSkillLineTab6 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -356 }, -- CheckButton
	SpellBookSkillLineTab7 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -404 }, -- CheckButton
	SpellBookSkillLineTab8 = { "TOPLEFT", "SpellBookFrameDiabolic", "TOPLEFT", 486, -452 }, -- CheckButton

	-- TradeFrame ------------------------------------------------------------
	-- the names over their columns, out from under the band (Blizzard's beside portraits)
	TradeFramePlayerNameText = { "BOTTOM", "TradePlayerItem1", "TOP", 0, 50 }, -- FontString "Padirac"
	TradeFrameRecipientNameText = { "BOTTOM", "TradeRecipientItem1", "TOP", 0, 50 }, -- FontString "Velkara"

	-- TradeSkillFrame -------------------------------------------------------
	TradeSkillDecrementButton = { "LEFT", "TradeSkillCreateAllButton", "RIGHT", 2, 0 }, -- Button
	TradeSkillDetailScrollFrame = { "TOPLEFT", "TradeSkillFrame", "TOPLEFT", 20, -255, 297, 132 }, -- ScrollFrame
	TradeSkillExpandButtonFrame = { "TOPLEFT", "TradeSkillFrame", "TOPLEFT", 15, -53 }, -- Frame
	TradeSkillFrameAvailableFilterCheckButton = { "LEFT", "TradeSkillFrameEditBox", "RIGHT", 12, 0 }, -- CheckButton
	TradeSkillIncrementButton = { "LEFT", "TradeSkillInputBox", "RIGHT", 8, 0 }, -- Button
	TradeSkillInputBox = { "LEFT", "TradeSkillDecrementButton", "RIGHT", 8, 0 }, -- EditBox "1"
	TradeSkillInvSlotDropDown = { "TOPRIGHT", "TradeSkillFrame", "TOPRIGHT", -21, -48 }, -- Frame
	TradeSkillListScrollFrame = { "TOPRIGHT", "TradeSkillFrame", "TOPRIGHT", -67, -89, 296, 125 }, -- ScrollFrame
	-- the skill's bar centred on our window (24 left of the frame, 14 right of it:
	-- room for the scroll bars), its rank in it
	TradeSkillRankFrame = { "TOP", "TradeSkillFrame", "TOPLEFT", 187, -32 }, -- StatusBar
	TradeSkillRankFrameSkillRank = { "CENTER", "TradeSkillRankFrame", "CENTER", 0, 0 }, -- FontString "450/450"
	TradeSkillReagent1 = { "TOPLEFT", "TradeSkillReagentLabel", "BOTTOMLEFT", -2, -7 }, -- Button
	TradeSkillReagent3 = { "TOPLEFT", "TradeSkillReagent1", "BOTTOMLEFT", 0, -6 }, -- Button
	TradeSkillReagent5 = { "TOPLEFT", "TradeSkillReagent3", "BOTTOMLEFT", 0, -6 }, -- Button
	TradeSkillReagent6 = { "LEFT", "TradeSkillReagent5", "RIGHT", 0, 0 }, -- Button
	TradeSkillReagent7 = { "TOPLEFT", "TradeSkillReagent6", "BOTTOMLEFT", 0, -6 }, -- Button
	TradeSkillSkill1 = { "TOPLEFT", "TradeSkillFrame", "TOPLEFT", 22, -89 }, -- Button "Bandage"
	TradeSkillSubClassDropDown = { "RIGHT", "TradeSkillInvSlotDropDown", "LEFT", 27, 0 }, -- Frame
})
