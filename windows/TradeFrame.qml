// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "TradeFrame"
    width: 384
    height: 512

    Frame {
        name: "TradeFrameDiabolic"
        wowParent: "TradeFrame"
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
            wowParent: "TradeFrameDiabolic"
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
                    wowParent: "TradeFrameDiabolicTitlePlate"
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
            wowParent: "TradeFrameDiabolic"
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
            wowParent: "TradeFrameDiabolic"
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
        wowParent: "TradeFrame"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.top: parent.top
        anchors.topMargin: 374
        width: 95.6
        height: 10.3

        FontString {
            name: "TradeFrameRecipientEnchantText"
            text: "Will not be traded"
            wowParent: "TradeFrame"
            anchors.left: parent.left
            anchors.leftMargin: 170
            anchors.verticalCenter: parent.verticalCenter
            width: 95.6
            height: 10.3
        }
    }

    Frame {
        name: "TradeHighlightPlayer"
        wowParent: "TradeFrame"
        anchors.left: parent.left
        anchors.leftMargin: 19
        anchors.top: parent.top
        anchors.topMargin: 100
        width: 161
        height: 266

        Frame {
            name: "TradeHighlightPlayerEnchant"
            wowParent: "TradeFrame"
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 4
            width: 161
            height: 61
        }
    }

    Frame {
        name: "TradePlayerInputMoneyFrame"
        wowParent: "TradeFrame"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.top: parent.top
        anchors.topMargin: 73
        width: 176
        height: 18

        EditBox {
            name: "TradePlayerInputMoneyFrameGold"
            wowParent: "TradePlayerInputMoneyFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 56
            height: 20

            EditBox {
                name: "TradePlayerInputMoneyFrameSilver"
                text: "2"
                wowParent: "TradePlayerInputMoneyFrame"
                anchors.left: parent.right
                anchors.leftMargin: 22
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: 20

                EditBox {
                    name: "TradePlayerInputMoneyFrameCopper"
                    wowParent: "TradePlayerInputMoneyFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 11
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 20
                }
            }
        }
    }

    Frame {
        name: "TradePlayerItem1"
        wowParent: "TradeFrame"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.top: parent.top
        anchors.topMargin: 104
        width: 153
        height: 37

        // the names over their columns, out from under the band (Blizzard's beside portraits)
        FontString {
            name: "TradeFramePlayerNameText"
            text: "Padirac"
            wowParent: "TradeFrame"
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 50
            width: 100
            height: 12
        }

        Button {
            name: "TradePlayerItem1ItemButton"
            wowParent: "TradePlayerItem1"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Frame {
            name: "TradePlayerItem2"
            wowParent: "TradeFrame"
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 7
            width: 153
            height: 37

            Button {
                name: "TradePlayerItem2ItemButton"
                wowParent: "TradePlayerItem2"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 37
                height: 37
            }

            Frame {
                name: "TradePlayerItem3"
                wowParent: "TradeFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 7
                width: 153
                height: 37

                Button {
                    name: "TradePlayerItem3ItemButton"
                    wowParent: "TradePlayerItem3"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 37
                    height: 37
                }

                Frame {
                    name: "TradePlayerItem4"
                    wowParent: "TradeFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 7
                    width: 153
                    height: 37

                    Button {
                        name: "TradePlayerItem4ItemButton"
                        wowParent: "TradePlayerItem4"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 37
                        height: 37
                    }

                    Frame {
                        name: "TradePlayerItem5"
                        wowParent: "TradeFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 7
                        width: 153
                        height: 37

                        Button {
                            name: "TradePlayerItem5ItemButton"
                            wowParent: "TradePlayerItem5"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 37
                            height: 37
                        }

                        Frame {
                            name: "TradePlayerItem6"
                            wowParent: "TradeFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 7
                            width: 153
                            height: 37

                            Button {
                                name: "TradePlayerItem6ItemButton"
                                wowParent: "TradePlayerItem6"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                width: 37
                                height: 37
                            }

                            Frame {
                                name: "TradePlayerItem7"
                                wowParent: "TradeFrame"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 28
                                width: 153
                                height: 37

                                Button {
                                    name: "TradePlayerItem7ItemButton"
                                    wowParent: "TradePlayerItem7"
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    width: 37
                                    height: 37
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Frame {
        name: "TradeRecipientItem1"
        wowParent: "TradeFrame"
        anchors.left: parent.left
        anchors.leftMargin: 195
        anchors.top: parent.top
        anchors.topMargin: 104
        width: 153
        height: 37

        FontString {
            name: "TradeFrameRecipientNameText"
            text: "Tmanx"
            wowParent: "TradeFrame"
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 50
            width: 80
            height: 12
        }

        Button {
            name: "TradeRecipientItem1ItemButton"
            wowParent: "TradeRecipientItem1"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37
            height: 37
        }

        Frame {
            name: "TradeRecipientItem2"
            wowParent: "TradeFrame"
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 7
            width: 153
            height: 37

            Button {
                name: "TradeRecipientItem2ItemButton"
                wowParent: "TradeRecipientItem2"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 37
                height: 37
            }

            Frame {
                name: "TradeRecipientItem3"
                wowParent: "TradeFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 7
                width: 153
                height: 37

                Button {
                    name: "TradeRecipientItem3ItemButton"
                    wowParent: "TradeRecipientItem3"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 37
                    height: 37
                }

                Frame {
                    name: "TradeRecipientItem4"
                    wowParent: "TradeFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 7
                    width: 153
                    height: 37

                    Button {
                        name: "TradeRecipientItem4ItemButton"
                        wowParent: "TradeRecipientItem4"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 37
                        height: 37
                    }

                    Frame {
                        name: "TradeRecipientItem5"
                        wowParent: "TradeFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 7
                        width: 153
                        height: 37

                        Button {
                            name: "TradeRecipientItem5ItemButton"
                            wowParent: "TradeRecipientItem5"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 37
                            height: 37
                        }

                        Frame {
                            name: "TradeRecipientItem6"
                            wowParent: "TradeFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 7
                            width: 153
                            height: 37

                            Button {
                                name: "TradeRecipientItem6ItemButton"
                                wowParent: "TradeRecipientItem6"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                width: 37
                                height: 37
                            }

                            Frame {
                                name: "TradeRecipientItem7"
                                wowParent: "TradeFrame"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 28
                                width: 153
                                height: 37

                                Button {
                                    name: "TradeRecipientItem7ItemButton"
                                    wowParent: "TradeRecipientItem7"
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    width: 37
                                    height: 37
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Frame {
        name: "TradeRecipientMoneyFrame"
        wowParent: "TradeFrame"
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 78
        width: 13
        height: 13
    }

    Ghost {
        name: "TradePlayerItem1NameFrame"
        x: 57
        y: 123
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

    Ghost {
        name: "TradePlayerItem2NameFrame"
        x: 57
        y: 167
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

    Ghost {
        name: "TradePlayerItem3NameFrame"
        x: 57
        y: 211
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

    Ghost {
        name: "TradePlayerItem4NameFrame"
        x: 57
        y: 255
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

    Ghost {
        name: "TradePlayerItem5NameFrame"
        x: 57
        y: 299
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

    Ghost {
        name: "TradePlayerItem6NameFrame"
        x: 57
        y: 343
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

    Ghost {
        name: "TradePlayerItem7NameFrame"
        x: 57
        y: 408
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

    Ghost {
        name: "TradeRecipientItem1NameFrame"
        x: 226
        y: 123
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

    Ghost {
        name: "TradeRecipientItem2NameFrame"
        x: 226
        y: 167
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

    Ghost {
        name: "TradeRecipientItem3NameFrame"
        x: 226
        y: 211
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

    Ghost {
        name: "TradeRecipientItem4NameFrame"
        x: 226
        y: 255
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

    Ghost {
        name: "TradeRecipientItem5NameFrame"
        x: 226
        y: 299
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

    Ghost {
        name: "TradeRecipientItem6NameFrame"
        x: 226
        y: 343
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

    Ghost {
        name: "TradeRecipientItem7NameFrame"
        x: 226
        y: 408
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
