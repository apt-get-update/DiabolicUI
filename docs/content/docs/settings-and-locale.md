---
title: "Settings & Locale"
weight: 5
---

# Settings & Locale

## `settings/` vs `defaults/`

See the config table in [Engine Architecture]({{< relref
"engine-architecture#config-and-static-data" >}}) for the short version.
Concretely:

- `settings/blizzard.lua`, `settings/actionbars.lua`, `settings/unitframes.lua`,
  ... — one `Engine:NewStaticConfig("Name", { ... })` per file, holding
  sizes, positions, texture paths, backdrops. Read back with
  `Engine:GetDB("Name")`. Never touched by the options panel, never written
  to `DiabolicUI_DB`.
- `defaults/lootframe.lua`, ... — one `Engine:NewConfig("Name", { ... })` per file, holding
  the actual user-toggleable values. Read back with
  `Engine:GetConfig("Name")`. These *do* round-trip through
  `DiabolicUI_DB`.

Both kinds get wired into the load order the same way: an
`Engine:New*Config(...)` call in a `.lua` file, listed in that folder's own
`defaults.xml`/`settings.xml`, which is `<Include>`d from the `.toc`.

## Locale

`locale/locale-enUS.lua` and `locale/locale-frFR.lua` populate the same
lookup table `L`, fetched anywhere with `Engine:GetLocale()`:

```lua
-- locale-enUS.lua (the reference locale — every key must exist here)
L["Loot"] = true
L["Reskin Loot Window"] = true

-- locale-frFR.lua (translations only — omit a key to fall back to enUS)
L["Loot"] = "Butin"
L["Reskin Loot Window"] = "Relooker la fenêtre de butin"
```

`L["key"] = true` in the English file means "the key *is* its own English
text" — there's no separate `= "Loot"` to keep in sync. Only non-English
locale files ever assign an actual translated string.

## Adding a new options-panel checkbox

The pattern (see `modules/menu/menu.lua`) for a toggle that needs a UI
reload to take effect, using the loot window's checkbox as a template:

1. `defaults/lootframe.lua`: `Engine:NewConfig("LootFrame", { enableSkin =
   false })`, included from `defaults/defaults.xml`.
2. `locale/locale-enUS.lua`: add the label/description keys.
3. `modules/menu/menu.lua`: add a checkbox bound to
   `Engine:GetConfig("LootFrame").enableSkin`, in whichever section of the
   panel it belongs.
4. The module that actually implements the feature reads
   `self.db = self:GetConfig("LootFrame")` in `OnInit` and checks
   `self.db.enableSkin` in `OnEnable` before doing anything.

Decide up front whether the setting is shared or per-character.
`GetConfig(name)` returns the `global` profile. Pass `"character"`,
`"realm"` or `"faction"` as the second argument to scope it, and use the
same profile everywhere that setting is read or written, including the
options panel. See
[Saved config profiles]({{< relref "engine-architecture#saved-config-profiles" >}}).
