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
    Ghost { id: questLogScrollFrameButton2; name: "QuestLogScrollFrameButton2"; x: 30; y: 20; width: 299; height: 16 }
}
