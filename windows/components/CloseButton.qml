// The close button: Diablo III's burnt orange square, its X a thin glowing line, on
// the window's top right corner, in a socket of the window's own iron, its frame's
// edge (its iron 15 to 24 in) drawn on its left and bottom only.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "close"
    property real size: 22
    property var texture: ({ normal: "textures/DiabolicUI_D3_Close.tga", lit: "textures/DiabolicUI_D3_CloseLit.tga", pushed: "textures/DiabolicUI_D3_ClosePushed.tga" })

    // the square in its canvas
    property var texcoords: [12/64, 52/64, 12/64, 52/64]

    // from the window's corner to its bars' outside: the X (22) and the two irons' halves (20 each)
    property real socket_size: 62

    // the middle of the window's iron
    property real socket_inset: 20

    // the left edge's art mitred with itself
    property string socket_corner: "textures/DiabolicUI_D3_SocketCorner.tga"
    property var socket_color: [0, 0, 0, 1]
}
