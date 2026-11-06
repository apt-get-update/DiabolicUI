// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: keyBindingFrame
    name: "KeyBindingFrame"
    width: 640
    height: 512

    Part {
        id: keyBindingFrameBinding1
        name: "KeyBindingFrameBinding1"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: 27
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 72
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding10
        name: "KeyBindingFrameBinding10"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding9.left
        anchors.top: keyBindingFrameBinding9.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding10Description
        name: "KeyBindingFrameBinding10Description"
        kind: "FontString"
        text: "Target Nearest Friend"
        wowParent: "KeyBindingFrameBinding10"
        anchors.left: keyBindingFrameBinding10.left
        anchors.verticalCenter: keyBindingFrameBinding10.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding10Key1Button
        name: "KeyBindingFrameBinding10Key1Button"
        kind: "Button"
        text: "CTRL-Tab"
        wowParent: "KeyBindingFrameBinding10"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 209.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding10Key1ButtonText
        name: "KeyBindingFrameBinding10Key1ButtonText"
        kind: "FontString"
        text: "CTRL-Tab"
        wowParent: "KeyBindingFrameBinding10Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding10Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding10Key1Button.verticalCenter
        width: 57.7
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding10Key2Button
        name: "KeyBindingFrameBinding10Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding10"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 209.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding10Key2ButtonText
        name: "KeyBindingFrameBinding10Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding10Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding10Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding10Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding11
        name: "KeyBindingFrameBinding11"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding10.left
        anchors.top: keyBindingFrameBinding10.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding11Description
        name: "KeyBindingFrameBinding11Description"
        kind: "FontString"
        text: "Target Previous Friend"
        wowParent: "KeyBindingFrameBinding11"
        anchors.left: keyBindingFrameBinding11.left
        anchors.verticalCenter: keyBindingFrameBinding11.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding11Key1Button
        name: "KeyBindingFrameBinding11Key1Button"
        kind: "Button"
        text: "CTRL-SHIFT-Tab"
        wowParent: "KeyBindingFrameBinding11"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 186.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding11Key1ButtonText
        name: "KeyBindingFrameBinding11Key1ButtonText"
        kind: "FontString"
        text: "CTRL-SHIFT-Tab"
        wowParent: "KeyBindingFrameBinding11Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding11Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding11Key1Button.verticalCenter
        width: 97.2
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding11Key2Button
        name: "KeyBindingFrameBinding11Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding11"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 186.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding11Key2ButtonText
        name: "KeyBindingFrameBinding11Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding11Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding11Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding11Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding12
        name: "KeyBindingFrameBinding12"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding11.left
        anchors.top: keyBindingFrameBinding11.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding12Description
        name: "KeyBindingFrameBinding12Description"
        kind: "FontString"
        text: "Target Nearest Enemy Player"
        wowParent: "KeyBindingFrameBinding12"
        anchors.left: keyBindingFrameBinding12.left
        anchors.verticalCenter: keyBindingFrameBinding12.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding12Key1Button
        name: "KeyBindingFrameBinding12Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding12"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 163.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding12Key1ButtonText
        name: "KeyBindingFrameBinding12Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding12Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding12Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding12Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding12Key2Button
        name: "KeyBindingFrameBinding12Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding12"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 163.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding12Key2ButtonText
        name: "KeyBindingFrameBinding12Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding12Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding12Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding12Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding13
        name: "KeyBindingFrameBinding13"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding12.left
        anchors.top: keyBindingFrameBinding12.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding13Description
        name: "KeyBindingFrameBinding13Description"
        kind: "FontString"
        text: "Target Previous Enemy Player"
        wowParent: "KeyBindingFrameBinding13"
        anchors.left: keyBindingFrameBinding13.left
        anchors.verticalCenter: keyBindingFrameBinding13.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding13Key1Button
        name: "KeyBindingFrameBinding13Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding13"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 140.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding13Key1ButtonText
        name: "KeyBindingFrameBinding13Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding13Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding13Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding13Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding13Key2Button
        name: "KeyBindingFrameBinding13Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding13"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 140.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding13Key2ButtonText
        name: "KeyBindingFrameBinding13Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding13Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding13Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding13Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding14
        name: "KeyBindingFrameBinding14"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding13.left
        anchors.top: keyBindingFrameBinding13.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding14Description
        name: "KeyBindingFrameBinding14Description"
        kind: "FontString"
        text: "Target Nearest Friendly Player"
        wowParent: "KeyBindingFrameBinding14"
        anchors.left: keyBindingFrameBinding14.left
        anchors.verticalCenter: keyBindingFrameBinding14.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding14Key1Button
        name: "KeyBindingFrameBinding14Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding14"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 117.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding14Key1ButtonText
        name: "KeyBindingFrameBinding14Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding14Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding14Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding14Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding14Key2Button
        name: "KeyBindingFrameBinding14Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding14"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 117.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding14Key2ButtonText
        name: "KeyBindingFrameBinding14Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding14Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding14Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding14Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding15
        name: "KeyBindingFrameBinding15"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding14.left
        anchors.top: keyBindingFrameBinding14.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding15Description
        name: "KeyBindingFrameBinding15Description"
        kind: "FontString"
        text: "Target Previous Friendly Player"
        wowParent: "KeyBindingFrameBinding15"
        anchors.left: keyBindingFrameBinding15.left
        anchors.verticalCenter: keyBindingFrameBinding15.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding15Key1Button
        name: "KeyBindingFrameBinding15Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding15"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 94.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding15Key1ButtonText
        name: "KeyBindingFrameBinding15Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding15Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding15Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding15Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding15Key2Button
        name: "KeyBindingFrameBinding15Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding15"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 94.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding15Key2ButtonText
        name: "KeyBindingFrameBinding15Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding15Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding15Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding15Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding16
        name: "KeyBindingFrameBinding16"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding15.left
        anchors.top: keyBindingFrameBinding15.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding16Description
        name: "KeyBindingFrameBinding16Description"
        kind: "FontString"
        text: "Target Self"
        wowParent: "KeyBindingFrameBinding16"
        anchors.left: keyBindingFrameBinding16.left
        anchors.verticalCenter: keyBindingFrameBinding16.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding16Key1Button
        name: "KeyBindingFrameBinding16Key1Button"
        kind: "Button"
        text: "F1"
        wowParent: "KeyBindingFrameBinding16"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 71.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding16Key1ButtonText
        name: "KeyBindingFrameBinding16Key1ButtonText"
        kind: "FontString"
        text: "F1"
        wowParent: "KeyBindingFrameBinding16Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding16Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding16Key1Button.verticalCenter
        width: 10.3
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding16Key2Button
        name: "KeyBindingFrameBinding16Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding16"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 71.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding16Key2ButtonText
        name: "KeyBindingFrameBinding16Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding16Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding16Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding16Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding17
        name: "KeyBindingFrameBinding17"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding16.left
        anchors.top: keyBindingFrameBinding16.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding17Description
        name: "KeyBindingFrameBinding17Description"
        kind: "FontString"
        text: "Target Party Member 1"
        wowParent: "KeyBindingFrameBinding17"
        anchors.left: keyBindingFrameBinding17.left
        anchors.verticalCenter: keyBindingFrameBinding17.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding17Header
        name: "KeyBindingFrameBinding17Header"
        kind: "FontString"
        text: "Chat Functions"
        wowParent: "KeyBindingFrameBinding17"
        anchors.left: keyBindingFrameBinding17.left
        anchors.verticalCenter: keyBindingFrameBinding17.verticalCenter
        width: 87.7
        height: 11.9
    }

    Part {
        id: keyBindingFrameBinding17Key1Button
        name: "KeyBindingFrameBinding17Key1Button"
        kind: "Button"
        text: "F2"
        wowParent: "KeyBindingFrameBinding17"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 48.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding17Key1ButtonText
        name: "KeyBindingFrameBinding17Key1ButtonText"
        kind: "FontString"
        text: "F2"
        wowParent: "KeyBindingFrameBinding17Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding17Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding17Key1Button.verticalCenter
        width: 12.6
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding17Key2Button
        name: "KeyBindingFrameBinding17Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding17"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 48.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding17Key2ButtonText
        name: "KeyBindingFrameBinding17Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding17Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding17Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding17Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding1Description
        name: "KeyBindingFrameBinding1Description"
        kind: "FontString"
        text: "Earth Totem"
        wowParent: "KeyBindingFrameBinding1"
        anchors.left: keyBindingFrameBinding1.left
        anchors.verticalCenter: keyBindingFrameBinding1.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding1Header
        name: "KeyBindingFrameBinding1Header"
        kind: "FontString"
        text: "Movement Keys"
        wowParent: "KeyBindingFrameBinding1"
        anchors.left: keyBindingFrameBinding1.left
        anchors.verticalCenter: keyBindingFrameBinding1.verticalCenter
        width: 97.2
        height: 11.9
    }

    Part {
        id: keyBindingFrameBinding1Key1Button
        name: "KeyBindingFrameBinding1Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding1"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 73.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding1Key1ButtonText
        name: "KeyBindingFrameBinding1Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding1Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding1Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding1Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding1Key2Button
        name: "KeyBindingFrameBinding1Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding1"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 73.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding1Key2ButtonText
        name: "KeyBindingFrameBinding1Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding1Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding1Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding1Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding2
        name: "KeyBindingFrameBinding2"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding1.left
        anchors.top: keyBindingFrameBinding1.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding2Description
        name: "KeyBindingFrameBinding2Description"
        kind: "FontString"
        text: "Fire Totem"
        wowParent: "KeyBindingFrameBinding2"
        anchors.left: keyBindingFrameBinding2.left
        anchors.verticalCenter: keyBindingFrameBinding2.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding2Key1Button
        name: "KeyBindingFrameBinding2Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding2"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 96.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding2Key1ButtonText
        name: "KeyBindingFrameBinding2Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding2Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding2Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding2Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding2Key2Button
        name: "KeyBindingFrameBinding2Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding2"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 96.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding2Key2ButtonText
        name: "KeyBindingFrameBinding2Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding2Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding2Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding2Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding3
        name: "KeyBindingFrameBinding3"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding2.left
        anchors.top: keyBindingFrameBinding2.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding3Description
        name: "KeyBindingFrameBinding3Description"
        kind: "FontString"
        text: "Water Totem"
        wowParent: "KeyBindingFrameBinding3"
        anchors.left: keyBindingFrameBinding3.left
        anchors.verticalCenter: keyBindingFrameBinding3.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding3Key1Button
        name: "KeyBindingFrameBinding3Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding3"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 119.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding3Key1ButtonText
        name: "KeyBindingFrameBinding3Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding3Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding3Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding3Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding3Key2Button
        name: "KeyBindingFrameBinding3Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding3"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 119.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding3Key2ButtonText
        name: "KeyBindingFrameBinding3Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding3Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding3Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding3Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding4
        name: "KeyBindingFrameBinding4"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding3.left
        anchors.top: keyBindingFrameBinding3.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding4Description
        name: "KeyBindingFrameBinding4Description"
        kind: "FontString"
        text: "Air Totem"
        wowParent: "KeyBindingFrameBinding4"
        anchors.left: keyBindingFrameBinding4.left
        anchors.verticalCenter: keyBindingFrameBinding4.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding4Key1Button
        name: "KeyBindingFrameBinding4Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding4"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 142.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding4Key1ButtonText
        name: "KeyBindingFrameBinding4Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding4Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding4Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding4Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding4Key2Button
        name: "KeyBindingFrameBinding4Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding4"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 142.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding4Key2ButtonText
        name: "KeyBindingFrameBinding4Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding4Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding4Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding4Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding5
        name: "KeyBindingFrameBinding5"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding4.left
        anchors.top: keyBindingFrameBinding4.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding5Description
        name: "KeyBindingFrameBinding5Description"
        kind: "FontString"
        text: "Turn Left"
        wowParent: "KeyBindingFrameBinding5"
        anchors.left: keyBindingFrameBinding5.left
        anchors.verticalCenter: keyBindingFrameBinding5.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding5Header
        name: "KeyBindingFrameBinding5Header"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding5"
        anchors.left: keyBindingFrameBinding5.left
        anchors.verticalCenter: keyBindingFrameBinding5.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: keyBindingFrameBinding5Key1Button
        name: "KeyBindingFrameBinding5Key1Button"
        kind: "Button"
        text: "A"
        wowParent: "KeyBindingFrameBinding5"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 165.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding5Key1ButtonText
        name: "KeyBindingFrameBinding5Key1ButtonText"
        kind: "FontString"
        text: "A"
        wowParent: "KeyBindingFrameBinding5Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding5Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding5Key1Button.verticalCenter
        width: 8.7
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding5Key2Button
        name: "KeyBindingFrameBinding5Key2Button"
        kind: "Button"
        text: "Left Arrow"
        wowParent: "KeyBindingFrameBinding5"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 165.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding5Key2ButtonText
        name: "KeyBindingFrameBinding5Key2ButtonText"
        kind: "FontString"
        text: "Left Arrow"
        wowParent: "KeyBindingFrameBinding5Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding5Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding5Key2Button.verticalCenter
        width: 75.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding6
        name: "KeyBindingFrameBinding6"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding5.left
        anchors.top: keyBindingFrameBinding5.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding6Description
        name: "KeyBindingFrameBinding6Description"
        kind: "FontString"
        text: "Totemic Recall"
        wowParent: "KeyBindingFrameBinding6"
        anchors.left: keyBindingFrameBinding6.left
        anchors.verticalCenter: keyBindingFrameBinding6.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding6Key1Button
        name: "KeyBindingFrameBinding6Key1Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding6"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 188.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding6Key1ButtonText
        name: "KeyBindingFrameBinding6Key1ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding6Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding6Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding6Key1Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding6Key2Button
        name: "KeyBindingFrameBinding6Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding6"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 188.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding6Key2ButtonText
        name: "KeyBindingFrameBinding6Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding6Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding6Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding6Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding7
        name: "KeyBindingFrameBinding7"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding6.left
        anchors.top: keyBindingFrameBinding6.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding7Description
        name: "KeyBindingFrameBinding7Description"
        kind: "FontString"
        text: "Strafe Left"
        wowParent: "KeyBindingFrameBinding7"
        anchors.left: keyBindingFrameBinding7.left
        anchors.verticalCenter: keyBindingFrameBinding7.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding7Header
        name: "KeyBindingFrameBinding7Header"
        kind: "FontString"
        text: "Targeting Functions"
        wowParent: "KeyBindingFrameBinding7"
        anchors.left: keyBindingFrameBinding7.left
        anchors.verticalCenter: keyBindingFrameBinding7.verticalCenter
        width: 116.1
        height: 11.9
    }

    Part {
        id: keyBindingFrameBinding7Key1Button
        name: "KeyBindingFrameBinding7Key1Button"
        kind: "Button"
        text: "'"
        wowParent: "KeyBindingFrameBinding7"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 211.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding7Key1ButtonText
        name: "KeyBindingFrameBinding7Key1ButtonText"
        kind: "FontString"
        text: "'"
        wowParent: "KeyBindingFrameBinding7Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding7Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding7Key1Button.verticalCenter
        width: 3.2
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding7Key2Button
        name: "KeyBindingFrameBinding7Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding7"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 211.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding7Key2ButtonText
        name: "KeyBindingFrameBinding7Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding7Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding7Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding7Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding8
        name: "KeyBindingFrameBinding8"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding7.left
        anchors.top: keyBindingFrameBinding7.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding8Description
        name: "KeyBindingFrameBinding8Description"
        kind: "FontString"
        text: "Target Nearest Enemy"
        wowParent: "KeyBindingFrameBinding8"
        anchors.left: keyBindingFrameBinding8.left
        anchors.verticalCenter: keyBindingFrameBinding8.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding8Key1Button
        name: "KeyBindingFrameBinding8Key1Button"
        kind: "Button"
        text: "Tab"
        wowParent: "KeyBindingFrameBinding8"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 234.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding8Key1ButtonText
        name: "KeyBindingFrameBinding8Key1ButtonText"
        kind: "FontString"
        text: "Tab"
        wowParent: "KeyBindingFrameBinding8Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding8Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding8Key1Button.verticalCenter
        width: 22.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding8Key2Button
        name: "KeyBindingFrameBinding8Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding8"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 234.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding8Key2ButtonText
        name: "KeyBindingFrameBinding8Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding8Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding8Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding8Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding9
        name: "KeyBindingFrameBinding9"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameBinding8.left
        anchors.top: keyBindingFrameBinding8.bottom
        anchors.topMargin: -2
        width: 560
        height: 25
    }

    Part {
        id: keyBindingFrameBinding9Description
        name: "KeyBindingFrameBinding9Description"
        kind: "FontString"
        text: "Target Previous Enemy"
        wowParent: "KeyBindingFrameBinding9"
        anchors.left: keyBindingFrameBinding9.left
        anchors.verticalCenter: keyBindingFrameBinding9.verticalCenter
        width: 170
        height: 24
    }

    Part {
        id: keyBindingFrameBinding9Key1Button
        name: "KeyBindingFrameBinding9Key1Button"
        kind: "Button"
        text: "SHIFT-Tab"
        wowParent: "KeyBindingFrameBinding9"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 261
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 232.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding9Key1ButtonText
        name: "KeyBindingFrameBinding9Key1ButtonText"
        kind: "FontString"
        text: "SHIFT-Tab"
        wowParent: "KeyBindingFrameBinding9Key1Button"
        anchors.horizontalCenter: keyBindingFrameBinding9Key1Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding9Key1Button.verticalCenter
        width: 61.6
        height: 10.3
    }

    Part {
        id: keyBindingFrameBinding9Key2Button
        name: "KeyBindingFrameBinding9Key2Button"
        kind: "Button"
        wowParent: "KeyBindingFrameBinding9"
        style: "Button"
        anchors.right: keyBindingFrame.right
        anchors.rightMargin: 78
        anchors.bottom: keyBindingFrame.bottom
        anchors.bottomMargin: 232.5
        width: 177
        height: 22
    }

    Part {
        id: keyBindingFrameBinding9Key2ButtonText
        name: "KeyBindingFrameBinding9Key2ButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameBinding9Key2Button"
        anchors.horizontalCenter: keyBindingFrameBinding9Key2Button.horizontalCenter
        anchors.verticalCenter: keyBindingFrameBinding9Key2Button.verticalCenter
        width: 71.1
        height: 10.3
    }

    Part {
        id: keyBindingFrameCancelButton
        name: "KeyBindingFrameCancelButton"
        kind: "Button"
        text: "Cancel"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "all"
        anchors.left: keyBindingFrameOkayButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: keyBindingFrameOkayButton.verticalCenter
        width: 125
        height: 22
    }

    Part {
        id: keyBindingFrameCancelButtonText
        name: "KeyBindingFrameCancelButtonText"
        kind: "FontString"
        text: "Cancel"
        wowParent: "KeyBindingFrameCancelButton"
        anchors.horizontalCenter: keyBindingFrameCancelButton.horizontalCenter
        anchors.verticalCenter: keyBindingFrameCancelButton.verticalCenter
        width: 45.8
        height: 10.3
    }

    Part {
        id: keyBindingFrameCharacterButton
        name: "KeyBindingFrameCharacterButton"
        kind: "CheckButton"
        wowParent: "KeyBindingFrame"
        style: "CheckBox"
        anchors.right: keyBindingFrameDiabolicBand.right
        anchors.rightMargin: 232.6
        anchors.verticalCenter: keyBindingFrameDiabolicBand.verticalCenter
        width: 20
        height: 20
    }

    Part {
        id: keyBindingFrameCharacterButtonText
        name: "KeyBindingFrameCharacterButtonText"
        kind: "FontString"
        wowParent: "KeyBindingFrameCharacterButton"
        anchors.left: keyBindingFrameCharacterButton.right
        anchors.leftMargin: 4
        anchors.verticalCenter: keyBindingFrameCharacterButton.verticalCenter
        width: 183.3
        height: 14.2
    }

    Part {
        id: keyBindingFrameCommandLabel
        name: "KeyBindingFrameCommandLabel"
        kind: "FontString"
        text: "Command"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: 26
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 35
        width: 61.6
        height: 11.9
    }

    // the buttons 16 lower, on the foot, as far in from both sides
    Part {
        id: keyBindingFrameDefaultButton
        name: "KeyBindingFrameDefaultButton"
        kind: "Button"
        text: "Reset To Default"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "place"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 37
        anchors.bottom: keyBindingFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 130
        height: 22
    }

    Part {
        id: keyBindingFrameDiabolic
        name: "KeyBindingFrameDiabolic"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: -24
        anchors.top: keyBindingFrame.top
        anchors.topMargin: -40
        width: 634
        height: 598
    }

    Part {
        id: keyBindingFrameDiabolicBand
        name: "KeyBindingFrameDiabolicBand"
        kind: "Frame"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: keyBindingFrameDiabolic.top
        anchors.topMargin: 24
        width: 586
        height: 40
    }

    Part {
        id: keyBindingFrameDiabolicBorder
        name: "KeyBindingFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.top: keyBindingFrameDiabolic.top
        width: 634
        height: 598
    }

    Part {
        id: keyBindingFrameDiabolicFoot
        name: "KeyBindingFrameDiabolicFoot"
        kind: "Frame"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.horizontalCenter: keyBindingFrameDefaultButton.horizontalCenter
        anchors.horizontalCenterOffset: 215
        anchors.top: keyBindingFrameDefaultButton.top
        anchors.topMargin: -6
        width: 588
        height: 35
    }

    Part {
        id: keyBindingFrameDiabolicTitlePlate
        name: "KeyBindingFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "KeyBindingFrameDiabolic"
        anchors.horizontalCenter: keyBindingFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: keyBindingFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: keyBindingFrameHeaderText
        name: "KeyBindingFrameHeaderText"
        kind: "FontString"
        text: "Key Bindings"
        wowParent: "KeyBindingFrameDiabolicTitlePlate"
        anchors.horizontalCenter: keyBindingFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: keyBindingFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 112.2
        height: 14.2
    }

    Part {
        id: keyBindingFrameKey1Label
        name: "KeyBindingFrameKey1Label"
        kind: "FontString"
        text: "Key 1"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameCommandLabel.right
        anchors.leftMargin: 185
        anchors.verticalCenter: keyBindingFrameCommandLabel.verticalCenter
        width: 32.4
        height: 11.9
    }

    Part {
        id: keyBindingFrameKey2Label
        name: "KeyBindingFrameKey2Label"
        kind: "FontString"
        text: "Key 2"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameKey1Label.right
        anchors.leftMargin: 145
        anchors.verticalCenter: keyBindingFrameKey1Label.verticalCenter
        width: 34
        height: 11.9
    }

    Part {
        id: keyBindingFrameOkayButton
        name: "KeyBindingFrameOkayButton"
        kind: "Button"
        text: "Okay"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "all"
        anchors.left: keyBindingFrameUnbindButton.right
        anchors.leftMargin: 6
        anchors.verticalCenter: keyBindingFrameUnbindButton.verticalCenter
        width: 125
        height: 22
    }

    Part {
        id: keyBindingFrameOkayButtonText
        name: "KeyBindingFrameOkayButtonText"
        kind: "FontString"
        text: "Okay"
        wowParent: "KeyBindingFrameOkayButton"
        anchors.horizontalCenter: keyBindingFrameOkayButton.horizontalCenter
        anchors.verticalCenter: keyBindingFrameOkayButton.verticalCenter
        width: 32.4
        height: 10.3
    }

    // what a key was bound to between the list and the foot
    Part {
        id: keyBindingFrameOutputText
        name: "KeyBindingFrameOutputText"
        kind: "FontString"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.horizontalCenter: keyBindingFrame.left
        anchors.horizontalCenterOffset: 293
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 465
        width: 1
        height: 1
    }

    // the list (its rows too) 6 under the column names
    Part {
        id: keyBindingFrameScrollFrame
        name: "KeyBindingFrameScrollFrame"
        kind: "ScrollFrame"
        wowParent: "KeyBindingFrame"
        pin: "place"
        anchors.left: keyBindingFrame.left
        anchors.leftMargin: 2
        anchors.top: keyBindingFrame.top
        anchors.topMargin: 72
        width: 560
        height: 390
    }

    Part {
        id: keyBindingFrameScrollFrameDiabolicZone
        name: "KeyBindingFrameScrollFrameDiabolicZone"
        kind: "Frame"
        wowParent: "KeyBindingFrame"
        anchors.left: keyBindingFrameScrollFrame.left
        anchors.leftMargin: -6
        anchors.top: keyBindingFrameScrollFrame.top
        anchors.topMargin: -6
        width: 594
        height: 402
    }

    Part {
        id: keyBindingFrameScrollFrameScrollBar
        name: "KeyBindingFrameScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "KeyBindingFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: keyBindingFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: keyBindingFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 358
    }

    Part {
        id: keyBindingFrameScrollFrameScrollBarDiabolicTrack
        name: "KeyBindingFrameScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "KeyBindingFrameScrollFrameScrollBar"
        anchors.horizontalCenter: keyBindingFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: keyBindingFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 392
    }

    Part {
        id: keyBindingFrameScrollFrameScrollBarScrollDownButton
        name: "KeyBindingFrameScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "KeyBindingFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: keyBindingFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: keyBindingFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: keyBindingFrameScrollFrameScrollBarScrollUpButton
        name: "KeyBindingFrameScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "KeyBindingFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: keyBindingFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: keyBindingFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: keyBindingFrameScrollFrameScrollChildFrame
        name: "KeyBindingFrameScrollFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "KeyBindingFrameScrollFrame"
        anchors.left: keyBindingFrameScrollFrame.left
        anchors.top: keyBindingFrameScrollFrame.top
        anchors.topMargin: -2100
        width: 300
        height: 7775
    }

    Part {
        id: keyBindingFrameUnbindButton
        name: "KeyBindingFrameUnbindButton"
        kind: "Button"
        text: "Unbind Key"
        wowParent: "KeyBindingFrame"
        style: "Button"
        pin: "all"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 210
        anchors.bottom: keyBindingFrameDiabolic.bottom
        anchors.bottomMargin: 30
        width: 125
        height: 22
    }

    Part {
        id: keyBindingFrameUnbindButtonText
        name: "KeyBindingFrameUnbindButtonText"
        kind: "FontString"
        text: "Unbind Key"
        wowParent: "KeyBindingFrameUnbindButton"
        anchors.horizontalCenter: keyBindingFrameUnbindButton.horizontalCenter
        anchors.verticalCenter: keyBindingFrameUnbindButton.verticalCenter
        width: 73.5
        height: 10.3
    }

    WowRow {
        name: "KeyBindingButtons"
        parts: ["KeyBindingFrameUnbindButton", "KeyBindingFrameOkayButton", "KeyBindingFrameCancelButton"]
        fit: "equal"
        anchors.left: keyBindingFrameDiabolic.left
        anchors.leftMargin: 210
        anchors.right: keyBindingFrameDiabolic.right
        anchors.rightMargin: 37
        anchors.bottom: keyBindingFrameDiabolic.bottom
        anchors.bottomMargin: 30
    }

}
