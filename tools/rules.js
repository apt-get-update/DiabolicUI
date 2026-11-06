.pragma library
// The windows' rules, checked in the editor as parts move (tools/editor.qml):
// buttons on a row too close, a button's text wider than it, the band's
// controls over each other, parts out of the window, the content too close to
// the band or the foot or its room uneven, its zones too close or almost lined
// up, a list's column names off its zone, a dropdown not Diablo III's, light
// text on parchment, edges between screen pixels. Only named parts are seen.
//
// check(model): the problems, each { text, parts }. model: { parts: { [name]:
// { left, top, right, bottom (y down) and what /dui layout saved: kind, text,
// written, faded, own, hung, chain, parent, control, dropdown, diablo, zone,
// material, edge, row, textWidth, justify, inset, light, onArt, onLit } }, view:
// { frame, band, foot, railOver, close, iron, scale (of a window the game scales) },
// rules: { button_gap, content_gap, uneven }, unit (screen pixels per unit),
// origin: [ left, top ] on screen }.

var LIGHT = { parchment: true, lined: true, page: true } // the materials read in ink
var COLUMN_NAMES = [/Sort$/, /ColumnHeader\d+$/, /_Heading_Button$/]

function round(v) { return Math.floor(v + .5) }

function named(p) { return p.text ? '"' + p.text + '"' : p.name }

// Where a part's art is: a text's letters, a dropdown's plate.
function box(p) {
    var left = p.left, right = p.right
    if (p.kind === "FontString") {
        // (a wrapped one's string width is its one line's: its box's at most)
        var width = Math.min(p.textWidth === undefined ? right - left : p.textWidth, right - left)
        if (p.justify === "LEFT") right = left + width
        else if (p.justify === "RIGHT") left = right - width
        else {
            var middle = (left + right) / 2
            left = middle - width / 2
            right = middle + width / 2
        }
    } else if (p.inset) {
        left += p.inset[0]
        right -= p.inset[1]
    }
    return { left: left, top: p.top, right: right, bottom: p.bottom, part: p }
}

function overlap(a, b) {
    var across = Math.min(a.right, b.right) - Math.max(a.left, b.left)
    var down = Math.min(a.bottom, b.bottom) - Math.max(a.top, b.top)
    return Math.max(0, Math.min(across, down))
}

function isIn(a, b) { return (a.chain || []).indexOf(b.name) >= 0 }

function sameFrame(a, b) { return a.zone === b.zone }

function check(model) {
    var out = []
    var seen = {}
    function say(text, parts) {
        if (!seen[text]) {
            seen[text] = true
            out.push({ text: text, parts: parts })
        }
    }
    var parts = model.parts, view = model.view || {}, rules = model.rules
    var all = Object.keys(parts).map(function (name) {
        var p = Object.assign({}, parts[name])
        p.name = name
        return p
    })
    var win = view.frame && parts[view.frame]
    if (!win || !rules) return out
    win = all.filter(function (p) { return p.name === view.frame })[0]
    function named_(name) { return all.filter(function (p) { return p.name === name })[0] }
    var band = view.band ? named_(view.band) : null
    var close = view.close ? named_(view.close) : null
    var foot = view.foot ? named_(view.foot) : null
    var controls = all.filter(function (p) { return p.control && !p.own && !p.faded })
    var texts = all.filter(function (p) { return p.kind === "FontString" && p.written && !p.own && !p.faded })
    var zones = all.filter(function (p) { return p.zone })
    var inner = zones.filter(function (z) {
        return !zones.some(function (o) {
            return o !== z && o.left >= z.left - 1 && o.right <= z.right + 1 && o.top >= z.top - 1 && o.bottom <= z.bottom + 1
        })
    })
    var byName = {}
    all.forEach(function (p) { byName[p.name] = p })

    // (out past the window on purpose: a banner, a scroll frame's, a tooltip's, a popup beside it)
    function isHung(p) {
        return p.hung || (p.chain || []).some(function (name) {
            var o = byName[name]
            if (!o) return false
            var x = (o.left + o.right) / 2, y = (o.top + o.bottom) / 2
            return o.kind !== "FontString" && (x > win.right || x < win.left || y < win.top || y > win.bottom)
        })
    }

    // Rows: buttons on a row closer than the rule, a button's text wider than it.
    var row = all.filter(function (p) { return p.row }).sort(function (a, b) { return a.left - b.left })
    row.forEach(function (a, i) {
        if (a.textWidth > a.right - a.left - 2) say(named(a) + "'s text is wider than it.", [a.name])
        for (var j = i + 1; j < row.length; j++) {
            var b = row[j]
            if (Math.abs((b.top + b.bottom - a.top - a.bottom) / 2) <= 4) {
                var off = round(Math.abs(b.top - a.top))
                if (off >= 1) say(named(a) + " and " + named(b) + " are " + off + " off their row.", [a.name, b.name])
                var apart = b.left - a.right
                if (apart < rules.button_gap - .5) say(named(a) + " and " + named(b) + " are " + round(apart) + " apart on their row (the rule: " + rules.button_gap + ").", [a.name, b.name])
                break
            }
        }
    })

    // Band: its controls and texts over each other, the title, the X. (Not what
    // scrolls: a list's row past its top is cut off at its scroll frame's edge.)
    function scrolls(p) {
        return (p.chain || []).some(function (name) { return byName[name] && byName[name].kind === "ScrollFrame" })
    }
    if (band) {
        var inBand = []
        controls.concat(texts).concat(close ? [close] : [])
            .concat(all.filter(function (p) { return p.kind === "FontString" && p.written && p.parent === band.name }))
            .forEach(function (p) {
                var b = box(p), middle = (b.top + b.bottom) / 2
                if (middle > band.top && middle < band.bottom && !scrolls(p) && !inBand.some(function (o) { return o.part === p })) inBand.push(b)
            })
        inBand.forEach(function (a, i) {
            inBand.slice(i + 1).forEach(function (b) {
                if (!isIn(a.part, b.part) && !isIn(b.part, a.part) && overlap(a, b) > 1)
                    say(named(a.part) + " and " + named(b.part) + " overlap in the band.", [a.part.name, b.part.name])
            })
        })
    }

    // Inside: parts past the window's sides.
    controls.concat(texts).forEach(function (p) {
        if (p === close || isHung(p)) return
        var b = box(p)
        if (b.left < win.left - 1 || b.right > win.right + 1 || b.top < win.top - 1 || b.bottom > win.bottom + 1)
            say(named(p) + " is out of the window.", [p.name])
    })

    if (zones.length) {
        // Room: over the content (under the band, or the tabs under it) and
        // under it (over the foot): at least the rule's, and even.
        var topZone = zones[0], bottomZone = zones[0]
        zones.forEach(function (z) {
            if (z.top < topZone.top) topZone = z
            if (z.bottom > bottomZone.bottom) bottomZone = z
        })
        var top = topZone.top, bottom = bottomZone.bottom
        var above = band ? band.bottom : win.top + (view.iron || 0), aboveName = band ? "the band" : "the iron"
        var between = controls.concat(texts).map(box)
        between.forEach(function (b) {
            if (b.bottom <= top + 1 && b.top >= above - 1 && b.bottom > above) {
                above = b.bottom
                aboveName = named(b.part)
            }
        })
        var over = round(top - above), under = null
        if (foot) {
            // (or the highest part between: the letter's attachments, money)
            var below = foot.top - (view.railOver || 0)
            between.forEach(function (b) {
                if (b.top >= bottom - 1 && b.bottom <= below + 1 && b.top < below) below = b.top
            })
            under = round(below - bottom)
        }
        if (over < rules.content_gap) say(topZone.zone + " is " + over + " under " + aboveName + " (the rule: at least " + rules.content_gap + ").", [topZone.name])
        if (under !== null && under < rules.content_gap) say(bottomZone.zone + " is " + under + " over the foot (the rule: at least " + rules.content_gap + ").", [bottomZone.name])
        if (under !== null && Math.abs(over - under) > rules.uneven) say(over + " of room over the content, " + under + " under it: uneven.", [topZone.name, bottomZone.name])

        // Sides: as much room left of the content (its zones, their scroll
        // bars, what's marked an edge) as right of it.
        var left = Infinity, right = -Infinity
        function reach(p) {
            left = Math.min(left, p.left)
            right = Math.max(right, p.right)
        }
        zones.forEach(reach)
        all.filter(function (p) { return p.edge }).forEach(reach)
        all.filter(function (p) { return p.kind === "Slider" && !isHung(p) }).forEach(function (bar) {
            reach(bar)
            all.filter(function (p) { return p.parent === bar.name }).forEach(reach)
        })
        var before = round(left - win.left), after = round(win.right - right)
        if (Math.abs(before - after) > rules.uneven) say(before + " of room left of the content, " + after + " right of it: uneven.", [])

        // Gaps and Align: the zones seen, apart by the rule's at least, their
        // edges not 1 to 3 off lining up.
        var EDGES = [["left", "left edges"], ["bottom", "bottoms"], ["right", "right edges"], ["top", "tops"]]
        inner.forEach(function (a, i) {
            inner.slice(i + 1).forEach(function (b) {
                if (sameFrame(a, b)) return
                if (!isIn(a, b) && !isIn(b, a)) {
                    var across = Math.max(a.left - b.right, b.left - a.right)
                    var down = Math.max(a.top - b.bottom, b.top - a.bottom)
                    if (across < -1 && down < -1) say(a.zone + " and " + b.zone + " overlap by " + round(-Math.max(across, down)) + ".", [a.name, b.name])
                    else {
                        var apart = Math.max(across, down)
                        if (apart < rules.content_gap - .5) say(a.zone + " and " + b.zone + " are " + round(apart) + " apart (the rule: at least " + rules.content_gap + ").", [a.name, b.name])
                    }
                }
                for (var e = 0; e < EDGES.length; e++) {
                    var off = Math.abs(a[EDGES[e][0]] - b[EDGES[e][0]])
                    if (off > .5 && off <= 3) {
                        say(a.zone + " and " + b.zone + " are " + round(off) + " off lining up (their " + EDGES[e][1] + ").", [a.name, b.name])
                        break
                    }
                }
            })
        })

        // Headers: a list's column names on its zone.
        controls.forEach(function (c) {
            if (COLUMN_NAMES.some(function (re) { return re.test(c.name) })
                && !zones.some(function (z) { return c.left >= z.left - 1 && c.right <= z.right + 1 && c.top >= z.top - 1 && c.bottom <= z.bottom + 1 }))
                say(named(c) + " is off its list's panel.", [c.name])
        })

        // Ink: light text on parchment, not on a chosen row's bar or its own art.
        var pages = zones.filter(function (z) { return LIGHT[z.material] })
        var light = texts.filter(function (t) {
            var b = box(t), x = (b.left + b.right) / 2, y = (b.top + b.bottom) / 2
            return t.light && !t.onLit && !t.onArt && pages.some(function (z) { return x >= z.left && x <= z.right && y >= z.top && y <= z.bottom })
        })
        if (light.length > 1) say(named(light[0]) + " and " + (light.length - 1) + " more are light on parchment: hard to read.", light.map(function (t) { return t.name }))
        else if (light.length) say(named(light[0]) + " is light on parchment: hard to read.", [light[0].name])
    }

    // DropDowns: still Blizzard's (or an addon's), not on Diablo III's plate.
    controls.forEach(function (c) {
        if (c.dropdown && !c.diablo) say(c.name + " isn't Diablo III's.", [c.name])
    })

    // Pixels: edges between screen pixels, when the UI's scale puts its units on whole pixels.
    var unit = model.unit
    if (unit && Math.abs(unit - round(unit)) <= .02 && model.origin) {
        var checked = [win].concat(band ? [band] : []).concat(foot ? [foot] : []).concat(zones).concat(controls)
        var count = 0, total = 0, worst = 0, worstPart = null
        checked.forEach(function (p) {
            total++
            var most = 0
            var s = view.scale || 1
            var edges = [model.origin[0] + p.left * s, model.origin[1] - p.top * s, model.origin[0] + p.right * s, model.origin[1] - p.bottom * s]
            edges.forEach(function (edge) {
                var at = edge * unit
                most = Math.max(most, Math.abs(at - round(at)))
            })
            if (most > .1) {
                count++
                if (most > worst) {
                    worst = most
                    worstPart = p
                }
            }
        })
        if (count) say(count + " of " + total + " parts are between screen pixels (" + (worstPart === win ? "the window" : worstPart.zone || worstPart.name) + " by " + worst.toFixed(1) + "): blurry edges.", [worstPart.name])
    }
    return out
}
