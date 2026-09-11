# Tests

Unit tests for pieces of DiabolicUI that are pure enough to run outside the
WoW client, using [LuaUnit](https://github.com/bluebird75/luaunit) (vendored
in `tests/luaunit.lua`, BSD licensed) under plain Lua 5.1 (the version WotLK
3.3.5 embeds).

This is **not** in-game testing and never touches the `.toc` - none of this
runs for players, it's a local dev tool only.

## Running

From the addon root (`DiabolicUI/`):

```bash
tests/run_all.sh            # every test file, one after another
lua5.1 tests/test_tooltip_positioning.lua   # a single file
```

Each `tests/test_*.lua` file is self-contained and runnable on its own.

## What's covered

- `test_all_modules_load.lua` - a load-only "smoke test" for **every**
  module/handler file in the addon (91 files at time of writing): each one
  is loaded standalone and we assert it doesn't error while doing so. This
  can't verify behaviour, but it catches load-time regressions across the
  whole addon - typos, a removed function a file still calls at file scope,
  a bad reference, etc. - without having to hand-write a test for each file.
- `test_tooltip_positioning.lua` - `modules/blizzard/tooltips.lua`'s
  cursor-anchoring math (`Tooltip_GetAnchorFractions`, `Tooltip_PositionAtCursor`):
  all 9 anchor points, the offset, and effective-scale handling.
- `test_actionbars_visibility.lua` - `modules/actionbars/actionbars.lua`'s
  `IsXPVisible` / `IsReputationVisible` (vehicle/pet-possession, level cap,
  watched-faction checks) - what decides whether the xp bar or the
  reputation bar is shown.
- `test_chat_fade_settings.lua` - `modules/chat/windows.lua`'s
  `ApplyFadeSettings` - pushing the Fade Chat / Time Fading / Time Visible
  options onto the real chat frames and Blizzard's own fade-out timing -
  and `ApplyBackgroundOpacity`, which pushes the Background Opacity slider
  (25% by default) onto the chat window's background texture - only while
  its editbox is shown, fully transparent otherwise.
- `test_chat_copy_text.lua` - `modules/chat/filters.lua`'s "right-click
  chat text to copy it" feature (toggled by its own "Click to Copy" option,
  on by default): wrapping the message body (after the sender's name) in a
  custom hyperlink with a plain-text copy stashed by index, and the
  replaced `SetItemRef` that opens the copy popup on a right-click of that
  link, swallows a left-click on it, and forwards every other link type to
  the original unchanged - exercised by calling the (mocked-in-place-of-
  Blizzard's-own) `SetItemRef` directly, since there's no real chat frame
  to click in this environment.

## How it works

WoW addon files aren't standalone Lua modules - they expect `...` to receive
`(addonName, Engine)` from the client's loader, and they call straight into
the WoW API and the addon's own `Engine` object (`Engine:NewModule`,
`Engine:GetConfig`, etc.) at file-load time. To unit test the *real* source
files (not reimplementations of their logic) without a WoW client:

- `tests/mocks/engine_mock.lua` provides a minimal stand-in for `Engine` -
  `NewModule` / `GetModule` / `NewHandler` / `GetHandler` / `NewConfig` /
  `GetConfig` / `NewStaticConfig` / `GetDB` / `GetLocale`, plus the same set
  of methods delegated onto module/handler/widget instances themselves
  (e.g. `self:GetDB(...)`), matching how the real addon code calls them. Any
  method call it doesn't recognize - on `Engine` itself or on a module -
  resolves to a harmless no-op instead of erroring, and any config lookup
  for a name nobody registered resolves to an "infinite mock" table that can
  be indexed arbitrarily deep (`config.fonts.text_normal.path`) without
  erroring either. It does not attempt to reproduce the real engine's actual
  behaviour beyond that (no combat-safe queuing, no event system, etc.).
- `tests/mocks/wow_api_mock.lua` stubs the handful of real WoW globals
  that specific files read *immediately* at file scope (not inside a
  function body) as actual strings/numbers/functions - e.g. `ITEM_LEVEL`,
  `UnitLevel("player")` - because generic auto-stubbing can't safely paper
  over those (a real `string.gsub` call needs a real string, not a mock
  object). Extend this only when a newly-tested file needs another such
  global; don't add globals speculatively.
- `tests/mocks/auto_stub.lua` is the permissive catch-all used by the
  whole-addon smoke test: once installed, *any* undefined global resolves to
  a Stub value that can be called, indexed (however deep) or concatenated
  with a string without erroring. This is what makes "just load every file
  and see if it errors" feasible without enumerating every global every
  file touches - but it only helps for load-only smoke testing, since the
  actual values are meaningless.
- A test that wants to exercise specific *behaviour* (not just "did it
  load") loads the target file itself via `loadfile(...)`, calls the
  returned chunk with `("DiabolicUI", Engine)`, and asks the mock Engine for
  the resulting module (`Engine:GetModule("...")`) to call its real methods
  directly - with small hand-written fakes (a fake tooltip frame recording
  `SetPoint` calls, a fake chat frame recording `SetFading` calls, etc.)
  standing in for whatever WoW objects those methods are handed, and
  `Module.db = {...}` set directly instead of going through SavedVariables.

  One gotcha worth knowing: several files capture a WoW API function as a
  local upvalue at file-load time (`local GetCursorPosition = _G.GetCursorPosition`).
  Reassigning `_G.GetCursorPosition` *after* the module has loaded has no
  effect on it - install one fixed mock function before loading, and have
  tests mutate a shared table it reads from instead (see
  `test_tooltip_positioning.lua`'s `cursor` table, or
  `test_actionbars_visibility.lua`'s `state` table, for the pattern).

## Scope and limitations

This approach only works for logic that's reachable without a deep tree of
frame/widget interactions - mostly pure calculations, plus anything whose
inputs and outputs are plain values/tables. It deliberately does **not**
attempt to test:

- Frame creation/layout (`CreateFrame`, `SetPoint` chains that depend on real
  frame hierarchies, templates like `OptionsSliderTemplate`).
- Anything that depends on real game state beyond what a test explicitly
  fakes (units, items, combat, SavedVariables).
- The options panel UI itself (`modules/unitframes/unitframes.lua`) - it's
  almost entirely frame construction and Blizzard template wiring, which
  would need a much larger UI mock to exercise meaningfully.

If you want a new file's *behaviour* covered (beyond the load-only smoke
test it already gets automatically as long as it's added to
`test_all_modules_load.lua`'s file list), the file first needs to be
checked for what it touches *at file scope* (outside any `function...end`)
- those are the only calls that must be individually mocked for `loadfile`
to succeed without the permissive auto-stub. Everything inside a function
body only matters for the specific functions a test actually calls.
