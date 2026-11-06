// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: merchantFrame
    name: "MerchantFrame"
    width: 384
    height: 512

    Button {
        id: diabolicSellJunkButton
        name: "DiabolicSellJunkButton"
        text: "Sell Junk"
        wowParent: "MerchantFrame"
        style: "Button"
        pin: "place"
        anchors.right: merchantFrameDiabolic.right
        anchors.rightMargin: 32
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 434
        width: 90
        height: 22
    }

    FontString {
        id: diabolicSellJunkButtonText
        name: "DiabolicSellJunkButtonText"
        text: "Sell Junk"
        wowParent: "DiabolicSellJunkButton"
        anchors.horizontalCenter: diabolicSellJunkButton.horizontalCenter
        anchors.verticalCenter: diabolicSellJunkButton.verticalCenter
        width: 68
        height: 11.9
    }

    Frame {
        id: merchantBuyBackItem
        name: "MerchantBuyBackItem"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.2
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 433.8
        width: 153
        height: 37
    }

    Button {
        id: merchantBuyBackItemItemButton
        name: "MerchantBuyBackItemItemButton"
        wowParent: "MerchantBuyBackItem"
        anchors.left: merchantBuyBackItem.left
        anchors.top: merchantBuyBackItem.top
        width: 37.5
        height: 36.4
    }

    FontString {
        id: merchantBuyBackItemItemButtonCount
        name: "MerchantBuyBackItemItemButtonCount"
        text: "20"
        wowParent: "MerchantBuyBackItemItemButton"
        anchors.right: merchantBuyBackItemItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantBuyBackItemItemButton.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Frame {
        id: merchantBuyBackItemMoneyFrame
        name: "MerchantBuyBackItemMoneyFrame"
        wowParent: "MerchantBuyBackItem"
        anchors.left: merchantBuyBackItemNameFrame.left
        anchors.bottom: merchantBuyBackItemNameFrame.bottom
        anchors.bottomMargin: 25
        width: 69.1
        height: 13
    }

    Button {
        id: merchantBuyBackItemMoneyFrameGoldButton
        name: "MerchantBuyBackItemMoneyFrameGoldButton"
        text: "1"
        wowParent: "MerchantBuyBackItemMoneyFrame"
        anchors.right: merchantBuyBackItemMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantBuyBackItemMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: merchantBuyBackItemMoneyFrameGoldButtonText
        name: "MerchantBuyBackItemMoneyFrameGoldButtonText"
        text: "1"
        wowParent: "MerchantBuyBackItemMoneyFrameGoldButton"
        anchors.right: merchantBuyBackItemMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantBuyBackItemMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Button {
        id: merchantBuyBackItemMoneyFrameSilverButton
        name: "MerchantBuyBackItemMoneyFrameSilverButton"
        text: "10"
        wowParent: "MerchantBuyBackItemMoneyFrame"
        anchors.right: merchantBuyBackItemMoneyFrameCopperButton.right
        anchors.verticalCenter: merchantBuyBackItemMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantBuyBackItemMoneyFrameSilverButtonText
        name: "MerchantBuyBackItemMoneyFrameSilverButtonText"
        text: "10"
        wowParent: "MerchantBuyBackItemMoneyFrameSilverButton"
        anchors.right: merchantBuyBackItemMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantBuyBackItemMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantBuyBackItemName
        name: "MerchantBuyBackItemName"
        wowParent: "MerchantBuyBackItem"
        anchors.left: merchantBuyBackItemItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantBuyBackItemItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Button {
        id: merchantFrameCloseButton
        name: "MerchantFrameCloseButton"
        wowParent: "MerchantFrame"
        style: "CloseButton"
        anchors.horizontalCenter: merchantFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: merchantFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: merchantFrameDiabolic
        name: "MerchantFrameDiabolic"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrame.left
        anchors.top: merchantFrame.top
        anchors.topMargin: -36
        width: 500
        height: 508
    }

    Frame {
        id: merchantFrameDiabolicBorder
        name: "MerchantFrameDiabolicBorder"
        wowParent: "MerchantFrameDiabolic"
        anchors.left: merchantFrameDiabolic.left
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 32
        width: 500
        height: 476
    }

    Frame {
        id: merchantFrameDiabolicFoot
        name: "MerchantFrameDiabolicFoot"
        wowParent: "MerchantFrameDiabolic"
        anchors.horizontalCenter: merchantBuyBackItem.horizontalCenter
        anchors.horizontalCenterOffset: 134.3
        anchors.top: merchantBuyBackItem.top
        anchors.topMargin: -14
        width: 454
        height: 65.2
    }

    Frame {
        id: merchantFrameDiabolicRail
        name: "MerchantFrameDiabolicRail"
        wowParent: "MerchantFrameDiabolic"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Frame {
        id: merchantFrameDiabolicSocket
        name: "MerchantFrameDiabolicSocket"
        wowParent: "MerchantFrameDiabolic"
        anchors.right: merchantFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: merchantFrameDiabolicTitlePlate
        name: "MerchantFrameDiabolicTitlePlate"
        wowParent: "MerchantFrameDiabolic"
        anchors.horizontalCenter: merchantFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: merchantFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: merchantFrameTab1
        name: "MerchantFrameTab1"
        text: "Merchant"
        wowParent: "MerchantFrame"
        style: "Banner"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: merchantFrameTab2
        name: "MerchantFrameTab2"
        text: "Buyback"
        wowParent: "MerchantFrame"
        style: "Banner"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        id: merchantItem1
        name: "MerchantItem1"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 72
        width: 153
        height: 44
    }

    Frame {
        id: merchantItem10
        name: "MerchantItem10"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 280
        width: 153
        height: 44
    }

    Button {
        id: merchantItem10ItemButton
        name: "MerchantItem10ItemButton"
        wowParent: "MerchantItem10"
        anchors.left: merchantItem10.left
        anchors.top: merchantItem10.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem10ItemButtonCount
        name: "MerchantItem10ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem10ItemButton"
        anchors.right: merchantItem10ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem10ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem10MoneyFrame
        name: "MerchantItem10MoneyFrame"
        wowParent: "MerchantItem10"
        anchors.left: merchantItem10NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem10NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Button {
        id: merchantItem10MoneyFrameCopperButton
        name: "MerchantItem10MoneyFrameCopperButton"
        text: "30"
        wowParent: "MerchantItem10MoneyFrame"
        anchors.right: merchantItem10MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem10MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem10MoneyFrameCopperButtonText
        name: "MerchantItem10MoneyFrameCopperButtonText"
        text: "30"
        wowParent: "MerchantItem10MoneyFrameCopperButton"
        anchors.right: merchantItem10MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem10MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem10MoneyFrameSilverButton
        name: "MerchantItem10MoneyFrameSilverButton"
        text: "33"
        wowParent: "MerchantItem10MoneyFrame"
        anchors.right: merchantItem10MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem10MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem10MoneyFrameSilverButtonText
        name: "MerchantItem10MoneyFrameSilverButtonText"
        text: "33"
        wowParent: "MerchantItem10MoneyFrameSilverButton"
        anchors.right: merchantItem10MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem10MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantItem10Name
        name: "MerchantItem10Name"
        text: "Padded Armor"
        wowParent: "MerchantItem10"
        anchors.left: merchantItem10ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem10ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem11
        name: "MerchantItem11"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 332
        width: 153
        height: 44
    }

    FontString {
        id: merchantItem11Name
        name: "MerchantItem11Name"
        wowParent: "MerchantItem11"
        anchors.left: merchantItem11ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem11ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem12
        name: "MerchantItem12"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 332
        width: 153
        height: 44
    }

    FontString {
        id: merchantItem12Name
        name: "MerchantItem12Name"
        wowParent: "MerchantItem12"
        anchors.left: merchantItem12ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem12ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Button {
        id: merchantItem1ItemButton
        name: "MerchantItem1ItemButton"
        wowParent: "MerchantItem1"
        anchors.left: merchantItem1.left
        anchors.top: merchantItem1.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem1ItemButtonCount
        name: "MerchantItem1ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem1ItemButton"
        anchors.right: merchantItem1ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem1ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem1MoneyFrame
        name: "MerchantItem1MoneyFrame"
        wowParent: "MerchantItem1"
        anchors.left: merchantItem1NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem1NameFrame.bottom
        anchors.bottomMargin: 31
        width: 76.2
        height: 13
    }

    Button {
        id: merchantItem1MoneyFrameCopperButton
        name: "MerchantItem1MoneyFrameCopperButton"
        text: "79"
        wowParent: "MerchantItem1MoneyFrame"
        anchors.right: merchantItem1MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem1MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem1MoneyFrameCopperButtonText
        name: "MerchantItem1MoneyFrameCopperButtonText"
        text: "79"
        wowParent: "MerchantItem1MoneyFrameCopperButton"
        anchors.right: merchantItem1MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem1MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem1MoneyFrameSilverButton
        name: "MerchantItem1MoneyFrameSilverButton"
        text: "41"
        wowParent: "MerchantItem1MoneyFrame"
        anchors.right: merchantItem1MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem1MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: merchantItem1MoneyFrameSilverButtonText
        name: "MerchantItem1MoneyFrameSilverButtonText"
        text: "41"
        wowParent: "MerchantItem1MoneyFrameSilverButton"
        anchors.right: merchantItem1MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem1MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 14.2
    }

    FontString {
        id: merchantItem1Name
        name: "MerchantItem1Name"
        text: "Cuirboulli Vest"
        wowParent: "MerchantItem1"
        anchors.left: merchantItem1ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem1ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem2
        name: "MerchantItem2"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 72
        width: 153
        height: 44
    }

    Button {
        id: merchantItem2ItemButton
        name: "MerchantItem2ItemButton"
        wowParent: "MerchantItem2"
        anchors.left: merchantItem2.left
        anchors.top: merchantItem2.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem2ItemButtonCount
        name: "MerchantItem2ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem2ItemButton"
        anchors.right: merchantItem2ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem2ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem2MoneyFrame
        name: "MerchantItem2MoneyFrame"
        wowParent: "MerchantItem2"
        anchors.left: merchantItem2NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem2NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Button {
        id: merchantItem2MoneyFrameCopperButton
        name: "MerchantItem2MoneyFrameCopperButton"
        text: "96"
        wowParent: "MerchantItem2MoneyFrame"
        anchors.right: merchantItem2MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem2MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem2MoneyFrameCopperButtonText
        name: "MerchantItem2MoneyFrameCopperButtonText"
        text: "96"
        wowParent: "MerchantItem2MoneyFrameCopperButton"
        anchors.right: merchantItem2MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem2MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem2MoneyFrameSilverButton
        name: "MerchantItem2MoneyFrameSilverButton"
        text: "20"
        wowParent: "MerchantItem2MoneyFrame"
        anchors.right: merchantItem2MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem2MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem2MoneyFrameSilverButtonText
        name: "MerchantItem2MoneyFrameSilverButtonText"
        text: "20"
        wowParent: "MerchantItem2MoneyFrameSilverButton"
        anchors.right: merchantItem2MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem2MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantItem2Name
        name: "MerchantItem2Name"
        text: "Cuirboulli Belt"
        wowParent: "MerchantItem2"
        anchors.left: merchantItem2ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem2ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem3
        name: "MerchantItem3"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 124
        width: 153
        height: 44
    }

    Button {
        id: merchantItem3ItemButton
        name: "MerchantItem3ItemButton"
        wowParent: "MerchantItem3"
        anchors.left: merchantItem3.left
        anchors.top: merchantItem3.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem3ItemButtonCount
        name: "MerchantItem3ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem3ItemButton"
        anchors.right: merchantItem3ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem3ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    FontString {
        id: merchantItem3ItemButtonStock
        name: "MerchantItem3ItemButtonStock"
        text: "(1)"
        wowParent: "MerchantItem3ItemButton"
        anchors.left: merchantItem3ItemButton.left
        anchors.top: merchantItem3ItemButton.top
        anchors.topMargin: 2
        width: 19
        height: 14.2
    }

    Frame {
        id: merchantItem3MoneyFrame
        name: "MerchantItem3MoneyFrame"
        wowParent: "MerchantItem3"
        anchors.left: merchantItem3NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem3NameFrame.bottom
        anchors.bottomMargin: 31
        width: 76.2
        height: 13
    }

    Button {
        id: merchantItem3MoneyFrameCopperButton
        name: "MerchantItem3MoneyFrameCopperButton"
        text: "56"
        wowParent: "MerchantItem3MoneyFrame"
        anchors.right: merchantItem3MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem3MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem3MoneyFrameCopperButtonText
        name: "MerchantItem3MoneyFrameCopperButtonText"
        text: "56"
        wowParent: "MerchantItem3MoneyFrameCopperButton"
        anchors.right: merchantItem3MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem3MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem3MoneyFrameSilverButton
        name: "MerchantItem3MoneyFrameSilverButton"
        text: "31"
        wowParent: "MerchantItem3MoneyFrame"
        anchors.right: merchantItem3MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem3MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: merchantItem3MoneyFrameSilverButtonText
        name: "MerchantItem3MoneyFrameSilverButtonText"
        text: "31"
        wowParent: "MerchantItem3MoneyFrameSilverButton"
        anchors.right: merchantItem3MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem3MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 14.2
    }

    FontString {
        id: merchantItem3Name
        name: "MerchantItem3Name"
        text: "Cuirboulli Boots"
        wowParent: "MerchantItem3"
        anchors.left: merchantItem3ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem3ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem4
        name: "MerchantItem4"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 124
        width: 153
        height: 44
    }

    Button {
        id: merchantItem4ItemButton
        name: "MerchantItem4ItemButton"
        wowParent: "MerchantItem4"
        anchors.left: merchantItem4.left
        anchors.top: merchantItem4.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem4ItemButtonCount
        name: "MerchantItem4ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem4ItemButton"
        anchors.right: merchantItem4ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem4ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem4MoneyFrame
        name: "MerchantItem4MoneyFrame"
        wowParent: "MerchantItem4"
        anchors.left: merchantItem4NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem4NameFrame.bottom
        anchors.bottomMargin: 31
        width: 73.8
        height: 13
    }

    Button {
        id: merchantItem4MoneyFrameCopperButton
        name: "MerchantItem4MoneyFrameCopperButton"
        text: "11"
        wowParent: "MerchantItem4MoneyFrame"
        anchors.right: merchantItem4MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrame.verticalCenter
        width: 28
        height: 13
    }

    FontString {
        id: merchantItem4MoneyFrameCopperButtonText
        name: "MerchantItem4MoneyFrameCopperButtonText"
        text: "11"
        wowParent: "MerchantItem4MoneyFrameCopperButton"
        anchors.right: merchantItem4MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrameCopperButton.verticalCenter
        width: 15
        height: 14.2
    }

    Button {
        id: merchantItem4MoneyFrameGoldButton
        name: "MerchantItem4MoneyFrameGoldButton"
        text: "4"
        wowParent: "MerchantItem4MoneyFrame"
        anchors.right: merchantItem4MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem4MoneyFrameSilverButton.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: merchantItem4MoneyFrameGoldButtonText
        name: "MerchantItem4MoneyFrameGoldButtonText"
        text: "4"
        wowParent: "MerchantItem4MoneyFrameGoldButton"
        anchors.right: merchantItem4MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrameGoldButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Button {
        id: merchantItem4MoneyFrameSilverButton
        name: "MerchantItem4MoneyFrameSilverButton"
        text: "21"
        wowParent: "MerchantItem4MoneyFrame"
        anchors.right: merchantItem4MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem4MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: merchantItem4MoneyFrameSilverButtonText
        name: "MerchantItem4MoneyFrameSilverButtonText"
        text: "21"
        wowParent: "MerchantItem4MoneyFrameSilverButton"
        anchors.right: merchantItem4MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 14.2
    }

    FontString {
        id: merchantItem4Name
        name: "MerchantItem4Name"
        text: "Cuirboulli Bracers"
        wowParent: "MerchantItem4"
        anchors.left: merchantItem4ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem4ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem5
        name: "MerchantItem5"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 176
        width: 153
        height: 44
    }

    Button {
        id: merchantItem5ItemButton
        name: "MerchantItem5ItemButton"
        wowParent: "MerchantItem5"
        anchors.left: merchantItem5.left
        anchors.top: merchantItem5.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem5ItemButtonCount
        name: "MerchantItem5ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem5ItemButton"
        anchors.right: merchantItem5ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem5ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem5MoneyFrame
        name: "MerchantItem5MoneyFrame"
        wowParent: "MerchantItem5"
        anchors.left: merchantItem5NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem5NameFrame.bottom
        anchors.bottomMargin: 31
        width: 76.2
        height: 13
    }

    Button {
        id: merchantItem5MoneyFrameCopperButton
        name: "MerchantItem5MoneyFrameCopperButton"
        text: "19"
        wowParent: "MerchantItem5MoneyFrame"
        anchors.right: merchantItem5MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem5MoneyFrameCopperButtonText
        name: "MerchantItem5MoneyFrameCopperButtonText"
        text: "19"
        wowParent: "MerchantItem5MoneyFrameCopperButton"
        anchors.right: merchantItem5MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem5MoneyFrameGoldButton
        name: "MerchantItem5MoneyFrameGoldButton"
        text: "1"
        anchors.right: merchantItem5MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem5MoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: merchantItem5MoneyFrameGoldButtonText
        name: "MerchantItem5MoneyFrameGoldButtonText"
        text: "1"
        anchors.right: merchantItem5MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrameGoldButton.verticalCenter
        width: 6
        height: 12
    }

    Button {
        id: merchantItem5MoneyFrameSilverButton
        name: "MerchantItem5MoneyFrameSilverButton"
        text: "21"
        wowParent: "MerchantItem5MoneyFrame"
        anchors.right: merchantItem5MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem5MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: merchantItem5MoneyFrameSilverButtonText
        name: "MerchantItem5MoneyFrameSilverButtonText"
        text: "21"
        wowParent: "MerchantItem5MoneyFrameSilverButton"
        anchors.right: merchantItem5MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 14.2
    }

    FontString {
        id: merchantItem5Name
        name: "MerchantItem5Name"
        text: "Cuirboulli Gloves"
        wowParent: "MerchantItem5"
        anchors.left: merchantItem5ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem5ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem6
        name: "MerchantItem6"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 176
        width: 153
        height: 44
    }

    Button {
        id: merchantItem6ItemButton
        name: "MerchantItem6ItemButton"
        wowParent: "MerchantItem6"
        anchors.left: merchantItem6.left
        anchors.top: merchantItem6.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem6ItemButtonCount
        name: "MerchantItem6ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem6ItemButton"
        anchors.right: merchantItem6ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem6ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    FontString {
        id: merchantItem6ItemButtonStock
        name: "MerchantItem6ItemButtonStock"
        text: "(1)"
        wowParent: "MerchantItem6ItemButton"
        anchors.left: merchantItem6ItemButton.left
        anchors.top: merchantItem6ItemButton.top
        anchors.topMargin: 2
        width: 19
        height: 14.2
    }

    Frame {
        id: merchantItem6MoneyFrame
        name: "MerchantItem6MoneyFrame"
        wowParent: "MerchantItem6"
        anchors.left: merchantItem6NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem6NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Button {
        id: merchantItem6MoneyFrameCopperButton
        name: "MerchantItem6MoneyFrameCopperButton"
        text: "47"
        wowParent: "MerchantItem6MoneyFrame"
        anchors.right: merchantItem6MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem6MoneyFrameCopperButtonText
        name: "MerchantItem6MoneyFrameCopperButtonText"
        text: "47"
        wowParent: "MerchantItem6MoneyFrameCopperButton"
        anchors.right: merchantItem6MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem6MoneyFrameGoldButton
        name: "MerchantItem6MoneyFrameGoldButton"
        text: "23"
        wowParent: "MerchantItem6MoneyFrame"
        anchors.right: merchantItem6MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem6MoneyFrameSilverButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem6MoneyFrameGoldButtonText
        name: "MerchantItem6MoneyFrameGoldButtonText"
        text: "23"
        wowParent: "MerchantItem6MoneyFrameGoldButton"
        anchors.right: merchantItem6MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrameGoldButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem6MoneyFrameSilverButton
        name: "MerchantItem6MoneyFrameSilverButton"
        text: "38"
        wowParent: "MerchantItem6MoneyFrame"
        anchors.right: merchantItem6MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem6MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem6MoneyFrameSilverButtonText
        name: "MerchantItem6MoneyFrameSilverButtonText"
        text: "38"
        wowParent: "MerchantItem6MoneyFrameSilverButton"
        anchors.right: merchantItem6MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantItem6Name
        name: "MerchantItem6Name"
        text: "Cuirboulli Pants"
        wowParent: "MerchantItem6"
        anchors.left: merchantItem6ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem6ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem7
        name: "MerchantItem7"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 228
        width: 153
        height: 44
    }

    Button {
        id: merchantItem7ItemButton
        name: "MerchantItem7ItemButton"
        wowParent: "MerchantItem7"
        anchors.left: merchantItem7.left
        anchors.top: merchantItem7.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem7ItemButtonCount
        name: "MerchantItem7ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem7ItemButton"
        anchors.right: merchantItem7ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem7ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem7MoneyFrame
        name: "MerchantItem7MoneyFrame"
        wowParent: "MerchantItem7"
        anchors.left: merchantItem7NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem7NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Button {
        id: merchantItem7MoneyFrameCopperButton
        name: "MerchantItem7MoneyFrameCopperButton"
        text: "62"
        wowParent: "MerchantItem7MoneyFrame"
        anchors.right: merchantItem7MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem7MoneyFrameCopperButtonText
        name: "MerchantItem7MoneyFrameCopperButtonText"
        text: "62"
        wowParent: "MerchantItem7MoneyFrameCopperButton"
        anchors.right: merchantItem7MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem7MoneyFrameGoldButton
        name: "MerchantItem7MoneyFrameGoldButton"
        text: "1"
        anchors.right: merchantItem7MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem7MoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: merchantItem7MoneyFrameGoldButtonText
        name: "MerchantItem7MoneyFrameGoldButtonText"
        text: "1"
        anchors.right: merchantItem7MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrameGoldButton.verticalCenter
        width: 6
        height: 12
    }

    Button {
        id: merchantItem7MoneyFrameSilverButton
        name: "MerchantItem7MoneyFrameSilverButton"
        text: "24"
        wowParent: "MerchantItem7MoneyFrame"
        anchors.right: merchantItem7MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem7MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem7MoneyFrameSilverButtonText
        name: "MerchantItem7MoneyFrameSilverButtonText"
        text: "24"
        wowParent: "MerchantItem7MoneyFrameSilverButton"
        anchors.right: merchantItem7MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantItem7Name
        name: "MerchantItem7Name"
        text: "Padded Boots"
        wowParent: "MerchantItem7"
        anchors.left: merchantItem7ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem7ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem8
        name: "MerchantItem8"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 228
        width: 153
        height: 44
    }

    Button {
        id: merchantItem8ItemButton
        name: "MerchantItem8ItemButton"
        wowParent: "MerchantItem8"
        anchors.left: merchantItem8.left
        anchors.top: merchantItem8.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem8ItemButtonCount
        name: "MerchantItem8ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem8ItemButton"
        anchors.right: merchantItem8ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem8ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem8MoneyFrame
        name: "MerchantItem8MoneyFrame"
        wowParent: "MerchantItem8"
        anchors.left: merchantItem8NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem8NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Button {
        id: merchantItem8MoneyFrameCopperButton
        name: "MerchantItem8MoneyFrameCopperButton"
        text: "52"
        wowParent: "MerchantItem8MoneyFrame"
        anchors.right: merchantItem8MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem8MoneyFrameCopperButtonText
        name: "MerchantItem8MoneyFrameCopperButtonText"
        text: "52"
        wowParent: "MerchantItem8MoneyFrameCopperButton"
        anchors.right: merchantItem8MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem8MoneyFrameGoldButton
        name: "MerchantItem8MoneyFrameGoldButton"
        text: "2"
        wowParent: "MerchantItem8MoneyFrame"
        anchors.right: merchantItem8MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem8MoneyFrameSilverButton.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: merchantItem8MoneyFrameGoldButtonText
        name: "MerchantItem8MoneyFrameGoldButtonText"
        text: "2"
        wowParent: "MerchantItem8MoneyFrameGoldButton"
        anchors.right: merchantItem8MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrameGoldButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Button {
        id: merchantItem8MoneyFrameSilverButton
        name: "MerchantItem8MoneyFrameSilverButton"
        text: "16"
        wowParent: "MerchantItem8MoneyFrame"
        anchors.right: merchantItem8MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem8MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem8MoneyFrameSilverButtonText
        name: "MerchantItem8MoneyFrameSilverButtonText"
        text: "16"
        wowParent: "MerchantItem8MoneyFrameSilverButton"
        anchors.right: merchantItem8MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantItem8Name
        name: "MerchantItem8Name"
        text: "Padded Gloves"
        wowParent: "MerchantItem8"
        anchors.left: merchantItem8ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem8ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantItem9
        name: "MerchantItem9"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 280
        width: 153
        height: 44
    }

    Button {
        id: merchantItem9ItemButton
        name: "MerchantItem9ItemButton"
        wowParent: "MerchantItem9"
        anchors.left: merchantItem9.left
        anchors.top: merchantItem9.top
        width: 38.2
        height: 38.1
    }

    FontString {
        id: merchantItem9ItemButtonCount
        name: "MerchantItem9ItemButtonCount"
        text: "5"
        wowParent: "MerchantItem9ItemButton"
        anchors.right: merchantItem9ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem9ItemButton.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: merchantItem9MoneyFrame
        name: "MerchantItem9MoneyFrame"
        wowParent: "MerchantItem9"
        anchors.left: merchantItem9NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem9NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Button {
        id: merchantItem9MoneyFrameCopperButton
        name: "MerchantItem9MoneyFrameCopperButton"
        text: "18"
        wowParent: "MerchantItem9MoneyFrame"
        anchors.right: merchantItem9MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem9MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem9MoneyFrameCopperButtonText
        name: "MerchantItem9MoneyFrameCopperButtonText"
        text: "18"
        wowParent: "MerchantItem9MoneyFrameCopperButton"
        anchors.right: merchantItem9MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem9MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantItem9MoneyFrameSilverButton
        name: "MerchantItem9MoneyFrameSilverButton"
        text: "33"
        wowParent: "MerchantItem9MoneyFrame"
        anchors.right: merchantItem9MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem9MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantItem9MoneyFrameSilverButtonText
        name: "MerchantItem9MoneyFrameSilverButtonText"
        text: "33"
        wowParent: "MerchantItem9MoneyFrameSilverButton"
        anchors.right: merchantItem9MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem9MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantItem9Name
        name: "MerchantItem9Name"
        text: "Padded Pants"
        wowParent: "MerchantItem9"
        anchors.left: merchantItem9ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem9ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Frame {
        id: merchantMoneyFrame
        name: "MerchantMoneyFrame"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.right: merchantFrameDiabolic.right
        anchors.rightMargin: 24
        anchors.bottom: merchantFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 126.4
        height: 13
    }

    Button {
        id: merchantMoneyFrameCopperButton
        name: "MerchantMoneyFrameCopperButton"
        text: "13"
        wowParent: "MerchantMoneyFrame"
        anchors.right: merchantMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantMoneyFrameCopperButtonText
        name: "MerchantMoneyFrameCopperButtonText"
        text: "13"
        wowParent: "MerchantMoneyFrameCopperButton"
        anchors.right: merchantMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: merchantMoneyFrameGoldButton
        name: "MerchantMoneyFrameGoldButton"
        text: "3654"
        wowParent: "MerchantMoneyFrame"
        anchors.right: merchantMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    FontString {
        id: merchantMoneyFrameGoldButtonText
        name: "MerchantMoneyFrameGoldButtonText"
        text: "3654"
        wowParent: "MerchantMoneyFrameGoldButton"
        anchors.right: merchantMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Button {
        id: merchantMoneyFrameSilverButton
        name: "MerchantMoneyFrameSilverButton"
        text: "16"
        wowParent: "MerchantMoneyFrame"
        anchors.right: merchantMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: merchantMoneyFrameSilverButtonText
        name: "MerchantMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "MerchantMoneyFrameSilverButton"
        anchors.right: merchantMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: merchantNameText
        name: "MerchantNameText"
        text: "Duncan Cullen"
        wowParent: "MerchantFrameDiabolicTitlePlate"
        anchors.horizontalCenter: merchantFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: merchantFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 136.7
        height: 14.2
    }

    Button {
        id: merchantNextPageButton
        name: "MerchantNextPageButton"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantPageText.right
        anchors.leftMargin: 8
        anchors.verticalCenter: merchantPageText.verticalCenter
        width: 26
        height: 26
    }

    FontString {
        id: merchantPageText
        name: "MerchantPageText"
        text: "Page 1 of 4"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.horizontalCenter: merchantFrameDiabolic.horizontalCenter
        anchors.verticalCenter: merchantFrameDiabolic.top
        anchors.verticalCenterOffset: 384
        width: 68.7
        height: 11.9
    }

    Button {
        id: merchantPrevPageButton
        name: "MerchantPrevPageButton"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.right: merchantPageText.left
        anchors.rightMargin: 8
        anchors.verticalCenter: merchantPageText.verticalCenter
        width: 26
        height: 26
    }

    Button {
        id: merchantRepairAllButton
        name: "MerchantRepairAllButton"
        wowParent: "MerchantFrame"
        pin: "place"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 288
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 434
        width: 36
        height: 36
    }

    Button {
        id: merchantRepairItemButton
        name: "MerchantRepairItemButton"
        wowParent: "MerchantFrame"
        anchors.right: merchantRepairAllButton.left
        anchors.rightMargin: 2
        anchors.verticalCenter: merchantRepairAllButton.verticalCenter
        width: 36
        height: 36
    }

    FontString {
        id: merchantRepairText
        name: "MerchantRepairText"
        text: "Repair Items"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrame.left
        anchors.leftMargin: 26
        anchors.bottom: merchantFrame.bottom
        anchors.bottomMargin: 103
        width: 67.2
        height: 10.3
    }

    Ghost { id: merchantBuyBackItemMoneyFrameCopperButton; name: "MerchantBuyBackItemMoneyFrameCopperButton"; x: 148.7; y: 427.7; width: 0; height: 0 }
    Ghost { id: merchantBuyBackItemNameFrame; name: "MerchantBuyBackItemNameFrame"; x: 92.6; y: 459.2; width: 0; height: 0 }
    Ghost { id: merchantItem10NameFrame; name: "MerchantItem10NameFrame"; x: 311.4; y: 313.1; width: 0; height: 0 }
    Ghost { id: merchantItem11ItemButton; name: "MerchantItem11ItemButton"; x: 77.4; y: 296; width: 0; height: 0 }
    Ghost { id: merchantItem12ItemButton; name: "MerchantItem12ItemButton"; x: 295.4; y: 296; width: 0; height: 0 }
    Ghost { id: merchantItem1NameFrame; name: "MerchantItem1NameFrame"; x: 93.4; y: 105.1; width: 0; height: 0 }
    Ghost { id: merchantItem2NameFrame; name: "MerchantItem2NameFrame"; x: 311.4; y: 105.1; width: 0; height: 0 }
    Ghost { id: merchantItem3NameFrame; name: "MerchantItem3NameFrame"; x: 93.4; y: 157.1; width: 0; height: 0 }
    Ghost { id: merchantItem4NameFrame; name: "MerchantItem4NameFrame"; x: 311.4; y: 157.1; width: 0; height: 0 }
    Ghost { id: merchantItem5NameFrame; name: "MerchantItem5NameFrame"; x: 93.4; y: 209.1; width: 0; height: 0 }
    Ghost { id: merchantItem6NameFrame; name: "MerchantItem6NameFrame"; x: 311.4; y: 209.1; width: 0; height: 0 }
    Ghost { id: merchantItem7NameFrame; name: "MerchantItem7NameFrame"; x: 93.4; y: 261.1; width: 0; height: 0 }
    Ghost { id: merchantItem8NameFrame; name: "MerchantItem8NameFrame"; x: 311.4; y: 261.1; width: 0; height: 0 }
    Ghost { id: merchantItem9NameFrame; name: "MerchantItem9NameFrame"; x: 93.4; y: 313.1; width: 0; height: 0 }
}
