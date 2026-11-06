// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: adiBagsContainer1
    name: "AdiBagsContainer1"
    width: 828
    height: 445

    Frame {
        id: adiBagsAnchor2
        name: "AdiBagsAnchor2"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1Title.left
        anchors.top: adiBagsContainer1Title.top
        width: 761.9
        height: 18
    }

    Frame {
        id: adiBagsContainer1Diabolic
        name: "AdiBagsContainer1Diabolic"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: -18
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: -18
        width: 864
        height: 481
    }

    Frame {
        id: adiBagsContainer1DiabolicBorder
        name: "AdiBagsContainer1DiabolicBorder"
        wowParent: "AdiBagsContainer1Diabolic"
        anchors.left: adiBagsContainer1Diabolic.left
        anchors.top: adiBagsContainer1Diabolic.top
        width: 864
        height: 481
    }

    Frame {
        id: adiBagsContainer1DiabolicSocket
        name: "AdiBagsContainer1DiabolicSocket"
        wowParent: "AdiBagsContainer1Diabolic"
        anchors.right: adiBagsContainer1Diabolic.right
        anchors.rightMargin: 20
        anchors.top: adiBagsContainer1Diabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    FontString {
        id: adiBagsContainer1Title
        name: "AdiBagsContainer1Title"
        text: "Backpack"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsSimpleLayeredRegion1.right
        anchors.leftMargin: 4
        anchors.verticalCenter: adiBagsSimpleLayeredRegion1.verticalCenter
        width: 761.9
        height: 18
    }

    Frame {
        id: adiBagsMoneyFrame
        name: "AdiBagsMoneyFrame"
        wowParent: "AdiBagsContainer1"
        anchors.right: adiBagsSimpleLayeredRegion4.right
        anchors.rightMargin: -13
        anchors.bottom: adiBagsSimpleLayeredRegion4.bottom
        width: 156.7
        height: 19
    }

    Button {
        id: adiBagsMoneyFrameCopperButton
        name: "AdiBagsMoneyFrameCopperButton"
        text: "13"
        wowParent: "AdiBagsMoneyFrame"
        anchors.right: adiBagsMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: adiBagsMoneyFrame.verticalCenter
        width: 38
        height: 19
    }

    FontString {
        id: adiBagsMoneyFrameCopperButtonText
        name: "AdiBagsMoneyFrameCopperButtonText"
        text: "13"
        wowParent: "AdiBagsMoneyFrameCopperButton"
        anchors.right: adiBagsMoneyFrameCopperButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: adiBagsMoneyFrameCopperButton.verticalCenter
        width: 19
        height: 15.8
    }

    Button {
        id: adiBagsMoneyFrameGoldButton
        name: "AdiBagsMoneyFrameGoldButton"
        text: "3654"
        wowParent: "AdiBagsMoneyFrame"
        anchors.right: adiBagsMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: adiBagsMoneyFrameSilverButton.verticalCenter
        width: 53.8
        height: 19
    }

    FontString {
        id: adiBagsMoneyFrameGoldButtonText
        name: "AdiBagsMoneyFrameGoldButtonText"
        text: "3654"
        wowParent: "AdiBagsMoneyFrameGoldButton"
        anchors.right: adiBagsMoneyFrameGoldButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: adiBagsMoneyFrameGoldButton.verticalCenter
        width: 34.8
        height: 15.8
    }

    Button {
        id: adiBagsMoneyFrameSilverButton
        name: "AdiBagsMoneyFrameSilverButton"
        text: "16"
        wowParent: "AdiBagsMoneyFrame"
        anchors.right: adiBagsMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: adiBagsMoneyFrameCopperButton.verticalCenter
        width: 38
        height: 19
    }

    FontString {
        id: adiBagsMoneyFrameSilverButtonText
        name: "AdiBagsMoneyFrameSilverButtonText"
        text: "16"
        wowParent: "AdiBagsMoneyFrameSilverButton"
        anchors.right: adiBagsMoneyFrameSilverButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: adiBagsMoneyFrameSilverButton.verticalCenter
        width: 19
        height: 15.8
    }

    Frame {
        id: adiBagsSection1
        name: "AdiBagsSection1"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 225.3
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 250
        width: 37
        height: 55
    }

    Frame {
        id: adiBagsSimpleLayeredRegion1
        name: "AdiBagsSimpleLayeredRegion1"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 8
        width: 18
        height: 18
    }

    Frame {
        id: adiBagsSimpleLayeredRegion4
        name: "AdiBagsSimpleLayeredRegion4"
        wowParent: "AdiBagsContainer1"
        anchors.right: adiBagsContainer1.right
        anchors.rightMargin: 8
        anchors.bottom: adiBagsContainer1.bottom
        anchors.bottomMargin: 8
        width: 156.7
        height: 19
    }

    Frame {
        id: adiBagsStackButton1
        name: "AdiBagsStackButton1"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsSection2.left
        anchors.top: adiBagsSection2.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Ghost { id: adiBagsSection2; name: "AdiBagsSection2"; x: 783; y: 32; width: 37; height: 55 }
}
