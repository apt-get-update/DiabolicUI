---
title: "Modules & Widgets"
weight: 3
---

# Modules & Widgets

## Anatomy of a module

A module file starts by fetching (or creating) its module object, then
defines `OnInit`/`OnEnable`:

```lua
local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: LootFrame")
local L = Engine:GetLocale()
local C = Engine:GetDB("Data: Colors")

Module.OnInit = function(self)
    self.config = self:GetDB("Blizzard").loot
    self.db = self:GetConfig("LootFrame")
end

Module.OnEnable = function(self)
    if (not self.db.enableSkin) then
        return
    end
    self:CreateWindow()
    ...
end
```

- `OnInit` should be side-effect-light: fetch config/db references, nothing
  that depends on other modules being enabled yet.
- `OnEnable` is where frames actually get created, events get registered,
  and other modules can safely be reached via `Engine:GetModule("X")` — see
  [module lifecycle ordering]({{< relref "engine-architecture#module-lifecycle-ordering" >}}).

Modules spanning multiple files (e.g. `modules/unitframes/`) call
`Engine:NewModule` once, in one file, and every other file in that module
does `local Module = Engine:GetModule("UnitFrames")` to add to it.

## Widgets

A **widget** is a self-contained sub-component of a module — a single
action bar, a single floating button — that still wants its own
`OnEnable`-style entry point without being a whole separate module:

```lua
-- modules/actionbars/elements/floaters.lua
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Floaters")

BarWidget.OnEnable = function(self)
    ...
    self.TaxiBar, self.TaxiExitButton = self:SpawnTaxiExitButton()
end
```

`Module:SetWidget(name)` creates (or returns) a named widget object scoped
to that module; `Module:GetWidget(name)` fetches one from elsewhere. Widgets
are how a big module like `ActionBars` is split across many files
(`elements/floaters.lua`, `elements/artwork.lua`, ...) without each one being
its own top-level module with its own independent lifecycle.

## Opting out: `SetIncompatible`

A module can bail out entirely when a known-conflicting addon is present,
without any manual checks inside its own `OnInit`/`OnEnable`:

```lua
local Module = Engine:NewModule("ChatBubbles")
Module:SetIncompatible("NiceBubbles")
```

Both `Init` and `Enable` (the engine-level dispatch functions, not the
module's own `OnInit`/`OnEnable`) check `self:IsIncompatible()` first and
return immediately if it's true — the module's `OnInit`/`OnEnable` never run
at all, as if the module didn't exist. `modules/chat/*.lua` is the clearest
example of the pattern in the wild: `ChatWindows` bails on
`"Prat-3.0"`, `ChatBubbles` on `"NiceBubbles"`, `ChatFilters` on
`"gUI4_Chat"` — each yielding to a dedicated standalone addon that does the
same job, rather than fighting it. `modules/nameplates/nameplates.lua` does
the same for half a dozen other nameplate addons.

`Engine:SetDependency`/`self:DependencyFailed()` is the mirror-image
mechanism for a *required* dependency instead of a conflicting one, checked
the same way.

## Modules vs. Handlers, one more time

If you're adding a new **feature**, it's a module. If you're adding
**reusable behavior that several unit-like frames need** (a health bar, a
portrait, a name string), it's a handler element — see
[Unit Frame Elements]({{< relref "unitframe-elements" >}}) for that pattern
in depth.
