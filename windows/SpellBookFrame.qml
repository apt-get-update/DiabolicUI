// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: spellBookFrame
    name: "SpellBookFrame"
    width: 384
    height: 512

    Part {
        id: companionButton1
        name: "CompanionButton1"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 189
        width: 37
        height: 37
    }

    Part {
        id: companionButton10
        name: "CompanionButton10"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 333
        width: 37
        height: 37
    }

    Part {
        id: companionButton11
        name: "CompanionButton11"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 333
        width: 37
        height: 37
    }

    Part {
        id: companionButton12
        name: "CompanionButton12"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 333
        width: 37
        height: 37
    }

    Part {
        id: companionButton2
        name: "CompanionButton2"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 189
        width: 37
        height: 37
    }

    Part {
        id: companionButton3
        name: "CompanionButton3"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 189
        width: 37
        height: 37
    }

    Part {
        id: companionButton4
        name: "CompanionButton4"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 237
        width: 37
        height: 37
    }

    Part {
        id: companionButton5
        name: "CompanionButton5"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 237
        width: 37
        height: 37
    }

    Part {
        id: companionButton6
        name: "CompanionButton6"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 237
        width: 37
        height: 37
    }

    Part {
        id: companionButton7
        name: "CompanionButton7"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 285
        width: 37
        height: 37
    }

    Part {
        id: companionButton8
        name: "CompanionButton8"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 285
        width: 37
        height: 37
    }

    Part {
        id: companionButton9
        name: "CompanionButton9"
        kind: "CheckButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 285
        width: 37
        height: 37
    }

    Part {
        id: companionModelFrame
        name: "CompanionModelFrame"
        kind: "DressUpModel"
        wowParent: "PetPaperDollFrameCompanionFrame"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 11
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 19
        width: 482
        height: 146
    }

    Part {
        id: companionModelFrameRotateLeftButton
        name: "CompanionModelFrameRotateLeftButton"
        kind: "Button"
        wowParent: "CompanionModelFrame"
        anchors.left: companionModelFrame.left
        anchors.leftMargin: 6
        anchors.bottom: companionModelFrame.bottom
        anchors.bottomMargin: 6
        width: 35
        height: 35
    }

    Part {
        id: companionModelFrameRotateRightButton
        name: "CompanionModelFrameRotateRightButton"
        kind: "Button"
        wowParent: "CompanionModelFrame"
        anchors.right: companionModelFrame.right
        anchors.rightMargin: 6
        anchors.bottom: companionModelFrame.bottom
        anchors.bottomMargin: 6
        width: 35
        height: 35
    }

    Part {
        id: companionNextPageButton
        name: "CompanionNextPageButton"
        kind: "Button"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.right: petPaperDollFrameCompanionFrame.right
        anchors.rightMargin: 12
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 387
        width: 26
        height: 26
    }

    Part {
        id: companionPageNumber
        name: "CompanionPageNumber"
        kind: "FontString"
        text: "Page 1 of 1"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.right: companionNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: companionNextPageButton.verticalCenter
        width: 60
        height: 10.3
    }

    Part {
        id: companionPrevPageButton
        name: "CompanionPrevPageButton"
        kind: "Button"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.right: companionPageNumber.left
        anchors.rightMargin: 4
        anchors.verticalCenter: companionPageNumber.verticalCenter
        width: 26
        height: 26
    }

    Part {
        id: companionSelectedName
        name: "CompanionSelectedName"
        kind: "FontString"
        text: "Bronze Drake Mount"
        wowParent: "PetPaperDollFrameCompanionFrame"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 107
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: -4
        width: 290
        height: 13
    }

    Part {
        id: companionSummonButton
        name: "CompanionSummonButton"
        kind: "Button"
        text: "Mount"
        wowParent: "PetPaperDollFrameCompanionFrame"
        style: "Button"
        anchors.horizontalCenter: companionModelFrame.horizontalCenter
        anchors.bottom: companionModelFrame.bottom
        anchors.bottomMargin: 11.5
        width: 140
        height: 24
    }

    Part {
        id: companionSummonButtonText
        name: "CompanionSummonButtonText"
        kind: "FontString"
        text: "Mount"
        wowParent: "CompanionSummonButton"
        anchors.horizontalCenter: companionSummonButton.horizontalCenter
        anchors.verticalCenter: companionSummonButton.verticalCenter
        width: 49.8
        height: 11.9
    }

    Part {
        id: diabolicUISpellBookSearchBox
        name: "DiabolicUISpellBookSearchBox"
        kind: "EditBox"
        wowParent: "SpellBookFrame"
        style: "EditBox"
        anchors.left: spellBookFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: spellBookFrameDiabolicBand.verticalCenter
        width: 160
        height: 20
    }

    Part {
        id: diabolicUISpellBookSearchBoxDiabolicField
        name: "DiabolicUISpellBookSearchBoxDiabolicField"
        kind: "Frame"
        wowParent: "DiabolicUISpellBookSearchBox"
        anchors.left: diabolicUISpellBookSearchBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: diabolicUISpellBookSearchBox.verticalCenter
        width: 176
        height: 22
    }

    Part {
        id: diabolicUISpellBookTabCRITTER
        name: "DiabolicUISpellBookTabCRITTER"
        kind: "Button"
        text: "Companions"
        wowParent: "SpellBookFrame"
        style: "Banner"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: spellBookFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: diabolicUISpellBookTabMOUNT
        name: "DiabolicUISpellBookTabMOUNT"
        kind: "Button"
        text: "Mounts"
        wowParent: "SpellBookFrame"
        style: "Banner"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: spellBookFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: diabolicUISpellBookTabPROFESSIONS
        name: "DiabolicUISpellBookTabPROFESSIONS"
        kind: "Button"
        text: "Professions"
        wowParent: "SpellBookFrame"
        style: "Banner"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: spellBookFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: diabolicUISpellBookUnassignedBox
        name: "DiabolicUISpellBookUnassignedBox"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        style: "CheckBox"
        anchors.left: showAllSpellRanksCheckBox.right
        anchors.leftMargin: 65.8
        anchors.verticalCenter: showAllSpellRanksCheckBox.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: diabolicUISpellBookUnassignedBoxText
        name: "DiabolicUISpellBookUnassignedBoxText"
        kind: "FontString"
        text: "Unassigned"
        wowParent: "DiabolicUISpellBookUnassignedBox"
        anchors.left: diabolicUISpellBookUnassignedBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: diabolicUISpellBookUnassignedBox.verticalCenter
        width: 68
        height: 14.2
    }

    Part {
        id: petPaperDollFrameCompanionFrame
        name: "PetPaperDollFrameCompanionFrame"
        kind: "Frame"
        wowParent: "SpellBookFrameDiabolicCover"
        anchors.left: spellBookFrameDiabolicCover.left
        anchors.top: spellBookFrameDiabolicCover.top
        anchors.topMargin: 18
        width: 504
        height: 452
    }

    Part {
        id: showAllSpellRanksCheckBox
        name: "ShowAllSpellRanksCheckBox"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        style: "CheckBox"
        anchors.left: diabolicUISpellBookSearchBox.right
        anchors.leftMargin: 20
        anchors.verticalCenter: diabolicUISpellBookSearchBox.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: showAllSpellRanksCheckBoxText
        name: "ShowAllSpellRanksCheckBoxText"
        kind: "FontString"
        text: "All ranks"
        wowParent: "ShowAllSpellRanksCheckBox"
        anchors.left: showAllSpellRanksCheckBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: showAllSpellRanksCheckBox.verticalCenter
        width: 49.8
        height: 14.2
    }

    Part {
        id: spellBookCloseButton
        name: "SpellBookCloseButton"
        kind: "Button"
        wowParent: "SpellBookFrame"
        style: "CloseButton"
        anchors.horizontalCenter: spellBookFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: spellBookFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: spellBookFrameDiabolic
        name: "SpellBookFrameDiabolic"
        kind: "Frame"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrame.left
        anchors.top: spellBookFrame.top
        anchors.topMargin: -36
        width: 550
        height: 548
    }

    Part {
        id: spellBookFrameDiabolicBand
        name: "SpellBookFrameDiabolicBand"
        kind: "Frame"
        wowParent: "SpellBookFrameDiabolic"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 56
        width: 502
        height: 40
    }

    Part {
        id: spellBookFrameDiabolicBorder
        name: "SpellBookFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "SpellBookFrameDiabolic"
        anchors.left: spellBookFrameDiabolic.left
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 32
        width: 550
        height: 516
    }

    Part {
        id: spellBookFrameDiabolicCover
        name: "SpellBookFrameDiabolicCover"
        kind: "Frame"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 23
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 55
        width: 504
        height: 470
    }

    Part {
        id: spellBookFrameDiabolicRail
        name: "SpellBookFrameDiabolicRail"
        kind: "Frame"
        wowParent: "SpellBookFrameDiabolic"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: spellBookFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Part {
        id: spellBookFrameDiabolicSocket
        name: "SpellBookFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "SpellBookFrameDiabolic"
        anchors.right: spellBookFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: spellBookFrameDiabolicTitlePlate
        name: "SpellBookFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "SpellBookFrameDiabolic"
        anchors.horizontalCenter: spellBookFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: spellBookFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: spellBookFrameTabButton1
        name: "SpellBookFrameTabButton1"
        kind: "Button"
        text: "Spellbook"
        wowParent: "SpellBookFrame"
        style: "Banner"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: spellBookFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: spellBookNextPageButton
        name: "SpellBookNextPageButton"
        kind: "Button"
        wowParent: "SpellBookFrame"
        anchors.right: spellBookFrameDiabolic.right
        anchors.rightMargin: 72
        anchors.verticalCenter: spellBookFrameDiabolic.top
        anchors.verticalCenterOffset: 483
        width: 26
        height: 26
    }

    Part {
        id: spellBookPageText
        name: "SpellBookPageText"
        kind: "FontString"
        text: "Page 1"
        wowParent: "SpellBookFrame"
        anchors.right: spellBookNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: spellBookNextPageButton.verticalCenter
        width: 39.5
        height: 11.9
    }

    Part {
        id: spellBookPrevPageButton
        name: "SpellBookPrevPageButton"
        kind: "Button"
        wowParent: "SpellBookFrame"
        anchors.right: spellBookPageText.left
        anchors.rightMargin: 4
        anchors.verticalCenter: spellBookPageText.verticalCenter
        width: 26
        height: 26
    }

    Part {
        id: spellBookSkillLineTab1
        name: "SpellBookSkillLineTab1"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 116
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab2
        name: "SpellBookSkillLineTab2"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 164
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab3
        name: "SpellBookSkillLineTab3"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 212
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab4
        name: "SpellBookSkillLineTab4"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 260
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab5
        name: "SpellBookSkillLineTab5"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 308
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab6
        name: "SpellBookSkillLineTab6"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 356
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab7
        name: "SpellBookSkillLineTab7"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 404
        width: 36
        height: 36
    }

    Part {
        id: spellBookSkillLineTab8
        name: "SpellBookSkillLineTab8"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 452
        width: 36
        height: 36
    }

    Part {
        id: spellBookTitleText
        name: "SpellBookTitleText"
        kind: "FontString"
        text: "Spellbook"
        wowParent: "SpellBookFrameDiabolicTitlePlate"
        anchors.horizontalCenter: spellBookFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: spellBookFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 88.5
        height: 14.2
    }

    Part {
        id: spellButton1
        name: "SpellButton1"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 140
        width: 37
        height: 37
    }

    Part {
        id: spellButton10
        name: "SpellButton10"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 282
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 340
        width: 37
        height: 37
    }

    Part {
        id: spellButton10SpellName
        name: "SpellButton10SpellName"
        kind: "FontString"
        text: "Psychic Scream"
        wowParent: "SpellButton10"
        anchors.left: spellButton10.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton10.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton10SubSpellName
        name: "SpellButton10SubSpellName"
        kind: "FontString"
        text: "Rank 4"
        wowParent: "SpellButton10"
        anchors.left: spellButton10SpellName.left
        anchors.top: spellButton10SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton11
        name: "SpellButton11"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 390
        width: 37
        height: 37
    }

    Part {
        id: spellButton11SpellName
        name: "SpellButton11SpellName"
        kind: "FontString"
        text: "Mind Flay"
        wowParent: "SpellButton11"
        anchors.left: spellButton11.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton11.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton11SubSpellName
        name: "SpellButton11SubSpellName"
        kind: "FontString"
        text: "Rank 9"
        wowParent: "SpellButton11"
        anchors.left: spellButton11SpellName.left
        anchors.top: spellButton11SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton12
        name: "SpellButton12"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 282
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 390
        width: 37
        height: 37
    }

    Part {
        id: spellButton12SpellName
        name: "SpellButton12SpellName"
        kind: "FontString"
        text: "Shadow Protection"
        wowParent: "SpellButton12"
        anchors.left: spellButton12.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton12.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton12SubSpellName
        name: "SpellButton12SubSpellName"
        kind: "FontString"
        text: "Rank 5"
        wowParent: "SpellButton12"
        anchors.left: spellButton12SpellName.left
        anchors.top: spellButton12SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton1SpellName
        name: "SpellButton1SpellName"
        kind: "FontString"
        text: "Devouring Plague"
        wowParent: "SpellButton1"
        anchors.left: spellButton1.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton1.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton1SubSpellName
        name: "SpellButton1SubSpellName"
        kind: "FontString"
        text: "Rank 9"
        wowParent: "SpellButton1"
        anchors.left: spellButton1SpellName.left
        anchors.top: spellButton1SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton2
        name: "SpellButton2"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 282
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 140
        width: 37
        height: 37
    }

    Part {
        id: spellButton2SpellName
        name: "SpellButton2SpellName"
        kind: "FontString"
        text: "Mind Sear"
        wowParent: "SpellButton2"
        anchors.left: spellButton2.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton2.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton2SubSpellName
        name: "SpellButton2SubSpellName"
        kind: "FontString"
        text: "Rank 2"
        wowParent: "SpellButton2"
        anchors.left: spellButton2SpellName.left
        anchors.top: spellButton2SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton3
        name: "SpellButton3"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 190
        width: 37
        height: 37
    }

    Part {
        id: spellButton3SpellName
        name: "SpellButton3SpellName"
        kind: "FontString"
        text: "Dispersion"
        wowParent: "SpellButton3"
        anchors.left: spellButton3.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton3.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton3SubSpellName
        name: "SpellButton3SubSpellName"
        kind: "FontString"
        wowParent: "SpellButton3"
        anchors.left: spellButton3SpellName.left
        anchors.top: spellButton3SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton4
        name: "SpellButton4"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 282
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 190
        width: 37
        height: 37
    }

    Part {
        id: spellButton4SpellName
        name: "SpellButton4SpellName"
        kind: "FontString"
        text: "Mind Soothe"
        wowParent: "SpellButton4"
        anchors.left: spellButton4.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton4.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton4SubSpellName
        name: "SpellButton4SubSpellName"
        kind: "FontString"
        wowParent: "SpellButton4"
        anchors.left: spellButton4SpellName.left
        anchors.top: spellButton4SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton5
        name: "SpellButton5"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 240
        width: 37
        height: 37
    }

    Part {
        id: spellButton5SpellName
        name: "SpellButton5SpellName"
        kind: "FontString"
        text: "Fade"
        wowParent: "SpellButton5"
        anchors.left: spellButton5.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton5.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton5SubSpellName
        name: "SpellButton5SubSpellName"
        kind: "FontString"
        wowParent: "SpellButton5"
        anchors.left: spellButton5SpellName.left
        anchors.top: spellButton5SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton6
        name: "SpellButton6"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 282
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 240
        width: 37
        height: 37
    }

    Part {
        id: spellButton6SpellName
        name: "SpellButton6SpellName"
        kind: "FontString"
        text: "Mind Vision"
        wowParent: "SpellButton6"
        anchors.left: spellButton6.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton6.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton6SubSpellName
        name: "SpellButton6SubSpellName"
        kind: "FontString"
        text: "Rank 2"
        wowParent: "SpellButton6"
        anchors.left: spellButton6SpellName.left
        anchors.top: spellButton6SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton7
        name: "SpellButton7"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 290
        width: 37
        height: 37
    }

    Part {
        id: spellButton7SpellName
        name: "SpellButton7SpellName"
        kind: "FontString"
        text: "Mind Blast"
        wowParent: "SpellButton7"
        anchors.left: spellButton7.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton7.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton7SubSpellName
        name: "SpellButton7SubSpellName"
        kind: "FontString"
        text: "Rank 13"
        wowParent: "SpellButton7"
        anchors.left: spellButton7SpellName.left
        anchors.top: spellButton7SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton8
        name: "SpellButton8"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 282
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 290
        width: 37
        height: 37
    }

    Part {
        id: spellButton8SpellName
        name: "SpellButton8SpellName"
        kind: "FontString"
        text: "Prayer of Shadow Protection"
        wowParent: "SpellButton8"
        anchors.left: spellButton8.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton8.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 23.7
    }

    Part {
        id: spellButton8SubSpellName
        name: "SpellButton8SubSpellName"
        kind: "FontString"
        text: "Rank 3"
        wowParent: "SpellButton8"
        anchors.left: spellButton8SpellName.left
        anchors.top: spellButton8SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

    Part {
        id: spellButton9
        name: "SpellButton9"
        kind: "CheckButton"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 340
        width: 37
        height: 37
    }

    Part {
        id: spellButton9SpellName
        name: "SpellButton9SpellName"
        kind: "FontString"
        text: "Mind Control"
        wowParent: "SpellButton9"
        anchors.left: spellButton9.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton9.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 145
        height: 11.9
    }

    Part {
        id: spellButton9SubSpellName
        name: "SpellButton9SubSpellName"
        kind: "FontString"
        wowParent: "SpellButton9"
        anchors.left: spellButton9SpellName.left
        anchors.top: spellButton9SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

}
