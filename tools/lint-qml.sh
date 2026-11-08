#!/usr/bin/env bash
# Checks the window files and the editor with Qt 6's qmllint: a property with a
# typo, an anchor on nothing. Run from anywhere: tools/lint-qml.sh
# (/usr/bin/qmllint can be Qt 5's, which only checks the syntax.)
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/.."

lint=${QMLLINT:-}
for candidate in pyside6-qmllint /usr/lib/qt6/bin/qmllint qmllint6; do
	if [ -z "$lint" ] && command -v "$candidate" > /dev/null; then
		lint=$candidate
	fi
done
if [ -z "$lint" ]; then
	echo "Qt 6's qmllint not found: set QMLLINT to it" >&2
	exit 2
fi

status=0
for file in windows/*.qml tools/editor.qml; do
	said=$("$lint" "$file" 2>&1) || status=1
	if [ -n "$said" ]; then
		echo "$said"
		status=1
	fi
done
[ "$status" -eq 0 ] && echo "QML: no warnings"
exit $status
