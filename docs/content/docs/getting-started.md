---
title: "Getting Started"
weight: 1
---

# Getting Started

## What this is

DiabolicUI is a full UI-replacement addon for the **WotLK 3.3.5a** client
(`Interface: 30300`, Lua 5.1). It targets private servers running that client
exclusively — there is no later-expansion code path to fall back to, and none
should be added (see [Conventions]({{< relref "conventions" >}})).

## Repo layout

```text
DiabolicUI/
├── DiabolicUI.toc        # load order, SavedVariables, addon metadata
├── locale/                # locale.xml + locale-enUS.lua / locale-frFR.lua
├── engine/                # the Engine framework (engine-core.lua) and wotlk-helpers.lua
├── data/                  # static data tables (colors, formatting, ...)
├── handlers/               # shared task handlers (unitframe, actionbutton, ...)
├── media/                  # fonts, statusbars, sound
├── settings/                # static, non-user-facing config tables
├── defaults/                # user-configurable settings (Engine:NewConfig)
├── modules/                 # the actual features, one folder per module
│   ├── actionbars/
│   ├── blizzard/             # reskins/behavior patches for Blizzard's own frames
│   ├── chat/
│   ├── menu/                  # the DiabolicUI options panel
│   ├── minimap/                # embedded, Ace3-based (see note below)
│   ├── nameplates/
│   ├── objectives/
│   └── unitframes/
├── tests/                    # LuaUnit test suite, run outside the game client
└── docs/                      # this site
```

Every folder that WoW loads has its own `<foldername>.xml` that lists the
`.lua`/`.xml` files inside it in load order, and is `<Include>`d from its
parent — `modules/modules.xml` includes each module's own XML, which is
itself included from `DiabolicUI.toc`.

> [!NOTE]
> **`modules/minimap` is the exception.** It's a large, self-contained Ace3
> addon (AceAddon/AceDB/AceHook/AceTimer) that was merged in as a module
> folder rather than ported to the Engine framework — porting working,
> tested Ace3 code to a different framework for no functional gain wasn't
> worth the risk. Its own options panel nests under DiabolicUI's Interface
> Options category automatically (it hardcodes `"DiabolicUI"` as its parent
> category), and it keeps its own `DiabolicUI_Minimap_DB` SavedVariable,
> declared in the `.toc` alongside the main `DiabolicUI_DB`. Nothing else in
> the addon depends on it, and it doesn't depend on the Engine.

## Running the tests

The test suite is plain [LuaUnit](https://github.com/bluebird75/luaunit) and
runs completely outside the game client, against a set of small stub globals
that fake just enough of the WoW API to load the addon's Lua files:

```bash
bash tests/run_all.sh
```

Before committing any change, also syntax-check whatever you touched with the
Lua 5.1 compiler (this catches typos test coverage won't, and is much
faster than a full client restart):

```bash
luac5.1 -p path/to/file.lua
```

There is no way to run the actual game client from this environment — UI
changes still need to be verified in-game by reloading (`/reload`) and
checking the golden path plus a couple of edge cases by hand.
