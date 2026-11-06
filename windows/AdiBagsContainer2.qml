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

    Button {
        id: adiBagsBankItemButton1
        name: "AdiBagsBankItemButton1"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton10
        name: "AdiBagsBankItemButton10"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton10Count
        name: "AdiBagsBankItemButton10Count"
        text: "11"
        wowParent: "AdiBagsBankItemButton10"
        anchors.right: adiBagsBankItemButton10.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton10.bottom
        anchors.bottomMargin: 2
        width: 15
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton11
        name: "AdiBagsBankItemButton11"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection22.left
        anchors.top: adiBagsSection22.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton12
        name: "AdiBagsBankItemButton12"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton12Count
        name: "AdiBagsBankItemButton12Count"
        text: "18"
        wowParent: "AdiBagsBankItemButton12"
        anchors.right: adiBagsBankItemButton12.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton12.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton13
        name: "AdiBagsBankItemButton13"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton14
        name: "AdiBagsBankItemButton14"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection14.left
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton14Count
        name: "AdiBagsBankItemButton14Count"
        text: "20"
        wowParent: "AdiBagsBankItemButton14"
        anchors.right: adiBagsBankItemButton14.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton14.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton15
        name: "AdiBagsBankItemButton15"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton16
        name: "AdiBagsBankItemButton16"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton17
        name: "AdiBagsBankItemButton17"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton17Count
        name: "AdiBagsBankItemButton17Count"
        text: "4"
        wowParent: "AdiBagsBankItemButton17"
        anchors.right: adiBagsBankItemButton17.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton17.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton18
        name: "AdiBagsBankItemButton18"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton19
        name: "AdiBagsBankItemButton19"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton19Count
        name: "AdiBagsBankItemButton19Count"
        text: "2"
        wowParent: "AdiBagsBankItemButton19"
        anchors.right: adiBagsBankItemButton19.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton19.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton2
        name: "AdiBagsBankItemButton2"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection17.left
        anchors.top: adiBagsSection17.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton20
        name: "AdiBagsBankItemButton20"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton21
        name: "AdiBagsBankItemButton21"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton21Count
        name: "AdiBagsBankItemButton21Count"
        text: "20"
        wowParent: "AdiBagsBankItemButton21"
        anchors.right: adiBagsBankItemButton21.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton21.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton22
        name: "AdiBagsBankItemButton22"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton22Count
        name: "AdiBagsBankItemButton22Count"
        text: "20"
        wowParent: "AdiBagsBankItemButton22"
        anchors.right: adiBagsBankItemButton22.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton22.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton23
        name: "AdiBagsBankItemButton23"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton24
        name: "AdiBagsBankItemButton24"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton24Count
        name: "AdiBagsBankItemButton24Count"
        text: "14"
        wowParent: "AdiBagsBankItemButton24"
        anchors.right: adiBagsBankItemButton24.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton24.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton25
        name: "AdiBagsBankItemButton25"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton25Count
        name: "AdiBagsBankItemButton25Count"
        text: "20"
        wowParent: "AdiBagsBankItemButton25"
        anchors.right: adiBagsBankItemButton25.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton25.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton26
        name: "AdiBagsBankItemButton26"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton26Count
        name: "AdiBagsBankItemButton26Count"
        text: "13"
        wowParent: "AdiBagsBankItemButton26"
        anchors.right: adiBagsBankItemButton26.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton26.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton27
        name: "AdiBagsBankItemButton27"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton28
        name: "AdiBagsBankItemButton28"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsBankItemButton28Count
        name: "AdiBagsBankItemButton28Count"
        text: "2"
        wowParent: "AdiBagsBankItemButton28"
        anchors.right: adiBagsBankItemButton28.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsBankItemButton28.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsBankItemButton3
        name: "AdiBagsBankItemButton3"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton4
        name: "AdiBagsBankItemButton4"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection15.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection15.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton5
        name: "AdiBagsBankItemButton5"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton6
        name: "AdiBagsBankItemButton6"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton7
        name: "AdiBagsBankItemButton7"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection13.left
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton8
        name: "AdiBagsBankItemButton8"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsBankItemButton9
        name: "AdiBagsBankItemButton9"
        wowParent: "AdiBagsItemContainer-1"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
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

    Button {
        id: adiBagsItemButton101
        name: "AdiBagsItemButton101"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton101Count
        name: "AdiBagsItemButton101Count"
        text: "2"
        wowParent: "AdiBagsItemButton101"
        anchors.right: adiBagsItemButton101.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton101.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton102
        name: "AdiBagsItemButton102"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection15.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection15.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton103
        name: "AdiBagsItemButton103"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection13.left
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton104
        name: "AdiBagsItemButton104"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton104Count
        name: "AdiBagsItemButton104Count"
        text: "4"
        wowParent: "AdiBagsItemButton104"
        anchors.right: adiBagsItemButton104.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton104.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton105
        name: "AdiBagsItemButton105"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton105Count
        name: "AdiBagsItemButton105Count"
        text: "84"
        wowParent: "AdiBagsItemButton105"
        anchors.right: adiBagsItemButton105.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton105.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton106
        name: "AdiBagsItemButton106"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton106Count
        name: "AdiBagsItemButton106Count"
        text: "20"
        wowParent: "AdiBagsItemButton106"
        anchors.right: adiBagsItemButton106.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton106.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton107
        name: "AdiBagsItemButton107"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton108
        name: "AdiBagsItemButton108"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton108Count
        name: "AdiBagsItemButton108Count"
        text: "2"
        wowParent: "AdiBagsItemButton108"
        anchors.right: adiBagsItemButton108.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton108.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton109
        name: "AdiBagsItemButton109"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton110
        name: "AdiBagsItemButton110"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton110Count
        name: "AdiBagsItemButton110Count"
        text: "80"
        wowParent: "AdiBagsItemButton110"
        anchors.right: adiBagsItemButton110.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton110.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton111
        name: "AdiBagsItemButton111"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton112
        name: "AdiBagsItemButton112"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton113
        name: "AdiBagsItemButton113"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton114
        name: "AdiBagsItemButton114"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton115
        name: "AdiBagsItemButton115"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton115Count
        name: "AdiBagsItemButton115Count"
        text: "9"
        wowParent: "AdiBagsItemButton115"
        anchors.right: adiBagsItemButton115.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton115.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton116
        name: "AdiBagsItemButton116"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton117
        name: "AdiBagsItemButton117"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection19.left
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton118
        name: "AdiBagsItemButton118"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection12.left
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton119
        name: "AdiBagsItemButton119"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton120
        name: "AdiBagsItemButton120"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton121
        name: "AdiBagsItemButton121"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton122
        name: "AdiBagsItemButton122"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection20.left
        anchors.top: adiBagsSection20.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton123
        name: "AdiBagsItemButton123"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton124
        name: "AdiBagsItemButton124"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton125
        name: "AdiBagsItemButton125"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton125Count
        name: "AdiBagsItemButton125Count"
        text: "20"
        wowParent: "AdiBagsItemButton125"
        anchors.right: adiBagsItemButton125.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton125.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton126
        name: "AdiBagsItemButton126"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection20.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection20.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton127
        name: "AdiBagsItemButton127"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton128
        name: "AdiBagsItemButton128"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton128Count
        name: "AdiBagsItemButton128Count"
        text: "8"
        wowParent: "AdiBagsItemButton128"
        anchors.right: adiBagsItemButton128.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton128.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton129
        name: "AdiBagsItemButton129"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton129Count
        name: "AdiBagsItemButton129Count"
        text: "11"
        wowParent: "AdiBagsItemButton129"
        anchors.right: adiBagsItemButton129.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton129.bottom
        anchors.bottomMargin: 2
        width: 15
        height: 14.2
    }

    Button {
        id: adiBagsItemButton130
        name: "AdiBagsItemButton130"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton131
        name: "AdiBagsItemButton131"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton132
        name: "AdiBagsItemButton132"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton133
        name: "AdiBagsItemButton133"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton134
        name: "AdiBagsItemButton134"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton134Count
        name: "AdiBagsItemButton134Count"
        text: "16"
        wowParent: "AdiBagsItemButton134"
        anchors.right: adiBagsItemButton134.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton134.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton135
        name: "AdiBagsItemButton135"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton136
        name: "AdiBagsItemButton136"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection18.left
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton137
        name: "AdiBagsItemButton137"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton137Count
        name: "AdiBagsItemButton137Count"
        text: "10"
        wowParent: "AdiBagsItemButton137"
        anchors.right: adiBagsItemButton137.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton137.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton138
        name: "AdiBagsItemButton138"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton139
        name: "AdiBagsItemButton139"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton140
        name: "AdiBagsItemButton140"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection19.left
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton141
        name: "AdiBagsItemButton141"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton142
        name: "AdiBagsItemButton142"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton142Count
        name: "AdiBagsItemButton142Count"
        text: "8"
        wowParent: "AdiBagsItemButton142"
        anchors.right: adiBagsItemButton142.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton142.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton143
        name: "AdiBagsItemButton143"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton144
        name: "AdiBagsItemButton144"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton145
        name: "AdiBagsItemButton145"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 223
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton146
        name: "AdiBagsItemButton146"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton147
        name: "AdiBagsItemButton147"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton147Count
        name: "AdiBagsItemButton147Count"
        text: "5"
        wowParent: "AdiBagsItemButton147"
        anchors.right: adiBagsItemButton147.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton147.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton148
        name: "AdiBagsItemButton148"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton149
        name: "AdiBagsItemButton149"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection12.left
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton149Count
        name: "AdiBagsItemButton149Count"
        text: "6"
        wowParent: "AdiBagsItemButton149"
        anchors.right: adiBagsItemButton149.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton149.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton150
        name: "AdiBagsItemButton150"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton151
        name: "AdiBagsItemButton151"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection13.left
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton152
        name: "AdiBagsItemButton152"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection14.left
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton152Count
        name: "AdiBagsItemButton152Count"
        text: "2"
        wowParent: "AdiBagsItemButton152"
        anchors.right: adiBagsItemButton152.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton152.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton153
        name: "AdiBagsItemButton153"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton154
        name: "AdiBagsItemButton154"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton155
        name: "AdiBagsItemButton155"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton156
        name: "AdiBagsItemButton156"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton157
        name: "AdiBagsItemButton157"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton158
        name: "AdiBagsItemButton158"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton158Count
        name: "AdiBagsItemButton158Count"
        text: "8"
        wowParent: "AdiBagsItemButton158"
        anchors.right: adiBagsItemButton158.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton158.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton159
        name: "AdiBagsItemButton159"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton160
        name: "AdiBagsItemButton160"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton161
        name: "AdiBagsItemButton161"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsStackButton2.left
        anchors.top: adiBagsStackButton2.top
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton161Count
        name: "AdiBagsItemButton161Count"
        text: "4"
        wowParent: "AdiBagsItemButton161"
        anchors.right: adiBagsItemButton161.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton161.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton162
        name: "AdiBagsItemButton162"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton162Count
        name: "AdiBagsItemButton162Count"
        text: "3"
        wowParent: "AdiBagsItemButton162"
        anchors.right: adiBagsItemButton162.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton162.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton163
        name: "AdiBagsItemButton163"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton164
        name: "AdiBagsItemButton164"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton165
        name: "AdiBagsItemButton165"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton166
        name: "AdiBagsItemButton166"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton167
        name: "AdiBagsItemButton167"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection22.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection22.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton168
        name: "AdiBagsItemButton168"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton169
        name: "AdiBagsItemButton169"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton169Count
        name: "AdiBagsItemButton169Count"
        text: "4"
        wowParent: "AdiBagsItemButton169"
        anchors.right: adiBagsItemButton169.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton169.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton170
        name: "AdiBagsItemButton170"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton171
        name: "AdiBagsItemButton171"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton172
        name: "AdiBagsItemButton172"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton173
        name: "AdiBagsItemButton173"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton173Count
        name: "AdiBagsItemButton173Count"
        text: "4"
        wowParent: "AdiBagsItemButton173"
        anchors.right: adiBagsItemButton173.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton173.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton174
        name: "AdiBagsItemButton174"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton175
        name: "AdiBagsItemButton175"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton175Count
        name: "AdiBagsItemButton175Count"
        text: "21"
        wowParent: "AdiBagsItemButton175"
        anchors.right: adiBagsItemButton175.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton175.bottom
        anchors.bottomMargin: 2
        width: 15.8
        height: 14.2
    }

    Button {
        id: adiBagsItemButton176
        name: "AdiBagsItemButton176"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton176Count
        name: "AdiBagsItemButton176Count"
        text: "20"
        wowParent: "AdiBagsItemButton176"
        anchors.right: adiBagsItemButton176.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton176.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton177
        name: "AdiBagsItemButton177"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton177Count
        name: "AdiBagsItemButton177Count"
        text: "2"
        wowParent: "AdiBagsItemButton177"
        anchors.right: adiBagsItemButton177.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton177.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton178
        name: "AdiBagsItemButton178"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton178Count
        name: "AdiBagsItemButton178Count"
        text: "7"
        wowParent: "AdiBagsItemButton178"
        anchors.right: adiBagsItemButton178.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton178.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton179
        name: "AdiBagsItemButton179"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection16.left
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton180
        name: "AdiBagsItemButton180"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection16.left
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton180Count
        name: "AdiBagsItemButton180Count"
        text: "7"
        wowParent: "AdiBagsItemButton180"
        anchors.right: adiBagsItemButton180.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton180.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton181
        name: "AdiBagsItemButton181"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton181Count
        name: "AdiBagsItemButton181Count"
        text: "7"
        anchors.right: adiBagsItemButton181.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton181.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Button {
        id: adiBagsItemButton182
        name: "AdiBagsItemButton182"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton182Count
        name: "AdiBagsItemButton182Count"
        text: "2"
        wowParent: "AdiBagsItemButton182"
        anchors.right: adiBagsItemButton182.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton182.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton183
        name: "AdiBagsItemButton183"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton183Count
        name: "AdiBagsItemButton183Count"
        text: "15"
        wowParent: "AdiBagsItemButton183"
        anchors.right: adiBagsItemButton183.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton183.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton184
        name: "AdiBagsItemButton184"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton184Count
        name: "AdiBagsItemButton184Count"
        text: "20"
        wowParent: "AdiBagsItemButton184"
        anchors.right: adiBagsItemButton184.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton184.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton185
        name: "AdiBagsItemButton185"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton185Count
        name: "AdiBagsItemButton185Count"
        text: "20"
        anchors.right: adiBagsItemButton185.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton185.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton186
        name: "AdiBagsItemButton186"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton186Count
        name: "AdiBagsItemButton186Count"
        text: "20"
        wowParent: "AdiBagsItemButton186"
        anchors.right: adiBagsItemButton186.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton186.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton187
        name: "AdiBagsItemButton187"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton187Count
        name: "AdiBagsItemButton187Count"
        text: "20"
        wowParent: "AdiBagsItemButton187"
        anchors.right: adiBagsItemButton187.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton187.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton188
        name: "AdiBagsItemButton188"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection14.left
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton188Count
        name: "AdiBagsItemButton188Count"
        text: "16"
        wowParent: "AdiBagsItemButton188"
        anchors.right: adiBagsItemButton188.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton188.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton189
        name: "AdiBagsItemButton189"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton189Count
        name: "AdiBagsItemButton189Count"
        text: "16"
        anchors.right: adiBagsItemButton189.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton189.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton190
        name: "AdiBagsItemButton190"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton191
        name: "AdiBagsItemButton191"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton191Count
        name: "AdiBagsItemButton191Count"
        text: "15"
        wowParent: "AdiBagsItemButton191"
        anchors.right: adiBagsItemButton191.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton191.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton192
        name: "AdiBagsItemButton192"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection15.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection15.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton192Count
        name: "AdiBagsItemButton192Count"
        text: "234"
        wowParent: "AdiBagsItemButton192"
        anchors.right: adiBagsItemButton192.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton192.bottom
        anchors.bottomMargin: 2
        width: 24.5
        height: 14.2
    }

    Button {
        id: adiBagsItemButton193
        name: "AdiBagsItemButton193"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton193Count
        name: "AdiBagsItemButton193Count"
        text: "20"
        wowParent: "AdiBagsItemButton193"
        anchors.right: adiBagsItemButton193.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton193.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton194
        name: "AdiBagsItemButton194"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton194Count
        name: "AdiBagsItemButton194Count"
        text: "20"
        anchors.right: adiBagsItemButton194.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton194.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton195
        name: "AdiBagsItemButton195"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton195Count
        name: "AdiBagsItemButton195Count"
        text: "7"
        wowParent: "AdiBagsItemButton195"
        anchors.right: adiBagsItemButton195.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton195.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton196
        name: "AdiBagsItemButton196"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton196Count
        name: "AdiBagsItemButton196Count"
        text: "5"
        wowParent: "AdiBagsItemButton196"
        anchors.right: adiBagsItemButton196.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton196.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton197
        name: "AdiBagsItemButton197"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton197Count
        name: "AdiBagsItemButton197Count"
        text: "5"
        anchors.right: adiBagsItemButton197.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton197.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Button {
        id: adiBagsItemButton198
        name: "AdiBagsItemButton198"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton198Count
        name: "AdiBagsItemButton198Count"
        text: "20"
        wowParent: "AdiBagsItemButton198"
        anchors.right: adiBagsItemButton198.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton198.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton199
        name: "AdiBagsItemButton199"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection12.left
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton199Count
        name: "AdiBagsItemButton199Count"
        text: "20"
        anchors.right: adiBagsItemButton199.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton199.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton200
        name: "AdiBagsItemButton200"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton200Count
        name: "AdiBagsItemButton200Count"
        text: "10"
        wowParent: "AdiBagsItemButton200"
        anchors.right: adiBagsItemButton200.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton200.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton201
        name: "AdiBagsItemButton201"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton201Count
        name: "AdiBagsItemButton201Count"
        text: "2"
        wowParent: "AdiBagsItemButton201"
        anchors.right: adiBagsItemButton201.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton201.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton202
        name: "AdiBagsItemButton202"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton202Count
        name: "AdiBagsItemButton202Count"
        text: "2"
        anchors.right: adiBagsItemButton202.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton202.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Button {
        id: adiBagsItemButton203
        name: "AdiBagsItemButton203"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 182
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton203Count
        name: "AdiBagsItemButton203Count"
        text: "15"
        wowParent: "AdiBagsItemButton203"
        anchors.right: adiBagsItemButton203.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton203.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton204
        name: "AdiBagsItemButton204"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 223
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton204Count
        name: "AdiBagsItemButton204Count"
        text: "13"
        wowParent: "AdiBagsItemButton204"
        anchors.right: adiBagsItemButton204.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton204.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton205
        name: "AdiBagsItemButton205"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton205Count
        name: "AdiBagsItemButton205Count"
        text: "15"
        anchors.right: adiBagsItemButton205.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton205.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton206
        name: "AdiBagsItemButton206"
        wowParent: "AdiBagsItemContainer11"
        anchors.left: adiBagsSection15.left
        anchors.top: adiBagsSection15.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton206Count
        name: "AdiBagsItemButton206Count"
        text: "13"
        anchors.right: adiBagsItemButton206.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton206.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton207
        name: "AdiBagsItemButton207"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection18.left
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton208
        name: "AdiBagsItemButton208"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection18.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection18.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton209
        name: "AdiBagsItemButton209"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 246
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton210
        name: "AdiBagsItemButton210"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton210Count
        name: "AdiBagsItemButton210Count"
        text: "2"
        wowParent: "AdiBagsItemButton210"
        anchors.right: adiBagsItemButton210.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton210.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton211
        name: "AdiBagsItemButton211"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton212
        name: "AdiBagsItemButton212"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton212Count
        name: "AdiBagsItemButton212Count"
        text: "5"
        wowParent: "AdiBagsItemButton212"
        anchors.right: adiBagsItemButton212.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton212.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton213
        name: "AdiBagsItemButton213"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton213Count
        name: "AdiBagsItemButton213Count"
        text: "20"
        wowParent: "AdiBagsItemButton213"
        anchors.right: adiBagsItemButton213.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton213.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton214
        name: "AdiBagsItemButton214"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 287
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton214Count
        name: "AdiBagsItemButton214Count"
        text: "20"
        wowParent: "AdiBagsItemButton214"
        anchors.right: adiBagsItemButton214.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton214.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton215
        name: "AdiBagsItemButton215"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 223
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton215Count
        name: "AdiBagsItemButton215Count"
        text: "4"
        wowParent: "AdiBagsItemButton215"
        anchors.right: adiBagsItemButton215.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton215.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton216
        name: "AdiBagsItemButton216"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 41
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton216Count
        name: "AdiBagsItemButton216Count"
        text: "20"
        anchors.right: adiBagsItemButton216.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton216.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
    }

    Button {
        id: adiBagsItemButton217
        name: "AdiBagsItemButton217"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 141
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton217Count
        name: "AdiBagsItemButton217Count"
        text: "4"
        anchors.right: adiBagsItemButton217.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton217.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Button {
        id: adiBagsItemButton218
        name: "AdiBagsItemButton218"
        wowParent: "AdiBagsItemContainer8"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton218Count
        name: "AdiBagsItemButton218Count"
        text: "8"
        wowParent: "AdiBagsItemButton218"
        anchors.right: adiBagsItemButton218.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton218.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton219
        name: "AdiBagsItemButton219"
        wowParent: "AdiBagsItemContainer10"
        anchors.left: adiBagsSection16.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection16.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton220
        name: "AdiBagsItemButton220"
        wowParent: "AdiBagsItemContainer6"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 205
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton220Count
        name: "AdiBagsItemButton220Count"
        text: "96"
        wowParent: "AdiBagsItemButton220"
        anchors.right: adiBagsItemButton220.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton220.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Button {
        id: adiBagsItemButton221
        name: "AdiBagsItemButton221"
        wowParent: "AdiBagsItemContainer9"
        anchors.left: adiBagsSection14.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection14.top
        anchors.topMargin: 18
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton222
        name: "AdiBagsItemButton222"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection12.left
        anchors.leftMargin: 123
        anchors.top: adiBagsSection12.top
        anchors.topMargin: 223
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton222Count
        name: "AdiBagsItemButton222Count"
        text: "2"
        wowParent: "AdiBagsItemButton222"
        anchors.right: adiBagsItemButton222.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton222.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Button {
        id: adiBagsItemButton223
        name: "AdiBagsItemButton223"
        wowParent: "AdiBagsItemContainer7"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton224
        name: "AdiBagsItemButton224"
        wowParent: "AdiBagsItemContainer5"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 82
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
    }

    FontString {
        id: adiBagsItemButton224Count
        name: "AdiBagsItemButton224Count"
        text: "2"
        anchors.right: adiBagsItemButton224.right
        anchors.rightMargin: 5
        anchors.bottom: adiBagsItemButton224.bottom
        anchors.bottomMargin: 2
        width: 6
        height: 12
    }

    Button {
        id: adiBagsItemButton225
        name: "AdiBagsItemButton225"
        anchors.left: adiBagsSection13.left
        anchors.leftMargin: 328
        anchors.top: adiBagsSection13.top
        anchors.topMargin: 100
        width: 37
        height: 37
    }

    Button {
        id: adiBagsItemButton226
        name: "AdiBagsItemButton226"
        anchors.left: adiBagsSection19.left
        anchors.leftMargin: 164
        anchors.top: adiBagsSection19.top
        anchors.topMargin: 59
        width: 37
        height: 37
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
        id: adiBagsSection13
        name: "AdiBagsSection13"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 389.3
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 32
        width: 365
        height: 178
    }

    Frame {
        id: adiBagsSection14
        name: "AdiBagsSection14"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 770.7
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 191
        width: 365
        height: 137
    }

    Frame {
        id: adiBagsSection15
        name: "AdiBagsSection15"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 770.7
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 332
        width: 160
        height: 55
    }

    Frame {
        id: adiBagsSection16
        name: "AdiBagsSection16"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 8
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 32
        width: 365
        height: 96
    }

    Frame {
        id: adiBagsSection17
        name: "AdiBagsSection17"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 865
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 132
        width: 37
        height: 55
    }

    Frame {
        id: adiBagsSection18
        name: "AdiBagsSection18"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 770.7
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 32
        width: 365
        height: 96
    }

    Frame {
        id: adiBagsSection19
        name: "AdiBagsSection19"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 389.3
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 214
        width: 365
        height: 137
    }

    Frame {
        id: adiBagsSection20
        name: "AdiBagsSection20"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 389.3
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 355
        width: 78
        height: 55
    }

    Frame {
        id: adiBagsSection21
        name: "AdiBagsSection21"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 947
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 332
        width: 37
        height: 55
    }

    Frame {
        id: adiBagsSection22
        name: "AdiBagsSection22"
        wowParent: "AdiBagsContainer2"
        anchors.left: adiBagsContainer2.left
        anchors.leftMargin: 770.7
        anchors.top: adiBagsContainer2.top
        anchors.topMargin: 132
        width: 78
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
}
