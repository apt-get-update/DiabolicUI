// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "AdiBagsContainer2"
    kind: "grid"
    width: 104
    height: 95

    Frame {
        name: "AdiBagsContainer2Diabolic"
        anchors.left: parent.left
        anchors.leftMargin: -18
        anchors.top: parent.top
        anchors.topMargin: -18
        width: 140
        height: 131

        Frame {
            name: "AdiBagsContainer2DiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 140
            height: 131
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
        width: 37.9
        height: 18

        Frame {
            name: "AdiBagsAnchor3"
            wowParent: "AdiBagsContainer2"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 37.9
            height: 18
        }
    }

    Frame {
        name: "AdiBagsSection5"
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 32
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
        x: 499.2
        y: 79.8
        width: 0
        height: 0

        Frame {
            name: "AdiBagsSection12"
            wowParent: "AdiBagsContainer1"
            anchors.left: parent.left
            anchors.leftMargin: 278.7
            anchors.top: parent.top
            anchors.topMargin: 291
            width: 37
            height: 55
        }
    }
}
