// The tabs in a row under the band.
// Shared by every window: settings/components.lua is written from this by
// tools/positions.lua (or the editor's Components). One line per property.
import QtQml

QtObject {
    objectName: "tab"

    // of its art, in a tab of Blizzard's height
    property real height: 26
    property string font: "DiabolicFont_HeaderRegular12"

    // from the art's middle (Blizzard's sits lower); Exocet's capitals sit low in their line
    property real text_offset: 1
}
