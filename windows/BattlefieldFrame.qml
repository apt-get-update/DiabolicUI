// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: battlefieldFrame
    name: "BattlefieldFrame"
    width: 384
    height: 512

    Button {
        id: battlefieldFrameCancelButton
        name: "BattlefieldFrameCancelButton"
        text: "Cancel"
        wowParent: "BattlefieldFrame"
        style: "Button"
        pin: "all"
        anchors.left: battlefieldFrameJoinButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: battlefieldFrameJoinButton.verticalCenter
        width: 75.6
        height: 22
    }

    FontString {
        id: battlefieldFrameCancelButtonText
        name: "BattlefieldFrameCancelButtonText"
        text: "Cancel"
        wowParent: "BattlefieldFrameCancelButton"
        anchors.horizontalCenter: battlefieldFrameCancelButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameCancelButton.verticalCenter
        width: 51.4
        height: 11.9
    }

    Button {
        id: battlefieldFrameCloseButton
        name: "BattlefieldFrameCloseButton"
        wowParent: "BattlefieldFrame"
        style: "CloseButton"
        anchors.horizontalCenter: battlefieldFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: battlefieldFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Frame {
        id: battlefieldFrameDiabolic
        name: "BattlefieldFrameDiabolic"
        wowParent: "BattlefieldFrame"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: -19
        anchors.top: battlefieldFrame.top
        width: 398
        height: 473
    }

    Frame {
        id: battlefieldFrameDiabolicBorder
        name: "BattlefieldFrameDiabolicBorder"
        wowParent: "BattlefieldFrameDiabolic"
        anchors.left: battlefieldFrameDiabolic.left
        anchors.top: battlefieldFrameDiabolic.top
        width: 398
        height: 473
    }

    Frame {
        id: battlefieldFrameDiabolicSocket
        name: "BattlefieldFrameDiabolicSocket"
        wowParent: "BattlefieldFrameDiabolic"
        anchors.right: battlefieldFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: battlefieldFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: battlefieldFrameDiabolicTitlePlate
        name: "BattlefieldFrameDiabolicTitlePlate"
        wowParent: "BattlefieldFrameDiabolic"
        anchors.horizontalCenter: battlefieldFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: battlefieldFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    FontString {
        id: battlefieldFrameFrameLabel
        name: "BattlefieldFrameFrameLabel"
        text: "Arathi Basin"
        wowParent: "BattlefieldFrameDiabolicTitlePlate"
        anchors.horizontalCenter: battlefieldFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: battlefieldFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 113
        height: 14.2
    }

    Button {
        id: battlefieldFrameGroupJoinButton
        name: "BattlefieldFrameGroupJoinButton"
        text: "Join as Group"
        wowParent: "BattlefieldFrame"
        style: "Button"
        pin: "all"
        anchors.left: battlefieldFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: battlefieldFrameDiabolic.bottom
        anchors.bottomMargin: 39
        width: 127.7
        height: 22
    }

    FontString {
        id: battlefieldFrameGroupJoinButtonText
        name: "BattlefieldFrameGroupJoinButtonText"
        text: "Join as Group"
        wowParent: "BattlefieldFrameGroupJoinButton"
        anchors.horizontalCenter: battlefieldFrameGroupJoinButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameGroupJoinButton.verticalCenter
        width: 103.5
        height: 11.9
    }

    // the rewards on slate too, under the instances: 16 higher (its panel clear
    // of the buttons), its top 7 lower (apart from theirs; Blizzard's 232 high)
    ScrollFrame {
        id: battlefieldFrameInfoScrollFrame
        name: "BattlefieldFrameInfoScrollFrame"
        wowParent: "BattlefieldFrame"
        pin: "all"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 19
        anchors.bottom: battlefieldFrame.bottom
        anchors.bottomMargin: 116
        width: 298
        height: 209
    }

    Frame {
        id: battlefieldFrameInfoScrollFrameChildFrame
        name: "BattlefieldFrameInfoScrollFrameChildFrame"
        wowParent: "BattlefieldFrameInfoScrollFrame"
        anchors.left: battlefieldFrameInfoScrollFrame.left
        anchors.top: battlefieldFrameInfoScrollFrame.top
        width: 1
        height: 1
    }

    Frame {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrame"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrame.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrame.top
        width: 298
        height: 232
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription"
        text: "Your urgent assistance is needed to combat our foes! Completing this Battleground will earn you extra rewards."
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle.bottom
        anchors.topMargin: 5
        width: 280
        height: 37.9
    }

    Frame {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.bottom
        anchors.topMargin: 2
        width: 319
        height: 40
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorAmount"
        text: "620"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol.verticalCenter
        width: 65
        height: 12
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardLabel"
        text: "Loss"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossReward.verticalCenter
        width: 90
        height: 10
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel"
        text: "Rewards"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription.left
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription.bottom
        anchors.topMargin: 10
        width: 84.5
        height: 15.8
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoTitle"
        text: "Call to Arms"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo.left
        anchors.leftMargin: 20
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfo.top
        anchors.topMargin: 15
        width: 130.4
        height: 15.8
    }

    Frame {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfo"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.left
        anchors.leftMargin: -19
        anchors.top: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoRewardsLabel.bottom
        anchors.topMargin: 15
        width: 319
        height: 40
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaAmount"
        text: "25"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol.verticalCenter
        width: 65
        height: 12
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorAmount"
        text: "3720"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.right
        anchors.leftMargin: 3
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol.verticalCenter
        width: 65
        height: 12
    }

    FontString {
        id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel
        name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardLabel"
        text: "Win"
        wowParent: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward"
        anchors.left: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.left
        anchors.leftMargin: 5
        anchors.verticalCenter: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinReward.verticalCenter
        width: 90
        height: 10
    }

    Frame {
        id: battlefieldFrameInfoScrollFrameDiabolicZone
        name: "BattlefieldFrameInfoScrollFrameDiabolicZone"
        wowParent: "BattlefieldFrame"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrame.horizontalCenter
        anchors.horizontalCenterOffset: 12
        anchors.top: battlefieldFrameInfoScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 221
    }

    Slider {
        id: battlefieldFrameInfoScrollFrameScrollBar
        name: "BattlefieldFrameInfoScrollFrameScrollBar"
        wowParent: "BattlefieldFrameInfoScrollFrame"
        style: "ScrollBar"
        anchors.left: battlefieldFrameInfoScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: battlefieldFrameInfoScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 177
    }

    Frame {
        id: battlefieldFrameInfoScrollFrameScrollBarDiabolicTrack
        name: "BattlefieldFrameInfoScrollFrameScrollBarDiabolicTrack"
        wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 211
    }

    Button {
        id: battlefieldFrameInfoScrollFrameScrollBarScrollDownButton
        name: "BattlefieldFrameInfoScrollFrameScrollBarScrollDownButton"
        wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.top: battlefieldFrameInfoScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: battlefieldFrameInfoScrollFrameScrollBarScrollUpButton
        name: "BattlefieldFrameInfoScrollFrameScrollBarScrollUpButton"
        wowParent: "BattlefieldFrameInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: battlefieldFrameInfoScrollFrameScrollBar.horizontalCenter
        anchors.bottom: battlefieldFrameInfoScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Button {
        id: battlefieldFrameJoinButton
        name: "BattlefieldFrameJoinButton"
        text: "Join Battle"
        wowParent: "BattlefieldFrame"
        style: "Button"
        pin: "all"
        anchors.left: battlefieldFrameGroupJoinButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: battlefieldFrameGroupJoinButton.verticalCenter
        width: 108.7
        height: 22
    }

    FontString {
        id: battlefieldFrameJoinButtonText
        name: "BattlefieldFrameJoinButtonText"
        text: "Join Battle"
        wowParent: "BattlefieldFrameJoinButton"
        anchors.horizontalCenter: battlefieldFrameJoinButton.horizontalCenter
        anchors.verticalCenter: battlefieldFrameJoinButton.verticalCenter
        width: 84.5
        height: 11.9
    }

    // "Battlefield Instance:" 5 higher, apart from its list
    FontString {
        id: battlefieldFrameNameHeader
        name: "BattlefieldFrameNameHeader"
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

    Frame {
        id: battlefieldListScrollFrameDiabolicZone
        name: "BattlefieldListScrollFrameDiabolicZone"
        wowParent: "BattlefieldFrame"
        anchors.left: battlefieldListScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: battlefieldListScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 107
    }

    Button {
        id: battlefieldZone1
        name: "BattlefieldZone1"
        text: "First Available"
        wowParent: "BattlefieldFrame"
        anchors.left: battlefieldFrame.left
        anchors.leftMargin: 23
        anchors.top: battlefieldFrame.top
        anchors.topMargin: 79
        width: 315
        height: 16
    }

    FontString {
        id: battlefieldZone1Text
        name: "BattlefieldZone1Text"
        text: "First Available"
        wowParent: "BattlefieldZone1"
        anchors.left: battlefieldZone1.left
        anchors.leftMargin: 20
        anchors.verticalCenter: battlefieldZone1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 84.5
        height: 11.9
    }

    WowRow {
        name: "BattlefieldButtons"
        parts: ["BattlefieldFrameGroupJoinButton", "BattlefieldFrameJoinButton", "BattlefieldFrameCancelButton"]
        anchors.left: battlefieldFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.right: battlefieldFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: battlefieldFrameDiabolic.bottom
        anchors.bottomMargin: 39
    }

    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoLossRewardHonorSymbol"; x: 152; y: 363.5; width: 0; height: 0 }
    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardArenaSymbol"; x: 257; y: 321.5; width: 0; height: 0 }
    Ghost { id: battlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol; name: "BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoWinRewardHonorSymbol"; x: 152; y: 321.5; width: 0; height: 0 }
    Ghost { id: battlefieldListScrollFrame; name: "BattlefieldListScrollFrame"; x: 21; y: 74; width: 0; height: 0 }
}
