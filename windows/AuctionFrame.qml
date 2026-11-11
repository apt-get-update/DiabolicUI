// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "AuctionFrame"
    width: 832
    height: 447

    Button {
        name: "Atr_AddToSListButton"
        text: "Add Item"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 123
        width: 93.1
        height: 20

        FontString {
            name: "Atr_AddToSListButtonText"
            text: "Add Item"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 48.8
            height: 10.1
        }
    }

    Frame {
        name: "Atr_Main_Panel"
        anchors.left: parent.left
        anchors.leftMargin: 210
        anchors.top: parent.top
        width: 548
        height: 447

        FontString {
            name: "Atr_ActiveItems_Text"
            text: "Active Items"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -350
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 64.6
            height: 10.1
        }

        Button {
            name: "Atr_CheckActiveButton"
            text: "Check for Undercuts"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: -210
            anchors.top: parent.top
            anchors.topMargin: 388
            width: 165
            height: 20

            FontString {
                name: "Atr_CheckActiveButtonText"
                text: "Check for Undercuts"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 110.6
                height: 10.1
            }
        }

        Frame {
            id: atr_HeadingsBar
            name: "Atr_HeadingsBar"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.top: parent.top
            anchors.topMargin: 138
            width: 605
            height: 64

            Ghost {
                name: "Atr_HeadingsBarMiddle"
                x: 0
                y: 32
                width: 0
                height: 0

                FontString {
                    name: "Atr_Col1_Heading"
                    text: "Item Price"
                    wowParent: "Atr_HeadingsBar"
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 100
                    height: 10.1
                }

                FontString {
                    name: "Atr_Col3_Heading"
                    text: "Current Auctions"
                    wowParent: "Atr_HeadingsBar"
                    anchors.left: parent.left
                    anchors.leftMargin: 205
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 86.2
                    height: 10.1
                }

                FontString {
                    name: "Atr_Col4_Heading"
                    text: "Stack Price"
                    wowParent: "Atr_HeadingsBar"
                    anchors.left: parent.left
                    anchors.leftMargin: 500
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 56
                    height: 10.1
                }
            }
        }

        Frame {
            name: "Atr_Hlist"
            anchors.left: parent.left
            anchors.leftMargin: -208
            anchors.top: parent.top
            anchors.topMargin: 50
            width: 170
            height: 335

            Button {
                name: "AuctionatorHEntry1"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 5
                width: 174
                height: 16

                FontString {
                    name: "AuctionatorHEntry1_EntryText"
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 174
                    height: 16
                }
            }
        }

        ScrollFrame {
            name: "Atr_Hlist_ScrollFrame"
            anchors.left: parent.left
            anchors.leftMargin: -208
            anchors.top: parent.top
            anchors.topMargin: 50
            width: 170
            height: 252

            Slider {
                name: "Atr_Hlist_ScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 220

                Frame {
                    name: "Atr_Hlist_ScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: atr_Hlist_ScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 254
                }

                Button {
                    name: "Atr_Hlist_ScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: atr_Hlist_ScrollFrameScrollBarScrollUpButton
                    name: "Atr_Hlist_ScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "Atr_Hlist_ScrollFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 800
            }
        }

        Frame {
            name: "Atr_ListTabs"
            anchors.right: atr_HeadingsBar.right
            anchors.bottom: atr_HeadingsBar.top
            anchors.bottomMargin: -22
            width: 250
            height: 40

            Button {
                name: "Atr_ListTabsTab1"
                text: "Current"
                style: "Tab"
                anchors.right: atr_ListTabsTab2.left
                anchors.rightMargin: 2
                anchors.verticalCenter: atr_ListTabsTab2.verticalCenter
                width: 70.4
                height: 32

                FontString {
                    name: "Atr_ListTabsTab1Text"
                    text: "Current"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 53.2
                    height: 13
                }
            }

            Button {
                id: atr_ListTabsTab2
                name: "Atr_ListTabsTab2"
                text: "History"
                style: "Tab"
                anchors.right: atr_ListTabsTab3.left
                anchors.rightMargin: 2
                anchors.verticalCenter: atr_ListTabsTab3.verticalCenter
                width: 69
                height: 32

                FontString {
                    name: "Atr_ListTabsTab2Text"
                    text: "History"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 50.3
                    height: 13
                }
            }

            Button {
                id: atr_ListTabsTab3
                name: "Atr_ListTabsTab3"
                text: "Other"
                style: "Tab"
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.bottom: parent.bottom
                width: 61.9
                height: 32

                FontString {
                    name: "Atr_ListTabsTab3Text"
                    text: "Other"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 38.8
                    height: 13
                }
            }
        }

        Button {
            name: "Atr_MngSListsButton"
            text: "Manage Shopping Lists"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: -210
            anchors.top: parent.top
            anchors.topMargin: 344
            width: 195
            height: 20

            FontString {
                name: "Atr_MngSListsButtonText"
                text: "Manage Shopping Lists"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 123.5
                height: 10.1
            }
        }

        Button {
            name: "Atr_NewSListButton"
            text: "New Shopping List"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: -210
            anchors.top: parent.top
            anchors.topMargin: 364
            width: 195
            height: 20

            FontString {
                name: "Atr_NewSListButtonText"
                text: "New Shopping List"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 98.4
                height: 10.1
            }
        }

        Button {
            name: "Atr_RecommendItem_Tex"
            anchors.left: parent.left
            anchors.leftMargin: 34
            anchors.top: parent.top
            anchors.topMargin: 62
            width: 37
            height: 37

            FontString {
                name: "Atr_RecommendItem_TexCount"
                text: "2"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 9.4
                height: 13.6
            }
        }

        Frame {
            name: "Atr_RecommendPerItem_Price"
            wowParent: "?"
            anchors.left: parent.left
            anchors.leftMargin: 131.7
            anchors.top: parent.top
            anchors.topMargin: 121
            width: 107.3
            height: 16

            Button {
                id: atr_RecommendPerItem_PriceCopperButton
                name: "Atr_RecommendPerItem_PriceCopperButton"
                text: "0"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "Atr_RecommendPerItem_PriceCopperButtonText"
                    text: "0"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }
            }

            Button {
                name: "Atr_RecommendPerItem_PriceGoldButton"
                text: "4"
                anchors.right: atr_RecommendPerItem_PriceSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: atr_RecommendPerItem_PriceSilverButton.verticalCenter
                width: 22.3
                height: 13

                FontString {
                    name: "Atr_RecommendPerItem_PriceGoldButtonText"
                    text: "4"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }
            }

            Button {
                id: atr_RecommendPerItem_PriceSilverButton
                name: "Atr_RecommendPerItem_PriceSilverButton"
                text: "94"
                anchors.right: atr_RecommendPerItem_PriceCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: atr_RecommendPerItem_PriceCopperButton.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "Atr_RecommendPerItem_PriceSilverButtonText"
                    text: "94"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 15.8
                    height: 13.6
                }
            }
        }

        FontString {
            name: "Atr_RecommendPerItem_Text"
            text: "per item"
            anchors.left: atr_Recommend_Text.left
            anchors.leftMargin: 152
            anchors.top: atr_Recommend_Text.top
            anchors.topMargin: 51
            width: 43.1
            height: 10.1
        }

        Frame {
            name: "Atr_RecommendPerStack_Price"
            wowParent: "?"
            anchors.left: parent.left
            anchors.leftMargin: 131.7
            anchors.top: parent.top
            anchors.topMargin: 99
            width: 107.3
            height: 16

            Button {
                id: atr_RecommendPerStack_PriceCopperButton
                name: "Atr_RecommendPerStack_PriceCopperButton"
                text: "0"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "Atr_RecommendPerStack_PriceCopperButtonText"
                    text: "0"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }
            }

            Button {
                name: "Atr_RecommendPerStack_PriceGoldButton"
                text: "9"
                anchors.right: atr_RecommendPerStack_PriceSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: atr_RecommendPerStack_PriceSilverButton.verticalCenter
                width: 22.3
                height: 13

                FontString {
                    name: "Atr_RecommendPerStack_PriceGoldButtonText"
                    text: "9"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }
            }

            Button {
                id: atr_RecommendPerStack_PriceSilverButton
                name: "Atr_RecommendPerStack_PriceSilverButton"
                text: "88"
                anchors.right: atr_RecommendPerStack_PriceCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: atr_RecommendPerStack_PriceCopperButton.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "Atr_RecommendPerStack_PriceSilverButtonText"
                    text: "88"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 15.8
                    height: 13.6
                }
            }
        }

        FontString {
            name: "Atr_RecommendPerStack_Text"
            text: "for your stack of 2"
            anchors.left: atr_Recommend_Text.left
            anchors.leftMargin: 152
            anchors.top: atr_Recommend_Text.top
            anchors.topMargin: 28
            width: 91.2
            height: 10.1
        }

        FontString {
            name: "Atr_Recommend_Basis_Text"
            text: "(based on cheapest current auction)"
            anchors.left: atr_Recommend_Text.right
            anchors.leftMargin: 20
            anchors.verticalCenter: atr_Recommend_Text.verticalCenter
            anchors.verticalCenterOffset: 2
            width: 181.7
            height: 10.1
        }

        FontString {
            id: atr_Recommend_Text
            name: "Atr_Recommend_Text"
            anchors.left: parent.left
            anchors.leftMargin: 87
            anchors.top: parent.top
            anchors.topMargin: 73
            width: 1
            height: 1
        }

        Frame {
            name: "Atr_SellControls"
            anchors.left: parent.left
            anchors.leftMargin: -205
            anchors.top: parent.top
            anchors.topMargin: 47
            width: 190
            height: 338

            FontString {
                name: "Atr_Batch_MaxAuctions_Text"
                text: "max: 0"
                anchors.left: atr_Batch_Stacksize_Text.left
                anchors.leftMargin: -34
                anchors.top: atr_Batch_Stacksize_Text.top
                anchors.topMargin: 21
                width: 34.5
                height: 10.1
            }

            FontString {
                name: "Atr_Batch_MaxStacksize_Text"
                text: "max: 0"
                anchors.left: atr_Batch_Stacksize_Text.left
                anchors.leftMargin: 79
                anchors.top: atr_Batch_Stacksize_Text.top
                anchors.topMargin: 21
                width: 34.5
                height: 10.1
            }

            EditBox {
                name: "Atr_Batch_NumAuctions"
                text: "0"
                anchors.left: atr_Batch_Stacksize_Text.left
                anchors.leftMargin: -37
                anchors.top: atr_Batch_Stacksize_Text.top
                width: 40
                height: 20
            }

            EditBox {
                name: "Atr_Batch_Stacksize"
                text: "0"
                anchors.left: atr_Batch_Stacksize_Text.left
                anchors.leftMargin: 84
                anchors.top: atr_Batch_Stacksize_Text.top
                width: 40
                height: 20
            }

            FontString {
                id: atr_Batch_Stacksize_Text
                name: "Atr_Batch_Stacksize_Text"
                text: "stack of"
                anchors.left: parent.left
                anchors.leftMargin: 55
                anchors.top: parent.top
                anchors.topMargin: 224
                width: 82
                height: 22
            }

            Button {
                name: "Atr_CreateAuctionButton"
                text: "Create Auction"
                style: "Button"
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top: parent.top
                anchors.topMargin: 170
                width: 185
                height: 30

                FontString {
                    name: "Atr_CreateAuctionButtonText"
                    text: "Create Auction"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 81.2
                    height: 10.1
                }
            }

            FontString {
                name: "Atr_Deposit_Text"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 345
                width: 1
                height: 1
            }

            Frame {
                name: "Atr_Duration"
                style: "DropDown"
                anchors.left: atr_Duration_Text.left
                anchors.leftMargin: 32
                anchors.top: atr_Duration_Text.top
                anchors.topMargin: -7
                width: 145
                height: 32

                Frame {
                    name: "Atr_DurationDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 145
                    height: 22

                    Button {
                        name: "Atr_DurationButton"
                        wowParent: "Atr_Duration"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Atr_DurationText"
                        text: "48 Hours"
                        wowParent: "Atr_Duration"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 83
                        height: 10
                    }
                }
            }

            FontString {
                id: atr_Duration_Text
                name: "Atr_Duration_Text"
                text: "Duration"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 304
                width: 43.8
                height: 10.1
            }

            Frame {
                name: "Atr_ItemPrice"
                anchors.left: atr_ItemPriceText.left
                anchors.leftMargin: 8
                anchors.top: atr_ItemPriceText.bottom
                anchors.topMargin: 2
                width: 176
                height: 18

                EditBox {
                    name: "Atr_ItemPriceCopper"
                    text: "0"
                    anchors.left: atr_ItemPriceSilver.right
                    anchors.leftMargin: 16
                    anchors.verticalCenter: atr_ItemPriceSilver.verticalCenter
                    width: 30
                    height: 20
                }

                EditBox {
                    id: atr_ItemPriceGold
                    name: "Atr_ItemPriceGold"
                    text: "4"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20
                }

                EditBox {
                    id: atr_ItemPriceSilver
                    name: "Atr_ItemPriceSilver"
                    text: "94"
                    anchors.left: atr_ItemPriceGold.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: atr_ItemPriceGold.verticalCenter
                    width: 30
                    height: 20
                }
            }

            FontString {
                id: atr_ItemPriceText
                name: "Atr_ItemPriceText"
                text: "Per Item"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 128
                width: 43.8
                height: 10.1
            }

            FontString {
                name: "Atr_ItemsOwned_Text"
                text: "Items owned: 0"
                anchors.horizontalCenter: atr_Batch_Stacksize_Text.horizontalCenter
                anchors.verticalCenter: atr_Batch_Stacksize_Text.verticalCenter
                anchors.verticalCenterOffset: -22
                width: 79
                height: 10.1
            }

            Button {
                name: "Atr_SellControls_Tex"
                anchors.left: parent.left
                anchors.leftMargin: 11
                anchors.top: parent.top
                anchors.topMargin: 23
                width: 37
                height: 37

                FontString {
                    name: "Atr_SellControls_TexCount"
                    text: "2"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 9.4
                    height: 13.6
                }

                FontString {
                    name: "Atr_SellControls_TexName"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    width: 124
                    height: 30
                }
            }

            Frame {
                name: "Atr_StackPrice"
                anchors.left: atr_StackPriceText.left
                anchors.leftMargin: 8
                anchors.top: atr_StackPriceText.bottom
                anchors.topMargin: 2
                width: 176
                height: 18

                EditBox {
                    name: "Atr_StackPriceCopper"
                    text: "0"
                    anchors.left: atr_StackPriceSilver.right
                    anchors.leftMargin: 16
                    anchors.verticalCenter: atr_StackPriceSilver.verticalCenter
                    width: 30
                    height: 20
                }

                EditBox {
                    id: atr_StackPriceGold
                    name: "Atr_StackPriceGold"
                    text: "0"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20
                }

                EditBox {
                    id: atr_StackPriceSilver
                    name: "Atr_StackPriceSilver"
                    text: "0"
                    anchors.left: atr_StackPriceGold.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: atr_StackPriceGold.verticalCenter
                    width: 30
                    height: 20
                }
            }

            FontString {
                id: atr_StackPriceText
                name: "Atr_StackPriceText"
                text: "Buyout Price"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 82
                width: 63.9
                height: 10.1
            }

            FontString {
                name: "Atr_StartingPriceDiscountText"
                text: "Starting Price Discount:  5%"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 270
                width: 137.9
                height: 10.1
            }
        }

        Button {
            name: "Atr_SrchSListButton"
            text: "Search for All Items"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: -210
            anchors.top: parent.top
            anchors.topMargin: 324
            width: 195
            height: 20

            FontString {
                name: "Atr_SrchSListButtonText"
                text: "Search for All Items"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 107
                height: 10.1
            }
        }

        FontString {
            name: "AuctionatorMessage2Frame"
            text: "Drag an item you want to sell to this area."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 18
            anchors.top: parent.top
            anchors.topMargin: 65
            width: 252.1
            height: 100
        }

        ScrollFrame {
            name: "AuctionatorScrollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 188
            width: 588
            height: 196

            Button {
                name: "AuctionatorEntry1"
                wowParent: "Atr_Main_Panel"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                width: 584
                height: 16

                FontString {
                    name: "AuctionatorEntry1_EntryText"
                    text: "1 stack of 2 (yours)"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 205
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 95.5
                    height: 10.1
                }

                Frame {
                    name: "AuctionatorEntry1_PerItem_Price"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 34.7
                    anchors.top: parent.top
                    anchors.topMargin: 1.5
                    width: 107.3
                    height: 13

                    Button {
                        id: auctionatorEntry1_PerItem_PriceCopperButton
                        name: "AuctionatorEntry1_PerItem_PriceCopperButton"
                        text: "0"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "AuctionatorEntry1_PerItem_PriceCopperButtonText"
                            text: "0"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    Button {
                        name: "AuctionatorEntry1_PerItem_PriceGoldButton"
                        text: "4"
                        anchors.right: auctionatorEntry1_PerItem_PriceSilverButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceSilverButton.verticalCenter
                        width: 22.3
                        height: 13

                        FontString {
                            name: "AuctionatorEntry1_PerItem_PriceGoldButtonText"
                            text: "4"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    Button {
                        id: auctionatorEntry1_PerItem_PriceSilverButton
                        name: "AuctionatorEntry1_PerItem_PriceSilverButton"
                        text: "94"
                        anchors.right: auctionatorEntry1_PerItem_PriceCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceCopperButton.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "AuctionatorEntry1_PerItem_PriceSilverButtonText"
                            text: "94"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 15.8
                            height: 13.6
                        }
                    }
                }

                FontString {
                    name: "AuctionatorEntry1_PerItem_Text"
                    text: "no buyout price"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 46.3
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    width: 79.7
                    height: 10.1
                }

                FontString {
                    name: "AuctionatorEntry1_StackPrice"
                    text: "9g 88s 00c"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 503.3
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 56.7
                    height: 10.1
                }
            }

            Slider {
                name: "AuctionatorScrollFrameScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 164

                Frame {
                    name: "AuctionatorScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: auctionatorScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: auctionatorScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 198
                }

                Button {
                    name: "AuctionatorScrollFrameScrollBarScrollDownButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: auctionatorScrollFrameScrollBarScrollUpButton
                    name: "AuctionatorScrollFrameScrollBarScrollUpButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "AuctionatorScrollFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 512
            }
        }

        FontString {
            name: "AuctionatorTitle"
            text: "Auctionator+ - More..."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -90
            anchors.top: parent.top
            anchors.topMargin: -7
            width: 135.7
            height: 12.2
        }

        Ghost {
            name: "Atr_Hilite1"
            x: 624
            y: 45
            width: 0
            height: 0

            Button {
                name: "Atr_Hilite1_btn"
                wowParent: "Atr_Main_Panel"
                anchors.right: parent.right
                anchors.top: parent.top
                width: 805
                height: 341
            }
        }
    }

    // Auctionator's left column (its parts: auction.lua)
    Frame {
        name: "Atr_Main_PanelDiabolicLeft"
        wowParent: "Atr_Main_Panel"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: -8
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 212
        height: 367

        Frame {
            name: "Atr_Main_PanelDiabolicLeftDiabolicZone"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 212
            height: 367
        }
    }

    // Auctionator's results, right of it
    Frame {
        name: "Atr_Main_PanelDiabolicRight"
        wowParent: "Atr_Main_Panel"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 212
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 628
        height: 367

        Frame {
            name: "Atr_Main_PanelDiabolicRightDiabolicZone"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 628
            height: 367
        }
    }

    Button {
        name: "Atr_RemFromSListButton"
        text: "Remove Item"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: parent.left
        anchors.leftMargin: 99.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 123
        width: 96.9
        height: 20

        FontString {
            name: "Atr_RemFromSListButtonText"
            text: "Remove Item"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 71.1
            height: 10.1
        }
    }

    Frame {
        name: "AuctionFrameAuctions"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 758
        height: 447

        Frame {
            name: "AuctionsDepositMoneyFrame"
            anchors.left: auctionsDepositText.right
            anchors.leftMargin: 5
            anchors.verticalCenter: auctionsDepositText.verticalCenter
            anchors.verticalCenterOffset: 1
            width: 13
            height: 13

            Ghost {
                name: "AuctionsDepositMoneyFrameCopperButton"
                x: 63.2
                y: 3.7
                width: 0
                height: 0

                Button {
                    name: "AuctionsDepositMoneyFrameGoldButton"
                    text: "1"
                    wowParent: "AuctionsDepositMoneyFrame"
                    anchors.right: auctionsDepositMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: auctionsDepositMoneyFrameSilverButton.verticalCenter
                    width: 20.9
                    height: 13

                    FontString {
                        name: "AuctionsDepositMoneyFrameGoldButtonText"
                        text: "1"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 7.9
                        height: 13.6
                    }
                }

                Button {
                    id: auctionsDepositMoneyFrameSilverButton
                    name: "AuctionsDepositMoneyFrameSilverButton"
                    text: "65"
                    wowParent: "AuctionsDepositMoneyFrame"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 29.5
                    height: 13

                    FontString {
                        name: "AuctionsDepositMoneyFrameSilverButtonText"
                        text: "65"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 16.5
                        height: 13.6
                    }
                }
            }
        }

        FontString {
            id: auctionsDepositText
            name: "AuctionsDepositText"
            text: "Deposit:"
            anchors.left: parent.left
            anchors.leftMargin: 1
            anchors.verticalCenter: parent.bottom
            anchors.verticalCenterOffset: -77
            width: 50.3
            height: 12.2
        }

        Button {
            name: "AuctionsItemButton"
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 92
            width: 37
            height: 37

            FontString {
                name: "AuctionsItemButtonCount"
                text: "100"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 22.3
                height: 13.6
            }

            FontString {
                name: "AuctionsItemButtonName"
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.top: parent.top
                width: 124
                height: 30
            }
        }

        FontString {
            name: "AuctionsItemText"
            text: "Auction Item"
            anchors.left: parent.left
            anchors.leftMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 78
            width: 66.8
            height: 10.1
        }

        EditBox {
            id: auctionsNumStacksEntry
            name: "AuctionsNumStacksEntry"
            text: "1"
            anchors.left: auctionsStackSizeEntry.left
            anchors.top: auctionsStackSizeEntry.bottom
            anchors.topMargin: 15
            width: 50
            height: 20
        }

        Button {
            name: "AuctionsNumStacksMaxButton"
            text: "Maximum"
            anchors.left: auctionsNumStacksEntry.right
            anchors.leftMargin: 5
            anchors.verticalCenter: auctionsNumStacksEntry.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 100
            height: 21

            FontString {
                name: "AuctionsNumStacksMaxButtonText"
                text: "Maximum"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 53.9
                height: 10.1
            }
        }

        EditBox {
            id: auctionsStackSizeEntry
            name: "AuctionsStackSizeEntry"
            text: "20"
            anchors.left: parent.left
            anchors.leftMargin: 17
            anchors.top: parent.top
            anchors.topMargin: 145
            width: 50
            height: 20
        }

        Button {
            name: "AuctionsStackSizeMaxButton"
            text: "Maximum"
            anchors.left: auctionsStackSizeEntry.right
            anchors.leftMargin: 5
            anchors.verticalCenter: auctionsStackSizeEntry.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 100
            height: 21

            FontString {
                name: "AuctionsStackSizeMaxButtonText"
                text: "Maximum"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 53.9
                height: 10.1
            }
        }

        FontString {
            name: "AuctionsTabText"
            text: "Create Auction"
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 97
            anchors.top: parent.top
            anchors.topMargin: 53
            width: 76.2
            height: 10.1
        }

        FontString {
            name: "AuctionsTitle"
            text: "Padirac's Auctions"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 114.2
            height: 12.2
        }

        Frame {
            name: "BuyoutPrice"
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 127
            width: 176
            height: 18

            FontString {
                name: "AuctionsBuyoutText"
                anchors.left: parent.left
                anchors.leftMargin: -10
                anchors.bottom: parent.top
                anchors.bottomMargin: 3
                width: 114.9
                height: 10.1
            }

            EditBox {
                name: "BuyoutPriceCopper"
                anchors.left: buyoutPriceSilver.right
                anchors.leftMargin: 16
                anchors.verticalCenter: buyoutPriceSilver.verticalCenter
                width: 30
                height: 20
            }

            EditBox {
                id: buyoutPriceGold
                name: "BuyoutPriceGold"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 58
                height: 20
            }

            EditBox {
                id: buyoutPriceSilver
                name: "BuyoutPriceSilver"
                anchors.left: buyoutPriceGold.right
                anchors.leftMargin: 26
                anchors.verticalCenter: buyoutPriceGold.verticalCenter
                width: 30
                height: 20
            }
        }

        Frame {
            name: "DurationDropDown"
            style: "DropDown"
            anchors.right: parent.left
            anchors.rightMargin: -193
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 91
            width: 130
            height: 32

            Frame {
                name: "DurationDropDownDiabolicField"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 130
                height: 22

                Button {
                    name: "DurationDropDownButton"
                    wowParent: "DurationDropDown"
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    width: 18
                    height: 18
                }

                FontString {
                    name: "DurationDropDownText"
                    text: "24 Hours"
                    wowParent: "DurationDropDown"
                    anchors.left: parent.left
                    anchors.leftMargin: 22
                    anchors.verticalCenter: parent.verticalCenter
                    width: 68
                    height: 10
                }
            }
        }

        Frame {
            name: "PriceDropDown"
            style: "DropDown"
            anchors.right: parent.left
            anchors.rightMargin: -193
            anchors.top: parent.top
            anchors.topMargin: 213
            width: 130
            height: 32

            Frame {
                name: "PriceDropDownDiabolicField"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 130
                height: 22

                Button {
                    name: "PriceDropDownButton"
                    wowParent: "PriceDropDown"
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    width: 18
                    height: 18
                }

                FontString {
                    name: "PriceDropDownText"
                    text: "per stack"
                    wowParent: "PriceDropDown"
                    anchors.left: parent.left
                    anchors.leftMargin: 22
                    anchors.verticalCenter: parent.verticalCenter
                    width: 68
                    height: 10
                }
            }
        }

        Frame {
            name: "StartPrice"
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 172
            width: 176
            height: 18

            EditBox {
                name: "StartPriceCopper"
                anchors.left: startPriceSilver.right
                anchors.leftMargin: 16
                anchors.verticalCenter: startPriceSilver.verticalCenter
                width: 30
                height: 20
            }

            EditBox {
                id: startPriceGold
                name: "StartPriceGold"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 58
                height: 20
            }

            EditBox {
                id: startPriceSilver
                name: "StartPriceSilver"
                anchors.left: startPriceGold.right
                anchors.leftMargin: 26
                anchors.verticalCenter: startPriceGold.verticalCenter
                width: 30
                height: 20
            }
        }
    }

    // Auctions' results, right of it
    Frame {
        id: auctionFrameAuctionsDiabolicResults
        name: "AuctionFrameAuctionsDiabolicResults"
        wowParent: "AuctionFrameAuctions"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 210
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 630
        height: 367

        Frame {
            name: "AuctionFrameAuctionsDiabolicResultsDiabolicZone"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 630
            height: 367
        }

        Button {
            name: "AuctionsBidSort"
            text: "Current Bid"
            wowParent: "AuctionFrameAuctions"
            anchors.left: auctionsHighBidderSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: auctionsHighBidderSort.verticalCenter
            width: 193
            height: 19

            FontString {
                name: "AuctionsBidSortText"
                text: "Current Bid"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 57.5
                height: 10.1
            }
        }

        Button {
            name: "AuctionsButton1"
            wowParent: "AuctionFrameAuctions"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 25
            width: 576
            height: 37

            Frame {
                name: "AuctionsButton1BuyoutFrame"
                anchors.right: auctionsButton1MoneyFrame.right
                anchors.top: auctionsButton1MoneyFrame.bottom
                anchors.topMargin: 1
                width: 197
                height: 13

                Frame {
                    name: "AuctionsButton1BuyoutFrameMoney"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 107.3
                    height: 13

                    Button {
                        id: auctionsButton1BuyoutFrameMoneyCopperButton
                        name: "AuctionsButton1BuyoutFrameMoneyCopperButton"
                        text: "0"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "AuctionsButton1BuyoutFrameMoneyCopperButtonText"
                            text: "0"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    Button {
                        name: "AuctionsButton1BuyoutFrameMoneyGoldButton"
                        text: "4"
                        anchors.right: auctionsButton1BuyoutFrameMoneySilverButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneySilverButton.verticalCenter
                        width: 22.3
                        height: 13

                        FontString {
                            name: "AuctionsButton1BuyoutFrameMoneyGoldButtonText"
                            text: "4"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    Button {
                        id: auctionsButton1BuyoutFrameMoneySilverButton
                        name: "AuctionsButton1BuyoutFrameMoneySilverButton"
                        text: "96"
                        anchors.right: auctionsButton1BuyoutFrameMoneyCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyCopperButton.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "AuctionsButton1BuyoutFrameMoneySilverButtonText"
                            text: "96"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 15.8
                            height: 13.6
                        }
                    }
                }

                Frame {
                    name: "AuctionsButton1BuyoutFrameText"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 87.6
                    height: 13
                }
            }

            Frame {
                name: "AuctionsButton1ClosingTime"
                anchors.left: parent.left
                anchors.leftMargin: 191
                anchors.top: parent.top
                width: 65
                height: 28

                FontString {
                    name: "AuctionsButton1ClosingTimeText"
                    text: "Very Long"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 65
                    height: 28
                }
            }

            FontString {
                name: "AuctionsButton1HighBidder"
                anchors.left: parent.left
                anchors.leftMargin: 279
                anchors.top: parent.top
                width: 104
                height: 28
            }

            Button {
                name: "AuctionsButton1Item"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 32
                height: 32

                FontString {
                    name: "AuctionsButton1ItemCount"
                    text: "20"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 15.8
                    height: 13.6
                }
            }

            Frame {
                id: auctionsButton1MoneyFrame
                name: "AuctionsButton1MoneyFrame"
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -10
                width: 107.3
                height: 13

                Button {
                    id: auctionsButton1MoneyFrameCopperButton
                    name: "AuctionsButton1MoneyFrameCopperButton"
                    text: "20"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 13

                    FontString {
                        name: "AuctionsButton1MoneyFrameCopperButtonText"
                        text: "20"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 15.8
                        height: 13.6
                    }
                }

                Button {
                    name: "AuctionsButton1MoneyFrameGoldButton"
                    text: "4"
                    anchors.right: auctionsButton1MoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: auctionsButton1MoneyFrameSilverButton.verticalCenter
                    width: 22.3
                    height: 13

                    FontString {
                        name: "AuctionsButton1MoneyFrameGoldButtonText"
                        text: "4"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 9.4
                        height: 13.6
                    }
                }

                Button {
                    id: auctionsButton1MoneyFrameSilverButton
                    name: "AuctionsButton1MoneyFrameSilverButton"
                    text: "71"
                    anchors.right: auctionsButton1MoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: auctionsButton1MoneyFrameCopperButton.verticalCenter
                    width: 32
                    height: 13

                    FontString {
                        name: "AuctionsButton1MoneyFrameSilverButtonText"
                        text: "71"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 14.4
                        height: 13.6
                    }
                }
            }

            FontString {
                name: "AuctionsButton1Name"
                text: "Stylish Blue Shirt"
                anchors.left: parent.left
                anchors.leftMargin: 43
                anchors.top: parent.top
                width: 142
                height: 28
            }
        }

        Button {
            id: auctionsDurationSort
            name: "AuctionsDurationSort"
            text: "Time Left"
            wowParent: "AuctionFrameAuctions"
            anchors.left: auctionsQualitySort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: auctionsQualitySort.verticalCenter
            width: 100
            height: 19

            FontString {
                name: "AuctionsDurationSortText"
                text: "Time Left"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 48.1
                height: 10.1
            }
        }

        Button {
            id: auctionsHighBidderSort
            name: "AuctionsHighBidderSort"
            text: "High Bidder"
            wowParent: "AuctionFrameAuctions"
            anchors.left: auctionsDurationSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: auctionsDurationSort.verticalCenter
            width: 108
            height: 19

            FontString {
                name: "AuctionsHighBidderSortText"
                text: "High Bidder"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 61.1
                height: 10.1
            }
        }

        Button {
            id: auctionsQualitySort
            name: "AuctionsQualitySort"
            text: "Rarity"
            wowParent: "AuctionFrameAuctions"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 4
            width: 185
            height: 19

            FontString {
                name: "AuctionsQualitySortText"
                text: "Rarity"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 29.5
                height: 10.1
            }
        }
    }

    // Auctions' selling column (Blizzard's parts: auction.lua)
    Frame {
        name: "AuctionFrameAuctionsDiabolicSelling"
        wowParent: "AuctionFrameAuctions"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: -8
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 210
        height: 367

        Frame {
            name: "AuctionFrameAuctionsDiabolicSellingDiabolicZone"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 210
            height: 367
        }

        Button {
            name: "AuctionsCreateAuctionButton"
            text: "Create Auction"
            wowParent: "AuctionFrameAuctions"
            style: "Button"
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            width: 191
            height: 20

            FontString {
                name: "AuctionsCreateAuctionButtonText"
                text: "Create Auction"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 81.2
                height: 10.1
            }
        }
    }

    Frame {
        name: "AuctionFrameBid"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 758
        height: 447

        FontString {
            name: "BidTitle"
            text: "Bid"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 20.1
            height: 12.2
        }
    }

    // Bids' results, across the page
    Frame {
        id: auctionFrameBidDiabolicResults
        name: "AuctionFrameBidDiabolicResults"
        wowParent: "AuctionFrameBid"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: -8
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 848
        height: 367

        Frame {
            name: "AuctionFrameBidDiabolicResultsDiabolicZone"
            wowParent: "AuctionFrameBid"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 848
            height: 367
        }

        Button {
            name: "BidBidSort"
            text: "Current Bid"
            wowParent: "AuctionFrameBid"
            anchors.left: bidStatusSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: bidStatusSort.verticalCenter
            width: 169
            height: 19

            FontString {
                name: "BidBidSortText"
                text: "Current Bid"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 57.5
                height: 10.1
            }
        }

        // its rows (shown with bids: a scan without any doesn't see them)
        Button {
            name: "BidButton1"
            wowParent: "AuctionFrameBid"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 27
            anchors.top: parent.top
            anchors.topMargin: 25
            width: 793
            height: 37
        }

        Button {
            id: bidBuyoutSort
            name: "BidBuyoutSort"
            text: "Buyout Price"
            wowParent: "AuctionFrameBid"
            anchors.left: bidDurationSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: bidDurationSort.verticalCenter
            width: 162
            height: 19

            FontString {
                name: "BidBuyoutSortText"
                text: "Buyout Price"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 63.9
                height: 10.1
            }
        }

        Button {
            id: bidDurationSort
            name: "BidDurationSort"
            text: "Time Left"
            wowParent: "AuctionFrameBid"
            anchors.left: bidLevelSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: bidLevelSort.verticalCenter
            width: 79
            height: 19

            FontString {
                name: "BidDurationSortText"
                text: "Time Left"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 48.1
                height: 10.1
            }
        }

        Button {
            id: bidLevelSort
            name: "BidLevelSort"
            text: "Lvl"
            wowParent: "AuctionFrameBid"
            anchors.left: bidQualitySort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: bidQualitySort.verticalCenter
            width: 65
            height: 19

            FontString {
                name: "BidLevelSortText"
                text: "Lvl"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 15.1
                height: 10.1
            }
        }

        Button {
            id: bidQualitySort
            name: "BidQualitySort"
            text: "Rarity"
            wowParent: "AuctionFrameBid"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 65
            anchors.top: parent.top
            anchors.topMargin: 4
            width: 195
            height: 19

            FontString {
                name: "BidQualitySortText"
                text: "Rarity"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 29.5
                height: 10.1
            }
        }

        Button {
            id: bidStatusSort
            name: "BidStatusSort"
            text: "Bid Status"
            wowParent: "AuctionFrameBid"
            anchors.left: bidBuyoutSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: bidBuyoutSort.verticalCenter
            width: 94
            height: 19

            FontString {
                name: "BidStatusSortText"
                text: "Bid Status"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 51
                height: 10.1
            }
        }
    }

    Frame {
        name: "AuctionFrameBrowse"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 758
        height: 447

        FontString {
            name: "BrowseNameText"
            text: "Name"
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.top: parent.top
            anchors.topMargin: 41
            width: 30.9
            height: 10.1
        }

        FontString {
            name: "BrowseTitle"
            text: "Browse Auctions"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 102.7
            height: 12.2
        }
    }

    // Browse's categories, under its toolbar
    Frame {
        id: auctionFrameBrowseDiabolicCategories
        name: "AuctionFrameBrowseDiabolicCategories"
        wowParent: "AuctionFrameBrowse"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: -8
        anchors.top: parent.top
        anchors.topMargin: 78
        width: 178
        height: 335

        Button {
            name: "AuctionFilterButton1"
            text: "Weapon"
            wowParent: "AuctionFrameBrowse"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 4
            width: 156
            height: 20

            FontString {
                name: "AuctionFilterButton1NormalText"
                text: "Weapon"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 115
                height: 8
            }
        }

        Frame {
            name: "AuctionFrameBrowseDiabolicCategoriesDiabolicZone"
            wowParent: "AuctionFrameBrowse"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 178
            height: 335
        }
    }

    // Browse's results, right of the categories
    Frame {
        id: auctionFrameBrowseDiabolicResults
        name: "AuctionFrameBrowseDiabolicResults"
        wowParent: "AuctionFrameBrowse"
        pin: "all"
        anchors.left: parent.left
        anchors.leftMargin: 178
        anchors.top: parent.top
        anchors.topMargin: 78
        width: 662
        height: 335

        Frame {
            name: "AuctionFrameBrowseDiabolicResultsDiabolicZone"
            wowParent: "AuctionFrameBrowse"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 662
            height: 335
        }

        Button {
            name: "BrowseButton1"
            wowParent: "AuctionFrameBrowse"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.top
            anchors.topMargin: 25
            width: 600
            height: 37

            Frame {
                name: "BrowseButton1BuyoutFrame"
                anchors.right: browseButton1MoneyFrame.right
                anchors.top: browseButton1MoneyFrame.bottom
                anchors.topMargin: 1
                width: 185
                height: 13

                Frame {
                    name: "BrowseButton1BuyoutFrameMoney"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 120.3
                    height: 13

                    Button {
                        id: browseButton1BuyoutFrameMoneyCopperButton
                        name: "BrowseButton1BuyoutFrameMoneyCopperButton"
                        text: "0"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "BrowseButton1BuyoutFrameMoneyCopperButtonText"
                            text: "0"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    Button {
                        name: "BrowseButton1BuyoutFrameMoneyGoldButton"
                        text: "249"
                        anchors.right: browseButton1BuyoutFrameMoneySilverButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: browseButton1BuyoutFrameMoneySilverButton.verticalCenter
                        width: 35.3
                        height: 13

                        FontString {
                            name: "BrowseButton1BuyoutFrameMoneyGoldButtonText"
                            text: "249"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 22.3
                            height: 13.6
                        }
                    }

                    Button {
                        id: browseButton1BuyoutFrameMoneySilverButton
                        name: "BrowseButton1BuyoutFrameMoneySilverButton"
                        text: "75"
                        anchors.right: browseButton1BuyoutFrameMoneyCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: browseButton1BuyoutFrameMoneyCopperButton.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "BrowseButton1BuyoutFrameMoneySilverButtonText"
                            text: "75"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 16.5
                            height: 13.6
                        }
                    }
                }

                Frame {
                    name: "BrowseButton1BuyoutFrameText"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 62.7
                    height: 13
                }
            }

            Frame {
                name: "BrowseButton1ClosingTime"
                anchors.left: parent.left
                anchors.leftMargin: 267
                anchors.top: parent.top
                width: 65
                height: 32

                FontString {
                    name: "BrowseButton1ClosingTimeText"
                    text: "Very Long"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 65
                    height: 32
                }
            }

            FontString {
                name: "BrowseButton1HighBidder"
                text: "Kovasky"
                anchors.left: parent.left
                anchors.leftMargin: 345
                anchors.top: parent.top
                width: 78
                height: 32
            }

            Button {
                name: "BrowseButton1Item"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 32
                height: 32

                FontString {
                    name: "BrowseButton1ItemCount"
                    text: "20"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 15.8
                    height: 13.6
                }
            }

            FontString {
                name: "BrowseButton1Level"
                text: "80"
                anchors.left: parent.left
                anchors.leftMargin: 205
                anchors.top: parent.top
                width: 52
                height: 32
            }

            Frame {
                id: browseButton1MoneyFrame
                name: "BrowseButton1MoneyFrame"
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -10
                width: 120.3
                height: 13

                Button {
                    id: browseButton1MoneyFrameCopperButton
                    name: "BrowseButton1MoneyFrameCopperButton"
                    text: "25"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 13

                    FontString {
                        name: "BrowseButton1MoneyFrameCopperButtonText"
                        text: "25"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 16.5
                        height: 13.6
                    }
                }

                Button {
                    name: "BrowseButton1MoneyFrameGoldButton"
                    text: "237"
                    anchors.right: browseButton1MoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: browseButton1MoneyFrameSilverButton.verticalCenter
                    width: 35.3
                    height: 13

                    FontString {
                        name: "BrowseButton1MoneyFrameGoldButtonText"
                        text: "237"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 22.3
                        height: 13.6
                    }
                }

                Button {
                    id: browseButton1MoneyFrameSilverButton
                    name: "BrowseButton1MoneyFrameSilverButton"
                    text: "26"
                    anchors.right: browseButton1MoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: browseButton1MoneyFrameCopperButton.verticalCenter
                    width: 32
                    height: 13

                    FontString {
                        name: "BrowseButton1MoneyFrameSilverButtonText"
                        text: "26"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 15.8
                        height: 13.6
                    }
                }
            }

            FontString {
                name: "BrowseButton1Name"
                text: "Durable Nerubhide Cape"
                anchors.left: parent.left
                anchors.leftMargin: 43
                anchors.top: parent.top
                width: 167
                height: 32
            }
        }

        Button {
            name: "BrowseCurrentBidSort"
            text: "Current Bid"
            wowParent: "AuctionFrameBrowse"
            anchors.left: browseHighBidderSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: browseHighBidderSort.verticalCenter
            width: 184
            height: 19

            FontString {
                name: "BrowseCurrentBidSortText"
                text: "Current Bid"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 57.5
                height: 10.1
            }
        }

        Button {
            id: browseDurationSort
            name: "BrowseDurationSort"
            text: "Time Left"
            wowParent: "AuctionFrameBrowse"
            anchors.left: browseLevelSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: browseLevelSort.verticalCenter
            width: 91
            height: 19

            FontString {
                name: "BrowseDurationSortText"
                text: "Time Left"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 48.1
                height: 10.1
            }
        }

        Button {
            id: browseHighBidderSort
            name: "BrowseHighBidderSort"
            text: "Seller"
            wowParent: "AuctionFrameBrowse"
            anchors.left: browseDurationSort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: browseDurationSort.verticalCenter
            width: 76
            height: 19

            FontString {
                name: "BrowseHighBidderSortText"
                text: "Seller"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 30.2
                height: 10.1
            }
        }

        Button {
            id: browseLevelSort
            name: "BrowseLevelSort"
            text: "Lvl"
            wowParent: "AuctionFrameBrowse"
            anchors.left: browseQualitySort.right
            anchors.leftMargin: -2
            anchors.verticalCenter: browseQualitySort.verticalCenter
            width: 57
            height: 19

            FontString {
                name: "BrowseLevelSortText"
                text: "Lvl"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 15.1
                height: 10.1
            }
        }

        FontString {
            name: "BrowseNoResultsText"
            text: "Choose search criteria and press \"Search\""
            wowParent: "AuctionFrameBrowse"
            pin: "place"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            width: 252.1
            height: 12.2
        }

        Button {
            id: browseQualitySort
            name: "BrowseQualitySort"
            text: "Rarity"
            wowParent: "AuctionFrameBrowse"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 9
            anchors.top: parent.top
            anchors.topMargin: 4
            width: 214
            height: 19

            FontString {
                name: "BrowseQualitySortText"
                text: "Rarity"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 29.5
                height: 10.1
            }
        }
    }

    Frame {
        id: auctionFrameDiabolic
        name: "AuctionFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -56
        width: 880
        height: 545

        Button {
            name: "AuctionFrameCloseButton"
            wowParent: "AuctionFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "AuctionFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 832
            height: 40

            Button {
                name: "Atr_Adv_Search_Button"
                text: "+"
                wowParent: "Atr_Main_Panel"
                style: "Button"
                anchors.left: atr_Search_Button.right
                anchors.leftMargin: 12
                anchors.verticalCenter: atr_Search_Button.verticalCenter
                width: 22
                height: 22

                FontString {
                    name: "Atr_Adv_Search_ButtonText"
                    text: "+"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 6.5
                    height: 10.1
                }
            }

            Frame {
                id: atr_DropDownSL
                name: "Atr_DropDownSL"
                wowParent: "Atr_Main_Panel"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.verticalCenter: parent.verticalCenter
                width: 200
                height: 32

                Frame {
                    name: "Atr_DropDownSLDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 200
                    height: 22

                    Button {
                        name: "Atr_DropDownSLButton"
                        wowParent: "Atr_DropDownSL"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }
                }

                Ghost {
                    name: "Atr_DropDownSLMiddle"
                    x: 100
                    y: 15
                    width: 0
                    height: 0

                    FontString {
                        name: "Atr_DropDownSLText"
                        text: "Recent Searches"
                        wowParent: "Atr_DropDownSL"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -2
                        width: 125
                        height: 10
                    }
                }
            }

            Button {
                name: "Atr_FullScanButton"
                text: "Full Scan..."
                wowParent: "Atr_Main_Panel"
                style: "Button"
                anchors.right: auctionator1Button.left
                anchors.rightMargin: 12
                anchors.verticalCenter: auctionator1Button.verticalCenter
                width: 74
                height: 22

                FontString {
                    name: "Atr_FullScanButtonText"
                    text: "Full Scan..."
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 58.9
                    height: 10.1
                }
            }

            EditBox {
                id: atr_Search_Box
                name: "Atr_Search_Box"
                wowParent: "Atr_Main_Panel"
                style: "EditBox"
                anchors.left: atr_DropDownSL.right
                anchors.leftMargin: 4
                anchors.verticalCenter: atr_DropDownSL.verticalCenter
                width: 260
                height: 20

                Frame {
                    name: "Atr_Search_BoxDiabolicField"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 276
                    height: 22
                }
            }

            Button {
                id: atr_Search_Button
                name: "Atr_Search_Button"
                text: "Search"
                wowParent: "Atr_Main_Panel"
                style: "Button"
                anchors.left: atr_Search_Box.right
                anchors.leftMargin: 20
                anchors.verticalCenter: atr_Search_Box.verticalCenter
                width: 80
                height: 22

                FontString {
                    name: "Atr_Search_ButtonText"
                    text: "Search"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 36.6
                    height: 10.1
                }
            }

            Button {
                id: auctionator1Button
                name: "Auctionator1Button"
                text: "Options"
                wowParent: "Atr_Main_Panel"
                style: "Button"
                anchors.right: parent.right
                anchors.rightMargin: 48
                anchors.verticalCenter: parent.verticalCenter
                width: 70
                height: 22

                FontString {
                    name: "Auctionator1ButtonText"
                    text: "Options"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 43.1
                    height: 10.1
                }
            }

            FontString {
                id: browseLevelText
                name: "BrowseLevelText"
                text: "Level Range"
                wowParent: "AuctionFrameBrowse"
                anchors.left: browseName.right
                anchors.leftMargin: 20
                anchors.verticalCenter: browseName.verticalCenter
                width: 66.8
                height: 13.6
            }

            EditBox {
                name: "BrowseMinLevel"
                wowParent: "AuctionFrameBrowse"
                style: "EditBox"
                anchors.left: browseLevelText.right
                anchors.leftMargin: 20
                anchors.verticalCenter: browseLevelText.verticalCenter
                width: 25
                height: 16

                Frame {
                    id: browseDropDown
                    name: "BrowseDropDown"
                    wowParent: "AuctionFrameBrowse"
                    style: "DropDown"
                    anchors.left: browseMaxLevel.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: browseMaxLevel.verticalCenter
                    width: 165
                    height: 32

                    Frame {
                        name: "BrowseDropDownDiabolicField"
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: 165
                        height: 22

                        Button {
                            name: "BrowseDropDownButton"
                            wowParent: "BrowseDropDown"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.verticalCenter: parent.verticalCenter
                            width: 18
                            height: 18
                        }

                        FontString {
                            name: "BrowseDropDownText"
                            text: "All"
                            wowParent: "BrowseDropDown"
                            anchors.left: parent.left
                            anchors.leftMargin: 22
                            anchors.verticalCenter: parent.verticalCenter
                            width: 103
                            height: 10
                        }
                    }

                    FontString {
                        name: "BrowseDropDownName"
                        text: "Rarity"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.bottom: parent.top
                        width: 29.5
                        height: 10.1
                    }
                }

                FontString {
                    id: browseLevelHyphen
                    name: "BrowseLevelHyphen"
                    text: "-"
                    anchors.left: parent.right
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    width: 5
                    height: 13.6
                }

                EditBox {
                    id: browseMaxLevel
                    name: "BrowseMaxLevel"
                    wowParent: "AuctionFrameBrowse"
                    style: "EditBox"
                    anchors.left: browseLevelHyphen.right
                    anchors.leftMargin: 20
                    anchors.verticalCenter: browseLevelHyphen.verticalCenter
                    width: 25
                    height: 16

                    Frame {
                        name: "BrowseMaxLevelDiabolicField"
                        anchors.left: parent.left
                        anchors.leftMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 41
                        height: 22
                    }
                }

                Frame {
                    name: "BrowseMinLevelDiabolicField"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 41
                    height: 22
                }

                Button {
                    name: "BrowseSearchButton"
                    text: "Search"
                    wowParent: "AuctionFrameBrowse"
                    style: "Button"
                    anchors.left: browseDropDown.right
                    anchors.leftMargin: -4
                    anchors.verticalCenter: browseDropDown.verticalCenter
                    width: 80
                    height: 22

                    FontString {
                        name: "BrowseSearchButtonText"
                        text: "Search"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 36.6
                        height: 10.1
                    }
                }
            }

            EditBox {
                id: browseName
                name: "BrowseName"
                wowParent: "AuctionFrameBrowse"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 140
                height: 16

                Frame {
                    name: "BrowseNameDiabolicField"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 156
                    height: 22
                }
            }
        }

        Frame {
            name: "AuctionFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 880
            height: 513

            Frame {
                name: "AuctionFrameDiabolicTitlePlate"
                wowParent: "AuctionFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "AuctionFrameDiabolicTitle"
                    text: "Auctions"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 79
                    height: 13.6
                }
            }
        }

        Frame {
            id: auctionFrameDiabolicFoot
            name: "AuctionFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 834
            height: 35

            Frame {
                name: "BidBidPrice"
                wowParent: "AuctionFrameBid"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -52
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 11
                width: 176
                height: 18

                EditBox {
                    name: "BidBidPriceCopper"
                    anchors.left: bidBidPriceSilver.right
                    anchors.leftMargin: 16
                    anchors.verticalCenter: bidBidPriceSilver.verticalCenter
                    width: 30
                    height: 20
                }

                EditBox {
                    id: bidBidPriceGold
                    name: "BidBidPriceGold"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20
                }

                EditBox {
                    id: bidBidPriceSilver
                    name: "BidBidPriceSilver"
                    anchors.left: bidBidPriceGold.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: bidBidPriceGold.verticalCenter
                    width: 30
                    height: 20
                }
            }

            FontString {
                name: "BidBidText"
                text: "Bid"
                wowParent: "AuctionFrameBid"
                pin: "place"
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 151.9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 14
                width: 17.3
                height: 10.1
            }

            Frame {
                name: "BrowseBidPrice"
                wowParent: "AuctionFrameBrowse"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -12
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 11
                width: 176
                height: 18

                EditBox {
                    name: "BrowseBidPriceCopper"
                    anchors.left: browseBidPriceSilver.right
                    anchors.leftMargin: 16
                    anchors.verticalCenter: browseBidPriceSilver.verticalCenter
                    width: 30
                    height: 20
                }

                EditBox {
                    id: browseBidPriceGold
                    name: "BrowseBidPriceGold"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20
                }

                EditBox {
                    id: browseBidPriceSilver
                    name: "BrowseBidPriceSilver"
                    anchors.left: browseBidPriceGold.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: browseBidPriceGold.verticalCenter
                    width: 30
                    height: 20
                }

                FontString {
                    name: "BrowseBidText"
                    text: "Bid"
                    anchors.right: parent.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.3
                    height: 10.1
                }
            }

            WowRow {
                name: "BrowseButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 585
                anchors.right: parent.right
                anchors.rightMargin: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "BrowseBidButton"
                    text: "Bid"
                    wowParent: "AuctionFrameBrowse"
                    style: "Button"
                    pin: "all"
                    width: 76
                    height: 22

                    FontString {
                        name: "BrowseBidButtonText"
                        text: "Bid"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.3
                        height: 10.1
                    }
                }

                Button {
                    name: "BrowseBuyoutButton"
                    text: "Buyout"
                    wowParent: "AuctionFrameBrowse"
                    style: "Button"
                    pin: "all"
                    width: 76
                    height: 22

                    FontString {
                        name: "BrowseBuyoutButtonText"
                        text: "Buyout"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 38.8
                        height: 10.1
                    }
                }

                Button {
                    name: "BrowseCloseButton"
                    text: "Close"
                    wowParent: "AuctionFrameBrowse"
                    style: "Button"
                    pin: "all"
                    width: 76
                    height: 22

                    FontString {
                        name: "BrowseCloseButtonText"
                        text: "Close"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28
                        height: 10.1
                    }
                }
            }

            WowRow {
                name: "BidButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 585
                anchors.right: parent.right
                anchors.rightMargin: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "BidBidButton"
                    text: "Bid"
                    wowParent: "AuctionFrameBid"
                    style: "Button"
                    pin: "all"
                    width: 76
                    height: 22

                    FontString {
                        name: "BidBidButtonText"
                        text: "Bid"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.3
                        height: 10.1
                    }
                }

                Button {
                    name: "BidBuyoutButton"
                    text: "Buyout"
                    wowParent: "AuctionFrameBid"
                    style: "Button"
                    pin: "all"
                    width: 76
                    height: 22

                    FontString {
                        name: "BidBuyoutButtonText"
                        text: "Buyout"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 38.8
                        height: 10.1
                    }
                }

                Button {
                    name: "BidCloseButton"
                    text: "Close"
                    wowParent: "AuctionFrameBid"
                    style: "Button"
                    pin: "all"
                    width: 76
                    height: 22

                    FontString {
                        name: "BidCloseButtonText"
                        text: "Close"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28
                        height: 10.1
                    }
                }
            }

            WowRow {
                name: "AuctionsButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 621
                anchors.right: parent.right
                anchors.rightMargin: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "AuctionsCancelAuctionButton"
                    text: "Cancel Auction"
                    wowParent: "AuctionFrameAuctions"
                    style: "Button"
                    pin: "all"
                    width: 121.1
                    height: 22

                    FontString {
                        name: "AuctionsCancelAuctionButtonText"
                        text: "Cancel Auction"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 81.2
                        height: 10.1
                    }
                }

                Button {
                    name: "AuctionsCloseButton"
                    text: "Close"
                    wowParent: "AuctionFrameAuctions"
                    style: "Button"
                    pin: "all"
                    width: 76.9
                    height: 22

                    FontString {
                        name: "AuctionsCloseButtonText"
                        text: "Close"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28
                        height: 10.1
                    }
                }
            }

            WowRow {
                name: "AuctionatorButtons"
                fit: "ends"
                anchors.left: parent.left
                anchors.leftMargin: 548
                anchors.right: parent.right
                anchors.rightMargin: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "Atr_Buy1_Button"
                    text: "Buy"
                    wowParent: "Atr_Main_Panel"
                    style: "Button"
                    pin: "all"
                    width: 84.3
                    height: 22

                    FontString {
                        name: "Atr_Buy1_ButtonText"
                        text: "Buy"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20.1
                        height: 10.1
                    }
                }

                Button {
                    name: "Atr_CancelSelectionButton"
                    text: "Cancel Auctions"
                    wowParent: "Atr_Main_Panel"
                    style: "Button"
                    pin: "all"
                    width: 105.8
                    height: 22

                    FontString {
                        name: "Atr_CancelSelectionButtonText"
                        text: "Cancel Auctions"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 86.9
                        height: 10.1
                    }
                }

                Button {
                    name: "AuctionatorCloseButton"
                    text: "Close"
                    wowParent: "Atr_Main_Panel"
                    style: "Button"
                    pin: "all"
                    width: 74.9
                    height: 22

                    FontString {
                        name: "AuctionatorCloseButtonText"
                        text: "Close"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28
                        height: 10.1
                    }
                }
            }
        }

        Frame {
            name: "AuctionFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 362
            height: 18
        }

        Frame {
            name: "AuctionFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Frame {
            name: "AuctionFrameMoneyFrame"
            wowParent: "AuctionFrame"
            pin: "place"
            anchors.right: auctionFrameDiabolicFoot.left
            anchors.rightMargin: -182
            anchors.bottom: auctionFrameDiabolicFoot.bottom
            anchors.bottomMargin: 13
            width: 121.1
            height: 13

            Button {
                id: auctionFrameMoneyFrameCopperButton
                name: "AuctionFrameMoneyFrameCopperButton"
                text: "75"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 29.5
                height: 13

                FontString {
                    name: "AuctionFrameMoneyFrameCopperButtonText"
                    text: "75"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16.5
                    height: 13.6
                }
            }

            Button {
                name: "AuctionFrameMoneyFrameGoldButton"
                text: "3663"
                anchors.right: auctionFrameMoneyFrameSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: auctionFrameMoneyFrameSilverButton.verticalCenter
                width: 41.7
                height: 13

                FontString {
                    name: "AuctionFrameMoneyFrameGoldButtonText"
                    text: "3663"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 28.7
                    height: 13.6
                }
            }

            Button {
                id: auctionFrameMoneyFrameSilverButton
                name: "AuctionFrameMoneyFrameSilverButton"
                text: "24"
                anchors.right: auctionFrameMoneyFrameCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: auctionFrameMoneyFrameCopperButton.verticalCenter
                width: 28.8
                height: 13

                FontString {
                    name: "AuctionFrameMoneyFrameSilverButtonText"
                    text: "24"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 15.8
                    height: 13.6
                }
            }
        }
    }

    Button {
        name: "AuctionFrameTab1"
        text: "Browse"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AuctionFrameTab2"
        text: "Bids"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AuctionFrameTab3"
        text: "Auctions"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AuctionFrameTab4"
        text: "Buy"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AuctionFrameTab5"
        text: "Sell"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AuctionFrameTab6"
        text: "More..."
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 318
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    ScrollFrame {
        name: "AuctionsScrollFrame"
        wowParent: "AuctionFrameAuctions"
        pin: "all"
        anchors.right: auctionFrameAuctionsDiabolicResults.left
        anchors.rightMargin: -593
        anchors.top: auctionFrameAuctionsDiabolicResults.top
        anchors.topMargin: 25
        width: 435
        height: 338

        Slider {
            name: "AuctionsScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 306

            Frame {
                name: "AuctionsScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: auctionsScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: auctionsScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 340
            }

            Button {
                name: "AuctionsScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: auctionsScrollFrameScrollBarScrollUpButton
                name: "AuctionsScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "AuctionsScrollFrameScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 444
        }
    }

    ScrollFrame {
        name: "BidScrollFrame"
        wowParent: "AuctionFrameBid"
        pin: "all"
        anchors.right: auctionFrameBidDiabolicResults.left
        anchors.rightMargin: -798
        anchors.top: auctionFrameBidDiabolicResults.top
        anchors.topMargin: 25
        width: 625
        height: 338
    }

    ScrollFrame {
        name: "BrowseFilterScrollFrame"
        wowParent: "AuctionFrameBrowse"
        pin: "all"
        anchors.right: auctionFrameBrowseDiabolicCategories.left
        anchors.rightMargin: -146
        anchors.top: auctionFrameBrowseDiabolicCategories.top
        anchors.topMargin: 4
        width: 160
        height: 327

        Slider {
            name: "BrowseFilterScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 295

            Frame {
                name: "BrowseFilterScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: browseFilterScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: browseFilterScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 329
            }

            Button {
                name: "BrowseFilterScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: browseFilterScrollFrameScrollBarScrollUpButton
                name: "BrowseFilterScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "BrowseFilterScrollFrameScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 420
        }
    }

    Button {
        id: browseNextPageButton
        name: "BrowseNextPageButton"
        wowParent: "AuctionFrameBrowse"
        pin: "all"
        anchors.right: auctionFrameBrowseDiabolicResults.right
        anchors.rightMargin: 16
        anchors.verticalCenter: auctionFrameBrowseDiabolicResults.top
        anchors.verticalCenterOffset: -20
        width: 24
        height: 24
    }

    Button {
        name: "BrowsePrevPageButton"
        wowParent: "AuctionFrameBrowse"
        anchors.right: browseNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseNextPageButton.verticalCenter
        width: 24
        height: 24
    }

    Button {
        name: "BrowseResetButton"
        text: "Reset"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        pin: "all"
        anchors.left: auctionFrameBrowseDiabolicCategories.left
        anchors.leftMargin: 10
        anchors.bottom: auctionFrameBrowseDiabolicCategories.top
        anchors.bottomMargin: 8
        width: 156
        height: 24

        FontString {
            name: "BrowseResetButtonText"
            text: "Reset"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30.2
            height: 10.1
        }
    }

    ScrollFrame {
        name: "BrowseScrollFrame"
        wowParent: "AuctionFrameBrowse"
        pin: "all"
        anchors.right: auctionFrameBrowseDiabolicResults.left
        anchors.rightMargin: -620
        anchors.top: auctionFrameBrowseDiabolicResults.top
        anchors.topMargin: 25
        width: 465
        height: 306

        Slider {
            name: "BrowseScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 274

            Frame {
                name: "BrowseScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: browseScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: browseScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 308
            }

            Button {
                name: "BrowseScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: browseScrollFrameScrollBarScrollUpButton
                name: "BrowseScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "BrowseScrollFrameScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 1887
        }
    }

    FontString {
        name: "BrowseSearchCountText"
        text: "Items 1 - 18  ( 118 total )"
        wowParent: "AuctionFrameBrowse"
        pin: "place"
        anchors.left: auctionFrameBrowseDiabolicResults.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFrameBrowseDiabolicResults.top
        anchors.verticalCenterOffset: -20
        width: 121.4
        height: 10.1
    }

    CheckButton {
        name: "IsUsableCheckButton"
        wowParent: "AuctionFrameBrowse"
        style: "CheckBox"
        pin: "place"
        anchors.left: auctionFrameBrowseDiabolicResults.left
        anchors.leftMargin: 182
        anchors.verticalCenter: auctionFrameBrowseDiabolicResults.top
        anchors.verticalCenterOffset: -20
        width: 20
        height: 20

        FontString {
            id: isUsableCheckButtonText
            name: "IsUsableCheckButtonText"
            text: "Usable Items"
            anchors.left: parent.right
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 70.4
            height: 13.6
        }

        CheckButton {
            name: "ShowOnPlayerCheckButton"
            wowParent: "AuctionFrameBrowse"
            style: "CheckBox"
            pin: "place"
            anchors.left: isUsableCheckButtonText.right
            anchors.leftMargin: 16
            anchors.verticalCenter: isUsableCheckButtonText.verticalCenter
            width: 20
            height: 20

            FontString {
                name: "ShowOnPlayerCheckButtonText"
                text: "Display on Character"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 112.1
                height: 13.6
            }
        }
    }

    Ghost {
        name: "BrowseButton2Item"
        x: 196.7
        y: 137.1
        width: 32
        height: 32

        FontString {
            name: "BrowseButton2ItemCount"
            text: "20"
            wowParent: "BrowseButton2Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "BrowseButton3Item"
        x: 196.7
        y: 174.1
        width: 32
        height: 32

        FontString {
            name: "BrowseButton3ItemCount"
            text: "20"
            wowParent: "BrowseButton3Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "BrowseButton4Item"
        x: 196.7
        y: 211.1
        width: 32
        height: 32

        FontString {
            name: "BrowseButton4ItemCount"
            text: "20"
            wowParent: "BrowseButton4Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "BrowseButton5Item"
        x: 196.7
        y: 248.1
        width: 32
        height: 32

        FontString {
            name: "BrowseButton5ItemCount"
            text: "20"
            wowParent: "BrowseButton5Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "BrowseButton6Item"
        x: 196.7
        y: 285.1
        width: 32
        height: 32

        FontString {
            name: "BrowseButton6ItemCount"
            text: "20"
            wowParent: "BrowseButton6Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "BrowseButton7Item"
        x: 196.7
        y: 322.1
        width: 32
        height: 32

        FontString {
            name: "BrowseButton7ItemCount"
            text: "20"
            wowParent: "BrowseButton7Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }
}
