---
title: "Module Tour: Minimap"
weight: 14
---

# Module Tour: Minimap

`modules/minimap/` is architecturally different from every other module in
this addon — see the note in [Getting Started]({{< relref
"getting-started#repo-layout" >}}) for why it was embedded as-is rather than
ported.

```text
modules/minimap/
├── minimap.xml       # single entry point, replicates the original .toc's load order
├── Libs/              # Ace3 (AceAddon/AceDB/AceGUI/AceHook/AceTimer/AceConsole/...),
│                       # LibMoreEvents-1.0, UTF8
├── Locale/
├── Core/               # Core.lua (AceAddon registration), API/, Common/, Widgets/, Finalize.lua, Private.lua
├── Config/             # options table + AceDB defaults
└── Components/          # Menu/, Misc/ — the actual minimap pieces (border, mail icon, clock, ...)
```

## It's a separate addon in every way that matters, except the folder

`Core/Core.lua` registers itself the normal Ace3 way:

```lua
local Addon, ns = ..., DiabolicUIMinimapNS
ns = LibStub("AceAddon-3.0"):NewAddon(ns, Addon, "AceConsole-3.0", "LibMoreEvents-1.0", "AceHook-3.0")
```

It keeps its own `DiabolicUI_Minimap_DB` SavedVariable (declared in the
addon's own `.toc`, alongside `DiabolicUI_DB`), has its own AceDB defaults
in `Config/`, and doesn't call into the Engine, `GetModule`, `GetHandler`,
or any of the conventions covered elsewhere on this site. Nothing else in
the addon reaches into it either.

## Why it keeps its own SavedVariable

Pointing the minimap's AceDB at `DiabolicUI_DB` instead of
`DiabolicUI_Minimap_DB` would mean two unrelated storage systems sharing
one root table, and each one assumes it owns that table:

- **The Engine overwrites its keys every login.**
  [`ParseSavedVariables`]({{< relref "engine-architecture#how-it-gets-saved-engineparsesavedvariables" >}})
  replaces `DiabolicUI_DB[name]` for every registered Engine config.
  AceDB writes its own fixed top-level keys onto whatever table it's given
  (`profiles`, `profileKeys`, `global`, `char`, `realm`, `class`, `race`,
  `faction`, `factionrealm`). Today nothing collides only because Engine
  config names happen to be PascalCase feature names (`"LootFrame"`,
  `"ActionBars"`). A future Engine config named, say, `"Global"` wouldn't
  collide (keys are case-sensitive), but one named `"global"` would silently
  wipe the minimap's global settings on the next login, with no error.
- **Resets would stop being independent.** Anything that clears
  `DiabolicUI_DB` (like the development-only `DEVELOPER_RESET` switch)
  would take the minimap's settings with it.
- **AceDB's profile features assume sole ownership.** Profile switching,
  copying and resetting, and their callbacks, aren't written to coexist
  with a second system rewriting parts of the same root table.

None of this would crash today. The point is that it would trade a
guaranteed separation for an unwritten naming rule that nothing checks.
Keeping two SavedVariables costs one extra name on the `.toc`'s
`## SavedVariables:` line.

## Why its options panel "just works"

`Components/Menu/Menu.lua` hardcodes `local L_PARENT_CATEGORY = "DiabolicUI"`
and sets it as `panel.parent` on its own Interface-Options panel — the same
`panel.name = "DiabolicUI"` category the main
[`Menu` module]({{< relref "settings-and-locale#adding-a-new-options-panel-checkbox" >}})
registers. Blizzard's Interface Options nests any panel under a matching
parent name automatically, so this module's settings show up as a
sub-category of DiabolicUI's own options with zero glue code required on
either side — this was true even back when it shipped as a fully separate
`DiabolicUI-Minimap` addon, and stayed true unchanged after the merge.

## `handlers/blizzard.lua`'s `Minimap` element

Not part of this module — a small, separate `Minimap = { OnDisable = ... }`
entry in the `BlizzardUI` handler that `SetParent(UIHider)`s a few default
Blizzard minimap pieces. It predates this module being merged in and stays
harmless/idempotent alongside it.
