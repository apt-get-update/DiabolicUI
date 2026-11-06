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
    Ghost { id: merchantItem1NameFrame; name: "MerchantItem1NameFrame"; x: 93.4; y: 105.1; width: 0; height: 0 }
    Ghost { id: merchantItem3ItemButton; name: "MerchantItem3ItemButton"; x: 39.3; y: 88; width: 38.2; height: 38.1 }
    Ghost { id: merchantItem4MoneyFrameSilverButton; name: "MerchantItem4MoneyFrameSilverButton"; x: 313.4; y: 113.1; width: 28.8; height: 13 }
    Ghost { id: merchantItem5MoneyFrameSilverButton; name: "MerchantItem5MoneyFrameSilverButton"; x: 95.4; y: 165.1; width: 28.8; height: 13 }
    Ghost { id: merchantItem6ItemButton; name: "MerchantItem6ItemButton"; x: 257.3; y: 140; width: 38.2; height: 38.1 }
    Ghost { id: merchantItem6MoneyFrameSilverButton; name: "MerchantItem6MoneyFrameSilverButton"; x: 313.4; y: 165.1; width: 30.4; height: 13 }
    Ghost { id: merchantItem7MoneyFrameSilverButton; name: "MerchantItem7MoneyFrameSilverButton"; x: 95.4; y: 217.1; width: 30.4; height: 13 }
    Ghost { id: merchantItem8MoneyFrameSilverButton; name: "MerchantItem8MoneyFrameSilverButton"; x: 313.4; y: 217.1; width: 30.4; height: 13 }
}
