// A part of a window: where it goes (its anchors, width and height) and what
// it is in the game. `pin`: "all", "place" or "size" puts it in
// settings/positions.lua, without one it follows /dui layout's scan.
import QtQuick

Rectangle {
    property string name
    property string kind: "Frame"
    property string text
    property string wowParent
    property string pin
    property string style // (the component it's styled as: windows/components/)
    // (the editor's)
    property bool picked
    property bool placedOn
    property bool follower
    property bool changed

    readonly property real line: parent ? parent.px : 1
    opacity: picked || placedOn || !parent || parent.outlines ? 1 : 0
    color: picked ? "#2ee0a640" : follower ? "#1ae0c040" : kind === "Texture" || kind === "FontString" ? "transparent" : "#0a6fa8dc"
    border.width: (picked || placedOn ? 2 : pin !== "" ? 3 : 1) * line
    border.color: picked ? "#e0a640" : placedOn ? "#e0c040" : changed ? "#e8703a" : kind === "FontString" ? "#8fce7a" : kind === "Texture" ? "#b48ead" : "#6fa8dc"

    Text {
        visible: parent.kind === "FontString"
        anchors.fill: parent
        text: parent.text
        color: "#8fce7a"
        font.pixelSize: 9
        clip: true
    }
}
