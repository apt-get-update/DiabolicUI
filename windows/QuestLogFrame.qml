// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: questLogFrame
    name: "QuestLogFrame"
    width: 682
    height: 447

    FontString {
        id: questInfoDescriptionHeader
        name: "QuestInfoDescriptionHeader"
        text: "Description"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoObjective1.left
        anchors.top: questInfoObjective1.bottom
        anchors.topMargin: 10
        width: 285
        height: 15.8
    }

    FontString {
        id: questInfoDescriptionText
        name: "QuestInfoDescriptionText"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoDescriptionHeader.left
        anchors.top: questInfoDescriptionHeader.bottom
        anchors.topMargin: 5
        width: 285
        height: 202.3
    }

    FontString {
        id: questInfoItemReceiveText
        name: "QuestInfoItemReceiveText"
        text: "You will receive:"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoRewardsHeader.left
        anchors.leftMargin: 3
        anchors.top: questInfoRewardsHeader.bottom
        anchors.topMargin: 5
        width: 106.7
        height: 12.6
    }

    Frame {
        id: questInfoMoneyFrame
        name: "QuestInfoMoneyFrame"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoItemReceiveText.right
        anchors.leftMargin: 15
        anchors.verticalCenter: questInfoItemReceiveText.verticalCenter
        width: 91
        height: 28
    }

    Button {
        id: questInfoMoneyFrameGoldButton
        name: "QuestInfoMoneyFrameGoldButton"
        text: "42"
        wowParent: "QuestInfoMoneyFrame"
        anchors.right: questInfoMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: questInfoMoneyFrameSilverButton.verticalCenter
        width: 38
        height: 19
    }

    FontString {
        id: questInfoMoneyFrameGoldButtonText
        name: "QuestInfoMoneyFrameGoldButtonText"
        text: "42"
        wowParent: "QuestInfoMoneyFrameGoldButton"
        anchors.right: questInfoMoneyFrameGoldButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: questInfoMoneyFrameGoldButton.verticalCenter
        width: 19
        height: 15.8
    }

    Button {
        id: questInfoMoneyFrameSilverButton
        name: "QuestInfoMoneyFrameSilverButton"
        text: "6"
        wowParent: "QuestInfoMoneyFrame"
        anchors.right: questInfoMoneyFrameCopperButton.right
        anchors.verticalCenter: questInfoMoneyFrameCopperButton.verticalCenter
        width: 30.1
        height: 19
    }

    FontString {
        id: questInfoMoneyFrameSilverButtonText
        name: "QuestInfoMoneyFrameSilverButtonText"
        text: "6"
        wowParent: "QuestInfoMoneyFrameSilverButton"
        anchors.right: questInfoMoneyFrameSilverButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: questInfoMoneyFrameSilverButton.verticalCenter
        width: 11.1
        height: 15.8
    }

    FontString {
        id: questInfoObjective1
        name: "QuestInfoObjective1"
        text: "Ahn'kahar Watcher Corpse Burned: 0/1"
        wowParent: "QuestInfoObjectivesFrame"
        anchors.left: questInfoObjectivesFrame.left
        anchors.top: questInfoObjectivesFrame.top
        width: 285
        height: 11.9
    }

    Frame {
        id: questInfoObjectivesFrame
        name: "QuestInfoObjectivesFrame"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoObjectivesText.left
        anchors.top: questInfoObjectivesText.bottom
        anchors.topMargin: 10
        width: 285
        height: 10
    }

    FontString {
        id: questInfoObjectivesText
        name: "QuestInfoObjectivesText"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoTitleHeader.left
        anchors.top: questInfoTitleHeader.bottom
        anchors.topMargin: 5
        width: 285
        height: 88.5
    }

    Frame {
        id: questInfoRewardsFrame
        name: "QuestInfoRewardsFrame"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoDescriptionText.left
        anchors.top: questInfoDescriptionText.bottom
        anchors.topMargin: 10
        width: 285
        height: 10
    }

    FontString {
        id: questInfoRewardsHeader
        name: "QuestInfoRewardsHeader"
        text: "Rewards"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoRewardsFrame.left
        anchors.top: questInfoRewardsFrame.top
        width: 285
        height: 15.8
    }

    Frame {
        id: questInfoSpacerFrame
        name: "QuestInfoSpacerFrame"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questInfoItemReceiveText.left
        anchors.top: questInfoItemReceiveText.bottom
        anchors.topMargin: 10
        width: 5
        height: 5
    }

    FontString {
        id: questInfoTitleHeader
        name: "QuestInfoTitleHeader"
        text: "All Things in Good Time"
        wowParent: "QuestLogDetailScrollChildFrame"
        anchors.left: questLogDetailScrollChildFrame.left
        anchors.leftMargin: 5
        anchors.top: questLogDetailScrollChildFrame.top
        anchors.topMargin: 5
        width: 285
        height: 15.8
    }

    Frame {
        id: questInfoXPFrame
        name: "QuestInfoXPFrame"
        wowParent: "QuestInfoRewardsFrame"
        anchors.left: questInfoItemReceiveText.left
        anchors.top: questInfoItemReceiveText.bottom
        anchors.topMargin: 5
        width: 280
        height: 20
    }

    FontString {
        id: questInfoXPFramePoints
        name: "QuestInfoXPFramePoints"
        text: "10050"
        wowParent: "QuestInfoXPFrame"
        anchors.left: questInfoXPFrameReceiveText.right
        anchors.leftMargin: 15
        anchors.verticalCenter: questInfoXPFrameReceiveText.verticalCenter
        width: 42.7
        height: 15.8
    }

    FontString {
        id: questInfoXPFrameReceiveText
        name: "QuestInfoXPFrameReceiveText"
        text: "Experience:"
        wowParent: "QuestInfoXPFrame"
        anchors.left: questInfoXPFrame.left
        anchors.verticalCenter: questInfoXPFrame.verticalCenter
        width: 74.3
        height: 12.6
    }

    Frame {
        id: questLogControlPanel
        name: "QuestLogControlPanel"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrameDiabolic.left
        anchors.leftMargin: 30
        anchors.bottom: questLogFrameDiabolic.bottom
        anchors.bottomMargin: 28
        width: 321
        height: 26
    }

    Frame {
        id: questLogCount
        name: "QuestLogCount"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrame.left
        anchors.leftMargin: 80
        anchors.top: questLogFrame.top
        anchors.topMargin: 41
        width: 92.4
        height: 20
    }

    Frame {
        id: questLogDetailScrollChildFrame
        name: "QuestLogDetailScrollChildFrame"
        wowParent: "QuestLogDetailScrollFrame"
        anchors.left: questLogDetailScrollFrame.left
        anchors.top: questLogDetailScrollFrame.top
        width: 298
        height: 333
    }

    ScrollFrame {
        id: questLogDetailScrollFrame
        name: "QuestLogDetailScrollFrame"
        wowParent: "QuestLogFrame"
        anchors.right: questLogFrameDiabolic.right
        anchors.rightMargin: 74
        anchors.top: questLogFrameDiabolic.top
        anchors.topMargin: 44
        width: 298
        height: 336
    }

    Frame {
        id: questLogDetailScrollFrameDiabolicPanel
        name: "QuestLogDetailScrollFrameDiabolicPanel"
        wowParent: "QuestLogFrame"
        anchors.left: questLogDetailScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: questLogDetailScrollFrame.top
        anchors.topMargin: -6
        width: 362
        height: 348
    }

    Frame {
        id: questLogDetailScrollFrameDiabolicParchment
        name: "QuestLogDetailScrollFrameDiabolicParchment"
        wowParent: "QuestLogDetailScrollFrame"
        anchors.left: questLogDetailScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: questLogDetailScrollFrame.top
        anchors.topMargin: -4
        width: 336
        height: 344
    }

    Slider {
        id: questLogDetailScrollFrameScrollBar
        name: "QuestLogDetailScrollFrameScrollBar"
        wowParent: "QuestLogDetailScrollFrame"
        style: "ScrollBar"
        anchors.left: questLogDetailScrollFrame.right
        anchors.leftMargin: 26
        anchors.top: questLogDetailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 304
    }

    Frame {
        id: questLogDetailScrollFrameScrollBarDiabolicTrack
        name: "QuestLogDetailScrollFrameScrollBarDiabolicTrack"
        wowParent: "QuestLogDetailScrollFrameScrollBar"
        anchors.horizontalCenter: questLogDetailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: questLogDetailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 338
    }

    Button {
        id: questLogDetailScrollFrameScrollBarScrollDownButton
        name: "QuestLogDetailScrollFrameScrollBarScrollDownButton"
        wowParent: "QuestLogDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogDetailScrollFrameScrollBar.horizontalCenter
        anchors.top: questLogDetailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: questLogDetailScrollFrameScrollBarScrollUpButton
        name: "QuestLogDetailScrollFrameScrollBarScrollUpButton"
        wowParent: "QuestLogDetailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogDetailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: questLogDetailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Button {
        id: questLogFrameAbandonButton
        name: "QuestLogFrameAbandonButton"
        text: "Abandon"
        wowParent: "QuestLogControlPanel"
        style: "Button"
        anchors.left: questLogControlPanel.left
        anchors.verticalCenter: questLogControlPanel.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 110
        height: 21
    }

    FontString {
        id: questLogFrameAbandonButtonText
        name: "QuestLogFrameAbandonButtonText"
        text: "Abandon"
        wowParent: "QuestLogFrameAbandonButton"
        anchors.horizontalCenter: questLogFrameAbandonButton.horizontalCenter
        anchors.verticalCenter: questLogFrameAbandonButton.verticalCenter
        width: 64.8
        height: 11.9
    }

    Button {
        id: questLogFrameCancelButton
        name: "QuestLogFrameCancelButton"
        text: "Close"
        wowParent: "QuestLogFrame"
        anchors.right: questLogFrame.right
        anchors.rightMargin: 7
        anchors.bottom: questLogFrame.bottom
        anchors.bottomMargin: 14
        width: 80
        height: 22
    }

    FontString {
        id: questLogFrameCancelButtonText
        name: "QuestLogFrameCancelButtonText"
        text: "Close"
        wowParent: "QuestLogFrameCancelButton"
        anchors.horizontalCenter: questLogFrameCancelButton.horizontalCenter
        anchors.verticalCenter: questLogFrameCancelButton.verticalCenter
        width: 34.8
        height: 11.9
    }

    Button {
        id: questLogFrameCloseButton
        name: "QuestLogFrameCloseButton"
        wowParent: "QuestLogFrame"
        style: "CloseButton"
        anchors.horizontalCenter: questLogFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: questLogFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Frame {
        id: questLogFrameDiabolic
        name: "QuestLogFrameDiabolic"
        wowParent: "QuestLogFrame"
        anchors.left: questLogFrame.left
        anchors.top: questLogFrame.top
        anchors.topMargin: -36
        width: 752
        height: 463
    }

    Frame {
        id: questLogFrameDiabolicBorder
        name: "QuestLogFrameDiabolicBorder"
        wowParent: "QuestLogFrameDiabolic"
        anchors.left: questLogFrameDiabolic.left
        anchors.top: questLogFrameDiabolic.top
        width: 752
        height: 463
    }

    Frame {
        id: questLogFrameDiabolicFoot
        name: "QuestLogFrameDiabolicFoot"
        wowParent: "QuestLogFrameDiabolic"
        anchors.horizontalCenter: questLogFrameAbandonButton.horizontalCenter
        anchors.horizontalCenterOffset: 291
        anchors.top: questLogFrameAbandonButton.top
        anchors.topMargin: -6
        width: 706
        height: 35.5
    }

    Frame {
        id: questLogFrameDiabolicSocket
        name: "QuestLogFrameDiabolicSocket"
        wowParent: "QuestLogFrameDiabolic"
        anchors.right: questLogFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: questLogFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: questLogFrameDiabolicTitlePlate
        name: "QuestLogFrameDiabolicTitlePlate"
        wowParent: "QuestLogFrameDiabolic"
        anchors.horizontalCenter: questLogFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: questLogFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: questLogFramePushQuestButton
        name: "QuestLogFramePushQuestButton"
        text: "Share"
        wowParent: "QuestLogControlPanel"
        style: "Button"
        anchors.left: questLogFrameAbandonButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: questLogFrameAbandonButton.verticalCenter
        width: 96
        height: 21
    }

    FontString {
        id: questLogFramePushQuestButtonText
        name: "QuestLogFramePushQuestButtonText"
        text: "Share"
        wowParent: "QuestLogFramePushQuestButton"
        anchors.horizontalCenter: questLogFramePushQuestButton.horizontalCenter
        anchors.verticalCenter: questLogFramePushQuestButton.verticalCenter
        width: 41.1
        height: 11.9
    }

    Button {
        id: questLogFrameTrackButton
        name: "QuestLogFrameTrackButton"
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

    FontString {
        id: questLogFrameTrackButtonText
        name: "QuestLogFrameTrackButtonText"
        text: "Track"
        wowParent: "QuestLogFrameTrackButton"
        anchors.horizontalCenter: questLogFrameTrackButton.horizontalCenter
        anchors.verticalCenter: questLogFrameTrackButton.verticalCenter
        width: 43.5
        height: 11.9
    }

    Frame {
        id: questLogHighlightFrame
        name: "QuestLogHighlightFrame"
        wowParent: "QuestLogScrollFrameButton2"
        anchors.left: questLogScrollFrameButton2.left
        anchors.top: questLogScrollFrameButton2.top
        width: 299
        height: 16
    }

    FontString {
        id: questLogQuestCount
        name: "QuestLogQuestCount"
        wowParent: "QuestLogCount"
        anchors.right: questLogCountTopRight.left
        anchors.rightMargin: -1
        anchors.top: questLogCountTopRight.bottom
        anchors.topMargin: -3
        width: 77.4
        height: 10.3
    }

    ScrollFrame {
        id: questLogScrollFrame
        name: "QuestLogScrollFrame"
        wowParent: "QuestLogFrame"
        pin: "all"
        anchors.left: questLogFrameDiabolic.left
        anchors.leftMargin: 30
        anchors.top: questLogFrameDiabolic.top
        anchors.topMargin: 40
        width: 305
        height: 340
    }

    Button {
        id: questLogScrollFrameButton1
        name: "QuestLogScrollFrameButton1"
        text: "Ahn'kahet: The Old Kingdom"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameScrollChild.left
        anchors.top: questLogScrollFrameScrollChild.top
        width: 299
        height: 16
    }

    Button {
        id: questLogScrollFrameButton10
        name: "QuestLogScrollFrameButton10"
        text: "        Overmaster Pyron"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton9.left
        anchors.top: questLogScrollFrameButton9.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton10NormalText
        name: "QuestLogScrollFrameButton10NormalText"
        text: "        Overmaster Pyron"
        wowParent: "QuestLogScrollFrameButton10"
        anchors.left: questLogScrollFrameButton10.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton10.verticalCenter
        width: 134.3
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton10Tag
        name: "QuestLogScrollFrameButton10Tag"
        text: "(Dungeon)"
        wowParent: "QuestLogScrollFrameButton10"
        anchors.right: questLogScrollFrameButton10.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton10.verticalCenter
        width: 62.4
        height: 16
    }

    Button {
        id: questLogScrollFrameButton11
        name: "QuestLogScrollFrameButton11"
        text: "Borean Tundra"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton10.left
        anchors.top: questLogScrollFrameButton10.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton11NormalText
        name: "QuestLogScrollFrameButton11NormalText"
        text: "Borean Tundra"
        wowParent: "QuestLogScrollFrameButton11"
        anchors.left: questLogScrollFrameButton11.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton11.verticalCenter
        width: 87.7
        height: 10
    }

    Button {
        id: questLogScrollFrameButton12
        name: "QuestLogScrollFrameButton12"
        text: "        Surrender... Not!"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton11.left
        anchors.top: questLogScrollFrameButton11.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton12NormalText
        name: "QuestLogScrollFrameButton12NormalText"
        text: "        Surrender... Not!"
        wowParent: "QuestLogScrollFrameButton12"
        anchors.left: questLogScrollFrameButton12.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton12.verticalCenter
        width: 123.3
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton12Tag
        name: "QuestLogScrollFrameButton12Tag"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton12"
        anchors.right: questLogScrollFrameButton12.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton12.verticalCenter
        width: 66.4
        height: 16
    }

    Button {
        id: questLogScrollFrameButton13
        name: "QuestLogScrollFrameButton13"
        text: "Darnassus"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton12.left
        anchors.top: questLogScrollFrameButton12.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton13NormalText
        name: "QuestLogScrollFrameButton13NormalText"
        text: "Darnassus"
        wowParent: "QuestLogScrollFrameButton13"
        anchors.left: questLogScrollFrameButton13.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton13.verticalCenter
        width: 62.4
        height: 10
    }

    Button {
        id: questLogScrollFrameButton14
        name: "QuestLogScrollFrameButton14"
        text: "        Morrowgrain Research"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton13.left
        anchors.top: questLogScrollFrameButton13.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton14NormalText
        name: "QuestLogScrollFrameButton14NormalText"
        text: "        Morrowgrain Research"
        wowParent: "QuestLogScrollFrameButton14"
        anchors.left: questLogScrollFrameButton14.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton14.verticalCenter
        width: 162
        height: 10
    }

    Button {
        id: questLogScrollFrameButton15
        name: "QuestLogScrollFrameButton15"
        text: "Ironforge"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton14.left
        anchors.top: questLogScrollFrameButton14.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton15NormalText
        name: "QuestLogScrollFrameButton15NormalText"
        text: "Ironforge"
        wowParent: "QuestLogScrollFrameButton15"
        anchors.left: questLogScrollFrameButton15.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton15.verticalCenter
        width: 57.7
        height: 10
    }

    Button {
        id: questLogScrollFrameButton16
        name: "QuestLogScrollFrameButton16"
        text: "        Reclaimers' Business in Desolace"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton15.left
        anchors.top: questLogScrollFrameButton15.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton16NormalText
        name: "QuestLogScrollFrameButton16NormalText"
        text: "        Reclaimers' Business in Desolace"
        wowParent: "QuestLogScrollFrameButton16"
        anchors.left: questLogScrollFrameButton16.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton16.verticalCenter
        width: 190.6
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton16Tag
        name: "QuestLogScrollFrameButton16Tag"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton16"
        anchors.right: questLogScrollFrameButton16.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton16.verticalCenter
        width: 66.4
        height: 16
    }

    Button {
        id: questLogScrollFrameButton17
        name: "QuestLogScrollFrameButton17"
        text: "        Dwarven Justice"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton16.left
        anchors.top: questLogScrollFrameButton16.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton17NormalText
        name: "QuestLogScrollFrameButton17NormalText"
        text: "        Dwarven Justice"
        wowParent: "QuestLogScrollFrameButton17"
        anchors.left: questLogScrollFrameButton17.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton17.verticalCenter
        width: 121.7
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton17Tag
        name: "QuestLogScrollFrameButton17Tag"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton17"
        anchors.right: questLogScrollFrameButton17.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton17.verticalCenter
        width: 66.4
        height: 16
    }

    Button {
        id: questLogScrollFrameButton18
        name: "QuestLogScrollFrameButton18"
        text: "Midsummer"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton17.left
        anchors.top: questLogScrollFrameButton17.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton18NormalText
        name: "QuestLogScrollFrameButton18NormalText"
        text: "Midsummer"
        wowParent: "QuestLogScrollFrameButton18"
        anchors.left: questLogScrollFrameButton18.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton18.verticalCenter
        width: 72.7
        height: 10
    }

    Button {
        id: questLogScrollFrameButton19
        name: "QuestLogScrollFrameButton19"
        text: "        Summon Ahune"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton18.left
        anchors.top: questLogScrollFrameButton18.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton19NormalText
        name: "QuestLogScrollFrameButton19NormalText"
        text: "        Summon Ahune"
        wowParent: "QuestLogScrollFrameButton19"
        anchors.left: questLogScrollFrameButton19.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton19.verticalCenter
        width: 119.3
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton19Tag
        name: "QuestLogScrollFrameButton19Tag"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton19"
        anchors.right: questLogScrollFrameButton19.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton19.verticalCenter
        width: 66.4
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton1NormalText
        name: "QuestLogScrollFrameButton1NormalText"
        text: "Ahn'kahet: The Old Kingdom"
        wowParent: "QuestLogScrollFrameButton1"
        anchors.left: questLogScrollFrameButton1.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton1.verticalCenter
        width: 171.5
        height: 10
    }

    Button {
        id: questLogScrollFrameButton2
        name: "QuestLogScrollFrameButton2"
        text: "        All Things in Good Time"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton1.left
        anchors.top: questLogScrollFrameButton1.bottom
        width: 299
        height: 16
    }

    Button {
        id: questLogScrollFrameButton20
        name: "QuestLogScrollFrameButton20"
        text: "Seasonal"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton19.left
        anchors.top: questLogScrollFrameButton19.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton20NormalText
        name: "QuestLogScrollFrameButton20NormalText"
        text: "Seasonal"
        wowParent: "QuestLogScrollFrameButton20"
        anchors.left: questLogScrollFrameButton20.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton20.verticalCenter
        width: 54.5
        height: 10
    }

    Button {
        id: questLogScrollFrameButton21
        name: "QuestLogScrollFrameButton21"
        text: "        \"Let the Fires Come!\""
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton20.left
        anchors.top: questLogScrollFrameButton20.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton21NormalText
        name: "QuestLogScrollFrameButton21NormalText"
        text: "        \"Let the Fires Come!\""
        wowParent: "QuestLogScrollFrameButton21"
        anchors.left: questLogScrollFrameButton21.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton21.verticalCenter
        width: 155.7
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton21Tag
        name: "QuestLogScrollFrameButton21Tag"
        text: "(Daily)"
        wowParent: "QuestLogScrollFrameButton21"
        anchors.right: questLogScrollFrameButton21.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton21.verticalCenter
        width: 38.7
        height: 16
    }

    Button {
        id: questLogScrollFrameButton22
        name: "QuestLogScrollFrameButton22"
        text: "        Chicken Clucking for a Mint"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton21.left
        anchors.top: questLogScrollFrameButton21.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton22NormalText
        name: "QuestLogScrollFrameButton22NormalText"
        text: "        Chicken Clucking for a Mint"
        wowParent: "QuestLogScrollFrameButton22"
        anchors.left: questLogScrollFrameButton22.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton22.verticalCenter
        width: 187.3
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton22Tag
        name: "QuestLogScrollFrameButton22Tag"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton22"
        anchors.right: questLogScrollFrameButton22.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton22.verticalCenter
        width: 66.4
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton2NormalText
        name: "QuestLogScrollFrameButton2NormalText"
        text: "        All Things in Good Time"
        wowParent: "QuestLogScrollFrameButton2"
        anchors.left: questLogScrollFrameButton2.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton2.verticalCenter
        width: 165.9
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton2Tag
        name: "QuestLogScrollFrameButton2Tag"
        text: "(Daily Heroic)"
        wowParent: "QuestLogScrollFrameButton2"
        anchors.right: questLogScrollFrameButton2.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton2.verticalCenter
        width: 80.6
        height: 16
    }

    Button {
        id: questLogScrollFrameButton3
        name: "QuestLogScrollFrameButton3"
        text: "Alterac Valley"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton2.left
        anchors.top: questLogScrollFrameButton2.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton3NormalText
        name: "QuestLogScrollFrameButton3NormalText"
        text: "Alterac Valley"
        wowParent: "QuestLogScrollFrameButton3"
        anchors.left: questLogScrollFrameButton3.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton3.verticalCenter
        width: 83
        height: 10
    }

    Button {
        id: questLogScrollFrameButton4
        name: "QuestLogScrollFrameButton4"
        text: "        The Sovereign Imperative"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton3.left
        anchors.top: questLogScrollFrameButton3.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton4NormalText
        name: "QuestLogScrollFrameButton4NormalText"
        text: "        The Sovereign Imperative"
        wowParent: "QuestLogScrollFrameButton4"
        anchors.left: questLogScrollFrameButton4.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton4.verticalCenter
        width: 177.8
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton4Tag
        name: "QuestLogScrollFrameButton4Tag"
        text: "(PvP)"
        wowParent: "QuestLogScrollFrameButton4"
        anchors.right: questLogScrollFrameButton4.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton4.verticalCenter
        width: 30
        height: 16
    }

    Button {
        id: questLogScrollFrameButton5
        name: "QuestLogScrollFrameButton5"
        text: "Badlands"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton4.left
        anchors.top: questLogScrollFrameButton4.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton5NormalText
        name: "QuestLogScrollFrameButton5NormalText"
        text: "Badlands"
        wowParent: "QuestLogScrollFrameButton5"
        anchors.left: questLogScrollFrameButton5.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton5.verticalCenter
        width: 55.3
        height: 10
    }

    Button {
        id: questLogScrollFrameButton6
        name: "QuestLogScrollFrameButton6"
        text: "        Prospect of Faith"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton5.left
        anchors.top: questLogScrollFrameButton5.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton6NormalText
        name: "QuestLogScrollFrameButton6NormalText"
        text: "        Prospect of Faith"
        wowParent: "QuestLogScrollFrameButton6"
        anchors.left: questLogScrollFrameButton6.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton6.verticalCenter
        width: 126.4
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton6Tag
        name: "QuestLogScrollFrameButton6Tag"
        text: "(Complete)"
        wowParent: "QuestLogScrollFrameButton6"
        anchors.right: questLogScrollFrameButton6.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton6.verticalCenter
        width: 66.4
        height: 16
    }

    Button {
        id: questLogScrollFrameButton7
        name: "QuestLogScrollFrameButton7"
        text: "Blackrock Depths"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton6.left
        anchors.top: questLogScrollFrameButton6.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton7NormalText
        name: "QuestLogScrollFrameButton7NormalText"
        text: "Blackrock Depths"
        wowParent: "QuestLogScrollFrameButton7"
        anchors.left: questLogScrollFrameButton7.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton7.verticalCenter
        width: 102.7
        height: 10
    }

    Button {
        id: questLogScrollFrameButton8
        name: "QuestLogScrollFrameButton8"
        text: "        The Love Potion"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton7.left
        anchors.top: questLogScrollFrameButton7.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton8NormalText
        name: "QuestLogScrollFrameButton8NormalText"
        text: "        The Love Potion"
        wowParent: "QuestLogScrollFrameButton8"
        anchors.left: questLogScrollFrameButton8.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton8.verticalCenter
        width: 121.7
        height: 10
    }

    FontString {
        id: questLogScrollFrameButton8Tag
        name: "QuestLogScrollFrameButton8Tag"
        text: "(Dungeon)"
        wowParent: "QuestLogScrollFrameButton8"
        anchors.right: questLogScrollFrameButton8.right
        anchors.rightMargin: 2
        anchors.verticalCenter: questLogScrollFrameButton8.verticalCenter
        width: 62.4
        height: 16
    }

    Button {
        id: questLogScrollFrameButton9
        name: "QuestLogScrollFrameButton9"
        text: "Blackrock Mountain"
        wowParent: "QuestLogScrollFrameScrollChild"
        anchors.left: questLogScrollFrameButton8.left
        anchors.top: questLogScrollFrameButton8.bottom
        width: 299
        height: 16
    }

    FontString {
        id: questLogScrollFrameButton9NormalText
        name: "QuestLogScrollFrameButton9NormalText"
        text: "Blackrock Mountain"
        wowParent: "QuestLogScrollFrameButton9"
        anchors.left: questLogScrollFrameButton9.left
        anchors.leftMargin: 20
        anchors.verticalCenter: questLogScrollFrameButton9.verticalCenter
        width: 117.7
        height: 10
    }

    Frame {
        id: questLogScrollFrameDiabolicZone
        name: "QuestLogScrollFrameDiabolicZone"
        wowParent: "QuestLogScrollFrame"
        anchors.left: questLogScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: questLogScrollFrame.top
        anchors.topMargin: -6
        width: 333
        height: 350
    }

    Slider {
        id: questLogScrollFrameScrollBar
        name: "QuestLogScrollFrameScrollBar"
        wowParent: "QuestLogScrollFrame"
        style: "ScrollBar"
        anchors.left: questLogScrollFrame.right
        anchors.top: questLogScrollFrame.top
        anchors.topMargin: 13
        width: 20
        height: 313
    }

    Frame {
        id: questLogScrollFrameScrollBarDiabolicTrack
        name: "QuestLogScrollFrameScrollBarDiabolicTrack"
        wowParent: "QuestLogScrollFrameScrollBar"
        anchors.horizontalCenter: questLogScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: questLogScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 343
    }

    Button {
        id: questLogScrollFrameScrollBarScrollDownButton
        name: "QuestLogScrollFrameScrollBarScrollDownButton"
        wowParent: "QuestLogScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogScrollFrameScrollBar.horizontalCenter
        anchors.top: questLogScrollFrameScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Button {
        id: questLogScrollFrameScrollBarScrollUpButton
        name: "QuestLogScrollFrameScrollBarScrollUpButton"
        wowParent: "QuestLogScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: questLogScrollFrameScrollBar.horizontalCenter
        anchors.bottom: questLogScrollFrameScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Frame {
        id: questLogScrollFrameScrollChild
        name: "QuestLogScrollFrameScrollChild"
        wowParent: "QuestLogScrollFrame"
        anchors.left: questLogScrollFrame.left
        anchors.top: questLogScrollFrame.top
        width: 305
        height: 352
    }

    FontString {
        id: questLogTitleText
        name: "QuestLogTitleText"
        text: "Quest Log  23/25"
        wowParent: "QuestLogFrameDiabolicTitlePlate"
        anchors.horizontalCenter: questLogFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: questLogFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 145.4
        height: 14.2
    }

    Ghost { id: questInfoMoneyFrameCopperButton; name: "QuestInfoMoneyFrameCopperButton"; x: 587.7; y: 414.3; width: 0; height: 0 }
    Ghost { id: questLogCountTopRight; name: "QuestLogCountTopRight"; x: 164.4; y: 48.9; width: 0; height: 0 }
}
