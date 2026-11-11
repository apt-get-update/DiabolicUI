// A table's column names on its dark bar (the section's, without its ends): Diablo
// III's red under the one hovered (the menus'), a thin bronze line between them.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "columns"
    property var hover_color: [.56, .1, .04, .9]
    property var line_color: [.42, .33, .18, 1]

    // the lines, short of the bar's top and bottom
    property real line_inset: 5
}
