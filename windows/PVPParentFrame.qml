// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "PVPParentFrame"
    width: 384
    height: 512

    Frame {
        name: "PVPBattlegroundFrame"
        wowParent: "PVPParentFrame"
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 1
        width: 384
        height: 512

        // the battlegrounds' block (title row, list, rewards) 5 left: in the middle
        Button {
            name: "BattlegroundType1"
            text: "Random Battleground"
            wowParent: "PVPBattlegroundFrame"
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
                wowParent: "BattlegroundType1"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 130.4
                height: 11.9
            }

            Button {
                name: "BattlegroundType2"
                text: "Arathi Basin (Call to Arms)"
                wowParent: "PVPBattlegroundFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                width: 295
                height: 16

                FontString {
                    name: "BattlegroundType2Text"
                    text: "Arathi Basin (Call to Arms)"
                    wowParent: "BattlegroundType2"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 155.7
                    height: 11.9
                }

                Button {
                    name: "BattlegroundType3"
                    text: "Warsong Gulch"
                    wowParent: "PVPBattlegroundFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    width: 295
                    height: 16

                    FontString {
                        name: "BattlegroundType3Text"
                        text: "Warsong Gulch"
                        wowParent: "BattlegroundType3"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 91.7
                        height: 11.9
                    }

                    Button {
                        name: "BattlegroundType4"
                        text: "Alterac Valley"
                        wowParent: "PVPBattlegroundFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        width: 295
                        height: 16

                        FontString {
                            name: "BattlegroundType4Text"
                            text: "Alterac Valley"
                            wowParent: "BattlegroundType4"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -1
                            width: 83
                            height: 11.9
                        }

                        Button {
                            name: "BattlegroundType5"
                            text: "Eye of the Storm"
                            wowParent: "PVPBattlegroundFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            width: 295
                            height: 16

                            FontString {
                                name: "BattlegroundType5Text"
                                text: "Eye of the Storm"
                                wowParent: "BattlegroundType5"
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -1
                                width: 99.6
                                height: 11.9
                            }
                        }
                    }
                }
            }

            // as wide with no scroll bar: Blizzard widens the rows it hangs from when
            // the list doesn't scroll, and the panels would follow
            ScrollFrame {
                name: "PVPBattlegroundFrameTypeScrollFrame"
                wowParent: "PVPBattlegroundFrame"
                pin: "all"
                anchors.left: parent.left
                anchors.top: parent.top
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
                    wowParent: "PVPBattlegroundFrameTypeScrollFrame"
                    style: "ScrollBar"
                    anchors.left: parent.right
                    anchors.leftMargin: 6
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    width: 16
                    height: 55

                    Button {
                        name: "PVPBattlegroundFrameTypeScrollFrameScrollBarScrollDownButton"
                        wowParent: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        width: 16
                        height: 16
                    }

                    Button {
                        name: "PVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton"
                        wowParent: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        width: 16
                        height: 16

                        Frame {
                            name: "PVPBattlegroundFrameTypeScrollFrameScrollBarDiabolicTrack"
                            wowParent: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 18
                            height: 89
                        }
                    }
                }

                Frame {
                    name: "PVPBattlegroundFrameTypeScrollFrameScrollChildFrame"
                    wowParent: "PVPBattlegroundFrameTypeScrollFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 300
                    height: 112
                }
            }
        }

        FontString {
            name: "PVPBattlegroundFrameFrameLabel"
            text: "Battlegrounds"
            wowParent: "PVPBattlegroundFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 17
            width: 84.5
            height: 11.9
        }

        // the rewards 208 high (Blizzard's 232): 6 over the foot's iron bar, 6 under the list
        ScrollFrame {
            name: "PVPBattlegroundFrameInfoScrollFrame"
            wowParent: "PVPBattlegroundFrame"
            pin: "all"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 122
            width: 298
            height: 208

            Frame {
                name: "PVPBattlegroundFrameInfoScrollFrameChildFrame"
                wowParent: "PVPBattlegroundFrameInfoScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 1
                height: 1

                Frame {
                    name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                    wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 298
                    height: 232

                    FontString {
                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle"
                        text: "Random Battleground"
                        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        width: 225.2
                        height: 15.8

                        FontString {
                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription"
                            text: "Completing Random Battlegrounds will earn you extra rewards."
                            wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 5
                            width: 280
                            height: 25.3

                            FontString {
                                name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
                                text: "Rewards"
                                wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 10
                                width: 84.5
                                height: 15.8

                                Frame {
                                    name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                    wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                                    anchors.left: parent.left
                                    anchors.leftMargin: -19
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 15
                                    width: 319
                                    height: 40

                                    Frame {
                                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                                        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 2
                                        width: 319
                                        height: 40

                                        FontString {
                                            name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
                                            text: "Loss"
                                            wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                                            anchors.left: parent.left
                                            anchors.leftMargin: 5
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 90
                                            height: 10
                                        }
                                    }

                                    FontString {
                                        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
                                        text: "Win"
                                        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 5
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 90
                                        height: 10
                                    }
                                }
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
                wowParent: "PVPBattlegroundFrameInfoScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 176

                Button {
                    name: "PVPBattlegroundFrameInfoScrollFrameScrollBarScrollDownButton"
                    wowParent: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "PVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton"
                    wowParent: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "PVPBattlegroundFrameInfoScrollFrameScrollBarDiabolicTrack"
                        wowParent: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 210
                    }
                }
            }
        }

        FontString {
            name: "PVPBattlegroundFrameNameHeader"
            text: "Battleground"
            wowParent: "PVPBattlegroundFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 53
            width: 78.2
            height: 11.9
        }

        Frame {
            name: "WintergraspTimer"
            wowParent: "PVPBattlegroundFrame"
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
        wowParent: "PVPParentFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512
    }

    Frame {
        name: "PVPParentFrameDiabolic"
        wowParent: "PVPParentFrame"
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
            wowParent: "PVPParentFrameDiabolic"
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
            }
        }

        Frame {
            name: "PVPParentFrameDiabolicFoot"
            wowParent: "PVPParentFrameDiabolic"
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
                        wowParent: "PVPBattlegroundFrameGroupJoinButton"
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
                        wowParent: "PVPBattlegroundFrameJoinButton"
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
                        wowParent: "PVPBattlegroundFrameCancelButton"
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
            wowParent: "PVPParentFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "PVPParentFrameDiabolicSocket"
            wowParent: "PVPParentFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "PVPParentFrameTab1"
            text: "PvP"
            wowParent: "PVPParentFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "PVPParentFrameTab2"
            text: "Battlegrounds"
            wowParent: "PVPParentFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Ghost {
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"
        x: 150
        y: 346.9
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

    Ghost {
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"
        x: 255
        y: 304.9
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
        x: 150
        y: 304.9
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
                name: "PVPFrameArenaLabel"
                text: "ARENA:"
                wowParent: "PVPFrameArena"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 41.9
                height: 10.3

                FontString {
                    name: "PVPFrameArenaPoints"
                    text: "0"
                    wowParent: "PVPFrameArena"
                    anchors.left: parent.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    width: 8.7
                    height: 11.9
                }
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
                name: "PVPFrameHonorLabel"
                text: "HONOR:"
                wowParent: "PVPFrameHonor"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 47.4
                height: 10.3

                FontString {
                    name: "PVPFrameHonorPoints"
                    text: "50130"
                    wowParent: "PVPFrameHonor"
                    anchors.left: parent.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    width: 38.7
                    height: 11.9
                }
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
                name: "PVPHonorKillsLabel"
                text: "Kills"
                wowParent: "PVPHonor"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 24
                width: 40
                height: 12

                FontString {
                    name: "PVPHonorHonorLabel"
                    text: "Honor"
                    wowParent: "PVPHonor"
                    anchors.right: parent.right
                    anchors.top: parent.bottom
                    anchors.topMargin: 8
                    width: 50
                    height: 12
                }

                FontString {
                    name: "PVPHonorLifetimeLabel"
                    text: "Lifetime"
                    wowParent: "PVPHonor"
                    anchors.left: parent.right
                    anchors.leftMargin: 170
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 10
                    width: 45
                    height: 10.3

                    FontString {
                        name: "PVPHonorLifetimeKills"
                        text: "66"
                        wowParent: "PVPHonor"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        width: 50
                        height: 14

                        FontString {
                            name: "PVPHonorLifetimeHonor"
                            text: "-"
                            wowParent: "PVPHonor"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            anchors.topMargin: 5
                            width: 50
                            height: 14
                        }
                    }
                }

                FontString {
                    name: "PVPHonorTodayLabel"
                    text: "Today"
                    wowParent: "PVPHonor"
                    anchors.left: parent.right
                    anchors.leftMargin: 20
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 10
                    width: 34.8
                    height: 10.3

                    FontString {
                        name: "PVPHonorTodayKills"
                        text: "0"
                        wowParent: "PVPHonor"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        width: 50
                        height: 14

                        FontString {
                            name: "PVPHonorTodayHonor"
                            text: "0"
                            wowParent: "PVPHonor"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            anchors.topMargin: 5
                            width: 50
                            height: 14
                        }
                    }
                }

                FontString {
                    name: "PVPHonorYesterdayLabel"
                    text: "Yesterday"
                    wowParent: "PVPHonor"
                    anchors.left: parent.right
                    anchors.leftMargin: 90
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 10
                    width: 53.7
                    height: 10.3

                    FontString {
                        name: "PVPHonorYesterdayKills"
                        text: "0"
                        wowParent: "PVPHonor"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        width: 50
                        height: 14

                        FontString {
                            name: "PVPHonorYesterdayHonor"
                            text: "0"
                            wowParent: "PVPHonor"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            anchors.topMargin: 5
                            width: 50
                            height: 14
                        }
                    }
                }
            }
        }

        Frame {
            name: "PVPTeam1Standard"
            wowParent: "PVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -85
            width: 64
            height: 64

            Button {
                name: "PVPTeam1"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "PVPTeam1TeamType"
                    text: "(2v2)"
                    wowParent: "PVPTeam1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }
        }

        Frame {
            name: "PVPTeam2Standard"
            wowParent: "PVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            width: 64
            height: 64

            Button {
                name: "PVPTeam2"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "PVPTeam2TeamType"
                    text: "(3v3)"
                    wowParent: "PVPTeam2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }
        }

        Frame {
            name: "PVPTeam3Standard"
            wowParent: "PVPFrame"
            anchors.left: parent.left
            anchors.leftMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 85
            width: 64
            height: 64

            Button {
                name: "PVPTeam3"
                wowParent: "PVPFrame"
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: 78

                FontString {
                    name: "PVPTeam3TeamType"
                    text: "(5v5)"
                    wowParent: "PVPTeam3"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41.9
                    height: 15.8
                }
            }
        }
    }
}
