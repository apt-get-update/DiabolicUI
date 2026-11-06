// A row of parts, the ones inside it, sharing the room from what it's in's left to its
// right (its anchors). `fit`: "fill" (as wide as their texts, the room left shared),
// "equal" (all as wide, filling the room), "center" (as they are, together in the
// middle), "ends" (as they are, the first and last at the ends). `spacing`: apart.
// Not on what hangs from its parts (a window's foot follows its buttons). Worked out
// here for the editor, by ResolveRow in tools/positions.lua for the game: change one,
// change the other.
import QtQuick

Item {
    id: row
    property string name
    property string fit: "fill"
    property real spacing: 6
    property real px: parent && parent.px !== undefined ? parent.px : 1
    property bool outlines: parent && parent.outlines !== undefined ? parent.outlines : true

    function place() {
        const parts = []
        for (let i = 0; i < children.length; i++) if (children[i].kind !== undefined) parts.push(children[i])
        const count = parts.length
        if (!count || !width) return
        const tenth = v => Math.round(v * 10) / 10
        const widths = parts.map(p => p.width), total = () => widths.reduce((a, b) => a + b, 0)
        const shared = width - spacing * (count - 1)
        let gap = spacing, first = 0
        if (fit === "fill") {
            // (those with a text as wide as it, the room left shared between them; no text known: all of them)
            const texted = parts.map(p => p.look.textWidth !== undefined && p.look.textWidth !== null)
            const all = texted.indexOf(true) < 0
            parts.forEach((p, i) => { if (texted[i]) widths[i] = p.look.textWidth })
            const extra = (shared - total()) / (all ? count : texted.filter(t => t).length)
            let last = count - 1
            parts.forEach((p, i) => {
                widths[i] = tenth(widths[i] + (all || texted[i] ? extra : 0))
                if (all || texted[i]) last = i
            })
            widths[last] = tenth(widths[last] + shared - total())
        } else if (fit === "equal") {
            parts.forEach((p, i) => { widths[i] = tenth(shared / count) })
            widths[count - 1] = tenth(widths[count - 1] + shared - total())
        } else if (fit === "center") {
            first = (width - total() - spacing * (count - 1)) / 2
        } else if (count > 1) {
            gap = (width - total()) / (count - 1)
        } else {
            first = (width - total()) / 2
        }
        let x = tenth(first)
        parts.forEach((p, i) => {
            p.x = x
            p.y = (parts[0].height - p.height) / 2
            p.width = widths[i]
            x += widths[i] + tenth(gap)
        })
        height = parts[0].height
    }
    onWidthChanged: place()
    onFitChanged: place()
    onSpacingChanged: place()
    Component.onCompleted: place()
}
