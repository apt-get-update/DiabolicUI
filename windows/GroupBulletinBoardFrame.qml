// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "GroupBulletinBoardFrame"
    width: 800
    height: 500

    Frame {
        name: "GroupBulletinBoardFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -20
        anchors.top: parent.top
        anchors.topMargin: -44
        width: 840
        height: 562

        Button {
            id: groupBulletinBoardFrameCloseButton
            name: "GroupBulletinBoardFrameCloseButton"
            text: "Close"
            wowParent: "GroupBulletinBoardFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "GroupBulletinBoardFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 792
            height: 40
        }

        Frame {
            name: "GroupBulletinBoardFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 840
            height: 562

            Frame {
                name: "GroupBulletinBoardFrameDiabolicTitlePlate"
                wowParent: "GroupBulletinBoardFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "GroupBulletinBoardFrameTitle"
                    text: "Group Bulletin Board"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 123.3
                    height: 11.9
                }
            }
        }

        Frame {
            name: "GroupBulletinBoardFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }

        Button {
            name: "GroupBulletinBoardFrameSettingsButton"
            wowParent: "GroupBulletinBoardFrame"
            pin: "place"
            anchors.right: groupBulletinBoardFrameCloseButton.left
            anchors.rightMargin: 6
            anchors.verticalCenter: groupBulletinBoardFrameCloseButton.verticalCenter
            width: 18
            height: 18
        }
    }

    Button {
        name: "GroupBulletinBoardFrameSelectChannel"
        text: "General"
        style: "Button"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        width: 80
        height: 20

        FontString {
            name: "GroupBulletinBoardFrameSelectChannelText"
            text: "General"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 41.9
            height: 10.3
        }
    }

    FontString {
        name: "GroupBulletinBoardFrameStatusText"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 780
        height: 10.3
    }

    ScrollFrame {
        name: "GroupBulletinBoardFrame_ScrollFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 30
        width: 760
        height: 420

        Frame {
            name: "GroupBulletinBoardFrame_ScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 760
            height: 420
        }

        Frame {
            name: "GroupBulletinBoardFrame_ScrollFrameDiabolicZone"
            wowParent: "GroupBulletinBoardFrame"
            anchors.left: parent.left
            anchors.leftMargin: -2
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 788
            height: 428
        }
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_BOTTOM"
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.bottom
        anchors.topMargin: -8
        width: 784
        height: 8
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_BOTTOMLEFT"
        anchors.left: parent.left
        anchors.top: parent.bottom
        width: 8
        height: -8
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_BOTTOMRIGHT"
        anchors.left: parent.right
        anchors.top: parent.bottom
        width: -8
        height: -8
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_LEFT"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 8
        width: 8
        height: 484
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_RIGHT"
        anchors.left: parent.right
        anchors.leftMargin: -8
        anchors.top: parent.top
        anchors.topMargin: 8
        width: 8
        height: 484
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_TOP"
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        width: 784
        height: 8
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_TOPLEFT"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 8
        height: 8
    }

    Frame {
        name: "GroupBulletinBoardFrame_size_TOPRIGHT"
        anchors.left: parent.right
        anchors.top: parent.top
        width: -8
        height: 8
    }
}
