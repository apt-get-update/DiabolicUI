-- The parts placed for good: { point, the frame it's placed on, that frame's
-- point, x, y, width, height } (x right, y up), without a width and height it
-- keeps its size, { width, height } alone sizes it where it is, whatever else
-- moves it; second = { point, that frame's point, x, y } stretches it to there
-- too (modules/blizzard/adjust.lua).
-- Written from windows/*.qml by tools/positions.lua: change those (docs:
-- Common Tasks), this file is overwritten.
local _, Engine = ...

Engine:NewStaticConfig("Positions", {

	-- AuctionFrame ----------------------------------------------------------
	Atr_Buy1_Button = { "BOTTOMLEFT", "AuctionFrameDiabolicFoot", "BOTTOMLEFT", 548, 7, 84.3, 22 }, -- Button "Buy"
	Atr_CancelSelectionButton = { "LEFT", "Atr_Buy1_Button", "RIGHT", 6, 0, 105.8, 22 }, -- Button "Cancel Auction"
	-- Auctionator's left column (its parts: auction.lua)
	Atr_Main_PanelDiabolicLeft = { "TOPLEFT", "AuctionFrame", "TOPLEFT", -8, -46, 212, 367 }, -- Frame
	-- Auctionator's results, right of it
	Atr_Main_PanelDiabolicRight = { "TOPLEFT", "AuctionFrame", "TOPLEFT", 212, -46, 628, 367 }, -- Frame
	AuctionFilterButton1 = { "TOPLEFT", "AuctionFrameBrowseDiabolicCategories", "TOPLEFT", 10, -4 }, -- Button "Weapon"
	-- Auctions' results, right of it
	AuctionFrameAuctionsDiabolicResults = { "TOPLEFT", "AuctionFrame", "TOPLEFT", 210, -46, 630, 367 }, -- Frame
	-- Auctions' selling column (Blizzard's parts: auction.lua)
	AuctionFrameAuctionsDiabolicSelling = { "TOPLEFT", "AuctionFrame", "TOPLEFT", -8, -46, 210, 367 }, -- Frame
	-- Bids' results, across the page
	AuctionFrameBidDiabolicResults = { "TOPLEFT", "AuctionFrame", "TOPLEFT", -8, -46, 848, 367 }, -- Frame
	-- Browse's categories, under its toolbar
	AuctionFrameBrowseDiabolicCategories = { "TOPLEFT", "AuctionFrame", "TOPLEFT", -8, -78, 178, 335 }, -- Frame
	-- Browse's results, right of the categories
	AuctionFrameBrowseDiabolicResults = { "TOPLEFT", "AuctionFrame", "TOPLEFT", 178, -78, 662, 335 }, -- Frame
	AuctionFrameDiabolicFoot = { "BOTTOMLEFT", "AuctionFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	AuctionFrameMoneyFrame = { "BOTTOMRIGHT", "AuctionFrameDiabolicFoot", "BOTTOMLEFT", 182, 13 }, -- Frame
	AuctionatorCloseButton = { "LEFT", "Atr_CancelSelectionButton", "RIGHT", 6, 0, 74.9, 22 }, -- Button "Close"
	AuctionsButton1 = { "TOPLEFT", "AuctionFrameAuctionsDiabolicResults", "TOPLEFT", 14, -25 }, -- Button
	AuctionsCancelAuctionButton = { "BOTTOMLEFT", "AuctionFrameDiabolicFoot", "BOTTOMLEFT", 621, 7, 121.1, 22 }, -- Button "Cancel Auction"
	AuctionsCloseButton = { "LEFT", "AuctionsCancelAuctionButton", "RIGHT", 6, 0, 76.9, 22 }, -- Button "Close"
	AuctionsCreateAuctionButton = { "BOTTOM", "AuctionFrameAuctionsDiabolicSelling", "BOTTOM", 0, 7 }, -- Button "Create Auction"
	AuctionsQualitySort = { "TOPLEFT", "AuctionFrameAuctionsDiabolicResults", "TOPLEFT", 14, -4 }, -- Button "Rarity"
	AuctionsScrollFrame = { "TOPRIGHT", "AuctionFrameAuctionsDiabolicResults", "TOPLEFT", 593, -25, 435, 338 }, -- ScrollFrame
	BidBidButton = { "BOTTOMLEFT", "AuctionFrameDiabolicFoot", "BOTTOMLEFT", 585, 7, 76, 22 }, -- Button "Bid"
	BidBidPrice = { "BOTTOM", "AuctionFrameDiabolicFoot", "BOTTOM", -52, 11 }, -- Frame
	BidBidText = { "BOTTOMRIGHT", "AuctionFrameDiabolicFoot", "BOTTOM", -151.9, 14 }, -- FontString "Bid"
	-- its rows (shown with bids: a scan without any doesn't see them)
	BidButton1 = { "TOPLEFT", "AuctionFrameBidDiabolicResults", "TOPLEFT", 27, -25 }, -- Button
	BidBuyoutButton = { "LEFT", "BidBidButton", "RIGHT", 6, 0, 76, 22 }, -- Button "Buyout"
	BidCloseButton = { "LEFT", "BidBuyoutButton", "RIGHT", 6, 0, 76, 22 }, -- Button "Close"
	BidQualitySort = { "TOPLEFT", "AuctionFrameBidDiabolicResults", "TOPLEFT", 65, -4 }, -- Button "Rarity"
	BidScrollFrame = { "TOPRIGHT", "AuctionFrameBidDiabolicResults", "TOPLEFT", 798, -25, 625, 338 }, -- ScrollFrame
	BrowseBidButton = { "BOTTOMLEFT", "AuctionFrameDiabolicFoot", "BOTTOMLEFT", 585, 7, 76, 22 }, -- Button "Bid"
	BrowseBidPrice = { "BOTTOM", "AuctionFrameDiabolicFoot", "BOTTOM", -12, 11 }, -- Frame
	BrowseButton1 = { "TOPLEFT", "AuctionFrameBrowseDiabolicResults", "TOPLEFT", 18, -25 }, -- Button
	BrowseBuyoutButton = { "LEFT", "BrowseBidButton", "RIGHT", 6, 0, 76, 22 }, -- Button "Buyout"
	BrowseCloseButton = { "LEFT", "BrowseBuyoutButton", "RIGHT", 6, 0, 76, 22 }, -- Button "Close"
	BrowseFilterScrollFrame = { "TOPRIGHT", "AuctionFrameBrowseDiabolicCategories", "TOPLEFT", 146, -4, 160, 327 }, -- ScrollFrame
	BrowseNextPageButton = { "RIGHT", "AuctionFrameBrowseDiabolicResults", "TOPRIGHT", -16, 20, 24, 24 }, -- Button
	BrowseNoResultsText = { "TOP", "AuctionFrameBrowseDiabolicResults", "TOP", 0, -40 }, -- FontString "Choose search criteria and press \"Search\""
	BrowseQualitySort = { "TOPLEFT", "AuctionFrameBrowseDiabolicResults", "TOPLEFT", 9, -4 }, -- Button "Rarity"
	BrowseResetButton = { "BOTTOMLEFT", "AuctionFrameBrowseDiabolicCategories", "TOPLEFT", 10, 8, 156, 24 }, -- Button "Reset"
	BrowseScrollFrame = { "TOPRIGHT", "AuctionFrameBrowseDiabolicResults", "TOPLEFT", 620, -25, 465, 306 }, -- ScrollFrame
	BrowseSearchCountText = { "LEFT", "AuctionFrameBrowseDiabolicResults", "TOPLEFT", 4, 20 }, -- FontString "Items 1 - 18  ( 118 total )"
	IsUsableCheckButton = { "LEFT", "AuctionFrameBrowseDiabolicResults", "TOPLEFT", 182, 20 }, -- CheckButton
	ShowOnPlayerCheckButton = { "LEFT", "IsUsableCheckButtonText", "RIGHT", 16, 0 }, -- CheckButton

	-- BattlefieldFrame ------------------------------------------------------
	BattlefieldFrameCancelButton = { "LEFT", "BattlefieldFrameJoinButton", "RIGHT", 6, 0, 75.6, 22 }, -- Button "Cancel"
	BattlefieldFrameDiabolicFoot = { "BOTTOMLEFT", "BattlefieldFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	BattlefieldFrameGroupJoinButton = { "BOTTOMLEFT", "BattlefieldFrameDiabolicFoot", "BOTTOMLEFT", 14, 7, 127.7, 22 }, -- Button "Join as Group"
	-- the rewards on slate too, under the instances: 16 higher (its panel clear
	-- of the buttons), its top 7 lower (apart from theirs; Blizzard's 232 high)
	BattlefieldFrameInfoScrollFrame = { "BOTTOMLEFT", "BattlefieldFrame", "BOTTOMLEFT", 19, 116, 298, 209 }, -- ScrollFrame
	BattlefieldFrameJoinButton = { "LEFT", "BattlefieldFrameGroupJoinButton", "RIGHT", 6, 0, 108.7, 22 }, -- Button "Join Battle"
	-- "Battlefield Instance:" 5 higher, apart from its list
	BattlefieldFrameNameHeader = { "TOPLEFT", "BattlefieldFrame", "TOPLEFT", 75, -50 }, -- FontString "Battlefield Instance:"

	-- CharacterFrame --------------------------------------------------------
	CharacterBackSlot = { "TOP", "CharacterShoulderSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterChestSlot = { "TOP", "CharacterBackSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterFeetSlot = { "TOP", "CharacterLegsSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterFinger0Slot = { "TOP", "CharacterFeetSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterFinger1Slot = { "TOP", "CharacterFinger0Slot", "BOTTOM", 0, -4 }, -- Button
	CharacterFrameDiabolicScene = { "TOP", "CharacterFrameDiabolicGear", "TOP", 0, -62, 248, 322 }, -- Frame
	CharacterHandsSlot = { "TOPRIGHT", "CharacterFrameDiabolicGear", "TOPRIGHT", -38, -66 }, -- Button
	CharacterHeadSlot = { "TOPLEFT", "CharacterFrameDiabolicGear", "TOPLEFT", 38, -66 }, -- Button
	CharacterLegsSlot = { "TOP", "CharacterWaistSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterMainHandSlot = { "TOPRIGHT", "CharacterSecondaryHandSlot", "TOPLEFT", -6, 0 }, -- Button
	CharacterModelFrameRotateLeftButton = { "TOPLEFT", "CharacterFrameDiabolicScene", "TOPLEFT", 4, -4 }, -- Button
	CharacterNeckSlot = { "TOP", "CharacterHeadSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterRangedSlot = { "TOPLEFT", "CharacterSecondaryHandSlot", "TOPRIGHT", 6, 0 }, -- Button
	CharacterSecondaryHandSlot = { "TOP", "CharacterFrameDiabolicScene", "BOTTOM", 0, -10 }, -- Button
	CharacterShirtSlot = { "TOP", "CharacterChestSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterShoulderSlot = { "TOP", "CharacterNeckSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterTabardSlot = { "TOP", "CharacterShirtSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterTrinket0Slot = { "TOP", "CharacterFinger1Slot", "BOTTOM", 0, -4 }, -- Button
	CharacterTrinket1Slot = { "TOP", "CharacterTrinket0Slot", "BOTTOM", 0, -4 }, -- Button
	CharacterWaistSlot = { "TOP", "CharacterHandsSlot", "BOTTOM", 0, -4 }, -- Button
	CharacterWristSlot = { "TOP", "CharacterTabardSlot", "BOTTOM", 0, -4 }, -- Button
	GearManagerDialogPopup = { "TOPLEFT", "CharacterFrameDiabolic", "TOPRIGHT", 6, 0 }, -- Frame
	-- the title's dropdown, out of sight (the titles' page has them)
	PlayerTitleFrame = { "TOP", "CharacterFrameDiabolicGear", "TOP", 0, -60 }, -- Frame
	ReputationDetailFrame = { "TOPLEFT", "CharacterFrameDiabolic", "TOPRIGHT", -8, -96 }, -- Frame
	TokenFrameMoneyFrame = { "BOTTOMRIGHT", "TokenFrame", "BOTTOMRIGHT", -44, 84 }, -- Frame
	TokenFramePopup = { "TOPLEFT", "CharacterFrameDiabolic", "TOPRIGHT", -8, -96 }, -- Frame
	TokenFramePopupBackpackCheckBox = { "TOPLEFT", "TokenFramePopupInactiveCheckBox", "BOTTOMLEFT", 0, -6 }, -- CheckButton
	TokenFramePopupCloseButton = { "TOPRIGHT", "TokenFramePopup", "TOPRIGHT", -1, -1 }, -- Button

	-- ClassTrainerFrame -----------------------------------------------------
	ClassTrainerCancelButton = { "LEFT", "ClassTrainerTrainButton", "RIGHT", 6, 0, 83.5, 22 }, -- Button "Exit"
	-- the chosen one's page 6 under the list's (Blizzard's 8 under its text)
	ClassTrainerDetailScrollFrame = { "TOPLEFT", "ClassTrainerListScrollFrame", "BOTTOMLEFT", 0, -28, 296, 121 }, -- ScrollFrame
	-- "All" and the list under the greeting (the chosen one's height: trainer.lua)
	ClassTrainerExpandButtonFrame = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 15, -66 }, -- Frame
	ClassTrainerFrameDiabolicFoot = { "BOTTOMLEFT", "ClassTrainerFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	ClassTrainerFrameDiabolicIronBar = { "TOPLEFT", "ClassTrainerListScrollFrame", "BOTTOMLEFT", -30, -6.5, 388, 16 }, -- Frame
	-- the greeting across the list's width under the band, its panel's left on
	-- the parchments', its right on their panels'
	ClassTrainerGreetingText = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 11, -34, 350, 24 }, -- FontString "Hello, priest!  Ready for some training?"
	ClassTrainerListScrollFrame = { "TOPRIGHT", "ClassTrainerFrame", "TOPRIGHT", -67, -72, 296, 158 }, -- ScrollFrame
	ClassTrainerMoneyFrame = { "BOTTOMRIGHT", "ClassTrainerFrameDiabolicFoot", "BOTTOMLEFT", 181, 12 }, -- Frame
	ClassTrainerSkill1 = { "TOPLEFT", "ClassTrainerFrame", "TOPLEFT", 22, -90 }, -- Button "Discipline"
	ClassTrainerTrainButton = { "BOTTOMLEFT", "ClassTrainerFrameDiabolicFoot", "BOTTOMLEFT", 185, 7, 83.5, 22 }, -- Button "Train"

	-- DressUpFrame ----------------------------------------------------------
	-- its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
	DressUpFrameDescriptionText = { "CENTER", "DressUpFrame", "TOP", -11, -50 }, -- FontString "CTRL-Left Click additional items to display them on your character"

	-- FriendsFrame ----------------------------------------------------------
	ChannelFrameNewButton = { "BOTTOMRIGHT", "FriendsFrameDiabolicFoot", "BOTTOMRIGHT", -14, 9 }, -- Button "Add"
	FriendsFrameAddFriendButton = { "BOTTOMLEFT", "FriendsFrameDiabolicFoot", "BOTTOMLEFT", 14, 8 }, -- Button "Add Friend"
	FriendsFrameDiabolicFoot = { "BOTTOMLEFT", "FriendsFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	FriendsFrameFriendsScrollFrameScrollBar = { "TOPLEFT", "FriendsFrameFriendsScrollFrame", "TOPRIGHT", 6, -15, second = { "BOTTOMLEFT", "BOTTOMRIGHT", 6, 15 } }, -- Slider
	FriendsFrameIgnoreButton1 = { "TOPLEFT", "FriendsFrame", "TOPLEFT", 21, -39 }, -- Button
	FriendsFrameIgnorePlayerButton = { "BOTTOMLEFT", "FriendsFrameDiabolicFoot", "BOTTOMLEFT", 14, 8 }, -- Button "Ignore Player"
	FriendsFrameIgnoreScrollFrame = { "TOPRIGHT", "FriendsFrame", "TOPRIGHT", -65, -36, 298, 340 }, -- ScrollFrame
	FriendsFrameSendMessageButton = { "LEFT", "FriendsFrameAddFriendButton", "RIGHT", 64, 0 }, -- Button "Send Message"
	FriendsFrameUnsquelchButton = { "BOTTOMRIGHT", "FriendsFrameDiabolicFoot", "BOTTOMRIGHT", -14, 8 }, -- Button "Remove Player"
	GuildEventLogFrame = { "TOPLEFT", "FriendsFrameDiabolic", "TOPRIGHT", 6, -96 }, -- Frame
	GuildFrameAddMemberButton = { "LEFT", "GuildFrameGuildInformationButton", "RIGHT", 6, 0, 94.4, 22 }, -- Button "Add Member"
	GuildFrameControlButton = { "LEFT", "GuildFrameAddMemberButton", "RIGHT", 6, 0, 96.7, 22 }, -- Button "Guild Control"
	GuildFrameGuildInformationButton = { "BOTTOMLEFT", "FriendsFrameDiabolicFoot", "BOTTOMLEFT", 14, 7, 122.9, 22 }, -- Button "Guild Information"
	GuildInfoFrame = { "TOPLEFT", "FriendsFrameDiabolic", "TOPRIGHT", 6, -96 }, -- Frame
	GuildMemberDetailFrame = { "TOPLEFT", "FriendsFrameDiabolic", "TOPRIGHT", 6, -96 }, -- Frame
	WhoFrameAddFriendButton = { "LEFT", "WhoFrameWhoButton", "RIGHT", 6, 0, 106.8, 22 }, -- Button "Add Friend"
	WhoFrameButton1 = { "TOPLEFT", "WhoFrame", "TOPLEFT", 15, -61 }, -- Button
	WhoFrameColumnHeader1 = { "TOPLEFT", "WhoFrame", "TOPLEFT", 20, -34 }, -- Button "Name"
	WhoFrameGroupInviteButton = { "LEFT", "WhoFrameAddFriendButton", "RIGHT", 6, 0, 117.8, 22 }, -- Button "Group Invite"
	WhoFrameWhoButton = { "BOTTOMLEFT", "FriendsFrameDiabolicFoot", "BOTTOMLEFT", 14, 7, 89.4, 22 }, -- Button "Refresh"
	WhoListScrollFrame = { "TOPRIGHT", "FriendsFrame", "TOPRIGHT", -67, -62 }, -- ScrollFrame

	-- GroupBulletinBoardFrame -----------------------------------------------
	GroupBulletinBoardFrameSettingsButton = { "RIGHT", "GroupBulletinBoardFrameCloseButton", "LEFT", -6, 0 }, -- Button

	-- GuildBankFrame --------------------------------------------------------
	-- the slots, logs and info 27 higher than Blizzard's: as far from the band
	-- as from the foot's iron bar
	GuildBankColumn1 = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 30, -43 }, -- Frame
	GuildBankFrameDepositButton = { "LEFT", "GuildBankFrameWithdrawButton", "RIGHT", 6, 0, 94.5, 21 }, -- Button "Deposit"
	GuildBankFrameDiabolicFoot = { "BOTTOMLEFT", "GuildBankFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	GuildBankFrameLog = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 0, 27 }, -- Frame
	GuildBankFrameWithdrawButton = { "BOTTOMLEFT", "GuildBankFrameDiabolicFoot", "BOTTOMLEFT", 562, 50, 94.5, 21 }, -- Button "Withdraw"
	GuildBankInfo = { "TOPLEFT", "GuildBankFrame", "TOPLEFT", 33, -46 }, -- Frame
	-- the info's page the logs' size, in the same place
	GuildBankInfoScrollFrame = { 688, 304 }, -- ScrollFrame
	GuildBankMoneyFrame = { "BOTTOMRIGHT", "GuildBankFrameDiabolicFoot", "BOTTOMRIGHT", -5, 29 }, -- Frame
	GuildBankMoneyLimitLabel = { "BOTTOMLEFT", "GuildBankFrameDiabolicFoot", "BOTTOMLEFT", 27, 29 }, -- FontString "Available Amount:"
	GuildBankTabInfoEditBox = { 688, 218 }, -- EditBox
	GuildBankTransactionsScrollFrame = { "TOPRIGHT", "GuildBankFrame", "TOPRIGHT", -50, -48 }, -- ScrollFrame

	-- InspectFrame ----------------------------------------------------------
	-- the level line (the guild's under it) out of the band, over the model
	InspectLevelText = { "BOTTOM", "InspectModelFrame", "TOP", 0, 22 }, -- FontString "Level 61 Human Warrior"
	InspectTalentFrameTab1 = { "BOTTOMLEFT", "InspectTalentFrameScrollFrame", "TOPLEFT", -6, 12 }, -- Button "Arms"
	InspectTalentFrameTab2 = { "LEFT", "InspectTalentFrameTab1", "RIGHT", 6, 0 }, -- Button "Fury"
	InspectTalentFrameTab3 = { "LEFT", "InspectTalentFrameTab2", "RIGHT", 6, 0 }, -- Button "Protection"

	-- KeyBindingFrame -------------------------------------------------------
	KeyBindingFrameBinding1 = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 27, -72 }, -- Frame
	KeyBindingFrameCancelButton = { "LEFT", "KeyBindingFrameOkayButton", "RIGHT", 6, 0, 125, 22 }, -- Button "Cancel"
	-- the buttons 16 lower, on the foot, as far in from both sides
	KeyBindingFrameDefaultButton = { "BOTTOMLEFT", "KeyBindingFrameDiabolicFoot", "BOTTOMLEFT", 14, 7 }, -- Button "Reset To Default"
	KeyBindingFrameDiabolicFoot = { "BOTTOMLEFT", "KeyBindingFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	KeyBindingFrameOkayButton = { "LEFT", "KeyBindingFrameUnbindButton", "RIGHT", 6, 0, 125, 22 }, -- Button "Okay"
	-- what a key was bound to between the list and the foot
	KeyBindingFrameOutputText = { "TOP", "KeyBindingFrame", "TOPLEFT", 293, -465 }, -- FontString
	-- the list (its rows too) 6 under the column names
	KeyBindingFrameScrollFrame = { "TOPLEFT", "KeyBindingFrame", "TOPLEFT", 2, -72 }, -- ScrollFrame
	KeyBindingFrameUnbindButton = { "BOTTOMLEFT", "KeyBindingFrameDiabolicFoot", "BOTTOMLEFT", 187, 7, 125, 22 }, -- Button "Unbind Key"

	-- LFDParentFrame --------------------------------------------------------
	LFDParentFrameDiabolicFoot = { "BOTTOMLEFT", "LFDParentFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	LFDQueueFrameCancelButton = { "LEFT", "LFDQueueFrameFindGroupButton", "RIGHT", 92, 0 }, -- Button "Close"
	LFDQueueFrameFindGroupButton = { "BOTTOMLEFT", "LFDParentFrameDiabolicFoot", "BOTTOMLEFT", 14, 7 }, -- Button "Find Group"
	LFDQueueFrameRandom = { "TOPLEFT", "LFDQueueFrame", "TOPLEFT", 0, 62, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", 0, 46 } }, -- Frame
	LFDQueueFrameRandomScrollFrame = { "BOTTOMRIGHT", "LFDQueueFrameRandom", "BOTTOMRIGHT", -34, 34, 298, 265 }, -- ScrollFrame
	LFDQueueFrameSpecific = { "TOPLEFT", "LFDQueueFrame", "TOPLEFT", 0, 62, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", 0, 46 } }, -- Frame

	-- LFRParentFrame --------------------------------------------------------
	LFRBrowseFrameColumnHeader1 = { "TOPLEFT", "LFRBrowseFrame", "TOPLEFT", 26, -40 }, -- Button "Name"
	LFRBrowseFrameInviteButton = { "LEFT", "LFRBrowseFrameSendMessageButton", "RIGHT", 6, 0, 74.1, 22 }, -- Button "Invite"
	LFRBrowseFrameListButton1 = { "TOPLEFT", "LFRBrowseFrame", "TOPLEFT", 12, -66 }, -- Button
	LFRBrowseFrameRefreshButton = { "LEFT", "LFRBrowseFrameInviteButton", "RIGHT", 6, 0, 83.6, 22 }, -- Button "Refresh"
	LFRBrowseFrameSendMessageButton = { "BOTTOMLEFT", "LFRParentFrameDiabolicFoot", "BOTTOMLEFT", 14, 7, 126.3, 22 }, -- Button "Send Message"
	LFRParentFrameDiabolicFoot = { "BOTTOMLEFT", "LFRParentFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	LFRQueueFrameAcceptCommentButton = { "LEFT", "LFRQueueFrameFindGroupButton", "RIGHT", 56, 0 }, -- Button "Set Comment"
	LFRQueueFrameFindGroupButton = { "BOTTOMLEFT", "LFRParentFrameDiabolicFoot", "BOTTOMLEFT", 14, 7 }, -- Button "List My Name"
	LFRQueueFrameSpecificListButton1 = { "TOPLEFT", "LFRQueueFrameSpecific", "TOPLEFT", 17, -132 }, -- Frame

	-- MacroFrame ------------------------------------------------------------
	-- the icons and the macro 20 up and 6 left (as far from the band as from the
	-- foot's bar, from the sides)
	MacroButtonScrollFrame = { "TOPLEFT", "MacroFrame", "TOPLEFT", 17, -56 }, -- ScrollFrame
	-- the buttons 10 down (30 over the window's bottom)
	MacroDeleteButton = { "BOTTOMLEFT", "MacroFrameDiabolicFoot", "BOTTOMLEFT", 14, 7 }, -- Button "Delete"
	MacroExitButton = { "LEFT", "MacroNewButton", "RIGHT", 6, 0, 80, 22 }, -- Button "Exit"
	-- the count of characters right of "Enter Macro Commands:" (Blizzard's
	-- under the text, over the foot)
	MacroFrameCharLimitText = { "BOTTOMRIGHT", "MacroFrameScrollFrame", "TOPRIGHT", 0, 8 }, -- FontString "80/255 Characters Used"
	MacroFrameDiabolicFoot = { "BOTTOMLEFT", "MacroFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	MacroFrameSelectedMacroBackground = { "TOPLEFT", "MacroFrame", "TOPLEFT", 10, -208 },
	MacroNewButton = { "BOTTOMLEFT", "MacroFrameDiabolicFoot", "BOTTOMLEFT", 172, 7, 80, 22 }, -- Button "New"

	-- MailFrame -------------------------------------------------------------
	InboxCurrentPage = { "BOTTOM", "MailFrameDiabolicFoot", "BOTTOM", -6, 8 }, -- FontString
	InboxNextPageButton = { "CENTER", "MailFrameDiabolicFoot", "BOTTOMLEFT", 307, 16 }, -- Button
	InboxPrevPageButton = { "CENTER", "MailFrameDiabolicFoot", "BOTTOMLEFT", 43, 16 }, -- Button
	MailFrameDiabolicFoot = { "BOTTOMLEFT", "MailFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	SendMailCancelButton = { "LEFT", "SendMailMailButton", "RIGHT", 6, 0, 78, 22 }, -- Button "Cancel"
	SendMailMailButton = { "BOTTOMLEFT", "MailFrameDiabolicFoot", "BOTTOMLEFT", 178, 7, 78, 22 }, -- Button "Send"
	SendMailMoneyButton = { "BOTTOMLEFT", "MailFrameDiabolicFoot", "BOTTOMLEFT", 23, 47 }, -- Frame
	SendMailMoneyFrame = { "BOTTOMRIGHT", "MailFrameDiabolicFoot", "BOTTOMLEFT", 176, 11 }, -- Frame

	-- MerchantFrame ---------------------------------------------------------
	DiabolicSellJunkButton = { "TOPRIGHT", "MerchantFrameDiabolicFoot", "TOPRIGHT", -9, -14 }, -- Button "Sell Junk"
	MerchantBuyBackItem = { "TOPLEFT", "MerchantFrameDiabolicFoot", "TOPLEFT", 16.2, -13.8 }, -- Frame
	MerchantFrameDiabolicFoot = { "BOTTOMLEFT", "MerchantFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
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
	MerchantMoneyFrame = { "BOTTOMRIGHT", "MerchantFrameDiabolicFoot", "BOTTOMRIGHT", -1, 7 }, -- Frame
	MerchantNextPageButton = { "LEFT", "MerchantPageText", "RIGHT", 8, 0 }, -- Button
	MerchantPageText = { "CENTER", "MerchantFrameDiabolic", "TOP", 0, -384 }, -- FontString "Page 1 of 3"
	MerchantPrevPageButton = { "RIGHT", "MerchantPageText", "LEFT", -8, 0 }, -- Button
	MerchantRepairAllButton = { "TOPLEFT", "MerchantFrameDiabolicFoot", "TOPLEFT", 265, -14 }, -- Button

	-- OpenMailFrame ---------------------------------------------------------
	OpenMailCancelButton = { "LEFT", "OpenMailDeleteButton", "RIGHT", 6, 0, 78, 22 }, -- Button "Close"
	OpenMailDeleteButton = { "LEFT", "OpenMailReplyButton", "RIGHT", 6, 0, 78, 22 }, -- Button "Return"
	OpenMailFrameDiabolicFoot = { "BOTTOMLEFT", "OpenMailFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	OpenMailReplyButton = { "BOTTOMLEFT", "OpenMailFrameDiabolicFoot", "BOTTOMLEFT", 94, 7, 78, 22 }, -- Button "Reply"

	-- PVPParentFrame --------------------------------------------------------
	-- the battlegrounds' block (title row, list, rewards) 5 left: in the middle
	BattlegroundType1 = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 18, -79 }, -- Button "Random Battleground"
	-- 8 apart
	PVPBattlegroundFrameCancelButton = { "LEFT", "PVPBattlegroundFrameJoinButton", "RIGHT", 6, 0, 77.4, 22 }, -- Button "Cancel"
	-- 8 apart
	PVPBattlegroundFrameGroupJoinButton = { "BOTTOMLEFT", "PVPParentFrameDiabolicFoot", "BOTTOMLEFT", 14, 7, 128, 22 }, -- Button "Join as Party"
	-- the rewards 208 high (Blizzard's 232): 6 over the foot's iron bar, 6 under the list
	PVPBattlegroundFrameInfoScrollFrame = { "BOTTOMLEFT", "PVPBattlegroundFrame", "BOTTOMLEFT", 15, 122, 298, 208 }, -- ScrollFrame
	-- the buttons in the middle of the window's foot (its middle 15 left of the
	-- frame's; Join as Party wider than Cancel, so Join Battle 27 right of it),
	-- room between the rewards and the foot
	PVPBattlegroundFrameJoinButton = { "LEFT", "PVPBattlegroundFrameGroupJoinButton", "RIGHT", 6, 0, 110.6, 22 }, -- Button "Join Battle"
	PVPBattlegroundFrameNameHeader = { "TOPLEFT", "PVPBattlegroundFrame", "TOPLEFT", 65, -53 }, -- FontString "Battleground"
	-- as wide with no scroll bar: Blizzard widens the rows it hangs from when
	-- the list doesn't scroll, and the panels would follow
	PVPBattlegroundFrameTypeScrollFrame = { "TOPLEFT", "BattlegroundType1", "TOPLEFT", 0, 2, 295, 87 }, -- ScrollFrame
	PVPParentFrameDiabolicFoot = { "BOTTOMLEFT", "PVPParentFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	WintergraspTimer = { "RIGHT", "PVPBattlegroundFrame", "TOPRIGHT", -45, -53 }, -- Frame

	-- PlayerTalentFrame -----------------------------------------------------
	PlayerTalentFrameActivateButton = { "CENTER", "PlayerTalentFrameDiabolicBand", "CENTER", 0, 0 }, -- Button "Activate These Talents"
	PlayerTalentFrameStatusFrame = { "CENTER", "PlayerTalentFrameDiabolicBand", "CENTER", 0, 0 }, -- Frame

	-- QuestLogFrame ---------------------------------------------------------
	QuestLogFrameDiabolicFoot = { "BOTTOMLEFT", "QuestLogFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
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
	TradeFrameCancelButton = { "LEFT", "TradeFrameTradeButton", "RIGHT", 6, 0, 80, 22 }, -- Button "Cancel"
	TradeFrameDiabolicFoot = { "BOTTOMLEFT", "TradeFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	TradeFramePlayerEnchantText = { "TOPLEFT", "TradePlayerItem7", "TOPLEFT", 0, 18 }, -- FontString "Will not be traded"
	-- the names over their columns, out from under the band (Blizzard's beside portraits)
	TradeFramePlayerNameText = { "BOTTOM", "TradePlayerItem1", "TOP", 0, 44 }, -- FontString "Padirac"
	TradeFrameRecipientEnchantText = { "TOPLEFT", "TradeRecipientItem7", "TOPLEFT", 0, 18 }, -- FontString "Will not be traded"
	TradeFrameRecipientNameText = { "BOTTOM", "TradeRecipientItem1", "TOP", 0, 44 }, -- FontString "Tmanx"
	TradeFrameTradeButton = { "BOTTOMLEFT", "TradeFrameDiabolicFoot", "BOTTOMLEFT", 196, 7, 80, 22 }, -- Button "Trade"
	TradeHighlightPlayer = { "TOPLEFT", "TradePlayerItem1", "TOPLEFT", -7, 4 }, -- Frame
	-- the recipient's accepted glow, as yours (not seen by a scan made before they accept)
	TradeHighlightRecipient = { "TOPLEFT", "TradeRecipientItem1", "TOPLEFT", -6, 4 }, -- Frame
	TradePlayerInputMoneyFrame = { "TOPLEFT", "TradePlayerItem1", "TOPLEFT", 0, 31 }, -- Frame
	TradePlayerItem1 = { "TOPLEFT", "TradeFrame", "TOPLEFT", 20, -96 }, -- Frame
	TradePlayerItem7 = { "TOPLEFT", "TradePlayerItem6", "BOTTOMLEFT", 0, -26 }, -- Frame
	TradeRecipientItem1 = { "TOPLEFT", "TradeFrame", "TOPLEFT", 201, -96 }, -- Frame
	TradeRecipientItem7 = { "TOPLEFT", "TradeRecipientItem6", "BOTTOMLEFT", 0, -26 }, -- Frame
	TradeRecipientMoneyFrame = { "RIGHT", "TradeRecipientItem1", "TOPRIGHT", 0, 22 }, -- Frame

	-- TradeSkillFrame -------------------------------------------------------
	TradeSkillCancelButton = { "LEFT", "TradeSkillCreateButton", "RIGHT", 6, 0, 85.5, 22 }, -- Button "Exit"
	TradeSkillCreateButton = { "BOTTOMLEFT", "TradeSkillFrameDiabolicFoot", "BOTTOMLEFT", 185, 7, 85.5, 22 }, -- Button "Create"
	TradeSkillDecrementButton = { "LEFT", "TradeSkillCreateAllButton", "RIGHT", 2, 0 }, -- Button
	TradeSkillDetailScrollFrame = { "TOPLEFT", "TradeSkillListScrollFrame", "BOTTOMLEFT", -1, -34, 297, 157 }, -- ScrollFrame
	TradeSkillExpandButtonFrame = { "TOPLEFT", "TradeSkillFrame", "TOPLEFT", 15, -64 }, -- Frame
	TradeSkillFrameAvailableFilterCheckButton = { "LEFT", "TradeSkillFrameEditBox", "RIGHT", 12, 0 }, -- CheckButton
	TradeSkillFrameDiabolicFoot = { "BOTTOMLEFT", "TradeSkillFrameDiabolic", "BOTTOMLEFT", 23, 23, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -23, 23 } }, -- Frame
	TradeSkillFrameDiabolicIronBar = { "TOPLEFT", "TradeSkillListScrollFrame", "BOTTOMLEFT", -30, -6.5, 392, 16 }, -- Frame
	TradeSkillIncrementButton = { "LEFT", "TradeSkillInputBox", "RIGHT", 8, 0 }, -- Button
	TradeSkillInputBox = { "LEFT", "TradeSkillDecrementButton", "RIGHT", 8, 0 }, -- EditBox "1"
	TradeSkillInvSlotDropDown = { "TOPRIGHT", "TradeSkillFrame", "TOPRIGHT", -78, -27 }, -- Frame
	TradeSkillListScrollFrame = { "TOPRIGHT", "TradeSkillFrame", "TOPRIGHT", -67, -68, 296, 135 }, -- ScrollFrame
	-- the skill's bar centred on our window (24 left of the frame, 14 right of it:
	-- room for the scroll bars), its rank in it
	TradeSkillRankFrame = { "TOP", "TradeSkillFrame", "TOPLEFT", 187, -32 }, -- StatusBar
	TradeSkillRankFrameSkillRank = { "CENTER", "TradeSkillRankFrame", "CENTER", 0, 0 }, -- FontString "450/450"
	TradeSkillReagent1 = { "TOPLEFT", "TradeSkillReagentLabel", "BOTTOMLEFT", -2, -7 }, -- Button
	TradeSkillReagent3 = { "TOPLEFT", "TradeSkillReagent1", "BOTTOMLEFT", 0, -6 }, -- Button
	TradeSkillReagent5 = { "TOPLEFT", "TradeSkillReagent3", "BOTTOMLEFT", 0, -6 }, -- Button
	TradeSkillReagent6 = { "LEFT", "TradeSkillReagent5", "RIGHT", 0, 0 }, -- Button
	TradeSkillReagent7 = { "TOPLEFT", "TradeSkillReagent6", "BOTTOMLEFT", 0, -6 }, -- Button
	TradeSkillSkill1 = { "TOPLEFT", "TradeSkillFrame", "TOPLEFT", 22, -88 }, -- Button " Frostweave Bag"
	TradeSkillSubClassDropDown = { "RIGHT", "TradeSkillInvSlotDropDown", "LEFT", 27, 0 }, -- Frame
})
