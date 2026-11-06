#!/usr/bin/env python3
"""The windows' editor: windows/*.qml opened as they are, each part to drag.

Run from anywhere: python3 tools/editor.py (needs PySide6, Pillow and lua5.1). It reads
the newest /dui layout scan by itself, again each time the game writes one;
Save writes the changes into windows/*.qml and settings/positions.lua through
tools/positions.lua. This file: that, and our art drawn as the game draws it.
"""
import glob
import json
import os
import subprocess
import sys

import gametextures
from PIL import Image
from PySide6.QtCore import QFileSystemWatcher, QObject, QPointF, QRectF, Qt, QTimer, QUrl, Signal, Slot
from PySide6.QtGui import QBrush, QColor, QGuiApplication, QIcon, QImage, QLinearGradient, QPainter, QPolygonF, QTransform
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuick import QQuickImageProvider
from PySide6.QtQuickControls2 import QQuickStyle

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LAYOUT = "tools/layout.json"
EDITS = "tools/edits.lua"
UNSAVED = "tools/editor-unsaved.json"
SAVED = "../../../WTF/Account/*/SavedVariables/DiabolicUI.lua"
QUALITY = 2  # the art's pixels per unit


def to_lua(value):
    if isinstance(value, dict):
        return "{" + ",".join("[%s]=%s" % (json.dumps(k), to_lua(v)) for k, v in value.items() if v is not None) + "}"
    if isinstance(value, list):
        return "{" + ",".join(to_lua(v) for v in value) + "}"
    return json.dumps(value)


def loaded(file):
    """A picture file (a .tga, a .png) ready to draw, or None."""
    try:
        picture = Image.open(file).convert("RGBA")
    except OSError:
        return None
    image = QImage(picture.tobytes(), picture.width, picture.height, QImage.Format_RGBA8888)
    return image.convertToFormat(QImage.Format_ARGB32_Premultiplied)


def blank(width, height):
    image = QImage(max(1, min(4096, int(width + .999))), max(1, min(4096, int(height + .999))), QImage.Format_ARGB32_Premultiplied)
    image.fill(Qt.transparent)
    return image


def rgb(color):
    return QColor.fromRgbF(min(1, color[0]), min(1, color[1]), min(1, color[2]))


def quad(painter, image, c, x, y, w, h):
    """A texture's corners (ULx, ULy, LLx, LLy, URx, URy, LRx, LRy; past 1: repeated) in a rect."""
    iw, ih = image.width(), image.height()
    u0, v0 = c[0] * iw, c[1] * ih
    ux, vx, uy, vy = (c[4] - c[0]) * iw, (c[5] - c[1]) * ih, (c[2] - c[0]) * iw, (c[3] - c[1]) * ih
    det = ux * vy - uy * vx
    if not det:
        return
    a, cc, b, d = w * vy / det, -w * uy / det, -h * vx / det, h * ux / det
    painter.save()
    painter.setTransform(QTransform(a, b, cc, d, x - (a * u0 + cc * v0), y - (b * u0 + d * v0)))
    painter.setPen(Qt.NoPen)
    painter.setBrush(QBrush(image))
    painter.drawPolygon(QPolygonF([QPointF(u0, v0), QPointF(u0 + ux, v0 + vx), QPointF(u0 + ux + uy, v0 + vx + vy), QPointF(u0 + uy, v0 + vy)]))
    painter.restore()


def tinted(width, height, color, paint, gradient=None):
    """What `paint` draws, colored as the game colors it (its gradient: left to right, bottom to top)."""
    source = blank(width, height)
    painter = QPainter(source)
    painter.setRenderHint(QPainter.SmoothPixmapTransform)
    paint(painter, source.width(), source.height())
    painter.end()
    if not gradient and (not color or min(color[:3]) >= 1):
        return source
    out = QImage(source)
    w, h = out.width(), out.height()
    painter = QPainter(out)
    painter.setCompositionMode(QPainter.CompositionMode_Multiply)
    alpha = None
    if gradient:
        orientation, r1, g1, b1, a1, r2, g2, b2, a2 = gradient
        points = (0, 0, w, 0) if orientation == "HORIZONTAL" else (0, h, 0, 0)
        ramp = QLinearGradient(*points)
        ramp.setColorAt(0, rgb((r1, g1, b1)))
        ramp.setColorAt(1, rgb((r2, g2, b2)))
        painter.fillRect(0, 0, w, h, QBrush(ramp))
        alpha = QLinearGradient(*points)
        alpha.setColorAt(0, QColor.fromRgbF(0, 0, 0, a1))
        alpha.setColorAt(1, QColor.fromRgbF(0, 0, 0, a2))
    else:
        painter.fillRect(0, 0, w, h, rgb(color))
    painter.setCompositionMode(QPainter.CompositionMode_DestinationIn)
    painter.drawImage(0, 0, source)
    if alpha:
        painter.fillRect(0, 0, w, h, QBrush(alpha))
    painter.end()
    return out


class Art(QQuickImageProvider):
    """image://art/<generation>/<window>/<view>/<index>: a piece of a window's art, at its size."""

    def __init__(self, backend):
        super().__init__(QQuickImageProvider.Image)
        self.backend = backend
        self.files = {}

    def picture(self, path):
        if path not in self.files:
            file = gametextures.png(path[5:]) if path.startswith("game/") else path
            self.files[path] = loaded(file) if file else None
        return self.files[path]

    def texture(self, item):
        rect = item["rect"]
        image = None if item["image"] is True else self.picture(item["image"])

        def paint(painter, w, h):
            if image:
                quad(painter, image, item["coords"], 0, 0, w, h)
            elif item["image"] is True:
                painter.fillRect(0, 0, w, h, Qt.white)

        out = tinted(rect[2] * QUALITY, rect[3] * QUALITY, item.get("color"), paint, item.get("gradient"))
        if item.get("blend") == "ADD":  # (what adds nothing shows nothing)
            out.setAlphaChannel(out.convertToFormat(QImage.Format_Grayscale8))
        return out

    def backdrop(self, item):
        rect, b = item["rect"], item["backdrop"]
        k = (item.get("scale") or 1) * QUALITY
        left, right, top, bottom = [v * k for v in b.get("insets") or (0, 0, 0, 0)]
        out = blank(rect[2] * QUALITY, rect[3] * QUALITY)
        w, h = out.width(), out.height()
        painter = QPainter(out)
        if b.get("bg"):
            image = None if b["bg"] is True else self.picture(b["bg"])

            def middle(p, _, __):
                area = QRectF(left, top, w - left - right, h - top - bottom)
                if b["bg"] is True:
                    p.fillRect(area, Qt.white)
                elif not image:  # (the game couldn't give it)
                    return
                elif b.get("tile") and b.get("tileSize"):
                    size = b["tileSize"] * k
                    scale = QTransform().translate(left, top).scale(size / image.width(), size / image.height())
                    brush = QBrush(image)
                    brush.setTransform(scale)
                    p.fillRect(area, brush)
                else:
                    p.drawImage(area, image)

            color = item.get("color") or (1, 1, 1, 1)
            painter.setOpacity(color[3])
            painter.drawImage(0, 0, tinted(w, h, color, middle))
        edge = b.get("edge") and b["edge"] is not True and self.picture(b["edge"])
        if edge:
            e = min((b.get("edgeSize") or 16) * k, w / 2, h / 2)
            nx, ny = (w - 2 * e) / e, (h - 2 * e) / e

            def around(p, _, __):  # (its 8 pieces: left, right, top, bottom, the 4 corners)
                t = [i / 8 for i in range(9)]
                quad(p, edge, (t[0], 0, t[0], ny, t[1], 0, t[1], ny), 0, e, e, h - 2 * e)
                quad(p, edge, (t[1], 0, t[1], ny, t[2], 0, t[2], ny), w - e, e, e, h - 2 * e)
                quad(p, edge, (t[2], nx, t[3], nx, t[2], 0, t[3], 0), e, 0, w - 2 * e, e)
                quad(p, edge, (t[3], nx, t[4], nx, t[3], 0, t[4], 0), e, h - e, w - 2 * e, e)
                for i, x, y in ((4, 0, 0), (5, w - e, 0), (6, 0, h - e), (7, w - e, h - e)):
                    quad(p, edge, (t[i], 0, t[i], 1, t[i + 1], 0, t[i + 1], 1), x, y, e, e)

            border = item.get("border") or (1, 1, 1, 1)
            painter.setOpacity(border[3])
            painter.drawImage(0, 0, tinted(w, h, border, around))
        painter.end()
        return out

    def requestImage(self, key, size, requested):
        _, window, view, index = key.split("/")
        data = self.backend.layout["windows"][window]
        art = (data["views"][int(view)].get("art") if data.get("views") else data.get("art")) or []
        if int(index) >= len(art):  # (asked for just as the window changed)
            return blank(1, 1)
        item = art[int(index)]
        out = self.backdrop(item) if item.get("backdrop") else self.texture(item)
        size.setWidth(out.width())
        size.setHeight(out.height())
        return out


class Backend(QObject):
    """What the page can't do: run tools/positions.lua, read and write files."""

    scanned = Signal()

    def __init__(self):
        super().__init__()
        self.layout = {"windows": {}}
        self.generation = 0
        self.engine = None
        self.message = self.run()
        self.watcher = QFileSystemWatcher(self)
        self.seen = self.stamp()
        for path in glob.glob(SAVED):
            self.watcher.addPath(os.path.dirname(path))
        self.wait = QTimer(self, singleShot=True, interval=1500, timeout=self.written)
        self.watcher.directoryChanged.connect(lambda _: self.wait.start())

    def stamp(self):
        return max((os.path.getmtime(p) for p in glob.glob(SAVED)), default=0)

    def written(self):
        if self.stamp() != self.seen:
            self.seen = self.stamp()
            self.scanned.emit()

    def run(self, *extra):
        """tools/positions.lua; what it says (what's wrong with a file, if anything)."""
        done = subprocess.run(["lua5.1", "tools/positions.lua", "", "settings/positions.lua", LAYOUT, "windows", *extra],
                              capture_output=True, text=True)
        if done.returncode:
            return "Not saved: " + done.stderr.strip().splitlines()[0]
        with open(LAYOUT, encoding="utf-8") as file:
            self.layout = json.load(file)
        self.generation += 1
        return done.stdout.strip()

    @Slot(result=str)
    def startMessage(self):
        return self.message

    @Slot(result=str)
    def windows(self):
        return json.dumps(sorted(self.layout["windows"]))

    @Slot(str, result=str)
    def window(self, name):
        data = dict(self.layout["windows"][name])
        data["url"] = QUrl.fromLocalFile(os.path.abspath(data["file"])).toString()
        data["rules"] = self.layout.get("rules")
        data["unit"] = float(self.layout.get("unit") or 0)
        data["generation"] = self.generation
        self.engine.clearComponentCache()
        return json.dumps(data)

    @Slot(result=str)
    def leftText(self):
        """What /dui layout says is left to scan."""
        left = self.layout.get("left") or {}
        lines = []
        for key, label in (("windows", "To open"), ("old", "Older scan, open again"), ("tabs", "Tabs to visit"), ("unstyled", "Not styled")):
            if isinstance(left.get(key), list) and left[key]:
                lines.append(label + ": " + ", ".join(left[key]))
        return "\n\n".join(lines)

    @Slot(result=str)
    def rescan(self):
        return self.run()

    @Slot(str, result=str)
    def save(self, edits):
        with open(EDITS, "w", encoding="utf-8") as file:
            file.write("return " + to_lua(json.loads(edits)))
        said = self.run(EDITS)
        os.remove(EDITS)
        return said

    @Slot(str)
    def keep(self, edits):
        with open(UNSAVED, "w", encoding="utf-8") as file:
            file.write(edits)

    @Slot(result=str)
    def kept(self):
        if os.path.exists(UNSAVED):
            with open(UNSAVED, encoding="utf-8") as file:
                return file.read()
        return "{}"


def start(arguments):
    os.chdir(ROOT)
    QQuickStyle.setStyle("Fusion")
    app = QGuiApplication(arguments)
    app.setOrganizationName("DiabolicUI")
    app.setApplicationName("Windows editor")
    app.setWindowIcon(QIcon(os.path.join(ROOT, "tools", "editor-icon.svg")))
    app.setDesktopFileName("diabolicui-editor")  # (tools/install-editor.sh: the panel's icon on Wayland)
    engine = QQmlApplicationEngine()
    backend = Backend()
    backend.engine = engine
    engine.addImageProvider("art", Art(backend))
    engine.rootContext().setContextProperty("backend", backend)
    engine.load(os.path.join(ROOT, "tools", "editor.qml"))
    return app, engine, backend


if __name__ == "__main__":
    application, qml, _ = start(sys.argv)
    if not qml.rootObjects():
        sys.exit(1)
    sys.exit(application.exec())
