// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "DressUpFrame"
    width: 400
    height: 400

    // its "CTRL-Left Click..." under the band, over the picture (Blizzard's hangs from the title)
    Part {
        name: "DressUpFrameDescriptionText"
        pin: "place"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -11
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 50
        width: 162
        height: 12
    }
}
