// A window of settings/positions.lua's parts: its parts are all its direct
// children, so any can anchor on any (QML anchors only on parents and siblings).
import QtQuick

Item {
    property string name
    property real px: 1 // (one screen pixel at the editor's zoom)
    property bool outlines: true // (each part's box)
}
