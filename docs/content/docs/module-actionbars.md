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
    ├── specswitch.lua         # talent specialization switch on top of the skull, and each spec's commands
    ├── floaters.lua           # stance bar toggle, vehicle/taxi exit buttons
    ├── keybinds.lua           # keybind text overlay on buttons
    ├── menu.lua               # the Micro Menu (main menu button row), online friends and guild on its social button
    ├── pet.lua                # pet action bar
    ├── reputation.lua         # reputation/XP-adjacent bar bits
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

Not part of this module folder, but the handler every button on every bar
is built from. The bars use three button types: `"action"` (the action
bars), `"pet"` and `"stance"`. `Button:UpdateUsable()` colors a button's
icon by a `usableState` string, computed from `IsUsableAction` and the range
check, in this order:

| State | When | Icon |
|---|---|---|
| `"taxi"` | the player is dead or a ghost | desaturated |
| `"mana"` | not enough mana (`IsUsableAction` also reports it as not usable, so this is checked first) | blue tint |
| `"unusable"` | not usable for any other reason | darkened |
| `"range"` | the target is out of range | red tint |
| `"usable"` | everything else | normal |

A button is only recolored when its state changes, except for the
`"forced"` refresh the handler sends once, a second after login: the
client can fail to desaturate icons that early.

## Artwork & desaturation (`elements/artwork.lua`)

Draws the bars' own background art, and separately desaturates icons based
on `usableState` (see above) — kept in its own file since it's purely visual
and has no button-click logic of its own.
