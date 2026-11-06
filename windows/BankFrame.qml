// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "BankFrame"
    width: 425
    height: 512

    Frame {
        name: "BankFrameDiabolic"
        wowParent: "BankFrame"
        anchors.left: parent.left
        anchors.leftMargin: -24
        anchors.top: parent.top
        width: 443
        height: 478

        Button {
            name: "BankCloseButton"
            wowParent: "BankFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "BankFrameDiabolicBorder"
            wowParent: "BankFrameDiabolic"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 443
            height: 478

            Frame {
                name: "BankFrameDiabolicTitlePlate"
                wowParent: "BankFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "BankFrameTitleText"
                    text: "Newton Burnside"
                    wowParent: "BankFrameDiabolicTitlePlate"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 157.2
                    height: 14.2
                }
            }
        }

        Frame {
            name: "BankFrameDiabolicSocket"
            wowParent: "BankFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Button {
        name: "BankFrameItem1"
        wowParent: "BankFrame"
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 73
        width: 37
        height: 37

        FontString {
            name: "BankFrameItem1Count"
            text: "18"
            wowParent: "BankFrameItem1"
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            width: 17.4
            height: 14.2
        }
    }

    Frame {
        name: "BankFrameMoneyFrame"
        wowParent: "BankFrame"
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 103
        width: 126.4
        height: 13

        Button {
            name: "BankFrameMoneyFrameCopperButton"
            text: "13"
            wowParent: "BankFrameMoneyFrame"
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            width: 30.4
            height: 13

            FontString {
                name: "BankFrameMoneyFrameCopperButtonText"
                text: "13"
                wowParent: "BankFrameMoneyFrameCopperButton"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 17.4
                height: 14.2
            }

            Button {
                name: "BankFrameMoneyFrameSilverButton"
                text: "16"
                wowParent: "BankFrameMoneyFrame"
                anchors.right: parent.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 30.4
                height: 13

                Button {
                    name: "BankFrameMoneyFrameGoldButton"
                    text: "3654"
                    wowParent: "BankFrameMoneyFrame"
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    width: 44.6
                    height: 13

                    FontString {
                        name: "BankFrameMoneyFrameGoldButtonText"
                        text: "3654"
                        wowParent: "BankFrameMoneyFrameGoldButton"
                        anchors.right: parent.right
                        anchors.rightMargin: 13
                        anchors.verticalCenter: parent.verticalCenter
                        width: 31.6
                        height: 14.2
                    }
                }

                FontString {
                    name: "BankFrameMoneyFrameSilverButtonText"
                    text: "16"
                    wowParent: "BankFrameMoneyFrameSilverButton"
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.4
                    height: 14.2
                }
            }
        }
    }

    Ghost {
        name: "BankFrameItem22"
        x: 40
        y: 205
        width: 37
        height: 37

        Button {
            name: "BankFrameBag1"
            wowParent: "BankFrame"
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 32
            width: 37
            height: 37

            Frame {
                name: "BankFrameBag1HighlightFrame"
                wowParent: "BankFrameBag1"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 37
                height: 37
            }

            Button {
                name: "BankFrameBag2"
                wowParent: "BankFrame"
                anchors.left: parent.right
                anchors.leftMargin: 12
                anchors.top: parent.top
                width: 37
                height: 37

                Frame {
                    name: "BankFrameBag2HighlightFrame"
                    wowParent: "BankFrameBag2"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 37
                    height: 37
                }

                Button {
                    name: "BankFrameBag3"
                    wowParent: "BankFrame"
                    anchors.left: parent.right
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    width: 37
                    height: 37

                    Frame {
                        name: "BankFrameBag3HighlightFrame"
                        wowParent: "BankFrameBag3"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 37
                        height: 37
                    }

                    Button {
                        name: "BankFrameBag4"
                        wowParent: "BankFrame"
                        anchors.left: parent.right
                        anchors.leftMargin: 12
                        anchors.top: parent.top
                        width: 37
                        height: 37

                        Frame {
                            name: "BankFrameBag4HighlightFrame"
                            wowParent: "BankFrameBag4"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 37
                            height: 37
                        }

                        Button {
                            name: "BankFrameBag5"
                            wowParent: "BankFrame"
                            anchors.left: parent.right
                            anchors.leftMargin: 12
                            anchors.top: parent.top
                            width: 37
                            height: 37

                            Frame {
                                name: "BankFrameBag5HighlightFrame"
                                wowParent: "BankFrameBag5"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                width: 37
                                height: 37
                            }

                            Button {
                                name: "BankFrameBag6"
                                wowParent: "BankFrame"
                                anchors.left: parent.right
                                anchors.leftMargin: 12
                                anchors.top: parent.top
                                width: 37
                                height: 37

                                Frame {
                                    name: "BankFrameBag6HighlightFrame"
                                    wowParent: "BankFrameBag6"
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    width: 37
                                    height: 37
                                }

                                Button {
                                    name: "BankFrameBag7"
                                    wowParent: "BankFrame"
                                    anchors.left: parent.right
                                    anchors.leftMargin: 12
                                    anchors.top: parent.top
                                    width: 37
                                    height: 37

                                    Frame {
                                        name: "BankFrameBag7HighlightFrame"
                                        wowParent: "BankFrameBag7"
                                        anchors.left: parent.left
                                        anchors.top: parent.top
                                        width: 37
                                        height: 37
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
