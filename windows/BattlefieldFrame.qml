// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "BattlefieldFrame"
    width: 384
    height: 512

    Frame {
        name: "BattlefieldFrameDiabolic"
        wowParent: "BattlefieldFrame"
        anchors.left: parent.left
        anchors.leftMargin: -19
        anchors.top: parent.top
        width: 398
        height: 473

        Button {
            name: "BattlefieldFrameCloseButton"
            wowParent: "BattlefieldFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "BattlefieldFrameDiabolicBorder"
            wowParent: "BattlefieldFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 398
            height: 473

            Frame {
                name: "BattlefieldFrameDiabolicTitlePlate"
                wowParent: "BattlefieldFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "BattlefieldFrameFrameLabel"
                    text: "Arathi Basin"
                    wowParent: "BattlefieldFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 113
                    height: 14.2
                }
            }
        }

        Frame {
            name: "BattlefieldFrameDiabolicFoot"
            wowParent: "BattlefieldFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 352
            height: 35

            WowRow {
                name: "BattlefieldButtons"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "BattlefieldFrameGroupJoinButton"
                    text: "Join as Group"
                    wowParent: "BattlefieldFrame"
                    style: "Button"
                    pin: "all"
                    width: 127.7
                    height: 22

                    FontString {
                        name: "BattlefieldFrameGroupJoinButtonText"
                        text: "Join as Group"
                        wowParent: "BattlefieldFrameGroupJoinButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 103.5
                        height: 11.9
                    }
                }

                Button {
                    name: "BattlefieldFrameJoinButton"
                    text: "Join Battle"
                    wowParent: "BattlefieldFrame"
                    style: "Button"
                    pin: "all"
                    width: 108.7
                    height: 22

                    FontString {
                        name: "BattlefieldFrameJoinButtonText"
                        text: "Join Battle"
                        wowParent: "BattlefieldFrameJoinButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 84.5
                        height: 11.9
                    }
                }

                Button {
                    name: "BattlefieldFrameCancelButton"
                    text: "Cancel"
                    wowParent: "BattlefieldFrame"
                    style: "Button"
                    pin: "all"
                    width: 75.6
                    height: 22

                    FontString {
                        name: "BattlefieldFrameCancelButtonText"
                        text: "Cancel"
                        wowParent: "BattlefieldFrameCancelButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 51.4
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "BattlefieldFrameDiabolicSocket"
            wowParent: "BattlefieldFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    // the rewards on slate too, under the instances: 16 higher (its panel clear
    // of the buttons), its top 7 lower (apart from theirs; Blizzard's 232 high)
    ScrollFrame {
        name: "BattlefieldFrameInfoScrollFrame"
        wowParent: "BattlefieldFrame"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 19
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 116
        width: 298
        height: 209

        Frame {
            name: "BattlefieldFrameInfoScrollFrameChildFrame"
            wowParent: "BattlefieldFrameInfoScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 1
            height: 1

            Frame {
                name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
                wowParent: "BattlefieldFrameInfoScrollFrameChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 298
                height: 232

                FontString {
                    name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle"
                    text: "Call to Arms"
                    wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    width: 130.4
                    height: 15.8

                    FontString {
                        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription"
                        text: "Your urgent assistance is needed to combat our foes! Completing this Battleground will earn you extra rewards."
                        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 5
                        width: 280
                        height: 37.9

                        FontString {
                            name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
                            text: "Rewards"
                            wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            width: 84.5
                            height: 15.8

                            Frame {
                                name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
                                anchors.left: parent.left
                                anchors.leftMargin: -19
                                anchors.top: parent.bottom
                                anchors.topMargin: 15
                                width: 319
                                height: 40

                                Frame {
                                    name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                                    wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 2
                                    width: 319
                                    height: 40

                                    FontString {
                                        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
                                        text: "Loss"
                                        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 5
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 90
                                        height: 10
                                    }

                                    Ghost {
                                        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"
                                        x: 132
                                        y: 20
                                        width: 0
                                        height: 0

                                        FontString {
                                            name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount"
                                            text: "620"
                                            wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
                                            anchors.left: parent.right
                                            anchors.leftMargin: 3
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 65
                                            height: 12
                                        }
                                    }
                                }

                                FontString {
                                    name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
                                    text: "Win"
                                    wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 90
                                    height: 10
                                }

                                Ghost {
                                    name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"
                                    x: 237
                                    y: 20
                                    width: 0
                                    height: 0

                                    FontString {
                                        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount"
                                        text: "25"
                                        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
                                        anchors.left: parent.right
                                        anchors.leftMargin: 3
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 65
                                        height: 12
                                    }
                                }

                                Ghost {
                                    name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol"
                                    x: 132
                                    y: 20
                                    width: 0
                                    height: 0

                                    FontString {
                                        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount"
                                        text: "3720"
                                        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
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
                }
            }
        }

        Frame {
            name: "BattlefieldFrameInfoScrollFrameDiabolicZone"
            wowParent: "BattlefieldFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 12
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 330
            height: 221
        }

        Slider {
            name: "BattlefieldFrameInfoScrollFrameScrollBar"
            wowParent: "BattlefieldFrameInfoScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 177

            Button {
                name: "BattlefieldFrameInfoScrollFrameScrollBarScrollDownButton"
                wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "BattlefieldFrameInfoScrollFrameScrollBarScrollUpButton"
                wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "BattlefieldFrameInfoScrollFrameScrollBarDiabolicTrack"
                    wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 211
                }
            }
        }
    }

    // "Battlefield Instance:" 5 higher, apart from its list
    FontString {
        name: "BattlefieldFrameNameHeader"
        text: "Battlefield Instance:"
        wowParent: "BattlefieldFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 75
        anchors.top: parent.top
        anchors.topMargin: 50
        width: 117.7
        height: 11.9
    }

    Button {
        name: "BattlefieldZone1"
        text: "First Available"
        wowParent: "BattlefieldFrame"
        anchors.left: parent.left
        anchors.leftMargin: 23
        anchors.top: parent.top
        anchors.topMargin: 79
        width: 315
        height: 16

        FontString {
            name: "BattlefieldZone1Text"
            text: "First Available"
            wowParent: "BattlefieldZone1"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 84.5
            height: 11.9
        }
    }

    Ghost {
        name: "BattlefieldListScrollFrame"
        x: 21
        y: 74
        width: 0
        height: 0

        Frame {
            name: "BattlefieldListScrollFrameDiabolicZone"
            wowParent: "BattlefieldFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 330
            height: 107
        }
    }
}
