// The bars: Diablo III's breath meter, a thin frame with metal caps, its red fill over
// its faint track; its middle a plain stretch of it (not its centrepiece).
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "bar"
    property string texture: "textures/DiabolicUI_D3_BreathMeter.tga"
    property var canvas: [256, 64]

    // the frame's inside: the bar
    property var art: [12, 10, 202, 35]
    property var left: [0, 14]
    property var middle: [14, 200]
    property var right: [200, 214]
    property string statusbar: "textures/DiabolicUI_D3_BreathMeterFill.tga"
    property string track: "textures/DiabolicUI_D3_BreathMeterTrack.tga"

    // the fill's own red
    property var color: [1, 1, 1]

    // how far its caps reach past the bar
    property real spike: 8
}
