---
title: "Module Tour: Nameplates"
weight: 11
---

# Module Tour: Nameplates

`modules/nameplates/nameplates.lua` is a full custom nameplate
implementation — a single ~1700-line file (after the WotLK-only
[dead-code sweep]({{< relref "conventions#wotlk-335a-only" >}})
removed the parallel `Cata`/`MoP`/`WoD`/`Legion` metatables it used to carry)
that builds and manages its own replacement plates entirely.

It yields to half a dozen other known nameplate addons via
[`SetIncompatible`]({{< relref "modules-and-widgets#opting-out-setincompatible" >}}):
`gUI4_NamePlates`, `NeatPlates`, `Kui_Nameplates`, `SimplePlates`,
`TidyPlates`, `TidyPlates_ThreatPlates`, `TidyPlatesContinued`.

## The metatable pattern

Every plate is a plain frame wrapped in a shared metatable
(`NamePlate_WotLK_MT`) that supplies all of its methods — `UpdateAlpha`,
`UpdateColor`, `HandleBaseFrame`, and so on — the same "one shared
prototype, many instances" shape as the
[unit frame handler]({{< relref "unitframe-elements" >}}), just without a
registered element system on top of it, since a nameplate isn't a
`UnitFrame`-handler frame:

```lua
local plate = setmetatable(
    Engine:CreateFrame("Frame", "Engine" .. (name or baseFrame:GetName()), worldFrame),
    NamePlate_WotLK_MT
)
```

(Before the dead-code sweep this was `NamePlate_Current_MT`, an alias picked
at runtime between four near-identical per-expansion metatables — collapsed
down to the one that was ever actually reachable on this client.)

## Threat/class coloring

Real class colors come from iterating the `RAID_CLASS_COLORS` table against
the plate's unit, setting `hasClass` when a match is found — a heuristic
"is this maybe a monk?" color-guess branch that used to run *after* that (a
leftover from a client version where class detection was less reliable) is
now just its unconditional enemy-player fallback, since the real detection
above already handles every actual class correctly on this client.

## What to check before touching this file

Given its size and the amount of now-removed cross-expansion branching it
used to carry, grep for the specific method or event you're changing rather
than reading top-to-bottom — and re-run
[`luac5.1 -p`]({{< relref "testing#syntax-checking" >}}) immediately after
any edit here in particular, given how much of this file is large blocks of
per-plate state manipulation with no unit tests exercising it directly.
