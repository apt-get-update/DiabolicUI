#!/usr/bin/env bash
# Runs every tests/test_*.lua file and reports overall pass/fail.
# Run from anywhere: tests/run_all.sh
# Six files at once (each one about 300 MB): not while the game runs. JOBS=1
# tests/run_all.sh runs one after another. The output still comes file by file.
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/.."

LUA=${LUA:-lua5.1}
JOBS=${JOBS:-6}
status=0

if [ "$JOBS" -le 1 ]; then
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
fi

# each file in the background, its output and exit code kept for after; its
# own TMPDIR (the tests name their files by the time and an unseeded random)
out=$(mktemp -d "${TMPDIR:-/tmp}/diabolicui_tests.XXXXXX")
trap 'rm -rf "$out"' EXIT
for file in tests/test_*.lua; do
	while [ "$(jobs -rp | wc -l)" -ge "$JOBS" ]; do
		wait -n
	done
	name=$(basename "$file" .lua)
	mkdir -p "$out/$name.tmp"
	(
		TMPDIR="$out/$name.tmp" "$LUA" "$file" > "$out/$name.out" 2>&1
		echo $? > "$out/$name.code"
	) &
done
wait

for file in tests/test_*.lua; do
	name=$(basename "$file" .lua)
	echo "== $file =="
	cat "$out/$name.out"
	if [ "$(cat "$out/$name.code")" -ne 0 ]; then
		status=1
	fi
	echo
done

exit $status
