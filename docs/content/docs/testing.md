---
title: "Testing"
weight: 7
---

# Testing

There's no way to launch the actual WoW client from this environment, so the
test suite exists to catch what it can *without* one: syntax errors, files
that fail to load at all, and a handful of pure-logic unit tests around
things like chat link parsing or capture-bar math that don't need the real
client to verify.

## Syntax checking

```bash
luac5.1 -p modules/unitframes/elements/portraits.lua
```

Compiles without executing — the fastest possible feedback for a typo,
and worth running on every file you touch before anything else.

A full-repo sweep (skipping vendored third-party code) catches anything
missed file-by-file:

```bash
find . -name '*.lua' -not -path './modules/minimap/Libs/*' -print0 \
  | xargs -0 -n1 luac5.1 -p
```

## The LuaUnit suite

```bash
bash tests/run_all.sh
```

Runs every `tests/test_*.lua` file against small stub WoW-API globals (just
enough to let the addon's files `require`/load without erroring), and prints
a `Ran N tests in Xs, N successes, 0 failures` line per file. Grep the full
output for `failures|FAIL` to make sure nothing regressed:

```bash
bash tests/run_all.sh 2>&1 | grep -iE "failures|FAIL"
```

`tests/test_all_modules_load.lua` is a smoke test: it lists every top-level
`.lua` file under `modules/`/`handlers/` by hand and asserts each one loads
without erroring. **This list doesn't update itself** — adding, removing, or
renaming a file at that level means editing this test's file list, or the
new file silently gets zero coverage (removing one without updating the list
instead makes the suite fail outright).

## What the suite can't catch

- Whether a frame is positioned where you meant it to be.
- Whether a texture actually looks right at the size it's stretched to.
- Whether a click handler fires correctly on a real, live Blizzard widget.
- Timing-dependent bugs (a value not yet populated by the client when your
  code reads it).

All of that needs a real `/reload` in-game. Report changes to UI-facing code
honestly: "syntax and load tested, not yet verified in-game" is a different,
weaker claim than "this works."
