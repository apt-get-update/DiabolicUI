// A number to tenths: the arrows and the wheel step it, or type it.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

SpinBox {
    id: box
    Layout.fillWidth: true
    // (in whole units outside; `factor`: how finely inside)
    property int factor: 10
    from: -99999 * factor; to: 99999 * factor
    stepSize: factor
    editable: true
    wheelEnabled: true
    textFromValue: (v) => String(v / factor)
    valueFromText: (t) => Math.round(Number(t) * factor)
    validator: DoubleValidator { decimals: box.factor > 10 ? 3 : 1; notation: DoubleValidator.StandardNotation }
    property real number: 0
    value: Math.round(number * factor)
    signal edited(real number)
    onValueModified: edited(value / factor)
}
