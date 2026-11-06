// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: mailFrame
    name: "MailFrame"
    width: 384
    height: 512

    Frame {
        id: autoCompleteBox
        name: "AutoCompleteBox"
        wowParent: "SendMailNameEditBox"
        anchors.left: sendMailNameEditBox.left
        anchors.top: sendMailNameEditBox.bottom
        anchors.topMargin: -3
        width: 120
        height: 105
    }

    Button {
        id: autoCompleteButton1
        name: "AutoCompleteButton1"
        text: "Acta"
        wowParent: "AutoCompleteBox"
        anchors.left: autoCompleteBox.left
        anchors.top: autoCompleteBox.top
        anchors.topMargin: 10
        width: 120
        height: 14
    }

    FontString {
        id: autoCompleteButton1Text
        name: "AutoCompleteButton1Text"
        text: "Acta"
        wowParent: "AutoCompleteButton1"
        anchors.left: autoCompleteButton1.left
        anchors.leftMargin: 15
        anchors.verticalCenter: autoCompleteButton1.verticalCenter
        anchors.verticalCenterOffset: -0.1
        width: 29.2
        height: 11.9
    }

    Button {
        id: autoCompleteButton2
        name: "AutoCompleteButton2"
        text: "Adoradear"
        wowParent: "AutoCompleteBox"
        anchors.left: autoCompleteButton1.left
        anchors.top: autoCompleteButton1.bottom
        width: 120
        height: 14
    }

    FontString {
        id: autoCompleteButton2Text
        name: "AutoCompleteButton2Text"
        text: "Adoradear"
        wowParent: "AutoCompleteButton2"
        anchors.left: autoCompleteButton2.left
        anchors.leftMargin: 15
        anchors.verticalCenter: autoCompleteButton2.verticalCenter
        anchors.verticalCenterOffset: -0.1
        width: 65.6
        height: 11.9
    }

    Button {
        id: autoCompleteButton3
        name: "AutoCompleteButton3"
        text: "Aeriana"
        wowParent: "AutoCompleteBox"
        anchors.left: autoCompleteButton2.left
        anchors.top: autoCompleteButton2.bottom
        width: 120
        height: 14
    }

    FontString {
        id: autoCompleteButton3Text
        name: "AutoCompleteButton3Text"
        text: "Aeriana"
        wowParent: "AutoCompleteButton3"
        anchors.left: autoCompleteButton3.left
        anchors.leftMargin: 15
        anchors.verticalCenter: autoCompleteButton3.verticalCenter
        anchors.verticalCenterOffset: -0.1
        width: 47.4
        height: 11.9
    }

    Button {
        id: autoCompleteButton4
        name: "AutoCompleteButton4"
        text: "Aishidin"
        wowParent: "AutoCompleteBox"
        anchors.left: autoCompleteButton3.left
        anchors.top: autoCompleteButton3.bottom
        width: 120
        height: 14
    }

    FontString {
        id: autoCompleteButton4Text
        name: "AutoCompleteButton4Text"
        text: "Aishidin"
        wowParent: "AutoCompleteButton4"
        anchors.left: autoCompleteButton4.left
        anchors.leftMargin: 15
        anchors.verticalCenter: autoCompleteButton4.verticalCenter
        anchors.verticalCenterOffset: -0.1
        width: 49
        height: 11.9
    }

    Button {
        id: autoCompleteButton5
        name: "AutoCompleteButton5"
        text: "..."
        wowParent: "AutoCompleteBox"
        anchors.left: autoCompleteButton4.left
        anchors.top: autoCompleteButton4.bottom
        width: 120
        height: 14
    }

    FontString {
        id: autoCompleteButton5Text
        name: "AutoCompleteButton5Text"
        text: "..."
        wowParent: "AutoCompleteButton5"
        anchors.left: autoCompleteButton5.left
        anchors.leftMargin: 15
        anchors.verticalCenter: autoCompleteButton5.verticalCenter
        anchors.verticalCenterOffset: -0.1
        width: 10.3
        height: 11.9
    }

    FontString {
        id: autoCompleteInstructions
        name: "AutoCompleteInstructions"
        wowParent: "AutoCompleteBox"
        anchors.left: autoCompleteBox.left
        anchors.leftMargin: 15
        anchors.bottom: autoCompleteBox.bottom
        anchors.bottomMargin: 10
        width: 51.4
        height: 10.3
    }

    Button {
        id: inboxCloseButton
        name: "InboxCloseButton"
        wowParent: "MailFrame"
        style: "CloseButton"
        anchors.horizontalCenter: mailFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: mailFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    FontString {
        id: inboxCurrentPage
        name: "InboxCurrentPage"
        wowParent: "InboxFrame"
        pin: "place"
        anchors.horizontalCenter: inboxFrame.horizontalCenter
        anchors.horizontalCenterOffset: -14
        anchors.bottom: inboxFrame.bottom
        anchors.bottomMargin: 72
        width: 192
        height: 1
    }

    Frame {
        id: inboxFrame
        name: "InboxFrame"
        wowParent: "MailFrame"
        anchors.left: mailFrame.left
        anchors.top: mailFrame.top
        width: 384
        height: 512
    }

    Button {
        id: inboxNextPageButton
        name: "InboxNextPageButton"
        wowParent: "InboxFrame"
        pin: "place"
        anchors.horizontalCenter: inboxFrame.left
        anchors.horizontalCenterOffset: 314
        anchors.verticalCenter: inboxFrame.bottom
        anchors.verticalCenterOffset: -80
        width: 26
        height: 26
    }

    Button {
        id: inboxPrevPageButton
        name: "InboxPrevPageButton"
        wowParent: "InboxFrame"
        pin: "place"
        anchors.horizontalCenter: inboxFrame.left
        anchors.horizontalCenterOffset: 50
        anchors.verticalCenter: inboxFrame.bottom
        anchors.verticalCenterOffset: -80
        width: 26
        height: 26
    }

    FontString {
        id: inboxTitleText
        name: "InboxTitleText"
        text: "Inbox"
        wowParent: "InboxFrame"
        anchors.horizontalCenter: inboxFrame.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: inboxFrame.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 224
        height: 14
    }

    Frame {
        id: mailFrameDiabolic
        name: "MailFrameDiabolic"
        wowParent: "MailFrame"
        anchors.left: mailFrame.left
        anchors.leftMargin: -16
        anchors.top: mailFrame.top
        anchors.topMargin: -68
        width: 400
        height: 540
    }

    Frame {
        id: mailFrameDiabolicBand
        name: "MailFrameDiabolicBand"
        wowParent: "MailFrameDiabolic"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: mailFrameDiabolic.top
        anchors.topMargin: 56
        width: 352
        height: 40
    }

    Frame {
        id: mailFrameDiabolicBorder
        name: "MailFrameDiabolicBorder"
        wowParent: "MailFrameDiabolic"
        anchors.left: mailFrameDiabolic.left
        anchors.top: mailFrameDiabolic.top
        anchors.topMargin: 32
        width: 400
        height: 508
    }

    Frame {
        id: mailFrameDiabolicFoot
        name: "MailFrameDiabolicFoot"
        wowParent: "MailFrameDiabolic"
        anchors.horizontalCenter: inboxPrevPageButton.horizontalCenter
        anchors.horizontalCenterOffset: 134
        anchors.top: inboxPrevPageButton.top
        anchors.topMargin: -6
        width: 354
        height: 36
    }

    Frame {
        id: mailFrameDiabolicRail
        name: "MailFrameDiabolicRail"
        wowParent: "MailFrameDiabolic"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: mailFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 130
        height: 18
    }

    Frame {
        id: mailFrameDiabolicSocket
        name: "MailFrameDiabolicSocket"
        wowParent: "MailFrameDiabolic"
        anchors.right: mailFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: mailFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: mailFrameDiabolicTitlePlate
        name: "MailFrameDiabolicTitlePlate"
        wowParent: "MailFrameDiabolic"
        anchors.horizontalCenter: mailFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: mailFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: mailFrameTab1
        name: "MailFrameTab1"
        text: "Inbox"
        wowParent: "MailFrame"
        style: "Banner"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: mailFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: mailFrameTab2
        name: "MailFrameTab2"
        text: "Send Mail"
        wowParent: "MailFrame"
        style: "Banner"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: mailFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        id: mailItem1
        name: "MailItem1"
        wowParent: "InboxFrame"
        anchors.left: inboxFrame.left
        anchors.leftMargin: 48
        anchors.top: inboxFrame.top
        anchors.topMargin: 44
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem1Button
        name: "MailItem1Button"
        wowParent: "MailItem1"
        anchors.left: mailItem1.left
        anchors.leftMargin: 4
        anchors.top: mailItem1.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Button {
        id: mailItem1ExpireTime
        name: "MailItem1ExpireTime"
        text: "28 Days "
        wowParent: "MailItem1"
        anchors.right: mailItem1.right
        anchors.rightMargin: -10
        anchors.top: mailItem1.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem1Sender
        name: "MailItem1Sender"
        text: "Brew of the Month Club"
        wowParent: "MailItem1"
        anchors.left: mailItem1.left
        anchors.leftMargin: 47
        anchors.top: mailItem1.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem1Subject
        name: "MailItem1Subject"
        text: "Fun For You And Your Friends"
        wowParent: "MailItem1"
        anchors.left: mailItem1Sender.left
        anchors.top: mailItem1Sender.bottom
        width: 248
        height: 18
    }

    Frame {
        id: mailItem2
        name: "MailItem2"
        wowParent: "InboxFrame"
        anchors.left: mailItem1.left
        anchors.top: mailItem1.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem2Button
        name: "MailItem2Button"
        wowParent: "MailItem2"
        anchors.left: mailItem2.left
        anchors.leftMargin: 4
        anchors.top: mailItem2.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Button {
        id: mailItem2ExpireTime
        name: "MailItem2ExpireTime"
        text: "3627 Days "
        wowParent: "MailItem2"
        anchors.right: mailItem2.right
        anchors.rightMargin: -10
        anchors.top: mailItem2.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem2Sender
        name: "MailItem2Sender"
        text: "Customer Support"
        wowParent: "MailItem2"
        anchors.left: mailItem2.left
        anchors.leftMargin: 47
        anchors.top: mailItem2.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem2Subject
        name: "MailItem2Subject"
        text: "Recovered items"
        wowParent: "MailItem2"
        anchors.left: mailItem2Sender.left
        anchors.top: mailItem2Sender.bottom
        width: 248
        height: 18
    }

    Frame {
        id: mailItem3
        name: "MailItem3"
        wowParent: "InboxFrame"
        anchors.left: mailItem2.left
        anchors.top: mailItem2.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem3Button
        name: "MailItem3Button"
        wowParent: "MailItem3"
        anchors.left: mailItem3.left
        anchors.leftMargin: 4
        anchors.top: mailItem3.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Button {
        id: mailItem3ExpireTime
        name: "MailItem3ExpireTime"
        text: "3627 Days "
        wowParent: "MailItem3"
        anchors.right: mailItem3.right
        anchors.rightMargin: -10
        anchors.top: mailItem3.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem3Sender
        name: "MailItem3Sender"
        wowParent: "MailItem3"
        anchors.left: mailItem3.left
        anchors.leftMargin: 47
        anchors.top: mailItem3.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem3Subject
        name: "MailItem3Subject"
        wowParent: "MailItem3"
        anchors.left: mailItem3Sender.left
        anchors.top: mailItem3Sender.bottom
        width: 248
        height: 18
    }

    Frame {
        id: mailItem4
        name: "MailItem4"
        wowParent: "InboxFrame"
        anchors.left: mailItem3.left
        anchors.top: mailItem3.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem4Button
        name: "MailItem4Button"
        wowParent: "MailItem4"
        anchors.left: mailItem4.left
        anchors.leftMargin: 4
        anchors.top: mailItem4.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Button {
        id: mailItem4ExpireTime
        name: "MailItem4ExpireTime"
        text: "3627 Days "
        wowParent: "MailItem4"
        anchors.right: mailItem4.right
        anchors.rightMargin: -10
        anchors.top: mailItem4.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem4Sender
        name: "MailItem4Sender"
        wowParent: "MailItem4"
        anchors.left: mailItem4.left
        anchors.leftMargin: 47
        anchors.top: mailItem4.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem4Subject
        name: "MailItem4Subject"
        wowParent: "MailItem4"
        anchors.left: mailItem4Sender.left
        anchors.top: mailItem4Sender.bottom
        width: 248
        height: 18
    }

    Frame {
        id: mailItem5
        name: "MailItem5"
        wowParent: "InboxFrame"
        anchors.left: mailItem4.left
        anchors.top: mailItem4.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem5Button
        name: "MailItem5Button"
        wowParent: "MailItem5"
        anchors.left: mailItem5.left
        anchors.leftMargin: 4
        anchors.top: mailItem5.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Button {
        id: mailItem5ExpireTime
        name: "MailItem5ExpireTime"
        text: "24 Days "
        wowParent: "MailItem5"
        anchors.right: mailItem5.right
        anchors.rightMargin: -10
        anchors.top: mailItem5.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem5Sender
        name: "MailItem5Sender"
        wowParent: "MailItem5"
        anchors.left: mailItem5.left
        anchors.leftMargin: 47
        anchors.top: mailItem5.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem5Subject
        name: "MailItem5Subject"
        wowParent: "MailItem5"
        anchors.left: mailItem5Sender.left
        anchors.top: mailItem5Sender.bottom
        width: 248
        height: 18
    }

    Frame {
        id: mailItem6
        name: "MailItem6"
        wowParent: "InboxFrame"
        anchors.left: mailItem5.left
        anchors.top: mailItem5.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem6Button
        name: "MailItem6Button"
        wowParent: "MailItem6"
        anchors.left: mailItem6.left
        anchors.leftMargin: 4
        anchors.top: mailItem6.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    FontString {
        id: mailItem6ButtonCount
        name: "MailItem6ButtonCount"
        text: "3"
        wowParent: "MailItem6Button"
        anchors.right: mailItem6Button.right
        anchors.rightMargin: 5
        anchors.bottom: mailItem6Button.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: mailItem6ExpireTime
        name: "MailItem6ExpireTime"
        text: "24 Days "
        wowParent: "MailItem6"
        anchors.right: mailItem6.right
        anchors.rightMargin: -10
        anchors.top: mailItem6.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem6Sender
        name: "MailItem6Sender"
        wowParent: "MailItem6"
        anchors.left: mailItem6.left
        anchors.leftMargin: 47
        anchors.top: mailItem6.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem6Subject
        name: "MailItem6Subject"
        wowParent: "MailItem6"
        anchors.left: mailItem6Sender.left
        anchors.top: mailItem6Sender.bottom
        width: 248
        height: 18
    }

    Frame {
        id: mailItem7
        name: "MailItem7"
        wowParent: "InboxFrame"
        anchors.left: mailItem6.left
        anchors.top: mailItem6.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    CheckButton {
        id: mailItem7Button
        name: "MailItem7Button"
        wowParent: "MailItem7"
        anchors.left: mailItem7.left
        anchors.leftMargin: 4
        anchors.top: mailItem7.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Button {
        id: mailItem7ExpireTime
        name: "MailItem7ExpireTime"
        text: "24 Days "
        wowParent: "MailItem7"
        anchors.right: mailItem7.right
        anchors.rightMargin: -10
        anchors.top: mailItem7.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    FontString {
        id: mailItem7Sender
        name: "MailItem7Sender"
        wowParent: "MailItem7"
        anchors.left: mailItem7.left
        anchors.leftMargin: 47
        anchors.top: mailItem7.top
        anchors.topMargin: 4
        width: 200
        height: 16
    }

    FontString {
        id: mailItem7Subject
        name: "MailItem7Subject"
        wowParent: "MailItem7"
        anchors.left: mailItem7Sender.left
        anchors.top: mailItem7Sender.bottom
        width: 248
        height: 18
    }

    CheckButton {
        id: postalInboxCB1
        name: "PostalInboxCB1"
        wowParent: "MailItem1"
        anchors.right: mailItem1.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem1.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB1Text
        name: "PostalInboxCB1Text"
        text: "1"
        wowParent: "PostalInboxCB1"
        anchors.horizontalCenter: postalInboxCB1.horizontalCenter
        anchors.bottom: postalInboxCB1.top
        width: 6.3
        height: 10.3
    }

    CheckButton {
        id: postalInboxCB2
        name: "PostalInboxCB2"
        wowParent: "MailItem2"
        anchors.right: mailItem2.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem2.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB2Text
        name: "PostalInboxCB2Text"
        text: "2"
        wowParent: "PostalInboxCB2"
        anchors.horizontalCenter: postalInboxCB2.horizontalCenter
        anchors.bottom: postalInboxCB2.top
        width: 7.9
        height: 10.3
    }

    CheckButton {
        id: postalInboxCB3
        name: "PostalInboxCB3"
        wowParent: "MailItem3"
        anchors.right: mailItem3.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem3.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB3Text
        name: "PostalInboxCB3Text"
        text: "3"
        wowParent: "PostalInboxCB3"
        anchors.horizontalCenter: postalInboxCB3.horizontalCenter
        anchors.bottom: postalInboxCB3.top
        width: 7.9
        height: 10.3
    }

    CheckButton {
        id: postalInboxCB4
        name: "PostalInboxCB4"
        wowParent: "MailItem4"
        anchors.right: mailItem4.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem4.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB4Text
        name: "PostalInboxCB4Text"
        text: "4"
        wowParent: "PostalInboxCB4"
        anchors.horizontalCenter: postalInboxCB4.horizontalCenter
        anchors.bottom: postalInboxCB4.top
        width: 8.7
        height: 10.3
    }

    CheckButton {
        id: postalInboxCB5
        name: "PostalInboxCB5"
        wowParent: "MailItem5"
        anchors.right: mailItem5.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem5.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB5Text
        name: "PostalInboxCB5Text"
        text: "5"
        wowParent: "PostalInboxCB5"
        anchors.horizontalCenter: postalInboxCB5.horizontalCenter
        anchors.bottom: postalInboxCB5.top
        width: 7.9
        height: 10.3
    }

    CheckButton {
        id: postalInboxCB6
        name: "PostalInboxCB6"
        wowParent: "MailItem6"
        anchors.right: mailItem6.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem6.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB6Text
        name: "PostalInboxCB6Text"
        text: "6"
        wowParent: "PostalInboxCB6"
        anchors.horizontalCenter: postalInboxCB6.horizontalCenter
        anchors.bottom: postalInboxCB6.top
        width: 7.9
        height: 10.3
    }

    CheckButton {
        id: postalInboxCB7
        name: "PostalInboxCB7"
        wowParent: "MailItem7"
        anchors.right: mailItem7.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem7.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    FontString {
        id: postalInboxCB7Text
        name: "PostalInboxCB7Text"
        text: "7"
        wowParent: "PostalInboxCB7"
        anchors.horizontalCenter: postalInboxCB7.horizontalCenter
        anchors.bottom: postalInboxCB7.top
        width: 7.9
        height: 10.3
    }

    Button {
        id: postalOpenAllButton
        name: "PostalOpenAllButton"
        text: "Open All"
        wowParent: "InboxFrame"
        style: "Button"
        anchors.horizontalCenter: inboxFrame.horizontalCenter
        anchors.horizontalCenterOffset: -22
        anchors.verticalCenter: inboxFrame.top
        anchors.verticalCenterOffset: 432
        width: 120
        height: 25
    }

    FontString {
        id: postalOpenAllButtonText
        name: "PostalOpenAllButtonText"
        text: "Open All"
        wowParent: "PostalOpenAllButton"
        anchors.horizontalCenter: postalOpenAllButton.horizontalCenter
        anchors.verticalCenter: postalOpenAllButton.verticalCenter
        width: 64
        height: 11.9
    }

    Button {
        id: postalSelectOpenButton
        name: "PostalSelectOpenButton"
        text: "Open"
        wowParent: "InboxFrame"
        style: "Button"
        anchors.right: mailFrameDiabolicBand.horizontalCenter
        anchors.rightMargin: 4
        anchors.verticalCenter: mailFrameDiabolicBand.verticalCenter
        width: 110
        height: 25
    }

    FontString {
        id: postalSelectOpenButtonText
        name: "PostalSelectOpenButtonText"
        text: "Open"
        wowParent: "PostalSelectOpenButton"
        anchors.horizontalCenter: postalSelectOpenButton.horizontalCenter
        anchors.verticalCenter: postalSelectOpenButton.verticalCenter
        width: 34.8
        height: 11.9
    }

    Button {
        id: postalSelectReturnButton
        name: "PostalSelectReturnButton"
        text: "Return"
        wowParent: "InboxFrame"
        style: "Button"
        anchors.left: mailFrameDiabolicBand.horizontalCenter
        anchors.leftMargin: 4
        anchors.verticalCenter: mailFrameDiabolicBand.verticalCenter
        width: 110
        height: 25
    }

    FontString {
        id: postalSelectReturnButtonText
        name: "PostalSelectReturnButtonText"
        text: "Return"
        wowParent: "PostalSelectReturnButton"
        anchors.horizontalCenter: postalSelectReturnButton.horizontalCenter
        anchors.verticalCenter: postalSelectReturnButton.verticalCenter
        width: 53.7
        height: 11.9
    }

    Button {
        id: postalSubjectHover1
        name: "PostalSubjectHover1"
        wowParent: "MailItem1"
        anchors.left: mailItem1Subject.left
        anchors.top: mailItem1Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postalSubjectHover2
        name: "PostalSubjectHover2"
        wowParent: "MailItem2"
        anchors.left: mailItem2Subject.left
        anchors.top: mailItem2Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postalSubjectHover3
        name: "PostalSubjectHover3"
        wowParent: "MailItem3"
        anchors.left: mailItem3Subject.left
        anchors.top: mailItem3Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postalSubjectHover4
        name: "PostalSubjectHover4"
        wowParent: "MailItem4"
        anchors.left: mailItem4Subject.left
        anchors.top: mailItem4Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postalSubjectHover5
        name: "PostalSubjectHover5"
        wowParent: "MailItem5"
        anchors.left: mailItem5Subject.left
        anchors.top: mailItem5Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postalSubjectHover6
        name: "PostalSubjectHover6"
        wowParent: "MailItem6"
        anchors.left: mailItem6Subject.left
        anchors.top: mailItem6Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postalSubjectHover7
        name: "PostalSubjectHover7"
        wowParent: "MailItem7"
        anchors.left: mailItem7Subject.left
        anchors.top: mailItem7Subject.top
        width: 248
        height: 18
    }

    Button {
        id: postal_BlackBookButton
        name: "Postal_BlackBookButton"
        wowParent: "SendMailFrame"
        anchors.left: sendMailNameEditBox.right
        anchors.leftMargin: 12
        anchors.verticalCenter: sendMailNameEditBox.verticalCenter
        width: 25
        height: 25
    }

    Button {
        id: postal_ModuleMenuButton
        name: "Postal_ModuleMenuButton"
        wowParent: "MailFrame"
        anchors.right: mailFrame.right
        anchors.rightMargin: 53
        anchors.top: mailFrame.top
        anchors.topMargin: -4
        width: 25
        height: 25
    }

    Button {
        id: postal_OpenAllMenuButton
        name: "Postal_OpenAllMenuButton"
        wowParent: "InboxFrame"
        anchors.left: postalOpenAllButton.right
        anchors.leftMargin: -2
        anchors.verticalCenter: postalOpenAllButton.verticalCenter
        width: 30
        height: 30
    }

    Button {
        id: sendMailAttachment1
        name: "SendMailAttachment1"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 32
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment1Count
        name: "SendMailAttachment1Count"
        wowParent: "SendMailAttachment1"
        anchors.right: sendMailAttachment1.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment1.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Button {
        id: sendMailAttachment2
        name: "SendMailAttachment2"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 76
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment2Count
        name: "SendMailAttachment2Count"
        wowParent: "SendMailAttachment2"
        anchors.right: sendMailAttachment2.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment2.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Button {
        id: sendMailAttachment3
        name: "SendMailAttachment3"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 120
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment3Count
        name: "SendMailAttachment3Count"
        wowParent: "SendMailAttachment3"
        anchors.right: sendMailAttachment3.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment3.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Button {
        id: sendMailAttachment4
        name: "SendMailAttachment4"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 164
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment4Count
        name: "SendMailAttachment4Count"
        wowParent: "SendMailAttachment4"
        anchors.right: sendMailAttachment4.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment4.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Button {
        id: sendMailAttachment5
        name: "SendMailAttachment5"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 208
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment5Count
        name: "SendMailAttachment5Count"
        wowParent: "SendMailAttachment5"
        anchors.right: sendMailAttachment5.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment5.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Button {
        id: sendMailAttachment6
        name: "SendMailAttachment6"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 252
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment6Count
        name: "SendMailAttachment6Count"
        wowParent: "SendMailAttachment6"
        anchors.right: sendMailAttachment6.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment6.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    Button {
        id: sendMailAttachment7
        name: "SendMailAttachment7"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 296
        anchors.top: sendMailFrame.bottom
        anchors.topMargin: -201
        width: 37
        height: 37
    }

    FontString {
        id: sendMailAttachment7Count
        name: "SendMailAttachment7Count"
        wowParent: "SendMailAttachment7"
        anchors.right: sendMailAttachment7.right
        anchors.rightMargin: 5
        anchors.bottom: sendMailAttachment7.bottom
        anchors.bottomMargin: 2
        width: 1
        height: 1
    }

    EditBox {
        id: sendMailBodyEditBox
        name: "SendMailBodyEditBox"
        wowParent: "SendMailScrollChildFrame"
        anchors.left: sendMailScrollChildFrame.left
        anchors.leftMargin: 20
        anchors.top: sendMailScrollChildFrame.top
        anchors.topMargin: 10
        width: 270
        height: 15
    }

    CheckButton {
        id: sendMailCODButton
        name: "SendMailCODButton"
        wowParent: "SendMailMoneyButton"
        anchors.left: sendMailSendMoneyButton.left
        anchors.top: sendMailSendMoneyButton.bottom
        anchors.topMargin: -1
        width: 16
        height: 16
    }

    FontString {
        id: sendMailCODButtonText
        name: "SendMailCODButtonText"
        text: "C.O.D."
        wowParent: "SendMailCODButton"
        anchors.left: sendMailCODButton.right
        anchors.leftMargin: 5
        anchors.verticalCenter: sendMailCODButton.verticalCenter
        width: 34.8
        height: 10.3
    }

    Button {
        id: sendMailCancelButton
        name: "SendMailCancelButton"
        text: "Cancel"
        wowParent: "SendMailFrame"
        style: "Button"
        pin: "all"
        anchors.left: sendMailMailButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: sendMailMailButton.verticalCenter
        width: 78
        height: 22
    }

    FontString {
        id: sendMailCancelButtonText
        name: "SendMailCancelButtonText"
        text: "Cancel"
        wowParent: "SendMailCancelButton"
        anchors.horizontalCenter: sendMailCancelButton.horizontalCenter
        anchors.verticalCenter: sendMailCancelButton.verticalCenter
        width: 51.4
        height: 11.9
    }

    Frame {
        id: sendMailCostMoneyFrame
        name: "SendMailCostMoneyFrame"
        wowParent: "SendMailFrame"
        anchors.right: mailFrameDiabolicBand.right
        anchors.rightMargin: 48
        anchors.verticalCenter: mailFrameDiabolicBand.verticalCenter
        width: 43.4
        height: 13
    }

    Button {
        id: sendMailCostMoneyFrameCopperButton
        name: "SendMailCostMoneyFrameCopperButton"
        text: "30"
        wowParent: "SendMailCostMoneyFrame"
        anchors.right: sendMailCostMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: sendMailCostMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: sendMailCostMoneyFrameCopperButtonText
        name: "SendMailCostMoneyFrameCopperButtonText"
        text: "30"
        wowParent: "SendMailCostMoneyFrameCopperButton"
        anchors.right: sendMailCostMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: sendMailCostMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Frame {
        id: sendMailFrame
        name: "SendMailFrame"
        wowParent: "MailFrame"
        anchors.left: mailFrame.left
        anchors.top: mailFrame.top
        width: 384
        height: 512
    }

    Frame {
        id: sendMailFrameDiabolicAttachments
        name: "SendMailFrameDiabolicAttachments"
        wowParent: "SendMailFrame"
        anchors.horizontalCenter: sendMailHorizontalBarLeft2.horizontalCenter
        anchors.top: sendMailHorizontalBarLeft2.top
        anchors.topMargin: 1
        width: 319
        height: 63
    }

    Button {
        id: sendMailMailButton
        name: "SendMailMailButton"
        text: "Send"
        wowParent: "SendMailFrame"
        style: "Button"
        pin: "all"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 201
        anchors.bottom: mailFrameDiabolic.bottom
        anchors.bottomMargin: 40
        width: 78
        height: 22
    }

    FontString {
        id: sendMailMailButtonText
        name: "SendMailMailButtonText"
        text: "Send"
        wowParent: "SendMailMailButton"
        anchors.horizontalCenter: sendMailMailButton.horizontalCenter
        anchors.verticalCenter: sendMailMailButton.verticalCenter
        width: 33.2
        height: 11.9
    }

    Frame {
        id: sendMailMoney
        name: "SendMailMoney"
        wowParent: "SendMailMoneyButton"
        anchors.left: sendMailMoneyText.left
        anchors.leftMargin: 5
        anchors.top: sendMailMoneyText.bottom
        anchors.topMargin: 3
        width: 176
        height: 18
    }

    Frame {
        id: sendMailMoneyButton
        name: "SendMailMoneyButton"
        wowParent: "SendMailFrame"
        pin: "place"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 30
        anchors.bottom: sendMailFrame.bottom
        anchors.bottomMargin: 120
        width: 37
        height: 37
    }

    EditBox {
        id: sendMailMoneyCopper
        name: "SendMailMoneyCopper"
        wowParent: "SendMailMoney"
        anchors.left: sendMailMoneySilver.right
        anchors.leftMargin: 16
        anchors.verticalCenter: sendMailMoneySilver.verticalCenter
        width: 30
        height: 20
    }

    Frame {
        id: sendMailMoneyFrame
        name: "SendMailMoneyFrame"
        wowParent: "SendMailFrame"
        anchors.right: sendMailFrame.left
        anchors.rightMargin: -183
        anchors.bottom: sendMailFrame.bottom
        anchors.bottomMargin: 84
        width: 126.4
        height: 13
    }

    Button {
        id: sendMailMoneyFrameCopperButton
        name: "SendMailMoneyFrameCopperButton"
        text: "79"
        wowParent: "SendMailMoneyFrame"
        anchors.right: sendMailMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: sendMailMoneyFrame.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: sendMailMoneyFrameCopperButtonText
        name: "SendMailMoneyFrameCopperButtonText"
        text: "79"
        wowParent: "SendMailMoneyFrameCopperButton"
        anchors.right: sendMailMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: sendMailMoneyFrameCopperButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Button {
        id: sendMailMoneyFrameGoldButton
        name: "SendMailMoneyFrameGoldButton"
        text: "8146"
        wowParent: "SendMailMoneyFrame"
        anchors.right: sendMailMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: sendMailMoneyFrameSilverButton.verticalCenter
        width: 44.6
        height: 13
    }

    FontString {
        id: sendMailMoneyFrameGoldButtonText
        name: "SendMailMoneyFrameGoldButtonText"
        text: "8146"
        wowParent: "SendMailMoneyFrameGoldButton"
        anchors.right: sendMailMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: sendMailMoneyFrameGoldButton.verticalCenter
        width: 31.6
        height: 14.2
    }

    Button {
        id: sendMailMoneyFrameSilverButton
        name: "SendMailMoneyFrameSilverButton"
        text: "83"
        wowParent: "SendMailMoneyFrame"
        anchors.right: sendMailMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: sendMailMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    FontString {
        id: sendMailMoneyFrameSilverButtonText
        name: "SendMailMoneyFrameSilverButtonText"
        text: "83"
        wowParent: "SendMailMoneyFrameSilverButton"
        anchors.right: sendMailMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: sendMailMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    EditBox {
        id: sendMailMoneyGold
        name: "SendMailMoneyGold"
        wowParent: "SendMailMoney"
        anchors.left: sendMailMoney.left
        anchors.top: sendMailMoney.top
        width: 58
        height: 20
    }

    EditBox {
        id: sendMailMoneySilver
        name: "SendMailMoneySilver"
        wowParent: "SendMailMoney"
        anchors.left: sendMailMoneyGold.right
        anchors.leftMargin: 26
        anchors.verticalCenter: sendMailMoneyGold.verticalCenter
        width: 30
        height: 20
    }

    FontString {
        id: sendMailMoneyText
        name: "SendMailMoneyText"
        text: "Amount to send:"
        wowParent: "SendMailMoneyButton"
        anchors.left: sendMailMoneyButton.left
        anchors.top: sendMailMoneyButton.top
        anchors.topMargin: 5
        width: 88.5
        height: 10.3
    }

    EditBox {
        id: sendMailNameEditBox
        name: "SendMailNameEditBox"
        wowParent: "SendMailFrame"
        style: "EditBox"
        anchors.left: mailFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: mailFrameDiabolicBand.verticalCenter
        width: 86
        height: 20
    }

    Frame {
        id: sendMailNameEditBoxDiabolicField
        name: "SendMailNameEditBoxDiabolicField"
        wowParent: "SendMailNameEditBox"
        anchors.left: sendMailNameEditBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: sendMailNameEditBox.verticalCenter
        width: 102
        height: 22
    }

    Frame {
        id: sendMailScrollChildFrame
        name: "SendMailScrollChildFrame"
        wowParent: "SendMailScrollFrame"
        anchors.left: sendMailScrollFrame.left
        anchors.top: sendMailScrollFrame.top
        width: 300
        height: 240
    }

    ScrollFrame {
        id: sendMailScrollFrame
        name: "SendMailScrollFrame"
        wowParent: "SendMailFrame"
        anchors.left: sendMailFrame.left
        anchors.leftMargin: 21
        anchors.top: sendMailFrame.top
        anchors.topMargin: 42
        width: 296
        height: 240
    }

    Frame {
        id: sendMailScrollFrameDiabolicPanel
        name: "SendMailScrollFrameDiabolicPanel"
        wowParent: "SendMailFrame"
        anchors.left: sendMailScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: sendMailScrollFrame.top
        anchors.topMargin: -6
        width: 330
        height: 252
    }

    Frame {
        id: sendMailScrollFrameDiabolicParchment
        name: "SendMailScrollFrameDiabolicParchment"
        wowParent: "SendMailScrollFrame"
        anchors.left: sendMailScrollFrame.left
        anchors.leftMargin: -4
        anchors.top: sendMailScrollFrame.top
        anchors.topMargin: -4
        width: 304
        height: 248
    }

    Slider {
        id: sendMailScrollFrameScrollBar
        name: "SendMailScrollFrameScrollBar"
        wowParent: "SendMailScrollFrame"
        style: "ScrollBar"
        anchors.left: sendMailScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: sendMailScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 208
    }

    Frame {
        id: sendMailScrollFrameScrollBarDiabolicTrack
        name: "SendMailScrollFrameScrollBarDiabolicTrack"
        wowParent: "SendMailScrollFrameScrollBar"
        anchors.horizontalCenter: sendMailScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: sendMailScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 242
    }

    Button {
        id: sendMailScrollFrameScrollBarScrollDownButton
        name: "SendMailScrollFrameScrollBarScrollDownButton"
        wowParent: "SendMailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: sendMailScrollFrameScrollBar.horizontalCenter
        anchors.top: sendMailScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: sendMailScrollFrameScrollBarScrollUpButton
        name: "SendMailScrollFrameScrollBarScrollUpButton"
        wowParent: "SendMailScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: sendMailScrollFrameScrollBar.horizontalCenter
        anchors.bottom: sendMailScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    CheckButton {
        id: sendMailSendMoneyButton
        name: "SendMailSendMoneyButton"
        wowParent: "SendMailMoneyButton"
        anchors.left: sendMailMoney.right
        anchors.top: sendMailMoney.top
        anchors.topMargin: -12
        width: 16
        height: 16
    }

    FontString {
        id: sendMailSendMoneyButtonText
        name: "SendMailSendMoneyButtonText"
        text: "Send Money"
        wowParent: "SendMailSendMoneyButton"
        anchors.left: sendMailSendMoneyButton.right
        anchors.leftMargin: 5
        anchors.verticalCenter: sendMailSendMoneyButton.verticalCenter
        width: 68
        height: 10.3
    }

    EditBox {
        id: sendMailSubjectEditBox
        name: "SendMailSubjectEditBox"
        wowParent: "SendMailFrame"
        style: "EditBox"
        anchors.left: mailFrameDiabolicBand.left
        anchors.leftMargin: 154
        anchors.verticalCenter: mailFrameDiabolicBand.verticalCenter
        width: 88.6
        height: 20
    }

    Frame {
        id: sendMailSubjectEditBoxDiabolicField
        name: "SendMailSubjectEditBoxDiabolicField"
        wowParent: "SendMailSubjectEditBox"
        anchors.left: sendMailSubjectEditBox.left
        anchors.leftMargin: -8
        anchors.verticalCenter: sendMailSubjectEditBox.verticalCenter
        width: 104.6
        height: 22
    }

    FontString {
        id: sendMailTitleText
        name: "SendMailTitleText"
        text: "Send Mail"
        wowParent: "SendMailFrame"
        anchors.horizontalCenter: sendMailFrame.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: sendMailFrame.verticalCenter
        anchors.verticalCenterOffset: -230
        width: 224
        height: 14
    }

    WowRow {
        name: "SendMailButtons"
        parts: ["SendMailMailButton", "SendMailCancelButton"]
        fit: "equal"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 201
        anchors.right: mailFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: mailFrameDiabolic.bottom
        anchors.bottomMargin: 40
    }

    Ghost { id: sendMailHorizontalBarLeft2; name: "SendMailHorizontalBarLeft2"; x: 184.5; y: 291; width: 0; height: 0 }
}
