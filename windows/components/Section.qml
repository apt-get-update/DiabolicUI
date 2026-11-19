// A section's title: on the left in orange, a thin bronze line under it.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "section"
    property real height: 22
    property string font: "DiabolicFont_HeaderRegular12"
    property var color: [1, .6, .2]

    // the thin line under the title
    property var line_color: [.43, .33, .2, 1]

    // from its left
    property var text_offset: [4, 1]
}
