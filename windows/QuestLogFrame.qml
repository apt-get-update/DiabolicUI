// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: questLogFrame
    name: "QuestLogFrame"
    width: 682
    height: 447

    Part {
        id: questInfoDescriptionHeader
        name: "QuestInfoDescriptionHeader"
        kind: "FontString"
        text: "Description"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoObjectivesText.left
        anchors.top: questInfoObjectivesText.bottom
        anchors.topMargin: 10
        width: 285
        height: 15.8
    }

    Part {
        id: questInfoDescriptionText
        name: "QuestInfoDescriptionText"
        kind: "FontString"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoDescriptionHeader.left
        anchors.top: questInfoDescriptionHeader.bottom
        anchors.topMargin: 5
        width: 285
        height: 164.3
    }

    Part {
        id: questInfoItemReceiveText
        name: "QuestInfoItemReceiveText"
        kind: "FontString"
        text: "You will receive:"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoRewardsHeader.left
        anchors.leftMargin: 3
        anchors.top: questInfoRewardsHeader.bottom
        anchors.topMargin: 5.1
        width: 106.7
        height: 12.6
    }

    Part {
        id: questInfoMoneyFrame
        name: "QuestInfoMoneyFrame"
        kind: "Frame"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoItemReceiveText.right
        anchors.leftMargin: 15
        anchors.verticalCenter: questInfoItemReceiveText.verticalCenter
        width: 91
        height: 28
    }

    Part {
        id: questInfoMoneyFrameGoldButton
        name: "QuestInfoMoneyFrameGoldButton"
        kind: "Button"
        text: "42"
        wowParent: "QuestInfoMoneyFrame"
        anchors.right: questInfoMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: questInfoMoneyFrameSilverButton.verticalCenter
        width: 38
        height: 19
    }

    Part {
        id: questInfoMoneyFrameGoldButtonText
        name: "QuestInfoMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "42"
        wowParent: "QuestInfoMoneyFrameGoldButton"
        anchors.right: questInfoMoneyFrameGoldButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: questInfoMoneyFrameGoldButton.verticalCenter
        width: 19
        height: 15.8
    }

    Part {
        id: questInfoMoneyFrameSilverButton
        name: "QuestInfoMoneyFrameSilverButton"
        kind: "Button"
        text: "6"
        wowParent: "QuestInfoMoneyFrame"
        anchors.right: questInfoMoneyFrameCopperButton.right
        anchors.verticalCenter: questInfoMoneyFrameCopperButton.verticalCenter
        width: 30.1
        height: 19
    }

    Part {
        id: questInfoMoneyFrameSilverButtonText
        name: "QuestInfoMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "6"
        wowParent: "QuestInfoMoneyFrameSilverButton"
        anchors.right: questInfoMoneyFrameSilverButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: questInfoMoneyFrameSilverButton.verticalCenter
        width: 11.1
        height: 15.8
    }

    Part {
        id: questInfoObjective1
        name: "QuestInfoObjective1"
        kind: "FontString"
        text: "Ahn'kahar Watcher Corpse Burned: 0/1"
        wowParent: "QuestInfoObjectivesFrame"
        anchors.left: questInfoObjectivesFrame.left
        anchors.top: questInfoObjectivesFrame.top
        width: 285
        height: 11.9
    }

    Part {
        id: questInfoObjectivesFrame
        name: "QuestInfoObjectivesFrame"
        kind: "Frame"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoObjectivesText.left
        anchors.top: questInfoObjectivesText.bottom
        anchors.topMargin: 35.3
        width: 285
        height: 10
    }

    Part {
        id: questInfoObjectivesText
        name: "QuestInfoObjectivesText"
        kind: "FontString"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoTitleHeader.left
        anchors.top: questInfoTitleHeader.bottom
        anchors.topMargin: 5
        width: 285
        height: 63.2
    }

    Part {
        id: questInfoRewardsFrame
        name: "QuestInfoRewardsFrame"
        kind: "Frame"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoDescriptionText.left
        anchors.top: questInfoDescriptionText.bottom
        anchors.topMargin: 10
        width: 285
        height: 10
    }

    Part {
        id: questInfoRewardsHeader
        name: "QuestInfoRewardsHeader"
        kind: "FontString"
        text: "Rewards"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoRewardsFrame.left
        anchors.top: questInfoRewardsFrame.top
        width: 285
        height: 15.8
    }

    Part {
        id: questInfoSpacerFrame
        name: "QuestInfoSpacerFrame"
        kind: "Frame"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoXPFrame.left
        anchors.top: questInfoXPFrame.bottom
        anchors.topMargin: 10
        width: 5
        height: 5
    }

    Part {
        id: questInfoTitleHeader
        name: "QuestInfoTitleHeader"
        kind: "FontString"
        text: "The Sovereign Imperative"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questLogDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: questLogDetailScrollChildFrame.top
        anchors.topMargin: 5
        width: 285
        height: 15.8
    }

    Part {
        id: questInfoXPFrame
        name: "QuestInfoXPFrame"
        kind: "Frame"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoItemReceiveText.left
        anchors.top: questInfoItemReceiveText.bottom
        anchors.topMargin: 5
        width: 280
        height: 20
    }

    Part {
        id: questInfoXPFramePoints
        name: "QuestInfoXPFramePoints"
        kind: "FontString"
        text: "10050"
        wowParent: "QuestInfoXPFrame"
        anchors.left: questInfoXPFrameReceiveText.right
        anchors.leftMargin: 15
        anchors.verticalCenter: questInfoXPFrameReceiveText.verticalCenter
        width: 42.7
        height: 15.8
    }

    Part {
        id: questInfoXPFrameReceiveText
        name: "QuestInfoXPFrameReceiveText"
        kind: "FontString"
        text: "Experience:"
        wowParent: "QuestInfoXPFrame"
        anchors.left: questInfoXPFrame.left
        anchors.verticalCenter: questInfoXPFrame.verticalCenter
        width: 74.3
        height: 12.6
    }

    Part {
        id: questLogControlPanel
        name: "QuestLogControlPanel"
        kind: "Frame"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrameDiabolic.left
        anchors.leftMargin: 30
        anchors.bottom: questLogFrameDiabolic.bottom
        anchors.bottomMargin: 28
        width: 321
        height: 26
    }

    Part {
        id: questLogCount
        name: "QuestLogCount"
        kind: "Frame"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrame.left
        anchors.leftMargin: 80
        anchors.top: questLogFrame.top
        anchors.topMargin: 41
        width: 85.3
        height: 20
    }

    Part {
        id: questLogDetailScrollChildFrame
        name: "QuestLogDetailScrollChildFrame"
        kind: "Frame"
        wowParent: "QuestLogDetailScrollFrame"
        anchors.left: questLogDetailScrollFrame.left
        anchors.top: questLogDetailScrollFrame.top
        width: 298
        height: 333
    }

    Part {
        id: questLogDetailScrollFrame
        name: "QuestLogDetailScrollFrame"
        kind: "ScrollFrame"
        wowParent: "QuestLogFrame"
        anchors.right: questLogFrameDiabolic.right
        anchors.rightMargin: 74
        anchors.top: questLogFrameDiabolic.top
        anchors.topMargin: 44
        width: 298
        height: 336
    }

    Part {
        id: questLogDetailScrollFrameDiabolicPanel
        name: "QuestLogDetailScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "QuestLogFrame"
        anchors.left: questLogDetailScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: questLogDetailScrollFrame.top
        anchors.topMargin: -6
        width: 362
        height: 348
    }

    Part {
        id: questLogDetailScrollFrameDiabolicParchment
        name: "QuestLogDetailScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "QuestLogDetailScrollFrame"
        anchors.left: questLogDetailScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: questLogDetailScrollFrame.top
        anchors.topMargin: -4
        width: 336
        height: 344
    }

    Part {
        id: questLogDetailScrollFrameScrollBar
        name: "QuestLogDetailScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "QuestLogDetailScrollFrame"
        style: "ScrollBar"
        anchors.left: questLogDetailScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: questLogDetailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 304
    }

    Part {
        id: questLogDetailScrollFrameScrollBarDiabolicTrack
        name: "QuestLogDetailScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "QuestLogDetailScrollFrameScrollBar"
        anchors.horizontalCenter: questLogDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: questLogDetailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 338
    }

    Part {
        id: questLogDetailScrollFrameScrollBarScrollDownButton
        name: "QuestLogDetailScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "QuestLogDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogDetailScrollFrameScrollBar.horizontalCenter
        anchors.top: questLogDetailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: questLogDetailScrollFrameScrollBarScrollUpButton
        name: "QuestLogDetailScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "QuestLogDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogDetailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: questLogDetailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: questLogFrameAbandonButton
        name: "QuestLogFrameAbandonButton"
        kind: "Button"
        text: "Abandon"
        wowParent: "QuestLogControlPanel"
        style: "Button"
        anchors.left: questLogControlPanel.left
        anchors.verticalCenter: questLogControlPanel.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 110
        height: 21
    }

    Part {
        id: questLogFrameAbandonButtonText
        name: "QuestLogFrameAbandonButtonText"
        kind: "FontString"
        text: "Abandon"
        wowParent: "QuestLogFrameAbandonButton"
        anchors.horizontalCenter: questLogFrameAbandonButton.horizontalCenter
        anchors.verticalCenter: questLogFrameAbandonButton.verticalCenter
        width: 64.8
        height: 11.9
    }

    Part {
        id: questLogFrameCancelButton
        name: "QuestLogFrameCancelButton"
        kind: "Button"
        text: "Close"
        wowParent: "QuestLogFrame"
        anchors.right: questLogFrame.right
        anchors.rightMargin: 7
        anchors.bottom: questLogFrame.bottom
        anchors.bottomMargin: 14
        width: 80
        height: 22
    }

    Part {
        id: questLogFrameCancelButtonText
        name: "QuestLogFrameCancelButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "QuestLogFrameCancelButton"
        anchors.horizontalCenter: questLogFrameCancelButton.horizontalCenter
        anchors.verticalCenter: questLogFrameCancelButton.verticalCenter
        width: 34.8
        height: 11.9
    }

    Part {
        id: questLogFrameCloseButton
        name: "QuestLogFrameCloseButton"
        kind: "Button"
        wowParent: "QuestLogFrame"
        style: "CloseButton"
        anchors.horizontalCenter: questLogFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: questLogFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: questLogFrameDiabolic
        name: "QuestLogFrameDiabolic"
        kind: "Frame"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrame.left
        anchors.top: questLogFrame.top
        anchors.topMargin: -36
        width: 752
        height: 463
    }

    Part {
        id: questLogFrameDiabolicBorder
        name: "QuestLogFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "QuestLogFrameDiabolic"
        anchors.left: questLogFrameDiabolic.left
        anchors.top: questLogFrameDiabolic.top
        width: 752
        height: 463
    }

    Part {
        id: questLogFrameDiabolicFoot
        name: "QuestLogFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "QuestLogFrameDiabolic"
        anchors.horizontalCenter: questLogFrameAbandonButton.horizontalCenter
        anchors.horizontalCenterOffset: 291
        anchors.top: questLogFrameAbandonButton.top
        anchors.topMargin: -6
        width: 706
        height: 35.5
    }

    Part {
        id: questLogFrameDiabolicSocket
        name: "QuestLogFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "QuestLogFrameDiabolic"
        anchors.right: questLogFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: questLogFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: questLogFrameDiabolicTitlePlate
        name: "QuestLogFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "QuestLogFrameDiabolic"
        anchors.horizontalCenter: questLogFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: questLogFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: questLogFramePushQuestButton
        name: "QuestLogFramePushQuestButton"
        kind: "Button"
        text: "Share"
        wowParent: "QuestLogControlPanel"
        style: "Button"
        anchors.left: questLogFrameAbandonButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: questLogFrameAbandonButton.verticalCenter
        width: 96
        height: 21
    }

    Part {
        id: questLogFramePushQuestButtonText
        name: "QuestLogFramePushQuestButtonText"
        kind: "FontString"
        text: "Share"
        wowParent: "QuestLogFramePushQuestButton"
        anchors.horizontalCenter: questLogFramePushQuestButton.horizontalCenter
        anchors.verticalCenter: questLogFramePushQuestButton.verticalCenter
        width: 41.1
        height: 11.9
    }

    Part {
        id: questLogFrameTrackButton
        name: "QuestLogFrameTrackButton"
        kind: "Button"
        text: "Track"
        wowParent: "QuestLogControlPanel"
        style: "Button"
        anchors.right: questLogControlPanel.right
        anchors.rightMargin: 3
        anchors.verticalCenter: questLogControlPanel.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 21
    }

    Part {
        id: questLogFrameTrackButtonText
        name: "QuestLogFrameTrackButtonText"
        kind: "FontString"
        text: "Track"
        wowParent: "QuestLogFrameTrackButton"
        anchors.horizontalCenter: questLogFrameTrackButton.horizontalCenter
        anchors.verticalCenter: questLogFrameTrackButton.verticalCenter
        width: 43.5
        height: 11.9
    }

    Part {
        id: questLogHighlightFrame
        name: "QuestLogHighlightFrame"
        kind: "Frame"
        wowParent: "QuestLogScrollFrameButton2"
        anchors.left: questLogScrollFrameButton2.left
        anchors.top: questLogScrollFrameButton2.top
        width: 299
        height: 16
    }

    Part {
        id: questLogQuestCount
        name: "QuestLogQuestCount"
        kind: "FontString"
        wowParent: "QuestLogCount"
        anchors.right: questLogCountTopRight.left
        anchors.rightMargin: -1
        anchors.top: questLogCountTopRight.bottom
        anchors.topMargin: -3
        width: 70.3
        height: 10.3
    }

    Part {
        id: questLogScrollFrame
        name: "QuestLogScrollFrame"
        kind: "ScrollFrame"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrameDiabolic.left
        anchors.leftMargin: 30
        anchors.top: questLogFrameDiabolic.top
        anchors.topMargin: 40
        width: 305
        height: 340
    }

    Part {
        id: questLogScrollFrameButton1
        name: "QuestLogScrollFrameButton1"
        kind: "Button"
        text: "Alterac Valley"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameScrollChild.left
        anchors.top: questLogScrollFrameScrollChild.top
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton10
        name: "QuestLogScrollFrameButton10"
        kind: "Button"
        text: "        Overmaster Pyron"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton9.left
        anchors.top: questLogScrollFrameButton9.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton10NormalText
        name: "QuestLogScrollFrameButton10NormalText"
        kind: "FontString"
        text: "        Overmaster Pyron"
        wowParent: "QuestLogScrollFrameButton10"
        anchors.left: questLogScrollFrameButton10.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton10.verticalCenter
        width: 134.3
        height: 10
    }

    Part {
        id: questLogScrollFrameButton10Tag
        name: "QuestLogScrollFrameButton10Tag"
        kind: "FontString"
        text: "(Dungeon)"
        wowParent: "QuestLogScrollFrameButton10"
        anchors.right: questLogScrollFrameButton10.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton10.verticalCenter
        width: 62.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton11
        name: "QuestLogScrollFrameButton11"
        kind: "Button"
        text: "Borean Tundra"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton10.left
        anchors.top: questLogScrollFrameButton10.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton11NormalText
        name: "QuestLogScrollFrameButton11NormalText"
        kind: "FontString"
        text: "Borean Tundra"
        wowParent: "QuestLogScrollFrameButton11"
        anchors.left: questLogScrollFrameButton11.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton11.verticalCenter
        width: 87.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton12
        name: "QuestLogScrollFrameButton12"
        kind: "Button"
        text: "        Surrender... Not!"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton11.left
        anchors.top: questLogScrollFrameButton11.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton12NormalText
        name: "QuestLogScrollFrameButton12NormalText"
        kind: "FontString"
        text: "        Surrender... Not!"
        wowParent: "QuestLogScrollFrameButton12"
        anchors.left: questLogScrollFrameButton12.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton12.verticalCenter
        width: 123.3
        height: 10
    }

    Part {
        id: questLogScrollFrameButton12Tag
        name: "QuestLogScrollFrameButton12Tag"
        kind: "FontString"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton12"
        anchors.right: questLogScrollFrameButton12.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton12.verticalCenter
        width: 66.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton13
        name: "QuestLogScrollFrameButton13"
        kind: "Button"
        text: "Darnassus"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton12.left
        anchors.top: questLogScrollFrameButton12.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton13NormalText
        name: "QuestLogScrollFrameButton13NormalText"
        kind: "FontString"
        text: "Darnassus"
        wowParent: "QuestLogScrollFrameButton13"
        anchors.left: questLogScrollFrameButton13.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton13.verticalCenter
        width: 62.4
        height: 10
    }

    Part {
        id: questLogScrollFrameButton14
        name: "QuestLogScrollFrameButton14"
        kind: "Button"
        text: "        Morrowgrain Research"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton13.left
        anchors.top: questLogScrollFrameButton13.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton14NormalText
        name: "QuestLogScrollFrameButton14NormalText"
        kind: "FontString"
        text: "        Morrowgrain Research"
        wowParent: "QuestLogScrollFrameButton14"
        anchors.left: questLogScrollFrameButton14.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton14.verticalCenter
        width: 162
        height: 10
    }

    Part {
        id: questLogScrollFrameButton15
        name: "QuestLogScrollFrameButton15"
        kind: "Button"
        text: "Ironforge"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton14.left
        anchors.top: questLogScrollFrameButton14.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton15NormalText
        name: "QuestLogScrollFrameButton15NormalText"
        kind: "FontString"
        text: "Ironforge"
        wowParent: "QuestLogScrollFrameButton15"
        anchors.left: questLogScrollFrameButton15.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton15.verticalCenter
        width: 57.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton16
        name: "QuestLogScrollFrameButton16"
        kind: "Button"
        text: "        Reclaimers' Business in Desolace"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton15.left
        anchors.top: questLogScrollFrameButton15.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton16NormalText
        name: "QuestLogScrollFrameButton16NormalText"
        kind: "FontString"
        text: "        Reclaimers' Business in Desolace"
        wowParent: "QuestLogScrollFrameButton16"
        anchors.left: questLogScrollFrameButton16.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton16.verticalCenter
        width: 190.6
        height: 10
    }

    Part {
        id: questLogScrollFrameButton16Tag
        name: "QuestLogScrollFrameButton16Tag"
        kind: "FontString"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton16"
        anchors.right: questLogScrollFrameButton16.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton16.verticalCenter
        width: 66.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton17
        name: "QuestLogScrollFrameButton17"
        kind: "Button"
        text: "        Dwarven Justice"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton16.left
        anchors.top: questLogScrollFrameButton16.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton17NormalText
        name: "QuestLogScrollFrameButton17NormalText"
        kind: "FontString"
        text: "        Dwarven Justice"
        wowParent: "QuestLogScrollFrameButton17"
        anchors.left: questLogScrollFrameButton17.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton17.verticalCenter
        width: 121.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton17Tag
        name: "QuestLogScrollFrameButton17Tag"
        kind: "FontString"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton17"
        anchors.right: questLogScrollFrameButton17.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton17.verticalCenter
        width: 66.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton18
        name: "QuestLogScrollFrameButton18"
        kind: "Button"
        text: "Midsummer"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton17.left
        anchors.top: questLogScrollFrameButton17.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton18NormalText
        name: "QuestLogScrollFrameButton18NormalText"
        kind: "FontString"
        text: "Midsummer"
        wowParent: "QuestLogScrollFrameButton18"
        anchors.left: questLogScrollFrameButton18.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton18.verticalCenter
        width: 72.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton19
        name: "QuestLogScrollFrameButton19"
        kind: "Button"
        text: "        Summon Ahune"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton18.left
        anchors.top: questLogScrollFrameButton18.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton19NormalText
        name: "QuestLogScrollFrameButton19NormalText"
        kind: "FontString"
        text: "        Summon Ahune"
        wowParent: "QuestLogScrollFrameButton19"
        anchors.left: questLogScrollFrameButton19.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton19.verticalCenter
        width: 119.3
        height: 10
    }

    Part {
        id: questLogScrollFrameButton19Tag
        name: "QuestLogScrollFrameButton19Tag"
        kind: "FontString"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton19"
        anchors.right: questLogScrollFrameButton19.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton19.verticalCenter
        width: 66.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton1NormalText
        name: "QuestLogScrollFrameButton1NormalText"
        kind: "FontString"
        text: "Alterac Valley"
        wowParent: "QuestLogScrollFrameButton1"
        anchors.left: questLogScrollFrameButton1.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton1.verticalCenter
        width: 83
        height: 10
    }

    Part {
        id: questLogScrollFrameButton2
        name: "QuestLogScrollFrameButton2"
        kind: "Button"
        text: "        The Sovereign Imperative"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton1.left
        anchors.top: questLogScrollFrameButton1.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton20
        name: "QuestLogScrollFrameButton20"
        kind: "Button"
        text: "Seasonal"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton19.left
        anchors.top: questLogScrollFrameButton19.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton20NormalText
        name: "QuestLogScrollFrameButton20NormalText"
        kind: "FontString"
        text: "Seasonal"
        wowParent: "QuestLogScrollFrameButton20"
        anchors.left: questLogScrollFrameButton20.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton20.verticalCenter
        width: 54.5
        height: 10
    }

    Part {
        id: questLogScrollFrameButton21
        name: "QuestLogScrollFrameButton21"
        kind: "Button"
        text: "        \"Let the Fires Come!\""
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton20.left
        anchors.top: questLogScrollFrameButton20.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton21NormalText
        name: "QuestLogScrollFrameButton21NormalText"
        kind: "FontString"
        text: "        \"Let the Fires Come!\""
        wowParent: "QuestLogScrollFrameButton21"
        anchors.left: questLogScrollFrameButton21.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton21.verticalCenter
        width: 155.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton21Tag
        name: "QuestLogScrollFrameButton21Tag"
        kind: "FontString"
        text: "(Daily)"
        wowParent: "QuestLogScrollFrameButton21"
        anchors.right: questLogScrollFrameButton21.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton21.verticalCenter
        width: 38.7
        height: 16
    }

    Part {
        id: questLogScrollFrameButton22
        name: "QuestLogScrollFrameButton22"
        kind: "Button"
        text: "        Chicken Clucking for a Mint"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton21.left
        anchors.top: questLogScrollFrameButton21.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton22NormalText
        name: "QuestLogScrollFrameButton22NormalText"
        kind: "FontString"
        text: "        Chicken Clucking for a Mint"
        wowParent: "QuestLogScrollFrameButton22"
        anchors.left: questLogScrollFrameButton22.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton22.verticalCenter
        width: 187.3
        height: 10
    }

    Part {
        id: questLogScrollFrameButton22Tag
        name: "QuestLogScrollFrameButton22Tag"
        kind: "FontString"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton22"
        anchors.right: questLogScrollFrameButton22.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton22.verticalCenter
        width: 66.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton2NormalText
        name: "QuestLogScrollFrameButton2NormalText"
        kind: "FontString"
        text: "        The Sovereign Imperative"
        wowParent: "QuestLogScrollFrameButton2"
        anchors.left: questLogScrollFrameButton2.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton2.verticalCenter
        width: 177.8
        height: 10
    }

    Part {
        id: questLogScrollFrameButton2Tag
        name: "QuestLogScrollFrameButton2Tag"
        kind: "FontString"
        text: "(PvP)"
        wowParent: "QuestLogScrollFrameButton2"
        anchors.right: questLogScrollFrameButton2.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton2.verticalCenter
        width: 30
        height: 16
    }

    Part {
        id: questLogScrollFrameButton3
        name: "QuestLogScrollFrameButton3"
        kind: "Button"
        text: "Midsummer"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton2.left
        anchors.top: questLogScrollFrameButton2.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton3NormalText
        name: "QuestLogScrollFrameButton3NormalText"
        kind: "FontString"
        text: "Midsummer"
        wowParent: "QuestLogScrollFrameButton3"
        anchors.left: questLogScrollFrameButton3.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton3.verticalCenter
        width: 72.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton4
        name: "QuestLogScrollFrameButton4"
        kind: "Button"
        text: "        Unusual Activity"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton3.left
        anchors.top: questLogScrollFrameButton3.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton4NormalText
        name: "QuestLogScrollFrameButton4NormalText"
        kind: "FontString"
        text: "        Unusual Activity"
        wowParent: "QuestLogScrollFrameButton4"
        anchors.left: questLogScrollFrameButton4.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton4.verticalCenter
        width: 123.3
        height: 10
    }

    Part {
        id: questLogScrollFrameButton4Tag
        name: "QuestLogScrollFrameButton4Tag"
        kind: "FontString"
        text: "(PvP)"
        wowParent: "QuestLogScrollFrameButton4"
        anchors.right: questLogScrollFrameButton4.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton4.verticalCenter
        width: 30
        height: 16
    }

    Part {
        id: questLogScrollFrameButton5
        name: "QuestLogScrollFrameButton5"
        kind: "Button"
        text: "Stormwind City"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton4.left
        anchors.top: questLogScrollFrameButton4.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton5NormalText
        name: "QuestLogScrollFrameButton5NormalText"
        kind: "FontString"
        text: "Stormwind City"
        wowParent: "QuestLogScrollFrameButton5"
        anchors.left: questLogScrollFrameButton5.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton5.verticalCenter
        width: 92.4
        height: 10
    }

    Part {
        id: questLogScrollFrameButton6
        name: "QuestLogScrollFrameButton6"
        kind: "Button"
        text: "        The First and the Last"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton5.left
        anchors.top: questLogScrollFrameButton5.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton6NormalText
        name: "QuestLogScrollFrameButton6NormalText"
        kind: "FontString"
        text: "        The First and the Last"
        wowParent: "QuestLogScrollFrameButton6"
        anchors.left: questLogScrollFrameButton6.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton6.verticalCenter
        width: 152.5
        height: 10
    }

    Part {
        id: questLogScrollFrameButton6Tag
        name: "QuestLogScrollFrameButton6Tag"
        kind: "FontString"
        text: "(Group)"
        wowParent: "QuestLogScrollFrameButton6"
        anchors.right: questLogScrollFrameButton6.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton6.verticalCenter
        width: 45.8
        height: 16
    }

    Part {
        id: questLogScrollFrameButton7
        name: "QuestLogScrollFrameButton7"
        kind: "Button"
        text: "Tanaris"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton6.left
        anchors.top: questLogScrollFrameButton6.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton7NormalText
        name: "QuestLogScrollFrameButton7NormalText"
        kind: "FontString"
        text: "Tanaris"
        wowParent: "QuestLogScrollFrameButton7"
        anchors.left: questLogScrollFrameButton7.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton7.verticalCenter
        width: 42.7
        height: 10
    }

    Part {
        id: questLogScrollFrameButton8
        name: "QuestLogScrollFrameButton8"
        kind: "Button"
        text: "        Find OOX-17/TN!"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton7.left
        anchors.top: questLogScrollFrameButton7.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton8NormalText
        name: "QuestLogScrollFrameButton8NormalText"
        kind: "FontString"
        text: "        Find OOX-17/TN!"
        wowParent: "QuestLogScrollFrameButton8"
        anchors.left: questLogScrollFrameButton8.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton8.verticalCenter
        width: 129.6
        height: 10
    }

    Part {
        id: questLogScrollFrameButton8Tag
        name: "QuestLogScrollFrameButton8Tag"
        kind: "FontString"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton8"
        anchors.right: questLogScrollFrameButton8.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton8.verticalCenter
        width: 66.4
        height: 16
    }

    Part {
        id: questLogScrollFrameButton9
        name: "QuestLogScrollFrameButton9"
        kind: "Button"
        text: "Blackrock Mountain"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton8.left
        anchors.top: questLogScrollFrameButton8.bottom
        width: 299
        height: 16
    }

    Part {
        id: questLogScrollFrameButton9NormalText
        name: "QuestLogScrollFrameButton9NormalText"
        kind: "FontString"
        text: "Blackrock Mountain"
        wowParent: "QuestLogScrollFrameButton9"
        anchors.left: questLogScrollFrameButton9.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton9.verticalCenter
        width: 117.7
        height: 10
    }

    Part {
        id: questLogScrollFrameDiabolicZone
        name: "QuestLogScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "QuestLogScrollFrame"
        anchors.left: questLogScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: questLogScrollFrame.top
        anchors.topMargin: -6
        width: 333
        height: 350
    }

    Part {
        id: questLogScrollFrameScrollBar
        name: "QuestLogScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "QuestLogScrollFrame"
        style: "ScrollBar"
        anchors.left: questLogScrollFrame.right
        anchors.top: questLogScrollFrame.top
        anchors.topMargin: 13
        width: 20
        height: 313
    }

    Part {
        id: questLogScrollFrameScrollBarDiabolicTrack
        name: "QuestLogScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "QuestLogScrollFrameScrollBar"
        anchors.horizontalCenter: questLogScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: questLogScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 343
    }

    Part {
        id: questLogScrollFrameScrollBarScrollDownButton
        name: "QuestLogScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "QuestLogScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogScrollFrameScrollBar.horizontalCenter
        anchors.top: questLogScrollFrameScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: questLogScrollFrameScrollBarScrollUpButton
        name: "QuestLogScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "QuestLogScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogScrollFrameScrollBar.horizontalCenter
        anchors.bottom: questLogScrollFrameScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: questLogScrollFrameScrollChild
        name: "QuestLogScrollFrameScrollChild"
        kind: "Frame"
        wowParent: "QuestLogScrollFrame"
        anchors.left: questLogScrollFrame.left
        anchors.top: questLogScrollFrame.top
        width: 305
        height: 352
    }

    Part {
        id: questLogTitleText
        name: "QuestLogTitleText"
        kind: "FontString"
        text: "Quest Log  4/25"
        wowParent: "QuestLogFrameDiabolicTitlePlate"
        anchors.horizontalCenter: questLogFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: questLogFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 136.7
        height: 14.2
    }

    Ghost { id: questInfoMoneyFrameCopperButton; name: "QuestInfoMoneyFrameCopperButton"; x: 587.7; y: 414.3; width: 0; height: 0 }
    Ghost { id: questLogCountTopRight; name: "QuestLogCountTopRight"; x: 157.3; y: 48.9; width: 0; height: 0 }
}
