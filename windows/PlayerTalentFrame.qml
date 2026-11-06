// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: playerTalentFrame
    name: "PlayerTalentFrame"
    width: 384
    height: 512

    Frame {
        id: glyphFrame
        name: "GlyphFrame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 45.4
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 86.7
        width: 384
        height: 512
    }

    Button {
        id: glyphFrameGlyph1
        name: "GlyphFrameGlyph1"
        wowParent: "GlyphFrame"
        anchors.horizontalCenter: glyphFrame.horizontalCenter
        anchors.horizontalCenterOffset: -15
        anchors.verticalCenter: glyphFrame.verticalCenter
        anchors.verticalCenterOffset: -140
        width: 90
        height: 90
    }

    Button {
        id: glyphFrameGlyph2
        name: "GlyphFrameGlyph2"
        wowParent: "GlyphFrame"
        anchors.horizontalCenter: glyphFrame.horizontalCenter
        anchors.horizontalCenterOffset: -14
        anchors.verticalCenter: glyphFrame.verticalCenter
        anchors.verticalCenterOffset: 103
        width: 90
        height: 90
    }

    Button {
        id: glyphFrameGlyph3
        name: "GlyphFrameGlyph3"
        wowParent: "GlyphFrame"
        anchors.left: glyphFrame.left
        anchors.leftMargin: 28
        anchors.top: glyphFrame.top
        anchors.topMargin: 133
        width: 90
        height: 90
    }

    Button {
        id: glyphFrameGlyph4
        name: "GlyphFrameGlyph4"
        wowParent: "GlyphFrame"
        anchors.right: glyphFrame.right
        anchors.rightMargin: 56
        anchors.bottom: glyphFrame.bottom
        anchors.bottomMargin: 168
        width: 90
        height: 90
    }

    Button {
        id: glyphFrameGlyph5
        name: "GlyphFrameGlyph5"
        wowParent: "GlyphFrame"
        anchors.right: glyphFrame.right
        anchors.rightMargin: 56
        anchors.top: glyphFrame.top
        anchors.topMargin: 133
        width: 90
        height: 90
    }

    Button {
        id: glyphFrameGlyph6
        name: "GlyphFrameGlyph6"
        wowParent: "GlyphFrame"
        anchors.left: glyphFrame.left
        anchors.leftMargin: 26
        anchors.bottom: glyphFrame.bottom
        anchors.bottomMargin: 168
        width: 90
        height: 90
    }

    Frame {
        id: glyphFrameSparkleFrame
        name: "GlyphFrameSparkleFrame"
        wowParent: "GlyphFrame"
        anchors.left: glyphFrame.left
        anchors.top: glyphFrame.top
        width: 337.9
        height: 450.6
    }

    FontString {
        id: glyphFrameTitleText
        name: "GlyphFrameTitleText"
        text: "Secondary Glyphs"
        wowParent: "GlyphFrame"
        anchors.horizontalCenter: glyphFrame.horizontalCenter
        anchors.top: glyphFrame.top
        anchors.topMargin: 18
        width: 96.4
        height: 10.3
    }

    CheckButton {
        id: playerSpecTab1
        name: "PlayerSpecTab1"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolicBand.left
        anchors.leftMargin: 12
        anchors.verticalCenter: playerTalentFrameDiabolicBand.verticalCenter
        width: 28
        height: 28
    }

    CheckButton {
        id: playerSpecTab2
        name: "PlayerSpecTab2"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerSpecTab1.right
        anchors.leftMargin: 6
        anchors.verticalCenter: playerSpecTab1.verticalCenter
        width: 28
        height: 28
    }

    Button {
        id: playerTalentFrameActivateButton
        name: "PlayerTalentFrameActivateButton"
        text: "Activate These Talents"
        wowParent: "PlayerTalentFrame"
        pin: "place"
        anchors.horizontalCenter: playerTalentFrameDiabolicBand.horizontalCenter
        anchors.verticalCenter: playerTalentFrameDiabolicBand.verticalCenter
        width: 201.8
        height: 22
    }

    FontString {
        id: playerTalentFrameActivateButtonText
        name: "PlayerTalentFrameActivateButtonText"
        text: "Activate These Talents"
        wowParent: "PlayerTalentFrameActivateButton"
        anchors.horizontalCenter: playerTalentFrameActivateButton.horizontalCenter
        anchors.verticalCenter: playerTalentFrameActivateButton.verticalCenter
        width: 177.8
        height: 11.9
    }

    Frame {
        id: playerTalentFrameArrowFrame
        name: "PlayerTalentFrameArrowFrame"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.top: playerTalentFrameScrollChildFrame.top
        width: 320
        height: 50
    }

    Button {
        id: playerTalentFrameCloseButton
        name: "PlayerTalentFrameCloseButton"
        wowParent: "PlayerTalentFrame"
        style: "CloseButton"
        anchors.horizontalCenter: playerTalentFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: playerTalentFrameDiabolic.top
        anchors.verticalCenterOffset: 63
        width: 22
        height: 22
    }

    Frame {
        id: playerTalentFrameDiabolic
        name: "PlayerTalentFrameDiabolic"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrame.left
        anchors.top: playerTalentFrame.top
        anchors.topMargin: -36
        width: 402
        height: 530
    }

    Frame {
        id: playerTalentFrameDiabolicBand
        name: "PlayerTalentFrameDiabolicBand"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 56
        width: 354
        height: 40
    }

    Frame {
        id: playerTalentFrameDiabolicBorder
        name: "PlayerTalentFrameDiabolicBorder"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 32
        width: 402
        height: 498
    }

    Frame {
        id: playerTalentFrameDiabolicCover
        name: "PlayerTalentFrameDiabolicCover"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 100
        width: 354
        height: 406
    }

    Frame {
        id: playerTalentFrameDiabolicRail
        name: "PlayerTalentFrameDiabolicRail"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 246
        height: 18
    }

    Frame {
        id: playerTalentFrameDiabolicSocket
        name: "PlayerTalentFrameDiabolicSocket"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.right: playerTalentFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 52
        width: 42
        height: 42
    }

    Frame {
        id: playerTalentFrameDiabolicTitlePlate
        name: "PlayerTalentFrameDiabolicTitlePlate"
        wowParent: "PlayerTalentFrameDiabolic"
        anchors.horizontalCenter: playerTalentFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Button {
        id: playerTalentFrameLearnButton
        name: "PlayerTalentFrameLearnButton"
        text: "Learn"
        wowParent: "PlayerTalentFramePreviewBar"
        style: "Button"
        anchors.right: playerTalentFrameResetButton.left
        anchors.verticalCenter: playerTalentFrameResetButton.verticalCenter
        width: 80
        height: 22
    }

    FontString {
        id: playerTalentFrameLearnButtonText
        name: "PlayerTalentFrameLearnButtonText"
        text: "Learn"
        wowParent: "PlayerTalentFrameLearnButton"
        anchors.horizontalCenter: playerTalentFrameLearnButton.horizontalCenter
        anchors.verticalCenter: playerTalentFrameLearnButton.verticalCenter
        width: 42.7
        height: 11.9
    }

    Frame {
        id: playerTalentFramePointsBar
        name: "PlayerTalentFramePointsBar"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 32
        anchors.verticalCenter: playerTalentFrameDiabolic.verticalCenter
        anchors.verticalCenterOffset: 222
        width: 338
        height: 26
    }

    Frame {
        id: playerTalentFramePreviewBar
        name: "PlayerTalentFramePreviewBar"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 32
        anchors.verticalCenter: playerTalentFrameDiabolic.verticalCenter
        anchors.verticalCenterOffset: 222
        width: 338
        height: 26
    }

    Frame {
        id: playerTalentFramePreviewBarFiller
        name: "PlayerTalentFramePreviewBarFiller"
        wowParent: "PlayerTalentFramePreviewBar"
        anchors.left: playerTalentFramePreviewBar.left
        anchors.verticalCenter: playerTalentFramePreviewBar.verticalCenter
        width: 174
        height: 26
    }

    Button {
        id: playerTalentFrameResetButton
        name: "PlayerTalentFrameResetButton"
        text: "Reset"
        wowParent: "PlayerTalentFramePreviewBar"
        style: "Button"
        anchors.right: playerTalentFramePreviewBar.right
        anchors.rightMargin: 4
        anchors.verticalCenter: playerTalentFramePreviewBar.verticalCenter
        width: 80
        height: 22
    }

    FontString {
        id: playerTalentFrameResetButtonText
        name: "PlayerTalentFrameResetButtonText"
        text: "Reset"
        wowParent: "PlayerTalentFrameResetButton"
        anchors.horizontalCenter: playerTalentFrameResetButton.horizontalCenter
        anchors.verticalCenter: playerTalentFrameResetButton.verticalCenter
        width: 40.3
        height: 11.9
    }

    Frame {
        id: playerTalentFrameScrollChildFrame
        name: "PlayerTalentFrameScrollChildFrame"
        wowParent: "PlayerTalentFrameScrollFrame"
        anchors.left: playerTalentFrameScrollFrame.left
        anchors.top: playerTalentFrameScrollFrame.top
        width: 320
        height: 50
    }

    ScrollFrame {
        id: playerTalentFrameScrollFrame
        name: "PlayerTalentFrameScrollFrame"
        wowParent: "PlayerTalentFrame"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 42
        anchors.top: playerTalentFrameDiabolic.top
        anchors.topMargin: 110
        width: 296
        height: 356
    }

    Slider {
        id: playerTalentFrameScrollFrameScrollBar
        name: "PlayerTalentFrameScrollFrameScrollBar"
        wowParent: "PlayerTalentFrameScrollFrame"
        style: "ScrollBar"
        anchors.left: playerTalentFrameScrollFrame.right
        anchors.leftMargin: 6
        anchors.top: playerTalentFrameScrollFrame.top
        anchors.topMargin: 16
        width: 16
        height: 324
    }

    Frame {
        id: playerTalentFrameScrollFrameScrollBarDiabolicTrack
        name: "PlayerTalentFrameScrollFrameScrollBarDiabolicTrack"
        wowParent: "PlayerTalentFrameScrollFrameScrollBar"
        anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBarScrollUpButton.horizontalCenter
        anchors.top: playerTalentFrameScrollFrameScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 358
    }

    Button {
        id: playerTalentFrameScrollFrameScrollBarScrollDownButton
        name: "PlayerTalentFrameScrollFrameScrollBarScrollDownButton"
        wowParent: "PlayerTalentFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBar.horizontalCenter
        anchors.top: playerTalentFrameScrollFrameScrollBar.bottom
        width: 16
        height: 16
    }

    Button {
        id: playerTalentFrameScrollFrameScrollBarScrollUpButton
        name: "PlayerTalentFrameScrollFrameScrollBarScrollUpButton"
        wowParent: "PlayerTalentFrameScrollFrameScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: playerTalentFrameScrollFrameScrollBar.horizontalCenter
        anchors.bottom: playerTalentFrameScrollFrameScrollBar.top
        width: 16
        height: 16
    }

    FontString {
        id: playerTalentFrameSpentPointsText
        name: "PlayerTalentFrameSpentPointsText"
        wowParent: "PlayerTalentFramePointsBar"
        anchors.left: playerTalentFramePointsBar.left
        anchors.leftMargin: 12
        anchors.verticalCenter: playerTalentFramePointsBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 104.3
        height: 15
    }

    Frame {
        id: playerTalentFrameStatusFrame
        name: "PlayerTalentFrameStatusFrame"
        wowParent: "PlayerTalentFrame"
        pin: "place"
        anchors.horizontalCenter: playerTalentFrameDiabolicBand.horizontalCenter
        anchors.verticalCenter: playerTalentFrameDiabolicBand.verticalCenter
        width: 264
        height: 20
    }

    FontString {
        id: playerTalentFrameStatusText
        name: "PlayerTalentFrameStatusText"
        text: "These are your active talents"
        wowParent: "PlayerTalentFrameStatusFrame"
        anchors.horizontalCenter: playerTalentFrameStatusFrame.horizontalCenter
        anchors.verticalCenter: playerTalentFrameStatusFrame.verticalCenter
        width: 167.5
        height: 14.2
    }

    Button {
        id: playerTalentFrameTab1
        name: "PlayerTalentFrameTab1"
        text: "Discipline"
        wowParent: "PlayerTalentFrame"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: playerTalentFrameTab2
        name: "PlayerTalentFrameTab2"
        text: "Holy"
        wowParent: "PlayerTalentFrame"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: playerTalentFrameTab3
        name: "PlayerTalentFrameTab3"
        text: "Shadow"
        wowParent: "PlayerTalentFrame"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: playerTalentFrameTab4
        name: "PlayerTalentFrameTab4"
        text: "Glyphs"
        wowParent: "PlayerTalentFrame"
        style: "Banner"
        anchors.left: playerTalentFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: playerTalentFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: playerTalentFrameTalent1
        name: "PlayerTalentFrameTalent1"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent10
        name: "PlayerTalentFrameTalent10"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent10Rank
        name: "PlayerTalentFrameTalent10Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent10"
        anchors.horizontalCenter: playerTalentFrameTalent10RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent10RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent11
        name: "PlayerTalentFrameTalent11"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent11Rank
        name: "PlayerTalentFrameTalent11Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent11"
        anchors.horizontalCenter: playerTalentFrameTalent11RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent11RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent12
        name: "PlayerTalentFrameTalent12"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 209
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent12Rank
        name: "PlayerTalentFrameTalent12Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent12"
        anchors.horizontalCenter: playerTalentFrameTalent12RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent12RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent13
        name: "PlayerTalentFrameTalent13"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent14
        name: "PlayerTalentFrameTalent14"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent14Rank
        name: "PlayerTalentFrameTalent14Rank"
        text: "1"
        wowParent: "PlayerTalentFrameTalent14"
        anchors.horizontalCenter: playerTalentFrameTalent14RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent14RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent15
        name: "PlayerTalentFrameTalent15"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent16
        name: "PlayerTalentFrameTalent16"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 224
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 272
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent16Rank
        name: "PlayerTalentFrameTalent16Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent16"
        anchors.horizontalCenter: playerTalentFrameTalent16RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent16RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent17
        name: "PlayerTalentFrameTalent17"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 335
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent17Rank
        name: "PlayerTalentFrameTalent17Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent17"
        anchors.horizontalCenter: playerTalentFrameTalent17RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent17RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent18
        name: "PlayerTalentFrameTalent18"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 335
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent18Rank
        name: "PlayerTalentFrameTalent18Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent18"
        anchors.horizontalCenter: playerTalentFrameTalent18RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent18RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent19
        name: "PlayerTalentFrameTalent19"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent19Rank
        name: "PlayerTalentFrameTalent19Rank"
        text: "1"
        wowParent: "PlayerTalentFrameTalent19"
        anchors.horizontalCenter: playerTalentFrameTalent19RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent19RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    FontString {
        id: playerTalentFrameTalent1Rank
        name: "PlayerTalentFrameTalent1Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent1"
        anchors.horizontalCenter: playerTalentFrameTalent1RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent1RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent2
        name: "PlayerTalentFrameTalent2"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent20
        name: "PlayerTalentFrameTalent20"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 398
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent20Rank
        name: "PlayerTalentFrameTalent20Rank"
        text: "5"
        wowParent: "PlayerTalentFrameTalent20"
        anchors.horizontalCenter: playerTalentFrameTalent20RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent20RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent21
        name: "PlayerTalentFrameTalent21"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 461
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent21Rank
        name: "PlayerTalentFrameTalent21Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent21"
        anchors.horizontalCenter: playerTalentFrameTalent21RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent21RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent22
        name: "PlayerTalentFrameTalent22"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 461
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent22Rank
        name: "PlayerTalentFrameTalent22Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent22"
        anchors.horizontalCenter: playerTalentFrameTalent22RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent22RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent23
        name: "PlayerTalentFrameTalent23"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent24
        name: "PlayerTalentFrameTalent24"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent24Rank
        name: "PlayerTalentFrameTalent24Rank"
        text: "1"
        wowParent: "PlayerTalentFrameTalent24"
        anchors.horizontalCenter: playerTalentFrameTalent24RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent24RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent25
        name: "PlayerTalentFrameTalent25"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent25Rank
        name: "PlayerTalentFrameTalent25Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent25"
        anchors.horizontalCenter: playerTalentFrameTalent25RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent25RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent26
        name: "PlayerTalentFrameTalent26"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 587
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent26Rank
        name: "PlayerTalentFrameTalent26Rank"
        text: "5"
        wowParent: "PlayerTalentFrameTalent26"
        anchors.horizontalCenter: playerTalentFrameTalent26RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent26RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent27
        name: "PlayerTalentFrameTalent27"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 650
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent27Rank
        name: "PlayerTalentFrameTalent27Rank"
        text: "1"
        wowParent: "PlayerTalentFrameTalent27"
        anchors.horizontalCenter: playerTalentFrameTalent27RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent27RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent28
        name: "PlayerTalentFrameTalent28"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent29
        name: "PlayerTalentFrameTalent29"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 524
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent2Rank
        name: "PlayerTalentFrameTalent2Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent2"
        anchors.horizontalCenter: playerTalentFrameTalent2RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent2RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent3
        name: "PlayerTalentFrameTalent3"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 20
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent30
        name: "PlayerTalentFrameTalent30"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 587
        width: 37
        height: 37
    }

    Button {
        id: playerTalentFrameTalent31
        name: "PlayerTalentFrameTalent31"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 650
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent3Rank
        name: "PlayerTalentFrameTalent3Rank"
        text: "5"
        wowParent: "PlayerTalentFrameTalent3"
        anchors.horizontalCenter: playerTalentFrameTalent3RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent3RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent4
        name: "PlayerTalentFrameTalent4"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent4Rank
        name: "PlayerTalentFrameTalent4Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent4"
        anchors.horizontalCenter: playerTalentFrameTalent4RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent4RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent5
        name: "PlayerTalentFrameTalent5"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent5Rank
        name: "PlayerTalentFrameTalent5Rank"
        text: "2"
        wowParent: "PlayerTalentFrameTalent5"
        anchors.horizontalCenter: playerTalentFrameTalent5RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent5RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent6
        name: "PlayerTalentFrameTalent6"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 83
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent6Rank
        name: "PlayerTalentFrameTalent6Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent6"
        anchors.horizontalCenter: playerTalentFrameTalent6RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent6RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent7
        name: "PlayerTalentFrameTalent7"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 35
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent7Rank
        name: "PlayerTalentFrameTalent7Rank"
        text: "3"
        wowParent: "PlayerTalentFrameTalent7"
        anchors.horizontalCenter: playerTalentFrameTalent7RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent7RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent8
        name: "PlayerTalentFrameTalent8"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 98
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent8Rank
        name: "PlayerTalentFrameTalent8Rank"
        text: "5"
        wowParent: "PlayerTalentFrameTalent8"
        anchors.horizontalCenter: playerTalentFrameTalent8RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent8RankBorder.verticalCenter
        width: 7.9
        height: 10.3
    }

    Button {
        id: playerTalentFrameTalent9
        name: "PlayerTalentFrameTalent9"
        wowParent: "PlayerTalentFrameScrollChildFrame"
        anchors.left: playerTalentFrameScrollChildFrame.left
        anchors.leftMargin: 161
        anchors.top: playerTalentFrameScrollChildFrame.top
        anchors.topMargin: 146
        width: 37
        height: 37
    }

    FontString {
        id: playerTalentFrameTalent9Rank
        name: "PlayerTalentFrameTalent9Rank"
        text: "1"
        wowParent: "PlayerTalentFrameTalent9"
        anchors.horizontalCenter: playerTalentFrameTalent9RankBorder.horizontalCenter
        anchors.verticalCenter: playerTalentFrameTalent9RankBorder.verticalCenter
        width: 6.3
        height: 10.3
    }

    FontString {
        id: playerTalentFrameTalentPointsText
        name: "PlayerTalentFrameTalentPointsText"
        wowParent: "PlayerTalentFramePointsBar"
        anchors.right: playerTalentFramePointsBar.right
        anchors.rightMargin: 12
        anchors.verticalCenter: playerTalentFramePointsBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 98.8
        height: 15
    }

    FontString {
        id: playerTalentFrameTitleText
        name: "PlayerTalentFrameTitleText"
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
    Ghost { id: playerTalentFrameTalent4RankBorder; name: "PlayerTalentFrameTalent4RankBorder"; x: 177; y: 193.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent5RankBorder; name: "PlayerTalentFrameTalent5RankBorder"; x: 177; y: 193.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent6RankBorder; name: "PlayerTalentFrameTalent6RankBorder"; x: 240; y: 193.9; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent7RankBorder; name: "PlayerTalentFrameTalent7RankBorder"; x: 114; y: 257; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent8RankBorder; name: "PlayerTalentFrameTalent8RankBorder"; x: 177; y: 257; width: 0; height: 0 }
    Ghost { id: playerTalentFrameTalent9RankBorder; name: "PlayerTalentFrameTalent9RankBorder"; x: 240; y: 257; width: 0; height: 0 }
}
