// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: classTrainerFrame
    name: "ClassTrainerFrame"
    width: 384
    height: 512

    Button {
        id: classTrainerCancelButton
        name: "ClassTrainerCancelButton"
        text: "Exit"
        wowParent: "ClassTrainerFrame"
        style: "Button"
        pin: "all"
        anchors.left: classTrainerTrainButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: classTrainerTrainButton.verticalCenter
        width: 83.5
        height: 22
    }

    FontString {
        id: classTrainerCancelButtonText
        name: "ClassTrainerCancelButtonText"
        text: "Exit"
        wowParent: "ClassTrainerCancelButton"
        anchors.horizontalCenter: classTrainerCancelButton.horizontalCenter
        anchors.verticalCenter: classTrainerCancelButton.verticalCenter
        width: 32.4
        height: 11.9
    }

    Button {
        id: classTrainerCollapseAllButton
        name: "ClassTrainerCollapseAllButton"
        text: "All"
        wowParent: "ClassTrainerExpandButtonFrame"
        anchors.left: classTrainerExpandTabLeft.right
        anchors.verticalCenter: classTrainerExpandTabLeft.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 22
    }

    FontString {
        id: classTrainerCollapseAllButtonSubText
        name: "ClassTrainerCollapseAllButtonSubText"
        wowParent: "ClassTrainerCollapseAllButton"
        anchors.left: classTrainerCollapseAllButton.left
        anchors.verticalCenter: classTrainerCollapseAllButton.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: classTrainerCollapseAllButtonText
        name: "ClassTrainerCollapseAllButtonText"
        text: "All"
        wowParent: "ClassTrainerCollapseAllButton"
        anchors.left: classTrainerCollapseAllButtonHighlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerCollapseAllButtonHighlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    FontString {
        id: classTrainerCostLabel
        name: "ClassTrainerCostLabel"
        text: "Cost:"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: classTrainerDetailScrollChildFrame.top
        anchors.topMargin: 50
        width: 27.7
        height: 10.3
    }

    Frame {
        id: classTrainerDetailMoneyFrame
        name: "ClassTrainerDetailMoneyFrame"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerCostLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: classTrainerCostLabel.verticalCenter
        width: 36.3
        height: 13
    }

    Button {
        id: classTrainerDetailMoneyFrameCopperButton
        name: "ClassTrainerDetailMoneyFrameCopperButton"
        text: "8"
        wowParent: "ClassTrainerDetailMoneyFrame"
        anchors.right: classTrainerDetailMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrame.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: classTrainerDetailMoneyFrameCopperButtonText
        name: "ClassTrainerDetailMoneyFrameCopperButtonText"
        text: "8"
        wowParent: "ClassTrainerDetailMoneyFrameCopperButton"
        anchors.right: classTrainerDetailMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Button {
        id: classTrainerDetailMoneyFrameGoldButton
        name: "ClassTrainerDetailMoneyFrameGoldButton"
        text: "1"
        wowParent: "ClassTrainerDetailMoneyFrame"
        anchors.right: classTrainerDetailMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerDetailMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: classTrainerDetailMoneyFrameGoldButtonText
        name: "ClassTrainerDetailMoneyFrameGoldButtonText"
        text: "1"
        wowParent: "ClassTrainerDetailMoneyFrameGoldButton"
        anchors.right: classTrainerDetailMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Button {
        id: classTrainerDetailMoneyFrameSilverButton
        name: "ClassTrainerDetailMoneyFrameSilverButton"
        text: "2"
        wowParent: "ClassTrainerDetailMoneyFrame"
        anchors.right: classTrainerDetailMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerDetailMoneyFrameCopperButton.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: classTrainerDetailMoneyFrameSilverButtonText
        name: "ClassTrainerDetailMoneyFrameSilverButtonText"
        text: "2"
        wowParent: "ClassTrainerDetailMoneyFrameSilverButton"
        anchors.right: classTrainerDetailMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerDetailMoneyFrameSilverButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Frame {
        id: classTrainerDetailScrollChildFrame
        name: "ClassTrainerDetailScrollChildFrame"
        wowParent: "ClassTrainerDetailScrollFrame"
        anchors.left: classTrainerDetailScrollFrame.left
        anchors.top: classTrainerDetailScrollFrame.top
        width: 296
        height: 50
    }

    // the chosen one's page 6 under the list's (Blizzard's 8 under its text)
    ScrollFrame {
        id: classTrainerDetailScrollFrame
        name: "ClassTrainerDetailScrollFrame"
        wowParent: "ClassTrainerFrame"
        pin: "place"
        anchors.left: classTrainerListScrollFrame.left
        anchors.top: classTrainerListScrollFrame.bottom
        anchors.topMargin: 14
        width: 296
        height: 95
    }

    Frame {
        id: classTrainerDetailScrollFrameDiabolicPanel
        name: "ClassTrainerDetailScrollFrameDiabolicPanel"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerDetailScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: classTrainerDetailScrollFrame.top
        anchors.topMargin: -6
        width: 360
        height: 107
    }

    Frame {
        id: classTrainerDetailScrollFrameDiabolicParchment
        name: "ClassTrainerDetailScrollFrameDiabolicParchment"
        wowParent: "ClassTrainerFrame"
        anchors.horizontalCenter: classTrainerDetailScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 5
        anchors.top: classTrainerDetailScrollFrame.top
        anchors.topMargin: -4
        width: 334
        height: 103
    }

    Slider {
        id: classTrainerDetailScrollFrameScrollBar
        name: "ClassTrainerDetailScrollFrameScrollBar"
        wowParent: "ClassTrainerDetailScrollFrame"
        style: "ScrollBar"
        anchors.left: classTrainerDetailScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: classTrainerDetailScrollFrame.top
        anchors.topMargin: 32
        width: 16
        height: 47
    }

    Frame {
        id: classTrainerDetailScrollFrameScrollBarDiabolicTrack
        name: "ClassTrainerDetailScrollFrameScrollBarDiabolicTrack"
        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
        anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: classTrainerDetailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 81
    }

    Button {
        id: classTrainerDetailScrollFrameScrollBarScrollDownButton
        name: "ClassTrainerDetailScrollFrameScrollBarScrollDownButton"
        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBar.horizontalCenter
        anchors.top: classTrainerDetailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: classTrainerDetailScrollFrameScrollBarScrollUpButton
        name: "ClassTrainerDetailScrollFrameScrollBarScrollUpButton"
        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: classTrainerDetailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    // "All" and the list under the greeting (the chosen one's height: trainer.lua)
    Frame {
        id: classTrainerExpandButtonFrame
        name: "ClassTrainerExpandButtonFrame"
        wowParent: "ClassTrainerFrame"
        pin: "place"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: 15
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 66
        width: 54
        height: 32
    }

    Button {
        id: classTrainerFrameCloseButton
        name: "ClassTrainerFrameCloseButton"
        wowParent: "ClassTrainerFrame"
        style: "CloseButton"
        anchors.horizontalCenter: classTrainerFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: classTrainerFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Frame {
        id: classTrainerFrameDiabolic
        name: "ClassTrainerFrameDiabolic"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: -24
        anchors.top: classTrainerFrame.top
        anchors.topMargin: -40
        width: 418
        height: 513
    }

    Frame {
        id: classTrainerFrameDiabolicBand
        name: "ClassTrainerFrameDiabolicBand"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.left: classTrainerFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: classTrainerFrameDiabolic.top
        anchors.topMargin: 24
        width: 370
        height: 40
    }

    Frame {
        id: classTrainerFrameDiabolicBorder
        name: "ClassTrainerFrameDiabolicBorder"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.left: classTrainerFrameDiabolic.left
        anchors.top: classTrainerFrameDiabolic.top
        width: 418
        height: 513
    }

    Frame {
        id: classTrainerFrameDiabolicFoot
        name: "ClassTrainerFrameDiabolicFoot"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.horizontalCenter: classTrainerTrainButton.horizontalCenter
        anchors.horizontalCenterOffset: -37.7
        anchors.top: classTrainerTrainButton.top
        anchors.topMargin: -6
        width: 372
        height: 47
    }

    Frame {
        id: classTrainerFrameDiabolicSocket
        name: "ClassTrainerFrameDiabolicSocket"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.right: classTrainerFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: classTrainerFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: classTrainerFrameDiabolicTitlePlate
        name: "ClassTrainerFrameDiabolicTitlePlate"
        wowParent: "ClassTrainerFrameDiabolic"
        anchors.horizontalCenter: classTrainerFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: classTrainerFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Frame {
        id: classTrainerFrameFilterDropDown
        name: "ClassTrainerFrameFilterDropDown"
        wowParent: "ClassTrainerFrame"
        style: "DropDown"
        anchors.left: classTrainerFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: classTrainerFrameDiabolicBand.verticalCenter
        width: 180
        height: 32
    }

    Button {
        id: classTrainerFrameFilterDropDownButton
        name: "ClassTrainerFrameFilterDropDownButton"
        wowParent: "ClassTrainerFrameFilterDropDown"
        anchors.right: classTrainerFrameFilterDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: classTrainerFrameFilterDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: classTrainerFrameFilterDropDownDiabolicField
        name: "ClassTrainerFrameFilterDropDownDiabolicField"
        wowParent: "ClassTrainerFrameFilterDropDown"
        anchors.left: classTrainerFrameFilterDropDown.left
        anchors.verticalCenter: classTrainerFrameFilterDropDown.verticalCenter
        width: 180
        height: 22
    }

    FontString {
        id: classTrainerFrameFilterDropDownText
        name: "ClassTrainerFrameFilterDropDownText"
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
    FontString {
        id: classTrainerGreetingText
        name: "ClassTrainerGreetingText"
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

    Frame {
        id: classTrainerGreetingTextDiabolicPanel
        name: "ClassTrainerGreetingTextDiabolicPanel"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerGreetingText.left
        anchors.leftMargin: -4
        anchors.top: classTrainerGreetingText.top
        anchors.topMargin: -4
        width: 358
        height: 32
    }

    ScrollFrame {
        id: classTrainerListScrollFrame
        name: "ClassTrainerListScrollFrame"
        wowParent: "ClassTrainerFrame"
        pin: "place"
        anchors.right: classTrainerFrame.right
        anchors.rightMargin: 67
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 102
        width: 296
        height: 168
    }

    Frame {
        id: classTrainerListScrollFrameDiabolicPanel
        name: "ClassTrainerListScrollFrameDiabolicPanel"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerListScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: -6
        width: 360
        height: 180
    }

    Frame {
        id: classTrainerListScrollFrameDiabolicParchment
        name: "ClassTrainerListScrollFrameDiabolicParchment"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerListScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: -4
        width: 334
        height: 176
    }

    Slider {
        id: classTrainerListScrollFrameScrollBar
        name: "ClassTrainerListScrollFrameScrollBar"
        wowParent: "ClassTrainerListScrollFrame"
        style: "ScrollBar"
        anchors.left: classTrainerListScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 136
    }

    Frame {
        id: classTrainerListScrollFrameScrollBarDiabolicTrack
        name: "ClassTrainerListScrollFrameScrollBarDiabolicTrack"
        wowParent: "ClassTrainerListScrollFrameScrollBar"
        anchors.horizontalCenter: classTrainerListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: classTrainerListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 170
    }

    Button {
        id: classTrainerListScrollFrameScrollBarScrollDownButton
        name: "ClassTrainerListScrollFrameScrollBarScrollDownButton"
        wowParent: "ClassTrainerListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerListScrollFrameScrollBar.horizontalCenter
        anchors.top: classTrainerListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: classTrainerListScrollFrameScrollBarScrollUpButton
        name: "ClassTrainerListScrollFrameScrollBarScrollUpButton"
        wowParent: "ClassTrainerListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: classTrainerListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: classTrainerListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: classTrainerListScrollFrameScrollChildFrame
        name: "ClassTrainerListScrollFrameScrollChildFrame"
        wowParent: "ClassTrainerListScrollFrame"
        anchors.left: classTrainerListScrollFrame.left
        anchors.top: classTrainerListScrollFrame.top
        anchors.topMargin: -16
        width: 300
        height: 1680
    }

    Frame {
        id: classTrainerMoneyFrame
        name: "ClassTrainerMoneyFrame"
        wowParent: "ClassTrainerFrame"
        anchors.right: classTrainerFrame.left
        anchors.rightMargin: -180
        anchors.bottom: classTrainerFrame.bottom
        anchors.bottomMargin: 86
        width: 126.4
        height: 13
    }

    Button {
        id: classTrainerMoneyFrameCopperButton
        name: "ClassTrainerMoneyFrameCopperButton"
        text: "13"
        wowParent: "ClassTrainerMoneyFrame"
        anchors.right: classTrainerMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: classTrainerMoneyFrameCopperButtonText
        name: "ClassTrainerMoneyFrameCopperButtonText"
        text: "13"
        wowParent: "ClassTrainerMoneyFrameCopperButton"
        anchors.right: classTrainerMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: classTrainerMoneyFrameGoldButton
        name: "ClassTrainerMoneyFrameGoldButton"
        text: "3654"
        wowParent: "ClassTrainerMoneyFrame"
        anchors.right: classTrainerMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    FontString {
        id: classTrainerMoneyFrameGoldButtonText
        name: "ClassTrainerMoneyFrameGoldButtonText"
        text: "3654"
        wowParent: "ClassTrainerMoneyFrameGoldButton"
        anchors.right: classTrainerMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Button {
        id: classTrainerMoneyFrameSilverButton
        name: "ClassTrainerMoneyFrameSilverButton"
        text: "16"
        wowParent: "ClassTrainerMoneyFrame"
        anchors.right: classTrainerMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: classTrainerMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: classTrainerMoneyFrameSilverButtonText
        name: "ClassTrainerMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "ClassTrainerMoneyFrameSilverButton"
        anchors.right: classTrainerMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: classTrainerMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: classTrainerNameText
        name: "ClassTrainerNameText"
        text: "Georgio Bolero"
        wowParent: "ClassTrainerFrameDiabolicTitlePlate"
        anchors.horizontalCenter: classTrainerFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: classTrainerFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 140.6
        height: 14.2
    }

    Button {
        id: classTrainerSkill1
        name: "ClassTrainerSkill1"
        text: "  Apprentice Tailor"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerFrame.left
        anchors.leftMargin: 22
        anchors.top: classTrainerFrame.top
        anchors.topMargin: 100
        width: 293
        height: 16
    }

    FontString {
        id: classTrainerSkill1SubText
        name: "ClassTrainerSkill1SubText"
        text: "(Rank 4)"
        wowParent: "ClassTrainerSkill1"
        anchors.right: classTrainerSkill1.right
        anchors.rightMargin: 2
        anchors.verticalCenter: classTrainerSkill1.verticalCenter
        width: 44.2
        height: 10.3
    }

    FontString {
        id: classTrainerSkill1Text
        name: "ClassTrainerSkill1Text"
        text: "  Apprentice Tailor"
        wowParent: "ClassTrainerSkill1"
        anchors.left: classTrainerSkill1Highlight.right
        anchors.leftMargin: 2
        anchors.verticalCenter: classTrainerSkill1Highlight.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 270
        height: 13
    }

    FontString {
        id: classTrainerSkillDescription
        name: "ClassTrainerSkillDescription"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerCostLabel.left
        anchors.top: classTrainerCostLabel.bottom
        anchors.topMargin: 10
        width: 290
        height: 1
    }

    Frame {
        id: classTrainerSkillHighlightFrame
        name: "ClassTrainerSkillHighlightFrame"
        wowParent: "ClassTrainerFrame"
        anchors.left: classTrainerSkill1.left
        anchors.top: classTrainerSkill1.top
        width: 293
        height: 16
    }

    Button {
        id: classTrainerSkillIcon
        name: "ClassTrainerSkillIcon"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: classTrainerDetailScrollChildFrame.top
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    FontString {
        id: classTrainerSkillName
        name: "ClassTrainerSkillName"
        text: "Apprentice Tailor"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerDetailScrollChildFrame.left
        anchors.leftMargin: 46
        anchors.top: classTrainerDetailScrollChildFrame.top
        anchors.topMargin: 2
        width: 244
        height: 11.9
    }

    FontString {
        id: classTrainerSkillRequirements
        name: "ClassTrainerSkillRequirements"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerSkillName.left
        anchors.top: classTrainerSkillName.bottom
        width: 244
        height: 10.3
    }

    FontString {
        id: classTrainerSubSkillName
        name: "ClassTrainerSubSkillName"
        text: "()"
        wowParent: "ClassTrainerDetailScrollChildFrame"
        anchors.left: classTrainerSkillName.right
        anchors.leftMargin: 5
        anchors.verticalCenter: classTrainerSkillName.verticalCenter
        width: 8.7
        height: 11.9
    }

    Button {
        id: classTrainerTrainButton
        name: "ClassTrainerTrainButton"
        text: "Train"
        wowParent: "ClassTrainerFrame"
        style: "Button"
        pin: "all"
        anchors.left: classTrainerFrameDiabolic.left
        anchors.leftMargin: 208
        anchors.bottom: classTrainerFrameDiabolic.bottom
        anchors.bottomMargin: 42
        width: 83.5
        height: 22
    }

    FontString {
        id: classTrainerTrainButtonText
        name: "ClassTrainerTrainButtonText"
        text: "Train"
        wowParent: "ClassTrainerTrainButton"
        anchors.horizontalCenter: classTrainerTrainButton.horizontalCenter
        anchors.verticalCenter: classTrainerTrainButton.verticalCenter
        width: 41.9
        height: 11.9
    }

    WowRow {
        name: "TrainerButtons"
        parts: ["ClassTrainerTrainButton", "ClassTrainerCancelButton"]
        fit: "equal"
        anchors.left: classTrainerFrameDiabolic.left
        anchors.leftMargin: 208
        anchors.right: classTrainerFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: classTrainerFrameDiabolic.bottom
        anchors.bottomMargin: 42
    }

    Ghost { id: classTrainerCollapseAllButtonHighlight; name: "ClassTrainerCollapseAllButtonHighlight"; x: 42; y: 79; width: 0; height: 0 }
    Ghost { id: classTrainerExpandTabLeft; name: "ClassTrainerExpandTabLeft"; x: 23; y: 82; width: 0; height: 0 }
    Ghost { id: classTrainerSkill1Highlight; name: "ClassTrainerSkill1Highlight"; x: 41; y: 108; width: 0; height: 0 }
}
