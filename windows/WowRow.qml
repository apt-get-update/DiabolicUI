// A row of a window's parts, sharing the room from a part's left to its right, in
// the order of `parts`. `fit`: "fill" (as wide as their texts, the room left
// shared), "equal" (all as wide, filling the room), "center" (as they are, together
// in the middle), "ends" (as they are, the first and last at the ends). `spacing`: apart, else the windows' rule. Anchor it
// on one part, not one that hangs from these (a window's foot follows its buttons).
// tools/positions.lua places its parts from it: they're pinned, change it instead.
import QtQuick

Item {
    property string name
    property var parts: []
    property string fit: "fill"
    property real spacing: 6
}
