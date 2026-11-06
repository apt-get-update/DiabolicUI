// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: characterFrame
    name: "CharacterFrame"
    width: 384
    height: 512

    Part {
        id: characterAmmoSlot
        name: "CharacterAmmoSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.left: characterRangedSlot.right
        anchors.leftMargin: 15
        anchors.verticalCenter: characterRangedSlot.verticalCenter
        width: 27
        height: 27
    }

    Part {
        id: characterBackSlot
        name: "CharacterBackSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterShoulderSlot.horizontalCenter
        anchors.top: characterShoulderSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterBackSlotPopoutButton
        name: "CharacterBackSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterBackSlot"
        anchors.left: characterBackSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterBackSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterChestSlot
        name: "CharacterChestSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterBackSlot.horizontalCenter
        anchors.top: characterBackSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterChestSlotPopoutButton
        name: "CharacterChestSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterChestSlot"
        anchors.left: characterChestSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterChestSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterFeetSlot
        name: "CharacterFeetSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterLegsSlot.horizontalCenter
        anchors.top: characterLegsSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterFeetSlotPopoutButton
        name: "CharacterFeetSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterFeetSlot"
        anchors.left: characterFeetSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterFeetSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterFinger0Slot
        name: "CharacterFinger0Slot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterFeetSlot.horizontalCenter
        anchors.top: characterFeetSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterFinger0SlotPopoutButton
        name: "CharacterFinger0SlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterFinger0Slot"
        anchors.left: characterFinger0Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterFinger0Slot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterFinger1Slot
        name: "CharacterFinger1Slot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterFinger0Slot.horizontalCenter
        anchors.top: characterFinger0Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterFinger1SlotPopoutButton
        name: "CharacterFinger1SlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterFinger1Slot"
        anchors.left: characterFinger1Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterFinger1Slot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterFrameCloseButton
        name: "CharacterFrameCloseButton"
        kind: "Button"
        wowParent: "CharacterFrame"
        style: "CloseButton"
        anchors.horizontalCenter: characterFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: characterFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: characterFrameDiabolic
        name: "CharacterFrameDiabolic"
        kind: "Frame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.top: characterFrame.top
        anchors.topMargin: 4
        width: 650
        height: 478
    }

    Part {
        id: characterFrameDiabolicBorder
        name: "CharacterFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "CharacterFrameDiabolic"
        anchors.left: characterFrameDiabolic.left
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 32
        width: 650
        height: 446
    }

    Part {
        id: characterFrameDiabolicRail
        name: "CharacterFrameDiabolicRail"
        kind: "Frame"
        wowParent: "CharacterFrameDiabolic"
        anchors.left: characterFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: characterFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Part {
        id: characterFrameDiabolicSocket
        name: "CharacterFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "CharacterFrameDiabolic"
        anchors.right: characterFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: characterFrameDiabolicTitlePlate
        name: "CharacterFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "CharacterFrameDiabolic"
        anchors.horizontalCenter: characterFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: characterFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: characterFrameDiabolicTitlePlateGem
        name: "CharacterFrameDiabolicTitlePlateGem"
        kind: "Button"
        wowParent: "CharacterFrameDiabolicTitlePlate"
        anchors.horizontalCenter: characterFrameDiabolicTitlePlate.left
        anchors.horizontalCenterOffset: 35
        anchors.verticalCenter: characterFrameDiabolicTitlePlate.verticalCenter
        width: 40
        height: 40
    }

    Part {
        id: characterFrameTab1
        name: "CharacterFrameTab1"
        kind: "Button"
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

    Part {
        id: characterFrameTab3
        name: "CharacterFrameTab3"
        kind: "Button"
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

    Part {
        id: characterFrameTab4
        name: "CharacterFrameTab4"
        kind: "Button"
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

    Part {
        id: characterFrameTab5
        name: "CharacterFrameTab5"
        kind: "Button"
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

    Part {
        id: characterGuildText
        name: "CharacterGuildText"
        kind: "FontString"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterLevelText.horizontalCenter
        anchors.top: characterLevelText.bottom
        anchors.topMargin: 1
        width: 1
        height: 1
    }

    Part {
        id: characterHandsSlot
        name: "CharacterHandsSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 343
        anchors.top: paperDollFrame.top
        anchors.topMargin: 70
        width: 37
        height: 37
    }

    Part {
        id: characterHandsSlotPopoutButton
        name: "CharacterHandsSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterHandsSlot"
        anchors.left: characterHandsSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterHandsSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterHeadSlot
        name: "CharacterHeadSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 38
        anchors.top: paperDollFrame.top
        anchors.topMargin: 70
        width: 37
        height: 37
    }

    Part {
        id: characterHeadSlotPopoutButton
        name: "CharacterHeadSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterHeadSlot"
        anchors.left: characterHeadSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterHeadSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterLegsSlot
        name: "CharacterLegsSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterWaistSlot.horizontalCenter
        anchors.top: characterWaistSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterLegsSlotPopoutButton
        name: "CharacterLegsSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterLegsSlot"
        anchors.left: characterLegsSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterLegsSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterLevelText
        name: "CharacterLevelText"
        kind: "FontString"
        text: "Level 80 Dwarf Priest"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterNameText.horizontalCenter
        anchors.top: characterNameText.bottom
        anchors.topMargin: 6
        width: 113.8
        height: 10.3
    }

    Part {
        id: characterMainHandSlot
        name: "CharacterMainHandSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.right: characterSecondaryHandSlot.left
        anchors.rightMargin: 6
        anchors.top: characterSecondaryHandSlot.top
        width: 37
        height: 37
    }

    Part {
        id: characterMainHandSlotPopoutButton
        name: "CharacterMainHandSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterMainHandSlot"
        anchors.horizontalCenter: characterMainHandSlot.horizontalCenter
        anchors.top: characterMainHandSlot.bottom
        anchors.topMargin: -4
        width: 38
        height: 16
    }

    Part {
        id: characterModelFrame
        name: "CharacterModelFrame"
        kind: "PlayerModel"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 89
        anchors.top: paperDollFrame.top
        anchors.topMargin: 44
        width: 240
        height: 372
    }

    Part {
        id: characterModelFrameRotateLeftButton
        name: "CharacterModelFrameRotateLeftButton"
        kind: "Button"
        wowParent: "CharacterModelFrame"
        anchors.left: characterModelFrame.left
        anchors.top: characterModelFrame.top
        anchors.topMargin: 26
        width: 35
        height: 35
    }

    Part {
        id: characterModelFrameRotateRightButton
        name: "CharacterModelFrameRotateRightButton"
        kind: "Button"
        wowParent: "CharacterModelFrame"
        anchors.left: characterModelFrameRotateLeftButton.right
        anchors.top: characterModelFrameRotateLeftButton.top
        width: 35
        height: 35
    }

    Part {
        id: characterNameFrame
        name: "CharacterNameFrame"
        kind: "Frame"
        wowParent: "CharacterFrame"
        anchors.horizontalCenter: characterFrame.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: characterFrame.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 109
        height: 12
    }

    Part {
        id: characterNameText
        name: "CharacterNameText"
        kind: "FontString"
        text: "Crusader Padirac"
        wowParent: "CharacterFrameDiabolicTitlePlate"
        anchors.horizontalCenter: characterFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: characterFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 158.8
        height: 14.2
    }

    Part {
        id: characterNeckSlot
        name: "CharacterNeckSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterHeadSlot.horizontalCenter
        anchors.top: characterHeadSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterNeckSlotPopoutButton
        name: "CharacterNeckSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterNeckSlot"
        anchors.left: characterNeckSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterNeckSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterRangedSlot
        name: "CharacterRangedSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.left: characterSecondaryHandSlot.right
        anchors.leftMargin: 6
        anchors.top: characterSecondaryHandSlot.top
        width: 37
        height: 37
    }

    Part {
        id: characterRangedSlotPopoutButton
        name: "CharacterRangedSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterRangedSlot"
        anchors.horizontalCenter: characterRangedSlot.horizontalCenter
        anchors.top: characterRangedSlot.bottom
        anchors.topMargin: -4
        width: 38
        height: 16
    }

    Part {
        id: characterResistanceFrame
        name: "CharacterResistanceFrame"
        kind: "Frame"
        wowParent: "PaperDollFrame"
        anchors.right: paperDollFrame.left
        anchors.rightMargin: -297
        anchors.top: paperDollFrame.top
        anchors.topMargin: 77
        width: 32
        height: 160
    }

    Part {
        id: characterSecondaryHandSlot
        name: "CharacterSecondaryHandSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 190.5
        anchors.top: paperDollFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    Part {
        id: characterSecondaryHandSlotPopoutButton
        name: "CharacterSecondaryHandSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterSecondaryHandSlot"
        anchors.horizontalCenter: characterSecondaryHandSlot.horizontalCenter
        anchors.top: characterSecondaryHandSlot.bottom
        anchors.topMargin: -4
        width: 38
        height: 16
    }

    Part {
        id: characterShirtSlot
        name: "CharacterShirtSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterChestSlot.horizontalCenter
        anchors.top: characterChestSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterShirtSlotPopoutButton
        name: "CharacterShirtSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterShirtSlot"
        anchors.left: characterShirtSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterShirtSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterShoulderSlot
        name: "CharacterShoulderSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterNeckSlot.horizontalCenter
        anchors.top: characterNeckSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterShoulderSlotPopoutButton
        name: "CharacterShoulderSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterShoulderSlot"
        anchors.left: characterShoulderSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterShoulderSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterTabardSlot
        name: "CharacterTabardSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterShirtSlot.horizontalCenter
        anchors.top: characterShirtSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterTabardSlotPopoutButton
        name: "CharacterTabardSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterTabardSlot"
        anchors.left: characterTabardSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterTabardSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterTrinket0Slot
        name: "CharacterTrinket0Slot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterFinger1Slot.horizontalCenter
        anchors.top: characterFinger1Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterTrinket0SlotPopoutButton
        name: "CharacterTrinket0SlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterTrinket0Slot"
        anchors.left: characterTrinket0Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterTrinket0Slot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterTrinket1Slot
        name: "CharacterTrinket1Slot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterTrinket0Slot.horizontalCenter
        anchors.top: characterTrinket0Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterTrinket1SlotPopoutButton
        name: "CharacterTrinket1SlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterTrinket1Slot"
        anchors.left: characterTrinket1Slot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterTrinket1Slot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterWaistSlot
        name: "CharacterWaistSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterHandsSlot.horizontalCenter
        anchors.top: characterHandsSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterWaistSlotPopoutButton
        name: "CharacterWaistSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterWaistSlot"
        anchors.left: characterWaistSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterWaistSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: characterWristSlot
        name: "CharacterWristSlot"
        kind: "Button"
        wowParent: "PaperDollFrame"
        anchors.horizontalCenter: characterTabardSlot.horizontalCenter
        anchors.top: characterTabardSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Part {
        id: characterWristSlotPopoutButton
        name: "CharacterWristSlotPopoutButton"
        kind: "Button"
        wowParent: "CharacterWristSlot"
        anchors.left: characterWristSlot.right
        anchors.leftMargin: -8
        anchors.verticalCenter: characterWristSlot.verticalCenter
        width: 16
        height: 38
    }

    Part {
        id: diabolicUICharacterSideTab1
        name: "DiabolicUICharacterSideTab1"
        kind: "Button"
        wowParent: "?"
        style: "Tab"
        anchors.right: diabolicUICharacterSideTab2.left
        anchors.rightMargin: 6
        anchors.verticalCenter: diabolicUICharacterSideTab2.verticalCenter
        width: 44
        height: 30
    }

    Part {
        id: diabolicUICharacterSideTab2
        name: "DiabolicUICharacterSideTab2"
        kind: "Button"
        wowParent: "?"
        style: "Tab"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 486
        anchors.top: paperDollFrame.top
        anchors.topMargin: 78
        width: 44
        height: 30
    }

    Part {
        id: diabolicUICharacterSideTab3
        name: "DiabolicUICharacterSideTab3"
        kind: "Button"
        wowParent: "?"
        style: "Tab"
        anchors.left: diabolicUICharacterSideTab2.right
        anchors.leftMargin: 6
        anchors.verticalCenter: diabolicUICharacterSideTab2.verticalCenter
        width: 44
        height: 30
    }

    Part {
        id: diabolicUICharacterStats11
        name: "DiabolicUICharacterStats11"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 268
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats11Label
        name: "DiabolicUICharacterStats11Label"
        kind: "FontString"
        text: "Strength:"
        wowParent: "DiabolicUICharacterStats11"
        anchors.left: diabolicUICharacterStats11.left
        anchors.verticalCenter: diabolicUICharacterStats11.verticalCenter
        width: 50.6
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats11Stat
        name: "DiabolicUICharacterStats11Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats11"
        anchors.right: diabolicUICharacterStats11.right
        anchors.verticalCenter: diabolicUICharacterStats11.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats11StatText
        name: "DiabolicUICharacterStats11StatText"
        kind: "FontString"
        wowParent: "DiabolicUICharacterStats11Stat"
        anchors.right: diabolicUICharacterStats11Stat.right
        anchors.verticalCenter: diabolicUICharacterStats11Stat.verticalCenter
        width: 13.4
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats12
        name: "DiabolicUICharacterStats12"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 280
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats12Label
        name: "DiabolicUICharacterStats12Label"
        kind: "FontString"
        text: "Agility:"
        wowParent: "DiabolicUICharacterStats12"
        anchors.left: diabolicUICharacterStats12.left
        anchors.verticalCenter: diabolicUICharacterStats12.verticalCenter
        width: 37.1
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats12Stat
        name: "DiabolicUICharacterStats12Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats12"
        anchors.right: diabolicUICharacterStats12.right
        anchors.verticalCenter: diabolicUICharacterStats12.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats12StatText
        name: "DiabolicUICharacterStats12StatText"
        kind: "FontString"
        wowParent: "DiabolicUICharacterStats12Stat"
        anchors.right: diabolicUICharacterStats12Stat.right
        anchors.verticalCenter: diabolicUICharacterStats12Stat.verticalCenter
        width: 14.2
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats13
        name: "DiabolicUICharacterStats13"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 292
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats13Label
        name: "DiabolicUICharacterStats13Label"
        kind: "FontString"
        text: "Stamina:"
        wowParent: "DiabolicUICharacterStats13"
        anchors.left: diabolicUICharacterStats13.left
        anchors.verticalCenter: diabolicUICharacterStats13.verticalCenter
        width: 47.4
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats13Stat
        name: "DiabolicUICharacterStats13Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats13"
        anchors.right: diabolicUICharacterStats13.right
        anchors.verticalCenter: diabolicUICharacterStats13.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats13StatText
        name: "DiabolicUICharacterStats13StatText"
        kind: "FontString"
        wowParent: "DiabolicUICharacterStats13Stat"
        anchors.right: diabolicUICharacterStats13Stat.right
        anchors.verticalCenter: diabolicUICharacterStats13Stat.verticalCenter
        width: 20.5
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats14
        name: "DiabolicUICharacterStats14"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 304
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats14Label
        name: "DiabolicUICharacterStats14Label"
        kind: "FontString"
        text: "Intellect:"
        wowParent: "DiabolicUICharacterStats14"
        anchors.left: diabolicUICharacterStats14.left
        anchors.verticalCenter: diabolicUICharacterStats14.verticalCenter
        width: 47.4
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats14Stat
        name: "DiabolicUICharacterStats14Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats14"
        anchors.right: diabolicUICharacterStats14.right
        anchors.verticalCenter: diabolicUICharacterStats14.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats14StatText
        name: "DiabolicUICharacterStats14StatText"
        kind: "FontString"
        wowParent: "DiabolicUICharacterStats14Stat"
        anchors.right: diabolicUICharacterStats14Stat.right
        anchors.verticalCenter: diabolicUICharacterStats14Stat.verticalCenter
        width: 20.5
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats15
        name: "DiabolicUICharacterStats15"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 316
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats15Label
        name: "DiabolicUICharacterStats15Label"
        kind: "FontString"
        text: "Spirit:"
        wowParent: "DiabolicUICharacterStats15"
        anchors.left: diabolicUICharacterStats15.left
        anchors.verticalCenter: diabolicUICharacterStats15.verticalCenter
        width: 32.4
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats15Stat
        name: "DiabolicUICharacterStats15Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats15"
        anchors.right: diabolicUICharacterStats15.right
        anchors.verticalCenter: diabolicUICharacterStats15.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats15StatText
        name: "DiabolicUICharacterStats15StatText"
        kind: "FontString"
        wowParent: "DiabolicUICharacterStats15Stat"
        anchors.right: diabolicUICharacterStats15Stat.right
        anchors.verticalCenter: diabolicUICharacterStats15Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats16
        name: "DiabolicUICharacterStats16"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 328
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats16Label
        name: "DiabolicUICharacterStats16Label"
        kind: "FontString"
        text: "Armor:"
        wowParent: "DiabolicUICharacterStats16"
        anchors.left: diabolicUICharacterStats16.left
        anchors.verticalCenter: diabolicUICharacterStats16.verticalCenter
        width: 37.1
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats16Stat
        name: "DiabolicUICharacterStats16Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats16"
        anchors.right: diabolicUICharacterStats16.right
        anchors.verticalCenter: diabolicUICharacterStats16.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats16StatText
        name: "DiabolicUICharacterStats16StatText"
        kind: "FontString"
        text: "2027"
        wowParent: "DiabolicUICharacterStats16Stat"
        anchors.right: diabolicUICharacterStats16Stat.right
        anchors.verticalCenter: diabolicUICharacterStats16Stat.verticalCenter
        width: 26.9
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats21
        name: "DiabolicUICharacterStats21"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 368
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats21Label
        name: "DiabolicUICharacterStats21Label"
        kind: "FontString"
        text: "Bonus Damage:"
        wowParent: "DiabolicUICharacterStats21"
        anchors.left: diabolicUICharacterStats21.left
        anchors.verticalCenter: diabolicUICharacterStats21.verticalCenter
        width: 84.5
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats21Stat
        name: "DiabolicUICharacterStats21Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats21"
        anchors.right: diabolicUICharacterStats21.right
        anchors.verticalCenter: diabolicUICharacterStats21.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats21StatText
        name: "DiabolicUICharacterStats21StatText"
        kind: "FontString"
        text: "1780"
        wowParent: "DiabolicUICharacterStats21Stat"
        anchors.right: diabolicUICharacterStats21Stat.right
        anchors.verticalCenter: diabolicUICharacterStats21Stat.verticalCenter
        width: 26.1
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats22
        name: "DiabolicUICharacterStats22"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 380
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats22Label
        name: "DiabolicUICharacterStats22Label"
        kind: "FontString"
        text: "Bonus Healing:"
        wowParent: "DiabolicUICharacterStats22"
        anchors.left: diabolicUICharacterStats22.left
        anchors.verticalCenter: diabolicUICharacterStats22.verticalCenter
        width: 81.4
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats22Stat
        name: "DiabolicUICharacterStats22Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats22"
        anchors.right: diabolicUICharacterStats22.right
        anchors.verticalCenter: diabolicUICharacterStats22.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats22StatText
        name: "DiabolicUICharacterStats22StatText"
        kind: "FontString"
        text: "1780"
        wowParent: "DiabolicUICharacterStats22Stat"
        anchors.right: diabolicUICharacterStats22Stat.right
        anchors.verticalCenter: diabolicUICharacterStats22Stat.verticalCenter
        width: 26.1
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats23
        name: "DiabolicUICharacterStats23"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 392
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats23Label
        name: "DiabolicUICharacterStats23Label"
        kind: "FontString"
        text: "Hit Rating:"
        wowParent: "DiabolicUICharacterStats23"
        anchors.left: diabolicUICharacterStats23.left
        anchors.verticalCenter: diabolicUICharacterStats23.verticalCenter
        width: 56.9
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats23Stat
        name: "DiabolicUICharacterStats23Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats23"
        anchors.right: diabolicUICharacterStats23.right
        anchors.verticalCenter: diabolicUICharacterStats23.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats23StatText
        name: "DiabolicUICharacterStats23StatText"
        kind: "FontString"
        text: "263"
        wowParent: "DiabolicUICharacterStats23Stat"
        anchors.right: diabolicUICharacterStats23Stat.right
        anchors.verticalCenter: diabolicUICharacterStats23Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats24
        name: "DiabolicUICharacterStats24"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 404
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats24Label
        name: "DiabolicUICharacterStats24Label"
        kind: "FontString"
        text: "Crit Chance:"
        wowParent: "DiabolicUICharacterStats24"
        anchors.left: diabolicUICharacterStats24.left
        anchors.verticalCenter: diabolicUICharacterStats24.verticalCenter
        width: 65.6
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats24Stat
        name: "DiabolicUICharacterStats24Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats24"
        anchors.right: diabolicUICharacterStats24.right
        anchors.verticalCenter: diabolicUICharacterStats24.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats24StatText
        name: "DiabolicUICharacterStats24StatText"
        kind: "FontString"
        text: "14.24%"
        wowParent: "DiabolicUICharacterStats24Stat"
        anchors.right: diabolicUICharacterStats24Stat.right
        anchors.verticalCenter: diabolicUICharacterStats24Stat.verticalCenter
        width: 39.5
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats25
        name: "DiabolicUICharacterStats25"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 416
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats25Label
        name: "DiabolicUICharacterStats25Label"
        kind: "FontString"
        text: "Haste Rating:"
        wowParent: "DiabolicUICharacterStats25"
        anchors.left: diabolicUICharacterStats25.left
        anchors.verticalCenter: diabolicUICharacterStats25.verticalCenter
        width: 71.9
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats25Stat
        name: "DiabolicUICharacterStats25Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats25"
        anchors.right: diabolicUICharacterStats25.right
        anchors.verticalCenter: diabolicUICharacterStats25.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats25StatText
        name: "DiabolicUICharacterStats25StatText"
        kind: "FontString"
        text: "413"
        wowParent: "DiabolicUICharacterStats25Stat"
        anchors.right: diabolicUICharacterStats25Stat.right
        anchors.verticalCenter: diabolicUICharacterStats25Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats26
        name: "DiabolicUICharacterStats26"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 436
        anchors.top: paperDollFrame.top
        anchors.topMargin: 428
        width: 144
        height: 13
    }

    Part {
        id: diabolicUICharacterStats26Label
        name: "DiabolicUICharacterStats26Label"
        kind: "FontString"
        text: "Mana Regen:"
        wowParent: "DiabolicUICharacterStats26"
        anchors.left: diabolicUICharacterStats26.left
        anchors.verticalCenter: diabolicUICharacterStats26.verticalCenter
        width: 70.3
        height: 10.3
    }

    Part {
        id: diabolicUICharacterStats26Stat
        name: "DiabolicUICharacterStats26Stat"
        kind: "Frame"
        wowParent: "DiabolicUICharacterStats26"
        anchors.right: diabolicUICharacterStats26.right
        anchors.verticalCenter: diabolicUICharacterStats26.verticalCenter
        width: 30
        height: 13
    }

    Part {
        id: diabolicUICharacterStats26StatText
        name: "DiabolicUICharacterStats26StatText"
        kind: "FontString"
        text: "345"
        wowParent: "DiabolicUICharacterStats26Stat"
        anchors.right: diabolicUICharacterStats26Stat.right
        anchors.verticalCenter: diabolicUICharacterStats26Stat.verticalCenter
        width: 19.8
        height: 10.3
    }

    Part {
        id: diabolicUICharacterTitles
        name: "DiabolicUICharacterTitles"
        kind: "ScrollFrame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 428
        anchors.top: paperDollFrame.top
        anchors.topMargin: 118
        width: 138
        height: 306
    }

    Part {
        id: diabolicUICharacterTitlesDiabolicParchment
        name: "DiabolicUICharacterTitlesDiabolicParchment"
        kind: "Frame"
        wowParent: "?"
        anchors.left: diabolicUICharacterTitles.left
        anchors.leftMargin: -4
        anchors.top: diabolicUICharacterTitles.top
        anchors.topMargin: -4
        width: 146
        height: 314
    }

    Part {
        id: diabolicUICharacterTitlesScrollBar
        name: "DiabolicUICharacterTitlesScrollBar"
        kind: "Slider"
        wowParent: "DiabolicUICharacterTitles"
        style: "ScrollBar"
        anchors.left: diabolicUICharacterTitles.right
        anchors.leftMargin: 6
        anchors.top: diabolicUICharacterTitles.top
        anchors.topMargin: 16
        width: 16
        height: 274
    }

    Part {
        id: diabolicUICharacterTitlesScrollBarDiabolicTrack
        name: "DiabolicUICharacterTitlesScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "DiabolicUICharacterTitlesScrollBar"
        anchors.horizontalCenter: diabolicUICharacterTitlesScrollBarScrollUpButton.horizontalCenter
        anchors.top: diabolicUICharacterTitlesScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 308
    }

    Part {
        id: diabolicUICharacterTitlesScrollBarScrollDownButton
        name: "DiabolicUICharacterTitlesScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "DiabolicUICharacterTitlesScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: diabolicUICharacterTitlesScrollBar.horizontalCenter
        anchors.top: diabolicUICharacterTitlesScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: diabolicUICharacterTitlesScrollBarScrollUpButton
        name: "DiabolicUICharacterTitlesScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "DiabolicUICharacterTitlesScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: diabolicUICharacterTitlesScrollBar.horizontalCenter
        anchors.bottom: diabolicUICharacterTitlesScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: factionMouseOver
        name: "FactionMouseOver"
        kind: "Frame"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrameFactionLabel.left
        anchors.top: reputationFrameFactionLabel.top
        width: 44.2
        height: 11.9
    }

    Part {
        id: gearManagerDialog
        name: "GearManagerDialog"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 428
        anchors.top: paperDollFrame.top
        anchors.topMargin: 134
        width: 160
        height: 151.5
    }

    Part {
        id: gearManagerDialogDeleteSet
        name: "GearManagerDialogDeleteSet"
        kind: "Button"
        wowParent: "GearManagerDialog"
        style: "Button"
        anchors.horizontalCenter: gearManagerDialogSaveSet.horizontalCenter
        anchors.top: gearManagerDialogSaveSet.bottom
        anchors.topMargin: 6
        width: 24
        height: 24
    }

    Part {
        id: gearManagerDialogDeleteSetText
        name: "GearManagerDialogDeleteSetText"
        kind: "FontString"
        wowParent: "GearManagerDialogDeleteSet"
        anchors.horizontalCenter: gearManagerDialogDeleteSet.horizontalCenter
        anchors.verticalCenter: gearManagerDialogDeleteSet.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: gearManagerDialogEquipSet
        name: "GearManagerDialogEquipSet"
        kind: "Button"
        wowParent: "GearManagerDialog"
        style: "Button"
        anchors.left: gearManagerDialog.left
        anchors.leftMargin: 127.9
        anchors.top: gearManagerDialog.top
        anchors.topMargin: 4
        width: 30
        height: 30
    }

    Part {
        id: gearManagerDialogEquipSetText
        name: "GearManagerDialogEquipSetText"
        kind: "FontString"
        wowParent: "GearManagerDialogEquipSet"
        anchors.horizontalCenter: gearManagerDialogEquipSet.horizontalCenter
        anchors.verticalCenter: gearManagerDialogEquipSet.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: gearManagerDialogPopup
        name: "GearManagerDialogPopup"
        kind: "Frame"
        wowParent: "GearManagerDialog"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: 6
        anchors.top: characterFrameDiabolic.top
        width: 297
        height: 298
    }

    Part {
        id: gearManagerDialogSaveSet
        name: "GearManagerDialogSaveSet"
        kind: "Button"
        wowParent: "GearManagerDialog"
        style: "Button"
        anchors.horizontalCenter: gearManagerDialogEquipSet.horizontalCenter
        anchors.top: gearManagerDialogEquipSet.bottom
        anchors.topMargin: 6
        width: 24
        height: 24
    }

    Part {
        id: gearManagerDialogSaveSetText
        name: "GearManagerDialogSaveSetText"
        kind: "FontString"
        wowParent: "GearManagerDialogSaveSet"
        anchors.horizontalCenter: gearManagerDialogSaveSet.horizontalCenter
        anchors.verticalCenter: gearManagerDialogSaveSet.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: gearSetButton1
        name: "GearSetButton1"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearManagerDialog.left
        anchors.top: gearManagerDialog.top
        anchors.topMargin: 8.4
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton10
        name: "GearSetButton10"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton9.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton9.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton10Name
        name: "GearSetButton10Name"
        kind: "FontString"
        wowParent: "GearSetButton10"
        anchors.horizontalCenter: gearSetButton10.horizontalCenter
        anchors.bottom: gearSetButton10.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton1Name
        name: "GearSetButton1Name"
        kind: "FontString"
        text: "holy"
        wowParent: "GearSetButton1"
        anchors.horizontalCenter: gearSetButton1.horizontalCenter
        anchors.bottom: gearSetButton1.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton2
        name: "GearSetButton2"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton1.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton1.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton2Name
        name: "GearSetButton2Name"
        kind: "FontString"
        text: "shadow"
        wowParent: "GearSetButton2"
        anchors.horizontalCenter: gearSetButton2.horizontalCenter
        anchors.bottom: gearSetButton2.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton3
        name: "GearSetButton3"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton2.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton2.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton3Name
        name: "GearSetButton3Name"
        kind: "FontString"
        wowParent: "GearSetButton3"
        anchors.horizontalCenter: gearSetButton3.horizontalCenter
        anchors.bottom: gearSetButton3.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton4
        name: "GearSetButton4"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.horizontalCenter: gearSetButton1.horizontalCenter
        anchors.top: gearSetButton1.bottom
        anchors.topMargin: 14
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton4Name
        name: "GearSetButton4Name"
        kind: "FontString"
        wowParent: "GearSetButton4"
        anchors.horizontalCenter: gearSetButton4.horizontalCenter
        anchors.bottom: gearSetButton4.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton5
        name: "GearSetButton5"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton4.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton4.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton5Name
        name: "GearSetButton5Name"
        kind: "FontString"
        wowParent: "GearSetButton5"
        anchors.horizontalCenter: gearSetButton5.horizontalCenter
        anchors.bottom: gearSetButton5.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton6
        name: "GearSetButton6"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton5.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton5.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton6Name
        name: "GearSetButton6Name"
        kind: "FontString"
        wowParent: "GearSetButton6"
        anchors.horizontalCenter: gearSetButton6.horizontalCenter
        anchors.bottom: gearSetButton6.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton7
        name: "GearSetButton7"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.horizontalCenter: gearSetButton4.horizontalCenter
        anchors.top: gearSetButton4.bottom
        anchors.topMargin: 14
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton7Name
        name: "GearSetButton7Name"
        kind: "FontString"
        wowParent: "GearSetButton7"
        anchors.horizontalCenter: gearSetButton7.horizontalCenter
        anchors.bottom: gearSetButton7.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton8
        name: "GearSetButton8"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton7.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton7.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton8Name
        name: "GearSetButton8Name"
        kind: "FontString"
        wowParent: "GearSetButton8"
        anchors.horizontalCenter: gearSetButton8.horizontalCenter
        anchors.bottom: gearSetButton8.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: gearSetButton9
        name: "GearSetButton9"
        kind: "CheckButton"
        wowParent: "GearManagerDialog"
        anchors.left: gearSetButton8.right
        anchors.leftMargin: 8
        anchors.verticalCenter: gearSetButton8.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: gearSetButton9Name
        name: "GearSetButton9Name"
        kind: "FontString"
        wowParent: "GearSetButton9"
        anchors.horizontalCenter: gearSetButton9.horizontalCenter
        anchors.bottom: gearSetButton9.bottom
        anchors.bottomMargin: 2
        width: 34.3
        height: 9.5
    }

    Part {
        id: magicResFrame1
        name: "MagicResFrame1"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 443.6
        anchors.top: paperDollFrame.top
        anchors.topMargin: 181.7
        width: 26
        height: 26
    }

    Part {
        id: magicResFrame2
        name: "MagicResFrame2"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 526.7
        anchors.top: paperDollFrame.top
        anchors.topMargin: 121.3
        width: 26
        height: 26
    }

    Part {
        id: magicResFrame3
        name: "MagicResFrame3"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 463.3
        anchors.top: paperDollFrame.top
        anchors.topMargin: 121.3
        width: 26
        height: 26
    }

    Part {
        id: magicResFrame4
        name: "MagicResFrame4"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 546.4
        anchors.top: paperDollFrame.top
        anchors.topMargin: 181.7
        width: 26
        height: 26
    }

    Part {
        id: magicResFrame5
        name: "MagicResFrame5"
        kind: "Frame"
        wowParent: "?"
        anchors.left: paperDollFrame.left
        anchors.leftMargin: 495
        anchors.top: paperDollFrame.top
        anchors.topMargin: 219
        width: 26
        height: 26
    }

    Part {
        id: magicResText1
        name: "MagicResText1"
        kind: "FontString"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame1.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame1.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    Part {
        id: magicResText2
        name: "MagicResText2"
        kind: "FontString"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame2.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame2.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    Part {
        id: magicResText3
        name: "MagicResText3"
        kind: "FontString"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame3.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame3.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    Part {
        id: magicResText4
        name: "MagicResText4"
        kind: "FontString"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame4.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame4.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    Part {
        id: magicResText5
        name: "MagicResText5"
        kind: "FontString"
        text: "0"
        wowParent: "?"
        anchors.right: magicResFrame5.right
        anchors.rightMargin: 2
        anchors.bottom: magicResFrame5.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 10.3
    }

    Part {
        id: paperDollFrame
        name: "PaperDollFrame"
        kind: "Frame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.top: characterFrame.top
        width: 384
        height: 512
    }

    Part {
        id: reputationBar1
        name: "ReputationBar1"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationFrame.right
        anchors.rightMargin: 70
        anchors.top: reputationFrame.top
        anchors.topMargin: 83
        width: 294
        height: 20
    }

    Part {
        id: reputationBar10
        name: "ReputationBar10"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar9.right
        anchors.top: reputationBar9.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar10ExpandOrCollapseButton
        name: "ReputationBar10ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar10"
        anchors.left: reputationBar10.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar10.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar10FactionName
        name: "ReputationBar10FactionName"
        kind: "FontString"
        text: "Zandalar Tribe"
        wowParent: "ReputationBar10"
        anchors.left: reputationBar10.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar10.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar10ReputationBar
        name: "ReputationBar10ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar10"
        anchors.right: reputationBar10.right
        anchors.verticalCenter: reputationBar10.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar10ReputationBarFactionStanding
        name: "ReputationBar10ReputationBarFactionStanding"
        kind: "FontString"
        text: "Neutral"
        wowParent: "ReputationBar10ReputationBar"
        anchors.horizontalCenter: reputationBar10ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar10ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Part {
        id: reputationBar11
        name: "ReputationBar11"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar10.right
        anchors.top: reputationBar10.bottom
        anchors.topMargin: 3
        width: 275
        height: 20
    }

    Part {
        id: reputationBar11ExpandOrCollapseButton
        name: "ReputationBar11ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar11"
        anchors.left: reputationBar11.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar11.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar11FactionName
        name: "ReputationBar11FactionName"
        kind: "FontString"
        text: "Alliance"
        wowParent: "ReputationBar11"
        anchors.left: reputationBar11ExpandOrCollapseButton.right
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar11ExpandOrCollapseButton.verticalCenter
        width: 135
        height: 10
    }

    Part {
        id: reputationBar11ReputationBar
        name: "ReputationBar11ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar11"
        anchors.right: reputationBar11.right
        anchors.verticalCenter: reputationBar11.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar11ReputationBarFactionStanding
        name: "ReputationBar11ReputationBarFactionStanding"
        kind: "FontString"
        text: "Hated"
        wowParent: "ReputationBar11ReputationBar"
        anchors.horizontalCenter: reputationBar11ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar11ReputationBar.verticalCenter
        width: 33.2
        height: 10.3
    }

    Part {
        id: reputationBar12
        name: "ReputationBar12"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar11.right
        anchors.top: reputationBar11.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Part {
        id: reputationBar12ExpandOrCollapseButton
        name: "ReputationBar12ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar12"
        anchors.left: reputationBar12.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar12.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar12FactionName
        name: "ReputationBar12FactionName"
        kind: "FontString"
        text: "Darnassus"
        wowParent: "ReputationBar12"
        anchors.left: reputationBar12.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar12.verticalCenter
        width: 150
        height: 10
    }

    Part {
        id: reputationBar12ReputationBar
        name: "ReputationBar12ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar12"
        anchors.right: reputationBar12.right
        anchors.verticalCenter: reputationBar12.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar12ReputationBarFactionStanding
        name: "ReputationBar12ReputationBarFactionStanding"
        kind: "FontString"
        text: "Exalted"
        wowParent: "ReputationBar12ReputationBar"
        anchors.horizontalCenter: reputationBar12ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar12ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Part {
        id: reputationBar13
        name: "ReputationBar13"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar12.right
        anchors.top: reputationBar12.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Part {
        id: reputationBar13ExpandOrCollapseButton
        name: "ReputationBar13ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar13"
        anchors.left: reputationBar13.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar13.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar13FactionName
        name: "ReputationBar13FactionName"
        kind: "FontString"
        text: "Exodar"
        wowParent: "ReputationBar13"
        anchors.left: reputationBar13.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar13.verticalCenter
        width: 150
        height: 10
    }

    Part {
        id: reputationBar13ReputationBar
        name: "ReputationBar13ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar13"
        anchors.right: reputationBar13.right
        anchors.verticalCenter: reputationBar13.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar13ReputationBarFactionStanding
        name: "ReputationBar13ReputationBarFactionStanding"
        kind: "FontString"
        text: "Exalted"
        wowParent: "ReputationBar13ReputationBar"
        anchors.horizontalCenter: reputationBar13ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar13ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Part {
        id: reputationBar14
        name: "ReputationBar14"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar13.right
        anchors.top: reputationBar13.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Part {
        id: reputationBar14FactionName
        name: "ReputationBar14FactionName"
        kind: "FontString"
        text: "Gnomeregan Exiles"
        wowParent: "ReputationBar14"
        anchors.left: reputationBar14.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar14.verticalCenter
        width: 150
        height: 10
    }

    Part {
        id: reputationBar14ReputationBar
        name: "ReputationBar14ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar14"
        anchors.right: reputationBar14.right
        anchors.verticalCenter: reputationBar14.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar14ReputationBarFactionStanding
        name: "ReputationBar14ReputationBarFactionStanding"
        kind: "FontString"
        text: "Exalted"
        wowParent: "ReputationBar14ReputationBar"
        anchors.horizontalCenter: reputationBar14ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar14ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Part {
        id: reputationBar15
        name: "ReputationBar15"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar14.right
        anchors.top: reputationBar14.bottom
        anchors.topMargin: 3
        width: 252
        height: 20
    }

    Part {
        id: reputationBar15ExpandOrCollapseButton
        name: "ReputationBar15ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar15"
        anchors.left: reputationBar15.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar15.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar15FactionName
        name: "ReputationBar15FactionName"
        kind: "FontString"
        text: "Ironforge"
        wowParent: "ReputationBar15"
        anchors.left: reputationBar15.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar15.verticalCenter
        width: 150
        height: 10
    }

    Part {
        id: reputationBar15ReputationBar
        name: "ReputationBar15ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar15"
        anchors.right: reputationBar15.right
        anchors.verticalCenter: reputationBar15.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar15ReputationBarFactionStanding
        name: "ReputationBar15ReputationBarFactionStanding"
        kind: "FontString"
        text: "Exalted"
        wowParent: "ReputationBar15ReputationBar"
        anchors.horizontalCenter: reputationBar15ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar15ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Part {
        id: reputationBar1ExpandOrCollapseButton
        name: "ReputationBar1ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar1"
        anchors.left: reputationBar1.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar1.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar1FactionName
        name: "ReputationBar1FactionName"
        kind: "FontString"
        text: "Classic"
        wowParent: "ReputationBar1"
        anchors.left: reputationBar1ExpandOrCollapseButton.right
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar1ExpandOrCollapseButton.verticalCenter
        width: 145
        height: 10
    }

    Part {
        id: reputationBar1ReputationBar
        name: "ReputationBar1ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar1"
        anchors.right: reputationBar1.right
        anchors.verticalCenter: reputationBar1.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar1ReputationBarFactionStanding
        name: "ReputationBar1ReputationBarFactionStanding"
        kind: "FontString"
        text: "Exalted"
        wowParent: "ReputationBar1ReputationBar"
        anchors.horizontalCenter: reputationBar1ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar1ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Part {
        id: reputationBar2
        name: "ReputationBar2"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar1.right
        anchors.top: reputationBar1.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar2FactionName
        name: "ReputationBar2FactionName"
        kind: "FontString"
        text: "Argent Dawn"
        wowParent: "ReputationBar2"
        anchors.left: reputationBar2.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar2.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar2ReputationBar
        name: "ReputationBar2ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar2"
        anchors.right: reputationBar2.right
        anchors.verticalCenter: reputationBar2.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar2ReputationBarFactionStanding
        name: "ReputationBar2ReputationBarFactionStanding"
        kind: "FontString"
        text: "Revered"
        wowParent: "ReputationBar2ReputationBar"
        anchors.horizontalCenter: reputationBar2ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar2ReputationBar.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: reputationBar3
        name: "ReputationBar3"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar2.right
        anchors.top: reputationBar2.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar3ExpandOrCollapseButton
        name: "ReputationBar3ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar3"
        anchors.left: reputationBar3.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar3.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar3FactionName
        name: "ReputationBar3FactionName"
        kind: "FontString"
        text: "Bloodsail Buccaneers"
        wowParent: "ReputationBar3"
        anchors.left: reputationBar3.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar3.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar3ReputationBar
        name: "ReputationBar3ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar3"
        anchors.right: reputationBar3.right
        anchors.verticalCenter: reputationBar3.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar3ReputationBarFactionStanding
        name: "ReputationBar3ReputationBarFactionStanding"
        kind: "FontString"
        text: "Honored"
        wowParent: "ReputationBar3ReputationBar"
        anchors.horizontalCenter: reputationBar3ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar3ReputationBar.verticalCenter
        width: 47.4
        height: 10.3
    }

    Part {
        id: reputationBar4
        name: "ReputationBar4"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar3.right
        anchors.top: reputationBar3.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar4ExpandOrCollapseButton
        name: "ReputationBar4ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar4"
        anchors.left: reputationBar4.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar4.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar4FactionName
        name: "ReputationBar4FactionName"
        kind: "FontString"
        text: "Cenarion Circle"
        wowParent: "ReputationBar4"
        anchors.left: reputationBar4.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar4.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar4ReputationBar
        name: "ReputationBar4ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar4"
        anchors.right: reputationBar4.right
        anchors.verticalCenter: reputationBar4.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar4ReputationBarFactionStanding
        name: "ReputationBar4ReputationBarFactionStanding"
        kind: "FontString"
        text: "Neutral"
        wowParent: "ReputationBar4ReputationBar"
        anchors.horizontalCenter: reputationBar4ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar4ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Part {
        id: reputationBar5
        name: "ReputationBar5"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar4.right
        anchors.top: reputationBar4.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar5ExpandOrCollapseButton
        name: "ReputationBar5ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar5"
        anchors.left: reputationBar5.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar5.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar5FactionName
        name: "ReputationBar5FactionName"
        kind: "FontString"
        text: "Darkmoon Faire"
        wowParent: "ReputationBar5"
        anchors.left: reputationBar5.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar5.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar5ReputationBar
        name: "ReputationBar5ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar5"
        anchors.right: reputationBar5.right
        anchors.verticalCenter: reputationBar5.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar5ReputationBarFactionStanding
        name: "ReputationBar5ReputationBarFactionStanding"
        kind: "FontString"
        text: "Neutral"
        wowParent: "ReputationBar5ReputationBar"
        anchors.horizontalCenter: reputationBar5ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar5ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Part {
        id: reputationBar6
        name: "ReputationBar6"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar5.right
        anchors.top: reputationBar5.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar6FactionName
        name: "ReputationBar6FactionName"
        kind: "FontString"
        text: "Hydraxian Waterlords"
        wowParent: "ReputationBar6"
        anchors.left: reputationBar6.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar6.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar6ReputationBar
        name: "ReputationBar6ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar6"
        anchors.right: reputationBar6.right
        anchors.verticalCenter: reputationBar6.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar6ReputationBarFactionStanding
        name: "ReputationBar6ReputationBarFactionStanding"
        kind: "FontString"
        text: "Friendly"
        wowParent: "ReputationBar6ReputationBar"
        anchors.horizontalCenter: reputationBar6ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar6ReputationBar.verticalCenter
        width: 43.5
        height: 10.3
    }

    Part {
        id: reputationBar7
        name: "ReputationBar7"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar6.right
        anchors.top: reputationBar6.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar7FactionName
        name: "ReputationBar7FactionName"
        kind: "FontString"
        text: "Ravenholdt"
        wowParent: "ReputationBar7"
        anchors.left: reputationBar7.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar7.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar7ReputationBar
        name: "ReputationBar7ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar7"
        anchors.right: reputationBar7.right
        anchors.verticalCenter: reputationBar7.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar7ReputationBarFactionStanding
        name: "ReputationBar7ReputationBarFactionStanding"
        kind: "FontString"
        text: "Neutral"
        wowParent: "ReputationBar7ReputationBar"
        anchors.horizontalCenter: reputationBar7ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar7ReputationBar.verticalCenter
        width: 39.5
        height: 10.3
    }

    Part {
        id: reputationBar8
        name: "ReputationBar8"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar7.right
        anchors.top: reputationBar7.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar8ExpandOrCollapseButton
        name: "ReputationBar8ExpandOrCollapseButton"
        kind: "Button"
        wowParent: "ReputationBar8"
        anchors.left: reputationBar8.left
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationBar8.verticalCenter
        width: 13
        height: 13
    }

    Part {
        id: reputationBar8FactionName
        name: "ReputationBar8FactionName"
        kind: "FontString"
        text: "Thorium Brotherhood"
        wowParent: "ReputationBar8"
        anchors.left: reputationBar8.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar8.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar8ReputationBar
        name: "ReputationBar8ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar8"
        anchors.right: reputationBar8.right
        anchors.verticalCenter: reputationBar8.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar8ReputationBarFactionStanding
        name: "ReputationBar8ReputationBarFactionStanding"
        kind: "FontString"
        text: "Revered"
        wowParent: "ReputationBar8ReputationBar"
        anchors.horizontalCenter: reputationBar8ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar8ReputationBar.verticalCenter
        width: 44.2
        height: 10.3
    }

    Part {
        id: reputationBar9
        name: "ReputationBar9"
        kind: "Button"
        wowParent: "ReputationFrame"
        anchors.right: reputationBar8.right
        anchors.top: reputationBar8.bottom
        anchors.topMargin: 3
        width: 270
        height: 20
    }

    Part {
        id: reputationBar9FactionName
        name: "ReputationBar9FactionName"
        kind: "FontString"
        text: "Timbermaw Hold"
        wowParent: "ReputationBar9"
        anchors.left: reputationBar9.left
        anchors.leftMargin: 10
        anchors.verticalCenter: reputationBar9.verticalCenter
        width: 160
        height: 10
    }

    Part {
        id: reputationBar9ReputationBar
        name: "ReputationBar9ReputationBar"
        kind: "StatusBar"
        wowParent: "ReputationBar9"
        anchors.right: reputationBar9.right
        anchors.verticalCenter: reputationBar9.verticalCenter
        width: 101
        height: 13
    }

    Part {
        id: reputationBar9ReputationBarFactionStanding
        name: "ReputationBar9ReputationBarFactionStanding"
        kind: "FontString"
        text: "Exalted"
        wowParent: "ReputationBar9ReputationBar"
        anchors.horizontalCenter: reputationBar9ReputationBar.horizontalCenter
        anchors.verticalCenter: reputationBar9ReputationBar.verticalCenter
        width: 40.3
        height: 10.3
    }

    Part {
        id: reputationDetailAtWarCheckBox
        name: "ReputationDetailAtWarCheckBox"
        kind: "CheckButton"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailFrame.left
        anchors.leftMargin: 14
        anchors.bottom: reputationDetailFrame.bottom
        anchors.bottomMargin: 34
        width: 26
        height: 26
    }

    Part {
        id: reputationDetailAtWarCheckBoxText
        name: "ReputationDetailAtWarCheckBoxText"
        kind: "FontString"
        text: "At War"
        wowParent: "ReputationDetailAtWarCheckBox"
        anchors.left: reputationDetailAtWarCheckBox.right
        anchors.leftMargin: -2
        anchors.verticalCenter: reputationDetailAtWarCheckBox.verticalCenter
        width: 37.9
        height: 10.3
    }

    Part {
        id: reputationDetailCloseButton
        name: "ReputationDetailCloseButton"
        kind: "Button"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailFrame.left
        anchors.leftMargin: 230
        anchors.top: reputationDetailFrame.top
        anchors.topMargin: -2.7
        width: 22
        height: 22
    }

    Part {
        id: reputationDetailFactionDescription
        name: "ReputationDetailFactionDescription"
        kind: "FontString"
        text: "This small group of reclusive night elves raises and trains wintersabers in the Winterspring area."
        wowParent: "ReputationDetailFrame"
        anchors.horizontalCenter: reputationDetailFactionName.horizontalCenter
        anchors.top: reputationDetailFactionName.bottom
        anchors.topMargin: 20
        width: 218
        height: 50.6
    }

    Part {
        id: reputationDetailFactionName
        name: "ReputationDetailFactionName"
        kind: "FontString"
        text: "Wintersaber Trainers"
        wowParent: "?"
        anchors.horizontalCenter: reputationDetailFrame.horizontalCenter
        anchors.top: reputationDetailFrame.top
        anchors.topMargin: 2
        width: 188
        height: 12.6
    }

    Part {
        id: reputationDetailFrame
        name: "ReputationDetailFrame"
        kind: "Frame"
        wowParent: "ReputationFrame"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: -8
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 96
        width: 260
        height: 203
    }

    Part {
        id: reputationDetailInactiveCheckBox
        name: "ReputationDetailInactiveCheckBox"
        kind: "CheckButton"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailAtWarCheckBoxText.right
        anchors.leftMargin: 3
        anchors.verticalCenter: reputationDetailAtWarCheckBoxText.verticalCenter
        width: 26
        height: 26
    }

    Part {
        id: reputationDetailInactiveCheckBoxText
        name: "ReputationDetailInactiveCheckBoxText"
        kind: "FontString"
        text: "Move to Inactive"
        wowParent: "ReputationDetailInactiveCheckBox"
        anchors.left: reputationDetailInactiveCheckBox.right
        anchors.verticalCenter: reputationDetailInactiveCheckBox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 90.9
        height: 10.3
    }

    Part {
        id: reputationDetailMainScreenCheckBox
        name: "ReputationDetailMainScreenCheckBox"
        kind: "CheckButton"
        wowParent: "ReputationDetailFrame"
        anchors.left: reputationDetailAtWarCheckBox.left
        anchors.top: reputationDetailAtWarCheckBox.bottom
        anchors.topMargin: -3
        width: 26
        height: 26
    }

    Part {
        id: reputationDetailMainScreenCheckBoxText
        name: "ReputationDetailMainScreenCheckBoxText"
        kind: "FontString"
        text: "Show as Experience Bar"
        wowParent: "ReputationDetailMainScreenCheckBox"
        anchors.left: reputationDetailMainScreenCheckBox.right
        anchors.verticalCenter: reputationDetailMainScreenCheckBox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 126.4
        height: 10.3
    }

    Part {
        id: reputationFrame
        name: "ReputationFrame"
        kind: "Frame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.leftMargin: 19
        anchors.top: characterFrame.top
        anchors.topMargin: 20
        width: 384
        height: 512
    }

    Part {
        id: reputationFrameFactionLabel
        name: "ReputationFrameFactionLabel"
        kind: "FontString"
        text: "Faction"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrame.left
        anchors.leftMargin: 70
        anchors.top: reputationFrame.top
        anchors.topMargin: 57
        width: 44.2
        height: 11.9
    }

    Part {
        id: reputationFrameStandingLabel
        name: "ReputationFrameStandingLabel"
        kind: "FontString"
        text: "Standing"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrame.left
        anchors.leftMargin: 215
        anchors.top: reputationFrame.top
        anchors.topMargin: 59
        width: 53.7
        height: 11.9
    }

    Part {
        id: reputationListScrollFrame
        name: "ReputationListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "ReputationFrame"
        anchors.right: reputationFrame.right
        anchors.rightMargin: 66
        anchors.top: reputationFrame.top
        anchors.topMargin: 76
        width: 296
        height: 354
    }

    Part {
        id: reputationListScrollFrameScrollBar
        name: "ReputationListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "ReputationListScrollFrame"
        style: "ScrollBar"
        anchors.left: reputationListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: reputationListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 322
    }

    Part {
        id: reputationListScrollFrameScrollBarDiabolicTrack
        name: "ReputationListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "ReputationListScrollFrameScrollBar"
        anchors.horizontalCenter: reputationListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: reputationListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 356
    }

    Part {
        id: reputationListScrollFrameScrollBarScrollDownButton
        name: "ReputationListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "ReputationListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: reputationListScrollFrameScrollBar.horizontalCenter
        anchors.top: reputationListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: reputationListScrollFrameScrollBarScrollUpButton
        name: "ReputationListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "ReputationListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: reputationListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: reputationListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: reputationListScrollFrameScrollChildFrame
        name: "ReputationListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "ReputationListScrollFrame"
        anchors.left: reputationListScrollFrame.left
        anchors.top: reputationListScrollFrame.top
        width: 300
        height: 1586
    }

    Part {
        id: skillDetailDescriptionText
        name: "SkillDetailDescriptionText"
        kind: "FontString"
        wowParent: "SkillDetailScrollChildFrame"
        anchors.horizontalCenter: skillDetailCostText.horizontalCenter
        anchors.top: skillDetailCostText.top
        width: 275
        height: 41.1
    }

    Part {
        id: skillDetailScrollChildFrame
        name: "SkillDetailScrollChildFrame"
        kind: "Frame"
        wowParent: "SkillDetailScrollFrame"
        anchors.left: skillDetailScrollFrame.left
        anchors.top: skillDetailScrollFrame.top
        width: 320
        height: 50
    }

    Part {
        id: skillDetailScrollFrame
        name: "SkillDetailScrollFrame"
        kind: "ScrollFrame"
        wowParent: "SkillFrame"
        anchors.left: skillListScrollFrame.left
        anchors.top: skillListScrollFrame.bottom
        anchors.topMargin: 8
        width: 296
        height: 107
    }

    Part {
        id: skillDetailStatusBar
        name: "SkillDetailStatusBar"
        kind: "StatusBar"
        wowParent: "SkillDetailScrollChildFrame"
        anchors.horizontalCenter: skillDetailScrollChildFrame.horizontalCenter
        anchors.horizontalCenterOffset: -10
        anchors.verticalCenter: skillDetailScrollChildFrame.top
        anchors.verticalCenterOffset: 20
        width: 211
        height: 15
    }

    Part {
        id: skillDetailStatusBarSkillName
        name: "SkillDetailStatusBarSkillName"
        kind: "FontString"
        text: "First Aid"
        wowParent: "SkillDetailStatusBar"
        anchors.left: skillDetailStatusBar.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillDetailStatusBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 44.2
        height: 10.3
    }

    Part {
        id: skillDetailStatusBarSkillRank
        name: "SkillDetailStatusBarSkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "SkillDetailStatusBar"
        anchors.left: skillDetailStatusBarSkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillDetailStatusBarSkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillFrame
        name: "SkillFrame"
        kind: "Frame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.leftMargin: 19
        anchors.top: characterFrame.top
        anchors.topMargin: 20
        width: 384
        height: 512
    }

    Part {
        id: skillFrameCollapseAllButton
        name: "SkillFrameCollapseAllButton"
        kind: "Button"
        text: "All"
        wowParent: "SkillFrameExpandButtonFrame"
        anchors.left: skillFrameExpandTabLeft.right
        anchors.leftMargin: -3
        anchors.verticalCenter: skillFrameExpandTabLeft.verticalCenter
        anchors.verticalCenterOffset: 3
        width: 40
        height: 22
    }

    Part {
        id: skillFrameExpandButtonFrame
        name: "SkillFrameExpandButtonFrame"
        kind: "Frame"
        wowParent: "SkillFrame"
        anchors.left: skillFrame.left
        anchors.leftMargin: 70
        anchors.top: skillFrame.top
        anchors.topMargin: 49
        width: 62.8
        height: 32
    }

    Part {
        id: skillListScrollFrame
        name: "SkillListScrollFrame"
        kind: "ScrollFrame"
        wowParent: "SkillFrame"
        anchors.right: skillFrame.right
        anchors.rightMargin: 67
        anchors.top: skillFrame.top
        anchors.topMargin: 75
        width: 296
        height: 220
    }

    Part {
        id: skillListScrollFrameScrollBar
        name: "SkillListScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "SkillListScrollFrame"
        style: "ScrollBar"
        anchors.left: skillListScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: skillListScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 188
    }

    Part {
        id: skillListScrollFrameScrollBarDiabolicTrack
        name: "SkillListScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "SkillListScrollFrameScrollBar"
        anchors.horizontalCenter: skillListScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: skillListScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 222
    }

    Part {
        id: skillListScrollFrameScrollBarScrollDownButton
        name: "SkillListScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "SkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: skillListScrollFrameScrollBar.horizontalCenter
        anchors.top: skillListScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: skillListScrollFrameScrollBarScrollUpButton
        name: "SkillListScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "SkillListScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: skillListScrollFrameScrollBar.horizontalCenter
        anchors.bottom: skillListScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: skillListScrollFrameScrollChildFrame
        name: "SkillListScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "SkillListScrollFrame"
        anchors.left: skillListScrollFrame.left
        anchors.top: skillListScrollFrame.top
        width: 300
        height: 360
    }

    Part {
        id: skillRankFrame10
        name: "SkillRankFrame10"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame9.left
        anchors.top: skillRankFrame9.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame10Border
        name: "SkillRankFrame10Border"
        kind: "Button"
        wowParent: "SkillRankFrame10"
        anchors.left: skillRankFrame10.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame10.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame10SkillName
        name: "SkillRankFrame10SkillName"
        kind: "FontString"
        text: "First Aid"
        wowParent: "SkillRankFrame10"
        anchors.left: skillRankFrame10.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame10.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 44.2
        height: 10.3
    }

    Part {
        id: skillRankFrame10SkillRank
        name: "SkillRankFrame10SkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "SkillRankFrame10"
        anchors.left: skillRankFrame10SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame10SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillRankFrame11
        name: "SkillRankFrame11"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame10.left
        anchors.top: skillRankFrame10.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame11Border
        name: "SkillRankFrame11Border"
        kind: "Button"
        wowParent: "SkillRankFrame11"
        anchors.left: skillRankFrame11.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame11.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame11SkillName
        name: "SkillRankFrame11SkillName"
        kind: "FontString"
        text: "Fishing"
        wowParent: "SkillRankFrame11"
        anchors.left: skillRankFrame11.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame11.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.7
        height: 10.3
    }

    Part {
        id: skillRankFrame11SkillRank
        name: "SkillRankFrame11SkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "SkillRankFrame11"
        anchors.left: skillRankFrame11SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame11SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillRankFrame12
        name: "SkillRankFrame12"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame11.left
        anchors.top: skillRankFrame11.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame12Border
        name: "SkillRankFrame12Border"
        kind: "Button"
        wowParent: "SkillRankFrame12"
        anchors.left: skillRankFrame12.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame12.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame12SkillName
        name: "SkillRankFrame12SkillName"
        kind: "FontString"
        text: "Riding"
        wowParent: "SkillRankFrame12"
        anchors.left: skillRankFrame12.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame12.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 35.6
        height: 10.3
    }

    Part {
        id: skillRankFrame12SkillRank
        name: "SkillRankFrame12SkillRank"
        kind: "FontString"
        text: "300/300"
        wowParent: "SkillRankFrame12"
        anchors.left: skillRankFrame12SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame12SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillRankFrame2
        name: "SkillRankFrame2"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame1.left
        anchors.top: skillRankFrame1.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame2Border
        name: "SkillRankFrame2Border"
        kind: "Button"
        wowParent: "SkillRankFrame2"
        anchors.left: skillRankFrame2.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame2.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame2SkillName
        name: "SkillRankFrame2SkillName"
        kind: "FontString"
        text: "Discipline"
        wowParent: "SkillRankFrame2"
        anchors.left: skillRankFrame2.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 52.9
        height: 10.3
    }

    Part {
        id: skillRankFrame2SkillRank
        name: "SkillRankFrame2SkillRank"
        kind: "FontString"
        wowParent: "SkillRankFrame2"
        anchors.left: skillRankFrame2SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame2SkillName.verticalCenter
        width: 128
        height: 1
    }

    Part {
        id: skillRankFrame3
        name: "SkillRankFrame3"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame2.left
        anchors.top: skillRankFrame2.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame3Border
        name: "SkillRankFrame3Border"
        kind: "Button"
        wowParent: "SkillRankFrame3"
        anchors.left: skillRankFrame3.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame3.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame3SkillName
        name: "SkillRankFrame3SkillName"
        kind: "FontString"
        text: "Holy"
        wowParent: "SkillRankFrame3"
        anchors.left: skillRankFrame3.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 26.9
        height: 10.3
    }

    Part {
        id: skillRankFrame3SkillRank
        name: "SkillRankFrame3SkillRank"
        kind: "FontString"
        wowParent: "SkillRankFrame3"
        anchors.left: skillRankFrame3SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame3SkillName.verticalCenter
        width: 128
        height: 1
    }

    Part {
        id: skillRankFrame4
        name: "SkillRankFrame4"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame3.left
        anchors.top: skillRankFrame3.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame4Border
        name: "SkillRankFrame4Border"
        kind: "Button"
        wowParent: "SkillRankFrame4"
        anchors.left: skillRankFrame4.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame4.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame4SkillName
        name: "SkillRankFrame4SkillName"
        kind: "FontString"
        text: "Shadow Magic"
        wowParent: "SkillRankFrame4"
        anchors.left: skillRankFrame4.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame4.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 79.8
        height: 10.3
    }

    Part {
        id: skillRankFrame4SkillRank
        name: "SkillRankFrame4SkillRank"
        kind: "FontString"
        wowParent: "SkillRankFrame4"
        anchors.left: skillRankFrame4SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame4SkillName.verticalCenter
        width: 128
        height: 1
    }

    Part {
        id: skillRankFrame5
        name: "SkillRankFrame5"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame4.left
        anchors.top: skillRankFrame4.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame5Border
        name: "SkillRankFrame5Border"
        kind: "Button"
        wowParent: "SkillRankFrame5"
        anchors.left: skillRankFrame5.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame5.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame5SkillName
        name: "SkillRankFrame5SkillName"
        kind: "FontString"
        text: "Unholy"
        wowParent: "SkillRankFrame5"
        anchors.left: skillRankFrame5.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame5.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.7
        height: 10.3
    }

    Part {
        id: skillRankFrame5SkillRank
        name: "SkillRankFrame5SkillRank"
        kind: "FontString"
        wowParent: "SkillRankFrame5"
        anchors.left: skillRankFrame5SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame5SkillName.verticalCenter
        width: 128
        height: 1
    }

    Part {
        id: skillRankFrame6
        name: "SkillRankFrame6"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame5.left
        anchors.top: skillRankFrame5.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame6Border
        name: "SkillRankFrame6Border"
        kind: "Button"
        wowParent: "SkillRankFrame6"
        anchors.left: skillRankFrame6.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame6.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame6SkillName
        name: "SkillRankFrame6SkillName"
        kind: "FontString"
        text: "Enchanting"
        wowParent: "SkillRankFrame6"
        anchors.left: skillRankFrame6.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame6.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 59.3
        height: 10.3
    }

    Part {
        id: skillRankFrame6SkillRank
        name: "SkillRankFrame6SkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "SkillRankFrame6"
        anchors.left: skillRankFrame6SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame6SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillRankFrame7
        name: "SkillRankFrame7"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame6.left
        anchors.top: skillRankFrame6.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame7Border
        name: "SkillRankFrame7Border"
        kind: "Button"
        wowParent: "SkillRankFrame7"
        anchors.left: skillRankFrame7.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame7.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame7SkillName
        name: "SkillRankFrame7SkillName"
        kind: "FontString"
        text: "Tailoring"
        wowParent: "SkillRankFrame7"
        anchors.left: skillRankFrame7.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame7.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 48.2
        height: 10.3
    }

    Part {
        id: skillRankFrame7SkillRank
        name: "SkillRankFrame7SkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "SkillRankFrame7"
        anchors.left: skillRankFrame7SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame7SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillRankFrame8
        name: "SkillRankFrame8"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame7.left
        anchors.top: skillRankFrame7.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame8Border
        name: "SkillRankFrame8Border"
        kind: "Button"
        wowParent: "SkillRankFrame8"
        anchors.left: skillRankFrame8.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame8.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame8SkillName
        name: "SkillRankFrame8SkillName"
        kind: "FontString"
        text: "Riding"
        wowParent: "SkillRankFrame8"
        anchors.left: skillRankFrame8.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame8.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 35.6
        height: 10.3
    }

    Part {
        id: skillRankFrame8SkillRank
        name: "SkillRankFrame8SkillRank"
        kind: "FontString"
        text: "150/150"
        wowParent: "SkillRankFrame8"
        anchors.left: skillRankFrame8SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame8SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillRankFrame9
        name: "SkillRankFrame9"
        kind: "StatusBar"
        wowParent: "SkillFrame"
        anchors.left: skillRankFrame8.left
        anchors.top: skillRankFrame8.bottom
        anchors.topMargin: 3
        width: 271
        height: 15
    }

    Part {
        id: skillRankFrame9Border
        name: "SkillRankFrame9Border"
        kind: "Button"
        wowParent: "SkillRankFrame9"
        anchors.left: skillRankFrame9.left
        anchors.leftMargin: -5
        anchors.verticalCenter: skillRankFrame9.verticalCenter
        width: 281
        height: 32
    }

    Part {
        id: skillRankFrame9SkillName
        name: "SkillRankFrame9SkillName"
        kind: "FontString"
        text: "Cooking"
        wowParent: "SkillRankFrame9"
        anchors.left: skillRankFrame9.left
        anchors.leftMargin: 6
        anchors.verticalCenter: skillRankFrame9.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 45
        height: 10.3
    }

    Part {
        id: skillRankFrame9SkillRank
        name: "SkillRankFrame9SkillRank"
        kind: "FontString"
        text: "450/450"
        wowParent: "SkillRankFrame9"
        anchors.left: skillRankFrame9SkillName.right
        anchors.leftMargin: 13
        anchors.verticalCenter: skillRankFrame9SkillName.verticalCenter
        width: 128
        height: 10.3
    }

    Part {
        id: skillTypeLabel1
        name: "SkillTypeLabel1"
        kind: "Button"
        text: "Class Skills"
        wowParent: "SkillFrame"
        anchors.left: skillFrame.left
        anchors.leftMargin: 22
        anchors.verticalCenter: skillFrame.top
        anchors.verticalCenterOffset: 86
        width: 285
        height: 14
    }

    Part {
        id: skillTypeLabel5
        name: "SkillTypeLabel5"
        kind: "Button"
        text: "Professions"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel4.left
        anchors.verticalCenter: skillTypeLabel4.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Part {
        id: skillTypeLabel6
        name: "SkillTypeLabel6"
        kind: "Button"
        text: "Secondary Skills"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel5.left
        anchors.verticalCenter: skillTypeLabel5.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Part {
        id: skillTypeLabel8
        name: "SkillTypeLabel8"
        kind: "Button"
        text: "Secondary Skills"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel7.left
        anchors.verticalCenter: skillTypeLabel7.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Part {
        id: skillTypeLabel9
        name: "SkillTypeLabel9"
        kind: "Button"
        text: "Weapon Skills"
        wowParent: "SkillFrame"
        anchors.left: skillTypeLabel8.left
        anchors.verticalCenter: skillTypeLabel8.verticalCenter
        anchors.verticalCenterOffset: 18
        width: 285
        height: 14
    }

    Part {
        id: standingMouseOver
        name: "StandingMouseOver"
        kind: "Frame"
        wowParent: "ReputationFrame"
        anchors.left: reputationFrameStandingLabel.left
        anchors.top: reputationFrameStandingLabel.top
        width: 53.7
        height: 11.9
    }

    Part {
        id: tokenFrame
        name: "TokenFrame"
        kind: "Frame"
        wowParent: "CharacterFrame"
        anchors.left: characterFrame.left
        anchors.leftMargin: 19
        anchors.top: characterFrame.top
        anchors.topMargin: 20
        width: 384
        height: 512
    }

    Part {
        id: tokenFrameContainer
        name: "TokenFrameContainer"
        kind: "ScrollFrame"
        wowParent: "TokenFrame"
        anchors.left: tokenFrame.left
        anchors.leftMargin: 26
        anchors.top: tokenFrame.top
        anchors.topMargin: 77
        width: 313
        height: 330
    }

    Part {
        id: tokenFrameContainerButton1
        name: "TokenFrameContainerButton1"
        kind: "Button"
        text: "Dungeon and Raid"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerScrollChild.left
        anchors.top: tokenFrameContainerScrollChild.top
        anchors.topMargin: 2
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton10
        name: "TokenFrameContainerButton10"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton9.left
        anchors.top: tokenFrameContainerButton9.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton10Count
        name: "TokenFrameContainerButton10Count"
        kind: "FontString"
        text: "0"
        wowParent: "TokenFrameContainerButton10"
        anchors.right: tokenFrameContainerButton10Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton10Icon.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton10Name
        name: "TokenFrameContainerButton10Name"
        kind: "FontString"
        text: "Arena Points"
        wowParent: "TokenFrameContainerButton10"
        anchors.left: tokenFrameContainerButton10.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton10.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton11
        name: "TokenFrameContainerButton11"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton10.left
        anchors.top: tokenFrameContainerButton10.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton11Count
        name: "TokenFrameContainerButton11Count"
        kind: "FontString"
        text: "50130"
        wowParent: "TokenFrameContainerButton11"
        anchors.right: tokenFrameContainerButton11Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton11Icon.verticalCenter
        width: 38.7
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton11Name
        name: "TokenFrameContainerButton11Name"
        kind: "FontString"
        text: "Honor Points"
        wowParent: "TokenFrameContainerButton11"
        anchors.left: tokenFrameContainerButton11.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton11.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton12
        name: "TokenFrameContainerButton12"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton11.left
        anchors.top: tokenFrameContainerButton11.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton12Count
        name: "TokenFrameContainerButton12Count"
        kind: "FontString"
        text: "195"
        wowParent: "TokenFrameContainerButton12"
        anchors.right: tokenFrameContainerButton12Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton12Icon.verticalCenter
        width: 23.7
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton12Name
        name: "TokenFrameContainerButton12Name"
        kind: "FontString"
        text: "Stone Keeper's Shard"
        wowParent: "TokenFrameContainerButton12"
        anchors.left: tokenFrameContainerButton12.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton12.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton13
        name: "TokenFrameContainerButton13"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton12.left
        anchors.top: tokenFrameContainerButton12.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton13Count
        name: "TokenFrameContainerButton13Count"
        kind: "FontString"
        text: "3"
        wowParent: "TokenFrameContainerButton13"
        anchors.right: tokenFrameContainerButton13Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton13Icon.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton13Name
        name: "TokenFrameContainerButton13Name"
        kind: "FontString"
        text: "Warsong Gulch Mark of Honor"
        wowParent: "TokenFrameContainerButton13"
        anchors.left: tokenFrameContainerButton13.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton13.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton14
        name: "TokenFrameContainerButton14"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton13.left
        anchors.top: tokenFrameContainerButton13.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton14Count
        name: "TokenFrameContainerButton14Count"
        kind: "FontString"
        text: "5"
        wowParent: "TokenFrameContainerButton14"
        anchors.right: tokenFrameContainerButton14Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton14Icon.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton14Name
        name: "TokenFrameContainerButton14Name"
        kind: "FontString"
        text: "Wintergrasp Mark of Honor"
        wowParent: "TokenFrameContainerButton14"
        anchors.left: tokenFrameContainerButton14.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton14.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton1Count
        name: "TokenFrameContainerButton1Count"
        kind: "FontString"
        wowParent: "TokenFrameContainerButton1"
        anchors.right: tokenFrameContainerButton1Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton1Icon.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tokenFrameContainerButton1Name
        name: "TokenFrameContainerButton1Name"
        kind: "FontString"
        wowParent: "TokenFrameContainerButton1"
        anchors.left: tokenFrameContainerButton1.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton1.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton2
        name: "TokenFrameContainerButton2"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton1.left
        anchors.top: tokenFrameContainerButton1.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton2Count
        name: "TokenFrameContainerButton2Count"
        kind: "FontString"
        text: "30"
        wowParent: "TokenFrameContainerButton2"
        anchors.right: tokenFrameContainerButton2Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton2Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton2Name
        name: "TokenFrameContainerButton2Name"
        kind: "FontString"
        text: "Emblem of Conquest"
        wowParent: "TokenFrameContainerButton2"
        anchors.left: tokenFrameContainerButton2.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton2.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton3
        name: "TokenFrameContainerButton3"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton2.left
        anchors.top: tokenFrameContainerButton2.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton3Count
        name: "TokenFrameContainerButton3Count"
        kind: "FontString"
        text: "29"
        wowParent: "TokenFrameContainerButton3"
        anchors.right: tokenFrameContainerButton3Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton3Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton3Name
        name: "TokenFrameContainerButton3Name"
        kind: "FontString"
        text: "Emblem of Heroism"
        wowParent: "TokenFrameContainerButton3"
        anchors.left: tokenFrameContainerButton3.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton3.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton4
        name: "TokenFrameContainerButton4"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton3.left
        anchors.top: tokenFrameContainerButton3.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton4Count
        name: "TokenFrameContainerButton4Count"
        kind: "FontString"
        text: "33"
        wowParent: "TokenFrameContainerButton4"
        anchors.right: tokenFrameContainerButton4Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton4Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton4Name
        name: "TokenFrameContainerButton4Name"
        kind: "FontString"
        text: "Emblem of Valor"
        wowParent: "TokenFrameContainerButton4"
        anchors.left: tokenFrameContainerButton4.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton4.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton5
        name: "TokenFrameContainerButton5"
        kind: "Button"
        text: "Miscellaneous"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton4.left
        anchors.top: tokenFrameContainerButton4.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton5Count
        name: "TokenFrameContainerButton5Count"
        kind: "FontString"
        wowParent: "TokenFrameContainerButton5"
        anchors.right: tokenFrameContainerButton5Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton5Icon.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tokenFrameContainerButton5Name
        name: "TokenFrameContainerButton5Name"
        kind: "FontString"
        wowParent: "TokenFrameContainerButton5"
        anchors.left: tokenFrameContainerButton5.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton5.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton6
        name: "TokenFrameContainerButton6"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton5.left
        anchors.top: tokenFrameContainerButton5.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton6Count
        name: "TokenFrameContainerButton6Count"
        kind: "FontString"
        text: "24"
        wowParent: "TokenFrameContainerButton6"
        anchors.right: tokenFrameContainerButton6Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton6Icon.verticalCenter
        width: 17.4
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton6Name
        name: "TokenFrameContainerButton6Name"
        kind: "FontString"
        text: "Badge of Justice"
        wowParent: "TokenFrameContainerButton6"
        anchors.left: tokenFrameContainerButton6.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton6.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton7
        name: "TokenFrameContainerButton7"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton6.left
        anchors.top: tokenFrameContainerButton6.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton7Count
        name: "TokenFrameContainerButton7Count"
        kind: "FontString"
        text: "89"
        wowParent: "TokenFrameContainerButton7"
        anchors.right: tokenFrameContainerButton7Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton7Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton7Name
        name: "TokenFrameContainerButton7Name"
        kind: "FontString"
        text: "Champion's Seal"
        wowParent: "TokenFrameContainerButton7"
        anchors.left: tokenFrameContainerButton7.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton7.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton8
        name: "TokenFrameContainerButton8"
        kind: "Button"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton7.left
        anchors.top: tokenFrameContainerButton7.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton8Count
        name: "TokenFrameContainerButton8Count"
        kind: "FontString"
        text: "29"
        wowParent: "TokenFrameContainerButton8"
        anchors.right: tokenFrameContainerButton8Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton8Icon.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: tokenFrameContainerButton8Name
        name: "TokenFrameContainerButton8Name"
        kind: "FontString"
        text: "Dalaran Cooking Award"
        wowParent: "TokenFrameContainerButton8"
        anchors.left: tokenFrameContainerButton8.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton8.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerButton9
        name: "TokenFrameContainerButton9"
        kind: "Button"
        text: "Player vs. Player"
        wowParent: "TokenFrameContainerScrollChild"
        anchors.left: tokenFrameContainerButton8.left
        anchors.top: tokenFrameContainerButton8.bottom
        anchors.topMargin: 3
        width: 313
        height: 17
    }

    Part {
        id: tokenFrameContainerButton9Count
        name: "TokenFrameContainerButton9Count"
        kind: "FontString"
        wowParent: "TokenFrameContainerButton9"
        anchors.right: tokenFrameContainerButton9Icon.left
        anchors.rightMargin: 5
        anchors.verticalCenter: tokenFrameContainerButton9Icon.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: tokenFrameContainerButton9Name
        name: "TokenFrameContainerButton9Name"
        kind: "FontString"
        wowParent: "TokenFrameContainerButton9"
        anchors.left: tokenFrameContainerButton9.left
        anchors.leftMargin: 11
        anchors.verticalCenter: tokenFrameContainerButton9.verticalCenter
        width: 210
        height: 11
    }

    Part {
        id: tokenFrameContainerScrollChild
        name: "TokenFrameContainerScrollChild"
        kind: "Frame"
        wowParent: "TokenFrameContainer"
        anchors.left: tokenFrameContainer.left
        anchors.top: tokenFrameContainer.top
        width: 299
        height: 420
    }

    Part {
        id: tokenFrameMoneyFrame
        name: "TokenFrameMoneyFrame"
        kind: "Frame"
        wowParent: "TokenFrame"
        pin: "place"
        anchors.right: tokenFrame.right
        anchors.rightMargin: 44
        anchors.bottom: tokenFrame.bottom
        anchors.bottomMargin: 84
        width: 126.4
        height: 13
    }

    Part {
        id: tokenFrameMoneyFrameCopperButton
        name: "TokenFrameMoneyFrameCopperButton"
        kind: "Button"
        text: "13"
        wowParent: "TokenFrameMoneyFrame"
        anchors.right: tokenFrameMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: tokenFrameMoneyFrameCopperButtonText
        name: "TokenFrameMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "13"
        wowParent: "TokenFrameMoneyFrameCopperButton"
        anchors.right: tokenFrameMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: tokenFrameMoneyFrameGoldButton
        name: "TokenFrameMoneyFrameGoldButton"
        kind: "Button"
        text: "3654"
        wowParent: "TokenFrameMoneyFrame"
        anchors.right: tokenFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: tokenFrameMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    Part {
        id: tokenFrameMoneyFrameGoldButtonText
        name: "TokenFrameMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "3654"
        wowParent: "TokenFrameMoneyFrameGoldButton"
        anchors.right: tokenFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Part {
        id: tokenFrameMoneyFrameSilverButton
        name: "TokenFrameMoneyFrameSilverButton"
        kind: "Button"
        text: "16"
        wowParent: "TokenFrameMoneyFrame"
        anchors.right: tokenFrameMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: tokenFrameMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: tokenFrameMoneyFrameSilverButtonText
        name: "TokenFrameMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "16"
        wowParent: "TokenFrameMoneyFrameSilverButton"
        anchors.right: tokenFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: tokenFrameMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: tokenFramePopup
        name: "TokenFramePopup"
        kind: "Frame"
        wowParent: "TokenFrame"
        pin: "place"
        anchors.left: characterFrameDiabolic.right
        anchors.leftMargin: -8
        anchors.top: characterFrameDiabolic.top
        anchors.topMargin: 96
        width: 205
        height: 100
    }

    Part {
        id: tokenFramePopupBackpackCheckBox
        name: "TokenFramePopupBackpackCheckBox"
        kind: "CheckButton"
        wowParent: "TokenFramePopup"
        style: "CheckBox"
        pin: "place"
        anchors.left: tokenFramePopupInactiveCheckBox.left
        anchors.top: tokenFramePopupInactiveCheckBox.bottom
        anchors.topMargin: 6
        width: 20
        height: 20
    }

    Part {
        id: tokenFramePopupBackpackCheckBoxText
        name: "TokenFramePopupBackpackCheckBoxText"
        kind: "FontString"
        text: "Show on Backpack"
        wowParent: "TokenFramePopupBackpackCheckBox"
        anchors.left: tokenFramePopupBackpackCheckBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: tokenFramePopupBackpackCheckBox.verticalCenter
        width: 109
        height: 14.2
    }

    Part {
        id: tokenFramePopupCloseButton
        name: "TokenFramePopupCloseButton"
        kind: "Button"
        wowParent: "TokenFramePopup"
        pin: "place"
        anchors.right: tokenFramePopup.right
        anchors.rightMargin: 1
        anchors.top: tokenFramePopup.top
        anchors.topMargin: 1
        width: 22
        height: 22
    }

    Part {
        id: tokenFramePopupInactiveCheckBox
        name: "TokenFramePopupInactiveCheckBox"
        kind: "CheckButton"
        wowParent: "TokenFramePopup"
        style: "CheckBox"
        anchors.left: tokenFramePopup.left
        anchors.leftMargin: 32
        anchors.top: tokenFramePopup.top
        anchors.topMargin: 32
        width: 20
        height: 20
    }

    Part {
        id: tokenFramePopupInactiveCheckBoxText
        name: "TokenFramePopupInactiveCheckBoxText"
        kind: "FontString"
        text: "Unused"
        wowParent: "TokenFramePopupInactiveCheckBox"
        anchors.left: tokenFramePopupInactiveCheckBox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: tokenFramePopupInactiveCheckBox.verticalCenter
        width: 44.2
        height: 14.2
    }

    Part {
        id: tokenFramePopupTitle
        name: "TokenFramePopupTitle"
        kind: "FontString"
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
