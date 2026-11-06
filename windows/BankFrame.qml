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

    Button {
        id: bankFrameItem10
        name: "BankFrameItem10"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem9.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem9.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem11
        name: "BankFrameItem11"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem10.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem10.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem12
        name: "BankFrameItem12"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem11.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem11.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem13
        name: "BankFrameItem13"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem12.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem12.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem13Count
        name: "BankFrameItem13Count"
        text: "11"
        wowParent: "BankFrameItem13"
        anchors.right: bankFrameItem13.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem13.bottom
        anchors.bottomMargin: 2
        width: 15
        height: 14.2
    }

    Button {
        id: bankFrameItem14
        name: "BankFrameItem14"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem13.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem13.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem14Count
        name: "BankFrameItem14Count"
        text: "20"
        wowParent: "BankFrameItem14"
        anchors.right: bankFrameItem14.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem14.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameItem15
        name: "BankFrameItem15"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem8.left
        anchors.top: bankFrameItem8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem15Count
        name: "BankFrameItem15Count"
        text: "20"
        wowParent: "BankFrameItem15"
        anchors.right: bankFrameItem15.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem15.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameItem16
        name: "BankFrameItem16"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem15.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem15.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem16Count
        name: "BankFrameItem16Count"
        text: "13"
        wowParent: "BankFrameItem16"
        anchors.right: bankFrameItem16.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem16.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameItem17
        name: "BankFrameItem17"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem16.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem16.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem17Count
        name: "BankFrameItem17Count"
        text: "2"
        wowParent: "BankFrameItem17"
        anchors.right: bankFrameItem17.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem17.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: bankFrameItem18
        name: "BankFrameItem18"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem17.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem17.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem19
        name: "BankFrameItem19"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem18.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem18.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem19Count
        name: "BankFrameItem19Count"
        text: "4"
        wowParent: "BankFrameItem19"
        anchors.right: bankFrameItem19.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem19.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
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

    Button {
        id: bankFrameItem2
        name: "BankFrameItem2"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem1.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem1.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem20
        name: "BankFrameItem20"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem19.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem19.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem20Count
        name: "BankFrameItem20Count"
        text: "20"
        wowParent: "BankFrameItem20"
        anchors.right: bankFrameItem20.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem20.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameItem21
        name: "BankFrameItem21"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem20.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem20.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem22
        name: "BankFrameItem22"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem15.left
        anchors.top: bankFrameItem15.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem23
        name: "BankFrameItem23"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem22.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem22.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem24
        name: "BankFrameItem24"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem23.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem23.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem25
        name: "BankFrameItem25"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem24.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem24.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem25Count
        name: "BankFrameItem25Count"
        text: "20"
        wowParent: "BankFrameItem25"
        anchors.right: bankFrameItem25.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem25.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameItem26
        name: "BankFrameItem26"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem25.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem25.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem27
        name: "BankFrameItem27"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem26.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem26.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem28
        name: "BankFrameItem28"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem27.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem27.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem28Count
        name: "BankFrameItem28Count"
        text: "14"
        wowParent: "BankFrameItem28"
        anchors.right: bankFrameItem28.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem28.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: bankFrameItem3
        name: "BankFrameItem3"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem2.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem2.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem4
        name: "BankFrameItem4"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem3.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem3.top
        width: 37
        height: 37
    }

    FontString {
        id: bankFrameItem4Count
        name: "BankFrameItem4Count"
        text: "2"
        wowParent: "BankFrameItem4"
        anchors.right: bankFrameItem4.right
        anchors.rightMargin: 5
        anchors.bottom: bankFrameItem4.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: bankFrameItem5
        name: "BankFrameItem5"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem4.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem4.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem6
        name: "BankFrameItem6"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem5.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem5.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem7
        name: "BankFrameItem7"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem6.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem6.top
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem8
        name: "BankFrameItem8"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem1.left
        anchors.top: bankFrameItem1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Button {
        id: bankFrameItem9
        name: "BankFrameItem9"
        wowParent: "BankFrame"
        anchors.left: bankFrameItem8.right
        anchors.leftMargin: 12
        anchors.top: bankFrameItem8.top
        width: 37
        height: 37
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

}
