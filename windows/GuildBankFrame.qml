// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "GuildBankFrame"
    width: 769
    height: 444

    // the slots, logs and info 27 higher than Blizzard's: as far from the band
    // as from the foot's iron bar
    Frame {
        id: guildBankColumn1
        name: "GuildBankColumn1"
        pin: "place"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 43
        width: 100
        height: 311

        Button {
            name: "GuildBankColumn1Button1"
            anchors.left: parent.left
            anchors.leftMargin: 7
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 37
            height: 37

            FontString {
                name: "GuildBankColumn1Button1Count"
                text: "2"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 10.3
                height: 14.2
            }
        }
    }

    Frame {
        id: guildBankColumn2
        name: "GuildBankColumn2"
        anchors.left: guildBankColumn1.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn1.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn3
        name: "GuildBankColumn3"
        anchors.left: guildBankColumn2.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn2.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn4
        name: "GuildBankColumn4"
        anchors.left: guildBankColumn3.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn3.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn5
        name: "GuildBankColumn5"
        anchors.left: guildBankColumn4.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn4.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn6
        name: "GuildBankColumn6"
        anchors.left: guildBankColumn5.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn5.top
        width: 100
        height: 311
    }

    Frame {
        name: "GuildBankColumn7"
        anchors.left: guildBankColumn6.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn6.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankFrameDiabolic
        name: "GuildBankFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        anchors.topMargin: -28
        width: 817
        height: 508

        Frame {
            name: "GuildBankEmblemFrame"
            wowParent: "GuildBankFrame"
            anchors.horizontalCenter: guildBankFrameDiabolicBorder.horizontalCenter
            anchors.horizontalCenterOffset: -70
            anchors.bottom: guildBankFrameDiabolicBorder.top
            anchors.bottomMargin: -15
            width: 700
            height: 80
        }

        Frame {
            id: guildBankFrameDiabolicBorder
            name: "GuildBankFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 817
            height: 476

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
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 23.3
                    height: 13

                    FontString {
                        name: "GuildBankMoneyFrameCopperButtonText"
                        text: "6"
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
                    anchors.right: guildBankMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: guildBankMoneyFrameSilverButton.verticalCenter
                    width: 51.7
                    height: 13

                    FontString {
                        name: "GuildBankMoneyFrameGoldButtonText"
                        text: "12023"
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
                    anchors.right: guildBankMoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: guildBankMoneyFrameCopperButton.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "GuildBankMoneyFrameSilverButtonText"
                        text: "16"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

            FontString {
                id: guildBankMoneyLimitLabel
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
            }

            Frame {
                name: "GuildBankWithdrawMoneyFrame"
                wowParent: "GuildBankFrame"
                anchors.left: guildBankMoneyLimitLabel.right
                anchors.leftMargin: 13
                anchors.verticalCenter: guildBankMoneyLimitLabel.verticalCenter
                width: 36.3
                height: 13

                Button {
                    name: "GuildBankWithdrawMoneyFrameCopperButton"
                    text: "0"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 23.3
                    height: 13

                    FontString {
                        name: "GuildBankWithdrawMoneyFrameCopperButtonText"
                        text: "0"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 10.3
                        height: 14.2
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
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 246
            height: 18
        }

        Frame {
            name: "GuildBankFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }
    }

    Frame {
        name: "GuildBankFrameLog"
        pin: "place"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -27
        width: 10
        height: 10

        ScrollingMessageFrame {
            name: "GuildBankMessageFrame"
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

    Button {
        name: "GuildBankFrameTab1"
        text: "Guild Bank"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "GuildBankFrameTab2"
        text: "Log"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "GuildBankFrameTab3"
        text: "Money Log"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "GuildBankFrameTab4"
        text: "Info"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        name: "GuildBankInfo"
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
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 272

                Frame {
                    name: "GuildBankInfoScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: guildBankInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: guildBankInfoScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 306
                }

                Button {
                    name: "GuildBankInfoScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: guildBankInfoScrollFrameScrollBarScrollUpButton
                    name: "GuildBankInfoScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }

            EditBox {
                name: "GuildBankTabInfoEditBox"
                pin: "size"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 688
                height: 218
            }
        }
    }

    Frame {
        id: guildBankTab1
        name: "GuildBankTab1"
        anchors.left: parent.right
        anchors.leftMargin: -1
        anchors.top: parent.top
        anchors.topMargin: 32
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab1Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
        }
    }

    Frame {
        id: guildBankTab2
        name: "GuildBankTab2"
        anchors.left: guildBankTab1.left
        anchors.top: guildBankTab1.bottom
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab2Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
        }
    }

    Frame {
        id: guildBankTab3
        name: "GuildBankTab3"
        anchors.left: guildBankTab2.left
        anchors.top: guildBankTab2.bottom
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab3Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
        }
    }

    Frame {
        id: guildBankTab4
        name: "GuildBankTab4"
        anchors.left: guildBankTab3.left
        anchors.top: guildBankTab3.bottom
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab4Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
        }
    }

    Frame {
        id: guildBankTab5
        name: "GuildBankTab5"
        anchors.left: guildBankTab4.left
        anchors.top: guildBankTab4.bottom
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab5Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
        }
    }

    Frame {
        name: "GuildBankTab6"
        anchors.left: guildBankTab5.left
        anchors.top: guildBankTab5.bottom
        width: 42
        height: 50

        CheckButton {
            name: "GuildBankTab6Button"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 36
            height: 34
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
            style: "ScrollBar"
            anchors.left: parent.right
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 16
            width: 16
            height: 272

            Frame {
                name: "GuildBankTransactionsScrollFrameScrollBarDiabolicTrack"
                anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBarScrollUpButton.horizontalCenter
                anchors.top: guildBankTransactionsScrollFrameScrollBarScrollUpButton.top
                anchors.topMargin: -1
                width: 18
                height: 306
            }

            Button {
                name: "GuildBankTransactionsScrollFrameScrollBarScrollDownButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                width: 16
                height: 16
            }

            Button {
                id: guildBankTransactionsScrollFrameScrollBarScrollUpButton
                name: "GuildBankTransactionsScrollFrameScrollBarScrollUpButton"
                style: "ScrollBar"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                width: 16
                height: 16
            }
        }

        Frame {
            name: "GuildBankTransactionsScrollFrameScrollChildFrame"
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
