// A window: its parts inside it, each in what it's placed on (QML anchors only on a
// parent or a sibling), as settings/positions.lua places them in the game.
import QtQuick

Item {
    property string name
    property real px: 1 // (one screen pixel at the editor's zoom)
    property bool outlines: true // (each part's box)
}
