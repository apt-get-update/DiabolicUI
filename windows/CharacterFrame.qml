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

    Frame {
        id: diabolicUICharacterStats12
        name: "DiabolicUICharacterStats12"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 280
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats12Label
        name: "DiabolicUICharacterStats12Label"
        text: "Agility:"
        wowParent: "DiabolicUICharacterStats12"
        anchors.left: diabolicUICharacterStats12.left
        anchors.verticalCenter: diabolicUICharacterStats12.verticalCenter
        width: 37.1
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats12Stat
        name: "DiabolicUICharacterStats12Stat"
        wowParent: "DiabolicUICharacterStats12"
        anchors.right: diabolicUICharacterStats12.right
        anchors.verticalCenter: diabolicUICharacterStats12.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats12StatText
        name: "DiabolicUICharacterStats12StatText"
        wowParent: "DiabolicUICharacterStats12Stat"
        anchors.right: diabolicUICharacterStats12Stat.right
        anchors.verticalCenter: diabolicUICharacterStats12Stat.verticalCenter
        width: 14.2
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats13
        name: "DiabolicUICharacterStats13"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 292
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats13Label
        name: "DiabolicUICharacterStats13Label"
        text: "Stamina:"
        wowParent: "DiabolicUICharacterStats13"
        anchors.left: diabolicUICharacterStats13.left
        anchors.verticalCenter: diabolicUICharacterStats13.verticalCenter
        width: 47.4
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats13Stat
        name: "DiabolicUICharacterStats13Stat"
        wowParent: "DiabolicUICharacterStats13"
        anchors.right: diabolicUICharacterStats13.right
        anchors.verticalCenter: diabolicUICharacterStats13.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats13StatText
        name: "DiabolicUICharacterStats13StatText"
        wowParent: "DiabolicUICharacterStats13Stat"
        anchors.right: diabolicUICharacterStats13Stat.right
        anchors.verticalCenter: diabolicUICharacterStats13Stat.verticalCenter
        width: 20.5
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats14
        name: "DiabolicUICharacterStats14"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 304
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats14Label
        name: "DiabolicUICharacterStats14Label"
        text: "Intellect:"
        wowParent: "DiabolicUICharacterStats14"
        anchors.left: diabolicUICharacterStats14.left
        anchors.verticalCenter: diabolicUICharacterStats14.verticalCenter
        width: 47.4
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats14Stat
        name: "DiabolicUICharacterStats14Stat"
        wowParent: "DiabolicUICharacterStats14"
        anchors.right: diabolicUICharacterStats14.right
        anchors.verticalCenter: diabolicUICharacterStats14.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats14StatText
        name: "DiabolicUICharacterStats14StatText"
        wowParent: "DiabolicUICharacterStats14Stat"
        anchors.right: diabolicUICharacterStats14Stat.right
        anchors.verticalCenter: diabolicUICharacterStats14Stat.verticalCenter
        width: 20.5
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats15
        name: "DiabolicUICharacterStats15"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 316
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats15Label
        name: "DiabolicUICharacterStats15Label"
        text: "Spirit:"
        wowParent: "DiabolicUICharacterStats15"
        anchors.left: diabolicUICharacterStats15.left
        anchors.verticalCenter: diabolicUICharacterStats15.verticalCenter
        width: 32.4
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats15Stat
        name: "DiabolicUICharacterStats15Stat"
        wowParent: "DiabolicUICharacterStats15"
        anchors.right: diabolicUICharacterStats15.right
        anchors.verticalCenter: diabolicUICharacterStats15.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats15StatText
        name: "DiabolicUICharacterStats15StatText"
        wowParent: "DiabolicUICharacterStats15Stat"
        anchors.right: diabolicUICharacterStats15Stat.right
        anchors.verticalCenter: diabolicUICharacterStats15Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats16
        name: "DiabolicUICharacterStats16"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 328
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats16Label
        name: "DiabolicUICharacterStats16Label"
        text: "Armor:"
        wowParent: "DiabolicUICharacterStats16"
        anchors.left: diabolicUICharacterStats16.left
        anchors.verticalCenter: diabolicUICharacterStats16.verticalCenter
        width: 37.1
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats16Stat
        name: "DiabolicUICharacterStats16Stat"
        wowParent: "DiabolicUICharacterStats16"
        anchors.right: diabolicUICharacterStats16.right
        anchors.verticalCenter: diabolicUICharacterStats16.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats16StatText
        name: "DiabolicUICharacterStats16StatText"
        text: "2027"
        wowParent: "DiabolicUICharacterStats16Stat"
        anchors.right: diabolicUICharacterStats16Stat.right
        anchors.verticalCenter: diabolicUICharacterStats16Stat.verticalCenter
        width: 26.9
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats21
        name: "DiabolicUICharacterStats21"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 368
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats21Label
        name: "DiabolicUICharacterStats21Label"
        text: "Bonus Damage:"
        wowParent: "DiabolicUICharacterStats21"
        anchors.left: diabolicUICharacterStats21.left
        anchors.verticalCenter: diabolicUICharacterStats21.verticalCenter
        width: 84.5
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats21Stat
        name: "DiabolicUICharacterStats21Stat"
        wowParent: "DiabolicUICharacterStats21"
        anchors.right: diabolicUICharacterStats21.right
        anchors.verticalCenter: diabolicUICharacterStats21.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats21StatText
        name: "DiabolicUICharacterStats21StatText"
        text: "1780"
        wowParent: "DiabolicUICharacterStats21Stat"
        anchors.right: diabolicUICharacterStats21Stat.right
        anchors.verticalCenter: diabolicUICharacterStats21Stat.verticalCenter
        width: 26.1
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats22
        name: "DiabolicUICharacterStats22"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 380
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats22Label
        name: "DiabolicUICharacterStats22Label"
        text: "Bonus Healing:"
        wowParent: "DiabolicUICharacterStats22"
        anchors.left: diabolicUICharacterStats22.left
        anchors.verticalCenter: diabolicUICharacterStats22.verticalCenter
        width: 81.4
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats22Stat
        name: "DiabolicUICharacterStats22Stat"
        wowParent: "DiabolicUICharacterStats22"
        anchors.right: diabolicUICharacterStats22.right
        anchors.verticalCenter: diabolicUICharacterStats22.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats22StatText
        name: "DiabolicUICharacterStats22StatText"
        text: "1780"
        wowParent: "DiabolicUICharacterStats22Stat"
        anchors.right: diabolicUICharacterStats22Stat.right
        anchors.verticalCenter: diabolicUICharacterStats22Stat.verticalCenter
        width: 26.1
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats23
        name: "DiabolicUICharacterStats23"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 392
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats23Label
        name: "DiabolicUICharacterStats23Label"
        text: "Hit Rating:"
        wowParent: "DiabolicUICharacterStats23"
        anchors.left: diabolicUICharacterStats23.left
        anchors.verticalCenter: diabolicUICharacterStats23.verticalCenter
        width: 56.9
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats23Stat
        name: "DiabolicUICharacterStats23Stat"
        wowParent: "DiabolicUICharacterStats23"
        anchors.right: diabolicUICharacterStats23.right
        anchors.verticalCenter: diabolicUICharacterStats23.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats23StatText
        name: "DiabolicUICharacterStats23StatText"
        text: "263"
        wowParent: "DiabolicUICharacterStats23Stat"
        anchors.right: diabolicUICharacterStats23Stat.right
        anchors.verticalCenter: diabolicUICharacterStats23Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats24
        name: "DiabolicUICharacterStats24"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 404
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats24Label
        name: "DiabolicUICharacterStats24Label"
        text: "Crit Chance:"
        wowParent: "DiabolicUICharacterStats24"
        anchors.left: diabolicUICharacterStats24.left
        anchors.verticalCenter: diabolicUICharacterStats24.verticalCenter
        width: 65.6
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats24Stat
        name: "DiabolicUICharacterStats24Stat"
        wowParent: "DiabolicUICharacterStats24"
        anchors.right: diabolicUICharacterStats24.right
        anchors.verticalCenter: diabolicUICharacterStats24.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats24StatText
        name: "DiabolicUICharacterStats24StatText"
        text: "14.24%"
        wowParent: "DiabolicUICharacterStats24Stat"
        anchors.right: diabolicUICharacterStats24Stat.right
        anchors.verticalCenter: diabolicUICharacterStats24Stat.verticalCenter
        width: 39.5
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats25
        name: "DiabolicUICharacterStats25"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 416
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats25Label
        name: "DiabolicUICharacterStats25Label"
        text: "Haste Rating:"
        wowParent: "DiabolicUICharacterStats25"
        anchors.left: diabolicUICharacterStats25.left
        anchors.verticalCenter: diabolicUICharacterStats25.verticalCenter
        width: 71.9
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats25Stat
        name: "DiabolicUICharacterStats25Stat"
        wowParent: "DiabolicUICharacterStats25"
        anchors.right: diabolicUICharacterStats25.right
        anchors.verticalCenter: diabolicUICharacterStats25.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats25StatText
        name: "DiabolicUICharacterStats25StatText"
        text: "413"
        wowParent: "DiabolicUICharacterStats25Stat"
        anchors.right: diabolicUICharacterStats25Stat.right
        anchors.verticalCenter: diabolicUICharacterStats25Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats26
        name: "DiabolicUICharacterStats26"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 428
        width: 144
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats26Label
        name: "DiabolicUICharacterStats26Label"
        text: "Mana Regen:"
        wowParent: "DiabolicUICharacterStats26"
        anchors.left: diabolicUICharacterStats26.left
        anchors.verticalCenter: diabolicUICharacterStats26.verticalCenter
        width: 70.3
        height: 10.3
    }

    Frame {
        id: diabolicUICharacterStats26Stat
        name: "DiabolicUICharacterStats26Stat"
        wowParent: "DiabolicUICharacterStats26"
        anchors.right: diabolicUICharacterStats26.right
        anchors.verticalCenter: diabolicUICharacterStats26.verticalCenter
        width: 30
        height: 13
    }

    FontString {
        id: diabolicUICharacterStats26StatText
        name: "DiabolicUICharacterStats26StatText"
        text: "345"
        wowParent: "DiabolicUICharacterStats26Stat"
        anchors.right: diabolicUICharacterStats26Stat.right
        anchors.verticalCenter: diabolicUICharacterStats26Stat.verticalCenter
        width: 19.8
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

    CheckButton {
        id: gearSetButton10
        name: "GearSetButton10"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton9.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton9.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton10Name
        name: "GearSetButton10Name"
        wowParent: "GearSetButton10"
        anchors.horizontalCenter: gearSetButton10.horizontalCenter
        anchors.bottom: gearSetButton10.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
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

    CheckButton {
        id: gearSetButton2
        name: "GearSetButton2"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton1.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton1.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton2Name
        name: "GearSetButton2Name"
        text: "shadow"
        wowParent: "GearSetButton2"
        anchors.horizontalCenter: gearSetButton2.horizontalCenter
        anchors.bottom: gearSetButton2.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton3
        name: "GearSetButton3"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton2.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton2.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton3Name
        name: "GearSetButton3Name"
        wowParent: "GearSetButton3"
        anchors.horizontalCenter: gearSetButton3.horizontalCenter
        anchors.bottom: gearSetButton3.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton4
        name: "GearSetButton4"
        wowParent: "GearManagerDialog"
        anchors.horizontalCenter: gearSetButton1.horizontalCenter
        anchors.top: gearSetButton1.bottom
        anchors.topMargin: 14
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton4Name
        name: "GearSetButton4Name"
        wowParent: "GearSetButton4"
        anchors.horizontalCenter: gearSetButton4.horizontalCenter
        anchors.bottom: gearSetButton4.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton5
        name: "GearSetButton5"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton4.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton4.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton5Name
        name: "GearSetButton5Name"
        wowParent: "GearSetButton5"
        anchors.horizontalCenter: gearSetButton5.horizontalCenter
        anchors.bottom: gearSetButton5.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton6
        name: "GearSetButton6"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton5.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton5.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton6Name
        name: "GearSetButton6Name"
        wowParent: "GearSetButton6"
        anchors.horizontalCenter: gearSetButton6.horizontalCenter
        anchors.bottom: gearSetButton6.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton7
        name: "GearSetButton7"
        wowParent: "GearManagerDialog"
        anchors.horizontalCenter: gearSetButton4.horizontalCenter
        anchors.top: gearSetButton4.bottom
        anchors.topMargin: 14
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton7Name
        name: "GearSetButton7Name"
        wowParent: "GearSetButton7"
        anchors.horizontalCenter: gearSetButton7.horizontalCenter
        anchors.bottom: gearSetButton7.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton8
        name: "GearSetButton8"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton7.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton7.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton8Name
        name: "GearSetButton8Name"
        wowParent: "GearSetButton8"
        anchors.horizontalCenter: gearSetButton8.horizontalCenter
        anchors.bottom: gearSetButton8.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    CheckButton {
        id: gearSetButton9
        name: "GearSetButton9"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton8.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton8.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: gearSetButton9Name
        name: "GearSetButton9Name"
        wowParent: "GearSetButton9"
        anchors.horizontalCenter: gearSetButton9.horizontalCenter
        anchors.bottom: gearSetButton9.bottom
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
        id: reputationBar10
        name: "ReputationBar10"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar9.right
        anchors.top: reputationBar9.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Button {
        id: reputationBar10ExpandOrCollapseButton
        name: "ReputationBar10ExpandOrCollapseButton"
        wowParent: "ReputationBar10"
        anchors.left: reputationBar10.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar10.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar10FactionName
        name: "ReputationBar10FactionName"
        text: "Zandalar Tribe"
        wowParent: "ReputationBar10"
        anchors.left: reputationBar10.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar10.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar10ReputationBar
        name: "ReputationBar10ReputationBar"
        wowParent: "ReputationBar10"
        anchors.right: reputationBar10.right
        anchors.verticalCenter: reputationBar10.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar10ReputationBarFactionStanding
        name: "ReputationBar10ReputationBarFactionStanding"
        text: "Neutral"
        wowParent: "ReputationBar10ReputationBar"
        anchors.horizontalCenter: reputationBar10ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar10ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Button {
        id: reputationBar11
        name: "ReputationBar11"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar10.right
        anchors.top: reputationBar10.bottom
        anchors.topMargin: 3
        width: 275
        height: 20
    }

    Button {
        id: reputationBar11ExpandOrCollapseButton
        name: "ReputationBar11ExpandOrCollapseButton"
        wowParent: "ReputationBar11"
        anchors.left: reputationBar11.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar11.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar11FactionName
        name: "ReputationBar11FactionName"
        text: "Alliance"
        wowParent: "ReputationBar11"
        anchors.left: reputationBar11ExpandOrCollapseButton.right
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar11ExpandOrCollapseButton.verticalCenter
        width: 135
        height: 10
    }

    StatusBar {
        id: reputationBar11ReputationBar
        name: "ReputationBar11ReputationBar"
        wowParent: "ReputationBar11"
        anchors.right: reputationBar11.right
        anchors.verticalCenter: reputationBar11.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar11ReputationBarFactionStanding
        name: "ReputationBar11ReputationBarFactionStanding"
        text: "Hated"
        wowParent: "ReputationBar11ReputationBar"
        anchors.horizontalCenter: reputationBar11ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar11ReputationBar.verticalCenter
        width: 33.2
        height: 10.3
    }

    Button {
        id: reputationBar12
        name: "ReputationBar12"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar11.right
        anchors.top: reputationBar11.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Button {
        id: reputationBar12ExpandOrCollapseButton
        name: "ReputationBar12ExpandOrCollapseButton"
        wowParent: "ReputationBar12"
        anchors.left: reputationBar12.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar12.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar12FactionName
        name: "ReputationBar12FactionName"
        text: "Darnassus"
        wowParent: "ReputationBar12"
        anchors.left: reputationBar12.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar12.verticalCenter
        width: 150
        height: 10
    }

    StatusBar {
        id: reputationBar12ReputationBar
        name: "ReputationBar12ReputationBar"
        wowParent: "ReputationBar12"
        anchors.right: reputationBar12.right
        anchors.verticalCenter: reputationBar12.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar12ReputationBarFactionStanding
        name: "ReputationBar12ReputationBarFactionStanding"
        text: "Exalted"
        wowParent: "ReputationBar12ReputationBar"
        anchors.horizontalCenter: reputationBar12ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar12ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Button {
        id: reputationBar13
        name: "ReputationBar13"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar12.right
        anchors.top: reputationBar12.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Button {
        id: reputationBar13ExpandOrCollapseButton
        name: "ReputationBar13ExpandOrCollapseButton"
        wowParent: "ReputationBar13"
        anchors.left: reputationBar13.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar13.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar13FactionName
        name: "ReputationBar13FactionName"
        text: "Exodar"
        wowParent: "ReputationBar13"
        anchors.left: reputationBar13.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar13.verticalCenter
        width: 150
        height: 10
    }

    StatusBar {
        id: reputationBar13ReputationBar
        name: "ReputationBar13ReputationBar"
        wowParent: "ReputationBar13"
        anchors.right: reputationBar13.right
        anchors.verticalCenter: reputationBar13.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar13ReputationBarFactionStanding
        name: "ReputationBar13ReputationBarFactionStanding"
        text: "Exalted"
        wowParent: "ReputationBar13ReputationBar"
        anchors.horizontalCenter: reputationBar13ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar13ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Button {
        id: reputationBar14
        name: "ReputationBar14"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar13.right
        anchors.top: reputationBar13.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    FontString {
        id: reputationBar14FactionName
        name: "ReputationBar14FactionName"
        text: "Gnomeregan Exiles"
        wowParent: "ReputationBar14"
        anchors.left: reputationBar14.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar14.verticalCenter
        width: 150
        height: 10
    }

    StatusBar {
        id: reputationBar14ReputationBar
        name: "ReputationBar14ReputationBar"
        wowParent: "ReputationBar14"
        anchors.right: reputationBar14.right
        anchors.verticalCenter: reputationBar14.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar14ReputationBarFactionStanding
        name: "ReputationBar14ReputationBarFactionStanding"
        text: "Exalted"
        wowParent: "ReputationBar14ReputationBar"
        anchors.horizontalCenter: reputationBar14ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar14ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Button {
        id: reputationBar15
        name: "ReputationBar15"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar14.right
        anchors.top: reputationBar14.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Button {
        id: reputationBar15ExpandOrCollapseButton
        name: "ReputationBar15ExpandOrCollapseButton"
        wowParent: "ReputationBar15"
        anchors.left: reputationBar15.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar15.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar15FactionName
        name: "ReputationBar15FactionName"
        text: "Ironforge"
        wowParent: "ReputationBar15"
        anchors.left: reputationBar15.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar15.verticalCenter
        width: 150
        height: 10
    }

    StatusBar {
        id: reputationBar15ReputationBar
        name: "ReputationBar15ReputationBar"
        wowParent: "ReputationBar15"
        anchors.right: reputationBar15.right
        anchors.verticalCenter: reputationBar15.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar15ReputationBarFactionStanding
        name: "ReputationBar15ReputationBarFactionStanding"
        text: "Exalted"
        wowParent: "ReputationBar15ReputationBar"
        anchors.horizontalCenter: reputationBar15ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar15ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
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

    Button {
        id: reputationBar2
        name: "ReputationBar2"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar1.right
        anchors.top: reputationBar1.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    FontString {
        id: reputationBar2FactionName
        name: "ReputationBar2FactionName"
        text: "Argent Dawn"
        wowParent: "ReputationBar2"
        anchors.left: reputationBar2.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar2.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar2ReputationBar
        name: "ReputationBar2ReputationBar"
        wowParent: "ReputationBar2"
        anchors.right: reputationBar2.right
        anchors.verticalCenter: reputationBar2.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar2ReputationBarFactionStanding
        name: "ReputationBar2ReputationBarFactionStanding"
        text: "Revered"
        wowParent: "ReputationBar2ReputationBar"
        anchors.horizontalCenter: reputationBar2ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar2ReputationBar.verticalCenter
        width: 44.2
        height: 10.3
    }

    Button {
        id: reputationBar3
        name: "ReputationBar3"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar2.right
        anchors.top: reputationBar2.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Button {
        id: reputationBar3ExpandOrCollapseButton
        name: "ReputationBar3ExpandOrCollapseButton"
        wowParent: "ReputationBar3"
        anchors.left: reputationBar3.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar3.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar3FactionName
        name: "ReputationBar3FactionName"
        text: "Bloodsail Buccaneers"
        wowParent: "ReputationBar3"
        anchors.left: reputationBar3.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar3.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar3ReputationBar
        name: "ReputationBar3ReputationBar"
        wowParent: "ReputationBar3"
        anchors.right: reputationBar3.right
        anchors.verticalCenter: reputationBar3.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar3ReputationBarFactionStanding
        name: "ReputationBar3ReputationBarFactionStanding"
        text: "Honored"
        wowParent: "ReputationBar3ReputationBar"
        anchors.horizontalCenter: reputationBar3ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar3ReputationBar.verticalCenter
        width: 47.4
        height: 10.3
    }

    Button {
        id: reputationBar4
        name: "ReputationBar4"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar3.right
        anchors.top: reputationBar3.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Button {
        id: reputationBar4ExpandOrCollapseButton
        name: "ReputationBar4ExpandOrCollapseButton"
        wowParent: "ReputationBar4"
        anchors.left: reputationBar4.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar4.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar4FactionName
        name: "ReputationBar4FactionName"
        text: "Cenarion Circle"
        wowParent: "ReputationBar4"
        anchors.left: reputationBar4.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar4.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar4ReputationBar
        name: "ReputationBar4ReputationBar"
        wowParent: "ReputationBar4"
        anchors.right: reputationBar4.right
        anchors.verticalCenter: reputationBar4.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar4ReputationBarFactionStanding
        name: "ReputationBar4ReputationBarFactionStanding"
        text: "Neutral"
        wowParent: "ReputationBar4ReputationBar"
        anchors.horizontalCenter: reputationBar4ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar4ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Button {
        id: reputationBar5
        name: "ReputationBar5"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar4.right
        anchors.top: reputationBar4.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Button {
        id: reputationBar5ExpandOrCollapseButton
        name: "ReputationBar5ExpandOrCollapseButton"
        wowParent: "ReputationBar5"
        anchors.left: reputationBar5.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar5.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar5FactionName
        name: "ReputationBar5FactionName"
        text: "Darkmoon Faire"
        wowParent: "ReputationBar5"
        anchors.left: reputationBar5.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar5.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar5ReputationBar
        name: "ReputationBar5ReputationBar"
        wowParent: "ReputationBar5"
        anchors.right: reputationBar5.right
        anchors.verticalCenter: reputationBar5.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar5ReputationBarFactionStanding
        name: "ReputationBar5ReputationBarFactionStanding"
        text: "Neutral"
        wowParent: "ReputationBar5ReputationBar"
        anchors.horizontalCenter: reputationBar5ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar5ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Button {
        id: reputationBar6
        name: "ReputationBar6"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar5.right
        anchors.top: reputationBar5.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    FontString {
        id: reputationBar6FactionName
        name: "ReputationBar6FactionName"
        text: "Hydraxian Waterlords"
        wowParent: "ReputationBar6"
        anchors.left: reputationBar6.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar6.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar6ReputationBar
        name: "ReputationBar6ReputationBar"
        wowParent: "ReputationBar6"
        anchors.right: reputationBar6.right
        anchors.verticalCenter: reputationBar6.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar6ReputationBarFactionStanding
        name: "ReputationBar6ReputationBarFactionStanding"
        text: "Friendly"
        wowParent: "ReputationBar6ReputationBar"
        anchors.horizontalCenter: reputationBar6ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar6ReputationBar.verticalCenter
        width: 43.5
        height: 10.3
    }

    Button {
        id: reputationBar7
        name: "ReputationBar7"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar6.right
        anchors.top: reputationBar6.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    FontString {
        id: reputationBar7FactionName
        name: "ReputationBar7FactionName"
        text: "Ravenholdt"
        wowParent: "ReputationBar7"
        anchors.left: reputationBar7.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar7.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar7ReputationBar
        name: "ReputationBar7ReputationBar"
        wowParent: "ReputationBar7"
        anchors.right: reputationBar7.right
        anchors.verticalCenter: reputationBar7.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar7ReputationBarFactionStanding
        name: "ReputationBar7ReputationBarFactionStanding"
        text: "Neutral"
        wowParent: "ReputationBar7ReputationBar"
        anchors.horizontalCenter: reputationBar7ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar7ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Button {
        id: reputationBar8
        name: "ReputationBar8"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar7.right
        anchors.top: reputationBar7.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Button {
        id: reputationBar8ExpandOrCollapseButton
        name: "ReputationBar8ExpandOrCollapseButton"
        wowParent: "ReputationBar8"
        anchors.left: reputationBar8.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar8.verticalCenter
        width: 13
        height: 13
    }

    FontString {
        id: reputationBar8FactionName
        name: "ReputationBar8FactionName"
        text: "Thorium Brotherhood"
        wowParent: "ReputationBar8"
        anchors.left: reputationBar8.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar8.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar8ReputationBar
        name: "ReputationBar8ReputationBar"
        wowParent: "ReputationBar8"
        anchors.right: reputationBar8.right
        anchors.verticalCenter: reputationBar8.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar8ReputationBarFactionStanding
        name: "ReputationBar8ReputationBarFactionStanding"
        text: "Revered"
        wowParent: "ReputationBar8ReputationBar"
        anchors.horizontalCenter: reputationBar8ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar8ReputationBar.verticalCenter
        width: 44.2
        height: 10.3
    }

    Button {
        id: reputationBar9
        name: "ReputationBar9"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar8.right
        anchors.top: reputationBar8.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    FontString {
        id: reputationBar9FactionName
        name: "ReputationBar9FactionName"
        text: "Timbermaw Hold"
        wowParent: "ReputationBar9"
        anchors.left: reputationBar9.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar9.verticalCenter
        width: 160
        height: 10
    }

    StatusBar {
        id: reputationBar9ReputationBar
        name: "ReputationBar9ReputationBar"
        wowParent: "ReputationBar9"
        anchors.right: reputationBar9.right
        anchors.verticalCenter: reputationBar9.verticalCenter
        width: 101
        height: 13
    }

    FontString {
        id: reputationBar9ReputationBarFactionStanding
        name: "ReputationBar9ReputationBarFactionStanding"
        text: "Exalted"
        wowParent: "ReputationBar9ReputationBar"
        anchors.horizontalCenter: reputationBar9ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar9ReputationBar.verticalCenter
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
        id: skillRankFrame10
        name: "SkillRankFrame10"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame9.left
        anchors.top: skillRankFrame9.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame10Border
        name: "SkillRankFrame10Border"
        wowParent: "SkillRankFrame10"
        anchors.left: skillRankFrame10.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame10.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame10SkillName
        name: "SkillRankFrame10SkillName"
        text: "First Aid"
        wowParent: "SkillRankFrame10"
        anchors.left: skillRankFrame10.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame10.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 44.2
        height: 10.3
    }

    FontString {
        id: skillRankFrame10SkillRank
        name: "SkillRankFrame10SkillRank"
        text: "450/450"
        wowParent: "SkillRankFrame10"
        anchors.left: skillRankFrame10SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame10SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    StatusBar {
        id: skillRankFrame11
        name: "SkillRankFrame11"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame10.left
        anchors.top: skillRankFrame10.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame11Border
        name: "SkillRankFrame11Border"
        wowParent: "SkillRankFrame11"
        anchors.left: skillRankFrame11.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame11.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame11SkillName
        name: "SkillRankFrame11SkillName"
        text: "Fishing"
        wowParent: "SkillRankFrame11"
        anchors.left: skillRankFrame11.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame11.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.7
        height: 10.3
    }

    FontString {
        id: skillRankFrame11SkillRank
        name: "SkillRankFrame11SkillRank"
        text: "450/450"
        wowParent: "SkillRankFrame11"
        anchors.left: skillRankFrame11SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame11SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    StatusBar {
        id: skillRankFrame12
        name: "SkillRankFrame12"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame11.left
        anchors.top: skillRankFrame11.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame12Border
        name: "SkillRankFrame12Border"
        wowParent: "SkillRankFrame12"
        anchors.left: skillRankFrame12.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame12.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame12SkillName
        name: "SkillRankFrame12SkillName"
        text: "Riding"
        wowParent: "SkillRankFrame12"
        anchors.left: skillRankFrame12.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame12.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 35.6
        height: 10.3
    }

    FontString {
        id: skillRankFrame12SkillRank
        name: "SkillRankFrame12SkillRank"
        text: "300/300"
        wowParent: "SkillRankFrame12"
        anchors.left: skillRankFrame12SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame12SkillName.verticalCenter
        width: 128
        height: 10.3
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

    StatusBar {
        id: skillRankFrame3
        name: "SkillRankFrame3"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame2.left
        anchors.top: skillRankFrame2.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame3Border
        name: "SkillRankFrame3Border"
        wowParent: "SkillRankFrame3"
        anchors.left: skillRankFrame3.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame3.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame3SkillName
        name: "SkillRankFrame3SkillName"
        text: "Holy"
        wowParent: "SkillRankFrame3"
        anchors.left: skillRankFrame3.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 26.9
        height: 10.3
    }

    FontString {
        id: skillRankFrame3SkillRank
        name: "SkillRankFrame3SkillRank"
        wowParent: "SkillRankFrame3"
        anchors.left: skillRankFrame3SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame3SkillName.verticalCenter
        width: 128
        height: 1
    }

    StatusBar {
        id: skillRankFrame4
        name: "SkillRankFrame4"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame3.left
        anchors.top: skillRankFrame3.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame4Border
        name: "SkillRankFrame4Border"
        wowParent: "SkillRankFrame4"
        anchors.left: skillRankFrame4.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame4.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame4SkillName
        name: "SkillRankFrame4SkillName"
        text: "Shadow Magic"
        wowParent: "SkillRankFrame4"
        anchors.left: skillRankFrame4.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame4.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 79.8
        height: 10.3
    }

    FontString {
        id: skillRankFrame4SkillRank
        name: "SkillRankFrame4SkillRank"
        wowParent: "SkillRankFrame4"
        anchors.left: skillRankFrame4SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame4SkillName.verticalCenter
        width: 128
        height: 1
    }

    StatusBar {
        id: skillRankFrame5
        name: "SkillRankFrame5"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame4.left
        anchors.top: skillRankFrame4.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame5Border
        name: "SkillRankFrame5Border"
        wowParent: "SkillRankFrame5"
        anchors.left: skillRankFrame5.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame5.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame5SkillName
        name: "SkillRankFrame5SkillName"
        text: "Unholy"
        wowParent: "SkillRankFrame5"
        anchors.left: skillRankFrame5.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame5.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.7
        height: 10.3
    }

    FontString {
        id: skillRankFrame5SkillRank
        name: "SkillRankFrame5SkillRank"
        wowParent: "SkillRankFrame5"
        anchors.left: skillRankFrame5SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame5SkillName.verticalCenter
        width: 128
        height: 1
    }

    StatusBar {
        id: skillRankFrame6
        name: "SkillRankFrame6"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame5.left
        anchors.top: skillRankFrame5.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame6Border
        name: "SkillRankFrame6Border"
        wowParent: "SkillRankFrame6"
        anchors.left: skillRankFrame6.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame6.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame6SkillName
        name: "SkillRankFrame6SkillName"
        text: "Enchanting"
        wowParent: "SkillRankFrame6"
        anchors.left: skillRankFrame6.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame6.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 59.3
        height: 10.3
    }

    FontString {
        id: skillRankFrame6SkillRank
        name: "SkillRankFrame6SkillRank"
        text: "450/450"
        wowParent: "SkillRankFrame6"
        anchors.left: skillRankFrame6SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame6SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    StatusBar {
        id: skillRankFrame7
        name: "SkillRankFrame7"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame6.left
        anchors.top: skillRankFrame6.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame7Border
        name: "SkillRankFrame7Border"
        wowParent: "SkillRankFrame7"
        anchors.left: skillRankFrame7.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame7.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame7SkillName
        name: "SkillRankFrame7SkillName"
        text: "Tailoring"
        wowParent: "SkillRankFrame7"
        anchors.left: skillRankFrame7.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame7.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 48.2
        height: 10.3
    }

    FontString {
        id: skillRankFrame7SkillRank
        name: "SkillRankFrame7SkillRank"
        text: "450/450"
        wowParent: "SkillRankFrame7"
        anchors.left: skillRankFrame7SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame7SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    StatusBar {
        id: skillRankFrame8
        name: "SkillRankFrame8"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame7.left
        anchors.top: skillRankFrame7.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame8Border
        name: "SkillRankFrame8Border"
        wowParent: "SkillRankFrame8"
        anchors.left: skillRankFrame8.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame8.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame8SkillName
        name: "SkillRankFrame8SkillName"
        text: "Riding"
        wowParent: "SkillRankFrame8"
        anchors.left: skillRankFrame8.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame8.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 35.6
        height: 10.3
    }

    FontString {
        id: skillRankFrame8SkillRank
        name: "SkillRankFrame8SkillRank"
        text: "150/150"
        wowParent: "SkillRankFrame8"
        anchors.left: skillRankFrame8SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame8SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    StatusBar {
        id: skillRankFrame9
        name: "SkillRankFrame9"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame8.left
        anchors.top: skillRankFrame8.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Button {
        id: skillRankFrame9Border
        name: "SkillRankFrame9Border"
        wowParent: "SkillRankFrame9"
        anchors.left: skillRankFrame9.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame9.verticalCenter
        width: 281
        height: 32
    }

    FontString {
        id: skillRankFrame9SkillName
        name: "SkillRankFrame9SkillName"
        text: "Cooking"
        wowParent: "SkillRankFrame9"
        anchors.left: skillRankFrame9.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame9.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 45
        height: 10.3
    }

    FontString {
        id: skillRankFrame9SkillRank
        name: "SkillRankFrame9SkillRank"
        text: "450/450"
        wowParent: "SkillRankFrame9"
        anchors.left: skillRankFrame9SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame9SkillName.verticalCenter
        width: 128
        height: 10.3
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

    Button {
        id: tokenFrameContainerButton10
        name: "TokenFrameContainerButton10"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton9.left
        anchors.top: tokenFrameContainerButton9.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton10Count
        name: "TokenFrameContainerButton10Count"
        text: "0"
        wowParent: "TokenFrameContainerButton10"
        anchors.right: tokenFrameContainerButton10Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton10Icon.verticalCenter
        width: 8.7
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton10Name
        name: "TokenFrameContainerButton10Name"
        text: "Arena Points"
        wowParent: "TokenFrameContainerButton10"
        anchors.left: tokenFrameContainerButton10.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton10.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton11
        name: "TokenFrameContainerButton11"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton10.left
        anchors.top: tokenFrameContainerButton10.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton11Count
        name: "TokenFrameContainerButton11Count"
        text: "50130"
        wowParent: "TokenFrameContainerButton11"
        anchors.right: tokenFrameContainerButton11Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton11Icon.verticalCenter
        width: 38.7
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton11Name
        name: "TokenFrameContainerButton11Name"
        text: "Honor Points"
        wowParent: "TokenFrameContainerButton11"
        anchors.left: tokenFrameContainerButton11.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton11.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton12
        name: "TokenFrameContainerButton12"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton11.left
        anchors.top: tokenFrameContainerButton11.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton12Count
        name: "TokenFrameContainerButton12Count"
        text: "195"
        wowParent: "TokenFrameContainerButton12"
        anchors.right: tokenFrameContainerButton12Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton12Icon.verticalCenter
        width: 23.7
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton12Name
        name: "TokenFrameContainerButton12Name"
        text: "Stone Keeper's Shard"
        wowParent: "TokenFrameContainerButton12"
        anchors.left: tokenFrameContainerButton12.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton12.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton13
        name: "TokenFrameContainerButton13"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton12.left
        anchors.top: tokenFrameContainerButton12.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton13Count
        name: "TokenFrameContainerButton13Count"
        text: "3"
        wowParent: "TokenFrameContainerButton13"
        anchors.right: tokenFrameContainerButton13Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton13Icon.verticalCenter
        width: 8.7
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton13Name
        name: "TokenFrameContainerButton13Name"
        text: "Warsong Gulch Mark of Honor"
        wowParent: "TokenFrameContainerButton13"
        anchors.left: tokenFrameContainerButton13.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton13.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton14
        name: "TokenFrameContainerButton14"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton13.left
        anchors.top: tokenFrameContainerButton13.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton14Count
        name: "TokenFrameContainerButton14Count"
        text: "5"
        wowParent: "TokenFrameContainerButton14"
        anchors.right: tokenFrameContainerButton14Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton14Icon.verticalCenter
        width: 8.7
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton14Name
        name: "TokenFrameContainerButton14Name"
        text: "Wintergrasp Mark of Honor"
        wowParent: "TokenFrameContainerButton14"
        anchors.left: tokenFrameContainerButton14.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton14.verticalCenter
        width: 210
        height: 11
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

    Button {
        id: tokenFrameContainerButton2
        name: "TokenFrameContainerButton2"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton1.left
        anchors.top: tokenFrameContainerButton1.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton2Count
        name: "TokenFrameContainerButton2Count"
        text: "30"
        wowParent: "TokenFrameContainerButton2"
        anchors.right: tokenFrameContainerButton2Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton2Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton2Name
        name: "TokenFrameContainerButton2Name"
        text: "Emblem of Conquest"
        wowParent: "TokenFrameContainerButton2"
        anchors.left: tokenFrameContainerButton2.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton2.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton3
        name: "TokenFrameContainerButton3"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton2.left
        anchors.top: tokenFrameContainerButton2.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton3Count
        name: "TokenFrameContainerButton3Count"
        text: "29"
        wowParent: "TokenFrameContainerButton3"
        anchors.right: tokenFrameContainerButton3Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton3Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton3Name
        name: "TokenFrameContainerButton3Name"
        text: "Emblem of Heroism"
        wowParent: "TokenFrameContainerButton3"
        anchors.left: tokenFrameContainerButton3.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton3.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton4
        name: "TokenFrameContainerButton4"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton3.left
        anchors.top: tokenFrameContainerButton3.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton4Count
        name: "TokenFrameContainerButton4Count"
        text: "33"
        wowParent: "TokenFrameContainerButton4"
        anchors.right: tokenFrameContainerButton4Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton4Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton4Name
        name: "TokenFrameContainerButton4Name"
        text: "Emblem of Valor"
        wowParent: "TokenFrameContainerButton4"
        anchors.left: tokenFrameContainerButton4.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton4.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton5
        name: "TokenFrameContainerButton5"
        text: "Miscellaneous"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton4.left
        anchors.top: tokenFrameContainerButton4.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton5Count
        name: "TokenFrameContainerButton5Count"
        wowParent: "TokenFrameContainerButton5"
        anchors.right: tokenFrameContainerButton5Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton5Icon.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tokenFrameContainerButton5Name
        name: "TokenFrameContainerButton5Name"
        wowParent: "TokenFrameContainerButton5"
        anchors.left: tokenFrameContainerButton5.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton5.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton6
        name: "TokenFrameContainerButton6"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton5.left
        anchors.top: tokenFrameContainerButton5.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton6Count
        name: "TokenFrameContainerButton6Count"
        text: "24"
        wowParent: "TokenFrameContainerButton6"
        anchors.right: tokenFrameContainerButton6Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton6Icon.verticalCenter
        width: 17.4
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton6Name
        name: "TokenFrameContainerButton6Name"
        text: "Badge of Justice"
        wowParent: "TokenFrameContainerButton6"
        anchors.left: tokenFrameContainerButton6.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton6.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton7
        name: "TokenFrameContainerButton7"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton6.left
        anchors.top: tokenFrameContainerButton6.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton7Count
        name: "TokenFrameContainerButton7Count"
        text: "89"
        wowParent: "TokenFrameContainerButton7"
        anchors.right: tokenFrameContainerButton7Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton7Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton7Name
        name: "TokenFrameContainerButton7Name"
        text: "Champion's Seal"
        wowParent: "TokenFrameContainerButton7"
        anchors.left: tokenFrameContainerButton7.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton7.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton8
        name: "TokenFrameContainerButton8"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton7.left
        anchors.top: tokenFrameContainerButton7.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton8Count
        name: "TokenFrameContainerButton8Count"
        text: "29"
        wowParent: "TokenFrameContainerButton8"
        anchors.right: tokenFrameContainerButton8Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton8Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    FontString {
        id: tokenFrameContainerButton8Name
        name: "TokenFrameContainerButton8Name"
        text: "Dalaran Cooking Award"
        wowParent: "TokenFrameContainerButton8"
        anchors.left: tokenFrameContainerButton8.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton8.verticalCenter
        width: 210
        height: 11
    }

    Button {
        id: tokenFrameContainerButton9
        name: "TokenFrameContainerButton9"
        text: "Player vs. Player"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton8.left
        anchors.top: tokenFrameContainerButton8.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    FontString {
        id: tokenFrameContainerButton9Count
        name: "TokenFrameContainerButton9Count"
        wowParent: "TokenFrameContainerButton9"
        anchors.right: tokenFrameContainerButton9Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton9Icon.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: tokenFrameContainerButton9Name
        name: "TokenFrameContainerButton9Name"
        wowParent: "TokenFrameContainerButton9"
        anchors.left: tokenFrameContainerButton9.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton9.verticalCenter
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
    Ghost { id: tokenFrameContainerButton10Icon; name: "TokenFrameContainerButton10Icon"; x: 323; y: 287.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton11Icon; name: "TokenFrameContainerButton11Icon"; x: 323; y: 307.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton12Icon; name: "TokenFrameContainerButton12Icon"; x: 323; y: 327.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton13Icon; name: "TokenFrameContainerButton13Icon"; x: 323; y: 347.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton14Icon; name: "TokenFrameContainerButton14Icon"; x: 323; y: 367.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton1Icon; name: "TokenFrameContainerButton1Icon"; x: 323; y: 107.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton2Icon; name: "TokenFrameContainerButton2Icon"; x: 323; y: 127.4; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton3Icon; name: "TokenFrameContainerButton3Icon"; x: 323; y: 147.4; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton4Icon; name: "TokenFrameContainerButton4Icon"; x: 323; y: 167.4; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton5Icon; name: "TokenFrameContainerButton5Icon"; x: 323; y: 187.5; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton6Icon; name: "TokenFrameContainerButton6Icon"; x: 323; y: 207.4; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton7Icon; name: "TokenFrameContainerButton7Icon"; x: 323; y: 227.4; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton8Icon; name: "TokenFrameContainerButton8Icon"; x: 323; y: 247.4; width: 0; height: 0 }
    Ghost { id: tokenFrameContainerButton9Icon; name: "TokenFrameContainerButton9Icon"; x: 323; y: 267.5; width: 0; height: 0 }
}
