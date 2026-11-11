// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "OpenMailFrame"
    width: 384
    height: 512

    Button {
        name: "OpenMailAttachmentButton1"
        anchors.left: parent.left
        anchors.leftMargin: 161.5
        anchors.top: parent.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37

        FontString {
            name: "OpenMailAttachmentButton1Count"
            text: "20"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 17.4
            height: 14.2
        }
    }

    Frame {
        name: "OpenMailFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -16
        anchors.top: parent.top
        anchors.topMargin: -68
        width: 400
        height: 530

        Button {
            name: "OpenMailCloseButton"
            wowParent: "OpenMailFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "OpenMailFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 352
            height: 40

            FontString {
                name: "OpenMailSender"
                text: "Unknown"
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
                anchors.right: parent.left
                anchors.rightMargin: -56.6
                anchors.bottom: parent.verticalCenter
                width: 33.2
                height: 16
            }

            FontString {
                name: "OpenMailSubject"
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
                anchors.right: parent.left
                anchors.rightMargin: -56.6
                anchors.top: parent.verticalCenter
                width: 46.6
                height: 16
            }
        }

        Frame {
            name: "OpenMailFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 400
            height: 530

            Frame {
                name: "OpenMailFrameDiabolicTitlePlate"
                wowParent: "OpenMailFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "OpenMailTitleText"
                    text: "Open Mail"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 88.5
                    height: 14.2
                }
            }
        }

        Frame {
            name: "OpenMailFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 354
            height: 35

            WowRow {
                name: "OpenMailButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 94
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "OpenMailReplyButton"
                    text: "Reply"
                    wowParent: "OpenMailFrame"
                    style: "Button"
                    pin: "all"
                    width: 78
                    height: 22

                    FontString {
                        name: "OpenMailReplyButtonText"
                        text: "Reply"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 40.3
                        height: 11.9
                    }
                }

                Button {
                    name: "OpenMailDeleteButton"
                    text: "Return"
                    wowParent: "OpenMailFrame"
                    style: "Button"
                    pin: "all"
                    width: 78
                    height: 22

                    FontString {
                        name: "OpenMailDeleteButtonText"
                        text: "Return"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 53.7
                        height: 11.9
                    }
                }

                Button {
                    name: "OpenMailCancelButton"
                    text: "Close"
                    wowParent: "OpenMailFrame"
                    style: "Button"
                    pin: "all"
                    width: 78
                    height: 22

                    FontString {
                        name: "OpenMailCancelButtonText"
                        text: "Close"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 40.3
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "OpenMailFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Button {
        name: "OpenMailLetterButton"
        anchors.left: parent.left
        anchors.leftMargin: 161.5
        anchors.top: parent.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Button {
        name: "OpenMailMoneyButton"
        anchors.left: parent.left
        anchors.leftMargin: 161.5
        anchors.top: parent.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    ScrollFrame {
        name: "OpenMailScrollFrame"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 13
        width: 296
        height: 362

        Frame {
            name: "OpenMailScrollChildFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 296
            height: 362

            FontString {
                name: "OpenMailBodyText"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                width: 276
                height: 1
            }

            Frame {
                name: "OpenMailInvoiceFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 296
                height: 314.7

                Frame {
                    name: "OpenMailDepositMoneyFrame"
                    anchors.right: openMailInvoiceDeposit.right
                    anchors.rightMargin: -130
                    anchors.verticalCenter: openMailInvoiceDeposit.verticalCenter
                    width: 72.3
                    height: 13

                    Button {
                        id: openMailDepositMoneyFrameCopperButton
                        name: "OpenMailDepositMoneyFrameCopperButton"
                        text: "0"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "OpenMailDepositMoneyFrameCopperButtonText"
                            text: "0"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 10.3
                            height: 14.2
                        }
                    }

                    Button {
                        name: "OpenMailDepositMoneyFrameSilverButton"
                        text: "6"
                        anchors.right: openMailDepositMoneyFrameCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: openMailDepositMoneyFrameCopperButton.verticalCenter
                        width: 23.3
                        height: 13

                        FontString {
                            name: "OpenMailDepositMoneyFrameSilverButtonText"
                            text: "6"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 10.3
                            height: 14.2
                        }
                    }
                }

                Frame {
                    name: "OpenMailHouseCutMoneyFrame"
                    anchors.right: openMailInvoiceHouseCut.right
                    anchors.rightMargin: -130
                    anchors.verticalCenter: openMailInvoiceHouseCut.verticalCenter
                    width: 70.7
                    height: 13

                    Button {
                        id: openMailHouseCutMoneyFrameCopperButton
                        name: "OpenMailHouseCutMoneyFrameCopperButton"
                        text: "72"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "OpenMailHouseCutMoneyFrameCopperButtonText"
                            text: "72"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 17.4
                            height: 14.2
                        }
                    }

                    Button {
                        name: "OpenMailHouseCutMoneyFrameSilverButton"
                        text: "1"
                        anchors.right: openMailHouseCutMoneyFrameCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: openMailHouseCutMoneyFrameCopperButton.verticalCenter
                        width: 21.7
                        height: 13

                        FontString {
                            name: "OpenMailHouseCutMoneyFrameSilverButtonText"
                            text: "1"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 8.7
                            height: 14.2
                        }
                    }
                }

                FontString {
                    id: openMailInvoiceAmountReceived
                    name: "OpenMailInvoiceAmountReceived"
                    text: "Amount Received:"
                    anchors.right: openMailInvoiceHouseCut.right
                    anchors.top: openMailInvoiceHouseCut.bottom
                    anchors.topMargin: 18
                    width: 107.5
                    height: 11.9
                }

                FontString {
                    name: "OpenMailInvoiceBuyMode"
                    text: "(Buyout)"
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
                    anchors.right: openMailInvoiceSalePrice.right
                    anchors.top: openMailInvoiceSalePrice.bottom
                    anchors.topMargin: 13
                    width: 49.8
                    height: 11.9
                }

                FontString {
                    id: openMailInvoiceHouseCut
                    name: "OpenMailInvoiceHouseCut"
                    text: "Auction House Cut:"
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
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 35
                    width: 240
                    height: 11.9
                }

                FontString {
                    id: openMailInvoicePurchaser
                    name: "OpenMailInvoicePurchaser"
                    text: "Purchased By: Gruzurpator"
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
                    anchors.right: openMailInvoicePurchaser.left
                    anchors.rightMargin: -125
                    anchors.top: openMailInvoicePurchaser.bottom
                    anchors.topMargin: 26
                    width: 59.3
                    height: 11.9
                }

                Frame {
                    name: "OpenMailSalePriceMoneyFrame"
                    anchors.right: openMailInvoiceSalePrice.right
                    anchors.rightMargin: -130
                    anchors.verticalCenter: openMailInvoiceSalePrice.verticalCenter
                    width: 106.7
                    height: 13

                    Button {
                        id: openMailSalePriceMoneyFrameCopperButton
                        name: "OpenMailSalePriceMoneyFrameCopperButton"
                        text: "0"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "OpenMailSalePriceMoneyFrameCopperButtonText"
                            text: "0"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 10.3
                            height: 14.2
                        }
                    }

                    Button {
                        name: "OpenMailSalePriceMoneyFrameGoldButton"
                        text: "1"
                        anchors.right: openMailSalePriceMoneyFrameSilverButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: openMailSalePriceMoneyFrameSilverButton.verticalCenter
                        width: 21.7
                        height: 13

                        FontString {
                            name: "OpenMailSalePriceMoneyFrameGoldButtonText"
                            text: "1"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 8.7
                            height: 14.2
                        }
                    }

                    Button {
                        id: openMailSalePriceMoneyFrameSilverButton
                        name: "OpenMailSalePriceMoneyFrameSilverButton"
                        text: "15"
                        anchors.right: openMailSalePriceMoneyFrameCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: openMailSalePriceMoneyFrameCopperButton.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "OpenMailSalePriceMoneyFrameSilverButtonText"
                            text: "15"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 17.4
                            height: 14.2
                        }
                    }
                }

                Frame {
                    name: "OpenMailTransactionAmountMoneyFrame"
                    anchors.right: openMailInvoiceAmountReceived.right
                    anchors.rightMargin: -130
                    anchors.verticalCenter: openMailInvoiceAmountReceived.verticalCenter
                    width: 106.7
                    height: 13

                    Button {
                        id: openMailTransactionAmountMoneyFrameCopperButton
                        name: "OpenMailTransactionAmountMoneyFrameCopperButton"
                        text: "28"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "OpenMailTransactionAmountMoneyFrameCopperButtonText"
                            text: "28"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 17.4
                            height: 14.2
                        }
                    }

                    Button {
                        name: "OpenMailTransactionAmountMoneyFrameGoldButton"
                        text: "1"
                        anchors.right: openMailTransactionAmountMoneyFrameSilverButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: openMailTransactionAmountMoneyFrameSilverButton.verticalCenter
                        width: 21.7
                        height: 13

                        FontString {
                            name: "OpenMailTransactionAmountMoneyFrameGoldButtonText"
                            text: "1"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 8.7
                            height: 14.2
                        }
                    }

                    Button {
                        id: openMailTransactionAmountMoneyFrameSilverButton
                        name: "OpenMailTransactionAmountMoneyFrameSilverButton"
                        text: "19"
                        anchors.right: openMailTransactionAmountMoneyFrameCopperButton.left
                        anchors.rightMargin: 4
                        anchors.verticalCenter: openMailTransactionAmountMoneyFrameCopperButton.verticalCenter
                        width: 32
                        height: 13

                        FontString {
                            name: "OpenMailTransactionAmountMoneyFrameSilverButtonText"
                            text: "19"
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

        Frame {
            name: "OpenMailScrollFrameDiabolicPanel"
            wowParent: "OpenMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: -6
            anchors.top: parent.top
            anchors.topMargin: -6
            width: 330
            height: 374
        }

        Frame {
            name: "OpenMailScrollFrameDiabolicParchment"
            anchors.left: parent.left
            anchors.leftMargin: -4
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 304
            height: 370
        }

        Slider {
            name: "OpenMailScrollFrameScrollBar"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 330

            Frame {
                name: "OpenMailScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: openMailScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: openMailScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 364
            }

            Button {
                name: "OpenMailScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: openMailScrollFrameScrollBarScrollUpButton
                name: "OpenMailScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }
    }
}
