#!/usr/bin/env bash
# Runs the whole test suite with line coverage recording, then prints a
# per-area coverage summary (full per-file table in tests/coverage/report.txt).
#
#   tests/coverage/run.sh            # report only
#   tests/coverage/run.sh --readme   # also refresh the table in README.adoc
#
# Run from anywhere. Exits non-zero if any test failed.
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

LUA=${LUA:-lua5.1}
STATS=tests/coverage/stats.out
status=0

rm -f "$STATS"

for file in tests/test_*.lua; do
	if ! "$LUA" -e "dofile('tests/coverage/hook.lua')" "$file" > /dev/null 2>&1; then
		echo "FAILED: $file (run it on its own to see why)"
		status=1
	fi
done

if [ "${1:-}" = "--readme" ]; then
	"$LUA" tests/coverage/report.lua --readme README.adoc
else
	"$LUA" tests/coverage/report.lua
fi

exit $status
