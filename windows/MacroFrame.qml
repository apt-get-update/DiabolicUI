// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: macroFrame
    name: "MacroFrame"
    width: 384
    height: 512

    CheckButton {
        id: macroButton1
        name: "MacroButton1"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButtonContainer.left
        anchors.leftMargin: 6
        anchors.top: macroButtonContainer.top
        anchors.topMargin: 6
        width: 36
        height: 36
    }

    FontString {
        id: macroButton1Name
        name: "MacroButton1Name"
        text: "DUI Holy End"
        wowParent: "MacroButton1"
        anchors.horizontalCenter: macroButton1.horizontalCenter
        anchors.bottom: macroButton1.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Frame {
        id: macroButtonContainer
        name: "MacroButtonContainer"
        wowParent: "MacroButtonScrollFrame"
        anchors.left: macroButtonScrollFrame.left
        anchors.top: macroButtonScrollFrame.top
        width: 285
        height: 10
    }

    // the icons and the macro 20 up and 6 left (as far from the band as from the
    // foot's bar, from the sides)
    ScrollFrame {
        id: macroButtonScrollFrame
        name: "MacroButtonScrollFrame"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.left: macroFrame.left
        anchors.leftMargin: 17
        anchors.top: macroFrame.top
        anchors.topMargin: 56
        width: 294
        height: 146
    }

    Frame {
        id: macroButtonScrollFrameDiabolicZone
        name: "MacroButtonScrollFrameDiabolicZone"
        wowParent: "MacroFrame"
        anchors.left: macroButtonScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: macroButtonScrollFrame.top
        anchors.topMargin: -6
        width: 328
        height: 158
    }

    Slider {
        id: macroButtonScrollFrameScrollBar
        name: "MacroButtonScrollFrameScrollBar"
        wowParent: "MacroButtonScrollFrame"
        style: "ScrollBar"
        anchors.left: macroButtonScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: macroButtonScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 114
    }

    Frame {
        id: macroButtonScrollFrameScrollBarDiabolicTrack
        name: "MacroButtonScrollFrameScrollBarDiabolicTrack"
        wowParent: "MacroButtonScrollFrameScrollBar"
        anchors.horizontalCenter: macroButtonScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: macroButtonScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 148
    }

    Button {
        id: macroButtonScrollFrameScrollBarScrollDownButton
        name: "MacroButtonScrollFrameScrollBarScrollDownButton"
        wowParent: "MacroButtonScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: macroButtonScrollFrameScrollBar.horizontalCenter
        anchors.top: macroButtonScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: macroButtonScrollFrameScrollBarScrollUpButton
        name: "MacroButtonScrollFrameScrollBarScrollUpButton"
        wowParent: "MacroButtonScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: macroButtonScrollFrameScrollBar.horizontalCenter
        anchors.bottom: macroButtonScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    // the buttons 10 down (30 over the window's bottom)
    Button {
        id: macroDeleteButton
        name: "MacroDeleteButton"
        text: "Delete"
        wowParent: "MacroFrame"
        style: "Button"
        pin: "place"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: macroFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 80
        height: 22
    }

    Button {
        id: macroEditButton
        name: "MacroEditButton"
        text: "Change Name/Icon"
        wowParent: "MacroFrame"
        style: "Button"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 51
        anchors.top: macroFrameSelectedMacroBackground.top
        anchors.topMargin: 30
        width: 170
        height: 22
    }

    FontString {
        id: macroEditButtonText
        name: "MacroEditButtonText"
        text: "Change Name/Icon"
        wowParent: "MacroEditButton"
        anchors.horizontalCenter: macroEditButton.horizontalCenter
        anchors.verticalCenter: macroEditButton.verticalCenter
        width: 135.1
        height: 11.9
    }

    Button {
        id: macroExitButton
        name: "MacroExitButton"
        text: "Exit"
        wowParent: "MacroFrame"
        style: "Button"
        pin: "all"
        anchors.left: macroNewButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: macroNewButton.verticalCenter
        width: 80
        height: 22
    }

    FontString {
        id: macroExitButtonText
        name: "MacroExitButtonText"
        text: "Exit"
        wowParent: "MacroExitButton"
        anchors.horizontalCenter: macroExitButton.horizontalCenter
        anchors.verticalCenter: macroExitButton.verticalCenter
        width: 32.4
        height: 11.9
    }

    // the count of characters right of "Enter Macro Commands:" (Blizzard's
    // under the text, over the foot)
    FontString {
        id: macroFrameCharLimitText
        name: "MacroFrameCharLimitText"
        text: "80/255 Characters Used"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.right: macroFrameScrollFrame.right
        anchors.bottom: macroFrameScrollFrame.top
        anchors.bottomMargin: 8
        width: 129.6
        height: 10
    }

    Button {
        id: macroFrameCloseButton
        name: "MacroFrameCloseButton"
        wowParent: "MacroFrame"
        style: "CloseButton"
        anchors.horizontalCenter: macroFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: macroFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: macroFrameDiabolic
        name: "MacroFrameDiabolic"
        wowParent: "MacroFrame"
        anchors.left: macroFrame.left
        anchors.leftMargin: -24
        anchors.top: macroFrame.top
        anchors.topMargin: -28
        width: 398
        height: 501
    }

    Frame {
        id: macroFrameDiabolicBorder
        name: "MacroFrameDiabolicBorder"
        wowParent: "MacroFrameDiabolic"
        anchors.left: macroFrameDiabolic.left
        anchors.top: macroFrameDiabolic.top
        anchors.topMargin: 32
        width: 398
        height: 469
    }

    Frame {
        id: macroFrameDiabolicFoot
        name: "MacroFrameDiabolicFoot"
        wowParent: "MacroFrameDiabolic"
        anchors.horizontalCenter: macroExitButton.horizontalCenter
        anchors.horizontalCenterOffset: -122
        anchors.top: macroExitButton.top
        anchors.topMargin: -6
        width: 352
        height: 35
    }

    Frame {
        id: macroFrameDiabolicRail
        name: "MacroFrameDiabolicRail"
        wowParent: "MacroFrameDiabolic"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: macroFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Frame {
        id: macroFrameDiabolicSocket
        name: "MacroFrameDiabolicSocket"
        wowParent: "MacroFrameDiabolic"
        anchors.right: macroFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: macroFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: macroFrameDiabolicTitlePlate
        name: "MacroFrameDiabolicTitlePlate"
        wowParent: "MacroFrameDiabolic"
        anchors.horizontalCenter: macroFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: macroFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    FontString {
        id: macroFrameEnterMacroText
        name: "MacroFrameEnterMacroText"
        text: "Enter Macro Commands:"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 8
        anchors.top: macroFrameSelectedMacroBackground.bottom
        width: 131.2
        height: 10.3
    }

    ScrollFrame {
        id: macroFrameScrollFrame
        name: "MacroFrameScrollFrame"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 11
        anchors.top: macroFrameSelectedMacroBackground.bottom
        anchors.topMargin: 18
        width: 286
        height: 85
    }

    Frame {
        id: macroFrameScrollFrameDiabolicZone
        name: "MacroFrameScrollFrameDiabolicZone"
        wowParent: "MacroFrameScrollFrame"
        anchors.left: macroFrameScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: macroFrameScrollFrame.top
        anchors.topMargin: -6
        width: 320
        height: 97
    }

    Slider {
        id: macroFrameScrollFrameScrollBar
        name: "MacroFrameScrollFrameScrollBar"
        wowParent: "MacroFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: macroFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: macroFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 53
    }

    Frame {
        id: macroFrameScrollFrameScrollBarDiabolicTrack
        name: "MacroFrameScrollFrameScrollBarDiabolicTrack"
        wowParent: "MacroFrameScrollFrameScrollBar"
        anchors.horizontalCenter: macroFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: macroFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 87
    }

    Button {
        id: macroFrameScrollFrameScrollBarScrollDownButton
        name: "MacroFrameScrollFrameScrollBarScrollDownButton"
        wowParent: "MacroFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: macroFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: macroFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: macroFrameScrollFrameScrollBarScrollUpButton
        name: "MacroFrameScrollFrameScrollBarScrollUpButton"
        wowParent: "MacroFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: macroFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: macroFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: macroFrameSelectedMacroBackground
        name: "MacroFrameSelectedMacroBackground"
        pin: "place"
        anchors.left: macroFrame.left
        anchors.leftMargin: 10
        anchors.top: macroFrame.top
        anchors.topMargin: 208
        width: 64
        height: 64
    }

    CheckButton {
        id: macroFrameSelectedMacroButton
        name: "MacroFrameSelectedMacroButton"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 14
        anchors.top: macroFrameSelectedMacroBackground.top
        anchors.topMargin: 14
        width: 36
        height: 36
    }

    FontString {
        id: macroFrameSelectedMacroButtonName
        name: "MacroFrameSelectedMacroButtonName"
        wowParent: "MacroFrameSelectedMacroButton"
        anchors.horizontalCenter: macroFrameSelectedMacroButton.horizontalCenter
        anchors.bottom: macroFrameSelectedMacroButton.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    FontString {
        id: macroFrameSelectedMacroName
        name: "MacroFrameSelectedMacroName"
        text: "DUI Holy End"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.right
        anchors.leftMargin: -4
        anchors.top: macroFrameSelectedMacroBackground.top
        anchors.topMargin: 10
        width: 256
        height: 16
    }

    Button {
        id: macroFrameTab1
        name: "MacroFrameTab1"
        text: "General Macros"
        wowParent: "MacroFrame"
        style: "Banner"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: macroFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: macroFrameTab2
        name: "MacroFrameTab2"
        text: "Padirac Specific Macros"
        wowParent: "MacroFrame"
        style: "Banner"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: macroFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    EditBox {
        id: macroFrameText
        name: "MacroFrameText"
        wowParent: "MacroFrameScrollFrame"
        anchors.left: macroFrameScrollFrame.left
        anchors.top: macroFrameScrollFrame.top
        width: 286
        height: 30.8
    }

    Frame {
        id: macroFrameTextBackground
        name: "MacroFrameTextBackground"
        wowParent: "MacroFrame"
        anchors.left: macroFrame.left
        anchors.leftMargin: 18
        anchors.top: macroFrame.top
        anchors.topMargin: 305
        width: 322
        height: 95
    }

    Button {
        id: macroFrameTextButton
        name: "MacroFrameTextButton"
        wowParent: "MacroFrame"
        anchors.left: macroFrameText.left
        anchors.top: macroFrameText.top
        width: 286
        height: 85
    }

    Button {
        id: macroNewButton
        name: "MacroNewButton"
        text: "New"
        wowParent: "MacroFrame"
        style: "Button"
        pin: "all"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 195
        anchors.bottom: macroFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 80
        height: 22
    }

    FontString {
        id: macroNewButtonText
        name: "MacroNewButtonText"
        text: "New"
        wowParent: "MacroNewButton"
        anchors.horizontalCenter: macroNewButton.horizontalCenter
        anchors.verticalCenter: macroNewButton.verticalCenter
        width: 30.8
        height: 11.9
    }

    WowRow {
        name: "MacroButtons"
        parts: ["MacroNewButton", "MacroExitButton"]
        fit: "equal"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 195
        anchors.right: macroFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: macroFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

}
