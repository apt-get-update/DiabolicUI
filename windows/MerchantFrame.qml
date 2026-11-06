// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: merchantFrame
    name: "MerchantFrame"
    width: 384
    height: 512

    Part {
        id: diabolicSellJunkButton
        name: "DiabolicSellJunkButton"
        kind: "Button"
        text: "Sell Junk"
        wowParent: "MerchantFrame"
        anchors.right: merchantFrameDiabolic.right
        anchors.rightMargin: 32
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 434
        width: 90
        height: 22
    }

    Part {
        id: diabolicSellJunkButtonText
        name: "DiabolicSellJunkButtonText"
        kind: "FontString"
        text: "Sell Junk"
        wowParent: "DiabolicSellJunkButton"
        anchors.horizontalCenter: diabolicSellJunkButton.horizontalCenter
        anchors.verticalCenter: diabolicSellJunkButton.verticalCenter
        width: 68
        height: 11.9
    }

    Part {
        id: merchantBuyBackItem
        name: "MerchantBuyBackItem"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.2
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 433.8
        width: 153
        height: 37
    }

    Part {
        id: merchantBuyBackItemItemButton
        name: "MerchantBuyBackItemItemButton"
        kind: "Button"
        wowParent: "MerchantBuyBackItem"
        anchors.left: merchantBuyBackItem.left
        anchors.top: merchantBuyBackItem.top
        width: 37.5
        height: 36.4
    }

    Part {
        id: merchantBuyBackItemName
        name: "MerchantBuyBackItemName"
        kind: "FontString"
        wowParent: "MerchantBuyBackItem"
        anchors.left: merchantBuyBackItemItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantBuyBackItemItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantFrameCloseButton
        name: "MerchantFrameCloseButton"
        kind: "Button"
        wowParent: "MerchantFrame"
        anchors.horizontalCenter: merchantFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: merchantFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: merchantFrameDiabolic
        name: "MerchantFrameDiabolic"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrame.left
        anchors.top: merchantFrame.top
        anchors.topMargin: -36
        width: 500
        height: 508
    }

    Part {
        id: merchantFrameDiabolicBorder
        name: "MerchantFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "MerchantFrameDiabolic"
        anchors.left: merchantFrameDiabolic.left
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 32
        width: 500
        height: 476
    }

    Part {
        id: merchantFrameDiabolicFoot
        name: "MerchantFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "MerchantFrameDiabolic"
        anchors.horizontalCenter: merchantBuyBackItem.horizontalCenter
        anchors.horizontalCenterOffset: 134.4
        anchors.top: merchantBuyBackItem.top
        anchors.topMargin: -14
        width: 454
        height: 65.2
    }

    Part {
        id: merchantFrameDiabolicRail
        name: "MerchantFrameDiabolicRail"
        kind: "Frame"
        wowParent: "MerchantFrameDiabolic"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Part {
        id: merchantFrameDiabolicSocket
        name: "MerchantFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "MerchantFrameDiabolic"
        anchors.right: merchantFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: merchantFrameDiabolicTitlePlate
        name: "MerchantFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "MerchantFrameDiabolic"
        anchors.horizontalCenter: merchantFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: merchantFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: merchantFrameTab1
        name: "MerchantFrameTab1"
        kind: "Button"
        text: "Merchant"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: merchantFrameTab2
        name: "MerchantFrameTab2"
        kind: "Button"
        text: "Buyback"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: merchantItem1
        name: "MerchantItem1"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 72
        width: 153
        height: 44
    }

    Part {
        id: merchantItem10
        name: "MerchantItem10"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 280
        width: 153
        height: 44
    }

    Part {
        id: merchantItem10ItemButton
        name: "MerchantItem10ItemButton"
        kind: "Button"
        anchors.left: merchantItem10.left
        anchors.top: merchantItem10.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem10ItemButtonCount
        name: "MerchantItem10ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem10ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem10ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem10MoneyFrame
        name: "MerchantItem10MoneyFrame"
        kind: "Frame"
        anchors.left: merchantItem10NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem10NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Part {
        id: merchantItem10MoneyFrameCopperButton
        name: "MerchantItem10MoneyFrameCopperButton"
        kind: "Button"
        text: "50"
        anchors.right: merchantItem10MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem10MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem10MoneyFrameCopperButtonText
        name: "MerchantItem10MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "50"
        anchors.right: merchantItem10MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem10MoneyFrameCopperButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem10MoneyFrameSilverButton
        name: "MerchantItem10MoneyFrameSilverButton"
        kind: "Button"
        text: "95"
        anchors.right: merchantItem10MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem10MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem10MoneyFrameSilverButtonText
        name: "MerchantItem10MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "95"
        anchors.right: merchantItem10MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem10MoneyFrameSilverButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem10Name
        name: "MerchantItem10Name"
        kind: "FontString"
        wowParent: "MerchantItem10"
        anchors.left: merchantItem10ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem10ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem11
        name: "MerchantItem11"
        kind: "Frame"
        anchors.left: merchantFrame.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrame.top
        anchors.topMargin: 296
        width: 153
        height: 44
    }

    Part {
        id: merchantItem11Name
        name: "MerchantItem11Name"
        kind: "FontString"
        anchors.left: merchantItem11ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem11ItemButton.top
        anchors.topMargin: -1
        width: 108
        height: 12
    }

    Part {
        id: merchantItem12
        name: "MerchantItem12"
        kind: "Frame"
        anchors.left: merchantFrame.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrame.top
        anchors.topMargin: 296
        width: 153
        height: 44
    }

    Part {
        id: merchantItem12Name
        name: "MerchantItem12Name"
        kind: "FontString"
        anchors.left: merchantItem12ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem12ItemButton.top
        anchors.topMargin: -1
        width: 108
        height: 12
    }

    Part {
        id: merchantItem1ItemButton
        name: "MerchantItem1ItemButton"
        kind: "Button"
        wowParent: "MerchantItem1"
        anchors.left: merchantItem1.left
        anchors.top: merchantItem1.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem1ItemButtonCount
        name: "MerchantItem1ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem1ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem1ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem1MoneyFrame
        name: "MerchantItem1MoneyFrame"
        kind: "Frame"
        wowParent: "MerchantItem1"
        anchors.left: merchantItem1NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem1NameFrame.bottom
        anchors.bottomMargin: 31
        width: 43.4
        height: 13
    }

    Part {
        id: merchantItem1MoneyFrameCopperButton
        name: "MerchantItem1MoneyFrameCopperButton"
        kind: "Button"
        text: "26"
        anchors.right: merchantItem1MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem1MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem1MoneyFrameCopperButtonText
        name: "MerchantItem1MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "26"
        anchors.right: merchantItem1MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem1MoneyFrameCopperButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem1MoneyFrameSilverButton
        name: "MerchantItem1MoneyFrameSilverButton"
        kind: "Button"
        text: "32"
        wowParent: "MerchantItem1MoneyFrame"
        anchors.right: merchantItem1MoneyFrameCopperButton.right
        anchors.verticalCenter: merchantItem1MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem1MoneyFrameSilverButtonText
        name: "MerchantItem1MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "32"
        wowParent: "MerchantItem1MoneyFrameSilverButton"
        anchors.right: merchantItem1MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem1MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem1Name
        name: "MerchantItem1Name"
        kind: "FontString"
        text: "Bold Yellow Shirt"
        wowParent: "MerchantItem1"
        anchors.left: merchantItem1ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem1ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem2
        name: "MerchantItem2"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 72
        width: 153
        height: 44
    }

    Part {
        id: merchantItem2ItemButton
        name: "MerchantItem2ItemButton"
        kind: "Button"
        wowParent: "MerchantItem2"
        anchors.left: merchantItem2.left
        anchors.top: merchantItem2.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem2ItemButtonCount
        name: "MerchantItem2ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem2ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem2ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem2MoneyFrame
        name: "MerchantItem2MoneyFrame"
        kind: "Frame"
        wowParent: "MerchantItem2"
        anchors.left: merchantItem2NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem2NameFrame.bottom
        anchors.bottomMargin: 31
        width: 43.4
        height: 13
    }

    Part {
        id: merchantItem2MoneyFrameCopperButton
        name: "MerchantItem2MoneyFrameCopperButton"
        kind: "Button"
        text: "18"
        anchors.right: merchantItem2MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem2MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem2MoneyFrameCopperButtonText
        name: "MerchantItem2MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "18"
        anchors.right: merchantItem2MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem2MoneyFrameCopperButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem2MoneyFrameSilverButton
        name: "MerchantItem2MoneyFrameSilverButton"
        kind: "Button"
        text: "48"
        wowParent: "MerchantItem2MoneyFrame"
        anchors.right: merchantItem2MoneyFrameCopperButton.right
        anchors.verticalCenter: merchantItem2MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem2MoneyFrameSilverButtonText
        name: "MerchantItem2MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "48"
        wowParent: "MerchantItem2MoneyFrameSilverButton"
        anchors.right: merchantItem2MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem2MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem2Name
        name: "MerchantItem2Name"
        kind: "FontString"
        text: "Stylish Black Shirt"
        wowParent: "MerchantItem2"
        anchors.left: merchantItem2ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem2ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem3
        name: "MerchantItem3"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 124
        width: 153
        height: 44
    }

    Part {
        id: merchantItem3ItemButton
        name: "MerchantItem3ItemButton"
        kind: "Button"
        wowParent: "MerchantItem3"
        anchors.left: merchantItem3.left
        anchors.top: merchantItem3.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem3ItemButtonCount
        name: "MerchantItem3ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem3ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem3ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem3MoneyFrame
        name: "MerchantItem3MoneyFrame"
        kind: "Frame"
        wowParent: "MerchantItem3"
        anchors.left: merchantItem3NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem3NameFrame.bottom
        anchors.bottomMargin: 31
        width: 70.7
        height: 13
    }

    Part {
        id: merchantItem3MoneyFrameCopperButton
        name: "MerchantItem3MoneyFrameCopperButton"
        kind: "Button"
        text: "20"
        wowParent: "MerchantItem3MoneyFrame"
        anchors.right: merchantItem3MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem3MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem3MoneyFrameCopperButtonText
        name: "MerchantItem3MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "20"
        wowParent: "MerchantItem3MoneyFrameCopperButton"
        anchors.right: merchantItem3MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem3MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem3MoneyFrameSilverButton
        name: "MerchantItem3MoneyFrameSilverButton"
        kind: "Button"
        text: "3"
        wowParent: "MerchantItem3MoneyFrame"
        anchors.right: merchantItem3MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem3MoneyFrameCopperButton.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: merchantItem3MoneyFrameSilverButtonText
        name: "MerchantItem3MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "3"
        wowParent: "MerchantItem3MoneyFrameSilverButton"
        anchors.right: merchantItem3MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem3MoneyFrameSilverButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: merchantItem3Name
        name: "MerchantItem3Name"
        kind: "FontString"
        text: "Common Gray Shirt"
        wowParent: "MerchantItem3"
        anchors.left: merchantItem3ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem3ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem4
        name: "MerchantItem4"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 124
        width: 153
        height: 44
    }

    Part {
        id: merchantItem4ItemButton
        name: "MerchantItem4ItemButton"
        kind: "Button"
        wowParent: "MerchantItem4"
        anchors.left: merchantItem4.left
        anchors.top: merchantItem4.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem4ItemButtonCount
        name: "MerchantItem4ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem4ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem4ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem4MoneyFrame
        name: "MerchantItem4MoneyFrame"
        kind: "Frame"
        wowParent: "MerchantItem4"
        anchors.left: merchantItem4NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem4NameFrame.bottom
        anchors.bottomMargin: 31
        width: 105
        height: 13
    }

    Part {
        id: merchantItem4MoneyFrameCopperButton
        name: "MerchantItem4MoneyFrameCopperButton"
        kind: "Button"
        text: "82"
        wowParent: "MerchantItem4MoneyFrame"
        anchors.right: merchantItem4MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem4MoneyFrameCopperButtonText
        name: "MerchantItem4MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "82"
        wowParent: "MerchantItem4MoneyFrameCopperButton"
        anchors.right: merchantItem4MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem4MoneyFrameGoldButton
        name: "MerchantItem4MoneyFrameGoldButton"
        kind: "Button"
        text: "4"
        wowParent: "MerchantItem4MoneyFrame"
        anchors.right: merchantItem4MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem4MoneyFrameSilverButton.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: merchantItem4MoneyFrameGoldButtonText
        name: "MerchantItem4MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "4"
        wowParent: "MerchantItem4MoneyFrameGoldButton"
        anchors.right: merchantItem4MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrameGoldButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: merchantItem4MoneyFrameSilverButton
        name: "MerchantItem4MoneyFrameSilverButton"
        kind: "Button"
        text: "40"
        wowParent: "MerchantItem4MoneyFrame"
        anchors.right: merchantItem4MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem4MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem4MoneyFrameSilverButtonText
        name: "MerchantItem4MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "40"
        wowParent: "MerchantItem4MoneyFrameSilverButton"
        anchors.right: merchantItem4MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem4MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem4Name
        name: "MerchantItem4Name"
        kind: "FontString"
        text: "Dark Green Wedding Hanbok"
        wowParent: "MerchantItem4"
        anchors.left: merchantItem4ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem4ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem5
        name: "MerchantItem5"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 176
        width: 153
        height: 44
    }

    Part {
        id: merchantItem5ItemButton
        name: "MerchantItem5ItemButton"
        kind: "Button"
        wowParent: "MerchantItem5"
        anchors.left: merchantItem5.left
        anchors.top: merchantItem5.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem5ItemButtonCount
        name: "MerchantItem5ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem5ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem5ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem5MoneyFrame
        name: "MerchantItem5MoneyFrame"
        kind: "Frame"
        wowParent: "MerchantItem5"
        anchors.left: merchantItem5NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem5NameFrame.bottom
        anchors.bottomMargin: 31
        width: 76.2
        height: 13
    }

    Part {
        id: merchantItem5MoneyFrameCopperButton
        name: "MerchantItem5MoneyFrameCopperButton"
        kind: "Button"
        text: "81"
        wowParent: "MerchantItem5MoneyFrame"
        anchors.right: merchantItem5MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrame.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: merchantItem5MoneyFrameCopperButtonText
        name: "MerchantItem5MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "81"
        wowParent: "MerchantItem5MoneyFrameCopperButton"
        anchors.right: merchantItem5MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 14.2
    }

    Part {
        id: merchantItem5MoneyFrameGoldButton
        name: "MerchantItem5MoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        anchors.right: merchantItem5MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem5MoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: merchantItem5MoneyFrameGoldButtonText
        name: "MerchantItem5MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        anchors.right: merchantItem5MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrameGoldButton.verticalCenter
        width: 6
        height: 12
    }

    Part {
        id: merchantItem5MoneyFrameSilverButton
        name: "MerchantItem5MoneyFrameSilverButton"
        kind: "Button"
        text: "23"
        wowParent: "MerchantItem5MoneyFrame"
        anchors.right: merchantItem5MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem5MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem5MoneyFrameSilverButtonText
        name: "MerchantItem5MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "23"
        wowParent: "MerchantItem5MoneyFrameSilverButton"
        anchors.right: merchantItem5MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem5MoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem5Name
        name: "MerchantItem5Name"
        kind: "FontString"
        text: "White Traditional Hanbok"
        wowParent: "MerchantItem5"
        anchors.left: merchantItem5ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem5ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem6
        name: "MerchantItem6"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 176
        width: 153
        height: 44
    }

    Part {
        id: merchantItem6ItemButton
        name: "MerchantItem6ItemButton"
        kind: "Button"
        wowParent: "MerchantItem6"
        anchors.left: merchantItem6.left
        anchors.top: merchantItem6.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem6ItemButtonCount
        name: "MerchantItem6ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem6ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem6ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem6MoneyFrame
        name: "MerchantItem6MoneyFrame"
        kind: "Frame"
        wowParent: "MerchantItem6"
        anchors.left: merchantItem6NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem6NameFrame.bottom
        anchors.bottomMargin: 31
        width: 105
        height: 13
    }

    Part {
        id: merchantItem6MoneyFrameCopperButton
        name: "MerchantItem6MoneyFrameCopperButton"
        kind: "Button"
        text: "59"
        wowParent: "MerchantItem6MoneyFrame"
        anchors.right: merchantItem6MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem6MoneyFrameCopperButtonText
        name: "MerchantItem6MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "59"
        wowParent: "MerchantItem6MoneyFrameCopperButton"
        anchors.right: merchantItem6MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem6MoneyFrameGoldButton
        name: "MerchantItem6MoneyFrameGoldButton"
        kind: "Button"
        text: "23"
        wowParent: "MerchantItem6MoneyFrame"
        anchors.right: merchantItem6MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem6MoneyFrameSilverButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem6MoneyFrameGoldButtonText
        name: "MerchantItem6MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "23"
        wowParent: "MerchantItem6MoneyFrameGoldButton"
        anchors.right: merchantItem6MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrameGoldButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantItem6MoneyFrameSilverButton
        name: "MerchantItem6MoneyFrameSilverButton"
        kind: "Button"
        text: "9"
        wowParent: "MerchantItem6MoneyFrame"
        anchors.right: merchantItem6MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem6MoneyFrameCopperButton.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: merchantItem6MoneyFrameSilverButtonText
        name: "MerchantItem6MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "MerchantItem6MoneyFrameSilverButton"
        anchors.right: merchantItem6MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem6MoneyFrameSilverButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: merchantItem6Name
        name: "MerchantItem6Name"
        kind: "FontString"
        text: "Royal Dangui"
        wowParent: "MerchantItem6"
        anchors.left: merchantItem6ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem6ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem7
        name: "MerchantItem7"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 228
        width: 153
        height: 44
    }

    Part {
        id: merchantItem7ItemButton
        name: "MerchantItem7ItemButton"
        kind: "Button"
        anchors.left: merchantItem7.left
        anchors.top: merchantItem7.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem7ItemButtonCount
        name: "MerchantItem7ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem7ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem7ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem7MoneyFrame
        name: "MerchantItem7MoneyFrame"
        kind: "Frame"
        anchors.left: merchantItem7NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem7NameFrame.bottom
        anchors.bottomMargin: 31
        width: 103.5
        height: 13
    }

    Part {
        id: merchantItem7MoneyFrameCopperButton
        name: "MerchantItem7MoneyFrameCopperButton"
        kind: "Button"
        text: "38"
        anchors.right: merchantItem7MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem7MoneyFrameCopperButtonText
        name: "MerchantItem7MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "38"
        anchors.right: merchantItem7MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrameCopperButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem7MoneyFrameGoldButton
        name: "MerchantItem7MoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        anchors.right: merchantItem7MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem7MoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: merchantItem7MoneyFrameGoldButtonText
        name: "MerchantItem7MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        anchors.right: merchantItem7MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrameGoldButton.verticalCenter
        width: 6
        height: 12
    }

    Part {
        id: merchantItem7MoneyFrameSilverButton
        name: "MerchantItem7MoneyFrameSilverButton"
        kind: "Button"
        text: "25"
        anchors.right: merchantItem7MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem7MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem7MoneyFrameSilverButtonText
        name: "MerchantItem7MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "25"
        anchors.right: merchantItem7MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem7MoneyFrameSilverButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem7Name
        name: "MerchantItem7Name"
        kind: "FontString"
        wowParent: "MerchantItem7"
        anchors.left: merchantItem7ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem7ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem8
        name: "MerchantItem8"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 257.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 228
        width: 153
        height: 44
    }

    Part {
        id: merchantItem8ItemButton
        name: "MerchantItem8ItemButton"
        kind: "Button"
        anchors.left: merchantItem8.left
        anchors.top: merchantItem8.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem8ItemButtonCount
        name: "MerchantItem8ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem8ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem8ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem8MoneyFrame
        name: "MerchantItem8MoneyFrame"
        kind: "Frame"
        anchors.left: merchantItem8NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem8NameFrame.bottom
        anchors.bottomMargin: 31
        width: 103.5
        height: 13
    }

    Part {
        id: merchantItem8MoneyFrameCopperButton
        name: "MerchantItem8MoneyFrameCopperButton"
        kind: "Button"
        text: "85"
        anchors.right: merchantItem8MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem8MoneyFrameCopperButtonText
        name: "MerchantItem8MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "85"
        anchors.right: merchantItem8MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrameCopperButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem8MoneyFrameGoldButton
        name: "MerchantItem8MoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        anchors.right: merchantItem8MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem8MoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: merchantItem8MoneyFrameGoldButtonText
        name: "MerchantItem8MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        anchors.right: merchantItem8MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrameGoldButton.verticalCenter
        width: 6
        height: 12
    }

    Part {
        id: merchantItem8MoneyFrameSilverButton
        name: "MerchantItem8MoneyFrameSilverButton"
        kind: "Button"
        text: "25"
        anchors.right: merchantItem8MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem8MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem8MoneyFrameSilverButtonText
        name: "MerchantItem8MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "25"
        anchors.right: merchantItem8MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem8MoneyFrameSilverButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem8Name
        name: "MerchantItem8Name"
        kind: "FontString"
        wowParent: "MerchantItem8"
        anchors.left: merchantItem8ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem8ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantItem9
        name: "MerchantItem9"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 39.3
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 280
        width: 153
        height: 44
    }

    Part {
        id: merchantItem9ItemButton
        name: "MerchantItem9ItemButton"
        kind: "Button"
        anchors.left: merchantItem9.left
        anchors.top: merchantItem9.top
        width: 38.2
        height: 38.1
    }

    Part {
        id: merchantItem9ItemButtonCount
        name: "MerchantItem9ItemButtonCount"
        kind: "FontString"
        text: "5"
        anchors.right: merchantItem9ItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: merchantItem9ItemButton.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: merchantItem9MoneyFrame
        name: "MerchantItem9MoneyFrame"
        kind: "Frame"
        anchors.left: merchantItem9NameFrame.left
        anchors.leftMargin: 2
        anchors.bottom: merchantItem9NameFrame.bottom
        anchors.bottomMargin: 31
        width: 77.8
        height: 13
    }

    Part {
        id: merchantItem9MoneyFrameCopperButton
        name: "MerchantItem9MoneyFrameCopperButton"
        kind: "Button"
        text: "16"
        anchors.right: merchantItem9MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem9MoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem9MoneyFrameCopperButtonText
        name: "MerchantItem9MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "16"
        anchors.right: merchantItem9MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem9MoneyFrameCopperButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem9MoneyFrameSilverButton
        name: "MerchantItem9MoneyFrameSilverButton"
        kind: "Button"
        text: "63"
        anchors.right: merchantItem9MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantItem9MoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantItem9MoneyFrameSilverButtonText
        name: "MerchantItem9MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "63"
        anchors.right: merchantItem9MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantItem9MoneyFrameSilverButton.verticalCenter
        width: 12
        height: 12
    }

    Part {
        id: merchantItem9Name
        name: "MerchantItem9Name"
        kind: "FontString"
        wowParent: "MerchantItem9"
        anchors.left: merchantItem9ItemButton.right
        anchors.leftMargin: 16
        anchors.top: merchantItem9ItemButton.top
        anchors.topMargin: -1
        width: 150
        height: 26
    }

    Part {
        id: merchantMoneyFrame
        name: "MerchantMoneyFrame"
        kind: "Frame"
        wowParent: "MerchantFrame"
        anchors.right: merchantFrameDiabolic.right
        anchors.rightMargin: 24
        anchors.bottom: merchantFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 126.4
        height: 13
    }

    Part {
        id: merchantMoneyFrameCopperButton
        name: "MerchantMoneyFrameCopperButton"
        kind: "Button"
        text: "13"
        wowParent: "MerchantMoneyFrame"
        anchors.right: merchantMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantMoneyFrameCopperButtonText
        name: "MerchantMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "13"
        wowParent: "MerchantMoneyFrameCopperButton"
        anchors.right: merchantMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantMoneyFrameGoldButton
        name: "MerchantMoneyFrameGoldButton"
        kind: "Button"
        text: "3654"
        wowParent: "MerchantMoneyFrame"
        anchors.right: merchantMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    Part {
        id: merchantMoneyFrameGoldButtonText
        name: "MerchantMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "3654"
        wowParent: "MerchantMoneyFrameGoldButton"
        anchors.right: merchantMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Part {
        id: merchantMoneyFrameSilverButton
        name: "MerchantMoneyFrameSilverButton"
        kind: "Button"
        text: "16"
        wowParent: "MerchantMoneyFrame"
        anchors.right: merchantMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: merchantMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: merchantMoneyFrameSilverButtonText
        name: "MerchantMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "16"
        wowParent: "MerchantMoneyFrameSilverButton"
        anchors.right: merchantMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: merchantMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: merchantNameText
        name: "MerchantNameText"
        kind: "FontString"
        text: "Lisbeth Schneider"
        wowParent: "MerchantFrameDiabolicTitlePlate"
        anchors.horizontalCenter: merchantFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: merchantFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 158
        height: 14.2
    }

    Part {
        id: merchantNextPageButton
        name: "MerchantNextPageButton"
        kind: "Button"
        anchors.left: merchantPageText.right
        anchors.leftMargin: 8
        anchors.verticalCenter: merchantPageText.verticalCenter
        width: 26
        height: 26
    }

    Part {
        id: merchantPageText
        name: "MerchantPageText"
        kind: "FontString"
        text: "Page 1 of 4"
        anchors.left: merchantFrame.left
        anchors.leftMargin: 215.6
        anchors.top: merchantFrame.top
        anchors.topMargin: 342.1
        width: 66
        height: 12
    }

    Part {
        id: merchantPrevPageButton
        name: "MerchantPrevPageButton"
        kind: "Button"
        anchors.right: merchantPageText.left
        anchors.rightMargin: 8
        anchors.verticalCenter: merchantPageText.verticalCenter
        width: 26
        height: 26
    }

    Part {
        id: merchantRepairAllButton
        name: "MerchantRepairAllButton"
        kind: "Button"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 288
        anchors.top: merchantFrameDiabolic.top
        anchors.topMargin: 434
        width: 36
        height: 36
    }

    Part {
        id: merchantRepairItemButton
        name: "MerchantRepairItemButton"
        kind: "Button"
        wowParent: "MerchantFrame"
        anchors.right: merchantRepairAllButton.left
        anchors.rightMargin: 2
        anchors.verticalCenter: merchantRepairAllButton.verticalCenter
        width: 36
        height: 36
    }

    Part {
        id: merchantRepairText
        name: "MerchantRepairText"
        kind: "FontString"
        text: "Repair Items"
        wowParent: "MerchantFrame"
        anchors.left: merchantFrame.left
        anchors.leftMargin: 26
        anchors.bottom: merchantFrame.bottom
        anchors.bottomMargin: 103
        width: 67.2
        height: 10.3
    }

    Ghost { id: merchantItem10NameFrame; name: "MerchantItem10NameFrame"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: merchantItem11ItemButton; name: "MerchantItem11ItemButton"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: merchantItem12ItemButton; name: "MerchantItem12ItemButton"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: merchantItem1NameFrame; name: "MerchantItem1NameFrame"; x: 93.5; y: 105; width: 0; height: 0 }
    Ghost { id: merchantItem2NameFrame; name: "MerchantItem2NameFrame"; x: 311.5; y: 105; width: 0; height: 0 }
    Ghost { id: merchantItem3NameFrame; name: "MerchantItem3NameFrame"; x: 93.5; y: 157; width: 0; height: 0 }
    Ghost { id: merchantItem4NameFrame; name: "MerchantItem4NameFrame"; x: 311.5; y: 157; width: 0; height: 0 }
    Ghost { id: merchantItem5NameFrame; name: "MerchantItem5NameFrame"; x: 93.5; y: 209; width: 0; height: 0 }
    Ghost { id: merchantItem6NameFrame; name: "MerchantItem6NameFrame"; x: 311.5; y: 209; width: 0; height: 0 }
    Ghost { id: merchantItem7NameFrame; name: "MerchantItem7NameFrame"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: merchantItem8NameFrame; name: "MerchantItem8NameFrame"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: merchantItem9NameFrame; name: "MerchantItem9NameFrame"; x: 0; y: 0; width: 0; height: 0 }
}
