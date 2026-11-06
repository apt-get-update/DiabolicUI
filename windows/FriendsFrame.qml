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

    Button {
        id: channelButton2
        name: "ChannelButton2"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton1.left
        anchors.top: channelButton1.bottom
        width: 155
        height: 20
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
        id: channelButton2Text
        name: "ChannelButton2Text"
        wowParent: "ChannelButton2"
        anchors.left: channelButton2.left
        anchors.leftMargin: 5
        anchors.verticalCenter: channelButton2.verticalCenter
        width: 135
        height: 8
    }

    Button {
        id: channelButton3
        name: "ChannelButton3"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton2.left
        anchors.top: channelButton2.bottom
        width: 155
        height: 20
    }

    FontString {
        id: channelButton3Text
        name: "ChannelButton3Text"
        wowParent: "ChannelButton3"
        anchors.left: channelButton3.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton3.verticalCenter
        width: 119
        height: 8
    }

    Button {
        id: channelButton4
        name: "ChannelButton4"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton3.left
        anchors.top: channelButton3.bottom
        width: 155
        height: 20
    }

    FontString {
        id: channelButton4Text
        name: "ChannelButton4Text"
        wowParent: "ChannelButton4"
        anchors.left: channelButton4.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton4.verticalCenter
        width: 119
        height: 8
    }

    Button {
        id: channelButton5
        name: "ChannelButton5"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton4.left
        anchors.top: channelButton4.bottom
        width: 155
        height: 20
    }

    FontString {
        id: channelButton5Text
        name: "ChannelButton5Text"
        wowParent: "ChannelButton5"
        anchors.left: channelButton5.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton5.verticalCenter
        width: 119
        height: 8
    }

    Button {
        id: channelButton6
        name: "ChannelButton6"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton5.left
        anchors.top: channelButton5.bottom
        width: 155
        height: 20
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
        id: channelButton6Text
        name: "ChannelButton6Text"
        wowParent: "ChannelButton6"
        anchors.left: channelButton6.left
        anchors.leftMargin: 5
        anchors.verticalCenter: channelButton6.verticalCenter
        width: 151
        height: 8
    }

    Button {
        id: channelButton7
        name: "ChannelButton7"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton6.left
        anchors.top: channelButton6.bottom
        width: 155
        height: 20
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

    FontString {
        id: channelButton7Text
        name: "ChannelButton7Text"
        wowParent: "ChannelButton7"
        anchors.left: channelButton7.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton7.verticalCenter
        width: 119
        height: 8
    }

    Button {
        id: channelButton8
        name: "ChannelButton8"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton7.left
        anchors.top: channelButton7.bottom
        width: 155
        height: 20
    }

    FontString {
        id: channelButton8Text
        name: "ChannelButton8Text"
        wowParent: "ChannelButton8"
        anchors.left: channelButton8.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton8.verticalCenter
        width: 119
        height: 8
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

    Button {
        id: channelMemberButton10
        name: "ChannelMemberButton10"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton9.left
        anchors.top: channelMemberButton9.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton10Name
        name: "ChannelMemberButton10Name"
        text: "Carez"
        wowParent: "?"
        anchors.left: channelMemberButton10.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton10.top
        anchors.topMargin: 1
        width: 30.8
        height: 10.3
    }

    Button {
        id: channelMemberButton11
        name: "ChannelMemberButton11"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton10.left
        anchors.top: channelMemberButton10.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton11Name
        name: "ChannelMemberButton11Name"
        text: "Cattiviy"
        wowParent: "?"
        anchors.left: channelMemberButton11.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton11.top
        anchors.topMargin: 1
        width: 41.9
        height: 10.3
    }

    Button {
        id: channelMemberButton12
        name: "ChannelMemberButton12"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton11.left
        anchors.top: channelMemberButton11.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton12Name
        name: "ChannelMemberButton12Name"
        text: "Chickenbutt"
        wowParent: "?"
        anchors.left: channelMemberButton12.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton12.top
        anchors.topMargin: 1
        width: 62.4
        height: 10.3
    }

    Button {
        id: channelMemberButton13
        name: "ChannelMemberButton13"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton12.left
        anchors.top: channelMemberButton12.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton13Name
        name: "ChannelMemberButton13Name"
        text: "Chilliwilli"
        wowParent: "?"
        anchors.left: channelMemberButton13.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton13.top
        anchors.topMargin: 1
        width: 48.2
        height: 10.3
    }

    Button {
        id: channelMemberButton14
        name: "ChannelMemberButton14"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton13.left
        anchors.top: channelMemberButton13.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton14Name
        name: "ChannelMemberButton14Name"
        text: "Chillydruid"
        wowParent: "?"
        anchors.left: channelMemberButton14.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton14.top
        anchors.topMargin: 1
        width: 57.7
        height: 10.3
    }

    Button {
        id: channelMemberButton15
        name: "ChannelMemberButton15"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton14.left
        anchors.top: channelMemberButton14.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton15Name
        name: "ChannelMemberButton15Name"
        text: "Dirtymerlin"
        wowParent: "?"
        anchors.left: channelMemberButton15.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton15.top
        anchors.topMargin: 1
        width: 60
        height: 10.3
    }

    Button {
        id: channelMemberButton16
        name: "ChannelMemberButton16"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton15.left
        anchors.top: channelMemberButton15.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton16Name
        name: "ChannelMemberButton16Name"
        text: "Dodedodedum"
        wowParent: "?"
        anchors.left: channelMemberButton16.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton16.top
        anchors.topMargin: 1
        width: 80.6
        height: 10.3
    }

    Button {
        id: channelMemberButton17
        name: "ChannelMemberButton17"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton16.left
        anchors.top: channelMemberButton16.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton17Name
        name: "ChannelMemberButton17Name"
        text: "Dornoxia"
        wowParent: "?"
        anchors.left: channelMemberButton17.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton17.top
        anchors.topMargin: 1
        width: 49
        height: 10.3
    }

    Button {
        id: channelMemberButton18
        name: "ChannelMemberButton18"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton17.left
        anchors.top: channelMemberButton17.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton18Name
        name: "ChannelMemberButton18Name"
        text: "Endorhim"
        wowParent: "?"
        anchors.left: channelMemberButton18.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton18.top
        anchors.topMargin: 1
        width: 51.4
        height: 10.3
    }

    Button {
        id: channelMemberButton19
        name: "ChannelMemberButton19"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton18.left
        anchors.top: channelMemberButton18.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton19Name
        name: "ChannelMemberButton19Name"
        text: "Ependytis"
        wowParent: "?"
        anchors.left: channelMemberButton19.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton19.top
        anchors.topMargin: 1
        width: 52.9
        height: 10.3
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

    Button {
        id: channelMemberButton2
        name: "ChannelMemberButton2"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton1.left
        anchors.top: channelMemberButton1.bottom
        width: 135
        height: 15
    }

    Button {
        id: channelMemberButton20
        name: "ChannelMemberButton20"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton19.left
        anchors.top: channelMemberButton19.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton20Name
        name: "ChannelMemberButton20Name"
        text: "Estra"
        wowParent: "?"
        anchors.left: channelMemberButton20.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton20.top
        anchors.topMargin: 1
        width: 26.9
        height: 10.3
    }

    Button {
        id: channelMemberButton21
        name: "ChannelMemberButton21"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton20.left
        anchors.top: channelMemberButton20.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton21Name
        name: "ChannelMemberButton21Name"
        text: "Faenielle"
        wowParent: "?"
        anchors.left: channelMemberButton21.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton21.top
        anchors.topMargin: 1
        width: 48.2
        height: 10.3
    }

    Button {
        id: channelMemberButton22
        name: "ChannelMemberButton22"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton21.left
        anchors.top: channelMemberButton21.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton22Name
        name: "ChannelMemberButton22Name"
        text: "Fercho"
        wowParent: "?"
        anchors.left: channelMemberButton22.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton22.top
        anchors.topMargin: 1
        width: 35.6
        height: 10.3
    }

    FontString {
        id: channelMemberButton2Name
        name: "ChannelMemberButton2Name"
        text: "Aendriel"
        wowParent: "?"
        anchors.left: channelMemberButton2.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton2.top
        anchors.topMargin: 1
        width: 45
        height: 10.3
    }

    Button {
        id: channelMemberButton3
        name: "ChannelMemberButton3"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton2.left
        anchors.top: channelMemberButton2.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton3Name
        name: "ChannelMemberButton3Name"
        text: "Aldore"
        wowParent: "?"
        anchors.left: channelMemberButton3.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton3.top
        anchors.topMargin: 1
        width: 37.1
        height: 10.3
    }

    Button {
        id: channelMemberButton4
        name: "ChannelMemberButton4"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton3.left
        anchors.top: channelMemberButton3.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton4Name
        name: "ChannelMemberButton4Name"
        text: "Amarin"
        wowParent: "?"
        anchors.left: channelMemberButton4.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton4.top
        anchors.topMargin: 1
        width: 39.5
        height: 10.3
    }

    Button {
        id: channelMemberButton5
        name: "ChannelMemberButton5"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton4.left
        anchors.top: channelMemberButton4.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton5Name
        name: "ChannelMemberButton5Name"
        text: "Aquablue"
        wowParent: "?"
        anchors.left: channelMemberButton5.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton5.top
        anchors.topMargin: 1
        width: 51.4
        height: 10.3
    }

    Button {
        id: channelMemberButton6
        name: "ChannelMemberButton6"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton5.left
        anchors.top: channelMemberButton5.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton6Name
        name: "ChannelMemberButton6Name"
        text: "Archidruid"
        wowParent: "?"
        anchors.left: channelMemberButton6.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton6.top
        anchors.topMargin: 1
        width: 55.3
        height: 10.3
    }

    Button {
        id: channelMemberButton7
        name: "ChannelMemberButton7"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton6.left
        anchors.top: channelMemberButton6.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton7Name
        name: "ChannelMemberButton7Name"
        text: "Armlok"
        wowParent: "?"
        anchors.left: channelMemberButton7.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton7.top
        anchors.topMargin: 1
        width: 40.3
        height: 10.3
    }

    Button {
        id: channelMemberButton8
        name: "ChannelMemberButton8"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton7.left
        anchors.top: channelMemberButton7.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton8Name
        name: "ChannelMemberButton8Name"
        text: "Bleedfury"
        wowParent: "?"
        anchors.left: channelMemberButton8.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton8.top
        anchors.topMargin: 1
        width: 52.1
        height: 10.3
    }

    Button {
        id: channelMemberButton9
        name: "ChannelMemberButton9"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton8.left
        anchors.top: channelMemberButton8.bottom
        width: 135
        height: 15
    }

    FontString {
        id: channelMemberButton9Name
        name: "ChannelMemberButton9Name"
        text: "Bmachie"
        wowParent: "?"
        anchors.left: channelMemberButton9.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton9.top
        anchors.topMargin: 1
        width: 46.6
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
        anchors.bottomMargin: 41
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

    Button {
        id: friendsFrameFriendsScrollFrameButton10
        name: "FriendsFrameFriendsScrollFrameButton10"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton9.left
        anchors.top: friendsFrameFriendsScrollFrameButton9.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton10Info
        name: "FriendsFrameFriendsScrollFrameButton10Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton10"
        anchors.left: friendsFrameFriendsScrollFrameButton10Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton10Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton10Name
        name: "FriendsFrameFriendsScrollFrameButton10Name"
        text: "Enby"
        wowParent: "FriendsFrameFriendsScrollFrameButton10"
        anchors.left: friendsFrameFriendsScrollFrameButton10.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton10.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton11
        name: "FriendsFrameFriendsScrollFrameButton11"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton10.left
        anchors.top: friendsFrameFriendsScrollFrameButton10.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton11Info
        name: "FriendsFrameFriendsScrollFrameButton11Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton11"
        anchors.left: friendsFrameFriendsScrollFrameButton11Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton11Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton11Name
        name: "FriendsFrameFriendsScrollFrameButton11Name"
        text: "Eske"
        wowParent: "FriendsFrameFriendsScrollFrameButton11"
        anchors.left: friendsFrameFriendsScrollFrameButton11.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton11.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton12
        name: "FriendsFrameFriendsScrollFrameButton12"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton11.left
        anchors.top: friendsFrameFriendsScrollFrameButton11.bottom
        width: 298
        height: 680
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton12Info
        name: "FriendsFrameFriendsScrollFrameButton12Info"
        wowParent: "FriendsFrameFriendsScrollFrameButton12"
        anchors.left: friendsFrameFriendsScrollFrameButton12Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton12Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton12Name
        name: "FriendsFrameFriendsScrollFrameButton12Name"
        wowParent: "FriendsFrameFriendsScrollFrameButton12"
        anchors.left: friendsFrameFriendsScrollFrameButton12.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton12.top
        anchors.topMargin: 3
        width: 248
        height: 12
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

    Button {
        id: friendsFrameFriendsScrollFrameButton2
        name: "FriendsFrameFriendsScrollFrameButton2"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton1.left
        anchors.top: friendsFrameFriendsScrollFrameButton1.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton2Info
        name: "FriendsFrameFriendsScrollFrameButton2Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton2"
        anchors.left: friendsFrameFriendsScrollFrameButton2Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton2Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton2Name
        name: "FriendsFrameFriendsScrollFrameButton2Name"
        text: "Apoyagtten"
        wowParent: "FriendsFrameFriendsScrollFrameButton2"
        anchors.left: friendsFrameFriendsScrollFrameButton2.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton2.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton3
        name: "FriendsFrameFriendsScrollFrameButton3"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton2.left
        anchors.top: friendsFrameFriendsScrollFrameButton2.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton3Info
        name: "FriendsFrameFriendsScrollFrameButton3Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton3"
        anchors.left: friendsFrameFriendsScrollFrameButton3Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton3Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton3Name
        name: "FriendsFrameFriendsScrollFrameButton3Name"
        text: "Clydruid"
        wowParent: "FriendsFrameFriendsScrollFrameButton3"
        anchors.left: friendsFrameFriendsScrollFrameButton3.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton3.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton4
        name: "FriendsFrameFriendsScrollFrameButton4"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton3.left
        anchors.top: friendsFrameFriendsScrollFrameButton3.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton4Info
        name: "FriendsFrameFriendsScrollFrameButton4Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton4"
        anchors.left: friendsFrameFriendsScrollFrameButton4Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton4Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton4Name
        name: "FriendsFrameFriendsScrollFrameButton4Name"
        text: "Cottonee"
        wowParent: "FriendsFrameFriendsScrollFrameButton4"
        anchors.left: friendsFrameFriendsScrollFrameButton4.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton4.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton5
        name: "FriendsFrameFriendsScrollFrameButton5"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton4.left
        anchors.top: friendsFrameFriendsScrollFrameButton4.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton5Info
        name: "FriendsFrameFriendsScrollFrameButton5Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton5"
        anchors.left: friendsFrameFriendsScrollFrameButton5Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton5Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton5Name
        name: "FriendsFrameFriendsScrollFrameButton5Name"
        text: "Darkdrifter"
        wowParent: "FriendsFrameFriendsScrollFrameButton5"
        anchors.left: friendsFrameFriendsScrollFrameButton5.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton5.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton6
        name: "FriendsFrameFriendsScrollFrameButton6"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton5.left
        anchors.top: friendsFrameFriendsScrollFrameButton5.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton6Info
        name: "FriendsFrameFriendsScrollFrameButton6Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton6"
        anchors.left: friendsFrameFriendsScrollFrameButton6Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton6Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton6Name
        name: "FriendsFrameFriendsScrollFrameButton6Name"
        text: "Dcde"
        wowParent: "FriendsFrameFriendsScrollFrameButton6"
        anchors.left: friendsFrameFriendsScrollFrameButton6.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton6.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton7
        name: "FriendsFrameFriendsScrollFrameButton7"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton6.left
        anchors.top: friendsFrameFriendsScrollFrameButton6.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton7Info
        name: "FriendsFrameFriendsScrollFrameButton7Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton7"
        anchors.left: friendsFrameFriendsScrollFrameButton7Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton7Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton7Name
        name: "FriendsFrameFriendsScrollFrameButton7Name"
        text: "Decadde"
        wowParent: "FriendsFrameFriendsScrollFrameButton7"
        anchors.left: friendsFrameFriendsScrollFrameButton7.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton7.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton8
        name: "FriendsFrameFriendsScrollFrameButton8"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton7.left
        anchors.top: friendsFrameFriendsScrollFrameButton7.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton8Info
        name: "FriendsFrameFriendsScrollFrameButton8Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton8"
        anchors.left: friendsFrameFriendsScrollFrameButton8Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton8Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton8Name
        name: "FriendsFrameFriendsScrollFrameButton8Name"
        text: "Droxus"
        wowParent: "FriendsFrameFriendsScrollFrameButton8"
        anchors.left: friendsFrameFriendsScrollFrameButton8.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton8.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Button {
        id: friendsFrameFriendsScrollFrameButton9
        name: "FriendsFrameFriendsScrollFrameButton9"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton8.left
        anchors.top: friendsFrameFriendsScrollFrameButton8.bottom
        width: 298
        height: 34
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton9Info
        name: "FriendsFrameFriendsScrollFrameButton9Info"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton9"
        anchors.left: friendsFrameFriendsScrollFrameButton9Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton9Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    FontString {
        id: friendsFrameFriendsScrollFrameButton9Name
        name: "FriendsFrameFriendsScrollFrameButton9Name"
        text: "Drread"
        wowParent: "FriendsFrameFriendsScrollFrameButton9"
        anchors.left: friendsFrameFriendsScrollFrameButton9.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton9.top
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

    Button {
        id: friendsFrameIgnoreButton10
        name: "FriendsFrameIgnoreButton10"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton9.horizontalCenter
        anchors.top: friendsFrameIgnoreButton9.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton10Name
        name: "FriendsFrameIgnoreButton10Name"
        text: "Isotopebelle"
        wowParent: "FriendsFrameIgnoreButton10"
        anchors.left: friendsFrameIgnoreButton10.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton10.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton11
        name: "FriendsFrameIgnoreButton11"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton10.horizontalCenter
        anchors.top: friendsFrameIgnoreButton10.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton11Name
        name: "FriendsFrameIgnoreButton11Name"
        text: "Thrallsonjr"
        wowParent: "FriendsFrameIgnoreButton11"
        anchors.left: friendsFrameIgnoreButton11.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton11.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton12
        name: "FriendsFrameIgnoreButton12"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton11.horizontalCenter
        anchors.top: friendsFrameIgnoreButton11.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton12Name
        name: "FriendsFrameIgnoreButton12Name"
        text: "Tyrandewind"
        wowParent: "FriendsFrameIgnoreButton12"
        anchors.left: friendsFrameIgnoreButton12.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton12.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
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
        id: friendsFrameIgnoreButton2
        name: "FriendsFrameIgnoreButton2"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton1.horizontalCenter
        anchors.top: friendsFrameIgnoreButton1.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton2Name
        name: "FriendsFrameIgnoreButton2Name"
        text: "Booped"
        wowParent: "FriendsFrameIgnoreButton2"
        anchors.left: friendsFrameIgnoreButton2.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton3
        name: "FriendsFrameIgnoreButton3"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton2.horizontalCenter
        anchors.top: friendsFrameIgnoreButton2.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton3Name
        name: "FriendsFrameIgnoreButton3Name"
        text: "Carmelita"
        wowParent: "FriendsFrameIgnoreButton3"
        anchors.left: friendsFrameIgnoreButton3.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton4
        name: "FriendsFrameIgnoreButton4"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton3.horizontalCenter
        anchors.top: friendsFrameIgnoreButton3.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton4Name
        name: "FriendsFrameIgnoreButton4Name"
        text: "Chouafa"
        wowParent: "FriendsFrameIgnoreButton4"
        anchors.left: friendsFrameIgnoreButton4.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton4.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton5
        name: "FriendsFrameIgnoreButton5"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton4.horizontalCenter
        anchors.top: friendsFrameIgnoreButton4.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton5Name
        name: "FriendsFrameIgnoreButton5Name"
        text: "Danty"
        wowParent: "FriendsFrameIgnoreButton5"
        anchors.left: friendsFrameIgnoreButton5.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton5.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton6
        name: "FriendsFrameIgnoreButton6"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton5.horizontalCenter
        anchors.top: friendsFrameIgnoreButton5.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton6Name
        name: "FriendsFrameIgnoreButton6Name"
        text: "Droxus"
        wowParent: "FriendsFrameIgnoreButton6"
        anchors.left: friendsFrameIgnoreButton6.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton6.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton7
        name: "FriendsFrameIgnoreButton7"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton6.horizontalCenter
        anchors.top: friendsFrameIgnoreButton6.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton7Name
        name: "FriendsFrameIgnoreButton7Name"
        text: "Faenyll"
        wowParent: "FriendsFrameIgnoreButton7"
        anchors.left: friendsFrameIgnoreButton7.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton7.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton8
        name: "FriendsFrameIgnoreButton8"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton7.horizontalCenter
        anchors.top: friendsFrameIgnoreButton7.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton8Name
        name: "FriendsFrameIgnoreButton8Name"
        text: "Fransisco"
        wowParent: "FriendsFrameIgnoreButton8"
        anchors.left: friendsFrameIgnoreButton8.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton8.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Button {
        id: friendsFrameIgnoreButton9
        name: "FriendsFrameIgnoreButton9"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton8.horizontalCenter
        anchors.top: friendsFrameIgnoreButton8.bottom
        width: 298
        height: 16
    }

    FontString {
        id: friendsFrameIgnoreButton9Name
        name: "FriendsFrameIgnoreButton9Name"
        text: "Harmful"
        wowParent: "FriendsFrameIgnoreButton9"
        anchors.left: friendsFrameIgnoreButton9.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton9.verticalCenter
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
        anchors.bottomMargin: 41
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
        anchors.bottomMargin: 41
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
        id: guildFrameButton2
        name: "GuildFrameButton2"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton1.left
        anchors.top: guildFrameButton1.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton2Class
        name: "GuildFrameButton2Class"
        text: "Death Knight"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton2Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton2Group
        name: "GuildFrameButton2Group"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Class.right
        anchors.verticalCenter: guildFrameButton2Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton2Level
        name: "GuildFrameButton2Level"
        text: "80"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton2Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton2Name
        name: "GuildFrameButton2Name"
        text: "Chiftea"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton2.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton2Zone
        name: "GuildFrameButton2Zone"
        text: "Dalaran"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton2Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameButton3
        name: "GuildFrameButton3"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton2.left
        anchors.top: guildFrameButton2.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton3Class
        name: "GuildFrameButton3Class"
        text: "Priest"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton3Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton3Group
        name: "GuildFrameButton3Group"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Class.right
        anchors.verticalCenter: guildFrameButton3Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton3Level
        name: "GuildFrameButton3Level"
        text: "80"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton3Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton3Name
        name: "GuildFrameButton3Name"
        text: "Padirac"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton3.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton3Zone
        name: "GuildFrameButton3Zone"
        text: "Stormwind City"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton3Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameButton4
        name: "GuildFrameButton4"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton3.left
        anchors.top: guildFrameButton3.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton4Class
        name: "GuildFrameButton4Class"
        text: "Mage"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton4Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton4Group
        name: "GuildFrameButton4Group"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Class.right
        anchors.verticalCenter: guildFrameButton4Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton4Level
        name: "GuildFrameButton4Level"
        text: "80"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton4Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton4Name
        name: "GuildFrameButton4Name"
        text: "Stephanaeon"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton4.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton4Zone
        name: "GuildFrameButton4Zone"
        text: "Halls of Stone"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton4Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameButton5
        name: "GuildFrameButton5"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton4.left
        anchors.top: guildFrameButton4.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton5Class
        name: "GuildFrameButton5Class"
        text: "Paladin"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton5Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton5Group
        name: "GuildFrameButton5Group"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Class.right
        anchors.verticalCenter: guildFrameButton5Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton5Level
        name: "GuildFrameButton5Level"
        text: "1"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton5Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton5Name
        name: "GuildFrameButton5Name"
        text: "Discordignis"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton5.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton5Zone
        name: "GuildFrameButton5Zone"
        text: "Azuremyst Isle"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton5Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameButton6
        name: "GuildFrameButton6"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton5.left
        anchors.top: guildFrameButton5.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton6Class
        name: "GuildFrameButton6Class"
        text: "Death Knight"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton6Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton6Group
        name: "GuildFrameButton6Group"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Class.right
        anchors.verticalCenter: guildFrameButton6Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton6Level
        name: "GuildFrameButton6Level"
        text: "80"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton6Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton6Name
        name: "GuildFrameButton6Name"
        text: "Ryddk"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton6.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton6Zone
        name: "GuildFrameButton6Zone"
        text: "Naxxramas"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton6Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameButton7
        name: "GuildFrameButton7"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton6.left
        anchors.top: guildFrameButton6.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton7Class
        name: "GuildFrameButton7Class"
        text: "Mage"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton7Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton7Group
        name: "GuildFrameButton7Group"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Class.right
        anchors.verticalCenter: guildFrameButton7Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton7Level
        name: "GuildFrameButton7Level"
        text: "80"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton7Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton7Name
        name: "GuildFrameButton7Name"
        text: "Stephanaeon"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton7.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton7Zone
        name: "GuildFrameButton7Zone"
        text: "Naxxramas"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton7Name.verticalCenter
        width: 110
        height: 14
    }

    Button {
        id: guildFrameButton8
        name: "GuildFrameButton8"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton7.left
        anchors.top: guildFrameButton7.bottom
        width: 298
        height: 16
    }

    FontString {
        id: guildFrameButton8Class
        name: "GuildFrameButton8Class"
        text: "Paladin"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton8Level.verticalCenter
        width: 80
        height: 14
    }

    FontString {
        id: guildFrameButton8Group
        name: "GuildFrameButton8Group"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Class.right
        anchors.verticalCenter: guildFrameButton8Class.verticalCenter
        width: 40
        height: 14
    }

    FontString {
        id: guildFrameButton8Level
        name: "GuildFrameButton8Level"
        text: "1"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton8Zone.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: guildFrameButton8Name
        name: "GuildFrameButton8Name"
        text: "Discordignis"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton8.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    FontString {
        id: guildFrameButton8Zone
        name: "GuildFrameButton8Zone"
        text: "Azuremyst Isle"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton8Name.verticalCenter
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
        anchors.bottomMargin: 42
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

    Button {
        id: whoFrameButton10
        name: "WhoFrameButton10"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton9.left
        anchors.top: whoFrameButton9.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton10Class
        name: "WhoFrameButton10Class"
        text: "Druid"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton10Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton10Level
        name: "WhoFrameButton10Level"
        text: "73"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton10Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton10Name
        name: "WhoFrameButton10Name"
        text: "Hindel"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton10.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton10Variable
        name: "WhoFrameButton10Variable"
        text: "Stormwind City"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10Name.right
        anchors.verticalCenter: whoFrameButton10Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton11
        name: "WhoFrameButton11"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton10.left
        anchors.top: whoFrameButton10.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton11Class
        name: "WhoFrameButton11Class"
        text: "Priest"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton11Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton11Level
        name: "WhoFrameButton11Level"
        text: "33"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton11Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton11Name
        name: "WhoFrameButton11Name"
        text: "Kassara"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton11.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton11Variable
        name: "WhoFrameButton11Variable"
        text: "Stranglethorn Vale"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11Name.right
        anchors.verticalCenter: whoFrameButton11Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton12
        name: "WhoFrameButton12"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton11.left
        anchors.top: whoFrameButton11.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton12Class
        name: "WhoFrameButton12Class"
        text: "Paladin"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton12Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton12Level
        name: "WhoFrameButton12Level"
        text: "40"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton12Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton12Name
        name: "WhoFrameButton12Name"
        text: "Diestero"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton12.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton12Variable
        name: "WhoFrameButton12Variable"
        text: "Stranglethorn Vale"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12Name.right
        anchors.verticalCenter: whoFrameButton12Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton13
        name: "WhoFrameButton13"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton12.left
        anchors.top: whoFrameButton12.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton13Class
        name: "WhoFrameButton13Class"
        text: "Mage"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton13Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton13Level
        name: "WhoFrameButton13Level"
        text: "80"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton13Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton13Name
        name: "WhoFrameButton13Name"
        text: "Iguanna"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton13.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton13Variable
        name: "WhoFrameButton13Variable"
        text: "The Culling of Stratholme"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13Name.right
        anchors.verticalCenter: whoFrameButton13Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton14
        name: "WhoFrameButton14"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton13.left
        anchors.top: whoFrameButton13.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton14Class
        name: "WhoFrameButton14Class"
        text: "Warlock"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton14Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton14Level
        name: "WhoFrameButton14Level"
        text: "68"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton14Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton14Name
        name: "WhoFrameButton14Name"
        text: "Pikica"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton14.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton14Variable
        name: "WhoFrameButton14Variable"
        text: "The Exodar"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14Name.right
        anchors.verticalCenter: whoFrameButton14Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton15
        name: "WhoFrameButton15"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton14.left
        anchors.top: whoFrameButton14.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton15Class
        name: "WhoFrameButton15Class"
        text: "Druid"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton15Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton15Level
        name: "WhoFrameButton15Level"
        text: "80"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton15Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton15Name
        name: "WhoFrameButton15Name"
        text: "Moohahaha"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton15.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton15Variable
        name: "WhoFrameButton15Variable"
        text: "The Slave Pens"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15Name.right
        anchors.verticalCenter: whoFrameButton15Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton16
        name: "WhoFrameButton16"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton15.left
        anchors.top: whoFrameButton15.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton16Class
        name: "WhoFrameButton16Class"
        text: "Paladin"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton16Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton16Level
        name: "WhoFrameButton16Level"
        text: "80"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton16Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton16Name
        name: "WhoFrameButton16Name"
        text: "Paroxysm"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton16.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton16Variable
        name: "WhoFrameButton16Variable"
        text: "The Storm Peaks"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16Name.right
        anchors.verticalCenter: whoFrameButton16Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton17
        name: "WhoFrameButton17"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton16.left
        anchors.top: whoFrameButton16.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton17Class
        name: "WhoFrameButton17Class"
        text: "Warrior"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton17Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton17Level
        name: "WhoFrameButton17Level"
        text: "2"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton17Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton17Name
        name: "WhoFrameButton17Name"
        text: "Keeroq"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton17.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton17Variable
        name: "WhoFrameButton17Variable"
        text: "Undercity"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17Name.right
        anchors.verticalCenter: whoFrameButton17Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton18
        name: "WhoFrameButton18"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton17.left
        anchors.top: whoFrameButton17.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton18Class
        name: "WhoFrameButton18Class"
        text: "Druid"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton18Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton18Level
        name: "WhoFrameButton18Level"
        text: "79"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton18Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton18Name
        name: "WhoFrameButton18Name"
        text: "Saltypanther"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton18.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton18Variable
        name: "WhoFrameButton18Variable"
        text: "Zangarmarsh"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18Name.right
        anchors.verticalCenter: whoFrameButton18Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton19
        name: "WhoFrameButton19"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton18.left
        anchors.top: whoFrameButton18.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton19Class
        name: "WhoFrameButton19Class"
        text: "Mage"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton19Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton19Level
        name: "WhoFrameButton19Level"
        text: "80"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton19Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton19Name
        name: "WhoFrameButton19Name"
        text: "Honeycandy"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton19.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton19Variable
        name: "WhoFrameButton19Variable"
        text: "Zul'Drak"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19Name.right
        anchors.verticalCenter: whoFrameButton19Name.verticalCenter
        width: 95
        height: 14
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
        id: whoFrameButton2
        name: "WhoFrameButton2"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton1.left
        anchors.top: whoFrameButton1.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton2Class
        name: "WhoFrameButton2Class"
        text: "Shaman"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton2Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton2Level
        name: "WhoFrameButton2Level"
        text: "73"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton2Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton2Name
        name: "WhoFrameButton2Name"
        text: "Ginst"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton2.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton2Variable
        name: "WhoFrameButton2Variable"
        text: "Howling Fjord"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2Name.right
        anchors.verticalCenter: whoFrameButton2Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton3
        name: "WhoFrameButton3"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton2.left
        anchors.top: whoFrameButton2.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton3Class
        name: "WhoFrameButton3Class"
        text: "Druid"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton3Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton3Level
        name: "WhoFrameButton3Level"
        text: "80"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton3Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton3Name
        name: "WhoFrameButton3Name"
        text: "Ursalles"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton3.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton3Variable
        name: "WhoFrameButton3Variable"
        text: "Icecrown"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3Name.right
        anchors.verticalCenter: whoFrameButton3Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton4
        name: "WhoFrameButton4"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton3.left
        anchors.top: whoFrameButton3.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton4Class
        name: "WhoFrameButton4Class"
        text: "Hunter"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton4Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton4Level
        name: "WhoFrameButton4Level"
        text: "80"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton4Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton4Name
        name: "WhoFrameButton4Name"
        text: "Grassmangler"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton4.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton4Variable
        name: "WhoFrameButton4Variable"
        text: "Icecrown"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4Name.right
        anchors.verticalCenter: whoFrameButton4Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton5
        name: "WhoFrameButton5"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton4.left
        anchors.top: whoFrameButton4.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton5Class
        name: "WhoFrameButton5Class"
        text: "Warrior"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton5Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton5Level
        name: "WhoFrameButton5Level"
        text: "10"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton5Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton5Name
        name: "WhoFrameButton5Name"
        text: "Donutreset"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton5.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton5Variable
        name: "WhoFrameButton5Variable"
        text: "Ironforge"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5Name.right
        anchors.verticalCenter: whoFrameButton5Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton6
        name: "WhoFrameButton6"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton5.left
        anchors.top: whoFrameButton5.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton6Class
        name: "WhoFrameButton6Class"
        text: "Druid"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton6Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton6Level
        name: "WhoFrameButton6Level"
        text: "71"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton6Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton6Name
        name: "WhoFrameButton6Name"
        text: "Foxifoxi"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton6.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton6Variable
        name: "WhoFrameButton6Variable"
        text: "Nagrand"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6Name.right
        anchors.verticalCenter: whoFrameButton6Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton7
        name: "WhoFrameButton7"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton6.left
        anchors.top: whoFrameButton6.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton7Class
        name: "WhoFrameButton7Class"
        text: "Priest"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton7Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton7Level
        name: "WhoFrameButton7Level"
        text: "1"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton7Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton7Name
        name: "WhoFrameButton7Name"
        text: "Fortknoxx"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton7.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton7Variable
        name: "WhoFrameButton7Variable"
        text: "Stormwind City"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7Name.right
        anchors.verticalCenter: whoFrameButton7Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton8
        name: "WhoFrameButton8"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton7.left
        anchors.top: whoFrameButton7.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton8Class
        name: "WhoFrameButton8Class"
        text: "Warlock"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton8Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton8Level
        name: "WhoFrameButton8Level"
        text: "15"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton8Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton8Name
        name: "WhoFrameButton8Name"
        text: "Lodix"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton8.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton8Variable
        name: "WhoFrameButton8Variable"
        text: "Stormwind City"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8Name.right
        anchors.verticalCenter: whoFrameButton8Name.verticalCenter
        width: 95
        height: 14
    }

    Button {
        id: whoFrameButton9
        name: "WhoFrameButton9"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton8.left
        anchors.top: whoFrameButton8.bottom
        width: 298
        height: 16
    }

    FontString {
        id: whoFrameButton9Class
        name: "WhoFrameButton9Class"
        text: "Warlock"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton9Level.verticalCenter
        width: 80
        height: 8
    }

    FontString {
        id: whoFrameButton9Level
        name: "WhoFrameButton9Level"
        text: "36"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton9Variable.verticalCenter
        width: 20
        height: 14
    }

    FontString {
        id: whoFrameButton9Name
        name: "WhoFrameButton9Name"
        text: "Voidmaster"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton9.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    FontString {
        id: whoFrameButton9Variable
        name: "WhoFrameButton9Variable"
        text: "Stormwind City"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9Name.right
        anchors.verticalCenter: whoFrameButton9Name.verticalCenter
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
        anchors.bottomMargin: 42
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
        anchors.bottomMargin: 41
    }

    WowRow {
        name: "WhoButtons"
        parts: ["WhoFrameWhoButton", "WhoFrameAddFriendButton", "WhoFrameGroupInviteButton"]
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 42
    }

    WowRow {
        name: "GuildButtons"
        parts: ["GuildFrameGuildInformationButton", "GuildFrameAddMemberButton", "GuildFrameControlButton"]
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: friendsFrameDiabolic.bottom
        anchors.bottomMargin: 42
    }

    Ghost { id: guildListScrollFrame; name: "GuildListScrollFrame"; x: 21; y: 73; width: 0; height: 0 }
    Ghost { id: uIParent; name: "UIParent"; x: 738.5; y: 290.6; width: 0; height: 0 }
}
