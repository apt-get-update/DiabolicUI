// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "InspectFrame"
    width: 384
    height: 512

    Frame {
        id: inspectFrameDiabolic
        name: "InspectFrameDiabolic"
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
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 188
            height: 18
        }

        Frame {
            name: "InspectFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }
    }

    Button {
        name: "InspectFrameTab1"
        text: "Character"
        style: "Banner"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "InspectFrameTab2"
        text: "PvP"
        style: "Banner"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "InspectFrameTab3"
        text: "Talents"
        style: "Banner"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        name: "InspectNameFrame"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 109
        height: 12
    }

    Frame {
        name: "InspectPVPFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

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
                    name: "InspectPVPHonorHonorLabel"
                    text: "Honor"
                    anchors.right: inspectPVPHonorKillsLabel.right
                    anchors.top: inspectPVPHonorKillsLabel.bottom
                    anchors.topMargin: 10
                    width: 34.8
                    height: 10.3
                }

                FontString {
                    id: inspectPVPHonorKillsLabel
                    name: "InspectPVPHonorKillsLabel"
                    text: "Kills"
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    anchors.top: parent.top
                    anchors.topMargin: 24
                    width: 22.9
                    height: 10.3
                }

                FontString {
                    name: "InspectPVPHonorLifetimeHonor"
                    text: "-"
                    anchors.horizontalCenter: inspectPVPHonorLifetimeKills.horizontalCenter
                    anchors.top: inspectPVPHonorLifetimeKills.bottom
                    anchors.topMargin: 10
                    width: 5.5
                    height: 10.3
                }

                FontString {
                    id: inspectPVPHonorLifetimeKills
                    name: "InspectPVPHonorLifetimeKills"
                    text: "30"
                    anchors.horizontalCenter: inspectPVPHonorLifetimeLabel.horizontalCenter
                    anchors.top: inspectPVPHonorLifetimeLabel.bottom
                    anchors.topMargin: 10
                    width: 15
                    height: 10.3
                }

                FontString {
                    id: inspectPVPHonorLifetimeLabel
                    name: "InspectPVPHonorLifetimeLabel"
                    text: "Lifetime"
                    anchors.left: inspectPVPHonorYesterdayLabel.right
                    anchors.leftMargin: 30
                    anchors.verticalCenter: inspectPVPHonorYesterdayLabel.verticalCenter
                    width: 45
                    height: 10.3
                }

                FontString {
                    name: "InspectPVPHonorTodayHonor"
                    text: "0"
                    anchors.horizontalCenter: inspectPVPHonorTodayKills.horizontalCenter
                    anchors.top: inspectPVPHonorTodayKills.bottom
                    anchors.topMargin: 10
                    width: 7.9
                    height: 14
                }

                FontString {
                    id: inspectPVPHonorTodayKills
                    name: "InspectPVPHonorTodayKills"
                    text: "0"
                    anchors.horizontalCenter: inspectPVPHonorTodayLabel.horizontalCenter
                    anchors.top: inspectPVPHonorTodayLabel.bottom
                    anchors.topMargin: 10
                    width: 7.9
                    height: 10.3
                }

                FontString {
                    id: inspectPVPHonorTodayLabel
                    name: "InspectPVPHonorTodayLabel"
                    text: "Today"
                    anchors.left: inspectPVPHonorKillsLabel.right
                    anchors.leftMargin: 30
                    anchors.bottom: inspectPVPHonorKillsLabel.top
                    anchors.bottomMargin: 10
                    width: 34.8
                    height: 10.3
                }

                FontString {
                    name: "InspectPVPHonorYesterdayHonor"
                    text: "0"
                    anchors.horizontalCenter: inspectPVPHonorYesterdayKills.horizontalCenter
                    anchors.top: inspectPVPHonorYesterdayKills.bottom
                    anchors.topMargin: 10
                    width: 7.9
                    height: 10.3
                }

                FontString {
                    id: inspectPVPHonorYesterdayKills
                    name: "InspectPVPHonorYesterdayKills"
                    text: "0"
                    anchors.horizontalCenter: inspectPVPHonorYesterdayLabel.horizontalCenter
                    anchors.top: inspectPVPHonorYesterdayLabel.bottom
                    anchors.topMargin: 10
                    width: 7.9
                    height: 10.3
                }

                FontString {
                    id: inspectPVPHonorYesterdayLabel
                    name: "InspectPVPHonorYesterdayLabel"
                    text: "Yesterday"
                    anchors.left: inspectPVPHonorTodayLabel.right
                    anchors.leftMargin: 30
                    anchors.verticalCenter: inspectPVPHonorTodayLabel.verticalCenter
                    width: 53.7
                    height: 10.3
                }
            }

            Button {
                name: "InspectPVPTeam1"
                wowParent: "InspectPVPFrame"
                anchors.left: inspectPVPTeam1Standard.left
                anchors.leftMargin: 33
                anchors.verticalCenter: inspectPVPTeam1Standard.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "InspectPVPTeam1TeamType"
                    text: "(2v2)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }

            Frame {
                id: inspectPVPTeam1Standard
                name: "InspectPVPTeam1Standard"
                wowParent: "InspectPVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -85
                width: 64
                height: 64
            }

            Button {
                name: "InspectPVPTeam2"
                wowParent: "InspectPVPFrame"
                anchors.left: inspectPVPTeam2Standard.left
                anchors.leftMargin: 33
                anchors.verticalCenter: inspectPVPTeam2Standard.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "InspectPVPTeam2TeamType"
                    text: "(3v3)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }

            Frame {
                id: inspectPVPTeam2Standard
                name: "InspectPVPTeam2Standard"
                wowParent: "InspectPVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                width: 64
                height: 64
            }

            Button {
                name: "InspectPVPTeam3"
                wowParent: "InspectPVPFrame"
                anchors.left: inspectPVPTeam3Standard.left
                anchors.leftMargin: 33
                anchors.verticalCenter: inspectPVPTeam3Standard.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "InspectPVPTeam3TeamType"
                    text: "(5v5)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }

            Frame {
                id: inspectPVPTeam3Standard
                name: "InspectPVPTeam3Standard"
                wowParent: "InspectPVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 85
                width: 64
                height: 64
            }
        }
    }

    Frame {
        name: "InspectPaperDollFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            id: inspectBackSlot
            name: "InspectBackSlot"
            anchors.left: inspectShoulderSlot.left
            anchors.top: inspectShoulderSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectChestSlot
            name: "InspectChestSlot"
            anchors.left: inspectBackSlot.left
            anchors.top: inspectBackSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectFeetSlot
            name: "InspectFeetSlot"
            anchors.left: inspectLegsSlot.left
            anchors.top: inspectLegsSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectFinger0Slot
            name: "InspectFinger0Slot"
            anchors.left: inspectFeetSlot.left
            anchors.top: inspectFeetSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectFinger1Slot
            name: "InspectFinger1Slot"
            anchors.left: inspectFinger0Slot.left
            anchors.top: inspectFinger0Slot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectHandsSlot
            name: "InspectHandsSlot"
            anchors.left: parent.left
            anchors.leftMargin: 305
            anchors.top: parent.top
            anchors.topMargin: 74
            width: 37
            height: 37
        }

        Button {
            id: inspectHeadSlot
            name: "InspectHeadSlot"
            anchors.left: parent.left
            anchors.leftMargin: 21
            anchors.top: parent.top
            anchors.topMargin: 74
            width: 37
            height: 37
        }

        Button {
            id: inspectLegsSlot
            name: "InspectLegsSlot"
            anchors.left: inspectWaistSlot.left
            anchors.top: inspectWaistSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        // the level line (the guild's under it) out of the band, over the model
        FontString {
            name: "InspectLevelText"
            text: "Level 61 Human Warrior"
            pin: "place"
            anchors.horizontalCenter: inspectModelFrame.horizontalCenter
            anchors.bottom: inspectModelFrame.top
            anchors.bottomMargin: 22
            width: 218.1
            height: 14.2
        }

        Button {
            id: inspectMainHandSlot
            name: "InspectMainHandSlot"
            anchors.left: parent.left
            anchors.leftMargin: 122
            anchors.top: parent.bottom
            anchors.topMargin: -127
            width: 37
            height: 37
        }

        PlayerModel {
            id: inspectModelFrame
            name: "InspectModelFrame"
            anchors.left: parent.left
            anchors.leftMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 78
            width: 233
            height: 300

            Button {
                id: inspectModelRotateLeftButton
                name: "InspectModelRotateLeftButton"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 35
                height: 35
            }

            Button {
                name: "InspectModelRotateRightButton"
                anchors.left: inspectModelRotateLeftButton.right
                anchors.top: inspectModelRotateLeftButton.top
                width: 35
                height: 35
            }
        }

        Button {
            id: inspectNeckSlot
            name: "InspectNeckSlot"
            anchors.left: inspectHeadSlot.left
            anchors.top: inspectHeadSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            name: "InspectRangedSlot"
            anchors.left: inspectSecondaryHandSlot.right
            anchors.leftMargin: 5
            anchors.top: inspectSecondaryHandSlot.top
            width: 37
            height: 37
        }

        Button {
            id: inspectSecondaryHandSlot
            name: "InspectSecondaryHandSlot"
            anchors.left: inspectMainHandSlot.right
            anchors.leftMargin: 5
            anchors.top: inspectMainHandSlot.top
            width: 37
            height: 37
        }

        Button {
            id: inspectShirtSlot
            name: "InspectShirtSlot"
            anchors.left: inspectChestSlot.left
            anchors.top: inspectChestSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectShoulderSlot
            name: "InspectShoulderSlot"
            anchors.left: inspectNeckSlot.left
            anchors.top: inspectNeckSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectTabardSlot
            name: "InspectTabardSlot"
            anchors.left: inspectShirtSlot.left
            anchors.top: inspectShirtSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectTrinket0Slot
            name: "InspectTrinket0Slot"
            anchors.left: inspectFinger1Slot.left
            anchors.top: inspectFinger1Slot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            name: "InspectTrinket1Slot"
            anchors.left: inspectTrinket0Slot.left
            anchors.top: inspectTrinket0Slot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            id: inspectWaistSlot
            name: "InspectWaistSlot"
            anchors.left: inspectHandsSlot.left
            anchors.top: inspectHandsSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }

        Button {
            name: "InspectWristSlot"
            anchors.left: inspectTabardSlot.left
            anchors.top: inspectTabardSlot.bottom
            anchors.topMargin: 4
            width: 37
            height: 37
        }
    }

    Frame {
        name: "InspectTalentFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "InspectTalentFrameCloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -44
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 25
            width: 32
            height: 32
        }

        Frame {
            name: "InspectTalentFramePointsBar"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 162
            width: 332
            height: 26

            FontString {
                name: "InspectTalentFrameSpentPointsText"
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 77.4
                height: 15
            }

            FontString {
                name: "InspectTalentFrameTalentPointsText"
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 98.8
                height: 15
            }
        }

        ScrollFrame {
            id: inspectTalentFrameScrollFrame
            name: "InspectTalentFrameScrollFrame"
            anchors.right: parent.right
            anchors.rightMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 77
            width: 296
            height: 328

            Frame {
                name: "InspectTalentFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 320
                height: 50

                Frame {
                    name: "InspectTalentFrameArrowFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 320
                    height: 50
                }

                Button {
                    name: "InspectTalentFrameTalent1"
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    width: 37
                    height: 37

                    Ghost {
                        name: "InspectTalentFrameTalent1RankBorder"
                        x: 99.9
                        y: -336.6
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
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 296

                Frame {
                    name: "InspectTalentFrameScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: inspectTalentFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: inspectTalentFrameScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 330
                }

                Button {
                    name: "InspectTalentFrameScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: inspectTalentFrameScrollFrameScrollBarScrollUpButton
                    name: "InspectTalentFrameScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }
        }

        Button {
            id: inspectTalentFrameTab1
            name: "InspectTalentFrameTab1"
            text: "Arms"
            pin: "place"
            anchors.left: inspectTalentFrameScrollFrame.left
            anchors.leftMargin: -6
            anchors.bottom: inspectTalentFrameScrollFrame.top
            anchors.bottomMargin: 12
            width: 28
            height: 28
        }

        Button {
            id: inspectTalentFrameTab2
            name: "InspectTalentFrameTab2"
            text: "Fury"
            pin: "place"
            anchors.left: inspectTalentFrameTab1.right
            anchors.leftMargin: 6
            anchors.verticalCenter: inspectTalentFrameTab1.verticalCenter
            width: 28
            height: 28
        }

        Button {
            name: "InspectTalentFrameTab3"
            text: "Protection"
            pin: "place"
            anchors.left: inspectTalentFrameTab2.right
            anchors.leftMargin: 6
            anchors.verticalCenter: inspectTalentFrameTab2.verticalCenter
            width: 28
            height: 28
        }
    }
}
