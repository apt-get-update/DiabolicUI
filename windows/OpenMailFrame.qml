// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: openMailFrame
    name: "OpenMailFrame"
    width: 384
    height: 512

    Part {
        id: openMailBodyText
        name: "OpenMailBodyText"
        kind: "FontString"
        text: "These items were recovered after the server issue on October 14. Sorry for the trouble."
        wowParent: "OpenMailScrollChildFrame"
        anchors.left: openMailScrollChildFrame.left
        anchors.leftMargin: 10
        anchors.top: openMailScrollChildFrame.top
        anchors.topMargin: 10
        width: 276
        height: 60
    }

    Part {
        id: openMailCancelButton
        name: "OpenMailCancelButton"
        kind: "Button"
        text: "Close"
        wowParent: "OpenMailFrame"
        style: "Button"
        anchors.right: openMailFrame.right
        anchors.rightMargin: 39
        anchors.bottom: openMailFrame.bottom
        anchors.bottomMargin: 80
        width: 76.1
        height: 22
    }

    Part {
        id: openMailCancelButtonText
        name: "OpenMailCancelButtonText"
        kind: "FontString"
        text: "Close"
        wowParent: "OpenMailCancelButton"
        anchors.horizontalCenter: openMailCancelButton.horizontalCenter
        anchors.verticalCenter: openMailCancelButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Part {
        id: openMailCloseButton
        name: "OpenMailCloseButton"
        kind: "Button"
        wowParent: "OpenMailFrame"
        style: "CloseButton"
        anchors.horizontalCenter: openMailFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: openMailFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: openMailDeleteButton
        name: "OpenMailDeleteButton"
        kind: "Button"
        text: "Delete"
        wowParent: "OpenMailFrame"
        style: "Button"
        anchors.right: openMailFrame.right
        anchors.rightMargin: 121.1
        anchors.bottom: openMailFrame.bottom
        anchors.bottomMargin: 80
        width: 78
        height: 22
    }

    Part {
        id: openMailDeleteButtonText
        name: "OpenMailDeleteButtonText"
        kind: "FontString"
        text: "Delete"
        wowParent: "OpenMailDeleteButton"
        anchors.horizontalCenter: openMailDeleteButton.horizontalCenter
        anchors.verticalCenter: openMailDeleteButton.verticalCenter
        width: 48.2
        height: 11.9
    }

    Part {
        id: openMailDepositMoneyFrame
        name: "OpenMailDepositMoneyFrame"
        kind: "Frame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceDeposit.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceDeposit.verticalCenter
        width: 72.3
        height: 13
    }

    Part {
        id: openMailDepositMoneyFrameCopperButton
        name: "OpenMailDepositMoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "OpenMailDepositMoneyFrame"
        anchors.right: openMailDepositMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailDepositMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: openMailDepositMoneyFrameCopperButtonText
        name: "OpenMailDepositMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "OpenMailDepositMoneyFrameCopperButton"
        anchors.right: openMailDepositMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailDepositMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: openMailDepositMoneyFrameSilverButton
        name: "OpenMailDepositMoneyFrameSilverButton"
        kind: "Button"
        text: "6"
        wowParent: "OpenMailDepositMoneyFrame"
        anchors.right: openMailDepositMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailDepositMoneyFrameCopperButton.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: openMailDepositMoneyFrameSilverButtonText
        name: "OpenMailDepositMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "6"
        wowParent: "OpenMailDepositMoneyFrameSilverButton"
        anchors.right: openMailDepositMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailDepositMoneyFrameSilverButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: openMailFrameDiabolic
        name: "OpenMailFrameDiabolic"
        kind: "Frame"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: -16
        anchors.top: openMailFrame.top
        anchors.topMargin: -68
        width: 400
        height: 540
    }

    Part {
        id: openMailFrameDiabolicBand
        name: "OpenMailFrameDiabolicBand"
        kind: "Frame"
        wowParent: "OpenMailFrameDiabolic"
        anchors.left: openMailFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: openMailFrameDiabolic.top
        anchors.topMargin: 24
        width: 352
        height: 40
    }

    Part {
        id: openMailFrameDiabolicBorder
        name: "OpenMailFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "OpenMailFrameDiabolic"
        anchors.left: openMailFrameDiabolic.left
        anchors.top: openMailFrameDiabolic.top
        width: 400
        height: 540
    }

    Part {
        id: openMailFrameDiabolicFoot
        name: "OpenMailFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "OpenMailFrameDiabolic"
        anchors.horizontalCenter: openMailCancelButton.horizontalCenter
        anchors.horizontalCenterOffset: -122.9
        anchors.top: openMailCancelButton.top
        anchors.topMargin: -6
        width: 354
        height: 45
    }

    Part {
        id: openMailFrameDiabolicSocket
        name: "OpenMailFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "OpenMailFrameDiabolic"
        anchors.right: openMailFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: openMailFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: openMailFrameDiabolicTitlePlate
        name: "OpenMailFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "OpenMailFrameDiabolic"
        anchors.horizontalCenter: openMailFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: openMailFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: openMailHouseCutMoneyFrame
        name: "OpenMailHouseCutMoneyFrame"
        kind: "Frame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceHouseCut.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceHouseCut.verticalCenter
        width: 70.7
        height: 13
    }

    Part {
        id: openMailHouseCutMoneyFrameCopperButton
        name: "OpenMailHouseCutMoneyFrameCopperButton"
        kind: "Button"
        text: "72"
        wowParent: "OpenMailHouseCutMoneyFrame"
        anchors.right: openMailHouseCutMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailHouseCutMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: openMailHouseCutMoneyFrameCopperButtonText
        name: "OpenMailHouseCutMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "72"
        wowParent: "OpenMailHouseCutMoneyFrameCopperButton"
        anchors.right: openMailHouseCutMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailHouseCutMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: openMailHouseCutMoneyFrameSilverButton
        name: "OpenMailHouseCutMoneyFrameSilverButton"
        kind: "Button"
        text: "1"
        wowParent: "OpenMailHouseCutMoneyFrame"
        anchors.right: openMailHouseCutMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailHouseCutMoneyFrameCopperButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: openMailHouseCutMoneyFrameSilverButtonText
        name: "OpenMailHouseCutMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "OpenMailHouseCutMoneyFrameSilverButton"
        anchors.right: openMailHouseCutMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailHouseCutMoneyFrameSilverButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Part {
        id: openMailInvoiceAmountReceived
        name: "OpenMailInvoiceAmountReceived"
        kind: "FontString"
        text: "Amount Received:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceHouseCut.right
        anchors.top: openMailInvoiceHouseCut.bottom
        anchors.topMargin: 18
        width: 107.5
        height: 11.9
    }

    Part {
        id: openMailInvoiceBuyMode
        name: "OpenMailInvoiceBuyMode"
        kind: "FontString"
        text: "(Buyout)"
        wowParent: "OpenMailInvoiceFrame"
        anchors.left: openMailInvoicePurchaser.right
        anchors.leftMargin: 5
        anchors.verticalCenter: openMailInvoicePurchaser.verticalCenter
        width: 45
        height: 10.3
    }

    Part {
        id: openMailInvoiceDeposit
        name: "OpenMailInvoiceDeposit"
        kind: "FontString"
        text: "Deposit:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceSalePrice.right
        anchors.top: openMailInvoiceSalePrice.bottom
        anchors.topMargin: 13
        width: 49.8
        height: 11.9
    }

    Part {
        id: openMailInvoiceFrame
        name: "OpenMailInvoiceFrame"
        kind: "Frame"
        wowParent: "OpenMailScrollChildFrame"
        anchors.left: openMailScrollChildFrame.left
        anchors.top: openMailScrollChildFrame.top
        width: 296
        height: 314.7
    }

    Part {
        id: openMailInvoiceHouseCut
        name: "OpenMailInvoiceHouseCut"
        kind: "FontString"
        text: "Auction House Cut:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceDeposit.right
        anchors.top: openMailInvoiceDeposit.bottom
        anchors.topMargin: 13
        width: 113.8
        height: 11.9
    }

    Part {
        id: openMailInvoiceItemLabel
        name: "OpenMailInvoiceItemLabel"
        kind: "FontString"
        text: "Item Sold: Runecloth"
        wowParent: "OpenMailInvoiceFrame"
        anchors.left: openMailInvoiceFrame.left
        anchors.leftMargin: 30
        anchors.top: openMailInvoiceFrame.top
        anchors.topMargin: 35
        width: 240
        height: 11.9
    }

    Part {
        id: openMailInvoicePurchaser
        name: "OpenMailInvoicePurchaser"
        kind: "FontString"
        text: "Purchased By: Gruzurpator"
        wowParent: "OpenMailInvoiceFrame"
        anchors.left: openMailInvoiceItemLabel.left
        anchors.top: openMailInvoiceItemLabel.bottom
        anchors.topMargin: 5
        width: 158
        height: 11.9
    }

    Part {
        id: openMailInvoiceSalePrice
        name: "OpenMailInvoiceSalePrice"
        kind: "FontString"
        text: "Sale Price:"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoicePurchaser.left
        anchors.rightMargin: -125
        anchors.top: openMailInvoicePurchaser.bottom
        anchors.topMargin: 26
        width: 59.3
        height: 11.9
    }

    Part {
        id: openMailLetterButton
        name: "OpenMailLetterButton"
        kind: "Button"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 161.5
        anchors.top: openMailFrame.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Part {
        id: openMailMoneyButton
        name: "OpenMailMoneyButton"
        kind: "Button"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 161.5
        anchors.top: openMailFrame.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Part {
        id: openMailReplyButton
        name: "OpenMailReplyButton"
        kind: "Button"
        text: "Reply"
        wowParent: "OpenMailFrame"
        style: "Button"
        anchors.right: openMailFrame.right
        anchors.rightMargin: 205
        anchors.bottom: openMailFrame.bottom
        anchors.bottomMargin: 80
        width: 78
        height: 22
    }

    Part {
        id: openMailReplyButtonText
        name: "OpenMailReplyButtonText"
        kind: "FontString"
        text: "Reply"
        wowParent: "OpenMailReplyButton"
        anchors.horizontalCenter: openMailReplyButton.horizontalCenter
        anchors.verticalCenter: openMailReplyButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Part {
        id: openMailSalePriceMoneyFrame
        name: "OpenMailSalePriceMoneyFrame"
        kind: "Frame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceSalePrice.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceSalePrice.verticalCenter
        width: 106.7
        height: 13
    }

    Part {
        id: openMailSalePriceMoneyFrameCopperButton
        name: "OpenMailSalePriceMoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "OpenMailSalePriceMoneyFrame"
        anchors.right: openMailSalePriceMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: openMailSalePriceMoneyFrameCopperButtonText
        name: "OpenMailSalePriceMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "OpenMailSalePriceMoneyFrameCopperButton"
        anchors.right: openMailSalePriceMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: openMailSalePriceMoneyFrameGoldButton
        name: "OpenMailSalePriceMoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        wowParent: "OpenMailSalePriceMoneyFrame"
        anchors.right: openMailSalePriceMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailSalePriceMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: openMailSalePriceMoneyFrameGoldButtonText
        name: "OpenMailSalePriceMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "OpenMailSalePriceMoneyFrameGoldButton"
        anchors.right: openMailSalePriceMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Part {
        id: openMailSalePriceMoneyFrameSilverButton
        name: "OpenMailSalePriceMoneyFrameSilverButton"
        kind: "Button"
        text: "15"
        wowParent: "OpenMailSalePriceMoneyFrame"
        anchors.right: openMailSalePriceMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailSalePriceMoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: openMailSalePriceMoneyFrameSilverButtonText
        name: "OpenMailSalePriceMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "15"
        wowParent: "OpenMailSalePriceMoneyFrameSilverButton"
        anchors.right: openMailSalePriceMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailSalePriceMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: openMailScrollChildFrame
        name: "OpenMailScrollChildFrame"
        kind: "Frame"
        wowParent: "OpenMailScrollFrame"
        anchors.left: openMailScrollFrame.left
        anchors.top: openMailScrollFrame.top
        width: 296
        height: 324
    }

    Part {
        id: openMailScrollFrame
        name: "OpenMailScrollFrame"
        kind: "ScrollFrame"
        wowParent: "OpenMailFrame"
        anchors.left: openMailFrame.left
        anchors.leftMargin: 21
        anchors.top: openMailFrame.top
        anchors.topMargin: 13
        width: 296
        height: 324
    }

    Part {
        id: openMailScrollFrameDiabolicPanel
        name: "OpenMailScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "OpenMailFrame"
        anchors.left: openMailScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 336
    }

    Part {
        id: openMailScrollFrameDiabolicParchment
        name: "OpenMailScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "OpenMailScrollFrame"
        anchors.left: openMailScrollFrame.left
        anchors.leftMargin: -4
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: -4
        width: 304
        height: 332
    }

    Part {
        id: openMailScrollFrameScrollBar
        name: "OpenMailScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "OpenMailScrollFrame"
        style: "ScrollBar"
        anchors.left: openMailScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: openMailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 292
    }

    Part {
        id: openMailScrollFrameScrollBarDiabolicTrack
        name: "OpenMailScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "OpenMailScrollFrameScrollBar"
        anchors.horizontalCenter: openMailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: openMailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 326
    }

    Part {
        id: openMailScrollFrameScrollBarScrollDownButton
        name: "OpenMailScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "OpenMailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: openMailScrollFrameScrollBar.horizontalCenter
        anchors.top: openMailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: openMailScrollFrameScrollBarScrollUpButton
        name: "OpenMailScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "OpenMailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: openMailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: openMailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: openMailSender
        name: "OpenMailSender"
        kind: "FontString"
        text: "Customer Support"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.left: openMailSenderLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: openMailSenderLabel.verticalCenter
        width: 242.4
        height: 14.2
    }

    Part {
        id: openMailSenderLabel
        name: "OpenMailSenderLabel"
        kind: "FontString"
        text: "From:"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.right: openMailFrameDiabolicBand.left
        anchors.rightMargin: -56.6
        anchors.bottom: openMailFrameDiabolicBand.verticalCenter
        width: 33.2
        height: 16
    }

    Part {
        id: openMailSubject
        name: "OpenMailSubject"
        kind: "FontString"
        text: "Recovered items"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.left: openMailSubjectLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: openMailSubjectLabel.verticalCenter
        width: 242.4
        height: 16
    }

    Part {
        id: openMailSubjectLabel
        name: "OpenMailSubjectLabel"
        kind: "FontString"
        text: "Subject:"
        wowParent: "OpenMailFrameDiabolicBand"
        anchors.right: openMailFrameDiabolicBand.left
        anchors.rightMargin: -56.6
        anchors.top: openMailFrameDiabolicBand.verticalCenter
        width: 46.6
        height: 16
    }

    Part {
        id: openMailTitleText
        name: "OpenMailTitleText"
        kind: "FontString"
        text: "Open Mail"
        wowParent: "OpenMailFrameDiabolicTitlePlate"
        anchors.horizontalCenter: openMailFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: openMailFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 88.5
        height: 14.2
    }

    Part {
        id: openMailTransactionAmountMoneyFrame
        name: "OpenMailTransactionAmountMoneyFrame"
        kind: "Frame"
        wowParent: "OpenMailInvoiceFrame"
        anchors.right: openMailInvoiceAmountReceived.right
        anchors.rightMargin: -130
        anchors.verticalCenter: openMailInvoiceAmountReceived.verticalCenter
        width: 106.7
        height: 13
    }

    Part {
        id: openMailTransactionAmountMoneyFrameCopperButton
        name: "OpenMailTransactionAmountMoneyFrameCopperButton"
        kind: "Button"
        text: "28"
        wowParent: "OpenMailTransactionAmountMoneyFrame"
        anchors.right: openMailTransactionAmountMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrame.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: openMailTransactionAmountMoneyFrameCopperButtonText
        name: "OpenMailTransactionAmountMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "28"
        wowParent: "OpenMailTransactionAmountMoneyFrameCopperButton"
        anchors.right: openMailTransactionAmountMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: openMailTransactionAmountMoneyFrameGoldButton
        name: "OpenMailTransactionAmountMoneyFrameGoldButton"
        kind: "Button"
        text: "1"
        wowParent: "OpenMailTransactionAmountMoneyFrame"
        anchors.right: openMailTransactionAmountMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameSilverButton.verticalCenter
        width: 21.7
        height: 13
    }

    Part {
        id: openMailTransactionAmountMoneyFrameGoldButtonText
        name: "OpenMailTransactionAmountMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "1"
        wowParent: "OpenMailTransactionAmountMoneyFrameGoldButton"
        anchors.right: openMailTransactionAmountMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameGoldButton.verticalCenter
        width: 8.7
        height: 14.2
    }

    Part {
        id: openMailTransactionAmountMoneyFrameSilverButton
        name: "OpenMailTransactionAmountMoneyFrameSilverButton"
        kind: "Button"
        text: "19"
        wowParent: "OpenMailTransactionAmountMoneyFrame"
        anchors.right: openMailTransactionAmountMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameCopperButton.verticalCenter
        width: 32
        height: 13
    }

    Part {
        id: openMailTransactionAmountMoneyFrameSilverButtonText
        name: "OpenMailTransactionAmountMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "19"
        wowParent: "OpenMailTransactionAmountMoneyFrameSilverButton"
        anchors.right: openMailTransactionAmountMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: openMailTransactionAmountMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

}
