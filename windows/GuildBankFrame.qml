// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "GuildBankFrame"
    width: 769
    height: 444

    // the slots, logs and info 27 higher than Blizzard's: as far from the band
    // as from the foot's iron bar
    Frame {
        name: "GuildBankColumn1"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 43
        width: 100
        height: 311

        Button {
            name: "GuildBankColumn1Button1"
            wowParent: "GuildBankColumn1"
            anchors.left: parent.left
            anchors.leftMargin: 7
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 37
            height: 37

            FontString {
                name: "GuildBankColumn1Button1Count"
                text: "2"
                wowParent: "GuildBankColumn1Button1"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 10.3
                height: 14.2
            }
        }

        Frame {
            name: "GuildBankColumn2"
            wowParent: "GuildBankFrame"
            anchors.left: parent.right
            anchors.leftMargin: 3
            anchors.top: parent.top
            width: 100
            height: 311

            Frame {
                name: "GuildBankColumn3"
                wowParent: "GuildBankFrame"
                anchors.left: parent.right
                anchors.leftMargin: 3
                anchors.top: parent.top
                width: 100
                height: 311

                Frame {
                    name: "GuildBankColumn4"
                    wowParent: "GuildBankFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 3
                    anchors.top: parent.top
                    width: 100
                    height: 311

                    Frame {
                        name: "GuildBankColumn5"
                        wowParent: "GuildBankFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 3
                        anchors.top: parent.top
                        width: 100
                        height: 311

                        Frame {
                            name: "GuildBankColumn6"
                            wowParent: "GuildBankFrame"
                            anchors.left: parent.right
                            anchors.leftMargin: 3
                            anchors.top: parent.top
                            width: 100
                            height: 311

                            Frame {
                                name: "GuildBankColumn7"
                                wowParent: "GuildBankFrame"
                                anchors.left: parent.right
                                anchors.leftMargin: 3
                                anchors.top: parent.top
                                width: 100
                                height: 311
                            }
                        }
                    }
                }
            }
        }
    }

    Frame {
        name: "GuildBankFrameDiabolic"
        wowParent: "GuildBankFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -28
        width: 817
        height: 508

        Frame {
            name: "GuildBankFrameDiabolicBorder"
            wowParent: "GuildBankFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 817
            height: 476

            Frame {
                name: "GuildBankEmblemFrame"
                wowParent: "GuildBankFrame"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -70
                anchors.bottom: parent.top
                anchors.bottomMargin: -15
                width: 700
                height: 80
            }

            Frame {
                name: "GuildBankFrameDiabolicTitlePlate"
                wowParent: "GuildBankFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "GuildBankFrameDiabolicTitle"
                    text: "Guild Bank"
                    wowParent: "GuildBankFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 97.2
                    height: 14.2
                }
            }
        }

        Frame {
            name: "GuildBankFrameDiabolicFoot"
            wowParent: "GuildBankFrameDiabolic"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 771
            height: 77

            Frame {
                name: "GuildBankMoneyFrame"
                wowParent: "GuildBankFrame"
                pin: "place"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 29
                width: 126.4
                height: 13

                Button {
                    id: guildBankMoneyFrameCopperButton
                    name: "GuildBankMoneyFrameCopperButton"
                    text: "6"
                    wowParent: "GuildBankMoneyFrame"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 23.3
                    height: 13

                    FontString {
                        name: "GuildBankMoneyFrameCopperButtonText"
                        text: "6"
                        wowParent: "GuildBankMoneyFrameCopperButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 10.3
                        height: 14.2
                    }
                }

                Button {
                    name: "GuildBankMoneyFrameGoldButton"
                    text: "12023"
                    wowParent: "GuildBankMoneyFrame"
                    anchors.right: guildBankMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: guildBankMoneyFrameSilverButton.verticalCenter
                    width: 51.7
                    height: 13

                    FontString {
                        name: "GuildBankMoneyFrameGoldButtonText"
                        text: "12023"
                        wowParent: "GuildBankMoneyFrameGoldButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 38.7
                        height: 14.2
                    }
                }

                Button {
                    id: guildBankMoneyFrameSilverButton
                    name: "GuildBankMoneyFrameSilverButton"
                    text: "16"
                    wowParent: "GuildBankMoneyFrame"
                    anchors.right: guildBankMoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: guildBankMoneyFrameCopperButton.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "GuildBankMoneyFrameSilverButtonText"
                        text: "16"
                        wowParent: "GuildBankMoneyFrameSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

            FontString {
                name: "GuildBankMoneyLimitLabel"
                text: "Available Amount:"
                wowParent: "GuildBankFrame"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 27
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 29
                width: 98
                height: 13

                Frame {
                    name: "GuildBankWithdrawMoneyFrame"
                    wowParent: "GuildBankFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 36.3
                    height: 13

                    Button {
                        name: "GuildBankWithdrawMoneyFrameCopperButton"
                        text: "0"
                        wowParent: "GuildBankWithdrawMoneyFrame"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 23.3
                        height: 13

                        FontString {
                            name: "GuildBankWithdrawMoneyFrameCopperButtonText"
                            text: "0"
                            wowParent: "GuildBankWithdrawMoneyFrameCopperButton"
                            anchors.right: parent.right
                            anchors.rightMargin: 13
                            anchors.verticalCenter: parent.verticalCenter
                            width: 10.3
                            height: 14.2
                        }
                    }
                }
            }

            WowRow {
                name: "GuildBankButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 562
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50

                Button {
                    name: "GuildBankFrameWithdrawButton"
                    text: "Withdraw"
                    wowParent: "GuildBankFrame"
                    style: "Button"
                    pin: "all"
                    width: 94.5
                    height: 21

                    FontString {
                        name: "GuildBankFrameWithdrawButtonText"
                        text: "Withdraw"
                        wowParent: "GuildBankFrameWithdrawButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 76.6
                        height: 11.9
                    }
                }

                Button {
                    name: "GuildBankFrameDepositButton"
                    text: "Deposit"
                    wowParent: "GuildBankFrame"
                    style: "Button"
                    pin: "all"
                    width: 94.5
                    height: 21

                    FontString {
                        name: "GuildBankFrameDepositButtonText"
                        text: "Deposit"
                        wowParent: "GuildBankFrameDepositButton"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 56.1
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "GuildBankFrameDiabolicRail"
            wowParent: "GuildBankFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 246
            height: 18
        }

        Frame {
            name: "GuildBankFrameDiabolicSocket"
            wowParent: "GuildBankFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "GuildBankFrameTab1"
            text: "Guild Bank"
            wowParent: "GuildBankFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "GuildBankFrameTab2"
            text: "Log"
            wowParent: "GuildBankFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "GuildBankFrameTab3"
            text: "Money Log"
            wowParent: "GuildBankFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 144
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "GuildBankFrameTab4"
            text: "Info"
            wowParent: "GuildBankFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 202
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Frame {
        name: "GuildBankFrameLog"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -27
        width: 10
        height: 10

        ScrollingMessageFrame {
            name: "GuildBankMessageFrame"
            wowParent: "GuildBankFrameLog"
            anchors.left: parent.left
            anchors.leftMargin: 33
            anchors.top: parent.top
            anchors.topMargin: 73
            width: 688
            height: 304

            Frame {
                name: "GuildBankMessageFrameDiabolicPanel"
                wowParent: "GuildBankFrameLog"
                anchors.left: parent.left
                anchors.leftMargin: -16
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 730
                height: 316
            }

            Frame {
                name: "GuildBankMessageFrameDiabolicParchment"
                wowParent: "GuildBankFrameLog"
                anchors.left: parent.left
                anchors.leftMargin: -14
                anchors.top: parent.top
                anchors.topMargin: -4
                width: 726
                height: 312
            }
        }
    }

    Frame {
        name: "GuildBankInfo"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 33
        anchors.top: parent.top
        anchors.topMargin: 46
        width: 10
        height: 10

        // the info's page the logs' size, in the same place
        ScrollFrame {
            name: "GuildBankInfoScrollFrame"
            wowParent: "GuildBankInfo"
            pin: "size"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 688
            height: 304

            Frame {
                name: "GuildBankInfoScrollFrameDiabolicPanel"
                wowParent: "GuildBankInfo"
                anchors.left: parent.left
                anchors.leftMargin: -16
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 730
                height: 316
            }

            Frame {
                name: "GuildBankInfoScrollFrameDiabolicParchment"
                wowParent: "GuildBankInfo"
                anchors.left: parent.left
                anchors.leftMargin: -14
                anchors.top: parent.top
                anchors.topMargin: -4
                width: 726
                height: 312
            }

            Slider {
                name: "GuildBankInfoScrollFrameScrollBar"
                wowParent: "GuildBankInfoScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 272

                Button {
                    name: "GuildBankInfoScrollFrameScrollBarScrollDownButton"
                    wowParent: "GuildBankInfoScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "GuildBankInfoScrollFrameScrollBarScrollUpButton"
                    wowParent: "GuildBankInfoScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "GuildBankInfoScrollFrameScrollBarDiabolicTrack"
                        wowParent: "GuildBankInfoScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 306
                    }
                }
            }

            EditBox {
                name: "GuildBankTabInfoEditBox"
                wowParent: "GuildBankInfoScrollFrame"
                pin: "size"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 688
                height: 218
            }
        }
    }

    Frame {
        name: "GuildBankTab1"
        wowParent: "GuildBankFrame"
        anchors.left: parent.right
        anchors.leftMargin: -1
        anchors.top: parent.top
        anchors.topMargin: 32
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab1Button"
            wowParent: "GuildBankTab1"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
        }

        Frame {
            name: "GuildBankTab2"
            wowParent: "GuildBankFrame"
            anchors.left: parent.left
            anchors.top: parent.bottom
            width: 42
            height: 50

            CheckButton {
                name: "GuildBankTab2Button"
                wowParent: "GuildBankTab2"
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.top: parent.top
                anchors.topMargin: 8
                width: 36
                height: 34
            }

            Frame {
                name: "GuildBankTab3"
                wowParent: "GuildBankFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                width: 42
                height: 50

                CheckButton {
                    name: "GuildBankTab3Button"
                    wowParent: "GuildBankTab3"
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    width: 36
                    height: 34
                }

                Frame {
                    name: "GuildBankTab4"
                    wowParent: "GuildBankFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    width: 42
                    height: 50

                    CheckButton {
                        name: "GuildBankTab4Button"
                        wowParent: "GuildBankTab4"
                        anchors.left: parent.left
                        anchors.leftMargin: 2
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        width: 36
                        height: 34
                    }

                    Frame {
                        name: "GuildBankTab5"
                        wowParent: "GuildBankFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        width: 42
                        height: 50

                        CheckButton {
                            name: "GuildBankTab5Button"
                            wowParent: "GuildBankTab5"
                            anchors.left: parent.left
                            anchors.leftMargin: 2
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            width: 36
                            height: 34
                        }

                        Frame {
                            name: "GuildBankTab6"
                            wowParent: "GuildBankFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            width: 42
                            height: 50

                            CheckButton {
                                name: "GuildBankTab6Button"
                                wowParent: "GuildBankTab6"
                                anchors.left: parent.left
                                anchors.leftMargin: 2
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                width: 36
                                height: 34
                            }
                        }
                    }
                }
            }
        }
    }

    ScrollFrame {
        name: "GuildBankTransactionsScrollFrame"
        wowParent: "GuildBankFrameLog"
        pin: "place"
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 48
        width: 688
        height: 304

        Slider {
            name: "GuildBankTransactionsScrollFrameScrollBar"
            wowParent: "GuildBankTransactionsScrollFrame"
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 272

            Button {
                name: "GuildBankTransactionsScrollFrameScrollBarScrollDownButton"
                wowParent: "GuildBankTransactionsScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                name: "GuildBankTransactionsScrollFrameScrollBarScrollUpButton"
                wowParent: "GuildBankTransactionsScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16

                Frame {
                    name: "GuildBankTransactionsScrollFrameScrollBarDiabolicTrack"
                    wowParent: "GuildBankTransactionsScrollFrameScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: -1
                    width: 18
                    height: 306
                }
            }
        }

        Frame {
            name: "GuildBankTransactionsScrollFrameScrollChildFrame"
            wowParent: "GuildBankTransactionsScrollFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 300
            height: 325
        }
    }

    Ghost {
        name: "GuildBankTabLimitBackground"
        x: 390.6
        y: 397
        width: 0
        height: 0

        FontString {
            name: "GuildBankLimitLabel"
            wowParent: "GuildBankFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            width: 260.7
            height: 10.3
        }
    }
}
