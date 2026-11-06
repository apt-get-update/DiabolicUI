// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: auctionFrame
    name: "AuctionFrame"
    width: 832
    height: 447

    Part {
        id: atr_ActiveItems_Text
        name: "Atr_ActiveItems_Text"
        kind: "FontString"
        text: "Active Items"
        wowParent: "Atr_Main_Panel"
        anchors.horizontalCenter: atr_Main_Panel.horizontalCenter
        anchors.horizontalCenterOffset: -350
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 32
        width: 64.6
        height: 10.1
    }

    Part {
        id: atr_AddToSListButton
        name: "Atr_AddToSListButton"
        kind: "Button"
        text: "Add Item"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: auctionFrame.left
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: 123
        width: 93.1
        height: 20
    }

    Part {
        id: atr_AddToSListButtonText
        name: "Atr_AddToSListButtonText"
        kind: "FontString"
        text: "Add Item"
        wowParent: "Atr_AddToSListButton"
        anchors.horizontalCenter: atr_AddToSListButton.horizontalCenter
        anchors.verticalCenter: atr_AddToSListButton.verticalCenter
        width: 48.8
        height: 10.1
    }

    Part {
        id: atr_Adv_Search_Button
        name: "Atr_Adv_Search_Button"
        kind: "Button"
        text: "+"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Search_Button.right
        anchors.leftMargin: 12
        anchors.verticalCenter: atr_Search_Button.verticalCenter
        width: 22
        height: 22
    }

    Part {
        id: atr_Adv_Search_ButtonText
        name: "Atr_Adv_Search_ButtonText"
        kind: "FontString"
        text: "+"
        wowParent: "Atr_Adv_Search_Button"
        anchors.horizontalCenter: atr_Adv_Search_Button.horizontalCenter
        anchors.verticalCenter: atr_Adv_Search_Button.verticalCenter
        width: 6.5
        height: 10.1
    }

    Part {
        id: atr_Batch_MaxAuctions_Text
        name: "Atr_Batch_MaxAuctions_Text"
        kind: "FontString"
        text: "max: 0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: -34
        anchors.top: atr_Batch_Stacksize_Text.top
        anchors.topMargin: 21
        width: 34.5
        height: 10.1
    }

    Part {
        id: atr_Batch_MaxStacksize_Text
        name: "Atr_Batch_MaxStacksize_Text"
        kind: "FontString"
        text: "max: 0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: 79
        anchors.top: atr_Batch_Stacksize_Text.top
        anchors.topMargin: 21
        width: 34.5
        height: 10.1
    }

    Part {
        id: atr_Batch_NumAuctions
        name: "Atr_Batch_NumAuctions"
        kind: "EditBox"
        text: "0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: -37
        anchors.top: atr_Batch_Stacksize_Text.top
        width: 40
        height: 20
    }

    Part {
        id: atr_Batch_Stacksize
        name: "Atr_Batch_Stacksize"
        kind: "EditBox"
        text: "0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: 84
        anchors.top: atr_Batch_Stacksize_Text.top
        width: 40
        height: 20
    }

    Part {
        id: atr_Batch_Stacksize_Text
        name: "Atr_Batch_Stacksize_Text"
        kind: "FontString"
        text: "stack of"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 55
        anchors.top: atr_SellControls.top
        anchors.topMargin: 224
        width: 82
        height: 22
    }

    Part {
        id: atr_Buy1_Button
        name: "Atr_Buy1_Button"
        kind: "Button"
        text: "Buy"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 200.7
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 84.3
        height: 22
    }

    Part {
        id: atr_Buy1_ButtonText
        name: "Atr_Buy1_ButtonText"
        kind: "FontString"
        text: "Buy"
        wowParent: "Atr_Buy1_Button"
        anchors.horizontalCenter: atr_Buy1_Button.horizontalCenter
        anchors.verticalCenter: atr_Buy1_Button.verticalCenter
        width: 20.1
        height: 10.1
    }

    Part {
        id: atr_CancelSelectionButton
        name: "Atr_CancelSelectionButton"
        kind: "Button"
        text: "Cancel Auctions"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 88.9
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 105.8
        height: 22
    }

    Part {
        id: atr_CancelSelectionButtonText
        name: "Atr_CancelSelectionButtonText"
        kind: "FontString"
        text: "Cancel Auctions"
        wowParent: "Atr_CancelSelectionButton"
        anchors.horizontalCenter: atr_CancelSelectionButton.horizontalCenter
        anchors.verticalCenter: atr_CancelSelectionButton.verticalCenter
        width: 86.9
        height: 10.1
    }

    Part {
        id: atr_CheckActiveButton
        name: "Atr_CheckActiveButton"
        kind: "Button"
        text: "Check for Undercuts"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -210
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 388
        width: 165
        height: 20
    }

    Part {
        id: atr_CheckActiveButtonText
        name: "Atr_CheckActiveButtonText"
        kind: "FontString"
        text: "Check for Undercuts"
        wowParent: "Atr_CheckActiveButton"
        anchors.horizontalCenter: atr_CheckActiveButton.horizontalCenter
        anchors.verticalCenter: atr_CheckActiveButton.verticalCenter
        width: 110.6
        height: 10.1
    }

    Part {
        id: atr_Col1_Heading
        name: "Atr_Col1_Heading"
        kind: "FontString"
        text: "Item Price"
        wowParent: "Atr_HeadingsBar"
        anchors.left: atr_HeadingsBarMiddle.left
        anchors.leftMargin: 40
        anchors.verticalCenter: atr_HeadingsBarMiddle.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 10.1
    }

    Part {
        id: atr_Col3_Heading
        name: "Atr_Col3_Heading"
        kind: "FontString"
        text: "Current Auctions"
        wowParent: "Atr_HeadingsBar"
        anchors.left: atr_HeadingsBarMiddle.left
        anchors.leftMargin: 205
        anchors.verticalCenter: atr_HeadingsBarMiddle.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 86.2
        height: 10.1
    }

    Part {
        id: atr_Col4_Heading
        name: "Atr_Col4_Heading"
        kind: "FontString"
        wowParent: "Atr_HeadingsBar"
        anchors.left: atr_HeadingsBarMiddle.left
        anchors.leftMargin: 500
        anchors.verticalCenter: atr_HeadingsBarMiddle.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 1
        height: 1
    }

    Part {
        id: atr_CreateAuctionButton
        name: "Atr_CreateAuctionButton"
        kind: "Button"
        text: "Create Auction"
        wowParent: "Atr_SellControls"
        style: "Button"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 3
        anchors.top: atr_SellControls.top
        anchors.topMargin: 170
        width: 185
        height: 30
    }

    Part {
        id: atr_CreateAuctionButtonText
        name: "Atr_CreateAuctionButtonText"
        kind: "FontString"
        text: "Create Auction"
        wowParent: "Atr_CreateAuctionButton"
        anchors.horizontalCenter: atr_CreateAuctionButton.horizontalCenter
        anchors.verticalCenter: atr_CreateAuctionButton.verticalCenter
        width: 81.2
        height: 10.1
    }

    Part {
        id: atr_Deposit_Text
        name: "Atr_Deposit_Text"
        kind: "FontString"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 345
        width: 1
        height: 1
    }

    Part {
        id: atr_DropDownSL
        name: "Atr_DropDownSL"
        kind: "Frame"
        wowParent: "Atr_Main_Panel"
        style: "DropDown"
        anchors.left: auctionFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: auctionFrameDiabolicBand.verticalCenter
        width: 200
        height: 32
    }

    Part {
        id: atr_DropDownSLButton
        name: "Atr_DropDownSLButton"
        kind: "Button"
        wowParent: "Atr_DropDownSL"
        anchors.right: atr_DropDownSLDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: atr_DropDownSLDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: atr_DropDownSLDiabolicField
        name: "Atr_DropDownSLDiabolicField"
        kind: "Frame"
        wowParent: "Atr_DropDownSL"
        anchors.left: atr_DropDownSL.left
        anchors.verticalCenter: atr_DropDownSL.verticalCenter
        width: 200
        height: 22
    }

    Part {
        id: atr_DropDownSLText
        name: "Atr_DropDownSLText"
        kind: "FontString"
        text: "Recent Searches"
        wowParent: "Atr_DropDownSL"
        anchors.horizontalCenter: atr_DropDownSLMiddle.horizontalCenter
        anchors.horizontalCenterOffset: -5
        anchors.verticalCenter: atr_DropDownSLMiddle.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 125
        height: 10
    }

    Part {
        id: atr_Duration
        name: "Atr_Duration"
        kind: "Frame"
        wowParent: "Atr_SellControls"
        style: "DropDown"
        anchors.left: atr_Duration_Text.left
        anchors.leftMargin: 32
        anchors.top: atr_Duration_Text.top
        anchors.topMargin: -7
        width: 145
        height: 32
    }

    Part {
        id: atr_DurationButton
        name: "Atr_DurationButton"
        kind: "Button"
        wowParent: "Atr_Duration"
        anchors.right: atr_DurationDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: atr_DurationDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: atr_DurationDiabolicField
        name: "Atr_DurationDiabolicField"
        kind: "Frame"
        wowParent: "Atr_Duration"
        anchors.left: atr_Duration.left
        anchors.verticalCenter: atr_Duration.verticalCenter
        width: 145
        height: 22
    }

    Part {
        id: atr_DurationText
        name: "Atr_DurationText"
        kind: "FontString"
        text: "48 Hours"
        wowParent: "Atr_Duration"
        anchors.left: atr_DurationDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: atr_DurationDiabolicField.verticalCenter
        width: 83
        height: 10
    }

    Part {
        id: atr_Duration_Text
        name: "Atr_Duration_Text"
        kind: "FontString"
        text: "Duration"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 304
        width: 43.8
        height: 10.1
    }

    Part {
        id: atr_FullScanButton
        name: "Atr_FullScanButton"
        kind: "Button"
        text: "Full Scan..."
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionator1Button.left
        anchors.rightMargin: 12
        anchors.verticalCenter: auctionator1Button.verticalCenter
        width: 74
        height: 22
    }

    Part {
        id: atr_FullScanButtonText
        name: "Atr_FullScanButtonText"
        kind: "FontString"
        text: "Full Scan..."
        wowParent: "Atr_FullScanButton"
        anchors.horizontalCenter: atr_FullScanButton.horizontalCenter
        anchors.verticalCenter: atr_FullScanButton.verticalCenter
        width: 58.9
        height: 10.1
    }

    Part {
        id: atr_HeadingsBar
        name: "Atr_HeadingsBar"
        kind: "Frame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 16
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 138
        width: 605
        height: 64
    }

    Part {
        id: atr_Hilite1_btn
        name: "Atr_Hilite1_btn"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.right: atr_Hilite1.right
        anchors.top: atr_Hilite1.top
        width: 805
        height: 341
    }

    Part {
        id: atr_Hlist
        name: "Atr_Hlist"
        kind: "Frame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -208
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 50
        width: 170
        height: 252
    }

    Part {
        id: atr_Hlist_ScrollFrame
        name: "Atr_Hlist_ScrollFrame"
        kind: "ScrollFrame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -208
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 50
        width: 170
        height: 252
    }

    Part {
        id: atr_Hlist_ScrollFrameScrollBar
        name: "Atr_Hlist_ScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "Atr_Hlist_ScrollFrame"
        style: "ScrollBar"
        anchors.left: atr_Hlist_ScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: atr_Hlist_ScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 220
    }

    Part {
        id: atr_Hlist_ScrollFrameScrollBarDiabolicTrack
        name: "Atr_Hlist_ScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
        anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: atr_Hlist_ScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 254
    }

    Part {
        id: atr_Hlist_ScrollFrameScrollBarScrollDownButton
        name: "Atr_Hlist_ScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBar.horizontalCenter
        anchors.top: atr_Hlist_ScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: atr_Hlist_ScrollFrameScrollBarScrollUpButton
        name: "Atr_Hlist_ScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBar.horizontalCenter
        anchors.bottom: atr_Hlist_ScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: atr_Hlist_ScrollFrameScrollChildFrame
        name: "Atr_Hlist_ScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "Atr_Hlist_ScrollFrame"
        anchors.left: atr_Hlist_ScrollFrame.left
        anchors.top: atr_Hlist_ScrollFrame.top
        width: 300
        height: 800
    }

    Part {
        id: atr_ItemsOwned_Text
        name: "Atr_ItemsOwned_Text"
        kind: "FontString"
        text: "Items owned: 0"
        wowParent: "Atr_SellControls"
        anchors.horizontalCenter: atr_Batch_Stacksize_Text.horizontalCenter
        anchors.verticalCenter: atr_Batch_Stacksize_Text.verticalCenter
        anchors.verticalCenterOffset: -22
        width: 79
        height: 10.1
    }

    Part {
        id: atr_ListTabs
        name: "Atr_ListTabs"
        kind: "Frame"
        wowParent: "Atr_Main_Panel"
        anchors.right: atr_HeadingsBar.right
        anchors.bottom: atr_HeadingsBar.top
        anchors.bottomMargin: -22
        width: 250
        height: 40
    }

    Part {
        id: atr_ListTabsTab1
        name: "Atr_ListTabsTab1"
        kind: "Button"
        text: "Current"
        wowParent: "Atr_ListTabs"
        style: "Tab"
        anchors.right: atr_ListTabsTab2.left
        anchors.rightMargin: 2
        anchors.verticalCenter: atr_ListTabsTab2.verticalCenter
        width: 70.4
        height: 32
    }

    Part {
        id: atr_ListTabsTab1Text
        name: "Atr_ListTabsTab1Text"
        kind: "FontString"
        text: "Current"
        wowParent: "Atr_ListTabsTab1"
        anchors.horizontalCenter: atr_ListTabsTab1.horizontalCenter
        anchors.verticalCenter: atr_ListTabsTab1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 53.2
        height: 13
    }

    Part {
        id: atr_ListTabsTab2
        name: "Atr_ListTabsTab2"
        kind: "Button"
        text: "History"
        wowParent: "Atr_ListTabs"
        style: "Tab"
        anchors.right: atr_ListTabsTab3.left
        anchors.rightMargin: 2
        anchors.verticalCenter: atr_ListTabsTab3.verticalCenter
        width: 69
        height: 32
    }

    Part {
        id: atr_ListTabsTab2Text
        name: "Atr_ListTabsTab2Text"
        kind: "FontString"
        text: "History"
        wowParent: "Atr_ListTabsTab2"
        anchors.horizontalCenter: atr_ListTabsTab2.horizontalCenter
        anchors.verticalCenter: atr_ListTabsTab2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 50.3
        height: 13
    }

    Part {
        id: atr_ListTabsTab3
        name: "Atr_ListTabsTab3"
        kind: "Button"
        text: "Other"
        wowParent: "Atr_ListTabs"
        style: "Tab"
        anchors.right: atr_ListTabs.right
        anchors.rightMargin: 8
        anchors.bottom: atr_ListTabs.bottom
        width: 61.9
        height: 32
    }

    Part {
        id: atr_ListTabsTab3Text
        name: "Atr_ListTabsTab3Text"
        kind: "FontString"
        text: "Other"
        wowParent: "Atr_ListTabsTab3"
        anchors.horizontalCenter: atr_ListTabsTab3.horizontalCenter
        anchors.verticalCenter: atr_ListTabsTab3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.8
        height: 13
    }

    Part {
        id: atr_Main_Panel
        name: "Atr_Main_Panel"
        kind: "Frame"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 210
        anchors.top: auctionFrame.top
        width: 548
        height: 447
    }

    Part {
        id: atr_MngSListsButton
        name: "Atr_MngSListsButton"
        kind: "Button"
        text: "Manage Shopping Lists"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -210
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 344
        width: 195
        height: 20
    }

    Part {
        id: atr_MngSListsButtonText
        name: "Atr_MngSListsButtonText"
        kind: "FontString"
        text: "Manage Shopping Lists"
        wowParent: "Atr_MngSListsButton"
        anchors.horizontalCenter: atr_MngSListsButton.horizontalCenter
        anchors.verticalCenter: atr_MngSListsButton.verticalCenter
        width: 123.5
        height: 10.1
    }

    Part {
        id: atr_NewSListButton
        name: "Atr_NewSListButton"
        kind: "Button"
        text: "New Shopping List"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -210
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 364
        width: 195
        height: 20
    }

    Part {
        id: atr_NewSListButtonText
        name: "Atr_NewSListButtonText"
        kind: "FontString"
        text: "New Shopping List"
        wowParent: "Atr_NewSListButton"
        anchors.horizontalCenter: atr_NewSListButton.horizontalCenter
        anchors.verticalCenter: atr_NewSListButton.verticalCenter
        width: 98.4
        height: 10.1
    }

    Part {
        id: atr_RecommendItem_Tex
        name: "Atr_RecommendItem_Tex"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 34
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 62
        width: 37
        height: 37
    }

    Part {
        id: atr_RecommendPerItem_Price
        name: "Atr_RecommendPerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 131.7
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 121
        width: 107.3
        height: 16
    }

    Part {
        id: atr_RecommendPerItem_PriceCopperButton
        name: "Atr_RecommendPerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "Atr_RecommendPerItem_Price"
        anchors.right: atr_RecommendPerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: atr_RecommendPerItem_PriceCopperButtonText
        name: "Atr_RecommendPerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "Atr_RecommendPerItem_PriceCopperButton"
        anchors.right: atr_RecommendPerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: atr_RecommendPerItem_PriceGoldButton
        name: "Atr_RecommendPerItem_PriceGoldButton"
        kind: "Button"
        text: "4"
        wowParent: "Atr_RecommendPerItem_Price"
        anchors.right: atr_RecommendPerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: atr_RecommendPerItem_PriceGoldButtonText
        name: "Atr_RecommendPerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "4"
        wowParent: "Atr_RecommendPerItem_PriceGoldButton"
        anchors.right: atr_RecommendPerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: atr_RecommendPerItem_PriceSilverButton
        name: "Atr_RecommendPerItem_PriceSilverButton"
        kind: "Button"
        text: "94"
        wowParent: "Atr_RecommendPerItem_Price"
        anchors.right: atr_RecommendPerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: atr_RecommendPerItem_PriceSilverButtonText
        name: "Atr_RecommendPerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "94"
        wowParent: "Atr_RecommendPerItem_PriceSilverButton"
        anchors.right: atr_RecommendPerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: atr_RecommendPerItem_Text
        name: "Atr_RecommendPerItem_Text"
        kind: "FontString"
        text: "per item"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Recommend_Text.left
        anchors.leftMargin: 152
        anchors.top: atr_Recommend_Text.top
        anchors.topMargin: 51
        width: 43.1
        height: 10.1
    }

    Part {
        id: atr_RecommendPerStack_Price
        name: "Atr_RecommendPerStack_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 131.7
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 99
        width: 107.3
        height: 16
    }

    Part {
        id: atr_RecommendPerStack_PriceCopperButton
        name: "Atr_RecommendPerStack_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "Atr_RecommendPerStack_Price"
        anchors.right: atr_RecommendPerStack_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: atr_RecommendPerStack_PriceCopperButtonText
        name: "Atr_RecommendPerStack_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "Atr_RecommendPerStack_PriceCopperButton"
        anchors.right: atr_RecommendPerStack_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: atr_RecommendPerStack_PriceGoldButton
        name: "Atr_RecommendPerStack_PriceGoldButton"
        kind: "Button"
        text: "4"
        wowParent: "Atr_RecommendPerStack_Price"
        anchors.right: atr_RecommendPerStack_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerStack_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: atr_RecommendPerStack_PriceGoldButtonText
        name: "Atr_RecommendPerStack_PriceGoldButtonText"
        kind: "FontString"
        text: "4"
        wowParent: "Atr_RecommendPerStack_PriceGoldButton"
        anchors.right: atr_RecommendPerStack_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: atr_RecommendPerStack_PriceSilverButton
        name: "Atr_RecommendPerStack_PriceSilverButton"
        kind: "Button"
        text: "94"
        wowParent: "Atr_RecommendPerStack_Price"
        anchors.right: atr_RecommendPerStack_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerStack_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: atr_RecommendPerStack_PriceSilverButtonText
        name: "Atr_RecommendPerStack_PriceSilverButtonText"
        kind: "FontString"
        text: "94"
        wowParent: "Atr_RecommendPerStack_PriceSilverButton"
        anchors.right: atr_RecommendPerStack_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: atr_RecommendPerStack_Text
        name: "Atr_RecommendPerStack_Text"
        kind: "FontString"
        text: "for your stack of 1"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Recommend_Text.left
        anchors.leftMargin: 152
        anchors.top: atr_Recommend_Text.top
        anchors.topMargin: 28
        width: 89.8
        height: 10.1
    }

    Part {
        id: atr_Recommend_Basis_Text
        name: "Atr_Recommend_Basis_Text"
        kind: "FontString"
        text: "(based on selected auction)"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Recommend_Text.right
        anchors.leftMargin: 20
        anchors.verticalCenter: atr_Recommend_Text.verticalCenter
        anchors.verticalCenterOffset: 2
        width: 140.1
        height: 10.1
    }

    Part {
        id: atr_Recommend_Text
        name: "Atr_Recommend_Text"
        kind: "FontString"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 87
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 73
        width: 1
        height: 1
    }

    Part {
        id: atr_RemFromSListButton
        name: "Atr_RemFromSListButton"
        kind: "Button"
        text: "Remove Item"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 99.1
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: 123
        width: 96.9
        height: 20
    }

    Part {
        id: atr_RemFromSListButtonText
        name: "Atr_RemFromSListButtonText"
        kind: "FontString"
        text: "Remove Item"
        wowParent: "Atr_RemFromSListButton"
        anchors.horizontalCenter: atr_RemFromSListButton.horizontalCenter
        anchors.verticalCenter: atr_RemFromSListButton.verticalCenter
        width: 71.1
        height: 10.1
    }

    Part {
        id: atr_Search_Box
        name: "Atr_Search_Box"
        kind: "EditBox"
        wowParent: "Atr_Main_Panel"
        style: "EditBox"
        anchors.left: atr_DropDownSL.right
        anchors.leftMargin: 4
        anchors.verticalCenter: atr_DropDownSL.verticalCenter
        width: 260
        height: 20
    }

    Part {
        id: atr_Search_BoxDiabolicField
        name: "Atr_Search_BoxDiabolicField"
        kind: "Frame"
        wowParent: "Atr_Search_Box"
        anchors.left: atr_Search_Box.left
        anchors.leftMargin: -8
        anchors.verticalCenter: atr_Search_Box.verticalCenter
        width: 276
        height: 22
    }

    Part {
        id: atr_Search_Button
        name: "Atr_Search_Button"
        kind: "Button"
        text: "Search"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Search_Box.right
        anchors.leftMargin: 20
        anchors.verticalCenter: atr_Search_Box.verticalCenter
        width: 80
        height: 22
    }

    Part {
        id: atr_Search_ButtonText
        name: "Atr_Search_ButtonText"
        kind: "FontString"
        text: "Search"
        wowParent: "Atr_Search_Button"
        anchors.horizontalCenter: atr_Search_Button.horizontalCenter
        anchors.verticalCenter: atr_Search_Button.verticalCenter
        width: 36.6
        height: 10.1
    }

    Part {
        id: atr_SellControls
        name: "Atr_SellControls"
        kind: "Frame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -205
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 47
        width: 190
        height: 338
    }

    Part {
        id: atr_SellControls_Tex
        name: "Atr_SellControls_Tex"
        kind: "Button"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 11
        anchors.top: atr_SellControls.top
        anchors.topMargin: 23
        width: 37
        height: 37
    }

    Part {
        id: atr_SellControls_TexName
        name: "Atr_SellControls_TexName"
        kind: "FontString"
        wowParent: "Atr_SellControls_Tex"
        anchors.left: atr_SellControls_Tex.right
        anchors.leftMargin: 5
        anchors.top: atr_SellControls_Tex.top
        width: 124
        height: 30
    }

    Part {
        id: atr_SrchSListButton
        name: "Atr_SrchSListButton"
        kind: "Button"
        text: "Search for All Items"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -210
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 324
        width: 195
        height: 20
    }

    Part {
        id: atr_SrchSListButtonText
        name: "Atr_SrchSListButtonText"
        kind: "FontString"
        text: "Search for All Items"
        wowParent: "Atr_SrchSListButton"
        anchors.horizontalCenter: atr_SrchSListButton.horizontalCenter
        anchors.verticalCenter: atr_SrchSListButton.verticalCenter
        width: 107
        height: 10.1
    }

    Part {
        id: atr_StackPrice
        name: "Atr_StackPrice"
        kind: "Frame"
        wowParent: "Atr_SellControls"
        anchors.left: atr_StackPriceText.left
        anchors.leftMargin: 8
        anchors.top: atr_StackPriceText.bottom
        anchors.topMargin: 2
        width: 176
        height: 18
    }

    Part {
        id: atr_StackPriceCopper
        name: "Atr_StackPriceCopper"
        kind: "EditBox"
        wowParent: "Atr_StackPrice"
        anchors.left: atr_StackPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: atr_StackPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: atr_StackPriceGold
        name: "Atr_StackPriceGold"
        kind: "EditBox"
        text: "0"
        wowParent: "Atr_StackPrice"
        anchors.left: atr_StackPrice.left
        anchors.top: atr_StackPrice.top
        width: 58
        height: 20
    }

    Part {
        id: atr_StackPriceSilver
        name: "Atr_StackPriceSilver"
        kind: "EditBox"
        text: "0"
        wowParent: "Atr_StackPrice"
        anchors.left: atr_StackPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: atr_StackPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: atr_StackPriceText
        name: "Atr_StackPriceText"
        kind: "FontString"
        text: "Buyout Price"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 82
        width: 63.9
        height: 10.1
    }

    Part {
        id: atr_StartingPriceDiscountText
        name: "Atr_StartingPriceDiscountText"
        kind: "FontString"
        text: "Starting Price Discount:  5%"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 270
        width: 137.9
        height: 10.1
    }

    Part {
        id: auctionFilterButton1
        name: "AuctionFilterButton1"
        kind: "Button"
        text: "Weapon"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 2
        anchors.top: auctionFrame.top
        anchors.topMargin: 82
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton10
        name: "AuctionFilterButton10"
        kind: "Button"
        text: "Gem"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton9.left
        anchors.top: auctionFilterButton9.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton10NormalText
        name: "AuctionFilterButton10NormalText"
        kind: "FontString"
        text: "Gem"
        wowParent: "AuctionFilterButton10"
        anchors.left: auctionFilterButton10.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton10.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton11
        name: "AuctionFilterButton11"
        kind: "Button"
        text: "Miscellaneous"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton10.left
        anchors.top: auctionFilterButton10.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton11NormalText
        name: "AuctionFilterButton11NormalText"
        kind: "FontString"
        text: "Miscellaneous"
        wowParent: "AuctionFilterButton11"
        anchors.left: auctionFilterButton11.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton11.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton12
        name: "AuctionFilterButton12"
        kind: "Button"
        text: "Quest"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton11.left
        anchors.top: auctionFilterButton11.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton12NormalText
        name: "AuctionFilterButton12NormalText"
        kind: "FontString"
        text: "Quest"
        wowParent: "AuctionFilterButton12"
        anchors.left: auctionFilterButton12.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton12.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton13
        name: "AuctionFilterButton13"
        kind: "Button"
        text: "Consumable"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton12.left
        anchors.top: auctionFilterButton12.bottom
        width: 136
        height: 20
    }

    Part {
        id: auctionFilterButton13NormalText
        name: "AuctionFilterButton13NormalText"
        kind: "FontString"
        text: "Consumable"
        wowParent: "AuctionFilterButton13"
        anchors.left: auctionFilterButton13.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton13.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton14
        name: "AuctionFilterButton14"
        kind: "Button"
        text: "Glyph"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton13.left
        anchors.top: auctionFilterButton13.bottom
        width: 136
        height: 20
    }

    Part {
        id: auctionFilterButton14NormalText
        name: "AuctionFilterButton14NormalText"
        kind: "FontString"
        text: "Glyph"
        wowParent: "AuctionFilterButton14"
        anchors.left: auctionFilterButton14.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton14.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton15
        name: "AuctionFilterButton15"
        kind: "Button"
        text: "Trade Goods"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton14.left
        anchors.top: auctionFilterButton14.bottom
        width: 136
        height: 20
    }

    Part {
        id: auctionFilterButton15NormalText
        name: "AuctionFilterButton15NormalText"
        kind: "FontString"
        text: "Trade Goods"
        wowParent: "AuctionFilterButton15"
        anchors.left: auctionFilterButton15.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton15.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton1NormalText
        name: "AuctionFilterButton1NormalText"
        kind: "FontString"
        text: "Weapon"
        wowParent: "AuctionFilterButton1"
        anchors.left: auctionFilterButton1.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton1.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton2
        name: "AuctionFilterButton2"
        kind: "Button"
        text: "Armor"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton1.left
        anchors.top: auctionFilterButton1.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton2NormalText
        name: "AuctionFilterButton2NormalText"
        kind: "FontString"
        text: "Armor"
        wowParent: "AuctionFilterButton2"
        anchors.left: auctionFilterButton2.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton2.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton3
        name: "AuctionFilterButton3"
        kind: "Button"
        text: "Container"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton2.left
        anchors.top: auctionFilterButton2.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton3NormalText
        name: "AuctionFilterButton3NormalText"
        kind: "FontString"
        text: "Container"
        wowParent: "AuctionFilterButton3"
        anchors.left: auctionFilterButton3.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton3.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton4
        name: "AuctionFilterButton4"
        kind: "Button"
        text: "Consumable"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton3.left
        anchors.top: auctionFilterButton3.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton4NormalText
        name: "AuctionFilterButton4NormalText"
        kind: "FontString"
        text: "Consumable"
        wowParent: "AuctionFilterButton4"
        anchors.left: auctionFilterButton4.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton4.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton5
        name: "AuctionFilterButton5"
        kind: "Button"
        text: "Glyph"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton4.left
        anchors.top: auctionFilterButton4.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton5NormalText
        name: "AuctionFilterButton5NormalText"
        kind: "FontString"
        text: "Glyph"
        wowParent: "AuctionFilterButton5"
        anchors.left: auctionFilterButton5.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton5.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton6
        name: "AuctionFilterButton6"
        kind: "Button"
        text: "Trade Goods"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton5.left
        anchors.top: auctionFilterButton5.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton6NormalText
        name: "AuctionFilterButton6NormalText"
        kind: "FontString"
        text: "Trade Goods"
        wowParent: "AuctionFilterButton6"
        anchors.left: auctionFilterButton6.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton6.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton7
        name: "AuctionFilterButton7"
        kind: "Button"
        text: "Projectile"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton6.left
        anchors.top: auctionFilterButton6.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton7NormalText
        name: "AuctionFilterButton7NormalText"
        kind: "FontString"
        text: "Projectile"
        wowParent: "AuctionFilterButton7"
        anchors.left: auctionFilterButton7.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton7.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton8
        name: "AuctionFilterButton8"
        kind: "Button"
        text: "Quiver"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton7.left
        anchors.top: auctionFilterButton7.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton8NormalText
        name: "AuctionFilterButton8NormalText"
        kind: "FontString"
        text: "Quiver"
        wowParent: "AuctionFilterButton8"
        anchors.left: auctionFilterButton8.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton8.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFilterButton9
        name: "AuctionFilterButton9"
        kind: "Button"
        text: "Recipe"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton8.left
        anchors.top: auctionFilterButton8.bottom
        width: 156
        height: 20
    }

    Part {
        id: auctionFilterButton9NormalText
        name: "AuctionFilterButton9NormalText"
        kind: "FontString"
        text: "Recipe"
        wowParent: "AuctionFilterButton9"
        anchors.left: auctionFilterButton9.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton9.verticalCenter
        width: 115
        height: 8
    }

    Part {
        id: auctionFrameAuctions
        name: "AuctionFrameAuctions"
        kind: "Frame"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.top: auctionFrame.top
        width: 758
        height: 447
    }

    Part {
        id: auctionFrameBid
        name: "AuctionFrameBid"
        kind: "Frame"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.top: auctionFrame.top
        width: 758
        height: 447
    }

    Part {
        id: auctionFrameBrowse
        name: "AuctionFrameBrowse"
        kind: "Frame"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.top: auctionFrame.top
        width: 758
        height: 447
    }

    Part {
        id: auctionFrameCloseButton
        name: "AuctionFrameCloseButton"
        kind: "Button"
        wowParent: "AuctionFrame"
        style: "CloseButton"
        anchors.horizontalCenter: auctionFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: auctionFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: auctionFrameDiabolic
        name: "AuctionFrameDiabolic"
        kind: "Frame"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.leftMargin: -24
        anchors.top: auctionFrame.top
        anchors.topMargin: -56
        width: 880
        height: 551
    }

    Part {
        id: auctionFrameDiabolicBand
        name: "AuctionFrameDiabolicBand"
        kind: "Frame"
        wowParent: "AuctionFrameDiabolic"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: auctionFrameDiabolic.top
        anchors.topMargin: 56
        width: 832
        height: 40
    }

    Part {
        id: auctionFrameDiabolicBorder
        name: "AuctionFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "AuctionFrameDiabolic"
        anchors.left: auctionFrameDiabolic.left
        anchors.top: auctionFrameDiabolic.top
        anchors.topMargin: 32
        width: 880
        height: 519
    }

    Part {
        id: auctionFrameDiabolicFoot
        name: "AuctionFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "AuctionFrameDiabolic"
        anchors.horizontalCenter: browseCloseButton.horizontalCenter
        anchors.horizontalCenterOffset: -370
        anchors.top: browseCloseButton.top
        anchors.topMargin: -6
        width: 834
        height: 41
    }

    Part {
        id: auctionFrameDiabolicRail
        name: "AuctionFrameDiabolicRail"
        kind: "Frame"
        wowParent: "AuctionFrameDiabolic"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 362
        height: 18
    }

    Part {
        id: auctionFrameDiabolicSocket
        name: "AuctionFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "AuctionFrameDiabolic"
        anchors.right: auctionFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: auctionFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: auctionFrameDiabolicTitlePlate
        name: "AuctionFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "AuctionFrameDiabolic"
        anchors.horizontalCenter: auctionFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: auctionFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: auctionFrameMoneyFrame
        name: "AuctionFrameMoneyFrame"
        kind: "Frame"
        wowParent: "AuctionFrame"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -181
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -6
        width: 120.3
        height: 13
    }

    Part {
        id: auctionFrameMoneyFrameCopperButton
        name: "AuctionFrameMoneyFrameCopperButton"
        kind: "Button"
        text: "13"
        wowParent: "AuctionFrameMoneyFrame"
        anchors.right: auctionFrameMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrame.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionFrameMoneyFrameCopperButtonText
        name: "AuctionFrameMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "13"
        wowParent: "AuctionFrameMoneyFrameCopperButton"
        anchors.right: auctionFrameMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionFrameMoneyFrameGoldButton
        name: "AuctionFrameMoneyFrameGoldButton"
        kind: "Button"
        text: "3654"
        wowParent: "AuctionFrameMoneyFrame"
        anchors.right: auctionFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionFrameMoneyFrameSilverButton.verticalCenter
        width: 41.7
        height: 13
    }

    Part {
        id: auctionFrameMoneyFrameGoldButtonText
        name: "AuctionFrameMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "3654"
        wowParent: "AuctionFrameMoneyFrameGoldButton"
        anchors.right: auctionFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrameGoldButton.verticalCenter
        width: 28.7
        height: 13.6
    }

    Part {
        id: auctionFrameMoneyFrameSilverButton
        name: "AuctionFrameMoneyFrameSilverButton"
        kind: "Button"
        text: "16"
        wowParent: "AuctionFrameMoneyFrame"
        anchors.right: auctionFrameMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionFrameMoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionFrameMoneyFrameSilverButtonText
        name: "AuctionFrameMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "16"
        wowParent: "AuctionFrameMoneyFrameSilverButton"
        anchors.right: auctionFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionFrameTab1
        name: "AuctionFrameTab1"
        kind: "Button"
        text: "Browse"
        wowParent: "AuctionFrame"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: auctionFrameTab2
        name: "AuctionFrameTab2"
        kind: "Button"
        text: "Bids"
        wowParent: "AuctionFrame"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: auctionFrameTab3
        name: "AuctionFrameTab3"
        kind: "Button"
        text: "Auctions"
        wowParent: "AuctionFrame"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: auctionFrameTab4
        name: "AuctionFrameTab4"
        kind: "Button"
        text: "Buy"
        wowParent: "AuctionFrame"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: auctionFrameTab5
        name: "AuctionFrameTab5"
        kind: "Button"
        text: "Sell"
        wowParent: "AuctionFrame"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: auctionFrameTab6
        name: "AuctionFrameTab6"
        kind: "Button"
        text: "More..."
        wowParent: "AuctionFrame"
        style: "Banner"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 318
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: auctionator1Button
        name: "Auctionator1Button"
        kind: "Button"
        text: "Options"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionFrameDiabolicBand.right
        anchors.rightMargin: 48
        anchors.verticalCenter: auctionFrameDiabolicBand.verticalCenter
        width: 70
        height: 22
    }

    Part {
        id: auctionator1ButtonText
        name: "Auctionator1ButtonText"
        kind: "FontString"
        text: "Options"
        wowParent: "Auctionator1Button"
        anchors.horizontalCenter: auctionator1Button.horizontalCenter
        anchors.verticalCenter: auctionator1Button.verticalCenter
        width: 43.1
        height: 10.1
    }

    Part {
        id: auctionatorCloseButton
        name: "AuctionatorCloseButton"
        kind: "Button"
        text: "Close"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 8
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 74.9
        height: 22
    }

    Part {
        id: auctionatorCloseButtonText
        name: "AuctionatorCloseButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "AuctionatorCloseButton"
        anchors.horizontalCenter: auctionatorCloseButton.horizontalCenter
        anchors.verticalCenter: auctionatorCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Part {
        id: auctionatorEntry1
        name: "AuctionatorEntry1"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorScrollFrame.left
        anchors.leftMargin: 8
        anchors.top: auctionatorScrollFrame.top
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry10
        name: "AuctionatorEntry10"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry9.left
        anchors.top: auctionatorEntry9.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry10_EntryText
        name: "AuctionatorEntry10_EntryText"
        kind: "FontString"
        text: "1 stack of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry10.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry10.top
        anchors.topMargin: 3
        width: 57.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry10_PerItem_Price
        name: "AuctionatorEntry10_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry10.left
        anchors.leftMargin: 28.2
        anchors.top: auctionatorEntry10.top
        anchors.topMargin: 1.5
        width: 113.8
        height: 13
    }

    Part {
        id: auctionatorEntry10_PerItem_PriceCopperButton
        name: "AuctionatorEntry10_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry10_PerItem_Price"
        anchors.right: auctionatorEntry10_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry10_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry10_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry10_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry10_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry10_PerItem_PriceGoldButton
        name: "AuctionatorEntry10_PerItem_PriceGoldButton"
        kind: "Button"
        text: "22"
        wowParent: "AuctionatorEntry10_PerItem_Price"
        anchors.right: auctionatorEntry10_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceSilverButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry10_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry10_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "22"
        wowParent: "AuctionatorEntry10_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry10_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceGoldButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry10_PerItem_PriceSilverButton
        name: "AuctionatorEntry10_PerItem_PriceSilverButton"
        kind: "Button"
        text: "50"
        wowParent: "AuctionatorEntry10_PerItem_Price"
        anchors.right: auctionatorEntry10_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry10_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry10_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "50"
        wowParent: "AuctionatorEntry10_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry10_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry10_StackPrice
        name: "AuctionatorEntry10_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry10.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry10.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorEntry11
        name: "AuctionatorEntry11"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry10.left
        anchors.top: auctionatorEntry10.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry11_EntryText
        name: "AuctionatorEntry11_EntryText"
        kind: "FontString"
        text: "47 stacks of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry11.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry11.top
        anchors.topMargin: 3
        width: 69
        height: 10.1
    }

    Part {
        id: auctionatorEntry11_PerItem_Price
        name: "AuctionatorEntry11_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry11.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry11.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry11_PerItem_PriceCopperButton
        name: "AuctionatorEntry11_PerItem_PriceCopperButton"
        kind: "Button"
        text: "99"
        wowParent: "AuctionatorEntry11_PerItem_Price"
        anchors.right: auctionatorEntry11_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry11_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry11_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry11_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "99"
        wowParent: "AuctionatorEntry11_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry11_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry11_PerItem_PriceCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry11_PerItem_PriceSilverButton
        name: "AuctionatorEntry11_PerItem_PriceSilverButton"
        kind: "Button"
        text: "38"
        wowParent: "AuctionatorEntry11_PerItem_Price"
        anchors.right: auctionatorEntry11_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry11_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry11_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry11_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "38"
        wowParent: "AuctionatorEntry11_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry11_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry11_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry11_StackPrice
        name: "AuctionatorEntry11_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry11.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry11.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorEntry12
        name: "AuctionatorEntry12"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry11.left
        anchors.top: auctionatorEntry11.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry12_EntryText
        name: "AuctionatorEntry12_EntryText"
        kind: "FontString"
        text: "10 stacks of 5"
        wowParent: "?"
        anchors.left: auctionatorEntry12.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry12.top
        anchors.topMargin: 3
        width: 68.3
        height: 10.1
    }

    Part {
        id: auctionatorEntry12_PerItem_Price
        name: "AuctionatorEntry12_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry12.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry12.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry12_PerItem_PriceCopperButton
        name: "AuctionatorEntry12_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry12_PerItem_Price"
        anchors.right: auctionatorEntry12_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry12_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry12_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry12_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry12_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry12_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry12_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry12_PerItem_PriceSilverButton
        name: "AuctionatorEntry12_PerItem_PriceSilverButton"
        kind: "Button"
        text: "39"
        wowParent: "AuctionatorEntry12_PerItem_Price"
        anchors.right: auctionatorEntry12_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry12_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry12_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry12_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "39"
        wowParent: "AuctionatorEntry12_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry12_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry12_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry12_StackPrice
        name: "AuctionatorEntry12_StackPrice"
        kind: "FontString"
        text: "1g 95s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry12.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry12.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Part {
        id: auctionatorEntry1_EntryText
        name: "AuctionatorEntry1_EntryText"
        kind: "FontString"
        text: "1 stack of 1 (yours)"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 3
        width: 95.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry1_PerItem_Price
        name: "AuctionatorEntry1_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 34.7
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 1.5
        width: 107.3
        height: 13
    }

    Part {
        id: auctionatorEntry1_PerItem_PriceCopperButton
        name: "AuctionatorEntry1_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry1_PerItem_Price"
        anchors.right: auctionatorEntry1_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry1_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry1_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry1_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry1_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry1_PerItem_PriceGoldButton
        name: "AuctionatorEntry1_PerItem_PriceGoldButton"
        kind: "Button"
        text: "4"
        wowParent: "AuctionatorEntry1_PerItem_Price"
        anchors.right: auctionatorEntry1_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionatorEntry1_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry1_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "4"
        wowParent: "AuctionatorEntry1_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry1_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry1_PerItem_PriceSilverButton
        name: "AuctionatorEntry1_PerItem_PriceSilverButton"
        kind: "Button"
        text: "94"
        wowParent: "AuctionatorEntry1_PerItem_Price"
        anchors.right: auctionatorEntry1_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry1_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry1_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "94"
        wowParent: "AuctionatorEntry1_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry1_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry1_PerItem_Text
        name: "AuctionatorEntry1_PerItem_Text"
        kind: "FontString"
        text: "no buyout price"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 46.3
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 2
        width: 79.7
        height: 10.1
    }

    Part {
        id: auctionatorEntry1_StackPrice
        name: "AuctionatorEntry1_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorEntry2
        name: "AuctionatorEntry2"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry1.left
        anchors.top: auctionatorEntry1.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry2_EntryText
        name: "AuctionatorEntry2_EntryText"
        kind: "FontString"
        text: "1 stack of 10"
        wowParent: "?"
        anchors.left: auctionatorEntry2.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry2.top
        anchors.topMargin: 3
        width: 64.6
        height: 10.1
    }

    Part {
        id: auctionatorEntry2_PerItem_Price
        name: "AuctionatorEntry2_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry2.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry2.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry2_PerItem_PriceCopperButton
        name: "AuctionatorEntry2_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry2_PerItem_Price"
        anchors.right: auctionatorEntry2_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry2_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry2_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry2_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry2_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry2_PerItem_PriceGoldButton
        name: "AuctionatorEntry2_PerItem_PriceGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionatorEntry2_PerItem_Price"
        anchors.right: auctionatorEntry2_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionatorEntry2_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry2_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionatorEntry2_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry2_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry2_PerItem_PriceSilverButton
        name: "AuctionatorEntry2_PerItem_PriceSilverButton"
        kind: "Button"
        text: "24"
        wowParent: "AuctionatorEntry2_PerItem_Price"
        anchors.right: auctionatorEntry2_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry2_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry2_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "24"
        wowParent: "AuctionatorEntry2_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry2_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry2_StackPrice
        name: "AuctionatorEntry2_StackPrice"
        kind: "FontString"
        text: "2g 40s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry2.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry2.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Part {
        id: auctionatorEntry3
        name: "AuctionatorEntry3"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry2.left
        anchors.top: auctionatorEntry2.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry3_EntryText
        name: "AuctionatorEntry3_EntryText"
        kind: "FontString"
        text: "1 stack of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry3.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry3.top
        anchors.topMargin: 3
        width: 57.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry3_PerItem_Price
        name: "AuctionatorEntry3_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry3.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry3.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry3_PerItem_PriceCopperButton
        name: "AuctionatorEntry3_PerItem_PriceCopperButton"
        kind: "Button"
        text: "98"
        wowParent: "AuctionatorEntry3_PerItem_Price"
        anchors.right: auctionatorEntry3_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry3_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry3_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "98"
        wowParent: "AuctionatorEntry3_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry3_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry3_PerItem_PriceGoldButton
        name: "AuctionatorEntry3_PerItem_PriceGoldButton"
        kind: "Button"
        text: "2"
        wowParent: "AuctionatorEntry3_PerItem_Price"
        anchors.right: auctionatorEntry3_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionatorEntry3_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry3_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "2"
        wowParent: "AuctionatorEntry3_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry3_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry3_PerItem_PriceSilverButton
        name: "AuctionatorEntry3_PerItem_PriceSilverButton"
        kind: "Button"
        text: "24"
        wowParent: "AuctionatorEntry3_PerItem_Price"
        anchors.right: auctionatorEntry3_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry3_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry3_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "24"
        wowParent: "AuctionatorEntry3_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry3_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry3_StackPrice
        name: "AuctionatorEntry3_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry3.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry3.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorEntry4
        name: "AuctionatorEntry4"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry3.left
        anchors.top: auctionatorEntry3.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry4_EntryText
        name: "AuctionatorEntry4_EntryText"
        kind: "FontString"
        text: "1 stack of 8"
        wowParent: "?"
        anchors.left: auctionatorEntry4.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry4.top
        anchors.topMargin: 3
        width: 58.9
        height: 10.1
    }

    Part {
        id: auctionatorEntry4_PerItem_Price
        name: "AuctionatorEntry4_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry4.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry4.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry4_PerItem_PriceCopperButton
        name: "AuctionatorEntry4_PerItem_PriceCopperButton"
        kind: "Button"
        text: "99"
        wowParent: "AuctionatorEntry4_PerItem_Price"
        anchors.right: auctionatorEntry4_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry4_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry4_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "99"
        wowParent: "AuctionatorEntry4_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry4_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry4_PerItem_PriceGoldButton
        name: "AuctionatorEntry4_PerItem_PriceGoldButton"
        kind: "Button"
        text: "2"
        wowParent: "AuctionatorEntry4_PerItem_Price"
        anchors.right: auctionatorEntry4_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionatorEntry4_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry4_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "2"
        wowParent: "AuctionatorEntry4_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry4_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry4_PerItem_PriceSilverButton
        name: "AuctionatorEntry4_PerItem_PriceSilverButton"
        kind: "Button"
        text: "24"
        wowParent: "AuctionatorEntry4_PerItem_Price"
        anchors.right: auctionatorEntry4_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry4_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry4_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "24"
        wowParent: "AuctionatorEntry4_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry4_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry4_StackPrice
        name: "AuctionatorEntry4_StackPrice"
        kind: "FontString"
        text: "1g 99s 92c"
        wowParent: "?"
        anchors.left: auctionatorEntry4.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry4.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Part {
        id: auctionatorEntry5
        name: "AuctionatorEntry5"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry4.left
        anchors.top: auctionatorEntry4.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry5_EntryText
        name: "AuctionatorEntry5_EntryText"
        kind: "FontString"
        text: "1 stack of 14"
        wowParent: "?"
        anchors.left: auctionatorEntry5.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry5.top
        anchors.topMargin: 3
        width: 64.6
        height: 10.1
    }

    Part {
        id: auctionatorEntry5_PerItem_Price
        name: "AuctionatorEntry5_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry5.left
        anchors.leftMargin: 63.5
        anchors.top: auctionatorEntry5.top
        anchors.topMargin: 1.5
        width: 78.5
        height: 13
    }

    Part {
        id: auctionatorEntry5_PerItem_PriceCopperButton
        name: "AuctionatorEntry5_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry5_PerItem_Price"
        anchors.right: auctionatorEntry5_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry5_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry5_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry5_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry5_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry5_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry5_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry5_PerItem_PriceSilverButton
        name: "AuctionatorEntry5_PerItem_PriceSilverButton"
        kind: "Button"
        text: "25"
        wowParent: "AuctionatorEntry5_PerItem_Price"
        anchors.right: auctionatorEntry5_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry5_PerItem_PriceCopperButton.verticalCenter
        width: 29.5
        height: 13
    }

    Part {
        id: auctionatorEntry5_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry5_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "25"
        wowParent: "AuctionatorEntry5_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry5_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry5_PerItem_PriceSilverButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: auctionatorEntry5_StackPrice
        name: "AuctionatorEntry5_StackPrice"
        kind: "FontString"
        text: "3g 50s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry5.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry5.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Part {
        id: auctionatorEntry6
        name: "AuctionatorEntry6"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry5.left
        anchors.top: auctionatorEntry5.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry6_EntryText
        name: "AuctionatorEntry6_EntryText"
        kind: "FontString"
        text: "1 stack of 14"
        wowParent: "?"
        anchors.left: auctionatorEntry6.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry6.top
        anchors.topMargin: 3
        width: 64.6
        height: 10.1
    }

    Part {
        id: auctionatorEntry6_PerItem_Price
        name: "AuctionatorEntry6_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry6.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry6.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry6_PerItem_PriceCopperButton
        name: "AuctionatorEntry6_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry6_PerItem_Price"
        anchors.right: auctionatorEntry6_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry6_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry6_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry6_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry6_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry6_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry6_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry6_PerItem_PriceSilverButton
        name: "AuctionatorEntry6_PerItem_PriceSilverButton"
        kind: "Button"
        text: "73"
        wowParent: "AuctionatorEntry6_PerItem_Price"
        anchors.right: auctionatorEntry6_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry6_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry6_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry6_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "73"
        wowParent: "AuctionatorEntry6_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry6_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry6_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry6_StackPrice
        name: "AuctionatorEntry6_StackPrice"
        kind: "FontString"
        text: "10g 22s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry6.left
        anchors.leftMargin: 497.5
        anchors.top: auctionatorEntry6.top
        anchors.topMargin: 3
        width: 62.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry7
        name: "AuctionatorEntry7"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry6.left
        anchors.top: auctionatorEntry6.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry7_EntryText
        name: "AuctionatorEntry7_EntryText"
        kind: "FontString"
        text: "1 stack of 1 (yours)"
        wowParent: "?"
        anchors.left: auctionatorEntry7.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry7.top
        anchors.topMargin: 3
        width: 95.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry7_PerItem_Price
        name: "AuctionatorEntry7_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry7.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry7.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Part {
        id: auctionatorEntry7_PerItem_PriceCopperButton
        name: "AuctionatorEntry7_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry7_PerItem_Price"
        anchors.right: auctionatorEntry7_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry7_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry7_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry7_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry7_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry7_PerItem_PriceGoldButton
        name: "AuctionatorEntry7_PerItem_PriceGoldButton"
        kind: "Button"
        text: "1"
        wowParent: "AuctionatorEntry7_PerItem_Price"
        anchors.right: auctionatorEntry7_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceSilverButton.verticalCenter
        width: 20.9
        height: 13
    }

    Part {
        id: auctionatorEntry7_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry7_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "AuctionatorEntry7_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry7_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceGoldButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Part {
        id: auctionatorEntry7_PerItem_PriceSilverButton
        name: "AuctionatorEntry7_PerItem_PriceSilverButton"
        kind: "Button"
        text: "74"
        wowParent: "AuctionatorEntry7_PerItem_Price"
        anchors.right: auctionatorEntry7_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionatorEntry7_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry7_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "74"
        wowParent: "AuctionatorEntry7_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry7_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry7_StackPrice
        name: "AuctionatorEntry7_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry7.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry7.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorEntry8
        name: "AuctionatorEntry8"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry7.left
        anchors.top: auctionatorEntry7.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry8_EntryText
        name: "AuctionatorEntry8_EntryText"
        kind: "FontString"
        text: "1 stack of 1 (yours)"
        wowParent: "?"
        anchors.left: auctionatorEntry8.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry8.top
        anchors.topMargin: 3
        width: 95.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry8_PerItem_Price
        name: "AuctionatorEntry8_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry8.left
        anchors.leftMargin: 36.1
        anchors.top: auctionatorEntry8.top
        anchors.topMargin: 1.5
        width: 105.9
        height: 13
    }

    Part {
        id: auctionatorEntry8_PerItem_PriceCopperButton
        name: "AuctionatorEntry8_PerItem_PriceCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry8_PerItem_Price"
        anchors.right: auctionatorEntry8_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry8_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry8_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry8_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry8_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry8_PerItem_PriceGoldButton
        name: "AuctionatorEntry8_PerItem_PriceGoldButton"
        kind: "Button"
        text: "1"
        wowParent: "AuctionatorEntry8_PerItem_Price"
        anchors.right: auctionatorEntry8_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceSilverButton.verticalCenter
        width: 20.9
        height: 13
    }

    Part {
        id: auctionatorEntry8_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry8_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "AuctionatorEntry8_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry8_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceGoldButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Part {
        id: auctionatorEntry8_PerItem_PriceSilverButton
        name: "AuctionatorEntry8_PerItem_PriceSilverButton"
        kind: "Button"
        text: "54"
        wowParent: "AuctionatorEntry8_PerItem_Price"
        anchors.right: auctionatorEntry8_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry8_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry8_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "54"
        wowParent: "AuctionatorEntry8_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry8_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionatorEntry8_StackPrice
        name: "AuctionatorEntry8_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry8.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry8.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorEntry9
        name: "AuctionatorEntry9"
        kind: "Button"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry8.left
        anchors.top: auctionatorEntry8.bottom
        width: 584
        height: 16
    }

    Part {
        id: auctionatorEntry9_EntryText
        name: "AuctionatorEntry9_EntryText"
        kind: "FontString"
        text: "3 stacks of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry9.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry9.top
        anchors.topMargin: 3
        width: 62.5
        height: 10.1
    }

    Part {
        id: auctionatorEntry9_PerItem_Price
        name: "AuctionatorEntry9_PerItem_Price"
        kind: "Frame"
        wowParent: "?"
        anchors.left: auctionatorEntry9.left
        anchors.leftMargin: 34.7
        anchors.top: auctionatorEntry9.top
        anchors.topMargin: 1.5
        width: 107.3
        height: 13
    }

    Part {
        id: auctionatorEntry9_PerItem_PriceCopperButton
        name: "AuctionatorEntry9_PerItem_PriceCopperButton"
        kind: "Button"
        text: "1"
        wowParent: "AuctionatorEntry9_PerItem_Price"
        anchors.right: auctionatorEntry9_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry9_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry9_PerItem_PriceCopperButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "AuctionatorEntry9_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry9_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceCopperButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Part {
        id: auctionatorEntry9_PerItem_PriceGoldButton
        name: "AuctionatorEntry9_PerItem_PriceGoldButton"
        kind: "Button"
        text: "3"
        wowParent: "AuctionatorEntry9_PerItem_Price"
        anchors.right: auctionatorEntry9_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionatorEntry9_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry9_PerItem_PriceGoldButtonText"
        kind: "FontString"
        text: "3"
        wowParent: "AuctionatorEntry9_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry9_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry9_PerItem_PriceSilverButton
        name: "AuctionatorEntry9_PerItem_PriceSilverButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionatorEntry9_PerItem_Price"
        anchors.right: auctionatorEntry9_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionatorEntry9_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry9_PerItem_PriceSilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionatorEntry9_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry9_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionatorEntry9_StackPrice
        name: "AuctionatorEntry9_StackPrice"
        kind: "FontString"
        wowParent: "?"
        anchors.left: auctionatorEntry9.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry9.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Part {
        id: auctionatorHEntry1
        name: "AuctionatorHEntry1"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 5
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry10
        name: "AuctionatorHEntry10"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 149
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry10_EntryText
        name: "AuctionatorHEntry10_EntryText"
        kind: "FontString"
        text: "runed orb"
        wowParent: "AuctionatorHEntry10"
        anchors.left: auctionatorHEntry10.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry10.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry11
        name: "AuctionatorHEntry11"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 165
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry11_EntryText
        name: "AuctionatorHEntry11_EntryText"
        kind: "FontString"
        text: "runed orbs"
        wowParent: "AuctionatorHEntry11"
        anchors.left: auctionatorHEntry11.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry11.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry12
        name: "AuctionatorHEntry12"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 181
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry12_EntryText
        name: "AuctionatorHEntry12_EntryText"
        kind: "FontString"
        text: "Tankard"
        wowParent: "AuctionatorHEntry12"
        anchors.left: auctionatorHEntry12.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry12.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry13
        name: "AuctionatorHEntry13"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 197
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry13_EntryText
        name: "AuctionatorHEntry13_EntryText"
        kind: "FontString"
        text: "Tankard of terror"
        wowParent: "AuctionatorHEntry13"
        anchors.left: auctionatorHEntry13.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry13.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry14
        name: "AuctionatorHEntry14"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 213
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry14_EntryText
        name: "AuctionatorHEntry14_EntryText"
        kind: "FontString"
        text: "Fish feast"
        wowParent: "AuctionatorHEntry14"
        anchors.left: auctionatorHEntry14.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry14.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry15
        name: "AuctionatorHEntry15"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 229
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry15_EntryText
        name: "AuctionatorHEntry15_EntryText"
        kind: "FontString"
        text: "Flask"
        wowParent: "AuctionatorHEntry15"
        anchors.left: auctionatorHEntry15.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry15.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry1_EntryText
        name: "AuctionatorHEntry1_EntryText"
        kind: "FontString"
        text: "Morrowgrain"
        wowParent: "AuctionatorHEntry1"
        anchors.left: auctionatorHEntry1.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry1.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry2
        name: "AuctionatorHEntry2"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 21
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry2_EntryText
        name: "AuctionatorHEntry2_EntryText"
        kind: "FontString"
        text: "un'goro"
        wowParent: "AuctionatorHEntry2"
        anchors.left: auctionatorHEntry2.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry2.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry3
        name: "AuctionatorHEntry3"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 37
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry3_EntryText
        name: "AuctionatorHEntry3_EntryText"
        kind: "FontString"
        text: "un goro"
        wowParent: "AuctionatorHEntry3"
        anchors.left: auctionatorHEntry3.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry3.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry4
        name: "AuctionatorHEntry4"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 53
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry4_EntryText
        name: "AuctionatorHEntry4_EntryText"
        kind: "FontString"
        text: "runecloth"
        wowParent: "AuctionatorHEntry4"
        anchors.left: auctionatorHEntry4.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry4.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry5
        name: "AuctionatorHEntry5"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 69
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry5_EntryText
        name: "AuctionatorHEntry5_EntryText"
        kind: "FontString"
        text: "Mageweave Cloth"
        wowParent: "AuctionatorHEntry5"
        anchors.left: auctionatorHEntry5.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry5.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry6
        name: "AuctionatorHEntry6"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 85
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry6_EntryText
        name: "AuctionatorHEntry6_EntryText"
        kind: "FontString"
        text: "Silk Cloth"
        wowParent: "AuctionatorHEntry6"
        anchors.left: auctionatorHEntry6.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry6.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry7
        name: "AuctionatorHEntry7"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 101
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry7_EntryText
        name: "AuctionatorHEntry7_EntryText"
        kind: "FontString"
        text: "Wool"
        wowParent: "AuctionatorHEntry7"
        anchors.left: auctionatorHEntry7.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry7.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry8
        name: "AuctionatorHEntry8"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 117
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry8_EntryText
        name: "AuctionatorHEntry8_EntryText"
        kind: "FontString"
        text: "Sash of ancient"
        wowParent: "AuctionatorHEntry8"
        anchors.left: auctionatorHEntry8.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry8.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry9
        name: "AuctionatorHEntry9"
        kind: "Button"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 133
        width: 174
        height: 16
    }

    Part {
        id: auctionatorHEntry9_EntryText
        name: "AuctionatorHEntry9_EntryText"
        kind: "FontString"
        text: "Sash of acient"
        wowParent: "AuctionatorHEntry9"
        anchors.left: auctionatorHEntry9.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry9.verticalCenter
        width: 174
        height: 16
    }

    Part {
        id: auctionatorMessage2Frame
        name: "AuctionatorMessage2Frame"
        kind: "FontString"
        wowParent: "Atr_Main_Panel"
        anchors.horizontalCenter: atr_Main_Panel.horizontalCenter
        anchors.horizontalCenterOffset: 18
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 65
        width: 265.7
        height: 100
    }

    Part {
        id: auctionatorScrollFrame
        name: "AuctionatorScrollFrame"
        kind: "ScrollFrame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 10
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 188
        width: 588
        height: 196
    }

    Part {
        id: auctionatorScrollFrameScrollBar
        name: "AuctionatorScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "AuctionatorScrollFrame"
        anchors.left: auctionatorScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: auctionatorScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 164
    }

    Part {
        id: auctionatorScrollFrameScrollBarDiabolicTrack
        name: "AuctionatorScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "AuctionatorScrollFrameScrollBar"
        anchors.horizontalCenter: auctionatorScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: auctionatorScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 198
    }

    Part {
        id: auctionatorScrollFrameScrollBarScrollDownButton
        name: "AuctionatorScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "AuctionatorScrollFrameScrollBar"
        anchors.horizontalCenter: auctionatorScrollFrameScrollBar.horizontalCenter
        anchors.top: auctionatorScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: auctionatorScrollFrameScrollBarScrollUpButton
        name: "AuctionatorScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "AuctionatorScrollFrameScrollBar"
        anchors.horizontalCenter: auctionatorScrollFrameScrollBar.horizontalCenter
        anchors.bottom: auctionatorScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: auctionatorScrollFrameScrollChildFrame
        name: "AuctionatorScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "AuctionatorScrollFrame"
        anchors.left: auctionatorScrollFrame.left
        anchors.top: auctionatorScrollFrame.top
        width: 300
        height: 512
    }

    Part {
        id: auctionatorTitle
        name: "AuctionatorTitle"
        kind: "FontString"
        text: "Auctionator+ - Buy"
        wowParent: "Atr_Main_Panel"
        anchors.horizontalCenter: atr_Main_Panel.horizontalCenter
        anchors.horizontalCenterOffset: -90
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: -7
        width: 116.4
        height: 12.2
    }

    Part {
        id: auctionsBidSort
        name: "AuctionsBidSort"
        kind: "Button"
        text: "Current Bid"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsHighBidderSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: auctionsHighBidderSort.verticalCenter
        width: 193
        height: 19
    }

    Part {
        id: auctionsBidSortText
        name: "AuctionsBidSortText"
        kind: "FontString"
        text: "Current Bid"
        wowParent: "AuctionsBidSort"
        anchors.left: auctionsBidSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsBidSort.verticalCenter
        width: 57.5
        height: 10.1
    }

    Part {
        id: auctionsButton1
        name: "AuctionsButton1"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 224
        anchors.top: auctionFrame.top
        anchors.topMargin: 71
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton1BuyoutFrame
        name: "AuctionsButton1BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton1"
        anchors.right: auctionsButton1MoneyFrame.right
        anchors.top: auctionsButton1MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton1BuyoutFrameMoney
        name: "AuctionsButton1BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton1BuyoutFrame"
        anchors.right: auctionsButton1BuyoutFrame.right
        anchors.verticalCenter: auctionsButton1BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton1BuyoutFrameMoneyCopperButton
        name: "AuctionsButton1BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton1BuyoutFrameMoney"
        anchors.right: auctionsButton1BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton1BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton1BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton1BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton1BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton1BuyoutFrameMoneyGoldButton
        name: "AuctionsButton1BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton1BuyoutFrameMoney"
        anchors.right: auctionsButton1BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton1BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton1BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton1BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton1BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton1BuyoutFrameMoneySilverButton
        name: "AuctionsButton1BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "80"
        wowParent: "AuctionsButton1BuyoutFrameMoney"
        anchors.right: auctionsButton1BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton1BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton1BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "80"
        wowParent: "AuctionsButton1BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton1BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton1BuyoutFrameText
        name: "AuctionsButton1BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton1BuyoutFrame"
        anchors.left: auctionsButton1BuyoutFrame.left
        anchors.top: auctionsButton1BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Part {
        id: auctionsButton1ClosingTime
        name: "AuctionsButton1ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton1.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton1ClosingTimeText
        name: "AuctionsButton1ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton1ClosingTime"
        anchors.left: auctionsButton1ClosingTime.left
        anchors.top: auctionsButton1ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton1HighBidder
        name: "AuctionsButton1HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton1.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton1Item
        name: "AuctionsButton1Item"
        kind: "Button"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.top: auctionsButton1.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton1ItemCount
        name: "AuctionsButton1ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "AuctionsButton1Item"
        anchors.right: auctionsButton1Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton1Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton1MoneyFrame
        name: "AuctionsButton1MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton1"
        anchors.right: auctionsButton1.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton1.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton1MoneyFrameCopperButton
        name: "AuctionsButton1MoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton1MoneyFrame"
        anchors.right: auctionsButton1MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton1MoneyFrameCopperButtonText
        name: "AuctionsButton1MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton1MoneyFrameCopperButton"
        anchors.right: auctionsButton1MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton1MoneyFrameGoldButton
        name: "AuctionsButton1MoneyFrameGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton1MoneyFrame"
        anchors.right: auctionsButton1MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton1MoneyFrameGoldButtonText
        name: "AuctionsButton1MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton1MoneyFrameGoldButton"
        anchors.right: auctionsButton1MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton1MoneyFrameSilverButton
        name: "AuctionsButton1MoneyFrameSilverButton"
        kind: "Button"
        text: "31"
        wowParent: "AuctionsButton1MoneyFrame"
        anchors.right: auctionsButton1MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton1MoneyFrameSilverButtonText
        name: "AuctionsButton1MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "31"
        wowParent: "AuctionsButton1MoneyFrameSilverButton"
        anchors.right: auctionsButton1MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    Part {
        id: auctionsButton1Name
        name: "AuctionsButton1Name"
        kind: "FontString"
        text: "Packet of Tharlendris Seeds"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton1.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton2
        name: "AuctionsButton2"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton1.left
        anchors.top: auctionsButton1.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton2BuyoutFrame
        name: "AuctionsButton2BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton2"
        anchors.right: auctionsButton2MoneyFrame.right
        anchors.top: auctionsButton2MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton2BuyoutFrameMoney
        name: "AuctionsButton2BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton2BuyoutFrame"
        anchors.right: auctionsButton2BuyoutFrame.right
        anchors.verticalCenter: auctionsButton2BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton2BuyoutFrameMoneyCopperButton
        name: "AuctionsButton2BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton2BuyoutFrameMoney"
        anchors.right: auctionsButton2BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton2BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton2BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton2BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton2BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton2BuyoutFrameMoneyGoldButton
        name: "AuctionsButton2BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton2BuyoutFrameMoney"
        anchors.right: auctionsButton2BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton2BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton2BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton2BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton2BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton2BuyoutFrameMoneySilverButton
        name: "AuctionsButton2BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "80"
        wowParent: "AuctionsButton2BuyoutFrameMoney"
        anchors.right: auctionsButton2BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton2BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton2BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "80"
        wowParent: "AuctionsButton2BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton2BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton2BuyoutFrameText
        name: "AuctionsButton2BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton2BuyoutFrame"
        anchors.left: auctionsButton2BuyoutFrame.left
        anchors.top: auctionsButton2BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Part {
        id: auctionsButton2ClosingTime
        name: "AuctionsButton2ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton2.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton2ClosingTimeText
        name: "AuctionsButton2ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton2ClosingTime"
        anchors.left: auctionsButton2ClosingTime.left
        anchors.top: auctionsButton2ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton2HighBidder
        name: "AuctionsButton2HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton2.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton2Item
        name: "AuctionsButton2Item"
        kind: "Button"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.top: auctionsButton2.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton2ItemCount
        name: "AuctionsButton2ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "AuctionsButton2Item"
        anchors.right: auctionsButton2Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton2Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton2MoneyFrame
        name: "AuctionsButton2MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton2"
        anchors.right: auctionsButton2.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton2.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton2MoneyFrameCopperButton
        name: "AuctionsButton2MoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton2MoneyFrame"
        anchors.right: auctionsButton2MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton2MoneyFrameCopperButtonText
        name: "AuctionsButton2MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton2MoneyFrameCopperButton"
        anchors.right: auctionsButton2MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton2MoneyFrameGoldButton
        name: "AuctionsButton2MoneyFrameGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton2MoneyFrame"
        anchors.right: auctionsButton2MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton2MoneyFrameGoldButtonText
        name: "AuctionsButton2MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton2MoneyFrameGoldButton"
        anchors.right: auctionsButton2MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton2MoneyFrameSilverButton
        name: "AuctionsButton2MoneyFrameSilverButton"
        kind: "Button"
        text: "31"
        wowParent: "AuctionsButton2MoneyFrame"
        anchors.right: auctionsButton2MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton2MoneyFrameSilverButtonText
        name: "AuctionsButton2MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "31"
        wowParent: "AuctionsButton2MoneyFrameSilverButton"
        anchors.right: auctionsButton2MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    Part {
        id: auctionsButton2Name
        name: "AuctionsButton2Name"
        kind: "FontString"
        text: "Packet of Tharlendris Seeds"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton2.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton3
        name: "AuctionsButton3"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton2.left
        anchors.top: auctionsButton2.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton3BuyoutFrame
        name: "AuctionsButton3BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton3"
        anchors.right: auctionsButton3MoneyFrame.right
        anchors.top: auctionsButton3MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton3BuyoutFrameMoney
        name: "AuctionsButton3BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton3BuyoutFrame"
        anchors.right: auctionsButton3BuyoutFrame.right
        anchors.verticalCenter: auctionsButton3BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton3BuyoutFrameMoneyCopperButton
        name: "AuctionsButton3BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton3BuyoutFrameMoney"
        anchors.right: auctionsButton3BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton3BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton3BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton3BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton3BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton3BuyoutFrameMoneyGoldButton
        name: "AuctionsButton3BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "8"
        wowParent: "AuctionsButton3BuyoutFrameMoney"
        anchors.right: auctionsButton3BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton3BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton3BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "8"
        wowParent: "AuctionsButton3BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton3BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton3BuyoutFrameMoneySilverButton
        name: "AuctionsButton3BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "82"
        wowParent: "AuctionsButton3BuyoutFrameMoney"
        anchors.right: auctionsButton3BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton3BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton3BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "82"
        wowParent: "AuctionsButton3BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton3BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton3BuyoutFrameText
        name: "AuctionsButton3BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton3BuyoutFrame"
        anchors.left: auctionsButton3BuyoutFrame.left
        anchors.top: auctionsButton3BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Part {
        id: auctionsButton3ClosingTime
        name: "AuctionsButton3ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton3.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton3ClosingTimeText
        name: "AuctionsButton3ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton3ClosingTime"
        anchors.left: auctionsButton3ClosingTime.left
        anchors.top: auctionsButton3ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton3HighBidder
        name: "AuctionsButton3HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton3.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton3Item
        name: "AuctionsButton3Item"
        kind: "Button"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.top: auctionsButton3.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton3ItemCount
        name: "AuctionsButton3ItemCount"
        kind: "FontString"
        text: "18"
        wowParent: "AuctionsButton3Item"
        anchors.right: auctionsButton3Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton3Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton3MoneyFrame
        name: "AuctionsButton3MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton3"
        anchors.right: auctionsButton3.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton3.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton3MoneyFrameCopperButton
        name: "AuctionsButton3MoneyFrameCopperButton"
        kind: "Button"
        text: "90"
        wowParent: "AuctionsButton3MoneyFrame"
        anchors.right: auctionsButton3MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton3MoneyFrameCopperButtonText
        name: "AuctionsButton3MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "90"
        wowParent: "AuctionsButton3MoneyFrameCopperButton"
        anchors.right: auctionsButton3MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton3MoneyFrameGoldButton
        name: "AuctionsButton3MoneyFrameGoldButton"
        kind: "Button"
        text: "8"
        wowParent: "AuctionsButton3MoneyFrame"
        anchors.right: auctionsButton3MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton3MoneyFrameGoldButtonText
        name: "AuctionsButton3MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "8"
        wowParent: "AuctionsButton3MoneyFrameGoldButton"
        anchors.right: auctionsButton3MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton3MoneyFrameSilverButton
        name: "AuctionsButton3MoneyFrameSilverButton"
        kind: "Button"
        text: "37"
        wowParent: "AuctionsButton3MoneyFrame"
        anchors.right: auctionsButton3MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton3MoneyFrameSilverButtonText
        name: "AuctionsButton3MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "37"
        wowParent: "AuctionsButton3MoneyFrameSilverButton"
        anchors.right: auctionsButton3MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton3Name
        name: "AuctionsButton3Name"
        kind: "FontString"
        text: "Packet of Tharlendris Seeds"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton3.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton4
        name: "AuctionsButton4"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton3.left
        anchors.top: auctionsButton3.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton4BuyoutFrame
        name: "AuctionsButton4BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton4"
        anchors.right: auctionsButton4MoneyFrame.right
        anchors.top: auctionsButton4MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton4BuyoutFrameMoney
        name: "AuctionsButton4BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton4BuyoutFrame"
        anchors.right: auctionsButton4BuyoutFrame.right
        anchors.verticalCenter: auctionsButton4BuyoutFrame.verticalCenter
        width: 77.8
        height: 13
    }

    Part {
        id: auctionsButton4BuyoutFrameMoneyCopperButton
        name: "AuctionsButton4BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton4BuyoutFrameMoney"
        anchors.right: auctionsButton4BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton4BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton4BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton4BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton4BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton4BuyoutFrameMoneySilverButton
        name: "AuctionsButton4BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "74"
        wowParent: "AuctionsButton4BuyoutFrameMoney"
        anchors.right: auctionsButton4BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionsButton4BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton4BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "74"
        wowParent: "AuctionsButton4BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton4BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton4BuyoutFrameText
        name: "AuctionsButton4BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton4BuyoutFrame"
        anchors.left: auctionsButton4BuyoutFrame.left
        anchors.top: auctionsButton4BuyoutFrame.top
        width: 117.2
        height: 13
    }

    Part {
        id: auctionsButton4ClosingTime
        name: "AuctionsButton4ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton4.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton4ClosingTimeText
        name: "AuctionsButton4ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton4ClosingTime"
        anchors.left: auctionsButton4ClosingTime.left
        anchors.top: auctionsButton4ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton4HighBidder
        name: "AuctionsButton4HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton4.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton4Item
        name: "AuctionsButton4Item"
        kind: "Button"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.top: auctionsButton4.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton4MoneyFrame
        name: "AuctionsButton4MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton4"
        anchors.right: auctionsButton4.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton4.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 77.8
        height: 13
    }

    Part {
        id: auctionsButton4MoneyFrameCopperButton
        name: "AuctionsButton4MoneyFrameCopperButton"
        kind: "Button"
        text: "30"
        wowParent: "AuctionsButton4MoneyFrame"
        anchors.right: auctionsButton4MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton4MoneyFrameCopperButtonText
        name: "AuctionsButton4MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "30"
        wowParent: "AuctionsButton4MoneyFrameCopperButton"
        anchors.right: auctionsButton4MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton4MoneyFrameSilverButton
        name: "AuctionsButton4MoneyFrameSilverButton"
        kind: "Button"
        text: "70"
        wowParent: "AuctionsButton4MoneyFrame"
        anchors.right: auctionsButton4MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton4MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionsButton4MoneyFrameSilverButtonText
        name: "AuctionsButton4MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "70"
        wowParent: "AuctionsButton4MoneyFrameSilverButton"
        anchors.right: auctionsButton4MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton4Name
        name: "AuctionsButton4Name"
        kind: "FontString"
        text: "Un'Goro Soil"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton4.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton5
        name: "AuctionsButton5"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton4.left
        anchors.top: auctionsButton4.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton5BuyoutFrame
        name: "AuctionsButton5BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton5"
        anchors.right: auctionsButton5MoneyFrame.right
        anchors.top: auctionsButton5MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton5BuyoutFrameMoney
        name: "AuctionsButton5BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton5BuyoutFrame"
        anchors.right: auctionsButton5BuyoutFrame.right
        anchors.verticalCenter: auctionsButton5BuyoutFrame.verticalCenter
        width: 71.3
        height: 13
    }

    Part {
        id: auctionsButton5BuyoutFrameMoneyCopperButton
        name: "AuctionsButton5BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "85"
        wowParent: "AuctionsButton5BuyoutFrameMoney"
        anchors.right: auctionsButton5BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton5BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton5BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "85"
        wowParent: "AuctionsButton5BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton5BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: auctionsButton5BuyoutFrameMoneySilverButton
        name: "AuctionsButton5BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton5BuyoutFrameMoney"
        anchors.right: auctionsButton5BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton5BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton5BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton5BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton5BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton5BuyoutFrameText
        name: "AuctionsButton5BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton5BuyoutFrame"
        anchors.left: auctionsButton5BuyoutFrame.left
        anchors.top: auctionsButton5BuyoutFrame.top
        width: 123.6
        height: 13
    }

    Part {
        id: auctionsButton5ClosingTime
        name: "AuctionsButton5ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton5.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton5ClosingTimeText
        name: "AuctionsButton5ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton5ClosingTime"
        anchors.left: auctionsButton5ClosingTime.left
        anchors.top: auctionsButton5ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton5HighBidder
        name: "AuctionsButton5HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton5.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton5Item
        name: "AuctionsButton5Item"
        kind: "Button"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.top: auctionsButton5.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton5MoneyFrame
        name: "AuctionsButton5MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton5"
        anchors.right: auctionsButton5.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton5.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 71.3
        height: 13
    }

    Part {
        id: auctionsButton5MoneyFrameCopperButton
        name: "AuctionsButton5MoneyFrameCopperButton"
        kind: "Button"
        text: "35"
        wowParent: "AuctionsButton5MoneyFrame"
        anchors.right: auctionsButton5MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton5MoneyFrameCopperButtonText
        name: "AuctionsButton5MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "35"
        wowParent: "AuctionsButton5MoneyFrameCopperButton"
        anchors.right: auctionsButton5MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: auctionsButton5MoneyFrameSilverButton
        name: "AuctionsButton5MoneyFrameSilverButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton5MoneyFrame"
        anchors.right: auctionsButton5MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton5MoneyFrameCopperButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton5MoneyFrameSilverButtonText
        name: "AuctionsButton5MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton5MoneyFrameSilverButton"
        anchors.right: auctionsButton5MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton5Name
        name: "AuctionsButton5Name"
        kind: "FontString"
        text: "Elixir of Detect Undead"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton5.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton6
        name: "AuctionsButton6"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton5.left
        anchors.top: auctionsButton5.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton6BuyoutFrame
        name: "AuctionsButton6BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton6"
        anchors.right: auctionsButton6MoneyFrame.right
        anchors.top: auctionsButton6MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton6BuyoutFrameMoney
        name: "AuctionsButton6BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton6BuyoutFrame"
        anchors.right: auctionsButton6BuyoutFrame.right
        anchors.verticalCenter: auctionsButton6BuyoutFrame.verticalCenter
        width: 77.8
        height: 13
    }

    Part {
        id: auctionsButton6BuyoutFrameMoneyCopperButton
        name: "AuctionsButton6BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton6BuyoutFrameMoney"
        anchors.right: auctionsButton6BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton6BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton6BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton6BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton6BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton6BuyoutFrameMoneySilverButton
        name: "AuctionsButton6BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "77"
        wowParent: "AuctionsButton6BuyoutFrameMoney"
        anchors.right: auctionsButton6BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionsButton6BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton6BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "77"
        wowParent: "AuctionsButton6BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton6BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton6BuyoutFrameText
        name: "AuctionsButton6BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton6BuyoutFrame"
        anchors.left: auctionsButton6BuyoutFrame.left
        anchors.top: auctionsButton6BuyoutFrame.top
        width: 117.2
        height: 13
    }

    Part {
        id: auctionsButton6ClosingTime
        name: "AuctionsButton6ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton6.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton6ClosingTimeText
        name: "AuctionsButton6ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton6ClosingTime"
        anchors.left: auctionsButton6ClosingTime.left
        anchors.top: auctionsButton6ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton6HighBidder
        name: "AuctionsButton6HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton6.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton6Item
        name: "AuctionsButton6Item"
        kind: "Button"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.top: auctionsButton6.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton6MoneyFrame
        name: "AuctionsButton6MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton6"
        anchors.right: auctionsButton6.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton6.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 77.8
        height: 13
    }

    Part {
        id: auctionsButton6MoneyFrameCopperButton
        name: "AuctionsButton6MoneyFrameCopperButton"
        kind: "Button"
        text: "15"
        wowParent: "AuctionsButton6MoneyFrame"
        anchors.right: auctionsButton6MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton6MoneyFrameCopperButtonText
        name: "AuctionsButton6MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "15"
        wowParent: "AuctionsButton6MoneyFrameCopperButton"
        anchors.right: auctionsButton6MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: auctionsButton6MoneyFrameSilverButton
        name: "AuctionsButton6MoneyFrameSilverButton"
        kind: "Button"
        text: "73"
        wowParent: "AuctionsButton6MoneyFrame"
        anchors.right: auctionsButton6MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton6MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionsButton6MoneyFrameSilverButtonText
        name: "AuctionsButton6MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "73"
        wowParent: "AuctionsButton6MoneyFrameSilverButton"
        anchors.right: auctionsButton6MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton6Name
        name: "AuctionsButton6Name"
        kind: "FontString"
        text: "Elixir of Greater Agility"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton6.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton7
        name: "AuctionsButton7"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton6.left
        anchors.top: auctionsButton6.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton7BuyoutFrame
        name: "AuctionsButton7BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton7"
        anchors.right: auctionsButton7MoneyFrame.right
        anchors.top: auctionsButton7MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton7BuyoutFrameMoney
        name: "AuctionsButton7BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton7BuyoutFrame"
        anchors.right: auctionsButton7BuyoutFrame.right
        anchors.verticalCenter: auctionsButton7BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton7BuyoutFrameMoneyCopperButton
        name: "AuctionsButton7BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton7BuyoutFrameMoney"
        anchors.right: auctionsButton7BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton7BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton7BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton7BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton7BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton7BuyoutFrameMoneyGoldButton
        name: "AuctionsButton7BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton7BuyoutFrameMoney"
        anchors.right: auctionsButton7BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton7BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton7BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton7BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton7BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton7BuyoutFrameMoneySilverButton
        name: "AuctionsButton7BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "96"
        wowParent: "AuctionsButton7BuyoutFrameMoney"
        anchors.right: auctionsButton7BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton7BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton7BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "96"
        wowParent: "AuctionsButton7BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton7BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton7BuyoutFrameText
        name: "AuctionsButton7BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton7BuyoutFrame"
        anchors.left: auctionsButton7BuyoutFrame.left
        anchors.top: auctionsButton7BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Part {
        id: auctionsButton7ClosingTime
        name: "AuctionsButton7ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton7.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton7ClosingTimeText
        name: "AuctionsButton7ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton7ClosingTime"
        anchors.left: auctionsButton7ClosingTime.left
        anchors.top: auctionsButton7ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton7HighBidder
        name: "AuctionsButton7HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton7.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton7Item
        name: "AuctionsButton7Item"
        kind: "Button"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.top: auctionsButton7.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton7ItemCount
        name: "AuctionsButton7ItemCount"
        kind: "FontString"
        text: "2"
        wowParent: "AuctionsButton7Item"
        anchors.right: auctionsButton7Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton7Item.bottom
        anchors.bottomMargin: 2
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton7MoneyFrame
        name: "AuctionsButton7MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton7"
        anchors.right: auctionsButton7.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton7.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton7MoneyFrameCopperButton
        name: "AuctionsButton7MoneyFrameCopperButton"
        kind: "Button"
        text: "20"
        wowParent: "AuctionsButton7MoneyFrame"
        anchors.right: auctionsButton7MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton7MoneyFrameCopperButtonText
        name: "AuctionsButton7MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "20"
        wowParent: "AuctionsButton7MoneyFrameCopperButton"
        anchors.right: auctionsButton7MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton7MoneyFrameGoldButton
        name: "AuctionsButton7MoneyFrameGoldButton"
        kind: "Button"
        text: "9"
        wowParent: "AuctionsButton7MoneyFrame"
        anchors.right: auctionsButton7MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton7MoneyFrameGoldButtonText
        name: "AuctionsButton7MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "9"
        wowParent: "AuctionsButton7MoneyFrameGoldButton"
        anchors.right: auctionsButton7MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton7MoneyFrameSilverButton
        name: "AuctionsButton7MoneyFrameSilverButton"
        kind: "Button"
        text: "46"
        wowParent: "AuctionsButton7MoneyFrame"
        anchors.right: auctionsButton7MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton7MoneyFrameSilverButtonText
        name: "AuctionsButton7MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "46"
        wowParent: "AuctionsButton7MoneyFrameSilverButton"
        anchors.right: auctionsButton7MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton7Name
        name: "AuctionsButton7Name"
        kind: "FontString"
        text: "Elixir of Giants"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton7.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton8
        name: "AuctionsButton8"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton7.left
        anchors.top: auctionsButton7.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton8BuyoutFrame
        name: "AuctionsButton8BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton8"
        anchors.right: auctionsButton8MoneyFrame.right
        anchors.top: auctionsButton8MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton8BuyoutFrameMoney
        name: "AuctionsButton8BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton8BuyoutFrame"
        anchors.right: auctionsButton8BuyoutFrame.right
        anchors.verticalCenter: auctionsButton8BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton8BuyoutFrameMoneyCopperButton
        name: "AuctionsButton8BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton8BuyoutFrameMoney"
        anchors.right: auctionsButton8BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton8BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton8BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton8BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton8BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton8BuyoutFrameMoneyGoldButton
        name: "AuctionsButton8BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "6"
        wowParent: "AuctionsButton8BuyoutFrameMoney"
        anchors.right: auctionsButton8BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton8BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton8BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "6"
        wowParent: "AuctionsButton8BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton8BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton8BuyoutFrameMoneySilverButton
        name: "AuctionsButton8BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "92"
        wowParent: "AuctionsButton8BuyoutFrameMoney"
        anchors.right: auctionsButton8BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton8BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton8BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "92"
        wowParent: "AuctionsButton8BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton8BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton8BuyoutFrameText
        name: "AuctionsButton8BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton8BuyoutFrame"
        anchors.left: auctionsButton8BuyoutFrame.left
        anchors.top: auctionsButton8BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Part {
        id: auctionsButton8ClosingTime
        name: "AuctionsButton8ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton8.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton8ClosingTimeText
        name: "AuctionsButton8ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton8ClosingTime"
        anchors.left: auctionsButton8ClosingTime.left
        anchors.top: auctionsButton8ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton8HighBidder
        name: "AuctionsButton8HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton8.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton8Item
        name: "AuctionsButton8Item"
        kind: "Button"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.top: auctionsButton8.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton8ItemCount
        name: "AuctionsButton8ItemCount"
        kind: "FontString"
        text: "2"
        wowParent: "AuctionsButton8Item"
        anchors.right: auctionsButton8Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton8Item.bottom
        anchors.bottomMargin: 2
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton8MoneyFrame
        name: "AuctionsButton8MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton8"
        anchors.right: auctionsButton8.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton8.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Part {
        id: auctionsButton8MoneyFrameCopperButton
        name: "AuctionsButton8MoneyFrameCopperButton"
        kind: "Button"
        text: "40"
        wowParent: "AuctionsButton8MoneyFrame"
        anchors.right: auctionsButton8MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton8MoneyFrameCopperButtonText
        name: "AuctionsButton8MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "40"
        wowParent: "AuctionsButton8MoneyFrameCopperButton"
        anchors.right: auctionsButton8MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton8MoneyFrameGoldButton
        name: "AuctionsButton8MoneyFrameGoldButton"
        kind: "Button"
        text: "6"
        wowParent: "AuctionsButton8MoneyFrame"
        anchors.right: auctionsButton8MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    Part {
        id: auctionsButton8MoneyFrameGoldButtonText
        name: "AuctionsButton8MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "6"
        wowParent: "AuctionsButton8MoneyFrameGoldButton"
        anchors.right: auctionsButton8MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton8MoneyFrameSilverButton
        name: "AuctionsButton8MoneyFrameSilverButton"
        kind: "Button"
        text: "57"
        wowParent: "AuctionsButton8MoneyFrame"
        anchors.right: auctionsButton8MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton8MoneyFrameSilverButtonText
        name: "AuctionsButton8MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "57"
        wowParent: "AuctionsButton8MoneyFrameSilverButton"
        anchors.right: auctionsButton8MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton8Name
        name: "AuctionsButton8Name"
        kind: "FontString"
        text: "Elixir of Demonslaying"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton8.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsButton9
        name: "AuctionsButton9"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton8.left
        anchors.top: auctionsButton8.bottom
        width: 576
        height: 37
    }

    Part {
        id: auctionsButton9BuyoutFrame
        name: "AuctionsButton9BuyoutFrame"
        kind: "Frame"
        wowParent: "AuctionsButton9"
        anchors.right: auctionsButton9MoneyFrame.right
        anchors.top: auctionsButton9MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Part {
        id: auctionsButton9BuyoutFrameMoney
        name: "AuctionsButton9BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "AuctionsButton9BuyoutFrame"
        anchors.right: auctionsButton9BuyoutFrame.right
        anchors.verticalCenter: auctionsButton9BuyoutFrame.verticalCenter
        width: 77.8
        height: 13
    }

    Part {
        id: auctionsButton9BuyoutFrameMoneyCopperButton
        name: "AuctionsButton9BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "AuctionsButton9BuyoutFrameMoney"
        anchors.right: auctionsButton9BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton9BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton9BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "AuctionsButton9BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton9BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: auctionsButton9BuyoutFrameMoneySilverButton
        name: "AuctionsButton9BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "49"
        wowParent: "AuctionsButton9BuyoutFrameMoney"
        anchors.right: auctionsButton9BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoneyCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionsButton9BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton9BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "49"
        wowParent: "AuctionsButton9BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton9BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton9BuyoutFrameText
        name: "AuctionsButton9BuyoutFrameText"
        kind: "Frame"
        wowParent: "AuctionsButton9BuyoutFrame"
        anchors.left: auctionsButton9BuyoutFrame.left
        anchors.top: auctionsButton9BuyoutFrame.top
        width: 117.2
        height: 13
    }

    Part {
        id: auctionsButton9ClosingTime
        name: "AuctionsButton9ClosingTime"
        kind: "Frame"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton9.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton9ClosingTimeText
        name: "AuctionsButton9ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "AuctionsButton9ClosingTime"
        anchors.left: auctionsButton9ClosingTime.left
        anchors.top: auctionsButton9ClosingTime.top
        width: 65
        height: 28
    }

    Part {
        id: auctionsButton9HighBidder
        name: "AuctionsButton9HighBidder"
        kind: "FontString"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton9.top
        width: 104
        height: 28
    }

    Part {
        id: auctionsButton9Item
        name: "AuctionsButton9Item"
        kind: "Button"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.top: auctionsButton9.top
        width: 32
        height: 32
    }

    Part {
        id: auctionsButton9MoneyFrame
        name: "AuctionsButton9MoneyFrame"
        kind: "Frame"
        wowParent: "AuctionsButton9"
        anchors.right: auctionsButton9.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton9.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 77.8
        height: 13
    }

    Part {
        id: auctionsButton9MoneyFrameCopperButton
        name: "AuctionsButton9MoneyFrameCopperButton"
        kind: "Button"
        text: "55"
        wowParent: "AuctionsButton9MoneyFrame"
        anchors.right: auctionsButton9MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: auctionsButton9MoneyFrameCopperButtonText
        name: "AuctionsButton9MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "55"
        wowParent: "AuctionsButton9MoneyFrameCopperButton"
        anchors.right: auctionsButton9MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: auctionsButton9MoneyFrameSilverButton
        name: "AuctionsButton9MoneyFrameSilverButton"
        kind: "Button"
        text: "46"
        wowParent: "AuctionsButton9MoneyFrame"
        anchors.right: auctionsButton9MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton9MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    Part {
        id: auctionsButton9MoneyFrameSilverButtonText
        name: "AuctionsButton9MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "46"
        wowParent: "AuctionsButton9MoneyFrameSilverButton"
        anchors.right: auctionsButton9MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: auctionsButton9Name
        name: "AuctionsButton9Name"
        kind: "FontString"
        text: "Scroll of Spirit III"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton9.top
        width: 142
        height: 28
    }

    Part {
        id: auctionsBuyoutText
        name: "AuctionsBuyoutText"
        kind: "FontString"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPrice.left
        anchors.leftMargin: -10
        anchors.bottom: buyoutPrice.top
        anchors.bottomMargin: 3
        width: 114.9
        height: 10.1
    }

    Part {
        id: auctionsCancelAuctionButton
        name: "AuctionsCancelAuctionButton"
        kind: "Button"
        text: "Cancel Auction"
        wowParent: "AuctionFrameAuctions"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 90.9
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 121.1
        height: 22
    }

    Part {
        id: auctionsCancelAuctionButtonText
        name: "AuctionsCancelAuctionButtonText"
        kind: "FontString"
        text: "Cancel Auction"
        wowParent: "AuctionsCancelAuctionButton"
        anchors.horizontalCenter: auctionsCancelAuctionButton.horizontalCenter
        anchors.verticalCenter: auctionsCancelAuctionButton.verticalCenter
        width: 81.2
        height: 10.1
    }

    Part {
        id: auctionsCloseButton
        name: "AuctionsCloseButton"
        kind: "Button"
        text: "Close"
        wowParent: "AuctionFrameAuctions"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 8
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76.9
        height: 22
    }

    Part {
        id: auctionsCloseButtonText
        name: "AuctionsCloseButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "AuctionsCloseButton"
        anchors.horizontalCenter: auctionsCloseButton.horizontalCenter
        anchors.verticalCenter: auctionsCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Part {
        id: auctionsCreateAuctionButton
        name: "AuctionsCreateAuctionButton"
        kind: "Button"
        text: "Create Auction"
        wowParent: "AuctionFrameAuctions"
        style: "Button"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 2
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 41
        width: 191
        height: 20
    }

    Part {
        id: auctionsCreateAuctionButtonText
        name: "AuctionsCreateAuctionButtonText"
        kind: "FontString"
        text: "Create Auction"
        wowParent: "AuctionsCreateAuctionButton"
        anchors.horizontalCenter: auctionsCreateAuctionButton.horizontalCenter
        anchors.verticalCenter: auctionsCreateAuctionButton.verticalCenter
        width: 81.2
        height: 10.1
    }

    Part {
        id: auctionsDepositMoneyFrame
        name: "AuctionsDepositMoneyFrame"
        kind: "Frame"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsDepositText.right
        anchors.leftMargin: 5
        anchors.verticalCenter: auctionsDepositText.verticalCenter
        anchors.verticalCenterOffset: 1
        width: 13
        height: 13
    }

    Part {
        id: auctionsDepositMoneyFrameGoldButton
        name: "AuctionsDepositMoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        wowParent: "AuctionsDepositMoneyFrame"
        anchors.right: auctionsDepositMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsDepositMoneyFrameSilverButton.verticalCenter
        width: 20.9
        height: 13
    }

    Part {
        id: auctionsDepositMoneyFrameGoldButtonText
        name: "AuctionsDepositMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "AuctionsDepositMoneyFrameGoldButton"
        anchors.right: auctionsDepositMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsDepositMoneyFrameGoldButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Part {
        id: auctionsDepositMoneyFrameSilverButton
        name: "AuctionsDepositMoneyFrameSilverButton"
        kind: "Button"
        text: "65"
        wowParent: "AuctionsDepositMoneyFrame"
        anchors.right: auctionsDepositMoneyFrameCopperButton.right
        anchors.verticalCenter: auctionsDepositMoneyFrameCopperButton.verticalCenter
        width: 29.5
        height: 13
    }

    Part {
        id: auctionsDepositMoneyFrameSilverButtonText
        name: "AuctionsDepositMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "65"
        wowParent: "AuctionsDepositMoneyFrameSilverButton"
        anchors.right: auctionsDepositMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsDepositMoneyFrameSilverButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: auctionsDepositText
        name: "AuctionsDepositText"
        kind: "FontString"
        text: "Deposit:"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 9
        anchors.verticalCenter: auctionFrameAuctions.bottom
        anchors.verticalCenterOffset: -77
        width: 50.3
        height: 12.2
    }

    Part {
        id: auctionsDurationSort
        name: "AuctionsDurationSort"
        kind: "Button"
        text: "Time Left"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsQualitySort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: auctionsQualitySort.verticalCenter
        width: 100
        height: 19
    }

    Part {
        id: auctionsDurationSortText
        name: "AuctionsDurationSortText"
        kind: "FontString"
        text: "Time Left"
        wowParent: "AuctionsDurationSort"
        anchors.left: auctionsDurationSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsDurationSort.verticalCenter
        width: 48.1
        height: 10.1
    }

    Part {
        id: auctionsHighBidderSort
        name: "AuctionsHighBidderSort"
        kind: "Button"
        text: "High Bidder"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsDurationSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: auctionsDurationSort.verticalCenter
        width: 108
        height: 19
    }

    Part {
        id: auctionsHighBidderSortText
        name: "AuctionsHighBidderSortText"
        kind: "FontString"
        text: "High Bidder"
        wowParent: "AuctionsHighBidderSort"
        anchors.left: auctionsHighBidderSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsHighBidderSort.verticalCenter
        width: 61.1
        height: 10.1
    }

    Part {
        id: auctionsItemButton
        name: "AuctionsItemButton"
        kind: "Button"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 14
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 92
        width: 37
        height: 37
    }

    Part {
        id: auctionsItemButtonCount
        name: "AuctionsItemButtonCount"
        kind: "FontString"
        text: "100"
        wowParent: "AuctionsItemButton"
        anchors.right: auctionsItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsItemButton.bottom
        anchors.bottomMargin: 2
        width: 22.3
        height: 13.6
    }

    Part {
        id: auctionsItemButtonName
        name: "AuctionsItemButtonName"
        kind: "FontString"
        wowParent: "AuctionsItemButton"
        anchors.left: auctionsItemButton.right
        anchors.leftMargin: 5
        anchors.top: auctionsItemButton.top
        width: 124
        height: 30
    }

    Part {
        id: auctionsItemText
        name: "AuctionsItemText"
        kind: "FontString"
        text: "Auction Item"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 9
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 78
        width: 66.8
        height: 10.1
    }

    Part {
        id: auctionsNumStacksEntry
        name: "AuctionsNumStacksEntry"
        kind: "EditBox"
        text: "1"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsStackSizeEntry.left
        anchors.top: auctionsStackSizeEntry.bottom
        anchors.topMargin: 15
        width: 50
        height: 20
    }

    Part {
        id: auctionsNumStacksMaxButton
        name: "AuctionsNumStacksMaxButton"
        kind: "Button"
        text: "Maximum"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsNumStacksEntry.right
        anchors.leftMargin: 5
        anchors.verticalCenter: auctionsNumStacksEntry.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 21
    }

    Part {
        id: auctionsNumStacksMaxButtonText
        name: "AuctionsNumStacksMaxButtonText"
        kind: "FontString"
        text: "Maximum"
        wowParent: "AuctionsNumStacksMaxButton"
        anchors.horizontalCenter: auctionsNumStacksMaxButton.horizontalCenter
        anchors.verticalCenter: auctionsNumStacksMaxButton.verticalCenter
        width: 53.9
        height: 10.1
    }

    Part {
        id: auctionsQualitySort
        name: "AuctionsQualitySort"
        kind: "Button"
        text: "Rarity"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 224
        anchors.top: auctionFrame.top
        anchors.topMargin: 50
        width: 185
        height: 19
    }

    Part {
        id: auctionsQualitySortText
        name: "AuctionsQualitySortText"
        kind: "FontString"
        text: "Rarity"
        wowParent: "AuctionsQualitySort"
        anchors.left: auctionsQualitySort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsQualitySort.verticalCenter
        width: 29.5
        height: 10.1
    }

    Part {
        id: auctionsScrollFrame
        name: "AuctionsScrollFrame"
        kind: "ScrollFrame"
        wowParent: "AuctionFrameAuctions"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -803
        anchors.top: auctionFrame.top
        anchors.topMargin: 71
        width: 435
        height: 338
    }

    Part {
        id: auctionsScrollFrameScrollBar
        name: "AuctionsScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "AuctionsScrollFrame"
        style: "ScrollBar"
        anchors.left: auctionsScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: auctionsScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 306
    }

    Part {
        id: auctionsScrollFrameScrollBarDiabolicTrack
        name: "AuctionsScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "AuctionsScrollFrameScrollBar"
        anchors.horizontalCenter: auctionsScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: auctionsScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 340
    }

    Part {
        id: auctionsScrollFrameScrollBarScrollDownButton
        name: "AuctionsScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "AuctionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: auctionsScrollFrameScrollBar.horizontalCenter
        anchors.top: auctionsScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: auctionsScrollFrameScrollBarScrollUpButton
        name: "AuctionsScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "AuctionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: auctionsScrollFrameScrollBar.horizontalCenter
        anchors.bottom: auctionsScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: auctionsScrollFrameScrollChildFrame
        name: "AuctionsScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "AuctionsScrollFrame"
        anchors.left: auctionsScrollFrame.left
        anchors.top: auctionsScrollFrame.top
        width: 300
        height: 555
    }

    Part {
        id: auctionsStackSizeEntry
        name: "AuctionsStackSizeEntry"
        kind: "EditBox"
        text: "20"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 17
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 145
        width: 50
        height: 20
    }

    Part {
        id: auctionsStackSizeMaxButton
        name: "AuctionsStackSizeMaxButton"
        kind: "Button"
        text: "Maximum"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsStackSizeEntry.right
        anchors.leftMargin: 5
        anchors.verticalCenter: auctionsStackSizeEntry.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 21
    }

    Part {
        id: auctionsStackSizeMaxButtonText
        name: "AuctionsStackSizeMaxButtonText"
        kind: "FontString"
        text: "Maximum"
        wowParent: "AuctionsStackSizeMaxButton"
        anchors.horizontalCenter: auctionsStackSizeMaxButton.horizontalCenter
        anchors.verticalCenter: auctionsStackSizeMaxButton.verticalCenter
        width: 53.9
        height: 10.1
    }

    Part {
        id: auctionsTabText
        name: "AuctionsTabText"
        kind: "FontString"
        text: "Create Auction"
        wowParent: "AuctionFrameAuctions"
        anchors.horizontalCenter: auctionFrameAuctions.left
        anchors.horizontalCenterOffset: 105
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 53
        width: 76.2
        height: 10.1
    }

    Part {
        id: auctionsTitle
        name: "AuctionsTitle"
        kind: "FontString"
        text: "Padirac's Auctions"
        wowParent: "AuctionFrameAuctions"
        anchors.horizontalCenter: auctionFrameAuctions.horizontalCenter
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 18
        width: 114.2
        height: 12.2
    }

    Part {
        id: bidBidButton
        name: "BidBidButton"
        kind: "Button"
        text: "Bid"
        wowParent: "AuctionFrameBid"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 172
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76
        height: 22
    }

    Part {
        id: bidBidButtonText
        name: "BidBidButtonText"
        kind: "FontString"
        text: "Bid"
        wowParent: "BidBidButton"
        anchors.horizontalCenter: bidBidButton.horizontalCenter
        anchors.verticalCenter: bidBidButton.verticalCenter
        width: 17.3
        height: 10.1
    }

    Part {
        id: bidBidPrice
        name: "BidBidPrice"
        kind: "Frame"
        wowParent: "AuctionFrameBid"
        anchors.horizontalCenter: auctionFrameBid.horizontalCenter
        anchors.horizontalCenterOffset: -15
        anchors.bottom: auctionFrameBid.bottom
        anchors.bottomMargin: -8
        width: 176
        height: 18
    }

    Part {
        id: bidBidPriceCopper
        name: "BidBidPriceCopper"
        kind: "EditBox"
        wowParent: "BidBidPrice"
        anchors.left: bidBidPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: bidBidPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: bidBidPriceGold
        name: "BidBidPriceGold"
        kind: "EditBox"
        wowParent: "BidBidPrice"
        anchors.left: bidBidPrice.left
        anchors.top: bidBidPrice.top
        width: 58
        height: 20
    }

    Part {
        id: bidBidPriceSilver
        name: "BidBidPriceSilver"
        kind: "EditBox"
        wowParent: "BidBidPrice"
        anchors.left: bidBidPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: bidBidPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: bidBidSort
        name: "BidBidSort"
        kind: "Button"
        text: "Current Bid"
        wowParent: "AuctionFrameBid"
        anchors.left: bidStatusSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: bidStatusSort.verticalCenter
        width: 169
        height: 19
    }

    Part {
        id: bidBidSortText
        name: "BidBidSortText"
        kind: "FontString"
        text: "Current Bid"
        wowParent: "BidBidSort"
        anchors.left: bidBidSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidBidSort.verticalCenter
        width: 57.5
        height: 10.1
    }

    Part {
        id: bidBidText
        name: "BidBidText"
        kind: "FontString"
        text: "Bid"
        wowParent: "AuctionFrameBid"
        anchors.right: auctionFrameBid.horizontalCenter
        anchors.rightMargin: 115
        anchors.bottom: auctionFrameBid.bottom
        anchors.bottomMargin: -5
        width: 17.3
        height: 10.1
    }

    Part {
        id: bidBuyoutButton
        name: "BidBuyoutButton"
        kind: "Button"
        text: "Buyout"
        wowParent: "AuctionFrameBid"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 90
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76
        height: 22
    }

    Part {
        id: bidBuyoutButtonText
        name: "BidBuyoutButtonText"
        kind: "FontString"
        text: "Buyout"
        wowParent: "BidBuyoutButton"
        anchors.horizontalCenter: bidBuyoutButton.horizontalCenter
        anchors.verticalCenter: bidBuyoutButton.verticalCenter
        width: 38.8
        height: 10.1
    }

    Part {
        id: bidBuyoutSort
        name: "BidBuyoutSort"
        kind: "Button"
        text: "Buyout Price"
        wowParent: "AuctionFrameBid"
        anchors.left: bidDurationSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: bidDurationSort.verticalCenter
        width: 162
        height: 19
    }

    Part {
        id: bidBuyoutSortText
        name: "BidBuyoutSortText"
        kind: "FontString"
        text: "Buyout Price"
        wowParent: "BidBuyoutSort"
        anchors.left: bidBuyoutSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidBuyoutSort.verticalCenter
        width: 63.9
        height: 10.1
    }

    Part {
        id: bidCloseButton
        name: "BidCloseButton"
        kind: "Button"
        text: "Close"
        wowParent: "AuctionFrameBid"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 8
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76
        height: 22
    }

    Part {
        id: bidCloseButtonText
        name: "BidCloseButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "BidCloseButton"
        anchors.horizontalCenter: bidCloseButton.horizontalCenter
        anchors.verticalCenter: bidCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Part {
        id: bidDurationSort
        name: "BidDurationSort"
        kind: "Button"
        text: "Time Left"
        wowParent: "AuctionFrameBid"
        anchors.left: bidLevelSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: bidLevelSort.verticalCenter
        width: 79
        height: 19
    }

    Part {
        id: bidDurationSortText
        name: "BidDurationSortText"
        kind: "FontString"
        text: "Time Left"
        wowParent: "BidDurationSort"
        anchors.left: bidDurationSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidDurationSort.verticalCenter
        width: 48.1
        height: 10.1
    }

    Part {
        id: bidLevelSort
        name: "BidLevelSort"
        kind: "Button"
        text: "Lvl"
        wowParent: "AuctionFrameBid"
        anchors.left: bidQualitySort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: bidQualitySort.verticalCenter
        width: 65
        height: 19
    }

    Part {
        id: bidLevelSortText
        name: "BidLevelSortText"
        kind: "FontString"
        text: "Lvl"
        wowParent: "BidLevelSort"
        anchors.left: bidLevelSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidLevelSort.verticalCenter
        width: 15.1
        height: 10.1
    }

    Part {
        id: bidQualitySort
        name: "BidQualitySort"
        kind: "Button"
        text: "Rarity"
        wowParent: "AuctionFrameBid"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 57
        anchors.top: auctionFrame.top
        anchors.topMargin: 50
        width: 195
        height: 19
    }

    Part {
        id: bidQualitySortText
        name: "BidQualitySortText"
        kind: "FontString"
        text: "Rarity"
        wowParent: "BidQualitySort"
        anchors.left: bidQualitySort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidQualitySort.verticalCenter
        width: 29.5
        height: 10.1
    }

    Part {
        id: bidStatusSort
        name: "BidStatusSort"
        kind: "Button"
        text: "Bid Status"
        wowParent: "AuctionFrameBid"
        anchors.left: bidBuyoutSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: bidBuyoutSort.verticalCenter
        width: 94
        height: 19
    }

    Part {
        id: bidStatusSortText
        name: "BidStatusSortText"
        kind: "FontString"
        text: "Bid Status"
        wowParent: "BidStatusSort"
        anchors.left: bidStatusSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidStatusSort.verticalCenter
        width: 51
        height: 10.1
    }

    Part {
        id: bidTitle
        name: "BidTitle"
        kind: "FontString"
        text: "Bid"
        wowParent: "AuctionFrameBid"
        anchors.horizontalCenter: auctionFrameBid.horizontalCenter
        anchors.top: auctionFrameBid.top
        anchors.topMargin: 18
        width: 20.1
        height: 12.2
    }

    Part {
        id: browseBidButton
        name: "BrowseBidButton"
        kind: "Button"
        text: "Bid"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 172
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76
        height: 22
    }

    Part {
        id: browseBidButtonText
        name: "BrowseBidButtonText"
        kind: "FontString"
        text: "Bid"
        wowParent: "BrowseBidButton"
        anchors.horizontalCenter: browseBidButton.horizontalCenter
        anchors.verticalCenter: browseBidButton.verticalCenter
        width: 17.3
        height: 10.1
    }

    Part {
        id: browseBidPrice
        name: "BrowseBidPrice"
        kind: "Frame"
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: auctionFrameBrowse.horizontalCenter
        anchors.horizontalCenterOffset: 25
        anchors.bottom: auctionFrameBrowse.bottom
        anchors.bottomMargin: -8
        width: 176
        height: 18
    }

    Part {
        id: browseBidPriceCopper
        name: "BrowseBidPriceCopper"
        kind: "EditBox"
        wowParent: "BrowseBidPrice"
        anchors.left: browseBidPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: browseBidPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: browseBidPriceGold
        name: "BrowseBidPriceGold"
        kind: "EditBox"
        wowParent: "BrowseBidPrice"
        anchors.left: browseBidPrice.left
        anchors.top: browseBidPrice.top
        width: 58
        height: 20
    }

    Part {
        id: browseBidPriceSilver
        name: "BrowseBidPriceSilver"
        kind: "EditBox"
        wowParent: "BrowseBidPrice"
        anchors.left: browseBidPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: browseBidPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: browseBidText
        name: "BrowseBidText"
        kind: "FontString"
        text: "Bid"
        wowParent: "BrowseBidPrice"
        anchors.right: browseBidPrice.left
        anchors.rightMargin: 10
        anchors.verticalCenter: browseBidPrice.verticalCenter
        width: 17.3
        height: 10.1
    }

    Part {
        id: browseButton1
        name: "BrowseButton1"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 196
        anchors.top: auctionFrame.top
        anchors.topMargin: 103
        width: 600
        height: 37
    }

    Part {
        id: browseButton1BuyoutFrame
        name: "BrowseButton1BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton1"
        anchors.right: browseButton1MoneyFrame.right
        anchors.top: browseButton1MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton1BuyoutFrameMoney
        name: "BrowseButton1BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton1BuyoutFrame"
        anchors.right: browseButton1BuyoutFrame.right
        anchors.verticalCenter: browseButton1BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton1BuyoutFrameMoneyCopperButton
        name: "BrowseButton1BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton1BuyoutFrameMoney"
        anchors.right: browseButton1BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton1BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton1BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton1BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton1BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton1BuyoutFrameMoneyGoldButton
        name: "BrowseButton1BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "249"
        wowParent: "BrowseButton1BuyoutFrameMoney"
        anchors.right: browseButton1BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton1BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton1BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "249"
        wowParent: "BrowseButton1BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton1BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton1BuyoutFrameMoneySilverButton
        name: "BrowseButton1BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "75"
        wowParent: "BrowseButton1BuyoutFrameMoney"
        anchors.right: browseButton1BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton1BuyoutFrameMoneySilverButtonText
        name: "BrowseButton1BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "75"
        wowParent: "BrowseButton1BuyoutFrameMoneySilverButton"
        anchors.right: browseButton1BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: browseButton1BuyoutFrameText
        name: "BrowseButton1BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton1BuyoutFrame"
        anchors.left: browseButton1BuyoutFrame.left
        anchors.top: browseButton1BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton1ClosingTime
        name: "BrowseButton1ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 267
        anchors.top: browseButton1.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton1ClosingTimeText
        name: "BrowseButton1ClosingTimeText"
        kind: "FontString"
        text: "Very Long"
        wowParent: "BrowseButton1ClosingTime"
        anchors.left: browseButton1ClosingTime.left
        anchors.top: browseButton1ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton1HighBidder
        name: "BrowseButton1HighBidder"
        kind: "FontString"
        text: "Kovasky"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 345
        anchors.top: browseButton1.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton1Item
        name: "BrowseButton1Item"
        kind: "Button"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.top: browseButton1.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton1ItemCount
        name: "BrowseButton1ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton1Item"
        anchors.right: browseButton1Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton1Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton1Level
        name: "BrowseButton1Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 205
        anchors.top: browseButton1.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton1MoneyFrame
        name: "BrowseButton1MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton1"
        anchors.right: browseButton1.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton1.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton1MoneyFrameCopperButton
        name: "BrowseButton1MoneyFrameCopperButton"
        kind: "Button"
        text: "25"
        wowParent: "BrowseButton1MoneyFrame"
        anchors.right: browseButton1MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton1MoneyFrameCopperButtonText
        name: "BrowseButton1MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "25"
        wowParent: "BrowseButton1MoneyFrameCopperButton"
        anchors.right: browseButton1MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Part {
        id: browseButton1MoneyFrameGoldButton
        name: "BrowseButton1MoneyFrameGoldButton"
        kind: "Button"
        text: "237"
        wowParent: "BrowseButton1MoneyFrame"
        anchors.right: browseButton1MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton1MoneyFrameGoldButtonText
        name: "BrowseButton1MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "237"
        wowParent: "BrowseButton1MoneyFrameGoldButton"
        anchors.right: browseButton1MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton1MoneyFrameSilverButton
        name: "BrowseButton1MoneyFrameSilverButton"
        kind: "Button"
        text: "26"
        wowParent: "BrowseButton1MoneyFrame"
        anchors.right: browseButton1MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton1MoneyFrameSilverButtonText
        name: "BrowseButton1MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "26"
        wowParent: "BrowseButton1MoneyFrameSilverButton"
        anchors.right: browseButton1MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton1Name
        name: "BrowseButton1Name"
        kind: "FontString"
        text: "Durable Nerubhide Cape"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 43
        anchors.top: browseButton1.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton2
        name: "BrowseButton2"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton1.left
        anchors.top: browseButton1.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton2BuyoutFrame
        name: "BrowseButton2BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton2"
        anchors.right: browseButton2MoneyFrame.right
        anchors.top: browseButton2MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton2BuyoutFrameMoney
        name: "BrowseButton2BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton2BuyoutFrame"
        anchors.right: browseButton2BuyoutFrame.right
        anchors.verticalCenter: browseButton2BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton2BuyoutFrameMoneyCopperButton
        name: "BrowseButton2BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoney"
        anchors.right: browseButton2BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton2BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton2BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton2BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton2BuyoutFrameMoneyGoldButton
        name: "BrowseButton2BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "250"
        wowParent: "BrowseButton2BuyoutFrameMoney"
        anchors.right: browseButton2BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton2BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton2BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "250"
        wowParent: "BrowseButton2BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton2BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton2BuyoutFrameMoneySilverButton
        name: "BrowseButton2BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoney"
        anchors.right: browseButton2BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton2BuyoutFrameMoneySilverButtonText
        name: "BrowseButton2BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoneySilverButton"
        anchors.right: browseButton2BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton2BuyoutFrameText
        name: "BrowseButton2BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton2BuyoutFrame"
        anchors.left: browseButton2BuyoutFrame.left
        anchors.top: browseButton2BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton2ClosingTime
        name: "BrowseButton2ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 267
        anchors.top: browseButton2.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton2ClosingTimeText
        name: "BrowseButton2ClosingTimeText"
        kind: "FontString"
        text: "Very Long"
        wowParent: "BrowseButton2ClosingTime"
        anchors.left: browseButton2ClosingTime.left
        anchors.top: browseButton2ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton2HighBidder
        name: "BrowseButton2HighBidder"
        kind: "FontString"
        text: "Fancyblades"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 345
        anchors.top: browseButton2.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton2Item
        name: "BrowseButton2Item"
        kind: "Button"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.top: browseButton2.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton2ItemCount
        name: "BrowseButton2ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton2Item"
        anchors.right: browseButton2Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton2Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton2Level
        name: "BrowseButton2Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 205
        anchors.top: browseButton2.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton2MoneyFrame
        name: "BrowseButton2MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton2"
        anchors.right: browseButton2.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton2.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton2MoneyFrameCopperButton
        name: "BrowseButton2MoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton2MoneyFrame"
        anchors.right: browseButton2MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton2MoneyFrameCopperButtonText
        name: "BrowseButton2MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton2MoneyFrameCopperButton"
        anchors.right: browseButton2MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton2MoneyFrameGoldButton
        name: "BrowseButton2MoneyFrameGoldButton"
        kind: "Button"
        text: "250"
        wowParent: "BrowseButton2MoneyFrame"
        anchors.right: browseButton2MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton2MoneyFrameGoldButtonText
        name: "BrowseButton2MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "250"
        wowParent: "BrowseButton2MoneyFrameGoldButton"
        anchors.right: browseButton2MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton2MoneyFrameSilverButton
        name: "BrowseButton2MoneyFrameSilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton2MoneyFrame"
        anchors.right: browseButton2MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton2MoneyFrameSilverButtonText
        name: "BrowseButton2MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton2MoneyFrameSilverButton"
        anchors.right: browseButton2MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton2Name
        name: "BrowseButton2Name"
        kind: "FontString"
        text: "Durable Nerubhide Cape"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 43
        anchors.top: browseButton2.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton3
        name: "BrowseButton3"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton2.left
        anchors.top: browseButton2.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton3BuyoutFrame
        name: "BrowseButton3BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton3"
        anchors.right: browseButton3MoneyFrame.right
        anchors.top: browseButton3MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton3BuyoutFrameMoney
        name: "BrowseButton3BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton3BuyoutFrame"
        anchors.right: browseButton3BuyoutFrame.right
        anchors.verticalCenter: browseButton3BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton3BuyoutFrameMoneyCopperButton
        name: "BrowseButton3BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoney"
        anchors.right: browseButton3BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton3BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton3BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton3BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton3BuyoutFrameMoneyGoldButton
        name: "BrowseButton3BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "250"
        wowParent: "BrowseButton3BuyoutFrameMoney"
        anchors.right: browseButton3BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton3BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton3BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "250"
        wowParent: "BrowseButton3BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton3BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton3BuyoutFrameMoneySilverButton
        name: "BrowseButton3BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoney"
        anchors.right: browseButton3BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton3BuyoutFrameMoneySilverButtonText
        name: "BrowseButton3BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoneySilverButton"
        anchors.right: browseButton3BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton3BuyoutFrameText
        name: "BrowseButton3BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton3BuyoutFrame"
        anchors.left: browseButton3BuyoutFrame.left
        anchors.top: browseButton3BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton3ClosingTime
        name: "BrowseButton3ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 267
        anchors.top: browseButton3.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton3ClosingTimeText
        name: "BrowseButton3ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "BrowseButton3ClosingTime"
        anchors.left: browseButton3ClosingTime.left
        anchors.top: browseButton3ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton3HighBidder
        name: "BrowseButton3HighBidder"
        kind: "FontString"
        text: "Krysimpaler"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 345
        anchors.top: browseButton3.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton3Item
        name: "BrowseButton3Item"
        kind: "Button"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.top: browseButton3.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton3ItemCount
        name: "BrowseButton3ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton3Item"
        anchors.right: browseButton3Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton3Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton3Level
        name: "BrowseButton3Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 205
        anchors.top: browseButton3.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton3MoneyFrame
        name: "BrowseButton3MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton3"
        anchors.right: browseButton3.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton3.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton3MoneyFrameCopperButton
        name: "BrowseButton3MoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton3MoneyFrame"
        anchors.right: browseButton3MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton3MoneyFrameCopperButtonText
        name: "BrowseButton3MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton3MoneyFrameCopperButton"
        anchors.right: browseButton3MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton3MoneyFrameGoldButton
        name: "BrowseButton3MoneyFrameGoldButton"
        kind: "Button"
        text: "250"
        wowParent: "BrowseButton3MoneyFrame"
        anchors.right: browseButton3MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton3MoneyFrameGoldButtonText
        name: "BrowseButton3MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "250"
        wowParent: "BrowseButton3MoneyFrameGoldButton"
        anchors.right: browseButton3MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton3MoneyFrameSilverButton
        name: "BrowseButton3MoneyFrameSilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton3MoneyFrame"
        anchors.right: browseButton3MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton3MoneyFrameSilverButtonText
        name: "BrowseButton3MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton3MoneyFrameSilverButton"
        anchors.right: browseButton3MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton3Name
        name: "BrowseButton3Name"
        kind: "FontString"
        text: "Earthen Leg Armor"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 43
        anchors.top: browseButton3.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton4
        name: "BrowseButton4"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton3.left
        anchors.top: browseButton3.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton4BuyoutFrame
        name: "BrowseButton4BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton4"
        anchors.right: browseButton4MoneyFrame.right
        anchors.top: browseButton4MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton4BuyoutFrameMoney
        name: "BrowseButton4BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton4BuyoutFrame"
        anchors.right: browseButton4BuyoutFrame.right
        anchors.verticalCenter: browseButton4BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton4BuyoutFrameMoneyCopperButton
        name: "BrowseButton4BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoney"
        anchors.right: browseButton4BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton4BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton4BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton4BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton4BuyoutFrameMoneyGoldButton
        name: "BrowseButton4BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "250"
        wowParent: "BrowseButton4BuyoutFrameMoney"
        anchors.right: browseButton4BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton4BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton4BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "250"
        wowParent: "BrowseButton4BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton4BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton4BuyoutFrameMoneySilverButton
        name: "BrowseButton4BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoney"
        anchors.right: browseButton4BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton4BuyoutFrameMoneySilverButtonText
        name: "BrowseButton4BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoneySilverButton"
        anchors.right: browseButton4BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton4BuyoutFrameText
        name: "BrowseButton4BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton4BuyoutFrame"
        anchors.left: browseButton4BuyoutFrame.left
        anchors.top: browseButton4BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton4ClosingTime
        name: "BrowseButton4ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 267
        anchors.top: browseButton4.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton4ClosingTimeText
        name: "BrowseButton4ClosingTimeText"
        kind: "FontString"
        text: "Long"
        wowParent: "BrowseButton4ClosingTime"
        anchors.left: browseButton4ClosingTime.left
        anchors.top: browseButton4ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton4HighBidder
        name: "BrowseButton4HighBidder"
        kind: "FontString"
        text: "Krysimpaler"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 345
        anchors.top: browseButton4.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton4Item
        name: "BrowseButton4Item"
        kind: "Button"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.top: browseButton4.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton4ItemCount
        name: "BrowseButton4ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton4Item"
        anchors.right: browseButton4Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton4Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton4Level
        name: "BrowseButton4Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 205
        anchors.top: browseButton4.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton4MoneyFrame
        name: "BrowseButton4MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton4"
        anchors.right: browseButton4.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton4.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton4MoneyFrameCopperButton
        name: "BrowseButton4MoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton4MoneyFrame"
        anchors.right: browseButton4MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton4MoneyFrameCopperButtonText
        name: "BrowseButton4MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton4MoneyFrameCopperButton"
        anchors.right: browseButton4MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton4MoneyFrameGoldButton
        name: "BrowseButton4MoneyFrameGoldButton"
        kind: "Button"
        text: "250"
        wowParent: "BrowseButton4MoneyFrame"
        anchors.right: browseButton4MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton4MoneyFrameGoldButtonText
        name: "BrowseButton4MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "250"
        wowParent: "BrowseButton4MoneyFrameGoldButton"
        anchors.right: browseButton4MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton4MoneyFrameSilverButton
        name: "BrowseButton4MoneyFrameSilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton4MoneyFrame"
        anchors.right: browseButton4MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton4MoneyFrameSilverButtonText
        name: "BrowseButton4MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton4MoneyFrameSilverButton"
        anchors.right: browseButton4MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton4Name
        name: "BrowseButton4Name"
        kind: "FontString"
        text: "Earthen Leg Armor"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 43
        anchors.top: browseButton4.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton5
        name: "BrowseButton5"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton4.left
        anchors.top: browseButton4.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton5BuyoutFrame
        name: "BrowseButton5BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton5"
        anchors.right: browseButton5MoneyFrame.right
        anchors.top: browseButton5MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton5BuyoutFrameMoney
        name: "BrowseButton5BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton5BuyoutFrame"
        anchors.right: browseButton5BuyoutFrame.right
        anchors.verticalCenter: browseButton5BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton5BuyoutFrameMoneyCopperButton
        name: "BrowseButton5BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton5BuyoutFrameMoney"
        anchors.right: browseButton5BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton5BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton5BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton5BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton5BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton5BuyoutFrameMoneyGoldButton
        name: "BrowseButton5BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "390"
        wowParent: "BrowseButton5BuyoutFrameMoney"
        anchors.right: browseButton5BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton5BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton5BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "390"
        wowParent: "BrowseButton5BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton5BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton5BuyoutFrameMoneySilverButton
        name: "BrowseButton5BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "50"
        wowParent: "BrowseButton5BuyoutFrameMoney"
        anchors.right: browseButton5BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton5BuyoutFrameMoneySilverButtonText
        name: "BrowseButton5BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "50"
        wowParent: "BrowseButton5BuyoutFrameMoneySilverButton"
        anchors.right: browseButton5BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton5BuyoutFrameText
        name: "BrowseButton5BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton5BuyoutFrame"
        anchors.left: browseButton5BuyoutFrame.left
        anchors.top: browseButton5BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton5ClosingTime
        name: "BrowseButton5ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 267
        anchors.top: browseButton5.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton5ClosingTimeText
        name: "BrowseButton5ClosingTimeText"
        kind: "FontString"
        text: "Very Long"
        wowParent: "BrowseButton5ClosingTime"
        anchors.left: browseButton5ClosingTime.left
        anchors.top: browseButton5ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton5HighBidder
        name: "BrowseButton5HighBidder"
        kind: "FontString"
        text: "Kovasky"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 345
        anchors.top: browseButton5.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton5Item
        name: "BrowseButton5Item"
        kind: "Button"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.top: browseButton5.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton5ItemCount
        name: "BrowseButton5ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton5Item"
        anchors.right: browseButton5Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton5Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton5Level
        name: "BrowseButton5Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 205
        anchors.top: browseButton5.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton5MoneyFrame
        name: "BrowseButton5MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton5"
        anchors.right: browseButton5.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton5.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton5MoneyFrameCopperButton
        name: "BrowseButton5MoneyFrameCopperButton"
        kind: "Button"
        text: "50"
        wowParent: "BrowseButton5MoneyFrame"
        anchors.right: browseButton5MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton5MoneyFrameCopperButtonText
        name: "BrowseButton5MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "50"
        wowParent: "BrowseButton5MoneyFrameCopperButton"
        anchors.right: browseButton5MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton5MoneyFrameGoldButton
        name: "BrowseButton5MoneyFrameGoldButton"
        kind: "Button"
        text: "370"
        wowParent: "BrowseButton5MoneyFrame"
        anchors.right: browseButton5MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton5MoneyFrameGoldButtonText
        name: "BrowseButton5MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "370"
        wowParent: "BrowseButton5MoneyFrameGoldButton"
        anchors.right: browseButton5MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton5MoneyFrameSilverButton
        name: "BrowseButton5MoneyFrameSilverButton"
        kind: "Button"
        text: "97"
        wowParent: "BrowseButton5MoneyFrame"
        anchors.right: browseButton5MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton5MoneyFrameSilverButtonText
        name: "BrowseButton5MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "97"
        wowParent: "BrowseButton5MoneyFrameSilverButton"
        anchors.right: browseButton5MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton5Name
        name: "BrowseButton5Name"
        kind: "FontString"
        text: "Earthgiving Boots"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 43
        anchors.top: browseButton5.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton6
        name: "BrowseButton6"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton5.left
        anchors.top: browseButton5.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton6BuyoutFrame
        name: "BrowseButton6BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton6"
        anchors.right: browseButton6MoneyFrame.right
        anchors.top: browseButton6MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton6BuyoutFrameMoney
        name: "BrowseButton6BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton6BuyoutFrame"
        anchors.right: browseButton6BuyoutFrame.right
        anchors.verticalCenter: browseButton6BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton6BuyoutFrameMoneyCopperButton
        name: "BrowseButton6BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoney"
        anchors.right: browseButton6BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton6BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton6BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton6BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton6BuyoutFrameMoneyGoldButton
        name: "BrowseButton6BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "590"
        wowParent: "BrowseButton6BuyoutFrameMoney"
        anchors.right: browseButton6BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton6BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton6BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "590"
        wowParent: "BrowseButton6BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton6BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton6BuyoutFrameMoneySilverButton
        name: "BrowseButton6BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoney"
        anchors.right: browseButton6BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton6BuyoutFrameMoneySilverButtonText
        name: "BrowseButton6BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoneySilverButton"
        anchors.right: browseButton6BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton6BuyoutFrameText
        name: "BrowseButton6BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton6BuyoutFrame"
        anchors.left: browseButton6BuyoutFrame.left
        anchors.top: browseButton6BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton6ClosingTime
        name: "BrowseButton6ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 267
        anchors.top: browseButton6.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton6ClosingTimeText
        name: "BrowseButton6ClosingTimeText"
        kind: "FontString"
        text: "Very Long"
        wowParent: "BrowseButton6ClosingTime"
        anchors.left: browseButton6ClosingTime.left
        anchors.top: browseButton6ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton6HighBidder
        name: "BrowseButton6HighBidder"
        kind: "FontString"
        text: "Kovasky"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 345
        anchors.top: browseButton6.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton6Item
        name: "BrowseButton6Item"
        kind: "Button"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.top: browseButton6.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton6ItemCount
        name: "BrowseButton6ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton6Item"
        anchors.right: browseButton6Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton6Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton6Level
        name: "BrowseButton6Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 205
        anchors.top: browseButton6.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton6MoneyFrame
        name: "BrowseButton6MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton6"
        anchors.right: browseButton6.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton6.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton6MoneyFrameCopperButton
        name: "BrowseButton6MoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "BrowseButton6MoneyFrame"
        anchors.right: browseButton6MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton6MoneyFrameCopperButtonText
        name: "BrowseButton6MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "BrowseButton6MoneyFrameCopperButton"
        anchors.right: browseButton6MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Part {
        id: browseButton6MoneyFrameGoldButton
        name: "BrowseButton6MoneyFrameGoldButton"
        kind: "Button"
        text: "560"
        wowParent: "BrowseButton6MoneyFrame"
        anchors.right: browseButton6MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton6MoneyFrameGoldButtonText
        name: "BrowseButton6MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "560"
        wowParent: "BrowseButton6MoneyFrameGoldButton"
        anchors.right: browseButton6MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton6MoneyFrameSilverButton
        name: "BrowseButton6MoneyFrameSilverButton"
        kind: "Button"
        text: "50"
        wowParent: "BrowseButton6MoneyFrame"
        anchors.right: browseButton6MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton6MoneyFrameSilverButtonText
        name: "BrowseButton6MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "50"
        wowParent: "BrowseButton6MoneyFrameSilverButton"
        anchors.right: browseButton6MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton6Name
        name: "BrowseButton6Name"
        kind: "FontString"
        text: "Earthgiving Legguards"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 43
        anchors.top: browseButton6.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton7
        name: "BrowseButton7"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton6.left
        anchors.top: browseButton6.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton7BuyoutFrame
        name: "BrowseButton7BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton7"
        anchors.right: browseButton7MoneyFrame.right
        anchors.top: browseButton7MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton7BuyoutFrameMoney
        name: "BrowseButton7BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton7BuyoutFrame"
        anchors.right: browseButton7BuyoutFrame.right
        anchors.verticalCenter: browseButton7BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton7BuyoutFrameMoneyCopperButton
        name: "BrowseButton7BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "63"
        wowParent: "BrowseButton7BuyoutFrameMoney"
        anchors.right: browseButton7BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton7BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton7BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "63"
        wowParent: "BrowseButton7BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton7BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton7BuyoutFrameMoneyGoldButton
        name: "BrowseButton7BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "187"
        wowParent: "BrowseButton7BuyoutFrameMoney"
        anchors.right: browseButton7BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton7BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton7BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "187"
        wowParent: "BrowseButton7BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton7BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton7BuyoutFrameMoneySilverButton
        name: "BrowseButton7BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "72"
        wowParent: "BrowseButton7BuyoutFrameMoney"
        anchors.right: browseButton7BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton7BuyoutFrameMoneySilverButtonText
        name: "BrowseButton7BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "72"
        wowParent: "BrowseButton7BuyoutFrameMoneySilverButton"
        anchors.right: browseButton7BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton7BuyoutFrameText
        name: "BrowseButton7BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton7BuyoutFrame"
        anchors.left: browseButton7BuyoutFrame.left
        anchors.top: browseButton7BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton7ClosingTime
        name: "BrowseButton7ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 267
        anchors.top: browseButton7.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton7ClosingTimeText
        name: "BrowseButton7ClosingTimeText"
        kind: "FontString"
        text: "Very Long"
        wowParent: "BrowseButton7ClosingTime"
        anchors.left: browseButton7ClosingTime.left
        anchors.top: browseButton7ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton7HighBidder
        name: "BrowseButton7HighBidder"
        kind: "FontString"
        text: "Bankbankstar"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 345
        anchors.top: browseButton7.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton7Item
        name: "BrowseButton7Item"
        kind: "Button"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.top: browseButton7.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton7ItemCount
        name: "BrowseButton7ItemCount"
        kind: "FontString"
        text: "20"
        wowParent: "BrowseButton7Item"
        anchors.right: browseButton7Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton7Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton7Level
        name: "BrowseButton7Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 205
        anchors.top: browseButton7.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton7MoneyFrame
        name: "BrowseButton7MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton7"
        anchors.right: browseButton7.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton7.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton7MoneyFrameCopperButton
        name: "BrowseButton7MoneyFrameCopperButton"
        kind: "Button"
        text: "33"
        wowParent: "BrowseButton7MoneyFrame"
        anchors.right: browseButton7MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton7MoneyFrameCopperButtonText
        name: "BrowseButton7MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "33"
        wowParent: "BrowseButton7MoneyFrameCopperButton"
        anchors.right: browseButton7MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton7MoneyFrameGoldButton
        name: "BrowseButton7MoneyFrameGoldButton"
        kind: "Button"
        text: "186"
        wowParent: "BrowseButton7MoneyFrame"
        anchors.right: browseButton7MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton7MoneyFrameGoldButtonText
        name: "BrowseButton7MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "186"
        wowParent: "BrowseButton7MoneyFrameGoldButton"
        anchors.right: browseButton7MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton7MoneyFrameSilverButton
        name: "BrowseButton7MoneyFrameSilverButton"
        kind: "Button"
        text: "91"
        wowParent: "BrowseButton7MoneyFrame"
        anchors.right: browseButton7MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton7MoneyFrameSilverButtonText
        name: "BrowseButton7MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "91"
        wowParent: "BrowseButton7MoneyFrameSilverButton"
        anchors.right: browseButton7MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    Part {
        id: browseButton7Name
        name: "BrowseButton7Name"
        kind: "FontString"
        text: "Ebonweave Gloves"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 43
        anchors.top: browseButton7.top
        width: 167
        height: 32
    }

    Part {
        id: browseButton8
        name: "BrowseButton8"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton7.left
        anchors.top: browseButton7.bottom
        width: 600
        height: 37
    }

    Part {
        id: browseButton8BuyoutFrame
        name: "BrowseButton8BuyoutFrame"
        kind: "Frame"
        wowParent: "BrowseButton8"
        anchors.right: browseButton8MoneyFrame.right
        anchors.top: browseButton8MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Part {
        id: browseButton8BuyoutFrameMoney
        name: "BrowseButton8BuyoutFrameMoney"
        kind: "Frame"
        wowParent: "BrowseButton8BuyoutFrame"
        anchors.right: browseButton8BuyoutFrame.right
        anchors.verticalCenter: browseButton8BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton8BuyoutFrameMoneyCopperButton
        name: "BrowseButton8BuyoutFrameMoneyCopperButton"
        kind: "Button"
        text: "63"
        wowParent: "BrowseButton8BuyoutFrameMoney"
        anchors.right: browseButton8BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton8BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton8BuyoutFrameMoneyCopperButtonText"
        kind: "FontString"
        text: "63"
        wowParent: "BrowseButton8BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton8BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton8BuyoutFrameMoneyGoldButton
        name: "BrowseButton8BuyoutFrameMoneyGoldButton"
        kind: "Button"
        text: "187"
        wowParent: "BrowseButton8BuyoutFrameMoney"
        anchors.right: browseButton8BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton8BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton8BuyoutFrameMoneyGoldButtonText"
        kind: "FontString"
        text: "187"
        wowParent: "BrowseButton8BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton8BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton8BuyoutFrameMoneySilverButton
        name: "BrowseButton8BuyoutFrameMoneySilverButton"
        kind: "Button"
        text: "72"
        wowParent: "BrowseButton8BuyoutFrameMoney"
        anchors.right: browseButton8BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton8BuyoutFrameMoneySilverButtonText
        name: "BrowseButton8BuyoutFrameMoneySilverButtonText"
        kind: "FontString"
        text: "72"
        wowParent: "BrowseButton8BuyoutFrameMoneySilverButton"
        anchors.right: browseButton8BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton8BuyoutFrameText
        name: "BrowseButton8BuyoutFrameText"
        kind: "Frame"
        wowParent: "BrowseButton8BuyoutFrame"
        anchors.left: browseButton8BuyoutFrame.left
        anchors.top: browseButton8BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Part {
        id: browseButton8ClosingTime
        name: "BrowseButton8ClosingTime"
        kind: "Frame"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 267
        anchors.top: browseButton8.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton8ClosingTimeText
        name: "BrowseButton8ClosingTimeText"
        kind: "FontString"
        text: "Very Long"
        wowParent: "BrowseButton8ClosingTime"
        anchors.left: browseButton8ClosingTime.left
        anchors.top: browseButton8ClosingTime.top
        width: 65
        height: 32
    }

    Part {
        id: browseButton8HighBidder
        name: "BrowseButton8HighBidder"
        kind: "FontString"
        text: "Bankbankstar"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 345
        anchors.top: browseButton8.top
        width: 78
        height: 32
    }

    Part {
        id: browseButton8Item
        name: "BrowseButton8Item"
        kind: "Button"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.top: browseButton8.top
        width: 32
        height: 32
    }

    Part {
        id: browseButton8Level
        name: "BrowseButton8Level"
        kind: "FontString"
        text: "80"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 205
        anchors.top: browseButton8.top
        width: 52
        height: 32
    }

    Part {
        id: browseButton8MoneyFrame
        name: "BrowseButton8MoneyFrame"
        kind: "Frame"
        wowParent: "BrowseButton8"
        anchors.right: browseButton8.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton8.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Part {
        id: browseButton8MoneyFrameCopperButton
        name: "BrowseButton8MoneyFrameCopperButton"
        kind: "Button"
        text: "33"
        wowParent: "BrowseButton8MoneyFrame"
        anchors.right: browseButton8MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton8MoneyFrameCopperButtonText
        name: "BrowseButton8MoneyFrameCopperButtonText"
        kind: "FontString"
        text: "33"
        wowParent: "BrowseButton8MoneyFrameCopperButton"
        anchors.right: browseButton8MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Part {
        id: browseButton8MoneyFrameGoldButton
        name: "BrowseButton8MoneyFrameGoldButton"
        kind: "Button"
        text: "186"
        wowParent: "BrowseButton8MoneyFrame"
        anchors.right: browseButton8MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    Part {
        id: browseButton8MoneyFrameGoldButtonText
        name: "BrowseButton8MoneyFrameGoldButtonText"
        kind: "FontString"
        text: "186"
        wowParent: "BrowseButton8MoneyFrameGoldButton"
        anchors.right: browseButton8MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Part {
        id: browseButton8MoneyFrameSilverButton
        name: "BrowseButton8MoneyFrameSilverButton"
        kind: "Button"
        text: "91"
        wowParent: "BrowseButton8MoneyFrame"
        anchors.right: browseButton8MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: browseButton8MoneyFrameSilverButtonText
        name: "BrowseButton8MoneyFrameSilverButtonText"
        kind: "FontString"
        text: "91"
        wowParent: "BrowseButton8MoneyFrameSilverButton"
        anchors.right: browseButton8MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    Part {
        id: browseButton8Name
        name: "BrowseButton8Name"
        kind: "FontString"
        text: "Ebonweave Gloves"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 43
        anchors.top: browseButton8.top
        width: 167
        height: 32
    }

    Part {
        id: browseBuyoutButton
        name: "BrowseBuyoutButton"
        kind: "Button"
        text: "Buyout"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 90
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76
        height: 22
    }

    Part {
        id: browseBuyoutButtonText
        name: "BrowseBuyoutButtonText"
        kind: "FontString"
        text: "Buyout"
        wowParent: "BrowseBuyoutButton"
        anchors.horizontalCenter: browseBuyoutButton.horizontalCenter
        anchors.verticalCenter: browseBuyoutButton.verticalCenter
        width: 38.8
        height: 10.1
    }

    Part {
        id: browseCloseButton
        name: "BrowseCloseButton"
        kind: "Button"
        text: "Close"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        anchors.right: auctionFrame.right
        anchors.rightMargin: 8
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -12
        width: 76
        height: 22
    }

    Part {
        id: browseCloseButtonText
        name: "BrowseCloseButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "BrowseCloseButton"
        anchors.horizontalCenter: browseCloseButton.horizontalCenter
        anchors.verticalCenter: browseCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Part {
        id: browseCurrentBidSort
        name: "BrowseCurrentBidSort"
        kind: "Button"
        text: "Current Bid"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseHighBidderSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: browseHighBidderSort.verticalCenter
        width: 207
        height: 19
    }

    Part {
        id: browseCurrentBidSortText
        name: "BrowseCurrentBidSortText"
        kind: "FontString"
        text: "Current Bid"
        wowParent: "BrowseCurrentBidSort"
        anchors.left: browseCurrentBidSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseCurrentBidSort.verticalCenter
        width: 57.5
        height: 10.1
    }

    Part {
        id: browseDropDown
        name: "BrowseDropDown"
        kind: "Frame"
        wowParent: "AuctionFrameBrowse"
        style: "DropDown"
        anchors.left: browseMaxLevel.right
        anchors.leftMargin: 4
        anchors.verticalCenter: browseMaxLevel.verticalCenter
        width: 165
        height: 32
    }

    Part {
        id: browseDropDownButton
        name: "BrowseDropDownButton"
        kind: "Button"
        wowParent: "BrowseDropDown"
        anchors.right: browseDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: browseDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: browseDropDownDiabolicField
        name: "BrowseDropDownDiabolicField"
        kind: "Frame"
        wowParent: "BrowseDropDown"
        anchors.left: browseDropDown.left
        anchors.verticalCenter: browseDropDown.verticalCenter
        width: 165
        height: 22
    }

    Part {
        id: browseDropDownName
        name: "BrowseDropDownName"
        kind: "FontString"
        text: "Rarity"
        wowParent: "BrowseDropDown"
        anchors.left: browseDropDown.left
        anchors.leftMargin: 20
        anchors.bottom: browseDropDown.top
        width: 29.5
        height: 10.1
    }

    Part {
        id: browseDropDownText
        name: "BrowseDropDownText"
        kind: "FontString"
        text: "All"
        wowParent: "BrowseDropDown"
        anchors.left: browseDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: browseDropDownDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Part {
        id: browseDurationSort
        name: "BrowseDurationSort"
        kind: "Button"
        text: "Time Left"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseLevelSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: browseLevelSort.verticalCenter
        width: 91
        height: 19
    }

    Part {
        id: browseDurationSortText
        name: "BrowseDurationSortText"
        kind: "FontString"
        text: "Time Left"
        wowParent: "BrowseDurationSort"
        anchors.left: browseDurationSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseDurationSort.verticalCenter
        width: 48.1
        height: 10.1
    }

    Part {
        id: browseFilterScrollFrame
        name: "BrowseFilterScrollFrame"
        kind: "ScrollFrame"
        wowParent: "AuctionFrameBrowse"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -138
        anchors.top: auctionFrame.top
        anchors.topMargin: 82
        width: 160
        height: 327
    }

    Part {
        id: browseFilterScrollFrameScrollBar
        name: "BrowseFilterScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "BrowseFilterScrollFrame"
        style: "ScrollBar"
        anchors.left: browseFilterScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: browseFilterScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 295
    }

    Part {
        id: browseFilterScrollFrameScrollBarDiabolicTrack
        name: "BrowseFilterScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "BrowseFilterScrollFrameScrollBar"
        anchors.horizontalCenter: browseFilterScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: browseFilterScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 329
    }

    Part {
        id: browseFilterScrollFrameScrollBarScrollDownButton
        name: "BrowseFilterScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "BrowseFilterScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseFilterScrollFrameScrollBar.horizontalCenter
        anchors.top: browseFilterScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: browseFilterScrollFrameScrollBarScrollUpButton
        name: "BrowseFilterScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "BrowseFilterScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseFilterScrollFrameScrollBar.horizontalCenter
        anchors.bottom: browseFilterScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: browseFilterScrollFrameScrollChildFrame
        name: "BrowseFilterScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "BrowseFilterScrollFrame"
        anchors.left: browseFilterScrollFrame.left
        anchors.top: browseFilterScrollFrame.top
        width: 300
        height: 420
    }

    Part {
        id: browseHighBidderSort
        name: "BrowseHighBidderSort"
        kind: "Button"
        text: "Seller"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseDurationSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: browseDurationSort.verticalCenter
        width: 76
        height: 19
    }

    Part {
        id: browseHighBidderSortText
        name: "BrowseHighBidderSortText"
        kind: "FontString"
        text: "Seller"
        wowParent: "BrowseHighBidderSort"
        anchors.left: browseHighBidderSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseHighBidderSort.verticalCenter
        width: 30.2
        height: 10.1
    }

    Part {
        id: browseLevelHyphen
        name: "BrowseLevelHyphen"
        kind: "FontString"
        text: "-"
        wowParent: "BrowseMinLevel"
        anchors.left: browseMinLevel.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseMinLevel.verticalCenter
        width: 5
        height: 13.6
    }

    Part {
        id: browseLevelSort
        name: "BrowseLevelSort"
        kind: "Button"
        text: "Lvl"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseQualitySort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: browseQualitySort.verticalCenter
        width: 57
        height: 19
    }

    Part {
        id: browseLevelSortText
        name: "BrowseLevelSortText"
        kind: "FontString"
        text: "Lvl"
        wowParent: "BrowseLevelSort"
        anchors.left: browseLevelSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseLevelSort.verticalCenter
        width: 15.1
        height: 10.1
    }

    Part {
        id: browseLevelText
        name: "BrowseLevelText"
        kind: "FontString"
        text: "Level Range"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseName.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseName.verticalCenter
        width: 66.8
        height: 13.6
    }

    Part {
        id: browseMaxLevel
        name: "BrowseMaxLevel"
        kind: "EditBox"
        wowParent: "AuctionFrameBrowse"
        style: "EditBox"
        anchors.left: browseLevelHyphen.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseLevelHyphen.verticalCenter
        width: 25
        height: 16
    }

    Part {
        id: browseMaxLevelDiabolicField
        name: "BrowseMaxLevelDiabolicField"
        kind: "Frame"
        wowParent: "BrowseMaxLevel"
        anchors.left: browseMaxLevel.left
        anchors.leftMargin: -8
        anchors.verticalCenter: browseMaxLevel.verticalCenter
        width: 41
        height: 22
    }

    Part {
        id: browseMinLevel
        name: "BrowseMinLevel"
        kind: "EditBox"
        wowParent: "AuctionFrameBrowse"
        style: "EditBox"
        anchors.left: browseLevelText.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseLevelText.verticalCenter
        width: 25
        height: 16
    }

    Part {
        id: browseMinLevelDiabolicField
        name: "BrowseMinLevelDiabolicField"
        kind: "Frame"
        wowParent: "BrowseMinLevel"
        anchors.left: browseMinLevel.left
        anchors.leftMargin: -8
        anchors.verticalCenter: browseMinLevel.verticalCenter
        width: 41
        height: 22
    }

    Part {
        id: browseName
        name: "BrowseName"
        kind: "EditBox"
        wowParent: "AuctionFrameBrowse"
        style: "EditBox"
        anchors.left: auctionFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: auctionFrameDiabolicBand.verticalCenter
        width: 140
        height: 16
    }

    Part {
        id: browseNameDiabolicField
        name: "BrowseNameDiabolicField"
        kind: "Frame"
        wowParent: "BrowseName"
        anchors.left: browseName.left
        anchors.leftMargin: -8
        anchors.verticalCenter: browseName.verticalCenter
        width: 156
        height: 22
    }

    Part {
        id: browseNameText
        name: "BrowseNameText"
        kind: "FontString"
        text: "Name"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 80
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 41
        width: 30.9
        height: 10.1
    }

    Part {
        id: browseNextPageButton
        name: "BrowseNextPageButton"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -840
        anchors.verticalCenter: auctionFrame.top
        anchors.verticalCenterOffset: 58
        width: 24
        height: 24
    }

    Part {
        id: browseNoResultsText
        name: "BrowseNoResultsText"
        kind: "FontString"
        text: "Choose search criteria and press \"Search\""
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: auctionFrame.left
        anchors.horizontalCenterOffset: 509
        anchors.top: auctionFrame.top
        anchors.topMargin: 118
        width: 252.1
        height: 12.2
    }

    Part {
        id: browsePrevPageButton
        name: "BrowsePrevPageButton"
        kind: "Button"
        wowParent: "AuctionFrameBrowse"
        anchors.right: browseNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseNextPageButton.verticalCenter
        width: 24
        height: 24
    }

    Part {
        id: browseQualitySort
        name: "BrowseQualitySort"
        kind: "Button"
        text: "Rarity"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 187
        anchors.top: auctionFrame.top
        anchors.topMargin: 82
        width: 214
        height: 19
    }

    Part {
        id: browseQualitySortText
        name: "BrowseQualitySortText"
        kind: "FontString"
        text: "Rarity"
        wowParent: "BrowseQualitySort"
        anchors.left: browseQualitySort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseQualitySort.verticalCenter
        width: 29.5
        height: 10.1
    }

    Part {
        id: browseResetButton
        name: "BrowseResetButton"
        kind: "Button"
        text: "Reset"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        anchors.left: auctionFrame.left
        anchors.leftMargin: -8
        anchors.top: auctionFrame.top
        anchors.topMargin: 46
        width: 178
        height: 24
    }

    Part {
        id: browseResetButtonText
        name: "BrowseResetButtonText"
        kind: "FontString"
        text: "Reset"
        wowParent: "BrowseResetButton"
        anchors.horizontalCenter: browseResetButton.horizontalCenter
        anchors.verticalCenter: browseResetButton.verticalCenter
        width: 30.2
        height: 10.1
    }

    Part {
        id: browseScrollFrame
        name: "BrowseScrollFrame"
        kind: "ScrollFrame"
        wowParent: "AuctionFrameBrowse"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -798
        anchors.top: auctionFrame.top
        anchors.topMargin: 103
        width: 465
        height: 306
    }

    Part {
        id: browseScrollFrameScrollBar
        name: "BrowseScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "BrowseScrollFrame"
        style: "ScrollBar"
        anchors.left: browseScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: browseScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 274
    }

    Part {
        id: browseScrollFrameScrollBarDiabolicTrack
        name: "BrowseScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "BrowseScrollFrameScrollBar"
        anchors.horizontalCenter: browseScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: browseScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 308
    }

    Part {
        id: browseScrollFrameScrollBarScrollDownButton
        name: "BrowseScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "BrowseScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseScrollFrameScrollBar.horizontalCenter
        anchors.top: browseScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: browseScrollFrameScrollBarScrollUpButton
        name: "BrowseScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "BrowseScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseScrollFrameScrollBar.horizontalCenter
        anchors.bottom: browseScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: browseScrollFrameScrollChildFrame
        name: "BrowseScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "BrowseScrollFrame"
        anchors.left: browseScrollFrame.left
        anchors.top: browseScrollFrame.top
        width: 300
        height: 1887
    }

    Part {
        id: browseSearchButton
        name: "BrowseSearchButton"
        kind: "Button"
        text: "Search"
        wowParent: "AuctionFrameBrowse"
        style: "Button"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 676.3
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 9
        width: 80
        height: 22
    }

    Part {
        id: browseSearchButtonText
        name: "BrowseSearchButtonText"
        kind: "FontString"
        text: "Search"
        wowParent: "BrowseSearchButton"
        anchors.horizontalCenter: browseSearchButton.horizontalCenter
        anchors.verticalCenter: browseSearchButton.verticalCenter
        width: 36.6
        height: 10.1
    }

    Part {
        id: browseSearchCountText
        name: "BrowseSearchCountText"
        kind: "FontString"
        text: "Items 1 - 18  ( 118 total )"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 182
        anchors.verticalCenter: auctionFrame.top
        anchors.verticalCenterOffset: 58
        width: 121.4
        height: 10.1
    }

    Part {
        id: browseTitle
        name: "BrowseTitle"
        kind: "FontString"
        text: "Browse Auctions"
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: auctionFrameBrowse.horizontalCenter
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 18
        width: 102.7
        height: 12.2
    }

    Part {
        id: buyoutPrice
        name: "BuyoutPrice"
        kind: "Frame"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 19
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 127
        width: 176
        height: 18
    }

    Part {
        id: buyoutPriceCopper
        name: "BuyoutPriceCopper"
        kind: "EditBox"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: buyoutPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: buyoutPriceGold
        name: "BuyoutPriceGold"
        kind: "EditBox"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPrice.left
        anchors.top: buyoutPrice.top
        width: 58
        height: 20
    }

    Part {
        id: buyoutPriceSilver
        name: "BuyoutPriceSilver"
        kind: "EditBox"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: buyoutPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: durationDropDown
        name: "DurationDropDown"
        kind: "Frame"
        wowParent: "AuctionFrameAuctions"
        style: "DropDown"
        anchors.right: auctionFrameAuctions.left
        anchors.rightMargin: -201
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 91
        width: 130
        height: 32
    }

    Part {
        id: durationDropDownButton
        name: "DurationDropDownButton"
        kind: "Button"
        wowParent: "DurationDropDown"
        anchors.right: durationDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: durationDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: durationDropDownDiabolicField
        name: "DurationDropDownDiabolicField"
        kind: "Frame"
        wowParent: "DurationDropDown"
        anchors.left: durationDropDown.left
        anchors.verticalCenter: durationDropDown.verticalCenter
        width: 130
        height: 22
    }

    Part {
        id: durationDropDownText
        name: "DurationDropDownText"
        kind: "FontString"
        text: "24 Hours"
        wowParent: "DurationDropDown"
        anchors.left: durationDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: durationDropDownDiabolicField.verticalCenter
        width: 68
        height: 10
    }

    Part {
        id: isUsableCheckButton
        name: "IsUsableCheckButton"
        kind: "CheckButton"
        wowParent: "AuctionFrameBrowse"
        style: "CheckBox"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 524.8
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 4
        width: 16
        height: 16
    }

    Part {
        id: isUsableCheckButtonText
        name: "IsUsableCheckButtonText"
        kind: "FontString"
        text: "Usable Items"
        wowParent: "IsUsableCheckButton"
        anchors.left: isUsableCheckButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: isUsableCheckButton.verticalCenter
        width: 70.4
        height: 13.6
    }

    Part {
        id: priceDropDown
        name: "PriceDropDown"
        kind: "Frame"
        wowParent: "AuctionFrameAuctions"
        style: "DropDown"
        anchors.right: auctionFrameAuctions.left
        anchors.rightMargin: -201
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 213
        width: 130
        height: 32
    }

    Part {
        id: priceDropDownButton
        name: "PriceDropDownButton"
        kind: "Button"
        wowParent: "PriceDropDown"
        anchors.right: priceDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: priceDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: priceDropDownDiabolicField
        name: "PriceDropDownDiabolicField"
        kind: "Frame"
        wowParent: "PriceDropDown"
        anchors.left: priceDropDown.left
        anchors.verticalCenter: priceDropDown.verticalCenter
        width: 130
        height: 22
    }

    Part {
        id: priceDropDownText
        name: "PriceDropDownText"
        kind: "FontString"
        text: "per stack"
        wowParent: "PriceDropDown"
        anchors.left: priceDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: priceDropDownDiabolicField.verticalCenter
        width: 68
        height: 10
    }

    Part {
        id: showOnPlayerCheckButton
        name: "ShowOnPlayerCheckButton"
        kind: "CheckButton"
        wowParent: "AuctionFrameBrowse"
        style: "CheckBox"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 524.8
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 20
        width: 16
        height: 16
    }

    Part {
        id: showOnPlayerCheckButtonText
        name: "ShowOnPlayerCheckButtonText"
        kind: "FontString"
        text: "Display on Character"
        wowParent: "ShowOnPlayerCheckButton"
        anchors.left: showOnPlayerCheckButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: showOnPlayerCheckButton.verticalCenter
        width: 112.1
        height: 13.6
    }

    Part {
        id: startPrice
        name: "StartPrice"
        kind: "Frame"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 19
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 172
        width: 176
        height: 18
    }

    Part {
        id: startPriceCopper
        name: "StartPriceCopper"
        kind: "EditBox"
        wowParent: "StartPrice"
        anchors.left: startPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: startPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    Part {
        id: startPriceGold
        name: "StartPriceGold"
        kind: "EditBox"
        wowParent: "StartPrice"
        anchors.left: startPrice.left
        anchors.top: startPrice.top
        width: 58
        height: 20
    }

    Part {
        id: startPriceSilver
        name: "StartPriceSilver"
        kind: "EditBox"
        wowParent: "StartPrice"
        anchors.left: startPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: startPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Ghost { id: atr_DropDownSLMiddle; name: "Atr_DropDownSLMiddle"; x: 94; y: 19; width: 0; height: 0 }
    Ghost { id: atr_HeadingsBarMiddle; name: "Atr_HeadingsBarMiddle"; x: 226; y: 170; width: 0; height: 0 }
    Ghost { id: atr_Hilite1; name: "Atr_Hilite1"; x: 834; y: 45; width: 0; height: 0 }
    Ghost { id: auctionsDepositMoneyFrameCopperButton; name: "AuctionsDepositMoneyFrameCopperButton"; x: 119.5; y: 368.1; width: 0; height: 0 }
}
