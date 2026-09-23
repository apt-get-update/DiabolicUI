---
title: "Unit Frame Elements"
weight: 4
---

# Unit Frame Elements

The `UnitFrame` handler (`handlers/unitframe.lua`) is what every unit frame
(`modules/unitframes/units/player.lua`, `target.lua`, `party.lua`, `raid.lua`,
`focus.lua`, ...) is built out of. It defines a frame template plus an
**element registry** — small, reusable pieces of behavior (health bar,
power bar, name, portrait, auras, ...) that any unit frame can opt into.

## Registering an element

`modules/unitframes/elements/*.lua` each register exactly one element:

```lua
-- modules/unitframes/elements/power.lua
local Handler = Engine:GetHandler("UnitFrame")

local Update = function(self, event, ...) ... end
local Enable = function(self, unit) ... end
local Disable = function(self, unit) ... end

Handler:RegisterElement("Power", Enable, Disable, Update)
```

- **`Enable(self, unit)`** — called once when a frame turns this element on.
  `self` is the unit frame. Should register whatever events the element
  needs and return a truthy value if it actually enabled something (a
  falsy/no return means "this frame doesn't have this element", e.g. no
  `self.Power` sub-widget was created for it).
- **`Disable(self, unit)`** — the mirror image: unregister events, hide the
  widget.
- **`Update(self, event, ...)`** — does the actual work. Called directly by
  `Enable` for the initial paint, and again every time a registered event
  fires.

A unit frame opts into an element simply by having created the
correspondingly-named child widget before calling `self:EnableElement(name)`
— e.g. `units/party.lua` creates `self.Power` and later the frame
construction code calls `self:EnableElement("Power")`, which looks up
`Elements["Power"].Enable(self, self.unit)`.

## Frequent (polled) vs. event-driven updates

Most elements are purely event-driven (`self:RegisterEvent("UNIT_HEALTH",
Update)`), but a widget can opt into throttled `OnUpdate` polling instead —
useful for smooth interpolation, or for state that has no dedicated event at
all:

```lua
Health.frequent = 1/120  -- ~120 times a second, for smooth bar animation
```

```lua
if Power.frequent then
    self:EnableFrequentUpdates("Power", Power.frequent)
else
    self:RegisterEvent("UNIT_MANA", Update)
    ...
end
```

`EnableFrequentUpdates` registers the frame/element pair in a shared table
that a single `OnUpdate` script (on the handler itself, not per-frame) walks
every frame, calling `Update(object, "FREQUENT", elapsed)` once the
element's own `hz` threshold has elapsed. `event` will be the literal string
`"FREQUENT"` in that call — make sure any `event`-based filtering in your
`Update` function (see below) doesn't accidentally reject it.

## Filtering events by unit

Events like `UNIT_HEALTH` fire for *every* unit in existence, not just the
one this frame cares about — the standard guard at the top of `Update` is:

```lua
local unit_events = {
    UNIT_PORTRAIT_UPDATE = true,
    UNIT_MODEL_CHANGED = true,
    ...
}

local Update = function(self, event, ...)
    local unit = self.unit
    if not unit then return end

    local arg = ...  -- for unit events, the first vararg is the affected unit
    if event and unit_events[event] and arg ~= unit then
        return
    end
    ...
end
```

Only events *listed in `unit_events`* get filtered this way — non-unit
events (`PLAYER_ENTERING_WORLD`, `"FREQUENT"`, ...) fall through unfiltered,
since they have no unit argument to compare against.

## Worked example: the Portrait element's 2D/3D fallback

`elements/portraits.lua` is a good example of an element juggling two
sibling widgets. Party (and focus) frames can optionally show an animated
3D bust portrait (`self.Portrait`, a `PlayerModel` widget) instead of a flat
icon. The problem: a `PlayerModel` widget is its own little 3D viewport —
it stays fully **opaque** even when it has no mesh to render (e.g. the
member wandered out of the range at which the client streams in 3D models),
so it can't just be left "empty" and expected to show something else behind
it.

`UnitIsVisible(unit)` turns out to be exactly the threshold past which the
model can no longer render at all (well before the unit would actually leave
the group) — so the element keeps a second, plain 2D texture
(`self.Portrait2D`, filled via the built-in `SetPortraitTexture(texture,
unit)`) and switches between the two explicitly:

```lua
if not UnitExists(unit) or not UnitIsConnected(unit) then
    Portrait:Hide()
    if Portrait2D then Portrait2D:Hide() end
    return
end

if not UnitIsVisible(unit) then
    Portrait:Hide()
    if Portrait2D then
        SetPortraitTexture(Portrait2D, unit)
        Portrait2D:Show()
    end
else
    if Portrait2D then Portrait2D:Hide() end
    Portrait:Show()
    Portrait:ClearModel()
    Portrait:SetUnit(unit)
    ...
end
```

`Portrait2D` is `nil` for any unit frame that never created one (player,
target, raid), so every `if Portrait2D then ...` guard is also what makes
this element safe to share across frames that do and don't have the 2D
fallback widget at all.
