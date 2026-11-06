// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: tradeFrame
    name: "TradeFrame"
    width: 384
    height: 512

    Button {
        id: tradeFrameCancelButton
        name: "TradeFrameCancelButton"
        text: "Cancel"
        wowParent: "TradeFrame"
        style: "Button"
        pin: "all"
        anchors.left: tradeFrameTradeButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: tradeFrameTradeButton.verticalCenter
        width: 80
        height: 22
    }

    Button {
        id: tradeFrameCloseButton
        name: "TradeFrameCloseButton"
        wowParent: "TradeFrame"
        style: "CloseButton"
        anchors.horizontalCenter: tradeFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: tradeFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Frame {
        id: tradeFrameDiabolic
        name: "TradeFrameDiabolic"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: -24
        anchors.top: tradeFrame.top
        width: 422
        height: 496
    }

    Frame {
        id: tradeFrameDiabolicBorder
        name: "TradeFrameDiabolicBorder"
        wowParent: "TradeFrameDiabolic"
        anchors.left: tradeFrameDiabolic.left
        anchors.top: tradeFrameDiabolic.top
        width: 422
        height: 496
    }

    Frame {
        id: tradeFrameDiabolicSocket
        name: "TradeFrameDiabolicSocket"
        wowParent: "TradeFrameDiabolic"
        anchors.right: tradeFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: tradeFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: tradeFrameDiabolicTitlePlate
        name: "TradeFrameDiabolicTitlePlate"
        wowParent: "TradeFrameDiabolic"
        anchors.horizontalCenter: tradeFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: tradeFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    FontString {
        id: tradeFramePlayerEnchantText
        name: "TradeFramePlayerEnchantText"
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
    FontString {
        id: tradeFramePlayerNameText
        name: "TradeFramePlayerNameText"
        text: "Padirac"
        wowParent: "TradeFrame"
        pin: "place"
        anchors.horizontalCenter: tradePlayerItem1.horizontalCenter
        anchors.bottom: tradePlayerItem1.top
        anchors.bottomMargin: 50
        width: 100
        height: 12
    }

    FontString {
        id: tradeFrameRecipientEnchantText
        name: "TradeFrameRecipientEnchantText"
        text: "Will not be traded"
        wowParent: "TradeFrame"
        anchors.left: tradeFramePlayerEnchantText.left
        anchors.leftMargin: 170
        anchors.verticalCenter: tradeFramePlayerEnchantText.verticalCenter
        width: 95.6
        height: 10.3
    }

    FontString {
        id: tradeFrameRecipientNameText
        name: "TradeFrameRecipientNameText"
        text: "Velkara"
        wowParent: "TradeFrame"
        pin: "place"
        anchors.horizontalCenter: tradeRecipientItem1.horizontalCenter
        anchors.bottom: tradeRecipientItem1.top
        anchors.bottomMargin: 50
        width: 80
        height: 12
    }

    Button {
        id: tradeFrameTradeButton
        name: "TradeFrameTradeButton"
        text: "Trade"
        wowParent: "TradeFrame"
        style: "Button"
        pin: "all"
        anchors.left: tradeFrameDiabolic.left
        anchors.leftMargin: 219
        anchors.bottom: tradeFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 80
        height: 22
    }

    Frame {
        id: tradePlayerInputMoneyFrame
        name: "TradePlayerInputMoneyFrame"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 26
        anchors.top: tradeFrame.top
        anchors.topMargin: 73
        width: 176
        height: 18
    }

    EditBox {
        id: tradePlayerInputMoneyFrameCopper
        name: "TradePlayerInputMoneyFrameCopper"
        wowParent: "TradePlayerInputMoneyFrame"
        anchors.left: tradePlayerInputMoneyFrameSilver.right
        anchors.leftMargin: 11
        anchors.verticalCenter: tradePlayerInputMoneyFrameSilver.verticalCenter
        width: 30
        height: 20
    }

    EditBox {
        id: tradePlayerInputMoneyFrameGold
        name: "TradePlayerInputMoneyFrameGold"
        wowParent: "TradePlayerInputMoneyFrame"
        anchors.left: tradePlayerInputMoneyFrame.left
        anchors.top: tradePlayerInputMoneyFrame.top
        width: 56
        height: 20
    }

    EditBox {
        id: tradePlayerInputMoneyFrameSilver
        name: "TradePlayerInputMoneyFrameSilver"
        wowParent: "TradePlayerInputMoneyFrame"
        anchors.left: tradePlayerInputMoneyFrameGold.right
        anchors.leftMargin: 22
        anchors.verticalCenter: tradePlayerInputMoneyFrameGold.verticalCenter
        width: 30
        height: 20
    }

    Frame {
        id: tradePlayerItem1
        name: "TradePlayerItem1"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 26
        anchors.top: tradeFrame.top
        anchors.topMargin: 104
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem1ItemButton
        name: "TradePlayerItem1ItemButton"
        wowParent: "TradePlayerItem1"
        anchors.left: tradePlayerItem1.left
        anchors.top: tradePlayerItem1.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem1Name
        name: "TradePlayerItem1Name"
        wowParent: "TradePlayerItem1"
        anchors.left: tradePlayerItem1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem1NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradePlayerItem2
        name: "TradePlayerItem2"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem1.left
        anchors.top: tradePlayerItem1.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem2ItemButton
        name: "TradePlayerItem2ItemButton"
        wowParent: "TradePlayerItem2"
        anchors.left: tradePlayerItem2.left
        anchors.top: tradePlayerItem2.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem2Name
        name: "TradePlayerItem2Name"
        wowParent: "TradePlayerItem2"
        anchors.left: tradePlayerItem2NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem2NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradePlayerItem3
        name: "TradePlayerItem3"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem2.left
        anchors.top: tradePlayerItem2.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem3ItemButton
        name: "TradePlayerItem3ItemButton"
        wowParent: "TradePlayerItem3"
        anchors.left: tradePlayerItem3.left
        anchors.top: tradePlayerItem3.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem3Name
        name: "TradePlayerItem3Name"
        wowParent: "TradePlayerItem3"
        anchors.left: tradePlayerItem3NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem3NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradePlayerItem4
        name: "TradePlayerItem4"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem3.left
        anchors.top: tradePlayerItem3.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem4ItemButton
        name: "TradePlayerItem4ItemButton"
        wowParent: "TradePlayerItem4"
        anchors.left: tradePlayerItem4.left
        anchors.top: tradePlayerItem4.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem4Name
        name: "TradePlayerItem4Name"
        wowParent: "TradePlayerItem4"
        anchors.left: tradePlayerItem4NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem4NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradePlayerItem5
        name: "TradePlayerItem5"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem4.left
        anchors.top: tradePlayerItem4.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem5ItemButton
        name: "TradePlayerItem5ItemButton"
        wowParent: "TradePlayerItem5"
        anchors.left: tradePlayerItem5.left
        anchors.top: tradePlayerItem5.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem5Name
        name: "TradePlayerItem5Name"
        wowParent: "TradePlayerItem5"
        anchors.left: tradePlayerItem5NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem5NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradePlayerItem6
        name: "TradePlayerItem6"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem5.left
        anchors.top: tradePlayerItem5.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem6ItemButton
        name: "TradePlayerItem6ItemButton"
        wowParent: "TradePlayerItem6"
        anchors.left: tradePlayerItem6.left
        anchors.top: tradePlayerItem6.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem6Name
        name: "TradePlayerItem6Name"
        wowParent: "TradePlayerItem6"
        anchors.left: tradePlayerItem6NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem6NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradePlayerItem7
        name: "TradePlayerItem7"
        wowParent: "TradeFrame"
        anchors.left: tradePlayerItem6.left
        anchors.top: tradePlayerItem6.bottom
        anchors.topMargin: 28
        width: 153
        height: 37
    }

    Button {
        id: tradePlayerItem7ItemButton
        name: "TradePlayerItem7ItemButton"
        wowParent: "TradePlayerItem7"
        anchors.left: tradePlayerItem7.left
        anchors.top: tradePlayerItem7.top
        width: 37
        height: 37
    }

    FontString {
        id: tradePlayerItem7Name
        name: "TradePlayerItem7Name"
        wowParent: "TradePlayerItem7"
        anchors.left: tradePlayerItem7NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradePlayerItem7NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem1
        name: "TradeRecipientItem1"
        wowParent: "TradeFrame"
        anchors.left: tradeFrame.left
        anchors.leftMargin: 195
        anchors.top: tradeFrame.top
        anchors.topMargin: 104
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem1ItemButton
        name: "TradeRecipientItem1ItemButton"
        wowParent: "TradeRecipientItem1"
        anchors.left: tradeRecipientItem1.left
        anchors.top: tradeRecipientItem1.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem1Name
        name: "TradeRecipientItem1Name"
        wowParent: "TradeRecipientItem1"
        anchors.left: tradeRecipientItem1NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem1NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem2
        name: "TradeRecipientItem2"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem1.left
        anchors.top: tradeRecipientItem1.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem2ItemButton
        name: "TradeRecipientItem2ItemButton"
        wowParent: "TradeRecipientItem2"
        anchors.left: tradeRecipientItem2.left
        anchors.top: tradeRecipientItem2.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem2Name
        name: "TradeRecipientItem2Name"
        wowParent: "TradeRecipientItem2"
        anchors.left: tradeRecipientItem2NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem2NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem3
        name: "TradeRecipientItem3"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem2.left
        anchors.top: tradeRecipientItem2.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem3ItemButton
        name: "TradeRecipientItem3ItemButton"
        wowParent: "TradeRecipientItem3"
        anchors.left: tradeRecipientItem3.left
        anchors.top: tradeRecipientItem3.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem3Name
        name: "TradeRecipientItem3Name"
        wowParent: "TradeRecipientItem3"
        anchors.left: tradeRecipientItem3NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem3NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem4
        name: "TradeRecipientItem4"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem3.left
        anchors.top: tradeRecipientItem3.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem4ItemButton
        name: "TradeRecipientItem4ItemButton"
        wowParent: "TradeRecipientItem4"
        anchors.left: tradeRecipientItem4.left
        anchors.top: tradeRecipientItem4.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem4Name
        name: "TradeRecipientItem4Name"
        wowParent: "TradeRecipientItem4"
        anchors.left: tradeRecipientItem4NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem4NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem5
        name: "TradeRecipientItem5"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem4.left
        anchors.top: tradeRecipientItem4.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem5ItemButton
        name: "TradeRecipientItem5ItemButton"
        wowParent: "TradeRecipientItem5"
        anchors.left: tradeRecipientItem5.left
        anchors.top: tradeRecipientItem5.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem5Name
        name: "TradeRecipientItem5Name"
        wowParent: "TradeRecipientItem5"
        anchors.left: tradeRecipientItem5NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem5NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem6
        name: "TradeRecipientItem6"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem5.left
        anchors.top: tradeRecipientItem5.bottom
        anchors.topMargin: 7
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem6ItemButton
        name: "TradeRecipientItem6ItemButton"
        wowParent: "TradeRecipientItem6"
        anchors.left: tradeRecipientItem6.left
        anchors.top: tradeRecipientItem6.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem6Name
        name: "TradeRecipientItem6Name"
        wowParent: "TradeRecipientItem6"
        anchors.left: tradeRecipientItem6NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem6NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientItem7
        name: "TradeRecipientItem7"
        wowParent: "TradeFrame"
        anchors.left: tradeRecipientItem6.left
        anchors.top: tradeRecipientItem6.bottom
        anchors.topMargin: 28
        width: 153
        height: 37
    }

    Button {
        id: tradeRecipientItem7ItemButton
        name: "TradeRecipientItem7ItemButton"
        wowParent: "TradeRecipientItem7"
        anchors.left: tradeRecipientItem7.left
        anchors.top: tradeRecipientItem7.top
        width: 37
        height: 37
    }

    FontString {
        id: tradeRecipientItem7Name
        name: "TradeRecipientItem7Name"
        wowParent: "TradeRecipientItem7"
        anchors.left: tradeRecipientItem7NameFrame.left
        anchors.leftMargin: 15
        anchors.verticalCenter: tradeRecipientItem7NameFrame.verticalCenter
        width: 90
        height: 30
    }

    Frame {
        id: tradeRecipientMoneyFrame
        name: "TradeRecipientMoneyFrame"
        wowParent: "TradeFrame"
        anchors.right: tradeFrame.right
        anchors.rightMargin: 40
        anchors.top: tradeFrame.top
        anchors.topMargin: 78
        width: 13
        height: 13
    }

    WowRow {
        name: "TradeButtons"
        parts: ["TradeFrameTradeButton", "TradeFrameCancelButton"]
        fit: "equal"
        anchors.left: tradeFrameDiabolic.left
        anchors.leftMargin: 219
        anchors.right: tradeFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: tradeFrameDiabolic.bottom
        anchors.bottomMargin: 30
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
