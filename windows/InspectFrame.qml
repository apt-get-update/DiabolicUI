// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "InspectFrame"
    width: 384
    height: 512

    Frame {
        name: "InspectFrameDiabolic"
        wowParent: "InspectFrame"
        anchors.left: parent.left
        anchors.leftMargin: -19
        anchors.top: parent.top
        anchors.topMargin: -28
        width: 402
        height: 531

        Button {
            name: "InspectFrameCloseButton"
            wowParent: "InspectFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "InspectFrameDiabolicBorder"
            wowParent: "InspectFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 402
            height: 499

            Frame {
                name: "InspectFrameDiabolicTitlePlate"
                wowParent: "InspectFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "InspectNameText"
                    text: "Wolvenblood"
                    wowParent: "InspectFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 123.3
                    height: 14.2
                }
            }
        }

        Frame {
            name: "InspectFrameDiabolicRail"
            wowParent: "InspectFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 188
            height: 18
        }

        Frame {
            name: "InspectFrameDiabolicSocket"
            wowParent: "InspectFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "InspectFrameTab1"
            text: "Character"
            wowParent: "InspectFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "InspectFrameTab2"
            text: "PvP"
            wowParent: "InspectFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "InspectFrameTab3"
            text: "Talents"
            wowParent: "InspectFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 144
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Frame {
        name: "InspectNameFrame"
        wowParent: "InspectFrame"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 109
        height: 12
    }

    Frame {
        name: "InspectPVPFrame"
        wowParent: "InspectFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "InspectPaperDollFrame"
        wowParent: "InspectFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "InspectHandsSlot"
            wowParent: "InspectPaperDollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 305
            anchors.top: parent.top
            anchors.topMargin: 74
            width: 37
            height: 37

            Button {
                name: "InspectWaistSlot"
                wowParent: "InspectPaperDollFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "InspectLegsSlot"
                    wowParent: "InspectPaperDollFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 4
                    width: 37
                    height: 37

                    Button {
                        name: "InspectFeetSlot"
                        wowParent: "InspectPaperDollFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 4
                        width: 37
                        height: 37

                        Button {
                            name: "InspectFinger0Slot"
                            wowParent: "InspectPaperDollFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 4
                            width: 37
                            height: 37

                            Button {
                                name: "InspectFinger1Slot"
                                wowParent: "InspectPaperDollFrame"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 4
                                width: 37
                                height: 37

                                Button {
                                    name: "InspectTrinket0Slot"
                                    wowParent: "InspectPaperDollFrame"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 4
                                    width: 37
                                    height: 37

                                    Button {
                                        name: "InspectTrinket1Slot"
                                        wowParent: "InspectPaperDollFrame"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 4
                                        width: 37
                                        height: 37
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Button {
            name: "InspectHeadSlot"
            wowParent: "InspectPaperDollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 21
            anchors.top: parent.top
            anchors.topMargin: 74
            width: 37
            height: 37

            Button {
                name: "InspectNeckSlot"
                wowParent: "InspectPaperDollFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "InspectShoulderSlot"
                    wowParent: "InspectPaperDollFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 4
                    width: 37
                    height: 37

                    Button {
                        name: "InspectBackSlot"
                        wowParent: "InspectPaperDollFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 4
                        width: 37
                        height: 37

                        Button {
                            name: "InspectChestSlot"
                            wowParent: "InspectPaperDollFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 4
                            width: 37
                            height: 37

                            Button {
                                name: "InspectShirtSlot"
                                wowParent: "InspectPaperDollFrame"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 4
                                width: 37
                                height: 37

                                Button {
                                    name: "InspectTabardSlot"
                                    wowParent: "InspectPaperDollFrame"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 4
                                    width: 37
                                    height: 37

                                    Button {
                                        name: "InspectWristSlot"
                                        wowParent: "InspectPaperDollFrame"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 4
                                        width: 37
                                        height: 37
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Button {
            name: "InspectMainHandSlot"
            wowParent: "InspectPaperDollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 122
            anchors.top: parent.bottom
            anchors.topMargin: -127
            width: 37
            height: 37

            Button {
                name: "InspectSecondaryHandSlot"
                wowParent: "InspectPaperDollFrame"
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.top: parent.top
                width: 37
                height: 37

                Button {
                    name: "InspectRangedSlot"
                    wowParent: "InspectPaperDollFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    width: 37
                    height: 37
                }
            }
        }

        PlayerModel {
            name: "InspectModelFrame"
            wowParent: "InspectPaperDollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 78
            width: 233
            height: 300

            // the level line (the guild's under it) out of the band, over the model
            FontString {
                name: "InspectLevelText"
                text: "Level 61 Human Warrior"
                wowParent: "InspectPaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: 22
                width: 218.1
                height: 14.2
            }

            Button {
                name: "InspectModelRotateLeftButton"
                wowParent: "InspectModelFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 35
                height: 35

                Button {
                    name: "InspectModelRotateRightButton"
                    wowParent: "InspectModelFrame"
                    anchors.left: parent.right
                    anchors.top: parent.top
                    width: 35
                    height: 35
                }
            }
        }
    }

    Frame {
        name: "InspectTalentFrame"
        wowParent: "InspectFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "InspectTalentFrameCloseButton"
            wowParent: "InspectTalentFrame"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -44
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 25
            width: 32
            height: 32
        }

        Frame {
            name: "InspectTalentFramePointsBar"
            wowParent: "InspectTalentFrame"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 162
            width: 332
            height: 26

            FontString {
                name: "InspectTalentFrameSpentPointsText"
                wowParent: "InspectTalentFramePointsBar"
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 77.4
                height: 15
            }

            FontString {
                name: "InspectTalentFrameTalentPointsText"
                wowParent: "InspectTalentFramePointsBar"
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 98.8
                height: 15
            }
        }

        ScrollFrame {
            name: "InspectTalentFrameScrollFrame"
            wowParent: "InspectTalentFrame"
            anchors.right: parent.right
            anchors.rightMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 77
            width: 296
            height: 328

            Frame {
                name: "InspectTalentFrameScrollChildFrame"
                wowParent: "InspectTalentFrameScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 320
                height: 50

                Frame {
                    name: "InspectTalentFrameArrowFrame"
                    wowParent: "InspectTalentFrameScrollChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 320
                    height: 50
                }

                Button {
                    name: "InspectTalentFrameTalent1"
                    wowParent: "InspectTalentFrameScrollChildFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    width: 37
                    height: 37
                }
            }

            Frame {
                name: "InspectTalentFrameScrollFrameDiabolicZone"
                wowParent: "InspectTalentFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 330
                height: 340
            }

            Slider {
                name: "InspectTalentFrameScrollFrameScrollBar"
                wowParent: "InspectTalentFrameScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 296

                Button {
                    name: "InspectTalentFrameScrollFrameScrollBarScrollDownButton"
                    wowParent: "InspectTalentFrameScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "InspectTalentFrameScrollFrameScrollBarScrollUpButton"
                    wowParent: "InspectTalentFrameScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "InspectTalentFrameScrollFrameScrollBarDiabolicTrack"
                        wowParent: "InspectTalentFrameScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 330
                    }
                }
            }

            Button {
                name: "InspectTalentFrameTab1"
                text: "Arms"
                wowParent: "InspectTalentFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.bottom: parent.top
                anchors.bottomMargin: 12
                width: 28
                height: 28

                Button {
                    name: "InspectTalentFrameTab2"
                    text: "Fury"
                    wowParent: "InspectTalentFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    width: 28
                    height: 28

                    Button {
                        name: "InspectTalentFrameTab3"
                        text: "Protection"
                        wowParent: "InspectTalentFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 6
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28
                        height: 28
                    }
                }
            }
        }
    }

    Ghost {
        name: "InspectPVPFrameBackground"
        x: 14
        y: 36
        width: 0
        height: 512

        Frame {
            name: "InspectPVPFrameArena"
            wowParent: "InspectPVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: parent.top
            anchors.topMargin: 95
            width: 300
            height: 20

            FontString {
                name: "InspectPVPFrameArenaLabel"
                text: "ARENA:"
                wowParent: "InspectPVPFrameArena"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 41.9
                height: 10.3
            }
        }

        Frame {
            name: "InspectPVPFrameHonor"
            wowParent: "InspectPVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 118
            anchors.top: parent.top
            anchors.topMargin: 2
            width: 300
            height: 20

            FontString {
                name: "InspectPVPFrameHonorLabel"
                text: "HONOR:"
                wowParent: "InspectPVPFrameHonor"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 47.4
                height: 10.3
            }
        }

        Frame {
            name: "InspectPVPHonor"
            wowParent: "InspectPVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 28
            width: 300
            height: 100

            FontString {
                name: "InspectPVPHonorKillsLabel"
                text: "Kills"
                wowParent: "InspectPVPHonor"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 24
                width: 22.9
                height: 10.3

                FontString {
                    name: "InspectPVPHonorHonorLabel"
                    text: "Honor"
                    wowParent: "InspectPVPHonor"
                    anchors.right: parent.right
                    anchors.top: parent.bottom
                    anchors.topMargin: 10
                    width: 34.8
                    height: 10.3
                }

                FontString {
                    name: "InspectPVPHonorTodayLabel"
                    text: "Today"
                    wowParent: "InspectPVPHonor"
                    anchors.left: parent.right
                    anchors.leftMargin: 30
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 10
                    width: 34.8
                    height: 10.3

                    FontString {
                        name: "InspectPVPHonorTodayKills"
                        text: "0"
                        wowParent: "InspectPVPHonor"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        width: 7.9
                        height: 10.3

                        FontString {
                            name: "InspectPVPHonorTodayHonor"
                            text: "0"
                            wowParent: "InspectPVPHonor"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            width: 7.9
                            height: 14
                        }
                    }

                    FontString {
                        name: "InspectPVPHonorYesterdayLabel"
                        text: "Yesterday"
                        wowParent: "InspectPVPHonor"
                        anchors.left: parent.right
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        width: 53.7
                        height: 10.3

                        FontString {
                            name: "InspectPVPHonorLifetimeLabel"
                            text: "Lifetime"
                            wowParent: "InspectPVPHonor"
                            anchors.left: parent.right
                            anchors.leftMargin: 30
                            anchors.verticalCenter: parent.verticalCenter
                            width: 45
                            height: 10.3

                            FontString {
                                name: "InspectPVPHonorLifetimeKills"
                                text: "30"
                                wowParent: "InspectPVPHonor"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.bottom
                                anchors.topMargin: 10
                                width: 15
                                height: 10.3

                                FontString {
                                    name: "InspectPVPHonorLifetimeHonor"
                                    text: "-"
                                    wowParent: "InspectPVPHonor"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 10
                                    width: 5.5
                                    height: 10.3
                                }
                            }
                        }

                        FontString {
                            name: "InspectPVPHonorYesterdayKills"
                            text: "0"
                            wowParent: "InspectPVPHonor"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            width: 7.9
                            height: 10.3

                            FontString {
                                name: "InspectPVPHonorYesterdayHonor"
                                text: "0"
                                wowParent: "InspectPVPHonor"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.bottom
                                anchors.topMargin: 10
                                width: 7.9
                                height: 10.3
                            }
                        }
                    }
                }
            }
        }

        Frame {
            name: "InspectPVPTeam1Standard"
            wowParent: "InspectPVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -85
            width: 64
            height: 64

            Button {
                name: "InspectPVPTeam1"
                wowParent: "InspectPVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "InspectPVPTeam1TeamType"
                    text: "(2v2)"
                    wowParent: "InspectPVPTeam1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }
        }

        Frame {
            name: "InspectPVPTeam2Standard"
            wowParent: "InspectPVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            width: 64
            height: 64

            Button {
                name: "InspectPVPTeam2"
                wowParent: "InspectPVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "InspectPVPTeam2TeamType"
                    text: "(3v3)"
                    wowParent: "InspectPVPTeam2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }
        }

        Frame {
            name: "InspectPVPTeam3Standard"
            wowParent: "InspectPVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 85
            width: 64
            height: 64

            Button {
                name: "InspectPVPTeam3"
                wowParent: "InspectPVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "InspectPVPTeam3TeamType"
                    text: "(5v5)"
                    wowParent: "InspectPVPTeam3"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }
        }
    }

    Ghost {
        name: "InspectTalentFrameTalent1RankBorder"
        x: 158
        y: -239.6
        width: 0
        height: 0

        FontString {
            name: "InspectTalentFrameTalent1Rank"
            text: "5"
            wowParent: "InspectTalentFrameTalent1"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 7.9
            height: 10.3
        }
    }
}
