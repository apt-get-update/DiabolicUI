// The scroll bars: a black track in a thin bronze line, red arrows (the chat's)
// and thumb (the sliders'), cut from their canvas to their art.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "scrollbar"

    // Blizzard's bars'
    property real width: 16
    property var up: ({ normal: "textures/DiabolicUI_ChatButtons_36x36_Up.tga", lit: "textures/DiabolicUI_ChatButtons_36x36_UpHighlight.tga", disabled: "textures/DiabolicUI_ChatButtons_36x36_UpDisabled.tga" })
    property var down: ({ normal: "textures/DiabolicUI_ChatButtons_36x36_Down.tga", lit: "textures/DiabolicUI_ChatButtons_36x36_DownHighlight.tga", disabled: "textures/DiabolicUI_ChatButtons_36x36_DownDisabled.tga" })

    // their 36x36 art
    property var arrow_texcoords: [14/64, 50/64, 14/64, 50/64]
    property string thumb: "textures/DiabolicUI_Slider_22x36_Thumb.tga"

    // its 22x36 art
    property var thumb_texcoords: [21/64, 43/64, 14/64, 50/64]

    // its art's shape at the bar's width
    property real thumb_height: 26
    property string blank: "Interface/Buttons/WHITE8X8"
    property real line: 1
    property var track_color: [0, 0, 0, .85]
    property var line_color: [.35, .27, .15, 1]
}
