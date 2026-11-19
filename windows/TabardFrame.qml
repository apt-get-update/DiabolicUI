// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "TabardFrame"
    kind: "sheet"
    width: 384
    height: 512

    Button {
        id: tabardCharacterModelRotateLeftButton
        name: "TabardCharacterModelRotateLeftButton"
        wowParent: "TabardModel"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 110
        width: 35
        height: 35
    }

    Button {
        name: "TabardCharacterModelRotateRightButton"
        wowParent: "TabardModel"
        anchors.left: tabardCharacterModelRotateLeftButton.right
        anchors.leftMargin: -5
        anchors.top: tabardCharacterModelRotateLeftButton.top
        width: 35
        height: 35
    }

    Button {
        name: "TabardFrameAcceptButton"
        text: "Accept"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 123.5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 81
        width: 76.5
        height: 22

        FontString {
            name: "TabardFrameAcceptButtonText"
            text: "Accept"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 50.6
            height: 11.9
        }
    }

    Button {
        name: "TabardFrameCancelButton"
        text: "Cancel"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 39
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 81
        width: 76.5
        height: 22

        FontString {
            name: "TabardFrameCancelButtonText"
            text: "Cancel"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 51.4
            height: 11.9
        }
    }

    Frame {
        name: "TabardFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -20
        anchors.top: parent.top
        width: 402
        height: 503

        Button {
            name: "TabardFrameCloseButton"
            wowParent: "TabardFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "TabardFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 402
            height: 503

            Frame {
                name: "TabardFrameDiabolicTitlePlate"
                wowParent: "TabardFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                Button {
                    name: "TabardFrameDiabolicTitlePlateGem"
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }

                FontString {
                    name: "TabardFrameNameText"
                    text: "Aldwin Laughlin"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 150.1
                    height: 14.2
                }
            }
        }

        Frame {
            name: "TabardFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    FontString {
        name: "TabardFrameGreetingText"
        text: "Greetings! Choose the symbol and colors of your guild."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 10
        anchors.top: parent.top
        anchors.topMargin: 39
        width: 250
        height: 23.7
    }

    Frame {
        name: "TabardFrameMoneyFrame"
        anchors.right: parent.left
        anchors.rightMargin: -183
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 86
        width: 112.1
        height: 13

        Button {
            id: tabardFrameMoneyFrameCopperButton
            name: "TabardFrameMoneyFrameCopperButton"
            text: "0"
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            width: 23.3
            height: 13

            FontString {
                name: "TabardFrameMoneyFrameCopperButtonText"
                text: "0"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 10.3
                height: 14.2
            }
        }

        Button {
            name: "TabardFrameMoneyFrameGoldButton"
            text: "5000"
            anchors.right: tabardFrameMoneyFrameSilverButton.left
            anchors.rightMargin: 4
            anchors.verticalCenter: tabardFrameMoneyFrameSilverButton.verticalCenter
            width: 44.6
            height: 13

            FontString {
                name: "TabardFrameMoneyFrameGoldButtonText"
                text: "5000"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 31.6
                height: 14.2
            }
        }

        Button {
            id: tabardFrameMoneyFrameSilverButton
            name: "TabardFrameMoneyFrameSilverButton"
            text: "0"
            anchors.right: tabardFrameMoneyFrameCopperButton.left
            anchors.rightMargin: 4
            anchors.verticalCenter: tabardFrameMoneyFrameCopperButton.verticalCenter
            width: 23.3
            height: 13

            FontString {
                name: "TabardFrameMoneyFrameSilverButtonText"
                text: "0"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 10.3
                height: 14.2
            }
        }
    }

    Part {
        name: "TabardModel"
        kind: "TabardModel"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -14
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 114
        width: 303
        height: 317
    }

    Ghost {
        name: "TabardFrameBackground"
        x: 23
        y: 76
        width: 0
        height: 0

        Frame {
            name: "TabardFrameBackgroundDiabolicPane"
            wowParent: "TabardFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 328
            height: 337
        }
    }

    Ghost {
        name: "TabardFrameCustomizationBorder"
        x: 119
        y: 206
        width: 0
        height: 0

        Frame {
            id: tabardFrameCustomization1
            name: "TabardFrameCustomization1"
            wowParent: "TabardFrameCustomizationFrame"
            anchors.left: parent.left
            anchors.leftMargin: 48
            anchors.top: parent.top
            anchors.topMargin: 65
            width: 164
            height: 20

            Ghost {
                name: "TabardFrameCustomization1Left"
                x: 9.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization1LeftButton"
                    wowParent: "TabardFrameCustomization1"
                    anchors.right: parent.left
                    anchors.rightMargin: -21
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }

            Ghost {
                name: "TabardFrameCustomization1Middle"
                x: 82
                y: 15
                width: 0
                height: 0

                FontString {
                    name: "TabardFrameCustomization1Text"
                    text: "Icon"
                    wowParent: "TabardFrameCustomization1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 85
                    height: 10
                }
            }

            Ghost {
                name: "TabardFrameCustomization1Right"
                x: 154.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization1RightButton"
                    wowParent: "TabardFrameCustomization1"
                    anchors.left: parent.right
                    anchors.leftMargin: -19
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }
        }

        Frame {
            id: tabardFrameCustomization2
            name: "TabardFrameCustomization2"
            wowParent: "TabardFrameCustomizationFrame"
            anchors.left: tabardFrameCustomization1.left
            anchors.top: tabardFrameCustomization1.bottom
            anchors.topMargin: 5
            width: 164
            height: 20

            Ghost {
                name: "TabardFrameCustomization2Left"
                x: 9.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization2LeftButton"
                    wowParent: "TabardFrameCustomization2"
                    anchors.right: parent.left
                    anchors.rightMargin: -21
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }

            Ghost {
                name: "TabardFrameCustomization2Middle"
                x: 82
                y: 15
                width: 0
                height: 0

                FontString {
                    name: "TabardFrameCustomization2Text"
                    text: "Icon Color"
                    wowParent: "TabardFrameCustomization2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 85
                    height: 10
                }
            }

            Ghost {
                name: "TabardFrameCustomization2Right"
                x: 154.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization2RightButton"
                    wowParent: "TabardFrameCustomization2"
                    anchors.left: parent.right
                    anchors.leftMargin: -19
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }
        }

        Frame {
            id: tabardFrameCustomization3
            name: "TabardFrameCustomization3"
            wowParent: "TabardFrameCustomizationFrame"
            anchors.left: tabardFrameCustomization2.left
            anchors.top: tabardFrameCustomization2.bottom
            anchors.topMargin: 5
            width: 164
            height: 20

            Ghost {
                name: "TabardFrameCustomization3Left"
                x: 9.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization3LeftButton"
                    wowParent: "TabardFrameCustomization3"
                    anchors.right: parent.left
                    anchors.rightMargin: -21
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }

            Ghost {
                name: "TabardFrameCustomization3Middle"
                x: 82
                y: 15
                width: 0
                height: 0

                FontString {
                    name: "TabardFrameCustomization3Text"
                    text: "Border"
                    wowParent: "TabardFrameCustomization3"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 85
                    height: 10
                }
            }

            Ghost {
                name: "TabardFrameCustomization3Right"
                x: 154.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization3RightButton"
                    wowParent: "TabardFrameCustomization3"
                    anchors.left: parent.right
                    anchors.leftMargin: -19
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }
        }

        Frame {
            id: tabardFrameCustomization4
            name: "TabardFrameCustomization4"
            wowParent: "TabardFrameCustomizationFrame"
            anchors.left: tabardFrameCustomization3.left
            anchors.top: tabardFrameCustomization3.bottom
            anchors.topMargin: 5
            width: 164
            height: 20

            Ghost {
                name: "TabardFrameCustomization4Left"
                x: 9.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization4LeftButton"
                    wowParent: "TabardFrameCustomization4"
                    anchors.right: parent.left
                    anchors.rightMargin: -21
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }

            Ghost {
                name: "TabardFrameCustomization4Middle"
                x: 82
                y: 15
                width: 0
                height: 0

                FontString {
                    name: "TabardFrameCustomization4Text"
                    text: "Border Color"
                    wowParent: "TabardFrameCustomization4"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 85
                    height: 10
                }
            }

            Ghost {
                name: "TabardFrameCustomization4Right"
                x: 154.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization4RightButton"
                    wowParent: "TabardFrameCustomization4"
                    anchors.left: parent.right
                    anchors.leftMargin: -19
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }
        }

        Frame {
            name: "TabardFrameCustomization5"
            wowParent: "TabardFrameCustomizationFrame"
            anchors.left: tabardFrameCustomization4.left
            anchors.top: tabardFrameCustomization4.bottom
            anchors.topMargin: 5
            width: 164
            height: 20

            Ghost {
                name: "TabardFrameCustomization5Left"
                x: 9.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization5LeftButton"
                    wowParent: "TabardFrameCustomization5"
                    anchors.right: parent.left
                    anchors.rightMargin: -21
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }

            Ghost {
                name: "TabardFrameCustomization5Middle"
                x: 82
                y: 15
                width: 0
                height: 0

                FontString {
                    name: "TabardFrameCustomization5Text"
                    text: "Background"
                    wowParent: "TabardFrameCustomization5"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 85
                    height: 10
                }
            }

            Ghost {
                name: "TabardFrameCustomization5Right"
                x: 154.5
                y: 15
                width: 0
                height: 0

                Button {
                    name: "TabardFrameCustomization5RightButton"
                    wowParent: "TabardFrameCustomization5"
                    anchors.left: parent.right
                    anchors.leftMargin: -19
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
                    width: 32
                    height: 32
                }
            }
        }
    }

    Ghost {
        name: "TabardFrameOuterFrameTopRight"
        x: 339
        y: 73
        width: 0
        height: 0

        Frame {
            name: "TabardFrameCostFrame"
            wowParent: "TabardFrame"
            anchors.right: parent.right
            anchors.rightMargin: 7
            anchors.top: parent.top
            anchors.topMargin: 5
            width: 170
            height: 23

            Frame {
                name: "TabardFrameCostMoneyFrame"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: 43.4
                height: 13

                FontString {
                    name: "TabardFrameCostLabel"
                    text: "Cost:"
                    anchors.right: parent.left
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 31.6
                    height: 11.9
                }

                Ghost {
                    name: "TabardFrameCostMoneyFrameSilverButton"
                    x: 30.4
                    y: 6.5
                    width: 0
                    height: 0

                    Button {
                        name: "TabardFrameCostMoneyFrameGoldButton"
                        text: "10"
                        wowParent: "TabardFrameCostMoneyFrame"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30.4
                        height: 13

                        FontString {
                            name: "TabardFrameCostMoneyFrameGoldButtonText"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 17.4
                            height: 14.2
                        }
                    }
                }
            }
        }
    }
}
