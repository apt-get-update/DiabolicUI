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
        style: "Button"
        pin: "place"
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
        style: "Button"
        pin: "place"
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
        pin: "all"
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
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1Count
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Count"
        kind: "FontString"
        text: "2"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: lFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture.bottom
        anchors.bottomMargin: 1
        width: 10.3
        height: 14.2
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1Name
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Name"
        kind: "FontString"
        text: "Satchel of Helpful Goods"
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
        width: 73
        height: 28
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
        kind: "Button"
        text: "6"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.verticalCenter
        width: 24.1
        height: 19
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "6"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton.verticalCenter
        width: 11.1
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
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameXPLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameXPLabel.bottom
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
        id: lFDQueueFrameRandomScrollFrameChildFrameXPAmount
        name: "LFDQueueFrameRandomScrollFrameChildFrameXPAmount"
        kind: "FontString"
        text: "16000"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameXPLabel.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameXPLabel.verticalCenter
        width: 42.7
        height: 15.8
    }

    Part {
        id: lFDQueueFrameRandomScrollFrameChildFrameXPLabel
        name: "LFDQueueFrameRandomScrollFrameChildFrameXPLabel"
        kind: "FontString"
        text: "Experience:"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.bottom
        anchors.topMargin: 5
        width: 74.3
        height: 12.6
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
        id: lFDQueueFrameSpecific
        name: "LFDQueueFrameSpecific"
        kind: "Frame"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrame.left
        anchors.top: lFDQueueFrame.top
        anchors.topMargin: -62
        width: 355
        height: 456
    }

    Part {
        id: lFDQueueFrameSpecificListButton1
        name: "LFDQueueFrameSpecificListButton1"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecific.left
        anchors.leftMargin: 25
        anchors.top: lFDQueueFrameSpecific.top
        anchors.topMargin: 165
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton10
        name: "LFDQueueFrameSpecificListButton10"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton9.left
        anchors.top: lFDQueueFrameSpecificListButton9.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton10EnableButton
        name: "LFDQueueFrameSpecificListButton10EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton10"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton10LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton10LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton10InstanceLevel
        name: "LFDQueueFrameSpecificListButton10InstanceLevel"
        kind: "FontString"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton10"
        anchors.right: lFDQueueFrameSpecificListButton10.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton10.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton10InstanceName
        name: "LFDQueueFrameSpecificListButton10InstanceName"
        kind: "FontString"
        text: "The Culling of Stratholme"
        wowParent: "LFDQueueFrameSpecificListButton10"
        anchors.left: lFDQueueFrameSpecificListButton10.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton10.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton11
        name: "LFDQueueFrameSpecificListButton11"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton10.left
        anchors.top: lFDQueueFrameSpecificListButton10.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton11EnableButton
        name: "LFDQueueFrameSpecificListButton11EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton11"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton11LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton11LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton11InstanceLevel
        name: "LFDQueueFrameSpecificListButton11InstanceLevel"
        kind: "FontString"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton11"
        anchors.right: lFDQueueFrameSpecificListButton11.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton11.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton11InstanceName
        name: "LFDQueueFrameSpecificListButton11InstanceName"
        kind: "FontString"
        text: "The Oculus"
        wowParent: "LFDQueueFrameSpecificListButton11"
        anchors.left: lFDQueueFrameSpecificListButton11.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton11.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton12
        name: "LFDQueueFrameSpecificListButton12"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton11.left
        anchors.top: lFDQueueFrameSpecificListButton11.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton12EnableButton
        name: "LFDQueueFrameSpecificListButton12EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton12"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton12LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton12LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton12InstanceLevel
        name: "LFDQueueFrameSpecificListButton12InstanceLevel"
        kind: "FontString"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton12"
        anchors.right: lFDQueueFrameSpecificListButton12.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton12.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton12InstanceName
        name: "LFDQueueFrameSpecificListButton12InstanceName"
        kind: "FontString"
        text: "Utgarde Pinnacle"
        wowParent: "LFDQueueFrameSpecificListButton12"
        anchors.left: lFDQueueFrameSpecificListButton12.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton12.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton13
        name: "LFDQueueFrameSpecificListButton13"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton12.left
        anchors.top: lFDQueueFrameSpecificListButton12.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton13EnableButton
        name: "LFDQueueFrameSpecificListButton13EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton13"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton13LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton13LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton13InstanceLevel
        name: "LFDQueueFrameSpecificListButton13InstanceLevel"
        kind: "FontString"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton13"
        anchors.right: lFDQueueFrameSpecificListButton13.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton13.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton13InstanceName
        name: "LFDQueueFrameSpecificListButton13InstanceName"
        kind: "FontString"
        text: "Halls of Reflection"
        wowParent: "LFDQueueFrameSpecificListButton13"
        anchors.left: lFDQueueFrameSpecificListButton13.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton13.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton14
        name: "LFDQueueFrameSpecificListButton14"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton13.left
        anchors.top: lFDQueueFrameSpecificListButton13.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton14InstanceLevel
        name: "LFDQueueFrameSpecificListButton14InstanceLevel"
        kind: "FontString"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton14"
        anchors.right: lFDQueueFrameSpecificListButton14.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton14.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton14InstanceName
        name: "LFDQueueFrameSpecificListButton14InstanceName"
        kind: "FontString"
        text: "Pit of Saron"
        wowParent: "LFDQueueFrameSpecificListButton14"
        anchors.left: lFDQueueFrameSpecificListButton14.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton14.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton15
        name: "LFDQueueFrameSpecificListButton15"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton14.left
        anchors.top: lFDQueueFrameSpecificListButton14.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton15EnableButton
        name: "LFDQueueFrameSpecificListButton15EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton15"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton15LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton15LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton15InstanceLevel
        name: "LFDQueueFrameSpecificListButton15InstanceLevel"
        kind: "FontString"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton15"
        anchors.right: lFDQueueFrameSpecificListButton15.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton15.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton15InstanceName
        name: "LFDQueueFrameSpecificListButton15InstanceName"
        kind: "FontString"
        text: "The Forge of Souls"
        wowParent: "LFDQueueFrameSpecificListButton15"
        anchors.left: lFDQueueFrameSpecificListButton15.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton15.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton16
        name: "LFDQueueFrameSpecificListButton16"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton15.left
        anchors.top: lFDQueueFrameSpecificListButton15.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton16EnableButton
        name: "LFDQueueFrameSpecificListButton16EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton16"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton16LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton16LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton16InstanceLevel
        name: "LFDQueueFrameSpecificListButton16InstanceLevel"
        kind: "FontString"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton16"
        anchors.right: lFDQueueFrameSpecificListButton16.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton16.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton16InstanceName
        name: "LFDQueueFrameSpecificListButton16InstanceName"
        kind: "FontString"
        text: "Trial of the Champion"
        wowParent: "LFDQueueFrameSpecificListButton16"
        anchors.left: lFDQueueFrameSpecificListButton16.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton16.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton1EnableButton
        name: "LFDQueueFrameSpecificListButton1EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton1LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton1ExpandOrCollapseButton
        name: "LFDQueueFrameSpecificListButton1ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: lFDQueueFrameSpecificListButton1InstanceLevel
        name: "LFDQueueFrameSpecificListButton1InstanceLevel"
        kind: "FontString"
        text: "(69 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.right: lFDQueueFrameSpecificListButton1.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton1InstanceName
        name: "LFDQueueFrameSpecificListButton1InstanceName"
        kind: "FontString"
        text: "The Nexus"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton2
        name: "LFDQueueFrameSpecificListButton2"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.top: lFDQueueFrameSpecificListButton1.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton2EnableButton
        name: "LFDQueueFrameSpecificListButton2EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton2"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton2LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton2LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton2InstanceLevel
        name: "LFDQueueFrameSpecificListButton2InstanceLevel"
        kind: "FontString"
        text: "(68 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton2"
        anchors.right: lFDQueueFrameSpecificListButton2.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton2.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton2InstanceName
        name: "LFDQueueFrameSpecificListButton2InstanceName"
        kind: "FontString"
        text: "Utgarde Keep"
        wowParent: "LFDQueueFrameSpecificListButton2"
        anchors.left: lFDQueueFrameSpecificListButton2.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton2.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton3
        name: "LFDQueueFrameSpecificListButton3"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton2.left
        anchors.top: lFDQueueFrameSpecificListButton2.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton3EnableButton
        name: "LFDQueueFrameSpecificListButton3EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton3"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton3LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton3LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton3InstanceLevel
        name: "LFDQueueFrameSpecificListButton3InstanceLevel"
        kind: "FontString"
        text: "(71 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton3"
        anchors.right: lFDQueueFrameSpecificListButton3.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton3.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton3InstanceName
        name: "LFDQueueFrameSpecificListButton3InstanceName"
        kind: "FontString"
        text: "Ahn'kahet: The Old Kingdom"
        wowParent: "LFDQueueFrameSpecificListButton3"
        anchors.left: lFDQueueFrameSpecificListButton3.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton3.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton4
        name: "LFDQueueFrameSpecificListButton4"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton3.left
        anchors.top: lFDQueueFrameSpecificListButton3.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton4EnableButton
        name: "LFDQueueFrameSpecificListButton4EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton4"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton4LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton4LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton4InstanceLevel
        name: "LFDQueueFrameSpecificListButton4InstanceLevel"
        kind: "FontString"
        text: "(70 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton4"
        anchors.right: lFDQueueFrameSpecificListButton4.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton4.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton4InstanceName
        name: "LFDQueueFrameSpecificListButton4InstanceName"
        kind: "FontString"
        text: "Azjol-Nerub"
        wowParent: "LFDQueueFrameSpecificListButton4"
        anchors.left: lFDQueueFrameSpecificListButton4.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton4.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton5
        name: "LFDQueueFrameSpecificListButton5"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton4.left
        anchors.top: lFDQueueFrameSpecificListButton4.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton5EnableButton
        name: "LFDQueueFrameSpecificListButton5EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton5"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton5LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton5LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton5InstanceLevel
        name: "LFDQueueFrameSpecificListButton5InstanceLevel"
        kind: "FontString"
        text: "(72 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton5"
        anchors.right: lFDQueueFrameSpecificListButton5.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton5.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton5InstanceName
        name: "LFDQueueFrameSpecificListButton5InstanceName"
        kind: "FontString"
        text: "Drak'Tharon Keep"
        wowParent: "LFDQueueFrameSpecificListButton5"
        anchors.left: lFDQueueFrameSpecificListButton5.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton5.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton6
        name: "LFDQueueFrameSpecificListButton6"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton5.left
        anchors.top: lFDQueueFrameSpecificListButton5.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton6EnableButton
        name: "LFDQueueFrameSpecificListButton6EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton6"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton6LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton6LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton6InstanceLevel
        name: "LFDQueueFrameSpecificListButton6InstanceLevel"
        kind: "FontString"
        text: "(73 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton6"
        anchors.right: lFDQueueFrameSpecificListButton6.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton6.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton6InstanceName
        name: "LFDQueueFrameSpecificListButton6InstanceName"
        kind: "FontString"
        text: "Violet Hold"
        wowParent: "LFDQueueFrameSpecificListButton6"
        anchors.left: lFDQueueFrameSpecificListButton6.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton6.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton7
        name: "LFDQueueFrameSpecificListButton7"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton6.left
        anchors.top: lFDQueueFrameSpecificListButton6.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton7EnableButton
        name: "LFDQueueFrameSpecificListButton7EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton7"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton7LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton7LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton7InstanceLevel
        name: "LFDQueueFrameSpecificListButton7InstanceLevel"
        kind: "FontString"
        text: "(74 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton7"
        anchors.right: lFDQueueFrameSpecificListButton7.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton7.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton7InstanceName
        name: "LFDQueueFrameSpecificListButton7InstanceName"
        kind: "FontString"
        text: "Gundrak"
        wowParent: "LFDQueueFrameSpecificListButton7"
        anchors.left: lFDQueueFrameSpecificListButton7.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton7.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton8
        name: "LFDQueueFrameSpecificListButton8"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton7.left
        anchors.top: lFDQueueFrameSpecificListButton7.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton8EnableButton
        name: "LFDQueueFrameSpecificListButton8EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton8"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton8LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton8LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton8InstanceLevel
        name: "LFDQueueFrameSpecificListButton8InstanceLevel"
        kind: "FontString"
        text: "(75 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton8"
        anchors.right: lFDQueueFrameSpecificListButton8.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton8.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton8InstanceName
        name: "LFDQueueFrameSpecificListButton8InstanceName"
        kind: "FontString"
        text: "Halls of Stone"
        wowParent: "LFDQueueFrameSpecificListButton8"
        anchors.left: lFDQueueFrameSpecificListButton8.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton8.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton9
        name: "LFDQueueFrameSpecificListButton9"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton8.left
        anchors.top: lFDQueueFrameSpecificListButton8.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton9EnableButton
        name: "LFDQueueFrameSpecificListButton9EnableButton"
        kind: "CheckButton"
        wowParent: "LFDQueueFrameSpecificListButton9"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton9LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton9LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFDQueueFrameSpecificListButton9InstanceLevel
        name: "LFDQueueFrameSpecificListButton9InstanceLevel"
        kind: "FontString"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton9"
        anchors.right: lFDQueueFrameSpecificListButton9.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton9.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListButton9InstanceName
        name: "LFDQueueFrameSpecificListButton9InstanceName"
        kind: "FontString"
        text: "Halls of Lightning"
        wowParent: "LFDQueueFrameSpecificListButton9"
        anchors.left: lFDQueueFrameSpecificListButton9.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton9.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrame
        name: "LFDQueueFrameSpecificListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.top: lFDQueueFrameSpecificListButton1.top
        anchors.topMargin: -7
        width: 296
        height: 270
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrameDiabolicZone
        name: "LFDQueueFrameSpecificListScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: lFDQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 282
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrameScrollBar
        name: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "LFDQueueFrameSpecificListScrollFrame"
        style: "ScrollBar"
        anchors.left: lFDQueueFrameSpecificListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: lFDQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 238
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack
        name: "LFDQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 272
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton
        name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.top: lFDQueueFrameSpecificListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton
        name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: lFDQueueFrameSpecificListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: lFDQueueFrameSpecificListScrollFrameScrollChildFrame
        name: "LFDQueueFrameSpecificListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "LFDQueueFrameSpecificListScrollFrame"
        anchors.left: lFDQueueFrameSpecificListScrollFrame.left
        anchors.top: lFDQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: -288
        width: 300
        height: 544
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
        style: "DropDown"
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
        text: "Random Burning Crusade Dungeon"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.horizontalCenter: lFDQueueFrameTypeDropDown.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        width: 205
        height: 10
    }

    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture; name: "LFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture"; x: 72; y: 261.1; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame; name: "LFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame"; x: 62; y: 241.6; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton; name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton"; x: 172; y: 279.5; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton10LockedIndicator; name: "LFDQueueFrameSpecificListButton10LockedIndicator"; x: 56; y: 255; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton11LockedIndicator; name: "LFDQueueFrameSpecificListButton11LockedIndicator"; x: 56; y: 271; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton12LockedIndicator; name: "LFDQueueFrameSpecificListButton12LockedIndicator"; x: 56; y: 287; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton13LockedIndicator; name: "LFDQueueFrameSpecificListButton13LockedIndicator"; x: 56; y: 303; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton15LockedIndicator; name: "LFDQueueFrameSpecificListButton15LockedIndicator"; x: 56; y: 335; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton16LockedIndicator; name: "LFDQueueFrameSpecificListButton16LockedIndicator"; x: 59.4; y: 351; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton1LockedIndicator; name: "LFDQueueFrameSpecificListButton1LockedIndicator"; x: 56; y: 111; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton2LockedIndicator; name: "LFDQueueFrameSpecificListButton2LockedIndicator"; x: 56; y: 127; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton3LockedIndicator; name: "LFDQueueFrameSpecificListButton3LockedIndicator"; x: 56; y: 143; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton4LockedIndicator; name: "LFDQueueFrameSpecificListButton4LockedIndicator"; x: 56; y: 159; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton5LockedIndicator; name: "LFDQueueFrameSpecificListButton5LockedIndicator"; x: 56; y: 175; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton6LockedIndicator; name: "LFDQueueFrameSpecificListButton6LockedIndicator"; x: 56; y: 191; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton7LockedIndicator; name: "LFDQueueFrameSpecificListButton7LockedIndicator"; x: 56; y: 207; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton8LockedIndicator; name: "LFDQueueFrameSpecificListButton8LockedIndicator"; x: 56; y: 223; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameSpecificListButton9LockedIndicator; name: "LFDQueueFrameSpecificListButton9LockedIndicator"; x: 56; y: 239; width: 0; height: 0 }
}
