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
    property string justify // (a text's, from the scan)
    property var look: ({}) // (how its text is drawn: GameText.qml)
    property bool wordless // (the editor's: its text not to draw, not there when the scan last looked, or faded)
    property bool labelled // (the editor's: a button whose text has no part of its own)

    readonly property real line: parent ? parent.px : 1
    // (outlines off: only what's picked has its box; a text still shows, it's what the window says)
    readonly property bool boxed: picked || placedOn || !parent || parent.outlines
    opacity: boxed || kind === "FontString" || labelled ? 1 : 0
    color: picked ? "#2ee0a640" : follower ? "#1ae0c040" : !boxed || kind === "Texture" || kind === "FontString" ? "transparent" : "#0a6fa8dc"
    border.width: boxed ? (picked || placedOn ? 2 : pin !== "" ? 3 : 1) * line : 0
    border.color: picked ? "#e0a640" : placedOn ? "#e0c040" : changed ? "#e8703a" : kind === "FontString" ? "#8fce7a" : kind === "Texture" ? "#b48ead" : "#6fa8dc"

    GameText {
        visible: (parent.kind === "FontString" || parent.labelled) && !parent.wordless
        anchors.fill: parent
        words: parent.text
        look: parent.look
        oneLine: parent.labelled
        horizontalAlignment: parent.labelled || parent.justify === "CENTER" ? Text.AlignHCenter : parent.justify === "RIGHT" ? Text.AlignRight : Text.AlignLeft
    }
}
