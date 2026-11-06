// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "LFDParentFrame"
    width: 355
    height: 440

    Frame {
        name: "LFDParentFrameDiabolic"
        wowParent: "LFDParentFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -40
        width: 413
        height: 482

        Frame {
            name: "LFDParentFrameDiabolicBand"
            wowParent: "LFDParentFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 365
            height: 40

            Frame {
                name: "LFDQueueFrameTypeDropDown"
                wowParent: "LFDQueueFrame"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.verticalCenter: parent.verticalCenter
                width: 280
                height: 32

                Frame {
                    name: "LFDQueueFrameTypeDropDownDiabolicField"
                    wowParent: "LFDQueueFrameTypeDropDown"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 280
                    height: 22

                    Button {
                        name: "LFDQueueFrameTypeDropDownButton"
                        wowParent: "LFDQueueFrameTypeDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }
                }

                FontString {
                    name: "LFDQueueFrameTypeDropDownName"
                    text: "Type:"
                    wowParent: "LFDQueueFrameTypeDropDown"
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 115
                    height: 24
                }

                FontString {
                    name: "LFDQueueFrameTypeDropDownText"
                    text: "Random Lich King Heroic"
                    wowParent: "LFDQueueFrameTypeDropDown"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -11
                    anchors.verticalCenter: parent.verticalCenter
                    width: 205
                    height: 10
                }
            }
        }

        Frame {
            name: "LFDParentFrameDiabolicBorder"
            wowParent: "LFDParentFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 413
            height: 482

            Frame {
                name: "LFDParentFrameDiabolicTitlePlate"
                wowParent: "LFDParentFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "LFDQueueFrameTitleText"
                    text: "Dungeon Finder"
                    wowParent: "LFDParentFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 144.6
                    height: 14.2
                }
            }
        }

        Frame {
            name: "LFDParentFrameDiabolicSocket"
            wowParent: "LFDParentFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }

        Button {
            name: "LFDQueueFrameRoleButtonTank"
            wowParent: "LFDQueueFrame"
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: -136
            anchors.top: parent.top
            anchors.topMargin: 72
            width: 48
            height: 48

            Button {
                name: "LFDQueueFrameRoleButtonHealer"
                wowParent: "LFDQueueFrame"
                anchors.left: parent.right
                anchors.leftMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                width: 48
                height: 48

                Button {
                    name: "LFDQueueFrameRoleButtonDPS"
                    wowParent: "LFDQueueFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 23
                    anchors.verticalCenter: parent.verticalCenter
                    width: 48
                    height: 48

                    Button {
                        name: "LFDQueueFrameRoleButtonLeader"
                        wowParent: "LFDQueueFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 32
                        anchors.verticalCenter: parent.verticalCenter
                        width: 48
                        height: 48
                    }
                }
            }
        }

        // kept as they are, at the foot's ends
        WowRow {
            name: "LFDButtons"
            fit: "ends"
            anchors.left: parent.left
            anchors.leftMargin: 37
            anchors.right: parent.right
            anchors.rightMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30

            Button {
                name: "LFDQueueFrameFindGroupButton"
                text: "Find Group"
                wowParent: "LFDQueueFrame"
                style: "Button"
                pin: "place"
                width: 135
                height: 22

                Frame {
                    name: "LFDParentFrameDiabolicFoot"
                    wowParent: "LFDParentFrameDiabolic"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 102
                    anchors.top: parent.top
                    anchors.topMargin: -6
                    width: 367
                    height: 35
                }

                FontString {
                    name: "LFDQueueFrameFindGroupButtonText"
                    text: "Find Group"
                    wowParent: "LFDQueueFrameFindGroupButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 82.2
                    height: 11.9
                }
            }

            Button {
                name: "LFDQueueFrameCancelButton"
                text: "Close"
                wowParent: "LFDQueueFrame"
                style: "Button"
                pin: "place"
                width: 112
                height: 22

                FontString {
                    name: "LFDQueueFrameCancelButtonText"
                    text: "Close"
                    wowParent: "LFDQueueFrameCancelButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40.3
                    height: 11.9
                }
            }
        }
    }

    Frame {
        name: "LFDParentFramePortrait"
        wowParent: "LFDParentFrame"
        anchors.left: parent.left
        anchors.leftMargin: 9
        anchors.top: parent.top
        anchors.topMargin: 5
        width: 64
        height: 64
    }

    Frame {
        name: "LFDQueueFrame"
        wowParent: "LFDParentFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 355
        height: 440

        Frame {
            name: "LFDQueueFrameRandom"
            wowParent: "LFDQueueFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -62
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 46
            width: 355
            height: 456

            ScrollFrame {
                name: "LFDQueueFrameRandomScrollFrame"
                wowParent: "LFDQueueFrameRandom"
                pin: "all"
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 34
                width: 298
                height: 265

                Frame {
                    name: "LFDQueueFrameRandomScrollFrameChildFrame"
                    wowParent: "LFDQueueFrameRandomScrollFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 1
                    height: 1

                    FontString {
                        name: "LFDQueueFrameRandomScrollFrameChildFrameTitle"
                        text: "Random Dungeon"
                        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        width: 171.5
                        height: 15.8

                        FontString {
                            name: "LFDQueueFrameRandomScrollFrameChildFrameDescription"
                            text: "Using the Dungeon Finder to do a Random Dungeon will earn you extra rewards."
                            wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 5
                            width: 280
                            height: 25.3

                            FontString {
                                name: "LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel"
                                text: "Rewards"
                                wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 10
                                width: 84.5
                                height: 15.8

                                FontString {
                                    name: "LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription"
                                    text: "The first random dungeon that you complete each day will earn you:"
                                    wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 5
                                    width: 280
                                    height: 25.3

                                    Button {
                                        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
                                        wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 10
                                        width: 147
                                        height: 41

                                        FontString {
                                            name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyLabel"
                                            text: "Money:"
                                            wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                            anchors.left: parent.left
                                            anchors.leftMargin: 20
                                            anchors.top: parent.bottom
                                            anchors.topMargin: 10
                                            width: 49
                                            height: 12.6

                                            Frame {
                                                name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
                                                wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                                anchors.left: parent.right
                                                anchors.leftMargin: 10
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: 80.9
                                                height: 28
                                            }

                                            Frame {
                                                name: "LFDQueueFrameRandomScrollFrameChildFrameSpacer"
                                                wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                                anchors.left: parent.left
                                                anchors.top: parent.bottom
                                                anchors.topMargin: 10
                                                width: 2
                                                height: 2
                                            }

                                            FontString {
                                                name: "LFDQueueFrameRandomScrollFrameChildFrameXPLabel"
                                                text: "Experience:"
                                                wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                                anchors.left: parent.left
                                                anchors.top: parent.bottom
                                                anchors.topMargin: 5
                                                width: 74.3
                                                height: 12.6

                                                FontString {
                                                    name: "LFDQueueFrameRandomScrollFrameChildFrameXPAmount"
                                                    text: "16000"
                                                    wowParent: "LFDQueueFrameRandomScrollFrameChildFrame"
                                                    anchors.left: parent.right
                                                    anchors.leftMargin: 10
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    width: 42.7
                                                    height: 15.8
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Frame {
                    name: "LFDQueueFrameRandomScrollFrameDiabolicZone"
                    wowParent: "LFDQueueFrameRandom"
                    anchors.left: parent.left
                    anchors.leftMargin: -6
                    anchors.top: parent.top
                    anchors.topMargin: -6
                    width: 332
                    height: 277
                }
            }
        }

        Frame {
            name: "LFDQueueFrameSpecific"
            wowParent: "LFDQueueFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -62
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 46
            width: 355
            height: 456

            Frame {
                name: "LFDQueueFrameSpecificListButton1"
                wowParent: "LFDQueueFrameSpecific"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 165
                width: 295
                height: 16

                Button {
                    name: "LFDQueueFrameSpecificListButton1ExpandOrCollapseButton"
                    wowParent: "LFDQueueFrameSpecificListButton1"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    width: 13
                    height: 13
                }

                FontString {
                    name: "LFDQueueFrameSpecificListButton1InstanceLevel"
                    text: "(69 - 80)"
                    wowParent: "LFDQueueFrameSpecificListButton1"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 60
                    height: 16
                }

                FontString {
                    name: "LFDQueueFrameSpecificListButton1InstanceName"
                    text: "The Nexus"
                    wowParent: "LFDQueueFrameSpecificListButton1"
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    anchors.verticalCenter: parent.verticalCenter
                    width: 185
                    height: 16
                }

                ScrollFrame {
                    name: "LFDQueueFrameSpecificListScrollFrame"
                    wowParent: "LFDQueueFrameSpecific"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: -7
                    width: 296
                    height: 270

                    Frame {
                        name: "LFDQueueFrameSpecificListScrollFrameDiabolicZone"
                        wowParent: "LFDQueueFrameSpecific"
                        anchors.left: parent.left
                        anchors.leftMargin: -6
                        anchors.top: parent.top
                        anchors.topMargin: -6
                        width: 330
                        height: 282
                    }

                    Slider {
                        name: "LFDQueueFrameSpecificListScrollFrameScrollBar"
                        wowParent: "LFDQueueFrameSpecificListScrollFrame"
                        style: "ScrollBar"
                        anchors.left: parent.right
                        anchors.leftMargin: 6
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        width: 16
                        height: 238

                        Button {
                            name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
                            wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            width: 16
                            height: 16
                        }

                        Button {
                            name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
                            wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
                            style: "ScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            width: 16
                            height: 16

                            Frame {
                                name: "LFDQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
                                wowParent: "LFDQueueFrameSpecificListScrollFrameScrollBar"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: -1
                                width: 18
                                height: 272
                            }
                        }
                    }

                    Frame {
                        name: "LFDQueueFrameSpecificListScrollFrameScrollChildFrame"
                        wowParent: "LFDQueueFrameSpecificListScrollFrame"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: -288
                        width: 300
                        height: 544
                    }
                }
            }
        }
    }

    Ghost {
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture"
        x: 72
        y: 261.1
        width: 0
        height: 0

        FontString {
            name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Count"
            text: "2"
            wowParent: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            width: 10.3
            height: 14.2
        }
    }

    Ghost {
        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1NameFrame"
        x: 62
        y: 241.6
        width: 0
        height: 0

        FontString {
            name: "LFDQueueFrameRandomScrollFrameChildFrameItem1Name"
            text: "Emblem of Conquest"
            wowParent: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            width: 90
            height: 36
        }
    }

    Ghost {
        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton"
        x: 180
        y: 279.5
        width: 0
        height: 0

        Button {
            name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
            text: "20"
            wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 32
            height: 19

            Button {
                name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
                text: "22"
                wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
                anchors.right: parent.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 19

                FontString {
                    name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText"
                    text: "22"
                    wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 19
                    height: 15.8
                }
            }

            FontString {
                name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButtonText"
                text: "20"
                wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 19
                height: 15.8
            }
        }
    }

    Ghost {
        name: "LFDQueueFrameSpecificListButton1LockedIndicator"
        x: 56
        y: 111
        width: 0
        height: 0

        CheckButton {
            name: "LFDQueueFrameSpecificListButton1EnableButton"
            wowParent: "LFDQueueFrameSpecificListButton1"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: 20
        }
    }
}
