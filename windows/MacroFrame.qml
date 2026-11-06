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

    CheckButton {
        id: macroButton10
        name: "MacroButton10"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton9.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton9.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton10Name
        name: "MacroButton10Name"
        wowParent: "MacroButton10"
        anchors.horizontalCenter: macroButton10.horizontalCenter
        anchors.bottom: macroButton10.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton11
        name: "MacroButton11"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton10.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton10.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton11Name
        name: "MacroButton11Name"
        wowParent: "MacroButton11"
        anchors.horizontalCenter: macroButton11.horizontalCenter
        anchors.bottom: macroButton11.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton12
        name: "MacroButton12"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton11.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton11.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton12Name
        name: "MacroButton12Name"
        wowParent: "MacroButton12"
        anchors.horizontalCenter: macroButton12.horizontalCenter
        anchors.bottom: macroButton12.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton13
        name: "MacroButton13"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton7.horizontalCenter
        anchors.top: macroButton7.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    FontString {
        id: macroButton13Name
        name: "MacroButton13Name"
        wowParent: "MacroButton13"
        anchors.horizontalCenter: macroButton13.horizontalCenter
        anchors.bottom: macroButton13.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton14
        name: "MacroButton14"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton13.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton13.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton14Name
        name: "MacroButton14Name"
        wowParent: "MacroButton14"
        anchors.horizontalCenter: macroButton14.horizontalCenter
        anchors.bottom: macroButton14.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton15
        name: "MacroButton15"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton14.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton14.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton15Name
        name: "MacroButton15Name"
        wowParent: "MacroButton15"
        anchors.horizontalCenter: macroButton15.horizontalCenter
        anchors.bottom: macroButton15.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton16
        name: "MacroButton16"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton15.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton15.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton16Name
        name: "MacroButton16Name"
        wowParent: "MacroButton16"
        anchors.horizontalCenter: macroButton16.horizontalCenter
        anchors.bottom: macroButton16.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton17
        name: "MacroButton17"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton16.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton16.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton17Name
        name: "MacroButton17Name"
        wowParent: "MacroButton17"
        anchors.horizontalCenter: macroButton17.horizontalCenter
        anchors.bottom: macroButton17.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton18
        name: "MacroButton18"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton17.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton17.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton18Name
        name: "MacroButton18Name"
        wowParent: "MacroButton18"
        anchors.horizontalCenter: macroButton18.horizontalCenter
        anchors.bottom: macroButton18.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton19
        name: "MacroButton19"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton13.horizontalCenter
        anchors.top: macroButton13.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    FontString {
        id: macroButton19Name
        name: "MacroButton19Name"
        wowParent: "MacroButton19"
        anchors.horizontalCenter: macroButton19.horizontalCenter
        anchors.bottom: macroButton19.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
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

    CheckButton {
        id: macroButton2
        name: "MacroButton2"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton1.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton1.verticalCenter
        width: 36
        height: 36
    }

    CheckButton {
        id: macroButton20
        name: "MacroButton20"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton19.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton19.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton20Name
        name: "MacroButton20Name"
        wowParent: "MacroButton20"
        anchors.horizontalCenter: macroButton20.horizontalCenter
        anchors.bottom: macroButton20.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton21
        name: "MacroButton21"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton20.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton20.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton21Name
        name: "MacroButton21Name"
        wowParent: "MacroButton21"
        anchors.horizontalCenter: macroButton21.horizontalCenter
        anchors.bottom: macroButton21.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton22
        name: "MacroButton22"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton21.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton21.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton22Name
        name: "MacroButton22Name"
        wowParent: "MacroButton22"
        anchors.horizontalCenter: macroButton22.horizontalCenter
        anchors.bottom: macroButton22.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton23
        name: "MacroButton23"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton22.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton22.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton23Name
        name: "MacroButton23Name"
        wowParent: "MacroButton23"
        anchors.horizontalCenter: macroButton23.horizontalCenter
        anchors.bottom: macroButton23.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton24
        name: "MacroButton24"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton23.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton23.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton24Name
        name: "MacroButton24Name"
        wowParent: "MacroButton24"
        anchors.horizontalCenter: macroButton24.horizontalCenter
        anchors.bottom: macroButton24.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton25
        name: "MacroButton25"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton19.horizontalCenter
        anchors.top: macroButton19.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    FontString {
        id: macroButton25Name
        name: "MacroButton25Name"
        wowParent: "MacroButton25"
        anchors.horizontalCenter: macroButton25.horizontalCenter
        anchors.bottom: macroButton25.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton26
        name: "MacroButton26"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton25.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton25.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton26Name
        name: "MacroButton26Name"
        wowParent: "MacroButton26"
        anchors.horizontalCenter: macroButton26.horizontalCenter
        anchors.bottom: macroButton26.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton27
        name: "MacroButton27"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton26.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton26.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton27Name
        name: "MacroButton27Name"
        wowParent: "MacroButton27"
        anchors.horizontalCenter: macroButton27.horizontalCenter
        anchors.bottom: macroButton27.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton28
        name: "MacroButton28"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton27.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton27.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton28Name
        name: "MacroButton28Name"
        wowParent: "MacroButton28"
        anchors.horizontalCenter: macroButton28.horizontalCenter
        anchors.bottom: macroButton28.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton29
        name: "MacroButton29"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton28.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton28.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton29Name
        name: "MacroButton29Name"
        wowParent: "MacroButton29"
        anchors.horizontalCenter: macroButton29.horizontalCenter
        anchors.bottom: macroButton29.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    FontString {
        id: macroButton2Name
        name: "MacroButton2Name"
        text: "DUI Holy Start"
        wowParent: "MacroButton2"
        anchors.horizontalCenter: macroButton2.horizontalCenter
        anchors.bottom: macroButton2.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton3
        name: "MacroButton3"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton2.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton2.verticalCenter
        width: 36
        height: 36
    }

    CheckButton {
        id: macroButton30
        name: "MacroButton30"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton29.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton29.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton30Name
        name: "MacroButton30Name"
        wowParent: "MacroButton30"
        anchors.horizontalCenter: macroButton30.horizontalCenter
        anchors.bottom: macroButton30.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton31
        name: "MacroButton31"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton25.horizontalCenter
        anchors.top: macroButton25.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    FontString {
        id: macroButton31Name
        name: "MacroButton31Name"
        wowParent: "MacroButton31"
        anchors.horizontalCenter: macroButton31.horizontalCenter
        anchors.bottom: macroButton31.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton32
        name: "MacroButton32"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton31.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton31.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton32Name
        name: "MacroButton32Name"
        wowParent: "MacroButton32"
        anchors.horizontalCenter: macroButton32.horizontalCenter
        anchors.bottom: macroButton32.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton33
        name: "MacroButton33"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton32.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton32.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton33Name
        name: "MacroButton33Name"
        wowParent: "MacroButton33"
        anchors.horizontalCenter: macroButton33.horizontalCenter
        anchors.bottom: macroButton33.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton34
        name: "MacroButton34"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton33.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton33.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton34Name
        name: "MacroButton34Name"
        wowParent: "MacroButton34"
        anchors.horizontalCenter: macroButton34.horizontalCenter
        anchors.bottom: macroButton34.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton35
        name: "MacroButton35"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton34.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton34.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton35Name
        name: "MacroButton35Name"
        wowParent: "MacroButton35"
        anchors.horizontalCenter: macroButton35.horizontalCenter
        anchors.bottom: macroButton35.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton36
        name: "MacroButton36"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton35.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton35.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton36Name
        name: "MacroButton36Name"
        wowParent: "MacroButton36"
        anchors.horizontalCenter: macroButton36.horizontalCenter
        anchors.bottom: macroButton36.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    FontString {
        id: macroButton3Name
        name: "MacroButton3Name"
        text: "DUI Shadow End"
        wowParent: "MacroButton3"
        anchors.horizontalCenter: macroButton3.horizontalCenter
        anchors.bottom: macroButton3.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton4
        name: "MacroButton4"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton3.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton3.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton4Name
        name: "MacroButton4Name"
        text: "DUI Shadow Start"
        wowParent: "MacroButton4"
        anchors.horizontalCenter: macroButton4.horizontalCenter
        anchors.bottom: macroButton4.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton5
        name: "MacroButton5"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton4.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton4.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton5Name
        name: "MacroButton5Name"
        wowParent: "MacroButton5"
        anchors.horizontalCenter: macroButton5.horizontalCenter
        anchors.bottom: macroButton5.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton6
        name: "MacroButton6"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton5.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton5.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton6Name
        name: "MacroButton6Name"
        wowParent: "MacroButton6"
        anchors.horizontalCenter: macroButton6.horizontalCenter
        anchors.bottom: macroButton6.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton7
        name: "MacroButton7"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton1.horizontalCenter
        anchors.top: macroButton1.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    FontString {
        id: macroButton7Name
        name: "MacroButton7Name"
        wowParent: "MacroButton7"
        anchors.horizontalCenter: macroButton7.horizontalCenter
        anchors.bottom: macroButton7.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton8
        name: "MacroButton8"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton7.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton7.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton8Name
        name: "MacroButton8Name"
        wowParent: "MacroButton8"
        anchors.horizontalCenter: macroButton8.horizontalCenter
        anchors.bottom: macroButton8.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    CheckButton {
        id: macroButton9
        name: "MacroButton9"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton8.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton8.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: macroButton9Name
        name: "MacroButton9Name"
        wowParent: "MacroButton9"
        anchors.horizontalCenter: macroButton9.horizontalCenter
        anchors.bottom: macroButton9.bottom
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
