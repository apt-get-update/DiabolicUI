// The edit boxes: on the dropdowns' field.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: ""

    // an edit box's plate (the dropdowns'), past its sides
    property real edit_padding: 8

    // an edit box's label pale in it while it's empty: its look, from its left
    property var hint: ({ font: "DiabolicFont_Narrow14", color: [.5, .45, .4], inset: 2 })
}
