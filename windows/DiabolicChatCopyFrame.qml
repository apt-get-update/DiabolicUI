// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: diabolicChatCopyFrame
    name: "DiabolicChatCopyFrame"
    width: 560
    height: 340

    Part {
        id: diabolicChatCopyFrameDiabolic
        name: "DiabolicChatCopyFrameDiabolic"
        kind: "Frame"
        wowParent: "DiabolicChatCopyFrame"
        anchors.left: diabolicChatCopyFrame.left
        anchors.top: diabolicChatCopyFrame.top
        width: 560
        height: 340
    }

    Part {
        id: diabolicChatCopyFrameDiabolicBorder
        name: "DiabolicChatCopyFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "DiabolicChatCopyFrameDiabolic"
        anchors.left: diabolicChatCopyFrameDiabolic.left
        anchors.top: diabolicChatCopyFrameDiabolic.top
        width: 560
        height: 340
    }

    Part {
        id: diabolicChatCopyFrameDiabolicSocket
        name: "DiabolicChatCopyFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "DiabolicChatCopyFrameDiabolic"
        anchors.right: diabolicChatCopyFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: diabolicChatCopyFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: diabolicChatCopyFrameDiabolicTitlePlate
        name: "DiabolicChatCopyFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "DiabolicChatCopyFrameDiabolic"
        anchors.horizontalCenter: diabolicChatCopyFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: diabolicChatCopyFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: diabolicChatCopyScroll
        name: "DiabolicChatCopyScroll"
        kind: "ScrollFrame"
        wowParent: "DiabolicChatCopyFrame"
        anchors.left: diabolicChatCopyFrame.left
        anchors.leftMargin: 36
        anchors.top: diabolicChatCopyFrame.top
        anchors.topMargin: 36
        width: 464
        height: 268
    }

    Part {
        id: diabolicChatCopyScrollDiabolicPanel
        name: "DiabolicChatCopyScrollDiabolicPanel"
        kind: "Frame"
        wowParent: "DiabolicChatCopyFrame"
        anchors.left: diabolicChatCopyScroll.left
        anchors.leftMargin: -6
        anchors.top: diabolicChatCopyScroll.top
        anchors.topMargin: -6
        width: 498
        height: 280
    }

    Part {
        id: diabolicChatCopyScrollScrollBar
        name: "DiabolicChatCopyScrollScrollBar"
        kind: "Slider"
        wowParent: "DiabolicChatCopyScroll"
        anchors.left: diabolicChatCopyScroll.right
        anchors.leftMargin: 6
        anchors.top: diabolicChatCopyScroll.top
        anchors.topMargin: 16
        width: 16
        height: 236
    }

    Part {
        id: diabolicChatCopyScrollScrollBarDiabolicTrack
        name: "DiabolicChatCopyScrollScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "DiabolicChatCopyScrollScrollBar"
        anchors.horizontalCenter: diabolicChatCopyScrollScrollBarScrollUpButton.horizontalCenter
        anchors.top: diabolicChatCopyScrollScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 270
    }

    Part {
        id: diabolicChatCopyScrollScrollBarScrollDownButton
        name: "DiabolicChatCopyScrollScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "DiabolicChatCopyScrollScrollBar"
        anchors.horizontalCenter: diabolicChatCopyScrollScrollBar.horizontalCenter
        anchors.top: diabolicChatCopyScrollScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: diabolicChatCopyScrollScrollBarScrollUpButton
        name: "DiabolicChatCopyScrollScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "DiabolicChatCopyScrollScrollBar"
        anchors.horizontalCenter: diabolicChatCopyScrollScrollBar.horizontalCenter
        anchors.bottom: diabolicChatCopyScrollScrollBar.top
        width: 16
        height: 16
    }

}
