// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "TradeFrame"
    width: 384
    height: 512

    Frame {
        name: "TradeFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        width: 422
        height: 496

        Button {
            name: "TradeFrameCloseButton"
            wowParent: "TradeFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "TradeFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 422
            height: 496

            Frame {
                name: "TradeFrameDiabolicTitlePlate"
                wowParent: "TradeFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "TradeFrameDiabolicTitle"
                    text: "Trade"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 52.9
                    height: 14.2
                }
            }
        }

        Frame {
            name: "TradeFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 376
            height: 35

            WowRow {
                name: "TradeButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 196
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "TradeFrameTradeButton"
                    text: "Trade"
                    wowParent: "TradeFrame"
                    style: "Button"
                    pin: "all"
                    width: 80
                    height: 22
                }

                Button {
                    name: "TradeFrameCancelButton"
                    text: "Cancel"
                    wowParent: "TradeFrame"
                    style: "Button"
                    pin: "all"
                    width: 80
                    height: 22
                }
            }
        }

        Frame {
            name: "TradeFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    FontString {
        name: "TradeFramePlayerEnchantText"
        text: "Will not be traded"
        pin: "place"
        anchors.left: tradePlayerItem7.left
        anchors.top: tradePlayerItem7.top
        anchors.topMargin: -18
        width: 95.6
        height: 10.3
    }

    // the names over their columns, out from under the band (Blizzard's beside portraits)
    FontString {
        name: "TradeFramePlayerNameText"
        text: "Padirac"
        pin: "place"
        anchors.horizontalCenter: tradePlayerItem1.horizontalCenter
        anchors.bottom: tradePlayerItem1.top
        anchors.bottomMargin: 44
        width: 100
        height: 12
    }

    FontString {
        name: "TradeFrameRecipientEnchantText"
        text: "Will not be traded"
        pin: "place"
        anchors.left: tradeRecipientItem7.left
        anchors.top: tradeRecipientItem7.top
        anchors.topMargin: -18
        width: 95.6
        height: 10.3
    }

    FontString {
        name: "TradeFrameRecipientNameText"
        text: "Tmanx"
        pin: "place"
        anchors.horizontalCenter: tradeRecipientItem1.horizontalCenter
        anchors.bottom: tradeRecipientItem1.top
        anchors.bottomMargin: 44
        width: 80
        height: 12
    }

    Frame {
        id: tradeHighlightPlayer
        name: "TradeHighlightPlayer"
        pin: "place"
        anchors.left: tradePlayerItem1.left
        anchors.leftMargin: -7
        anchors.top: tradePlayerItem1.top
        anchors.topMargin: -4
        width: 161
        height: 266
    }

    Frame {
        name: "TradeHighlightPlayerEnchant"
        anchors.left: tradeHighlightPlayer.left
        anchors.top: tradeHighlightPlayer.bottom
        anchors.topMargin: 4
        width: 161
        height: 61
    }

    Frame {
        name: "TradePlayerInputMoneyFrame"
        pin: "place"
        anchors.left: tradePlayerItem1.left
        anchors.top: tradePlayerItem1.top
        anchors.topMargin: -31
        width: 176
        height: 18

        EditBox {
            name: "TradePlayerInputMoneyFrameCopper"
            anchors.left: tradePlayerInputMoneyFrameSilver.right
            anchors.leftMargin: 11
            anchors.verticalCenter: tradePlayerInputMoneyFrameSilver.verticalCenter
            width: 30
            height: 20
        }

        EditBox {
            id: tradePlayerInputMoneyFrameGold
            name: "TradePlayerInputMoneyFrameGold"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 56
            height: 20
        }

        EditBox {
            id: tradePlayerInputMoneyFrameSilver
            name: "TradePlayerInputMoneyFrameSilver"
            text: "2"
            anchors.left: tradePlayerInputMoneyFrameGold.right
            anchors.leftMargin: 22
            anchors.verticalCenter: tradePlayerInputMoneyFrameGold.verticalCenter
            width: 30
            height: 20
        }
    }

    Frame {
        id: tradePlayerItem1
        name: "TradePlayerItem1"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 96
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem1ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem1NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem1Name"
                wowParent: "TradePlayerItem1"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradePlayerItem2
        name: "TradePlayerItem2"
        anchors.left: tradePlayerItem1.left
        anchors.top: tradePlayerItem1.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem2ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem2NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem2Name"
                wowParent: "TradePlayerItem2"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradePlayerItem3
        name: "TradePlayerItem3"
        anchors.left: tradePlayerItem2.left
        anchors.top: tradePlayerItem2.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem3ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem3NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem3Name"
                wowParent: "TradePlayerItem3"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradePlayerItem4
        name: "TradePlayerItem4"
        anchors.left: tradePlayerItem3.left
        anchors.top: tradePlayerItem3.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem4ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem4NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem4Name"
                wowParent: "TradePlayerItem4"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradePlayerItem5
        name: "TradePlayerItem5"
        anchors.left: tradePlayerItem4.left
        anchors.top: tradePlayerItem4.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem5ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem5NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem5Name"
                wowParent: "TradePlayerItem5"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradePlayerItem6
        name: "TradePlayerItem6"
        anchors.left: tradePlayerItem5.left
        anchors.top: tradePlayerItem5.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem6ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem6NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem6Name"
                wowParent: "TradePlayerItem6"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradePlayerItem7
        name: "TradePlayerItem7"
        pin: "place"
        anchors.left: tradePlayerItem6.left
        anchors.top: tradePlayerItem6.bottom
        anchors.topMargin: 26
        width: 153
        height: 37

        Button {
            name: "TradePlayerItem7ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradePlayerItem7NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradePlayerItem7Name"
                wowParent: "TradePlayerItem7"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem1
        name: "TradeRecipientItem1"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 201
        anchors.top: parent.top
        anchors.topMargin: 96
        width: 153
        height: 37

        // the recipient's accepted glow, as yours (not seen by a scan made before they accept)
        Frame {
            name: "TradeHighlightRecipient"
            wowParent: "TradeFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 161
            height: 266
        }

        Button {
            name: "TradeRecipientItem1ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem1NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem1Name"
                wowParent: "TradeRecipientItem1"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem2
        name: "TradeRecipientItem2"
        anchors.left: tradeRecipientItem1.left
        anchors.top: tradeRecipientItem1.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradeRecipientItem2ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem2NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem2Name"
                wowParent: "TradeRecipientItem2"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem3
        name: "TradeRecipientItem3"
        anchors.left: tradeRecipientItem2.left
        anchors.top: tradeRecipientItem2.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradeRecipientItem3ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem3NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem3Name"
                wowParent: "TradeRecipientItem3"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem4
        name: "TradeRecipientItem4"
        anchors.left: tradeRecipientItem3.left
        anchors.top: tradeRecipientItem3.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradeRecipientItem4ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem4NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem4Name"
                wowParent: "TradeRecipientItem4"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem5
        name: "TradeRecipientItem5"
        anchors.left: tradeRecipientItem4.left
        anchors.top: tradeRecipientItem4.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradeRecipientItem5ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem5NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem5Name"
                wowParent: "TradeRecipientItem5"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem6
        name: "TradeRecipientItem6"
        anchors.left: tradeRecipientItem5.left
        anchors.top: tradeRecipientItem5.bottom
        anchors.topMargin: 7
        width: 153
        height: 37

        Button {
            name: "TradeRecipientItem6ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem6NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem6Name"
                wowParent: "TradeRecipientItem6"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        id: tradeRecipientItem7
        name: "TradeRecipientItem7"
        pin: "place"
        anchors.left: tradeRecipientItem6.left
        anchors.top: tradeRecipientItem6.bottom
        anchors.topMargin: 26
        width: 153
        height: 37

        Button {
            name: "TradeRecipientItem7ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Ghost {
            name: "TradeRecipientItem7NameFrame"
            x: 31
            y: 19
            width: 0
            height: 0

            FontString {
                name: "TradeRecipientItem7Name"
                wowParent: "TradeRecipientItem7"
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 30
            }
        }
    }

    Frame {
        name: "TradeRecipientMoneyFrame"
        pin: "place"
        anchors.right: tradeRecipientItem1.right
        anchors.verticalCenter: tradeRecipientItem1.top
        anchors.verticalCenterOffset: -22
        width: 13
        height: 13
    }
}
