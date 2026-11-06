// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: battlefieldFrame
    name: "BattlefieldFrame"
    width: 384
    height: 512

    Part {
        id: battlefieldFrameCancelButton
        name: "BattlefieldFrameCancelButton"
        kind: "Button"
        text: "Cancel"
        wowParent: "BattlefieldFrame"
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
        wowParent: "BattlefieldFrameCancelButton"
        anchors.horizontalCenter: battlefieldFrameCancelButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameCancelButton.verticalCenter
        width: 51.4
        height: 11.9
    }

    Part {
        id: battlefieldFrameCloseButton
        name: "BattlefieldFrameCloseButton"
        kind: "Button"
        wowParent: "BattlefieldFrame"
        anchors.horizontalCenter: battlefieldFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: battlefieldFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: battlefieldFrameDiabolic
        name: "BattlefieldFrameDiabolic"
        kind: "Frame"
        wowParent: "BattlefieldFrame"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: -19
        anchors.top: battlefieldFrame.top
        width: 398
        height: 473
    }

    Part {
        id: battlefieldFrameDiabolicBorder
        name: "BattlefieldFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "BattlefieldFrameDiabolic"
        anchors.left: battlefieldFrameDiabolic.left
        anchors.top: battlefieldFrameDiabolic.top
        width: 398
        height: 473
    }

    Part {
        id: battlefieldFrameDiabolicSocket
        name: "BattlefieldFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "BattlefieldFrameDiabolic"
        anchors.right: battlefieldFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: battlefieldFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: battlefieldFrameDiabolicTitlePlate
        name: "BattlefieldFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "BattlefieldFrameDiabolic"
        anchors.horizontalCenter: battlefieldFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: battlefieldFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: battlefieldFrameFrameLabel
        name: "BattlefieldFrameFrameLabel"
        kind: "FontString"
        text: "Eye of the Storm"
        wowParent: "BattlefieldFrameDiabolicTitlePlate"
        anchors.horizontalCenter: battlefieldFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: battlefieldFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 158
        height: 14.2
    }

    Part {
        id: battlefieldFrameGroupJoinButton
        name: "BattlefieldFrameGroupJoinButton"
        kind: "Button"
        text: "Join as Group"
        wowParent: "BattlefieldFrame"
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
        wowParent: "BattlefieldFrameGroupJoinButton"
        anchors.horizontalCenter: battlefieldFrameGroupJoinButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameGroupJoinButton.verticalCenter
        width: 103.5
        height: 11.9
    }

    // the rewards on slate too, under the instances: 16 higher (its panel clear
    // of the buttons), its top 7 lower (apart from theirs; Blizzard's 232 high)
    Part {
        id: battlefieldFrameInfoScrollFrame
        name: "BattlefieldFrameInfoScrollFrame"
        kind: "ScrollFrame"
        wowParent: "BattlefieldFrame"
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
        wowParent: "BattlefieldFrameInfoScrollFrame"
        anchors.left: battlefieldFrameInfoScrollFrame.left
        anchors.top: battlefieldFrameInfoScrollFrame.top
        width: 1
        height: 1
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        kind: "Frame"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrame"
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
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle.bottom
        anchors.topMargin: 5
        width: 280
        height: 37.9
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        kind: "Frame"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
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
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.verticalCenter
        width: 65
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
        kind: "FontString"
        text: "Loss"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward.verticalCenter
        width: 90
        height: 10
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
        kind: "FontString"
        text: "Rewards"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription.bottom
        anchors.topMargin: 10
        width: 84.5
        height: 15.8
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle"
        kind: "FontString"
        text: "Call to Arms"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo.left
        anchors.leftMargin: 20
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo.top
        anchors.topMargin: 15
        width: 130.4
        height: 15.8
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        kind: "Frame"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
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
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.verticalCenter
        width: 65
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount"
        kind: "FontString"
        text: "3720"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.verticalCenter
        width: 65
        height: 12
    }

    Part {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
        kind: "FontString"
        text: "Win"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.verticalCenter
        width: 90
        height: 10
    }

    Part {
        id: battlefieldFrameInfoScrollFrameDiabolicZone
        name: "BattlefieldFrameInfoScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "BattlefieldFrame"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 12
        anchors.top: battlefieldFrameInfoScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 221
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBar
        name: "BattlefieldFrameInfoScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "BattlefieldFrameInfoScrollFrame"
        anchors.left: battlefieldFrameInfoScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: battlefieldFrameInfoScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 177
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBarDiabolicTrack
        name: "BattlefieldFrameInfoScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 211
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBarScrollDownButton
        name: "BattlefieldFrameInfoScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.top: battlefieldFrameInfoScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton
        name: "BattlefieldFrameInfoScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
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
        wowParent: "BattlefieldFrame"
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
        wowParent: "BattlefieldFrameJoinButton"
        anchors.horizontalCenter: battlefieldFrameJoinButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameJoinButton.verticalCenter
        width: 84.5
        height: 11.9
    }

    // "Battlefield Instance:" 5 higher, apart from its list
    Part {
        id: battlefieldFrameNameHeader
        name: "BattlefieldFrameNameHeader"
        kind: "FontString"
        text: "Battlefield Instance:"
        wowParent: "BattlefieldFrame"
        pin: "place"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 75
        anchors.top: battlefieldFrame.top
        anchors.topMargin: 50
        width: 117.7
        height: 11.9
    }

    Part {
        id: battlefieldListScrollFrameDiabolicZone
        name: "BattlefieldListScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "BattlefieldFrame"
        anchors.left: battlefieldListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: battlefieldListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 107
    }

    Part {
        id: battlefieldZone1
        name: "BattlefieldZone1"
        kind: "Button"
        text: "First Available"
        wowParent: "BattlefieldFrame"
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
        wowParent: "BattlefieldZone1"
        anchors.left: battlefieldZone1.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlefieldZone1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 84.5
        height: 11.9
    }

    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"; x: 152; y: 363.5; width: 0; height: 0 }
    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"; x: 257; y: 321.5; width: 0; height: 0 }
    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol"; x: 152; y: 321.5; width: 0; height: 0 }
    Ghost { id: battlefieldListScrollFrame; name: "BattlefieldListScrollFrame"; x: 21; y: 74; width: 0; height: 0 }
}
