// A part of a window: where it goes (its anchors on the part it's in, its width and
// height) and what it is in the game. `pin`: "all", "place" or "size" puts it in
// settings/positions.lua, without one it follows /dui layout's scan.
import QtQuick

Item {
    property string name
    property string kind: "Frame"
    property string text
    property string wowParent
    property string pin
    property string style // (the component it's styled as: windows/components/)
    // (the editor's)
    property bool shown: true // (what's drawn of it, by the tab: not `visible`, which would hide what's in it)
    property bool picked
    property bool placedOn
    property bool changed
    property string justify // (a text's, from the scan)
    property var look: ({}) // (how its text is drawn: GameText.qml)
    property bool wordless // (its text not to draw, not there when the scan last looked, or faded)
    property bool labelled // (a button whose text has no part of its own)
    // (from the part it's in, any kind: not known to the linter)
    // qmllint disable missing-property
    property real px: parent && parent.px !== undefined ? parent.px : 1 // (one screen pixel at the editor's zoom)
    property bool outlines: parent && parent.outlines !== undefined ? parent.outlines : true
    // qmllint enable missing-property

    // (outlines off: only what's picked has its box; a text still shows, it's what the window says)
    readonly property bool boxed: picked || placedOn || outlines

    Rectangle {
        anchors.fill: parent
        visible: parent.shown && parent.boxed
        color: parent.picked ? "#2ee0a640" : parent.kind === "Texture" || parent.kind === "FontString" ? "transparent" : "#0a6fa8dc"
        border.width: (parent.picked || parent.placedOn ? 2 : parent.pin !== "" ? 3 : 1) * parent.px
        border.color: parent.picked ? "#e0a640" : parent.placedOn ? "#e0c040" : parent.changed ? "#e8703a" : parent.kind === "FontString" ? "#8fce7a" : parent.kind === "Texture" ? "#b48ead" : "#6fa8dc"
    }

    GameText {
        visible: parent.shown && (parent.kind === "FontString" || parent.labelled) && !parent.wordless
        anchors.fill: parent
        words: parent.text
        look: parent.look
        oneLine: parent.labelled
        horizontalAlignment: parent.labelled || parent.justify === "CENTER" ? Text.AlignHCenter : parent.justify === "RIGHT" ? Text.AlignRight : Text.AlignLeft
    }
}
