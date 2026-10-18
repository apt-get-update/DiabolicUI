# Tests

Tests for DiabolicUI that run outside the WoW client, using
[LuaUnit](https://github.com/bluebird75/luaunit) (vendored in
`tests/luaunit.lua`, BSD licensed) under plain Lua 5.1 (the version WotLK
3.3.5 embeds): unit tests for single functions, and session tests that boot
the whole addon in a fake 3.3.5 client and play the game at it.

This is **not** in-game testing and never touches the `.toc` - none of this
runs for players, it's a local dev tool only.

## Running

From the addon root (`DiabolicUI/`):

```bash
tests/run_all.sh            # every test file, one after another
lua5.1 tests/test_tooltip_positioning.lua   # a single file
```

Each `tests/test_*.lua` file is self-contained and runnable on its own.

### Coverage

```bash
tests/coverage/run.sh            # summary per area; per-file table in tests/coverage/report.txt
tests/coverage/run.sh --readme   # also refresh the table in README.adoc
```

`coverage/hook.lua` is loaded in front of each test file and records every
addon line that runs (a `debug.sethook` line hook; test files, `docs/` and
vendored `Libs/` are left out). The tests run in parallel, one job per CPU
(`JOBS=2 tests/coverage/run.sh` to change that), each into its own file
under `coverage/stats.d/`, merged at the end: the session tests, the slow
ones under the hook, one test per job, the other files one file per job. Lua 5.1.5 itself crashes now and then under a
line hook on a busy machine ("double free or corruption"): a test file that
crashes is run once more. `coverage/report.lua` counts a line as
executable when `luac5.1 -l` shows code for it, leaving out two kinds of
jumps that can never run, whose line (often an `if`'s `end`) would never
count as covered: the jump back after a `for ... in` loop's TFORLOOP
(which does the jump itself), and a jump right after a `return` that
nothing jumps to (the compiler still ends a `return`ing branch with a jump
past the rest of the `if`). No luacov needed. The raw hits (`stats.out`) and `report.txt` are
git-ignored.

## What's covered

- `test_no_global_leaks.lua` - fails if any addon file assigns a global
  variable (a missing `local`) that isn't on its explicit per-file `ALLOWED`
  list. Reads the compiler's bytecode listing (`luac5.1 -l`), so it needs
  `luac5.1` on the PATH (override with `LUAC=...`). Vendored code under
  `modules/minimap/Libs/` is skipped.

- `test_addon_loads.lua` - loads the **whole addon** the way the client
  does: `DiabolicUI.toc`, then every `<Include>`/`<Script>` of its XML files
  in order, with one shared addon table - the real engine, handlers,
  settings, and the minimap module with its vendored Ace3 libraries. Also
  fails when an XML file points at a file that doesn't exist, or when a
  `.lua` file (outside vendored `Libs/`) isn't loaded by anything - except
  the ones listed in its `NOT_LOADED` table, with the reason.
- `test_all_modules_load.lua` - a load-only "smoke test" for **every**
  `handlers/` and `modules/` file (found on disk, so new files are covered
  automatically; the minimap module is left to `test_addon_loads.lua`):
  each one is loaded standalone against a fresh Engine mock and we assert
  it doesn't error while doing so. This can't verify behaviour, but it
  catches load-time regressions - typos, a removed function a file still
  calls at file scope, a bad reference, etc.
- `test_engine_core.lua` - the real `engine/engine-core.lua` on
  `mocks/frame_mock.lua`, driven by firing events through its own event
  frame: module/handler/widget registration and its errors, the startup
  order (every OnInit before any OnEnable, LOW priority waiting for
  PLAYER_LOGIN), SetIncompatible, event and message dispatch and their
  misuse errors, `Engine:Wrap` deferring calls until combat ends (`nil`
  arguments included), `Place` and `ForAll`, and saved config profiles
  (`NewConfig`, `GetConfig`, `ParseSavedVariables`).
- `test_wotlk_globals.lua` - fails when addon code reads an ALL-CAPS
  Blizzard global (a UI string like `TAXI_CANCEL`, or a constant) that the
  3.3.5 client doesn't define: code written for a later expansion, which
  reads nil on WotLK. `tests/data/wotlk-globals.txt` is the list of names
  the 3.3.5 (12340) client's own UI defines, generated from
  [Goldpaw/WoW_UI_Source_WotLK](https://github.com/Goldpaw/WoW_UI_Source_WotLK).
- `test_api_usage.lua` - the same idea for the rest of the API: fails when
  addon code reads a lowercase global nobody defines (a typo or a missing
  `local`, which reads nil), registers an event only later expansions fire
  (`GROUP_ROSTER_UPDATE` instead of `PARTY_MEMBERS_CHANGED` /
  `RAID_ROSTER_UPDATE`, ...), or uses a function or frame method from a
  later expansion (`SetShown`, `GetSpellCharges`, ...). Each list says
  what 3.3.5 uses instead; a planted-mistakes test checks the detectors.
  Also fails when a secure snippet calls a method nobody defines
  (`control:CallMethod("SaveNumBars")`): code in a string, which otherwise
  only fails in game, as "Invalid method".
- `test_locales.lua` - `locale/locale_handler.lua`'s fallback to English,
  every locale file loading and assigning each key once, translations only
  using keys that exist in `locale-enUS.lua`, every literal `L["..."]` key
  in the code existing there too, and every English text being used.
- `test_data_helpers.lua` - `data/functions.lua` (`F.Short`, in 万 and 亿
  on Chinese clients too, `F.Colorize`),
  `data/aura-functions.lua` (the `isBossDebuff` /
  `isCastByPlayer` extras) and `engine/wotlk-helpers.lua`
  (`Engine.UnitIsTapDenied`, `/rl`).
- `test_unitframes_portraits.lua` - `elements/portraits.lua`: 3D model in
  range, 2D portrait out of range, both hidden offline, camera choice
  (female humans and humanoid NPCs, the Caverns of Time illusion, a druid
  in a form).
- `test_unitframes_runes.lua` - `elements/runes.lua`, the death knight
  runes: Blizzard's display order, colors by rune type (death runes too),
  the fill cropped to recharge progress, and the DiabolicUI2 visibility
  rules (dimmed while recharging, hidden out of combat when all are ready,
  hidden in vehicles).
- `test_unitframes_raid.lua` - `units/raid.lua`'s debuff filter: the WotLK
  dispel list per class, Cleanse Spirit for shaman curses, boss debuffs;
  and its layout by subgroup under "Group N" labels, which waits for the
  end of combat when the roster changes in combat (the frames are secure).
- `test_unitframes_shared.lua` - `units/shared.lua`, what the smaller unit
  frames share: health colors by status, class and reaction, the colors
  set only on change, the borders lit on mouseover, and the enemy and
  group aura filters branch by branch.
- `test_unitframes_health_power.lua` - `elements/health.lua` and
  `elements/power.lua`: bar values, the value text, dead / ghost /
  offline, power colors (an orb's too), the druid's mana orb in forms, `Enable` reporting
  success (a frame with only a mana bar too), and polls (`"FREQUENT"`) that
  find nothing changed skipping the work but still refreshing twice a
  second.
- `test_bars_layout.lua` - `handlers/statusbar.lua` and `handlers/orb.lua`
  on fake frames that count calls: the spark pulses every frame, but the bar
  or orb is only laid out again when its value, range, size, texture or crop
  changes.
- `test_actionbars_combat.lua` - combat lockdown in `handlers/actionbutton.lua`
  (cast on key down), `elements/pet.lua` and `elements/stance.lua`: nothing
  secure changes in combat, the change happens when combat ends, and the
  end-of-combat event is let go again.
- `test_actionbars_buttons.lua` - `handlers/actionbutton.lua`'s
  `UpdateUsable` (usable / out of range / out of mana / unusable, redrawn
  only on change or when forced) and `elements/artwork.lua`'s border layers
  (empty, normal, checked; hovered or not).
- `test_objectives_tracker.lua` - `objectives/tracker.lua`'s quest tracker
  fade (delay, fade, hover, Questie vs. Blizzard tracker switching).
- `test_actionbars_floaters.lua` - `elements/floaters.lua`'s taxi "request
  early landing" button visibility, including waiting out combat.
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
- `test_chat_cleaner.lua` - `modules/chat/cleaner.lua`'s shorter system
  lines, with the WotLK enUS global strings: loot, money, experience,
  reputation, honor, skills, level ups, quests, away/busy/rested,
  online/offline, auctions and achievements, each group's option, channel
  notices (with the bookkeeping of a channel left) and empty lines hidden,
  and patterns for translations that reorder their arguments.
- `test_chat_copy_weblinks.lua` - `modules/chat/filters.lua`'s "Copy Web
  Links" feature (toggled by its own option, on by default): what counts
  as a web address (schemes, www., e-mails, IPv4, domains with a path or a
  common top level domain) and what doesn't ("etc.", "v3.3.5a"), the light
  blue `|Hurl:...|h` link, brackets and punctuation kept out of it, links,
  textures and colors left alone, the hover tooltip, and the replaced
  `SetItemRef` that opens the copy popup on a left-click of that link,
  swallows a right-click on it, and forwards every other link type
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
- `test_blizzard_itemtooltips.lua` - `modules/blizzard/itemtooltips.lua`,
  the Diablo III style item tooltips: Blizzard's DPS / armor / durability
  format strings turned into patterns (English and French clients), and
  what it reads and rewrites when a tooltip shows an item (name, icon,
  quality color, sell price, the big-number line, the durability line
  moved to the footer, comparison tooltips, uncached items). The layout
  itself needs real frame geometry and is checked in game.
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

### Session tests

Each one boots the addon in the fake client (`tests/mocks/client.lua`, see
"The fake client" below) and checks a part of it the way a player meets it:

- `test_session_login.lua` - every class logs in cleanly; a `/reload` with
  the last session's saved variables, and a new character's first login;
  every event the addon listens to, in and out of combat; every frame with
  a mouse script hovered and clicked.
- `test_session_unitframes.lua` - the player's orbs (every power type, the
  druid's mana in forms, auras, weapon enchants, the vehicle), target by
  classification, its aura filters and sounds, cast bars (latency, channels,
  long names), target of target, focus, party (roles: assigned, or guessed
  from inspected talents), raid, boss and arena frames, the pet, the test
  mode previews.
- `test_session_actionbars.lua` - the menus (main, micro buttons, bar
  layout, bags, gold and fps), the online count on the social button, the
  talent specialization switch on the skull, the XP and
  reputation bars, the pet and stance bars, the vehicle and taxi buttons,
  the bar count commands and the cast-on-key-down option (after a reload
  too).
- `test_session_handlers.lua` - the shared handlers through their own API:
  popups (one to three buttons, no title or text, pressed looks, several at
  once), status bars and orbs (directions, smoothing, the spark, crops,
  colors), the action buttons (flashing, usability, cooldowns, stacks,
  grid, pet actions, tooltips), the unit frames' menus and tooltips, and
  the engine's `/diabolic setscale` and `resetsetup`.
- `test_session_nameplates.lua` - 3.3.5's nameplates read and restyled:
  name, level, icons, reaction and class colors, threat, the target's
  plate, fading, castbars.
- `test_session_tooltips.lua` / `test_session_itemtooltips.lua` - unit and
  aura tooltips, inspecting with Shift, following the cursor, the skins;
  the Diablo III item tooltip layout.
- `test_session_minimap.lua` - the embedded minimap module: its look, zone
  text, clock, mail, compass, edit mode, options page and slash commands.
- `test_session_objectives.lua` - world state scores and timers, capture
  bars, error and quest messages, PvP emotes.
- `test_session_blizzard.lua` - the loot window, bag and bank slots, tinted
  panels, the Escape menu, mirror timers, durability and vehicle seat
  anchors, fonts and combat text, popups and the Dungeon Finder's dialogs.
- `test_session_chat.lua` - chat bubbles, the chat windows (input box,
  buttons, IM style, whisper windows, the stuck key guard, the layout
  question, a hand-placed window kept) and copying web links.
- `test_session_menu.lua` - every widget of the options pages, the reload
  question, cancel and refresh, `/diabolic config`.

`tests/mocks/session.lua` has their shared helpers: `assertClean(client)`
(fails with every Lua error and blocked action the client recorded; end
each test with it), `item(...)` to put an item in the client's item cache,
`tooltipLines(tooltip)` and `stripColors(text)`.

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
- `tests/mocks/frame_mock.lua` is a small fake of the frame API for tests
  that drive frames through their scripts (`frame:Fire("OnEvent", ...)`,
  `frame:Fire("OnUpdate", elapsed)`). It only has the methods it lists - no
  catch-all - so unset fields read as nil, like on a real frame.
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

## The fake client

`tests/mocks/client.lua` boots the real addon the way WoW does:
`addon_loader.lua` reads `DiabolicUI.toc` and every XML file it includes
(running the scripts, creating the `<Font>` objects), the saved variables
are put in place after the files ran and before `ADDON_LOADED`, then the
login events fire. A test then drives it:

```lua
local client = Client.boot({ class = "DRUID", world = function(world) ... end,
	savedVariables = { DiabolicUI_DB = { ... } } })
client:FireEvent("PLAYER_TARGET_CHANGED")
client:Tick(0.5)                 -- OnUpdate, animations, state drivers
client:Hover(frame); client:Click(button)
client:EnterCombat()             -- protected frames refuse changes
Session.assertClean(client)
```

- `client_widgets.lua` - the widget types with the 3.3.5 method set (a
  method that came later is missing, like in game) and real state: points
  and a layout engine (`GetLeft`, `GetWidth`... of anchored frames),
  visibility through parents, scripts and hooks, fonts that measure text,
  strict color setters. Every widget table holds a `[0]` userdata handle,
  so a deep-copied frame table still counts as a frame.
- `client_api.lua` - the game API, answering from `client.world` (units,
  items, bags, loot, world states, CVars, addons, ...). Change the world in
  `options.world` before login, or in `client.world` during a test.
- `client_blizzard.lua` - Blizzard's frames and FrameXML functions the
  addon touches, built after the 3.3.5 FrameXML (names, parents, templates,
  which ones start hidden). Load-on-demand addons are built when loaded.
  The windows DiabolicUI restyles (mail, merchant, social, spellbook,
  talents, inspect, auction house...) come from `tests/data/framexml.lua`,
  generated from Blizzard's own FrameXML by `tests/tools/framexml.py`
  (their names, types, parents, sizes, first anchor, art, templates
  expanded); whatever's made by hand above is kept, and what it lacks is
  added under it. Run the script again after adding a window to its list.
- `client_secure.lua` - the secure handler templates: snippets run in a
  restricted environment against frame handles, state drivers, unit
  watches, `WrapScript`, `RunFor`, `ChildUpdate`, auto hide.

Handlers run protected: an error is recorded in `client.errors` with a
traceback instead of stopping the test, and an action refused in combat in
`client.blocked`. Globals nobody defines read nil, except ALL CAPS names
(UI strings), which read as their own name; both are listed in
`client.missing`.

When the addon needs a frame or function the fake client lacks, add it
there the way the 3.3.5 client has it (check the FrameXML), not the way the
test would like it.

Two LuaUnit pitfalls with it: LuaUnit prints the test table between tests,
so keep the client out of `self` (or clear it in `tearDown`); and
`assertEquals` on long strings is slow to diff, so report a long problem
list with `lu.fail` (as `assertClean` does).

## Scope and limitations

The unit tests only work for logic that's reachable without a deep tree of
frame/widget interactions - mostly pure calculations, plus anything whose
inputs and outputs are plain values/tables. Frame layout, templates, game
state and the options pages are the session tests' job. Neither can tell
whether the art looks right, or where the real client behaves differently
from the fake one; that still needs a `/reload` in game.

If you want a new file's *behaviour* covered (beyond the load-only smoke
tests it already gets automatically), the file first needs to be
checked for what it touches *at file scope* (outside any `function...end`)
- those are the only calls that must be individually mocked for `loadfile`
to succeed without the permissive auto-stub. Everything inside a function
body only matters for the specific functions a test actually calls.
