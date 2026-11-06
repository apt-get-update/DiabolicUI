// A section's title bar: dark, iron arrows at its ends, its title on the left in orange.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "section"
    property string texture: "textures/DiabolicUI_Window_Section.tga"
    property var canvas: [512, 32]
    property var art: [0, 3, 512, 29]
    property var left: [0, 32]
    property var middle: [32, 480]
    property var right: [480, 512]
    property real height: 22
    property string font: "DiabolicFont_HeaderRegular12"
    property var color: [1, .6, .2]

    // from its left, past the arrow
    property var text_offset: [28, 1]
}
