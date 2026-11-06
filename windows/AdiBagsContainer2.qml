// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: adiBagsContainer2
    name: "AdiBagsContainer2"
    width: 1143.7
    height: 418

    Frame {
        id: adiBagsAnchor3
        name: "AdiBagsAnchor3"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2Title.left
        anchors.top: adiBagsContainer2Title.top
        width: 1077.6
        height: 18
    }

    Frame {
        id: adiBagsContainer2Diabolic
        name: "AdiBagsContainer2Diabolic"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: -18
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: -18
        width: 1179.7
        height: 454
    }

    Frame {
        id: adiBagsContainer2DiabolicBorder
        name: "AdiBagsContainer2DiabolicBorder"
        wowParent: "AdiBagsContainer2Diabolic"
        anchors.left: adiBagsContainer2Diabolic.left
        anchors.top: adiBagsContainer2Diabolic.top
        width: 1179.7
        height: 454
    }

    Frame {
        id: adiBagsContainer2DiabolicSocket
        name: "AdiBagsContainer2DiabolicSocket"
        wowParent: "AdiBagsContainer2Diabolic"
        anchors.right: adiBagsContainer2Diabolic.right
        anchors.rightMargin: 20
        anchors.top: adiBagsContainer2Diabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    FontString {
        id: adiBagsContainer2Title
        name: "AdiBagsContainer2Title"
        text: "Bank"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsSimpleLayeredRegion5.right
        anchors.leftMargin: 4
        anchors.verticalCenter: adiBagsSimpleLayeredRegion5.verticalCenter
        width: 1077.6
        height: 18
    }

    Frame {
        id: adiBagsSection12
        name: "AdiBagsSection12"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 184.3
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 91
        width: 37
        height: 55
    }

    Frame {
        id: adiBagsSimpleLayeredRegion5
        name: "AdiBagsSimpleLayeredRegion5"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 8
        width: 18
        height: 18
    }

    Frame {
        id: adiBagsStackButton2
        name: "AdiBagsStackButton2"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsSection21.left
        anchors.top: adiBagsSection21.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Ghost { id: adiBagsContainer1; name: "AdiBagsContainer1"; x: 915.1; y: 104.8; width: 0; height: 0 }
    Ghost { id: adiBagsSection21; name: "AdiBagsSection21"; x: 947; y: 332; width: 37; height: 55 }
}
