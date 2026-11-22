// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "InterfaceOptionsFrame"
    kind: "list"
    width: 648
    height: 520

    Button {
        name: "InterfaceOptionsFrameCancel"
        text: "Cancel"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        width: 92
        height: 22

        FontString {
            name: "InterfaceOptionsFrameCancelText"
            text: "Cancel"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 35.6
            height: 10.3
        }
    }

    Frame {
        id: interfaceOptionsFrameCategories
        name: "InterfaceOptionsFrameCategories"
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 175
        height: 429

        Button {
            name: "InterfaceOptionsFrameCategoriesButton1"
            text: "Controls"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 8
            width: 175
            height: 18

            FontString {
                name: "InterfaceOptionsFrameCategoriesButton1Text"
                text: "Controls"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -2
                width: 145
                height: 11.9
            }
        }
    }

    Button {
        name: "InterfaceOptionsFrameDefaults"
        text: "Defaults"
        style: "Button"
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        width: 96
        height: 22
    }

    Frame {
        name: "InterfaceOptionsFrameDiabolic"
        anchors.left: parent.left
        anchors.leftMargin: -16
        anchors.top: parent.top
        width: 680
        height: 536

        Frame {
            name: "InterfaceOptionsFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 680
            height: 536

            Frame {
                name: "InterfaceOptionsFrameDiabolicTitlePlate"
                wowParent: "InterfaceOptionsFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                Button {
                    name: "InterfaceOptionsFrameDiabolicTitlePlateGem"
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40
                }

                FontString {
                    name: "InterfaceOptionsFrameHeaderText"
                    text: "Interface"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 88.5
                    height: 14.2
                }
            }
        }
    }

    Button {
        name: "InterfaceOptionsFrameOkay"
        text: "Okay"
        style: "Button"
        anchors.right: parent.right
        anchors.rightMargin: 116
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        width: 92
        height: 22

        FontString {
            name: "InterfaceOptionsFrameOkayText"
            text: "Okay"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 28.4
            height: 10.3
        }
    }

    Frame {
        name: "InterfaceOptionsFramePanelContainer"
        anchors.left: interfaceOptionsFrameCategories.right
        anchors.leftMargin: 16
        anchors.top: interfaceOptionsFrameCategories.top
        width: 413
        height: 428

        Frame {
            name: "InterfaceOptionsControlsPanel"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 413
            height: 428

            CheckButton {
                id: interfaceOptionsControlsPanelAutoClearAFK
                name: "InterfaceOptionsControlsPanelAutoClearAFK"
                anchors.left: interfaceOptionsControlsPanelAutoDismount.left
                anchors.top: interfaceOptionsControlsPanelAutoDismount.bottom
                anchors.topMargin: 8
                width: 26
                height: 26

                FontString {
                    name: "InterfaceOptionsControlsPanelAutoClearAFKText"
                    text: "Auto Clear Away"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 101.9
                    height: 11.9
                }
            }

            CheckButton {
                id: interfaceOptionsControlsPanelAutoDismount
                name: "InterfaceOptionsControlsPanelAutoDismount"
                anchors.left: interfaceOptionsControlsPanelStickyTargeting.left
                anchors.top: interfaceOptionsControlsPanelStickyTargeting.bottom
                anchors.topMargin: 8
                width: 26
                height: 26

                FontString {
                    name: "InterfaceOptionsControlsPanelAutoDismountText"
                    text: "Auto Dismount in Flight"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 139.9
                    height: 11.9
                }
            }

            CheckButton {
                id: interfaceOptionsControlsPanelAutoLootCorpse
                name: "InterfaceOptionsControlsPanelAutoLootCorpse"
                anchors.left: interfaceOptionsControlsPanelLootAtMouse.left
                anchors.top: interfaceOptionsControlsPanelLootAtMouse.bottom
                anchors.topMargin: 8
                width: 26
                height: 26

                FontString {
                    name: "InterfaceOptionsControlsPanelAutoLootCorpseText"
                    text: "Auto Loot"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 61.6
                    height: 11.9
                }
            }

            Frame {
                name: "InterfaceOptionsControlsPanelAutoLootKeyDropDown"
                anchors.left: interfaceOptionsControlsPanelAutoLootCorpse.left
                anchors.leftMargin: -13
                anchors.top: interfaceOptionsControlsPanelAutoLootCorpse.bottom
                anchors.topMargin: 24
                width: 140
                height: 32

                FontString {
                    name: "InterfaceOptionsControlsPanelAutoLootKeyDropDownLabel"
                    text: "Auto Loot Key"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 86.9
                    height: 11.9
                }

                Ghost {
                    name: "InterfaceOptionsControlsPanelAutoLootKeyDropDownRight"
                    x: 140
                    y: -17
                    width: 0
                    height: 64

                    Button {
                        name: "InterfaceOptionsControlsPanelAutoLootKeyDropDownButton"
                        wowParent: "InterfaceOptionsControlsPanelAutoLootKeyDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: 16
                        anchors.top: parent.top
                        anchors.topMargin: 18
                        width: 24
                        height: 24
                    }

                    FontString {
                        name: "InterfaceOptionsControlsPanelAutoLootKeyDropDownText"
                        text: "SHIFT key"
                        wowParent: "InterfaceOptionsControlsPanelAutoLootKeyDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: 43
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -2
                        width: 65
                        height: 10
                    }
                }
            }

            CheckButton {
                id: interfaceOptionsControlsPanelBlockTrades
                name: "InterfaceOptionsControlsPanelBlockTrades"
                anchors.left: interfaceOptionsControlsPanelAutoClearAFK.left
                anchors.top: interfaceOptionsControlsPanelAutoClearAFK.bottom
                anchors.topMargin: 8
                width: 26
                height: 26

                FontString {
                    name: "InterfaceOptionsControlsPanelBlockTradesText"
                    text: "Block Trades"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 75.9
                    height: 11.9
                }
            }

            CheckButton {
                id: interfaceOptionsControlsPanelLootAtMouse
                name: "InterfaceOptionsControlsPanelLootAtMouse"
                anchors.left: interfaceOptionsControlsPanelBlockTrades.left
                anchors.top: interfaceOptionsControlsPanelBlockTrades.bottom
                anchors.topMargin: 8
                width: 26
                height: 26

                FontString {
                    name: "InterfaceOptionsControlsPanelLootAtMouseText"
                    text: "Open Loot Window at Mouse"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 176.2
                    height: 11.9
                }
            }

            CheckButton {
                id: interfaceOptionsControlsPanelStickyTargeting
                name: "InterfaceOptionsControlsPanelStickyTargeting"
                anchors.left: interfaceOptionsControlsPanelSubText.left
                anchors.leftMargin: -2
                anchors.top: interfaceOptionsControlsPanelSubText.bottom
                anchors.topMargin: 8
                width: 26
                height: 26

                FontString {
                    name: "InterfaceOptionsControlsPanelStickyTargetingText"
                    text: "Sticky Targeting"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 95.6
                    height: 11.9
                }
            }

            FontString {
                id: interfaceOptionsControlsPanelSubText
                name: "InterfaceOptionsControlsPanelSubText"
                text: "These are general gameplay related controls that affect how your character interacts with objects and other players in the game world."
                anchors.left: interfaceOptionsControlsPanelTitle.left
                anchors.top: interfaceOptionsControlsPanelTitle.bottom
                anchors.topMargin: 8
                width: 365
                height: 32
            }

            FontString {
                id: interfaceOptionsControlsPanelTitle
                name: "InterfaceOptionsControlsPanelTitle"
                text: "Controls"
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 65.6
                height: 15.8
            }
        }
    }

    Button {
        id: interfaceOptionsFrameTab1
        name: "InterfaceOptionsFrameTab1"
        text: "Game"
        anchors.left: interfaceOptionsFrameCategories.left
        anchors.leftMargin: 6
        anchors.bottom: interfaceOptionsFrameCategories.top
        anchors.bottomMargin: -3
        width: 73.2
        height: 24

        FontString {
            name: "InterfaceOptionsFrameTab1Text"
            text: "Game"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 3
            width: 33.2
            height: 10.3
        }
    }

    Button {
        name: "InterfaceOptionsFrameTab2"
        text: "AddOns"
        anchors.left: interfaceOptionsFrameTab1.right
        anchors.leftMargin: -16
        anchors.top: interfaceOptionsFrameTab1.top
        width: 84.2
        height: 24

        FontString {
            name: "InterfaceOptionsFrameTab2Text"
            text: "AddOns"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 3
            width: 44.2
            height: 10.3
        }
    }
}
