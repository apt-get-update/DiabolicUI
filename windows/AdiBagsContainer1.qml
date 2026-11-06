// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: adiBagsContainer1
    name: "AdiBagsContainer1"
    width: 828
    height: 445

    Part {
        id: adiBagsAnchor2
        name: "AdiBagsAnchor2"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1Title.left
        anchors.top: adiBagsContainer1Title.top
        width: 761.9
        height: 18
    }

    Part {
        id: adiBagsContainer1Diabolic
        name: "AdiBagsContainer1Diabolic"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: -18
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: -18
        width: 864
        height: 481
    }

    Part {
        id: adiBagsContainer1DiabolicBorder
        name: "AdiBagsContainer1DiabolicBorder"
        kind: "Frame"
        wowParent: "AdiBagsContainer1Diabolic"
        anchors.left: adiBagsContainer1Diabolic.left
        anchors.top: adiBagsContainer1Diabolic.top
        width: 864
        height: 481
    }

    Part {
        id: adiBagsContainer1DiabolicSocket
        name: "AdiBagsContainer1DiabolicSocket"
        kind: "Frame"
        wowParent: "AdiBagsContainer1Diabolic"
        anchors.right: adiBagsContainer1Diabolic.right
        anchors.rightMargin: 20
        anchors.top: adiBagsContainer1Diabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: adiBagsContainer1Title
        name: "AdiBagsContainer1Title"
        kind: "FontString"
        text: "Backpack"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsSimpleLayeredRegion1.right
        anchors.leftMargin: 4
        anchors.verticalCenter: adiBagsSimpleLayeredRegion1.verticalCenter
        width: 761.9
        height: 18
    }

    Part {
        id: adiBagsItemButton1
        name: "AdiBagsItemButton1"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton10
        name: "AdiBagsItemButton10"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton100
        name: "AdiBagsItemButton100"
        kind: "Button"
        anchors.left: adiBagsSection9.left
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton10Count
        name: "AdiBagsItemButton10Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton10.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton10.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton11
        name: "AdiBagsItemButton11"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton11Count
        name: "AdiBagsItemButton11Count"
        kind: "FontString"
        text: "5"
        wowParent: "AdiBagsItemButton11"
        anchors.right: adiBagsItemButton11.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton11.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton12
        name: "AdiBagsItemButton12"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton12Count
        name: "AdiBagsItemButton12Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton12.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton12.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton12Stock
        name: "AdiBagsItemButton12Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton12.left
        anchors.top: adiBagsItemButton12.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton13
        name: "AdiBagsItemButton13"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton13Count
        name: "AdiBagsItemButton13Count"
        kind: "FontString"
        text: "4"
        wowParent: "AdiBagsItemButton13"
        anchors.right: adiBagsItemButton13.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton13.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton14
        name: "AdiBagsItemButton14"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton14Count
        name: "AdiBagsItemButton14Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton14.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton14.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton14Stock
        name: "AdiBagsItemButton14Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton14"
        anchors.left: adiBagsItemButton14.left
        anchors.top: adiBagsItemButton14.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton15
        name: "AdiBagsItemButton15"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton15Count
        name: "AdiBagsItemButton15Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton15.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton15.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton16
        name: "AdiBagsItemButton16"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton16Count
        name: "AdiBagsItemButton16Count"
        kind: "FontString"
        text: "6"
        wowParent: "AdiBagsItemButton16"
        anchors.right: adiBagsItemButton16.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton16.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton17
        name: "AdiBagsItemButton17"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton17Count
        name: "AdiBagsItemButton17Count"
        kind: "FontString"
        text: "4"
        anchors.right: adiBagsItemButton17.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton17.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton18
        name: "AdiBagsItemButton18"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton18Count
        name: "AdiBagsItemButton18Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton18"
        anchors.right: adiBagsItemButton18.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton18.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton19
        name: "AdiBagsItemButton19"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton19Count
        name: "AdiBagsItemButton19Count"
        kind: "FontString"
        text: "23"
        anchors.right: adiBagsItemButton19.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton19.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton19Stock
        name: "AdiBagsItemButton19Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton19"
        anchors.left: adiBagsItemButton19.left
        anchors.top: adiBagsItemButton19.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton1Count
        name: "AdiBagsItemButton1Count"
        kind: "FontString"
        text: "6"
        anchors.right: adiBagsItemButton1.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton1.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton2
        name: "AdiBagsItemButton2"
        kind: "Button"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton20
        name: "AdiBagsItemButton20"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton20Count
        name: "AdiBagsItemButton20Count"
        kind: "FontString"
        text: "2"
        anchors.right: adiBagsItemButton20.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton20.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton20Stock
        name: "AdiBagsItemButton20Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton20.left
        anchors.top: adiBagsItemButton20.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton21
        name: "AdiBagsItemButton21"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection1.left
        anchors.top: adiBagsSection1.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton21Stock
        name: "AdiBagsItemButton21Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton21.left
        anchors.top: adiBagsItemButton21.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton22
        name: "AdiBagsItemButton22"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton22Stock
        name: "AdiBagsItemButton22Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton22"
        anchors.left: adiBagsItemButton22.left
        anchors.top: adiBagsItemButton22.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton23
        name: "AdiBagsItemButton23"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton23Count
        name: "AdiBagsItemButton23Count"
        kind: "FontString"
        text: "2"
        wowParent: "AdiBagsItemButton23"
        anchors.right: adiBagsItemButton23.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton23.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton23Stock
        name: "AdiBagsItemButton23Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton23.left
        anchors.top: adiBagsItemButton23.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton24
        name: "AdiBagsItemButton24"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton24Count
        name: "AdiBagsItemButton24Count"
        kind: "FontString"
        text: "4"
        wowParent: "AdiBagsItemButton24"
        anchors.right: adiBagsItemButton24.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton24.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton25
        name: "AdiBagsItemButton25"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection3.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection3.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton25Count
        name: "AdiBagsItemButton25Count"
        kind: "FontString"
        text: "16"
        anchors.right: adiBagsItemButton25.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton25.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton25Stock
        name: "AdiBagsItemButton25Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton25.left
        anchors.top: adiBagsItemButton25.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton26
        name: "AdiBagsItemButton26"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton27
        name: "AdiBagsItemButton27"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton27Count
        name: "AdiBagsItemButton27Count"
        kind: "FontString"
        text: "4"
        anchors.right: adiBagsItemButton27.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton27.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton27Stock
        name: "AdiBagsItemButton27Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton27"
        anchors.left: adiBagsItemButton27.left
        anchors.top: adiBagsItemButton27.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton28
        name: "AdiBagsItemButton28"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton29
        name: "AdiBagsItemButton29"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsStackButton1.left
        anchors.top: adiBagsStackButton1.top
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton29Count
        name: "AdiBagsItemButton29Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton29"
        anchors.right: adiBagsItemButton29.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton29.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton2Count
        name: "AdiBagsItemButton2Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton2.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton2.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton2Stock
        name: "AdiBagsItemButton2Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton2.left
        anchors.top: adiBagsItemButton2.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton3
        name: "AdiBagsItemButton3"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton30
        name: "AdiBagsItemButton30"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton31
        name: "AdiBagsItemButton31"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton31Count
        name: "AdiBagsItemButton31Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton31"
        anchors.right: adiBagsItemButton31.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton31.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton32
        name: "AdiBagsItemButton32"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection7.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection7.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton32Count
        name: "AdiBagsItemButton32Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton32.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton32.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton33
        name: "AdiBagsItemButton33"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection3.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection3.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton33Count
        name: "AdiBagsItemButton33Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton33.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton33.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton34
        name: "AdiBagsItemButton34"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton34Count
        name: "AdiBagsItemButton34Count"
        kind: "FontString"
        text: "4"
        wowParent: "AdiBagsItemButton34"
        anchors.right: adiBagsItemButton34.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton34.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton35
        name: "AdiBagsItemButton35"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton36
        name: "AdiBagsItemButton36"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton36Count
        name: "AdiBagsItemButton36Count"
        kind: "FontString"
        text: "4"
        anchors.right: adiBagsItemButton36.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton36.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton37
        name: "AdiBagsItemButton37"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton37Stock
        name: "AdiBagsItemButton37Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton37.left
        anchors.top: adiBagsItemButton37.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton38
        name: "AdiBagsItemButton38"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton38Count
        name: "AdiBagsItemButton38Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton38.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton38.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton39
        name: "AdiBagsItemButton39"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton39Count
        name: "AdiBagsItemButton39Count"
        kind: "FontString"
        text: "15"
        wowParent: "AdiBagsItemButton39"
        anchors.right: adiBagsItemButton39.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton39.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton3Count
        name: "AdiBagsItemButton3Count"
        kind: "FontString"
        text: "11"
        wowParent: "AdiBagsItemButton3"
        anchors.right: adiBagsItemButton3.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton3.bottom
        anchors.bottomMargin: 2
        width: 15
        height: 14.2
    }

    Part {
        id: adiBagsItemButton4
        name: "AdiBagsItemButton4"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton40
        name: "AdiBagsItemButton40"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton40Count
        name: "AdiBagsItemButton40Count"
        kind: "FontString"
        text: "6"
        wowParent: "AdiBagsItemButton40"
        anchors.right: adiBagsItemButton40.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton40.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton41
        name: "AdiBagsItemButton41"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton42
        name: "AdiBagsItemButton42"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton42Count
        name: "AdiBagsItemButton42Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton42"
        anchors.right: adiBagsItemButton42.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton42.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton43
        name: "AdiBagsItemButton43"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton43Count
        name: "AdiBagsItemButton43Count"
        kind: "FontString"
        text: "32"
        wowParent: "AdiBagsItemButton43"
        anchors.right: adiBagsItemButton43.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton43.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton44
        name: "AdiBagsItemButton44"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton44Count
        name: "AdiBagsItemButton44Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton44.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton44.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton45
        name: "AdiBagsItemButton45"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton45Stock
        name: "AdiBagsItemButton45Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton45"
        anchors.left: adiBagsItemButton45.left
        anchors.top: adiBagsItemButton45.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton46
        name: "AdiBagsItemButton46"
        kind: "Button"
        anchors.left: adiBagsSection6.left
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton47
        name: "AdiBagsItemButton47"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection7.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection7.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton47Count
        name: "AdiBagsItemButton47Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton47"
        anchors.right: adiBagsItemButton47.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton47.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton47Stock
        name: "AdiBagsItemButton47Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton47.left
        anchors.top: adiBagsItemButton47.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton48
        name: "AdiBagsItemButton48"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton49
        name: "AdiBagsItemButton49"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton49Count
        name: "AdiBagsItemButton49Count"
        kind: "FontString"
        text: "3"
        anchors.right: adiBagsItemButton49.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton49.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton5
        name: "AdiBagsItemButton5"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection3.left
        anchors.top: adiBagsSection3.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton50
        name: "AdiBagsItemButton50"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection9.left
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton51
        name: "AdiBagsItemButton51"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton51Count
        name: "AdiBagsItemButton51Count"
        kind: "FontString"
        text: "4"
        anchors.right: adiBagsItemButton51.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton51.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton52
        name: "AdiBagsItemButton52"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton52Count
        name: "AdiBagsItemButton52Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton52"
        anchors.right: adiBagsItemButton52.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton52.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton53
        name: "AdiBagsItemButton53"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton53Count
        name: "AdiBagsItemButton53Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton53.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton53.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton54
        name: "AdiBagsItemButton54"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton54Count
        name: "AdiBagsItemButton54Count"
        kind: "FontString"
        text: "14"
        anchors.right: adiBagsItemButton54.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton54.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton55
        name: "AdiBagsItemButton55"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton55Count
        name: "AdiBagsItemButton55Count"
        kind: "FontString"
        text: "17"
        wowParent: "AdiBagsItemButton55"
        anchors.right: adiBagsItemButton55.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton55.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton56
        name: "AdiBagsItemButton56"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection7.left
        anchors.top: adiBagsSection7.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton57
        name: "AdiBagsItemButton57"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton58
        name: "AdiBagsItemButton58"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton58Count
        name: "AdiBagsItemButton58Count"
        kind: "FontString"
        text: "17"
        anchors.right: adiBagsItemButton58.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton58.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton58Stock
        name: "AdiBagsItemButton58Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton58"
        anchors.left: adiBagsItemButton58.left
        anchors.top: adiBagsItemButton58.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton59
        name: "AdiBagsItemButton59"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton59Count
        name: "AdiBagsItemButton59Count"
        kind: "FontString"
        text: "4"
        wowParent: "AdiBagsItemButton59"
        anchors.right: adiBagsItemButton59.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton59.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton59Stock
        name: "AdiBagsItemButton59Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton59.left
        anchors.top: adiBagsItemButton59.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton5Count
        name: "AdiBagsItemButton5Count"
        kind: "FontString"
        text: "15"
        anchors.right: adiBagsItemButton5.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton5.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton5Stock
        name: "AdiBagsItemButton5Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton5.left
        anchors.top: adiBagsItemButton5.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton6
        name: "AdiBagsItemButton6"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton60
        name: "AdiBagsItemButton60"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton60Count
        name: "AdiBagsItemButton60Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton60.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton60.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton61
        name: "AdiBagsItemButton61"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton61Stock
        name: "AdiBagsItemButton61Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton61"
        anchors.left: adiBagsItemButton61.left
        anchors.top: adiBagsItemButton61.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton62
        name: "AdiBagsItemButton62"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection3.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection3.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton62Count
        name: "AdiBagsItemButton62Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton62.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton62.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton63
        name: "AdiBagsItemButton63"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton63Count
        name: "AdiBagsItemButton63Count"
        kind: "FontString"
        text: "11"
        anchors.right: adiBagsItemButton63.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton63.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton64
        name: "AdiBagsItemButton64"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton64Count
        name: "AdiBagsItemButton64Count"
        kind: "FontString"
        text: "7"
        anchors.right: adiBagsItemButton64.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton64.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton65
        name: "AdiBagsItemButton65"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton65Count
        name: "AdiBagsItemButton65Count"
        kind: "FontString"
        text: "3"
        wowParent: "AdiBagsItemButton65"
        anchors.right: adiBagsItemButton65.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton65.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton66
        name: "AdiBagsItemButton66"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton66Count
        name: "AdiBagsItemButton66Count"
        kind: "FontString"
        text: "8"
        wowParent: "AdiBagsItemButton66"
        anchors.right: adiBagsItemButton66.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton66.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton67
        name: "AdiBagsItemButton67"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection7.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection7.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton67Count
        name: "AdiBagsItemButton67Count"
        kind: "FontString"
        text: "14"
        wowParent: "AdiBagsItemButton67"
        anchors.right: adiBagsItemButton67.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton67.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton68
        name: "AdiBagsItemButton68"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton68Count
        name: "AdiBagsItemButton68Count"
        kind: "FontString"
        text: "16"
        wowParent: "AdiBagsItemButton68"
        anchors.right: adiBagsItemButton68.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton68.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton68Stock
        name: "AdiBagsItemButton68Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton68"
        anchors.left: adiBagsItemButton68.left
        anchors.top: adiBagsItemButton68.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton69
        name: "AdiBagsItemButton69"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection9.left
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton7
        name: "AdiBagsItemButton7"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton70
        name: "AdiBagsItemButton70"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton70Stock
        name: "AdiBagsItemButton70Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton70"
        anchors.left: adiBagsItemButton70.left
        anchors.top: adiBagsItemButton70.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton71
        name: "AdiBagsItemButton71"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection5.left
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton72
        name: "AdiBagsItemButton72"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton72Count
        name: "AdiBagsItemButton72Count"
        kind: "FontString"
        text: "4"
        anchors.right: adiBagsItemButton72.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton72.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton73
        name: "AdiBagsItemButton73"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton74
        name: "AdiBagsItemButton74"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton74Count
        name: "AdiBagsItemButton74Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton74"
        anchors.right: adiBagsItemButton74.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton74.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton75
        name: "AdiBagsItemButton75"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection4.left
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton76
        name: "AdiBagsItemButton76"
        kind: "Button"
        wowParent: "AdiBagsItemContainer-2"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton76Count
        name: "AdiBagsItemButton76Count"
        kind: "FontString"
        text: "5"
        anchors.right: adiBagsItemButton76.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton76.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton76Stock
        name: "AdiBagsItemButton76Stock"
        kind: "FontString"
        text: "Ke"
        wowParent: "AdiBagsItemButton76"
        anchors.left: adiBagsItemButton76.left
        anchors.top: adiBagsItemButton76.top
        anchors.topMargin: 2
        width: 18.2
        height: 14.2
    }

    Part {
        id: adiBagsItemButton77
        name: "AdiBagsItemButton77"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection7.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection7.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton78
        name: "AdiBagsItemButton78"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton78Count
        name: "AdiBagsItemButton78Count"
        kind: "FontString"
        text: "7"
        wowParent: "AdiBagsItemButton78"
        anchors.right: adiBagsItemButton78.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton78.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton79
        name: "AdiBagsItemButton79"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton79Count
        name: "AdiBagsItemButton79Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton79"
        anchors.right: adiBagsItemButton79.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton79.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton7Count
        name: "AdiBagsItemButton7Count"
        kind: "FontString"
        text: "5"
        anchors.right: adiBagsItemButton7.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton7.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton8
        name: "AdiBagsItemButton8"
        kind: "Button"
        anchors.left: adiBagsSection8.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection8.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton80
        name: "AdiBagsItemButton80"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton80Stock
        name: "AdiBagsItemButton80Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton80.left
        anchors.top: adiBagsItemButton80.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton81
        name: "AdiBagsItemButton81"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton81Count
        name: "AdiBagsItemButton81Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton81.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton81.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton82
        name: "AdiBagsItemButton82"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection4.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection4.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton82Count
        name: "AdiBagsItemButton82Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton82.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton82.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton83
        name: "AdiBagsItemButton83"
        kind: "Button"
        wowParent: "AdiBagsItemContainer2"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton83Count
        name: "AdiBagsItemButton83Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton83"
        anchors.right: adiBagsItemButton83.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton83.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton84
        name: "AdiBagsItemButton84"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection5.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection5.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton84Stock
        name: "AdiBagsItemButton84Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton84.left
        anchors.top: adiBagsItemButton84.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton85
        name: "AdiBagsItemButton85"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton86
        name: "AdiBagsItemButton86"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton86Count
        name: "AdiBagsItemButton86Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton86"
        anchors.right: adiBagsItemButton86.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton86.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton87
        name: "AdiBagsItemButton87"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection7.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection7.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton87Count
        name: "AdiBagsItemButton87Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton87"
        anchors.right: adiBagsItemButton87.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton87.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton88
        name: "AdiBagsItemButton88"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton88Count
        name: "AdiBagsItemButton88Count"
        kind: "FontString"
        text: "6"
        wowParent: "AdiBagsItemButton88"
        anchors.right: adiBagsItemButton88.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton88.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: adiBagsItemButton89
        name: "AdiBagsItemButton89"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection11.left
        anchors.top: adiBagsSection11.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton89Count
        name: "AdiBagsItemButton89Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton89.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton89.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton8Count
        name: "AdiBagsItemButton8Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton8.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton8.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton8Stock
        name: "AdiBagsItemButton8Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton8.left
        anchors.top: adiBagsItemButton8.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton9
        name: "AdiBagsItemButton9"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton90
        name: "AdiBagsItemButton90"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton90Stock
        name: "AdiBagsItemButton90Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton90.left
        anchors.top: adiBagsItemButton90.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton91
        name: "AdiBagsItemButton91"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection3.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection3.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton91Count
        name: "AdiBagsItemButton91Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton91.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton91.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton92
        name: "AdiBagsItemButton92"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton92Count
        name: "AdiBagsItemButton92Count"
        kind: "FontString"
        text: "20"
        wowParent: "AdiBagsItemButton92"
        anchors.right: adiBagsItemButton92.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton92.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton92Stock
        name: "AdiBagsItemButton92Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton92.left
        anchors.top: adiBagsItemButton92.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton93
        name: "AdiBagsItemButton93"
        kind: "Button"
        wowParent: "AdiBagsItemContainer1"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton93Count
        name: "AdiBagsItemButton93Count"
        kind: "FontString"
        text: "4"
        anchors.right: adiBagsItemButton93.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton93.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton93Stock
        name: "AdiBagsItemButton93Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton93.left
        anchors.top: adiBagsItemButton93.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton94
        name: "AdiBagsItemButton94"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection10.left
        anchors.top: adiBagsSection10.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton95
        name: "AdiBagsItemButton95"
        kind: "Button"
        wowParent: "AdiBagsItemContainer3"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton95Count
        name: "AdiBagsItemButton95Count"
        kind: "FontString"
        text: "6"
        anchors.right: adiBagsItemButton95.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton95.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Part {
        id: adiBagsItemButton96
        name: "AdiBagsItemButton96"
        kind: "Button"
        wowParent: "AdiBagsItemContainer0"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton96Count
        name: "AdiBagsItemButton96Count"
        kind: "FontString"
        text: "23"
        wowParent: "AdiBagsItemButton96"
        anchors.right: adiBagsItemButton96.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton96.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton96Stock
        name: "AdiBagsItemButton96Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton96.left
        anchors.top: adiBagsItemButton96.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton97
        name: "AdiBagsItemButton97"
        kind: "Button"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton98
        name: "AdiBagsItemButton98"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection9.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection9.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton99
        name: "AdiBagsItemButton99"
        kind: "Button"
        wowParent: "AdiBagsItemContainer4"
        anchors.left: adiBagsSection6.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection6.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    Part {
        id: adiBagsItemButton99Count
        name: "AdiBagsItemButton99Count"
        kind: "FontString"
        text: "18"
        wowParent: "AdiBagsItemButton99"
        anchors.right: adiBagsItemButton99.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton99.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: adiBagsItemButton99Stock
        name: "AdiBagsItemButton99Stock"
        kind: "FontString"
        text: "Ke"
        anchors.left: adiBagsItemButton99.left
        anchors.top: adiBagsItemButton99.top
        anchors.topMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsItemButton9Count
        name: "AdiBagsItemButton9Count"
        kind: "FontString"
        text: "20"
        anchors.right: adiBagsItemButton9.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton9.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Part {
        id: adiBagsMoneyFrame
        name: "AdiBagsMoneyFrame"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.right: adiBagsSimpleLayeredRegion4.right
        anchors.rightMargin: -13
        anchors.bottom: adiBagsSimpleLayeredRegion4.bottom
        width: 156.7
        height: 19
    }

    Part {
        id: adiBagsMoneyFrameCopperButton
        name: "AdiBagsMoneyFrameCopperButton"
        kind: "Button"
        text: "53"
        wowParent: "AdiBagsMoneyFrame"
        anchors.right: adiBagsMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: adiBagsMoneyFrame.verticalCenter
        width: 38
        height: 19
    }

    Part {
        id: adiBagsMoneyFrameCopperButtonText
        name: "AdiBagsMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "53"
        wowParent: "AdiBagsMoneyFrameCopperButton"
        anchors.right: adiBagsMoneyFrameCopperButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: adiBagsMoneyFrameCopperButton.verticalCenter
        width: 19
        height: 15.8
    }

    Part {
        id: adiBagsMoneyFrameGoldButton
        name: "AdiBagsMoneyFrameGoldButton"
        kind: "Button"
        text: "3632"
        wowParent: "AdiBagsMoneyFrame"
        anchors.right: adiBagsMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: adiBagsMoneyFrameSilverButton.verticalCenter
        width: 53.8
        height: 19
    }

    Part {
        id: adiBagsMoneyFrameGoldButtonText
        name: "AdiBagsMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "3632"
        wowParent: "AdiBagsMoneyFrameGoldButton"
        anchors.right: adiBagsMoneyFrameGoldButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: adiBagsMoneyFrameGoldButton.verticalCenter
        width: 34.8
        height: 15.8
    }

    Part {
        id: adiBagsMoneyFrameSilverButton
        name: "AdiBagsMoneyFrameSilverButton"
        kind: "Button"
        text: "10"
        wowParent: "AdiBagsMoneyFrame"
        anchors.right: adiBagsMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: adiBagsMoneyFrameCopperButton.verticalCenter
        width: 38
        height: 19
    }

    Part {
        id: adiBagsMoneyFrameSilverButtonText
        name: "AdiBagsMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "10"
        wowParent: "AdiBagsMoneyFrameSilverButton"
        anchors.right: adiBagsMoneyFrameSilverButton.right
        anchors.rightMargin: 19
        anchors.verticalCenter: adiBagsMoneyFrameSilverButton.verticalCenter
        width: 19
        height: 15.8
    }

    Part {
        id: adiBagsSection1
        name: "AdiBagsSection1"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 225.3
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 250
        width: 37
        height: 55
    }

    Part {
        id: adiBagsSection10
        name: "AdiBagsSection10"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 91
        width: 37
        height: 55
    }

    Part {
        id: adiBagsSection11
        name: "AdiBagsSection11"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 278.7
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 250
        width: 37
        height: 55
    }

    Part {
        id: adiBagsSection2
        name: "AdiBagsSection2"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 783
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 32
        width: 37
        height: 55
    }

    Part {
        id: adiBagsSection3
        name: "AdiBagsSection3"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 250
        width: 201
        height: 55
    }

    Part {
        id: adiBagsSection4
        name: "AdiBagsSection4"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 191
        width: 365
        height: 55
    }

    Part {
        id: adiBagsSection5
        name: "AdiBagsSection5"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 32
        width: 365
        height: 55
    }

    Part {
        id: adiBagsSection6
        name: "AdiBagsSection6"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 401.7
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 32
        width: 365
        height: 219
    }

    Part {
        id: adiBagsSection7
        name: "AdiBagsSection7"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 401.7
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 255
        width: 242
        height: 55
    }

    Part {
        id: adiBagsSection8
        name: "AdiBagsSection8"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 401.7
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 314
        width: 365
        height: 96
    }

    Part {
        id: adiBagsSection9
        name: "AdiBagsSection9"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 61.3
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 91
        width: 324
        height: 96
    }

    Part {
        id: adiBagsSimpleLayeredRegion1
        name: "AdiBagsSimpleLayeredRegion1"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsContainer1.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer1.top
        anchors.topMargin: 8
        width: 18
        height: 18
    }

    Part {
        id: adiBagsSimpleLayeredRegion4
        name: "AdiBagsSimpleLayeredRegion4"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.right: adiBagsContainer1.right
        anchors.rightMargin: 8
        anchors.bottom: adiBagsContainer1.bottom
        anchors.bottomMargin: 8
        width: 156.7
        height: 19
    }

    Part {
        id: adiBagsStackButton1
        name: "AdiBagsStackButton1"
        kind: "Frame"
        wowParent: "AdiBagsContainer1"
        anchors.left: adiBagsSection2.left
        anchors.top: adiBagsSection2.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

}
