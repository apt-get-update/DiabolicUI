---
title: "Module Tour: Action Bars"
weight: 9
---

# Module Tour: Action Bars

`modules/actionbars/` is the addon's biggest module, and the clearest real
example of the widget-per-file pattern from
[Modules & Widgets]({{< relref "modules-and-widgets" >}}).

```text
modules/actionbars/
├── actionbars.lua        # Engine:NewModule("ActionBars"), ties the rest together
├── controllers/           # frame-anchoring/paging controller widgets
├── templates/             # shared button/bar layout templates
└── elements/
    ├── bar1.lua .. bar5.lua  # the five main action bars, one widget each
    ├── artwork.lua            # bar background art + range/mana desaturation
    ├── floaters.lua           # stance bar toggle, vehicle/taxi exit buttons
    ├── keybinds.lua           # keybind text overlay on buttons
    ├── menu.lua               # the Micro Menu (main menu button row)
    ├── pet.lua                # pet action bar
    ├── reputation.lua         # reputation/XP-adjacent bar bits
    ├── social.lua              # social/raid/PvP micro-buttons
    ├── stance.lua              # stance/shapeshift bar
    ├── vehicle.lua              # vehicle action bar
    └── xp.lua                    # experience bar
```

Every file under `elements/` is a **widget** on the single `"ActionBars"`
module (`Module:SetWidget("Bar: Floaters")`, etc.), not a module of its own —
see [Modules & Widgets]({{< relref "modules-and-widgets#widgets" >}}).

## Floating buttons (`elements/floaters.lua`)

Holds the stance-bar toggle button, the vehicle exit button, and the taxi
cancel-flight button. The taxi button is a good example of an easy
`UnitOnTaxi`-driven show/hide bug: it's shown by `UpdateTaxiExitButtonVisibility`
on a handful of events (`UPDATE_BONUS_ACTIONBAR`, `UNIT_ENTERED_VEHICLE`,
`PLAYER_ENTERING_WORLD`, ...) plus `PLAYER_CONTROL_LOST`/`PLAYER_CONTROL_GAINED`
— the pair that actually fires the instant a taxi ride starts/ends. Without
those last two, the button gets stuck shown after landing, since none of the
"vehicle" events apply to an ordinary flight path at all.

## Button usability state (`handlers/actionbutton.lua`)

Not part of this module folder, but the handler every action/spell/item
button on every bar is built from. `Button:UpdateUsable()` desaturates a
button's icon based on a `usableState` string — `"normal"`, `"unusable"`,
`"nomana"`, `"taxi"`, ... — computed from `IsUsableAction`/`IsActionInRange`/
`UnitOnTaxi`. `"taxi"` covers "unusable because you're on a flight or
otherwise out of normal control," desaturating the whole bar rather than
graying out one button at a time.

## Artwork & desaturation (`elements/artwork.lua`)

Draws the bars' own background art, and separately desaturates icons based
on `usableState` (see above) — kept in its own file since it's purely visual
and has no button-click logic of its own.
