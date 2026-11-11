// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "ClassTrainerFrame"
    width: 384
    height: 512

    // the chosen one's page 6 under the list's (Blizzard's 8 under its text)
    ScrollFrame {
        name: "ClassTrainerDetailScrollFrame"
        pin: "all"
        anchors.left: classTrainerListScrollFrame.left
        anchors.top: classTrainerListScrollFrame.bottom
        anchors.topMargin: 28
        width: 296
        height: 121

        Frame {
            name: "ClassTrainerDetailScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 296
            height: 50

            FontString {
                id: classTrainerCostLabel
                name: "ClassTrainerCostLabel"
                text: "Cost:"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 50
                width: 27.7
                height: 10.3
            }

            Frame {
                name: "ClassTrainerDetailMoneyFrame"
                anchors.left: classTrainerCostLabel.right
                anchors.leftMargin: 5
                anchors.verticalCenter: classTrainerCostLabel.verticalCenter
                width: 36.3
                height: 13

                Button {
                    id: classTrainerDetailMoneyFrameCopperButton
                    name: "ClassTrainerDetailMoneyFrameCopperButton"
                    text: "8"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 23.3
                    height: 13

                    FontString {
                        name: "ClassTrainerDetailMoneyFrameCopperButtonText"
                        text: "8"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 10.3
                        height: 14.2
                    }
                }

                Button {
                    name: "ClassTrainerDetailMoneyFrameGoldButton"
                    text: "3"
                    anchors.right: classTrainerDetailMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: classTrainerDetailMoneyFrameSilverButton.verticalCenter
                    width: 23.3
                    height: 13

                    FontString {
                        name: "ClassTrainerDetailMoneyFrameGoldButtonText"
                        text: "3"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 10.3
                        height: 14.2
                    }
                }

                Button {
                    id: classTrainerDetailMoneyFrameSilverButton
                    name: "ClassTrainerDetailMoneyFrameSilverButton"
                    text: "68"
                    anchors.right: classTrainerDetailMoneyFrameCopperButton.right
                    anchors.verticalCenter: classTrainerDetailMoneyFrameCopperButton.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "ClassTrainerDetailMoneyFrameSilverButtonText"
                        text: "68"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

            FontString {
                name: "ClassTrainerSkillDescription"
                text: "Power infuses the target, increasing their Stamina by 3 for 30 min."
                anchors.left: classTrainerCostLabel.left
                anchors.top: classTrainerCostLabel.bottom
                anchors.topMargin: 10
                width: 290
                height: 20.5
            }

            Button {
                name: "ClassTrainerSkillIcon"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 37
                height: 37
            }

            FontString {
                id: classTrainerSkillName
                name: "ClassTrainerSkillName"
                text: "Power Word: Fortitude"
                anchors.left: parent.left
                anchors.leftMargin: 46
                anchors.top: parent.top
                anchors.topMargin: 2
                width: 244
                height: 11.9
            }

            FontString {
                name: "ClassTrainerSkillRequirements"
                anchors.left: classTrainerSkillName.left
                anchors.top: classTrainerSkillName.bottom
                width: 244
                height: 1
            }

            FontString {
                name: "ClassTrainerSubSkillName"
                text: "(Rank 1)"
                anchors.left: classTrainerSkillName.right
                anchors.leftMargin: 5
                anchors.verticalCenter: classTrainerSkillName.verticalCenter
                width: 48.2
                height: 11.9
            }
        }

        Frame {
            name: "ClassTrainerDetailScrollFrameDiabolicPanel"
            wowParent: "ClassTrainerFrame"
            anchors.left: parent.left
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 360
            height: 133
        }

        Frame {
            name: "ClassTrainerDetailScrollFrameDiabolicParchment"
            wowParent: "ClassTrainerFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 5
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 334
            height: 129
        }

        Slider {
            name: "ClassTrainerDetailScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: -14.3
            anchors.top: parent.top
            anchors.topMargin: -71.4
            width: 16
            height: 103

            Frame {
                name: "ClassTrainerDetailScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: classTrainerDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: classTrainerDetailScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 137
            }

            Button {
                name: "ClassTrainerDetailScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: classTrainerDetailScrollFrameScrollBarScrollUpButton
                name: "ClassTrainerDetailScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }
    }

    // "All" and the list under the greeting (the chosen one's height: trainer.lua)
    Frame {
        name: "ClassTrainerExpandButtonFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 66
        width: 54
        height: 32

        Ghost {
            name: "ClassTrainerExpandTabLeft"
            x: 8
            y: 16
            width: 0
            height: 0

            Button {
                name: "ClassTrainerCollapseAllButton"
                text: "All"
                wowParent: "ClassTrainerExpandButtonFrame"
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -3
                width: 40
                height: 22

                FontString {
                    name: "ClassTrainerCollapseAllButtonSubText"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 1
                    height: 1
                }

                Ghost {
                    name: "ClassTrainerCollapseAllButtonHighlight"
                    x: 19
                    y: 11
                    width: 0
                    height: 0

                    FontString {
                        name: "ClassTrainerCollapseAllButtonText"
                        text: "All"
                        wowParent: "ClassTrainerCollapseAllButton"
                        anchors.left: parent.right
                        anchors.leftMargin: 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 270
                        height: 13
                    }
                }
            }
        }
    }

    Frame {
        name: "ClassTrainerFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -40
        width: 418
        height: 501

        Button {
            name: "ClassTrainerFrameCloseButton"
            wowParent: "ClassTrainerFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "ClassTrainerFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 370
            height: 40

            Frame {
                name: "ClassTrainerFrameFilterDropDown"
                wowParent: "ClassTrainerFrame"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.verticalCenter: parent.verticalCenter
                width: 180
                height: 32

                Frame {
                    name: "ClassTrainerFrameFilterDropDownDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 180
                    height: 22

                    Button {
                        name: "ClassTrainerFrameFilterDropDownButton"
                        wowParent: "ClassTrainerFrameFilterDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "ClassTrainerFrameFilterDropDownText"
                        text: "Filter"
                        wowParent: "ClassTrainerFrameFilterDropDown"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 118
                        height: 10
                    }
                }
            }
        }

        Frame {
            name: "ClassTrainerFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 418
            height: 501

            Frame {
                name: "ClassTrainerFrameDiabolicTitlePlate"
                wowParent: "ClassTrainerFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "ClassTrainerNameText"
                    text: "High Priestess Laurena"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 200
                    height: 16
                }
            }
        }

        Frame {
            id: classTrainerFrameDiabolicFoot
            name: "ClassTrainerFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 372
            height: 35

            WowRow {
                name: "TrainerButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 185
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "ClassTrainerTrainButton"
                    text: "Train"
                    wowParent: "ClassTrainerFrame"
                    style: "Button"
                    pin: "all"
                    width: 83.5
                    height: 22

                    FontString {
                        name: "ClassTrainerTrainButtonText"
                        text: "Train"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 41.9
                        height: 11.9
                    }
                }

                Button {
                    name: "ClassTrainerCancelButton"
                    text: "Exit"
                    wowParent: "ClassTrainerFrame"
                    style: "Button"
                    pin: "all"
                    width: 83.5
                    height: 22

                    FontString {
                        name: "ClassTrainerCancelButtonText"
                        text: "Exit"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32.4
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "ClassTrainerFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }

        Frame {
            name: "ClassTrainerMoneyFrame"
            wowParent: "ClassTrainerFrame"
            pin: "place"
            anchors.right: classTrainerFrameDiabolicFoot.left
            anchors.rightMargin: -181
            anchors.bottom: classTrainerFrameDiabolicFoot.bottom
            anchors.bottomMargin: 12
            width: 126.4
            height: 13

            Button {
                id: classTrainerMoneyFrameCopperButton
                name: "ClassTrainerMoneyFrameCopperButton"
                text: "75"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 30.4
                height: 13

                FontString {
                    name: "ClassTrainerMoneyFrameCopperButtonText"
                    text: "75"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.4
                    height: 14.2
                }
            }

            Button {
                name: "ClassTrainerMoneyFrameGoldButton"
                text: "3663"
                anchors.right: classTrainerMoneyFrameSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: classTrainerMoneyFrameSilverButton.verticalCenter
                width: 44.6
                height: 13

                FontString {
                    name: "ClassTrainerMoneyFrameGoldButtonText"
                    text: "3663"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 31.6
                    height: 14.2
                }
            }

            Button {
                id: classTrainerMoneyFrameSilverButton
                name: "ClassTrainerMoneyFrameSilverButton"
                text: "24"
                anchors.right: classTrainerMoneyFrameCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: classTrainerMoneyFrameCopperButton.verticalCenter
                width: 30.4
                height: 13

                FontString {
                    name: "ClassTrainerMoneyFrameSilverButtonText"
                    text: "24"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.4
                    height: 14.2
                }
            }
        }
    }

    Frame {
        name: "ClassTrainerFrameDiabolicIronBar"
        wowParent: "ClassTrainerFrameDiabolic"
        pin: "all"
        anchors.left: classTrainerListScrollFrame.left
        anchors.leftMargin: -30
        anchors.top: classTrainerListScrollFrame.bottom
        anchors.topMargin: 6.5
        width: 388
        height: 16
    }

    // the greeting across the list's width under the band, its panel's left on
    // the parchments', its right on their panels'
    FontString {
        name: "ClassTrainerGreetingText"
        text: "Hello, priest!  Ready for some training?"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 11
        anchors.top: parent.top
        anchors.topMargin: 34
        width: 350
        height: 24

        Frame {
            name: "ClassTrainerGreetingTextDiabolicPanel"
            wowParent: "ClassTrainerFrame"
            anchors.left: parent.left
            anchors.leftMargin: -4
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 358
            height: 32
        }
    }

    ScrollFrame {
        id: classTrainerListScrollFrame
        name: "ClassTrainerListScrollFrame"
        pin: "all"
        anchors.right: parent.right
        anchors.rightMargin: 67
        anchors.top: parent.top
        anchors.topMargin: 72
        width: 296
        height: 158

        Frame {
            name: "ClassTrainerListScrollFrameDiabolicPanel"
            wowParent: "ClassTrainerFrame"
            anchors.left: parent.left
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 360
            height: 170
        }

        Frame {
            name: "ClassTrainerListScrollFrameDiabolicParchment"
            wowParent: "ClassTrainerFrame"
            anchors.left: parent.left
            anchors.leftMargin: -14
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 334
            height: 166
        }

        Slider {
            name: "ClassTrainerListScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 26
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 126

            Frame {
                name: "ClassTrainerListScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: classTrainerListScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: classTrainerListScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 160
            }

            Button {
                name: "ClassTrainerListScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: classTrainerListScrollFrameScrollBarScrollUpButton
                name: "ClassTrainerListScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "ClassTrainerListScrollFrameScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -400
            width: 300
            height: 3536
        }
    }

    Button {
        id: classTrainerSkill1
        name: "ClassTrainerSkill1"
        text: "  Power Word: Fortitude"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 90
        width: 293
        height: 16

        FontString {
            name: "ClassTrainerSkill1SubText"
            text: "(Rank 5)"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            width: 44.2
            height: 10.3
        }

        Ghost {
            name: "ClassTrainerSkill1Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "ClassTrainerSkill1Text"
                text: "  Power Word: Fortitude"
                wowParent: "ClassTrainerSkill1"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 210
                height: 13
            }
        }
    }

    Frame {
        name: "ClassTrainerSkillHighlightFrame"
        anchors.left: classTrainerSkill1.left
        anchors.top: classTrainerSkill1.top
        width: 293
        height: 16
    }
}
