// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: lFRParentFrame
    name: "LFRParentFrame"
    width: 355
    height: 440

    Part {
        id: lFRBrowseFrame
        name: "LFRBrowseFrame"
        kind: "Frame"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrame.left
        anchors.top: lFRParentFrame.top
        width: 355
        height: 440
    }

    Part {
        id: lFRBrowseFrameColumnHeader1
        name: "LFRBrowseFrameColumnHeader1"
        kind: "Button"
        text: "Name"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrame.left
        anchors.leftMargin: 26
        anchors.top: lFRBrowseFrame.top
        anchors.topMargin: 40
        width: 97
        height: 22
    }

    Part {
        id: lFRBrowseFrameColumnHeader2
        name: "LFRBrowseFrameColumnHeader2"
        kind: "Button"
        text: "Lvl"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader1.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader1.verticalCenter
        width: 34
        height: 22
    }

    Part {
        id: lFRBrowseFrameColumnHeader3
        name: "LFRBrowseFrameColumnHeader3"
        kind: "Button"
        text: "Class"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader2.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader2.verticalCenter
        width: 80
        height: 22
    }

    Part {
        id: lFRBrowseFrameColumnHeader4
        name: "LFRBrowseFrameColumnHeader4"
        kind: "Button"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader3.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader3.verticalCenter
        width: 25
        height: 22
    }

    Part {
        id: lFRBrowseFrameColumnHeader5
        name: "LFRBrowseFrameColumnHeader5"
        kind: "Button"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader4.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader4.verticalCenter
        width: 25
        height: 22
    }

    Part {
        id: lFRBrowseFrameColumnHeader6
        name: "LFRBrowseFrameColumnHeader6"
        kind: "Button"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader5.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader5.verticalCenter
        width: 25
        height: 22
    }

    Part {
        id: lFRBrowseFrameColumnHeader7
        name: "LFRBrowseFrameColumnHeader7"
        kind: "Button"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader6.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader6.verticalCenter
        width: 25
        height: 22
    }

    Part {
        id: lFRBrowseFrameInviteButton
        name: "LFRBrowseFrameInviteButton"
        kind: "Button"
        text: "Invite"
        wowParent: "LFRBrowseFrame"
        anchors.right: lFRParentFrame.right
        anchors.rightMargin: 115
        anchors.bottom: lFRParentFrame.bottom
        anchors.bottomMargin: -6
        width: 98.1
        height: 22
    }

    Part {
        id: lFRBrowseFrameInviteButtonText
        name: "LFRBrowseFrameInviteButtonText"
        kind: "FontString"
        text: "Invite"
        wowParent: "LFRBrowseFrameInviteButton"
        anchors.horizontalCenter: lFRBrowseFrameInviteButton.horizontalCenter
        anchors.verticalCenter: lFRBrowseFrameInviteButton.verticalCenter
        width: 45.8
        height: 11.9
    }

    Part {
        id: lFRBrowseFrameListScrollFrameDiabolicZone
        name: "LFRBrowseFrameListScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "LFRBrowseFrame"
        anchors.horizontalCenter: lFRBrowseFrameListScrollFrame.horizontalCenter
        anchors.top: lFRBrowseFrameListScrollFrame.top
        anchors.topMargin: -4
        width: 330
        height: 332
    }

    Part {
        id: lFRBrowseFrameListScrollFrameDiabolicZoneColumnBar
        name: "LFRBrowseFrameListScrollFrameDiabolicZoneColumnBar"
        kind: "Frame"
        wowParent: "LFRBrowseFrameListScrollFrameDiabolicZone"
        anchors.left: lFRBrowseFrameListScrollFrameDiabolicZone.left
        anchors.bottom: lFRBrowseFrameListScrollFrameDiabolicZone.top
        width: 330
        height: 22
    }

    Part {
        id: lFRBrowseFrameRaidDropDown
        name: "LFRBrowseFrameRaidDropDown"
        kind: "Frame"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameRaidDropDownName.right
        anchors.leftMargin: -4
        anchors.verticalCenter: lFRBrowseFrameRaidDropDownName.verticalCenter
        width: 190
        height: 32
    }

    Part {
        id: lFRBrowseFrameRaidDropDownButton
        name: "LFRBrowseFrameRaidDropDownButton"
        kind: "Button"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.right: lFRBrowseFrameRaidDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: lFRBrowseFrameRaidDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: lFRBrowseFrameRaidDropDownDiabolicField
        name: "LFRBrowseFrameRaidDropDownDiabolicField"
        kind: "Frame"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.left: lFRBrowseFrameRaidDropDown.left
        anchors.verticalCenter: lFRBrowseFrameRaidDropDown.verticalCenter
        width: 190
        height: 22
    }

    Part {
        id: lFRBrowseFrameRaidDropDownName
        name: "LFRBrowseFrameRaidDropDownName"
        kind: "FontString"
        text: "Browsing:"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.left: lFRParentFrameDiabolicBand.left
        anchors.leftMargin: 10
        anchors.verticalCenter: lFRParentFrameDiabolicBand.verticalCenter
        width: 55.3
        height: 12
    }

    Part {
        id: lFRBrowseFrameRaidDropDownText
        name: "LFRBrowseFrameRaidDropDownText"
        kind: "FontString"
        text: "None"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.left: lFRBrowseFrameRaidDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: lFRBrowseFrameRaidDropDownDiabolicField.verticalCenter
        width: 128
        height: 10
    }

    Part {
        id: lFRBrowseFrameRefreshButton
        name: "LFRBrowseFrameRefreshButton"
        kind: "Button"
        text: "Refresh"
        wowParent: "LFRBrowseFrame"
        anchors.right: lFRParentFrame.right
        anchors.rightMargin: 7
        anchors.bottom: lFRParentFrame.bottom
        anchors.bottomMargin: -6
        width: 102
        height: 22
    }

    Part {
        id: lFRBrowseFrameRefreshButtonText
        name: "LFRBrowseFrameRefreshButtonText"
        kind: "FontString"
        text: "Refresh"
        wowParent: "LFRBrowseFrameRefreshButton"
        anchors.horizontalCenter: lFRBrowseFrameRefreshButton.horizontalCenter
        anchors.verticalCenter: lFRBrowseFrameRefreshButton.verticalCenter
        width: 55.3
        height: 11.9
    }

    Part {
        id: lFRBrowseFrameSendMessageButton
        name: "LFRBrowseFrameSendMessageButton"
        kind: "Button"
        text: "Send Message"
        wowParent: "LFRBrowseFrame"
        anchors.right: lFRParentFrame.right
        anchors.rightMargin: 219.1
        anchors.bottom: lFRParentFrame.bottom
        anchors.bottomMargin: -6
        width: 110.9
        height: 22
    }

    Part {
        id: lFRBrowseFrameSendMessageButtonText
        name: "LFRBrowseFrameSendMessageButtonText"
        kind: "FontString"
        text: "Send Message"
        wowParent: "LFRBrowseFrameSendMessageButton"
        anchors.horizontalCenter: lFRBrowseFrameSendMessageButton.horizontalCenter
        anchors.verticalCenter: lFRBrowseFrameSendMessageButton.verticalCenter
        width: 98
        height: 11.9
    }

    Part {
        id: lFRBrowseFrameTitleText
        name: "LFRBrowseFrameTitleText"
        kind: "FontString"
        text: "Raid Browser"
        wowParent: "LFRBrowseFrame"
        anchors.horizontalCenter: lFRBrowseFrame.horizontalCenter
        anchors.horizontalCenterOffset: 12
        anchors.top: lFRBrowseFrame.top
        anchors.topMargin: 18
        width: 79.8
        height: 11.9
    }

    Part {
        id: lFRParentFrameDiabolic
        name: "LFRParentFrameDiabolic"
        kind: "Frame"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrame.left
        anchors.leftMargin: -16
        anchors.top: lFRParentFrame.top
        anchors.topMargin: -68
        width: 370
        height: 544
    }

    Part {
        id: lFRParentFrameDiabolicBand
        name: "LFRParentFrameDiabolicBand"
        kind: "Frame"
        wowParent: "LFRParentFrameDiabolic"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 56
        width: 322
        height: 40
    }

    Part {
        id: lFRParentFrameDiabolicBorder
        name: "LFRParentFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "LFRParentFrameDiabolic"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 32
        width: 370
        height: 512
    }

    Part {
        id: lFRParentFrameDiabolicFoot
        name: "LFRParentFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "LFRParentFrameDiabolic"
        anchors.horizontalCenter: lFRQueueFrameFindGroupButton.horizontalCenter
        anchors.horizontalCenterOffset: 85.5
        anchors.top: lFRQueueFrameFindGroupButton.top
        anchors.topMargin: -6
        width: 324
        height: 35
    }

    Part {
        id: lFRParentFrameDiabolicRail
        name: "LFRParentFrameDiabolicRail"
        kind: "Frame"
        wowParent: "LFRParentFrameDiabolic"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: lFRParentFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Part {
        id: lFRParentFrameDiabolicSocket
        name: "LFRParentFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "LFRParentFrameDiabolic"
        anchors.right: lFRParentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: lFRParentFrameDiabolicTitlePlate
        name: "LFRParentFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "LFRParentFrameDiabolic"
        anchors.horizontalCenter: lFRParentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: lFRParentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: lFRParentFrameTab1
        name: "LFRParentFrameTab1"
        kind: "Button"
        text: "Choose Raid"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: lFRParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: lFRParentFrameTab2
        name: "LFRParentFrameTab2"
        kind: "Button"
        text: "Browse"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: lFRParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: lFRQueueFrame
        name: "LFRQueueFrame"
        kind: "Frame"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrame.left
        anchors.top: lFRParentFrame.top
        width: 355
        height: 440
    }

    Part {
        id: lFRQueueFrameAcceptCommentButton
        name: "LFRQueueFrameAcceptCommentButton"
        kind: "Button"
        text: "Set Comment"
        wowParent: "LFRQueueFrame"
        anchors.right: lFRQueueFrame.right
        anchors.rightMargin: 21
        anchors.bottom: lFRQueueFrame.bottom
        anchors.bottomMargin: -6
        width: 115
        height: 22
    }

    Part {
        id: lFRQueueFrameAcceptCommentButtonText
        name: "LFRQueueFrameAcceptCommentButtonText"
        kind: "FontString"
        text: "Set Comment"
        wowParent: "LFRQueueFrameAcceptCommentButton"
        anchors.horizontalCenter: lFRQueueFrameAcceptCommentButton.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameAcceptCommentButton.verticalCenter
        width: 96.4
        height: 11.9
    }

    Part {
        id: lFRQueueFrameComment
        name: "LFRQueueFrameComment"
        kind: "EditBox"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRParentFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: lFRParentFrameDiabolicBand.verticalCenter
        width: 250
        height: 20
    }

    Part {
        id: lFRQueueFrameCommentDiabolicField
        name: "LFRQueueFrameCommentDiabolicField"
        kind: "Frame"
        wowParent: "LFRQueueFrameComment"
        anchors.left: lFRQueueFrameComment.left
        anchors.leftMargin: -8
        anchors.verticalCenter: lFRQueueFrameComment.verticalCenter
        width: 266
        height: 22
    }

    Part {
        id: lFRQueueFrameCommentExplanation
        name: "LFRQueueFrameCommentExplanation"
        kind: "FontString"
        text: "Type your comment here."
        wowParent: "LFRQueueFrameComment"
        anchors.left: lFRQueueFrameComment.left
        anchors.top: lFRQueueFrameComment.top
        width: 250
        height: 20
    }

    Part {
        id: lFRQueueFrameCommentTextButton
        name: "LFRQueueFrameCommentTextButton"
        kind: "Button"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrameComment.left
        anchors.top: lFRQueueFrameComment.top
        width: 250
        height: 20
    }

    Part {
        id: lFRQueueFrameFindGroupButton
        name: "LFRQueueFrameFindGroupButton"
        kind: "Button"
        text: "List My Name"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrame.left
        anchors.leftMargin: 21
        anchors.bottom: lFRQueueFrame.bottom
        anchors.bottomMargin: -6
        width: 125
        height: 22
    }

    Part {
        id: lFRQueueFrameFindGroupButtonText
        name: "LFRQueueFrameFindGroupButtonText"
        kind: "FontString"
        text: "List My Name"
        wowParent: "LFRQueueFrameFindGroupButton"
        anchors.horizontalCenter: lFRQueueFrameFindGroupButton.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameFindGroupButton.verticalCenter
        width: 97.2
        height: 11.9
    }

    Part {
        id: lFRQueueFrameRoleButtonDPS
        name: "LFRQueueFrameRoleButtonDPS"
        kind: "Button"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrameRoleButtonHealer.right
        anchors.leftMargin: 43
        anchors.verticalCenter: lFRQueueFrameRoleButtonHealer.verticalCenter
        width: 48
        height: 48
    }

    Part {
        id: lFRQueueFrameRoleButtonHealer
        name: "LFRQueueFrameRoleButtonHealer"
        kind: "Button"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrameRoleButtonTank.right
        anchors.leftMargin: 45
        anchors.verticalCenter: lFRQueueFrameRoleButtonTank.verticalCenter
        width: 48
        height: 48
    }

    Part {
        id: lFRQueueFrameRoleButtonTank
        name: "LFRQueueFrameRoleButtonTank"
        kind: "Button"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRParentFrameDiabolic.horizontalCenter
        anchors.leftMargin: -116
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 128
        width: 48
        height: 48
    }

    Part {
        id: lFRQueueFrameSpecific
        name: "LFRQueueFrameSpecific"
        kind: "Frame"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrame.left
        anchors.top: lFRQueueFrame.top
        width: 355
        height: 440
    }

    Part {
        id: lFRQueueFrameSpecificListButton1
        name: "LFRQueueFrameSpecificListButton1"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecific.left
        anchors.leftMargin: 17
        anchors.top: lFRQueueFrameSpecific.top
        anchors.topMargin: 132
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton10
        name: "LFRQueueFrameSpecificListButton10"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton9.left
        anchors.top: lFRQueueFrameSpecificListButton9.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton10EnableButton
        name: "LFRQueueFrameSpecificListButton10EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton10"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton10LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton10LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton10InstanceLevel
        name: "LFRQueueFrameSpecificListButton10InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton10"
        anchors.right: lFRQueueFrameSpecificListButton10.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton10.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton10InstanceName
        name: "LFRQueueFrameSpecificListButton10InstanceName"
        kind: "FontString"
        text: "Ulduar"
        wowParent: "LFRQueueFrameSpecificListButton10"
        anchors.left: lFRQueueFrameSpecificListButton10.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton10.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton11
        name: "LFRQueueFrameSpecificListButton11"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton10.left
        anchors.top: lFRQueueFrameSpecificListButton10.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton11EnableButton
        name: "LFRQueueFrameSpecificListButton11EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton11"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton11LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton11LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton11InstanceLevel
        name: "LFRQueueFrameSpecificListButton11InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton11"
        anchors.right: lFRQueueFrameSpecificListButton11.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton11.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton11InstanceName
        name: "LFRQueueFrameSpecificListButton11InstanceName"
        kind: "FontString"
        text: "Vault of Archavon"
        wowParent: "LFRQueueFrameSpecificListButton11"
        anchors.left: lFRQueueFrameSpecificListButton11.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton11.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton12
        name: "LFRQueueFrameSpecificListButton12"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton11.left
        anchors.top: lFRQueueFrameSpecificListButton11.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton12EnableButton
        name: "LFRQueueFrameSpecificListButton12EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton12LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton12ExpandOrCollapseButton
        name: "LFRQueueFrameSpecificListButton12ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.left: lFRQueueFrameSpecificListButton12.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: lFRQueueFrameSpecificListButton12InstanceName
        name: "LFRQueueFrameSpecificListButton12InstanceName"
        kind: "FontString"
        text: "Wrath of the Lich King Raid (10)"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.left: lFRQueueFrameSpecificListButton12.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12.verticalCenter
        width: 255
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton13
        name: "LFRQueueFrameSpecificListButton13"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton12.left
        anchors.top: lFRQueueFrameSpecificListButton12.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton13InstanceLevel
        name: "LFRQueueFrameSpecificListButton13InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton13"
        anchors.right: lFRQueueFrameSpecificListButton13.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton13.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton13InstanceName
        name: "LFRQueueFrameSpecificListButton13InstanceName"
        kind: "FontString"
        text: "Icecrown Citadel"
        wowParent: "LFRQueueFrameSpecificListButton13"
        anchors.left: lFRQueueFrameSpecificListButton13.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton13.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton14
        name: "LFRQueueFrameSpecificListButton14"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton13.left
        anchors.top: lFRQueueFrameSpecificListButton13.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton14EnableButton
        name: "LFRQueueFrameSpecificListButton14EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton14"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton14LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton14LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton14InstanceLevel
        name: "LFRQueueFrameSpecificListButton14InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton14"
        anchors.right: lFRQueueFrameSpecificListButton14.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton14.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton14InstanceName
        name: "LFRQueueFrameSpecificListButton14InstanceName"
        kind: "FontString"
        text: "Naxxramas"
        wowParent: "LFRQueueFrameSpecificListButton14"
        anchors.left: lFRQueueFrameSpecificListButton14.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton14.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton1EnableButton
        name: "LFRQueueFrameSpecificListButton1EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton1LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton1ExpandOrCollapseButton
        name: "LFRQueueFrameSpecificListButton1ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: lFRQueueFrameSpecificListButton1InstanceName
        name: "LFRQueueFrameSpecificListButton1InstanceName"
        kind: "FontString"
        text: "Wrath of the Lich King Raid (25)"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1.verticalCenter
        width: 255
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton2
        name: "LFRQueueFrameSpecificListButton2"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.top: lFRQueueFrameSpecificListButton1.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton2InstanceLevel
        name: "LFRQueueFrameSpecificListButton2InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton2"
        anchors.right: lFRQueueFrameSpecificListButton2.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton2.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton2InstanceName
        name: "LFRQueueFrameSpecificListButton2InstanceName"
        kind: "FontString"
        text: "Icecrown Citadel"
        wowParent: "LFRQueueFrameSpecificListButton2"
        anchors.left: lFRQueueFrameSpecificListButton2.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton2.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton3
        name: "LFRQueueFrameSpecificListButton3"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton2.left
        anchors.top: lFRQueueFrameSpecificListButton2.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton3EnableButton
        name: "LFRQueueFrameSpecificListButton3EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton3"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton3LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton3LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton3InstanceLevel
        name: "LFRQueueFrameSpecificListButton3InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton3"
        anchors.right: lFRQueueFrameSpecificListButton3.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton3.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton3InstanceName
        name: "LFRQueueFrameSpecificListButton3InstanceName"
        kind: "FontString"
        text: "Naxxramas"
        wowParent: "LFRQueueFrameSpecificListButton3"
        anchors.left: lFRQueueFrameSpecificListButton3.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton3.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton4
        name: "LFRQueueFrameSpecificListButton4"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton3.left
        anchors.top: lFRQueueFrameSpecificListButton3.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton4EnableButton
        name: "LFRQueueFrameSpecificListButton4EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton4"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton4LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton4LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton4InstanceLevel
        name: "LFRQueueFrameSpecificListButton4InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton4"
        anchors.right: lFRQueueFrameSpecificListButton4.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton4.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton4InstanceName
        name: "LFRQueueFrameSpecificListButton4InstanceName"
        kind: "FontString"
        text: "Onyxia's Lair"
        wowParent: "LFRQueueFrameSpecificListButton4"
        anchors.left: lFRQueueFrameSpecificListButton4.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton4.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton5
        name: "LFRQueueFrameSpecificListButton5"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton4.left
        anchors.top: lFRQueueFrameSpecificListButton4.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton5InstanceLevel
        name: "LFRQueueFrameSpecificListButton5InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton5"
        anchors.right: lFRQueueFrameSpecificListButton5.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton5.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton5InstanceName
        name: "LFRQueueFrameSpecificListButton5InstanceName"
        kind: "FontString"
        text: "Ruby Sanctum"
        wowParent: "LFRQueueFrameSpecificListButton5"
        anchors.left: lFRQueueFrameSpecificListButton5.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton5.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton6
        name: "LFRQueueFrameSpecificListButton6"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton5.left
        anchors.top: lFRQueueFrameSpecificListButton5.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton6EnableButton
        name: "LFRQueueFrameSpecificListButton6EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton6LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton6InstanceLevel
        name: "LFRQueueFrameSpecificListButton6InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.right: lFRQueueFrameSpecificListButton6.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton6InstanceName
        name: "LFRQueueFrameSpecificListButton6InstanceName"
        kind: "FontString"
        text: "The Eye of Eternity"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.left: lFRQueueFrameSpecificListButton6.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton7
        name: "LFRQueueFrameSpecificListButton7"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton6.left
        anchors.top: lFRQueueFrameSpecificListButton6.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton7EnableButton
        name: "LFRQueueFrameSpecificListButton7EnableButton"
        kind: "CheckButton"
        wowParent: "LFRQueueFrameSpecificListButton7"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton7LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton7LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: lFRQueueFrameSpecificListButton7InstanceLevel
        name: "LFRQueueFrameSpecificListButton7InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton7"
        anchors.right: lFRQueueFrameSpecificListButton7.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton7.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton7InstanceName
        name: "LFRQueueFrameSpecificListButton7InstanceName"
        kind: "FontString"
        text: "The Obsidian Sanctum"
        wowParent: "LFRQueueFrameSpecificListButton7"
        anchors.left: lFRQueueFrameSpecificListButton7.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton7.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton8
        name: "LFRQueueFrameSpecificListButton8"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton7.left
        anchors.top: lFRQueueFrameSpecificListButton7.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton8InstanceLevel
        name: "LFRQueueFrameSpecificListButton8InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton8"
        anchors.right: lFRQueueFrameSpecificListButton8.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton8.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton8InstanceName
        name: "LFRQueueFrameSpecificListButton8InstanceName"
        kind: "FontString"
        text: "Trial of the Crusader"
        wowParent: "LFRQueueFrameSpecificListButton8"
        anchors.left: lFRQueueFrameSpecificListButton8.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton8.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton9
        name: "LFRQueueFrameSpecificListButton9"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton8.left
        anchors.top: lFRQueueFrameSpecificListButton8.bottom
        width: 295
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton9InstanceLevel
        name: "LFRQueueFrameSpecificListButton9InstanceLevel"
        kind: "FontString"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton9"
        anchors.right: lFRQueueFrameSpecificListButton9.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton9.verticalCenter
        width: 60
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListButton9InstanceName
        name: "LFRQueueFrameSpecificListButton9InstanceName"
        kind: "FontString"
        text: "Trial of the Grand Crusader"
        wowParent: "LFRQueueFrameSpecificListButton9"
        anchors.left: lFRQueueFrameSpecificListButton9.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton9.verticalCenter
        width: 185
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrame
        name: "LFRQueueFrameSpecificListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.top: lFRQueueFrameSpecificListButton1.top
        anchors.topMargin: -2
        width: 296
        height: 228
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrameDiabolicZone
        name: "LFRQueueFrameSpecificListScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 2
        anchors.top: lFRQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 270
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrameScrollBar
        name: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "LFRQueueFrameSpecificListScrollFrame"
        anchors.left: lFRQueueFrameSpecificListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: lFRQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 196
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack
        name: "LFRQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: lFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 230
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrameScrollBarScrollDownButton
        name: "LFRQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.top: lFRQueueFrameSpecificListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton
        name: "LFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: lFRQueueFrameSpecificListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: lFRQueueFrameSpecificListScrollFrameScrollChildFrame
        name: "LFRQueueFrameSpecificListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "LFRQueueFrameSpecificListScrollFrame"
        anchors.left: lFRQueueFrameSpecificListScrollFrame.left
        anchors.top: lFRQueueFrameSpecificListScrollFrame.top
        width: 300
        height: 624
    }

    Part {
        id: lFRQueueFrameTitleText
        name: "LFRQueueFrameTitleText"
        kind: "FontString"
        text: "Raid Browser"
        wowParent: "LFRParentFrameDiabolicTitlePlate"
        anchors.horizontalCenter: lFRParentFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: lFRParentFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 120.9
        height: 14.2
    }

    Ghost { id: lFRBrowseFrameListScrollFrame; name: "LFRBrowseFrameListScrollFrame"; x: 167; y: 66; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton10LockedIndicator; name: "LFRQueueFrameSpecificListButton10LockedIndicator"; x: 48; y: 284; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton11LockedIndicator; name: "LFRQueueFrameSpecificListButton11LockedIndicator"; x: 48; y: 300; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton12LockedIndicator; name: "LFRQueueFrameSpecificListButton12LockedIndicator"; x: 48; y: 316; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton14LockedIndicator; name: "LFRQueueFrameSpecificListButton14LockedIndicator"; x: 48; y: 348; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton1LockedIndicator; name: "LFRQueueFrameSpecificListButton1LockedIndicator"; x: 48; y: 140; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton3LockedIndicator; name: "LFRQueueFrameSpecificListButton3LockedIndicator"; x: 48; y: 172; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton4LockedIndicator; name: "LFRQueueFrameSpecificListButton4LockedIndicator"; x: 48; y: 188; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton6LockedIndicator; name: "LFRQueueFrameSpecificListButton6LockedIndicator"; x: 48; y: 220; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton7LockedIndicator; name: "LFRQueueFrameSpecificListButton7LockedIndicator"; x: 48; y: 236; width: 0; height: 0 }
}
