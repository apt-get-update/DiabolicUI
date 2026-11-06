// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: macroFrame
    name: "MacroFrame"
    width: 384
    height: 512

    Part {
        id: macroButton1
        name: "MacroButton1"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButtonContainer.left
        anchors.leftMargin: 6
        anchors.top: macroButtonContainer.top
        anchors.topMargin: 6
        width: 36
        height: 36
    }

    Part {
        id: macroButton10
        name: "MacroButton10"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton9.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton9.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton10Name
        name: "MacroButton10Name"
        kind: "FontString"
        wowParent: "MacroButton10"
        anchors.horizontalCenter: macroButton10.horizontalCenter
        anchors.bottom: macroButton10.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton11
        name: "MacroButton11"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton10.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton10.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton11Name
        name: "MacroButton11Name"
        kind: "FontString"
        wowParent: "MacroButton11"
        anchors.horizontalCenter: macroButton11.horizontalCenter
        anchors.bottom: macroButton11.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton12
        name: "MacroButton12"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton11.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton11.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton12Name
        name: "MacroButton12Name"
        kind: "FontString"
        wowParent: "MacroButton12"
        anchors.horizontalCenter: macroButton12.horizontalCenter
        anchors.bottom: macroButton12.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton13
        name: "MacroButton13"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton7.horizontalCenter
        anchors.top: macroButton7.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    Part {
        id: macroButton13Name
        name: "MacroButton13Name"
        kind: "FontString"
        wowParent: "MacroButton13"
        anchors.horizontalCenter: macroButton13.horizontalCenter
        anchors.bottom: macroButton13.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton14
        name: "MacroButton14"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton13.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton13.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton14Name
        name: "MacroButton14Name"
        kind: "FontString"
        wowParent: "MacroButton14"
        anchors.horizontalCenter: macroButton14.horizontalCenter
        anchors.bottom: macroButton14.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton15
        name: "MacroButton15"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton14.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton14.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton15Name
        name: "MacroButton15Name"
        kind: "FontString"
        wowParent: "MacroButton15"
        anchors.horizontalCenter: macroButton15.horizontalCenter
        anchors.bottom: macroButton15.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton16
        name: "MacroButton16"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton15.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton15.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton16Name
        name: "MacroButton16Name"
        kind: "FontString"
        wowParent: "MacroButton16"
        anchors.horizontalCenter: macroButton16.horizontalCenter
        anchors.bottom: macroButton16.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton17
        name: "MacroButton17"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton16.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton16.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton17Name
        name: "MacroButton17Name"
        kind: "FontString"
        wowParent: "MacroButton17"
        anchors.horizontalCenter: macroButton17.horizontalCenter
        anchors.bottom: macroButton17.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton18
        name: "MacroButton18"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton17.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton17.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton18Name
        name: "MacroButton18Name"
        kind: "FontString"
        wowParent: "MacroButton18"
        anchors.horizontalCenter: macroButton18.horizontalCenter
        anchors.bottom: macroButton18.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton19
        name: "MacroButton19"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton13.horizontalCenter
        anchors.top: macroButton13.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    Part {
        id: macroButton19Name
        name: "MacroButton19Name"
        kind: "FontString"
        wowParent: "MacroButton19"
        anchors.horizontalCenter: macroButton19.horizontalCenter
        anchors.bottom: macroButton19.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton1Name
        name: "MacroButton1Name"
        kind: "FontString"
        text: "DUI Holy End"
        wowParent: "MacroButton1"
        anchors.horizontalCenter: macroButton1.horizontalCenter
        anchors.bottom: macroButton1.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton2
        name: "MacroButton2"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton1.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton1.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton20
        name: "MacroButton20"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton19.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton19.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton20Name
        name: "MacroButton20Name"
        kind: "FontString"
        wowParent: "MacroButton20"
        anchors.horizontalCenter: macroButton20.horizontalCenter
        anchors.bottom: macroButton20.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton21
        name: "MacroButton21"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton20.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton20.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton21Name
        name: "MacroButton21Name"
        kind: "FontString"
        wowParent: "MacroButton21"
        anchors.horizontalCenter: macroButton21.horizontalCenter
        anchors.bottom: macroButton21.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton22
        name: "MacroButton22"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton21.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton21.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton22Name
        name: "MacroButton22Name"
        kind: "FontString"
        wowParent: "MacroButton22"
        anchors.horizontalCenter: macroButton22.horizontalCenter
        anchors.bottom: macroButton22.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton23
        name: "MacroButton23"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton22.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton22.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton23Name
        name: "MacroButton23Name"
        kind: "FontString"
        wowParent: "MacroButton23"
        anchors.horizontalCenter: macroButton23.horizontalCenter
        anchors.bottom: macroButton23.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton24
        name: "MacroButton24"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton23.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton23.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton24Name
        name: "MacroButton24Name"
        kind: "FontString"
        wowParent: "MacroButton24"
        anchors.horizontalCenter: macroButton24.horizontalCenter
        anchors.bottom: macroButton24.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton25
        name: "MacroButton25"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton19.horizontalCenter
        anchors.top: macroButton19.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    Part {
        id: macroButton25Name
        name: "MacroButton25Name"
        kind: "FontString"
        wowParent: "MacroButton25"
        anchors.horizontalCenter: macroButton25.horizontalCenter
        anchors.bottom: macroButton25.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton26
        name: "MacroButton26"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton25.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton25.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton26Name
        name: "MacroButton26Name"
        kind: "FontString"
        wowParent: "MacroButton26"
        anchors.horizontalCenter: macroButton26.horizontalCenter
        anchors.bottom: macroButton26.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton27
        name: "MacroButton27"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton26.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton26.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton27Name
        name: "MacroButton27Name"
        kind: "FontString"
        wowParent: "MacroButton27"
        anchors.horizontalCenter: macroButton27.horizontalCenter
        anchors.bottom: macroButton27.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton28
        name: "MacroButton28"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton27.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton27.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton28Name
        name: "MacroButton28Name"
        kind: "FontString"
        wowParent: "MacroButton28"
        anchors.horizontalCenter: macroButton28.horizontalCenter
        anchors.bottom: macroButton28.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton29
        name: "MacroButton29"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton28.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton28.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton29Name
        name: "MacroButton29Name"
        kind: "FontString"
        wowParent: "MacroButton29"
        anchors.horizontalCenter: macroButton29.horizontalCenter
        anchors.bottom: macroButton29.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton2Name
        name: "MacroButton2Name"
        kind: "FontString"
        text: "DUI Holy Start"
        wowParent: "MacroButton2"
        anchors.horizontalCenter: macroButton2.horizontalCenter
        anchors.bottom: macroButton2.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton3
        name: "MacroButton3"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton2.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton2.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton30
        name: "MacroButton30"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton29.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton29.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton30Name
        name: "MacroButton30Name"
        kind: "FontString"
        wowParent: "MacroButton30"
        anchors.horizontalCenter: macroButton30.horizontalCenter
        anchors.bottom: macroButton30.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton31
        name: "MacroButton31"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton25.horizontalCenter
        anchors.top: macroButton25.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    Part {
        id: macroButton31Name
        name: "MacroButton31Name"
        kind: "FontString"
        wowParent: "MacroButton31"
        anchors.horizontalCenter: macroButton31.horizontalCenter
        anchors.bottom: macroButton31.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton32
        name: "MacroButton32"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton31.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton31.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton32Name
        name: "MacroButton32Name"
        kind: "FontString"
        wowParent: "MacroButton32"
        anchors.horizontalCenter: macroButton32.horizontalCenter
        anchors.bottom: macroButton32.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton33
        name: "MacroButton33"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton32.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton32.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton33Name
        name: "MacroButton33Name"
        kind: "FontString"
        wowParent: "MacroButton33"
        anchors.horizontalCenter: macroButton33.horizontalCenter
        anchors.bottom: macroButton33.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton34
        name: "MacroButton34"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton33.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton33.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton34Name
        name: "MacroButton34Name"
        kind: "FontString"
        wowParent: "MacroButton34"
        anchors.horizontalCenter: macroButton34.horizontalCenter
        anchors.bottom: macroButton34.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton35
        name: "MacroButton35"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton34.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton34.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton35Name
        name: "MacroButton35Name"
        kind: "FontString"
        wowParent: "MacroButton35"
        anchors.horizontalCenter: macroButton35.horizontalCenter
        anchors.bottom: macroButton35.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton36
        name: "MacroButton36"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton35.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton35.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton36Name
        name: "MacroButton36Name"
        kind: "FontString"
        wowParent: "MacroButton36"
        anchors.horizontalCenter: macroButton36.horizontalCenter
        anchors.bottom: macroButton36.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton3Name
        name: "MacroButton3Name"
        kind: "FontString"
        text: "DUI Shadow End"
        wowParent: "MacroButton3"
        anchors.horizontalCenter: macroButton3.horizontalCenter
        anchors.bottom: macroButton3.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton4
        name: "MacroButton4"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton3.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton3.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton4Name
        name: "MacroButton4Name"
        kind: "FontString"
        text: "DUI Shadow Start"
        wowParent: "MacroButton4"
        anchors.horizontalCenter: macroButton4.horizontalCenter
        anchors.bottom: macroButton4.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton5
        name: "MacroButton5"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton4.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton4.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton5Name
        name: "MacroButton5Name"
        kind: "FontString"
        wowParent: "MacroButton5"
        anchors.horizontalCenter: macroButton5.horizontalCenter
        anchors.bottom: macroButton5.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton6
        name: "MacroButton6"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton5.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton5.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton6Name
        name: "MacroButton6Name"
        kind: "FontString"
        wowParent: "MacroButton6"
        anchors.horizontalCenter: macroButton6.horizontalCenter
        anchors.bottom: macroButton6.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton7
        name: "MacroButton7"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.horizontalCenter: macroButton1.horizontalCenter
        anchors.top: macroButton1.bottom
        anchors.topMargin: 10
        width: 36
        height: 36
    }

    Part {
        id: macroButton7Name
        name: "MacroButton7Name"
        kind: "FontString"
        wowParent: "MacroButton7"
        anchors.horizontalCenter: macroButton7.horizontalCenter
        anchors.bottom: macroButton7.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton8
        name: "MacroButton8"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton7.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton7.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton8Name
        name: "MacroButton8Name"
        kind: "FontString"
        wowParent: "MacroButton8"
        anchors.horizontalCenter: macroButton8.horizontalCenter
        anchors.bottom: macroButton8.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButton9
        name: "MacroButton9"
        kind: "CheckButton"
        wowParent: "MacroButtonContainer"
        anchors.left: macroButton8.right
        anchors.leftMargin: 13
        anchors.verticalCenter: macroButton8.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: macroButton9Name
        name: "MacroButton9Name"
        kind: "FontString"
        wowParent: "MacroButton9"
        anchors.horizontalCenter: macroButton9.horizontalCenter
        anchors.bottom: macroButton9.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroButtonContainer
        name: "MacroButtonContainer"
        kind: "Frame"
        wowParent: "MacroButtonScrollFrame"
        anchors.left: macroButtonScrollFrame.left
        anchors.top: macroButtonScrollFrame.top
        width: 285
        height: 10
    }

    // the icons and the macro 20 up and 6 left (as far from the band as from the
    // foot's bar, from the sides)
    Part {
        id: macroButtonScrollFrame
        name: "MacroButtonScrollFrame"
        kind: "ScrollFrame"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.left: macroFrame.left
        anchors.leftMargin: 17
        anchors.top: macroFrame.top
        anchors.topMargin: 56
        width: 294
        height: 146
    }

    Part {
        id: macroButtonScrollFrameDiabolicZone
        name: "MacroButtonScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "MacroFrame"
        anchors.left: macroButtonScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: macroButtonScrollFrame.top
        anchors.topMargin: -6
        width: 328
        height: 158
    }

    Part {
        id: macroButtonScrollFrameScrollBar
        name: "MacroButtonScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "MacroButtonScrollFrame"
        anchors.left: macroButtonScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: macroButtonScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 114
    }

    Part {
        id: macroButtonScrollFrameScrollBarDiabolicTrack
        name: "MacroButtonScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "MacroButtonScrollFrameScrollBar"
        anchors.horizontalCenter: macroButtonScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: macroButtonScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 148
    }

    Part {
        id: macroButtonScrollFrameScrollBarScrollDownButton
        name: "MacroButtonScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "MacroButtonScrollFrameScrollBar"
        anchors.horizontalCenter: macroButtonScrollFrameScrollBar.horizontalCenter
        anchors.top: macroButtonScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: macroButtonScrollFrameScrollBarScrollUpButton
        name: "MacroButtonScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "MacroButtonScrollFrameScrollBar"
        anchors.horizontalCenter: macroButtonScrollFrameScrollBar.horizontalCenter
        anchors.bottom: macroButtonScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    // the buttons 10 down (30 over the window's bottom)
    Part {
        id: macroDeleteButton
        name: "MacroDeleteButton"
        kind: "Button"
        text: "Delete"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.left: macroFrame.left
        anchors.leftMargin: 17
        anchors.bottom: macroFrame.bottom
        anchors.bottomMargin: 69
        width: 80
        height: 22
    }

    Part {
        id: macroEditButton
        name: "MacroEditButton"
        kind: "Button"
        text: "Change Name/Icon"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 51
        anchors.top: macroFrameSelectedMacroBackground.top
        anchors.topMargin: 30
        width: 170
        height: 22
    }

    Part {
        id: macroEditButtonText
        name: "MacroEditButtonText"
        kind: "FontString"
        text: "Change Name/Icon"
        wowParent: "MacroEditButton"
        anchors.horizontalCenter: macroEditButton.horizontalCenter
        anchors.verticalCenter: macroEditButton.verticalCenter
        width: 135.1
        height: 11.9
    }

    Part {
        id: macroExitButton
        name: "MacroExitButton"
        kind: "Button"
        text: "Exit"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.horizontalCenter: macroFrame.left
        anchors.horizontalCenterOffset: 303
        anchors.verticalCenter: macroFrame.top
        anchors.verticalCenterOffset: 432
        width: 77.5
        height: 22
    }

    Part {
        id: macroExitButtonText
        name: "MacroExitButtonText"
        kind: "FontString"
        text: "Exit"
        wowParent: "MacroExitButton"
        anchors.horizontalCenter: macroExitButton.horizontalCenter
        anchors.verticalCenter: macroExitButton.verticalCenter
        width: 32.4
        height: 11.9
    }

    // the count of characters right of "Enter Macro Commands:" (Blizzard's
    // under the text, over the foot)
    Part {
        id: macroFrameCharLimitText
        name: "MacroFrameCharLimitText"
        kind: "FontString"
        text: "80/255 Characters Used"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.right: macroFrameScrollFrame.right
        anchors.bottom: macroFrameScrollFrame.top
        anchors.bottomMargin: 8
        width: 129.6
        height: 10
    }

    Part {
        id: macroFrameCloseButton
        name: "MacroFrameCloseButton"
        kind: "Button"
        wowParent: "MacroFrame"
        anchors.horizontalCenter: macroFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: macroFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: macroFrameDiabolic
        name: "MacroFrameDiabolic"
        kind: "Frame"
        wowParent: "MacroFrame"
        anchors.left: macroFrame.left
        anchors.leftMargin: -24
        anchors.top: macroFrame.top
        anchors.topMargin: -28
        width: 398
        height: 501
    }

    Part {
        id: macroFrameDiabolicBorder
        name: "MacroFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "MacroFrameDiabolic"
        anchors.left: macroFrameDiabolic.left
        anchors.top: macroFrameDiabolic.top
        anchors.topMargin: 32
        width: 398
        height: 469
    }

    Part {
        id: macroFrameDiabolicFoot
        name: "MacroFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "MacroFrameDiabolic"
        anchors.horizontalCenter: macroExitButton.horizontalCenter
        anchors.horizontalCenterOffset: -127.9
        anchors.top: macroExitButton.top
        anchors.topMargin: -6
        width: 352
        height: 35
    }

    Part {
        id: macroFrameDiabolicRail
        name: "MacroFrameDiabolicRail"
        kind: "Frame"
        wowParent: "MacroFrameDiabolic"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: macroFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Part {
        id: macroFrameDiabolicSocket
        name: "MacroFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "MacroFrameDiabolic"
        anchors.right: macroFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: macroFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: macroFrameDiabolicTitlePlate
        name: "MacroFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "MacroFrameDiabolic"
        anchors.horizontalCenter: macroFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: macroFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: macroFrameEnterMacroText
        name: "MacroFrameEnterMacroText"
        kind: "FontString"
        text: "Enter Macro Commands:"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 8
        anchors.top: macroFrameSelectedMacroBackground.bottom
        width: 131.2
        height: 10.3
    }

    Part {
        id: macroFrameScrollFrame
        name: "MacroFrameScrollFrame"
        kind: "ScrollFrame"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 11
        anchors.top: macroFrameSelectedMacroBackground.bottom
        anchors.topMargin: 18
        width: 286
        height: 85
    }

    Part {
        id: macroFrameScrollFrameDiabolicZone
        name: "MacroFrameScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "MacroFrameScrollFrame"
        anchors.left: macroFrameScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: macroFrameScrollFrame.top
        anchors.topMargin: -6
        width: 320
        height: 97
    }

    Part {
        id: macroFrameScrollFrameScrollBar
        name: "MacroFrameScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "MacroFrameScrollFrame"
        anchors.left: macroFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: macroFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 53
    }

    Part {
        id: macroFrameScrollFrameScrollBarDiabolicTrack
        name: "MacroFrameScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "MacroFrameScrollFrameScrollBar"
        anchors.horizontalCenter: macroFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: macroFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 87
    }

    Part {
        id: macroFrameScrollFrameScrollBarScrollDownButton
        name: "MacroFrameScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "MacroFrameScrollFrameScrollBar"
        anchors.horizontalCenter: macroFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: macroFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: macroFrameScrollFrameScrollBarScrollUpButton
        name: "MacroFrameScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "MacroFrameScrollFrameScrollBar"
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
        width: 198
        height: 12
    }

    Part {
        id: macroFrameSelectedMacroButton
        name: "MacroFrameSelectedMacroButton"
        kind: "CheckButton"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.left
        anchors.leftMargin: 14
        anchors.top: macroFrameSelectedMacroBackground.top
        anchors.topMargin: 14
        width: 36
        height: 36
    }

    Part {
        id: macroFrameSelectedMacroButtonName
        name: "MacroFrameSelectedMacroButtonName"
        kind: "FontString"
        wowParent: "MacroFrameSelectedMacroButton"
        anchors.horizontalCenter: macroFrameSelectedMacroButton.horizontalCenter
        anchors.bottom: macroFrameSelectedMacroButton.bottom
        anchors.bottomMargin: 2
        width: 36
        height: 10
    }

    Part {
        id: macroFrameSelectedMacroName
        name: "MacroFrameSelectedMacroName"
        kind: "FontString"
        text: "DUI Holy End"
        wowParent: "MacroFrame"
        anchors.left: macroFrameSelectedMacroBackground.right
        anchors.leftMargin: -4
        anchors.top: macroFrameSelectedMacroBackground.top
        anchors.topMargin: 10
        width: 256
        height: 16
    }

    Part {
        id: macroFrameTab1
        name: "MacroFrameTab1"
        kind: "Button"
        text: "General Macros"
        wowParent: "MacroFrame"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: macroFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: macroFrameTab2
        name: "MacroFrameTab2"
        kind: "Button"
        text: "Padirac Specific Macros"
        wowParent: "MacroFrame"
        anchors.left: macroFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: macroFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: macroFrameText
        name: "MacroFrameText"
        kind: "EditBox"
        wowParent: "MacroFrameScrollFrame"
        anchors.left: macroFrameScrollFrame.left
        anchors.top: macroFrameScrollFrame.top
        width: 286
        height: 30.8
    }

    Part {
        id: macroFrameTextBackground
        name: "MacroFrameTextBackground"
        kind: "Frame"
        wowParent: "MacroFrame"
        anchors.left: macroFrame.left
        anchors.leftMargin: 18
        anchors.top: macroFrame.top
        anchors.topMargin: 305
        width: 322
        height: 95
    }

    Part {
        id: macroFrameTextButton
        name: "MacroFrameTextButton"
        kind: "Button"
        wowParent: "MacroFrame"
        anchors.left: macroFrameText.left
        anchors.top: macroFrameText.top
        width: 286
        height: 85
    }

    Part {
        id: macroNewButton
        name: "MacroNewButton"
        kind: "Button"
        text: "New"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.horizontalCenter: macroFrame.left
        anchors.horizontalCenterOffset: 222
        anchors.verticalCenter: macroFrame.top
        anchors.verticalCenterOffset: 432
        width: 77.5
        height: 22
    }

    Part {
        id: macroNewButtonText
        name: "MacroNewButtonText"
        kind: "FontString"
        text: "New"
        wowParent: "MacroNewButton"
        anchors.horizontalCenter: macroNewButton.horizontalCenter
        anchors.verticalCenter: macroNewButton.verticalCenter
        width: 30.8
        height: 11.9
    }

}
