// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: openMailFrame
    name: "OpenMailFrame"
    width: 400
    height: 400

    Part {
        id: openMailBodyText
        name: "OpenMailBodyText"
        kind: "FontString"
        anchors.left: openMailScrollChildFrame.left
        anchors.leftMargin: 10
        anchors.top: openMailScrollChildFrame.top
        anchors.topMargin: 10
        width: 96
        height: 12
    }

    Part {
        id: openMailCancelButton
        name: "OpenMailCancelButton"
        kind: "Button"
        text: "Close"
        anchors.right: openMailFrame.right
        anchors.rightMargin: 39
        anchors.bottom: openMailFrame.bottom
        anchors.bottomMargin: 80
        width: 76.1
        height: 22
    }

    Part {
        id: openMailCancelButtonText
        name: "OpenMailCancelButtonText"
        kind: "FontString"
        text: "Close"
        anchors.horizontalCenter: openMailCancelButton.horizontalCenter
        anchors.verticalCenter: openMailCancelButton.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: openMailCloseButton
        name: "OpenMailCloseButton"
        kind: "Button"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 342
        anchors.top: openMailFrame.top
        anchors.topMargin: -48
        width: 22
        height: 22
    }

    Part {
        id: openMailDeleteButton
        name: "OpenMailDeleteButton"
        kind: "Button"
        text: "Delete"
        anchors.right: openMailFrame.right
        anchors.rightMargin: 121.1
        anchors.bottom: openMailFrame.bottom
        anchors.bottomMargin: 80
        width: 78
        height: 22
    }

    Part {
        id: openMailDeleteButtonText
        name: "OpenMailDeleteButtonText"
        kind: "FontString"
        text: "Delete"
        anchors.horizontalCenter: openMailDeleteButton.horizontalCenter
        anchors.verticalCenter: openMailDeleteButton.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: openMailLetterButton
        name: "OpenMailLetterButton"
        kind: "Button"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 161.5
        anchors.top: openMailFrame.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Part {
        id: openMailReplyButton
        name: "OpenMailReplyButton"
        kind: "Button"
        text: "Reply"
        anchors.right: openMailFrame.right
        anchors.rightMargin: 205
        anchors.bottom: openMailFrame.bottom
        anchors.bottomMargin: 80
        width: 78
        height: 22
    }

    Part {
        id: openMailReplyButtonText
        name: "OpenMailReplyButtonText"
        kind: "FontString"
        text: "Reply"
        anchors.horizontalCenter: openMailReplyButton.horizontalCenter
        anchors.verticalCenter: openMailReplyButton.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: openMailScrollChildFrame
        name: "OpenMailScrollChildFrame"
        kind: "Frame"
        anchors.left: openMailScrollFrame.left
        anchors.top: openMailScrollFrame.top
        width: 296
        height: 314.7
    }

    Part {
        id: openMailScrollFrame
        name: "OpenMailScrollFrame"
        kind: "ScrollFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 21
        anchors.top: openMailFrame.top
        anchors.topMargin: 13
        width: 296
        height: 314.7
    }

    Part {
        id: openMailScrollFrameScrollBar
        name: "OpenMailScrollFrameScrollBar"
        kind: "Slider"
        anchors.left: openMailScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 282.7
    }

    Part {
        id: openMailScrollFrameScrollBarScrollDownButton
        name: "OpenMailScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        anchors.horizontalCenter: openMailScrollFrameScrollBar.horizontalCenter
        anchors.top: openMailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: openMailScrollFrameScrollBarScrollUpButton
        name: "OpenMailScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        anchors.horizontalCenter: openMailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: openMailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

}
