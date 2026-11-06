// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: pVPParentFrame
    name: "PVPParentFrame"
    width: 384
    height: 512

    // the battlegrounds' block (title row, list, rewards) 5 left: in the middle
    Part {
        id: battlegroundType1
        name: "BattlegroundType1"
        kind: "Button"
        text: "Random Battleground"
        wowParent: "PVPBattlegroundFrame"
        pin: "place"
        anchors.left: pVPBattlegroundFrame.left
        anchors.leftMargin: 18
        anchors.top: pVPBattlegroundFrame.top
        anchors.topMargin: 79
        width: 295
        height: 16
    }

    Part {
        id: battlegroundType1Text
        name: "BattlegroundType1Text"
        kind: "FontString"
        text: "Random Battleground"
        wowParent: "BattlegroundType1"
        anchors.left: battlegroundType1.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlegroundType1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 130.4
        height: 11.9
    }

    Part {
        id: battlegroundType2
        name: "BattlegroundType2"
        kind: "Button"
        text: "Arathi Basin (Call to Arms)"
        wowParent: "PVPBattlegroundFrame"
        anchors.left: battlegroundType1.left
        anchors.top: battlegroundType1.bottom
        width: 295
        height: 16
    }

    Part {
        id: battlegroundType2Text
        name: "BattlegroundType2Text"
        kind: "FontString"
        text: "Arathi Basin (Call to Arms)"
        wowParent: "BattlegroundType2"
        anchors.left: battlegroundType2.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlegroundType2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 155.7
        height: 11.9
    }

    Part {
        id: battlegroundType3
        name: "BattlegroundType3"
        kind: "Button"
        text: "Warsong Gulch"
        wowParent: "PVPBattlegroundFrame"
        anchors.left: battlegroundType2.left
        anchors.top: battlegroundType2.bottom
        width: 295
        height: 16
    }

    Part {
        id: battlegroundType3Text
        name: "BattlegroundType3Text"
        kind: "FontString"
        text: "Warsong Gulch"
        wowParent: "BattlegroundType3"
        anchors.left: battlegroundType3.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlegroundType3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 91.7
        height: 11.9
    }

    Part {
        id: battlegroundType4
        name: "BattlegroundType4"
        kind: "Button"
        text: "Alterac Valley"
        wowParent: "PVPBattlegroundFrame"
        anchors.left: battlegroundType3.left
        anchors.top: battlegroundType3.bottom
        width: 295
        height: 16
    }

    Part {
        id: battlegroundType4Text
        name: "BattlegroundType4Text"
        kind: "FontString"
        text: "Alterac Valley"
        wowParent: "BattlegroundType4"
        anchors.left: battlegroundType4.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlegroundType4.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 83
        height: 11.9
    }

    Part {
        id: battlegroundType5
        name: "BattlegroundType5"
        kind: "Button"
        text: "Eye of the Storm"
        wowParent: "PVPBattlegroundFrame"
        anchors.left: battlegroundType4.left
        anchors.top: battlegroundType4.bottom
        width: 295
        height: 16
    }

    Part {
        id: battlegroundType5Text
        name: "BattlegroundType5Text"
        kind: "FontString"
        text: "Eye of the Storm"
        wowParent: "BattlegroundType5"
        anchors.left: battlegroundType5.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlegroundType5.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 99.6
        height: 11.9
    }

    Part {
        id: pVPBattlegroundFrame
        name: "PVPBattlegroundFrame"
        kind: "Frame"
        wowParent: "PVPParentFrame"
        anchors.left: pVPParentFrame.left
        anchors.leftMargin: 2
        anchors.top: pVPParentFrame.top
        anchors.topMargin: 1
        width: 384
        height: 512
    }

    // 8 apart
    Part {
        id: pVPBattlegroundFrameCancelButton
        name: "PVPBattlegroundFrameCancelButton"
        kind: "Button"
        text: "Cancel"
        wowParent: "PVPBattlegroundFrame"
        style: "Button"
        pin: "place"
        anchors.left: pVPBattlegroundFrameJoinButton.right
        anchors.leftMargin: 8
        anchors.verticalCenter: pVPBattlegroundFrameJoinButton.verticalCenter
        width: 83
        height: 22
    }

    Part {
        id: pVPBattlegroundFrameCancelButtonText
        name: "PVPBattlegroundFrameCancelButtonText"
        kind: "FontString"
        text: "Cancel"
        wowParent: "PVPBattlegroundFrameCancelButton"
        anchors.horizontalCenter: pVPBattlegroundFrameCancelButton.horizontalCenter
        anchors.verticalCenter: pVPBattlegroundFrameCancelButton.verticalCenter
        width: 51.4
        height: 11.9
    }

    Part {
        id: pVPBattlegroundFrameFrameLabel
        name: "PVPBattlegroundFrameFrameLabel"
        kind: "FontString"
        text: "Battlegrounds"
        wowParent: "PVPBattlegroundFrame"
        anchors.horizontalCenter: pVPBattlegroundFrame.horizontalCenter
        anchors.top: pVPBattlegroundFrame.top
        anchors.topMargin: 17
        width: 84.5
        height: 11.9
    }

    // 8 apart
    Part {
        id: pVPBattlegroundFrameGroupJoinButton
        name: "PVPBattlegroundFrameGroupJoinButton"
        kind: "Button"
        text: "Join as Party"
        wowParent: "PVPBattlegroundFrame"
        style: "Button"
        pin: "place"
        anchors.right: pVPBattlegroundFrameJoinButton.left
        anchors.rightMargin: 8
        anchors.verticalCenter: pVPBattlegroundFrameJoinButton.verticalCenter
        width: 136
        height: 22
    }

    Part {
        id: pVPBattlegroundFrameGroupJoinButtonText
        name: "PVPBattlegroundFrameGroupJoinButtonText"
        kind: "FontString"
        text: "Join as Party"
        wowParent: "PVPBattlegroundFrameGroupJoinButton"
        anchors.horizontalCenter: pVPBattlegroundFrameGroupJoinButton.horizontalCenter
        anchors.verticalCenter: pVPBattlegroundFrameGroupJoinButton.verticalCenter
        width: 101.9
        height: 11.9
    }

    // the rewards 208 high (Blizzard's 232): 6 over the foot's iron bar, 6 under the list
    Part {
        id: pVPBattlegroundFrameInfoScrollFrame
        name: "PVPBattlegroundFrameInfoScrollFrame"
        kind: "ScrollFrame"
        wowParent: "PVPBattlegroundFrame"
        pin: "all"
        anchors.left: pVPBattlegroundFrame.left
        anchors.leftMargin: 15
        anchors.bottom: pVPBattlegroundFrame.bottom
        anchors.bottomMargin: 122
        width: 298
        height: 208
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrame
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrame"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameInfoScrollFrame"
        anchors.left: pVPBattlegroundFrameInfoScrollFrame.left
        anchors.top: pVPBattlegroundFrameInfoScrollFrame.top
        width: 1
        height: 1
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrame"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrame.left
        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrame.top
        width: 298
        height: 232
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription"
        kind: "FontString"
        text: "Completing Random Battlegrounds will earn you extra rewards."
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle.left
        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle.bottom
        anchors.topMargin: 5
        width: 280
        height: 25.3
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward.bottom
        anchors.topMargin: 2
        width: 319
        height: 40
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount"
        kind: "FontString"
        text: "620"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.verticalCenter
        width: 65
        height: 12
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
        kind: "FontString"
        text: "Loss"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossReward.verticalCenter
        width: 90
        height: 10
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
        kind: "FontString"
        text: "Rewards"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription.left
        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoDescription.bottom
        anchors.topMargin: 10
        width: 84.5
        height: 15.8
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoTitle"
        kind: "FontString"
        text: "Random Battleground"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo.left
        anchors.leftMargin: 20
        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo.top
        anchors.topMargin: 15
        width: 225.2
        height: 15.8
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.left
        anchors.leftMargin: -19
        anchors.top: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.bottom
        anchors.topMargin: 15
        width: 319
        height: 40
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount"
        kind: "FontString"
        text: "25"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.verticalCenter
        width: 65
        height: 12
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount"
        kind: "FontString"
        text: "3720"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.verticalCenter
        width: 65
        height: 12
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel
        name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
        kind: "FontString"
        text: "Win"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinReward.verticalCenter
        width: 90
        height: 10
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameDiabolicZone
        name: "PVPBattlegroundFrameInfoScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrame"
        anchors.horizontalCenter: pVPBattlegroundFrameInfoScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 12.5
        anchors.top: pVPBattlegroundFrameInfoScrollFrame.top
        anchors.topMargin: -6
        width: 329
        height: 220
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameScrollBar
        name: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "PVPBattlegroundFrameInfoScrollFrame"
        style: "ScrollBar"
        anchors.left: pVPBattlegroundFrameInfoScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: pVPBattlegroundFrameInfoScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 176
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameScrollBarDiabolicTrack
        name: "PVPBattlegroundFrameInfoScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
        anchors.horizontalCenter: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 210
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollDownButton
        name: "PVPBattlegroundFrameInfoScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: pVPBattlegroundFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.top: pVPBattlegroundFrameInfoScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: pVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton
        name: "PVPBattlegroundFrameInfoScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "PVPBattlegroundFrameInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: pVPBattlegroundFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.bottom: pVPBattlegroundFrameInfoScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    // the buttons in the middle of the window's foot (its middle 15 left of the
    // frame's; Join as Party wider than Cancel, so Join Battle 27 right of it),
    // room between the rewards and the foot
    Part {
        id: pVPBattlegroundFrameJoinButton
        name: "PVPBattlegroundFrameJoinButton"
        kind: "Button"
        text: "Join Battle"
        wowParent: "PVPBattlegroundFrame"
        style: "Button"
        pin: "place"
        anchors.horizontalCenter: pVPParentFrame.horizontalCenter
        anchors.horizontalCenterOffset: 12
        anchors.bottom: pVPParentFrame.bottom
        anchors.bottomMargin: 69
        width: 109
        height: 22
    }

    Part {
        id: pVPBattlegroundFrameJoinButtonText
        name: "PVPBattlegroundFrameJoinButtonText"
        kind: "FontString"
        text: "Join Battle"
        wowParent: "PVPBattlegroundFrameJoinButton"
        anchors.horizontalCenter: pVPBattlegroundFrameJoinButton.horizontalCenter
        anchors.verticalCenter: pVPBattlegroundFrameJoinButton.verticalCenter
        width: 84.5
        height: 11.9
    }

    Part {
        id: pVPBattlegroundFrameNameHeader
        name: "PVPBattlegroundFrameNameHeader"
        kind: "FontString"
        text: "Battleground"
        wowParent: "PVPBattlegroundFrame"
        pin: "place"
        anchors.left: pVPBattlegroundFrame.left
        anchors.leftMargin: 65
        anchors.top: pVPBattlegroundFrame.top
        anchors.topMargin: 53
        width: 78.2
        height: 11.9
    }

    // as wide with no scroll bar: Blizzard widens the rows it hangs from when
    // the list doesn't scroll, and the panels would follow
    Part {
        id: pVPBattlegroundFrameTypeScrollFrame
        name: "PVPBattlegroundFrameTypeScrollFrame"
        kind: "ScrollFrame"
        wowParent: "PVPBattlegroundFrame"
        pin: "all"
        anchors.left: battlegroundType1.left
        anchors.top: battlegroundType1.top
        anchors.topMargin: -2
        width: 295
        height: 87
    }

    Part {
        id: pVPBattlegroundFrameTypeScrollFrameDiabolicZone
        name: "PVPBattlegroundFrameTypeScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrame"
        anchors.left: pVPBattlegroundFrameTypeScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: pVPBattlegroundFrameTypeScrollFrame.top
        anchors.topMargin: -6
        width: 329
        height: 99
    }

    Part {
        id: pVPBattlegroundFrameTypeScrollFrameScrollBar
        name: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "PVPBattlegroundFrameTypeScrollFrame"
        style: "ScrollBar"
        anchors.left: pVPBattlegroundFrameTypeScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: pVPBattlegroundFrameTypeScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 55
    }

    Part {
        id: pVPBattlegroundFrameTypeScrollFrameScrollBarDiabolicTrack
        name: "PVPBattlegroundFrameTypeScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
        anchors.horizontalCenter: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 89
    }

    Part {
        id: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollDownButton
        name: "PVPBattlegroundFrameTypeScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: pVPBattlegroundFrameTypeScrollFrameScrollBar.horizontalCenter
        anchors.top: pVPBattlegroundFrameTypeScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: pVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton
        name: "PVPBattlegroundFrameTypeScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "PVPBattlegroundFrameTypeScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: pVPBattlegroundFrameTypeScrollFrameScrollBar.horizontalCenter
        anchors.bottom: pVPBattlegroundFrameTypeScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: pVPBattlegroundFrameTypeScrollFrameScrollChildFrame
        name: "PVPBattlegroundFrameTypeScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrameTypeScrollFrame"
        anchors.left: pVPBattlegroundFrameTypeScrollFrame.left
        anchors.top: pVPBattlegroundFrameTypeScrollFrame.top
        width: 300
        height: 112
    }

    Part {
        id: pVPFrame
        name: "PVPFrame"
        kind: "Frame"
        wowParent: "PVPParentFrame"
        anchors.left: pVPParentFrame.left
        anchors.top: pVPParentFrame.top
        width: 384
        height: 512
    }

    Part {
        id: pVPFrameArena
        name: "PVPFrameArena"
        kind: "Frame"
        wowParent: "PVPFrame"
        anchors.left: pVPFrameBackground.left
        anchors.leftMargin: 120
        anchors.top: pVPFrameBackground.top
        anchors.topMargin: 95
        width: 300
        height: 20
    }

    Part {
        id: pVPFrameArenaLabel
        name: "PVPFrameArenaLabel"
        kind: "FontString"
        text: "ARENA:"
        wowParent: "PVPFrameArena"
        anchors.left: pVPFrameArena.left
        anchors.verticalCenter: pVPFrameArena.verticalCenter
        width: 41.9
        height: 10.3
    }

    Part {
        id: pVPFrameArenaPoints
        name: "PVPFrameArenaPoints"
        kind: "FontString"
        text: "0"
        wowParent: "PVPFrameArena"
        anchors.left: pVPFrameArenaLabel.right
        anchors.leftMargin: 15
        anchors.verticalCenter: pVPFrameArenaLabel.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: pVPFrameHonor
        name: "PVPFrameHonor"
        kind: "Frame"
        wowParent: "PVPFrame"
        anchors.left: pVPFrameBackground.left
        anchors.leftMargin: 118
        anchors.top: pVPFrameBackground.top
        anchors.topMargin: 2
        width: 300
        height: 20
    }

    Part {
        id: pVPFrameHonorLabel
        name: "PVPFrameHonorLabel"
        kind: "FontString"
        text: "HONOR:"
        wowParent: "PVPFrameHonor"
        anchors.left: pVPFrameHonor.left
        anchors.verticalCenter: pVPFrameHonor.verticalCenter
        width: 47.4
        height: 10.3
    }

    Part {
        id: pVPFrameHonorPoints
        name: "PVPFrameHonorPoints"
        kind: "FontString"
        text: "50130"
        wowParent: "PVPFrameHonor"
        anchors.left: pVPFrameHonorLabel.right
        anchors.leftMargin: 15
        anchors.verticalCenter: pVPFrameHonorLabel.verticalCenter
        width: 38.7
        height: 11.9
    }

    Part {
        id: pVPHonor
        name: "PVPHonor"
        kind: "Frame"
        wowParent: "PVPFrame"
        anchors.left: pVPFrameBackground.left
        anchors.leftMargin: 15
        anchors.top: pVPFrameBackground.top
        anchors.topMargin: 28
        width: 300
        height: 100
    }

    Part {
        id: pVPHonorHonorLabel
        name: "PVPHonorHonorLabel"
        kind: "FontString"
        text: "Honor"
        wowParent: "PVPHonor"
        anchors.right: pVPHonorKillsLabel.right
        anchors.top: pVPHonorKillsLabel.bottom
        anchors.topMargin: 8
        width: 50
        height: 12
    }

    Part {
        id: pVPHonorKillsLabel
        name: "PVPHonorKillsLabel"
        kind: "FontString"
        text: "Kills"
        wowParent: "PVPHonor"
        anchors.left: pVPHonor.left
        anchors.leftMargin: 20
        anchors.top: pVPHonor.top
        anchors.topMargin: 24
        width: 40
        height: 12
    }

    Part {
        id: pVPHonorLifetimeHonor
        name: "PVPHonorLifetimeHonor"
        kind: "FontString"
        text: "-"
        wowParent: "PVPHonor"
        anchors.horizontalCenter: pVPHonorLifetimeKills.horizontalCenter
        anchors.top: pVPHonorLifetimeKills.bottom
        anchors.topMargin: 5
        width: 50
        height: 14
    }

    Part {
        id: pVPHonorLifetimeKills
        name: "PVPHonorLifetimeKills"
        kind: "FontString"
        text: "66"
        wowParent: "PVPHonor"
        anchors.horizontalCenter: pVPHonorLifetimeLabel.horizontalCenter
        anchors.top: pVPHonorLifetimeLabel.bottom
        anchors.topMargin: 10
        width: 50
        height: 14
    }

    Part {
        id: pVPHonorLifetimeLabel
        name: "PVPHonorLifetimeLabel"
        kind: "FontString"
        text: "Lifetime"
        wowParent: "PVPHonor"
        anchors.left: pVPHonorKillsLabel.right
        anchors.leftMargin: 170
        anchors.bottom: pVPHonorKillsLabel.top
        anchors.bottomMargin: 10
        width: 45
        height: 10.3
    }

    Part {
        id: pVPHonorTodayHonor
        name: "PVPHonorTodayHonor"
        kind: "FontString"
        text: "0"
        wowParent: "PVPHonor"
        anchors.horizontalCenter: pVPHonorTodayKills.horizontalCenter
        anchors.top: pVPHonorTodayKills.bottom
        anchors.topMargin: 5
        width: 50
        height: 14
    }

    Part {
        id: pVPHonorTodayKills
        name: "PVPHonorTodayKills"
        kind: "FontString"
        text: "0"
        wowParent: "PVPHonor"
        anchors.horizontalCenter: pVPHonorTodayLabel.horizontalCenter
        anchors.top: pVPHonorTodayLabel.bottom
        anchors.topMargin: 10
        width: 50
        height: 14
    }

    Part {
        id: pVPHonorTodayLabel
        name: "PVPHonorTodayLabel"
        kind: "FontString"
        text: "Today"
        wowParent: "PVPHonor"
        anchors.left: pVPHonorKillsLabel.right
        anchors.leftMargin: 20
        anchors.bottom: pVPHonorKillsLabel.top
        anchors.bottomMargin: 10
        width: 34.8
        height: 10.3
    }

    Part {
        id: pVPHonorYesterdayHonor
        name: "PVPHonorYesterdayHonor"
        kind: "FontString"
        text: "0"
        wowParent: "PVPHonor"
        anchors.horizontalCenter: pVPHonorYesterdayKills.horizontalCenter
        anchors.top: pVPHonorYesterdayKills.bottom
        anchors.topMargin: 5
        width: 50
        height: 14
    }

    Part {
        id: pVPHonorYesterdayKills
        name: "PVPHonorYesterdayKills"
        kind: "FontString"
        text: "0"
        wowParent: "PVPHonor"
        anchors.horizontalCenter: pVPHonorYesterdayLabel.horizontalCenter
        anchors.top: pVPHonorYesterdayLabel.bottom
        anchors.topMargin: 10
        width: 50
        height: 14
    }

    Part {
        id: pVPHonorYesterdayLabel
        name: "PVPHonorYesterdayLabel"
        kind: "FontString"
        text: "Yesterday"
        wowParent: "PVPHonor"
        anchors.left: pVPHonorKillsLabel.right
        anchors.leftMargin: 90
        anchors.bottom: pVPHonorKillsLabel.top
        anchors.bottomMargin: 10
        width: 53.7
        height: 10.3
    }

    Part {
        id: pVPParentFrameCloseButton
        name: "PVPParentFrameCloseButton"
        kind: "Button"
        wowParent: "PVPParentFrame"
        style: "CloseButton"
        anchors.horizontalCenter: pVPParentFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: pVPParentFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: pVPParentFrameDiabolic
        name: "PVPParentFrameDiabolic"
        kind: "Frame"
        wowParent: "PVPParentFrame"
        anchors.left: pVPParentFrame.left
        anchors.leftMargin: -24
        anchors.top: pVPParentFrame.top
        anchors.topMargin: -28
        width: 402
        height: 501
    }

    Part {
        id: pVPParentFrameDiabolicBorder
        name: "PVPParentFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "PVPParentFrameDiabolic"
        anchors.left: pVPParentFrameDiabolic.left
        anchors.top: pVPParentFrameDiabolic.top
        anchors.topMargin: 32
        width: 402
        height: 469
    }

    Part {
        id: pVPParentFrameDiabolicFoot
        name: "PVPParentFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "PVPParentFrameDiabolic"
        anchors.horizontalCenter: pVPBattlegroundFrameJoinButton.horizontalCenter
        anchors.horizontalCenterOffset: -27
        anchors.top: pVPBattlegroundFrameJoinButton.top
        anchors.topMargin: -6
        width: 356
        height: 35
    }

    Part {
        id: pVPParentFrameDiabolicRail
        name: "PVPParentFrameDiabolicRail"
        kind: "Frame"
        wowParent: "PVPParentFrameDiabolic"
        anchors.left: pVPParentFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: pVPParentFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Part {
        id: pVPParentFrameDiabolicSocket
        name: "PVPParentFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "PVPParentFrameDiabolic"
        anchors.right: pVPParentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: pVPParentFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: pVPParentFrameDiabolicTitlePlate
        name: "PVPParentFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "PVPParentFrameDiabolic"
        anchors.horizontalCenter: pVPParentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: pVPParentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: pVPParentFrameTab1
        name: "PVPParentFrameTab1"
        kind: "Button"
        text: "PvP"
        wowParent: "PVPParentFrame"
        style: "Banner"
        anchors.left: pVPParentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: pVPParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: pVPParentFrameTab2
        name: "PVPParentFrameTab2"
        kind: "Button"
        text: "Battlegrounds"
        wowParent: "PVPParentFrame"
        style: "Banner"
        anchors.left: pVPParentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: pVPParentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: pVPTeam1
        name: "PVPTeam1"
        kind: "Button"
        wowParent: "PVPFrame"
        anchors.left: pVPTeam1Standard.left
        anchors.leftMargin: 33
        anchors.verticalCenter: pVPTeam1Standard.verticalCenter
        width: 300
        height: 78
    }

    Part {
        id: pVPTeam1Standard
        name: "PVPTeam1Standard"
        kind: "Frame"
        wowParent: "PVPFrame"
        anchors.left: pVPFrameBackground.left
        anchors.leftMargin: 13
        anchors.verticalCenter: pVPFrameBackground.verticalCenter
        anchors.verticalCenterOffset: -85
        width: 64
        height: 64
    }

    Part {
        id: pVPTeam1TeamType
        name: "PVPTeam1TeamType"
        kind: "FontString"
        text: "(2v2)"
        wowParent: "PVPTeam1"
        anchors.horizontalCenter: pVPTeam1.horizontalCenter
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenter: pVPTeam1.verticalCenter
        width: 41.9
        height: 15.8
    }

    Part {
        id: pVPTeam2
        name: "PVPTeam2"
        kind: "Button"
        wowParent: "PVPFrame"
        anchors.left: pVPTeam2Standard.left
        anchors.leftMargin: 33
        anchors.verticalCenter: pVPTeam2Standard.verticalCenter
        width: 300
        height: 78
    }

    Part {
        id: pVPTeam2Standard
        name: "PVPTeam2Standard"
        kind: "Frame"
        wowParent: "PVPFrame"
        anchors.left: pVPFrameBackground.left
        anchors.leftMargin: 13
        anchors.verticalCenter: pVPFrameBackground.verticalCenter
        width: 64
        height: 64
    }

    Part {
        id: pVPTeam2TeamType
        name: "PVPTeam2TeamType"
        kind: "FontString"
        text: "(3v3)"
        wowParent: "PVPTeam2"
        anchors.horizontalCenter: pVPTeam2.horizontalCenter
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenter: pVPTeam2.verticalCenter
        width: 41.9
        height: 15.8
    }

    Part {
        id: pVPTeam3
        name: "PVPTeam3"
        kind: "Button"
        wowParent: "PVPFrame"
        anchors.left: pVPTeam3Standard.left
        anchors.leftMargin: 33
        anchors.verticalCenter: pVPTeam3Standard.verticalCenter
        width: 300
        height: 78
    }

    Part {
        id: pVPTeam3Standard
        name: "PVPTeam3Standard"
        kind: "Frame"
        wowParent: "PVPFrame"
        anchors.left: pVPFrameBackground.left
        anchors.leftMargin: 13
        anchors.verticalCenter: pVPFrameBackground.verticalCenter
        anchors.verticalCenterOffset: 85
        width: 64
        height: 64
    }

    Part {
        id: pVPTeam3TeamType
        name: "PVPTeam3TeamType"
        kind: "FontString"
        text: "(5v5)"
        wowParent: "PVPTeam3"
        anchors.horizontalCenter: pVPTeam3.horizontalCenter
        anchors.horizontalCenterOffset: -8
        anchors.verticalCenter: pVPTeam3.verticalCenter
        width: 41.9
        height: 15.8
    }

    Part {
        id: wintergraspTimer
        name: "WintergraspTimer"
        kind: "Frame"
        wowParent: "PVPBattlegroundFrame"
        pin: "place"
        anchors.right: pVPBattlegroundFrame.right
        anchors.rightMargin: 45
        anchors.verticalCenter: pVPBattlegroundFrame.top
        anchors.verticalCenterOffset: 53
        width: 32
        height: 32
    }

    Ghost { id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol; name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"; x: 150; y: 346.9; width: 0; height: 0 }
    Ghost { id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol; name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"; x: 255; y: 304.9; width: 0; height: 0 }
    Ghost { id: pVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol; name: "PVPBattlegroundFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol"; x: 150; y: 304.9; width: 0; height: 0 }
    Ghost { id: pVPFrameBackground; name: "PVPFrameBackground"; x: 14; y: 36; width: 0; height: 512 }
}
