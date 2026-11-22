#!/usr/bin/env python3
"""Every window and tab against the rules, as the editor draws them (its Rules
button; docs: Windows Editor), and their pictures. Offscreen: nothing in the
addon written (the scan read into a copy of windows/).

  tools/check.py [window...]            what breaks a rule; exit 1 if anything
  tools/check.py --marked [window...]   and each tab that breaks one drawn, the
                                        parts marked, into tools/pictures/marked
  tools/check.py --pictures [window...] each tab drawn into tools/pictures/new;
                                        those not as kept: tools/pictures/changed.png
  tools/check.py --keep                 the new pictures kept (tools/pictures/kept)
  --scan <saved variables>              another scan than the newest (the test realm's)
"""
import json
import os
import shutil
import subprocess
import sys
import tempfile
import time

os.environ["QT_QPA_PLATFORM"] = "offscreen"
os.environ["QT_QUICK_BACKEND"] = "software"
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, "tools"))
os.chdir(ROOT)
PICTURES = os.path.join(ROOT, "tools", "pictures")

import editor  # noqa: E402
from PySide6.QtCore import QCoreApplication, QEvent, QMetaObject, QObject, QPointF, QRect, Q_ARG  # noqa: E402
from PySide6.QtGui import QColor, QFont, QGuiApplication, QImage, QPainter  # noqa: E402
from PySide6.QtQml import QQmlApplicationEngine  # noqa: E402
from PySide6.QtQuickControls2 import QQuickStyle  # noqa: E402


def arguments():
    args, scan, mode = sys.argv[1:], "", "check"
    if "--scan" in args:
        at = args.index("--scan")
        scan = args[at + 1]
        del args[at:at + 2]
    for flag in ("--pictures", "--keep", "--marked"):
        if flag in args:
            mode = flag[2:]
            args.remove(flag)
    return mode, scan, args


def keep():
    new, kept = os.path.join(PICTURES, "new"), os.path.join(PICTURES, "kept")
    if not os.path.isdir(new):
        sys.exit("No new pictures: tools/check.py --pictures first")
    shutil.rmtree(kept, ignore_errors=True)
    shutil.copytree(new, kept)
    print("Kept: %d pictures" % len(os.listdir(kept)))


def load(scan):
    """The editor, offscreen, on a copy of the windows read with the scan."""
    copy = tempfile.mkdtemp(prefix="dui-check-")
    shutil.copytree("windows", os.path.join(copy, "windows"))
    layout = os.path.join(copy, "layout.json")
    done = subprocess.run(["lua5.1", "tools/positions.lua", scan, os.path.join(copy, "positions.lua"), layout,
                           os.path.join(copy, "windows")], capture_output=True, text=True)
    if done.returncode:
        sys.exit(done.stderr.strip())

    def run(self, *_):
        with open(layout, encoding="utf-8") as file:
            self.layout = json.load(file)
        self.seen = self.stamp()
        self.generation += 1
        return ""

    editor.Backend.run = run
    editor.Backend.watchFiles = lambda self: None
    QQuickStyle.setStyle("Fusion")
    app = QGuiApplication(sys.argv[:1])
    app.setOrganizationName("DiabolicUI-check")  # (not the editor's own settings)
    engine = QQmlApplicationEngine()
    backend = editor.Backend()
    backend.engine = engine
    backend.keep = lambda *_: None  # (the editor's unsaved changes left alone)
    backend.kept = lambda *_: "{}"
    engine.addImageProvider("art", editor.Art(backend))
    engine.rootContext().setContextProperty("backend", backend)
    engine.load(os.path.join(ROOT, "tools", "editor.qml"))
    if not engine.rootObjects():
        sys.exit("The editor didn't load")
    win = engine.rootObjects()[0]
    win.setProperty("width", 1800)
    win.setProperty("height", 1300)
    return app, engine, backend, win, copy


def settle(app, n=8):
    for _ in range(n):
        app.processEvents()
        QCoreApplication.sendPostedEvents(None, QEvent.DeferredDelete)
        time.sleep(0.01)


def variant(value):
    return value.toVariant() if hasattr(value, "toVariant") else value


def sheet(changed, out):
    """The pictures changed: before, after, side by side."""
    width, gap, label = 900, 20, 34
    rows = []
    for name in changed:
        before, after = QImage(os.path.join(PICTURES, "kept", name)), QImage(os.path.join(PICTURES, "new", name))
        k = min(1, (width / 2 - gap) / max(before.width(), after.width(), 1))
        rows.append((name, before, after, k, max(before.height(), after.height()) * k))
    image = QImage(width, int(sum(r[4] + label + gap for r in rows)) + gap, QImage.Format_RGB32)
    image.fill(QColor("#141110"))
    painter = QPainter(image)
    painter.setPen(QColor("#e0a640"))
    painter.setFont(QFont("Sans", 13))
    y = gap
    for name, before, after, k, h in rows:
        painter.drawText(10, y + 22, name[:-4] + "   (before | after)")
        y += label
        for x, picture in ((0, before), (width / 2, after)):
            painter.drawImage(QRect(int(x + 10), int(y), int(picture.width() * k), int(picture.height() * k)), picture)
        y += h + gap
    painter.end()
    image.save(out)


def main():
    mode, scan, only = arguments()
    if mode == "keep":
        return keep()
    app, _engine, backend, win, copy = load(scan)
    view = win.findChild(QObject, "view")
    settle(app, 150)
    found, new, marked = {}, os.path.join(PICTURES, "new"), os.path.join(PICTURES, "marked")
    out = new if mode == "pictures" else marked
    if mode in ("pictures", "marked"):
        shutil.rmtree(out, ignore_errors=True)
        os.makedirs(out)
    win.setProperty("marking", mode == "marked")
    for name in sorted(backend.layout["windows"]):
        if only and name not in only:
            continue
        QMetaObject.invokeMethod(win, "openWindow", Q_ARG("QVariant", name))
        settle(app)
        views = variant(win.property("views")) or []
        bands = 0
        for i in range(max(1, len(views))):
            label = (views[i].get("label") if views else "") or ""
            if views:
                QMetaObject.invokeMethod(win, "showView", Q_ARG("QVariant", i))
            settle(app, 4)
            problems = variant(win.property("problems")) or []
            for problem in problems:
                if problem["rule"] == "band":
                    bands += 1
                    continue
                key = (name, problem["part"], problem["text"])
                found.setdefault(key, []).append(label)
            if mode == "pictures" or (mode == "marked" and problems):
                QMetaObject.invokeMethod(win, "fit", Q_ARG("QVariant", False))
                settle(app, 30)
                at = view.mapToItem(None, QPointF(0, 0))
                shot = win.grabWindow().copy(QRect(int(at.x()), int(at.y()), int(view.property("width")), int(view.property("height"))))
                shot.save(os.path.join(out, "%s-%d.png" % (name, i)))
        # (a band empty on every tab: one with something in it on another is needed)
        if bands and bands == max(1, len(views)):
            found[(name, name + "DiabolicBand", "Nothing in its band: band = false (settings/blizzard.lua)")] = []
    shutil.rmtree(copy, ignore_errors=True)
    if mode == "pictures":
        kept = os.path.join(PICTURES, "kept")
        names = sorted(os.listdir(new))
        if not os.path.isdir(kept):
            print("%d pictures drawn: tools/check.py --keep to keep them" % len(names))
            return 0
        changed = [n for n in names if not os.path.exists(os.path.join(kept, n)) or QImage(os.path.join(kept, n)) != QImage(os.path.join(new, n))]
        if changed:
            sheet(changed, os.path.join(PICTURES, "changed.png"))
            print("%d of %d changed: tools/pictures/changed.png (tools/check.py --keep to keep them)" % (len(changed), len(names)))
        else:
            print("%d pictures, none changed" % len(names))
        return 0
    last = None
    for (window, part, text), tabs in sorted(found.items()):
        if window != last:
            print(window)
            last = window
        where = " (" + ", ".join(sorted(set(t or "no tab" for t in tabs))) + ")" if tabs and any(tabs) else ""
        print("    %s: %s%s" % (part, text, where))
    print("Rules: %d broken" % len(found) if found else "Rules: all kept")
    return 1 if found else 0


if __name__ == "__main__":
    sys.exit(main())
