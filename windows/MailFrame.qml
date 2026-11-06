// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: mailFrame
    name: "MailFrame"
    width: 400
    height: 565

    Part {
        id: inboxCloseButton
        name: "InboxCloseButton"
        kind: "Button"
        anchors.left: mailFrame.left
        anchors.leftMargin: 342
        anchors.top: mailFrame.top
        anchors.topMargin: -16
        width: 22
        height: 22
    }

    Part {
        id: inboxCurrentPage
        name: "InboxCurrentPage"
        kind: "FontString"
        anchors.horizontalCenter: inboxFrame.horizontalCenter
        anchors.horizontalCenterOffset: -14
        anchors.bottom: inboxFrame.bottom
        anchors.bottomMargin: 72
        width: 96
        height: 12
    }

    Part {
        id: inboxFrame
        name: "InboxFrame"
        kind: "Frame"
        anchors.left: mailFrame.left
        anchors.top: mailFrame.top
        width: 384
        height: 512
    }

    Part {
        id: inboxNextPageButton
        name: "InboxNextPageButton"
        kind: "Button"
        anchors.horizontalCenter: inboxFrame.left
        anchors.horizontalCenterOffset: 314
        anchors.verticalCenter: inboxFrame.bottom
        anchors.verticalCenterOffset: -80
        width: 26
        height: 26
    }

    Part {
        id: inboxPrevPageButton
        name: "InboxPrevPageButton"
        kind: "Button"
        anchors.horizontalCenter: inboxFrame.left
        anchors.horizontalCenterOffset: 50
        anchors.verticalCenter: inboxFrame.bottom
        anchors.verticalCenterOffset: -80
        width: 26
        height: 26
    }

    Part {
        id: inboxTitleText
        name: "InboxTitleText"
        kind: "FontString"
        text: "Inbox"
        anchors.horizontalCenter: inboxFrame.horizontalCenter
        anchors.horizontalCenterOffset: 6
        anchors.verticalCenter: inboxFrame.verticalCenter
        anchors.verticalCenterOffset: -232
        width: 30
        height: 12
    }

    Part {
        id: mailFrameTab1
        name: "MailFrameTab1"
        kind: "Button"
        text: "Inbox"
        anchors.left: mailFrame.left
        anchors.leftMargin: 12
        anchors.top: mailFrame.top
        anchors.topMargin: 449
        width: 52
        height: 116
    }

    Part {
        id: mailFrameTab2
        name: "MailFrameTab2"
        kind: "Button"
        text: "Send Mail"
        anchors.left: mailFrame.left
        anchors.leftMargin: 70
        anchors.top: mailFrame.top
        anchors.topMargin: 449
        width: 52
        height: 116
    }

    Part {
        id: mailItem1
        name: "MailItem1"
        kind: "Frame"
        anchors.left: inboxFrame.left
        anchors.leftMargin: 48
        anchors.top: inboxFrame.top
        anchors.topMargin: 44
        width: 280
        height: 45
    }

    Part {
        id: mailItem1Button
        name: "MailItem1Button"
        kind: "CheckButton"
        anchors.left: mailItem1.left
        anchors.leftMargin: 4
        anchors.top: mailItem1.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: mailItem1ExpireTime
        name: "MailItem1ExpireTime"
        kind: "Button"
        text: "29 Days "
        anchors.right: mailItem1.right
        anchors.rightMargin: -10
        anchors.top: mailItem1.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    Part {
        id: mailItem1Sender
        name: "MailItem1Sender"
        kind: "FontString"
        text: "Brew of the Month Club"
        anchors.left: mailItem1.left
        anchors.leftMargin: 47
        anchors.top: mailItem1.top
        anchors.topMargin: 4
        width: 132
        height: 12
    }

    Part {
        id: mailItem1Subject
        name: "MailItem1Subject"
        kind: "FontString"
        text: "Fun For You And Your Friends"
        anchors.left: mailItem1Sender.left
        anchors.top: mailItem1Sender.bottom
        width: 168
        height: 12
    }

    Part {
        id: mailItem2
        name: "MailItem2"
        kind: "Frame"
        anchors.left: mailItem1.left
        anchors.top: mailItem1.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    Part {
        id: mailItem2Button
        name: "MailItem2Button"
        kind: "CheckButton"
        anchors.left: mailItem2.left
        anchors.leftMargin: 4
        anchors.top: mailItem2.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: mailItem2ExpireTime
        name: "MailItem2ExpireTime"
        kind: "Button"
        text: "3629 Days "
        anchors.right: mailItem2.right
        anchors.rightMargin: -10
        anchors.top: mailItem2.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    Part {
        id: mailItem2Sender
        name: "MailItem2Sender"
        kind: "FontString"
        text: "Customer Support"
        anchors.left: mailItem2.left
        anchors.leftMargin: 47
        anchors.top: mailItem2.top
        anchors.topMargin: 4
        width: 96
        height: 12
    }

    Part {
        id: mailItem2Subject
        name: "MailItem2Subject"
        kind: "FontString"
        text: "Recovered items"
        anchors.left: mailItem2Sender.left
        anchors.top: mailItem2Sender.bottom
        width: 90
        height: 12
    }

    Part {
        id: mailItem3
        name: "MailItem3"
        kind: "Frame"
        anchors.left: mailItem2.left
        anchors.top: mailItem2.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    Part {
        id: mailItem3Button
        name: "MailItem3Button"
        kind: "CheckButton"
        anchors.left: mailItem3.left
        anchors.leftMargin: 4
        anchors.top: mailItem3.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: mailItem3ExpireTime
        name: "MailItem3ExpireTime"
        kind: "Button"
        text: "3629 Days "
        anchors.right: mailItem3.right
        anchors.rightMargin: -10
        anchors.top: mailItem3.top
        anchors.topMargin: 4
        width: 100
        height: 16
    }

    Part {
        id: mailItem3Sender
        name: "MailItem3Sender"
        kind: "FontString"
        anchors.left: mailItem3.left
        anchors.leftMargin: 47
        anchors.top: mailItem3.top
        anchors.topMargin: 4
        width: 90
        height: 12
    }

    Part {
        id: mailItem3Subject
        name: "MailItem3Subject"
        kind: "FontString"
        anchors.left: mailItem3Sender.left
        anchors.top: mailItem3Sender.bottom
        width: 96
        height: 12
    }

    Part {
        id: mailItem4
        name: "MailItem4"
        kind: "Frame"
        anchors.left: mailItem3.left
        anchors.top: mailItem3.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    Part {
        id: mailItem4Sender
        name: "MailItem4Sender"
        kind: "FontString"
        anchors.left: mailItem4.left
        anchors.leftMargin: 47
        anchors.top: mailItem4.top
        anchors.topMargin: 4
        width: 90
        height: 12
    }

    Part {
        id: mailItem4Subject
        name: "MailItem4Subject"
        kind: "FontString"
        anchors.left: mailItem4Sender.left
        anchors.top: mailItem4Sender.bottom
        width: 96
        height: 12
    }

    Part {
        id: mailItem5
        name: "MailItem5"
        kind: "Frame"
        anchors.left: mailItem4.left
        anchors.top: mailItem4.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    Part {
        id: mailItem5Sender
        name: "MailItem5Sender"
        kind: "FontString"
        anchors.left: mailItem5.left
        anchors.leftMargin: 47
        anchors.top: mailItem5.top
        anchors.topMargin: 4
        width: 90
        height: 12
    }

    Part {
        id: mailItem5Subject
        name: "MailItem5Subject"
        kind: "FontString"
        anchors.left: mailItem5Sender.left
        anchors.top: mailItem5Sender.bottom
        width: 96
        height: 12
    }

    Part {
        id: mailItem6
        name: "MailItem6"
        kind: "Frame"
        anchors.left: mailItem5.left
        anchors.top: mailItem5.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    Part {
        id: mailItem6Sender
        name: "MailItem6Sender"
        kind: "FontString"
        anchors.left: mailItem6.left
        anchors.leftMargin: 47
        anchors.top: mailItem6.top
        anchors.topMargin: 4
        width: 90
        height: 12
    }

    Part {
        id: mailItem6Subject
        name: "MailItem6Subject"
        kind: "FontString"
        anchors.left: mailItem6Sender.left
        anchors.top: mailItem6Sender.bottom
        width: 96
        height: 12
    }

    Part {
        id: mailItem7
        name: "MailItem7"
        kind: "Frame"
        anchors.left: mailItem6.left
        anchors.top: mailItem6.bottom
        anchors.topMargin: 6
        width: 280
        height: 45
    }

    Part {
        id: mailItem7Sender
        name: "MailItem7Sender"
        kind: "FontString"
        anchors.left: mailItem7.left
        anchors.leftMargin: 47
        anchors.top: mailItem7.top
        anchors.topMargin: 4
        width: 90
        height: 12
    }

    Part {
        id: mailItem7Subject
        name: "MailItem7Subject"
        kind: "FontString"
        anchors.left: mailItem7Sender.left
        anchors.top: mailItem7Sender.bottom
        width: 96
        height: 12
    }

    Part {
        id: postalInboxCB1
        name: "PostalInboxCB1"
        kind: "CheckButton"
        anchors.right: mailItem1.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem1.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    Part {
        id: postalInboxCB1Text
        name: "PostalInboxCB1Text"
        kind: "FontString"
        text: "1"
        anchors.horizontalCenter: postalInboxCB1.horizontalCenter
        anchors.bottom: postalInboxCB1.top
        width: 6
        height: 12
    }

    Part {
        id: postalInboxCB2
        name: "PostalInboxCB2"
        kind: "CheckButton"
        anchors.right: mailItem2.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem2.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    Part {
        id: postalInboxCB2Text
        name: "PostalInboxCB2Text"
        kind: "FontString"
        text: "2"
        anchors.horizontalCenter: postalInboxCB2.horizontalCenter
        anchors.bottom: postalInboxCB2.top
        width: 6
        height: 12
    }

    Part {
        id: postalInboxCB3
        name: "PostalInboxCB3"
        kind: "CheckButton"
        anchors.right: mailItem3.left
        anchors.rightMargin: -5
        anchors.verticalCenter: mailItem3.verticalCenter
        anchors.verticalCenterOffset: 5
        width: 24
        height: 24
    }

    Part {
        id: postalInboxCB3Text
        name: "PostalInboxCB3Text"
        kind: "FontString"
        text: "3"
        anchors.horizontalCenter: postalInboxCB3.horizontalCenter
        anchors.bottom: postalInboxCB3.top
        width: 6
        height: 12
    }

    Part {
        id: postalOpenAllButton
        name: "PostalOpenAllButton"
        kind: "Button"
        text: "Open All"
        anchors.horizontalCenter: inboxFrame.horizontalCenter
        anchors.horizontalCenterOffset: -22
        anchors.verticalCenter: inboxFrame.top
        anchors.verticalCenterOffset: 432
        width: 120
        height: 25
    }

    Part {
        id: postalOpenAllButtonText
        name: "PostalOpenAllButtonText"
        kind: "FontString"
        text: "Open All"
        anchors.horizontalCenter: postalOpenAllButton.horizontalCenter
        anchors.verticalCenter: postalOpenAllButton.verticalCenter
        width: 48
        height: 12
    }

    Part {
        id: postalSelectOpenButton
        name: "PostalSelectOpenButton"
        kind: "Button"
        text: "Open"
        anchors.left: inboxFrame.left
        anchors.leftMargin: 70
        anchors.top: inboxFrame.top
        anchors.topMargin: -4.5
        width: 110
        height: 25
    }

    Part {
        id: postalSelectOpenButtonText
        name: "PostalSelectOpenButtonText"
        kind: "FontString"
        text: "Open"
        anchors.horizontalCenter: postalSelectOpenButton.horizontalCenter
        anchors.verticalCenter: postalSelectOpenButton.verticalCenter
        width: 24
        height: 12
    }

    Part {
        id: postalSelectReturnButton
        name: "PostalSelectReturnButton"
        kind: "Button"
        text: "Return"
        anchors.left: inboxFrame.left
        anchors.leftMargin: 188
        anchors.top: inboxFrame.top
        anchors.topMargin: -4.5
        width: 110
        height: 25
    }

    Part {
        id: postalSelectReturnButtonText
        name: "PostalSelectReturnButtonText"
        kind: "FontString"
        text: "Return"
        anchors.horizontalCenter: postalSelectReturnButton.horizontalCenter
        anchors.verticalCenter: postalSelectReturnButton.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: postalSubjectHover1
        name: "PostalSubjectHover1"
        kind: "Button"
        anchors.left: mailItem1Subject.left
        anchors.top: mailItem1Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postalSubjectHover2
        name: "PostalSubjectHover2"
        kind: "Button"
        anchors.left: mailItem2Subject.left
        anchors.top: mailItem2Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postalSubjectHover3
        name: "PostalSubjectHover3"
        kind: "Button"
        anchors.left: mailItem3Subject.left
        anchors.top: mailItem3Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postalSubjectHover4
        name: "PostalSubjectHover4"
        kind: "Button"
        anchors.left: mailItem4Subject.left
        anchors.top: mailItem4Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postalSubjectHover5
        name: "PostalSubjectHover5"
        kind: "Button"
        anchors.left: mailItem5Subject.left
        anchors.top: mailItem5Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postalSubjectHover6
        name: "PostalSubjectHover6"
        kind: "Button"
        anchors.left: mailItem6Subject.left
        anchors.top: mailItem6Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postalSubjectHover7
        name: "PostalSubjectHover7"
        kind: "Button"
        anchors.left: mailItem7Subject.left
        anchors.top: mailItem7Subject.top
        width: 248
        height: 18
    }

    Part {
        id: postal_ModuleMenuButton
        name: "Postal_ModuleMenuButton"
        kind: "Button"
        anchors.right: mailFrame.right
        anchors.rightMargin: 53
        anchors.top: mailFrame.top
        anchors.topMargin: -4
        width: 25
        height: 25
    }

    Part {
        id: postal_OpenAllMenuButton
        name: "Postal_OpenAllMenuButton"
        kind: "Button"
        anchors.left: postalOpenAllButton.right
        anchors.leftMargin: -2
        anchors.verticalCenter: postalOpenAllButton.verticalCenter
        width: 30
        height: 30
    }

}
