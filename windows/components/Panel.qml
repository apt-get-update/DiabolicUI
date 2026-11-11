// What the window shows, a little darker.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "panel"
    property var backdrop: ({ bgFile: "Interface/ChatFrame/ChatFrameBackground", edgeFile: "textures/DiabolicUI_Tooltip_Body.tga", edgeSize: 32, insets: { left: 3, right: 3, top: 3, bottom: 3 } })
    property var backdrop_color: [0, 0, 0, .5]
    property var backdrop_border_color: [71/255 * 3.5, 56/255 * 3.5, 28/255 * 3.5, 1]
}
