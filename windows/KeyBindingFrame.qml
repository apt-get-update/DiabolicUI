// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: keyBindingFrame
    name: "KeyBindingFrame"
    width: 640
    height: 512

    Frame {
        id: keyBindingFrameBinding1
        name: "KeyBindingFrameBinding1"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: 27
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 72
        width: 560
        height: 25
    }

    FontString {
        id: keyBindingFrameBinding17Header
        name: "KeyBindingFrameBinding17Header"
        text: "Chat Functions"
        wowParent: "KeyBindingFrameBinding17"
        anchors.left: keyBindingFrameBinding17.left
        anchors.verticalCenter: keyBindingFrameBinding17.verticalCenter
        width: 87.7
        height: 11.9
    }

    FontString {
        id: keyBindingFrameBinding1Description
        name: "KeyBindingFrameBinding1Description"
        text: "Earth Totem"
        wowParent: "KeyBindingFrameBinding1"
        anchors.left: keyBindingFrameBinding1.left
        anchors.verticalCenter: keyBindingFrameBinding1.verticalCenter
        width: 170
        height: 24
    }

    FontString {
        id: keyBindingFrameBinding1Header
        name: "KeyBindingFrameBinding1Header"
        text: "Movement Keys"
        wowParent: "KeyBindingFrameBinding1"
        anchors.left: keyBindingFrameBinding1.left
        anchors.verticalCenter: keyBindingFrameBinding1.verticalCenter
        width: 97.2
        height: 11.9
    }

    Button {
        id: keyBindingFrameBinding1Key1Button
        name: "KeyBindingFrameBinding1Key1Button"
        wowParent: "KeyBindingFrameBinding1"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 73.5
        width: 177
        height: 22
    }

    FontString {
        id: keyBindingFrameBinding1Key1ButtonText
        name: "KeyBindingFrameBinding1Key1ButtonText"
        wowParent: "KeyBindingFrameBinding1Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding1Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding1Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    FontString {
        id: keyBindingFrameBinding5Header
        name: "KeyBindingFrameBinding5Header"
        wowParent: "KeyBindingFrameBinding5"
        anchors.left: keyBindingFrameBinding5.left
        anchors.verticalCenter: keyBindingFrameBinding5.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: keyBindingFrameBinding7Header
        name: "KeyBindingFrameBinding7Header"
        text: "Targeting Functions"
        wowParent: "KeyBindingFrameBinding7"
        anchors.left: keyBindingFrameBinding7.left
        anchors.verticalCenter: keyBindingFrameBinding7.verticalCenter
        width: 116.1
        height: 11.9
    }

    Button {
        id: keyBindingFrameCancelButton
        name: "KeyBindingFrameCancelButton"
        text: "Cancel"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "all"
        anchors.left: keyBindingFrameOkayButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: keyBindingFrameOkayButton.verticalCenter
        width: 125
        height: 22
    }

    FontString {
        id: keyBindingFrameCancelButtonText
        name: "KeyBindingFrameCancelButtonText"
        text: "Cancel"
        wowParent: "KeyBindingFrameCancelButton"
        anchors.horizontalCenter: keyBindingFrameCancelButton.horizontalCenter
        anchors.verticalCenter: keyBindingFrameCancelButton.verticalCenter
        width: 45.8
        height: 10.3
    }

    CheckButton {
        id: keyBindingFrameCharacterButton
        name: "KeyBindingFrameCharacterButton"
        wowParent: "KeyBindingFrame"
        style: "CheckBox"
        anchors.right: keyBindingFrameDiabolicBand.right
        anchors.rightMargin: 232.6
        anchors.verticalCenter: keyBindingFrameDiabolicBand.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: keyBindingFrameCharacterButtonText
        name: "KeyBindingFrameCharacterButtonText"
        wowParent: "KeyBindingFrameCharacterButton"
        anchors.left: keyBindingFrameCharacterButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: keyBindingFrameCharacterButton.verticalCenter
        width: 183.3
        height: 14.2
    }

    FontString {
        id: keyBindingFrameCommandLabel
        name: "KeyBindingFrameCommandLabel"
        text: "Command"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: 26
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 35
        width: 61.6
        height: 11.9
    }

    // the buttons 16 lower, on the foot, as far in from both sides
    Button {
        id: keyBindingFrameDefaultButton
        name: "KeyBindingFrameDefaultButton"
        text: "Reset To Default"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "place"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: keyBindingFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 130
        height: 22
    }

    Frame {
        id: keyBindingFrameDiabolic
        name: "KeyBindingFrameDiabolic"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: -24
        anchors.top: keyBindingFrame.top
        anchors.topMargin: -40
        width: 634
        height: 598
    }

    Frame {
        id: keyBindingFrameDiabolicBand
        name: "KeyBindingFrameDiabolicBand"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: keyBindingFrameDiabolic.top
        anchors.topMargin: 24
        width: 586
        height: 40
    }

    Frame {
        id: keyBindingFrameDiabolicBorder
        name: "KeyBindingFrameDiabolicBorder"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.top: keyBindingFrameDiabolic.top
        width: 634
        height: 598
    }

    Frame {
        id: keyBindingFrameDiabolicFoot
        name: "KeyBindingFrameDiabolicFoot"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.horizontalCenter: keyBindingFrameDefaultButton.horizontalCenter
        anchors.horizontalCenterOffset: 215
        anchors.top: keyBindingFrameDefaultButton.top
        anchors.topMargin: -6
        width: 588
        height: 35
    }

    Frame {
        id: keyBindingFrameDiabolicTitlePlate
        name: "KeyBindingFrameDiabolicTitlePlate"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.horizontalCenter: keyBindingFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: keyBindingFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    FontString {
        id: keyBindingFrameHeaderText
        name: "KeyBindingFrameHeaderText"
        text: "Key Bindings"
        wowParent: "KeyBindingFrameDiabolicTitlePlate"
        anchors.horizontalCenter: keyBindingFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: keyBindingFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 112.2
        height: 14.2
    }

    FontString {
        id: keyBindingFrameKey1Label
        name: "KeyBindingFrameKey1Label"
        text: "Key 1"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameCommandLabel.right
        anchors.leftMargin: 185
        anchors.verticalCenter: keyBindingFrameCommandLabel.verticalCenter
        width: 32.4
        height: 11.9
    }

    FontString {
        id: keyBindingFrameKey2Label
        name: "KeyBindingFrameKey2Label"
        text: "Key 2"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameKey1Label.right
        anchors.leftMargin: 145
        anchors.verticalCenter: keyBindingFrameKey1Label.verticalCenter
        width: 34
        height: 11.9
    }

    Button {
        id: keyBindingFrameOkayButton
        name: "KeyBindingFrameOkayButton"
        text: "Okay"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "all"
        anchors.left: keyBindingFrameUnbindButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: keyBindingFrameUnbindButton.verticalCenter
        width: 125
        height: 22
    }

    FontString {
        id: keyBindingFrameOkayButtonText
        name: "KeyBindingFrameOkayButtonText"
        text: "Okay"
        wowParent: "KeyBindingFrameOkayButton"
        anchors.horizontalCenter: keyBindingFrameOkayButton.horizontalCenter
        anchors.verticalCenter: keyBindingFrameOkayButton.verticalCenter
        width: 32.4
        height: 10.3
    }

    // what a key was bound to between the list and the foot
    FontString {
        id: keyBindingFrameOutputText
        name: "KeyBindingFrameOutputText"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.horizontalCenter: keyBindingFrame.left
        anchors.horizontalCenterOffset: 293
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 465
        width: 1
        height: 1
    }

    // the list (its rows too) 6 under the column names
    ScrollFrame {
        id: keyBindingFrameScrollFrame
        name: "KeyBindingFrameScrollFrame"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: 2
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 72
        width: 560
        height: 390
    }

    Frame {
        id: keyBindingFrameScrollFrameDiabolicZone
        name: "KeyBindingFrameScrollFrameDiabolicZone"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: keyBindingFrameScrollFrame.top
        anchors.topMargin: -6
        width: 594
        height: 402
    }

    Slider {
        id: keyBindingFrameScrollFrameScrollBar
        name: "KeyBindingFrameScrollFrameScrollBar"
        wowParent: "KeyBindingFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: keyBindingFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: keyBindingFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 358
    }

    Frame {
        id: keyBindingFrameScrollFrameScrollBarDiabolicTrack
        name: "KeyBindingFrameScrollFrameScrollBarDiabolicTrack"
        wowParent: "KeyBindingFrameScrollFrameScrollBar"
        anchors.horizontalCenter: keyBindingFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: keyBindingFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 392
    }

    Button {
        id: keyBindingFrameScrollFrameScrollBarScrollDownButton
        name: "KeyBindingFrameScrollFrameScrollBarScrollDownButton"
        wowParent: "KeyBindingFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: keyBindingFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: keyBindingFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: keyBindingFrameScrollFrameScrollBarScrollUpButton
        name: "KeyBindingFrameScrollFrameScrollBarScrollUpButton"
        wowParent: "KeyBindingFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: keyBindingFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: keyBindingFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: keyBindingFrameScrollFrameScrollChildFrame
        name: "KeyBindingFrameScrollFrameScrollChildFrame"
        wowParent: "KeyBindingFrameScrollFrame"
        anchors.left: keyBindingFrameScrollFrame.left
        anchors.top: keyBindingFrameScrollFrame.top
        anchors.topMargin: -2100
        width: 300
        height: 7775
    }

    Button {
        id: keyBindingFrameUnbindButton
        name: "KeyBindingFrameUnbindButton"
        text: "Unbind Key"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "all"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 210
        anchors.bottom: keyBindingFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 125
        height: 22
    }

    FontString {
        id: keyBindingFrameUnbindButtonText
        name: "KeyBindingFrameUnbindButtonText"
        text: "Unbind Key"
        wowParent: "KeyBindingFrameUnbindButton"
        anchors.horizontalCenter: keyBindingFrameUnbindButton.horizontalCenter
        anchors.verticalCenter: keyBindingFrameUnbindButton.verticalCenter
        width: 73.5
        height: 10.3
    }

    WowRow {
        name: "KeyBindingButtons"
        parts: ["KeyBindingFrameUnbindButton", "KeyBindingFrameOkayButton", "KeyBindingFrameCancelButton"]
        fit: "equal"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 210
        anchors.right: keyBindingFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: keyBindingFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

    Ghost { id: keyBindingFrameBinding17; name: "KeyBindingFrameBinding17"; x: 27; y: 440; width: 560; height: 25 }
    Ghost { id: keyBindingFrameBinding5; name: "KeyBindingFrameBinding5"; x: 27; y: 164; width: 560; height: 25 }
    Ghost { id: keyBindingFrameBinding7; name: "KeyBindingFrameBinding7"; x: 27; y: 210; width: 560; height: 25 }
}
