// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "OpenMailFrame"
    width: 384
    height: 512

    Button {
        name: "OpenMailAttachmentButton1"
        wowParent: "OpenMailFrame"
        anchors.left: parent.left
        anchors.leftMargin: 161.5
        anchors.top: parent.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37

        FontString {
            name: "OpenMailAttachmentButton1Count"
            text: "20"
            wowParent: "OpenMailAttachmentButton1"
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
        wowParent: "OpenMailFrame"
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
            wowParent: "OpenMailFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 352
            height: 40

            FontString {
                name: "OpenMailSenderLabel"
                text: "From:"
                wowParent: "OpenMailFrameDiabolicBand"
                anchors.right: parent.left
                anchors.rightMargin: -56.6
                anchors.bottom: parent.verticalCenter
                width: 33.2
                height: 16

                FontString {
                    name: "OpenMailSender"
                    text: "Unknown"
                    wowParent: "OpenMailFrameDiabolicBand"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    width: 242.4
                    height: 14.2
                }
            }

            FontString {
                name: "OpenMailSubjectLabel"
                text: "Subject:"
                wowParent: "OpenMailFrameDiabolicBand"
                anchors.right: parent.left
                anchors.rightMargin: -56.6
                anchors.top: parent.verticalCenter
                width: 46.6
                height: 16

                FontString {
                    name: "OpenMailSubject"
                    wowParent: "OpenMailFrameDiabolicBand"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    width: 242.4
                    height: 16
                }
            }
        }

        Frame {
            name: "OpenMailFrameDiabolicBorder"
            wowParent: "OpenMailFrameDiabolic"
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
                    wowParent: "OpenMailFrameDiabolicTitlePlate"
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
            wowParent: "OpenMailFrameDiabolic"
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
                        wowParent: "OpenMailReplyButton"
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
                        wowParent: "OpenMailDeleteButton"
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
                        wowParent: "OpenMailCancelButton"
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
            wowParent: "OpenMailFrameDiabolic"
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
        wowParent: "OpenMailFrame"
        anchors.left: parent.left
        anchors.leftMargin: 161.5
        anchors.top: parent.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    Button {
        name: "OpenMailMoneyButton"
        wowParent: "OpenMailFrame"
        anchors.left: parent.left
        anchors.leftMargin: 161.5
        anchors.top: parent.bottom
        anchors.topMargin: -163.6
        width: 37
        height: 37
    }

    ScrollFrame {
        name: "OpenMailScrollFrame"
        wowParent: "OpenMailFrame"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 13
        width: 296
        height: 362

        Frame {
            name: "OpenMailScrollChildFrame"
            wowParent: "OpenMailScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 296
            height: 362

            FontString {
                name: "OpenMailBodyText"
                wowParent: "OpenMailScrollChildFrame"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                width: 276
                height: 1
            }

            Frame {
                name: "OpenMailInvoiceFrame"
                wowParent: "OpenMailScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 296
                height: 314.7

                FontString {
                    name: "OpenMailInvoiceItemLabel"
                    text: "Item Sold: Runecloth"
                    wowParent: "OpenMailInvoiceFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 35
                    width: 240
                    height: 11.9

                    FontString {
                        name: "OpenMailInvoicePurchaser"
                        text: "Purchased By: Gruzurpator"
                        wowParent: "OpenMailInvoiceFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 5
                        width: 158
                        height: 11.9

                        FontString {
                            name: "OpenMailInvoiceBuyMode"
                            text: "(Buyout)"
                            wowParent: "OpenMailInvoiceFrame"
                            anchors.left: parent.right
                            anchors.leftMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            width: 45
                            height: 10.3
                        }

                        FontString {
                            name: "OpenMailInvoiceSalePrice"
                            text: "Sale Price:"
                            wowParent: "OpenMailInvoiceFrame"
                            anchors.right: parent.left
                            anchors.rightMargin: -125
                            anchors.top: parent.bottom
                            anchors.topMargin: 26
                            width: 59.3
                            height: 11.9

                            FontString {
                                name: "OpenMailInvoiceDeposit"
                                text: "Deposit:"
                                wowParent: "OpenMailInvoiceFrame"
                                anchors.right: parent.right
                                anchors.top: parent.bottom
                                anchors.topMargin: 13
                                width: 49.8
                                height: 11.9

                                Frame {
                                    name: "OpenMailDepositMoneyFrame"
                                    wowParent: "OpenMailInvoiceFrame"
                                    anchors.right: parent.right
                                    anchors.rightMargin: -130
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 72.3
                                    height: 13

                                    Button {
                                        name: "OpenMailDepositMoneyFrameCopperButton"
                                        text: "0"
                                        wowParent: "OpenMailDepositMoneyFrame"
                                        anchors.right: parent.right
                                        anchors.rightMargin: 13
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 32
                                        height: 13

                                        FontString {
                                            name: "OpenMailDepositMoneyFrameCopperButtonText"
                                            text: "0"
                                            wowParent: "OpenMailDepositMoneyFrameCopperButton"
                                            anchors.right: parent.right
                                            anchors.rightMargin: 13
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 10.3
                                            height: 14.2
                                        }

                                        Button {
                                            name: "OpenMailDepositMoneyFrameSilverButton"
                                            text: "6"
                                            wowParent: "OpenMailDepositMoneyFrame"
                                            anchors.right: parent.left
                                            anchors.rightMargin: 4
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 23.3
                                            height: 13

                                            FontString {
                                                name: "OpenMailDepositMoneyFrameSilverButtonText"
                                                text: "6"
                                                wowParent: "OpenMailDepositMoneyFrameSilverButton"
                                                anchors.right: parent.right
                                                anchors.rightMargin: 13
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: 10.3
                                                height: 14.2
                                            }
                                        }
                                    }
                                }

                                FontString {
                                    name: "OpenMailInvoiceHouseCut"
                                    text: "Auction House Cut:"
                                    wowParent: "OpenMailInvoiceFrame"
                                    anchors.right: parent.right
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 13
                                    width: 113.8
                                    height: 11.9

                                    Frame {
                                        name: "OpenMailHouseCutMoneyFrame"
                                        wowParent: "OpenMailInvoiceFrame"
                                        anchors.right: parent.right
                                        anchors.rightMargin: -130
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 70.7
                                        height: 13

                                        Button {
                                            name: "OpenMailHouseCutMoneyFrameCopperButton"
                                            text: "72"
                                            wowParent: "OpenMailHouseCutMoneyFrame"
                                            anchors.right: parent.right
                                            anchors.rightMargin: 13
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 32
                                            height: 13

                                            FontString {
                                                name: "OpenMailHouseCutMoneyFrameCopperButtonText"
                                                text: "72"
                                                wowParent: "OpenMailHouseCutMoneyFrameCopperButton"
                                                anchors.right: parent.right
                                                anchors.rightMargin: 13
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: 17.4
                                                height: 14.2
                                            }

                                            Button {
                                                name: "OpenMailHouseCutMoneyFrameSilverButton"
                                                text: "1"
                                                wowParent: "OpenMailHouseCutMoneyFrame"
                                                anchors.right: parent.left
                                                anchors.rightMargin: 4
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: 21.7
                                                height: 13

                                                FontString {
                                                    name: "OpenMailHouseCutMoneyFrameSilverButtonText"
                                                    text: "1"
                                                    wowParent: "OpenMailHouseCutMoneyFrameSilverButton"
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 13
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    width: 8.7
                                                    height: 14.2
                                                }
                                            }
                                        }
                                    }

                                    FontString {
                                        name: "OpenMailInvoiceAmountReceived"
                                        text: "Amount Received:"
                                        wowParent: "OpenMailInvoiceFrame"
                                        anchors.right: parent.right
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 18
                                        width: 107.5
                                        height: 11.9

                                        Frame {
                                            name: "OpenMailTransactionAmountMoneyFrame"
                                            wowParent: "OpenMailInvoiceFrame"
                                            anchors.right: parent.right
                                            anchors.rightMargin: -130
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 106.7
                                            height: 13

                                            Button {
                                                name: "OpenMailTransactionAmountMoneyFrameCopperButton"
                                                text: "28"
                                                wowParent: "OpenMailTransactionAmountMoneyFrame"
                                                anchors.right: parent.right
                                                anchors.rightMargin: 13
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: 32
                                                height: 13

                                                FontString {
                                                    name: "OpenMailTransactionAmountMoneyFrameCopperButtonText"
                                                    text: "28"
                                                    wowParent: "OpenMailTransactionAmountMoneyFrameCopperButton"
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 13
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    width: 17.4
                                                    height: 14.2
                                                }

                                                Button {
                                                    name: "OpenMailTransactionAmountMoneyFrameSilverButton"
                                                    text: "19"
                                                    wowParent: "OpenMailTransactionAmountMoneyFrame"
                                                    anchors.right: parent.left
                                                    anchors.rightMargin: 4
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    width: 32
                                                    height: 13

                                                    Button {
                                                        name: "OpenMailTransactionAmountMoneyFrameGoldButton"
                                                        text: "1"
                                                        wowParent: "OpenMailTransactionAmountMoneyFrame"
                                                        anchors.right: parent.left
                                                        anchors.rightMargin: 4
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        width: 21.7
                                                        height: 13

                                                        FontString {
                                                            name: "OpenMailTransactionAmountMoneyFrameGoldButtonText"
                                                            text: "1"
                                                            wowParent: "OpenMailTransactionAmountMoneyFrameGoldButton"
                                                            anchors.right: parent.right
                                                            anchors.rightMargin: 13
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            width: 8.7
                                                            height: 14.2
                                                        }
                                                    }

                                                    FontString {
                                                        name: "OpenMailTransactionAmountMoneyFrameSilverButtonText"
                                                        text: "19"
                                                        wowParent: "OpenMailTransactionAmountMoneyFrameSilverButton"
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
                            }

                            Frame {
                                name: "OpenMailSalePriceMoneyFrame"
                                wowParent: "OpenMailInvoiceFrame"
                                anchors.right: parent.right
                                anchors.rightMargin: -130
                                anchors.verticalCenter: parent.verticalCenter
                                width: 106.7
                                height: 13

                                Button {
                                    name: "OpenMailSalePriceMoneyFrameCopperButton"
                                    text: "0"
                                    wowParent: "OpenMailSalePriceMoneyFrame"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 32
                                    height: 13

                                    FontString {
                                        name: "OpenMailSalePriceMoneyFrameCopperButtonText"
                                        text: "0"
                                        wowParent: "OpenMailSalePriceMoneyFrameCopperButton"
                                        anchors.right: parent.right
                                        anchors.rightMargin: 13
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 10.3
                                        height: 14.2
                                    }

                                    Button {
                                        name: "OpenMailSalePriceMoneyFrameSilverButton"
                                        text: "15"
                                        wowParent: "OpenMailSalePriceMoneyFrame"
                                        anchors.right: parent.left
                                        anchors.rightMargin: 4
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 32
                                        height: 13

                                        Button {
                                            name: "OpenMailSalePriceMoneyFrameGoldButton"
                                            text: "1"
                                            wowParent: "OpenMailSalePriceMoneyFrame"
                                            anchors.right: parent.left
                                            anchors.rightMargin: 4
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 21.7
                                            height: 13

                                            FontString {
                                                name: "OpenMailSalePriceMoneyFrameGoldButtonText"
                                                text: "1"
                                                wowParent: "OpenMailSalePriceMoneyFrameGoldButton"
                                                anchors.right: parent.right
                                                anchors.rightMargin: 13
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: 8.7
                                                height: 14.2
                                            }
                                        }

                                        FontString {
                                            name: "OpenMailSalePriceMoneyFrameSilverButtonText"
                                            text: "15"
                                            wowParent: "OpenMailSalePriceMoneyFrameSilverButton"
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
            wowParent: "OpenMailScrollFrame"
            anchors.left: parent.left
            anchors.leftMargin: -4
            anchors.top: parent.top
            anchors.topMargin: -4
            width: 304
            height: 370
        }

        Slider {
            name: "OpenMailScrollFrameScrollBar"
            wowParent: "OpenMailScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 330

            Button {
                name: "OpenMailScrollFrameScrollBarScrollDownButton"
                wowParent: "OpenMailScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "OpenMailScrollFrameScrollBarScrollUpButton"
                wowParent: "OpenMailScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "OpenMailScrollFrameScrollBarDiabolicTrack"
                    wowParent: "OpenMailScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 364
                }
            }
        }
    }
}
