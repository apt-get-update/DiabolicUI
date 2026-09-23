---
title: "Engine Architecture"
weight: 2
---

# Engine Architecture

Everything in the addon is wired together by `engine/engine-core.lua`, a
single global `Engine` table passed to every file as the addon's private
namespace (`local ADDON, Engine = ...`). There's no Ace3, no oUF — the whole
module/handler/config system below is hand-rolled specifically for this
addon.

## Modules and Handlers

Two kinds of objects get registered with the Engine:

- **Modules** (`Engine:NewModule(name, loadPriority, makeUnsecure)`) — one
  per feature (`"UnitFrames"`, `"ActionBars"`, `"Menu"`, `"Blizzard: LootFrame"`, ...).
  A module owns its own lifecycle (`OnInit`/`OnEnable`) and, optionally, a set
  of **widgets** (see below).
- **Handlers** (`Engine:NewHandler(name)`) — shared logic used *by* modules,
  not modules themselves (`"UnitFrame"`, `"ActionButton"`, ...). A handler
  defines a reusable frame template plus an **element registry** (see
  [Unit Frame Elements]({{< relref "unitframe-elements" >}})).

Both are looked up later by name:

```lua
local Module = Engine:GetModule("UnitFrames")
local Handler = Engine:GetHandler("UnitFrame")
```

`loadPriority` is one of `"HIGH"`, `"NORMAL"` (the default) or `"LOW"` — it
only affects *when* `OnEnable` fires (`"LOW"` delays it until after
`PLAYER_LOGIN`), see below.

## Module lifecycle ordering

This is the single most important guarantee in the whole framework, and the
reason cross-module calls like `Engine:GetModule("UnitFrames"):SomeMethod()`
are safe to make from another module's `OnEnable` without worrying about
which module happens to load first:

```lua
-- engine/engine-core.lua, Engine.Init
for i = 1, #PRIORITY_INDEX do
    self:ForAll("Init", PRIORITY_INDEX[i], event, ...)
end
for i = 1, 2 do -- "HIGH" and "NORMAL" only
    self:ForAll("Enable", PRIORITY_INDEX[i], event, ...)
end
```

**Every module's `OnInit` runs to completion before any module's `OnEnable`
runs at all.** `pairs()` iteration order within one priority tier is not
defined, so relying on module A initializing before module B is never safe —
but relying on *all* `OnInit`s having already run before *any* `OnEnable`
runs is always safe. Put anything another module's `OnEnable` might need
(config lookups, `self.db = self:GetConfig(...)`) in `OnInit`, not `OnEnable`.

`"LOW"` priority modules are the exception: their `OnEnable` is deferred to a
separate pass after `PLAYER_LOGIN`, run from `Engine.Enable` rather than
`Engine.Init`.

## Config and static data

Two parallel systems exist, and the naming is easy to mix up:

| | User-configurable (saved) | Static (not saved) |
|---|---|---|
| Declare | `Engine:NewConfig(name, defaults)` | `Engine:NewStaticConfig(name, table)` |
| Read | `Engine:GetConfig(name[, profile])` | `Engine:GetDB(name)` |
| Lives in | `defaults/*.lua` | `settings/*.lua`, `data/*.lua` |

- `GetConfig` results are backed by `DiabolicUI_DB` (the addon's
  SavedVariable) and are what options-panel checkboxes/sliders read and
  write — e.g. `defaults/lootframe.lua`'s `Engine:NewConfig("LootFrame", {
  enableSkin = false })`, flipped by a checkbox in `modules/menu/menu.lua`.
- `GetDB` results are plain read-only Lua tables baked into the addon —
  sizes, positions, texture paths, color tables. They never change at
  runtime and never get written to disk.

A module typically reads both in `OnInit`:

```lua
Module.OnInit = function(self)
    self.config = self:GetDB("Blizzard").loot   -- static: sizes, textures, positions
    self.db = self:GetConfig("LootFrame")        -- saved: user's on/off toggle
end
```

## Saved config profiles

`Engine:NewConfig(name, defaults)` doesn't store one copy of the defaults —
it stores four independent **profiles**, each a fresh copy:

```lua
configs[name] = {
    defaults = copyTable(config),
    profiles = {
        global    = copyTable(config),
        realm     = { [realm]                  = copyTable(config) },
        faction   = { [faction]                = copyTable(config) },
        character = { [character.."-"..realm]  = copyTable(config) },
    }
}
```

`Engine:GetConfig(name, profile)` picks one. Leaving `profile` out returns
`global`; the others are `"realm"`, `"faction"` or `"character"`, each keyed
to the current player automatically:

```lua
self.db = self:GetConfig("LootFrame")                  -- shared by every character
self.db = self:GetConfig("ActionBars", "character")    -- per character
```

`ActionBars` is the main user of a non-global profile — bar layout is
per-character, since two characters rarely want the same bars. Most other
settings are global. `Engine:GetConfigDefaults(name)` returns the untouched
defaults, e.g. for a "reset to defaults" button.

### How it gets saved: `Engine:ParseSavedVariables`

`DiabolicUI_DB` is the only SavedVariable the Engine owns. At startup,
`Engine.Init` calls `ParseSavedVariables()` **before** any module's
`OnInit`, which does two passes:

1. **Merge.** For each key in the `DiabolicUI_DB` loaded from disk that
   matches a registered config, it copies the stored
   `global`/`realm`/`faction`/`character` values over the fresh defaults.
   Keys that don't match any registered config are skipped.
2. **Re-point.** For **every** registered config, it replaces the stored
   entry outright:

   ```lua
   for name,data in pairs(configs) do
       DiabolicUI_DB[name] = { profiles = configs[name].profiles }
   end
   ```

   From here on, `DiabolicUI_DB[name].profiles` *is* the live table
   `GetConfig` hands out, so changing a value in a module's `self.db` is
   what gets written at logout. No explicit "save" call is needed.

Consequences worth knowing:

- **Reading config in `OnInit`, not at file load, matters.** The merge
  replaces the profile tables, so a reference grabbed before
  `ParseSavedVariables` runs would point at the discarded defaults. The
  source comment says it outright: *"if the modules do it right, they
  haven't fetched their config or db yet."*
- **Adding a new key to an existing config is safe.** New keys come from
  the defaults, and stored values are copied over them, so existing players
  get the new default for anything they've never saved.
- **Renaming or removing a config leaves the old data behind.** The merge
  pass skips unknown keys and the re-point pass only writes registered
  ones, so an old entry just sits in `DiabolicUI_DB` forever, harmlessly.
- **The Engine assumes it owns every top-level key it has a config for.**
  This is why the embedded minimap keeps its own SavedVariable; see
  [Module Tour: Minimap]({{< relref "module-minimap#why-it-keeps-its-own-savedvariable" >}}).

There's also a `DEVELOPER_RESET` switch at the top of `engine-core.lua`
that `wipe()`s all of `DiabolicUI_DB` before parsing. It's commented out
and meant only for development, when the stored format changes.

## `engine/wotlk-helpers.lua`

The first file the addon loads. It holds the few 3.3.5 helpers shared
across modules, stored on the private `Engine` table rather than as
globals:

- `Engine.UnitIsTapDenied(unit)`: true when someone outside your group
  tagged the unit, so you get no loot or credit (gray health bars). Built
  from the native `UnitIsTapped` family. Modules pick it up with
  `local UnitIsTapDenied = Engine.UnitIsTapDenied`.
- The `/rl`, `/reload` and `/reloadui` slash commands.

There is no client-version detection anywhere in the engine. The addon
runs on exactly one build, so there's nothing to branch on; see
[Conventions]({{< relref "conventions#wotlk-335a-only" >}}).
