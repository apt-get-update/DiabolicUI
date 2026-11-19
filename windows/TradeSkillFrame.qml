// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "TradeSkillFrame"
    kind: "list"
    width: 384
    height: 512

    ScrollFrame {
        name: "TradeSkillDetailScrollFrame"
        pin: "all"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.leftMargin: -1
        anchors.top: tradeSkillListScrollFrame.bottom
        anchors.topMargin: 34
        width: 297
        height: 157

        Frame {
            name: "TradeSkillDetailScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 297
            height: 150

            Button {
                name: "Auctionator_Search"
                text: "Scan AH"
                style: "Button"
                pin: "all"
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.top: parent.top
                anchors.topMargin: 11
                width: 96
                height: 22

                // (on the chapter's dark strip, in its middle, 8 in from its right end: Auctionator's 32 high hung past it)
                FontString {
                    name: "Auctionator_SearchText"
                    text: "Scan AH"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 43.5
                    height: 10.3
                }
            }

            FontString {
                name: "TradeSkillDescription"
                text: " "
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 50
                width: 290
                height: 10.3

                Button {
                    id: tradeSkillReagent1
                    name: "TradeSkillReagent1"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    pin: "place"
                    anchors.left: tradeSkillReagentLabel.left
                    anchors.leftMargin: -2
                    anchors.top: tradeSkillReagentLabel.bottom
                    anchors.topMargin: 7
                    width: 147
                    height: 41

                    Ghost {
                        name: "TradeSkillReagent1IconTexture"
                        x: 39
                        y: 39
                        width: 0
                        height: 0

                        FontString {
                            name: "TradeSkillReagent1Count"
                            text: "0 /10"
                            wowParent: "TradeSkillReagent1"
                            anchors.right: parent.right
                            anchors.rightMargin: 1
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 1
                            width: 32.4
                            height: 14.2
                        }
                    }

                    Ghost {
                        name: "TradeSkillReagent1NameFrame"
                        x: 29
                        y: 19.5
                        width: 0
                        height: 0

                        FontString {
                            name: "TradeSkillReagent1Name"
                            text: "Moonshroud"
                            wowParent: "TradeSkillReagent1"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            width: 100
                            height: 36
                        }
                    }
                }

                Button {
                    name: "TradeSkillReagent2"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    anchors.left: tradeSkillReagent1.right
                    anchors.verticalCenter: tradeSkillReagent1.verticalCenter
                    width: 147
                    height: 41

                    Ghost {
                        name: "TradeSkillReagent2IconTexture"
                        x: 39
                        y: 39
                        width: 0
                        height: 0

                        FontString {
                            name: "TradeSkillReagent2Count"
                            text: "0 /5"
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
                        x: 29
                        y: 19.5
                        width: 0
                        height: 0

                        FontString {
                            name: "TradeSkillReagent2Name"
                            text: "Primordial Saronite"
                            wowParent: "TradeSkillReagent2"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            width: 100
                            height: 36
                        }
                    }
                }

                Button {
                    id: tradeSkillReagent3
                    name: "TradeSkillReagent3"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    pin: "place"
                    anchors.left: tradeSkillReagent1.left
                    anchors.top: tradeSkillReagent1.bottom
                    anchors.topMargin: 6
                    width: 147
                    height: 41

                    Ghost {
                        name: "TradeSkillReagent3IconTexture"
                        x: 39
                        y: 39
                        width: 0
                        height: 0

                        FontString {
                            name: "TradeSkillReagent3Count"
                            text: "0 /8"
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
                        x: 29
                        y: 19.5
                        width: 0
                        height: 0

                        FontString {
                            name: "TradeSkillReagent3Name"
                            text: "Primordial Saronite"
                            wowParent: "TradeSkillReagent3"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            width: 100
                            height: 36
                        }
                    }
                }

                Button {
                    name: "TradeSkillReagent4"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    anchors.left: tradeSkillReagent3.right
                    anchors.verticalCenter: tradeSkillReagent3.verticalCenter
                    width: 147
                    height: 41

                    Ghost {
                        name: "TradeSkillReagent4IconTexture"
                        x: 39
                        y: 39
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
                        x: 29
                        y: 19.5
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
                }

                Button {
                    id: tradeSkillReagent5
                    name: "TradeSkillReagent5"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    pin: "place"
                    anchors.left: tradeSkillReagent3.left
                    anchors.top: tradeSkillReagent3.bottom
                    anchors.topMargin: 6
                    width: 147
                    height: 41
                }

                Button {
                    id: tradeSkillReagent6
                    name: "TradeSkillReagent6"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    pin: "place"
                    anchors.left: tradeSkillReagent5.right
                    anchors.verticalCenter: tradeSkillReagent5.verticalCenter
                    width: 147
                    height: 41
                }

                Button {
                    name: "TradeSkillReagent7"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    pin: "place"
                    anchors.left: tradeSkillReagent6.left
                    anchors.top: tradeSkillReagent6.bottom
                    anchors.topMargin: 6
                    width: 147
                    height: 41
                }

                FontString {
                    id: tradeSkillReagentLabel
                    name: "TradeSkillReagentLabel"
                    wowParent: "TradeSkillDetailScrollChildFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 56.1
                    height: 10.3
                }
            }

            FontString {
                id: tradeSkillRequirementLabel
                name: "TradeSkillRequirementLabel"
                text: "Requires:"
                anchors.left: tradeSkillSkillName.left
                anchors.top: tradeSkillSkillName.bottom
                width: 49.8
                height: 10.3
            }

            FontString {
                name: "TradeSkillRequirementText"
                anchors.left: tradeSkillRequirementLabel.right
                anchors.leftMargin: 4
                anchors.top: tradeSkillRequirementLabel.top
                width: 77.2
                height: 1
            }

            FontString {
                name: "TradeSkillSkillCooldown"
                anchors.left: tradeSkillRequirementLabel.left
                anchors.top: tradeSkillRequirementLabel.bottom
                width: 1
                height: 1
            }

            Button {
                name: "TradeSkillSkillIcon"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "TradeSkillSkillIconCount"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 1
                    height: 1
                }
            }

            FontString {
                id: tradeSkillSkillName
                name: "TradeSkillSkillName"
                text: "Sandals of Consecration"
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 5
                width: 146
                height: 11.9
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
            height: 175
        }

        Frame {
            name: "TradeSkillDetailScrollFrameDiabolicParchment"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.leftMargin: -14
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 335
            height: 165
        }

        Slider {
            name: "TradeSkillDetailScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 26
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 125

            Frame {
                name: "TradeSkillDetailScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: tradeSkillDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: tradeSkillDetailScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 159
            }

            Button {
                name: "TradeSkillDetailScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: tradeSkillDetailScrollFrameScrollBarScrollUpButton
                name: "TradeSkillDetailScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }
    }

    Frame {
        name: "TradeSkillExpandButtonFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 64
        width: 54
        height: 32

        Ghost {
            name: "TradeSkillExpandTabLeft"
            x: 8
            y: 16
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
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 1
                    height: 1
                }

                Ghost {
                    name: "TradeSkillCollapseAllButtonHighlight"
                    x: 19
                    y: 11
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
            }
        }
    }

    Frame {
        name: "TradeSkillFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -26
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
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 374
            height: 40

            CheckButton {
                name: "TradeSkillFrameAvailableFilterCheckButton"
                wowParent: "TradeSkillFrame"
                style: "CheckBox"
                anchors.left: tradeSkillFrameEditBox.right
                anchors.leftMargin: 12
                anchors.verticalCenter: tradeSkillFrameEditBox.verticalCenter
                width: 20
                height: 20

                FontString {
                    name: "TradeSkillFrameAvailableFilterCheckButtonText"
                    text: "Have Materials"
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 86.1
                    height: 14.2
                }
            }

            EditBox {
                id: tradeSkillFrameEditBox
                name: "TradeSkillFrameEditBox"
                text: "Search"
                wowParent: "TradeSkillFrame"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 128
                height: 20

                Frame {
                    name: "TradeSkillFrameEditBoxDiabolicField"
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
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }

                FontString {
                    id: tradeSkillFrameTitleText
                    name: "TradeSkillFrameTitleText"
                    text: "Tailoring 450/450"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 160.4
                    height: 14.2
                }

                Button {
                    name: "TradeSkillLinkButton"
                    wowParent: "TradeSkillFrame"
                    anchors.left: tradeSkillFrameTitleText.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: tradeSkillFrameTitleText.verticalCenter
                    width: 32
                    height: 16
                }
            }
        }

        Frame {
            name: "TradeSkillFrameDiabolicFoot"
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
                    width: 84.5
                    height: 22

                    Button {
                        id: tradeSkillCreateAllButton
                        name: "TradeSkillCreateAllButton"
                        text: "Create All"
                        wowParent: "TradeSkillFrame"
                        style: "Button"
                        pin: "place"
                        anchors.right: parent.left
                        anchors.rightMargin: 91
                        anchors.verticalCenter: parent.verticalCenter
                        width: 80
                        height: 22

                        FontString {
                            name: "TradeSkillCreateAllButtonText"
                            text: "Create All"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 52.1
                            height: 10.3
                        }
                    }

                    FontString {
                        name: "TradeSkillCreateButtonText"
                        text: "Create"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 36.3
                        height: 10.3
                    }

                    Button {
                        id: tradeSkillDecrementButton
                        name: "TradeSkillDecrementButton"
                        wowParent: "TradeSkillFrame"
                        pin: "place"
                        anchors.left: tradeSkillCreateAllButton.right
                        anchors.leftMargin: 2
                        anchors.verticalCenter: tradeSkillCreateAllButton.verticalCenter
                        width: 20
                        height: 20
                    }

                    Button {
                        name: "TradeSkillIncrementButton"
                        wowParent: "TradeSkillFrame"
                        pin: "place"
                        anchors.left: tradeSkillInputBox.right
                        anchors.leftMargin: 8
                        anchors.verticalCenter: tradeSkillInputBox.verticalCenter
                        width: 20
                        height: 20
                    }

                    EditBox {
                        id: tradeSkillInputBox
                        name: "TradeSkillInputBox"
                        text: "1"
                        wowParent: "TradeSkillFrame"
                        style: "EditBox"
                        pin: "place"
                        anchors.left: tradeSkillDecrementButton.right
                        anchors.leftMargin: 8
                        anchors.verticalCenter: tradeSkillDecrementButton.verticalCenter
                        width: 26
                        height: 20

                        Frame {
                            name: "TradeSkillInputBoxDiabolicField"
                            anchors.left: parent.left
                            anchors.leftMargin: -8
                            anchors.verticalCenter: parent.verticalCenter
                            width: 42
                            height: 22
                        }
                    }
                }

                Button {
                    name: "TradeSkillCancelButton"
                    text: "Exit"
                    wowParent: "TradeSkillFrame"
                    style: "Button"
                    pin: "all"
                    width: 84.5
                    height: 22

                    FontString {
                        name: "TradeSkillCancelButtonText"
                        text: "Exit"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 21.3
                        height: 10.3
                    }
                }
            }
        }

        Frame {
            name: "TradeSkillFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Frame {
        name: "TradeSkillFrameDiabolicIronBar"
        wowParent: "TradeSkillFrameDiabolic"
        pin: "all"
        anchors.left: tradeSkillListScrollFrame.left
        anchors.leftMargin: -30
        anchors.top: tradeSkillListScrollFrame.bottom
        anchors.topMargin: 6.5
        width: 392
        height: 16
    }

    Frame {
        id: tradeSkillInvSlotDropDown
        name: "TradeSkillInvSlotDropDown"
        style: "DropDown"
        pin: "place"
        anchors.right: parent.right
        anchors.rightMargin: 78
        anchors.top: parent.top
        anchors.topMargin: 27
        width: 170
        height: 32

        Frame {
            name: "TradeSkillInvSlotDropDownDiabolicField"
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
    }

    ScrollFrame {
        id: tradeSkillListScrollFrame
        name: "TradeSkillListScrollFrame"
        pin: "all"
        anchors.right: parent.right
        anchors.rightMargin: 67
        anchors.top: parent.top
        anchors.topMargin: 68
        width: 296
        height: 135

        Frame {
            name: "TradeSkillListScrollFrameDiabolicPanel"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 360
            height: 147
        }

        Frame {
            name: "TradeSkillListScrollFrameDiabolicZone"
            wowParent: "TradeSkillFrame"
            anchors.left: parent.left
            anchors.leftMargin: -17
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 361
            height: 147

            Slider {
                name: "TradeSkillListScrollFrameScrollBar"
                wowParent: "TradeSkillListScrollFrame"
                style: "ScrollBar"
                anchors.right: parent.right
                anchors.rightMargin: 7
                anchors.top: parent.top
                anchors.topMargin: 23
                width: 16
                height: 101

                Frame {
                    name: "TradeSkillListScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: tradeSkillListScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: tradeSkillListScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 135
                }

                Button {
                    name: "TradeSkillListScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: tradeSkillListScrollFrameScrollBarScrollUpButton
                    name: "TradeSkillListScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }
        }

        Frame {
            name: "TradeSkillListScrollFrameScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 7072
        }
    }

    // the skill's bar centred on our window (24 left of the frame, 14 right of it:
    // room for the scroll bars), its rank in it
    StatusBar {
        name: "TradeSkillRankFrame"
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
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 48.2
            height: 9
        }
    }

    Button {
        id: tradeSkillSkill1
        name: "TradeSkillSkill1"
        text: "Embroider"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 88
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill1SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill1Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill1Count"
                wowParent: "TradeSkillSkill1"
                anchors.left: tradeSkillSkill1Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill1Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill1Text
                name: "TradeSkillSkill1Text"
                text: "Embroider"
                wowParent: "TradeSkillSkill1"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Button {
        id: tradeSkillSkill2
        name: "TradeSkillSkill2"
        text: " Darkglow Embroidery"
        anchors.left: tradeSkillSkill1.left
        anchors.top: tradeSkillSkill1.bottom
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill2SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill2Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill2Count"
                wowParent: "TradeSkillSkill2"
                anchors.left: tradeSkillSkill2Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill2Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill2Text
                name: "TradeSkillSkill2Text"
                text: " Darkglow Embroidery"
                wowParent: "TradeSkillSkill2"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Button {
        id: tradeSkillSkill3
        name: "TradeSkillSkill3"
        text: " Lightweave Embroidery"
        anchors.left: tradeSkillSkill2.left
        anchors.top: tradeSkillSkill2.bottom
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill3SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill3Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill3Count"
                wowParent: "TradeSkillSkill3"
                anchors.left: tradeSkillSkill3Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill3Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill3Text
                name: "TradeSkillSkill3Text"
                text: " Lightweave Embroidery"
                wowParent: "TradeSkillSkill3"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Button {
        id: tradeSkillSkill4
        name: "TradeSkillSkill4"
        text: " Master's Spellthread"
        anchors.left: tradeSkillSkill3.left
        anchors.top: tradeSkillSkill3.bottom
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill4SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill4Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill4Count"
                wowParent: "TradeSkillSkill4"
                anchors.left: tradeSkillSkill4Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill4Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill4Text
                name: "TradeSkillSkill4Text"
                text: " Master's Spellthread"
                wowParent: "TradeSkillSkill4"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Button {
        id: tradeSkillSkill5
        name: "TradeSkillSkill5"
        text: " Sanctified Spellthread"
        anchors.left: tradeSkillSkill4.left
        anchors.top: tradeSkillSkill4.bottom
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

        FontString {
            name: "TradeSkillSkill5SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill5Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill5Count"
                wowParent: "TradeSkillSkill5"
                anchors.left: tradeSkillSkill5Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill5Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill5Text
                name: "TradeSkillSkill5Text"
                text: " Sanctified Spellthread"
                wowParent: "TradeSkillSkill5"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Button {
        id: tradeSkillSkill6
        name: "TradeSkillSkill6"
        text: " Swordguard Embroidery"
        anchors.left: tradeSkillSkill5.left
        anchors.top: tradeSkillSkill5.bottom
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill6SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill6Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill6Count"
                wowParent: "TradeSkillSkill6"
                anchors.left: tradeSkillSkill6Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill6Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill6Text
                name: "TradeSkillSkill6Text"
                text: " Swordguard Embroidery"
                wowParent: "TradeSkillSkill6"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Button {
        name: "TradeSkillSkill7"
        text: "Item Enhancement"
        anchors.left: tradeSkillSkill6.left
        anchors.top: tradeSkillSkill6.bottom
        width: 293
        height: 16

        FontString {
            name: "TradeSkillSkill7SubText"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 1
        }

        Ghost {
            name: "TradeSkillSkill7Highlight"
            x: 19
            y: 8
            width: 0
            height: 0

            FontString {
                name: "TradeSkillSkill7Count"
                wowParent: "TradeSkillSkill7"
                anchors.left: tradeSkillSkill7Text.right
                anchors.leftMargin: 2
                anchors.verticalCenter: tradeSkillSkill7Text.verticalCenter
                width: 1
                height: 13
            }

            FontString {
                id: tradeSkillSkill7Text
                name: "TradeSkillSkill7Text"
                text: "Item Enhancement"
                wowParent: "TradeSkillSkill7"
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 275
                height: 13
            }
        }
    }

    Frame {
        name: "TradeSkillSubClassDropDown"
        style: "DropDown"
        pin: "place"
        anchors.right: tradeSkillInvSlotDropDown.left
        anchors.rightMargin: -27
        anchors.verticalCenter: tradeSkillInvSlotDropDown.verticalCenter
        width: 170
        height: 32

        Frame {
            name: "TradeSkillSubClassDropDownDiabolicField"
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
