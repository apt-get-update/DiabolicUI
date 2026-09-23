---
title: "Module Tour: Objectives"
weight: 13
---

# Module Tour: Objectives

`modules/objectives/` covers the quest tracker, world-state UI (capture
bars, PvP timers), zone text, and a couple of small standalone extras.

| File | Module | Covers |
|---|---|---|
| `tracker.lua` | `ObjectiveTracker` | Fades the quest tracker: Questie's when it's in use, Blizzard's `WatchFrame` otherwise |
| `capturebars.lua` | `CaptureBars` | Battleground/world-PvP capture-point bars |
| `worldstate.lua` | `WorldState` | World state UI: battleground scores and zone objective text |
| `zone.lua` | `ZoneText` | Disables Blizzard's own zone text in favor of the `BlizzardUI` handler's element |
| `warnings.lua` | `Warnings` | Fading raid-warning-style message display |
| `pvpemotes.lua` | `PvPEmotes` | Automatic emotes on PvP killing blows |

## `tracker.lua` (`ObjectiveTracker`)

Fades whichever quest tracker is in use out after it hasn't been hovered
for a while, and back in on hover. The transition itself takes
`FADE_DURATION = .3` seconds. How long to wait before fading (`fadeDelay`)
and how far to fade (`fadeOpacity`) are user settings in the
`ObjectiveTracker` config.

**Which tracker.** `GetTracker()` returns `Questie_BaseFrame` if it exists
and is shown, and `_G.WatchFrame` otherwise. It runs on every tick instead
of once, for two reasons:

- Questie builds its tracker lazily from a coroutine some time after
  login, and no event reliably fires once it exists.
- The player can switch Questie's tracker on or off at any time from
  Questie's own options.

When the result changes, the old frame's alpha is reset to 1 before
switching, so it isn't left stuck partway through a fade.

**Hover detection.** Questie disables mouse input on its tracker
(`EnableMouse(false)`) whenever it's locked, which is its default state,
so `OnEnter`/`OnLeave` never fire on it. Hover is detected geometrically
instead, by comparing the cursor position against the frame's rect on each
tick. That works the same way for both trackers.

Only `SetAlpha` is used, never `Show`/`Hide`/`SetPoint`. Alpha changes are
allowed in combat, which matters because `WatchFrame`'s quest item buttons
are secure action buttons.

## `capturebars.lua`

Builds its own `CaptureBar` frame type (`Engine:CreateFrame("Frame")`, used
as a prototype/constructor the way most custom widgets in this addon are)
and drives it from `GetNumWorldStateUI`/`GetWorldStateUIInfo` — the same
low-level API Blizzard's own capture-bar UI reads from, rather than
patching Blizzard's existing bar frames.

## `zone.lua`

The shortest module in the addon — `OnEnable` is a single line,
`self:GetHandler("BlizzardUI"):GetElement("ZoneText"):Disable()`. All the
actual replacement zone-text behavior (fade timing, expand-from-left-or-right)
lives in the `BlizzardUI` handler's `ZoneText` element, not in this file;
this module exists purely to turn Blizzard's own version off.

## `pvpemotes.lua`

Watches the combat log for the player (or their pet) landing a killing blow
on another player, then `DoEmote`s at the victim — a random pick from a
fixed, alphabetized emote list once the player already has achievement
`#247` (checked via `GetAchievementInfo`), or a fixed `"HUG"` before that. A
small, self-contained flavor feature with no config UI of its own.
