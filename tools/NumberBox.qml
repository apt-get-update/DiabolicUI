// A number to tenths: the arrows and the wheel step it, or type it.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

SpinBox {
    id: box
    Layout.fillWidth: true
    from: -999990; to: 999990
    stepSize: 10
    editable: true
    wheelEnabled: true
    textFromValue: (v) => String(v / 10)
    valueFromText: (t) => Math.round(Number(t) * 10)
    validator: DoubleValidator { decimals: 1; notation: DoubleValidator.StandardNotation }
    // (in whole units outside)
    property real number: 0
    value: Math.round(number * 10)
    signal edited(real number)
    onValueModified: edited(value / 10)
}
