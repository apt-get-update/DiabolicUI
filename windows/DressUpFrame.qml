// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: dressUpFrame
    name: "DressUpFrame"
    width: 400
    height: 400

    // its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
    Part {
        id: dressUpFrameDescriptionText
        name: "DressUpFrameDescriptionText"
        pin: "place"
        anchors.horizontalCenter: dressUpFrame.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: dressUpFrame.top
        anchors.verticalCenterOffset: 50
        width: 162
        height: 12
    }

}
