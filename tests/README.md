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
- `test_chat_copy_weblinks.lua` - `modules/chat/filters.lua`'s "Copy Web
  Links" feature (toggled by its own option, on by default): wrapping any
  http:// or https:// URL found in a message (there can be more than one)
  in a custom hyperlink, keeping the URL itself as the link's visible text
  and stashing a copy of it by index, leaving everything else in the
  message - including any other real hyperlink - untouched, and the
  replaced `SetItemRef` that opens the copy popup on a left-click of that
  link, swallows a right-click on it, and forwards every other link type
  to the original unchanged - exercised by calling the (mocked-in-place-
  of-Blizzard's-own) `SetItemRef` directly, since there's no real chat
  frame to click in this environment.
- `test_chat_commands.lua` - `handlers/commands.lua`'s `/diabolic` /
  `/diabolicui` / `/dui` slash command plumbing: `ParseCommand` (trims and
  collapses whitespace, splits into command + args), `PerformCommand`
  (defaults an empty/nil command to "config", so a bare `/dui` opens the
  options panel; looks up and calls whatever `Register` put in the
  registry), and `Register` itself (first-write-wins).
- `test_objectives_capturebars.lua` - `modules/objectives/capturebars.lua`'s
  `UpdateCaptureBar` - the tug-of-war progress bar shown for battleground
  and outdoor objectives: resizing the neutral-zone middle section,
  clamping it to a sane range, repositioning the spark to the current
  value, and showing the left/right "moving" indicator based on which way
  the value just changed (or hiding both near the edges).
- `test_blizzard_mirrortimers.lua` - `modules/blizzard/mirrortimers.lua`'s
  `UpdateTimer` (crops, not shrinks, a mirror/start timer's statusbar
  texture to the current value, clamped to its own min/max) and
  `UpdateAnchors` (only visible timers get anchored, mirrors sorted before
  regular timers then by id, stacked with a configured padding, anchored at
  one of two configured positions depending on whether a capture bar is
  currently occupying that screen spot).
- `test_unitframes_elements.lua` - two of
  `modules/unitframes/elements/*.lua`'s per-unit-frame element `Update`
  functions: `name.lua` (colors the name text white by default, blue for an
  elite only if the frame opted in via `Name.colorElite`, purple for a
  world boss only if `Name.colorBoss` - and bails out if the unit doesn't
  exist or, on `UNIT_TARGET`, isn't the frame's own current target) and
  `threat.lua` (shows the threat glow in the aggro-status color while the
  unit has a threat situation, hides it otherwise, ignoring the event
  entirely for a different unit than its own).
- `test_minimap_api.lua` - three of the embedded minimap module's own small
  `Core/API/*.lua` utility functions: `Positions.lua`'s
  `GetParsedPosition` (which of the 9 anchor regions a coordinate within a
  frame falls into), `Abbreviations.lua`'s `AbbreviateNumber` /
  `AbbreviateNumberBalanced` / `AbbreviateTime` (number/time -> short
  display-string formatting), and `Addons.lua`'s `IsAddOnAvailable` /
  `IsAddOnEnabled` / `IsAddOnLoadable` (case-insensitive lookups against a
  faked addon listing).

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
  `test_actionbars_visibility.lua`'s `state` table, for the pattern). This
  also applies to a few WoW-custom Lua extensions that aren't part of
  standard Lua 5.1 and so aren't there to capture unless a test installs
  them first - `string.split` (`test_chat_commands.lua`) and `table.wipe`
  (`test_blizzard_mirrortimers.lua`) are the two hit so far.
- Per-element unit frame files (`modules/unitframes/elements/*.lua`) all
  end with `Handler:RegisterElement(name, Enable, Disable, Update)` instead
  of exposing those three functions as module methods. Since
  `engine_mock.lua`'s handler stand-in doesn't define `RegisterElement`,
  override it on the handler *before* loading the file to capture the three
  local functions directly (see `test_unitframes_elements.lua`) - the same
  "small hand-written fake standing in for a WoW object" idiom above, just
  applied to the handler instead of a frame.
- A hand-written fake that uses a catch-all metatable to auto-vivify *any*
  missing method into a recording stub (so you don't have to list every
  method up front) can reintroduce the exact same kind of "always resolves
  to a truthy stub instead of nil" problem `engine_mock.lua`'s `permissive()`
  has, described above, for its *own* plain data fields - e.g. a fake fontstring
  built this way makes `Name.colorBoss` resolve to an always-truthy stub
  function instead of nil when a test leaves it unset, silently breaking an
  `if Name.colorBoss then ...` check in the real code. Prefer a small
  fake with only the specific methods a test needs explicitly defined (see
  `test_unitframes_elements.lua`'s `newFakeNameText`); reserve a catch-all
  spy for objects that only ever receive method calls, never plain field
  reads (see `test_objectives_capturebars.lua` / `test_blizzard_mirrortimers.lua`'s
  `newSpy`).
- Relatedly: don't embed a spy object *inside the same tuple you're
  comparing against one of that spy's own recorded calls* (e.g.
  `assertEquals(spy.calls[1], {"SetWidth", spy, 20})`) - the spy's `.calls`
  list already contains a call embedding the spy itself, so the freshly
  built "expected" tuple and the "actual" one both reach the same
  self-referential structure and LuaUnit's deep comparison doesn't handle
  it consistently. Have the spy's recorder drop the leading `self` a colon
  call passes instead, so a recorded call is just `{methodName, arg1, ...}`
  with no reference back to the spy.
- The embedded minimap module (`modules/minimap/`) doesn't use the
  `Engine`/`local Addon, Engine = ...` convention at all - its files do
  `local Addon, ns = ..., DiabolicUIMinimapNS`, reading a *global*
  `DiabolicUIMinimapNS` table instead. Set `_G.DiabolicUIMinimapNS = {}`
  once before loading any of its files, and call `chunk("DiabolicUI")`
  with just the one argument (see `test_minimap_api.lua`). Its
  `Core/API/*.lua` files each do `local API = ns.API or {}; ns.API = API`,
  so loading several of them against the same table accumulates all of
  their functions onto one shared `ns.API`, same as the real addon's own
  load order.

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
