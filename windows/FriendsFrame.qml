// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: friendsFrame
    name: "FriendsFrame"
    width: 384
    height: 512

    Part {
        id: channelButton1
        name: "ChannelButton1"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelListScrollChildFrame.left
        anchors.top: channelListScrollChildFrame.top
        width: 155
        height: 20
    }

    Part {
        id: channelButton1Text
        name: "ChannelButton1Text"
        kind: "FontString"
        wowParent: "ChannelButton1"
        anchors.left: channelButton1.left
        anchors.leftMargin: 5
        anchors.verticalCenter: channelButton1.verticalCenter
        width: 135
        height: 8
    }

    Part {
        id: channelButton2
        name: "ChannelButton2"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton1.left
        anchors.top: channelButton1.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton2Collapsed
        name: "ChannelButton2Collapsed"
        kind: "FontString"
        text: "-"
        wowParent: "ChannelButton2"
        anchors.right: channelButton2.right
        anchors.rightMargin: 5
        anchors.verticalCenter: channelButton2.verticalCenter
        width: 7.9
        height: 15.8
    }

    Part {
        id: channelButton2Text
        name: "ChannelButton2Text"
        kind: "FontString"
        wowParent: "ChannelButton2"
        anchors.left: channelButton2.left
        anchors.leftMargin: 5
        anchors.verticalCenter: channelButton2.verticalCenter
        width: 135
        height: 8
    }

    Part {
        id: channelButton3
        name: "ChannelButton3"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton2.left
        anchors.top: channelButton2.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton3Text
        name: "ChannelButton3Text"
        kind: "FontString"
        wowParent: "ChannelButton3"
        anchors.left: channelButton3.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton3.verticalCenter
        width: 119
        height: 8
    }

    Part {
        id: channelButton4
        name: "ChannelButton4"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton3.left
        anchors.top: channelButton3.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton4Text
        name: "ChannelButton4Text"
        kind: "FontString"
        wowParent: "ChannelButton4"
        anchors.left: channelButton4.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton4.verticalCenter
        width: 119
        height: 8
    }

    Part {
        id: channelButton5
        name: "ChannelButton5"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton4.left
        anchors.top: channelButton4.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton5Text
        name: "ChannelButton5Text"
        kind: "FontString"
        wowParent: "ChannelButton5"
        anchors.left: channelButton5.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton5.verticalCenter
        width: 119
        height: 8
    }

    Part {
        id: channelButton6
        name: "ChannelButton6"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton5.left
        anchors.top: channelButton5.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton6Collapsed
        name: "ChannelButton6Collapsed"
        kind: "FontString"
        text: "-"
        wowParent: "ChannelButton6"
        anchors.right: channelButton6.right
        anchors.rightMargin: 5
        anchors.verticalCenter: channelButton6.verticalCenter
        width: 7.9
        height: 15.8
    }

    Part {
        id: channelButton6Text
        name: "ChannelButton6Text"
        kind: "FontString"
        wowParent: "ChannelButton6"
        anchors.left: channelButton6.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton6.verticalCenter
        width: 119
        height: 8
    }

    Part {
        id: channelButton7
        name: "ChannelButton7"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton6.left
        anchors.top: channelButton6.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton7Collapsed
        name: "ChannelButton7Collapsed"
        kind: "FontString"
        text: "-"
        wowParent: "ChannelButton7"
        anchors.right: channelButton7.right
        anchors.rightMargin: 5
        anchors.verticalCenter: channelButton7.verticalCenter
        width: 7.9
        height: 15.8
    }

    Part {
        id: channelButton7Text
        name: "ChannelButton7Text"
        kind: "FontString"
        wowParent: "ChannelButton7"
        anchors.left: channelButton7.left
        anchors.leftMargin: 5
        anchors.verticalCenter: channelButton7.verticalCenter
        width: 135
        height: 8
    }

    Part {
        id: channelButton8
        name: "ChannelButton8"
        kind: "Button"
        wowParent: "ChannelListScrollChildFrame"
        anchors.left: channelButton7.left
        anchors.top: channelButton7.bottom
        width: 155
        height: 20
    }

    Part {
        id: channelButton8Text
        name: "ChannelButton8Text"
        kind: "FontString"
        wowParent: "ChannelButton8"
        anchors.left: channelButton8.left
        anchors.leftMargin: 10
        anchors.verticalCenter: channelButton8.verticalCenter
        width: 119
        height: 8
    }

    Part {
        id: channelFrame
        name: "ChannelFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 355
        height: 512
    }

    Part {
        id: channelFrameDaughterFrame
        name: "ChannelFrameDaughterFrame"
        kind: "Frame"
        wowParent: "ChannelFrame"
        anchors.horizontalCenter: uIParent.horizontalCenter
        anchors.verticalCenter: uIParent.verticalCenter
        anchors.verticalCenterOffset: -100
        width: 212
        height: 200
    }

    Part {
        id: channelFrameDaughterFrameCancelButton
        name: "ChannelFrameDaughterFrameCancelButton"
        kind: "Button"
        text: "Cancel"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.right: channelFrameDaughterFrame.right
        anchors.rightMargin: 9
        anchors.bottom: channelFrameDaughterFrame.bottom
        anchors.bottomMargin: 12
        width: 93.5
        height: 22
    }

    Part {
        id: channelFrameDaughterFrameCancelButtonText
        name: "ChannelFrameDaughterFrameCancelButtonText"
        kind: "FontString"
        text: "Cancel"
        wowParent: "ChannelFrameDaughterFrameCancelButton"
        anchors.horizontalCenter: channelFrameDaughterFrameCancelButton.horizontalCenter
        anchors.verticalCenter: channelFrameDaughterFrameCancelButton.verticalCenter
        width: 35.6
        height: 10.3
    }

    Part {
        id: channelFrameDaughterFrameChannelName
        name: "ChannelFrameDaughterFrameChannelName"
        kind: "EditBox"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.left: channelFrameDaughterFrame.left
        anchors.leftMargin: 23
        anchors.top: channelFrameDaughterFrame.top
        anchors.topMargin: 60
        width: 170
        height: 16
    }

    Part {
        id: channelFrameDaughterFrameChannelNameDiabolicField
        name: "ChannelFrameDaughterFrameChannelNameDiabolicField"
        kind: "Frame"
        wowParent: "ChannelFrameDaughterFrameChannelName"
        anchors.left: channelFrameDaughterFrameChannelName.left
        anchors.leftMargin: -8
        anchors.verticalCenter: channelFrameDaughterFrameChannelName.verticalCenter
        width: 186
        height: 22
    }

    Part {
        id: channelFrameDaughterFrameChannelNameLabel
        name: "ChannelFrameDaughterFrameChannelNameLabel"
        kind: "FontString"
        text: "Channel Name"
        wowParent: "ChannelFrameDaughterFrameChannelName"
        anchors.left: channelFrameDaughterFrameChannelName.left
        anchors.bottom: channelFrameDaughterFrameChannelName.top
        anchors.bottomMargin: 5
        width: 85.3
        height: 14.2
    }

    Part {
        id: channelFrameDaughterFrameChannelPassword
        name: "ChannelFrameDaughterFrameChannelPassword"
        kind: "EditBox"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.left: channelFrameDaughterFrameChannelName.left
        anchors.top: channelFrameDaughterFrameChannelName.bottom
        anchors.topMargin: 30
        width: 170
        height: 16
    }

    Part {
        id: channelFrameDaughterFrameChannelPasswordDiabolicField
        name: "ChannelFrameDaughterFrameChannelPasswordDiabolicField"
        kind: "Frame"
        wowParent: "ChannelFrameDaughterFrameChannelPassword"
        anchors.left: channelFrameDaughterFrameChannelPassword.left
        anchors.leftMargin: -8
        anchors.verticalCenter: channelFrameDaughterFrameChannelPassword.verticalCenter
        width: 186
        height: 22
    }

    Part {
        id: channelFrameDaughterFrameChannelPasswordLabel
        name: "ChannelFrameDaughterFrameChannelPasswordLabel"
        kind: "FontString"
        text: "Password"
        wowParent: "ChannelFrameDaughterFrameChannelPassword"
        anchors.left: channelFrameDaughterFrameChannelPassword.left
        anchors.bottom: channelFrameDaughterFrameChannelPassword.top
        anchors.bottomMargin: 5
        width: 55.3
        height: 14.2
    }

    Part {
        id: channelFrameDaughterFrameChannelPasswordOptional
        name: "ChannelFrameDaughterFrameChannelPasswordOptional"
        kind: "FontString"
        text: "(optional)"
        wowParent: "ChannelFrameDaughterFrameChannelPassword"
        anchors.left: channelFrameDaughterFrameChannelPasswordLabel.right
        anchors.leftMargin: 3
        anchors.verticalCenter: channelFrameDaughterFrameChannelPasswordLabel.verticalCenter
        width: 52.9
        height: 10.3
    }

    Part {
        id: channelFrameDaughterFrameDetailCloseButton
        name: "ChannelFrameDaughterFrameDetailCloseButton"
        kind: "Button"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.right: channelFrameDaughterFrame.right
        anchors.rightMargin: 2
        anchors.top: channelFrameDaughterFrame.top
        anchors.topMargin: 3
        width: 22
        height: 22
    }

    Part {
        id: channelFrameDaughterFrameName
        name: "ChannelFrameDaughterFrameName"
        kind: "FontString"
        text: "New Channel"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.horizontalCenter: channelFrameDaughterFrame.horizontalCenter
        anchors.horizontalCenterOffset: -5
        anchors.top: channelFrameDaughterFrame.top
        anchors.topMargin: 13
        width: 79
        height: 12
    }

    Part {
        id: channelFrameDaughterFrameOkayButton
        name: "ChannelFrameDaughterFrameOkayButton"
        kind: "Button"
        text: "Okay"
        wowParent: "ChannelFrameDaughterFrame"
        anchors.right: channelFrameDaughterFrame.right
        anchors.rightMargin: 108.5
        anchors.bottom: channelFrameDaughterFrame.bottom
        anchors.bottomMargin: 12
        width: 93.5
        height: 22
    }

    Part {
        id: channelFrameDaughterFrameOkayButtonText
        name: "ChannelFrameDaughterFrameOkayButtonText"
        kind: "FontString"
        text: "Okay"
        wowParent: "ChannelFrameDaughterFrameOkayButton"
        anchors.horizontalCenter: channelFrameDaughterFrameOkayButton.horizontalCenter
        anchors.verticalCenter: channelFrameDaughterFrameOkayButton.verticalCenter
        width: 28.4
        height: 10.3
    }

    Part {
        id: channelFrameNewButton
        name: "ChannelFrameNewButton"
        kind: "Button"
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

    Part {
        id: channelFrameNewButtonText
        name: "ChannelFrameNewButtonText"
        kind: "FontString"
        text: "Add"
        wowParent: "ChannelFrameNewButton"
        anchors.horizontalCenter: channelFrameNewButton.horizontalCenter
        anchors.verticalCenter: channelFrameNewButton.verticalCenter
        width: 21.3
        height: 10.3
    }

    Part {
        id: channelFrameVerticalBar
        name: "ChannelFrameVerticalBar"
        kind: "Frame"
        wowParent: "ChannelFrame"
        anchors.horizontalCenter: channelFrame.horizontalCenter
        anchors.horizontalCenterOffset: 3
        anchors.verticalCenter: channelFrame.verticalCenter
        anchors.verticalCenterOffset: -35
        width: 13
        height: 300
    }

    Part {
        id: channelListScrollChildFrame
        name: "ChannelListScrollChildFrame"
        kind: "Frame"
        wowParent: "ChannelListScrollFrame"
        anchors.left: channelListScrollFrame.left
        anchors.top: channelListScrollFrame.top
        width: 145
        height: -1240
    }

    Part {
        id: channelListScrollFrame
        name: "ChannelListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "ChannelFrame"
        anchors.left: channelFrame.left
        anchors.leftMargin: 20
        anchors.top: channelFrame.top
        anchors.topMargin: 76
        width: 158
        height: 327
    }

    Part {
        id: channelMemberButton1
        name: "ChannelMemberButton1"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelFrame.left
        anchors.leftMargin: 186
        anchors.top: channelFrame.top
        anchors.topMargin: 75
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton10
        name: "ChannelMemberButton10"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton9.left
        anchors.top: channelMemberButton9.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton10Name
        name: "ChannelMemberButton10Name"
        kind: "FontString"
        text: "Carez"
        wowParent: "?"
        anchors.left: channelMemberButton10.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton10.top
        anchors.topMargin: 1
        width: 30.8
        height: 10.3
    }

    Part {
        id: channelMemberButton11
        name: "ChannelMemberButton11"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton10.left
        anchors.top: channelMemberButton10.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton11Name
        name: "ChannelMemberButton11Name"
        kind: "FontString"
        text: "Cattiviy"
        wowParent: "?"
        anchors.left: channelMemberButton11.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton11.top
        anchors.topMargin: 1
        width: 41.9
        height: 10.3
    }

    Part {
        id: channelMemberButton12
        name: "ChannelMemberButton12"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton11.left
        anchors.top: channelMemberButton11.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton12Name
        name: "ChannelMemberButton12Name"
        kind: "FontString"
        text: "Chickenbutt"
        wowParent: "?"
        anchors.left: channelMemberButton12.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton12.top
        anchors.topMargin: 1
        width: 62.4
        height: 10.3
    }

    Part {
        id: channelMemberButton13
        name: "ChannelMemberButton13"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton12.left
        anchors.top: channelMemberButton12.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton13Name
        name: "ChannelMemberButton13Name"
        kind: "FontString"
        text: "Chilliwilli"
        wowParent: "?"
        anchors.left: channelMemberButton13.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton13.top
        anchors.topMargin: 1
        width: 48.2
        height: 10.3
    }

    Part {
        id: channelMemberButton14
        name: "ChannelMemberButton14"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton13.left
        anchors.top: channelMemberButton13.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton14Name
        name: "ChannelMemberButton14Name"
        kind: "FontString"
        text: "Chillydruid"
        wowParent: "?"
        anchors.left: channelMemberButton14.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton14.top
        anchors.topMargin: 1
        width: 57.7
        height: 10.3
    }

    Part {
        id: channelMemberButton15
        name: "ChannelMemberButton15"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton14.left
        anchors.top: channelMemberButton14.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton15Name
        name: "ChannelMemberButton15Name"
        kind: "FontString"
        text: "Dirtymerlin"
        wowParent: "?"
        anchors.left: channelMemberButton15.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton15.top
        anchors.topMargin: 1
        width: 60
        height: 10.3
    }

    Part {
        id: channelMemberButton16
        name: "ChannelMemberButton16"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton15.left
        anchors.top: channelMemberButton15.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton16Name
        name: "ChannelMemberButton16Name"
        kind: "FontString"
        text: "Dodedodedum"
        wowParent: "?"
        anchors.left: channelMemberButton16.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton16.top
        anchors.topMargin: 1
        width: 80.6
        height: 10.3
    }

    Part {
        id: channelMemberButton17
        name: "ChannelMemberButton17"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton16.left
        anchors.top: channelMemberButton16.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton17Name
        name: "ChannelMemberButton17Name"
        kind: "FontString"
        text: "Dornoxia"
        wowParent: "?"
        anchors.left: channelMemberButton17.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton17.top
        anchors.topMargin: 1
        width: 49
        height: 10.3
    }

    Part {
        id: channelMemberButton18
        name: "ChannelMemberButton18"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton17.left
        anchors.top: channelMemberButton17.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton18Name
        name: "ChannelMemberButton18Name"
        kind: "FontString"
        text: "Endorhim"
        wowParent: "?"
        anchors.left: channelMemberButton18.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton18.top
        anchors.topMargin: 1
        width: 51.4
        height: 10.3
    }

    Part {
        id: channelMemberButton19
        name: "ChannelMemberButton19"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton18.left
        anchors.top: channelMemberButton18.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton19Name
        name: "ChannelMemberButton19Name"
        kind: "FontString"
        text: "Ependytis"
        wowParent: "?"
        anchors.left: channelMemberButton19.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton19.top
        anchors.topMargin: 1
        width: 52.9
        height: 10.3
    }

    Part {
        id: channelMemberButton1Name
        name: "ChannelMemberButton1Name"
        kind: "FontString"
        text: "Aashwath"
        wowParent: "?"
        anchors.left: channelMemberButton1.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton1.top
        anchors.topMargin: 1
        width: 52.9
        height: 10.3
    }

    Part {
        id: channelMemberButton2
        name: "ChannelMemberButton2"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton1.left
        anchors.top: channelMemberButton1.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton20
        name: "ChannelMemberButton20"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton19.left
        anchors.top: channelMemberButton19.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton20Name
        name: "ChannelMemberButton20Name"
        kind: "FontString"
        text: "Estra"
        wowParent: "?"
        anchors.left: channelMemberButton20.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton20.top
        anchors.topMargin: 1
        width: 26.9
        height: 10.3
    }

    Part {
        id: channelMemberButton21
        name: "ChannelMemberButton21"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton20.left
        anchors.top: channelMemberButton20.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton21Name
        name: "ChannelMemberButton21Name"
        kind: "FontString"
        text: "Faenielle"
        wowParent: "?"
        anchors.left: channelMemberButton21.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton21.top
        anchors.topMargin: 1
        width: 48.2
        height: 10.3
    }

    Part {
        id: channelMemberButton22
        name: "ChannelMemberButton22"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton21.left
        anchors.top: channelMemberButton21.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton22Name
        name: "ChannelMemberButton22Name"
        kind: "FontString"
        text: "Fercho"
        wowParent: "?"
        anchors.left: channelMemberButton22.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton22.top
        anchors.topMargin: 1
        width: 35.6
        height: 10.3
    }

    Part {
        id: channelMemberButton2Name
        name: "ChannelMemberButton2Name"
        kind: "FontString"
        text: "Aendriel"
        wowParent: "?"
        anchors.left: channelMemberButton2.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton2.top
        anchors.topMargin: 1
        width: 45
        height: 10.3
    }

    Part {
        id: channelMemberButton3
        name: "ChannelMemberButton3"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton2.left
        anchors.top: channelMemberButton2.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton3Name
        name: "ChannelMemberButton3Name"
        kind: "FontString"
        text: "Aldore"
        wowParent: "?"
        anchors.left: channelMemberButton3.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton3.top
        anchors.topMargin: 1
        width: 37.1
        height: 10.3
    }

    Part {
        id: channelMemberButton4
        name: "ChannelMemberButton4"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton3.left
        anchors.top: channelMemberButton3.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton4Name
        name: "ChannelMemberButton4Name"
        kind: "FontString"
        text: "Amarin"
        wowParent: "?"
        anchors.left: channelMemberButton4.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton4.top
        anchors.topMargin: 1
        width: 39.5
        height: 10.3
    }

    Part {
        id: channelMemberButton5
        name: "ChannelMemberButton5"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton4.left
        anchors.top: channelMemberButton4.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton5Name
        name: "ChannelMemberButton5Name"
        kind: "FontString"
        text: "Aquablue"
        wowParent: "?"
        anchors.left: channelMemberButton5.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton5.top
        anchors.topMargin: 1
        width: 51.4
        height: 10.3
    }

    Part {
        id: channelMemberButton6
        name: "ChannelMemberButton6"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton5.left
        anchors.top: channelMemberButton5.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton6Name
        name: "ChannelMemberButton6Name"
        kind: "FontString"
        text: "Archidruid"
        wowParent: "?"
        anchors.left: channelMemberButton6.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton6.top
        anchors.topMargin: 1
        width: 55.3
        height: 10.3
    }

    Part {
        id: channelMemberButton7
        name: "ChannelMemberButton7"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton6.left
        anchors.top: channelMemberButton6.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton7Name
        name: "ChannelMemberButton7Name"
        kind: "FontString"
        text: "Armlok"
        wowParent: "?"
        anchors.left: channelMemberButton7.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton7.top
        anchors.topMargin: 1
        width: 40.3
        height: 10.3
    }

    Part {
        id: channelMemberButton8
        name: "ChannelMemberButton8"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton7.left
        anchors.top: channelMemberButton7.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton8Name
        name: "ChannelMemberButton8Name"
        kind: "FontString"
        text: "Bleedfury"
        wowParent: "?"
        anchors.left: channelMemberButton8.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton8.top
        anchors.topMargin: 1
        width: 52.1
        height: 10.3
    }

    Part {
        id: channelMemberButton9
        name: "ChannelMemberButton9"
        kind: "Button"
        wowParent: "ChannelRoster"
        anchors.left: channelMemberButton8.left
        anchors.top: channelMemberButton8.bottom
        width: 135
        height: 15
    }

    Part {
        id: channelMemberButton9Name
        name: "ChannelMemberButton9Name"
        kind: "FontString"
        text: "Bmachie"
        wowParent: "?"
        anchors.left: channelMemberButton9.left
        anchors.leftMargin: 13
        anchors.top: channelMemberButton9.top
        anchors.topMargin: 1
        width: 46.6
        height: 10.3
    }

    Part {
        id: channelRoster
        name: "ChannelRoster"
        kind: "Frame"
        wowParent: "ChannelFrame"
        anchors.left: channelFrame.horizontalCenter
        anchors.leftMargin: 121
        anchors.top: channelFrame.top
        anchors.topMargin: 79
        width: 158
        height: 327
    }

    Part {
        id: channelRosterChannelCount
        name: "ChannelRosterChannelCount"
        kind: "FontString"
        wowParent: "ChannelRoster"
        anchors.left: channelRosterChannelName.right
        anchors.verticalCenter: channelRosterChannelName.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: channelRosterChannelName
        name: "ChannelRosterChannelName"
        kind: "FontString"
        wowParent: "ChannelRoster"
        anchors.left: channelRoster.left
        anchors.leftMargin: -115
        anchors.top: channelRoster.top
        anchors.topMargin: -20
        width: 1
        height: 1
    }

    Part {
        id: channelRosterScrollFrame
        name: "ChannelRosterScrollFrame"
        kind: "ScrollFrame"
        wowParent: "ChannelRoster"
        anchors.right: channelFrame.right
        anchors.rightMargin: 39
        anchors.top: channelFrame.top
        anchors.topMargin: 76
        width: 158
        height: 327
    }

    Part {
        id: channelRosterScrollFrameScrollBar
        name: "ChannelRosterScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "ChannelRosterScrollFrame"
        anchors.left: channelRosterScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: channelRosterScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 295
    }

    Part {
        id: channelRosterScrollFrameScrollBarDiabolicTrack
        name: "ChannelRosterScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "ChannelRosterScrollFrameScrollBar"
        anchors.horizontalCenter: channelRosterScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: channelRosterScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 329
    }

    Part {
        id: channelRosterScrollFrameScrollBarScrollDownButton
        name: "ChannelRosterScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "ChannelRosterScrollFrameScrollBar"
        anchors.horizontalCenter: channelRosterScrollFrameScrollBar.horizontalCenter
        anchors.top: channelRosterScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: channelRosterScrollFrameScrollBarScrollUpButton
        name: "ChannelRosterScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "ChannelRosterScrollFrameScrollBar"
        anchors.horizontalCenter: channelRosterScrollFrameScrollBar.horizontalCenter
        anchors.bottom: channelRosterScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: channelRosterScrollFrameScrollChildFrame
        name: "ChannelRosterScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "ChannelRosterScrollFrame"
        anchors.left: channelRosterScrollFrame.left
        anchors.top: channelRosterScrollFrame.top
        width: 300
        height: 1245
    }

    Part {
        id: friendsFrameAddFriendButton
        name: "FriendsFrameAddFriendButton"
        kind: "Button"
        text: "Add Friend"
        wowParent: "FriendsListFrame"
        style: "Button"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 15
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 81
        width: 131
        height: 21
    }

    Part {
        id: friendsFrameAddFriendButtonText
        name: "FriendsFrameAddFriendButtonText"
        kind: "FontString"
        text: "Add Friend"
        wowParent: "FriendsFrameAddFriendButton"
        anchors.horizontalCenter: friendsFrameAddFriendButton.horizontalCenter
        anchors.verticalCenter: friendsFrameAddFriendButton.verticalCenter
        width: 59.3
        height: 10.3
    }

    Part {
        id: friendsFrameCloseButton
        name: "FriendsFrameCloseButton"
        kind: "Button"
        wowParent: "FriendsFrame"
        style: "CloseButton"
        anchors.horizontalCenter: friendsFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: friendsFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: friendsFrameDiabolic
        name: "FriendsFrameDiabolic"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.leftMargin: -20
        anchors.top: friendsFrame.top
        anchors.topMargin: -68
        width: 400
        height: 540
    }

    Part {
        id: friendsFrameDiabolicBand
        name: "FriendsFrameDiabolicBand"
        kind: "Frame"
        wowParent: "FriendsFrameDiabolic"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 56
        width: 352
        height: 40
    }

    Part {
        id: friendsFrameDiabolicBorder
        name: "FriendsFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "FriendsFrameDiabolic"
        anchors.left: friendsFrameDiabolic.left
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 32
        width: 400
        height: 508
    }

    Part {
        id: friendsFrameDiabolicFoot
        name: "FriendsFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "FriendsFrameDiabolic"
        anchors.horizontalCenter: guildFrameGuildInformationButton.horizontalCenter
        anchors.horizontalCenterOffset: 110.5
        anchors.top: guildFrameGuildInformationButton.top
        anchors.topMargin: -6
        width: 354
        height: 47
    }

    Part {
        id: friendsFrameDiabolicRail
        name: "FriendsFrameDiabolicRail"
        kind: "Frame"
        wowParent: "FriendsFrameDiabolic"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 304
        height: 18
    }

    Part {
        id: friendsFrameDiabolicSocket
        name: "FriendsFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "FriendsFrameDiabolic"
        anchors.right: friendsFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: friendsFrameDiabolicTitlePlate
        name: "FriendsFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "FriendsFrameDiabolic"
        anchors.horizontalCenter: friendsFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: friendsFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: friendsFrameFriendsScrollFrame
        name: "FriendsFrameFriendsScrollFrame"
        kind: "ScrollFrame"
        wowParent: "FriendsListFrame"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 21
        anchors.top: friendsFrame.top
        anchors.topMargin: 36
        width: 302
        height: 340
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton1
        name: "FriendsFrameFriendsScrollFrameButton1"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameScrollChild.left
        anchors.top: friendsFrameFriendsScrollFrameScrollChild.top
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton10
        name: "FriendsFrameFriendsScrollFrameButton10"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton9.left
        anchors.top: friendsFrameFriendsScrollFrameButton9.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton10Info
        name: "FriendsFrameFriendsScrollFrameButton10Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton10"
        anchors.left: friendsFrameFriendsScrollFrameButton10Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton10Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton10Name
        name: "FriendsFrameFriendsScrollFrameButton10Name"
        kind: "FontString"
        text: "Enby"
        wowParent: "FriendsFrameFriendsScrollFrameButton10"
        anchors.left: friendsFrameFriendsScrollFrameButton10.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton10.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton11
        name: "FriendsFrameFriendsScrollFrameButton11"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton10.left
        anchors.top: friendsFrameFriendsScrollFrameButton10.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton11Info
        name: "FriendsFrameFriendsScrollFrameButton11Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton11"
        anchors.left: friendsFrameFriendsScrollFrameButton11Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton11Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton11Name
        name: "FriendsFrameFriendsScrollFrameButton11Name"
        kind: "FontString"
        text: "Eske"
        wowParent: "FriendsFrameFriendsScrollFrameButton11"
        anchors.left: friendsFrameFriendsScrollFrameButton11.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton11.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton12
        name: "FriendsFrameFriendsScrollFrameButton12"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton11.left
        anchors.top: friendsFrameFriendsScrollFrameButton11.bottom
        width: 298
        height: 680
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton12Info
        name: "FriendsFrameFriendsScrollFrameButton12Info"
        kind: "FontString"
        wowParent: "FriendsFrameFriendsScrollFrameButton12"
        anchors.left: friendsFrameFriendsScrollFrameButton12Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton12Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton12Name
        name: "FriendsFrameFriendsScrollFrameButton12Name"
        kind: "FontString"
        wowParent: "FriendsFrameFriendsScrollFrameButton12"
        anchors.left: friendsFrameFriendsScrollFrameButton12.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton12.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton1Info
        name: "FriendsFrameFriendsScrollFrameButton1Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton1"
        anchors.left: friendsFrameFriendsScrollFrameButton1Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton1Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton1Name
        name: "FriendsFrameFriendsScrollFrameButton1Name"
        kind: "FontString"
        text: "Kaldon"
        wowParent: "FriendsFrameFriendsScrollFrameButton1"
        anchors.left: friendsFrameFriendsScrollFrameButton1.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton1.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton2
        name: "FriendsFrameFriendsScrollFrameButton2"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton1.left
        anchors.top: friendsFrameFriendsScrollFrameButton1.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton2Info
        name: "FriendsFrameFriendsScrollFrameButton2Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton2"
        anchors.left: friendsFrameFriendsScrollFrameButton2Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton2Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton2Name
        name: "FriendsFrameFriendsScrollFrameButton2Name"
        kind: "FontString"
        text: "Padirac"
        wowParent: "FriendsFrameFriendsScrollFrameButton2"
        anchors.left: friendsFrameFriendsScrollFrameButton2.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton2.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton3
        name: "FriendsFrameFriendsScrollFrameButton3"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton2.left
        anchors.top: friendsFrameFriendsScrollFrameButton2.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton3Info
        name: "FriendsFrameFriendsScrollFrameButton3Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton3"
        anchors.left: friendsFrameFriendsScrollFrameButton3Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton3Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton3Name
        name: "FriendsFrameFriendsScrollFrameButton3Name"
        kind: "FontString"
        text: "Clydruid"
        wowParent: "FriendsFrameFriendsScrollFrameButton3"
        anchors.left: friendsFrameFriendsScrollFrameButton3.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton3.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton4
        name: "FriendsFrameFriendsScrollFrameButton4"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton3.left
        anchors.top: friendsFrameFriendsScrollFrameButton3.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton4Info
        name: "FriendsFrameFriendsScrollFrameButton4Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton4"
        anchors.left: friendsFrameFriendsScrollFrameButton4Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton4Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton4Name
        name: "FriendsFrameFriendsScrollFrameButton4Name"
        kind: "FontString"
        text: "Cottonee"
        wowParent: "FriendsFrameFriendsScrollFrameButton4"
        anchors.left: friendsFrameFriendsScrollFrameButton4.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton4.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton5
        name: "FriendsFrameFriendsScrollFrameButton5"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton4.left
        anchors.top: friendsFrameFriendsScrollFrameButton4.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton5Info
        name: "FriendsFrameFriendsScrollFrameButton5Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton5"
        anchors.left: friendsFrameFriendsScrollFrameButton5Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton5Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton5Name
        name: "FriendsFrameFriendsScrollFrameButton5Name"
        kind: "FontString"
        text: "Darkdrifter"
        wowParent: "FriendsFrameFriendsScrollFrameButton5"
        anchors.left: friendsFrameFriendsScrollFrameButton5.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton5.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton6
        name: "FriendsFrameFriendsScrollFrameButton6"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton5.left
        anchors.top: friendsFrameFriendsScrollFrameButton5.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton6Info
        name: "FriendsFrameFriendsScrollFrameButton6Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton6"
        anchors.left: friendsFrameFriendsScrollFrameButton6Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton6Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton6Name
        name: "FriendsFrameFriendsScrollFrameButton6Name"
        kind: "FontString"
        text: "Dcde"
        wowParent: "FriendsFrameFriendsScrollFrameButton6"
        anchors.left: friendsFrameFriendsScrollFrameButton6.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton6.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton7
        name: "FriendsFrameFriendsScrollFrameButton7"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton6.left
        anchors.top: friendsFrameFriendsScrollFrameButton6.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton7Info
        name: "FriendsFrameFriendsScrollFrameButton7Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton7"
        anchors.left: friendsFrameFriendsScrollFrameButton7Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton7Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton7Name
        name: "FriendsFrameFriendsScrollFrameButton7Name"
        kind: "FontString"
        text: "Decadde"
        wowParent: "FriendsFrameFriendsScrollFrameButton7"
        anchors.left: friendsFrameFriendsScrollFrameButton7.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton7.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton8
        name: "FriendsFrameFriendsScrollFrameButton8"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton7.left
        anchors.top: friendsFrameFriendsScrollFrameButton7.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton8Info
        name: "FriendsFrameFriendsScrollFrameButton8Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton8"
        anchors.left: friendsFrameFriendsScrollFrameButton8Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton8Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton8Name
        name: "FriendsFrameFriendsScrollFrameButton8Name"
        kind: "FontString"
        text: "Droxus"
        wowParent: "FriendsFrameFriendsScrollFrameButton8"
        anchors.left: friendsFrameFriendsScrollFrameButton8.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton8.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton9
        name: "FriendsFrameFriendsScrollFrameButton9"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
        anchors.left: friendsFrameFriendsScrollFrameButton8.left
        anchors.top: friendsFrameFriendsScrollFrameButton8.bottom
        width: 298
        height: 34
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton9Info
        name: "FriendsFrameFriendsScrollFrameButton9Info"
        kind: "FontString"
        text: "Unknown"
        wowParent: "FriendsFrameFriendsScrollFrameButton9"
        anchors.left: friendsFrameFriendsScrollFrameButton9Name.left
        anchors.top: friendsFrameFriendsScrollFrameButton9Name.bottom
        anchors.topMargin: 2
        width: 260
        height: 10
    }

    Part {
        id: friendsFrameFriendsScrollFrameButton9Name
        name: "FriendsFrameFriendsScrollFrameButton9Name"
        kind: "FontString"
        text: "Drread"
        wowParent: "FriendsFrameFriendsScrollFrameButton9"
        anchors.left: friendsFrameFriendsScrollFrameButton9.left
        anchors.leftMargin: 20
        anchors.top: friendsFrameFriendsScrollFrameButton9.top
        anchors.topMargin: 3
        width: 248
        height: 12
    }

    Part {
        id: friendsFrameFriendsScrollFrameDiabolicZone
        name: "FriendsFrameFriendsScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "FriendsListFrame"
        anchors.left: friendsFrameFriendsScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: friendsFrameFriendsScrollFrame.top
        anchors.topMargin: -2
        width: 336
        height: 352
    }

    Part {
        id: friendsFrameFriendsScrollFrameScrollBar
        name: "FriendsFrameFriendsScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "FriendsFrameFriendsScrollFrame"
        style: "ScrollBar"
        anchors.left: friendsFrameFriendsScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameFriendsScrollFrame.top
        anchors.topMargin: 15
        width: 16
        height: 310
    }

    Part {
        id: friendsFrameFriendsScrollFrameScrollBarDiabolicTrack
        name: "FriendsFrameFriendsScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
        anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: friendsFrameFriendsScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 344
    }

    Part {
        id: friendsFrameFriendsScrollFrameScrollBarScrollDownButton
        name: "FriendsFrameFriendsScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBar.horizontalCenter
        anchors.top: friendsFrameFriendsScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: friendsFrameFriendsScrollFrameScrollBarScrollUpButton
        name: "FriendsFrameFriendsScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBar.horizontalCenter
        anchors.bottom: friendsFrameFriendsScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: friendsFrameFriendsScrollFrameScrollChild
        name: "FriendsFrameFriendsScrollFrameScrollChild"
        kind: "Frame"
        wowParent: "FriendsFrameFriendsScrollFrame"
        anchors.left: friendsFrameFriendsScrollFrame.left
        anchors.top: friendsFrameFriendsScrollFrame.top
        width: 10
        height: 10
    }

    Part {
        id: friendsFrameIgnoreButton1
        name: "FriendsFrameIgnoreButton1"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        pin: "place"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 21
        anchors.top: friendsFrame.top
        anchors.topMargin: 39
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton10
        name: "FriendsFrameIgnoreButton10"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton9.horizontalCenter
        anchors.top: friendsFrameIgnoreButton9.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton10Name
        name: "FriendsFrameIgnoreButton10Name"
        kind: "FontString"
        text: "Isotopebelle"
        wowParent: "FriendsFrameIgnoreButton10"
        anchors.left: friendsFrameIgnoreButton10.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton10.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton11
        name: "FriendsFrameIgnoreButton11"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton10.horizontalCenter
        anchors.top: friendsFrameIgnoreButton10.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton11Name
        name: "FriendsFrameIgnoreButton11Name"
        kind: "FontString"
        text: "Thrallsonjr"
        wowParent: "FriendsFrameIgnoreButton11"
        anchors.left: friendsFrameIgnoreButton11.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton11.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton12
        name: "FriendsFrameIgnoreButton12"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton11.horizontalCenter
        anchors.top: friendsFrameIgnoreButton11.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton12Name
        name: "FriendsFrameIgnoreButton12Name"
        kind: "FontString"
        text: "Tyrandewind"
        wowParent: "FriendsFrameIgnoreButton12"
        anchors.left: friendsFrameIgnoreButton12.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton12.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton1Name
        name: "FriendsFrameIgnoreButton1Name"
        kind: "FontString"
        wowParent: "FriendsFrameIgnoreButton1"
        anchors.left: friendsFrameIgnoreButton1.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton2
        name: "FriendsFrameIgnoreButton2"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton1.horizontalCenter
        anchors.top: friendsFrameIgnoreButton1.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton2Name
        name: "FriendsFrameIgnoreButton2Name"
        kind: "FontString"
        text: "Booped"
        wowParent: "FriendsFrameIgnoreButton2"
        anchors.left: friendsFrameIgnoreButton2.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton3
        name: "FriendsFrameIgnoreButton3"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton2.horizontalCenter
        anchors.top: friendsFrameIgnoreButton2.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton3Name
        name: "FriendsFrameIgnoreButton3Name"
        kind: "FontString"
        text: "Carmelita"
        wowParent: "FriendsFrameIgnoreButton3"
        anchors.left: friendsFrameIgnoreButton3.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton4
        name: "FriendsFrameIgnoreButton4"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton3.horizontalCenter
        anchors.top: friendsFrameIgnoreButton3.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton4Name
        name: "FriendsFrameIgnoreButton4Name"
        kind: "FontString"
        text: "Chouafa"
        wowParent: "FriendsFrameIgnoreButton4"
        anchors.left: friendsFrameIgnoreButton4.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton4.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton5
        name: "FriendsFrameIgnoreButton5"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton4.horizontalCenter
        anchors.top: friendsFrameIgnoreButton4.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton5Name
        name: "FriendsFrameIgnoreButton5Name"
        kind: "FontString"
        text: "Danty"
        wowParent: "FriendsFrameIgnoreButton5"
        anchors.left: friendsFrameIgnoreButton5.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton5.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton6
        name: "FriendsFrameIgnoreButton6"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton5.horizontalCenter
        anchors.top: friendsFrameIgnoreButton5.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton6Name
        name: "FriendsFrameIgnoreButton6Name"
        kind: "FontString"
        text: "Droxus"
        wowParent: "FriendsFrameIgnoreButton6"
        anchors.left: friendsFrameIgnoreButton6.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton6.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton7
        name: "FriendsFrameIgnoreButton7"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton6.horizontalCenter
        anchors.top: friendsFrameIgnoreButton6.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton7Name
        name: "FriendsFrameIgnoreButton7Name"
        kind: "FontString"
        text: "Faenyll"
        wowParent: "FriendsFrameIgnoreButton7"
        anchors.left: friendsFrameIgnoreButton7.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton7.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton8
        name: "FriendsFrameIgnoreButton8"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton7.horizontalCenter
        anchors.top: friendsFrameIgnoreButton7.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton8Name
        name: "FriendsFrameIgnoreButton8Name"
        kind: "FontString"
        text: "Fransisco"
        wowParent: "FriendsFrameIgnoreButton8"
        anchors.left: friendsFrameIgnoreButton8.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton8.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnoreButton9
        name: "FriendsFrameIgnoreButton9"
        kind: "Button"
        wowParent: "IgnoreListFrame"
        anchors.horizontalCenter: friendsFrameIgnoreButton8.horizontalCenter
        anchors.top: friendsFrameIgnoreButton8.bottom
        width: 298
        height: 16
    }

    Part {
        id: friendsFrameIgnoreButton9Name
        name: "FriendsFrameIgnoreButton9Name"
        kind: "FontString"
        text: "Harmful"
        wowParent: "FriendsFrameIgnoreButton9"
        anchors.left: friendsFrameIgnoreButton9.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameIgnoreButton9.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 288
        height: 12
    }

    Part {
        id: friendsFrameIgnorePlayerButton
        name: "FriendsFrameIgnorePlayerButton"
        kind: "Button"
        text: "Ignore Player"
        wowParent: "IgnoreListFrame"
        style: "Button"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 15
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 81
        width: 131
        height: 21
    }

    Part {
        id: friendsFrameIgnorePlayerButtonText
        name: "FriendsFrameIgnorePlayerButtonText"
        kind: "FontString"
        text: "Ignore Player"
        wowParent: "FriendsFrameIgnorePlayerButton"
        anchors.horizontalCenter: friendsFrameIgnorePlayerButton.horizontalCenter
        anchors.verticalCenter: friendsFrameIgnorePlayerButton.verticalCenter
        width: 75.1
        height: 10.3
    }

    Part {
        id: friendsFrameIgnoreScrollFrame
        name: "FriendsFrameIgnoreScrollFrame"
        kind: "ScrollFrame"
        wowParent: "IgnoreListFrame"
        pin: "all"
        anchors.right: friendsFrame.right
        anchors.rightMargin: 65
        anchors.top: friendsFrame.top
        anchors.topMargin: 36
        width: 298
        height: 340
    }

    Part {
        id: friendsFrameIgnoreScrollFrameDiabolicZone
        name: "FriendsFrameIgnoreScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "IgnoreListFrame"
        anchors.left: friendsFrameIgnoreScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: friendsFrameIgnoreScrollFrame.top
        anchors.topMargin: -2
        width: 332
        height: 344
    }

    Part {
        id: friendsFrameIgnoredHeader
        name: "FriendsFrameIgnoredHeader"
        kind: "Frame"
        wowParent: "FriendsFrameIgnoreButton1"
        anchors.left: friendsFrameIgnoreButton1.left
        anchors.top: friendsFrameIgnoreButton1.top
        width: 302
        height: 16
    }

    Part {
        id: friendsFrameIgnoredHeaderTitle
        name: "FriendsFrameIgnoredHeaderTitle"
        kind: "FontString"
        text: "Ignored"
        wowParent: "FriendsFrameIgnoredHeader"
        anchors.left: friendsFrameIgnoredHeader.left
        anchors.leftMargin: 5
        anchors.verticalCenter: friendsFrameIgnoredHeader.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 47.4
        height: 11.9
    }

    Part {
        id: friendsFrameSendMessageButton
        name: "FriendsFrameSendMessageButton"
        kind: "Button"
        text: "Send Message"
        wowParent: "FriendsListFrame"
        style: "Button"
        anchors.right: friendsFrame.right
        anchors.rightMargin: 41
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 81
        width: 131
        height: 21
    }

    Part {
        id: friendsFrameSendMessageButtonText
        name: "FriendsFrameSendMessageButtonText"
        kind: "FontString"
        text: "Send Message"
        wowParent: "FriendsFrameSendMessageButton"
        anchors.horizontalCenter: friendsFrameSendMessageButton.horizontalCenter
        anchors.verticalCenter: friendsFrameSendMessageButton.verticalCenter
        width: 78.2
        height: 10.3
    }

    Part {
        id: friendsFrameStatusDropDown
        name: "FriendsFrameStatusDropDown"
        kind: "Frame"
        wowParent: "FriendsTabHeader"
        style: "DropDown"
        anchors.left: friendsFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 78
        height: 32
    }

    Part {
        id: friendsFrameStatusDropDownButton
        name: "FriendsFrameStatusDropDownButton"
        kind: "Button"
        wowParent: "FriendsFrameStatusDropDown"
        anchors.right: friendsFrameStatusDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: friendsFrameStatusDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: friendsFrameStatusDropDownDiabolicField
        name: "FriendsFrameStatusDropDownDiabolicField"
        kind: "Frame"
        wowParent: "FriendsFrameStatusDropDown"
        anchors.left: friendsFrameStatusDropDown.left
        anchors.verticalCenter: friendsFrameStatusDropDown.verticalCenter
        width: 78
        height: 22
    }

    Part {
        id: friendsFrameStatusDropDownMouseOver
        name: "FriendsFrameStatusDropDownMouseOver"
        kind: "Frame"
        wowParent: "FriendsFrameStatusDropDown"
        anchors.left: friendsFrameStatusDropDown.left
        anchors.leftMargin: 16
        anchors.top: friendsFrameStatusDropDown.top
        anchors.topMargin: 2
        width: 22
        height: 23
    }

    Part {
        id: friendsFrameTab1
        name: "FriendsFrameTab1"
        kind: "Button"
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

    Part {
        id: friendsFrameTab2
        name: "FriendsFrameTab2"
        kind: "Button"
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

    Part {
        id: friendsFrameTab3
        name: "FriendsFrameTab3"
        kind: "Button"
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

    Part {
        id: friendsFrameTab4
        name: "FriendsFrameTab4"
        kind: "Button"
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

    Part {
        id: friendsFrameTab5
        name: "FriendsFrameTab5"
        kind: "Button"
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

    Part {
        id: friendsFrameTitleText
        name: "FriendsFrameTitleText"
        kind: "FontString"
        text: "Raid"
        wowParent: "FriendsFrameDiabolicTitlePlate"
        anchors.horizontalCenter: friendsFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: friendsFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.7
        height: 14.2
    }

    Part {
        id: friendsFrameUnsquelchButton
        name: "FriendsFrameUnsquelchButton"
        kind: "Button"
        text: "Remove Player"
        wowParent: "IgnoreListFrame"
        style: "Button"
        anchors.right: friendsFrame.right
        anchors.rightMargin: 38
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 81
        width: 134
        height: 21
    }

    Part {
        id: friendsFrameUnsquelchButtonText
        name: "FriendsFrameUnsquelchButtonText"
        kind: "FontString"
        text: "Remove Player"
        wowParent: "FriendsFrameUnsquelchButton"
        anchors.horizontalCenter: friendsFrameUnsquelchButton.horizontalCenter
        anchors.verticalCenter: friendsFrameUnsquelchButton.verticalCenter
        width: 81.4
        height: 10.3
    }

    Part {
        id: friendsListFrame
        name: "FriendsListFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Part {
        id: friendsTabHeader
        name: "FriendsTabHeader"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Part {
        id: friendsTabHeaderTab1
        name: "FriendsTabHeaderTab1"
        kind: "Button"
        text: "Friends"
        wowParent: "FriendsTabHeader"
        style: "Tab"
        anchors.left: friendsFrameStatusDropDown.right
        anchors.leftMargin: -4
        anchors.verticalCenter: friendsFrameStatusDropDown.verticalCenter
        width: 69
        height: 32
    }

    Part {
        id: friendsTabHeaderTab1Text
        name: "FriendsTabHeaderTab1Text"
        kind: "FontString"
        text: "Friends"
        wowParent: "FriendsTabHeaderTab1"
        anchors.horizontalCenter: friendsTabHeaderTab1.horizontalCenter
        anchors.verticalCenter: friendsTabHeaderTab1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 48.2
        height: 13
    }

    Part {
        id: friendsTabHeaderTab2
        name: "FriendsTabHeaderTab2"
        kind: "Button"
        text: "Ignore"
        wowParent: "FriendsTabHeader"
        style: "Tab"
        anchors.left: friendsTabHeaderTab1.right
        anchors.verticalCenter: friendsTabHeaderTab1.verticalCenter
        width: 65.4
        height: 32
    }

    Part {
        id: friendsTabHeaderTab2Text
        name: "FriendsTabHeaderTab2Text"
        kind: "FontString"
        text: "Ignore"
        wowParent: "FriendsTabHeaderTab2"
        anchors.horizontalCenter: friendsTabHeaderTab2.horizontalCenter
        anchors.verticalCenter: friendsTabHeaderTab2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 43.5
        height: 13
    }

    Part {
        id: friendsTooltip
        name: "FriendsTooltip"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrameFriendsScrollFrameButton10.right
        anchors.leftMargin: 36
        anchors.top: friendsFrameFriendsScrollFrameButton10.top
        width: 67.7
        height: 35.8
    }

    Part {
        id: friendsTooltipHeader
        name: "FriendsTooltipHeader"
        kind: "FontString"
        text: "Droxus"
        wowParent: "FriendsTooltip"
        anchors.left: friendsTooltip.left
        anchors.leftMargin: 12
        anchors.top: friendsTooltip.top
        anchors.topMargin: 12
        width: 152.9
        height: 10.3
    }

    Part {
        id: guildEventFrame
        name: "GuildEventFrame"
        kind: "Frame"
        wowParent: "GuildEventLogFrame"
        anchors.left: guildEventLogFrame.left
        anchors.leftMargin: 11
        anchors.top: guildEventLogFrame.top
        anchors.topMargin: 42
        width: 375
        height: 360
    }

    Part {
        id: guildEventLogCancelButton
        name: "GuildEventLogCancelButton"
        kind: "Button"
        text: "Close"
        wowParent: "GuildEventLogFrame"
        anchors.right: guildEventLogFrame.right
        anchors.rightMargin: 9
        anchors.bottom: guildEventLogFrame.bottom
        anchors.bottomMargin: 13
        width: 139
        height: 22
    }

    Part {
        id: guildEventLogCancelButtonText
        name: "GuildEventLogCancelButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "GuildEventLogCancelButton"
        anchors.horizontalCenter: guildEventLogCancelButton.horizontalCenter
        anchors.verticalCenter: guildEventLogCancelButton.verticalCenter
        width: 30
        height: 10.3
    }

    Part {
        id: guildEventLogCloseButton
        name: "GuildEventLogCloseButton"
        kind: "Button"
        wowParent: "GuildEventLogFrame"
        anchors.right: guildEventLogFrame.right
        anchors.rightMargin: 3
        anchors.top: guildEventLogFrame.top
        anchors.topMargin: 3
        width: 22
        height: 22
    }

    Part {
        id: guildEventLogFrame
        name: "GuildEventLogFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 395
        height: 435
    }

    Part {
        id: guildEventLogScrollChildFrame
        name: "GuildEventLogScrollChildFrame"
        kind: "Frame"
        wowParent: "GuildEventLogScrollFrame"
        anchors.left: guildEventLogScrollFrame.left
        anchors.top: guildEventLogScrollFrame.top
        width: 325
        height: 359
    }

    Part {
        id: guildEventLogScrollFrame
        name: "GuildEventLogScrollFrame"
        kind: "ScrollFrame"
        wowParent: "GuildEventFrame"
        anchors.right: guildEventFrame.right
        anchors.rightMargin: 28
        anchors.top: guildEventFrame.top
        anchors.topMargin: 6
        width: 325
        height: 349
    }

    Part {
        id: guildEventLogScrollFrameScrollBar
        name: "GuildEventLogScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "GuildEventLogScrollFrame"
        anchors.left: guildEventLogScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: guildEventLogScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 317
    }

    Part {
        id: guildEventLogScrollFrameScrollBarDiabolicTrack
        name: "GuildEventLogScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "GuildEventLogScrollFrameScrollBar"
        anchors.horizontalCenter: guildEventLogScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildEventLogScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 351
    }

    Part {
        id: guildEventLogScrollFrameScrollBarScrollDownButton
        name: "GuildEventLogScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "GuildEventLogScrollFrameScrollBar"
        anchors.horizontalCenter: guildEventLogScrollFrameScrollBar.horizontalCenter
        anchors.top: guildEventLogScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: guildEventLogScrollFrameScrollBarScrollUpButton
        name: "GuildEventLogScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "GuildEventLogScrollFrameScrollBar"
        anchors.horizontalCenter: guildEventLogScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildEventLogScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: guildEventLogTitle
        name: "GuildEventLogTitle"
        kind: "FontString"
        text: "Log"
        wowParent: "GuildEventLogFrame"
        anchors.left: guildEventLogFrame.left
        anchors.leftMargin: 17
        anchors.top: guildEventLogFrame.top
        anchors.topMargin: 17
        width: 24.5
        height: 11.9
    }

    Part {
        id: guildEventMessage
        name: "GuildEventMessage"
        kind: "FontString"
        wowParent: "GuildEventLogScrollChildFrame"
        anchors.left: guildEventLogScrollChildFrame.left
        anchors.top: guildEventLogScrollChildFrame.top
        width: 325
        height: 1623.7
    }

    Part {
        id: guildFrame
        name: "GuildFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Part {
        id: guildFrameAddMemberButton
        name: "GuildFrameAddMemberButton"
        kind: "Button"
        text: "Add Member"
        wowParent: "GuildFrame"
        style: "Button"
        anchors.right: guildFrameControlButton.left
        anchors.rightMargin: 6
        anchors.verticalCenter: guildFrameControlButton.verticalCenter
        width: 98
        height: 22
    }

    Part {
        id: guildFrameAddMemberButtonText
        name: "GuildFrameAddMemberButtonText"
        kind: "FontString"
        text: "Add Member"
        wowParent: "GuildFrameAddMemberButton"
        anchors.horizontalCenter: guildFrameAddMemberButton.horizontalCenter
        anchors.verticalCenter: guildFrameAddMemberButton.verticalCenter
        width: 70.3
        height: 10.3
    }

    Part {
        id: guildFrameButton1
        name: "GuildFrameButton1"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrame.left
        anchors.leftMargin: 15
        anchors.top: guildFrame.top
        anchors.topMargin: 70
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton1Class
        name: "GuildFrameButton1Class"
        kind: "FontString"
        text: "Death Knight"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton1Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton1Group
        name: "GuildFrameButton1Group"
        kind: "FontString"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Class.right
        anchors.verticalCenter: guildFrameButton1Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton1Level
        name: "GuildFrameButton1Level"
        kind: "FontString"
        text: "62"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton1Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton1Name
        name: "GuildFrameButton1Name"
        kind: "FontString"
        text: "Padizwerch"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton1.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton1Zone
        name: "GuildFrameButton1Zone"
        kind: "FontString"
        text: "Winterspring"
        wowParent: "GuildFrameButton1"
        anchors.left: guildFrameButton1Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton1Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton2
        name: "GuildFrameButton2"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton1.left
        anchors.top: guildFrameButton1.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton2Class
        name: "GuildFrameButton2Class"
        kind: "FontString"
        text: "Priest"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton2Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton2Group
        name: "GuildFrameButton2Group"
        kind: "FontString"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Class.right
        anchors.verticalCenter: guildFrameButton2Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton2Level
        name: "GuildFrameButton2Level"
        kind: "FontString"
        text: "80"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton2Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton2Name
        name: "GuildFrameButton2Name"
        kind: "FontString"
        text: "Padirac"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton2.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton2Zone
        name: "GuildFrameButton2Zone"
        kind: "FontString"
        text: "Stormwind City"
        wowParent: "GuildFrameButton2"
        anchors.left: guildFrameButton2Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton2Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton3
        name: "GuildFrameButton3"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton2.left
        anchors.top: guildFrameButton2.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton3Class
        name: "GuildFrameButton3Class"
        kind: "FontString"
        text: "Shaman"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton3Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton3Group
        name: "GuildFrameButton3Group"
        kind: "FontString"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Class.right
        anchors.verticalCenter: guildFrameButton3Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton3Level
        name: "GuildFrameButton3Level"
        kind: "FontString"
        text: "80"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton3Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton3Name
        name: "GuildFrameButton3Name"
        kind: "FontString"
        text: "Fancipants"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton3.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton3Zone
        name: "GuildFrameButton3Zone"
        kind: "FontString"
        text: "The Storm Peaks"
        wowParent: "GuildFrameButton3"
        anchors.left: guildFrameButton3Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton3Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton4
        name: "GuildFrameButton4"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton3.left
        anchors.top: guildFrameButton3.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton4Class
        name: "GuildFrameButton4Class"
        kind: "FontString"
        text: "Paladin"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton4Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton4Group
        name: "GuildFrameButton4Group"
        kind: "FontString"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Class.right
        anchors.verticalCenter: guildFrameButton4Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton4Level
        name: "GuildFrameButton4Level"
        kind: "FontString"
        text: "1"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton4Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton4Name
        name: "GuildFrameButton4Name"
        kind: "FontString"
        text: "Discordignis"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton4.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton4Zone
        name: "GuildFrameButton4Zone"
        kind: "FontString"
        text: "Azuremyst Isle"
        wowParent: "GuildFrameButton4"
        anchors.left: guildFrameButton4Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton4Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton5
        name: "GuildFrameButton5"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton4.left
        anchors.top: guildFrameButton4.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton5Class
        name: "GuildFrameButton5Class"
        kind: "FontString"
        text: "Priest"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton5Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton5Group
        name: "GuildFrameButton5Group"
        kind: "FontString"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Class.right
        anchors.verticalCenter: guildFrameButton5Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton5Level
        name: "GuildFrameButton5Level"
        kind: "FontString"
        text: "80"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton5Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton5Name
        name: "GuildFrameButton5Name"
        kind: "FontString"
        text: "Isari"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton5.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton5Zone
        name: "GuildFrameButton5Zone"
        kind: "FontString"
        text: "Naxxramas"
        wowParent: "GuildFrameButton5"
        anchors.left: guildFrameButton5Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton5Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton6
        name: "GuildFrameButton6"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton5.left
        anchors.top: guildFrameButton5.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton6Class
        name: "GuildFrameButton6Class"
        kind: "FontString"
        text: "Death Knight"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton6Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton6Group
        name: "GuildFrameButton6Group"
        kind: "FontString"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Class.right
        anchors.verticalCenter: guildFrameButton6Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton6Level
        name: "GuildFrameButton6Level"
        kind: "FontString"
        text: "80"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton6Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton6Name
        name: "GuildFrameButton6Name"
        kind: "FontString"
        text: "Ryddk"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton6.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton6Zone
        name: "GuildFrameButton6Zone"
        kind: "FontString"
        text: "Naxxramas"
        wowParent: "GuildFrameButton6"
        anchors.left: guildFrameButton6Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton6Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton7
        name: "GuildFrameButton7"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton6.left
        anchors.top: guildFrameButton6.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton7Class
        name: "GuildFrameButton7Class"
        kind: "FontString"
        text: "Mage"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton7Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton7Group
        name: "GuildFrameButton7Group"
        kind: "FontString"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Class.right
        anchors.verticalCenter: guildFrameButton7Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton7Level
        name: "GuildFrameButton7Level"
        kind: "FontString"
        text: "80"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton7Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton7Name
        name: "GuildFrameButton7Name"
        kind: "FontString"
        text: "Stephanaeon"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton7.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton7Zone
        name: "GuildFrameButton7Zone"
        kind: "FontString"
        text: "Naxxramas"
        wowParent: "GuildFrameButton7"
        anchors.left: guildFrameButton7Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton7Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameButton8
        name: "GuildFrameButton8"
        kind: "Button"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameButton7.left
        anchors.top: guildFrameButton7.bottom
        width: 298
        height: 16
    }

    Part {
        id: guildFrameButton8Class
        name: "GuildFrameButton8Class"
        kind: "FontString"
        text: "Paladin"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: guildFrameButton8Level.verticalCenter
        width: 80
        height: 14
    }

    Part {
        id: guildFrameButton8Group
        name: "GuildFrameButton8Group"
        kind: "FontString"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Class.right
        anchors.verticalCenter: guildFrameButton8Class.verticalCenter
        width: 40
        height: 14
    }

    Part {
        id: guildFrameButton8Level
        name: "GuildFrameButton8Level"
        kind: "FontString"
        text: "1"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Zone.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameButton8Zone.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: guildFrameButton8Name
        name: "GuildFrameButton8Name"
        kind: "FontString"
        text: "Discordignis"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8.left
        anchors.leftMargin: 14
        anchors.top: guildFrameButton8.top
        anchors.topMargin: 3
        width: 78
        height: 14
    }

    Part {
        id: guildFrameButton8Zone
        name: "GuildFrameButton8Zone"
        kind: "FontString"
        text: "Azuremyst Isle"
        wowParent: "GuildFrameButton8"
        anchors.left: guildFrameButton8Name.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameButton8Name.verticalCenter
        width: 110
        height: 14
    }

    Part {
        id: guildFrameColumnHeader1
        name: "GuildFrameColumnHeader1"
        kind: "Button"
        text: "Name"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildPlayerStatusFrame.left
        anchors.leftMargin: 20
        anchors.top: guildPlayerStatusFrame.top
        anchors.topMargin: 70
        width: 83
        height: 22
    }

    Part {
        id: guildFrameColumnHeader2
        name: "GuildFrameColumnHeader2"
        kind: "Button"
        text: "Zone"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameColumnHeader1.right
        anchors.leftMargin: -2
        anchors.verticalCenter: guildFrameColumnHeader1.verticalCenter
        width: 120
        height: 22
    }

    Part {
        id: guildFrameColumnHeader3
        name: "GuildFrameColumnHeader3"
        kind: "Button"
        text: "Lvl"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameColumnHeader2.right
        anchors.leftMargin: -2
        anchors.verticalCenter: guildFrameColumnHeader2.verticalCenter
        width: 32
        height: 22
    }

    Part {
        id: guildFrameColumnHeader4
        name: "GuildFrameColumnHeader4"
        kind: "Button"
        text: "Class"
        wowParent: "GuildPlayerStatusFrame"
        anchors.left: guildFrameColumnHeader3.right
        anchors.leftMargin: -2
        anchors.verticalCenter: guildFrameColumnHeader3.verticalCenter
        width: 92
        height: 22
    }

    Part {
        id: guildFrameControlButton
        name: "GuildFrameControlButton"
        kind: "Button"
        text: "Guild Control"
        wowParent: "GuildFrame"
        style: "Button"
        anchors.right: guildFrame.right
        anchors.rightMargin: 39
        anchors.bottom: guildFrame.bottom
        anchors.bottomMargin: 82
        width: 104
        height: 22
    }

    Part {
        id: guildFrameControlButtonText
        name: "GuildFrameControlButtonText"
        kind: "FontString"
        text: "Guild Control"
        wowParent: "GuildFrameControlButton"
        anchors.horizontalCenter: guildFrameControlButton.horizontalCenter
        anchors.verticalCenter: guildFrameControlButton.verticalCenter
        width: 72.7
        height: 10.3
    }

    Part {
        id: guildFrameGuildInformationButton
        name: "GuildFrameGuildInformationButton"
        kind: "Button"
        text: "Guild Information"
        wowParent: "GuildFrame"
        style: "Button"
        anchors.right: guildFrameAddMemberButton.left
        anchors.rightMargin: 6
        anchors.verticalCenter: guildFrameAddMemberButton.verticalCenter
        width: 123
        height: 22
    }

    Part {
        id: guildFrameGuildInformationButtonText
        name: "GuildFrameGuildInformationButtonText"
        kind: "FontString"
        text: "Guild Information"
        wowParent: "GuildFrameGuildInformationButton"
        anchors.horizontalCenter: guildFrameGuildInformationButton.horizontalCenter
        anchors.verticalCenter: guildFrameGuildInformationButton.verticalCenter
        width: 98.8
        height: 10.3
    }

    Part {
        id: guildFrameGuildListToggleButton
        name: "GuildFrameGuildListToggleButton"
        kind: "Button"
        text: "Player Status"
        wowParent: "GuildFrame"
        anchors.left: guildFrame.left
        anchors.leftMargin: 307
        anchors.verticalCenter: guildFrame.verticalCenter
        anchors.verticalCenterOffset: 34
        width: 32
        height: 32
    }

    Part {
        id: guildFrameLFGButton
        name: "GuildFrameLFGButton"
        kind: "CheckButton"
        wowParent: "GuildFrameLFGFrame"
        style: "CheckBox"
        anchors.left: friendsFrameDiabolicBand.left
        anchors.leftMargin: 10
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: guildFrameLFGButtonText
        name: "GuildFrameLFGButtonText"
        kind: "FontString"
        text: "Show Offline Members"
        wowParent: "GuildFrameLFGButton"
        anchors.left: guildFrameLFGButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: guildFrameLFGButton.verticalCenter
        width: 129.6
        height: 14.2
    }

    Part {
        id: guildFrameLFGFrame
        name: "GuildFrameLFGFrame"
        kind: "Frame"
        wowParent: "GuildFrame"
        anchors.right: guildFrame.right
        anchors.rightMargin: 42
        anchors.top: guildFrame.top
        anchors.topMargin: 13
        width: 210
        height: 23
    }

    Part {
        id: guildFrameNotesLabel
        name: "GuildFrameNotesLabel"
        kind: "FontString"
        text: "Guild Message Of The Day:"
        wowParent: "GuildFrame"
        anchors.left: guildFrame.left
        anchors.leftMargin: 23
        anchors.top: guildFrame.top
        anchors.topMargin: 319
        width: 225
        height: 11
    }

    Part {
        id: guildFrameNotesText
        name: "GuildFrameNotesText"
        kind: "FontString"
        text: "Naxx25man on Saturday 4pm ish ST - Discord https://discord.gg/xYy82MWUx2"
        wowParent: "GuildFrame"
        anchors.left: guildFrameNotesLabel.left
        anchors.top: guildFrameNotesLabel.bottom
        anchors.topMargin: 3
        width: 315
        height: 36
    }

    Part {
        id: guildFrameOnlineTotals
        name: "GuildFrameOnlineTotals"
        kind: "FontString"
        wowParent: "GuildFrame"
        anchors.left: guildFrameTotals.right
        anchors.leftMargin: 3
        anchors.verticalCenter: guildFrameTotals.verticalCenter
        width: 53.7
        height: 16
    }

    Part {
        id: guildFrameTotals
        name: "GuildFrameTotals"
        kind: "FontString"
        wowParent: "GuildFrame"
        anchors.horizontalCenter: guildFrame.left
        anchors.horizontalCenterOffset: 75
        anchors.bottom: guildFrame.verticalCenter
        anchors.bottomMargin: -42
        width: 87.7
        height: 16
    }

    Part {
        id: guildInfoCancelButton
        name: "GuildInfoCancelButton"
        kind: "Button"
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

    Part {
        id: guildInfoCancelButtonText
        name: "GuildInfoCancelButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "GuildInfoCancelButton"
        anchors.horizontalCenter: guildInfoCancelButton.horizontalCenter
        anchors.verticalCenter: guildInfoCancelButton.verticalCenter
        width: 30
        height: 10.3
    }

    Part {
        id: guildInfoCloseButton
        name: "GuildInfoCloseButton"
        kind: "Button"
        wowParent: "GuildInfoFrame"
        anchors.right: guildInfoFrame.right
        anchors.rightMargin: 3
        anchors.top: guildInfoFrame.top
        anchors.topMargin: 3
        width: 22
        height: 22
    }

    Part {
        id: guildInfoEditBox
        name: "GuildInfoEditBox"
        kind: "EditBox"
        wowParent: "GuildInfoFrameScrollFrame"
        anchors.left: guildInfoFrameScrollFrame.left
        anchors.top: guildInfoFrameScrollFrame.top
        width: 240
        height: 106.7
    }

    Part {
        id: guildInfoFrame
        name: "GuildInfoFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 297
        height: 298
    }

    Part {
        id: guildInfoFrameScrollFrame
        name: "GuildInfoFrameScrollFrame"
        kind: "ScrollFrame"
        wowParent: "GuildInfoTextBackground"
        anchors.left: guildInfoTextBackground.left
        anchors.leftMargin: 5
        anchors.top: guildInfoTextBackground.top
        anchors.topMargin: 7
        width: 243
        height: 208
    }

    Part {
        id: guildInfoFrameScrollFrameScrollBar
        name: "GuildInfoFrameScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "GuildInfoFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: guildInfoFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: guildInfoFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 176
    }

    Part {
        id: guildInfoFrameScrollFrameScrollBarDiabolicTrack
        name: "GuildInfoFrameScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "GuildInfoFrameScrollFrameScrollBar"
        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildInfoFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 210
    }

    Part {
        id: guildInfoFrameScrollFrameScrollBarScrollDownButton
        name: "GuildInfoFrameScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "GuildInfoFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: guildInfoFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: guildInfoFrameScrollFrameScrollBarScrollUpButton
        name: "GuildInfoFrameScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "GuildInfoFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildInfoFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: guildInfoGuildEventButton
        name: "GuildInfoGuildEventButton"
        kind: "Button"
        text: "Log"
        wowParent: "GuildInfoFrame"
        style: "Button"
        anchors.right: guildInfoSaveButton.left
        anchors.rightMargin: 32
        anchors.verticalCenter: guildInfoSaveButton.verticalCenter
        width: 65
        height: 22
    }

    Part {
        id: guildInfoGuildEventButtonText
        name: "GuildInfoGuildEventButtonText"
        kind: "FontString"
        text: "Log"
        wowParent: "GuildInfoGuildEventButton"
        anchors.horizontalCenter: guildInfoGuildEventButton.horizontalCenter
        anchors.verticalCenter: guildInfoGuildEventButton.verticalCenter
        width: 20.5
        height: 10.3
    }

    Part {
        id: guildInfoSaveButton
        name: "GuildInfoSaveButton"
        kind: "Button"
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

    Part {
        id: guildInfoSaveButtonText
        name: "GuildInfoSaveButtonText"
        kind: "FontString"
        text: "Accept"
        wowParent: "GuildInfoSaveButton"
        anchors.horizontalCenter: guildInfoSaveButton.horizontalCenter
        anchors.verticalCenter: guildInfoSaveButton.verticalCenter
        width: 37.1
        height: 10.3
    }

    Part {
        id: guildInfoTextBackground
        name: "GuildInfoTextBackground"
        kind: "Frame"
        wowParent: "GuildInfoFrame"
        anchors.left: guildInfoFrame.left
        anchors.leftMargin: 11
        anchors.top: guildInfoFrame.top
        anchors.topMargin: 42
        width: 276
        height: 220
    }

    Part {
        id: guildInfoTitle
        name: "GuildInfoTitle"
        kind: "FontString"
        text: "Guild Information"
        wowParent: "GuildInfoFrame"
        anchors.left: guildInfoFrame.left
        anchors.leftMargin: 17
        anchors.top: guildInfoFrame.top
        anchors.topMargin: 17
        width: 105.1
        height: 11.9
    }

    Part {
        id: guildListScrollFrameDiabolicZone
        name: "GuildListScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "GuildFrame"
        anchors.left: guildListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: guildListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 240
    }

    Part {
        id: guildListScrollFrameDiabolicZoneColumnBar
        name: "GuildListScrollFrameDiabolicZoneColumnBar"
        kind: "Frame"
        wowParent: "GuildListScrollFrameDiabolicZone"
        anchors.left: guildListScrollFrameDiabolicZone.left
        anchors.bottom: guildListScrollFrameDiabolicZone.top
        width: 330
        height: 22
    }

    Part {
        id: guildMOTDEditButton
        name: "GuildMOTDEditButton"
        kind: "Button"
        wowParent: "GuildFrame"
        anchors.left: guildFrameNotesText.left
        anchors.top: guildFrameNotesText.top
        width: 315
        height: 36
    }

    Part {
        id: guildMemberDetailFrame
        name: "GuildMemberDetailFrame"
        kind: "Frame"
        wowParent: "GuildFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 212
        height: 270
    }

    Part {
        id: guildPlayerStatusFrame
        name: "GuildPlayerStatusFrame"
        kind: "Frame"
        wowParent: "GuildFrame"
        anchors.left: guildFrame.left
        anchors.top: guildFrame.top
        anchors.topMargin: -25
        width: 300
        height: 200
    }

    Part {
        id: ignoreListFrame
        name: "IgnoreListFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Part {
        id: raidFrame
        name: "RaidFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Part {
        id: raidFrameConvertToRaidButton
        name: "RaidFrameConvertToRaidButton"
        kind: "Button"
        text: "Convert To Raid"
        wowParent: "RaidFrame"
        style: "Button"
        anchors.right: friendsFrameDiabolicBand.horizontalCenter
        anchors.rightMargin: 4
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 115
        height: 21
    }

    Part {
        id: raidFrameConvertToRaidButtonText
        name: "RaidFrameConvertToRaidButtonText"
        kind: "FontString"
        text: "Convert To Raid"
        wowParent: "RaidFrameConvertToRaidButton"
        anchors.horizontalCenter: raidFrameConvertToRaidButton.horizontalCenter
        anchors.verticalCenter: raidFrameConvertToRaidButton.verticalCenter
        width: 86.9
        height: 10.3
    }

    Part {
        id: raidFrameNotInRaid
        name: "RaidFrameNotInRaid"
        kind: "Frame"
        wowParent: "RaidFrame"
        anchors.left: raidFrame.left
        anchors.top: raidFrame.top
        width: 384
        height: 512
    }

    Part {
        id: raidFrameNotInRaidRaidBrowserButton
        name: "RaidFrameNotInRaidRaidBrowserButton"
        kind: "Button"
        text: "Open Raid Browser"
        wowParent: "RaidFrameNotInRaid"
        style: "Button"
        anchors.horizontalCenter: raidFrameRaidBrowserDescription.horizontalCenter
        anchors.top: raidFrameRaidBrowserDescription.bottom
        anchors.topMargin: 10
        width: 260
        height: 22
    }

    Part {
        id: raidFrameNotInRaidRaidBrowserButtonText
        name: "RaidFrameNotInRaidRaidBrowserButtonText"
        kind: "FontString"
        text: "Open Raid Browser"
        wowParent: "RaidFrameNotInRaidRaidBrowserButton"
        anchors.horizontalCenter: raidFrameNotInRaidRaidBrowserButton.horizontalCenter
        anchors.verticalCenter: raidFrameNotInRaidRaidBrowserButton.verticalCenter
        width: 105.1
        height: 10.3
    }

    Part {
        id: raidFrameRaidBrowserDescription
        name: "RaidFrameRaidBrowserDescription"
        kind: "FontString"
        text: "Find a Raid Group or Assemble a Raid"
        wowParent: "RaidFrameNotInRaid"
        anchors.horizontalCenter: raidFrameRaidDescription.horizontalCenter
        anchors.top: raidFrameRaidDescription.bottom
        anchors.topMargin: 50
        width: 300
        height: 11.9
    }

    Part {
        id: raidFrameRaidDescription
        name: "RaidFrameRaidDescription"
        kind: "FontString"
        wowParent: "RaidFrameNotInRaid"
        anchors.left: raidFrameNotInRaid.left
        anchors.leftMargin: 29
        anchors.top: raidFrameNotInRaid.top
        anchors.topMargin: 85
        width: 300
        height: 165.9
    }

    Part {
        id: raidFrameRaidInfoButton
        name: "RaidFrameRaidInfoButton"
        kind: "Button"
        text: "Raid Info"
        wowParent: "RaidFrame"
        style: "Button"
        anchors.left: friendsFrameDiabolicBand.horizontalCenter
        anchors.leftMargin: 4
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 90
        height: 21
    }

    Part {
        id: raidFrameRaidInfoButtonText
        name: "RaidFrameRaidInfoButtonText"
        kind: "FontString"
        text: "Raid Info"
        wowParent: "RaidFrameRaidInfoButton"
        anchors.horizontalCenter: raidFrameRaidInfoButton.horizontalCenter
        anchors.verticalCenter: raidFrameRaidInfoButton.verticalCenter
        width: 50.6
        height: 10.3
    }

    Part {
        id: whoFrame
        name: "WhoFrame"
        kind: "Frame"
        wowParent: "FriendsFrame"
        anchors.left: friendsFrame.left
        anchors.top: friendsFrame.top
        width: 384
        height: 512
    }

    Part {
        id: whoFrameAddFriendButton
        name: "WhoFrameAddFriendButton"
        kind: "Button"
        text: "Add Friend"
        wowParent: "WhoFrame"
        style: "Button"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 106.9
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 82
        width: 115.6
        height: 22
    }

    Part {
        id: whoFrameAddFriendButtonText
        name: "WhoFrameAddFriendButtonText"
        kind: "FontString"
        text: "Add Friend"
        wowParent: "WhoFrameAddFriendButton"
        anchors.horizontalCenter: whoFrameAddFriendButton.horizontalCenter
        anchors.verticalCenter: whoFrameAddFriendButton.verticalCenter
        width: 59.3
        height: 10.3
    }

    Part {
        id: whoFrameButton1
        name: "WhoFrameButton1"
        kind: "Button"
        wowParent: "WhoFrame"
        pin: "place"
        anchors.left: whoFrame.left
        anchors.leftMargin: 15
        anchors.top: whoFrame.top
        anchors.topMargin: 61
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton10
        name: "WhoFrameButton10"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton9.left
        anchors.top: whoFrameButton9.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton10Class
        name: "WhoFrameButton10Class"
        kind: "FontString"
        text: "Shaman"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton10Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton10Level
        name: "WhoFrameButton10Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton10Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton10Name
        name: "WhoFrameButton10Name"
        kind: "FontString"
        text: "Cattiviy"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton10.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton10Variable
        name: "WhoFrameButton10Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton10"
        anchors.left: whoFrameButton10Name.right
        anchors.verticalCenter: whoFrameButton10Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton11
        name: "WhoFrameButton11"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton10.left
        anchors.top: whoFrameButton10.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton11Class
        name: "WhoFrameButton11Class"
        kind: "FontString"
        text: "Shaman"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton11Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton11Level
        name: "WhoFrameButton11Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton11Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton11Name
        name: "WhoFrameButton11Name"
        kind: "FontString"
        text: "Naturalfocus"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton11.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton11Variable
        name: "WhoFrameButton11Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton11"
        anchors.left: whoFrameButton11Name.right
        anchors.verticalCenter: whoFrameButton11Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton12
        name: "WhoFrameButton12"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton11.left
        anchors.top: whoFrameButton11.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton12Class
        name: "WhoFrameButton12Class"
        kind: "FontString"
        text: "Shaman"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton12Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton12Level
        name: "WhoFrameButton12Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton12Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton12Name
        name: "WhoFrameButton12Name"
        kind: "FontString"
        text: "Prentiss"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton12.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton12Variable
        name: "WhoFrameButton12Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton12"
        anchors.left: whoFrameButton12Name.right
        anchors.verticalCenter: whoFrameButton12Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton13
        name: "WhoFrameButton13"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton12.left
        anchors.top: whoFrameButton12.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton13Class
        name: "WhoFrameButton13Class"
        kind: "FontString"
        text: "Warrior"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton13Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton13Level
        name: "WhoFrameButton13Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton13Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton13Name
        name: "WhoFrameButton13Name"
        kind: "FontString"
        text: "Isabaa"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton13.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton13Variable
        name: "WhoFrameButton13Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton13"
        anchors.left: whoFrameButton13Name.right
        anchors.verticalCenter: whoFrameButton13Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton14
        name: "WhoFrameButton14"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton13.left
        anchors.top: whoFrameButton13.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton14Class
        name: "WhoFrameButton14Class"
        kind: "FontString"
        text: "Warrior"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton14Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton14Level
        name: "WhoFrameButton14Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton14Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton14Name
        name: "WhoFrameButton14Name"
        kind: "FontString"
        text: "Pissgrave"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton14.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton14Variable
        name: "WhoFrameButton14Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton14"
        anchors.left: whoFrameButton14Name.right
        anchors.verticalCenter: whoFrameButton14Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton15
        name: "WhoFrameButton15"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton14.left
        anchors.top: whoFrameButton14.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton15Class
        name: "WhoFrameButton15Class"
        kind: "FontString"
        text: "Mage"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton15Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton15Level
        name: "WhoFrameButton15Level"
        kind: "FontString"
        text: "71"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton15Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton15Name
        name: "WhoFrameButton15Name"
        kind: "FontString"
        text: "Washuwan"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton15.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton15Variable
        name: "WhoFrameButton15Variable"
        kind: "FontString"
        text: "Dragonblight"
        wowParent: "WhoFrameButton15"
        anchors.left: whoFrameButton15Name.right
        anchors.verticalCenter: whoFrameButton15Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton16
        name: "WhoFrameButton16"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton15.left
        anchors.top: whoFrameButton15.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton16Class
        name: "WhoFrameButton16Class"
        kind: "FontString"
        text: "Druid"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton16Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton16Level
        name: "WhoFrameButton16Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton16Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton16Name
        name: "WhoFrameButton16Name"
        kind: "FontString"
        text: "Eneldo"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton16.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton16Variable
        name: "WhoFrameButton16Variable"
        kind: "FontString"
        text: "Dragonblight"
        wowParent: "WhoFrameButton16"
        anchors.left: whoFrameButton16Name.right
        anchors.verticalCenter: whoFrameButton16Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton17
        name: "WhoFrameButton17"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton16.left
        anchors.top: whoFrameButton16.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton17Class
        name: "WhoFrameButton17Class"
        kind: "FontString"
        text: "Mage"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton17Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton17Level
        name: "WhoFrameButton17Level"
        kind: "FontString"
        text: "6"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton17Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton17Name
        name: "WhoFrameButton17Name"
        kind: "FontString"
        text: "Fistndntilus"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton17.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton17Variable
        name: "WhoFrameButton17Variable"
        kind: "FontString"
        text: "Dun Morogh"
        wowParent: "WhoFrameButton17"
        anchors.left: whoFrameButton17Name.right
        anchors.verticalCenter: whoFrameButton17Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton18
        name: "WhoFrameButton18"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton17.left
        anchors.top: whoFrameButton17.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton18Class
        name: "WhoFrameButton18Class"
        kind: "FontString"
        text: "Shaman"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton18Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton18Level
        name: "WhoFrameButton18Level"
        kind: "FontString"
        text: "9"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton18Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton18Name
        name: "WhoFrameButton18Name"
        kind: "FontString"
        text: "Krazmor"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton18.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton18Variable
        name: "WhoFrameButton18Variable"
        kind: "FontString"
        text: "Durotar"
        wowParent: "WhoFrameButton18"
        anchors.left: whoFrameButton18Name.right
        anchors.verticalCenter: whoFrameButton18Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton19
        name: "WhoFrameButton19"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton18.left
        anchors.top: whoFrameButton18.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton19Class
        name: "WhoFrameButton19Class"
        kind: "FontString"
        text: "Death Knight"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton19Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton19Level
        name: "WhoFrameButton19Level"
        kind: "FontString"
        text: "73"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton19Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton19Name
        name: "WhoFrameButton19Name"
        kind: "FontString"
        text: "Littlebottom"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton19.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton19Variable
        name: "WhoFrameButton19Variable"
        kind: "FontString"
        text: "Eastern Plaguelands"
        wowParent: "WhoFrameButton19"
        anchors.left: whoFrameButton19Name.right
        anchors.verticalCenter: whoFrameButton19Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton1Class
        name: "WhoFrameButton1Class"
        kind: "FontString"
        text: "Death Knight"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton1Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton1Level
        name: "WhoFrameButton1Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton1Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton1Name
        name: "WhoFrameButton1Name"
        kind: "FontString"
        text: "Deathrain"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton1.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton1Variable
        name: "WhoFrameButton1Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton1"
        anchors.left: whoFrameButton1Name.right
        anchors.verticalCenter: whoFrameButton1Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton2
        name: "WhoFrameButton2"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton1.left
        anchors.top: whoFrameButton1.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton2Class
        name: "WhoFrameButton2Class"
        kind: "FontString"
        text: "Death Knight"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton2Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton2Level
        name: "WhoFrameButton2Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton2Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton2Name
        name: "WhoFrameButton2Name"
        kind: "FontString"
        text: "Naterisdk"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton2.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton2Variable
        name: "WhoFrameButton2Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton2"
        anchors.left: whoFrameButton2Name.right
        anchors.verticalCenter: whoFrameButton2Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton3
        name: "WhoFrameButton3"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton2.left
        anchors.top: whoFrameButton2.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton3Class
        name: "WhoFrameButton3Class"
        kind: "FontString"
        text: "Death Knight"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton3Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton3Level
        name: "WhoFrameButton3Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton3Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton3Name
        name: "WhoFrameButton3Name"
        kind: "FontString"
        text: "Ripcord"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton3.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton3Variable
        name: "WhoFrameButton3Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton3"
        anchors.left: whoFrameButton3Name.right
        anchors.verticalCenter: whoFrameButton3Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton4
        name: "WhoFrameButton4"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton3.left
        anchors.top: whoFrameButton3.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton4Class
        name: "WhoFrameButton4Class"
        kind: "FontString"
        text: "Druid"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton4Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton4Level
        name: "WhoFrameButton4Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton4Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton4Name
        name: "WhoFrameButton4Name"
        kind: "FontString"
        text: "Faenielle"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton4.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton4Variable
        name: "WhoFrameButton4Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton4"
        anchors.left: whoFrameButton4Name.right
        anchors.verticalCenter: whoFrameButton4Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton5
        name: "WhoFrameButton5"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton4.left
        anchors.top: whoFrameButton4.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton5Class
        name: "WhoFrameButton5Class"
        kind: "FontString"
        text: "Hunter"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton5Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton5Level
        name: "WhoFrameButton5Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton5Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton5Name
        name: "WhoFrameButton5Name"
        kind: "FontString"
        text: "Lezbow"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton5.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton5Variable
        name: "WhoFrameButton5Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton5"
        anchors.left: whoFrameButton5Name.right
        anchors.verticalCenter: whoFrameButton5Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton6
        name: "WhoFrameButton6"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton5.left
        anchors.top: whoFrameButton5.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton6Class
        name: "WhoFrameButton6Class"
        kind: "FontString"
        text: "Mage"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton6Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton6Level
        name: "WhoFrameButton6Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton6Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton6Name
        name: "WhoFrameButton6Name"
        kind: "FontString"
        text: "Siwiel"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton6.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton6Variable
        name: "WhoFrameButton6Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton6"
        anchors.left: whoFrameButton6Name.right
        anchors.verticalCenter: whoFrameButton6Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton7
        name: "WhoFrameButton7"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton6.left
        anchors.top: whoFrameButton6.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton7Class
        name: "WhoFrameButton7Class"
        kind: "FontString"
        text: "Paladin"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton7Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton7Level
        name: "WhoFrameButton7Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton7Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton7Name
        name: "WhoFrameButton7Name"
        kind: "FontString"
        text: "Dornoxia"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton7.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton7Variable
        name: "WhoFrameButton7Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton7"
        anchors.left: whoFrameButton7Name.right
        anchors.verticalCenter: whoFrameButton7Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton8
        name: "WhoFrameButton8"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton7.left
        anchors.top: whoFrameButton7.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton8Class
        name: "WhoFrameButton8Class"
        kind: "FontString"
        text: "Paladin"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton8Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton8Level
        name: "WhoFrameButton8Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton8Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton8Name
        name: "WhoFrameButton8Name"
        kind: "FontString"
        text: "Fercho"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton8.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton8Variable
        name: "WhoFrameButton8Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton8"
        anchors.left: whoFrameButton8Name.right
        anchors.verticalCenter: whoFrameButton8Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameButton9
        name: "WhoFrameButton9"
        kind: "Button"
        wowParent: "WhoFrame"
        anchors.left: whoFrameButton8.left
        anchors.top: whoFrameButton8.bottom
        width: 298
        height: 16
    }

    Part {
        id: whoFrameButton9Class
        name: "WhoFrameButton9Class"
        kind: "FontString"
        text: "Paladin"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9Level.right
        anchors.leftMargin: 12
        anchors.verticalCenter: whoFrameButton9Level.verticalCenter
        width: 80
        height: 8
    }

    Part {
        id: whoFrameButton9Level
        name: "WhoFrameButton9Level"
        kind: "FontString"
        text: "80"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9Variable.right
        anchors.leftMargin: 2
        anchors.verticalCenter: whoFrameButton9Variable.verticalCenter
        width: 20
        height: 14
    }

    Part {
        id: whoFrameButton9Name
        name: "WhoFrameButton9Name"
        kind: "FontString"
        text: "Mayl"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9.left
        anchors.leftMargin: 10
        anchors.top: whoFrameButton9.top
        anchors.topMargin: 3
        width: 88
        height: 14
    }

    Part {
        id: whoFrameButton9Variable
        name: "WhoFrameButton9Variable"
        kind: "FontString"
        text: "Dalaran"
        wowParent: "WhoFrameButton9"
        anchors.left: whoFrameButton9Name.right
        anchors.verticalCenter: whoFrameButton9Name.verticalCenter
        width: 95
        height: 14
    }

    Part {
        id: whoFrameColumnHeader1
        name: "WhoFrameColumnHeader1"
        kind: "Button"
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

    Part {
        id: whoFrameColumnHeader2
        name: "WhoFrameColumnHeader2"
        kind: "Button"
        text: "Zone"
        wowParent: "WhoFrame"
        anchors.left: whoFrameColumnHeader1.right
        anchors.leftMargin: -2
        anchors.verticalCenter: whoFrameColumnHeader1.verticalCenter
        width: 120
        height: 22
    }

    Part {
        id: whoFrameColumnHeader3
        name: "WhoFrameColumnHeader3"
        kind: "Button"
        text: "Lvl"
        wowParent: "WhoFrame"
        anchors.left: whoFrameColumnHeader2.right
        anchors.leftMargin: -2
        anchors.verticalCenter: whoFrameColumnHeader2.verticalCenter
        width: 32
        height: 22
    }

    Part {
        id: whoFrameColumnHeader4
        name: "WhoFrameColumnHeader4"
        kind: "Button"
        text: "Class"
        wowParent: "WhoFrame"
        anchors.left: whoFrameColumnHeader3.right
        anchors.leftMargin: -2
        anchors.verticalCenter: whoFrameColumnHeader3.verticalCenter
        width: 92
        height: 22
    }

    Part {
        id: whoFrameDropDown
        name: "WhoFrameDropDown"
        kind: "Frame"
        wowParent: "WhoFrameColumnHeader2"
        style: "DropDown"
        anchors.left: friendsFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: friendsFrameDiabolicBand.verticalCenter
        width: 114
        height: 32
    }

    Part {
        id: whoFrameDropDownButton
        name: "WhoFrameDropDownButton"
        kind: "Button"
        wowParent: "WhoFrameDropDown"
        anchors.right: whoFrameDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: whoFrameDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: whoFrameDropDownDiabolicField
        name: "WhoFrameDropDownDiabolicField"
        kind: "Frame"
        wowParent: "WhoFrameDropDown"
        anchors.left: whoFrameDropDown.left
        anchors.verticalCenter: whoFrameDropDown.verticalCenter
        width: 114
        height: 22
    }

    Part {
        id: whoFrameDropDownText
        name: "WhoFrameDropDownText"
        kind: "FontString"
        text: "Zone"
        wowParent: "WhoFrameDropDown"
        anchors.horizontalCenter: whoFrameDropDown.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: whoFrameDropDown.verticalCenter
        width: 39
        height: 10
    }

    Part {
        id: whoFrameEditBox
        name: "WhoFrameEditBox"
        kind: "EditBox"
        wowParent: "WhoFrame"
        style: "EditBox"
        anchors.left: whoFrameDropDown.right
        anchors.leftMargin: 4
        anchors.verticalCenter: whoFrameDropDown.verticalCenter
        width: 200
        height: 20
    }

    Part {
        id: whoFrameEditBoxDiabolicField
        name: "WhoFrameEditBoxDiabolicField"
        kind: "Frame"
        wowParent: "WhoFrameEditBox"
        anchors.left: whoFrameEditBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: whoFrameEditBox.verticalCenter
        width: 216
        height: 22
    }

    Part {
        id: whoFrameGroupInviteButton
        name: "WhoFrameGroupInviteButton"
        kind: "Button"
        text: "Group Invite"
        wowParent: "WhoFrame"
        style: "Button"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 228.4
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 82
        width: 115.6
        height: 22
    }

    Part {
        id: whoFrameGroupInviteButtonText
        name: "WhoFrameGroupInviteButtonText"
        kind: "FontString"
        text: "Group Invite"
        wowParent: "WhoFrameGroupInviteButton"
        anchors.horizontalCenter: whoFrameGroupInviteButton.horizontalCenter
        anchors.verticalCenter: whoFrameGroupInviteButton.verticalCenter
        width: 70.3
        height: 10.3
    }

    Part {
        id: whoFrameTotals
        name: "WhoFrameTotals"
        kind: "FontString"
        text: "0 People Found  "
        wowParent: "WhoFrame"
        anchors.horizontalCenter: whoFrame.horizontalCenter
        anchors.horizontalCenterOffset: -10
        anchors.bottom: whoFrame.bottom
        anchors.bottomMargin: 127
        width: 298
        height: 16
    }

    Part {
        id: whoFrameWhoButton
        name: "WhoFrameWhoButton"
        kind: "Button"
        text: "Refresh"
        wowParent: "WhoFrame"
        style: "Button"
        anchors.left: friendsFrame.left
        anchors.leftMargin: 19
        anchors.bottom: friendsFrame.bottom
        anchors.bottomMargin: 82
        width: 81.9
        height: 22
    }

    Part {
        id: whoFrameWhoButtonText
        name: "WhoFrameWhoButtonText"
        kind: "FontString"
        text: "Refresh"
        wowParent: "WhoFrameWhoButton"
        anchors.horizontalCenter: whoFrameWhoButton.horizontalCenter
        anchors.verticalCenter: whoFrameWhoButton.verticalCenter
        width: 41.9
        height: 10.3
    }

    Part {
        id: whoListScrollFrame
        name: "WhoListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "WhoFrame"
        pin: "place"
        anchors.right: friendsFrame.right
        anchors.rightMargin: 67
        anchors.top: friendsFrame.top
        anchors.topMargin: 62
        width: 296
        height: 298
    }

    Part {
        id: whoListScrollFrameDiabolicZone
        name: "WhoListScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "WhoFrame"
        anchors.left: whoListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: whoListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 328
    }

    Part {
        id: whoListScrollFrameDiabolicZoneColumnBar
        name: "WhoListScrollFrameDiabolicZoneColumnBar"
        kind: "Frame"
        wowParent: "WhoListScrollFrameDiabolicZone"
        anchors.left: whoListScrollFrameDiabolicZone.left
        anchors.bottom: whoListScrollFrameDiabolicZone.top
        width: 330
        height: 22
    }

    Part {
        id: whoListScrollFrameScrollBar
        name: "WhoListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "WhoListScrollFrame"
        anchors.left: whoListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: whoListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 266
    }

    Part {
        id: whoListScrollFrameScrollBarDiabolicTrack
        name: "WhoListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "WhoListScrollFrameScrollBar"
        anchors.horizontalCenter: whoListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: whoListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 300
    }

    Part {
        id: whoListScrollFrameScrollBarScrollDownButton
        name: "WhoListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "WhoListScrollFrameScrollBar"
        anchors.horizontalCenter: whoListScrollFrameScrollBar.horizontalCenter
        anchors.top: whoListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: whoListScrollFrameScrollBarScrollUpButton
        name: "WhoListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "WhoListScrollFrameScrollBar"
        anchors.horizontalCenter: whoListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: whoListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: whoListScrollFrameScrollChildFrame
        name: "WhoListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "WhoListScrollFrame"
        anchors.left: whoListScrollFrame.left
        anchors.top: whoListScrollFrame.top
        width: 300
        height: 784
    }

    Ghost { id: guildListScrollFrame; name: "GuildListScrollFrame"; x: 21; y: 73; width: 0; height: 0 }
    Ghost { id: uIParent; name: "UIParent"; x: 738.5; y: 290.6; width: 0; height: 0 }
}
