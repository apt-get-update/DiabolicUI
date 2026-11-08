// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "AdiBagsContainer2"
    width: 1143.7
    height: 418

    Frame {
        name: "AdiBagsContainer2Diabolic"
        anchors.left: parent.left
        anchors.leftMargin: -18
        anchors.top: parent.top
        anchors.topMargin: -18
        width: 1179.7
        height: 454

        Frame {
            name: "AdiBagsContainer2DiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 1179.7
            height: 454
        }

        Frame {
            name: "AdiBagsContainer2DiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    FontString {
        name: "AdiBagsContainer2Title"
        text: "Bank"
        anchors.left: adiBagsSimpleLayeredRegion5.right
        anchors.leftMargin: 4
        anchors.verticalCenter: adiBagsSimpleLayeredRegion5.verticalCenter
        width: 1077.6
        height: 18

        Frame {
            name: "AdiBagsAnchor3"
            wowParent: "AdiBagsContainer2"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 1077.6
            height: 18
        }
    }

    Frame {
        id: adiBagsSimpleLayeredRegion5
        name: "AdiBagsSimpleLayeredRegion5"
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 8
        width: 18
        height: 18
    }

    Ghost {
        name: "AdiBagsContainer1"
        x: 915.1
        y: 104.8
        width: 0
        height: 0

        Frame {
            name: "AdiBagsSection12"
            wowParent: "AdiBagsContainer1"
            anchors.left: parent.left
            anchors.leftMargin: 184.3
            anchors.top: parent.top
            anchors.topMargin: 91
            width: 37
            height: 55
        }
    }

    Ghost {
        name: "AdiBagsSection21"
        x: 947
        y: 332
        width: 37
        height: 55

        Frame {
            name: "AdiBagsStackButton2"
            wowParent: "AdiBagsContainer2"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 18
            width: 37
            height: 37
        }
    }
}
