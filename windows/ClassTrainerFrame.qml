// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "ClassTrainerFrame"
    width: 384
    height: 512

    // "All" and the list under the greeting (the chosen one's height: trainer.lua)
    Frame {
        name: "ClassTrainerExpandButtonFrame"
        wowParent: "ClassTrainerFrame"
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
                    wowParent: "ClassTrainerCollapseAllButton"
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
        wowParent: "ClassTrainerFrame"
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
            wowParent: "ClassTrainerFrameDiabolic"
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
                    wowParent: "ClassTrainerFrameFilterDropDown"
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
            wowParent: "ClassTrainerFrameDiabolic"
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
                    wowParent: "ClassTrainerFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 200
                    height: 16
                }
            }
        }

        Frame {
            name: "ClassTrainerFrameDiabolicFoot"
            wowParent: "ClassTrainerFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 372
            height: 35

            Frame {
                name: "ClassTrainerMoneyFrame"
                wowParent: "ClassTrainerFrame"
                pin: "place"
                anchors.right: parent.left
                anchors.rightMargin: -181
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                width: 126.4
                height: 13

                Button {
                    id: classTrainerMoneyFrameCopperButton
                    name: "ClassTrainerMoneyFrameCopperButton"
                    text: "63"
                    wowParent: "ClassTrainerMoneyFrame"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "ClassTrainerMoneyFrameCopperButtonText"
                        text: "63"
                        wowParent: "ClassTrainerMoneyFrameCopperButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }

                Button {
                    name: "ClassTrainerMoneyFrameGoldButton"
                    text: "3653"
                    wowParent: "ClassTrainerMoneyFrame"
                    anchors.right: classTrainerMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: classTrainerMoneyFrameSilverButton.verticalCenter
                    width: 44.6
                    height: 13

                    FontString {
                        name: "ClassTrainerMoneyFrameGoldButtonText"
                        text: "3653"
                        wowParent: "ClassTrainerMoneyFrameGoldButton"
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
                    text: "55"
                    wowParent: "ClassTrainerMoneyFrame"
                    anchors.right: classTrainerMoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: classTrainerMoneyFrameCopperButton.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "ClassTrainerMoneyFrameSilverButtonText"
                        text: "55"
                        wowParent: "ClassTrainerMoneyFrameSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

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
                        wowParent: "ClassTrainerTrainButton"
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
                        wowParent: "ClassTrainerCancelButton"
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
            wowParent: "ClassTrainerFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    // the greeting across the list's width under the band, its panel's left on
    // the parchments', its right on their panels'
    FontString {
        name: "ClassTrainerGreetingText"
        text: "Hello, priest!  Ready for some training?"
        wowParent: "ClassTrainerFrame"
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
        name: "ClassTrainerListScrollFrame"
        wowParent: "ClassTrainerFrame"
        pin: "all"
        anchors.right: parent.right
        anchors.rightMargin: 67
        anchors.top: parent.top
        anchors.topMargin: 72
        width: 296
        height: 158

        // the chosen one's page 6 under the list's (Blizzard's 8 under its text)
        ScrollFrame {
            name: "ClassTrainerDetailScrollFrame"
            wowParent: "ClassTrainerFrame"
            pin: "all"
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 28
            width: 296
            height: 121

            Frame {
                name: "ClassTrainerDetailScrollChildFrame"
                wowParent: "ClassTrainerDetailScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 296
                height: 50

                FontString {
                    name: "ClassTrainerCostLabel"
                    text: "Cost:"
                    wowParent: "ClassTrainerDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    width: 27.7
                    height: 10.3

                    Frame {
                        name: "ClassTrainerDetailMoneyFrame"
                        wowParent: "ClassTrainerDetailScrollChildFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 70.7
                        height: 13

                        Button {
                            id: classTrainerDetailMoneyFrameCopperButton
                            name: "ClassTrainerDetailMoneyFrameCopperButton"
                            text: "8"
                            wowParent: "ClassTrainerDetailMoneyFrame"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 23.3
                            height: 13

                            FontString {
                                name: "ClassTrainerDetailMoneyFrameCopperButtonText"
                                text: "8"
                                wowParent: "ClassTrainerDetailMoneyFrameCopperButton"
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
                            wowParent: "ClassTrainerDetailMoneyFrame"
                            anchors.right: classTrainerDetailMoneyFrameSilverButton.left
                            anchors.rightMargin: 4
                            anchors.verticalCenter: classTrainerDetailMoneyFrameSilverButton.verticalCenter
                            width: 23.3
                            height: 13

                            FontString {
                                name: "ClassTrainerDetailMoneyFrameGoldButtonText"
                                text: "3"
                                wowParent: "ClassTrainerDetailMoneyFrameGoldButton"
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
                            wowParent: "ClassTrainerDetailMoneyFrame"
                            anchors.right: classTrainerDetailMoneyFrameCopperButton.right
                            anchors.verticalCenter: classTrainerDetailMoneyFrameCopperButton.verticalCenter
                            width: 30.4
                            height: 13

                            FontString {
                                name: "ClassTrainerDetailMoneyFrameSilverButtonText"
                                text: "68"
                                wowParent: "ClassTrainerDetailMoneyFrameSilverButton"
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
                        text: "Power infuses all party and raid members, increasing their Stamina by 70 for 1 hour."
                        wowParent: "ClassTrainerDetailScrollChildFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        width: 290
                        height: 20.5
                    }
                }

                Button {
                    name: "ClassTrainerSkillIcon"
                    wowParent: "ClassTrainerDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 37
                    height: 37
                }

                FontString {
                    name: "ClassTrainerSkillName"
                    text: "Prayer of Fortitude"
                    wowParent: "ClassTrainerDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 46
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    width: 244
                    height: 11.9

                    FontString {
                        name: "ClassTrainerSkillRequirements"
                        wowParent: "ClassTrainerDetailScrollChildFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        width: 244
                        height: 20.5
                    }

                    FontString {
                        name: "ClassTrainerSubSkillName"
                        text: "(Rank 2)"
                        wowParent: "ClassTrainerDetailScrollChildFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 48.2
                        height: 11.9
                    }
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
                wowParent: "ClassTrainerDetailScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 26
                anchors.top: parent.top
                anchors.topMargin: 2
                width: 16
                height: 103

                Button {
                    name: "ClassTrainerDetailScrollFrameScrollBarScrollDownButton"
                    wowParent: "ClassTrainerDetailScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "ClassTrainerDetailScrollFrameScrollBarScrollUpButton"
                    wowParent: "ClassTrainerDetailScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "ClassTrainerDetailScrollFrameScrollBarDiabolicTrack"
                        wowParent: "ClassTrainerDetailScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 137
                    }
                }
            }
        }

        Frame {
            name: "ClassTrainerFrameDiabolicIronBar"
            wowParent: "ClassTrainerFrameDiabolic"
            pin: "all"
            anchors.left: parent.left
            anchors.leftMargin: -30
            anchors.top: parent.bottom
            anchors.topMargin: 6.5
            width: 388
            height: 16
        }

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
            wowParent: "ClassTrainerListScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 26
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 126

            Button {
                name: "ClassTrainerListScrollFrameScrollBarScrollDownButton"
                wowParent: "ClassTrainerListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "ClassTrainerListScrollFrameScrollBarScrollUpButton"
                wowParent: "ClassTrainerListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "ClassTrainerListScrollFrameScrollBarDiabolicTrack"
                    wowParent: "ClassTrainerListScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 160
                }
            }
        }

        Frame {
            name: "ClassTrainerListScrollFrameScrollChildFrame"
            wowParent: "ClassTrainerListScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 3536
        }
    }

    Button {
        name: "ClassTrainerSkill1"
        text: "Discipline"
        wowParent: "ClassTrainerFrame"
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
            wowParent: "ClassTrainerSkill1"
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
                text: "Discipline"
                wowParent: "ClassTrainerSkill1"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 270
                height: 13
            }
        }
    }

    Ghost {
        name: "ClassTrainerSkill7"
        x: 22
        y: 186
        width: 293
        height: 16

        Frame {
            name: "ClassTrainerSkillHighlightFrame"
            wowParent: "ClassTrainerFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 293
            height: 16
        }
    }
}
