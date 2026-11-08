// The windows' editor (tools/editor.py runs it): a windows/*.qml file loaded
// as it is, each part inside what it's placed on, so what's on a part goes with
// it. Press a part to pick it (again: the one under it), drag it (it snaps to the
// others' edges, Alt: not), drag a handle to size it, drag a dot to another part's
// to place it in that part. Right-click: all that's under the cursor.
import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import "../windows" as Game

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
    property var windowData: null          // its part of layout.json
    property string title_: ""
    property var parts: ({})         // its parts, by name
    property var items: ({})         // the QML items, by name (the window's, the Ghosts' and the rows' too)
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
    property int moved: 0            // up each time parts have moved: what's drawn from where they are follows
    property string status: backend.startMessage()
    property string leftText: backend.leftText()
    property var shown: ({ Frame: true, FontString: true, Texture: true })
    property var artBase: ({})
    property var views: []           // what it shows by its tabs: { key, label, rect, window, art }
    property int viewIndex: 0
    readonly property var view_: views[viewIndex] || null
    readonly property var viewRect: (view_ && view_.rect) || (windowData ? windowData.rect : null)

    Settings {
        id: settings
        property string lastWindow
        property alias listWidth: left.width_
        property alias outlines: showOutlines.checked
    }

    function kindOf(kind) { return kind === "Texture" || kind === "FontString" ? kind : "Frame" }
    function roundTenth(v) { return Math.round(v * 10) / 10 }
    function fractionX(p) { return p.indexOf("LEFT") >= 0 ? 0 : p.indexOf("RIGHT") >= 0 ? 1 : .5 }
    function fractionY(p) { return p.indexOf("TOP") >= 0 ? 0 : p.indexOf("BOTTOM") >= 0 ? 1 : .5 } // (y down here)
    function lineX(p) { return p.indexOf("LEFT") >= 0 ? "left" : p.indexOf("RIGHT") >= 0 ? "right" : "horizontalCenter" }
    function lineY(p) { return p.indexOf("TOP") >= 0 ? "top" : p.indexOf("BOTTOM") >= 0 ? "bottom" : "verticalCenter" }
    function same(a, b) { return JSON.stringify(a === undefined ? null : a) === JSON.stringify(b === undefined ? null : b) }
    // where a part (or the window) is in the window: x, y, width, height
    function rectOf(name) {
        const item = items[name], at = item.mapToItem(root, 0, 0)
        return [at.x, at.y, item.width, item.height]
    }
    function under(name, over) {
        for (let up = items[name]; up && up !== root; up = up.parent) if (up === items[over]) return true
        // (or next to it, by what it's placed on)
        const seen = {}
        for (let up = name; up && parts[up] && !seen[up]; up = (entry(up).place || [])[1]) {
            if (up === over) return true
            seen[up] = true
        }
        return false
    }
    function isRow(name) { return !!items[name] && items[name].fit !== undefined }
    function bumpMoved() { moved++ }
    function fileEntry(name) {
        const p = parts[name]
        return { place: p.place, size: p.size, pin: p.pin || "", second: p.second }
    }
    function entry(name) { return edits[name] || fileEntry(name) }

    // ---- opening
    function openWindow(name) {
        pick(""); hovered = ""; artModel = []; scrollFrames = []; follows = ({}) // (first: what's drawn on a part comes out of it)
        if (root) root.destroy()
        root = null
        unfolded = {}
        windowData = JSON.parse(backend.window(name))
        title_ = name
        settings.lastWindow = name
        windowPick.currentIndex = windowPick.model.indexOf(name)
        parts = windowData.parts
        views = windowData.views || []
        viewIndex = 0
        const component = Qt.createComponent(windowData.url)
        if (component.status !== Component.Ready) {
            status = component.errorString()
            return
        }
        root = component.createObject(holder, { px: 1 / content.scale })
        root.px = Qt.binding(() => 1 / content.scale)
        root.outlines = Qt.binding(() => showOutlines.checked)
        const map = {}
        map[name] = root
        const walk = item => {
            for (let i = 0; i < item.children.length; i++) {
                const child = item.children[i]
                if (child.name !== undefined) { map[child.name] = child; walk(child) }
            }
        }
        walk(root)
        items = map
        // (a button with a text and no part for it, the game's unnamed: it draws it itself; a tab's is our banner's tooltip)
        const worded = {}
        const says = p => !!p.text || !!(p.words && Object.keys(p.words).length)
        for (const n in parts) if (parts[n].kind === "FontString" && says(parts[n])) worded[parts[n].parent] = true
        for (const n in parts) if (items[n] && !parts[n].preview) {
            items[n].look = parts[n]
            if (says(parts[n]) && parts[n].kind !== "FontString" && !worded[n] && !/Tab\d+$/.test(n)) items[n].labelled = true
        }
        for (const n in edits) if (edits[n].window === name && items[n] && parts[n]) applyItem(n)
        for (const row of windowData.rows || []) applyRow(row)
        followSides()
        for (const n in parts) if (items[n] && !parts[n].preview && parts[n].justify) items[n].justify = justifyOf(parts[n], items[n].width)
        // the art follows its part from where the part is now
        const base = {}
        for (const n in map) base[n] = rectOf(n)
        artBase = base
        showView(0)
        fit(false)
    }

    // What the game stretches between the sides of what it's placed on (a panel on
    // its list, a scroll bar) does so here, with no pin: sizing that sizes it, and
    // sizing it sizes that.
    property var follows: ({})
    property var scrollFrames: []
    function followSides() {
        const found = {}, lists = []
        for (const n in parts) {
            const p = parts[n], item = items[n], points = p.points
            if (item && !p.preview && p.kind === "ScrollFrame" && p.rect) lists.push(n)
            if (!item || p.preview || p.pin || p.inRow || edits[n] || !p.place || !points || points.length < 2) continue
            const on = items[p.place[1]]
            if (!on || (item.parent !== on && item.parent !== on.parent)) continue
            // (its other side as the scan saw it placed: what it's on may have been sized since)
            const stretch = (line, offset) => {
                const first = line(p.place[0])
                if (first === "horizontalCenter" || first === "verticalCenter" || !points.some(q => q[1] === p.place[1] && line(q[0]) === first)) return
                const other = points.filter(q => line(q[0]) !== first && line(q[0]) !== "horizontalCenter" && line(q[0]) !== "verticalCenter")[0]
                if (!other) return
                const side = line(other[0])
                if (other[1] === p.place[1]) {
                    item.anchors[side] = on[line(other[2])]
                    item.anchors[marginOf[side][0]] = other[offset] * marginOf[side][1]
                    found[n] = p.place[1]
                } else if (line === lineY && side === "bottom" && items[other[1]]) { // (a track between its arrows: anchors can't reach)
                    const to = other[1], below = other[4]
                    const track = n
                    item.height = Qt.binding(() => { void moved; if (!root || !items[track] || !items[to]) return 1; const t = rectOf(to); return Math.max(1, t[1] + t[3] - below - items[track].mapToItem(root, 0, 0).y) })
                }
            }
            stretch(lineX, 3)
            stretch(lineY, 4)
        }
        follows = found
        scrollFrames = lists
    }
    function sizer(name) { return follows[name] && !edits[name] ? follows[name] : name }
    // A list made shorter than the scan saw it: are these rows now under it?
    function cutOff(x, y, width, height) {
        void moved // (again as parts move)
        const cx = x + width / 2, cy = y + height / 2
        for (const n of scrollFrames) {
            const was = previewBox(parts[n].rect), now = rectOf(n)
            if (now[3] < was[3] - .5 && cx >= was[0] && cx <= was[0] + was[2] && cy > now[1] + now[3] && cy <= was[1] + was[3]) return true
        }
        return false
    }
    // A scroll bar's thumb where the scan saw it, past the end of a bar made shorter?
    function thumbPast(name, y, height) {
        void moved
        if (!/ScrollBarThumbTexture$/.test(name)) return false
        const bar = name.replace(/ThumbTexture$/, "")
        return !!items[bar] && y + height > rectOf(bar)[1] + rectOf(bar)[3] + 1
    }
    // Where a picture goes as its part grows, along one side: pieces at an end stay
    // that size at it, what's between grows with it, the rest in proportion.
    // [ from the part's start, size ]
    // the part art is drawn on: its own, or for a texture that's no part (a
    // button's NormalTexture) the part its name starts with
    function artOwner(name) {
        for (let n = name || ""; n && n !== title_; n = n.replace(/([A-Z][a-z]*|\d+)$/, "")) {
            if (parts[n]) return n
            if (!/([A-Z][a-z]*|\d+)$/.test(n)) break
        }
        return ""
    }
    function artSpan(start, size, whole, now) {
        const end = whole - start - size, grown = now - whole, length = Math.abs(size)
        if (start <= 8 && length <= 40) return [start, size]
        if (end <= 8 && length <= 40) return [start + grown, size]
        if (start <= 40 && end <= 40) return [start, size + grown]
        const k = whole ? now / whole : 1
        return [start * k, size * k]
    }

    // a rect the scan saw (from the bottom left) as drawn: x, y from the top left, width, height
    function previewBox(r) {
        const f = viewRect || [0, 0, 0, 0]
        return [r[0] - f[0], f[1] + f[3] - r[1] - r[3], r[2], r[3]]
    }
    // where a text goes in its box. (Drawn smaller than in the game: a box as wide as
    // its text, the text in its middle.)
    function justifyOf(p, width) { return Math.abs(width - (p.textWidth || 0)) < 1 ? "CENTER" : p.justify || "LEFT" }
    // what a part says in the tab shown (a scan from before these were saved: all it has)
    function wordsOf(p) {
        return p.words && view_ && view_.worded ? p.words[view_.key] || "" : p.text || ""
    }
    // the texts of what's only to be seen (a bag's counts, a list's rows)
    property var previewTexts: []
    property int previewCount: 0
    function previewUpdate() {
        const texts = []
        let count = 0
        for (const n in parts) {
            const p = parts[n]
            if (!p.preview || !inView(n) || (view_ && p.current && !p.current[view_.key])) continue
            count++
            const words = wordsOf(p)
            if (p.kind === "FontString" && words && p.rect) {
                const r = previewBox(p.rect)
                if (!p.faded) texts.push({ words: words, look: p, x: r[0], y: r[1], width: r[2], height: r[3], align: justifyOf(p, r[2]) })
            }
        }
        previewTexts = texts
        previewCount = count
    }

    // one of its tabs: only what shows in it (a part seen in no tab, in all)
    function showView(index) {
        artModel = []
        viewIndex = index
        artModel = (view_ ? view_.art : windowData.art) || []
        previewUpdate()
        applyShown()
        if (picked && !(items[picked] && items[picked].shown)) pick("")
        listModelUpdate()
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
        for (const n in parts) if (items[n]) {
            // (only what the last look at this tab saw: the rest stays to pick)
            if (!parts[n].preview) { // (a preview's may be a Ghost)
                items[n].shown = shown[kindOf(parts[n].kind)] && inView(n)
                items[n].wordless = !!parts[n].faded || !!(view_ && parts[n].current && !parts[n].current[view_.key])
                items[n].text = wordsOf(parts[n])
            }
        }
    }

    // ---- a part's anchors, live
    readonly property var marginOf: ({ left: ["leftMargin", 1], right: ["rightMargin", -1], horizontalCenter: ["horizontalCenterOffset", 1],
        top: ["topMargin", -1], bottom: ["bottomMargin", 1], verticalCenter: ["verticalCenterOffset", -1] })

    // a part where it's told: inside what it's placed on, by its anchors (a row places its own)
    function applyItem(name) {
        const item = items[name], e = entry(name)
        if (!item) return
        const anchors = item.anchors, target = e.place && items[e.place[1]]
        if (target && !rowOf(name)) {
            const x = lineX(e.place[0]), y = lineY(e.place[0])
            const x2 = e.second ? lineX(e.second[0]) : x, y2 = e.second ? lineY(e.second[0]) : y // (stretched: its other side)
            const moving = item.parent !== target && item.parent !== target.parent // (a button next to another: its sibling)
            for (const line of ["left", "right", "horizontalCenter", "top", "bottom", "verticalCenter"])
                if (moving || (line !== x && line !== y && line !== x2 && line !== y2)) { anchors[line] = undefined; anchors[marginOf[line][0]] = 0 }
            if (moving) item.parent = target
            anchors[x] = target[lineX(e.place[2])]
            anchors[y] = target[lineY(e.place[2])]
            anchors[marginOf[x][0]] = e.place[3] * marginOf[x][1]
            anchors[marginOf[y][0]] = e.place[4] * marginOf[y][1]
            if (x2 !== x) { anchors[x2] = target[lineX(e.second[1])]; anchors[marginOf[x2][0]] = e.second[2] * marginOf[x2][1] }
            if (y2 !== y) { anchors[y2] = target[lineY(e.second[1])]; anchors[marginOf[y2][0]] = e.second[3] * marginOf[y2][1] }
        }
        if (e.size && !rowOf(name)) { item.width = e.size[0]; item.height = e.size[1] }
        item.pin = e.pin
        item.changed = !!edits[name]
        Qt.callLater(bumpMoved)
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
        if (name === picked || sizer(picked) === name) pickedEntry = pickedNow()
        if (!quiet) changed()
    }

    // what the panel says of the picked part (one that follows another: its size now)
    function pickedNow() {
        const e = entry(picked), item = items[picked]
        return follows[picked] && !edits[picked] && e.size ? Object.assign({}, e, { size: [roundTenth(item.width), roundTenth(item.height)] }) : e
    }

    // ---- sizing, by a handle or a number
    // What a part hangs from, under it or right of it, gives up the room it takes:
    // the gap between them stays, and its far side doesn't move.
    function giving(name, side) {
        const place = placeOf(name), on = place[1]
        const fraction = side === "above" ? fractionY : fractionX
        if (!parts[on] || rowOf(on) || fraction(place[0]) !== 0 || fraction(place[2]) !== 1) return null
        const e = entry(on)
        return e.size && !e.second ? { name: on, place: placeOf(on).slice(), size: e.size.slice() } : null
    }
    function sizeStart(name) {
        const e = entry(name)
        return e.size ? { name: name, place: placeOf(name).slice(), w: e.size[0], h: e.size[1], above: giving(name, "above"), beside: giving(name, "beside") } : null
    }
    // `fx`, `fy`: the side that moves (0 its left or top, 1 its right or bottom, .5 neither)
    function sizeTo(s, w, h, fx, fy) {
        const above = fy === 0 ? s.above : null, beside = fx === 0 ? s.beside : null
        if (above) h = Math.min(h, s.h + above.size[1] - 16)
        if (beside) w = Math.min(w, s.w + beside.size[0] - 16)
        const px = fractionX(s.place[0]), py = fractionY(s.place[0]), place = s.place.slice()
        // (the side across from the handle stays: its point goes with what's between)
        place[3] = roundTenth(s.place[3] + (beside ? 0 : fx === 0 ? (s.w - w) + px * (w - s.w) : fx === 1 ? px * (w - s.w) : 0))
        place[4] = roundTenth(s.place[4] - (above ? 0 : fy === 0 ? (s.h - h) + py * (h - s.h) : fy === 1 ? py * (h - s.h) : 0))
        if (above) change(above.name, above.place, [above.size[0], above.size[1] - (h - s.h)], true)
        if (beside) change(beside.name, beside.place, [beside.size[0] - (w - s.w), beside.size[1]], true)
        change(s.name, place, [w, h], true)
    }
    function sizeBy(name, dw, dh) {
        const s = sizeStart(sizer(name))
        if (!s) return
        remember()
        sizeTo(s, Math.max(1, s.w + dw), Math.max(1, s.h + dh), dw && s.beside ? 0 : .5, dh && s.above ? 0 : .5)
        changed()
    }

    function changed() {
        backend.keep(JSON.stringify(edits))
        listModelUpdate()
    }

    function restore(text) {
        const before = edits
        edits = JSON.parse(text)
        for (const n in Object.assign({}, before, edits)) if (parts[n]) applyItem(n)
        for (const row of (windowData && windowData.rows) || []) applyRow(row)
        drawSample()
        if (picked) pickedEntry = pickedNow()
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

    // ---- the rows: as told here, windows/WowRow.qml works out their parts
    readonly property var pickedRow: {
        const row = picked && parts[picked] ? rowOf(picked) : null
        return row ? rowNow(row) : null
    }
    readonly property bool pickedHeld: !!pickedRow || !!(pickedEntry && pickedEntry.second) // (not dragged, no handles: its row or its sides place it)
    function rowOf(name) {
        const row = parts[name] && parts[name].inRow
        return row ? (windowData.rows || []).filter(r => r.name === row)[0] || null : null
    }
    function rowEdit(row) {
        const rows = edits["@rows"], mine = rows && rows[title_]
        return (mine && mine[row.name]) || null
    }
    function rowNow(row) {
        const edit = rowEdit(row)
        return edit ? Object.assign({}, row, edit, { spacing: edit.spacing }) : row
    }
    function applyRow(row) {
        const item = items[row.name], now = rowNow(row), line = marginOf[lineY(row.point)]
        item.fit = now.fit
        item.spacing = now.spacing === undefined || now.spacing === null ? row.gap : now.spacing
        item.anchors.leftMargin = now.left
        item.anchors.rightMargin = now.right
        item.anchors[line[0]] = now.y * line[1]
        item.place()
        for (const n of row.parts) if (items[n]) items[n].changed = !!rowEdit(row)
        Qt.callLater(bumpMoved)
    }
    // `changes` (fit, spacing, left, right, y) to a row. Quiet: while dragged.
    function setRow(row, changes, quiet) {
        if (!quiet) remember()
        const file = (windowData.rows || []).filter(r => r.name === row.name)[0]
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
        applyRow(file)
        if (picked) pickedEntry = entry(picked)
        if (!quiet) changed()
    }
    function resetRow(row) {
        const file = (windowData.rows || []).filter(r => r.name === row.name)[0]
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
        drawSample()
        changed()
    }
    function resetComponent(name) {
        if (!componentEdited(name)) return
        remember()
        const copy = JSON.parse(JSON.stringify(edits))
        delete copy["@components"][name]
        if (!Object.keys(copy["@components"]).length) delete copy["@components"]
        edits = copy
        drawSample()
        changed()
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
        if (name && parts[name] && parts[name].preview) return // (only to be seen)
        if (name) componentsMode = false // (a part picked: its own panel)
        picked = name
        pickedEntry = name ? pickedNow() : null
        if (name) unfoldTo(name)
        const at = listModel.indexOf(name)
        if (at >= 0) list.positionViewAtIndex(at, ListView.Contain)
        const on = pickedEntry && pickedEntry.place && pickedEntry.place[1]
        for (const n in items) {
            if (items[n].picked !== undefined) {
                items[n].picked = n === name
                items[n].placedOn = n === on
            }
        }
    }

    function partsAt(x, y) {
        const hits = []
        for (const n in parts) {
            if (!items[n] || parts[n].preview || !items[n].shown) continue
            const r = rectOf(n)
            if (x >= r[0] && x <= r[0] + r[2] && y >= r[1] && y <= r[1] + r[3]) hits.push(n)
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
        const r = rectOf(name), t = rectOf(rel)
        return [point, rel, relPoint,
            roundTenth(r[0] + fractionX(point) * r[2] - t[0] - fractionX(relPoint) * t[2]),
            roundTenth(-(r[1] + fractionY(point) * r[3] - t[1] - fractionY(relPoint) * t[3]))]
    }

    // is `p` (in the view) on the picked part's handles or dots?
    readonly property real handleGap: 24
    function overControls(p) {
        if (!pickedItem || componentsMode) return false
        const at = toRoot(p), near = 8 / content.scale, gap = handleGap / content.scale
        if (pickedRow) { // (only its ends' handles)
            const r = rectOf(pickedRow.name), y = r[1] + r[3] / 2
            return Math.hypot(at.x - r[0] + gap / 2, at.y - y) < near || Math.hypot(at.x - r[0] - r[2] - gap / 2, at.y - y) < near
        }
        if (pickedHeld) return false
        const r = rectOf(picked)
        for (const fx of [0, .5, 1]) {
            for (const fy of [0, .5, 1]) {
                const x = r[0] + fx * r[2], y = r[1] + fy * r[3]
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
        const w = (view_ && view_.window) || (windowData && windowData.window), f = viewRect
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
        if (alone) return [x, y]
        const box = rectOf(name), reach = 5 / content.scale, row = rowOf(name)
        let bestX = row ? -1 : reach, bestY = reach, dx = 0, dy = 0 // (a row goes up and down only)
        // (not what goes with it: what's in it, its row's)
        const moving = row ? row.name : name
        const candidates = Object.keys(parts).filter(n => items[n] && items[n].shown && !parts[n].preview && !under(n, moving))
        candidates.push(title_)
        for (const n of candidates) {
            const o = rectOf(n)
            for (const a of [x, x + box[2] / 2, x + box[2]]) {
                for (const b of [o[0], o[0] + o[2] / 2, o[0] + o[2]]) {
                    if (Math.abs(b - a) < bestX) { bestX = Math.abs(b - a); dx = b - a; guideX = b }
                }
            }
            for (const a of [y, y + box[3] / 2, y + box[3]]) {
                for (const b of [o[1], o[1] + o[3] / 2, o[1] + o[3]]) {
                    if (Math.abs(b - a) < bestY) { bestY = Math.abs(b - a); dy = b - a; guideY = b }
                }
            }
        }
        return [x + dx, y + dy]
    }

    // ---- the list
    // (the window's tree: each part under what it's placed on, folded but for
    // what's been opened; a search shows what's found, under what it's in)
    property var listModel: []       // the rows shown, their names
    property var listInfo: ({})      // by name: { depth, kids, open, over }
    property var unfolded: ({})
    property var artModel: []
    // the parts in `item`: a row's and a Ghost's as if its own
    function partsIn(item) {
        const out = []
        for (let i = 0; i < item.children.length; i++) {
            const child = item.children[i]
            if (child.name === undefined) continue
            if (parts[child.name]) out.push(child)
            else out.push(...partsIn(child))
        }
        return out.sort((a, b) => a.name < b.name ? -1 : 1)
    }
    function listModelUpdate() {
        if (!root) return
        const q = find.text.toLowerCase(), out = [], info = {}
        const found = n => !q || n.toLowerCase().indexOf(q) >= 0 || (parts[n].text || "").toLowerCase().indexOf(q) >= 0
        const seen = n => shown[kindOf(parts[n].kind)] && inView(n) && found(n)
        // (what's not in this tab stays, for what's on it that is)
        const add = (item, depth, over) => {
            const n = item.name, at = out.length
            out.push(n)
            const open = !!q || !!unfolded[n]
            let kids = 0
            for (const child of partsIn(item)) {
                const before = out.length
                if (add(child, depth + 1, n)) kids++
                if (!open) out.length = before
            }
            if (!kids && !seen(n)) { out.length = at; return false }
            info[n] = { depth: depth, kids: kids, open: open, over: over }
            return true
        }
        for (const child of partsIn(root)) add(child, 0, "")
        listInfo = info
        listModel = out
    }
    function unfoldTo(name) {
        let any = false
        for (let up = items[name] && items[name].parent; up && up !== root; up = up.parent) {
            if (parts[up.name] && !unfolded[up.name]) { unfolded[up.name] = true; any = true }
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
    // its name without what it's in's, which is just above it; its text
    function listText(name) {
        const p = parts[name] || {}, over = (listInfo[name] || {}).over
        const inIt = over && name.indexOf(over) === 0 && name.length > over.length
        return (inIt ? name.slice(over.length) : name) + (p.text ? "  “" + p.text + "”" : "")
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
            if (e.size) sizeBy(picked, across * step, up * step)
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
                            text: (app.edits[modelData] ? "● " : "") + (app.parts[modelData] && app.parts[modelData].pin ? "◆ " : "") + app.listText(modelData)
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
            Label {
                objectName: "previewNote"
                visible: !app.componentsMode && app.previewCount > 0
                Layout.fillWidth: true; Layout.margins: 8; Layout.topMargin: 0
                wrapMode: Text.Wrap
                color: app.dim
                font.pixelSize: 11
                text: app.previewCount + " more only to be seen: what's in a bag, the other rows of a list."
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
                            readonly property string ownerName: app.artOwner(modelData.owner)
                            readonly property Item owner: ownerName ? app.items[ownerName] || null : null
                            // (where its part was when the scan drew it, not where it's saved to be since)
                            readonly property var base: !owner ? null : app.parts[ownerName].rect ? app.previewBox(app.parts[ownerName].rect) : app.artBase[ownerName]
                            readonly property var at: { void app.moved; return owner && owner.parent ? owner.mapToItem(app.root, 0, 0) : null }
                            readonly property real ax: modelData.rect[0] - f[0]
                            readonly property real ay: (f[1] + f[3]) - (modelData.rect[1] + modelData.rect[3])
                            // (sized with its part if it's on it: a tab can draw it elsewhere)
                            readonly property bool drawnOnIt: !!(owner && base) && ax + modelData.rect[2] / 2 >= base[0] && ax + modelData.rect[2] / 2 <= base[0] + base[2]
                                && ay + modelData.rect[3] / 2 >= base[1] && ay + modelData.rect[3] / 2 <= base[1] + base[3]
                            readonly property var spanX: drawnOnIt ? app.artSpan(ax - base[0], modelData.rect[2], base[2], owner.width) : [ax - (base ? base[0] : 0), modelData.rect[2]]
                            readonly property var spanY: drawnOnIt ? app.artSpan(ay - base[1], modelData.rect[3], base[3], owner.height) : [ay - (base ? base[1] : 0), modelData.rect[3]]
                            // (a row's, under a list made shorter)
                            readonly property bool cut: !!(modelData.owner && app.parts[modelData.owner] && app.parts[modelData.owner].preview) && app.cutOff(ax, ay, modelData.rect[2], modelData.rect[3])
                            visible: showArt.checked && !cut && !app.thumbPast(modelData.owner || "", ay, modelData.rect[3])
                            x: at && base ? at.x + spanX[0] : ax
                            y: at && base ? at.y + spanY[0] : ay
                            width: spanX[1]
                            height: spanY[1]
                            opacity: (modelData.alpha === undefined ? 1 : modelData.alpha) * (modelData.backdrop || !modelData.color ? 1 : modelData.color[3])
                            source: "image://art/" + app.windowData.generation + "/" + app.title_ + "/" + app.viewIndex + "/" + index
                            cache: false
                            smooth: true
                        }
                    }
                    // what's only to be seen: its texts
                    Repeater {
                        model: app.previewTexts
                        Game.GameText {
                            required property var modelData
                            visible: !!app.shown.FontString && !app.cutOff(modelData.x, modelData.y, modelData.width, modelData.height)
                            x: modelData.x; y: modelData.y
                            width: modelData.width; height: modelData.height
                            words: modelData.words
                            look: modelData.look
                            horizontalAlignment: modelData.align === "CENTER" ? Text.AlignHCenter : modelData.align === "RIGHT" ? Text.AlignRight : Text.AlignLeft
                        }
                    }
                    Item { id: holder }

                    // the hovered part (drawn in it, it goes with it)
                    Rectangle {
                        parent: app.hoveredItem || holder
                        visible: !!app.hoveredItem
                        anchors.fill: parent
                        z: 90
                        color: "#18ffffff"
                        border.color: "#ffffff"; border.width: 1 / content.scale
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
                        parent: app.pickedItem || holder
                        visible: !!app.pickedItem
                        anchors.fill: parent
                        z: 100

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
                                            parent.start = app.sizeStart(app.sizer(app.picked))
                                            if (parent.start) { parent.start.x0 = centroid.scenePosition.x; parent.start.y0 = centroid.scenePosition.y }
                                        } else app.changed()
                                    }
                                    onCentroidChanged: {
                                        if (!active || !parent.start) return
                                        const s = parent.start, fx = parent.modelData[0], fy = parent.modelData[1]
                                        const dx = (centroid.scenePosition.x - s.x0) / content.scale, dy = (centroid.scenePosition.y - s.y0) / content.scale
                                        const w = Math.max(1, Math.round(s.w + (fx === 1 ? dx : fx === 0 ? -dx : 0)))
                                        const h = Math.max(1, Math.round(s.h + (fy === 1 ? dy : fy === 0 ? -dy : 0)))
                                        app.sizeTo(s, w, h, fx, fy)
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
                        parent: (row && app.items[row.name]) || holder
                        visible: !!row
                        anchors.fill: parent
                        z: 100
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
                            const r = app.rectOf(app.picked)
                            point = p
                            from = Qt.point(r[0] + app.fractionX(p) * r[2], r[1] + app.fractionY(p) * r[3])
                            to = from
                            target = ""
                            active = true
                        }
                        function moved(scene) {
                            const local = content.mapFromItem(null, scene.x, scene.y)
                            to = local
                            let best = 14 / content.scale, name = "", at = ""
                            // (not what's in it: it would be in itself)
                            for (const n in app.items) {
                                if (n === app.picked || app.isRow(n) || app.items[n].shown === false || app.under(n, app.picked)) continue
                                const o = app.rectOf(n)
                                for (const q of app.pointNames) {
                                    const d = Math.hypot(o[0] + app.fractionX(q) * o[2] - local.x, o[1] + app.fractionY(q) * o[3] - local.y)
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
                            readonly property var o: drop.target ? app.rectOf(drop.target) : null
                            width: 13 / content.scale; height: width; radius: width / 2
                            x: o ? o[0] + app.fractionX(drop.targetPoint) * o[2] - width / 2 : 0
                            y: o ? o[1] + app.fractionY(drop.targetPoint) * o[3] - height / 2 : 0
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
                    const r = app.rectOf(name), e = app.entry(name), row = app.rowOf(name)
                    if (e.second && !row) {
                        app.status = name + " is stretched: its sides are in its panel."
                        start = null
                        return
                    }
                    app.remember()
                    if (row) { // (the whole row, up and down)
                        start = { row: row.name, rowY: app.rowNow(row).y, name: name, press: press, x: r[0], y: r[1] }
                        return
                    }
                    start = { move: true, name: name, press: press, place: app.placeOf(name).slice(), size: e.size, x: r[0], y: r[1] }
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
                                    Layout.preferredWidth: 48; Layout.preferredHeight: 22
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
                    Layout.fillWidth: true; Layout.leftMargin: 10; Layout.rightMargin: 10
                    readonly property var place: app.pickedEntry ? app.pickedEntry.place : null
                    readonly property var size: app.pickedEntry ? app.pickedEntry.size : null
                    readonly property var second: app.pickedEntry ? app.pickedEntry.second || null : null
                    readonly property bool across: !!(second && place && app.lineX(second[0]) !== app.lineX(place[0]))
                    readonly property bool down: !!(second && place && app.lineY(second[0]) !== app.lineY(place[0]))
                    function numbers() {
                        const e = app.entry(app.picked), place = app.placeOf(app.picked).slice()
                        // (a size: what it's sized by, and what gives up the room)
                        const shown = app.pickedEntry.size
                        if (!second && shown && (fw.value / 10 !== shown[0] || fh.value / 10 !== shown[1])) {
                            app.sizeBy(app.picked, fw.value / 10 - shown[0], fh.value / 10 - shown[1])
                            return
                        }
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

                    Button {
                        objectName: "placedOn"
                        Layout.columnSpan: 2; Layout.fillWidth: true
                        flat: true
                        enabled: !!(fields.place && app.parts[fields.place[1]])
                        font.family: app.plain
                        text: fields.place ? "In " + fields.place[1] + (fields.place[0] === fields.place[2] ? "" : "  (" + fields.place[0] + " to " + fields.place[2] + ")") : "Not placed"
                        onClicked: app.pick(fields.place[1])
                        ToolTip.visible: hovered
                        ToolTip.delay: 400
                        ToolTip.text: "Pick it. To place this part in another, drag one of its dots there"
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
            if (app.changeCount) { app.status = "A new scan or window file: Save, and it's read."; return }
            app.reload()
        }
    }

    Component.onCompleted: {
        const list_ = windowPick.model
        if (list_.length) Qt.callLater(() => openWindow(list_.indexOf(settings.lastWindow) >= 0 ? settings.lastWindow : list_[0]))
    }
}
