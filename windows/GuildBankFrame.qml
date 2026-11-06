// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: guildBankFrame
    name: "GuildBankFrame"
    width: 769
    height: 444

    // the slots, logs and info 27 higher than Blizzard's: as far from the band
    // as from the foot's iron bar
    Frame {
        id: guildBankColumn1
        name: "GuildBankColumn1"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: 30
        anchors.top: guildBankFrame.top
        anchors.topMargin: 43
        width: 100
        height: 311
    }

    Button {
        id: guildBankColumn1Button1
        name: "GuildBankColumn1Button1"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn1.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    FontString {
        id: guildBankColumn1Button1Count
        name: "GuildBankColumn1Button1Count"
        text: "2"
        wowParent: "GuildBankColumn1Button1"
        anchors.right: guildBankColumn1Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button1.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Frame {
        id: guildBankColumn2
        name: "GuildBankColumn2"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn1.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn1.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn3
        name: "GuildBankColumn3"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn2.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn2.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn4
        name: "GuildBankColumn4"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn3.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn3.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn5
        name: "GuildBankColumn5"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn4.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn4.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn6
        name: "GuildBankColumn6"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn5.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn5.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankColumn7
        name: "GuildBankColumn7"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn6.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn6.top
        width: 100
        height: 311
    }

    Frame {
        id: guildBankEmblemFrame
        name: "GuildBankEmblemFrame"
        wowParent: "GuildBankFrame"
        anchors.horizontalCenter: guildBankFrameDiabolicBorder.horizontalCenter
        anchors.horizontalCenterOffset: -70
        anchors.bottom: guildBankFrameDiabolicBorder.top
        anchors.bottomMargin: -15
        width: 700
        height: 80
    }

    Button {
        id: guildBankFrameDepositButton
        name: "GuildBankFrameDepositButton"
        text: "Deposit"
        wowParent: "GuildBankFrame"
        style: "Button"
        pin: "all"
        anchors.left: guildBankFrameWithdrawButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: guildBankFrameWithdrawButton.verticalCenter
        width: 94.5
        height: 21
    }

    FontString {
        id: guildBankFrameDepositButtonText
        name: "GuildBankFrameDepositButtonText"
        text: "Deposit"
        wowParent: "GuildBankFrameDepositButton"
        anchors.horizontalCenter: guildBankFrameDepositButton.horizontalCenter
        anchors.verticalCenter: guildBankFrameDepositButton.verticalCenter
        width: 56.1
        height: 11.9
    }

    Frame {
        id: guildBankFrameDiabolic
        name: "GuildBankFrameDiabolic"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: -24
        anchors.top: guildBankFrame.top
        anchors.topMargin: -28
        width: 817
        height: 508
    }

    Frame {
        id: guildBankFrameDiabolicBorder
        name: "GuildBankFrameDiabolicBorder"
        wowParent: "GuildBankFrameDiabolic"
        anchors.left: guildBankFrameDiabolic.left
        anchors.top: guildBankFrameDiabolic.top
        anchors.topMargin: 32
        width: 817
        height: 476
    }

    Frame {
        id: guildBankFrameDiabolicFoot
        name: "GuildBankFrameDiabolicFoot"
        wowParent: "GuildBankFrameDiabolic"
        anchors.horizontalCenter: guildBankFrameDepositButton.horizontalCenter
        anchors.horizontalCenterOffset: -325.7
        anchors.top: guildBankFrameDepositButton.top
        anchors.topMargin: -6
        width: 771
        height: 77
    }

    Frame {
        id: guildBankFrameDiabolicRail
        name: "GuildBankFrameDiabolicRail"
        wowParent: "GuildBankFrameDiabolic"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Frame {
        id: guildBankFrameDiabolicSocket
        name: "GuildBankFrameDiabolicSocket"
        wowParent: "GuildBankFrameDiabolic"
        anchors.right: guildBankFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: guildBankFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: guildBankFrameDiabolicTitlePlate
        name: "GuildBankFrameDiabolicTitlePlate"
        wowParent: "GuildBankFrameDiabolic"
        anchors.horizontalCenter: guildBankFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: guildBankFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Frame {
        id: guildBankFrameLog
        name: "GuildBankFrameLog"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: guildBankFrame.left
        anchors.top: guildBankFrame.top
        anchors.topMargin: -27
        width: 10
        height: 10
    }

    Button {
        id: guildBankFrameTab1
        name: "GuildBankFrameTab1"
        text: "Guild Bank"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: guildBankFrameTab2
        name: "GuildBankFrameTab2"
        text: "Log"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: guildBankFrameTab3
        name: "GuildBankFrameTab3"
        text: "Money Log"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: guildBankFrameTab4
        name: "GuildBankFrameTab4"
        text: "Info"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: guildBankFrameWithdrawButton
        name: "GuildBankFrameWithdrawButton"
        text: "Withdraw"
        wowParent: "GuildBankFrame"
        style: "Button"
        pin: "all"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 585
        anchors.bottom: guildBankFrameDiabolic.bottom
        anchors.bottomMargin: 73
        width: 94.5
        height: 21
    }

    FontString {
        id: guildBankFrameWithdrawButtonText
        name: "GuildBankFrameWithdrawButtonText"
        text: "Withdraw"
        wowParent: "GuildBankFrameWithdrawButton"
        anchors.horizontalCenter: guildBankFrameWithdrawButton.horizontalCenter
        anchors.verticalCenter: guildBankFrameWithdrawButton.verticalCenter
        width: 76.6
        height: 11.9
    }

    Frame {
        id: guildBankInfo
        name: "GuildBankInfo"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: 33
        anchors.top: guildBankFrame.top
        anchors.topMargin: 46
        width: 10
        height: 10
    }

    // the info's page the logs' size, in the same place
    ScrollFrame {
        id: guildBankInfoScrollFrame
        name: "GuildBankInfoScrollFrame"
        wowParent: "GuildBankInfo"
        pin: "size"
        anchors.left: guildBankInfo.left
        anchors.top: guildBankInfo.top
        width: 688
        height: 304
    }

    Frame {
        id: guildBankInfoScrollFrameDiabolicPanel
        name: "GuildBankInfoScrollFrameDiabolicPanel"
        wowParent: "GuildBankInfo"
        anchors.left: guildBankInfoScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: guildBankInfoScrollFrame.top
        anchors.topMargin: -6
        width: 730
        height: 316
    }

    Frame {
        id: guildBankInfoScrollFrameDiabolicParchment
        name: "GuildBankInfoScrollFrameDiabolicParchment"
        wowParent: "GuildBankInfo"
        anchors.left: guildBankInfoScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: guildBankInfoScrollFrame.top
        anchors.topMargin: -4
        width: 726
        height: 312
    }

    Slider {
        id: guildBankInfoScrollFrameScrollBar
        name: "GuildBankInfoScrollFrameScrollBar"
        wowParent: "GuildBankInfoScrollFrame"
        style: "ScrollBar"
        anchors.left: guildBankInfoScrollFrame.right
        anchors.leftMargin: 4
        anchors.top: guildBankInfoScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 272
    }

    Frame {
        id: guildBankInfoScrollFrameScrollBarDiabolicTrack
        name: "GuildBankInfoScrollFrameScrollBarDiabolicTrack"
        wowParent: "GuildBankInfoScrollFrameScrollBar"
        anchors.horizontalCenter: guildBankInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildBankInfoScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 306
    }

    Button {
        id: guildBankInfoScrollFrameScrollBarScrollDownButton
        name: "GuildBankInfoScrollFrameScrollBarScrollDownButton"
        wowParent: "GuildBankInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankInfoScrollFrameScrollBar.horizontalCenter
        anchors.top: guildBankInfoScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: guildBankInfoScrollFrameScrollBarScrollUpButton
        name: "GuildBankInfoScrollFrameScrollBarScrollUpButton"
        wowParent: "GuildBankInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankInfoScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildBankInfoScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    FontString {
        id: guildBankLimitLabel
        name: "GuildBankLimitLabel"
        wowParent: "GuildBankFrame"
        anchors.horizontalCenter: guildBankTabLimitBackground.horizontalCenter
        anchors.verticalCenter: guildBankTabLimitBackground.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 254.4
        height: 10.3
    }

    ScrollingMessageFrame {
        id: guildBankMessageFrame
        name: "GuildBankMessageFrame"
        wowParent: "GuildBankFrameLog"
        anchors.left: guildBankFrameLog.left
        anchors.leftMargin: 33
        anchors.top: guildBankFrameLog.top
        anchors.topMargin: 73
        width: 688
        height: 304
    }

    Frame {
        id: guildBankMessageFrameDiabolicPanel
        name: "GuildBankMessageFrameDiabolicPanel"
        wowParent: "GuildBankFrameLog"
        anchors.left: guildBankMessageFrame.left
        anchors.leftMargin: -16
        anchors.top: guildBankMessageFrame.top
        anchors.topMargin: -6
        width: 730
        height: 316
    }

    Frame {
        id: guildBankMessageFrameDiabolicParchment
        name: "GuildBankMessageFrameDiabolicParchment"
        wowParent: "GuildBankFrameLog"
        anchors.left: guildBankMessageFrame.left
        anchors.leftMargin: -14
        anchors.top: guildBankMessageFrame.top
        anchors.topMargin: -4
        width: 726
        height: 312
    }

    Frame {
        id: guildBankMoneyFrame
        name: "GuildBankMoneyFrame"
        wowParent: "GuildBankFrame"
        anchors.right: guildBankFrame.right
        anchors.rightMargin: 4
        anchors.bottom: guildBankFrame.bottom
        anchors.bottomMargin: 16
        width: 126.4
        height: 13
    }

    Button {
        id: guildBankMoneyFrameCopperButton
        name: "GuildBankMoneyFrameCopperButton"
        text: "6"
        wowParent: "GuildBankMoneyFrame"
        anchors.right: guildBankMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrame.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: guildBankMoneyFrameCopperButtonText
        name: "GuildBankMoneyFrameCopperButtonText"
        text: "6"
        wowParent: "GuildBankMoneyFrameCopperButton"
        anchors.right: guildBankMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Button {
        id: guildBankMoneyFrameGoldButton
        name: "GuildBankMoneyFrameGoldButton"
        text: "12008"
        wowParent: "GuildBankMoneyFrame"
        anchors.right: guildBankMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: guildBankMoneyFrameSilverButton.verticalCenter
        width: 51.7
        height: 13
    }

    FontString {
        id: guildBankMoneyFrameGoldButtonText
        name: "GuildBankMoneyFrameGoldButtonText"
        text: "12008"
        wowParent: "GuildBankMoneyFrameGoldButton"
        anchors.right: guildBankMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrameGoldButton.verticalCenter
        width: 38.7
        height: 14.2
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
    }

    FontString {
        id: guildBankMoneyFrameSilverButtonText
        name: "GuildBankMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "GuildBankMoneyFrameSilverButton"
        anchors.right: guildBankMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    FontString {
        id: guildBankMoneyLimitLabel
        name: "GuildBankMoneyLimitLabel"
        text: "Available Amount:"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: 26
        anchors.bottom: guildBankFrame.bottom
        anchors.bottomMargin: 16
        width: 98
        height: 13
    }

    Frame {
        id: guildBankTab1
        name: "GuildBankTab1"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankFrame.right
        anchors.leftMargin: -1
        anchors.top: guildBankFrame.top
        anchors.topMargin: 32
        width: 42
        height: 50
    }

    CheckButton {
        id: guildBankTab1Button
        name: "GuildBankTab1Button"
        wowParent: "GuildBankTab1"
        anchors.left: guildBankTab1.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab1.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Frame {
        id: guildBankTab2
        name: "GuildBankTab2"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab1.left
        anchors.top: guildBankTab1.bottom
        width: 42
        height: 50
    }

    CheckButton {
        id: guildBankTab2Button
        name: "GuildBankTab2Button"
        wowParent: "GuildBankTab2"
        anchors.left: guildBankTab2.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab2.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Frame {
        id: guildBankTab3
        name: "GuildBankTab3"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab2.left
        anchors.top: guildBankTab2.bottom
        width: 42
        height: 50
    }

    CheckButton {
        id: guildBankTab3Button
        name: "GuildBankTab3Button"
        wowParent: "GuildBankTab3"
        anchors.left: guildBankTab3.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab3.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Frame {
        id: guildBankTab4
        name: "GuildBankTab4"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab3.left
        anchors.top: guildBankTab3.bottom
        width: 42
        height: 50
    }

    CheckButton {
        id: guildBankTab4Button
        name: "GuildBankTab4Button"
        wowParent: "GuildBankTab4"
        anchors.left: guildBankTab4.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab4.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Frame {
        id: guildBankTab5
        name: "GuildBankTab5"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab4.left
        anchors.top: guildBankTab4.bottom
        width: 42
        height: 50
    }

    CheckButton {
        id: guildBankTab5Button
        name: "GuildBankTab5Button"
        wowParent: "GuildBankTab5"
        anchors.left: guildBankTab5.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab5.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Frame {
        id: guildBankTab6
        name: "GuildBankTab6"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab5.left
        anchors.top: guildBankTab5.bottom
        width: 42
        height: 50
    }

    CheckButton {
        id: guildBankTab6Button
        name: "GuildBankTab6Button"
        wowParent: "GuildBankTab6"
        anchors.left: guildBankTab6.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab6.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    EditBox {
        id: guildBankTabInfoEditBox
        name: "GuildBankTabInfoEditBox"
        wowParent: "GuildBankInfoScrollFrame"
        pin: "size"
        anchors.left: guildBankInfoScrollFrame.left
        anchors.top: guildBankInfoScrollFrame.top
        width: 688
        height: 218
    }

    ScrollFrame {
        id: guildBankTransactionsScrollFrame
        name: "GuildBankTransactionsScrollFrame"
        wowParent: "GuildBankFrameLog"
        pin: "place"
        anchors.right: guildBankFrame.right
        anchors.rightMargin: 50
        anchors.top: guildBankFrame.top
        anchors.topMargin: 48
        width: 688
        height: 304
    }

    Slider {
        id: guildBankTransactionsScrollFrameScrollBar
        name: "GuildBankTransactionsScrollFrameScrollBar"
        wowParent: "GuildBankTransactionsScrollFrame"
        style: "ScrollBar"
        anchors.left: guildBankTransactionsScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: guildBankTransactionsScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 272
    }

    Frame {
        id: guildBankTransactionsScrollFrameScrollBarDiabolicTrack
        name: "GuildBankTransactionsScrollFrameScrollBarDiabolicTrack"
        wowParent: "GuildBankTransactionsScrollFrameScrollBar"
        anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildBankTransactionsScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 306
    }

    Button {
        id: guildBankTransactionsScrollFrameScrollBarScrollDownButton
        name: "GuildBankTransactionsScrollFrameScrollBarScrollDownButton"
        wowParent: "GuildBankTransactionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBar.horizontalCenter
        anchors.top: guildBankTransactionsScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: guildBankTransactionsScrollFrameScrollBarScrollUpButton
        name: "GuildBankTransactionsScrollFrameScrollBarScrollUpButton"
        wowParent: "GuildBankTransactionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildBankTransactionsScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Frame {
        id: guildBankTransactionsScrollFrameScrollChildFrame
        name: "GuildBankTransactionsScrollFrameScrollChildFrame"
        wowParent: "GuildBankTransactionsScrollFrame"
        anchors.left: guildBankTransactionsScrollFrame.left
        anchors.top: guildBankTransactionsScrollFrame.top
        width: 300
        height: 325
    }

    Frame {
        id: guildBankWithdrawMoneyFrame
        name: "GuildBankWithdrawMoneyFrame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankMoneyLimitLabel.right
        anchors.leftMargin: 13
        anchors.verticalCenter: guildBankMoneyLimitLabel.verticalCenter
        width: 36.3
        height: 13
    }

    Button {
        id: guildBankWithdrawMoneyFrameCopperButton
        name: "GuildBankWithdrawMoneyFrameCopperButton"
        text: "0"
        wowParent: "GuildBankWithdrawMoneyFrame"
        anchors.right: guildBankWithdrawMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankWithdrawMoneyFrame.verticalCenter
        width: 23.3
        height: 13
    }

    FontString {
        id: guildBankWithdrawMoneyFrameCopperButtonText
        name: "GuildBankWithdrawMoneyFrameCopperButtonText"
        text: "0"
        wowParent: "GuildBankWithdrawMoneyFrameCopperButton"
        anchors.right: guildBankWithdrawMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankWithdrawMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    WowRow {
        name: "GuildBankButtons"
        parts: ["GuildBankFrameWithdrawButton", "GuildBankFrameDepositButton"]
        fit: "equal"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 585
        anchors.right: guildBankFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: guildBankFrameDiabolic.bottom
        anchors.bottomMargin: 73
    }

    Ghost { id: guildBankTabLimitBackground; name: "GuildBankTabLimitBackground"; x: 390.5; y: 397; width: 0; height: 0 }
}
