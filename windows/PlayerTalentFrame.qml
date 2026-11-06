// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: playerTalentFrame
    name: "PlayerTalentFrame"
    width: 384
    height: 512

    Part {
        id: glyphFrame
        name: "GlyphFrame"
        kind: "Frame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 45.4
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 86.7
        width: 384
        height: 512
    }

    Part {
        id: glyphFrameGlyph1
        name: "GlyphFrameGlyph1"
        kind: "Button"
        wowParent: "GlyphFrame"
        anchors.horizontalCenter: glyphFrame.horizontalCenter
        anchors.horizontalCenterOffset: -15
        anchors.verticalCenter: glyphFrame.verticalCenter
        anchors.verticalCenterOffset: -140
        width: 90
        height: 90
    }

    Part {
        id: glyphFrameGlyph2
        name: "GlyphFrameGlyph2"
        kind: "Button"
        wowParent: "GlyphFrame"
        anchors.horizontalCenter: glyphFrame.horizontalCenter
        anchors.horizontalCenterOffset: -14
        anchors.verticalCenter: glyphFrame.verticalCenter
        anchors.verticalCenterOffset: 103
        width: 90
        height: 90
    }

    Part {
        id: glyphFrameGlyph3
        name: "GlyphFrameGlyph3"
        kind: "Button"
        wowParent: "GlyphFrame"
        anchors.left: glyphFrame.left
        anchors.leftMargin: 28
        anchors.top: glyphFrame.top
        anchors.topMargin: 133
        width: 90
        height: 90
    }

    Part {
        id: glyphFrameGlyph4
        name: "GlyphFrameGlyph4"
        kind: "Button"
        wowParent: "GlyphFrame"
        anchors.right: glyphFrame.right
        anchors.rightMargin: 56
        anchors.bottom: glyphFrame.bottom
        anchors.bottomMargin: 168
        width: 90
        height: 90
    }

    Part {
        id: glyphFrameGlyph5
        name: "GlyphFrameGlyph5"
        kind: "Button"
        wowParent: "GlyphFrame"
        anchors.right: glyphFrame.right
        anchors.rightMargin: 56
        anchors.top: glyphFrame.top
        anchors.topMargin: 133
        width: 90
        height: 90
    }

    Part {
        id: glyphFrameGlyph6
        name: "GlyphFrameGlyph6"
        kind: "Button"
        wowParent: "GlyphFrame"
        anchors.left: glyphFrame.left
        anchors.leftMargin: 26
        anchors.bottom: glyphFrame.bottom
        anchors.bottomMargin: 168
        width: 90
        height: 90
    }

    Part {
        id: glyphFrameSparkleFrame
        name: "GlyphFrameSparkleFrame"
        kind: "Frame"
        wowParent: "GlyphFrame"
        anchors.left: glyphFrame.left
        anchors.top: glyphFrame.top
        width: 337.9
        height: 450.6
    }

    Part {
        id: glyphFrameTitleText
        name: "GlyphFrameTitleText"
        kind: "FontString"
        text: "Secondary Glyphs"
        wowParent: "GlyphFrame"
        anchors.horizontalCenter: glyphFrame.horizontalCenter
        anchors.top: glyphFrame.top
        anchors.topMargin: 18
        width: 96.4
        height: 10.3
    }

    Part {
        id: playerSpecTab1
        name: "PlayerSpecTab1"
        kind: "CheckButton"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolicBand.left
        anchors.leftMargin: 12
        anchors.verticalCenter: playerTalentFrameDiabolicBand.verticalCenter
        width: 28
        height: 28
    }

    Part {
        id: playerSpecTab2
        name: "PlayerSpecTab2"
        kind: "CheckButton"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerSpecTab1.right
        anchors.leftMargin: 6
        anchors.verticalCenter: playerSpecTab1.verticalCenter
        width: 28
        height: 28
    }

    Part {
        id: playerTalentFrameArrowFrame
        name: "PlayerTalentFrameArrowFrame"
        kind: "Frame"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.top: playerTalentFrameScrollChildFrame.top
        width: 320
        height: 50
    }

    Part {
        id: playerTalentFrameCloseButton
        name: "PlayerTalentFrameCloseButton"
        kind: "Button"
        wowParent: "PlayerTalentFrame"
        anchors.horizontalCenter: playerTalentFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: playerTalentFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Part {
        id: playerTalentFrameDiabolic
        name: "PlayerTalentFrameDiabolic"
        kind: "Frame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrame.left
        anchors.top: playerTalentFrame.top
        anchors.topMargin: -36
        width: 402
        height: 530
    }

    Part {
        id: playerTalentFrameDiabolicBand
        name: "PlayerTalentFrameDiabolicBand"
        kind: "Frame"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 56
        width: 354
        height: 40
    }

    Part {
        id: playerTalentFrameDiabolicBorder
        name: "PlayerTalentFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 32
        width: 402
        height: 498
    }

    Part {
        id: playerTalentFrameDiabolicCover
        name: "PlayerTalentFrameDiabolicCover"
        kind: "Frame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 100
        width: 354
        height: 406
    }

    Part {
        id: playerTalentFrameDiabolicRail
        name: "PlayerTalentFrameDiabolicRail"
        kind: "Frame"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Part {
        id: playerTalentFrameDiabolicSocket
        name: "PlayerTalentFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.right: playerTalentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Part {
        id: playerTalentFrameDiabolicTitlePlate
        name: "PlayerTalentFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.horizontalCenter: playerTalentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: playerTalentFramePointsBar
        name: "PlayerTalentFramePointsBar"
        kind: "Frame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 32
        anchors.verticalCenter: playerTalentFrameDiabolic.verticalCenter
        anchors.verticalCenterOffset: 222
        width: 338
        height: 26
    }

    Part {
        id: playerTalentFrameScrollChildFrame
        name: "PlayerTalentFrameScrollChildFrame"
        kind: "Frame"
        wowParent: "PlayerTalentFrameScrollFrame"
        anchors.left: playerTalentFrameScrollFrame.left
        anchors.top: playerTalentFrameScrollFrame.top
        width: 320
        height: 50
    }

    Part {
        id: playerTalentFrameScrollFrame
        name: "PlayerTalentFrameScrollFrame"
        kind: "ScrollFrame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 42
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 110
        width: 296
        height: 356
    }

    Part {
        id: playerTalentFrameScrollFrameScrollBar
        name: "PlayerTalentFrameScrollFrameScrollBar"
        kind: "Slider"
        wowParent: "PlayerTalentFrameScrollFrame"
        anchors.left: playerTalentFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: playerTalentFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 324
    }

    Part {
        id: playerTalentFrameScrollFrameScrollBarDiabolicTrack
        name: "PlayerTalentFrameScrollFrameScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "PlayerTalentFrameScrollFrameScrollBar"
        anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: playerTalentFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 358
    }

    Part {
        id: playerTalentFrameScrollFrameScrollBarScrollDownButton
        name: "PlayerTalentFrameScrollFrameScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollFrameScrollBar"
        anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: playerTalentFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Part {
        id: playerTalentFrameScrollFrameScrollBarScrollUpButton
        name: "PlayerTalentFrameScrollFrameScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollFrameScrollBar"
        anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: playerTalentFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    Part {
        id: playerTalentFrameSpentPointsText
        name: "PlayerTalentFrameSpentPointsText"
        kind: "FontString"
        wowParent: "PlayerTalentFramePointsBar"
        anchors.left: playerTalentFramePointsBar.left
        anchors.leftMargin: 12
        anchors.verticalCenter: playerTalentFramePointsBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 104.3
        height: 15
    }

    Part {
        id: playerTalentFrameStatusFrame
        name: "PlayerTalentFrameStatusFrame"
        kind: "Frame"
        wowParent: "PlayerTalentFrame"
        anchors.horizontalCenter: playerTalentFrameDiabolicBand.horizontalCenter
        anchors.verticalCenter: playerTalentFrameDiabolicBand.verticalCenter
        width: 264
        height: 20
    }

    Part {
        id: playerTalentFrameStatusText
        name: "PlayerTalentFrameStatusText"
        kind: "FontString"
        text: "These are your active talents"
        wowParent: "PlayerTalentFrameStatusFrame"
        anchors.horizontalCenter: playerTalentFrameStatusFrame.horizontalCenter
        anchors.verticalCenter: playerTalentFrameStatusFrame.verticalCenter
        width: 167.5
        height: 14.2
    }

    Part {
        id: playerTalentFrameTab1
        name: "PlayerTalentFrameTab1"
        kind: "Button"
        text: "Discipline"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: playerTalentFrameTab2
        name: "PlayerTalentFrameTab2"
        kind: "Button"
        text: "Holy"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: playerTalentFrameTab3
        name: "PlayerTalentFrameTab3"
        kind: "Button"
        text: "Shadow"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: playerTalentFrameTab4
        name: "PlayerTalentFrameTab4"
        kind: "Button"
        text: "Glyphs"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: playerTalentFrameTalent1
        name: "PlayerTalentFrameTalent1"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent10
        name: "PlayerTalentFrameTalent10"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent10Rank
        name: "PlayerTalentFrameTalent10Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent10"
        anchors.horizontalCenter: playerTalentFrameTalent10RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent10RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent11
        name: "PlayerTalentFrameTalent11"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent11Rank
        name: "PlayerTalentFrameTalent11Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent11"
        anchors.horizontalCenter: playerTalentFrameTalent11RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent11RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent12
        name: "PlayerTalentFrameTalent12"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent12Rank
        name: "PlayerTalentFrameTalent12Rank"
        kind: "FontString"
        text: "3"
        wowParent: "PlayerTalentFrameTalent12"
        anchors.horizontalCenter: playerTalentFrameTalent12RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent12RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent13
        name: "PlayerTalentFrameTalent13"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent14
        name: "PlayerTalentFrameTalent14"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent14Rank
        name: "PlayerTalentFrameTalent14Rank"
        kind: "FontString"
        text: "1"
        wowParent: "PlayerTalentFrameTalent14"
        anchors.horizontalCenter: playerTalentFrameTalent14RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent14RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent15
        name: "PlayerTalentFrameTalent15"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent16
        name: "PlayerTalentFrameTalent16"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent16Rank
        name: "PlayerTalentFrameTalent16Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent16"
        anchors.horizontalCenter: playerTalentFrameTalent16RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent16RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent17
        name: "PlayerTalentFrameTalent17"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 335
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent17Rank
        name: "PlayerTalentFrameTalent17Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent17"
        anchors.horizontalCenter: playerTalentFrameTalent17RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent17RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent18
        name: "PlayerTalentFrameTalent18"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 335
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent18Rank
        name: "PlayerTalentFrameTalent18Rank"
        kind: "FontString"
        text: "3"
        wowParent: "PlayerTalentFrameTalent18"
        anchors.horizontalCenter: playerTalentFrameTalent18RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent18RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent19
        name: "PlayerTalentFrameTalent19"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent19Rank
        name: "PlayerTalentFrameTalent19Rank"
        kind: "FontString"
        text: "1"
        wowParent: "PlayerTalentFrameTalent19"
        anchors.horizontalCenter: playerTalentFrameTalent19RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent19RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent1Rank
        name: "PlayerTalentFrameTalent1Rank"
        kind: "FontString"
        text: "3"
        wowParent: "PlayerTalentFrameTalent1"
        anchors.horizontalCenter: playerTalentFrameTalent1RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent1RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent2
        name: "PlayerTalentFrameTalent2"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent20
        name: "PlayerTalentFrameTalent20"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent20Rank
        name: "PlayerTalentFrameTalent20Rank"
        kind: "FontString"
        text: "5"
        wowParent: "PlayerTalentFrameTalent20"
        anchors.horizontalCenter: playerTalentFrameTalent20RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent20RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent21
        name: "PlayerTalentFrameTalent21"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 461
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent21Rank
        name: "PlayerTalentFrameTalent21Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent21"
        anchors.horizontalCenter: playerTalentFrameTalent21RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent21RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent22
        name: "PlayerTalentFrameTalent22"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 461
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent22Rank
        name: "PlayerTalentFrameTalent22Rank"
        kind: "FontString"
        text: "3"
        wowParent: "PlayerTalentFrameTalent22"
        anchors.horizontalCenter: playerTalentFrameTalent22RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent22RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent23
        name: "PlayerTalentFrameTalent23"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent24
        name: "PlayerTalentFrameTalent24"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent24Rank
        name: "PlayerTalentFrameTalent24Rank"
        kind: "FontString"
        text: "1"
        wowParent: "PlayerTalentFrameTalent24"
        anchors.horizontalCenter: playerTalentFrameTalent24RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent24RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent25
        name: "PlayerTalentFrameTalent25"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent25Rank
        name: "PlayerTalentFrameTalent25Rank"
        kind: "FontString"
        text: "3"
        wowParent: "PlayerTalentFrameTalent25"
        anchors.horizontalCenter: playerTalentFrameTalent25RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent25RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent26
        name: "PlayerTalentFrameTalent26"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 587
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent26Rank
        name: "PlayerTalentFrameTalent26Rank"
        kind: "FontString"
        text: "5"
        wowParent: "PlayerTalentFrameTalent26"
        anchors.horizontalCenter: playerTalentFrameTalent26RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent26RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent27
        name: "PlayerTalentFrameTalent27"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 650
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent27Rank
        name: "PlayerTalentFrameTalent27Rank"
        kind: "FontString"
        text: "1"
        wowParent: "PlayerTalentFrameTalent27"
        anchors.horizontalCenter: playerTalentFrameTalent27RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent27RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent2Rank
        name: "PlayerTalentFrameTalent2Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent2"
        anchors.horizontalCenter: playerTalentFrameTalent2RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent2RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent3
        name: "PlayerTalentFrameTalent3"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent3Rank
        name: "PlayerTalentFrameTalent3Rank"
        kind: "FontString"
        text: "5"
        wowParent: "PlayerTalentFrameTalent3"
        anchors.horizontalCenter: playerTalentFrameTalent3RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent3RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent4
        name: "PlayerTalentFrameTalent4"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent5
        name: "PlayerTalentFrameTalent5"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent5Rank
        name: "PlayerTalentFrameTalent5Rank"
        kind: "FontString"
        text: "2"
        wowParent: "PlayerTalentFrameTalent5"
        anchors.horizontalCenter: playerTalentFrameTalent5RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent5RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent6
        name: "PlayerTalentFrameTalent6"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent6Rank
        name: "PlayerTalentFrameTalent6Rank"
        kind: "FontString"
        text: "3"
        wowParent: "PlayerTalentFrameTalent6"
        anchors.horizontalCenter: playerTalentFrameTalent6RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent6RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent7
        name: "PlayerTalentFrameTalent7"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent8
        name: "PlayerTalentFrameTalent8"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent8Rank
        name: "PlayerTalentFrameTalent8Rank"
        kind: "FontString"
        text: "5"
        wowParent: "PlayerTalentFrameTalent8"
        anchors.horizontalCenter: playerTalentFrameTalent8RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent8RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalent9
        name: "PlayerTalentFrameTalent9"
        kind: "Button"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    Part {
        id: playerTalentFrameTalent9Rank
        name: "PlayerTalentFrameTalent9Rank"
        kind: "FontString"
        text: "1"
        wowParent: "PlayerTalentFrameTalent9"
        anchors.horizontalCenter: playerTalentFrameTalent9RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent9RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Part {
        id: playerTalentFrameTalentPointsText
        name: "PlayerTalentFrameTalentPointsText"
        kind: "FontString"
        wowParent: "PlayerTalentFramePointsBar"
        anchors.right: playerTalentFramePointsBar.right
        anchors.rightMargin: 12
        anchors.verticalCenter: playerTalentFramePointsBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 98.8
        height: 15
    }

    Part {
        id: playerTalentFrameTitleText
        name: "PlayerTalentFrameTitleText"
        kind: "FontString"
        text: "Secondary Talents"
        wowParent: "PlayerTalentFrameDiabolicTitlePlate"
        anchors.horizontalCenter: playerTalentFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: playerTalentFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 175.4
        height: 14.2
    }

    Ghost { id: playerTalentFrameTalent10RankBorder; name: "PlayerTalentFrameTalent10RankBorder"; x: 177; y: 320; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent11RankBorder; name: "PlayerTalentFrameTalent11RankBorder"; x: 240; y: 320; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent12RankBorder; name: "PlayerTalentFrameTalent12RankBorder"; x: 303; y: 320; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent14RankBorder; name: "PlayerTalentFrameTalent14RankBorder"; x: 177; y: 383; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent16RankBorder; name: "PlayerTalentFrameTalent16RankBorder"; x: 303; y: 383; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent17RankBorder; name: "PlayerTalentFrameTalent17RankBorder"; x: 114; y: 446; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent18RankBorder; name: "PlayerTalentFrameTalent18RankBorder"; x: 240; y: 446; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent19RankBorder; name: "PlayerTalentFrameTalent19RankBorder"; x: 177; y: 508.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent1RankBorder; name: "PlayerTalentFrameTalent1RankBorder"; x: 114; y: 130.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent20RankBorder; name: "PlayerTalentFrameTalent20RankBorder"; x: 240; y: 508.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent21RankBorder; name: "PlayerTalentFrameTalent21RankBorder"; x: 114; y: 571.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent22RankBorder; name: "PlayerTalentFrameTalent22RankBorder"; x: 240; y: 571.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent24RankBorder; name: "PlayerTalentFrameTalent24RankBorder"; x: 177; y: 634.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent25RankBorder; name: "PlayerTalentFrameTalent25RankBorder"; x: 240; y: 634.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent26RankBorder; name: "PlayerTalentFrameTalent26RankBorder"; x: 240; y: 697.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent27RankBorder; name: "PlayerTalentFrameTalent27RankBorder"; x: 177; y: 760.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent2RankBorder; name: "PlayerTalentFrameTalent2RankBorder"; x: 177; y: 130.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent3RankBorder; name: "PlayerTalentFrameTalent3RankBorder"; x: 240; y: 130.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent5RankBorder; name: "PlayerTalentFrameTalent5RankBorder"; x: 177; y: 193.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent6RankBorder; name: "PlayerTalentFrameTalent6RankBorder"; x: 240; y: 193.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent8RankBorder; name: "PlayerTalentFrameTalent8RankBorder"; x: 177; y: 257; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent9RankBorder; name: "PlayerTalentFrameTalent9RankBorder"; x: 240; y: 257; width: 0; height: 0 }
}
