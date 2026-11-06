// A frame that's in no part of this window but has parts placed on it: where it
// stands, with them in it (written by tools/positions.lua; not a part).
import QtQuick

Item {
    property string name
    property real px: parent && parent.px !== undefined ? parent.px : 1
    property bool outlines: parent && parent.outlines !== undefined ? parent.outlines : true
}
