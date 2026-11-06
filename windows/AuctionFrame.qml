// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
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
            wowParent: "Atr_AddToSListButton"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 48.8
            height: 10.1
        }
    }

    Frame {
        name: "Atr_Main_Panel"
        wowParent: "AuctionFrame"
        anchors.left: parent.left
        anchors.leftMargin: 210
        anchors.top: parent.top
        width: 548
        height: 447

        FontString {
            name: "Atr_ActiveItems_Text"
            text: "Active Items"
            wowParent: "Atr_Main_Panel"
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
            wowParent: "Atr_Main_Panel"
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
                wowParent: "Atr_CheckActiveButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 110.6
                height: 10.1
            }
        }

        Frame {
            name: "Atr_HeadingsBar"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.top: parent.top
            anchors.topMargin: 138
            width: 605
            height: 64

            Frame {
                name: "Atr_ListTabs"
                wowParent: "Atr_Main_Panel"
                anchors.right: parent.right
                anchors.bottom: parent.top
                anchors.bottomMargin: -22
                width: 250
                height: 40

                Button {
                    name: "Atr_ListTabsTab3"
                    text: "Other"
                    wowParent: "Atr_ListTabs"
                    style: "Tab"
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.bottom: parent.bottom
                    width: 61.9
                    height: 32

                    Button {
                        name: "Atr_ListTabsTab2"
                        text: "History"
                        wowParent: "Atr_ListTabs"
                        style: "Tab"
                        anchors.right: parent.left
                        anchors.rightMargin: 2
                        anchors.verticalCenter: parent.verticalCenter
                        width: 69
                        height: 32

                        Button {
                            name: "Atr_ListTabsTab1"
                            text: "Current"
                            wowParent: "Atr_ListTabs"
                            style: "Tab"
                            anchors.right: parent.left
                            anchors.rightMargin: 2
                            anchors.verticalCenter: parent.verticalCenter
                            width: 70.4
                            height: 32

                            FontString {
                                name: "Atr_ListTabsTab1Text"
                                text: "Current"
                                wowParent: "Atr_ListTabsTab1"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -1
                                width: 53.2
                                height: 13
                            }
                        }

                        FontString {
                            name: "Atr_ListTabsTab2Text"
                            text: "History"
                            wowParent: "Atr_ListTabsTab2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -1
                            width: 50.3
                            height: 13
                        }
                    }

                    FontString {
                        name: "Atr_ListTabsTab3Text"
                        text: "Other"
                        wowParent: "Atr_ListTabsTab3"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 38.8
                        height: 13
                    }
                }
            }
        }

        Frame {
            name: "Atr_Hlist"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.leftMargin: -208
            anchors.top: parent.top
            anchors.topMargin: 50
            width: 170
            height: 335

            Button {
                name: "AuctionatorHEntry1"
                wowParent: "Atr_Hlist"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 5
                width: 174
                height: 16

                FontString {
                    name: "AuctionatorHEntry1_EntryText"
                    wowParent: "AuctionatorHEntry1"
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
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.leftMargin: -208
            anchors.top: parent.top
            anchors.topMargin: 50
            width: 170
            height: 252

            Slider {
                name: "Atr_Hlist_ScrollFrameScrollBar"
                wowParent: "Atr_Hlist_ScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 220

                Button {
                    name: "Atr_Hlist_ScrollFrameScrollBarScrollDownButton"
                    wowParent: "Atr_Hlist_ScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "Atr_Hlist_ScrollFrameScrollBarScrollUpButton"
                    wowParent: "Atr_Hlist_ScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "Atr_Hlist_ScrollFrameScrollBarDiabolicTrack"
                        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 254
                    }
                }
            }

            Frame {
                name: "Atr_Hlist_ScrollFrameScrollChildFrame"
                wowParent: "Atr_Hlist_ScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 800
            }
        }

        Button {
            name: "Atr_MngSListsButton"
            text: "Manage Shopping Lists"
            wowParent: "Atr_Main_Panel"
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
                wowParent: "Atr_MngSListsButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 123.5
                height: 10.1
            }
        }

        Button {
            name: "Atr_NewSListButton"
            text: "New Shopping List"
            wowParent: "Atr_Main_Panel"
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
                wowParent: "Atr_NewSListButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 98.4
                height: 10.1
            }
        }

        Button {
            name: "Atr_RecommendItem_Tex"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.leftMargin: 34
            anchors.top: parent.top
            anchors.topMargin: 62
            width: 37
            height: 37
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
                name: "Atr_RecommendPerItem_PriceCopperButton"
                text: "0"
                wowParent: "Atr_RecommendPerItem_Price"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "Atr_RecommendPerItem_PriceCopperButtonText"
                    text: "0"
                    wowParent: "Atr_RecommendPerItem_PriceCopperButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }

                Button {
                    name: "Atr_RecommendPerItem_PriceSilverButton"
                    text: "94"
                    wowParent: "Atr_RecommendPerItem_Price"
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 13

                    Button {
                        name: "Atr_RecommendPerItem_PriceGoldButton"
                        text: "4"
                        wowParent: "Atr_RecommendPerItem_Price"
                        anchors.right: parent.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 22.3
                        height: 13

                        FontString {
                            name: "Atr_RecommendPerItem_PriceGoldButtonText"
                            text: "4"
                            wowParent: "Atr_RecommendPerItem_PriceGoldButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    FontString {
                        name: "Atr_RecommendPerItem_PriceSilverButtonText"
                        text: "94"
                        wowParent: "Atr_RecommendPerItem_PriceSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 15.8
                        height: 13.6
                    }
                }
            }
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
                name: "Atr_RecommendPerStack_PriceCopperButton"
                text: "0"
                wowParent: "Atr_RecommendPerStack_Price"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "Atr_RecommendPerStack_PriceCopperButtonText"
                    text: "0"
                    wowParent: "Atr_RecommendPerStack_PriceCopperButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }

                Button {
                    name: "Atr_RecommendPerStack_PriceSilverButton"
                    text: "94"
                    wowParent: "Atr_RecommendPerStack_Price"
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 13

                    Button {
                        name: "Atr_RecommendPerStack_PriceGoldButton"
                        text: "4"
                        wowParent: "Atr_RecommendPerStack_Price"
                        anchors.right: parent.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 22.3
                        height: 13

                        FontString {
                            name: "Atr_RecommendPerStack_PriceGoldButtonText"
                            text: "4"
                            wowParent: "Atr_RecommendPerStack_PriceGoldButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    FontString {
                        name: "Atr_RecommendPerStack_PriceSilverButtonText"
                        text: "94"
                        wowParent: "Atr_RecommendPerStack_PriceSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 15.8
                        height: 13.6
                    }
                }
            }
        }

        FontString {
            name: "Atr_Recommend_Text"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.leftMargin: 87
            anchors.top: parent.top
            anchors.topMargin: 73
            width: 1
            height: 1

            FontString {
                name: "Atr_RecommendPerItem_Text"
                text: "per item"
                wowParent: "Atr_Main_Panel"
                anchors.left: parent.left
                anchors.leftMargin: 152
                anchors.top: parent.top
                anchors.topMargin: 51
                width: 43.1
                height: 10.1
            }

            FontString {
                name: "Atr_RecommendPerStack_Text"
                text: "for your stack of 1"
                wowParent: "Atr_Main_Panel"
                anchors.left: parent.left
                anchors.leftMargin: 152
                anchors.top: parent.top
                anchors.topMargin: 28
                width: 89.8
                height: 10.1
            }

            FontString {
                name: "Atr_Recommend_Basis_Text"
                text: "(based on selected auction)"
                wowParent: "Atr_Main_Panel"
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 2
                width: 140.1
                height: 10.1
            }
        }

        Frame {
            name: "Atr_SellControls"
            wowParent: "Atr_Main_Panel"
            anchors.left: parent.left
            anchors.leftMargin: -205
            anchors.top: parent.top
            anchors.topMargin: 47
            width: 190
            height: 338

            FontString {
                name: "Atr_Batch_Stacksize_Text"
                text: "stack of"
                wowParent: "Atr_SellControls"
                anchors.left: parent.left
                anchors.leftMargin: 55
                anchors.top: parent.top
                anchors.topMargin: 224
                width: 82
                height: 22

                FontString {
                    name: "Atr_Batch_MaxAuctions_Text"
                    text: "max: 0"
                    wowParent: "Atr_SellControls"
                    anchors.left: parent.left
                    anchors.leftMargin: -34
                    anchors.top: parent.top
                    anchors.topMargin: 21
                    width: 34.5
                    height: 10.1
                }

                FontString {
                    name: "Atr_Batch_MaxStacksize_Text"
                    text: "max: 0"
                    wowParent: "Atr_SellControls"
                    anchors.left: parent.left
                    anchors.leftMargin: 79
                    anchors.top: parent.top
                    anchors.topMargin: 21
                    width: 34.5
                    height: 10.1
                }

                EditBox {
                    name: "Atr_Batch_NumAuctions"
                    text: "0"
                    wowParent: "Atr_SellControls"
                    anchors.left: parent.left
                    anchors.leftMargin: -37
                    anchors.top: parent.top
                    width: 40
                    height: 20
                }

                EditBox {
                    name: "Atr_Batch_Stacksize"
                    text: "0"
                    wowParent: "Atr_SellControls"
                    anchors.left: parent.left
                    anchors.leftMargin: 84
                    anchors.top: parent.top
                    width: 40
                    height: 20
                }

                FontString {
                    name: "Atr_ItemsOwned_Text"
                    text: "Items owned: 0"
                    wowParent: "Atr_SellControls"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -22
                    width: 79
                    height: 10.1
                }
            }

            Button {
                name: "Atr_CreateAuctionButton"
                text: "Create Auction"
                wowParent: "Atr_SellControls"
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
                    wowParent: "Atr_CreateAuctionButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 81.2
                    height: 10.1
                }
            }

            FontString {
                name: "Atr_Deposit_Text"
                wowParent: "Atr_SellControls"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 345
                width: 1
                height: 1
            }

            FontString {
                name: "Atr_Duration_Text"
                text: "Duration"
                wowParent: "Atr_SellControls"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 304
                width: 43.8
                height: 10.1

                Frame {
                    name: "Atr_Duration"
                    wowParent: "Atr_SellControls"
                    style: "DropDown"
                    anchors.left: parent.left
                    anchors.leftMargin: 32
                    anchors.top: parent.top
                    anchors.topMargin: -7
                    width: 145
                    height: 32

                    Frame {
                        name: "Atr_DurationDiabolicField"
                        wowParent: "Atr_Duration"
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
            }

            Button {
                name: "Atr_SellControls_Tex"
                wowParent: "Atr_SellControls"
                anchors.left: parent.left
                anchors.leftMargin: 11
                anchors.top: parent.top
                anchors.topMargin: 23
                width: 37
                height: 37

                FontString {
                    name: "Atr_SellControls_TexName"
                    wowParent: "Atr_SellControls_Tex"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    width: 124
                    height: 30
                }
            }

            FontString {
                name: "Atr_StackPriceText"
                text: "Buyout Price"
                wowParent: "Atr_SellControls"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 82
                width: 63.9
                height: 10.1

                Frame {
                    name: "Atr_StackPrice"
                    wowParent: "Atr_SellControls"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.top: parent.bottom
                    anchors.topMargin: 2
                    width: 176
                    height: 18

                    EditBox {
                        name: "Atr_StackPriceGold"
                        text: "0"
                        wowParent: "Atr_StackPrice"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 58
                        height: 20

                        EditBox {
                            name: "Atr_StackPriceSilver"
                            text: "0"
                            wowParent: "Atr_StackPrice"
                            anchors.left: parent.right
                            anchors.leftMargin: 26
                            anchors.verticalCenter: parent.verticalCenter
                            width: 30
                            height: 20

                            EditBox {
                                name: "Atr_StackPriceCopper"
                                wowParent: "Atr_StackPrice"
                                anchors.left: parent.right
                                anchors.leftMargin: 16
                                anchors.verticalCenter: parent.verticalCenter
                                width: 30
                                height: 20
                            }
                        }
                    }
                }
            }

            FontString {
                name: "Atr_StartingPriceDiscountText"
                text: "Starting Price Discount:  5%"
                wowParent: "Atr_SellControls"
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
            wowParent: "Atr_Main_Panel"
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
                wowParent: "Atr_SrchSListButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 107
                height: 10.1
            }
        }

        FontString {
            name: "AuctionatorMessage2Frame"
            text: "Drag an item you want to sell to this area."
            wowParent: "Atr_Main_Panel"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 18
            anchors.top: parent.top
            anchors.topMargin: 65
            width: 252.1
            height: 100
        }

        ScrollFrame {
            name: "AuctionatorScrollFrame"
            wowParent: "Atr_Main_Panel"
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
                    text: "1 stack of 1 (yours)"
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
                        name: "AuctionatorEntry1_PerItem_PriceCopperButton"
                        text: "0"
                        wowParent: "AuctionatorEntry1_PerItem_Price"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "AuctionatorEntry1_PerItem_PriceCopperButtonText"
                            text: "0"
                            wowParent: "AuctionatorEntry1_PerItem_PriceCopperButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }

                        Button {
                            name: "AuctionatorEntry1_PerItem_PriceSilverButton"
                            text: "94"
                            wowParent: "AuctionatorEntry1_PerItem_Price"
                            anchors.right: parent.left
                            anchors.rightMargin: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 13

                            Button {
                                name: "AuctionatorEntry1_PerItem_PriceGoldButton"
                                text: "4"
                                wowParent: "AuctionatorEntry1_PerItem_Price"
                                anchors.right: parent.left
                                anchors.rightMargin: 4
                                anchors.verticalCenter: parent.verticalCenter
                                width: 22.3
                                height: 13

                                FontString {
                                    name: "AuctionatorEntry1_PerItem_PriceGoldButtonText"
                                    text: "4"
                                    wowParent: "AuctionatorEntry1_PerItem_PriceGoldButton"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 9.4
                                    height: 13.6
                                }
                            }

                            FontString {
                                name: "AuctionatorEntry1_PerItem_PriceSilverButtonText"
                                text: "94"
                                wowParent: "AuctionatorEntry1_PerItem_PriceSilverButton"
                                anchors.right: parent.right
                                anchors.rightMargin: 13
                                anchors.verticalCenter: parent.verticalCenter
                                width: 15.8
                                height: 13.6
                            }
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
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 559
                    anchors.top: parent.top
                    anchors.topMargin: 7.5
                    width: 1
                    height: 1
                }
            }

            Slider {
                name: "AuctionatorScrollFrameScrollBar"
                wowParent: "AuctionatorScrollFrame"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 164

                Button {
                    name: "AuctionatorScrollFrameScrollBarScrollDownButton"
                    wowParent: "AuctionatorScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "AuctionatorScrollFrameScrollBarScrollUpButton"
                    wowParent: "AuctionatorScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "AuctionatorScrollFrameScrollBarDiabolicTrack"
                        wowParent: "AuctionatorScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 198
                    }
                }
            }

            Frame {
                name: "AuctionatorScrollFrameScrollChildFrame"
                wowParent: "AuctionatorScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 512
            }
        }

        FontString {
            name: "AuctionatorTitle"
            text: "Auctionator+ - More..."
            wowParent: "Atr_Main_Panel"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -90
            anchors.top: parent.top
            anchors.topMargin: -7
            width: 135.7
            height: 12.2
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
            wowParent: "Atr_RemFromSListButton"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 71.1
            height: 10.1
        }
    }

    Button {
        name: "AuctionFilterButton1"
        text: "Weapon"
        wowParent: "AuctionFrameBrowse"
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 82
        width: 156
        height: 20

        FontString {
            name: "AuctionFilterButton1NormalText"
            text: "Weapon"
            wowParent: "AuctionFilterButton1"
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 115
            height: 8
        }
    }

    Frame {
        name: "AuctionFrameAuctions"
        wowParent: "AuctionFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 758
        height: 447

        Button {
            name: "AuctionsCreateAuctionButton"
            text: "Create Auction"
            wowParent: "AuctionFrameAuctions"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 41
            width: 191
            height: 20

            FontString {
                name: "AuctionsCreateAuctionButtonText"
                text: "Create Auction"
                wowParent: "AuctionsCreateAuctionButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 81.2
                height: 10.1
            }
        }

        FontString {
            name: "AuctionsDepositText"
            text: "Deposit:"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.leftMargin: 9
            anchors.verticalCenter: parent.bottom
            anchors.verticalCenterOffset: -77
            width: 50.3
            height: 12.2

            Frame {
                name: "AuctionsDepositMoneyFrame"
                wowParent: "AuctionFrameAuctions"
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                width: 13
                height: 13
            }
        }

        Button {
            name: "AuctionsItemButton"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 92
            width: 37
            height: 37

            FontString {
                name: "AuctionsItemButtonCount"
                text: "100"
                wowParent: "AuctionsItemButton"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 22.3
                height: 13.6
            }

            FontString {
                name: "AuctionsItemButtonName"
                wowParent: "AuctionsItemButton"
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
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.leftMargin: 9
            anchors.top: parent.top
            anchors.topMargin: 78
            width: 66.8
            height: 10.1
        }

        EditBox {
            name: "AuctionsStackSizeEntry"
            text: "20"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.leftMargin: 17
            anchors.top: parent.top
            anchors.topMargin: 145
            width: 50
            height: 20

            EditBox {
                name: "AuctionsNumStacksEntry"
                text: "1"
                wowParent: "AuctionFrameAuctions"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 15
                width: 50
                height: 20

                Button {
                    name: "AuctionsNumStacksMaxButton"
                    text: "Maximum"
                    wowParent: "AuctionFrameAuctions"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 100
                    height: 21

                    FontString {
                        name: "AuctionsNumStacksMaxButtonText"
                        text: "Maximum"
                        wowParent: "AuctionsNumStacksMaxButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 53.9
                        height: 10.1
                    }
                }
            }

            Button {
                name: "AuctionsStackSizeMaxButton"
                text: "Maximum"
                wowParent: "AuctionFrameAuctions"
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 100
                height: 21

                FontString {
                    name: "AuctionsStackSizeMaxButtonText"
                    text: "Maximum"
                    wowParent: "AuctionsStackSizeMaxButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 53.9
                    height: 10.1
                }
            }
        }

        FontString {
            name: "AuctionsTabText"
            text: "Create Auction"
            wowParent: "AuctionFrameAuctions"
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 105
            anchors.top: parent.top
            anchors.topMargin: 53
            width: 76.2
            height: 10.1
        }

        FontString {
            name: "AuctionsTitle"
            text: "Padirac's Auctions"
            wowParent: "AuctionFrameAuctions"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 114.2
            height: 12.2
        }

        Frame {
            name: "BuyoutPrice"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.leftMargin: 19
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 127
            width: 176
            height: 18

            FontString {
                name: "AuctionsBuyoutText"
                wowParent: "BuyoutPrice"
                anchors.left: parent.left
                anchors.leftMargin: -10
                anchors.bottom: parent.top
                anchors.bottomMargin: 3
                width: 114.9
                height: 10.1
            }

            EditBox {
                name: "BuyoutPriceGold"
                wowParent: "BuyoutPrice"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 58
                height: 20

                EditBox {
                    name: "BuyoutPriceSilver"
                    wowParent: "BuyoutPrice"
                    anchors.left: parent.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 20

                    EditBox {
                        name: "BuyoutPriceCopper"
                        wowParent: "BuyoutPrice"
                        anchors.left: parent.right
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 20
                    }
                }
            }
        }

        Frame {
            name: "DurationDropDown"
            wowParent: "AuctionFrameAuctions"
            style: "DropDown"
            anchors.right: parent.left
            anchors.rightMargin: -201
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 91
            width: 130
            height: 32

            Frame {
                name: "DurationDropDownDiabolicField"
                wowParent: "DurationDropDown"
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
            wowParent: "AuctionFrameAuctions"
            style: "DropDown"
            anchors.right: parent.left
            anchors.rightMargin: -201
            anchors.top: parent.top
            anchors.topMargin: 213
            width: 130
            height: 32

            Frame {
                name: "PriceDropDownDiabolicField"
                wowParent: "PriceDropDown"
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
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.left
            anchors.leftMargin: 19
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 172
            width: 176
            height: 18

            EditBox {
                name: "StartPriceGold"
                wowParent: "StartPrice"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 58
                height: 20

                EditBox {
                    name: "StartPriceSilver"
                    wowParent: "StartPrice"
                    anchors.left: parent.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 20

                    EditBox {
                        name: "StartPriceCopper"
                        wowParent: "StartPrice"
                        anchors.left: parent.right
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 20
                    }
                }
            }
        }
    }

    Frame {
        name: "AuctionFrameBid"
        wowParent: "AuctionFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 758
        height: 447

        FontString {
            name: "BidTitle"
            text: "Bid"
            wowParent: "AuctionFrameBid"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 20.1
            height: 12.2
        }
    }

    Frame {
        name: "AuctionFrameBrowse"
        wowParent: "AuctionFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 758
        height: 447

        FontString {
            name: "BrowseNameText"
            text: "Name"
            wowParent: "AuctionFrameBrowse"
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.top: parent.top
            anchors.topMargin: 41
            width: 30.9
            height: 10.1
        }

        Button {
            name: "BrowseSearchButton"
            text: "Search"
            wowParent: "AuctionFrameBrowse"
            style: "Button"
            anchors.left: parent.left
            anchors.leftMargin: 676.3
            anchors.top: parent.top
            anchors.topMargin: 9
            width: 80
            height: 22

            FontString {
                name: "BrowseSearchButtonText"
                text: "Search"
                wowParent: "BrowseSearchButton"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 36.6
                height: 10.1
            }
        }

        FontString {
            name: "BrowseTitle"
            text: "Browse Auctions"
            wowParent: "AuctionFrameBrowse"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 102.7
            height: 12.2
        }

        CheckButton {
            name: "IsUsableCheckButton"
            wowParent: "AuctionFrameBrowse"
            style: "CheckBox"
            anchors.left: parent.left
            anchors.leftMargin: 524.8
            anchors.top: parent.top
            anchors.topMargin: 4
            width: 16
            height: 16

            FontString {
                name: "IsUsableCheckButtonText"
                text: "Usable Items"
                wowParent: "IsUsableCheckButton"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 70.4
                height: 13.6
            }
        }

        CheckButton {
            name: "ShowOnPlayerCheckButton"
            wowParent: "AuctionFrameBrowse"
            style: "CheckBox"
            anchors.left: parent.left
            anchors.leftMargin: 524.8
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 16
            height: 16

            FontString {
                name: "ShowOnPlayerCheckButtonText"
                text: "Display on Character"
                wowParent: "ShowOnPlayerCheckButton"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 112.1
                height: 13.6
            }
        }
    }

    Frame {
        name: "AuctionFrameDiabolic"
        wowParent: "AuctionFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -56
        width: 880
        height: 551

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
            wowParent: "AuctionFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 832
            height: 40

            Frame {
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
                    wowParent: "Atr_DropDownSL"
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

                EditBox {
                    name: "Atr_Search_Box"
                    wowParent: "Atr_Main_Panel"
                    style: "EditBox"
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 260
                    height: 20

                    Frame {
                        name: "Atr_Search_BoxDiabolicField"
                        wowParent: "Atr_Search_Box"
                        anchors.left: parent.left
                        anchors.leftMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 276
                        height: 22
                    }

                    Button {
                        name: "Atr_Search_Button"
                        text: "Search"
                        wowParent: "Atr_Main_Panel"
                        style: "Button"
                        anchors.left: parent.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        width: 80
                        height: 22

                        Button {
                            name: "Atr_Adv_Search_Button"
                            text: "+"
                            wowParent: "Atr_Main_Panel"
                            style: "Button"
                            anchors.left: parent.right
                            anchors.leftMargin: 12
                            anchors.verticalCenter: parent.verticalCenter
                            width: 22
                            height: 22

                            FontString {
                                name: "Atr_Adv_Search_ButtonText"
                                text: "+"
                                wowParent: "Atr_Adv_Search_Button"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width: 6.5
                                height: 10.1
                            }
                        }

                        FontString {
                            name: "Atr_Search_ButtonText"
                            text: "Search"
                            wowParent: "Atr_Search_Button"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 36.6
                            height: 10.1
                        }
                    }
                }
            }

            Button {
                name: "Auctionator1Button"
                text: "Options"
                wowParent: "Atr_Main_Panel"
                style: "Button"
                anchors.right: parent.right
                anchors.rightMargin: 48
                anchors.verticalCenter: parent.verticalCenter
                width: 70
                height: 22

                Button {
                    name: "Atr_FullScanButton"
                    text: "Full Scan..."
                    wowParent: "Atr_Main_Panel"
                    style: "Button"
                    anchors.right: parent.left
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    width: 74
                    height: 22

                    FontString {
                        name: "Atr_FullScanButtonText"
                        text: "Full Scan..."
                        wowParent: "Atr_FullScanButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 58.9
                        height: 10.1
                    }
                }

                FontString {
                    name: "Auctionator1ButtonText"
                    text: "Options"
                    wowParent: "Auctionator1Button"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 43.1
                    height: 10.1
                }
            }

            EditBox {
                name: "BrowseName"
                wowParent: "AuctionFrameBrowse"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 140
                height: 16

                FontString {
                    name: "BrowseLevelText"
                    text: "Level Range"
                    wowParent: "AuctionFrameBrowse"
                    anchors.left: parent.right
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    width: 66.8
                    height: 13.6

                    EditBox {
                        name: "BrowseMinLevel"
                        wowParent: "AuctionFrameBrowse"
                        style: "EditBox"
                        anchors.left: parent.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        width: 25
                        height: 16

                        FontString {
                            name: "BrowseLevelHyphen"
                            text: "-"
                            wowParent: "BrowseMinLevel"
                            anchors.left: parent.right
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            width: 5
                            height: 13.6

                            EditBox {
                                name: "BrowseMaxLevel"
                                wowParent: "AuctionFrameBrowse"
                                style: "EditBox"
                                anchors.left: parent.right
                                anchors.leftMargin: 20
                                anchors.verticalCenter: parent.verticalCenter
                                width: 25
                                height: 16

                                Frame {
                                    name: "BrowseDropDown"
                                    wowParent: "AuctionFrameBrowse"
                                    style: "DropDown"
                                    anchors.left: parent.right
                                    anchors.leftMargin: 4
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 165
                                    height: 32

                                    Frame {
                                        name: "BrowseDropDownDiabolicField"
                                        wowParent: "BrowseDropDown"
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
                                        wowParent: "BrowseDropDown"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        anchors.bottom: parent.top
                                        width: 29.5
                                        height: 10.1
                                    }
                                }

                                Frame {
                                    name: "BrowseMaxLevelDiabolicField"
                                    wowParent: "BrowseMaxLevel"
                                    anchors.left: parent.left
                                    anchors.leftMargin: -8
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 41
                                    height: 22
                                }
                            }
                        }

                        Frame {
                            name: "BrowseMinLevelDiabolicField"
                            wowParent: "BrowseMinLevel"
                            anchors.left: parent.left
                            anchors.leftMargin: -8
                            anchors.verticalCenter: parent.verticalCenter
                            width: 41
                            height: 22
                        }
                    }
                }

                Frame {
                    name: "BrowseNameDiabolicField"
                    wowParent: "BrowseName"
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
            wowParent: "AuctionFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 880
            height: 519

            Frame {
                name: "AuctionFrameDiabolicTitlePlate"
                wowParent: "AuctionFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41
            }
        }

        Frame {
            name: "AuctionFrameDiabolicFoot"
            wowParent: "AuctionFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 834
            height: 41

            Frame {
                name: "AuctionFrameMoneyFrame"
                wowParent: "AuctionFrame"
                pin: "place"
                anchors.right: parent.left
                anchors.rightMargin: -182
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 13
                width: 120.3
                height: 13

                Button {
                    name: "AuctionFrameMoneyFrameCopperButton"
                    text: "13"
                    wowParent: "AuctionFrameMoneyFrame"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 28.8
                    height: 13

                    FontString {
                        name: "AuctionFrameMoneyFrameCopperButtonText"
                        text: "13"
                        wowParent: "AuctionFrameMoneyFrameCopperButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 15.8
                        height: 13.6
                    }

                    Button {
                        name: "AuctionFrameMoneyFrameSilverButton"
                        text: "16"
                        wowParent: "AuctionFrameMoneyFrame"
                        anchors.right: parent.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 28.8
                        height: 13

                        Button {
                            name: "AuctionFrameMoneyFrameGoldButton"
                            text: "3654"
                            wowParent: "AuctionFrameMoneyFrame"
                            anchors.right: parent.left
                            anchors.rightMargin: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 41.7
                            height: 13

                            FontString {
                                name: "AuctionFrameMoneyFrameGoldButtonText"
                                text: "3654"
                                wowParent: "AuctionFrameMoneyFrameGoldButton"
                                anchors.right: parent.right
                                anchors.rightMargin: 13
                                anchors.verticalCenter: parent.verticalCenter
                                width: 28.7
                                height: 13.6
                            }
                        }

                        FontString {
                            name: "AuctionFrameMoneyFrameSilverButtonText"
                            text: "16"
                            wowParent: "AuctionFrameMoneyFrameSilverButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 15.8
                            height: 13.6
                        }
                    }
                }
            }

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
                    name: "BidBidPriceGold"
                    wowParent: "BidBidPrice"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20

                    EditBox {
                        name: "BidBidPriceSilver"
                        wowParent: "BidBidPrice"
                        anchors.left: parent.right
                        anchors.leftMargin: 26
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 20

                        EditBox {
                            name: "BidBidPriceCopper"
                            wowParent: "BidBidPrice"
                            anchors.left: parent.right
                            anchors.leftMargin: 16
                            anchors.verticalCenter: parent.verticalCenter
                            width: 30
                            height: 20
                        }
                    }
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
                    name: "BrowseBidPriceGold"
                    wowParent: "BrowseBidPrice"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20

                    EditBox {
                        name: "BrowseBidPriceSilver"
                        wowParent: "BrowseBidPrice"
                        anchors.left: parent.right
                        anchors.leftMargin: 26
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 20

                        EditBox {
                            name: "BrowseBidPriceCopper"
                            wowParent: "BrowseBidPrice"
                            anchors.left: parent.right
                            anchors.leftMargin: 16
                            anchors.verticalCenter: parent.verticalCenter
                            width: 30
                            height: 20
                        }
                    }
                }

                FontString {
                    name: "BrowseBidText"
                    text: "Bid"
                    wowParent: "BrowseBidPrice"
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
                        wowParent: "BrowseBidButton"
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
                        wowParent: "BrowseBuyoutButton"
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
                        wowParent: "BrowseCloseButton"
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
                        wowParent: "BidBidButton"
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
                        wowParent: "BidBuyoutButton"
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
                        wowParent: "BidCloseButton"
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
                        wowParent: "AuctionsCancelAuctionButton"
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
                        wowParent: "AuctionsCloseButton"
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
                        wowParent: "Atr_Buy1_Button"
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
                        wowParent: "Atr_CancelSelectionButton"
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
                        wowParent: "AuctionatorCloseButton"
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
            wowParent: "AuctionFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 362
            height: 18
        }

        Frame {
            name: "AuctionFrameDiabolicSocket"
            wowParent: "AuctionFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "AuctionFrameTab1"
            text: "Browse"
            wowParent: "AuctionFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AuctionFrameTab2"
            text: "Bids"
            wowParent: "AuctionFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AuctionFrameTab3"
            text: "Auctions"
            wowParent: "AuctionFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 144
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AuctionFrameTab4"
            text: "Buy"
            wowParent: "AuctionFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 202
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AuctionFrameTab5"
            text: "Sell"
            wowParent: "AuctionFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 260
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AuctionFrameTab6"
            text: "More..."
            wowParent: "AuctionFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 318
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Button {
        name: "AuctionsButton1"
        wowParent: "AuctionFrameAuctions"
        anchors.left: parent.left
        anchors.leftMargin: 224
        anchors.top: parent.top
        anchors.topMargin: 71
        width: 576
        height: 37

        Frame {
            name: "AuctionsButton1ClosingTime"
            wowParent: "AuctionsButton1"
            anchors.left: parent.left
            anchors.leftMargin: 191
            anchors.top: parent.top
            width: 65
            height: 28

            FontString {
                name: "AuctionsButton1ClosingTimeText"
                text: "Medium"
                wowParent: "AuctionsButton1ClosingTime"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 65
                height: 28
            }
        }

        FontString {
            name: "AuctionsButton1HighBidder"
            wowParent: "AuctionsButton1"
            anchors.left: parent.left
            anchors.leftMargin: 279
            anchors.top: parent.top
            width: 104
            height: 28
        }

        Button {
            name: "AuctionsButton1Item"
            wowParent: "AuctionsButton1"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 32
            height: 32

            FontString {
                name: "AuctionsButton1ItemCount"
                text: "20"
                wowParent: "AuctionsButton1Item"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 15.8
                height: 13.6
            }
        }

        Frame {
            name: "AuctionsButton1MoneyFrame"
            wowParent: "AuctionsButton1"
            anchors.right: parent.right
            anchors.rightMargin: -10
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -10
            width: 107.3
            height: 13

            Frame {
                name: "AuctionsButton1BuyoutFrame"
                wowParent: "AuctionsButton1"
                anchors.right: parent.right
                anchors.top: parent.bottom
                anchors.topMargin: 1
                width: 197
                height: 13

                Frame {
                    name: "AuctionsButton1BuyoutFrameMoney"
                    wowParent: "AuctionsButton1BuyoutFrame"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 107.3
                    height: 13

                    Button {
                        name: "AuctionsButton1BuyoutFrameMoneyCopperButton"
                        text: "0"
                        wowParent: "AuctionsButton1BuyoutFrameMoney"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "AuctionsButton1BuyoutFrameMoneyCopperButtonText"
                            text: "0"
                            wowParent: "AuctionsButton1BuyoutFrameMoneyCopperButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }

                        Button {
                            name: "AuctionsButton1BuyoutFrameMoneySilverButton"
                            text: "80"
                            wowParent: "AuctionsButton1BuyoutFrameMoney"
                            anchors.right: parent.left
                            anchors.rightMargin: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 13

                            Button {
                                name: "AuctionsButton1BuyoutFrameMoneyGoldButton"
                                text: "9"
                                wowParent: "AuctionsButton1BuyoutFrameMoney"
                                anchors.right: parent.left
                                anchors.rightMargin: 4
                                anchors.verticalCenter: parent.verticalCenter
                                width: 22.3
                                height: 13

                                FontString {
                                    name: "AuctionsButton1BuyoutFrameMoneyGoldButtonText"
                                    text: "9"
                                    wowParent: "AuctionsButton1BuyoutFrameMoneyGoldButton"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 9.4
                                    height: 13.6
                                }
                            }

                            FontString {
                                name: "AuctionsButton1BuyoutFrameMoneySilverButtonText"
                                text: "80"
                                wowParent: "AuctionsButton1BuyoutFrameMoneySilverButton"
                                anchors.right: parent.right
                                anchors.rightMargin: 13
                                anchors.verticalCenter: parent.verticalCenter
                                width: 15.8
                                height: 13.6
                            }
                        }
                    }
                }

                Frame {
                    name: "AuctionsButton1BuyoutFrameText"
                    wowParent: "AuctionsButton1BuyoutFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 87.6
                    height: 13
                }
            }

            Button {
                name: "AuctionsButton1MoneyFrameCopperButton"
                text: "0"
                wowParent: "AuctionsButton1MoneyFrame"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "AuctionsButton1MoneyFrameCopperButtonText"
                    text: "0"
                    wowParent: "AuctionsButton1MoneyFrameCopperButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 9.4
                    height: 13.6
                }

                Button {
                    name: "AuctionsButton1MoneyFrameSilverButton"
                    text: "31"
                    wowParent: "AuctionsButton1MoneyFrame"
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 13

                    Button {
                        name: "AuctionsButton1MoneyFrameGoldButton"
                        text: "9"
                        wowParent: "AuctionsButton1MoneyFrame"
                        anchors.right: parent.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 22.3
                        height: 13

                        FontString {
                            name: "AuctionsButton1MoneyFrameGoldButtonText"
                            text: "9"
                            wowParent: "AuctionsButton1MoneyFrameGoldButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }
                    }

                    FontString {
                        name: "AuctionsButton1MoneyFrameSilverButtonText"
                        text: "31"
                        wowParent: "AuctionsButton1MoneyFrameSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 14.4
                        height: 13.6
                    }
                }
            }
        }

        FontString {
            name: "AuctionsButton1Name"
            text: "Packet of Tharlendris Seeds"
            wowParent: "AuctionsButton1"
            anchors.left: parent.left
            anchors.leftMargin: 43
            anchors.top: parent.top
            width: 142
            height: 28
        }
    }

    Button {
        name: "AuctionsQualitySort"
        text: "Rarity"
        wowParent: "AuctionFrameAuctions"
        anchors.left: parent.left
        anchors.leftMargin: 224
        anchors.top: parent.top
        anchors.topMargin: 50
        width: 185
        height: 19

        Button {
            name: "AuctionsDurationSort"
            text: "Time Left"
            wowParent: "AuctionFrameAuctions"
            anchors.left: parent.right
            anchors.leftMargin: -2
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 19

            FontString {
                name: "AuctionsDurationSortText"
                text: "Time Left"
                wowParent: "AuctionsDurationSort"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 48.1
                height: 10.1
            }

            Button {
                name: "AuctionsHighBidderSort"
                text: "High Bidder"
                wowParent: "AuctionFrameAuctions"
                anchors.left: parent.right
                anchors.leftMargin: -2
                anchors.verticalCenter: parent.verticalCenter
                width: 108
                height: 19

                Button {
                    name: "AuctionsBidSort"
                    text: "Current Bid"
                    wowParent: "AuctionFrameAuctions"
                    anchors.left: parent.right
                    anchors.leftMargin: -2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 193
                    height: 19

                    FontString {
                        name: "AuctionsBidSortText"
                        text: "Current Bid"
                        wowParent: "AuctionsBidSort"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 57.5
                        height: 10.1
                    }
                }

                FontString {
                    name: "AuctionsHighBidderSortText"
                    text: "High Bidder"
                    wowParent: "AuctionsHighBidderSort"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 61.1
                    height: 10.1
                }
            }
        }

        FontString {
            name: "AuctionsQualitySortText"
            text: "Rarity"
            wowParent: "AuctionsQualitySort"
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: 29.5
            height: 10.1
        }
    }

    ScrollFrame {
        name: "AuctionsScrollFrame"
        wowParent: "AuctionFrameAuctions"
        anchors.right: parent.left
        anchors.rightMargin: -803
        anchors.top: parent.top
        anchors.topMargin: 71
        width: 435
        height: 338

        Slider {
            name: "AuctionsScrollFrameScrollBar"
            wowParent: "AuctionsScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 306

            Button {
                name: "AuctionsScrollFrameScrollBarScrollDownButton"
                wowParent: "AuctionsScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "AuctionsScrollFrameScrollBarScrollUpButton"
                wowParent: "AuctionsScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "AuctionsScrollFrameScrollBarDiabolicTrack"
                    wowParent: "AuctionsScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 340
                }
            }
        }

        Frame {
            name: "AuctionsScrollFrameScrollChildFrame"
            wowParent: "AuctionsScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 555
        }
    }

    Button {
        name: "BidQualitySort"
        text: "Rarity"
        wowParent: "AuctionFrameBid"
        anchors.left: parent.left
        anchors.leftMargin: 57
        anchors.top: parent.top
        anchors.topMargin: 50
        width: 195
        height: 19

        Button {
            name: "BidLevelSort"
            text: "Lvl"
            wowParent: "AuctionFrameBid"
            anchors.left: parent.right
            anchors.leftMargin: -2
            anchors.verticalCenter: parent.verticalCenter
            width: 65
            height: 19

            Button {
                name: "BidDurationSort"
                text: "Time Left"
                wowParent: "AuctionFrameBid"
                anchors.left: parent.right
                anchors.leftMargin: -2
                anchors.verticalCenter: parent.verticalCenter
                width: 79
                height: 19

                Button {
                    name: "BidBuyoutSort"
                    text: "Buyout Price"
                    wowParent: "AuctionFrameBid"
                    anchors.left: parent.right
                    anchors.leftMargin: -2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 162
                    height: 19

                    FontString {
                        name: "BidBuyoutSortText"
                        text: "Buyout Price"
                        wowParent: "BidBuyoutSort"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 63.9
                        height: 10.1
                    }

                    Button {
                        name: "BidStatusSort"
                        text: "Bid Status"
                        wowParent: "AuctionFrameBid"
                        anchors.left: parent.right
                        anchors.leftMargin: -2
                        anchors.verticalCenter: parent.verticalCenter
                        width: 94
                        height: 19

                        Button {
                            name: "BidBidSort"
                            text: "Current Bid"
                            wowParent: "AuctionFrameBid"
                            anchors.left: parent.right
                            anchors.leftMargin: -2
                            anchors.verticalCenter: parent.verticalCenter
                            width: 169
                            height: 19

                            FontString {
                                name: "BidBidSortText"
                                text: "Current Bid"
                                wowParent: "BidBidSort"
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                width: 57.5
                                height: 10.1
                            }
                        }

                        FontString {
                            name: "BidStatusSortText"
                            text: "Bid Status"
                            wowParent: "BidStatusSort"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            width: 51
                            height: 10.1
                        }
                    }
                }

                FontString {
                    name: "BidDurationSortText"
                    text: "Time Left"
                    wowParent: "BidDurationSort"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 48.1
                    height: 10.1
                }
            }

            FontString {
                name: "BidLevelSortText"
                text: "Lvl"
                wowParent: "BidLevelSort"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 15.1
                height: 10.1
            }
        }

        FontString {
            name: "BidQualitySortText"
            text: "Rarity"
            wowParent: "BidQualitySort"
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: 29.5
            height: 10.1
        }
    }

    Button {
        name: "BrowseButton1"
        wowParent: "AuctionFrameBrowse"
        anchors.left: parent.left
        anchors.leftMargin: 196
        anchors.top: parent.top
        anchors.topMargin: 103
        width: 600
        height: 37

        Frame {
            name: "BrowseButton1ClosingTime"
            wowParent: "BrowseButton1"
            anchors.left: parent.left
            anchors.leftMargin: 267
            anchors.top: parent.top
            width: 65
            height: 32

            FontString {
                name: "BrowseButton1ClosingTimeText"
                text: "Very Long"
                wowParent: "BrowseButton1ClosingTime"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 65
                height: 32
            }
        }

        FontString {
            name: "BrowseButton1HighBidder"
            text: "Kovasky"
            wowParent: "BrowseButton1"
            anchors.left: parent.left
            anchors.leftMargin: 345
            anchors.top: parent.top
            width: 78
            height: 32
        }

        Button {
            name: "BrowseButton1Item"
            wowParent: "BrowseButton1"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 32
            height: 32

            FontString {
                name: "BrowseButton1ItemCount"
                text: "20"
                wowParent: "BrowseButton1Item"
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
            wowParent: "BrowseButton1"
            anchors.left: parent.left
            anchors.leftMargin: 205
            anchors.top: parent.top
            width: 52
            height: 32
        }

        Frame {
            name: "BrowseButton1MoneyFrame"
            wowParent: "BrowseButton1"
            anchors.right: parent.right
            anchors.rightMargin: -10
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -10
            width: 120.3
            height: 13

            Frame {
                name: "BrowseButton1BuyoutFrame"
                wowParent: "BrowseButton1"
                anchors.right: parent.right
                anchors.top: parent.bottom
                anchors.topMargin: 1
                width: 185
                height: 13

                Frame {
                    name: "BrowseButton1BuyoutFrameMoney"
                    wowParent: "BrowseButton1BuyoutFrame"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 120.3
                    height: 13

                    Button {
                        name: "BrowseButton1BuyoutFrameMoneyCopperButton"
                        text: "0"
                        wowParent: "BrowseButton1BuyoutFrameMoney"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "BrowseButton1BuyoutFrameMoneyCopperButtonText"
                            text: "0"
                            wowParent: "BrowseButton1BuyoutFrameMoneyCopperButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 9.4
                            height: 13.6
                        }

                        Button {
                            name: "BrowseButton1BuyoutFrameMoneySilverButton"
                            text: "75"
                            wowParent: "BrowseButton1BuyoutFrameMoney"
                            anchors.right: parent.left
                            anchors.rightMargin: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 13

                            Button {
                                name: "BrowseButton1BuyoutFrameMoneyGoldButton"
                                text: "249"
                                wowParent: "BrowseButton1BuyoutFrameMoney"
                                anchors.right: parent.left
                                anchors.rightMargin: 4
                                anchors.verticalCenter: parent.verticalCenter
                                width: 35.3
                                height: 13

                                FontString {
                                    name: "BrowseButton1BuyoutFrameMoneyGoldButtonText"
                                    text: "249"
                                    wowParent: "BrowseButton1BuyoutFrameMoneyGoldButton"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 22.3
                                    height: 13.6
                                }
                            }

                            FontString {
                                name: "BrowseButton1BuyoutFrameMoneySilverButtonText"
                                text: "75"
                                wowParent: "BrowseButton1BuyoutFrameMoneySilverButton"
                                anchors.right: parent.right
                                anchors.rightMargin: 13
                                anchors.verticalCenter: parent.verticalCenter
                                width: 16.5
                                height: 13.6
                            }
                        }
                    }
                }

                Frame {
                    name: "BrowseButton1BuyoutFrameText"
                    wowParent: "BrowseButton1BuyoutFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 62.7
                    height: 13
                }
            }

            Button {
                name: "BrowseButton1MoneyFrameCopperButton"
                text: "25"
                wowParent: "BrowseButton1MoneyFrame"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 13

                FontString {
                    name: "BrowseButton1MoneyFrameCopperButtonText"
                    text: "25"
                    wowParent: "BrowseButton1MoneyFrameCopperButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16.5
                    height: 13.6
                }

                Button {
                    name: "BrowseButton1MoneyFrameSilverButton"
                    text: "26"
                    wowParent: "BrowseButton1MoneyFrame"
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 13

                    Button {
                        name: "BrowseButton1MoneyFrameGoldButton"
                        text: "237"
                        wowParent: "BrowseButton1MoneyFrame"
                        anchors.right: parent.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 35.3
                        height: 13

                        FontString {
                            name: "BrowseButton1MoneyFrameGoldButtonText"
                            text: "237"
                            wowParent: "BrowseButton1MoneyFrameGoldButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 22.3
                            height: 13.6
                        }
                    }

                    FontString {
                        name: "BrowseButton1MoneyFrameSilverButtonText"
                        text: "26"
                        wowParent: "BrowseButton1MoneyFrameSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 15.8
                        height: 13.6
                    }
                }
            }
        }

        FontString {
            name: "BrowseButton1Name"
            text: "Durable Nerubhide Cape"
            wowParent: "BrowseButton1"
            anchors.left: parent.left
            anchors.leftMargin: 43
            anchors.top: parent.top
            width: 167
            height: 32
        }
    }

    ScrollFrame {
        name: "BrowseFilterScrollFrame"
        wowParent: "AuctionFrameBrowse"
        anchors.right: parent.left
        anchors.rightMargin: -138
        anchors.top: parent.top
        anchors.topMargin: 82
        width: 160
        height: 327

        Slider {
            name: "BrowseFilterScrollFrameScrollBar"
            wowParent: "BrowseFilterScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 295

            Button {
                name: "BrowseFilterScrollFrameScrollBarScrollDownButton"
                wowParent: "BrowseFilterScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "BrowseFilterScrollFrameScrollBarScrollUpButton"
                wowParent: "BrowseFilterScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "BrowseFilterScrollFrameScrollBarDiabolicTrack"
                    wowParent: "BrowseFilterScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 329
                }
            }
        }

        Frame {
            name: "BrowseFilterScrollFrameScrollChildFrame"
            wowParent: "BrowseFilterScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 420
        }
    }

    Button {
        name: "BrowseNextPageButton"
        wowParent: "AuctionFrameBrowse"
        anchors.right: parent.left
        anchors.rightMargin: -840
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 58
        width: 24
        height: 24

        Button {
            name: "BrowsePrevPageButton"
            wowParent: "AuctionFrameBrowse"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
        }
    }

    FontString {
        name: "BrowseNoResultsText"
        text: "Choose search criteria and press \"Search\""
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 509
        anchors.top: parent.top
        anchors.topMargin: 118
        width: 252.1
        height: 12.2
    }

    Button {
        name: "BrowseQualitySort"
        text: "Rarity"
        wowParent: "AuctionFrameBrowse"
        anchors.left: parent.left
        anchors.leftMargin: 187
        anchors.top: parent.top
        anchors.topMargin: 82
        width: 214
        height: 19

        Button {
            name: "BrowseLevelSort"
            text: "Lvl"
            wowParent: "AuctionFrameBrowse"
            anchors.left: parent.right
            anchors.leftMargin: -2
            anchors.verticalCenter: parent.verticalCenter
            width: 57
            height: 19

            Button {
                name: "BrowseDurationSort"
                text: "Time Left"
                wowParent: "AuctionFrameBrowse"
                anchors.left: parent.right
                anchors.leftMargin: -2
                anchors.verticalCenter: parent.verticalCenter
                width: 91
                height: 19

                FontString {
                    name: "BrowseDurationSortText"
                    text: "Time Left"
                    wowParent: "BrowseDurationSort"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 48.1
                    height: 10.1
                }

                Button {
                    name: "BrowseHighBidderSort"
                    text: "Seller"
                    wowParent: "AuctionFrameBrowse"
                    anchors.left: parent.right
                    anchors.leftMargin: -2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 76
                    height: 19

                    Button {
                        name: "BrowseCurrentBidSort"
                        text: "Current Bid"
                        wowParent: "AuctionFrameBrowse"
                        anchors.left: parent.right
                        anchors.leftMargin: -2
                        anchors.verticalCenter: parent.verticalCenter
                        width: 207
                        height: 19

                        FontString {
                            name: "BrowseCurrentBidSortText"
                            text: "Current Bid"
                            wowParent: "BrowseCurrentBidSort"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            width: 57.5
                            height: 10.1
                        }
                    }

                    FontString {
                        name: "BrowseHighBidderSortText"
                        text: "Seller"
                        wowParent: "BrowseHighBidderSort"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30.2
                        height: 10.1
                    }
                }
            }

            FontString {
                name: "BrowseLevelSortText"
                text: "Lvl"
                wowParent: "BrowseLevelSort"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                width: 15.1
                height: 10.1
            }
        }

        FontString {
            name: "BrowseQualitySortText"
            text: "Rarity"
            wowParent: "BrowseQualitySort"
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: 29.5
            height: 10.1
        }
    }

    Button {
        name: "BrowseResetButton"
        text: "Reset"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        anchors.left: parent.left
        anchors.leftMargin: -8
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 178
        height: 24

        FontString {
            name: "BrowseResetButtonText"
            text: "Reset"
            wowParent: "BrowseResetButton"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30.2
            height: 10.1
        }
    }

    ScrollFrame {
        name: "BrowseScrollFrame"
        wowParent: "AuctionFrameBrowse"
        anchors.right: parent.left
        anchors.rightMargin: -798
        anchors.top: parent.top
        anchors.topMargin: 103
        width: 465
        height: 306

        Slider {
            name: "BrowseScrollFrameScrollBar"
            wowParent: "BrowseScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 274

            Button {
                name: "BrowseScrollFrameScrollBarScrollDownButton"
                wowParent: "BrowseScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "BrowseScrollFrameScrollBarScrollUpButton"
                wowParent: "BrowseScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "BrowseScrollFrameScrollBarDiabolicTrack"
                    wowParent: "BrowseScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 308
                }
            }
        }

        Frame {
            name: "BrowseScrollFrameScrollChildFrame"
            wowParent: "BrowseScrollFrame"
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
        anchors.left: parent.left
        anchors.leftMargin: 182
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 58
        width: 121.4
        height: 10.1
    }

    Ghost {
        name: "Atr_DropDownSLMiddle"
        x: 94
        y: 19
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

    Ghost {
        name: "Atr_HeadingsBarMiddle"
        x: 226
        y: 170
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
            wowParent: "Atr_HeadingsBar"
            anchors.left: parent.left
            anchors.leftMargin: 500
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 1
            height: 1
        }
    }

    Ghost {
        name: "Atr_Hilite1"
        x: 834
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

    Ghost {
        name: "AuctionsButton2BuyoutFrameMoneySilverButton"
        x: 729
        y: 124
        width: 32
        height: 13

        Button {
            name: "AuctionsButton2BuyoutFrameMoneyGoldButton"
            text: "9"
            wowParent: "AuctionsButton2BuyoutFrameMoney"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton2BuyoutFrameMoneyGoldButtonText"
                text: "9"
                wowParent: "AuctionsButton2BuyoutFrameMoneyGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton2Item"
        x: 224
        y: 108
        width: 32
        height: 32

        FontString {
            name: "AuctionsButton2ItemCount"
            text: "20"
            wowParent: "AuctionsButton2Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "AuctionsButton2MoneyFrameSilverButton"
        x: 729
        y: 110
        width: 32
        height: 13

        Button {
            name: "AuctionsButton2MoneyFrameGoldButton"
            text: "9"
            wowParent: "AuctionsButton2MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton2MoneyFrameGoldButtonText"
                text: "9"
                wowParent: "AuctionsButton2MoneyFrameGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton3BuyoutFrameMoneySilverButton"
        x: 729
        y: 161
        width: 32
        height: 13

        Button {
            name: "AuctionsButton3BuyoutFrameMoneyGoldButton"
            text: "8"
            wowParent: "AuctionsButton3BuyoutFrameMoney"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton3BuyoutFrameMoneyGoldButtonText"
                text: "8"
                wowParent: "AuctionsButton3BuyoutFrameMoneyGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton3Item"
        x: 224
        y: 145
        width: 32
        height: 32

        FontString {
            name: "AuctionsButton3ItemCount"
            text: "18"
            wowParent: "AuctionsButton3Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 15.8
            height: 13.6
        }
    }

    Ghost {
        name: "AuctionsButton3MoneyFrameSilverButton"
        x: 729
        y: 147
        width: 32
        height: 13

        Button {
            name: "AuctionsButton3MoneyFrameGoldButton"
            text: "8"
            wowParent: "AuctionsButton3MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton3MoneyFrameGoldButtonText"
                text: "8"
                wowParent: "AuctionsButton3MoneyFrameGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton7BuyoutFrameMoneySilverButton"
        x: 729
        y: 309
        width: 32
        height: 13

        Button {
            name: "AuctionsButton7BuyoutFrameMoneyGoldButton"
            text: "9"
            wowParent: "AuctionsButton7BuyoutFrameMoney"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton7BuyoutFrameMoneyGoldButtonText"
                text: "9"
                wowParent: "AuctionsButton7BuyoutFrameMoneyGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton7Item"
        x: 224
        y: 293
        width: 32
        height: 32

        FontString {
            name: "AuctionsButton7ItemCount"
            text: "2"
            wowParent: "AuctionsButton7Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 9.4
            height: 13.6
        }
    }

    Ghost {
        name: "AuctionsButton7MoneyFrameSilverButton"
        x: 729
        y: 295
        width: 32
        height: 13

        Button {
            name: "AuctionsButton7MoneyFrameGoldButton"
            text: "9"
            wowParent: "AuctionsButton7MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton7MoneyFrameGoldButtonText"
                text: "9"
                wowParent: "AuctionsButton7MoneyFrameGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton8BuyoutFrameMoneySilverButton"
        x: 729
        y: 346
        width: 32
        height: 13

        Button {
            name: "AuctionsButton8BuyoutFrameMoneyGoldButton"
            text: "6"
            wowParent: "AuctionsButton8BuyoutFrameMoney"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton8BuyoutFrameMoneyGoldButtonText"
                text: "6"
                wowParent: "AuctionsButton8BuyoutFrameMoneyGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsButton8Item"
        x: 224
        y: 330
        width: 32
        height: 32

        FontString {
            name: "AuctionsButton8ItemCount"
            text: "2"
            wowParent: "AuctionsButton8Item"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 9.4
            height: 13.6
        }
    }

    Ghost {
        name: "AuctionsButton8MoneyFrameSilverButton"
        x: 729
        y: 332
        width: 32
        height: 13

        Button {
            name: "AuctionsButton8MoneyFrameGoldButton"
            text: "6"
            wowParent: "AuctionsButton8MoneyFrame"
            anchors.right: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: 22.3
            height: 13

            FontString {
                name: "AuctionsButton8MoneyFrameGoldButtonText"
                text: "6"
                wowParent: "AuctionsButton8MoneyFrameGoldButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 9.4
                height: 13.6
            }
        }
    }

    Ghost {
        name: "AuctionsDepositMoneyFrameCopperButton"
        x: 119.5
        y: 368.1
        width: 0
        height: 0

        Button {
            name: "AuctionsDepositMoneyFrameSilverButton"
            text: "65"
            wowParent: "AuctionsDepositMoneyFrame"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 29.5
            height: 13

            Button {
                name: "AuctionsDepositMoneyFrameGoldButton"
                text: "1"
                wowParent: "AuctionsDepositMoneyFrame"
                anchors.right: parent.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 20.9
                height: 13

                FontString {
                    name: "AuctionsDepositMoneyFrameGoldButtonText"
                    text: "1"
                    wowParent: "AuctionsDepositMoneyFrameGoldButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 7.9
                    height: 13.6
                }
            }

            FontString {
                name: "AuctionsDepositMoneyFrameSilverButtonText"
                text: "65"
                wowParent: "AuctionsDepositMoneyFrameSilverButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 16.5
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
