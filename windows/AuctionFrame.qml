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
        id: auctionatorHEntry1
        name: "AuctionatorHEntry1"
        wowParent: "Atr_Hlist"
        anchors.left: atr_Hlist.left
        anchors.top: atr_Hlist.top
        anchors.topMargin: 5
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
    Ghost { id: auctionsButton2BuyoutFrameMoneySilverButton; name: "AuctionsButton2BuyoutFrameMoneySilverButton"; x: 729; y: 124; width: 32; height: 13 }
    Ghost { id: auctionsButton2Item; name: "AuctionsButton2Item"; x: 224; y: 108; width: 32; height: 32 }
    Ghost { id: auctionsButton2MoneyFrameSilverButton; name: "AuctionsButton2MoneyFrameSilverButton"; x: 729; y: 110; width: 32; height: 13 }
    Ghost { id: auctionsButton3BuyoutFrameMoneySilverButton; name: "AuctionsButton3BuyoutFrameMoneySilverButton"; x: 729; y: 161; width: 32; height: 13 }
    Ghost { id: auctionsButton3Item; name: "AuctionsButton3Item"; x: 224; y: 145; width: 32; height: 32 }
    Ghost { id: auctionsButton3MoneyFrameSilverButton; name: "AuctionsButton3MoneyFrameSilverButton"; x: 729; y: 147; width: 32; height: 13 }
    Ghost { id: auctionsButton7BuyoutFrameMoneySilverButton; name: "AuctionsButton7BuyoutFrameMoneySilverButton"; x: 729; y: 309; width: 32; height: 13 }
    Ghost { id: auctionsButton7Item; name: "AuctionsButton7Item"; x: 224; y: 293; width: 32; height: 32 }
    Ghost { id: auctionsButton7MoneyFrameSilverButton; name: "AuctionsButton7MoneyFrameSilverButton"; x: 729; y: 295; width: 32; height: 13 }
    Ghost { id: auctionsButton8BuyoutFrameMoneySilverButton; name: "AuctionsButton8BuyoutFrameMoneySilverButton"; x: 729; y: 346; width: 32; height: 13 }
    Ghost { id: auctionsButton8Item; name: "AuctionsButton8Item"; x: 224; y: 330; width: 32; height: 32 }
    Ghost { id: auctionsButton8MoneyFrameSilverButton; name: "AuctionsButton8MoneyFrameSilverButton"; x: 729; y: 332; width: 32; height: 13 }
    Ghost { id: auctionsDepositMoneyFrameCopperButton; name: "AuctionsDepositMoneyFrameCopperButton"; x: 119.5; y: 368.1; width: 0; height: 0 }
    Ghost { id: browseButton2Item; name: "BrowseButton2Item"; x: 196.7; y: 137.1; width: 32; height: 32 }
    Ghost { id: browseButton3Item; name: "BrowseButton3Item"; x: 196.7; y: 174.1; width: 32; height: 32 }
    Ghost { id: browseButton4Item; name: "BrowseButton4Item"; x: 196.7; y: 211.1; width: 32; height: 32 }
    Ghost { id: browseButton5Item; name: "BrowseButton5Item"; x: 196.7; y: 248.1; width: 32; height: 32 }
    Ghost { id: browseButton6Item; name: "BrowseButton6Item"; x: 196.7; y: 285.1; width: 32; height: 32 }
    Ghost { id: browseButton7Item; name: "BrowseButton7Item"; x: 196.7; y: 322.1; width: 32; height: 32 }
}
