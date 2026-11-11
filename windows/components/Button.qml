// The buttons. Cut in three (left, middle, right, in canvas pixels), so their
// ends keep their shape at any width: art is the visible part of the canvas,
// scaled to the button's height.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: ""

    // Diablo III's flat buttons in iron edges (categories, tabs): red, lit (chosen,
    // under the mouse), dark (the tabs not chosen); its gold corners at the ends
    property var rect_button: ({ texture: { normal: "textures/DiabolicUI_D3_Button.tga", lit: "textures/DiabolicUI_D3_ButtonLit.tga", dark: "textures/DiabolicUI_D3_ButtonDark.tga" }, canvas: [512, 64], art: [0, 1, 457, 63], left: [0, 48], middle: [48, 409], right: [409, 457] })

    // the action buttons' border, made for 44 wide ones (the ammo slot's, the spellbook's)
    property var button_border: ({ texture: "textures/DiabolicUI_Button_44x44_Border.tga", size: [64, 64], offset: [-10, 10] })
    property string button_font: "DiabolicFont_HeaderRegular12"

    // Blizzard's buttons whose text is too wide in it get these, in turn
    property string button_font_small: "DiabolicFont_HeaderRegular10"
    property string button_font_narrow: "DiabolicFont_SansBold10"

    // kept free at each end
    property real button_text_margin: 6

    // an enabled button's text (its font's own)
    property var button_text_color: [1, 1, 1]

    // a disabled button's text
    property var button_disabled_color: [.5, .47, .44]
}
