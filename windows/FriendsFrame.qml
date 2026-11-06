// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: friendsFrame
    name: "FriendsFrame"
    width: 384
    height: 512

    Button {
        id: channelButton1
        name: "ChannelButton1"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelListScrollChildFrame.left
        anchors.top: channelListScrollChildFrame.top
        width: 155
        height: 20
    }

    FontString {
        id: channelButton1Text
        name: "ChannelButton1Text"
        wowParent: "ChannelButton1"
        anchors.left: channelButton1.left
        anchors.leftMargin: 5
        anchors.verticalCenter: channelButton1.verticalCenter
        width: 135
        height: 8
    }

    FontString {
        id: channelButton2Collapsed
        name: "ChannelButton2Collapsed"
        text: "-"
        wowParent: "ChannelButton2"
        anchors.right: channelButton2.right
        anchors.rightMargin: 5
        anchors.verticalCenter: channelButton2.verticalCenter
        width: 7.9
        height: 15.8
    }

    FontString {
        id: channelButton6Collapsed
        name: "ChannelButton6Collapsed"
        text: "-"
        wowParent: "ChannelButton6"
        anchors.right: channelButton6.right
        anchors.rightMargin: 5
        anchors.verticalCenter: channelButton6.verticalCenter
        width: 7.9
        height: 15.8
    }

    FontString {
        id: channelButton7Collapsed
        name: "ChannelButton7Collapsed"
        text: "-"
        wowParent: "ChannelButton7"
        anchors.right: channelButton7.right
        anchors.rightMargin: 5
        anchors.verticalCenter: channelButton7.verticalCenter
        width: 7.9
        height: 15.8
    }

    Frame {
        id: channelFrame
        name: "ChannelFrame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 355
        height: 512
    }

    Frame {
        id: channelFrameDaughterFrame
        name: "ChannelFrameDaughterFrame"
        wowParent: "ChannelFrame"
        anchors.horizontalCenter: uIParent.horizontalCenter
        anchors.verticalCenter: uIParent.verticalCenter
        anchors.verticalCenterOffset: -100
        width: 212
        height: 200
    }

    Button {
        id: channelFrameDaughterFrameCancelButton
        name: "ChannelFrameDaughterFrameCancelButton"
        text: "Cancel"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.right: channelFrameDaughterFrame.right
        anchors.rightMargin: 9
        anchors.bottom: channelFrameDaughterFrame.bottom
        anchors.bottomMargin: 12
        width: 93.5
        height: 22
    }

    FontString {
        id: channelFrameDaughterFrameCancelButtonText
        name: "ChannelFrameDaughterFrameCancelButtonText"
        text: "Cancel"
        wowParent: "ChannelFrameDaughterFrameCancelButton"
        anchors.horizontalCenter: channelFrameDaughterFrameCancelButton.horizontalCenter
        anchors.verticalCenter: channelFrameDaughterFrameCancelButton.verticalCenter
        width: 35.6
        height: 10.3
    }

    EditBox {
        id: channelFrameDaughterFrameChannelName
        name: "ChannelFrameDaughterFrameChannelName"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.left: channelFrameDaughterFrame.left
        anchors.leftMargin: 23
        anchors.top: channelFrameDaughterFrame.top
        anchors.topMargin: 60
        width: 170
        height: 16
    }

    Frame {
        id: channelFrameDaughterFrameChannelNameDiabolicField
        name: "ChannelFrameDaughterFrameChannelNameDiabolicField"
        wowParent: "ChannelFrameDaughterFrameChannelName"
        anchors.left: channelFrameDaughterFrameChannelName.left
        anchors.leftMargin: -8
        anchors.verticalCenter: channelFrameDaughterFrameChannelName.verticalCenter
        width: 186
        height: 22
    }

    FontString {
        id: channelFrameDaughterFrameChannelNameLabel
        name: "ChannelFrameDaughterFrameChannelNameLabel"
        text: "Channel Name"
        wowParent: "ChannelFrameDaughterFrameChannelName"
        anchors.left: channelFrameDaughterFrameChannelName.left
        anchors.bottom: channelFrameDaughterFrameChannelName.top
        anchors.bottomMargin: 5
        width: 85.3
        height: 14.2
    }

    EditBox {
        id: channelFrameDaughterFrameChannelPassword
        name: "ChannelFrameDaughterFrameChannelPassword"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.left: channelFrameDaughterFrameChannelName.left
        anchors.top: channelFrameDaughterFrameChannelName.bottom
        anchors.topMargin: 30
        width: 170
        height: 16
    }

    Frame {
        id: channelFrameDaughterFrameChannelPasswordDiabolicField
        name: "ChannelFrameDaughterFrameChannelPasswordDiabolicField"
        wowParent: "ChannelFrameDaughterFrameChannelPassword"
        anchors.left: channelFrameDaughterFrameChannelPassword.left
        anchors.leftMargin: -8
        anchors.verticalCenter: channelFrameDaughterFrameChannelPassword.verticalCenter
        width: 186
        height: 22
    }

    FontString {
        id: channelFrameDaughterFrameChannelPasswordLabel
        name: "ChannelFrameDaughterFrameChannelPasswordLabel"
        text: "Password"
        wowParent: "ChannelFrameDaughterFrameChannelPassword"
        anchors.left: channelFrameDaughterFrameChannelPassword.left
        anchors.bottom: channelFrameDaughterFrameChannelPassword.top
        anchors.bottomMargin: 5
        width: 55.3
        height: 14.2
    }

    FontString {
        id: channelFrameDaughterFrameChannelPasswordOptional
        name: "ChannelFrameDaughterFrameChannelPasswordOptional"
        text: "(optional)"
        wowParent: "ChannelFrameDaughterFrameChannelPassword"
        anchors.left: channelFrameDaughterFrameChannelPasswordLabel.right
        anchors.leftMargin: 3
        anchors.verticalCenter: channelFrameDaughterFrameChannelPasswordLabel.verticalCenter
        width: 52.9
        height: 10.3
    }

    Button {
        id: channelFrameDaughterFrameDetailCloseButton
        name: "ChannelFrameDaughterFrameDetailCloseButton"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.right: channelFrameDaughterFrame.right
        anchors.rightMargin: 2
        anchors.top: channelFrameDaughterFrame.top
        anchors.topMargin: 3
        width: 22
        height: 22
    }

    FontString {
        id: channelFrameDaughterFrameName
        name: "ChannelFrameDaughterFrameName"
        text: "New Channel"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.horizontalCenter: channelFrameDaughterFrame.horizontalCenter
        anchors.horizontalCenterOffset: -5
        anchors.top: channelFrameDaughterFrame.top
        anchors.topMargin: 13
        width: 79
        height: 12
    }

    Button {
        id: channelFrameDaughterFrameOkayButton
        name: "ChannelFrameDaughterFrameOkayButton"
        text: "Okay"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.right: channelFrameDaughterFrame.right
        anchors.rightMargin: 108.5
        anchors.bottom: channelFrameDaughterFrame.bottom
        anchors.bottomMargin: 12
        width: 93.5
        height: 22
    }

    FontString {
        id: channelFrameDaughterFrameOkayButtonText
        name: "ChannelFrameDaughterFrameOkayButtonText"
        text: "Okay"
        wowParent: "ChannelFrameDaughterFrameOkayButton"
        anchors.horizontalCenter: channelFrameDaughterFrameOkayButton.horizontalCenter
        anchors.verticalCenter: channelFrameDaughterFrameOkayButton.verticalCenter
        width: 28.4
        height: 10.3
    }

    Button {
        id: channelFrameNewButton
        name: "ChannelFrameNewButton"
        text: "Add"
        wowParent: "ChannelFrame"
        style: "Button"
        anchors.right: channelFrame.right
        anchors.rightMargin: 12
        anchors.bottom: channelFrame.bottom
        anchors.bottomMargin: 82
        width: 80
        height: 22
    }

    FontString {
        id: channelFrameNewButtonText
        name: "ChannelFrameNewButtonText"
        text: "Add"
        wowParent: "ChannelFrameNewButton"
        anchors.horizontalCenter: channelFrameNewButton.horizontalCenter
        anchors.verticalCenter: channelFrameNewButton.verticalCenter
        width: 21.3
        height: 10.3
    }

    Frame {
        id: channelFrameVerticalBar
        name: "ChannelFrameVerticalBar"
        wowParent: "ChannelFrame"
        anchors.horizontalCenter: channelFrame.horizontalCenter
        anchors.horizontalCenterOffset: 3
        anchors.verticalCenter: channelFrame.verticalCenter
        anchors.verticalCenterOffset: -35
        width: 13
        height: 300
    }

    Frame {
        id: channelListScrollChildFrame
        name: "ChannelListScrollChildFrame"
        wowParent: "ChannelListScrollFrame"
        anchors.left: channelListScrollFrame.left
        anchors.top: channelListScrollFrame.top
        width: 145
        height: -1780
    }

    ScrollFrame {
        id: channelListScrollFrame
        name: "ChannelListScrollFrame"
        wowParent: "ChannelFrame"
        anchors.left: channelFrame.left
        anchors.leftMargin: 20
        anchors.top: channelFrame.top
        anchors.topMargin: 76
        width: 158
        height: 327
    }

    Button {
        id: channelMemberButton1
        name: "ChannelMemberButton1"
        wowParent: "ChannelRoster"
        anchors.left: channelFrame.left
        anchors.leftMargin: 186
        anchors.top: channelFrame.top
        anchors.topMargin: 75
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton1Name
        name: "ChannelMemberButton1Name"
        text: "Aashwath"
        wowParent: "?"
        anchors.left: channelMemberButton1.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton1.top
        anchors.topMargin: 1
        width: 52.9
        height: 10.3
    }

    Frame {
        id: channelRoster
        name: "ChannelRoster"
        wowParent: "ChannelFrame"
        anchors.left: channelFrame.horizontalCenter
        anchors.leftMargin: 121
        anchors.top: channelFrame.top
        anchors.topMargin: 79
        width: 158
        height: 327
    }

    FontString {
        id: channelRosterChannelCount
        name: "ChannelRosterChannelCount"
        wowParent: "ChannelRoster"
        anchors.left: channelRosterChannelName.right
        anchors.verticalCenter: channelRosterChannelName.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: channelRosterChannelName
        name: "ChannelRosterChannelName"
        wowParent: "ChannelRoster"
        anchors.left: channelRoster.left
        anchors.leftMargin: -115
        anchors.top: channelRoster.top
        anchors.topMargin: -20
        width: 1
        height: 1
    }

    ScrollFrame {
        id: channelRosterScrollFrame
        name: "ChannelRosterScrollFrame"
        wowParent: "ChannelRoster"
        anchors.right: channelFrame.right
        anchors.rightMargin: 39
        anchors.top: channelFrame.top
        anchors.topMargin: 76
        width: 158
        height: 327
    }

    Slider {
        id: channelRosterScrollFrameScrollBar
        name: "ChannelRosterScrollFrameScrollBar"
        wowParent: "ChannelRosterScrollFrame"
        anchors.left: channelRosterScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: channelRosterScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 295
    }

    Frame {
        id: channelRosterScrollFrameScrollBarDiabolicTrack
        name: "ChannelRosterScrollFrameScrollBarDiabolicTrack"
        wowParent: "ChannelRosterScrollFrameScrollBar"
        anchors.horizontalCenter: channelRosterScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: channelRosterScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 329
    }

    Button {
        id: channelRosterScrollFrameScrollBarScrollDownButton
        name: "ChannelRosterScrollFrameScrollBarScrollDownButton"
        wowParent: "ChannelRosterScrollFrameScrollBar"
        anchors.horizontalCenter: channelRosterScrollFrameScrollBar.horizontalCenter
        anchors.top: channelRosterScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: channelRosterScrollFrameScrollBarScrollUpButton
        name: "ChannelRosterScrollFrameScrollBarScrollUpButton"
        wowParent: "ChannelRosterScrollFrameScrollBar"
        anchors.horizontalCenter: channelRosterScrollFrameScrollBar.horizontalCenter
        anchors.bottom: channelRosterScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: channelRosterScrollFrameScrollChildFrame
        name: "ChannelRosterScrollFrameScrollChildFrame"
        wowParent: "ChannelRosterScrollFrame"
        anchors.left: channelRosterScrollFrame.left
        anchors.top: channelRosterScrollFrame.top
        width: 300
        height: 1245
    }

    Button {
        id: friendsFrameAddFriendButton
        name: "FriendsFrameAddFriendButton"
        text: "Add Friend"
        wowParent: "FriendsListFrame"
        style: "Button"
        pin: "place"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 31
        width: 131
        height: 21
    }

    FontString {
        id: friendsFrameAddFriendButtonText
        name: "FriendsFrameAddFriendButtonText"
        text: "Add Friend"
        wowParent: "FriendsFrameAddFriendButton"
        anchors.horizontalCenter: friendsFrameAddFriendButton.horizontalCenter
        anchors.verticalCenter: friendsFrameAddFriendButton.verticalCenter
        width: 59.3
        height: 10.3
    }

    Button {
        id: friendsFrameCloseButton
        name: "FriendsFrameCloseButton"
        wowParent: "FriendsFrame"
        style: "CloseButton"
        anchors.horizontalCenter: friendsFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: friendsFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: friendsFrameDiabolic
        name: "FriendsFrameDiabolic"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.leftMargin: -20
        anchors.top: friendsFrame.top
        anchors.topMargin: -68
        width: 400
        height: 540
    }

    Frame {
        id: friendsFrameDiabolicBand
        name: "FriendsFrameDiabolicBand"
        wowParent: "FriendsFrameDiabolic"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 56
        width: 352
        height: 40
    }

    Frame {
        id: friendsFrameDiabolicBorder
        name: "FriendsFrameDiabolicBorder"
        wowParent: "FriendsFrameDiabolic"
        anchors.left: friendsFrameDiabolic.left
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 32
        width: 400
        height: 508
    }

    Frame {
        id: friendsFrameDiabolicFoot
        name: "FriendsFrameDiabolicFoot"
        wowParent: "FriendsFrameDiabolic"
        anchors.horizontalCenter: guildFrameGuildInformationButton.horizontalCenter
        anchors.horizontalCenterOffset: 101.6
        anchors.top: guildFrameGuildInformationButton.top
        anchors.topMargin: -6
        width: 354
        height: 47
    }

    Frame {
        id: friendsFrameDiabolicRail
        name: "FriendsFrameDiabolicRail"
        wowParent: "FriendsFrameDiabolic"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 304
        height: 18
    }

    Frame {
        id: friendsFrameDiabolicSocket
        name: "FriendsFrameDiabolicSocket"
        wowParent: "FriendsFrameDiabolic"
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: friendsFrameDiabolicTitlePlate
        name: "FriendsFrameDiabolicTitlePlate"
        wowParent: "FriendsFrameDiabolic"
        anchors.horizontalCenter: friendsFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: friendsFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    ScrollFrame {
        id: friendsFrameFriendsScrollFrame
        name: "FriendsFrameFriendsScrollFrame"
        wowParent: "FriendsListFrame"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 21
        anchors.top: friendsFrame.top
        anchors.topMargin: 36
        width: 302
        height: 340
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton1
        name: "FriendsFrameFriendsScrollFrameButton1"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameScrollChild.left
        anchors.top: friendsFrameFriendsScrollFrameScrollChild.top
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton1Info
        name: "FriendsFrameFriendsScrollFrameButton1Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton1"
        anchors.left: friendsFrameFriendsScrollFrameButton1Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton1Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton1Name
        name: "FriendsFrameFriendsScrollFrameButton1Name"
        text: "Annah"
        wowParent: "FriendsFrameFriendsScrollFrameButton1"
        anchors.left: friendsFrameFriendsScrollFrameButton1.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton1.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Frame {
        id: friendsFrameFriendsScrollFrameDiabolicZone
        name: "FriendsFrameFriendsScrollFrameDiabolicZone"
        wowParent: "FriendsListFrame"
        anchors.left: friendsFrameFriendsScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: friendsFrameFriendsScrollFrame.top
        anchors.topMargin: -2
        width: 336
        height: 352
    }

    Slider {
        id: friendsFrameFriendsScrollFrameScrollBar
        name: "FriendsFrameFriendsScrollFrameScrollBar"
        wowParent: "FriendsFrameFriendsScrollFrame"
        style: "ScrollBar"
        pin: "place"
        anchors.left: friendsFrameFriendsScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameFriendsScrollFrame.top
        anchors.topMargin: 15
        anchors.bottom: friendsFrameFriendsScrollFrame.bottom
        anchors.bottomMargin: 15
        width: 16
        height: 310
    }

    Frame {
        id: friendsFrameFriendsScrollFrameScrollBarDiabolicTrack
        name: "FriendsFrameFriendsScrollFrameScrollBarDiabolicTrack"
        wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
        anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: friendsFrameFriendsScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 344
    }

    Button {
        id: friendsFrameFriendsScrollFrameScrollBarScrollDownButton
        name: "FriendsFrameFriendsScrollFrameScrollBarScrollDownButton"
        wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBar.horizontalCenter
        anchors.top: friendsFrameFriendsScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: friendsFrameFriendsScrollFrameScrollBarScrollUpButton
        name: "FriendsFrameFriendsScrollFrameScrollBarScrollUpButton"
        wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBar.horizontalCenter
        anchors.bottom: friendsFrameFriendsScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: friendsFrameFriendsScrollFrameScrollChild
        name: "FriendsFrameFriendsScrollFrameScrollChild"
        wowParent: "FriendsFrameFriendsScrollFrame"
        anchors.left: friendsFrameFriendsScrollFrame.left
        anchors.top: friendsFrameFriendsScrollFrame.top
        width: 10
        height: 10
    }

    Button {
        id: friendsFrameIgnoreButton1
        name: "FriendsFrameIgnoreButton1"
        wowParent: "IgnoreListFrame"
        pin: "place"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 21
        anchors.top: friendsFrame.top
        anchors.topMargin: 39
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton1Name
        name: "FriendsFrameIgnoreButton1Name"
        wowParent: "FriendsFrameIgnoreButton1"
        anchors.left: friendsFrameIgnoreButton1.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnorePlayerButton
        name: "FriendsFrameIgnorePlayerButton"
        text: "Ignore Player"
        wowParent: "IgnoreListFrame"
        style: "Button"
        pin: "place"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 31
        width: 131
        height: 21
    }

    FontString {
        id: friendsFrameIgnorePlayerButtonText
        name: "FriendsFrameIgnorePlayerButtonText"
        text: "Ignore Player"
        wowParent: "FriendsFrameIgnorePlayerButton"
        anchors.horizontalCenter: friendsFrameIgnorePlayerButton.horizontalCenter
        anchors.verticalCenter: friendsFrameIgnorePlayerButton.verticalCenter
        width: 75.1
        height: 10.3
    }

    ScrollFrame {
        id: friendsFrameIgnoreScrollFrame
        name: "FriendsFrameIgnoreScrollFrame"
        wowParent: "IgnoreListFrame"
        pin: "all"
        anchors.right: friendsFrame.right
        anchors.rightMargin: 65
        anchors.top: friendsFrame.top
        anchors.topMargin: 36
        width: 298
        height: 340
    }

    Frame {
        id: friendsFrameIgnoreScrollFrameDiabolicZone
        name: "FriendsFrameIgnoreScrollFrameDiabolicZone"
        wowParent: "IgnoreListFrame"
        anchors.left: friendsFrameIgnoreScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: friendsFrameIgnoreScrollFrame.top
        anchors.topMargin: -2
        width: 332
        height: 344
    }

    Frame {
        id: friendsFrameIgnoredHeader
        name: "FriendsFrameIgnoredHeader"
        wowParent: "FriendsFrameIgnoreButton1"
        anchors.left: friendsFrameIgnoreButton1.left
        anchors.top: friendsFrameIgnoreButton1.top
        width: 302
        height: 16
    }

    FontString {
        id: friendsFrameIgnoredHeaderTitle
        name: "FriendsFrameIgnoredHeaderTitle"
        text: "Ignored"
        wowParent: "FriendsFrameIgnoredHeader"
        anchors.left: friendsFrameIgnoredHeader.left
        anchors.leftMargin: 5
        anchors.verticalCenter: friendsFrameIgnoredHeader.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 47.4
        height: 11.9
    }

    Button {
        id: friendsFrameSendMessageButton
        name: "FriendsFrameSendMessageButton"
        text: "Send Message"
        wowParent: "FriendsListFrame"
        style: "Button"
        pin: "place"
        anchors.left: friendsFrameAddFriendButton.right
        anchors.leftMargin: 64
        anchors.verticalCenter: friendsFrameAddFriendButton.verticalCenter
        width: 131
        height: 21
    }

    FontString {
        id: friendsFrameSendMessageButtonText
        name: "FriendsFrameSendMessageButtonText"
        text: "Send Message"
        wowParent: "FriendsFrameSendMessageButton"
        anchors.horizontalCenter: friendsFrameSendMessageButton.horizontalCenter
        anchors.verticalCenter: friendsFrameSendMessageButton.verticalCenter
        width: 78.2
        height: 10.3
    }

    Frame {
        id: friendsFrameStatusDropDown
        name: "FriendsFrameStatusDropDown"
        wowParent: "FriendsTabHeader"
        style: "DropDown"
        anchors.left: friendsFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 78
        height: 32
    }

    Button {
        id: friendsFrameStatusDropDownButton
        name: "FriendsFrameStatusDropDownButton"
        wowParent: "FriendsFrameStatusDropDown"
        anchors.right: friendsFrameStatusDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: friendsFrameStatusDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: friendsFrameStatusDropDownDiabolicField
        name: "FriendsFrameStatusDropDownDiabolicField"
        wowParent: "FriendsFrameStatusDropDown"
        anchors.left: friendsFrameStatusDropDown.left
        anchors.verticalCenter: friendsFrameStatusDropDown.verticalCenter
        width: 78
        height: 22
    }

    Frame {
        id: friendsFrameStatusDropDownMouseOver
        name: "FriendsFrameStatusDropDownMouseOver"
        wowParent: "FriendsFrameStatusDropDown"
        anchors.left: friendsFrameStatusDropDown.left
        anchors.leftMargin: 16
        anchors.top: friendsFrameStatusDropDown.top
        anchors.topMargin: 2
        width: 22
        height: 23
    }

    Button {
        id: friendsFrameTab1
        name: "FriendsFrameTab1"
        text: "Friends"
        wowParent: "FriendsFrame"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: friendsFrameTab2
        name: "FriendsFrameTab2"
        text: "Who"
        wowParent: "FriendsFrame"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: friendsFrameTab3
        name: "FriendsFrameTab3"
        text: "Guild"
        wowParent: "FriendsFrame"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: friendsFrameTab4
        name: "FriendsFrameTab4"
        text: "Chat"
        wowParent: "FriendsFrame"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: friendsFrameTab5
        name: "FriendsFrameTab5"
        text: "Raid"
        wowParent: "FriendsFrame"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    FontString {
        id: friendsFrameTitleText
        name: "FriendsFrameTitleText"
        text: "Raid"
        wowParent: "FriendsFrameDiabolicTitlePlate"
        anchors.horizontalCenter: friendsFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: friendsFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.7
        height: 14.2
    }

    Button {
        id: friendsFrameUnsquelchButton
        name: "FriendsFrameUnsquelchButton"
        text: "Remove Player"
        wowParent: "IgnoreListFrame"
        style: "Button"
        pin: "place"
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 31
        width: 134
        height: 21
    }

    FontString {
        id: friendsFrameUnsquelchButtonText
        name: "FriendsFrameUnsquelchButtonText"
        text: "Remove Player"
        wowParent: "FriendsFrameUnsquelchButton"
        anchors.horizontalCenter: friendsFrameUnsquelchButton.horizontalCenter
        anchors.verticalCenter: friendsFrameUnsquelchButton.verticalCenter
        width: 81.4
        height: 10.3
    }

    Frame {
        id: friendsListFrame
        name: "FriendsListFrame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Frame {
        id: friendsTabHeader
        name: "FriendsTabHeader"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Button {
        id: friendsTabHeaderTab1
        name: "FriendsTabHeaderTab1"
        text: "Friends"
        wowParent: "FriendsTabHeader"
        style: "Tab"
        anchors.left: friendsFrameStatusDropDown.right
        anchors.leftMargin: -4
        anchors.verticalCenter: friendsFrameStatusDropDown.verticalCenter
        width: 69
        height: 32
    }

    FontString {
        id: friendsTabHeaderTab1Text
        name: "FriendsTabHeaderTab1Text"
        text: "Friends"
        wowParent: "FriendsTabHeaderTab1"
        anchors.horizontalCenter: friendsTabHeaderTab1.horizontalCenter
        anchors.verticalCenter: friendsTabHeaderTab1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 48.2
        height: 13
    }

    Button {
        id: friendsTabHeaderTab2
        name: "FriendsTabHeaderTab2"
        text: "Ignore"
        wowParent: "FriendsTabHeader"
        style: "Tab"
        anchors.left: friendsTabHeaderTab1.right
        anchors.verticalCenter: friendsTabHeaderTab1.verticalCenter
        width: 65.4
        height: 32
    }

    FontString {
        id: friendsTabHeaderTab2Text
        name: "FriendsTabHeaderTab2Text"
        text: "Ignore"
        wowParent: "FriendsTabHeaderTab2"
        anchors.horizontalCenter: friendsTabHeaderTab2.horizontalCenter
        anchors.verticalCenter: friendsTabHeaderTab2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 43.5
        height: 13
    }

    Frame {
        id: friendsTooltip
        name: "FriendsTooltip"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrameFriendsScrollFrameButton9.right
        anchors.leftMargin: 36
        anchors.top: friendsFrameFriendsScrollFrameButton9.top
        width: 65.8
        height: 35.8
    }

    FontString {
        id: friendsTooltipHeader
        name: "FriendsTooltipHeader"
        text: "Drread"
        wowParent: "FriendsTooltip"
        anchors.left: friendsTooltip.left
        anchors.leftMargin: 12
        anchors.top: friendsTooltip.top
        anchors.topMargin: 12
        width: 152.9
        height: 10.3
    }

    FontString {
        id: friendsTooltipNoteText
        name: "FriendsTooltipNoteText"
        text: "THE ONLY ONE"
        wowParent: "FriendsTooltip"
        anchors.horizontalCenter: friendsTooltipHeader.horizontalCenter
        anchors.horizontalCenterOffset: 7.8
        anchors.top: friendsTooltipHeader.bottom
        anchors.topMargin: -95.1
        width: 137.3
        height: 8.7
    }

    Frame {
        id: guildEventFrame
        name: "GuildEventFrame"
        wowParent: "GuildEventLogFrame"
        anchors.left: guildEventLogFrame.left
        anchors.leftMargin: 11
        anchors.top: guildEventLogFrame.top
        anchors.topMargin: 42
        width: 375
        height: 360
    }

    Button {
        id: guildEventLogCancelButton
        name: "GuildEventLogCancelButton"
        text: "Close"
        wowParent: "GuildEventLogFrame"
        style: "Button"
        anchors.right: guildEventLogFrame.right
        anchors.rightMargin: 9
        anchors.bottom: guildEventLogFrame.bottom
        anchors.bottomMargin: 13
        width: 139
        height: 22
    }

    FontString {
        id: guildEventLogCancelButtonText
        name: "GuildEventLogCancelButtonText"
        text: "Close"
        wowParent: "GuildEventLogCancelButton"
        anchors.horizontalCenter: guildEventLogCancelButton.horizontalCenter
        anchors.verticalCenter: guildEventLogCancelButton.verticalCenter
        width: 30
        height: 10.3
    }

    Button {
        id: guildEventLogCloseButton
        name: "GuildEventLogCloseButton"
        wowParent: "GuildEventLogFrame"
        anchors.right: guildEventLogFrame.right
        anchors.rightMargin: 3
        anchors.top: guildEventLogFrame.top
        anchors.topMargin: 3
        width: 22
        height: 22
    }

    Frame {
        id: guildEventLogFrame
        name: "GuildEventLogFrame"
        wowParent: "FriendsFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 395
        height: 435
    }

    Frame {
        id: guildEventLogScrollChildFrame
        name: "GuildEventLogScrollChildFrame"
        wowParent: "GuildEventLogScrollFrame"
        anchors.left: guildEventLogScrollFrame.left
        anchors.top: guildEventLogScrollFrame.top
        anchors.topMargin: -1109.5
        width: 325
        height: 359
    }

    ScrollFrame {
        id: guildEventLogScrollFrame
        name: "GuildEventLogScrollFrame"
        wowParent: "GuildEventFrame"
        anchors.right: guildEventFrame.right
        anchors.rightMargin: 28
        anchors.top: guildEventFrame.top
        anchors.topMargin: 6
        width: 325
        height: 349
    }

    Slider {
        id: guildEventLogScrollFrameScrollBar
        name: "GuildEventLogScrollFrameScrollBar"
        wowParent: "GuildEventLogScrollFrame"
        style: "ScrollBar"
        anchors.left: guildEventLogScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: guildEventLogScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 317
    }

    Frame {
        id: guildEventLogScrollFrameScrollBarDiabolicTrack
        name: "GuildEventLogScrollFrameScrollBarDiabolicTrack"
        wowParent: "GuildEventLogScrollFrameScrollBar"
        anchors.horizontalCenter: guildEventLogScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildEventLogScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 351
    }

    Button {
        id: guildEventLogScrollFrameScrollBarScrollDownButton
        name: "GuildEventLogScrollFrameScrollBarScrollDownButton"
        wowParent: "GuildEventLogScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildEventLogScrollFrameScrollBar.horizontalCenter
        anchors.top: guildEventLogScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: guildEventLogScrollFrameScrollBarScrollUpButton
        name: "GuildEventLogScrollFrameScrollBarScrollUpButton"
        wowParent: "GuildEventLogScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildEventLogScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildEventLogScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    FontString {
        id: guildEventLogTitle
        name: "GuildEventLogTitle"
        text: "Log"
        wowParent: "GuildEventLogFrame"
        anchors.left: guildEventLogFrame.left
        anchors.leftMargin: 17
        anchors.top: guildEventLogFrame.top
        anchors.topMargin: 17
        width: 24.5
        height: 11.9
    }

    FontString {
        id: guildEventMessage
        name: "GuildEventMessage"
        wowParent: "GuildEventLogScrollChildFrame"
        anchors.left: guildEventLogScrollChildFrame.left
        anchors.top: guildEventLogScrollChildFrame.top
        width: 325
        height: 1635.6
    }

    Frame {
        id: guildFrame
        name: "GuildFrame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Button {
        id: guildFrameAddMemberButton
        name: "GuildFrameAddMemberButton"
        text: "Add Member"
        wowParent: "GuildFrame"
        style: "Button"
        pin: "all"
        anchors.left: guildFrameGuildInformationButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: guildFrameGuildInformationButton.verticalCenter
        width: 94.4
        height: 22
    }

    FontString {
        id: guildFrameAddMemberButtonText
        name: "GuildFrameAddMemberButtonText"
        text: "Add Member"
        wowParent: "GuildFrameAddMemberButton"
        anchors.horizontalCenter: guildFrameAddMemberButton.horizontalCenter
        anchors.verticalCenter: guildFrameAddMemberButton.verticalCenter
        width: 70.3
        height: 10.3
    }

    Button {
        id: guildFrameButton1
        name: "GuildFrameButton1"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrame.left
        anchors.leftMargin: 15
        anchors.top: guildFrame.top
        anchors.topMargin: 70
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton1Class
        name: "GuildFrameButton1Class"
        text: "Warrior"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton1Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton1Group
        name: "GuildFrameButton1Group"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Class.right
        anchors.verticalCenter: guildFrameButton1Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton1Level
        name: "GuildFrameButton1Level"
        text: "70"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton1Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton1Name
        name: "GuildFrameButton1Name"
        text: "Tocha"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton1.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton1Zone
        name: "GuildFrameButton1Zone"
        text: "Borean Tundra"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton1Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameColumnHeader1
        name: "GuildFrameColumnHeader1"
        text: "Name"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildPlayerStatusFrame.left
        anchors.leftMargin: 20
        anchors.top: guildPlayerStatusFrame.top
        anchors.topMargin: 70
        width: 83
        height: 22
    }

    Button {
        id: guildFrameColumnHeader2
        name: "GuildFrameColumnHeader2"
        text: "Zone"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameColumnHeader1.right
        anchors.leftMargin: -2
        anchors.verticalCenter: guildFrameColumnHeader1.verticalCenter
        width: 120
        height: 22
    }

    Button {
        id: guildFrameColumnHeader3
        name: "GuildFrameColumnHeader3"
        text: "Lvl"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameColumnHeader2.right
        anchors.leftMargin: -2
        anchors.verticalCenter: guildFrameColumnHeader2.verticalCenter
        width: 32
        height: 22
    }

    Button {
        id: guildFrameColumnHeader4
        name: "GuildFrameColumnHeader4"
        text: "Class"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameColumnHeader3.right
        anchors.leftMargin: -2
        anchors.verticalCenter: guildFrameColumnHeader3.verticalCenter
        width: 92
        height: 22
    }

    Button {
        id: guildFrameControlButton
        name: "GuildFrameControlButton"
        text: "Guild Control"
        wowParent: "GuildFrame"
        style: "Button"
        pin: "all"
        anchors.left: guildFrameAddMemberButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: guildFrameAddMemberButton.verticalCenter
        width: 96.7
        height: 22
    }

    FontString {
        id: guildFrameControlButtonText
        name: "GuildFrameControlButtonText"
        text: "Guild Control"
        wowParent: "GuildFrameControlButton"
        anchors.horizontalCenter: guildFrameControlButton.horizontalCenter
        anchors.verticalCenter: guildFrameControlButton.verticalCenter
        width: 72.7
        height: 10.3
    }

    Button {
        id: guildFrameGuildInformationButton
        name: "GuildFrameGuildInformationButton"
        text: "Guild Information"
        wowParent: "GuildFrame"
        style: "Button"
        pin: "all"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 122.9
        height: 22
    }

    FontString {
        id: guildFrameGuildInformationButtonText
        name: "GuildFrameGuildInformationButtonText"
        text: "Guild Information"
        wowParent: "GuildFrameGuildInformationButton"
        anchors.horizontalCenter: guildFrameGuildInformationButton.horizontalCenter
        anchors.verticalCenter: guildFrameGuildInformationButton.verticalCenter
        width: 98.8
        height: 10.3
    }

    Button {
        id: guildFrameGuildListToggleButton
        name: "GuildFrameGuildListToggleButton"
        text: "Player Status"
        wowParent: "GuildFrame"
        anchors.left: guildFrame.left
        anchors.leftMargin: 307
        anchors.verticalCenter: guildFrame.verticalCenter
        anchors.verticalCenterOffset: 34
        width: 32
        height: 32
    }

    CheckButton {
        id: guildFrameLFGButton
        name: "GuildFrameLFGButton"
        wowParent: "GuildFrameLFGFrame"
        style: "CheckBox"
        anchors.left: friendsFrameDiabolicBand.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: guildFrameLFGButtonText
        name: "GuildFrameLFGButtonText"
        text: "Show Offline Members"
        wowParent: "GuildFrameLFGButton"
        anchors.left: guildFrameLFGButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameLFGButton.verticalCenter
        width: 129.6
        height: 14.2
    }

    Frame {
        id: guildFrameLFGFrame
        name: "GuildFrameLFGFrame"
        wowParent: "GuildFrame"
        anchors.right: guildFrame.right
        anchors.rightMargin: 42
        anchors.top: guildFrame.top
        anchors.topMargin: 13
        width: 210
        height: 23
    }

    FontString {
        id: guildFrameNotesLabel
        name: "GuildFrameNotesLabel"
        text: "Guild Message Of The Day:"
        wowParent: "GuildFrame"
        anchors.left: guildFrame.left
        anchors.leftMargin: 23
        anchors.top: guildFrame.top
        anchors.topMargin: 319
        width: 225
        height: 11
    }

    FontString {
        id: guildFrameNotesText
        name: "GuildFrameNotesText"
        text: "https://discord.gg/Xkh2Q6kW4m - WE NEED MORE PET PICTURES "
        wowParent: "GuildFrame"
        anchors.left: guildFrameNotesLabel.left
        anchors.top: guildFrameNotesLabel.bottom
        anchors.topMargin: 3
        width: 315
        height: 36
    }

    FontString {
        id: guildFrameOnlineTotals
        name: "GuildFrameOnlineTotals"
        wowParent: "GuildFrame"
        anchors.left: guildFrameTotals.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameTotals.verticalCenter
        width: 53.7
        height: 16
    }

    FontString {
        id: guildFrameTotals
        name: "GuildFrameTotals"
        wowParent: "GuildFrame"
        anchors.horizontalCenter: guildFrame.left
        anchors.horizontalCenterOffset: 75
        anchors.bottom: guildFrame.verticalCenter
        anchors.bottomMargin: -42
        width: 92.4
        height: 16
    }

    Button {
        id: guildInfoCancelButton
        name: "GuildInfoCancelButton"
        text: "Close"
        wowParent: "GuildInfoFrame"
        style: "Button"
        anchors.right: guildInfoFrame.right
        anchors.rightMargin: 9
        anchors.bottom: guildInfoFrame.bottom
        anchors.bottomMargin: 12
        width: 87
        height: 22
    }

    FontString {
        id: guildInfoCancelButtonText
        name: "GuildInfoCancelButtonText"
        text: "Close"
        wowParent: "GuildInfoCancelButton"
        anchors.horizontalCenter: guildInfoCancelButton.horizontalCenter
        anchors.verticalCenter: guildInfoCancelButton.verticalCenter
        width: 30
        height: 10.3
    }

    Button {
        id: guildInfoCloseButton
        name: "GuildInfoCloseButton"
        wowParent: "GuildInfoFrame"
        anchors.right: guildInfoFrame.right
        anchors.rightMargin: 3
        anchors.top: guildInfoFrame.top
        anchors.topMargin: 3
        width: 22
        height: 22
    }

    EditBox {
        id: guildInfoEditBox
        name: "GuildInfoEditBox"
        wowParent: "GuildInfoFrameScrollFrame"
        anchors.left: guildInfoFrameScrollFrame.left
        anchors.top: guildInfoFrameScrollFrame.top
        width: 240
        height: 118.5
    }

    Frame {
        id: guildInfoFrame
        name: "GuildInfoFrame"
        wowParent: "FriendsFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 297
        height: 298
    }

    ScrollFrame {
        id: guildInfoFrameScrollFrame
        name: "GuildInfoFrameScrollFrame"
        wowParent: "GuildInfoTextBackground"
        anchors.left: guildInfoTextBackground.left
        anchors.leftMargin: 5
        anchors.top: guildInfoTextBackground.top
        anchors.topMargin: 7
        width: 243
        height: 208
    }

    Slider {
        id: guildInfoFrameScrollFrameScrollBar
        name: "GuildInfoFrameScrollFrameScrollBar"
        wowParent: "GuildInfoFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: guildInfoFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: guildInfoFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 176
    }

    Frame {
        id: guildInfoFrameScrollFrameScrollBarDiabolicTrack
        name: "GuildInfoFrameScrollFrameScrollBarDiabolicTrack"
        wowParent: "GuildInfoFrameScrollFrameScrollBar"
        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildInfoFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 210
    }

    Button {
        id: guildInfoFrameScrollFrameScrollBarScrollDownButton
        name: "GuildInfoFrameScrollFrameScrollBarScrollDownButton"
        wowParent: "GuildInfoFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: guildInfoFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: guildInfoFrameScrollFrameScrollBarScrollUpButton
        name: "GuildInfoFrameScrollFrameScrollBarScrollUpButton"
        wowParent: "GuildInfoFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildInfoFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Button {
        id: guildInfoGuildEventButton
        name: "GuildInfoGuildEventButton"
        text: "Log"
        wowParent: "GuildInfoFrame"
        style: "Button"
        anchors.right: guildInfoSaveButton.left
        anchors.rightMargin: 32
        anchors.verticalCenter: guildInfoSaveButton.verticalCenter
        width: 65
        height: 22
    }

    FontString {
        id: guildInfoGuildEventButtonText
        name: "GuildInfoGuildEventButtonText"
        text: "Log"
        wowParent: "GuildInfoGuildEventButton"
        anchors.horizontalCenter: guildInfoGuildEventButton.horizontalCenter
        anchors.verticalCenter: guildInfoGuildEventButton.verticalCenter
        width: 20.5
        height: 10.3
    }

    Button {
        id: guildInfoSaveButton
        name: "GuildInfoSaveButton"
        text: "Accept"
        wowParent: "GuildInfoFrame"
        style: "Button"
        anchors.right: guildInfoFrame.right
        anchors.rightMargin: 102
        anchors.bottom: guildInfoFrame.bottom
        anchors.bottomMargin: 12
        width: 87
        height: 22
    }

    FontString {
        id: guildInfoSaveButtonText
        name: "GuildInfoSaveButtonText"
        text: "Accept"
        wowParent: "GuildInfoSaveButton"
        anchors.horizontalCenter: guildInfoSaveButton.horizontalCenter
        anchors.verticalCenter: guildInfoSaveButton.verticalCenter
        width: 37.1
        height: 10.3
    }

    Frame {
        id: guildInfoTextBackground
        name: "GuildInfoTextBackground"
        wowParent: "GuildInfoFrame"
        anchors.left: guildInfoFrame.left
        anchors.leftMargin: 11
        anchors.top: guildInfoFrame.top
        anchors.topMargin: 42
        width: 276
        height: 220
    }

    FontString {
        id: guildInfoTitle
        name: "GuildInfoTitle"
        text: "Guild Information"
        wowParent: "GuildInfoFrame"
        anchors.left: guildInfoFrame.left
        anchors.leftMargin: 17
        anchors.top: guildInfoFrame.top
        anchors.topMargin: 17
        width: 105.1
        height: 11.9
    }

    Frame {
        id: guildListScrollFrameDiabolicZone
        name: "GuildListScrollFrameDiabolicZone"
        wowParent: "GuildFrame"
        anchors.left: guildListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: guildListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 240
    }

    Frame {
        id: guildListScrollFrameDiabolicZoneColumnBar
        name: "GuildListScrollFrameDiabolicZoneColumnBar"
        wowParent: "GuildListScrollFrameDiabolicZone"
        anchors.left: guildListScrollFrameDiabolicZone.left
        anchors.bottom: guildListScrollFrameDiabolicZone.top
        width: 330
        height: 22
    }

    Button {
        id: guildMOTDEditButton
        name: "GuildMOTDEditButton"
        wowParent: "GuildFrame"
        anchors.left: guildFrameNotesText.left
        anchors.top: guildFrameNotesText.top
        width: 315
        height: 36
    }

    Frame {
        id: guildMemberDetailFrame
        name: "GuildMemberDetailFrame"
        wowParent: "GuildFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 212
        height: 270
    }

    Frame {
        id: guildPlayerStatusFrame
        name: "GuildPlayerStatusFrame"
        wowParent: "GuildFrame"
        anchors.left: guildFrame.left
        anchors.top: guildFrame.top
        anchors.topMargin: -25
        width: 300
        height: 200
    }

    Frame {
        id: ignoreListFrame
        name: "IgnoreListFrame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Frame {
        id: raidFrame
        name: "RaidFrame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Button {
        id: raidFrameConvertToRaidButton
        name: "RaidFrameConvertToRaidButton"
        text: "Convert To Raid"
        wowParent: "RaidFrame"
        style: "Button"
        anchors.right: friendsFrameDiabolicBand.horizontalCenter
        anchors.rightMargin: 4
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 115
        height: 21
    }

    FontString {
        id: raidFrameConvertToRaidButtonText
        name: "RaidFrameConvertToRaidButtonText"
        text: "Convert To Raid"
        wowParent: "RaidFrameConvertToRaidButton"
        anchors.horizontalCenter: raidFrameConvertToRaidButton.horizontalCenter
        anchors.verticalCenter: raidFrameConvertToRaidButton.verticalCenter
        width: 86.9
        height: 10.3
    }

    Frame {
        id: raidFrameNotInRaid
        name: "RaidFrameNotInRaid"
        wowParent: "RaidFrame"
        anchors.left: raidFrame.left
        anchors.top: raidFrame.top
        width: 384
        height: 512
    }

    Button {
        id: raidFrameNotInRaidRaidBrowserButton
        name: "RaidFrameNotInRaidRaidBrowserButton"
        text: "Open Raid Browser"
        wowParent: "RaidFrameNotInRaid"
        style: "Button"
        anchors.horizontalCenter: raidFrameRaidBrowserDescription.horizontalCenter
        anchors.top: raidFrameRaidBrowserDescription.bottom
        anchors.topMargin: 10
        width: 260
        height: 22
    }

    FontString {
        id: raidFrameNotInRaidRaidBrowserButtonText
        name: "RaidFrameNotInRaidRaidBrowserButtonText"
        text: "Open Raid Browser"
        wowParent: "RaidFrameNotInRaidRaidBrowserButton"
        anchors.horizontalCenter: raidFrameNotInRaidRaidBrowserButton.horizontalCenter
        anchors.verticalCenter: raidFrameNotInRaidRaidBrowserButton.verticalCenter
        width: 105.1
        height: 10.3
    }

    FontString {
        id: raidFrameRaidBrowserDescription
        name: "RaidFrameRaidBrowserDescription"
        text: "Find a Raid Group or Assemble a Raid"
        wowParent: "RaidFrameNotInRaid"
        anchors.horizontalCenter: raidFrameRaidDescription.horizontalCenter
        anchors.top: raidFrameRaidDescription.bottom
        anchors.topMargin: 50
        width: 300
        height: 11.9
    }

    FontString {
        id: raidFrameRaidDescription
        name: "RaidFrameRaidDescription"
        wowParent: "RaidFrameNotInRaid"
        anchors.left: raidFrameNotInRaid.left
        anchors.leftMargin: 29
        anchors.top: raidFrameNotInRaid.top
        anchors.topMargin: 85
        width: 300
        height: 165.9
    }

    Button {
        id: raidFrameRaidInfoButton
        name: "RaidFrameRaidInfoButton"
        text: "Raid Info"
        wowParent: "RaidFrame"
        style: "Button"
        anchors.left: friendsFrameDiabolicBand.horizontalCenter
        anchors.leftMargin: 4
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 90
        height: 21
    }

    FontString {
        id: raidFrameRaidInfoButtonText
        name: "RaidFrameRaidInfoButtonText"
        text: "Raid Info"
        wowParent: "RaidFrameRaidInfoButton"
        anchors.horizontalCenter: raidFrameRaidInfoButton.horizontalCenter
        anchors.verticalCenter: raidFrameRaidInfoButton.verticalCenter
        width: 50.6
        height: 10.3
    }

    Frame {
        id: whoFrame
        name: "WhoFrame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Button {
        id: whoFrameAddFriendButton
        name: "WhoFrameAddFriendButton"
        text: "Add Friend"
        wowParent: "WhoFrame"
        style: "Button"
        pin: "all"
        anchors.left: whoFrameWhoButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: whoFrameWhoButton.verticalCenter
        width: 106.8
        height: 22
    }

    FontString {
        id: whoFrameAddFriendButtonText
        name: "WhoFrameAddFriendButtonText"
        text: "Add Friend"
        wowParent: "WhoFrameAddFriendButton"
        anchors.horizontalCenter: whoFrameAddFriendButton.horizontalCenter
        anchors.verticalCenter: whoFrameAddFriendButton.verticalCenter
        width: 59.3
        height: 10.3
    }

    Button {
        id: whoFrameButton1
        name: "WhoFrameButton1"
        wowParent: "WhoFrame"
        pin: "place"
        anchors.left: whoFrame.left
        anchors.leftMargin: 15
        anchors.top: whoFrame.top
        anchors.topMargin: 61
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton1Class
        name: "WhoFrameButton1Class"
        text: "Paladin"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton1Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton1Level
        name: "WhoFrameButton1Level"
        text: "30"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton1Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton1Name
        name: "WhoFrameButton1Name"
        text: "Avitar"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton1.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton1Variable
        name: "WhoFrameButton1Variable"
        text: "Hillsbrad Foothills"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1Name.right
        anchors.verticalCenter: whoFrameButton1Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameColumnHeader1
        name: "WhoFrameColumnHeader1"
        text: "Name"
        wowParent: "WhoFrame"
        pin: "place"
        anchors.left: whoFrame.left
        anchors.leftMargin: 20
        anchors.top: whoFrame.top
        anchors.topMargin: 34
        width: 83
        height: 22
    }

    Button {
        id: whoFrameColumnHeader2
        name: "WhoFrameColumnHeader2"
        text: "Zone"
        wowParent: "WhoFrame"
        anchors.left: whoFrameColumnHeader1.right
        anchors.leftMargin: -2
        anchors.verticalCenter: whoFrameColumnHeader1.verticalCenter
        width: 120
        height: 22
    }

    Button {
        id: whoFrameColumnHeader3
        name: "WhoFrameColumnHeader3"
        text: "Lvl"
        wowParent: "WhoFrame"
        anchors.left: whoFrameColumnHeader2.right
        anchors.leftMargin: -2
        anchors.verticalCenter: whoFrameColumnHeader2.verticalCenter
        width: 32
        height: 22
    }

    Button {
        id: whoFrameColumnHeader4
        name: "WhoFrameColumnHeader4"
        text: "Class"
        wowParent: "WhoFrame"
        anchors.left: whoFrameColumnHeader3.right
        anchors.leftMargin: -2
        anchors.verticalCenter: whoFrameColumnHeader3.verticalCenter
        width: 92
        height: 22
    }

    Frame {
        id: whoFrameDropDown
        name: "WhoFrameDropDown"
        wowParent: "WhoFrameColumnHeader2"
        style: "DropDown"
        anchors.left: friendsFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 114
        height: 32
    }

    Button {
        id: whoFrameDropDownButton
        name: "WhoFrameDropDownButton"
        wowParent: "WhoFrameDropDown"
        anchors.right: whoFrameDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: whoFrameDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: whoFrameDropDownDiabolicField
        name: "WhoFrameDropDownDiabolicField"
        wowParent: "WhoFrameDropDown"
        anchors.left: whoFrameDropDown.left
        anchors.verticalCenter: whoFrameDropDown.verticalCenter
        width: 114
        height: 22
    }

    FontString {
        id: whoFrameDropDownText
        name: "WhoFrameDropDownText"
        text: "Zone"
        wowParent: "WhoFrameDropDown"
        anchors.horizontalCenter: whoFrameDropDown.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: whoFrameDropDown.verticalCenter
        width: 39
        height: 10
    }

    EditBox {
        id: whoFrameEditBox
        name: "WhoFrameEditBox"
        wowParent: "WhoFrame"
        style: "EditBox"
        anchors.left: whoFrameDropDown.right
        anchors.leftMargin: 4
        anchors.verticalCenter: whoFrameDropDown.verticalCenter
        width: 200
        height: 20
    }

    Frame {
        id: whoFrameEditBoxDiabolicField
        name: "WhoFrameEditBoxDiabolicField"
        wowParent: "WhoFrameEditBox"
        anchors.left: whoFrameEditBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: whoFrameEditBox.verticalCenter
        width: 216
        height: 22
    }

    Button {
        id: whoFrameGroupInviteButton
        name: "WhoFrameGroupInviteButton"
        text: "Group Invite"
        wowParent: "WhoFrame"
        style: "Button"
        pin: "all"
        anchors.left: whoFrameAddFriendButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: whoFrameAddFriendButton.verticalCenter
        width: 117.8
        height: 22
    }

    FontString {
        id: whoFrameGroupInviteButtonText
        name: "WhoFrameGroupInviteButtonText"
        text: "Group Invite"
        wowParent: "WhoFrameGroupInviteButton"
        anchors.horizontalCenter: whoFrameGroupInviteButton.horizontalCenter
        anchors.verticalCenter: whoFrameGroupInviteButton.verticalCenter
        width: 70.3
        height: 10.3
    }

    FontString {
        id: whoFrameTotals
        name: "WhoFrameTotals"
        text: "0 People Found  "
        wowParent: "WhoFrame"
        anchors.horizontalCenter: whoFrame.horizontalCenter
        anchors.horizontalCenterOffset: -10
        anchors.bottom: whoFrame.bottom
        anchors.bottomMargin: 127
        width: 298
        height: 16
    }

    Button {
        id: whoFrameWhoButton
        name: "WhoFrameWhoButton"
        text: "Refresh"
        wowParent: "WhoFrame"
        style: "Button"
        pin: "all"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 89.4
        height: 22
    }

    FontString {
        id: whoFrameWhoButtonText
        name: "WhoFrameWhoButtonText"
        text: "Refresh"
        wowParent: "WhoFrameWhoButton"
        anchors.horizontalCenter: whoFrameWhoButton.horizontalCenter
        anchors.verticalCenter: whoFrameWhoButton.verticalCenter
        width: 41.9
        height: 10.3
    }

    ScrollFrame {
        id: whoListScrollFrame
        name: "WhoListScrollFrame"
        wowParent: "WhoFrame"
        pin: "place"
        anchors.right: friendsFrame.right
        anchors.rightMargin: 67
        anchors.top: friendsFrame.top
        anchors.topMargin: 62
        width: 296
        height: 298
    }

    Frame {
        id: whoListScrollFrameDiabolicZone
        name: "WhoListScrollFrameDiabolicZone"
        wowParent: "WhoFrame"
        anchors.left: whoListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: whoListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 328
    }

    Frame {
        id: whoListScrollFrameDiabolicZoneColumnBar
        name: "WhoListScrollFrameDiabolicZoneColumnBar"
        wowParent: "WhoListScrollFrameDiabolicZone"
        anchors.left: whoListScrollFrameDiabolicZone.left
        anchors.bottom: whoListScrollFrameDiabolicZone.top
        width: 330
        height: 22
    }

    Slider {
        id: whoListScrollFrameScrollBar
        name: "WhoListScrollFrameScrollBar"
        wowParent: "WhoListScrollFrame"
        style: "ScrollBar"
        anchors.left: whoListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: whoListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 266
    }

    Frame {
        id: whoListScrollFrameScrollBarDiabolicTrack
        name: "WhoListScrollFrameScrollBarDiabolicTrack"
        wowParent: "WhoListScrollFrameScrollBar"
        anchors.horizontalCenter: whoListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: whoListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 300
    }

    Button {
        id: whoListScrollFrameScrollBarScrollDownButton
        name: "WhoListScrollFrameScrollBarScrollDownButton"
        wowParent: "WhoListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: whoListScrollFrameScrollBar.horizontalCenter
        anchors.top: whoListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: whoListScrollFrameScrollBarScrollUpButton
        name: "WhoListScrollFrameScrollBarScrollUpButton"
        wowParent: "WhoListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: whoListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: whoListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: whoListScrollFrameScrollChildFrame
        name: "WhoListScrollFrameScrollChildFrame"
        wowParent: "WhoListScrollFrame"
        anchors.left: whoListScrollFrame.left
        anchors.top: whoListScrollFrame.top
        anchors.topMargin: -480
        width: 300
        height: 784
    }

    // kept as they are, at the foot's ends
    WowRow {
        name: "FriendsButtons"
        parts: ["FriendsFrameAddFriendButton", "FriendsFrameSendMessageButton"]
        fit: "ends"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 31
    }

    WowRow {
        name: "WhoButtons"
        parts: ["WhoFrameWhoButton", "WhoFrameAddFriendButton", "WhoFrameGroupInviteButton"]
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    WowRow {
        name: "GuildButtons"
        parts: ["GuildFrameGuildInformationButton", "GuildFrameAddMemberButton", "GuildFrameControlButton"]
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    Ghost { id: channelButton2; name: "ChannelButton2"; x: 20; y: 96; width: 155; height: 20 }
    Ghost { id: channelButton6; name: "ChannelButton6"; x: 20; y: 176; width: 155; height: 20 }
    Ghost { id: channelButton7; name: "ChannelButton7"; x: 20; y: 196; width: 155; height: 20 }
    Ghost { id: friendsFrameFriendsScrollFrameButton9; name: "FriendsFrameFriendsScrollFrameButton9"; x: 21; y: 308; width: 298; height: 34 }
    Ghost { id: guildListScrollFrame; name: "GuildListScrollFrame"; x: 21; y: 73; width: 0; height: 0 }
    Ghost { id: uIParent; name: "UIParent"; x: 738.5; y: 290.6; width: 0; height: 0 }
}
