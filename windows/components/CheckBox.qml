// The checkboxes: Diablo III's options' box, 42 x 43 at the top left of each 64 x 64
// slot of its file: empty, its frame alone lit (under the mouse); Blizzard's gold
// tick over it when checked.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "check_box"
    property string texture: "textures/DiabolicUI_D3_CheckBox.tga"
    property var box: [0, 42/256, 0, 43/64]
    property var lit: [64/256, 106/256, 0, 43/64]
    property string check: "Interface/Buttons/UI-CheckBox-Check"
    property string check_disabled: "Interface/Buttons/UI-CheckBox-Check-Disabled"

    // the tick's file is 32 for Blizzard's box of about 20: as big over ours
    property real check_scale: 1.6
    property real size: 20
    property var pushed_color: [.7, .7, .7]

    // its label from it
    property real label_gap: 4

    // its label (the band's)
    property string font: "DiabolicFont_Narrow14"

    // two one under the other in a band: within its height
    property var stacked: ({ size: 16, font: "DiabolicFont_Narrow12" })
}
