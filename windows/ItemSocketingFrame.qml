// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "ItemSocketingFrame"
    kind: "sheet"
    width: 384
    height: 293.1

    Frame {
        name: "ItemSocketingFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -18
        anchors.top: parent.top
        anchors.topMargin: -18
        width: 420
        height: 329.1

        Button {
            name: "ItemSocketingCloseButton"
            wowParent: "ItemSocketingFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "ItemSocketingFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 420
            height: 329.1

            Frame {
                name: "ItemSocketingFrameDiabolicTitlePlate"
                wowParent: "ItemSocketingFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "ItemSocketingFrameDiabolicTitle"
                    text: "Item Socketing"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 136.7
                    height: 14.2
                }

                Button {
                    name: "ItemSocketingFrameDiabolicTitlePlateGem"
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }
            }
        }

        Frame {
            name: "ItemSocketingFrameDiabolicFoot"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            width: 374
            height: 35
        }

        Frame {
            name: "ItemSocketingFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Frame {
        name: "ItemSocketingFrameDiabolicPane"
        anchors.horizontalCenter: itemSocketingFrameDiabolicSlate.horizontalCenter
        anchors.top: itemSocketingFrameDiabolicSlate.bottom
        anchors.topMargin: 6
        width: 340
        height: 72

        Button {
            name: "ItemSocketingSocket1"
            wowParent: "ItemSocketingFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -38
            anchors.verticalCenter: parent.verticalCenter
            width: 44
            height: 44

            Frame {
                name: "ItemSocketingSocket1BracketFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 44
                height: 44
            }

            Frame {
                name: "ItemSocketingSocket1Shine"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -1
                anchors.verticalCenter: parent.verticalCenter
                width: 37
                height: 37
            }
        }

        Button {
            name: "ItemSocketingSocket2"
            wowParent: "ItemSocketingFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 38
            anchors.verticalCenter: parent.verticalCenter
            width: 44
            height: 44

            Frame {
                name: "ItemSocketingSocket2BracketFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 44
                height: 44
            }

            Frame {
                name: "ItemSocketingSocket2Shine"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -1
                anchors.verticalCenter: parent.verticalCenter
                width: 37
                height: 37
            }
        }
    }

    Frame {
        id: itemSocketingFrameDiabolicSlate
        name: "ItemSocketingFrameDiabolicSlate"
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 14
        width: 340
        height: 155.1

        Frame {
            name: "ItemSocketingFrameDiabolicSlateDiabolicZone"
            wowParent: "ItemSocketingFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 340
            height: 155.1
        }

        ScrollFrame {
            name: "ItemSocketingScrollFrame"
            wowParent: "ItemSocketingFrame"
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 6
            width: 297
            height: 143.1

            Frame {
                name: "ItemSocketingScrollChild"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 259
                height: 143.1

                Part {
                    name: "ItemSocketingDescription"
                    kind: "GameTooltip"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 259
                    height: 143.1

                    FontString {
                        name: "ItemSocketingDescriptionTextLeft1"
                        text: "Gladiator's Dreadweave Hood"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: 268
                        height: 11.9
                    }

                    Ghost {
                        name: "ItemSocketingDescriptionTextLeft2"
                        x: 10
                        y: 23.8
                        width: 268
                        height: 11.9

                        FontString {
                            name: "ItemSocketingDescriptionTextRight2"
                            text: "Cloth"
                            wowParent: "ItemSocketingDescription"
                            anchors.right: parent.left
                            anchors.rightMargin: -268
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32.4
                            height: 11.9
                        }
                    }
                }
            }

            Slider {
                name: "ItemSocketingScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 18
                width: 16
                height: 166

                Frame {
                    name: "ItemSocketingScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: itemSocketingScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: itemSocketingScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 204
                }

                Button {
                    name: "ItemSocketingScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: 3
                    width: 16
                    height: 16
                }

                Button {
                    id: itemSocketingScrollFrameScrollBarScrollUpButton
                    name: "ItemSocketingScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 1
                    width: 16
                    height: 16
                }
            }
        }
    }

    Button {
        name: "ItemSocketingSocketButton"
        text: "Socket Gems"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 19
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        width: 162
        height: 22
    }
}
