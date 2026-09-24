---
title: "Conventions & Gotchas"
weight: 6
---

# Conventions & Gotchas

House rules that aren't enforced by the compiler, learned the hard way.

## WotLK 3.3.5a only

This addon targets exactly one client build, so there are no version
checks: no `IsBuild`, no build numbers, no "if this API exists" branches for
later expansions. Write against the 3.3.5 API directly:

| Later clients | 3.3.5 |
|---|---|
| `PlaySoundKitID(SOUNDKIT.IG_MAINMENU_OPEN)` | `PlaySound("igMainMenuOpen")` |
| `texture:SetColorTexture(r, g, b, a)` | `texture:SetTexture(r, g, b, a)` |
| `GetNumGroupMembers()` in a raid loop | `GetNumRaidMembers()` |
| `IsInGroup()` | `GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0` |
| `frame:SetShown(flag)` | `if flag then frame:Show() else frame:Hide() end` |
| `GameTooltip:IsForbidden()` | nothing: tooltips are never forbidden on 3.3.5 |
| `UnitIsTapDenied(unit)` | `Engine.UnitIsTapDenied(unit)` |

**Never add a missing API name to the global namespace.** Other addons
check whether names like `GetNumGroupMembers` or `SOUNDKIT` exist to decide
which client they're running on, and a backfill makes them take the wrong
code path. If a small helper is genuinely shared, put it on the private
`Engine` table in `engine/wotlk-helpers.lua`.

**Watch for hidden dependencies.** A later-client function can seem to work
only because another installed addon backfills it. `SetShown` did exactly
that: DiabolicUI2's polyfills defined it, so the gold/FPS toggles worked
until DiabolicUI2 was disabled. Before relying on a function, check that
3.3.5 itself has it.

**UI strings and constants too.** Blizzard adds global strings and
constants with every expansion, and code written for a later client reads
them as nil on 3.3.5. The taxi button's tooltip used `TAXI_CANCEL`, a
Cataclysm string, and hovering it failed with `GameTooltip:SetText(nil)`.
When 3.3.5 has no string for what you need, add one to the addon's own
locale files (`L["Request Stop"]`). `tests/test_wotlk_globals.lua` checks
every ALL-CAPS global the addon reads against the list of names the 3.3.5
client defines, `tests/data/wotlk-globals.txt`.

## Everything is `local`

A missing `local` makes a variable global, shared with Blizzard's UI and
every other addon. Two files can then silently overwrite each other, and
writing a name Blizzard's own code reads (like `_`, or a frame name such as
`WorldStateAlwaysUpFrame`) taints it, which can surface later as "action
blocked" errors that are very hard to trace back.

`tests/test_no_global_leaks.lua` enforces this. It fails on any global
assignment that isn't on its per-file `ALLOWED` list. When a global write
is intentional (overriding a Blizzard constant like `STANDARD_TEXT_FONT`),
either add it to that list or write it as `_G.NAME = value`, which the
check deliberately ignores because it's visibly on purpose.

One ordering trap when fixing a leak: a local function must be defined
*above* anything that calls it. A global function works even when defined
further down the file, because the lookup happens at call time.

## Safe cross-frame anchoring

Never give one frame two anchor points of *different types* relative to two
different frames (e.g. `TOPLEFT` to frame A and `BOTTOMRIGHT` to frame B) —
that class of layout is exactly what breaks first when either frame resizes.
Anchor via a **single point, relative to one known frame**, with a
hand-computed numeric offset instead:

```lua
-- fragile: two points, two different reference frames
frame:SetPoint("TOPLEFT", A, "TOPLEFT")
frame:SetPoint("BOTTOMRIGHT", B, "BOTTOMRIGHT")

-- robust: one point, one reference frame, an offset that encodes the intent
frame:SetPoint("TOPLEFT", A, "BOTTOMLEFT", 0, -gap)
```

## Texture canvas vs. visible art

Several of the addon's own decorative textures (anything under
`DiabolicUI_UIButton_*`, the tooltip/loot window borders, ...) have a much
larger **canvas** (`texture_size` in the relevant settings table, e.g.
`{512, 128}`) than their actual **visible art** (`size`, e.g. `{300, 51}`),
symmetrically centered within transparent padding. Sizing the texture
*frame* to a desired visible dimension means scaling the *whole canvas* by
the same ratio — not just setting the frame to the visible size, which
renders the art far smaller than intended:

```lua
local scale = desiredVisibleWidth / config.size[1]
texture:SetSize(config.texture_size[1] * scale, config.texture_size[2] * scale)
```

This shows up anywhere a background/border texture needs to stretch to fit
dynamic content — see the loot window's row backgrounds in the
[case study]({{< relref "case-study-loot-window" >}}).

## "Own the frame" over reskinning Blizzard's

When replacing a piece of Blizzard's UI rather than just recoloring it,
prefer building a fully self-owned frame/buttons over patching Blizzard's
live instance — see the [loot window case study]({{< relref
"case-study-loot-window" >}}) for the full reasoning and the concrete
technique. The short version: Blizzard's live frames come with scrollframe
clipping, multi-anchor icons, and inherited scripts you don't want and can't
fully predict; a frame you built yourself has none of that.

## Verifying a change without the game client

1. `luac5.1 -p <file>` on everything touched — catches syntax errors in
   seconds.
2. `bash tests/run_all.sh` — full LuaUnit suite; watch for `0 failures` on
   every sub-suite listed.
3. If you added, removed or renamed a `.lua` file, update the XML file that
   loads it: `tests/test_addon_loads.lua` fails on a file nothing loads, and
   on an XML entry pointing at a file that no longer exists.
4. Give a new file a short header comment saying what it's for, like the
   rest of the addon has, and a behaviour test if its logic can run without
   the client (see [Testing]({{< relref "testing" >}})).
5. Actual in-game verification (does it look right, does clicking it work)
   still has to happen by hand — say so explicitly rather than claiming a
   UI change works when it's only been syntax- and load-tested.
