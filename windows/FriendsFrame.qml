// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "FriendsFrame"
    width: 384
    height: 512

    Frame {
        name: "ChannelFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 355
        height: 512

        Frame {
            name: "ChannelFrameVerticalBar"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -35
            width: 13
            height: 300
        }

        ScrollFrame {
            name: "ChannelListScrollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 76
            width: 158
            height: 327

            Frame {
                name: "ChannelListScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 145
                height: -320

                Button {
                    name: "ChannelButton1"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 155
                    height: 20

                    FontString {
                        name: "ChannelButton1Text"
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 135
                        height: 8
                    }
                }
            }
        }

        Button {
            name: "ChannelMemberButton1"
            wowParent: "ChannelRoster"
            anchors.left: parent.left
            anchors.leftMargin: 186
            anchors.top: parent.top
            anchors.topMargin: 75
            width: 135
            height: 15

            FontString {
                name: "ChannelMemberButton1Name"
                text: "Aashwath"
                wowParent: "?"
                anchors.left: parent.left
                anchors.leftMargin: 13
                anchors.top: parent.top
                anchors.topMargin: 1
                width: 52.9
                height: 10.3
            }
        }

        Frame {
            name: "ChannelRoster"
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 121
            anchors.top: parent.top
            anchors.topMargin: 79
            width: 158
            height: 327

            FontString {
                name: "ChannelRosterChannelCount"
                anchors.left: channelRosterChannelName.right
                anchors.verticalCenter: channelRosterChannelName.verticalCenter
                width: 30
                height: 13
            }

            FontString {
                id: channelRosterChannelName
                name: "ChannelRosterChannelName"
                anchors.left: parent.left
                anchors.leftMargin: -115
                anchors.top: parent.top
                anchors.topMargin: -20
                width: 1
                height: 1
            }
        }

        ScrollFrame {
            name: "ChannelRosterScrollFrame"
            wowParent: "ChannelRoster"
            anchors.right: parent.right
            anchors.rightMargin: 39
            anchors.top: parent.top
            anchors.topMargin: 76
            width: 158
            height: 327

            Slider {
                name: "ChannelRosterScrollFrameScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 295

                Frame {
                    name: "ChannelRosterScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: channelRosterScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: channelRosterScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 329
                }

                Button {
                    name: "ChannelRosterScrollFrameScrollBarScrollDownButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: channelRosterScrollFrameScrollBarScrollUpButton
                    name: "ChannelRosterScrollFrameScrollBarScrollUpButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "ChannelRosterScrollFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 1245
            }
        }

        Ghost {
            name: "UIParent"
            x: 738.5
            y: 290.6
            width: 0
            height: 0

            Frame {
                name: "ChannelFrameDaughterFrame"
                wowParent: "ChannelFrame"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -100
                width: 212
                height: 200

                Button {
                    name: "ChannelFrameDaughterFrameCancelButton"
                    text: "Cancel"
                    anchors.right: parent.right
                    anchors.rightMargin: 9
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 12
                    width: 93.5
                    height: 22

                    FontString {
                        name: "ChannelFrameDaughterFrameCancelButtonText"
                        text: "Cancel"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 35.6
                        height: 10.3
                    }
                }

                EditBox {
                    id: channelFrameDaughterFrameChannelName
                    name: "ChannelFrameDaughterFrameChannelName"
                    anchors.left: parent.left
                    anchors.leftMargin: 23
                    anchors.top: parent.top
                    anchors.topMargin: 60
                    width: 170
                    height: 16

                    Frame {
                        name: "ChannelFrameDaughterFrameChannelNameDiabolicField"
                        anchors.left: parent.left
                        anchors.leftMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 186
                        height: 22
                    }

                    FontString {
                        name: "ChannelFrameDaughterFrameChannelNameLabel"
                        text: "Channel Name"
                        anchors.left: parent.left
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 5
                        width: 85.3
                        height: 14.2
                    }
                }

                EditBox {
                    name: "ChannelFrameDaughterFrameChannelPassword"
                    anchors.left: channelFrameDaughterFrameChannelName.left
                    anchors.top: channelFrameDaughterFrameChannelName.bottom
                    anchors.topMargin: 30
                    width: 170
                    height: 16

                    Frame {
                        name: "ChannelFrameDaughterFrameChannelPasswordDiabolicField"
                        anchors.left: parent.left
                        anchors.leftMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 186
                        height: 22
                    }

                    FontString {
                        id: channelFrameDaughterFrameChannelPasswordLabel
                        name: "ChannelFrameDaughterFrameChannelPasswordLabel"
                        text: "Password"
                        anchors.left: parent.left
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 5
                        width: 55.3
                        height: 14.2
                    }

                    FontString {
                        name: "ChannelFrameDaughterFrameChannelPasswordOptional"
                        text: "(optional)"
                        anchors.left: channelFrameDaughterFrameChannelPasswordLabel.right
                        anchors.leftMargin: 3
                        anchors.verticalCenter: channelFrameDaughterFrameChannelPasswordLabel.verticalCenter
                        width: 52.9
                        height: 10.3
                    }
                }

                Button {
                    name: "ChannelFrameDaughterFrameDetailCloseButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 22
                    height: 22
                }

                FontString {
                    name: "ChannelFrameDaughterFrameName"
                    text: "New Channel"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -5
                    anchors.top: parent.top
                    anchors.topMargin: 13
                    width: 79
                    height: 12
                }

                Button {
                    name: "ChannelFrameDaughterFrameOkayButton"
                    text: "Okay"
                    anchors.right: parent.right
                    anchors.rightMargin: 108.5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 12
                    width: 93.5
                    height: 22

                    FontString {
                        name: "ChannelFrameDaughterFrameOkayButtonText"
                        text: "Okay"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28.4
                        height: 10.3
                    }
                }
            }
        }
    }

    Frame {
        id: friendsFrameDiabolic
        name: "FriendsFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -20
        anchors.top: parent.top
        anchors.topMargin: -68
        width: 400
        height: 530

        Button {
            name: "FriendsFrameCloseButton"
            wowParent: "FriendsFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "FriendsFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 352
            height: 40

            Frame {
                id: friendsFrameStatusDropDown
                name: "FriendsFrameStatusDropDown"
                wowParent: "FriendsTabHeader"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.verticalCenter: parent.verticalCenter
                width: 78
                height: 32

                Frame {
                    name: "FriendsFrameStatusDropDownDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 78
                    height: 22

                    Button {
                        name: "FriendsFrameStatusDropDownButton"
                        wowParent: "FriendsFrameStatusDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }
                }

                Frame {
                    name: "FriendsFrameStatusDropDownMouseOver"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    width: 22
                    height: 23
                }
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

                FontString {
                    name: "FriendsTabHeaderTab1Text"
                    text: "Friends"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 48.2
                    height: 13
                }
            }

            Button {
                name: "FriendsTabHeaderTab2"
                text: "Ignore"
                wowParent: "FriendsTabHeader"
                style: "Tab"
                anchors.left: friendsTabHeaderTab1.right
                anchors.verticalCenter: friendsTabHeaderTab1.verticalCenter
                width: 65.4
                height: 32

                FontString {
                    name: "FriendsTabHeaderTab2Text"
                    text: "Ignore"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 43.5
                    height: 13
                }
            }

            CheckButton {
                name: "GuildFrameLFGButton"
                wowParent: "GuildFrameLFGFrame"
                style: "CheckBox"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 20
                height: 20

                FontString {
                    name: "GuildFrameLFGButtonText"
                    text: "Show Offline Members"
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 129.6
                    height: 14.2
                }
            }

            Button {
                name: "RaidFrameConvertToRaidButton"
                text: "Convert To Raid"
                wowParent: "RaidFrame"
                style: "Button"
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 115
                height: 21

                FontString {
                    name: "RaidFrameConvertToRaidButtonText"
                    text: "Convert To Raid"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 86.9
                    height: 10.3
                }
            }

            Button {
                name: "RaidFrameRaidInfoButton"
                text: "Raid Info"
                wowParent: "RaidFrame"
                style: "Button"
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 21

                FontString {
                    name: "RaidFrameRaidInfoButtonText"
                    text: "Raid Info"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 50.6
                    height: 10.3
                }
            }

            Frame {
                id: whoFrameDropDown
                name: "WhoFrameDropDown"
                wowParent: "WhoFrameColumnHeader2"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.verticalCenter: parent.verticalCenter
                width: 114
                height: 32

                Frame {
                    name: "WhoFrameDropDownDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 114
                    height: 22

                    Button {
                        name: "WhoFrameDropDownButton"
                        wowParent: "WhoFrameDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }
                }

                FontString {
                    name: "WhoFrameDropDownText"
                    text: "Zone"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -11
                    anchors.verticalCenter: parent.verticalCenter
                    width: 39
                    height: 10
                }
            }

            EditBox {
                name: "WhoFrameEditBox"
                wowParent: "WhoFrame"
                style: "EditBox"
                anchors.left: whoFrameDropDown.right
                anchors.leftMargin: 4
                anchors.verticalCenter: whoFrameDropDown.verticalCenter
                width: 200
                height: 20

                Frame {
                    name: "WhoFrameEditBoxDiabolicField"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 216
                    height: 22
                }
            }
        }

        Frame {
            name: "FriendsFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 400
            height: 498

            Frame {
                name: "FriendsFrameDiabolicTitlePlate"
                wowParent: "FriendsFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "FriendsFrameTitleText"
                    text: "Raid"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 38.7
                    height: 14.2
                }
            }
        }

        Frame {
            name: "FriendsFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 354
            height: 35

            Button {
                name: "ChannelFrameNewButton"
                text: "Add"
                wowParent: "ChannelFrame"
                style: "Button"
                pin: "place"
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 9
                width: 80
                height: 22

                FontString {
                    name: "ChannelFrameNewButtonText"
                    text: "Add"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 21.3
                    height: 10.3
                }
            }

            Button {
                name: "FriendsFrameIgnorePlayerButton"
                text: "Ignore Player"
                wowParent: "IgnoreListFrame"
                style: "Button"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                width: 131
                height: 21

                FontString {
                    name: "FriendsFrameIgnorePlayerButtonText"
                    text: "Ignore Player"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 75.1
                    height: 10.3
                }
            }

            Button {
                name: "FriendsFrameUnsquelchButton"
                text: "Remove Player"
                wowParent: "IgnoreListFrame"
                style: "Button"
                pin: "place"
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                width: 134
                height: 21

                FontString {
                    name: "FriendsFrameUnsquelchButtonText"
                    text: "Remove Player"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 81.4
                    height: 10.3
                }
            }

            // kept as they are, at the foot's ends
            WowRow {
                name: "FriendsButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8

                Button {
                    name: "FriendsFrameAddFriendButton"
                    text: "Add Friend"
                    wowParent: "FriendsListFrame"
                    style: "Button"
                    pin: "place"
                    width: 131
                    height: 21

                    FontString {
                        name: "FriendsFrameAddFriendButtonText"
                        text: "Add Friend"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 59.3
                        height: 10.3
                    }
                }

                Button {
                    name: "FriendsFrameSendMessageButton"
                    text: "Send Message"
                    wowParent: "FriendsListFrame"
                    style: "Button"
                    pin: "place"
                    width: 131
                    height: 21

                    FontString {
                        name: "FriendsFrameSendMessageButtonText"
                        text: "Send Message"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 78.2
                        height: 10.3
                    }
                }
            }

            WowRow {
                name: "WhoButtons"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "WhoFrameWhoButton"
                    text: "Refresh"
                    wowParent: "WhoFrame"
                    style: "Button"
                    pin: "all"
                    width: 89.4
                    height: 22

                    FontString {
                        name: "WhoFrameWhoButtonText"
                        text: "Refresh"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 41.9
                        height: 10.3
                    }
                }

                Button {
                    name: "WhoFrameAddFriendButton"
                    text: "Add Friend"
                    wowParent: "WhoFrame"
                    style: "Button"
                    pin: "all"
                    width: 106.8
                    height: 22

                    FontString {
                        name: "WhoFrameAddFriendButtonText"
                        text: "Add Friend"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 59.3
                        height: 10.3
                    }
                }

                Button {
                    name: "WhoFrameGroupInviteButton"
                    text: "Group Invite"
                    wowParent: "WhoFrame"
                    style: "Button"
                    pin: "all"
                    width: 117.8
                    height: 22

                    FontString {
                        name: "WhoFrameGroupInviteButtonText"
                        text: "Group Invite"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 70.3
                        height: 10.3
                    }
                }
            }

            WowRow {
                name: "GuildButtons"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "GuildFrameGuildInformationButton"
                    text: "Guild Information"
                    wowParent: "GuildFrame"
                    style: "Button"
                    pin: "all"
                    width: 122.9
                    height: 22

                    FontString {
                        name: "GuildFrameGuildInformationButtonText"
                        text: "Guild Information"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 98.8
                        height: 10.3
                    }
                }

                Button {
                    name: "GuildFrameAddMemberButton"
                    text: "Add Member"
                    wowParent: "GuildFrame"
                    style: "Button"
                    pin: "all"
                    width: 94.4
                    height: 22

                    FontString {
                        name: "GuildFrameAddMemberButtonText"
                        text: "Add Member"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 70.3
                        height: 10.3
                    }
                }

                Button {
                    name: "GuildFrameControlButton"
                    text: "Guild Control"
                    wowParent: "GuildFrame"
                    style: "Button"
                    pin: "all"
                    width: 96.7
                    height: 22

                    FontString {
                        name: "GuildFrameControlButtonText"
                        text: "Guild Control"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 72.7
                        height: 10.3
                    }
                }
            }
        }

        Frame {
            name: "FriendsFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 304
            height: 18
        }

        Frame {
            name: "FriendsFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }
    }

    ScrollFrame {
        name: "FriendsFrameFriendsScrollFrame"
        wowParent: "FriendsListFrame"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 36
        width: 302
        height: 340

        Frame {
            name: "FriendsFrameFriendsScrollFrameDiabolicZone"
            wowParent: "FriendsListFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -2
            width: 336
            height: 352
        }

        Slider {
            name: "FriendsFrameFriendsScrollFrameScrollBar"
            style: "ScrollBar"
            pin: "place"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            width: 16
            height: 310

            Frame {
                name: "FriendsFrameFriendsScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: friendsFrameFriendsScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: friendsFrameFriendsScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 344
            }

            Button {
                name: "FriendsFrameFriendsScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: friendsFrameFriendsScrollFrameScrollBarScrollUpButton
                name: "FriendsFrameFriendsScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "FriendsFrameFriendsScrollFrameScrollChild"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 10
            height: 10

            Button {
                name: "FriendsFrameFriendsScrollFrameButton1"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 298
                height: 34

                FontString {
                    name: "FriendsFrameFriendsScrollFrameButton1Info"
                    text: "Orgrimmar"
                    anchors.left: friendsFrameFriendsScrollFrameButton1Name.left
                    anchors.top: friendsFrameFriendsScrollFrameButton1Name.bottom
                    anchors.topMargin: 2
                    width: 260
                    height: 10
                }

                FontString {
                    id: friendsFrameFriendsScrollFrameButton1Name
                    name: "FriendsFrameFriendsScrollFrameButton1Name"
                    text: "Enby, Level 80 Rogue"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 248
                    height: 12
                }
            }
        }
    }

    Button {
        name: "FriendsFrameIgnoreButton1"
        wowParent: "IgnoreListFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 39
        width: 298
        height: 16

        FontString {
            name: "FriendsFrameIgnoreButton1Name"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 288
            height: 12
        }

        Frame {
            name: "FriendsFrameIgnoredHeader"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 302
            height: 16

            FontString {
                name: "FriendsFrameIgnoredHeaderTitle"
                text: "Ignored"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 47.4
                height: 11.9
            }
        }
    }

    ScrollFrame {
        name: "FriendsFrameIgnoreScrollFrame"
        wowParent: "IgnoreListFrame"
        pin: "all"
        anchors.right: parent.right
        anchors.rightMargin: 65
        anchors.top: parent.top
        anchors.topMargin: 36
        width: 298
        height: 340

        Frame {
            name: "FriendsFrameIgnoreScrollFrameDiabolicZone"
            wowParent: "IgnoreListFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -2
            width: 332
            height: 344
        }
    }

    Button {
        name: "FriendsFrameTab1"
        text: "Friends"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "FriendsFrameTab2"
        text: "Who"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "FriendsFrameTab3"
        text: "Guild"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "FriendsFrameTab4"
        text: "Chat"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "FriendsFrameTab5"
        text: "Raid"
        style: "Banner"
        anchors.left: friendsFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: friendsFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        name: "FriendsListFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "FriendsTabHeader"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "GuildEventLogFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 395
        height: 435

        Frame {
            name: "GuildEventFrame"
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.top: parent.top
            anchors.topMargin: 42
            width: 375
            height: 360

            ScrollFrame {
                name: "GuildEventLogScrollFrame"
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.top: parent.top
                anchors.topMargin: 6
                width: 325
                height: 349

                Frame {
                    name: "GuildEventLogScrollChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 325
                    height: 359

                    FontString {
                        name: "GuildEventMessage"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 325
                        height: 1635.6
                    }
                }

                Slider {
                    name: "GuildEventLogScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.left: parent.right
                    anchors.leftMargin: 6
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    width: 16
                    height: 317

                    Frame {
                        name: "GuildEventLogScrollFrameScrollBarDiabolicTrack"
                        anchors.horizontalCenter: guildEventLogScrollFrameScrollBarScrollUpButton.horizontalCenter
                        anchors.top: guildEventLogScrollFrameScrollBarScrollUpButton.top
                        anchors.topMargin: -1
                        width: 18
                        height: 351
                    }

                    Button {
                        name: "GuildEventLogScrollFrameScrollBarScrollDownButton"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        width: 16
                        height: 16
                    }

                    Button {
                        id: guildEventLogScrollFrameScrollBarScrollUpButton
                        name: "GuildEventLogScrollFrameScrollBarScrollUpButton"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        width: 16
                        height: 16
                    }
                }
            }
        }

        Button {
            name: "GuildEventLogCancelButton"
            text: "Close"
            style: "Button"
            anchors.right: parent.right
            anchors.rightMargin: 9
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 13
            width: 139
            height: 22

            FontString {
                name: "GuildEventLogCancelButtonText"
                text: "Close"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: 10.3
            }
        }

        Button {
            name: "GuildEventLogCloseButton"
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 22
            height: 22
        }

        FontString {
            name: "GuildEventLogTitle"
            text: "Log"
            anchors.left: parent.left
            anchors.leftMargin: 17
            anchors.top: parent.top
            anchors.topMargin: 17
            width: 24.5
            height: 11.9
        }
    }

    Frame {
        name: "GuildFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            id: guildFrameButton1
            name: "GuildFrameButton1"
            wowParent: "GuildPlayerStatusFrame"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 70
            width: 298
            height: 16

            FontString {
                id: guildFrameButton1Class
                name: "GuildFrameButton1Class"
                text: "Death Knight"
                anchors.left: guildFrameButton1Level.right
                anchors.leftMargin: 12
                anchors.verticalCenter: guildFrameButton1Level.verticalCenter
                width: 80
                height: 14
            }

            FontString {
                name: "GuildFrameButton1Group"
                anchors.left: guildFrameButton1Class.right
                anchors.verticalCenter: guildFrameButton1Class.verticalCenter
                width: 40
                height: 14
            }

            FontString {
                id: guildFrameButton1Level
                name: "GuildFrameButton1Level"
                text: "80"
                anchors.left: guildFrameButton1Zone.right
                anchors.leftMargin: 4
                anchors.verticalCenter: guildFrameButton1Zone.verticalCenter
                width: 20
                height: 14
            }

            FontString {
                id: guildFrameButton1Name
                name: "GuildFrameButton1Name"
                text: "Chiftea"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 78
                height: 14
            }

            FontString {
                id: guildFrameButton1Zone
                name: "GuildFrameButton1Zone"
                text: "Icecrown"
                anchors.left: guildFrameButton1Name.right
                anchors.leftMargin: 3
                anchors.verticalCenter: guildFrameButton1Name.verticalCenter
                width: 110
                height: 14
            }
        }

        Button {
            name: "GuildFrameGuildListToggleButton"
            text: "Player Status"
            anchors.left: parent.left
            anchors.leftMargin: 307
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 34
            width: 32
            height: 32
        }

        Button {
            name: "GuildFrameGuildStatusButton1"
            wowParent: "GuildStatusFrame"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 70
            width: 298
            height: 16

            FontString {
                id: guildFrameGuildStatusButton1Name
                name: "GuildFrameGuildStatusButton1Name"
                text: "Padirac"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 75
                height: 14
            }

            FontString {
                id: guildFrameGuildStatusButton1Note
                name: "GuildFrameGuildStatusButton1Note"
                anchors.left: guildFrameGuildStatusButton1Rank.right
                anchors.leftMargin: 11
                anchors.verticalCenter: guildFrameGuildStatusButton1Rank.verticalCenter
                width: 85
                height: 14
            }

            FontString {
                name: "GuildFrameGuildStatusButton1Online"
                text: "Online"
                anchors.left: guildFrameGuildStatusButton1Note.right
                anchors.leftMargin: 10
                anchors.verticalCenter: guildFrameGuildStatusButton1Note.verticalCenter
                width: 80
                height: 14
            }

            FontString {
                id: guildFrameGuildStatusButton1Rank
                name: "GuildFrameGuildStatusButton1Rank"
                text: "Senior Member"
                anchors.left: guildFrameGuildStatusButton1Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: guildFrameGuildStatusButton1Name.verticalCenter
                width: 55
                height: 14
            }
        }

        Button {
            name: "GuildFrameGuildStatusButton2"
            wowParent: "GuildStatusFrame"
            anchors.left: guildFrameButton1.left
            anchors.top: guildFrameButton1.bottom
            width: 298
            height: 16

            FontString {
                id: guildFrameGuildStatusButton2Name
                name: "GuildFrameGuildStatusButton2Name"
                text: "Discordignis"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 75
                height: 14
            }

            FontString {
                id: guildFrameGuildStatusButton2Note
                name: "GuildFrameGuildStatusButton2Note"
                text: "Discord Chat Bot"
                anchors.left: guildFrameGuildStatusButton2Rank.right
                anchors.leftMargin: 11
                anchors.verticalCenter: guildFrameGuildStatusButton2Rank.verticalCenter
                width: 85
                height: 14
            }

            FontString {
                name: "GuildFrameGuildStatusButton2Online"
                text: "Online"
                anchors.left: guildFrameGuildStatusButton2Note.right
                anchors.leftMargin: 10
                anchors.verticalCenter: guildFrameGuildStatusButton2Note.verticalCenter
                width: 80
                height: 14
            }

            FontString {
                id: guildFrameGuildStatusButton2Rank
                name: "GuildFrameGuildStatusButton2Rank"
                text: "Guild Master"
                anchors.left: guildFrameGuildStatusButton2Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: guildFrameGuildStatusButton2Name.verticalCenter
                width: 55
                height: 14
            }
        }

        Frame {
            name: "GuildFrameLFGFrame"
            anchors.right: parent.right
            anchors.rightMargin: 42
            anchors.top: parent.top
            anchors.topMargin: 13
            width: 210
            height: 23
        }

        FontString {
            id: guildFrameNotesLabel
            name: "GuildFrameNotesLabel"
            text: "Guild Message Of The Day:"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.top: parent.top
            anchors.topMargin: 319
            width: 225
            height: 11
        }

        FontString {
            name: "GuildFrameNotesText"
            text: "https://discord.gg/Xkh2Q6kW4m - WE NEED MORE PET PICTURES "
            anchors.left: guildFrameNotesLabel.left
            anchors.top: guildFrameNotesLabel.bottom
            anchors.topMargin: 3
            width: 315
            height: 36

            Button {
                name: "GuildMOTDEditButton"
                wowParent: "GuildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 315
                height: 36
            }
        }

        FontString {
            name: "GuildFrameOnlineTotals"
            anchors.left: guildFrameTotals.right
            anchors.leftMargin: 3
            anchors.verticalCenter: guildFrameTotals.verticalCenter
            width: 53.7
            height: 16
        }

        FontString {
            id: guildFrameTotals
            name: "GuildFrameTotals"
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 75
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: -42
            width: 92.4
            height: 16
        }

        Frame {
            name: "GuildPlayerStatusFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -25
            width: 300
            height: 200

            Button {
                id: guildFrameColumnHeader1
                name: "GuildFrameColumnHeader1"
                text: "Name"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 70
                width: 83
                height: 22
            }

            Button {
                id: guildFrameColumnHeader2
                name: "GuildFrameColumnHeader2"
                text: "Zone"
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
                anchors.left: guildFrameColumnHeader2.right
                anchors.leftMargin: -2
                anchors.verticalCenter: guildFrameColumnHeader2.verticalCenter
                width: 32
                height: 22
            }

            Button {
                name: "GuildFrameColumnHeader4"
                text: "Class"
                anchors.left: guildFrameColumnHeader3.right
                anchors.leftMargin: -2
                anchors.verticalCenter: guildFrameColumnHeader3.verticalCenter
                width: 92
                height: 22
            }
        }

        Frame {
            name: "GuildStatusFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -25
            width: 300
            height: 200

            Button {
                id: guildFrameGuildStatusColumnHeader1
                name: "GuildFrameGuildStatusColumnHeader1"
                text: "Name"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 70
                width: 83
                height: 22
            }

            Button {
                id: guildFrameGuildStatusColumnHeader2
                name: "GuildFrameGuildStatusColumnHeader2"
                text: "Rank"
                anchors.left: guildFrameGuildStatusColumnHeader1.right
                anchors.leftMargin: -2
                anchors.verticalCenter: guildFrameGuildStatusColumnHeader1.verticalCenter
                width: 75
                height: 22
            }

            Button {
                id: guildFrameGuildStatusColumnHeader3
                name: "GuildFrameGuildStatusColumnHeader3"
                text: "Note"
                anchors.left: guildFrameGuildStatusColumnHeader2.right
                anchors.leftMargin: -2
                anchors.verticalCenter: guildFrameGuildStatusColumnHeader2.verticalCenter
                width: 90
                height: 22
            }

            Button {
                name: "GuildFrameGuildStatusColumnHeader4"
                text: "Last Online"
                anchors.left: guildFrameGuildStatusColumnHeader3.right
                anchors.leftMargin: -2
                anchors.verticalCenter: guildFrameGuildStatusColumnHeader3.verticalCenter
                width: 75
                height: 22
            }
        }

        Ghost {
            name: "GuildListScrollFrame"
            x: 21
            y: 73
            width: 0
            height: 0

            Frame {
                name: "GuildListScrollFrameDiabolicZone"
                wowParent: "GuildFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 330
                height: 240

                Frame {
                    name: "GuildListScrollFrameDiabolicZoneColumnBar"
                    anchors.left: parent.left
                    anchors.bottom: parent.top
                    width: 330
                    height: 22
                }
            }
        }
    }

    Frame {
        name: "GuildInfoFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 297
        height: 298

        Button {
            name: "GuildInfoCancelButton"
            text: "Close"
            style: "Button"
            anchors.right: parent.right
            anchors.rightMargin: 9
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            width: 87
            height: 22

            FontString {
                name: "GuildInfoCancelButtonText"
                text: "Close"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: 10.3
            }
        }

        Button {
            name: "GuildInfoCloseButton"
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 22
            height: 22
        }

        Button {
            name: "GuildInfoGuildEventButton"
            text: "Log"
            style: "Button"
            anchors.right: guildInfoSaveButton.left
            anchors.rightMargin: 32
            anchors.verticalCenter: guildInfoSaveButton.verticalCenter
            width: 65
            height: 22

            FontString {
                name: "GuildInfoGuildEventButtonText"
                text: "Log"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 20.5
                height: 10.3
            }
        }

        Button {
            id: guildInfoSaveButton
            name: "GuildInfoSaveButton"
            text: "Accept"
            style: "Button"
            anchors.right: parent.right
            anchors.rightMargin: 102
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            width: 87
            height: 22

            FontString {
                name: "GuildInfoSaveButtonText"
                text: "Accept"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 37.1
                height: 10.3
            }
        }

        Frame {
            name: "GuildInfoTextBackground"
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.top: parent.top
            anchors.topMargin: 42
            width: 276
            height: 220

            ScrollFrame {
                name: "GuildInfoFrameScrollFrame"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 7
                width: 243
                height: 208

                EditBox {
                    name: "GuildInfoEditBox"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 240
                    height: 118.5
                }

                Slider {
                    name: "GuildInfoFrameScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.left: parent.right
                    anchors.leftMargin: 6
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    width: 16
                    height: 176

                    Frame {
                        name: "GuildInfoFrameScrollFrameScrollBarDiabolicTrack"
                        anchors.horizontalCenter: guildInfoFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
                        anchors.top: guildInfoFrameScrollFrameScrollBarScrollUpButton.top
                        anchors.topMargin: -1
                        width: 18
                        height: 210
                    }

                    Button {
                        name: "GuildInfoFrameScrollFrameScrollBarScrollDownButton"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        width: 16
                        height: 16
                    }

                    Button {
                        id: guildInfoFrameScrollFrameScrollBarScrollUpButton
                        name: "GuildInfoFrameScrollFrameScrollBarScrollUpButton"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        width: 16
                        height: 16
                    }
                }
            }
        }

        FontString {
            name: "GuildInfoTitle"
            text: "Guild Information"
            anchors.left: parent.left
            anchors.leftMargin: 17
            anchors.top: parent.top
            anchors.topMargin: 17
            width: 105.1
            height: 11.9
        }
    }

    Frame {
        name: "GuildMemberDetailFrame"
        pin: "place"
        anchors.left: friendsFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: friendsFrameDiabolic.top
        anchors.topMargin: 96
        width: 212
        height: 195

        Button {
            name: "GuildMemberDetailCloseButton"
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 22
            height: 22
        }

        FontString {
            id: guildMemberDetailLevel
            name: "GuildMemberDetailLevel"
            text: "Level 1 Paladin"
            anchors.left: guildMemberDetailName.left
            anchors.top: guildMemberDetailName.bottom
            anchors.topMargin: 2
            width: 82.2
            height: 10.3
        }

        FontString {
            id: guildMemberDetailName
            name: "GuildMemberDetailName"
            text: "Discordignis"
            anchors.left: parent.left
            anchors.leftMargin: 17
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 74.3
            height: 12
        }

        FontString {
            id: guildMemberDetailNoteLabel
            name: "GuildMemberDetailNoteLabel"
            text: "Note:"
            anchors.left: guildMemberDetailOnlineLabel.left
            anchors.top: guildMemberDetailOnlineLabel.bottom
            anchors.topMargin: 8
            width: 30
            height: 10.3
        }

        FontString {
            id: guildMemberDetailOnlineLabel
            name: "GuildMemberDetailOnlineLabel"
            text: "Last Online:"
            anchors.left: guildMemberDetailRankLabel.left
            anchors.top: guildMemberDetailRankLabel.bottom
            anchors.topMargin: 8
            width: 64
            height: 10.3
        }

        FontString {
            name: "GuildMemberDetailOnlineText"
            text: "Online"
            anchors.left: guildMemberDetailOnlineLabel.right
            anchors.leftMargin: 2
            anchors.verticalCenter: guildMemberDetailOnlineLabel.verticalCenter
            width: 39.5
            height: 11.9
        }

        FontString {
            id: guildMemberDetailRankLabel
            name: "GuildMemberDetailRankLabel"
            text: "Rank:"
            anchors.left: guildMemberDetailZoneLabel.left
            anchors.top: guildMemberDetailZoneLabel.bottom
            anchors.topMargin: 8
            width: 29.2
            height: 10.3
        }

        FontString {
            name: "GuildMemberDetailRankText"
            text: "Guild Master"
            anchors.left: guildMemberDetailRankLabel.right
            anchors.leftMargin: 2
            anchors.verticalCenter: guildMemberDetailRankLabel.verticalCenter
            width: 103.8
            height: 11.9
        }

        FontString {
            id: guildMemberDetailZoneLabel
            name: "GuildMemberDetailZoneLabel"
            text: "Zone:"
            anchors.left: guildMemberDetailLevel.left
            anchors.top: guildMemberDetailLevel.bottom
            anchors.topMargin: 11
            width: 30.8
            height: 10.3
        }

        FontString {
            name: "GuildMemberDetailZoneText"
            text: "Azuremyst Isle"
            anchors.left: guildMemberDetailZoneLabel.right
            anchors.leftMargin: 2
            anchors.verticalCenter: guildMemberDetailZoneLabel.verticalCenter
            width: 147
            height: 12
        }

        Button {
            name: "GuildMemberGroupInviteButton"
            text: "Group Invite"
            style: "Button"
            anchors.right: parent.right
            anchors.rightMargin: 9
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            width: 93.5
            height: 22

            FontString {
                name: "GuildMemberGroupInviteButtonText"
                text: "Group Invite"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 70.3
                height: 10.3
            }
        }

        Frame {
            name: "GuildMemberNoteBackground"
            anchors.left: guildMemberDetailNoteLabel.left
            anchors.leftMargin: -2
            anchors.top: guildMemberDetailNoteLabel.bottom
            width: 181
            height: 40

            FontString {
                name: "PersonalNoteText"
                text: "Discord Chat Bot"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 1
                anchors.top: parent.top
                anchors.topMargin: 6
                width: 165
                height: 32
            }
        }

        Button {
            name: "GuildMemberRemoveButton"
            text: "Remove"
            style: "Button"
            anchors.right: parent.right
            anchors.rightMargin: 108.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            width: 93.5
            height: 22

            FontString {
                name: "GuildMemberRemoveButtonText"
                text: "Remove"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 44.2
                height: 10.3
            }
        }
    }

    Frame {
        name: "IgnoreListFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "RaidFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Frame {
            name: "RaidFrameNotInRaid"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 384
            height: 512

            Button {
                name: "RaidFrameNotInRaidRaidBrowserButton"
                text: "Open Raid Browser"
                style: "Button"
                anchors.horizontalCenter: raidFrameRaidBrowserDescription.horizontalCenter
                anchors.top: raidFrameRaidBrowserDescription.bottom
                anchors.topMargin: 10
                width: 260
                height: 22

                FontString {
                    name: "RaidFrameNotInRaidRaidBrowserButtonText"
                    text: "Open Raid Browser"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 105.1
                    height: 10.3
                }
            }

            FontString {
                id: raidFrameRaidBrowserDescription
                name: "RaidFrameRaidBrowserDescription"
                text: "Find a Raid Group or Assemble a Raid"
                anchors.horizontalCenter: raidFrameRaidDescription.horizontalCenter
                anchors.top: raidFrameRaidDescription.bottom
                anchors.topMargin: 50
                width: 300
                height: 11.9
            }

            FontString {
                id: raidFrameRaidDescription
                name: "RaidFrameRaidDescription"
                anchors.left: parent.left
                anchors.leftMargin: 29
                anchors.top: parent.top
                anchors.topMargin: 85
                width: 300
                height: 165.9
            }
        }
    }

    Frame {
        name: "WhoFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "WhoFrameButton1"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 61
            width: 298
            height: 16

            FontString {
                name: "WhoFrameButton1Class"
                text: "Paladin"
                anchors.left: whoFrameButton1Level.right
                anchors.leftMargin: 12
                anchors.verticalCenter: whoFrameButton1Level.verticalCenter
                width: 80
                height: 8
            }

            FontString {
                id: whoFrameButton1Level
                name: "WhoFrameButton1Level"
                text: "37"
                anchors.left: whoFrameButton1Variable.right
                anchors.leftMargin: 2
                anchors.verticalCenter: whoFrameButton1Variable.verticalCenter
                width: 20
                height: 14
            }

            FontString {
                id: whoFrameButton1Name
                name: "WhoFrameButton1Name"
                text: "Ches"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 88
                height: 14
            }

            FontString {
                id: whoFrameButton1Variable
                name: "WhoFrameButton1Variable"
                text: "Alterac Mountains"
                anchors.left: whoFrameButton1Name.right
                anchors.verticalCenter: whoFrameButton1Name.verticalCenter
                width: 95
                height: 14
            }
        }

        Button {
            id: whoFrameColumnHeader1
            name: "WhoFrameColumnHeader1"
            text: "Name"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 34
            width: 83
            height: 22
        }

        Button {
            id: whoFrameColumnHeader2
            name: "WhoFrameColumnHeader2"
            text: "Zone"
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
            anchors.left: whoFrameColumnHeader2.right
            anchors.leftMargin: -2
            anchors.verticalCenter: whoFrameColumnHeader2.verticalCenter
            width: 32
            height: 22
        }

        Button {
            name: "WhoFrameColumnHeader4"
            text: "Class"
            anchors.left: whoFrameColumnHeader3.right
            anchors.leftMargin: -2
            anchors.verticalCenter: whoFrameColumnHeader3.verticalCenter
            width: 92
            height: 22
        }

        FontString {
            name: "WhoFrameTotals"
            text: "0 People Found  "
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 127
            width: 298
            height: 16
        }
    }

    ScrollFrame {
        name: "WhoListScrollFrame"
        wowParent: "WhoFrame"
        pin: "place"
        anchors.right: parent.right
        anchors.rightMargin: 67
        anchors.top: parent.top
        anchors.topMargin: 62
        width: 296
        height: 298

        Frame {
            name: "WhoListScrollFrameDiabolicZone"
            wowParent: "WhoFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 330
            height: 330

            Frame {
                name: "WhoListScrollFrameDiabolicZoneColumnBar"
                anchors.left: parent.left
                anchors.bottom: parent.top
                width: 330
                height: 22
            }
        }

        Slider {
            name: "WhoListScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 266

            Frame {
                name: "WhoListScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: whoListScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: whoListScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 300
            }

            Button {
                name: "WhoListScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: whoListScrollFrameScrollBarScrollUpButton
                name: "WhoListScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "WhoListScrollFrameScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 784
        }
    }

    Ghost {
        name: "ChannelButton2"
        x: 20
        y: 96
        width: 155
        height: 20

        FontString {
            name: "ChannelButton2Collapsed"
            text: "-"
            wowParent: "ChannelButton2"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            width: 7.9
            height: 15.8
        }
    }

    Ghost {
        name: "ChannelButton6"
        x: 20
        y: 176
        width: 155
        height: 20

        FontString {
            name: "ChannelButton6Collapsed"
            text: "-"
            wowParent: "ChannelButton6"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            width: 7.9
            height: 15.8
        }
    }

    Ghost {
        name: "ChannelButton7"
        x: 20
        y: 196
        width: 155
        height: 20

        FontString {
            name: "ChannelButton7Collapsed"
            text: "-"
            wowParent: "ChannelButton7"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            width: 7.9
            height: 15.8
        }
    }

    Ghost {
        name: "FriendsFrameFriendsScrollFrameButton3"
        x: 21
        y: 86
        width: 298
        height: 34

        Frame {
            name: "FriendsTooltip"
            wowParent: "FriendsFrame"
            anchors.left: parent.right
            anchors.leftMargin: 36
            anchors.top: parent.top
            width: 64
            height: 35.8

            FontString {
                id: friendsTooltipHeader
                name: "FriendsTooltipHeader"
                text: "Annah"
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.top: parent.top
                anchors.topMargin: 12
                width: 152.9
                height: 10.3
            }

            FontString {
                name: "FriendsTooltipNoteText"
                text: "THE ONLY ONE"
                anchors.horizontalCenter: friendsTooltipHeader.horizontalCenter
                anchors.horizontalCenterOffset: 7.8
                anchors.top: friendsTooltipHeader.bottom
                anchors.topMargin: 126.9
                width: 137.3
                height: 8.7
            }

            FontString {
                name: "FriendsTooltipToon1Info"
                text: "Dalaran"
                anchors.horizontalCenter: friendsTooltipToon1Name.horizontalCenter
                anchors.horizontalCenterOffset: 3.5
                anchors.top: friendsTooltipToon1Name.bottom
                anchors.topMargin: 3.5
                width: 146
                height: 8.7
            }

            FontString {
                id: friendsTooltipToon1Name
                name: "FriendsTooltipToon1Name"
                text: "Level 80 Rogue"
                anchors.horizontalCenter: friendsTooltipHeader.horizontalCenter
                anchors.top: friendsTooltipHeader.bottom
                anchors.topMargin: -46.6
                width: 152.9
                height: 8.7
            }
        }
    }
}
