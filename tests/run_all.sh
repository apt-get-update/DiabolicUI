#!/usr/bin/env bash
# Runs every tests/test_*.lua file and reports overall pass/fail.
# Run from anywhere: tests/run_all.sh
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/.."

LUA=${LUA:-lua5.1}
status=0

for file in tests/test_*.lua; do
	echo "== $file =="
	"$LUA" "$file"
	code=$?
	if [ "$code" -ne 0 ]; then
		status=1
	fi
	echo
done

exit $status
