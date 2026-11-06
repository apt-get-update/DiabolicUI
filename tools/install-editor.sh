#!/bin/sh
# Installs the windows' editor in the desktop's menu, for this user: its
# .desktop file (written here: it needs this folder's full path, its icon's too).
set -e
tools="$(cd "$(dirname "$0")" && pwd)"
data="${XDG_DATA_HOME:-$HOME/.local/share}"
mkdir -p "$data/applications"
cat > "$data/applications/diabolicui-editor.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=DiabolicUI Windows Editor
Comment=Move and resize DiabolicUI's windows out of the game
Exec="$tools/editor.py"
Path=$tools
Icon=$tools/editor-icon.svg
Terminal=false
Categories=Development;
StartupWMClass=diabolicui-editor
DESKTOP
command -v update-desktop-database >/dev/null && update-desktop-database "$data/applications" || true
command -v kbuildsycoca6 >/dev/null && kbuildsycoca6 >/dev/null 2>&1 || true
echo "Installed: $data/applications/diabolicui-editor.desktop"
