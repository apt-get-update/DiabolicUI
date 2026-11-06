// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "FriendsFrame"
    width: 384
    height: 512

    Frame {
        name: "ChannelFrame"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 355
        height: 512

        Button {
            name: "ChannelFrameNewButton"
            text: "Add"
            wowParent: "ChannelFrame"
            style: "Button"
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 82
            width: 80
            height: 22

            FontString {
                name: "ChannelFrameNewButtonText"
                text: "Add"
                wowParent: "ChannelFrameNewButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 21.3
                height: 10.3
            }
        }

        Frame {
            name: "ChannelFrameVerticalBar"
            wowParent: "ChannelFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -35
            width: 13
            height: 300
        }

        ScrollFrame {
            name: "ChannelListScrollFrame"
            wowParent: "ChannelFrame"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 76
            width: 158
            height: 327

            Frame {
                name: "ChannelListScrollChildFrame"
                wowParent: "ChannelListScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 145
                height: -1780

                Button {
                    name: "ChannelButton1"
                    wowParent: "ChannelListScrollChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 155
                    height: 20

                    FontString {
                        name: "ChannelButton1Text"
                        wowParent: "ChannelButton1"
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
            wowParent: "ChannelFrame"
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 121
            anchors.top: parent.top
            anchors.topMargin: 79
            width: 158
            height: 327

            FontString {
                name: "ChannelRosterChannelName"
                wowParent: "ChannelRoster"
                anchors.left: parent.left
                anchors.leftMargin: -115
                anchors.top: parent.top
                anchors.topMargin: -20
                width: 1
                height: 1

                FontString {
                    name: "ChannelRosterChannelCount"
                    wowParent: "ChannelRoster"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 13
                }
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
                wowParent: "ChannelRosterScrollFrame"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 295

                Button {
                    name: "ChannelRosterScrollFrameScrollBarScrollDownButton"
                    wowParent: "ChannelRosterScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "ChannelRosterScrollFrameScrollBarScrollUpButton"
                    wowParent: "ChannelRosterScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "ChannelRosterScrollFrameScrollBarDiabolicTrack"
                        wowParent: "ChannelRosterScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 329
                    }
                }
            }

            Frame {
                name: "ChannelRosterScrollFrameScrollChildFrame"
                wowParent: "ChannelRosterScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 1245
            }
        }
    }

    Frame {
        name: "FriendsFrameDiabolic"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.leftMargin: -20
        anchors.top: parent.top
        anchors.topMargin: -68
        width: 400
        height: 540

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
            wowParent: "FriendsFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 352
            height: 40

            Frame {
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
                    wowParent: "FriendsFrameStatusDropDown"
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
                    wowParent: "FriendsFrameStatusDropDown"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    width: 22
                    height: 23
                }

                Button {
                    name: "FriendsTabHeaderTab1"
                    text: "Friends"
                    wowParent: "FriendsTabHeader"
                    style: "Tab"
                    anchors.left: parent.right
                    anchors.leftMargin: -4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 69
                    height: 32

                    FontString {
                        name: "FriendsTabHeaderTab1Text"
                        text: "Friends"
                        wowParent: "FriendsTabHeaderTab1"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 48.2
                        height: 13
                    }

                    Button {
                        name: "FriendsTabHeaderTab2"
                        text: "Ignore"
                        wowParent: "FriendsTabHeader"
                        style: "Tab"
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 65.4
                        height: 32

                        FontString {
                            name: "FriendsTabHeaderTab2Text"
                            text: "Ignore"
                            wowParent: "FriendsTabHeaderTab2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -1
                            width: 43.5
                            height: 13
                        }
                    }
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
                    wowParent: "GuildFrameLFGButton"
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
                    wowParent: "RaidFrameConvertToRaidButton"
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
                    wowParent: "RaidFrameRaidInfoButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 50.6
                    height: 10.3
                }
            }

            Frame {
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
                    wowParent: "WhoFrameDropDown"
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
                    wowParent: "WhoFrameDropDown"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -11
                    anchors.verticalCenter: parent.verticalCenter
                    width: 39
                    height: 10
                }

                EditBox {
                    name: "WhoFrameEditBox"
                    wowParent: "WhoFrame"
                    style: "EditBox"
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 200
                    height: 20

                    Frame {
                        name: "WhoFrameEditBoxDiabolicField"
                        wowParent: "WhoFrameEditBox"
                        anchors.left: parent.left
                        anchors.leftMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 216
                        height: 22
                    }
                }
            }
        }

        Frame {
            name: "FriendsFrameDiabolicBorder"
            wowParent: "FriendsFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 400
            height: 508

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
                    wowParent: "FriendsFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 38.7
                    height: 14.2
                }
            }
        }

        Frame {
            name: "FriendsFrameDiabolicRail"
            wowParent: "FriendsFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 304
            height: 18
        }

        Frame {
            name: "FriendsFrameDiabolicSocket"
            wowParent: "FriendsFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "FriendsFrameIgnorePlayerButton"
            text: "Ignore Player"
            wowParent: "IgnoreListFrame"
            style: "Button"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 31
            width: 131
            height: 21

            FontString {
                name: "FriendsFrameIgnorePlayerButtonText"
                text: "Ignore Player"
                wowParent: "FriendsFrameIgnorePlayerButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 75.1
                height: 10.3
            }
        }

        Button {
            name: "FriendsFrameTab1"
            text: "Friends"
            wowParent: "FriendsFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "FriendsFrameTab2"
            text: "Who"
            wowParent: "FriendsFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "FriendsFrameTab3"
            text: "Guild"
            wowParent: "FriendsFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 144
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "FriendsFrameTab4"
            text: "Chat"
            wowParent: "FriendsFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 202
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "FriendsFrameTab5"
            text: "Raid"
            wowParent: "FriendsFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 260
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "FriendsFrameUnsquelchButton"
            text: "Remove Player"
            wowParent: "IgnoreListFrame"
            style: "Button"
            pin: "place"
            anchors.right: parent.right
            anchors.rightMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 31
            width: 134
            height: 21

            FontString {
                name: "FriendsFrameUnsquelchButtonText"
                text: "Remove Player"
                wowParent: "FriendsFrameUnsquelchButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 81.4
                height: 10.3
            }
        }

        Frame {
            name: "GuildEventLogFrame"
            wowParent: "FriendsFrame"
            pin: "place"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 96
            width: 395
            height: 435

            Frame {
                name: "GuildEventFrame"
                wowParent: "GuildEventLogFrame"
                anchors.left: parent.left
                anchors.leftMargin: 11
                anchors.top: parent.top
                anchors.topMargin: 42
                width: 375
                height: 360

                ScrollFrame {
                    name: "GuildEventLogScrollFrame"
                    wowParent: "GuildEventFrame"
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: parent.top
                    anchors.topMargin: 6
                    width: 325
                    height: 349

                    Frame {
                        name: "GuildEventLogScrollChildFrame"
                        wowParent: "GuildEventLogScrollFrame"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: -1109.5
                        width: 325
                        height: 359

                        FontString {
                            name: "GuildEventMessage"
                            wowParent: "GuildEventLogScrollChildFrame"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 325
                            height: 1635.6
                        }
                    }

                    Slider {
                        name: "GuildEventLogScrollFrameScrollBar"
                        wowParent: "GuildEventLogScrollFrame"
                        style: "ScrollBar"
                        anchors.left: parent.right
                        anchors.leftMargin: 6
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        width: 16
                        height: 317

                        Button {
                            name: "GuildEventLogScrollFrameScrollBarScrollDownButton"
                            wowParent: "GuildEventLogScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            width: 16
                            height: 16
                        }

                        Button {
                            name: "GuildEventLogScrollFrameScrollBarScrollUpButton"
                            wowParent: "GuildEventLogScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            width: 16
                            height: 16

                            Frame {
                                name: "GuildEventLogScrollFrameScrollBarDiabolicTrack"
                                wowParent: "GuildEventLogScrollFrameScrollBar"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: -1
                                width: 18
                                height: 351
                            }
                        }
                    }
                }
            }

            Button {
                name: "GuildEventLogCancelButton"
                text: "Close"
                wowParent: "GuildEventLogFrame"
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
                    wowParent: "GuildEventLogCancelButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 10.3
                }
            }

            Button {
                name: "GuildEventLogCloseButton"
                wowParent: "GuildEventLogFrame"
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
                wowParent: "GuildEventLogFrame"
                anchors.left: parent.left
                anchors.leftMargin: 17
                anchors.top: parent.top
                anchors.topMargin: 17
                width: 24.5
                height: 11.9
            }
        }

        Frame {
            name: "GuildInfoFrame"
            wowParent: "FriendsFrame"
            pin: "place"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 96
            width: 297
            height: 298

            Button {
                name: "GuildInfoCancelButton"
                text: "Close"
                wowParent: "GuildInfoFrame"
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
                    wowParent: "GuildInfoCancelButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 10.3
                }
            }

            Button {
                name: "GuildInfoCloseButton"
                wowParent: "GuildInfoFrame"
                anchors.right: parent.right
                anchors.rightMargin: 3
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 22
                height: 22
            }

            Button {
                name: "GuildInfoSaveButton"
                text: "Accept"
                wowParent: "GuildInfoFrame"
                style: "Button"
                anchors.right: parent.right
                anchors.rightMargin: 102
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                width: 87
                height: 22

                Button {
                    name: "GuildInfoGuildEventButton"
                    text: "Log"
                    wowParent: "GuildInfoFrame"
                    style: "Button"
                    anchors.right: parent.left
                    anchors.rightMargin: 32
                    anchors.verticalCenter: parent.verticalCenter
                    width: 65
                    height: 22

                    FontString {
                        name: "GuildInfoGuildEventButtonText"
                        text: "Log"
                        wowParent: "GuildInfoGuildEventButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20.5
                        height: 10.3
                    }
                }

                FontString {
                    name: "GuildInfoSaveButtonText"
                    text: "Accept"
                    wowParent: "GuildInfoSaveButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 37.1
                    height: 10.3
                }
            }

            Frame {
                name: "GuildInfoTextBackground"
                wowParent: "GuildInfoFrame"
                anchors.left: parent.left
                anchors.leftMargin: 11
                anchors.top: parent.top
                anchors.topMargin: 42
                width: 276
                height: 220

                ScrollFrame {
                    name: "GuildInfoFrameScrollFrame"
                    wowParent: "GuildInfoTextBackground"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 7
                    width: 243
                    height: 208

                    EditBox {
                        name: "GuildInfoEditBox"
                        wowParent: "GuildInfoFrameScrollFrame"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 240
                        height: 118.5
                    }

                    Slider {
                        name: "GuildInfoFrameScrollFrameScrollBar"
                        wowParent: "GuildInfoFrameScrollFrame"
                        style: "ScrollBar"
                        anchors.left: parent.right
                        anchors.leftMargin: 6
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        width: 16
                        height: 176

                        Button {
                            name: "GuildInfoFrameScrollFrameScrollBarScrollDownButton"
                            wowParent: "GuildInfoFrameScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            width: 16
                            height: 16
                        }

                        Button {
                            name: "GuildInfoFrameScrollFrameScrollBarScrollUpButton"
                            wowParent: "GuildInfoFrameScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            width: 16
                            height: 16

                            Frame {
                                name: "GuildInfoFrameScrollFrameScrollBarDiabolicTrack"
                                wowParent: "GuildInfoFrameScrollFrameScrollBar"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: -1
                                width: 18
                                height: 210
                            }
                        }
                    }
                }
            }

            FontString {
                name: "GuildInfoTitle"
                text: "Guild Information"
                wowParent: "GuildInfoFrame"
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
            wowParent: "GuildFrame"
            pin: "place"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 96
            width: 212
            height: 270
        }

        // kept as they are, at the foot's ends
        WowRow {
            name: "FriendsButtons"
            fit: "ends"
            anchors.left: parent.left
            anchors.leftMargin: 37
            anchors.right: parent.right
            anchors.rightMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 31

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
                    wowParent: "FriendsFrameAddFriendButton"
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
                    wowParent: "FriendsFrameSendMessageButton"
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
            anchors.leftMargin: 37
            anchors.right: parent.right
            anchors.rightMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30

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
                    wowParent: "WhoFrameWhoButton"
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
                    wowParent: "WhoFrameAddFriendButton"
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
                    wowParent: "WhoFrameGroupInviteButton"
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
            anchors.leftMargin: 37
            anchors.right: parent.right
            anchors.rightMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30

            Button {
                name: "GuildFrameGuildInformationButton"
                text: "Guild Information"
                wowParent: "GuildFrame"
                style: "Button"
                pin: "all"
                width: 122.9
                height: 22

                Frame {
                    name: "FriendsFrameDiabolicFoot"
                    wowParent: "FriendsFrameDiabolic"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 101.6
                    anchors.top: parent.top
                    anchors.topMargin: -6
                    width: 354
                    height: 47
                }

                FontString {
                    name: "GuildFrameGuildInformationButtonText"
                    text: "Guild Information"
                    wowParent: "GuildFrameGuildInformationButton"
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
                    wowParent: "GuildFrameAddMemberButton"
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
                    wowParent: "GuildFrameControlButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 72.7
                    height: 10.3
                }
            }
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
            wowParent: "FriendsFrameFriendsScrollFrame"
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

            Button {
                name: "FriendsFrameFriendsScrollFrameScrollBarScrollDownButton"
                wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "FriendsFrameFriendsScrollFrameScrollBarScrollUpButton"
                wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "FriendsFrameFriendsScrollFrameScrollBarDiabolicTrack"
                    wowParent: "FriendsFrameFriendsScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 344
                }
            }
        }

        Frame {
            name: "FriendsFrameFriendsScrollFrameScrollChild"
            wowParent: "FriendsFrameFriendsScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 10
            height: 10

            Button {
                name: "FriendsFrameFriendsScrollFrameButton1"
                wowParent: "FriendsFrameFriendsScrollFrameScrollChild"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 298
                height: 34

                FontString {
                    name: "FriendsFrameFriendsScrollFrameButton1Name"
                    text: "Annah"
                    wowParent: "FriendsFrameFriendsScrollFrameButton1"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 248
                    height: 12

                    FontString {
                        name: "FriendsFrameFriendsScrollFrameButton1Info"
                        text: "Unknown"
                        wowParent: "FriendsFrameFriendsScrollFrameButton1"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 2
                        width: 260
                        height: 10
                    }
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
            wowParent: "FriendsFrameIgnoreButton1"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 288
            height: 12
        }

        Frame {
            name: "FriendsFrameIgnoredHeader"
            wowParent: "FriendsFrameIgnoreButton1"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 302
            height: 16

            FontString {
                name: "FriendsFrameIgnoredHeaderTitle"
                text: "Ignored"
                wowParent: "FriendsFrameIgnoredHeader"
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

    Frame {
        name: "FriendsListFrame"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "FriendsTabHeader"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "GuildFrame"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "GuildFrameButton1"
            wowParent: "GuildPlayerStatusFrame"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 70
            width: 298
            height: 16

            FontString {
                name: "GuildFrameButton1Name"
                text: "Tocha"
                wowParent: "GuildFrameButton1"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 78
                height: 14

                FontString {
                    name: "GuildFrameButton1Zone"
                    text: "Borean Tundra"
                    wowParent: "GuildFrameButton1"
                    anchors.left: parent.right
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    width: 110
                    height: 14

                    FontString {
                        name: "GuildFrameButton1Level"
                        text: "70"
                        wowParent: "GuildFrameButton1"
                        anchors.left: parent.right
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20
                        height: 14

                        FontString {
                            name: "GuildFrameButton1Class"
                            text: "Warrior"
                            wowParent: "GuildFrameButton1"
                            anchors.left: parent.right
                            anchors.leftMargin: 12
                            anchors.verticalCenter: parent.verticalCenter
                            width: 80
                            height: 14

                            FontString {
                                name: "GuildFrameButton1Group"
                                wowParent: "GuildFrameButton1"
                                anchors.left: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: 40
                                height: 14
                            }
                        }
                    }
                }
            }
        }

        Button {
            name: "GuildFrameGuildListToggleButton"
            text: "Player Status"
            wowParent: "GuildFrame"
            anchors.left: parent.left
            anchors.leftMargin: 307
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 34
            width: 32
            height: 32
        }

        Frame {
            name: "GuildFrameLFGFrame"
            wowParent: "GuildFrame"
            anchors.right: parent.right
            anchors.rightMargin: 42
            anchors.top: parent.top
            anchors.topMargin: 13
            width: 210
            height: 23
        }

        FontString {
            name: "GuildFrameNotesLabel"
            text: "Guild Message Of The Day:"
            wowParent: "GuildFrame"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.top: parent.top
            anchors.topMargin: 319
            width: 225
            height: 11

            FontString {
                name: "GuildFrameNotesText"
                text: "https://discord.gg/Xkh2Q6kW4m - WE NEED MORE PET PICTURES "
                wowParent: "GuildFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
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
        }

        FontString {
            name: "GuildFrameTotals"
            wowParent: "GuildFrame"
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 75
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: -42
            width: 92.4
            height: 16

            FontString {
                name: "GuildFrameOnlineTotals"
                wowParent: "GuildFrame"
                anchors.left: parent.right
                anchors.leftMargin: 3
                anchors.verticalCenter: parent.verticalCenter
                width: 53.7
                height: 16
            }
        }

        Frame {
            name: "GuildPlayerStatusFrame"
            wowParent: "GuildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -25
            width: 300
            height: 200

            Button {
                name: "GuildFrameColumnHeader1"
                text: "Name"
                wowParent: "GuildPlayerStatusFrame"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 70
                width: 83
                height: 22

                Button {
                    name: "GuildFrameColumnHeader2"
                    text: "Zone"
                    wowParent: "GuildPlayerStatusFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: -2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 120
                    height: 22

                    Button {
                        name: "GuildFrameColumnHeader3"
                        text: "Lvl"
                        wowParent: "GuildPlayerStatusFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: -2
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 22

                        Button {
                            name: "GuildFrameColumnHeader4"
                            text: "Class"
                            wowParent: "GuildPlayerStatusFrame"
                            anchors.left: parent.right
                            anchors.leftMargin: -2
                            anchors.verticalCenter: parent.verticalCenter
                            width: 92
                            height: 22
                        }
                    }
                }
            }
        }
    }

    Frame {
        name: "IgnoreListFrame"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "RaidFrame"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Frame {
            name: "RaidFrameNotInRaid"
            wowParent: "RaidFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 384
            height: 512

            FontString {
                name: "RaidFrameRaidDescription"
                wowParent: "RaidFrameNotInRaid"
                anchors.left: parent.left
                anchors.leftMargin: 29
                anchors.top: parent.top
                anchors.topMargin: 85
                width: 300
                height: 165.9

                FontString {
                    name: "RaidFrameRaidBrowserDescription"
                    text: "Find a Raid Group or Assemble a Raid"
                    wowParent: "RaidFrameNotInRaid"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: 50
                    width: 300
                    height: 11.9

                    Button {
                        name: "RaidFrameNotInRaidRaidBrowserButton"
                        text: "Open Raid Browser"
                        wowParent: "RaidFrameNotInRaid"
                        style: "Button"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        width: 260
                        height: 22

                        FontString {
                            name: "RaidFrameNotInRaidRaidBrowserButtonText"
                            text: "Open Raid Browser"
                            wowParent: "RaidFrameNotInRaidRaidBrowserButton"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 105.1
                            height: 10.3
                        }
                    }
                }
            }
        }
    }

    Frame {
        name: "WhoFrame"
        wowParent: "FriendsFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "WhoFrameButton1"
            wowParent: "WhoFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 61
            width: 298
            height: 16

            FontString {
                name: "WhoFrameButton1Name"
                text: "Avitar"
                wowParent: "WhoFrameButton1"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 88
                height: 14

                FontString {
                    name: "WhoFrameButton1Variable"
                    text: "Hillsbrad Foothills"
                    wowParent: "WhoFrameButton1"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 95
                    height: 14

                    FontString {
                        name: "WhoFrameButton1Level"
                        text: "30"
                        wowParent: "WhoFrameButton1"
                        anchors.left: parent.right
                        anchors.leftMargin: 2
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20
                        height: 14

                        FontString {
                            name: "WhoFrameButton1Class"
                            text: "Paladin"
                            wowParent: "WhoFrameButton1"
                            anchors.left: parent.right
                            anchors.leftMargin: 12
                            anchors.verticalCenter: parent.verticalCenter
                            width: 80
                            height: 8
                        }
                    }
                }
            }
        }

        Button {
            name: "WhoFrameColumnHeader1"
            text: "Name"
            wowParent: "WhoFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 34
            width: 83
            height: 22

            Button {
                name: "WhoFrameColumnHeader2"
                text: "Zone"
                wowParent: "WhoFrame"
                anchors.left: parent.right
                anchors.leftMargin: -2
                anchors.verticalCenter: parent.verticalCenter
                width: 120
                height: 22

                Button {
                    name: "WhoFrameColumnHeader3"
                    text: "Lvl"
                    wowParent: "WhoFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: -2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 22

                    Button {
                        name: "WhoFrameColumnHeader4"
                        text: "Class"
                        wowParent: "WhoFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: -2
                        anchors.verticalCenter: parent.verticalCenter
                        width: 92
                        height: 22
                    }
                }
            }
        }

        FontString {
            name: "WhoFrameTotals"
            text: "0 People Found  "
            wowParent: "WhoFrame"
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
            height: 328

            Frame {
                name: "WhoListScrollFrameDiabolicZoneColumnBar"
                wowParent: "WhoListScrollFrameDiabolicZone"
                anchors.left: parent.left
                anchors.bottom: parent.top
                width: 330
                height: 22
            }
        }

        Slider {
            name: "WhoListScrollFrameScrollBar"
            wowParent: "WhoListScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 266

            Button {
                name: "WhoListScrollFrameScrollBarScrollDownButton"
                wowParent: "WhoListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "WhoListScrollFrameScrollBarScrollUpButton"
                wowParent: "WhoListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "WhoListScrollFrameScrollBarDiabolicTrack"
                    wowParent: "WhoListScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 300
                }
            }
        }

        Frame {
            name: "WhoListScrollFrameScrollChildFrame"
            wowParent: "WhoListScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -480
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
        name: "FriendsFrameFriendsScrollFrameButton9"
        x: 21
        y: 308
        width: 298
        height: 34

        Frame {
            name: "FriendsTooltip"
            wowParent: "FriendsFrame"
            anchors.left: parent.right
            anchors.leftMargin: 36
            anchors.top: parent.top
            width: 65.8
            height: 35.8

            FontString {
                name: "FriendsTooltipHeader"
                text: "Drread"
                wowParent: "FriendsTooltip"
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.top: parent.top
                anchors.topMargin: 12
                width: 152.9
                height: 10.3

                FontString {
                    name: "FriendsTooltipNoteText"
                    text: "THE ONLY ONE"
                    wowParent: "FriendsTooltip"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 7.8
                    anchors.top: parent.bottom
                    anchors.topMargin: -95.1
                    width: 137.3
                    height: 8.7
                }
            }
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
                wowParent: "GuildListScrollFrameDiabolicZone"
                anchors.left: parent.left
                anchors.bottom: parent.top
                width: 330
                height: 22
            }
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
                wowParent: "ChannelFrameDaughterFrame"
                anchors.right: parent.right
                anchors.rightMargin: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                width: 93.5
                height: 22

                FontString {
                    name: "ChannelFrameDaughterFrameCancelButtonText"
                    text: "Cancel"
                    wowParent: "ChannelFrameDaughterFrameCancelButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 35.6
                    height: 10.3
                }
            }

            EditBox {
                name: "ChannelFrameDaughterFrameChannelName"
                wowParent: "ChannelFrameDaughterFrame"
                anchors.left: parent.left
                anchors.leftMargin: 23
                anchors.top: parent.top
                anchors.topMargin: 60
                width: 170
                height: 16

                Frame {
                    name: "ChannelFrameDaughterFrameChannelNameDiabolicField"
                    wowParent: "ChannelFrameDaughterFrameChannelName"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 186
                    height: 22
                }

                FontString {
                    name: "ChannelFrameDaughterFrameChannelNameLabel"
                    text: "Channel Name"
                    wowParent: "ChannelFrameDaughterFrameChannelName"
                    anchors.left: parent.left
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 5
                    width: 85.3
                    height: 14.2
                }

                EditBox {
                    name: "ChannelFrameDaughterFrameChannelPassword"
                    wowParent: "ChannelFrameDaughterFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 30
                    width: 170
                    height: 16

                    Frame {
                        name: "ChannelFrameDaughterFrameChannelPasswordDiabolicField"
                        wowParent: "ChannelFrameDaughterFrameChannelPassword"
                        anchors.left: parent.left
                        anchors.leftMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 186
                        height: 22
                    }

                    FontString {
                        name: "ChannelFrameDaughterFrameChannelPasswordLabel"
                        text: "Password"
                        wowParent: "ChannelFrameDaughterFrameChannelPassword"
                        anchors.left: parent.left
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 5
                        width: 55.3
                        height: 14.2

                        FontString {
                            name: "ChannelFrameDaughterFrameChannelPasswordOptional"
                            text: "(optional)"
                            wowParent: "ChannelFrameDaughterFrameChannelPassword"
                            anchors.left: parent.right
                            anchors.leftMargin: 3
                            anchors.verticalCenter: parent.verticalCenter
                            width: 52.9
                            height: 10.3
                        }
                    }
                }
            }

            Button {
                name: "ChannelFrameDaughterFrameDetailCloseButton"
                wowParent: "ChannelFrameDaughterFrame"
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
                wowParent: "ChannelFrameDaughterFrame"
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
                wowParent: "ChannelFrameDaughterFrame"
                anchors.right: parent.right
                anchors.rightMargin: 108.5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                width: 93.5
                height: 22

                FontString {
                    name: "ChannelFrameDaughterFrameOkayButtonText"
                    text: "Okay"
                    wowParent: "ChannelFrameDaughterFrameOkayButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 28.4
                    height: 10.3
                }
            }
        }
    }
}
