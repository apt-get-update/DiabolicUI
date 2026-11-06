// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: tradeFrame
    name: "TradeFrame"
    width: 384
    height: 512

    Part {
        id: tradeFrameCancelButton
        name: "TradeFrameCancelButton"
        kind: "Button"
        text: "Cancel"
        wowParent: "TradeFrame"
        anchors.right: tradeFrame.right
        anchors.rightMargin: 33
        anchors.bottom: tradeFrame.bottom
        anchors.bottomMargin: 55
        width: 75.6
        height: 22
    }

    Part {
        id: tradeFrameCloseButton
        name: "TradeFrameCloseButton"
        kind: "Button"
        wowParent: "TradeFrame"
        anchors.horizontalCenter: tradeFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: tradeFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: tradeFrameDiabolic
        name: "TradeFrameDiabolic"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: -24
        anchors.top: tradeFrame.top
        width: 422
        height: 496
    }

    Part {
        id: tradeFrameDiabolicBorder
        name: "TradeFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "TradeFrameDiabolic"
        anchors.left: tradeFrameDiabolic.left
        anchors.top: tradeFrameDiabolic.top
        width: 422
        height: 496
    }

    Part {
        id: tradeFrameDiabolicSocket
        name: "TradeFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "TradeFrameDiabolic"
        anchors.right: tradeFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: tradeFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: tradeFrameDiabolicTitlePlate
        name: "TradeFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "TradeFrameDiabolic"
        anchors.horizontalCenter: tradeFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: tradeFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: tradeFramePlayerEnchantText
        name: "TradeFramePlayerEnchantText"
        kind: "FontString"
        text: "Will not be traded"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 26
        anchors.top: tradeFrame.top
        anchors.topMargin: 374
        width: 95.6
        height: 10.3
    }

    // the names over their columns, out from under the band (Blizzard's beside portraits)
    Part {
        id: tradeFramePlayerNameText
        name: "TradeFramePlayerNameText"
        kind: "FontString"
        text: "Padirac"
        wowParent: "TradeFrame"
        pin: "place"
        anchors.horizontalCenter: tradePlayerItem1.horizontalCenter
        anchors.bottom: tradePlayerItem1.top
        anchors.bottomMargin: 50
        width: 100
        height: 12
    }

    Part {
        id: tradeFrameRecipientEnchantText
        name: "TradeFrameRecipientEnchantText"
        kind: "FontString"
        text: "Will not be traded"
        wowParent: "TradeFrame"
        anchors.left: tradeFramePlayerEnchantText.left
        anchors.leftMargin: 170
        anchors.verticalCenter: tradeFramePlayerEnchantText.verticalCenter
        width: 95.6
        height: 10.3
    }

    Part {
        id: tradeFrameRecipientNameText
        name: "TradeFrameRecipientNameText"
        kind: "FontString"
        text: "Unluckylock"
        wowParent: "TradeFrame"
        pin: "place"
        anchors.horizontalCenter: tradeRecipientItem1.horizontalCenter
        anchors.bottom: tradeRecipientItem1.top
        anchors.bottomMargin: 50
        width: 80
        height: 12
    }

    Part {
        id: tradeFrameTradeButton
        name: "TradeFrameTradeButton"
        kind: "Button"
        text: "Trade"
        wowParent: "TradeFrame"
        anchors.right: tradeFrame.right
        anchors.rightMargin: 114.6
        anchors.bottom: tradeFrame.bottom
        anchors.bottomMargin: 55
        width: 83.4
        height: 22
    }

    Part {
        id: tradePlayerInputMoneyFrame
        name: "TradePlayerInputMoneyFrame"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 26
        anchors.top: tradeFrame.top
        anchors.topMargin: 73
        width: 176
        height: 18
    }

    Part {
        id: tradePlayerInputMoneyFrameCopper
        name: "TradePlayerInputMoneyFrameCopper"
        kind: "EditBox"
        wowParent: "TradePlayerInputMoneyFrame"
        anchors.left: tradePlayerInputMoneyFrameSilver.right
        anchors.leftMargin: 11
        anchors.verticalCenter: tradePlayerInputMoneyFrameSilver.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: tradePlayerInputMoneyFrameGold
        name: "TradePlayerInputMoneyFrameGold"
        kind: "EditBox"
        wowParent: "TradePlayerInputMoneyFrame"
        anchors.left: tradePlayerInputMoneyFrame.left
        anchors.top: tradePlayerInputMoneyFrame.top
        width: 56
        height: 20
    }

    Part {
        id: tradePlayerInputMoneyFrameSilver
        name: "TradePlayerInputMoneyFrameSilver"
        kind: "EditBox"
        wowParent: "TradePlayerInputMoneyFrame"
        anchors.left: tradePlayerInputMoneyFrameGold.right
        anchors.leftMargin: 22
        anchors.verticalCenter: tradePlayerInputMoneyFrameGold.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: tradePlayerItem1
        name: "TradePlayerItem1"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 26
        anchors.top: tradeFrame.top
        anchors.topMargin: 104
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem1ItemButton
        name: "TradePlayerItem1ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem1"
        anchors.left: tradePlayerItem1.left
        anchors.top: tradePlayerItem1.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem1Name
        name: "TradePlayerItem1Name"
        kind: "FontString"
        wowParent: "TradePlayerItem1"
        anchors.left: tradePlayerItem1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem1NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradePlayerItem2
        name: "TradePlayerItem2"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem1.left
        anchors.top: tradePlayerItem1.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem2ItemButton
        name: "TradePlayerItem2ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem2"
        anchors.left: tradePlayerItem2.left
        anchors.top: tradePlayerItem2.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem2Name
        name: "TradePlayerItem2Name"
        kind: "FontString"
        wowParent: "TradePlayerItem2"
        anchors.left: tradePlayerItem2NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem2NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradePlayerItem3
        name: "TradePlayerItem3"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem2.left
        anchors.top: tradePlayerItem2.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem3ItemButton
        name: "TradePlayerItem3ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem3"
        anchors.left: tradePlayerItem3.left
        anchors.top: tradePlayerItem3.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem3Name
        name: "TradePlayerItem3Name"
        kind: "FontString"
        wowParent: "TradePlayerItem3"
        anchors.left: tradePlayerItem3NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem3NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradePlayerItem4
        name: "TradePlayerItem4"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem3.left
        anchors.top: tradePlayerItem3.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem4ItemButton
        name: "TradePlayerItem4ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem4"
        anchors.left: tradePlayerItem4.left
        anchors.top: tradePlayerItem4.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem4Name
        name: "TradePlayerItem4Name"
        kind: "FontString"
        wowParent: "TradePlayerItem4"
        anchors.left: tradePlayerItem4NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem4NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradePlayerItem5
        name: "TradePlayerItem5"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem4.left
        anchors.top: tradePlayerItem4.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem5ItemButton
        name: "TradePlayerItem5ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem5"
        anchors.left: tradePlayerItem5.left
        anchors.top: tradePlayerItem5.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem5Name
        name: "TradePlayerItem5Name"
        kind: "FontString"
        wowParent: "TradePlayerItem5"
        anchors.left: tradePlayerItem5NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem5NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradePlayerItem6
        name: "TradePlayerItem6"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem5.left
        anchors.top: tradePlayerItem5.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem6ItemButton
        name: "TradePlayerItem6ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem6"
        anchors.left: tradePlayerItem6.left
        anchors.top: tradePlayerItem6.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem6Name
        name: "TradePlayerItem6Name"
        kind: "FontString"
        wowParent: "TradePlayerItem6"
        anchors.left: tradePlayerItem6NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem6NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradePlayerItem7
        name: "TradePlayerItem7"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem6.left
        anchors.top: tradePlayerItem6.bottom
        anchors.topMargin: 28
        width: 153
        height: 37
    }

    Part {
        id: tradePlayerItem7ItemButton
        name: "TradePlayerItem7ItemButton"
        kind: "Button"
        wowParent: "TradePlayerItem7"
        anchors.left: tradePlayerItem7.left
        anchors.top: tradePlayerItem7.top
        width: 37
        height: 37
    }

    Part {
        id: tradePlayerItem7Name
        name: "TradePlayerItem7Name"
        kind: "FontString"
        wowParent: "TradePlayerItem7"
        anchors.left: tradePlayerItem7NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem7NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem1
        name: "TradeRecipientItem1"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 195
        anchors.top: tradeFrame.top
        anchors.topMargin: 104
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem1ItemButton
        name: "TradeRecipientItem1ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem1"
        anchors.left: tradeRecipientItem1.left
        anchors.top: tradeRecipientItem1.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem1Name
        name: "TradeRecipientItem1Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem1"
        anchors.left: tradeRecipientItem1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem1NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem2
        name: "TradeRecipientItem2"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem1.left
        anchors.top: tradeRecipientItem1.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem2ItemButton
        name: "TradeRecipientItem2ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem2"
        anchors.left: tradeRecipientItem2.left
        anchors.top: tradeRecipientItem2.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem2Name
        name: "TradeRecipientItem2Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem2"
        anchors.left: tradeRecipientItem2NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem2NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem3
        name: "TradeRecipientItem3"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem2.left
        anchors.top: tradeRecipientItem2.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem3ItemButton
        name: "TradeRecipientItem3ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem3"
        anchors.left: tradeRecipientItem3.left
        anchors.top: tradeRecipientItem3.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem3Name
        name: "TradeRecipientItem3Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem3"
        anchors.left: tradeRecipientItem3NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem3NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem4
        name: "TradeRecipientItem4"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem3.left
        anchors.top: tradeRecipientItem3.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem4ItemButton
        name: "TradeRecipientItem4ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem4"
        anchors.left: tradeRecipientItem4.left
        anchors.top: tradeRecipientItem4.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem4Name
        name: "TradeRecipientItem4Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem4"
        anchors.left: tradeRecipientItem4NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem4NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem5
        name: "TradeRecipientItem5"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem4.left
        anchors.top: tradeRecipientItem4.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem5ItemButton
        name: "TradeRecipientItem5ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem5"
        anchors.left: tradeRecipientItem5.left
        anchors.top: tradeRecipientItem5.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem5Name
        name: "TradeRecipientItem5Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem5"
        anchors.left: tradeRecipientItem5NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem5NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem6
        name: "TradeRecipientItem6"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem5.left
        anchors.top: tradeRecipientItem5.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem6ItemButton
        name: "TradeRecipientItem6ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem6"
        anchors.left: tradeRecipientItem6.left
        anchors.top: tradeRecipientItem6.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem6Name
        name: "TradeRecipientItem6Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem6"
        anchors.left: tradeRecipientItem6NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem6NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientItem7
        name: "TradeRecipientItem7"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem6.left
        anchors.top: tradeRecipientItem6.bottom
        anchors.topMargin: 28
        width: 153
        height: 37
    }

    Part {
        id: tradeRecipientItem7ItemButton
        name: "TradeRecipientItem7ItemButton"
        kind: "Button"
        wowParent: "TradeRecipientItem7"
        anchors.left: tradeRecipientItem7.left
        anchors.top: tradeRecipientItem7.top
        width: 37
        height: 37
    }

    Part {
        id: tradeRecipientItem7Name
        name: "TradeRecipientItem7Name"
        kind: "FontString"
        wowParent: "TradeRecipientItem7"
        anchors.left: tradeRecipientItem7NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem7NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Part {
        id: tradeRecipientMoneyFrame
        name: "TradeRecipientMoneyFrame"
        kind: "Frame"
        wowParent: "TradeFrame"
        anchors.right: tradeFrame.right
        anchors.rightMargin: 40
        anchors.top: tradeFrame.top
        anchors.topMargin: 78
        width: 13
        height: 13
    }

    Ghost { id: tradePlayerItem1NameFrame; name: "TradePlayerItem1NameFrame"; x: 57; y: 123; width: 0; height: 0 }
    Ghost { id: tradePlayerItem2NameFrame; name: "TradePlayerItem2NameFrame"; x: 57; y: 167; width: 0; height: 0 }
    Ghost { id: tradePlayerItem3NameFrame; name: "TradePlayerItem3NameFrame"; x: 57; y: 211; width: 0; height: 0 }
    Ghost { id: tradePlayerItem4NameFrame; name: "TradePlayerItem4NameFrame"; x: 57; y: 255; width: 0; height: 0 }
    Ghost { id: tradePlayerItem5NameFrame; name: "TradePlayerItem5NameFrame"; x: 57; y: 299; width: 0; height: 0 }
    Ghost { id: tradePlayerItem6NameFrame; name: "TradePlayerItem6NameFrame"; x: 57; y: 343; width: 0; height: 0 }
    Ghost { id: tradePlayerItem7NameFrame; name: "TradePlayerItem7NameFrame"; x: 57; y: 408; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem1NameFrame; name: "TradeRecipientItem1NameFrame"; x: 226; y: 123; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem2NameFrame; name: "TradeRecipientItem2NameFrame"; x: 226; y: 167; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem3NameFrame; name: "TradeRecipientItem3NameFrame"; x: 226; y: 211; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem4NameFrame; name: "TradeRecipientItem4NameFrame"; x: 226; y: 255; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem5NameFrame; name: "TradeRecipientItem5NameFrame"; x: 226; y: 299; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem6NameFrame; name: "TradeRecipientItem6NameFrame"; x: 226; y: 343; width: 0; height: 0 }
    Ghost { id: tradeRecipientItem7NameFrame; name: "TradeRecipientItem7NameFrame"; x: 226; y: 408; width: 0; height: 0 }
}
