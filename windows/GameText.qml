// A text as the game draws it: its font, size, colour and colour codes, from what
// /dui layout saw (`look`, a part of tools/layout.json). Drawn by Part.qml and by the
// editor's preview.
import QtQuick

Text {
    property string words
    property var look: ({})
    property bool oneLine // (a button's label: whatever the room)

    readonly property bool coded: /[|\n]/.test(words)
    // (wraps when its box has room for more lines; a box too narrow for its line ends in "...", as in the game)
    readonly property bool lines: !oneLine && height > 1.6 * font.pixelSize

    // |cAARRGGBB, |r, |n and links' codes as styled text; icons left out
    function styled(raw) {
        let open = false
        const body = raw.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
            .replace(/\|\||\|c[0-9a-fA-F]{8}|\|r|\|n|\n|\|H.*?\|h|\|h|\|T.*?\|t/g, code => {
                if (code === "||") return "|"
                if (code === "|n" || code === "\n") return "<br>"
                if (code === "|r" || code.startsWith("|c")) {
                    const close = open ? "</font>" : ""
                    open = code !== "|r"
                    return close + (open ? '<font color="#' + code.slice(4) + '">' : "")
                }
                return ""
            })
        return body + (open ? "</font>" : "")
    }

    text: coded ? styled(words) : words
    textFormat: coded ? Text.StyledText : Text.PlainText
    color: look.color ? Qt.rgba(Math.min(1, look.color[0]), Math.min(1, look.color[1]), Math.min(1, look.color[2]), look.color[3] === undefined ? 1 : look.color[3]) : "#e8dcc0"
    font.family: look.family || ""
    font.pixelSize: Math.max(1, Math.round(look.fontSize || 9))
    style: look.outline ? Text.Outline : look.shadow ? Text.Raised : Text.Normal
    styleColor: "#000000"
    verticalAlignment: oneLine || look.justifyV === "MIDDLE" || (!look.justifyV && !lines) ? Text.AlignVCenter : look.justifyV === "BOTTOM" ? Text.AlignBottom : Text.AlignTop
    wrapMode: lines ? Text.WordWrap : Text.NoWrap
    elide: !lines && (look.textWidth || 0) > width + 1 ? Text.ElideRight : Text.ElideNone
    clip: lines
}
