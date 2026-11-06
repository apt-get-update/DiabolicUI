// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "TradeSkillFrame"
    width: 384
    height: 512

    ScrollFrame {
        name: "TradeSkillDetailScrollFrame"
        wowParent: "TradeSkillFrame"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 255
        width: 297
        height: 132

        Frame {
            name: "TradeSkillDetailScrollChildFrame"
            wowParent: "TradeSkillDetailScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 297
            height: 150

            Button {
                name: "Auctionator_Search"
                text: "Scan AH"
                wowParent: "TradeSkillDetailScrollChildFrame"
                style: "Button"
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 96
                height: 32

                FontString {
                    name: "Auctionator_SearchText"
                    text: "Scan AH"
                    wowParent: "Auctionator_Search"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 43.5
                    height: 10.3
                }
            }

            FontString {
                name: "TradeSkillDescription"
                text: " "
                wowParent: "TradeSkillDetailScrollChildFrame"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 50
                width: 290
                height: 10.3

                FontString {
                    name: "TradeSkillReagentLabel"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 56.1
                    height: 10.3

                    Button {
                        name: "TradeSkillReagent1"
                        wowParent: "TradeSkillDetailScrollChildFrame"
                        pin: "place"
                        anchors.left: parent.left
                        anchors.leftMargin: -2
                        anchors.top: parent.bottom
                        anchors.topMargin: 7
                        width: 147
                        height: 41

                        Button {
                            name: "TradeSkillReagent2"
                            wowParent: "TradeSkillDetailScrollChildFrame"
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            width: 147
                            height: 41
                        }

                        Button {
                            name: "TradeSkillReagent3"
                            wowParent: "TradeSkillDetailScrollChildFrame"
                            pin: "place"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 6
                            width: 147
                            height: 41

                            Button {
                                name: "TradeSkillReagent4"
                                wowParent: "TradeSkillDetailScrollChildFrame"
                                anchors.left: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: 147
                                height: 41
                            }

                            Button {
                                name: "TradeSkillReagent5"
                                wowParent: "TradeSkillDetailScrollChildFrame"
                                pin: "place"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 6
                                width: 147
                                height: 41

                                Button {
                                    name: "TradeSkillReagent6"
                                    wowParent: "TradeSkillDetailScrollChildFrame"
                                    pin: "place"
                                    anchors.left: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 147
                                    height: 41

                                    Button {
                                        name: "TradeSkillReagent7"
                                        wowParent: "TradeSkillDetailScrollChildFrame"
                                        pin: "place"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 6
                                        width: 147
                                        height: 41
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Button {
                name: "TradeSkillSkillIcon"
                wowParent: "TradeSkillDetailScrollChildFrame"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "TradeSkillSkillIconCount"
                    wowParent: "TradeSkillSkillIcon"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 1
                    height: 1
                }
            }

            FontString {
                name: "TradeSkillSkillName"
                text: "Heavy Frostweave Bandage"
                wowParent: "TradeSkillDetailScrollChildFrame"
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 5
                width: 146
                height: 23.7

                FontString {
                    name: "TradeSkillRequirementLabel"
                    text: "Requires:"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    width: 49.8
                    height: 10.3

                    FontString {
                        name: "TradeSkillRequirementText"
                        wowParent: "TradeSkillDetailScrollChildFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 4
                        anchors.top: parent.top
                        width: 87.2
                        height: 1
                    }

                    FontString {
                        name: "TradeSkillSkillCooldown"
                        wowParent: "TradeSkillDetailScrollChildFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        width: 1
                        height: 1
                    }
                }
            }
        }

        Frame {
            name: "TradeSkillDetailScrollFrameDiabolicPanel"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: -12
            width: 361
            height: 150
        }

        Frame {
            name: "TradeSkillDetailScrollFrameDiabolicParchment"
            wowParent: "TradeSkillFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 5.5
            anchors.top: parent.top
            anchors.topMargin: -10
            width: 334
            height: 146
        }

        Slider {
            name: "TradeSkillDetailScrollFrameScrollBar"
            wowParent: "TradeSkillDetailScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 26
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 100

            Button {
                name: "TradeSkillDetailScrollFrameScrollBarScrollDownButton"
                wowParent: "TradeSkillDetailScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "TradeSkillDetailScrollFrameScrollBarScrollUpButton"
                wowParent: "TradeSkillDetailScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "TradeSkillDetailScrollFrameScrollBarDiabolicTrack"
                    wowParent: "TradeSkillDetailScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 134
                }
            }
        }
    }

    Frame {
        name: "TradeSkillExpandButtonFrame"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 53
        width: 54
        height: 32
    }

    Frame {
        name: "TradeSkillFrameDiabolic"
        wowParent: "TradeSkillFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -40
        width: 422
        height: 509

        Button {
            name: "TradeSkillFrameCloseButton"
            wowParent: "TradeSkillFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "TradeSkillFrameDiabolicBand"
            wowParent: "TradeSkillFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 374
            height: 40

            EditBox {
                name: "TradeSkillFrameEditBox"
                text: "Search"
                wowParent: "TradeSkillFrame"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 128
                height: 20

                CheckButton {
                    name: "TradeSkillFrameAvailableFilterCheckButton"
                    wowParent: "TradeSkillFrame"
                    style: "CheckBox"
                    pin: "place"
                    anchors.left: parent.right
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    width: 20
                    height: 20

                    FontString {
                        name: "TradeSkillFrameAvailableFilterCheckButtonText"
                        text: "Have Materials"
                        wowParent: "TradeSkillFrameAvailableFilterCheckButton"
                        anchors.left: parent.right
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 86.1
                        height: 14.2
                    }
                }

                Frame {
                    name: "TradeSkillFrameEditBoxDiabolicField"
                    wowParent: "TradeSkillFrameEditBox"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 144
                    height: 22
                }
            }
        }

        Frame {
            name: "TradeSkillFrameDiabolicBorder"
            wowParent: "TradeSkillFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 422
            height: 509

            Frame {
                name: "TradeSkillFrameDiabolicTitlePlate"
                wowParent: "TradeSkillFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                Button {
                    name: "TradeSkillFrameDiabolicTitlePlateGem"
                    wowParent: "TradeSkillFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }

                FontString {
                    name: "TradeSkillFrameTitleText"
                    text: "First Aid"
                    wowParent: "TradeSkillFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 79.8
                    height: 14.2

                    Button {
                        name: "TradeSkillLinkButton"
                        wowParent: "TradeSkillFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 16
                    }
                }
            }
        }

        Frame {
            name: "TradeSkillFrameDiabolicFoot"
            wowParent: "TradeSkillFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 376
            height: 35

            WowRow {
                name: "TradeSkillButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 185
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "TradeSkillCreateButton"
                    text: "Create"
                    wowParent: "TradeSkillFrame"
                    style: "Button"
                    pin: "all"
                    width: 85.5
                    height: 22

                    Button {
                        name: "TradeSkillCreateAllButton"
                        text: "Create All"
                        wowParent: "TradeSkillFrame"
                        style: "Button"
                        anchors.right: parent.left
                        anchors.rightMargin: 86
                        anchors.verticalCenter: parent.verticalCenter
                        width: 80
                        height: 22

                        FontString {
                            name: "TradeSkillCreateAllButtonText"
                            text: "Create All"
                            wowParent: "TradeSkillCreateAllButton"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 52.1
                            height: 10.3
                        }

                        Button {
                            name: "TradeSkillDecrementButton"
                            wowParent: "TradeSkillFrame"
                            pin: "place"
                            anchors.left: parent.right
                            anchors.leftMargin: 2
                            anchors.verticalCenter: parent.verticalCenter
                            width: 20
                            height: 20

                            EditBox {
                                name: "TradeSkillInputBox"
                                text: "1"
                                wowParent: "TradeSkillFrame"
                                style: "EditBox"
                                pin: "place"
                                anchors.left: parent.right
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                width: 26
                                height: 20

                                Button {
                                    name: "TradeSkillIncrementButton"
                                    wowParent: "TradeSkillFrame"
                                    pin: "place"
                                    anchors.left: parent.right
                                    anchors.leftMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 20
                                    height: 20
                                }

                                Frame {
                                    name: "TradeSkillInputBoxDiabolicField"
                                    wowParent: "TradeSkillInputBox"
                                    anchors.left: parent.left
                                    anchors.leftMargin: -8
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 42
                                    height: 22
                                }
                            }
                        }
                    }

                    FontString {
                        name: "TradeSkillCreateButtonText"
                        text: "Create"
                        wowParent: "TradeSkillCreateButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 36.3
                        height: 10.3
                    }
                }

                Button {
                    name: "TradeSkillCancelButton"
                    text: "Exit"
                    wowParent: "TradeSkillFrame"
                    style: "Button"
                    pin: "all"
                    width: 85.5
                    height: 22

                    FontString {
                        name: "TradeSkillCancelButtonText"
                        text: "Exit"
                        wowParent: "TradeSkillCancelButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 21.3
                        height: 10.3
                    }
                }
            }
        }

        Frame {
            name: "TradeSkillFrameDiabolicIronBar"
            wowParent: "TradeSkillFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 422
            height: 509
        }

        Frame {
            name: "TradeSkillFrameDiabolicSocket"
            wowParent: "TradeSkillFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Frame {
        name: "TradeSkillInvSlotDropDown"
        wowParent: "TradeSkillFrame"
        style: "DropDown"
        pin: "place"
        anchors.right: parent.right
        anchors.rightMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 48
        width: 170
        height: 32

        Frame {
            name: "TradeSkillInvSlotDropDownDiabolicField"
            wowParent: "TradeSkillInvSlotDropDown"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 170
            height: 22

            Button {
                name: "TradeSkillInvSlotDropDownButton"
                wowParent: "TradeSkillInvSlotDropDown"
                anchors.right: parent.right
                anchors.rightMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 18
                height: 18
            }

            FontString {
                name: "TradeSkillInvSlotDropDownText"
                text: "All Slots"
                wowParent: "TradeSkillInvSlotDropDown"
                anchors.left: parent.left
                anchors.leftMargin: 22
                anchors.verticalCenter: parent.verticalCenter
                width: 108
                height: 10
            }
        }

        Frame {
            name: "TradeSkillSubClassDropDown"
            wowParent: "TradeSkillFrame"
            style: "DropDown"
            pin: "place"
            anchors.right: parent.left
            anchors.rightMargin: -27
            anchors.verticalCenter: parent.verticalCenter
            width: 170
            height: 32

            Frame {
                name: "TradeSkillSubClassDropDownDiabolicField"
                wowParent: "TradeSkillSubClassDropDown"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 170
                height: 22

                Button {
                    name: "TradeSkillSubClassDropDownButton"
                    wowParent: "TradeSkillSubClassDropDown"
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    width: 18
                    height: 18
                }

                FontString {
                    name: "TradeSkillSubClassDropDownText"
                    text: "All Subclasses"
                    wowParent: "TradeSkillSubClassDropDown"
                    anchors.left: parent.left
                    anchors.leftMargin: 22
                    anchors.verticalCenter: parent.verticalCenter
                    width: 108
                    height: 10
                }
            }
        }
    }

    ScrollFrame {
        name: "TradeSkillListScrollFrame"
        wowParent: "TradeSkillFrame"
        pin: "all"
        anchors.right: parent.right
        anchors.rightMargin: 67
        anchors.top: parent.top
        anchors.topMargin: 89
        width: 296
        height: 125

        Frame {
            name: "TradeSkillListScrollFrameDiabolicPanel"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 360
            height: 137
        }

        Frame {
            name: "TradeSkillListScrollFrameDiabolicParchment"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.leftMargin: -14
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 334
            height: 133
        }

        Slider {
            name: "TradeSkillListScrollFrameScrollBar"
            wowParent: "TradeSkillListScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 26
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 93

            Button {
                name: "TradeSkillListScrollFrameScrollBarScrollDownButton"
                wowParent: "TradeSkillListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "TradeSkillListScrollFrameScrollBarScrollUpButton"
                wowParent: "TradeSkillListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "TradeSkillListScrollFrameScrollBarDiabolicTrack"
                    wowParent: "TradeSkillListScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 127
                }
            }
        }

        Frame {
            name: "TradeSkillListScrollFrameScrollChildFrame"
            wowParent: "TradeSkillListScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: -144
            width: 300
            height: 272
        }
    }

    // the skill's bar centred on our window (24 left of the frame, 14 right of it:
    // room for the scroll bars), its rank in it
    StatusBar {
        name: "TradeSkillRankFrame"
        wowParent: "TradeSkillFrame"
        style: "Bar"
        pin: "place"
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 187
        anchors.top: parent.top
        anchors.topMargin: 32
        width: 265
        height: 14

        FontString {
            name: "TradeSkillRankFrameSkillRank"
            text: "450/450"
            wowParent: "TradeSkillRankFrame"
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 48.2
            height: 9
        }
    }

    Button {
        name: "TradeSkillSkill1"
        text: " Heavy Silk Bandage"
        wowParent: "TradeSkillFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 89
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill1SubText"
            wowParent: "TradeSkillSkill1"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }
    }

    Ghost {
        name: "TradeSkillCollapseAllButtonHighlight"
        x: 42
        y: 66
        width: 0
        height: 0

        FontString {
            name: "TradeSkillCollapseAllButtonText"
            text: "All"
            wowParent: "TradeSkillCollapseAllButton"
            anchors.left: parent.right
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 270
            height: 13
        }
    }

    Ghost {
        name: "TradeSkillExpandTabLeft"
        x: 23
        y: 69
        width: 0
        height: 0

        Button {
            name: "TradeSkillCollapseAllButton"
            text: "All"
            wowParent: "TradeSkillExpandButtonFrame"
            anchors.left: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -3
            width: 40
            height: 22

            FontString {
                name: "TradeSkillCollapseAllButtonSubText"
                wowParent: "TradeSkillCollapseAllButton"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 1
            }
        }
    }

    Ghost {
        name: "TradeSkillReagent1IconTexture"
        x: 62
        y: 361.2
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent1Count"
            text: "0 /2"
            wowParent: "TradeSkillReagent1"
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            width: 25.3
            height: 14.2
        }
    }

    Ghost {
        name: "TradeSkillReagent1NameFrame"
        x: 52
        y: 341.7
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent1Name"
            text: "Frostweave Cloth"
            wowParent: "TradeSkillReagent1"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 36
        }
    }

    Ghost {
        name: "TradeSkillReagent2IconTexture"
        x: 209
        y: 385.8
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent2Count"
            text: "0 /6"
            wowParent: "TradeSkillReagent2"
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            width: 25.3
            height: 14.2
        }
    }

    Ghost {
        name: "TradeSkillReagent2NameFrame"
        x: 199
        y: 366.3
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent2Name"
            text: "Dream Shard"
            wowParent: "TradeSkillReagent2"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 36
        }
    }

    Ghost {
        name: "TradeSkillReagent3IconTexture"
        x: 62
        y: 432.8
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent3Count"
            text: "0 /6"
            wowParent: "TradeSkillReagent3"
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            width: 25.3
            height: 14.2
        }
    }

    Ghost {
        name: "TradeSkillReagent3NameFrame"
        x: 52
        y: 413.3
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent3Name"
            text: "Abyss Crystal"
            wowParent: "TradeSkillReagent3"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 36
        }
    }

    Ghost {
        name: "TradeSkillReagent4IconTexture"
        x: 209
        y: 354.8
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent4Count"
            text: "0 /1"
            wowParent: "TradeSkillReagent4"
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            width: 23.7
            height: 14.2
        }
    }

    Ghost {
        name: "TradeSkillReagent4NameFrame"
        x: 199
        y: 335.3
        width: 0
        height: 0

        FontString {
            name: "TradeSkillReagent4Name"
            text: "Northern Spices"
            wowParent: "TradeSkillReagent4"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 36
        }
    }

    Ghost {
        name: "TradeSkillSkill1Highlight"
        x: 41
        y: 97
        width: 0
        height: 0

        FontString {
            name: "TradeSkillSkill1Text"
            text: " Heavy Silk Bandage"
            wowParent: "TradeSkillSkill1"
            anchors.left: parent.right
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 275
            height: 13

            FontString {
                name: "TradeSkillSkill1Count"
                wowParent: "TradeSkillSkill1"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 13
            }
        }
    }

    Ghost {
        name: "TradeSkillSkill2"
        x: 22
        y: 105
        width: 293
        height: 16

        Frame {
            name: "TradeSkillHighlightFrame"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 293
            height: 16
        }
    }
}
