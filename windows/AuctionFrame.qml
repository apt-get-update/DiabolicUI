// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: auctionFrame
    name: "AuctionFrame"
    width: 832
    height: 447

    FontString {
        id: atr_ActiveItems_Text
        name: "Atr_ActiveItems_Text"
        text: "Active Items"
        wowParent: "Atr_Main_Panel"
        anchors.horizontalCenter: atr_Main_Panel.horizontalCenter
        anchors.horizontalCenterOffset: -350
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 32
        width: 64.6
        height: 10.1
    }

    Button {
        id: atr_AddToSListButton
        name: "Atr_AddToSListButton"
        text: "Add Item"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: auctionFrame.left
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: 123
        width: 93.1
        height: 20
    }

    FontString {
        id: atr_AddToSListButtonText
        name: "Atr_AddToSListButtonText"
        text: "Add Item"
        wowParent: "Atr_AddToSListButton"
        anchors.horizontalCenter: atr_AddToSListButton.horizontalCenter
        anchors.verticalCenter: atr_AddToSListButton.verticalCenter
        width: 48.8
        height: 10.1
    }

    Button {
        id: atr_Adv_Search_Button
        name: "Atr_Adv_Search_Button"
        text: "+"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.left: atr_Search_Button.right
        anchors.leftMargin: 12
        anchors.verticalCenter: atr_Search_Button.verticalCenter
        width: 22
        height: 22
    }

    FontString {
        id: atr_Adv_Search_ButtonText
        name: "Atr_Adv_Search_ButtonText"
        text: "+"
        wowParent: "Atr_Adv_Search_Button"
        anchors.horizontalCenter: atr_Adv_Search_Button.horizontalCenter
        anchors.verticalCenter: atr_Adv_Search_Button.verticalCenter
        width: 6.5
        height: 10.1
    }

    FontString {
        id: atr_Batch_MaxAuctions_Text
        name: "Atr_Batch_MaxAuctions_Text"
        text: "max: 0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: -34
        anchors.top: atr_Batch_Stacksize_Text.top
        anchors.topMargin: 21
        width: 34.5
        height: 10.1
    }

    FontString {
        id: atr_Batch_MaxStacksize_Text
        name: "Atr_Batch_MaxStacksize_Text"
        text: "max: 0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: 79
        anchors.top: atr_Batch_Stacksize_Text.top
        anchors.topMargin: 21
        width: 34.5
        height: 10.1
    }

    EditBox {
        id: atr_Batch_NumAuctions
        name: "Atr_Batch_NumAuctions"
        text: "0"
        wowParent: "Atr_SellControls"
        anchors.left: atr_Batch_Stacksize_Text.left
        anchors.leftMargin: -37
        anchors.top: atr_Batch_Stacksize_Text.top
        width: 40
        height: 20
    }

    EditBox {
        id: atr_Batch_Stacksize
        name: "Atr_Batch_Stacksize"
        text: "0"
        wowParent: "Atr_SellControls"
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
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 55
        anchors.top: atr_SellControls.top
        anchors.topMargin: 224
        width: 82
        height: 22
    }

    Button {
        id: atr_Buy1_Button
        name: "Atr_Buy1_Button"
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

    FontString {
        id: atr_Buy1_ButtonText
        name: "Atr_Buy1_ButtonText"
        text: "Buy"
        wowParent: "Atr_Buy1_Button"
        anchors.horizontalCenter: atr_Buy1_Button.horizontalCenter
        anchors.verticalCenter: atr_Buy1_Button.verticalCenter
        width: 20.1
        height: 10.1
    }

    Button {
        id: atr_CancelSelectionButton
        name: "Atr_CancelSelectionButton"
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

    FontString {
        id: atr_CancelSelectionButtonText
        name: "Atr_CancelSelectionButtonText"
        text: "Cancel Auctions"
        wowParent: "Atr_CancelSelectionButton"
        anchors.horizontalCenter: atr_CancelSelectionButton.horizontalCenter
        anchors.verticalCenter: atr_CancelSelectionButton.verticalCenter
        width: 86.9
        height: 10.1
    }

    Button {
        id: atr_CheckActiveButton
        name: "Atr_CheckActiveButton"
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

    FontString {
        id: atr_CheckActiveButtonText
        name: "Atr_CheckActiveButtonText"
        text: "Check for Undercuts"
        wowParent: "Atr_CheckActiveButton"
        anchors.horizontalCenter: atr_CheckActiveButton.horizontalCenter
        anchors.verticalCenter: atr_CheckActiveButton.verticalCenter
        width: 110.6
        height: 10.1
    }

    FontString {
        id: atr_Col1_Heading
        name: "Atr_Col1_Heading"
        text: "Item Price"
        wowParent: "Atr_HeadingsBar"
        anchors.left: atr_HeadingsBarMiddle.left
        anchors.leftMargin: 40
        anchors.verticalCenter: atr_HeadingsBarMiddle.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 10.1
    }

    FontString {
        id: atr_Col3_Heading
        name: "Atr_Col3_Heading"
        text: "Current Auctions"
        wowParent: "Atr_HeadingsBar"
        anchors.left: atr_HeadingsBarMiddle.left
        anchors.leftMargin: 205
        anchors.verticalCenter: atr_HeadingsBarMiddle.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 86.2
        height: 10.1
    }

    FontString {
        id: atr_Col4_Heading
        name: "Atr_Col4_Heading"
        wowParent: "Atr_HeadingsBar"
        anchors.left: atr_HeadingsBarMiddle.left
        anchors.leftMargin: 500
        anchors.verticalCenter: atr_HeadingsBarMiddle.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 1
        height: 1
    }

    Button {
        id: atr_CreateAuctionButton
        name: "Atr_CreateAuctionButton"
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

    FontString {
        id: atr_CreateAuctionButtonText
        name: "Atr_CreateAuctionButtonText"
        text: "Create Auction"
        wowParent: "Atr_CreateAuctionButton"
        anchors.horizontalCenter: atr_CreateAuctionButton.horizontalCenter
        anchors.verticalCenter: atr_CreateAuctionButton.verticalCenter
        width: 81.2
        height: 10.1
    }

    FontString {
        id: atr_Deposit_Text
        name: "Atr_Deposit_Text"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 345
        width: 1
        height: 1
    }

    Frame {
        id: atr_DropDownSL
        name: "Atr_DropDownSL"
        wowParent: "Atr_Main_Panel"
        style: "DropDown"
        anchors.left: auctionFrameDiabolicBand.left
        anchors.leftMargin: -6
        anchors.verticalCenter: auctionFrameDiabolicBand.verticalCenter
        width: 200
        height: 32
    }

    Button {
        id: atr_DropDownSLButton
        name: "Atr_DropDownSLButton"
        wowParent: "Atr_DropDownSL"
        anchors.right: atr_DropDownSLDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: atr_DropDownSLDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: atr_DropDownSLDiabolicField
        name: "Atr_DropDownSLDiabolicField"
        wowParent: "Atr_DropDownSL"
        anchors.left: atr_DropDownSL.left
        anchors.verticalCenter: atr_DropDownSL.verticalCenter
        width: 200
        height: 22
    }

    FontString {
        id: atr_DropDownSLText
        name: "Atr_DropDownSLText"
        text: "Recent Searches"
        wowParent: "Atr_DropDownSL"
        anchors.horizontalCenter: atr_DropDownSLMiddle.horizontalCenter
        anchors.horizontalCenterOffset: -5
        anchors.verticalCenter: atr_DropDownSLMiddle.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 125
        height: 10
    }

    Frame {
        id: atr_Duration
        name: "Atr_Duration"
        wowParent: "Atr_SellControls"
        style: "DropDown"
        anchors.left: atr_Duration_Text.left
        anchors.leftMargin: 32
        anchors.top: atr_Duration_Text.top
        anchors.topMargin: -7
        width: 145
        height: 32
    }

    Button {
        id: atr_DurationButton
        name: "Atr_DurationButton"
        wowParent: "Atr_Duration"
        anchors.right: atr_DurationDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: atr_DurationDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: atr_DurationDiabolicField
        name: "Atr_DurationDiabolicField"
        wowParent: "Atr_Duration"
        anchors.left: atr_Duration.left
        anchors.verticalCenter: atr_Duration.verticalCenter
        width: 145
        height: 22
    }

    FontString {
        id: atr_DurationText
        name: "Atr_DurationText"
        text: "48 Hours"
        wowParent: "Atr_Duration"
        anchors.left: atr_DurationDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: atr_DurationDiabolicField.verticalCenter
        width: 83
        height: 10
    }

    FontString {
        id: atr_Duration_Text
        name: "Atr_Duration_Text"
        text: "Duration"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 304
        width: 43.8
        height: 10.1
    }

    Button {
        id: atr_FullScanButton
        name: "Atr_FullScanButton"
        text: "Full Scan..."
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionator1Button.left
        anchors.rightMargin: 12
        anchors.verticalCenter: auctionator1Button.verticalCenter
        width: 74
        height: 22
    }

    FontString {
        id: atr_FullScanButtonText
        name: "Atr_FullScanButtonText"
        text: "Full Scan..."
        wowParent: "Atr_FullScanButton"
        anchors.horizontalCenter: atr_FullScanButton.horizontalCenter
        anchors.verticalCenter: atr_FullScanButton.verticalCenter
        width: 58.9
        height: 10.1
    }

    Frame {
        id: atr_HeadingsBar
        name: "Atr_HeadingsBar"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 16
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 138
        width: 605
        height: 64
    }

    Button {
        id: atr_Hilite1_btn
        name: "Atr_Hilite1_btn"
        wowParent: "Atr_Main_Panel"
        anchors.right: atr_Hilite1.right
        anchors.top: atr_Hilite1.top
        width: 805
        height: 341
    }

    Frame {
        id: atr_Hlist
        name: "Atr_Hlist"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -208
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 50
        width: 170
        height: 335
    }

    ScrollFrame {
        id: atr_Hlist_ScrollFrame
        name: "Atr_Hlist_ScrollFrame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -208
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 50
        width: 170
        height: 252
    }

    Slider {
        id: atr_Hlist_ScrollFrameScrollBar
        name: "Atr_Hlist_ScrollFrameScrollBar"
        wowParent: "Atr_Hlist_ScrollFrame"
        style: "ScrollBar"
        anchors.left: atr_Hlist_ScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: atr_Hlist_ScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 220
    }

    Frame {
        id: atr_Hlist_ScrollFrameScrollBarDiabolicTrack
        name: "Atr_Hlist_ScrollFrameScrollBarDiabolicTrack"
        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
        anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: atr_Hlist_ScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 254
    }

    Button {
        id: atr_Hlist_ScrollFrameScrollBarScrollDownButton
        name: "Atr_Hlist_ScrollFrameScrollBarScrollDownButton"
        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBar.horizontalCenter
        anchors.top: atr_Hlist_ScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: atr_Hlist_ScrollFrameScrollBarScrollUpButton
        name: "Atr_Hlist_ScrollFrameScrollBarScrollUpButton"
        wowParent: "Atr_Hlist_ScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: atr_Hlist_ScrollFrameScrollBar.horizontalCenter
        anchors.bottom: atr_Hlist_ScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: atr_Hlist_ScrollFrameScrollChildFrame
        name: "Atr_Hlist_ScrollFrameScrollChildFrame"
        wowParent: "Atr_Hlist_ScrollFrame"
        anchors.left: atr_Hlist_ScrollFrame.left
        anchors.top: atr_Hlist_ScrollFrame.top
        width: 300
        height: 800
    }

    FontString {
        id: atr_ItemsOwned_Text
        name: "Atr_ItemsOwned_Text"
        text: "Items owned: 0"
        wowParent: "Atr_SellControls"
        anchors.horizontalCenter: atr_Batch_Stacksize_Text.horizontalCenter
        anchors.verticalCenter: atr_Batch_Stacksize_Text.verticalCenter
        anchors.verticalCenterOffset: -22
        width: 79
        height: 10.1
    }

    Frame {
        id: atr_ListTabs
        name: "Atr_ListTabs"
        wowParent: "Atr_Main_Panel"
        anchors.right: atr_HeadingsBar.right
        anchors.bottom: atr_HeadingsBar.top
        anchors.bottomMargin: -22
        width: 250
        height: 40
    }

    Button {
        id: atr_ListTabsTab1
        name: "Atr_ListTabsTab1"
        text: "Current"
        wowParent: "Atr_ListTabs"
        style: "Tab"
        anchors.right: atr_ListTabsTab2.left
        anchors.rightMargin: 2
        anchors.verticalCenter: atr_ListTabsTab2.verticalCenter
        width: 70.4
        height: 32
    }

    FontString {
        id: atr_ListTabsTab1Text
        name: "Atr_ListTabsTab1Text"
        text: "Current"
        wowParent: "Atr_ListTabsTab1"
        anchors.horizontalCenter: atr_ListTabsTab1.horizontalCenter
        anchors.verticalCenter: atr_ListTabsTab1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 53.2
        height: 13
    }

    Button {
        id: atr_ListTabsTab2
        name: "Atr_ListTabsTab2"
        text: "History"
        wowParent: "Atr_ListTabs"
        style: "Tab"
        anchors.right: atr_ListTabsTab3.left
        anchors.rightMargin: 2
        anchors.verticalCenter: atr_ListTabsTab3.verticalCenter
        width: 69
        height: 32
    }

    FontString {
        id: atr_ListTabsTab2Text
        name: "Atr_ListTabsTab2Text"
        text: "History"
        wowParent: "Atr_ListTabsTab2"
        anchors.horizontalCenter: atr_ListTabsTab2.horizontalCenter
        anchors.verticalCenter: atr_ListTabsTab2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 50.3
        height: 13
    }

    Button {
        id: atr_ListTabsTab3
        name: "Atr_ListTabsTab3"
        text: "Other"
        wowParent: "Atr_ListTabs"
        style: "Tab"
        anchors.right: atr_ListTabs.right
        anchors.rightMargin: 8
        anchors.bottom: atr_ListTabs.bottom
        width: 61.9
        height: 32
    }

    FontString {
        id: atr_ListTabsTab3Text
        name: "Atr_ListTabsTab3Text"
        text: "Other"
        wowParent: "Atr_ListTabsTab3"
        anchors.horizontalCenter: atr_ListTabsTab3.horizontalCenter
        anchors.verticalCenter: atr_ListTabsTab3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 38.8
        height: 13
    }

    Frame {
        id: atr_Main_Panel
        name: "Atr_Main_Panel"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 210
        anchors.top: auctionFrame.top
        width: 548
        height: 447
    }

    Button {
        id: atr_MngSListsButton
        name: "Atr_MngSListsButton"
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

    FontString {
        id: atr_MngSListsButtonText
        name: "Atr_MngSListsButtonText"
        text: "Manage Shopping Lists"
        wowParent: "Atr_MngSListsButton"
        anchors.horizontalCenter: atr_MngSListsButton.horizontalCenter
        anchors.verticalCenter: atr_MngSListsButton.verticalCenter
        width: 123.5
        height: 10.1
    }

    Button {
        id: atr_NewSListButton
        name: "Atr_NewSListButton"
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

    FontString {
        id: atr_NewSListButtonText
        name: "Atr_NewSListButtonText"
        text: "New Shopping List"
        wowParent: "Atr_NewSListButton"
        anchors.horizontalCenter: atr_NewSListButton.horizontalCenter
        anchors.verticalCenter: atr_NewSListButton.verticalCenter
        width: 98.4
        height: 10.1
    }

    Button {
        id: atr_RecommendItem_Tex
        name: "Atr_RecommendItem_Tex"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 34
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 62
        width: 37
        height: 37
    }

    Frame {
        id: atr_RecommendPerItem_Price
        name: "Atr_RecommendPerItem_Price"
        wowParent: "?"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 131.7
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 121
        width: 107.3
        height: 16
    }

    Button {
        id: atr_RecommendPerItem_PriceCopperButton
        name: "Atr_RecommendPerItem_PriceCopperButton"
        text: "0"
        wowParent: "Atr_RecommendPerItem_Price"
        anchors.right: atr_RecommendPerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: atr_RecommendPerItem_PriceCopperButtonText
        name: "Atr_RecommendPerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "Atr_RecommendPerItem_PriceCopperButton"
        anchors.right: atr_RecommendPerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: atr_RecommendPerItem_PriceGoldButton
        name: "Atr_RecommendPerItem_PriceGoldButton"
        text: "4"
        wowParent: "Atr_RecommendPerItem_Price"
        anchors.right: atr_RecommendPerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: atr_RecommendPerItem_PriceGoldButtonText
        name: "Atr_RecommendPerItem_PriceGoldButtonText"
        text: "4"
        wowParent: "Atr_RecommendPerItem_PriceGoldButton"
        anchors.right: atr_RecommendPerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: atr_RecommendPerItem_PriceSilverButton
        name: "Atr_RecommendPerItem_PriceSilverButton"
        text: "94"
        wowParent: "Atr_RecommendPerItem_Price"
        anchors.right: atr_RecommendPerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: atr_RecommendPerItem_PriceSilverButtonText
        name: "Atr_RecommendPerItem_PriceSilverButtonText"
        text: "94"
        wowParent: "Atr_RecommendPerItem_PriceSilverButton"
        anchors.right: atr_RecommendPerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: atr_RecommendPerItem_Text
        name: "Atr_RecommendPerItem_Text"
        text: "per item"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Recommend_Text.left
        anchors.leftMargin: 152
        anchors.top: atr_Recommend_Text.top
        anchors.topMargin: 51
        width: 43.1
        height: 10.1
    }

    Frame {
        id: atr_RecommendPerStack_Price
        name: "Atr_RecommendPerStack_Price"
        wowParent: "?"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 131.7
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 99
        width: 107.3
        height: 16
    }

    Button {
        id: atr_RecommendPerStack_PriceCopperButton
        name: "Atr_RecommendPerStack_PriceCopperButton"
        text: "0"
        wowParent: "Atr_RecommendPerStack_Price"
        anchors.right: atr_RecommendPerStack_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: atr_RecommendPerStack_PriceCopperButtonText
        name: "Atr_RecommendPerStack_PriceCopperButtonText"
        text: "0"
        wowParent: "Atr_RecommendPerStack_PriceCopperButton"
        anchors.right: atr_RecommendPerStack_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: atr_RecommendPerStack_PriceGoldButton
        name: "Atr_RecommendPerStack_PriceGoldButton"
        text: "4"
        wowParent: "Atr_RecommendPerStack_Price"
        anchors.right: atr_RecommendPerStack_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerStack_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: atr_RecommendPerStack_PriceGoldButtonText
        name: "Atr_RecommendPerStack_PriceGoldButtonText"
        text: "4"
        wowParent: "Atr_RecommendPerStack_PriceGoldButton"
        anchors.right: atr_RecommendPerStack_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: atr_RecommendPerStack_PriceSilverButton
        name: "Atr_RecommendPerStack_PriceSilverButton"
        text: "94"
        wowParent: "Atr_RecommendPerStack_Price"
        anchors.right: atr_RecommendPerStack_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: atr_RecommendPerStack_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: atr_RecommendPerStack_PriceSilverButtonText
        name: "Atr_RecommendPerStack_PriceSilverButtonText"
        text: "94"
        wowParent: "Atr_RecommendPerStack_PriceSilverButton"
        anchors.right: atr_RecommendPerStack_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: atr_RecommendPerStack_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: atr_RecommendPerStack_Text
        name: "Atr_RecommendPerStack_Text"
        text: "for your stack of 1"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Recommend_Text.left
        anchors.leftMargin: 152
        anchors.top: atr_Recommend_Text.top
        anchors.topMargin: 28
        width: 89.8
        height: 10.1
    }

    FontString {
        id: atr_Recommend_Basis_Text
        name: "Atr_Recommend_Basis_Text"
        text: "(based on selected auction)"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Recommend_Text.right
        anchors.leftMargin: 20
        anchors.verticalCenter: atr_Recommend_Text.verticalCenter
        anchors.verticalCenterOffset: 2
        width: 140.1
        height: 10.1
    }

    FontString {
        id: atr_Recommend_Text
        name: "Atr_Recommend_Text"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 87
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 73
        width: 1
        height: 1
    }

    Button {
        id: atr_RemFromSListButton
        name: "Atr_RemFromSListButton"
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

    FontString {
        id: atr_RemFromSListButtonText
        name: "Atr_RemFromSListButtonText"
        text: "Remove Item"
        wowParent: "Atr_RemFromSListButton"
        anchors.horizontalCenter: atr_RemFromSListButton.horizontalCenter
        anchors.verticalCenter: atr_RemFromSListButton.verticalCenter
        width: 71.1
        height: 10.1
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
    }

    Frame {
        id: atr_Search_BoxDiabolicField
        name: "Atr_Search_BoxDiabolicField"
        wowParent: "Atr_Search_Box"
        anchors.left: atr_Search_Box.left
        anchors.leftMargin: -8
        anchors.verticalCenter: atr_Search_Box.verticalCenter
        width: 276
        height: 22
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
    }

    FontString {
        id: atr_Search_ButtonText
        name: "Atr_Search_ButtonText"
        text: "Search"
        wowParent: "Atr_Search_Button"
        anchors.horizontalCenter: atr_Search_Button.horizontalCenter
        anchors.verticalCenter: atr_Search_Button.verticalCenter
        width: 36.6
        height: 10.1
    }

    Frame {
        id: atr_SellControls
        name: "Atr_SellControls"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: -205
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 47
        width: 190
        height: 338
    }

    Button {
        id: atr_SellControls_Tex
        name: "Atr_SellControls_Tex"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 11
        anchors.top: atr_SellControls.top
        anchors.topMargin: 23
        width: 37
        height: 37
    }

    FontString {
        id: atr_SellControls_TexName
        name: "Atr_SellControls_TexName"
        wowParent: "Atr_SellControls_Tex"
        anchors.left: atr_SellControls_Tex.right
        anchors.leftMargin: 5
        anchors.top: atr_SellControls_Tex.top
        width: 124
        height: 30
    }

    Button {
        id: atr_SrchSListButton
        name: "Atr_SrchSListButton"
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

    FontString {
        id: atr_SrchSListButtonText
        name: "Atr_SrchSListButtonText"
        text: "Search for All Items"
        wowParent: "Atr_SrchSListButton"
        anchors.horizontalCenter: atr_SrchSListButton.horizontalCenter
        anchors.verticalCenter: atr_SrchSListButton.verticalCenter
        width: 107
        height: 10.1
    }

    Frame {
        id: atr_StackPrice
        name: "Atr_StackPrice"
        wowParent: "Atr_SellControls"
        anchors.left: atr_StackPriceText.left
        anchors.leftMargin: 8
        anchors.top: atr_StackPriceText.bottom
        anchors.topMargin: 2
        width: 176
        height: 18
    }

    EditBox {
        id: atr_StackPriceCopper
        name: "Atr_StackPriceCopper"
        wowParent: "Atr_StackPrice"
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
        wowParent: "Atr_StackPrice"
        anchors.left: atr_StackPrice.left
        anchors.top: atr_StackPrice.top
        width: 58
        height: 20
    }

    EditBox {
        id: atr_StackPriceSilver
        name: "Atr_StackPriceSilver"
        text: "0"
        wowParent: "Atr_StackPrice"
        anchors.left: atr_StackPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: atr_StackPriceGold.verticalCenter
        width: 30
        height: 20
    }

    FontString {
        id: atr_StackPriceText
        name: "Atr_StackPriceText"
        text: "Buyout Price"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 82
        width: 63.9
        height: 10.1
    }

    FontString {
        id: atr_StartingPriceDiscountText
        name: "Atr_StartingPriceDiscountText"
        text: "Starting Price Discount:  5%"
        wowParent: "Atr_SellControls"
        anchors.left: atr_SellControls.left
        anchors.leftMargin: 10
        anchors.top: atr_SellControls.top
        anchors.topMargin: 270
        width: 137.9
        height: 10.1
    }

    Button {
        id: auctionFilterButton1
        name: "AuctionFilterButton1"
        text: "Weapon"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 2
        anchors.top: auctionFrame.top
        anchors.topMargin: 82
        width: 156
        height: 20
    }

    Button {
        id: auctionFilterButton10
        name: "AuctionFilterButton10"
        text: "Gem"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton9.left
        anchors.top: auctionFilterButton9.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton10NormalText
        name: "AuctionFilterButton10NormalText"
        text: "Gem"
        wowParent: "AuctionFilterButton10"
        anchors.left: auctionFilterButton10.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton10.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton11
        name: "AuctionFilterButton11"
        text: "Miscellaneous"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton10.left
        anchors.top: auctionFilterButton10.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton11NormalText
        name: "AuctionFilterButton11NormalText"
        text: "Miscellaneous"
        wowParent: "AuctionFilterButton11"
        anchors.left: auctionFilterButton11.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton11.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton12
        name: "AuctionFilterButton12"
        text: "Quest"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton11.left
        anchors.top: auctionFilterButton11.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton12NormalText
        name: "AuctionFilterButton12NormalText"
        text: "Quest"
        wowParent: "AuctionFilterButton12"
        anchors.left: auctionFilterButton12.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton12.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton13
        name: "AuctionFilterButton13"
        text: "Consumable"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton12.left
        anchors.top: auctionFilterButton12.bottom
        width: 136
        height: 20
    }

    FontString {
        id: auctionFilterButton13NormalText
        name: "AuctionFilterButton13NormalText"
        text: "Consumable"
        wowParent: "AuctionFilterButton13"
        anchors.left: auctionFilterButton13.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton13.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton14
        name: "AuctionFilterButton14"
        text: "Glyph"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton13.left
        anchors.top: auctionFilterButton13.bottom
        width: 136
        height: 20
    }

    FontString {
        id: auctionFilterButton14NormalText
        name: "AuctionFilterButton14NormalText"
        text: "Glyph"
        wowParent: "AuctionFilterButton14"
        anchors.left: auctionFilterButton14.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton14.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton15
        name: "AuctionFilterButton15"
        text: "Trade Goods"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton14.left
        anchors.top: auctionFilterButton14.bottom
        width: 136
        height: 20
    }

    FontString {
        id: auctionFilterButton15NormalText
        name: "AuctionFilterButton15NormalText"
        text: "Trade Goods"
        wowParent: "AuctionFilterButton15"
        anchors.left: auctionFilterButton15.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton15.verticalCenter
        width: 115
        height: 8
    }

    FontString {
        id: auctionFilterButton1NormalText
        name: "AuctionFilterButton1NormalText"
        text: "Weapon"
        wowParent: "AuctionFilterButton1"
        anchors.left: auctionFilterButton1.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton1.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton2
        name: "AuctionFilterButton2"
        text: "Armor"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton1.left
        anchors.top: auctionFilterButton1.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton2NormalText
        name: "AuctionFilterButton2NormalText"
        text: "Armor"
        wowParent: "AuctionFilterButton2"
        anchors.left: auctionFilterButton2.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton2.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton3
        name: "AuctionFilterButton3"
        text: "Container"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton2.left
        anchors.top: auctionFilterButton2.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton3NormalText
        name: "AuctionFilterButton3NormalText"
        text: "Container"
        wowParent: "AuctionFilterButton3"
        anchors.left: auctionFilterButton3.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton3.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton4
        name: "AuctionFilterButton4"
        text: "Consumable"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton3.left
        anchors.top: auctionFilterButton3.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton4NormalText
        name: "AuctionFilterButton4NormalText"
        text: "Consumable"
        wowParent: "AuctionFilterButton4"
        anchors.left: auctionFilterButton4.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton4.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton5
        name: "AuctionFilterButton5"
        text: "Glyph"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton4.left
        anchors.top: auctionFilterButton4.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton5NormalText
        name: "AuctionFilterButton5NormalText"
        text: "Glyph"
        wowParent: "AuctionFilterButton5"
        anchors.left: auctionFilterButton5.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton5.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton6
        name: "AuctionFilterButton6"
        text: "Trade Goods"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton5.left
        anchors.top: auctionFilterButton5.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton6NormalText
        name: "AuctionFilterButton6NormalText"
        text: "Trade Goods"
        wowParent: "AuctionFilterButton6"
        anchors.left: auctionFilterButton6.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton6.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton7
        name: "AuctionFilterButton7"
        text: "Projectile"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton6.left
        anchors.top: auctionFilterButton6.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton7NormalText
        name: "AuctionFilterButton7NormalText"
        text: "Projectile"
        wowParent: "AuctionFilterButton7"
        anchors.left: auctionFilterButton7.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton7.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton8
        name: "AuctionFilterButton8"
        text: "Quiver"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton7.left
        anchors.top: auctionFilterButton7.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton8NormalText
        name: "AuctionFilterButton8NormalText"
        text: "Quiver"
        wowParent: "AuctionFilterButton8"
        anchors.left: auctionFilterButton8.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton8.verticalCenter
        width: 115
        height: 8
    }

    Button {
        id: auctionFilterButton9
        name: "AuctionFilterButton9"
        text: "Recipe"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFilterButton8.left
        anchors.top: auctionFilterButton8.bottom
        width: 156
        height: 20
    }

    FontString {
        id: auctionFilterButton9NormalText
        name: "AuctionFilterButton9NormalText"
        text: "Recipe"
        wowParent: "AuctionFilterButton9"
        anchors.left: auctionFilterButton9.left
        anchors.leftMargin: 4
        anchors.verticalCenter: auctionFilterButton9.verticalCenter
        width: 115
        height: 8
    }

    Frame {
        id: auctionFrameAuctions
        name: "AuctionFrameAuctions"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.top: auctionFrame.top
        width: 758
        height: 447
    }

    Frame {
        id: auctionFrameBid
        name: "AuctionFrameBid"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.top: auctionFrame.top
        width: 758
        height: 447
    }

    Frame {
        id: auctionFrameBrowse
        name: "AuctionFrameBrowse"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.top: auctionFrame.top
        width: 758
        height: 447
    }

    Button {
        id: auctionFrameCloseButton
        name: "AuctionFrameCloseButton"
        wowParent: "AuctionFrame"
        style: "CloseButton"
        anchors.horizontalCenter: auctionFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: auctionFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: auctionFrameDiabolic
        name: "AuctionFrameDiabolic"
        wowParent: "AuctionFrame"
        anchors.left: auctionFrame.left
        anchors.leftMargin: -24
        anchors.top: auctionFrame.top
        anchors.topMargin: -56
        width: 880
        height: 551
    }

    Frame {
        id: auctionFrameDiabolicBand
        name: "AuctionFrameDiabolicBand"
        wowParent: "AuctionFrameDiabolic"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: auctionFrameDiabolic.top
        anchors.topMargin: 56
        width: 832
        height: 40
    }

    Frame {
        id: auctionFrameDiabolicBorder
        name: "AuctionFrameDiabolicBorder"
        wowParent: "AuctionFrameDiabolic"
        anchors.left: auctionFrameDiabolic.left
        anchors.top: auctionFrameDiabolic.top
        anchors.topMargin: 32
        width: 880
        height: 519
    }

    Frame {
        id: auctionFrameDiabolicFoot
        name: "AuctionFrameDiabolicFoot"
        wowParent: "AuctionFrameDiabolic"
        anchors.horizontalCenter: browseCloseButton.horizontalCenter
        anchors.horizontalCenterOffset: -370
        anchors.top: browseCloseButton.top
        anchors.topMargin: -6
        width: 834
        height: 41
    }

    Frame {
        id: auctionFrameDiabolicRail
        name: "AuctionFrameDiabolicRail"
        wowParent: "AuctionFrameDiabolic"
        anchors.left: auctionFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: auctionFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 362
        height: 18
    }

    Frame {
        id: auctionFrameDiabolicSocket
        name: "AuctionFrameDiabolicSocket"
        wowParent: "AuctionFrameDiabolic"
        anchors.right: auctionFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: auctionFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: auctionFrameDiabolicTitlePlate
        name: "AuctionFrameDiabolicTitlePlate"
        wowParent: "AuctionFrameDiabolic"
        anchors.horizontalCenter: auctionFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: auctionFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Frame {
        id: auctionFrameMoneyFrame
        name: "AuctionFrameMoneyFrame"
        wowParent: "AuctionFrame"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -181
        anchors.bottom: auctionFrame.bottom
        anchors.bottomMargin: -6
        width: 120.3
        height: 13
    }

    Button {
        id: auctionFrameMoneyFrameCopperButton
        name: "AuctionFrameMoneyFrameCopperButton"
        text: "13"
        wowParent: "AuctionFrameMoneyFrame"
        anchors.right: auctionFrameMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrame.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionFrameMoneyFrameCopperButtonText
        name: "AuctionFrameMoneyFrameCopperButtonText"
        text: "13"
        wowParent: "AuctionFrameMoneyFrameCopperButton"
        anchors.right: auctionFrameMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionFrameMoneyFrameGoldButton
        name: "AuctionFrameMoneyFrameGoldButton"
        text: "3654"
        wowParent: "AuctionFrameMoneyFrame"
        anchors.right: auctionFrameMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionFrameMoneyFrameSilverButton.verticalCenter
        width: 41.7
        height: 13
    }

    FontString {
        id: auctionFrameMoneyFrameGoldButtonText
        name: "AuctionFrameMoneyFrameGoldButtonText"
        text: "3654"
        wowParent: "AuctionFrameMoneyFrameGoldButton"
        anchors.right: auctionFrameMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrameGoldButton.verticalCenter
        width: 28.7
        height: 13.6
    }

    Button {
        id: auctionFrameMoneyFrameSilverButton
        name: "AuctionFrameMoneyFrameSilverButton"
        text: "16"
        wowParent: "AuctionFrameMoneyFrame"
        anchors.right: auctionFrameMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionFrameMoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionFrameMoneyFrameSilverButtonText
        name: "AuctionFrameMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "AuctionFrameMoneyFrameSilverButton"
        anchors.right: auctionFrameMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionFrameMoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionFrameTab1
        name: "AuctionFrameTab1"
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

    Button {
        id: auctionFrameTab2
        name: "AuctionFrameTab2"
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

    Button {
        id: auctionFrameTab3
        name: "AuctionFrameTab3"
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

    Button {
        id: auctionFrameTab4
        name: "AuctionFrameTab4"
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

    Button {
        id: auctionFrameTab5
        name: "AuctionFrameTab5"
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

    Button {
        id: auctionFrameTab6
        name: "AuctionFrameTab6"
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

    Button {
        id: auctionator1Button
        name: "Auctionator1Button"
        text: "Options"
        wowParent: "Atr_Main_Panel"
        style: "Button"
        anchors.right: auctionFrameDiabolicBand.right
        anchors.rightMargin: 48
        anchors.verticalCenter: auctionFrameDiabolicBand.verticalCenter
        width: 70
        height: 22
    }

    FontString {
        id: auctionator1ButtonText
        name: "Auctionator1ButtonText"
        text: "Options"
        wowParent: "Auctionator1Button"
        anchors.horizontalCenter: auctionator1Button.horizontalCenter
        anchors.verticalCenter: auctionator1Button.verticalCenter
        width: 43.1
        height: 10.1
    }

    Button {
        id: auctionatorCloseButton
        name: "AuctionatorCloseButton"
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

    FontString {
        id: auctionatorCloseButtonText
        name: "AuctionatorCloseButtonText"
        text: "Close"
        wowParent: "AuctionatorCloseButton"
        anchors.horizontalCenter: auctionatorCloseButton.horizontalCenter
        anchors.verticalCenter: auctionatorCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Button {
        id: auctionatorEntry1
        name: "AuctionatorEntry1"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorScrollFrame.left
        anchors.leftMargin: 8
        anchors.top: auctionatorScrollFrame.top
        width: 584
        height: 16
    }

    Button {
        id: auctionatorEntry10
        name: "AuctionatorEntry10"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry9.left
        anchors.top: auctionatorEntry9.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry10_EntryText
        name: "AuctionatorEntry10_EntryText"
        text: "1 stack of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry10.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry10.top
        anchors.topMargin: 3
        width: 57.5
        height: 10.1
    }

    Frame {
        id: auctionatorEntry10_PerItem_Price
        name: "AuctionatorEntry10_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry10.left
        anchors.leftMargin: 28.2
        anchors.top: auctionatorEntry10.top
        anchors.topMargin: 1.5
        width: 113.8
        height: 13
    }

    Button {
        id: auctionatorEntry10_PerItem_PriceCopperButton
        name: "AuctionatorEntry10_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry10_PerItem_Price"
        anchors.right: auctionatorEntry10_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry10_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry10_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry10_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry10_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry10_PerItem_PriceGoldButton
        name: "AuctionatorEntry10_PerItem_PriceGoldButton"
        text: "22"
        wowParent: "AuctionatorEntry10_PerItem_Price"
        anchors.right: auctionatorEntry10_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceSilverButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry10_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry10_PerItem_PriceGoldButtonText"
        text: "22"
        wowParent: "AuctionatorEntry10_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry10_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceGoldButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionatorEntry10_PerItem_PriceSilverButton
        name: "AuctionatorEntry10_PerItem_PriceSilverButton"
        text: "50"
        wowParent: "AuctionatorEntry10_PerItem_Price"
        anchors.right: auctionatorEntry10_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry10_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry10_PerItem_PriceSilverButtonText"
        text: "50"
        wowParent: "AuctionatorEntry10_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry10_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry10_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry10_StackPrice
        name: "AuctionatorEntry10_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry10.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry10.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorEntry11
        name: "AuctionatorEntry11"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry10.left
        anchors.top: auctionatorEntry10.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry11_EntryText
        name: "AuctionatorEntry11_EntryText"
        text: "47 stacks of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry11.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry11.top
        anchors.topMargin: 3
        width: 69
        height: 10.1
    }

    Frame {
        id: auctionatorEntry11_PerItem_Price
        name: "AuctionatorEntry11_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry11.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry11.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry11_PerItem_PriceCopperButton
        name: "AuctionatorEntry11_PerItem_PriceCopperButton"
        text: "99"
        wowParent: "AuctionatorEntry11_PerItem_Price"
        anchors.right: auctionatorEntry11_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry11_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry11_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry11_PerItem_PriceCopperButtonText"
        text: "99"
        wowParent: "AuctionatorEntry11_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry11_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry11_PerItem_PriceCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionatorEntry11_PerItem_PriceSilverButton
        name: "AuctionatorEntry11_PerItem_PriceSilverButton"
        text: "38"
        wowParent: "AuctionatorEntry11_PerItem_Price"
        anchors.right: auctionatorEntry11_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry11_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry11_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry11_PerItem_PriceSilverButtonText"
        text: "38"
        wowParent: "AuctionatorEntry11_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry11_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry11_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry11_StackPrice
        name: "AuctionatorEntry11_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry11.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry11.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorEntry12
        name: "AuctionatorEntry12"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry11.left
        anchors.top: auctionatorEntry11.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry12_EntryText
        name: "AuctionatorEntry12_EntryText"
        text: "10 stacks of 5"
        wowParent: "?"
        anchors.left: auctionatorEntry12.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry12.top
        anchors.topMargin: 3
        width: 68.3
        height: 10.1
    }

    Frame {
        id: auctionatorEntry12_PerItem_Price
        name: "AuctionatorEntry12_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry12.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry12.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry12_PerItem_PriceCopperButton
        name: "AuctionatorEntry12_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry12_PerItem_Price"
        anchors.right: auctionatorEntry12_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry12_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry12_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry12_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry12_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry12_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry12_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry12_PerItem_PriceSilverButton
        name: "AuctionatorEntry12_PerItem_PriceSilverButton"
        text: "39"
        wowParent: "AuctionatorEntry12_PerItem_Price"
        anchors.right: auctionatorEntry12_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry12_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry12_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry12_PerItem_PriceSilverButtonText"
        text: "39"
        wowParent: "AuctionatorEntry12_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry12_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry12_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry12_StackPrice
        name: "AuctionatorEntry12_StackPrice"
        text: "1g 95s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry12.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry12.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    FontString {
        id: auctionatorEntry1_EntryText
        name: "AuctionatorEntry1_EntryText"
        text: "1 stack of 1 (yours)"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 3
        width: 95.5
        height: 10.1
    }

    Frame {
        id: auctionatorEntry1_PerItem_Price
        name: "AuctionatorEntry1_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 34.7
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 1.5
        width: 107.3
        height: 13
    }

    Button {
        id: auctionatorEntry1_PerItem_PriceCopperButton
        name: "AuctionatorEntry1_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry1_PerItem_Price"
        anchors.right: auctionatorEntry1_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry1_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry1_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry1_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry1_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry1_PerItem_PriceGoldButton
        name: "AuctionatorEntry1_PerItem_PriceGoldButton"
        text: "4"
        wowParent: "AuctionatorEntry1_PerItem_Price"
        anchors.right: auctionatorEntry1_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionatorEntry1_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry1_PerItem_PriceGoldButtonText"
        text: "4"
        wowParent: "AuctionatorEntry1_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry1_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry1_PerItem_PriceSilverButton
        name: "AuctionatorEntry1_PerItem_PriceSilverButton"
        text: "94"
        wowParent: "AuctionatorEntry1_PerItem_Price"
        anchors.right: auctionatorEntry1_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry1_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry1_PerItem_PriceSilverButtonText"
        text: "94"
        wowParent: "AuctionatorEntry1_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry1_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry1_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry1_PerItem_Text
        name: "AuctionatorEntry1_PerItem_Text"
        text: "no buyout price"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 46.3
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 2
        width: 79.7
        height: 10.1
    }

    FontString {
        id: auctionatorEntry1_StackPrice
        name: "AuctionatorEntry1_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry1.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry1.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorEntry2
        name: "AuctionatorEntry2"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry1.left
        anchors.top: auctionatorEntry1.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry2_EntryText
        name: "AuctionatorEntry2_EntryText"
        text: "1 stack of 10"
        wowParent: "?"
        anchors.left: auctionatorEntry2.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry2.top
        anchors.topMargin: 3
        width: 64.6
        height: 10.1
    }

    Frame {
        id: auctionatorEntry2_PerItem_Price
        name: "AuctionatorEntry2_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry2.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry2.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry2_PerItem_PriceCopperButton
        name: "AuctionatorEntry2_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry2_PerItem_Price"
        anchors.right: auctionatorEntry2_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry2_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry2_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry2_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry2_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry2_PerItem_PriceGoldButton
        name: "AuctionatorEntry2_PerItem_PriceGoldButton"
        text: "9"
        wowParent: "AuctionatorEntry2_PerItem_Price"
        anchors.right: auctionatorEntry2_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionatorEntry2_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry2_PerItem_PriceGoldButtonText"
        text: "9"
        wowParent: "AuctionatorEntry2_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry2_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry2_PerItem_PriceSilverButton
        name: "AuctionatorEntry2_PerItem_PriceSilverButton"
        text: "24"
        wowParent: "AuctionatorEntry2_PerItem_Price"
        anchors.right: auctionatorEntry2_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry2_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry2_PerItem_PriceSilverButtonText"
        text: "24"
        wowParent: "AuctionatorEntry2_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry2_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry2_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry2_StackPrice
        name: "AuctionatorEntry2_StackPrice"
        text: "2g 40s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry2.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry2.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Button {
        id: auctionatorEntry3
        name: "AuctionatorEntry3"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry2.left
        anchors.top: auctionatorEntry2.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry3_EntryText
        name: "AuctionatorEntry3_EntryText"
        text: "1 stack of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry3.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry3.top
        anchors.topMargin: 3
        width: 57.5
        height: 10.1
    }

    Frame {
        id: auctionatorEntry3_PerItem_Price
        name: "AuctionatorEntry3_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry3.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry3.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry3_PerItem_PriceCopperButton
        name: "AuctionatorEntry3_PerItem_PriceCopperButton"
        text: "98"
        wowParent: "AuctionatorEntry3_PerItem_Price"
        anchors.right: auctionatorEntry3_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry3_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry3_PerItem_PriceCopperButtonText"
        text: "98"
        wowParent: "AuctionatorEntry3_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry3_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionatorEntry3_PerItem_PriceGoldButton
        name: "AuctionatorEntry3_PerItem_PriceGoldButton"
        text: "2"
        wowParent: "AuctionatorEntry3_PerItem_Price"
        anchors.right: auctionatorEntry3_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionatorEntry3_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry3_PerItem_PriceGoldButtonText"
        text: "2"
        wowParent: "AuctionatorEntry3_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry3_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry3_PerItem_PriceSilverButton
        name: "AuctionatorEntry3_PerItem_PriceSilverButton"
        text: "24"
        wowParent: "AuctionatorEntry3_PerItem_Price"
        anchors.right: auctionatorEntry3_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry3_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry3_PerItem_PriceSilverButtonText"
        text: "24"
        wowParent: "AuctionatorEntry3_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry3_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry3_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry3_StackPrice
        name: "AuctionatorEntry3_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry3.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry3.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorEntry4
        name: "AuctionatorEntry4"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry3.left
        anchors.top: auctionatorEntry3.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry4_EntryText
        name: "AuctionatorEntry4_EntryText"
        text: "1 stack of 8"
        wowParent: "?"
        anchors.left: auctionatorEntry4.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry4.top
        anchors.topMargin: 3
        width: 58.9
        height: 10.1
    }

    Frame {
        id: auctionatorEntry4_PerItem_Price
        name: "AuctionatorEntry4_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry4.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry4.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry4_PerItem_PriceCopperButton
        name: "AuctionatorEntry4_PerItem_PriceCopperButton"
        text: "99"
        wowParent: "AuctionatorEntry4_PerItem_Price"
        anchors.right: auctionatorEntry4_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry4_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry4_PerItem_PriceCopperButtonText"
        text: "99"
        wowParent: "AuctionatorEntry4_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry4_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionatorEntry4_PerItem_PriceGoldButton
        name: "AuctionatorEntry4_PerItem_PriceGoldButton"
        text: "2"
        wowParent: "AuctionatorEntry4_PerItem_Price"
        anchors.right: auctionatorEntry4_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionatorEntry4_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry4_PerItem_PriceGoldButtonText"
        text: "2"
        wowParent: "AuctionatorEntry4_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry4_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry4_PerItem_PriceSilverButton
        name: "AuctionatorEntry4_PerItem_PriceSilverButton"
        text: "24"
        wowParent: "AuctionatorEntry4_PerItem_Price"
        anchors.right: auctionatorEntry4_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry4_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry4_PerItem_PriceSilverButtonText"
        text: "24"
        wowParent: "AuctionatorEntry4_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry4_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry4_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry4_StackPrice
        name: "AuctionatorEntry4_StackPrice"
        text: "1g 99s 92c"
        wowParent: "?"
        anchors.left: auctionatorEntry4.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry4.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Button {
        id: auctionatorEntry5
        name: "AuctionatorEntry5"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry4.left
        anchors.top: auctionatorEntry4.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry5_EntryText
        name: "AuctionatorEntry5_EntryText"
        text: "1 stack of 14"
        wowParent: "?"
        anchors.left: auctionatorEntry5.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry5.top
        anchors.topMargin: 3
        width: 64.6
        height: 10.1
    }

    Frame {
        id: auctionatorEntry5_PerItem_Price
        name: "AuctionatorEntry5_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry5.left
        anchors.leftMargin: 63.5
        anchors.top: auctionatorEntry5.top
        anchors.topMargin: 1.5
        width: 78.5
        height: 13
    }

    Button {
        id: auctionatorEntry5_PerItem_PriceCopperButton
        name: "AuctionatorEntry5_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry5_PerItem_Price"
        anchors.right: auctionatorEntry5_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry5_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry5_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry5_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry5_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry5_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry5_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry5_PerItem_PriceSilverButton
        name: "AuctionatorEntry5_PerItem_PriceSilverButton"
        text: "25"
        wowParent: "AuctionatorEntry5_PerItem_Price"
        anchors.right: auctionatorEntry5_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry5_PerItem_PriceCopperButton.verticalCenter
        width: 29.5
        height: 13
    }

    FontString {
        id: auctionatorEntry5_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry5_PerItem_PriceSilverButtonText"
        text: "25"
        wowParent: "AuctionatorEntry5_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry5_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry5_PerItem_PriceSilverButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    FontString {
        id: auctionatorEntry5_StackPrice
        name: "AuctionatorEntry5_StackPrice"
        text: "3g 50s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry5.left
        anchors.leftMargin: 503.3
        anchors.top: auctionatorEntry5.top
        anchors.topMargin: 3
        width: 56.7
        height: 10.1
    }

    Button {
        id: auctionatorEntry6
        name: "AuctionatorEntry6"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry5.left
        anchors.top: auctionatorEntry5.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry6_EntryText
        name: "AuctionatorEntry6_EntryText"
        text: "1 stack of 14"
        wowParent: "?"
        anchors.left: auctionatorEntry6.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry6.top
        anchors.topMargin: 3
        width: 64.6
        height: 10.1
    }

    Frame {
        id: auctionatorEntry6_PerItem_Price
        name: "AuctionatorEntry6_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry6.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry6.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry6_PerItem_PriceCopperButton
        name: "AuctionatorEntry6_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry6_PerItem_Price"
        anchors.right: auctionatorEntry6_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry6_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry6_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry6_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry6_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry6_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry6_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry6_PerItem_PriceSilverButton
        name: "AuctionatorEntry6_PerItem_PriceSilverButton"
        text: "73"
        wowParent: "AuctionatorEntry6_PerItem_Price"
        anchors.right: auctionatorEntry6_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry6_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry6_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry6_PerItem_PriceSilverButtonText"
        text: "73"
        wowParent: "AuctionatorEntry6_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry6_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry6_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry6_StackPrice
        name: "AuctionatorEntry6_StackPrice"
        text: "10g 22s 00c"
        wowParent: "?"
        anchors.left: auctionatorEntry6.left
        anchors.leftMargin: 497.5
        anchors.top: auctionatorEntry6.top
        anchors.topMargin: 3
        width: 62.5
        height: 10.1
    }

    Button {
        id: auctionatorEntry7
        name: "AuctionatorEntry7"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry6.left
        anchors.top: auctionatorEntry6.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry7_EntryText
        name: "AuctionatorEntry7_EntryText"
        text: "1 stack of 1 (yours)"
        wowParent: "?"
        anchors.left: auctionatorEntry7.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry7.top
        anchors.topMargin: 3
        width: 95.5
        height: 10.1
    }

    Frame {
        id: auctionatorEntry7_PerItem_Price
        name: "AuctionatorEntry7_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry7.left
        anchors.leftMargin: 64.2
        anchors.top: auctionatorEntry7.top
        anchors.topMargin: 1.5
        width: 77.8
        height: 13
    }

    Button {
        id: auctionatorEntry7_PerItem_PriceCopperButton
        name: "AuctionatorEntry7_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry7_PerItem_Price"
        anchors.right: auctionatorEntry7_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry7_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry7_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry7_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry7_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry7_PerItem_PriceGoldButton
        name: "AuctionatorEntry7_PerItem_PriceGoldButton"
        text: "1"
        wowParent: "AuctionatorEntry7_PerItem_Price"
        anchors.right: auctionatorEntry7_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceSilverButton.verticalCenter
        width: 20.9
        height: 13
    }

    FontString {
        id: auctionatorEntry7_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry7_PerItem_PriceGoldButtonText"
        text: "1"
        wowParent: "AuctionatorEntry7_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry7_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceGoldButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Button {
        id: auctionatorEntry7_PerItem_PriceSilverButton
        name: "AuctionatorEntry7_PerItem_PriceSilverButton"
        text: "74"
        wowParent: "AuctionatorEntry7_PerItem_Price"
        anchors.right: auctionatorEntry7_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionatorEntry7_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry7_PerItem_PriceSilverButtonText"
        text: "74"
        wowParent: "AuctionatorEntry7_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry7_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry7_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry7_StackPrice
        name: "AuctionatorEntry7_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry7.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry7.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorEntry8
        name: "AuctionatorEntry8"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry7.left
        anchors.top: auctionatorEntry7.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry8_EntryText
        name: "AuctionatorEntry8_EntryText"
        text: "1 stack of 1 (yours)"
        wowParent: "?"
        anchors.left: auctionatorEntry8.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry8.top
        anchors.topMargin: 3
        width: 95.5
        height: 10.1
    }

    Frame {
        id: auctionatorEntry8_PerItem_Price
        name: "AuctionatorEntry8_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry8.left
        anchors.leftMargin: 36.1
        anchors.top: auctionatorEntry8.top
        anchors.topMargin: 1.5
        width: 105.9
        height: 13
    }

    Button {
        id: auctionatorEntry8_PerItem_PriceCopperButton
        name: "AuctionatorEntry8_PerItem_PriceCopperButton"
        text: "0"
        wowParent: "AuctionatorEntry8_PerItem_Price"
        anchors.right: auctionatorEntry8_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry8_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry8_PerItem_PriceCopperButtonText"
        text: "0"
        wowParent: "AuctionatorEntry8_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry8_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry8_PerItem_PriceGoldButton
        name: "AuctionatorEntry8_PerItem_PriceGoldButton"
        text: "1"
        wowParent: "AuctionatorEntry8_PerItem_Price"
        anchors.right: auctionatorEntry8_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceSilverButton.verticalCenter
        width: 20.9
        height: 13
    }

    FontString {
        id: auctionatorEntry8_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry8_PerItem_PriceGoldButtonText"
        text: "1"
        wowParent: "AuctionatorEntry8_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry8_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceGoldButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Button {
        id: auctionatorEntry8_PerItem_PriceSilverButton
        name: "AuctionatorEntry8_PerItem_PriceSilverButton"
        text: "54"
        wowParent: "AuctionatorEntry8_PerItem_Price"
        anchors.right: auctionatorEntry8_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry8_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry8_PerItem_PriceSilverButtonText"
        text: "54"
        wowParent: "AuctionatorEntry8_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry8_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry8_PerItem_PriceSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionatorEntry8_StackPrice
        name: "AuctionatorEntry8_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry8.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry8.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorEntry9
        name: "AuctionatorEntry9"
        wowParent: "Atr_Main_Panel"
        anchors.left: auctionatorEntry8.left
        anchors.top: auctionatorEntry8.bottom
        width: 584
        height: 16
    }

    FontString {
        id: auctionatorEntry9_EntryText
        name: "AuctionatorEntry9_EntryText"
        text: "3 stacks of 1"
        wowParent: "?"
        anchors.left: auctionatorEntry9.left
        anchors.leftMargin: 205
        anchors.top: auctionatorEntry9.top
        anchors.topMargin: 3
        width: 62.5
        height: 10.1
    }

    Frame {
        id: auctionatorEntry9_PerItem_Price
        name: "AuctionatorEntry9_PerItem_Price"
        wowParent: "?"
        anchors.left: auctionatorEntry9.left
        anchors.leftMargin: 34.7
        anchors.top: auctionatorEntry9.top
        anchors.topMargin: 1.5
        width: 107.3
        height: 13
    }

    Button {
        id: auctionatorEntry9_PerItem_PriceCopperButton
        name: "AuctionatorEntry9_PerItem_PriceCopperButton"
        text: "1"
        wowParent: "AuctionatorEntry9_PerItem_Price"
        anchors.right: auctionatorEntry9_PerItem_Price.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_Price.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry9_PerItem_PriceCopperButtonText
        name: "AuctionatorEntry9_PerItem_PriceCopperButtonText"
        text: "1"
        wowParent: "AuctionatorEntry9_PerItem_PriceCopperButton"
        anchors.right: auctionatorEntry9_PerItem_PriceCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceCopperButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Button {
        id: auctionatorEntry9_PerItem_PriceGoldButton
        name: "AuctionatorEntry9_PerItem_PriceGoldButton"
        text: "3"
        wowParent: "AuctionatorEntry9_PerItem_Price"
        anchors.right: auctionatorEntry9_PerItem_PriceSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionatorEntry9_PerItem_PriceGoldButtonText
        name: "AuctionatorEntry9_PerItem_PriceGoldButtonText"
        text: "3"
        wowParent: "AuctionatorEntry9_PerItem_PriceGoldButton"
        anchors.right: auctionatorEntry9_PerItem_PriceGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionatorEntry9_PerItem_PriceSilverButton
        name: "AuctionatorEntry9_PerItem_PriceSilverButton"
        text: "0"
        wowParent: "AuctionatorEntry9_PerItem_Price"
        anchors.right: auctionatorEntry9_PerItem_PriceCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionatorEntry9_PerItem_PriceSilverButtonText
        name: "AuctionatorEntry9_PerItem_PriceSilverButtonText"
        text: "0"
        wowParent: "AuctionatorEntry9_PerItem_PriceSilverButton"
        anchors.right: auctionatorEntry9_PerItem_PriceSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionatorEntry9_PerItem_PriceSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    FontString {
        id: auctionatorEntry9_StackPrice
        name: "AuctionatorEntry9_StackPrice"
        wowParent: "?"
        anchors.left: auctionatorEntry9.left
        anchors.leftMargin: 559
        anchors.top: auctionatorEntry9.top
        anchors.topMargin: 7.5
        width: 1
        height: 1
    }

    Button {
        id: auctionatorHEntry1
        name: "AuctionatorHEntry1"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 5
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry10
        name: "AuctionatorHEntry10"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 149
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry10_EntryText
        name: "AuctionatorHEntry10_EntryText"
        wowParent: "AuctionatorHEntry10"
        anchors.left: auctionatorHEntry10.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry10.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry11
        name: "AuctionatorHEntry11"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 165
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry11_EntryText
        name: "AuctionatorHEntry11_EntryText"
        wowParent: "AuctionatorHEntry11"
        anchors.left: auctionatorHEntry11.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry11.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry12
        name: "AuctionatorHEntry12"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 181
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry12_EntryText
        name: "AuctionatorHEntry12_EntryText"
        wowParent: "AuctionatorHEntry12"
        anchors.left: auctionatorHEntry12.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry12.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry13
        name: "AuctionatorHEntry13"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 197
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry13_EntryText
        name: "AuctionatorHEntry13_EntryText"
        wowParent: "AuctionatorHEntry13"
        anchors.left: auctionatorHEntry13.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry13.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry14
        name: "AuctionatorHEntry14"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 213
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry14_EntryText
        name: "AuctionatorHEntry14_EntryText"
        text: "Fish feast"
        wowParent: "AuctionatorHEntry14"
        anchors.left: auctionatorHEntry14.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry14.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry15
        name: "AuctionatorHEntry15"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 229
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry15_EntryText
        name: "AuctionatorHEntry15_EntryText"
        text: "Flask"
        wowParent: "AuctionatorHEntry15"
        anchors.left: auctionatorHEntry15.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry15.verticalCenter
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry1_EntryText
        name: "AuctionatorHEntry1_EntryText"
        wowParent: "AuctionatorHEntry1"
        anchors.left: auctionatorHEntry1.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry1.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry2
        name: "AuctionatorHEntry2"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 21
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry2_EntryText
        name: "AuctionatorHEntry2_EntryText"
        wowParent: "AuctionatorHEntry2"
        anchors.left: auctionatorHEntry2.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry2.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry3
        name: "AuctionatorHEntry3"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 37
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry3_EntryText
        name: "AuctionatorHEntry3_EntryText"
        wowParent: "AuctionatorHEntry3"
        anchors.left: auctionatorHEntry3.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry3.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry4
        name: "AuctionatorHEntry4"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 53
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry4_EntryText
        name: "AuctionatorHEntry4_EntryText"
        wowParent: "AuctionatorHEntry4"
        anchors.left: auctionatorHEntry4.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry4.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry5
        name: "AuctionatorHEntry5"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 69
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry5_EntryText
        name: "AuctionatorHEntry5_EntryText"
        wowParent: "AuctionatorHEntry5"
        anchors.left: auctionatorHEntry5.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry5.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry6
        name: "AuctionatorHEntry6"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 85
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry6_EntryText
        name: "AuctionatorHEntry6_EntryText"
        wowParent: "AuctionatorHEntry6"
        anchors.left: auctionatorHEntry6.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry6.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry7
        name: "AuctionatorHEntry7"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 101
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry7_EntryText
        name: "AuctionatorHEntry7_EntryText"
        wowParent: "AuctionatorHEntry7"
        anchors.left: auctionatorHEntry7.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry7.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry8
        name: "AuctionatorHEntry8"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 117
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry8_EntryText
        name: "AuctionatorHEntry8_EntryText"
        wowParent: "AuctionatorHEntry8"
        anchors.left: auctionatorHEntry8.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry8.verticalCenter
        width: 174
        height: 16
    }

    Button {
        id: auctionatorHEntry9
        name: "AuctionatorHEntry9"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 133
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorHEntry9_EntryText
        name: "AuctionatorHEntry9_EntryText"
        wowParent: "AuctionatorHEntry9"
        anchors.left: auctionatorHEntry9.left
        anchors.leftMargin: 2
        anchors.verticalCenter: auctionatorHEntry9.verticalCenter
        width: 174
        height: 16
    }

    FontString {
        id: auctionatorMessage2Frame
        name: "AuctionatorMessage2Frame"
        text: "Drag an item you want to sell to this area."
        wowParent: "Atr_Main_Panel"
        anchors.horizontalCenter: atr_Main_Panel.horizontalCenter
        anchors.horizontalCenterOffset: 18
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 65
        width: 252.1
        height: 100
    }

    ScrollFrame {
        id: auctionatorScrollFrame
        name: "AuctionatorScrollFrame"
        wowParent: "Atr_Main_Panel"
        anchors.left: atr_Main_Panel.left
        anchors.leftMargin: 10
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: 188
        width: 588
        height: 196
    }

    Slider {
        id: auctionatorScrollFrameScrollBar
        name: "AuctionatorScrollFrameScrollBar"
        wowParent: "AuctionatorScrollFrame"
        anchors.left: auctionatorScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: auctionatorScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 164
    }

    Frame {
        id: auctionatorScrollFrameScrollBarDiabolicTrack
        name: "AuctionatorScrollFrameScrollBarDiabolicTrack"
        wowParent: "AuctionatorScrollFrameScrollBar"
        anchors.horizontalCenter: auctionatorScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: auctionatorScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 198
    }

    Button {
        id: auctionatorScrollFrameScrollBarScrollDownButton
        name: "AuctionatorScrollFrameScrollBarScrollDownButton"
        wowParent: "AuctionatorScrollFrameScrollBar"
        anchors.horizontalCenter: auctionatorScrollFrameScrollBar.horizontalCenter
        anchors.top: auctionatorScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: auctionatorScrollFrameScrollBarScrollUpButton
        name: "AuctionatorScrollFrameScrollBarScrollUpButton"
        wowParent: "AuctionatorScrollFrameScrollBar"
        anchors.horizontalCenter: auctionatorScrollFrameScrollBar.horizontalCenter
        anchors.bottom: auctionatorScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: auctionatorScrollFrameScrollChildFrame
        name: "AuctionatorScrollFrameScrollChildFrame"
        wowParent: "AuctionatorScrollFrame"
        anchors.left: auctionatorScrollFrame.left
        anchors.top: auctionatorScrollFrame.top
        width: 300
        height: 512
    }

    FontString {
        id: auctionatorTitle
        name: "AuctionatorTitle"
        text: "Auctionator+ - More..."
        wowParent: "Atr_Main_Panel"
        anchors.horizontalCenter: atr_Main_Panel.horizontalCenter
        anchors.horizontalCenterOffset: -90
        anchors.top: atr_Main_Panel.top
        anchors.topMargin: -7
        width: 135.7
        height: 12.2
    }

    Button {
        id: auctionsBidSort
        name: "AuctionsBidSort"
        text: "Current Bid"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsHighBidderSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: auctionsHighBidderSort.verticalCenter
        width: 193
        height: 19
    }

    FontString {
        id: auctionsBidSortText
        name: "AuctionsBidSortText"
        text: "Current Bid"
        wowParent: "AuctionsBidSort"
        anchors.left: auctionsBidSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsBidSort.verticalCenter
        width: 57.5
        height: 10.1
    }

    Button {
        id: auctionsButton1
        name: "AuctionsButton1"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 224
        anchors.top: auctionFrame.top
        anchors.topMargin: 71
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton1BuyoutFrame
        name: "AuctionsButton1BuyoutFrame"
        wowParent: "AuctionsButton1"
        anchors.right: auctionsButton1MoneyFrame.right
        anchors.top: auctionsButton1MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton1BuyoutFrameMoney
        name: "AuctionsButton1BuyoutFrameMoney"
        wowParent: "AuctionsButton1BuyoutFrame"
        anchors.right: auctionsButton1BuyoutFrame.right
        anchors.verticalCenter: auctionsButton1BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton1BuyoutFrameMoneyCopperButton
        name: "AuctionsButton1BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton1BuyoutFrameMoney"
        anchors.right: auctionsButton1BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton1BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton1BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton1BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton1BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton1BuyoutFrameMoneyGoldButton
        name: "AuctionsButton1BuyoutFrameMoneyGoldButton"
        text: "9"
        wowParent: "AuctionsButton1BuyoutFrameMoney"
        anchors.right: auctionsButton1BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton1BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton1BuyoutFrameMoneyGoldButtonText"
        text: "9"
        wowParent: "AuctionsButton1BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton1BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton1BuyoutFrameMoneySilverButton
        name: "AuctionsButton1BuyoutFrameMoneySilverButton"
        text: "80"
        wowParent: "AuctionsButton1BuyoutFrameMoney"
        anchors.right: auctionsButton1BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton1BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton1BuyoutFrameMoneySilverButtonText"
        text: "80"
        wowParent: "AuctionsButton1BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton1BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton1BuyoutFrameText
        name: "AuctionsButton1BuyoutFrameText"
        wowParent: "AuctionsButton1BuyoutFrame"
        anchors.left: auctionsButton1BuyoutFrame.left
        anchors.top: auctionsButton1BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Frame {
        id: auctionsButton1ClosingTime
        name: "AuctionsButton1ClosingTime"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton1.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton1ClosingTimeText
        name: "AuctionsButton1ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton1ClosingTime"
        anchors.left: auctionsButton1ClosingTime.left
        anchors.top: auctionsButton1ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton1HighBidder
        name: "AuctionsButton1HighBidder"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton1.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton1Item
        name: "AuctionsButton1Item"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.top: auctionsButton1.top
        width: 32
        height: 32
    }

    FontString {
        id: auctionsButton1ItemCount
        name: "AuctionsButton1ItemCount"
        text: "20"
        wowParent: "AuctionsButton1Item"
        anchors.right: auctionsButton1Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton1Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton1MoneyFrame
        name: "AuctionsButton1MoneyFrame"
        wowParent: "AuctionsButton1"
        anchors.right: auctionsButton1.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton1.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton1MoneyFrameCopperButton
        name: "AuctionsButton1MoneyFrameCopperButton"
        text: "0"
        wowParent: "AuctionsButton1MoneyFrame"
        anchors.right: auctionsButton1MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton1MoneyFrameCopperButtonText
        name: "AuctionsButton1MoneyFrameCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton1MoneyFrameCopperButton"
        anchors.right: auctionsButton1MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton1MoneyFrameGoldButton
        name: "AuctionsButton1MoneyFrameGoldButton"
        text: "9"
        wowParent: "AuctionsButton1MoneyFrame"
        anchors.right: auctionsButton1MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton1MoneyFrameGoldButtonText
        name: "AuctionsButton1MoneyFrameGoldButtonText"
        text: "9"
        wowParent: "AuctionsButton1MoneyFrameGoldButton"
        anchors.right: auctionsButton1MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton1MoneyFrameSilverButton
        name: "AuctionsButton1MoneyFrameSilverButton"
        text: "31"
        wowParent: "AuctionsButton1MoneyFrame"
        anchors.right: auctionsButton1MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton1MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton1MoneyFrameSilverButtonText
        name: "AuctionsButton1MoneyFrameSilverButtonText"
        text: "31"
        wowParent: "AuctionsButton1MoneyFrameSilverButton"
        anchors.right: auctionsButton1MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton1MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    FontString {
        id: auctionsButton1Name
        name: "AuctionsButton1Name"
        text: "Packet of Tharlendris Seeds"
        wowParent: "AuctionsButton1"
        anchors.left: auctionsButton1.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton1.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton2
        name: "AuctionsButton2"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton1.left
        anchors.top: auctionsButton1.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton2BuyoutFrame
        name: "AuctionsButton2BuyoutFrame"
        wowParent: "AuctionsButton2"
        anchors.right: auctionsButton2MoneyFrame.right
        anchors.top: auctionsButton2MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton2BuyoutFrameMoney
        name: "AuctionsButton2BuyoutFrameMoney"
        wowParent: "AuctionsButton2BuyoutFrame"
        anchors.right: auctionsButton2BuyoutFrame.right
        anchors.verticalCenter: auctionsButton2BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton2BuyoutFrameMoneyCopperButton
        name: "AuctionsButton2BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton2BuyoutFrameMoney"
        anchors.right: auctionsButton2BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton2BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton2BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton2BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton2BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton2BuyoutFrameMoneyGoldButton
        name: "AuctionsButton2BuyoutFrameMoneyGoldButton"
        text: "9"
        wowParent: "AuctionsButton2BuyoutFrameMoney"
        anchors.right: auctionsButton2BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton2BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton2BuyoutFrameMoneyGoldButtonText"
        text: "9"
        wowParent: "AuctionsButton2BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton2BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton2BuyoutFrameMoneySilverButton
        name: "AuctionsButton2BuyoutFrameMoneySilverButton"
        text: "80"
        wowParent: "AuctionsButton2BuyoutFrameMoney"
        anchors.right: auctionsButton2BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton2BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton2BuyoutFrameMoneySilverButtonText"
        text: "80"
        wowParent: "AuctionsButton2BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton2BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton2BuyoutFrameText
        name: "AuctionsButton2BuyoutFrameText"
        wowParent: "AuctionsButton2BuyoutFrame"
        anchors.left: auctionsButton2BuyoutFrame.left
        anchors.top: auctionsButton2BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Frame {
        id: auctionsButton2ClosingTime
        name: "AuctionsButton2ClosingTime"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton2.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton2ClosingTimeText
        name: "AuctionsButton2ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton2ClosingTime"
        anchors.left: auctionsButton2ClosingTime.left
        anchors.top: auctionsButton2ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton2HighBidder
        name: "AuctionsButton2HighBidder"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton2.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton2Item
        name: "AuctionsButton2Item"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.top: auctionsButton2.top
        width: 32
        height: 32
    }

    FontString {
        id: auctionsButton2ItemCount
        name: "AuctionsButton2ItemCount"
        text: "20"
        wowParent: "AuctionsButton2Item"
        anchors.right: auctionsButton2Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton2Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton2MoneyFrame
        name: "AuctionsButton2MoneyFrame"
        wowParent: "AuctionsButton2"
        anchors.right: auctionsButton2.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton2.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton2MoneyFrameCopperButton
        name: "AuctionsButton2MoneyFrameCopperButton"
        text: "0"
        wowParent: "AuctionsButton2MoneyFrame"
        anchors.right: auctionsButton2MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton2MoneyFrameCopperButtonText
        name: "AuctionsButton2MoneyFrameCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton2MoneyFrameCopperButton"
        anchors.right: auctionsButton2MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton2MoneyFrameGoldButton
        name: "AuctionsButton2MoneyFrameGoldButton"
        text: "9"
        wowParent: "AuctionsButton2MoneyFrame"
        anchors.right: auctionsButton2MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton2MoneyFrameGoldButtonText
        name: "AuctionsButton2MoneyFrameGoldButtonText"
        text: "9"
        wowParent: "AuctionsButton2MoneyFrameGoldButton"
        anchors.right: auctionsButton2MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton2MoneyFrameSilverButton
        name: "AuctionsButton2MoneyFrameSilverButton"
        text: "31"
        wowParent: "AuctionsButton2MoneyFrame"
        anchors.right: auctionsButton2MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton2MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton2MoneyFrameSilverButtonText
        name: "AuctionsButton2MoneyFrameSilverButtonText"
        text: "31"
        wowParent: "AuctionsButton2MoneyFrameSilverButton"
        anchors.right: auctionsButton2MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton2MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    FontString {
        id: auctionsButton2Name
        name: "AuctionsButton2Name"
        text: "Packet of Tharlendris Seeds"
        wowParent: "AuctionsButton2"
        anchors.left: auctionsButton2.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton2.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton3
        name: "AuctionsButton3"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton2.left
        anchors.top: auctionsButton2.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton3BuyoutFrame
        name: "AuctionsButton3BuyoutFrame"
        wowParent: "AuctionsButton3"
        anchors.right: auctionsButton3MoneyFrame.right
        anchors.top: auctionsButton3MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton3BuyoutFrameMoney
        name: "AuctionsButton3BuyoutFrameMoney"
        wowParent: "AuctionsButton3BuyoutFrame"
        anchors.right: auctionsButton3BuyoutFrame.right
        anchors.verticalCenter: auctionsButton3BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton3BuyoutFrameMoneyCopperButton
        name: "AuctionsButton3BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton3BuyoutFrameMoney"
        anchors.right: auctionsButton3BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton3BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton3BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton3BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton3BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton3BuyoutFrameMoneyGoldButton
        name: "AuctionsButton3BuyoutFrameMoneyGoldButton"
        text: "8"
        wowParent: "AuctionsButton3BuyoutFrameMoney"
        anchors.right: auctionsButton3BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton3BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton3BuyoutFrameMoneyGoldButtonText"
        text: "8"
        wowParent: "AuctionsButton3BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton3BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton3BuyoutFrameMoneySilverButton
        name: "AuctionsButton3BuyoutFrameMoneySilverButton"
        text: "82"
        wowParent: "AuctionsButton3BuyoutFrameMoney"
        anchors.right: auctionsButton3BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton3BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton3BuyoutFrameMoneySilverButtonText"
        text: "82"
        wowParent: "AuctionsButton3BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton3BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton3BuyoutFrameText
        name: "AuctionsButton3BuyoutFrameText"
        wowParent: "AuctionsButton3BuyoutFrame"
        anchors.left: auctionsButton3BuyoutFrame.left
        anchors.top: auctionsButton3BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Frame {
        id: auctionsButton3ClosingTime
        name: "AuctionsButton3ClosingTime"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton3.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton3ClosingTimeText
        name: "AuctionsButton3ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton3ClosingTime"
        anchors.left: auctionsButton3ClosingTime.left
        anchors.top: auctionsButton3ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton3HighBidder
        name: "AuctionsButton3HighBidder"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton3.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton3Item
        name: "AuctionsButton3Item"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.top: auctionsButton3.top
        width: 32
        height: 32
    }

    FontString {
        id: auctionsButton3ItemCount
        name: "AuctionsButton3ItemCount"
        text: "18"
        wowParent: "AuctionsButton3Item"
        anchors.right: auctionsButton3Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton3Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton3MoneyFrame
        name: "AuctionsButton3MoneyFrame"
        wowParent: "AuctionsButton3"
        anchors.right: auctionsButton3.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton3.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton3MoneyFrameCopperButton
        name: "AuctionsButton3MoneyFrameCopperButton"
        text: "90"
        wowParent: "AuctionsButton3MoneyFrame"
        anchors.right: auctionsButton3MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton3MoneyFrameCopperButtonText
        name: "AuctionsButton3MoneyFrameCopperButtonText"
        text: "90"
        wowParent: "AuctionsButton3MoneyFrameCopperButton"
        anchors.right: auctionsButton3MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionsButton3MoneyFrameGoldButton
        name: "AuctionsButton3MoneyFrameGoldButton"
        text: "8"
        wowParent: "AuctionsButton3MoneyFrame"
        anchors.right: auctionsButton3MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton3MoneyFrameGoldButtonText
        name: "AuctionsButton3MoneyFrameGoldButtonText"
        text: "8"
        wowParent: "AuctionsButton3MoneyFrameGoldButton"
        anchors.right: auctionsButton3MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton3MoneyFrameSilverButton
        name: "AuctionsButton3MoneyFrameSilverButton"
        text: "37"
        wowParent: "AuctionsButton3MoneyFrame"
        anchors.right: auctionsButton3MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton3MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton3MoneyFrameSilverButtonText
        name: "AuctionsButton3MoneyFrameSilverButtonText"
        text: "37"
        wowParent: "AuctionsButton3MoneyFrameSilverButton"
        anchors.right: auctionsButton3MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton3MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionsButton3Name
        name: "AuctionsButton3Name"
        text: "Packet of Tharlendris Seeds"
        wowParent: "AuctionsButton3"
        anchors.left: auctionsButton3.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton3.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton4
        name: "AuctionsButton4"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton3.left
        anchors.top: auctionsButton3.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton4BuyoutFrame
        name: "AuctionsButton4BuyoutFrame"
        wowParent: "AuctionsButton4"
        anchors.right: auctionsButton4MoneyFrame.right
        anchors.top: auctionsButton4MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton4BuyoutFrameMoney
        name: "AuctionsButton4BuyoutFrameMoney"
        wowParent: "AuctionsButton4BuyoutFrame"
        anchors.right: auctionsButton4BuyoutFrame.right
        anchors.verticalCenter: auctionsButton4BuyoutFrame.verticalCenter
        width: 77.8
        height: 13
    }

    Button {
        id: auctionsButton4BuyoutFrameMoneyCopperButton
        name: "AuctionsButton4BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton4BuyoutFrameMoney"
        anchors.right: auctionsButton4BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton4BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton4BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton4BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton4BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton4BuyoutFrameMoneySilverButton
        name: "AuctionsButton4BuyoutFrameMoneySilverButton"
        text: "74"
        wowParent: "AuctionsButton4BuyoutFrameMoney"
        anchors.right: auctionsButton4BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionsButton4BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton4BuyoutFrameMoneySilverButtonText"
        text: "74"
        wowParent: "AuctionsButton4BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton4BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton4BuyoutFrameText
        name: "AuctionsButton4BuyoutFrameText"
        wowParent: "AuctionsButton4BuyoutFrame"
        anchors.left: auctionsButton4BuyoutFrame.left
        anchors.top: auctionsButton4BuyoutFrame.top
        width: 117.2
        height: 13
    }

    Frame {
        id: auctionsButton4ClosingTime
        name: "AuctionsButton4ClosingTime"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton4.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton4ClosingTimeText
        name: "AuctionsButton4ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton4ClosingTime"
        anchors.left: auctionsButton4ClosingTime.left
        anchors.top: auctionsButton4ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton4HighBidder
        name: "AuctionsButton4HighBidder"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton4.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton4Item
        name: "AuctionsButton4Item"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.top: auctionsButton4.top
        width: 32
        height: 32
    }

    Frame {
        id: auctionsButton4MoneyFrame
        name: "AuctionsButton4MoneyFrame"
        wowParent: "AuctionsButton4"
        anchors.right: auctionsButton4.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton4.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 77.8
        height: 13
    }

    Button {
        id: auctionsButton4MoneyFrameCopperButton
        name: "AuctionsButton4MoneyFrameCopperButton"
        text: "30"
        wowParent: "AuctionsButton4MoneyFrame"
        anchors.right: auctionsButton4MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton4MoneyFrameCopperButtonText
        name: "AuctionsButton4MoneyFrameCopperButtonText"
        text: "30"
        wowParent: "AuctionsButton4MoneyFrameCopperButton"
        anchors.right: auctionsButton4MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionsButton4MoneyFrameSilverButton
        name: "AuctionsButton4MoneyFrameSilverButton"
        text: "70"
        wowParent: "AuctionsButton4MoneyFrame"
        anchors.right: auctionsButton4MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton4MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionsButton4MoneyFrameSilverButtonText
        name: "AuctionsButton4MoneyFrameSilverButtonText"
        text: "70"
        wowParent: "AuctionsButton4MoneyFrameSilverButton"
        anchors.right: auctionsButton4MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton4MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionsButton4Name
        name: "AuctionsButton4Name"
        text: "Un'Goro Soil"
        wowParent: "AuctionsButton4"
        anchors.left: auctionsButton4.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton4.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton5
        name: "AuctionsButton5"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton4.left
        anchors.top: auctionsButton4.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton5BuyoutFrame
        name: "AuctionsButton5BuyoutFrame"
        wowParent: "AuctionsButton5"
        anchors.right: auctionsButton5MoneyFrame.right
        anchors.top: auctionsButton5MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton5BuyoutFrameMoney
        name: "AuctionsButton5BuyoutFrameMoney"
        wowParent: "AuctionsButton5BuyoutFrame"
        anchors.right: auctionsButton5BuyoutFrame.right
        anchors.verticalCenter: auctionsButton5BuyoutFrame.verticalCenter
        width: 71.3
        height: 13
    }

    Button {
        id: auctionsButton5BuyoutFrameMoneyCopperButton
        name: "AuctionsButton5BuyoutFrameMoneyCopperButton"
        text: "85"
        wowParent: "AuctionsButton5BuyoutFrameMoney"
        anchors.right: auctionsButton5BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton5BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton5BuyoutFrameMoneyCopperButtonText"
        text: "85"
        wowParent: "AuctionsButton5BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton5BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Button {
        id: auctionsButton5BuyoutFrameMoneySilverButton
        name: "AuctionsButton5BuyoutFrameMoneySilverButton"
        text: "9"
        wowParent: "AuctionsButton5BuyoutFrameMoney"
        anchors.right: auctionsButton5BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton5BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton5BuyoutFrameMoneySilverButtonText"
        text: "9"
        wowParent: "AuctionsButton5BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton5BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Frame {
        id: auctionsButton5BuyoutFrameText
        name: "AuctionsButton5BuyoutFrameText"
        wowParent: "AuctionsButton5BuyoutFrame"
        anchors.left: auctionsButton5BuyoutFrame.left
        anchors.top: auctionsButton5BuyoutFrame.top
        width: 123.6
        height: 13
    }

    Frame {
        id: auctionsButton5ClosingTime
        name: "AuctionsButton5ClosingTime"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton5.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton5ClosingTimeText
        name: "AuctionsButton5ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton5ClosingTime"
        anchors.left: auctionsButton5ClosingTime.left
        anchors.top: auctionsButton5ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton5HighBidder
        name: "AuctionsButton5HighBidder"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton5.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton5Item
        name: "AuctionsButton5Item"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.top: auctionsButton5.top
        width: 32
        height: 32
    }

    Frame {
        id: auctionsButton5MoneyFrame
        name: "AuctionsButton5MoneyFrame"
        wowParent: "AuctionsButton5"
        anchors.right: auctionsButton5.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton5.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 71.3
        height: 13
    }

    Button {
        id: auctionsButton5MoneyFrameCopperButton
        name: "AuctionsButton5MoneyFrameCopperButton"
        text: "35"
        wowParent: "AuctionsButton5MoneyFrame"
        anchors.right: auctionsButton5MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton5MoneyFrameCopperButtonText
        name: "AuctionsButton5MoneyFrameCopperButtonText"
        text: "35"
        wowParent: "AuctionsButton5MoneyFrameCopperButton"
        anchors.right: auctionsButton5MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Button {
        id: auctionsButton5MoneyFrameSilverButton
        name: "AuctionsButton5MoneyFrameSilverButton"
        text: "9"
        wowParent: "AuctionsButton5MoneyFrame"
        anchors.right: auctionsButton5MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton5MoneyFrameCopperButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton5MoneyFrameSilverButtonText
        name: "AuctionsButton5MoneyFrameSilverButtonText"
        text: "9"
        wowParent: "AuctionsButton5MoneyFrameSilverButton"
        anchors.right: auctionsButton5MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton5MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    FontString {
        id: auctionsButton5Name
        name: "AuctionsButton5Name"
        text: "Elixir of Detect Undead"
        wowParent: "AuctionsButton5"
        anchors.left: auctionsButton5.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton5.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton6
        name: "AuctionsButton6"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton5.left
        anchors.top: auctionsButton5.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton6BuyoutFrame
        name: "AuctionsButton6BuyoutFrame"
        wowParent: "AuctionsButton6"
        anchors.right: auctionsButton6MoneyFrame.right
        anchors.top: auctionsButton6MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton6BuyoutFrameMoney
        name: "AuctionsButton6BuyoutFrameMoney"
        wowParent: "AuctionsButton6BuyoutFrame"
        anchors.right: auctionsButton6BuyoutFrame.right
        anchors.verticalCenter: auctionsButton6BuyoutFrame.verticalCenter
        width: 77.8
        height: 13
    }

    Button {
        id: auctionsButton6BuyoutFrameMoneyCopperButton
        name: "AuctionsButton6BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton6BuyoutFrameMoney"
        anchors.right: auctionsButton6BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton6BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton6BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton6BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton6BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton6BuyoutFrameMoneySilverButton
        name: "AuctionsButton6BuyoutFrameMoneySilverButton"
        text: "77"
        wowParent: "AuctionsButton6BuyoutFrameMoney"
        anchors.right: auctionsButton6BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionsButton6BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton6BuyoutFrameMoneySilverButtonText"
        text: "77"
        wowParent: "AuctionsButton6BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton6BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton6BuyoutFrameText
        name: "AuctionsButton6BuyoutFrameText"
        wowParent: "AuctionsButton6BuyoutFrame"
        anchors.left: auctionsButton6BuyoutFrame.left
        anchors.top: auctionsButton6BuyoutFrame.top
        width: 117.2
        height: 13
    }

    Frame {
        id: auctionsButton6ClosingTime
        name: "AuctionsButton6ClosingTime"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton6.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton6ClosingTimeText
        name: "AuctionsButton6ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton6ClosingTime"
        anchors.left: auctionsButton6ClosingTime.left
        anchors.top: auctionsButton6ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton6HighBidder
        name: "AuctionsButton6HighBidder"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton6.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton6Item
        name: "AuctionsButton6Item"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.top: auctionsButton6.top
        width: 32
        height: 32
    }

    Frame {
        id: auctionsButton6MoneyFrame
        name: "AuctionsButton6MoneyFrame"
        wowParent: "AuctionsButton6"
        anchors.right: auctionsButton6.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton6.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 77.8
        height: 13
    }

    Button {
        id: auctionsButton6MoneyFrameCopperButton
        name: "AuctionsButton6MoneyFrameCopperButton"
        text: "15"
        wowParent: "AuctionsButton6MoneyFrame"
        anchors.right: auctionsButton6MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton6MoneyFrameCopperButtonText
        name: "AuctionsButton6MoneyFrameCopperButtonText"
        text: "15"
        wowParent: "AuctionsButton6MoneyFrameCopperButton"
        anchors.right: auctionsButton6MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Button {
        id: auctionsButton6MoneyFrameSilverButton
        name: "AuctionsButton6MoneyFrameSilverButton"
        text: "73"
        wowParent: "AuctionsButton6MoneyFrame"
        anchors.right: auctionsButton6MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton6MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionsButton6MoneyFrameSilverButtonText
        name: "AuctionsButton6MoneyFrameSilverButtonText"
        text: "73"
        wowParent: "AuctionsButton6MoneyFrameSilverButton"
        anchors.right: auctionsButton6MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton6MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionsButton6Name
        name: "AuctionsButton6Name"
        text: "Elixir of Greater Agility"
        wowParent: "AuctionsButton6"
        anchors.left: auctionsButton6.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton6.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton7
        name: "AuctionsButton7"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton6.left
        anchors.top: auctionsButton6.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton7BuyoutFrame
        name: "AuctionsButton7BuyoutFrame"
        wowParent: "AuctionsButton7"
        anchors.right: auctionsButton7MoneyFrame.right
        anchors.top: auctionsButton7MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton7BuyoutFrameMoney
        name: "AuctionsButton7BuyoutFrameMoney"
        wowParent: "AuctionsButton7BuyoutFrame"
        anchors.right: auctionsButton7BuyoutFrame.right
        anchors.verticalCenter: auctionsButton7BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton7BuyoutFrameMoneyCopperButton
        name: "AuctionsButton7BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton7BuyoutFrameMoney"
        anchors.right: auctionsButton7BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton7BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton7BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton7BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton7BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton7BuyoutFrameMoneyGoldButton
        name: "AuctionsButton7BuyoutFrameMoneyGoldButton"
        text: "9"
        wowParent: "AuctionsButton7BuyoutFrameMoney"
        anchors.right: auctionsButton7BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton7BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton7BuyoutFrameMoneyGoldButtonText"
        text: "9"
        wowParent: "AuctionsButton7BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton7BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton7BuyoutFrameMoneySilverButton
        name: "AuctionsButton7BuyoutFrameMoneySilverButton"
        text: "96"
        wowParent: "AuctionsButton7BuyoutFrameMoney"
        anchors.right: auctionsButton7BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton7BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton7BuyoutFrameMoneySilverButtonText"
        text: "96"
        wowParent: "AuctionsButton7BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton7BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton7BuyoutFrameText
        name: "AuctionsButton7BuyoutFrameText"
        wowParent: "AuctionsButton7BuyoutFrame"
        anchors.left: auctionsButton7BuyoutFrame.left
        anchors.top: auctionsButton7BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Frame {
        id: auctionsButton7ClosingTime
        name: "AuctionsButton7ClosingTime"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton7.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton7ClosingTimeText
        name: "AuctionsButton7ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton7ClosingTime"
        anchors.left: auctionsButton7ClosingTime.left
        anchors.top: auctionsButton7ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton7HighBidder
        name: "AuctionsButton7HighBidder"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton7.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton7Item
        name: "AuctionsButton7Item"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.top: auctionsButton7.top
        width: 32
        height: 32
    }

    FontString {
        id: auctionsButton7ItemCount
        name: "AuctionsButton7ItemCount"
        text: "2"
        wowParent: "AuctionsButton7Item"
        anchors.right: auctionsButton7Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton7Item.bottom
        anchors.bottomMargin: 2
        width: 9.4
        height: 13.6
    }

    Frame {
        id: auctionsButton7MoneyFrame
        name: "AuctionsButton7MoneyFrame"
        wowParent: "AuctionsButton7"
        anchors.right: auctionsButton7.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton7.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton7MoneyFrameCopperButton
        name: "AuctionsButton7MoneyFrameCopperButton"
        text: "20"
        wowParent: "AuctionsButton7MoneyFrame"
        anchors.right: auctionsButton7MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton7MoneyFrameCopperButtonText
        name: "AuctionsButton7MoneyFrameCopperButtonText"
        text: "20"
        wowParent: "AuctionsButton7MoneyFrameCopperButton"
        anchors.right: auctionsButton7MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionsButton7MoneyFrameGoldButton
        name: "AuctionsButton7MoneyFrameGoldButton"
        text: "9"
        wowParent: "AuctionsButton7MoneyFrame"
        anchors.right: auctionsButton7MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton7MoneyFrameGoldButtonText
        name: "AuctionsButton7MoneyFrameGoldButtonText"
        text: "9"
        wowParent: "AuctionsButton7MoneyFrameGoldButton"
        anchors.right: auctionsButton7MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton7MoneyFrameSilverButton
        name: "AuctionsButton7MoneyFrameSilverButton"
        text: "46"
        wowParent: "AuctionsButton7MoneyFrame"
        anchors.right: auctionsButton7MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton7MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton7MoneyFrameSilverButtonText
        name: "AuctionsButton7MoneyFrameSilverButtonText"
        text: "46"
        wowParent: "AuctionsButton7MoneyFrameSilverButton"
        anchors.right: auctionsButton7MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton7MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionsButton7Name
        name: "AuctionsButton7Name"
        text: "Elixir of Giants"
        wowParent: "AuctionsButton7"
        anchors.left: auctionsButton7.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton7.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton8
        name: "AuctionsButton8"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton7.left
        anchors.top: auctionsButton7.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton8BuyoutFrame
        name: "AuctionsButton8BuyoutFrame"
        wowParent: "AuctionsButton8"
        anchors.right: auctionsButton8MoneyFrame.right
        anchors.top: auctionsButton8MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton8BuyoutFrameMoney
        name: "AuctionsButton8BuyoutFrameMoney"
        wowParent: "AuctionsButton8BuyoutFrame"
        anchors.right: auctionsButton8BuyoutFrame.right
        anchors.verticalCenter: auctionsButton8BuyoutFrame.verticalCenter
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton8BuyoutFrameMoneyCopperButton
        name: "AuctionsButton8BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton8BuyoutFrameMoney"
        anchors.right: auctionsButton8BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton8BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton8BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton8BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton8BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton8BuyoutFrameMoneyGoldButton
        name: "AuctionsButton8BuyoutFrameMoneyGoldButton"
        text: "6"
        wowParent: "AuctionsButton8BuyoutFrameMoney"
        anchors.right: auctionsButton8BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton8BuyoutFrameMoneyGoldButtonText
        name: "AuctionsButton8BuyoutFrameMoneyGoldButtonText"
        text: "6"
        wowParent: "AuctionsButton8BuyoutFrameMoneyGoldButton"
        anchors.right: auctionsButton8BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneyGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton8BuyoutFrameMoneySilverButton
        name: "AuctionsButton8BuyoutFrameMoneySilverButton"
        text: "92"
        wowParent: "AuctionsButton8BuyoutFrameMoney"
        anchors.right: auctionsButton8BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton8BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton8BuyoutFrameMoneySilverButtonText"
        text: "92"
        wowParent: "AuctionsButton8BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton8BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton8BuyoutFrameText
        name: "AuctionsButton8BuyoutFrameText"
        wowParent: "AuctionsButton8BuyoutFrame"
        anchors.left: auctionsButton8BuyoutFrame.left
        anchors.top: auctionsButton8BuyoutFrame.top
        width: 87.6
        height: 13
    }

    Frame {
        id: auctionsButton8ClosingTime
        name: "AuctionsButton8ClosingTime"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton8.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton8ClosingTimeText
        name: "AuctionsButton8ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton8ClosingTime"
        anchors.left: auctionsButton8ClosingTime.left
        anchors.top: auctionsButton8ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton8HighBidder
        name: "AuctionsButton8HighBidder"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton8.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton8Item
        name: "AuctionsButton8Item"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.top: auctionsButton8.top
        width: 32
        height: 32
    }

    FontString {
        id: auctionsButton8ItemCount
        name: "AuctionsButton8ItemCount"
        text: "2"
        wowParent: "AuctionsButton8Item"
        anchors.right: auctionsButton8Item.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsButton8Item.bottom
        anchors.bottomMargin: 2
        width: 9.4
        height: 13.6
    }

    Frame {
        id: auctionsButton8MoneyFrame
        name: "AuctionsButton8MoneyFrame"
        wowParent: "AuctionsButton8"
        anchors.right: auctionsButton8.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton8.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 107.3
        height: 13
    }

    Button {
        id: auctionsButton8MoneyFrameCopperButton
        name: "AuctionsButton8MoneyFrameCopperButton"
        text: "40"
        wowParent: "AuctionsButton8MoneyFrame"
        anchors.right: auctionsButton8MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton8MoneyFrameCopperButtonText
        name: "AuctionsButton8MoneyFrameCopperButtonText"
        text: "40"
        wowParent: "AuctionsButton8MoneyFrameCopperButton"
        anchors.right: auctionsButton8MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: auctionsButton8MoneyFrameGoldButton
        name: "AuctionsButton8MoneyFrameGoldButton"
        text: "6"
        wowParent: "AuctionsButton8MoneyFrame"
        anchors.right: auctionsButton8MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8MoneyFrameSilverButton.verticalCenter
        width: 22.3
        height: 13
    }

    FontString {
        id: auctionsButton8MoneyFrameGoldButtonText
        name: "AuctionsButton8MoneyFrameGoldButtonText"
        text: "6"
        wowParent: "AuctionsButton8MoneyFrameGoldButton"
        anchors.right: auctionsButton8MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrameGoldButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton8MoneyFrameSilverButton
        name: "AuctionsButton8MoneyFrameSilverButton"
        text: "57"
        wowParent: "AuctionsButton8MoneyFrame"
        anchors.right: auctionsButton8MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton8MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton8MoneyFrameSilverButtonText
        name: "AuctionsButton8MoneyFrameSilverButtonText"
        text: "57"
        wowParent: "AuctionsButton8MoneyFrameSilverButton"
        anchors.right: auctionsButton8MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton8MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionsButton8Name
        name: "AuctionsButton8Name"
        text: "Elixir of Demonslaying"
        wowParent: "AuctionsButton8"
        anchors.left: auctionsButton8.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton8.top
        width: 142
        height: 28
    }

    Button {
        id: auctionsButton9
        name: "AuctionsButton9"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsButton8.left
        anchors.top: auctionsButton8.bottom
        width: 576
        height: 37
    }

    Frame {
        id: auctionsButton9BuyoutFrame
        name: "AuctionsButton9BuyoutFrame"
        wowParent: "AuctionsButton9"
        anchors.right: auctionsButton9MoneyFrame.right
        anchors.top: auctionsButton9MoneyFrame.bottom
        anchors.topMargin: 1
        width: 197
        height: 13
    }

    Frame {
        id: auctionsButton9BuyoutFrameMoney
        name: "AuctionsButton9BuyoutFrameMoney"
        wowParent: "AuctionsButton9BuyoutFrame"
        anchors.right: auctionsButton9BuyoutFrame.right
        anchors.verticalCenter: auctionsButton9BuyoutFrame.verticalCenter
        width: 77.8
        height: 13
    }

    Button {
        id: auctionsButton9BuyoutFrameMoneyCopperButton
        name: "AuctionsButton9BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "AuctionsButton9BuyoutFrameMoney"
        anchors.right: auctionsButton9BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton9BuyoutFrameMoneyCopperButtonText
        name: "AuctionsButton9BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "AuctionsButton9BuyoutFrameMoneyCopperButton"
        anchors.right: auctionsButton9BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: auctionsButton9BuyoutFrameMoneySilverButton
        name: "AuctionsButton9BuyoutFrameMoneySilverButton"
        text: "49"
        wowParent: "AuctionsButton9BuyoutFrameMoney"
        anchors.right: auctionsButton9BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoneyCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionsButton9BuyoutFrameMoneySilverButtonText
        name: "AuctionsButton9BuyoutFrameMoneySilverButtonText"
        text: "49"
        wowParent: "AuctionsButton9BuyoutFrameMoneySilverButton"
        anchors.right: auctionsButton9BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: auctionsButton9BuyoutFrameText
        name: "AuctionsButton9BuyoutFrameText"
        wowParent: "AuctionsButton9BuyoutFrame"
        anchors.left: auctionsButton9BuyoutFrame.left
        anchors.top: auctionsButton9BuyoutFrame.top
        width: 117.2
        height: 13
    }

    Frame {
        id: auctionsButton9ClosingTime
        name: "AuctionsButton9ClosingTime"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.leftMargin: 191
        anchors.top: auctionsButton9.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton9ClosingTimeText
        name: "AuctionsButton9ClosingTimeText"
        text: "Medium"
        wowParent: "AuctionsButton9ClosingTime"
        anchors.left: auctionsButton9ClosingTime.left
        anchors.top: auctionsButton9ClosingTime.top
        width: 65
        height: 28
    }

    FontString {
        id: auctionsButton9HighBidder
        name: "AuctionsButton9HighBidder"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.leftMargin: 279
        anchors.top: auctionsButton9.top
        width: 104
        height: 28
    }

    Button {
        id: auctionsButton9Item
        name: "AuctionsButton9Item"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.top: auctionsButton9.top
        width: 32
        height: 32
    }

    Frame {
        id: auctionsButton9MoneyFrame
        name: "AuctionsButton9MoneyFrame"
        wowParent: "AuctionsButton9"
        anchors.right: auctionsButton9.right
        anchors.rightMargin: -10
        anchors.verticalCenter: auctionsButton9.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 77.8
        height: 13
    }

    Button {
        id: auctionsButton9MoneyFrameCopperButton
        name: "AuctionsButton9MoneyFrameCopperButton"
        text: "55"
        wowParent: "AuctionsButton9MoneyFrame"
        anchors.right: auctionsButton9MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: auctionsButton9MoneyFrameCopperButtonText
        name: "AuctionsButton9MoneyFrameCopperButtonText"
        text: "55"
        wowParent: "AuctionsButton9MoneyFrameCopperButton"
        anchors.right: auctionsButton9MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Button {
        id: auctionsButton9MoneyFrameSilverButton
        name: "AuctionsButton9MoneyFrameSilverButton"
        text: "46"
        wowParent: "AuctionsButton9MoneyFrame"
        anchors.right: auctionsButton9MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsButton9MoneyFrameCopperButton.verticalCenter
        width: 28.8
        height: 13
    }

    FontString {
        id: auctionsButton9MoneyFrameSilverButtonText
        name: "AuctionsButton9MoneyFrameSilverButtonText"
        text: "46"
        wowParent: "AuctionsButton9MoneyFrameSilverButton"
        anchors.right: auctionsButton9MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsButton9MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: auctionsButton9Name
        name: "AuctionsButton9Name"
        text: "Scroll of Spirit III"
        wowParent: "AuctionsButton9"
        anchors.left: auctionsButton9.left
        anchors.leftMargin: 43
        anchors.top: auctionsButton9.top
        width: 142
        height: 28
    }

    FontString {
        id: auctionsBuyoutText
        name: "AuctionsBuyoutText"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPrice.left
        anchors.leftMargin: -10
        anchors.bottom: buyoutPrice.top
        anchors.bottomMargin: 3
        width: 114.9
        height: 10.1
    }

    Button {
        id: auctionsCancelAuctionButton
        name: "AuctionsCancelAuctionButton"
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

    FontString {
        id: auctionsCancelAuctionButtonText
        name: "AuctionsCancelAuctionButtonText"
        text: "Cancel Auction"
        wowParent: "AuctionsCancelAuctionButton"
        anchors.horizontalCenter: auctionsCancelAuctionButton.horizontalCenter
        anchors.verticalCenter: auctionsCancelAuctionButton.verticalCenter
        width: 81.2
        height: 10.1
    }

    Button {
        id: auctionsCloseButton
        name: "AuctionsCloseButton"
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

    FontString {
        id: auctionsCloseButtonText
        name: "AuctionsCloseButtonText"
        text: "Close"
        wowParent: "AuctionsCloseButton"
        anchors.horizontalCenter: auctionsCloseButton.horizontalCenter
        anchors.verticalCenter: auctionsCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Button {
        id: auctionsCreateAuctionButton
        name: "AuctionsCreateAuctionButton"
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

    FontString {
        id: auctionsCreateAuctionButtonText
        name: "AuctionsCreateAuctionButtonText"
        text: "Create Auction"
        wowParent: "AuctionsCreateAuctionButton"
        anchors.horizontalCenter: auctionsCreateAuctionButton.horizontalCenter
        anchors.verticalCenter: auctionsCreateAuctionButton.verticalCenter
        width: 81.2
        height: 10.1
    }

    Frame {
        id: auctionsDepositMoneyFrame
        name: "AuctionsDepositMoneyFrame"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsDepositText.right
        anchors.leftMargin: 5
        anchors.verticalCenter: auctionsDepositText.verticalCenter
        anchors.verticalCenterOffset: 1
        width: 13
        height: 13
    }

    Button {
        id: auctionsDepositMoneyFrameGoldButton
        name: "AuctionsDepositMoneyFrameGoldButton"
        text: "1"
        wowParent: "AuctionsDepositMoneyFrame"
        anchors.right: auctionsDepositMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: auctionsDepositMoneyFrameSilverButton.verticalCenter
        width: 20.9
        height: 13
    }

    FontString {
        id: auctionsDepositMoneyFrameGoldButtonText
        name: "AuctionsDepositMoneyFrameGoldButtonText"
        text: "1"
        wowParent: "AuctionsDepositMoneyFrameGoldButton"
        anchors.right: auctionsDepositMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsDepositMoneyFrameGoldButton.verticalCenter
        width: 7.9
        height: 13.6
    }

    Button {
        id: auctionsDepositMoneyFrameSilverButton
        name: "AuctionsDepositMoneyFrameSilverButton"
        text: "65"
        wowParent: "AuctionsDepositMoneyFrame"
        anchors.right: auctionsDepositMoneyFrameCopperButton.right
        anchors.verticalCenter: auctionsDepositMoneyFrameCopperButton.verticalCenter
        width: 29.5
        height: 13
    }

    FontString {
        id: auctionsDepositMoneyFrameSilverButtonText
        name: "AuctionsDepositMoneyFrameSilverButtonText"
        text: "65"
        wowParent: "AuctionsDepositMoneyFrameSilverButton"
        anchors.right: auctionsDepositMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: auctionsDepositMoneyFrameSilverButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    FontString {
        id: auctionsDepositText
        name: "AuctionsDepositText"
        text: "Deposit:"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 9
        anchors.verticalCenter: auctionFrameAuctions.bottom
        anchors.verticalCenterOffset: -77
        width: 50.3
        height: 12.2
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
    }

    FontString {
        id: auctionsDurationSortText
        name: "AuctionsDurationSortText"
        text: "Time Left"
        wowParent: "AuctionsDurationSort"
        anchors.left: auctionsDurationSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsDurationSort.verticalCenter
        width: 48.1
        height: 10.1
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
    }

    FontString {
        id: auctionsHighBidderSortText
        name: "AuctionsHighBidderSortText"
        text: "High Bidder"
        wowParent: "AuctionsHighBidderSort"
        anchors.left: auctionsHighBidderSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsHighBidderSort.verticalCenter
        width: 61.1
        height: 10.1
    }

    Button {
        id: auctionsItemButton
        name: "AuctionsItemButton"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 14
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 92
        width: 37
        height: 37
    }

    FontString {
        id: auctionsItemButtonCount
        name: "AuctionsItemButtonCount"
        text: "100"
        wowParent: "AuctionsItemButton"
        anchors.right: auctionsItemButton.right
        anchors.rightMargin: 5
        anchors.bottom: auctionsItemButton.bottom
        anchors.bottomMargin: 2
        width: 22.3
        height: 13.6
    }

    FontString {
        id: auctionsItemButtonName
        name: "AuctionsItemButtonName"
        wowParent: "AuctionsItemButton"
        anchors.left: auctionsItemButton.right
        anchors.leftMargin: 5
        anchors.top: auctionsItemButton.top
        width: 124
        height: 30
    }

    FontString {
        id: auctionsItemText
        name: "AuctionsItemText"
        text: "Auction Item"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 9
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 78
        width: 66.8
        height: 10.1
    }

    EditBox {
        id: auctionsNumStacksEntry
        name: "AuctionsNumStacksEntry"
        text: "1"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsStackSizeEntry.left
        anchors.top: auctionsStackSizeEntry.bottom
        anchors.topMargin: 15
        width: 50
        height: 20
    }

    Button {
        id: auctionsNumStacksMaxButton
        name: "AuctionsNumStacksMaxButton"
        text: "Maximum"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsNumStacksEntry.right
        anchors.leftMargin: 5
        anchors.verticalCenter: auctionsNumStacksEntry.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 21
    }

    FontString {
        id: auctionsNumStacksMaxButtonText
        name: "AuctionsNumStacksMaxButtonText"
        text: "Maximum"
        wowParent: "AuctionsNumStacksMaxButton"
        anchors.horizontalCenter: auctionsNumStacksMaxButton.horizontalCenter
        anchors.verticalCenter: auctionsNumStacksMaxButton.verticalCenter
        width: 53.9
        height: 10.1
    }

    Button {
        id: auctionsQualitySort
        name: "AuctionsQualitySort"
        text: "Rarity"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 224
        anchors.top: auctionFrame.top
        anchors.topMargin: 50
        width: 185
        height: 19
    }

    FontString {
        id: auctionsQualitySortText
        name: "AuctionsQualitySortText"
        text: "Rarity"
        wowParent: "AuctionsQualitySort"
        anchors.left: auctionsQualitySort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: auctionsQualitySort.verticalCenter
        width: 29.5
        height: 10.1
    }

    ScrollFrame {
        id: auctionsScrollFrame
        name: "AuctionsScrollFrame"
        wowParent: "AuctionFrameAuctions"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -803
        anchors.top: auctionFrame.top
        anchors.topMargin: 71
        width: 435
        height: 338
    }

    Slider {
        id: auctionsScrollFrameScrollBar
        name: "AuctionsScrollFrameScrollBar"
        wowParent: "AuctionsScrollFrame"
        style: "ScrollBar"
        anchors.left: auctionsScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: auctionsScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 306
    }

    Frame {
        id: auctionsScrollFrameScrollBarDiabolicTrack
        name: "AuctionsScrollFrameScrollBarDiabolicTrack"
        wowParent: "AuctionsScrollFrameScrollBar"
        anchors.horizontalCenter: auctionsScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: auctionsScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 340
    }

    Button {
        id: auctionsScrollFrameScrollBarScrollDownButton
        name: "AuctionsScrollFrameScrollBarScrollDownButton"
        wowParent: "AuctionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: auctionsScrollFrameScrollBar.horizontalCenter
        anchors.top: auctionsScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: auctionsScrollFrameScrollBarScrollUpButton
        name: "AuctionsScrollFrameScrollBarScrollUpButton"
        wowParent: "AuctionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: auctionsScrollFrameScrollBar.horizontalCenter
        anchors.bottom: auctionsScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: auctionsScrollFrameScrollChildFrame
        name: "AuctionsScrollFrameScrollChildFrame"
        wowParent: "AuctionsScrollFrame"
        anchors.left: auctionsScrollFrame.left
        anchors.top: auctionsScrollFrame.top
        width: 300
        height: 555
    }

    EditBox {
        id: auctionsStackSizeEntry
        name: "AuctionsStackSizeEntry"
        text: "20"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 17
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 145
        width: 50
        height: 20
    }

    Button {
        id: auctionsStackSizeMaxButton
        name: "AuctionsStackSizeMaxButton"
        text: "Maximum"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionsStackSizeEntry.right
        anchors.leftMargin: 5
        anchors.verticalCenter: auctionsStackSizeEntry.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 100
        height: 21
    }

    FontString {
        id: auctionsStackSizeMaxButtonText
        name: "AuctionsStackSizeMaxButtonText"
        text: "Maximum"
        wowParent: "AuctionsStackSizeMaxButton"
        anchors.horizontalCenter: auctionsStackSizeMaxButton.horizontalCenter
        anchors.verticalCenter: auctionsStackSizeMaxButton.verticalCenter
        width: 53.9
        height: 10.1
    }

    FontString {
        id: auctionsTabText
        name: "AuctionsTabText"
        text: "Create Auction"
        wowParent: "AuctionFrameAuctions"
        anchors.horizontalCenter: auctionFrameAuctions.left
        anchors.horizontalCenterOffset: 105
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 53
        width: 76.2
        height: 10.1
    }

    FontString {
        id: auctionsTitle
        name: "AuctionsTitle"
        text: "Padirac's Auctions"
        wowParent: "AuctionFrameAuctions"
        anchors.horizontalCenter: auctionFrameAuctions.horizontalCenter
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 18
        width: 114.2
        height: 12.2
    }

    Button {
        id: bidBidButton
        name: "BidBidButton"
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

    FontString {
        id: bidBidButtonText
        name: "BidBidButtonText"
        text: "Bid"
        wowParent: "BidBidButton"
        anchors.horizontalCenter: bidBidButton.horizontalCenter
        anchors.verticalCenter: bidBidButton.verticalCenter
        width: 17.3
        height: 10.1
    }

    Frame {
        id: bidBidPrice
        name: "BidBidPrice"
        wowParent: "AuctionFrameBid"
        anchors.horizontalCenter: auctionFrameBid.horizontalCenter
        anchors.horizontalCenterOffset: -15
        anchors.bottom: auctionFrameBid.bottom
        anchors.bottomMargin: -8
        width: 176
        height: 18
    }

    EditBox {
        id: bidBidPriceCopper
        name: "BidBidPriceCopper"
        wowParent: "BidBidPrice"
        anchors.left: bidBidPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: bidBidPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    EditBox {
        id: bidBidPriceGold
        name: "BidBidPriceGold"
        wowParent: "BidBidPrice"
        anchors.left: bidBidPrice.left
        anchors.top: bidBidPrice.top
        width: 58
        height: 20
    }

    EditBox {
        id: bidBidPriceSilver
        name: "BidBidPriceSilver"
        wowParent: "BidBidPrice"
        anchors.left: bidBidPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: bidBidPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Button {
        id: bidBidSort
        name: "BidBidSort"
        text: "Current Bid"
        wowParent: "AuctionFrameBid"
        anchors.left: bidStatusSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: bidStatusSort.verticalCenter
        width: 169
        height: 19
    }

    FontString {
        id: bidBidSortText
        name: "BidBidSortText"
        text: "Current Bid"
        wowParent: "BidBidSort"
        anchors.left: bidBidSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidBidSort.verticalCenter
        width: 57.5
        height: 10.1
    }

    FontString {
        id: bidBidText
        name: "BidBidText"
        text: "Bid"
        wowParent: "AuctionFrameBid"
        anchors.right: auctionFrameBid.horizontalCenter
        anchors.rightMargin: 115
        anchors.bottom: auctionFrameBid.bottom
        anchors.bottomMargin: -5
        width: 17.3
        height: 10.1
    }

    Button {
        id: bidBuyoutButton
        name: "BidBuyoutButton"
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

    FontString {
        id: bidBuyoutButtonText
        name: "BidBuyoutButtonText"
        text: "Buyout"
        wowParent: "BidBuyoutButton"
        anchors.horizontalCenter: bidBuyoutButton.horizontalCenter
        anchors.verticalCenter: bidBuyoutButton.verticalCenter
        width: 38.8
        height: 10.1
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
    }

    FontString {
        id: bidBuyoutSortText
        name: "BidBuyoutSortText"
        text: "Buyout Price"
        wowParent: "BidBuyoutSort"
        anchors.left: bidBuyoutSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidBuyoutSort.verticalCenter
        width: 63.9
        height: 10.1
    }

    Button {
        id: bidCloseButton
        name: "BidCloseButton"
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

    FontString {
        id: bidCloseButtonText
        name: "BidCloseButtonText"
        text: "Close"
        wowParent: "BidCloseButton"
        anchors.horizontalCenter: bidCloseButton.horizontalCenter
        anchors.verticalCenter: bidCloseButton.verticalCenter
        width: 28
        height: 10.1
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
    }

    FontString {
        id: bidDurationSortText
        name: "BidDurationSortText"
        text: "Time Left"
        wowParent: "BidDurationSort"
        anchors.left: bidDurationSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidDurationSort.verticalCenter
        width: 48.1
        height: 10.1
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
    }

    FontString {
        id: bidLevelSortText
        name: "BidLevelSortText"
        text: "Lvl"
        wowParent: "BidLevelSort"
        anchors.left: bidLevelSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidLevelSort.verticalCenter
        width: 15.1
        height: 10.1
    }

    Button {
        id: bidQualitySort
        name: "BidQualitySort"
        text: "Rarity"
        wowParent: "AuctionFrameBid"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 57
        anchors.top: auctionFrame.top
        anchors.topMargin: 50
        width: 195
        height: 19
    }

    FontString {
        id: bidQualitySortText
        name: "BidQualitySortText"
        text: "Rarity"
        wowParent: "BidQualitySort"
        anchors.left: bidQualitySort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidQualitySort.verticalCenter
        width: 29.5
        height: 10.1
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
    }

    FontString {
        id: bidStatusSortText
        name: "BidStatusSortText"
        text: "Bid Status"
        wowParent: "BidStatusSort"
        anchors.left: bidStatusSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: bidStatusSort.verticalCenter
        width: 51
        height: 10.1
    }

    FontString {
        id: bidTitle
        name: "BidTitle"
        text: "Bid"
        wowParent: "AuctionFrameBid"
        anchors.horizontalCenter: auctionFrameBid.horizontalCenter
        anchors.top: auctionFrameBid.top
        anchors.topMargin: 18
        width: 20.1
        height: 12.2
    }

    Button {
        id: browseBidButton
        name: "BrowseBidButton"
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

    FontString {
        id: browseBidButtonText
        name: "BrowseBidButtonText"
        text: "Bid"
        wowParent: "BrowseBidButton"
        anchors.horizontalCenter: browseBidButton.horizontalCenter
        anchors.verticalCenter: browseBidButton.verticalCenter
        width: 17.3
        height: 10.1
    }

    Frame {
        id: browseBidPrice
        name: "BrowseBidPrice"
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: auctionFrameBrowse.horizontalCenter
        anchors.horizontalCenterOffset: 25
        anchors.bottom: auctionFrameBrowse.bottom
        anchors.bottomMargin: -8
        width: 176
        height: 18
    }

    EditBox {
        id: browseBidPriceCopper
        name: "BrowseBidPriceCopper"
        wowParent: "BrowseBidPrice"
        anchors.left: browseBidPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: browseBidPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    EditBox {
        id: browseBidPriceGold
        name: "BrowseBidPriceGold"
        wowParent: "BrowseBidPrice"
        anchors.left: browseBidPrice.left
        anchors.top: browseBidPrice.top
        width: 58
        height: 20
    }

    EditBox {
        id: browseBidPriceSilver
        name: "BrowseBidPriceSilver"
        wowParent: "BrowseBidPrice"
        anchors.left: browseBidPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: browseBidPriceGold.verticalCenter
        width: 30
        height: 20
    }

    FontString {
        id: browseBidText
        name: "BrowseBidText"
        text: "Bid"
        wowParent: "BrowseBidPrice"
        anchors.right: browseBidPrice.left
        anchors.rightMargin: 10
        anchors.verticalCenter: browseBidPrice.verticalCenter
        width: 17.3
        height: 10.1
    }

    Button {
        id: browseButton1
        name: "BrowseButton1"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 196
        anchors.top: auctionFrame.top
        anchors.topMargin: 103
        width: 600
        height: 37
    }

    Frame {
        id: browseButton1BuyoutFrame
        name: "BrowseButton1BuyoutFrame"
        wowParent: "BrowseButton1"
        anchors.right: browseButton1MoneyFrame.right
        anchors.top: browseButton1MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton1BuyoutFrameMoney
        name: "BrowseButton1BuyoutFrameMoney"
        wowParent: "BrowseButton1BuyoutFrame"
        anchors.right: browseButton1BuyoutFrame.right
        anchors.verticalCenter: browseButton1BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton1BuyoutFrameMoneyCopperButton
        name: "BrowseButton1BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "BrowseButton1BuyoutFrameMoney"
        anchors.right: browseButton1BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton1BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton1BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "BrowseButton1BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton1BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton1BuyoutFrameMoneyGoldButton
        name: "BrowseButton1BuyoutFrameMoneyGoldButton"
        text: "249"
        wowParent: "BrowseButton1BuyoutFrameMoney"
        anchors.right: browseButton1BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton1BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton1BuyoutFrameMoneyGoldButtonText"
        text: "249"
        wowParent: "BrowseButton1BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton1BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton1BuyoutFrameMoneySilverButton
        name: "BrowseButton1BuyoutFrameMoneySilverButton"
        text: "75"
        wowParent: "BrowseButton1BuyoutFrameMoney"
        anchors.right: browseButton1BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton1BuyoutFrameMoneySilverButtonText
        name: "BrowseButton1BuyoutFrameMoneySilverButtonText"
        text: "75"
        wowParent: "BrowseButton1BuyoutFrameMoneySilverButton"
        anchors.right: browseButton1BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1BuyoutFrameMoneySilverButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Frame {
        id: browseButton1BuyoutFrameText
        name: "BrowseButton1BuyoutFrameText"
        wowParent: "BrowseButton1BuyoutFrame"
        anchors.left: browseButton1BuyoutFrame.left
        anchors.top: browseButton1BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton1ClosingTime
        name: "BrowseButton1ClosingTime"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 267
        anchors.top: browseButton1.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton1ClosingTimeText
        name: "BrowseButton1ClosingTimeText"
        text: "Very Long"
        wowParent: "BrowseButton1ClosingTime"
        anchors.left: browseButton1ClosingTime.left
        anchors.top: browseButton1ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton1HighBidder
        name: "BrowseButton1HighBidder"
        text: "Kovasky"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 345
        anchors.top: browseButton1.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton1Item
        name: "BrowseButton1Item"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.top: browseButton1.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton1ItemCount
        name: "BrowseButton1ItemCount"
        text: "20"
        wowParent: "BrowseButton1Item"
        anchors.right: browseButton1Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton1Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton1Level
        name: "BrowseButton1Level"
        text: "80"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 205
        anchors.top: browseButton1.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton1MoneyFrame
        name: "BrowseButton1MoneyFrame"
        wowParent: "BrowseButton1"
        anchors.right: browseButton1.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton1.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton1MoneyFrameCopperButton
        name: "BrowseButton1MoneyFrameCopperButton"
        text: "25"
        wowParent: "BrowseButton1MoneyFrame"
        anchors.right: browseButton1MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton1MoneyFrameCopperButtonText
        name: "BrowseButton1MoneyFrameCopperButtonText"
        text: "25"
        wowParent: "BrowseButton1MoneyFrameCopperButton"
        anchors.right: browseButton1MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrameCopperButton.verticalCenter
        width: 16.5
        height: 13.6
    }

    Button {
        id: browseButton1MoneyFrameGoldButton
        name: "BrowseButton1MoneyFrameGoldButton"
        text: "237"
        wowParent: "BrowseButton1MoneyFrame"
        anchors.right: browseButton1MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton1MoneyFrameGoldButtonText
        name: "BrowseButton1MoneyFrameGoldButtonText"
        text: "237"
        wowParent: "BrowseButton1MoneyFrameGoldButton"
        anchors.right: browseButton1MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton1MoneyFrameSilverButton
        name: "BrowseButton1MoneyFrameSilverButton"
        text: "26"
        wowParent: "BrowseButton1MoneyFrame"
        anchors.right: browseButton1MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton1MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton1MoneyFrameSilverButtonText
        name: "BrowseButton1MoneyFrameSilverButtonText"
        text: "26"
        wowParent: "BrowseButton1MoneyFrameSilverButton"
        anchors.right: browseButton1MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton1MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton1Name
        name: "BrowseButton1Name"
        text: "Durable Nerubhide Cape"
        wowParent: "BrowseButton1"
        anchors.left: browseButton1.left
        anchors.leftMargin: 43
        anchors.top: browseButton1.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton2
        name: "BrowseButton2"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton1.left
        anchors.top: browseButton1.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton2BuyoutFrame
        name: "BrowseButton2BuyoutFrame"
        wowParent: "BrowseButton2"
        anchors.right: browseButton2MoneyFrame.right
        anchors.top: browseButton2MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton2BuyoutFrameMoney
        name: "BrowseButton2BuyoutFrameMoney"
        wowParent: "BrowseButton2BuyoutFrame"
        anchors.right: browseButton2BuyoutFrame.right
        anchors.verticalCenter: browseButton2BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton2BuyoutFrameMoneyCopperButton
        name: "BrowseButton2BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoney"
        anchors.right: browseButton2BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton2BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton2BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton2BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton2BuyoutFrameMoneyGoldButton
        name: "BrowseButton2BuyoutFrameMoneyGoldButton"
        text: "250"
        wowParent: "BrowseButton2BuyoutFrameMoney"
        anchors.right: browseButton2BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton2BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton2BuyoutFrameMoneyGoldButtonText"
        text: "250"
        wowParent: "BrowseButton2BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton2BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton2BuyoutFrameMoneySilverButton
        name: "BrowseButton2BuyoutFrameMoneySilverButton"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoney"
        anchors.right: browseButton2BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton2BuyoutFrameMoneySilverButtonText
        name: "BrowseButton2BuyoutFrameMoneySilverButtonText"
        text: "0"
        wowParent: "BrowseButton2BuyoutFrameMoneySilverButton"
        anchors.right: browseButton2BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Frame {
        id: browseButton2BuyoutFrameText
        name: "BrowseButton2BuyoutFrameText"
        wowParent: "BrowseButton2BuyoutFrame"
        anchors.left: browseButton2BuyoutFrame.left
        anchors.top: browseButton2BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton2ClosingTime
        name: "BrowseButton2ClosingTime"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 267
        anchors.top: browseButton2.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton2ClosingTimeText
        name: "BrowseButton2ClosingTimeText"
        text: "Very Long"
        wowParent: "BrowseButton2ClosingTime"
        anchors.left: browseButton2ClosingTime.left
        anchors.top: browseButton2ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton2HighBidder
        name: "BrowseButton2HighBidder"
        text: "Fancyblades"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 345
        anchors.top: browseButton2.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton2Item
        name: "BrowseButton2Item"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.top: browseButton2.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton2ItemCount
        name: "BrowseButton2ItemCount"
        text: "20"
        wowParent: "BrowseButton2Item"
        anchors.right: browseButton2Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton2Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton2Level
        name: "BrowseButton2Level"
        text: "80"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 205
        anchors.top: browseButton2.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton2MoneyFrame
        name: "BrowseButton2MoneyFrame"
        wowParent: "BrowseButton2"
        anchors.right: browseButton2.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton2.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton2MoneyFrameCopperButton
        name: "BrowseButton2MoneyFrameCopperButton"
        text: "0"
        wowParent: "BrowseButton2MoneyFrame"
        anchors.right: browseButton2MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton2MoneyFrameCopperButtonText
        name: "BrowseButton2MoneyFrameCopperButtonText"
        text: "0"
        wowParent: "BrowseButton2MoneyFrameCopperButton"
        anchors.right: browseButton2MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton2MoneyFrameGoldButton
        name: "BrowseButton2MoneyFrameGoldButton"
        text: "250"
        wowParent: "BrowseButton2MoneyFrame"
        anchors.right: browseButton2MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton2MoneyFrameGoldButtonText
        name: "BrowseButton2MoneyFrameGoldButtonText"
        text: "250"
        wowParent: "BrowseButton2MoneyFrameGoldButton"
        anchors.right: browseButton2MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton2MoneyFrameSilverButton
        name: "BrowseButton2MoneyFrameSilverButton"
        text: "0"
        wowParent: "BrowseButton2MoneyFrame"
        anchors.right: browseButton2MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton2MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton2MoneyFrameSilverButtonText
        name: "BrowseButton2MoneyFrameSilverButtonText"
        text: "0"
        wowParent: "BrowseButton2MoneyFrameSilverButton"
        anchors.right: browseButton2MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton2MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    FontString {
        id: browseButton2Name
        name: "BrowseButton2Name"
        text: "Durable Nerubhide Cape"
        wowParent: "BrowseButton2"
        anchors.left: browseButton2.left
        anchors.leftMargin: 43
        anchors.top: browseButton2.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton3
        name: "BrowseButton3"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton2.left
        anchors.top: browseButton2.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton3BuyoutFrame
        name: "BrowseButton3BuyoutFrame"
        wowParent: "BrowseButton3"
        anchors.right: browseButton3MoneyFrame.right
        anchors.top: browseButton3MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton3BuyoutFrameMoney
        name: "BrowseButton3BuyoutFrameMoney"
        wowParent: "BrowseButton3BuyoutFrame"
        anchors.right: browseButton3BuyoutFrame.right
        anchors.verticalCenter: browseButton3BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton3BuyoutFrameMoneyCopperButton
        name: "BrowseButton3BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoney"
        anchors.right: browseButton3BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton3BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton3BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton3BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton3BuyoutFrameMoneyGoldButton
        name: "BrowseButton3BuyoutFrameMoneyGoldButton"
        text: "250"
        wowParent: "BrowseButton3BuyoutFrameMoney"
        anchors.right: browseButton3BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton3BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton3BuyoutFrameMoneyGoldButtonText"
        text: "250"
        wowParent: "BrowseButton3BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton3BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton3BuyoutFrameMoneySilverButton
        name: "BrowseButton3BuyoutFrameMoneySilverButton"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoney"
        anchors.right: browseButton3BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton3BuyoutFrameMoneySilverButtonText
        name: "BrowseButton3BuyoutFrameMoneySilverButtonText"
        text: "0"
        wowParent: "BrowseButton3BuyoutFrameMoneySilverButton"
        anchors.right: browseButton3BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Frame {
        id: browseButton3BuyoutFrameText
        name: "BrowseButton3BuyoutFrameText"
        wowParent: "BrowseButton3BuyoutFrame"
        anchors.left: browseButton3BuyoutFrame.left
        anchors.top: browseButton3BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton3ClosingTime
        name: "BrowseButton3ClosingTime"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 267
        anchors.top: browseButton3.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton3ClosingTimeText
        name: "BrowseButton3ClosingTimeText"
        text: "Long"
        wowParent: "BrowseButton3ClosingTime"
        anchors.left: browseButton3ClosingTime.left
        anchors.top: browseButton3ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton3HighBidder
        name: "BrowseButton3HighBidder"
        text: "Krysimpaler"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 345
        anchors.top: browseButton3.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton3Item
        name: "BrowseButton3Item"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.top: browseButton3.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton3ItemCount
        name: "BrowseButton3ItemCount"
        text: "20"
        wowParent: "BrowseButton3Item"
        anchors.right: browseButton3Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton3Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton3Level
        name: "BrowseButton3Level"
        text: "80"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 205
        anchors.top: browseButton3.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton3MoneyFrame
        name: "BrowseButton3MoneyFrame"
        wowParent: "BrowseButton3"
        anchors.right: browseButton3.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton3.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton3MoneyFrameCopperButton
        name: "BrowseButton3MoneyFrameCopperButton"
        text: "0"
        wowParent: "BrowseButton3MoneyFrame"
        anchors.right: browseButton3MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton3MoneyFrameCopperButtonText
        name: "BrowseButton3MoneyFrameCopperButtonText"
        text: "0"
        wowParent: "BrowseButton3MoneyFrameCopperButton"
        anchors.right: browseButton3MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton3MoneyFrameGoldButton
        name: "BrowseButton3MoneyFrameGoldButton"
        text: "250"
        wowParent: "BrowseButton3MoneyFrame"
        anchors.right: browseButton3MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton3MoneyFrameGoldButtonText
        name: "BrowseButton3MoneyFrameGoldButtonText"
        text: "250"
        wowParent: "BrowseButton3MoneyFrameGoldButton"
        anchors.right: browseButton3MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton3MoneyFrameSilverButton
        name: "BrowseButton3MoneyFrameSilverButton"
        text: "0"
        wowParent: "BrowseButton3MoneyFrame"
        anchors.right: browseButton3MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton3MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton3MoneyFrameSilverButtonText
        name: "BrowseButton3MoneyFrameSilverButtonText"
        text: "0"
        wowParent: "BrowseButton3MoneyFrameSilverButton"
        anchors.right: browseButton3MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton3MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    FontString {
        id: browseButton3Name
        name: "BrowseButton3Name"
        text: "Earthen Leg Armor"
        wowParent: "BrowseButton3"
        anchors.left: browseButton3.left
        anchors.leftMargin: 43
        anchors.top: browseButton3.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton4
        name: "BrowseButton4"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton3.left
        anchors.top: browseButton3.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton4BuyoutFrame
        name: "BrowseButton4BuyoutFrame"
        wowParent: "BrowseButton4"
        anchors.right: browseButton4MoneyFrame.right
        anchors.top: browseButton4MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton4BuyoutFrameMoney
        name: "BrowseButton4BuyoutFrameMoney"
        wowParent: "BrowseButton4BuyoutFrame"
        anchors.right: browseButton4BuyoutFrame.right
        anchors.verticalCenter: browseButton4BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton4BuyoutFrameMoneyCopperButton
        name: "BrowseButton4BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoney"
        anchors.right: browseButton4BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton4BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton4BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton4BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton4BuyoutFrameMoneyGoldButton
        name: "BrowseButton4BuyoutFrameMoneyGoldButton"
        text: "250"
        wowParent: "BrowseButton4BuyoutFrameMoney"
        anchors.right: browseButton4BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton4BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton4BuyoutFrameMoneyGoldButtonText"
        text: "250"
        wowParent: "BrowseButton4BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton4BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton4BuyoutFrameMoneySilverButton
        name: "BrowseButton4BuyoutFrameMoneySilverButton"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoney"
        anchors.right: browseButton4BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton4BuyoutFrameMoneySilverButtonText
        name: "BrowseButton4BuyoutFrameMoneySilverButtonText"
        text: "0"
        wowParent: "BrowseButton4BuyoutFrameMoneySilverButton"
        anchors.right: browseButton4BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Frame {
        id: browseButton4BuyoutFrameText
        name: "BrowseButton4BuyoutFrameText"
        wowParent: "BrowseButton4BuyoutFrame"
        anchors.left: browseButton4BuyoutFrame.left
        anchors.top: browseButton4BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton4ClosingTime
        name: "BrowseButton4ClosingTime"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 267
        anchors.top: browseButton4.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton4ClosingTimeText
        name: "BrowseButton4ClosingTimeText"
        text: "Long"
        wowParent: "BrowseButton4ClosingTime"
        anchors.left: browseButton4ClosingTime.left
        anchors.top: browseButton4ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton4HighBidder
        name: "BrowseButton4HighBidder"
        text: "Krysimpaler"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 345
        anchors.top: browseButton4.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton4Item
        name: "BrowseButton4Item"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.top: browseButton4.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton4ItemCount
        name: "BrowseButton4ItemCount"
        text: "20"
        wowParent: "BrowseButton4Item"
        anchors.right: browseButton4Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton4Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton4Level
        name: "BrowseButton4Level"
        text: "80"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 205
        anchors.top: browseButton4.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton4MoneyFrame
        name: "BrowseButton4MoneyFrame"
        wowParent: "BrowseButton4"
        anchors.right: browseButton4.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton4.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton4MoneyFrameCopperButton
        name: "BrowseButton4MoneyFrameCopperButton"
        text: "0"
        wowParent: "BrowseButton4MoneyFrame"
        anchors.right: browseButton4MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton4MoneyFrameCopperButtonText
        name: "BrowseButton4MoneyFrameCopperButtonText"
        text: "0"
        wowParent: "BrowseButton4MoneyFrameCopperButton"
        anchors.right: browseButton4MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton4MoneyFrameGoldButton
        name: "BrowseButton4MoneyFrameGoldButton"
        text: "250"
        wowParent: "BrowseButton4MoneyFrame"
        anchors.right: browseButton4MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton4MoneyFrameGoldButtonText
        name: "BrowseButton4MoneyFrameGoldButtonText"
        text: "250"
        wowParent: "BrowseButton4MoneyFrameGoldButton"
        anchors.right: browseButton4MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton4MoneyFrameSilverButton
        name: "BrowseButton4MoneyFrameSilverButton"
        text: "0"
        wowParent: "BrowseButton4MoneyFrame"
        anchors.right: browseButton4MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton4MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton4MoneyFrameSilverButtonText
        name: "BrowseButton4MoneyFrameSilverButtonText"
        text: "0"
        wowParent: "BrowseButton4MoneyFrameSilverButton"
        anchors.right: browseButton4MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton4MoneyFrameSilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    FontString {
        id: browseButton4Name
        name: "BrowseButton4Name"
        text: "Earthen Leg Armor"
        wowParent: "BrowseButton4"
        anchors.left: browseButton4.left
        anchors.leftMargin: 43
        anchors.top: browseButton4.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton5
        name: "BrowseButton5"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton4.left
        anchors.top: browseButton4.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton5BuyoutFrame
        name: "BrowseButton5BuyoutFrame"
        wowParent: "BrowseButton5"
        anchors.right: browseButton5MoneyFrame.right
        anchors.top: browseButton5MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton5BuyoutFrameMoney
        name: "BrowseButton5BuyoutFrameMoney"
        wowParent: "BrowseButton5BuyoutFrame"
        anchors.right: browseButton5BuyoutFrame.right
        anchors.verticalCenter: browseButton5BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton5BuyoutFrameMoneyCopperButton
        name: "BrowseButton5BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "BrowseButton5BuyoutFrameMoney"
        anchors.right: browseButton5BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton5BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton5BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "BrowseButton5BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton5BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton5BuyoutFrameMoneyGoldButton
        name: "BrowseButton5BuyoutFrameMoneyGoldButton"
        text: "390"
        wowParent: "BrowseButton5BuyoutFrameMoney"
        anchors.right: browseButton5BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton5BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton5BuyoutFrameMoneyGoldButtonText"
        text: "390"
        wowParent: "BrowseButton5BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton5BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton5BuyoutFrameMoneySilverButton
        name: "BrowseButton5BuyoutFrameMoneySilverButton"
        text: "50"
        wowParent: "BrowseButton5BuyoutFrameMoney"
        anchors.right: browseButton5BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton5BuyoutFrameMoneySilverButtonText
        name: "BrowseButton5BuyoutFrameMoneySilverButtonText"
        text: "50"
        wowParent: "BrowseButton5BuyoutFrameMoneySilverButton"
        anchors.right: browseButton5BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: browseButton5BuyoutFrameText
        name: "BrowseButton5BuyoutFrameText"
        wowParent: "BrowseButton5BuyoutFrame"
        anchors.left: browseButton5BuyoutFrame.left
        anchors.top: browseButton5BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton5ClosingTime
        name: "BrowseButton5ClosingTime"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 267
        anchors.top: browseButton5.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton5ClosingTimeText
        name: "BrowseButton5ClosingTimeText"
        text: "Very Long"
        wowParent: "BrowseButton5ClosingTime"
        anchors.left: browseButton5ClosingTime.left
        anchors.top: browseButton5ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton5HighBidder
        name: "BrowseButton5HighBidder"
        text: "Kovasky"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 345
        anchors.top: browseButton5.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton5Item
        name: "BrowseButton5Item"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.top: browseButton5.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton5ItemCount
        name: "BrowseButton5ItemCount"
        text: "20"
        wowParent: "BrowseButton5Item"
        anchors.right: browseButton5Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton5Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton5Level
        name: "BrowseButton5Level"
        text: "80"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 205
        anchors.top: browseButton5.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton5MoneyFrame
        name: "BrowseButton5MoneyFrame"
        wowParent: "BrowseButton5"
        anchors.right: browseButton5.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton5.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton5MoneyFrameCopperButton
        name: "BrowseButton5MoneyFrameCopperButton"
        text: "50"
        wowParent: "BrowseButton5MoneyFrame"
        anchors.right: browseButton5MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton5MoneyFrameCopperButtonText
        name: "BrowseButton5MoneyFrameCopperButtonText"
        text: "50"
        wowParent: "BrowseButton5MoneyFrameCopperButton"
        anchors.right: browseButton5MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: browseButton5MoneyFrameGoldButton
        name: "BrowseButton5MoneyFrameGoldButton"
        text: "370"
        wowParent: "BrowseButton5MoneyFrame"
        anchors.right: browseButton5MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton5MoneyFrameGoldButtonText
        name: "BrowseButton5MoneyFrameGoldButtonText"
        text: "370"
        wowParent: "BrowseButton5MoneyFrameGoldButton"
        anchors.right: browseButton5MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton5MoneyFrameSilverButton
        name: "BrowseButton5MoneyFrameSilverButton"
        text: "97"
        wowParent: "BrowseButton5MoneyFrame"
        anchors.right: browseButton5MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton5MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton5MoneyFrameSilverButtonText
        name: "BrowseButton5MoneyFrameSilverButtonText"
        text: "97"
        wowParent: "BrowseButton5MoneyFrameSilverButton"
        anchors.right: browseButton5MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton5MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton5Name
        name: "BrowseButton5Name"
        text: "Earthgiving Boots"
        wowParent: "BrowseButton5"
        anchors.left: browseButton5.left
        anchors.leftMargin: 43
        anchors.top: browseButton5.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton6
        name: "BrowseButton6"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton5.left
        anchors.top: browseButton5.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton6BuyoutFrame
        name: "BrowseButton6BuyoutFrame"
        wowParent: "BrowseButton6"
        anchors.right: browseButton6MoneyFrame.right
        anchors.top: browseButton6MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton6BuyoutFrameMoney
        name: "BrowseButton6BuyoutFrameMoney"
        wowParent: "BrowseButton6BuyoutFrame"
        anchors.right: browseButton6BuyoutFrame.right
        anchors.verticalCenter: browseButton6BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton6BuyoutFrameMoneyCopperButton
        name: "BrowseButton6BuyoutFrameMoneyCopperButton"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoney"
        anchors.right: browseButton6BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton6BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton6BuyoutFrameMoneyCopperButtonText"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton6BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton6BuyoutFrameMoneyGoldButton
        name: "BrowseButton6BuyoutFrameMoneyGoldButton"
        text: "590"
        wowParent: "BrowseButton6BuyoutFrameMoney"
        anchors.right: browseButton6BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton6BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton6BuyoutFrameMoneyGoldButtonText"
        text: "590"
        wowParent: "BrowseButton6BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton6BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton6BuyoutFrameMoneySilverButton
        name: "BrowseButton6BuyoutFrameMoneySilverButton"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoney"
        anchors.right: browseButton6BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton6BuyoutFrameMoneySilverButtonText
        name: "BrowseButton6BuyoutFrameMoneySilverButtonText"
        text: "0"
        wowParent: "BrowseButton6BuyoutFrameMoneySilverButton"
        anchors.right: browseButton6BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6BuyoutFrameMoneySilverButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Frame {
        id: browseButton6BuyoutFrameText
        name: "BrowseButton6BuyoutFrameText"
        wowParent: "BrowseButton6BuyoutFrame"
        anchors.left: browseButton6BuyoutFrame.left
        anchors.top: browseButton6BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton6ClosingTime
        name: "BrowseButton6ClosingTime"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 267
        anchors.top: browseButton6.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton6ClosingTimeText
        name: "BrowseButton6ClosingTimeText"
        text: "Very Long"
        wowParent: "BrowseButton6ClosingTime"
        anchors.left: browseButton6ClosingTime.left
        anchors.top: browseButton6ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton6HighBidder
        name: "BrowseButton6HighBidder"
        text: "Kovasky"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 345
        anchors.top: browseButton6.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton6Item
        name: "BrowseButton6Item"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.top: browseButton6.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton6ItemCount
        name: "BrowseButton6ItemCount"
        text: "20"
        wowParent: "BrowseButton6Item"
        anchors.right: browseButton6Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton6Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton6Level
        name: "BrowseButton6Level"
        text: "80"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 205
        anchors.top: browseButton6.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton6MoneyFrame
        name: "BrowseButton6MoneyFrame"
        wowParent: "BrowseButton6"
        anchors.right: browseButton6.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton6.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton6MoneyFrameCopperButton
        name: "BrowseButton6MoneyFrameCopperButton"
        text: "0"
        wowParent: "BrowseButton6MoneyFrame"
        anchors.right: browseButton6MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton6MoneyFrameCopperButtonText
        name: "BrowseButton6MoneyFrameCopperButtonText"
        text: "0"
        wowParent: "BrowseButton6MoneyFrameCopperButton"
        anchors.right: browseButton6MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrameCopperButton.verticalCenter
        width: 9.4
        height: 13.6
    }

    Button {
        id: browseButton6MoneyFrameGoldButton
        name: "BrowseButton6MoneyFrameGoldButton"
        text: "560"
        wowParent: "BrowseButton6MoneyFrame"
        anchors.right: browseButton6MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton6MoneyFrameGoldButtonText
        name: "BrowseButton6MoneyFrameGoldButtonText"
        text: "560"
        wowParent: "BrowseButton6MoneyFrameGoldButton"
        anchors.right: browseButton6MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton6MoneyFrameSilverButton
        name: "BrowseButton6MoneyFrameSilverButton"
        text: "50"
        wowParent: "BrowseButton6MoneyFrame"
        anchors.right: browseButton6MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton6MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton6MoneyFrameSilverButtonText
        name: "BrowseButton6MoneyFrameSilverButtonText"
        text: "50"
        wowParent: "BrowseButton6MoneyFrameSilverButton"
        anchors.right: browseButton6MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton6MoneyFrameSilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton6Name
        name: "BrowseButton6Name"
        text: "Earthgiving Legguards"
        wowParent: "BrowseButton6"
        anchors.left: browseButton6.left
        anchors.leftMargin: 43
        anchors.top: browseButton6.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton7
        name: "BrowseButton7"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton6.left
        anchors.top: browseButton6.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton7BuyoutFrame
        name: "BrowseButton7BuyoutFrame"
        wowParent: "BrowseButton7"
        anchors.right: browseButton7MoneyFrame.right
        anchors.top: browseButton7MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton7BuyoutFrameMoney
        name: "BrowseButton7BuyoutFrameMoney"
        wowParent: "BrowseButton7BuyoutFrame"
        anchors.right: browseButton7BuyoutFrame.right
        anchors.verticalCenter: browseButton7BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton7BuyoutFrameMoneyCopperButton
        name: "BrowseButton7BuyoutFrameMoneyCopperButton"
        text: "63"
        wowParent: "BrowseButton7BuyoutFrameMoney"
        anchors.right: browseButton7BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton7BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton7BuyoutFrameMoneyCopperButtonText"
        text: "63"
        wowParent: "BrowseButton7BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton7BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: browseButton7BuyoutFrameMoneyGoldButton
        name: "BrowseButton7BuyoutFrameMoneyGoldButton"
        text: "187"
        wowParent: "BrowseButton7BuyoutFrameMoney"
        anchors.right: browseButton7BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton7BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton7BuyoutFrameMoneyGoldButtonText"
        text: "187"
        wowParent: "BrowseButton7BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton7BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton7BuyoutFrameMoneySilverButton
        name: "BrowseButton7BuyoutFrameMoneySilverButton"
        text: "72"
        wowParent: "BrowseButton7BuyoutFrameMoney"
        anchors.right: browseButton7BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton7BuyoutFrameMoneySilverButtonText
        name: "BrowseButton7BuyoutFrameMoneySilverButtonText"
        text: "72"
        wowParent: "BrowseButton7BuyoutFrameMoneySilverButton"
        anchors.right: browseButton7BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: browseButton7BuyoutFrameText
        name: "BrowseButton7BuyoutFrameText"
        wowParent: "BrowseButton7BuyoutFrame"
        anchors.left: browseButton7BuyoutFrame.left
        anchors.top: browseButton7BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton7ClosingTime
        name: "BrowseButton7ClosingTime"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 267
        anchors.top: browseButton7.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton7ClosingTimeText
        name: "BrowseButton7ClosingTimeText"
        text: "Very Long"
        wowParent: "BrowseButton7ClosingTime"
        anchors.left: browseButton7ClosingTime.left
        anchors.top: browseButton7ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton7HighBidder
        name: "BrowseButton7HighBidder"
        text: "Bankbankstar"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 345
        anchors.top: browseButton7.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton7Item
        name: "BrowseButton7Item"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.top: browseButton7.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton7ItemCount
        name: "BrowseButton7ItemCount"
        text: "20"
        wowParent: "BrowseButton7Item"
        anchors.right: browseButton7Item.right
        anchors.rightMargin: 5
        anchors.bottom: browseButton7Item.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 13.6
    }

    FontString {
        id: browseButton7Level
        name: "BrowseButton7Level"
        text: "80"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 205
        anchors.top: browseButton7.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton7MoneyFrame
        name: "BrowseButton7MoneyFrame"
        wowParent: "BrowseButton7"
        anchors.right: browseButton7.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton7.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton7MoneyFrameCopperButton
        name: "BrowseButton7MoneyFrameCopperButton"
        text: "33"
        wowParent: "BrowseButton7MoneyFrame"
        anchors.right: browseButton7MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton7MoneyFrameCopperButtonText
        name: "BrowseButton7MoneyFrameCopperButtonText"
        text: "33"
        wowParent: "BrowseButton7MoneyFrameCopperButton"
        anchors.right: browseButton7MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: browseButton7MoneyFrameGoldButton
        name: "BrowseButton7MoneyFrameGoldButton"
        text: "186"
        wowParent: "BrowseButton7MoneyFrame"
        anchors.right: browseButton7MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton7MoneyFrameGoldButtonText
        name: "BrowseButton7MoneyFrameGoldButtonText"
        text: "186"
        wowParent: "BrowseButton7MoneyFrameGoldButton"
        anchors.right: browseButton7MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton7MoneyFrameSilverButton
        name: "BrowseButton7MoneyFrameSilverButton"
        text: "91"
        wowParent: "BrowseButton7MoneyFrame"
        anchors.right: browseButton7MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton7MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton7MoneyFrameSilverButtonText
        name: "BrowseButton7MoneyFrameSilverButtonText"
        text: "91"
        wowParent: "BrowseButton7MoneyFrameSilverButton"
        anchors.right: browseButton7MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton7MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    FontString {
        id: browseButton7Name
        name: "BrowseButton7Name"
        text: "Ebonweave Gloves"
        wowParent: "BrowseButton7"
        anchors.left: browseButton7.left
        anchors.leftMargin: 43
        anchors.top: browseButton7.top
        width: 167
        height: 32
    }

    Button {
        id: browseButton8
        name: "BrowseButton8"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseButton7.left
        anchors.top: browseButton7.bottom
        width: 600
        height: 37
    }

    Frame {
        id: browseButton8BuyoutFrame
        name: "BrowseButton8BuyoutFrame"
        wowParent: "BrowseButton8"
        anchors.right: browseButton8MoneyFrame.right
        anchors.top: browseButton8MoneyFrame.bottom
        anchors.topMargin: 1
        width: 185
        height: 13
    }

    Frame {
        id: browseButton8BuyoutFrameMoney
        name: "BrowseButton8BuyoutFrameMoney"
        wowParent: "BrowseButton8BuyoutFrame"
        anchors.right: browseButton8BuyoutFrame.right
        anchors.verticalCenter: browseButton8BuyoutFrame.verticalCenter
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton8BuyoutFrameMoneyCopperButton
        name: "BrowseButton8BuyoutFrameMoneyCopperButton"
        text: "63"
        wowParent: "BrowseButton8BuyoutFrameMoney"
        anchors.right: browseButton8BuyoutFrameMoney.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoney.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton8BuyoutFrameMoneyCopperButtonText
        name: "BrowseButton8BuyoutFrameMoneyCopperButtonText"
        text: "63"
        wowParent: "BrowseButton8BuyoutFrameMoneyCopperButton"
        anchors.right: browseButton8BuyoutFrameMoneyCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: browseButton8BuyoutFrameMoneyGoldButton
        name: "BrowseButton8BuyoutFrameMoneyGoldButton"
        text: "187"
        wowParent: "BrowseButton8BuyoutFrameMoney"
        anchors.right: browseButton8BuyoutFrameMoneySilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton8BuyoutFrameMoneyGoldButtonText
        name: "BrowseButton8BuyoutFrameMoneyGoldButtonText"
        text: "187"
        wowParent: "BrowseButton8BuyoutFrameMoneyGoldButton"
        anchors.right: browseButton8BuyoutFrameMoneyGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoneyGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton8BuyoutFrameMoneySilverButton
        name: "BrowseButton8BuyoutFrameMoneySilverButton"
        text: "72"
        wowParent: "BrowseButton8BuyoutFrameMoney"
        anchors.right: browseButton8BuyoutFrameMoneyCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8BuyoutFrameMoneyCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton8BuyoutFrameMoneySilverButtonText
        name: "BrowseButton8BuyoutFrameMoneySilverButtonText"
        text: "72"
        wowParent: "BrowseButton8BuyoutFrameMoneySilverButton"
        anchors.right: browseButton8BuyoutFrameMoneySilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8BuyoutFrameMoneySilverButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Frame {
        id: browseButton8BuyoutFrameText
        name: "BrowseButton8BuyoutFrameText"
        wowParent: "BrowseButton8BuyoutFrame"
        anchors.left: browseButton8BuyoutFrame.left
        anchors.top: browseButton8BuyoutFrame.top
        width: 62.7
        height: 13
    }

    Frame {
        id: browseButton8ClosingTime
        name: "BrowseButton8ClosingTime"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 267
        anchors.top: browseButton8.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton8ClosingTimeText
        name: "BrowseButton8ClosingTimeText"
        text: "Very Long"
        wowParent: "BrowseButton8ClosingTime"
        anchors.left: browseButton8ClosingTime.left
        anchors.top: browseButton8ClosingTime.top
        width: 65
        height: 32
    }

    FontString {
        id: browseButton8HighBidder
        name: "BrowseButton8HighBidder"
        text: "Bankbankstar"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 345
        anchors.top: browseButton8.top
        width: 78
        height: 32
    }

    Button {
        id: browseButton8Item
        name: "BrowseButton8Item"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.top: browseButton8.top
        width: 32
        height: 32
    }

    FontString {
        id: browseButton8Level
        name: "BrowseButton8Level"
        text: "80"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 205
        anchors.top: browseButton8.top
        width: 52
        height: 32
    }

    Frame {
        id: browseButton8MoneyFrame
        name: "BrowseButton8MoneyFrame"
        wowParent: "BrowseButton8"
        anchors.right: browseButton8.right
        anchors.rightMargin: -10
        anchors.verticalCenter: browseButton8.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 120.3
        height: 13
    }

    Button {
        id: browseButton8MoneyFrameCopperButton
        name: "BrowseButton8MoneyFrameCopperButton"
        text: "33"
        wowParent: "BrowseButton8MoneyFrame"
        anchors.right: browseButton8MoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton8MoneyFrameCopperButtonText
        name: "BrowseButton8MoneyFrameCopperButtonText"
        text: "33"
        wowParent: "BrowseButton8MoneyFrameCopperButton"
        anchors.right: browseButton8MoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrameCopperButton.verticalCenter
        width: 15.8
        height: 13.6
    }

    Button {
        id: browseButton8MoneyFrameGoldButton
        name: "BrowseButton8MoneyFrameGoldButton"
        text: "186"
        wowParent: "BrowseButton8MoneyFrame"
        anchors.right: browseButton8MoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8MoneyFrameSilverButton.verticalCenter
        width: 35.3
        height: 13
    }

    FontString {
        id: browseButton8MoneyFrameGoldButtonText
        name: "BrowseButton8MoneyFrameGoldButtonText"
        text: "186"
        wowParent: "BrowseButton8MoneyFrameGoldButton"
        anchors.right: browseButton8MoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrameGoldButton.verticalCenter
        width: 22.3
        height: 13.6
    }

    Button {
        id: browseButton8MoneyFrameSilverButton
        name: "BrowseButton8MoneyFrameSilverButton"
        text: "91"
        wowParent: "BrowseButton8MoneyFrame"
        anchors.right: browseButton8MoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseButton8MoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: browseButton8MoneyFrameSilverButtonText
        name: "BrowseButton8MoneyFrameSilverButtonText"
        text: "91"
        wowParent: "BrowseButton8MoneyFrameSilverButton"
        anchors.right: browseButton8MoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: browseButton8MoneyFrameSilverButton.verticalCenter
        width: 14.4
        height: 13.6
    }

    FontString {
        id: browseButton8Name
        name: "BrowseButton8Name"
        text: "Ebonweave Gloves"
        wowParent: "BrowseButton8"
        anchors.left: browseButton8.left
        anchors.leftMargin: 43
        anchors.top: browseButton8.top
        width: 167
        height: 32
    }

    Button {
        id: browseBuyoutButton
        name: "BrowseBuyoutButton"
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

    FontString {
        id: browseBuyoutButtonText
        name: "BrowseBuyoutButtonText"
        text: "Buyout"
        wowParent: "BrowseBuyoutButton"
        anchors.horizontalCenter: browseBuyoutButton.horizontalCenter
        anchors.verticalCenter: browseBuyoutButton.verticalCenter
        width: 38.8
        height: 10.1
    }

    Button {
        id: browseCloseButton
        name: "BrowseCloseButton"
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

    FontString {
        id: browseCloseButtonText
        name: "BrowseCloseButtonText"
        text: "Close"
        wowParent: "BrowseCloseButton"
        anchors.horizontalCenter: browseCloseButton.horizontalCenter
        anchors.verticalCenter: browseCloseButton.verticalCenter
        width: 28
        height: 10.1
    }

    Button {
        id: browseCurrentBidSort
        name: "BrowseCurrentBidSort"
        text: "Current Bid"
        wowParent: "AuctionFrameBrowse"
        anchors.left: browseHighBidderSort.right
        anchors.leftMargin: -2
        anchors.verticalCenter: browseHighBidderSort.verticalCenter
        width: 207
        height: 19
    }

    FontString {
        id: browseCurrentBidSortText
        name: "BrowseCurrentBidSortText"
        text: "Current Bid"
        wowParent: "BrowseCurrentBidSort"
        anchors.left: browseCurrentBidSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseCurrentBidSort.verticalCenter
        width: 57.5
        height: 10.1
    }

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
    }

    Button {
        id: browseDropDownButton
        name: "BrowseDropDownButton"
        wowParent: "BrowseDropDown"
        anchors.right: browseDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: browseDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: browseDropDownDiabolicField
        name: "BrowseDropDownDiabolicField"
        wowParent: "BrowseDropDown"
        anchors.left: browseDropDown.left
        anchors.verticalCenter: browseDropDown.verticalCenter
        width: 165
        height: 22
    }

    FontString {
        id: browseDropDownName
        name: "BrowseDropDownName"
        text: "Rarity"
        wowParent: "BrowseDropDown"
        anchors.left: browseDropDown.left
        anchors.leftMargin: 20
        anchors.bottom: browseDropDown.top
        width: 29.5
        height: 10.1
    }

    FontString {
        id: browseDropDownText
        name: "BrowseDropDownText"
        text: "All"
        wowParent: "BrowseDropDown"
        anchors.left: browseDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: browseDropDownDiabolicField.verticalCenter
        width: 103
        height: 10
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
    }

    FontString {
        id: browseDurationSortText
        name: "BrowseDurationSortText"
        text: "Time Left"
        wowParent: "BrowseDurationSort"
        anchors.left: browseDurationSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseDurationSort.verticalCenter
        width: 48.1
        height: 10.1
    }

    ScrollFrame {
        id: browseFilterScrollFrame
        name: "BrowseFilterScrollFrame"
        wowParent: "AuctionFrameBrowse"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -138
        anchors.top: auctionFrame.top
        anchors.topMargin: 82
        width: 160
        height: 327
    }

    Slider {
        id: browseFilterScrollFrameScrollBar
        name: "BrowseFilterScrollFrameScrollBar"
        wowParent: "BrowseFilterScrollFrame"
        style: "ScrollBar"
        anchors.left: browseFilterScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: browseFilterScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 295
    }

    Frame {
        id: browseFilterScrollFrameScrollBarDiabolicTrack
        name: "BrowseFilterScrollFrameScrollBarDiabolicTrack"
        wowParent: "BrowseFilterScrollFrameScrollBar"
        anchors.horizontalCenter: browseFilterScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: browseFilterScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 329
    }

    Button {
        id: browseFilterScrollFrameScrollBarScrollDownButton
        name: "BrowseFilterScrollFrameScrollBarScrollDownButton"
        wowParent: "BrowseFilterScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseFilterScrollFrameScrollBar.horizontalCenter
        anchors.top: browseFilterScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: browseFilterScrollFrameScrollBarScrollUpButton
        name: "BrowseFilterScrollFrameScrollBarScrollUpButton"
        wowParent: "BrowseFilterScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseFilterScrollFrameScrollBar.horizontalCenter
        anchors.bottom: browseFilterScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: browseFilterScrollFrameScrollChildFrame
        name: "BrowseFilterScrollFrameScrollChildFrame"
        wowParent: "BrowseFilterScrollFrame"
        anchors.left: browseFilterScrollFrame.left
        anchors.top: browseFilterScrollFrame.top
        width: 300
        height: 420
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
    }

    FontString {
        id: browseHighBidderSortText
        name: "BrowseHighBidderSortText"
        text: "Seller"
        wowParent: "BrowseHighBidderSort"
        anchors.left: browseHighBidderSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseHighBidderSort.verticalCenter
        width: 30.2
        height: 10.1
    }

    FontString {
        id: browseLevelHyphen
        name: "BrowseLevelHyphen"
        text: "-"
        wowParent: "BrowseMinLevel"
        anchors.left: browseMinLevel.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseMinLevel.verticalCenter
        width: 5
        height: 13.6
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
    }

    FontString {
        id: browseLevelSortText
        name: "BrowseLevelSortText"
        text: "Lvl"
        wowParent: "BrowseLevelSort"
        anchors.left: browseLevelSort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseLevelSort.verticalCenter
        width: 15.1
        height: 10.1
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
        id: browseMaxLevel
        name: "BrowseMaxLevel"
        wowParent: "AuctionFrameBrowse"
        style: "EditBox"
        anchors.left: browseLevelHyphen.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseLevelHyphen.verticalCenter
        width: 25
        height: 16
    }

    Frame {
        id: browseMaxLevelDiabolicField
        name: "BrowseMaxLevelDiabolicField"
        wowParent: "BrowseMaxLevel"
        anchors.left: browseMaxLevel.left
        anchors.leftMargin: -8
        anchors.verticalCenter: browseMaxLevel.verticalCenter
        width: 41
        height: 22
    }

    EditBox {
        id: browseMinLevel
        name: "BrowseMinLevel"
        wowParent: "AuctionFrameBrowse"
        style: "EditBox"
        anchors.left: browseLevelText.right
        anchors.leftMargin: 20
        anchors.verticalCenter: browseLevelText.verticalCenter
        width: 25
        height: 16
    }

    Frame {
        id: browseMinLevelDiabolicField
        name: "BrowseMinLevelDiabolicField"
        wowParent: "BrowseMinLevel"
        anchors.left: browseMinLevel.left
        anchors.leftMargin: -8
        anchors.verticalCenter: browseMinLevel.verticalCenter
        width: 41
        height: 22
    }

    EditBox {
        id: browseName
        name: "BrowseName"
        wowParent: "AuctionFrameBrowse"
        style: "EditBox"
        anchors.left: auctionFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: auctionFrameDiabolicBand.verticalCenter
        width: 140
        height: 16
    }

    Frame {
        id: browseNameDiabolicField
        name: "BrowseNameDiabolicField"
        wowParent: "BrowseName"
        anchors.left: browseName.left
        anchors.leftMargin: -8
        anchors.verticalCenter: browseName.verticalCenter
        width: 156
        height: 22
    }

    FontString {
        id: browseNameText
        name: "BrowseNameText"
        text: "Name"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 80
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 41
        width: 30.9
        height: 10.1
    }

    Button {
        id: browseNextPageButton
        name: "BrowseNextPageButton"
        wowParent: "AuctionFrameBrowse"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -840
        anchors.verticalCenter: auctionFrame.top
        anchors.verticalCenterOffset: 58
        width: 24
        height: 24
    }

    FontString {
        id: browseNoResultsText
        name: "BrowseNoResultsText"
        text: "Choose search criteria and press \"Search\""
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: auctionFrame.left
        anchors.horizontalCenterOffset: 509
        anchors.top: auctionFrame.top
        anchors.topMargin: 118
        width: 252.1
        height: 12.2
    }

    Button {
        id: browsePrevPageButton
        name: "BrowsePrevPageButton"
        wowParent: "AuctionFrameBrowse"
        anchors.right: browseNextPageButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: browseNextPageButton.verticalCenter
        width: 24
        height: 24
    }

    Button {
        id: browseQualitySort
        name: "BrowseQualitySort"
        text: "Rarity"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 187
        anchors.top: auctionFrame.top
        anchors.topMargin: 82
        width: 214
        height: 19
    }

    FontString {
        id: browseQualitySortText
        name: "BrowseQualitySortText"
        text: "Rarity"
        wowParent: "BrowseQualitySort"
        anchors.left: browseQualitySort.left
        anchors.leftMargin: 8
        anchors.verticalCenter: browseQualitySort.verticalCenter
        width: 29.5
        height: 10.1
    }

    Button {
        id: browseResetButton
        name: "BrowseResetButton"
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

    FontString {
        id: browseResetButtonText
        name: "BrowseResetButtonText"
        text: "Reset"
        wowParent: "BrowseResetButton"
        anchors.horizontalCenter: browseResetButton.horizontalCenter
        anchors.verticalCenter: browseResetButton.verticalCenter
        width: 30.2
        height: 10.1
    }

    ScrollFrame {
        id: browseScrollFrame
        name: "BrowseScrollFrame"
        wowParent: "AuctionFrameBrowse"
        anchors.right: auctionFrame.left
        anchors.rightMargin: -798
        anchors.top: auctionFrame.top
        anchors.topMargin: 103
        width: 465
        height: 306
    }

    Slider {
        id: browseScrollFrameScrollBar
        name: "BrowseScrollFrameScrollBar"
        wowParent: "BrowseScrollFrame"
        style: "ScrollBar"
        anchors.left: browseScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: browseScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 274
    }

    Frame {
        id: browseScrollFrameScrollBarDiabolicTrack
        name: "BrowseScrollFrameScrollBarDiabolicTrack"
        wowParent: "BrowseScrollFrameScrollBar"
        anchors.horizontalCenter: browseScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: browseScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 308
    }

    Button {
        id: browseScrollFrameScrollBarScrollDownButton
        name: "BrowseScrollFrameScrollBarScrollDownButton"
        wowParent: "BrowseScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseScrollFrameScrollBar.horizontalCenter
        anchors.top: browseScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: browseScrollFrameScrollBarScrollUpButton
        name: "BrowseScrollFrameScrollBarScrollUpButton"
        wowParent: "BrowseScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: browseScrollFrameScrollBar.horizontalCenter
        anchors.bottom: browseScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: browseScrollFrameScrollChildFrame
        name: "BrowseScrollFrameScrollChildFrame"
        wowParent: "BrowseScrollFrame"
        anchors.left: browseScrollFrame.left
        anchors.top: browseScrollFrame.top
        width: 300
        height: 1887
    }

    Button {
        id: browseSearchButton
        name: "BrowseSearchButton"
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

    FontString {
        id: browseSearchButtonText
        name: "BrowseSearchButtonText"
        text: "Search"
        wowParent: "BrowseSearchButton"
        anchors.horizontalCenter: browseSearchButton.horizontalCenter
        anchors.verticalCenter: browseSearchButton.verticalCenter
        width: 36.6
        height: 10.1
    }

    FontString {
        id: browseSearchCountText
        name: "BrowseSearchCountText"
        text: "Items 1 - 18  ( 118 total )"
        wowParent: "AuctionFrameBrowse"
        anchors.left: auctionFrame.left
        anchors.leftMargin: 182
        anchors.verticalCenter: auctionFrame.top
        anchors.verticalCenterOffset: 58
        width: 121.4
        height: 10.1
    }

    FontString {
        id: browseTitle
        name: "BrowseTitle"
        text: "Browse Auctions"
        wowParent: "AuctionFrameBrowse"
        anchors.horizontalCenter: auctionFrameBrowse.horizontalCenter
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 18
        width: 102.7
        height: 12.2
    }

    Frame {
        id: buyoutPrice
        name: "BuyoutPrice"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 19
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 127
        width: 176
        height: 18
    }

    EditBox {
        id: buyoutPriceCopper
        name: "BuyoutPriceCopper"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: buyoutPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    EditBox {
        id: buyoutPriceGold
        name: "BuyoutPriceGold"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPrice.left
        anchors.top: buyoutPrice.top
        width: 58
        height: 20
    }

    EditBox {
        id: buyoutPriceSilver
        name: "BuyoutPriceSilver"
        wowParent: "BuyoutPrice"
        anchors.left: buyoutPriceGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: buyoutPriceGold.verticalCenter
        width: 30
        height: 20
    }

    Frame {
        id: durationDropDown
        name: "DurationDropDown"
        wowParent: "AuctionFrameAuctions"
        style: "DropDown"
        anchors.right: auctionFrameAuctions.left
        anchors.rightMargin: -201
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 91
        width: 130
        height: 32
    }

    Button {
        id: durationDropDownButton
        name: "DurationDropDownButton"
        wowParent: "DurationDropDown"
        anchors.right: durationDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: durationDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: durationDropDownDiabolicField
        name: "DurationDropDownDiabolicField"
        wowParent: "DurationDropDown"
        anchors.left: durationDropDown.left
        anchors.verticalCenter: durationDropDown.verticalCenter
        width: 130
        height: 22
    }

    FontString {
        id: durationDropDownText
        name: "DurationDropDownText"
        text: "24 Hours"
        wowParent: "DurationDropDown"
        anchors.left: durationDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: durationDropDownDiabolicField.verticalCenter
        width: 68
        height: 10
    }

    CheckButton {
        id: isUsableCheckButton
        name: "IsUsableCheckButton"
        wowParent: "AuctionFrameBrowse"
        style: "CheckBox"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 524.8
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 4
        width: 16
        height: 16
    }

    FontString {
        id: isUsableCheckButtonText
        name: "IsUsableCheckButtonText"
        text: "Usable Items"
        wowParent: "IsUsableCheckButton"
        anchors.left: isUsableCheckButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: isUsableCheckButton.verticalCenter
        width: 70.4
        height: 13.6
    }

    Frame {
        id: priceDropDown
        name: "PriceDropDown"
        wowParent: "AuctionFrameAuctions"
        style: "DropDown"
        anchors.right: auctionFrameAuctions.left
        anchors.rightMargin: -201
        anchors.top: auctionFrameAuctions.top
        anchors.topMargin: 213
        width: 130
        height: 32
    }

    Button {
        id: priceDropDownButton
        name: "PriceDropDownButton"
        wowParent: "PriceDropDown"
        anchors.right: priceDropDownDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: priceDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: priceDropDownDiabolicField
        name: "PriceDropDownDiabolicField"
        wowParent: "PriceDropDown"
        anchors.left: priceDropDown.left
        anchors.verticalCenter: priceDropDown.verticalCenter
        width: 130
        height: 22
    }

    FontString {
        id: priceDropDownText
        name: "PriceDropDownText"
        text: "per stack"
        wowParent: "PriceDropDown"
        anchors.left: priceDropDownDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: priceDropDownDiabolicField.verticalCenter
        width: 68
        height: 10
    }

    CheckButton {
        id: showOnPlayerCheckButton
        name: "ShowOnPlayerCheckButton"
        wowParent: "AuctionFrameBrowse"
        style: "CheckBox"
        anchors.left: auctionFrameBrowse.left
        anchors.leftMargin: 524.8
        anchors.top: auctionFrameBrowse.top
        anchors.topMargin: 20
        width: 16
        height: 16
    }

    FontString {
        id: showOnPlayerCheckButtonText
        name: "ShowOnPlayerCheckButtonText"
        text: "Display on Character"
        wowParent: "ShowOnPlayerCheckButton"
        anchors.left: showOnPlayerCheckButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: showOnPlayerCheckButton.verticalCenter
        width: 112.1
        height: 13.6
    }

    Frame {
        id: startPrice
        name: "StartPrice"
        wowParent: "AuctionFrameAuctions"
        anchors.left: auctionFrameAuctions.left
        anchors.leftMargin: 19
        anchors.bottom: auctionFrameAuctions.bottom
        anchors.bottomMargin: 172
        width: 176
        height: 18
    }

    EditBox {
        id: startPriceCopper
        name: "StartPriceCopper"
        wowParent: "StartPrice"
        anchors.left: startPriceSilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: startPriceSilver.verticalCenter
        width: 30
        height: 20
    }

    EditBox {
        id: startPriceGold
        name: "StartPriceGold"
        wowParent: "StartPrice"
        anchors.left: startPrice.left
        anchors.top: startPrice.top
        width: 58
        height: 20
    }

    EditBox {
        id: startPriceSilver
        name: "StartPriceSilver"
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
