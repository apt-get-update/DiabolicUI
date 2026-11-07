// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "MailFrame"
    width: 384
    height: 512

    Frame {
        name: "InboxFrame"
        wowParent: "MailFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        FontString {
            name: "InboxTitleText"
            text: "Inbox"
            wowParent: "InboxFrame"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -232
            width: 224
            height: 14
        }

        Frame {
            name: "MailItem1"
            wowParent: "InboxFrame"
            anchors.left: parent.left
            anchors.leftMargin: 48
            anchors.top: parent.top
            anchors.topMargin: 44
            width: 280
            height: 45

            CheckButton {
                name: "MailItem1Button"
                wowParent: "MailItem1"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 37
                height: 37

                FontString {
                    name: "MailItem1ButtonCount"
                    text: "20"
                    wowParent: "MailItem1Button"
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
                text: "27 Days "
                wowParent: "MailItem1"
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 100
                height: 16
            }

            FontString {
                name: "MailItem1Sender"
                text: "Brew of the Month Club"
                wowParent: "MailItem1"
                anchors.left: parent.left
                anchors.leftMargin: 47
                anchors.top: parent.top
                anchors.topMargin: 4
                width: 200
                height: 16

                FontString {
                    name: "MailItem1Subject"
                    text: "Fun For You And Your Friends"
                    wowParent: "MailItem1"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
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
            }

            Frame {
                name: "MailItem2"
                wowParent: "InboxFrame"
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 6
                width: 280
                height: 45

                CheckButton {
                    name: "MailItem2Button"
                    wowParent: "MailItem2"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 37
                    height: 37

                    FontString {
                        name: "MailItem2ButtonCount"
                        text: "6"
                        wowParent: "MailItem2Button"
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
                    text: "3626 Days "
                    wowParent: "MailItem2"
                    anchors.right: parent.right
                    anchors.rightMargin: -10
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 100
                    height: 16
                }

                FontString {
                    name: "MailItem2Sender"
                    text: "Customer Support"
                    wowParent: "MailItem2"
                    anchors.left: parent.left
                    anchors.leftMargin: 47
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 200
                    height: 16

                    FontString {
                        name: "MailItem2Subject"
                        text: "Recovered items"
                        wowParent: "MailItem2"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
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
                }

                Frame {
                    name: "MailItem3"
                    wowParent: "InboxFrame"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 6
                    width: 280
                    height: 45

                    CheckButton {
                        name: "MailItem3Button"
                        wowParent: "MailItem3"
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
                        wowParent: "MailItem3"
                        anchors.right: parent.right
                        anchors.rightMargin: -10
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        width: 100
                        height: 16
                    }

                    FontString {
                        name: "MailItem3Sender"
                        wowParent: "MailItem3"
                        anchors.left: parent.left
                        anchors.leftMargin: 47
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        width: 200
                        height: 16

                        FontString {
                            name: "MailItem3Subject"
                            wowParent: "MailItem3"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
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
                    }

                    Frame {
                        name: "MailItem4"
                        wowParent: "InboxFrame"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 6
                        width: 280
                        height: 45

                        CheckButton {
                            name: "MailItem4Button"
                            wowParent: "MailItem4"
                            anchors.left: parent.left
                            anchors.leftMargin: 4
                            anchors.top: parent.top
                            anchors.topMargin: 3
                            width: 37
                            height: 37

                            FontString {
                                name: "MailItem4ButtonCount"
                                text: "9"
                                wowParent: "MailItem4Button"
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
                            wowParent: "MailItem4"
                            anchors.right: parent.right
                            anchors.rightMargin: -10
                            anchors.top: parent.top
                            anchors.topMargin: 4
                            width: 100
                            height: 16
                        }

                        FontString {
                            name: "MailItem4Sender"
                            wowParent: "MailItem4"
                            anchors.left: parent.left
                            anchors.leftMargin: 47
                            anchors.top: parent.top
                            anchors.topMargin: 4
                            width: 200
                            height: 16

                            FontString {
                                name: "MailItem4Subject"
                                wowParent: "MailItem4"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
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
                        }

                        Frame {
                            name: "MailItem5"
                            wowParent: "InboxFrame"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 6
                            width: 280
                            height: 45

                            CheckButton {
                                name: "MailItem5Button"
                                wowParent: "MailItem5"
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
                                wowParent: "MailItem5"
                                anchors.right: parent.right
                                anchors.rightMargin: -10
                                anchors.top: parent.top
                                anchors.topMargin: 4
                                width: 100
                                height: 16
                            }

                            FontString {
                                name: "MailItem5Sender"
                                wowParent: "MailItem5"
                                anchors.left: parent.left
                                anchors.leftMargin: 47
                                anchors.top: parent.top
                                anchors.topMargin: 4
                                width: 200
                                height: 16

                                FontString {
                                    name: "MailItem5Subject"
                                    wowParent: "MailItem5"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
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
                            }

                            Frame {
                                name: "MailItem6"
                                wowParent: "InboxFrame"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 6
                                width: 280
                                height: 45

                                CheckButton {
                                    name: "MailItem6Button"
                                    wowParent: "MailItem6"
                                    anchors.left: parent.left
                                    anchors.leftMargin: 4
                                    anchors.top: parent.top
                                    anchors.topMargin: 3
                                    width: 37
                                    height: 37

                                    FontString {
                                        name: "MailItem6ButtonCount"
                                        text: "2"
                                        wowParent: "MailItem6Button"
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
                                    wowParent: "MailItem6"
                                    anchors.right: parent.right
                                    anchors.rightMargin: -10
                                    anchors.top: parent.top
                                    anchors.topMargin: 4
                                    width: 100
                                    height: 16
                                }

                                FontString {
                                    name: "MailItem6Sender"
                                    wowParent: "MailItem6"
                                    anchors.left: parent.left
                                    anchors.leftMargin: 47
                                    anchors.top: parent.top
                                    anchors.topMargin: 4
                                    width: 200
                                    height: 16

                                    FontString {
                                        name: "MailItem6Subject"
                                        wowParent: "MailItem6"
                                        anchors.left: parent.left
                                        anchors.top: parent.bottom
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
                                }

                                Frame {
                                    name: "MailItem7"
                                    wowParent: "InboxFrame"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 6
                                    width: 280
                                    height: 45

                                    CheckButton {
                                        name: "MailItem7Button"
                                        wowParent: "MailItem7"
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
                                        wowParent: "MailItem7"
                                        anchors.right: parent.right
                                        anchors.rightMargin: -10
                                        anchors.top: parent.top
                                        anchors.topMargin: 4
                                        width: 100
                                        height: 16
                                    }

                                    FontString {
                                        name: "MailItem7Sender"
                                        wowParent: "MailItem7"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 47
                                        anchors.top: parent.top
                                        anchors.topMargin: 4
                                        width: 200
                                        height: 16

                                        FontString {
                                            name: "MailItem7Subject"
                                            wowParent: "MailItem7"
                                            anchors.left: parent.left
                                            anchors.top: parent.bottom
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
                                    }

                                    CheckButton {
                                        name: "PostalInboxCB7"
                                        wowParent: "MailItem7"
                                        anchors.right: parent.left
                                        anchors.rightMargin: -5
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.verticalCenterOffset: 5
                                        width: 24
                                        height: 24

                                        FontString {
                                            name: "PostalInboxCB7Text"
                                            text: "7"
                                            wowParent: "PostalInboxCB7"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.bottom: parent.top
                                            width: 7.9
                                            height: 10.3
                                        }
                                    }
                                }

                                CheckButton {
                                    name: "PostalInboxCB6"
                                    wowParent: "MailItem6"
                                    anchors.right: parent.left
                                    anchors.rightMargin: -5
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: 5
                                    width: 24
                                    height: 24

                                    FontString {
                                        name: "PostalInboxCB6Text"
                                        text: "6"
                                        wowParent: "PostalInboxCB6"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottom: parent.top
                                        width: 7.9
                                        height: 10.3
                                    }
                                }
                            }

                            CheckButton {
                                name: "PostalInboxCB5"
                                wowParent: "MailItem5"
                                anchors.right: parent.left
                                anchors.rightMargin: -5
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: 5
                                width: 24
                                height: 24

                                FontString {
                                    name: "PostalInboxCB5Text"
                                    text: "5"
                                    wowParent: "PostalInboxCB5"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.top
                                    width: 7.9
                                    height: 10.3
                                }
                            }
                        }

                        CheckButton {
                            name: "PostalInboxCB4"
                            wowParent: "MailItem4"
                            anchors.right: parent.left
                            anchors.rightMargin: -5
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: 5
                            width: 24
                            height: 24

                            FontString {
                                name: "PostalInboxCB4Text"
                                text: "4"
                                wowParent: "PostalInboxCB4"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top
                                width: 8.7
                                height: 10.3
                            }
                        }
                    }

                    CheckButton {
                        name: "PostalInboxCB3"
                        wowParent: "MailItem3"
                        anchors.right: parent.left
                        anchors.rightMargin: -5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 5
                        width: 24
                        height: 24

                        FontString {
                            name: "PostalInboxCB3Text"
                            text: "3"
                            wowParent: "PostalInboxCB3"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            width: 7.9
                            height: 10.3
                        }
                    }
                }

                CheckButton {
                    name: "PostalInboxCB2"
                    wowParent: "MailItem2"
                    anchors.right: parent.left
                    anchors.rightMargin: -5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                    width: 24
                    height: 24

                    FontString {
                        name: "PostalInboxCB2Text"
                        text: "2"
                        wowParent: "PostalInboxCB2"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        width: 7.9
                        height: 10.3
                    }
                }
            }

            CheckButton {
                name: "PostalInboxCB1"
                wowParent: "MailItem1"
                anchors.right: parent.left
                anchors.rightMargin: -5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                width: 24
                height: 24

                FontString {
                    name: "PostalInboxCB1Text"
                    text: "1"
                    wowParent: "PostalInboxCB1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 6.3
                    height: 10.3
                }
            }
        }
    }

    Frame {
        name: "MailFrameDiabolic"
        wowParent: "MailFrame"
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
            wowParent: "MailFrameDiabolic"
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
                    wowParent: "PostalSelectOpenButton"
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
                    wowParent: "PostalSelectReturnButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 53.7
                    height: 11.9
                }
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
                    wowParent: "SendMailCostMoneyFrame"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "SendMailCostMoneyFrameCopperButtonText"
                        text: "30"
                        wowParent: "SendMailCostMoneyFrameCopperButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
            }

            EditBox {
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
                    wowParent: "SendMailNameEditBox"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: -3
                    width: 120
                    height: 105

                    Button {
                        id: autoCompleteButton1
                        name: "AutoCompleteButton1"
                        text: "Acta"
                        wowParent: "AutoCompleteBox"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton1Text"
                            text: "Acta"
                            wowParent: "AutoCompleteButton1"
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
                        wowParent: "AutoCompleteBox"
                        anchors.left: autoCompleteButton1.left
                        anchors.top: autoCompleteButton1.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton2Text"
                            text: "Adoradear"
                            wowParent: "AutoCompleteButton2"
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
                        wowParent: "AutoCompleteBox"
                        anchors.left: autoCompleteButton2.left
                        anchors.top: autoCompleteButton2.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton3Text"
                            text: "Aeriana"
                            wowParent: "AutoCompleteButton3"
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
                        wowParent: "AutoCompleteBox"
                        anchors.left: autoCompleteButton3.left
                        anchors.top: autoCompleteButton3.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton4Text"
                            text: "Aishidin"
                            wowParent: "AutoCompleteButton4"
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
                        wowParent: "AutoCompleteBox"
                        anchors.left: autoCompleteButton4.left
                        anchors.top: autoCompleteButton4.bottom
                        width: 120
                        height: 14

                        FontString {
                            name: "AutoCompleteButton5Text"
                            text: "..."
                            wowParent: "AutoCompleteButton5"
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
                        wowParent: "AutoCompleteBox"
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        width: 51.4
                        height: 10.3
                    }
                }

                Button {
                    name: "Postal_BlackBookButton"
                    wowParent: "SendMailFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    width: 25
                    height: 25
                }

                Frame {
                    name: "SendMailNameEditBoxDiabolicField"
                    wowParent: "SendMailNameEditBox"
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
                    wowParent: "SendMailSubjectEditBox"
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
            wowParent: "MailFrameDiabolic"
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
                    text: "Send Mail"
                    wowParent: "MailFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 86.9
                    height: 14.2
                }
            }
        }

        Frame {
            name: "MailFrameDiabolicFoot"
            wowParent: "MailFrameDiabolic"
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
                    wowParent: "PostalOpenAllButton"
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

            Frame {
                name: "SendMailMoneyButton"
                wowParent: "SendMailFrame"
                pin: "place"
                anchors.left: parent.left
                anchors.leftMargin: 23
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 47
                width: 37
                height: 37

                FontString {
                    name: "SendMailMoneyText"
                    text: "Amount to send:"
                    wowParent: "SendMailMoneyButton"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    width: 88.5
                    height: 10.3

                    Frame {
                        name: "SendMailMoney"
                        wowParent: "SendMailMoneyButton"
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.top: parent.bottom
                        anchors.topMargin: 3
                        width: 176
                        height: 18

                        CheckButton {
                            name: "SendMailCODButton"
                            wowParent: "SendMailMoneyButton"
                            anchors.left: sendMailSendMoneyButton.left
                            anchors.top: sendMailSendMoneyButton.bottom
                            anchors.topMargin: -1
                            width: 16
                            height: 16

                            FontString {
                                name: "SendMailCODButtonText"
                                text: "C.O.D."
                                wowParent: "SendMailCODButton"
                                anchors.left: parent.right
                                anchors.leftMargin: 5
                                anchors.verticalCenter: parent.verticalCenter
                                width: 34.8
                                height: 10.3
                            }
                        }

                        EditBox {
                            name: "SendMailMoneyGold"
                            wowParent: "SendMailMoney"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 58
                            height: 20

                            EditBox {
                                name: "SendMailMoneySilver"
                                wowParent: "SendMailMoney"
                                anchors.left: parent.right
                                anchors.leftMargin: 26
                                anchors.verticalCenter: parent.verticalCenter
                                width: 30
                                height: 20

                                EditBox {
                                    name: "SendMailMoneyCopper"
                                    wowParent: "SendMailMoney"
                                    anchors.left: parent.right
                                    anchors.leftMargin: 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 30
                                    height: 20
                                }
                            }
                        }

                        CheckButton {
                            id: sendMailSendMoneyButton
                            name: "SendMailSendMoneyButton"
                            wowParent: "SendMailMoneyButton"
                            anchors.left: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: -12
                            width: 16
                            height: 16

                            FontString {
                                name: "SendMailSendMoneyButtonText"
                                text: "Send Money"
                                wowParent: "SendMailSendMoneyButton"
                                anchors.left: parent.right
                                anchors.leftMargin: 5
                                anchors.verticalCenter: parent.verticalCenter
                                width: 68
                                height: 10.3
                            }
                        }
                    }
                }
            }

            Frame {
                name: "SendMailMoneyFrame"
                wowParent: "SendMailFrame"
                pin: "place"
                anchors.right: parent.left
                anchors.rightMargin: -176
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 11
                width: 126.4
                height: 13

                Button {
                    id: sendMailMoneyFrameCopperButton
                    name: "SendMailMoneyFrameCopperButton"
                    text: "13"
                    wowParent: "SendMailMoneyFrame"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "SendMailMoneyFrameCopperButtonText"
                        text: "13"
                        wowParent: "SendMailMoneyFrameCopperButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }

                Button {
                    name: "SendMailMoneyFrameGoldButton"
                    text: "3654"
                    wowParent: "SendMailMoneyFrame"
                    anchors.right: sendMailMoneyFrameSilverButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: sendMailMoneyFrameSilverButton.verticalCenter
                    width: 44.6
                    height: 13

                    FontString {
                        name: "SendMailMoneyFrameGoldButtonText"
                        text: "3654"
                        wowParent: "SendMailMoneyFrameGoldButton"
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
                    text: "16"
                    wowParent: "SendMailMoneyFrame"
                    anchors.right: sendMailMoneyFrameCopperButton.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: sendMailMoneyFrameCopperButton.verticalCenter
                    width: 30.4
                    height: 13

                    FontString {
                        name: "SendMailMoneyFrameSilverButtonText"
                        text: "16"
                        wowParent: "SendMailMoneyFrameSilverButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 17.4
                        height: 14.2
                    }
                }
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
                        wowParent: "SendMailMailButton"
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
                        wowParent: "SendMailCancelButton"
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
            wowParent: "MailFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 130
            height: 18
        }

        Frame {
            name: "MailFrameDiabolicSocket"
            wowParent: "MailFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Button {
            name: "MailFrameTab1"
            text: "Inbox"
            wowParent: "MailFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "MailFrameTab2"
            text: "Send Mail"
            wowParent: "MailFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Button {
        name: "Postal_ModuleMenuButton"
        wowParent: "MailFrame"
        anchors.right: parent.right
        anchors.rightMargin: 53
        anchors.top: parent.top
        anchors.topMargin: -4
        width: 25
        height: 25
    }

    Frame {
        name: "SendMailFrame"
        wowParent: "MailFrame"
        anchors.left: parent.left
        anchors.top: parent.top
        width: 384
        height: 512

        Button {
            name: "SendMailAttachment1"
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment1Count"
                wowParent: "SendMailAttachment1"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 76
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment2Count"
                wowParent: "SendMailAttachment2"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment3Count"
                wowParent: "SendMailAttachment3"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 164
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment4Count"
                wowParent: "SendMailAttachment4"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 208
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment5Count"
                wowParent: "SendMailAttachment5"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 252
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment6Count"
                wowParent: "SendMailAttachment6"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 296
            anchors.top: parent.bottom
            anchors.topMargin: -201
            width: 37
            height: 37

            FontString {
                name: "SendMailAttachment7Count"
                wowParent: "SendMailAttachment7"
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
            wowParent: "SendMailFrame"
            anchors.left: parent.left
            anchors.leftMargin: 21
            anchors.top: parent.top
            anchors.topMargin: 42
            width: 296
            height: 240

            Frame {
                name: "SendMailScrollChildFrame"
                wowParent: "SendMailScrollFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 300
                height: 240

                EditBox {
                    name: "SendMailBodyEditBox"
                    wowParent: "SendMailScrollChildFrame"
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
                wowParent: "SendMailScrollFrame"
                anchors.left: parent.left
                anchors.leftMargin: -4
                anchors.top: parent.top
                anchors.topMargin: -4
                width: 304
                height: 248
            }

            Slider {
                name: "SendMailScrollFrameScrollBar"
                wowParent: "SendMailScrollFrame"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 208

                Button {
                    name: "SendMailScrollFrameScrollBarScrollDownButton"
                    wowParent: "SendMailScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    name: "SendMailScrollFrameScrollBarScrollUpButton"
                    wowParent: "SendMailScrollFrameScrollBar"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16

                    Frame {
                        name: "SendMailScrollFrameScrollBarDiabolicTrack"
                        wowParent: "SendMailScrollFrameScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 242
                    }
                }
            }
        }

        FontString {
            name: "SendMailTitleText"
            text: "Send Mail"
            wowParent: "SendMailFrame"
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
