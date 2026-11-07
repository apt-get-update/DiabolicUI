// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "LFRParentFrame"
    width: 355
    height: 440

    Frame {
        name: "LFRBrowseFrame"
        wowParent: "LFRParentFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 355
        height: 440

        Button {
            id: lFRBrowseFrameColumnHeader1
            name: "LFRBrowseFrameColumnHeader1"
            text: "Name"
            wowParent: "LFRBrowseFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 26
            anchors.top: parent.top
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
            name: "LFRBrowseFrameColumnHeader7"
            wowParent: "LFRBrowseFrame"
            anchors.left: lFRBrowseFrameColumnHeader6.right
            anchors.leftMargin: -2
            anchors.verticalCenter: lFRBrowseFrameColumnHeader6.verticalCenter
            width: 25
            height: 22
        }

        Button {
            name: "LFRBrowseFrameListButton1"
            wowParent: "LFRBrowseFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.top: parent.top
            anchors.topMargin: 66
            width: 298
            height: 16
        }

        FontString {
            name: "LFRBrowseFrameTitleText"
            text: "Raid Browser"
            wowParent: "LFRBrowseFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 12
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 79.8
            height: 11.9
        }
    }

    Frame {
        name: "LFRParentFrameDiabolic"
        wowParent: "LFRParentFrame"
        anchors.left: parent.left
        anchors.leftMargin: -16
        anchors.top: parent.top
        anchors.topMargin: -68
        width: 370
        height: 544

        Frame {
            name: "LFRParentFrameDiabolicBand"
            wowParent: "LFRParentFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 322
            height: 40

            FontString {
                name: "LFRBrowseFrameRaidDropDownName"
                text: "Browsing:"
                wowParent: "LFRBrowseFrameRaidDropDown"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 55.3
                height: 12

                Frame {
                    name: "LFRBrowseFrameRaidDropDown"
                    wowParent: "LFRBrowseFrame"
                    style: "DropDown"
                    anchors.left: parent.right
                    anchors.leftMargin: -4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 190
                    height: 32

                    Frame {
                        name: "LFRBrowseFrameRaidDropDownDiabolicField"
                        wowParent: "LFRBrowseFrameRaidDropDown"
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: 190
                        height: 22

                        Button {
                            name: "LFRBrowseFrameRaidDropDownButton"
                            wowParent: "LFRBrowseFrameRaidDropDown"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.verticalCenter: parent.verticalCenter
                            width: 18
                            height: 18
                        }

                        FontString {
                            name: "LFRBrowseFrameRaidDropDownText"
                            text: "(25) Icecrown Citadel"
                            wowParent: "LFRBrowseFrameRaidDropDown"
                            anchors.left: parent.left
                            anchors.leftMargin: 22
                            anchors.verticalCenter: parent.verticalCenter
                            width: 128
                            height: 10
                        }
                    }
                }
            }

            EditBox {
                name: "LFRQueueFrameComment"
                wowParent: "LFRQueueFrame"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 250
                height: 20

                Frame {
                    name: "LFRQueueFrameCommentDiabolicField"
                    wowParent: "LFRQueueFrameComment"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 266
                    height: 22
                }

                FontString {
                    name: "LFRQueueFrameCommentExplanation"
                    text: "Type your comment here."
                    wowParent: "LFRQueueFrameComment"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 250
                    height: 20
                }

                Button {
                    name: "LFRQueueFrameCommentTextButton"
                    wowParent: "LFRQueueFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 250
                    height: 20
                }
            }
        }

        Frame {
            name: "LFRParentFrameDiabolicBorder"
            wowParent: "LFRParentFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 370
            height: 512

            Frame {
                name: "LFRParentFrameDiabolicTitlePlate"
                wowParent: "LFRParentFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "LFRQueueFrameTitleText"
                    text: "Raid Browser"
                    wowParent: "LFRParentFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 120.9
                    height: 14.2
                }
            }
        }

        Frame {
            name: "LFRParentFrameDiabolicFoot"
            wowParent: "LFRParentFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 324
            height: 35

            // the browse page's buttons across the foot, clear of the iron
            WowRow {
                name: "LFRBrowseButtons"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "LFRBrowseFrameSendMessageButton"
                    text: "Send Message"
                    wowParent: "LFRBrowseFrame"
                    style: "Button"
                    pin: "all"
                    width: 126.3
                    height: 22

                    FontString {
                        name: "LFRBrowseFrameSendMessageButtonText"
                        text: "Send Message"
                        wowParent: "LFRBrowseFrameSendMessageButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 98
                        height: 11.9
                    }
                }

                Button {
                    name: "LFRBrowseFrameInviteButton"
                    text: "Invite"
                    wowParent: "LFRBrowseFrame"
                    style: "Button"
                    pin: "all"
                    width: 74.1
                    height: 22

                    FontString {
                        name: "LFRBrowseFrameInviteButtonText"
                        text: "Invite"
                        wowParent: "LFRBrowseFrameInviteButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 45.8
                        height: 11.9
                    }
                }

                Button {
                    name: "LFRBrowseFrameRefreshButton"
                    text: "Refresh"
                    wowParent: "LFRBrowseFrame"
                    style: "Button"
                    pin: "all"
                    width: 83.6
                    height: 22

                    FontString {
                        name: "LFRBrowseFrameRefreshButtonText"
                        text: "Refresh"
                        wowParent: "LFRBrowseFrameRefreshButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 55.3
                        height: 11.9
                    }
                }
            }

            // the raid page's two at the foot's ends, as far in
            WowRow {
                name: "LFRQueueButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "LFRQueueFrameFindGroupButton"
                    text: "List My Name"
                    wowParent: "LFRQueueFrame"
                    style: "Button"
                    pin: "place"
                    width: 125
                    height: 22

                    FontString {
                        name: "LFRQueueFrameFindGroupButtonText"
                        text: "List My Name"
                        wowParent: "LFRQueueFrameFindGroupButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 97.2
                        height: 11.9
                    }
                }

                Button {
                    name: "LFRQueueFrameAcceptCommentButton"
                    text: "Set Comment"
                    wowParent: "LFRQueueFrame"
                    style: "Button"
                    pin: "place"
                    width: 115
                    height: 22

                    FontString {
                        name: "LFRQueueFrameAcceptCommentButtonText"
                        text: "Set Comment"
                        wowParent: "LFRQueueFrameAcceptCommentButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 96.4
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "LFRParentFrameDiabolicRail"
            wowParent: "LFRParentFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "LFRParentFrameDiabolicSocket"
            wowParent: "LFRParentFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "LFRParentFrameTab1"
            text: "Choose Raid"
            wowParent: "LFRParentFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "LFRParentFrameTab2"
            text: "Browse"
            wowParent: "LFRParentFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
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
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: -116
            anchors.top: parent.top
            anchors.topMargin: 128
            width: 48
            height: 48
        }
    }

    Frame {
        name: "LFRQueueFrame"
        wowParent: "LFRParentFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 355
        height: 440

        Frame {
            name: "LFRQueueFrameSpecific"
            wowParent: "LFRQueueFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 355
            height: 440

            Frame {
                name: "LFRQueueFrameSpecificListButton1"
                wowParent: "LFRQueueFrameSpecific"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 17
                anchors.top: parent.top
                anchors.topMargin: 132
                width: 295
                height: 16

                Button {
                    name: "LFRQueueFrameSpecificListButton1ExpandOrCollapseButton"
                    wowParent: "LFRQueueFrameSpecificListButton1"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    width: 13
                    height: 13
                }

                FontString {
                    name: "LFRQueueFrameSpecificListButton1InstanceLevel"
                    text: "(80 - 83)"
                    wowParent: "LFRQueueFrameSpecificListButton1"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 60
                    height: 16
                }

                FontString {
                    name: "LFRQueueFrameSpecificListButton1InstanceName"
                    text: "Wrath of the Lich King Raid (25)"
                    wowParent: "LFRQueueFrameSpecificListButton1"
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    anchors.verticalCenter: parent.verticalCenter
                    width: 255
                    height: 16
                }

                ScrollFrame {
                    name: "LFRQueueFrameSpecificListScrollFrame"
                    wowParent: "LFRQueueFrameSpecific"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: -2
                    width: 296
                    height: 228

                    Frame {
                        name: "LFRQueueFrameSpecificListScrollFrameDiabolicZone"
                        wowParent: "LFRQueueFrameSpecific"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: 2
                        anchors.top: parent.top
                        anchors.topMargin: -6
                        width: 330
                        height: 270
                    }

                    Slider {
                        name: "LFRQueueFrameSpecificListScrollFrameScrollBar"
                        wowParent: "LFRQueueFrameSpecificListScrollFrame"
                        style: "ScrollBar"
                        anchors.left: parent.right
                        anchors.leftMargin: 6
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        width: 16
                        height: 196

                        Button {
                            name: "LFRQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
                            wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            width: 16
                            height: 16
                        }

                        Button {
                            name: "LFRQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
                            wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            width: 16
                            height: 16

                            Frame {
                                name: "LFRQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
                                wowParent: "LFRQueueFrameSpecificListScrollFrameScrollBar"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: -1
                                width: 18
                                height: 230
                            }
                        }
                    }

                    Frame {
                        name: "LFRQueueFrameSpecificListScrollFrameScrollChildFrame"
                        wowParent: "LFRQueueFrameSpecificListScrollFrame"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 300
                        height: 624
                    }
                }
            }
        }
    }

    Ghost {
        name: "LFRBrowseFrameListScrollFrame"
        x: 167
        y: 66
        width: 0
        height: 0

        Frame {
            name: "LFRBrowseFrameListScrollFrameDiabolicZone"
            wowParent: "LFRBrowseFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 330
            height: 332

            Frame {
                name: "LFRBrowseFrameListScrollFrameDiabolicZoneColumnBar"
                wowParent: "LFRBrowseFrameListScrollFrameDiabolicZone"
                anchors.left: parent.left
                anchors.bottom: parent.top
                width: 330
                height: 22
            }
        }
    }

    Ghost {
        name: "LFRQueueFrameSpecificListButton12"
        x: 17
        y: 308
        width: 295
        height: 16

        Button {
            name: "LFRQueueFrameSpecificListButton12ExpandOrCollapseButton"
            wowParent: "LFRQueueFrameSpecificListButton12"
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            width: 13
            height: 13
        }
    }

    Ghost {
        name: "LFRQueueFrameSpecificListButton1LockedIndicator"
        x: 48
        y: 140
        width: 0
        height: 0

        CheckButton {
            name: "LFRQueueFrameSpecificListButton1EnableButton"
            wowParent: "LFRQueueFrameSpecificListButton1"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: 20
        }
    }

    Ghost {
        name: "LFRQueueFrameSpecificListButton6"
        x: 17
        y: 212
        width: 295
        height: 16

        Button {
            name: "LFRQueueFrameSpecificListButton6ExpandOrCollapseButton"
            wowParent: "LFRQueueFrameSpecificListButton6"
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            width: 13
            height: 13
        }
    }
}
