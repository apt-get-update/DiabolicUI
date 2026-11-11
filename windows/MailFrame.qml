// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "MailFrame"
    width: 384
    height: 512

    Frame {
        name: "InboxFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        FontString {
            name: "InboxTitleText"
            text: "Inbox"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -232
            width: 224
            height: 14
        }

        Frame {
            id: mailItem1
            name: "MailItem1"
            anchors.left: parent.left
            anchors.leftMargin: 48
            anchors.top: parent.top
            anchors.topMargin: 44
            width: 280
            height: 45

            CheckButton {
                name: "MailItem1Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "MailItem1ButtonCount"
                    text: "20"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 17.4
                    height: 14.2
                }
            }

            Button {
                name: "MailItem1ExpireTime"
                text: "24 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem1Sender
                name: "MailItem1Sender"
                text: "Brew of the Month Club"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem1Subject"
                text: "Fun For You And Your Friends"
                anchors.left: mailItem1Sender.left
                anchors.top: mailItem1Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover1"
                    wowParent: "MailItem1"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB1"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB1Text"
                    text: "1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 6.3
                    height: 10.3
                }
            }
        }

        Frame {
            id: mailItem2
            name: "MailItem2"
            anchors.left: mailItem1.left
            anchors.top: mailItem1.bottom
            anchors.topMargin: 6
            width: 280
            height: 45

            CheckButton {
                name: "MailItem2Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "MailItem2ButtonCount"
                    text: "6"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 10.3
                    height: 14.2
                }
            }

            Button {
                name: "MailItem2ExpireTime"
                text: "3624 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem2Sender
                name: "MailItem2Sender"
                text: "Customer Support"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem2Subject"
                text: "Recovered items"
                anchors.left: mailItem2Sender.left
                anchors.top: mailItem2Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover2"
                    wowParent: "MailItem2"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB2"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB2Text"
                    text: "2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 7.9
                    height: 10.3
                }
            }
        }

        Frame {
            id: mailItem3
            name: "MailItem3"
            anchors.left: mailItem2.left
            anchors.top: mailItem2.bottom
            anchors.topMargin: 6
            width: 280
            height: 45

            CheckButton {
                name: "MailItem3Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37
            }

            Button {
                name: "MailItem3ExpireTime"
                text: "29 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem3Sender
                name: "MailItem3Sender"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem3Subject"
                anchors.left: mailItem3Sender.left
                anchors.top: mailItem3Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover3"
                    wowParent: "MailItem3"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB3"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB3Text"
                    text: "3"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 7.9
                    height: 10.3
                }
            }
        }

        Frame {
            id: mailItem4
            name: "MailItem4"
            anchors.left: mailItem3.left
            anchors.top: mailItem3.bottom
            anchors.topMargin: 6
            width: 280
            height: 45

            CheckButton {
                name: "MailItem4Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "MailItem4ButtonCount"
                    text: "9"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 10.3
                    height: 14.2
                }
            }

            Button {
                name: "MailItem4ExpireTime"
                text: "29 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem4Sender
                name: "MailItem4Sender"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem4Subject"
                anchors.left: mailItem4Sender.left
                anchors.top: mailItem4Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover4"
                    wowParent: "MailItem4"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB4"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB4Text"
                    text: "4"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 8.7
                    height: 10.3
                }
            }
        }

        Frame {
            id: mailItem5
            name: "MailItem5"
            anchors.left: mailItem4.left
            anchors.top: mailItem4.bottom
            anchors.topMargin: 6
            width: 280
            height: 45

            CheckButton {
                name: "MailItem5Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37
            }

            Button {
                name: "MailItem5ExpireTime"
                text: "29 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem5Sender
                name: "MailItem5Sender"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem5Subject"
                anchors.left: mailItem5Sender.left
                anchors.top: mailItem5Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover5"
                    wowParent: "MailItem5"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB5"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB5Text"
                    text: "5"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 7.9
                    height: 10.3
                }
            }
        }

        Frame {
            id: mailItem6
            name: "MailItem6"
            anchors.left: mailItem5.left
            anchors.top: mailItem5.bottom
            anchors.topMargin: 6
            width: 280
            height: 45

            CheckButton {
                name: "MailItem6Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "MailItem6ButtonCount"
                    text: "2"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 10.3
                    height: 14.2
                }
            }

            Button {
                name: "MailItem6ExpireTime"
                text: "29 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem6Sender
                name: "MailItem6Sender"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem6Subject"
                anchors.left: mailItem6Sender.left
                anchors.top: mailItem6Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover6"
                    wowParent: "MailItem6"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB6"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB6Text"
                    text: "6"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 7.9
                    height: 10.3
                }
            }
        }

        Frame {
            name: "MailItem7"
            anchors.left: mailItem6.left
            anchors.top: mailItem6.bottom
            anchors.topMargin: 6
            width: 280
            height: 45

            CheckButton {
                name: "MailItem7Button"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37
            }

            Button {
                name: "MailItem7ExpireTime"
                text: "29 Days "
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                id: mailItem7Sender
                name: "MailItem7Sender"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16
            }

            FontString {
                name: "MailItem7Subject"
                anchors.left: mailItem7Sender.left
                anchors.top: mailItem7Sender.bottom
                width: 248
                height: 18

                Button {
                    name: "PostalSubjectHover7"
                    wowParent: "MailItem7"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 248
                    height: 18
                }
            }

            CheckButton {
                name: "PostalInboxCB7"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB7Text"
                    text: "7"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 7.9
                    height: 10.3
                }
            }
        }
    }

    Frame {
        id: mailFrameDiabolic
        name: "MailFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -16
        anchors.top: parent.top
        anchors.topMargin: -68
        width: 400
        height: 530

        Button {
            name: "InboxCloseButton"
            wowParent: "MailFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "MailFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 352
            height: 40

            Button {
                name: "PostalSelectOpenButton"
                text: "Open"
                wowParent: "InboxFrame"
                style: "Button"
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 110
                height: 25

                FontString {
                    name: "PostalSelectOpenButtonText"
                    text: "Open"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 34.8
                    height: 11.9
                }
            }

            Button {
                name: "PostalSelectReturnButton"
                text: "Return"
                wowParent: "InboxFrame"
                style: "Button"
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 110
                height: 25

                FontString {
                    name: "PostalSelectReturnButtonText"
                    text: "Return"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 53.7
                    height: 11.9
                }
            }

            Button {
                name: "Postal_BlackBookButton"
                wowParent: "SendMailFrame"
                anchors.left: sendMailNameEditBox.right
                anchors.leftMargin: 12
                anchors.verticalCenter: sendMailNameEditBox.verticalCenter
                width: 25
                height: 25
            }

            Frame {
                name: "SendMailCostMoneyFrame"
                wowParent: "SendMailFrame"
                anchors.right: parent.right
                anchors.rightMargin: 48
                anchors.verticalCenter: parent.verticalCenter
                width: 43.4
                height: 13

                Button {
                    name: "SendMailCostMoneyFrameCopperButton"
                    text: "30"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "SendMailCostMoneyFrameCopperButtonText"
                        text: "30"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

            EditBox {
                id: sendMailNameEditBox
                name: "SendMailNameEditBox"
                text: "Padizwerch"
                wowParent: "SendMailFrame"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 86
                height: 20

                Frame {
                    name: "AutoCompleteBox"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: -3
                    width: 120
                    height: 105

                    Button {
                        id: autoCompleteButton1
                        name: "AutoCompleteButton1"
                        text: "Acta"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton1Text"
                            text: "Acta"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -0.1
                            width: 29.2
                            height: 11.9
                        }
                    }

                    Button {
                        id: autoCompleteButton2
                        name: "AutoCompleteButton2"
                        text: "Adoradear"
                        anchors.left: autoCompleteButton1.left
                        anchors.top: autoCompleteButton1.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton2Text"
                            text: "Adoradear"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -0.1
                            width: 65.6
                            height: 11.9
                        }
                    }

                    Button {
                        id: autoCompleteButton3
                        name: "AutoCompleteButton3"
                        text: "Aeriana"
                        anchors.left: autoCompleteButton2.left
                        anchors.top: autoCompleteButton2.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton3Text"
                            text: "Aeriana"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -0.1
                            width: 47.4
                            height: 11.9
                        }
                    }

                    Button {
                        id: autoCompleteButton4
                        name: "AutoCompleteButton4"
                        text: "Aishidin"
                        anchors.left: autoCompleteButton3.left
                        anchors.top: autoCompleteButton3.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton4Text"
                            text: "Aishidin"
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -0.1
                            width: 49
                            height: 11.9
                        }
                    }

                    Button {
                        name: "AutoCompleteButton5"
                        text: "..."
                        anchors.left: autoCompleteButton4.left
                        anchors.top: autoCompleteButton4.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton5Text"
                            text: "..."
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -0.1
                            width: 10.3
                            height: 11.9
                        }
                    }

                    FontString {
                        name: "AutoCompleteInstructions"
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        width: 51.4
                        height: 10.3
                    }
                }

                Frame {
                    name: "SendMailNameEditBoxDiabolicField"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 102
                    height: 22
                }
            }

            EditBox {
                name: "SendMailSubjectEditBox"
                wowParent: "SendMailFrame"
                style: "EditBox"
                anchors.left: parent.left
                anchors.leftMargin: 154
                anchors.verticalCenter: parent.verticalCenter
                width: 88.6
                height: 20

                Frame {
                    name: "SendMailSubjectEditBoxDiabolicField"
                    anchors.left: parent.left
                    anchors.leftMargin: -8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 104.6
                    height: 22
                }
            }
        }

        Frame {
            name: "MailFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 400
            height: 498

            Frame {
                name: "MailFrameDiabolicTitlePlate"
                wowParent: "MailFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "MailFrameDiabolicTitle"
                    text: "Inbox"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 52.1
                    height: 14.2
                }
            }
        }

        Frame {
            id: mailFrameDiabolicFoot
            name: "MailFrameDiabolicFoot"
            pin: "place"
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.right: parent.right
            anchors.rightMargin: 23
            width: 354
            height: 35

            FontString {
                name: "InboxCurrentPage"
                wowParent: "InboxFrame"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -6
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                width: 192
                height: 1
            }

            Button {
                name: "InboxNextPageButton"
                wowParent: "InboxFrame"
                pin: "place"
                anchors.horizontalCenter: parent.left
                anchors.horizontalCenterOffset: 307
                anchors.verticalCenter: parent.bottom
                anchors.verticalCenterOffset: -16
                width: 26
                height: 26
            }

            Button {
                name: "InboxPrevPageButton"
                wowParent: "InboxFrame"
                pin: "place"
                anchors.horizontalCenter: parent.left
                anchors.horizontalCenterOffset: 43
                anchors.verticalCenter: parent.bottom
                anchors.verticalCenterOffset: -16
                width: 26
                height: 26
            }

            Button {
                id: postalOpenAllButton
                name: "PostalOpenAllButton"
                text: "Open All"
                wowParent: "InboxFrame"
                style: "Button"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -14
                anchors.verticalCenter: parent.bottom
                anchors.verticalCenterOffset: -16
                width: 120
                height: 25

                FontString {
                    name: "PostalOpenAllButtonText"
                    text: "Open All"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 64
                    height: 11.9
                }
            }

            Button {
                name: "Postal_OpenAllMenuButton"
                wowParent: "InboxFrame"
                anchors.left: postalOpenAllButton.right
                anchors.leftMargin: -2
                anchors.verticalCenter: postalOpenAllButton.verticalCenter
                width: 30
                height: 30
            }

            WowRow {
                name: "SendMailButtons"
                fit: "equal"
                anchors.left: parent.left
                anchors.leftMargin: 178
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7

                Button {
                    name: "SendMailMailButton"
                    text: "Send"
                    wowParent: "SendMailFrame"
                    style: "Button"
                    pin: "all"
                    width: 78
                    height: 22

                    FontString {
                        name: "SendMailMailButtonText"
                        text: "Send"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 33.2
                        height: 11.9
                    }
                }

                Button {
                    name: "SendMailCancelButton"
                    text: "Cancel"
                    wowParent: "SendMailFrame"
                    style: "Button"
                    pin: "all"
                    width: 78
                    height: 22

                    FontString {
                        name: "SendMailCancelButtonText"
                        text: "Cancel"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 51.4
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "MailFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "MailFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Frame {
            name: "SendMailMoneyButton"
            wowParent: "SendMailFrame"
            pin: "place"
            anchors.left: mailFrameDiabolicFoot.left
            anchors.leftMargin: 23
            anchors.bottom: mailFrameDiabolicFoot.bottom
            anchors.bottomMargin: 47
            width: 37
            height: 37

            CheckButton {
                name: "SendMailCODButton"
                anchors.left: sendMailSendMoneyButton.left
                anchors.top: sendMailSendMoneyButton.bottom
                anchors.topMargin: -1
                width: 16
                height: 16

                FontString {
                    name: "SendMailCODButtonText"
                    text: "C.O.D."
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    width: 34.8
                    height: 10.3
                }
            }

            Frame {
                id: sendMailMoney
                name: "SendMailMoney"
                anchors.left: sendMailMoneyText.left
                anchors.leftMargin: 5
                anchors.top: sendMailMoneyText.bottom
                anchors.topMargin: 3
                width: 176
                height: 18

                EditBox {
                    name: "SendMailMoneyCopper"
                    anchors.left: sendMailMoneySilver.right
                    anchors.leftMargin: 16
                    anchors.verticalCenter: sendMailMoneySilver.verticalCenter
                    width: 30
                    height: 20
                }

                EditBox {
                    id: sendMailMoneyGold
                    name: "SendMailMoneyGold"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 58
                    height: 20
                }

                EditBox {
                    id: sendMailMoneySilver
                    name: "SendMailMoneySilver"
                    anchors.left: sendMailMoneyGold.right
                    anchors.leftMargin: 26
                    anchors.verticalCenter: sendMailMoneyGold.verticalCenter
                    width: 30
                    height: 20
                }
            }

            FontString {
                id: sendMailMoneyText
                name: "SendMailMoneyText"
                text: "Amount to send:"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 5
                width: 88.5
                height: 10.3
            }

            CheckButton {
                id: sendMailSendMoneyButton
                name: "SendMailSendMoneyButton"
                anchors.left: sendMailMoney.right
                anchors.top: sendMailMoney.top
                anchors.topMargin: -12
                width: 16
                height: 16

                FontString {
                    name: "SendMailSendMoneyButtonText"
                    text: "Send Money"
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    width: 68
                    height: 10.3
                }
            }
        }

        Frame {
            name: "SendMailMoneyFrame"
            wowParent: "SendMailFrame"
            pin: "place"
            anchors.right: mailFrameDiabolicFoot.left
            anchors.rightMargin: -176
            anchors.bottom: mailFrameDiabolicFoot.bottom
            anchors.bottomMargin: 11
            width: 126.4
            height: 13

            Button {
                id: sendMailMoneyFrameCopperButton
                name: "SendMailMoneyFrameCopperButton"
                text: "75"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 30.4
                height: 13

                FontString {
                    name: "SendMailMoneyFrameCopperButtonText"
                    text: "75"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.4
                    height: 14.2
                }
            }

            Button {
                name: "SendMailMoneyFrameGoldButton"
                text: "3663"
                anchors.right: sendMailMoneyFrameSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: sendMailMoneyFrameSilverButton.verticalCenter
                width: 44.6
                height: 13

                FontString {
                    name: "SendMailMoneyFrameGoldButtonText"
                    text: "3663"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 31.6
                    height: 14.2
                }
            }

            Button {
                id: sendMailMoneyFrameSilverButton
                name: "SendMailMoneyFrameSilverButton"
                text: "24"
                anchors.right: sendMailMoneyFrameCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: sendMailMoneyFrameCopperButton.verticalCenter
                width: 30.4
                height: 13

                FontString {
                    name: "SendMailMoneyFrameSilverButtonText"
                    text: "24"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.4
                    height: 14.2
                }
            }
        }
    }

    Button {
        name: "MailFrameTab1"
        text: "Inbox"
        style: "Banner"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: mailFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "MailFrameTab2"
        text: "Send Mail"
        style: "Banner"
        anchors.left: mailFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: mailFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "Postal_ModuleMenuButton"
        anchors.right: parent.right
        anchors.rightMargin: 53
        anchors.top: parent.top
        anchors.topMargin: -4
        width: 25
        height: 25
    }

    Frame {
        name: "SendMailFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "SendMailAttachment1"
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment1Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        Button {
            name: "SendMailAttachment2"
            anchors.left: parent.left
            anchors.leftMargin: 76
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment2Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        Button {
            name: "SendMailAttachment3"
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment3Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        Button {
            name: "SendMailAttachment4"
            anchors.left: parent.left
            anchors.leftMargin: 164
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment4Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        Button {
            name: "SendMailAttachment5"
            anchors.left: parent.left
            anchors.leftMargin: 208
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment5Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        Button {
            name: "SendMailAttachment6"
            anchors.left: parent.left
            anchors.leftMargin: 252
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment6Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        Button {
            name: "SendMailAttachment7"
            anchors.left: parent.left
            anchors.leftMargin: 296
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment7Count"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 1
                height: 1
            }
        }

        ScrollFrame {
            name: "SendMailScrollFrame"
            anchors.left: parent.left
            anchors.leftMargin: 21
            anchors.top: parent.top
            anchors.topMargin: 42
            width: 296
            height: 240

            Frame {
                name: "SendMailScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 240

                EditBox {
                    name: "SendMailBodyEditBox"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: 270
                    height: 15
                }
            }

            Frame {
                name: "SendMailScrollFrameDiabolicPanel"
                wowParent: "SendMailFrame"
                anchors.left: parent.left
                anchors.leftMargin: -6
                anchors.top: parent.top
                anchors.topMargin: -6
                width: 330
                height: 252
            }

            Frame {
                name: "SendMailScrollFrameDiabolicParchment"
                anchors.left: parent.left
                anchors.leftMargin: -4
                anchors.top: parent.top
                anchors.topMargin: -4
                width: 304
                height: 248
            }

            Slider {
                name: "SendMailScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 208

                Frame {
                    name: "SendMailScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: sendMailScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: sendMailScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 242
                }

                Button {
                    name: "SendMailScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: sendMailScrollFrameScrollBarScrollUpButton
                    name: "SendMailScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }
        }

        FontString {
            name: "SendMailTitleText"
            text: "Send Mail"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -230
            width: 224
            height: 14
        }

        Ghost {
            name: "SendMailHorizontalBarLeft2"
            x: 184.5
            y: 291
            width: 0
            height: 0

            Frame {
                name: "SendMailFrameDiabolicAttachments"
                wowParent: "SendMailFrame"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 1
                width: 319
                height: 63
            }
        }
    }
}
