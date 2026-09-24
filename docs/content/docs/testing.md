---
title: "Testing"
weight: 7
---

# Testing

There's no way to launch the actual WoW client from this environment, so the
test suite exists to catch what it can *without* one: syntax errors, files
that fail to load, load-order mistakes, and the behaviour of the logic that
doesn't need a live client (the engine itself, dispel rules, portrait
fallback, tooltip anchoring, chat link parsing, and so on).

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

Runs every `tests/test_*.lua` file under plain Lua 5.1 with fake WoW API
globals, and prints a `Ran N tests in Xs, N successes, 0 failures` line per
file. The script exits non-zero if any file failed.

The suite has three layers:

| Layer | Files | Catches |
|---|---|---|
| Whole addon | `test_addon_loads.lua` | The addon loaded like the client does: `DiabolicUI.toc`, then every `<Include>`/`<Script>` in order, with the real engine and the minimap module's Ace3 libraries. Also fails on an XML entry pointing at a missing file, or a `.lua` file nothing loads. |
| Every file | `test_all_modules_load.lua`, `test_no_global_leaks.lua`, `test_locales.lua` | Each `handlers/` and `modules/` file loaded on its own against a mock Engine (found on disk, no list to maintain); accidental globals; translation keys that don't exist in English. |
| Behaviour | the other `test_*.lua` files | Real functions called with fake frames and a scripted game state: the engine's lifecycle, events, combat queue and saved profiles; unit frame elements; raid dispel list; tracker fade; taxi button; chat, tooltip and capture bar logic; data helpers. |

`tests/README.md` explains the mocking approach and its pitfalls in detail.
Read it before writing a new test.

## Code coverage

```bash
tests/coverage/run.sh            # summary per area, full table in tests/coverage/report.txt
tests/coverage/run.sh --readme   # also refresh the coverage table in README.adoc
```

The coverage tool is part of the repo (`tests/coverage/hook.lua` and
`report.lua`) and needs nothing beyond Lua 5.1 and `luac5.1`. It records
which lines run through a debug hook, and counts a line as executable when
`luac5.1 -l` shows the compiler emitted code for it.

Read the numbers with care. Loading the whole addon runs every file's top
level, so data, settings and locale files are close to 100% just from being
loaded. The `engine`, `handlers` and `modules/*` numbers are the ones that
reflect tested behaviour: most of those lines sit inside functions that only
a behaviour test reaches.

## Writing a new test

1. Pick a function whose inputs and outputs you can fake: WoW API calls
   answered from a small table, frames replaced by tables recording the
   calls they receive.
2. Load the real file with `loadfile(path)("DiabolicUI", Engine)`, using
   `tests/mocks/engine_mock.lua` (or the real engine, as
   `test_engine_core.lua` does).
3. Install any WoW function the file captures as a local *before* loading
   it; replacing the global afterwards has no effect.
4. If the function is a file-local, expose it on its module or widget with
   a one-line "Exposed for tests/..." comment, as `units/raid.lua` does for
   its debuff filter.

## What the suite can't catch

- Whether a frame is positioned where you meant it to be.
- Whether a texture actually looks right at the size it's stretched to.
- Whether a click handler fires correctly on a real, live Blizzard widget.
- Timing-dependent bugs (a value not yet populated by the client when your
  code reads it).

All of that needs a real `/reload` in-game. Report changes to UI-facing code
honestly: "syntax and load tested, not yet verified in-game" is a different,
weaker claim than "this works."
