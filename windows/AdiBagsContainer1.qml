// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "AdiBagsContainer1"
    width: 774.7
    height: 504

    Frame {
        name: "AdiBagsContainer1Diabolic"
        anchors.left: parent.left
        anchors.leftMargin: -18
        anchors.top: parent.top
        anchors.topMargin: -18
        width: 810.7
        height: 540

        Frame {
            name: "AdiBagsContainer1DiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 810.7
            height: 540
        }

        Frame {
            name: "AdiBagsContainer1DiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    FontString {
        name: "AdiBagsContainer1Title"
        text: "Backpack"
        anchors.left: adiBagsSimpleLayeredRegion1.right
        anchors.leftMargin: 4
        anchors.verticalCenter: adiBagsSimpleLayeredRegion1.verticalCenter
        width: 708.6
        height: 18

        Frame {
            name: "AdiBagsAnchor2"
            wowParent: "AdiBagsContainer1"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 708.6
            height: 18
        }
    }

    Frame {
        name: "AdiBagsSection1"
        anchors.left: parent.left
        anchors.leftMargin: 225.3
        anchors.top: parent.top
        anchors.topMargin: 291
        width: 37
        height: 55
    }

    Frame {
        id: adiBagsSimpleLayeredRegion1
        name: "AdiBagsSimpleLayeredRegion1"
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 8
        width: 18
        height: 18
    }

    Frame {
        name: "AdiBagsSimpleLayeredRegion4"
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: 155.1
        height: 19

        Frame {
            name: "AdiBagsMoneyFrame"
            wowParent: "AdiBagsContainer1"
            anchors.right: parent.right
            anchors.rightMargin: -13
            anchors.bottom: parent.bottom
            width: 155.1
            height: 19

            Button {
                id: adiBagsMoneyFrameCopperButton
                name: "AdiBagsMoneyFrameCopperButton"
                text: "71"
                anchors.right: parent.right
                anchors.rightMargin: 13
                anchors.verticalCenter: parent.verticalCenter
                width: 36.4
                height: 19

                FontString {
                    name: "AdiBagsMoneyFrameCopperButtonText"
                    text: "71"
                    anchors.right: parent.right
                    anchors.rightMargin: 19
                    anchors.verticalCenter: parent.verticalCenter
                    width: 17.4
                    height: 15.8
                }
            }

            Button {
                name: "AdiBagsMoneyFrameGoldButton"
                text: "1820"
                anchors.right: adiBagsMoneyFrameSilverButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: adiBagsMoneyFrameSilverButton.verticalCenter
                width: 53.8
                height: 19

                FontString {
                    name: "AdiBagsMoneyFrameGoldButtonText"
                    text: "1820"
                    anchors.right: parent.right
                    anchors.rightMargin: 19
                    anchors.verticalCenter: parent.verticalCenter
                    width: 34.8
                    height: 15.8
                }
            }

            Button {
                id: adiBagsMoneyFrameSilverButton
                name: "AdiBagsMoneyFrameSilverButton"
                text: "16"
                anchors.right: adiBagsMoneyFrameCopperButton.left
                anchors.rightMargin: 4
                anchors.verticalCenter: adiBagsMoneyFrameCopperButton.verticalCenter
                width: 38
                height: 19

                FontString {
                    name: "AdiBagsMoneyFrameSilverButtonText"
                    text: "16"
                    anchors.right: parent.right
                    anchors.rightMargin: 19
                    anchors.verticalCenter: parent.verticalCenter
                    width: 19
                    height: 15.8
                }
            }
        }
    }

    Ghost {
        name: "AdiBagsSection5"
        x: 537
        y: 414
        width: 37
        height: 55

        Frame {
            name: "AdiBagsStackButton1"
            wowParent: "AdiBagsContainer1"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 37
            height: 37
        }
    }
}
