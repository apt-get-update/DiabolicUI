// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "SpellBookFrame"
    width: 384
    height: 512

    Frame {
        name: "SpellBookFrameDiabolic"
        wowParent: "SpellBookFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -36
        width: 550
        height: 548

        Button {
            name: "DiabolicUISpellBookTabCRITTER"
            text: "Companions"
            wowParent: "SpellBookFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "DiabolicUISpellBookTabMOUNT"
            text: "Mounts"
            wowParent: "SpellBookFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 144
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "DiabolicUISpellBookTabPROFESSIONS"
            text: "Professions"
            wowParent: "SpellBookFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 202
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "SpellBookCloseButton"
            wowParent: "SpellBookFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "SpellBookFrameDiabolicBand"
            wowParent: "SpellBookFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 502
            height: 40

            EditBox {
                name: "DiabolicUISpellBookSearchBox"
                wowParent: "SpellBookFrame"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 160
                height: 20

                Frame {
                    name: "DiabolicUISpellBookSearchBoxDiabolicField"
                    wowParent: "DiabolicUISpellBookSearchBox"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 176
                    height: 22
                }

                CheckButton {
                    name: "DiabolicUISpellBookUnassignedBox"
                    wowParent: "SpellBookFrame"
                    style: "CheckBox"
                    anchors.left: showAllSpellRanksCheckBox.right
                    anchors.leftMargin: 65.8
                    anchors.verticalCenter: showAllSpellRanksCheckBox.verticalCenter
                    width: 20
                    height: 20

                    FontString {
                        name: "DiabolicUISpellBookUnassignedBoxText"
                        text: "Unassigned"
                        wowParent: "DiabolicUISpellBookUnassignedBox"
                        anchors.left: parent.right
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 68
                        height: 14.2
                    }
                }

                CheckButton {
                    id: showAllSpellRanksCheckBox
                    name: "ShowAllSpellRanksCheckBox"
                    wowParent: "SpellBookFrame"
                    style: "CheckBox"
                    anchors.left: parent.right
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    width: 20
                    height: 20

                    FontString {
                        name: "ShowAllSpellRanksCheckBoxText"
                        text: "All ranks"
                        wowParent: "ShowAllSpellRanksCheckBox"
                        anchors.left: parent.right
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 49.8
                        height: 14.2
                    }
                }
            }
        }

        Frame {
            name: "SpellBookFrameDiabolicBorder"
            wowParent: "SpellBookFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 550
            height: 516

            Frame {
                name: "SpellBookFrameDiabolicTitlePlate"
                wowParent: "SpellBookFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "SpellBookTitleText"
                    text: "Spellbook"
                    wowParent: "SpellBookFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 88.5
                    height: 14.2
                }
            }
        }

        Frame {
            name: "SpellBookFrameDiabolicCover"
            wowParent: "SpellBookFrame"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.top: parent.top
            anchors.topMargin: 55
            width: 504
            height: 470

            Frame {
                name: "PetPaperDollFrameCompanionFrame"
                wowParent: "SpellBookFrameDiabolicCover"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 18
                width: 504
                height: 452

                CheckButton {
                    name: "CompanionButton1"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 189
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton10"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 333
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton11"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 178
                    anchors.top: parent.top
                    anchors.topMargin: 333
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton12"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 340
                    anchors.top: parent.top
                    anchors.topMargin: 333
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton2"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 178
                    anchors.top: parent.top
                    anchors.topMargin: 189
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton3"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 340
                    anchors.top: parent.top
                    anchors.topMargin: 189
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton4"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 237
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton5"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 178
                    anchors.top: parent.top
                    anchors.topMargin: 237
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton6"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 340
                    anchors.top: parent.top
                    anchors.topMargin: 237
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton7"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 285
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton8"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 178
                    anchors.top: parent.top
                    anchors.topMargin: 285
                    width: 37
                    height: 37
                }

                CheckButton {
                    name: "CompanionButton9"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.left: parent.left
                    anchors.leftMargin: 340
                    anchors.top: parent.top
                    anchors.topMargin: 285
                    width: 37
                    height: 37
                }

                DressUpModel {
                    name: "CompanionModelFrame"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 11
                    anchors.top: parent.top
                    anchors.topMargin: 19
                    width: 482
                    height: 146

                    Button {
                        name: "CompanionModelFrameRotateLeftButton"
                        wowParent: "CompanionModelFrame"
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 6
                        width: 35
                        height: 35
                    }

                    Button {
                        name: "CompanionModelFrameRotateRightButton"
                        wowParent: "CompanionModelFrame"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 6
                        width: 35
                        height: 35
                    }

                    Button {
                        name: "CompanionSummonButton"
                        text: "Mount"
                        wowParent: "PetPaperDollFrameCompanionFrame"
                        style: "Button"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 11.5
                        width: 140
                        height: 24

                        FontString {
                            name: "CompanionSummonButtonText"
                            text: "Mount"
                            wowParent: "CompanionSummonButton"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 49.8
                            height: 11.9
                        }
                    }
                }

                Button {
                    name: "CompanionNextPageButton"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    pin: "place"
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 387
                    width: 26
                    height: 26

                    FontString {
                        name: "CompanionPageNumber"
                        text: "Page 1 of 1"
                        wowParent: "PetPaperDollFrameCompanionFrame"
                        pin: "place"
                        anchors.right: parent.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 60
                        height: 10.3

                        Button {
                            name: "CompanionPrevPageButton"
                            wowParent: "PetPaperDollFrameCompanionFrame"
                            pin: "place"
                            anchors.right: parent.left
                            anchors.rightMargin: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 26
                            height: 26
                        }
                    }
                }

                FontString {
                    name: "CompanionSelectedName"
                    text: "Bronze Drake Mount"
                    wowParent: "PetPaperDollFrameCompanionFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 107
                    anchors.top: parent.top
                    anchors.topMargin: -4
                    width: 290
                    height: 13
                }
            }
        }

        Frame {
            name: "SpellBookFrameDiabolicRail"
            wowParent: "SpellBookFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 246
            height: 18
        }

        Frame {
            name: "SpellBookFrameDiabolicSocket"
            wowParent: "SpellBookFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "SpellBookFrameTabButton1"
            text: "Spellbook"
            wowParent: "SpellBookFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "SpellBookNextPageButton"
            wowParent: "SpellBookFrame"
            anchors.right: parent.right
            anchors.rightMargin: 72
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 483
            width: 26
            height: 26

            FontString {
                name: "SpellBookPageText"
                text: "Page 1"
                wowParent: "SpellBookFrame"
                anchors.right: parent.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 39.5
                height: 11.9

                Button {
                    name: "SpellBookPrevPageButton"
                    wowParent: "SpellBookFrame"
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 26
                    height: 26
                }
            }
        }

        CheckButton {
            name: "SpellBookSkillLineTab1"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 116
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab2"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 164
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab3"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 212
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab4"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 260
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab5"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 308
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab6"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 356
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab7"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 404
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellBookSkillLineTab8"
            wowParent: "SpellBookFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 486
            anchors.top: parent.top
            anchors.topMargin: 452
            width: 36
            height: 36
        }

        CheckButton {
            name: "SpellButton1"
            wowParent: "SpellBookFrame"
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 140
            width: 37
            height: 37

            FontString {
                name: "SpellButton1SpellName"
                text: "Auto Attack"
                wowParent: "SpellButton1"
                anchors.left: parent.right
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -2
                width: 145
                height: 11.9

                FontString {
                    name: "SpellButton1SubSpellName"
                    wowParent: "SpellButton1"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: -4
                    width: 145
                    height: 18
                }
            }
        }
    }
}
