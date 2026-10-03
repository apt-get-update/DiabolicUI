#!/usr/bin/env bash
# Runs the whole test suite with line coverage recording, then prints a
# per-area coverage summary (full per-file table in tests/coverage/report.txt).
#
#   tests/coverage/run.sh            # report only
#   tests/coverage/run.sh --readme   # also refresh the table in README.adoc
#
# Run from anywhere. Test files run in parallel (one per CPU; set JOBS to
# change that), each recording into its own file, merged at the end.
# Exits non-zero if any test failed.
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

LUA=${LUA:-lua5.1}
JOBS=${JOBS:-$(nproc 2>/dev/null || echo 4)}
STATS=tests/coverage/stats.out
PARTS=tests/coverage/stats.d

rm -rf "$STATS" "$PARTS"
mkdir -p "$PARTS"

export LUA PARTS
# the session tests first: they're the slow ones
{ ls tests/test_session_*.lua; ls tests/test_*.lua | grep -v '/test_session_'; } | xargs -P "$JOBS" -I{} sh -c '
	name=$(basename "{}" .lua)
	run() {
		rm -f "$PARTS/$name.out"
		DIABOLICUI_COVERAGE_STATS="$PARTS/$name.out" "$LUA" -e "dofile(\"tests/coverage/hook.lua\")" "{}" > "$PARTS/$name.log" 2>&1
	}
	run
	code=$?
	# Lua 5.1.5 itself crashes now and then under the line hook when the
	# machine is busy ("double free or corruption"): a crash gets one rerun.
	if [ "$code" -ge 128 ]; then
		echo "(rerun after a crash: tests/$name.lua)"
		run
		code=$?
	fi
	if [ "$code" -ne 0 ]; then
		mv "$PARTS/$name.log" "$PARTS/$name.failed"
	fi
'

status=0
for failed in "$PARTS"/*.failed; do
	[ -e "$failed" ] || continue
	echo "FAILED: tests/$(basename "$failed" .failed).lua"
	tail -n 30 "$failed" | sed 's/^/    /'
	status=1
done
cat "$PARTS"/*.out > "$STATS" 2>/dev/null
rm -rf "$PARTS"

if [ "${1:-}" = "--readme" ]; then
	"$LUA" tests/coverage/report.lua --readme README.adoc
else
	"$LUA" tests/coverage/report.lua
fi

exit $status
