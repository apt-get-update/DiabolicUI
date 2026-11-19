// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "ArenaFrame"
    kind: "list"
    width: 384
    height: 512

    Frame {
        name: "ArenaFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -19
        anchors.top: parent.top
        width: 398
        height: 422

        Button {
            name: "ArenaFrameCloseButton"
            wowParent: "ArenaFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "ArenaFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 398
            height: 422

            Frame {
                name: "ArenaFrameDiabolicTitlePlate"
                wowParent: "ArenaFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                Button {
                    name: "ArenaFrameDiabolicTitlePlateGem"
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }

                FontString {
                    name: "ArenaFrameFrameLabel"
                    text: "Arena Battles"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 128.8
                    height: 14.2
                }
            }
        }

        Frame {
            name: "ArenaFrameDiabolicFoot"
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
                name: "ArenaButtons"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "ArenaFrameGroupJoinButton"
                    text: "Join as Group"
                    wowParent: "ArenaFrame"
                    style: "Button"
                    pin: "all"
                    width: 122.7
                    height: 22

                    FontString {
                        name: "ArenaFrameGroupJoinButtonText"
                        text: "Join as Group"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 90.1
                        height: 10.3
                    }
                }

                Button {
                    name: "ArenaFrameJoinButton"
                    text: "Join Battle"
                    wowParent: "ArenaFrame"
                    style: "Button"
                    pin: "all"
                    width: 106.9
                    height: 22

                    FontString {
                        name: "ArenaFrameJoinButtonText"
                        text: "Join Battle"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 74.3
                        height: 10.3
                    }
                }

                Button {
                    name: "ArenaFrameCancelButton"
                    text: "Cancel"
                    wowParent: "ArenaFrame"
                    style: "Button"
                    pin: "all"
                    width: 78.4
                    height: 22

                    FontString {
                        name: "ArenaFrameCancelButtonText"
                        text: "Cancel"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 45.8
                        height: 10.3
                    }
                }
            }
        }

        Frame {
            name: "ArenaFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    FontString {
        name: "ArenaFrameNameHeader"
        text: "Rated Battle:"
        pin: "place"
        anchors.left: arenaZone1.left
        anchors.bottom: arenaZone1.top
        anchors.bottomMargin: 12
        width: 76.6
        height: 11.9
    }

    FontString {
        name: "ArenaFrameNameHeader2"
        text: "Practice Battle:"
        pin: "place"
        anchors.left: arenaZone4.left
        anchors.bottom: arenaZone4.top
        anchors.bottomMargin: 12
        width: 88.5
        height: 11.9
    }

    FontString {
        name: "ArenaFrameZoneDescription"
        text: "Let the games begin!  The door is open to all who wish to find glory in the arena, and the Steamwheedle Cartel is prepared to accept your entry into the games.  If victory is your destiny, then register a team with an Arena Organizer, or join one that has already been registered!"
        pin: "all"
        anchors.left: arenaZone6.left
        anchors.leftMargin: 8
        anchors.top: arenaZone6.bottom
        anchors.topMargin: 30
        width: 299
        height: 72

        Frame {
            name: "ArenaFrameZoneDescriptionDiabolicSpan"
            wowParent: "ArenaFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 299
            height: 72

            Frame {
                name: "ArenaFrameZoneDescriptionDiabolicSpanDiabolicZone"
                wowParent: "ArenaFrame"
                anchors.left: parent.left
                anchors.leftMargin: -14
                anchors.top: parent.top
                anchors.topMargin: -12
                width: 327
                height: 96
            }
        }
    }

    Button {
        id: arenaZone1
        name: "ArenaZone1"
        text: "2v2 Battle"
        anchors.left: parent.left
        anchors.leftMargin: 23
        anchors.top: parent.top
        anchors.topMargin: 79
        width: 315
        height: 16

        FontString {
            name: "ArenaZone1Status"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        FontString {
            name: "ArenaZone1Text"
            text: "2v2 Battle"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 62.4
            height: 11.9
        }
    }

    Frame {
        name: "ArenaZone1DiabolicSpan"
        anchors.left: arenaZone1.left
        anchors.top: arenaZone1.top
        width: 315
        height: 48

        Frame {
            name: "ArenaZone1DiabolicSpanDiabolicZone"
            wowParent: "ArenaFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 327
            height: 60
        }
    }

    Button {
        id: arenaZone2
        name: "ArenaZone2"
        text: "3v3 Battle"
        anchors.left: arenaZone1.left
        anchors.top: arenaZone1.bottom
        width: 315
        height: 16

        FontString {
            name: "ArenaZone2Status"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        FontString {
            name: "ArenaZone2Text"
            text: "3v3 Battle"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 62.4
            height: 11.9
        }
    }

    Button {
        id: arenaZone3
        name: "ArenaZone3"
        text: "5v5 Battle"
        anchors.left: arenaZone2.left
        anchors.top: arenaZone2.bottom
        width: 315
        height: 16

        FontString {
            name: "ArenaZone3Status"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        FontString {
            name: "ArenaZone3Text"
            text: "5v5 Battle"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 62.4
            height: 11.9
        }
    }

    Button {
        id: arenaZone4
        name: "ArenaZone4"
        text: "2v2 Skirmish"
        anchors.left: arenaZone3.left
        anchors.top: arenaZone3.top
        anchors.topMargin: 85
        width: 315
        height: 16

        FontString {
            name: "ArenaZone4Status"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        FontString {
            name: "ArenaZone4Text"
            text: "2v2 Skirmish"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 76.6
            height: 11.9
        }
    }

    Frame {
        name: "ArenaZone4DiabolicSpan"
        anchors.left: arenaZone4.left
        anchors.top: arenaZone4.top
        width: 315
        height: 48

        Frame {
            name: "ArenaZone4DiabolicSpanDiabolicZone"
            wowParent: "ArenaFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 327
            height: 60
        }
    }

    Button {
        id: arenaZone5
        name: "ArenaZone5"
        text: "3v3 Skirmish"
        anchors.left: arenaZone4.left
        anchors.top: arenaZone4.bottom
        width: 315
        height: 16

        FontString {
            name: "ArenaZone5Status"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        FontString {
            name: "ArenaZone5Text"
            text: "3v3 Skirmish"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 76.6
            height: 11.9
        }
    }

    Button {
        id: arenaZone6
        name: "ArenaZone6"
        text: "5v5 Skirmish"
        anchors.left: arenaZone5.left
        anchors.top: arenaZone5.bottom
        width: 315
        height: 16

        FontString {
            name: "ArenaZone6Status"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        FontString {
            name: "ArenaZone6Text"
            text: "5v5 Skirmish"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 76.6
            height: 11.9
        }
    }
}
