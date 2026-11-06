// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: diabolicChatCopyFrame
    name: "DiabolicChatCopyFrame"
    width: 560
    height: 340

    Frame {
        id: diabolicChatCopyFrameDiabolic
        name: "DiabolicChatCopyFrameDiabolic"
        wowParent: "DiabolicChatCopyFrame"
        anchors.left: diabolicChatCopyFrame.left
        anchors.top: diabolicChatCopyFrame.top
        width: 560
        height: 340
    }

    Frame {
        id: diabolicChatCopyFrameDiabolicBorder
        name: "DiabolicChatCopyFrameDiabolicBorder"
        wowParent: "DiabolicChatCopyFrameDiabolic"
        anchors.left: diabolicChatCopyFrameDiabolic.left
        anchors.top: diabolicChatCopyFrameDiabolic.top
        width: 560
        height: 340
    }

    Frame {
        id: diabolicChatCopyFrameDiabolicSocket
        name: "DiabolicChatCopyFrameDiabolicSocket"
        wowParent: "DiabolicChatCopyFrameDiabolic"
        anchors.right: diabolicChatCopyFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: diabolicChatCopyFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: diabolicChatCopyFrameDiabolicTitlePlate
        name: "DiabolicChatCopyFrameDiabolicTitlePlate"
        wowParent: "DiabolicChatCopyFrameDiabolic"
        anchors.horizontalCenter: diabolicChatCopyFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: diabolicChatCopyFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    ScrollFrame {
        id: diabolicChatCopyScroll
        name: "DiabolicChatCopyScroll"
        wowParent: "DiabolicChatCopyFrame"
        anchors.left: diabolicChatCopyFrame.left
        anchors.leftMargin: 36
        anchors.top: diabolicChatCopyFrame.top
        anchors.topMargin: 36
        width: 464
        height: 268
    }

    Frame {
        id: diabolicChatCopyScrollDiabolicPanel
        name: "DiabolicChatCopyScrollDiabolicPanel"
        wowParent: "DiabolicChatCopyFrame"
        anchors.left: diabolicChatCopyScroll.left
        anchors.leftMargin: -6
        anchors.top: diabolicChatCopyScroll.top
        anchors.topMargin: -6
        width: 498
        height: 280
    }

    Slider {
        id: diabolicChatCopyScrollScrollBar
        name: "DiabolicChatCopyScrollScrollBar"
        wowParent: "DiabolicChatCopyScroll"
        style: "ScrollBar"
        anchors.left: diabolicChatCopyScroll.right
        anchors.leftMargin: 6
        anchors.top: diabolicChatCopyScroll.top
        anchors.topMargin: 16
        width: 16
        height: 236
    }

    Frame {
        id: diabolicChatCopyScrollScrollBarDiabolicTrack
        name: "DiabolicChatCopyScrollScrollBarDiabolicTrack"
        wowParent: "DiabolicChatCopyScrollScrollBar"
        anchors.horizontalCenter: diabolicChatCopyScrollScrollBarScrollUpButton.horizontalCenter
        anchors.top: diabolicChatCopyScrollScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 270
    }

    Button {
        id: diabolicChatCopyScrollScrollBarScrollDownButton
        name: "DiabolicChatCopyScrollScrollBarScrollDownButton"
        wowParent: "DiabolicChatCopyScrollScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: diabolicChatCopyScrollScrollBar.horizontalCenter
        anchors.top: diabolicChatCopyScrollScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: diabolicChatCopyScrollScrollBarScrollUpButton
        name: "DiabolicChatCopyScrollScrollBarScrollUpButton"
        wowParent: "DiabolicChatCopyScrollScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: diabolicChatCopyScrollScrollBar.horizontalCenter
        anchors.bottom: diabolicChatCopyScrollScrollBar.top
        width: 16
        height: 16
    }

}
