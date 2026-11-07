// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "MacroFrame"
    width: 384
    height: 512

    // the icons and the macro 20 up and 6 left (as far from the band as from the
    // foot's bar, from the sides)
    ScrollFrame {
        name: "MacroButtonScrollFrame"
        wowParent: "MacroFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 17
        anchors.top: parent.top
        anchors.topMargin: 56
        width: 294
        height: 146

        Frame {
            name: "MacroButtonContainer"
            wowParent: "MacroButtonScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 285
            height: 10

            CheckButton {
                name: "MacroButton1"
                wowParent: "MacroButtonContainer"
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 6
                width: 36
                height: 36

                FontString {
                    name: "MacroButton1Name"
                    text: "DUI Holy End"
                    wowParent: "MacroButton1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 36
                    height: 10
                }
            }
        }

        Frame {
            name: "MacroButtonScrollFrameDiabolicZone"
            wowParent: "MacroFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 328
            height: 158
        }

        Slider {
            name: "MacroButtonScrollFrameScrollBar"
            wowParent: "MacroButtonScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 114

            Button {
                name: "MacroButtonScrollFrameScrollBarScrollDownButton"
                wowParent: "MacroButtonScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "MacroButtonScrollFrameScrollBarScrollUpButton"
                wowParent: "MacroButtonScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "MacroButtonScrollFrameScrollBarDiabolicTrack"
                    wowParent: "MacroButtonScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 148
                }
            }
        }
    }

    Frame {
        name: "MacroFrameDiabolic"
        wowParent: "MacroFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -28
        width: 398
        height: 501

        Button {
            name: "MacroFrameCloseButton"
            wowParent: "MacroFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "MacroFrameDiabolicBorder"
            wowParent: "MacroFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 398
            height: 469

            Frame {
                name: "MacroFrameDiabolicTitlePlate"
                wowParent: "MacroFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "MacroFrameDiabolicTitle"
                    text: "Create Macros"
                    wowParent: "MacroFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 134.3
                    height: 14.2
                }
            }
        }

        Frame {
            name: "MacroFrameDiabolicFoot"
            wowParent: "MacroFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 352
            height: 35

            // the buttons 10 down (30 over the window's bottom)
            Button {
                name: "MacroDeleteButton"
                text: "Delete"
                wowParent: "MacroFrame"
                style: "Button"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7
                width: 80
                height: 22
            }

            WowRow {
                name: "MacroButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 172
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "MacroNewButton"
                    text: "New"
                    wowParent: "MacroFrame"
                    style: "Button"
                    pin: "all"
                    width: 80
                    height: 22

                    FontString {
                        name: "MacroNewButtonText"
                        text: "New"
                        wowParent: "MacroNewButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30.8
                        height: 11.9
                    }
                }

                Button {
                    name: "MacroExitButton"
                    text: "Exit"
                    wowParent: "MacroFrame"
                    style: "Button"
                    pin: "all"
                    width: 80
                    height: 22

                    FontString {
                        name: "MacroExitButtonText"
                        text: "Exit"
                        wowParent: "MacroExitButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32.4
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "MacroFrameDiabolicRail"
            wowParent: "MacroFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "MacroFrameDiabolicSocket"
            wowParent: "MacroFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "MacroFrameTab1"
            text: "General Macros"
            wowParent: "MacroFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "MacroFrameTab2"
            text: "Padirac Specific Macros"
            wowParent: "MacroFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Part {
        name: "MacroFrameSelectedMacroBackground"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 208
        width: 64
        height: 64

        Button {
            name: "MacroEditButton"
            text: "Change Name/Icon"
            wowParent: "MacroFrame"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: 51
            anchors.top: parent.top
            anchors.topMargin: 30
            width: 170
            height: 22

            FontString {
                name: "MacroEditButtonText"
                text: "Change Name/Icon"
                wowParent: "MacroEditButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 135.1
                height: 11.9
            }
        }

        FontString {
            name: "MacroFrameEnterMacroText"
            text: "Enter Macro Commands:"
            wowParent: "MacroFrame"
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.top: parent.bottom
            width: 131.2
            height: 10.3
        }

        ScrollFrame {
            name: "MacroFrameScrollFrame"
            wowParent: "MacroFrame"
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.top: parent.bottom
            anchors.topMargin: 18
            width: 286
            height: 85

            // the count of characters right of "Enter Macro Commands:" (Blizzard's
            // under the text, over the foot)
            FontString {
                name: "MacroFrameCharLimitText"
                text: "80/255 Characters Used"
                wowParent: "MacroFrame"
                pin: "place"
                anchors.right: parent.right
                anchors.bottom: parent.top
                anchors.bottomMargin: 8
                width: 129.6
                height: 10
            }

            Frame {
                name: "MacroFrameScrollFrameDiabolicZone"
                wowParent: "MacroFrameScrollFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 320
                height: 97
            }

            Slider {
                name: "MacroFrameScrollFrameScrollBar"
                wowParent: "MacroFrameScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 53

                Button {
                    name: "MacroFrameScrollFrameScrollBarScrollDownButton"
                    wowParent: "MacroFrameScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "MacroFrameScrollFrameScrollBarScrollUpButton"
                    wowParent: "MacroFrameScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "MacroFrameScrollFrameScrollBarDiabolicTrack"
                        wowParent: "MacroFrameScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 87
                    }
                }
            }

            EditBox {
                name: "MacroFrameText"
                wowParent: "MacroFrameScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 286
                height: 30.8

                Button {
                    name: "MacroFrameTextButton"
                    wowParent: "MacroFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 286
                    height: 85
                }
            }
        }

        CheckButton {
            name: "MacroFrameSelectedMacroButton"
            wowParent: "MacroFrame"
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 14
            width: 36
            height: 36

            FontString {
                name: "MacroFrameSelectedMacroButtonName"
                wowParent: "MacroFrameSelectedMacroButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 36
                height: 10
            }
        }

        FontString {
            name: "MacroFrameSelectedMacroName"
            text: "DUI Holy End"
            wowParent: "MacroFrame"
            anchors.left: parent.right
            anchors.leftMargin: -4
            anchors.top: parent.top
            anchors.topMargin: 10
            width: 256
            height: 16
        }
    }

    Frame {
        name: "MacroFrameTextBackground"
        wowParent: "MacroFrame"
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 305
        width: 322
        height: 95
    }
}
