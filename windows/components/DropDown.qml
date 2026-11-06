// The dropdowns: a plain dark field, Diablo III's small orange square with its
// arrow.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "dropdown"
    property real height: 22

    // UIDropDownMenuTemplate's art is drawn that far in
    property real inset: 16

    // its text, in from the field's left
    property real text_padding: 6

    // its field (the edit boxes' too): the old plate's cracked dark stone (its
    // middle, without its iron and ornaments) in a bronze border, two lines thick,
    // bevelled (top and left light, bottom and right dark), brightest in each side's
    // middle (sheen_ends: each side's ends, from its middle's)
    property var field: ({ stone: "textures/DiabolicUI_D3_DropDown_Plate.tga", stone_coords: [40/512, 230/512, 38/128, 84/128], texture: "Interface/Buttons/WHITE8X8", line_color: [.62, .48, .25], line_dark: [.26, .19, .09], bevel: { light: 1.2, dark: .65 }, sheen_ends: .55 })
    property var arrow: ({ normal: "textures/DiabolicUI_D3_DropDown.tga", lit: "textures/DiabolicUI_D3_DropDownLit.tga", pushed: "textures/DiabolicUI_D3_DropDownPushed.tga" })

    // inside the field's line (its height less 2 each side)
    property real arrow_size: 18

    // from the field's right end
    property real arrow_inset: 2

    // its text's room left of it
    property real arrow_gap: 4

    // the square in its canvas
    property var arrow_texcoords: [0, 23/32, 0, 23/32]
}
