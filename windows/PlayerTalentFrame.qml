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

    Ghost { id: playerTalentFrameTalent1RankBorder; name: "PlayerTalentFrameTalent1RankBorder"; x: 114; y: 130.9; width: 0; height: 0 }
}
