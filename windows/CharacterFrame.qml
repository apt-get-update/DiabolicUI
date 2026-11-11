// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "CharacterFrame"
    width: 384
    height: 512

    Frame {
        id: characterFrameDiabolic
        name: "CharacterFrameDiabolic"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 4
        width: 402
        height: 490

        Button {
            name: "CharacterFrameCloseButton"
            wowParent: "CharacterFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "CharacterFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 402
            height: 458

            Frame {
                name: "CharacterFrameDiabolicTitlePlate"
                wowParent: "CharacterFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                Button {
                    name: "CharacterFrameDiabolicTitlePlateGem"
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }

                FontString {
                    name: "CharacterGuildText"
                    wowParent: "PaperDollFrame"
                    anchors.horizontalCenter: characterLevelText.horizontalCenter
                    anchors.top: characterLevelText.bottom
                    anchors.topMargin: 1
                    width: 1
                    height: 1
                }

                FontString {
                    id: characterLevelText
                    name: "CharacterLevelText"
                    text: "Level 80 Dwarf Priest"
                    wowParent: "PaperDollFrame"
                    anchors.horizontalCenter: characterNameText.horizontalCenter
                    anchors.top: characterNameText.bottom
                    anchors.topMargin: 6
                    width: 113.8
                    height: 10.3
                }

                FontString {
                    id: characterNameText
                    name: "CharacterNameText"
                    text: "Crusader Padirac"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 158.8
                    height: 14.2
                }
            }
        }

        Frame {
            name: "CharacterFrameDiabolicGear"
            wowParent: "PaperDollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 418
            height: 478

            Button {
                name: "CharacterAmmoSlot"
                wowParent: "PaperDollFrame"
                anchors.left: characterRangedSlot.right
                anchors.leftMargin: 15
                anchors.verticalCenter: characterRangedSlot.verticalCenter
                width: 27
                height: 27
            }

            Button {
                id: characterBackSlot
                name: "CharacterBackSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterShoulderSlot.horizontalCenter
                anchors.top: characterShoulderSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterBackSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterChestSlot
                name: "CharacterChestSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterBackSlot.horizontalCenter
                anchors.top: characterBackSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterChestSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterFeetSlot
                name: "CharacterFeetSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterLegsSlot.horizontalCenter
                anchors.top: characterLegsSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterFeetSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterFinger0Slot
                name: "CharacterFinger0Slot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterFeetSlot.horizontalCenter
                anchors.top: characterFeetSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterFinger0SlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterFinger1Slot
                name: "CharacterFinger1Slot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterFinger0Slot.horizontalCenter
                anchors.top: characterFinger0Slot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterFinger1SlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Frame {
                id: characterFrameDiabolicScene
                name: "CharacterFrameDiabolicScene"
                wowParent: "PaperDollFrame"
                pin: "all"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 62
                width: 248
                height: 322

                PlayerModel {
                    name: "CharacterModelFrame"
                    wowParent: "PaperDollFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.top: parent.top
                    anchors.topMargin: -22
                    width: 240
                    height: 372
                }

                Button {
                    id: characterModelFrameRotateLeftButton
                    name: "CharacterModelFrameRotateLeftButton"
                    wowParent: "CharacterModelFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 35
                    height: 35
                }

                Button {
                    name: "CharacterModelFrameRotateRightButton"
                    wowParent: "CharacterModelFrame"
                    anchors.left: characterModelFrameRotateLeftButton.right
                    anchors.top: characterModelFrameRotateLeftButton.top
                    width: 35
                    height: 35
                }
            }

            Button {
                id: characterHandsSlot
                name: "CharacterHandsSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.right: parent.right
                anchors.rightMargin: 38
                anchors.top: parent.top
                anchors.topMargin: 66
                width: 37
                height: 37

                Button {
                    name: "CharacterHandsSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterHeadSlot
                name: "CharacterHeadSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 38
                anchors.top: parent.top
                anchors.topMargin: 66
                width: 37
                height: 37

                Button {
                    name: "CharacterHeadSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterLegsSlot
                name: "CharacterLegsSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterWaistSlot.horizontalCenter
                anchors.top: characterWaistSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterLegsSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                name: "CharacterMainHandSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.right: characterSecondaryHandSlot.left
                anchors.rightMargin: 6
                anchors.top: characterSecondaryHandSlot.top
                width: 37
                height: 37

                Button {
                    name: "CharacterMainHandSlotPopoutButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -4
                    width: 38
                    height: 16
                }
            }

            Button {
                id: characterNeckSlot
                name: "CharacterNeckSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterHeadSlot.horizontalCenter
                anchors.top: characterHeadSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterNeckSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterRangedSlot
                name: "CharacterRangedSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.left: characterSecondaryHandSlot.right
                anchors.leftMargin: 6
                anchors.top: characterSecondaryHandSlot.top
                width: 37
                height: 37

                Button {
                    name: "CharacterRangedSlotPopoutButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -4
                    width: 38
                    height: 16
                }
            }

            Button {
                id: characterSecondaryHandSlot
                name: "CharacterSecondaryHandSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterFrameDiabolicScene.horizontalCenter
                anchors.top: characterFrameDiabolicScene.bottom
                anchors.topMargin: 10
                width: 37
                height: 37

                Button {
                    name: "CharacterSecondaryHandSlotPopoutButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -4
                    width: 38
                    height: 16
                }
            }

            Button {
                id: characterShirtSlot
                name: "CharacterShirtSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterChestSlot.horizontalCenter
                anchors.top: characterChestSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterShirtSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterShoulderSlot
                name: "CharacterShoulderSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterNeckSlot.horizontalCenter
                anchors.top: characterNeckSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterShoulderSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterTabardSlot
                name: "CharacterTabardSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterShirtSlot.horizontalCenter
                anchors.top: characterShirtSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterTabardSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterTrinket0Slot
                name: "CharacterTrinket0Slot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterFinger1Slot.horizontalCenter
                anchors.top: characterFinger1Slot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterTrinket0SlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                name: "CharacterTrinket1Slot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterTrinket0Slot.horizontalCenter
                anchors.top: characterTrinket0Slot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterTrinket1SlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                id: characterWaistSlot
                name: "CharacterWaistSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterHandsSlot.horizontalCenter
                anchors.top: characterHandsSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterWaistSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            Button {
                name: "CharacterWristSlot"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: characterTabardSlot.horizontalCenter
                anchors.top: characterTabardSlot.bottom
                anchors.topMargin: 4
                width: 37
                height: 37

                Button {
                    name: "CharacterWristSlotPopoutButton"
                    anchors.left: parent.right
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16
                    height: 38
                }
            }

            // the title's dropdown, out of sight (the titles' page has them)
            Frame {
                name: "PlayerTitleFrame"
                wowParent: "PaperDollFrame"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 60
                width: 160
                height: 32
            }
        }

        Frame {
            name: "CharacterFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 246
            height: 18
        }

        Frame {
            name: "CharacterFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }
    }

    Button {
        name: "CharacterFrameTab1"
        text: "Character"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "CharacterFrameTab3"
        text: "Reputation"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "CharacterFrameTab4"
        text: "Skills"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "CharacterFrameTab5"
        text: "Currency"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        name: "CharacterNameFrame"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 109
        height: 12
    }

    Button {
        name: "DiabolicUICharacterSideTab1"
        wowParent: "?"
        style: "Tab"
        anchors.right: diabolicUICharacterSideTab2.left
        anchors.rightMargin: 6
        anchors.verticalCenter: diabolicUICharacterSideTab2.verticalCenter
        width: 44
        height: 30
    }

    Button {
        id: diabolicUICharacterSideTab2
        name: "DiabolicUICharacterSideTab2"
        wowParent: "?"
        style: "Tab"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 486
        anchors.top: paperDollFrame.top
        anchors.topMargin: 78
        width: 44
        height: 30
    }

    Button {
        name: "DiabolicUICharacterSideTab3"
        wowParent: "?"
        style: "Tab"
        anchors.left: diabolicUICharacterSideTab2.right
        anchors.leftMargin: 6
        anchors.verticalCenter: diabolicUICharacterSideTab2.verticalCenter
        width: 44
        height: 30
    }

    Frame {
        name: "DiabolicUICharacterStats11"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 268
        width: 144
        height: 13

        FontString {
            name: "DiabolicUICharacterStats11Label"
            text: "Strength:"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 50.6
            height: 10.3
        }

        Frame {
            name: "DiabolicUICharacterStats11Stat"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 13

            FontString {
                name: "DiabolicUICharacterStats11StatText"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: 13.4
                height: 10.3
            }
        }
    }

    ScrollFrame {
        name: "DiabolicUICharacterTitles"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 428
        anchors.top: paperDollFrame.top
        anchors.topMargin: 118
        width: 138
        height: 306

        Frame {
            name: "DiabolicUICharacterTitlesDiabolicParchment"
            wowParent: "?"
            anchors.left: parent.left
            anchors.leftMargin: -4
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 146
            height: 314
        }

        Slider {
            name: "DiabolicUICharacterTitlesScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 274

            Frame {
                name: "DiabolicUICharacterTitlesScrollBarDiabolicTrack"
                anchors.horizontalCenter: diabolicUICharacterTitlesScrollBarScrollUpButton.horizontalCenter
                anchors.top: diabolicUICharacterTitlesScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 308
            }

            Button {
                name: "DiabolicUICharacterTitlesScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: diabolicUICharacterTitlesScrollBarScrollUpButton
                name: "DiabolicUICharacterTitlesScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }
    }

    Frame {
        name: "GearManagerDialog"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 428
        anchors.top: paperDollFrame.top
        anchors.topMargin: 134
        width: 160
        height: 151.5

        Button {
            name: "GearManagerDialogDeleteSet"
            style: "Button"
            anchors.horizontalCenter: gearManagerDialogSaveSet.horizontalCenter
            anchors.top: gearManagerDialogSaveSet.bottom
            anchors.topMargin: 6
            width: 24
            height: 24

            FontString {
                name: "GearManagerDialogDeleteSetText"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 1
            }
        }

        Button {
            id: gearManagerDialogEquipSet
            name: "GearManagerDialogEquipSet"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: 127.9
            anchors.top: parent.top
            anchors.topMargin: 4
            width: 30
            height: 30

            FontString {
                name: "GearManagerDialogEquipSetText"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 1
            }
        }

        Button {
            id: gearManagerDialogSaveSet
            name: "GearManagerDialogSaveSet"
            style: "Button"
            anchors.horizontalCenter: gearManagerDialogEquipSet.horizontalCenter
            anchors.top: gearManagerDialogEquipSet.bottom
            anchors.topMargin: 6
            width: 24
            height: 24

            FontString {
                name: "GearManagerDialogSaveSetText"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 1
            }
        }

        CheckButton {
            name: "GearSetButton1"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 8.4
            width: 36
            height: 36

            FontString {
                name: "GearSetButton1Name"
                text: "holy"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 34.3
                height: 9.5
            }
        }
    }

    Frame {
        name: "GearManagerDialogPopup"
        wowParent: "GearManagerDialog"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: characterFrameDiabolic.top
        width: 297
        height: 298
    }

    Frame {
        name: "MagicResFrame1"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 443.6
        anchors.top: paperDollFrame.top
        anchors.topMargin: 181.7
        width: 26
        height: 26

        FontString {
            name: "MagicResText1"
            text: "0"
            wowParent: "?"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 10.3
            height: 10.3
        }
    }

    Frame {
        name: "MagicResFrame2"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 526.7
        anchors.top: paperDollFrame.top
        anchors.topMargin: 121.3
        width: 26
        height: 26

        FontString {
            name: "MagicResText2"
            text: "0"
            wowParent: "?"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 10.3
            height: 10.3
        }
    }

    Frame {
        name: "MagicResFrame3"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 463.3
        anchors.top: paperDollFrame.top
        anchors.topMargin: 121.3
        width: 26
        height: 26

        FontString {
            name: "MagicResText3"
            text: "0"
            wowParent: "?"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 10.3
            height: 10.3
        }
    }

    Frame {
        name: "MagicResFrame4"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 546.4
        anchors.top: paperDollFrame.top
        anchors.topMargin: 181.7
        width: 26
        height: 26

        FontString {
            name: "MagicResText4"
            text: "0"
            wowParent: "?"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 10.3
            height: 10.3
        }
    }

    Frame {
        name: "MagicResFrame5"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 495
        anchors.top: paperDollFrame.top
        anchors.topMargin: 219
        width: 26
        height: 26

        FontString {
            name: "MagicResText5"
            text: "0"
            wowParent: "?"
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 10.3
            height: 10.3
        }
    }

    Frame {
        id: paperDollFrame
        name: "PaperDollFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Frame {
            name: "CharacterResistanceFrame"
            anchors.right: parent.left
            anchors.rightMargin: -297
            anchors.top: parent.top
            anchors.topMargin: 77
            width: 32
            height: 160
        }
    }

    Frame {
        name: "ReputationDetailFrame"
        wowParent: "ReputationFrame"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: -8
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 96
        width: 260
        height: 203

        CheckButton {
            id: reputationDetailAtWarCheckBox
            name: "ReputationDetailAtWarCheckBox"
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 34
            width: 26
            height: 26

            FontString {
                id: reputationDetailAtWarCheckBoxText
                name: "ReputationDetailAtWarCheckBoxText"
                text: "At War"
                anchors.left: parent.right
                anchors.leftMargin: -2
                anchors.verticalCenter: parent.verticalCenter
                width: 37.9
                height: 10.3
            }

            CheckButton {
                name: "ReputationDetailInactiveCheckBox"
                wowParent: "ReputationDetailFrame"
                anchors.left: reputationDetailAtWarCheckBoxText.right
                anchors.leftMargin: 3
                anchors.verticalCenter: reputationDetailAtWarCheckBoxText.verticalCenter
                width: 26
                height: 26

                FontString {
                    name: "ReputationDetailInactiveCheckBoxText"
                    text: "Move to Inactive"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 90.9
                    height: 10.3
                }
            }
        }

        Button {
            name: "ReputationDetailCloseButton"
            anchors.left: parent.left
            anchors.leftMargin: 230
            anchors.top: parent.top
            anchors.topMargin: -2.7
            width: 22
            height: 22
        }

        FontString {
            name: "ReputationDetailFactionDescription"
            text: "This small group of reclusive night elves raises and trains wintersabers in the Winterspring area."
            anchors.horizontalCenter: reputationDetailFactionName.horizontalCenter
            anchors.top: reputationDetailFactionName.bottom
            anchors.topMargin: 20
            width: 218
            height: 50.6
        }

        FontString {
            id: reputationDetailFactionName
            name: "ReputationDetailFactionName"
            text: "Wintersaber Trainers"
            wowParent: "?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 2
            width: 188
            height: 12.6
        }

        CheckButton {
            name: "ReputationDetailMainScreenCheckBox"
            anchors.left: reputationDetailAtWarCheckBox.left
            anchors.top: reputationDetailAtWarCheckBox.bottom
            anchors.topMargin: -3
            width: 26
            height: 26

            FontString {
                name: "ReputationDetailMainScreenCheckBoxText"
                text: "Show as Experience Bar"
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 126.4
                height: 10.3
            }
        }
    }

    Frame {
        name: "ReputationFrame"
        anchors.left: parent.left
        anchors.leftMargin: 19
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 384
        height: 512

        Button {
            name: "ReputationBar1"
            anchors.right: parent.right
            anchors.rightMargin: 70
            anchors.top: parent.top
            anchors.topMargin: 83
            width: 294
            height: 20

            Button {
                id: reputationBar1ExpandOrCollapseButton
                name: "ReputationBar1ExpandOrCollapseButton"
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.verticalCenter: parent.verticalCenter
                width: 13
                height: 13
            }

            FontString {
                name: "ReputationBar1FactionName"
                text: "Classic"
                anchors.left: reputationBar1ExpandOrCollapseButton.right
                anchors.leftMargin: 10
                anchors.verticalCenter: reputationBar1ExpandOrCollapseButton.verticalCenter
                width: 145
                height: 10
            }

            StatusBar {
                name: "ReputationBar1ReputationBar"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: 101
                height: 13

                FontString {
                    name: "ReputationBar1ReputationBarFactionStanding"
                    text: "Exalted"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40.3
                    height: 10.3
                }
            }
        }

        FontString {
            name: "ReputationFrameFactionLabel"
            text: "Faction"
            anchors.left: parent.left
            anchors.leftMargin: 70
            anchors.top: parent.top
            anchors.topMargin: 57
            width: 44.2
            height: 11.9

            Frame {
                name: "FactionMouseOver"
                wowParent: "ReputationFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 44.2
                height: 11.9
            }
        }

        FontString {
            name: "ReputationFrameStandingLabel"
            text: "Standing"
            anchors.left: parent.left
            anchors.leftMargin: 215
            anchors.top: parent.top
            anchors.topMargin: 59
            width: 53.7
            height: 11.9

            Frame {
                name: "StandingMouseOver"
                wowParent: "ReputationFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 53.7
                height: 11.9
            }
        }

        ScrollFrame {
            name: "ReputationListScrollFrame"
            anchors.right: parent.right
            anchors.rightMargin: 66
            anchors.top: parent.top
            anchors.topMargin: 76
            width: 296
            height: 354

            Slider {
                name: "ReputationListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 322

                Frame {
                    name: "ReputationListScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: reputationListScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: reputationListScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 356
                }

                Button {
                    name: "ReputationListScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: reputationListScrollFrameScrollBarScrollUpButton
                    name: "ReputationListScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "ReputationListScrollFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 1586
            }
        }
    }

    Frame {
        name: "SkillFrame"
        anchors.left: parent.left
        anchors.leftMargin: 19
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 384
        height: 512

        ScrollFrame {
            name: "SkillDetailScrollFrame"
            anchors.left: skillListScrollFrame.left
            anchors.top: skillListScrollFrame.bottom
            anchors.topMargin: 8
            width: 296
            height: 107

            Frame {
                name: "SkillDetailScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 320
                height: 50

                StatusBar {
                    name: "SkillDetailStatusBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -10
                    anchors.verticalCenter: parent.top
                    anchors.verticalCenterOffset: 20
                    width: 211
                    height: 15

                    FontString {
                        id: skillDetailStatusBarSkillName
                        name: "SkillDetailStatusBarSkillName"
                        text: "First Aid"
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 44.2
                        height: 10.3
                    }

                    FontString {
                        name: "SkillDetailStatusBarSkillRank"
                        text: "450/450"
                        anchors.left: skillDetailStatusBarSkillName.right
                        anchors.leftMargin: 13
                        anchors.verticalCenter: skillDetailStatusBarSkillName.verticalCenter
                        width: 128
                        height: 10.3
                    }
                }

                Ghost {
                    name: "SkillDetailCostText"
                    x: 150
                    y: 39.5
                    width: 0
                    height: 0

                    FontString {
                        name: "SkillDetailDescriptionText"
                        wowParent: "SkillDetailScrollChildFrame"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: 275
                        height: 41.1
                    }
                }
            }
        }

        Frame {
            name: "SkillFrameExpandButtonFrame"
            anchors.left: parent.left
            anchors.leftMargin: 70
            anchors.top: parent.top
            anchors.topMargin: 49
            width: 62.8
            height: 32

            Ghost {
                name: "SkillFrameExpandTabLeft"
                x: 8
                y: 10
                width: 0
                height: 0

                Button {
                    name: "SkillFrameCollapseAllButton"
                    text: "All"
                    wowParent: "SkillFrameExpandButtonFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: -3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 3
                    width: 40
                    height: 22
                }
            }
        }

        ScrollFrame {
            id: skillListScrollFrame
            name: "SkillListScrollFrame"
            anchors.right: parent.right
            anchors.rightMargin: 67
            anchors.top: parent.top
            anchors.topMargin: 75
            width: 296
            height: 220

            Slider {
                name: "SkillListScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 188

                Frame {
                    name: "SkillListScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: skillListScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: skillListScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 222
                }

                Button {
                    name: "SkillListScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: skillListScrollFrameScrollBarScrollUpButton
                    name: "SkillListScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "SkillListScrollFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 360
            }
        }

        Button {
            name: "SkillTypeLabel1"
            text: "Class Skills"
            anchors.left: parent.left
            anchors.leftMargin: 22
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 86
            width: 285
            height: 14
        }

        Ghost {
            name: "SkillRankFrame1"
            x: 38
            y: 94
            width: 0
            height: 0

            StatusBar {
                name: "SkillRankFrame2"
                wowParent: "SkillFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 3
                width: 271
                height: 15

                Button {
                    name: "SkillRankFrame2Border"
                    anchors.left: parent.left
                    anchors.leftMargin: -5
                    anchors.verticalCenter: parent.verticalCenter
                    width: 281
                    height: 32
                }

                FontString {
                    id: skillRankFrame2SkillName
                    name: "SkillRankFrame2SkillName"
                    text: "Discipline"
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 52.9
                    height: 10.3
                }

                FontString {
                    name: "SkillRankFrame2SkillRank"
                    anchors.left: skillRankFrame2SkillName.right
                    anchors.leftMargin: 13
                    anchors.verticalCenter: skillRankFrame2SkillName.verticalCenter
                    width: 128
                    height: 1
                }
            }
        }

        Ghost {
            name: "SkillTypeLabel4"
            x: 22
            y: 140
            width: 0
            height: 0

            Button {
                id: skillTypeLabel5
                name: "SkillTypeLabel5"
                text: "Professions"
                wowParent: "SkillFrame"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 18
                width: 285
                height: 14
            }

            Button {
                name: "SkillTypeLabel6"
                text: "Secondary Skills"
                wowParent: "SkillFrame"
                anchors.left: skillTypeLabel5.left
                anchors.verticalCenter: skillTypeLabel5.verticalCenter
                anchors.verticalCenterOffset: 18
                width: 285
                height: 14
            }
        }

        Ghost {
            name: "SkillTypeLabel7"
            x: 22
            y: 194
            width: 0
            height: 0

            Button {
                id: skillTypeLabel8
                name: "SkillTypeLabel8"
                text: "Secondary Skills"
                wowParent: "SkillFrame"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 18
                width: 285
                height: 14
            }

            Button {
                name: "SkillTypeLabel9"
                text: "Weapon Skills"
                wowParent: "SkillFrame"
                anchors.left: skillTypeLabel8.left
                anchors.verticalCenter: skillTypeLabel8.verticalCenter
                anchors.verticalCenterOffset: 18
                width: 285
                height: 14
            }
        }
    }

    Frame {
        name: "TokenFrame"
        anchors.left: parent.left
        anchors.leftMargin: 19
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 384
        height: 512

        ScrollFrame {
            name: "TokenFrameContainer"
            anchors.left: parent.left
            anchors.leftMargin: 26
            anchors.top: parent.top
            anchors.topMargin: 77
            width: 313
            height: 330

            Frame {
                name: "TokenFrameContainerScrollChild"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 299
                height: 420

                Button {
                    name: "TokenFrameContainerButton1"
                    text: "Dungeon and Raid"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    width: 313
                    height: 17

                    FontString {
                        name: "TokenFrameContainerButton1Name"
                        anchors.left: parent.left
                        anchors.leftMargin: 11
                        anchors.verticalCenter: parent.verticalCenter
                        width: 210
                        height: 11
                    }

                    Ghost {
                        name: "TokenFrameContainerButton1Icon"
                        x: 278
                        y: 8.5
                        width: 0
                        height: 0

                        FontString {
                            name: "TokenFrameContainerButton1Count"
                            wowParent: "TokenFrameContainerButton1"
                            anchors.right: parent.left
                            anchors.rightMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            width: 1
                            height: 1
                        }
                    }
                }
            }
        }

        Frame {
            name: "TokenFrameMoneyFrame"
            pin: "place"
            anchors.right: parent.right
            anchors.rightMargin: 44
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 84
            width: 124.8
            height: 13

            Button {
                id: tokenFrameMoneyFrameCopperButton
                name: "TokenFrameMoneyFrameCopperButton"
                text: "71"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 28.8
                height: 13

                FontString {
                    name: "TokenFrameMoneyFrameCopperButtonText"
                    text: "71"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 15.8
                    height: 14.2
                }
            }

            Button {
                name: "TokenFrameMoneyFrameGoldButton"
                text: "1820"
                anchors.right: tokenFrameMoneyFrameSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: tokenFrameMoneyFrameSilverButton.verticalCenter
                width: 44.6
                height: 13

                FontString {
                    name: "TokenFrameMoneyFrameGoldButtonText"
                    text: "1820"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 31.6
                    height: 14.2
                }
            }

            Button {
                id: tokenFrameMoneyFrameSilverButton
                name: "TokenFrameMoneyFrameSilverButton"
                text: "16"
                anchors.right: tokenFrameMoneyFrameCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: tokenFrameMoneyFrameCopperButton.verticalCenter
                width: 30.4
                height: 13

                FontString {
                    name: "TokenFrameMoneyFrameSilverButtonText"
                    text: "16"
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
        name: "TokenFramePopup"
        wowParent: "TokenFrame"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: -8
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 96
        width: 205
        height: 100

        CheckButton {
            name: "TokenFramePopupBackpackCheckBox"
            style: "CheckBox"
            pin: "place"
            anchors.left: tokenFramePopupInactiveCheckBox.left
            anchors.top: tokenFramePopupInactiveCheckBox.bottom
            anchors.topMargin: 6
            width: 20
            height: 20

            FontString {
                name: "TokenFramePopupBackpackCheckBoxText"
                text: "Show on Backpack"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 109
                height: 14.2
            }
        }

        Button {
            name: "TokenFramePopupCloseButton"
            pin: "place"
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 1
            width: 22
            height: 22
        }

        CheckButton {
            id: tokenFramePopupInactiveCheckBox
            name: "TokenFramePopupInactiveCheckBox"
            style: "CheckBox"
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 20
            height: 20

            FontString {
                name: "TokenFramePopupInactiveCheckBoxText"
                text: "Unused"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 44.2
                height: 14.2
            }
        }

        FontString {
            name: "TokenFramePopupTitle"
            text: "Currency Options"
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.top: parent.top
            anchors.topMargin: 17
            width: 104.3
            height: 11.9
        }
    }
}
