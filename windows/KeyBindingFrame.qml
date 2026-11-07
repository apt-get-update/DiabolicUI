// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "KeyBindingFrame"
    width: 640
    height: 512

    Frame {
        name: "KeyBindingFrameBinding1"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 27
        anchors.top: parent.top
        anchors.topMargin: 72
        width: 560
        height: 25

        FontString {
            name: "KeyBindingFrameBinding1Description"
            text: "Earth Totem"
            wowParent: "KeyBindingFrameBinding1"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 170
            height: 24
        }

        FontString {
            name: "KeyBindingFrameBinding1Header"
            text: "Movement Keys"
            wowParent: "KeyBindingFrameBinding1"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 97.2
            height: 11.9
        }
    }

    Button {
        name: "KeyBindingFrameBinding1Key1Button"
        wowParent: "KeyBindingFrameBinding1"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 261
        anchors.top: parent.top
        anchors.topMargin: 73.5
        width: 177
        height: 22

        FontString {
            name: "KeyBindingFrameBinding1Key1ButtonText"
            wowParent: "KeyBindingFrameBinding1Key1Button"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 71.1
            height: 10.3
        }
    }

    FontString {
        name: "KeyBindingFrameCommandLabel"
        text: "Command"
        wowParent: "KeyBindingFrame"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.top: parent.top
        anchors.topMargin: 35
        width: 61.6
        height: 11.9

        FontString {
            name: "KeyBindingFrameKey1Label"
            text: "Key 1"
            wowParent: "KeyBindingFrame"
            anchors.left: parent.right
            anchors.leftMargin: 185
            anchors.verticalCenter: parent.verticalCenter
            width: 32.4
            height: 11.9

            FontString {
                name: "KeyBindingFrameKey2Label"
                text: "Key 2"
                wowParent: "KeyBindingFrame"
                anchors.left: parent.right
                anchors.leftMargin: 145
                anchors.verticalCenter: parent.verticalCenter
                width: 34
                height: 11.9
            }
        }
    }

    Frame {
        name: "KeyBindingFrameDiabolic"
        wowParent: "KeyBindingFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -40
        width: 634
        height: 598

        Frame {
            name: "KeyBindingFrameDiabolicBand"
            wowParent: "KeyBindingFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 586
            height: 40

            CheckButton {
                name: "KeyBindingFrameCharacterButton"
                wowParent: "KeyBindingFrame"
                style: "CheckBox"
                anchors.right: parent.right
                anchors.rightMargin: 232.6
                anchors.verticalCenter: parent.verticalCenter
                width: 20
                height: 20

                FontString {
                    name: "KeyBindingFrameCharacterButtonText"
                    wowParent: "KeyBindingFrameCharacterButton"
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 183.3
                    height: 14.2
                }
            }
        }

        Frame {
            name: "KeyBindingFrameDiabolicBorder"
            wowParent: "KeyBindingFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 634
            height: 598

            Frame {
                name: "KeyBindingFrameDiabolicTitlePlate"
                wowParent: "KeyBindingFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "KeyBindingFrameHeaderText"
                    text: "Key Bindings"
                    wowParent: "KeyBindingFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 112.2
                    height: 14.2
                }
            }
        }

        Frame {
            name: "KeyBindingFrameDiabolicFoot"
            wowParent: "KeyBindingFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 588
            height: 35

            // the buttons 16 lower, on the foot, as far in from both sides
            Button {
                name: "KeyBindingFrameDefaultButton"
                text: "Reset To Default"
                wowParent: "KeyBindingFrame"
                style: "Button"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7
                width: 130
                height: 22
            }

            WowRow {
                name: "KeyBindingButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 187
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "KeyBindingFrameUnbindButton"
                    text: "Unbind Key"
                    wowParent: "KeyBindingFrame"
                    style: "Button"
                    pin: "all"
                    width: 125
                    height: 22

                    FontString {
                        name: "KeyBindingFrameUnbindButtonText"
                        text: "Unbind Key"
                        wowParent: "KeyBindingFrameUnbindButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 73.5
                        height: 10.3
                    }
                }

                Button {
                    name: "KeyBindingFrameOkayButton"
                    text: "Okay"
                    wowParent: "KeyBindingFrame"
                    style: "Button"
                    pin: "all"
                    width: 125
                    height: 22

                    FontString {
                        name: "KeyBindingFrameOkayButtonText"
                        text: "Okay"
                        wowParent: "KeyBindingFrameOkayButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32.4
                        height: 10.3
                    }
                }

                Button {
                    name: "KeyBindingFrameCancelButton"
                    text: "Cancel"
                    wowParent: "KeyBindingFrame"
                    style: "Button"
                    pin: "all"
                    width: 125
                    height: 22

                    FontString {
                        name: "KeyBindingFrameCancelButtonText"
                        text: "Cancel"
                        wowParent: "KeyBindingFrameCancelButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 45.8
                        height: 10.3
                    }
                }
            }
        }
    }

    // what a key was bound to between the list and the foot
    FontString {
        name: "KeyBindingFrameOutputText"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 293
        anchors.top: parent.top
        anchors.topMargin: 465
        width: 1
        height: 1
    }

    // the list (its rows too) 6 under the column names
    ScrollFrame {
        name: "KeyBindingFrameScrollFrame"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 72
        width: 560
        height: 390

        Frame {
            name: "KeyBindingFrameScrollFrameDiabolicZone"
            wowParent: "KeyBindingFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 594
            height: 402
        }

        Slider {
            name: "KeyBindingFrameScrollFrameScrollBar"
            wowParent: "KeyBindingFrameScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 358

            Button {
                name: "KeyBindingFrameScrollFrameScrollBarScrollDownButton"
                wowParent: "KeyBindingFrameScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "KeyBindingFrameScrollFrameScrollBarScrollUpButton"
                wowParent: "KeyBindingFrameScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "KeyBindingFrameScrollFrameScrollBarDiabolicTrack"
                    wowParent: "KeyBindingFrameScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 392
                }
            }
        }

        Frame {
            name: "KeyBindingFrameScrollFrameScrollChildFrame"
            wowParent: "KeyBindingFrameScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 7775
        }
    }

    Ghost {
        name: "KeyBindingFrameBinding17"
        x: 27
        y: 440
        width: 560
        height: 25

        FontString {
            name: "KeyBindingFrameBinding17Header"
            text: "Chat Functions"
            wowParent: "KeyBindingFrameBinding17"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 87.7
            height: 11.9
        }
    }

    Ghost {
        name: "KeyBindingFrameBinding5"
        x: 27
        y: 164
        width: 560
        height: 25

        FontString {
            name: "KeyBindingFrameBinding5Header"
            wowParent: "KeyBindingFrameBinding5"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }
    }

    Ghost {
        name: "KeyBindingFrameBinding7"
        x: 27
        y: 210
        width: 560
        height: 25

        FontString {
            name: "KeyBindingFrameBinding7Header"
            text: "Targeting Functions"
            wowParent: "KeyBindingFrameBinding7"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 116.1
            height: 11.9
        }
    }
}
