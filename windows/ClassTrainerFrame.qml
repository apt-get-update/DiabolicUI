// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: classTrainerFrame
    name: "ClassTrainerFrame"
    width: 384
    height: 512

    Part {
        id: classTrainerCancelButton
        name: "ClassTrainerCancelButton"
        kind: "Button"
        text: "Exit"
        wowParent: "ClassTrainerFrame"
        style: "Button"
        anchors.right: classTrainerFrame.right
        anchors.rightMargin: 39
        anchors.bottom: classTrainerFrame.bottom
        anchors.bottomMargin: 81
        width: 77.5
        height: 22
    }

    Part {
        id: classTrainerCancelButtonText
        name: "ClassTrainerCancelButtonText"
        kind: "FontString"
        text: "Exit"
        wowParent: "ClassTrainerCancelButton"
        anchors.horizontalCenter: classTrainerCancelButton.horizontalCenter
        anchors.verticalCenter: classTrainerCancelButton.verticalCenter
        width: 32.4
        height: 11.9
    }

    Part {
        id: classTrainerCollapseAllButton
        name: "ClassTrainerCollapseAllButton"
        kind: "Button"
        text: "All"
        wowParent: "ClassTrainerExpandButtonFrame"
        anchors.left: classTrainerExpandTabLeft.right
        anchors.verticalCenter: classTrainerExpandTabLeft.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 22
    }

    Part {
        id: classTrainerCollapseAllButtonSubText
        name: "ClassTrainerCollapseAllButtonSubText"
        kind: "FontString"
        wowParent: "ClassTrainerCollapseAllButton"
        anchors.left: classTrainerCollapseAllButton.left
        anchors.verticalCenter: classTrainerCollapseAllButton.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: classTrainerCollapseAllButtonText
        name: "ClassTrainerCollapseAllButtonText"
        kind: "FontString"
        text: "All"
        wowParent: "ClassTrainerCollapseAllButton"
        anchors.left: classTrainerCollapseAllButtonHighlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerCollapseAllButtonHighlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerCostLabel
        name: "ClassTrainerCostLabel"
        kind: "FontString"
        text: "Cost:"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: classTrainerDetailScrollChildFrame.top
        anchors.topMargin: 50
        width: 27.7
        height: 10.3
    }

    Part {
        id: classTrainerDetailMoneyFrame
        name: "ClassTrainerDetailMoneyFrame"
        kind: "Frame"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerCostLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: classTrainerCostLabel.verticalCenter
        width: 36.3
        height: 13
    }

    Part {
        id: classTrainerDetailMoneyFrameCopperButton
        name: "ClassTrainerDetailMoneyFrameCopperButton"
        kind: "Button"
        text: "8"
        wowParent: "ClassTrainerDetailMoneyFrame"
        anchors.right: classTrainerDetailMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrame.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: classTrainerDetailMoneyFrameCopperButtonText
        name: "ClassTrainerDetailMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "8"
        wowParent: "ClassTrainerDetailMoneyFrameCopperButton"
        anchors.right: classTrainerDetailMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: classTrainerDetailMoneyFrameGoldButton
        name: "ClassTrainerDetailMoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        wowParent: "ClassTrainerDetailMoneyFrame"
        anchors.right: classTrainerDetailMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerDetailMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: classTrainerDetailMoneyFrameGoldButtonText
        name: "ClassTrainerDetailMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "ClassTrainerDetailMoneyFrameGoldButton"
        anchors.right: classTrainerDetailMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Part {
        id: classTrainerDetailMoneyFrameSilverButton
        name: "ClassTrainerDetailMoneyFrameSilverButton"
        kind: "Button"
        text: "2"
        wowParent: "ClassTrainerDetailMoneyFrame"
        anchors.right: classTrainerDetailMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerDetailMoneyFrameCopperButton.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: classTrainerDetailMoneyFrameSilverButtonText
        name: "ClassTrainerDetailMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "2"
        wowParent: "ClassTrainerDetailMoneyFrameSilverButton"
        anchors.right: classTrainerDetailMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrameSilverButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: classTrainerDetailScrollChildFrame
        name: "ClassTrainerDetailScrollChildFrame"
        kind: "Frame"
        wowParent: "ClassTrainerDetailScrollFrame"
        anchors.left: classTrainerDetailScrollFrame.left
        anchors.top: classTrainerDetailScrollFrame.top
        width: 296
        height: 50
    }

    // the chosen one's page 6 under the list's (Blizzard's 8 under its text)
    Part {
        id: classTrainerDetailScrollFrame
        name: "ClassTrainerDetailScrollFrame"
        kind: "ScrollFrame"
        wowParent: "ClassTrainerFrame"
        pin: "place"
        anchors.left: classTrainerListScrollFrame.left
        anchors.top: classTrainerListScrollFrame.bottom
        anchors.topMargin: 14
        width: 296
        height: 95
    }

    Part {
        id: classTrainerDetailScrollFrameDiabolicPanel
        name: "ClassTrainerDetailScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerDetailScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: classTrainerDetailScrollFrame.top
        anchors.topMargin: -6
        width: 360
        height: 107
    }

    Part {
        id: classTrainerDetailScrollFrameDiabolicParchment
        name: "ClassTrainerDetailScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.horizontalCenter: classTrainerDetailScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 5
        anchors.top: classTrainerDetailScrollFrame.top
        anchors.topMargin: -4
        width: 334
        height: 103
    }

    Part {
        id: classTrainerDetailScrollFrameScrollBar
        name: "ClassTrainerDetailScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "ClassTrainerDetailScrollFrame"
        style: "ScrollBar"
        anchors.left: classTrainerDetailScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: classTrainerDetailScrollFrame.top
        anchors.topMargin: 32
        width: 16
        height: 47
    }

    Part {
        id: classTrainerDetailScrollFrameScrollBarDiabolicTrack
        name: "ClassTrainerDetailScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
        anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: classTrainerDetailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 81
    }

    Part {
        id: classTrainerDetailScrollFrameScrollBarScrollDownButton
        name: "ClassTrainerDetailScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBar.horizontalCenter
        anchors.top: classTrainerDetailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: classTrainerDetailScrollFrameScrollBarScrollUpButton
        name: "ClassTrainerDetailScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: classTrainerDetailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    // "All" and the list under the greeting (the chosen one's height: trainer.lua)
    Part {
        id: classTrainerExpandButtonFrame
        name: "ClassTrainerExpandButtonFrame"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        pin: "place"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: 15
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 66
        width: 54
        height: 32
    }

    Part {
        id: classTrainerFrameCloseButton
        name: "ClassTrainerFrameCloseButton"
        kind: "Button"
        wowParent: "ClassTrainerFrame"
        style: "CloseButton"
        anchors.horizontalCenter: classTrainerFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: classTrainerFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: classTrainerFrameDiabolic
        name: "ClassTrainerFrameDiabolic"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: -24
        anchors.top: classTrainerFrame.top
        anchors.topMargin: -40
        width: 418
        height: 513
    }

    Part {
        id: classTrainerFrameDiabolicBand
        name: "ClassTrainerFrameDiabolicBand"
        kind: "Frame"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.left: classTrainerFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: classTrainerFrameDiabolic.top
        anchors.topMargin: 24
        width: 370
        height: 40
    }

    Part {
        id: classTrainerFrameDiabolicBorder
        name: "ClassTrainerFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.left: classTrainerFrameDiabolic.left
        anchors.top: classTrainerFrameDiabolic.top
        width: 418
        height: 513
    }

    Part {
        id: classTrainerFrameDiabolicFoot
        name: "ClassTrainerFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.horizontalCenter: classTrainerTrainButton.horizontalCenter
        anchors.horizontalCenterOffset: -37.7
        anchors.top: classTrainerTrainButton.top
        anchors.topMargin: -6
        width: 372
        height: 47
    }

    Part {
        id: classTrainerFrameDiabolicSocket
        name: "ClassTrainerFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.right: classTrainerFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: classTrainerFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: classTrainerFrameDiabolicTitlePlate
        name: "ClassTrainerFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.horizontalCenter: classTrainerFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: classTrainerFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: classTrainerFrameFilterDropDown
        name: "ClassTrainerFrameFilterDropDown"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        style: "DropDown"
        anchors.left: classTrainerFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: classTrainerFrameDiabolicBand.verticalCenter
        width: 180
        height: 32
    }

    Part {
        id: classTrainerFrameFilterDropDownButton
        name: "ClassTrainerFrameFilterDropDownButton"
        kind: "Button"
        wowParent: "ClassTrainerFrameFilterDropDown"
        anchors.right: classTrainerFrameFilterDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: classTrainerFrameFilterDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: classTrainerFrameFilterDropDownDiabolicField
        name: "ClassTrainerFrameFilterDropDownDiabolicField"
        kind: "Frame"
        wowParent: "ClassTrainerFrameFilterDropDown"
        anchors.left: classTrainerFrameFilterDropDown.left
        anchors.verticalCenter: classTrainerFrameFilterDropDown.verticalCenter
        width: 180
        height: 22
    }

    Part {
        id: classTrainerFrameFilterDropDownText
        name: "ClassTrainerFrameFilterDropDownText"
        kind: "FontString"
        text: "Filter"
        wowParent: "ClassTrainerFrameFilterDropDown"
        anchors.left: classTrainerFrameFilterDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: classTrainerFrameFilterDropDownDiabolicField.verticalCenter
        width: 118
        height: 10
    }

    // the greeting across the list's width under the band, its panel's left on
    // the parchments', its right on their panels'
    Part {
        id: classTrainerGreetingText
        name: "ClassTrainerGreetingText"
        kind: "FontString"
        text: "Greetings!  Can I teach you how to turn found cloth into cloth armor?"
        wowParent: "ClassTrainerFrame"
        pin: "all"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: 11
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 34
        width: 350
        height: 24
    }

    Part {
        id: classTrainerGreetingTextDiabolicPanel
        name: "ClassTrainerGreetingTextDiabolicPanel"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerGreetingText.left
        anchors.leftMargin: -4
        anchors.top: classTrainerGreetingText.top
        anchors.topMargin: -4
        width: 358
        height: 32
    }

    Part {
        id: classTrainerListScrollFrame
        name: "ClassTrainerListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "ClassTrainerFrame"
        pin: "place"
        anchors.right: classTrainerFrame.right
        anchors.rightMargin: 67
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 102
        width: 296
        height: 168
    }

    Part {
        id: classTrainerListScrollFrameDiabolicPanel
        name: "ClassTrainerListScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerListScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: -6
        width: 360
        height: 180
    }

    Part {
        id: classTrainerListScrollFrameDiabolicParchment
        name: "ClassTrainerListScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerListScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: -4
        width: 334
        height: 176
    }

    Part {
        id: classTrainerListScrollFrameScrollBar
        name: "ClassTrainerListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "ClassTrainerListScrollFrame"
        style: "ScrollBar"
        anchors.left: classTrainerListScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 136
    }

    Part {
        id: classTrainerListScrollFrameScrollBarDiabolicTrack
        name: "ClassTrainerListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "ClassTrainerListScrollFrameScrollBar"
        anchors.horizontalCenter: classTrainerListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: classTrainerListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 170
    }

    Part {
        id: classTrainerListScrollFrameScrollBarScrollDownButton
        name: "ClassTrainerListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "ClassTrainerListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerListScrollFrameScrollBar.horizontalCenter
        anchors.top: classTrainerListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: classTrainerListScrollFrameScrollBarScrollUpButton
        name: "ClassTrainerListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "ClassTrainerListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: classTrainerListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: classTrainerListScrollFrameScrollChildFrame
        name: "ClassTrainerListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "ClassTrainerListScrollFrame"
        anchors.left: classTrainerListScrollFrame.left
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: -16
        width: 300
        height: 1680
    }

    Part {
        id: classTrainerMoneyFrame
        name: "ClassTrainerMoneyFrame"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.right: classTrainerFrame.left
        anchors.rightMargin: -180
        anchors.bottom: classTrainerFrame.bottom
        anchors.bottomMargin: 86
        width: 126.4
        height: 13
    }

    Part {
        id: classTrainerMoneyFrameCopperButton
        name: "ClassTrainerMoneyFrameCopperButton"
        kind: "Button"
        text: "13"
        wowParent: "ClassTrainerMoneyFrame"
        anchors.right: classTrainerMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: classTrainerMoneyFrameCopperButtonText
        name: "ClassTrainerMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "13"
        wowParent: "ClassTrainerMoneyFrameCopperButton"
        anchors.right: classTrainerMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: classTrainerMoneyFrameGoldButton
        name: "ClassTrainerMoneyFrameGoldButton"
        kind: "Button"
        text: "3654"
        wowParent: "ClassTrainerMoneyFrame"
        anchors.right: classTrainerMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    Part {
        id: classTrainerMoneyFrameGoldButtonText
        name: "ClassTrainerMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "3654"
        wowParent: "ClassTrainerMoneyFrameGoldButton"
        anchors.right: classTrainerMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Part {
        id: classTrainerMoneyFrameSilverButton
        name: "ClassTrainerMoneyFrameSilverButton"
        kind: "Button"
        text: "16"
        wowParent: "ClassTrainerMoneyFrame"
        anchors.right: classTrainerMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: classTrainerMoneyFrameSilverButtonText
        name: "ClassTrainerMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "16"
        wowParent: "ClassTrainerMoneyFrameSilverButton"
        anchors.right: classTrainerMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: classTrainerNameText
        name: "ClassTrainerNameText"
        kind: "FontString"
        text: "Georgio Bolero"
        wowParent: "ClassTrainerFrameDiabolicTitlePlate"
        anchors.horizontalCenter: classTrainerFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: classTrainerFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 140.6
        height: 14.2
    }

    Part {
        id: classTrainerSkill1
        name: "ClassTrainerSkill1"
        kind: "Button"
        text: "  Apprentice Tailor"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: 22
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 100
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill10
        name: "ClassTrainerSkill10"
        kind: "Button"
        text: "  Simple Linen Boots"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill9.left
        anchors.top: classTrainerSkill9.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill10SubText
        name: "ClassTrainerSkill10SubText"
        kind: "FontString"
        text: "(Rank 9)"
        wowParent: "ClassTrainerSkill10"
        anchors.right: classTrainerSkill10.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill10.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill10Text
        name: "ClassTrainerSkill10Text"
        kind: "FontString"
        text: "  Simple Linen Boots"
        wowParent: "ClassTrainerSkill10"
        anchors.left: classTrainerSkill10Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill10Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill11
        name: "ClassTrainerSkill11"
        kind: "Button"
        text: "  Shadowfiend"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill10.left
        anchors.top: classTrainerSkill10.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill11SubText
        name: "ClassTrainerSkill11SubText"
        kind: "FontString"
        text: "(Rank 4)"
        wowParent: "ClassTrainerSkill11"
        anchors.right: classTrainerSkill11.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill11.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill11Text
        name: "ClassTrainerSkill11Text"
        kind: "FontString"
        text: "  Shadowfiend"
        wowParent: "ClassTrainerSkill11"
        anchors.left: classTrainerSkill11Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill11Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill1SubText
        name: "ClassTrainerSkill1SubText"
        kind: "FontString"
        text: "(Rank 4)"
        wowParent: "ClassTrainerSkill1"
        anchors.right: classTrainerSkill1.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill1.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill1Text
        name: "ClassTrainerSkill1Text"
        kind: "FontString"
        text: "  Apprentice Tailor"
        wowParent: "ClassTrainerSkill1"
        anchors.left: classTrainerSkill1Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill1Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill2
        name: "ClassTrainerSkill2"
        kind: "Button"
        text: "  Journeyman Tailor"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill1.left
        anchors.top: classTrainerSkill1.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill2SubText
        name: "ClassTrainerSkill2SubText"
        kind: "FontString"
        text: "(Rank 3)"
        wowParent: "ClassTrainerSkill2"
        anchors.right: classTrainerSkill2.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill2.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill2Text
        name: "ClassTrainerSkill2Text"
        kind: "FontString"
        text: "  Journeyman Tailor"
        wowParent: "ClassTrainerSkill2"
        anchors.left: classTrainerSkill2Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill2Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill3
        name: "ClassTrainerSkill3"
        kind: "Button"
        text: "  Expert Tailor"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill2.left
        anchors.top: classTrainerSkill2.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill3SubText
        name: "ClassTrainerSkill3SubText"
        kind: "FontString"
        text: "(Rank 9)"
        wowParent: "ClassTrainerSkill3"
        anchors.right: classTrainerSkill3.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill3.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill3Text
        name: "ClassTrainerSkill3Text"
        kind: "FontString"
        text: "  Expert Tailor"
        wowParent: "ClassTrainerSkill3"
        anchors.left: classTrainerSkill3Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill3Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill4
        name: "ClassTrainerSkill4"
        kind: "Button"
        text: "  Artisan Tailor"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill3.left
        anchors.top: classTrainerSkill3.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill4SubText
        name: "ClassTrainerSkill4SubText"
        kind: "FontString"
        text: "(Rank 8)"
        wowParent: "ClassTrainerSkill4"
        anchors.right: classTrainerSkill4.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill4.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill4Text
        name: "ClassTrainerSkill4Text"
        kind: "FontString"
        text: "  Artisan Tailor"
        wowParent: "ClassTrainerSkill4"
        anchors.left: classTrainerSkill4Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill4Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill5
        name: "ClassTrainerSkill5"
        kind: "Button"
        text: "Recipes"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill4.left
        anchors.top: classTrainerSkill4.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill5SubText
        name: "ClassTrainerSkill5SubText"
        kind: "FontString"
        text: "(Rank 6)"
        wowParent: "ClassTrainerSkill5"
        anchors.right: classTrainerSkill5.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill5.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill5Text
        name: "ClassTrainerSkill5Text"
        kind: "FontString"
        text: "Recipes"
        wowParent: "ClassTrainerSkill5"
        anchors.left: classTrainerSkill5Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill5Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill6
        name: "ClassTrainerSkill6"
        kind: "Button"
        text: "  Brown Linen Shirt"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill5.left
        anchors.top: classTrainerSkill5.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill6SubText
        name: "ClassTrainerSkill6SubText"
        kind: "FontString"
        text: "(Rank 6)"
        wowParent: "ClassTrainerSkill6"
        anchors.right: classTrainerSkill6.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill6.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill6Text
        name: "ClassTrainerSkill6Text"
        kind: "FontString"
        text: "  Brown Linen Shirt"
        wowParent: "ClassTrainerSkill6"
        anchors.left: classTrainerSkill6Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill6Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill7
        name: "ClassTrainerSkill7"
        kind: "Button"
        text: "  White Linen Shirt"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill6.left
        anchors.top: classTrainerSkill6.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill7SubText
        name: "ClassTrainerSkill7SubText"
        kind: "FontString"
        text: "(Rank 2)"
        wowParent: "ClassTrainerSkill7"
        anchors.right: classTrainerSkill7.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill7.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill7Text
        name: "ClassTrainerSkill7Text"
        kind: "FontString"
        text: "  White Linen Shirt"
        wowParent: "ClassTrainerSkill7"
        anchors.left: classTrainerSkill7Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill7Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill8
        name: "ClassTrainerSkill8"
        kind: "Button"
        text: "  Brown Linen Vest"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill7.left
        anchors.top: classTrainerSkill7.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill8SubText
        name: "ClassTrainerSkill8SubText"
        kind: "FontString"
        text: "(Rank 1)"
        wowParent: "ClassTrainerSkill8"
        anchors.right: classTrainerSkill8.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill8.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: classTrainerSkill8Text
        name: "ClassTrainerSkill8Text"
        kind: "FontString"
        text: "  Brown Linen Vest"
        wowParent: "ClassTrainerSkill8"
        anchors.left: classTrainerSkill8Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill8Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkill9
        name: "ClassTrainerSkill9"
        kind: "Button"
        text: "  Linen Belt"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill8.left
        anchors.top: classTrainerSkill8.bottom
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkill9SubText
        name: "ClassTrainerSkill9SubText"
        kind: "FontString"
        text: "(Rank 10)"
        wowParent: "ClassTrainerSkill9"
        anchors.right: classTrainerSkill9.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill9.verticalCenter
        width: 50.6
        height: 10.3
    }

    Part {
        id: classTrainerSkill9Text
        name: "ClassTrainerSkill9Text"
        kind: "FontString"
        text: "  Linen Belt"
        wowParent: "ClassTrainerSkill9"
        anchors.left: classTrainerSkill9Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill9Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    Part {
        id: classTrainerSkillDescription
        name: "ClassTrainerSkillDescription"
        kind: "FontString"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerCostLabel.left
        anchors.top: classTrainerCostLabel.bottom
        anchors.topMargin: 10
        width: 290
        height: 1
    }

    Part {
        id: classTrainerSkillHighlightFrame
        name: "ClassTrainerSkillHighlightFrame"
        kind: "Frame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill1.left
        anchors.top: classTrainerSkill1.top
        width: 293
        height: 16
    }

    Part {
        id: classTrainerSkillIcon
        name: "ClassTrainerSkillIcon"
        kind: "Button"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: classTrainerDetailScrollChildFrame.top
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: classTrainerSkillName
        name: "ClassTrainerSkillName"
        kind: "FontString"
        text: "Apprentice Tailor"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerDetailScrollChildFrame.left
        anchors.leftMargin: 46
        anchors.top: classTrainerDetailScrollChildFrame.top
        anchors.topMargin: 2
        width: 244
        height: 11.9
    }

    Part {
        id: classTrainerSkillRequirements
        name: "ClassTrainerSkillRequirements"
        kind: "FontString"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerSkillName.left
        anchors.top: classTrainerSkillName.bottom
        width: 244
        height: 10.3
    }

    Part {
        id: classTrainerSubSkillName
        name: "ClassTrainerSubSkillName"
        kind: "FontString"
        text: "()"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerSkillName.right
        anchors.leftMargin: 5
        anchors.verticalCenter: classTrainerSkillName.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: classTrainerTrainButton
        name: "ClassTrainerTrainButton"
        kind: "Button"
        text: "Train"
        wowParent: "ClassTrainerFrame"
        style: "Button"
        anchors.right: classTrainerFrame.right
        anchors.rightMargin: 122.5
        anchors.bottom: classTrainerFrame.bottom
        anchors.bottomMargin: 81
        width: 77.5
        height: 22
    }

    Part {
        id: classTrainerTrainButtonText
        name: "ClassTrainerTrainButtonText"
        kind: "FontString"
        text: "Train"
        wowParent: "ClassTrainerTrainButton"
        anchors.horizontalCenter: classTrainerTrainButton.horizontalCenter
        anchors.verticalCenter: classTrainerTrainButton.verticalCenter
        width: 41.9
        height: 11.9
    }

    Ghost { id: classTrainerCollapseAllButtonHighlight; name: "ClassTrainerCollapseAllButtonHighlight"; x: 42; y: 79; width: 0; height: 0 }
    Ghost { id: classTrainerExpandTabLeft; name: "ClassTrainerExpandTabLeft"; x: 23; y: 82; width: 0; height: 0 }
    Ghost { id: classTrainerSkill10Highlight; name: "ClassTrainerSkill10Highlight"; x: 41; y: 252; width: 0; height: 0 }
    Ghost { id: classTrainerSkill11Highlight; name: "ClassTrainerSkill11Highlight"; x: 41; y: 268; width: 0; height: 0 }
    Ghost { id: classTrainerSkill1Highlight; name: "ClassTrainerSkill1Highlight"; x: 41; y: 108; width: 0; height: 0 }
    Ghost { id: classTrainerSkill2Highlight; name: "ClassTrainerSkill2Highlight"; x: 41; y: 124; width: 0; height: 0 }
    Ghost { id: classTrainerSkill3Highlight; name: "ClassTrainerSkill3Highlight"; x: 41; y: 140; width: 0; height: 0 }
    Ghost { id: classTrainerSkill4Highlight; name: "ClassTrainerSkill4Highlight"; x: 41; y: 156; width: 0; height: 0 }
    Ghost { id: classTrainerSkill5Highlight; name: "ClassTrainerSkill5Highlight"; x: 41; y: 172; width: 0; height: 0 }
    Ghost { id: classTrainerSkill6Highlight; name: "ClassTrainerSkill6Highlight"; x: 41; y: 188; width: 0; height: 0 }
    Ghost { id: classTrainerSkill7Highlight; name: "ClassTrainerSkill7Highlight"; x: 41; y: 204; width: 0; height: 0 }
    Ghost { id: classTrainerSkill8Highlight; name: "ClassTrainerSkill8Highlight"; x: 41; y: 220; width: 0; height: 0 }
    Ghost { id: classTrainerSkill9Highlight; name: "ClassTrainerSkill9Highlight"; x: 41; y: 236; width: 0; height: 0 }
}
