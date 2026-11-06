// The windows' editor (tools/editor.py runs it): a windows/*.qml file loaded
// as it is, its anchors live, so what's placed on a part follows it. Press a
// part to pick it (again: the one under it), drag it (it snaps to the others'
// edges, Alt: not), drag a handle to size it, drag a dot to another part's
// to place it there. Right-click: all that's under the cursor. What breaks the
// windows' rules (rules.js) is listed as it happens.
import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
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
    property var edits: JSON.parse(backend.kept()) // what's not saved, by name: { window, place, size, pin, second }; "@rows": by window, by row
    property var undoList: []
    property var redoList: []
    property int changeCount: {
        const shared = edits["@components"] || {}
        const rows = edits["@rows"] || {}
        let count = Object.keys(edits).length - (edits["@components"] ? 1 : 0) - (edits["@rows"] ? 1 : 0)
        for (const name in shared) count += Object.keys(shared[name]).length
        for (const title in rows) count += Object.keys(rows[title]).length
        return count
    }
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
        property alias outlines: showOutlines.checked
        property alias anchorsOpen: fields.open
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
        return { place: p.place, size: p.size, pin: p.pin || "", second: p.second }
    }
    function entry(name) { return rowPlaced[name] || edits[name] || fileEntry(name) }

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
            if (item && inView(n) && (!parts[n].current || parts[n].current[view_.key])) model[n] = Object.assign({}, parts[n], { left: item.x, top: item.y, right: item.x + item.width, bottom: item.y + item.height })
        }
        const f = viewRect
        problems = Rules.check({ parts: model, view: view_, rules: data.rules, unit: data.unit, origin: f ? [f[0], f[1] + f[3]] : null })
    }

    // ---- opening
    function openWindow(name) {
        if (root) root.destroy()
        root = null
        pick(""); hovered = ""; artModel = []
        rowPlaced = {}
        unfolded = {}
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
        const rowNames = (data.rows || []).map(r => r.name)
        names = Object.keys(map).filter(n => rowNames.indexOf(n) < 0).sort()
        for (const n in edits) if (edits[n].window === name && items[n] && parts[n]) applyItem(n)
        rowsUpdate()
        // (drawn smaller than in the game: a box as wide as its text, the text in its middle)
        for (const n in parts) if (items[n] && parts[n].justify)
            items[n].justify = Math.abs(items[n].width - (parts[n].textWidth || 0)) < 1 ? "CENTER" : parts[n].justify
        applyShown()
        // the art follows its part from where the part is now
        const base = {}
        for (const n in map) base[n] = [map[n].x, map[n].y, map[n].width, map[n].height]
        artBase = base
        applyComponents()
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
        components = JSON.parse(backend.components())
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
            const x2 = e.second ? lineX(e.second[0]) : x, y2 = e.second ? lineY(e.second[0]) : y // (stretched: its other side)
            for (const line of ["left", "right", "horizontalCenter", "top", "bottom", "verticalCenter"])
                if (line !== x && line !== y && line !== x2 && line !== y2) { anchors[line] = undefined; anchors[marginOf[line][0]] = 0 }
            anchors[x] = target[lineX(e.place[2])]
            anchors[y] = target[lineY(e.place[2])]
            anchors[marginOf[x][0]] = e.place[3] * marginOf[x][1]
            anchors[marginOf[y][0]] = e.place[4] * marginOf[y][1]
            if (x2 !== x) { anchors[x2] = target[lineX(e.second[1])]; anchors[marginOf[x2][0]] = e.second[2] * marginOf[x2][1] }
            if (y2 !== y) { anchors[y2] = target[lineY(e.second[1])]; anchors[marginOf[y2][0]] = e.second[3] * marginOf[y2][1] }
        }
        if (e.size) { item.width = e.size[0]; item.height = e.size[1] }
        item.pin = e.pin
        item.changed = !!edits[name] || !!rowPlaced[name]
    }

    function remember() {
        undoList = undoList.concat(JSON.stringify(edits)).slice(-300)
        redoList = []
    }

    // a part's new place and size: what it's pinned by grows with what changed.
    // `second`: its other side, stretched (null: no more; left out: as it was).
    function change(name, place, size, quiet, second) {
        if (rowOf(name)) {
            status = name + " is in the row " + parts[name].inRow + ": change the row, or drag it."
            return
        }
        if (!quiet) remember()
        const was = entry(name), file = fileEntry(name)
        const other = second === undefined ? was.second : second
        const placed = !same(place, was.place) || !same(other, was.second), sized = !same(size, was.size)
        const p = placed || was.pin === "all" || was.pin === "place"
        const s = sized || was.pin === "all" || was.pin === "size" || (was.second && !other) // (no sides to size it any more)
        const pin = p && s ? "all" : p ? "place" : s ? "size" : ""
        const next = { window: title_, place: place, size: size, pin: pin }
        if (other) next.second = other
        const copy = Object.assign({}, edits)
        const kept = !(same(place, file.place) && same(size, file.size) && pin === file.pin && same(other, file.second))
        if (kept) copy[name] = next
        else delete copy[name]
        edits = copy
        applyItem(name)
        if (kept && other) { // (its sides size it: what it comes to, for the fields)
            const item = items[name], sized_ = Object.assign({}, edits)
            sized_[name] = Object.assign({}, next, { size: [roundTenth(item.width), roundTenth(item.height)] })
            edits = sized_
        }
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
        rowsUpdate()
        applyComponents()
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

    // ---- the rows: as told here, worked out as tools/positions.lua does when saved
    property var rowPlaced: ({})     // their parts, by name, while a row's changed: { place, size, pin }
    readonly property var pickedRow: {
        const row = picked && parts[picked] ? rowOf(picked) : null
        return row ? rowNow(row) : null
    }
    readonly property bool pickedHeld: !!pickedRow || !!(pickedEntry && pickedEntry.second) // (not dragged, no handles: its row or its sides place it)
    function rowOf(name) {
        const row = parts[name] && parts[name].inRow
        return row ? (data.rows || []).filter(r => r.name === row)[0] || null : null
    }
    function rowEdit(row) {
        const rows = edits["@rows"], mine = rows && rows[title_]
        return (mine && mine[row.name]) || null
    }
    function rowNow(row) {
        const edit = rowEdit(row)
        return edit ? Object.assign({}, row, edit, { spacing: edit.spacing }) : row
    }
    // { [part]: { place, size, pin } } for a row (ResolveRow's, tools/positions.lua)
    function rowLayout(row) {
        const on = items[row.on], out = {}
        if (!on) return out
        const names = row.parts, count = names.length, room = on.width - row.left - row.right
        const has = row.spacing !== undefined && row.spacing !== null
        let gap = has ? row.spacing : row.gap, first = row.left
        const sizeOf = n => parts[n].size || (parts[n].rect ? [parts[n].rect[2], parts[n].rect[3]] : [items[n].width, items[n].height])
        const widths = names.map(n => sizeOf(n)[0])
        const shared = room - gap * (count - 1)
        let sum = widths.reduce((a, b) => a + b, 0)
        if (row.fit === "fill") {
            const texted = n => parts[n].textWidth !== undefined && parts[n].textWidth !== null
            let sharing = names.filter(texted).length
            const all = !sharing
            if (all) sharing = count
            names.forEach((n, i) => { if (texted(n)) widths[i] = parts[n].textWidth })
            sum = widths.reduce((a, b) => a + b, 0)
            const extra = (shared - sum) / sharing
            let last = count - 1
            names.forEach((n, i) => {
                if (all || texted(n)) { widths[i] = roundTenth(widths[i] + extra); last = i }
                else widths[i] = roundTenth(widths[i])
            })
            sum = widths.reduce((a, b) => a + b, 0)
            widths[last] = roundTenth(widths[last] + shared - sum)
        } else if (row.fit === "equal") {
            names.forEach((n, i) => { widths[i] = roundTenth(shared / count) })
            sum = widths.reduce((a, b) => a + b, 0)
            widths[count - 1] = roundTenth(widths[count - 1] + shared - sum)
        } else if (row.fit === "center") {
            first = row.left + (room - sum - gap * (count - 1)) / 2
        } else if (count > 1) {
            gap = (room - sum) / (count - 1)
        } else {
            first = row.left + (room - sum) / 2
        }
        const sized = row.fit === "fill" || row.fit === "equal"
        names.forEach((n, i) => {
            const place = i === 0 ? [row.point, row.on, row.relPoint, roundTenth(first), row.y] : ["LEFT", names[i - 1], "RIGHT", roundTenth(gap), 0]
            out[n] = { place: place, size: [widths[i], sizeOf(n)[1]], pin: sized || parts[n].pin === "all" ? "all" : "place" }
        })
        return out
    }
    // the parts of the rows changed where they're told, those of the others back
    function rowsUpdate() {
        const placed = {}
        for (const row of (data && data.rows) || []) if (rowEdit(row)) Object.assign(placed, rowLayout(rowNow(row)))
        const before = rowPlaced
        rowPlaced = placed
        for (const n in Object.assign({}, before, placed)) if (items[n]) applyItem(n)
    }
    // `changes` (fit, spacing, left, right, y) to a row. Quiet: while dragged.
    function setRow(row, changes, quiet) {
        if (!quiet) remember()
        const file = (data.rows || []).filter(r => r.name === row.name)[0]
        const next = Object.assign({}, rowNow(row), changes)
        const edit = { fit: next.fit, left: next.left, right: next.right, y: next.y }
        const spacing = next.spacing === undefined || next.spacing === null ? file.spacing : next.spacing
        if (spacing !== undefined && spacing !== null && !(spacing === file.gap && (file.spacing === undefined || file.spacing === null))) edit.spacing = spacing
        const copy = JSON.parse(JSON.stringify(edits))
        const rows = copy["@rows"] || {}, mine = rows[title_] || {}
        if (edit.fit === file.fit && edit.left === file.left && edit.right === file.right && edit.y === file.y && same(edit.spacing, file.spacing)) delete mine[row.name]
        else mine[row.name] = edit
        if (Object.keys(mine).length) rows[title_] = mine
        else delete rows[title_]
        if (Object.keys(rows).length) copy["@rows"] = rows
        else delete copy["@rows"]
        edits = copy
        rowsUpdate()
        if (picked) pickedEntry = entry(picked)
        linkUpdate()
        ruleTimer.restart()
        if (!quiet) changed()
    }
    function resetRow(row) {
        const file = (data.rows || []).filter(r => r.name === row.name)[0]
        setRow(row, { fit: file.fit, spacing: file.spacing === undefined ? null : file.spacing, left: file.left, right: file.right, y: file.y })
    }

    // ---- stretching: `across` left to right, `down` top to bottom, of what it's placed on
    function pointName(x, y) { return (y + x) || "CENTER" }
    function sideX(p) { return p.indexOf("LEFT") >= 0 ? "LEFT" : p.indexOf("RIGHT") >= 0 ? "RIGHT" : "" }
    function sideY(p) { return p.indexOf("TOP") >= 0 ? "TOP" : p.indexOf("BOTTOM") >= 0 ? "BOTTOM" : "" }
    function setStretch(name, across, down) {
        const was = placeOf(name), rel = was[1], item = items[name]
        // (an axis not stretched keeps its line; one no longer stretched, from its first side)
        const px = across ? "LEFT" : sideX(was[0]), py = down ? "TOP" : sideY(was[0])
        const tx = across ? "LEFT" : sideX(was[2]), ty = down ? "TOP" : sideY(was[2])
        const place = anchored(name, pointName(px, py), rel, pointName(tx, ty))
        let second = null
        if (across || down) {
            const point = pointName(across ? "RIGHT" : px, down ? "BOTTOM" : py), relPoint = pointName(across ? "RIGHT" : tx, down ? "BOTTOM" : ty)
            const other = anchored(name, point, rel, relPoint)
            second = [point, relPoint, other[3], other[4]]
        }
        change(name, place, [roundTenth(item.width), roundTenth(item.height)], false, second)
        pick(name)
    }

    // ---- the components (windows/components/): what every window inherits
    property var components: JSON.parse(backend.components())
    property bool componentsMode: false
    property string componentName: components.length ? components[0].name : ""
    readonly property var currentComponent: components.filter(c => c.name === componentName)[0] || null

    function openComponent(name) {
        componentName = name
        componentsMode = true
    }

    // ---- the sample window it shows (tools/sample.lua): every control drawn by
    // the game's own styling, with what's not saved
    property var sample: null
    property string sampleAsked: ""
    property bool fitSample: false
    property var hoveredControl: null
    onComponentsModeChanged: {
        hoveredControl = null
        fitSample = componentsMode
        if (componentsMode) drawSample()
        fit(false)
    }
    function drawSample() {
        if (!componentsMode) return
        const asked = JSON.stringify({ "@components": edits["@components"] || {} })
        if (asked === sampleAsked) return
        sampleAsked = asked
        backend.drawSample(asked)
    }
    // the control at a place: the smallest there
    function controlAt(at) {
        if (!sample) return null
        let best = null
        for (const c of sample.controls) {
            const r = sampleBox(c.rect)
            if (at.x >= r[0] && at.x <= r[0] + r[2] && at.y >= r[1] && at.y <= r[1] + r[3]
                && (!best || r[2] * r[3] < best.rect[2] * best.rect[3])) best = c
        }
        return best
    }
    // a rect of the game's (from its bottom left) as drawn: x, y from the top left, width, height
    function sampleBox(r) {
        const all = sample ? sample.rect : [0, 0, 0, 0]
        return [r[0] - all[0], all[1] + all[3] - r[1] - r[3], r[2], r[3]]
    }
    function componentValue(name, field) {
        const shared = edits["@components"], changed_ = shared && shared[name]
        return changed_ && changed_[field.key] !== undefined ? changed_[field.key] : field.value
    }
    function componentEdited(name) { return !!(edits["@components"] && edits["@components"][name]) }
    function setComponent(field, value) {
        remember()
        const copy = JSON.parse(JSON.stringify(edits))
        const shared = copy["@components"] || {}
        const changes = shared[componentName] || {}
        if (same(value, field.value)) delete changes[field.key]
        else changes[field.key] = value
        if (Object.keys(changes).length) shared[componentName] = changes
        else delete shared[componentName]
        if (Object.keys(shared).length) copy["@components"] = shared
        else delete copy["@components"]
        edits = copy
        applyComponents()
        ruleTimer.restart()
        changed()
    }
    function resetComponent(name) {
        if (!componentEdited(name)) return
        remember()
        const copy = JSON.parse(JSON.stringify(edits))
        delete copy["@components"][name]
        if (!Object.keys(copy["@components"]).length) delete copy["@components"]
        edits = copy
        applyComponents()
        ruleTimer.restart()
        changed()
    }
    // What a part of a component takes from a change not saved yet, in the window
    // open too (its rules go by it; the rest of its art shows once saved, /reload
    // and /dui layout).
    function componentSize(item) {
        const shared = edits["@components"], changes = shared && shared[item.style]
        if (!changes) return null
        const key = item.style === "ScrollBar" ? (/Scroll(Up|Down)Button$/.test(item.name) ? "width" : "")
            : item.style === "CloseButton" || item.style === "CheckBox" ? "size" : ""
        return key && changes[key] !== undefined ? [changes[key], changes[key]] : null
    }
    function applyComponents() {
        drawSample()
        for (const name in items) {
            const item = items[name]
            if (!item.style || !parts[name]) continue
            const e = entry(name), size = e.pin === "all" || e.pin === "size" ? null : componentSize(item) || e.size
            if (size) { item.width = size[0]; item.height = size[1] }
        }
    }

    // Reset: what's not saved of it gone, as in its file.
    function resetPart(name) {
        if (!edits[name]) return
        remember()
        const copy = Object.assign({}, edits)
        delete copy[name]
        edits = copy
        applyItem(name)
        if (name === picked) pickedEntry = entry(name)
        ruleTimer.restart()
        changed()
    }

    // Unpin: back as in its file, following the scan once saved.
    function unpinPart(name) {
        remember()
        const copy = Object.assign({}, edits)
        if (parts[name].pin) copy[name] = { window: title_, place: parts[name].place, size: parts[name].size, pin: "" }
        else delete copy[name]
        edits = copy
        applyItem(name)
        if (name === picked) pickedEntry = entry(name)
        status = name + " follows the scan once saved."
        ruleTimer.restart()
        changed()
    }

    function save() {
        const inComponents = componentsMode
        status = backend.save(JSON.stringify(edits))
        if (status.indexOf("Not saved") === 0) return
        leftText = backend.leftText()
        components = JSON.parse(backend.components())
        sampleAsked = ""
        edits = {}
        undoList = []; redoList = []
        backend.keep("{}")
        const was = picked
        openWindow(title_)
        if (was && parts[was]) pick(was)
        componentsMode = inComponents
        status += "  Saved: /reload the game."
    }

    // ---- picking
    function pick(name) {
        if (name) componentsMode = false // (a part picked: its own panel)
        picked = name
        pickedEntry = name ? entry(name) : null
        linkUpdate()
        if (name) unfoldTo(name)
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
        // a button before its own text, what's pressed is the button (press again for the text)
        const isText = n => parts[n].kind === "FontString" && hits.indexOf(parts[n].parent) >= 0
            && (parts[parts[n].parent].kind === "Button" || parts[parts[n].parent].kind === "CheckButton")
        const texts = hits.filter(isText)
        return hits.filter(n => !isText(n)).concat(texts)
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
        if (!pickedItem || componentsMode) return false
        const at = toRoot(p), item = pickedItem, near = 8 / content.scale, gap = handleGap / content.scale
        if (pickedRow) { // (only its ends' handles)
            const on = items[pickedRow.on], left = on.x + pickedRow.left, right = on.x + on.width - pickedRow.right
            const y = item.y + item.height / 2
            return Math.hypot(at.x - left + gap / 2, at.y - y) < near || Math.hypot(at.x - right - gap / 2, at.y - y) < near
        }
        if (pickedHeld) return false
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
        if (componentsMode) {
            if (!sample) return // (once it's drawn)
            r = [0, 0, sample.rect[2], sample.rect[3]]
        } else if (w && f) {
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
        const reach = 5 / content.scale, row = rowOf(name)
        let bestX = row ? -1 : reach, bestY = reach, dx = 0, dy = 0 // (a row goes up and down only)
        const follows = {}
        for (const n in parts) { const e = entry(n); if (e.place && e.place[1] === name) follows[n] = true }
        if (row) for (const n of row.parts) follows[n] = true // (they go with it)
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
    // (a tree by the game's parents: each part under the nearest that shows, folded
    // but for what's been opened; a search shows what's found, under its parents)
    property var listModel: []       // the rows shown, their names
    property var listInfo: ({})      // by name: { depth, kids, open }
    property var unfolded: ({})
    property var artModel: []
    function listModelUpdate() {
        const q = find.text.toLowerCase(), seen = n => shown[kindOf(parts[n].kind)] && inView(n)
        const names_ = Object.keys(parts).sort().filter(seen), kids = {}, roots = [], over = {}
        const nearest = n => {
            let up = parts[n].parent
            for (let i = 0; up && parts[up] && !seen(up) && i < 50; i++) up = parts[up].parent
            return up && parts[up] && seen(up) && up !== n ? up : null
        }
        for (const n of names_) over[n] = nearest(n)
        for (const n of names_) {
            // (one held by what it holds, should a scan say so: on top)
            let up = over[n], loop = false
            for (let i = 0; up && i < 50; i++) { if (up === n) { loop = true; break } up = over[up] }
            if (over[n] && !loop) (kids[over[n]] = kids[over[n]] || []).push(n)
            else roots.push(n)
        }
        const wanted = {}
        if (q) for (const n of names_) {
            if (n.toLowerCase().indexOf(q) >= 0 || (parts[n].text || "").toLowerCase().indexOf(q) >= 0)
                for (let up = n, i = 0; up && i < 50; i++) { wanted[up] = true; up = over[up] }
        }
        const out = [], info = {}
        const add = (n, depth) => {
            if (q && !wanted[n]) return
            const under = kids[n] || [], open = !!q || !!unfolded[n]
            out.push(n)
            info[n] = { depth: depth, kids: under.length, open: open }
            if (open) for (const c of under) add(c, depth + 1)
        }
        for (const n of roots) add(n, 0)
        listInfo = info
        listModel = out
    }
    function unfoldTo(name) {
        let any = false, up = parts[name] && parts[name].parent
        for (let i = 0; up && parts[up] && i < 50; i++) {
            if (!unfolded[up]) { unfolded[up] = true; any = true }
            up = parts[up].parent
        }
        if (any) listModelUpdate()
    }
    function toggleFold(name) {
        if (unfolded[name]) delete unfolded[name]
        else unfolded[name] = true
        listModelUpdate()
    }
    function foldAll() {
        unfolded = {}
        if (picked) unfoldTo(picked)
        listModelUpdate()
    }
    // its name without its parent's, which is just above it; its text
    function listText(name) {
        const p = parts[name] || {}, under = p.parent && parts[p.parent] && name.indexOf(p.parent) === 0 && name.length > p.parent.length
        return (under ? name.slice(p.parent.length) : name) + (p.text ? "  “" + p.text + "”" : "")
    }

    function lineFor(name, e) {
        if (name === "@components") {
            const lines = []
            for (const c of Object.keys(e).sort())
                for (const key of Object.keys(e[c]).sort()) lines.push(c + "." + key + " = " + JSON.stringify(e[c][key]))
            return lines.join("\n")
        }
        if (name === "@rows") {
            const lines = []
            for (const w of Object.keys(e).sort())
                for (const row of Object.keys(e[w]).sort()) lines.push(row + " = " + JSON.stringify(e[w][row]))
            return lines.join("\n")
        }
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
        if (componentsMode || !picked || (!across && !up)) return false
        const step = modifiers & Qt.ShiftModifier ? 10 : 1, e = entry(picked)
        if (pickedRow) { // (the whole row, up and down)
            if (up) setRow(pickedRow, { y: roundTenth(pickedRow.y + up * step) })
            return true
        }
        if (e.second) { // (both its sides)
            const place = e.place.slice(), other = e.second.slice()
            place[3] = roundTenth(place[3] + across * step); other[2] = roundTenth(other[2] + across * step)
            place[4] = roundTenth(place[4] + up * step); other[3] = roundTenth(other[3] + up * step)
            change(picked, place, e.size, false, other)
            return true
        }
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
                    onActivated: {
                        app.componentsMode = false
                        app.openWindow(currentText)
                    }
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
                            CheckBox { id: showOutlines; objectName: "showOutlines"; text: "Outlines"; checked: false }
                        }
                    }
                }
                Action {
                    objectName: "componentsButton"
                    text: "Components"
                    tip: "What every window inherits: scroll bars, buttons, dropdowns..."
                    highlighted: app.componentsMode
                    onClicked: app.componentsMode = !app.componentsMode
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
                visible: app.views.length > 1 && !app.componentsMode
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
                text: app.componentsMode
                    ? "Press a control to open it  ·  what you change shows here at once  ·  the windows inherit it once saved, then /reload and /dui layout"
                    : app.pickedRow
                    ? "Drag a button: the whole row up or down  ·  its gold ends: its room  ·  arrows: up and down, Shift: 10"
                    : app.pickedHeld
                    ? "Its sides hold it: set them on the right  ·  arrows move both, Shift: 10"
                    : app.picked
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
            ListView {
                objectName: "componentList"
                visible: app.componentsMode
                Layout.fillWidth: true; Layout.fillHeight: true; Layout.margins: 8
                clip: true
                model: app.components
                delegate: ItemDelegate {
                    required property var modelData
                    width: ListView.view.width
                    height: 28
                    padding: 2
                    leftPadding: 6
                    contentItem: Text {
                        text: (app.componentEdited(modelData.name) ? "● " : "") + modelData.name
                        color: modelData.name === app.componentName ? app.gold : app.palette.text
                        font.family: app.plain
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: app.componentName = modelData.name
                }
            }
            RowLayout {
                visible: !app.componentsMode
                Layout.fillWidth: true; Layout.margins: 8; Layout.bottomMargin: 0
                TextField {
                    id: find
                    Layout.fillWidth: true
                    placeholderText: "Find a part…  (Ctrl+F)"
                    font.family: app.plain
                    onTextChanged: app.listModelUpdate()
                }
                Button {
                    objectName: "foldAll"
                    text: "Fold"
                    onClicked: app.foldAll()
                    ToolTip.visible: hovered
                    ToolTip.delay: 400
                    ToolTip.text: "Fold the whole list"
                }
            }
            ListView {
                id: list
                objectName: "list"
                visible: !app.componentsMode
                Layout.fillWidth: true; Layout.fillHeight: true; Layout.margins: 8; Layout.topMargin: 0
                clip: true
                model: app.listModel
                highlightMoveDuration: 80
                currentIndex: app.listModel.indexOf(app.picked)
                highlight: Rectangle { color: "#3a2c18"; radius: 3 }
                ScrollBar.vertical: ScrollBar {}
                delegate: ItemDelegate {
                    required property string modelData
                    readonly property var info: app.listInfo[modelData] || ({ depth: 0, kids: 0, open: false })
                    width: ListView.view.width
                    height: 24
                    padding: 2
                    leftPadding: 2 + info.depth * 14
                    highlighted: false
                    contentItem: RowLayout {
                        spacing: 2
                        Text {
                            objectName: "fold"
                            Layout.preferredWidth: 16
                            Layout.fillHeight: true
                            text: info.kids ? (info.open ? "▾" : "▸") : ""
                            font.pixelSize: 18
                            color: app.dim
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            MouseArea {
                                anchors.fill: parent
                                enabled: info.kids > 0
                                cursorShape: Qt.PointingHandCursor
                                onClicked: app.toggleFold(modelData)
                            }
                        }
                        Text {
                            Layout.fillWidth: true
                            text: (app.edits[modelData] || app.rowPlaced[modelData] ? "● " : "") + (app.parts[modelData] && app.parts[modelData].pin ? "◆ " : "") + app.listText(modelData)
                            color: modelData === app.picked ? app.gold : (app.parts[modelData] || {}).kind === "FontString" ? "#8fce7a" : app.palette.text
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                            font.family: app.plain
                        }
                    }
                    ToolTip.visible: hovered
                    ToolTip.delay: 400
                    ToolTip.text: modelData + " (" + ((app.parts[modelData] || {}).kind || "?") + ")" + ((app.parts[modelData] || {}).text ? "\n“" + app.parts[modelData].text + "”" : "")
                    onClicked: app.pick(modelData)
                    onDoubleClicked: if (info.kids) app.toggleFold(modelData)
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
                // ---- Components: the sample window
                Item {
                    objectName: "sampleLayer"
                    visible: app.componentsMode
                    Repeater {
                        model: app.sample ? app.sample.art : []
                        Image {
                            required property var modelData
                            required property int index
                            readonly property var box: app.sampleBox(modelData.rect)
                            x: box[0]; y: box[1]; width: box[2]; height: box[3]
                            opacity: (modelData.alpha === undefined ? 1 : modelData.alpha) * (modelData.backdrop || !modelData.color ? 1 : modelData.color[3])
                            source: "image://art/" + app.sample.generation + "/@sample/0/" + index
                            cache: false
                            smooth: true
                        }
                    }
                    Repeater {
                        model: app.sample ? app.sample.texts : []
                        Text {
                            required property var modelData
                            readonly property var box: app.sampleBox(modelData.rect)
                            FontLoader { id: fontFile; source: modelData.font }
                            x: box[0]; y: box[1]; width: box[2]; height: box[3]
                            text: modelData.text
                            textFormat: Text.PlainText
                            color: Qt.rgba(Math.min(1, modelData.color[0]), Math.min(1, modelData.color[1]), Math.min(1, modelData.color[2]), 1)
                            opacity: modelData.alpha
                            font.family: modelData.font ? fontFile.name : app.plain
                            font.pixelSize: modelData.size
                            horizontalAlignment: modelData.align === "left" ? Text.AlignLeft : modelData.align === "right" ? Text.AlignRight : Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            style: modelData.outline ? Text.Outline : Text.Raised
                            styleColor: "#000000"
                        }
                    }
                    // the component open's controls, and the one under the mouse
                    Repeater {
                        model: app.sample ? app.sample.controls.filter(c => c.component === app.componentName && c.component !== "Window") : []
                        Rectangle {
                            required property var modelData
                            readonly property var box: app.sampleBox(modelData.rect)
                            x: box[0]; y: box[1]; width: box[2]; height: box[3]
                            color: "transparent"
                            border.color: app.gold; border.width: 2 / content.scale
                        }
                    }
                    Rectangle {
                        readonly property var box: app.hoveredControl ? app.sampleBox(app.hoveredControl.rect) : [0, 0, 0, 0]
                        visible: !!app.hoveredControl && app.hoveredControl.component !== "Window"
                        x: box[0]; y: box[1]; width: box[2]; height: box[3]
                        color: "#18ffffff"
                        border.color: "#ffffff"; border.width: 1 / content.scale
                    }
                }

                // ---- the window open
                Item {
                    id: windowLayer
                    visible: !app.componentsMode
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
                            // (sized with its part if it's on it: a tab can draw it elsewhere)
                            readonly property bool onOwner: !!(owner && base) && ax + modelData.rect[2] / 2 >= base[0] && ax + modelData.rect[2] / 2 <= base[0] + base[2]
                                && ay + modelData.rect[3] / 2 >= base[1] && ay + modelData.rect[3] / 2 <= base[1] + base[3]
                            readonly property real sx: onOwner && base[2] ? owner.width / base[2] : 1
                            readonly property real sy: onOwner && base[3] ? owner.height / base[3] : 1
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
                                visible: !!(app.pickedEntry && app.pickedEntry.size) && !app.pickedHeld
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
                                visible: !app.pickedHeld
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

                    // the picked part's row: the room it shares, a handle at each end
                    Item {
                        id: rowBox
                        objectName: "rowBox"
                        readonly property var row: app.pickedRow
                        readonly property Item on: row ? app.items[row.on] || null : null
                        visible: !!on && !!app.pickedItem
                        x: on ? on.x + row.left : 0
                        width: on ? on.width - row.left - row.right : 0
                        y: app.pickedItem ? app.pickedItem.y : 0
                        height: app.pickedItem ? app.pickedItem.height : 0
                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.color: app.gold; border.width: 1 / content.scale
                        }
                        Repeater {
                            model: [0, 1]
                            Rectangle {
                                required property int modelData
                                objectName: "rowHandle" + modelData
                                width: 9 / content.scale; height: 14 / content.scale
                                x: rowBox.width * modelData + (modelData - .5) * app.handleGap / content.scale - width / 2
                                y: (rowBox.height - height) / 2
                                color: rowEnd.active ? "#fff2d8" : app.gold
                                border.color: "#000"; border.width: 1 / content.scale
                                property var start: null
                                HoverHandler { cursorShape: Qt.SizeHorCursor }
                                DragHandler {
                                    id: rowEnd
                                    target: null
                                    grabPermissions: PointerHandler.CanTakeOverFromAnything
                                    onActiveChanged: {
                                        if (active) {
                                            app.remember()
                                            parent.start = { x0: centroid.scenePosition.x, left: rowBox.row.left, right: rowBox.row.right, width: rowBox.width }
                                        } else app.changed()
                                    }
                                    onCentroidChanged: {
                                        if (!active || !parent.start) return
                                        const s = parent.start
                                        // (the room can't close up)
                                        const dx = Math.round((centroid.scenePosition.x - s.x0) / content.scale)
                                        if (parent.modelData === 0) app.setRow(rowBox.row, { left: s.left + Math.min(dx, s.width - 1) }, true)
                                        else app.setRow(rowBox.row, { right: s.right - Math.max(dx, 1 - s.width) }, true)
                                    }
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
                    if (app.componentsMode) {
                        const control = app.controlAt(app.toRoot(point.position))
                        app.hoveredControl = control
                        readout.text = control ? control.component : ""
                        return
                    }
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
                    if (app.componentsMode) {
                        const control = app.controlAt(app.toRoot(point.position))
                        if (control) app.componentName = control.component
                        return
                    }
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
                        if (start && (start.move || start.row)) app.changed()
                        app.guideX = null; app.guideY = null
                        start = null
                        return
                    }
                    const press = centroid.pressPosition, at = app.toRoot(press), hits = app.partsAt(at.x, at.y)
                    if (app.overControls(press)) { start = null; return }
                    let name = hits.indexOf(app.picked) >= 0 ? app.picked : hits[0]
                    if (!name) { start = { pan: true, x: content.x - press.x, y: content.y - press.y }; return }
                    if (name !== app.picked) app.pick(name)
                    const item = app.items[name], e = app.entry(name), row = app.rowOf(name)
                    if (e.second && !row) {
                        app.status = name + " is stretched: its sides are in its panel."
                        start = null
                        return
                    }
                    app.remember()
                    if (row) { // (the whole row, up and down)
                        start = { row: row.name, rowY: app.rowNow(row).y, name: name, press: press, x: item.x, y: item.y }
                        return
                    }
                    start = { move: true, name: name, press: press, place: app.placeOf(name).slice(), size: e.size,
                        x: item.x, y: item.y }
                }
                onCentroidChanged: {
                    if (!active || !start) return
                    const p = centroid.position
                    if (start.pan) { content.x = start.x + p.x; content.y = start.y + p.y; return }
                    const dx = (p.x - start.press.x) / content.scale, dy = (p.y - start.press.y) / content.scale
                    if (start.row) {
                        const moved = app.snapped(start.name, start.x, Math.round(start.y + dy), centroid.modifiers & Qt.AltModifier)
                        app.setRow(app.rowOf(start.name), { y: app.roundTenth(start.rowY - (moved[1] - start.y)) }, true)
                        return
                    }
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
                    if (app.componentsMode) return
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
                MenuItem { text: "Reset this part"; enabled: !!app.edits[app.picked]; onTriggered: app.resetPart(app.picked) }
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
                // ---- the component chosen
                ColumnLayout {
                    objectName: "componentPanel"
                    visible: app.componentsMode && !!app.currentComponent
                    Layout.fillWidth: true
                    Layout.leftMargin: 10; Layout.rightMargin: 10; Layout.topMargin: 8
                    spacing: 6
                    Label { text: "SHARED BY EVERY WINDOW"; color: app.dim; font.pixelSize: 11 }
                    Label { text: app.componentName; color: app.gold; font.family: app.plain }
                    Label {
                        Layout.fillWidth: true
                        text: app.currentComponent ? app.currentComponent.comment : ""
                        color: app.dim
                        wrapMode: Text.Wrap
                        font.family: app.plain
                        font.pixelSize: 12
                    }
                    Button {
                        objectName: "componentReset"
                        text: "Reset"
                        enabled: app.componentEdited(app.componentName)
                        onClicked: app.resetComponent(app.componentName)
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Forget what's not saved of this component"
                    }
                    Repeater {
                        model: app.currentComponent ? app.currentComponent.fields : []
                        ColumnLayout {
                            id: fieldRow
                            required property var modelData
                            readonly property var current: app.componentValue(app.componentName, modelData)
                            readonly property string kind: modelData.kind
                            Layout.fillWidth: true
                            Layout.topMargin: 4
                            spacing: 2
                            Label {
                                Layout.fillWidth: true
                                text: fieldRow.modelData.key
                                color: JSON.stringify(fieldRow.current) === JSON.stringify(fieldRow.modelData.value) ? app.dim : "#e8703a"
                                font.family: app.plain
                                font.pixelSize: 12
                                elide: Text.ElideRight
                            }
                            Label {
                                Layout.fillWidth: true
                                visible: !!fieldRow.modelData.note
                                text: fieldRow.modelData.note || ""
                                color: "#6f6657"
                                wrapMode: Text.Wrap
                                font.family: app.plain
                                font.pixelSize: 11
                            }
                            NumberBox {
                                visible: fieldRow.kind === "number"
                                factor: 1000
                                stepSize: fieldRow.kind === "number" && Math.abs(fieldRow.modelData.value) < 2 ? 50 : 1000
                                number: fieldRow.kind === "number" ? fieldRow.current : 0
                                onEdited: value => app.setComponent(fieldRow.modelData, value)
                            }
                            CheckBox {
                                visible: fieldRow.kind === "boolean"
                                checked: fieldRow.current === true
                                onToggled: app.setComponent(fieldRow.modelData, checked)
                            }
                            RowLayout {
                                visible: fieldRow.kind === "color"
                                Rectangle {
                                    objectName: "swatch"
                                    width: 48; height: 22
                                    radius: 2
                                    border.color: app.dim
                                    color: fieldRow.kind === "color" ? Qt.rgba(Math.min(1, fieldRow.current[0]), Math.min(1, fieldRow.current[1]), Math.min(1, fieldRow.current[2]), 1) : "transparent"
                                    TapHandler { onTapped: app.pickColor(fieldRow.modelData, fieldRow.current) }
                                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                                }
                                Label {
                                    Layout.fillWidth: true
                                    text: fieldRow.kind === "color" ? fieldRow.current.map(v => Math.round(v * 100) / 100).join(", ") : ""
                                    color: app.dim
                                    font.family: app.plain
                                    font.pixelSize: 12
                                }
                            }
                            RowLayout {
                                visible: fieldRow.kind === "texture" || fieldRow.kind === "string" || fieldRow.kind === "list"
                                Image {
                                    visible: fieldRow.kind === "texture"
                                    Layout.preferredWidth: 32; Layout.preferredHeight: 32
                                    fillMode: Image.PreserveAspectFit
                                    source: fieldRow.kind === "texture" ? "image://art/file/media/" + fieldRow.current : ""
                                }
                                TextField {
                                    Layout.fillWidth: true
                                    font.family: app.plain
                                    font.pixelSize: 12
                                    text: fieldRow.kind === "list" ? fieldRow.current.join(", ") : String(fieldRow.current)
                                    onEditingFinished: {
                                        if (fieldRow.kind !== "list") {
                                            if (text !== fieldRow.current) app.setComponent(fieldRow.modelData, text)
                                            return
                                        }
                                        const items = text.split(",").map(t => t.trim()).filter(t => t !== "").map(t => isFinite(t) ? Number(t) : t)
                                        if (JSON.stringify(items) !== JSON.stringify(fieldRow.current)) app.setComponent(fieldRow.modelData, items)
                                    }
                                }
                            }
                        }
                    }
                }

                // ---- the part picked
                ColumnLayout {
                    visible: !app.componentsMode
                    Layout.fillWidth: true
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
                            + "\n" + (p.inRow ? "◆ In a row: drag it, or change the row below" : app.pickedHeld ? "◆ Stretched: its sides place it"
                                : pin === "place" ? "◆ Its place is pinned" : pin === "size" ? "◆ Its size is pinned"
                                : pin ? "◆ Pinned: stays as set" : "Not pinned: follows the game's scan")
                    }
                }
                GridLayout {
                    id: fields
                    objectName: "fields"
                    // (a row's part: its row's panel says it all)
                    visible: !!(app.picked && app.pickedEntry && !app.pickedRow)
                    columns: 2
                    property bool open: false // (what it's placed on: to change, otherwise said in a line)
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    readonly property var place: app.pickedEntry ? app.pickedEntry.place : null
                    readonly property var size: app.pickedEntry ? app.pickedEntry.size : null
                    readonly property var second: app.pickedEntry ? app.pickedEntry.second || null : null
                    readonly property bool across: !!(second && place && app.lineX(second[0]) !== app.lineX(place[0]))
                    readonly property bool down: !!(second && place && app.lineY(second[0]) !== app.lineY(place[0]))
                    function anchor(point, rel, relPoint) {
                        if (app.items[rel]) {
                            app.change(app.picked, app.anchored(app.picked, point, rel, relPoint), app.entry(app.picked).size)
                            app.pick(app.picked)
                        }
                    }
                    function numbers() {
                        const e = app.entry(app.picked), place = app.placeOf(app.picked).slice()
                        place[3] = fx.value / 10; place[4] = (down ? -fy.value : fy.value) / 10
                        let other = undefined
                        if (second) {
                            // (the side not stretched: the same line as its first)
                            other = second.slice()
                            other[2] = across ? -fx2.value / 10 : place[3]
                            other[3] = down ? fy2.value / 10 : place[4]
                        }
                        app.change(app.picked, place, e.size ? [fw.value / 10, fh.value / 10] : e.size, false, other)
                    }

                    Label {
                        objectName: "placedOn"
                        Layout.columnSpan: 2; Layout.fillWidth: true
                        visible: !fields.open
                        color: app.dim
                        wrapMode: Text.WrapAnywhere
                        font.family: app.plain
                        text: fields.place ? "On " + fields.place[1] + (fields.place[0] === fields.place[2] ? "" : "  (" + fields.place[0] + " to " + fields.place[2] + ")") : "Not placed"
                    }
                    Button {
                        objectName: "anchorsToggle"
                        Layout.columnSpan: 2
                        visible: !fields.second
                        text: fields.open ? "Hide where it's placed" : "Change where it's placed"
                        flat: true
                        onClicked: fields.open = !fields.open
                    }
                    Label { text: "Point"; color: app.dim; visible: fields.open && !fields.second }
                    ComboBox {
                        Layout.fillWidth: true
                        visible: fields.open && !fields.second
                        model: app.pointNames
                        currentIndex: fields.place ? model.indexOf(fields.place[0]) : -1
                        onActivated: fields.anchor(currentText, fields.place ? fields.place[1] : app.title_, fields.place ? fields.place[2] : "TOPLEFT")
                    }
                    Label { text: "On"; color: app.dim; visible: fields.open && !fields.second }
                    ComboBox {
                        Layout.fillWidth: true
                        visible: fields.open && !fields.second
                        editable: true
                        font.family: app.plain
                        model: app.names
                        currentIndex: fields.place ? model.indexOf(fields.place[1]) : -1
                        onActivated: fields.anchor(fields.place ? fields.place[0] : "TOPLEFT", currentText, fields.place ? fields.place[2] : "TOPLEFT")
                        onAccepted: fields.anchor(fields.place ? fields.place[0] : "TOPLEFT", editText, fields.place ? fields.place[2] : "TOPLEFT")
                    }
                    Label { text: "At"; color: app.dim; visible: fields.open && !fields.second }
                    ComboBox {
                        Layout.fillWidth: true
                        visible: fields.open && !fields.second
                        model: app.pointNames
                        currentIndex: fields.place ? model.indexOf(fields.place[2]) : -1
                        onActivated: fields.anchor(fields.place ? fields.place[0] : "TOPLEFT", fields.place ? fields.place[1] : app.title_, currentText)
                    }
                    Label { text: fields.across ? "From left" : "X"; color: app.dim }
                    NumberBox { id: fx; number: fields.place ? fields.place[3] : 0; onEdited: fields.numbers() }
                    Label { text: "From right"; color: app.dim; visible: fields.across }
                    NumberBox { id: fx2; objectName: "fromRight"; visible: fields.across; number: fields.second ? -fields.second[2] : 0; onEdited: fields.numbers() }
                    Label { text: fields.down ? "From top" : "Y"; color: app.dim }
                    NumberBox { id: fy; number: fields.place ? (fields.down ? -fields.place[4] : fields.place[4]) : 0; onEdited: fields.numbers() }
                    Label { text: "From bottom"; color: app.dim; visible: fields.down }
                    NumberBox { id: fy2; objectName: "fromBottom"; visible: fields.down; number: fields.second ? fields.second[3] : 0; onEdited: fields.numbers() }
                    Label { text: "Width"; color: app.dim; visible: !!fields.size && !fields.across }
                    NumberBox { id: fw; visible: !!fields.size && !fields.across; number: fields.size ? fields.size[0] : 0; onEdited: fields.numbers() }
                    Label { text: "Height"; color: app.dim; visible: !!fields.size && !fields.down }
                    NumberBox { id: fh; visible: !!fields.size && !fields.down; number: fields.size ? fields.size[1] : 0; onEdited: fields.numbers() }
                }
                // stretched between what it's placed on's sides
                ColumnLayout {
                    objectName: "stretch"
                    Layout.leftMargin: 10
                    spacing: 0
                    visible: !!(app.picked && app.pickedEntry && !app.pickedRow && (app.parts[app.picked] || {}).kind !== "FontString")
                    CheckBox {
                        objectName: "stretchAcross"
                        text: "Stretch left to right"
                        checked: fields.across
                        onToggled: app.setStretch(app.picked, checked, fields.down)
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Its sides stay on the left and right of what it's placed on, as it is now"
                    }
                    CheckBox {
                        objectName: "stretchDown"
                        text: "Stretch top to bottom"
                        checked: fields.down
                        onToggled: app.setStretch(app.picked, fields.across, checked)
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Its sides stay on the top and bottom of what it's placed on, as it is now"
                    }
                }
                // the row it's in
                GridLayout {
                    objectName: "rowFields"
                    visible: !!app.pickedRow
                    columns: 2
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    readonly property var row: app.pickedRow
                    Label { Layout.columnSpan: 2; text: "ROW"; color: app.dim; font.pixelSize: 11; Layout.topMargin: 4 }
                    Label {
                        Layout.columnSpan: 2; Layout.fillWidth: true
                        text: parent.row ? parent.row.name : ""
                        color: app.gold
                        font.family: app.plain
                        wrapMode: Text.WrapAnywhere
                    }
                    Label { text: "Fit"; color: app.dim }
                    ComboBox {
                        objectName: "rowFit"
                        Layout.fillWidth: true
                        model: ["fill", "equal", "center", "ends"]
                        currentIndex: parent.row ? model.indexOf(parent.row.fit) : -1
                        onActivated: app.setRow(parent.row, { fit: currentText })
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "fill: as wide as their texts, the room left shared\nequal: all as wide, filling the room\ncenter: as they are, in the middle\nends: as they are, first and last at the ends"
                    }
                    Label { text: "Spacing"; color: app.dim }
                    NumberBox {
                        objectName: "rowSpacing"
                        enabled: !!(parent.row && parent.row.fit !== "ends")
                        number: parent.row ? (parent.row.spacing === undefined || parent.row.spacing === null ? parent.row.gap : parent.row.spacing) : 0
                        onEdited: (value) => app.setRow(parent.row, { spacing: value })
                    }
                    Label { text: "From left"; color: app.dim }
                    NumberBox { objectName: "rowLeft"; number: parent.row ? parent.row.left : 0; onEdited: (value) => app.setRow(parent.row, { left: value }) }
                    Label { text: "From right"; color: app.dim }
                    NumberBox { objectName: "rowRight"; number: parent.row ? parent.row.right : 0; onEdited: (value) => app.setRow(parent.row, { right: value }) }
                    Label { text: "Y"; color: app.dim }
                    NumberBox { objectName: "rowY"; number: parent.row ? parent.row.y : 0; onEdited: (value) => app.setRow(parent.row, { y: value }) }
                    Button {
                        objectName: "resetRow"
                        Layout.columnSpan: 2
                        text: "Reset row"
                        enabled: !!(parent.row && app.rowEdit(parent.row))
                        onClicked: app.resetRow(parent.row)
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Forget what's not saved of this row"
                    }
                }
                RowLayout {
                    Layout.leftMargin: 10
                    visible: !!app.picked
                    Button {
                        objectName: "resetButton"
                        text: "Reset"
                        visible: !app.pickedRow
                        enabled: !!app.edits[app.picked]
                        onClicked: app.resetPart(app.picked)
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Forget what's not saved of this part"
                    }
                    Button {
                        objectName: "unpinButton"
                        text: "Unpin"
                        visible: !!(app.pickedEntry && app.pickedEntry.pin && !app.pickedHeld)
                        onClicked: app.unpinPart(app.picked)
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Let it follow the game's scan again, once saved"
                    }
                }
                Button {
                    objectName: "partComponent"
                    Layout.leftMargin: 10
                    readonly property string style: (app.parts[app.picked] || {}).style || ""
                    visible: style !== ""
                    text: "Styled as " + style + " ▸"
                    onClicked: app.openComponent(style)
                    ToolTip.visible: hovered
                    ToolTip.delay: 400
                    ToolTip.text: "Its look is shared by every window: change it there"
                }
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

    ColorDialog {
        id: colorDialog
        objectName: "colorDialog"
        property var field: null
        property var was: null
        options: ColorDialog.ShowAlphaChannel
        onAccepted: {
            const r3 = v => Math.round(v * 1000) / 1000
            const out = [r3(selectedColor.r), r3(selectedColor.g), r3(selectedColor.b)]
            if (was.length > 3) out.push(r3(selectedColor.a))
            app.setComponent(field, out)
        }
    }
    function pickColor(field, value) {
        colorDialog.field = field
        colorDialog.was = value
        colorDialog.selectedColor = Qt.rgba(Math.min(1, value[0]), Math.min(1, value[1]), Math.min(1, value[2]), value.length > 3 ? value[3] : 1)
        colorDialog.open()
    }

    Connections {
        target: backend
        function onSampled(text) {
            app.sample = JSON.parse(text)
            if (app.fitSample) {
                app.fitSample = false
                app.fit(false)
            }
        }
        function onSampleFailed(problem) { app.status = "Sample window: " + problem }
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
