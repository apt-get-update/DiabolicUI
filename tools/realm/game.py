#!/usr/bin/env python3
"""The test realm from here: its server's console and the test client (up.sh
started both).

  game.py gm <command>      a console command (.character level Padirac 80)
  game.py start | stop      the test client
  game.py shot              its screen: <realm>/shots/screen.png
  game.py key <keys>        keys (xdotool's names: Return, ctrl+a, ...)
  game.py type <text>       text typed
  game.py click <x> <y> [3] a click (3: the right button)
  game.py say <line>        a chat line (Enter, the line, Enter): /dui layout all, .ui all
  game.py record on | off   film the client (in film mode: remote.py's DUI_FILM)
"""
import base64
import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

# (from a sandbox with a loopback of its own: through its proxy, to this PC's)
for name in ("no_proxy", "NO_PROXY"):
    os.environ.pop(name, None)
PROXY = os.environ.get("HTTP_PROXY") or os.environ.get("http_proxy")
OPEN = urllib.request.build_opener(urllib.request.ProxyHandler({"http": PROXY} if PROXY else {})).open
REMOTE = "http://127.0.0.1:7999"
SOAP = "http://127.0.0.1:7878/"
ACCOUNT = ("DUI", "DUI")


def remote(action, **query):
    url = REMOTE + "/" + action + ("?" + urllib.parse.urlencode(query) if query else "")
    with OPEN(url, timeout=60) as answer:
        return json.loads(answer.read())


def gm(command):
    body = ('<?xml version="1.0" encoding="utf-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"'
            ' xmlns:ns1="urn:AC"><SOAP-ENV:Body><ns1:executeCommand><command>%s</command></ns1:executeCommand>'
            '</SOAP-ENV:Body></SOAP-ENV:Envelope>') % command.replace("&", "&amp;").replace("<", "&lt;")
    request = urllib.request.Request(SOAP, body.encode(), {"Content-Type": "text/xml"})
    request.add_header("Authorization", "Basic " + base64.b64encode(("%s:%s" % ACCOUNT).encode()).decode())
    try:
        with OPEN(request, timeout=30) as answer:
            text = answer.read().decode()
    except urllib.error.HTTPError as problem:
        text = problem.read().decode()
    found = re.search(r"<result>(.*?)</result>|<faultstring>(.*?)</faultstring>", text, re.S)
    return (found.group(1) or found.group(2) or "").strip() if found else text


def say(line):
    remote("key", k="Return")
    time.sleep(0.3)
    remote("type", t=line)
    time.sleep(0.2)
    return remote("key", k="Return")


def main(args):
    if not args:
        sys.exit(__doc__)
    what, rest = args[0], args[1:]
    if what == "gm":
        print(gm(" ".join(rest)))
    elif what == "say":
        print(say(" ".join(rest)))
    elif what == "type":
        print(remote("type", t=" ".join(rest)))
    elif what == "key":
        print(remote("key", k=" ".join(rest)))
    elif what == "record":
        print(remote("record", on="1" if rest and rest[0] == "on" else "0"))
    elif what == "click":
        print(remote("click", x=rest[0], y=rest[1], b=rest[2] if len(rest) > 2 else "1"))
    else:
        print(remote(what))


if __name__ == "__main__":
    main(sys.argv[1:])
