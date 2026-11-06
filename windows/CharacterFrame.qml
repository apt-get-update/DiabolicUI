// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: characterFrame
    name: "CharacterFrame"
    width: 384
    height: 512

    Button {
        id: characterAmmoSlot
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
        anchors.horizontalCenter: characterShoulderSlot.horizontalCenter
        anchors.top: characterShoulderSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterBackSlotPopoutButton
        name: "CharacterBackSlotPopoutButton"
        wowParent: "CharacterBackSlot"
        anchors.left: characterBackSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterBackSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterChestSlot
        name: "CharacterChestSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterBackSlot.horizontalCenter
        anchors.top: characterBackSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterChestSlotPopoutButton
        name: "CharacterChestSlotPopoutButton"
        wowParent: "CharacterChestSlot"
        anchors.left: characterChestSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterChestSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterFeetSlot
        name: "CharacterFeetSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterLegsSlot.horizontalCenter
        anchors.top: characterLegsSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterFeetSlotPopoutButton
        name: "CharacterFeetSlotPopoutButton"
        wowParent: "CharacterFeetSlot"
        anchors.left: characterFeetSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterFeetSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterFinger0Slot
        name: "CharacterFinger0Slot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterFeetSlot.horizontalCenter
        anchors.top: characterFeetSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterFinger0SlotPopoutButton
        name: "CharacterFinger0SlotPopoutButton"
        wowParent: "CharacterFinger0Slot"
        anchors.left: characterFinger0Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterFinger0Slot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterFinger1Slot
        name: "CharacterFinger1Slot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterFinger0Slot.horizontalCenter
        anchors.top: characterFinger0Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterFinger1SlotPopoutButton
        name: "CharacterFinger1SlotPopoutButton"
        wowParent: "CharacterFinger1Slot"
        anchors.left: characterFinger1Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterFinger1Slot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterFrameCloseButton
        name: "CharacterFrameCloseButton"
        wowParent: "CharacterFrame"
        style: "CloseButton"
        anchors.horizontalCenter: characterFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: characterFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: characterFrameDiabolic
        name: "CharacterFrameDiabolic"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.top: characterFrame.top
        anchors.topMargin: 4
        width: 650
        height: 478
    }

    Frame {
        id: characterFrameDiabolicBorder
        name: "CharacterFrameDiabolicBorder"
        wowParent: "CharacterFrameDiabolic"
        anchors.left: characterFrameDiabolic.left
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 32
        width: 650
        height: 446
    }

    Frame {
        id: characterFrameDiabolicRail
        name: "CharacterFrameDiabolicRail"
        wowParent: "CharacterFrameDiabolic"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Frame {
        id: characterFrameDiabolicSocket
        name: "CharacterFrameDiabolicSocket"
        wowParent: "CharacterFrameDiabolic"
        anchors.right: characterFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: characterFrameDiabolicTitlePlate
        name: "CharacterFrameDiabolicTitlePlate"
        wowParent: "CharacterFrameDiabolic"
        anchors.horizontalCenter: characterFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: characterFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: characterFrameDiabolicTitlePlateGem
        name: "CharacterFrameDiabolicTitlePlateGem"
        wowParent: "CharacterFrameDiabolicTitlePlate"
        anchors.horizontalCenter: characterFrameDiabolicTitlePlate.left
        anchors.horizontalCenterOffset: 35
        anchors.verticalCenter: characterFrameDiabolicTitlePlate.verticalCenter
        width: 40
        height: 40
    }

    Button {
        id: characterFrameTab1
        name: "CharacterFrameTab1"
        text: "Character"
        wowParent: "CharacterFrame"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: characterFrameTab3
        name: "CharacterFrameTab3"
        text: "Reputation"
        wowParent: "CharacterFrame"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: characterFrameTab4
        name: "CharacterFrameTab4"
        text: "Skills"
        wowParent: "CharacterFrame"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: characterFrameTab5
        name: "CharacterFrameTab5"
        text: "Currency"
        wowParent: "CharacterFrame"
        style: "Banner"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    FontString {
        id: characterGuildText
        name: "CharacterGuildText"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterLevelText.horizontalCenter
        anchors.top: characterLevelText.bottom
        anchors.topMargin: 1
        width: 1
        height: 1
    }

    Button {
        id: characterHandsSlot
        name: "CharacterHandsSlot"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 343
        anchors.top: paperDollFrame.top
        anchors.topMargin: 70
        width: 37
        height: 37
    }

    Button {
        id: characterHandsSlotPopoutButton
        name: "CharacterHandsSlotPopoutButton"
        wowParent: "CharacterHandsSlot"
        anchors.left: characterHandsSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterHandsSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterHeadSlot
        name: "CharacterHeadSlot"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 38
        anchors.top: paperDollFrame.top
        anchors.topMargin: 70
        width: 37
        height: 37
    }

    Button {
        id: characterHeadSlotPopoutButton
        name: "CharacterHeadSlotPopoutButton"
        wowParent: "CharacterHeadSlot"
        anchors.left: characterHeadSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterHeadSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterLegsSlot
        name: "CharacterLegsSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterWaistSlot.horizontalCenter
        anchors.top: characterWaistSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterLegsSlotPopoutButton
        name: "CharacterLegsSlotPopoutButton"
        wowParent: "CharacterLegsSlot"
        anchors.left: characterLegsSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterLegsSlot.verticalCenter
        width: 16
        height: 38
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

    Button {
        id: characterMainHandSlot
        name: "CharacterMainHandSlot"
        wowParent: "PaperDollFrame"
        anchors.right: characterSecondaryHandSlot.left
        anchors.rightMargin: 6
        anchors.top: characterSecondaryHandSlot.top
        width: 37
        height: 37
    }

    Button {
        id: characterMainHandSlotPopoutButton
        name: "CharacterMainHandSlotPopoutButton"
        wowParent: "CharacterMainHandSlot"
        anchors.horizontalCenter: characterMainHandSlot.horizontalCenter
        anchors.top: characterMainHandSlot.bottom
        anchors.topMargin: -4
        width: 38
        height: 16
    }

    PlayerModel {
        id: characterModelFrame
        name: "CharacterModelFrame"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 89
        anchors.top: paperDollFrame.top
        anchors.topMargin: 44
        width: 240
        height: 372
    }

    Button {
        id: characterModelFrameRotateLeftButton
        name: "CharacterModelFrameRotateLeftButton"
        wowParent: "CharacterModelFrame"
        anchors.left: characterModelFrame.left
        anchors.top: characterModelFrame.top
        anchors.topMargin: 26
        width: 35
        height: 35
    }

    Button {
        id: characterModelFrameRotateRightButton
        name: "CharacterModelFrameRotateRightButton"
        wowParent: "CharacterModelFrame"
        anchors.left: characterModelFrameRotateLeftButton.right
        anchors.top: characterModelFrameRotateLeftButton.top
        width: 35
        height: 35
    }

    Frame {
        id: characterNameFrame
        name: "CharacterNameFrame"
        wowParent: "CharacterFrame"
        anchors.horizontalCenter: characterFrame.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: characterFrame.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 109
        height: 12
    }

    FontString {
        id: characterNameText
        name: "CharacterNameText"
        text: "Crusader Padirac"
        wowParent: "CharacterFrameDiabolicTitlePlate"
        anchors.horizontalCenter: characterFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: characterFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 158.8
        height: 14.2
    }

    Button {
        id: characterNeckSlot
        name: "CharacterNeckSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterHeadSlot.horizontalCenter
        anchors.top: characterHeadSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterNeckSlotPopoutButton
        name: "CharacterNeckSlotPopoutButton"
        wowParent: "CharacterNeckSlot"
        anchors.left: characterNeckSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterNeckSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterRangedSlot
        name: "CharacterRangedSlot"
        wowParent: "PaperDollFrame"
        anchors.left: characterSecondaryHandSlot.right
        anchors.leftMargin: 6
        anchors.top: characterSecondaryHandSlot.top
        width: 37
        height: 37
    }

    Button {
        id: characterRangedSlotPopoutButton
        name: "CharacterRangedSlotPopoutButton"
        wowParent: "CharacterRangedSlot"
        anchors.horizontalCenter: characterRangedSlot.horizontalCenter
        anchors.top: characterRangedSlot.bottom
        anchors.topMargin: -4
        width: 38
        height: 16
    }

    Frame {
        id: characterResistanceFrame
        name: "CharacterResistanceFrame"
        wowParent: "PaperDollFrame"
        anchors.right: paperDollFrame.left
        anchors.rightMargin: -297
        anchors.top: paperDollFrame.top
        anchors.topMargin: 77
        width: 32
        height: 160
    }

    Button {
        id: characterSecondaryHandSlot
        name: "CharacterSecondaryHandSlot"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 190.5
        anchors.top: paperDollFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    Button {
        id: characterSecondaryHandSlotPopoutButton
        name: "CharacterSecondaryHandSlotPopoutButton"
        wowParent: "CharacterSecondaryHandSlot"
        anchors.horizontalCenter: characterSecondaryHandSlot.horizontalCenter
        anchors.top: characterSecondaryHandSlot.bottom
        anchors.topMargin: -4
        width: 38
        height: 16
    }

    Button {
        id: characterShirtSlot
        name: "CharacterShirtSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterChestSlot.horizontalCenter
        anchors.top: characterChestSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterShirtSlotPopoutButton
        name: "CharacterShirtSlotPopoutButton"
        wowParent: "CharacterShirtSlot"
        anchors.left: characterShirtSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterShirtSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterShoulderSlot
        name: "CharacterShoulderSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterNeckSlot.horizontalCenter
        anchors.top: characterNeckSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterShoulderSlotPopoutButton
        name: "CharacterShoulderSlotPopoutButton"
        wowParent: "CharacterShoulderSlot"
        anchors.left: characterShoulderSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterShoulderSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterTabardSlot
        name: "CharacterTabardSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterShirtSlot.horizontalCenter
        anchors.top: characterShirtSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterTabardSlotPopoutButton
        name: "CharacterTabardSlotPopoutButton"
        wowParent: "CharacterTabardSlot"
        anchors.left: characterTabardSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterTabardSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterTrinket0Slot
        name: "CharacterTrinket0Slot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterFinger1Slot.horizontalCenter
        anchors.top: characterFinger1Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterTrinket0SlotPopoutButton
        name: "CharacterTrinket0SlotPopoutButton"
        wowParent: "CharacterTrinket0Slot"
        anchors.left: characterTrinket0Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterTrinket0Slot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterTrinket1Slot
        name: "CharacterTrinket1Slot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterTrinket0Slot.horizontalCenter
        anchors.top: characterTrinket0Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterTrinket1SlotPopoutButton
        name: "CharacterTrinket1SlotPopoutButton"
        wowParent: "CharacterTrinket1Slot"
        anchors.left: characterTrinket1Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterTrinket1Slot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterWaistSlot
        name: "CharacterWaistSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterHandsSlot.horizontalCenter
        anchors.top: characterHandsSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterWaistSlotPopoutButton
        name: "CharacterWaistSlotPopoutButton"
        wowParent: "CharacterWaistSlot"
        anchors.left: characterWaistSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterWaistSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: characterWristSlot
        name: "CharacterWristSlot"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterTabardSlot.horizontalCenter
        anchors.top: characterTabardSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: characterWristSlotPopoutButton
        name: "CharacterWristSlotPopoutButton"
        wowParent: "CharacterWristSlot"
        anchors.left: characterWristSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterWristSlot.verticalCenter
        width: 16
        height: 38
    }

    Button {
        id: diabolicUICharacterSideTab1
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
        id: diabolicUICharacterSideTab3
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
        id: diabolicUICharacterStats11
        name: "DiabolicUICharacterStats11"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 268
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats11Label
        name: "DiabolicUICharacterStats11Label"
        text: "Strength:"
        wowParent: "DiabolicUICharacterStats11"
        anchors.left: diabolicUICharacterStats11.left
        anchors.verticalCenter: diabolicUICharacterStats11.verticalCenter
        width: 50.6
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats11Stat
        name: "DiabolicUICharacterStats11Stat"
        wowParent: "DiabolicUICharacterStats11"
        anchors.right: diabolicUICharacterStats11.right
        anchors.verticalCenter: diabolicUICharacterStats11.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats11StatText
        name: "DiabolicUICharacterStats11StatText"
        wowParent: "DiabolicUICharacterStats11Stat"
        anchors.right: diabolicUICharacterStats11Stat.right
        anchors.verticalCenter: diabolicUICharacterStats11Stat.verticalCenter
        width: 13.4
        height: 10.3
    }

    ScrollFrame {
        id: diabolicUICharacterTitles
        name: "DiabolicUICharacterTitles"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 428
        anchors.top: paperDollFrame.top
        anchors.topMargin: 118
        width: 138
        height: 306
    }

    Frame {
        id: diabolicUICharacterTitlesDiabolicParchment
        name: "DiabolicUICharacterTitlesDiabolicParchment"
        wowParent: "?"
        anchors.left: diabolicUICharacterTitles.left
        anchors.leftMargin: -4
        anchors.top: diabolicUICharacterTitles.top
        anchors.topMargin: -4
        width: 146
        height: 314
    }

    Slider {
        id: diabolicUICharacterTitlesScrollBar
        name: "DiabolicUICharacterTitlesScrollBar"
        wowParent: "DiabolicUICharacterTitles"
        style: "ScrollBar"
        anchors.left: diabolicUICharacterTitles.right
        anchors.leftMargin: 6
        anchors.top: diabolicUICharacterTitles.top
        anchors.topMargin: 16
        width: 16
        height: 274
    }

    Frame {
        id: diabolicUICharacterTitlesScrollBarDiabolicTrack
        name: "DiabolicUICharacterTitlesScrollBarDiabolicTrack"
        wowParent: "DiabolicUICharacterTitlesScrollBar"
        anchors.horizontalCenter: diabolicUICharacterTitlesScrollBarScrollUpButton.horizontalCenter
        anchors.top: diabolicUICharacterTitlesScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 308
    }

    Button {
        id: diabolicUICharacterTitlesScrollBarScrollDownButton
        name: "DiabolicUICharacterTitlesScrollBarScrollDownButton"
        wowParent: "DiabolicUICharacterTitlesScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: diabolicUICharacterTitlesScrollBar.horizontalCenter
        anchors.top: diabolicUICharacterTitlesScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: diabolicUICharacterTitlesScrollBarScrollUpButton
        name: "DiabolicUICharacterTitlesScrollBarScrollUpButton"
        wowParent: "DiabolicUICharacterTitlesScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: diabolicUICharacterTitlesScrollBar.horizontalCenter
        anchors.bottom: diabolicUICharacterTitlesScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: factionMouseOver
        name: "FactionMouseOver"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrameFactionLabel.left
        anchors.top: reputationFrameFactionLabel.top
        width: 44.2
        height: 11.9
    }

    Frame {
        id: gearManagerDialog
        name: "GearManagerDialog"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 428
        anchors.top: paperDollFrame.top
        anchors.topMargin: 134
        width: 160
        height: 151.5
    }

    Button {
        id: gearManagerDialogDeleteSet
        name: "GearManagerDialogDeleteSet"
        wowParent: "GearManagerDialog"
        style: "Button"
        anchors.horizontalCenter: gearManagerDialogSaveSet.horizontalCenter
        anchors.top: gearManagerDialogSaveSet.bottom
        anchors.topMargin: 6
        width: 24
        height: 24
    }

    FontString {
        id: gearManagerDialogDeleteSetText
        name: "GearManagerDialogDeleteSetText"
        wowParent: "GearManagerDialogDeleteSet"
        anchors.horizontalCenter: gearManagerDialogDeleteSet.horizontalCenter
        anchors.verticalCenter: gearManagerDialogDeleteSet.verticalCenter
        width: 1
        height: 1
    }

    Button {
        id: gearManagerDialogEquipSet
        name: "GearManagerDialogEquipSet"
        wowParent: "GearManagerDialog"
        style: "Button"
        anchors.left: gearManagerDialog.left
        anchors.leftMargin: 127.9
        anchors.top: gearManagerDialog.top
        anchors.topMargin: 4
        width: 30
        height: 30
    }

    FontString {
        id: gearManagerDialogEquipSetText
        name: "GearManagerDialogEquipSetText"
        wowParent: "GearManagerDialogEquipSet"
        anchors.horizontalCenter: gearManagerDialogEquipSet.horizontalCenter
        anchors.verticalCenter: gearManagerDialogEquipSet.verticalCenter
        width: 1
        height: 1
    }

    Frame {
        id: gearManagerDialogPopup
        name: "GearManagerDialogPopup"
        wowParent: "GearManagerDialog"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: characterFrameDiabolic.top
        width: 297
        height: 298
    }

    Button {
        id: gearManagerDialogSaveSet
        name: "GearManagerDialogSaveSet"
        wowParent: "GearManagerDialog"
        style: "Button"
        anchors.horizontalCenter: gearManagerDialogEquipSet.horizontalCenter
        anchors.top: gearManagerDialogEquipSet.bottom
        anchors.topMargin: 6
        width: 24
        height: 24
    }

    FontString {
        id: gearManagerDialogSaveSetText
        name: "GearManagerDialogSaveSetText"
        wowParent: "GearManagerDialogSaveSet"
        anchors.horizontalCenter: gearManagerDialogSaveSet.horizontalCenter
        anchors.verticalCenter: gearManagerDialogSaveSet.verticalCenter
        width: 1
        height: 1
    }

    CheckButton {
        id: gearSetButton1
        name: "GearSetButton1"
        wowParent: "GearManagerDialog"
        anchors.left: gearManagerDialog.left
        anchors.top: gearManagerDialog.top
        anchors.topMargin: 8.4
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton1Name
        name: "GearSetButton1Name"
        text: "holy"
        wowParent: "GearSetButton1"
        anchors.horizontalCenter: gearSetButton1.horizontalCenter
        anchors.bottom: gearSetButton1.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Frame {
        id: magicResFrame1
        name: "MagicResFrame1"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 443.6
        anchors.top: paperDollFrame.top
        anchors.topMargin: 181.7
        width: 26
        height: 26
    }

    Frame {
        id: magicResFrame2
        name: "MagicResFrame2"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 526.7
        anchors.top: paperDollFrame.top
        anchors.topMargin: 121.3
        width: 26
        height: 26
    }

    Frame {
        id: magicResFrame3
        name: "MagicResFrame3"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 463.3
        anchors.top: paperDollFrame.top
        anchors.topMargin: 121.3
        width: 26
        height: 26
    }

    Frame {
        id: magicResFrame4
        name: "MagicResFrame4"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 546.4
        anchors.top: paperDollFrame.top
        anchors.topMargin: 181.7
        width: 26
        height: 26
    }

    Frame {
        id: magicResFrame5
        name: "MagicResFrame5"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 495
        anchors.top: paperDollFrame.top
        anchors.topMargin: 219
        width: 26
        height: 26
    }

    FontString {
        id: magicResText1
        name: "MagicResText1"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame1.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame1.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    FontString {
        id: magicResText2
        name: "MagicResText2"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame2.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame2.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    FontString {
        id: magicResText3
        name: "MagicResText3"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame3.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame3.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    FontString {
        id: magicResText4
        name: "MagicResText4"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame4.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame4.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    FontString {
        id: magicResText5
        name: "MagicResText5"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame5.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame5.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    Frame {
        id: paperDollFrame
        name: "PaperDollFrame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.top: characterFrame.top
        width: 384
        height: 512
    }

    Button {
        id: reputationBar1
        name: "ReputationBar1"
        wowParent: "ReputationFrame"
        anchors.right: reputationFrame.right
        anchors.rightMargin: 70
        anchors.top: reputationFrame.top
        anchors.topMargin: 83
        width: 294
        height: 20
    }

    Button {
        id: reputationBar1ExpandOrCollapseButton
        name: "ReputationBar1ExpandOrCollapseButton"
        wowParent: "ReputationBar1"
        anchors.left: reputationBar1.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar1.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar1FactionName
        name: "ReputationBar1FactionName"
        text: "Classic"
        wowParent: "ReputationBar1"
        anchors.left: reputationBar1ExpandOrCollapseButton.right
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar1ExpandOrCollapseButton.verticalCenter
        width: 145
        height: 10
    }

    StatusBar {
        id: reputationBar1ReputationBar
        name: "ReputationBar1ReputationBar"
        wowParent: "ReputationBar1"
        anchors.right: reputationBar1.right
        anchors.verticalCenter: reputationBar1.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar1ReputationBarFactionStanding
        name: "ReputationBar1ReputationBarFactionStanding"
        text: "Exalted"
        wowParent: "ReputationBar1ReputationBar"
        anchors.horizontalCenter: reputationBar1ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar1ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    CheckButton {
        id: reputationDetailAtWarCheckBox
        name: "ReputationDetailAtWarCheckBox"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailFrame.left
        anchors.leftMargin: 14
        anchors.bottom: reputationDetailFrame.bottom
        anchors.bottomMargin: 34
        width: 26
        height: 26
    }

    FontString {
        id: reputationDetailAtWarCheckBoxText
        name: "ReputationDetailAtWarCheckBoxText"
        text: "At War"
        wowParent: "ReputationDetailAtWarCheckBox"
        anchors.left: reputationDetailAtWarCheckBox.right
        anchors.leftMargin: -2
        anchors.verticalCenter: reputationDetailAtWarCheckBox.verticalCenter
        width: 37.9
        height: 10.3
    }

    Button {
        id: reputationDetailCloseButton
        name: "ReputationDetailCloseButton"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailFrame.left
        anchors.leftMargin: 230
        anchors.top: reputationDetailFrame.top
        anchors.topMargin: -2.7
        width: 22
        height: 22
    }

    FontString {
        id: reputationDetailFactionDescription
        name: "ReputationDetailFactionDescription"
        text: "This small group of reclusive night elves raises and trains wintersabers in the Winterspring area."
        wowParent: "ReputationDetailFrame"
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
        anchors.horizontalCenter: reputationDetailFrame.horizontalCenter
        anchors.top: reputationDetailFrame.top
        anchors.topMargin: 2
        width: 188
        height: 12.6
    }

    Frame {
        id: reputationDetailFrame
        name: "ReputationDetailFrame"
        wowParent: "ReputationFrame"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: -8
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 96
        width: 260
        height: 203
    }

    CheckButton {
        id: reputationDetailInactiveCheckBox
        name: "ReputationDetailInactiveCheckBox"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailAtWarCheckBoxText.right
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationDetailAtWarCheckBoxText.verticalCenter
        width: 26
        height: 26
    }

    FontString {
        id: reputationDetailInactiveCheckBoxText
        name: "ReputationDetailInactiveCheckBoxText"
        text: "Move to Inactive"
        wowParent: "ReputationDetailInactiveCheckBox"
        anchors.left: reputationDetailInactiveCheckBox.right
        anchors.verticalCenter: reputationDetailInactiveCheckBox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 90.9
        height: 10.3
    }

    CheckButton {
        id: reputationDetailMainScreenCheckBox
        name: "ReputationDetailMainScreenCheckBox"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailAtWarCheckBox.left
        anchors.top: reputationDetailAtWarCheckBox.bottom
        anchors.topMargin: -3
        width: 26
        height: 26
    }

    FontString {
        id: reputationDetailMainScreenCheckBoxText
        name: "ReputationDetailMainScreenCheckBoxText"
        text: "Show as Experience Bar"
        wowParent: "ReputationDetailMainScreenCheckBox"
        anchors.left: reputationDetailMainScreenCheckBox.right
        anchors.verticalCenter: reputationDetailMainScreenCheckBox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 126.4
        height: 10.3
    }

    Frame {
        id: reputationFrame
        name: "ReputationFrame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.leftMargin: 19
        anchors.top: characterFrame.top
        anchors.topMargin: 20
        width: 384
        height: 512
    }

    FontString {
        id: reputationFrameFactionLabel
        name: "ReputationFrameFactionLabel"
        text: "Faction"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrame.left
        anchors.leftMargin: 70
        anchors.top: reputationFrame.top
        anchors.topMargin: 57
        width: 44.2
        height: 11.9
    }

    FontString {
        id: reputationFrameStandingLabel
        name: "ReputationFrameStandingLabel"
        text: "Standing"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrame.left
        anchors.leftMargin: 215
        anchors.top: reputationFrame.top
        anchors.topMargin: 59
        width: 53.7
        height: 11.9
    }

    ScrollFrame {
        id: reputationListScrollFrame
        name: "ReputationListScrollFrame"
        wowParent: "ReputationFrame"
        anchors.right: reputationFrame.right
        anchors.rightMargin: 66
        anchors.top: reputationFrame.top
        anchors.topMargin: 76
        width: 296
        height: 354
    }

    Slider {
        id: reputationListScrollFrameScrollBar
        name: "ReputationListScrollFrameScrollBar"
        wowParent: "ReputationListScrollFrame"
        style: "ScrollBar"
        anchors.left: reputationListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: reputationListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 322
    }

    Frame {
        id: reputationListScrollFrameScrollBarDiabolicTrack
        name: "ReputationListScrollFrameScrollBarDiabolicTrack"
        wowParent: "ReputationListScrollFrameScrollBar"
        anchors.horizontalCenter: reputationListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: reputationListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 356
    }

    Button {
        id: reputationListScrollFrameScrollBarScrollDownButton
        name: "ReputationListScrollFrameScrollBarScrollDownButton"
        wowParent: "ReputationListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: reputationListScrollFrameScrollBar.horizontalCenter
        anchors.top: reputationListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: reputationListScrollFrameScrollBarScrollUpButton
        name: "ReputationListScrollFrameScrollBarScrollUpButton"
        wowParent: "ReputationListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: reputationListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: reputationListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: reputationListScrollFrameScrollChildFrame
        name: "ReputationListScrollFrameScrollChildFrame"
        wowParent: "ReputationListScrollFrame"
        anchors.left: reputationListScrollFrame.left
        anchors.top: reputationListScrollFrame.top
        width: 300
        height: 1586
    }

    FontString {
        id: skillDetailDescriptionText
        name: "SkillDetailDescriptionText"
        wowParent: "SkillDetailScrollChildFrame"
        anchors.horizontalCenter: skillDetailCostText.horizontalCenter
        anchors.top: skillDetailCostText.top
        width: 275
        height: 41.1
    }

    Frame {
        id: skillDetailScrollChildFrame
        name: "SkillDetailScrollChildFrame"
        wowParent: "SkillDetailScrollFrame"
        anchors.left: skillDetailScrollFrame.left
        anchors.top: skillDetailScrollFrame.top
        width: 320
        height: 50
    }

    ScrollFrame {
        id: skillDetailScrollFrame
        name: "SkillDetailScrollFrame"
        wowParent: "SkillFrame"
        anchors.left: skillListScrollFrame.left
        anchors.top: skillListScrollFrame.bottom
        anchors.topMargin: 8
        width: 296
        height: 107
    }

    StatusBar {
        id: skillDetailStatusBar
        name: "SkillDetailStatusBar"
        wowParent: "SkillDetailScrollChildFrame"
        anchors.horizontalCenter: skillDetailScrollChildFrame.horizontalCenter
        anchors.horizontalCenterOffset: -10
        anchors.verticalCenter: skillDetailScrollChildFrame.top
        anchors.verticalCenterOffset: 20
        width: 211
        height: 15
    }

    FontString {
        id: skillDetailStatusBarSkillName
        name: "SkillDetailStatusBarSkillName"
        text: "First Aid"
        wowParent: "SkillDetailStatusBar"
        anchors.left: skillDetailStatusBar.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillDetailStatusBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 44.2
        height: 10.3
    }

    FontString {
        id: skillDetailStatusBarSkillRank
        name: "SkillDetailStatusBarSkillRank"
        text: "450/450"
        wowParent: "SkillDetailStatusBar"
        anchors.left: skillDetailStatusBarSkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillDetailStatusBarSkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Frame {
        id: skillFrame
        name: "SkillFrame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.leftMargin: 19
        anchors.top: characterFrame.top
        anchors.topMargin: 20
        width: 384
        height: 512
    }

    Button {
        id: skillFrameCollapseAllButton
        name: "SkillFrameCollapseAllButton"
        text: "All"
        wowParent: "SkillFrameExpandButtonFrame"
        anchors.left: skillFrameExpandTabLeft.right
        anchors.leftMargin: -3
        anchors.verticalCenter: skillFrameExpandTabLeft.verticalCenter
        anchors.verticalCenterOffset: 3
        width: 40
        height: 22
    }

    Frame {
        id: skillFrameExpandButtonFrame
        name: "SkillFrameExpandButtonFrame"
        wowParent: "SkillFrame"
        anchors.left: skillFrame.left
        anchors.leftMargin: 70
        anchors.top: skillFrame.top
        anchors.topMargin: 49
        width: 62.8
        height: 32
    }

    ScrollFrame {
        id: skillListScrollFrame
        name: "SkillListScrollFrame"
        wowParent: "SkillFrame"
        anchors.right: skillFrame.right
        anchors.rightMargin: 67
        anchors.top: skillFrame.top
        anchors.topMargin: 75
        width: 296
        height: 220
    }

    Slider {
        id: skillListScrollFrameScrollBar
        name: "SkillListScrollFrameScrollBar"
        wowParent: "SkillListScrollFrame"
        style: "ScrollBar"
        anchors.left: skillListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: skillListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 188
    }

    Frame {
        id: skillListScrollFrameScrollBarDiabolicTrack
        name: "SkillListScrollFrameScrollBarDiabolicTrack"
        wowParent: "SkillListScrollFrameScrollBar"
        anchors.horizontalCenter: skillListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: skillListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 222
    }

    Button {
        id: skillListScrollFrameScrollBarScrollDownButton
        name: "SkillListScrollFrameScrollBarScrollDownButton"
        wowParent: "SkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: skillListScrollFrameScrollBar.horizontalCenter
        anchors.top: skillListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: skillListScrollFrameScrollBarScrollUpButton
        name: "SkillListScrollFrameScrollBarScrollUpButton"
        wowParent: "SkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: skillListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: skillListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: skillListScrollFrameScrollChildFrame
        name: "SkillListScrollFrameScrollChildFrame"
        wowParent: "SkillListScrollFrame"
        anchors.left: skillListScrollFrame.left
        anchors.top: skillListScrollFrame.top
        width: 300
        height: 360
    }

    StatusBar {
        id: skillRankFrame2
        name: "SkillRankFrame2"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame1.left
        anchors.top: skillRankFrame1.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame2Border
        name: "SkillRankFrame2Border"
        wowParent: "SkillRankFrame2"
        anchors.left: skillRankFrame2.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame2.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame2SkillName
        name: "SkillRankFrame2SkillName"
        text: "Discipline"
        wowParent: "SkillRankFrame2"
        anchors.left: skillRankFrame2.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 52.9
        height: 10.3
    }

    FontString {
        id: skillRankFrame2SkillRank
        name: "SkillRankFrame2SkillRank"
        wowParent: "SkillRankFrame2"
        anchors.left: skillRankFrame2SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame2SkillName.verticalCenter
        width: 128
        height: 1
    }

    Button {
        id: skillTypeLabel1
        name: "SkillTypeLabel1"
        text: "Class Skills"
        wowParent: "SkillFrame"
        anchors.left: skillFrame.left
        anchors.leftMargin: 22
        anchors.verticalCenter: skillFrame.top
        anchors.verticalCenterOffset: 86
        width: 285
        height: 14
    }

    Button {
        id: skillTypeLabel5
        name: "SkillTypeLabel5"
        text: "Professions"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel4.left
        anchors.verticalCenter: skillTypeLabel4.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Button {
        id: skillTypeLabel6
        name: "SkillTypeLabel6"
        text: "Secondary Skills"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel5.left
        anchors.verticalCenter: skillTypeLabel5.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Button {
        id: skillTypeLabel8
        name: "SkillTypeLabel8"
        text: "Secondary Skills"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel7.left
        anchors.verticalCenter: skillTypeLabel7.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Button {
        id: skillTypeLabel9
        name: "SkillTypeLabel9"
        text: "Weapon Skills"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel8.left
        anchors.verticalCenter: skillTypeLabel8.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Frame {
        id: standingMouseOver
        name: "StandingMouseOver"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrameStandingLabel.left
        anchors.top: reputationFrameStandingLabel.top
        width: 53.7
        height: 11.9
    }

    Frame {
        id: tokenFrame
        name: "TokenFrame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.leftMargin: 19
        anchors.top: characterFrame.top
        anchors.topMargin: 20
        width: 384
        height: 512
    }

    ScrollFrame {
        id: tokenFrameContainer
        name: "TokenFrameContainer"
        wowParent: "TokenFrame"
        anchors.left: tokenFrame.left
        anchors.leftMargin: 26
        anchors.top: tokenFrame.top
        anchors.topMargin: 77
        width: 313
        height: 330
    }

    Button {
        id: tokenFrameContainerButton1
        name: "TokenFrameContainerButton1"
        text: "Dungeon and Raid"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerScrollChild.left
        anchors.top: tokenFrameContainerScrollChild.top
        anchors.topMargin: 2
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton1Count
        name: "TokenFrameContainerButton1Count"
        wowParent: "TokenFrameContainerButton1"
        anchors.right: tokenFrameContainerButton1Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton1Icon.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tokenFrameContainerButton1Name
        name: "TokenFrameContainerButton1Name"
        wowParent: "TokenFrameContainerButton1"
        anchors.left: tokenFrameContainerButton1.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton1.verticalCenter
        width: 210
        height: 11
    }

    Frame {
        id: tokenFrameContainerScrollChild
        name: "TokenFrameContainerScrollChild"
        wowParent: "TokenFrameContainer"
        anchors.left: tokenFrameContainer.left
        anchors.top: tokenFrameContainer.top
        width: 299
        height: 420
    }

    Frame {
        id: tokenFrameMoneyFrame
        name: "TokenFrameMoneyFrame"
        wowParent: "TokenFrame"
        pin: "place"
        anchors.right: tokenFrame.right
        anchors.rightMargin: 44
        anchors.bottom: tokenFrame.bottom
        anchors.bottomMargin: 84
        width: 126.4
        height: 13
    }

    Button {
        id: tokenFrameMoneyFrameCopperButton
        name: "TokenFrameMoneyFrameCopperButton"
        text: "13"
        wowParent: "TokenFrameMoneyFrame"
        anchors.right: tokenFrameMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: tokenFrameMoneyFrameCopperButtonText
        name: "TokenFrameMoneyFrameCopperButtonText"
        text: "13"
        wowParent: "TokenFrameMoneyFrameCopperButton"
        anchors.right: tokenFrameMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: tokenFrameMoneyFrameGoldButton
        name: "TokenFrameMoneyFrameGoldButton"
        text: "3654"
        wowParent: "TokenFrameMoneyFrame"
        anchors.right: tokenFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: tokenFrameMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    FontString {
        id: tokenFrameMoneyFrameGoldButtonText
        name: "TokenFrameMoneyFrameGoldButtonText"
        text: "3654"
        wowParent: "TokenFrameMoneyFrameGoldButton"
        anchors.right: tokenFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Button {
        id: tokenFrameMoneyFrameSilverButton
        name: "TokenFrameMoneyFrameSilverButton"
        text: "16"
        wowParent: "TokenFrameMoneyFrame"
        anchors.right: tokenFrameMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: tokenFrameMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: tokenFrameMoneyFrameSilverButtonText
        name: "TokenFrameMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "TokenFrameMoneyFrameSilverButton"
        anchors.right: tokenFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Frame {
        id: tokenFramePopup
        name: "TokenFramePopup"
        wowParent: "TokenFrame"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: -8
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 96
        width: 205
        height: 100
    }

    CheckButton {
        id: tokenFramePopupBackpackCheckBox
        name: "TokenFramePopupBackpackCheckBox"
        wowParent: "TokenFramePopup"
        style: "CheckBox"
        pin: "place"
        anchors.left: tokenFramePopupInactiveCheckBox.left
        anchors.top: tokenFramePopupInactiveCheckBox.bottom
        anchors.topMargin: 6
        width: 20
        height: 20
    }

    FontString {
        id: tokenFramePopupBackpackCheckBoxText
        name: "TokenFramePopupBackpackCheckBoxText"
        text: "Show on Backpack"
        wowParent: "TokenFramePopupBackpackCheckBox"
        anchors.left: tokenFramePopupBackpackCheckBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: tokenFramePopupBackpackCheckBox.verticalCenter
        width: 109
        height: 14.2
    }

    Button {
        id: tokenFramePopupCloseButton
        name: "TokenFramePopupCloseButton"
        wowParent: "TokenFramePopup"
        pin: "place"
        anchors.right: tokenFramePopup.right
        anchors.rightMargin: 1
        anchors.top: tokenFramePopup.top
        anchors.topMargin: 1
        width: 22
        height: 22
    }

    CheckButton {
        id: tokenFramePopupInactiveCheckBox
        name: "TokenFramePopupInactiveCheckBox"
        wowParent: "TokenFramePopup"
        style: "CheckBox"
        anchors.left: tokenFramePopup.left
        anchors.leftMargin: 32
        anchors.top: tokenFramePopup.top
        anchors.topMargin: 32
        width: 20
        height: 20
    }

    FontString {
        id: tokenFramePopupInactiveCheckBoxText
        name: "TokenFramePopupInactiveCheckBoxText"
        text: "Unused"
        wowParent: "TokenFramePopupInactiveCheckBox"
        anchors.left: tokenFramePopupInactiveCheckBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: tokenFramePopupInactiveCheckBox.verticalCenter
        width: 44.2
        height: 14.2
    }

    FontString {
        id: tokenFramePopupTitle
        name: "TokenFramePopupTitle"
        text: "Currency Options"
        wowParent: "TokenFramePopup"
        anchors.left: tokenFramePopup.left
        anchors.leftMargin: 25
        anchors.top: tokenFramePopup.top
        anchors.topMargin: 17
        width: 104.3
        height: 11.9
    }

    Ghost { id: skillDetailCostText; name: "SkillDetailCostText"; x: 190; y: 362.5; width: 0; height: 0 }
    Ghost { id: skillFrameExpandTabLeft; name: "SkillFrameExpandTabLeft"; x: 97; y: 79; width: 0; height: 0 }
    Ghost { id: skillRankFrame1; name: "SkillRankFrame1"; x: 57; y: 114; width: 0; height: 0 }
    Ghost { id: skillTypeLabel4; name: "SkillTypeLabel4"; x: 41; y: 160; width: 0; height: 0 }
    Ghost { id: skillTypeLabel7; name: "SkillTypeLabel7"; x: 41; y: 214; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton1Icon; name: "TokenFrameContainerButton1Icon"; x: 323; y: 107.5; width: 0; height: 0 }
}
