// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: lFRParentFrame
    name: "LFRParentFrame"
    width: 355
    height: 440

    Frame {
        id: lFRBrowseFrame
        name: "LFRBrowseFrame"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrame.left
        anchors.top: lFRParentFrame.top
        width: 355
        height: 440
    }

    Button {
        id: lFRBrowseFrameColumnHeader1
        name: "LFRBrowseFrameColumnHeader1"
        text: "Name"
        wowParent: "LFRBrowseFrame"
        pin: "place"
        anchors.left: lFRBrowseFrame.left
        anchors.leftMargin: 26
        anchors.top: lFRBrowseFrame.top
        anchors.topMargin: 40
        width: 97
        height: 22
    }

    Button {
        id: lFRBrowseFrameColumnHeader2
        name: "LFRBrowseFrameColumnHeader2"
        text: "Lvl"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader1.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader1.verticalCenter
        width: 34
        height: 22
    }

    Button {
        id: lFRBrowseFrameColumnHeader3
        name: "LFRBrowseFrameColumnHeader3"
        text: "Class"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader2.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader2.verticalCenter
        width: 80
        height: 22
    }

    Button {
        id: lFRBrowseFrameColumnHeader4
        name: "LFRBrowseFrameColumnHeader4"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader3.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader3.verticalCenter
        width: 25
        height: 22
    }

    Button {
        id: lFRBrowseFrameColumnHeader5
        name: "LFRBrowseFrameColumnHeader5"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader4.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader4.verticalCenter
        width: 25
        height: 22
    }

    Button {
        id: lFRBrowseFrameColumnHeader6
        name: "LFRBrowseFrameColumnHeader6"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader5.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader5.verticalCenter
        width: 25
        height: 22
    }

    Button {
        id: lFRBrowseFrameColumnHeader7
        name: "LFRBrowseFrameColumnHeader7"
        wowParent: "LFRBrowseFrame"
        anchors.left: lFRBrowseFrameColumnHeader6.right
        anchors.leftMargin: -2
        anchors.verticalCenter: lFRBrowseFrameColumnHeader6.verticalCenter
        width: 25
        height: 22
    }

    Button {
        id: lFRBrowseFrameInviteButton
        name: "LFRBrowseFrameInviteButton"
        text: "Invite"
        wowParent: "LFRBrowseFrame"
        style: "Button"
        pin: "all"
        anchors.left: lFRBrowseFrameSendMessageButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: lFRBrowseFrameSendMessageButton.verticalCenter
        width: 74.1
        height: 22
    }

    FontString {
        id: lFRBrowseFrameInviteButtonText
        name: "LFRBrowseFrameInviteButtonText"
        text: "Invite"
        wowParent: "LFRBrowseFrameInviteButton"
        anchors.horizontalCenter: lFRBrowseFrameInviteButton.horizontalCenter
        anchors.verticalCenter: lFRBrowseFrameInviteButton.verticalCenter
        width: 45.8
        height: 11.9
    }

    Button {
        id: lFRBrowseFrameListButton1
        name: "LFRBrowseFrameListButton1"
        wowParent: "LFRBrowseFrame"
        pin: "place"
        anchors.left: lFRBrowseFrame.left
        anchors.leftMargin: 12
        anchors.top: lFRBrowseFrame.top
        anchors.topMargin: 66
        width: 298
        height: 16
    }

    Frame {
        id: lFRBrowseFrameListScrollFrameDiabolicZone
        name: "LFRBrowseFrameListScrollFrameDiabolicZone"
        wowParent: "LFRBrowseFrame"
        anchors.horizontalCenter: lFRBrowseFrameListScrollFrame.horizontalCenter
        anchors.top: lFRBrowseFrameListScrollFrame.top
        anchors.topMargin: -4
        width: 330
        height: 332
    }

    Frame {
        id: lFRBrowseFrameListScrollFrameDiabolicZoneColumnBar
        name: "LFRBrowseFrameListScrollFrameDiabolicZoneColumnBar"
        wowParent: "LFRBrowseFrameListScrollFrameDiabolicZone"
        anchors.left: lFRBrowseFrameListScrollFrameDiabolicZone.left
        anchors.bottom: lFRBrowseFrameListScrollFrameDiabolicZone.top
        width: 330
        height: 22
    }

    Frame {
        id: lFRBrowseFrameRaidDropDown
        name: "LFRBrowseFrameRaidDropDown"
        wowParent: "LFRBrowseFrame"
        style: "DropDown"
        anchors.left: lFRBrowseFrameRaidDropDownName.right
        anchors.leftMargin: -4
        anchors.verticalCenter: lFRBrowseFrameRaidDropDownName.verticalCenter
        width: 190
        height: 32
    }

    Button {
        id: lFRBrowseFrameRaidDropDownButton
        name: "LFRBrowseFrameRaidDropDownButton"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.right: lFRBrowseFrameRaidDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: lFRBrowseFrameRaidDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: lFRBrowseFrameRaidDropDownDiabolicField
        name: "LFRBrowseFrameRaidDropDownDiabolicField"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.left: lFRBrowseFrameRaidDropDown.left
        anchors.verticalCenter: lFRBrowseFrameRaidDropDown.verticalCenter
        width: 190
        height: 22
    }

    FontString {
        id: lFRBrowseFrameRaidDropDownName
        name: "LFRBrowseFrameRaidDropDownName"
        text: "Browsing:"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.left: lFRParentFrameDiabolicBand.left
        anchors.leftMargin: 10
        anchors.verticalCenter: lFRParentFrameDiabolicBand.verticalCenter
        width: 55.3
        height: 12
    }

    FontString {
        id: lFRBrowseFrameRaidDropDownText
        name: "LFRBrowseFrameRaidDropDownText"
        text: "None"
        wowParent: "LFRBrowseFrameRaidDropDown"
        anchors.left: lFRBrowseFrameRaidDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: lFRBrowseFrameRaidDropDownDiabolicField.verticalCenter
        width: 128
        height: 10
    }

    Button {
        id: lFRBrowseFrameRefreshButton
        name: "LFRBrowseFrameRefreshButton"
        text: "Refresh"
        wowParent: "LFRBrowseFrame"
        style: "Button"
        pin: "all"
        anchors.left: lFRBrowseFrameInviteButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: lFRBrowseFrameInviteButton.verticalCenter
        width: 83.6
        height: 22
    }

    FontString {
        id: lFRBrowseFrameRefreshButtonText
        name: "LFRBrowseFrameRefreshButtonText"
        text: "Refresh"
        wowParent: "LFRBrowseFrameRefreshButton"
        anchors.horizontalCenter: lFRBrowseFrameRefreshButton.horizontalCenter
        anchors.verticalCenter: lFRBrowseFrameRefreshButton.verticalCenter
        width: 55.3
        height: 11.9
    }

    Button {
        id: lFRBrowseFrameSendMessageButton
        name: "LFRBrowseFrameSendMessageButton"
        text: "Send Message"
        wowParent: "LFRBrowseFrame"
        style: "Button"
        pin: "all"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: lFRParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 126.3
        height: 22
    }

    FontString {
        id: lFRBrowseFrameSendMessageButtonText
        name: "LFRBrowseFrameSendMessageButtonText"
        text: "Send Message"
        wowParent: "LFRBrowseFrameSendMessageButton"
        anchors.horizontalCenter: lFRBrowseFrameSendMessageButton.horizontalCenter
        anchors.verticalCenter: lFRBrowseFrameSendMessageButton.verticalCenter
        width: 98
        height: 11.9
    }

    FontString {
        id: lFRBrowseFrameTitleText
        name: "LFRBrowseFrameTitleText"
        text: "Raid Browser"
        wowParent: "LFRBrowseFrame"
        anchors.horizontalCenter: lFRBrowseFrame.horizontalCenter
        anchors.horizontalCenterOffset: 12
        anchors.top: lFRBrowseFrame.top
        anchors.topMargin: 18
        width: 79.8
        height: 11.9
    }

    Frame {
        id: lFRParentFrameDiabolic
        name: "LFRParentFrameDiabolic"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrame.left
        anchors.leftMargin: -16
        anchors.top: lFRParentFrame.top
        anchors.topMargin: -68
        width: 370
        height: 544
    }

    Frame {
        id: lFRParentFrameDiabolicBand
        name: "LFRParentFrameDiabolicBand"
        wowParent: "LFRParentFrameDiabolic"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 56
        width: 322
        height: 40
    }

    Frame {
        id: lFRParentFrameDiabolicBorder
        name: "LFRParentFrameDiabolicBorder"
        wowParent: "LFRParentFrameDiabolic"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 32
        width: 370
        height: 512
    }

    Frame {
        id: lFRParentFrameDiabolicFoot
        name: "LFRParentFrameDiabolicFoot"
        wowParent: "LFRParentFrameDiabolic"
        anchors.horizontalCenter: lFRBrowseFrameSendMessageButton.horizontalCenter
        anchors.horizontalCenterOffset: 84.9
        anchors.top: lFRBrowseFrameSendMessageButton.top
        anchors.topMargin: -6
        width: 324
        height: 35
    }

    Frame {
        id: lFRParentFrameDiabolicRail
        name: "LFRParentFrameDiabolicRail"
        wowParent: "LFRParentFrameDiabolic"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: lFRParentFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Frame {
        id: lFRParentFrameDiabolicSocket
        name: "LFRParentFrameDiabolicSocket"
        wowParent: "LFRParentFrameDiabolic"
        anchors.right: lFRParentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: lFRParentFrameDiabolicTitlePlate
        name: "LFRParentFrameDiabolicTitlePlate"
        wowParent: "LFRParentFrameDiabolic"
        anchors.horizontalCenter: lFRParentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: lFRParentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: lFRParentFrameTab1
        name: "LFRParentFrameTab1"
        text: "Choose Raid"
        wowParent: "LFRParentFrame"
        style: "Banner"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: lFRParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: lFRParentFrameTab2
        name: "LFRParentFrameTab2"
        text: "Browse"
        wowParent: "LFRParentFrame"
        style: "Banner"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: lFRParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        id: lFRQueueFrame
        name: "LFRQueueFrame"
        wowParent: "LFRParentFrame"
        anchors.left: lFRParentFrame.left
        anchors.top: lFRParentFrame.top
        width: 355
        height: 440
    }

    Button {
        id: lFRQueueFrameAcceptCommentButton
        name: "LFRQueueFrameAcceptCommentButton"
        text: "Set Comment"
        wowParent: "LFRQueueFrame"
        style: "Button"
        pin: "place"
        anchors.left: lFRQueueFrameFindGroupButton.right
        anchors.leftMargin: 56
        anchors.verticalCenter: lFRQueueFrameFindGroupButton.verticalCenter
        width: 115
        height: 22
    }

    FontString {
        id: lFRQueueFrameAcceptCommentButtonText
        name: "LFRQueueFrameAcceptCommentButtonText"
        text: "Set Comment"
        wowParent: "LFRQueueFrameAcceptCommentButton"
        anchors.horizontalCenter: lFRQueueFrameAcceptCommentButton.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameAcceptCommentButton.verticalCenter
        width: 96.4
        height: 11.9
    }

    EditBox {
        id: lFRQueueFrameComment
        name: "LFRQueueFrameComment"
        wowParent: "LFRQueueFrame"
        style: "EditBox"
        anchors.left: lFRParentFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: lFRParentFrameDiabolicBand.verticalCenter
        width: 250
        height: 20
    }

    Frame {
        id: lFRQueueFrameCommentDiabolicField
        name: "LFRQueueFrameCommentDiabolicField"
        wowParent: "LFRQueueFrameComment"
        anchors.left: lFRQueueFrameComment.left
        anchors.leftMargin: -8
        anchors.verticalCenter: lFRQueueFrameComment.verticalCenter
        width: 266
        height: 22
    }

    FontString {
        id: lFRQueueFrameCommentExplanation
        name: "LFRQueueFrameCommentExplanation"
        text: "Type your comment here."
        wowParent: "LFRQueueFrameComment"
        anchors.left: lFRQueueFrameComment.left
        anchors.top: lFRQueueFrameComment.top
        width: 250
        height: 20
    }

    Button {
        id: lFRQueueFrameCommentTextButton
        name: "LFRQueueFrameCommentTextButton"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrameComment.left
        anchors.top: lFRQueueFrameComment.top
        width: 250
        height: 20
    }

    Button {
        id: lFRQueueFrameFindGroupButton
        name: "LFRQueueFrameFindGroupButton"
        text: "List My Name"
        wowParent: "LFRQueueFrame"
        style: "Button"
        pin: "place"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: lFRParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 125
        height: 22
    }

    FontString {
        id: lFRQueueFrameFindGroupButtonText
        name: "LFRQueueFrameFindGroupButtonText"
        text: "List My Name"
        wowParent: "LFRQueueFrameFindGroupButton"
        anchors.horizontalCenter: lFRQueueFrameFindGroupButton.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameFindGroupButton.verticalCenter
        width: 97.2
        height: 11.9
    }

    Button {
        id: lFRQueueFrameRoleButtonDPS
        name: "LFRQueueFrameRoleButtonDPS"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrameRoleButtonHealer.right
        anchors.leftMargin: 43
        anchors.verticalCenter: lFRQueueFrameRoleButtonHealer.verticalCenter
        width: 48
        height: 48
    }

    Button {
        id: lFRQueueFrameRoleButtonHealer
        name: "LFRQueueFrameRoleButtonHealer"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrameRoleButtonTank.right
        anchors.leftMargin: 45
        anchors.verticalCenter: lFRQueueFrameRoleButtonTank.verticalCenter
        width: 48
        height: 48
    }

    Button {
        id: lFRQueueFrameRoleButtonTank
        name: "LFRQueueFrameRoleButtonTank"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRParentFrameDiabolic.horizontalCenter
        anchors.leftMargin: -116
        anchors.top: lFRParentFrameDiabolic.top
        anchors.topMargin: 128
        width: 48
        height: 48
    }

    Frame {
        id: lFRQueueFrameSpecific
        name: "LFRQueueFrameSpecific"
        wowParent: "LFRQueueFrame"
        anchors.left: lFRQueueFrame.left
        anchors.top: lFRQueueFrame.top
        width: 355
        height: 440
    }

    Frame {
        id: lFRQueueFrameSpecificListButton1
        name: "LFRQueueFrameSpecificListButton1"
        wowParent: "LFRQueueFrameSpecific"
        pin: "place"
        anchors.left: lFRQueueFrameSpecific.left
        anchors.leftMargin: 17
        anchors.top: lFRQueueFrameSpecific.top
        anchors.topMargin: 132
        width: 295
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton10
        name: "LFRQueueFrameSpecificListButton10"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton9.left
        anchors.top: lFRQueueFrameSpecificListButton9.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton10EnableButton
        name: "LFRQueueFrameSpecificListButton10EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton10"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton10LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton10LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton10InstanceLevel
        name: "LFRQueueFrameSpecificListButton10InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton10"
        anchors.right: lFRQueueFrameSpecificListButton10.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton10.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton10InstanceName
        name: "LFRQueueFrameSpecificListButton10InstanceName"
        text: "Ulduar"
        wowParent: "LFRQueueFrameSpecificListButton10"
        anchors.left: lFRQueueFrameSpecificListButton10.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton10.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton11
        name: "LFRQueueFrameSpecificListButton11"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton10.left
        anchors.top: lFRQueueFrameSpecificListButton10.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton11EnableButton
        name: "LFRQueueFrameSpecificListButton11EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton11"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton11LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton11LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton11InstanceLevel
        name: "LFRQueueFrameSpecificListButton11InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton11"
        anchors.right: lFRQueueFrameSpecificListButton11.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton11.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton11InstanceName
        name: "LFRQueueFrameSpecificListButton11InstanceName"
        text: "Vault of Archavon"
        wowParent: "LFRQueueFrameSpecificListButton11"
        anchors.left: lFRQueueFrameSpecificListButton11.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton11.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton12
        name: "LFRQueueFrameSpecificListButton12"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton11.left
        anchors.top: lFRQueueFrameSpecificListButton11.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton12EnableButton
        name: "LFRQueueFrameSpecificListButton12EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton12LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Button {
        id: lFRQueueFrameSpecificListButton12ExpandOrCollapseButton
        name: "LFRQueueFrameSpecificListButton12ExpandOrCollapseButton"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.left: lFRQueueFrameSpecificListButton12.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: lFRQueueFrameSpecificListButton12InstanceLevel
        name: "LFRQueueFrameSpecificListButton12InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.right: lFRQueueFrameSpecificListButton12.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton12InstanceName
        name: "LFRQueueFrameSpecificListButton12InstanceName"
        text: "Wrath of the Lich King Raid (10)"
        wowParent: "LFRQueueFrameSpecificListButton12"
        anchors.left: lFRQueueFrameSpecificListButton12.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton12.verticalCenter
        width: 255
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton13
        name: "LFRQueueFrameSpecificListButton13"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton12.left
        anchors.top: lFRQueueFrameSpecificListButton12.bottom
        width: 295
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton13InstanceLevel
        name: "LFRQueueFrameSpecificListButton13InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton13"
        anchors.right: lFRQueueFrameSpecificListButton13.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton13.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton13InstanceName
        name: "LFRQueueFrameSpecificListButton13InstanceName"
        text: "Icecrown Citadel"
        wowParent: "LFRQueueFrameSpecificListButton13"
        anchors.left: lFRQueueFrameSpecificListButton13.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton13.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton14
        name: "LFRQueueFrameSpecificListButton14"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton13.left
        anchors.top: lFRQueueFrameSpecificListButton13.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton14EnableButton
        name: "LFRQueueFrameSpecificListButton14EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton14"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton14LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton14LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton14InstanceLevel
        name: "LFRQueueFrameSpecificListButton14InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton14"
        anchors.right: lFRQueueFrameSpecificListButton14.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton14.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton14InstanceName
        name: "LFRQueueFrameSpecificListButton14InstanceName"
        text: "Naxxramas"
        wowParent: "LFRQueueFrameSpecificListButton14"
        anchors.left: lFRQueueFrameSpecificListButton14.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton14.verticalCenter
        width: 185
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton1EnableButton
        name: "LFRQueueFrameSpecificListButton1EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton1LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Button {
        id: lFRQueueFrameSpecificListButton1ExpandOrCollapseButton
        name: "LFRQueueFrameSpecificListButton1ExpandOrCollapseButton"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: lFRQueueFrameSpecificListButton1InstanceLevel
        name: "LFRQueueFrameSpecificListButton1InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.right: lFRQueueFrameSpecificListButton1.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton1InstanceName
        name: "LFRQueueFrameSpecificListButton1InstanceName"
        text: "Wrath of the Lich King Raid (25)"
        wowParent: "LFRQueueFrameSpecificListButton1"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton1.verticalCenter
        width: 255
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton2
        name: "LFRQueueFrameSpecificListButton2"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.top: lFRQueueFrameSpecificListButton1.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton2EnableButton
        name: "LFRQueueFrameSpecificListButton2EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton2"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton2LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton2LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton2InstanceLevel
        name: "LFRQueueFrameSpecificListButton2InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton2"
        anchors.right: lFRQueueFrameSpecificListButton2.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton2.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton2InstanceName
        name: "LFRQueueFrameSpecificListButton2InstanceName"
        text: "Icecrown Citadel"
        wowParent: "LFRQueueFrameSpecificListButton2"
        anchors.left: lFRQueueFrameSpecificListButton2.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton2.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton3
        name: "LFRQueueFrameSpecificListButton3"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton2.left
        anchors.top: lFRQueueFrameSpecificListButton2.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton3EnableButton
        name: "LFRQueueFrameSpecificListButton3EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton3"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton3LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton3LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton3InstanceLevel
        name: "LFRQueueFrameSpecificListButton3InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton3"
        anchors.right: lFRQueueFrameSpecificListButton3.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton3.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton3InstanceName
        name: "LFRQueueFrameSpecificListButton3InstanceName"
        text: "Naxxramas"
        wowParent: "LFRQueueFrameSpecificListButton3"
        anchors.left: lFRQueueFrameSpecificListButton3.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton3.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton4
        name: "LFRQueueFrameSpecificListButton4"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton3.left
        anchors.top: lFRQueueFrameSpecificListButton3.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton4EnableButton
        name: "LFRQueueFrameSpecificListButton4EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton4"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton4LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton4LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton4InstanceLevel
        name: "LFRQueueFrameSpecificListButton4InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton4"
        anchors.right: lFRQueueFrameSpecificListButton4.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton4.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton4InstanceName
        name: "LFRQueueFrameSpecificListButton4InstanceName"
        text: "Onyxia's Lair"
        wowParent: "LFRQueueFrameSpecificListButton4"
        anchors.left: lFRQueueFrameSpecificListButton4.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton4.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton5
        name: "LFRQueueFrameSpecificListButton5"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton4.left
        anchors.top: lFRQueueFrameSpecificListButton4.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton5EnableButton
        name: "LFRQueueFrameSpecificListButton5EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton5"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton5LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton5LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton5InstanceLevel
        name: "LFRQueueFrameSpecificListButton5InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton5"
        anchors.right: lFRQueueFrameSpecificListButton5.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton5.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton5InstanceName
        name: "LFRQueueFrameSpecificListButton5InstanceName"
        text: "Ruby Sanctum"
        wowParent: "LFRQueueFrameSpecificListButton5"
        anchors.left: lFRQueueFrameSpecificListButton5.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton5.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton6
        name: "LFRQueueFrameSpecificListButton6"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton5.left
        anchors.top: lFRQueueFrameSpecificListButton5.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton6EnableButton
        name: "LFRQueueFrameSpecificListButton6EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton6LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    Button {
        id: lFRQueueFrameSpecificListButton6ExpandOrCollapseButton
        name: "LFRQueueFrameSpecificListButton6ExpandOrCollapseButton"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.left: lFRQueueFrameSpecificListButton6.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: lFRQueueFrameSpecificListButton6InstanceLevel
        name: "LFRQueueFrameSpecificListButton6InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.right: lFRQueueFrameSpecificListButton6.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton6InstanceName
        name: "LFRQueueFrameSpecificListButton6InstanceName"
        text: "The Eye of Eternity"
        wowParent: "LFRQueueFrameSpecificListButton6"
        anchors.left: lFRQueueFrameSpecificListButton6.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton6.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton7
        name: "LFRQueueFrameSpecificListButton7"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton6.left
        anchors.top: lFRQueueFrameSpecificListButton6.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton7EnableButton
        name: "LFRQueueFrameSpecificListButton7EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton7"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton7LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton7LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton7InstanceLevel
        name: "LFRQueueFrameSpecificListButton7InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton7"
        anchors.right: lFRQueueFrameSpecificListButton7.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton7.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton7InstanceName
        name: "LFRQueueFrameSpecificListButton7InstanceName"
        text: "The Obsidian Sanctum"
        wowParent: "LFRQueueFrameSpecificListButton7"
        anchors.left: lFRQueueFrameSpecificListButton7.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton7.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton8
        name: "LFRQueueFrameSpecificListButton8"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton7.left
        anchors.top: lFRQueueFrameSpecificListButton7.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton8EnableButton
        name: "LFRQueueFrameSpecificListButton8EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton8"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton8LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton8LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton8InstanceLevel
        name: "LFRQueueFrameSpecificListButton8InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton8"
        anchors.right: lFRQueueFrameSpecificListButton8.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton8.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton8InstanceName
        name: "LFRQueueFrameSpecificListButton8InstanceName"
        text: "Trial of the Crusader"
        wowParent: "LFRQueueFrameSpecificListButton8"
        anchors.left: lFRQueueFrameSpecificListButton8.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton8.verticalCenter
        width: 185
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListButton9
        name: "LFRQueueFrameSpecificListButton9"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton8.left
        anchors.top: lFRQueueFrameSpecificListButton8.bottom
        width: 295
        height: 16
    }

    CheckButton {
        id: lFRQueueFrameSpecificListButton9EnableButton
        name: "LFRQueueFrameSpecificListButton9EnableButton"
        wowParent: "LFRQueueFrameSpecificListButton9"
        anchors.horizontalCenter: lFRQueueFrameSpecificListButton9LockedIndicator.horizontalCenter
        anchors.verticalCenter: lFRQueueFrameSpecificListButton9LockedIndicator.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: lFRQueueFrameSpecificListButton9InstanceLevel
        name: "LFRQueueFrameSpecificListButton9InstanceLevel"
        text: "(80 - 83)"
        wowParent: "LFRQueueFrameSpecificListButton9"
        anchors.right: lFRQueueFrameSpecificListButton9.right
        anchors.verticalCenter: lFRQueueFrameSpecificListButton9.verticalCenter
        width: 60
        height: 16
    }

    FontString {
        id: lFRQueueFrameSpecificListButton9InstanceName
        name: "LFRQueueFrameSpecificListButton9InstanceName"
        text: "Trial of the Grand Crusader"
        wowParent: "LFRQueueFrameSpecificListButton9"
        anchors.left: lFRQueueFrameSpecificListButton9.left
        anchors.leftMargin: 40
        anchors.verticalCenter: lFRQueueFrameSpecificListButton9.verticalCenter
        width: 185
        height: 16
    }

    ScrollFrame {
        id: lFRQueueFrameSpecificListScrollFrame
        name: "LFRQueueFrameSpecificListScrollFrame"
        wowParent: "LFRQueueFrameSpecific"
        anchors.left: lFRQueueFrameSpecificListButton1.left
        anchors.top: lFRQueueFrameSpecificListButton1.top
        anchors.topMargin: -2
        width: 296
        height: 228
    }

    Frame {
        id: lFRQueueFrameSpecificListScrollFrameDiabolicZone
        name: "LFRQueueFrameSpecificListScrollFrameDiabolicZone"
        wowParent: "LFRQueueFrameSpecific"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 2
        anchors.top: lFRQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 270
    }

    Slider {
        id: lFRQueueFrameSpecificListScrollFrameScrollBar
        name: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        wowParent: "LFRQueueFrameSpecificListScrollFrame"
        style: "ScrollBar"
        anchors.left: lFRQueueFrameSpecificListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: lFRQueueFrameSpecificListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 196
    }

    Frame {
        id: lFRQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack
        name: "LFRQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
        wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: lFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 230
    }

    Button {
        id: lFRQueueFrameSpecificListScrollFrameScrollBarScrollDownButton
        name: "LFRQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
        wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.top: lFRQueueFrameSpecificListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: lFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton
        name: "LFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
        wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: lFRQueueFrameSpecificListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: lFRQueueFrameSpecificListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: lFRQueueFrameSpecificListScrollFrameScrollChildFrame
        name: "LFRQueueFrameSpecificListScrollFrameScrollChildFrame"
        wowParent: "LFRQueueFrameSpecificListScrollFrame"
        anchors.left: lFRQueueFrameSpecificListScrollFrame.left
        anchors.top: lFRQueueFrameSpecificListScrollFrame.top
        width: 300
        height: 624
    }

    FontString {
        id: lFRQueueFrameTitleText
        name: "LFRQueueFrameTitleText"
        text: "Raid Browser"
        wowParent: "LFRParentFrameDiabolicTitlePlate"
        anchors.horizontalCenter: lFRParentFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: lFRParentFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 120.9
        height: 14.2
    }

    // the browse page's buttons across the foot, clear of the iron
    WowRow {
        name: "LFRBrowseButtons"
        parts: ["LFRBrowseFrameSendMessageButton", "LFRBrowseFrameInviteButton", "LFRBrowseFrameRefreshButton"]
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: lFRParentFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: lFRParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    // the raid page's two at the foot's ends, as far in
    WowRow {
        name: "LFRQueueButtons"
        parts: ["LFRQueueFrameFindGroupButton", "LFRQueueFrameAcceptCommentButton"]
        fit: "ends"
        anchors.left: lFRParentFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: lFRParentFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: lFRParentFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    Ghost { id: lFRBrowseFrameListScrollFrame; name: "LFRBrowseFrameListScrollFrame"; x: 167; y: 66; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton10LockedIndicator; name: "LFRQueueFrameSpecificListButton10LockedIndicator"; x: 48; y: 284; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton11LockedIndicator; name: "LFRQueueFrameSpecificListButton11LockedIndicator"; x: 48; y: 300; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton12LockedIndicator; name: "LFRQueueFrameSpecificListButton12LockedIndicator"; x: 48; y: 316; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton14LockedIndicator; name: "LFRQueueFrameSpecificListButton14LockedIndicator"; x: 48; y: 348; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton1LockedIndicator; name: "LFRQueueFrameSpecificListButton1LockedIndicator"; x: 48; y: 140; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton2LockedIndicator; name: "LFRQueueFrameSpecificListButton2LockedIndicator"; x: 48; y: 156; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton3LockedIndicator; name: "LFRQueueFrameSpecificListButton3LockedIndicator"; x: 48; y: 172; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton4LockedIndicator; name: "LFRQueueFrameSpecificListButton4LockedIndicator"; x: 48; y: 188; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton5LockedIndicator; name: "LFRQueueFrameSpecificListButton5LockedIndicator"; x: 560.2; y: 196.9; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton6LockedIndicator; name: "LFRQueueFrameSpecificListButton6LockedIndicator"; x: 48; y: 220; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton7LockedIndicator; name: "LFRQueueFrameSpecificListButton7LockedIndicator"; x: 48; y: 236; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton8LockedIndicator; name: "LFRQueueFrameSpecificListButton8LockedIndicator"; x: 560.2; y: 244.9; width: 0; height: 0 }
    Ghost { id: lFRQueueFrameSpecificListButton9LockedIndicator; name: "LFRQueueFrameSpecificListButton9LockedIndicator"; x: 560.2; y: 260.9; width: 0; height: 0 }
}
