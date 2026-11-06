// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: bankFrame
    name: "BankFrame"
    width: 425
    height: 512

    Button {
        id: bankCloseButton
        name: "BankCloseButton"
        wowParent: "BankFrame"
        style: "CloseButton"
        anchors.horizontalCenter: bankFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: bankFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Button {
        id: bankFrameBag1
        name: "BankFrameBag1"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem22.left
        anchors.top: bankFrameItem22.bottom
        anchors.topMargin: 32
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag1HighlightFrame
        name: "BankFrameBag1HighlightFrame"
        wowParent: "BankFrameBag1"
        anchors.left: bankFrameBag1.left
        anchors.top: bankFrameBag1.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameBag2
        name: "BankFrameBag2"
        wowParent: "BankFrame"
        anchors.left: bankFrameBag1.right
        anchors.leftMargin: 12
        anchors.top: bankFrameBag1.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag2HighlightFrame
        name: "BankFrameBag2HighlightFrame"
        wowParent: "BankFrameBag2"
        anchors.left: bankFrameBag2.left
        anchors.top: bankFrameBag2.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameBag3
        name: "BankFrameBag3"
        wowParent: "BankFrame"
        anchors.left: bankFrameBag2.right
        anchors.leftMargin: 12
        anchors.top: bankFrameBag2.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag3HighlightFrame
        name: "BankFrameBag3HighlightFrame"
        wowParent: "BankFrameBag3"
        anchors.left: bankFrameBag3.left
        anchors.top: bankFrameBag3.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameBag4
        name: "BankFrameBag4"
        wowParent: "BankFrame"
        anchors.left: bankFrameBag3.right
        anchors.leftMargin: 12
        anchors.top: bankFrameBag3.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag4HighlightFrame
        name: "BankFrameBag4HighlightFrame"
        wowParent: "BankFrameBag4"
        anchors.left: bankFrameBag4.left
        anchors.top: bankFrameBag4.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameBag5
        name: "BankFrameBag5"
        wowParent: "BankFrame"
        anchors.left: bankFrameBag4.right
        anchors.leftMargin: 12
        anchors.top: bankFrameBag4.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag5HighlightFrame
        name: "BankFrameBag5HighlightFrame"
        wowParent: "BankFrameBag5"
        anchors.left: bankFrameBag5.left
        anchors.top: bankFrameBag5.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameBag6
        name: "BankFrameBag6"
        wowParent: "BankFrame"
        anchors.left: bankFrameBag5.right
        anchors.leftMargin: 12
        anchors.top: bankFrameBag5.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag6HighlightFrame
        name: "BankFrameBag6HighlightFrame"
        wowParent: "BankFrameBag6"
        anchors.left: bankFrameBag6.left
        anchors.top: bankFrameBag6.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameBag7
        name: "BankFrameBag7"
        wowParent: "BankFrame"
        anchors.left: bankFrameBag6.right
        anchors.leftMargin: 12
        anchors.top: bankFrameBag6.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameBag7HighlightFrame
        name: "BankFrameBag7HighlightFrame"
        wowParent: "BankFrameBag7"
        anchors.left: bankFrameBag7.left
        anchors.top: bankFrameBag7.top
        width: 37
        height: 37
    }

    Frame {
        id: bankFrameDiabolic
        name: "BankFrameDiabolic"
        wowParent: "BankFrame"
        anchors.left: bankFrame.left
        anchors.leftMargin: -24
        anchors.top: bankFrame.top
        width: 443
        height: 478
    }

    Frame {
        id: bankFrameDiabolicBorder
        name: "BankFrameDiabolicBorder"
        wowParent: "BankFrameDiabolic"
        anchors.left: bankFrameDiabolic.left
        anchors.top: bankFrameDiabolic.top
        width: 443
        height: 478
    }

    Frame {
        id: bankFrameDiabolicSocket
        name: "BankFrameDiabolicSocket"
        wowParent: "BankFrameDiabolic"
        anchors.right: bankFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: bankFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: bankFrameDiabolicTitlePlate
        name: "BankFrameDiabolicTitlePlate"
        wowParent: "BankFrameDiabolic"
        anchors.horizontalCenter: bankFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: bankFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: bankFrameItem1
        name: "BankFrameItem1"
        wowParent: "BankFrame"
        anchors.left: bankFrame.left
        anchors.leftMargin: 40
        anchors.top: bankFrame.top
        anchors.topMargin: 73
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem1Count
        name: "BankFrameItem1Count"
        text: "18"
        wowParent: "BankFrameItem1"
        anchors.right: bankFrameItem1.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem1.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Frame {
        id: bankFrameMoneyFrame
        name: "BankFrameMoneyFrame"
        wowParent: "BankFrame"
        anchors.right: bankFrame.right
        anchors.rightMargin: 30
        anchors.bottom: bankFrame.bottom
        anchors.bottomMargin: 103
        width: 126.4
        height: 13
    }

    Button {
        id: bankFrameMoneyFrameCopperButton
        name: "BankFrameMoneyFrameCopperButton"
        text: "13"
        wowParent: "BankFrameMoneyFrame"
        anchors.right: bankFrameMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: bankFrameMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: bankFrameMoneyFrameCopperButtonText
        name: "BankFrameMoneyFrameCopperButtonText"
        text: "13"
        wowParent: "BankFrameMoneyFrameCopperButton"
        anchors.right: bankFrameMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: bankFrameMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameMoneyFrameGoldButton
        name: "BankFrameMoneyFrameGoldButton"
        text: "3654"
        wowParent: "BankFrameMoneyFrame"
        anchors.right: bankFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: bankFrameMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    FontString {
        id: bankFrameMoneyFrameGoldButtonText
        name: "BankFrameMoneyFrameGoldButtonText"
        text: "3654"
        wowParent: "BankFrameMoneyFrameGoldButton"
        anchors.right: bankFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: bankFrameMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Button {
        id: bankFrameMoneyFrameSilverButton
        name: "BankFrameMoneyFrameSilverButton"
        text: "16"
        wowParent: "BankFrameMoneyFrame"
        anchors.right: bankFrameMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: bankFrameMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: bankFrameMoneyFrameSilverButtonText
        name: "BankFrameMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "BankFrameMoneyFrameSilverButton"
        anchors.right: bankFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: bankFrameMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: bankFrameTitleText
        name: "BankFrameTitleText"
        text: "Newton Burnside"
        wowParent: "BankFrameDiabolicTitlePlate"
        anchors.horizontalCenter: bankFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: bankFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 157.2
        height: 14.2
    }

    Ghost { id: bankFrameItem22; name: "BankFrameItem22"; x: 40; y: 205; width: 37; height: 37 }
}
