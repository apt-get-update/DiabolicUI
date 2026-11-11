// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "DiabolicChatCopyFrame"
    width: 560
    height: 340

    Frame {
        name: "DiabolicChatCopyFrameDiabolic"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 560
        height: 340

        Frame {
            name: "DiabolicChatCopyFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 560
            height: 340

            Frame {
                name: "DiabolicChatCopyFrameDiabolicTitlePlate"
                wowParent: "DiabolicChatCopyFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "DiabolicChatCopyFrameDiabolicTitle"
                    text: "Copy Chat"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 92.4
                    height: 14.2
                }
            }
        }

        Frame {
            name: "DiabolicChatCopyFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    ScrollFrame {
        name: "DiabolicChatCopyScroll"
        anchors.left: parent.left
        anchors.leftMargin: 36
        anchors.top: parent.top
        anchors.topMargin: 36
        width: 464
        height: 268

        Frame {
            name: "DiabolicChatCopyScrollDiabolicPanel"
            wowParent: "DiabolicChatCopyFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 498
            height: 280
        }

        Slider {
            name: "DiabolicChatCopyScrollScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 236

            Frame {
                name: "DiabolicChatCopyScrollScrollBarDiabolicTrack"
                anchors.horizontalCenter: diabolicChatCopyScrollScrollBarScrollUpButton.horizontalCenter
                anchors.top: diabolicChatCopyScrollScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 270
            }

            Button {
                name: "DiabolicChatCopyScrollScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: diabolicChatCopyScrollScrollBarScrollUpButton
                name: "DiabolicChatCopyScrollScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }
    }
}
