#!/usr/bin/env bash
# Runs the whole test suite with line coverage recording, then prints a
# per-area coverage summary (full per-file table in tests/coverage/report.txt).
#
#   tests/coverage/run.sh            # report only
#   tests/coverage/run.sh --readme   # also refresh the table in README.adoc
#
# Run from anywhere. Tests run in parallel (one job per CPU; set JOBS to
# change that), each job recording into its own file, merged at the end:
# the session tests one test per job, since a whole session file is far
# slower than the rest (every test boots the addon), the other files one
# file per job. Exits non-zero if any test failed.
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

LUA=${LUA:-lua5.1}
JOBS=${JOBS:-$(nproc 2>/dev/null || echo 4)}
STATS=tests/coverage/stats.out
PARTS=tests/coverage/stats.d

rm -rf "$STATS" "$PARTS"
mkdir -p "$PARTS"

export LUA PARTS
# "file [test]" per job, the session tests first: they're the slow ones
{
	for file in tests/test_session_*.lua; do
		grep -oE '^function Test[A-Za-z0-9_]+[:.]test[A-Za-z0-9_]*' "$file" \
			| sed -E "s|^function ||; s|:|.|; s|^|$file |"
	done
	ls tests/test_*.lua | grep -v '/test_session_'
} | xargs -P "$JOBS" -L1 sh -c '
	file=$0 test=${1:-}
	name=$(basename "$file" .lua)${test:+.$test}
	run() {
		rm -f "$PARTS/$name.out"
		DIABOLICUI_COVERAGE_STATS="$PARTS/$name.out" "$LUA" -e "dofile(\"tests/coverage/hook.lua\")" "$file" $test > "$PARTS/$name.log" 2>&1
	}
	run
	code=$?
	# Lua 5.1.5 itself crashes now and then under the line hook when the
	# machine is busy ("double free or corruption"): a crash gets one rerun.
	if [ "$code" -ge 128 ]; then
		echo "(rerun after a crash: $file $test)"
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
	echo "FAILED: $(basename "$failed" .failed)"
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
