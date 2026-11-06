// The windows' editor (tools/editor.py runs it): a windows/*.qml file loaded
// as it is, its anchors live, so what's placed on a part follows it. Press a
// part to pick it (again: the one under it), drag it (it snaps to the others'
// edges, Alt: not), drag a handle to size it, drag a dot to another part's
// to place it there. Right-click: all that's under the cursor. What breaks the
// windows' rules (rules.js) is listed as it happens.
import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "rules.js" as Rules

ApplicationWindow {
    id: app
    objectName: "app"
    title: "Windows editor" + (changeCount ? " (" + changeCount + " to save)" : "")
    width: 1500
    height: 950
    visible: true

    palette {
        window: "#1c1917"; windowText: "#e8dcc8"; base: "#0e0c0b"; alternateBase: "#1c1917"; text: "#e8dcc8"
        button: "#2a241f"; buttonText: "#e8dcc8"; highlight: "#8a5f20"; highlightedText: "#fff2d8"
        placeholderText: "#978b78"; mid: "#3a322a"; dark: "#14110f"; light: "#3a322a"; midlight: "#2a241f"
    }

    readonly property var pointNames: ["TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT"]
    readonly property color gold: "#e0a640"
    readonly property color dim: "#978b78"
    readonly property string plain: "sans-serif" // (the names and numbers: as they're written, whatever the desktop's font)

    // A button for the top bar: says what it does and its key when hovered,
    // leaves the keyboard on the part picked.
    component Action: Button {
        property string tip
        focusPolicy: Qt.NoFocus
        ToolTip.visible: hovered && tip !== ""
        ToolTip.text: tip
        ToolTip.delay: 400
    }

    // A section of the right panel, closed until asked for.
    component Fold: ColumnLayout {
        id: fold
        property string title
        property bool open: false
        default property alias body: inner.data
        spacing: 4
        ItemDelegate {
            Layout.fillWidth: true
            padding: 4; leftPadding: 10
            text: (fold.open ? "▾  " : "▸  ") + fold.title
            onClicked: fold.open = !fold.open
        }
        ColumnLayout {
            id: inner
            visible: fold.open
            Layout.fillWidth: true
            Layout.leftMargin: 10; Layout.rightMargin: 10
        }
    }

    // ---- the window opened
    property var data: null          // its part of layout.json
    property string title_: ""
    property var parts: ({})         // its parts, by name
    property var items: ({})         // the QML items, by name (the window's and the Ghosts' too)
    property var names: []           // every name a part can be placed on
    property Item root: null
    property var edits: JSON.parse(backend.kept()) // what's not saved, by name: { window, place, size, pin }
    property var undoList: []
    property var redoList: []
    property int changeCount: Object.keys(edits).length
    property string picked: ""
    property Item pickedItem: picked ? items[picked] || null : null
    property var pickedEntry: null
    property string hovered: ""
    property Item hoveredItem: hovered && hovered !== picked ? items[hovered] || null : null
    property string status: backend.startMessage()
    property string leftText: backend.leftText()
    property var shown: ({ Frame: true, FontString: true, Texture: true })
    property var artBase: ({})
    property var views: []           // what it shows by its tabs: { key, label, rect, window, art }
    property int viewIndex: 0
    readonly property var view_: views[viewIndex] || null
    readonly property var viewRect: (view_ && view_.rect) || (data ? data.rect : null)

    Settings {
        id: settings
        property string lastWindow
        property alias listWidth: left.width_
    }

    function kindOf(kind) { return kind === "Texture" || kind === "FontString" ? kind : "Frame" }
    function roundTenth(v) { return Math.round(v * 10) / 10 }
    function fractionX(p) { return p.indexOf("LEFT") >= 0 ? 0 : p.indexOf("RIGHT") >= 0 ? 1 : .5 }
    function fractionY(p) { return p.indexOf("TOP") >= 0 ? 0 : p.indexOf("BOTTOM") >= 0 ? 1 : .5 } // (y down here)
    function lineX(p) { return p.indexOf("LEFT") >= 0 ? "left" : p.indexOf("RIGHT") >= 0 ? "right" : "horizontalCenter" }
    function lineY(p) { return p.indexOf("TOP") >= 0 ? "top" : p.indexOf("BOTTOM") >= 0 ? "bottom" : "verticalCenter" }
    function same(a, b) { return JSON.stringify(a === undefined ? null : a) === JSON.stringify(b === undefined ? null : b) }
    function fileEntry(name) {
        const p = parts[name]
        return { place: p.place, size: p.size, pin: p.pin || "" }
    }
    function entry(name) { return edits[name] || fileEntry(name) }

    function itemFor(name) { return items[name] }
    function editsText() { return JSON.stringify(edits) }
    function listCount() { return listModel.length }
    function problemsText() { return JSON.stringify(problems.map(p => p.text)) }

    // ---- the rules, for the tab shown, as parts move
    property var problems: []
    readonly property bool canCheck: !!(view_ && view_.frame && data && data.rules)
    Timer { id: ruleTimer; interval: 120; onTriggered: app.runRules() }
    function runRules() {
        if (!canCheck) { problems = []; return }
        const model = {}
        for (const n in parts) {
            const item = items[n]
            if (item && inView(n)) model[n] = Object.assign({}, parts[n], { left: item.x, top: item.y, right: item.x + item.width, bottom: item.y + item.height })
        }
        const f = viewRect
        problems = Rules.check({ parts: model, view: view_, rules: data.rules, unit: data.unit, origin: f ? [f[0], f[1] + f[3]] : null })
    }

    // ---- opening
    function openWindow(name) {
        if (root) root.destroy()
        root = null
        pick(""); hovered = ""; artModel = []
        data = JSON.parse(backend.window(name))
        title_ = name
        settings.lastWindow = name
        windowPick.currentIndex = windowPick.model.indexOf(name)
        parts = data.parts
        views = data.views || []
        viewIndex = 0
        const component = Qt.createComponent(data.url)
        if (component.status !== Component.Ready) {
            status = component.errorString()
            return
        }
        root = component.createObject(holder, { px: 1 / content.scale })
        root.px = Qt.binding(() => 1 / content.scale)
        root.outlines = Qt.binding(() => showOutlines.checked)
        const map = {}
        map[name] = root
        const children = root.children
        for (let i = 0; i < children.length; i++) map[children[i].name] = children[i]
        items = map
        names = Object.keys(map).sort()
        for (const n in edits) if (edits[n].window === name && items[n] && parts[n]) applyItem(n)
        applyShown()
        // the art follows its part from where the part is now
        const base = {}
        for (const n in map) base[n] = [map[n].x, map[n].y, map[n].width, map[n].height]
        artBase = base
        showView(0)
        fit(false)
    }

    // one of its tabs: only what shows in it (a part seen in no tab, in all)
    function showView(index) {
        artModel = []
        viewIndex = index
        artModel = (view_ ? view_.art : data.art) || []
        applyShown()
        if (picked && !(items[picked] && items[picked].visible)) pick("")
        listModelUpdate()
        ruleTimer.restart()
    }
    function inView(name) {
        const tabs = parts[name].tabs
        return !view_ || !tabs || tabs.indexOf(view_.key) >= 0
    }

    function reload() {
        status = backend.rescan()
        leftText = backend.leftText()
        openWindow(title_)
    }

    function applyShown() {
        for (const n in parts) if (items[n]) items[n].visible = shown[kindOf(parts[n].kind)] && inView(n)
    }

    // ---- a part's anchors, live
    readonly property var marginOf: ({ left: ["leftMargin", 1], right: ["rightMargin", -1], horizontalCenter: ["horizontalCenterOffset", 1],
        top: ["topMargin", -1], bottom: ["bottomMargin", 1], verticalCenter: ["verticalCenterOffset", -1] })

    function applyItem(name) {
        const item = items[name], e = entry(name)
        if (!item) return
        const anchors = item.anchors, target = e.place && items[e.place[1]]
        if (target) {
            const x = lineX(e.place[0]), y = lineY(e.place[0])
            for (const line of ["left", "right", "horizontalCenter", "top", "bottom", "verticalCenter"])
                if (line !== x && line !== y) { anchors[line] = undefined; anchors[marginOf[line][0]] = 0 }
            anchors[x] = target[lineX(e.place[2])]
            anchors[y] = target[lineY(e.place[2])]
            anchors[marginOf[x][0]] = e.place[3] * marginOf[x][1]
            anchors[marginOf[y][0]] = e.place[4] * marginOf[y][1]
        }
        if (e.size) { item.width = e.size[0]; item.height = e.size[1] }
        item.pin = e.pin
        item.changed = !!edits[name]
    }

    function remember() {
        undoList = undoList.concat(JSON.stringify(edits)).slice(-300)
        redoList = []
    }

    // a part's new place and size: what it's pinned by grows with what changed
    function change(name, place, size, quiet) {
        if (!quiet) remember()
        const was = entry(name), file = fileEntry(name)
        const placed = !same(place, was.place), sized = !same(size, was.size)
        const p = placed || was.pin === "all" || was.pin === "place"
        const s = sized || was.pin === "all" || was.pin === "size"
        const pin = p && s ? "all" : p ? "place" : s ? "size" : ""
        const next = { window: title_, place: place, size: size, pin: pin }
        const copy = Object.assign({}, edits)
        if (same(place, file.place) && same(size, file.size) && pin === file.pin) delete copy[name]
        else copy[name] = next
        edits = copy
        applyItem(name)
        if (name === picked) pickedEntry = entry(name)
        ruleTimer.restart()
        if (!quiet) changed()
    }

    function changed() {
        backend.keep(JSON.stringify(edits))
        listModelUpdate()
        linkUpdate()
    }

    function restore(text) {
        const before = edits
        edits = JSON.parse(text)
        for (const n in Object.assign({}, before, edits)) if (parts[n]) applyItem(n)
        if (picked) pickedEntry = entry(picked)
        ruleTimer.restart()
        changed()
    }
    function undo() {
        if (!undoList.length) return
        redoList = redoList.concat(JSON.stringify(edits))
        const last = undoList[undoList.length - 1]
        undoList = undoList.slice(0, -1)
        restore(last)
    }
    function redo() {
        if (!redoList.length) return
        undoList = undoList.concat(JSON.stringify(edits))
        const last = redoList[redoList.length - 1]
        redoList = redoList.slice(0, -1)
        restore(last)
    }

    function resetPart(name) {
        if (edits[name]) {
            remember()
            const copy = Object.assign({}, edits)
            delete copy[name]
            edits = copy
            applyItem(name)
        } else if (parts[name].pin) { // (pinned in its file: let go when saved)
            remember()
            const copy = Object.assign({}, edits)
            copy[name] = { window: title_, place: parts[name].place, size: parts[name].size, pin: "" }
            edits = copy
            applyItem(name)
            status = name + " follows the scan once saved."
        }
        if (name === picked) pickedEntry = entry(name)
        changed()
    }

    function save() {
        status = backend.save(JSON.stringify(edits))
        if (status.indexOf("Not saved") === 0) return
        leftText = backend.leftText()
        edits = {}
        undoList = []; redoList = []
        backend.keep("{}")
        const was = picked
        openWindow(title_)
        if (was && parts[was]) pick(was)
        status += "  Saved: /reload the game."
    }

    // ---- picking
    function pick(name) {
        picked = name
        pickedEntry = name ? entry(name) : null
        linkUpdate()
        const at = listModel.indexOf(name)
        if (at >= 0) list.positionViewAtIndex(at, ListView.Contain)
        const on = pickedEntry && pickedEntry.place && pickedEntry.place[1]
        for (const n in items) {
            if (items[n].picked !== undefined) {
                items[n].picked = n === name
                items[n].placedOn = n === on
                const e = parts[n] && entry(n)
                items[n].follower = !!(name && e && e.place && e.place[1] === name)
            }
        }
    }

    function partsAt(x, y) {
        const hits = []
        for (const n in parts) {
            const item = items[n]
            if (item && item.visible && x >= item.x && x <= item.x + item.width && y >= item.y && y <= item.y + item.height)
                hits.push(n)
        }
        hits.sort((a, b) => items[a].width * items[a].height - items[b].width * items[b].height)
        return hits
    }

    // the place keeping a part where it is, on another point or frame
    function anchored(name, point, rel, relPoint) {
        const item = items[name], target = items[rel]
        return [point, rel, relPoint,
            roundTenth(item.x + fractionX(point) * item.width - target.x - fractionX(relPoint) * target.width),
            roundTenth(-(item.y + fractionY(point) * item.height - target.y - fractionY(relPoint) * target.height))]
    }

    // is `p` (in the view) on the picked part's handles or dots?
    readonly property real handleGap: 24
    function overControls(p) {
        if (!pickedItem) return false
        const at = toRoot(p), item = pickedItem, near = 8 / content.scale, gap = handleGap / content.scale
        for (const fx of [0, .5, 1]) {
            for (const fy of [0, .5, 1]) {
                const x = item.x + fx * item.width, y = item.y + fy * item.height
                if (Math.hypot(at.x - x, at.y - y) < near) return true
                if (pickedEntry && pickedEntry.size && Math.hypot(at.x - x - (fx - .5) * gap, at.y - y - (fy - .5) * gap) < near) return true
            }
        }
        return false
    }

    // a place to change, for a part only sized so far
    function placeOf(name) {
        return entry(name).place || anchored(name, "TOPLEFT", title_, "TOPLEFT")
    }

    // ---- the view
    property bool fitLater: false
    function fit(animated) {
        let r = [0, 0, root ? root.width : 400, root ? root.height : 400]
        const w = (view_ && view_.window) || (data && data.window), f = viewRect
        if (w && f) {
            r = [w[0] - f[0], (f[1] + f[3]) - (w[1] + w[3]), w[2], w[3]]
        }
        const margin = 40
        fitLater = view.width <= 2 * margin || view.height <= 2 * margin // (opened before the view has its size)
        if (fitLater) return
        const z = Math.min((view.width - 2 * margin) / Math.max(r[2], 1), (view.height - 2 * margin) / Math.max(r[3], 1))
        const x = (view.width - r[2] * z) / 2 - r[0] * z, y = (view.height - r[3] * z) / 2 - r[1] * z
        if (animated) {
            fitX.to = x; fitY.to = y; fitZ.to = z
            fitAnimation.restart()
        } else {
            content.x = x; content.y = y; content.scale = z
        }
    }

    function zoomAt(px, py, factor) {
        const z = Math.max(.1, Math.min(16, content.scale * factor))
        content.x = px - (px - content.x) * z / content.scale
        content.y = py - (py - content.y) * z / content.scale
        content.scale = z
    }

    function toRoot(p) { return Qt.point((p.x - content.x) / content.scale, (p.y - content.y) / content.scale) }

    // ---- snapping: a moving part's lines to the others'
    property var guideX: null
    property var guideY: null
    function snapped(name, x, y, alone) {
        guideX = null; guideY = null
        const item = items[name]
        if (alone) return [x, y]
        const reach = 5 / content.scale
        let bestX = reach, bestY = reach, dx = 0, dy = 0
        const follows = {}
        for (const n in parts) { const e = entry(n); if (e.place && e.place[1] === name) follows[n] = true }
        const candidates = Object.keys(parts).filter(n => n !== name && !follows[n] && items[n] && items[n].visible)
        candidates.push(title_)
        for (const n of candidates) {
            const o = items[n]
            for (const a of [x, x + item.width / 2, x + item.width]) {
                for (const b of [o.x, o.x + o.width / 2, o.x + o.width]) {
                    if (Math.abs(b - a) < bestX) { bestX = Math.abs(b - a); dx = b - a; guideX = b }
                }
            }
            for (const a of [y, y + item.height / 2, y + item.height]) {
                for (const b of [o.y, o.y + o.height / 2, o.y + o.height]) {
                    if (Math.abs(b - a) < bestY) { bestY = Math.abs(b - a); dy = b - a; guideY = b }
                }
            }
        }
        return [x + dx, y + dy]
    }

    // ---- the line to what it's placed on
    property var linkA: null
    property var linkB: null
    function linkUpdate() {
        const e = picked && entry(picked)
        const target = e && e.place && items[e.place[1]]
        if (!target) { linkA = null; linkB = null; return }
        const item = items[picked]
        linkB = Qt.point(target.x + fractionX(e.place[2]) * target.width, target.y + fractionY(e.place[2]) * target.height)
        linkA = Qt.point(item.x + fractionX(e.place[0]) * item.width, item.y + fractionY(e.place[0]) * item.height)
    }

    // ---- the list
    property var listModel: []
    property var artModel: []
    function listModelUpdate() {
        const q = find.text.toLowerCase(), out = []
        for (const n of Object.keys(parts).sort()) {
            const text = parts[n].text || ""
            if (shown[kindOf(parts[n].kind)] && inView(n) && (!q || n.toLowerCase().indexOf(q) >= 0 || text.toLowerCase().indexOf(q) >= 0)) out.push(n)
        }
        listModel = out
    }

    function lineFor(name, e) {
        const parts_ = []
        if (e.pin === "") return name + " = follows the scan"
        if (e.pin !== "size") parts_.push('"' + e.place[0] + '", "' + e.place[1] + '", "' + e.place[2] + '", ' + e.place[3] + ", " + e.place[4])
        if (e.pin !== "place") parts_.push(e.size[0] + ", " + e.size[1])
        return name + " = { " + parts_.join(", ") + " }"
    }
    readonly property string changesText: {
        const out = []
        for (const n of Object.keys(edits).sort()) out.push(lineFor(n, edits[n]))
        return out.join("\n")
    }

    // ---- keys
    Shortcut { sequences: [StandardKey.Save]; onActivated: app.save() }
    Shortcut { sequences: [StandardKey.Undo]; onActivated: app.undo() }
    Shortcut { sequences: [StandardKey.Redo]; onActivated: app.redo() }
    Shortcut { sequence: "F"; onActivated: app.fit(true) }
    Shortcut { sequence: "Escape"; onActivated: app.pick("") }
    Shortcut { sequence: "Ctrl+F"; onActivated: find.forceActiveFocus() }

    function nudge(key, modifiers) {
        const across = key === Qt.Key_Left ? -1 : key === Qt.Key_Right ? 1 : 0
        const up = key === Qt.Key_Up ? 1 : key === Qt.Key_Down ? -1 : 0
        if (!picked || (!across && !up)) return false
        const step = modifiers & Qt.ShiftModifier ? 10 : 1, e = entry(picked)
        if (modifiers & Qt.ControlModifier) {
            if (e.size) change(picked, e.place, [Math.max(1, e.size[0] + across * step), Math.max(1, e.size[1] + up * step)])
        } else {
            const place = placeOf(picked).slice()
            place[3] = roundTenth(place[3] + across * step)
            place[4] = roundTenth(place[4] + up * step)
            change(picked, place, e.size)
        }
        return true
    }

    // ---- on top: the window, what's shown, the actions, the window's tabs (they wrap, none out of sight)
    header: Rectangle {
        color: app.palette.dark
        implicitHeight: bar.implicitHeight + 14
        Column {
            id: bar
            anchors.left: parent.left; anchors.right: parent.right; anchors.top: parent.top
            anchors.margins: 6
            spacing: 6
            RowLayout {
                width: parent.width
                ComboBox {
                    id: windowPick
                    objectName: "windowPick"
                    Layout.preferredWidth: 300
                    focusPolicy: Qt.NoFocus
                    font.family: app.plain
                    model: JSON.parse(backend.windows())
                    onActivated: app.openWindow(currentText)
                }
                Action {
                    id: showButton
                    objectName: "showButton"
                    text: "Show ▾"
                    tip: showPopup.opened ? "" : "What's drawn"
                    onClicked: showPopup.open()
                    Popup {
                        id: showPopup
                        objectName: "showPopup"
                        y: showButton.height + 4
                        ColumnLayout {
                            spacing: 2
                            Repeater {
                                model: [["Frame", "Frames"], ["FontString", "Texts"], ["Texture", "Textures"]]
                                CheckBox {
                                    required property var modelData
                                    text: modelData[1]
                                    checked: true
                                    onToggled: {
                                        app.shown[modelData[0]] = checked
                                        app.applyShown()
                                        app.listModelUpdate()
                                    }
                                }
                            }
                            CheckBox { id: showArt; text: "Art"; checked: true }
                            CheckBox { id: showOutlines; text: "Outlines"; checked: true }
                        }
                    }
                }
                Item { Layout.fillWidth: true }
                Action { objectName: "undoButton"; text: "Undo"; tip: "Ctrl+Z"; enabled: app.undoList.length > 0; onClicked: app.undo() }
                Action { objectName: "redoButton"; text: "Redo"; tip: "Ctrl+Shift+Z"; enabled: app.redoList.length > 0; onClicked: app.redo() }
                Action { text: "Fit"; tip: "See the whole window (F)"; onClicked: app.fit(true) }
                Action {
                    objectName: "saveButton"
                    text: app.changeCount ? "Save (" + app.changeCount + ")" : "Save"
                    tip: "Write the files, then /reload in game (Ctrl+S)"
                    highlighted: app.changeCount > 0
                    enabled: app.changeCount > 0
                    onClicked: app.save()
                }
            }
            Flow {
                id: tabs
                objectName: "tabs"
                width: parent.width
                visible: app.views.length > 1
                spacing: 4
                Repeater {
                    model: app.views
                    AbstractButton {
                        id: tab
                        required property var modelData
                        required property int index
                        readonly property bool current: index === app.viewIndex
                        text: modelData.label || "(no tab)"
                        focusPolicy: Qt.NoFocus // (the arrows stay on the part picked)
                        padding: 8; leftPadding: 16; rightPadding: 16
                        contentItem: Text {
                            text: tab.text
                            font.pixelSize: 15
                            font.bold: true
                            color: tab.current ? "#1c1917" : app.palette.text
                        }
                        background: Rectangle {
                            radius: 3
                            color: tab.current ? app.gold : tab.hovered ? "#4a3d30" : app.palette.button
                            border.color: tab.current ? app.gold : app.dim
                        }
                        onClicked: app.showView(index)
                    }
                }
            }
        }
        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 2; color: app.gold }
    }

    // ---- at the bottom: what can be done now, and what the last action said
    footer: Rectangle {
        color: app.palette.dark
        implicitHeight: bottomRow.implicitHeight + 8
        RowLayout {
            id: bottomRow
            anchors.left: parent.left; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 8; anchors.rightMargin: 8
            spacing: 16
            Label {
                objectName: "hint"
                Layout.fillWidth: true
                elide: Text.ElideRight
                color: app.dim
                font.family: app.plain
                text: app.picked
                    ? "Drag to move  ·  gold handles to size  ·  drag a dot onto another part to place it there  ·  arrows: 1, Shift: 10  ·  Alt: no snapping"
                    : "Press a part to pick it, again for the one under it  ·  wheel to zoom  ·  drag the empty space to pan  ·  right-click: all that's there"
            }
            Label {
                id: statusLine
                objectName: "status"
                Layout.maximumWidth: app.width / 2
                elide: Text.ElideRight
                font.family: app.plain
                color: app.status.indexOf("Not saved") === 0 ? "#e8703a" : app.palette.text
                text: app.status.replace(/\n/g, "  ")
                HoverHandler { id: statusHover }
                ToolTip.visible: statusHover.hovered && statusLine.truncated
                ToolTip.text: app.status
            }
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        // ---- the windows and their parts
        ColumnLayout {
            id: left
            property real width_: 300
            SplitView.preferredWidth: width_
            SplitView.minimumWidth: 200
            spacing: 6
            TextField {
                id: find
                Layout.fillWidth: true; Layout.margins: 8; Layout.bottomMargin: 0
                placeholderText: "Find a part…  (Ctrl+F)"
                font.family: app.plain
                onTextChanged: app.listModelUpdate()
            }
            ListView {
                id: list
                objectName: "list"
                Layout.fillWidth: true; Layout.fillHeight: true; Layout.margins: 8; Layout.topMargin: 0
                clip: true
                model: app.listModel
                highlightMoveDuration: 80
                currentIndex: app.listModel.indexOf(app.picked)
                highlight: Rectangle { color: "#3a2c18"; radius: 3 }
                ScrollBar.vertical: ScrollBar {}
                delegate: ItemDelegate {
                    required property string modelData
                    width: ListView.view.width
                    height: 24
                    padding: 2
                    leftPadding: 6
                    highlighted: false
                    contentItem: Text {
                        text: (app.edits[modelData] ? "● " : "") + (app.parts[modelData] && app.parts[modelData].pin ? "◆ " : "") + modelData
                        color: modelData === app.picked ? app.gold : app.palette.text
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        font.family: app.plain
                    }
                    ToolTip.visible: hovered
                    ToolTip.delay: 400
                    ToolTip.text: modelData + ((app.parts[modelData] || {}).text ? "\n“" + app.parts[modelData].text + "”" : "")
                    onClicked: app.pick(modelData)
                }
            }
        }

        // ---- the window
        Item {
            id: view
            objectName: "view"
            SplitView.fillWidth: true
            clip: true
            onWidthChanged: if (app.fitLater) app.fit(false)
            onHeightChanged: if (app.fitLater) app.fit(false)
            focus: true
            Keys.onPressed: event => {
                if (event.key === Qt.Key_Tab || event.key === Qt.Key_Backtab) {
                    const at = app.toRoot(hover.point.position), hits = app.partsAt(at.x, at.y)
                    if (hits.length) app.pick(hits[(hits.indexOf(app.picked) + (event.key === Qt.Key_Tab ? 1 : hits.length - 1)) % hits.length])
                    event.accepted = true
                } else event.accepted = app.nudge(event.key, event.modifiers)
            }

            Rectangle { anchors.fill: parent; color: "#0a0909" }

            Item {
                id: content
                objectName: "content"
                transformOrigin: Item.TopLeft
                Repeater {
                    visible: showArt.checked
                    model: app.artModel
                    Image {
                        required property var modelData
                        required property int index
                        readonly property var f: app.viewRect || [modelData.rect[0], modelData.rect[1] + modelData.rect[3], 0, 0]
                        readonly property Item owner: modelData.owner && app.parts[modelData.owner] ? app.items[modelData.owner] || null : null
                        readonly property var base: owner ? app.artBase[modelData.owner] : null
                        readonly property real ax: modelData.rect[0] - f[0]
                        readonly property real ay: (f[1] + f[3]) - (modelData.rect[1] + modelData.rect[3])
                        readonly property real sx: owner && base && base[2] ? owner.width / base[2] : 1
                        readonly property real sy: owner && base && base[3] ? owner.height / base[3] : 1
                        visible: showArt.checked
                        x: owner && base ? owner.x + (ax - base[0]) * sx : ax
                        y: owner && base ? owner.y + (ay - base[1]) * sy : ay
                        width: modelData.rect[2] * sx
                        height: modelData.rect[3] * sy
                        opacity: (modelData.alpha === undefined ? 1 : modelData.alpha) * (modelData.backdrop || !modelData.color ? 1 : modelData.color[3])
                        source: "image://art/" + app.data.generation + "/" + app.title_ + "/" + app.viewIndex + "/" + index
                        cache: false
                        smooth: true
                    }
                }
                Item { id: holder }

                // the hovered part
                Rectangle {
                    visible: !!app.hoveredItem
                    x: app.hoveredItem ? app.hoveredItem.x : 0; y: app.hoveredItem ? app.hoveredItem.y : 0
                    width: app.hoveredItem ? app.hoveredItem.width : 0; height: app.hoveredItem ? app.hoveredItem.height : 0
                    color: "#18ffffff"
                    border.color: "#ffffff"; border.width: 1 / content.scale
                }

                // the line to what it's placed on
                Rectangle {
                    visible: !!app.linkA && !drop.active
                    readonly property real dx: app.linkA && app.linkB ? app.linkB.x - app.linkA.x : 0
                    readonly property real dy: app.linkA && app.linkB ? app.linkB.y - app.linkA.y : 0
                    x: app.linkA ? app.linkA.x : 0; y: app.linkA ? app.linkA.y : 0
                    width: Math.sqrt(dx * dx + dy * dy); height: 2 / content.scale
                    transformOrigin: Item.TopLeft
                    rotation: Math.atan2(dy, dx) * 180 / Math.PI
                    color: "#e0c040"
                }
                Rectangle {
                    visible: !!app.linkB
                    width: 9 / content.scale; height: width; radius: width / 2
                    x: app.linkB ? app.linkB.x - width / 2 : 0; y: app.linkB ? app.linkB.y - width / 2 : 0
                    color: "transparent"; border.color: "#e0c040"; border.width: 2 / content.scale
                }

                // the guides it snaps to
                Rectangle {
                    visible: app.guideX !== null
                    x: app.guideX === null ? 0 : app.guideX; y: -5000
                    width: 1 / content.scale; height: 10000; color: "#40e0d0"
                }
                Rectangle {
                    visible: app.guideY !== null
                    y: app.guideY === null ? 0 : app.guideY; x: -5000
                    height: 1 / content.scale; width: 10000; color: "#40e0d0"
                }

                // the picked part: its handles, its dots
                Item {
                    id: selection
                    visible: !!app.pickedItem
                    x: app.pickedItem ? app.pickedItem.x : 0; y: app.pickedItem ? app.pickedItem.y : 0
                    width: app.pickedItem ? app.pickedItem.width : 0; height: app.pickedItem ? app.pickedItem.height : 0

                    Repeater {
                        model: [[0, 0], [.5, 0], [1, 0], [0, .5], [1, .5], [0, 1], [.5, 1], [1, 1]]
                        Rectangle {
                            required property var modelData
                            objectName: "handle" + modelData[0] + "_" + modelData[1]
                            visible: !!(app.pickedEntry && app.pickedEntry.size)
                            width: 9 / content.scale; height: width
                            // (outside the part: its dots are on it)
                            x: selection.width * modelData[0] + (modelData[0] - .5) * app.handleGap / content.scale - width / 2
                            y: selection.height * modelData[1] + (modelData[1] - .5) * app.handleGap / content.scale - height / 2
                            color: resize.active ? "#fff2d8" : app.gold
                            border.color: "#000"; border.width: 1 / content.scale
                            property var start: null
                            HoverHandler {
                                cursorShape: modelData[0] === .5 ? Qt.SizeVerCursor : modelData[1] === .5 ? Qt.SizeHorCursor
                                    : modelData[0] === modelData[1] ? Qt.SizeFDiagCursor : Qt.SizeBDiagCursor
                            }
                            DragHandler {
                                id: resize
                                target: null
                                grabPermissions: PointerHandler.CanTakeOverFromAnything // (not to be taken from)
                                onActiveChanged: {
                                    if (active) {
                                        app.remember()
                                        const e = app.entry(app.picked), item = app.items[app.picked]
                                        parent.start = { e: JSON.parse(JSON.stringify(e)), place: app.placeOf(app.picked).slice(),
                                            x0: centroid.scenePosition.x, y0: centroid.scenePosition.y, w: e.size[0], h: e.size[1] }
                                    } else app.changed()
                                }
                                onCentroidChanged: {
                                    if (!active || !parent.start) return
                                    const s = parent.start, fx = parent.modelData[0], fy = parent.modelData[1]
                                    const dx = (centroid.scenePosition.x - s.x0) / content.scale, dy = (centroid.scenePosition.y - s.y0) / content.scale
                                    const w = Math.max(1, Math.round(s.w + (fx === 1 ? dx : fx === 0 ? -dx : 0)))
                                    const h = Math.max(1, Math.round(s.h + (fy === 1 ? dy : fy === 0 ? -dy : 0)))
                                    // the side across from the handle stays: its point goes with what's between
                                    const px = app.fractionX(s.place[0]), py = app.fractionY(s.place[0])
                                    const place = s.place.slice()
                                    place[3] = app.roundTenth(s.place[3] + (fx === 0 ? (s.w - w) + px * (w - s.w) : fx === 1 ? px * (w - s.w) : 0))
                                    place[4] = app.roundTenth(s.place[4] - (fy === 0 ? (s.h - h) + py * (h - s.h) : fy === 1 ? py * (h - s.h) : 0))
                                    app.change(app.picked, place, [w, h], true)
                                    app.linkUpdate()
                                }
                            }
                        }
                    }
                    Repeater {
                        model: app.pointNames
                        Rectangle {
                            required property string modelData
                            objectName: "dot" + modelData
                            readonly property bool own: !!(app.pickedEntry && app.pickedEntry.place && app.pickedEntry.place[0] === modelData)
                            width: (own ? 11 : 7) / content.scale; height: width; radius: width / 2
                            x: selection.width * app.fractionX(modelData) - width / 2
                            y: selection.height * app.fractionY(modelData) - height / 2
                            color: own ? "#e0c040" : "#40e0d0"
                            border.color: "#000"; border.width: 1 / content.scale
                            ToolTip.visible: dotHover.hovered && !drop.active
                            ToolTip.text: modelData + ": drag it onto a part to place it there"
                            HoverHandler { id: dotHover; cursorShape: Qt.CrossCursor }
                            DragHandler {
                                target: null
                                grabPermissions: PointerHandler.CanTakeOverFromAnything
                                onActiveChanged: {
                                    if (active) drop.begin(parent.modelData)
                                    else drop.end()
                                }
                                onCentroidChanged: if (active) drop.moved(centroid.scenePosition)
                            }
                        }
                    }
                }

                // a dot dragged: the other parts' points to drop it on
                Item {
                    id: drop
                    objectName: "drop"
                    property bool active: false
                    property string point: ""
                    property var from: Qt.point(0, 0)
                    property var to: Qt.point(0, 0)
                    property string target: ""
                    property string targetPoint: ""
                    function begin(p) {
                        const item = app.items[app.picked]
                        point = p
                        from = Qt.point(item.x + app.fractionX(p) * item.width, item.y + app.fractionY(p) * item.height)
                        to = from
                        target = ""
                        active = true
                    }
                    function moved(scene) {
                        const local = content.mapFromItem(null, scene.x, scene.y)
                        to = local
                        let best = 14 / content.scale, name = "", at = ""
                        for (const n of app.names) {
                            const o = app.items[n]
                            if (n === app.picked || !o.visible) continue
                            for (const q of app.pointNames) {
                                const d = Math.hypot(o.x + app.fractionX(q) * o.width - local.x, o.y + app.fractionY(q) * o.height - local.y)
                                if (d < best) { best = d; name = n; at = q }
                            }
                        }
                        target = name; targetPoint = at
                    }
                    function end() {
                        active = false
                        const e = app.entry(app.picked)
                        const rel = target || (e.place ? e.place[1] : app.title_)
                        const relPoint = target ? targetPoint : (e.place ? e.place[2] : "TOPLEFT")
                        if (target || !e.place || point !== e.place[0]) {
                            app.change(app.picked, app.anchored(app.picked, point, rel, relPoint), e.size)
                            app.pick(app.picked)
                        }
                    }
                    Rectangle {
                        visible: drop.active
                        readonly property real dx: drop.to.x - drop.from.x
                        readonly property real dy: drop.to.y - drop.from.y
                        x: drop.from.x; y: drop.from.y
                        width: Math.sqrt(dx * dx + dy * dy); height: 2 / content.scale
                        transformOrigin: Item.TopLeft
                        rotation: Math.atan2(dy, dx) * 180 / Math.PI
                        color: "#40e0d0"
                    }
                    Rectangle {
                        visible: drop.active && drop.target !== ""
                        readonly property Item o: drop.target ? app.items[drop.target] || null : null
                        width: 13 / content.scale; height: width; radius: width / 2
                        x: o ? o.x + app.fractionX(drop.targetPoint) * o.width - width / 2 : 0
                        y: o ? o.y + app.fractionY(drop.targetPoint) * o.height - height / 2 : 0
                        color: "#40e0d0"
                    }
                }
            }

            ParallelAnimation {
                id: fitAnimation
                NumberAnimation { id: fitX; target: content; property: "x"; duration: 200; easing.type: Easing.OutCubic }
                NumberAnimation { id: fitY; target: content; property: "y"; duration: 200; easing.type: Easing.OutCubic }
                NumberAnimation { id: fitZ; target: content; property: "scale"; duration: 200; easing.type: Easing.OutCubic }
            }

            // ---- the mouse on the window
            HoverHandler {
                id: hover
                onPointChanged: {
                    if (!app.root) return
                    const at = app.toRoot(point.position), hits = app.partsAt(at.x, at.y)
                    app.hovered = hits.length ? hits[0] : ""
                    readout.text = Math.round(at.x) + ", " + Math.round(at.y) + "   " + Math.round(content.scale * 100) + "%   "
                        + hits.slice(0, 3).join(" › ")
                }
            }
            WheelHandler {
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                onWheel: event => app.zoomAt(point.position.x, point.position.y, Math.pow(1.0015, event.angleDelta.y))
            }
            PinchHandler {
                target: null
                property real last: 1
                onActiveChanged: last = 1
                onActiveScaleChanged: {
                    app.zoomAt(centroid.position.x, centroid.position.y, activeScale / last)
                    last = activeScale
                }
            }
            // the middle button always pans
            DragHandler {
                target: null
                acceptedButtons: Qt.MiddleButton
                property var start: null
                onActiveChanged: start = active ? Qt.point(content.x - centroid.position.x, content.y - centroid.position.y) : null
                onCentroidChanged: if (active && start) { content.x = start.x + centroid.position.x; content.y = start.y + centroid.position.y }
            }
            // press: a part to pick; a part dragged moves; nothing dragged pans
            TapHandler {
                id: tap
                acceptedButtons: Qt.LeftButton
                property var lastAt: null
                onPressedChanged: if (pressed) view.forceActiveFocus()
                onTapped: (point) => {
                    if (app.overControls(point.position)) return
                    const at = app.toRoot(point.position), hits = app.partsAt(at.x, at.y)
                    const again = lastAt && Math.hypot(lastAt.x - point.position.x, lastAt.y - point.position.y) <= 3
                    lastAt = point.position
                    if (!hits.length) { app.pick(""); return }
                    app.pick(again ? hits[(hits.indexOf(app.picked) + 1) % hits.length] : hits[0])
                }
            }
            DragHandler {
                id: mover
                target: null
                grabPermissions: PointerHandler.CanTakeOverFromItems // (the handles and dots come first)
                acceptedButtons: Qt.LeftButton
                property var start: null
                onActiveChanged: {
                    if (!active) {
                        if (start && start.move) app.changed()
                        app.guideX = null; app.guideY = null
                        start = null
                        return
                    }
                    const press = centroid.pressPosition, at = app.toRoot(press), hits = app.partsAt(at.x, at.y)
                    if (app.overControls(press)) { start = null; return }
                    let name = hits.indexOf(app.picked) >= 0 ? app.picked : hits[0]
                    if (!name) { start = { pan: true, x: content.x - press.x, y: content.y - press.y }; return }
                    if (name !== app.picked) app.pick(name)
                    app.remember()
                    const item = app.items[name], e = app.entry(name)
                    start = { move: true, name: name, press: press, place: app.placeOf(name).slice(), size: e.size,
                        x: item.x, y: item.y }
                }
                onCentroidChanged: {
                    if (!active || !start) return
                    const p = centroid.position
                    if (start.pan) { content.x = start.x + p.x; content.y = start.y + p.y; return }
                    const dx = (p.x - start.press.x) / content.scale, dy = (p.y - start.press.y) / content.scale
                    const to = app.snapped(start.name, Math.round(start.x + dx), Math.round(start.y + dy), centroid.modifiers & Qt.AltModifier)
                    const place = start.place.slice()
                    place[3] = app.roundTenth(start.place[3] + to[0] - start.x)
                    place[4] = app.roundTenth(start.place[4] - (to[1] - start.y))
                    app.change(start.name, place, start.size, true)
                    app.linkUpdate()
                }
            }
            TapHandler {
                acceptedButtons: Qt.RightButton
                onTapped: (point) => {
                    const at = app.toRoot(point.position)
                    menu.hits = app.partsAt(at.x, at.y).slice(0, 15)
                    menu.popup()
                }
            }

            Menu {
                id: menu
                property var hits: []
                Instantiator {
                    model: menu.hits
                    MenuItem {
                        required property string modelData
                        text: modelData
                        checkable: true
                        checked: modelData === app.picked
                        onTriggered: app.pick(modelData)
                    }
                    onObjectAdded: (index, object) => menu.insertItem(index, object)
                    onObjectRemoved: (index, object) => menu.removeItem(object)
                }
                MenuSeparator {}
                MenuItem {
                    text: "Pick what it's placed on"
                    enabled: !!(app.pickedEntry && app.pickedEntry.place && app.parts[app.pickedEntry.place[1]])
                    onTriggered: app.pick(app.pickedEntry.place[1])
                }
                MenuItem { text: "Reset this part"; enabled: !!app.picked; onTriggered: app.resetPart(app.picked) }
                MenuItem { text: "Fit the window"; onTriggered: app.fit(true) }
            }

            Label {
                id: readout
                anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: parent.bottom
                padding: 4; leftPadding: 8
                elide: Text.ElideRight
                color: app.dim
                background: Rectangle { color: "#d814110f" }
            }
        }

        // ---- the part, and what's to save
        ScrollView {
            id: side
            SplitView.preferredWidth: 340
            SplitView.minimumWidth: 280
            contentWidth: availableWidth
            ColumnLayout {
                width: side.availableWidth
                spacing: 6
                Label { text: "PART"; color: app.dim; font.pixelSize: 11; Layout.topMargin: 8; Layout.leftMargin: 10 }
                Label {
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    text: app.picked || "None picked: press one in the window or the list."
                    color: app.picked ? app.gold : app.dim
                    wrapMode: app.picked ? Text.WrapAnywhere : Text.Wrap
                    font.family: app.plain
                }
                Label {
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    visible: !!app.picked
                    color: app.dim
                    wrapMode: Text.Wrap
                    text: {
                        const p = app.parts[app.picked]
                        if (!p) return ""
                        const pin = app.pickedEntry && app.pickedEntry.pin
                        return (p.kind || "?") + (p.text ? " · “" + p.text + "”" : "") + (p.parent && p.parent !== "?" ? "\nin " + p.parent : "")
                            + "\n" + (pin === "place" ? "◆ Its place is pinned" : pin === "size" ? "◆ Its size is pinned"
                                : pin ? "◆ Pinned: stays as set" : "Not pinned: follows the game's scan")
                    }
                }
                GridLayout {
                    id: fields
                    objectName: "fields"
                    visible: !!(app.picked && app.pickedEntry)
                    columns: 2
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    readonly property var place: app.pickedEntry ? app.pickedEntry.place : null
                    readonly property var size: app.pickedEntry ? app.pickedEntry.size : null
                    function anchor(point, rel, relPoint) {
                        if (app.items[rel]) {
                            app.change(app.picked, app.anchored(app.picked, point, rel, relPoint), app.entry(app.picked).size)
                            app.pick(app.picked)
                        }
                    }
                    function numbers() {
                        const e = app.entry(app.picked), place = app.placeOf(app.picked).slice()
                        place[3] = fx.value / 10; place[4] = fy.value / 10
                        app.change(app.picked, place, e.size ? [fw.value / 10, fh.value / 10] : e.size)
                    }

                    Label { text: "Point"; color: app.dim }
                    ComboBox {
                        Layout.fillWidth: true
                        model: app.pointNames
                        currentIndex: fields.place ? model.indexOf(fields.place[0]) : -1
                        onActivated: fields.anchor(currentText, fields.place ? fields.place[1] : app.title_, fields.place ? fields.place[2] : "TOPLEFT")
                    }
                    Label { text: "On"; color: app.dim }
                    ComboBox {
                        Layout.fillWidth: true
                        editable: true
                        font.family: app.plain
                        model: app.names
                        currentIndex: fields.place ? model.indexOf(fields.place[1]) : -1
                        onActivated: fields.anchor(fields.place ? fields.place[0] : "TOPLEFT", currentText, fields.place ? fields.place[2] : "TOPLEFT")
                        onAccepted: fields.anchor(fields.place ? fields.place[0] : "TOPLEFT", editText, fields.place ? fields.place[2] : "TOPLEFT")
                    }
                    Label { text: "At"; color: app.dim }
                    ComboBox {
                        Layout.fillWidth: true
                        model: app.pointNames
                        currentIndex: fields.place ? model.indexOf(fields.place[2]) : -1
                        onActivated: fields.anchor(fields.place ? fields.place[0] : "TOPLEFT", fields.place ? fields.place[1] : app.title_, currentText)
                    }
                    Label { text: "X"; color: app.dim }
                    NumberBox { id: fx; number: fields.place ? fields.place[3] : 0; onEdited: fields.numbers() }
                    Label { text: "Y"; color: app.dim }
                    NumberBox { id: fy; number: fields.place ? fields.place[4] : 0; onEdited: fields.numbers() }
                    Label { text: "Width"; color: app.dim; visible: !!fields.size }
                    NumberBox { id: fw; visible: !!fields.size; number: fields.size ? fields.size[0] : 0; onEdited: fields.numbers() }
                    Label { text: "Height"; color: app.dim; visible: !!fields.size }
                    NumberBox { id: fh; visible: !!fields.size; number: fields.size ? fields.size[1] : 0; onEdited: fields.numbers() }
                }
                Button {
                    Layout.leftMargin: 10
                    text: "Reset this part"
                    visible: !!app.picked
                    onClicked: app.resetPart(app.picked)
                }

                Label {
                    objectName: "rulesTitle"
                    text: "RULES" + (app.problems.length ? " (" + app.problems.length + ")" : "")
                    color: app.problems.length ? "#e8703a" : app.dim
                    font.pixelSize: 11; Layout.topMargin: 10; Layout.leftMargin: 10
                }
                Label {
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    visible: !app.problems.length
                    color: app.dim
                    wrapMode: Text.Wrap
                    text: app.canCheck ? "Nothing breaks them." : "Needs a new scan: /dui layout all, then /reload."
                }
                Repeater {
                    model: app.problems
                    ItemDelegate {
                        required property var modelData
                        Layout.fillWidth: true; Layout.leftMargin: 6; Layout.rightMargin: 6
                        padding: 3; leftPadding: 4; rightPadding: 4
                        contentItem: Text {
                            text: modelData.text
                            color: "#e8c0a0"
                            wrapMode: Text.Wrap
                            font.pixelSize: 12
                            font.family: app.plain
                        }
                        onClicked: if (modelData.parts.length && app.items[modelData.parts[0]]) app.pick(modelData.parts[0])
                    }
                }

                Fold {
                    objectName: "stillToScanFold"
                    title: "Still to scan"
                    visible: app.leftText !== ""
                    Layout.fillWidth: true; Layout.topMargin: 6
                    Label {
                        objectName: "stillToScan"
                        Layout.fillWidth: true
                        text: app.leftText
                        color: app.dim
                        wrapMode: Text.Wrap
                        font.pixelSize: 12
                        font.family: app.plain
                    }
                }

                Fold {
                    objectName: "toSaveFold"
                    title: "To save (" + app.changeCount + ")"
                    visible: app.changeCount > 0
                    Layout.fillWidth: true; Layout.bottomMargin: 10
                    TextArea {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 170
                        readOnly: true
                        wrapMode: TextEdit.WrapAnywhere
                        font.family: "monospace"; font.pixelSize: 11
                        text: app.changesText
                    }
                }
            }
        }
    }

    Connections {
        target: backend
        function onScanned() {
            if (app.changeCount) { app.status = "A new scan: Save, and it's read."; return }
            app.reload()
        }
    }

    Component.onCompleted: {
        const list_ = windowPick.model
        if (list_.length) Qt.callLater(() => openWindow(list_.indexOf(settings.lastWindow) >= 0 ? settings.lastWindow : list_[0]))
    }
}
