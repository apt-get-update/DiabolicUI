// The generic window, what every styled window inherits: a stone window in an
// iron frame, its band, its title plate, its foot, the rules of its layout.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: ""

    property var backdrop: ({ bgFile: "textures/DiabolicUI_Tooltip_Background.tga", edgeFile: "textures/DiabolicUI_Tooltip_Border.tga", edgeSize: 32, tile: true, tileSize: 256, insets: { left: 23, right: 23, top: 23, bottom: 23 } })
    // the stone toward red
    property var backdrop_color: [.8, .65, .65, 1]
    property var backdrop_border_color: [1, 1, 1, 1]

    // Diablo III's title bar: a red stained-glass band along the top, in tiles
    // (its stash window's, mirrored to repeat); canvas: its art's shape
    property var band: ({ texture: "textures/DiabolicUI_D3_Band.tga", canvas: [364, 104] })

    // every text in a band: the chat's Arial Narrow, a label in the title's gold,
    // what's typed or chosen in white, a button's text as a label (a list's All)
    property var band_text: ({ label_font: "DiabolicFont_Narrow14", label: [.86, .76, .6], value_font: "DiabolicFont_Narrow14", value: [1, 1, 1], label_button_font: "DiabolicFont_Narrow14Gold" })

    // the title on the window's top edge: Diablo III's skills pane's plate (its art
    // 512 x 70 in its 512 x 128 file), y its middle from the window's top, text_width
    // its inlay. Longer titles: wider up to max_width (cuts: its pieces in its file's
    // pixels, the 2nd and 4th stretched), short of the sides by side_room (the X's
    // socket). text_offset: Exocet's capitals sit low. gem: a window's icon (the spec,
    // the profession) in its left cross, in the minimap's spiked bronze ring
    property var title_plate: ({ texture: "textures/DiabolicUI_D3_TitlePlate.tga", rows: 70/128, width: 300, height: 41, y: -15, text_width: 200, file_width: 512, cuts: [96, 140, 376, 420], max_width: 440, side_room: 62, text_offset: 1, font: "DiabolicFont_HeaderRegular14", color: [.86, .76, .6], gem: { ring: "textures/DiabolicUI_D3_GemRing.tga", size: 40, x: 35, y: 0, glass: .66, glass_offset: [0, 0] } })
    property string title_font: "DiabolicFont_HeaderRegular18Title"

    // a window's foot (its rough stone, inside its iron frame): how high for a row of
    // buttons, its top over theirs (what's over the foot is placed from that)
    property real footer_height: 35
    property real footer_margin: 6

    // the iron bar along the foot's top: the frame's left edge (its file's first 32px)
    // turned; cut, the part of it drawn, bar, the bar itself (from the window's edge)
    property var footer_rail: ({ cut: [12, 28], bar: [15, 24] })

    // the rules every window's layout follows:
    // button_gap, between buttons on a row (those closer narrowed, as wide in all);
    // band_edge, the band's first control from its left end; band_gap, between its
    // controls; band_right_edge, its last on the right from its right end (short of
    // the X's socket); content_gap, the least room over the content and under it;
    // uneven, the most the room over it may differ from the room under it
    property var layout: ({ button_gap: 6, band_edge: 10, band_gap: 12, band_right_edge: 48, content_gap: 6, uneven: 8 })
}
