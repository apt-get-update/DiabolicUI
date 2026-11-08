// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "PVPParentFrame"
    width: 384
    height: 512

    Frame {
        name: "PVPBattlegroundFrame"
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 1
        width: 384
        height: 512

        // the battlegrounds' block (title row, list, rewards) 5 left: in the middle
        Button {
            id: battlegroundType1
            name: "BattlegroundType1"
            text: "Random Battleground"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.top
            anchors.topMargin: 79
            width: 295
            height: 16

            FontString {
                name: "BattlegroundType1Text"
                text: "Random Battleground"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 130.4
                height: 11.9
            }
        }

        Button {
            id: battlegroundType2
            name: "BattlegroundType2"
            text: "Arathi Basin (Call to Arms)"
            anchors.left: battlegroundType1.left
            anchors.top: battlegroundType1.bottom
            width: 295
            height: 16

            FontString {
                name: "BattlegroundType2Text"
                text: "Arathi Basin (Call to Arms)"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 155.7
                height: 11.9
            }
        }

        Button {
            id: battlegroundType3
            name: "BattlegroundType3"
            text: "Warsong Gulch"
            anchors.left: battlegroundType2.left
            anchors.top: battlegroundType2.bottom
            width: 295
            height: 16

            FontString {
                name: "BattlegroundType3Text"
                text: "Warsong Gulch"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 91.7
                height: 11.9
            }
        }

        Button {
            id: battlegroundType4
            name: "BattlegroundType4"
            text: "Alterac Valley"
            anchors.left: battlegroundType3.left
            anchors.top: battlegroundType3.bottom
            width: 295
            height: 16

            FontString {
                name: "BattlegroundType4Text"
                text: "Alterac Valley"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 83
                height: 11.9
            }
        }

        Button {
            name: "BattlegroundType5"
            text: "Eye of the Storm"
            anchors.left: battlegroundType4.left
            anchors.top: battlegroundType4.bottom
            width: 295
            height: 16

            FontString {
                name: "BattlegroundType5Text"
                text: "Eye of the Storm"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 99.6
                height: 11.9
            }
        }

        FontString {
            name: "PVPBattlegroundFrameFrameLabel"
            text: "Battlegrounds"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 17
            width: 84.5
            height: 11.9
        }

        // the rewards 208 high (Blizzard's 232): 6 over the foot's iron bar, 6 under the list
        ScrollFrame {
            name: "PVPBattlegroundFrameInfoScrollFrame"
            pin: "all"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 122
            width: 298
            height: 208

            Frame {
                name: "PVPBattlegroundFrameInfoScrollFrameChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 1
                height: 1

                Frame {
                    name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 298
                    height: 232

                    FontString {
                        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription
                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription"
                        text: "Completing Random Battlegrounds will earn you extra rewards."
                        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle.left
                        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle.bottom
                        anchors.topMargin: 5
                        width: 280
                        height: 25.3
                    }

                    Frame {
                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
                        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward.bottom
                        anchors.topMargin: 2
                        width: 319
                        height: 40

                        FontString {
                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
                            text: "Loss"
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            width: 90
                            height: 10
                        }

                        Ghost {
                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"
                            x: 132
                            y: 20
                            width: 0
                            height: 0

                            FontString {
                                name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount"
                                text: "620"
                                wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                                anchors.left: parent.right
                                anchors.leftMargin: 3
                                anchors.verticalCenter: parent.verticalCenter
                                width: 65
                                height: 12
                            }
                        }
                    }

                    FontString {
                        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel
                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
                        text: "Rewards"
                        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription.left
                        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription.bottom
                        anchors.topMargin: 10
                        width: 84.5
                        height: 15.8
                    }

                    FontString {
                        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle
                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle"
                        text: "Random Battleground"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        width: 225.2
                        height: 15.8
                    }

                    Frame {
                        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward
                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.left
                        anchors.leftMargin: -19
                        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.bottom
                        anchors.topMargin: 15
                        width: 319
                        height: 40

                        FontString {
                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
                            text: "Win"
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            width: 90
                            height: 10
                        }

                        Ghost {
                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"
                            x: 237
                            y: 20
                            width: 0
                            height: 0

                            FontString {
                                name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount"
                                text: "25"
                                wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                anchors.left: parent.right
                                anchors.leftMargin: 3
                                anchors.verticalCenter: parent.verticalCenter
                                width: 65
                                height: 12
                            }
                        }

                        Ghost {
                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol"
                            x: 132
                            y: 20
                            width: 0
                            height: 0

                            FontString {
                                name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount"
                                text: "3720"
                                wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                anchors.left: parent.right
                                anchors.leftMargin: 3
                                anchors.verticalCenter: parent.verticalCenter
                                width: 65
                                height: 12
                            }
                        }
                    }
                }
            }

            Frame {
                name: "PVPBattlegroundFrameInfoScrollFrameDiabolicZone"
                wowParent: "PVPBattlegroundFrame"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 12.5
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 329
                height: 220
            }

            Slider {
                name: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 176

                Frame {
                    name: "PVPBattlegroundFrameInfoScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 210
                }

                Button {
                    name: "PVPBattlegroundFrameInfoScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton
                    name: "PVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }
        }

        FontString {
            name: "PVPBattlegroundFrameNameHeader"
            text: "Battleground"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 53
            width: 78.2
            height: 11.9
        }

        // as wide with no scroll bar: Blizzard widens the rows it hangs from when
        // the list doesn't scroll, and the panels would follow
        ScrollFrame {
            name: "PVPBattlegroundFrameTypeScrollFrame"
            pin: "all"
            anchors.left: battlegroundType1.left
            anchors.top: battlegroundType1.top
            anchors.topMargin: -2
            width: 295
            height: 87

            Frame {
                name: "PVPBattlegroundFrameTypeScrollFrameDiabolicZone"
                wowParent: "PVPBattlegroundFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 329
                height: 99
            }

            Slider {
                name: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 55

                Frame {
                    name: "PVPBattlegroundFrameTypeScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 89
                }

                Button {
                    name: "PVPBattlegroundFrameTypeScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton
                    name: "PVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "PVPBattlegroundFrameTypeScrollFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 112
            }
        }

        Frame {
            name: "WintergraspTimer"
            pin: "place"
            anchors.right: parent.right
            anchors.rightMargin: 45
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 53
            width: 32
            height: 32
        }
    }

    Frame {
        name: "PVPFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Ghost {
            name: "PVPFrameBackground"
            x: 14
            y: 36
            width: 0
            height: 512

            Frame {
                name: "PVPFrameArena"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 120
                anchors.top: parent.top
                anchors.topMargin: 95
                width: 300
                height: 20

                FontString {
                    id: pVPFrameArenaLabel
                    name: "PVPFrameArenaLabel"
                    text: "ARENA:"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 10.3
                }

                FontString {
                    name: "PVPFrameArenaPoints"
                    text: "0"
                    anchors.left: pVPFrameArenaLabel.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: pVPFrameArenaLabel.verticalCenter
                    width: 8.7
                    height: 11.9
                }
            }

            Frame {
                name: "PVPFrameHonor"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 118
                anchors.top: parent.top
                anchors.topMargin: 2
                width: 300
                height: 20

                FontString {
                    id: pVPFrameHonorLabel
                    name: "PVPFrameHonorLabel"
                    text: "HONOR:"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 47.4
                    height: 10.3
                }

                FontString {
                    name: "PVPFrameHonorPoints"
                    text: "50130"
                    anchors.left: pVPFrameHonorLabel.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: pVPFrameHonorLabel.verticalCenter
                    width: 38.7
                    height: 11.9
                }
            }

            Frame {
                name: "PVPHonor"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: parent.top
                anchors.topMargin: 28
                width: 300
                height: 100

                FontString {
                    name: "PVPHonorHonorLabel"
                    text: "Honor"
                    anchors.right: pVPHonorKillsLabel.right
                    anchors.top: pVPHonorKillsLabel.bottom
                    anchors.topMargin: 8
                    width: 50
                    height: 12
                }

                FontString {
                    id: pVPHonorKillsLabel
                    name: "PVPHonorKillsLabel"
                    text: "Kills"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 24
                    width: 40
                    height: 12
                }

                FontString {
                    name: "PVPHonorLifetimeHonor"
                    text: "-"
                    anchors.horizontalCenter: pVPHonorLifetimeKills.horizontalCenter
                    anchors.top: pVPHonorLifetimeKills.bottom
                    anchors.topMargin: 5
                    width: 50
                    height: 14
                }

                FontString {
                    id: pVPHonorLifetimeKills
                    name: "PVPHonorLifetimeKills"
                    text: "66"
                    anchors.horizontalCenter: pVPHonorLifetimeLabel.horizontalCenter
                    anchors.top: pVPHonorLifetimeLabel.bottom
                    anchors.topMargin: 10
                    width: 50
                    height: 14
                }

                FontString {
                    id: pVPHonorLifetimeLabel
                    name: "PVPHonorLifetimeLabel"
                    text: "Lifetime"
                    anchors.left: pVPHonorKillsLabel.right
                    anchors.leftMargin: 170
                    anchors.bottom: pVPHonorKillsLabel.top
                    anchors.bottomMargin: 10
                    width: 45
                    height: 10.3
                }

                FontString {
                    name: "PVPHonorTodayHonor"
                    text: "0"
                    anchors.horizontalCenter: pVPHonorTodayKills.horizontalCenter
                    anchors.top: pVPHonorTodayKills.bottom
                    anchors.topMargin: 5
                    width: 50
                    height: 14
                }

                FontString {
                    id: pVPHonorTodayKills
                    name: "PVPHonorTodayKills"
                    text: "0"
                    anchors.horizontalCenter: pVPHonorTodayLabel.horizontalCenter
                    anchors.top: pVPHonorTodayLabel.bottom
                    anchors.topMargin: 10
                    width: 50
                    height: 14
                }

                FontString {
                    id: pVPHonorTodayLabel
                    name: "PVPHonorTodayLabel"
                    text: "Today"
                    anchors.left: pVPHonorKillsLabel.right
                    anchors.leftMargin: 20
                    anchors.bottom: pVPHonorKillsLabel.top
                    anchors.bottomMargin: 10
                    width: 34.8
                    height: 10.3
                }

                FontString {
                    name: "PVPHonorYesterdayHonor"
                    text: "0"
                    anchors.horizontalCenter: pVPHonorYesterdayKills.horizontalCenter
                    anchors.top: pVPHonorYesterdayKills.bottom
                    anchors.topMargin: 5
                    width: 50
                    height: 14
                }

                FontString {
                    id: pVPHonorYesterdayKills
                    name: "PVPHonorYesterdayKills"
                    text: "0"
                    anchors.horizontalCenter: pVPHonorYesterdayLabel.horizontalCenter
                    anchors.top: pVPHonorYesterdayLabel.bottom
                    anchors.topMargin: 10
                    width: 50
                    height: 14
                }

                FontString {
                    id: pVPHonorYesterdayLabel
                    name: "PVPHonorYesterdayLabel"
                    text: "Yesterday"
                    anchors.left: pVPHonorKillsLabel.right
                    anchors.leftMargin: 90
                    anchors.bottom: pVPHonorKillsLabel.top
                    anchors.bottomMargin: 10
                    width: 53.7
                    height: 10.3
                }
            }

            Button {
                name: "PVPTeam1"
                wowParent: "PVPFrame"
                anchors.left: pVPTeam1Standard.left
                anchors.leftMargin: 33
                anchors.verticalCenter: pVPTeam1Standard.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "PVPTeam1TeamType"
                    text: "(2v2)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }

            Frame {
                id: pVPTeam1Standard
                name: "PVPTeam1Standard"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -85
                width: 64
                height: 64
            }

            Button {
                name: "PVPTeam2"
                wowParent: "PVPFrame"
                anchors.left: pVPTeam2Standard.left
                anchors.leftMargin: 33
                anchors.verticalCenter: pVPTeam2Standard.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "PVPTeam2TeamType"
                    text: "(3v3)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }

            Frame {
                id: pVPTeam2Standard
                name: "PVPTeam2Standard"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 64
                height: 64
            }

            Button {
                name: "PVPTeam3"
                wowParent: "PVPFrame"
                anchors.left: pVPTeam3Standard.left
                anchors.leftMargin: 33
                anchors.verticalCenter: pVPTeam3Standard.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "PVPTeam3TeamType"
                    text: "(5v5)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }

            Frame {
                id: pVPTeam3Standard
                name: "PVPTeam3Standard"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 85
                width: 64
                height: 64
            }
        }
    }

    Frame {
        id: pVPParentFrameDiabolic
        name: "PVPParentFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -28
        width: 402
        height: 501

        Button {
            name: "PVPParentFrameCloseButton"
            wowParent: "PVPParentFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "PVPParentFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 402
            height: 469

            Frame {
                name: "PVPParentFrameDiabolicTitlePlate"
                wowParent: "PVPParentFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "PVPParentFrameDiabolicTitle"
                    text: "Player vs. Player"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 158.8
                    height: 14.2
                }
            }
        }

        Frame {
            name: "PVPParentFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 356
            height: 35

            WowRow {
                name: "PVPButtons"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                // 8 apart
                Button {
                    name: "PVPBattlegroundFrameGroupJoinButton"
                    text: "Join as Party"
                    wowParent: "PVPBattlegroundFrame"
                    style: "Button"
                    pin: "all"
                    width: 128
                    height: 22

                    FontString {
                        name: "PVPBattlegroundFrameGroupJoinButtonText"
                        text: "Join as Party"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 101.9
                        height: 11.9
                    }
                }

                // the buttons in the middle of the window's foot (its middle 15 left of the
                // frame's; Join as Party wider than Cancel, so Join Battle 27 right of it),
                // room between the rewards and the foot
                Button {
                    name: "PVPBattlegroundFrameJoinButton"
                    text: "Join Battle"
                    wowParent: "PVPBattlegroundFrame"
                    style: "Button"
                    pin: "all"
                    width: 110.6
                    height: 22

                    FontString {
                        name: "PVPBattlegroundFrameJoinButtonText"
                        text: "Join Battle"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 84.5
                        height: 11.9
                    }
                }

                // 8 apart
                Button {
                    name: "PVPBattlegroundFrameCancelButton"
                    text: "Cancel"
                    wowParent: "PVPBattlegroundFrame"
                    style: "Button"
                    pin: "all"
                    width: 77.4
                    height: 22

                    FontString {
                        name: "PVPBattlegroundFrameCancelButtonText"
                        text: "Cancel"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 51.4
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "PVPParentFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "PVPParentFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }
    }

    Button {
        name: "PVPParentFrameTab1"
        text: "PvP"
        style: "Banner"
        anchors.left: pVPParentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: pVPParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "PVPParentFrameTab2"
        text: "Battlegrounds"
        style: "Banner"
        anchors.left: pVPParentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: pVPParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }
}
