// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "MerchantFrame"
    width: 384
    height: 512

    Frame {
        id: merchantFrameDiabolic
        name: "MerchantFrameDiabolic"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -36
        width: 500
        height: 508

        Button {
            name: "MerchantFrameCloseButton"
            wowParent: "MerchantFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "MerchantFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 500
            height: 476

            Frame {
                name: "MerchantFrameDiabolicTitlePlate"
                wowParent: "MerchantFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "MerchantNameText"
                    text: "Innkeeper Allison"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 161.2
                    height: 14.2
                }
            }
        }

        Frame {
            name: "MerchantFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 454
            height: 65

            Button {
                name: "DiabolicSellJunkButton"
                text: "Sell Junk"
                wowParent: "MerchantFrame"
                style: "Button"
                pin: "place"
                anchors.right: parent.right
                anchors.rightMargin: 9
                anchors.top: parent.top
                anchors.topMargin: 14
                width: 90
                height: 22

                FontString {
                    name: "DiabolicSellJunkButtonText"
                    text: "Sell Junk"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 68
                    height: 11.9
                }
            }

            Frame {
                name: "MerchantBuyBackItem"
                wowParent: "MerchantFrame"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 16.2
                anchors.top: parent.top
                anchors.topMargin: 13.8
                width: 153
                height: 37

                Button {
                    id: merchantBuyBackItemItemButton
                    name: "MerchantBuyBackItemItemButton"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 37.5
                    height: 36.4

                    FontString {
                        name: "MerchantBuyBackItemItemButtonCount"
                        text: "20"
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        width: 17.4
                        height: 14.2
                    }
                }

                FontString {
                    name: "MerchantBuyBackItemName"
                    anchors.left: merchantBuyBackItemItemButton.right
                    anchors.leftMargin: 16
                    anchors.top: merchantBuyBackItemItemButton.top
                    anchors.topMargin: -1
                    width: 150
                    height: 26
                }

                Ghost {
                    name: "MerchantBuyBackItemNameFrame"
                    x: 53.4
                    y: 61.4
                    width: 0
                    height: 0

                    Frame {
                        name: "MerchantBuyBackItemMoneyFrame"
                        wowParent: "MerchantBuyBackItem"
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        width: 69.1
                        height: 13

                        Ghost {
                            name: "MerchantBuyBackItemMoneyFrameCopperButton"
                            x: 56.1
                            y: 6.5
                            width: 0
                            height: 0

                            Button {
                                name: "MerchantBuyBackItemMoneyFrameGoldButton"
                                text: "1"
                                wowParent: "MerchantBuyBackItemMoneyFrame"
                                anchors.right: merchantBuyBackItemMoneyFrameSilverButton.left
                                anchors.rightMargin: 4
                                anchors.verticalCenter: merchantBuyBackItemMoneyFrameSilverButton.verticalCenter
                                width: 21.7
                                height: 13

                                FontString {
                                    name: "MerchantBuyBackItemMoneyFrameGoldButtonText"
                                    text: "1"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 8.7
                                    height: 14.2
                                }
                            }

                            Button {
                                id: merchantBuyBackItemMoneyFrameSilverButton
                                name: "MerchantBuyBackItemMoneyFrameSilverButton"
                                text: "10"
                                wowParent: "MerchantBuyBackItemMoneyFrame"
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: 30.4
                                height: 13

                                FontString {
                                    name: "MerchantBuyBackItemMoneyFrameSilverButtonText"
                                    text: "10"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 17.4
                                    height: 14.2
                                }
                            }
                        }
                    }
                }
            }

            Frame {
                name: "MerchantMoneyFrame"
                wowParent: "MerchantFrame"
                pin: "place"
                anchors.right: parent.right
                anchors.rightMargin: 1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7
                width: 126.4
                height: 13

                Button {
                    id: merchantMoneyFrameCopperButton
                    name: "MerchantMoneyFrameCopperButton"
                    text: "63"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "MerchantMoneyFrameCopperButtonText"
                        text: "63"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }

                Button {
                    name: "MerchantMoneyFrameGoldButton"
                    text: "3653"
                    anchors.right: merchantMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: merchantMoneyFrameSilverButton.verticalCenter
                    width: 44.6
                    height: 13

                    FontString {
                        name: "MerchantMoneyFrameGoldButtonText"
                        text: "3653"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 31.6
                        height: 14.2
                    }
                }

                Button {
                    id: merchantMoneyFrameSilverButton
                    name: "MerchantMoneyFrameSilverButton"
                    text: "55"
                    anchors.right: merchantMoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: merchantMoneyFrameCopperButton.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "MerchantMoneyFrameSilverButtonText"
                        text: "55"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

            Button {
                id: merchantRepairAllButton
                name: "MerchantRepairAllButton"
                wowParent: "MerchantFrame"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 265
                anchors.top: parent.top
                anchors.topMargin: 14
                width: 36
                height: 36
            }

            Button {
                name: "MerchantRepairItemButton"
                wowParent: "MerchantFrame"
                anchors.right: merchantRepairAllButton.left
                anchors.rightMargin: 2
                anchors.verticalCenter: merchantRepairAllButton.verticalCenter
                width: 36
                height: 36
            }
        }

        Frame {
            name: "MerchantFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "MerchantFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Frame {
            name: "MerchantItem1"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 39.3
            anchors.top: parent.top
            anchors.topMargin: 72
            width: 153
            height: 44

            Button {
                id: merchantItem1ItemButton
                name: "MerchantItem1ItemButton"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 38.2
                height: 38.1

                FontString {
                    name: "MerchantItem1ItemButtonCount"
                    text: "5"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 10.3
                    height: 14.2
                }
            }

            FontString {
                name: "MerchantItem1Name"
                text: "Refreshing Spring Water"
                anchors.left: merchantItem1ItemButton.right
                anchors.leftMargin: 16
                anchors.top: merchantItem1ItemButton.top
                anchors.topMargin: -1
                width: 150
                height: 26
            }

            Ghost {
                name: "MerchantItem1NameFrame"
                x: 54.1
                y: 69.1
                width: 0
                height: 0

                Frame {
                    name: "MerchantItem1MoneyFrame"
                    wowParent: "MerchantItem1"
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 31
                    width: 43.4
                    height: 13

                    Button {
                        id: merchantItem1MoneyFrameCopperButton
                        name: "MerchantItem1MoneyFrameCopperButton"
                        text: "20"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30.4
                        height: 13

                        FontString {
                            name: "MerchantItem1MoneyFrameCopperButtonText"
                            text: "20"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 17.4
                            height: 14.2
                        }
                    }

                    Button {
                        name: "MerchantItem1MoneyFrameSilverButton"
                        text: "41"
                        anchors.right: merchantItem1MoneyFrameCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: merchantItem1MoneyFrameCopperButton.verticalCenter
                        width: 28.8
                        height: 13

                        FontString {
                            name: "MerchantItem1MoneyFrameSilverButtonText"
                            text: "41"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 15.8
                            height: 14.2
                        }
                    }
                }
            }
        }

        Frame {
            name: "MerchantItem10"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 257.3
            anchors.top: parent.top
            anchors.topMargin: 280
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem11"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 39.3
            anchors.top: parent.top
            anchors.topMargin: 332
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem12"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 257.3
            anchors.top: parent.top
            anchors.topMargin: 332
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem2"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 257.3
            anchors.top: parent.top
            anchors.topMargin: 72
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem3"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 39.3
            anchors.top: parent.top
            anchors.topMargin: 124
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem4"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 257.3
            anchors.top: parent.top
            anchors.topMargin: 124
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem5"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 39.3
            anchors.top: parent.top
            anchors.topMargin: 176
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem6"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 257.3
            anchors.top: parent.top
            anchors.topMargin: 176
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem7"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 39.3
            anchors.top: parent.top
            anchors.topMargin: 228
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem8"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 257.3
            anchors.top: parent.top
            anchors.topMargin: 228
            width: 153
            height: 44
        }

        Frame {
            name: "MerchantItem9"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 39.3
            anchors.top: parent.top
            anchors.topMargin: 280
            width: 153
            height: 44
        }

        Button {
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
            text: "Page 1 of 3"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 384
            width: 68
            height: 11.9
        }

        Button {
            name: "MerchantPrevPageButton"
            wowParent: "MerchantFrame"
            pin: "place"
            anchors.right: merchantPageText.left
            anchors.rightMargin: 8
            anchors.verticalCenter: merchantPageText.verticalCenter
            width: 26
            height: 26
        }
    }

    Button {
        name: "MerchantFrameTab1"
        text: "Merchant"
        style: "Banner"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "MerchantFrameTab2"
        text: "Buyback"
        style: "Banner"
        anchors.left: merchantFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: merchantFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    FontString {
        name: "MerchantRepairText"
        text: "Repair Items"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 103
        width: 67.2
        height: 10.3
    }

    Ghost {
        name: "MerchantItem3ItemButton"
        x: 39.3
        y: 88
        width: 38.2
        height: 38.1

        FontString {
            name: "MerchantItem3ItemButtonStock"
            text: "(1)"
            wowParent: "MerchantItem3ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 2
            width: 19
            height: 14.2
        }
    }

    Ghost {
        name: "MerchantItem4MoneyFrameSilverButton"
        x: 313.4
        y: 113.1
        width: 30.4
        height: 13

        Button {
            name: "MerchantItem4MoneyFrameGoldButton"
            text: "4"
            wowParent: "MerchantItem4MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 23.3
            height: 13

            FontString {
                name: "MerchantItem4MoneyFrameGoldButtonText"
                text: "4"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 10.3
                height: 14.2
            }
        }
    }

    Ghost {
        name: "MerchantItem5MoneyFrameSilverButton"
        x: 95.4
        y: 165.1
        width: 23.3
        height: 13

        Button {
            name: "MerchantItem5MoneyFrameGoldButton"
            text: "1"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 21.7
            height: 13

            FontString {
                name: "MerchantItem5MoneyFrameGoldButtonText"
                text: "1"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 6
                height: 12
            }
        }
    }

    Ghost {
        name: "MerchantItem6ItemButton"
        x: 257.3
        y: 140
        width: 38.2
        height: 38.1

        FontString {
            name: "MerchantItem6ItemButtonStock"
            text: "(1)"
            wowParent: "MerchantItem6ItemButton"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 2
            width: 19
            height: 14.2
        }
    }

    Ghost {
        name: "MerchantItem6MoneyFrameSilverButton"
        x: 313.4
        y: 165.1
        width: 30.4
        height: 13

        Button {
            name: "MerchantItem6MoneyFrameGoldButton"
            text: "23"
            wowParent: "MerchantItem6MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 30.4
            height: 13

            FontString {
                name: "MerchantItem6MoneyFrameGoldButtonText"
                text: "23"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 17.4
                height: 14.2
            }
        }
    }

    Ghost {
        name: "MerchantItem7MoneyFrameSilverButton"
        x: 95.4
        y: 217.1
        width: 21.7
        height: 13

        Button {
            name: "MerchantItem7MoneyFrameGoldButton"
            text: "1"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 21.7
            height: 13

            FontString {
                name: "MerchantItem7MoneyFrameGoldButtonText"
                text: "1"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 6
                height: 12
            }
        }
    }

    Ghost {
        name: "MerchantItem8MoneyFrameSilverButton"
        x: 313.4
        y: 217.1
        width: 23.3
        height: 13

        Button {
            name: "MerchantItem8MoneyFrameGoldButton"
            text: "2"
            wowParent: "MerchantItem8MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 23.3
            height: 13

            FontString {
                name: "MerchantItem8MoneyFrameGoldButtonText"
                text: "2"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 10.3
                height: 14.2
            }
        }
    }
}
