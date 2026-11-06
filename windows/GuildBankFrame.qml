// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: guildBankFrame
    name: "GuildBankFrame"
    width: 769
    height: 444

    // the slots, logs and info 27 higher than Blizzard's: as far from the band
    // as from the foot's iron bar
    Part {
        id: guildBankColumn1
        name: "GuildBankColumn1"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: 30
        anchors.top: guildBankFrame.top
        anchors.topMargin: 43
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn1Button1
        name: "GuildBankColumn1Button1"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn1.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button10
        name: "GuildBankColumn1Button10"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button9.left
        anchors.top: guildBankColumn1Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button10Count
        name: "GuildBankColumn1Button10Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn1Button10"
        anchors.right: guildBankColumn1Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button10.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button11
        name: "GuildBankColumn1Button11"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button10.left
        anchors.top: guildBankColumn1Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button11Count
        name: "GuildBankColumn1Button11Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn1Button11"
        anchors.right: guildBankColumn1Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button11.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button12
        name: "GuildBankColumn1Button12"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button11.left
        anchors.top: guildBankColumn1Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button12Count
        name: "GuildBankColumn1Button12Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn1Button12"
        anchors.right: guildBankColumn1Button12.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button12.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button13
        name: "GuildBankColumn1Button13"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button12.left
        anchors.top: guildBankColumn1Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button13Count
        name: "GuildBankColumn1Button13Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn1Button13"
        anchors.right: guildBankColumn1Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button13.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button14
        name: "GuildBankColumn1Button14"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button13.left
        anchors.top: guildBankColumn1Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button14Count
        name: "GuildBankColumn1Button14Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn1Button14"
        anchors.right: guildBankColumn1Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button14.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button1Count
        name: "GuildBankColumn1Button1Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn1Button1"
        anchors.right: guildBankColumn1Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button1.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button2
        name: "GuildBankColumn1Button2"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button1.left
        anchors.top: guildBankColumn1Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button2Count
        name: "GuildBankColumn1Button2Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn1Button2"
        anchors.right: guildBankColumn1Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button2.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button3
        name: "GuildBankColumn1Button3"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button2.left
        anchors.top: guildBankColumn1Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button3Count
        name: "GuildBankColumn1Button3Count"
        kind: "FontString"
        text: "7"
        wowParent: "GuildBankColumn1Button3"
        anchors.right: guildBankColumn1Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button3.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button4
        name: "GuildBankColumn1Button4"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button3.left
        anchors.top: guildBankColumn1Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button4Count
        name: "GuildBankColumn1Button4Count"
        kind: "FontString"
        text: "5"
        wowParent: "GuildBankColumn1Button4"
        anchors.right: guildBankColumn1Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button4.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button5
        name: "GuildBankColumn1Button5"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button4.left
        anchors.top: guildBankColumn1Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button5Count
        name: "GuildBankColumn1Button5Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn1Button5"
        anchors.right: guildBankColumn1Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button5.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button6
        name: "GuildBankColumn1Button6"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button5.left
        anchors.top: guildBankColumn1Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button6Count
        name: "GuildBankColumn1Button6Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn1Button6"
        anchors.right: guildBankColumn1Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button6.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button7
        name: "GuildBankColumn1Button7"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button6.left
        anchors.top: guildBankColumn1Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button7Count
        name: "GuildBankColumn1Button7Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn1Button7"
        anchors.right: guildBankColumn1Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button7.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button8
        name: "GuildBankColumn1Button8"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn1Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button8Count
        name: "GuildBankColumn1Button8Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn1Button8"
        anchors.right: guildBankColumn1Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button8.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn1Button9
        name: "GuildBankColumn1Button9"
        kind: "Button"
        wowParent: "GuildBankColumn1"
        anchors.left: guildBankColumn1Button8.left
        anchors.top: guildBankColumn1Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn1Button9Count
        name: "GuildBankColumn1Button9Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn1Button9"
        anchors.right: guildBankColumn1Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn1Button9.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2
        name: "GuildBankColumn2"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn1.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn1.top
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn2Button1
        name: "GuildBankColumn2Button1"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn2.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button10
        name: "GuildBankColumn2Button10"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button9.left
        anchors.top: guildBankColumn2Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button10Count
        name: "GuildBankColumn2Button10Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn2Button10"
        anchors.right: guildBankColumn2Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button10.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button11
        name: "GuildBankColumn2Button11"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button10.left
        anchors.top: guildBankColumn2Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button11Count
        name: "GuildBankColumn2Button11Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn2Button11"
        anchors.right: guildBankColumn2Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button11.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button12
        name: "GuildBankColumn2Button12"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button11.left
        anchors.top: guildBankColumn2Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button12Count
        name: "GuildBankColumn2Button12Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn2Button12"
        anchors.right: guildBankColumn2Button12.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button12.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button13
        name: "GuildBankColumn2Button13"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button12.left
        anchors.top: guildBankColumn2Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button13Count
        name: "GuildBankColumn2Button13Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn2Button13"
        anchors.right: guildBankColumn2Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button13.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button14
        name: "GuildBankColumn2Button14"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button13.left
        anchors.top: guildBankColumn2Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button14Count
        name: "GuildBankColumn2Button14Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn2Button14"
        anchors.right: guildBankColumn2Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button14.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button1Count
        name: "GuildBankColumn2Button1Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn2Button1"
        anchors.right: guildBankColumn2Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button1.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button2
        name: "GuildBankColumn2Button2"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button1.left
        anchors.top: guildBankColumn2Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button2Count
        name: "GuildBankColumn2Button2Count"
        kind: "FontString"
        text: "4"
        wowParent: "GuildBankColumn2Button2"
        anchors.right: guildBankColumn2Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button2.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button3
        name: "GuildBankColumn2Button3"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button2.left
        anchors.top: guildBankColumn2Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button3Count
        name: "GuildBankColumn2Button3Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn2Button3"
        anchors.right: guildBankColumn2Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button3.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button4
        name: "GuildBankColumn2Button4"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button3.left
        anchors.top: guildBankColumn2Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button4Count
        name: "GuildBankColumn2Button4Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn2Button4"
        anchors.right: guildBankColumn2Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button4.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button5
        name: "GuildBankColumn2Button5"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button4.left
        anchors.top: guildBankColumn2Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button5Count
        name: "GuildBankColumn2Button5Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn2Button5"
        anchors.right: guildBankColumn2Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button5.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button6
        name: "GuildBankColumn2Button6"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button5.left
        anchors.top: guildBankColumn2Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button6Count
        name: "GuildBankColumn2Button6Count"
        kind: "FontString"
        text: "4"
        wowParent: "GuildBankColumn2Button6"
        anchors.right: guildBankColumn2Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button6.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button7
        name: "GuildBankColumn2Button7"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button6.left
        anchors.top: guildBankColumn2Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button7Count
        name: "GuildBankColumn2Button7Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn2Button7"
        anchors.right: guildBankColumn2Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button7.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button8
        name: "GuildBankColumn2Button8"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn2Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button8Count
        name: "GuildBankColumn2Button8Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn2Button8"
        anchors.right: guildBankColumn2Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button8.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn2Button9
        name: "GuildBankColumn2Button9"
        kind: "Button"
        wowParent: "GuildBankColumn2"
        anchors.left: guildBankColumn2Button8.left
        anchors.top: guildBankColumn2Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn2Button9Count
        name: "GuildBankColumn2Button9Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn2Button9"
        anchors.right: guildBankColumn2Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn2Button9.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn3
        name: "GuildBankColumn3"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn2.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn2.top
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn3Button1
        name: "GuildBankColumn3Button1"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn3.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button10
        name: "GuildBankColumn3Button10"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button9.left
        anchors.top: guildBankColumn3Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button10Count
        name: "GuildBankColumn3Button10Count"
        kind: "FontString"
        text: "12"
        wowParent: "GuildBankColumn3Button10"
        anchors.right: guildBankColumn3Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button10.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button11
        name: "GuildBankColumn3Button11"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button10.left
        anchors.top: guildBankColumn3Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button11Count
        name: "GuildBankColumn3Button11Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button11"
        anchors.right: guildBankColumn3Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button11.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button12
        name: "GuildBankColumn3Button12"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button11.left
        anchors.top: guildBankColumn3Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button12Count
        name: "GuildBankColumn3Button12Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button12"
        anchors.right: guildBankColumn3Button12.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button12.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button13
        name: "GuildBankColumn3Button13"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button12.left
        anchors.top: guildBankColumn3Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button13Count
        name: "GuildBankColumn3Button13Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button13"
        anchors.right: guildBankColumn3Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button13.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button14
        name: "GuildBankColumn3Button14"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button13.left
        anchors.top: guildBankColumn3Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button14Count
        name: "GuildBankColumn3Button14Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button14"
        anchors.right: guildBankColumn3Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button14.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button1Count
        name: "GuildBankColumn3Button1Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button1"
        anchors.right: guildBankColumn3Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button1.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button2
        name: "GuildBankColumn3Button2"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button1.left
        anchors.top: guildBankColumn3Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button2Count
        name: "GuildBankColumn3Button2Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button2"
        anchors.right: guildBankColumn3Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button2.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button3
        name: "GuildBankColumn3Button3"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button2.left
        anchors.top: guildBankColumn3Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button3Count
        name: "GuildBankColumn3Button3Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button3"
        anchors.right: guildBankColumn3Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button3.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button4
        name: "GuildBankColumn3Button4"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button3.left
        anchors.top: guildBankColumn3Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button4Count
        name: "GuildBankColumn3Button4Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button4"
        anchors.right: guildBankColumn3Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button4.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button5
        name: "GuildBankColumn3Button5"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button4.left
        anchors.top: guildBankColumn3Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button5Count
        name: "GuildBankColumn3Button5Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button5"
        anchors.right: guildBankColumn3Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button5.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button6
        name: "GuildBankColumn3Button6"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button5.left
        anchors.top: guildBankColumn3Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button6Count
        name: "GuildBankColumn3Button6Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button6"
        anchors.right: guildBankColumn3Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button6.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button7
        name: "GuildBankColumn3Button7"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button6.left
        anchors.top: guildBankColumn3Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button7Count
        name: "GuildBankColumn3Button7Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button7"
        anchors.right: guildBankColumn3Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button7.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button8
        name: "GuildBankColumn3Button8"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn3Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button8Count
        name: "GuildBankColumn3Button8Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn3Button8"
        anchors.right: guildBankColumn3Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button8.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn3Button9
        name: "GuildBankColumn3Button9"
        kind: "Button"
        wowParent: "GuildBankColumn3"
        anchors.left: guildBankColumn3Button8.left
        anchors.top: guildBankColumn3Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn3Button9Count
        name: "GuildBankColumn3Button9Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn3Button9"
        anchors.right: guildBankColumn3Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn3Button9.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn4
        name: "GuildBankColumn4"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn3.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn3.top
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn4Button1
        name: "GuildBankColumn4Button1"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn4.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button10
        name: "GuildBankColumn4Button10"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button9.left
        anchors.top: guildBankColumn4Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button10Count
        name: "GuildBankColumn4Button10Count"
        kind: "FontString"
        text: "8"
        wowParent: "GuildBankColumn4Button10"
        anchors.right: guildBankColumn4Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button10.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button11
        name: "GuildBankColumn4Button11"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button10.left
        anchors.top: guildBankColumn4Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button11Count
        name: "GuildBankColumn4Button11Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button11"
        anchors.right: guildBankColumn4Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button11.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button12
        name: "GuildBankColumn4Button12"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button11.left
        anchors.top: guildBankColumn4Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button12Count
        name: "GuildBankColumn4Button12Count"
        kind: "FontString"
        text: "16"
        wowParent: "GuildBankColumn4Button12"
        anchors.right: guildBankColumn4Button12.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button12.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button13
        name: "GuildBankColumn4Button13"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button12.left
        anchors.top: guildBankColumn4Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button13Count
        name: "GuildBankColumn4Button13Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button13"
        anchors.right: guildBankColumn4Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button13.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button14
        name: "GuildBankColumn4Button14"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button13.left
        anchors.top: guildBankColumn4Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button14Count
        name: "GuildBankColumn4Button14Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn4Button14"
        anchors.right: guildBankColumn4Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button14.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button1Count
        name: "GuildBankColumn4Button1Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button1"
        anchors.right: guildBankColumn4Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button1.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button2
        name: "GuildBankColumn4Button2"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button1.left
        anchors.top: guildBankColumn4Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button2Count
        name: "GuildBankColumn4Button2Count"
        kind: "FontString"
        text: "13"
        wowParent: "GuildBankColumn4Button2"
        anchors.right: guildBankColumn4Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button2.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button3
        name: "GuildBankColumn4Button3"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button2.left
        anchors.top: guildBankColumn4Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button3Count
        name: "GuildBankColumn4Button3Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button3"
        anchors.right: guildBankColumn4Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button3.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button4
        name: "GuildBankColumn4Button4"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button3.left
        anchors.top: guildBankColumn4Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button4Count
        name: "GuildBankColumn4Button4Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn4Button4"
        anchors.right: guildBankColumn4Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button4.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button5
        name: "GuildBankColumn4Button5"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button4.left
        anchors.top: guildBankColumn4Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button5Count
        name: "GuildBankColumn4Button5Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn4Button5"
        anchors.right: guildBankColumn4Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button5.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button6
        name: "GuildBankColumn4Button6"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button5.left
        anchors.top: guildBankColumn4Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button6Count
        name: "GuildBankColumn4Button6Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button6"
        anchors.right: guildBankColumn4Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button6.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button7
        name: "GuildBankColumn4Button7"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button6.left
        anchors.top: guildBankColumn4Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button7Count
        name: "GuildBankColumn4Button7Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button7"
        anchors.right: guildBankColumn4Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button7.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button8
        name: "GuildBankColumn4Button8"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn4Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button8Count
        name: "GuildBankColumn4Button8Count"
        kind: "FontString"
        text: "9"
        wowParent: "GuildBankColumn4Button8"
        anchors.right: guildBankColumn4Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button8.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn4Button9
        name: "GuildBankColumn4Button9"
        kind: "Button"
        wowParent: "GuildBankColumn4"
        anchors.left: guildBankColumn4Button8.left
        anchors.top: guildBankColumn4Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn4Button9Count
        name: "GuildBankColumn4Button9Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn4Button9"
        anchors.right: guildBankColumn4Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn4Button9.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn5
        name: "GuildBankColumn5"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn4.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn4.top
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn5Button1
        name: "GuildBankColumn5Button1"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn5.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button10
        name: "GuildBankColumn5Button10"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button9.left
        anchors.top: guildBankColumn5Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button10Count
        name: "GuildBankColumn5Button10Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn5Button10"
        anchors.right: guildBankColumn5Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button10.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button11
        name: "GuildBankColumn5Button11"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button10.left
        anchors.top: guildBankColumn5Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button11Count
        name: "GuildBankColumn5Button11Count"
        kind: "FontString"
        text: "9"
        wowParent: "GuildBankColumn5Button11"
        anchors.right: guildBankColumn5Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button11.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button12
        name: "GuildBankColumn5Button12"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button11.left
        anchors.top: guildBankColumn5Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button13
        name: "GuildBankColumn5Button13"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button12.left
        anchors.top: guildBankColumn5Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button13Count
        name: "GuildBankColumn5Button13Count"
        kind: "FontString"
        text: "11"
        wowParent: "GuildBankColumn5Button13"
        anchors.right: guildBankColumn5Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button13.bottom
        anchors.bottomMargin: 2
        width: 15
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button14
        name: "GuildBankColumn5Button14"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button13.left
        anchors.top: guildBankColumn5Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button14Count
        name: "GuildBankColumn5Button14Count"
        kind: "FontString"
        text: "15"
        wowParent: "GuildBankColumn5Button14"
        anchors.right: guildBankColumn5Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button14.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button1Count
        name: "GuildBankColumn5Button1Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn5Button1"
        anchors.right: guildBankColumn5Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button1.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button2
        name: "GuildBankColumn5Button2"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button1.left
        anchors.top: guildBankColumn5Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button2Count
        name: "GuildBankColumn5Button2Count"
        kind: "FontString"
        text: "4"
        wowParent: "GuildBankColumn5Button2"
        anchors.right: guildBankColumn5Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button2.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button3
        name: "GuildBankColumn5Button3"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button2.left
        anchors.top: guildBankColumn5Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button3Count
        name: "GuildBankColumn5Button3Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn5Button3"
        anchors.right: guildBankColumn5Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button3.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button4
        name: "GuildBankColumn5Button4"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button3.left
        anchors.top: guildBankColumn5Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button4Count
        name: "GuildBankColumn5Button4Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn5Button4"
        anchors.right: guildBankColumn5Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button4.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button5
        name: "GuildBankColumn5Button5"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button4.left
        anchors.top: guildBankColumn5Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button5Count
        name: "GuildBankColumn5Button5Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn5Button5"
        anchors.right: guildBankColumn5Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button5.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button6
        name: "GuildBankColumn5Button6"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button5.left
        anchors.top: guildBankColumn5Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button6Count
        name: "GuildBankColumn5Button6Count"
        kind: "FontString"
        text: "6"
        wowParent: "GuildBankColumn5Button6"
        anchors.right: guildBankColumn5Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button6.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button7
        name: "GuildBankColumn5Button7"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button6.left
        anchors.top: guildBankColumn5Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button7Count
        name: "GuildBankColumn5Button7Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn5Button7"
        anchors.right: guildBankColumn5Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button7.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button8
        name: "GuildBankColumn5Button8"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn5Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button8Count
        name: "GuildBankColumn5Button8Count"
        kind: "FontString"
        text: "19"
        wowParent: "GuildBankColumn5Button8"
        anchors.right: guildBankColumn5Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button8.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn5Button9
        name: "GuildBankColumn5Button9"
        kind: "Button"
        wowParent: "GuildBankColumn5"
        anchors.left: guildBankColumn5Button8.left
        anchors.top: guildBankColumn5Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn5Button9Count
        name: "GuildBankColumn5Button9Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn5Button9"
        anchors.right: guildBankColumn5Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn5Button9.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6
        name: "GuildBankColumn6"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn5.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn5.top
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn6Button1
        name: "GuildBankColumn6Button1"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn6.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button10
        name: "GuildBankColumn6Button10"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button9.left
        anchors.top: guildBankColumn6Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button10Count
        name: "GuildBankColumn6Button10Count"
        kind: "FontString"
        text: "4"
        wowParent: "GuildBankColumn6Button10"
        anchors.right: guildBankColumn6Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button10.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button11
        name: "GuildBankColumn6Button11"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button10.left
        anchors.top: guildBankColumn6Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button11Count
        name: "GuildBankColumn6Button11Count"
        kind: "FontString"
        text: "4"
        wowParent: "GuildBankColumn6Button11"
        anchors.right: guildBankColumn6Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button11.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button12
        name: "GuildBankColumn6Button12"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button11.left
        anchors.top: guildBankColumn6Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button12Count
        name: "GuildBankColumn6Button12Count"
        kind: "FontString"
        text: "18"
        wowParent: "GuildBankColumn6Button12"
        anchors.right: guildBankColumn6Button12.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button12.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button13
        name: "GuildBankColumn6Button13"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button12.left
        anchors.top: guildBankColumn6Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button13Count
        name: "GuildBankColumn6Button13Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn6Button13"
        anchors.right: guildBankColumn6Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button13.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button14
        name: "GuildBankColumn6Button14"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button13.left
        anchors.top: guildBankColumn6Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button14Count
        name: "GuildBankColumn6Button14Count"
        kind: "FontString"
        text: "8"
        wowParent: "GuildBankColumn6Button14"
        anchors.right: guildBankColumn6Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button14.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button1Count
        name: "GuildBankColumn6Button1Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn6Button1"
        anchors.right: guildBankColumn6Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button1.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button2
        name: "GuildBankColumn6Button2"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button1.left
        anchors.top: guildBankColumn6Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button2Count
        name: "GuildBankColumn6Button2Count"
        kind: "FontString"
        text: "5"
        wowParent: "GuildBankColumn6Button2"
        anchors.right: guildBankColumn6Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button2.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button3
        name: "GuildBankColumn6Button3"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button2.left
        anchors.top: guildBankColumn6Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button3Count
        name: "GuildBankColumn6Button3Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn6Button3"
        anchors.right: guildBankColumn6Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button3.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button4
        name: "GuildBankColumn6Button4"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button3.left
        anchors.top: guildBankColumn6Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button4Count
        name: "GuildBankColumn6Button4Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn6Button4"
        anchors.right: guildBankColumn6Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button4.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button5
        name: "GuildBankColumn6Button5"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button4.left
        anchors.top: guildBankColumn6Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button5Count
        name: "GuildBankColumn6Button5Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn6Button5"
        anchors.right: guildBankColumn6Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button5.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button6
        name: "GuildBankColumn6Button6"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button5.left
        anchors.top: guildBankColumn6Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button6Count
        name: "GuildBankColumn6Button6Count"
        kind: "FontString"
        text: "9"
        wowParent: "GuildBankColumn6Button6"
        anchors.right: guildBankColumn6Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button6.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button7
        name: "GuildBankColumn6Button7"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button6.left
        anchors.top: guildBankColumn6Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button7Count
        name: "GuildBankColumn6Button7Count"
        kind: "FontString"
        text: "2"
        wowParent: "GuildBankColumn6Button7"
        anchors.right: guildBankColumn6Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button7.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button8
        name: "GuildBankColumn6Button8"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn6Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button8Count
        name: "GuildBankColumn6Button8Count"
        kind: "FontString"
        text: "5"
        wowParent: "GuildBankColumn6Button8"
        anchors.right: guildBankColumn6Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button8.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn6Button9
        name: "GuildBankColumn6Button9"
        kind: "Button"
        wowParent: "GuildBankColumn6"
        anchors.left: guildBankColumn6Button8.left
        anchors.top: guildBankColumn6Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn6Button9Count
        name: "GuildBankColumn6Button9Count"
        kind: "FontString"
        text: "6"
        wowParent: "GuildBankColumn6Button9"
        anchors.right: guildBankColumn6Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn6Button9.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7
        name: "GuildBankColumn7"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankColumn6.right
        anchors.leftMargin: 3
        anchors.top: guildBankColumn6.top
        width: 100
        height: 311
    }

    Part {
        id: guildBankColumn7Button1
        name: "GuildBankColumn7Button1"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7.left
        anchors.leftMargin: 7
        anchors.top: guildBankColumn7.top
        anchors.topMargin: 3
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button10
        name: "GuildBankColumn7Button10"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button9.left
        anchors.top: guildBankColumn7Button9.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button10Count
        name: "GuildBankColumn7Button10Count"
        kind: "FontString"
        text: "8"
        wowParent: "GuildBankColumn7Button10"
        anchors.right: guildBankColumn7Button10.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button10.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button11
        name: "GuildBankColumn7Button11"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button10.left
        anchors.top: guildBankColumn7Button10.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button11Count
        name: "GuildBankColumn7Button11Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn7Button11"
        anchors.right: guildBankColumn7Button11.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button11.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button12
        name: "GuildBankColumn7Button12"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button11.left
        anchors.top: guildBankColumn7Button11.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button12Count
        name: "GuildBankColumn7Button12Count"
        kind: "FontString"
        text: "10"
        wowParent: "GuildBankColumn7Button12"
        anchors.right: guildBankColumn7Button12.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button12.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button13
        name: "GuildBankColumn7Button13"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button12.left
        anchors.top: guildBankColumn7Button12.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button13Count
        name: "GuildBankColumn7Button13Count"
        kind: "FontString"
        text: "11"
        wowParent: "GuildBankColumn7Button13"
        anchors.right: guildBankColumn7Button13.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button13.bottom
        anchors.bottomMargin: 2
        width: 15
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button14
        name: "GuildBankColumn7Button14"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button13.left
        anchors.top: guildBankColumn7Button13.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button14Count
        name: "GuildBankColumn7Button14Count"
        kind: "FontString"
        text: "7"
        wowParent: "GuildBankColumn7Button14"
        anchors.right: guildBankColumn7Button14.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button14.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button1Count
        name: "GuildBankColumn7Button1Count"
        kind: "FontString"
        text: "3"
        wowParent: "GuildBankColumn7Button1"
        anchors.right: guildBankColumn7Button1.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button1.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button2
        name: "GuildBankColumn7Button2"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button1.left
        anchors.top: guildBankColumn7Button1.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button2Count
        name: "GuildBankColumn7Button2Count"
        kind: "FontString"
        text: "7"
        wowParent: "GuildBankColumn7Button2"
        anchors.right: guildBankColumn7Button2.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button2.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button3
        name: "GuildBankColumn7Button3"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button2.left
        anchors.top: guildBankColumn7Button2.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button3Count
        name: "GuildBankColumn7Button3Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn7Button3"
        anchors.right: guildBankColumn7Button3.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button3.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button4
        name: "GuildBankColumn7Button4"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button3.left
        anchors.top: guildBankColumn7Button3.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button4Count
        name: "GuildBankColumn7Button4Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn7Button4"
        anchors.right: guildBankColumn7Button4.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button4.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button5
        name: "GuildBankColumn7Button5"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button4.left
        anchors.top: guildBankColumn7Button4.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button5Count
        name: "GuildBankColumn7Button5Count"
        kind: "FontString"
        text: "9"
        wowParent: "GuildBankColumn7Button5"
        anchors.right: guildBankColumn7Button5.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button5.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button6
        name: "GuildBankColumn7Button6"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button5.left
        anchors.top: guildBankColumn7Button5.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button6Count
        name: "GuildBankColumn7Button6Count"
        kind: "FontString"
        text: "4"
        wowParent: "GuildBankColumn7Button6"
        anchors.right: guildBankColumn7Button6.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button6.bottom
        anchors.bottomMargin: 2
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button7
        name: "GuildBankColumn7Button7"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button6.left
        anchors.top: guildBankColumn7Button6.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button7Count
        name: "GuildBankColumn7Button7Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn7Button7"
        anchors.right: guildBankColumn7Button7.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button7.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button8
        name: "GuildBankColumn7Button8"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button1.right
        anchors.leftMargin: 12
        anchors.top: guildBankColumn7Button1.top
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button8Count
        name: "GuildBankColumn7Button8Count"
        kind: "FontString"
        text: "20"
        wowParent: "GuildBankColumn7Button8"
        anchors.right: guildBankColumn7Button8.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button8.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankColumn7Button9
        name: "GuildBankColumn7Button9"
        kind: "Button"
        wowParent: "GuildBankColumn7"
        anchors.left: guildBankColumn7Button8.left
        anchors.top: guildBankColumn7Button8.bottom
        anchors.topMargin: 7
        width: 37
        height: 37
    }

    Part {
        id: guildBankColumn7Button9Count
        name: "GuildBankColumn7Button9Count"
        kind: "FontString"
        text: "10"
        wowParent: "GuildBankColumn7Button9"
        anchors.right: guildBankColumn7Button9.right
        anchors.rightMargin: 5
        anchors.bottom: guildBankColumn7Button9.bottom
        anchors.bottomMargin: 2
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankEmblemFrame
        name: "GuildBankEmblemFrame"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.horizontalCenter: guildBankFrameDiabolicBorder.horizontalCenter
        anchors.horizontalCenterOffset: -70
        anchors.bottom: guildBankFrameDiabolicBorder.top
        anchors.bottomMargin: -15
        width: 700
        height: 80
    }

    Part {
        id: guildBankFrameDepositButton
        name: "GuildBankFrameDepositButton"
        kind: "Button"
        text: "Deposit"
        wowParent: "GuildBankFrame"
        style: "Button"
        anchors.right: guildBankFrame.right
        anchors.rightMargin: 11
        anchors.bottom: guildBankFrame.bottom
        anchors.bottomMargin: 37
        width: 95.5
        height: 21
    }

    Part {
        id: guildBankFrameDepositButtonText
        name: "GuildBankFrameDepositButtonText"
        kind: "FontString"
        text: "Deposit"
        wowParent: "GuildBankFrameDepositButton"
        anchors.horizontalCenter: guildBankFrameDepositButton.horizontalCenter
        anchors.verticalCenter: guildBankFrameDepositButton.verticalCenter
        width: 56.1
        height: 11.9
    }

    Part {
        id: guildBankFrameDiabolic
        name: "GuildBankFrameDiabolic"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: -24
        anchors.top: guildBankFrame.top
        anchors.topMargin: -28
        width: 817
        height: 508
    }

    Part {
        id: guildBankFrameDiabolicBorder
        name: "GuildBankFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "GuildBankFrameDiabolic"
        anchors.left: guildBankFrameDiabolic.left
        anchors.top: guildBankFrameDiabolic.top
        anchors.topMargin: 32
        width: 817
        height: 476
    }

    Part {
        id: guildBankFrameDiabolicFoot
        name: "GuildBankFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "GuildBankFrameDiabolic"
        anchors.horizontalCenter: guildBankFrameDepositButton.horizontalCenter
        anchors.horizontalCenterOffset: -325.7
        anchors.top: guildBankFrameDepositButton.top
        anchors.topMargin: -6
        width: 771
        height: 77
    }

    Part {
        id: guildBankFrameDiabolicRail
        name: "GuildBankFrameDiabolicRail"
        kind: "Frame"
        wowParent: "GuildBankFrameDiabolic"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Part {
        id: guildBankFrameDiabolicSocket
        name: "GuildBankFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "GuildBankFrameDiabolic"
        anchors.right: guildBankFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: guildBankFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: guildBankFrameDiabolicTitlePlate
        name: "GuildBankFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "GuildBankFrameDiabolic"
        anchors.horizontalCenter: guildBankFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: guildBankFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: guildBankFrameLog
        name: "GuildBankFrameLog"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: guildBankFrame.left
        anchors.top: guildBankFrame.top
        anchors.topMargin: -27
        width: 10
        height: 10
    }

    Part {
        id: guildBankFrameTab1
        name: "GuildBankFrameTab1"
        kind: "Button"
        text: "Guild Bank"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: guildBankFrameTab2
        name: "GuildBankFrameTab2"
        kind: "Button"
        text: "Log"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: guildBankFrameTab3
        name: "GuildBankFrameTab3"
        kind: "Button"
        text: "Money Log"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: guildBankFrameTab4
        name: "GuildBankFrameTab4"
        kind: "Button"
        text: "Info"
        wowParent: "GuildBankFrame"
        style: "Banner"
        anchors.left: guildBankFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: guildBankFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: guildBankFrameWithdrawButton
        name: "GuildBankFrameWithdrawButton"
        kind: "Button"
        text: "Withdraw"
        wowParent: "GuildBankFrame"
        style: "Button"
        anchors.right: guildBankFrame.right
        anchors.rightMargin: 112.5
        anchors.bottom: guildBankFrame.bottom
        anchors.bottomMargin: 37
        width: 95.5
        height: 21
    }

    Part {
        id: guildBankFrameWithdrawButtonText
        name: "GuildBankFrameWithdrawButtonText"
        kind: "FontString"
        text: "Withdraw"
        wowParent: "GuildBankFrameWithdrawButton"
        anchors.horizontalCenter: guildBankFrameWithdrawButton.horizontalCenter
        anchors.verticalCenter: guildBankFrameWithdrawButton.verticalCenter
        width: 76.6
        height: 11.9
    }

    Part {
        id: guildBankInfo
        name: "GuildBankInfo"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        pin: "place"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: 33
        anchors.top: guildBankFrame.top
        anchors.topMargin: 46
        width: 10
        height: 10
    }

    // the info's page the logs' size, in the same place
    Part {
        id: guildBankInfoScrollFrame
        name: "GuildBankInfoScrollFrame"
        kind: "ScrollFrame"
        wowParent: "GuildBankInfo"
        pin: "size"
        anchors.left: guildBankInfo.left
        anchors.top: guildBankInfo.top
        width: 688
        height: 304
    }

    Part {
        id: guildBankInfoScrollFrameDiabolicPanel
        name: "GuildBankInfoScrollFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "GuildBankInfo"
        anchors.left: guildBankInfoScrollFrame.left
        anchors.leftMargin: -16
        anchors.top: guildBankInfoScrollFrame.top
        anchors.topMargin: -6
        width: 730
        height: 316
    }

    Part {
        id: guildBankInfoScrollFrameDiabolicParchment
        name: "GuildBankInfoScrollFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "GuildBankInfo"
        anchors.left: guildBankInfoScrollFrame.left
        anchors.leftMargin: -14
        anchors.top: guildBankInfoScrollFrame.top
        anchors.topMargin: -4
        width: 726
        height: 312
    }

    Part {
        id: guildBankInfoScrollFrameScrollBar
        name: "GuildBankInfoScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "GuildBankInfoScrollFrame"
        style: "ScrollBar"
        anchors.left: guildBankInfoScrollFrame.right
        anchors.leftMargin: 4
        anchors.top: guildBankInfoScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 272
    }

    Part {
        id: guildBankInfoScrollFrameScrollBarDiabolicTrack
        name: "GuildBankInfoScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "GuildBankInfoScrollFrameScrollBar"
        anchors.horizontalCenter: guildBankInfoScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildBankInfoScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 306
    }

    Part {
        id: guildBankInfoScrollFrameScrollBarScrollDownButton
        name: "GuildBankInfoScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "GuildBankInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankInfoScrollFrameScrollBar.horizontalCenter
        anchors.top: guildBankInfoScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: guildBankInfoScrollFrameScrollBarScrollUpButton
        name: "GuildBankInfoScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "GuildBankInfoScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankInfoScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildBankInfoScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: guildBankLimitLabel
        name: "GuildBankLimitLabel"
        kind: "FontString"
        wowParent: "GuildBankFrame"
        anchors.horizontalCenter: guildBankTabLimitBackground.horizontalCenter
        anchors.verticalCenter: guildBankTabLimitBackground.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 254.4
        height: 10.3
    }

    Part {
        id: guildBankMessageFrame
        name: "GuildBankMessageFrame"
        kind: "ScrollingMessageFrame"
        wowParent: "GuildBankFrameLog"
        anchors.left: guildBankFrameLog.left
        anchors.leftMargin: 33
        anchors.top: guildBankFrameLog.top
        anchors.topMargin: 73
        width: 688
        height: 304
    }

    Part {
        id: guildBankMessageFrameDiabolicPanel
        name: "GuildBankMessageFrameDiabolicPanel"
        kind: "Frame"
        wowParent: "GuildBankFrameLog"
        anchors.left: guildBankMessageFrame.left
        anchors.leftMargin: -16
        anchors.top: guildBankMessageFrame.top
        anchors.topMargin: -6
        width: 730
        height: 316
    }

    Part {
        id: guildBankMessageFrameDiabolicParchment
        name: "GuildBankMessageFrameDiabolicParchment"
        kind: "Frame"
        wowParent: "GuildBankFrameLog"
        anchors.left: guildBankMessageFrame.left
        anchors.leftMargin: -14
        anchors.top: guildBankMessageFrame.top
        anchors.topMargin: -4
        width: 726
        height: 312
    }

    Part {
        id: guildBankMoneyFrame
        name: "GuildBankMoneyFrame"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.right: guildBankFrame.right
        anchors.rightMargin: 4
        anchors.bottom: guildBankFrame.bottom
        anchors.bottomMargin: 16
        width: 126.4
        height: 13
    }

    Part {
        id: guildBankMoneyFrameCopperButton
        name: "GuildBankMoneyFrameCopperButton"
        kind: "Button"
        text: "6"
        wowParent: "GuildBankMoneyFrame"
        anchors.right: guildBankMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrame.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: guildBankMoneyFrameCopperButtonText
        name: "GuildBankMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "6"
        wowParent: "GuildBankMoneyFrameCopperButton"
        anchors.right: guildBankMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Part {
        id: guildBankMoneyFrameGoldButton
        name: "GuildBankMoneyFrameGoldButton"
        kind: "Button"
        text: "12008"
        wowParent: "GuildBankMoneyFrame"
        anchors.right: guildBankMoneyFrameSilverButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: guildBankMoneyFrameSilverButton.verticalCenter
        width: 51.7
        height: 13
    }

    Part {
        id: guildBankMoneyFrameGoldButtonText
        name: "GuildBankMoneyFrameGoldButtonText"
        kind: "FontString"
        text: "12008"
        wowParent: "GuildBankMoneyFrameGoldButton"
        anchors.right: guildBankMoneyFrameGoldButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrameGoldButton.verticalCenter
        width: 38.7
        height: 14.2
    }

    Part {
        id: guildBankMoneyFrameSilverButton
        name: "GuildBankMoneyFrameSilverButton"
        kind: "Button"
        text: "16"
        wowParent: "GuildBankMoneyFrame"
        anchors.right: guildBankMoneyFrameCopperButton.left
        anchors.rightMargin: 4
        anchors.verticalCenter: guildBankMoneyFrameCopperButton.verticalCenter
        width: 30.4
        height: 13
    }

    Part {
        id: guildBankMoneyFrameSilverButtonText
        name: "GuildBankMoneyFrameSilverButtonText"
        kind: "FontString"
        text: "16"
        wowParent: "GuildBankMoneyFrameSilverButton"
        anchors.right: guildBankMoneyFrameSilverButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankMoneyFrameSilverButton.verticalCenter
        width: 17.4
        height: 14.2
    }

    Part {
        id: guildBankMoneyLimitLabel
        name: "GuildBankMoneyLimitLabel"
        kind: "FontString"
        text: "Available Amount:"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankFrame.left
        anchors.leftMargin: 26
        anchors.bottom: guildBankFrame.bottom
        anchors.bottomMargin: 16
        width: 98
        height: 13
    }

    Part {
        id: guildBankTab1
        name: "GuildBankTab1"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankFrame.right
        anchors.leftMargin: -1
        anchors.top: guildBankFrame.top
        anchors.topMargin: 32
        width: 42
        height: 50
    }

    Part {
        id: guildBankTab1Button
        name: "GuildBankTab1Button"
        kind: "CheckButton"
        wowParent: "GuildBankTab1"
        anchors.left: guildBankTab1.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab1.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Part {
        id: guildBankTab2
        name: "GuildBankTab2"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab1.left
        anchors.top: guildBankTab1.bottom
        width: 42
        height: 50
    }

    Part {
        id: guildBankTab2Button
        name: "GuildBankTab2Button"
        kind: "CheckButton"
        wowParent: "GuildBankTab2"
        anchors.left: guildBankTab2.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab2.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Part {
        id: guildBankTab3
        name: "GuildBankTab3"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab2.left
        anchors.top: guildBankTab2.bottom
        width: 42
        height: 50
    }

    Part {
        id: guildBankTab3Button
        name: "GuildBankTab3Button"
        kind: "CheckButton"
        wowParent: "GuildBankTab3"
        anchors.left: guildBankTab3.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab3.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Part {
        id: guildBankTab4
        name: "GuildBankTab4"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab3.left
        anchors.top: guildBankTab3.bottom
        width: 42
        height: 50
    }

    Part {
        id: guildBankTab4Button
        name: "GuildBankTab4Button"
        kind: "CheckButton"
        wowParent: "GuildBankTab4"
        anchors.left: guildBankTab4.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab4.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Part {
        id: guildBankTab5
        name: "GuildBankTab5"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab4.left
        anchors.top: guildBankTab4.bottom
        width: 42
        height: 50
    }

    Part {
        id: guildBankTab5Button
        name: "GuildBankTab5Button"
        kind: "CheckButton"
        wowParent: "GuildBankTab5"
        anchors.left: guildBankTab5.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab5.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Part {
        id: guildBankTab6
        name: "GuildBankTab6"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankTab5.left
        anchors.top: guildBankTab5.bottom
        width: 42
        height: 50
    }

    Part {
        id: guildBankTab6Button
        name: "GuildBankTab6Button"
        kind: "CheckButton"
        wowParent: "GuildBankTab6"
        anchors.left: guildBankTab6.left
        anchors.leftMargin: 2
        anchors.top: guildBankTab6.top
        anchors.topMargin: 8
        width: 36
        height: 34
    }

    Part {
        id: guildBankTabInfoEditBox
        name: "GuildBankTabInfoEditBox"
        kind: "EditBox"
        wowParent: "GuildBankInfoScrollFrame"
        pin: "size"
        anchors.left: guildBankInfoScrollFrame.left
        anchors.top: guildBankInfoScrollFrame.top
        width: 688
        height: 218
    }

    Part {
        id: guildBankTransactionsScrollFrame
        name: "GuildBankTransactionsScrollFrame"
        kind: "ScrollFrame"
        wowParent: "GuildBankFrameLog"
        pin: "place"
        anchors.right: guildBankFrame.right
        anchors.rightMargin: 50
        anchors.top: guildBankFrame.top
        anchors.topMargin: 48
        width: 688
        height: 304
    }

    Part {
        id: guildBankTransactionsScrollFrameScrollBar
        name: "GuildBankTransactionsScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "GuildBankTransactionsScrollFrame"
        style: "ScrollBar"
        anchors.left: guildBankTransactionsScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: guildBankTransactionsScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 272
    }

    Part {
        id: guildBankTransactionsScrollFrameScrollBarDiabolicTrack
        name: "GuildBankTransactionsScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "GuildBankTransactionsScrollFrameScrollBar"
        anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: guildBankTransactionsScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 306
    }

    Part {
        id: guildBankTransactionsScrollFrameScrollBarScrollDownButton
        name: "GuildBankTransactionsScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "GuildBankTransactionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBar.horizontalCenter
        anchors.top: guildBankTransactionsScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: guildBankTransactionsScrollFrameScrollBarScrollUpButton
        name: "GuildBankTransactionsScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "GuildBankTransactionsScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: guildBankTransactionsScrollFrameScrollBar.horizontalCenter
        anchors.bottom: guildBankTransactionsScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: guildBankTransactionsScrollFrameScrollChildFrame
        name: "GuildBankTransactionsScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "GuildBankTransactionsScrollFrame"
        anchors.left: guildBankTransactionsScrollFrame.left
        anchors.top: guildBankTransactionsScrollFrame.top
        width: 300
        height: 325
    }

    Part {
        id: guildBankWithdrawMoneyFrame
        name: "GuildBankWithdrawMoneyFrame"
        kind: "Frame"
        wowParent: "GuildBankFrame"
        anchors.left: guildBankMoneyLimitLabel.right
        anchors.leftMargin: 13
        anchors.verticalCenter: guildBankMoneyLimitLabel.verticalCenter
        width: 36.3
        height: 13
    }

    Part {
        id: guildBankWithdrawMoneyFrameCopperButton
        name: "GuildBankWithdrawMoneyFrameCopperButton"
        kind: "Button"
        text: "0"
        wowParent: "GuildBankWithdrawMoneyFrame"
        anchors.right: guildBankWithdrawMoneyFrame.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankWithdrawMoneyFrame.verticalCenter
        width: 23.3
        height: 13
    }

    Part {
        id: guildBankWithdrawMoneyFrameCopperButtonText
        name: "GuildBankWithdrawMoneyFrameCopperButtonText"
        kind: "FontString"
        text: "0"
        wowParent: "GuildBankWithdrawMoneyFrameCopperButton"
        anchors.right: guildBankWithdrawMoneyFrameCopperButton.right
        anchors.rightMargin: 13
        anchors.verticalCenter: guildBankWithdrawMoneyFrameCopperButton.verticalCenter
        width: 10.3
        height: 14.2
    }

    Ghost { id: guildBankTabLimitBackground; name: "GuildBankTabLimitBackground"; x: 390.5; y: 397; width: 0; height: 0 }
}
