// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: inspectFrame
    name: "InspectFrame"
    width: 384
    height: 512

    Button {
        id: inspectBackSlot
        name: "InspectBackSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectShoulderSlot.left
        anchors.top: inspectShoulderSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectChestSlot
        name: "InspectChestSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectBackSlot.left
        anchors.top: inspectBackSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectFeetSlot
        name: "InspectFeetSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectLegsSlot.left
        anchors.top: inspectLegsSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectFinger0Slot
        name: "InspectFinger0Slot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectFeetSlot.left
        anchors.top: inspectFeetSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectFinger1Slot
        name: "InspectFinger1Slot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectFinger0Slot.left
        anchors.top: inspectFinger0Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectFrameCloseButton
        name: "InspectFrameCloseButton"
        wowParent: "InspectFrame"
        style: "CloseButton"
        anchors.horizontalCenter: inspectFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: inspectFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: inspectFrameDiabolic
        name: "InspectFrameDiabolic"
        wowParent: "InspectFrame"
        anchors.left: inspectFrame.left
        anchors.leftMargin: -19
        anchors.top: inspectFrame.top
        anchors.topMargin: -28
        width: 402
        height: 531
    }

    Frame {
        id: inspectFrameDiabolicBorder
        name: "InspectFrameDiabolicBorder"
        wowParent: "InspectFrameDiabolic"
        anchors.left: inspectFrameDiabolic.left
        anchors.top: inspectFrameDiabolic.top
        anchors.topMargin: 32
        width: 402
        height: 499
    }

    Frame {
        id: inspectFrameDiabolicRail
        name: "InspectFrameDiabolicRail"
        wowParent: "InspectFrameDiabolic"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 188
        height: 18
    }

    Frame {
        id: inspectFrameDiabolicSocket
        name: "InspectFrameDiabolicSocket"
        wowParent: "InspectFrameDiabolic"
        anchors.right: inspectFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: inspectFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: inspectFrameDiabolicTitlePlate
        name: "InspectFrameDiabolicTitlePlate"
        wowParent: "InspectFrameDiabolic"
        anchors.horizontalCenter: inspectFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: inspectFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: inspectFrameTab1
        name: "InspectFrameTab1"
        text: "Character"
        wowParent: "InspectFrame"
        style: "Banner"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: inspectFrameTab2
        name: "InspectFrameTab2"
        text: "PvP"
        wowParent: "InspectFrame"
        style: "Banner"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: inspectFrameTab3
        name: "InspectFrameTab3"
        text: "Talents"
        wowParent: "InspectFrame"
        style: "Banner"
        anchors.left: inspectFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: inspectFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: inspectHandsSlot
        name: "InspectHandsSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectPaperDollFrame.left
        anchors.leftMargin: 305
        anchors.top: inspectPaperDollFrame.top
        anchors.topMargin: 74
        width: 37
        height: 37
    }

    Button {
        id: inspectHeadSlot
        name: "InspectHeadSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectPaperDollFrame.left
        anchors.leftMargin: 21
        anchors.top: inspectPaperDollFrame.top
        anchors.topMargin: 74
        width: 37
        height: 37
    }

    Button {
        id: inspectLegsSlot
        name: "InspectLegsSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectWaistSlot.left
        anchors.top: inspectWaistSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    // the level line (the guild's under it) out of the band, over the model
    FontString {
        id: inspectLevelText
        name: "InspectLevelText"
        text: "Level 25 Gnome Warrior"
        wowParent: "InspectPaperDollFrame"
        pin: "place"
        anchors.horizontalCenter: inspectModelFrame.horizontalCenter
        anchors.bottom: inspectModelFrame.top
        anchors.bottomMargin: 22
        width: 218.1
        height: 14.2
    }

    Button {
        id: inspectMainHandSlot
        name: "InspectMainHandSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectPaperDollFrame.left
        anchors.leftMargin: 122
        anchors.top: inspectPaperDollFrame.bottom
        anchors.topMargin: -127
        width: 37
        height: 37
    }

    PlayerModel {
        id: inspectModelFrame
        name: "InspectModelFrame"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectPaperDollFrame.left
        anchors.leftMargin: 65
        anchors.top: inspectPaperDollFrame.top
        anchors.topMargin: 78
        width: 233
        height: 300
    }

    Button {
        id: inspectModelRotateLeftButton
        name: "InspectModelRotateLeftButton"
        wowParent: "InspectModelFrame"
        anchors.left: inspectModelFrame.left
        anchors.top: inspectModelFrame.top
        width: 35
        height: 35
    }

    Button {
        id: inspectModelRotateRightButton
        name: "InspectModelRotateRightButton"
        wowParent: "InspectModelFrame"
        anchors.left: inspectModelRotateLeftButton.right
        anchors.top: inspectModelRotateLeftButton.top
        width: 35
        height: 35
    }

    Frame {
        id: inspectNameFrame
        name: "InspectNameFrame"
        wowParent: "InspectFrame"
        anchors.horizontalCenter: inspectFrame.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: inspectFrame.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 109
        height: 12
    }

    FontString {
        id: inspectNameText
        name: "InspectNameText"
        text: "Bastoncino"
        wowParent: "InspectFrameDiabolicTitlePlate"
        anchors.horizontalCenter: inspectFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: inspectFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 105.1
        height: 14.2
    }

    Button {
        id: inspectNeckSlot
        name: "InspectNeckSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectHeadSlot.left
        anchors.top: inspectHeadSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Frame {
        id: inspectPVPFrame
        name: "InspectPVPFrame"
        wowParent: "InspectFrame"
        anchors.left: inspectFrame.left
        anchors.top: inspectFrame.top
        width: 384
        height: 512
    }

    Frame {
        id: inspectPVPFrameArena
        name: "InspectPVPFrameArena"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPFrameBackground.left
        anchors.leftMargin: 120
        anchors.top: inspectPVPFrameBackground.top
        anchors.topMargin: 95
        width: 300
        height: 20
    }

    FontString {
        id: inspectPVPFrameArenaLabel
        name: "InspectPVPFrameArenaLabel"
        text: "ARENA:"
        wowParent: "InspectPVPFrameArena"
        anchors.left: inspectPVPFrameArena.left
        anchors.verticalCenter: inspectPVPFrameArena.verticalCenter
        width: 41.9
        height: 10.3
    }

    Frame {
        id: inspectPVPFrameHonor
        name: "InspectPVPFrameHonor"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPFrameBackground.left
        anchors.leftMargin: 118
        anchors.top: inspectPVPFrameBackground.top
        anchors.topMargin: 2
        width: 300
        height: 20
    }

    FontString {
        id: inspectPVPFrameHonorLabel
        name: "InspectPVPFrameHonorLabel"
        text: "HONOR:"
        wowParent: "InspectPVPFrameHonor"
        anchors.left: inspectPVPFrameHonor.left
        anchors.verticalCenter: inspectPVPFrameHonor.verticalCenter
        width: 47.4
        height: 10.3
    }

    Frame {
        id: inspectPVPHonor
        name: "InspectPVPHonor"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPFrameBackground.left
        anchors.leftMargin: 15
        anchors.top: inspectPVPFrameBackground.top
        anchors.topMargin: 28
        width: 300
        height: 100
    }

    FontString {
        id: inspectPVPHonorHonorLabel
        name: "InspectPVPHonorHonorLabel"
        text: "Honor"
        wowParent: "InspectPVPHonor"
        anchors.right: inspectPVPHonorKillsLabel.right
        anchors.top: inspectPVPHonorKillsLabel.bottom
        anchors.topMargin: 10
        width: 34.8
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorKillsLabel
        name: "InspectPVPHonorKillsLabel"
        text: "Kills"
        wowParent: "InspectPVPHonor"
        anchors.left: inspectPVPHonor.left
        anchors.leftMargin: 25
        anchors.top: inspectPVPHonor.top
        anchors.topMargin: 24
        width: 22.9
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorLifetimeHonor
        name: "InspectPVPHonorLifetimeHonor"
        text: "-"
        wowParent: "InspectPVPHonor"
        anchors.horizontalCenter: inspectPVPHonorLifetimeKills.horizontalCenter
        anchors.top: inspectPVPHonorLifetimeKills.bottom
        anchors.topMargin: 10
        width: 5.5
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorLifetimeKills
        name: "InspectPVPHonorLifetimeKills"
        text: "0"
        wowParent: "InspectPVPHonor"
        anchors.horizontalCenter: inspectPVPHonorLifetimeLabel.horizontalCenter
        anchors.top: inspectPVPHonorLifetimeLabel.bottom
        anchors.topMargin: 10
        width: 7.9
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorLifetimeLabel
        name: "InspectPVPHonorLifetimeLabel"
        text: "Lifetime"
        wowParent: "InspectPVPHonor"
        anchors.left: inspectPVPHonorYesterdayLabel.right
        anchors.leftMargin: 30
        anchors.verticalCenter: inspectPVPHonorYesterdayLabel.verticalCenter
        width: 45
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorTodayHonor
        name: "InspectPVPHonorTodayHonor"
        text: "0"
        wowParent: "InspectPVPHonor"
        anchors.horizontalCenter: inspectPVPHonorTodayKills.horizontalCenter
        anchors.top: inspectPVPHonorTodayKills.bottom
        anchors.topMargin: 10
        width: 7.9
        height: 14
    }

    FontString {
        id: inspectPVPHonorTodayKills
        name: "InspectPVPHonorTodayKills"
        text: "0"
        wowParent: "InspectPVPHonor"
        anchors.horizontalCenter: inspectPVPHonorTodayLabel.horizontalCenter
        anchors.top: inspectPVPHonorTodayLabel.bottom
        anchors.topMargin: 10
        width: 7.9
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorTodayLabel
        name: "InspectPVPHonorTodayLabel"
        text: "Today"
        wowParent: "InspectPVPHonor"
        anchors.left: inspectPVPHonorKillsLabel.right
        anchors.leftMargin: 30
        anchors.bottom: inspectPVPHonorKillsLabel.top
        anchors.bottomMargin: 10
        width: 34.8
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorYesterdayHonor
        name: "InspectPVPHonorYesterdayHonor"
        text: "0"
        wowParent: "InspectPVPHonor"
        anchors.horizontalCenter: inspectPVPHonorYesterdayKills.horizontalCenter
        anchors.top: inspectPVPHonorYesterdayKills.bottom
        anchors.topMargin: 10
        width: 7.9
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorYesterdayKills
        name: "InspectPVPHonorYesterdayKills"
        text: "0"
        wowParent: "InspectPVPHonor"
        anchors.horizontalCenter: inspectPVPHonorYesterdayLabel.horizontalCenter
        anchors.top: inspectPVPHonorYesterdayLabel.bottom
        anchors.topMargin: 10
        width: 7.9
        height: 10.3
    }

    FontString {
        id: inspectPVPHonorYesterdayLabel
        name: "InspectPVPHonorYesterdayLabel"
        text: "Yesterday"
        wowParent: "InspectPVPHonor"
        anchors.left: inspectPVPHonorTodayLabel.right
        anchors.leftMargin: 30
        anchors.verticalCenter: inspectPVPHonorTodayLabel.verticalCenter
        width: 53.7
        height: 10.3
    }

    Button {
        id: inspectPVPTeam1
        name: "InspectPVPTeam1"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPTeam1Standard.left
        anchors.leftMargin: 33
        anchors.verticalCenter: inspectPVPTeam1Standard.verticalCenter
        width: 300
        height: 78
    }

    Frame {
        id: inspectPVPTeam1Standard
        name: "InspectPVPTeam1Standard"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPFrameBackground.left
        anchors.leftMargin: 16
        anchors.verticalCenter: inspectPVPFrameBackground.verticalCenter
        anchors.verticalCenterOffset: -85
        width: 64
        height: 64
    }

    FontString {
        id: inspectPVPTeam1TeamType
        name: "InspectPVPTeam1TeamType"
        text: "(2v2)"
        wowParent: "InspectPVPTeam1"
        anchors.horizontalCenter: inspectPVPTeam1.horizontalCenter
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenter: inspectPVPTeam1.verticalCenter
        width: 41.9
        height: 15.8
    }

    Button {
        id: inspectPVPTeam2
        name: "InspectPVPTeam2"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPTeam2Standard.left
        anchors.leftMargin: 33
        anchors.verticalCenter: inspectPVPTeam2Standard.verticalCenter
        width: 300
        height: 78
    }

    Frame {
        id: inspectPVPTeam2Standard
        name: "InspectPVPTeam2Standard"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPFrameBackground.left
        anchors.leftMargin: 16
        anchors.verticalCenter: inspectPVPFrameBackground.verticalCenter
        width: 64
        height: 64
    }

    FontString {
        id: inspectPVPTeam2TeamType
        name: "InspectPVPTeam2TeamType"
        text: "(3v3)"
        wowParent: "InspectPVPTeam2"
        anchors.horizontalCenter: inspectPVPTeam2.horizontalCenter
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenter: inspectPVPTeam2.verticalCenter
        width: 41.9
        height: 15.8
    }

    Button {
        id: inspectPVPTeam3
        name: "InspectPVPTeam3"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPTeam3Standard.left
        anchors.leftMargin: 33
        anchors.verticalCenter: inspectPVPTeam3Standard.verticalCenter
        width: 300
        height: 78
    }

    Frame {
        id: inspectPVPTeam3Standard
        name: "InspectPVPTeam3Standard"
        wowParent: "InspectPVPFrame"
        anchors.left: inspectPVPFrameBackground.left
        anchors.leftMargin: 16
        anchors.verticalCenter: inspectPVPFrameBackground.verticalCenter
        anchors.verticalCenterOffset: 85
        width: 64
        height: 64
    }

    FontString {
        id: inspectPVPTeam3TeamType
        name: "InspectPVPTeam3TeamType"
        text: "(5v5)"
        wowParent: "InspectPVPTeam3"
        anchors.horizontalCenter: inspectPVPTeam3.horizontalCenter
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenter: inspectPVPTeam3.verticalCenter
        width: 41.9
        height: 15.8
    }

    Frame {
        id: inspectPaperDollFrame
        name: "InspectPaperDollFrame"
        wowParent: "InspectFrame"
        anchors.left: inspectFrame.left
        anchors.top: inspectFrame.top
        width: 384
        height: 512
    }

    Button {
        id: inspectRangedSlot
        name: "InspectRangedSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectSecondaryHandSlot.right
        anchors.leftMargin: 5
        anchors.top: inspectSecondaryHandSlot.top
        width: 37
        height: 37
    }

    Button {
        id: inspectSecondaryHandSlot
        name: "InspectSecondaryHandSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectMainHandSlot.right
        anchors.leftMargin: 5
        anchors.top: inspectMainHandSlot.top
        width: 37
        height: 37
    }

    Button {
        id: inspectShirtSlot
        name: "InspectShirtSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectChestSlot.left
        anchors.top: inspectChestSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectShoulderSlot
        name: "InspectShoulderSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectNeckSlot.left
        anchors.top: inspectNeckSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectTabardSlot
        name: "InspectTabardSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectShirtSlot.left
        anchors.top: inspectShirtSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Frame {
        id: inspectTalentFrame
        name: "InspectTalentFrame"
        wowParent: "InspectFrame"
        anchors.left: inspectFrame.left
        anchors.top: inspectFrame.top
        width: 384
        height: 512
    }

    Frame {
        id: inspectTalentFrameArrowFrame
        name: "InspectTalentFrameArrowFrame"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.top: inspectTalentFrameScrollChildFrame.top
        width: 320
        height: 50
    }

    Button {
        id: inspectTalentFrameCloseButton
        name: "InspectTalentFrameCloseButton"
        wowParent: "InspectTalentFrame"
        anchors.horizontalCenter: inspectTalentFrame.right
        anchors.horizontalCenterOffset: -44
        anchors.verticalCenter: inspectTalentFrame.top
        anchors.verticalCenterOffset: 25
        width: 32
        height: 32
    }

    Frame {
        id: inspectTalentFramePointsBar
        name: "InspectTalentFramePointsBar"
        wowParent: "InspectTalentFrame"
        anchors.left: inspectTalentFrame.left
        anchors.leftMargin: 16
        anchors.verticalCenter: inspectTalentFrame.verticalCenter
        anchors.verticalCenterOffset: 162
        width: 332
        height: 26
    }

    Frame {
        id: inspectTalentFrameScrollChildFrame
        name: "InspectTalentFrameScrollChildFrame"
        wowParent: "InspectTalentFrameScrollFrame"
        anchors.left: inspectTalentFrameScrollFrame.left
        anchors.top: inspectTalentFrameScrollFrame.top
        width: 320
        height: 50
    }

    ScrollFrame {
        id: inspectTalentFrameScrollFrame
        name: "InspectTalentFrameScrollFrame"
        wowParent: "InspectTalentFrame"
        anchors.right: inspectTalentFrame.right
        anchors.rightMargin: 65
        anchors.top: inspectTalentFrame.top
        anchors.topMargin: 77
        width: 296
        height: 328
    }

    Frame {
        id: inspectTalentFrameScrollFrameDiabolicZone
        name: "InspectTalentFrameScrollFrameDiabolicZone"
        wowParent: "InspectTalentFrame"
        anchors.left: inspectTalentFrameScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: inspectTalentFrameScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 340
    }

    Slider {
        id: inspectTalentFrameScrollFrameScrollBar
        name: "InspectTalentFrameScrollFrameScrollBar"
        wowParent: "InspectTalentFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: inspectTalentFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: inspectTalentFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 296
    }

    Frame {
        id: inspectTalentFrameScrollFrameScrollBarDiabolicTrack
        name: "InspectTalentFrameScrollFrameScrollBarDiabolicTrack"
        wowParent: "InspectTalentFrameScrollFrameScrollBar"
        anchors.horizontalCenter: inspectTalentFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: inspectTalentFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 330
    }

    Button {
        id: inspectTalentFrameScrollFrameScrollBarScrollDownButton
        name: "InspectTalentFrameScrollFrameScrollBarScrollDownButton"
        wowParent: "InspectTalentFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: inspectTalentFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: inspectTalentFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: inspectTalentFrameScrollFrameScrollBarScrollUpButton
        name: "InspectTalentFrameScrollFrameScrollBarScrollUpButton"
        wowParent: "InspectTalentFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: inspectTalentFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: inspectTalentFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    FontString {
        id: inspectTalentFrameSpentPointsText
        name: "InspectTalentFrameSpentPointsText"
        wowParent: "InspectTalentFramePointsBar"
        anchors.left: inspectTalentFramePointsBar.left
        anchors.leftMargin: 12
        anchors.verticalCenter: inspectTalentFramePointsBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 77.4
        height: 15
    }

    Button {
        id: inspectTalentFrameTab1
        name: "InspectTalentFrameTab1"
        text: "Arms"
        wowParent: "InspectTalentFrame"
        anchors.left: inspectTalentFrameScrollFrame.left
        anchors.leftMargin: -6
        anchors.bottom: inspectTalentFrameScrollFrame.top
        anchors.bottomMargin: 12
        width: 28
        height: 28
    }

    Button {
        id: inspectTalentFrameTab2
        name: "InspectTalentFrameTab2"
        text: "Fury"
        wowParent: "InspectTalentFrame"
        anchors.left: inspectTalentFrameTab1.right
        anchors.leftMargin: 6
        anchors.verticalCenter: inspectTalentFrameTab1.verticalCenter
        width: 28
        height: 28
    }

    Button {
        id: inspectTalentFrameTab3
        name: "InspectTalentFrameTab3"
        text: "Protection"
        wowParent: "InspectTalentFrame"
        anchors.left: inspectTalentFrameTab2.right
        anchors.leftMargin: 6
        anchors.verticalCenter: inspectTalentFrameTab2.verticalCenter
        width: 28
        height: 28
    }

    Button {
        id: inspectTalentFrameTalent1
        name: "InspectTalentFrameTalent1"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Button {
        id: inspectTalentFrameTalent10
        name: "InspectTalentFrameTalent10"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent10Rank
        name: "InspectTalentFrameTalent10Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent10"
        anchors.horizontalCenter: inspectTalentFrameTalent10RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent10RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent11
        name: "InspectTalentFrameTalent11"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent11Rank
        name: "InspectTalentFrameTalent11Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent11"
        anchors.horizontalCenter: inspectTalentFrameTalent11RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent11RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent12
        name: "InspectTalentFrameTalent12"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent12Rank
        name: "InspectTalentFrameTalent12Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent12"
        anchors.horizontalCenter: inspectTalentFrameTalent12RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent12RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent13
        name: "InspectTalentFrameTalent13"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent13Rank
        name: "InspectTalentFrameTalent13Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent13"
        anchors.horizontalCenter: inspectTalentFrameTalent13RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent13RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent14
        name: "InspectTalentFrameTalent14"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent14Rank
        name: "InspectTalentFrameTalent14Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent14"
        anchors.horizontalCenter: inspectTalentFrameTalent14RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent14RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent15
        name: "InspectTalentFrameTalent15"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent15Rank
        name: "InspectTalentFrameTalent15Rank"
        text: "2"
        wowParent: "InspectTalentFrameTalent15"
        anchors.horizontalCenter: inspectTalentFrameTalent15RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent15RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent16
        name: "InspectTalentFrameTalent16"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 335
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent16Rank
        name: "InspectTalentFrameTalent16Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent16"
        anchors.horizontalCenter: inspectTalentFrameTalent16RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent16RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent17
        name: "InspectTalentFrameTalent17"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 335
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent17Rank
        name: "InspectTalentFrameTalent17Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent17"
        anchors.horizontalCenter: inspectTalentFrameTalent17RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent17RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent18
        name: "InspectTalentFrameTalent18"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent18Rank
        name: "InspectTalentFrameTalent18Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent18"
        anchors.horizontalCenter: inspectTalentFrameTalent18RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent18RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent19
        name: "InspectTalentFrameTalent19"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent19Rank
        name: "InspectTalentFrameTalent19Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent19"
        anchors.horizontalCenter: inspectTalentFrameTalent19RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent19RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    FontString {
        id: inspectTalentFrameTalent1Rank
        name: "InspectTalentFrameTalent1Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent1"
        anchors.horizontalCenter: inspectTalentFrameTalent1RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent1RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent2
        name: "InspectTalentFrameTalent2"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Button {
        id: inspectTalentFrameTalent20
        name: "InspectTalentFrameTalent20"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent20Rank
        name: "InspectTalentFrameTalent20Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent20"
        anchors.horizontalCenter: inspectTalentFrameTalent20RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent20RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent21
        name: "InspectTalentFrameTalent21"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 461
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent21Rank
        name: "InspectTalentFrameTalent21Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent21"
        anchors.horizontalCenter: inspectTalentFrameTalent21RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent21RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent22
        name: "InspectTalentFrameTalent22"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 461
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent22Rank
        name: "InspectTalentFrameTalent22Rank"
        text: "2"
        wowParent: "InspectTalentFrameTalent22"
        anchors.horizontalCenter: inspectTalentFrameTalent22RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent22RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent23
        name: "InspectTalentFrameTalent23"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent23Rank
        name: "InspectTalentFrameTalent23Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent23"
        anchors.horizontalCenter: inspectTalentFrameTalent23RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent23RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent24
        name: "InspectTalentFrameTalent24"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent24Rank
        name: "InspectTalentFrameTalent24Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent24"
        anchors.horizontalCenter: inspectTalentFrameTalent24RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent24RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent25
        name: "InspectTalentFrameTalent25"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent25Rank
        name: "InspectTalentFrameTalent25Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent25"
        anchors.horizontalCenter: inspectTalentFrameTalent25RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent25RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent26
        name: "InspectTalentFrameTalent26"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 587
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent26Rank
        name: "InspectTalentFrameTalent26Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent26"
        anchors.horizontalCenter: inspectTalentFrameTalent26RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent26RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent27
        name: "InspectTalentFrameTalent27"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 650
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent27Rank
        name: "InspectTalentFrameTalent27Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent27"
        anchors.horizontalCenter: inspectTalentFrameTalent27RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent27RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent28
        name: "InspectTalentFrameTalent28"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 650
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent28Rank
        name: "InspectTalentFrameTalent28Rank"
        text: "4"
        wowParent: "InspectTalentFrameTalent28"
        anchors.horizontalCenter: inspectTalentFrameTalent28RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent28RankBorder.verticalCenter
        width: 8.7
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent29
        name: "InspectTalentFrameTalent29"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 650
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent2Rank
        name: "InspectTalentFrameTalent2Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent2"
        anchors.horizontalCenter: inspectTalentFrameTalent2RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent2RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent3
        name: "InspectTalentFrameTalent3"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent3Rank
        name: "InspectTalentFrameTalent3Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent3"
        anchors.horizontalCenter: inspectTalentFrameTalent3RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent3RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent4
        name: "InspectTalentFrameTalent4"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent4Rank
        name: "InspectTalentFrameTalent4Rank"
        text: "3"
        wowParent: "InspectTalentFrameTalent4"
        anchors.horizontalCenter: inspectTalentFrameTalent4RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent4RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent5
        name: "InspectTalentFrameTalent5"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent5Rank
        name: "InspectTalentFrameTalent5Rank"
        text: "5"
        wowParent: "InspectTalentFrameTalent5"
        anchors.horizontalCenter: inspectTalentFrameTalent5RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent5RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent6
        name: "InspectTalentFrameTalent6"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent6Rank
        name: "InspectTalentFrameTalent6Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent6"
        anchors.horizontalCenter: inspectTalentFrameTalent6RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent6RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent7
        name: "InspectTalentFrameTalent7"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent7Rank
        name: "InspectTalentFrameTalent7Rank"
        text: "2"
        wowParent: "InspectTalentFrameTalent7"
        anchors.horizontalCenter: inspectTalentFrameTalent7RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent7RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent8
        name: "InspectTalentFrameTalent8"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent8Rank
        name: "InspectTalentFrameTalent8Rank"
        text: "2"
        wowParent: "InspectTalentFrameTalent8"
        anchors.horizontalCenter: inspectTalentFrameTalent8RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent8RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: inspectTalentFrameTalent9
        name: "InspectTalentFrameTalent9"
        wowParent: "InspectTalentFrameScrollChildFrame"
        anchors.left: inspectTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: inspectTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: inspectTalentFrameTalent9Rank
        name: "InspectTalentFrameTalent9Rank"
        text: "1"
        wowParent: "InspectTalentFrameTalent9"
        anchors.horizontalCenter: inspectTalentFrameTalent9RankBorder.horizontalCenter
        anchors.verticalCenter: inspectTalentFrameTalent9RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    FontString {
        id: inspectTalentFrameTalentPointsText
        name: "InspectTalentFrameTalentPointsText"
        wowParent: "InspectTalentFramePointsBar"
        anchors.right: inspectTalentFramePointsBar.right
        anchors.rightMargin: 12
        anchors.verticalCenter: inspectTalentFramePointsBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 98.8
        height: 15
    }

    Button {
        id: inspectTrinket0Slot
        name: "InspectTrinket0Slot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectFinger1Slot.left
        anchors.top: inspectFinger1Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectTrinket1Slot
        name: "InspectTrinket1Slot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectTrinket0Slot.left
        anchors.top: inspectTrinket0Slot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectWaistSlot
        name: "InspectWaistSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectHandsSlot.left
        anchors.top: inspectHandsSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Button {
        id: inspectWristSlot
        name: "InspectWristSlot"
        wowParent: "InspectPaperDollFrame"
        anchors.left: inspectTabardSlot.left
        anchors.top: inspectTabardSlot.bottom
        anchors.topMargin: 4
        width: 37
        height: 37
    }

    Ghost { id: inspectPVPFrameBackground; name: "InspectPVPFrameBackground"; x: 14; y: 36; width: 0; height: 512 }
    Ghost { id: inspectTalentFrameTalent10RankBorder; name: "InspectTalentFrameTalent10RankBorder"; x: 221; y: 260; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent11RankBorder; name: "InspectTalentFrameTalent11RankBorder"; x: 284; y: 260; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent12RankBorder; name: "InspectTalentFrameTalent12RankBorder"; x: 158; y: 323; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent13RankBorder; name: "InspectTalentFrameTalent13RankBorder"; x: 221; y: 323; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent14RankBorder; name: "InspectTalentFrameTalent14RankBorder"; x: 95; y: 386; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent15RankBorder; name: "InspectTalentFrameTalent15RankBorder"; x: 221; y: 386; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent16RankBorder; name: "InspectTalentFrameTalent16RankBorder"; x: 158; y: 449; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent17RankBorder; name: "InspectTalentFrameTalent17RankBorder"; x: 221; y: 449; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent18RankBorder; name: "InspectTalentFrameTalent18RankBorder"; x: 221; y: 511.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent19RankBorder; name: "InspectTalentFrameTalent19RankBorder"; x: 158; y: 511.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent1RankBorder; name: "InspectTalentFrameTalent1RankBorder"; x: 158; y: -239.6; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent20RankBorder; name: "InspectTalentFrameTalent20RankBorder"; x: 221; y: 511.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent21RankBorder; name: "InspectTalentFrameTalent21RankBorder"; x: 158; y: 574.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent22RankBorder; name: "InspectTalentFrameTalent22RankBorder"; x: 221; y: 574.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent23RankBorder; name: "InspectTalentFrameTalent23RankBorder"; x: 158; y: 574.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent24RankBorder; name: "InspectTalentFrameTalent24RankBorder"; x: 158; y: 637.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent25RankBorder; name: "InspectTalentFrameTalent25RankBorder"; x: 221; y: 637.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent26RankBorder; name: "InspectTalentFrameTalent26RankBorder"; x: 158; y: 700.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent27RankBorder; name: "InspectTalentFrameTalent27RankBorder"; x: 158; y: 763.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent28RankBorder; name: "InspectTalentFrameTalent28RankBorder"; x: 158; y: 700.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent2RankBorder; name: "InspectTalentFrameTalent2RankBorder"; x: 158; y: 133.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent3RankBorder; name: "InspectTalentFrameTalent3RankBorder"; x: 221; y: 133.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent4RankBorder; name: "InspectTalentFrameTalent4RankBorder"; x: 158; y: 196.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent5RankBorder; name: "InspectTalentFrameTalent5RankBorder"; x: 158; y: 196.9; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent6RankBorder; name: "InspectTalentFrameTalent6RankBorder"; x: 95; y: 260; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent7RankBorder; name: "InspectTalentFrameTalent7RankBorder"; x: 158; y: 260; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent8RankBorder; name: "InspectTalentFrameTalent8RankBorder"; x: 221; y: 260; width: 0; height: 0 }
    Ghost { id: inspectTalentFrameTalent9RankBorder; name: "InspectTalentFrameTalent9RankBorder"; x: 158; y: 260; width: 0; height: 0 }
}
