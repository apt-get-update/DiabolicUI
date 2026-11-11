// A list's rows: the chosen one as Diablo III's blacksmith's, faintly lit, in a thin
// orange box; its + and - (its headers', its collapse-all): Diablo III's red
// squares (the tracker's), the plus on top, the minus under it.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: ""
    property var chosen_row: ({ fill: [1, .55, .15, .12], line: [1, .6, .15, .9], width: 1 })
    property var expander: ({ texture: "textures/DiabolicUI_ExpandCollapseButton_22x21.tga", plus: [0, .5, 0, .5], minus: [0, .5, .5, 1] })
}
