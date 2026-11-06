// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: lFDParentFrame
    name: "LFDParentFrame"
    width: 355
    height: 440

    Frame {
        id: lFDParentFrameDiabolic
        name: "LFDParentFrameDiabolic"
        wowParent: "LFDParentFrame"
        anchors.left: lFDParentFrame.left
        anchors.leftMargin: -24
        anchors.top: lFDParentFrame.top
        anchors.topMargin: -40
        width: 413
        height: 482
    }

    Frame {
        id: lFDParentFrameDiabolicBand
        name: "LFDParentFrameDiabolicBand"
        wowParent: "LFDParentFrameDiabolic"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: lFDParentFrameDiabolic.top
        anchors.topMargin: 24
        width: 365
        height: 40
    }

    Frame {
        id: lFDParentFrameDiabolicBorder
        name: "LFDParentFrameDiabolicBorder"
        wowParent: "LFDParentFrameDiabolic"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.top: lFDParentFrameDiabolic.top
        width: 413
        height: 482
    }

    Frame {
        id: lFDParentFrameDiabolicFoot
        name: "LFDParentFrameDiabolicFoot"
        wowParent: "LFDParentFrameDiabolic"
        anchors.horizontalCenter: lFDQueueFrameFindGroupButton.horizontalCenter
        anchors.horizontalCenterOffset: 102
        anchors.top: lFDQueueFrameFindGroupButton.top
        anchors.topMargin: -6
        width: 367
        height: 35
    }

    Frame {
        id: lFDParentFrameDiabolicSocket
        name: "LFDParentFrameDiabolicSocket"
        wowParent: "LFDParentFrameDiabolic"
        anchors.right: lFDParentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: lFDParentFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: lFDParentFrameDiabolicTitlePlate
        name: "LFDParentFrameDiabolicTitlePlate"
        wowParent: "LFDParentFrameDiabolic"
        anchors.horizontalCenter: lFDParentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: lFDParentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Frame {
        id: lFDParentFramePortrait
        name: "LFDParentFramePortrait"
        wowParent: "LFDParentFrame"
        anchors.left: lFDParentFrame.left
        anchors.leftMargin: 9
        anchors.top: lFDParentFrame.top
        anchors.topMargin: 5
        width: 64
        height: 64
    }

    Frame {
        id: lFDQueueFrame
        name: "LFDQueueFrame"
        wowParent: "LFDParentFrame"
        anchors.left: lFDParentFrame.left
        anchors.top: lFDParentFrame.top
        width: 355
        height: 440
    }

    Button {
        id: lFDQueueFrameCancelButton
        name: "LFDQueueFrameCancelButton"
        text: "Close"
        wowParent: "LFDQueueFrame"
        style: "Button"
        pin: "place"
        anchors.left: lFDQueueFrameFindGroupButton.right
        anchors.leftMargin: 92
        anchors.verticalCenter: lFDQueueFrameFindGroupButton.verticalCenter
        width: 112
        height: 22
    }

    FontString {
        id: lFDQueueFrameCancelButtonText
        name: "LFDQueueFrameCancelButtonText"
        text: "Close"
        wowParent: "LFDQueueFrameCancelButton"
        anchors.horizontalCenter: lFDQueueFrameCancelButton.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameCancelButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Button {
        id: lFDQueueFrameFindGroupButton
        name: "LFDQueueFrameFindGroupButton"
        text: "Find Group"
        wowParent: "LFDQueueFrame"
        style: "Button"
        pin: "place"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: lFDParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 135
        height: 22
    }

    FontString {
        id: lFDQueueFrameFindGroupButtonText
        name: "LFDQueueFrameFindGroupButtonText"
        text: "Find Group"
        wowParent: "LFDQueueFrameFindGroupButton"
        anchors.horizontalCenter: lFDQueueFrameFindGroupButton.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameFindGroupButton.verticalCenter
        width: 82.2
        height: 11.9
    }

    Frame {
        id: lFDQueueFrameRandom
        name: "LFDQueueFrameRandom"
        wowParent: "LFDQueueFrame"
        pin: "place"
        anchors.left: lFDQueueFrame.left
        anchors.top: lFDQueueFrame.top
        anchors.topMargin: -62
        anchors.right: lFDQueueFrame.right
        anchors.bottom: lFDQueueFrame.bottom
        anchors.bottomMargin: 46
        width: 355
        height: 456
    }

    ScrollFrame {
        id: lFDQueueFrameRandomScrollFrame
        name: "LFDQueueFrameRandomScrollFrame"
        wowParent: "LFDQueueFrameRandom"
        pin: "all"
        anchors.right: lFDQueueFrameRandom.right
        anchors.rightMargin: 34
        anchors.bottom: lFDQueueFrameRandom.bottom
        anchors.bottomMargin: 34
        width: 298
        height: 265
    }

    Frame {
        id: lFDQueueFrameRandomScrollFrameChildFrame
        name: "LFDQueueFrameRandomScrollFrameChildFrame"
        wowParent: "LFDQueueFrameRandomScrollFrame"
        anchors.left: lFDQueueFrameRandomScrollFrame.left
        anchors.top: lFDQueueFrameRandomScrollFrame.top
        width: 1
        height: 1
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameDescription
        name: "LFDQueueFrameRandomScrollFrameChildFrameDescription"
        text: "Using the Dungeon Finder to do a Random Dungeon will earn you extra rewards."
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameTitle.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameTitle.bottom
        anchors.topMargin: 5
        width: 280
        height: 25.3
    }

    Button {
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription.bottom
        anchors.topMargin: 10
        width: 147
        height: 41
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1Count
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Count"
        text: "2"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture.right
        anchors.rightMargin: 1
        anchors.bottom: lFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture.bottom
        anchors.bottomMargin: 1
        width: 10.3
        height: 14.2
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameItem1Name
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Name"
        text: "Emblem of Conquest"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame.verticalCenter
        width: 90
        height: 36
    }

    Frame {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrame
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.verticalCenter
        width: 80.9
        height: 28
    }

    Button {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
        text: "22"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.verticalCenter
        width: 32
        height: 19
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText"
        text: "22"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton.verticalCenter
        width: 19
        height: 15.8
    }

    Button {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
        text: "20"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton.right
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton.verticalCenter
        width: 32
        height: 19
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButtonText
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButtonText"
        text: "20"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
        anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.verticalCenter
        width: 19
        height: 15.8
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyLabel"
        text: "Money:"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameItem1.left
        anchors.leftMargin: 20
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameItem1.bottom
        anchors.topMargin: 10
        width: 49
        height: 12.6
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription
        name: "LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription"
        text: "The first random dungeon that you complete each day will earn you:"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameRewardsLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameRewardsLabel.bottom
        anchors.topMargin: 5
        width: 280
        height: 25.3
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameRewardsLabel
        name: "LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel"
        text: "Rewards"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameDescription.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameDescription.bottom
        anchors.topMargin: 10
        width: 84.5
        height: 15.8
    }

    Frame {
        id: lFDQueueFrameRandomScrollFrameChildFrameSpacer
        name: "LFDQueueFrameRandomScrollFrameChildFrameSpacer"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.bottom
        anchors.topMargin: 10
        width: 2
        height: 2
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameTitle
        name: "LFDQueueFrameRandomScrollFrameChildFrameTitle"
        text: "Random Dungeon"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrame.left
        anchors.leftMargin: 10
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrame.top
        anchors.topMargin: 15
        width: 171.5
        height: 15.8
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameXPAmount
        name: "LFDQueueFrameRandomScrollFrameChildFrameXPAmount"
        text: "16000"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameXPLabel.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameXPLabel.verticalCenter
        width: 42.7
        height: 15.8
    }

    FontString {
        id: lFDQueueFrameRandomScrollFrameChildFrameXPLabel
        name: "LFDQueueFrameRandomScrollFrameChildFrameXPLabel"
        text: "Experience:"
        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.left
        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.bottom
        anchors.topMargin: 5
        width: 74.3
        height: 12.6
    }

    Frame {
        id: lFDQueueFrameRandomScrollFrameDiabolicZone
        name: "LFDQueueFrameRandomScrollFrameDiabolicZone"
        wowParent: "LFDQueueFrameRandom"
        anchors.left: lFDQueueFrameRandomScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: lFDQueueFrameRandomScrollFrame.top
        anchors.topMargin: -6
        width: 332
        height: 277
    }

    Button {
        id: lFDQueueFrameRoleButtonDPS
        name: "LFDQueueFrameRoleButtonDPS"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrameRoleButtonHealer.right
        anchors.leftMargin: 23
        anchors.verticalCenter: lFDQueueFrameRoleButtonHealer.verticalCenter
        width: 48
        height: 48
    }

    Button {
        id: lFDQueueFrameRoleButtonHealer
        name: "LFDQueueFrameRoleButtonHealer"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrameRoleButtonTank.right
        anchors.leftMargin: 25
        anchors.verticalCenter: lFDQueueFrameRoleButtonTank.verticalCenter
        width: 48
        height: 48
    }

    Button {
        id: lFDQueueFrameRoleButtonLeader
        name: "LFDQueueFrameRoleButtonLeader"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDQueueFrameRoleButtonDPS.right
        anchors.leftMargin: 32
        anchors.verticalCenter: lFDQueueFrameRoleButtonDPS.verticalCenter
        width: 48
        height: 48
    }

    Button {
        id: lFDQueueFrameRoleButtonTank
        name: "LFDQueueFrameRoleButtonTank"
        wowParent: "LFDQueueFrame"
        anchors.left: lFDParentFrameDiabolic.horizontalCenter
        anchors.leftMargin: -136
        anchors.top: lFDParentFrameDiabolic.top
        anchors.topMargin: 72
        width: 48
        height: 48
    }

    Frame {
        id: lFDQueueFrameSpecific
        name: "LFDQueueFrameSpecific"
        wowParent: "LFDQueueFrame"
        pin: "place"
        anchors.left: lFDQueueFrame.left
        anchors.top: lFDQueueFrame.top
        anchors.topMargin: -62
        anchors.right: lFDQueueFrame.right
        anchors.bottom: lFDQueueFrame.bottom
        anchors.bottomMargin: 46
        width: 355
        height: 456
    }

    Frame {
        id: lFDQueueFrameSpecificListButton1
        name: "LFDQueueFrameSpecificListButton1"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecific.left
        anchors.leftMargin: 25
        anchors.top: lFDQueueFrameSpecific.top
        anchors.topMargin: 165
        width: 295
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton10
        name: "LFDQueueFrameSpecificListButton10"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton9.left
        anchors.top: lFDQueueFrameSpecificListButton9.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton10EnableButton
        name: "LFDQueueFrameSpecificListButton10EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton10"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton10LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton10LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton10InstanceLevel
        name: "LFDQueueFrameSpecificListButton10InstanceLevel"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton10"
        anchors.right: lFDQueueFrameSpecificListButton10.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton10.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton10InstanceName
        name: "LFDQueueFrameSpecificListButton10InstanceName"
        text: "The Culling of Stratholme"
        wowParent: "LFDQueueFrameSpecificListButton10"
        anchors.left: lFDQueueFrameSpecificListButton10.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton10.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton11
        name: "LFDQueueFrameSpecificListButton11"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton10.left
        anchors.top: lFDQueueFrameSpecificListButton10.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton11EnableButton
        name: "LFDQueueFrameSpecificListButton11EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton11"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton11LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton11LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton11InstanceLevel
        name: "LFDQueueFrameSpecificListButton11InstanceLevel"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton11"
        anchors.right: lFDQueueFrameSpecificListButton11.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton11.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton11InstanceName
        name: "LFDQueueFrameSpecificListButton11InstanceName"
        text: "The Oculus"
        wowParent: "LFDQueueFrameSpecificListButton11"
        anchors.left: lFDQueueFrameSpecificListButton11.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton11.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton12
        name: "LFDQueueFrameSpecificListButton12"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton11.left
        anchors.top: lFDQueueFrameSpecificListButton11.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton12EnableButton
        name: "LFDQueueFrameSpecificListButton12EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton12"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton12LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton12LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton12InstanceLevel
        name: "LFDQueueFrameSpecificListButton12InstanceLevel"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton12"
        anchors.right: lFDQueueFrameSpecificListButton12.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton12.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton12InstanceName
        name: "LFDQueueFrameSpecificListButton12InstanceName"
        text: "Utgarde Pinnacle"
        wowParent: "LFDQueueFrameSpecificListButton12"
        anchors.left: lFDQueueFrameSpecificListButton12.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton12.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton13
        name: "LFDQueueFrameSpecificListButton13"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton12.left
        anchors.top: lFDQueueFrameSpecificListButton12.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton13EnableButton
        name: "LFDQueueFrameSpecificListButton13EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton13"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton13LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton13LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton13InstanceLevel
        name: "LFDQueueFrameSpecificListButton13InstanceLevel"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton13"
        anchors.right: lFDQueueFrameSpecificListButton13.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton13.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton13InstanceName
        name: "LFDQueueFrameSpecificListButton13InstanceName"
        text: "Halls of Reflection"
        wowParent: "LFDQueueFrameSpecificListButton13"
        anchors.left: lFDQueueFrameSpecificListButton13.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton13.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton14
        name: "LFDQueueFrameSpecificListButton14"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton13.left
        anchors.top: lFDQueueFrameSpecificListButton13.bottom
        width: 295
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton14InstanceLevel
        name: "LFDQueueFrameSpecificListButton14InstanceLevel"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton14"
        anchors.right: lFDQueueFrameSpecificListButton14.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton14.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton14InstanceName
        name: "LFDQueueFrameSpecificListButton14InstanceName"
        text: "Pit of Saron"
        wowParent: "LFDQueueFrameSpecificListButton14"
        anchors.left: lFDQueueFrameSpecificListButton14.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton14.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton15
        name: "LFDQueueFrameSpecificListButton15"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton14.left
        anchors.top: lFDQueueFrameSpecificListButton14.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton15EnableButton
        name: "LFDQueueFrameSpecificListButton15EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton15"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton15LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton15LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton15InstanceLevel
        name: "LFDQueueFrameSpecificListButton15InstanceLevel"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton15"
        anchors.right: lFDQueueFrameSpecificListButton15.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton15.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton15InstanceName
        name: "LFDQueueFrameSpecificListButton15InstanceName"
        text: "The Forge of Souls"
        wowParent: "LFDQueueFrameSpecificListButton15"
        anchors.left: lFDQueueFrameSpecificListButton15.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton15.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton16
        name: "LFDQueueFrameSpecificListButton16"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton15.left
        anchors.top: lFDQueueFrameSpecificListButton15.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton16EnableButton
        name: "LFDQueueFrameSpecificListButton16EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton16"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton16LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton16LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton16InstanceLevel
        name: "LFDQueueFrameSpecificListButton16InstanceLevel"
        text: "(80)"
        wowParent: "LFDQueueFrameSpecificListButton16"
        anchors.right: lFDQueueFrameSpecificListButton16.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton16.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton16InstanceName
        name: "LFDQueueFrameSpecificListButton16InstanceName"
        text: "Trial of the Champion"
        wowParent: "LFDQueueFrameSpecificListButton16"
        anchors.left: lFDQueueFrameSpecificListButton16.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton16.verticalCenter
        width: 185
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton1EnableButton
        name: "LFDQueueFrameSpecificListButton1EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton1LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Button {
        id: lFDQueueFrameSpecificListButton1ExpandOrCollapseButton
        name: "LFDQueueFrameSpecificListButton1ExpandOrCollapseButton"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: lFDQueueFrameSpecificListButton1InstanceLevel
        name: "LFDQueueFrameSpecificListButton1InstanceLevel"
        text: "(69 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.right: lFDQueueFrameSpecificListButton1.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton1InstanceName
        name: "LFDQueueFrameSpecificListButton1InstanceName"
        text: "The Nexus"
        wowParent: "LFDQueueFrameSpecificListButton1"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton1.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton2
        name: "LFDQueueFrameSpecificListButton2"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.top: lFDQueueFrameSpecificListButton1.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton2EnableButton
        name: "LFDQueueFrameSpecificListButton2EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton2"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton2LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton2LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton2InstanceLevel
        name: "LFDQueueFrameSpecificListButton2InstanceLevel"
        text: "(68 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton2"
        anchors.right: lFDQueueFrameSpecificListButton2.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton2.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton2InstanceName
        name: "LFDQueueFrameSpecificListButton2InstanceName"
        text: "Utgarde Keep"
        wowParent: "LFDQueueFrameSpecificListButton2"
        anchors.left: lFDQueueFrameSpecificListButton2.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton2.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton3
        name: "LFDQueueFrameSpecificListButton3"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton2.left
        anchors.top: lFDQueueFrameSpecificListButton2.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton3EnableButton
        name: "LFDQueueFrameSpecificListButton3EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton3"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton3LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton3LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton3InstanceLevel
        name: "LFDQueueFrameSpecificListButton3InstanceLevel"
        text: "(71 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton3"
        anchors.right: lFDQueueFrameSpecificListButton3.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton3.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton3InstanceName
        name: "LFDQueueFrameSpecificListButton3InstanceName"
        text: "Ahn'kahet: The Old Kingdom"
        wowParent: "LFDQueueFrameSpecificListButton3"
        anchors.left: lFDQueueFrameSpecificListButton3.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton3.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton4
        name: "LFDQueueFrameSpecificListButton4"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton3.left
        anchors.top: lFDQueueFrameSpecificListButton3.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton4EnableButton
        name: "LFDQueueFrameSpecificListButton4EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton4"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton4LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton4LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton4InstanceLevel
        name: "LFDQueueFrameSpecificListButton4InstanceLevel"
        text: "(70 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton4"
        anchors.right: lFDQueueFrameSpecificListButton4.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton4.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton4InstanceName
        name: "LFDQueueFrameSpecificListButton4InstanceName"
        text: "Azjol-Nerub"
        wowParent: "LFDQueueFrameSpecificListButton4"
        anchors.left: lFDQueueFrameSpecificListButton4.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton4.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton5
        name: "LFDQueueFrameSpecificListButton5"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton4.left
        anchors.top: lFDQueueFrameSpecificListButton4.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton5EnableButton
        name: "LFDQueueFrameSpecificListButton5EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton5"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton5LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton5LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton5InstanceLevel
        name: "LFDQueueFrameSpecificListButton5InstanceLevel"
        text: "(72 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton5"
        anchors.right: lFDQueueFrameSpecificListButton5.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton5.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton5InstanceName
        name: "LFDQueueFrameSpecificListButton5InstanceName"
        text: "Drak'Tharon Keep"
        wowParent: "LFDQueueFrameSpecificListButton5"
        anchors.left: lFDQueueFrameSpecificListButton5.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton5.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton6
        name: "LFDQueueFrameSpecificListButton6"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton5.left
        anchors.top: lFDQueueFrameSpecificListButton5.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton6EnableButton
        name: "LFDQueueFrameSpecificListButton6EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton6"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton6LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton6LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton6InstanceLevel
        name: "LFDQueueFrameSpecificListButton6InstanceLevel"
        text: "(73 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton6"
        anchors.right: lFDQueueFrameSpecificListButton6.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton6.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton6InstanceName
        name: "LFDQueueFrameSpecificListButton6InstanceName"
        text: "Violet Hold"
        wowParent: "LFDQueueFrameSpecificListButton6"
        anchors.left: lFDQueueFrameSpecificListButton6.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton6.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton7
        name: "LFDQueueFrameSpecificListButton7"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton6.left
        anchors.top: lFDQueueFrameSpecificListButton6.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton7EnableButton
        name: "LFDQueueFrameSpecificListButton7EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton7"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton7LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton7LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton7InstanceLevel
        name: "LFDQueueFrameSpecificListButton7InstanceLevel"
        text: "(74 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton7"
        anchors.right: lFDQueueFrameSpecificListButton7.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton7.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton7InstanceName
        name: "LFDQueueFrameSpecificListButton7InstanceName"
        text: "Gundrak"
        wowParent: "LFDQueueFrameSpecificListButton7"
        anchors.left: lFDQueueFrameSpecificListButton7.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton7.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton8
        name: "LFDQueueFrameSpecificListButton8"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton7.left
        anchors.top: lFDQueueFrameSpecificListButton7.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton8EnableButton
        name: "LFDQueueFrameSpecificListButton8EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton8"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton8LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton8LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton8InstanceLevel
        name: "LFDQueueFrameSpecificListButton8InstanceLevel"
        text: "(75 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton8"
        anchors.right: lFDQueueFrameSpecificListButton8.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton8.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton8InstanceName
        name: "LFDQueueFrameSpecificListButton8InstanceName"
        text: "Halls of Stone"
        wowParent: "LFDQueueFrameSpecificListButton8"
        anchors.left: lFDQueueFrameSpecificListButton8.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton8.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListButton9
        name: "LFDQueueFrameSpecificListButton9"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton8.left
        anchors.top: lFDQueueFrameSpecificListButton8.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFDQueueFrameSpecificListButton9EnableButton
        name: "LFDQueueFrameSpecificListButton9EnableButton"
        wowParent: "LFDQueueFrameSpecificListButton9"
        anchors.horizontalCenter: lFDQueueFrameSpecificListButton9LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFDQueueFrameSpecificListButton9LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFDQueueFrameSpecificListButton9InstanceLevel
        name: "LFDQueueFrameSpecificListButton9InstanceLevel"
        text: "(77 - 80)"
        wowParent: "LFDQueueFrameSpecificListButton9"
        anchors.right: lFDQueueFrameSpecificListButton9.right
        anchors.verticalCenter: lFDQueueFrameSpecificListButton9.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFDQueueFrameSpecificListButton9InstanceName
        name: "LFDQueueFrameSpecificListButton9InstanceName"
        text: "Halls of Lightning"
        wowParent: "LFDQueueFrameSpecificListButton9"
        anchors.left: lFDQueueFrameSpecificListButton9.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFDQueueFrameSpecificListButton9.verticalCenter
        width: 185
        height: 16
    }

    ScrollFrame {
        id: lFDQueueFrameSpecificListScrollFrame
        name: "LFDQueueFrameSpecificListScrollFrame"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListButton1.left
        anchors.top: lFDQueueFrameSpecificListButton1.top
        anchors.topMargin: -7
        width: 296
        height: 270
    }

    Frame {
        id: lFDQueueFrameSpecificListScrollFrameDiabolicZone
        name: "LFDQueueFrameSpecificListScrollFrameDiabolicZone"
        wowParent: "LFDQueueFrameSpecific"
        anchors.left: lFDQueueFrameSpecificListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: lFDQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 282
    }

    Slider {
        id: lFDQueueFrameSpecificListScrollFrameScrollBar
        name: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        wowParent: "LFDQueueFrameSpecificListScrollFrame"
        style: "ScrollBar"
        anchors.left: lFDQueueFrameSpecificListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: lFDQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 238
    }

    Frame {
        id: lFDQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack
        name: "LFDQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
        wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 272
    }

    Button {
        id: lFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton
        name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
        wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.top: lFDQueueFrameSpecificListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton
        name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
        wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: lFDQueueFrameSpecificListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: lFDQueueFrameSpecificListScrollFrameScrollChildFrame
        name: "LFDQueueFrameSpecificListScrollFrameScrollChildFrame"
        wowParent: "LFDQueueFrameSpecificListScrollFrame"
        anchors.left: lFDQueueFrameSpecificListScrollFrame.left
        anchors.top: lFDQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: -288
        width: 300
        height: 544
    }

    FontString {
        id: lFDQueueFrameTitleText
        name: "LFDQueueFrameTitleText"
        text: "Dungeon Finder"
        wowParent: "LFDParentFrameDiabolicTitlePlate"
        anchors.horizontalCenter: lFDParentFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: lFDParentFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 144.6
        height: 14.2
    }

    Frame {
        id: lFDQueueFrameTypeDropDown
        name: "LFDQueueFrameTypeDropDown"
        wowParent: "LFDQueueFrame"
        style: "DropDown"
        anchors.left: lFDParentFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: lFDParentFrameDiabolicBand.verticalCenter
        width: 280
        height: 32
    }

    Button {
        id: lFDQueueFrameTypeDropDownButton
        name: "LFDQueueFrameTypeDropDownButton"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.right: lFDQueueFrameTypeDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: lFDQueueFrameTypeDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: lFDQueueFrameTypeDropDownDiabolicField
        name: "LFDQueueFrameTypeDropDownDiabolicField"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.left: lFDQueueFrameTypeDropDown.left
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        width: 280
        height: 22
    }

    FontString {
        id: lFDQueueFrameTypeDropDownName
        name: "LFDQueueFrameTypeDropDownName"
        text: "Type:"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.right: lFDQueueFrameTypeDropDown.left
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 115
        height: 24
    }

    FontString {
        id: lFDQueueFrameTypeDropDownText
        name: "LFDQueueFrameTypeDropDownText"
        text: "Random Lich King Heroic"
        wowParent: "LFDQueueFrameTypeDropDown"
        anchors.horizontalCenter: lFDQueueFrameTypeDropDown.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: lFDQueueFrameTypeDropDown.verticalCenter
        width: 205
        height: 10
    }

    // kept as they are, at the foot's ends
    WowRow {
        name: "LFDButtons"
        parts: ["LFDQueueFrameFindGroupButton", "LFDQueueFrameCancelButton"]
        fit: "ends"
        anchors.left: lFDParentFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: lFDParentFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: lFDParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture; name: "LFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture"; x: 72; y: 261.1; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame; name: "LFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame"; x: 62; y: 241.6; width: 0; height: 0 }
    Ghost { id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton; name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton"; x: 180; y: 279.5; width: 0; height: 0 }
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
