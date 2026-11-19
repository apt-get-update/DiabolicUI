#!/usr/bin/env python3
"""The game remote: a test client of the game, headless (Xvfb, Wine), driven
over 127.0.0.1:7999 by a few fixed actions, for checks run where Wine can't
(tools/realm/up.sh starts it):

  /start                 the client, logged out (on the test realm, 127.0.0.1)
  /stop                  the client closed
  /shot                  the screen, as <realm>/shots/screen.png
  /key?k=Return          keys (xdotool's names, "+" between held ones)
  /type?t=/reload        text typed
  /click?x=10&y=20&b=1   a click (b: 1 left, 3 right)
  /status                is it running

The test client: <realm>/client, links to the game's files, its own WTF
(realmlist 127.0.0.1), without the game's d3d9, dinput8 and version DLLs
(GShade and the rest); its own Interface, the game's addons linked, DiabolicUI
with a .toc of its own that adds the scan (tools/realm/scan.lua: /dui layout,
DiabolicUI_Layout), which the addon players get never loads.

  remote.py <game folder> <realm folder>
"""
import json
import os
import re
import subprocess
import sys
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlparse

GAME, REALM = os.path.abspath(sys.argv[1]), os.path.abspath(sys.argv[2])
CLIENT, PREFIX, SHOTS = os.path.join(REALM, "client"), os.path.join(REALM, "prefix"), os.path.join(REALM, "shots")
DISPLAY = ":99"
LEFT_OUT = re.compile(r"^(Data|WTF|Interface|Screenshots|Cache|Logs|Errors|d3d9\.dll|version\.dll|dinput8\.dll|gshade.*|lumenveil.*|_disabled|.*backup.*|__pycache__)$", re.I)
CONFIG = """SET realmList "127.0.0.1"
SET gxWindow "1"
SET gxMaximize "0"
SET gxResolution "1920x1080"
SET gxApi "d3d9"
SET readEULA "1"
SET readTOS "1"
SET readScanning "1"
SET readContest "1"
SET readTerminationWithoutNotice "1"
SET accountName "DUI"
SET accounttype "LK"
SET locale "enUS"
SET movie "0"
SET Sound_EnableAllSound "0"
SET checkAddonVersion "0"
SET screenshotFormat "tga"
SET screenshotQuality "10"
SET uiScale "1"
SET useUiScale "0"
"""
env = dict(os.environ, DISPLAY=DISPLAY, WINEPREFIX=PREFIX, WINEDEBUG="-all", WINEDLLOVERRIDES="mscoree,mshtml=")
processes = {}


def link(source, target):
    if not os.path.lexists(target):
        os.symlink(source, target)


def build_interface():
    """The test client's Interface: the game's linked, but DiabolicUI's, its
    files linked and a .toc of its own: the game's, the scan added."""
    game, mine = os.path.join(GAME, "Interface"), os.path.join(CLIENT, "Interface")
    if os.path.islink(mine):
        os.unlink(mine)
    os.makedirs(os.path.join(mine, "AddOns", "DiabolicUI"), exist_ok=True)
    for name in os.listdir(game):
        if name != "AddOns":
            link(os.path.join(game, name), os.path.join(mine, name))
    for name in os.listdir(os.path.join(game, "AddOns")):
        if name != "DiabolicUI":
            link(os.path.join(game, "AddOns", name), os.path.join(mine, "AddOns", name))
    source, addon = os.path.join(game, "AddOns", "DiabolicUI"), os.path.join(mine, "AddOns", "DiabolicUI")
    for name in os.listdir(source):
        if name != "DiabolicUI.toc":
            link(os.path.join(source, name), os.path.join(addon, name))
    with open(os.path.join(source, "DiabolicUI.toc")) as file:
        toc = file.read()
    toc = re.sub(r"^(## SavedVariables: .*)$", r"\1, DiabolicUI_Layout", toc, count=1, flags=re.M)
    with open(os.path.join(addon, "DiabolicUI.toc"), "w") as file:
        file.write(toc.rstrip("\n") + "\ntools\\realm\\scan.lua\n")


def build_client():
    """The test client's folder: the game's files linked, its own settings."""
    os.makedirs(os.path.join(CLIENT, "Data", "enUS"), exist_ok=True)
    os.makedirs(os.path.join(CLIENT, "WTF"), exist_ok=True)
    os.makedirs(SHOTS, exist_ok=True)
    for name in os.listdir(GAME):
        if not LEFT_OUT.match(name):
            link(os.path.join(GAME, name), os.path.join(CLIENT, name))
    for name in os.listdir(os.path.join(GAME, "Data")):
        if name != "enUS":
            link(os.path.join(GAME, "Data", name), os.path.join(CLIENT, "Data", name))
    for name in os.listdir(os.path.join(GAME, "Data", "enUS")):
        if name.lower() != "realmlist.wtf":
            link(os.path.join(GAME, "Data", "enUS", name), os.path.join(CLIENT, "Data", "enUS", name))
    build_interface()
    with open(os.path.join(CLIENT, "Data", "enUS", "realmlist.wtf"), "w") as file:
        file.write("set realmlist 127.0.0.1\n")
    config = os.path.join(CLIENT, "WTF", "Config.wtf")
    if not os.path.exists(config):
        with open(config, "w") as file:
            file.write(CONFIG)


def running(name):
    process = processes.get(name)
    return bool(process and process.poll() is None)


def start():
    build_client()
    if not running("x"):
        processes["x"] = subprocess.Popen(["Xvfb", DISPLAY, "-screen", "0", "1920x1080x24", "+extension", "GLX", "-nolisten", "tcp"])
        time.sleep(2)
    if not running("wow"):
        processes["wow"] = subprocess.Popen(["wine", "Wow.exe"], cwd=CLIENT, env=env,
                                            stdout=subprocess.DEVNULL, stderr=open(os.path.join(REALM, "logs", "wine.log"), "w"))
    return {"started": True}


def stop():
    if running("wow"):
        subprocess.run(["wineserver", "-k"], env=env)
        processes["wow"].wait(timeout=30)
    return {"stopped": True}


def xdotool(*args):
    done = subprocess.run(["xdotool", *args], env=env, capture_output=True, text=True)
    return {"ok": done.returncode == 0, "said": done.stderr.strip()}


def shot():
    path = os.path.join(SHOTS, "screen.png")
    done = subprocess.run(["import", "-display", DISPLAY, "-window", "root", path], capture_output=True, text=True)
    return {"ok": done.returncode == 0, "file": path, "said": done.stderr.strip()}


KEYS = re.compile(r"^[A-Za-z0-9_+]{1,40}( [A-Za-z0-9_+]{1,40}){0,9}$")


def act(path, query):
    one = lambda key: (query.get(key) or [""])[0]
    if path == "/start":
        return start()
    if path == "/stop":
        return stop()
    if path == "/status":
        return {"x": running("x"), "wow": running("wow")}
    if path == "/shot":
        return shot()
    if path == "/key" and KEYS.match(one("k")):
        return xdotool("key", "--delay", "60", *one("k").split(" "))
    if path == "/type" and 0 < len(one("t")) <= 255 and one("t").isprintable():
        return xdotool("type", "--delay", "40", "--", one("t"))
    if path == "/click" and one("x").isdigit() and one("y").isdigit() and one("b") in ("", "1", "3"):
        moved = xdotool("mousemove", one("x"), one("y"))
        time.sleep(0.1)
        return xdotool("click", one("b") or "1") if moved["ok"] else moved
    return None


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        url = urlparse(self.path)
        try:
            out = act(url.path, parse_qs(url.query))
        except Exception as problem:  # (said back, the remote kept up)
            out = {"error": str(problem)}
        body = json.dumps(out if out is not None else {"error": "unknown action or bad argument"}).encode()
        self.send_response(200 if out is not None else 400)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *_):
        pass


if __name__ == "__main__":
    ThreadingHTTPServer(("127.0.0.1", 7999), Handler).serve_forever()
