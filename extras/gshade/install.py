#!/usr/bin/env python3
"""Sets up GShade for World of Warcraft 3.3.5a the way DiabolicUI uses it.

    ./install.py                      game folder found from where this script sits
    ./install.py /path/to/wow         or given
    ./install.py --skip-gshade        GShade is already installed: only add our part
    ./install.py --force              replace our files even where they already exist
    ./install.py --dry-run            say what would change, change nothing

What it does, in the game folder:
  1. GShade (latest release): GShade32.dll as d3d9.dll, its shaders and presets.
  2. Two shaders the GShade download lacks, from their authors' repositories:
     Marty's SMAA (iMMERSE) and qUINT Lightroom, into gshade-local-shaders/.
  3. ReShade Effect Shader Toggler (REST, 32-bit D3D9 build) in gshade-addons/,
     set up to apply the effects before WoW draws its UI.
  4. The DiabolicUI presets in gshade-presets/DiabolicUI/.
  5. GShade.ini: add-on folder, shader folders, depth settings, startup preset.
  6. WTF/Config.wtf: multisampling 1x (GShade can't read depth above that).

Everything replaced is kept in GShade-backups/<date>/. The game must be closed.
See README.adoc next to this script for the in-game steps and troubleshooting.
"""

import argparse
import io
import os
import re
import shutil
import subprocess
import sys
import time
import urllib.request
import zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
FILES = os.path.join(HERE, "files")
USER_AGENT = "DiabolicUI-gshade-install"

GSHADE_REPO = "Mortalitas/GShade"
GSHADE_ASSET = "GShade.Latest.zip"

# Shaders the GShade download doesn't include: (url, path under gshade-local-shaders)
EXTRA_SHADERS = [
    ("https://raw.githubusercontent.com/martymcmodding/iMMERSE/main/Shaders/MartysMods_SMAA.fx", "MartysMods_SMAA.fx"),
    ("https://raw.githubusercontent.com/martymcmodding/qUINT/master/Shaders/qUINT_lightroom.fx", "qUINT_lightroom.fx"),
    ("https://raw.githubusercontent.com/martymcmodding/qUINT/master/Shaders/qUINT_common.fxh", "qUINT_common.fxh"),
]
MARTYS_HEADERS = ["bxdf", "camera", "colorspaces", "debug", "deferred", "depth", "fft", "global", "harmonics",
                  "hash", "input", "math", "qmc", "sfc", "texture"]
EXTRA_SHADERS += [(f"https://raw.githubusercontent.com/martymcmodding/iMMERSE/main/Shaders/MartysMods/mmx_{name}.fxh",
                   f"MartysMods/mmx_{name}.fxh") for name in MARTYS_HEADERS]

STARTUP_PRESET = r".\gshade-presets\DiabolicUI\Kino.ini"

# GShade.ini values: (section, key, value). Lists are merged into what's there.
GSHADE_SETTINGS = [
    ("ADDON", "AddonPath", "gshade-addons"),
    # Generic Depth II finds no depth in WoW 3.3.5; the original Generic Depth does
    ("ADDON", "DisabledAddons", "Generic Depth II"),
    # WoW never clears its main depth buffer, so a copy made "before clear" never happens
    ("DEPTH", "DepthCopyBeforeClears", "0"),
    ("GENERAL", "EnableStartupPreset", "1"),
    ("GENERAL", "PresetPath", STARTUP_PRESET),
    ("GENERAL", "StartupPresetPath", STARTUP_PRESET),
    # Only compile the effects a preset uses: fast reloads, less memory in a 32-bit game
    ("GENERAL", "SkipLoadingDisabledEffects", "1"),
]
SEARCH_PATHS = [("EffectSearchPaths", [r".\gshade-shaders\Shaders", r".\gshade-shaders\ComputeShaders", r".\gshade-local-shaders"]),
                ("TextureSearchPaths", [r".\gshade-shaders\Textures"])]
DEPTH_DEFINITIONS = {
    "RESHADE_DEPTH_LINEARIZATION_FAR_PLANE": "1000.0",
    "RESHADE_DEPTH_INPUT_IS_UPSIDE_DOWN": "0",
    "RESHADE_DEPTH_INPUT_IS_REVERSED": "0",  # WoW 3.3.5's depth is not reversed
    "RESHADE_DEPTH_INPUT_IS_LOGARITHMIC": "0",
}


class Installer:
    def __init__(self, game, dry_run, force):
        self.game, self.dry_run, self.force = game, dry_run, force
        self.backup_dir = os.path.join(game, "GShade-backups", time.strftime("%Y%m%d-%H%M%S"))
        self.changes = []

    def path(self, *parts):
        return os.path.join(self.game, *parts)

    def note(self, text):
        self.changes.append(text)
        print(("  (dry run) " if self.dry_run else "  ") + text)

    def backup(self, target):
        """Moves an existing file (or link) aside before it's replaced."""
        if not os.path.lexists(target):
            return
        kept = os.path.join(self.backup_dir, os.path.relpath(target, self.game))
        if not self.dry_run:
            os.makedirs(os.path.dirname(kept), exist_ok=True)
            shutil.move(target, kept)

    def write(self, target, data, replace=True):
        if os.path.isfile(target) and not os.path.islink(target):
            with open(target, "rb") as file:
                if file.read() == data:
                    return
        if os.path.lexists(target) and not replace:
            print(f"  kept {os.path.relpath(target, self.game)} (exists; --force replaces it)")
            return
        self.note(f"{'replace' if os.path.lexists(target) else 'add'} {os.path.relpath(target, self.game)}")
        if self.dry_run:
            return
        self.backup(target)
        os.makedirs(os.path.dirname(target), exist_ok=True)
        with open(target, "wb") as file:
            file.write(data)

    # 1. GShade ----------------------------------------------------------------

    def install_gshade(self):
        tag = latest_release(GSHADE_REPO)
        print(f"GShade {tag}")
        data = fetch(f"https://github.com/{GSHADE_REPO}/releases/download/{tag}/{GSHADE_ASSET}", "GShade")
        with zipfile.ZipFile(io.BytesIO(data)) as zipped:
            self.write(self.path("d3d9.dll"), zipped.read("GShade32.dll"))
            shaders = self.path("gshade-shaders")
            if os.path.islink(shaders):
                print("  kept gshade-shaders (a link to a shared GShade install)")
            else:
                for name in zipped.namelist():
                    if name.startswith(("gshade-shaders/", "gshade-presets/")) and not name.endswith("/"):
                        target = self.path(*name.split("/"))
                        if not os.path.exists(target) or self.force:
                            if not self.dry_run:
                                os.makedirs(os.path.dirname(target), exist_ok=True)
                                with open(target, "wb") as file:
                                    file.write(zipped.read(name))
                self.note("add GShade's shaders and presets (existing files kept)")

    # 2. Extra shaders -----------------------------------------------------------

    def install_extra_shaders(self):
        print("Shaders GShade's download lacks")
        shipped = self.path("gshade-shaders", "Shaders")
        for url, relative in EXTRA_SHADERS:
            if os.path.exists(os.path.join(shipped, *relative.split("/"))):
                print(f"  kept {relative} (already in gshade-shaders)")
                continue
            target = self.path("gshade-local-shaders", *relative.split("/"))
            if os.path.exists(target) and not self.force:
                print(f"  kept gshade-local-shaders/{relative}")
                continue
            self.write(target, fetch(url, relative), replace=True)
        for name in sorted(os.listdir(os.path.join(FILES, "gshade-local-shaders"))):
            self.copy_file(("gshade-local-shaders", name), replace=self.force)

    # 3. REST, 4. presets ----------------------------------------------------------

    def copy_file(self, parts, replace):
        with open(os.path.join(FILES, *parts), "rb") as file:
            self.write(self.path(*parts), file.read(), replace=replace or not os.path.lexists(self.path(*parts)))

    def install_rest(self):
        print("ReShade Effect Shader Toggler")
        self.copy_file(("gshade-addons", "ReshadeEffectShaderToggler.addon32"), replace=True)
        self.copy_file(("gshade-addons", "ReshadeEffectShaderToggler-LICENSE.txt"), replace=True)
        # its settings hold the UI shader group; a user's own groups are kept unless --force
        self.copy_file(("gshade-addons", "ReshadeEffectShaderToggler.ini"), replace=self.force)

    def install_presets(self):
        print("DiabolicUI presets")
        for name in sorted(os.listdir(os.path.join(FILES, "gshade-presets", "DiabolicUI"))):
            self.copy_file(("gshade-presets", "DiabolicUI", name), replace=self.force)

    # 5. GShade.ini ------------------------------------------------------------------

    def configure_gshade(self):
        print("GShade.ini")
        target = self.path("GShade.ini")
        text = read_text(target) if os.path.exists(target) else ""
        ini = Ini(text)
        for section, key, value in GSHADE_SETTINGS:
            if key == "DisabledAddons":
                value = merge_list(ini.get(section, key), [value])
            ini.set(section, key, value)
        for key, paths in SEARCH_PATHS:
            ini.set("GENERAL", key, merge_list(ini.get("GENERAL", key), paths))
        definitions = ini.get("GENERAL", "PreprocessorDefinitions") or ""
        found = dict(d.split("=", 1) if "=" in d else (d, "") for d in definitions.split(",") if d)
        found.update(DEPTH_DEFINITIONS)
        ini.set("GENERAL", "PreprocessorDefinitions", ",".join(f"{k}={v}" if v else k for k, v in found.items()))
        if ini.text() != text:
            self.write(target, ini.text().encode("utf-8"))
        else:
            print("  GShade.ini already set")

    # 6. WoW's multisampling ---------------------------------------------------------

    def configure_wow(self):
        print("WTF/Config.wtf")
        target = self.path("WTF", "Config.wtf")
        if not os.path.exists(target):
            print("  no WTF/Config.wtf yet: set Multisampling to 1x in WoW's video options")
            return
        text = read_text(target)
        # WoW only writes the line when it differs from the default, which is 1x
        new = re.sub(r'^SET gxMultisample "[^"]*"(\r?)$', r'SET gxMultisample "1"\1', text, flags=re.M)
        if new != text:
            self.write(target, new.encode("utf-8"))
        else:
            print("  multisampling already 1x")


class Ini:
    """Edits an ini in place: keeps its order, comments and line endings."""

    def __init__(self, text):
        self.newline = "\r\n" if "\r\n" in text else "\n"
        self.lines = text.replace("\r\n", "\n").split("\n") if text else []

    def _find(self, section, key):
        current, section_at, key_at = None, None, None
        for index, line in enumerate(self.lines):
            header = re.match(r"^\[(.+)\]\s*$", line)
            if header:
                current = header.group(1)
                if current == section:
                    section_at = index
                continue
            if current == section and line.split("=", 1)[0] == key and "=" in line:
                key_at = index
        return section_at, key_at

    def get(self, section, key):
        _, at = self._find(section, key)
        return self.lines[at].split("=", 1)[1] if at is not None else None

    def set(self, section, key, value):
        section_at, key_at = self._find(section, key)
        if key_at is not None:
            self.lines[key_at] = f"{key}={value}"
        elif section_at is not None:
            self.lines.insert(section_at + 1, f"{key}={value}")
        else:
            while self.lines and self.lines[-1] == "":
                self.lines.pop()
            self.lines += ([""] if self.lines else []) + [f"[{section}]", f"{key}={value}"]

    def text(self):
        lines = list(self.lines)
        while lines and lines[-1] == "":
            lines.pop()
        return self.newline.join(lines) + self.newline


def merge_list(current, wanted):
    items = [i for i in (current or "").split(",") if i]
    items += [w for w in wanted if w.lower() not in (i.lower() for i in items)]
    return ",".join(items)


def read_text(path):
    with open(path, "rb") as file:
        return file.read().decode("utf-8", "replace")


def fetch(url, label):
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=120) as response:
        data = response.read()
    print(f"  downloaded {label} ({len(data) // 1024} KB)")
    return data


def latest_release(repo):
    """The latest release's tag, from where /releases/latest redirects (no API rate limit)."""
    request = urllib.request.Request(f"https://github.com/{repo}/releases/latest", method="HEAD",
                                     headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=30) as response:
        match = re.search(r"/releases/tag/([^/?#]+)$", response.geturl())
    if not match:
        sys.exit(f"No release found on github.com/{repo}.")
    return match.group(1)


def find_game(start):
    """Walks up from this script (it lives in Interface/AddOns/DiabolicUI/extras/gshade)."""
    folder = start
    for _ in range(8):
        if os.path.exists(os.path.join(folder, "Wow.exe")):
            return folder
        folder = os.path.dirname(folder)
    return None


def game_running():
    if os.name == "nt":
        result = subprocess.run(["tasklist", "/FI", "IMAGENAME eq Wow.exe"], capture_output=True, text=True)
        return "Wow.exe" in result.stdout
    # Under Wine the process is named Wow.exe, or its command line holds a Windows path to it;
    # a plain "wow.exe" match would also catch any shell whose command mentions the file
    for pattern in (["-ix", r"wow\.exe"], ["-fi", r"^[a-z]:\\.*\\wow\.exe"]):
        if subprocess.run(["pgrep", *pattern], capture_output=True).returncode == 0:
            return True
    return False


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("game", nargs="?", help="the WoW 3.3.5a folder (the one with Wow.exe)")
    parser.add_argument("--skip-gshade", action="store_true", help="GShade is already installed: don't download it")
    parser.add_argument("--force", action="store_true", help="replace our presets, shaders and REST settings if present")
    parser.add_argument("--dry-run", action="store_true", help="show what would change without changing anything")
    args = parser.parse_args()

    game = os.path.abspath(args.game) if args.game else find_game(HERE)
    if not game or not os.path.exists(os.path.join(game, "Wow.exe")):
        sys.exit("WoW's folder (with Wow.exe) wasn't found: give it as an argument.")
    if game_running():
        sys.exit("WoW is running: close it first (GShade and WoW rewrite their settings on exit).")
    print(f"WoW folder: {game}\n")

    installer = Installer(game, args.dry_run, args.force)
    if not args.skip_gshade:
        installer.install_gshade()
    installer.install_extra_shaders()
    installer.install_rest()
    installer.install_presets()
    installer.configure_gshade()
    installer.configure_wow()

    print()
    if os.path.isdir(installer.backup_dir):
        print(f"Replaced files are in {os.path.relpath(installer.backup_dir, game)}/")
    if os.name != "nt":
        print("On Linux, Wine must load the game folder's d3d9.dll: add d3d9=n,b to WINEDLLOVERRIDES\n"
              "(or in winecfg, Libraries). GShade also needs Microsoft's d3dcompiler_47:\n"
              "winetricks d3dcompiler_47 (or protontricks) in the game's prefix. See README.adoc.")
    print("Then start the game and follow the first-launch checks in README.adoc.")


if __name__ == "__main__":
    main()
