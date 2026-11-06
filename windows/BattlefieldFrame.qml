// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: battlefieldFrame
    name: "BattlefieldFrame"
    width: 400
    height: 400

    Part {
        id: battlefieldFrameCancelButton
        name: "BattlefieldFrameCancelButton"
        kind: "Button"
        text: "Cancel"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 266
        anchors.bottom: battlefieldFrame.bottom
        anchors.bottomMargin: 78
        width: 80.5
        height: 22
    }

    Part {
        id: battlefieldFrameCancelButtonText
        name: "BattlefieldFrameCancelButtonText"
        kind: "FontString"
        text: "Cancel"
        anchors.horizontalCenter: battlefieldFrameCancelButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameCancelButton.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: battlefieldFrameCloseButton
        name: "BattlefieldFrameCloseButton"
        kind: "Button"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 337
        anchors.top: battlefieldFrame.top
        anchors.topMargin: 20
        width: 22
        height: 22
    }

    Part {
        id: battlefieldFrameGroupJoinButton
        name: "BattlefieldFrameGroupJoinButton"
        kind: "Button"
        text: "Join as Group"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 16.5
        anchors.bottom: battlefieldFrame.bottom
        anchors.bottomMargin: 78
        width: 131.9
        height: 22
    }

    Part {
        id: battlefieldFrameGroupJoinButtonText
        name: "BattlefieldFrameGroupJoinButtonText"
        kind: "FontString"
        text: "Join as Group"
        anchors.horizontalCenter: battlefieldFrameGroupJoinButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameGroupJoinButton.verticalCenter
        width: 78
        height: 12
    }

    // the rewards on slate too, under the instances: 16 higher (its panel clear
    // of the buttons), its top 7 lower (apart from theirs; Blizzard's 232 high)
    Part {
        id: battlefieldFrameInfoScrollFrame
        name: "BattlefieldFrameInfoScrollFrame"
        kind: "ScrollFrame"
        pin: "all"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 19
        anchors.bottom: battlefieldFrame.bottom
        anchors.bottomMargin: 116
        width: 298
        height: 209
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrame
        name: "BattlefieldFrameInfoScrollFrameChildFrame"
        kind: "Frame"
        anchors.left: battlefieldFrameInfoScrollFrame.left
        anchors.top: battlefieldFrameInfoScrollFrame.top
        width: 1
        height: 1
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        kind: "Frame"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrame.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrame.top
        width: 298
        height: 232
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription"
        kind: "FontString"
        text: "Your urgent assistance is needed to combat our foes! Completing this Battleground will earn you extra rewards."
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle.bottom
        anchors.topMargin: 5
        width: 660
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        kind: "Frame"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.bottom
        anchors.topMargin: 2
        width: 319
        height: 40
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount"
        kind: "FontString"
        text: "620"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.verticalCenter
        width: 18
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
        kind: "FontString"
        text: "Loss"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward.verticalCenter
        width: 24
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
        kind: "FontString"
        text: "Rewards"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription.bottom
        anchors.topMargin: 10
        width: 42
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle"
        kind: "FontString"
        text: "Call to Arms"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo.left
        anchors.leftMargin: 20
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo.top
        anchors.topMargin: 15
        width: 72
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        kind: "Frame"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.left
        anchors.leftMargin: -19
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.bottom
        anchors.topMargin: 15
        width: 319
        height: 40
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount"
        kind: "FontString"
        text: "25"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount"
        kind: "FontString"
        text: "3720"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.verticalCenter
        width: 24
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
        kind: "FontString"
        text: "Win"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.verticalCenter
        width: 18
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBar
        name: "BattlefieldFrameInfoScrollFrameScrollBar"
        kind: "Slider"
        anchors.left: battlefieldFrameInfoScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: battlefieldFrameInfoScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 177
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBarScrollDownButton
        name: "BattlefieldFrameInfoScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.top: battlefieldFrameInfoScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton
        name: "BattlefieldFrameInfoScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.bottom: battlefieldFrameInfoScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: battlefieldFrameJoinButton
        name: "BattlefieldFrameJoinButton"
        kind: "Button"
        text: "Join Battle"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 154.4
        anchors.bottom: battlefieldFrame.bottom
        anchors.bottomMargin: 78
        width: 105.7
        height: 22
    }

    Part {
        id: battlefieldFrameJoinButtonText
        name: "BattlefieldFrameJoinButtonText"
        kind: "FontString"
        text: "Join Battle"
        anchors.horizontalCenter: battlefieldFrameJoinButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameJoinButton.verticalCenter
        width: 66
        height: 12
    }

    // "Battlefield Instance:" 5 higher, apart from its list
    Part {
        id: battlefieldFrameNameHeader
        name: "BattlefieldFrameNameHeader"
        kind: "FontString"
        text: "Battlefield Instance:"
        pin: "place"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 75
        anchors.top: battlefieldFrame.top
        anchors.topMargin: 50
        width: 126
        height: 12
    }

    Part {
        id: battlefieldZone1
        name: "BattlefieldZone1"
        kind: "Button"
        text: "First Available"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 23
        anchors.top: battlefieldFrame.top
        anchors.topMargin: 79
        width: 315
        height: 16
    }

    Part {
        id: battlefieldZone1Text
        name: "BattlefieldZone1Text"
        kind: "FontString"
        text: "First Available"
        anchors.left: battlefieldZone1.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlefieldZone1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 90
        height: 12
    }

    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol"; x: 0; y: 0; width: 0; height: 0 }
}
