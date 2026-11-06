// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: tradeSkillFrame
    name: "TradeSkillFrame"
    width: 384
    height: 512

    Part {
        id: auctionator_Search
        name: "Auctionator_Search"
        kind: "Button"
        text: "Scan AH"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.right: tradeSkillDetailScrollChildFrame.right
        anchors.rightMargin: 4
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 4
        width: 96
        height: 32
    }

    Part {
        id: auctionator_SearchText
        name: "Auctionator_SearchText"
        kind: "FontString"
        text: "Scan AH"
        wowParent: "Auctionator_Search"
        anchors.horizontalCenter: auctionator_Search.horizontalCenter
        anchors.verticalCenter: auctionator_Search.verticalCenter
        width: 43.5
        height: 10.3
    }

    Part {
        id: tradeSkillCancelButton
        name: "TradeSkillCancelButton"
        kind: "Button"
        text: "Exit"
        wowParent: "TradeSkillFrame"
        style: "Button"
        anchors.right: tradeSkillFrame.right
        anchors.rightMargin: 39
        anchors.bottom: tradeSkillFrame.bottom
        anchors.bottomMargin: 73
        width: 77.5
        height: 22
    }

    Part {
        id: tradeSkillCancelButtonText
        name: "TradeSkillCancelButtonText"
        kind: "FontString"
        text: "Exit"
        wowParent: "TradeSkillCancelButton"
        anchors.horizontalCenter: tradeSkillCancelButton.horizontalCenter
        anchors.verticalCenter: tradeSkillCancelButton.verticalCenter
        width: 21.3
        height: 10.3
    }

    Part {
        id: tradeSkillCollapseAllButton
        name: "TradeSkillCollapseAllButton"
        kind: "Button"
        text: "All"
        wowParent: "TradeSkillExpandButtonFrame"
        anchors.left: tradeSkillExpandTabLeft.right
        anchors.verticalCenter: tradeSkillExpandTabLeft.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 22
    }

    Part {
        id: tradeSkillCollapseAllButtonSubText
        name: "TradeSkillCollapseAllButtonSubText"
        kind: "FontString"
        wowParent: "TradeSkillCollapseAllButton"
        anchors.left: tradeSkillCollapseAllButton.left
        anchors.verticalCenter: tradeSkillCollapseAllButton.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillCollapseAllButtonText
        name: "TradeSkillCollapseAllButtonText"
        kind: "FontString"
        text: "All"
        wowParent: "TradeSkillCollapseAllButton"
        anchors.left: tradeSkillCollapseAllButtonHighlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillCollapseAllButtonHighlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: tradeSkillCreateAllButton
        name: "TradeSkillCreateAllButton"
        kind: "Button"
        text: "Create All"
        wowParent: "TradeSkillFrame"
        style: "Button"
        anchors.right: tradeSkillCreateButton.left
        anchors.rightMargin: 86
        anchors.verticalCenter: tradeSkillCreateButton.verticalCenter
        width: 80
        height: 22
    }

    Part {
        id: tradeSkillCreateAllButtonText
        name: "TradeSkillCreateAllButtonText"
        kind: "FontString"
        text: "Create All"
        wowParent: "TradeSkillCreateAllButton"
        anchors.horizontalCenter: tradeSkillCreateAllButton.horizontalCenter
        anchors.verticalCenter: tradeSkillCreateAllButton.verticalCenter
        width: 52.1
        height: 10.3
    }

    Part {
        id: tradeSkillCreateButton
        name: "TradeSkillCreateButton"
        kind: "Button"
        text: "Create"
        wowParent: "TradeSkillFrame"
        style: "Button"
        anchors.right: tradeSkillFrame.right
        anchors.rightMargin: 122.5
        anchors.bottom: tradeSkillFrame.bottom
        anchors.bottomMargin: 73
        width: 77.5
        height: 22
    }

    Part {
        id: tradeSkillCreateButtonText
        name: "TradeSkillCreateButtonText"
        kind: "FontString"
        text: "Create"
        wowParent: "TradeSkillCreateButton"
        anchors.horizontalCenter: tradeSkillCreateButton.horizontalCenter
        anchors.verticalCenter: tradeSkillCreateButton.verticalCenter
        width: 36.3
        height: 10.3
    }

    Part {
        id: tradeSkillDecrementButton
        name: "TradeSkillDecrementButton"
        kind: "Button"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillCreateAllButton.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillCreateAllButton.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: tradeSkillDescription
        name: "TradeSkillDescription"
        kind: "FontString"
        text: " "
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 50
        width: 290
        height: 10.3
    }

    Part {
        id: tradeSkillDetailScrollChildFrame
        name: "TradeSkillDetailScrollChildFrame"
        kind: "Frame"
        wowParent: "TradeSkillDetailScrollFrame"
        anchors.left: tradeSkillDetailScrollFrame.left
        anchors.top: tradeSkillDetailScrollFrame.top
        width: 297
        height: 150
    }

    Part {
        id: tradeSkillDetailScrollFrame
        name: "TradeSkillDetailScrollFrame"
        kind: "ScrollFrame"
        wowParent: "TradeSkillFrame"
        pin: "all"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: 20
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 255
        width: 297
        height: 132
    }

    Part {
        id: tradeSkillDetailScrollFrameDiabolicPanel
        name: "TradeSkillDetailScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillDetailScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: tradeSkillDetailScrollFrame.top
        anchors.topMargin: -12
        width: 361
        height: 150
    }

    Part {
        id: tradeSkillDetailScrollFrameDiabolicParchment
        name: "TradeSkillDetailScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        anchors.horizontalCenter: tradeSkillDetailScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 5.5
        anchors.top: tradeSkillDetailScrollFrame.top
        anchors.topMargin: -10
        width: 334
        height: 146
    }

    Part {
        id: tradeSkillDetailScrollFrameScrollBar
        name: "TradeSkillDetailScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "TradeSkillDetailScrollFrame"
        style: "ScrollBar"
        anchors.left: tradeSkillDetailScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: tradeSkillDetailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 100
    }

    Part {
        id: tradeSkillDetailScrollFrameScrollBarDiabolicTrack
        name: "TradeSkillDetailScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "TradeSkillDetailScrollFrameScrollBar"
        anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: tradeSkillDetailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 134
    }

    Part {
        id: tradeSkillDetailScrollFrameScrollBarScrollDownButton
        name: "TradeSkillDetailScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBar.horizontalCenter
        anchors.top: tradeSkillDetailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: tradeSkillDetailScrollFrameScrollBarScrollUpButton
        name: "TradeSkillDetailScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: tradeSkillDetailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: tradeSkillExpandButtonFrame
        name: "TradeSkillExpandButtonFrame"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: 15
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 53
        width: 54
        height: 32
    }

    Part {
        id: tradeSkillFrameAvailableFilterCheckButton
        name: "TradeSkillFrameAvailableFilterCheckButton"
        kind: "CheckButton"
        wowParent: "TradeSkillFrame"
        style: "CheckBox"
        pin: "place"
        anchors.left: tradeSkillFrameEditBox.right
        anchors.leftMargin: 12
        anchors.verticalCenter: tradeSkillFrameEditBox.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: tradeSkillFrameAvailableFilterCheckButtonText
        name: "TradeSkillFrameAvailableFilterCheckButtonText"
        kind: "FontString"
        text: "Have Materials"
        wowParent: "TradeSkillFrameAvailableFilterCheckButton"
        anchors.left: tradeSkillFrameAvailableFilterCheckButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: tradeSkillFrameAvailableFilterCheckButton.verticalCenter
        width: 86.1
        height: 14.2
    }

    Part {
        id: tradeSkillFrameCloseButton
        name: "TradeSkillFrameCloseButton"
        kind: "Button"
        wowParent: "TradeSkillFrame"
        style: "CloseButton"
        anchors.horizontalCenter: tradeSkillFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: tradeSkillFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: tradeSkillFrameDiabolic
        name: "TradeSkillFrameDiabolic"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: -24
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: -40
        width: 422
        height: 509
    }

    Part {
        id: tradeSkillFrameDiabolicBand
        name: "TradeSkillFrameDiabolicBand"
        kind: "Frame"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: tradeSkillFrameDiabolic.top
        anchors.topMargin: 24
        width: 374
        height: 40
    }

    Part {
        id: tradeSkillFrameDiabolicBorder
        name: "TradeSkillFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.top: tradeSkillFrameDiabolic.top
        width: 422
        height: 509
    }

    Part {
        id: tradeSkillFrameDiabolicFoot
        name: "TradeSkillFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.horizontalCenter: tradeSkillCreateAllButton.horizontalCenter
        anchors.horizontalCenterOffset: 129
        anchors.top: tradeSkillCreateAllButton.top
        anchors.topMargin: -6
        width: 376
        height: 35
    }

    Part {
        id: tradeSkillFrameDiabolicIronBar
        name: "TradeSkillFrameDiabolicIronBar"
        kind: "Frame"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.left: tradeSkillFrameDiabolic.left
        anchors.top: tradeSkillFrameDiabolic.top
        width: 422
        height: 509
    }

    Part {
        id: tradeSkillFrameDiabolicSocket
        name: "TradeSkillFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.right: tradeSkillFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: tradeSkillFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: tradeSkillFrameDiabolicTitlePlate
        name: "TradeSkillFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "TradeSkillFrameDiabolic"
        anchors.horizontalCenter: tradeSkillFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: tradeSkillFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: tradeSkillFrameDiabolicTitlePlateGem
        name: "TradeSkillFrameDiabolicTitlePlateGem"
        kind: "Button"
        wowParent: "TradeSkillFrameDiabolicTitlePlate"
        anchors.horizontalCenter: tradeSkillFrameDiabolicTitlePlate.left
        anchors.horizontalCenterOffset: 35
        anchors.verticalCenter: tradeSkillFrameDiabolicTitlePlate.verticalCenter
        width: 40
        height: 40
    }

    Part {
        id: tradeSkillFrameEditBox
        name: "TradeSkillFrameEditBox"
        kind: "EditBox"
        text: "Search"
        wowParent: "TradeSkillFrame"
        style: "EditBox"
        anchors.left: tradeSkillFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: tradeSkillFrameDiabolicBand.verticalCenter
        width: 128
        height: 20
    }

    Part {
        id: tradeSkillFrameEditBoxDiabolicField
        name: "TradeSkillFrameEditBoxDiabolicField"
        kind: "Frame"
        wowParent: "TradeSkillFrameEditBox"
        anchors.left: tradeSkillFrameEditBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: tradeSkillFrameEditBox.verticalCenter
        width: 144
        height: 22
    }

    Part {
        id: tradeSkillFrameTitleText
        name: "TradeSkillFrameTitleText"
        kind: "FontString"
        text: "First Aid"
        wowParent: "TradeSkillFrameDiabolicTitlePlate"
        anchors.horizontalCenter: tradeSkillFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: tradeSkillFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 79.8
        height: 14.2
    }

    Part {
        id: tradeSkillHighlightFrame
        name: "TradeSkillHighlightFrame"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill2.left
        anchors.top: tradeSkillSkill2.top
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillIncrementButton
        name: "TradeSkillIncrementButton"
        kind: "Button"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillInputBox.right
        anchors.leftMargin: 8
        anchors.verticalCenter: tradeSkillInputBox.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: tradeSkillInputBox
        name: "TradeSkillInputBox"
        kind: "EditBox"
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

    Part {
        id: tradeSkillInputBoxDiabolicField
        name: "TradeSkillInputBoxDiabolicField"
        kind: "Frame"
        wowParent: "TradeSkillInputBox"
        anchors.left: tradeSkillInputBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: tradeSkillInputBox.verticalCenter
        width: 42
        height: 22
    }

    Part {
        id: tradeSkillInvSlotDropDown
        name: "TradeSkillInvSlotDropDown"
        kind: "Frame"
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

    Part {
        id: tradeSkillInvSlotDropDownButton
        name: "TradeSkillInvSlotDropDownButton"
        kind: "Button"
        wowParent: "TradeSkillInvSlotDropDown"
        anchors.right: tradeSkillInvSlotDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: tradeSkillInvSlotDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: tradeSkillInvSlotDropDownDiabolicField
        name: "TradeSkillInvSlotDropDownDiabolicField"
        kind: "Frame"
        wowParent: "TradeSkillInvSlotDropDown"
        anchors.left: tradeSkillInvSlotDropDown.left
        anchors.verticalCenter: tradeSkillInvSlotDropDown.verticalCenter
        width: 170
        height: 22
    }

    Part {
        id: tradeSkillInvSlotDropDownText
        name: "TradeSkillInvSlotDropDownText"
        kind: "FontString"
        text: "All Slots"
        wowParent: "TradeSkillInvSlotDropDown"
        anchors.left: tradeSkillInvSlotDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: tradeSkillInvSlotDropDownDiabolicField.verticalCenter
        width: 108
        height: 10
    }

    Part {
        id: tradeSkillLinkButton
        name: "TradeSkillLinkButton"
        kind: "Button"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillFrameTitleText.right
        anchors.leftMargin: 5
        anchors.verticalCenter: tradeSkillFrameTitleText.verticalCenter
        width: 32
        height: 16
    }

    Part {
        id: tradeSkillListScrollFrame
        name: "TradeSkillListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "TradeSkillFrame"
        pin: "all"
        anchors.right: tradeSkillFrame.right
        anchors.rightMargin: 67
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 89
        width: 296
        height: 125
    }

    Part {
        id: tradeSkillListScrollFrameDiabolicPanel
        name: "TradeSkillListScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: -6
        width: 360
        height: 137
    }

    Part {
        id: tradeSkillListScrollFrameDiabolicParchment
        name: "TradeSkillListScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: -4
        width: 334
        height: 133
    }

    Part {
        id: tradeSkillListScrollFrameScrollBar
        name: "TradeSkillListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "TradeSkillListScrollFrame"
        style: "ScrollBar"
        anchors.left: tradeSkillListScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: tradeSkillListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 93
    }

    Part {
        id: tradeSkillListScrollFrameScrollBarDiabolicTrack
        name: "TradeSkillListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "TradeSkillListScrollFrameScrollBar"
        anchors.horizontalCenter: tradeSkillListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: tradeSkillListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 127
    }

    Part {
        id: tradeSkillListScrollFrameScrollBarScrollDownButton
        name: "TradeSkillListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "TradeSkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillListScrollFrameScrollBar.horizontalCenter
        anchors.top: tradeSkillListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: tradeSkillListScrollFrameScrollBarScrollUpButton
        name: "TradeSkillListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "TradeSkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: tradeSkillListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: tradeSkillListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: tradeSkillListScrollFrameScrollChildFrame
        name: "TradeSkillListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "TradeSkillListScrollFrame"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.top: tradeSkillListScrollFrame.top
        width: 300
        height: 272
    }

    // the skill's bar centred on our window (24 left of the frame, 14 right of it:
    // room for the scroll bars), its rank in it
    Part {
        id: tradeSkillRankFrame
        name: "TradeSkillRankFrame"
        kind: "StatusBar"
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

    Part {
        id: tradeSkillRankFrameSkillRank
        name: "TradeSkillRankFrameSkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "TradeSkillRankFrame"
        pin: "place"
        anchors.horizontalCenter: tradeSkillRankFrame.horizontalCenter
        anchors.verticalCenter: tradeSkillRankFrame.verticalCenter
        width: 48.2
        height: 9
    }

    Part {
        id: tradeSkillReagent1
        name: "TradeSkillReagent1"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagentLabel.left
        anchors.leftMargin: -2
        anchors.top: tradeSkillReagentLabel.bottom
        anchors.topMargin: 7
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagent1Count
        name: "TradeSkillReagent1Count"
        kind: "FontString"
        text: "0 /2"
        wowParent: "TradeSkillReagent1"
        anchors.right: tradeSkillReagent1IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent1IconTexture.bottom
        anchors.bottomMargin: 1
        width: 25.3
        height: 14.2
    }

    Part {
        id: tradeSkillReagent1Name
        name: "TradeSkillReagent1Name"
        kind: "FontString"
        text: "Frostweave Cloth"
        wowParent: "TradeSkillReagent1"
        anchors.left: tradeSkillReagent1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent1NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Part {
        id: tradeSkillReagent2
        name: "TradeSkillReagent2"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillReagent1.right
        anchors.verticalCenter: tradeSkillReagent1.verticalCenter
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagent2Count
        name: "TradeSkillReagent2Count"
        kind: "FontString"
        text: "0 /2"
        wowParent: "TradeSkillReagent2"
        anchors.right: tradeSkillReagent2IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent2IconTexture.bottom
        anchors.bottomMargin: 1
        width: 25.3
        height: 14.2
    }

    Part {
        id: tradeSkillReagent2Name
        name: "TradeSkillReagent2Name"
        kind: "FontString"
        text: "Glacial Salmon"
        wowParent: "TradeSkillReagent2"
        anchors.left: tradeSkillReagent2NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent2NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Part {
        id: tradeSkillReagent3
        name: "TradeSkillReagent3"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent1.left
        anchors.top: tradeSkillReagent1.bottom
        anchors.topMargin: 6
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagent3Count
        name: "TradeSkillReagent3Count"
        kind: "FontString"
        text: "0 /2"
        wowParent: "TradeSkillReagent3"
        anchors.right: tradeSkillReagent3IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent3IconTexture.bottom
        anchors.bottomMargin: 1
        width: 25.3
        height: 14.2
    }

    Part {
        id: tradeSkillReagent3Name
        name: "TradeSkillReagent3Name"
        kind: "FontString"
        text: "Nettlefish"
        wowParent: "TradeSkillReagent3"
        anchors.left: tradeSkillReagent3NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent3NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Part {
        id: tradeSkillReagent4
        name: "TradeSkillReagent4"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillReagent3.right
        anchors.verticalCenter: tradeSkillReagent3.verticalCenter
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagent4Count
        name: "TradeSkillReagent4Count"
        kind: "FontString"
        text: "0 /1"
        wowParent: "TradeSkillReagent4"
        anchors.right: tradeSkillReagent4IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: tradeSkillReagent4IconTexture.bottom
        anchors.bottomMargin: 1
        width: 23.7
        height: 14.2
    }

    Part {
        id: tradeSkillReagent4Name
        name: "TradeSkillReagent4Name"
        kind: "FontString"
        text: "Northern Spices"
        wowParent: "TradeSkillReagent4"
        anchors.left: tradeSkillReagent4NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeSkillReagent4NameFrame.verticalCenter
        width: 100
        height: 36
    }

    Part {
        id: tradeSkillReagent5
        name: "TradeSkillReagent5"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent3.left
        anchors.top: tradeSkillReagent3.bottom
        anchors.topMargin: 6
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagent6
        name: "TradeSkillReagent6"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent5.right
        anchors.verticalCenter: tradeSkillReagent5.verticalCenter
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagent7
        name: "TradeSkillReagent7"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        pin: "place"
        anchors.left: tradeSkillReagent6.left
        anchors.top: tradeSkillReagent6.bottom
        anchors.topMargin: 6
        width: 147
        height: 41
    }

    Part {
        id: tradeSkillReagentLabel
        name: "TradeSkillReagentLabel"
        kind: "FontString"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDescription.left
        anchors.top: tradeSkillDescription.top
        width: 56.1
        height: 10.3
    }

    Part {
        id: tradeSkillRequirementLabel
        name: "TradeSkillRequirementLabel"
        kind: "FontString"
        text: "Requires:"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillSkillName.left
        anchors.top: tradeSkillSkillName.bottom
        width: 49.8
        height: 10.3
    }

    Part {
        id: tradeSkillRequirementText
        name: "TradeSkillRequirementText"
        kind: "FontString"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillRequirementLabel.right
        anchors.leftMargin: 4
        anchors.top: tradeSkillRequirementLabel.top
        width: 180
        height: 1
    }

    Part {
        id: tradeSkillSkill1
        name: "TradeSkillSkill1"
        kind: "Button"
        text: "Bandage"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: tradeSkillFrame.left
        anchors.leftMargin: 22
        anchors.top: tradeSkillFrame.top
        anchors.topMargin: 89
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill1Count
        name: "TradeSkillSkill1Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill1"
        anchors.left: tradeSkillSkill1Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill1Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill1SubText
        name: "TradeSkillSkill1SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill1"
        anchors.left: tradeSkillSkill1.left
        anchors.verticalCenter: tradeSkillSkill1.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill1Text
        name: "TradeSkillSkill1Text"
        kind: "FontString"
        text: "Bandage"
        wowParent: "TradeSkillSkill1"
        anchors.left: tradeSkillSkill1Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill1Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill2
        name: "TradeSkillSkill2"
        kind: "Button"
        text: " Heavy Frostweave Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill1.left
        anchors.top: tradeSkillSkill1.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill2Count
        name: "TradeSkillSkill2Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill2"
        anchors.left: tradeSkillSkill2Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill2Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill2SubText
        name: "TradeSkillSkill2SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill2"
        anchors.left: tradeSkillSkill2.left
        anchors.verticalCenter: tradeSkillSkill2.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill2Text
        name: "TradeSkillSkill2Text"
        kind: "FontString"
        text: " Heavy Frostweave Bandage"
        wowParent: "TradeSkillSkill2"
        anchors.left: tradeSkillSkill2Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill2Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill3
        name: "TradeSkillSkill3"
        kind: "Button"
        text: " Frostweave Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill2.left
        anchors.top: tradeSkillSkill2.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill3Count
        name: "TradeSkillSkill3Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill3"
        anchors.left: tradeSkillSkill3Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill3Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill3SubText
        name: "TradeSkillSkill3SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill3"
        anchors.left: tradeSkillSkill3.left
        anchors.verticalCenter: tradeSkillSkill3.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill3Text
        name: "TradeSkillSkill3Text"
        kind: "FontString"
        text: " Frostweave Bandage"
        wowParent: "TradeSkillSkill3"
        anchors.left: tradeSkillSkill3Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill3Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill4
        name: "TradeSkillSkill4"
        kind: "Button"
        text: " Heavy Netherweave Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill3.left
        anchors.top: tradeSkillSkill3.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill4Count
        name: "TradeSkillSkill4Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill4"
        anchors.left: tradeSkillSkill4Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill4Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill4SubText
        name: "TradeSkillSkill4SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill4"
        anchors.left: tradeSkillSkill4.left
        anchors.verticalCenter: tradeSkillSkill4.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill4Text
        name: "TradeSkillSkill4Text"
        kind: "FontString"
        text: " Heavy Netherweave Bandage"
        wowParent: "TradeSkillSkill4"
        anchors.left: tradeSkillSkill4Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill4Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill5
        name: "TradeSkillSkill5"
        kind: "Button"
        text: " Netherweave Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill4.left
        anchors.top: tradeSkillSkill4.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill5Count
        name: "TradeSkillSkill5Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill5"
        anchors.left: tradeSkillSkill5Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill5Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill5SubText
        name: "TradeSkillSkill5SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill5"
        anchors.left: tradeSkillSkill5.left
        anchors.verticalCenter: tradeSkillSkill5.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill5Text
        name: "TradeSkillSkill5Text"
        kind: "FontString"
        text: " Netherweave Bandage"
        wowParent: "TradeSkillSkill5"
        anchors.left: tradeSkillSkill5Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill5Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill6
        name: "TradeSkillSkill6"
        kind: "Button"
        text: " Heavy Runecloth Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill5.left
        anchors.top: tradeSkillSkill5.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill6Count
        name: "TradeSkillSkill6Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill6"
        anchors.left: tradeSkillSkill6Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill6Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill6SubText
        name: "TradeSkillSkill6SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill6"
        anchors.left: tradeSkillSkill6.left
        anchors.verticalCenter: tradeSkillSkill6.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill6Text
        name: "TradeSkillSkill6Text"
        kind: "FontString"
        text: " Heavy Runecloth Bandage"
        wowParent: "TradeSkillSkill6"
        anchors.left: tradeSkillSkill6Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill6Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill7
        name: "TradeSkillSkill7"
        kind: "Button"
        text: " Runecloth Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill6.left
        anchors.top: tradeSkillSkill6.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill7Count
        name: "TradeSkillSkill7Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill7"
        anchors.left: tradeSkillSkill7Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill7Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill7SubText
        name: "TradeSkillSkill7SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill7"
        anchors.left: tradeSkillSkill7.left
        anchors.verticalCenter: tradeSkillSkill7.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill7Text
        name: "TradeSkillSkill7Text"
        kind: "FontString"
        text: " Runecloth Bandage"
        wowParent: "TradeSkillSkill7"
        anchors.left: tradeSkillSkill7Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill7Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkill8
        name: "TradeSkillSkill8"
        kind: "Button"
        text: " Heavy Mageweave Bandage"
        wowParent: "TradeSkillFrame"
        anchors.left: tradeSkillSkill7.left
        anchors.top: tradeSkillSkill7.bottom
        width: 293
        height: 16
    }

    Part {
        id: tradeSkillSkill8Count
        name: "TradeSkillSkill8Count"
        kind: "FontString"
        wowParent: "TradeSkillSkill8"
        anchors.left: tradeSkillSkill8Text.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill8Text.verticalCenter
        width: 1
        height: 13
    }

    Part {
        id: tradeSkillSkill8SubText
        name: "TradeSkillSkill8SubText"
        kind: "FontString"
        wowParent: "TradeSkillSkill8"
        anchors.left: tradeSkillSkill8.left
        anchors.verticalCenter: tradeSkillSkill8.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkill8Text
        name: "TradeSkillSkill8Text"
        kind: "FontString"
        text: " Heavy Mageweave Bandage"
        wowParent: "TradeSkillSkill8"
        anchors.left: tradeSkillSkill8Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: tradeSkillSkill8Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 275
        height: 13
    }

    Part {
        id: tradeSkillSkillCooldown
        name: "TradeSkillSkillCooldown"
        kind: "FontString"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillRequirementLabel.left
        anchors.top: tradeSkillRequirementLabel.bottom
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkillIcon
        name: "TradeSkillSkillIcon"
        kind: "Button"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDetailScrollChildFrame.left
        anchors.leftMargin: 8
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: tradeSkillSkillIconCount
        name: "TradeSkillSkillIconCount"
        kind: "FontString"
        wowParent: "TradeSkillSkillIcon"
        anchors.right: tradeSkillSkillIcon.right
        anchors.rightMargin: 5
        anchors.bottom: tradeSkillSkillIcon.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Part {
        id: tradeSkillSkillName
        name: "TradeSkillSkillName"
        kind: "FontString"
        text: "Heavy Frostweave Bandage"
        wowParent: "TradeSkillDetailScrollChildFrame"
        anchors.left: tradeSkillDetailScrollChildFrame.left
        anchors.leftMargin: 50
        anchors.top: tradeSkillDetailScrollChildFrame.top
        anchors.topMargin: 5
        width: 244
        height: 11.9
    }

    Part {
        id: tradeSkillSubClassDropDown
        name: "TradeSkillSubClassDropDown"
        kind: "Frame"
        wowParent: "TradeSkillFrame"
        style: "DropDown"
        pin: "place"
        anchors.right: tradeSkillInvSlotDropDown.left
        anchors.rightMargin: -27
        anchors.verticalCenter: tradeSkillInvSlotDropDown.verticalCenter
        width: 170
        height: 32
    }

    Part {
        id: tradeSkillSubClassDropDownButton
        name: "TradeSkillSubClassDropDownButton"
        kind: "Button"
        wowParent: "TradeSkillSubClassDropDown"
        anchors.right: tradeSkillSubClassDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: tradeSkillSubClassDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: tradeSkillSubClassDropDownDiabolicField
        name: "TradeSkillSubClassDropDownDiabolicField"
        kind: "Frame"
        wowParent: "TradeSkillSubClassDropDown"
        anchors.left: tradeSkillSubClassDropDown.left
        anchors.verticalCenter: tradeSkillSubClassDropDown.verticalCenter
        width: 170
        height: 22
    }

    Part {
        id: tradeSkillSubClassDropDownText
        name: "TradeSkillSubClassDropDownText"
        kind: "FontString"
        text: "All Subclasses"
        wowParent: "TradeSkillSubClassDropDown"
        anchors.left: tradeSkillSubClassDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: tradeSkillSubClassDropDownDiabolicField.verticalCenter
        width: 108
        height: 10
    }

    Ghost { id: tradeSkillCollapseAllButtonHighlight; name: "TradeSkillCollapseAllButtonHighlight"; x: 42; y: 66; width: 0; height: 0 }
    Ghost { id: tradeSkillExpandTabLeft; name: "TradeSkillExpandTabLeft"; x: 23; y: 69; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent1IconTexture; name: "TradeSkillReagent1IconTexture"; x: 62; y: 361.2; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent1NameFrame; name: "TradeSkillReagent1NameFrame"; x: 52; y: 341.7; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent2IconTexture; name: "TradeSkillReagent2IconTexture"; x: 209; y: 307.8; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent2NameFrame; name: "TradeSkillReagent2NameFrame"; x: 199; y: 288.3; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent3IconTexture; name: "TradeSkillReagent3IconTexture"; x: 62; y: 354.8; width: 0; height: 0 }
    Ghost { id: tradeSkillReagent3NameFrame; name: "TradeSkillReagent3NameFrame"; x: 52; y: 335.3; width: 0; height: 0 }
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
