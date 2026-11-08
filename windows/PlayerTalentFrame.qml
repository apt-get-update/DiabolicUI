// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "PlayerTalentFrame"
    width: 384
    height: 512

    Frame {
        id: playerTalentFrameDiabolic
        name: "PlayerTalentFrameDiabolic"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -36
        width: 402
        height: 530

        Frame {
            name: "GlyphFrame"
            wowParent: "PlayerTalentFrame"
            anchors.left: parent.left
            anchors.leftMargin: 45.4
            anchors.top: parent.top
            anchors.topMargin: 86.7
            width: 384
            height: 512

            Button {
                name: "GlyphFrameGlyph1"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -15
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -140
                width: 90
                height: 90
            }

            Button {
                name: "GlyphFrameGlyph2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -14
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 103
                width: 90
                height: 90
            }

            Button {
                name: "GlyphFrameGlyph3"
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: parent.top
                anchors.topMargin: 133
                width: 90
                height: 90
            }

            Button {
                name: "GlyphFrameGlyph4"
                anchors.right: parent.right
                anchors.rightMargin: 56
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 168
                width: 90
                height: 90
            }

            Button {
                name: "GlyphFrameGlyph5"
                anchors.right: parent.right
                anchors.rightMargin: 56
                anchors.top: parent.top
                anchors.topMargin: 133
                width: 90
                height: 90
            }

            Button {
                name: "GlyphFrameGlyph6"
                anchors.left: parent.left
                anchors.leftMargin: 26
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 168
                width: 90
                height: 90
            }

            Frame {
                name: "GlyphFrameSparkleFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 337.9
                height: 450.6
            }

            FontString {
                name: "GlyphFrameTitleText"
                text: "Secondary Glyphs"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 18
                width: 96.4
                height: 10.3
            }
        }

        Button {
            name: "PlayerTalentFrameCloseButton"
            wowParent: "PlayerTalentFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 63
            width: 22
            height: 22
        }

        Frame {
            name: "PlayerTalentFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 56
            width: 354
            height: 40

            CheckButton {
                id: playerSpecTab1
                name: "PlayerSpecTab1"
                wowParent: "PlayerTalentFrame"
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                width: 28
                height: 28
            }

            CheckButton {
                name: "PlayerSpecTab2"
                wowParent: "PlayerTalentFrame"
                anchors.left: playerSpecTab1.right
                anchors.leftMargin: 6
                anchors.verticalCenter: playerSpecTab1.verticalCenter
                width: 28
                height: 28
            }

            Button {
                name: "PlayerTalentFrameActivateButton"
                text: "Activate These Talents"
                wowParent: "PlayerTalentFrame"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 201.8
                height: 22

                FontString {
                    name: "PlayerTalentFrameActivateButtonText"
                    text: "Activate These Talents"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 177.8
                    height: 11.9
                }
            }

            Frame {
                name: "PlayerTalentFrameStatusFrame"
                wowParent: "PlayerTalentFrame"
                pin: "place"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 264
                height: 20

                FontString {
                    name: "PlayerTalentFrameStatusText"
                    text: "These are your active talents"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 167.5
                    height: 14.2
                }
            }
        }

        Frame {
            name: "PlayerTalentFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 32
            width: 402
            height: 498

            Frame {
                name: "PlayerTalentFrameDiabolicTitlePlate"
                wowParent: "PlayerTalentFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "PlayerTalentFrameTitleText"
                    text: "Secondary Talents"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 175.4
                    height: 14.2
                }
            }
        }

        Frame {
            name: "PlayerTalentFrameDiabolicCover"
            wowParent: "PlayerTalentFrame"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 354
            height: 406
        }

        Frame {
            name: "PlayerTalentFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 246
            height: 18
        }

        Frame {
            name: "PlayerTalentFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 52
            width: 42
            height: 42
        }

        Frame {
            name: "PlayerTalentFramePointsBar"
            wowParent: "PlayerTalentFrame"
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 222
            width: 338
            height: 26

            FontString {
                name: "PlayerTalentFrameSpentPointsText"
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 104.3
                height: 15
            }

            FontString {
                name: "PlayerTalentFrameTalentPointsText"
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -1
                width: 98.8
                height: 15
            }
        }

        Frame {
            name: "PlayerTalentFramePreviewBar"
            wowParent: "PlayerTalentFrame"
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 222
            width: 338
            height: 26

            Button {
                name: "PlayerTalentFrameLearnButton"
                text: "Learn"
                style: "Button"
                anchors.right: playerTalentFrameResetButton.left
                anchors.verticalCenter: playerTalentFrameResetButton.verticalCenter
                width: 80
                height: 22

                FontString {
                    name: "PlayerTalentFrameLearnButtonText"
                    text: "Learn"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 42.7
                    height: 11.9
                }
            }

            Frame {
                name: "PlayerTalentFramePreviewBarFiller"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 174
                height: 26
            }

            Button {
                id: playerTalentFrameResetButton
                name: "PlayerTalentFrameResetButton"
                text: "Reset"
                style: "Button"
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 80
                height: 22

                FontString {
                    name: "PlayerTalentFrameResetButtonText"
                    text: "Reset"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40.3
                    height: 11.9
                }
            }
        }

        ScrollFrame {
            name: "PlayerTalentFrameScrollFrame"
            wowParent: "PlayerTalentFrame"
            anchors.left: parent.left
            anchors.leftMargin: 42
            anchors.top: parent.top
            anchors.topMargin: 110
            width: 296
            height: 356

            Frame {
                name: "PlayerTalentFrameScrollChildFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 320
                height: 50

                Frame {
                    name: "PlayerTalentFrameArrowFrame"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 320
                    height: 50
                }

                Button {
                    name: "PlayerTalentFrameTalent1"
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    width: 37
                    height: 37

                    Ghost {
                        name: "PlayerTalentFrameTalent1RankBorder"
                        x: 37
                        y: 36.9
                        width: 0
                        height: 0

                        FontString {
                            name: "PlayerTalentFrameTalent1Rank"
                            text: "3"
                            wowParent: "PlayerTalentFrameTalent1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 7.9
                            height: 10.3
                        }
                    }
                }
            }

            Slider {
                name: "PlayerTalentFrameScrollFrameScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 16
                height: 324

                Frame {
                    name: "PlayerTalentFrameScrollFrameScrollBarDiabolicTrack"
                    anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
                    anchors.top: playerTalentFrameScrollFrameScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 358
                }

                Button {
                    name: "PlayerTalentFrameScrollFrameScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 16
                    height: 16
                }

                Button {
                    id: playerTalentFrameScrollFrameScrollBarScrollUpButton
                    name: "PlayerTalentFrameScrollFrameScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 16
                    height: 16
                }
            }
        }
    }

    Button {
        name: "PlayerTalentFrameTab1"
        text: "Discipline"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "PlayerTalentFrameTab2"
        text: "Holy"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "PlayerTalentFrameTab3"
        text: "Shadow"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "PlayerTalentFrameTab4"
        text: "Glyphs"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }
}
