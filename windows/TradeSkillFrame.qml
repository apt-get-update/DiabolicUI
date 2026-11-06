// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: tradeSkillFrame
    name: "TradeSkillFrame"
    width: 384
    height: 512

    Button {
        id: auctionator_Search
        name: "Auctionator_Search"
        text: "Scan AH"
        wowParent: "TradeSkillDetailScrollChildFrame"
        style: "Button"
        anchors.right: tradeSkillDetailScrollChildFrame.right
        anchors.rightMargin: 4
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 4
        width: 96
        height: 32
    }

    FontString {
        id: auctionator_SearchText
        name: "Auctionator_SearchText"
        text: "Scan AH"
        wowParent: "Auctionator_Search"
        anchors.horizontalCenter: auctionator_Search.horizontalCenter
        anchors.verticalCenter: auctionator_Search.verticalCenter
        width: 43.5
        height: 10.3
    }

    Button {
        id: tradeSkillCancelButton
        name: "TradeSkillCancelButton"
        text: "Exit"
        wowParent: "TradeSkillFrame"
        style: "Button"
        pin: "all"
        anchors.left: tradeSkillCreateButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: tradeSkillCreateButton.verticalCenter
        width: 85.5
        height: 22
    }

    FontString {
        id: tradeSkillCancelButtonText
        name: "TradeSkillCancelButtonText"
        text: "Exit"
        wowParent: "TradeSkillCancelButton"
        anchors.horizontalCenter: tradeSkillCancelButton.horizontalCenter
        anchors.verticalCenter: tradeSkillCancelButton.verticalCenter
        width: 21.3
        height: 10.3
    }

    Button {
        id: tradeSkillCollapseAllButton
        name: "TradeSkillCollapseAllButton"
        text: "All"
        wowParent: "TradeSkillExpandButtonFrame"
        anchors.left: tradeSkillExpandTabLeft.right
        anchors.verticalCenter: tradeSkillExpandTabLeft.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 22
    }

    FontString {
        id: tradeSkillCollapseAllButtonSubText
        name: "TradeSkillCollapseAllButtonSubText"
        wowParent: "TradeSkillCollapseAllButton"
        anchors.left: tradeSkillCollapseAllButton.left
        anchors.verticalCenter: tradeSkillCollapseAllButton.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillCollapseAllButtonText
        name: "TradeSkillCollapseAllButtonText"
        text: "All"
        wowParent: "TradeSkillCollapseAllButton"
        anchors.left: tradeSkillCollapseAllButtonHighlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillCollapseAllButtonHighlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Button {
        id: tradeSkillCreateAllButton
        name: "TradeSkillCreateAllButton"
        text: "Create All"
        wowParent: "TradeSkillFrame"
        style: "Button"
        anchors.right: tradeSkillCreateButton.left
        anchors.rightMargin: 86
        anchors.verticalCenter: tradeSkillCreateButton.verticalCenter
        width: 80
        height: 22
    }

    FontString {
        id: tradeSkillCreateAllButtonText
        name: "TradeSkillCreateAllButtonText"
        text: "Create All"
        wowParent: "TradeSkillCreateAllButton"
        anchors.horizontalCenter: tradeSkillCreateAllButton.horizontalCenter
        anchors.verticalCenter: tradeSkillCreateAllButton.verticalCenter
        width: 52.1
        height: 10.3
    }

    Button {
        id: tradeSkillCreateButton
        name: "TradeSkillCreateButton"
        text: "Create"
        wowParent: "TradeSkillFrame"
        style: "Button"
        pin: "all"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.leftMargin: 208
        anchors.bottom: tradeSkillFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 85.5
        height: 22
    }

    FontString {
        id: tradeSkillCreateButtonText
        name: "TradeSkillCreateButtonText"
        text: "Create"
        wowParent: "TradeSkillCreateButton"
        anchors.horizontalCenter: tradeSkillCreateButton.horizontalCenter
        anchors.verticalCenter: tradeSkillCreateButton.verticalCenter
        width: 36.3
        height: 10.3
    }

    Button {
        id: tradeSkillDecrementButton
        name: "TradeSkillDecrementButton"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillCreateAllButton.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillCreateAllButton.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: tradeSkillDescription
        name: "TradeSkillDescription"
        text: " "
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 50
        width: 290
        height: 10.3
    }

    Frame {
        id: tradeSkillDetailScrollChildFrame
        name: "TradeSkillDetailScrollChildFrame"
        wowParent: "TradeSkillDetailScrollFrame"
        anchors.left: tradeSkillDetailScrollFrame.left
        anchors.top: tradeSkillDetailScrollFrame.top
        width: 297
        height: 150
    }

    ScrollFrame {
        id: tradeSkillDetailScrollFrame
        name: "TradeSkillDetailScrollFrame"
        wowParent: "TradeSkillFrame"
        pin: "all"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: 20
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 255
        width: 297
        height: 132
    }

    Frame {
        id: tradeSkillDetailScrollFrameDiabolicPanel
        name: "TradeSkillDetailScrollFrameDiabolicPanel"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillDetailScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: tradeSkillDetailScrollFrame.top
        anchors.topMargin: -12
        width: 361
        height: 150
    }

    Frame {
        id: tradeSkillDetailScrollFrameDiabolicParchment
        name: "TradeSkillDetailScrollFrameDiabolicParchment"
        wowParent: "TradeSkillFrame"
        anchors.horizontalCenter: tradeSkillDetailScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 5.5
        anchors.top: tradeSkillDetailScrollFrame.top
        anchors.topMargin: -10
        width: 334
        height: 146
    }

    Slider {
        id: tradeSkillDetailScrollFrameScrollBar
        name: "TradeSkillDetailScrollFrameScrollBar"
        wowParent: "TradeSkillDetailScrollFrame"
        style: "ScrollBar"
        anchors.left: tradeSkillDetailScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: tradeSkillDetailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 100
    }

    Frame {
        id: tradeSkillDetailScrollFrameScrollBarDiabolicTrack
        name: "TradeSkillDetailScrollFrameScrollBarDiabolicTrack"
        wowParent: "TradeSkillDetailScrollFrameScrollBar"
        anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: tradeSkillDetailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 134
    }

    Button {
        id: tradeSkillDetailScrollFrameScrollBarScrollDownButton
        name: "TradeSkillDetailScrollFrameScrollBarScrollDownButton"
        wowParent: "TradeSkillDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBar.horizontalCenter
        anchors.top: tradeSkillDetailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: tradeSkillDetailScrollFrameScrollBarScrollUpButton
        name: "TradeSkillDetailScrollFrameScrollBarScrollUpButton"
        wowParent: "TradeSkillDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: tradeSkillDetailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: tradeSkillExpandButtonFrame
        name: "TradeSkillExpandButtonFrame"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: 15
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 53
        width: 54
        height: 32
    }

    CheckButton {
        id: tradeSkillFrameAvailableFilterCheckButton
        name: "TradeSkillFrameAvailableFilterCheckButton"
        wowParent: "TradeSkillFrame"
        style: "CheckBox"
        pin: "place"
        anchors.left: tradeSkillFrameEditBox.right
        anchors.leftMargin: 12
        anchors.verticalCenter: tradeSkillFrameEditBox.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: tradeSkillFrameAvailableFilterCheckButtonText
        name: "TradeSkillFrameAvailableFilterCheckButtonText"
        text: "Have Materials"
        wowParent: "TradeSkillFrameAvailableFilterCheckButton"
        anchors.left: tradeSkillFrameAvailableFilterCheckButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: tradeSkillFrameAvailableFilterCheckButton.verticalCenter
        width: 86.1
        height: 14.2
    }

    Button {
        id: tradeSkillFrameCloseButton
        name: "TradeSkillFrameCloseButton"
        wowParent: "TradeSkillFrame"
        style: "CloseButton"
        anchors.horizontalCenter: tradeSkillFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: tradeSkillFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Frame {
        id: tradeSkillFrameDiabolic
        name: "TradeSkillFrameDiabolic"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: -24
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: -40
        width: 422
        height: 509
    }

    Frame {
        id: tradeSkillFrameDiabolicBand
        name: "TradeSkillFrameDiabolicBand"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: tradeSkillFrameDiabolic.top
        anchors.topMargin: 24
        width: 374
        height: 40
    }

    Frame {
        id: tradeSkillFrameDiabolicBorder
        name: "TradeSkillFrameDiabolicBorder"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.top: tradeSkillFrameDiabolic.top
        width: 422
        height: 509
    }

    Frame {
        id: tradeSkillFrameDiabolicFoot
        name: "TradeSkillFrameDiabolicFoot"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.horizontalCenter: tradeSkillCreateAllButton.horizontalCenter
        anchors.horizontalCenterOffset: 129
        anchors.top: tradeSkillCreateAllButton.top
        anchors.topMargin: -6
        width: 376
        height: 35
    }

    Frame {
        id: tradeSkillFrameDiabolicIronBar
        name: "TradeSkillFrameDiabolicIronBar"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.top: tradeSkillFrameDiabolic.top
        width: 422
        height: 509
    }

    Frame {
        id: tradeSkillFrameDiabolicSocket
        name: "TradeSkillFrameDiabolicSocket"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.right: tradeSkillFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: tradeSkillFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: tradeSkillFrameDiabolicTitlePlate
        name: "TradeSkillFrameDiabolicTitlePlate"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.horizontalCenter: tradeSkillFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: tradeSkillFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: tradeSkillFrameDiabolicTitlePlateGem
        name: "TradeSkillFrameDiabolicTitlePlateGem"
        wowParent: "TradeSkillFrameDiabolicTitlePlate"
        anchors.horizontalCenter: tradeSkillFrameDiabolicTitlePlate.left
        anchors.horizontalCenterOffset: 35
        anchors.verticalCenter: tradeSkillFrameDiabolicTitlePlate.verticalCenter
        width: 40
        height: 40
    }

    EditBox {
        id: tradeSkillFrameEditBox
        name: "TradeSkillFrameEditBox"
        text: "Search"
        wowParent: "TradeSkillFrame"
        style: "EditBox"
        anchors.left: tradeSkillFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: tradeSkillFrameDiabolicBand.verticalCenter
        width: 128
        height: 20
    }

    Frame {
        id: tradeSkillFrameEditBoxDiabolicField
        name: "TradeSkillFrameEditBoxDiabolicField"
        wowParent: "TradeSkillFrameEditBox"
        anchors.left: tradeSkillFrameEditBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: tradeSkillFrameEditBox.verticalCenter
        width: 144
        height: 22
    }

    FontString {
        id: tradeSkillFrameTitleText
        name: "TradeSkillFrameTitleText"
        text: "First Aid"
        wowParent: "TradeSkillFrameDiabolicTitlePlate"
        anchors.horizontalCenter: tradeSkillFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: tradeSkillFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 79.8
        height: 14.2
    }

    Frame {
        id: tradeSkillHighlightFrame
        name: "TradeSkillHighlightFrame"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill2.left
        anchors.top: tradeSkillSkill2.top
        width: 293
        height: 16
    }

    Button {
        id: tradeSkillIncrementButton
        name: "TradeSkillIncrementButton"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillInputBox.right
        anchors.leftMargin: 8
        anchors.verticalCenter: tradeSkillInputBox.verticalCenter
        width: 20
        height: 20
    }

    EditBox {
        id: tradeSkillInputBox
        name: "TradeSkillInputBox"
        text: "1"
        wowParent: "TradeSkillFrame"
        style: "EditBox"
        pin: "place"
        anchors.left: tradeSkillDecrementButton.right
        anchors.leftMargin: 8
        anchors.verticalCenter: tradeSkillDecrementButton.verticalCenter
        width: 26
        height: 20
    }

    Frame {
        id: tradeSkillInputBoxDiabolicField
        name: "TradeSkillInputBoxDiabolicField"
        wowParent: "TradeSkillInputBox"
        anchors.left: tradeSkillInputBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: tradeSkillInputBox.verticalCenter
        width: 42
        height: 22
    }

    Frame {
        id: tradeSkillInvSlotDropDown
        name: "TradeSkillInvSlotDropDown"
        wowParent: "TradeSkillFrame"
        style: "DropDown"
        pin: "place"
        anchors.right: tradeSkillFrame.right
        anchors.rightMargin: 21
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 48
        width: 170
        height: 32
    }

    Button {
        id: tradeSkillInvSlotDropDownButton
        name: "TradeSkillInvSlotDropDownButton"
        wowParent: "TradeSkillInvSlotDropDown"
        anchors.right: tradeSkillInvSlotDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: tradeSkillInvSlotDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: tradeSkillInvSlotDropDownDiabolicField
        name: "TradeSkillInvSlotDropDownDiabolicField"
        wowParent: "TradeSkillInvSlotDropDown"
        anchors.left: tradeSkillInvSlotDropDown.left
        anchors.verticalCenter: tradeSkillInvSlotDropDown.verticalCenter
        width: 170
        height: 22
    }

    FontString {
        id: tradeSkillInvSlotDropDownText
        name: "TradeSkillInvSlotDropDownText"
        text: "All Slots"
        wowParent: "TradeSkillInvSlotDropDown"
        anchors.left: tradeSkillInvSlotDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: tradeSkillInvSlotDropDownDiabolicField.verticalCenter
        width: 108
        height: 10
    }

    Button {
        id: tradeSkillLinkButton
        name: "TradeSkillLinkButton"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillFrameTitleText.right
        anchors.leftMargin: 5
        anchors.verticalCenter: tradeSkillFrameTitleText.verticalCenter
        width: 32
        height: 16
    }

    ScrollFrame {
        id: tradeSkillListScrollFrame
        name: "TradeSkillListScrollFrame"
        wowParent: "TradeSkillFrame"
        pin: "all"
        anchors.right: tradeSkillFrame.right
        anchors.rightMargin: 67
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 89
        width: 296
        height: 125
    }

    Frame {
        id: tradeSkillListScrollFrameDiabolicPanel
        name: "TradeSkillListScrollFrameDiabolicPanel"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: -6
        width: 360
        height: 137
    }

    Frame {
        id: tradeSkillListScrollFrameDiabolicParchment
        name: "TradeSkillListScrollFrameDiabolicParchment"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: -4
        width: 334
        height: 133
    }

    Slider {
        id: tradeSkillListScrollFrameScrollBar
        name: "TradeSkillListScrollFrameScrollBar"
        wowParent: "TradeSkillListScrollFrame"
        style: "ScrollBar"
        anchors.left: tradeSkillListScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 93
    }

    Frame {
        id: tradeSkillListScrollFrameScrollBarDiabolicTrack
        name: "TradeSkillListScrollFrameScrollBarDiabolicTrack"
        wowParent: "TradeSkillListScrollFrameScrollBar"
        anchors.horizontalCenter: tradeSkillListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: tradeSkillListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 127
    }

    Button {
        id: tradeSkillListScrollFrameScrollBarScrollDownButton
        name: "TradeSkillListScrollFrameScrollBarScrollDownButton"
        wowParent: "TradeSkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillListScrollFrameScrollBar.horizontalCenter
        anchors.top: tradeSkillListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: tradeSkillListScrollFrameScrollBarScrollUpButton
        name: "TradeSkillListScrollFrameScrollBarScrollUpButton"
        wowParent: "TradeSkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: tradeSkillListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: tradeSkillListScrollFrameScrollChildFrame
        name: "TradeSkillListScrollFrameScrollChildFrame"
        wowParent: "TradeSkillListScrollFrame"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: -144
        width: 300
        height: 272
    }

    // the skill's bar centred on our window (24 left of the frame, 14 right of it:
    // room for the scroll bars), its rank in it
    StatusBar {
        id: tradeSkillRankFrame
        name: "TradeSkillRankFrame"
        wowParent: "TradeSkillFrame"
        style: "Bar"
        pin: "place"
        anchors.horizontalCenter: tradeSkillFrame.left
        anchors.horizontalCenterOffset: 187
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 32
        width: 265
        height: 14
    }

    FontString {
        id: tradeSkillRankFrameSkillRank
        name: "TradeSkillRankFrameSkillRank"
        text: "450/450"
        wowParent: "TradeSkillRankFrame"
        pin: "place"
        anchors.horizontalCenter: tradeSkillRankFrame.horizontalCenter
        anchors.verticalCenter: tradeSkillRankFrame.verticalCenter
        width: 48.2
        height: 9
    }

    Button {
        id: tradeSkillReagent1
        name: "TradeSkillReagent1"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagentLabel.left
        anchors.leftMargin: -2
        anchors.top: tradeSkillReagentLabel.bottom
        anchors.topMargin: 7
        width: 147
        height: 41
    }

    FontString {
        id: tradeSkillReagent1Count
        name: "TradeSkillReagent1Count"
        text: "0 /2"
        wowParent: "TradeSkillReagent1"
        anchors.right: tradeSkillReagent1IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent1IconTexture.bottom
        anchors.bottomMargin: 1
        width: 25.3
        height: 14.2
    }

    FontString {
        id: tradeSkillReagent1Name
        name: "TradeSkillReagent1Name"
        text: "Frostweave Cloth"
        wowParent: "TradeSkillReagent1"
        anchors.left: tradeSkillReagent1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent1NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Button {
        id: tradeSkillReagent2
        name: "TradeSkillReagent2"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillReagent1.right
        anchors.verticalCenter: tradeSkillReagent1.verticalCenter
        width: 147
        height: 41
    }

    FontString {
        id: tradeSkillReagent2Count
        name: "TradeSkillReagent2Count"
        text: "0 /6"
        wowParent: "TradeSkillReagent2"
        anchors.right: tradeSkillReagent2IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent2IconTexture.bottom
        anchors.bottomMargin: 1
        width: 25.3
        height: 14.2
    }

    FontString {
        id: tradeSkillReagent2Name
        name: "TradeSkillReagent2Name"
        text: "Dream Shard"
        wowParent: "TradeSkillReagent2"
        anchors.left: tradeSkillReagent2NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent2NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Button {
        id: tradeSkillReagent3
        name: "TradeSkillReagent3"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent1.left
        anchors.top: tradeSkillReagent1.bottom
        anchors.topMargin: 6
        width: 147
        height: 41
    }

    FontString {
        id: tradeSkillReagent3Count
        name: "TradeSkillReagent3Count"
        text: "0 /6"
        wowParent: "TradeSkillReagent3"
        anchors.right: tradeSkillReagent3IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent3IconTexture.bottom
        anchors.bottomMargin: 1
        width: 25.3
        height: 14.2
    }

    FontString {
        id: tradeSkillReagent3Name
        name: "TradeSkillReagent3Name"
        text: "Abyss Crystal"
        wowParent: "TradeSkillReagent3"
        anchors.left: tradeSkillReagent3NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent3NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Button {
        id: tradeSkillReagent4
        name: "TradeSkillReagent4"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillReagent3.right
        anchors.verticalCenter: tradeSkillReagent3.verticalCenter
        width: 147
        height: 41
    }

    FontString {
        id: tradeSkillReagent4Count
        name: "TradeSkillReagent4Count"
        text: "0 /1"
        wowParent: "TradeSkillReagent4"
        anchors.right: tradeSkillReagent4IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent4IconTexture.bottom
        anchors.bottomMargin: 1
        width: 23.7
        height: 14.2
    }

    FontString {
        id: tradeSkillReagent4Name
        name: "TradeSkillReagent4Name"
        text: "Northern Spices"
        wowParent: "TradeSkillReagent4"
        anchors.left: tradeSkillReagent4NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent4NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Button {
        id: tradeSkillReagent5
        name: "TradeSkillReagent5"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent3.left
        anchors.top: tradeSkillReagent3.bottom
        anchors.topMargin: 6
        width: 147
        height: 41
    }

    Button {
        id: tradeSkillReagent6
        name: "TradeSkillReagent6"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent5.right
        anchors.verticalCenter: tradeSkillReagent5.verticalCenter
        width: 147
        height: 41
    }

    Button {
        id: tradeSkillReagent7
        name: "TradeSkillReagent7"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent6.left
        anchors.top: tradeSkillReagent6.bottom
        anchors.topMargin: 6
        width: 147
        height: 41
    }

    FontString {
        id: tradeSkillReagentLabel
        name: "TradeSkillReagentLabel"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDescription.left
        anchors.top: tradeSkillDescription.top
        width: 56.1
        height: 10.3
    }

    FontString {
        id: tradeSkillRequirementLabel
        name: "TradeSkillRequirementLabel"
        text: "Requires:"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillSkillName.left
        anchors.top: tradeSkillSkillName.bottom
        width: 49.8
        height: 10.3
    }

    FontString {
        id: tradeSkillRequirementText
        name: "TradeSkillRequirementText"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillRequirementLabel.right
        anchors.leftMargin: 4
        anchors.top: tradeSkillRequirementLabel.top
        width: 87.2
        height: 1
    }

    Button {
        id: tradeSkillSkill1
        name: "TradeSkillSkill1"
        text: " Heavy Silk Bandage"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: 22
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 89
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill1Count
        name: "TradeSkillSkill1Count"
        wowParent: "TradeSkillSkill1"
        anchors.left: tradeSkillSkill1Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill1Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill1SubText
        name: "TradeSkillSkill1SubText"
        wowParent: "TradeSkillSkill1"
        anchors.left: tradeSkillSkill1.left
        anchors.verticalCenter: tradeSkillSkill1.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill1Text
        name: "TradeSkillSkill1Text"
        text: " Heavy Silk Bandage"
        wowParent: "TradeSkillSkill1"
        anchors.left: tradeSkillSkill1Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill1Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill2
        name: "TradeSkillSkill2"
        text: " Silk Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill1.left
        anchors.top: tradeSkillSkill1.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill2Count
        name: "TradeSkillSkill2Count"
        wowParent: "TradeSkillSkill2"
        anchors.left: tradeSkillSkill2Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill2Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill2SubText
        name: "TradeSkillSkill2SubText"
        wowParent: "TradeSkillSkill2"
        anchors.left: tradeSkillSkill2.left
        anchors.verticalCenter: tradeSkillSkill2.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill2Text
        name: "TradeSkillSkill2Text"
        text: " Silk Bandage"
        wowParent: "TradeSkillSkill2"
        anchors.left: tradeSkillSkill2Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill2Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill3
        name: "TradeSkillSkill3"
        text: " Heavy Wool Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill2.left
        anchors.top: tradeSkillSkill2.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill3Count
        name: "TradeSkillSkill3Count"
        wowParent: "TradeSkillSkill3"
        anchors.left: tradeSkillSkill3Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill3Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill3SubText
        name: "TradeSkillSkill3SubText"
        wowParent: "TradeSkillSkill3"
        anchors.left: tradeSkillSkill3.left
        anchors.verticalCenter: tradeSkillSkill3.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill3Text
        name: "TradeSkillSkill3Text"
        text: " Heavy Wool Bandage"
        wowParent: "TradeSkillSkill3"
        anchors.left: tradeSkillSkill3Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill3Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill4
        name: "TradeSkillSkill4"
        text: " Wool Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill3.left
        anchors.top: tradeSkillSkill3.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill4Count
        name: "TradeSkillSkill4Count"
        wowParent: "TradeSkillSkill4"
        anchors.left: tradeSkillSkill4Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill4Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill4SubText
        name: "TradeSkillSkill4SubText"
        wowParent: "TradeSkillSkill4"
        anchors.left: tradeSkillSkill4.left
        anchors.verticalCenter: tradeSkillSkill4.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill4Text
        name: "TradeSkillSkill4Text"
        text: " Wool Bandage"
        wowParent: "TradeSkillSkill4"
        anchors.left: tradeSkillSkill4Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill4Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill5
        name: "TradeSkillSkill5"
        text: " Heavy Linen Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill4.left
        anchors.top: tradeSkillSkill4.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill5Count
        name: "TradeSkillSkill5Count"
        wowParent: "TradeSkillSkill5"
        anchors.left: tradeSkillSkill5Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill5Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill5SubText
        name: "TradeSkillSkill5SubText"
        wowParent: "TradeSkillSkill5"
        anchors.left: tradeSkillSkill5.left
        anchors.verticalCenter: tradeSkillSkill5.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill5Text
        name: "TradeSkillSkill5Text"
        text: " Heavy Linen Bandage"
        wowParent: "TradeSkillSkill5"
        anchors.left: tradeSkillSkill5Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill5Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill6
        name: "TradeSkillSkill6"
        text: " Linen Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill5.left
        anchors.top: tradeSkillSkill5.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill6Count
        name: "TradeSkillSkill6Count"
        wowParent: "TradeSkillSkill6"
        anchors.left: tradeSkillSkill6Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill6Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill6SubText
        name: "TradeSkillSkill6SubText"
        wowParent: "TradeSkillSkill6"
        anchors.left: tradeSkillSkill6.left
        anchors.verticalCenter: tradeSkillSkill6.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill6Text
        name: "TradeSkillSkill6Text"
        text: " Linen Bandage"
        wowParent: "TradeSkillSkill6"
        anchors.left: tradeSkillSkill6Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill6Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill7
        name: "TradeSkillSkill7"
        text: "Other"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill6.left
        anchors.top: tradeSkillSkill6.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill7Count
        name: "TradeSkillSkill7Count"
        wowParent: "TradeSkillSkill7"
        anchors.left: tradeSkillSkill7Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill7Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill7SubText
        name: "TradeSkillSkill7SubText"
        wowParent: "TradeSkillSkill7"
        anchors.left: tradeSkillSkill7.left
        anchors.verticalCenter: tradeSkillSkill7.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill7Text
        name: "TradeSkillSkill7Text"
        text: "Other"
        wowParent: "TradeSkillSkill7"
        anchors.left: tradeSkillSkill7Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill7Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Button {
        id: tradeSkillSkill8
        name: "TradeSkillSkill8"
        text: " Anti-Venom"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill7.left
        anchors.top: tradeSkillSkill7.bottom
        width: 293
        height: 16
    }

    FontString {
        id: tradeSkillSkill8Count
        name: "TradeSkillSkill8Count"
        wowParent: "TradeSkillSkill8"
        anchors.left: tradeSkillSkill8Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill8Text.verticalCenter
        width: 1
        height: 13
    }

    FontString {
        id: tradeSkillSkill8SubText
        name: "TradeSkillSkill8SubText"
        wowParent: "TradeSkillSkill8"
        anchors.left: tradeSkillSkill8.left
        anchors.verticalCenter: tradeSkillSkill8.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkill8Text
        name: "TradeSkillSkill8Text"
        text: " Anti-Venom"
        wowParent: "TradeSkillSkill8"
        anchors.left: tradeSkillSkill8Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill8Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    FontString {
        id: tradeSkillSkillCooldown
        name: "TradeSkillSkillCooldown"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillRequirementLabel.left
        anchors.top: tradeSkillRequirementLabel.bottom
        width: 1
        height: 1
    }

    Button {
        id: tradeSkillSkillIcon
        name: "TradeSkillSkillIcon"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDetailScrollChildFrame.left
        anchors.leftMargin: 8
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    FontString {
        id: tradeSkillSkillIconCount
        name: "TradeSkillSkillIconCount"
        wowParent: "TradeSkillSkillIcon"
        anchors.right: tradeSkillSkillIcon.right
        anchors.rightMargin: 5
        anchors.bottom: tradeSkillSkillIcon.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    FontString {
        id: tradeSkillSkillName
        name: "TradeSkillSkillName"
        text: "Heavy Frostweave Bandage"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDetailScrollChildFrame.left
        anchors.leftMargin: 50
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 5
        width: 146
        height: 23.7
    }

    Frame {
        id: tradeSkillSubClassDropDown
        name: "TradeSkillSubClassDropDown"
        wowParent: "TradeSkillFrame"
        style: "DropDown"
        pin: "place"
        anchors.right: tradeSkillInvSlotDropDown.left
        anchors.rightMargin: -27
        anchors.verticalCenter: tradeSkillInvSlotDropDown.verticalCenter
        width: 170
        height: 32
    }

    Button {
        id: tradeSkillSubClassDropDownButton
        name: "TradeSkillSubClassDropDownButton"
        wowParent: "TradeSkillSubClassDropDown"
        anchors.right: tradeSkillSubClassDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: tradeSkillSubClassDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: tradeSkillSubClassDropDownDiabolicField
        name: "TradeSkillSubClassDropDownDiabolicField"
        wowParent: "TradeSkillSubClassDropDown"
        anchors.left: tradeSkillSubClassDropDown.left
        anchors.verticalCenter: tradeSkillSubClassDropDown.verticalCenter
        width: 170
        height: 22
    }

    FontString {
        id: tradeSkillSubClassDropDownText
        name: "TradeSkillSubClassDropDownText"
        text: "All Subclasses"
        wowParent: "TradeSkillSubClassDropDown"
        anchors.left: tradeSkillSubClassDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: tradeSkillSubClassDropDownDiabolicField.verticalCenter
        width: 108
        height: 10
    }

    WowRow {
        name: "TradeSkillButtons"
        parts: ["TradeSkillCreateButton", "TradeSkillCancelButton"]
        fit: "equal"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.leftMargin: 208
        anchors.right: tradeSkillFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: tradeSkillFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    Ghost { id: tradeSkillCollapseAllButtonHighlight; name: "TradeSkillCollapseAllButtonHighlight"; x: 42; y: 66; width: 0; height: 0 }
    Ghost { id: tradeSkillExpandTabLeft; name: "TradeSkillExpandTabLeft"; x: 23; y: 69; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent1IconTexture; name: "TradeSkillReagent1IconTexture"; x: 62; y: 361.2; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent1NameFrame; name: "TradeSkillReagent1NameFrame"; x: 52; y: 341.7; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent2IconTexture; name: "TradeSkillReagent2IconTexture"; x: 209; y: 385.8; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent2NameFrame; name: "TradeSkillReagent2NameFrame"; x: 199; y: 366.3; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent3IconTexture; name: "TradeSkillReagent3IconTexture"; x: 62; y: 432.8; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent3NameFrame; name: "TradeSkillReagent3NameFrame"; x: 52; y: 413.3; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent4IconTexture; name: "TradeSkillReagent4IconTexture"; x: 209; y: 354.8; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent4NameFrame; name: "TradeSkillReagent4NameFrame"; x: 199; y: 335.3; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill1Highlight; name: "TradeSkillSkill1Highlight"; x: 41; y: 97; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill2Highlight; name: "TradeSkillSkill2Highlight"; x: 41; y: 113; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill3Highlight; name: "TradeSkillSkill3Highlight"; x: 41; y: 129; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill4Highlight; name: "TradeSkillSkill4Highlight"; x: 41; y: 145; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill5Highlight; name: "TradeSkillSkill5Highlight"; x: 41; y: 161; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill6Highlight; name: "TradeSkillSkill6Highlight"; x: 41; y: 177; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill7Highlight; name: "TradeSkillSkill7Highlight"; x: 41; y: 193; width: 0; height: 0 }
    Ghost { id: tradeSkillSkill8Highlight; name: "TradeSkillSkill8Highlight"; x: 41; y: 209; width: 0; height: 0 }
}
