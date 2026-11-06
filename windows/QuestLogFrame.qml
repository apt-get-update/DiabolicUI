// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "QuestLogFrame"
    width: 682
    height: 447

    Frame {
        name: "QuestLogCount"
        wowParent: "QuestLogFrame"
        anchors.left: parent.left
        anchors.leftMargin: 80
        anchors.top: parent.top
        anchors.topMargin: 41
        width: 92.4
        height: 20
    }

    Button {
        name: "QuestLogFrameCancelButton"
        text: "Close"
        wowParent: "QuestLogFrame"
        anchors.right: parent.right
        anchors.rightMargin: 7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
        width: 80
        height: 22

        FontString {
            name: "QuestLogFrameCancelButtonText"
            text: "Close"
            wowParent: "QuestLogFrameCancelButton"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 34.8
            height: 11.9
        }
    }

    Frame {
        name: "QuestLogFrameDiabolic"
        wowParent: "QuestLogFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -36
        width: 752
        height: 463

        Frame {
            name: "QuestLogControlPanel"
            wowParent: "QuestLogFrame"
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 28
            width: 321
            height: 26

            Button {
                name: "QuestLogFrameAbandonButton"
                text: "Abandon"
                wowParent: "QuestLogControlPanel"
                style: "Button"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 110
                height: 21

                FontString {
                    name: "QuestLogFrameAbandonButtonText"
                    text: "Abandon"
                    wowParent: "QuestLogFrameAbandonButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 64.8
                    height: 11.9
                }

                Frame {
                    name: "QuestLogFrameDiabolicFoot"
                    wowParent: "QuestLogFrameDiabolic"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 291
                    anchors.top: parent.top
                    anchors.topMargin: -6
                    width: 706
                    height: 35.5
                }

                Button {
                    name: "QuestLogFramePushQuestButton"
                    text: "Share"
                    wowParent: "QuestLogControlPanel"
                    style: "Button"
                    anchors.left: parent.right
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    width: 96
                    height: 21

                    FontString {
                        name: "QuestLogFramePushQuestButtonText"
                        text: "Share"
                        wowParent: "QuestLogFramePushQuestButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 41.1
                        height: 11.9
                    }
                }
            }

            Button {
                name: "QuestLogFrameTrackButton"
                text: "Track"
                wowParent: "QuestLogControlPanel"
                style: "Button"
                anchors.right: parent.right
                anchors.rightMargin: 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 100
                height: 21

                FontString {
                    name: "QuestLogFrameTrackButtonText"
                    text: "Track"
                    wowParent: "QuestLogFrameTrackButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 43.5
                    height: 11.9
                }
            }
        }

        ScrollFrame {
            name: "QuestLogDetailScrollFrame"
            wowParent: "QuestLogFrame"
            anchors.right: parent.right
            anchors.rightMargin: 74
            anchors.top: parent.top
            anchors.topMargin: 44
            width: 298
            height: 336

            Frame {
                name: "QuestLogDetailScrollChildFrame"
                wowParent: "QuestLogDetailScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 298
                height: 333

                FontString {
                    name: "QuestInfoTitleHeader"
                    text: "All Things in Good Time"
                    wowParent: "QuestLogDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    width: 285
                    height: 15.8

                    FontString {
                        name: "QuestInfoObjectivesText"
                        wowParent: "QuestLogDetailScrollChildFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 5
                        width: 285
                        height: 88.5

                        Frame {
                            name: "QuestInfoObjectivesFrame"
                            wowParent: "QuestLogDetailScrollChildFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            width: 285
                            height: 10

                            FontString {
                                name: "QuestInfoObjective1"
                                text: "Ahn'kahar Watcher Corpse Burned: 0/1"
                                wowParent: "QuestInfoObjectivesFrame"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                width: 285
                                height: 11.9

                                FontString {
                                    name: "QuestInfoDescriptionHeader"
                                    text: "Description"
                                    wowParent: "QuestLogDetailScrollChildFrame"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 10
                                    width: 285
                                    height: 15.8

                                    FontString {
                                        name: "QuestInfoDescriptionText"
                                        wowParent: "QuestLogDetailScrollChildFrame"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 5
                                        width: 285
                                        height: 202.3

                                        Frame {
                                            name: "QuestInfoRewardsFrame"
                                            wowParent: "QuestLogDetailScrollChildFrame"
                                            anchors.left: parent.left
                                            anchors.top: parent.bottom
                                            anchors.topMargin: 10
                                            width: 285
                                            height: 10

                                            FontString {
                                                name: "QuestInfoRewardsHeader"
                                                text: "Rewards"
                                                wowParent: "QuestInfoRewardsFrame"
                                                anchors.left: parent.left
                                                anchors.top: parent.top
                                                width: 285
                                                height: 15.8

                                                FontString {
                                                    name: "QuestInfoItemReceiveText"
                                                    text: "You will receive:"
                                                    wowParent: "QuestInfoRewardsFrame"
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 3
                                                    anchors.top: parent.bottom
                                                    anchors.topMargin: 5
                                                    width: 106.7
                                                    height: 12.6

                                                    Frame {
                                                        name: "QuestInfoMoneyFrame"
                                                        wowParent: "QuestInfoRewardsFrame"
                                                        anchors.left: parent.right
                                                        anchors.leftMargin: 15
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        width: 91
                                                        height: 28
                                                    }

                                                    Frame {
                                                        name: "QuestInfoSpacerFrame"
                                                        wowParent: "QuestLogDetailScrollChildFrame"
                                                        anchors.left: parent.left
                                                        anchors.top: parent.bottom
                                                        anchors.topMargin: 10
                                                        width: 5
                                                        height: 5
                                                    }

                                                    Frame {
                                                        name: "QuestInfoXPFrame"
                                                        wowParent: "QuestInfoRewardsFrame"
                                                        anchors.left: parent.left
                                                        anchors.top: parent.bottom
                                                        anchors.topMargin: 5
                                                        width: 280
                                                        height: 20

                                                        FontString {
                                                            name: "QuestInfoXPFrameReceiveText"
                                                            text: "Experience:"
                                                            wowParent: "QuestInfoXPFrame"
                                                            anchors.left: parent.left
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            width: 74.3
                                                            height: 12.6

                                                            FontString {
                                                                name: "QuestInfoXPFramePoints"
                                                                text: "10050"
                                                                wowParent: "QuestInfoXPFrame"
                                                                anchors.left: parent.right
                                                                anchors.leftMargin: 15
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
                        }
                    }
                }
            }

            Frame {
                name: "QuestLogDetailScrollFrameDiabolicPanel"
                wowParent: "QuestLogFrame"
                anchors.left: parent.left
                anchors.leftMargin: -16
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 362
                height: 348
            }

            Frame {
                name: "QuestLogDetailScrollFrameDiabolicParchment"
                wowParent: "QuestLogDetailScrollFrame"
                anchors.left: parent.left
                anchors.leftMargin: -14
                anchors.top: parent.top
                anchors.topMargin: -4
                width: 336
                height: 344
            }

            Slider {
                name: "QuestLogDetailScrollFrameScrollBar"
                wowParent: "QuestLogDetailScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 26
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 304

                Button {
                    name: "QuestLogDetailScrollFrameScrollBarScrollDownButton"
                    wowParent: "QuestLogDetailScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "QuestLogDetailScrollFrameScrollBarScrollUpButton"
                    wowParent: "QuestLogDetailScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "QuestLogDetailScrollFrameScrollBarDiabolicTrack"
                        wowParent: "QuestLogDetailScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 338
                    }
                }
            }
        }

        Button {
            name: "QuestLogFrameCloseButton"
            wowParent: "QuestLogFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "QuestLogFrameDiabolicBorder"
            wowParent: "QuestLogFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 752
            height: 463

            Frame {
                name: "QuestLogFrameDiabolicTitlePlate"
                wowParent: "QuestLogFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "QuestLogTitleText"
                    text: "Quest Log  23/25"
                    wowParent: "QuestLogFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 145.4
                    height: 14.2
                }
            }
        }

        Frame {
            name: "QuestLogFrameDiabolicSocket"
            wowParent: "QuestLogFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }

        ScrollFrame {
            name: "QuestLogScrollFrame"
            wowParent: "QuestLogFrame"
            pin: "all"
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 40
            width: 305
            height: 340

            Frame {
                name: "QuestLogScrollFrameDiabolicZone"
                wowParent: "QuestLogScrollFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 333
                height: 350
            }

            Slider {
                name: "QuestLogScrollFrameScrollBar"
                wowParent: "QuestLogScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.top: parent.top
                anchors.topMargin: 13
                width: 20
                height: 313

                Button {
                    name: "QuestLogScrollFrameScrollBarScrollDownButton"
                    wowParent: "QuestLogScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -2
                    width: 16
                    height: 16
                }

                Button {
                    name: "QuestLogScrollFrameScrollBarScrollUpButton"
                    wowParent: "QuestLogScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: -2
                    width: 16
                    height: 16

                    Frame {
                        name: "QuestLogScrollFrameScrollBarDiabolicTrack"
                        wowParent: "QuestLogScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 343
                    }
                }
            }

            Frame {
                name: "QuestLogScrollFrameScrollChild"
                wowParent: "QuestLogScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 305
                height: 352

                Button {
                    name: "QuestLogScrollFrameButton1"
                    text: "Ahn'kahet: The Old Kingdom"
                    wowParent: "QuestLogScrollFrameScrollChild"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 299
                    height: 16

                    FontString {
                        name: "QuestLogScrollFrameButton1NormalText"
                        text: "Ahn'kahet: The Old Kingdom"
                        wowParent: "QuestLogScrollFrameButton1"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        width: 171.5
                        height: 10
                    }
                }
            }
        }
    }

    Ghost {
        name: "QuestInfoMoneyFrameCopperButton"
        x: 587.7
        y: 414.3
        width: 0
        height: 0

        Button {
            name: "QuestInfoMoneyFrameSilverButton"
            text: "6"
            wowParent: "QuestInfoMoneyFrame"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 30.1
            height: 19

            Button {
                name: "QuestInfoMoneyFrameGoldButton"
                text: "42"
                wowParent: "QuestInfoMoneyFrame"
                anchors.right: parent.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 38
                height: 19

                FontString {
                    name: "QuestInfoMoneyFrameGoldButtonText"
                    text: "42"
                    wowParent: "QuestInfoMoneyFrameGoldButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 19
                    anchors.verticalCenter: parent.verticalCenter
                    width: 19
                    height: 15.8
                }
            }

            FontString {
                name: "QuestInfoMoneyFrameSilverButtonText"
                text: "6"
                wowParent: "QuestInfoMoneyFrameSilverButton"
                anchors.right: parent.right
                anchors.rightMargin: 19
                anchors.verticalCenter: parent.verticalCenter
                width: 11.1
                height: 15.8
            }
        }
    }

    Ghost {
        name: "QuestLogCountTopRight"
        x: 164.4
        y: 48.9
        width: 0
        height: 0

        FontString {
            name: "QuestLogQuestCount"
            wowParent: "QuestLogCount"
            anchors.right: parent.left
            anchors.rightMargin: -1
            anchors.top: parent.bottom
            anchors.topMargin: -3
            width: 77.4
            height: 10.3
        }
    }

    Ghost {
        name: "QuestLogScrollFrameButton2"
        x: 30
        y: 20
        width: 299
        height: 16

        Frame {
            name: "QuestLogHighlightFrame"
            wowParent: "QuestLogScrollFrameButton2"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 299
            height: 16
        }

        FontString {
            name: "QuestLogScrollFrameButton2Tag"
            text: "(Daily Heroic)"
            wowParent: "QuestLogScrollFrameButton2"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            width: 80.6
            height: 16
        }
    }
}
