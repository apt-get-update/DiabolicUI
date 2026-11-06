// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: lFDParentFrame
    name: "LFDParentFrame"
    width: 355
    height: 440

    Part {
        id: lFDParentFrameDiabolic
        name: "LFDParentFrameDiabolic"
        kind: "Frame"
        wowParent: "LFDParentFrame"
        anchors.left: lFDParentFrame.left
        anchors.leftMargin: -24
        anchors.top: lFDParentFrame.top
        anchors.topMargin: -40
        width: 413
        height: 482
    }

    Part {
        id: lFDParentFrameDiabolicBand
        name: "LFDParentFrameDiabolicBand"
        kind: "Frame"
        wowParent: "LFDParentFrameDiabolic"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: lFDParentFrameDiabolic.top
        anchors.topMargin: 24
        width: 365
        height: 40
    }

    Part {
        id: lFDParentFrameDiabolicBorder
        name: "LFDParentFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "LFDParentFrameDiabolic"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.top: lFDParentFrameDiabolic.top
        width: 413
        height: 482
    }

    Part {
        id: lFDParentFrameDiabolicFoot
        name: "LFDParentFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "LFDParentFrameDiabolic"
        anchors.horizontalCenter: lFDQueueFrameFindGroupButton.horizontalCenter
        anchors.horizontalCenterOffset: 105
        anchors.top: lFDQueueFrameFindGroupButton.top
        anchors.topMargin: -6
        width: 367
        height: 35
    }

    Part {
        id: lFDParentFrameDiabolicSocket
        name: "LFDParentFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "LFDParentFrameDiabolic"
        anchors.right: lFDParentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: lFDParentFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: lFDParentFrameDiabolicTitlePlate
        name: "LFDParentFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "LFDParentFrameDiabolic"
        anchors.horizontalCenter: lFDParentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: lFDParentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: lFDParentFramePortrait
        name: "LFDParentFramePortrait"
        kind: "Frame"
        wowParent: "LFDParentFrame"
        anchors.left: lFDParentFrame.left
        anchors.leftMargin: 9
        anchors.top: lFDParentFrame.top
        anchors.topMargin: 5
        width: 64
        height: 64
    }

    Part {
        id: lFDQueueFrame
        name: "LFDQueueFrame"
        kind: "Frame"
        wowParent: "LFDParentFrame"
        anchors.left: lFDParentFrame.left
        anchors.top: lFDParentFrame.top
        width: 355
        height: 440
    }

    Part {
        id: lFDQueueFrameCancelButton
        name: "LFDQueueFrameCancelButton"
        kind: "Button"
        text: "Close"
        wowParent: "LFDQueueFrame"
        anchors.right: lFDParentFrameDiabolic.right
        anchors.rightMargin: 34
        anchors.bottom: lFDParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 112
        height: 22
    }

    Part {
        id: lFDQueueFrameCancelButtonText
        name: "LFDQueueFrameCancelButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "LFDQueueFrameCancelButton"
        anchors.horizontalCenter: lFDQueueFrameCancelButton.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameCancelButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Part {
        id: lFDQueueFrameFindGroupButton
        name: "LFDQueueFrameFindGroupButton"
        kind: "Button"
        text: "Find Group"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.leftMargin: 34
        anchors.bottom: lFDParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 135
        height: 22
    }

    Part {
        id: lFDQueueFrameFindGroupButtonText
        name: "LFDQueueFrameFindGroupButtonText"
        kind: "FontString"
        text: "Find Group"
        wowParent: "LFDQueueFrameFindGroupButton"
        anchors.horizontalCenter: lFDQueueFrameFindGroupButton.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameFindGroupButton.verticalCenter
        width: 82.2
        height: 11.9
    }

    Part {
        id: lFDQueueFrameRandom
        name: "LFDQueueFrameRandom"
        kind: "Frame"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrame.left
        anchors.top: lFDQueueFrame.top
        anchors.topMargin: -62
        width: 355
        height: 456
    }

    Part {
        id: lFDQueueFrameRandomScrollFrame
        name: "LFDQueueFrameRandomScrollFrame"
        kind: "ScrollFrame"
        wowParent: "LFDQueueFrameRandom"
        anchors.right: lFDQueueFrameRandom.right
        anchors.rightMargin: 34
        anchors.bottom: lFDQueueFrameRandom.bottom
        anchors.bottomMargin: 34
        width: 298
        height: 265
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrame
        name: "LFDQueueFrameRandomScrollFrameChildFrame"
        kind: "Frame"
        wowParent: "LFDQueueFrameRandomScrollFrame"
        anchors.left: lFDQueueFrameRandomScrollFrame.left
        anchors.top: lFDQueueFrameRandomScrollFrame.top
        width: 1
        height: 1
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameDescription
        name: "LFDQueueFrameRandomScrollFrameChildFrameDescription"
        kind: "FontString"
        text: "Using the Dungeon Finder to do a Random Dungeon will earn you extra rewards."
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameTitle.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameTitle.bottom
        anchors.topMargin: 5
        width: 280
        height: 25.3
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
        kind: "Button"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription.bottom
        anchors.topMargin: 10
        width: 147
        height: 41
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1Name
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Name"
        kind: "FontString"
        text: "Emblem of Conquest"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame.verticalCenter
        width: 90
        height: 36
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrame
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        kind: "Frame"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.verticalCenter
        width: 80.9
        height: 28
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
        kind: "Button"
        text: "22"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.verticalCenter
        width: 32
        height: 19
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "22"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton.verticalCenter
        width: 19
        height: 15.8
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
        kind: "Button"
        text: "20"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton.right
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton.verticalCenter
        width: 32
        height: 19
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButtonText
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "20"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.verticalCenter
        width: 19
        height: 15.8
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyLabel"
        kind: "FontString"
        text: "Money:"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameItem1.left
        anchors.leftMargin: 20
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameItem1.bottom
        anchors.topMargin: 10
        width: 49
        height: 12.6
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription
        name: "LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription"
        kind: "FontString"
        text: "The first random dungeon that you complete each day will earn you:"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameRewardsLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameRewardsLabel.bottom
        anchors.topMargin: 5
        width: 280
        height: 25.3
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameRewardsLabel
        name: "LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel"
        kind: "FontString"
        text: "Rewards"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameDescription.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameDescription.bottom
        anchors.topMargin: 10
        width: 84.5
        height: 15.8
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameSpacer
        name: "LFDQueueFrameRandomScrollFrameChildFrameSpacer"
        kind: "Frame"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.bottom
        anchors.topMargin: 10
        width: 2
        height: 2
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameTitle
        name: "LFDQueueFrameRandomScrollFrameChildFrameTitle"
        kind: "FontString"
        text: "Random Dungeon"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrame.left
        anchors.leftMargin: 10
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrame.top
        anchors.topMargin: 15
        width: 171.5
        height: 15.8
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameDiabolicZone
        name: "LFDQueueFrameRandomScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "LFDQueueFrameRandom"
        anchors.left: lFDQueueFrameRandomScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: lFDQueueFrameRandomScrollFrame.top
        anchors.topMargin: -6
        width: 332
        height: 277
    }

    Part {
        id: lFDQueueFrameRoleButtonDPS
        name: "LFDQueueFrameRoleButtonDPS"
        kind: "Button"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrameRoleButtonHealer.right
        anchors.leftMargin: 23
        anchors.verticalCenter: lFDQueueFrameRoleButtonHealer.verticalCenter
        width: 48
        height: 48
    }

    Part {
        id: lFDQueueFrameRoleButtonHealer
        name: "LFDQueueFrameRoleButtonHealer"
        kind: "Button"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrameRoleButtonTank.right
        anchors.leftMargin: 25
        anchors.verticalCenter: lFDQueueFrameRoleButtonTank.verticalCenter
        width: 48
        height: 48
    }

    Part {
        id: lFDQueueFrameRoleButtonLeader
        name: "LFDQueueFrameRoleButtonLeader"
        kind: "Button"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrameRoleButtonDPS.right
        anchors.leftMargin: 32
        anchors.verticalCenter: lFDQueueFrameRoleButtonDPS.verticalCenter
        width: 48
        height: 48
    }

    Part {
        id: lFDQueueFrameRoleButtonTank
        name: "LFDQueueFrameRoleButtonTank"
        kind: "Button"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDParentFrameDiabolic.horizontalCenter
        anchors.leftMargin: -136
        anchors.top: lFDParentFrameDiabolic.top
        anchors.topMargin: 72
        width: 48
        height: 48
    }

    Part {
        id: lFDQueueFrameTitleText
        name: "LFDQueueFrameTitleText"
        kind: "FontString"
        text: "Dungeon Finder"
        wowParent: "LFDParentFrameDiabolicTitlePlate"
        anchors.horizontalCenter: lFDParentFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: lFDParentFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 144.6
        height: 14.2
    }

    Part {
        id: lFDQueueFrameTypeDropDown
        name: "LFDQueueFrameTypeDropDown"
        kind: "Frame"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDParentFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: lFDParentFrameDiabolicBand.verticalCenter
        width: 280
        height: 32
    }

    Part {
        id: lFDQueueFrameTypeDropDownButton
        name: "LFDQueueFrameTypeDropDownButton"
        kind: "Button"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.right: lFDQueueFrameTypeDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: lFDQueueFrameTypeDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: lFDQueueFrameTypeDropDownDiabolicField
        name: "LFDQueueFrameTypeDropDownDiabolicField"
        kind: "Frame"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.left: lFDQueueFrameTypeDropDown.left
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        width: 280
        height: 22
    }

    Part {
        id: lFDQueueFrameTypeDropDownName
        name: "LFDQueueFrameTypeDropDownName"
        kind: "FontString"
        text: "Type:"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.right: lFDQueueFrameTypeDropDown.left
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 115
        height: 24
    }

    Part {
        id: lFDQueueFrameTypeDropDownText
        name: "LFDQueueFrameTypeDropDownText"
        kind: "FontString"
        text: "Random Lich King Heroic"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.horizontalCenter: lFDQueueFrameTypeDropDown.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        width: 205
        height: 10
    }

    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame; name: "LFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame"; x: 62; y: 241.6; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton; name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton"; x: 180; y: 279.5; width: 0; height: 0 }
}
