// The windows' tabs as Diablo III's hero banners hanging from the window's foot: dark
// cloth in gold trim with an emblem, the chosen one red and hanging lower, the
// name on hover (built from Diablo III's banner art: its Knight003 shape).
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "banner"

    // white, its folds kept: dyed here
    property string cloth: "textures/DiabolicUI_D3_BannerCloth.tga"
    property string trim: "textures/DiabolicUI_D3_BannerTrim.tga"

    // white, dyed here
    property string sigils: "textures/DiabolicUI_D3_BannerSigils.tga"

    // the emblems in the atlas, 64 square, 8 to a row (Diablo III's names)
    property var sigil_names: ["hoodedface", "WolfHead", "shield", "hellforge", "stein", "openbook", "owl", "horse", "crow", "TwoHeadHawk", "lion", "AllSeeing", "time", "star", "sword", "flames", "tree", "wizardhat", "sun", "scarab", "fleur", "skullcrossbones", "Clover", "orbLight", "summoningrune", "pentagram", "monkRune", "gryphon", "khalimswill", "leoric_crown", "swan", "Demon"]
    property real sigil_columns: 8
    property real sigil_rows: 4

    // a tab with no emblem of its own (an addon's)
    property string fallback: "star"

    // the banner: its art fills its 128 x 256 canvas
    property real width: 52
    property real height: 104

    // its top (the rod's notches) not drawn: it starts under the rail
    property real tuck: 22

    // the chosen one that much longer
    property real drop: 12
    property real gap: 6

    // the first one's left, from the window's (Blizzard's tabs start at the left too)
    property real left: 28

    // the rail's shadow down each one's top
    property real shadow: 14
    property real shadow_alpha: .8

    // the iron rail they hang from, along the window's foot: Diablo III's dark plate
    // with its gold ends, bronze edged. up: its top under the window's iron (15 to 24
    // in from its edge); overhang: past the first and last banners; cap: each end, of
    // its file's width
    property var rail: ({ texture: "textures/DiabolicUI_D3_BannerRail.tga", height: 18, up: 19, overhang: 10, cap: 26/512, cap_width: 9, rows: 1 })

    // the bronze clasps holding each to the rail, over its trim's sides: x their
    // middles from the banner's left, y over the rail's bottom, a little darker
    property var clasp: ({ texture: "textures/DiabolicUI_D3_BannerClasp.tga", width: 8, height: 20, x: [4, 48], y: 2, color: [.85, .85, .85] })
    property real sigil_size: 30

    // the emblem's middle, from the banner's top: in its cloth
    property real sigil_y: -38

    // a WoW icon in its place, round
    property real icon_size: 26

    // near black, as the window's stone
    property var cloth_color: [.13, .11, .1]

    // deep red
    property var chosen_color: [.45, .07, .05]
    property var sigil_color: [.72, .6, .4]
    property var chosen_sigil_color: [1, .85, .55]

    // the cloth lit under the mouse
    property real lit_alpha: .25

    // warm (white turns the dark cloth grey)
    property var lit_color: [.9, .3, .18]

    // its text: the name shows on hover instead
    property string name_font: "DiabolicFont_Hidden"
}
