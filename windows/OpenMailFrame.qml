// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: openMailFrame
    name: "OpenMailFrame"
    width: 384
    height: 512

    FontString {
        id: openMailBodyText
        name: "OpenMailBodyText"
        wowParent: "OpenMailScrollChildFrame"
        anchors.left: openMailScrollChildFrame.left
        anchors.leftMargin: 10
        anchors.top: openMailScrollChildFrame.top
        anchors.topMargin: 10
        width: 276
        height: 240.2
    }

    Button {
        id: openMailCancelButton
        name: "OpenMailCancelButton"
        text: "Close"
        wowParent: "OpenMailFrame"
        style: "Button"
        pin: "all"
        anchors.left: openMailDeleteButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: openMailDeleteButton.verticalCenter
        width: 78
        height: 22
    }

    FontString {
        id: openMailCancelButtonText
        name: "OpenMailCancelButtonText"
        text: "Close"
        wowParent: "OpenMailCancelButton"
        anchors.horizontalCenter: openMailCancelButton.horizontalCenter
        anchors.verticalCenter: openMailCancelButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Button {
        id: openMailCloseButton
        name: "OpenMailCloseButton"
        wowParent: "OpenMailFrame"
        style: "CloseButton"
        anchors.horizontalCenter: openMailFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: openMailFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Button {
        id: openMailDeleteButton
        name: "OpenMailDeleteButton"
        text: "Delete"
        wowParent: "OpenMailFrame"
        style: "Button"
        pin: "all"
        anchors.left: openMailReplyButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: openMailReplyButton.verticalCenter
        width: 78
        height: 22
    }

    FontString {
        id: openMailDeleteButtonText
        name: "OpenMailDeleteButtonText"
        text: "Delete"
        wowParent: "OpenMailDeleteButton"
        anchors.horizontalCenter: openMailDeleteButton.horizontalCenter
        anchors.verticalCenter: openMailDeleteButton.verticalCenter
        width: 48.2
        height: 11.9
    }

    Frame {
        id: openMailDepositMoneyFrame
        name: "OpenMailDepositMoneyFrame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceDeposit.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceDeposit.verticalCenter
        width: 72.3
        height: 13
    }

    Button {
        id: openMailDepositMoneyFrameCopperButton
        name: "OpenMailDepositMoneyFrameCopperButton"
        text: "0"
        wowParent: "OpenMailDepositMoneyFrame"
        anchors.right: openMailDepositMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailDepositMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: openMailDepositMoneyFrameCopperButtonText
        name: "OpenMailDepositMoneyFrameCopperButtonText"
        text: "0"
        wowParent: "OpenMailDepositMoneyFrameCopperButton"
        anchors.right: openMailDepositMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailDepositMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Button {
        id: openMailDepositMoneyFrameSilverButton
        name: "OpenMailDepositMoneyFrameSilverButton"
        text: "6"
        wowParent: "OpenMailDepositMoneyFrame"
        anchors.right: openMailDepositMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailDepositMoneyFrameCopperButton.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: openMailDepositMoneyFrameSilverButtonText
        name: "OpenMailDepositMoneyFrameSilverButtonText"
        text: "6"
        wowParent: "OpenMailDepositMoneyFrameSilverButton"
        anchors.right: openMailDepositMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailDepositMoneyFrameSilverButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Frame {
        id: openMailFrameDiabolic
        name: "OpenMailFrameDiabolic"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: -16
        anchors.top: openMailFrame.top
        anchors.topMargin: -68
        width: 400
        height: 540
    }

    Frame {
        id: openMailFrameDiabolicBand
        name: "OpenMailFrameDiabolicBand"
        wowParent: "OpenMailFrameDiabolic"
        anchors.left: openMailFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: openMailFrameDiabolic.top
        anchors.topMargin: 24
        width: 352
        height: 40
    }

    Frame {
        id: openMailFrameDiabolicBorder
        name: "OpenMailFrameDiabolicBorder"
        wowParent: "OpenMailFrameDiabolic"
        anchors.left: openMailFrameDiabolic.left
        anchors.top: openMailFrameDiabolic.top
        width: 400
        height: 540
    }

    Frame {
        id: openMailFrameDiabolicFoot
        name: "OpenMailFrameDiabolicFoot"
        wowParent: "OpenMailFrameDiabolic"
        anchors.horizontalCenter: openMailCancelButton.horizontalCenter
        anchors.horizontalCenterOffset: -122.9
        anchors.top: openMailCancelButton.top
        anchors.topMargin: -6
        width: 354
        height: 45
    }

    Frame {
        id: openMailFrameDiabolicSocket
        name: "OpenMailFrameDiabolicSocket"
        wowParent: "OpenMailFrameDiabolic"
        anchors.right: openMailFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: openMailFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: openMailFrameDiabolicTitlePlate
        name: "OpenMailFrameDiabolicTitlePlate"
        wowParent: "OpenMailFrameDiabolic"
        anchors.horizontalCenter: openMailFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: openMailFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Frame {
        id: openMailHouseCutMoneyFrame
        name: "OpenMailHouseCutMoneyFrame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceHouseCut.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceHouseCut.verticalCenter
        width: 70.7
        height: 13
    }

    Button {
        id: openMailHouseCutMoneyFrameCopperButton
        name: "OpenMailHouseCutMoneyFrameCopperButton"
        text: "72"
        wowParent: "OpenMailHouseCutMoneyFrame"
        anchors.right: openMailHouseCutMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailHouseCutMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: openMailHouseCutMoneyFrameCopperButtonText
        name: "OpenMailHouseCutMoneyFrameCopperButtonText"
        text: "72"
        wowParent: "OpenMailHouseCutMoneyFrameCopperButton"
        anchors.right: openMailHouseCutMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailHouseCutMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: openMailHouseCutMoneyFrameSilverButton
        name: "OpenMailHouseCutMoneyFrameSilverButton"
        text: "1"
        wowParent: "OpenMailHouseCutMoneyFrame"
        anchors.right: openMailHouseCutMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailHouseCutMoneyFrameCopperButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: openMailHouseCutMoneyFrameSilverButtonText
        name: "OpenMailHouseCutMoneyFrameSilverButtonText"
        text: "1"
        wowParent: "OpenMailHouseCutMoneyFrameSilverButton"
        anchors.right: openMailHouseCutMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailHouseCutMoneyFrameSilverButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    FontString {
        id: openMailInvoiceAmountReceived
        name: "OpenMailInvoiceAmountReceived"
        text: "Amount Received:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceHouseCut.right
        anchors.top: openMailInvoiceHouseCut.bottom
        anchors.topMargin: 18
        width: 107.5
        height: 11.9
    }

    FontString {
        id: openMailInvoiceBuyMode
        name: "OpenMailInvoiceBuyMode"
        text: "(Buyout)"
        wowParent: "OpenMailInvoiceFrame"
        anchors.left: openMailInvoicePurchaser.right
        anchors.leftMargin: 5
        anchors.verticalCenter: openMailInvoicePurchaser.verticalCenter
        width: 45
        height: 10.3
    }

    FontString {
        id: openMailInvoiceDeposit
        name: "OpenMailInvoiceDeposit"
        text: "Deposit:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceSalePrice.right
        anchors.top: openMailInvoiceSalePrice.bottom
        anchors.topMargin: 13
        width: 49.8
        height: 11.9
    }

    Frame {
        id: openMailInvoiceFrame
        name: "OpenMailInvoiceFrame"
        wowParent: "OpenMailScrollChildFrame"
        anchors.left: openMailScrollChildFrame.left
        anchors.top: openMailScrollChildFrame.top
        width: 296
        height: 314.7
    }

    FontString {
        id: openMailInvoiceHouseCut
        name: "OpenMailInvoiceHouseCut"
        text: "Auction House Cut:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceDeposit.right
        anchors.top: openMailInvoiceDeposit.bottom
        anchors.topMargin: 13
        width: 113.8
        height: 11.9
    }

    FontString {
        id: openMailInvoiceItemLabel
        name: "OpenMailInvoiceItemLabel"
        text: "Item Sold: Runecloth"
        wowParent: "OpenMailInvoiceFrame"
        anchors.left: openMailInvoiceFrame.left
        anchors.leftMargin: 30
        anchors.top: openMailInvoiceFrame.top
        anchors.topMargin: 35
        width: 240
        height: 11.9
    }

    FontString {
        id: openMailInvoicePurchaser
        name: "OpenMailInvoicePurchaser"
        text: "Purchased By: Gruzurpator"
        wowParent: "OpenMailInvoiceFrame"
        anchors.left: openMailInvoiceItemLabel.left
        anchors.top: openMailInvoiceItemLabel.bottom
        anchors.topMargin: 5
        width: 158
        height: 11.9
    }

    FontString {
        id: openMailInvoiceSalePrice
        name: "OpenMailInvoiceSalePrice"
        text: "Sale Price:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoicePurchaser.left
        anchors.rightMargin: -125
        anchors.top: openMailInvoicePurchaser.bottom
        anchors.topMargin: 26
        width: 59.3
        height: 11.9
    }

    Button {
        id: openMailLetterButton
        name: "OpenMailLetterButton"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 161.5
        anchors.top: openMailFrame.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Button {
        id: openMailMoneyButton
        name: "OpenMailMoneyButton"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 161.5
        anchors.top: openMailFrame.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Button {
        id: openMailReplyButton
        name: "OpenMailReplyButton"
        text: "Reply"
        wowParent: "OpenMailFrame"
        style: "Button"
        pin: "all"
        anchors.left: openMailFrameDiabolic.left
        anchors.leftMargin: 117
        anchors.bottom: openMailFrameDiabolic.bottom
        anchors.bottomMargin: 40
        width: 78
        height: 22
    }

    FontString {
        id: openMailReplyButtonText
        name: "OpenMailReplyButtonText"
        text: "Reply"
        wowParent: "OpenMailReplyButton"
        anchors.horizontalCenter: openMailReplyButton.horizontalCenter
        anchors.verticalCenter: openMailReplyButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Frame {
        id: openMailSalePriceMoneyFrame
        name: "OpenMailSalePriceMoneyFrame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceSalePrice.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceSalePrice.verticalCenter
        width: 106.7
        height: 13
    }

    Button {
        id: openMailSalePriceMoneyFrameCopperButton
        name: "OpenMailSalePriceMoneyFrameCopperButton"
        text: "0"
        wowParent: "OpenMailSalePriceMoneyFrame"
        anchors.right: openMailSalePriceMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: openMailSalePriceMoneyFrameCopperButtonText
        name: "OpenMailSalePriceMoneyFrameCopperButtonText"
        text: "0"
        wowParent: "OpenMailSalePriceMoneyFrameCopperButton"
        anchors.right: openMailSalePriceMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Button {
        id: openMailSalePriceMoneyFrameGoldButton
        name: "OpenMailSalePriceMoneyFrameGoldButton"
        text: "1"
        wowParent: "OpenMailSalePriceMoneyFrame"
        anchors.right: openMailSalePriceMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailSalePriceMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: openMailSalePriceMoneyFrameGoldButtonText
        name: "OpenMailSalePriceMoneyFrameGoldButtonText"
        text: "1"
        wowParent: "OpenMailSalePriceMoneyFrameGoldButton"
        anchors.right: openMailSalePriceMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Button {
        id: openMailSalePriceMoneyFrameSilverButton
        name: "OpenMailSalePriceMoneyFrameSilverButton"
        text: "15"
        wowParent: "OpenMailSalePriceMoneyFrame"
        anchors.right: openMailSalePriceMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailSalePriceMoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: openMailSalePriceMoneyFrameSilverButtonText
        name: "OpenMailSalePriceMoneyFrameSilverButtonText"
        text: "15"
        wowParent: "OpenMailSalePriceMoneyFrameSilverButton"
        anchors.right: openMailSalePriceMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Frame {
        id: openMailScrollChildFrame
        name: "OpenMailScrollChildFrame"
        wowParent: "OpenMailScrollFrame"
        anchors.left: openMailScrollFrame.left
        anchors.top: openMailScrollFrame.top
        width: 296
        height: 314.7
    }

    ScrollFrame {
        id: openMailScrollFrame
        name: "OpenMailScrollFrame"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 21
        anchors.top: openMailFrame.top
        anchors.topMargin: 13
        width: 296
        height: 314.7
    }

    Frame {
        id: openMailScrollFrameDiabolicPanel
        name: "OpenMailScrollFrameDiabolicPanel"
        wowParent: "OpenMailFrame"
        anchors.left: openMailScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 326.7
    }

    Frame {
        id: openMailScrollFrameDiabolicParchment
        name: "OpenMailScrollFrameDiabolicParchment"
        wowParent: "OpenMailScrollFrame"
        anchors.left: openMailScrollFrame.left
        anchors.leftMargin: -4
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: -4
        width: 304
        height: 322.7
    }

    Slider {
        id: openMailScrollFrameScrollBar
        name: "OpenMailScrollFrameScrollBar"
        wowParent: "OpenMailScrollFrame"
        style: "ScrollBar"
        anchors.left: openMailScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 282.7
    }

    Frame {
        id: openMailScrollFrameScrollBarDiabolicTrack
        name: "OpenMailScrollFrameScrollBarDiabolicTrack"
        wowParent: "OpenMailScrollFrameScrollBar"
        anchors.horizontalCenter: openMailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: openMailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 316.7
    }

    Button {
        id: openMailScrollFrameScrollBarScrollDownButton
        name: "OpenMailScrollFrameScrollBarScrollDownButton"
        wowParent: "OpenMailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: openMailScrollFrameScrollBar.horizontalCenter
        anchors.top: openMailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: openMailScrollFrameScrollBarScrollUpButton
        name: "OpenMailScrollFrameScrollBarScrollUpButton"
        wowParent: "OpenMailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: openMailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: openMailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    FontString {
        id: openMailSender
        name: "OpenMailSender"
        text: "Brew of the Month Club"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.left: openMailSenderLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: openMailSenderLabel.verticalCenter
        width: 242.4
        height: 14.2
    }

    FontString {
        id: openMailSenderLabel
        name: "OpenMailSenderLabel"
        text: "From:"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.right: openMailFrameDiabolicBand.left
        anchors.rightMargin: -56.6
        anchors.bottom: openMailFrameDiabolicBand.verticalCenter
        width: 33.2
        height: 16
    }

    FontString {
        id: openMailSubject
        name: "OpenMailSubject"
        text: "Fun For You And Your Friends"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.left: openMailSubjectLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: openMailSubjectLabel.verticalCenter
        width: 242.4
        height: 16
    }

    FontString {
        id: openMailSubjectLabel
        name: "OpenMailSubjectLabel"
        text: "Subject:"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.right: openMailFrameDiabolicBand.left
        anchors.rightMargin: -56.6
        anchors.top: openMailFrameDiabolicBand.verticalCenter
        width: 46.6
        height: 16
    }

    FontString {
        id: openMailTitleText
        name: "OpenMailTitleText"
        text: "Open Mail"
        wowParent: "OpenMailFrameDiabolicTitlePlate"
        anchors.horizontalCenter: openMailFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: openMailFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 88.5
        height: 14.2
    }

    Frame {
        id: openMailTransactionAmountMoneyFrame
        name: "OpenMailTransactionAmountMoneyFrame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceAmountReceived.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceAmountReceived.verticalCenter
        width: 106.7
        height: 13
    }

    Button {
        id: openMailTransactionAmountMoneyFrameCopperButton
        name: "OpenMailTransactionAmountMoneyFrameCopperButton"
        text: "28"
        wowParent: "OpenMailTransactionAmountMoneyFrame"
        anchors.right: openMailTransactionAmountMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: openMailTransactionAmountMoneyFrameCopperButtonText
        name: "OpenMailTransactionAmountMoneyFrameCopperButtonText"
        text: "28"
        wowParent: "OpenMailTransactionAmountMoneyFrameCopperButton"
        anchors.right: openMailTransactionAmountMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: openMailTransactionAmountMoneyFrameGoldButton
        name: "OpenMailTransactionAmountMoneyFrameGoldButton"
        text: "1"
        wowParent: "OpenMailTransactionAmountMoneyFrame"
        anchors.right: openMailTransactionAmountMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    FontString {
        id: openMailTransactionAmountMoneyFrameGoldButtonText
        name: "OpenMailTransactionAmountMoneyFrameGoldButtonText"
        text: "1"
        wowParent: "OpenMailTransactionAmountMoneyFrameGoldButton"
        anchors.right: openMailTransactionAmountMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Button {
        id: openMailTransactionAmountMoneyFrameSilverButton
        name: "OpenMailTransactionAmountMoneyFrameSilverButton"
        text: "19"
        wowParent: "OpenMailTransactionAmountMoneyFrame"
        anchors.right: openMailTransactionAmountMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    FontString {
        id: openMailTransactionAmountMoneyFrameSilverButtonText
        name: "OpenMailTransactionAmountMoneyFrameSilverButtonText"
        text: "19"
        wowParent: "OpenMailTransactionAmountMoneyFrameSilverButton"
        anchors.right: openMailTransactionAmountMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    WowRow {
        name: "OpenMailButtons"
        parts: ["OpenMailReplyButton", "OpenMailDeleteButton", "OpenMailCancelButton"]
        fit: "equal"
        anchors.left: openMailFrameDiabolic.left
        anchors.leftMargin: 117
        anchors.right: openMailFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: openMailFrameDiabolic.bottom
        anchors.bottomMargin: 40
    }

}
