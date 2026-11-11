// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "LFDParentFrame"
    width: 355
    height: 440

    Frame {
        name: "LFDParentFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -40
        width: 413
        height: 482

        Frame {
            name: "LFDParentFrameDiabolicBand"
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
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 115
                    height: 24
                }

                FontString {
                    name: "LFDQueueFrameTypeDropDownText"
                    text: "Random Lich King Heroic"
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
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 144.6
                    height: 14.2
                }
            }
        }

        Frame {
            name: "LFDParentFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 367
            height: 35

            // kept as they are, at the foot's ends
            WowRow {
                name: "LFDButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "LFDQueueFrameFindGroupButton"
                    text: "Find Group"
                    wowParent: "LFDQueueFrame"
                    style: "Button"
                    pin: "place"
                    width: 135
                    height: 22

                    FontString {
                        name: "LFDQueueFrameFindGroupButtonText"
                        text: "Find Group"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 40.3
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "LFDParentFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
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
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: -136
            anchors.top: parent.top
            anchors.topMargin: 72
            width: 48
            height: 48
        }
    }

    Frame {
        name: "LFDParentFramePortrait"
        anchors.left: parent.left
        anchors.leftMargin: 9
        anchors.top: parent.top
        anchors.topMargin: 5
        width: 64
        height: 64
    }

    Frame {
        name: "LFDQueueFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 355
        height: 440

        Frame {
            name: "LFDQueueFrameRandom"
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
                pin: "all"
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 34
                width: 298
                height: 265

                Frame {
                    name: "LFDQueueFrameRandomScrollFrameChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 1
                    height: 1

                    FontString {
                        id: lFDQueueFrameRandomScrollFrameChildFrameDescription
                        name: "LFDQueueFrameRandomScrollFrameChildFrameDescription"
                        text: "Using the Dungeon Finder to do a Random Dungeon will earn you extra rewards."
                        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameTitle.left
                        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameTitle.bottom
                        anchors.topMargin: 5
                        width: 280
                        height: 25.3
                    }

                    Button {
                        id: lFDQueueFrameRandomScrollFrameChildFrameItem1
                        name: "LFDQueueFrameRandomScrollFrameChildFrameItem1"
                        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription.left
                        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameRewardsDescription.bottom
                        anchors.topMargin: 10
                        width: 147
                        height: 41

                        Ghost {
                            name: "LFDQueueFrameRandomScrollFrameChildFrameItem1IconTexture"
                            x: 39
                            y: 39
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
                            x: 29
                            y: 19.5
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
                    }

                    Frame {
                        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
                        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.verticalCenter
                        width: 80.9
                        height: 28

                        Ghost {
                            name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameCopperButton"
                            x: 68
                            y: 14
                            width: 0
                            height: 0

                            Button {
                                name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButton"
                                text: "22"
                                wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
                                anchors.right: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.left
                                anchors.rightMargin: 4
                                anchors.verticalCenter: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton.verticalCenter
                                width: 32
                                height: 19

                                FontString {
                                    name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameGoldButtonText"
                                    text: "22"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 19
                                    height: 15.8
                                }
                            }

                            Button {
                                id: lFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton
                                name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButton"
                                text: "20"
                                wowParent: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrame"
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: 32
                                height: 19

                                FontString {
                                    name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyFrameSilverButtonText"
                                    text: "20"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 19
                                    height: 15.8
                                }
                            }
                        }
                    }

                    FontString {
                        id: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel
                        name: "LFDQueueFrameRandomScrollFrameChildFrameMoneyLabel"
                        text: "Money:"
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
                        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameDescription.left
                        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameDescription.bottom
                        anchors.topMargin: 10
                        width: 84.5
                        height: 15.8
                    }

                    Frame {
                        name: "LFDQueueFrameRandomScrollFrameChildFrameSpacer"
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
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        width: 171.5
                        height: 15.8
                    }

                    FontString {
                        name: "LFDQueueFrameRandomScrollFrameChildFrameXPAmount"
                        text: "16000"
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
                        anchors.left: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.left
                        anchors.top: lFDQueueFrameRandomScrollFrameChildFrameMoneyLabel.bottom
                        anchors.topMargin: 5
                        width: 74.3
                        height: 12.6
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
                id: lFDQueueFrameSpecificListButton1
                name: "LFDQueueFrameSpecificListButton1"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 165
                width: 295
                height: 16

                Button {
                    name: "LFDQueueFrameSpecificListButton1ExpandOrCollapseButton"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    width: 13
                    height: 13
                }

                FontString {
                    name: "LFDQueueFrameSpecificListButton1InstanceLevel"
                    text: "(69 - 80)"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 60
                    height: 16
                }

                FontString {
                    name: "LFDQueueFrameSpecificListButton1InstanceName"
                    text: "The Nexus"
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    anchors.verticalCenter: parent.verticalCenter
                    width: 185
                    height: 16
                }

                Ghost {
                    name: "LFDQueueFrameSpecificListButton1LockedIndicator"
                    x: 31
                    y: 8
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

            ScrollFrame {
                name: "LFDQueueFrameSpecificListScrollFrame"
                anchors.left: lFDQueueFrameSpecificListButton1.left
                anchors.top: lFDQueueFrameSpecificListButton1.top
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
                    style: "ScrollBar"
                    anchors.left: parent.right
                    anchors.leftMargin: 6
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    width: 16
                    height: 238

                    Frame {
                        name: "LFDQueueFrameSpecificListScrollFrameScrollBarDiabolicTrack"
                        anchors.horizontalCenter: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.horizontalCenter
                        anchors.top: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton.top
                        anchors.topMargin: -1
                        width: 18
                        height: 272
                    }

                    Button {
                        name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        width: 16
                        height: 16
                    }

                    Button {
                        id: lFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton
                        name: "LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        width: 16
                        height: 16
                    }
                }

                Frame {
                    name: "LFDQueueFrameSpecificListScrollFrameScrollChildFrame"
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
