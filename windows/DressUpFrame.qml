// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "DressUpFrame"
    width: 384
    height: 512

    Button {
        name: "DressUpFrameCancelButton"
        text: "Close"
        wowParent: "DressUpFrame"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 39
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 79
        width: 77
        height: 22

        FontString {
            name: "DressUpFrameCancelButtonText"
            text: "Close"
            wowParent: "DressUpFrameCancelButton"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 40.3
            height: 11.9
        }
    }

    // its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
    FontString {
        name: "DressUpFrameDescriptionText"
        text: "CTRL-Left Click additional items to display them on your character"
        wowParent: "DressUpFrame"
        pin: "place"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 50
        width: 260
        height: 36
    }

    Frame {
        name: "DressUpFrameDiabolic"
        wowParent: "DressUpFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        width: 402
        height: 503

        Button {
            name: "DressUpFrameCloseButton"
            wowParent: "DressUpFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "DressUpFrameDiabolicBorder"
            wowParent: "DressUpFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 402
            height: 503

            Frame {
                name: "DressUpFrameDiabolicTitlePlate"
                wowParent: "DressUpFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "DressUpFrameTitleText"
                    text: "Dressing Room"
                    wowParent: "DressUpFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 132
                    height: 14.2
                }
            }
        }

        Frame {
            name: "DressUpFrameDiabolicSocket"
            wowParent: "DressUpFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Button {
        name: "DressUpFrameResetButton"
        text: "Reset"
        wowParent: "DressUpFrame"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 79
        width: 77
        height: 22

        FontString {
            name: "DressUpFrameResetButtonText"
            text: "Reset"
            wowParent: "DressUpFrameResetButton"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 40.3
            height: 11.9
        }
    }

    DressUpModel {
        name: "DressUpModel"
        wowParent: "DressUpFrame"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 105
        width: 316
        height: 331
    }

    Button {
        name: "DressUpModelRotateLeftButton"
        wowParent: "DressUpModel"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 75
        width: 35
        height: 35

        Button {
            name: "DressUpModelRotateRightButton"
            wowParent: "DressUpModel"
            anchors.left: parent.right
            anchors.top: parent.top
            width: 35
            height: 35
        }
    }

    Ghost {
        name: "DressUpBackgroundTopLeft"
        x: 22
        y: 76
        width: 0
        height: 0

        Frame {
            name: "DressUpBackgroundTopLeftDiabolicPane"
            wowParent: "DressUpFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 330
            height: 395
        }
    }
}
