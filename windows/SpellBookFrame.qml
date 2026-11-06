// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: spellBookFrame
    name: "SpellBookFrame"
    width: 384
    height: 512

    CheckButton {
        id: companionButton1
        name: "CompanionButton1"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 189
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton10
        name: "CompanionButton10"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 333
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton11
        name: "CompanionButton11"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 333
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton12
        name: "CompanionButton12"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 333
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton2
        name: "CompanionButton2"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 189
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton3
        name: "CompanionButton3"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 189
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton4
        name: "CompanionButton4"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 237
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton5
        name: "CompanionButton5"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 237
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton6
        name: "CompanionButton6"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 237
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton7
        name: "CompanionButton7"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 16
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 285
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton8
        name: "CompanionButton8"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 178
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 285
        width: 37
        height: 37
    }

    CheckButton {
        id: companionButton9
        name: "CompanionButton9"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 340
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 285
        width: 37
        height: 37
    }

    DressUpModel {
        id: companionModelFrame
        name: "CompanionModelFrame"
        wowParent: "PetPaperDollFrameCompanionFrame"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 11
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 19
        width: 482
        height: 146
    }

    Button {
        id: companionModelFrameRotateLeftButton
        name: "CompanionModelFrameRotateLeftButton"
        wowParent: "CompanionModelFrame"
        anchors.left: companionModelFrame.left
        anchors.leftMargin: 6
        anchors.bottom: companionModelFrame.bottom
        anchors.bottomMargin: 6
        width: 35
        height: 35
    }

    Button {
        id: companionModelFrameRotateRightButton
        name: "CompanionModelFrameRotateRightButton"
        wowParent: "CompanionModelFrame"
        anchors.right: companionModelFrame.right
        anchors.rightMargin: 6
        anchors.bottom: companionModelFrame.bottom
        anchors.bottomMargin: 6
        width: 35
        height: 35
    }

    Button {
        id: companionNextPageButton
        name: "CompanionNextPageButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.right: petPaperDollFrameCompanionFrame.right
        anchors.rightMargin: 12
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: 387
        width: 26
        height: 26
    }

    FontString {
        id: companionPageNumber
        name: "CompanionPageNumber"
        text: "Page 1 of 1"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.right: companionNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: companionNextPageButton.verticalCenter
        width: 60
        height: 10.3
    }

    Button {
        id: companionPrevPageButton
        name: "CompanionPrevPageButton"
        wowParent: "PetPaperDollFrameCompanionFrame"
        pin: "place"
        anchors.right: companionPageNumber.left
        anchors.rightMargin: 4
        anchors.verticalCenter: companionPageNumber.verticalCenter
        width: 26
        height: 26
    }

    FontString {
        id: companionSelectedName
        name: "CompanionSelectedName"
        text: "Bronze Drake Mount"
        wowParent: "PetPaperDollFrameCompanionFrame"
        anchors.left: petPaperDollFrameCompanionFrame.left
        anchors.leftMargin: 107
        anchors.top: petPaperDollFrameCompanionFrame.top
        anchors.topMargin: -4
        width: 290
        height: 13
    }

    Button {
        id: companionSummonButton
        name: "CompanionSummonButton"
        text: "Mount"
        wowParent: "PetPaperDollFrameCompanionFrame"
        style: "Button"
        anchors.horizontalCenter: companionModelFrame.horizontalCenter
        anchors.bottom: companionModelFrame.bottom
        anchors.bottomMargin: 11.5
        width: 140
        height: 24
    }

    FontString {
        id: companionSummonButtonText
        name: "CompanionSummonButtonText"
        text: "Mount"
        wowParent: "CompanionSummonButton"
        anchors.horizontalCenter: companionSummonButton.horizontalCenter
        anchors.verticalCenter: companionSummonButton.verticalCenter
        width: 49.8
        height: 11.9
    }

    EditBox {
        id: diabolicUISpellBookSearchBox
        name: "DiabolicUISpellBookSearchBox"
        wowParent: "SpellBookFrame"
        style: "EditBox"
        anchors.left: spellBookFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: spellBookFrameDiabolicBand.verticalCenter
        width: 160
        height: 20
    }

    Frame {
        id: diabolicUISpellBookSearchBoxDiabolicField
        name: "DiabolicUISpellBookSearchBoxDiabolicField"
        wowParent: "DiabolicUISpellBookSearchBox"
        anchors.left: diabolicUISpellBookSearchBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: diabolicUISpellBookSearchBox.verticalCenter
        width: 176
        height: 22
    }

    Button {
        id: diabolicUISpellBookTabCRITTER
        name: "DiabolicUISpellBookTabCRITTER"
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

    Button {
        id: diabolicUISpellBookTabMOUNT
        name: "DiabolicUISpellBookTabMOUNT"
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

    Button {
        id: diabolicUISpellBookTabPROFESSIONS
        name: "DiabolicUISpellBookTabPROFESSIONS"
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

    CheckButton {
        id: diabolicUISpellBookUnassignedBox
        name: "DiabolicUISpellBookUnassignedBox"
        wowParent: "SpellBookFrame"
        style: "CheckBox"
        anchors.left: showAllSpellRanksCheckBox.right
        anchors.leftMargin: 65.8
        anchors.verticalCenter: showAllSpellRanksCheckBox.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: diabolicUISpellBookUnassignedBoxText
        name: "DiabolicUISpellBookUnassignedBoxText"
        text: "Unassigned"
        wowParent: "DiabolicUISpellBookUnassignedBox"
        anchors.left: diabolicUISpellBookUnassignedBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: diabolicUISpellBookUnassignedBox.verticalCenter
        width: 68
        height: 14.2
    }

    Frame {
        id: petPaperDollFrameCompanionFrame
        name: "PetPaperDollFrameCompanionFrame"
        wowParent: "SpellBookFrameDiabolicCover"
        anchors.left: spellBookFrameDiabolicCover.left
        anchors.top: spellBookFrameDiabolicCover.top
        anchors.topMargin: 18
        width: 504
        height: 452
    }

    CheckButton {
        id: showAllSpellRanksCheckBox
        name: "ShowAllSpellRanksCheckBox"
        wowParent: "SpellBookFrame"
        style: "CheckBox"
        anchors.left: diabolicUISpellBookSearchBox.right
        anchors.leftMargin: 20
        anchors.verticalCenter: diabolicUISpellBookSearchBox.verticalCenter
        width: 20
        height: 20
    }

    FontString {
        id: showAllSpellRanksCheckBoxText
        name: "ShowAllSpellRanksCheckBoxText"
        text: "All ranks"
        wowParent: "ShowAllSpellRanksCheckBox"
        anchors.left: showAllSpellRanksCheckBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: showAllSpellRanksCheckBox.verticalCenter
        width: 49.8
        height: 14.2
    }

    Button {
        id: spellBookCloseButton
        name: "SpellBookCloseButton"
        wowParent: "SpellBookFrame"
        style: "CloseButton"
        anchors.horizontalCenter: spellBookFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: spellBookFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: spellBookFrameDiabolic
        name: "SpellBookFrameDiabolic"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrame.left
        anchors.top: spellBookFrame.top
        anchors.topMargin: -36
        width: 550
        height: 548
    }

    Frame {
        id: spellBookFrameDiabolicBand
        name: "SpellBookFrameDiabolicBand"
        wowParent: "SpellBookFrameDiabolic"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 56
        width: 502
        height: 40
    }

    Frame {
        id: spellBookFrameDiabolicBorder
        name: "SpellBookFrameDiabolicBorder"
        wowParent: "SpellBookFrameDiabolic"
        anchors.left: spellBookFrameDiabolic.left
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 32
        width: 550
        height: 516
    }

    Frame {
        id: spellBookFrameDiabolicCover
        name: "SpellBookFrameDiabolicCover"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 23
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 55
        width: 504
        height: 470
    }

    Frame {
        id: spellBookFrameDiabolicRail
        name: "SpellBookFrameDiabolicRail"
        wowParent: "SpellBookFrameDiabolic"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: spellBookFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Frame {
        id: spellBookFrameDiabolicSocket
        name: "SpellBookFrameDiabolicSocket"
        wowParent: "SpellBookFrameDiabolic"
        anchors.right: spellBookFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: spellBookFrameDiabolicTitlePlate
        name: "SpellBookFrameDiabolicTitlePlate"
        wowParent: "SpellBookFrameDiabolic"
        anchors.horizontalCenter: spellBookFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: spellBookFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: spellBookFrameTabButton1
        name: "SpellBookFrameTabButton1"
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

    Button {
        id: spellBookNextPageButton
        name: "SpellBookNextPageButton"
        wowParent: "SpellBookFrame"
        anchors.right: spellBookFrameDiabolic.right
        anchors.rightMargin: 72
        anchors.verticalCenter: spellBookFrameDiabolic.top
        anchors.verticalCenterOffset: 483
        width: 26
        height: 26
    }

    FontString {
        id: spellBookPageText
        name: "SpellBookPageText"
        text: "Page 1"
        wowParent: "SpellBookFrame"
        anchors.right: spellBookNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: spellBookNextPageButton.verticalCenter
        width: 39.5
        height: 11.9
    }

    Button {
        id: spellBookPrevPageButton
        name: "SpellBookPrevPageButton"
        wowParent: "SpellBookFrame"
        anchors.right: spellBookPageText.left
        anchors.rightMargin: 4
        anchors.verticalCenter: spellBookPageText.verticalCenter
        width: 26
        height: 26
    }

    CheckButton {
        id: spellBookSkillLineTab1
        name: "SpellBookSkillLineTab1"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 116
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab2
        name: "SpellBookSkillLineTab2"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 164
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab3
        name: "SpellBookSkillLineTab3"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 212
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab4
        name: "SpellBookSkillLineTab4"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 260
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab5
        name: "SpellBookSkillLineTab5"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 308
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab6
        name: "SpellBookSkillLineTab6"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 356
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab7
        name: "SpellBookSkillLineTab7"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 404
        width: 36
        height: 36
    }

    CheckButton {
        id: spellBookSkillLineTab8
        name: "SpellBookSkillLineTab8"
        wowParent: "SpellBookFrame"
        pin: "place"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 486
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 452
        width: 36
        height: 36
    }

    FontString {
        id: spellBookTitleText
        name: "SpellBookTitleText"
        text: "Spellbook"
        wowParent: "SpellBookFrameDiabolicTitlePlate"
        anchors.horizontalCenter: spellBookFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: spellBookFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 88.5
        height: 14.2
    }

    CheckButton {
        id: spellButton1
        name: "SpellButton1"
        wowParent: "SpellBookFrame"
        anchors.left: spellBookFrameDiabolic.left
        anchors.leftMargin: 50
        anchors.top: spellBookFrameDiabolic.top
        anchors.topMargin: 140
        width: 37
        height: 37
    }

    FontString {
        id: spellButton1SpellName
        name: "SpellButton1SpellName"
        text: "Devouring Plague"
        wowParent: "SpellButton1"
        anchors.left: spellButton1.right
        anchors.leftMargin: 12
        anchors.verticalCenter: spellButton1.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 145
        height: 11.9
    }

    FontString {
        id: spellButton1SubSpellName
        name: "SpellButton1SubSpellName"
        text: "Rank 9"
        wowParent: "SpellButton1"
        anchors.left: spellButton1SpellName.left
        anchors.top: spellButton1SpellName.bottom
        anchors.topMargin: -4
        width: 145
        height: 18
    }

}
